From: Auger Eric <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2 04/40] iommu/sva: Add a mm_exit callback for device
	drivers
Date: Wed, 5 Sep 2018 15:23:34 +0200
Message-ID: <d1dc28c4-7742-9c41-3f91-3fbcb8b13c1c@redhat.com>
References: <20180511190641.23008-1-jean-philippe.brucker@arm.com>
	<20180511190641.23008-5-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180511190641.23008-5-jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org
Cc: xieyisheng1-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, ilias.apalodimas-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, xuzaibo-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, rfranz-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, rgummal-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, liubo95-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, christian.koenig-5C7GfCeVMHo@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Jean-Philippe,

On 05/11/2018 09:06 PM, Jean-Philippe Brucker wrote:
> When an mm exits, devices that were bound to it must stop performing DMA
> on its PASID. Let device drivers register a callback to be notified on mm
> exit. Add the callback to the sva_param structure attached to struct
> device.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
> 
> ---
> v1->v2: use iommu_sva_device_init instead of a separate function
> ---
>  drivers/iommu/iommu-sva.c | 11 ++++++++++-
>  include/linux/iommu.h     |  9 +++++++--
>  2 files changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
> index 6ac679c48f3c..0700893c679d 100644
> --- a/drivers/iommu/iommu-sva.c
> +++ b/drivers/iommu/iommu-sva.c
> @@ -303,6 +303,7 @@ static void io_mm_detach_locked(struct iommu_bond *bond)
>   * @dev: the device
>   * @features: bitmask of features that need to be initialized
>   * @max_pasid: max PASID value supported by the device
> + * @mm_exit: callback to notify the device driver of an mm exiting
>   *
>   * Users of the bind()/unbind() API must call this function to initialize all
>   * features required for SVA.
> @@ -313,13 +314,20 @@ static void io_mm_detach_locked(struct iommu_bond *bond)
>   * description. Setting @max_pasid to a non-zero value smaller than this limit
>   * overrides it.
>   *
> + * If the driver intends to share process address spaces, it should pass a valid
> + * @mm_exit handler. Otherwise @mm_exit can be NULL.
I don't get case where mm_exit is allowed to be NULL.

Thanks

Eric
 After @mm_exit returns, the
> + * device must not issue any more transaction with the PASID given as argument.
> + * The handler gets an opaque pointer corresponding to the drvdata passed as
> + * argument of bind().
> + *
>   * The device should not be performing any DMA while this function is running,
>   * otherwise the behavior is undefined.
>   *
>   * Return 0 if initialization succeeded, or an error.
>   */
>  int iommu_sva_device_init(struct device *dev, unsigned long features,
> -			  unsigned int max_pasid)
> +			  unsigned int max_pasid,
> +			  iommu_mm_exit_handler_t mm_exit)
>  {
>  	int ret;
>  	struct iommu_sva_param *param;
> @@ -337,6 +345,7 @@ int iommu_sva_device_init(struct device *dev, unsigned long features,
>  
>  	param->features		= features;
>  	param->max_pasid	= max_pasid;
> +	param->mm_exit		= mm_exit;
>  	INIT_LIST_HEAD(&param->mm_list);
>  
>  	/*
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index d5f21719a5a0..439c8fffd836 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -61,6 +61,7 @@ struct iommu_fault_event;
>  typedef int (*iommu_fault_handler_t)(struct iommu_domain *,
>  			struct device *, unsigned long, int, void *);
>  typedef int (*iommu_dev_fault_handler_t)(struct iommu_fault_event *, void *);
> +typedef int (*iommu_mm_exit_handler_t)(struct device *dev, int pasid, void *);
>  
>  struct iommu_domain_geometry {
>  	dma_addr_t aperture_start; /* First address that can be mapped    */
> @@ -231,6 +232,7 @@ struct iommu_sva_param {
>  	unsigned int min_pasid;
>  	unsigned int max_pasid;
>  	struct list_head mm_list;
> +	iommu_mm_exit_handler_t mm_exit;
>  };
>  
>  /**
> @@ -980,17 +982,20 @@ static inline int iommu_sva_unbind_device(struct device *dev, int pasid)
>  
>  #ifdef CONFIG_IOMMU_SVA
>  extern int iommu_sva_device_init(struct device *dev, unsigned long features,
> -				 unsigned int max_pasid);
> +				 unsigned int max_pasid,
> +				 iommu_mm_exit_handler_t mm_exit);
>  extern int iommu_sva_device_shutdown(struct device *dev);
>  extern int __iommu_sva_bind_device(struct device *dev, struct mm_struct *mm,
>  				   int *pasid, unsigned long flags,
>  				   void *drvdata);
>  extern int __iommu_sva_unbind_device(struct device *dev, int pasid);
>  extern void __iommu_sva_unbind_dev_all(struct device *dev);
> +
>  #else /* CONFIG_IOMMU_SVA */
>  static inline int iommu_sva_device_init(struct device *dev,
>  					unsigned long features,
> -					unsigned int max_pasid)
> +					unsigned int max_pasid,
> +					iommu_mm_exit_handler_t mm_exit)
>  {
>  	return -ENODEV;
>  }
> 
