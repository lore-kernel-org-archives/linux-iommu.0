Return-Path: <SRS0=YXze=KI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F11C433ED
	for <iommu@archiver.kernel.org>; Thu, 13 May 2021 22:32:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60D1161435
	for <iommu@archiver.kernel.org>; Thu, 13 May 2021 22:32:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60D1161435
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3599140415;
	Thu, 13 May 2021 22:32:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id l-HpkmB1qCUw; Thu, 13 May 2021 22:32:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id F094E4041D;
	Thu, 13 May 2021 22:32:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CCCFFC0028;
	Thu, 13 May 2021 22:32:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1915BC0023
 for <iommu@lists.linux-foundation.org>; Thu, 13 May 2021 22:32:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 087EE403FC
 for <iommu@lists.linux-foundation.org>; Thu, 13 May 2021 22:32:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id x7mOSTXRdPbg for <iommu@lists.linux-foundation.org>;
 Thu, 13 May 2021 22:32:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 22FD8400F7
 for <iommu@lists.linux-foundation.org>; Thu, 13 May 2021 22:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:MIME-Version:Message-Id:Date:Cc:To:From
 :references:content-disposition:in-reply-to;
 bh=iEMTzht1OWcJNBYhS5s3qHl4AFHEGpyftzhjsptY00E=; b=J+TX9vcQOO3ZAfxX7+MJPatZLC
 IgMRxndkvM+1RJiSpNNWbESxiGwgqd2bOUHtzdwP25biUz/9cG9xe6XgXmktyMlN2gTR4vAvwmqhb
 MKygHYng0wNG4iH+3zWCguQ7e5D2x+3w2w5BJKbGiNBrJhhGeluoGizm/zPVsh5RDKPhxSZ1dFQIP
 FDaWPdypRbXwmHHjBgu5NYxKitqfVZKPkjavKpx0fXff7dEqqUM0P3gO4ukeBoiIdPk/wMBGYdEYr
 Ys5Jq08iNMN+9Dp0k04WkKmYXjc+Xw4RfWoGr3ozpc3N9u3vqsR3j0+VVoRw63GhgX9Omk2A/sOGb
 rBFlmogA==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <gunthorp@deltatee.com>)
 id 1lhJsL-0000nB-QQ; Thu, 13 May 2021 16:32:15 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
 (envelope-from <gunthorp@deltatee.com>)
 id 1lhJsF-0001ST-Ld; Thu, 13 May 2021 16:32:07 -0600
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
Date: Thu, 13 May 2021 16:31:41 -0600
Message-Id: <20210513223203.5542-1-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, sbates@raithlin.com, hch@lst.de,
 jgg@ziepe.ca, christian.koenig@amd.com, jhubbard@nvidia.com,
 ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch,
 jason@jlekstrand.net, dave.hansen@linux.intel.com, helgaas@kernel.org,
 dan.j.williams@intel.com, andrzej.jakowski@intel.com, dave.b.minturn@intel.com,
 jianxin.xiong@intel.com, ira.weiny@intel.com, robin.murphy@arm.com,
 logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v2 00/22] Add new DMA mapping operation for P2PDMA
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Cc: Minturn Dave B <dave.b.minturn@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 John Hubbard <jhubbard@nvidia.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Robin Murphy <robin.murphy@arm.com>, Matthew Wilcox <willy@infradead.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Logan Gunthorpe <logang@deltatee.com>,
 Jason Ekstrand <jason@jlekstrand.net>, Daniel Vetter <daniel.vetter@ffwll.ch>,
 Bjorn Helgaas <helgaas@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
 Stephen Bates <sbates@raithlin.com>,
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

This patchset continues my work to to add P2PDMA support to the common
dma map operations. This allows for creating SGLs that have both P2PDMA
and regular pages which is a necessary step to allowing P2PDMA pages in
userspace.

The earlier RFC[1] and v1[2] postings generated a lot of great feedback.
This version adds a bunch more cleanup at the start of the series. I'll
probably look to split the earlier patches off and get them merged
indpendantly after a round of review with this series as this series
has gotten quite long.

I'm happy to do a few more passes if anyone has any further feedback
or better ideas.

This series is based on v5.13-rc1 and a git branch can be found here:

  https://github.com/sbates130272/linux-p2pmem/  p2pdma_map_ops_v2

Thanks,

Logan

[1] https://lore.kernel.org/linux-block/20210311233142.7900-1-logang@deltatee.com/
[2] https://lore.kernel.org/linux-block/20210408170123.8788-1-logang@deltatee.com/

