Return-Path: <SRS0=vyM6=WW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C2AC3A59E
	for <iommu@archiver.kernel.org>; Mon, 26 Aug 2019 07:09:59 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CD6F20874
	for <iommu@archiver.kernel.org>; Mon, 26 Aug 2019 07:09:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CD6F20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id E7A71FF7;
	Mon, 26 Aug 2019 07:09:58 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 5AB03FEC
	for <iommu@lists.linux-foundation.org>;
	Mon, 26 Aug 2019 07:09:44 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id EC75989B
	for <iommu@lists.linux-foundation.org>;
	Mon, 26 Aug 2019 07:09:43 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id B04E568B02; Mon, 26 Aug 2019 09:09:39 +0200 (CEST)
Date: Mon, 26 Aug 2019 09:09:39 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: Re: [PATCH v2 01/11] asm-generic: add dma_zone_size
Message-ID: <20190826070939.GD11331@lst.de>
References: <20190820145821.27214-1-nsaenzjulienne@suse.de>
	<20190820145821.27214-2-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190820145821.27214-2-nsaenzjulienne@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: catalin.marinas@arm.com, eric@anholt.net, linux-riscv@lists.infradead.org,
	frowand.list@gmail.com, hch@lst.de, linux-arch@vger.kernel.org,
	f.fainelli@gmail.com, will@kernel.org,
	devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	marc.zyngier@arm.com, robh+dt@kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, phill@raspberryi.org,
	mbrugger@suse.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	wahrenst@gmx.net, akpm@linux-foundation.org,
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

On Tue, Aug 20, 2019 at 04:58:09PM +0200, Nicolas Saenz Julienne wrote:
> Some architectures have platform specific DMA addressing limitations.
> This will allow for hardware description code to provide the constraints
> in a generic manner, so as for arch code to properly setup it's memory
> zones and DMA mask.

I know this just spreads the arm code, but I still kinda hate it.

MAX_DMA_ADDRESS is such an oddly defined concepts.  We have the mm
code that uses it to start allocating after the dma zones, but
I think that would better be done using a function returning
1 << max(zone_dma_bits, 32) or so.  Then we have about a handful
of drivers using it that all seem rather bogus, and one of which
I think are usable on arm64.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
