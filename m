Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36EB2C433F5
	for <iommu@archiver.kernel.org>; Tue, 29 Mar 2022 05:40:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C681D404F1;
	Tue, 29 Mar 2022 05:40:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0X-QHQUuzY5C; Tue, 29 Mar 2022 05:40:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A7C9840377;
	Tue, 29 Mar 2022 05:40:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5C191C001D;
	Tue, 29 Mar 2022 05:40:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3E649C0012
 for <iommu@lists.linux-foundation.org>; Tue, 29 Mar 2022 05:40:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 250BB40377
 for <iommu@lists.linux-foundation.org>; Tue, 29 Mar 2022 05:40:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LZEQVlq3fhHs for <iommu@lists.linux-foundation.org>;
 Tue, 29 Mar 2022 05:40:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4F626404BA
 for <iommu@lists.linux-foundation.org>; Tue, 29 Mar 2022 05:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1648532414; x=1680068414;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=tknkKS8klJn8jY0SolaOVo53TFN54BvuIWRpHY8TEAU=;
 b=XPF/j88gz1rjFiDq3L+oDALH4Eegis/QNTXhMVwifORTLcvdi/0+GFSY
 lG7ElxADcJqdMxEAiBfKfDMszb7L/GRcZJgw4QbgRf2DGvat1jy2Zgsys
 8pRhgX/u+MVVCsCfKtXv41prj+XXEvPWm8xPlRaUtUMoXHcyCOjT1cy64
 oIhG7uiQqxUBovShuSYT91qN97vsgbHMfdNitB7UnAmbsjRA3albfM4JQ
 pqQn83+JxZ0C+IqPehoIQVQnQkF2IIfr2HMA4fTeE0m6jApwMjC1uvJGc
 2uid5TDDFplJuvZp560SshvHgQ68OuYSCCWQEAqXpos4tjDeG4f20cYyw A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10300"; a="239099099"
X-IronPort-AV: E=Sophos;i="5.90,219,1643702400"; d="scan'208";a="239099099"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Mar 2022 22:40:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,219,1643702400"; d="scan'208";a="694603557"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by fmsmga001.fm.intel.com with ESMTP; 28 Mar 2022 22:40:10 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
Subject: [PATCH RFC v2 00/11] iommu: SVA and IOPF refactoring
Date: Tue, 29 Mar 2022 13:37:49 +0800
Message-Id: <20220329053800.3049561-1-baolu.lu@linux.intel.com>
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

Hi,

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
[2] https://github.com/LuBaolu/intel-iommu/commits/iommu-sva-refactoring-v2

Please help review and suggest.

Best regards,
baolu

Change log:
v1:
 - https://lore.kernel.org/linux-iommu/20220320064030.2936936-1-baolu.lu@linux.intel.com/
 - Initial post.

v2:
 - Add sva domain life cycle management to avoid race between unbind and
   page fault handling.
 - Use a single domain for each mm.
 - Return a single sva handler for the same binding.
 - Add a new helper to meet singleton group requirement.
 - Rework the SVA domain allocation for arm smmu v3 driver and move the
   pasid_bit initialization to device probe.
 - Drop the patch "iommu: Handle IO page faults directly".
 - Add mmget_not_zero(mm) in SVA page fault handler.

Lu Baolu (11):
  iommu: Add pasid_bits field in struct dev_iommu
  iommu: Add iommu_group_singleton_lockdown()
  iommu/sva: Add iommu_domain type for SVA
  iommu: Add attach/detach_dev_pasid domain ops
  iommu/vt-d: Remove SVM_FLAG_SUPERVISOR_MODE suport
  iommu/vt-d: Add SVA domain support
  arm-smmu-v3/sva: Add SVA domain support
  iommu/sva: Use attach/detach_pasid_dev in SVA interfaces
  iommu: Remove SVA related callbacks from iommu ops
  iommu: Per-domain I/O page fault handling
  iommu: Rename iommu-sva-lib.{c,h}

 include/linux/intel-iommu.h                   |   5 +-
 include/linux/iommu.h                         | 107 ++++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  25 +-
 .../iommu/{iommu-sva-lib.h => iommu-sva.h}    |  12 +-
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  85 ++---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  28 +-
 drivers/iommu/intel/iommu.c                   |  20 +-
 drivers/iommu/intel/svm.c                     | 135 +++-----
 drivers/iommu/io-pgfault.c                    |  72 +---
 drivers/iommu/iommu-sva-lib.c                 |  71 ----
 drivers/iommu/iommu-sva.c                     | 307 ++++++++++++++++++
 drivers/iommu/iommu.c                         | 208 ++++++------
 drivers/iommu/Makefile                        |   2 +-
 13 files changed, 655 insertions(+), 422 deletions(-)
 rename drivers/iommu/{iommu-sva-lib.h => iommu-sva.h} (80%)
 delete mode 100644 drivers/iommu/iommu-sva-lib.c
 create mode 100644 drivers/iommu/iommu-sva.c

-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
