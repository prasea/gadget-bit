class Admin::ImagesController < AdminController
  def destroy
    @product = Product.find(params[:product_id])
    @image = @product.images.find(params[:id])
    @image.purge
    redirect_to edit_admin_product_path(@product), notice: 'Image successfully deleted'
  end
end
