Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59C42C433EF
	for <iommu@archiver.kernel.org>; Sat, 14 May 2022 01:47:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 21CDD401B0;
	Sat, 14 May 2022 01:47:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gDcb51nSAOOe; Sat, 14 May 2022 01:47:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id CFEAA4018B;
	Sat, 14 May 2022 01:47:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A9C49C0032;
	Sat, 14 May 2022 01:47:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A9F32C002D
 for <iommu@lists.linux-foundation.org>; Sat, 14 May 2022 01:47:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A7A0A828B5
 for <iommu@lists.linux-foundation.org>; Sat, 14 May 2022 01:47:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4XV5cSEsq2d0 for <iommu@lists.linux-foundation.org>;
 Sat, 14 May 2022 01:47:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F41CA82611
 for <iommu@lists.linux-foundation.org>; Sat, 14 May 2022 01:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1652492829; x=1684028829;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=v3kPt++FiQ9ARnwZa6X+VCG2cZHcHXHj7nyunngZA8s=;
 b=gVV2fmw7+XSUAA+RPpZUTwqXiqCfx28egKZIWy7WX+aHtqrVHLBEzeI1
 G7EPLf8BWZsvND16aNehslH7+rD9UKVtasrK4YoKqlIhY9KzkfmKo3NZg
 pF9dtFcte8QINLbobVbDqdBAv6a4EB+nXYghThwEbLJq5Hcses+aKgvjy
 Pz2kISGI8Hctj4XCiAfiNxo0YlhMnM3K/aXrMpLOHlGHFDzuIjvbuJTF1
 UnuilzoQks66zT1WSow783wEpIkqgLfnCjU02iK7czBKOcy7oYTfTPfoO
 ByhdmSJcehXCHo4zvBzyU9QKVG5O1fndmWGxPisOAShReD2VypTNk21Cy Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10346"; a="270581960"
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; d="scan'208";a="270581960"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 May 2022 18:47:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; d="scan'208";a="712630826"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by fmsmga001.fm.intel.com with ESMTP; 13 May 2022 18:47:04 -0700
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
Subject: [PATCH 6/7] x86/boot/tboot: Move tboot_force_iommu() to Intel IOMMU
Date: Sat, 14 May 2022 09:43:21 +0800
Message-Id: <20220514014322.2927339-7-baolu.lu@linux.intel.com>
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

tboot_force_iommu() is only called by the Intel IOMMU driver. Move the
helper into that driver. No functional change intended.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/tboot.h       |  2 --
 arch/x86/kernel/tboot.c     | 15 ---------------
 drivers/iommu/intel/iommu.c | 14 ++++++++++++++
 3 files changed, 14 insertions(+), 17 deletions(-)

diff --git a/include/linux/tboot.h b/include/linux/tboot.h
index 5146d2574e85..d2279160ef39 100644
--- a/include/linux/tboot.h
+++ b/include/linux/tboot.h
@@ -126,7 +126,6 @@ extern void tboot_probe(void);
 extern void tboot_shutdown(u32 shutdown_type);
 extern struct acpi_table_header *tboot_get_dmar_table(
 				      struct acpi_table_header *dmar_tbl);
-extern int tboot_force_iommu(void);
 
 #else
 
@@ -136,7 +135,6 @@ extern int tboot_force_iommu(void);
 #define tboot_sleep(sleep_state, pm1a_control, pm1b_control)	\
 					do { } while (0)
 #define tboot_get_dmar_table(dmar_tbl)	(dmar_tbl)
-#define tboot_force_iommu()		0
 
 #endif /* !CONFIG_INTEL_TXT */
 
diff --git a/arch/x86/kernel/tboot.c b/arch/x86/kernel/tboot.c
index f9af561c3cd4..6eb9c4146f17 100644
--- a/arch/x86/kernel/tboot.c
+++ b/arch/x86/kernel/tboot.c
@@ -6,7 +6,6 @@
  * Copyright (c) 2006-2009, Intel Corporation
  */
 
-#include <linux/intel-iommu.h>
 #include <linux/init_task.h>
 #include <linux/spinlock.h>
 #include <linux/export.h>
@@ -517,17 +516,3 @@ struct acpi_table_header *tboot_get_dmar_table(struct acpi_table_header *dmar_tb
 
 	return dmar_tbl;
 }
-
-int tboot_force_iommu(void)
-{
-	if (!tboot_enabled())
-		return 0;
-
-	if (no_iommu || dmar_disabled)
-		pr_warn("Forcing Intel-IOMMU to enabled\n");
-
-	dmar_disabled = 0;
-	no_iommu = 0;
-
-	return 1;
-}
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 744af407d0da..ea1c3bcd38d5 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4043,6 +4043,20 @@ static int __init probe_acpi_namespace_devices(void)
 	return 0;
 }
 
+static __init int tboot_force_iommu(void)
+{
+	if (!tboot_enabled())
+		return 0;
+
+	if (no_iommu || dmar_disabled)
+		pr_warn("Forcing Intel-IOMMU to enabled\n");
+
+	dmar_disabled = 0;
+	no_iommu = 0;
+
+	return 1;
+}
+
 int __init intel_iommu_init(void)
 {
 	int ret = -ENODEV;
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
