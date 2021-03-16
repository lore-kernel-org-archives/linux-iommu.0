Return-Path: <SRS0=0/W0=IO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3BDAC433DB
	for <iommu@archiver.kernel.org>; Tue, 16 Mar 2021 19:18:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 700506500E
	for <iommu@archiver.kernel.org>; Tue, 16 Mar 2021 19:18:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 700506500E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5110560692;
	Tue, 16 Mar 2021 19:18:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id slbrahZlac5D; Tue, 16 Mar 2021 19:18:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 253D960586;
	Tue, 16 Mar 2021 19:18:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 05335C000D;
	Tue, 16 Mar 2021 19:18:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8199CC000A
 for <iommu@lists.linux-foundation.org>; Tue, 16 Mar 2021 19:18:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 70D39606B9
 for <iommu@lists.linux-foundation.org>; Tue, 16 Mar 2021 19:18:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NY9KhEVymkeh for <iommu@lists.linux-foundation.org>;
 Tue, 16 Mar 2021 19:18:51 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3C85160586
 for <iommu@lists.linux-foundation.org>; Tue, 16 Mar 2021 19:18:51 +0000 (UTC)
Received: by mail-wr1-x42e.google.com with SMTP id v15so11087720wrx.4
 for <iommu@lists.linux-foundation.org>; Tue, 16 Mar 2021 12:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hbwZsYD4Q8bJKtEB6fxh/bFBCimZQTVQVLBghKe6qbw=;
 b=Fw/OojIRjcN1Khd18loli2fVEoX2eO8BxWvGUV/w/gINHwluL30dSWAh6qrJt3Sd/N
 ck2xw1Cjj6Trn4wLHz33y3JImni1Q9YLXkE7sUjgdpk8ct76pvt1ScCTaKNhBzT+gpQ7
 yeLtQMMQ6yJAPa3ql2QOtP6O4VNaswVNnUKrG1wr4ovsscKI50j+nTmVWepaiariJtvd
 gpjHPvJbE/fjajNo9/K5fc6ypFNzPL4XP8X2om88xf094zU8oeD0nTw/JHOiQGj0ffv4
 xv7HYx02Khp62T8TfM6qak2p3lLGu4VSeqwTonb1ORY/cHgGrOZokparIbPY79QU0aHx
 tiXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hbwZsYD4Q8bJKtEB6fxh/bFBCimZQTVQVLBghKe6qbw=;
 b=ePkhRBtlZ9easIuOhXrRLX/yWodigwIcYG9k6ykc+eyKKJboAH/hoEUeQSBGlOep8E
 WUL5QqW9M/Km3vQOt4kBRVeP2zgDhqsCaK3FqbxVqZBPC83Dw8gcOXoNIfuzv6fUxlPH
 uULjYpxO03xCyDJyDYklyDNj/jh/YNejrX0w0MPV1tOrtCgV0LwWXVlOWhur17h+DIqz
 DwWcoJU6pQaBGwtPQvf1metDrxpH6p1/1OrxPivJaLGyOCPs7uzbkovgtjl2wBaO40kW
 LplsG8q/bcty3lYLeHZW8hUHS5F6LF7+m13ibvU8hgchnBpUL/J0aeG19xhMyZ+if07b
 tMPg==
X-Gm-Message-State: AOAM533dBtvTQmvdooNMpd9WeEh7PwyXMMzDjY6KiRuYV8WDR1zoQ8XP
 S9fPH1J7hG6YtdbsLjpl63kFhQ==
X-Google-Smtp-Source: ABdhPJymVA+bDQYxQA0i9VexjAgCNYrzeQ8+S/1wLYjWYR0LjtgKCLhBt3in1MQJ33b+oqMmOM4lKA==
X-Received: by 2002:a5d:6c69:: with SMTP id r9mr549309wrz.11.1615922329510;
 Tue, 16 Mar 2021 12:18:49 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id p12sm22690438wrx.28.2021.03.16.12.18.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Mar 2021 12:18:49 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: rjw@rjwysocki.net,
	lenb@kernel.org,
	joro@8bytes.org,
	mst@redhat.com
