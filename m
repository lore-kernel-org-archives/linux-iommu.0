Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72FFCC433F5
	for <iommu@archiver.kernel.org>; Tue, 10 May 2022 02:37:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id EA945402EB;
	Tue, 10 May 2022 02:37:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8dSACC9Si1Jo; Tue, 10 May 2022 02:37:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D578A40201;
	Tue, 10 May 2022 02:37:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5B050C0083;
	Tue, 10 May 2022 02:37:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2C341C0039
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 02:37:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0CD4E60ABB
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 02:37:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oNSNb4iHmV2G for <iommu@lists.linux-foundation.org>;
 Tue, 10 May 2022 02:37:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6549460A9E
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 02:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1652150233; x=1683686233;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=ng4pHAlrbWQ21oogsFuW/E3rAhjpaKpe0ooXnzDxlBk=;
 b=NmhL+rXVmNcw2hPE3PzoIpllMCEPn94IeWCTWP4smKqU/IdOIYd95G5s
 T/ZoaMU9AeDCvFTzAKcY8uhMm4a11g6jqvpGlmy7alJoaYLuUUxVnvj1T
 vI2vfChEL+9Hy0ZfWcT5D36zBgSthF8z87Hvh8zp5MQDotUlxzU6ajJbt
 2+xPB+4lYfW8lI5zh6npewZUs1UZyGaAdPLZh/rBNNAGTUCecaT4HKsrf
 CrYcvWjtEPT9tgYM01zo90Vmxli7ybpOcFJSOscv1pGy5baSnf5lt2zaW
 8ZOV0XHa21tEcqTqkbHWZTGfgjFLwRX73bRKgSlq1tiMYxJOIw9DOVvGS g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="266825956"
X-IronPort-AV: E=Sophos;i="5.91,213,1647327600"; d="scan'208";a="266825956"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 May 2022 19:37:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,213,1647327600"; d="scan'208";a="519523419"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by orsmga003.jf.intel.com with ESMTP; 09 May 2022 19:37:08 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 0/8] [PULL REQUEST] Intel IOMMU updates for Linux v5.19
Date: Tue, 10 May 2022 10:33:59 +0800
Message-Id: <20220510023407.2759143-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: Kevin Tian <kevin.tian@intel.com>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 iommu@lists.linux-foundation.org, Jason Gunthorpe <jgg@nvidia.com>,
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

This includes patches queued for v5.19. It includes:

 - Domain force snooping improvement.
 - Cleanups, no intentional functional changes.

Please consider them for v5.19.

[This series cannot be directly applied to vt-d branch. Some domain
 force snooping patches have been merged on the core branch. You may
 also need to add those patches to the vt-d branch, or just merge
 this series into the core branch.]

Best regards,
Baolu

Lu Baolu (7):
  iommu/vt-d: Change return type of dmar_insert_one_dev_info()
  iommu/vt-d: Fold dmar_insert_one_dev_info() into its caller
  iommu/vt-d: Size Page Request Queue to avoid overflow condition
  iommu/vt-d: Block force-snoop domain attaching if no SC support
  iommu/vt-d: Check domain force_snooping against attached devices
  iommu/vt-d: Remove domain_update_iommu_snooping()
  iommu/vt-d: Remove hard coding PGSNP bit in PASID entries

Muhammad Usama Anjum (1):
  iommu/vt-d: Remove unneeded validity check on dev

 include/linux/intel-iommu.h |   1 +
 include/linux/intel-svm.h   |   2 +-
 drivers/iommu/intel/pasid.h |   2 +
 drivers/iommu/intel/iommu.c | 201 ++++++++++++++++++------------------
 drivers/iommu/intel/pasid.c |  45 +++++++-
 5 files changed, 149 insertions(+), 102 deletions(-)

-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
