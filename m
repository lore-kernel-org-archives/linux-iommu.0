Return-Path: <SRS0=cQN6=S2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E96C282E1
	for <iommu@archiver.kernel.org>; Wed, 24 Apr 2019 14:57:24 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 757772084F
	for <iommu@archiver.kernel.org>; Wed, 24 Apr 2019 14:57:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 757772084F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 4262A13BD;
	Wed, 24 Apr 2019 14:57:24 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 2D5B2139B
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Apr 2019 14:57:23 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id BDE9174A
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Apr 2019 14:57:22 +0000 (UTC)
Received: by newverein.lst.de (Postfix, from userid 2407)
	id 5CBC367358; Wed, 24 Apr 2019 16:57:06 +0200 (CEST)
Date: Wed, 24 Apr 2019 16:57:05 +0200
From: Christoph Hellwig <hch@lst.de>
To: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: Re: [RFC PATCH] dma-mapping: create iommu mapping for newly
	allocated dma coherent mem
Message-ID: <20190424145705.GB21480@lst.de>
References: <20190422165125.21704-1-laurentiu.tudor@nxp.com>
	<20190422181100.GB32490@lst.de>
	<VI1PR04MB513407A66107759EC0DFE175EC230@VI1PR04MB5134.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <VI1PR04MB513407A66107759EC0DFE175EC230@VI1PR04MB5134.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Leo Li <leoyang.li@nxp.com>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	Christoph Hellwig <hch@lst.de>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190424145705.JBKBUh2RV20voA8Xp4dVUAfYbwPmRnhMzlKgZ1iez0s@z>

I'd be happy to offload all of the mentioned tasks to you if you
volunteer.

I think the first step is to move the two USB controller that can only
DMA to their own BAR off the existing DMA coherent infrastructure.  The
controllers are already identified using the HCD_LOCAL_MEM flag, so we
just need to key off that in the hcd_buffer_* routines and call into a
genalloc that has been fed using the bar, replacing the current
dma_declare_coherent usage.  Take a look at drivers/pci/p2pdma.c
for another example of allocating bits of a BAR using genalloc.

Another issue in that are just popped up, which is remoteproc_virtio.c,
which looks like a complete trainwreck.  I'll need to spend time to
figure out what the hell they are trying to first, though.

Then we need to kill the dma_declare_coherent_memory and
dma_release_declared_memory exports ASAP to avoid growing more users.

Next is figuring out how we want to plumb the OF / early boot coherent
regions into the iommu drivers.  I think I want to handle them similar
to the per-device CMA regions, that is each of the DMA ops has to
manually call into it instead of the page allocator.  Fortunately we
are down to only about a hand full of instances that are relevant
for the reserved memory now.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
