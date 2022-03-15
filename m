Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1618C433F5
	for <iommu@archiver.kernel.org>; Tue, 15 Mar 2022 05:04:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 59FD4408FE;
	Tue, 15 Mar 2022 05:04:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d76v24NZ1axX; Tue, 15 Mar 2022 05:04:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id CC730405B6;
	Tue, 15 Mar 2022 05:04:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9390FC0033;
	Tue, 15 Mar 2022 05:04:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 065F2C000B
 for <iommu@lists.linux-foundation.org>; Tue, 15 Mar 2022 05:04:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EC6A041609
 for <iommu@lists.linux-foundation.org>; Tue, 15 Mar 2022 05:03:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xqyHeAs0K1Dl for <iommu@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 05:03:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1C351401F1
 for <iommu@lists.linux-foundation.org>; Tue, 15 Mar 2022 05:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1647320639; x=1678856639;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=tpMOnF3L21oRMXjbylyNzJFTycaw/Dvgw48xE8xN/vo=;
 b=g7Aev1bzxapFOQ1AHM1I1PnVqNXrQD5oHrZuUpYAAxp9jvc01mofu+hi
 zLmh9aSd7oaAleQv4pjcz7wdRlxPoWRvdq3Lp9LQhf1Qewf4DnLrsj9yb
 w4Juzh126k3jEgnDSS5XpI7hI202RXPmo9r1U+doqhBMFGFwMIlhgjXUM
 UDSxVhQxgKMoOAODm7Nfso4a6O9xJhkQ0tLsVD1VByht15WzBu0G0B/ap
 Hbje13FHWkA8PpifXLBJxW8E52HQx/TnIEOcj1SpRv/jRLVfvtEYN76OF
 wjFr0afJAd8QYHLU7RcsdIkfNgzI5f2dbMcR/cBbKaPrlp2p3eWI0PehS A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="342640145"
X-IronPort-AV: E=Sophos;i="5.90,182,1643702400"; d="scan'208";a="342640145"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Mar 2022 22:03:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,182,1643702400"; d="scan'208";a="580383563"
Received: from otc-wp-03.jf.intel.com (HELO jacob-builder.jf.intel.com)
 ([10.54.39.79])
 by orsmga001.jf.intel.com with ESMTP; 14 Mar 2022 22:03:58 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
 "Christoph Hellwig" <hch@infradead.org>,
 "Lu Baolu" <baolu.lu@linux.intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
Subject: [PATCH v2 0/8] Enable PASID for DMA API users
Date: Mon, 14 Mar 2022 22:07:04 -0700
Message-Id: <20220315050713.2000518-1-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Tony Luck <tony.luck@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Raj Ashok <ashok.raj@intel.com>, "Zanussi,
 Tom" <tom.zanussi@intel.com>, "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
 Jacob Pan <jacob.jun.pan@intel.com>, Dan Williams <dan.j.williams@intel.com>
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
iommu_enable_pasid_dma(struct device *dev, ioasid_t &pasid);

2. An IOMMU op that allows attaching device-domain-PASID generically (will
be used beyond DMA API PASID support)

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
v2
	- Do not reserve a special PASID for DMA API usage. Use IOASID
	  allocation instead.
	- Introduced a generic device-pasid-domain attachment IOMMU op.
	  Replaced the DMA API only IOMMU op.
	- Removed supervisor SVA support in VT-d
	- Removed unused sva_bind_device parameters
	- Use IOMMU specific data instead of struct device to store PASID
	  info

Jacob Pan (6):
  iommu/vt-d: Implement device_pasid domain attach ops
  iommu/vt-d: Use device_pasid attach op for RID2PASID
  iommu: Add PASID support for DMA mapping API users
  dmaengine: idxd: Use DMA API for in-kernel DMA with PASID
  iommu/vt-d: Delete supervisor/kernel SVA
  iommu: Remove unused driver data in sva_bind_device

Lu Baolu (2):
  iommu: Assign per device max PASID
  iommu: Add attach/detach_dev_pasid domain ops

 drivers/dma/idxd/cdev.c                       |   2 +-
 drivers/dma/idxd/idxd.h                       |   1 -
 drivers/dma/idxd/init.c                       |  34 +--
 drivers/dma/idxd/sysfs.c                      |   7 -
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |   2 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |   5 +-
 drivers/iommu/dma-iommu.c                     |  65 ++++++
 drivers/iommu/intel/iommu.c                   | 214 ++++++++++++++++--
 drivers/iommu/intel/svm.c                     |  51 +----
 drivers/iommu/iommu.c                         |   4 +-
 drivers/misc/uacce/uacce.c                    |   2 +-
 include/linux/dma-iommu.h                     |   7 +
 include/linux/intel-iommu.h                   |  15 +-
 include/linux/iommu.h                         |  37 ++-
 14 files changed, 338 insertions(+), 108 deletions(-)

-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
