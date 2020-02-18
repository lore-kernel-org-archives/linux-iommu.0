Return-Path: <SRS0=Yw80=4G=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2431C34047
	for <iommu@archiver.kernel.org>; Tue, 18 Feb 2020 18:20:10 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9847224654
	for <iommu@archiver.kernel.org>; Tue, 18 Feb 2020 18:20:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FyQYrjqy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9847224654
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6EF19875DA;
	Tue, 18 Feb 2020 18:20:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TsZ1l6i+p1MW; Tue, 18 Feb 2020 18:20:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6B190875CB;
	Tue, 18 Feb 2020 18:20:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4A913C1D84;
	Tue, 18 Feb 2020 18:20:09 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B6B27C013E
 for <iommu@lists.linux-foundation.org>; Tue, 18 Feb 2020 18:20:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id A05ED85495
 for <iommu@lists.linux-foundation.org>; Tue, 18 Feb 2020 18:20:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9T4P5LQx__lA for <iommu@lists.linux-foundation.org>;
 Tue, 18 Feb 2020 18:20:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com
 [209.85.208.66])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id AAE5284DFD
 for <iommu@lists.linux-foundation.org>; Tue, 18 Feb 2020 18:20:06 +0000 (UTC)
Received: by mail-ed1-f66.google.com with SMTP id r21so25933641edq.0
 for <iommu@lists.linux-foundation.org>; Tue, 18 Feb 2020 10:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mFpfQMXDcTILM8p6YZkURH/PZ0c/a3Gt7zfwkgA7PZs=;
 b=FyQYrjqyqb21kEEx3w3LXCyRBFAjASj6lCrAa3Ha+O7l5IiRL4jnoXo9NxDLjeI1Qs
 /rixHYxVJqzcG6EaiGZlVDUT3PnahWrZo4/UNYcvlHOYuYVRSJW83E+s1TnxiZaKjhHn
 GJkStXXOTWn58ayGW+UHNKwFf0spIqZ3hneJwUUV+KH1x2PvQtdiiZthkgyFko00OOLg
 sKXcC3L9KNviP+tq9VthA5TzyV843P2Ns+W+aCXfgeuXIzMChZgeJxp6+piIEJ0usF7L
 HcjePpSCEeRIyJ9IIC0lM2HUSsoqhVt4yrm1wUN17ZZLt5lPLG9REEOxNyuTE4HvXfpN
 yIoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mFpfQMXDcTILM8p6YZkURH/PZ0c/a3Gt7zfwkgA7PZs=;
 b=Oji3/vHcxcIz4p+G/QKOWFOoOzSsF3pGGLzgLIMGjSTzAkdfZCQclfy0Iap/fAo9At
 f60vMdOMRPS881jZoZgXgAmBS067LDWxwPTcubYeTjfiDFhO/qMgtVP45Y7reKpgKDac
 G/MCWeLX4v0orFDPznQrwnzGcyamMelhZmDS4aPjsucEEUM5NxvLNcfDKOr5qfpejmVS
 YRdvjCPo77MqKE+xTt2Gq/OKYHYf0Wcx3ia8SziBGsOA9G16zQMOFaLihkBR1gROeRwq
 G2kbUEi0aQ/fDIE+OQomRW6OHwiQDTjsenY4VbDAvi3/G8LJt3mNDx1x+58Alb+2IUjZ
 +jUw==
X-Gm-Message-State: APjAAAXyji5DZ1yZmPx65duXSt9dCjwGlD9ggS7pjC/reALViljMvgdO
 ZTVkl5SUTvLyrknXoxtHGTghGNIlcqHY8Hnw/PE=
X-Google-Smtp-Source: APXvYqwqURRrVtjZm03lW6XQA7ZhZaAg148HuuceB26Lz99GzgTJCZLN/lZNTR1RHx1cjra7vjc/E+IlK3Q/BY845lE=
X-Received: by 2002:a17:906:a44d:: with SMTP id
 cb13mr21055283ejb.258.1582050004828; 
 Tue, 18 Feb 2020 10:20:04 -0800 (PST)
MIME-Version: 1.0
References: <1580250823-30739-1-git-send-email-jcrouse@codeaurora.org>
In-Reply-To: <1580250823-30739-1-git-send-email-jcrouse@codeaurora.org>
From: Rob Clark <robdclark@gmail.com>
Date: Tue, 18 Feb 2020 10:19:53 -0800
Message-ID: <CAF6AEGvQyaZL8iSKkzTZ-X4nqXWcyO6RBf-pUfOZFg0w52BGUA@mail.gmail.com>
Subject: Re: [RFC PATCH v1] iommu/arm-smmu: Allow domains to choose a context
 bank
To: Jordan Crouse <jcrouse@codeaurora.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>, Will Deacon <will@kernel.org>,
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

