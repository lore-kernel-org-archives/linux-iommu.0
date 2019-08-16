Return-Path: <SRS0=MJs7=WM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5EDDC3A59D
	for <iommu@archiver.kernel.org>; Fri, 16 Aug 2019 18:45:26 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9210F2086C
	for <iommu@archiver.kernel.org>; Fri, 16 Aug 2019 18:45:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="li2IDh4m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9210F2086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 8FB13C96;
	Fri, 16 Aug 2019 18:45:25 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id EFE56BE7
	for <iommu@lists.linux-foundation.org>;
	Fri, 16 Aug 2019 18:45:23 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-oi1-f193.google.com (mail-oi1-f193.google.com
	[209.85.167.193])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 67D9D87B
	for <iommu@lists.linux-foundation.org>;
	Fri, 16 Aug 2019 18:45:23 +0000 (UTC)
Received: by mail-oi1-f193.google.com with SMTP id p124so5508541oig.5
	for <iommu@lists.linux-foundation.org>;
	Fri, 16 Aug 2019 11:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=8m/PnUmMNG5r4K8qxwTrufqLXmjy5RNoUVedVSyDCas=;
	b=li2IDh4mr+UAvox0w8zYX5tehUMkPPvP7XXDZCuFsaYSIFIidndEttxHLIPHalJnbr
	NjPHIAX42dtPi/AoVxuy5mtla/nzfy/BXFISPwcgG5eg7CKIeWppsVo+M1yV0O1Ivv6x
	ZkGpP31kNHoxf/lHiet4xJZ4Hrg989UdKskSM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=8m/PnUmMNG5r4K8qxwTrufqLXmjy5RNoUVedVSyDCas=;
	b=mhK4GtNljgQdmEqIVoxUBMURJKb38/4v0MWPL/M5TsCQ7+M/qlJ1uFe118fpyByYLv
	2TsqDJYrMrgjqDQ7Yns+77Y2nvJoQoafM6ydMvmmy40UjVFdv36YMiWwm08FbzuIkpTR
	L/tuSS2roF+9vMtChP1I7+Nx/VORfjNj2hywNWelJK30WXsiYKp+9BvDYFNdZCG41y/m
	NSgD6HyZafq7T1tohXgmQNvEANPpSk0Gg0IRXgbanly/RaLUOH8YFhibESCw9c3xLf3g
	9JrET/5JOuWdpfUaHfOqQHnnbjefpRbM4sYW2E/aIAY6soxcQyrXOdDLVPhmR9G5n3Ik
	kkJw==
X-Gm-Message-State: APjAAAXpB7bCoQnDqv7iLLOu8b5X+QyRFIUdsf1vt7jtY59Gr6QmoQiA
	GWdD1Amdb6TX9jhGRCQNFI8x7GbG0yHT5C0tw84RIA==
X-Google-Smtp-Source: APXvYqxtlu0LEJa8psV6E/U/IwuYFYQU5hM+C5zSCrQVLfT7Mz2rnMfcYn79/qmwJoa+Ktloe0ld4rH3kcVpmdEdjao=
X-Received: by 2002:a05:6808:28d:: with SMTP id
	z13mr5408599oic.101.1565981122323; 
	Fri, 16 Aug 2019 11:45:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190814145033.GA11190@Red>
	<20190814174927.GT7444@phenom.ffwll.local>
	<20190816143146.GB30445@Red>
In-Reply-To: <20190816143146.GB30445@Red>
From: Daniel Vetter <daniel@ffwll.ch>
Date: Fri, 16 Aug 2019 20:45:11 +0200
Message-ID: <CAKMK7uGb0twmXUXS5GVN0mmGW-csWH524psJFfdFYuou9YXFDw@mail.gmail.com>
Subject: Re: DMA-API: cacheline tracking ENOMEM, dma-debug disabled due to
	nouveau ?
To: Corentin Labbe <clabbe.montjoie@gmail.com>
Cc: Dave Airlie <airlied@linux.ie>, Nouveau Dev <nouveau@lists.freedesktop.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	dri-devel <dri-devel@lists.freedesktop.org>,
	"list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
	Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
	Ben Skeggs <bskeggs@redhat.com>, Robin Murphy <robin.murphy@arm.com>,
	Christoph Hellwig <hch@lst.de>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Fri, Aug 16, 2019 at 4:31 PM Corentin Labbe
<clabbe.montjoie@gmail.com> wrote:
> On Wed, Aug 14, 2019 at 07:49:27PM +0200, Daniel Vetter wrote:
> > On Wed, Aug 14, 2019 at 04:50:33PM +0200, Corentin Labbe wrote:
> > > Hello
> > >
> > > Since lot of release (at least since 4.19), I hit the following error message:
> > > DMA-API: cacheline tracking ENOMEM, dma-debug disabled
> > >
> > > After hitting that, I try to check who is creating so many DMA mapping and see:
> > > cat /sys/kernel/debug/dma-api/dump | cut -d' ' -f2 | sort | uniq -c
> > >       6 ahci
> > >     257 e1000e
> > >       6 ehci-pci
> > >    5891 nouveau
> > >      24 uhci_hcd
> > >
> > > Does nouveau having this high number of DMA mapping is normal ?
> >
> > Yeah seems perfectly fine for a gpu.
>
> Note that it never go down and when I terminate my X session, it stays the same.
> So without any "real" GPU work, does it is still normal to have so many active mapping ?

Might just be the dma_alloc cache. It should go down under memory
pressure I think. Otherwise might also be a leak.

> For example, when doing some transfer, the ahci mapping number changes and then always go down to 6.

gpu drivers tend to cache everything, all the time ...
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
