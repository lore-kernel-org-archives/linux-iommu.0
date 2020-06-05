Return-Path: <SRS0=1g3H=7S=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7AD2C433E1
	for <iommu@archiver.kernel.org>; Fri,  5 Jun 2020 18:00:38 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD12D206FA
	for <iommu@archiver.kernel.org>; Fri,  5 Jun 2020 18:00:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="FRxuYIjm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD12D206FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2C7BF889AF;
	Fri,  5 Jun 2020 18:00:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id he52tJ4I0iX2; Fri,  5 Jun 2020 18:00:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 06FCF88CBB;
	Fri,  5 Jun 2020 18:00:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D3AF9C0892;
	Fri,  5 Jun 2020 18:00:36 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 83499C016E
 for <iommu@lists.linux-foundation.org>; Fri,  5 Jun 2020 14:57:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 731C888D81
 for <iommu@lists.linux-foundation.org>; Fri,  5 Jun 2020 14:57:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IKwLywhQ6I5D for <iommu@lists.linux-foundation.org>;
 Fri,  5 Jun 2020 14:57:09 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com
 [207.171.190.10])
 by hemlock.osuosl.org (Postfix) with ESMTPS id AA63688CBB
 for <iommu@lists.linux-foundation.org>; Fri,  5 Jun 2020 14:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
 t=1591369030; x=1622905030;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version;
 bh=UPrbcyUInt7PKI6jtTi6fbDxIlhjWWiO//hV802ls+M=;
 b=FRxuYIjmg6AaZxf65MnVfVvotgxAFsgavt5tZiXJPXpKMa7gzLba7vST
 Hurn6eusm7r3zzIB9pbkGgBvjeneubps6/VXRDGYUNsw7mB8xmhpsQLRK
 KNlfq+0zGtTDVeAKY/AANHWFkw+YeqRwgk654GWslDqMXnsaAvWG5CgDz M=;
IronPort-SDR: QC9bIxdPIjVxlG/jkRxZL1eUtjcZyrvKH9Io7GO/agljYBDhQZp2OuNqzKOuv99iqPegJPWKhV
 eQvk1oJ2GBPg==
X-IronPort-AV: E=Sophos;i="5.73,476,1583193600"; d="scan'208";a="48774256"
Received: from sea32-co-svc-lb4-vlan2.sea.corp.amazon.com (HELO
 email-inbound-relay-2c-6f38efd9.us-west-2.amazon.com) ([10.47.23.34])
 by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP;
 05 Jun 2020 14:57:05 +0000
Received: from EX13MTAUWA001.ant.amazon.com
 (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
 by email-inbound-relay-2c-6f38efd9.us-west-2.amazon.com (Postfix) with ESMTPS
 id E17FBA2065; Fri,  5 Jun 2020 14:57:04 +0000 (UTC)
Received: from EX13D29UWA002.ant.amazon.com (10.43.160.63) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.58) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 5 Jun 2020 14:57:04 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D29UWA002.ant.amazon.com (10.43.160.63) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 5 Jun 2020 14:57:03 +0000
Received: from uc7682112f22859.ant.amazon.com (10.1.213.30) by
 mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Fri, 5 Jun 2020 14:57:02 +0000
To: Joerg Roedel <joro@8bytes.org>, <iommu@lists.linux-foundation.org>
Subject: [PATCH 1/3] iommu/amd: Parse supported address sizes from IVRS
Date: Fri, 5 Jun 2020 16:56:53 +0200
Message-ID: <20200605145655.13639-2-sebott@amazon.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200605145655.13639-1-sebott@amazon.de>
References: <20200605145655.13639-1-sebott@amazon.de>
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 05 Jun 2020 18:00:35 +0000
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

The IVRS ACPI table specifies maximum address sizes for I/O virtual
addresses that can be handled by the IOMMUs in the system. Parse that
data from the IVRS header so that it can be considered in limiting the
I/O aperture.

Based on prior work by Marius Hillenbrand.

Link: https://www.amd.com/system/files/TechDocs/48882_IOMMU_3.05_PUB.pdf

Signed-off-by: Sebastian Ott <sebott@amazon.de>
---
 drivers/iommu/amd_iommu.c       |  1 +
 drivers/iommu/amd_iommu_init.c  | 26 ++++++++++++++++++++++++++
 drivers/iommu/amd_iommu_types.h |  3 +++
 3 files changed, 30 insertions(+)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 2883ac389abb..fb4a44550c4a 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -88,6 +88,7 @@ const struct iommu_ops amd_iommu_ops;
 
 static ATOMIC_NOTIFIER_HEAD(ppr_notifier);
 int amd_iommu_max_glx_val = -1;
+u8 amd_iommu_ivrs_va_size;
 
 /*
  * general struct to manage commands send to an IOMMU
diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 5b81fd16f5fa..3b07218e7000 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -11,6 +11,7 @@
 #include <linux/pci.h>
 #include <linux/acpi.h>
 #include <linux/list.h>
+#include <linux/bitfield.h>
 #include <linux/bitmap.h>
 #include <linux/slab.h>
 #include <linux/syscore_ops.h>
@@ -41,6 +42,7 @@
  * definitions for the ACPI scanning code
  */
 #define IVRS_HEADER_LENGTH 48
+#define IVRS_HEADER_IVINFO_OFFSET 36
 
 #define ACPI_IVHD_TYPE_MAX_SUPPORTED	0x40
 #define ACPI_IVMD_TYPE_ALL              0x20
@@ -2492,6 +2494,27 @@ static void __init free_dma_resources(void)
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
+			amd_iommu_ivrs_va_size = va_size;
+			break;
+		}
+	}
+
+	if (!amd_iommu_ivrs_va_size) {
+		pr_warn("Invalid virtual address size %u in IVRS header, use most restrictive %u\n",
+			va_size, valid_va_sizes[0]);
+		amd_iommu_ivrs_va_size = valid_va_sizes[0];
+	}
+}
+
 /*
  * This is the hardware init function for AMD IOMMU in the system.
  * This function is called either from amd_iommu_init or from the interrupt
@@ -2546,6 +2569,9 @@ static int __init early_amd_iommu_init(void)
 	if (ret)
 		goto out;
 
+	get_ivrs_ivinfo(ivrs_base);
+	DUMP_printk("IVRS vasize=%d\n", amd_iommu_ivrs_va_size);
+
 	amd_iommu_target_ivhd_type = get_highest_supported_ivhd_type(ivrs_base);
 	DUMP_printk("Using IVHD type %#x\n", amd_iommu_target_ivhd_type);
 
diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
index 7a8fdec138bd..8141b2874170 100644
--- a/drivers/iommu/amd_iommu_types.h
+++ b/drivers/iommu/amd_iommu_types.h
@@ -755,6 +755,9 @@ extern bool amd_iommu_force_isolation;
 /* Max levels of glxval supported */
 extern int amd_iommu_max_glx_val;
 
+/* Maximum virtual address size supported */
+extern u8 amd_iommu_ivrs_va_size;
+
 /*
  * This function flushes all internal caches of
  * the IOMMU used by this driver.
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
