Return-Path: <SRS0=codQ=S4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90401C43218
	for <iommu@archiver.kernel.org>; Fri, 26 Apr 2019 15:15:43 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 697DB206BA
	for <iommu@archiver.kernel.org>; Fri, 26 Apr 2019 15:15:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 697DB206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 38CE62867;
	Fri, 26 Apr 2019 15:15:43 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 5565D27FA
	for <iommu@lists.linux-foundation.org>;
	Fri, 26 Apr 2019 15:13:47 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id EC8A382A
	for <iommu@lists.linux-foundation.org>;
	Fri, 26 Apr 2019 15:13:46 +0000 (UTC)
Received: by newverein.lst.de (Postfix, from userid 2407)
	id 8230D227A81; Fri, 26 Apr 2019 17:13:30 +0200 (CEST)
Date: Fri, 26 Apr 2019 17:13:30 +0200
From: Christoph Hellwig <hch@lst.de>
To: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: Re: [RFC PATCH] dma-mapping: create iommu mapping for newly
	allocated dma coherent mem
Message-ID: <20190426151330.GC20438@lst.de>
References: <20190422165125.21704-1-laurentiu.tudor@nxp.com>
	<20190422181100.GB32490@lst.de>
	<VI1PR04MB513407A66107759EC0DFE175EC230@VI1PR04MB5134.eurprd04.prod.outlook.com>
	<20190424145705.GB21480@lst.de>
	<b9f2b425-dde9-f9a1-b8fa-b7710e764b16@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b9f2b425-dde9-f9a1-b8fa-b7710e764b16@nxp.com>
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
Message-ID: <20190426151330.vg8ecM1Wj2NAOpko33tgzpH6cMa0UJgmS40msX9Apjw@z>

On Thu, Apr 25, 2019 at 11:30:54AM +0000, Laurentiu Tudor wrote:
> > I think the first step is to move the two USB controller that can only
> > DMA to their own BAR off the existing DMA coherent infrastructure.  The
> > controllers are already identified using the HCD_LOCAL_MEM flag, so we
> > just need to key off that in the hcd_buffer_* routines and call into a
> 
> So if HCD_LOCAL_MEM is set I should call into the gen_pool api instead 
> of existing dma_{alloc,free}_coherent().

Yes.

> > genalloc that has been fed using the bar, replacing the current
> > dma_declare_coherent usage.  Take a look at drivers/pci/p2pdma.c
> > for another example of allocating bits of a BAR using genalloc.
> 
> Where should I place the reference to the gen_pool? How does local_pool 
> in 'struct hcd_usb' sound?

Sounds fine to me, but in the end the usb maintainers will have
to decide.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
