Return-Path: <SRS0=bugC=HJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1208C433E0
	for <iommu@archiver.kernel.org>; Sun,  7 Feb 2021 15:56:16 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 186F2601FB
	for <iommu@archiver.kernel.org>; Sun,  7 Feb 2021 15:56:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 186F2601FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id E640B867AC;
	Sun,  7 Feb 2021 15:56:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6Y8SFYY+djRL; Sun,  7 Feb 2021 15:56:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1EC048691C;
	Sun,  7 Feb 2021 15:56:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0815DC0891;
	Sun,  7 Feb 2021 15:56:14 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3B898C013A
 for <iommu@lists.linux-foundation.org>; Sun,  7 Feb 2021 15:56:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 348DD8678B
 for <iommu@lists.linux-foundation.org>; Sun,  7 Feb 2021 15:56:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pdxpKRHW-dlP for <iommu@lists.linux-foundation.org>;
 Sun,  7 Feb 2021 15:56:10 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by whitealder.osuosl.org (Postfix) with ESMTPS id A4C408691C
 for <iommu@lists.linux-foundation.org>; Sun,  7 Feb 2021 15:56:10 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 3732F68B02; Sun,  7 Feb 2021 16:56:02 +0100 (CET)
Date: Sun, 7 Feb 2021 16:56:01 +0100
From: Christoph Hellwig <hch@lst.de>
To: Dongli Zhang <dongli.zhang@oracle.com>
Subject: Re: [PATCH RFC v1 5/6] xen-swiotlb: convert variables to arrays
Message-ID: <20210207155601.GA25111@lst.de>
References: <20210203233709.19819-1-dongli.zhang@oracle.com>
 <20210203233709.19819-6-dongli.zhang@oracle.com>
 <20210204084023.GA32328@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210204084023.GA32328@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: ulf.hansson@linaro.org, airlied@linux.ie, benh@kernel.crashing.org,
 joonas.lahtinen@linux.intel.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, bhelgaas@google.com, paulus@samba.org,
 hpa@zytor.com, hch@lst.de, sstabellini@kernel.org, adrian.hunter@intel.com,
 mpe@ellerman.id.au, x86@kernel.org, joe.jin@oracle.com, mingo@kernel.org,
 peterz@infradead.org, mingo@redhat.com, bskeggs@redhat.com,
 linux-pci@vger.kernel.org, xen-devel@lists.xenproject.org,
 matthew.auld@intel.com, thomas.lendacky@amd.com, konrad.wilk@oracle.com,
 intel-gfx@lists.freedesktop.org, jani.nikula@linux.intel.com, bp@alien8.de,
 rodrigo.vivi@intel.com, nouveau@lists.freedesktop.org,
 boris.ostrovsky@oracle.com, chris@chris-wilson.co.uk, jgross@suse.com,
 tsbogend@alpha.franken.de, robin.murphy@arm.com, linux-mmc@vger.kernel.org,
 linux-mips@vger.kernel.org, iommu@lists.linux-foundation.org,
 tglx@linutronix.de, daniel@ffwll.ch, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, rppt@kernel.org
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

On Thu, Feb 04, 2021 at 09:40:23AM +0100, Christoph Hellwig wrote:
> So one thing that has been on my mind for a while:  I'd really like
> to kill the separate dma ops in Xen swiotlb.  If we compare xen-swiotlb
> to swiotlb the main difference seems to be:
> 
>  - additional reasons to bounce I/O vs the plain DMA capable
>  - the possibility to do a hypercall on arm/arm64
>  - an extra translation layer before doing the phys_to_dma and vice
>    versa
>  - an special memory allocator
> 
> I wonder if inbetween a few jump labels or other no overhead enablement
> options and possibly better use of the dma_range_map we could kill
> off most of swiotlb-xen instead of maintaining all this code duplication?

So I looked at this a bit more.

For x86 with XENFEAT_auto_translated_physmap (how common is that?)
pfn_to_gfn is a nop, so plain phys_to_dma/dma_to_phys do work as-is.

xen_arch_need_swiotlb always returns true for x86, and
range_straddles_page_boundary should never be true for the
XENFEAT_auto_translated_physmap case.

So as far as I can tell the mapping fast path for the
XENFEAT_auto_translated_physmap can be trivially reused from swiotlb.

That leaves us with the next more complicated case, x86 or fully cache
coherent arm{,64} without XENFEAT_auto_translated_physmap.  In that case
we need to patch in a phys_to_dma/dma_to_phys that performs the MFN
lookup, which could be done using alternatives or jump labels.
I think if that is done right we should also be able to let that cover
the foreign pages in is_xen_swiotlb_buffer/is_swiotlb_buffer, but
in that worst case that would need another alternative / jump label.

For non-coherent arm{,64} we'd also need to use alternatives or jump
labels to for the cache maintainance ops, but that isn't a hard problem
either.


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
