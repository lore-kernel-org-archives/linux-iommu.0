Return-Path: <SRS0=5edT=4J=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24FE1C35656
	for <iommu@archiver.kernel.org>; Fri, 21 Feb 2020 16:47:40 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0C802067D
	for <iommu@archiver.kernel.org>; Fri, 21 Feb 2020 16:47:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wuDLptut"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0C802067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 99C30220EC;
	Fri, 21 Feb 2020 16:47:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Qalsgjue-3lY; Fri, 21 Feb 2020 16:47:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 6C5A720378;
	Fri, 21 Feb 2020 16:47:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4FA36C07FE;
	Fri, 21 Feb 2020 16:47:38 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 01DB6C013E
 for <iommu@lists.linux-foundation.org>; Fri, 21 Feb 2020 16:47:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id E425D87A3A
 for <iommu@lists.linux-foundation.org>; Fri, 21 Feb 2020 16:47:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Iu0B8xAWUuaC for <iommu@lists.linux-foundation.org>;
 Fri, 21 Feb 2020 16:47:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 8DBB9856E4
 for <iommu@lists.linux-foundation.org>; Fri, 21 Feb 2020 16:47:35 +0000 (UTC)
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com
 [209.85.222.176])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 41BA22067D
 for <iommu@lists.linux-foundation.org>; Fri, 21 Feb 2020 16:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1582303655;
 bh=UFnupkuEDoqrc04q8jdKLGfA1GzFl1b0UoKJJZMQFao=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=wuDLptutO0uDqtoV5jd77T1qy+Hhi4cSREJS/MW38kle9cteOozL9nV01o4KCEyCF
 YDZWP2Nfoby7MVf/WKLvlnu7YRf77WNnqpNcMlVDLZ3stmkpK/fH2mZpofMhIu6KHY
 QuDJWk/nQzcfx42rLA5JUCo7bS9WkZ3jMaak0UsU=
Received: by mail-qk1-f176.google.com with SMTP id c20so2420329qkm.1
 for <iommu@lists.linux-foundation.org>; Fri, 21 Feb 2020 08:47:35 -0800 (PST)
X-Gm-Message-State: APjAAAXQkOcpYIe3eWM8TH+a1VoCGghTp8KrR5Istcn8pwX0O8zz/Dnw
 V9yFWue0c1NXs0RAqqGYFY8M2Fe3uNH89qHQhg==
X-Google-Smtp-Source: APXvYqwzykXA/llhTIK2x1jpCbxq/lDy9xawSBtgCPgf1YfnTn4ax60XEuwwK1egxvgGS6LsTn4b9eLD25XV52HLTz4=
X-Received: by 2002:ae9:f205:: with SMTP id m5mr35008078qkg.152.1582303654430; 
 Fri, 21 Feb 2020 08:47:34 -0800 (PST)
MIME-Version: 1.0
References: <20200117211628.27888-1-robh@kernel.org>
 <2d04f201-3457-08ad-db8e-735f8315d74e@redhat.com>
 <7ac3f864-6c39-76e9-ee4a-21be03abc044@arm.com>
 <CAL_JsqJRSD-7U8UH1tevBdD2P6qPWzApQLpXU-SVBmZ8=Yiy0A@mail.gmail.com>
 <d49b62f2-74f4-c3e0-ad97-a4fedd169b27@arm.com>
 <CAL_JsqKY1_WmwLOKySwBasyZ5Kb=Rx-Y6m8bDppRKVxzoY58xg@mail.gmail.com>
 <49847ca9-3ee8-4c08-a772-a93f10aa817f@arm.com>
In-Reply-To: <49847ca9-3ee8-4c08-a772-a93f10aa817f@arm.com>
From: Rob Herring <robh@kernel.org>
Date: Fri, 21 Feb 2020 10:47:23 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJam8qO-XAfQTXNZ0y_gLdOx0LAX28XnKjXd2yh7y3_Uw@mail.gmail.com>
Message-ID: <CAL_JsqJam8qO-XAfQTXNZ0y_gLdOx0LAX28XnKjXd2yh7y3_Uw@mail.gmail.com>
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

