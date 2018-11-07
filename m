From: "Liu, Yi L" <yi.l.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH v4 10/12] iommu/vt-d: Add first level page table interface
Date: Wed, 7 Nov 2018 07:34:47 +0000
Message-ID: <A2975661238FB949B60364EF0F2C257439D5FB43@SHSMSX104.ccr.corp.intel.com>
References: <20181105053151.7173-1-baolu.lu@linux.intel.com>
	<20181105053151.7173-11-baolu.lu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20181105053151.7173-11-baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
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
To: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: "Tian, Kevin" <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Raj, Ashok" <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>, "Kumar,
	Sanjay K" <sanjay.k.kumar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Sun, Yi Y" <yi.y.sun-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Pan,
	Jacob jun" <jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Baolu,

> From: Lu Baolu [mailto:baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org]
> Sent: Monday, November 5, 2018 1:32 PM
> Subject: [PATCH v4 10/12] iommu/vt-d: Add first level page table interface
> 
> This adds an interface to setup the PASID entries for first

This patch adds interface to setup the PASID entries for first. :)

> level page table translation.
> 
> Cc: Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Cc: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Cc: Kevin Tian <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Cc: Liu Yi L <yi.l.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Sanjay Kumar <sanjay.k.kumar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Reviewed-by: Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/iommu/intel-pasid.c | 81 +++++++++++++++++++++++++++++++++++++
>  drivers/iommu/intel-pasid.h | 11 +++++
>  include/linux/intel-iommu.h |  1 +
>  3 files changed, 93 insertions(+)
> 
> diff --git a/drivers/iommu/intel-pasid.c b/drivers/iommu/intel-pasid.c
> index 69530317c323..d8ca1e6a8e5e 100644
> --- a/drivers/iommu/intel-pasid.c
> +++ b/drivers/iommu/intel-pasid.c
> @@ -10,6 +10,7 @@
>  #define pr_fmt(fmt)	"DMAR: " fmt
> 
>  #include <linux/bitops.h>
> +#include <linux/cpufeature.h>
>  #include <linux/dmar.h>
>  #include <linux/intel-iommu.h>
>  #include <linux/iommu.h>
> @@ -388,6 +389,26 @@ static inline void pasid_set_page_snoop(struct pasid_entry
> *pe, bool value)
>  	pasid_set_bits(&pe->val[1], 1 << 23, value);
>  }
> 
> +/*
> + * Setup the First Level Page table Pointer field (Bit 140~191)
> + * of a scalable mode PASID entry.
> + */
> +static inline void
> +pasid_set_flptr(struct pasid_entry *pe, u64 value)
> +{
> +	pasid_set_bits(&pe->val[2], VTD_PAGE_MASK, value);
> +}
> +
> +/*
> + * Setup the First Level Paging Mode field (Bit 130~131) of a
> + * scalable mode PASID entry.
> + */
> +static inline void
> +pasid_set_flpm(struct pasid_entry *pe, u64 value)
> +{
> +	pasid_set_bits(&pe->val[2], GENMASK_ULL(3, 2), value << 2);
> +}
> +
>  static void
>  pasid_cache_invalidation_with_pasid(struct intel_iommu *iommu,
>  				    u16 did, int pasid)
> @@ -458,6 +479,66 @@ void intel_pasid_tear_down_entry(struct intel_iommu
> *iommu,
>  		devtlb_invalidation_with_pasid(iommu, dev, pasid);
>  }
> 
> +/*
> + * Set up the scalable mode pasid table entry for first only
> + * translation type.
> + */
> +int intel_pasid_setup_first_level(struct intel_iommu *iommu,
> +				  struct device *dev, pgd_t *pgd,
> +				  int pasid, int flags)
> +{
> +	u16 did = FLPT_DEFAULT_DID;
> +	struct pasid_entry *pte;

aha, same comment with previous patch. may be better us pt_entry
or pasid_entry.

Regards,
Yi Liu
