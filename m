Return-Path: <SRS0=MJs7=WM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27BA8C41514
	for <iommu@archiver.kernel.org>; Fri, 16 Aug 2019 07:43:54 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 057EA21773
	for <iommu@archiver.kernel.org>; Fri, 16 Aug 2019 07:43:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 057EA21773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id BE8E7CB7;
	Fri, 16 Aug 2019 07:43:53 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 5FF8BCB6
	for <iommu@lists.linux-foundation.org>;
	Fri, 16 Aug 2019 07:43:52 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-oi1-f194.google.com (mail-oi1-f194.google.com
	[209.85.167.194])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id EF425E5
	for <iommu@lists.linux-foundation.org>;
	Fri, 16 Aug 2019 07:43:51 +0000 (UTC)
Received: by mail-oi1-f194.google.com with SMTP id h21so4185693oie.7
	for <iommu@lists.linux-foundation.org>;
	Fri, 16 Aug 2019 00:43:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=bvAyBsUlIJF0bF+3UmDVqzcZaxe3TRuVyFQ4SKm03Ag=;
	b=OQlLpaBSTtZSvbpSF5h6iMm5zCydkNkcffyDBBlop8lEkk/WxKhL7ND/FhoKCjpQaO
	qWeN5EuZMzHyjJI4PuJPi4AOxGutMPv5WgbJnuDNVmFl7S5vPXtyqCP834fQbaa6M90l
	ku2DS+9ApqbD3AGJcXHumHVCBSzVWi8iGuTAttWYomR0k41uYtyMGZ3LXSBRB4MAVVcP
	BE3u6MqNwj+HfZXOn0h6t8lz4EctcTbfeeJORnWILyKEI6PRT6NwsKXhG8TwNAlQqcW0
	SZMz8tyt3qvOd5yTTvuVg9czyM5j+hVQyEm4xLnZaTodowPLb+MnjZ8dcA37Hym4XzjE
	KRMw==
X-Gm-Message-State: APjAAAU9viosNQ7hjH8XCGwhuJOyfAXqQgw2/9JYzao0RMIUH4626Qyx
	43uJIK4AA0aBZWQlYccCBa/gdG6vGGEous4XoBM=
X-Google-Smtp-Source: APXvYqxDhwWwhe23FnPOhfwBJdvvv1RZQ4uxY4zTeFQQdGxuUoRdT5WMzdETbuNlDvSjEY17/b21joZDSXi2Bi1nfwg=
X-Received: by 2002:a54:478d:: with SMTP id o13mr4253177oic.54.1565941431065; 
	Fri, 16 Aug 2019 00:43:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190816070754.15653-1-hch@lst.de>
	<20190816070754.15653-5-hch@lst.de>
In-Reply-To: <20190816070754.15653-5-hch@lst.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 16 Aug 2019 09:43:40 +0200
Message-ID: <CAMuHMdVk3LZk3Ro3PYn9aOZ6NRUr5AOp+NwSNiaq2hBTS0-BtQ@mail.gmail.com>
Subject: Re: [PATCH 4/6] dma-mapping: remove arch_dma_mmap_pgprot
To: Christoph Hellwig <hch@lst.de>
Cc: Shawn Anastasio <shawn@anastas.io>,
	linux-m68k <linux-m68k@lists.linux-m68k.org>,
	Will Deacon <will@kernel.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux IOMMU <iommu@lists.linux-foundation.org>,
	Paul Burton <paul.burton@mips.com>,
	Catalin Marinas <catalin.marinas@arm.com>, James Hogan <jhogan@kernel.org>,
	Russell King <linux@armlinux.org.uk>, linux-mips@vger.kernel.org,
	Guan Xuetao <gxt@pku.edu.cn>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
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

On Fri, Aug 16, 2019 at 9:19 AM Christoph Hellwig <hch@lst.de> wrote:
> arch_dma_mmap_pgprot is used for two things:
>
>  1) to override the "normal" uncached page attributes for mapping
>     memory coherent to devices that can't snoop the CPU caches
>  2) to provide the special DMA_ATTR_WRITE_COMBINE semantics on older
>     arm systems
>
> Replace one with the pgprot_dmacoherent macro that is already provided
> by arm and much simpler to use, and lift the DMA_ATTR_WRITE_COMBINE
> handling to common code with an explicit arch opt-in.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

>  arch/m68k/Kconfig                  |  1 -
>  arch/m68k/include/asm/pgtable_mm.h |  3 +++
>  arch/m68k/kernel/dma.c             |  3 +--

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

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
