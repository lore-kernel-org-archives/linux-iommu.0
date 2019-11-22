Return-Path: <SRS0=Z7Xn=ZO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6748BC432C3
	for <iommu@archiver.kernel.org>; Fri, 22 Nov 2019 10:51:12 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DF2D2075B
	for <iommu@archiver.kernel.org>; Fri, 22 Nov 2019 10:51:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SOMWRl5M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DF2D2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 13BE5261B4;
	Fri, 22 Nov 2019 10:51:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bUtpp4uEE20i; Fri, 22 Nov 2019 10:51:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 7B9FA261AF;
	Fri, 22 Nov 2019 10:51:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 69621C1DD8;
	Fri, 22 Nov 2019 10:51:10 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 800B6C18DA
 for <iommu@lists.linux-foundation.org>; Fri, 22 Nov 2019 10:51:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 6D2FA261BE
 for <iommu@lists.linux-foundation.org>; Fri, 22 Nov 2019 10:51:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id m4d-x6DLKFcf for <iommu@lists.linux-foundation.org>;
 Fri, 22 Nov 2019 10:51:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com
 [209.85.128.67])
 by silver.osuosl.org (Postfix) with ESMTPS id 0112C260A3
 for <iommu@lists.linux-foundation.org>; Fri, 22 Nov 2019 10:51:06 +0000 (UTC)
Received: by mail-wm1-f67.google.com with SMTP id z19so7061630wmk.3
 for <iommu@lists.linux-foundation.org>; Fri, 22 Nov 2019 02:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=X6qGp2c7p8L2l1s7Du/UosUTRGtm9jAQFCi+oOptldg=;
 b=SOMWRl5MASeOm4GNtX9OArMbaILwLPRIzg8o5jQFJjlDJs7o7+6TRqRDRJJlcZKv1S
 C2wRUga0S929l8ZmubuZMrj4IpG5Fa2Nqe1Nopf/OfaG7JXzleQDTj1N8JFM+wM4dxkw
 a0IPZK9nsydiR7+ZaHFq8+zB4Kl+q/5r1Xtc5efWJGgpcICIwIevEVheIsqYwHeQbybW
 cC1h0KeLL/1CSa0gL5NCQZiIo97Dk5CcMapCj8Pt35ahMGhjHVVuLINva1JbNz3+Gk7f
 HvHGhikrvzqw3GWpjHonq28nTbE1JPkhrHfsEMIPgU0/NbAlKrRBh/66q3xFCw04rAqj
 UPvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=X6qGp2c7p8L2l1s7Du/UosUTRGtm9jAQFCi+oOptldg=;
 b=bC/jjO3JIFwfO4whxf4HpP5h+FGEZ7Pe6VOm2s0ajehKXHw8z/ch0S9YFp2/Jg6xgb
 EINw4ifvpKQp37AkD0vvRVEnLTySkyCiUwBO3xtrCJHmOoZRXO+5PLktUDBPul2cO5a0
 C/NBROWaCGzofzeCYyNkE0G4Khnfj5vUHmvCACf/9GlhoUG+SIawJnqGYrcTRyftcPGP
 0ag2ZniCuETJPGagNFwq2rmKaCkaMqKa4lRY7xEGcpRiTGFzQY3l7X1b3z45PcUEZmp0
 bp5RhD0k8fgL+y+PJP7KZF2CRydTIJwBmQFbuPhXnRFu1QlD8pmU/n7J7D89c0VBfs8A
 N+4Q==
X-Gm-Message-State: APjAAAXy51DP3Bf2iKPOt30HGdbgMTfzDMnItry0LycxZ3K8cHSeWWht
 WVeauoQhEoW9xR4f3pgbRjmQTw==
X-Google-Smtp-Source: APXvYqyUulc/cLM8hB09K3/hFqAi2tZ8CaZnvvhDeSgluvoZSIPS68UGsollQ+F3ni0gC6lT6Ek3Mw==
X-Received: by 2002:a1c:2d49:: with SMTP id t70mr15677618wmt.131.1574419865443; 
 Fri, 22 Nov 2019 02:51:05 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-204-106.adslplus.ch.
 [188.155.204.106])
 by smtp.gmail.com with ESMTPSA id o133sm2088197wmb.4.2019.11.22.02.51.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Nov 2019 02:51:05 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux-foundation.org,
 virtualization@lists.linux-foundation.org, linux-pci@vger.kernel.org,
 virtio-dev@lists.oasis-open.org
Subject: [RFC 11/13] ACPI: Add VIOT table
Date: Fri, 22 Nov 2019 11:49:58 +0100
Message-Id: <20191122105000.800410-12-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122105000.800410-1-jean-philippe@linaro.org>
References: <20191122105000.800410-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: kevin.tian@intel.com, mst@redhat.com, gregkh@linuxfoundation.org,
 sudeep.holla@arm.com, rjw@rjwysocki.net, sebastien.boeuf@intel.com,
 jacob.jun.pan@intel.com, guohanjun@huawei.com, bhelgaas@google.com,
 jasowang@redhat.com, lenb@kernel.org
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

