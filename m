Return-Path: <SRS0=B4OP=WL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36499C433FF
	for <iommu@archiver.kernel.org>; Thu, 15 Aug 2019 10:56:28 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A4CE2184D
	for <iommu@archiver.kernel.org>; Thu, 15 Aug 2019 10:56:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HncehK0V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A4CE2184D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id D5BA11033;
	Thu, 15 Aug 2019 10:56:27 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 8DD24D1A
	for <iommu@lists.linux-foundation.org>;
	Thu, 15 Aug 2019 10:56:26 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 05B3C67F
	for <iommu@lists.linux-foundation.org>;
	Thu, 15 Aug 2019 10:56:26 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
	bits)) (No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 4B96F21744;
	Thu, 15 Aug 2019 10:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565866585;
	bh=8D6OrleAFj04JQA9ZH9MMZ7u4sfwPhB2JbKNxPQaMkk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HncehK0VFOGw8d9ng8b57iR+mqmK/droVfq+Lcy/EJBNIWS8/XDpjPfrb6wX4ceRZ
	nuRKC7mNTfc/2JKnWTeaFychC81E8jozEyGvpyBLC0OoujIsVXV6caBN/9JJdafENd
	98tosuR75Agsla3Ms5ATjaIhl142Mxw3cXyfcrd4=
Date: Thu, 15 Aug 2019 11:56:21 +0100
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 15/15] iommu/arm-smmu: Add context init implementation hook
Message-ID: <20190815105621.vt2gsuppjqgesrho@willie-the-truck>
References: <cover.1565369764.git.robin.murphy@arm.com>
	<6adbec8e4757f3b6c9f47135544a0302f8e7c55c.1565369764.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6adbec8e4757f3b6c9f47135544a0302f8e7c55c.1565369764.git.robin.murphy@arm.com>
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

On Fri, Aug 09, 2019 at 06:07:52PM +0100, Robin Murphy wrote:
> Allocating and initialising a context for a domain is another point
> where certain implementations are known to want special behaviour.
> Currently the other half of the Cavium workaround comes into play here,
> so let's finish the job to get the whole thing right out of the way.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/arm-smmu-impl.c | 39 +++++++++++++++++++++++++--
>  drivers/iommu/arm-smmu.c      | 51 +++++++----------------------------
>  drivers/iommu/arm-smmu.h      | 42 +++++++++++++++++++++++++++--
>  3 files changed, 86 insertions(+), 46 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu-impl.c b/drivers/iommu/arm-smmu-impl.c
> index c8904da08354..7a657d47b6ec 100644
> --- a/drivers/iommu/arm-smmu-impl.c
> +++ b/drivers/iommu/arm-smmu-impl.c
> @@ -48,6 +48,12 @@ const struct arm_smmu_impl calxeda_impl = {
>  };
>  
>  
> +struct cavium_smmu {
> +	struct arm_smmu_device smmu;
> +	u32 id_base;
> +};
> +#define to_csmmu(s)	container_of(s, struct cavium_smmu, smmu)

To be honest with you, I'd just use container_of directly for the two
callsites that need it. "to_csmmu" isn't a great name when we're also got
the calxeda thing in here.

>  static int cavium_cfg_probe(struct arm_smmu_device *smmu)
>  {
>  	static atomic_t context_count = ATOMIC_INIT(0);
> @@ -56,17 +62,46 @@ static int cavium_cfg_probe(struct arm_smmu_device *smmu)
>  	 * Ensure ASID and VMID allocation is unique across all SMMUs in
>  	 * the system.
>  	 */
> -	smmu->cavium_id_base = atomic_fetch_add(smmu->num_context_banks,
> +	to_csmmu(smmu)->id_base = atomic_fetch_add(smmu->num_context_banks,
>  						   &context_count);
>  	dev_notice(smmu->dev, "\tenabling workaround for Cavium erratum 27704\n");
>  
>  	return 0;
>  }
>  
> +int cavium_init_context(struct arm_smmu_domain *smmu_domain)
> +{
> +	u32 id_base = to_csmmu(smmu_domain->smmu)->id_base;
> +
> +	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S2)
> +		smmu_domain->cfg.vmid += id_base;
> +	else
> +		smmu_domain->cfg.asid += id_base;
> +
> +	return 0;
> +}
> +
>  const struct arm_smmu_impl cavium_impl = {
>  	.cfg_probe = cavium_cfg_probe,
> +	.init_context = cavium_init_context,
>  };
>  
> +struct arm_smmu_device *cavium_smmu_impl_init(struct arm_smmu_device *smmu)
> +{
> +	struct cavium_smmu *csmmu;
> +
> +	csmmu = devm_kzalloc(smmu->dev, sizeof(*csmmu), GFP_KERNEL);
> +	if (!csmmu)
> +		return ERR_PTR(-ENOMEM);
> +
> +	csmmu->smmu = *smmu;
> +	csmmu->smmu.impl = &cavium_impl;
> +
> +	devm_kfree(smmu->dev, smmu);
> +
> +	return &csmmu->smmu;
> +}
> +
>  
>  #define ARM_MMU500_ACTLR_CPRE		(1 << 1)
>  
> @@ -121,7 +156,7 @@ struct arm_smmu_device *arm_smmu_impl_init(struct arm_smmu_device *smmu)
>  		smmu->impl = &calxeda_impl;
>  
>  	if (smmu->model == CAVIUM_SMMUV2)
> -		smmu->impl = &cavium_impl;
> +		return cavium_smmu_impl_init(smmu);
>  
>  	if (smmu->model == ARM_MMU500)
>  		smmu->impl = &arm_mmu500_impl;

Maybe rework this so we do the calxeda detection first (and return if we
match), followed by a switch on smmu->model to make it crystal clear that
we match only one?

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
