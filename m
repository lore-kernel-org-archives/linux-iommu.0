Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF600C433F5
	for <iommu@archiver.kernel.org>; Sat, 14 May 2022 01:47:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5FEB182E14;
	Sat, 14 May 2022 01:47:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id reTFXqdm38PH; Sat, 14 May 2022 01:47:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 045F982726;
	Sat, 14 May 2022 01:47:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D3CEEC0032;
	Sat, 14 May 2022 01:47:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 403B6C002D
 for <iommu@lists.linux-foundation.org>; Sat, 14 May 2022 01:47:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2F1FB40516
 for <iommu@lists.linux-foundation.org>; Sat, 14 May 2022 01:47:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cEufyTJ-r-t6 for <iommu@lists.linux-foundation.org>;
 Sat, 14 May 2022 01:47:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 52E7D400AF
 for <iommu@lists.linux-foundation.org>; Sat, 14 May 2022 01:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1652492836; x=1684028836;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=h9H5Br/N5inR8hBGkTrWQLfQT0kDOku9gguSP1OEsxA=;
 b=IhVnR980ayc/Cr3b86axBshi7VWW/0hqvbekTAC4ICQRhwKg7U8cU147
 27iViuIGAAjj7zeg+ZJsjaiwXgD1CtcQKrNUC208V8pTp6oJks8HqdWfU
 4/8siVttweixv+lwpTwKWSrIHXo+b+hWLfMu1bg0RKx+P5Y0XVOVxvDgx
 9Abw7QmFAeSdMTdNb1bKRmZ4JWifNegRU9oo/uR3u6gHkXyzkVgnuDq/7
 4oZB3+9EJBTP0Ud46hnhh3Z+KhUyEbmPG1tYjVjYCwYhunTyw6BApQ7RL
 Ols79Ak6rFzOY8QmTHPaXvU0SLKWl7Zzjx/wqhxfFfnYq8THCLOjcmp9Z g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10346"; a="258005814"
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; d="scan'208";a="258005814"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 May 2022 18:47:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; d="scan'208";a="712630839"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by fmsmga001.fm.intel.com with ESMTP; 13 May 2022 18:47:09 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, David Airlie <airlied@linux.ie>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
 Daniel Vetter <daniel@ffwll.ch>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Liu Yi L <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, Ning Sun <ning.sun@intel.com>
Subject: [PATCH 7/7] iommu/vt-d: Move include/linux/intel_iommu.h under iommu
Date: Sat, 14 May 2022 09:43:22 +0800
Message-Id: <20220514014322.2927339-8-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220514014322.2927339-1-baolu.lu@linux.intel.com>
References: <20220514014322.2927339-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: Steve Wahl <steve.wahl@hpe.com>, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Jason Gunthorpe <jgg@nvidia.com>, Robin Murphy <robin.murphy@arm.com>,
 Christoph Hellwig <hch@lst.de>
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

This header file is private to the Intel IOMMU driver. Move it to the
driver folder.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/intel-iommu.h => drivers/iommu/intel/iommu.h | 0
 drivers/iommu/intel/trace.h                                | 3 ++-
 drivers/iommu/intel/cap_audit.c                            | 2 +-
 drivers/iommu/intel/debugfs.c                              | 2 +-
 drivers/iommu/intel/dmar.c                                 | 2 +-
 drivers/iommu/intel/iommu.c                                | 2 +-
 drivers/iommu/intel/irq_remapping.c                        | 2 +-
 drivers/iommu/intel/pasid.c                                | 2 +-
 drivers/iommu/intel/perf.c                                 | 2 +-
 drivers/iommu/intel/svm.c                                  | 2 +-
 MAINTAINERS                                                | 1 -
 11 files changed, 10 insertions(+), 10 deletions(-)
 rename include/linux/intel-iommu.h => drivers/iommu/intel/iommu.h (100%)

diff --git a/include/linux/intel-iommu.h b/drivers/iommu/intel/iommu.h
similarity index 100%
rename from include/linux/intel-iommu.h
rename to drivers/iommu/intel/iommu.h
diff --git a/drivers/iommu/intel/trace.h b/drivers/iommu/intel/trace.h
index 25cb7f88e1a2..93d96f93a89b 100644
--- a/drivers/iommu/intel/trace.h
+++ b/drivers/iommu/intel/trace.h
@@ -13,7 +13,8 @@
 #define _TRACE_INTEL_IOMMU_H
 
 #include <linux/tracepoint.h>
-#include <linux/intel-iommu.h>
+
+#include "iommu.h"
 
 #define MSG_MAX		256
 
