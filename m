Return-Path: <SRS0=Z7Xn=ZO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A92AFC432C0
	for <iommu@archiver.kernel.org>; Fri, 22 Nov 2019 10:51:07 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 692CD2072E
	for <iommu@archiver.kernel.org>; Fri, 22 Nov 2019 10:51:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KvntgGm3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 692CD2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 074EC87388;
	Fri, 22 Nov 2019 10:51:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EO7OLtXjfmd6; Fri, 22 Nov 2019 10:51:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8513087383;
	Fri, 22 Nov 2019 10:50:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7430DC1DD8;
	Fri, 22 Nov 2019 10:50:58 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AA2BFC18DA
 for <iommu@lists.linux-foundation.org>; Fri, 22 Nov 2019 10:50:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id A1FEE25D78
 for <iommu@lists.linux-foundation.org>; Fri, 22 Nov 2019 10:50:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oIS0dAdALcC1 for <iommu@lists.linux-foundation.org>;
 Fri, 22 Nov 2019 10:50:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
 [209.85.128.65])
 by silver.osuosl.org (Postfix) with ESMTPS id 6CBD221526
 for <iommu@lists.linux-foundation.org>; Fri, 22 Nov 2019 10:50:55 +0000 (UTC)
Received: by mail-wm1-f65.google.com with SMTP id l17so6945411wmh.0
 for <iommu@lists.linux-foundation.org>; Fri, 22 Nov 2019 02:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/inLver145cFol/5bUSjQQctnMruvUV98+tylzxeqnk=;
 b=KvntgGm303h0Ssxf9aIFIK2XkoQiqLGKm8oBQdtFp8m6CkhuS563d23h38idVHFBTS
 kkHWOjKBIeiLqtFnIN5JqRxHj/IPpP1+8FLf2khs7+nbgJ0OpH9sMYPdLblXJN/5mPtZ
 Wb+8873vkfkzhOEno3SZc1Y9APZr1NOsSzkKP1ZCQ6Z0rpQLTlKOI9WgdHg2e1LDo7F0
 tBgAB48y5L6SMpiI5ioJ2KIyTBgMturfH5KATIT+F+PcJxgVRRlhZPFK7De+LuxTeNtE
 M4IA2puSbiUMBj2P+pdk0515MczvrK3k66Sn0WsjBltTEdPU0l74IdtDnv4aQdCAd0EZ
 nmsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/inLver145cFol/5bUSjQQctnMruvUV98+tylzxeqnk=;
 b=dv6OfmXpUWtaOKka85mVcqmEIaKf/TJ0uRErWBkk0Nkoa1MwAhAJG1X5Tn1MLC3faD
 Qx2cw5GjwMdp8dbr5779sNfK9EZrT22o+P2mm6PclCtXXGgVBXSBiaUBEHrU3MM6I+dl
 X0q0GnExwLJY15AFX64rHWEpe36CMyyjlw0vO+86VGxt+1A1nNyXfIDeJDVVtVU6cW4D
 bHm+K8o4VB6iUH908/bDZuNzTV7s8em+LMmhnU2HyTSnS5X2JNgVnd+/Z0G1uVIleN5x
 Rx//vc6xhLO2+v6AD6a5Rl/CUKRc+g0JgQ6paWJpz2f1Tq9922jAXxtJSQppZlqd9xA+
 kw0w==
X-Gm-Message-State: APjAAAUX+YQOnnJFCXnvn7w1dZhF49MZVDPr8AwS+O2IfmXUhcwpWKMK
 Acr4N1O828aKxv5yGHNO9uvnpA==
X-Google-Smtp-Source: APXvYqybl+9ikgvCfSNL7CGfiLoR9Bk+QtDdRzYQU3EDUxB/3MAL7UXcY6vI8QXG4ikVn9LuAUlWLA==
X-Received: by 2002:a05:600c:3cd:: with SMTP id
 z13mr15785876wmd.105.1574419853787; 
 Fri, 22 Nov 2019 02:50:53 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-204-106.adslplus.ch.
 [188.155.204.106])
 by smtp.gmail.com with ESMTPSA id o133sm2088197wmb.4.2019.11.22.02.50.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Nov 2019 02:50:53 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux-foundation.org,
 virtualization@lists.linux-foundation.org, linux-pci@vger.kernel.org,
 virtio-dev@lists.oasis-open.org
Subject: [RFC 02/13] ACPI: Add VIOT definitions
Date: Fri, 22 Nov 2019 11:49:49 +0100
Message-Id: <20191122105000.800410-3-jean-philippe@linaro.org>
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

This is temporary, until the VIOT table is published and these
definitions added to ACPICA.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 include/acpi/actbl2.h | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index e45ced27f4c3..99c1d747e9d8 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -25,6 +25,7 @@
  * the wrong signature.
  */
 #define ACPI_SIG_IORT           "IORT"	/* IO Remapping Table */
+#define ACPI_SIG_VIOT           "VIOT"	/* Virtual I/O Table */
 #define ACPI_SIG_IVRS           "IVRS"	/* I/O Virtualization Reporting Structure */
 #define ACPI_SIG_LPIT           "LPIT"	/* Low Power Idle Table */
 #define ACPI_SIG_MADT           "APIC"	/* Multiple APIC Description Table */
@@ -412,6 +413,36 @@ struct acpi_ivrs_memory {
 	u64 memory_length;
 };
 
+/*******************************************************************************
+ *
+ * VIOT - Virtual I/O Table
+ *        Version 1
+ *
+ ******************************************************************************/
+
+struct acpi_table_viot {
+	struct acpi_table_header header;
+	u8 reserved[12];
+	struct acpi_table_header base_table;
+};
+
+#define ACPI_VIOT_IORT_NODE_VIRTIO_PCI_IOMMU    0x80
+#define ACPI_VIOT_IORT_NODE_VIRTIO_MMIO_IOMMU   0x81
+
+struct acpi_viot_iort_virtio_pci_iommu {
+	u32 devid;
+};
+
+struct acpi_viot_iort_virtio_mmio_iommu {
+	u64 base_address;
+	u64 span;
+	u64 flags;
+	u64 interrupt;
+};
+
+/* FIXME: rename this monstrosity. */
+#define ACPI_VIOT_IORT_VIRTIO_MMIO_IOMMU_CACHE_COHERENT (1<<0)
+
 /*******************************************************************************
  *
  * LPIT - Low Power Idle Table
-- 
2.24.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
