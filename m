Return-Path: <SRS0=Yw80=4G=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F059C34026
	for <iommu@archiver.kernel.org>; Tue, 18 Feb 2020 18:41:15 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 467372464E
	for <iommu@archiver.kernel.org>; Tue, 18 Feb 2020 18:41:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="WLfHTRyw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 467372464E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3438F86096;
	Tue, 18 Feb 2020 18:41:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q3v6x5Sm7ARp; Tue, 18 Feb 2020 18:41:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5F657853E6;
	Tue, 18 Feb 2020 18:41:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 498DFC1D84;
	Tue, 18 Feb 2020 18:41:14 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B1859C013E
 for <iommu@lists.linux-foundation.org>; Tue, 18 Feb 2020 18:41:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 9DFD18557B
 for <iommu@lists.linux-foundation.org>; Tue, 18 Feb 2020 18:41:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Df2vskBes1wT for <iommu@lists.linux-foundation.org>;
 Tue, 18 Feb 2020 18:41:11 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail27.static.mailgun.info (mail27.static.mailgun.info
 [104.130.122.27])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 7A3DE8550D
 for <iommu@lists.linux-foundation.org>; Tue, 18 Feb 2020 18:41:11 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1582051271; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=EvQfb4KB0Yt3g3r/UGv9gwTSbjpcLofIpVM7Lm1Z4Z4=;
 b=WLfHTRywMjIPEGx8UiOCIw1VSx86kyn35ORP1gI5VO/f4Jo0JiChqHJwRSSs0QPgHhZ1ziFF
 HRxEMbsDv2YpuPSmwW33/61Qaz7A8EZpkY1xzhiV3rfOnwOMxK4Y9NUOxZY9wvP9R8tFXr6z
 UutPo6m2jiyxJADMdU+fmgw/GBo=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e4c2fc6.7f8a9af89b20-smtp-out-n02;
 Tue, 18 Feb 2020 18:41:10 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 3262AC4479F; Tue, 18 Feb 2020 18:41:09 +0000 (UTC)
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: jcrouse)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 898CBC43383;
 Tue, 18 Feb 2020 18:41:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 898CBC43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=none smtp.mailfrom=jcrouse@codeaurora.org
Date: Tue, 18 Feb 2020 11:41:05 -0700
From: Jordan Crouse <jcrouse@codeaurora.org>
To: Rob Clark <robdclark@gmail.com>
Subject: Re: [RFC PATCH v1] iommu/arm-smmu: Allow domains to choose a context
 bank
Message-ID: <20200218184103.GA15947@jcrouse1-lnx.qualcomm.com>
Mail-Followup-To: Rob Clark <robdclark@gmail.com>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>, 
 Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, 
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>
References: <1580250823-30739-1-git-send-email-jcrouse@codeaurora.org>
 <CAF6AEGvQyaZL8iSKkzTZ-X4nqXWcyO6RBf-pUfOZFg0w52BGUA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAF6AEGvQyaZL8iSKkzTZ-X4nqXWcyO6RBf-pUfOZFg0w52BGUA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
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

On Tue, Feb 18, 2020 at 10:19:53AM -0800, Rob Clark wrote:
> On Tue, Jan 28, 2020 at 2:34 PM Jordan Crouse <jcrouse@codeaurora.org> wrote:
> >
> > Domains which are being set up for split pagetables usually want to be
> > on a specific context bank for hardware reasons. Force the context
> > bank for domains with the split-pagetable quirk to context bank 0.
> > If context bank 0 is taken, move that context bank to another unused
> > bank and rewrite the stream matching registers accordingly.
> 
> Is the only reason for dealing with the case that bank 0 is already in
> use, due to the DMA domain that gets setup before driver probes?

Right. On Adreno GPUs only one context bank at a time is accessible from the
GPU through an aperture which defaults to context bank 0 and as you might
expect, the aperture controls are protected by the secure world on AC enabled
targets.

Some of the newer targets have a SCM call to switch the aperture but for all the
currently merged platforms we are forced to use context bank 0.

