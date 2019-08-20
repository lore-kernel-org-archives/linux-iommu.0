Return-Path: <SRS0=xQF/=WQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EEE7C3A589
	for <iommu@archiver.kernel.org>; Tue, 20 Aug 2019 10:19:18 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5673122CF4
	for <iommu@archiver.kernel.org>; Tue, 20 Aug 2019 10:19:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="df9fx7q7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5673122CF4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 3DC84CCB;
	Tue, 20 Aug 2019 10:19:18 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 3D084CAE
	for <iommu@lists.linux-foundation.org>;
	Tue, 20 Aug 2019 10:19:17 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id C128512E
	for <iommu@lists.linux-foundation.org>;
	Tue, 20 Aug 2019 10:19:16 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
	bits)) (No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 7647A20C01;
	Tue, 20 Aug 2019 10:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566296356;
	bh=P/AkiFjoa+ZXD65ahVrE1D56kGITx+qPBb6Af5bjtQk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=df9fx7q7d85HjJ0eJrMEUzl7Xo/pDZGT6gPXVq+3UgRaFIzHWMRZGsKtPuNW6YOkw
	8dNVvpZtxwkb7MMDzHfUYuxt2J8LVNnyiXqcygZbjEX69VwpaiOd/FrJ2nBfiPSJEO
	/8gd7hS4wd4ox5h0uL19vKbUjj10lmYVX2XxLdsU=
Date: Tue, 20 Aug 2019 11:19:12 +0100
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 2/4] iommu/io-pgtable-arm: Rationalise TTBRn handling
Message-ID: <20190820101911.ndwtaf76kn3zplk2@willie-the-truck>
References: <cover.1566238530.git.robin.murphy@arm.com>
	<dbb942070c2ef812e379414c236734931613d860.1566238530.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <dbb942070c2ef812e379414c236734931613d860.1566238530.git.robin.murphy@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Cc: iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
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

On Mon, Aug 19, 2019 at 07:19:29PM +0100, Robin Murphy wrote:
> TTBR1 values have so far been redundant since no users implement any
> support for split address spaces. Crucially, though, one of the main
> reasons for wanting to do so is to be able to manage each half entirely
> independently, e.g. context-switching one set of mappings without
> disturbing the other. Thus it seems unlikely that tying two tables
> together in a single io_pgtable_cfg would ever be particularly desirable
> or useful.
> 
> Streamline the configs to just a single conceptual TTBR value
> representing the allocated table. This paves the way for future users to
> support split address spaces by simply allocating a table and dealing
> with the detailed TTBRn logistics themselves.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/arm-smmu-v3.c        |  2 +-
>  drivers/iommu/arm-smmu.c           |  9 ++++-----
>  drivers/iommu/io-pgtable-arm-v7s.c | 16 +++++++---------
>  drivers/iommu/io-pgtable-arm.c     |  7 +++----
>  drivers/iommu/ipmmu-vmsa.c         |  2 +-
>  drivers/iommu/msm_iommu.c          |  4 ++--
>  drivers/iommu/mtk_iommu.c          |  4 ++--
>  drivers/iommu/qcom_iommu.c         |  3 +--
>  include/linux/io-pgtable.h         |  4 ++--
>  9 files changed, 23 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 2a8db896d698..2e50cf49c3c4 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -1722,7 +1722,7 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
>  	}
>  
>  	cfg->cd.asid	= (u16)asid;
> -	cfg->cd.ttbr	= pgtbl_cfg->arm_lpae_s1_cfg.ttbr[0];
> +	cfg->cd.ttbr	= pgtbl_cfg->arm_lpae_s1_cfg.ttbr;
>  	cfg->cd.tcr	= pgtbl_cfg->arm_lpae_s1_cfg.tcr;
>  	cfg->cd.mair	= pgtbl_cfg->arm_lpae_s1_cfg.mair;
>  	return 0;
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 184ca41e9de7..19030c4b5904 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -473,13 +473,12 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain,
>  	/* TTBRs */
>  	if (stage1) {
>  		if (cfg->fmt == ARM_SMMU_CTX_FMT_AARCH32_S) {
> -			cb->ttbr[0] = pgtbl_cfg->arm_v7s_cfg.ttbr[0];
> -			cb->ttbr[1] = pgtbl_cfg->arm_v7s_cfg.ttbr[1];
> +			cb->ttbr[0] = pgtbl_cfg->arm_v7s_cfg.ttbr;
> +			cb->ttbr[1] = 0;
>  		} else {
> -			cb->ttbr[0] = pgtbl_cfg->arm_lpae_s1_cfg.ttbr[0];
> +			cb->ttbr[0] = pgtbl_cfg->arm_lpae_s1_cfg.ttbr;
>  			cb->ttbr[0] |= FIELD_PREP(TTBRn_ASID, cfg->asid);
> -			cb->ttbr[1] = pgtbl_cfg->arm_lpae_s1_cfg.ttbr[1];
> -			cb->ttbr[1] |= FIELD_PREP(TTBRn_ASID, cfg->asid);
> +			cb->ttbr[1] = FIELD_PREP(TTBRn_ASID, cfg->asid);

Why do you continue to put the ASID in here?

> diff --git a/drivers/iommu/qcom_iommu.c b/drivers/iommu/qcom_iommu.c
> index 34bb357b3cfa..de55b6d82ef1 100644
> --- a/drivers/iommu/qcom_iommu.c
> +++ b/drivers/iommu/qcom_iommu.c
> @@ -247,10 +247,9 @@ static int qcom_iommu_init_domain(struct iommu_domain *domain,
>  
>  		/* TTBRs */
>  		iommu_writeq(ctx, ARM_SMMU_CB_TTBR0,
> -				pgtbl_cfg.arm_lpae_s1_cfg.ttbr[0] |
> +				pgtbl_cfg.arm_lpae_s1_cfg.ttbr |
>  				FIELD_PREP(TTBRn_ASID, ctx->asid));
>  		iommu_writeq(ctx, ARM_SMMU_CB_TTBR1,
> -				pgtbl_cfg.arm_lpae_s1_cfg.ttbr[1] |
>  				FIELD_PREP(TTBRn_ASID, ctx->asid));

Same here.

> diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
> index a6c8aa204733..7a0905d7a006 100644
> --- a/include/linux/io-pgtable.h
> +++ b/include/linux/io-pgtable.h
> @@ -90,7 +90,7 @@ struct io_pgtable_cfg {
>  	/* Low-level data specific to the table format */
>  	union {
>  		struct {
> -			u64	ttbr[2];
> +			u64	ttbr;
>  			u64	tcr;
>  			u64	mair;
>  		} arm_lpae_s1_cfg;
> @@ -101,7 +101,7 @@ struct io_pgtable_cfg {
>  		} arm_lpae_s2_cfg;
>  
>  		struct {
> -			u32	ttbr[2];
> +			u32	ttbr;

We could probably do with a comment for these 'ttbr' field now saying that
they refer to ttbr0 (since the tcr will have EPD1 set).

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
