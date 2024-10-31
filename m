Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B6E1C9ECC
	for <iommu@lists.linux.dev>; Thu, 31 Oct 2024 18:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730400193; cv=fail; b=LVu798rVQaA2X79W2RaPbiP45aUs23+euh0ixvEcEXB2cjrLnt919is9oGXjFswcOpeF+A1zELTdKhvIbLDaE2Hx0BOOfGiiXgxH0+o7gOBUtDnmGJV0e7ZlVMvOt9jqhr2jToJSgxV3dqrjEGnTCwxsWupaQRXP5geQKEWKepM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730400193; c=relaxed/simple;
	bh=Vq81mRBYJcs3juIMPOi2BohITasMJmFEoGwurSlLkk0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JF8/4Iy7/RFJbqodAnnfVATzWXZj60szNNl3Hc87iHU2DzZv7d4K+jhTsxNiKx2k/P9P1R16qblOT/aApgu7FBzYVj5nERxmoLkny2weMv37OQ+txF4ImFWs+CyLrRchLZoMRSipFAGTCuovHq8wacS0VwqvX1civCI3nGHN3gg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Jf7GIPeN; arc=fail smtp.client-ip=40.107.237.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Jf7GIPeN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g8hYGq1pmgksSdiWg1NdImGDZjlhstxQsF86tVN0NurbgBFmNNdSYd/qVGTJss52OgjEnoFIHeHD351gG03ZRdYQiiU+Z1cXfl3vU+Pmi62KfnnRckxeQAEgpQV5vPtcgxzRmZD10Fl5owhtCowPMmiZwakVWFJIcyw320b3ouAqlsu/NYCyH7b5Zg4sjX6Kluw8AJGufOlBsyZEzE2uwAxItQTP9ZKELh0W0yY1YLjnE9UTIg6KD1CL/5Kk+bP2N5ZVhPEoTuf12vHq2zXBzeOUV6xhKkpOL8t6Zu2GRZpcR9k+jgyYIUghfUruUbzojeTVc0PeFT/nSEor+RzMYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CEPp+Qb5jbzvUJp0ewDSsOcaVFtsC7Ozi7jNsnnyDIQ=;
 b=QzKFRAakS9MEATRbYw1f48nhI2bziHpazzNHKQ4bYXgQUfU3SM6BEps7fbgadYc0PCEKeXPe9F6JPgMIlfx4ek47t2a9ByUamrGEzE//9cO2XDu/7u1KM/gHPe1Q1u4+fTrXz1P08MRT3Psm50zlOD1hsgrdohaaybgUigv1rlE7ybAFsOvbBrDchIVxsA+njzyo5m05Etyz0yiH5kLCR5c8GYaT2cbnZzqf6Tz6vfTQG29RBAf/S6MH10P78+uUwj/HFeCV5PQT+uMavyLT2JBvSHJIgs0vcp8wyQ//e9Cjx2bYUZGfTNyowHZscCsyjilB6+BmgUr5+nJSVkQ8IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CEPp+Qb5jbzvUJp0ewDSsOcaVFtsC7Ozi7jNsnnyDIQ=;
 b=Jf7GIPeNmPYmr3nnbrPIMkHItIhaPF0dC+OJINXJ3uHLZUayjicS7JP67Qno7yT2oVEjP+t/wzOAUJ2fdPlZtp/lyOjVjIp6n1ZmvC56ss14WaehsSrHaFSf5FWTojPKVAVKqs2zhyNFbFoQfFk89CjV2njrSxFDi60FKCVILFk=
Received: from CH0PR07CA0017.namprd07.prod.outlook.com (2603:10b6:610:32::22)
 by SA3PR12MB8802.namprd12.prod.outlook.com (2603:10b6:806:314::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.27; Thu, 31 Oct
 2024 18:43:05 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:32:cafe::9d) by CH0PR07CA0017.outlook.office365.com
 (2603:10b6:610:32::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.23 via Frontend
 Transport; Thu, 31 Oct 2024 18:43:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Thu, 31 Oct 2024 18:43:05 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 31 Oct
 2024 13:43:01 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
	<jgg@nvidia.com>, <kevin.tian@intel.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <pandoh@google.com>, <kumaranand@google.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v8 01/10] iommu/amd: Misc ACPI IVRS debug info clean up
