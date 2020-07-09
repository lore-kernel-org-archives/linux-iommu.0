Return-Path: <SRS0=szPT=AU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F32EAC433E0
	for <iommu@archiver.kernel.org>; Thu,  9 Jul 2020 16:17:58 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF25B2078B
	for <iommu@archiver.kernel.org>; Thu,  9 Jul 2020 16:17:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n3wS0iGz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF25B2078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 586D786BAD;
	Thu,  9 Jul 2020 16:17:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7RgixJyuWmI2; Thu,  9 Jul 2020 16:17:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7905386A5D;
	Thu,  9 Jul 2020 16:17:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5DC32C0865;
	Thu,  9 Jul 2020 16:17:31 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6EC65C016F
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jul 2020 16:17:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 96040895FC
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jul 2020 16:17:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yep3LNVigrer for <iommu@lists.linux-foundation.org>;
 Thu,  9 Jul 2020 16:17:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com
 [209.85.208.68])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 8C39788515
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jul 2020 16:17:12 +0000 (UTC)
Received: by mail-ed1-f68.google.com with SMTP id n2so2296051edr.5
 for <iommu@lists.linux-foundation.org>; Thu, 09 Jul 2020 09:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=PbZTITmKTO9v4/Yy5DRRIZvAYJtU4hHDRKc55yhoFy4=;
 b=n3wS0iGzZ+3YDjJV1K5llsijCzKsYTst8VuFIEVvZOSavY1U74imu45mEgZlSakZf4
 WPMJYVU/0tUHeJI3M2J3pGB9N9I0H/aWlu4TC3GOoAmF1NMT3dbJiX+p67oqmwRKay3O
 rRhCmZU9Ek/IOFhh4gljW512FIRCzsVu0P0yGrBxP2tJZuj3RJtcUN8slT8VL3/PRwOr
 oCk+66SFbGZUkpjpXBrLDGG3gSQrv4VNLRiE7fUMK12wfZVibjY4XmW7JXJm2YxSxfy7
 78A2ckUJ3hQUx7LFW2vusyS+D+99aRqGihxtgozQebu7h6jbQ+dlYEMptlp+nE7Rbtbn
 hCrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PbZTITmKTO9v4/Yy5DRRIZvAYJtU4hHDRKc55yhoFy4=;
 b=qs6XoQjhVtzGVuk2oVzZyZxoxoIQZX5J/kqbyC2Eb7y4MIFxYtDv7oZoAondq3EZvG
 w6U2LbzbikSQNuXNI6g2jjCcEv3+AOJ3HeRe3lRzETJzylqz3WC8lm2Rrs1SxTG9rKZp
 lnh99TXMWqU0vWZ9Dqx8w5Jvxi1fKK/s75MkaWcPZv3v7f2uE+DAiXn1lSukj5sScwXo
 cWLYdWy7GL7SXJuxOBIp5HRVAFjAVJHJMZRoK/vGizX3BerAmFYG+ijcoPym1S3lmmmi
 SlrUwaJ/xAkYNnwunl/7T6+f7SNSb0N9UZx6cbRR0y9PWJNzr361i0BVJCSyPmNNDHwM
 a1mA==
X-Gm-Message-State: AOAM531ZvQKeB7/XYserVyQTQhDihdA1pK764IAdqH202d9n0Z9c2brR
 A3gOXwS5iIi7n+mWcjKJracvZ3AUzuANulOvcu4=
X-Google-Smtp-Source: ABdhPJxyxniiEqOkIUEv4MnLELcL6+agHSgEU06T0R8qfHUOr7BcZLOmDEYtKyWKxCrm4Pm5IgGcCEQKfeInQQacQDs=
X-Received: by 2002:a50:f392:: with SMTP id g18mr49995614edm.151.1594311430652; 
 Thu, 09 Jul 2020 09:17:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200709050145.3520931-1-bjorn.andersson@linaro.org>
 <20200709050145.3520931-3-bjorn.andersson@linaro.org>
In-Reply-To: <20200709050145.3520931-3-bjorn.andersson@linaro.org>
From: Rob Clark <robdclark@gmail.com>
Date: Thu, 9 Jul 2020 09:17:42 -0700
Message-ID: <CAF6AEGugJYmMpeH_9mWXcegq1awzraUzBTa0S1Rqcr3=Bmk0uQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] iommu/arm-smmu: Emulate bypass by using context banks
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Jonathan Marek <jonathan@marek.ca>, Will Deacon <will@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
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

