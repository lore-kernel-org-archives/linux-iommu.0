From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [RFC] iommu: qcom-iommu-v0 IOMMU
Date: Thu, 10 Jul 2014 14:53:48 -0700
Message-ID: <20140710215348.GQ20486@codeaurora.org>
References: <1405020077-16148-1-git-send-email-robdclark@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1405020077-16148-1-git-send-email-robdclark@gmail.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Rob Clark <robdclark@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

On 07/10, Rob Clark wrote:
> So, in it's current form, this is superficially a copy of msm_iommu
> plus DT conversion.  But the pre-DT IOMMU driver had fairly different
> structure.. ie. psuedo root device, with IOMMU devices hanging off
> that, and context devices hanging off that.  The context devices were
> what the client device would attach (which was also somewhat non-
> standard.. see msm_iommu_get_ctx()).
> 
> I couldn't really think of some sane way to refactor this and add DT
> while at the same time keeping compatibility with the old pre-DT msm
> stuff.  So I copied to a new driver.
> 
> It was pointed out that nothing upstream actually *used* the msm_iommu
> driver.  So if no one objects to dropping pre-DT support, then I could
> do some patch rejuggling + sed to make this replace the old driver
> instead.

+1

> +
> +// TODO any good reason for global lock vs per-iommu lock?
> +DEFINE_SPINLOCK(qcom_iommu_lock);

static?

> +static LIST_HEAD(qcom_iommu_devices);
> +
> +/* Note that a single iommu_domain can, for devices sitting behind
> + * more than one IOMMU (ie. one per AXI interface) will have more
> + * than one iommu in the iommu_list.  But all are programmed to
> + * point at the same pagetables so from client device perspective
> + * they act as a single IOMMU.
> + */
> +struct qcom_domain_priv {
> +	unsigned long *pgtable;
> +	struct list_head iommu_list;  /* list of attached 'struct qcom_iommu' */
> +};
> +
> +static int __enable_clocks(struct qcom_iommu *iommu)
> +{
> +	int ret;
> +
> +	ret = clk_prepare_enable(iommu->pclk);

Looks like __enable_clocks() is called from within a spinlock
sometimes. Please move the prepare call outside of any atomic
sections and also enable CONFIG_PROVE_LOCKING and/or
CONFIG_DEBUG_ATOMIC_SLEEP to find such problems.

> +	if (ret)
> +		goto fail;
> +
> +	if (iommu->clk) {
> +		ret = clk_prepare_enable(iommu->clk);
> +		if (ret)
> +			clk_disable_unprepare(iommu->pclk);
> +	}
> +fail:
> +	return ret;
> +}
> +

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
