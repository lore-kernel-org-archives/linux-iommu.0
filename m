Return-Path: <SRS0=JEM9=V3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB6EC433FF
	for <iommu@archiver.kernel.org>; Tue, 30 Jul 2019 06:30:34 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 562952064A
	for <iommu@archiver.kernel.org>; Tue, 30 Jul 2019 06:30:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 562952064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 2DFE02473;
	Tue, 30 Jul 2019 06:30:34 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 92A672467
	for <iommu@lists.linux-foundation.org>;
	Tue, 30 Jul 2019 06:26:57 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 2BF7FA8
	for <iommu@lists.linux-foundation.org>;
	Tue, 30 Jul 2019 06:26:57 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 221D568AEF; Tue, 30 Jul 2019 08:26:52 +0200 (CEST)
Date: Tue, 30 Jul 2019 08:26:51 +0200
From: Christoph Hellwig <hch@lst.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 4/5] dma-mapping: provide a better default
	->get_required_mask
Message-ID: <20190730062651.GA29518@lst.de>
References: <20190725063401.29904-1-hch@lst.de>
	<20190725063401.29904-5-hch@lst.de>
	<CAMuHMdUBPj8AVSuDwaBB_4gRD6k7vzo0WAFJEkTUbxSw31bzUg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAMuHMdUBPj8AVSuDwaBB_4gRD6k7vzo0WAFJEkTUbxSw31bzUg@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: linux-xtensa@linux-xtensa.org, Michal Simek <monstr@monstr.eu>,
	Parisc List <linux-parisc@vger.kernel.org>,
	Linux-sh list <linux-sh@vger.kernel.org>, Takashi Iwai <tiwai@suse.de>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	the arch/x86 maintainers <x86@kernel.org>,
	linux-m68k <linux-m68k@lists.linux-m68k.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux IOMMU <iommu@lists.linux-foundation.org>,
	Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
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

On Mon, Jul 29, 2019 at 11:57:19AM +0200, Geert Uytterhoeven wrote:
> Hi Christoph,
> 
> On Thu, Jul 25, 2019 at 8:35 AM Christoph Hellwig <hch@lst.de> wrote:
> > Most dma_map_ops instances are IOMMUs that work perfectly fine in 32-bits
> > of IOVA space, and the generic direct mapping code already provides its
> > own routines that is intelligent based on the amount of memory actually
> > present.  Wire up the dma-direct routine for the ARM direct mapping code
> > as well, and otherwise default to the constant 32-bit mask.  This way
> > we only need to override it for the occasional odd IOMMU that requires
> > 64-bit IOVA support, or IOMMU drivers that are more efficient if they
> > can fall back to the direct mapping.
> 
> As I know you like diving into cans of worms ;-)
> 
> Does 64-bit IOVA support actually work in general? Or only on 64-bit
> platforms, due to dma_addr_t to unsigned long truncation on 32-bit?

Most IOMMUs use 32-bit IOVAs, and thus we default to the 32-bit mask
because it is common and failsafe vs the normal linux assumptions.
However the ia64 SGI SN2 platform, and the powerpc IBM ebus
implementations seem to require a 64-bit mask already, so we keep that
behavior as is.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
