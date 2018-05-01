From: "Liu, Yi L" <yi.l.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH 7/9] iommu/vt-d: Calculate PTS value
Date: Tue, 1 May 2018 09:22:31 +0000
Message-ID: <A2975661238FB949B60364EF0F2C257439BE753A@SHSMSX104.ccr.corp.intel.com>
References: <1523934202-21669-1-git-send-email-baolu.lu@linux.intel.com>
	<1523934202-21669-8-git-send-email-baolu.lu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1523934202-21669-8-git-send-email-baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
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
To: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: "Raj, Ashok" <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Kumar,
	Sanjay K" <sanjay.k.kumar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Sun, Yi Y" <yi.y.sun-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Pan,
	Jacob jun" <jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

> From: Lu Baolu [mailto:baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org]
> Sent: Tuesday, April 17, 2018 11:03 AM
> 
> Calculate PTS (PASID Table Size) value for the extended
> context entry from the real size of the PASID table for
> a domain.
> 
> Cc: Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Cc: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Cc: Kevin Tian <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Cc: Liu Yi L <yi.l.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

Looks good to me.
Reviewed-by: Liu, Yi L <yi.l.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

Regards,
Yi Liu
> ---
>  drivers/iommu/intel-iommu.c | 22 ++++++++--------------
>  1 file changed, 8 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 99c643b..d4f9cea 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -5146,22 +5146,16 @@ static void intel_iommu_put_resv_regions(struct device
> *dev,
> 
>  #ifdef CONFIG_INTEL_IOMMU_SVM
>  #define MAX_NR_PASID_BITS (20)
> -static inline unsigned long intel_iommu_get_pts(struct intel_iommu *iommu)
> +static inline unsigned long intel_iommu_get_pts(struct dmar_domain *domain)
>  {
> -	/*
> -	 * Convert ecap_pss to extend context entry pts encoding, also
> -	 * respect the soft pasid_max value set by the iommu.
> -	 * - number of PASID bits = ecap_pss + 1
> -	 * - number of PASID table entries = 2^(pts + 5)
> -	 * Therefore, pts = ecap_pss - 4
> -	 * e.g. KBL ecap_pss = 0x13, PASID has 20 bits, pts = 15
> -	 */
> -	if (ecap_pss(iommu->ecap) < 5)
> +	int pts;
> +
> +	pts = find_first_bit((unsigned long *)&domain->max_pasid,
> +			     MAX_NR_PASID_BITS);
> +	if (pts < 5)
>  		return 0;
> 
> -	/* pasid_max is encoded as actual number of entries not the bits */
> -	return find_first_bit((unsigned long *)&iommu->pasid_max,
> -			MAX_NR_PASID_BITS) - 5;
> +	return pts - 5;
>  }
> 
>  int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct intel_svm_dev
> *sdev)
> @@ -5198,7 +5192,7 @@ int intel_iommu_enable_pasid(struct intel_iommu
> *iommu, struct intel_svm_dev *sd
>  		if (iommu->pasid_state_table)
>  			context[1].hi = (u64)virt_to_phys(iommu-
> >pasid_state_table);
>  		context[1].lo = (u64)virt_to_phys(iommu->pasid_table) |
> -			intel_iommu_get_pts(iommu);
> +			intel_iommu_get_pts(domain);
> 
>  		wmb();
>  		/* CONTEXT_TT_MULTI_LEVEL and CONTEXT_TT_DEV_IOTLB are
> both
> --
> 2.7.4
