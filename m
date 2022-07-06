Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049282F3A
	for <iommu@lists.linux.dev>; Wed,  6 Jul 2022 11:43:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DICcoRCbPLAgUSjZrjpklBQyzXuw/bpNdFsTiJTx8jwbM85b6eosUdbW2yfIqrlhsIFm3qh1imG0NjK7bXCofmhUmHsgtS0TW6B5AhM6r4/JJAJda6dVhZs2QtYyr/ivnQZhhGT9DW3mR+BDQe2nMaZzuXpvtBhRR/9O7poMWGZgqvvEd1LUcZJx80Fr+3gKcDIuSdbZWQVA9MQjwKoSkBSM7Zzci9V0rcI6FsoVEzJs6nI6dMfVVAYOYA3/mn83QYNIeyr1UATF8xlQUt0HOO+e603ucBKxnwDQRQkQjX8AJcAEgpoyxkaJc87mlxP7owxDJI6TEvtAiQo2ZyHRxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kPU+HtbhsrLxYONmb1KZU0jiRXYn5SBW4PvA0uExPlI=;
 b=iQZ93vFfYIK95zqua0i0mOlGwmYL/h7dYMsXYN7M3JaUASSFbKtQbYctKDUxKNvfeisB8kzOyn+rchcmQgX4qF9/sqLxsEbPb9VeRKSs1uJiP2AyDVsw5Ql0rUMWzgShNscF1AqbAHDb1K2Fo9p4FsrsaLTKk6Exb0A2J5a9l6bHCzLDF0PevVV3uBS0exwNrIkndD9pCg7VjJYBE8pidJK7u514Bi3cKJsfGnPeqidjWinJkJA8v5V817LKYok2oSLeQLicu7SumqhFwqA8LAkfTaAWJyxLrEcGOK/qTbj8OKRJVul5VEjk3ibPKT4NdvySUic15s8D9BQKSOeNeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kPU+HtbhsrLxYONmb1KZU0jiRXYn5SBW4PvA0uExPlI=;
 b=OeessVGwRWnEREtzbl3ZcMR94NzfRX52MwSP3liwZuEhojo+JnhFFJdFnsVl0M3eQEOjnh1SGSNYN5sQRFnOzmN7dq1MYlwdC71r/7alYgXjwht16H9vN8IB0JbF0Qu1pH94NFw+2zxm39Ybhu6Sgg6hW/ulwwItwE72/EOuoSc=
