Return-Path: <SRS0=Xx/3=YV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B3EFCA9EC0
	for <iommu@archiver.kernel.org>; Mon, 28 Oct 2019 12:38:14 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D471208C0
	for <iommu@archiver.kernel.org>; Mon, 28 Oct 2019 12:38:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D471208C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id DCBAA10BC;
	Mon, 28 Oct 2019 12:38:13 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 953D2B1F
	for <iommu@lists.linux-foundation.org>;
	Mon, 28 Oct 2019 12:38:12 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 2F03B87B
	for <iommu@lists.linux-foundation.org>;
	Mon, 28 Oct 2019 12:38:12 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id F170068B05; Mon, 28 Oct 2019 13:38:05 +0100 (CET)
Date: Mon, 28 Oct 2019 13:38:05 +0100
From: "hch@lst.de" <hch@lst.de>
To: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: Re: [PATCH v2 1/3] dma-mapping: introduce new dma unmap and sync
	api variants
Message-ID: <20191028123805.GA25160@lst.de>
References: <20191024124130.16871-1-laurentiu.tudor@nxp.com>
	<20191024124130.16871-2-laurentiu.tudor@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191024124130.16871-2-laurentiu.tudor@nxp.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Madalin Bucur <madalin.bucur@nxp.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Leo Li <leoyang.li@nxp.com>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "hch@lst.de" <hch@lst.de>
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

On Thu, Oct 24, 2019 at 12:41:41PM +0000, Laurentiu Tudor wrote:
> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> 
> Introduce a few new dma unmap and sync variants that, on top of the
> original variants, return the virtual address corresponding to the
> input dma address.
> In order to implement this a new dma map op is added and used:
>     void *get_virt_addr(dev, dma_handle);
> It does the actual conversion of an input dma address to the output
> virtual address.

We'll definitively need an implementation for dma-direct at least as
well.  Also as said previously we need a dma_can_unmap_by_dma_addr()
or similar helper that tells the driver beforehand if this works, so
that the driver can either use a sub-optimal workaround or fail the
probe if this functionality isn't implemented.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
