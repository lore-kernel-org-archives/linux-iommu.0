Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFCA1CCA47C
	for <iommu@archiver.kernel.org>; Wed, 29 Jun 2022 07:52:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6784340CDB;
	Wed, 29 Jun 2022 07:52:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6784340CDB
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kEAb9zYx
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0GQ8nEZ7p5xP; Wed, 29 Jun 2022 07:52:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3791D405CD;
	Wed, 29 Jun 2022 07:52:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3791D405CD
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1CF94C0039;
	Wed, 29 Jun 2022 07:52:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B2D81C007E
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jun 2022 07:52:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 82D4241607
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jun 2022 07:52:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 82D4241607
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=kEAb9zYx
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rm-nGXc2fu10 for <iommu@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 07:52:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 85074409A2
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 85074409A2
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jun 2022 07:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1656489133; x=1688025133;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=WngZy2RXcl507LUfl56SWWZdud4Z0sU0Rtwz35+5lWQ=;
 b=kEAb9zYx9l+keaTUOVGoO3LXnMHlpVU6bhdol0nRSc1SuJpUhmKg4nMQ
 TxpPbBbKnDRT9aSM8woMeFY2G6CpE5AzGP9Dl8dydmt39HMefCJAJ9SvH
 QamYD+qOJHta7fV6bU5HeLe3UIy0vWujk3/Orc4AYHs6uhfrkeEYDaQmN
 fveCwjIIFiOlQ6Glcp7E3YxcIXOfsz2WUCJ4Db7GBLMBzn6VWUJyeAsrg
 Q3eEEm3CpmAbkV25sATSGT8qESfEXmcQZI9ta/pYf1+aNfGr2GRgTwK7+
 U6+/8Bh+nADJET62/oMVDrK2Z3TJ7se0I04kM9qSKpBCE8OO1s/oChmA/ Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="262362989"
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; d="scan'208";a="262362989"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jun 2022 00:52:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; d="scan'208";a="588209721"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by orsmga007.jf.intel.com with ESMTP; 29 Jun 2022 00:52:11 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: iommu@lists.linux-foundation.org,
	iommu@lists.linux.dev
Subject: [PATCH v3 09/11] iommu/vt-d: Fold __dmar_remove_one_dev_info() into
 its caller
Date: Wed, 29 Jun 2022 15:47:23 +0800
Message-Id: <20220629074725.2331441-10-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220629074725.2331441-1-baolu.lu@linux.intel.com>
References: <20220629074725.2331441-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 linux-kernel@vger.kernel.org, Jacob jun Pan <jacob.jun.pan@intel.com>
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

Fold __dmar_remove_one_dev_info() into dmar_remove_one_dev_info() which
is its only caller. Make the spin lock critical range only cover the
device list change code and remove some unnecessary checks.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 33 ++++++++-------------------------
 1 file changed, 8 insertions(+), 25 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 94f41981b75b..3038aafecff9 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -295,7 +295,6 @@ static LIST_HEAD(dmar_satc_units);
 static int g_num_of_iommus;
 
 static void dmar_remove_one_dev_info(struct device *dev);
-static void __dmar_remove_one_dev_info(struct device_domain_info *info);
 
 int dmar_disabled = !IS_ENABLED(CONFIG_INTEL_IOMMU_DEFAULT_ON);
 int intel_iommu_sm = IS_ENABLED(CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON);
@@ -4141,20 +4140,13 @@ static void domain_context_clear(struct device_domain_info *info)
 			       &domain_context_clear_one_cb, info);
 }
 
-static void __dmar_remove_one_dev_info(struct device_domain_info *info)
+static void dmar_remove_one_dev_info(struct device *dev)
 {
-	struct dmar_domain *domain;
-	struct intel_iommu *iommu;
-
-	assert_spin_locked(&device_domain_lock);
-
-	if (WARN_ON(!info))
-		return;
-
-	iommu = info->iommu;
-	domain = info->domain;
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct intel_iommu *iommu = info->iommu;
+	unsigned long flags;
 
-	if (info->dev && !dev_is_real_dma_subdevice(info->dev)) {
+	if (!dev_is_real_dma_subdevice(info->dev)) {
 		if (dev_is_pci(info->dev) && sm_supported(iommu))
 			intel_pasid_tear_down_entry(iommu, info->dev,
 					PASID_RID2PASID, false);
@@ -4164,20 +4156,11 @@ static void __dmar_remove_one_dev_info(struct device_domain_info *info)
 		intel_pasid_free_table(info->dev);
 	}
 
-	list_del(&info->link);
-	domain_detach_iommu(domain, iommu);
-}
-
-static void dmar_remove_one_dev_info(struct device *dev)
-{
-	struct device_domain_info *info;
-	unsigned long flags;
-
 	spin_lock_irqsave(&device_domain_lock, flags);
-	info = dev_iommu_priv_get(dev);
-	if (info)
-		__dmar_remove_one_dev_info(info);
+	list_del(&info->link);
 	spin_unlock_irqrestore(&device_domain_lock, flags);
+
+	domain_detach_iommu(info->domain, iommu);
 }
 
 static int md_domain_init(struct dmar_domain *domain, int guest_width)
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
