Return-Path: <SRS0=MJs7=WM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA4BC3A59C
	for <iommu@archiver.kernel.org>; Fri, 16 Aug 2019 07:39:18 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EB4420644
	for <iommu@archiver.kernel.org>; Fri, 16 Aug 2019 07:39:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EB4420644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 1FC33CC6;
	Fri, 16 Aug 2019 07:39:18 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 5090ACB6
	for <iommu@lists.linux-foundation.org>;
	Fri, 16 Aug 2019 07:39:16 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com
	[209.85.210.67])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id A9EDEE5
	for <iommu@lists.linux-foundation.org>;
	Fri, 16 Aug 2019 07:39:15 +0000 (UTC)
Received: by mail-ot1-f67.google.com with SMTP id g17so8024674otl.2
	for <iommu@lists.linux-foundation.org>;
	Fri, 16 Aug 2019 00:39:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=rNgiwRT8IqruHTtyg4qTM81WOjWWtlc2s7dRDLMNYXA=;
	b=k7Pu65VWi66CgjDcsT1BBtrq6sSqW6CCSGvYhQJmkBNYVtYMxuGMjgDfDrv2EMCxNf
	MNPKppibMqi8tDqsdMjeP6TYsQ0rbbgyW+8Iw6dh+EbiLR0EsF6vSn0zuQHrTUxMX+f7
	92mbTd6Cr/U8Ex0uzRo5R972/a43rNDyDtTs1xCsexOJn2NLRiXM5gs5u7vmk+pdRR+T
	sj4gnt+e/YJ/Oh/jXxoFBLU+VxOMjS7uB+sZld5uLEJCVGcIhGWnju6vJ4bz6LR4clwP
	74CI3a4faKTFYLEHbDskkvYgA4UZxYm3dQPjffqrs/fQtHUfBbcucLx+Y7ABWfOV+WEm
	LBRQ==
X-Gm-Message-State: APjAAAUsE9snCiOwQWUegqn63lDphmbakCdfx7XJBCGcDQBOB/M8OXS8
	E2O/BUttlCy4+ff7+vhS+dss0ycK5B0Lt9CKKVo=
X-Google-Smtp-Source: APXvYqz193ixgGnhQHDM0sA58o87yH16orCv5VbCTsKEDkS808wZnFykFKzgKwDR213pxnj04zPYszKH8AWAfSfEEwQ=
X-Received: by 2002:a9d:68c5:: with SMTP id i5mr6603053oto.250.1565941154237; 
	Fri, 16 Aug 2019 00:39:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190816062435.881-1-hch@lst.de> <20190816062435.881-7-hch@lst.de>
In-Reply-To: <20190816062435.881-7-hch@lst.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 16 Aug 2019 09:39:03 +0200
Message-ID: <CAMuHMdVj+4Kh6pRGrz32w4zgwGHH4-r+-iHX1CSAXU6t4sprJw@mail.gmail.com>
Subject: Re: [PATCH 6/6] driver core: initialize a default DMA mask for
	platform device
To: Christoph Hellwig <hch@lst.de>
Cc: Gavin Li <git@thegavinli.com>, Shawn Guo <shawnguo@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Linux-Arch <linux-arch@vger.kernel.org>,
	Michal Simek <michal.simek@xilinx.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Alan Stern <stern@rowland.harvard.edu>, NXP Linux Team <linux-imx@nxp.com>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	linux-m68k <linux-m68k@lists.linux-m68k.org>,
	Minas Harutyunyan <hminas@synopsys.com>, Bin Liu <b-liu@ti.com>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	Geoff Levand <geoff@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	USB list <linux-usb@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux IOMMU <iommu@lists.linux-foundation.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
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

Hi Christoph,

On Fri, Aug 16, 2019 at 8:30 AM Christoph Hellwig <hch@lst.de> wrote:
> We still treat devices without a DMA mask as defaulting to 32-bits for
> both mask, but a few releases ago we've started warning about such
> cases, as they require special cases to work around this sloppyness.
> Add a dma_mask field to struct platform_device so that we can initialize
> the dma_mask pointer in struct device and initialize both masks to
> 32-bits by default, replacing similar functionality in m68k and
> powerpc.  The arch_setup_pdev_archdata hooks is now unused and removed.
>
> Note that the code looks a little odd with the various conditionals
> because we have to support platform_device structures that are
> statically allocated.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/m68k/kernel/dma.c               |  9 -------

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

>  arch/sh/boards/mach-ecovec24/setup.c |  2 --
>  arch/sh/boards/mach-migor/setup.c    |  1 -

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
given "[PATCH 0/2] Remove calls to empty arch_setup_pdev_archdata()"
https://lore.kernel.org/linux-renesas-soc/1526641611-2769-1-git-send-email-geert+renesas@glider.be/

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
