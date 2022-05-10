Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 997E7C43217
	for <iommu@archiver.kernel.org>; Tue, 10 May 2022 21:03:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1C1B941718;
	Tue, 10 May 2022 21:03:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id n-RgVHa3H9sJ; Tue, 10 May 2022 21:03:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B6E3E4035E;
	Tue, 10 May 2022 21:03:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6FB33C0032;
	Tue, 10 May 2022 21:03:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5651AC002D
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 21:03:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 204768305C
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 21:03:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YqA3Bguf0kBm for <iommu@lists.linux-foundation.org>;
 Tue, 10 May 2022 21:03:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DA29583046
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 21:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1652216600; x=1683752600;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=T2RqD8DycZnIZwNsICjtUhI+ydkb5hVA3rlyqO1BIDA=;
 b=oHc/Uib9ePahYFgU02q8P1ye7wE0US8Six/kPXNZ3FoMM7MOtzkJqYyx
 N2vJHvaydkMgCDzWrNvx9hDHl7uv/DTsw8gU7wqnU5ilpS2y2sTpPF2Nh
 VuLPfHwN8ySnmNHmvu930S/A7O+9TnsZmh8Z86NCn3do86ebvODuqTOiW
 b1S6Iv56pWQkGVmxgYSdf3e0qCpU7JYKziMiWcx7GPADaSLhewRKSK6EN
 LgcTBFfeshdl4j3SgArS+Ok2qHrOXBXYsZQbsw7LtV7pa/qn+yqxjtnXc
 r9aF/o7bfEP1erCw2e3UbxVNI9A6NZfrxjwf3mm/I5COpvCGueg0IINHU A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="251551567"
X-IronPort-AV: E=Sophos;i="5.91,215,1647327600"; d="scan'208";a="251551567"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 May 2022 14:03:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,215,1647327600"; d="scan'208";a="553017093"
Received: from otc-wp-03.jf.intel.com (HELO jacob-builder.jf.intel.com)
 ([10.54.39.79])
 by orsmga002.jf.intel.com with ESMTP; 10 May 2022 14:03:19 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 dmaengine@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
 David Woodhouse <dwmw2@infradead.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 "Lu Baolu" <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 vkoul@kernel.org, robin.murphy@arm.com, will@kernel.org
Subject: [PATCH v3 0/4] Enable PASID for DMA API users
Date: Tue, 10 May 2022 14:07:00 -0700
Message-Id: <20220510210704.3539577-1-jacob.jun.pan@linux.intel.com>
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


Jacob Pan (4):
  iommu/vt-d: Implement domain ops for attach_dev_pasid
  iommu: Add PASID support for DMA mapping API users
  dmaengine: idxd: Use DMA API for in-kernel DMA with PASID
  iommu/vt-d: Delete unused SVM flag

 drivers/dma/idxd/idxd.h     |   1 -
 drivers/dma/idxd/init.c     |  34 +++---------
 drivers/dma/idxd/sysfs.c    |   7 ---
 drivers/iommu/dma-iommu.c   | 107 ++++++++++++++++++++++++++++++++++++
 drivers/iommu/intel/iommu.c |  81 ++++++++++++++++++++++++++-
 drivers/iommu/intel/svm.c   |   2 +-
 include/linux/dma-iommu.h   |   3 +
 include/linux/intel-iommu.h |   1 +
 include/linux/intel-svm.h   |  13 -----
 include/linux/iommu.h       |   2 +
 10 files changed, 202 insertions(+), 49 deletions(-)

-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
