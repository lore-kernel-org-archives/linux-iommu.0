Return-Path: <SRS0=NhDI=NJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1685C4338F
	for <iommu@archiver.kernel.org>; Wed, 18 Aug 2021 13:51:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2A7F61058
	for <iommu@archiver.kernel.org>; Wed, 18 Aug 2021 13:51:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A2A7F61058
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7E72C80DE2;
	Wed, 18 Aug 2021 13:51:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hgRdDQAjkalF; Wed, 18 Aug 2021 13:51:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 51F2080DC1;
	Wed, 18 Aug 2021 13:51:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3C719C001A;
	Wed, 18 Aug 2021 13:51:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 33C37C000E
 for <iommu@lists.linux-foundation.org>; Wed, 18 Aug 2021 13:51:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2200A402C8
 for <iommu@lists.linux-foundation.org>; Wed, 18 Aug 2021 13:51:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9ObZiqfrAvLm for <iommu@lists.linux-foundation.org>;
 Wed, 18 Aug 2021 13:51:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 35308402BA
 for <iommu@lists.linux-foundation.org>; Wed, 18 Aug 2021 13:51:44 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10080"; a="214478847"
X-IronPort-AV: E=Sophos;i="5.84,330,1620716400"; d="scan'208";a="214478847"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2021 06:51:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,330,1620716400"; d="scan'208";a="449729212"
Received: from allen-box.sh.intel.com ([10.239.159.118])
 by fmsmga007.fm.intel.com with ESMTP; 18 Aug 2021 06:51:41 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 1/9] iommu/vt-d: Update the virtual command related registers
Date: Wed, 18 Aug 2021 21:48:44 +0800
Message-Id: <20210818134852.1847070-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210818134852.1847070-1-baolu.lu@linux.intel.com>
References: <20210818134852.1847070-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Sanjay Kumar <sanjay.k.kumar@intel.com>, iommu@lists.linux-foundation.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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

The VT-d spec Revision 3.3 updated the virtual command registers, virtual
command opcode B register, virtual command response register and virtual
command capability register (Section 10.4.43, 10.4.44, 10.4.45, 10.4.46).
This updates the virtual command interface implementation in the Intel
IOMMU driver accordingly.

Fixes: 24f27d32ab6b7 ("iommu/vt-d: Enlightened PASID allocation")
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Sanjay Kumar <sanjay.k.kumar@intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20210713042649.3547403-1-baolu.lu@linux.intel.com
---
 include/linux/intel-iommu.h |  6 +++---
 drivers/iommu/intel/pasid.h | 10 +++++-----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index d0fa0b31994d..05a65eb155f7 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -124,9 +124,9 @@
 #define DMAR_MTRR_PHYSMASK8_REG 0x208
 #define DMAR_MTRR_PHYSBASE9_REG 0x210
 #define DMAR_MTRR_PHYSMASK9_REG 0x218
-#define DMAR_VCCAP_REG		0xe00 /* Virtual command capability register */
-#define DMAR_VCMD_REG		0xe10 /* Virtual command register */
-#define DMAR_VCRSP_REG		0xe20 /* Virtual command response register */
+#define DMAR_VCCAP_REG		0xe30 /* Virtual command capability register */
+#define DMAR_VCMD_REG		0xe00 /* Virtual command register */
+#define DMAR_VCRSP_REG		0xe10 /* Virtual command response register */
 
 #define DMAR_IQER_REG_IQEI(reg)		FIELD_GET(GENMASK_ULL(3, 0), reg)
 #define DMAR_IQER_REG_ITESID(reg)	FIELD_GET(GENMASK_ULL(47, 32), reg)
diff --git a/drivers/iommu/intel/pasid.h b/drivers/iommu/intel/pasid.h
index c11bc8b833b8..d5552e2c160d 100644
--- a/drivers/iommu/intel/pasid.h
+++ b/drivers/iommu/intel/pasid.h
@@ -28,12 +28,12 @@
 #define VCMD_CMD_ALLOC			0x1
 #define VCMD_CMD_FREE			0x2
 #define VCMD_VRSP_IP			0x1
-#define VCMD_VRSP_SC(e)			(((e) >> 1) & 0x3)
+#define VCMD_VRSP_SC(e)			(((e) & 0xff) >> 1)
 #define VCMD_VRSP_SC_SUCCESS		0
-#define VCMD_VRSP_SC_NO_PASID_AVAIL	2
-#define VCMD_VRSP_SC_INVALID_PASID	2
-#define VCMD_VRSP_RESULT_PASID(e)	(((e) >> 8) & 0xfffff)
-#define VCMD_CMD_OPERAND(e)		((e) << 8)
+#define VCMD_VRSP_SC_NO_PASID_AVAIL	16
+#define VCMD_VRSP_SC_INVALID_PASID	16
+#define VCMD_VRSP_RESULT_PASID(e)	(((e) >> 16) & 0xfffff)
+#define VCMD_CMD_OPERAND(e)		((e) << 16)
 /*
  * Domain ID reserved for pasid entries programmed for first-level
  * only and pass-through transfer modes.
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