Date: Thu, 31 Oct 2024 18:42:34 +0000
Message-ID: <20241031184243.4184-2-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241031184243.4184-1-suravee.suthikulpanit@amd.com>
References: <20241031184243.4184-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|SA3PR12MB8802:EE_
X-MS-Office365-Filtering-Correlation-Id: 0461d469-a35c-4ee0-9369-08dcf9dbdb88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?g1tgqlM8ob9K/h4ZkjWl5Xp1ls+eABlBW2cpShDqySA+KUjQg0OFvLgh42Jx?=
 =?us-ascii?Q?c2NZ2xu6yW8keuF4EKj/i+0/wM280ElRZ21dVkqqv4daSlOnLSE/ERJLjbAe?=
 =?us-ascii?Q?PqpIyghKNNqVg4DtTSZe964eOedV7ddszh3HN9d7fvw7qff+LKpiLiB6l5O+?=
 =?us-ascii?Q?GwOlaiQ9QYcYcFrkb8f/jSCjm/wpA/gUgt3ffmpbAi56BQUnVf/KB0pTnILB?=
 =?us-ascii?Q?QEpELjWwmJeHfb+szuVehb3/LBRCPLeGQED1m7HHbnqeMHfzRbRE0ezaP+jW?=
 =?us-ascii?Q?McZznENxTtPU/ogoRyCFq8cn1cxzhgAOJNclK67Ozr97ddrkWfhjjPgRcTsU?=
 =?us-ascii?Q?96CjV7iKL/hcG6i5L7auQc+XZST02wNlplMz1xiTNtJVlYzU/O4SOkS6KaTX?=
 =?us-ascii?Q?E5dTS3lkP6UDDgsmieHg1QSvxF9GMt5qi1sCcDdCQo08OhempEKT+Vpc5+gI?=
 =?us-ascii?Q?MoHAiUZlzMY5t59IXX73UVNJcXISchnoxB9093qGjrAJ/ty1/JZkmGAsUaDV?=
 =?us-ascii?Q?RMHWnXZbVQOOhwwC7NtUuEMhlm7NfwIVVfW0zLW6xD2lO08/fm4KSWlHO5rt?=
 =?us-ascii?Q?gPrDaAPwCa94oOk4n1DgKikVrNVPDLpGYJ0I8r58HLW4BSrhlste6hG1BCD6?=
 =?us-ascii?Q?RyK4lwEPacG21CGXJ/7X2edrO562giYMsUMfH8KrgMfpnvN4tuqCOljjkrAp?=
 =?us-ascii?Q?TqSKY2m0EPOUn7nRQliiLC0uEkzWANeFbU/GwdxBpwkY5u7R1EQOtugRkGOb?=
 =?us-ascii?Q?owrtZem88WM9yguMYYMTdHcuTcoL6BmnKL4Zf0HL2r88VBfy1xl6WRM6EE/7?=
 =?us-ascii?Q?anNVakwlxw8e2K/8S8tcLU/PFyVrTuUy5lJCBZyuW5HzRqYuUtVYfjAmpfo7?=
 =?us-ascii?Q?shSwV2S9A5hQ7YpKlJHBU2Hg/RJW1xL4SsULtzh1ea9hsJMYx5oiB+oI9wvw?=
 =?us-ascii?Q?fuG3MMsWJ8hc0xLnhIbHIjJsQgsES1q4THAQ2LR4EnX9pjxhKgIzMHYVIelV?=
 =?us-ascii?Q?xLgOqTA7qie3X6Ln9vh0cEieL7RnzN/nZVFNGoBRR/nAKs8NRPainYlxFUDR?=
 =?us-ascii?Q?GO3zG2VJ14Q8sa/5GjFko59wWnDIyAWQb9KGxG8h+CHA4gSIuerlCAcY3KWe?=
 =?us-ascii?Q?tXotvtmbDQr+XXf69AixVXyPX59nbuv9PmOFC4gJxG5c6ZVXuzmNpd0YCYGe?=
 =?us-ascii?Q?/Jz84kh2gWdA7aAuuTJrT4fSBqxxPMRKEA2ED648SkVsx7hFm6v0jYNxPIzY?=
 =?us-ascii?Q?naerkb+rmrjE1EftM1JDOb+/P/muNgPeKKcuG81gGLwnP3rSGxfJWg6avZbn?=
 =?us-ascii?Q?+KwWxgfeUliJMUF2kIdz/f9o4FEEhz5zuliR6yM+ONNlxyM8OJklLRlZR11q?=
 =?us-ascii?Q?UWAFaiTyFkhnfesf8iqFPidOpF1LUIcv3vel5yOoZU36viaSQg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 18:43:05.5301
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0461d469-a35c-4ee0-9369-08dcf9dbdb88
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8802

