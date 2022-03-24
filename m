Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C87DFC433EF
	for <iommu@archiver.kernel.org>; Thu, 24 Mar 2022 00:55:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 67C5784A2A;
	Thu, 24 Mar 2022 00:55:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Uu93Lmt0L5FY; Thu, 24 Mar 2022 00:55:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2BB1B84A1E;
	Thu, 24 Mar 2022 00:55:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F3B7CC0012;
	Thu, 24 Mar 2022 00:55:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 381D3C000B
 for <iommu@lists.linux-foundation.org>; Thu, 24 Mar 2022 00:55:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 194EC418E8
 for <iommu@lists.linux-foundation.org>; Thu, 24 Mar 2022 00:55:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XL7ZS9zsWB3t for <iommu@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 00:55:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 55DD341716
 for <iommu@lists.linux-foundation.org>; Thu, 24 Mar 2022 00:55:39 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 3A88961912
 for <iommu@lists.linux-foundation.org>; Thu, 24 Mar 2022 00:55:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34D03C340F3
 for <iommu@lists.linux-foundation.org>; Thu, 24 Mar 2022 00:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1648083337;
 bh=Y0on+fjdMzikugBt55YCOFCiUxO2vyhhnfZ1+tZj3dM=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=YbgA8cNEkOuzUPh9PdBF+YfFt1LYibT6+Ty2RvBN2xiDZ0J6uoPuExioJsIUlM2Xi
 btPcoPpxpLU2vae+NgcGO1sV9/N3pfb2xN09MVKaFYsFj2ir5u+yPQmdc931mP8BWc
 dUfLnsULyuPzjQ6nUjE8CHOEj454uePbpUDn0NTx9GhTuaG8yim7zIn58nuphAGmVU
 cTIk5H5Nmk0WlBiB+llVc1EjCRUEd1eKMdb0Q/OpWdJLtKa/rjetOQo6Oypuro9i8Z
 4QZGYUOv7yvfB+bQvCBVn/1J8PGE63EC/kPAfT0Q36k9uihQUQkEib8L7eObwu9qqP
 nmua1yTbwzAiQ==
Received: by mail-ed1-f42.google.com with SMTP id u26so3812403eda.12
 for <iommu@lists.linux-foundation.org>; Wed, 23 Mar 2022 17:55:37 -0700 (PDT)
X-Gm-Message-State: AOAM532ImicTx2Qma408QswD7VdVV/ebdzKIAPPgNSqM0bWQTLaaadtL
 gB0q61KriK/vd8OqqF8Obyg1u25TPjp8rh/4sw==
X-Google-Smtp-Source: ABdhPJx1W8QOEZ5hwqRlDF/QFZDT+YJ7hcxbg7cfyRwDqZy6yyOAfpfXWiF/SIW30v36rh26i+KiOFb4/HbLsjBblEc=
X-Received: by 2002:a05:6402:686:b0:418:edaa:9cbc with SMTP id
 f6-20020a056402068600b00418edaa9cbcmr3676164edy.67.1648083335299; Wed, 23 Mar
 2022 17:55:35 -0700 (PDT)
MIME-Version: 1.0
References: <65657c5370fa0161739ba094ea948afdfa711b8a.1647967875.git.robin.murphy@arm.com>
 <874k3pxalr.wl-maz@kernel.org> <Yjub51Ct3esuNA9B@xps13.dannf>
In-Reply-To: <Yjub51Ct3esuNA9B@xps13.dannf>
From: Rob Herring <robh@kernel.org>
Date: Wed, 23 Mar 2022 19:55:23 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLFnN46WixKwsuhPswNo8fye4ERhU7_hPdPABi=70p7HA@mail.gmail.com>
Message-ID: <CAL_JsqLFnN46WixKwsuhPswNo8fye4ERhU7_hPdPABi=70p7HA@mail.gmail.com>
Subject: Re: [PATCH] iommu/dma: Explicitly sort PCI DMA windows
To: dann frazier <dann.frazier@canonical.com>
Cc: Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Robin Murphy <robin.murphy@arm.com>
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

On Wed, Mar 23, 2022 at 5:15 PM dann frazier <dann.frazier@canonical.com> wrote:
>
> On Wed, Mar 23, 2022 at 09:49:04AM +0000, Marc Zyngier wrote:
> > On Tue, 22 Mar 2022 17:27:36 +0000,
> > Robin Murphy <robin.murphy@arm.com> wrote:
> > >
> > > Originally, creating the dma_ranges resource list in pre-sorted fashion
> > > was the simplest and most efficient way to enforce the order required by
> > > iova_reserve_pci_windows(). However since then at least one PCI host
> > > driver is now re-sorting the list for its own probe-time processing,
> > > which doesn't seem entirely unreasonable, so that basic assumption no
> > > longer holds. Make iommu-dma robust and get the sort order it needs by
> > > explicitly sorting, which means we can also save the effort at creation
> > > time and just build the list in whatever natural order the DT had.
> > >
> > > Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> > > ---
> > >
> > > Looking at this area off the back of the XGene thread[1] made me realise
> > > that we need to do it anyway, regardless of whether it might also happen
> > > to restore the previous XGene behaviour or not. Presumably nobody's
> > > tried to use pcie-cadence-host behind an IOMMU yet...
> >
> > This definitely restores PCIe functionality on my Mustang (XGene-1).
> > Hopefully dann can comment on whether this addresses his own issue, as
> > his firmware is significantly different.
>
> Robin, Marc,
>
> Adding just this patch on top of v5.17 (w/ vendor dtb) isn't enough to
> fix m400 networking:

I wouldn't expect it to given both the IB register selection changed
and the 2nd dma-ranges entry is ignored.

Can you (and others) try out this branch:

git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git xgene-pci-fix

It should maintain the same IB register usage for both cases and
handle the error in 'dma-ranges'.

Rob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
