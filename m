Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1177C433F5
	for <iommu@archiver.kernel.org>; Fri, 11 Mar 2022 09:50:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7BD12611BE;
	Fri, 11 Mar 2022 09:50:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id G2IBErNorS7u; Fri, 11 Mar 2022 09:49:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 40083611BA;
	Fri, 11 Mar 2022 09:49:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 191F8C0012;
	Fri, 11 Mar 2022 09:49:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B9588C000B
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 09:49:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B6ADD611BE
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 09:49:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fawgIWMXLtIZ for <iommu@lists.linux-foundation.org>;
 Fri, 11 Mar 2022 09:49:57 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::62e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E2D8C611BA
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 09:49:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kh0InGjDDK+8d11ygJzcBPqgBR44S+GhcP3YUOEJW3NrcRcaGlAv/oWifOfq8dWdaI9qAZZymU9sS1r3Ocq8CEGCwGp11sz2dsVoDrTbYB8+yTWMPxCKypNqjOenzoRcYs+e2WbHSkKVna3o3XDDNOM6dGUI/fgxpW/3IK34sUYJwTsaxqXb9EiCPmHk7JOq5j9XHt7QUGWVrcdZVhPeLsp+cwa8CzMtDX2tzYtKq3o1jPQfT/4ClAM3bA9AtTUEd+Zns7es6pzkDQDql7IOaJDhLYkUgrMcVaDQ/vMq2sy38tMKGzjJBxrtqgZwD6HohGiUyB0rZ+DgY2sfuNhDqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gZiGpnD+0QE4LGjPnQo9c6IiJr7gfqi3ZDn0sQ7ax7M=;
 b=Agl16yVTWnqOZsWdciCRn72qG30t3H30zkJ32TyZzQGeukn7Tn0XLa8YoTuLSe5Ljo6TZbjpPbeVfU5wddhSt1+hdU5/gx738cr2FlzXRySbs3zTHvZBpC//uTSDuoRfEBU3j8UMO5a6rJgMAU7m7c/PeYAKEe7GyOEucm2NnpaOoBw1KINS6LZi8Nj2uaYDRzV6u5f8EVIMjE9khsMq4cs6kDYoA+gVJzhdcU5t0L3RKY3s1lvTqY46wl/5ZWJAuAxPHW/1hFJ4ToTESMxi1XwkUdbzyv+yShnsko5qnq9F8iNBx6/te5qZqmfj0kagw3tnpID6mXYeRd/gZ/ZU8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gZiGpnD+0QE4LGjPnQo9c6IiJr7gfqi3ZDn0sQ7ax7M=;
 b=uqHm4cAppf0a7Q3nLC4z0ap+6KrqRj5lUcoAz+MJ2YOqCRmriAqNeAsZ4IuKWdGsDmK6t0xTkdPjqsTgch8oKKsBJD7/REZlMDsr/kBTusNRp4fU79ySitCiV+nFpDr8ZrhgoP21oS/ypqDhy/a0K0smNQGB2o2S6aINUrSDc/4=
Received: from BN0PR04CA0188.namprd04.prod.outlook.com (2603:10b6:408:e9::13)
 by BY5PR12MB4193.namprd12.prod.outlook.com (2603:10b6:a03:20c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.24; Fri, 11 Mar
 2022 09:49:54 +0000
Received: from BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e9:cafe::48) by BN0PR04CA0188.outlook.office365.com
 (2603:10b6:408:e9::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22 via Frontend
 Transport; Fri, 11 Mar 2022 09:49:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT054.mail.protection.outlook.com (10.13.177.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Fri, 11 Mar 2022 09:49:51 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 11 Mar
 2022 03:49:49 -0600
To: <iommu@lists.linux-foundation.org>, <joro@8bytes.org>
Subject: [RFC PATCH 01/36] iommu/amd: Introduce pci segment structure
Date: Fri, 11 Mar 2022 15:18:19 +0530
Message-ID: <20220311094854.31595-2-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220311094854.31595-1-vasant.hegde@amd.com>
References: <20220311094854.31595-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c21a181b-bd56-4705-5cbc-08da03447d37
X-MS-TrafficTypeDiagnostic: BY5PR12MB4193:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB41938B41D725F9B202862881870C9@BY5PR12MB4193.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pXT7cAcZgQhJ46ZSN5bvhjBBG/ifzXag35lUqqlFIzpFcJXRY5D1KDMMWMjyjoYy0trXRgSzJZ9ldeqrAkdelUnfvM/h307HI7xxua40/jR6ZIySsteHdqvn6EW7MsjQYT/gnB6/l09fUMP5O2ABBRwKnw/7Z0TluTGVfuHVTrZ8JlBlzP4SB+zq4/rZgBI+6cp2wRDMLiA7AAnOavqbcautEiMJRIN6VudarPVLDBU6/yO1RiS0doNkMzFjW9+kgOizl6163E4ngZrUxz9CMIiDryvt0SkO11h25v5g1vJWHAUkOeTOv+MjcYsPyn3Qel91kOWzSUDCVUJO7ytKvYTw8xOPidM0JF88eDLbM7xE3Vx24Ov+YbXo2St/Cqzr2mngQguAG+qi0/MgWzdfnS0Fg90T1LQngiEPHkKMnpkhIFfn6A1eT9F1sObH2pMw4vCahkOBX9azVdtPxq9IJkhU9Nuqoing3LUmZSsREU8XiJGURrrPfgQG0YaBbJyBhmfxdMkZmhjdLqT9CeS6QlXYKKyrrzOMSkt1xgMEoGPobDWpSkfQCeJu69FqsPteLg5JVMOJmzAj60RDzEAz7XOcRvobwhPZdT7Z1mmrqHJrn+Uq6bTv+EZCS8x0eAXMn+ouTN83nuXiWILuTcCYqVOtrMmcuw7n+2QpHof2gqKBIphpN/8ZewwNA5NNCtSIALkhS2nzzeJKH+Q/zY/9Hg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(110136005)(82310400004)(6666004)(2906002)(54906003)(36756003)(508600001)(44832011)(40460700003)(86362001)(36860700001)(47076005)(8936002)(5660300002)(2616005)(336012)(426003)(1076003)(70206006)(70586007)(81166007)(4326008)(8676002)(356005)(16526019)(186003)(26005)(316002)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2022 09:49:51.9161 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c21a181b-bd56-4705-5cbc-08da03447d37
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4193
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
index 47108ed44fbb..67f8efac3180 100644
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
