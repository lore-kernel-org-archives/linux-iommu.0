Return-Path: <SRS0=dlfR=AT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8400C433E1
	for <iommu@archiver.kernel.org>; Wed,  8 Jul 2020 15:36:42 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D85220720
	for <iommu@archiver.kernel.org>; Wed,  8 Jul 2020 15:36:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D85220720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 623998854A;
	Wed,  8 Jul 2020 15:36:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id I-SfzUpIWm6Q; Wed,  8 Jul 2020 15:36:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 668D3885B6;
	Wed,  8 Jul 2020 15:36:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 529A1C0893;
	Wed,  8 Jul 2020 15:36:41 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 45F9EC016F
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jul 2020 15:36:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 4037A87CCB
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jul 2020 15:36:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IFS5AX5nbULu for <iommu@lists.linux-foundation.org>;
 Wed,  8 Jul 2020 15:36:39 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 1964E87CC5
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jul 2020 15:36:39 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 6727E68B05; Wed,  8 Jul 2020 17:36:36 +0200 (CEST)
Date: Wed, 8 Jul 2020 17:36:35 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: Re: [PATCH] dma-pool: use single atomic pool for both DMA zones
Message-ID: <20200708153635.GB26743@lst.de>
References: <20200707122804.21262-1-nsaenzjulienne@suse.de>
 <e6504dc5-4169-edf9-d08e-17a378a1ef7a@arm.com>
 <21a7276e98ae245404d82537ac1ee597a92f9150.camel@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <21a7276e98ae245404d82537ac1ee597a92f9150.camel@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: linux-kernel@vger.kernel.org, Jeremy Linton <jeremy.linton@arm.com>,
 iommu@lists.linux-foundation.org, linux-rpi-kernel@lists.infradead.org,
 David Rientjes <rientjes@google.com>, Robin Murphy <robin.murphy@arm.com>,
 Christoph Hellwig <hch@lst.de>
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

On Wed, Jul 08, 2020 at 12:35:34PM +0200, Nicolas Saenz Julienne wrote:
> > Which allows me to switch between ACPI/DT on the machine. In DT mode it 
> > works fine now, 
> 
> Nice, would that count as a Tested-by from you?
> 
> > but with ACPI I continue to have failures unless I 
> > disable CMA via cma=0 on the kernel command line. 
> 
> Yes, I see why, in atomic_pool_expand() memory is allocated from CMA without
> checking its correctness. That calls for a separate fix. I'll try to think of
> something.

I think we need a dma_coherent_ok for the allocations from the
pool and then fall back to the next better one to get started.  And
yes, CMA is a bit of a mess, that generally needs better checks.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
