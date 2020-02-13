Return-Path: <SRS0=ZJ+1=4B=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA1C6C352A3
	for <iommu@archiver.kernel.org>; Thu, 13 Feb 2020 21:50:10 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A57EB218AC
	for <iommu@archiver.kernel.org>; Thu, 13 Feb 2020 21:50:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="onDzsv+H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A57EB218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8E3BE8807A;
	Thu, 13 Feb 2020 21:50:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GtGXGU+foXM8; Thu, 13 Feb 2020 21:50:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id C86DD88049;
	Thu, 13 Feb 2020 21:50:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B6DDDC08A4;
	Thu, 13 Feb 2020 21:50:07 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D5845C0177
 for <iommu@lists.linux-foundation.org>; Thu, 13 Feb 2020 21:50:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id C413B8706B
 for <iommu@lists.linux-foundation.org>; Thu, 13 Feb 2020 21:50:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oOOev6eM1A3A for <iommu@lists.linux-foundation.org>;
 Thu, 13 Feb 2020 21:50:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 0354486FBB
 for <iommu@lists.linux-foundation.org>; Thu, 13 Feb 2020 21:50:04 +0000 (UTC)
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com
 [209.85.219.50])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id AA5A4217F4
 for <iommu@lists.linux-foundation.org>; Thu, 13 Feb 2020 21:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1581630603;
 bh=84yk1pvYO6JnX0O5s4/D9lH5XUgJjHH9Jztb4zMA7W4=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=onDzsv+HqQuPF63pQdyFRx6xIOVVtxR7SQQMyt37h4Kb3SH1aX9dJSzDcb+cEe8DE
 sqmN4vsU1Yy15KXr4HUm6J3t2tV6v0IHVDrkWIHLlcwNCRslKgXO2YMR5FeUjXmKxy
 tJXwLq5z0weGcY7Z1u0Ib9iYI96pVNPw80OljRJ4=
Received: by mail-qv1-f50.google.com with SMTP id dc14so3360376qvb.9
 for <iommu@lists.linux-foundation.org>; Thu, 13 Feb 2020 13:50:03 -0800 (PST)
X-Gm-Message-State: APjAAAVSuY7jlXD5yWO8RPwhUKAFYXrBFKBRQCJiB7xsc4kl3xetb43l
 v4TMbqT/dRFnfwJbsbywpRmV0LuVsYUbFIUW2A==
X-Google-Smtp-Source: APXvYqxm7mA40ANjHFkBEyDPsFFHgKRuAZvxYL3zQflVSS5U4tYdmv6XC8Ju2cdSy5DBQ45tg67qjr0m9+b+M9wmMmk=
X-Received: by 2002:a0c:f68f:: with SMTP id p15mr13009761qvn.79.1581630602716; 
 Thu, 13 Feb 2020 13:50:02 -0800 (PST)
MIME-Version: 1.0
References: <20200117211628.27888-1-robh@kernel.org>
 <2d04f201-3457-08ad-db8e-735f8315d74e@redhat.com>
 <7ac3f864-6c39-76e9-ee4a-21be03abc044@arm.com>
In-Reply-To: <7ac3f864-6c39-76e9-ee4a-21be03abc044@arm.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 13 Feb 2020 15:49:51 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJRSD-7U8UH1tevBdD2P6qPWzApQLpXU-SVBmZ8=Yiy0A@mail.gmail.com>
Message-ID: <CAL_JsqJRSD-7U8UH1tevBdD2P6qPWzApQLpXU-SVBmZ8=Yiy0A@mail.gmail.com>
Subject: Re: [PATCH v2] iommu/arm-smmu-v3: Add SMMUv3.2 range invalidation
 support
To: Robin Murphy <robin.murphy@arm.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Linux IOMMU <iommu@lists.linux-foundation.org>, Will Deacon <will@kernel.org>,
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

On Thu, Jan 30, 2020 at 11:34 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 30/01/2020 3:06 pm, Auger Eric wrote:
> > Hi Rob,
> > On 1/17/20 10:16 PM, Rob Herring wrote:
> >> Arm SMMUv3.2 adds support for TLB range invalidate operations.
> >> Support for range invalidate is determined by the RIL bit in the IDR3
> >> register.
> >>
> >> The range invalidate is in units of the leaf page size and operates on
> >> 1-32 chunks of a power of 2 multiple pages. First, we determine from the
> >> size what power of 2 multiple we can use. Then we calculate how many
> >> chunks (1-31) of the power of 2 size for the range on the iteration. On
> >> each iteration, we move up in size by at least 5 bits.
> >>
> >> Cc: Eric Auger <eric.auger@redhat.com>
> >> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> >> Cc: Will Deacon <will@kernel.org>
> >> Cc: Robin Murphy <robin.murphy@arm.com>
> >> Cc: Joerg Roedel <joro@8bytes.org>
> >> Signed-off-by: Rob Herring <robh@kernel.org>


