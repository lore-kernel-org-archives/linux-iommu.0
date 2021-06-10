Return-Path: <SRS0=Vfdp=LE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 948C6C48BD1
	for <iommu@archiver.kernel.org>; Thu, 10 Jun 2021 02:04:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FFB261418
	for <iommu@archiver.kernel.org>; Thu, 10 Jun 2021 02:04:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FFB261418
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B4F626062B;
	Thu, 10 Jun 2021 02:04:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m0qLdieUOsbu; Thu, 10 Jun 2021 02:04:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id AF8E160856;
	Thu, 10 Jun 2021 02:04:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6AFD3C0023;
	Thu, 10 Jun 2021 02:04:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 60C42C000B
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 02:04:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 755E0405A1
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 02:04:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AT9N5Mkwe0NO for <iommu@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 02:04:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5A76B40594
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 02:04:16 +0000 (UTC)
IronPort-SDR: AdFGZh1piEL8hbnv2AiqSL2OexQbWg7GykdHeDc7KYWi9e+HOHJ/fKP9dQ5zeLDJgtVbYIxIur
 fR8GIYpsLwXQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10010"; a="202184346"
X-IronPort-AV: E=Sophos;i="5.83,262,1616482800"; d="scan'208";a="202184346"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2021 19:04:00 -0700
IronPort-SDR: 7L6VU5ZxcsbjBfzz758ToX/XR/trKaffbmed+2hysVboOwZKv/acYIU4ayWZdkr+T1FXpS/TZ7
 149GtV3Aik3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,262,1616482800"; d="scan'208";a="402500552"
Received: from allen-box.sh.intel.com ([10.239.159.105])
 by orsmga006.jf.intel.com with ESMTP; 09 Jun 2021 19:03:57 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 20/23] iommu/vt-d: Removed unused iommu_count in dmar domain
Date: Thu, 10 Jun 2021 10:01:12 +0800
Message-Id: <20210610020115.1637656-21-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210610020115.1637656-1-baolu.lu@linux.intel.com>
References: <20210610020115.1637656-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: Fenghua Yu <fenghua.yu@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Aditya Srivastava <yashsri421@gmail.com>, Randy Dunlap <rdunlap@infradead.org>,
 YueHaibing <yuehaibing@huawei.com>,
 "Gustavo A . R . Silva" <gustavoars@kernel.org>,
 iommu@lists.linux-foundation.org, Colin Ian King <colin.king@canonical.com>,
 Will Deacon <will@kernel.org>
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

From: Parav Pandit <parav@nvidia.com>

DMAR domain uses per DMAR refcount. It is indexed by iommu seq_id.
Older iommu_count is only incremented and decremented but no decisions
are taken based on this refcount. This is not of much use.

Hence, remove iommu_count and further simplify domain_detach_iommu()
by returning void.

Signed-off-by: Parav Pandit <parav@nvidia.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Link: https://lore.kernel.org/r/20210530075053.264218-1-parav@nvidia.com
---
 include/linux/intel-iommu.h |  1 -
 drivers/iommu/intel/iommu.c | 11 +++--------
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 2621eff04c82..574b932dfe86 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -561,7 +561,6 @@ struct dmar_domain {
 	int		agaw;
 
 	int		flags;		/* flags to find out type of domain */
-	int		iommu_count;	/* reference count of iommu */
 	int		iommu_superpage;/* Level of superpages supported:
 					   0 == 4KiB (no superpages), 1 == 2MiB,
 					   2 == 1GiB, 3 == 512GiB, 4 == 1TiB */
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 430ef2232d47..dd8ecfbfdb23 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1920,7 +1920,6 @@ static int domain_attach_iommu(struct dmar_domain *domain,
 	assert_spin_locked(&iommu->lock);
 
 	domain->iommu_refcnt[iommu->seq_id] += 1;
-	domain->iommu_count += 1;
 	if (domain->iommu_refcnt[iommu->seq_id] == 1) {
 		ndomains = cap_ndoms(iommu->cap);
 		num      = find_first_zero_bit(iommu->domain_ids, ndomains);
@@ -1928,7 +1927,6 @@ static int domain_attach_iommu(struct dmar_domain *domain,
 		if (num >= ndomains) {
 			pr_err("%s: No free domain ids\n", iommu->name);
 			domain->iommu_refcnt[iommu->seq_id] -= 1;
-			domain->iommu_count -= 1;
 			return -ENOSPC;
 		}
 
@@ -1944,16 +1942,15 @@ static int domain_attach_iommu(struct dmar_domain *domain,
 	return 0;
 }
 
-static int domain_detach_iommu(struct dmar_domain *domain,
-			       struct intel_iommu *iommu)
+static void domain_detach_iommu(struct dmar_domain *domain,
+				struct intel_iommu *iommu)
 {
-	int num, count;
+	int num;
 
 	assert_spin_locked(&device_domain_lock);
 	assert_spin_locked(&iommu->lock);
 
 	domain->iommu_refcnt[iommu->seq_id] -= 1;
-	count = --domain->iommu_count;
 	if (domain->iommu_refcnt[iommu->seq_id] == 0) {
 		num = domain->iommu_did[iommu->seq_id];
 		clear_bit(num, iommu->domain_ids);
@@ -1962,8 +1959,6 @@ static int domain_detach_iommu(struct dmar_domain *domain,
 		domain_update_iommu_cap(domain);
 		domain->iommu_did[iommu->seq_id] = 0;
 	}
-
-	return count;
 }
 
 static inline int guestwidth_to_adjustwidth(int gaw)
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
