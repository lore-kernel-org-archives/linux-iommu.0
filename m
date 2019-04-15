From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 10/18] iommu/vt-d: Add custom allocator for IOASID
Date: Mon, 15 Apr 2019 14:37:11 -0600
Message-ID: <20190415143711.13c29308@x1.home>
References: <1554767973-30125-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1554767973-30125-11-git-send-email-jacob.jun.pan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1554767973-30125-11-git-send-email-jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: "Tian, Kevin" <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Raj Ashok <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Andriy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon,  8 Apr 2019 16:59:25 -0700
Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:

> When VT-d driver runs in the guest, PASID allocation must be
> performed via virtual command interface. This patch register a
> custom IOASID allocator which takes precedence over the default
> IDR based allocator. The resulting IOASID allocation will always
> come from the host. This ensures that PASID namespace is system-
> wide.
> 
> Signed-off-by: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Signed-off-by: Liu, Yi L <yi.l.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> ---
>  drivers/iommu/intel-iommu.c | 50 +++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/intel-iommu.h |  1 +
>  2 files changed, 51 insertions(+)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 28cb713..a38d774 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -4820,6 +4820,42 @@ static int __init platform_optin_force_iommu(void)
>  	return 1;
>  }
>  
> +static ioasid_t intel_ioasid_alloc(ioasid_t min, ioasid_t max, void *data)
> +{
> +	struct intel_iommu *iommu = data;
> +	ioasid_t ioasid;
> +
> +	if (vcmd_alloc_pasid(iommu, &ioasid))
> +		return INVALID_IOASID;
> +	return ioasid;

How does this honor min/max?

> +}
> +
> +static int intel_ioasid_free(ioasid_t ioasid, void *data)
> +{
> +	struct iommu_pasid_alloc_info *svm;
> +	struct intel_iommu *iommu = data;
> +
> +	if (!iommu || !cap_caching_mode(iommu->cap))
> +		return -EINVAL;
> +	/*
> +	 * Sanity check the ioasid owner is done at upper layer, e.g. VFIO
> +	 * We can only free the PASID when all the devices are unbond.
> +	 */
> +	svm = ioasid_find(NULL, ioasid, NULL);
> +	if (!svm) {
> +		pr_warn("Freeing unbond IOASID %d\n", ioasid);
> +		return -EBUSY;
> +	}
> +	vcmd_free_pasid(iommu, ioasid);
> +
> +	return 0;
> +}
> +
> +static struct ioasid_allocator intel_iommu_ioasid_allocator = {
> +	.alloc = intel_ioasid_alloc,
> +	.free = intel_ioasid_free,
> +};
> +
>  int __init intel_iommu_init(void)
>  {
>  	int ret = -ENODEV;
> @@ -4921,6 +4957,20 @@ int __init intel_iommu_init(void)
>  				       "%s", iommu->name);
>  		iommu_device_set_ops(&iommu->iommu, &intel_iommu_ops);
>  		iommu_device_register(&iommu->iommu);
> +		if (cap_caching_mode(iommu->cap) && sm_supported(iommu)) {
> +			/*
> +			 * Register a custom ASID allocator if we are running
> +			 * in a guest, the purpose is to have a system wide PASID
> +			 * namespace among all PASID users.
> +			 * Note that only one vIOMMU in each guest is supported.

Why one vIOMMU per guest?  This would prevent guests with multiple PCI
domains aiui.

> +			 */
> +			intel_iommu_ioasid_allocator.pdata = (void *)iommu;
> +			ret = ioasid_set_allocator(&intel_iommu_ioasid_allocator);
> +			if (ret == -EBUSY) {
> +				pr_info("Custom IOASID allocator already registered\n");
> +				break;
> +			}
> +		}
>  	}
>  
>  	bus_set_iommu(&pci_bus_type, &intel_iommu_ops);
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index b29c85c..bc09d80 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -31,6 +31,7 @@
>  #include <linux/iommu.h>
>  #include <linux/io-64-nonatomic-lo-hi.h>
>  #include <linux/dmar.h>
> +#include <linux/ioasid.h>
>  
>  #include <asm/cacheflush.h>
>  #include <asm/iommu.h>