On Wed, Jul 8, 2020 at 10:01 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> Some firmware found on various Qualcomm platforms traps writes to S2CR
> of type BYPASS and writes FAULT into the register. This prevents us from
> marking the streams for the display controller as BYPASS to allow
> continued scanout of the screen through the initialization of the ARM
> SMMU.
>
> This adds a Qualcomm specific cfg_probe function, which probes the
> behavior of the S2CR registers and if found faulty enables the related
> quirk. Based on this quirk context banks are allocated for IDENTITY
> domains as well, but with ARM_SMMU_SCTLR_M omitted.
>
> The result is valid stream mappings, without translation.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  drivers/iommu/arm-smmu-qcom.c | 21 +++++++++++++++++++++
>  drivers/iommu/arm-smmu.c      | 14 ++++++++++++--
>  drivers/iommu/arm-smmu.h      |  3 +++
>  3 files changed, 36 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iommu/arm-smmu-qcom.c b/drivers/iommu/arm-smmu-qcom.c
> index cf01d0215a39..e8a36054e912 100644
> --- a/drivers/iommu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm-smmu-qcom.c
> @@ -23,6 +23,26 @@ static const struct of_device_id qcom_smmu_client_of_match[] = {
>         { }
>  };
>
> +static int qcom_smmu_cfg_probe(struct arm_smmu_device *smmu)
> +{
> +       unsigned int last_s2cr = ARM_SMMU_GR0_S2CR(smmu->num_mapping_groups - 1);
> +       u32 reg;
> +
> +       /*
> +        * With some firmware writes to S2CR of type FAULT are ignored, and
> +        * writing BYPASS will end up as FAULT in the register. Perform a write
> +        * to S2CR to detect if this is the case with the current firmware.
> +        */
> +       arm_smmu_gr0_write(smmu, last_s2cr, FIELD_PREP(ARM_SMMU_S2CR_TYPE, S2CR_TYPE_BYPASS) |
> +                                           FIELD_PREP(ARM_SMMU_S2CR_CBNDX, 0xff) |
> +                                           FIELD_PREP(ARM_SMMU_S2CR_PRIVCFG, S2CR_PRIVCFG_DEFAULT));
> +       reg = arm_smmu_gr0_read(smmu, last_s2cr);
> +       if (FIELD_GET(ARM_SMMU_S2CR_TYPE, reg) != S2CR_TYPE_BYPASS)
> +               smmu->qcom_bypass_quirk = true;
> +
> +       return 0;
> +}
> +
>  static int qcom_smmu_def_domain_type(struct device *dev)
>  {
>         const struct of_device_id *match =
> @@ -61,6 +81,7 @@ static int qcom_smmu500_reset(struct arm_smmu_device *smmu)
>  }
>
>  static const struct arm_smmu_impl qcom_smmu_impl = {
> +       .cfg_probe = qcom_smmu_cfg_probe,
>         .def_domain_type = qcom_smmu_def_domain_type,
>         .reset = qcom_smmu500_reset,
>  };
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 2e27cf9815ab..f33eda3117fa 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -654,7 +654,9 @@ static void arm_smmu_write_context_bank(struct arm_smmu_device *smmu, int idx)
>
>         /* SCTLR */
>         reg = ARM_SMMU_SCTLR_CFIE | ARM_SMMU_SCTLR_CFRE | ARM_SMMU_SCTLR_AFE |
> -             ARM_SMMU_SCTLR_TRE | ARM_SMMU_SCTLR_M;
> +             ARM_SMMU_SCTLR_TRE;
> +       if (cfg->m)
> +               reg |= ARM_SMMU_SCTLR_M;
>         if (stage1)
>                 reg |= ARM_SMMU_SCTLR_S1_ASIDPNE;
>         if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN))
> @@ -678,7 +680,11 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
>         if (smmu_domain->smmu)
>                 goto out_unlock;
>
> -       if (domain->type == IOMMU_DOMAIN_IDENTITY) {
> +       /*
> +        * Nothing to do for IDENTITY domains,unless disabled context banks are
> +        * used to emulate bypass mappings on Qualcomm platforms.
> +        */
> +       if (domain->type == IOMMU_DOMAIN_IDENTITY && !smmu->qcom_bypass_quirk) {

maybe I'm overlooking something, but I think this would put us back to
allocating pgtables (and making iommu->map/unmap() no longer no-ops),
which I don't think we want

BR,
-R

>                 smmu_domain->stage = ARM_SMMU_DOMAIN_BYPASS;
>                 smmu_domain->smmu = smmu;
>                 goto out_unlock;
> @@ -826,6 +832,10 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
>         domain->geometry.aperture_end = (1UL << ias) - 1;
>         domain->geometry.force_aperture = true;
>
> +       /* Enable translation for non-identity context banks */
> +       if (domain->type != IOMMU_DOMAIN_IDENTITY)
> +               cfg->m = true;
> +
>         /* Initialise the context bank with our page table cfg */
>         arm_smmu_init_context_bank(smmu_domain, &pgtbl_cfg);
>         arm_smmu_write_context_bank(smmu, cfg->cbndx);
> diff --git a/drivers/iommu/arm-smmu.h b/drivers/iommu/arm-smmu.h
> index d172c024be61..a71d193073e4 100644
> --- a/drivers/iommu/arm-smmu.h
> +++ b/drivers/iommu/arm-smmu.h
> @@ -305,6 +305,8 @@ struct arm_smmu_device {
>
>         /* IOMMU core code handle */
>         struct iommu_device             iommu;
> +
> +       bool                            qcom_bypass_quirk;
>  };
>
>  enum arm_smmu_context_fmt {
> @@ -323,6 +325,7 @@ struct arm_smmu_cfg {
>         };
>         enum arm_smmu_cbar_type         cbar;
>         enum arm_smmu_context_fmt       fmt;
> +       bool                            m;
>  };
>  #define ARM_SMMU_INVALID_IRPTNDX       0xff
>
> --
> 2.26.2
>
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
