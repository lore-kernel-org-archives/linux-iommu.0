Return-Path: <SRS0=YAC4=GD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6161C433DB
	for <iommu@archiver.kernel.org>; Thu, 31 Dec 2020 01:01:30 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C9A3221FA
	for <iommu@archiver.kernel.org>; Thu, 31 Dec 2020 01:01:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C9A3221FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0F76E873A5;
	Thu, 31 Dec 2020 01:01:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4yI2bS2KEibi; Thu, 31 Dec 2020 01:01:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id C89358737A;
	Thu, 31 Dec 2020 01:01:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9D34CC1DA7;
	Thu, 31 Dec 2020 01:01:28 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B2E0AC013A
 for <iommu@lists.linux-foundation.org>; Thu, 31 Dec 2020 01:01:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 90D932036B
 for <iommu@lists.linux-foundation.org>; Thu, 31 Dec 2020 01:01:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6JCmLZnyxnEO for <iommu@lists.linux-foundation.org>;
 Thu, 31 Dec 2020 01:01:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by silver.osuosl.org (Postfix) with ESMTPS id C01742E0E4
 for <iommu@lists.linux-foundation.org>; Thu, 31 Dec 2020 01:01:25 +0000 (UTC)
IronPort-SDR: /rWc2jgPWbzyz8DlHqSy5CjuDBt9SegUEwqtcO+JgM0CKfLwggsfgqWCbgq9u1vQE9elurC/uB
 aC1P1RI7Vy0Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9850"; a="176754107"
X-IronPort-AV: E=Sophos;i="5.78,462,1599548400"; d="scan'208";a="176754107"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Dec 2020 17:01:25 -0800
IronPort-SDR: QjJke4P2SbrVBJ0IJWOh0rgwcSZ/vVEY2SYmPQiZ54DoUU1xFs4hmajQQ38go6o71mNL1Qzy5R
 T8+z6BH9ZQhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,462,1599548400"; d="scan'208";a="460676225"
Received: from allen-box.sh.intel.com ([10.239.159.28])
 by fmsmga001.fm.intel.com with ESMTP; 30 Dec 2020 17:01:23 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Subject: [PATCH 2/5] iommu/vt-d: Fix unaligned addresses for
 intel_flush_svm_range_dev()
Date: Thu, 31 Dec 2020 08:53:20 +0800
Message-Id: <20201231005323.2178523-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201231005323.2178523-1-baolu.lu@linux.intel.com>
References: <20201231005323.2178523-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: Ashok Raj <ashok.raj@intel.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Guo Kaijie <Kaijie.Guo@intel.com>
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

The VT-d hardware will ignore those Addr bits which have been masked by
the AM field in the PASID-based-IOTLB invalidation descriptor. As the
result, if the starting address in the descriptor is not aligned with
the address mask, some IOTLB caches might not invalidate. Hence people
will see below errors.

[ 1093.704661] dmar_fault: 29 callbacks suppressed
[ 1093.704664] DMAR: DRHD: handling fault status reg 3
[ 1093.712738] DMAR: [DMA Read] Request device [7a:02.0] PASID 2
               fault addr 7f81c968d000 [fault reason 113]
               SM: Present bit in first-level paging entry is clear

Fix this by using aligned address for PASID-based-IOTLB invalidation.

Fixes: 1c4f88b7f1f92 ("iommu/vt-d: Shared virtual address in scalable mode")
Reported-and-tested-by: Guo Kaijie <Kaijie.Guo@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/svm.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 69566695d032..b16a4791acfb 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -118,8 +118,10 @@ void intel_svm_check(struct intel_iommu *iommu)
 	iommu->flags |= VTD_FLAG_SVM_CAPABLE;
 }
 
-static void intel_flush_svm_range_dev (struct intel_svm *svm, struct intel_svm_dev *sdev,
-				unsigned long address, unsigned long pages, int ih)
+static void __flush_svm_range_dev(struct intel_svm *svm,
+				  struct intel_svm_dev *sdev,
+				  unsigned long address,
+				  unsigned long pages, int ih)
 {
 	struct qi_desc desc;
 
@@ -170,6 +172,22 @@ static void intel_flush_svm_range_dev (struct intel_svm *svm, struct intel_svm_d
 	}
 }
 
+static void intel_flush_svm_range_dev(struct intel_svm *svm,
+				      struct intel_svm_dev *sdev,
+				      unsigned long address,
+				      unsigned long pages, int ih)
+{
+	unsigned long shift = ilog2(__roundup_pow_of_two(pages));
+	unsigned long align = (1ULL << (VTD_PAGE_SHIFT + shift));
+	unsigned long start = ALIGN_DOWN(address, align);
+	unsigned long end = ALIGN(address + (pages << VTD_PAGE_SHIFT), align);
+
+	while (start < end) {
+		__flush_svm_range_dev(svm, sdev, start, align >> VTD_PAGE_SHIFT, ih);
+		start += align;
+	}
+}
+
 static void intel_flush_svm_range(struct intel_svm *svm, unsigned long address,
 				unsigned long pages, int ih)
 {
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
