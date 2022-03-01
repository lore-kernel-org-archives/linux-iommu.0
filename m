Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 864ACC433F5
	for <iommu@archiver.kernel.org>; Tue,  1 Mar 2022 02:03:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3DE8E40332;
	Tue,  1 Mar 2022 02:03:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lPXlVJdUzLEl; Tue,  1 Mar 2022 02:03:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9047C402E1;
	Tue,  1 Mar 2022 02:03:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 61627C0077;
	Tue,  1 Mar 2022 02:03:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E8678C001A
 for <iommu@lists.linux-foundation.org>; Tue,  1 Mar 2022 02:03:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E420780C30
 for <iommu@lists.linux-foundation.org>; Tue,  1 Mar 2022 02:03:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hKjFlmjzybMc for <iommu@lists.linux-foundation.org>;
 Tue,  1 Mar 2022 02:03:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A311A80C15
 for <iommu@lists.linux-foundation.org>; Tue,  1 Mar 2022 02:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1646100220; x=1677636220;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=9e4hvtEBJN+4ICflCaa5ETNZXDhPyySyMpwbpIJ6NVU=;
 b=lZLIvq1+P4fz1OEwyc6fTz9wshirF/JFKhzstD4SnlR7MbRKG1PaAjRR
 gLY9aXTtE8B0skuTpOI5wGaWZyrwXtT6WyWPKZj8fsvTvh2C5TAR2LW/F
 u+/S7YcH1GDsKnTKf+YYnRimTtil/kx0sU75wChR3fKfXSRRekhnPgjzR
 lB/weuxcCbO17rxjJNQmFYYobbUmpg7ZSQ27U7R1PL2gvpKSiyPJvjeQI
 Vqptbdyb8vEyPdGbr3NLzUFzgsOVcQZvt5mBrYLVcAJP40obbvquUy0RP
 XEXe+0y6Tbqk7KGX9Zc+OHUsYsDg6HIVrP97V8RMc5SZeRMZD8acpPaDf Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="339468410"
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; d="scan'208";a="339468410"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Feb 2022 18:03:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; d="scan'208";a="685551087"
Received: from allen-box.sh.intel.com ([10.239.159.118])
 by fmsmga001.fm.intel.com with ESMTP; 28 Feb 2022 18:03:38 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 00/12] [PULL REQUEST] Intel IOMMU updates for Linux v5.18
Date: Tue,  1 Mar 2022 10:01:47 +0800
Message-Id: <20220301020159.633356-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: YueHaibing <yuehaibing@huawei.com>, Marco Bonelli <marco@mebeim.net>,
 iommu@lists.linux-foundation.org, Jason Gunthorpe <jgg@nvidia.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Christoph Hellwig <hch@lst.de>
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

Hi Joerg,

This includes patches queued for v5.18. It includes:

 - [PATCH 1 ~ 11] Various cleanups, no intentional functional changes.
 - [PATCH 12] Enable ATS in SoC-integrated devices listed in ACPI/SATC
              table.

Please consider them for v5.18.

Best regards,
Baolu

Andy Shevchenko (1):
  iommu/vt-d: Move intel_iommu_ops to header file

Lu Baolu (8):
  iommu/vt-d: Remove intel_iommu::domains
  iommu/vt-d: Remove finding domain in dmar_insert_one_dev_info()
  iommu/vt-d: Remove iova_cache_get/put()
  iommu/vt-d: Remove domain and devinfo mempool
  iommu/vt-d: Remove DEFER_DEVICE_DOMAIN_INFO
  iommu/vt-d: Remove unnecessary includes
  iommu/vt-d: Remove unnecessary prototypes
  iommu/vt-d: Fix indentation of goto labels

Marco Bonelli (1):
  iommu/vt-d: Add missing "__init" for rmrr_sanity_check()

Yian Chen (1):
  iommu/vt-d: Enable ATS for the devices in SATC table

YueHaibing (1):
  iommu/vt-d: Remove unused function intel_svm_capable()

 include/linux/intel-iommu.h   |   6 +-
 drivers/iommu/intel/debugfs.c |   3 +-
 drivers/iommu/intel/dmar.c    |   2 -
 drivers/iommu/intel/iommu.c   | 461 +++++++++-------------------------
 drivers/iommu/intel/pasid.c   |  12 +-
 drivers/iommu/intel/svm.c     |  11 +-
 6 files changed, 133 insertions(+), 362 deletions(-)

-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
