Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDE14C433F5
	for <iommu@archiver.kernel.org>; Tue, 21 Dec 2021 09:00:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5BCAF4051B;
	Tue, 21 Dec 2021 09:00:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ovs6U3oeAKz1; Tue, 21 Dec 2021 09:00:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id EF02540129;
	Tue, 21 Dec 2021 09:00:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C3FE2C001E;
	Tue, 21 Dec 2021 09:00:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 81B78C0012
 for <iommu@lists.linux-foundation.org>; Tue, 21 Dec 2021 09:00:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5EE924016B
 for <iommu@lists.linux-foundation.org>; Tue, 21 Dec 2021 09:00:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3zj_Tl8CkUC0 for <iommu@lists.linux-foundation.org>;
 Tue, 21 Dec 2021 09:00:14 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E3D0640129
 for <iommu@lists.linux-foundation.org>; Tue, 21 Dec 2021 09:00:13 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 7A18568AFE; Tue, 21 Dec 2021 10:00:04 +0100 (CET)
Date: Tue, 21 Dec 2021 10:00:03 +0100
From: Christoph Hellwig <hch@lst.de>
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH v4 01/23] lib/scatterlist: cleanup macros into static
 inline functions
Message-ID: <20211221090003.GA7949@lst.de>
References: <20211117215410.3695-1-logang@deltatee.com>
 <20211117215410.3695-2-logang@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211117215410.3695-2-logang@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: linux-pci@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
 linux-nvme@lists.infradead.org, Stephen Bates <sbates@raithlin.com>,
 linux-mm@kvack.org, Jason Ekstrand <jason@jlekstrand.net>,
 Ira Weiny <ira.weiny@intel.com>, Christoph Hellwig <hch@lst.de>,
 Minturn Dave B <dave.b.minturn@intel.com>,
 Martin Oliveira <martin.oliveira@eideticom.com>,
 Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Daniel Vetter <daniel.vetter@ffwll.ch>, John Hubbard <jhubbard@nvidia.com>,
 linux-block@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
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

On Wed, Nov 17, 2021 at 02:53:48PM -0700, Logan Gunthorpe wrote:
> Convert the sg_is_chain(), sg_is_last() and sg_chain_ptr() macros
> into static inline functions. There's no reason for these to be macros
> and static inline are generally preferred these days.
> 
> Also introduce the SG_PAGE_LINK_MASK define so the P2PDMA work, which is
> adding another bit to this mask, can do so more easily.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>

Looks fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>

scatterlist.h doesn't have a real maintainer, do you want me to pick
this up through the DMA tree?
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
