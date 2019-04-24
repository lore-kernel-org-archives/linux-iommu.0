From: Auger Eric <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2 09/19] iommu/vt-d: Enlightened PASID allocation
Date: Wed, 24 Apr 2019 19:27:52 +0200
Message-ID: <143adac1-d58b-dde6-593b-74ea71da73c8@redhat.com>
References: <1556062279-64135-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1556062279-64135-10-git-send-email-jacob.jun.pan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1556062279-64135-10-git-send-email-jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
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
To: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Cc: "Tian, Kevin" <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Raj Ashok <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Andriy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Jacob,

On 4/24/19 1:31 AM, Jacob Pan wrote:
> From: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> 
> If Intel IOMMU runs in caching mode, a.k.a. virtual IOMMU, the
> IOMMU driver should rely on the emulation software to allocate
> and free PASID IDs.
Do we make the decision depending on the CM or depending on the VCCAP_REG?

VCCAP_REG description says:

If Set, software must use Virtual Command Register interface to
allocate and free PASIDs.

 The Intel vt-d spec revision 3.0 defines a
> register set to support this. This includes a capability register,
> a virtual command register and a virtual response register. Refer
> to section 10.4.42, 10.4.43, 10.4.44 for more information.
> 
> This patch adds the enlightened PASID allocation/free interfaces
For mu curiosity why is it called "enlightened"?
> via the virtual command register.
> 
> Cc: Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Cc: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Cc: Kevin Tian <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Liu Yi L <yi.l.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> ---
>  drivers/iommu/intel-pasid.c | 70 +++++++++++++++++++++++++++++++++++++++++++++
>  drivers/iommu/intel-pasid.h | 13 ++++++++-
>  include/linux/intel-iommu.h |  2 ++
>  3 files changed, 84 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel-pasid.c b/drivers/iommu/intel-pasid.c
> index 03b12d2..5b1d3be 100644
> --- a/drivers/iommu/intel-pasid.c
> +++ b/drivers/iommu/intel-pasid.c
> @@ -63,6 +63,76 @@ void *intel_pasid_lookup_id(int pasid)
>  	return p;
>  }
>  
> +int vcmd_alloc_pasid(struct intel_iommu *iommu, unsigned int *pasid)
> +{
> +	u64 res;
> +	u64 cap;
> +	u8 err_code;
> +	unsigned long flags;
> +	int ret = 0;
> +
> +	if (!ecap_vcs(iommu->ecap)) {
> +		pr_warn("IOMMU: %s: Hardware doesn't support virtual command\n",
> +			iommu->name);
nit: other pr_* messages don't have the "IOMMU: %s:" prefix.
> +		return -ENODEV;
> +	}
> +
> +	cap = dmar_readq(iommu->reg + DMAR_VCCAP_REG);
> +	if (!(cap & DMA_VCS_PAS)) {
> +		pr_warn("IOMMU: %s: Emulation software doesn't support PASID allocation\n",
> +			iommu->name);
> +		return -ENODEV;
> +	}
> +
> +	raw_spin_lock_irqsave(&iommu->register_lock, flags);
> +	dmar_writeq(iommu->reg + DMAR_VCMD_REG, VCMD_CMD_ALLOC);
> +	IOMMU_WAIT_OP(iommu, DMAR_VCRSP_REG, dmar_readq,
> +		      !(res & VCMD_VRSP_IP), res);
> +	raw_spin_unlock_irqrestore(&iommu->register_lock, flags);
> +
> +	err_code = VCMD_VRSP_EC(res);
> +	switch (err_code) {
> +	case VCMD_VRSP_EC_SUCCESS:
> +		*pasid = VCMD_VRSP_RESULE(res);
> +		break;
> +	case VCMD_VRSP_EC_UNAVAIL:
> +		pr_info("IOMMU: %s: No PASID available\n", iommu->name);
> +		ret = -ENOMEM;
> +		break;
> +	default:
> +		ret = -ENODEV;
> +		pr_warn("IOMMU: %s: Unkonwn error code %d\n",
unknown
> +			iommu->name, err_code);
> +	}
> +
> +	return ret;
> +}
> +
> +void vcmd_free_pasid(struct intel_iommu *iommu, unsigned int pasid)
> +{
> +	u64 res;
> +	u8 err_code;
> +	unsigned long flags;
Shall we check as well the cap is set?
> +
> +	raw_spin_lock_irqsave(&iommu->register_lock, flags);
> +	dmar_writeq(iommu->reg + DMAR_VCMD_REG, (pasid << 8) | VCMD_CMD_FREE);
> +	IOMMU_WAIT_OP(iommu, DMAR_VCRSP_REG, dmar_readq,
> +		      !(res & VCMD_VRSP_IP), res);
> +	raw_spin_unlock_irqrestore(&iommu->register_lock, flags);
> +
> +	err_code = VCMD_VRSP_EC(res);
> +	switch (err_code) {
> +	case VCMD_VRSP_EC_SUCCESS:
> +		break;
> +	case VCMD_VRSP_EC_INVAL:
> +		pr_info("IOMMU: %s: Invalid PASID\n", iommu->name);
> +		break;
> +	default:
> +		pr_warn("IOMMU: %s: Unkonwn error code %d\n",
unknown
> +			iommu->name, err_code);
> +	}
> +}
> +
>  /*
>   * Per device pasid table management:
>   */
> diff --git a/drivers/iommu/intel-pasid.h b/drivers/iommu/intel-pasid.h
> index 23537b3..0999dfe 100644
> --- a/drivers/iommu/intel-pasid.h
> +++ b/drivers/iommu/intel-pasid.h
> @@ -19,6 +19,16 @@
>  #define PASID_PDE_SHIFT			6
>  #define MAX_NR_PASID_BITS		20
>  
> +/* Virtual command interface for enlightened pasid management. */
> +#define VCMD_CMD_ALLOC			0x1
> +#define VCMD_CMD_FREE			0x2
> +#define VCMD_VRSP_IP			0x1
> +#define VCMD_VRSP_EC(e)			(((e) >> 1) & 0x3)
s/EC/SC? for Status Code and below
> +#define VCMD_VRSP_EC_SUCCESS		0
> +#define VCMD_VRSP_EC_UNAVAIL		1
nit: _NO_VALID_PASID
> +#define VCMD_VRSP_EC_INVAL		1
nit: _INVALID_PASID
> +#define VCMD_VRSP_RESULE(e)		(((e) >> 8) & 0xfffff)
nit: s/RESULE/RSLT?
> +
>  /*
>   * Domain ID reserved for pasid entries programmed for first-level
>   * only and pass-through transfer modes.
> @@ -69,5 +79,6 @@ int intel_pasid_setup_pass_through(struct intel_iommu *iommu,
>  				   struct device *dev, int pasid);
>  void intel_pasid_tear_down_entry(struct intel_iommu *iommu,
>  				 struct device *dev, int pasid);
> -
> +int vcmd_alloc_pasid(struct intel_iommu *iommu, unsigned int *pasid);
> +void vcmd_free_pasid(struct intel_iommu *iommu, unsigned int pasid);
>  #endif /* __INTEL_PASID_H */
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index 6925a18..bff907b 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -173,6 +173,7 @@
>  #define ecap_smpwc(e)		(((e) >> 48) & 0x1)
>  #define ecap_flts(e)		(((e) >> 47) & 0x1)
>  #define ecap_slts(e)		(((e) >> 46) & 0x1)
> +#define ecap_vcs(e)		(((e) >> 44) & 0x1)
>  #define ecap_smts(e)		(((e) >> 43) & 0x1)
>  #define ecap_dit(e)		((e >> 41) & 0x1)
>  #define ecap_pasid(e)		((e >> 40) & 0x1)
> @@ -289,6 +290,7 @@
>  
>  /* PRS_REG */
>  #define DMA_PRS_PPR	((u32)1)
> +#define DMA_VCS_PAS	((u64)1)
>  
>  #define IOMMU_WAIT_OP(iommu, offset, op, cond, sts)			\
>  do {									\
> 

Thanks

Eric
