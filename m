Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F40FC433EF
	for <iommu@archiver.kernel.org>; Wed, 29 Jun 2022 07:51:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EEB7641995;
	Wed, 29 Jun 2022 07:51:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EEB7641995
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=K4tRYide
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XepQk4GWyfqn; Wed, 29 Jun 2022 07:51:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 18E37409C3;
	Wed, 29 Jun 2022 07:51:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 18E37409C3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CF7B4C0039;
	Wed, 29 Jun 2022 07:51:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8C7FDC002D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jun 2022 07:51:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 58BE9409A0
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jun 2022 07:51:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 58BE9409A0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YhIc-LHUIb5h for <iommu@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 07:51:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 451B1409C3
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 451B1409C3
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jun 2022 07:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1656489114; x=1688025114;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=+H3iqUVrNt1aGjueQ2PCPg/gSRm34eU6k9Nmq35zT4I=;
 b=K4tRYidevQR5KQ3noedBNLpVSzXNOJhjZTmVvCW9q4mdDrw0ZnQxbpV4
 96r15ZOogWOjZMjGumHJ91mYy8zg7M6yfFCV5PsXvKHYEcFLCHB7+RCAI
 RZulqfE8zetsCSQmV2L8i/iAAHnNa+xGdw3A8K3QiCxf5EJUpKcJ/IJJP
 db8JkBsvd4vvYwKDPEweUVcjjZT/KIDHfKuHP1KNYTSXq3I2oy+qgdJed
 3YQLMUYthat/P5NK9Dl6hrW7jRpXjiVeDCels9hrDZgaNoQR59XxHnC8R
 gR5TQO5Q4lRFRqlYLjPXJHH30n6RQ4Yvul6jVpP+O1MD5vFNTgkTbp1dr A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="262362914"
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; d="scan'208";a="262362914"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jun 2022 00:51:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; d="scan'208";a="588209580"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by orsmga007.jf.intel.com with ESMTP; 29 Jun 2022 00:51:51 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: iommu@lists.linux-foundation.org,
	iommu@lists.linux.dev
Subject: [PATCH v3 01/11] iommu/vt-d: debugfs: Remove device_domain_lock usage
Date: Wed, 29 Jun 2022 15:47:15 +0800
Message-Id: <20220629074725.2331441-2-baolu.lu@linux.intel.com>
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

The domain_translation_struct debugfs node is used to dump the DMAR page
tables for the PCI devices. It potentially races with setting domains to
devices. The existing code uses the global spinlock device_domain_lock to
avoid the races.

This removes the use of device_domain_lock outside of iommu.c by replacing
it with the group mutex lock. Using the group mutex lock is cleaner and
more compatible to following cleanups.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.h   |  1 -
 drivers/iommu/intel/debugfs.c | 43 +++++++++++++++++++++++++----------
 drivers/iommu/intel/iommu.c   |  2 +-
 3 files changed, 32 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 8285fcfa5fea..8deb745d8b36 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -480,7 +480,6 @@ enum {
 #define VTD_FLAG_SVM_CAPABLE		(1 << 2)
 
 extern int intel_iommu_sm;
-extern spinlock_t device_domain_lock;
 
 #define sm_supported(iommu)	(intel_iommu_sm && ecap_smts((iommu)->ecap))
 #define pasid_supported(iommu)	(sm_supported(iommu) &&			\
diff --git a/drivers/iommu/intel/debugfs.c b/drivers/iommu/intel/debugfs.c
index d927ef10641b..6e1a3f88abc8 100644
--- a/drivers/iommu/intel/debugfs.c
+++ b/drivers/iommu/intel/debugfs.c
@@ -342,13 +342,13 @@ static void pgtable_walk_level(struct seq_file *m, struct dma_pte *pde,
 	}
 }
 
-static int show_device_domain_translation(struct device *dev, void *data)
+static int __show_device_domain_translation(struct device *dev, void *data)
 {
-	struct device_domain_info *info = dev_iommu_priv_get(dev);
-	struct dmar_domain *domain = info->domain;
+	struct dmar_domain *domain;
 	struct seq_file *m = data;
 	u64 path[6] = { 0 };
 
+	domain = to_dmar_domain(iommu_get_domain_for_dev(dev));
 	if (!domain)
 		return 0;
 
@@ -359,20 +359,39 @@ static int show_device_domain_translation(struct device *dev, void *data)
 	pgtable_walk_level(m, domain->pgd, domain->agaw + 2, 0, path);
 	seq_putc(m, '\n');
 
-	return 0;
+	/* Don't iterate */
+	return 1;
 }
 
-static int domain_translation_struct_show(struct seq_file *m, void *unused)
+static int show_device_domain_translation(struct device *dev, void *data)
 {
-	unsigned long flags;
-	int ret;
+	struct iommu_group *group;
 
-	spin_lock_irqsave(&device_domain_lock, flags);
-	ret = bus_for_each_dev(&pci_bus_type, NULL, m,
-			       show_device_domain_translation);
-	spin_unlock_irqrestore(&device_domain_lock, flags);
+	group = iommu_group_get(dev);
+	if (group) {
+		/*
+		 * The group->mutex is held across the callback, which will
+		 * block calls to iommu_attach/detach_group/device. Hence,
+		 * the domain of the device will not change during traversal.
+		 *
+		 * All devices in an iommu group share a single domain, hence
+		 * we only dump the domain of the first device. Even though,
+		 * this code still possibly races with the iommu_unmap()
+		 * interface. This could be solved by RCU-freeing the page
+		 * table pages in the iommu_unmap() path.
+		 */
+		iommu_group_for_each_dev(group, data,
+					 __show_device_domain_translation);
+		iommu_group_put(group);
+	}
 
-	return ret;
+	return 0;
+}
+
+static int domain_translation_struct_show(struct seq_file *m, void *unused)
+{
+	return bus_for_each_dev(&pci_bus_type, NULL, m,
+				show_device_domain_translation);
 }
 DEFINE_SHOW_ATTRIBUTE(domain_translation_struct);
 
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 10bda4bec8fe..3b6571681bdd 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -314,7 +314,7 @@ static int iommu_skip_te_disable;
 #define IDENTMAP_GFX		2
 #define IDENTMAP_AZALIA		4
 
-DEFINE_SPINLOCK(device_domain_lock);
+static DEFINE_SPINLOCK(device_domain_lock);
 static LIST_HEAD(device_domain_list);
 
 const struct iommu_ops intel_iommu_ops;
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
