Return-Path: <SRS0=5yIV=F3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 805DCC433E6
	for <iommu@archiver.kernel.org>; Wed, 23 Dec 2020 06:27:43 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 050DF20759
	for <iommu@archiver.kernel.org>; Wed, 23 Dec 2020 06:27:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 050DF20759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 85D2B87204;
	Wed, 23 Dec 2020 06:27:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FM-kDt0+k5ye; Wed, 23 Dec 2020 06:27:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4B1F6871F0;
	Wed, 23 Dec 2020 06:27:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2E3C5C1825;
	Wed, 23 Dec 2020 06:27:41 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 62BAAC0893
 for <iommu@lists.linux-foundation.org>; Wed, 23 Dec 2020 06:27:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 5DE8D85D97
 for <iommu@lists.linux-foundation.org>; Wed, 23 Dec 2020 06:27:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jGng2LAo2kJD for <iommu@lists.linux-foundation.org>;
 Wed, 23 Dec 2020 06:27:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 65F7C85D90
 for <iommu@lists.linux-foundation.org>; Wed, 23 Dec 2020 06:27:38 +0000 (UTC)
IronPort-SDR: QT4A/a8juo4VtiE3ht80QV17E3fO2CZYwnBwGLmG7K/a1n4P01P1ZJXZ+2hgF1fKHQXS2GjY7t
 8mlOrVdsa98g==
X-IronPort-AV: E=McAfee;i="6000,8403,9843"; a="155182356"
X-IronPort-AV: E=Sophos;i="5.78,441,1599548400"; d="scan'208";a="155182356"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Dec 2020 22:27:37 -0800
IronPort-SDR: ipOPRoLKMqQ1PrvKHXtDvFixq5dER7SZRJf4GEUYfTEfruPizqCNMqRfhy+5ET0xw7LykzMO/R
 bkIVBkTZ4BVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,441,1599548400"; d="scan'208";a="338703477"
Received: from yiliu-dev.bj.intel.com (HELO iov-dev.bj.intel.com)
 ([10.238.156.135])
 by fmsmga007.fm.intel.com with ESMTP; 22 Dec 2020 22:27:34 -0800
From: Liu Yi L <yi.l.liu@intel.com>
To: baolu.lu@linux.intel.com, joro@8bytes.org, will@kernel.org,
 jacob.jun.pan@linux.intel.com
Subject: [PATCH v2 0/3] iommu/vt-d: Misc fixes on scalable mode
Date: Wed, 23 Dec 2020 14:27:17 +0800
Message-Id: <20201223062720.29364-1-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: kevin.tian@intel.com, ashok.raj@intel.com, jun.j.tian@intel.com,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 yi.y.sun@intel.com
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

This patchset aims to fix a bug regards to native SVM usage, and
also several bugs around subdevice (attached to device via auxiliary
manner) tracking and ineffective device_tlb flush.

Liu Yi L (3):
  iommu/vt-d: Move intel_iommu info from struct intel_svm to struct
    intel_svm_dev
  iommu/vt-d: Track device aux-attach with subdevice_domain_info
  iommu/vt-d: Fix ineffective devTLB invalidation for subdevices

 drivers/iommu/intel/iommu.c | 158 +++++++++++++++++++++++++++---------
 drivers/iommu/intel/svm.c   |   9 +-
 include/linux/intel-iommu.h |  18 ++--
 3 files changed, 135 insertions(+), 50 deletions(-)

-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
