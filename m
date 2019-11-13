Return-Path: <SRS0=M1C0=ZF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53DD3C33C8C
	for <iommu@archiver.kernel.org>; Wed, 13 Nov 2019 16:21:47 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB6E323787
	for <iommu@archiver.kernel.org>; Wed, 13 Nov 2019 16:03:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB6E323787
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 81982E25;
	Wed, 13 Nov 2019 16:03:49 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 86773D99
	for <iommu@lists.linux-foundation.org>;
	Wed, 13 Nov 2019 16:03:47 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 02935102
	for <iommu@lists.linux-foundation.org>;
	Wed, 13 Nov 2019 16:03:46 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 830D068AFE; Wed, 13 Nov 2019 17:03:44 +0100 (CET)
Date: Wed, 13 Nov 2019 17:03:44 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: remove DMA_ATTR_WRITE_BARRIER
Message-ID: <20191113160344.GA12853@lst.de>
References: <20191113073214.9514-1-hch@lst.de>
	<20191113154712.GF21728@mellanox.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191113154712.GF21728@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	Doug Ledford <dledford@redhat.com>, Christoph Hellwig <hch@lst.de>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
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

On Wed, Nov 13, 2019 at 03:47:18PM +0000, Jason Gunthorpe wrote:
> On Wed, Nov 13, 2019 at 08:32:12AM +0100, Christoph Hellwig wrote:
> > There is no implementation of the DMA_ATTR_WRITE_BARRIER flag left
> > now that the ia64 sn2 code has been removed.  Drop the flag and
> > the calling convention to set it in the RDMA code.
> 
> This looks OK, do you want it to go through the RDMA tree?

Either the dma-mapping or rdma tree is fine with me.  I guess
there are more potential conflicts with rdma changes, so tht might
be the better choice.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
