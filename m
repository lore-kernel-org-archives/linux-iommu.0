Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1F5AC4332F
	for <iommu@archiver.kernel.org>; Tue,  7 Dec 2021 22:35:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8B7AB41D6B;
	Tue,  7 Dec 2021 22:35:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HRCzhVfWZNV1; Tue,  7 Dec 2021 22:35:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5DA0541D74;
	Tue,  7 Dec 2021 22:35:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3EFACC006F;
	Tue,  7 Dec 2021 22:35:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1BFF9C006E
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 22:35:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C26E482C38
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 22:35:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id utwuJ_Mpdx_f for <iommu@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 22:35:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E406A82D14
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 22:35:10 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10191"; a="224958937"
X-IronPort-AV: E=Sophos;i="5.87,295,1631602800"; d="scan'208";a="224958937"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Dec 2021 14:35:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,295,1631602800"; d="scan'208";a="515845481"
Received: from otc-wp-03.jf.intel.com ([10.54.39.79])
 by fmsmga007.fm.intel.com with ESMTP; 07 Dec 2021 14:35:02 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
 "Christoph Hellwig" <hch@infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
Subject: [PATCH 0/4] Enable PASID for DMA API users
Date: Tue,  7 Dec 2021 05:47:10 -0800
Message-Id: <1638884834-83028-1-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Tony Luck <tony.luck@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 Barry Song <21cnbao@gmail.com>, "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
 Jacob Pan <jacob.jun.pan@intel.com>, "Zanussi, Tom" <tom.zanussi@intel.com>,
 Dan Williams <dan.j.williams@intel.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Modern accelerators such as Intel's Data Streaming Accelerator (DSA) can
perform DMA requests with PASID, which is a finer granularity than the
device's requester ID(RID). In fact, work submissions on DSA shared work
queues require PASID.

DMA mapping API is the de facto standard for in-kernel DMA. However, it
operates on a per device/RID basis which is not PASID-aware.

This patch introduces the following driver facing API that enables DMA API
PASID usage: ioasid_t iommu_enable_pasid_dma(struct device *dev);

A PASID field is added to struct device for the purposes of storing kernel
DMA PASID and flushing device IOTLBs. A separate use case in interrupt
message store (IMS) also hinted adding a PASID field to struct device.
https://lore.kernel.org/all/87pmx73tfw.ffs@nanos.tec.linutronix.de/
IMS virtualization and DMA API does not overlap.

Once enabled, device drivers can continue to use DMA APIs as-is. There is
no difference in terms of mapping in dma_handle between without PASID and
with PASID.  The DMA mapping performed by IOMMU will be identical for both
requests with and without PASID (legacy), let it be IOVA or PA in case of
pass-through.

In addition, this set converts the current support for in-kernel PASID DMA
from SVA lib to DMA API. There have been security and functional issues
with the kernel SVA approach:
(https://lore.kernel.org/linux-iommu/20210511194726.GP1002214@nvidia.com/)
The highlights are as the following:
 - The lack of IOTLB synchronization upon kernel page table updates.
   (vmalloc, module/BPF loading, CONFIG_DEBUG_PAGEALLOC etc.)
 - Other than slight more protection, using kernel virtual address (KVA)
 has little advantage over physical address.
There are also no use cases yet where DMA engines need kernel virtual
addresses for in-kernel DMA.

Once this set is accepted, more cleanup patches will follow. The plan is to
remove the usage of sva_bind_device() for in-kernel usages. Removing page
requests and other special cases around kernel SVA in VT-d driver.



Jacob Pan (4):
  ioasid: Reserve a global PASID for in-kernel DMA
  iommu: Add PASID support for DMA mapping API users
  iommu/vt-d: Support PASID DMA for in-kernel usage
  dmaengine: idxd: Use DMA API for in-kernel DMA with PASID

 .../admin-guide/kernel-parameters.txt         |   6 -
 drivers/dma/Kconfig                           |  10 --
 drivers/dma/idxd/idxd.h                       |   1 -
 drivers/dma/idxd/init.c                       |  59 +++-------
 drivers/dma/idxd/sysfs.c                      |   7 --
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |   2 +-
 drivers/iommu/dma-iommu.c                     |  71 ++++++++++++
 drivers/iommu/intel/iommu.c                   | 109 +++++++++++++++++-
 drivers/iommu/intel/pasid.c                   |   7 ++
 drivers/iommu/intel/pasid.h                   |   3 +-
 drivers/iommu/intel/svm.c                     |   2 +-
 drivers/iommu/ioasid.c                        |   2 +
 include/linux/device.h                        |   1 +
 include/linux/dma-iommu.h                     |   7 ++
 include/linux/intel-iommu.h                   |   3 +-
 include/linux/ioasid.h                        |   4 +
 include/linux/iommu.h                         |   4 +
 17 files changed, 226 insertions(+), 72 deletions(-)

-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
