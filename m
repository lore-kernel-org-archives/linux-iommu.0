Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011004.outbound.protection.outlook.com [52.101.52.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469CC37CD5C
	for <iommu@lists.linux.dev>; Mon, 20 Apr 2026 17:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776704467; cv=fail; b=iW9E/RX2gsaMDEpZgaR+23ycGc7kvBzvW7epVqmpb3/CcyfmmBU9LQR+w3hZkBj2piN18GkFhYMtyAnCwIYUkzHOvCcYYJH1Wyp2WrObNT8FeYve0XUaNW1+V43eYPwNRRDpCxof7lHRJq5HI8w+USmv7UIXqiw3jkBW7d9yvE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776704467; c=relaxed/simple;
	bh=5N+z/NAtHHOJ2PoYvk7Iel9de4lyEoY9c/9OKCHPsMQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kgMflvg/4Ej0+Vv02dXN0prLTdMANwoQDg7az9rYPYERJtl/DmNVKgklnGqXgiEe0Urpnpcteo1N/j5sUouhZDrxc3f7IShFkm+PviBPEn4hCV4qjpSMCZzxpgUJm7rIJ1tc2aWDT8/GQFdXnapo9/WLmvcYo45CZ7Gr1WFK1kE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DwpmMfGv; arc=fail smtp.client-ip=52.101.52.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DwpmMfGv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dpmKNtdECgSRViKYEs5iXUV6puHwu5vwI+GmRR5XaMUGkXbOLAJU+rJYC+8OjyTTL1UUgexZQPCzcO35bGp7i5eVXmP/xia9HBBccmaZN+gnt3OOUmKOiM/Uf4/AamgaLQo0QIFwHnoB5XbJu0eOKPnXb2OJyd3zaRifBquzt3WdFL6Ecp5YGyuhdHbWvU7WBUeVqSrCMAE2dSY6alByv5nAqsdtuXFqiKfeOh9jr6jnIPt17RQUNPu7RdXp+MAMX7abqctE0+fOz2U8CoBAO4cjQ8bBvV3XPt9/u4WREBcDLWHZLMCvj2jvbdCm1TFzqygTH1vTljB9EnbWxM0kJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GGLnSAye/42oS+36ZDVC9FGVqw1cGJPaEMA9poaSuPs=;
 b=JDYMYempSQLGoX9hYmlGUNqKB8H/jRO9KDMyt9idQJExLB7WpHzRvPY/HgmbfUHii+TVnEuD7pUUH5VnA6FsOQMeLefIeD1ZypdF7rlbmSridD/LDbG16gtpn5EMzwcxGhbGxetRTGfLLFALgJuQRx33ygUbUi6iq2rtA8ONJwQ6koWHU75MgZqwDeIQRaj2//BxPpDx1aePjAiUpDxdkVaZvKBXFXUHJ+5KYIuZJoe/O6CTlA7oa7/bwtt9B2kdtj4/I48nPiSMy+C4vFMz8OuRzK5Idkazz9B/+W/tVo+8158lYSoon1NVvo1YWScGh4YfWCNVSIyT9LwQwOlH6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GGLnSAye/42oS+36ZDVC9FGVqw1cGJPaEMA9poaSuPs=;
 b=DwpmMfGvORO0pPfJJMBFDN/ZX2EueYYhMnSg3NaaLCdNN+bQiwu8S93qdCHxodjHDNdRFpk7INmiTDYIeTd10iLsigV+BhEH/3dY9o5Q1mEmihzlNTUHCGWO5aPBdsDIlEwjWAFUbdno3H11kW/MUJt9rmY3boGNDYyyT2aO+j0=
Received: from MN0P222CA0028.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:531::30)
 by IA1PR12MB7567.namprd12.prod.outlook.com (2603:10b6:208:42d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Mon, 20 Apr
 2026 17:01:00 +0000
Received: from BL02EPF0001A106.namprd05.prod.outlook.com
 (2603:10b6:208:531:cafe::97) by MN0P222CA0028.outlook.office365.com
 (2603:10b6:208:531::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Mon,
 20 Apr 2026 17:01:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A106.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.48 via Frontend Transport; Mon, 20 Apr 2026 17:01:00 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 20 Apr
 2026 12:00:57 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <jon.grimm@amd.com>, <vasant.hegde@amd.com>,
	<frank.gorishek@amd.com>, <thomas.lendacky@amd.com>,
	<santosh.shukla@amd.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: [PATCH 3/4] iommu/amd: Clean up and simplify IVMD entry handling
Date: Mon, 20 Apr 2026 17:00:32 +0000
Message-ID: <20260420170033.6780-4-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260420170033.6780-1-suravee.suthikulpanit@amd.com>
References: <20260420170033.6780-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A106:EE_|IA1PR12MB7567:EE_
X-MS-Office365-Filtering-Correlation-Id: 77371ab9-6f97-4b45-cced-08de9efe6642
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|82310400026|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	SE0OyfOfzVWLgaADLO67gzoxA7Dz5FgdLkxROOR97bsIj2HmbtjKi6w42sdR58Au91hXcbdlkIq7BCm2DidE6FSqSNpTlKLvonUlzucswziGVTEsLw4SRdZDzS5+Noi8yJ+WkTCsbYQvmraDPkXKvWzDbYJM+UdR8oet59TsmVIxuW1pcWoDSYcdQqUA1DH6xL0oB2p0IEzLNhQsHUwnDCZPROVwJwJ0u2fxGxY3bBz2DxSLu8e/NHo8I//AgeHoe1stpbDv1dDpSAnzYKkOGJP7dhZUTQ6pgKCqfo7MOgO1+acoMFIYrNtHqXhUwx1v+ucsNvAxuhGxksVwNlZN96rjblvr7l+nDZxrk86CA9ZRCFW8z6x3wfeImFwMlhHkC5i1OStGhk4fNyv0wBNk1MKTgtFfgzwWra1gDDXjuB7KTAkkdizI/kRL60Ai2+K1O3NdWMK6RmOL4mtJElrn1KGOB/CjBocwy1/x9scwc5PSK5EId+eB2BdCeOtGW6IZxRGUBaXzxWehFuYXou7RyP4AZ7h5o2vxZ2L9BrJ5Wi7j0xWeV/oFndFa4cBi/VERb2w6QF0L0CeIdoo4m6Nq9b0/HBIEbL+oy+Dm5+s0xFGGUrFJsHWqSdw6OK5KHHWhWLFp2y/UVpZMW+CFHiavWfowYOce4K4rHBntLdeLsR6rBpE7XB61CBsY+Q6oH7aRN8M7kbsFkD0oBff9S3d0jgUTbBzwkM6p4I21B2uwhkw4Z6hLfvfRonHJbJ+k4nKhEpXqrm9UsKekz9/QzqtbuA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	DarZ8XzRB77YGeTgJj7tThIPtkT6oLuo57fT1O21BxFZxVRklQ4yz8ezutFJnNhaZN6zVMcxirwCtOWG1FgFS7IgRg/U5EtuRdwMG9fpgbCiWBjOm87J/ZcNR/RsHNbSsQWBEyMXtKiOMwdP+ixxZY8E1DbarcNNUEe1eXYpp4EyQLnDVtY/Dc0RT6pOZHeSjtXhNlwo45fLVnL//3qWXmC0OlCm4w3He5CymylIbq3clRbLz8tTd/aLG9/SN15eEW5D5R+FFvDAWNhf02+9IiNfzaQ+T0bme2F4kwvjvs8axhhS+fzoLKWDJ9Rj3v8A1CjqZaL07sRBGt/DIbEZgEmmgEeEEv/iXeR1rUj1WSpf/5p2QiaiadUw3pem6s8q/gn8fLxoAU3kxpNkqx9OHAUdrhzJYNiEpLO2oE84ldK5qNpr8OIcP/RKoo2WcVmW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 17:01:00.7368
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77371ab9-6f97-4b45-cced-08de9efe6642
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A106.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7567

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
 drivers/iommu/amd/amd_iommu_types.h | 20 +++++++--------
 drivers/iommu/amd/init.c            | 39 +++++++++++++----------------
 drivers/iommu/amd/iommu.c           | 28 +++++++++++++++------
 3 files changed, 48 insertions(+), 39 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index c4ea701b7cab..e93b4b857dde 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -376,11 +376,11 @@
 /* DTE[128:179] | DTE[184:191] */
 #define DTE_DATA2_INTR_MASK	~GENMASK_ULL(55, 52)
 
-#define IOMMU_PROT_MASK 0x03
-#define IOMMU_PROT_IR 0x01
-#define IOMMU_PROT_IW 0x02
-
-#define IOMMU_UNITY_MAP_FLAG_EXCL_RANGE	(1 << 2)
+#define IVMD_FLAG_UNITY		BIT(0)
+#define IVMD_FLAG_IR		BIT(1)
+#define IVMD_FLAG_IW		BIT(2)
+#define IVMD_FLAG_EXCL		BIT(3)
+#define IVMD_FLAG_MASK		GENMASK_U32(3, 0)
 
 /* IOMMU capabilities */
 #define IOMMU_CAP_IOTLB   24
@@ -616,11 +616,11 @@ struct amd_iommu_pci_seg {
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
@@ -876,7 +876,7 @@ struct ivhd_dte_flags {
 /*
  * One entry for unity mappings parsed out of the ACPI table.
  */
-struct unity_map_entry {
+struct ivmd_entry {
 	struct list_head list;
 
 	/* starting device id this entry is used for (including) */
@@ -889,8 +889,8 @@ struct unity_map_entry {
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
index 760d5f4623b5..fc3389ded01a 100644
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
@@ -3063,28 +3063,42 @@ static void amd_iommu_get_resv_regions(struct device *dev,
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
-		if (entry->prot & IOMMU_UNITY_MAP_FLAG_EXCL_RANGE)
-			/* Exclusion range */
+		if (entry->flags & IVMD_FLAG_EXCL) {
 			type = IOMMU_RESV_RESERVED;
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

