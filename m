Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50469C43334
	for <iommu@archiver.kernel.org>; Tue, 21 Jun 2022 14:48:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7DE0D418E7;
	Tue, 21 Jun 2022 14:48:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7DE0D418E7
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PPJ3trso
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hVlWc0-7QL4Y; Tue, 21 Jun 2022 14:48:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id EAC6B418F0;
	Tue, 21 Jun 2022 14:48:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EAC6B418F0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8FDDFC0085;
	Tue, 21 Jun 2022 14:48:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4C289C002D
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jun 2022 14:48:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1364583F1C
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jun 2022 14:48:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1364583F1C
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=PPJ3trso
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nZyr2qT4iBUJ for <iommu@lists.linux-foundation.org>;
 Tue, 21 Jun 2022 14:48:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EE2BB83ED1
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EE2BB83ED1
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jun 2022 14:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1655822885; x=1687358885;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=fu8/GjqKi9Ni4wzzQ55YeDYb5M22/TNQdg9Rxma6pTE=;
 b=PPJ3trsotGwMbHkE3uU8rSS/cCuA5PAzi0x7Cx9LLRDOLUxSxZhGuDlk
 73IK6qibJIwx7450pA4G+I+4+D3JyDo3WzRDW9HRj4r1wsG0O71ziiWWL
 X6uE32L92XWBXgl6My3T0/VjXbVFYvg5uZQ6IMS8Ps08u/12S7ugO9xpN
 R1NG5cCp8wzGHdtpB1l9xHdsLtFNJ3nfxFVAkUnB8MOJwO9PllLHQ+TAo
 jBDA0FxF/8TLxKFfs0XmttjZGIUh9scFvYaaSiR2WeJywrVN4iO/KYu9y
 MQ9nIU6kM/GFa9EGtnmnwujyFzRn6t+IYHpBTSIgcqVtPBqX2C5XTSgPg A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10384"; a="280867038"
X-IronPort-AV: E=Sophos;i="5.92,209,1650956400"; d="scan'208";a="280867038"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jun 2022 07:48:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,209,1650956400"; d="scan'208";a="643659174"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by fmsmga008.fm.intel.com with ESMTP; 21 Jun 2022 07:48:00 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v9 00/11] iommu: SVA and IOPF refactoring
Date: Tue, 21 Jun 2022 22:43:42 +0800
Message-Id: <20220621144353.17547-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Jacob jun Pan <jacob.jun.pan@intel.com>
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
sva_bind/unbind iommu ops with set/block_dev_pasid domain ops.

The latter part changes the existing I/O page fault handling framework
from only serving SVA to a generic one. Any driver or component could
handle the I/O page faults for its domain in its own way by installing
an I/O page fault handler.

This series has been functionally tested on an x86 machine and compile
tested for all architectures.

This series is also available on github:
[2] https://github.com/LuBaolu/intel-iommu/commits/iommu-sva-refactoring-v9

Please review and suggest.

Best regards,
baolu

Change log:
v9:
 - Some minor changes on comments and function names.
 - Simplify dev_iommu_get_max_pasids().

v8:
 - https://lore.kernel.org/linux-iommu/20220607014942.3954894-1-baolu.lu@linux.intel.com/
 - Add support for calculating the max pasids that a device could
   consume.
 - Replace container_of_safe() with container_of.
 - Remove iommu_ops->sva_domain_ops and make sva support through the
   generic domain_alloc/free() interfaces.
 - [Robin] It would be logical to pass IOMMU_DOMAIN_SVA to the normal
   domain_alloc call, so that driver-internal stuff like context
   descriptors can be still be hung off the domain as usual (rather than
   all drivers having to implement some extra internal lookup mechanism 
   to handle all the SVA domain ops).
 - [Robin] I'd just stick the mm pointer in struct iommu_domain, in a
   union with the fault handler stuff those are mutually exclusive with
   SVA.
 - https://lore.kernel.org/linux-iommu/f3170016-4d7f-e78e-db48-68305f683349@arm.com/

v7:
 - https://lore.kernel.org/linux-iommu/20220519072047.2996983-1-baolu.lu@linux.intel.com/
 - Remove duplicate array for sva domain.
 - Rename detach_dev_pasid to block_dev_pasid.
 - Add raw device driver interfaces for iommufd.
 - Other misc refinements and patch reorganization.
 - Drop "dmaengine: idxd: Separate user and kernel pasid enabling" which
   has been picked for dmaengine tree.

v6:
 - https://lore.kernel.org/linux-iommu/20220510061738.2761430-1-baolu.lu@linux.intel.com/
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
 - Treat all buses except PCI as static in immutable singleton check.
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

*** BLURB HERE ***

Lu Baolu (11):
  iommu: Add max_pasids field in struct iommu_device
  iommu: Add max_pasids field in struct dev_iommu
  iommu: Remove SVM_FLAG_SUPERVISOR_MODE support
  iommu: Add sva iommu_domain support
  iommu/vt-d: Add SVA domain support
  arm-smmu-v3/sva: Add SVA domain support
  iommu/sva: Refactoring iommu_sva_bind/unbind_device()
  iommu: Remove SVA related callbacks from iommu ops
  iommu: Prepare IOMMU domain for IOPF
  iommu: Per-domain I/O page fault handling
  iommu: Rename iommu-sva-lib.{c,h}

 include/linux/intel-iommu.h                   |  12 +-
 include/linux/intel-svm.h                     |  13 -
 include/linux/iommu.h                         | 128 +++++++---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  19 +-
 .../iommu/{iommu-sva-lib.h => iommu-sva.h}    |  14 +-
 drivers/dma/idxd/cdev.c                       |   3 +-
 drivers/dma/idxd/init.c                       |  25 +-
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 112 +++++----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |   9 +-
 drivers/iommu/intel/dmar.c                    |   7 +
 drivers/iommu/intel/iommu.c                   |   7 +-
 drivers/iommu/intel/svm.c                     | 149 +++++------
 drivers/iommu/io-pgfault.c                    |  73 ++----
 drivers/iommu/iommu-sva-lib.c                 |  71 ------
 drivers/iommu/iommu-sva.c                     | 229 +++++++++++++++++
 drivers/iommu/iommu.c                         | 237 +++++++++++-------
 drivers/misc/uacce/uacce.c                    |   2 +-
 drivers/iommu/Makefile                        |   2 +-
 18 files changed, 649 insertions(+), 463 deletions(-)
 rename drivers/iommu/{iommu-sva-lib.h => iommu-sva.h} (83%)
 delete mode 100644 drivers/iommu/iommu-sva-lib.c
 create mode 100644 drivers/iommu/iommu-sva.c

-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
