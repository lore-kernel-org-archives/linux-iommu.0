Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.31
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795773952;
	b=A+IEiOT0bDHYZ5ebhfW6dGGJjmw/WdWIfp5O0+HXJryH2XdiDSBETyHvNNEmM4iWT/U5
	 l9Fj4nJ8gZ1nVxP3FylX54HIFDz1MOgaBzL6G7hzxMLlrcGsb9skYS5VJuL1b5FUo/UVy
	 yXJ1rZ/SRCxLKzQYZvlJWa+kDps1piWYobTUIs+fQDwSiNuf0z0xkJ2T1GAQyzJBPDL1x
	 d3AumxkuK6I3arw7PNGUHSeRbRNUsp1zSbnWObr8sTA0z836hXG8qjmoFv6aoSHNJldfY
	 NDZGu8cDUFJTwQoBI/iqPc/MajFdMMgYflLUde3ODhM1YnNezdwd01JJTTS0HlIDOEA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795773952;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=HjZJ4KbnwpNkBgVnzJJv3WlMPtPel4OMYNIsQRhSXhA=;
	b=EV07nDH2m2fSVNnWUKrDXidLGnddQWadPZrLMHOL2gBeLdzP9eZ0nY4FVBy5RUphtbS3
	 efV07um/nB4H8ZkX4XjHtI0+st1B8DmlsWzpjL++MP0+nrX4UmaLvpSOnM5qT/4XPqmuk
	 nncm4hWLgBJRoBEwD82SGWrTA12SYgvteZIKIcUzUgDrE6lZ5U7okfBW0yh0rfIopRnY+
	 MOJnpA5nkKIGkRdi/kkzxPzXB0BG4bG6xvj2k8BfLkmDTH0GTkUYGAyouN222xeFTKHy2
	 +f/Hm8skdcYlJiFoV6vIJBh3Amt3+mw93Z892EzEClo2IncKqk8VJnP26tU0uleUAew==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=kEHqpcn0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.31
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012031.outbound.protection.outlook.com [52.101.48.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA89606A31C
	for <iommu@lists.linux.dev>; Fri, 27 Nov 2026 10:05:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1AA89606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=kEHqpcn0
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kb+tFAjHlyodPYULpX8yMbkDhhM8n+EkK4Ai8Fk5Z97MDQRYREiP8OYLpodyFNQYvJHv7oJD+QZIfUiijNyARzVGk8wkqqPQdfL9yDdTTClqO+XgILrOKghBt9oHt/fuz7QTNrvDpmnZ7YOTV3dtJcYAyvdosE7K7gPOudAZYNq1jHEZS7aV8PmK1W/aLVW5wO1muzVUGmfdibAPpQGKXx96nCYo8ytutpcljhRGZRMJLggjpsiJLqod7oeV/72v1+d8jR9VFZ5BW0COayEulwEJl+du7nWVIVERv5TL6zR2gC0BYEI8tNHy6oXBjPyOSK1xWU89AxEneCD3afZ6hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HjZJ4KbnwpNkBgVnzJJv3WlMPtPel4OMYNIsQRhSXhA=;
 b=xiPD01LFY1TOsPs05tDg4abdh9qo+hJJ+CnmLVQLhLGHHxgWe1GZhdjIVK6ubVzQtElQ61cesOfYXZFvEx57fuc+FsWC62UYwVHZyazo4e5Qx+tY3eoB3ZfIPrp7L8svSg0xzE5PWwx/vun+4LynlgsnemXc+ThD2dIuuwIpyQBVs22Wdy66pX9QM2T/+DDZg+V1sOkY9an5emqGfAiHoGft24MenJ0RLM/pOtXQ/7bXwuOutNkWgpveVoBw8Etr4g9twS+ul/gH8e2n1e1tEBNZpXYPqu4b2NEwsQTlX7ADilczZJuCy0XkdeknxppeJe0ehR9gmQaubCAw+fNJ6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HjZJ4KbnwpNkBgVnzJJv3WlMPtPel4OMYNIsQRhSXhA=;
 b=kEHqpcn0Fmt86zsu/KDYGOM0j/h/1iATiEx8DCuzWt/SOEtcq0HknIpu+UBUjo4ECDoME2xswKnUFPoH316C+tflJtb6mdW73Rl1YkVa3lQbxXon7ax7Z81yk8PJllR8mYg4cejLwV0Ppf5a05Rr8oQ2uWy41tjxWqU8gDQCxv8=
Received: from BN9PR03CA0665.namprd03.prod.outlook.com (2603:10b6:408:10e::10)
 by DM6PR12MB4313.namprd12.prod.outlook.com (2603:10b6:5:21e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Fri, 27 Nov
 2026 10:05:47 +0000
Received: from BN3PEPF0000B373.namprd21.prod.outlook.com
 (2603:10b6:408:10e:cafe::65) by BN9PR03CA0665.outlook.office365.com
 (2603:10b6:408:10e::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.11 via Frontend Transport; Fri,
 27 Nov 2026 10:05:47 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B373.mail.protection.outlook.com (10.167.243.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.0 via Frontend Transport; Fri, 27 Nov 2026 10:05:47 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 27 Nov
 2026 04:05:44 -0600
From: Sairaj Kodilkar <sarunkod@amd.com>
To: "Joerg Roedel (AMD)" <joro@8bytes.org>, Adrian Huang
	<ahuang12@lenovo.com>, Joerg Roedel <jroedel@suse.de>, Robin Murphy
	<robin.murphy@arm.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, "Will
 Deacon" <will@kernel.org>, <iommu@lists.linux.dev>
CC: <Vasant.Hegde@amd.com>, <Suravee.Suthikulpanit@amd.com>, Sairaj Kodilkar
	<sarunkod@amd.com>
Subject: [PATCH v5 3/3] iommu/amd: Rename unity_map symbols to ivmd_entry
Date: Fri, 27 Nov 2026 15:34:14 +0530
Message-ID: <20261127100414.6980-4-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261127100414.6980-1-sarunkod@amd.com>
References: <20261127100414.6980-1-sarunkod@amd.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B373:EE_|DM6PR12MB4313:EE_
X-MS-Office365-Filtering-Correlation-Id: c495d842-e6e2-497e-56df-08df4c6e0219
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|1800799024|36860700016|376014|6133799003|22082099003|18002099003|56012099006|11063799006|261022075727099003|261026140227099003|261022105027099003|261028144727099003|261021121427099003|261009223027099003|261102123227099003|261021123027099003|10067099003|261026121527099003;
X-Microsoft-Antispam-Message-Info:
	1zMtaycyhdDt/SEK7q9gKvD5kOb/rioc0/qIbH4iHFkIyRtveJXCIIWX7VMzGmLjV8hftNc84jUSecT7WyRi0DljZNd/r2ytHOn7d5IXeq2sxYsvaFFzPIfCEyQeOLfHmZxCTxmdRTRKuJOa1guZ+GjiIxzz6M/7nu3yz++DpS+vPlgLPudPsOU8LY52shqVUb6NHVZvhIAciVyMnKdSYPyX3Ww19lmGVvG98HTdAlGf/3RFSuBBx9LJ5RJ9EeWlet7iratn5Y3SR5I0ayE+mbs1/q4dZFu8qWGgCATYlbh1lOIFZmNF810DFK0Uy7xI1GQ69Vex5BTBp3fB7P4+BsW8PvzixH3dDENl+SiRAldV+VtJ3F6Ak9itzLjz3dy1EDBfyhNNqTjMKIozIexOpBlr894EBkP3FjfEqhxLTRgYfJRkATaralD6OFRfXqqiYylZ0KvHV4usH0aWpWEUfMH6/9/xvBI5HEFmyjpU84n8mZqS4DHTvM15Le/qfzDN/xeVCzaaI29sZ+ue/7A5fGdxvu3Zf9kKTssNT6AzBDDPy3NliLy1Qa0JdGJfU1af+HH2frYiI7INsXb9wV0iG/JxAQSX99eJiVab6IvfIjYwEkax2LB4ZvB0lbq0dSgsl1OMbVL7GFQ0HleEYFexb4PPvIXapL69a43h4Uo61+vM9t5SVghAVOIM32Up6gEqiFuVRYBhBr0GnPyUwUbQ3g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(1800799024)(36860700016)(376014)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006)(261022075727099003)(261026140227099003)(261022105027099003)(261028144727099003)(261021121427099003)(261009223027099003)(261102123227099003)(261021123027099003)(10067099003)(261026121527099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qrrxxXMPrrnevFlBNx1bi+N8EW6TuNyZ2Ncq135GB8R9p3u4uLafeUZdm92hHgDL29hS4MTVhCG4/lXipfMp8s2iprYTaXMq8H1IkagGtOE0Fn45N7X2PjybhFU/2fACvtuus0ytstQfFUIcdjYjJfgm22+hwsI82VCohFlwZdWVsH9PD4g5fzelt0z9oPyclrofw7uikuoueB75GEBLxD8Jz5PNVgLlaZDeJPvA1LA9S/dY69Cq+oWGhqWfN5rc7n9A2KuP3J1xZtzQX+T7GARQ6Sg4nVxVZXGAOjpdgLYkKby75SDE4Z1t2s3xDBDhNVLh3JGGhBji882Pl0dw47VJkXLQuxui95As0kHz09PPmkkA4CRMNI4xKoCcuGoZK4K1aHXsQMrUVsSUipma47Uk/LsEBrbqEhVRgQWGlK/6p6T4vmHFpFRZPGRQzaYZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 10:05:47.4829
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c495d842-e6e2-497e-56df-08df4c6e0219
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B373.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4313

Rename unity_map_entry, unity_map, free_unity_maps, init_unity_map_range to
ivmd_entry, ivmd_entry_list, free_ivmd_entry_list, init_ivmd_entry
respectively.

No functional change intended.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 12 ++++++------
 drivers/iommu/amd/init.c            | 30 ++++++++++++++---------------
 drivers/iommu/amd/iommu.c           |  6 +++---
 3 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 0f4c3c65188c..f4790af97d6e 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -615,11 +615,11 @@ struct amd_iommu_pci_seg {
 	u16 *alias_table;
 
 	/*
-	 * A list of required unity mappings we find in ACPI. It is not locked
+	 * A list of required IVMD mappings we find in ACPI. It is not locked
 	 * because as runtime it is only read. It is created at ACPI table
 	 * parsing time.
 	 */
-	struct list_head unity_map;
+	struct list_head ivmd_entry_list;
 };
 
 /*
@@ -877,9 +877,9 @@ struct ivhd_dte_flags {
 };
 
 /*
- * One entry for unity mappings parsed out of the ACPI table.
+ * One entry for unity/exclusion ranges parsed out of the ACPI table.
  */
-struct unity_map_entry {
+struct ivmd_entry {
 	struct list_head list;
 
 	/* starting device id this entry is used for (including) */
@@ -887,9 +887,9 @@ struct unity_map_entry {
 	/* end device id this entry is used for (including) */
 	u16 devid_end;
 
-	/* start address to unity map (including) */
+	/* start address to unity/exclusion range (including) */
 	u64 address_start;
-	/* end address to unity map (including) */
+	/* end address to unity/exclusion range (including) */
 	u64 address_end;
 
 	/* IVMD flags for the entry */
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 6d92fb5c81a7..46483fdfba82 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -132,7 +132,7 @@ int amd_iommu_pprlog_size = PPRLOG_SIZE_DEF;
 
 /*
  * An AMD IOMMU memory definition structure. It defines things like exclusion
- * ranges for devices and regions that should be unity mapped.
+ * ranges, unity mapping for device and regions.
  */
 struct ivmd_header {
 	u8 type;
@@ -1796,7 +1796,7 @@ static struct amd_iommu_pci_seg *__init alloc_pci_segment(u16 id,
 
 	pci_seg->id = id;
 	init_llist_head(&pci_seg->dev_data_list);
-	INIT_LIST_HEAD(&pci_seg->unity_map);
+	INIT_LIST_HEAD(&pci_seg->ivmd_entry_list);
 	list_add_tail(&pci_seg->list, &amd_iommu_pci_seg_list);
 
 	if (alloc_dev_table(pci_seg))
@@ -2425,8 +2425,8 @@ static int __init amd_iommu_init_pci(void)
 	}
 
 	/*
-	 * Order is important here to make sure any unity map requirements are
-	 * fulfilled. The unity mappings are created and written to the device
+	 * Order is important here to make sure any ivmd map requirements are
+	 * fulfilled. The ivmd mappings are created and written to the device
 	 * table during the iommu_init_pci() call.
 	 *
 	 * After that we call init_device_table_dma() to make sure any
@@ -2712,28 +2712,28 @@ static int iommu_init_irq(struct amd_iommu *iommu)
  *
  * The next functions belong to the third pass of parsing the ACPI
  * table. In this last pass the memory mapping requirements are
- * gathered (like exclusion and unity mapping ranges).
+ * gathered (like exclusion and ivmd mapping ranges).
  *
  ****************************************************************************/
 
-static void __init free_unity_maps(void)
+static void __init free_ivmd_entry_list(void)
 {
-	struct unity_map_entry *entry, *next;
+	struct ivmd_entry *entry, *next;
 	struct amd_iommu_pci_seg *p, *pci_seg;
 
 	for_each_pci_segment_safe(pci_seg, p) {
-		list_for_each_entry_safe(entry, next, &pci_seg->unity_map, list) {
+		list_for_each_entry_safe(entry, next, &pci_seg->ivmd_entry_list, list) {
 			list_del(&entry->list);
 			kfree(entry);
 		}
 	}
 }
 
-/* called for unity map ACPI definition */
-static int __init init_unity_map_range(struct ivmd_header *m,
-				       struct acpi_table_header *ivrs_base)
+/* called for ivmd entry mapping in IVRS */
+static int __init init_ivmd_entry(struct ivmd_header *m,
+				  struct acpi_table_header *ivrs_base)
 {
-	struct unity_map_entry *e = NULL;
+	struct ivmd_entry *e = NULL;
 	struct amd_iommu_pci_seg *pci_seg;
 	char *s;
 
@@ -2796,7 +2796,7 @@ static int __init init_unity_map_range(struct ivmd_header *m,
 		    PCI_SLOT(e->devid_end), PCI_FUNC(e->devid_end),
 		    e->address_start, e->address_end, m->flags);
 
-	list_add_tail(&e->list, &pci_seg->unity_map);
+	list_add_tail(&e->list, &pci_seg->ivmd_entry_list);
 
 	return 0;
 }
@@ -2825,7 +2825,7 @@ static int __init init_memory_definitions(struct acpi_table_header *table)
 		if (!ivrs_block_type_ivmd(m->type))
 			continue;
 		if (m->flags & (IVMD_FLAG_UNITY_MAP | IVMD_FLAG_EXCL_RANGE))
-			init_unity_map_range(m, table);
+			init_ivmd_entry(m, table);
 	}
 
 	return 0;
@@ -3299,7 +3299,7 @@ static bool __init check_ioapic_information(void)
 static void __init free_dma_resources(void)
 {
 	amd_iommu_pdom_id_destroy();
-	free_unity_maps();
+	free_ivmd_entry_list();
 }
 
 static void __init ivinfo_init(void *ivrs)
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index a417bfce0c89..493c66b6b794 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3131,7 +3131,7 @@ static void amd_iommu_get_resv_regions(struct device *dev,
 				       struct list_head *head)
 {
 	struct iommu_resv_region *region;
-	struct unity_map_entry *entry;
+	struct ivmd_entry *entry;
 	struct amd_iommu *iommu;
 	struct amd_iommu_pci_seg *pci_seg;
 	int devid, sbdf;
@@ -3144,7 +3144,7 @@ static void amd_iommu_get_resv_regions(struct device *dev,
 	iommu = get_amd_iommu_from_dev(dev);
 	pci_seg = iommu->pci_seg;
 
-	list_for_each_entry(entry, &pci_seg->unity_map, list) {
+	list_for_each_entry(entry, &pci_seg->ivmd_entry_list, list) {
 		int type, prot = 0;
 		size_t length;
 
@@ -3182,7 +3182,7 @@ static void amd_iommu_get_resv_regions(struct device *dev,
 						 length, prot, type,
 						 GFP_KERNEL);
 		if (!region) {
-			dev_err(dev, "Out of memory allocating dm-regions\n");
+			dev_err(dev, "Out of memory allocating reserved regions\n");
 			return;
 		}
 		list_add_tail(&region->list, head);
-- 
2.34.1

