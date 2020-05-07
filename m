Return-Path: <SRS0=32yV=6V=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F39C47257
	for <iommu@archiver.kernel.org>; Thu,  7 May 2020 16:40:13 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D046215A4
	for <iommu@archiver.kernel.org>; Thu,  7 May 2020 16:40:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="exrcyj3R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D046215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2694088A29;
	Thu,  7 May 2020 16:40:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qyvbK3WCmqgP; Thu,  7 May 2020 16:40:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8EA1F88A2D;
	Thu,  7 May 2020 16:40:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7C986C0865;
	Thu,  7 May 2020 16:40:12 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1EE78C07FF
 for <iommu@lists.linux-foundation.org>; Thu,  7 May 2020 16:40:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 0E82F862A5
 for <iommu@lists.linux-foundation.org>; Thu,  7 May 2020 16:40:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PChwsrMqqH2a for <iommu@lists.linux-foundation.org>;
 Thu,  7 May 2020 16:40:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
 [209.85.221.65])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 10E3E87209
 for <iommu@lists.linux-foundation.org>; Thu,  7 May 2020 16:40:10 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id w7so6356778wre.13
 for <iommu@lists.linux-foundation.org>; Thu, 07 May 2020 09:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:date:user-agent:mime-version
 :content-transfer-encoding;
 bh=E1ZxG0JPCuLf4scW0nrRzMw3Gn0AUm6ynAm1NyY3Ers=;
 b=exrcyj3RwvbklSIdAcmJ4tPgieTFGYnxWBmqGyiODMZio65fJobnLVFU9fLY9LC+7k
 1NBdUNjr8Ekfm9GdlC8Oic+tFLZRxktZoHlhU/kl6izoQThw+wqvsGuzMSw1CzSX+C2B
 3NFBtvgtIwDagM+x6jYxBwe3/lKKpl0yg4QqhPn9NP0ain70fv1rsha3JCnFxvF8segI
 256nSWLHhC179oAjMvVXWsFgvkbKjxygAHTzWeXMERMT4EwZYbd1Mxt6IQSJcpNyxLLE
 UtijWIAHiDZZoC8KbeQUa0r8yyn1fuWD2xKQAsBdKoV+mgh33n+36hORqmhk79DfwlYc
 +Gvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:date:user-agent
 :mime-version:content-transfer-encoding;
 bh=E1ZxG0JPCuLf4scW0nrRzMw3Gn0AUm6ynAm1NyY3Ers=;
 b=l1drl9jrafgryGDIcKsc/Q1mhZ/oUUklQwD5OmTKErMXOZE8sIwNCFExO6pMEjGy1V
 4BJEBFm72ek0i9Tw8MMdWCsmnB7IS1P42VZzA3cNz1XzpZVgP8nHoduZC5gtIQOEAb6B
 /A1dhfKOG8FNx1/yYp8WJDlLqxxCKysq4Nw9eOUJ1NiD583clbSPm0Stz3oxc4Ph/ePx
 R4/+5xQj4/oXnpXzH6kT06D2wxTqYN9KLWTwGEUXvr/sEYIDpCSOtBOPVvH7ymAv+tPp
 ZwKnM46Da2LKmBwPTzwwDcDwPcz3F8XnfIjmQ0tMAbxBICKibjVVYU5N+fjFzAU3EAmI
 oFRw==
X-Gm-Message-State: AGi0Puaw6zblefOqW6XDmekRqcbpqwJLE4MgDBQB5ZwTWM6W7oSFjia+
 Dyb0lWSvkHH6iv9MV6pmhb+1HqUh/Ag=
X-Google-Smtp-Source: APiQypK7nHMzwkADO63/ULZK378UnLVM997I46thakDuOhZ3ulQvUvlqJka9qGMOicv7JLWOnGOZsg==
X-Received: by 2002:adf:f1c3:: with SMTP id z3mr6588656wro.201.1588869607953; 
 Thu, 07 May 2020 09:40:07 -0700 (PDT)
Received: from localhost.localdomain ([62.31.71.236])
 by smtp.gmail.com with ESMTPSA id t18sm5547084wrr.86.2020.05.07.09.40.07
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2020 09:40:07 -0700 (PDT)
Message-ID: <ab48d859dfb99fb746a628d74c1b76969929d81c.camel@gmail.com>
Subject: [PATCH] WIP: iommu: Export dmar_platform_optin() as a securityfs
 attribute
From: Richard Hughes <hughsient@gmail.com>
To: iommu@lists.linux-foundation.org
Date: Thu, 07 May 2020 17:40:06 +0100
User-Agent: Evolution 3.36.2 (3.36.2-1.fc32) 
MIME-Version: 1.0
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

Although we can get the same information from
/sys/bus/thunderbolt/devices/domainX/iommu_dma_protection, the
IP block on the SOC may be deactivated. That means that it would
not be exported even though pre boot DMA was enabled and available.

This patch is work in progress and is only supposed to spark
discussion. I'm new here, so please be gentle :)

