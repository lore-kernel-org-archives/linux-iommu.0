Return-Path: <SRS0=8rqH=AN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF19C433E1
	for <iommu@archiver.kernel.org>; Thu,  2 Jul 2020 20:22:11 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DC2020760
	for <iommu@archiver.kernel.org>; Thu,  2 Jul 2020 20:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A7yLVEUd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DC2020760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2E7B788CE7;
	Thu,  2 Jul 2020 20:22:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZpVvT1FsXuV5; Thu,  2 Jul 2020 20:22:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8646388CE2;
	Thu,  2 Jul 2020 20:22:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 68786C0890;
	Thu,  2 Jul 2020 20:22:10 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 97BE0C0733
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jul 2020 20:22:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 83F3487A68
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jul 2020 20:22:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3ad8zl4m-SbK for <iommu@lists.linux-foundation.org>;
 Thu,  2 Jul 2020 20:22:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com
 [209.85.208.68])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 8D83687A62
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jul 2020 20:22:07 +0000 (UTC)
Received: by mail-ed1-f68.google.com with SMTP id d15so25329648edm.10
 for <iommu@lists.linux-foundation.org>; Thu, 02 Jul 2020 13:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=LJqRalz8nhd1uucT/hW2AoacNEdXpfTo9tORErtQ+CY=;
 b=A7yLVEUdkzu0U9R4Gydu8ALB+orKv8jxKoFtu9XmVALASxtFPW+Va6LJ5qJhI72YNO
 9Xv4iYY5bNsUh4qm4m+LioK2uUta+u/jnJbYpH5humUCWvYsMBgJboDYhKhHZZUx+Y2t
 CDichgejEQLfWBWPDxoXBh4pejxijkeFbK9MuXnJAFs5KNJlHJCDWrK9c/h1hkSFn1Q4
 i5mh2FvofLz5G0TU14GFgd8kGAENZrFOlC0+nycGxTpVBcCABFThDjY47tWqwP7ogWZm
 0gGGJU4NXyM42SPgXXtcGIsWvfmWkLee6PiI8Na2c1rFNSlo/xXzsM8i1cmZ6bAwIOqg
 4fkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LJqRalz8nhd1uucT/hW2AoacNEdXpfTo9tORErtQ+CY=;
 b=cUJnwhAMBqZt4G8KhzAq9t2cS8IYBzpcn42F72qG7quLyTxdwwbGWK+DcekrudMW4F
 vwgyXumcgV3xWE9jSJQ8mFByMCclDan5DpHOrHameprWwhCMI8vi+TqrRjxxfrRzAuCN
 er4HPK1WDBPJuoTl5gvXHDdLdKsOuYoqebL61/zH+rQcuqtru2qwp7CRY5yhXinGMeH9
 7m8Kyw1mIN+0fPULRP4NbCNM3/B4pROo1cD1l8vIpe1WjLWntEqhJHdtXsY5oQZjnxjb
 jXnk5Go39I2T2xkUNxn37xv1fpxVmFSk3CpVAseXlcUZOFZEIvSEAt//odJhqVZuf4Xm
 3uaw==
X-Gm-Message-State: AOAM530qZ0RfKiBIDwAVZn4/V9clTSDo+AbuonIuzX1heCXVFsoUcK29
 e8GJomXO5cwOR+AjGdec3q1UfmN6jCmPGgkvo44=
X-Google-Smtp-Source: ABdhPJzZ45bUaTYoAMc4+7tytjU6jg5rAHFG6yHcGC5gt16WN/ceKbzpc4PdmYV+WosMNX1otFsQabXOGlQkVzfbrmw=
X-Received: by 2002:a50:f392:: with SMTP id g18mr14487895edm.151.1593721325980; 
 Thu, 02 Jul 2020 13:22:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200626200042.13713-1-jcrouse@codeaurora.org>
 <20200626200042.13713-3-jcrouse@codeaurora.org>
In-Reply-To: <20200626200042.13713-3-jcrouse@codeaurora.org>
From: Rob Clark <robdclark@gmail.com>
Date: Thu, 2 Jul 2020 13:22:36 -0700
Message-ID: <CAF6AEGuN6b5a0=Ava53vyv8E57=XCPBTZAjYrRNxtNv41VOp4Q@mail.gmail.com>
Subject: Re: [PATCH v9 2/7] iommu/arm-smmu: Add support for split pagetables
To: Jordan Crouse <jcrouse@codeaurora.org>
Cc: freedreno <freedreno@lists.freedesktop.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 John Stultz <john.stultz@linaro.org>, Will Deacon <will@kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
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

On Fri, Jun 26, 2020 at 1:01 PM Jordan Crouse <jcrouse@codeaurora.org> wrote:
>
> Enable TTBR1 for a context bank if IO_PGTABLE_QUIRK_ARM_TTBR1 is selected
> by the io-pgtable configuration.
>
> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> ---
>
>  drivers/iommu/arm-smmu.c | 21 ++++++++++++++++-----
>  drivers/iommu/arm-smmu.h | 25 +++++++++++++++++++------
>  2 files changed, 35 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 8a3a6c8c887a..048de2681670 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -555,11 +555,15 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain,
>                         cb->ttbr[0] = pgtbl_cfg->arm_v7s_cfg.ttbr;
>                         cb->ttbr[1] = 0;
>                 } else {
> -                       cb->ttbr[0] = pgtbl_cfg->arm_lpae_s1_cfg.ttbr;
> -                       cb->ttbr[0] |= FIELD_PREP(ARM_SMMU_TTBRn_ASID,
> -                                                 cfg->asid);
> +                       cb->ttbr[0] = FIELD_PREP(ARM_SMMU_TTBRn_ASID,
> +                               cfg->asid);
>                         cb->ttbr[1] = FIELD_PREP(ARM_SMMU_TTBRn_ASID,
> -                                                cfg->asid);
> +                               cfg->asid);

