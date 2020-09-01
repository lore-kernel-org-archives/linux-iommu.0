Return-Path: <SRS0=Ln9J=CK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44990C433E6
	for <iommu@archiver.kernel.org>; Tue,  1 Sep 2020 03:41:32 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E8C2207D3
	for <iommu@archiver.kernel.org>; Tue,  1 Sep 2020 03:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OvdGgx8z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E8C2207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id E7D5586654;
	Tue,  1 Sep 2020 03:41:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GFoOh3AQHn+F; Tue,  1 Sep 2020 03:41:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4F533845CF;
	Tue,  1 Sep 2020 03:41:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4357AC088B;
	Tue,  1 Sep 2020 03:41:31 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D517AC0052
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 03:41:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id C3F5A86650
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 03:41:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iW9mt1Y+uleE for <iommu@lists.linux-foundation.org>;
 Tue,  1 Sep 2020 03:41:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com
 [209.85.210.66])
 by whitealder.osuosl.org (Postfix) with ESMTPS id B17DD845CF
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 03:41:28 +0000 (UTC)
Received: by mail-ot1-f66.google.com with SMTP id a65so7288424otc.8
 for <iommu@lists.linux-foundation.org>; Mon, 31 Aug 2020 20:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=m9Iy8xTCC/lsqmeyypdzVoGtMOlOgKNaC8wzlU8V0Ak=;
 b=OvdGgx8zL65e4Bb0BcRh6yN/3q4dC8gjuaK+3Fhp4cUpG3iCDerutJodNY03OjYGP8
 Z7IeLMMyALrTbMCIheI/0pB9cFz8WOgmYMVVS4jpwYTel3xiCmjFIAmT/aZASLFaWd4T
 +KlMM+ZpXAHZxi2uxzJUWy5SvcX11B11Qn9yVD/wZUxJXte8pEL7w7rNAxWAuhIc35CN
 Z0PV5saGr80uO1fKWdefggxhfofcB5C9jh2zqS75yi2w1Q6GwKLqlIfRw7Z3vzdZXDaD
 QEF2clVJcASNZMrwB69e21JElbzPC9VzX1JB4pr5/tr3grZpDwrj/YjhqCs18KZRH2GG
 u1XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=m9Iy8xTCC/lsqmeyypdzVoGtMOlOgKNaC8wzlU8V0Ak=;
 b=fNguSC7mXKXMMlNPKTmQgN309bS6AP8bSQCkkiOO18//Vl4Q8Ht224F9mz7M48NJIH
 bl8WnRPwW4ZtqNQM5X1yg0Uko4n18e2KV6R+jzoirvXqWmIrabCoXdZX7jfBRiV21Gjx
 S9jktgeLnZymg6qsWAO+4mT7KICv6qAleg+PqxOvsWvmIJE2nJ4GVrIAJQGwVXUcZgKj
 Ffr6zILpCZyvVaQx7SO2FhSNafHQhre9ucpADIh6kiBPA9/REGZokF3h7b0CBimGOel4
 DwzpBcM05cMglaZt1oXgO8gRnQGiz7b/h24uJqPMs1LUrW9AqKN120+UgzQ6+ue76Cp0
 0yDQ==
X-Gm-Message-State: AOAM532BzsUyyiwAM8R5ryxC5J++fFgSLJXWCcYWV5kVwYaGsm/fw3Mr
 06K5oCGLuw5UT82W0RX5X3uqig==
X-Google-Smtp-Source: ABdhPJxtDOjj0e1mP0NY8oxLhIt6qsoBW5DDUq2IVcRAKAsm/7RnzzUFwBc3Sk1qfl66he83RS8k5Q==
X-Received: by 2002:a9d:63c5:: with SMTP id e5mr9472otl.46.1598931687626;
 Mon, 31 Aug 2020 20:41:27 -0700 (PDT)
Received: from yoga ([2605:6000:e5cb:c100:8898:14ff:fe6d:34e])
 by smtp.gmail.com with ESMTPSA id b79sm908112oii.33.2020.08.31.20.41.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2020 20:41:27 -0700 (PDT)
Date: Mon, 31 Aug 2020 22:41:23 -0500
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Rob Clark <robdclark@gmail.com>
Subject: Re: [PATCH 03/19] iommu/arm-smmu: Add support for split pagetables
Message-ID: <20200901034123.GL3715@yoga>
References: <20200810222657.1841322-1-jcrouse@codeaurora.org>
 <20200814024114.1177553-4-robdclark@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200814024114.1177553-4-robdclark@gmail.com>
