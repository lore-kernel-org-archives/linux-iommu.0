Return-Path: <SRS0=R8za=TV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B77C04AAF
	for <iommu@archiver.kernel.org>; Tue, 21 May 2019 13:04:31 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3071721773
	for <iommu@archiver.kernel.org>; Tue, 21 May 2019 13:04:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3071721773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id C8D63C11;
	Tue, 21 May 2019 13:04:30 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 6C66DBDC
	for <iommu@lists.linux-foundation.org>;
	Tue, 21 May 2019 13:04:29 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id F0B1D27B
	for <iommu@lists.linux-foundation.org>;
	Tue, 21 May 2019 13:04:28 +0000 (UTC)
Received: by newverein.lst.de (Postfix, from userid 2407)
	id AF38268B20; Tue, 21 May 2019 15:04:03 +0200 (CEST)
Date: Tue, 21 May 2019 15:04:02 +0200
From: Christoph Hellwig <hch@lst.de>
To: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Subject: Re: [PATCH 2/2] ARM: dma-mapping: allow larger DMA mask than supported
Message-ID: <20190521130402.GA5130@lst.de>
References: <20190521124729.23559-1-hch@lst.de>
	<20190521124729.23559-3-hch@lst.de>
	<20190521130047.3bvvttpaa3pfqkdq@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190521130047.3bvvttpaa3pfqkdq@shell.armlinux.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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

On Tue, May 21, 2019 at 02:00:47PM +0100, Russell King - ARM Linux admin wrote:
> On Tue, May 21, 2019 at 02:47:29PM +0200, Christoph Hellwig wrote:
> > Since Linux 5.1 we allow drivers to just set the largest DMA mask they
> > support instead of falling back to smaller ones.
> 
> This doesn't make sense.  "they" is confusing - why would a driver set
> a DMA mask larger than the driver supports?  Or is "they" not
> referring to the drivers (in which case, what is it referring to?)

The current plan is:

 - the driver sets whatever the device supports, and unless that mask
   is too small to be supportable it will always succeed

Which replaces the previous scheme of:

 - the driver tries to set whatever the device supports.  If there are
   addressing limitation outside the device (e.g. the PCIe root port,
   or the AXI interconnect) that will fail, and the device will set
   a 32-bit mask instead which it assumes will generally work.

> The point of this check is to trap the case where we have, for example,
> 8GB of memory, but dma_addr_t is 32-bit.  We can allocate in the high
> 4GB, but we can't represent the address in a dma_addr_t.

Yep, and that is what patch 1/2 should handle by truncating the
dma mask to something that can work.  I don't actually have hardware
I could test this scenario on, though.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
