Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB570C433EF
	for <iommu@archiver.kernel.org>; Mon,  2 May 2022 01:51:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7AC1340936;
	Mon,  2 May 2022 01:51:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uobpDAjm6z7D; Mon,  2 May 2022 01:51:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5BA094014A;
	Mon,  2 May 2022 01:51:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1D9F3C0039;
	Mon,  2 May 2022 01:51:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 84E3BC002D
 for <iommu@lists.linux-foundation.org>; Mon,  2 May 2022 01:51:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5D4E74099B
 for <iommu@lists.linux-foundation.org>; Mon,  2 May 2022 01:51:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id E1TTf6wdtEx4 for <iommu@lists.linux-foundation.org>;
 Mon,  2 May 2022 01:51:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 10F4D408D3
 for <iommu@lists.linux-foundation.org>; Mon,  2 May 2022 01:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1651456307; x=1682992307;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=nBgb/6v6Rg6UR6PoLHzzUhaMGDDupSCLP2KtncAqse0=;
 b=PqnObNamVV3x8vgvm5Y7Nz57qgqo6djdqBuMgEVYUYBvo5NVexwMKnfC
 vsGh2w30FeQvz3Hvu/UB3eLdeg6uiY03Uq2a+5rPfIOVj/t7G+2B3pM5O
 ncs39aEjEbV4plljCepO+Tkem8x0lDGSVMLpeSFaamo+1Tc7Utpb0Wk4M
 TQo2slTbMLf6QqIrvBw1e/XI2USFM2IKvf/HblsXHTumD1YUI6hB6YDAC
 XmAtdw2ndOI6AHJPd79CwOAJn0KRn4U1PVcPaX42Y/Chu1KW8LXNjqGwA
 Tc4354b3Aa9jUF6NQuD3C7woBINzQ+3ImW+m8xXIrFbr54fzhZfLCQidQ g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10334"; a="254535316"
X-IronPort-AV: E=Sophos;i="5.91,190,1647327600"; d="scan'208";a="254535316"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 May 2022 18:51:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,190,1647327600"; d="scan'208";a="707406440"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by fmsmga001.fm.intel.com with ESMTP; 01 May 2022 18:51:41 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v5 00/12] iommu: SVA and IOPF refactoring
Date: Mon,  2 May 2022 09:48:30 +0800
Message-Id: <20220502014842.991097-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Jacob jun Pan <jacob.jun.pan@intel.com>
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

Hi folks,

The former part of this series refactors the IOMMU SVA code by assigning
an SVA type of iommu_domain to a shared virtual address and replacing
sva_bind/unbind iommu ops with attach/detach_dev_pasid domain ops.

The latter part changes the existing I/O page fault handling framework
from only serving SVA to a generic one. Any driver or component could
handle the I/O page faults for its domain in its own way by installing
an I/O page fault handler.

This series has been functionally tested on an x86 machine and compile
tested for other architectures.

This series is also available on github:
[2] https://github.com/LuBaolu/intel-iommu/commits/iommu-sva-refactoring-v5

Please review and suggest.

Best regards,
baolu

Change log:
v5:
 - Address review comments from Jean-Philippe Brucker. Very appreciated!
 - Remove redundant pci aliases check in
   device_group_immutable_singleton().
 - Treat all buses exept PCI as static in immutable singleton check.
 - As the sva_bind/unbind() have already guaranteed sva domain free only
   after iopf_queue_flush_dev(), remove the unnecessary domain refcount.
 - Move domain get() out of the list iteration in iopf_handle_group().

v4:
 - https://lore.kernel.org/linux-iommu/20220421052121.3464100-1-baolu.lu@linux.intel.com/
 - Solve the overlap with another series and make this series
   self-contained.
 - No objection to the abstraction of data structure during v3 review.
   Hence remove the RFC subject prefix.
 - Refine the immutable singleton group code according to Kevin's
   comments.

v3:
 - https://lore.kernel.org/linux-iommu/20220410102443.294128-1-baolu.lu@linux.intel.com/
 - Rework iommu_group_singleton_lockdown() by adding a flag to the group
   that positively indicates the group can never have more than one
   member, even after hot plug.
 - Abstract the data structs used for iommu sva in a separated patches to
   make it easier for review.
 - I still keep the RFC prefix in this series as above two significant
   changes need at least another round review to be finalized.
 - Several misc refinements.

v2:
 - https://lore.kernel.org/linux-iommu/20220329053800.3049561-1-baolu.lu@linux.intel.com/
 - Add sva domain life cycle management to avoid race between unbind and
   page fault handling.
 - Use a single domain for each mm.
 - Return a single sva handler for the same binding.
 - Add a new helper to meet singleton group requirement.
 - Rework the SVA domain allocation for arm smmu v3 driver and move the
   pasid_bit initialization to device probe.
 - Drop the patch "iommu: Handle IO page faults directly".
 - Add mmget_not_zero(mm) in SVA page fault handler.

v1:
 - https://lore.kernel.org/linux-iommu/20220320064030.2936936-1-baolu.lu@linux.intel.com/
 - Initial post.

Dave Jiang (1):
  dmaengine: idxd: Separate user and kernel pasid enabling

Lu Baolu (11):
  iommu: Add pasid_bits field in struct dev_iommu
  iommu: Add attach/detach_dev_pasid domain ops
  iommu/sva: Basic data structures for SVA
  iommu/vt-d: Remove SVM_FLAG_SUPERVISOR_MODE support
  iommu/vt-d: Add SVA domain support
  arm-smmu-v3/sva: Add SVA domain support
  iommu/sva: Use attach/detach_pasid_dev in SVA interfaces
  iommu: Remove SVA related callbacks from iommu ops
  iommu: Prepare IOMMU domain for IOPF
  iommu: Per-domain I/O page fault handling
  iommu: Rename iommu-sva-lib.{c,h}

 include/linux/intel-iommu.h                   |   5 +-
 include/linux/iommu.h                         | 100 ++++--
 drivers/dma/idxd/idxd.h                       |   6 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  25 +-
 .../iommu/{iommu-sva-lib.h => iommu-sva.h}    |   3 +-
 drivers/dma/idxd/cdev.c                       |   4 +-
 drivers/dma/idxd/init.c                       |  30 +-
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  85 ++---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  28 +-
 drivers/iommu/intel/iommu.c                   |  20 +-
 drivers/iommu/intel/svm.c                     | 135 +++----
 drivers/iommu/io-pgfault.c                    |  66 +---
 drivers/iommu/iommu-sva-lib.c                 |  71 ----
 drivers/iommu/iommu-sva.c                     | 328 ++++++++++++++++++
 drivers/iommu/iommu.c                         | 189 +++++-----
 drivers/iommu/Makefile                        |   2 +-
 16 files changed, 672 insertions(+), 425 deletions(-)
 rename drivers/iommu/{iommu-sva-lib.h => iommu-sva.h} (91%)
 delete mode 100644 drivers/iommu/iommu-sva-lib.c
 create mode 100644 drivers/iommu/iommu-sva.c

-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
