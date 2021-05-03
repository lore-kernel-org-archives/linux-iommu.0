Return-Path: <SRS0=N1FY=J6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 380B4C433B4
	for <iommu@archiver.kernel.org>; Mon,  3 May 2021 18:35:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF73D610A2
	for <iommu@archiver.kernel.org>; Mon,  3 May 2021 18:35:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF73D610A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6D4A860B4B;
	Mon,  3 May 2021 18:35:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yhF6ci7k6UB5; Mon,  3 May 2021 18:35:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id B3CAB606ED;
	Mon,  3 May 2021 18:35:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 99FD0C000D;
	Mon,  3 May 2021 18:35:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 257D2C0001
 for <iommu@lists.linux-foundation.org>; Mon,  3 May 2021 18:35:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0B1A9402A8
 for <iommu@lists.linux-foundation.org>; Mon,  3 May 2021 18:35:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0iSRhsoV0iP9 for <iommu@lists.linux-foundation.org>;
 Mon,  3 May 2021 18:35:14 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E7382400B8
 for <iommu@lists.linux-foundation.org>; Mon,  3 May 2021 18:35:13 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id A773768B05; Mon,  3 May 2021 20:35:09 +0200 (CEST)
Date: Mon, 3 May 2021 20:35:09 +0200
From: Christoph Hellwig <hch@lst.de>
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH 03/16] PCI/P2PDMA: Attempt to set map_type if it has
 not been set
Message-ID: <20210503183509.GA17971@lst.de>
References: <20210408170123.8788-1-logang@deltatee.com>
 <20210408170123.8788-4-logang@deltatee.com>
 <3834be62-3d1b-fc98-d793-e7dcb0a74624@nvidia.com>
 <a1b6ffa9-7a9c-753f-6350-5ea26506cdc3@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a1b6ffa9-7a9c-753f-6350-5ea26506cdc3@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>,
 Dave Hansen <dave.hansen@linux.intel.com>, linux-nvme@lists.infradead.org,
 Stephen Bates <sbates@raithlin.com>, linux-mm@kvack.org,
 Jason Ekstrand <jason@jlekstrand.net>, Ira Weiny <ira.weiny@intel.com>,
 Christoph Hellwig <hch@lst.de>, Minturn Dave B <dave.b.minturn@intel.com>,
 Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
 John Hubbard <jhubbard@nvidia.com>, linux-block@vger.kernel.org,
 Dan Williams <dan.j.williams@intel.com>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
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

On Mon, May 03, 2021 at 10:17:59AM -0600, Logan Gunthorpe wrote:
> I agree that some of this has evolved in a way that some of the names
> are a bit odd now. Could definitely use a cleanup, but that's not really
> part of this series. When I have some time I can look at doing a cleanup
> series to help with some of this.

I think adding it to the series would be very helpful.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
