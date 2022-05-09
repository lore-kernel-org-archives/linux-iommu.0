Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC842C433F5
	for <iommu@archiver.kernel.org>; Mon,  9 May 2022 19:27:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 53D6A60E57;
	Mon,  9 May 2022 19:27:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0KVOdkG4gBdb; Mon,  9 May 2022 19:27:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4D0F860E60;
	Mon,  9 May 2022 19:27:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 20C1CC0032;
	Mon,  9 May 2022 19:27:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B10E0C002D
 for <iommu@lists.linux-foundation.org>; Mon,  9 May 2022 19:27:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 90FF84000B
 for <iommu@lists.linux-foundation.org>; Mon,  9 May 2022 19:27:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ea6rdj3ApTcs for <iommu@lists.linux-foundation.org>;
 Mon,  9 May 2022 19:27:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F13CA40004
 for <iommu@lists.linux-foundation.org>; Mon,  9 May 2022 19:27:32 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id C6FED61694
 for <iommu@lists.linux-foundation.org>; Mon,  9 May 2022 19:27:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37E3CC385BD
 for <iommu@lists.linux-foundation.org>; Mon,  9 May 2022 19:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1652124451;
 bh=LHhMugA56ra1E/f4M4s+HXIm7ikQL8aa6G58KTVtBz4=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=h2xt4MIT0hq1byYBVWoaJFVZH1PqfmapTHYVbY4QF1GfBw0gWYpkJvffxYVJROp/w
 o5e5XlseTtAbyczalx8WZma7nau3776eEMiPnAb+aH7DGy0paSceaMMK2NgH7mDaq7
 V6qTzsl90AZuCQCvlnnxzD8SWTPrbuwvdWXVVtFaMT3bvb+XpjRevOipjIyd5LJ+QM
 5lmV1PyqZUkQhLRASuo/BMjBfrdnF6ogjqVZ5ErYdH/2BTdCsGCeE1sWNtQT8ooI2a
 1MGt9OfEic40lzbwntnx56i0TY8f3A/Y94vuuNcULimj4Higp6KJ9f0rpfeGaAwk44
 BUgdRk+a2pzvw==
Received: by mail-pl1-f175.google.com with SMTP id n18so14803630plg.5
 for <iommu@lists.linux-foundation.org>; Mon, 09 May 2022 12:27:31 -0700 (PDT)
X-Gm-Message-State: AOAM533bDKAfK6uWtQ92cNzoNK0vMw/JExOTI7iB32CTTgvQmOCEH/lk
 i+vKusUDMRIz8DfMlGewRQM8vLhacutY1CRYvQ==
X-Google-Smtp-Source: ABdhPJxsHGmg1x9eSAFKq3936wK9SVxFgpdBQ4tMi6tmOw4dHd/EQlYww4Lzlp1GP6qEzY5zGXKq8YCcknR/kaYKZuM=
X-Received: by 2002:a17:902:9345:b0:15f:186b:e478 with SMTP id
 g5-20020a170902934500b0015f186be478mr4219682plp.117.1652124450742; Mon, 09
 May 2022 12:27:30 -0700 (PDT)
MIME-Version: 1.0
References: <35661036a7e4160850895f9b37f35408b6a29f2f.1652091160.git.robin.murphy@arm.com>
In-Reply-To: <35661036a7e4160850895f9b37f35408b6a29f2f.1652091160.git.robin.murphy@arm.com>
From: Rob Herring <robh@kernel.org>
Date: Mon, 9 May 2022 14:27:19 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLSt4n2LMC_Rcz01jYdzeAVM0aodBibSNxOcqt1m0vJfw@mail.gmail.com>
Message-ID: <CAL_JsqLSt4n2LMC_Rcz01jYdzeAVM0aodBibSNxOcqt1m0vJfw@mail.gmail.com>
Subject: Re: [PATCH v2] iommu/dma: Explicitly sort PCI DMA windows
To: Robin Murphy <robin.murphy@arm.com>
Cc: PCI <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Will Deacon <will@kernel.org>
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

On Mon, May 9, 2022 at 5:16 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> Originally, creating the dma_ranges resource list in pre-sorted fashion
> was the simplest and most efficient way to enforce the order required by
> iova_reserve_pci_windows(). However since then at least one PCI host
> driver is now re-sorting the list for its own probe-time processing,
> which doesn't seem entirely unreasonable, so that basic assumption no
> longer holds. Make iommu-dma robust and get the sort order it needs by
> explicitly sorting, which means we can also save the effort at creation
> time and just build the list in whatever natural order the DT had.
>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>
> v2: Clean up now-unused local variable
>
>  drivers/iommu/dma-iommu.c | 13 ++++++++++++-
>  drivers/pci/of.c          |  8 +-------
>  2 files changed, 13 insertions(+), 8 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
