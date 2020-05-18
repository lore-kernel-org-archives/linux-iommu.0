Return-Path: <SRS0=00Kx=7A=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22083C433DF
	for <iommu@archiver.kernel.org>; Mon, 18 May 2020 15:00:14 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEC9D2065F
	for <iommu@archiver.kernel.org>; Mon, 18 May 2020 15:00:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uNdmSK6q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEC9D2065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id BC06021509;
	Mon, 18 May 2020 15:00:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id V64q4cXg-xc6; Mon, 18 May 2020 15:00:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id D13072154A;
	Mon, 18 May 2020 15:00:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A815AC0881;
	Mon, 18 May 2020 15:00:07 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CB02DC07FF
 for <iommu@lists.linux-foundation.org>; Mon, 18 May 2020 15:00:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id B82D387D46
 for <iommu@lists.linux-foundation.org>; Mon, 18 May 2020 15:00:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id w8SREvSSWe-W for <iommu@lists.linux-foundation.org>;
 Mon, 18 May 2020 15:00:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 8E9038768A
 for <iommu@lists.linux-foundation.org>; Mon, 18 May 2020 15:00:04 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 118762065F;
 Mon, 18 May 2020 15:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1589814004;
 bh=RNl6fktbFCVNb99FAXoUAHm7HFGk+HnBZtNJ3HcZJYk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=uNdmSK6qwH2wEs1Dmvxn71gST5OtXhoWG1ERuWlW5HjkBatY1wakm3u6qeoCeqxQW
 UuvTXUIqydZD04oNCS+WbK4w0/gvCkAac2cxw5Mi7eEB0fEgZsx14Ig0Tku6fZMYvL
 iKvPC/+BLbKoO+lQB9OJpljl83PFqCY4jW7yueIM=