Changes sine v1:
 * Rebased onto v5.13-rc1
 * Add some cleanup to the existing P2PDMA code to fix up some naming
   conventions and documentation as the code has evolved a bit since the
   names were chosen. (As suggested by John)
 * Add a patch that adds a warning if a host bridge is not in the whitelist
   (as suggested by Don)
 * Change to using dma_map_sgtable() instead of creating a new
   interface. For this, a couple of .map_sg implementations were changed
   to return full error codes. (as per Christoph)
 * Renamed the scatterlist functions to include the term "dma" to
   indicate that they apply to the DMA side of the sg. (per Jason)
 * Introduce ib_dma_pci_p2p_dma_supported() helper instead of open
   coding the check (per Jason)
 * Numerous minor adjustments and documentation fixes

Changes since the RFC:
 * Added comment and fixed up the pci_get_slot patch. (per Bjorn)
 * Fixed glaring sg_phys() double offset bug. (per Robin)
 * Created a new map operation (dma_map_sg_p2pdma()) with a new calling
   convention instead of modifying the calling convention of
   dma_map_sg(). (per Robin)
 * Integrated the two similar pci_p2pdma_dma_map_type() and
   pci_p2pdma_map_type() functions into one (per Ira)
 * Reworked some of the logic in the map_sg() implementations into
   helpers in the p2pdma code. (per Christoph)
 * Dropped a bunch of unnecessary symbol exports (per Christoph)
 * Expanded the code in dma_pci_p2pdma_supported() for clarity. (per
   Ira and Christoph)
 * Finished off using the new dma_map_sg_p2pdma() call in rdma_rw
   and removed the old pci_p2pdma_[un]map_sg(). (per Jason)

--

Logan Gunthorpe (22):
  PCI/P2PDMA: Rename upstream_bridge_distance() and rework documentation
  PCI/P2PDMA: Use a buffer on the stack for collecting the acs list
  PCI/P2PDMA: Cleanup type for return value of calc_map_type_and_dist()
  PCI/P2PDMA: Avoid pci_get_slot() which sleeps
  PCI/P2PDMA: Print a warning if the host bridge is not in the whitelist
  PCI/P2PDMA: Attempt to set map_type if it has not been set
  PCI/P2PDMA: Refactor pci_p2pdma_map_type() to take pagemap and device
  dma-mapping: Allow map_sg() ops to return negative error codes
  dma-direct: Return appropriate error code from dma_direct_map_sg()
  iommu: Return full error code from iommu_map_sg[_atomic]()
  dma-iommu: Return error code from iommu_dma_map_sg()
  lib/scatterlist: Add flag for indicating P2PDMA segments in an SGL
  PCI/P2PDMA: Make pci_p2pdma_map_type() non-static
  PCI/P2PDMA: Introduce helpers for dma_map_sg implementations
  dma-direct: Support PCI P2PDMA pages in dma-direct map_sg
  dma-mapping: Add flags to dma_map_ops to indicate PCI P2PDMA support
  iommu/dma: Support PCI P2PDMA pages in dma-iommu map_sg
  nvme-pci: Check DMA ops when indicating support for PCI P2PDMA
  nvme-pci: Convert to using dma_map_sgtable()
  RDMA/core: Introduce ib_dma_pci_p2p_dma_supported()
  RDMA/rw: use dma_map_sgtable()
  PCI/P2PDMA: Remove pci_p2pdma_[un]map_sg()

 drivers/infiniband/core/rw.c |  75 ++++------
 drivers/iommu/dma-iommu.c    |  86 +++++++++--
 drivers/iommu/iommu.c        |  15 +-
 drivers/nvme/host/core.c     |   3 +-
 drivers/nvme/host/nvme.h     |   2 +-
 drivers/nvme/host/pci.c      |  80 +++++-----
 drivers/nvme/target/rdma.c   |   2 +-
 drivers/pci/Kconfig          |   2 +-
 drivers/pci/p2pdma.c         | 273 +++++++++++++++++++----------------
 include/linux/dma-map-ops.h  |  18 ++-
 include/linux/dma-mapping.h  |  46 +++++-
 include/linux/iommu.h        |  22 +--
 include/linux/pci-p2pdma.h   |  81 ++++++++---
 include/linux/scatterlist.h  |  50 ++++++-
 include/rdma/ib_verbs.h      |  30 ++++
 kernel/dma/direct.c          |  44 +++++-
 kernel/dma/mapping.c         |  31 +++-
 17 files changed, 570 insertions(+), 290 deletions(-)


base-commit: 6efb943b8616ec53a5e444193dccf1af9ad627b5
--
2.20.1
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
