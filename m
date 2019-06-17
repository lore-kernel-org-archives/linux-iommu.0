Return-Path: <SRS0=Kmd8=UQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8986CC31E44
	for <iommu@archiver.kernel.org>; Mon, 17 Jun 2019 06:23:42 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55EC92189F
	for <iommu@archiver.kernel.org>; Mon, 17 Jun 2019 06:23:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55EC92189F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 18A4CC6A;
	Mon, 17 Jun 2019 06:23:42 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 61FC5A5E
	for <iommu@lists.linux-foundation.org>;
	Mon, 17 Jun 2019 06:23:40 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-lf1-f65.google.com (mail-lf1-f65.google.com
	[209.85.167.65])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 6D2452C3
	for <iommu@lists.linux-foundation.org>;
	Mon, 17 Jun 2019 06:23:39 +0000 (UTC)
Received: by mail-lf1-f65.google.com with SMTP id y13so5585014lfh.9
	for <iommu@lists.linux-foundation.org>;
	Sun, 16 Jun 2019 23:23:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=F7XRJjX0kBku2ATYK3GUg5Lrv9SchTe3YLEUK9ub8O0=;
	b=clADi7mys+p31YyUfQqiNeVpUGuoTyxa4BHpuOmsBENkO8N51k0VSQzf9WntZHhrSG
	GED4PmzazprReR+San7GwsWkwBuS33KzeWcWyGM1GbBoXtgHrTOL4pLG6FkYdAEUwcXQ
	VqoL0X4zz9kgh/6ig1kV+i6IftnT1cdQQG+O6hJ7QGp2iEi1Yr3cxAkerD781ZhtJWy8
	0L3hRxUq6XUlivJguZmAGL59C9UOiQQTA+XN7Icyrl+q5R1JL6foKlqNg9ENBp44aFsB
	4RqDvW0EhQwuJPQlcH2RArLBIuJd9RKWrJPn7QOEhk/XOWPTg3j/ZmjQjCrzMXnD3MjC
	zb5Q==
X-Gm-Message-State: APjAAAVpBVmRT7USk9mI64HjA6//aP7/TJtpJ/tufH/B9AU0Bk8AVCFh
	kL2FY5zrCiRnhRMTp4ftivM4N4rTpImR+qPzb9c=
X-Google-Smtp-Source: APXvYqy3bhMxkDPqSpihWCfeWIwNFdNEjnMbVm8tSrWIEMfR4v+33Zv0KgrWbN5daZ3WDGCGRcCppWVYxjCWl/bFHac=
X-Received: by 2002:a19:6e41:: with SMTP id q1mr46867465lfk.20.1560752617786; 
	Sun, 16 Jun 2019 23:23:37 -0700 (PDT)
MIME-Version: 1.0
References: <1560421215-10750-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<1560421215-10750-5-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<CAMuHMdXYqgPRX1WfUTRsKHhnSok5vfnr4AY36=vXoUvAxcNyWQ@mail.gmail.com>
	<20190614071800.GB8420@lst.de>
	<CAMuHMdXm5RtDUL5Wkyd6aJihu9nykYOhRf7vN6hOtB-OO8CTQQ@mail.gmail.com>
	<OSBPR01MB3590D4EF069F4554DA5D7ABBD8EB0@OSBPR01MB3590.jpnprd01.prod.outlook.com>
In-Reply-To: <OSBPR01MB3590D4EF069F4554DA5D7ABBD8EB0@OSBPR01MB3590.jpnprd01.prod.outlook.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 17 Jun 2019 08:23:24 +0200
Message-ID: <CAMuHMdWPUZGFWeKzPK=zkwc5h2SD+aW6ULb8C2rDJSmTWNXjeA@mail.gmail.com>
Subject: Re: [RFC PATCH v6 4/5] mmc: tmio: Use dma_max_mapping_size() instead
	of a workaround
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Linux MMC List <linux-mmc@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Linux IOMMU <iommu@lists.linux-foundation.org>,
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

Hi Shimoda-san,

On Mon, Jun 17, 2019 at 6:54 AM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> > From: Geert Uytterhoeven, Sent: Friday, June 14, 2019 4:27 PM
> > On Fri, Jun 14, 2019 at 9:18 AM Christoph Hellwig wrote:
> > > On Thu, Jun 13, 2019 at 10:35:44PM +0200, Geert Uytterhoeven wrote:
> > > > I'm always triggered by the use of min_t() and other casts:
> > > > mmc->max_blk_size and mmc->max_blk_count are both unsigned int.
> > > > dma_max_mapping_size() returns size_t, which can be 64-bit.
> > > >
> > > >  1) Can the multiplication overflow?
> > > >     Probably not, as per commit 2a55c1eac7882232 ("mmc: renesas_sdhi:
> > > >     prevent overflow for max_req_size"), but I thought I'd better ask.
>
> Geert-san:
>
> I agree.
>
> > > >  2) In theory, dma_max_mapping_size() can return a number that doesn't
> > > >     fit in 32-bit, and will be truncated (to e.g. 0), leading to max_req_size
> > > >     is zero?
>
> Geert-san:
>
> I agree. If dma_max_mapping_size() return 0x1_0000_0000, it will be truncated to 0
> and then max_req_size is set to zero. It is a problem. Also, the second argument
> "mmc->max_blk_size * mmc->max_blk_count" will not be overflow and then the value is
> 0xffff_ffff or less. So, I also think this should use size_t instead of unsigned int.
>
> > > This really should use a min_t on size_t.  Otherwise the patch looks
> > > fine:
> >
> > Followed by another min() to make it fit in mmc->max_req_size, which is
> > unsigned int.
>
> Geert-san:
>
> I'm afraid, but I cannot understand this means.
> Is this patch is possible to be upstream? Or, do you have any concern?

Please disregard my last comment: as the value of "mmc->max_blk_size *
mmc->max_blk_count" is always 0xffff_ffff or less, "min_t(size_t,
mmc->max_blk_size * mmc->max_blk_count, dma_max_mapping_size(&pdev->dev))"
will always be 0xffff_ffff or less, too, so there is no extra step needed
to make it fit in mmc->max_req_size.


Sorry for the confusion.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