above looks like stray whitespace changes?

> +
> +                       if (pgtbl_cfg->quirks & IO_PGTABLE_QUIRK_ARM_TTBR1)
> +                               cb->ttbr[1] |= pgtbl_cfg->arm_lpae_s1_cfg.ttbr;
> +                       else
> +                               cb->ttbr[0] |= pgtbl_cfg->arm_lpae_s1_cfg.ttbr;
>                 }
>         } else {
>                 cb->ttbr[0] = pgtbl_cfg->arm_lpae_s2_cfg.vttbr;
> @@ -824,7 +828,14 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
>
>         /* Update the domain's page sizes to reflect the page table format */
>         domain->pgsize_bitmap = pgtbl_cfg.pgsize_bitmap;
> -       domain->geometry.aperture_end = (1UL << ias) - 1;
> +
> +       if (pgtbl_cfg.quirks & IO_PGTABLE_QUIRK_ARM_TTBR1) {
> +               domain->geometry.aperture_start = ~0UL << ias;
> +               domain->geometry.aperture_end = ~0UL;
> +       } else {
> +               domain->geometry.aperture_end = (1UL << ias) - 1;
> +       }
> +
>         domain->geometry.force_aperture = true;
>
>         /* Initialise the context bank with our page table cfg */
> diff --git a/drivers/iommu/arm-smmu.h b/drivers/iommu/arm-smmu.h
> index 38b041530a4f..5f2de20e883b 100644
> --- a/drivers/iommu/arm-smmu.h
> +++ b/drivers/iommu/arm-smmu.h
> @@ -168,10 +168,12 @@ enum arm_smmu_cbar_type {
>  #define ARM_SMMU_CB_TCR                        0x30
>  #define ARM_SMMU_TCR_EAE               BIT(31)
>  #define ARM_SMMU_TCR_EPD1              BIT(23)
> +#define ARM_SMMU_TCR_A1                        BIT(22)
>  #define ARM_SMMU_TCR_TG0               GENMASK(15, 14)
>  #define ARM_SMMU_TCR_SH0               GENMASK(13, 12)
>  #define ARM_SMMU_TCR_ORGN0             GENMASK(11, 10)
>  #define ARM_SMMU_TCR_IRGN0             GENMASK(9, 8)
> +#define ARM_SMMU_TCR_EPD0              BIT(7)
>  #define ARM_SMMU_TCR_T0SZ              GENMASK(5, 0)
>
>  #define ARM_SMMU_VTCR_RES1             BIT(31)
> @@ -347,12 +349,23 @@ struct arm_smmu_domain {
>
>  static inline u32 arm_smmu_lpae_tcr(struct io_pgtable_cfg *cfg)
>  {
> -       return ARM_SMMU_TCR_EPD1 |
> -              FIELD_PREP(ARM_SMMU_TCR_TG0, cfg->arm_lpae_s1_cfg.tcr.tg) |
> -              FIELD_PREP(ARM_SMMU_TCR_SH0, cfg->arm_lpae_s1_cfg.tcr.sh) |
> -              FIELD_PREP(ARM_SMMU_TCR_ORGN0, cfg->arm_lpae_s1_cfg.tcr.orgn) |
> -              FIELD_PREP(ARM_SMMU_TCR_IRGN0, cfg->arm_lpae_s1_cfg.tcr.irgn) |
> -              FIELD_PREP(ARM_SMMU_TCR_T0SZ, cfg->arm_lpae_s1_cfg.tcr.tsz);
> +       u32 tcr = FIELD_PREP(ARM_SMMU_TCR_TG0, cfg->arm_lpae_s1_cfg.tcr.tg) |
> +               FIELD_PREP(ARM_SMMU_TCR_SH0, cfg->arm_lpae_s1_cfg.tcr.sh) |
> +               FIELD_PREP(ARM_SMMU_TCR_ORGN0, cfg->arm_lpae_s1_cfg.tcr.orgn) |
> +               FIELD_PREP(ARM_SMMU_TCR_IRGN0, cfg->arm_lpae_s1_cfg.tcr.irgn) |
> +               FIELD_PREP(ARM_SMMU_TCR_T0SZ, cfg->arm_lpae_s1_cfg.tcr.tsz);
> +
> +       /*
> +       * When TTBR1 is selected shift the TCR fields by 16 bits and disable
> +       * translation in TTBR0
> +       */
> +       if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_TTBR1) {
> +               tcr = (tcr << 16) & ~ARM_SMMU_TCR_A1;
> +               tcr |= ARM_SMMU_TCR_EPD0;
> +       } else
> +               tcr |= ARM_SMMU_TCR_EPD1;

I'm not personally a fan of if/else ladders that mix {}'s, but
Will/Robin may have a different opinion

BR,
-R

> +
> +       return tcr;
>  }
>
>  static inline u32 arm_smmu_lpae_tcr2(struct io_pgtable_cfg *cfg)
> --
> 2.17.1
>
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
