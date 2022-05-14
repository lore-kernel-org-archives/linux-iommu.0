Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A5F9C433F5
	for <iommu@archiver.kernel.org>; Sat, 14 May 2022 01:46:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 13C61600C4;
	Sat, 14 May 2022 01:46:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HuVyqVG7U4nJ; Sat, 14 May 2022 01:46:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D6B03600B5;
	Sat, 14 May 2022 01:46:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B2765C0032;
	Sat, 14 May 2022 01:46:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3AAECC002D
 for <iommu@lists.linux-foundation.org>; Sat, 14 May 2022 01:46:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1A9B4404AA
 for <iommu@lists.linux-foundation.org>; Sat, 14 May 2022 01:46:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dJ2dgTM-ziVm for <iommu@lists.linux-foundation.org>;
 Sat, 14 May 2022 01:46:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6B08A400AF
 for <iommu@lists.linux-foundation.org>; Sat, 14 May 2022 01:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1652492805; x=1684028805;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=VEv3FSPSgIXzTD6OswoTPktFlXlfBLKoUGoPMD7VvYY=;
 b=lzpJonMORXZkqJCKnw0ppc5kcIkp8kbVfDW2BHYAOZziBjtxTfBq4MYe
 Ep/tpGKDw8H7aioccWBfaUfd+J9mDGvrOpC9Paear5/IzNmvoA/QJaMsb
 kGPsKcXCF/E9y0EnfeCAlMR/F0aYgggEXvq8rFa5dgQypnhlhTKv78+FG
 4sVR6v6Smj13uvGoolEo/qHJVg3VmELWSJTaUqWexQGczlUAwYP2ChrnO
 VKcabIdL8rBBDkHiS1BOLO7O+x4MlccFQ33kPD0/wBY/dsS+3WgxRjfJN
 jAxhXgMowJQf9xR+4yNAQ+6IFFHjBQAs6ILoW/b54Y4A4+dn3+99VHwaN w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10346"; a="270387994"
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; d="scan'208";a="270387994"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 May 2022 18:46:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; d="scan'208";a="712630770"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by fmsmga001.fm.intel.com with ESMTP; 13 May 2022 18:46:36 -0700
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
Subject: [PATCH 1/7] iommu/vt-d: Move trace/events/intel_iommu.h under iommu
Date: Sat, 14 May 2022 09:43:16 +0800
Message-Id: <20220514014322.2927339-2-baolu.lu@linux.intel.com>
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
 .../trace/events/intel_iommu.h => drivers/iommu/intel/trace.h | 4 ++++
 drivers/iommu/intel/dmar.c                                    | 2 +-
 drivers/iommu/intel/svm.c                                     | 2 +-
 drivers/iommu/intel/trace.c                                   | 2 +-
 4 files changed, 7 insertions(+), 3 deletions(-)
 rename include/trace/events/intel_iommu.h => drivers/iommu/intel/trace.h (94%)

diff --git a/include/trace/events/intel_iommu.h b/drivers/iommu/intel/trace.h
similarity index 94%
rename from include/trace/events/intel_iommu.h
rename to drivers/iommu/intel/trace.h
index e5c1ca6d16ee..25cb7f88e1a2 100644
--- a/include/trace/events/intel_iommu.h
+++ b/drivers/iommu/intel/trace.h
@@ -91,4 +91,8 @@ TRACE_EVENT(prq_report,
 #endif /* _TRACE_INTEL_IOMMU_H */
 
 /* This part must be outside protection */
+#undef TRACE_INCLUDE_PATH
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_PATH ../../drivers/iommu/intel/
+#define TRACE_INCLUDE_FILE trace
 #include <trace/define_trace.h>
diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 4de960834a1b..b02d72097a8c 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -31,10 +31,10 @@
 #include <linux/limits.h>
 #include <asm/irq_remapping.h>
 #include <asm/iommu_table.h>
-#include <trace/events/intel_iommu.h>
 
 #include "../irq_remapping.h"
 #include "perf.h"
+#include "trace.h"
 
 typedef int (*dmar_res_handler_t)(struct acpi_dmar_header *, void *);
 struct dmar_res_callback {
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 7ee37d996e15..70b40d007a52 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -21,11 +21,11 @@
 #include <linux/ioasid.h>
 #include <asm/page.h>
 #include <asm/fpu/api.h>
-#include <trace/events/intel_iommu.h>
 
 #include "pasid.h"
 #include "perf.h"
 #include "../iommu-sva-lib.h"
+#include "trace.h"
 
 static irqreturn_t prq_event_thread(int irq, void *d);
 static void intel_svm_drain_prq(struct device *dev, u32 pasid);
diff --git a/drivers/iommu/intel/trace.c b/drivers/iommu/intel/trace.c
index bfb6a6e37a88..117e626e3ea9 100644
--- a/drivers/iommu/intel/trace.c
+++ b/drivers/iommu/intel/trace.c
@@ -11,4 +11,4 @@
 #include <linux/types.h>
 
 #define CREATE_TRACE_POINTS
-#include <trace/events/intel_iommu.h>
+#include "trace.h"
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
