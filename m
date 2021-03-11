Return-Path: <SRS0=X4VR=IJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0287C433E0
	for <iommu@archiver.kernel.org>; Thu, 11 Mar 2021 23:48:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87EA764F7C
	for <iommu@archiver.kernel.org>; Thu, 11 Mar 2021 23:48:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87EA764F7C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 68513843CD;
	Thu, 11 Mar 2021 23:48:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1ptgEcKDyJX9; Thu, 11 Mar 2021 23:48:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4854A843CC;
	Thu, 11 Mar 2021 23:48:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3525CC000B;
	Thu, 11 Mar 2021 23:48:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0FBF9C0001
 for <iommu@lists.linux-foundation.org>; Thu, 11 Mar 2021 23:48:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3D99143220
 for <iommu@lists.linux-foundation.org>; Thu, 11 Mar 2021 23:48:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=deltatee.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AyZ0XxYbdLKE for <iommu@lists.linux-foundation.org>;
 Thu, 11 Mar 2021 23:48:50 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5853943208
 for <iommu@lists.linux-foundation.org>; Thu, 11 Mar 2021 23:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:MIME-Version:Message-Id:Date:Cc:To:From
 :references:content-disposition:in-reply-to;
 bh=kE7unqHb96tgCLiqAy7oTQD9QBaPCBADwUUVoF85ezA=; b=NgonvtaxHynX26gURA+2WbVFF7
 EdmjT2rJo+H+u9pFbAy9IsACHfULVpJDenz/wZp/uIJ7n11VpJ4PmS3Bye0OakNE8a74IZjm9kiZr
 HmCO0vtzmtENVocWjr8J6ARILinTKOBgkFxrQ2/zoJCo5nIyXNy4Bnqyn7uw0M3TDFbsPJBGNThgo
 y9SPPR7K0JweAHZs5X2Ib7iIZBz6T/pQNeEPzLNj+SbWX0fVWQ2YUJ0etkvfvadDo6kE5IIEVbp8y
 R1+iSUFNpi7MQb8lTFwrflPLEtzmvEAkRYK/jnMRPh29G2joRkm0gvJhU1WPsT4owdgClS4/omxu5
 9EE77grw==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <gunthorp@deltatee.com>)
 id 1lKUmZ-0003eq-Rw; Thu, 11 Mar 2021 16:32:15 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
 (envelope-from <gunthorp@deltatee.com>)
 id 1lKUmV-00024K-OI; Thu, 11 Mar 2021 16:31:51 -0700
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
Date: Thu, 11 Mar 2021 16:31:30 -0700
Message-Id: <20210311233142.7900-1-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, sbates@raithlin.com, hch@lst.de,
 jgg@ziepe.ca, christian.koenig@amd.com, jhubbard@nvidia.com,
 ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch,
 jason@jlekstrand.net, dave.hansen@linux.intel.com, dan.j.williams@intel.com,
 iweiny@intel.com, andrzej.jakowski@intel.com, dave.b.minturn@intel.com,
 jianxin.xiong@intel.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [RFC PATCH v2 00/11] Add support to dma_map_sg for P2PDMA
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Cc: Minturn Dave B <dave.b.minturn@intel.com>,
 John Hubbard <jhubbard@nvidia.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Ira Weiny <iweiny@intel.com>, Matthew Wilcox <willy@infradead.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Logan Gunthorpe <logang@deltatee.com>,
 Jason Ekstrand <jason@jlekstrand.net>, Daniel Vetter <daniel.vetter@ffwll.ch>,
 Dan Williams <dan.j.williams@intel.com>, Stephen Bates <sbates@raithlin.com>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>, Christoph Hellwig <hch@lst.de>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi,

This is a rework of the first half of my RFC for doing P2PDMA in userspace
with O_DIRECT[1].

The largest issue with that series was the gross way of flagging P2PDMA
SGL segments. This RFC proposes a different approach, (suggested by
Dan Williams[2]) which uses the third bit in the page_link field of the
SGL.

This approach is a lot less hacky but comes at the cost of adding a
CONFIG_64BIT dependency to CONFIG_PCI_P2PDMA and using up the last
scarce bit in the page_link. For our purposes, a 64BIT restriction is
acceptable but it's not clear if this is ok for all usecases hoping
to make use of P2PDMA.

Matthew Wilcox has already suggested (off-list) that this is the wrong
approach, preferring a new dma mapping operation and an SGL replacement. I
don't disagree that something along those lines would be a better long
term solution, but it involves overcoming a lot of challenges to get
there. Creating a new mapping operation still means adding support to more
than 25 dma_map_ops implementations (many of which are on obscure
architectures) or creating a redundant path to fallback with dma_map_sg()
for every driver that uses the new operation. This RFC is an approach
that doesn't require overcoming these blocks.

Any alternative ideas or feedback is welcome.

These patches are based on v5.12-rc2 and a git branch is available here:

  https://github.com/sbates130272/linux-p2pmem/  p2pdma_dma_map_ops_rfc

A branch with the patches from the previous RFC that add userspace
O_DIRECT support is available at the same URL with the name
"p2pdma_dma_map_ops_rfc+user" (however, none of the issues with those
extra patches from the feedback of the last posting have been fixed).

Thanks,

Logan

[1] https://lore.kernel.org/linux-block/20201106170036.18713-1-logang@deltatee.com/
[2] https://lore.kernel.org/linux-block/CAPcyv4ifGcrdOtUt8qr7pmFhmecGHqGVre9G0RorGczCGVECQQ@mail.gmail.com/

--

Logan Gunthorpe (11):
  PCI/P2PDMA: Pass gfp_mask flags to upstream_bridge_distance_warn()
  PCI/P2PDMA: Avoid pci_get_slot() which sleeps
  PCI/P2PDMA: Attempt to set map_type if it has not been set
  PCI/P2PDMA: Introduce pci_p2pdma_should_map_bus() and
    pci_p2pdma_bus_offset()
  lib/scatterlist: Add flag for indicating P2PDMA segments in an SGL
  dma-direct: Support PCI P2PDMA pages in dma-direct map_sg
  dma-mapping: Add flags to dma_map_ops to indicate PCI P2PDMA support
  iommu/dma: Support PCI P2PDMA pages in dma-iommu map_sg
  block: Add BLK_STS_P2PDMA
  nvme-pci: Check DMA ops when indicating support for PCI P2PDMA
  nvme-pci: Convert to using dma_map_sg for p2pdma pages

 block/blk-core.c            |  2 +
 drivers/iommu/dma-iommu.c   | 63 +++++++++++++++++++++-----
 drivers/nvme/host/core.c    |  3 +-
 drivers/nvme/host/nvme.h    |  2 +-
 drivers/nvme/host/pci.c     | 38 +++++++---------
 drivers/pci/Kconfig         |  2 +-
 drivers/pci/p2pdma.c        | 89 +++++++++++++++++++++++++++++++------
 include/linux/blk_types.h   |  7 +++
 include/linux/dma-map-ops.h |  3 ++
 include/linux/dma-mapping.h |  5 +++
 include/linux/pci-p2pdma.h  | 11 +++++
 include/linux/scatterlist.h | 49 ++++++++++++++++++--
 kernel/dma/direct.c         | 35 +++++++++++++--
 kernel/dma/mapping.c        | 21 +++++++--
 14 files changed, 271 insertions(+), 59 deletions(-)


base-commit: a38fd8748464831584a19438cbb3082b5a2dab15
--
2.20.1
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
