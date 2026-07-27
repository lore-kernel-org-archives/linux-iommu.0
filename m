Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012055.outbound.protection.outlook.com [52.101.53.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1D240E8DC
	for <iommu@lists.linux.dev>; Mon, 27 Jul 2026 13:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785158995; cv=fail; b=mxQ57H9sEwpKXoNDykrnl0+mjle36XMmasR2d+E9mA/LW8lCAYGw06DHLFztMjxKuZivEPSI6moNm9mdvfWVTIz8ClOeO4ilZbWzFqSAKfgZZvdBelttvHI1koXsknelcNtmyVoCpqLm3f9/rIFKHxm+PqqCYs4rUOUa/EghGEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785158995; c=relaxed/simple;
	bh=21X5BexkEKUnmbyDro3IoHeHmUhI6q9ftvBZP3Nf4ec=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mb7O1bOmgdIrBPowrOBU/KZcrFMf1Ooy33181xtwvzzpcq20zP2NkTWjETcMjCNwMpcaCVJ6j5iE773cmVpTazSR9aSvomQcOXXJk5o9jzZN3U9BXNwqh5Vd31O/SExwfc0nTlyVQYBp2fnL3QERK7djnxqI5rrzu1GtAesUdXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kqf/73CZ; arc=fail smtp.client-ip=52.101.53.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kqf/73CZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rPyfwDxdUTmSgM/YOcwhiwuuVkjZec2xf9U36Wt20OLGjcJfKWwKXUZbQ8mWUehFhw5DG473rB3yv7/DhDP/GGfVY+haj+eODzhak/THFhEM4icNQFrZuO1qjfCuqkU71Nr3dD4QotjWAhh6H9ERQdPMpJyj576LINWMJjwsNkzB8VXiB30q/nM0ZQGhXfAHxv9zKCP9HY5tEjK9IeS9iID9JvdGnzWNBNRULwcy9JAA7KTWzQRk0+P6p+UrHVhoeQ5SY4FcW69CSuKo4RgMoRcvE7eD8xrk+2LHRORX1u6ZG4Qi4tfhqWyxwQabLC8nzTtEg16OciSa4Acq7lA2EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BFK3Tzdw0ETKiHpeMSu98pkrb0NNhikSToE9uH7lRu0=;
 b=jFQwnrSG0RgpLXkGc+lbFVieqLr4nWOOzg6JecIuqAh9/PJINo48bUt/1V1ps0506/FVTNYN36dWprREsOaRtsWagNDoXXk5Yttoe4MQNjj+LNKoXUgFX92Hzk/TLWIr/yLfVJLVna5RgW5/Vo+CXRoH4XbbEUiPktH1jq8b1FZzU+QueMv41Zm+hgy7WHlR9FwZDEF1yN1+igVz2lbOVeYCFEaaVdm9e+dXGZyVF0nMlqvGnhdCi+1gKWCVK74isnGt01rHauXas81qbsqpHcNEEtS+3ayhWw6/v17UAZH4R79VS18GdD9A5zrsmZYNuPKV+wNHbxWxqdsPTU4BqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BFK3Tzdw0ETKiHpeMSu98pkrb0NNhikSToE9uH7lRu0=;
 b=kqf/73CZo9unlZ9NNM1g/UxMD3NkO1Vg70It2E7h8vgzrShpTcrM2RnkSNyC6ggFS2Bn6kL4p2KY6w2FanC4QVn24BlQR8bLUPabpuH/Jm7tKudUaRmAGkfcZpm1p4jYAxKSR5KvdOaloZQVQOiGM4PMvKJnxkd4jEfKtPw69DM=
Received: from SA1PR03CA0010.namprd03.prod.outlook.com (2603:10b6:806:2d3::26)
 by DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 13:29:46 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:806:2d3:cafe::1d) by SA1PR03CA0010.outlook.office365.com
 (2603:10b6:806:2d3::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.13 via Frontend Transport; Mon,
 27 Jul 2026 13:29:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Mon, 27 Jul 2026 13:29:46 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 27 Jul
 2026 08:29:40 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<Sairaj.K@amd.com>, <jay.chen@amd.com>, <wvw@google.com>, <wnliu@google.com>,
	<dantuluris@google.com>, <chriscli@google.com>, <kpsingh@google.com>,
	<alejandro.j.jimenez@oracle.com>, <joao.m.martins@oracle.com>, "Suravee
 Suthikulpanit" <suravee.suthikulpanit@amd.com>
Subject: [PATCH 02/24] iommu/amd: Introduce vIOMMU-specific events and event
Date: Mon, 27 Jul 2026 13:28:51 +0000
Message-ID: <20260727132913.22475-3-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260727132913.22475-1-suravee.suthikulpanit@amd.com>
References: <20260727132913.22475-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|DM6PR12MB4075:EE_
X-MS-Office365-Filtering-Correlation-Id: 70ee2b4b-8eae-44e8-9235-08deebe32026
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|23010399003|7416014|376014|36860700016|6133799003|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	eKWjI9LiUtFWh4RTVOTQSM7JihNHKi7ZwqgnCOf0bSZeg8Tdew03aDGVOHlUBfbZ7dkl8HHxjIMOqLVVrItobiwLSI3Q3PHnnkiozPMU7lNei2nvQ7lfe5pj63wA8LfT9hSf1AgGT27qUaAP10pJcK+dTimUggkB7yi6nO9SD2alciF1t1g4iGAxSitkrNdRjwfr+fsGjOdsZzittZoE6+uhKjoGVg00HVsLvOsPwfkgRTstmriIz19ScpRsiOuieCv1hp07UbqVDbnTmQLAh9XC5mpXppgv4Ao5tGr3HMUAdHPtsNHvnkb5vbZfn9EdbsiuQ9UwgAGTU0L3enDmTbD9oEs+irSdi84LBf2tFwKIbprXSWe8PeMHQLg6tMKjRlvDtP0perzqMECZ0NKgklgQDDCdAO9IMaLImFD5Ip3hbDXNzr5NFxtTxyrM/NRyUMXfkyTuKoovqXP3IotKSqSXByvKEs0LPCO+R8etwnFpi/+Xpf+GikpLYU/WSltU5S1r6Iuhne7W6jWii9cSIx6ugl+lfd/+gLPD5uRwxeG/aTeOBVyaVH5nHYWnRHewJ4eKjhe//euXCIuJq8QbB0QMamIjsIj11WrQSZkESEjQGnVmuLOcdOQfhZ416JhrgXfNFO2JfWMDTcI73q4chkCZRm5sb1LZbvUzRwbcURM/G/yE5M0L4VZ0yryRqEVvkgmYn90RAiYFJp/5uOFDxg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(23010399003)(7416014)(376014)(36860700016)(6133799003)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	dUhz/OYwIHVoWrz7rG8rGylVkabU0grDcifvfUz/LW0SMUnhCvJ1I4JLfey2Hvh6LvNuN1kfz+Zg42shSNeiY/PqAWrRgLU4nBB9gqCGc2VsWviHtjYrh/CTqK2oxjSqoaU2J9/8Qqnf7WFi7hzfcpLpMUwSuyjEHPHLh+rcEu7tlU9v+5zEbFdFJ2EaRkBqyr39e+yVd3oj2t4m+g2N/x+364vhNzmCZKoaAmh/ZvgzcgLZW8MU1vAIKQ1X2D8Kr7VVK8NZQpiVO4uCq7RRk2OwX1LE8IzsKk9Y2kuq2YwHSQipq6/wYzctIAGTxDciO/oqqterpSyczP7qdrWrSVaTkm40td/js5rj8C3876yz331Wb9K0ih1Jildpg7hcoGDboTVS5fqNtJiZT1XmkNJQh0fD6XF0MC4T0CHRukIcutwSHyazX9FA3ZfG/wzm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 13:29:46.1981
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70ee2b4b-8eae-44e8-9235-08deebe32026
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4075

Adding support for new vIOMMU events:
  * Guest Event Fault event
  * vIOMMU Hardware Error event

Also, adding support for the additional vIOMMU related flags
in existing events.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  7 ++++
 drivers/iommu/amd/iommu.c           | 58 ++++++++++++++++++++++-------
 2 files changed, 52 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index d2c64e2e9f05..4df6a50128de 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -149,6 +149,9 @@
 #define EVENT_TYPE_IOTLB_INV_TO	0x7
 #define EVENT_TYPE_INV_DEV_REQ	0x8
 #define EVENT_TYPE_INV_PPR_REQ	0x9
+#define EVENT_TYPE_GUEST_EVENT_FAULT	0xb
+#define EVENT_TYPE_VIOMMU_HW_ERR	0xc
+
 #define EVENT_TYPE_RMP_FAULT	0xd
 #define EVENT_TYPE_RMP_HW_ERR	0xe
 #define EVENT_DEVID_MASK	0xffff
@@ -261,6 +264,10 @@
 #define EVTLOG_SIZE_MAX		SZ_512K /* 32K entries */
 #define EVTLOG_LEN_MASK_MAX	(0xFULL << EVTLOG_SIZE_SHIFT)
 
+/* Constants for IO_PAGE_FAULT event */
+#define IO_PAGE_FAULT_VFLAGS_SHIFT	27
+#define IO_PAGE_FAULT_VFLAGS_MASK	GENMASK_ULL(27, 23)
+
 /* Constants for PPR Log handling */
 #define PPRLOG_ENTRY_SIZE	0x10
 #define PPRLOG_SIZE_SHIFT	56
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 4b4dd20ebec6..50f26c8123f3 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -854,7 +854,7 @@ static void amd_iommu_report_rmp_fault(struct amd_iommu *iommu, volatile u32 *ev
 
 static void amd_iommu_report_page_fault(struct amd_iommu *iommu,
 					u16 devid, u16 domain_id,
-					u64 address, int flags)
+					u64 address, int flags, u8 vflags)
 {
 	struct iommu_dev_data *dev_data = NULL;
 	struct pci_dev *pdev;
@@ -889,13 +889,13 @@ static void amd_iommu_report_page_fault(struct amd_iommu *iommu,
 		}
 
 		if (__ratelimit(&dev_data->rs)) {
-			pci_err(pdev, "Event logged [IO_PAGE_FAULT domain=0x%04x address=0x%llx flags=0x%04x]\n",
-				domain_id, address, flags);
+			pci_err(pdev, "Event logged [IO_PAGE_FAULT domain=0x%04x address=0x%llx flags=0x%04x vflags=%#x]\n",
+				domain_id, address, flags, vflags);
 		}
 	} else {
-		pr_err_ratelimited("Event logged [IO_PAGE_FAULT device=%04x:%02x:%02x.%x domain=0x%04x address=0x%llx flags=0x%04x]\n",
+		pr_err_ratelimited("Event logged [IO_PAGE_FAULT device=%04x:%02x:%02x.%x domain=0x%04x address=0x%llx flags=0x%04x vflags=%#x]\n",
 			iommu->pci_seg->id, PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
-			domain_id, address, flags);
+			domain_id, address, flags, vflags);
 	}
 
 out:
@@ -932,29 +932,42 @@ static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
 	}
 
 	if (type == EVENT_TYPE_IO_FAULT) {
-		amd_iommu_report_page_fault(iommu, devid, pasid, address, flags);
+		u8 vflags = FIELD_GET(IO_PAGE_FAULT_VFLAGS_MASK, event[0]);
+
+		amd_iommu_report_page_fault(iommu, devid, pasid, address, flags, vflags);
 		return;
 	}
 
 	switch (type) {
 	case EVENT_TYPE_ILL_DEV:
-		dev_err(dev, "Event logged [ILLEGAL_DEV_TABLE_ENTRY device=%04x:%02x:%02x.%x pasid=0x%05x address=0x%llx flags=0x%04x]\n",
+	{
+		u8 vflags = FIELD_GET(IO_PAGE_FAULT_VFLAGS_MASK, event[0]);
+
+		dev_err(dev, "Event logged [ILLEGAL_DEV_TABLE_ENTRY deice=%04x:%02x:%02x.%x pasid=0x%05x address=0x%llx flags=0x%04x vflags=%#x]\n",
 			iommu->pci_seg->id, PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
-			pasid, address, flags);
+			pasid, address, flags, vflags);
 		dev_err(dev, "Control Reg : 0x%llx\n", ctrl);
 		dump_dte_entry(iommu, devid);
 		break;
+	}
 	case EVENT_TYPE_DEV_TAB_ERR:
-		dev_err(dev, "Event logged [DEV_TAB_HARDWARE_ERROR device=%04x:%02x:%02x.%x "
-			"address=0x%llx flags=0x%04x]\n",
+	{
+		u8 vflags = FIELD_GET(IO_PAGE_FAULT_VFLAGS_MASK, event[0]);
+
+		dev_err(dev, "Event logged [DEV_TAB_HARDWARE_ERROR device=%04x:%02x:%02x.%x address=%#llx flags=%#04x vlfags=%#x]\n",
 			iommu->pci_seg->id, PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
-			address, flags);
+			address, flags, vflags);
 		break;
+	}
 	case EVENT_TYPE_PAGE_TAB_ERR:
-		dev_err(dev, "Event logged [PAGE_TAB_HARDWARE_ERROR device=%04x:%02x:%02x.%x pasid=0x%04x address=0x%llx flags=0x%04x]\n",
+	{
+		u8 vflags = FIELD_GET(IO_PAGE_FAULT_VFLAGS_MASK, event[0]);
+
+		dev_err(dev, "Event logged [PAGE_TAB_HARDWARE_ERROR device=%04x:%02x:%02x.%x pasid=0x%04x address=0x%llx flags=0x%04x vflags=%#x]\n",
 			iommu->pci_seg->id, PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
-			pasid, address, flags);
+			pasid, address, flags, vflags);
 		break;
+	}
 	case EVENT_TYPE_ILL_CMD:
 		dev_err(dev, "Event logged [ILLEGAL_COMMAND_ERROR address=0x%llx]\n", address);
 		dump_command(address);
@@ -986,6 +999,25 @@ static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
 			iommu->pci_seg->id, PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
 			pasid, address, flags, tag);
 		break;
+	case EVENT_TYPE_GUEST_EVENT_FAULT:
+	{
+		u8 gid = event[1] & 0xFFFF;
+		u8 vflags = FIELD_GET(IO_PAGE_FAULT_VFLAGS_MASK, event[0]);
+
+		dev_err(dev, "Event logged [GUEST_EVENT_FAULT gid=#%x flags=0x%04x vflags=%#x]\n",
+			gid, flags, vflags);
+		break;
+	}
+	case EVENT_TYPE_VIOMMU_HW_ERR:
+	{
+		u16 gid = event[0] & 0xFFFF;
+		u8 src = (event[0] >> 16) & 0x3;
+		u8 vflags = FIELD_GET(IO_PAGE_FAULT_VFLAGS_MASK, event[0]);
+
+		dev_err(dev, "Event logged [VIOMMU_HW_ERR gid=%#x address=%#llx src=%#x flags=%#x vflags=%#x]\n",
+			gid, address, src, flags, vflags);
+		break;
+	}
 	default:
 		dev_err(dev, "Event logged [UNKNOWN event[0]=0x%08x event[1]=0x%08x event[2]=0x%08x event[3]=0x%08x\n",
 			event[0], event[1], event[2], event[3]);
-- 
2.34.1

