Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B784C433F5
	for <iommu@archiver.kernel.org>; Mon, 25 Apr 2022 11:35:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 37F504109D;
	Mon, 25 Apr 2022 11:35:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gs0yHNVul0Cv; Mon, 25 Apr 2022 11:35:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 64816409EF;
	Mon, 25 Apr 2022 11:35:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3B20FC0039;
	Mon, 25 Apr 2022 11:35:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 15576C002D
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:35:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 028EF4057C
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:35:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OAlC8LApxi6S for <iommu@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 11:35:39 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eb2::629])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C33AE4045C
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:35:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i6tRCN6auc/Qp4OceWTafJweq63s8Rr508LuhOfK3l+czaIPlUIbIADOEVjnudpWw6tFtXq0EkWjQEtyopNfi6fcG0cLTDcl7xxZnI1Et7CMqfO9M18cGOvWuAhIIIqG+v6jUsVu64iF5pxaG2+psIkMfO5OWqpA3I63a68uQd8+7F54UL2BDoB+4XaVYrFmR8XkPwNhvdkrdWaChWytQeRYrimeV+79bZLHxnIdEchhBM4Hl63WauphO/BcASKXyUbpvRNIl3jt2gehMa6a2gXXDydOtw5C/u1sNGQiW5lj1bRFjwkdldt26XNGzzjvUvkAsDjVvNiSupbXjgyEqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5hAShbvAxP/kmQOTrvrhfnRRCTAMrhbvTwuzvj2K57U=;
 b=CDX36zCeKsgg5butbuAICjcfaczqT3c48C04g2CAF3n1VCBoLXXfObkjOmfZU3fjznWONrd85Q/gaVlfggipHFG9p6fKqmI2653KehOAp2e5Jm1jQmfrCBUIN9U8VMap5iGjhul4DeD1nYemuvOpvKIM+kTmxxLkoiO37xVh+X7UsCj/cOavCVPlptdqlYfn0jm8Sz2LztEFToUAFzNWB3osNdOZZsvlv9DaXHFVNCifmNkWHTTitJrAVwWFEF+F7SQFFytglCY3WOhq/2JLnOUnuB0ANuOw9ul9Ak0oELsSAESUO0zXgW10s0RL1IdpNHcUKGC5rIZB5cnBhC3kEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5hAShbvAxP/kmQOTrvrhfnRRCTAMrhbvTwuzvj2K57U=;
 b=uQ4QXS/7jReNjFcVw8pr5bmyyggiIlEpzgQ2DJXo0pXvnjzsnkyx+ZNEhDUnNZHDco9MKaKXkrcTHeaSUj3mpqoBwF6jq1qGAARrqbW5+RtIlfUAJb8EvT+pnilcdG1FbYLl5JLz0HY0jiOE4rByxVkuwirX55tVcQWqMBO1jsc=
Received: from BN9PR03CA0294.namprd03.prod.outlook.com (2603:10b6:408:f5::29)
 by BYAPR12MB3576.namprd12.prod.outlook.com (2603:10b6:a03:d8::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Mon, 25 Apr
 2022 11:35:34 +0000
Received: from BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f5:cafe::65) by BN9PR03CA0294.outlook.office365.com
 (2603:10b6:408:f5::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15 via Frontend
 Transport; Mon, 25 Apr 2022 11:35:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT012.mail.protection.outlook.com (10.13.177.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5164.19 via Frontend Transport; Mon, 25 Apr 2022 11:35:33 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 25 Apr
 2022 06:35:31 -0500
To: <iommu@lists.linux-foundation.org>
Subject: [PATCH v2 02/37] iommu/amd: Introduce pci segment structure
Date: Mon, 25 Apr 2022 17:03:40 +0530
Message-ID: <20220425113415.24087-3-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220425113415.24087-1-vasant.hegde@amd.com>
References: <20220425113415.24087-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b5ba73fb-1c19-4172-39b9-08da26afb5fb
X-MS-TrafficTypeDiagnostic: BYAPR12MB3576:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB35765D84E18483A877162EA687F89@BYAPR12MB3576.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U7A2T8fqeTI2RmREy8VAkIQTaepQZJDvKMv5mZvqRRIVv4PRgpNaABqppViVcD4XqtKoWzXheyyDzFdG8nQJTQ8yNTn0OhLILTQj2rhu2bOKT1fIxm1a9XG4S2rGmREZcKbOt6Pib3BDGMIM0PaituKnF6D76xHvmbT7G2qM0U6Y8X2nLfn3Y/lQkGf5Prcqe96SJsDDBjIEJ1EYJwDMWHK7Qqs/1eVMFXNsG92VwVOLeUSc/VWQCktlG14rny76NuN7wN9uP5MWg+kGnXl7Fxsb69+8dyOUULAf0Did8q4NGIzn6V9GJ0mzy1ppSzLuSS+M3Vn06SVz3kdaWW9N63VbqEmIdi7YQ+7hfGHrpC90a8qVY2wLb6dExUfJpL74IGsk88iEEEvM42GjMKiX4djUgjB9a14cwFj/jcTTuX3XrqsNWKaAgcAPslqJNC6tk8UYMAbteNhUQuLeqMVui37IuU0BfSRXkW1a+VTXmOxbzJtCkM34DFMAZxNmfqmjho+tcTq3/VY2d5zLwP3NAJfQQPgo2znIaucuD6wKcGDRjw+A5p8COGMUKy/ml1T99bx6wRkji9qZlYxPoRgWdUNZVZ/OhYgXFW951IM7iVMja2aihFwHmO8OTeDmE8vMD6W8nJsD7pHa+D2Sk2Quab2DlM93n+uJdlxhLsBwmQOOi0uWVbnck0vnzu7vBAWzaN56lKRE+KXyuEAkY+bvSg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(426003)(336012)(4326008)(16526019)(70206006)(70586007)(8676002)(186003)(82310400005)(36756003)(6666004)(26005)(316002)(6916009)(5660300002)(81166007)(356005)(2616005)(1076003)(47076005)(54906003)(86362001)(2906002)(83380400001)(36860700001)(40460700003)(508600001)(8936002)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 11:35:33.9838 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5ba73fb-1c19-4172-39b9-08da26afb5fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3576
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
 drivers/iommu/amd/amd_iommu_types.h | 23 ++++++++++++++-
 drivers/iommu/amd/init.c            | 46 ++++++++++++++++++++++++++++-
 2 files changed, 67 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 06235b7cb13d..62442d88978f 100644
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
@@ -526,6 +531,16 @@ struct protection_domain {
 	unsigned dev_iommu[MAX_IOMMUS]; /* per-IOMMU reference count */
 };
 
+/*
+ * This structure contains information about one PCI segment in the system.
+ */
+struct amd_iommu_pci_seg {
+	struct list_head list;
+
+	/* PCI segment number */
+	u16 id;
+};
+
 /*
  * Structure where we save information about one hardware AMD IOMMU in the
  * system.
@@ -577,7 +592,7 @@ struct amd_iommu {
 	u16 cap_ptr;
 
 	/* pci domain of this IOMMU */
-	u16 pci_seg;
+	struct amd_iommu_pci_seg *pci_seg;
 
 	/* start of exclusion range of that IOMMU */
 	u64 exclusion_start;
@@ -705,6 +720,12 @@ extern struct list_head ioapic_map;
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
index b4a798c7b347..e01eae9dcbc1 100644
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
+static void __init free_pci_segment(void)
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
+	free_pci_segment();
 }
 
 /* SB IOAPIC is always on this device in AMD systems */
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
