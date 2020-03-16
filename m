Return-Path: <SRS0=N4Nm=5B=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA852C0044D
	for <iommu@archiver.kernel.org>; Mon, 16 Mar 2020 21:39:23 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F6CD20679
	for <iommu@archiver.kernel.org>; Mon, 16 Mar 2020 21:39:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JymR0FKo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F6CD20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9039E86B1C;
	Mon, 16 Mar 2020 21:39:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qNRAGpHqEYbk; Mon, 16 Mar 2020 21:39:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 10BDF86A15;
	Mon, 16 Mar 2020 21:39:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DC4C4C1D7C;
	Mon, 16 Mar 2020 21:39:17 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0B517C013E
 for <iommu@lists.linux-foundation.org>; Mon, 16 Mar 2020 21:39:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id EDAFC88E41
 for <iommu@lists.linux-foundation.org>; Mon, 16 Mar 2020 21:39:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Owu9NikfleKG for <iommu@lists.linux-foundation.org>;
 Mon, 16 Mar 2020 21:39:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com
 [209.85.216.65])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 02ABC887B4
 for <iommu@lists.linux-foundation.org>; Mon, 16 Mar 2020 21:39:16 +0000 (UTC)
Received: by mail-pj1-f65.google.com with SMTP id l36so9008472pjb.3
 for <iommu@lists.linux-foundation.org>; Mon, 16 Mar 2020 14:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=Iv7KMVJA85Sx1LgEUzFaUAJSP9avw45LZ2+zg6JYxC0=;
 b=JymR0FKoBkS7vFA9Y9eHf56KJX5/lpQ6CnOhgF4ApCmOkhRuyrt/tL+iiadfwjJfJb
 0QctrffzOqb8ejQptBMkab9Rqpl3CarXsDaZ9ksnHBUqU7skAHWnSLQen6ETTKRGEuof
 BzCuM+OwkZp3Ch5ZEpAtllltH1eg6qJeID636d9MVp5u1cWvdE7WgeC3RiH3ciFUpFOq
 tFM8On4+pa4wgQC0Y0NOqH9DjNheis+PvpoIT4YvayIUUxuFkLtgk7xdK+q8u0EVMtkP
 7HA4xETo44jU6jZaQk7aIufFLMcMZAHfyl0iCni+AiWbGgvEwLgUCFiWzQzTfxkAmzWy
 e5nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Iv7KMVJA85Sx1LgEUzFaUAJSP9avw45LZ2+zg6JYxC0=;
 b=RXv9y1Ufk+XIvlqfcEkuh5NvW8VWz+Xjfa05hZVHKj4XLbMPCVAtUD5YhNRG0fUbdU
 MyagNOW3d9WDwc3tileSAKy/Ps6Tfit00koP9Up5FBQyf0qizYmjzoUDyhT3BfKVAtFS
 13HainzzGCHcvDkvTYoAsku1sEYPq3FdNceWdezMPtCf2v5HqjF3PLejf9fmxIusd9I3
 rRc5RsFFTOORKnOw1TE4P+ZIqm4+pfD2bqMPpG+sd8HBIULmHOEwR8WmESb3caOc6Pxc
 HYUXQLNn/anbTakwd/6mxfRUKrMzBLs15PvE5MkSZzlNdgj4k77IaGs+S5a2R3ad3uDG
 Wzhw==
X-Gm-Message-State: ANhLgQ3iDWdnZDMA0vZIz1UGAVYonycmV4Bla9Kpb6BcA3uuT6XecgWt
 O/QX3XuAfXgnUKX9o5WyBLM=
X-Google-Smtp-Source: ADFU+vvPWLU8A4OXFX2ZE53ogKTzeu6QmkvmI3lQ/esLaVRKUv1TXt0q6nzE5CdBuByH5H8iYYu0Jg==
X-Received: by 2002:a17:90a:c482:: with SMTP id
 j2mr1617116pjt.71.1584394755228; 
 Mon, 16 Mar 2020 14:39:15 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id c16sm635317pfn.86.2020.03.16.14.39.14
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 16 Mar 2020 14:39:14 -0700 (PDT)
Date: Mon, 16 Mar 2020 14:39:27 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [RFC][PATCH] dma-mapping: align default segment_boundary_mask
 with dma_mask
Message-ID: <20200316213923.GA18970@Asurada-Nvidia.nvidia.com>
References: <20200314000007.13778-1-nicoleotsuka@gmail.com>
 <f36ac67e-0eca-46df-78ec-c8b1c4fbe951@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f36ac67e-0eca-46df-78ec-c8b1c4fbe951@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, hch@lst.de
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

Hi Robin,

Thank you for the inputs.

On Mon, Mar 16, 2020 at 12:12:08PM +0000, Robin Murphy wrote:
> On 2020-03-14 12:00 am, Nicolin Chen wrote:
> > More and more drivers set dma_masks above DMA_BIT_MAKS(32) while
> > only a handful of drivers call dma_set_seg_boundary(). This means
> > that most drivers have a 4GB segmention boundary because DMA API
> > returns DMA_BIT_MAKS(32) as a default value, though they might be
> > able to handle things above 32-bit.
> 
> Don't assume the boundary mask and the DMA mask are related. There do exist
> devices which can DMA to a 64-bit address space in general, but due to
> descriptor formats/hardware design/whatever still require any single
> transfer not to cross some smaller boundary. XHCI is 64-bit yet requires
> most things not to cross a 64KB boundary. EHCI's 64-bit mode is an example
> of the 4GB boundary (not the best example, admittedly, but it undeniably
> exists).

