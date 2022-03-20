Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8ABEC433EF
	for <iommu@archiver.kernel.org>; Sun, 20 Mar 2022 06:42:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6511381A50;
	Sun, 20 Mar 2022 06:42:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RmlsqSEQdtFJ; Sun, 20 Mar 2022 06:42:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 51DC281A18;
	Sun, 20 Mar 2022 06:42:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 335E9C001A;
	Sun, 20 Mar 2022 06:42:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 06802C000B
 for <iommu@lists.linux-foundation.org>; Sun, 20 Mar 2022 06:42:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E169440901
 for <iommu@lists.linux-foundation.org>; Sun, 20 Mar 2022 06:42:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id k1YPZ9tjkam3 for <iommu@lists.linux-foundation.org>;
 Sun, 20 Mar 2022 06:42:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B201D40900
 for <iommu@lists.linux-foundation.org>; Sun, 20 Mar 2022 06:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1647758558; x=1679294558;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=gbEDJc7UjnYqXMs/lN72CbHb0WPgXfSbE7JnkNcwm3E=;
 b=b8jFe7F/fa9zsRQMHevFjyQHzkRWASeQ/8F7FXDLZgxS3mWDZ0ncmGjk
 AHlmdG5Y5fPBEgkbNumPH6ASed/piIr3atalT1trbqbMGPZEkg82072Ug
 OFx1hzWCMNLPJ0D1U9/sXayY7v8aCoSIsSXMrYuloFg07aoguns+oB96Z
 O07T8kHyTRoCdcXsCiVgJwvefiagKP4ug/EpGYHyU89XKBgE/8+W+QIwE
 zCzzgAejtHeg/ASquxmhpxz7Xq+IEKErPzorJAFtB/iHy9U+AZGgyjCFk
 ZS0hjlOQMS/kNy1qesOkFB1ko1MyQb9/1i3bNFl0IlZNAPOkT21qvNMg/ Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10291"; a="237961375"
X-IronPort-AV: E=Sophos;i="5.90,195,1643702400"; d="scan'208";a="237961375"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Mar 2022 23:42:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,195,1643702400"; d="scan'208";a="691839857"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by fmsmga001.fm.intel.com with ESMTP; 19 Mar 2022 23:42:34 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
Subject: [PATCH RFC 00/11] iommu: SVA and IOPF refactoring
Date: Sun, 20 Mar 2022 14:40:19 +0800
Message-Id: <20220320064030.2936936-1-baolu.lu@linux.intel.com>
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
[2] https://github.com/LuBaolu/intel-iommu/commits/iommu-sva-refactoring-v1

Please help review and suggest.

Best regards,
baolu

Lu Baolu (11):
  iommu: Add pasid_bits field in struct dev_iommu
  iommu: Add iommu_domain type for SVA
  iommu: Add attach/detach_dev_pasid domain ops
  iommu/vt-d: Add SVA domain support
  arm-smmu-v3/sva: Add SVA domain support
  iommu/sva: Use attach/detach_pasid_dev in SVA interfaces
  iommu: Remove SVA related callbacks from iommu ops
  iommu: Handle IO page faults directly
  iommu: Add iommu_get_domain_for_dev_pasid()
  iommu: Make IOPF handling framework generic
  iommu: Rename iommu-sva-lib.{c,h}

 include/linux/intel-iommu.h                   |   5 +-
 include/linux/iommu.h                         |  95 +++++---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  25 +-
 .../iommu/{iommu-sva-lib.h => iommu-sva.h}    |   0
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  96 ++++----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  19 +-
 drivers/iommu/intel/iommu.c                   |  36 +--
 drivers/iommu/intel/svm.c                     |  85 +++----
 drivers/iommu/io-pgfault.c                    |  69 +-----
 drivers/iommu/iommu-sva-lib.c                 |  71 ------
 drivers/iommu/iommu-sva.c                     | 230 ++++++++++++++++++
 drivers/iommu/iommu.c                         | 175 ++++++-------
 drivers/iommu/Makefile                        |   2 +-
 13 files changed, 515 insertions(+), 393 deletions(-)
 rename drivers/iommu/{iommu-sva-lib.h => iommu-sva.h} (100%)
 delete mode 100644 drivers/iommu/iommu-sva-lib.c
 create mode 100644 drivers/iommu/iommu-sva.c

-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
