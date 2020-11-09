Return-Path: <SRS0=JucZ=EP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96998C2D0A3
	for <iommu@archiver.kernel.org>; Mon,  9 Nov 2020 23:13:20 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F13812074F
	for <iommu@archiver.kernel.org>; Mon,  9 Nov 2020 23:13:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zjl3lSMl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F13812074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 6BBCE2202C;
	Mon,  9 Nov 2020 23:13:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jbe3Is6C1JYr; Mon,  9 Nov 2020 23:13:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id E7CA020453;
	Mon,  9 Nov 2020 23:13:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B1040C0889;
	Mon,  9 Nov 2020 23:13:17 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E4C68C016F
 for <iommu@lists.linux-foundation.org>; Mon,  9 Nov 2020 23:13:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id C899320457
 for <iommu@lists.linux-foundation.org>; Mon,  9 Nov 2020 23:13:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zz7ruaWRU9Ss for <iommu@lists.linux-foundation.org>;
 Mon,  9 Nov 2020 23:13:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
 [209.85.221.66])
 by silver.osuosl.org (Postfix) with ESMTPS id 04CFD20453
 for <iommu@lists.linux-foundation.org>; Mon,  9 Nov 2020 23:13:15 +0000 (UTC)
Received: by mail-wr1-f66.google.com with SMTP id w1so10660407wrm.4
 for <iommu@lists.linux-foundation.org>; Mon, 09 Nov 2020 15:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SzyzIFUHACGGtEjbEi3vs8mJQQfV5+rYDswxbA8M/m4=;
 b=Zjl3lSMlwvvESHqMfFzS+5eQN59OuHO9r0r30lNuvJpzf7i83Mm6Ss9krJTnqvrZgf
 5Yh9988oL1MM0Vtur483IGqsb1mkCuD2645+EA1T9BCcrn08BWP9hsQCHsQu1cvw1Nbx
 FoF6RKP2xksNAxT3yctHue3woWJ1pdsZlZgZPnAYYLLVkIS3HimuI2vNkEzxPMeHJZM0
 lxfwM/l98Kky/qzRs2FLGkBIM3AowfWiXV8SPDJb5pRP3rTBHrblC/hdc4mkQdAyn7HY
 GQVmWFdbtfwbprbHg/LL9IOJiKRmB/M7RR44cLsn0UwD9gGQg4xFQt/dpONb5RLt8Ngq
 D1ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SzyzIFUHACGGtEjbEi3vs8mJQQfV5+rYDswxbA8M/m4=;
 b=kCMOXqeXt39coKkHSwubdqpCq08vk9YC5rfXmznJy5NsExD40MtNv7iWbtaKBow06l
 ayq7gkUMkYAsyRC7k4RtTaBrsg9LbzWQKkh3BvzWKjIGoGg6H73jiDHzyd8ftPIWzVk2
 ViILd6XkRMQtkCsR61xaJG00Qyy+syGBWEQCHdOBLWkH+HMXLh4p8qoK7ftwxOPK6OTT
 AHlPq0VUfBEohYE3n+YaTKeQ3yGtfnnjh34eMcJbeeYHO3+3keWCpG3N1xFEidaMQB5N
 GYT5nSqYoFv6aZH1dVH8+djQKBEVjCb8xLNTzqz4x2zHYC7Qi5DWzDcd9oH5awy9yErk
 P9Jg==
X-Gm-Message-State: AOAM531Qe3y2Qesb1UXYj5cb+ppV9wltrd+MODU3MgfJzZOgaaQz2brO
 hhyiPp9QOIMButiq+Hz5VbmEXHfOU8J6Dd2fQrA=
X-Google-Smtp-Source: ABdhPJyT6A9cKehZWb10KrnBie1nNYFDIpBin6H4BfNw8lMRDh4wdHe62j3D8Lt/Wi97awQK5IviqbABQnlhm14zshQ=
X-Received: by 2002:adf:a54d:: with SMTP id j13mr17227610wrb.132.1604963593350; 
 Mon, 09 Nov 2020 15:13:13 -0800 (PST)
MIME-Version: 1.0
References: <20201109222319.2630557-1-jcrouse@codeaurora.org>
 <20201109222319.2630557-3-jcrouse@codeaurora.org>
In-Reply-To: <20201109222319.2630557-3-jcrouse@codeaurora.org>
From: Rob Clark <robdclark@gmail.com>
Date: Mon, 9 Nov 2020 15:13:01 -0800
Message-ID: <CAF6AEGv19=+3gc1KnYrzmLBs--7P7BFhjmV1Qg_9N10299Qg2g@mail.gmail.com>
Subject: Re: [RFC PATCH v1 2/3] drm/msm: Add an adreno-smmu-priv callback to
 get pagefault info
To: Jordan Crouse <jcrouse@codeaurora.org>
Cc: Rob Clark <robdclark@chromium.org>, Will Deacon <will@kernel.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
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

