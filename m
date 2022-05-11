Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AD5FC433EF
	for <iommu@archiver.kernel.org>; Wed, 11 May 2022 07:22:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DE68940ADF;
	Wed, 11 May 2022 07:22:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UDl_vN6Yqk3W; Wed, 11 May 2022 07:22:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9A498404F0;
	Wed, 11 May 2022 07:22:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 83E95C0039;
	Wed, 11 May 2022 07:22:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BB273C002D
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 07:22:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A892560A83
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 07:22:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fYDUEGMouTEk for <iommu@lists.linux-foundation.org>;
 Wed, 11 May 2022 07:22:49 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::62e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B23E860881
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 07:22:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mgUj7eJPqj3vcv8uZ4Ic/Xc6RRTQJqBvHDs2JPDEzt78Q/Oc3p0lGL5x/RG+apZjKGTfJkqzQsD7tAED5E8FNdp/neK5hAuH+AloYU8bpFPiRBebEaI72aUg061Mo6mR2uv301IX0433XeJ/jmzPfQbLtg+tDQdp0BzS307MN9+xeszh6gtbng5KbEhkr6Wu7pvvVgDl4/7eF3IznofNqeOYuy5mlBibA8T08L7j6uiRvKLMHCe+6VL5kb0aiRZmjbwDuDEUu7tPtwQBQtpsLg6P5YPbbOtGo8GXXRrYZHCK0CL/BlA3SMgkgIefUhpfL1tl9GVX5tX2lRQV7jWmxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zHlvpCqYlezJcamrgXuz5OT35LU6SHG5y4epIRkQ778=;
 b=mFE/cDWnO2wiJHM82T/Sq9B9nG76YGHCCzwki4Ab6RIlaCtUhCnwffBkkJqvttfDrBrtgeXtoq8Nnsx//QFdbsvm1gp5DhyA+fryQ9741hDbUwVJTMwvxSoAPfNNWvTnUN3CbWYtwYBuZFW3ywbl0Zx85jgkl85ePUynlXMfkOvAwiM6yRvHif+Z/45AYw+et+2Buci8/AFKsU7WDaqg6RNp+1UP2KSGraPA5xJuxmSQV3NvFR6qhgvm0iJbiprnvdxz8QyPo94Y1mp8o1SUq1Xvptak4tsDz4bbM9AwtrYemZxGq27NyBeYKbIWdSZ7mUrGiEEUo706pXA3+UeH+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zHlvpCqYlezJcamrgXuz5OT35LU6SHG5y4epIRkQ778=;
 b=ZFNpIjt+sgmVuG/1+z6cWxwJS45uwjr+MEvuDIDWD7fwjcMEVClTXI6PrP4QiGRIxwPEgHZkZab9WK38JWEn0FDf/IRdaWiAbl0WaSMIYETt9Np3U76Ih3BTwTuiuFfn7Ok4naYlFGUBzA5hZ8Yo38ZdZUgqBVNmWmzt+vu+mMc=
