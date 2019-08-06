Return-Path: <SRS0=bP0W=WC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C43A0C31E40
	for <iommu@archiver.kernel.org>; Tue,  6 Aug 2019 05:23:31 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D9022070D
	for <iommu@archiver.kernel.org>; Tue,  6 Aug 2019 05:23:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D9022070D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 5DC88D80;
	Tue,  6 Aug 2019 05:23:31 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 2EF99D7F
	for <iommu@lists.linux-foundation.org>;
	Tue,  6 Aug 2019 05:23:30 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 5CBA34C3
	for <iommu@lists.linux-foundation.org>;
	Tue,  6 Aug 2019 05:23:29 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id A815768B05; Tue,  6 Aug 2019 07:23:25 +0200 (CEST)
Date: Tue, 6 Aug 2019 07:23:25 +0200
From: Christoph Hellwig <hch@lst.de>
To: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH] dma-direct: don't truncate dma_required_mask to bus
	addressing capabilities
Message-ID: <20190806052325.GB13409@lst.de>
References: <20190805155153.11021-1-l.stach@pengutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190805155153.11021-1-l.stach@pengutronix.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: linux-kernel@vger.kernel.org, patchwork-lst@pengutronix.de,
	Atish Patra <atish.patra@wdc.com>,
	iommu@lists.linux-foundation.org, kernel@pengutronix.de,
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

On Mon, Aug 05, 2019 at 05:51:53PM +0200, Lucas Stach wrote:
> The dma required_mask needs to reflect the actual addressing capabilities
> needed to handle the whole system RAM. When truncated down to the bus
> addressing capabilities dma_addressing_limited() will incorrectly signal
> no limitations for devices which are restricted by the bus_dma_mask.
> 
> Fixes: b4ebe6063204 (dma-direct: implement complete bus_dma_mask handling)
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

Yeah, this looks sensible.  Atish, can you check if this helps on the
HiFive board as well?
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
