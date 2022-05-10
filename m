Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E1FFC433EF
	for <iommu@archiver.kernel.org>; Tue, 10 May 2022 06:21:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B5C9B415D9;
	Tue, 10 May 2022 06:21:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id k-RQSu1vszPe; Tue, 10 May 2022 06:21:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 28593415D5;
	Tue, 10 May 2022 06:21:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F3A18C0039;
	Tue, 10 May 2022 06:21:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4C9ACC002D
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 06:21:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2C2B48194C
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 06:21:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AbUAjkOQ7ErG for <iommu@lists.linux-foundation.org>;
 Tue, 10 May 2022 06:21:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CDC928191E
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 06:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1652163669; x=1683699669;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=UMoOuGqNBTp5BKUte75oUqeM8P736Bjhoh4LYu+1ej4=;
 b=jw3toPu8G7SmrrR5uHWvnrqByimd+UztJMZ+/P8N0hWczviwbOXktIoq
 4rgXe5jvd1Ya1GE+b/7T7UDgqOmi/Be4tUc10cdCxiJgn+JTNKbDnzYhF
 ytIo1U/npU/lkMrAHnrxYw7F9PS0M/s4oejjjCS95+AxhoZ8RK+8g6WWP
 y63kNq2jxDKJM54QSnri8pv10sqG9iuskah9lQhkiS0vzDJiBwnAatBKq
 6tnfZxZEQUh5BJNpUpwxoOVegoSK4VxrUUUMWauFo4JdSGelCKFKTm5Qe
 kRm/WWh86vcashSsYrg+Gu1qerBPVn4AlbMTk8toBVfVaaM0utZIhOOQT Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="266863616"
X-IronPort-AV: E=Sophos;i="5.91,213,1647327600"; d="scan'208";a="266863616"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 May 2022 23:20:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,213,1647327600"; d="scan'208";a="552636294"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by orsmga002.jf.intel.com with ESMTP; 09 May 2022 23:20:43 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v6 00/12] iommu: SVA and IOPF refactoring
Date: Tue, 10 May 2022 14:17:26 +0800
Message-Id: <20220510061738.2761430-1-baolu.lu@linux.intel.com>
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
[2] https://github.com/LuBaolu/intel-iommu/commits/iommu-sva-refactoring-v6

Please review and suggest.

Best regards,
baolu

Change log:
v6:
 - Refine the SVA basic data structures.
   Link: https://lore.kernel.org/linux-iommu/YnFv0ps0Ad8v+7uH@myrica/
 - Refine arm smmuv3 sva domain allocation.
 - Fix a possible lock issue.
   Link: https://lore.kernel.org/linux-iommu/YnFydE8j8l7Q4m+b@myrica/

v5:
 - https://lore.kernel.org/linux-iommu/20220502014842.991097-1-baolu.lu@linux.intel.com/
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

 include/linux/intel-iommu.h                   |   9 +-
 include/linux/iommu.h                         |  99 +++++--
 drivers/dma/idxd/idxd.h                       |   6 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  19 +-
 .../iommu/{iommu-sva-lib.h => iommu-sva.h}    |   3 -
 drivers/dma/idxd/cdev.c                       |   4 +-
 drivers/dma/idxd/init.c                       |  30 +-
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 111 +++++---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  10 +-
 drivers/iommu/intel/iommu.c                   |  12 +-
 drivers/iommu/intel/svm.c                     | 146 ++++------
 drivers/iommu/io-pgfault.c                    |  73 +----
 drivers/iommu/iommu-sva-lib.c                 |  71 -----
 drivers/iommu/iommu-sva.c                     | 261 ++++++++++++++++++
 drivers/iommu/iommu.c                         | 193 +++++++------
 drivers/iommu/Makefile                        |   2 +-
 16 files changed, 623 insertions(+), 426 deletions(-)
 rename drivers/iommu/{iommu-sva-lib.h => iommu-sva.h} (91%)
 delete mode 100644 drivers/iommu/iommu-sva-lib.c
 create mode 100644 drivers/iommu/iommu-sva.c

-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
