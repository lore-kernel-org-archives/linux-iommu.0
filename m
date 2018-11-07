From: "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH v4 05/12] iommu/vt-d: Reserve a domain id for FL and PT
 modes
Date: Wed, 7 Nov 2018 06:55:38 +0000
Message-ID: <A2975661238FB949B60364EF0F2C257439D5FAE7@SHSMSX104.ccr.corp.intel.com>
References: <20181105053151.7173-1-baolu.lu@linux.intel.com>
 <20181105053151.7173-6-baolu.lu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181105053151.7173-6-baolu.lu@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>
Cc: "Raj, Ashok" <ashok.raj@intel.com>, "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>, "Pan, Jacob jun" <jacob.jun.pan@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>, "peterx@redhat.com" <peterx@redhat.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

Hi Baolu,

> From: Lu Baolu [mailto:baolu.lu@linux.intel.com]
> Sent: Monday, November 5, 2018 1:32 PM
> Subject: [PATCH v4 05/12] iommu/vt-d: Reserve a domain id for FL and PT modes
> 
> Vt-d spec rev3.0 (section 6.2.3.1) requires that each pasid
> entry for first-level or pass-through translation should be
> programmed with a domain id different from those used for
> second-level or nested translation. It is recommended that
> software could use a same domain id for all first-only and
> pass-through translations.
> 
> This reserves a domain id for first-level and pass-through
> translations.
> 
> Cc: Ashok Raj <ashok.raj@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Liu Yi L <yi.l.liu@intel.com>
> Cc: Sanjay Kumar <sanjay.k.kumar@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel-iommu.c | 10 ++++++++++
>  drivers/iommu/intel-pasid.h |  6 ++++++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 9331240c70b8..2f7455ee4e7a 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -1618,6 +1618,16 @@ static int iommu_init_domains(struct intel_iommu
> *iommu)
>  	 */
>  	set_bit(0, iommu->domain_ids);
> 
> +	/*
> +	 * Vt-d spec rev3.0 (section 6.2.3.1) requires that each pasid
> +	 * entry for first-level or pass-through translation modes should
> +	 * be programmed with a domain id different from those used for
> +	 * second-level or nested translation. We reserve a domain id for
> +	 * this purpose.
> +	 */
> +	if (sm_supported(iommu))
> +		set_bit(FLPT_DEFAULT_DID, iommu->domain_ids);

"FLPT_DEFAULT_DID" looks very likely for first level translation. How about
"PT_FL_DEFAULT_DID"?

>  	return 0;
>  }
> 
> diff --git a/drivers/iommu/intel-pasid.h b/drivers/iommu/intel-pasid.h
> index 12f480c2bb8b..03c1612d173c 100644
> --- a/drivers/iommu/intel-pasid.h
> +++ b/drivers/iommu/intel-pasid.h
> @@ -17,6 +17,12 @@
>  #define PDE_PFN_MASK			PAGE_MASK
>  #define PASID_PDE_SHIFT			6
> 
> +/*
> + * Domain ID reserved for pasid entries programmed for first-level
> + * only and pass-through transfer modes.
> + */
> +#define FLPT_DEFAULT_DID		1

Would be helpful to elaborate why DID 1 is selected in the patch
description.

Regards,
Yi Liu
