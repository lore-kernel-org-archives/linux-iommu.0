Return-Path: <SRS0=zE+z=V2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B44C76191
	for <iommu@archiver.kernel.org>; Mon, 29 Jul 2019 09:58:08 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F159206DD
	for <iommu@archiver.kernel.org>; Mon, 29 Jul 2019 09:58:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F159206DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 341C21466;
	Mon, 29 Jul 2019 09:58:08 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 53509145F
	for <iommu@lists.linux-foundation.org>;
	Mon, 29 Jul 2019 09:57:34 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
	[209.85.221.65])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 17CD15E4
	for <iommu@lists.linux-foundation.org>;
	Mon, 29 Jul 2019 09:57:33 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id n9so61215565wru.0
	for <iommu@lists.linux-foundation.org>;
	Mon, 29 Jul 2019 02:57:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=3EgmHLFik/OPgDdGuLMAdfuPiX1r55Htn8ht8rmVprc=;
	b=kH9aY/SjxjRC1g38QaG3sJ/nMFwbFzu8iINFgMC7F8laRQCqZBLyEijjMdmz7utXRw
	45Jiv1SsPylG2Wm0SyF5cEf6+oVdKGO0cYzjILthTNNp7EDRyp1bCpj3EX+BPW3j4ivR
	qxKrgPK6Zpq2Cl+gUdvWcOo2e8wjl4sQPetO/xLvexzvz5rQOVqX+ppz6N4T6MhF4PzW
	VYsQXM7rw6d1Etk3iajKwxKlU44KjIPoAj9NUikjaC6dr4NfU7yQ0vu+fR4j/vbOLMvS
	o3Jpejw6YQjSInMoqSsIPsmf6zupeLDmr263IpMiJFjBCqzqWChuFflRvZEKLV/Eljv2
	SnvA==
X-Gm-Message-State: APjAAAUAEZJeg3WYFwUmsO/k41HalMa9Jk9ND3JrYJK5+rlf9HLdWrBL
	FgUHJGbBtP/Pa+FvhfkyAni0ZkRir/IAaQIW1GQ=
X-Google-Smtp-Source: APXvYqwjfJqS4NGp1R7UrJA2JKANbRDFjcVknk63xGwZnvz1sSMLkkUqcYNpnDqWGXG4WZ8w21QgE4NZzRTpKbjjx94=
X-Received: by 2002:adf:f08f:: with SMTP id n15mr35431224wro.213.1564394251709;
	Mon, 29 Jul 2019 02:57:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190725063401.29904-1-hch@lst.de>
	<20190725063401.29904-5-hch@lst.de>
In-Reply-To: <20190725063401.29904-5-hch@lst.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 29 Jul 2019 11:57:19 +0200
Message-ID: <CAMuHMdUBPj8AVSuDwaBB_4gRD6k7vzo0WAFJEkTUbxSw31bzUg@mail.gmail.com>
Subject: Re: [PATCH 4/5] dma-mapping: provide a better default
	->get_required_mask
To: Christoph Hellwig <hch@lst.de>
Cc: linux-xtensa@linux-xtensa.org, Michal Simek <monstr@monstr.eu>,
	Parisc List <linux-parisc@vger.kernel.org>,
	Linux-sh list <linux-sh@vger.kernel.org>, Takashi Iwai <tiwai@suse.de>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	the arch/x86 maintainers <x86@kernel.org>,
	linux-m68k <linux-m68k@lists.linux-m68k.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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

On Thu, Jul 25, 2019 at 8:35 AM Christoph Hellwig <hch@lst.de> wrote:
> Most dma_map_ops instances are IOMMUs that work perfectly fine in 32-bits
> of IOVA space, and the generic direct mapping code already provides its
> own routines that is intelligent based on the amount of memory actually
> present.  Wire up the dma-direct routine for the ARM direct mapping code
> as well, and otherwise default to the constant 32-bit mask.  This way
> we only need to override it for the occasional odd IOMMU that requires
> 64-bit IOVA support, or IOMMU drivers that are more efficient if they
> can fall back to the direct mapping.

As I know you like diving into cans of worms ;-)

Does 64-bit IOVA support actually work in general? Or only on 64-bit
platforms, due to dma_addr_t to unsigned long truncation on 32-bit?

https://lore.kernel.org/linux-renesas-soc/CAMuHMdWkQ918Y61tMJbHEu29AGLEyNwbvZbSBB-RRH7YYUNRcA@mail.gmail.com/

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
