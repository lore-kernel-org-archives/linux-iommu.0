Return-Path: <SRS0=B4OP=WL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC66C433FF
	for <iommu@archiver.kernel.org>; Thu, 15 Aug 2019 10:56:18 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C55052184B
	for <iommu@archiver.kernel.org>; Thu, 15 Aug 2019 10:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qlJkbahb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C55052184B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id AFBC7E7F;
	Thu, 15 Aug 2019 10:56:18 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 655D2D1A
	for <iommu@lists.linux-foundation.org>;
	Thu, 15 Aug 2019 10:56:17 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id E25A067F
	for <iommu@lists.linux-foundation.org>;
	Thu, 15 Aug 2019 10:56:16 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
	bits)) (No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 3C0F221744;
	Thu, 15 Aug 2019 10:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565866576;
	bh=YGphF6s1f7WGZAHyAoOJ8BaEHYQUybLPmN2u5ZcFyG0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qlJkbahbOxQVjzQkiPuzqRtrSuWYLG0wo5xsf0E2js6ROgaRd1sRZX//bjFCdKnqX
	MKgh1aGejgFvxBJTcP4/uIGqbhcLrR8ZcVvaKB46tsKMLmCufDF7Kb9D1VcQRA1RR6
	cUYzIETeAEIBaPI2WoQonGMbyBB1ED9OD/eN/Mbo=
Date: Thu, 15 Aug 2019 11:56:12 +0100
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 08/15] iommu/arm-smmu: Abstract context bank accesses
Message-ID: <20190815105611.fk7ouis2cs3uzvew@willie-the-truck>
References: <cover.1565369764.git.robin.murphy@arm.com>
	<1051d7568c96142ff90b004a2ec61e3b5dbe770e.1565369764.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1051d7568c96142ff90b004a2ec61e3b5dbe770e.1565369764.git.robin.murphy@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Cc: bjorn.andersson@linaro.org, iommu@lists.linux-foundation.org,
	gregory.clement@bootlin.com, linux-arm-kernel@lists.infradead.org
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Fri, Aug 09, 2019 at 06:07:45PM +0100, Robin Murphy wrote:
> Context bank accesses are fiddly enough to deserve a number of extra
> helpers to keep the callsites looking sane, even though there are only
> one or two of each.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/arm-smmu.c | 137 ++++++++++++++++++++-------------------
>  1 file changed, 72 insertions(+), 65 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 72505647b77d..abdcc3f52e2e 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -82,9 +82,6 @@
>  		((smmu->options & ARM_SMMU_OPT_SECURE_CFG_ACCESS)	\
>  			? 0x400 : 0))
>  
> -/* Translation context bank */
> -#define ARM_SMMU_CB(smmu, n)	((smmu)->base + (((smmu)->cb_base + (n)) << (smmu)->pgshift))
> -
>  #define MSI_IOVA_BASE			0x8000000
>  #define MSI_IOVA_LENGTH			0x100000
>  
> @@ -265,9 +262,29 @@ static void arm_smmu_writel(struct arm_smmu_device *smmu, int page, int offset,
>  	writel_relaxed(val, arm_smmu_page(smmu, page) + offset);
>  }
>  
> +static u64 arm_smmu_readq(struct arm_smmu_device *smmu, int page, int offset)
> +{
> +	return readq_relaxed(arm_smmu_page(smmu, page) + offset);
> +}
> +
> +static void arm_smmu_writeq(struct arm_smmu_device *smmu, int page, int offset,
> +			    u64 val)
> +{
> +	writeq_relaxed(val, arm_smmu_page(smmu, page) + offset);
> +}
> +
>  #define arm_smmu_read_gr1(s, r)		arm_smmu_readl((s), 1, (r))
>  #define arm_smmu_write_gr1(s, r, v)	arm_smmu_writel((s), 1, (r), (v))
>  
> +#define arm_smmu_read_cb(s, n, r)				\
> +	arm_smmu_readl((s), (s)->cb_base + (n), (r))
> +#define arm_smmu_write_cb(s, n, r, v)				\
> +	arm_smmu_writel((s), (s)->cb_base + (n), (r), (v))
> +#define arm_smmu_read_cb_q(s, n, r)				\
> +	arm_smmu_readq((s), (s)->cb_base + (n), (r))
> +#define arm_smmu_write_cb_q(s, n, r, v)				\
> +	arm_smmu_writeq((s), (s)->cb_base + (n), (r), (v))

'r' for 'offset'? (maybe just rename offset => register in the helpers).

>  struct arm_smmu_option_prop {
>  	u32 opt;
>  	const char *prop;
> @@ -423,15 +440,17 @@ static void __arm_smmu_free_bitmap(unsigned long *map, int idx)
>  }
>  
>  /* Wait for any pending TLB invalidations to complete */
> -static void __arm_smmu_tlb_sync(struct arm_smmu_device *smmu,
> -				void __iomem *sync, void __iomem *status)
> +static void __arm_smmu_tlb_sync(struct arm_smmu_device *smmu, int page,
> +				int sync, int status)
>  {
>  	unsigned int spin_cnt, delay;
> +	u32 reg;
>  
> -	writel_relaxed(QCOM_DUMMY_VAL, sync);
> +	arm_smmu_writel(smmu, page, sync, QCOM_DUMMY_VAL);
>  	for (delay = 1; delay < TLB_LOOP_TIMEOUT; delay *= 2) {
>  		for (spin_cnt = TLB_SPIN_COUNT; spin_cnt > 0; spin_cnt--) {
> -			if (!(readl_relaxed(status) & sTLBGSTATUS_GSACTIVE))
> +			reg = arm_smmu_readl(smmu, page, status);
> +			if (!(reg & sTLBGSTATUS_GSACTIVE))
>  				return;
>  			cpu_relax();
>  		}
> @@ -443,12 +462,11 @@ static void __arm_smmu_tlb_sync(struct arm_smmu_device *smmu,
>  
>  static void arm_smmu_tlb_sync_global(struct arm_smmu_device *smmu)
>  {
> -	void __iomem *base = ARM_SMMU_GR0(smmu);
>  	unsigned long flags;
>  
>  	spin_lock_irqsave(&smmu->global_sync_lock, flags);
> -	__arm_smmu_tlb_sync(smmu, base + ARM_SMMU_GR0_sTLBGSYNC,
> -			    base + ARM_SMMU_GR0_sTLBGSTATUS);
> +	__arm_smmu_tlb_sync(smmu, 0, ARM_SMMU_GR0_sTLBGSYNC,

Can we have a #define for page zero, please?

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
