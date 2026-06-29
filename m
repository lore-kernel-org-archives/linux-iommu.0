Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012055.outbound.protection.outlook.com [52.101.48.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C9A41B37D
	for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 15:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782747715; cv=fail; b=c9M/RU6sLAKIbMuI9TyiAdBiyPE57n+5BNyP0RDtAJ92veaQOoXw2n0GCK6BHX5t+Mil5GXiPGFld4qF0w+uqBjxhZGB0cvChTR6YXTDEMK4YdGHqPHZnlYVg1/6Ix77Tdo8IV5s8pEk6cMlPpf1JxVPprgRK/6rP8lrizAA7kI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782747715; c=relaxed/simple;
	bh=21X5BexkEKUnmbyDro3IoHeHmUhI6q9ftvBZP3Nf4ec=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XLspouRYrgBqE4dwBkqLk8Bes7ovyBvUxsEMHyP+wiomqME6JR96ZXizLFpXL0LzSy/713aTo3VNpXjz01Rv9f5DNR8vGzCktGmJoq5+Hwh4p5CIe76EhVZ935ngu2IP1q0FvQIrYIVTTEWbEP7E+Ixo+kSJ9qGeFp/gNzQdN/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZVpcHlTm; arc=fail smtp.client-ip=52.101.48.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZVpcHlTm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V5GKyPXVOCMHUNj+szrB0+aGQhqmqLH810Os/pxwGN1ynqF2FNC+hzK4L0uGbfB9bUhBh6u6xapQ7YchpAw7h0/xzNBU1uMjri3WFUuV+Z5oh5bYGjevkHw/i1bymYZshDSYZqniaqcBR0oqzpXn/EZ4cy4cX62Rel8QNzncp8966wdQ/w9ebif571OeGTOufvQHBhU3dWp6YDEZTsU4TuzqWWHXSFfz3pZjOejnSoy1OLRunAl9WQXhhiYwqJ3A4EO2AxQeQ2cZpb+nE5IX9hktcQnCSoLmBUY/b5TnFknlYSR2QYm090Ykof2RIBIIVNJ96We0aN3OdHrFtpJmCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BFK3Tzdw0ETKiHpeMSu98pkrb0NNhikSToE9uH7lRu0=;
 b=o/rgaI4rZbEUIEQ6A2u8B1kPoxACMJ9YTCK6bgs26ku+1g403L2UZUyCxTvLmKmJtQRW1f1RX4T+rJZ4tRmq7qoWO0yEgCkGqrlbEoIA4uQ1pbhhhRdYrAsJb8ZCB2ZzWMMXjAu0SnrCbKehs2N+2mV2XXbdnAc0yNvFRCXVvWPWygrp1Kp7OlIh61ebnPKls2YEpgM6JHYZ3CKJlkjE/ldqynbB2Uhd2pvtu3sms+f84LWVQ3tN3gQhJhi8/B00jPhmcxjhQ+j4rWor617ah4SV3YceyNFAlZJFSq+rFjvmbC0HUMs7OlUfcCtgn7IK9Ytu5V2b5/6m+IxGj/PlOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BFK3Tzdw0ETKiHpeMSu98pkrb0NNhikSToE9uH7lRu0=;
 b=ZVpcHlTm5/ph9x2UsixG5TAd5foNapCT+H+rP9Vk/b8T1s9WJHruJOFp2clbYfiugJ/hVNebPJ+igmoPL4EuURhO5vBpbFriThMHGaNTHF5YBN7ar8Wd23agqyRwNOJFrcafi/OUcwtciDUNequfkHAH4xDaEsv2F4utDHPOdgw=
Received: from SJ0PR13CA0173.namprd13.prod.outlook.com (2603:10b6:a03:2c7::28)
 by LV8PR12MB9405.namprd12.prod.outlook.com (2603:10b6:408:1fa::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 15:41:48 +0000
Received: from SJ1PEPF000026C4.namprd04.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::3) by SJ0PR13CA0173.outlook.office365.com
 (2603:10b6:a03:2c7::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Mon, 29
 Jun 2026 15:41:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C4.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 29 Jun 2026 15:41:47 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 10:41:32 -0500
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 08:36:01 -0700
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jay.chen@amd.com>, <wvw@google.com>,
	<wnliu@google.com>, <dantuluris@google.com>, <chriscli@google.com>,
	<kpsingh@google.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v3 02/22] iommu/amd: Introduce vIOMMU-specific events and event
Date: Mon, 29 Jun 2026 15:35:15 +0000
Message-ID: <20260629153535.15775-3-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629153535.15775-1-suravee.suthikulpanit@amd.com>
References: <20260629153535.15775-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C4:EE_|LV8PR12MB9405:EE_
X-MS-Office365-Filtering-Correlation-Id: 40bffda4-ccd4-498a-1ba1-08ded5f4ee4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|23010399003|36860700016|376014|7416014|6133799003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	zdr+AUcAXEzkDS5BDhNK4dDqZfZZaMt8hEYGEwyhxhcI+5xZO7QD3GbpLTEvwY4RVvGVNivh8c/ZL5bJdPs6Td58g/XPUhjH0tmdHxWawx+9+NFb2JLRqempkIuq1GcAnoMC0O0xCGJU3BiJTtSX9D/ugtehJQfWC9LRfhrPWZVaLO9fUkpJMbFXRNXt4tq30Eb7voDPijyI/2cBA0mDRjYT60GKeIrc/s7xeCLbYrk7xSCEMu0ihFfwkRy/pb2etOnARJ8OwG45H7lgsXj5oScbYDWt6wiMeVQxIL+gmup18wmCodSwAexIsPGgd5x2RbxJkQDrDL6yuO6gOOk/wwSdWYm9wQeuL+8P9lgoirvxyru6Nz9hcuwCxElCLOKlPpH5ByPUP8oeT8985+UDlLr2zvDf7p8q7YCtWHgfi/whlShuMDc51GKJvGr/4wS9xzBXDhFi24rn5wczJzMtmPjNllr2Ja7klbhpfR60iz702Y7SrLajN+PogLV7DMLBBmqdmdmtfsHkm2AVWonEcdxB+aNeHLOXQkcKk0mJoRJ9kTlCeAaZ/iENlWQ4YjZOaOYEg7HvoiAxwlaopBI2NF6FkPdhGimBZKbM6sz8l58MfRfbgqwzhd3i4IEbo0YWryq9fmYEKRzSGwuHl4yVxLNTmD+bav9B04m88Z6XYlvGhv0lAemGXu8ppr49PH1wiQv57xQfTbX2Cm2haoeePw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(23010399003)(36860700016)(376014)(7416014)(6133799003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	BFr1m0kw0rj3s5qparenSza9j0WkkKZwvwTACQVPTD8+YN2SC0XEjWUvu6x/jekwcmWjpqVAUzc4j2TreSMQ9A+LlhOK1kZTOW1i0w/uVtX6/WiOVTtg7/JceIw+iVgM3aube0ARAX2ClDeaiWM1EzNaWZokwsRdL1iUjOW+GATJ4bS8hXmpX/Gmo/sFuZI6nK3PebYHUMj+hkX8kby92fqFBwV4ybWaF+vGZrKTM+uK1y7P1zxsgbB7O5FA5IqpUBKpXB3v0NbQXOmjgtsPkRc499ocj2o8yvU7eX6DmAPGoec4zfMmggQGwCOVn1vNkqajqEG5P+JP4nY2DGrVBm6M4Dm1NAnIlwOhaF++0iwt7xb1uW6r6aVRQ58MXLkXdOToDloxixJCaeZooVqcXRp8BBBLhUJ7x/A4xtx+viFCz2o9z6XwzywlGSGYkhKj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 15:41:47.8766
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40bffda4-ccd4-498a-1ba1-08ded5f4ee4f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9405

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