Subject: [PATCH 1/3] ACPICA: iASL: Add definitions for the VIOT table
Date: Tue, 16 Mar 2021 20:16:52 +0100
Message-Id: <20210316191652.3401335-2-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210316191652.3401335-1-jean-philippe@linaro.org>
References: <20210316191652.3401335-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: jean-philippe@linaro.org, kevin.tian@intel.com, robin.murphy@arm.com,
 virtualization@lists.linux-foundation.org, linux-acpi@vger.kernel.org,
 iommu@lists.linux-foundation.org, sebastien.boeuf@intel.com, will@kernel.org
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

Just here for reference, don't merge!

The actual commits will be pulled from the next ACPICA release.
I squashed the three relevant commits:

ACPICA commit fc4e33319c1ee08f20f5c44853dd8426643f6dfd
ACPICA commit 2197e354fb5dcafaddd2016ffeb0620e5bc3d5e2
ACPICA commit 856a96fdf4b51b2b8da17529df0255e6f51f1b5b

Link: https://github.com/acpica/acpica/commit/fc4e3331
Link: https://github.com/acpica/acpica/commit/2197e354
Link: https://github.com/acpica/acpica/commit/856a96fd
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 include/acpi/actbl3.h | 67 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/include/acpi/actbl3.h b/include/acpi/actbl3.h
index df5f4b27f3aa..09d15898e9a8 100644
--- a/include/acpi/actbl3.h
+++ b/include/acpi/actbl3.h
@@ -33,6 +33,7 @@
 #define ACPI_SIG_TCPA           "TCPA"	/* Trusted Computing Platform Alliance table */
 #define ACPI_SIG_TPM2           "TPM2"	/* Trusted Platform Module 2.0 H/W interface table */
 #define ACPI_SIG_UEFI           "UEFI"	/* Uefi Boot Optimization Table */
+#define ACPI_SIG_VIOT           "VIOT"	/* Virtual I/O Translation Table */
 #define ACPI_SIG_WAET           "WAET"	/* Windows ACPI Emulated devices Table */
 #define ACPI_SIG_WDAT           "WDAT"	/* Watchdog Action Table */
 #define ACPI_SIG_WDDT           "WDDT"	/* Watchdog Timer Description Table */
@@ -483,6 +484,72 @@ struct acpi_table_uefi {
 	u16 data_offset;	/* Offset of remaining data in table */
 };
 
+/*******************************************************************************
+ *
+ * VIOT - Virtual I/O Translation Table
+ *        Version 1
+ *
+ ******************************************************************************/
+
+struct acpi_table_viot {
+	struct acpi_table_header header;	/* Common ACPI table header */
+	u16 node_count;
+	u16 node_offset;
+	u8 reserved[8];
+};
+
+/* VIOT subtable header */
+
+struct acpi_viot_header {
+	u8 type;
+	u8 reserved;
+	u16 length;
+};
+
+/* Values for Type field above */
+
+enum acpi_viot_node_type {
+	ACPI_VIOT_NODE_PCI_RANGE = 0x01,
+	ACPI_VIOT_NODE_MMIO = 0x02,
+	ACPI_VIOT_NODE_VIRTIO_IOMMU_PCI = 0x03,
+	ACPI_VIOT_NODE_VIRTIO_IOMMU_MMIO = 0x04,
+	ACPI_VIOT_RESERVED = 0x05
+};
+
+/* VIOT subtables */
+
+struct acpi_viot_pci_range {
+	struct acpi_viot_header header;
+	u32 endpoint_start;
+	u16 segment_start;
+	u16 segment_end;
+	u16 bdf_start;
+	u16 bdf_end;
+	u16 output_node;
+	u8 reserved[6];
+};
+
+struct acpi_viot_mmio {
+	struct acpi_viot_header header;
+	u32 endpoint;
+	u64 base_address;
+	u16 output_node;
+	u8 reserved[6];
+};
+
+struct acpi_viot_virtio_iommu_pci {
+	struct acpi_viot_header header;
+	u16 segment;
+	u16 bdf;
+	u8 reserved[8];
+};
+
+struct acpi_viot_virtio_iommu_mmio {
+	struct acpi_viot_header header;
+	u8 reserved[4];
+	u64 base_address;
+};
+
 /*******************************************************************************
  *
  * WAET - Windows ACPI Emulated devices Table
-- 
2.30.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