Signed-off-by: Richard Hughes <richard@hughsie.com>
---
 drivers/iommu/Kconfig            | 10 ++++++
 drivers/iommu/Makefile           |  1 +
 drivers/iommu/iommu-securityfs.c | 55 ++++++++++++++++++++++++++++++++
 drivers/iommu/iommu.c            |  1 +
 include/linux/iommu.h            |  7 ++++
 5 files changed, 74 insertions(+)
 create mode 100644 drivers/iommu/iommu-securityfs.c

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 2ab07ce17abb..e31fa9a459d6 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -79,6 +79,16 @@ config IOMMU_DEBUGFS
 	  debug/iommu directory, and then populate a subdirectory with
 	  entries as required.
 
+config IOMMU_SECURITYFS
+	bool "Export IOMMU attributes in SecurityFS"
+	depends on SECURITY
+	help
+	  Allows exposure of IOMMU security attributes. Devices can,
+	  at initialization time, cause the IOMMU code to create a top-
level
+	  security/iommu directory, and then populate entries as
required.
+
+	  If unsure, say N here.
+
 config IOMMU_DEFAULT_PASSTHROUGH
 	bool "IOMMU passthrough by default"
 	depends on IOMMU_API
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 9f33fdb3bb05..f6c9c07b86b6 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -3,6 +3,7 @@ obj-$(CONFIG_IOMMU_API) += iommu.o
 obj-$(CONFIG_IOMMU_API) += iommu-traces.o
 obj-$(CONFIG_IOMMU_API) += iommu-sysfs.o
 obj-$(CONFIG_IOMMU_DEBUGFS) += iommu-debugfs.o
+obj-$(CONFIG_IOMMU_SECURITYFS) += iommu-securityfs.o
 obj-$(CONFIG_IOMMU_DMA) += dma-iommu.o
 obj-$(CONFIG_IOMMU_IO_PGTABLE) += io-pgtable.o
 obj-$(CONFIG_IOMMU_IO_PGTABLE_ARMV7S) += io-pgtable-arm-v7s.o
diff --git a/drivers/iommu/iommu-securityfs.c b/drivers/iommu/iommu-
securityfs.c
new file mode 100644
index 000000000000..71210c56311a
--- /dev/null
+++ b/drivers/iommu/iommu-securityfs.c
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * IOMMU security interface
+ *
+ * Copyright 2020 (c) Richard Hughes (richard@hughsie.com)
+ */
+
+#include <linux/pci.h>
+#include <linux/iommu.h>
+#include <linux/security.h>
+#include <linux/dmar.h>
+
+struct dentry *iommu_securityfs_dir;
+EXPORT_SYMBOL_GPL(iommu_securityfs_dir);
+
+struct dentry *iommu_dmar_enabled;
+
+static ssize_t iommu_dmar_enabled_read(struct file *filp,
+				       char __user *buf,
+				       size_t count,
+				       loff_t *ppos)
+{
+	char tmp[2];
+
+	sprintf(tmp, "%d\n", dmar_platform_optin());
+	return simple_read_from_buffer(buf, count, ppos, tmp,
sizeof(tmp));
+}
+
+static const struct file_operations iommu_dmar_enabled_ops = {
+	.read  = iommu_dmar_enabled_read,
+};
+
+/**
+ * iommu_securityfs_setup - create the iommu directory in security
with any
+ *                          shared attributes
+ *
+ * Provide base enablement for using security to expose internal data
of an
+ * IOMMU driver. When called, this function creates the
+ * /sys/kernel/security/iommu directory.
+ *
+ * This function is called from iommu_init; drivers may then use
+ * iommu_securityfs_dir to instantiate vendor-specific attributes.
+ */
+void iommu_securityfs_setup(void)
+{
+	if (!iommu_securityfs_dir) {
+		iommu_securityfs_dir = securityfs_create_dir("iommu",
NULL);
+		if (IS_ERR(iommu_dmar_enabled))
+			return;
+		iommu_dmar_enabled =
+		    securityfs_create_file("dmar_enabled",
+					   0600, iommu_securityfs_dir,
NULL,
+					   &iommu_dmar_enabled_ops);
+	}
+}
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 7b375421afba..d8256485a7af 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2192,6 +2192,7 @@ static int __init iommu_init(void)
 	BUG_ON(!iommu_group_kset);
 
 	iommu_debugfs_setup();
+	iommu_securityfs_setup();
 
 	return 0;
 }
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 7ef8b0bda695..5d6721ec9bf9 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -1101,4 +1101,11 @@ void iommu_debugfs_setup(void);
 static inline void iommu_debugfs_setup(void) {}
 #endif
 
+#ifdef CONFIG_SECURITY
+extern	struct dentry *iommu_securityfs_dir;
+void iommu_securityfs_setup(void);
+#else
+static inline void iommu_securityfs_setup(void) {}
+#endif
+
 #endif /* __LINUX_IOMMU_H */


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
