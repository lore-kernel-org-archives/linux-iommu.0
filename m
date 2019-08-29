Return-Path: <SRS0=xflu=WZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 425C1C3A5A3
	for <iommu@archiver.kernel.org>; Thu, 29 Aug 2019 11:47:04 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 096DF205ED
	for <iommu@archiver.kernel.org>; Thu, 29 Aug 2019 11:47:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="v0DIYa/N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 096DF205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id A52EC473F;
	Thu, 29 Aug 2019 11:47:03 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id DA0A64739
	for <iommu@lists.linux-foundation.org>;
	Thu, 29 Aug 2019 11:46:36 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com
	[210.131.2.91])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 484F03D0
	for <iommu@lists.linux-foundation.org>;
	Thu, 29 Aug 2019 11:46:36 +0000 (UTC)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com
	[209.85.217.46]) (authenticated)
	by conssluserg-06.nifty.com with ESMTP id x7TBk6IH015457
	for <iommu@lists.linux-foundation.org>; Thu, 29 Aug 2019 20:46:06 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com x7TBk6IH015457
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
	s=dec2015msa; t=1567079167;
	bh=jJHAKRHFRUzF/5jWYYKHoeNpyJFG8X4zd/Hk645vV1s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=v0DIYa/N3Xb1q0ZoiyisojONsg5VPrer3W7UwpyB5KRroyEh9h5haUmjjoJLQKzb4
	tmoYTtGvBHScodv8lX0osiq7GfA0tbDtfF8UGeRoB5qTUmhdpEStRhRFwax/ZDdWhn
	z306pev+Nbic0pcC1kkvmBrtzy5j8okAn0hJXGgQeuM9ic/1Mn7mrmNHJsxYBGDazw
	8Vq0H89pLo7Cpr4AZ5lb7q6gSUCVvAilMVz3XeTv7+T787gA1icyMc1WNOLAo9ZJj5
	aJG2EllT6dSOBWZePoV0ADx73NY/tesBrX7WZkoph+VhsDLSoGmuA/SX6I8nVl5qVk
	H0L90mwVgDOZQ==
X-Nifty-SrcIP: [209.85.217.46]
Received: by mail-vs1-f46.google.com with SMTP id b20so2214685vso.1
	for <iommu@lists.linux-foundation.org>;
	Thu, 29 Aug 2019 04:46:06 -0700 (PDT)
X-Gm-Message-State: APjAAAXciyb5RTkgJbgdYPtimLnAFiWww4Kvf13ThMSKOe8gTO3+QqlL
	cfKz97kHsC/Bynko1Xc89OQ9dNQPEoUZUOpMhiw=
X-Google-Smtp-Source: APXvYqySzvmeE9kiWjvNGM1iaAxnZ+QgH8m0ESiSIlhk3/0sUZoqbPgAj7pYaewNuKSsBX5H2zvSqil85IeqcrkN9II=
X-Received: by 2002:a67:fe12:: with SMTP id l18mr5139562vsr.54.1567079164044; 
	Thu, 29 Aug 2019 04:46:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190506223334.1834-1-nicoleotsuka@gmail.com>
	<20190506223334.1834-3-nicoleotsuka@gmail.com>
	<CAK7LNARacEorb38mVBw_V-Zvz-znWgBma1AP1-z_5B_xZU4ogg@mail.gmail.com>
	<CAK7LNAQfYBCoChMV=MOwcUyVoqRkrPWs7DaWdzDqjBe18gGiAQ@mail.gmail.com>
	<20190825011025.GA23410@lst.de>
	<CAK7LNAQb1ZHr=DiHLNeNRaQExMuXdDOV4sFghoGbco_Q=Qzb8g@mail.gmail.com>
	<20190826073320.GA11712@lst.de>
	<CAK7LNATYOLEboUTO4qPx2z7cqwDrHBO1HFHG8VzZEJ15STv+nw@mail.gmail.com>
	<20190827075021.GA953@lst.de>
	<CAK7LNAQZ+bueZZzSoMADmgLjWNvijHRV=wLQzN_kvLG3b5Uu+w@mail.gmail.com>
	<20190827115541.GB5921@lst.de>
	<CAK7LNAQ_nQcBt=xH1-h+=co85mTxFgbe+_46Gu4LaNsDSm+kYA@mail.gmail.com>
	<CAK7LNATvz=TTe+3OyLrtUqDuTUTn1dg9Sk-t3BD_OFZfViCPMw@mail.gmail.com>
In-Reply-To: <CAK7LNATvz=TTe+3OyLrtUqDuTUTn1dg9Sk-t3BD_OFZfViCPMw@mail.gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Thu, 29 Aug 2019 20:45:27 +0900
X-Gmail-Original-Message-ID: <CAK7LNASs2qkpGY_BkL--hvmKm3FJ9sEK4+v5VVYc1_CrowAB4w@mail.gmail.com>
Message-ID: <CAK7LNASs2qkpGY_BkL--hvmKm3FJ9sEK4+v5VVYc1_CrowAB4w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] dma-contiguous: Use fallback alloc_pages for
	single pages
To: Christoph Hellwig <hch@lst.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Tony Lindgren <tony@atomide.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Max Filippov <jcmvbkbc@gmail.com>, Stephen Rothwell <sfr@canb.auug.org.au>,
	Russell King <linux@armlinux.org.uk>, Thierry Reding <treding@nvidia.com>,
	linux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	Chris Zankel <chris@zankel.net>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	David Woodhouse <dwmw2@infradead.org>,
	linux-mmc <linux-mmc@vger.kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	iommu@lists.linux-foundation.org, iamjoonsoo.kim@lge.com,
	Robin Murphy <robin.murphy@arm.com>
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

On Wed, Aug 28, 2019 at 9:23 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> On Wed, Aug 28, 2019 at 7:53 PM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
> >
> > Hi Christoph,
> >
> > On Tue, Aug 27, 2019 at 8:55 PM Christoph Hellwig <hch@lst.de> wrote:
> > >
> > > On Tue, Aug 27, 2019 at 06:03:14PM +0900, Masahiro Yamada wrote:
> > > > Yes, this makes my driver working again
> > > > when CONFIG_DMA_CMA=y.
> > > >
> > > >
> > > > If I apply the following, my driver gets back working
> > > > irrespective of CONFIG_DMA_CMA.
> > >
> > > That sounds a lot like the device simply isn't 64-bit DMA capable, and
> > > previously always got CMA allocations under the limit it actually
> > > supported.  I suggest that you submit this quirk to the mmc maintainers.
> >
> >
> > I tested v5.2 and my MMC host controller works with
> > dma_address that exceeds 32-bit physical address.
> >
> > So, I believe my MMC device is 64-bit DMA capable.
> >
> > I am still looking into the code
> > to find out what was changed.
>
>
> I retract this comment.
>
> Prior to bd2e75633c8012fc8a7431c82fda66237133bf7e,
> the descriptor table for ADMA is placed within the
> 32-bit phys address range, not exceeds the 32-bit limit.
>
> Probably, my device is not 64-bit capable.
>
> I will talk to the hardware engineer,
> and check the hardware spec just in case.
>


After looking more into my hardware,
I found out how to fix my driver:
https://lore.kernel.org/patchwork/patch/1121600/



-- 
Best Regards
Masahiro Yamada
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