On Fri, Feb 21, 2020 at 10:19 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 20/02/2020 5:54 pm, Rob Herring wrote:
> > On Mon, Feb 17, 2020 at 1:17 PM Robin Murphy <robin.murphy@arm.com> wrote:
> >>
> >> On 13/02/2020 9:49 pm, Rob Herring wrote:
> >>> On Thu, Jan 30, 2020 at 11:34 AM Robin Murphy <robin.murphy@arm.com> wrote:
> >>>>
> >>>> On 30/01/2020 3:06 pm, Auger Eric wrote:
> >>>>> Hi Rob,
> >>>>> On 1/17/20 10:16 PM, Rob Herring wrote:
> >>>>>> Arm SMMUv3.2 adds support for TLB range invalidate operations.
> >>>>>> Support for range invalidate is determined by the RIL bit in the IDR3
> >>>>>> register.
> >>>>>>
> >>>>>> The range invalidate is in units of the leaf page size and operates on
> >>>>>> 1-32 chunks of a power of 2 multiple pages. First, we determine from the
> >>>>>> size what power of 2 multiple we can use. Then we calculate how many
> >>>>>> chunks (1-31) of the power of 2 size for the range on the iteration. On
> >>>>>> each iteration, we move up in size by at least 5 bits.
> >>>>>>
> >>>>>> Cc: Eric Auger <eric.auger@redhat.com>
> >>>>>> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> >>>>>> Cc: Will Deacon <will@kernel.org>
> >>>>>> Cc: Robin Murphy <robin.murphy@arm.com>
> >>>>>> Cc: Joerg Roedel <joro@8bytes.org>
> >>>>>> Signed-off-by: Rob Herring <robh@kernel.org>
> >>>
> >>>
> >>>>>> @@ -2003,7 +2024,7 @@ static void arm_smmu_tlb_inv_range(unsigned long iova, size_t size,
> >>>>>>     {
> >>>>>>        u64 cmds[CMDQ_BATCH_ENTRIES * CMDQ_ENT_DWORDS];
> >>>>>>        struct arm_smmu_device *smmu = smmu_domain->smmu;
> >>>>>> -    unsigned long start = iova, end = iova + size;
> >>>>>> +    unsigned long start = iova, end = iova + size, num_pages = 0, tg = 0;
> >>>>>>        int i = 0;
> >>>>>>        struct arm_smmu_cmdq_ent cmd = {
> >>>>>>                .tlbi = {
> >>>>>> @@ -2022,12 +2043,50 @@ static void arm_smmu_tlb_inv_range(unsigned long iova, size_t size,
> >>>>>>                cmd.tlbi.vmid   = smmu_domain->s2_cfg.vmid;
> >>>>>>        }
> >>>>>>
> >>>>>> +    if (smmu->features & ARM_SMMU_FEAT_RANGE_INV) {
> >>>>>> +            /* Get the leaf page size */
> >>>>>> +            tg = __ffs(smmu_domain->domain.pgsize_bitmap);
> >>>>>> +
> >>>>>> +            /* Convert page size of 12,14,16 (log2) to 1,2,3 */
> >>>>>> +            cmd.tlbi.tg = ((tg - ilog2(SZ_4K)) / 2) + 1;
> >>>>
> >>>> Given the comment, I think "(tg - 10) / 2" would suffice ;)
> >>>
> >>> Well, duh...
> >>>
> >>>>
> >>>>>> +
> >>>>>> +            /* Determine what level the granule is at */
> >>>>>> +            cmd.tlbi.ttl = 4 - ((ilog2(granule) - 3) / (tg - 3));
> >>>>
> >>>> Is it possible to rephrase that with logs and shifts to avoid the division?
> >>>
> >>> Well, with a loop is the only other way I came up with:
> >>>
> >>> bpl = tg - 3;
> >>> ttl = 3;
> >>> mask = BIT(bpl) - 1;
> >>> while ((granule & (mask << ((4 - ttl) * bpl + 3))) == 0)
> >>>       ttl--;
> >>>
> >>> Doesn't seem like much improvement to me given we have h/w divide...
> >>
> >> Sure, it doesn't take too many extra instructions to start matching
> >> typical IDIV latency, so there's no point being silly if there really
> >> isn't a clean alternative.
> >>
> >> Some quick scribbling suggests "4 - ilog2(granule) / 10" might actually
> >> be close enough, but perhaps that's a bit too cheeky.
> >
> > How does divide by 10 save a divide?
>
> Well, by that point I was more just thinking about the smallest
> expression, since *some* division seems unavoidable. Although GCC does
> apparently still think that transforming constant division is a win ;)

Okay. Still, divide by 10 happens to work, but it is very much not
obvious. It also doesn't work for level 1 and 16 or 64KB pages (though
we'll never see that granule). Subtracting 3 is not that obvious
either, but is at least in the spec for calculating the bits per
level.

I think we've spent enough time micro-optimizing this and have better
things to worry about.

Rob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
