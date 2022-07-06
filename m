Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C858C2F3A
	for <iommu@lists.linux.dev>; Wed,  6 Jul 2022 11:42:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L9S/6cGTcc87MpkTf5HXHf5R1ozoLvEtTpRMXsW48N111vcHz2fsY6xs/6tph8Hfrm5oZ3EEAPZNuhVdPiW2nABykdDVC7bfvqypiGpMegVq+efcBnynDknL8VtO9VhpegtYthQ93qMFHtC0gwOP6IvR5zk6u5/LkJ9Bu99wyeMweJDqOYifAJ1cyryFbbWEuV3gn4oO/E8nu6LkefxHCEsJ3YfQAbYduHK3LvliHfnwm2WGg0yUwlOqKaB4UIPKsLbn4IiivcLtSvEA1JYv0aqNF8yFWrBfdB4XdwwICZAIUKIAZN2fcm59p2K9C7NJ+/tXtLM46AcUlNafFozVPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1700QU4VmC1XZBkcZoEixo58D7hnHmQGRQxx7bRjFT4=;
 b=DQpSJFvxIGrdl+bHGaB3jGyM5lbA8DhsNYULL+elqjVV2YHaE+KtAiPtgrZrIi8vvslnBnbxRwOUXJElSQPmaPV1/WlhwW6KbxlmW0oxj5/kwHMkMuM93e99XcUyCn1n/F07YxaAvAg5VNuJyNthhIp1sHbEE4/Yzdu0dwwczCqguLjVo4xcNmqhbTvyLUAmojGW5xDfxJBU3HJR/8j2yBMqFHuopcxBE7ugCTLYCZs4OT3OOJCw4/NrxrZaZBjLe76tTvtXBNHOAAdnFbkXnd4HqWq4ZvP6FE4TQU0Fzk5sUbPBRHNwRnGxTciMKsxCqLgbu9CKalWy37i1hPKWpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1700QU4VmC1XZBkcZoEixo58D7hnHmQGRQxx7bRjFT4=;
 b=uIZT7HxTXQ/cnqFZr08N/6x9Q4uvcBbbo1OSWDNUB52r28IRQHu1tRZNfNB3pfh9uPkjPctWA5x1aT0YedXcAWsuAxHWwjb2re6WaCBWyOdJIlt7cZGRlNwX5CykNGUPPRZW416ICpV3JGxSiwiZywM7fd4HM92PDfZOgJ/aKyE=