Received: from DS7PR05CA0086.namprd05.prod.outlook.com (2603:10b6:8:56::7) by
 DM8PR12MB5448.namprd12.prod.outlook.com (2603:10b6:8:27::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5227.22; Wed, 11 May 2022 07:22:45 +0000
Received: from DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:56:cafe::6a) by DS7PR05CA0086.outlook.office365.com
 (2603:10b6:8:56::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13 via Frontend
 Transport; Wed, 11 May 2022 07:22:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT011.mail.protection.outlook.com (10.13.172.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Wed, 11 May 2022 07:22:45 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 11 May
 2022 02:22:43 -0500
To: <iommu@lists.linux-foundation.org>
Subject: [PATCH v3 02/35] iommu/amd: Introduce pci segment structure
Date: Wed, 11 May 2022 12:51:08 +0530
Message-ID: <20220511072141.15485-3-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220511072141.15485-1-vasant.hegde@amd.com>
References: <20220511072141.15485-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ac6f86e-7de5-4fae-339e-08da331f0b5b
X-MS-TrafficTypeDiagnostic: DM8PR12MB5448:EE_
X-Microsoft-Antispam-PRVS: <DM8PR12MB54486840D7CE79322C7ED28D87C89@DM8PR12MB5448.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: omZsh9H+8uT6j3a5+AZG8eaI3dEn/L/2g+NaQoPxXHuyVhYvUjgacq90Z2LamxMQCxP/ePpFNF2lLm7vQ/9KbfNVGRQnk4Zg4zsBvna2jkc/bqlGgcckOetY6XYcKq8jDVmKBnIohM/ZY/Pqo6tODcoTFy+NHuYxUShY5NKg1TSGVRHDGQAWknC15FnE79NRWr+l14tFZEo2QHVVp+Pjk8sCF8TNVMmtDCZHABx/PcYAEZvfplx/q9etcFnlBqH7c6TmwLzHoWZyseAak944ZvSmOtRjbIH5GA5R0KA2YVZ+Xtx1OaQpV9PymkAFOJBCK+7z8+8LZsrOg8FDU79jlWR5/pYH9rMQBGB3GQYFJ+4tm7k8PNluyAVIBRhviUzuanLFZnkf12RfzOIBzTR6vcGloywXhXEesSRMs/MXFyoAOz9D//3u84y9Gnhb8BeOR6WG0MnVSa4IuznG6IbawJcLKm4KjsCq7YpK34Ih7MlwfXcWxxKsIRo+yhylyUXRR5o8qiK50CIjU5e6BqdDaEBHw8LuiQapnBRwGxyQ7fPwn28XUB+8Is+ngoC7FMyw9bDHGHdcEXrQdq7d3Zrp9IVhtsKnnl/3adTm6H8PacVRpfHSF0yIJsI52KKNC5cBzezNzuYmQtVok+FG3Dwi74MXat+9VHUHM5f8VFH9Hdi4Lp1I+tVAJ2C5qOUeCox0ZM/CEx/M8/7QcSWran+kdg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(82310400005)(2906002)(36756003)(36860700001)(8936002)(5660300002)(44832011)(70206006)(8676002)(4326008)(70586007)(186003)(1076003)(86362001)(6916009)(83380400001)(54906003)(40460700003)(16526019)(2616005)(336012)(7696005)(26005)(316002)(47076005)(81166007)(6666004)(426003)(356005)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 07:22:45.2781 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ac6f86e-7de5-4fae-339e-08da331f0b5b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5448
Cc: Vasant Hegde <vasant.hegde@amd.com>
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
From: Vasant Hegde via iommu <iommu@lists.linux-foundation.org>
Reply-To: Vasant Hegde <vasant.hegde@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Newer AMD systems can support multiple PCI segments, where each segment
contains one or more IOMMU instances. However, an IOMMU instance can only
support a single PCI segment.

Current code assumes that system contains only one pci segment (segment 0)
and creates global data structures such as device table, rlookup table,
etc.

Introducing per PCI segment data structure, which contains segment
specific data structures. This will eventually replace the global
data structures.

Also update `amd_iommu->pci_seg` variable to point to PCI segment
structure instead of PCI segment ID.

Co-developed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 24 ++++++++++++++-
 drivers/iommu/amd/init.c            | 46 ++++++++++++++++++++++++++++-
 2 files changed, 68 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 06235b7cb13d..7ec032afc1b2 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -452,6 +452,11 @@ extern bool amd_iommu_irq_remap;
 /* kmem_cache to get tables with 128 byte alignement */
 extern struct kmem_cache *amd_iommu_irq_cache;
 
+/* Make iterating over all pci segment easier */
+#define for_each_pci_segment(pci_seg) \
+	list_for_each_entry((pci_seg), &amd_iommu_pci_seg_list, list)
+#define for_each_pci_segment_safe(pci_seg, next) \
+	list_for_each_entry_safe((pci_seg), (next), &amd_iommu_pci_seg_list, list)
 /*
  * Make iterating over all IOMMUs easier
  */
@@ -526,6 +531,17 @@ struct protection_domain {
 	unsigned dev_iommu[MAX_IOMMUS]; /* per-IOMMU reference count */
 };
 
+/*
+ * This structure contains information about one PCI segment in the system.
+ */
+struct amd_iommu_pci_seg {
+	/* List with all PCI segments in the system */
+	struct list_head list;
+
+	/* PCI segment number */
+	u16 id;
+};
+
 /*
  * Structure where we save information about one hardware AMD IOMMU in the
  * system.
@@ -577,7 +593,7 @@ struct amd_iommu {
 	u16 cap_ptr;
 
 	/* pci domain of this IOMMU */
-	u16 pci_seg;
+	struct amd_iommu_pci_seg *pci_seg;
 
 	/* start of exclusion range of that IOMMU */
 	u64 exclusion_start;
@@ -705,6 +721,12 @@ extern struct list_head ioapic_map;
 extern struct list_head hpet_map;
 extern struct list_head acpihid_map;
 
+/*
+ * List with all PCI segments in the system. This list is not locked because
+ * it is only written at driver initialization time
+ */
+extern struct list_head amd_iommu_pci_seg_list;
+
 /*
  * List with all IOMMUs in the system. This list is not locked because it is
  * only written and read at driver initialization or suspend time
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index b4a798c7b347..71be7ee4aa8b 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -165,6 +165,7 @@ u16 amd_iommu_last_bdf;			/* largest PCI device id we have
 LIST_HEAD(amd_iommu_unity_map);		/* a list of required unity mappings
 					   we find in ACPI */
 
+LIST_HEAD(amd_iommu_pci_seg_list);	/* list of all PCI segments */
 LIST_HEAD(amd_iommu_list);		/* list of all AMD IOMMUs in the
 					   system */
 
@@ -1456,6 +1457,43 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 	return 0;
 }
 
+/* Allocate PCI segment data structure */
+static struct amd_iommu_pci_seg *__init alloc_pci_segment(u16 id)
+{
+	struct amd_iommu_pci_seg *pci_seg;
+
+	pci_seg = kzalloc(sizeof(struct amd_iommu_pci_seg), GFP_KERNEL);
+	if (pci_seg == NULL)
+		return NULL;
+
+	pci_seg->id = id;
+	list_add_tail(&pci_seg->list, &amd_iommu_pci_seg_list);
+
+	return pci_seg;
+}
+
+static struct amd_iommu_pci_seg *__init get_pci_segment(u16 id)
+{
+	struct amd_iommu_pci_seg *pci_seg;
+
+	for_each_pci_segment(pci_seg) {
+		if (pci_seg->id == id)
+			return pci_seg;
+	}
+
+	return alloc_pci_segment(id);
+}
+
+static void __init free_pci_segments(void)
+{
+	struct amd_iommu_pci_seg *pci_seg, *next;
+
+	for_each_pci_segment_safe(pci_seg, next) {
+		list_del(&pci_seg->list);
+		kfree(pci_seg);
+	}
+}
+
 static void __init free_iommu_one(struct amd_iommu *iommu)
 {
 	free_cwwb_sem(iommu);
@@ -1542,8 +1580,14 @@ static void amd_iommu_ats_write_check_workaround(struct amd_iommu *iommu)
  */
 static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h)
 {
+	struct amd_iommu_pci_seg *pci_seg;
 	int ret;
 
+	pci_seg = get_pci_segment(h->pci_seg);
+	if (pci_seg == NULL)
+		return -ENOMEM;
+	iommu->pci_seg = pci_seg;
+
 	raw_spin_lock_init(&iommu->lock);
 	iommu->cmd_sem_val = 0;
 
@@ -1564,7 +1608,6 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h)
 	 */
 	iommu->devid   = h->devid;
 	iommu->cap_ptr = h->cap_ptr;
-	iommu->pci_seg = h->pci_seg;
 	iommu->mmio_phys = h->mmio_phys;
 
 	switch (h->type) {
@@ -2610,6 +2653,7 @@ static void __init free_iommu_resources(void)
 	amd_iommu_dev_table = NULL;
 
 	free_iommu_all();
+	free_pci_segments();
 }
 
 /* SB IOAPIC is always on this device in AMD systems */
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
