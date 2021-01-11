Return-Path: <SRS0=1kRO=GO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA568C433DB
	for <iommu@archiver.kernel.org>; Mon, 11 Jan 2021 21:36:36 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7215A225AC
	for <iommu@archiver.kernel.org>; Mon, 11 Jan 2021 21:36:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7215A225AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id E97E42270C;
	Mon, 11 Jan 2021 21:36:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 76Sxv5g2A0hf; Mon, 11 Jan 2021 21:36:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 380A2204A5;
	Mon, 11 Jan 2021 21:36:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 19279C0893;
	Mon, 11 Jan 2021 21:36:33 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A0A4AC013A
 for <iommu@lists.linux-foundation.org>; Mon, 11 Jan 2021 21:36:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 91EEA865E2
 for <iommu@lists.linux-foundation.org>; Mon, 11 Jan 2021 21:36:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pAeoa55QeUq8 for <iommu@lists.linux-foundation.org>;
 Mon, 11 Jan 2021 21:36:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 96ECB8613C
 for <iommu@lists.linux-foundation.org>; Mon, 11 Jan 2021 21:36:30 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id t16so297209wra.3
 for <iommu@lists.linux-foundation.org>; Mon, 11 Jan 2021 13:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=i0xMi6BcZcyDu0fcZnUeC0nFD2sQudz3pvIy74Uu1Co=;
 b=aoPFqdupBdo2m50fA72kLB51Y4eAj0rEvXhgPGXgU3pHawnWSdq+OOJo+x02/Ttmh/
 GT/usW8NL+/oXIuxlc+SjB3GIpvrLO3AqRas0wNI6fpXwnN2njXJcx7tzXn1i2zmDr5V
 4pBDPqMBoBGacxzqtY5h7ZOC/kYBQeqihZfBx17J4OKktz2sNwOPRv276CKNOAYKINlF
 PzSZSUjORtpor/zgcG4uYxinJsR9F46Id/uhmHZyNxCLMdAMIW3p7iSIFaHG0yE02xYP
 hiewwhR/TQ0wpE4tWLB/7LtTzmTpni+aGYOK1X+x2doEpCEgYjDdFfbtY8HmzStCeiRb
 oylQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=i0xMi6BcZcyDu0fcZnUeC0nFD2sQudz3pvIy74Uu1Co=;
 b=acMAuzFwy6KSxWzL57JQo9+JfLlc0SCLktIPbvfDHQb+f+WMd/n/UV9qSI+8YSByM5
 rzkQmFEZ8KN7jJmwgfcaj5Uuej9gB7harYnA/NMFsjC/rOyO+yCONfEhkIVL7RxMQ3Bn
 DSxtCfBWwtMx+pPe2Dl+kEcSVIsZlk120VJSTCydpSZT8L0+m3o1Yao81CyXvMK560xY
 YI2TfhWtOVvAy9PZ3Ytg5AX55vtWOCvFvQsusSPoWFU8absCF57PMIyJGg2f7aT7+uW0
 pXV4Mv6O4kwcmBo6j3Sw4/8ENwihV/wLbJL1qG9KnNd/pmp1bns3FgsC0gd/Udtvwf4K
 XMgg==
X-Gm-Message-State: AOAM532fYDEdO6rXvo+pvVY2BvYLlVfmnRcdrWNqZfqyYT1tSbGYoDeg
 gDPyRcxl3F6MEqNNYFJtE+4WOLaklWWVfyi73ONdpg==
X-Google-Smtp-Source: ABdhPJwc4Tc/s46NcBJR4zTZePqRBiO7sGEbGyK0c71idGH77xhltZxnEMdsrKLPkDWH1LYE57mboh9Z32DxStHJfik=
X-Received: by 2002:adf:ee4d:: with SMTP id w13mr1028748wro.216.1610400988919; 
 Mon, 11 Jan 2021 13:36:28 -0800 (PST)
MIME-Version: 1.0
References: <20210111154335.23388-1-marcorr@google.com>
 <dc6db6b4-88f1-4762-bd3b-edf3dd410366@arm.com>
 <CAA03e5HLN_iPzXRTJ_Dvx5h8KP-Qi+=6u+9mHnaoB9oBMMWs7Q@mail.gmail.com>
 <bbf6f07c-369b-e470-78ff-815cfb4dbf92@arm.com>
In-Reply-To: <bbf6f07c-369b-e470-78ff-815cfb4dbf92@arm.com>
Date: Mon, 11 Jan 2021 13:36:17 -0800
Message-ID: <CAA03e5G6UohDjvA6P1mq4SdcPRQ_LFBvkhwUM9Uo6ztGU_9BQg@mail.gmail.com>
Subject: Re: [PATCH] dma: mark unmapped DMA scatter/gather invalid
To: Robin Murphy <robin.murphy@arm.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Jianxiong Gao <jxgao@google.com>, hch@lst.de
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
From: Marc Orr via iommu <iommu@lists.linux-foundation.org>
Reply-To: Marc Orr <marcorr@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

> >>> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> >>> index 0a4881e59aa7..3d9b17fe5771 100644
> >>> --- a/kernel/dma/direct.c
> >>> +++ b/kernel/dma/direct.c
> >>> @@ -374,9 +374,11 @@ void dma_direct_unmap_sg(struct device *dev, struct scatterlist *sgl,
> >>>        struct scatterlist *sg;
> >>>        int i;
> >>>
> >>> -     for_each_sg(sgl, sg, nents, i)
> >>> +     for_each_sg(sgl, sg, nents, i) {
> >>>                dma_direct_unmap_page(dev, sg->dma_address, sg_dma_len(sg), dir,
> >>>                             attrs);
> >>> +             sg->dma_address = DMA_MAPPING_ERROR;
> >>
> >> There are more DMA API backends than just dma-direct, so while this
> >> might help paper over bugs when SWIOTLB is in use, it's not going to
> >> have any effect when those same bugs are hit under other circumstances.
> >> Once again, the moral of the story is that effort is better spent just
> >> fixing the bugs ;)
> >
> > Thanks for the quick feedback. What is the correct fix? I understand
> > the first half. The NVMe driver should be updated to not call unmap on
> > an address that has already been unmapped within the DMA direct code.
> > Where I'm less certain is how to communicate to the NVMe driver that
> > the mapping failed. In particular, the NVMe code explicitly checks if
> > the first DMA address in the scatter/gather list is set to
> > DMA_MAPPING_ERROR. Thus, don't we need to update the DMA direct code
> > to propagate DMA_MAPPING_ERROR back up to the driver, via the
> > scatter/gather struct?
>
> Erm, you check the return value of dma_map_sg(). If it's zero, the
> request failed; if it's nonzero, that's how many DMA segments you now
> have to process. See Documentation/core-api/dma-api.rst.
>
> The only guarantee offered about the state of the scatterlist itself is
> that if it is successfully mapped, then the dma_address and dma_length
> fields are valid for that many segments, and if that is fewer than the
> total number of physical segments then the next one after the final DMA
> segment will have a dma_length of 0. In particular there are no
> guarantees at all about the state if the mapping was unsuccessful.
>
> If a driver is failing to keep track of the success/failure status and
> later down the line trying to guess what to do with a list that may or
> may not have been mapped, then frankly that driver should be redesigned
> because that is a terrible anti-pattern. At the very very least it
> should explicitly encode its own "known bad" state upon failure that it
> can then reliably recognise later.

Got it now. I'll get to work on a patch for the NVMe driver to fix the
bug. Thanks for all of these pointers. They are immensely helpful.

Thanks,
Marc
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
