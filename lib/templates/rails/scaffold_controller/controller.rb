<% if namespaced? -%>
require_dependency "<%= namespaced_path %>/application_controller"
<% end -%>
<% module_namespacing do -%>
class <%= controller_class_name %>Controller < ApplicationController
  before_action :set_<%= singular_table_name %>, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  # GET <%= route_url %>
  def index
    @<%= plural_table_name %> = <%= orm_class.all(class_name) %>
  end
  # GET <%= route_url %>/1
  def show
  end

  # GET <%= route_url %>/new
  def new
    @<%= singular_table_name %> = <%= orm_class.build(class_name) %>
  end

  # GET <%= route_url %>/1/edit
  def edit
  end

  # POST <%= route_url %>
  def create
    <%- if attributes_names.include? 'user_id' -%>
      @<%= singular_table_name %> = current_user.<%= singular_table_name%>s.build(<%=singular_table_name%>_params)
    <%- else -%>
      @<%= singular_table_name %> = <%= orm_class.build(class_name, "#{singular_table_name}_params") %>
    <%- end -%>
    if @<%= orm_instance.save %>
      redirect_to <%= singular_table_name %>_path(@<%= singular_table_name %>, locale:I18n.locale), notice: t(".<%=singular_table_name%>_succes")
    else
      render :new
    end
  end
  # PATCH/PUT <%= route_url %>/1
  def update
    if @<%= orm_instance.update("#{singular_table_name}_params") %>
      redirect_to <%= singular_table_name %>_path(@<%= singular_table_name %>, locale:I18n.locale), notice: t(".<%=singular_table_name%>_updated")
    else
      render :edit
    end
  end
  # DELETE <%= route_url %>/1
  def destroy
    @<%= orm_instance.destroy %>
    redirect_to <%= index_helper %>_url(locale: I18n.locale), notice: t(".<%=singular_table_name%>_destroyed")
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_<%= singular_table_name %>
      @<%= singular_table_name %> = <%= orm_class.find(class_name, "params[:id]") %>
    end

    # Only allow a trusted parameter "white list" through.
    def <%= "#{singular_table_name}_params" %>
      <%- if attributes_names.empty? -%>
      params.fetch(:<%= singular_table_name %>, {})
      <%- else -%>
      <%- attributes_names.delete('user_id')-%>
      params.require(:<%= singular_table_name %>).permit(<%= attributes_names.map { |name| ":#{name}" }.join(', ') %>)
      <%- end -%>
    end
end
<% end -%>
