Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47EBBC433FE
	for <iommu@archiver.kernel.org>; Thu,  2 Dec 2021 18:11:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DC0846066C;
	Thu,  2 Dec 2021 18:11:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EstHr7T0iGAp; Thu,  2 Dec 2021 18:11:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E65DE60654;
	Thu,  2 Dec 2021 18:11:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C0C54C0012;
	Thu,  2 Dec 2021 18:11:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5D0DDC000A
 for <iommu@lists.linux-foundation.org>; Thu,  2 Dec 2021 18:11:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4A95F6066C
 for <iommu@lists.linux-foundation.org>; Thu,  2 Dec 2021 18:11:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fK9ewp73XrCc for <iommu@lists.linux-foundation.org>;
 Thu,  2 Dec 2021 18:11:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9A1D760654
 for <iommu@lists.linux-foundation.org>; Thu,  2 Dec 2021 18:11:17 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9BC341435;
 Thu,  2 Dec 2021 10:11:16 -0800 (PST)
Received: from arm.com (arrakis.cambridge.arm.com [10.1.196.175])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2FEB23F766;
 Thu,  2 Dec 2021 10:11:15 -0800 (PST)
Date: Thu, 2 Dec 2021 18:11:12 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Calvin Zhang <calvinzhang.cool@gmail.com>
Subject: Re: [PATCH] mm: kmemleak: Ignore kmemleak scanning on CMA regions
Message-ID: <YakMQA1A75ZADeHi@arm.com>
References: <20211126024711.54937-1-calvinzhang.cool@gmail.com>
 <20211127160718.54e82aa93c977a367404a9e3@linux-foundation.org>
 <YaLgfYzxFRVamvdI@debian>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YaLgfYzxFRVamvdI@debian>
Cc: devicetree@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Frank Rowand <frowand.list@gmail.com>, Christoph Hellwig <hch@lst.de>
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

On Sun, Nov 28, 2021 at 09:50:53AM +0800, Calvin Zhang wrote:
> On Sat, Nov 27, 2021 at 04:07:18PM -0800, Andrew Morton wrote:
> >On Fri, 26 Nov 2021 10:47:11 +0800 Calvin Zhang <calvinzhang.cool@gmail.com> wrote:
> >> Just like this:
> >> commit 620951e27457 ("mm/cma: make kmemleak ignore CMA regions").
> >> 
> >> Add kmemleak_ignore_phys() for CMA created from of reserved node.
[...]
> >The 620951e27457 changelog says "Without this, the kernel crashes...". 
> >Does your patch also fix a crash?  If so under what circumstances and
> >should we backport this fix into -stable kernels?
> 
> No crash occurred. 620951e27457 avoids crashes caused by accessing
> highmem and it was fixed later. Now kmemleak_alloc_phys() and
> kmemleak_ignore_phys() skip highmem. This patch is based on the
> point that CMA regions don't contain pointers to other kmemleak
> objects, and ignores CMA regions from reserved memory as what
> 620951e27457 did.

Note that kmemleak_ignore() only works if there was a prior
kmemleak_alloc() on that address range. With the previous commit we get
this via the memblock_alloc_range() but I fail to see one on the
rmem_cma_setup() path.

-- 
Catalin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
