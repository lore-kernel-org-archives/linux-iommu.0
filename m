Return-Path: <SRS0=Lo8e=YA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDEF1C4740A
	for <iommu@archiver.kernel.org>; Mon,  7 Oct 2019 07:35:38 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91AA92196F
	for <iommu@archiver.kernel.org>; Mon,  7 Oct 2019 07:35:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91AA92196F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 6131141C;
	Mon,  7 Oct 2019 07:35:38 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id C95D740B
	for <iommu@lists.linux-foundation.org>;
	Mon,  7 Oct 2019 07:35:36 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-oi1-f195.google.com (mail-oi1-f195.google.com
	[209.85.167.195])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 6A3EED0
	for <iommu@lists.linux-foundation.org>;
	Mon,  7 Oct 2019 07:35:36 +0000 (UTC)
Received: by mail-oi1-f195.google.com with SMTP id m16so10819021oic.5
	for <iommu@lists.linux-foundation.org>;
	Mon, 07 Oct 2019 00:35:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=vC7dAYfXwJKhiTI/wvNma7+9JHZprD9j7d4aco906Rg=;
	b=mam/k1Q2i3c0UIa05S5rTLwuawHxp9pkCFqSo6SZJ6SIJnWNR8qe0v2pGeyeN9m/EF
	RkcyN/1utpT37nzAh+vcHwSGDjps6t2uEOv92c0NplUkqqSA6f4eLfp6URERXqZAzgAG
	ZJT/cOhoFZU2u8nDBmZ1++nulVq4/DPITIt2yf9e4smNNh1OIbEGY7IqXBs1EewWJcjl
	yGZS19v6poQkHq7sAPFlw/d3kv5RR5+Ta7bUpY2HBlQwSrDyalsCCmXUryY6yubHRi5a
	GWMFKmh7AM99zGIrB6/YB1TXxUNl1dn0+EzC2loFdkGIGRwqNU16fYZxEff9p18qYH08
	14tw==
X-Gm-Message-State: APjAAAWoCoDtCGJaw82uEpexeAefjv5oIu3BdCLZO/WvOK7dGv/5YfC4
	rpFRilwYCcoJTQZOiMZs4b5SylqZcBTbpvzNK/I=
X-Google-Smtp-Source: APXvYqz2xsowCyv7BriFiCE5eWCSUyFySeTWPsmMojbahQ43q5zsM0Wz1Yn++ZwgA8+zcnB3RXHRWT0R0cHyrvakUFU=
X-Received: by 2002:aca:b654:: with SMTP id g81mr16278742oif.153.1570433735656;
	Mon, 07 Oct 2019 00:35:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190830062924.21714-1-hch@lst.de>
	<20190830062924.21714-4-hch@lst.de>
	<CAMuHMdXxWp2=9n2LQA9KVH_ArOUnY78ZoiQ7ZsDMbTOGsEz4hw@mail.gmail.com>
	<20191006184541.GA4110@lst.de>
In-Reply-To: <20191006184541.GA4110@lst.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 7 Oct 2019 09:35:24 +0200
Message-ID: <CAMuHMdVdw8QGet8JxVPM9JOiQ1OG3rhbB7ha=mEQ7BdYGs4+gw@mail.gmail.com>
Subject: Re: [PATCH 3/4] dma-mapping: introduce a dma_common_find_pages helper
To: Christoph Hellwig <hch@lst.de>
Cc: linux-xtensa@linux-xtensa.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
	Linux MM <linux-mm@kvack.org>,
	Linux IOMMU <iommu@lists.linux-foundation.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>
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

On Sun, Oct 6, 2019 at 8:45 PM Christoph Hellwig <hch@lst.de> wrote:
> please try Linus' current tree.  It has a fix from Andrey Smirnov
> for what looks the same problem that you reported.

Thanks, confirmed fixed by commit 2cf2aa6a69db0b17 ("dma-mapping: fix
false positivse warnings in dma_common_free_remap()").

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
