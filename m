Return-Path: <SRS0=C8jr=MS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C7AC432BE
	for <iommu@archiver.kernel.org>; Mon, 26 Jul 2021 20:04:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A67D60F9D
	for <iommu@archiver.kernel.org>; Mon, 26 Jul 2021 20:04:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5A67D60F9D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 24883402F6;
	Mon, 26 Jul 2021 20:04:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FXvSoToRCRMb; Mon, 26 Jul 2021 20:03:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id EA8EC402F5;
	Mon, 26 Jul 2021 20:03:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A2456C0010;
	Mon, 26 Jul 2021 20:03:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BECABC000E
 for <iommu@lists.linux-foundation.org>; Mon, 26 Jul 2021 20:03:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AD746402F6
 for <iommu@lists.linux-foundation.org>; Mon, 26 Jul 2021 20:03:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8-pH4n11fJwM for <iommu@lists.linux-foundation.org>;
 Mon, 26 Jul 2021 20:03:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 98B1E402F5
 for <iommu@lists.linux-foundation.org>; Mon, 26 Jul 2021 20:03:56 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id DA84E60F6E;
 Mon, 26 Jul 2021 20:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1627329836;
 bh=Wz9/1UR+NNm1PWmlemY6+S+vta0TSAKrTaG4D9BMtVU=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=ItiA4mf5ZlUSB7NEffLS/Ciydpncc8l8pOdGbITmrzKgIJkUUPs7R7WnKNHCWStGr
 UMVpaQdvW8JE+VQFNBHDaQsB8mcFjo+olM/SYE0Nw3dBEBTSoPiE/kuP+51PJDAHbc
 9LyxycyrPeKTiTHLQZXVMrTpXqm2vuSnU74u++9SnVjKnGi1ovv/O4P1G3bNRLhGZN
 xo9loHiTbvMdHtlivPsvwg5TqAsSJDlabH6OVICoR3gNqsT8O9DuLsOB+BvkpnwtBK
 1uYAZioNvM3X2whk38QJIYZ8yKznb03/U39coBfHVAAtVt3g5neSe41arfYpzXCh+q
 3xQ0VIy+aUH4g==
Date: Mon, 26 Jul 2021 13:03:55 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [GIT PULL] dma-mapping fix for Linux 5.14
In-Reply-To: <957943ce-c50e-1560-6f1b-aea0a1c9a114@oracle.com>
Message-ID: <alpine.DEB.2.21.2107261212500.10122@sstabellini-ThinkPad-T480s>
References: <YPz+qQ6dbZVDbMwu@infradead.org>
 <CAHk-=wi2OMmUkZFdQ0=uYmGeC3sv3eYw-p1=d51pJS-XVKaM2A@mail.gmail.com>
 <957943ce-c50e-1560-6f1b-aea0a1c9a114@oracle.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Cc: Stefano Stabellini <sstabellini@kernel.org>, rm.skakun@gmail.com,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>,
 iommu <iommu@lists.linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
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

On Mon, 26 Jul 2021, Boris Ostrovsky wrote:
> On 7/25/21 12:50 PM, Linus Torvalds wrote:
> > On Sat, Jul 24, 2021 at 11:03 PM Christoph Hellwig <hch@infradead.org> wrote:
> >
> >>   - handle vmalloc addresses in dma_common_{mmap,get_sgtable}
> >>     (Roman Skakun)
> > I've pulled this, but my reaction is that we've tried to avoid this in
> > the past. Why is Xen using vmalloc'ed addresses and passing those in
> > to the dma mapping routines?
> >
> > It *smells* to me like a Xen-swiotlb bug, and it would have been
> > better to try to fix it there. Was that just too painful?
> 
> 
> Stefano will probably know better but this appears to have something to do with how Pi (and possibly more ARM systems?) manage DMA memory: https://lore.kernel.org/xen-devel/CADz_WD5Ln7Pe1WAFp73d2Mz9wxspzTE3WgAJusp5S8LX4=83Bw@mail.gmail.com/.

The original issue was found on the Raspberry Pi 4, and the fix was in
swiotlb-xen.c, commit 8b1e868f6. More recently, Roman realized that
dma_common_mmap might also end up calling virt_to_page on a vmalloc
address. This is the fix for that.


Why is Xen using vmalloc'ed addresses with dma routines at all?

Xen is actually just calling the regular dma_direct_alloc to allocate
pages (xen_swiotlb_alloc_coherent -> xen_alloc_coherent_pages ->
dma_direct_alloc). dma_direct_alloc is the generic implementation. Back
when the original issue was found, dma_direct_alloc returned a vmalloc
address on RPi4.

The original analysis was "xen_alloc_coherent_pages() eventually calls
arch_dma_alloc() in remap.c which successfully allocates pages from
atomic pool." See https://marc.info/?l=xen-devel&m=158878173207775.


I don't know on which platform Roman Skakun (CC'ed) found the problem.
But if we look at arch/arm/mm/dma-mapping.c:__dma_alloc, one of the
possible options is the "remap_allocator", which calls
__alloc_remap_buffer, which calls dma_common_contiguous_remap, which
calls vmap.

So unfortunately it seems that on certain arch/platforms
dma_alloc_coherent can return a vmap'ed address. So I would imagine this
issue could also happen on native (without Xen), at least in theory.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
