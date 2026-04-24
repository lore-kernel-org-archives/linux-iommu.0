Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013038.outbound.protection.outlook.com [40.93.201.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A654E272E7C
	for <iommu@lists.linux.dev>; Fri, 24 Apr 2026 09:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777022568; cv=fail; b=esnbWtIFMaC3pU3Lztsjpdqq83eD4B90cjL85aU1he0qkdjHFpPtJrkdygI4N+gMsiNgMrOHOSK1lL/ZHwO1U98163B1Ok8BK5JLqFCto727kq9TUjeo7p+AMyufx566KIAdGgsQG/ute9zL5vEO5PzwxjZ42DEcYcygbSmnm90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777022568; c=relaxed/simple;
	bh=746XmB8CmIZ++YebW02kQX5o6zMQtXIkr90UD+aFeas=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fIt2Gx+labsY41qbS8oxbvvJyu9u/rx9HXbhm69hv/n2EShfRKvzMs9Wx2CGab+dhXVULZmAP2Ap059X//5rT8FvjoJreASaBy2rUyWdLLDNwyRQ8vjE3D8mdnhAc2R23GwwuBIlMsykHwu7NteYfWHoc5kJ4Qx5echQwnBtRJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=au8/AOU5; arc=fail smtp.client-ip=40.93.201.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="au8/AOU5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I378fvGiIDF+fx1HtRW1u57nOTtrW07npXVs5IDIOY/ixRzi7f2RlQ3YE/orwCVj7nsz8zkt2T+biuRGxaGJg6RXJyPbdNLlGNIf89CZZeD8b6d9sXs0G2ZLVmGYH16nXuXclvS4wdrQ7Sj9W4SpBzOIiCYmNt7Zbbzk5NOP8XR5KNrqHBOOasfn7UlofK5PIS2YIV25fmoV4pPYU4kTO5fAw9RAv+QuJ4DRgT5kz6roUCqD5Im8JZSvESeHQOhiTTCdpuDsb8arWtXQ+GdUCT05V+hF6xGelWNa32rGAvhfr6DZiB+4ZJbX5ro+Rf1tAqEESFOJ8c6qocz6ug2Hgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A/UNKhfy7w6O9rv1E3a+qsyCXt4GvTPBuLnJB0w6UDM=;
 b=OYZ/VOfgmCGh73mOoc2d2olOj8rp9N0tDNjILhGelChK0FEftRFgF+UVXSSW2QBmdMtBpBZq29wnavZD7dX88gKL3b4VQ6y7F1n+2tbO2N86VL0I53qRrLeNrVUcbeifV+UE+qSsMCpesykNSuc4zDYwPchzaYa8OsAYapYWD+CkPK2FpxxA29vqyYMp1zU5eLlkaXlzeVykakBzP3iN+BNFtqKkDnxQ6VjWUkE6Fqy7Ehlb63L4D0WPjIToRHdmsswGiC8Di1HrWjCG/7FcSna9SRWFBjHExUcqnBEJpsC8WjteMVO2tmayGd3qHuj57ne5j01tCZPNp1LnLTkzWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A/UNKhfy7w6O9rv1E3a+qsyCXt4GvTPBuLnJB0w6UDM=;
 b=au8/AOU5zQ9qj+vVh/kCZ6wpxC3LcpEA8LZQeC8i/+gvTFrhHCen/X+8MpMyOMGYgNsBuErNfS/42GpXQoB3kkbBYVrEYmMYmBStQz4vlXvUmHFdZXPYEsUONi0A5wtHnylUaDrVEim7wGL0DUlVOh/SL91k8GhgBDvQYzXxpo0=
Received: from CH0PR03CA0432.namprd03.prod.outlook.com (2603:10b6:610:10e::20)
 by SJ0PR12MB5664.namprd12.prod.outlook.com (2603:10b6:a03:42b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Fri, 24 Apr
 2026 09:22:41 +0000
Received: from CH2PEPF0000009C.namprd02.prod.outlook.com
 (2603:10b6:610:10e:cafe::be) by CH0PR03CA0432.outlook.office365.com
 (2603:10b6:610:10e::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.22 via Frontend Transport; Fri,
 24 Apr 2026 09:22:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009C.mail.protection.outlook.com (10.167.244.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Fri, 24 Apr 2026 09:22:40 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 24 Apr
 2026 04:22:36 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <jon.grimm@amd.com>, <vasant.hegde@amd.com>,
	<frank.gorishek@amd.com>, <thomas.lendacky@amd.com>,
	<santosh.shukla@amd.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: [PATCH v2 3/4] iommu/amd: Clean up and simplify IVMD entry handling
Date: Fri, 24 Apr 2026 09:22:12 +0000
Message-ID: <20260424092213.16976-4-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260424092213.16976-1-suravee.suthikulpanit@amd.com>
References: <20260424092213.16976-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009C:EE_|SJ0PR12MB5664:EE_
X-MS-Office365-Filtering-Correlation-Id: 56cd7ec5-ded0-46f7-ce21-08dea1e30880
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|82310400026|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	RndLC0jxfeyPm4au7rcVCyfO4MqMhqlkrDGqnZ8Dy+a13bBEpuakrOso3PixnNk7y3T2JmtfV+8wnlH8YV/Lho6YlJY2ja6uINr7+gJafufeE7akT6G47R0OSrV91QGM/QKx9GhQHcuU8YRzbh+nk+8ADNLAyYxEliEh6+nmWoxcxS7YlrfqzqGUDdycGKE0XKyKBKG0uasbpY+UgGh18Ycjk12wN/nDKBtyMO7qZI0fkCdljKVIUxHVRgJr9qpQlUgIcr4Fr6kM4SYkM9Ii/LxMUFf7aDo+RDnXfoH+mFo9Hs/JPbr4YvwthMG8DbnXql1VDWfUXfklq8vdSMBYWQZe4qeiX0IvCdeg/+DEYHdFf9p1AkNszWOj1CX/U0rtLoNrqihZyvXqaT+VJjvNvkZUhreloAjrUuTcwaYWRyW6qRkKryIvZItOZsrGQlfY1ZCKvU1JscmY7IKu6jzIcBIWAOe3ekly40ZfQnjeE/UxIo1YSYgZRoJ74Jslr8eFmsqEV32ft10uepdt3Wo0hESK6xCQHvGFD60dlBBdKJyZrKyPL/0OjMtaM31O1qJF1F6OzTZv1Z3jySoBhSfnoXdwcBIWVzczgGcApk9MJSoahJmNiKiOAbE6qb4xihE2cMWnebMRPpj+0AxvrETdTG7ZSAE91r7/6vFwPiga5/vwzxwcwGUcOsuENffV5KFBZKuPEOhoCpriy/eUpUppvusNhx6WzTvdaQBlxA8GlP7vIC7hQcXwMYfVWTBx5Ax8EfK2NEDVG+Mg+pBuxSIe/A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	os1a4TowmK2EwMdnzU7Xn9KNvyXAcjU7TS1QTraZlAJ/X5IYl6K9wjNbq2JOg95LLlf/TWaoDL+MinrVKW4eW80eT3oQ49zHkkXbUTZPU3i+GxDkHCYZOh59WqDD9b9vKafU24xw6bb3P5kdYek8EzWxGZ8JuYhzZ66IQ5stQDCpHUFJmgOVYRhBkH+awkDBL0SQhkWiI1Vsp9Up8JaRPrng70qJUJBcRZTyAnnfNArOEIWqX1tCDBwtbu3HW9XgxnC3LSWHX9UZOtYfOD6yW/1ZbWL4Z2NtUqi8c5I4uI92ZHwdwGRJeAzd8RloqvqY+ohNTKWvzU+eEfliTSGGpYWwfH1QlPI4OiOv/Ml+XX83rMb8EvWDULBvHh9OyLldt/jm8REH7nO8s4mkth6JVuVOCxIPQgf5ph5ixFCZ6NcQ3edukBLPOaYUzWKveyKl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 09:22:40.4960
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56cd7ec5-ded0-46f7-ce21-08dea1e30880
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5664

Clean up IVMD ACPI flags and mask in amd_iommu_types.h, and drop the
IOMMU_PROT_* / IOMMU_UNITY_MAP_FLAG_EXCL_RANGE, which only existed
to carry IVMD semantics.

Rename unity_map_entry and unity_map to ivmd_entry and ivmd_entry_map,
store the raw IVMD flags byte from the ACPI table instead of shifting
protection into a separate int, and derive IOMMU reserved regions from
those flags in amd_iommu_get_resv_regions(). Also, rename struct
list_head unity_map to ivmd_entry_map along with renaming the unity-map
helper functions.

Lastyly, add error message when handling invalid IVMD entry.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 18 +++++++------
 drivers/iommu/amd/init.c            | 39 +++++++++++++----------------
 drivers/iommu/amd/iommu.c           | 27 ++++++++++++++++----
 3 files changed, 49 insertions(+), 35 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 6b0f1b05aa47..9321b7cc200b 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -375,9 +375,11 @@
 /* DTE[128:179] | DTE[184:191] */
 #define DTE_DATA2_INTR_MASK	~GENMASK_ULL(55, 52)
 
-#define IOMMU_PROT_MASK 0x03
-#define IOMMU_PROT_IR 0x01
-#define IOMMU_PROT_IW 0x02
+#define IVMD_FLAG_UNITY		BIT(0)
+#define IVMD_FLAG_IR		BIT(1)
+#define IVMD_FLAG_IW		BIT(2)
+#define IVMD_FLAG_EXCL		BIT(3)
+#define IVMD_FLAG_MASK		GENMASK_U32(3, 0)
 
 /* IOMMU capabilities */
 #define IOMMU_CAP_IOTLB   24
@@ -613,11 +615,11 @@ struct amd_iommu_pci_seg {
 	u16 *alias_table;
 
 	/*
-	 * A list of required unity mappings we find in ACPI. It is not locked
+	 * A list of required IVMD entry we find in ACPI. It is not locked
 	 * because as runtime it is only read. It is created at ACPI table
 	 * parsing time.
 	 */
-	struct list_head unity_map;
+	struct list_head ivmd_entry_map;
 };
 
 /*
@@ -873,7 +875,7 @@ struct ivhd_dte_flags {
 /*
  * One entry for unity mappings parsed out of the ACPI table.
  */
-struct unity_map_entry {
+struct ivmd_entry {
 	struct list_head list;
 
 	/* starting device id this entry is used for (including) */
@@ -886,8 +888,8 @@ struct unity_map_entry {
 	/* end address to unity map (including) */
 	u64 address_end;
 
-	/* required protection */
-	int prot;
+	/* IVMD flags for the entry */
+	u8 flags;
 };
 
 /*
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 2e854f4639a7..4b62bb89a12c 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -70,11 +70,6 @@
 #define IVHD_FLAG_RESPASSPW_EN_MASK     0x04
 #define IVHD_FLAG_ISOC_EN_MASK          0x08
 
-#define IVMD_FLAG_EXCL_RANGE            0x08
-#define IVMD_FLAG_IW                    0x04
-#define IVMD_FLAG_IR                    0x02
-#define IVMD_FLAG_UNITY_MAP             0x01
-
 #define ACPI_DEVFLAG_INITPASS           0x01
 #define ACPI_DEVFLAG_EXTINT             0x02
 #define ACPI_DEVFLAG_NMI                0x04
@@ -134,7 +129,7 @@ struct ivhd_entry {
 
 /*
  * An AMD IOMMU memory definition structure. It defines things like exclusion
- * ranges for devices and regions that should be unity mapped.
+ * ranges, unity mapping for devices and regions.
  */
 struct ivmd_header {
 	u8 type;
@@ -1708,7 +1703,7 @@ static struct amd_iommu_pci_seg *__init alloc_pci_segment(u16 id,
 
 	pci_seg->id = id;
 	init_llist_head(&pci_seg->dev_data_list);
-	INIT_LIST_HEAD(&pci_seg->unity_map);
+	INIT_LIST_HEAD(&pci_seg->ivmd_entry_map);
 	list_add_tail(&pci_seg->list, &amd_iommu_pci_seg_list);
 
 	if (alloc_dev_table(pci_seg))
@@ -2301,8 +2296,8 @@ static int __init amd_iommu_init_pci(void)
 	}
 
 	/*
-	 * Order is important here to make sure any unity map requirements are
-	 * fulfilled. The unity mappings are created and written to the device
+	 * Order is important here to make sure any ivmd map requirements are
+	 * fulfilled. The ivmd mappings are created and written to the device
 	 * table during the iommu_init_pci() call.
 	 *
 	 * After that we call init_device_table_dma() to make sure any
@@ -2588,28 +2583,28 @@ static int iommu_init_irq(struct amd_iommu *iommu)
  *
  * The next functions belong to the third pass of parsing the ACPI
  * table. In this last pass the memory mapping requirements are
- * gathered (like exclusion and unity mapping ranges).
+ * gathered (like exclusion and ivmd mapping ranges).
  *
  ****************************************************************************/
 
-static void __init free_unity_maps(void)
+static void __init free_ivmd_maps(void)
 {
-	struct unity_map_entry *entry, *next;
+	struct ivmd_entry *entry, *next;
 	struct amd_iommu_pci_seg *p, *pci_seg;
 
 	for_each_pci_segment_safe(pci_seg, p) {
-		list_for_each_entry_safe(entry, next, &pci_seg->unity_map, list) {
+		list_for_each_entry_safe(entry, next, &pci_seg->ivmd_entry_map, list) {
 			list_del(&entry->list);
 			kfree(entry);
 		}
 	}
 }
 
-/* called for unity map ACPI definition */
-static int __init init_unity_map_range(struct ivmd_header *m,
-				       struct acpi_table_header *ivrs_base)
+/* called for ivmd map ACPI definition */
+static int __init init_ivmd_map_range(struct ivmd_header *m,
+				      struct acpi_table_header *ivrs_base)
 {
-	struct unity_map_entry *e = NULL;
+	struct ivmd_entry *e = NULL;
 	struct amd_iommu_pci_seg *pci_seg;
 	char *s;
 
@@ -2642,7 +2637,7 @@ static int __init init_unity_map_range(struct ivmd_header *m,
 	}
 	e->address_start = PAGE_ALIGN(m->range_start);
 	e->address_end = e->address_start + PAGE_ALIGN(m->range_length);
-	e->prot = m->flags >> 1;
+	e->flags = m->flags;
 
 	DUMP_printk("%s devid_start: %04x:%02x:%02x.%x devid_end: "
 		    "%04x:%02x:%02x.%x range_start: %016llx range_end: %016llx"
@@ -2653,7 +2648,7 @@ static int __init init_unity_map_range(struct ivmd_header *m,
 		    PCI_SLOT(e->devid_end), PCI_FUNC(e->devid_end),
 		    e->address_start, e->address_end, m->flags);
 
-	list_add_tail(&e->list, &pci_seg->unity_map);
+	list_add_tail(&e->list, &pci_seg->ivmd_entry_map);
 
 	return 0;
 }
@@ -2669,8 +2664,8 @@ static int __init init_memory_definitions(struct acpi_table_header *table)
 
 	while (p < end) {
 		m = (struct ivmd_header *)p;
-		if (m->flags & (IVMD_FLAG_UNITY_MAP | IVMD_FLAG_EXCL_RANGE))
-			init_unity_map_range(m, table);
+		if (m->flags & (IVMD_FLAG_UNITY | IVMD_FLAG_EXCL))
+			init_ivmd_map_range(m, table);
 
 		p += m->length;
 	}
@@ -3115,7 +3110,7 @@ static bool __init check_ioapic_information(void)
 static void __init free_dma_resources(void)
 {
 	amd_iommu_pdom_id_destroy();
-	free_unity_maps();
+	free_ivmd_maps();
 }
 
 static void __init ivinfo_init(void *ivrs)
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 4e7f5b993c65..b26d29cb2d66 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3050,7 +3050,7 @@ static void amd_iommu_get_resv_regions(struct device *dev,
 				       struct list_head *head)
 {
 	struct iommu_resv_region *region;
-	struct unity_map_entry *entry;
+	struct ivmd_entry *entry;
 	struct amd_iommu *iommu;
 	struct amd_iommu_pci_seg *pci_seg;
 	int devid, sbdf;
@@ -3063,25 +3063,42 @@ static void amd_iommu_get_resv_regions(struct device *dev,
 	iommu = get_amd_iommu_from_dev(dev);
 	pci_seg = iommu->pci_seg;
 
-	list_for_each_entry(entry, &pci_seg->unity_map, list) {
+	list_for_each_entry(entry, &pci_seg->ivmd_entry_map, list) {
 		int type, prot = 0;
 		size_t length;
 
 		if (devid < entry->devid_start || devid > entry->devid_end)
 			continue;
 
+		/*
+		 * IVMD_FLAG_UNITY, IVMD_FLAG_IR, IVMD_FLAG_IW are ignored if
+		 * IVMD_FLAG_EXCL is set.
+		 */
+		if ((entry->flags & IVMD_FLAG_EXCL) &&
+		    (entry->flags & (IVMD_FLAG_UNITY | IVMD_FLAG_IR | IVMD_FLAG_IW)))
+			pr_err(FW_BUG "%s: Invalid IVMD flags combination: %#02x for sbdf=%#x. Ignore IW/IR/Unity flags\n",
+			       __func__, entry->flags, sbdf);
+
+		if (entry->flags & ~IVMD_FLAG_MASK)
+			pr_err("%s: Unknown flags: %#02x for sbdf=%#x\n",
+			       __func__, entry->flags & ~IVMD_FLAG_MASK, sbdf);
+
 		type   = IOMMU_RESV_DIRECT;
 		length = entry->address_end - entry->address_start;
-		if (entry->prot & IOMMU_PROT_IR)
+		if (entry->flags & IVMD_FLAG_IR)
 			prot |= IOMMU_READ;
-		if (entry->prot & IOMMU_PROT_IW)
+		if (entry->flags & IVMD_FLAG_IW)
 			prot |= IOMMU_WRITE;
+		if (entry->flags & IVMD_FLAG_EXCL) {
+ 			type = IOMMU_RESV_RESERVED;
+			prot = 0;
+		}
 
 		region = iommu_alloc_resv_region(entry->address_start,
 						 length, prot, type,
 						 GFP_KERNEL);
 		if (!region) {
-			dev_err(dev, "Out of memory allocating dm-regions\n");
+			pr_err("%s: Out of memory allocating reserved regions for sbdf=%#x\n", __func__, sbdf);
 			return;
 		}
 		list_add_tail(&region->list, head);
-- 
2.34.1