Cc: Rob Clark <robdclark@chromium.org>,
 open list <linux-kernel@vger.kernel.org>, Will Deacon <will@kernel.org>,
 linux-arm-msm@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
 dri-devel@lists.freedesktop.org, Stephen Boyd <swboyd@chromium.org>,
 iommu@lists.linux-foundation.org, Sibi Sankar <sibis@codeaurora.org>,
 Vivek Gautam <vivek.gautam@codeaurora.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jon Hunter <jonathanh@nvidia.com>, freedreno@lists.freedesktop.org,
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

On Thu 13 Aug 21:40 CDT 2020, Rob Clark wrote:

> From: Jordan Crouse <jcrouse@codeaurora.org>
> 
> Enable TTBR1 for a context bank if IO_PGTABLE_QUIRK_ARM_TTBR1 is selected
> by the io-pgtable configuration.
> 
> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu.c | 21 ++++++++++++++++-----
>  drivers/iommu/arm/arm-smmu/arm-smmu.h | 25 +++++++++++++++++++------
>  2 files changed, 35 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> index 37d8d49299b4..976d43a7f2ff 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> @@ -552,11 +552,15 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain,
>  			cb->ttbr[0] = pgtbl_cfg->arm_v7s_cfg.ttbr;
>  			cb->ttbr[1] = 0;
>  		} else {
> -			cb->ttbr[0] = pgtbl_cfg->arm_lpae_s1_cfg.ttbr;
> -			cb->ttbr[0] |= FIELD_PREP(ARM_SMMU_TTBRn_ASID,
> -						  cfg->asid);
> +			cb->ttbr[0] = FIELD_PREP(ARM_SMMU_TTBRn_ASID,
> +				cfg->asid);
>  			cb->ttbr[1] = FIELD_PREP(ARM_SMMU_TTBRn_ASID,
> -						 cfg->asid);
> +				cfg->asid);

The old indentation seems more appropriate.

Apart from that this looks sensible.

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> +
> +			if (pgtbl_cfg->quirks & IO_PGTABLE_QUIRK_ARM_TTBR1)
> +				cb->ttbr[1] |= pgtbl_cfg->arm_lpae_s1_cfg.ttbr;
> +			else
> +				cb->ttbr[0] |= pgtbl_cfg->arm_lpae_s1_cfg.ttbr;
>  		}
>  	} else {
>  		cb->ttbr[0] = pgtbl_cfg->arm_lpae_s2_cfg.vttbr;
> @@ -822,7 +826,14 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
>  
>  	/* Update the domain's page sizes to reflect the page table format */
>  	domain->pgsize_bitmap = pgtbl_cfg.pgsize_bitmap;
> -	domain->geometry.aperture_end = (1UL << ias) - 1;
> +
> +	if (pgtbl_cfg.quirks & IO_PGTABLE_QUIRK_ARM_TTBR1) {
> +		domain->geometry.aperture_start = ~0UL << ias;
> +		domain->geometry.aperture_end = ~0UL;
> +	} else {
> +		domain->geometry.aperture_end = (1UL << ias) - 1;
> +	}
> +
>  	domain->geometry.force_aperture = true;
>  
>  	/* Initialise the context bank with our page table cfg */
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm/arm-smmu/arm-smmu.h
> index 83294516ac08..f3e456893f28 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
> @@ -169,10 +169,12 @@ enum arm_smmu_cbar_type {
>  #define ARM_SMMU_CB_TCR			0x30
>  #define ARM_SMMU_TCR_EAE		BIT(31)
>  #define ARM_SMMU_TCR_EPD1		BIT(23)
> +#define ARM_SMMU_TCR_A1			BIT(22)
>  #define ARM_SMMU_TCR_TG0		GENMASK(15, 14)
>  #define ARM_SMMU_TCR_SH0		GENMASK(13, 12)
>  #define ARM_SMMU_TCR_ORGN0		GENMASK(11, 10)
>  #define ARM_SMMU_TCR_IRGN0		GENMASK(9, 8)
> +#define ARM_SMMU_TCR_EPD0		BIT(7)
>  #define ARM_SMMU_TCR_T0SZ		GENMASK(5, 0)
>  
>  #define ARM_SMMU_VTCR_RES1		BIT(31)
> @@ -350,12 +352,23 @@ struct arm_smmu_domain {
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
> +	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_TTBR1) {
> +		tcr = (tcr << 16) & ~ARM_SMMU_TCR_A1;
> +		tcr |= ARM_SMMU_TCR_EPD0;
> +	} else
> +		tcr |= ARM_SMMU_TCR_EPD1;
> +
> +	return tcr;
>  }
>  
>  static inline u32 arm_smmu_lpae_tcr2(struct io_pgtable_cfg *cfg)
> -- 
> 2.26.2
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