* Remove redundant AMD-Vi prefix.
* Print IVHD device entry settings field using hex value.
* Print root device of IVHD ACPI device entry using hex value.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  2 +-
 drivers/iommu/amd/init.c            | 35 +++++++++++++----------------
 2 files changed, 16 insertions(+), 21 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 601fb4ee6900..dadc65808951 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -468,7 +468,7 @@ extern bool amd_iommu_dump;
 #define DUMP_printk(format, arg...)				\
 	do {							\
 		if (amd_iommu_dump)				\
-			pr_info("AMD-Vi: " format, ## arg);	\
+			pr_info(format, ## arg);	\
 	} while(0);
 
 /* global flag if IOMMUs cache non-present entries */
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 43131c3a2172..aa9bf81a6ec9 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1243,7 +1243,7 @@ static int __init add_acpi_hid_device(u8 *hid, u8 *uid, u32 *devid,
 	entry->cmd_line	= cmd_line;
 	entry->root_devid = (entry->devid & (~0x7));
 
-	pr_info("%s, add hid:%s, uid:%s, rdevid:%d\n",
+	pr_info("%s, add hid:%s, uid:%s, rdevid:%#x\n",
 		entry->cmd_line ? "cmd" : "ivrs",
 		entry->hid, entry->uid, entry->root_devid);
 
@@ -1335,15 +1335,14 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 		switch (e->type) {
 		case IVHD_DEV_ALL:
 
-			DUMP_printk("  DEV_ALL\t\t\tflags: %02x\n", e->flags);
+			DUMP_printk("  DEV_ALL\t\t\tsetting: %#02x\n", e->flags);
 
 			for (dev_i = 0; dev_i <= pci_seg->last_bdf; ++dev_i)
 				set_dev_entry_from_acpi(iommu, dev_i, e->flags, 0);
 			break;
 		case IVHD_DEV_SELECT:
 
-			DUMP_printk("  DEV_SELECT\t\t\t devid: %04x:%02x:%02x.%x "
-				    "flags: %02x\n",
+			DUMP_printk("  DEV_SELECT\t\t\tdevid: %04x:%02x:%02x.%x flags: %#02x\n",
 				    seg_id, PCI_BUS_NUM(e->devid),
 				    PCI_SLOT(e->devid),
 				    PCI_FUNC(e->devid),
@@ -1354,8 +1353,7 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 			break;
 		case IVHD_DEV_SELECT_RANGE_START:
 
-			DUMP_printk("  DEV_SELECT_RANGE_START\t "
-				    "devid: %04x:%02x:%02x.%x flags: %02x\n",
+			DUMP_printk("  DEV_SELECT_RANGE_START\tdevid: %04x:%02x:%02x.%x flags: %#02x\n",
 				    seg_id, PCI_BUS_NUM(e->devid),
 				    PCI_SLOT(e->devid),
 				    PCI_FUNC(e->devid),
@@ -1368,8 +1366,7 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 			break;
 		case IVHD_DEV_ALIAS:
 
-			DUMP_printk("  DEV_ALIAS\t\t\t devid: %04x:%02x:%02x.%x "
-				    "flags: %02x devid_to: %02x:%02x.%x\n",
+			DUMP_printk("  DEV_ALIAS\t\t\tdevid: %04x:%02x:%02x.%x flags: %#02x devid_to: %02x:%02x.%x\n",
 				    seg_id, PCI_BUS_NUM(e->devid),
 				    PCI_SLOT(e->devid),
 				    PCI_FUNC(e->devid),
@@ -1386,9 +1383,7 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 			break;
 		case IVHD_DEV_ALIAS_RANGE:
 
-			DUMP_printk("  DEV_ALIAS_RANGE\t\t "
-				    "devid: %04x:%02x:%02x.%x flags: %02x "
-				    "devid_to: %04x:%02x:%02x.%x\n",
+			DUMP_printk("  DEV_ALIAS_RANGE\t\tdevid: %04x:%02x:%02x.%x flags: %#02x devid_to: %04x:%02x:%02x.%x\n",
 				    seg_id, PCI_BUS_NUM(e->devid),
 				    PCI_SLOT(e->devid),
 				    PCI_FUNC(e->devid),
@@ -1405,8 +1400,7 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 			break;
 		case IVHD_DEV_EXT_SELECT:
 
-			DUMP_printk("  DEV_EXT_SELECT\t\t devid: %04x:%02x:%02x.%x "
-				    "flags: %02x ext: %08x\n",
+			DUMP_printk("  DEV_EXT_SELECT\t\tdevid: %04x:%02x:%02x.%x flags: %#02x ext: %08x\n",
 				    seg_id, PCI_BUS_NUM(e->devid),
 				    PCI_SLOT(e->devid),
 				    PCI_FUNC(e->devid),
@@ -1418,8 +1412,7 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 			break;
 		case IVHD_DEV_EXT_SELECT_RANGE:
 
-			DUMP_printk("  DEV_EXT_SELECT_RANGE\t devid: "
-				    "%04x:%02x:%02x.%x flags: %02x ext: %08x\n",
+			DUMP_printk("  DEV_EXT_SELECT_RANGE\tdevid: %04x:%02x:%02x.%x flags: %#02x ext: %08x\n",
 				    seg_id, PCI_BUS_NUM(e->devid),
 				    PCI_SLOT(e->devid),
 				    PCI_FUNC(e->devid),
@@ -1432,7 +1425,7 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 			break;
 		case IVHD_DEV_RANGE_END:
 
-			DUMP_printk("  DEV_RANGE_END\t\t devid: %04x:%02x:%02x.%x\n",
+			DUMP_printk("  DEV_RANGE_END\t\tdevid: %04x:%02x:%02x.%x\n",
 				    seg_id, PCI_BUS_NUM(e->devid),
 				    PCI_SLOT(e->devid),
 				    PCI_FUNC(e->devid));
@@ -1465,11 +1458,12 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 			else
 				var = "UNKNOWN";
 
-			DUMP_printk("  DEV_SPECIAL(%s[%d])\t\tdevid: %04x:%02x:%02x.%x\n",
+			DUMP_printk("  DEV_SPECIAL(%s[%d])\t\tdevid: %04x:%02x:%02x.%x, flags: %#02x\n",
 				    var, (int)handle,
 				    seg_id, PCI_BUS_NUM(devid),
 				    PCI_SLOT(devid),
-				    PCI_FUNC(devid));
+				    PCI_FUNC(devid),
+				    e->flags);
 
 			ret = add_special_device(type, handle, &devid, false);
 			if (ret)
@@ -1529,11 +1523,12 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 			}
 
 			devid = PCI_SEG_DEVID_TO_SBDF(seg_id, e->devid);
-			DUMP_printk("  DEV_ACPI_HID(%s[%s])\t\tdevid: %04x:%02x:%02x.%x\n",
+			DUMP_printk("  DEV_ACPI_HID(%s[%s])\t\tdevid: %04x:%02x:%02x.%x, flags: %#02x\n",
 				    hid, uid, seg_id,
 				    PCI_BUS_NUM(devid),
 				    PCI_SLOT(devid),
-				    PCI_FUNC(devid));
+				    PCI_FUNC(devid),
+				    e->flags);
 
 			flags = e->flags;
 
-- 
2.34.1

