From: "Liu, Yi L" <yi.l.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [RFC PATCH 1/5] iommu: Add APIs for IOMMU PASID management
Date: Sat, 15 Dec 2018 22:38:26 +0000
Message-ID: <A2975661238FB949B60364EF0F2C257439D8E060@SHSMSX104.ccr.corp.intel.com>
References: <20181112064501.2290-1-baolu.lu@linux.intel.com>
	<20181112064501.2290-2-baolu.lu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20181112064501.2290-2-baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
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
To: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Kirti Wankhede <kwankhede-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "Tian, Kevin" <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Raj, Ashok" <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Bie, Tiwei" <tiwei.bie-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>, "Kumar,
	Sanjay K" <sanjay.k.kumar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Sun, Yi Y" <yi.y.sun-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Pan,
	Jacob jun" <jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

> From: Lu Baolu [mailto:baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org]
> Sent: Sunday, November 11, 2018 10:45 PM
> Subject: [RFC PATCH 1/5] iommu: Add APIs for IOMMU PASID management
> 
> This adds APIs for IOMMU drivers and device drivers to manage the PASIDs used for
> DMA transfer and translation. It bases on I/O ASID allocator for PASID namespace
> management and relies on vendor specific IOMMU drivers for paravirtual PASIDs.
> 
> Below APIs are added:
> 
> * iommu_pasid_init(pasid)
>   - Initialize a PASID consumer. The vendor specific IOMMU
>     drivers are able to set the PASID range imposed by IOMMU
>     hardware through a callback in iommu_ops.
> 
> * iommu_pasid_exit(pasid)
>   - The PASID consumer stops consuming any PASID.
> 
> * iommu_pasid_alloc(pasid, min, max, private, *ioasid)
>   - Allocate a PASID and associate a @private data with this
>     PASID. The PASID value is stored in @ioaisd if returning
>     success.
> 
> * iommu_pasid_free(pasid, ioasid)
>   - Free a PASID to the pool so that it could be consumed by
>     others.
> 
> This also adds below helpers to lookup or iterate PASID items associated with a
> consumer.
> 
> * iommu_pasid_for_each(pasid, func, data)
>   - Iterate PASID items of the consumer identified by @pasid,
>     and call @func() against each item. An error returned from
>     @func() will break the iteration.
> 
> * iommu_pasid_find(pasid, ioasid)
>   - Retrieve the private data associated with @ioasid.
> 
> Cc: Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Cc: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Cc: Kevin Tian <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Cc: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
> Signed-off-by: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> ---
>  drivers/iommu/Kconfig |  1 +
>  drivers/iommu/iommu.c | 89 +++++++++++++++++++++++++++++++++++++++++++
>  include/linux/iommu.h | 73 +++++++++++++++++++++++++++++++++++
>  3 files changed, 163 insertions(+)
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig index
> d9a25715650e..39f2bb76c7b8 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -1,6 +1,7 @@
>  # IOMMU_API always gets selected by whoever wants it.
>  config IOMMU_API
>  	bool
> +	select IOASID
> 
>  menuconfig IOMMU_SUPPORT
>  	bool "IOMMU Hardware Support"
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c index
> 0b7c96d1425e..570b244897bb 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2082,3 +2082,92 @@ void iommu_detach_device_aux(struct iommu_domain
> *domain, struct device *dev)
>  	}
>  }
>  EXPORT_SYMBOL_GPL(iommu_detach_device_aux);
> +
> +/*
> + * APIs for PASID used by IOMMU and the device drivers which depend
> + * on IOMMU.
> + */
> +struct iommu_pasid *iommu_pasid_init(struct bus_type *bus) {

I'm thinking about if using struct iommu_domain here is better
than struct bus_type. The major purpose is to pass iommu_ops
in it and route into iommu-sublayer. iommu_domain may be
better since some modules like vfio_iommu_type1 would use
iommu_domain more than bus type.

Thanks,
Yi Liu