Received: from BN9PR03CA0564.namprd03.prod.outlook.com (2603:10b6:408:138::29)
 by DM4PR12MB6568.namprd12.prod.outlook.com (2603:10b6:8:8f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.21; Wed, 6 Jul
 2022 11:43:27 +0000
Received: from BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:138:cafe::e8) by BN9PR03CA0564.outlook.office365.com
 (2603:10b6:408:138::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15 via Frontend
 Transport; Wed, 6 Jul 2022 11:43:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT063.mail.protection.outlook.com (10.13.177.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Wed, 6 Jul 2022 11:43:26 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 6 Jul
 2022 06:43:24 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <joro@8bytes.org>, <iommu@lists.linux.dev>
CC: <iommu@lists.linux-foundation.org>, <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v3 RESEND 04/35] iommu/amd: Introduce per PCI segment rlookup table
Date: Wed, 6 Jul 2022 17:07:54 +0530
Message-ID: <20220706113825.25582-5-vasant.hegde@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: b8e1d871-cba8-4af3-567a-08da5f44bda8
X-MS-TrafficTypeDiagnostic: DM4PR12MB6568:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8rceioWH3phIjeczdcnECYDbfLy8K3n7ilFuewr79VTY18Xt8VPP8vbANIHCtgrPyboqM3RXSooi34j2fHPBAiWkOYGZAEUn9m7JQXUMisyHuuaCXYZ0oS3pHfaRMrKKhEIynW1LwnhPQf9Fdwoa1jR5vQ3pwVg9Wxu65hz9wtg+owv9ekRjS+c0viHs9rZ9QrBXNWLpbNW9sW+r4VvvKPIVu/AoVMdBZbrz0rKIpX21ywk/Nq5Etz5qguQEe83L9N2nm7Qlo1CKx+eknPwhegnmvAPwDuj1XyOj5svEbg1JY9EOVbocwCPFPw6/Aelhm/rMvjIUjNqK2DDmesFtQ5o3xx1YJVZUybZrNubbr7Zg/ZOLaJHsSq+n7NzE4HnTwY1TvrdErCc+KyWuzgh8Mdp3B/qQB82+7OV26gX0wX/XINGD8QNlkQ9Jkp0RoRI8OAorQ+d6FM7HZH/WX9vPaVFaq6fhwUESDTM83T5f1Mqk2m1qoDki2p2yCt+6IKZBIkS992OFnYwaKrw+mdraHTwFdMvaDPKo0zbIRwTmmZAGYSiOqWJP6+UdbmdtbDXgsmjMebLK2Z7MnkX3MQ61eYzZNk/JGzERAVIzKvY1Rmkz9hvsoIbgoDZPoqIHlasUW69/vSLAG7YEEQ8SmUO72XJjRzQwcHHm7yx0C9lTF21xBWM68J7AVu1JI3jdlpjIi0baLKPg2bP/xN8Ac+FkymcQJGpK8O+63FfG56Dh1U+eJTFcdVc6USi7YRxoNBtnkVs+P/cLgsuNVrWEH9H7VnTdBl1Zg6+/pGlHk113ubR6cs3y0+nrnI/73gRwZPtIbEeHXR5mEbX4aXShEKgVXqOBjGqCsQTV5+Dcaut9OA/QVbK5FwceTgu81gzVkwdw
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(39860400002)(396003)(346002)(136003)(46966006)(40470700004)(36840700001)(82310400005)(478600001)(336012)(426003)(36860700001)(16526019)(83380400001)(41300700001)(110136005)(36756003)(54906003)(47076005)(316002)(186003)(1076003)(6666004)(40460700003)(44832011)(2616005)(81166007)(4326008)(8676002)(356005)(70206006)(70586007)(26005)(34020700004)(5660300002)(86362001)(8936002)(7696005)(2906002)(40480700001)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 11:43:26.9906
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8e1d871-cba8-4af3-567a-08da5f44bda8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6568
Message-ID: <20220706113754.50-mvhZBst9Lbiz-6O20WIMAR6BkEwXQt32l4ZsZ87o@z>

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

This will replace global rlookup table (amd_iommu_rlookup_table).
Add helper functions to set/get rlookup table for the given device.
Also add macros to get seg/devid from sbdf.

Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h       |  1 +
 drivers/iommu/amd/amd_iommu_types.h | 11 ++++++++
 drivers/iommu/amd/init.c            | 23 +++++++++++++++
 drivers/iommu/amd/iommu.c           | 44 +++++++++++++++++++++++++++++
 4 files changed, 79 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 885570cd0d77..2947239700ce 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -19,6 +19,7 @@ extern int amd_iommu_init_devices(void);
 extern void amd_iommu_uninit_devices(void);
 extern void amd_iommu_init_notifier(void);
 extern int amd_iommu_init_api(void);
+extern void amd_iommu_set_rlookup_table(struct amd_iommu *iommu, u16 devid);
 
 #ifdef CONFIG_AMD_IOMMU_DEBUGFS
 void amd_iommu_debugfs_setup(struct amd_iommu *iommu);
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 422ea87ae4c7..d0ee78c656ff 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -456,6 +456,9 @@ extern bool amdr_ivrs_remap_support;
 /* kmem_cache to get tables with 128 byte alignement */
 extern struct kmem_cache *amd_iommu_irq_cache;
 
+#define PCI_SBDF_TO_SEGID(sbdf)		(((sbdf) >> 16) & 0xffff)
+#define PCI_SBDF_TO_DEVID(sbdf)		((sbdf) & 0xffff)
+
 /* Make iterating over all pci segment easier */
 #define for_each_pci_segment(pci_seg) \
 	list_for_each_entry((pci_seg), &amd_iommu_pci_seg_list, list)
@@ -490,6 +493,7 @@ struct amd_iommu_fault {
 };
 
 
+struct amd_iommu;
 struct iommu_domain;
 struct irq_domain;
 struct amd_irte_ops;
@@ -554,6 +558,13 @@ struct amd_iommu_pci_seg {
 	 * page table root pointer.
 	 */
 	struct dev_table_entry *dev_table;
+
+	/*
+	 * The rlookup iommu table is used to find the IOMMU which is
+	 * responsible for a specific device. It is indexed by the PCI
+	 * device id.
+	 */
+	struct amd_iommu **rlookup_table;
 };
 
 /*
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 5152243593bf..2fb3e1b82e09 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -665,6 +665,26 @@ static inline void free_dev_table(struct amd_iommu_pci_seg *pci_seg)
 	pci_seg->dev_table = NULL;
 }
 
+/* Allocate per PCI segment IOMMU rlookup table. */
+static inline int __init alloc_rlookup_table(struct amd_iommu_pci_seg *pci_seg)
+{
+	pci_seg->rlookup_table = (void *)__get_free_pages(
+						GFP_KERNEL | __GFP_ZERO,
+						get_order(rlookup_table_size));
+	if (pci_seg->rlookup_table == NULL)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static inline void free_rlookup_table(struct amd_iommu_pci_seg *pci_seg)
+{
+	free_pages((unsigned long)pci_seg->rlookup_table,
+		   get_order(rlookup_table_size));
+	pci_seg->rlookup_table = NULL;
+}
+
+
 /*
  * Allocates the command buffer. This buffer is per AMD IOMMU. We can
  * write commands to that buffer later and the IOMMU will execute them
@@ -1491,6 +1511,8 @@ static struct amd_iommu_pci_seg *__init alloc_pci_segment(u16 id)
 
 	if (alloc_dev_table(pci_seg))
 		return NULL;
+	if (alloc_rlookup_table(pci_seg))
+		return NULL;
 
 	return pci_seg;
 }
@@ -1513,6 +1535,7 @@ static void __init free_pci_segments(void)
 
 	for_each_pci_segment_safe(pci_seg, next) {
 		list_del(&pci_seg->list);
+		free_rlookup_table(pci_seg);
 		free_dev_table(pci_seg);
 		kfree(pci_seg);
 	}
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index ac8f81f527b4..b0262b2e749d 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -146,6 +146,50 @@ struct dev_table_entry *get_dev_table(struct amd_iommu *iommu)
 	return dev_table;
 }
 
+static inline u16 get_device_segment(struct device *dev)
+{
+	u16 seg;
+
+	if (dev_is_pci(dev)) {
+		struct pci_dev *pdev = to_pci_dev(dev);
+
+		seg = pci_domain_nr(pdev->bus);
+	} else {
+		u32 devid = get_acpihid_device_id(dev, NULL);
+
+		seg = PCI_SBDF_TO_SEGID(devid);
+	}
+
+	return seg;
+}
+
+/* Writes the specific IOMMU for a device into the PCI segment rlookup table */
+void amd_iommu_set_rlookup_table(struct amd_iommu *iommu, u16 devid)
+{
+	struct amd_iommu_pci_seg *pci_seg = iommu->pci_seg;
+
+	pci_seg->rlookup_table[devid] = iommu;
+}
+
+static struct amd_iommu *__rlookup_amd_iommu(u16 seg, u16 devid)
+{
+	struct amd_iommu_pci_seg *pci_seg;
+
+	for_each_pci_segment(pci_seg) {
+		if (pci_seg->id == seg)
+			return pci_seg->rlookup_table[devid];
+	}
+	return NULL;
+}
+
+static struct amd_iommu *rlookup_amd_iommu(struct device *dev)
+{
+	u16 seg = get_device_segment(dev);
+	u16 devid = get_device_id(dev);
+
+	return __rlookup_amd_iommu(seg, devid);
+}
+
 static struct protection_domain *to_pdomain(struct iommu_domain *dom)
 {
 	return container_of(dom, struct protection_domain, domain);
-- 
2.31.1

