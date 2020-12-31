Return-Path: <SRS0=YAC4=GD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0733AC433E0
	for <iommu@archiver.kernel.org>; Thu, 31 Dec 2020 01:01:30 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82E50221FA
	for <iommu@archiver.kernel.org>; Thu, 31 Dec 2020 01:01:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82E50221FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2F94986E45;
	Thu, 31 Dec 2020 01:01:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vQPL+YXSnAEt; Thu, 31 Dec 2020 01:01:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7D94086899;
	Thu, 31 Dec 2020 01:01:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6F516C088B;
	Thu, 31 Dec 2020 01:01:28 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 89500C013A
 for <iommu@lists.linux-foundation.org>; Thu, 31 Dec 2020 01:01:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 4C9C22E0E9
 for <iommu@lists.linux-foundation.org>; Thu, 31 Dec 2020 01:01:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XX5FGLwvnVtA for <iommu@lists.linux-foundation.org>;
 Thu, 31 Dec 2020 01:01:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by silver.osuosl.org (Postfix) with ESMTPS id 1532D2036B
 for <iommu@lists.linux-foundation.org>; Thu, 31 Dec 2020 01:01:24 +0000 (UTC)
IronPort-SDR: PHu1a4ERhH46XA/L4hwSrGug5XoSF/PshcFlGdUC7Thcmw2sOml2XD7UC+rbR+ARGPOo+B+DIq
 DYt1dRJFf40g==
X-IronPort-AV: E=McAfee;i="6000,8403,9850"; a="176754103"
X-IronPort-AV: E=Sophos;i="5.78,462,1599548400"; d="scan'208";a="176754103"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Dec 2020 17:01:23 -0800
IronPort-SDR: bZrafJa6JgKKeMplBEHcCnRpluwTaZIJgv0PlOSSG37PYi7wmJwQjfRq7kqw0bM+9vPtUBWq6H
 eGCLLacmyEZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,462,1599548400"; d="scan'208";a="460676216"
Received: from allen-box.sh.intel.com ([10.239.159.28])
 by fmsmga001.fm.intel.com with ESMTP; 30 Dec 2020 17:01:21 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Subject: [PATCH 1/5] iommu/vt-d: Fix misuse of ALIGN in qi_flush_piotlb()
Date: Thu, 31 Dec 2020 08:53:19 +0800
Message-Id: <20201231005323.2178523-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
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

Use IS_ALIGNED() instead. Otherwise, an unaligned address will be ignored.

Fixes: 33cd6e642d6a7 ("iommu/vt-d: Flush PASID-based iotlb for iova over first level")
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/dmar.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index b46dbfa6d0ed..004feaed3c72 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1461,8 +1461,8 @@ void qi_flush_piotlb(struct intel_iommu *iommu, u16 did, u32 pasid, u64 addr,
 		int mask = ilog2(__roundup_pow_of_two(npages));
 		unsigned long align = (1ULL << (VTD_PAGE_SHIFT + mask));
 
-		if (WARN_ON_ONCE(!ALIGN(addr, align)))
-			addr &= ~(align - 1);
+		if (WARN_ON_ONCE(!IS_ALIGNED(addr, align)))
+			addr = ALIGN_DOWN(addr, align);
 
 		desc.qw0 = QI_EIOTLB_PASID(pasid) |
 				QI_EIOTLB_DID(did) |
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
