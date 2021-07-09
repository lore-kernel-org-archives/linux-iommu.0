Return-Path: <SRS0=6oxg=MB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED3CC11F66
	for <iommu@archiver.kernel.org>; Fri,  9 Jul 2021 11:43:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9E8F613C9
	for <iommu@archiver.kernel.org>; Fri,  9 Jul 2021 11:43:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9E8F613C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8ED6883D3A;
	Fri,  9 Jul 2021 11:43:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vvqfsZb2jLmz; Fri,  9 Jul 2021 11:43:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5F56383D17;
	Fri,  9 Jul 2021 11:43:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 39248C001A;
	Fri,  9 Jul 2021 11:43:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 76EBDC000E;
 Fri,  9 Jul 2021 11:43:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 586BF6074A;
 Fri,  9 Jul 2021 11:43:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bjasu24yTbDX; Fri,  9 Jul 2021 11:43:49 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8CA20605DE;
 Fri,  9 Jul 2021 11:43:49 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 u5-20020a7bc0450000b02901480e40338bso6363031wmc.1; 
 Fri, 09 Jul 2021 04:43:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pLOJW7d88vrY9GmA9ucvUaUUVOlvzPYC8Oyh2a0Sb1s=;
 b=CYxMhUiH1ZqtOGS6NeuptdTSdKSQ18bDEO2gp7Hha0hYOq4IYJ2eMWeuJ4Wn9ZHRss
 ZPCx3xH+xeR23PFI0Sa3C5FW1oqdRPcwT/xE77EhxYdZ/EXcxT1EjpatF1Ih2ZH4PbrM
 XpMhPEQqjhuIEkPCERUkMtKIc1Or7CUZk1ljaLLKopZBDDZTfQFAWWq3daJ3yWHFM6qo
 0VD4zmfSk6z/X2PzPs2YFcVNsRCe3dCKtTLG8CClKmXPtEoxq2XZA0TOWh6eshSiHj6T
 NwEvlmvhxtvT6syrEKpwVRbVQ7Br0c+GgaMvCWWp3TwG9evBZfujRenAvW0U92ScZYLg
 82zw==
X-Gm-Message-State: AOAM530DX+qULLFh3rFXQZt03ADOhGSllegNigUPJ2FVZfrs6hQjzjnt
 sSRD0ui7m7UARGdssWfV2SQ=
X-Google-Smtp-Source: ABdhPJyoOzdW1/ocaitVPdNhN15vIaawhkBqprEc88D3z21sdADkciIP1zBasQCgJY0b30+cUdo/Wg==
X-Received: by 2002:a05:600c:4a09:: with SMTP id
 c9mr38602838wmp.11.1625831027824; 
 Fri, 09 Jul 2021 04:43:47 -0700 (PDT)
Received: from
 liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net
 ([51.145.34.42])
 by smtp.gmail.com with ESMTPSA id z12sm4896849wrs.39.2021.07.09.04.43.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Jul 2021 04:43:47 -0700 (PDT)
From: Wei Liu <wei.liu@kernel.org>
To: Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Subject: [RFC v1 3/8] intel/vt-d: make DMAR table parsing code more flexible
Date: Fri,  9 Jul 2021 11:43:34 +0000
Message-Id: <20210709114339.3467637-4-wei.liu@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210709114339.3467637-1-wei.liu@kernel.org>
References: <20210709114339.3467637-1-wei.liu@kernel.org>
MIME-Version: 1.0
Cc: Wei Liu <wei.liu@kernel.org>, pasha.tatashin@soleen.com,
 Will Deacon <will@kernel.org>, kumarpraveen@linux.microsoft.com,
 David Woodhouse <dwmw2@infradead.org>,
 Linux Kernel List <linux-kernel@vger.kernel.org>,
 Michael Kelley <mikelley@microsoft.com>,
 "open list:INTEL IOMMU VT-d" <iommu@lists.linux-foundation.org>,
 Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 virtualization@lists.linux-foundation.org,
 Vineeth Pillai <viremana@linux.microsoft.com>
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

Microsoft Hypervisor provides a set of hypercalls to manage device
domains. The root kernel should parse the DMAR so that it can program
the IOMMU (with hypercalls) correctly.

The DMAR code was designed to work with Intel IOMMU only. Add two more
parameters to make it useful to Microsoft Hypervisor. Microsoft
Hypervisor does not need the DMAR parsing code to allocate an Intel
IOMMU structure; it also wishes to always reparse the DMAR table even
after it has been parsed before.

Adjust Intel IOMMU code to use the new dmar_table_init. There should be
no functional change to Intel IOMMU code.

Signed-off-by: Wei Liu <wei.liu@kernel.org>
---
We may be able to combine alloc and force_parse?
---
 drivers/iommu/intel/dmar.c          | 38 ++++++++++++++++++++---------
 drivers/iommu/intel/iommu.c         |  2 +-
 drivers/iommu/intel/irq_remapping.c |  2 +-
 include/linux/dmar.h                |  2 +-
 4 files changed, 30 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 84057cb9596c..bd72f47c728b 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -408,7 +408,8 @@ dmar_find_dmaru(struct acpi_dmar_hardware_unit *drhd)
  * structure which uniquely represent one DMA remapping hardware unit
  * present in the platform
  */