Received: from BN0PR02CA0036.namprd02.prod.outlook.com (2603:10b6:408:e5::11)
 by BY5PR12MB4999.namprd12.prod.outlook.com (2603:10b6:a03:1da::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Wed, 6 Jul
 2022 11:42:57 +0000
Received: from BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e5:cafe::fd) by BN0PR02CA0036.outlook.office365.com
 (2603:10b6:408:e5::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14 via Frontend
 Transport; Wed, 6 Jul 2022 11:42:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT051.mail.protection.outlook.com (10.13.177.66) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Wed, 6 Jul 2022 11:42:56 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 6 Jul
 2022 06:42:54 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <joro@8bytes.org>, <iommu@lists.linux.dev>
CC: <iommu@lists.linux-foundation.org>, <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v3 RESEND 02/35] iommu/amd: Introduce pci segment structure
Date: Wed, 6 Jul 2022 17:07:52 +0530
Message-ID: <20220706113825.25582-3-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220706113825.25582-1-vasant.hegde@amd.com>
References: <20220706113825.25582-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b63bf947-4337-4a63-ee77-08da5f44ab90
X-MS-TrafficTypeDiagnostic: BY5PR12MB4999:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RMo6jVsT+p6XQxq+X6CAuFzh/Ehpptqu3I4MEEueCh5PQOa2T+35atqfxfhUjEdL6tPXriy/J3kCcNZa4KhdmVaQ3y9X236O3QeglPXVby0unSpTJEV5km/BZ9n2HTCPt5u90y+EUxx+wzhf6zrY+5tpcr1proPUHiSBRVLHQ5XOh54n0N4nGvkPRh7KtVe059NxlvtD6YR3UdDHTYsXA0sjOM0MPssCBfe+0KON752ERBrqrAPpoTtsqCf1/WJM94Zme7udV6TDN+jArOMJuKGjFXX8gFZ9qJR4zTLdriYmFpCIxLMt+T/gOG2jwA8mxC2NYaK9y9ohvUUyd6+hEHdA1/yYZMnrMaCT7P0+JERAxIQ49uf8lRNSWZowkNUOW0F5nmEL66TdSpRAlPB5Tz8t6AzyAMz+S15r4NO+28k486Qtmcl+6CYu5OsGj7kldW2kOikOvoCeOmyqqq5bculEhuFnkHjQXH/w7i66YnpkOyfg+EnMljkPDNPYBD6YQ8i9PLYKoiQJDjFLsnSZfHfBNmsnbaEVJ3UpaYthsuAN3rSC9Q5FGWxV3dGMfVWNl0/f8jO6NNLAGkQqbAkOTv1ldKNK8ga7POJhYHG5lBvf51FUPheA57Nuway19+MF+NaO/hao/n3LoHUon7Epsh15+fxLfKvjIpq479qQzroIAr6RU6QbtEFlZ5xAHomtBeWbJH5/tjA1izVhsUVu8a4ITl4vIryRp/4TFn11wNWils/TKPiyjOs7YdSL9qgGndcxQ4d2lVWVrE04r+LUJ+QTSjOSGqKMzD+iSg/ZQVBLJX6F/IfK0amwQEUJkmjtNMRP6gfWHJXQV6YrwuGm+Up2QDHhel/vWA2GNUusTDym1LbOfUVDR2dkt8kC2KNd
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(376002)(39860400002)(136003)(40470700004)(46966006)(36840700001)(426003)(34020700004)(82310400005)(83380400001)(336012)(16526019)(47076005)(81166007)(41300700001)(82740400003)(1076003)(40460700003)(356005)(36756003)(36860700001)(316002)(186003)(110136005)(54906003)(44832011)(478600001)(2616005)(8936002)(8676002)(40480700001)(86362001)(70586007)(5660300002)(4326008)(26005)(70206006)(2906002)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 11:42:56.6538
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b63bf947-4337-4a63-ee77-08da5f44ab90
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4999
Message-ID: <20220706113752.ucPfLP6CWDux3vVu2kKLKdZofr9Iv33GlMlfhFIjc84@z>

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
index 9b563f850f1d..2243b1a22d78 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -456,6 +456,11 @@ extern bool amdr_ivrs_remap_support;
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
@@ -530,6 +535,17 @@ struct protection_domain {
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
@@ -581,7 +597,7 @@ struct amd_iommu {
 	u16 cap_ptr;
 
 	/* pci domain of this IOMMU */
-	u16 pci_seg;
+	struct amd_iommu_pci_seg *pci_seg;
 
 	/* start of exclusion range of that IOMMU */
 	u64 exclusion_start;
@@ -709,6 +725,12 @@ extern struct list_head ioapic_map;
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
index 1d08f87e734b..c1b5d530dbf3 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -164,6 +164,7 @@ u16 amd_iommu_last_bdf;			/* largest PCI device id we have
 LIST_HEAD(amd_iommu_unity_map);		/* a list of required unity mappings
 					   we find in ACPI */
 
+LIST_HEAD(amd_iommu_pci_seg_list);	/* list of all PCI segments */
 LIST_HEAD(amd_iommu_list);		/* list of all AMD IOMMUs in the
 					   system */
 
@@ -1458,6 +1459,43 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
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
@@ -1544,8 +1582,14 @@ static void amd_iommu_ats_write_check_workaround(struct amd_iommu *iommu)
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
 
@@ -1566,7 +1610,6 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h)
 	 */
 	iommu->devid   = h->devid;
 	iommu->cap_ptr = h->cap_ptr;
-	iommu->pci_seg = h->pci_seg;
 	iommu->mmio_phys = h->mmio_phys;
 
 	switch (h->type) {
@@ -2611,6 +2654,7 @@ static void __init free_iommu_resources(void)
 	amd_iommu_dev_table = NULL;
 
 	free_iommu_all();
+	free_pci_segments();
 }
 
 /* SB IOAPIC is always on this device in AMD systems */
-- 
2.31.1

