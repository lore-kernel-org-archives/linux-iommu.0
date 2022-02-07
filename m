Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B085C433EF
	for <iommu@archiver.kernel.org>; Mon,  7 Feb 2022 06:43:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 859C060B3A;
	Mon,  7 Feb 2022 06:43:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oAd8vkq2M9x4; Mon,  7 Feb 2022 06:43:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 85A2660625;
	Mon,  7 Feb 2022 06:43:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 58792C0011;
	Mon,  7 Feb 2022 06:43:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 79A78C000B
 for <iommu@lists.linux-foundation.org>; Mon,  7 Feb 2022 06:43:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 609C0400E5
 for <iommu@lists.linux-foundation.org>; Mon,  7 Feb 2022 06:43:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5jwig-EVxC42 for <iommu@lists.linux-foundation.org>;
 Mon,  7 Feb 2022 06:43:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9DAB3400D8
 for <iommu@lists.linux-foundation.org>; Mon,  7 Feb 2022 06:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1644216180; x=1675752180;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Yco+/+LynFN8oIASNk8w1jMvxVl0gBS6tYwskQzaS3g=;
 b=oK4n89Guz0r2Jn6m0tHmk6PyKRUuGsE1gXlvgt736nU+AZLMOT6nc68e
 J8o9o4POoHUClgGjbGnxsTudMFJQ1cz8xEfBvvoqJK7wgDYr6cMsLPTzm
 fECUtu1T2dJG48y9y4XKuZ4SGpjaJTJymOjxPBbHS1GCtl+mcvetZeet3
 yol4YEpgX5s4AmGWbzyZaDqfVcYFcr29OG2OJY1ZwQdI2vUbEqztAJ2C3
 /eMrldPau/z54tASHif5ZpAz1BUGAug1Bagn4r/bJfFUOtN8YwQjs0SUo
 NcQO6UCtNsnwV79/w7o0IybhgxYh5aSbZpGLVZHux+cTxASUe0W19hYjT w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10250"; a="228622918"
X-IronPort-AV: E=Sophos;i="5.88,349,1635231600"; d="scan'208";a="228622918"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Feb 2022 22:42:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,349,1635231600"; d="scan'208";a="525020172"
Received: from allen-box.sh.intel.com ([10.239.159.118])
 by orsmga007.jf.intel.com with ESMTP; 06 Feb 2022 22:42:56 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Liu Yi L <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v1 00/10] iommu/vt-d: Some Intel IOMMU cleanups
Date: Mon,  7 Feb 2022 14:41:32 +0800
Message-Id: <20220207064142.1092846-1-baolu.lu@linux.intel.com>
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

After a long time of evolution, the drivers/iommu/intel/iommu.c becomes
fat and a bit messy. This series tries to cleanup and refactor the
driver to make it more concise. Your comments are very appreciated.

Best regards,
baolu

Lu Baolu (10):
  iommu/vt-d: Move DMAR specific helpers into dmar.c
  iommu/vt-d: Remove intel_iommu::domains
  iommu/vt-d: Remove finding domain in dmar_insert_one_dev_info()
  iommu/vt-d: Remove iova_cache_get/put()
  iommu/vt-d: Remove domain and devinfo mempool
  iommu/vt-d: Remove DEFER_DEVICE_DOMAIN_INFO
  iommu/vt-d: Use an xarray for global device_domain_info
  iommu/vt-d: Use rculist for dmar_domain::devices
  iommu/vt-d: Refactor dmar_insert_one_dev_info()
  iommu/vt-d: Some cleanups in iommu.c

 include/linux/dmar.h          |   43 +-
 include/linux/intel-iommu.h   |  220 ++++++-
 drivers/iommu/intel/debugfs.c |    3 -
 drivers/iommu/intel/dmar.c    |  216 ++++++-
 drivers/iommu/intel/iommu.c   | 1109 ++++++---------------------------
 5 files changed, 650 insertions(+), 941 deletions(-)

-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
