Return-Path: <SRS0=i+j8=MG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D762EC12002
	for <iommu@archiver.kernel.org>; Wed, 14 Jul 2021 20:52:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85740613CA
	for <iommu@archiver.kernel.org>; Wed, 14 Jul 2021 20:52:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85740613CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3453D40620;
	Wed, 14 Jul 2021 20:52:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BvnDD69z5PVQ; Wed, 14 Jul 2021 20:51:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9C034400F8;
	Wed, 14 Jul 2021 20:51:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 64132C001A;
	Wed, 14 Jul 2021 20:51:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F108AC000E
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 20:51:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D6CFD4035C
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 20:51:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fUDEMtfi38aY for <iommu@lists.linux-foundation.org>;
 Wed, 14 Jul 2021 20:51:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BA96A402FD
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 20:51:51 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 47B2D613D3
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 20:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1626295911;
 bh=xAyIdXe/5fhq34AXTyvgdjHjmK5ndfv86zQ48bk0AJE=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=WLPrmbY+/4G0TvI9fg6g5W/gH96ZMYa8lj/uZ1BhLE7SH6PB/P5a9HYbijdqUuTaL
 sKsL7R7hmGI11aE99N7FLPfwE3VMeU1/b1xpb5GNPUMfW8ydK8bson3RLBs3XgvcSW
 j+QxsuNrxkwlwLiPecBRrXHTMYmQDrJuxcdq4u3+yBdIOcUfsSR++EYhTBXZTzH9Fw
 cgAYzwKQ1QEUqUsmDwWaiYAdNscr3871knlhHMs5zteG+7IXqtoyalqWc9OBCnjGK2
 eDSOoI4b/akid9ZOzp/NBUWMJMmuDVllwd3O7bRU2DVDv22glZx6Dda2Foy75q6uvd
 bmHQoij/psogw==
Received: by mail-wm1-f48.google.com with SMTP id n4so2410766wms.1
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 13:51:51 -0700 (PDT)
X-Gm-Message-State: AOAM531fgN0kX3UYWeyFq3T/quTn94E7WtUAhUWIAXrNLm9QYCI/YEIL
 nwhA1kUwMYrQwXI0DCqjThGcCwg7IowU/mB/YK8=
X-Google-Smtp-Source: ABdhPJz63KW2Ft3EbkVjZmLO4vq5WYRyfYEAftI+sXxudBSXv9441/KxGl10WXB7ZvaYYnopUapzerEF9J1s+q7gcgU=
X-Received: by 2002:a1c:4e0c:: with SMTP id g12mr6068054wmh.120.1626295909914; 
 Wed, 14 Jul 2021 13:51:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210627143405.77298-1-sven@svenpeter.dev>
 <7261df01-34a9-4e53-37cd-ae1aa15b1fb4@arm.com>
In-Reply-To: <7261df01-34a9-4e53-37cd-ae1aa15b1fb4@arm.com>
From: Arnd Bergmann <arnd@kernel.org>
Date: Wed, 14 Jul 2021 22:51:34 +0200
X-Gmail-Original-Message-ID: <CAK8P3a18XK2mfMGbZ+M32Mbabhbkd+=DNrnzampOah_j=rWozw@mail.gmail.com>
Message-ID: <CAK8P3a18XK2mfMGbZ+M32Mbabhbkd+=DNrnzampOah_j=rWozw@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] Apple M1 DART IOMMU driver
To: Robin Murphy <robin.murphy@arm.com>
Cc: DTML <devicetree@vger.kernel.org>,
 Rouven Czerwinski <r.czerwinski@pengutronix.de>, Marc Zyngier <maz@kernel.org>,
 Hector Martin <marcan@marcan.st>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Rob Herring <robh+dt@kernel.org>, Alexander Graf <graf@amazon.com>,
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
 Mohamed Mediouni <mohamed.mediouni@caramail.com>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, Will Deacon <will@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Stan Skowronek <stan@corellium.com>
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

On Wed, Jul 14, 2021 at 8:21 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2021-06-27 15:34, Sven Peter wrote:
> [...]
> > In the long term, I'd like to extend the dma-iommu framework itself to
> > support iommu pagesizes with a larger granule than the CPU pagesize if that is
> > something you agree with.
>
> BTW this isn't something we can fully support in general. IOMMU API
> users may expect this to work:
>
> iommu_map(domain, iova, page_to_phys(p1), PAGE_SIZE, prot);
> iommu_map(domain, iova + PAGE_SIZE, page_to_phys(p2), PAGE_SIZE, prot);
>
> Although they do in principle have visibility of pgsize_bitmap, I still
> doubt anyone is really prepared for CPU-page-aligned mappings to fail.
> Even at the DMA API level you could hide *some* of it (at the cost of
> effectively only having 1/4 of the usable address space), but there are
> still cases like where v4l2 has a hard requirement that a page-aligned
> scatterlist can be mapped into a contiguous region of DMA addresses.

I think that was the same conclusion we had earlier: the dma-mapping
interfaces should be possible for large iotlb pages, but any driver directly
using the IOMMU API, such as VFIO, would not work.

The question is how we can best allow one but not the other.

         Arnd
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