Add support for a new ACPI table that embeds other tables describing a
platform's IOMMU topology. Currently the only supported base table is
IORT. The VIOT contains an IORT with additional node types, that
describe a virtio-iommu.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/acpi/Kconfig      |  4 ++++
 drivers/acpi/Makefile     |  1 +
 drivers/acpi/bus.c        |  2 ++
 drivers/acpi/tables.c     |  2 +-
 drivers/acpi/viot.c       | 44 +++++++++++++++++++++++++++++++++++++++
 drivers/iommu/Kconfig     |  1 +
 include/linux/acpi_viot.h | 20 ++++++++++++++++++
 7 files changed, 73 insertions(+), 1 deletion(-)
 create mode 100644 drivers/acpi/viot.c
 create mode 100644 include/linux/acpi_viot.h

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 548976c8b2b0..513a5e4d3526 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -579,6 +579,10 @@ config TPS68470_PMIC_OPREGION
 config ACPI_IORT
 	bool
 
+config ACPI_VIOT
+	bool
+	select ACPI_IORT
+
 endif	# ACPI
 
 config X86_PM_TIMER
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 9d1792165713..6abdc6cc32c7 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -124,3 +124,4 @@ obj-y				+= dptf/
 
 obj-$(CONFIG_ARM64)		+= arm64/
 obj-$(CONFIG_ACPI_IORT) 	+= iort.o
+obj-$(CONFIG_ACPI_VIOT)		+= viot.o
diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 48bc96d45bab..6f364e0c9240 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -25,6 +25,7 @@
 #include <linux/dmi.h>
 #endif
 #include <linux/acpi_iort.h>
+#include <linux/acpi_viot.h>
 #include <linux/pci.h>
 #include <acpi/apei.h>
 #include <linux/suspend.h>
@@ -1246,6 +1247,7 @@ static int __init acpi_init(void)
 
 	pci_mmcfg_late_init();
 	acpi_iort_init();
+	acpi_viot_init();
 	acpi_scan_init();
 	acpi_ec_init();
 	acpi_debugfs_init();
diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 180ac4329763..9662ea5e1064 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -501,7 +501,7 @@ static const char * const table_sigs[] = {
 	ACPI_SIG_WDDT, ACPI_SIG_WDRT, ACPI_SIG_DSDT, ACPI_SIG_FADT,
 	ACPI_SIG_PSDT, ACPI_SIG_RSDT, ACPI_SIG_XSDT, ACPI_SIG_SSDT,
 	ACPI_SIG_IORT, ACPI_SIG_NFIT, ACPI_SIG_HMAT, ACPI_SIG_PPTT,
-	NULL };
+	ACPI_SIG_VIOT, NULL };
 
 #define ACPI_HEADER_SIZE sizeof(struct acpi_table_header)
 
diff --git a/drivers/acpi/viot.c b/drivers/acpi/viot.c
new file mode 100644
index 000000000000..ab9a6e43ad9b
--- /dev/null
+++ b/drivers/acpi/viot.c
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2019 Linaro
+ *
+ * Virtual IOMMU table
+ */
+#define pr_fmt(fmt)	"ACPI: VIOT: " fmt
+
+#include <linux/acpi.h>
+#include <linux/acpi_iort.h>
+#include <linux/acpi_viot.h>
+
+int __init acpi_viot_init(void)
+{
+	struct acpi_table_viot *viot;
+	struct acpi_table_header *acpi_header;
+	acpi_status status;
+
+	status = acpi_get_table(ACPI_SIG_VIOT, 0, &acpi_header);
+	if (ACPI_FAILURE(status)) {
+		if (status != AE_NOT_FOUND) {
+			const char *msg = acpi_format_exception(status);
+
+			pr_err("Failed to get table, %s\n", msg);
+			return -EINVAL;
+		}
+
+		return 0;
+	}
+
+	if (acpi_header->length < sizeof(*viot)) {
+		pr_err("VIOT table overflow, bad table!\n");
+		return -EINVAL;
+	}
+
+	viot = (struct acpi_table_viot *)acpi_header;
+	if (ACPI_COMPARE_NAMESEG(viot->base_table.signature, ACPI_SIG_IORT)) {
+		acpi_iort_register_table(&viot->base_table, IORT_SOURCE_VIOT);
+		return 0;
+	}
+
+	pr_err("Unknown base table header\n");
+	return -EINVAL;
+}
diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index e3842eabcfdd..e6eb4f238d1a 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -480,6 +480,7 @@ config VIRTIO_IOMMU
 	depends on ARM64
 	select IOMMU_API
 	select INTERVAL_TREE
+	select ACPI_VIOT if ACPI
 	help
 	  Para-virtualised IOMMU driver with virtio.
 
diff --git a/include/linux/acpi_viot.h b/include/linux/acpi_viot.h
new file mode 100644
index 000000000000..6c282d5eb793
--- /dev/null
+++ b/include/linux/acpi_viot.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2019 Linaro
+ */
+
+#ifndef __ACPI_VIOT_H__
+#define __ACPI_VIOT_H__
+
+#ifdef CONFIG_ACPI_VIOT
+
+int acpi_viot_init(void);
+
+#else /* !CONFIG_ACPI_VIOT */
+
+static inline int acpi_viot_init(void)
+{}
+
+#endif /* !CONFIG_ACPI_VIOT */
+
+#endif /* __ACPI_VIOT_H__ */
-- 
2.24.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
