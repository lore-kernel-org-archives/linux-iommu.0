Return-Path: <SRS0=yPDG=DQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0AB7C433E7
	for <iommu@archiver.kernel.org>; Fri,  9 Oct 2020 07:37:56 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FE182227E
	for <iommu@archiver.kernel.org>; Fri,  9 Oct 2020 07:37:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hr/EfPQd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FE182227E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9FE36876C5;
	Fri,  9 Oct 2020 07:37:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3M-if-CWCX8U; Fri,  9 Oct 2020 07:37:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 22EED876B8;
	Fri,  9 Oct 2020 07:37:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E5B67C016F;
	Fri,  9 Oct 2020 07:37:54 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 30A15C0051
 for <iommu@lists.linux-foundation.org>; Fri,  9 Oct 2020 07:37:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 1848F876C5
 for <iommu@lists.linux-foundation.org>; Fri,  9 Oct 2020 07:37:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JvW7YxVpIabA for <iommu@lists.linux-foundation.org>;
 Fri,  9 Oct 2020 07:37:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 6DE38876B8
 for <iommu@lists.linux-foundation.org>; Fri,  9 Oct 2020 07:37:52 +0000 (UTC)
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com
 [209.85.210.41])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C5F2F22282
 for <iommu@lists.linux-foundation.org>; Fri,  9 Oct 2020 07:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1602229071;
 bh=uwHGsExUwomnGZGAB9Ig2cy91/4zjXFRWuSoOtt/2uc=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=hr/EfPQdRr7YOMI/Ml+6/nicYKOq2pzsRkwJDK4QOWHasA7h3oiXAIpK8Icq9k0cv
 B+Pr4QjjAsu4RyNsMNzqa5+CA1tTcrgTjx2kn0DhJTQgTTn8izNoFlcMq6d6kgu0vn
 6IJ/b+FrCQ4BlPeeC2xEElSxY1bwAgxst0UX0QZs=
Received: by mail-ot1-f41.google.com with SMTP id m11so8129739otk.13
 for <iommu@lists.linux-foundation.org>; Fri, 09 Oct 2020 00:37:51 -0700 (PDT)
X-Gm-Message-State: AOAM533Iytmv/B3/fj+QEqhQebxIHE5bT5sKKkyPBtnY1IbgJ4Kg6WxM
 /Z3/uOVDJY7Kyp4BuSWRZPhwPPl8/aCneiMBrCg=
X-Google-Smtp-Source: ABdhPJwm7Itaee4mU5h+ix4hYGBefWmG86wT+rm9HR2eTuMvzP6PBTs811cyWxyuLFCA+ubq6YIJxYBgULsTYR7jHG8=
X-Received: by 2002:a9d:6a85:: with SMTP id l5mr8311994otq.77.1602229071004;
 Fri, 09 Oct 2020 00:37:51 -0700 (PDT)
MIME-Version: 1.0
References: <20201001161740.29064-1-nsaenzjulienne@suse.de>
 <20201001161740.29064-2-nsaenzjulienne@suse.de> <20201001171500.GN21544@gaia>
 <20201001172320.GQ21544@gaia>
 <b47232e2173e9e5ddf8f5be4c7b5a2f897f34eb7.camel@suse.de>
 <20201002115541.GC7034@gaia>
 <12f33d487eabd626db4c07ded5a1447795eed355.camel@suse.de>
 <20201009071013.GA12208@lst.de>
In-Reply-To: <20201009071013.GA12208@lst.de>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 9 Oct 2020 09:37:39 +0200
X-Gmail-Original-Message-ID: <CAMj1kXG+7Lq=rgUfyU_XS9LrJwpUiC8nKsRPom+R0=phuXioHQ@mail.gmail.com>
Message-ID: <CAMj1kXG+7Lq=rgUfyU_XS9LrJwpUiC8nKsRPom+R0=phuXioHQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] of/fdt: Update zone_dma_bits when running in bcm2711
To: Christoph Hellwig <hch@lst.de>
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Will Deacon <will@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Memory Management List <linux-mm@kvack.org>,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 linux-rpi-kernel@lists.infradead.org, Frank Rowand <frowand.list@gmail.com>,
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

On Fri, 9 Oct 2020 at 09:11, Christoph Hellwig <hch@lst.de> wrote:
>
> On Thu, Oct 08, 2020 at 12:05:25PM +0200, Nicolas Saenz Julienne wrote:
> > Sadly I just realised that the series is incomplete, we have RPi4 users that
> > want to boot unsing ACPI, and this series would break things for them. I'll
> > have a word with them to see what we can do for their use-case.
>
> Stupid question:  why do these users insist on a totally unsuitable
> interface?  And why would we as Linux developers care to support such
> a aims?
>

The point is really whether we want to revert changes in Linux that
made both DT and ACPI boot work without quirks on RPi4. Having to
check the RPi4 compatible string or OEM id in core init code is awful,
regardless of whether you boot via ACPI or via DT.

The problem with this hardware is that it uses a DMA mask which is
narrower than 32, and the arm64 kernel is simply not set up to deal
with that at all. On DT, we have DMA ranges properties and the likes
to describe such limitations, on ACPI we have _DMA methods as well as
DMA range attributes in the IORT, both of which are now handled
correctly. So all the information is there, we just have to figure out
how to consume it early on.

Interestingly, this limitation always existed in the SoC, but it
wasn't until they started shipping it with more than 1 GB of DRAM that
it became a problem. This means issues like this could resurface in
the future with existing SoCs when they get shipped with more memory,
and so I would prefer fixing this in a generic way.

Also, I assume papering over the issue like this does not fix the
kdump issue fundamentally, it just works around it, and so we might
run into this again in the future.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