diff --git a/drivers/iommu/intel/cap_audit.c b/drivers/iommu/intel/cap_audit.c
index 71596fc62822..3ee68393122f 100644
--- a/drivers/iommu/intel/cap_audit.c
+++ b/drivers/iommu/intel/cap_audit.c
@@ -10,7 +10,7 @@
 
 #define pr_fmt(fmt)	"DMAR: " fmt
 
-#include <linux/intel-iommu.h>
+#include "iommu.h"
 #include "cap_audit.h"
 
 static u64 intel_iommu_cap_sanity;
diff --git a/drivers/iommu/intel/debugfs.c b/drivers/iommu/intel/debugfs.c
index ed796eea4581..d927ef10641b 100644
--- a/drivers/iommu/intel/debugfs.c
+++ b/drivers/iommu/intel/debugfs.c
@@ -10,11 +10,11 @@
 
 #include <linux/debugfs.h>
 #include <linux/dmar.h>
-#include <linux/intel-iommu.h>
 #include <linux/pci.h>
 
 #include <asm/irq_remapping.h>
 
+#include "iommu.h"
 #include "pasid.h"
 #include "perf.h"
 
diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index b02d72097a8c..059af0ef2a9d 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -19,7 +19,6 @@
 #include <linux/pci.h>
 #include <linux/dmar.h>
 #include <linux/iova.h>
-#include <linux/intel-iommu.h>
 #include <linux/timer.h>
 #include <linux/irq.h>
 #include <linux/interrupt.h>
@@ -32,6 +31,7 @@
 #include <asm/irq_remapping.h>
 #include <asm/iommu_table.h>
 
+#include "iommu.h"
 #include "../irq_remapping.h"
 #include "perf.h"
 #include "trace.h"
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index ea1c3bcd38d5..1af4b6562266 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -17,7 +17,6 @@
 #include <linux/dma-direct.h>
 #include <linux/dma-iommu.h>
 #include <linux/dmi.h>
-#include <linux/intel-iommu.h>
 #include <linux/intel-svm.h>
 #include <linux/memory.h>
 #include <linux/pci.h>
@@ -26,6 +25,7 @@
 #include <linux/syscore_ops.h>
 #include <linux/tboot.h>
 
+#include "iommu.h"
 #include "../irq_remapping.h"
 #include "../iommu-sva-lib.h"
 #include "pasid.h"
diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
index a67319597884..2e9683e970f8 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -10,7 +10,6 @@
 #include <linux/hpet.h>
 #include <linux/pci.h>
 #include <linux/irq.h>
-#include <linux/intel-iommu.h>
 #include <linux/acpi.h>
 #include <linux/irqdomain.h>
 #include <linux/crash_dump.h>
@@ -21,6 +20,7 @@
 #include <asm/irq_remapping.h>
 #include <asm/pci-direct.h>
 
+#include "iommu.h"
 #include "../irq_remapping.h"
 #include "cap_audit.h"
 
diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index cb4c1d0cf25c..b2ac5869286f 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -12,13 +12,13 @@
 #include <linux/bitops.h>
 #include <linux/cpufeature.h>
 #include <linux/dmar.h>
-#include <linux/intel-iommu.h>
 #include <linux/iommu.h>
 #include <linux/memory.h>
 #include <linux/pci.h>
 #include <linux/pci-ats.h>
 #include <linux/spinlock.h>
 
+#include "iommu.h"
 #include "pasid.h"
 
 /*
diff --git a/drivers/iommu/intel/perf.c b/drivers/iommu/intel/perf.c
index 0e8e03252d92..94ee70ac38e3 100644
--- a/drivers/iommu/intel/perf.c
+++ b/drivers/iommu/intel/perf.c
@@ -9,8 +9,8 @@
  */
 
 #include <linux/spinlock.h>
-#include <linux/intel-iommu.h>
 
+#include "iommu.h"
 #include "perf.h"
 
 static DEFINE_SPINLOCK(latency_lock);
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 70b40d007a52..580713aa9e07 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -5,7 +5,6 @@
  * Authors: David Woodhouse <dwmw2@infradead.org>
  */
 
-#include <linux/intel-iommu.h>
 #include <linux/mmu_notifier.h>
 #include <linux/sched.h>
 #include <linux/sched/mm.h>
@@ -22,6 +21,7 @@
 #include <asm/page.h>
 #include <asm/fpu/api.h>
 
+#include "iommu.h"
 #include "pasid.h"
 #include "perf.h"
 #include "../iommu-sva-lib.h"
diff --git a/MAINTAINERS b/MAINTAINERS
index a2095c832d84..81458c7f9a32 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9870,7 +9870,6 @@ L:	iommu@lists.linux-foundation.org
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
 F:	drivers/iommu/intel/
-F:	include/linux/intel-iommu.h
 F:	include/linux/intel-svm.h
 
 INTEL IOP-ADMA DMA DRIVER
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