> >> @@ -2003,7 +2024,7 @@ static void arm_smmu_tlb_inv_range(unsigned long iova, size_t size,
> >>   {
> >>      u64 cmds[CMDQ_BATCH_ENTRIES * CMDQ_ENT_DWORDS];
> >>      struct arm_smmu_device *smmu = smmu_domain->smmu;
> >> -    unsigned long start = iova, end = iova + size;
> >> +    unsigned long start = iova, end = iova + size, num_pages = 0, tg = 0;
> >>      int i = 0;
> >>      struct arm_smmu_cmdq_ent cmd = {
> >>              .tlbi = {
> >> @@ -2022,12 +2043,50 @@ static void arm_smmu_tlb_inv_range(unsigned long iova, size_t size,
> >>              cmd.tlbi.vmid   = smmu_domain->s2_cfg.vmid;
> >>      }
> >>
> >> +    if (smmu->features & ARM_SMMU_FEAT_RANGE_INV) {
> >> +            /* Get the leaf page size */
> >> +            tg = __ffs(smmu_domain->domain.pgsize_bitmap);
> >> +
> >> +            /* Convert page size of 12,14,16 (log2) to 1,2,3 */
> >> +            cmd.tlbi.tg = ((tg - ilog2(SZ_4K)) / 2) + 1;
>
> Given the comment, I think "(tg - 10) / 2" would suffice ;)

Well, duh...

>
> >> +
> >> +            /* Determine what level the granule is at */
> >> +            cmd.tlbi.ttl = 4 - ((ilog2(granule) - 3) / (tg - 3));
>
> Is it possible to rephrase that with logs and shifts to avoid the division?

Well, with a loop is the only other way I came up with:

bpl = tg - 3;
ttl = 3;
mask = BIT(bpl) - 1;
while ((granule & (mask << ((4 - ttl) * bpl + 3))) == 0)
    ttl--;

Doesn't seem like much improvement to me given we have h/w divide...

>
> >> +
> >> +            num_pages = size / (1UL << tg);
>
> Similarly, in my experience GCC has always seemed too cautious to elide
> non-constant division even in a seemingly-obvious case like this, so
> explicit "size >> tg" might be preferable.

My experience has been gcc is smart enough. I checked and there's only
one divide and it is the prior one. But I'll change it anyways.

>
> >> +    }
> >> +
> >>      while (iova < end) {
> >>              if (i == CMDQ_BATCH_ENTRIES) {
> >>                      arm_smmu_cmdq_issue_cmdlist(smmu, cmds, i, false);
> >>                      i = 0;
> >>              }
> >>
> >> +            if (smmu->features & ARM_SMMU_FEAT_RANGE_INV) {
> >> +                    /*
> >> +                     * On each iteration of the loop, the range is 5 bits
> >> +                     * worth of the aligned size remaining.
> >> +                     * The range in pages is:
> >> +                     *
> >> +                     * range = (num_pages & (0x1f << __ffs(num_pages)))
> >> +                     */
> >> +                    unsigned long scale, num;
> >> +
> >> +                    /* Determine the power of 2 multiple number of pages */
> >> +                    scale = __ffs(num_pages);
> >> +                    cmd.tlbi.scale = scale;
> >> +
> >> +                    /* Determine how many chunks of 2^scale size we have */
> >> +                    num = (num_pages >> scale) & CMDQ_TLBI_RANGE_NUM_MAX;
> >> +                    cmd.tlbi.num = num - 1;
> >> +
> >> +                    /* range is num * 2^scale * pgsize */
> >> +                    granule = num << (scale + tg);
> >> +
> >> +                    /* Clear out the lower order bits for the next iteration */
> >> +                    num_pages -= num << scale;
> > Regarding the 2 options given in
> > https://lore.kernel.org/linux-arm-kernel/CAL_JsqKABoE+0crGwyZdNogNgEoG=MOOpf6deQgH6s73c0UNdA@mail.gmail.com/raw,
> >
> > I understand you implemented 2) but I still do not understand why you
> > preferred that one against 1).
> >
> > In your case of 1023*4k pages this will invalidate by 31 32*2^0*4K +
> > 31*2^0*4K pages
> > whereas you could achieve that with 10 invalidations with the 1st algo.
> > I did not get the case where it is more efficient. Please can you detail.
>
> I guess essentially we want to solve for two variables to get a range as
> close to size as possible. There might be a more elegant numerical
> method, but for the numbers involved brute force is probably good enough
> for the real world. 5 minutes alone with the architecture spec and a
> blank editor begat this pseudo-implementation:
>
>         size_t npages = size >> pgshift;
>         while (npages) {
>                 unsigned long range;
>                 unsigned int delta, best = UINT_MAX;
>                 int num, scale = min(31, __ffs(npages));
>
>                 while (scale) {
>                         num = min(32, npages >> scale);
>                         if (num == 32)
>                                 break;
>
>                         delta = npages & ((1 << scale) - 1);
>                         if (!delta || delta > best)
>                                 break;
>
>                         best = delta;
>                         scale--;
>                 }
>
>                 //invalidate
>
>                 range = num << scale;
>                 npages -= range;
>                 iova += (range) << pgshift;
>         }
>
> Modulo any obvious thinkos, what do you reckon?

I don't think this is an improvement. See my other reply.

Rob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
