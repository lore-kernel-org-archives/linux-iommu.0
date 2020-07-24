Return-Path: <SRS0=ASoY=BD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A16D1C433F7
	for <iommu@archiver.kernel.org>; Fri, 24 Jul 2020 01:54:48 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 812DF22B3F
	for <iommu@archiver.kernel.org>; Fri, 24 Jul 2020 01:54:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 812DF22B3F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5C46C881BB;
	Fri, 24 Jul 2020 01:54:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6osrQs+0gwcc; Fri, 24 Jul 2020 01:54:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id B3E38882E3;
	Fri, 24 Jul 2020 01:54:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A952CC0051;
	Fri, 24 Jul 2020 01:54:47 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 62DEAC004C
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jul 2020 01:54:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 52D0F881BB
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jul 2020 01:54:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6Say64m+J+yd for <iommu@lists.linux-foundation.org>;
 Fri, 24 Jul 2020 01:54:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 260F587F40
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jul 2020 01:54:45 +0000 (UTC)
IronPort-SDR: eOsSyryxFAOuxNRQpJgFQ5HxKvce4FFmBmBZSPdNfThOR1oB2DeDhtVE4Np2TDJgUvcv3cWxhL
 DfmeCKfF25sA==
X-IronPort-AV: E=McAfee;i="6000,8403,9691"; a="168778806"
X-IronPort-AV: E=Sophos;i="5.75,388,1589266800"; d="scan'208";a="168778806"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2020 18:54:45 -0700
IronPort-SDR: 0b55RnZFjcgbHPHS1PUHYVpFeDJMCZqYrqo/kTzF3tX/lNvl69kXHrgeCE+5rTus2ERMyXVNoL
 qGw9oMMF3toA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,388,1589266800"; d="scan'208";a="488576812"
Received: from allen-box.sh.intel.com ([10.239.159.139])
 by fmsmga006.fm.intel.com with ESMTP; 23 Jul 2020 18:54:43 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 12/12] iommu/vt-d: Rename intel-pasid.h to pasid.h
Date: Fri, 24 Jul 2020 09:49:25 +0800
Message-Id: <20200724014925.15523-13-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200724014925.15523-1-baolu.lu@linux.intel.com>
References: <20200724014925.15523-1-baolu.lu@linux.intel.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

As Intel VT-d files have been moved to its own subdirectory, the prefix
makes no sense. No functional changes.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/debugfs.c                  | 2 +-
 drivers/iommu/intel/iommu.c                    | 2 +-
 drivers/iommu/intel/pasid.c                    | 2 +-
 drivers/iommu/intel/{intel-pasid.h => pasid.h} | 2 +-
 drivers/iommu/intel/svm.c                      | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)
 rename drivers/iommu/intel/{intel-pasid.h => pasid.h} (98%)

diff --git a/drivers/iommu/intel/debugfs.c b/drivers/iommu/intel/debugfs.c
index cf1ebb98e418..efea7f02abd9 100644
--- a/drivers/iommu/intel/debugfs.c
+++ b/drivers/iommu/intel/debugfs.c
@@ -15,7 +15,7 @@
 
 #include <asm/irq_remapping.h>
 
-#include "intel-pasid.h"
+#include "pasid.h"
 
 struct tbl_walk {
 	u16 bus;
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index a939d17d40a1..ca557d351518 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -48,7 +48,7 @@
 #include <trace/events/intel_iommu.h>
 
 #include "../irq_remapping.h"
-#include "intel-pasid.h"
+#include "pasid.h"
 
 #define ROOT_SIZE		VTD_PAGE_SIZE
 #define CONTEXT_SIZE		VTD_PAGE_SIZE
diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index fa0154cce537..e6faedf42fd4 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -19,7 +19,7 @@
 #include <linux/pci-ats.h>
 #include <linux/spinlock.h>
 
-#include "intel-pasid.h"
+#include "pasid.h"
 
 /*
  * Intel IOMMU system wide PASID name space:
diff --git a/drivers/iommu/intel/intel-pasid.h b/drivers/iommu/intel/pasid.h
similarity index 98%
rename from drivers/iommu/intel/intel-pasid.h
rename to drivers/iommu/intel/pasid.h
index c5318d40e0fa..c9850766c3a9 100644
--- a/drivers/iommu/intel/intel-pasid.h
+++ b/drivers/iommu/intel/pasid.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * intel-pasid.h - PASID idr, table and entry header
+ * pasid.h - PASID idr, table and entry header
  *
  * Copyright (C) 2018 Intel Corporation
  *
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 85ce8daa3177..442623ac4b47 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -20,7 +20,7 @@
 #include <linux/ioasid.h>
 #include <asm/page.h>
 
-#include "intel-pasid.h"
+#include "pasid.h"
 
 static irqreturn_t prq_event_thread(int irq, void *d);
 static void intel_svm_drain_prq(struct device *dev, int pasid);
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
