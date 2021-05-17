Return-Path: <SRS0=Mf8z=KM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CBA6C433ED
	for <iommu@archiver.kernel.org>; Mon, 17 May 2021 06:55:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAFDD6121F
	for <iommu@archiver.kernel.org>; Mon, 17 May 2021 06:55:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAFDD6121F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 62E0B403D0;
	Mon, 17 May 2021 06:55:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qv822g3VvcDS; Mon, 17 May 2021 06:55:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id E7B3B403D2;
	Mon, 17 May 2021 06:55:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BF0BDC000D;
	Mon, 17 May 2021 06:55:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5C277C0001
 for <iommu@lists.linux-foundation.org>; Mon, 17 May 2021 06:55:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3C2F2403D2
 for <iommu@lists.linux-foundation.org>; Mon, 17 May 2021 06:55:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ngopXSUPXR-8 for <iommu@lists.linux-foundation.org>;
 Mon, 17 May 2021 06:55:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7A85A403D0
 for <iommu@lists.linux-foundation.org>; Mon, 17 May 2021 06:55:26 +0000 (UTC)
IronPort-SDR: UfG8T6861bRR9+tH4QiL7bwa6txDH9N4R9fh6IgLlJVQvP7wKlVTvNccEkF262wA9cMpTewumW
 QBnZs5NRs4tw==
X-IronPort-AV: E=McAfee;i="6200,9189,9986"; a="261635191"
X-IronPort-AV: E=Sophos;i="5.82,306,1613462400"; d="scan'208";a="261635191"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 May 2021 23:55:25 -0700
IronPort-SDR: KeXez7K1RYKXJwlOE1fJAV0gc9GZTGTEZb8gsphTouGsZIjMSV3CccSWBhidmZyMrkZkiYLTSK
 T7SF46e1K7AA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,306,1613462400"; d="scan'208";a="460173873"
Received: from allen-box.sh.intel.com ([10.239.159.128])
 by fmsmga004.fm.intel.com with ESMTP; 16 May 2021 23:55:22 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Subject: [PATCH v2 1/1] iommu/vt-d: Tweak the description of a DMA fault
Date: Mon, 17 May 2021 14:54:25 +0800
Message-Id: <20210517065425.4953-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: kevin.tian@intel.com, ashok.raj@intel.com, sanjay.k.kumar@intel.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 jacob.jun.pan@intel.com
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

The Intel IOMMU driver reports the DMA fault reason in a decimal number
while the VT-d specification uses a hexadecimal one. It's inconvenient
that users need to covert them everytime before consulting the spec.
Let's use hexadecimal number for a DMA fault reason.

The fault message uses 0xffffffff as PASID for DMA requests w/o PASID.
This is confusing. Tweak this by adding "NO_PASID" explicitly.

Reviewed-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/dmar.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

Change log:
v1->v2:
 - Add "0x" prefix to all hex numbers

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 1757ac1e1623..1e31e6799d5c 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1911,16 +1911,23 @@ static int dmar_fault_do_one(struct intel_iommu *iommu, int type,
 	reason = dmar_get_fault_reason(fault_reason, &fault_type);
 
 	if (fault_type == INTR_REMAP)
-		pr_err("[INTR-REMAP] Request device [%02x:%02x.%d] fault index %llx [fault reason %02d] %s\n",
-			source_id >> 8, PCI_SLOT(source_id & 0xFF),
-			PCI_FUNC(source_id & 0xFF), addr >> 48,
-			fault_reason, reason);
-	else
-		pr_err("[%s] Request device [%02x:%02x.%d] PASID %x fault addr %llx [fault reason %02d] %s\n",
+		pr_err("[INTR-REMAP] Request device [0x%02x:0x%02x.%d] fault index 0x%llx [fault reason 0x%02x] %s\n",
+		       source_id >> 8, PCI_SLOT(source_id & 0xFF),
+		       PCI_FUNC(source_id & 0xFF), addr >> 48,
+		       fault_reason, reason);
+	else if (pasid == INVALID_IOASID)
+		pr_err("[%s NO_PASID] Request device [0x%02x:0x%02x.%d] fault addr 0x%llx [fault reason 0x%02x] %s\n",
 		       type ? "DMA Read" : "DMA Write",
 		       source_id >> 8, PCI_SLOT(source_id & 0xFF),
-		       PCI_FUNC(source_id & 0xFF), pasid, addr,
+		       PCI_FUNC(source_id & 0xFF), addr,
 		       fault_reason, reason);
+	else
+		pr_err("[%s PASID 0x%x] Request device [0x%02x:0x%02x.%d] fault addr 0x%llx [fault reason 0x%02x] %s\n",
+		       type ? "DMA Read" : "DMA Write", pasid,
+		       source_id >> 8, PCI_SLOT(source_id & 0xFF),
+		       PCI_FUNC(source_id & 0xFF), addr,
+		       fault_reason, reason);
+
 	return 0;
 }
 
@@ -1987,7 +1994,7 @@ irqreturn_t dmar_fault(int irq, void *dev_id)
 		if (!ratelimited)
 			/* Using pasid -1 if pasid is not present */
 			dmar_fault_do_one(iommu, type, fault_reason,
-					  pasid_present ? pasid : -1,
+					  pasid_present ? pasid : INVALID_IOASID,
 					  source_id, guest_addr);
 
 		fault_index++;
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
