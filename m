Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38F84C433EF
	for <iommu@archiver.kernel.org>; Thu, 16 Dec 2021 01:17:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B078E4168B;
	Thu, 16 Dec 2021 01:17:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id shbF9nYS4D5Y; Thu, 16 Dec 2021 01:17:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9740541667;
	Thu, 16 Dec 2021 01:17:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 63F27C001E;
	Thu, 16 Dec 2021 01:17:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A6C87C0012
 for <iommu@lists.linux-foundation.org>; Thu, 16 Dec 2021 01:17:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7F94640ABE
 for <iommu@lists.linux-foundation.org>; Thu, 16 Dec 2021 01:17:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7NodosrdDd1T for <iommu@lists.linux-foundation.org>;
 Thu, 16 Dec 2021 01:17:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DA22D40587
 for <iommu@lists.linux-foundation.org>; Thu, 16 Dec 2021 01:17:26 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10199"; a="220056672"
X-IronPort-AV: E=Sophos;i="5.88,210,1635231600"; d="scan'208";a="220056672"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Dec 2021 17:17:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,210,1635231600"; d="scan'208";a="662173740"
Received: from allen-box.sh.intel.com ([10.239.159.118])
 by fmsmga001.fm.intel.com with ESMTP; 15 Dec 2021 17:17:23 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 1/1] iommu/vt-d: Remove unused macros
Date: Thu, 16 Dec 2021 09:17:03 +0800
Message-Id: <20211216011703.763331-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org
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

These macros has no reference in the tree anymore. Cleanup them.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/intel-svm.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/linux/intel-svm.h b/include/linux/intel-svm.h
index 57cceecbe37f..1b73bab7eeff 100644
--- a/include/linux/intel-svm.h
+++ b/include/linux/intel-svm.h
@@ -8,12 +8,6 @@
 #ifndef __INTEL_SVM_H__
 #define __INTEL_SVM_H__
 
-/* Values for rxwp in fault_cb callback */
-#define SVM_REQ_READ	(1<<3)
-#define SVM_REQ_WRITE	(1<<2)
-#define SVM_REQ_EXEC	(1<<1)
-#define SVM_REQ_PRIV	(1<<0)
-
 /* Page Request Queue depth */
 #define PRQ_ORDER	2
 #define PRQ_RING_MASK	((0x1000 << PRQ_ORDER) - 0x20)
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
