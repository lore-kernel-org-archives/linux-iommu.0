Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5F10C433F5
	for <iommu@archiver.kernel.org>; Mon, 14 Feb 2022 02:58:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 75F2960648;
	Mon, 14 Feb 2022 02:58:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NTAk1u3m13c5; Mon, 14 Feb 2022 02:58:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 540F2606E7;
	Mon, 14 Feb 2022 02:58:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2B59AC001A;
	Mon, 14 Feb 2022 02:58:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AC57BC000B
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 02:58:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 89D0840139
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 02:58:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id t9DrF9xu0p-B for <iommu@lists.linux-foundation.org>;
 Mon, 14 Feb 2022 02:58:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4B6304012A
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 02:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1644807515; x=1676343515;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=U5LogFle85DF75CuzggC6SMHtkreQy9inDpsfSOHuaY=;
 b=ilj94RoCa7+gofwYu9AFexxKG/cKurRmv+8sUIIlMHUQIYG7Tg6/9LPr
 FPMbgq8ZsmWilf/E/W0p6524Bl+4dFRW8ELRo7NUFlDiyhZ02/ibRHCOR
 r9Li1vTxeGc7JscnwxbU/uWkr/a1jNwubaMZebefQ6ogZ+1nQHBjZ67TD
 iBDNbNAWlcz56jTHza+oygBbUpYCa6qcVwLbZbKDQCA0Q0giawFz1Bl1W
 xLnMnp0rS8pePxTyjwtDdGRPxjP5gtko3XhygL/PW5tiPCdNUUxyRis+v
 jpMDdtXf6bCEjxtyfuTXcBzBxU2lD6OulVnd24G/f6VJJXCxFxxpMVElw Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="230637511"
X-IronPort-AV: E=Sophos;i="5.88,366,1635231600"; d="scan'208";a="230637511"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Feb 2022 18:58:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,366,1635231600"; d="scan'208";a="501514886"
Received: from allen-box.sh.intel.com ([10.239.159.118])
 by orsmga002.jf.intel.com with ESMTP; 13 Feb 2022 18:58:31 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Liu Yi L <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v2 00/11] iommu/vt-d: Some Intel IOMMU cleanups
Date: Mon, 14 Feb 2022 10:56:53 +0800
Message-Id: <20220214025704.3184654-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Jason Gunthorpe <jgg@nvidia.com>, Robin Murphy <robin.murphy@arm.com>,
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

Hi folks,

After a long time of evolution, the drivers/iommu/intel/iommu.c
becomes a bit messy. This series tries to cleanup and refactor
the driver to make it more concise.

It includes,

- Remove some unnecessary code, includes and prototypes;
- Move creating per-device driver data from domain_attach to
  device_probe callback.
- Use an array for global per-device driver data so that they
  could be searched repidly.
- Use the rculist for per-domain device driver data and remove
  the existing spinlock.
- Code style fix.

Your comments are very appreciated.

Best regards,
baolu

Change log:

v1: initial post
 - https://lore.kernel.org/linux-iommu/20220207064142.1092846-1-baolu.lu@linux.intel.com/

v2:
 - Avoid migration of large amounts of code.
 - Split the cleanup patches into separated ones for convenient code
   review.
 - This version of series is available on github:
   https://github.com/LuBaolu/intel-iommu/commits/iommu-vtd-cleanup-v2

Lu Baolu (11):
  iommu/vt-d: Remove intel_iommu::domains
  iommu/vt-d: Remove finding domain in dmar_insert_one_dev_info()
  iommu/vt-d: Remove iova_cache_get/put()
  iommu/vt-d: Remove domain and devinfo mempool
  iommu/vt-d: Remove DEFER_DEVICE_DOMAIN_INFO
  iommu/vt-d: Remove unnecessary includes
  iommu/vt-d: Remove unnecessary prototypes
  iommu/vt-d: Fix indentation of goto labels
  iommu/vt-d: Remove commented code
  iommu/vt-d: Use xarray for global device_domain_info
  iommu/vt-d: Use rculist for per-domain device list

 include/linux/intel-iommu.h   |   6 +-
 drivers/iommu/intel/debugfs.c |  14 +-
 drivers/iommu/intel/iommu.c   | 597 +++++++++-------------------------
 drivers/iommu/intel/pasid.c   |  12 +-
 drivers/iommu/intel/svm.c     |   6 +-
 5 files changed, 165 insertions(+), 470 deletions(-)

-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
