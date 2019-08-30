Return-Path: <SRS0=ODk1=W2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62802C3A59B
	for <iommu@archiver.kernel.org>; Fri, 30 Aug 2019 15:25:02 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3130621726
	for <iommu@archiver.kernel.org>; Fri, 30 Aug 2019 15:25:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3130621726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id F338E5CD6;
	Fri, 30 Aug 2019 15:25:01 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 6D9EA5C9F
	for <iommu@lists.linux-foundation.org>;
	Fri, 30 Aug 2019 15:23:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id D6BB9EC
	for <iommu@lists.linux-foundation.org>;
	Fri, 30 Aug 2019 15:23:16 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 53209344;
	Fri, 30 Aug 2019 08:23:16 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9C7973F703;
	Fri, 30 Aug 2019 08:23:14 -0700 (PDT)
Subject: Re: [PATCH 3/7] iommu/arm-smmu: Add tlb_sync implementation hook
To: Krishna Reddy <vdumpa@nvidia.com>
References: <1567118827-26358-1-git-send-email-vdumpa@nvidia.com>
	<1567118827-26358-4-git-send-email-vdumpa@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <554f8de1-1638-4eb9-59ae-8e1f0d786c44@arm.com>
Date: Fri, 30 Aug 2019 16:23:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1567118827-26358-4-git-send-email-vdumpa@nvidia.com>
Content-Language: en-GB
Cc: talho@nvidia.com, treding@nvidia.com, mperttunen@nvidia.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	praithatha@nvidia.com, thomasz@nvidia.com, snikam@nvidia.com,
	linux-tegra@vger.kernel.org, yhsu@nvidia.com,
	jtukkinen@nvidia.com, avanbrunt@nvidia.com,
	linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Development issues for Linux IOMMU support
	<iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On 29/08/2019 23:47, Krishna Reddy wrote:
> tlb_sync hook allows nvidia smmu handle tlb sync
> across multiple SMMUs as necessary.
> 
> Signed-off-by: Krishna Reddy <vdumpa@nvidia.com>
> ---
>   drivers/iommu/arm-smmu-nvidia.c | 32 ++++++++++++++++++++++++++++++++
>   drivers/iommu/arm-smmu.c        |  8 +++++---
>   drivers/iommu/arm-smmu.h        |  4 ++++
>   3 files changed, 41 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu-nvidia.c b/drivers/iommu/arm-smmu-nvidia.c
> index d93ceda..a429b2c 100644
> --- a/drivers/iommu/arm-smmu-nvidia.c
> +++ b/drivers/iommu/arm-smmu-nvidia.c
> @@ -56,11 +56,43 @@ static void nsmmu_write_reg64(struct arm_smmu_device *smmu,
>   		writeq_relaxed(val, nsmmu_page(smmu, i, page) + offset);
>   }
>   
> +static void nsmmu_tlb_sync_wait(struct arm_smmu_device *smmu, int page,
> +				int sync, int status, int inst)
> +{
> +	u32 reg;
> +	unsigned int spin_cnt, delay;
> +
> +	for (delay = 1; delay < TLB_LOOP_TIMEOUT; delay *= 2) {
> +		for (spin_cnt = TLB_SPIN_COUNT; spin_cnt > 0; spin_cnt--) {
> +			reg = readl_relaxed(
> +			      nsmmu_page(smmu, inst, page) + status);
> +			if (!(reg & sTLBGSTATUS_GSACTIVE))
> +				return;
> +			cpu_relax();
> +		}
> +		udelay(delay);
> +	}
> +	dev_err_ratelimited(smmu->dev,
> +			    "TLB sync timed out -- SMMU may be deadlocked\n");
> +}
> +
> +static void nsmmu_tlb_sync(struct arm_smmu_device *smmu, int page,
> +			   int sync, int status)
> +{
> +	int i;
> +
> +	arm_smmu_writel(smmu, page, sync, 0);
> +
> +	for (i = 0; i < to_nsmmu(smmu)->num_inst; i++)

It might make more sense to make this the innermost loop, i.e.:

	for (i = 0; i < nsmmu->num_inst; i++)
		reg &= readl_relaxed(nsmmu_page(smmu, i, page)...

since polling the instances in parallel rather than in series seems like 
it might be a bit more efficient.

> +		nsmmu_tlb_sync_wait(smmu, page, sync, status, i);
> +}
> +
>   static const struct arm_smmu_impl nsmmu_impl = {
>   	.read_reg = nsmmu_read_reg,
>   	.write_reg = nsmmu_write_reg,
>   	.read_reg64 = nsmmu_read_reg64,
>   	.write_reg64 = nsmmu_write_reg64,
> +	.tlb_sync = nsmmu_tlb_sync,
>   };
>   
>   struct arm_smmu_device *nvidia_smmu_impl_init(struct arm_smmu_device *smmu)
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 46e1641..f5454e71 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -52,9 +52,6 @@
>    */
>   #define QCOM_DUMMY_VAL -1
>   
> -#define TLB_LOOP_TIMEOUT		1000000	/* 1s! */
> -#define TLB_SPIN_COUNT			10
> -
>   #define MSI_IOVA_BASE			0x8000000
>   #define MSI_IOVA_LENGTH			0x100000
>   
> @@ -244,6 +241,11 @@ static void __arm_smmu_tlb_sync(struct arm_smmu_device *smmu, int page,
>   	unsigned int spin_cnt, delay;
>   	u32 reg;
>   
> +	if (smmu->impl->tlb_sync) {
> +		smmu->impl->tlb_sync(smmu, page, sync, status);

What I'd hoped is that rather than needing a hook for this, you could 
just override smmu_domain->tlb_ops from .init_context to wire up the 
alternate .sync method directly. That would save this extra level of 
indirection.

Robin.

> +		return;
> +	}
> +
>   	arm_smmu_writel(smmu, page, sync, QCOM_DUMMY_VAL);
>   	for (delay = 1; delay < TLB_LOOP_TIMEOUT; delay *= 2) {
>   		for (spin_cnt = TLB_SPIN_COUNT; spin_cnt > 0; spin_cnt--) {
> diff --git a/drivers/iommu/arm-smmu.h b/drivers/iommu/arm-smmu.h
> index 9645bf1..d3217f1 100644
> --- a/drivers/iommu/arm-smmu.h
> +++ b/drivers/iommu/arm-smmu.h
> @@ -207,6 +207,8 @@ enum arm_smmu_cbar_type {
>   /* Maximum number of context banks per SMMU */
>   #define ARM_SMMU_MAX_CBS		128
>   
> +#define TLB_LOOP_TIMEOUT		1000000	/* 1s! */
> +#define TLB_SPIN_COUNT			10
>   
>   /* Shared driver definitions */
>   enum arm_smmu_arch_version {
> @@ -336,6 +338,8 @@ struct arm_smmu_impl {
>   	int (*cfg_probe)(struct arm_smmu_device *smmu);
>   	int (*reset)(struct arm_smmu_device *smmu);
>   	int (*init_context)(struct arm_smmu_domain *smmu_domain);
> +	void (*tlb_sync)(struct arm_smmu_device *smmu, int page, int sync,
> +			 int status);
>   };
>   
>   static inline void __iomem *arm_smmu_page(struct arm_smmu_device *smmu, int n)
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
