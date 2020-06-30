Return-Path: <SRS0=0Jez=AL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38581C433DF
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 22:47:12 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 095772073E
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 22:47:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="jyT4MFkt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 095772073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id CFA2A887ED;
	Tue, 30 Jun 2020 22:47:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id szqQDhFP6BjT; Tue, 30 Jun 2020 22:47:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id ABFC2887D4;
	Tue, 30 Jun 2020 22:47:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 99F74C08A6;
	Tue, 30 Jun 2020 22:47:10 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9C677C016E
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 22:47:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 9736288725
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 22:47:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Hj+lId8GiFHQ for <iommu@lists.linux-foundation.org>;
 Tue, 30 Jun 2020 22:47:06 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com
 [207.171.184.29])
 by whitealder.osuosl.org (Postfix) with ESMTPS id AC39A886E9
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 22:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
 t=1593557227; x=1625093227;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version;
 bh=+IEiFiSreY+HvcWSmq5CAxY/qr5JM0FGcYoy839j2m4=;
 b=jyT4MFkt91H1/Qi9AWXqOubqylV1uDRR9RbbEvoGOoxq9S+vu3g00eRp
 KoV+KxG3iAjF/Sye6EQaFa94PQ8C28VkaXOYXj539HHcm4CIZViLGuTpv
 dTxTkXN6YAGGPQBENTS9kwjkunC1kepADqK/a/4g1fyACaZKU37FP7enN M=;
IronPort-SDR: Nw9DsTVzgKaGCANCxqrs4O82Zy4/tdvMFYfNnVewSWbV38SHngBswBQX52A8tK5MVmlgJSJnUD
 3ddhtnFkwR9w==
X-IronPort-AV: E=Sophos;i="5.75,298,1589241600"; d="scan'208";a="56429127"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO
 email-inbound-relay-2b-a7fdc47a.us-west-2.amazon.com) ([10.47.23.38])
 by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP;
 30 Jun 2020 22:47:06 +0000
Received: from EX13MTAUWA001.ant.amazon.com
 (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
 by email-inbound-relay-2b-a7fdc47a.us-west-2.amazon.com (Postfix) with ESMTPS
 id C0D00C0704; Tue, 30 Jun 2020 22:47:05 +0000 (UTC)
Received: from EX13D29UWA001.ant.amazon.com (10.43.160.187) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.58) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 30 Jun 2020 22:47:05 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX13D29UWA001.ant.amazon.com (10.43.160.187) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 30 Jun 2020 22:47:04 +0000
Received: from uc7682112f22859.ant.amazon.com (10.1.213.20) by
 mail-relay.amazon.com (10.43.160.118) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Tue, 30 Jun 2020 22:47:03 +0000
To: Joerg Roedel <joro@8bytes.org>, <iommu@lists.linux-foundation.org>
Subject: [PATCH v2 1/3] iommu/amd: Parse supported address sizes from IVRS
Date: Wed, 1 Jul 2020 00:46:32 +0200
Message-ID: <20200630224634.319-2-sebott@amazon.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200630224634.319-1-sebott@amazon.de>
References: <20200630093039.GC28824@8bytes.org>
 <20200630224634.319-1-sebott@amazon.de>
MIME-Version: 1.0
Cc: Benjamin Serebrin <serebrin@amazon.com>, Filippo Sironi <sironi@amazon.de>,
 Sebastian Ott <sebott@amazon.de>
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
From: Sebastian Ott via iommu <iommu@lists.linux-foundation.org>
Reply-To: Sebastian Ott <sebott@amazon.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

The IVRS ACPI table specifies maximum address sizes for i/o virtual
addresses that can be handled by the IOMMUs in the system.  Parse that
data from the IVRS header so that it can be considered in limiting the
IO aperture (in subsequent patches).

Based on prior work by Marius Hillenbrand.

Link: https://www.amd.com/system/files/TechDocs/48882_IOMMU_3.05_PUB.pdf

Signed-off-by: Sebastian Ott <sebott@amazon.de>
Cc: Benjamin Serebrin <serebrin@amazon.com>
Cc: Filippo Sironi <sironi@amazon.de>

CR: https://code.amazon.com/reviews/CR-26408321
---
 drivers/iommu/amd/amd_iommu_types.h |  3 +++
 drivers/iommu/amd/init.c            | 26 ++++++++++++++++++++++++++
 drivers/iommu/amd/iommu.c           |  1 +
 3 files changed, 30 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 30a5d412255a..0946638306d6 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -754,6 +754,9 @@ extern bool amd_iommu_force_isolation;
 /* Max levels of glxval supported */
 extern int amd_iommu_max_glx_val;
 
+/* Maximum virtual address supported */
+extern u64 amd_iommu_max_va;
+
 /*
  * This function flushes all internal caches of
  * the IOMMU used by this driver.
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 6ebd4825e320..ab9d226b4215 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -11,6 +11,7 @@
 #include <linux/pci.h>
 #include <linux/acpi.h>
 #include <linux/list.h>
+#include <linux/bitfield.h>
 #include <linux/bitmap.h>
 #include <linux/slab.h>
 #include <linux/syscore_ops.h>
@@ -39,6 +40,7 @@
  * definitions for the ACPI scanning code
  */
 #define IVRS_HEADER_LENGTH 48
+#define IVRS_HEADER_IVINFO_OFFSET 36
 
 #define ACPI_IVHD_TYPE_MAX_SUPPORTED	0x40
 #define ACPI_IVMD_TYPE_ALL              0x20
@@ -2490,6 +2492,27 @@ static void __init free_dma_resources(void)
 	free_unity_maps();
 }
 
+static void __init get_ivrs_ivinfo(struct acpi_table_header *ivrs)
+{
+	u32 *ivinfo = (u32 *)((u8 *)ivrs + IVRS_HEADER_IVINFO_OFFSET);
+	u8 va_size = FIELD_GET(GENMASK(21, 15), *ivinfo);
+	u8 valid_va_sizes[] = {32, 40, 48, 64};
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(valid_va_sizes); i++) {
+		if (va_size == valid_va_sizes[i]) {
+			amd_iommu_max_va = DMA_BIT_MASK(va_size);
+			break;
+		}
+	}
+
+	if (!amd_iommu_max_va) {
+		pr_warn("Invalid virtual address size %u in IVRS header, use most restrictive %u\n",
+			va_size, valid_va_sizes[0]);
+		amd_iommu_max_va = DMA_BIT_MASK(valid_va_sizes[0]);
+	}
+}
+
 /*
  * This is the hardware init function for AMD IOMMU in the system.
  * This function is called either from amd_iommu_init or from the interrupt
@@ -2544,6 +2567,9 @@ static int __init early_amd_iommu_init(void)
 	if (ret)
 		goto out;
 
+	get_ivrs_ivinfo(ivrs_base);
+	DUMP_printk("IVRS vasize=%llx\n", amd_iommu_max_va);
+
 	amd_iommu_target_ivhd_type = get_highest_supported_ivhd_type(ivrs_base);
 	DUMP_printk("Using IVHD type %#x\n", amd_iommu_target_ivhd_type);
 
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 74cca1757172..acab35220d98 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -88,6 +88,7 @@ const struct iommu_ops amd_iommu_ops;
 
 static ATOMIC_NOTIFIER_HEAD(ppr_notifier);
 int amd_iommu_max_glx_val = -1;
+u64 amd_iommu_max_va;
 
 /*
  * general struct to manage commands send to an IOMMU
-- 
2.17.1




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
