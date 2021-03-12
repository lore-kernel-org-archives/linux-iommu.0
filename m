Return-Path: <SRS0=dgoC=IK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14663C433DB
	for <iommu@archiver.kernel.org>; Fri, 12 Mar 2021 15:51:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A199D64F72
	for <iommu@archiver.kernel.org>; Fri, 12 Mar 2021 15:51:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A199D64F72
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 605596FAE8;
	Fri, 12 Mar 2021 15:51:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id V0PM5_B5N6LA; Fri, 12 Mar 2021 15:51:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 241B46FA1E;
	Fri, 12 Mar 2021 15:51:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EDC95C000B;
	Fri, 12 Mar 2021 15:51:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3503CC0001
 for <iommu@lists.linux-foundation.org>; Fri, 12 Mar 2021 15:51:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0DDD44324E
 for <iommu@lists.linux-foundation.org>; Fri, 12 Mar 2021 15:51:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id O6iT76lS23s0 for <iommu@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 15:51:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id A96F14327F
 for <iommu@lists.linux-foundation.org>; Fri, 12 Mar 2021 15:51:48 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 79DA01FB;
 Fri, 12 Mar 2021 07:51:47 -0800 (PST)
Received: from [10.57.52.136] (unknown [10.57.52.136])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 38D593F7D7;
 Fri, 12 Mar 2021 07:51:43 -0800 (PST)
Subject: Re: [RFC PATCH v2 00/11] Add support to dma_map_sg for P2PDMA
To: Logan Gunthorpe <logang@deltatee.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
References: <20210311233142.7900-1-logang@deltatee.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <6b9be188-1ec7-527c-ae47-3f5b4e153758@arm.com>
Date: Fri, 12 Mar 2021 15:51:37 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210311233142.7900-1-logang@deltatee.com>
Content-Language: en-GB
Cc: Minturn Dave B <dave.b.minturn@intel.com>,
 John Hubbard <jhubbard@nvidia.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Ira Weiny <iweiny@intel.com>, Christoph Hellwig <hch@lst.de>,
 Matthew Wilcox <willy@infradead.org>, Stephen Bates <sbates@raithlin.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Jason Ekstrand <jason@jlekstrand.net>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Dan Williams <dan.j.williams@intel.com>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2021-03-11 23:31, Logan Gunthorpe wrote:
> Hi,
> 
> This is a rework of the first half of my RFC for doing P2PDMA in userspace
> with O_DIRECT[1].
> 
> The largest issue with that series was the gross way of flagging P2PDMA
> SGL segments. This RFC proposes a different approach, (suggested by
> Dan Williams[2]) which uses the third bit in the page_link field of the
> SGL.
> 
> This approach is a lot less hacky but comes at the cost of adding a
> CONFIG_64BIT dependency to CONFIG_PCI_P2PDMA and using up the last
> scarce bit in the page_link. For our purposes, a 64BIT restriction is
> acceptable but it's not clear if this is ok for all usecases hoping
> to make use of P2PDMA.
> 
> Matthew Wilcox has already suggested (off-list) that this is the wrong
> approach, preferring a new dma mapping operation and an SGL replacement. I
> don't disagree that something along those lines would be a better long
> term solution, but it involves overcoming a lot of challenges to get
> there. Creating a new mapping operation still means adding support to more
> than 25 dma_map_ops implementations (many of which are on obscure
> architectures) or creating a redundant path to fallback with dma_map_sg()
> for every driver that uses the new operation. This RFC is an approach
> that doesn't require overcoming these blocks.

I don't really follow that argument - you're only adding support to two 
implementations with the awkward flag, so why would using a dedicated 
operation instead be any different? Whatever callers need to do if 
dma_pci_p2pdma_supported() says no, they could equally do if 
dma_map_p2p_sg() (or whatever) returns -ENXIO, no?

We don't try to multiplex .map_resource through .map_page, so there 
doesn't seem to be any good reason to force that complexity on .map_sg 
either. And having a distinct API from the outset should make it a lot 
easier to transition to better "list of P2P memory regions" data 
structures in future without rewriting the whole world. As it is, there 
are potential benefits in a P2P interface which can define its own 
behaviour - for instance if threw out the notion of segment merging it 
could save a load of bother by just maintaining the direct correlation 
between pages and DMA addresses.

Robin.

> Any alternative ideas or feedback is welcome.
> 
> These patches are based on v5.12-rc2 and a git branch is available here:
> 
>    https://github.com/sbates130272/linux-p2pmem/  p2pdma_dma_map_ops_rfc
> 
> A branch with the patches from the previous RFC that add userspace
> O_DIRECT support is available at the same URL with the name
> "p2pdma_dma_map_ops_rfc+user" (however, none of the issues with those
> extra patches from the feedback of the last posting have been fixed).
> 
> Thanks,
> 
> Logan
> 
> [1] https://lore.kernel.org/linux-block/20201106170036.18713-1-logang@deltatee.com/
> [2] https://lore.kernel.org/linux-block/CAPcyv4ifGcrdOtUt8qr7pmFhmecGHqGVre9G0RorGczCGVECQQ@mail.gmail.com/
> 
> --
> 
> Logan Gunthorpe (11):
>    PCI/P2PDMA: Pass gfp_mask flags to upstream_bridge_distance_warn()
>    PCI/P2PDMA: Avoid pci_get_slot() which sleeps
>    PCI/P2PDMA: Attempt to set map_type if it has not been set
>    PCI/P2PDMA: Introduce pci_p2pdma_should_map_bus() and
>      pci_p2pdma_bus_offset()
>    lib/scatterlist: Add flag for indicating P2PDMA segments in an SGL
>    dma-direct: Support PCI P2PDMA pages in dma-direct map_sg
>    dma-mapping: Add flags to dma_map_ops to indicate PCI P2PDMA support
>    iommu/dma: Support PCI P2PDMA pages in dma-iommu map_sg
>    block: Add BLK_STS_P2PDMA
>    nvme-pci: Check DMA ops when indicating support for PCI P2PDMA
>    nvme-pci: Convert to using dma_map_sg for p2pdma pages
> 
>   block/blk-core.c            |  2 +
>   drivers/iommu/dma-iommu.c   | 63 +++++++++++++++++++++-----
>   drivers/nvme/host/core.c    |  3 +-
>   drivers/nvme/host/nvme.h    |  2 +-
>   drivers/nvme/host/pci.c     | 38 +++++++---------
>   drivers/pci/Kconfig         |  2 +-
>   drivers/pci/p2pdma.c        | 89 +++++++++++++++++++++++++++++++------
>   include/linux/blk_types.h   |  7 +++
>   include/linux/dma-map-ops.h |  3 ++
>   include/linux/dma-mapping.h |  5 +++
>   include/linux/pci-p2pdma.h  | 11 +++++
>   include/linux/scatterlist.h | 49 ++++++++++++++++++--
>   kernel/dma/direct.c         | 35 +++++++++++++--
>   kernel/dma/mapping.c        | 21 +++++++--
>   14 files changed, 271 insertions(+), 59 deletions(-)
> 
> 
> base-commit: a38fd8748464831584a19438cbb3082b5a2dab15
> --
> 2.20.1
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
