Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93E94C4321E
	for <iommu@archiver.kernel.org>; Wed, 18 May 2022 18:17:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 37202416CD;
	Wed, 18 May 2022 18:17:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Gqwe-p-rHsgU; Wed, 18 May 2022 18:17:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9223941696;
	Wed, 18 May 2022 18:17:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 78130C0032;
	Wed, 18 May 2022 18:17:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1BF1BC002D
 for <iommu@lists.linux-foundation.org>; Wed, 18 May 2022 18:17:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id ACCA961243
 for <iommu@lists.linux-foundation.org>; Wed, 18 May 2022 18:17:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id thahJrcyB2CT for <iommu@lists.linux-foundation.org>;
 Wed, 18 May 2022 18:17:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A2804605EA
 for <iommu@lists.linux-foundation.org>; Wed, 18 May 2022 18:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1652897854; x=1684433854;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=jiWNr+sMv+2JyZnQPheEt7B1dprQHk1BBtw/ckfenU8=;
 b=OIJ6bqTLdjtsFnPjWaSLfpNhLYtCr5NDu/SRnoEYPrsxHUOZE+/hsvxX
 q0+vKU0QvgcgpYPsI48+LkKscJIJpvdoZkFj17lVpYwG4TB0s8XuZDw0B
 Wo/clT2Fo8gngNjmQGHLORNaMef2yPDgpeIfnNETUHgNUAC3QaX76BR78
 11JXDfEj29AjxI2LaeNKH+5G0qNYbTtVe+43u9PkHZXS303ESXv3ff4/b
 KVY9vTShagclHgTTiqbShqi94iSI+24OFNblMshVdIv2KQ44y7YUMeFQ0
 ZfW8XnGR+CxDzHHQKWg+qhTMv/2IVElKFDk1K6kixav04oQ6Z3S0Es0OQ A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10351"; a="259392416"
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; d="scan'208";a="259392416"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2022 11:17:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; d="scan'208";a="639405492"
Received: from otc-wp-03.jf.intel.com (HELO jacob-builder.jf.intel.com)
 ([10.54.39.79])
 by fmsmga004.fm.intel.com with ESMTP; 18 May 2022 11:17:30 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 dmaengine@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
 David Woodhouse <dwmw2@infradead.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 "Lu Baolu" <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 "Christoph Hellwig" <hch@infradead.org>, vkoul@kernel.org,
 robin.murphy@arm.com, will@kernel.org
Subject: [PATCH v4 0/6] Enable PASID for DMA API users
Date: Wed, 18 May 2022 11:21:14 -0700
Message-Id: <20220518182120.1136715-1-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Raj Ashok <ashok.raj@intel.com>
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

Some modern accelerators such as Intel's Data Streaming Accelerator (DSA)
require PASID in DMA requests to be operational. Specifically, the work
submissions with ENQCMD on shared work queues require PASIDs. The use cases
include both user DMA with shared virtual addressing (SVA) and in-kernel
DMA similar to legacy DMA w/o PASID. Here we address the latter.

DMA mapping API is the de facto standard for in-kernel DMA. However, it
operates on a per device or Requester ID(RID) basis which is not
PASID-aware. To leverage DMA API for devices relies on PASIDs, this
patchset introduces the following APIs

1. A driver facing API that enables DMA API PASID usage:
iommu_attach_dma_pasid(struct device *dev, ioasid_t &pasid);
2. VT-d driver default domain op that allows attaching device-domain-PASID

Once PASID DMA is enabled and attached to the appropriate IOMMU domain,
device drivers can continue to use DMA APIs as-is. There is no difference
in terms of mapping in dma_handle between without PASID and with PASID.
The DMA mapping performed by IOMMU will be identical for both requests, let
it be IOVA or PA in case of pass-through.

In addition, this set converts DSA driver in-kernel DMA with PASID from SVA
lib to DMA API. There have been security and functional issues with the
kernel SVA approach:
(https://lore.kernel.org/linux-iommu/20210511194726.GP1002214@nvidia.com/)
The highlights are as the following:
 - The lack of IOTLB synchronization upon kernel page table updates.
   (vmalloc, module/BPF loading, CONFIG_DEBUG_PAGEALLOC etc.)
 - Other than slight more protection, using kernel virtual address (KVA)
has little advantage over physical address. There are also no use cases yet
where DMA engines need kernel virtual addresses for in-kernel DMA.

Subsequently, cleanup is done around the usage of sva_bind_device() for
in-kernel DMA. Removing special casing code in VT-d driver and tightening
SVA lib API.

This work and idea behind it is a collaboration with many people, many
thanks to Baolu Lu, Jason Gunthorpe, Dave Jiang, and others.


ChangeLog:
v4
	- Rebased on "Baolu's SVA and IOPF refactoring" series v6.
	(https://github.com/LuBaolu/intel-iommu/commits/iommu-sva-refactoring-v6)
	- Fixed locking for protecting iommu domain PASID data
	- Use iommu_attach_device_pasid() API instead of calling domain
	  ops directly. This will leverage the common pasid_array that
	  replaces driver specific storage in device_domain_info.
	- Added a helper function to do look up in pasid_array from
	  domain

v3
	- Rebased on "Baolu's SVA and IOPF refactoring" series v5.
	(https://github.com/LuBaolu/intel-iommu/commits/iommu-sva-refactoring-v5)
	This version is significantly simplified by leveraging IOMMU domain
	ops, attach_dev_pasid() op is implemented differently on a DMA domain
	than on a SVA domain.
	We currently have no need to support multiple PASIDs per DMA domain.
	(https://lore.kernel.org/lkml/20220315142216.GV11336@nvidia.com/).
	Removed PASID-device list from V2, a PASID field is introduced to
	struct iommu_domain instead. It is intended for DMA requests with
	PASID by all devices attached to the domain.

v2
	- Do not reserve a special PASID for DMA API usage. Use IOASID
	  allocation instead.
	- Introduced a generic device-pasid-domain attachment IOMMU op.
	  Replaced the DMA API only IOMMU op.
	- Removed supervisor SVA support in VT-d
	- Removed unused sva_bind_device parameters
	- Use IOMMU specific data instead of struct device to store PASID
	  info




*** SUBJECT HERE ***

*** BLURB HERE ***

Jacob Pan (6):
  iommu: Add a per domain PASID for DMA API
  iommu: Add a helper to do PASID lookup from domain
  iommu/vt-d: Implement domain ops for attach_dev_pasid
  iommu: Add PASID support for DMA mapping API users
  dmaengine: idxd: Use DMA API for in-kernel DMA with PASID
  iommu/vt-d: Delete unused SVM flag

 drivers/dma/idxd/idxd.h     |   1 -
 drivers/dma/idxd/init.c     |  34 +++--------
 drivers/dma/idxd/sysfs.c    |   7 ---
 drivers/iommu/dma-iommu.c   | 114 ++++++++++++++++++++++++++++++++++++
 drivers/iommu/intel/iommu.c |  72 ++++++++++++++++++++++-
 drivers/iommu/intel/svm.c   |   2 +-
 drivers/iommu/iommu.c       |  22 +++++++
 include/linux/dma-iommu.h   |   3 +
 include/linux/intel-svm.h   |  13 ----
 include/linux/iommu.h       |   8 ++-
 10 files changed, 226 insertions(+), 50 deletions(-)

-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
