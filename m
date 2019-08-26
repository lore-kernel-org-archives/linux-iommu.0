Return-Path: <SRS0=vyM6=WW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42441C3A5A1
	for <iommu@archiver.kernel.org>; Mon, 26 Aug 2019 01:57:08 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03A0F20815
	for <iommu@archiver.kernel.org>; Mon, 26 Aug 2019 01:57:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="qEUlffBn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03A0F20815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id B077917CB;
	Mon, 26 Aug 2019 01:57:07 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id C9E8717CA
	for <iommu@lists.linux-foundation.org>;
	Mon, 26 Aug 2019 01:57:06 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com
	[210.131.2.91])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 523AF710
	for <iommu@lists.linux-foundation.org>;
	Mon, 26 Aug 2019 01:57:06 +0000 (UTC)
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com
	[209.85.222.42]) (authenticated)
	by conssluserg-06.nifty.com with ESMTP id x7Q1uoDi028780
	for <iommu@lists.linux-foundation.org>; Mon, 26 Aug 2019 10:56:51 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com x7Q1uoDi028780
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
	s=dec2015msa; t=1566784611;
	bh=Xw+wxYvXUGE3fRV+Doiiivavq+mUL1vvPgjRzYtJ358=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qEUlffBnvbyTRi4uQhlTUH+vofgwb9EaW33590XA9MrcgGTzxogl/oHgBozFk3o+y
	dDlDvn619VpEhOGIcZgbOvezBV8e15WgO5j2bPZ28u3/T/xFnG5AOVo5mk810x4yEM
	hPG3ps/8mTkGsS7Ausrg+7oLoD7S3YiOiXO29Td/QYtpKKwu+Fhng5kKhl2oZkwM4/
	iRmVXEldM/JCjJ6jK5WNJnJvlxl15g04T9dnVvHJx23jf8JpaPIChkW9rW3jLhmaqd
	J1gED6X+yT42OJUiAqwnDzEYTGFglAWCWfTMtLWmwVP/gFZuJtP31z/wrkRKZiYIg7
	QgLFwkXGrp+gA==
X-Nifty-SrcIP: [209.85.222.42]
Received: by mail-ua1-f42.google.com with SMTP id b2so3804094uak.3
	for <iommu@lists.linux-foundation.org>;
	Sun, 25 Aug 2019 18:56:51 -0700 (PDT)
X-Gm-Message-State: APjAAAWiBvDrHRPprh0u8HNzjD+06bQcEJ27ElX+GlQUOJYUulh5wkmy
	mJPUyEPBWgqzthUGgKiPtYnyh1Ha9UlK2/XV+Eg=
X-Google-Smtp-Source: APXvYqzdRMKAVamOOE+1e4sp/Bzd54Y2ifvgVrHPozgaBDgPJcD9G9g8zSB4pXJdG2r6CZRzYRRos2G+z4U8cxBoK20=
X-Received: by 2002:ab0:4261:: with SMTP id i88mr7473666uai.95.1566784610044; 
	Sun, 25 Aug 2019 18:56:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190506223334.1834-1-nicoleotsuka@gmail.com>
	<20190506223334.1834-3-nicoleotsuka@gmail.com>
	<CAK7LNARacEorb38mVBw_V-Zvz-znWgBma1AP1-z_5B_xZU4ogg@mail.gmail.com>
	<20190823221103.GA3604@Asurada-Nvidia.nvidia.com>
In-Reply-To: <20190823221103.GA3604@Asurada-Nvidia.nvidia.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Mon, 26 Aug 2019 10:56:14 +0900
X-Gmail-Original-Message-ID: <CAK7LNARrCviBr5j=2Lridh+MfbN1CFPU51cbpKDxNG6XKeQgdw@mail.gmail.com>
Message-ID: <CAK7LNARrCviBr5j=2Lridh+MfbN1CFPU51cbpKDxNG6XKeQgdw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] dma-contiguous: Use fallback alloc_pages for
	single pages
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>, Max Filippov <jcmvbkbc@gmail.com>,
	Christoph Hellwig <hch@lst.de>, Stephen Rothwell <sfr@canb.auug.org.au>,
	Russell King <linux@armlinux.org.uk>, Thierry Reding <treding@nvidia.com>,
	linux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	Chris Zankel <chris@zankel.net>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	iommu@lists.linux-foundation.org, iamjoonsoo.kim@lge.com,
	David Woodhouse <dwmw2@infradead.org>
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

Hi Nicolin,

On Sat, Aug 24, 2019 at 7:10 AM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>
> On Fri, Aug 23, 2019 at 09:49:46PM +0900, Masahiro Yamada wrote:

> >
> > Reverting this commit fixed the problem.
>
> We are having another problem with the new API and Christoph
> submitted a patch at: https://lkml.org/lkml/2019/8/20/86
>
> Would it be possible for you to test to see if it can fix?


It is included in 5.3-rc6

I tested 5.3-rc6 in on my board,
but I still see the same DMA fauilure.


Masahiro





> We can revert my fallback change after all, if Christoph's
> patch doesn't work for you either.
>
> Thanks
> Nicolin



-- 
Best Regards
Masahiro Yamada
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