On Tue, Jan 28, 2020 at 2:34 PM Jordan Crouse <jcrouse@codeaurora.org> wrote:
>
> Domains which are being set up for split pagetables usually want to be
> on a specific context bank for hardware reasons. Force the context
> bank for domains with the split-pagetable quirk to context bank 0.
> If context bank 0 is taken, move that context bank to another unused
> bank and rewrite the stream matching registers accordingly.

Is the only reason for dealing with the case that bank 0 is already in
use, due to the DMA domain that gets setup before driver probes?

I'm kinda thinking that we need to invent a way to unwind/detatch the
DMA domain, and unhook the iommu-dmaops, since this seems to already
be already causing problems with dma-bufs imported from other drivers
(who expect that dma_map_*(), with the importing device's dev ptr,
will do something sane.

BR,
-R

>
> This is be used by [1] and [2] to leave context bank 0 open so that
> the Adreno GPU can program it.
>
> [1] https://lists.linuxfoundation.org/pipermail/iommu/2020-January/041438.html
> [2] https://lists.linuxfoundation.org/pipermail/iommu/2020-January/041444.html
>
> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> ---
>
>  drivers/iommu/arm-smmu.c | 63 +++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 59 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 85a6773..799a254 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -254,6 +254,43 @@ static int __arm_smmu_alloc_bitmap(unsigned long *map, int start, int end)
>         return idx;
>  }
>
> +static void arm_smmu_write_s2cr(struct arm_smmu_device *smmu, int idx);
> +
> +static int __arm_smmu_alloc_cb(struct arm_smmu_device *smmu, int start,
> +               int target)
> +{
> +       int new, i;
> +
> +       /* Allocate a new context bank id */
> +       new = __arm_smmu_alloc_bitmap(smmu->context_map, start,
> +               smmu->num_context_banks);
> +
> +       if (new < 0)
> +               return new;
> +
> +       /* If no target is set or we actually got the bank index we wanted */
> +       if (target == -1 || new == target)
> +               return new;
> +
> +       /* Copy the context configuration to the new index */
> +       memcpy(&smmu->cbs[new], &smmu->cbs[target], sizeof(*smmu->cbs));
> +       smmu->cbs[new].cfg->cbndx = new;
> +
> +       /* FIXME: Do we need locking here? */
> +       for (i = 0; i < smmu->num_mapping_groups; i++) {
> +               if (smmu->s2crs[i].cbndx == target) {
> +                       smmu->s2crs[i].cbndx = new;
> +                       arm_smmu_write_s2cr(smmu, i);
> +               }
> +       }
> +
> +       /*
> +        * FIXME: Does getting here imply that 'target' is already set in the
> +        * context_map?
> +        */
> +       return target;
> +}
> +
>  static void __arm_smmu_free_bitmap(unsigned long *map, int idx)
>  {
>         clear_bit(idx, map);
> @@ -770,6 +807,7 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
>         struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
>         struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
>         unsigned long quirks = 0;
> +       int forcecb = -1;
>
>         mutex_lock(&smmu_domain->init_mutex);
>         if (smmu_domain->smmu)
> @@ -844,8 +882,25 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
>                          * SEP_UPSTREAM so we don't need to reduce the size of
>                          * the ias to account for the sign extension bit
>                          */
> -                       if (smmu_domain->split_pagetables)
> -                               quirks |= IO_PGTABLE_QUIRK_ARM_TTBR1;
> +                       if (smmu_domain->split_pagetables) {
> +                               /*
> +                                * If split pagetables are enabled, assume that
> +                                * the user's intent is to use per-instance
> +                                * pagetables which, at least on a QCOM target,
> +                                * means that this domain should be on context
> +                                * bank 0.
> +                                */
> +
> +                               /*
> +                                * If we can't force to context bank 0 then
> +                                * don't bother enabling split pagetables which
> +                                * then would not allow aux domains
> +                                */
> +                               if (start == 0) {
> +                                       forcecb = 0;
> +                                       quirks |= IO_PGTABLE_QUIRK_ARM_TTBR1;
> +                               }
> +                       }
>                 } else if (cfg->fmt == ARM_SMMU_CTX_FMT_AARCH32_L) {
>                         fmt = ARM_32_LPAE_S1;
>                         ias = min(ias, 32UL);
> @@ -883,8 +938,8 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
>                 ret = -EINVAL;
>                 goto out_unlock;
>         }
> -       ret = __arm_smmu_alloc_bitmap(smmu->context_map, start,
> -                                     smmu->num_context_banks);
> +
> +       ret = __arm_smmu_alloc_cb(smmu, start, forcecb);
>         if (ret < 0)
>                 goto out_unlock;
>
> --
> 2.7.4
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