On Mon, Nov 9, 2020 at 2:23 PM Jordan Crouse <jcrouse@codeaurora.org> wrote:
>
> Add a callback in adreno-smmu-priv to read interesting SMMU
> registers to provide an opportunity for a richer debug experience
> in the GPU driver.
>
> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> ---
>
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 19 +++++++++++++
>  drivers/iommu/arm/arm-smmu/arm-smmu.h      |  2 ++
>  include/linux/adreno-smmu-priv.h           | 31 +++++++++++++++++++++-
>  3 files changed, 51 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> index d0636c803a36..367a267324a2 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -32,6 +32,24 @@ static void qcom_adreno_smmu_write_sctlr(struct arm_smmu_device *smmu, int idx,
>         arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_SCTLR, reg);
>  }
>
> +static void qcom_adreno_smmu_get_fault_info(const void *cookie,
> +               struct adreno_smmu_fault_info *info)
> +{
> +       struct arm_smmu_domain *smmu_domain = (void *)cookie;
> +       struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
> +       struct arm_smmu_device *smmu = smmu_domain->smmu;
> +
> +       info->fsr = arm_smmu_cb_read(smmu, cfg->cbndx, ARM_SMMU_CB_FSR);
> +       /* FIXME: return error here if we aren't really in a fault? */
> +
> +       info->fsynr0 = arm_smmu_cb_read(smmu, cfg->cbndx, ARM_SMMU_CB_FSYNR0);
> +       info->fsynr1 = arm_smmu_cb_read(smmu, cfg->cbndx, ARM_SMMU_CB_FSYNR1);
> +       info->far = arm_smmu_cb_readq(smmu, cfg->cbndx, ARM_SMMU_CB_FAR);
> +       info->cbfrsynra = arm_smmu_gr1_read(smmu, ARM_SMMU_GR1_CBFRSYNRA(cfg->cbndx));
> +       info->ttbr0 = arm_smmu_cb_read(smmu, cfg->cbndx, ARM_SMMU_CB_TTBR0);
> +       info->contextidr = arm_smmu_cb_read(smmu, cfg->cbndx, ARM_SMMU_CB_CONTEXTIDR);
> +}
> +
>  #define QCOM_ADRENO_SMMU_GPU_SID 0
>
>  static bool qcom_adreno_smmu_is_gpu_device(struct device *dev)
> @@ -156,6 +174,7 @@ static int qcom_adreno_smmu_init_context(struct arm_smmu_domain *smmu_domain,
>         priv->cookie = smmu_domain;
>         priv->get_ttbr1_cfg = qcom_adreno_smmu_get_ttbr1_cfg;
>         priv->set_ttbr0_cfg = qcom_adreno_smmu_set_ttbr0_cfg;
> +       priv->get_fault_info = qcom_adreno_smmu_get_fault_info;
>
>         return 0;
>  }
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm/arm-smmu/arm-smmu.h
> index 04288b6fc619..fe511540a6bf 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
> @@ -224,6 +224,8 @@ enum arm_smmu_cbar_type {
>  #define ARM_SMMU_CB_FSYNR0             0x68
>  #define ARM_SMMU_FSYNR0_WNR            BIT(4)
>
> +#define ARM_SMMU_CB_FSYNR1             0x6c
> +
>  #define ARM_SMMU_CB_S1_TLBIVA          0x600
>  #define ARM_SMMU_CB_S1_TLBIASID                0x610
>  #define ARM_SMMU_CB_S1_TLBIVAL         0x620
> diff --git a/include/linux/adreno-smmu-priv.h b/include/linux/adreno-smmu-priv.h
> index a889f28afb42..fc2592ebb9ba 100644
> --- a/include/linux/adreno-smmu-priv.h
> +++ b/include/linux/adreno-smmu-priv.h
> @@ -8,6 +8,32 @@
>
>  #include <linux/io-pgtable.h>
>
> +/**
> + * struct adreno_smmu_fault_info - container for key fault information
> + *
> + * @far: The faulting IOVA from ARM_SMMU_CB_FAR
> + * @ttbr0: The current TTBR0 pagetable from ARM_SMMU_CB_TTBR0
> + * @contextidr: The value of ARM_SMMU_CB_CONTEXTIDR
> + * @fsr: The fault status from ARM_SMMU_CB_FSR
> + * @fsynr0: The value of FSYNR0 from ARM_SMMU_CB_FSYNR0
> + * @fsynr1: The value of FSYNR1 from ARM_SMMU_CB_FSYNR0
> + * @cbfrsynra: The value of CBFRSYNRA from ARM_SMMU_GR1_CBFRSYNRA(idx)
> + *
> + * This struct passes back key page fault information to the GPU driver
> + * through the get_fault_info function pointer.
> + * The GPU driver can use this information to print informative
> + * log messages and provide deeper GPU specific insight into the fault.
> + */
> +struct adreno_smmu_fault_info {
> +       u64 far;
> +       u64 ttbr0;
> +       u32 contextidr;
> +       u32 fsr;
> +       u32 fsynr0;
> +       u32 fsynr1;
> +       u32 cbfrsynra;
> +};
> +
>  /**
>   * struct adreno_smmu_priv - private interface between adreno-smmu and GPU
>   *
> @@ -17,6 +43,8 @@
>   * @set_ttbr0_cfg: Set the TTBR0 config for the GPUs context bank.  A
>   *                 NULL config disables TTBR0 translation, otherwise
>   *                 TTBR0 translation is enabled with the specified cfg
> + * @get_fault_info: Call a helper function in the GPU driver to process a
> + *                 pagefault

This description isn't quite right, since it is call*ed* by the GPU
driver.  (And the helper aspect is irrelivant to the adreno/smmu
private interface).  Maybe something like:

"Called by the GPU driver fault handler to retrieve information about
a pagefault"

?

BR,
-R

>   *
>   * The GPU driver (drm/msm) and adreno-smmu work together for controlling
>   * the GPU's SMMU instance.  This is by necessity, as the GPU is directly
> @@ -31,6 +59,7 @@ struct adreno_smmu_priv {
>      const void *cookie;
>      const struct io_pgtable_cfg *(*get_ttbr1_cfg)(const void *cookie);
>      int (*set_ttbr0_cfg)(const void *cookie, const struct io_pgtable_cfg *cfg);
> +    void (*get_fault_info)(const void *cookie, struct adreno_smmu_fault_info *info);
>  };
>
> -#endif /* __ADRENO_SMMU_PRIV_H */
> \ No newline at end of file
> +#endif /* __ADRENO_SMMU_PRIV_H */
> --
> 2.25.1
>
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