Date: Mon, 18 May 2020 15:59:59 +0100
From: Will Deacon <will@kernel.org>
To: Jordan Crouse <jcrouse@codeaurora.org>
Subject: Re: [PATCH v6 2/5] iommu/arm-smmu: Add support for TTBR1
Message-ID: <20200518145959.GK32394@willie-the-truck>
References: <20200409233350.6343-1-jcrouse@codeaurora.org>
 <20200409233350.6343-3-jcrouse@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200409233350.6343-3-jcrouse@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, robin.murphy@arm.com,
 linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
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
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Thu, Apr 09, 2020 at 05:33:47PM -0600, Jordan Crouse wrote:
> Add support to enable TTBR1 if the domain requests it via the
> DOMAIN_ATTR_SPLIT_TABLES attribute. If enabled by the hardware
> and pagetable configuration the driver will configure the TTBR1 region
> and program the domain pagetable on TTBR1. TTBR0 will be disabled.
> 
> After attaching the device the value of he domain attribute can
> be queried to see if the split pagetables were successfully programmed.
> The domain geometry will be updated as well so that the caller can
> determine the active region for the pagetable that was programmed.
> 
> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> ---
> 
>  drivers/iommu/arm-smmu.c | 48 ++++++++++++++++++++++++++++++++++------
>  drivers/iommu/arm-smmu.h | 24 +++++++++++++++-----
>  2 files changed, 59 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index a6a5796e9c41..db6d503c1673 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -555,11 +555,16 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain,
>  			cb->ttbr[0] = pgtbl_cfg->arm_v7s_cfg.ttbr;
>  			cb->ttbr[1] = 0;
>  		} else {
> -			cb->ttbr[0] = pgtbl_cfg->arm_lpae_s1_cfg.ttbr;
> -			cb->ttbr[0] |= FIELD_PREP(ARM_SMMU_TTBRn_ASID,
> -						  cfg->asid);
> -			cb->ttbr[1] = FIELD_PREP(ARM_SMMU_TTBRn_ASID,
> -						 cfg->asid);
> +			cb->ttbr[0] = FIELD_PREP(ARM_SMMU_TTBRn_ASID,
> +				cfg->asid);
> +
> +			if (pgtbl_cfg->quirks & IO_PGTABLE_QUIRK_ARM_TTBR1) {
> +				cb->ttbr[1] = pgtbl_cfg->arm_lpae_s1_cfg.ttbr;
> +			} else {
> +				cb->ttbr[0] |= pgtbl_cfg->arm_lpae_s1_cfg.ttbr;
> +				cb->ttbr[1] = FIELD_PREP(ARM_SMMU_TTBRn_ASID,
> +							 cfg->asid);
> +			}

This looks odd to me. As I mentioned before, the SMMU driver absolutely has
to manage the ASID space, so we should be setting it in both TTBRs here.

> diff --git a/drivers/iommu/arm-smmu.h b/drivers/iommu/arm-smmu.h
> index 8d1cd54d82a6..5f6d0af7c8c8 100644
> --- a/drivers/iommu/arm-smmu.h
> +++ b/drivers/iommu/arm-smmu.h
> @@ -172,6 +172,7 @@ enum arm_smmu_cbar_type {
>  #define ARM_SMMU_TCR_SH0		GENMASK(13, 12)
>  #define ARM_SMMU_TCR_ORGN0		GENMASK(11, 10)
>  #define ARM_SMMU_TCR_IRGN0		GENMASK(9, 8)
> +#define ARM_SMMU_TCR_EPD0		BIT(7)
>  #define ARM_SMMU_TCR_T0SZ		GENMASK(5, 0)
>  
>  #define ARM_SMMU_VTCR_RES1		BIT(31)
> @@ -343,16 +344,27 @@ struct arm_smmu_domain {
>  	struct mutex			init_mutex; /* Protects smmu pointer */
>  	spinlock_t			cb_lock; /* Serialises ATS1* ops and TLB syncs */
>  	struct iommu_domain		domain;
> +	bool				split_pagetables;
>  };
>  
>  static inline u32 arm_smmu_lpae_tcr(struct io_pgtable_cfg *cfg)
>  {
> -	return ARM_SMMU_TCR_EPD1 |
> -	       FIELD_PREP(ARM_SMMU_TCR_TG0, cfg->arm_lpae_s1_cfg.tcr.tg) |
> -	       FIELD_PREP(ARM_SMMU_TCR_SH0, cfg->arm_lpae_s1_cfg.tcr.sh) |
> -	       FIELD_PREP(ARM_SMMU_TCR_ORGN0, cfg->arm_lpae_s1_cfg.tcr.orgn) |
> -	       FIELD_PREP(ARM_SMMU_TCR_IRGN0, cfg->arm_lpae_s1_cfg.tcr.irgn) |
> -	       FIELD_PREP(ARM_SMMU_TCR_T0SZ, cfg->arm_lpae_s1_cfg.tcr.tsz);
> +	u32 tcr = FIELD_PREP(ARM_SMMU_TCR_TG0, cfg->arm_lpae_s1_cfg.tcr.tg) |
> +		FIELD_PREP(ARM_SMMU_TCR_SH0, cfg->arm_lpae_s1_cfg.tcr.sh) |
> +		FIELD_PREP(ARM_SMMU_TCR_ORGN0, cfg->arm_lpae_s1_cfg.tcr.orgn) |
> +		FIELD_PREP(ARM_SMMU_TCR_IRGN0, cfg->arm_lpae_s1_cfg.tcr.irgn) |
> +		FIELD_PREP(ARM_SMMU_TCR_T0SZ, cfg->arm_lpae_s1_cfg.tcr.tsz);
> +
> +       /*
> +	* When TTBR1 is selected shift the TCR fields by 16 bits and disable
> +	* translation in TTBR0
> +	*/
> +	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_TTBR1)
> +		tcr = (tcr << 16) | ARM_SMMU_TCR_EPD0;

This looks reasonably dodgy to me, as you copy a RESERVED bit into the A1
field. Furthermore, for 32-bit context banks you've got the EAE bit to
contend with as well.

Perhaps we shouldn't expose DOMAIN_ATTR_SPLIT_TABLES for anything other than
the 64-bit page table format.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
