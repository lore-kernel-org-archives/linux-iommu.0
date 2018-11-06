From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v4 6/8] vfio/mdev: Add iommu place holders in mdev_device
Date: Tue, 6 Nov 2018 16:53:56 -0700
Message-ID: <20181106165356.44b59ec3@w520.home>
References: <20181105073408.21815-1-baolu.lu@linux.intel.com>
	<20181105073408.21815-7-baolu.lu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20181105073408.21815-7-baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, tiwei.bie-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>, sanjay.k.kumar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, yi.y.sun-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kirti Wankhede <kwankhede-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon,  5 Nov 2018 15:34:06 +0800
Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:

> A parent device might create different types of mediated
> devices. For example, a mediated device could be created
> by the parent device with full isolation and protection
> provided by the IOMMU. One usage case could be found on
> Intel platforms where a mediated device is an assignable
> subset of a PCI, the DMA requests on behalf of it are all
> tagged with a PASID. Since IOMMU supports PASID-granular
> translations (scalable mode in vt-d 3.0), this mediated
> device could be individually protected and isolated by an
> IOMMU.
> 
> This patch adds two new members in struct mdev_device:
> * iommu_device
>   - This, if set, indicates that the mediated device could
>     be fully isolated and protected by IOMMU via attaching
>     an iommu domain to this device. If empty, it indicates
>     using vendor defined isolation.
> 
> * iommu_domain
>   - This is a place holder for an iommu domain. A domain
>     could be store here for later use once it has been
>     attached to the iommu_device of this mdev.
> 
> Below helpers are added to set and get above iommu device
> and iommu domain pointers.
> 
> * mdev_set/get_iommu_device(dev, iommu_device)
>   - Set or get the iommu device which represents this mdev
>     in IOMMU's device scope. Drivers don't need to set the
>     iommu device if it uses vendor defined isolation.
> 
> * mdev_set/get_iommu_domain(domain)
>   - A iommu domain which has been attached to the iommu
>     device in order to protect and isolate the mediated
>     device will be kept in the mdev data structure and
>     could be retrieved later.
> 
> Cc: Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Cc: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Cc: Kevin Tian <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Cc: Liu Yi L <yi.l.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Suggested-by: Kevin Tian <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Suggested-by: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> Signed-off-by: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> ---
>  drivers/vfio/mdev/mdev_core.c    | 36 ++++++++++++++++++++++++++++++++
>  drivers/vfio/mdev/mdev_private.h |  2 ++
>  include/linux/mdev.h             | 23 ++++++++++++++++++++
>  3 files changed, 61 insertions(+)
> 
> diff --git a/drivers/vfio/mdev/mdev_core.c b/drivers/vfio/mdev/mdev_core.c
> index 0212f0ee8aea..5119809225c5 100644
> --- a/drivers/vfio/mdev/mdev_core.c
> +++ b/drivers/vfio/mdev/mdev_core.c
> @@ -390,6 +390,42 @@ int mdev_device_remove(struct device *dev, bool force_remove)
>  	return 0;
>  }
>  
> +int mdev_set_iommu_device(struct device *dev, struct device *iommu_device)
> +{
> +	struct mdev_device *mdev = to_mdev_device(dev);
> +
> +	mdev->iommu_device = iommu_device;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(mdev_set_iommu_device);
> +
> +struct device *mdev_get_iommu_device(struct device *dev)
> +{
> +	struct mdev_device *mdev = to_mdev_device(dev);
> +
> +	return mdev->iommu_device;
> +}
> +EXPORT_SYMBOL(mdev_get_iommu_device);
> +
> +int mdev_set_iommu_domain(struct device *dev, void *domain)
> +{
> +	struct mdev_device *mdev = to_mdev_device(dev);
> +
> +	mdev->iommu_domain = domain;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(mdev_set_iommu_domain);
> +
> +void *mdev_get_iommu_domain(struct device *dev)
> +{
> +	struct mdev_device *mdev = to_mdev_device(dev);
> +
> +	return mdev->iommu_domain;
> +}
> +EXPORT_SYMBOL(mdev_get_iommu_domain);
> +
>  static int __init mdev_init(void)
>  {
>  	return mdev_bus_register();
> diff --git a/drivers/vfio/mdev/mdev_private.h b/drivers/vfio/mdev/mdev_private.h
> index b5819b7d7ef7..c01518068e84 100644
> --- a/drivers/vfio/mdev/mdev_private.h
> +++ b/drivers/vfio/mdev/mdev_private.h
> @@ -34,6 +34,8 @@ struct mdev_device {
>  	struct list_head next;
>  	struct kobject *type_kobj;
>  	bool active;
> +	struct device *iommu_device;
> +	void *iommu_domain;
>  };
>  
>  #define to_mdev_device(dev)	container_of(dev, struct mdev_device, dev)
> diff --git a/include/linux/mdev.h b/include/linux/mdev.h
> index b6e048e1045f..c46777d3e568 100644
> --- a/include/linux/mdev.h
> +++ b/include/linux/mdev.h
> @@ -14,6 +14,29 @@
>  #define MDEV_H
>  
>  struct mdev_device;
> +struct iommu_domain;
> +
> +/*
> + * Called by the parent device driver to set the PCI device which represents

s/PCI //

There is no requirement or expectation that the device is PCI.

> + * this mdev in iommu protection scope. By default, the iommu device is NULL,
> + * that indicates using vendor defined isolation.
> + *
> + * @dev: the mediated device that iommu will isolate.
> + * @iommu_device: a pci device which represents the iommu for @dev.
> + *
> + * Return 0 for success, otherwise negative error value.
> + */
> +int mdev_set_iommu_device(struct device *dev, struct device *iommu_device);
> +
> +struct device *mdev_get_iommu_device(struct device *dev);
> +
> +/*
> + * Called by vfio iommu modules to save the iommu domain after a domain being
> + * attached to the mediated device.
> + */
> +int mdev_set_iommu_domain(struct device *dev, void *domain);
> +
> +void *mdev_get_iommu_domain(struct device *dev);

I can't say I really understand the purpose of this, the cover letter
indicates this is a placeholder, should we add it separately when we
have a requirement for it?  Thanks,

Alex
