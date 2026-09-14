Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010009.outbound.protection.outlook.com [52.101.61.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE21396D2C
	for <iommu@lists.linux.dev>; Mon, 14 Sep 2026 18:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789411780; cv=fail; b=DB1+SiFsot3FyRO5Rx80QsyTr1jG5gPs3cF3fhV6YjutqYj95HtPIhmg/Zcvtk3GIIFNjbmHQKKDId8NoE5m/qA8ftOm5z3bJPGv0Yw0G5sDcb71yHXoNejAkDZ/3no+Vrv+4i61jvXw/JXteD50Gy18aIYPyzRaZB/oXgyqVgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789411780; c=relaxed/simple;
	bh=e5Nlmsl0PLoT0fEBfl8DglwacN3sLpN/2yoINmGM88c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J9xmMYp0VEfwRGdk/VAglN8ku79M3IZfbkCrHSPWHeMWat/Ho2weS6+Fi1lGzT6yA2Yz4NsX2XBsvqsI4roFaViEMG6y+xHNp3Njf7pyvPxoqNLr/7+19ycsbx7Y7Xvf32F81Kap9rCovufgZ4Gmvb59hhuLTmNfP9xWVNGqvjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=okExYO5i; arc=fail smtp.client-ip=52.101.61.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="okExYO5i"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nxc/r0fi31ctjGIDwxD8DS4QgUko4X5BO+Xx7dBhy6HmXLYuh5hq7MdwRcudRhSlUIgE1t0LMLZTbnNDFwRJNxVpj5YasOUHASi6RX3GZnWSIgs5AREEmc3dOv4y3ljyioanW+v6QH/Yyof1u/C9yAKFtqjEjTGFV31Xb1d21DrudaHJDJv9H4ajoO1eYYSmX2fM+U4QEtkfJ6sTwnyAECpnZH99mGdFdW8TL8gpVVraPpy8oCrM0X4hFBJm/9gsA9msBz65VfqyxC20O0lQzAEM2Z0kBkgKmjyKFz5stIuxvAgpwmH/A9K8x7qDbtmAX9y7VvzSATdBBALXFHe1hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CmKQoD4fV9QYORxbWFbKh5A/CQe0J8OiT4hJRB/TJT8=;
 b=d2x/L1TA1Z6d9RrZX7yWfV/KxE8hD2KH/EewhZ+dxWJNuBfzs6XVo1BgwY1EN3pj1NaTxUxlLM94f/Dow5MKHsbZFJdlJhcpIeUOnmNyLzZZFkiB4d6MJyLDnh0ocXewBEmJxfhmMCUhF4cnzR1cHdiaLD9/t8Vp+V837xFVk+7yRP0xS20rfRdowrG1EwGjvzdcSjzwqQ2sfyeobmuTrAqLSfwqbWQmzCGVc42OV9gh7SXOBZZhHlRk9hmLWLwc7eAY8WWYXizvu/LKQINv71OWk+M3f9NvsKrmPgVrXPFVd8QWgpYxLXJU8Y5OhOC9/zRiN/dpGb9vzsM1/Rblag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CmKQoD4fV9QYORxbWFbKh5A/CQe0J8OiT4hJRB/TJT8=;
 b=okExYO5iqv40WHSHauufwPa+bJue+gmpKdm+3zf98pwitujICPVMz9frwbk9Cmqk3WQox5AzaIc8ewXVAqntXT9nTWAUTXS+DspUeCGT6IomdyvDolu5vo0D+iiFi6PvpgGMyScCFtaPHmqPMsZASBjkgaFhHQHNgyZMAWlQbOw=
Received: from BLAPR03CA0144.namprd03.prod.outlook.com (2603:10b6:208:32e::29)
 by MN2PR12MB4269.namprd12.prod.outlook.com (2603:10b6:208:1d4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 18:49:31 +0000
Received: from BL02EPF00021F69.namprd02.prod.outlook.com
 (2603:10b6:208:32e:cafe::86) by BLAPR03CA0144.outlook.office365.com
 (2603:10b6:208:32e::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Mon,
 14 Sep 2026 18:49:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F69.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Mon, 14 Sep 2026 18:49:31 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 14 Sep
 2026 13:49:23 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<Sairaj.K@amd.com>, <jay.chen@amd.com>, <Ming.Shu@amd.com>,
	<SooJin.Tan@amd.com>, <wvw@google.com>, <wnliu@google.com>,
	<dantuluris@google.com>, <chriscli@google.com>, <kpsingh@google.com>,
	<alejandro.j.jimenez@oracle.com>, <joao.m.martins@oracle.com>,
	<guanghuifeng@linux.alibaba.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: [PATCH v5 12/24] iommu/amd: Store per-segment iommu_dev_data in an xarray
Date: Mon, 14 Sep 2026 18:47:38 +0000
Message-ID: <20260914184750.222939-13-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260914184750.222939-1-suravee.suthikulpanit@amd.com>
References: <20260914184750.222939-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F69:EE_|MN2PR12MB4269:EE_
X-MS-Office365-Filtering-Correlation-Id: 068ac2ae-28db-489a-25c3-08df1290e9eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|7416014|376014|1800799024|23010399003|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	9mdTotFSQR6KuBHs22/9MSlfeYBc8BTL0O8gxEwLNtqCTBzZSNehipXBHUlPcA/Qe4yYDCSk1CuwmnW/OT5QlX2K/j/NPA2cZZeHqEGNGnJMUyh3r9g3UdAqt9G9xzw1TW5MD9zFBK2+uvb+BeeWs9xBvk/PWp2rjLTlnQMyrKbSbX7+s6gmc9pwDPzrej2RfD1mjSA2snk0chh/szFERRdFGQrHMR+/ZtltU9+FCYxPkWqt2VxtnK/T+U4+yGsLeMmoWGn2YgtrYxTvhkfiUbFoMKP0GqcephZT3WccJ6+TxXCcDrqGpcjfL4dgwg+BdY+P/wc8rrQQNap/lYF5Sp5waI6+Ho/QHirStRcUlqn3CVI2sN3jJd71Xnt8nsiGr3cEEEZVR5NTabXqzmfj2VO0xBMP2VuRoZgfMmM2T62J1WMzWAShl1CBb0ha/YvHKGM/LN0aCzxC1Nr4cBmfVqNdaG3H9jy1a3Sm/Q76r4RG4PE4pkZThUFJjV6bAywvWjdYYi5HnjfPM5HjcNewNTBXsw3zSggBD8P82f5pz9MJyaUj9HRyHgknmXOU51eX4w0hnPUl5MaY9r15nsY916wGr4sGK5jsZBEZ6BWGHyfZaze6qPygYf0V78CI6/JpFvx72TXW4aGYwqmhjEGWDQxmDxfKF9KB0NAu3tGvBxxHKRYCTtYekHuFqOOU2kv1DCn0zhjfvwqu8Q2VX9we/g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(7416014)(376014)(1800799024)(23010399003)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	N6KkGwM1AJfo6brxLcms1mdFRlFq+6yDYI9XAnyt8tZZOLzHedLQCpFIa83ZioamZDmEmphUPbhdsczhEGQ3M7kU1qcV65b6jJk1X1w9u2UUg+WqsMbNBsNM+ZF51d56RuK1o1iqCrg6UaAb5Jtg969LhD2330AwRUjZdph6hQIwNKP7A9AN06NBDjwrPF97zRHSLSk5Xk2boAWkxiquaiHUKKCksuHZfXD6H6uNhgl04eAgejgQ4lfXNI6aOahrQYKmjoK+kWYNG0r+lKI985jhJiS9AXN+M4FvXm2jRsWNC7OEcM7WyMrL+BtiYzx1nvP4uU/0x1VzAEmKcVzwQubkyyIfAREQUOY9aLL8YvlQAh1wo3eKV17RSuSEZWBd/5jZ5PFrdXnYvnJMypf9k8u75nVtq80nNm6qgyO+Nq6SojZcHwbskBD4vDJXYAxr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 18:49:31.8548
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 068ac2ae-28db-489a-25c3-08df1290e9eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F69.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4269

Replace the per-segment llist of iommu_dev_data with an xarray keyed
by devid so lookup is O(1). These objects stay immortal for the life
of the PCI segment: amd_iommu_release_device() keeps them for replug,
and IRQ/DTE paths look them up locklessly via xa_load().

Same-devid intern on xa_cmpxchg() covers replug and racing
find_dev_data(). Aliases still get separate keys. Intern remains
local to iommu.c; only the lookup table changes.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  6 ++---
 drivers/iommu/amd/init.c            |  4 +++-
 drivers/iommu/amd/iommu.c           | 34 +++++++++++++++--------------
 3 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 9a90b8fe0fe3..d02f49a39a90 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -22,6 +22,7 @@
 #include <linux/irqreturn.h>
 #include <linux/generic_pt/iommu.h>
 #include <linux/idr.h>
+#include <linux/xarray.h>
 
 #include <uapi/linux/iommufd.h>
 
@@ -605,8 +606,8 @@ struct amd_iommu_pci_seg {
 	/* List with all PCI segments in the system */
 	struct list_head list;
 
-	/* List of all available dev_data structures */
-	struct llist_head dev_data_list;
+	/* Immortal iommu_dev_data objects keyed by devid */
+	struct xarray dev_data_xa;
 
 	/* PCI segment number */
 	u16 id;
@@ -861,7 +862,6 @@ struct iommu_dev_data {
 	spinlock_t dte_lock;              /* DTE lock for 256-bit access */
 
 	struct list_head list;		  /* For domain->dev_list */
-	struct llist_node dev_data_list;  /* For global dev_data_list */
 	struct protection_domain *domain; /* Domain the device is bound to */
 	struct gcr3_tbl_info gcr3_info;   /* Per-device GCR3 table */
 	struct device *dev;
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 17d321412dcc..1616fcfd361b 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1737,7 +1737,7 @@ static struct amd_iommu_pci_seg *__init alloc_pci_segment(u16 id,
 		    SZ_4K);
 
 	pci_seg->id = id;
-	init_llist_head(&pci_seg->dev_data_list);
+	xa_init(&pci_seg->dev_data_xa);
 	INIT_LIST_HEAD(&pci_seg->unity_map);
 	list_add_tail(&pci_seg->list, &amd_iommu_pci_seg_list);
 
@@ -1756,6 +1756,7 @@ static struct amd_iommu_pci_seg *__init alloc_pci_segment(u16 id,
 	free_dev_table(pci_seg);
 err_free_pci_seg:
 	list_del(&pci_seg->list);
+	xa_destroy(&pci_seg->dev_data_xa);
 	kfree(pci_seg);
 	return NULL;
 }
@@ -1779,6 +1780,7 @@ static void __init free_pci_segments(void)
 
 	for_each_pci_segment_safe(pci_seg, next) {
 		list_del(&pci_seg->list);
+		xa_destroy(&pci_seg->dev_data_xa);
 		free_irq_lookup_table(pci_seg);
 		free_rlookup_table(pci_seg);
 		free_alias_table(pci_seg);
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index dd2cb79d506f..2b039f38f9ef 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -390,9 +390,14 @@ static struct amd_iommu *rlookup_amd_iommu(struct device *dev)
 	return __rlookup_amd_iommu(seg, PCI_SBDF_TO_DEVID(devid));
 }
 
+/*
+ * Allocate an immortal per-devid object stored in pci_seg->dev_data_xa.
+ * These are never erased: amd_iommu_release_device() keeps them for
+ * replug, and IRQ/DTE paths look them up locklessly via xa_load().
+ */
 static struct iommu_dev_data *alloc_dev_data(struct amd_iommu *iommu, u16 devid)
 {
-	struct iommu_dev_data *dev_data;
+	struct iommu_dev_data *dev_data, *old;
 	struct amd_iommu_pci_seg *pci_seg = iommu->pci_seg;
 
 	dev_data = kzalloc_obj(*dev_data);
@@ -404,26 +409,23 @@ static struct iommu_dev_data *alloc_dev_data(struct amd_iommu *iommu, u16 devid)
 	dev_data->devid = devid;
 	ratelimit_default_init(&dev_data->rs);
 
-	llist_add(&dev_data->dev_data_list, &pci_seg->dev_data_list);
+	old = xa_cmpxchg(&pci_seg->dev_data_xa, devid, NULL, dev_data,
+			 GFP_KERNEL);
+	if (xa_is_err(old)) {
+		kfree(dev_data);
+		return NULL;
+	}
+	if (old) {
+		kfree(dev_data);
+		return old;
+	}
+
 	return dev_data;
 }
 
 struct iommu_dev_data *search_dev_data(struct amd_iommu *iommu, u16 devid)
 {
-	struct iommu_dev_data *dev_data;
-	struct llist_node *node;
-	struct amd_iommu_pci_seg *pci_seg = iommu->pci_seg;
-
-	if (llist_empty(&pci_seg->dev_data_list))
-		return NULL;
-
-	node = pci_seg->dev_data_list.first;
-	llist_for_each_entry(dev_data, node, dev_data_list) {
-		if (dev_data->devid == devid)
-			return dev_data;
-	}
-
-	return NULL;
+	return xa_load(&iommu->pci_seg->dev_data_xa, devid);
 }
 
 static int clone_alias(struct pci_dev *pdev_origin, u16 alias, void *data)
-- 
2.34.1

