Return-Path: <SRS0=ZOt4=IV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A32D2C433C1
	for <iommu@archiver.kernel.org>; Tue, 23 Mar 2021 01:15:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51F0361974
	for <iommu@archiver.kernel.org>; Tue, 23 Mar 2021 01:15:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51F0361974
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 31F9A83D9E;
	Tue, 23 Mar 2021 01:15:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4CUDOUWIVhW0; Tue, 23 Mar 2021 01:15:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3652883D95;
	Tue, 23 Mar 2021 01:15:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 22E6DC000B;
	Tue, 23 Mar 2021 01:15:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 00666C0001
 for <iommu@lists.linux-foundation.org>; Tue, 23 Mar 2021 01:15:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E3FA16080B
 for <iommu@lists.linux-foundation.org>; Tue, 23 Mar 2021 01:15:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id j_5JDqdLl8-w for <iommu@lists.linux-foundation.org>;
 Tue, 23 Mar 2021 01:15:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 52A526080A
 for <iommu@lists.linux-foundation.org>; Tue, 23 Mar 2021 01:15:48 +0000 (UTC)
IronPort-SDR: oybqftuuBsUyMx/HgwsCvtYzd6VrVcgaUoBC8aOQXSHOC0t/bSVcs/LTUFUaAztglubLCuzPYg
 eFikesbHDjew==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="275480168"
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; d="scan'208";a="275480168"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Mar 2021 18:15:48 -0700
IronPort-SDR: 4+4KfI+Pz943ysW2ZNCFvJKqkFD2FDX6ZdAAjrewftqd6cyCg+j/mTnkP0mIqE0OhtIKJuFwHa
 sz+sX/wuF2dA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; d="scan'208";a="435362487"
Received: from allen-box.sh.intel.com ([10.239.159.128])
 by fmsmga004.fm.intel.com with ESMTP; 22 Mar 2021 18:15:45 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Subject: [PATCH 5/5] iommu/vt-d: Make unnecessarily global functions static
Date: Tue, 23 Mar 2021 09:06:00 +0800
Message-Id: <20210323010600.678627-6-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210323010600.678627-1-baolu.lu@linux.intel.com>
References: <20210323010600.678627-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: kevin.tian@intel.com, ashok.raj@intel.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, jacob.jun.pan@intel.com
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

Make some functions static as they are only used inside pasid.c.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/pasid.c | 4 ++--
 drivers/iommu/intel/pasid.h | 2 --
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index f2c747e62c6a..c896aef7db40 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -230,7 +230,7 @@ struct pasid_table *intel_pasid_get_table(struct device *dev)
 	return info->pasid_table;
 }
 
-int intel_pasid_get_dev_max_id(struct device *dev)
+static int intel_pasid_get_dev_max_id(struct device *dev)
 {
 	struct device_domain_info *info;
 
@@ -241,7 +241,7 @@ int intel_pasid_get_dev_max_id(struct device *dev)
 	return info->pasid_table->max_pasid;
 }
 
-struct pasid_entry *intel_pasid_get_entry(struct device *dev, u32 pasid)
+static struct pasid_entry *intel_pasid_get_entry(struct device *dev, u32 pasid)
 {
 	struct device_domain_info *info;
 	struct pasid_table *pasid_table;
diff --git a/drivers/iommu/intel/pasid.h b/drivers/iommu/intel/pasid.h
index 90a3268d7a77..079534fcf55d 100644
--- a/drivers/iommu/intel/pasid.h
+++ b/drivers/iommu/intel/pasid.h
@@ -102,8 +102,6 @@ extern unsigned int intel_pasid_max_id;
 int intel_pasid_alloc_table(struct device *dev);
 void intel_pasid_free_table(struct device *dev);
 struct pasid_table *intel_pasid_get_table(struct device *dev);
-int intel_pasid_get_dev_max_id(struct device *dev);
-struct pasid_entry *intel_pasid_get_entry(struct device *dev, u32 pasid);
 int intel_pasid_setup_first_level(struct intel_iommu *iommu,
 				  struct device *dev, pgd_t *pgd,
 				  u32 pasid, u16 did, int flags);
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
