Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64A68C433EF
	for <iommu@archiver.kernel.org>; Sun, 10 Apr 2022 10:27:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CF18A41760;
	Sun, 10 Apr 2022 10:27:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T_JyNaDbMMda; Sun, 10 Apr 2022 10:27:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3BB774175D;
	Sun, 10 Apr 2022 10:27:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1A1E8C0084;
	Sun, 10 Apr 2022 10:27:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 820A7C002C
 for <iommu@lists.linux-foundation.org>; Sun, 10 Apr 2022 10:27:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6E8DE41760
 for <iommu@lists.linux-foundation.org>; Sun, 10 Apr 2022 10:27:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HXHyW9O0M88T for <iommu@lists.linux-foundation.org>;
 Sun, 10 Apr 2022 10:27:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C5BBD4175D
 for <iommu@lists.linux-foundation.org>; Sun, 10 Apr 2022 10:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1649586430; x=1681122430;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=/cU/WapWQvkhhrNMrCPzh/gxIogDMTXN0gGrwGCnQo0=;
 b=hInUNBMoPci0rINx5ZYVxlt/rz25KUq/3bI/8QDmf3dPvVuuwmNgGXuz
 lhs6HzxHBdJb/4eHhMQLMp1/u7bycVVRqr2EKyIQKc0tujTNTCgBG7NEk
 XNy7CXjy0at1K0EU0AXclPtTBSqXm5kux+VdWd1plcJZUTnHf43GwBvSg
 8FBSzzVwxX1RTOwx8t7O0Ppw53fV6Z4ip6Qf2TTwOdB2QssjCJ+eFOau+
 CnZzMpmvYZaGdkKIthmZlboQnNJamN5wobINAd717844M++A6e2OU6tC6
 z7cyqA5OVFHiyoi+dNNmP2Gq+Pf614SPxUOyfj+4t5mmtAdl0eyd8RNYt w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10312"; a="249238443"
X-IronPort-AV: E=Sophos;i="5.90,249,1643702400"; d="scan'208";a="249238443"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Apr 2022 03:27:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,249,1643702400"; d="scan'208";a="699019573"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by fmsmga001.fm.intel.com with ESMTP; 10 Apr 2022 03:27:05 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
Subject: [PATCH RFC v3 00/12] iommu: SVA and IOPF refactoring
Date: Sun, 10 Apr 2022 18:24:31 +0800
Message-Id: <20220410102443.294128-1-baolu.lu@linux.intel.com>
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

This series overlaps with another series posted here [1]. For the
convenience of review, I included all relevant patches in this series.
We will solve the overlap problem later.

This series is also available on github here [2].

[1] https://lore.kernel.org/lkml/20220315050713.2000518-1-jacob.jun.pan@linux.intel.com/
[2] https://github.com/LuBaolu/intel-iommu/commits/iommu-sva-refactoring-v3

Please help review and suggest.

Best regards,
baolu

Change log:
v1:
 - https://lore.kernel.org/linux-iommu/20220320064030.2936936-1-baolu.lu@linux.intel.com/
 - Initial post.

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

v3:
 - Rework iommu_group_singleton_lockdown() by adding a flag to the group
   that positively indicates the group can never have more than one
   member, even after hot plug.
 - Abstract the data structs used for iommu sva in a separated patches to
   make it easier for review.
 - I still keep the RFC prefix in this series as above two significant
   changes need at least another round review to be finalized.
 - Several misc refinements.

Lu Baolu (12):
  iommu: Add pasid_bits field in struct dev_iommu
  iommu: Add a flag to indicate immutable singleton group
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
 include/linux/iommu.h                         | 107 ++++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  25 +-
 .../iommu/{iommu-sva-lib.h => iommu-sva.h}    |   8 +-
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  85 ++---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  28 +-
 drivers/iommu/intel/iommu.c                   |  20 +-
 drivers/iommu/intel/svm.c                     | 135 +++----
 drivers/iommu/io-pgfault.c                    |  71 +---
 drivers/iommu/iommu-sva-lib.c                 |  71 ----
 drivers/iommu/iommu-sva.c                     | 331 ++++++++++++++++++
 drivers/iommu/iommu.c                         | 239 +++++++------
 drivers/iommu/Makefile                        |   2 +-
 13 files changed, 706 insertions(+), 421 deletions(-)
 rename drivers/iommu/{iommu-sva-lib.h => iommu-sva.h} (88%)
 delete mode 100644 drivers/iommu/iommu-sva-lib.c
 create mode 100644 drivers/iommu/iommu-sva.c

-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
