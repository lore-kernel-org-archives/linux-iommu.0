Return-Path: <SRS0=5nCU=HB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C68BC433E0
	for <iommu@archiver.kernel.org>; Sat, 30 Jan 2021 15:27:39 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDD7264E13
	for <iommu@archiver.kernel.org>; Sat, 30 Jan 2021 15:27:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDD7264E13
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 62C9E86B67;
	Sat, 30 Jan 2021 15:27:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1+TiDJ086uCo; Sat, 30 Jan 2021 15:27:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 324A086B39;
	Sat, 30 Jan 2021 15:27:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 22EF8C08A1;
	Sat, 30 Jan 2021 15:27:36 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8CB2AC013A
 for <iommu@lists.linux-foundation.org>; Sat, 30 Jan 2021 15:27:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 756DF20480
 for <iommu@lists.linux-foundation.org>; Sat, 30 Jan 2021 15:27:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eM-WUq7m72OZ for <iommu@lists.linux-foundation.org>;
 Sat, 30 Jan 2021 15:27:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by silver.osuosl.org (Postfix) with ESMTPS id 655AE20443
 for <iommu@lists.linux-foundation.org>; Sat, 30 Jan 2021 15:27:33 +0000 (UTC)
IronPort-SDR: 9cGTEbzQK5iB6a+ukB7Wo4zjD+PtVy6VRrZ4QwVmNZ71IQrcZjUCuh+UQElVZZFkyTGcJumVyR
 YrnzSXUkCpRA==
X-IronPort-AV: E=McAfee;i="6000,8403,9880"; a="177974161"
X-IronPort-AV: E=Sophos;i="5.79,388,1602572400"; d="scan'208";a="177974161"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jan 2021 07:27:32 -0800
IronPort-SDR: 0Fdaod5SS/O4p5u2mRo7WEr3CE5ATOhPuMbQemLHOhjpL6GaqNiSsXJ216wJ2gemxMc6D0KRnY
 DUBGSW/l7tFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,388,1602572400"; d="scan'208";a="404853077"
Received: from allen-box.sh.intel.com ([10.239.159.128])
 by fmsmga004.fm.intel.com with ESMTP; 30 Jan 2021 07:27:31 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 1/1] iommu/vt-d: Fix compile error
 [-Werror=implicit-function-declaration]
Date: Sat, 30 Jan 2021 23:19:07 +0800
Message-Id: <20210130151907.3929148-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: kernel test robot <lkp@intel.com>, iommu@lists.linux-foundation.org,
 Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
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

trace_qi_submit() could be used when interrupt remapping is supported,
but DMA remapping is not. In this case, the following compile error
occurs.

../drivers/iommu/intel/dmar.c: In function 'qi_submit_sync':
../drivers/iommu/intel/dmar.c:1311:3: error: implicit declaration of function 'trace_qi_submit';
  did you mean 'ftrace_nmi_exit'? [-Werror=implicit-function-declaration]
   trace_qi_submit(iommu, desc[i].qw0, desc[i].qw1,
   ^~~~~~~~~~~~~~~
   ftrace_nmi_exit

Fixes: f2dd871799ba5 ("iommu/vt-d: Add qi_submit trace event")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/Makefile       | 2 +-
 drivers/iommu/intel/iommu.c        | 1 -
 include/trace/events/intel_iommu.h | 2 --
 3 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/iommu/intel/Makefile b/drivers/iommu/intel/Makefile
index fb8e1e8c8029..ae570810a35e 100644
--- a/drivers/iommu/intel/Makefile
+++ b/drivers/iommu/intel/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_DMAR_TABLE) += dmar.o
 obj-$(CONFIG_INTEL_IOMMU) += iommu.o pasid.o
-obj-$(CONFIG_INTEL_IOMMU) += trace.o
+obj-$(CONFIG_DMAR_TABLE) += trace.o
 obj-$(CONFIG_INTEL_IOMMU_DEBUGFS) += debugfs.o
 obj-$(CONFIG_INTEL_IOMMU_SVM) += svm.o
 obj-$(CONFIG_IRQ_REMAP) += irq_remapping.o
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index d7fecc109947..37da4caa67c9 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -44,7 +44,6 @@
 #include <asm/irq_remapping.h>
 #include <asm/cacheflush.h>
 #include <asm/iommu.h>
-#include <trace/events/intel_iommu.h>
 
 #include "../irq_remapping.h"
 #include "pasid.h"
diff --git a/include/trace/events/intel_iommu.h b/include/trace/events/intel_iommu.h
index aad2ff0c1e2e..e801f4910522 100644
--- a/include/trace/events/intel_iommu.h
+++ b/include/trace/events/intel_iommu.h
@@ -6,7 +6,6 @@
  *
  * Author: Lu Baolu <baolu.lu@linux.intel.com>
  */
-#ifdef CONFIG_INTEL_IOMMU
 #undef TRACE_SYSTEM
 #define TRACE_SYSTEM intel_iommu
 
@@ -176,4 +175,3 @@ TRACE_EVENT(qi_submit,
 
 /* This part must be outside protection */
 #include <trace/define_trace.h>
-#endif /* CONFIG_INTEL_IOMMU */
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