-static int dmar_parse_one_drhd(struct acpi_dmar_header *header, void *arg)
+static int dmar_parse_one_drhd_internal(struct acpi_dmar_header *header,
+		void *arg, bool alloc)
 {
 	struct acpi_dmar_hardware_unit *drhd;
 	struct dmar_drhd_unit *dmaru;
@@ -440,12 +441,14 @@ static int dmar_parse_one_drhd(struct acpi_dmar_header *header, void *arg)
 		return -ENOMEM;
 	}
 
-	ret = alloc_iommu(dmaru);
-	if (ret) {
-		dmar_free_dev_scope(&dmaru->devices,
-				    &dmaru->devices_cnt);
-		kfree(dmaru);
-		return ret;
+	if (alloc) {
+		ret = alloc_iommu(dmaru);
+		if (ret) {
+			dmar_free_dev_scope(&dmaru->devices,
+					    &dmaru->devices_cnt);
+			kfree(dmaru);
+			return ret;
+		}
 	}
 	dmar_register_drhd_unit(dmaru);
 
@@ -456,6 +459,16 @@ static int dmar_parse_one_drhd(struct acpi_dmar_header *header, void *arg)
 	return 0;
 }
 
+static int dmar_parse_one_drhd(struct acpi_dmar_header *header, void *arg)
+{
+	return dmar_parse_one_drhd_internal(header, arg, true);
+}
+
+int dmar_parse_one_drhd_noalloc(struct acpi_dmar_header *header, void *arg)
+{
+	return dmar_parse_one_drhd_internal(header, arg, false);
+}
+
 static void dmar_free_drhd(struct dmar_drhd_unit *dmaru)
 {
 	if (dmaru->devices && dmaru->devices_cnt)
@@ -633,7 +646,7 @@ static inline int dmar_walk_dmar_table(struct acpi_table_dmar *dmar,
  * parse_dmar_table - parses the DMA reporting table
  */
 static int __init
-parse_dmar_table(void)
+parse_dmar_table(bool alloc)
 {
 	struct acpi_table_dmar *dmar;
 	int drhd_count = 0;
@@ -650,6 +663,9 @@ parse_dmar_table(void)
 		.cb[ACPI_DMAR_TYPE_SATC] = &dmar_parse_one_satc,
 	};
 
+	if (!alloc)
+		cb.cb[ACPI_DMAR_TYPE_HARDWARE_UNIT] = &dmar_parse_one_drhd_noalloc;
+
 	/*
 	 * Do it again, earlier dmar_tbl mapping could be mapped with
 	 * fixed map.
@@ -840,13 +856,13 @@ void __init dmar_register_bus_notifier(void)
 }
 
 
-int __init dmar_table_init(void)
+int __init dmar_table_init(bool alloc, bool force_parse)
 {
 	static int dmar_table_initialized;
 	int ret;
 
-	if (dmar_table_initialized == 0) {
-		ret = parse_dmar_table();
+	if (dmar_table_initialized == 0 || force_parse) {
+		ret = parse_dmar_table(alloc);
 		if (ret < 0) {
 			if (ret != -ENODEV)
 				pr_info("Parse DMAR table failure.\n");
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index be35284a2016..a4294d310b93 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4310,7 +4310,7 @@ int __init intel_iommu_init(void)
 	}
 
 	down_write(&dmar_global_lock);
-	if (dmar_table_init()) {
+	if (dmar_table_init(true, false)) {
 		if (force_on)
 			panic("tboot: Failed to initialize DMAR table\n");
 		goto out_free_dmar;
diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
index f912fe45bea2..0e8abef862e4 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -732,7 +732,7 @@ static int __init intel_prepare_irq_remapping(void)
 		return -ENODEV;
 	}
 
-	if (dmar_table_init() < 0)
+	if (dmar_table_init(true, false) < 0)
 		return -ENODEV;
 
 	if (intel_cap_audit(CAP_AUDIT_STATIC_IRQR, NULL))
diff --git a/include/linux/dmar.h b/include/linux/dmar.h
index e04436a7ff27..f88535d41a6e 100644
--- a/include/linux/dmar.h
+++ b/include/linux/dmar.h
@@ -106,7 +106,7 @@ static inline bool dmar_rcu_check(void)
 	for_each_dev_scope((devs), (cnt), (i), (tmp))			\
 		if (!(tmp)) { continue; } else
 
-extern int dmar_table_init(void);
+extern int dmar_table_init(bool alloc, bool force_parse);
 extern int dmar_dev_scope_init(void);
 extern void dmar_register_bus_notifier(void);
 extern int dmar_parse_dev_scope(void *start, void *end, int *cnt,
-- 
2.30.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