I see. But for those cases, they should set seg_boundary_mask in
the drivers, in my opinion, because only they know what hardware
limits are, same as they set dma_mask and coherent_dma_mask.

The reason for I picked dma_mask was because we won't likely hit
the boundary, if it's >= dma_mask -- maybe I am wrong here.

> > This might result in a situation that iommu_map_sg() cuts an IOVA
> > region, larger than 4GB, into discontiguous pieces and creates a
> > faulty IOVA mapping that overlaps some physical memory being out
> > of the scatter list, which might lead to some random kernel panic
> > after DMA overwrites that faulty IOVA space.
> 
> If that's really a problem, then what about users who set a non-default
> mask?

I got a (downstream) bug report from our GPU side. I am not 100%
sure if it's a real world case. But I can't simply ignore -- even
if it's not at this point, sooner or later it'd be.

Not quite getting what could be a user case for non-default mask.
Yet, whoever sets the mask should take the responsibility for any
bad thing happens.

> Furthermore, scatterlist segments are just DMA duffers - if there is no
> IOMMU and a device accesses outside a buffer, Bad Things can and will
> happen; if the ends of the buffer don't line up exactly to page boundaries
> even with an IOMMU, if the device accesses outside the buffer then Bad
> Things can happen; even if an IOMMU can map a buffer perfectly, accesses
> outside it will either hit other buffers or generate unexpected faults,
> which are both - you guessed it - Bad Things.
> 
> In short, if this is happening then something is certainly broken, but it
> isn't the DMA layer.

I don't mean DMA API should be blamed for bad thing happening.
Yet, it sets the 32-bit boundary by returning in the get(), so
it's just easier to do the flu-shot in the API; otherwise, we
will end up with patching every single driver. Maybe not quite
a lot at this point, but there will be potentially.

> > We have CONFIG_DMA_API_DEBUG_SG in kernel/dma/debug.c that checks
> > such situations to prevent bad things from happening. However, it
> > is not a mandatory check. And one might not think of enabling it
> > when debugging a random kernel panic until figuring out that it's
> > related to iommu_map_sg().
> > 
> > A safer solution may be to align the default segmention boundary
> > with the configured dma_mask, so DMA API may create a contiguous
> > IOVA space as a device "expect" -- what tries to make sense is:
> > Though it's device driver's responsibility to set dma_parms, it
> > is not fair or even safe to apply a 4GB boundary here, which was
> > added a decade ago to work for up-to-4GB mappings at that time.
> > 
> > This patch updates the default segment_boundary_mask by aligning
> > it with dma_mask.
> 
> Why bother even interrogating the device? You can trivially express "no
> limit" as "~0UL", which is arguably less confusing than pretending this
> bears any relation to DMA masks. However, like Christoph I'm concerned that
> we don't know how many drivers are relying on the current default (and to a
> lesser extent that it leads to a subtle difference in behaviour between
> 32-bit PAE and 'proper' 64-bit builds).

I stated the reason in my first inline reply. But I don't have a
problem for "~0UL", if it feels less confusing to most of people.

And I agree with the concern. Yet we still need to do something,
right? Is there any other value that we may rely on, rather than
dma_mask, even if just for safety? Or would it be possible for us
to warn user when mapping gets out of the given physical address
space, since this is the point when thing goes wrong?

> And in the specific case of iommu-dma, this only comes into the picture at
> all if a single scatterlist maps more than 4GB at once, which isn't exactly
> typical streaming DMA behaviour - given that that implies a rather absurd
> figure of more than 65536 entries at the default max_segment_size, the
> relevant device probably doesn't want to be relying on the default dma_parms
> in the first place.

From my point of view, when a device doesn't set dma_params but
uses the default one, it sounds like "I don't have such a limit
in my hardware so you can just give me whatever you can prepare
for me", instead of "I am just a non-absurd case" :)

Overall, I do see a fear of regression for touching the default
segmentation boundary mask. At least I want to see if there can
be anything that we can or will likely do in the future, rather
than adding dma_set_seg_boundary() to all the drivers.

> [ I though I'd replied to your previous mail already; let me go see what
> happened to that... ]

I did send a related bug-reporting email a couple of weeks ago:
https://lists.linuxfoundation.org/pipermail/iommu/2020-March/042220.html

Yet have not seen any reply.

Thanks a lot!

> Robin.
> 
> > Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> > ---
> >   include/linux/dma-mapping.h | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> > index 330ad58fbf4d..0df0ee92eba1 100644
> > --- a/include/linux/dma-mapping.h
> > +++ b/include/linux/dma-mapping.h
> > @@ -736,7 +736,7 @@ static inline unsigned long dma_get_seg_boundary(struct device *dev)
> >   {
> >   	if (dev->dma_parms && dev->dma_parms->segment_boundary_mask)
> >   		return dev->dma_parms->segment_boundary_mask;
> > -	return DMA_BIT_MASK(32);
> > +	return (unsigned long)dma_get_mask(dev);
> >   }
> >   static inline int dma_set_seg_boundary(struct device *dev, unsigned long mask)
> > 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
