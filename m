Return-Path: <SRS0=VAik=NT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ECE5C4320E
	for <iommu@archiver.kernel.org>; Sat, 28 Aug 2021 07:09:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D90BD6108B
	for <iommu@archiver.kernel.org>; Sat, 28 Aug 2021 07:09:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D90BD6108B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A0015615B8;
	Sat, 28 Aug 2021 07:09:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VPPVOLT88-kw; Sat, 28 Aug 2021 07:09:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6DFDC615C9;
	Sat, 28 Aug 2021 07:09:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 49E4BC0010;
	Sat, 28 Aug 2021 07:09:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 52962C001F
 for <iommu@lists.linux-foundation.org>; Sat, 28 Aug 2021 07:09:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 202B583134
 for <iommu@lists.linux-foundation.org>; Sat, 28 Aug 2021 07:09:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4KtUQcdPVlh8 for <iommu@lists.linux-foundation.org>;
 Sat, 28 Aug 2021 07:09:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 62CED830FB
 for <iommu@lists.linux-foundation.org>; Sat, 28 Aug 2021 07:09:24 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10089"; a="216222589"
X-IronPort-AV: E=Sophos;i="5.84,358,1620716400"; d="scan'208";a="216222589"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2021 00:09:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,358,1620716400"; d="scan'208";a="495954841"
Received: from allen-box.sh.intel.com ([10.239.159.118])
 by fmsmga008.fm.intel.com with ESMTP; 28 Aug 2021 00:09:22 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 1/2] iommu/vt-d: Fix PASID leak in intel_svm_unbind_mm()
Date: Sat, 28 Aug 2021 15:06:21 +0800
Message-Id: <20210828070622.2437559-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210828070622.2437559-1-baolu.lu@linux.intel.com>
References: <20210828070622.2437559-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: Fenghua Yu <fenghua.yu@intel.com>, iommu@lists.linux-foundation.org,
 Dave Jiang <dave.jiang@intel.com>
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

From: Fenghua Yu <fenghua.yu@intel.com>

The mm->pasid will be used in intel_svm_free_pasid() after load_pasid()
during unbinding mm. Clearing it in load_pasid() will cause PASID cannot
be freed in intel_svm_free_pasid().

Additionally mm->pasid was updated already before load_pasid() during pasid
allocation. No need to update it again in load_pasid() during binding mm.
Don't update mm->pasid to avoid the issues in both binding mm and unbinding
mm.

Fixes: 4048377414162 ("iommu/vt-d: Use iommu_sva_alloc(free)_pasid() helpers")
Reported-and-tested-by: Dave Jiang <dave.jiang@intel.com>
Co-developed-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Link: https://lore.kernel.org/r/20210826215918.4073446-1-fenghua.yu@intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/svm.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 2014fe8695ac..a3f84f2ff1ba 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -514,9 +514,6 @@ static void load_pasid(struct mm_struct *mm, u32 pasid)
 {
 	mutex_lock(&mm->context.lock);
 
-	/* Synchronize with READ_ONCE in update_pasid(). */
-	smp_store_release(&mm->pasid, pasid);
-
 	/* Update PASID MSR on all CPUs running the mm's tasks. */
 	on_each_cpu_mask(mm_cpumask(mm), _load_pasid, NULL, true);
 
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