> I'm kinda thinking that we need to invent a way to unwind/detatch the
> DMA domain, and unhook the iommu-dmaops, since this seems to already
> be already causing problems with dma-bufs imported from other drivers
> (who expect that dma_map_*(), with the importing device's dev ptr,
> will do something sane.

That could work, assuming that we could guarantee that our new replacement
domain got the context bank we wanted.

Jordan

> >
> > This is be used by [1] and [2] to leave context bank 0 open so that
> > the Adreno GPU can program it.
> >
> > [1] https://lists.linuxfoundation.org/pipermail/iommu/2020-January/041438.html
> > [2] https://lists.linuxfoundation.org/pipermail/iommu/2020-January/041444.html
> >
> > Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> > ---
> >
> >  drivers/iommu/arm-smmu.c | 63 +++++++++++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 59 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> > index 85a6773..799a254 100644
> > --- a/drivers/iommu/arm-smmu.c
> > +++ b/drivers/iommu/arm-smmu.c
> > @@ -254,6 +254,43 @@ static int __arm_smmu_alloc_bitmap(unsigned long *map, int start, int end)
> >         return idx;
> >  }
> >
> > +static void arm_smmu_write_s2cr(struct arm_smmu_device *smmu, int idx);
> > +
> > +static int __arm_smmu_alloc_cb(struct arm_smmu_device *smmu, int start,
> > +               int target)
> > +{
> > +       int new, i;
> > +
> > +       /* Allocate a new context bank id */
> > +       new = __arm_smmu_alloc_bitmap(smmu->context_map, start,
> > +               smmu->num_context_banks);
> > +
> > +       if (new < 0)
> > +               return new;
> > +
> > +       /* If no target is set or we actually got the bank index we wanted */
> > +       if (target == -1 || new == target)
> > +               return new;
> > +
> > +       /* Copy the context configuration to the new index */
> > +       memcpy(&smmu->cbs[new], &smmu->cbs[target], sizeof(*smmu->cbs));
> > +       smmu->cbs[new].cfg->cbndx = new;
> > +
> > +       /* FIXME: Do we need locking here? */
> > +       for (i = 0; i < smmu->num_mapping_groups; i++) {
> > +               if (smmu->s2crs[i].cbndx == target) {
> > +                       smmu->s2crs[i].cbndx = new;
> > +                       arm_smmu_write_s2cr(smmu, i);
> > +               }
> > +       }
> > +
> > +       /*
> > +        * FIXME: Does getting here imply that 'target' is already set in the
> > +        * context_map?
> > +        */
> > +       return target;
> > +}
> > +
> >  static void __arm_smmu_free_bitmap(unsigned long *map, int idx)
> >  {
> >         clear_bit(idx, map);
> > @@ -770,6 +807,7 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
> >         struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
> >         struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
> >         unsigned long quirks = 0;
> > +       int forcecb = -1;
> >
> >         mutex_lock(&smmu_domain->init_mutex);
> >         if (smmu_domain->smmu)
> > @@ -844,8 +882,25 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
> >                          * SEP_UPSTREAM so we don't need to reduce the size of
> >                          * the ias to account for the sign extension bit
> >                          */
> > -                       if (smmu_domain->split_pagetables)
> > -                               quirks |= IO_PGTABLE_QUIRK_ARM_TTBR1;
> > +                       if (smmu_domain->split_pagetables) {
> > +                               /*
> > +                                * If split pagetables are enabled, assume that
> > +                                * the user's intent is to use per-instance
> > +                                * pagetables which, at least on a QCOM target,
> > +                                * means that this domain should be on context
> > +                                * bank 0.
> > +                                */
> > +
> > +                               /*
> > +                                * If we can't force to context bank 0 then
> > +                                * don't bother enabling split pagetables which
> > +                                * then would not allow aux domains
> > +                                */
> > +                               if (start == 0) {
> > +                                       forcecb = 0;
> > +                                       quirks |= IO_PGTABLE_QUIRK_ARM_TTBR1;
> > +                               }
> > +                       }
> >                 } else if (cfg->fmt == ARM_SMMU_CTX_FMT_AARCH32_L) {
> >                         fmt = ARM_32_LPAE_S1;
> >                         ias = min(ias, 32UL);
> > @@ -883,8 +938,8 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
> >                 ret = -EINVAL;
> >                 goto out_unlock;
> >         }
> > -       ret = __arm_smmu_alloc_bitmap(smmu->context_map, start,
> > -                                     smmu->num_context_banks);
> > +
> > +       ret = __arm_smmu_alloc_cb(smmu, start, forcecb);
> >         if (ret < 0)
> >                 goto out_unlock;
> >
> > --
> > 2.7.4

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
