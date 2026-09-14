Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012016.outbound.protection.outlook.com [52.101.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CDA361943
	for <iommu@lists.linux.dev>; Mon, 14 Sep 2026 18:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789411710; cv=fail; b=BC840SsIVW1Yv0yiv3JWiql7gf4+inm2caomkH3Xqpk43vCE9Gy5caVPFYNHbbxizznrw1Y9IlyjsSAud0RysCMZAnA1mDN7nDLNuPIfmjR/fnZUnyUwyYQZRz94mgMROHF3hp3XNnjUCJKkN9qrvvCz0ESYqMxzRa8J/te+LpU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789411710; c=relaxed/simple;
	bh=/Y2PQl0vJnjW2tmf54ugY+um95UjPb9FnJ6D/9kW22w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HIzU7legDkH1r50VyLrsjrggoApVa4orLBrTIqZOd5gJuOOz6s/sA/YW05OhG3SB+OxFDvI3PoUigFVxaHOYujAkuy1Fnkcr/+EXpyT+p6KKfIPrbVRbhJSU3xWyxFhQDetwBwliFQFqy/XPEHAcm+h8exqX+ayBzBHzO0/YmjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PNpJpZ5o; arc=fail smtp.client-ip=52.101.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PNpJpZ5o"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jlLSR9FOQekoVj+vfi3G8Yp024Y0WVVxopQghaIlT/xf1f/FyDnWpyj1tLMRsuH5apC8sO7krFap0SwbktgDlBaN+nHrU4GJWxHs1KIDl2NGA9CNskJtu29a3bUiU2eU9FYqJS1dF0VctxjbfycVi/PNo29fA6jQy5i6rt5Pt2FFMDMk4Z1lZNWKkVHCWBTNXE0fTcxmnSW/xD6bh+/1mI/Fi/feeQrTE4kWwSVPV2FU+Al8QHL6YEpnu5xc0B5IGzh6JVPHgrmSwfSQ/Xhw6piFZA59N+b5QV1ptdG+BV4XOzlZPtTwBiReHEMlQuHfcdFlBb3y/lLP+6bwg9uYZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wx89cAN1XzONKzeV3Cn94rs4Y+inKDiYKDwx9ZYCjHI=;
 b=Sjp+c7FWhnmlk7EQCa/Hq5gG82S1nQeqhidsaiFLj7pN+oLzlJ9PJIMsvyN8S886+giIs6q2JypY0o2RNcvdmoHVKB9fxjgYzTXDy8uYeHiwFVU33FQKbSA1Z8xmO7/neOkWuVO9ikphYiZlqE6nUmJhSszpaHe51xGFPX0HuRpQnx3H/uZBqZ74JbDGhgNSDV6efutLgnEtcd1AtpoOH2TwcmyTwi/DgvpvCS/X1vqcF8zexh61VyNqt7GwIHEyHa8fGn7wSrhnsL+fXHc1jXfFPJmsZkSgOG7NgM8xSJ1wGdCuRv6p8IBnpnL3Z+BpCJ7l/biXCpEHDLTQU6xreQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wx89cAN1XzONKzeV3Cn94rs4Y+inKDiYKDwx9ZYCjHI=;
 b=PNpJpZ5oUPnb71qZ1pLeF7pKs2j+3i3S3HN7evVagjle+x34aHsC+njejEivWep4I/0ZnfKqt3H9rCQYB2hqcxbXA1hMENqo7+DA0++helXBkkxAt1BHl11eR6BZRDeHdlKsf+kMigQVlmAIJ7ZWuA8fQabqKRFhTBpnrFzz9Fg=
Received: from BN9PR03CA0175.namprd03.prod.outlook.com (2603:10b6:408:f4::30)
 by CH3PR12MB8850.namprd12.prod.outlook.com (2603:10b6:610:167::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Mon, 14 Sep
 2026 18:48:22 +0000
Received: from BL02EPF00021F6E.namprd02.prod.outlook.com
 (2603:10b6:408:f4:cafe::6f) by BN9PR03CA0175.outlook.office365.com
 (2603:10b6:408:f4::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Mon,
 14 Sep 2026 18:48:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6E.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Mon, 14 Sep 2026 18:48:22 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 14 Sep
 2026 13:48:16 -0500
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
Subject: [PATCH v5 01/24] iommu/amd: Introduce vIOMMU-specific events and event
Date: Mon, 14 Sep 2026 18:47:27 +0000
Message-ID: <20260914184750.222939-2-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6E:EE_|CH3PR12MB8850:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fc9c6c3-c0fe-47a5-5dcf-08df1290c08f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|36860700016|1800799024|82310400026|10067099003|56012099006|6133799003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	3Li4A0byHXgbC7GGu/fcLsYRlB+uCb+veQ1C9uFoWK403GpoQKPZhwHCysdC5cFFlojuoxZEauwMxvC4LUhAkMehBuXLjiCNNTqEPsdTm2OB1PxlHJ1n/EuvGPeGDzrMKaN1bK2RhX8//ylBF9IFrYAzyzDfLPPmgY4ue4B0uuRI18hrPk4J6uhDmEDXbpnou4Tn8t7nSqg6tamj5oioYIujlyeD8JBHnCofKwWUyQq8QfZ61l8+DESA/gylOPqQ6PBcu3YQ3uA1PEIsaIHl/ZuXiMmMk7c+RWYLicEz9DiPhlmsPWE/wOTUFNctYaeu+riwYXYOQnJrIBrUmXAwGQ5sGeJvwsaSdkLGtse/y5VJX8BK1Rqid+m9dbNBCPTDrcCHAyG+5SHOGlVt5Sp8vnWrgT3mWZ539gqLVDhWUVMLNLKsMxet5bVIzt+JblwSRXrop2hjxlOgZpkTHZQvE6qaR8EJf6yjVhphfPheFxxOgiUhgWFcUB6uygFrGnzT0gKtl1kpMB8jLKO2Av7u0Eq0Cl+vxEnscZMCJKX3HZvatG7yRo3qNHdNvxQMakI5AqbmC2Zp1Fh/NlNlbyfbX//t2hSh0HW0tR4d3YKSVCP3TEgup1DNpLqiEVMRq9s5jymuCPAhBhhl8BXOnZUUkclsBgqjmb6VMW+HlP6IN5p7CYns+9DYeEvKRzBbULna4SLHljRDP44ycai/28tJIw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(36860700016)(1800799024)(82310400026)(10067099003)(56012099006)(6133799003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	EodRvFRW3E1ZqOQ1MheXiJVjgOL4e5ECUeqjR2auH1+oxNQLcsAYj6o6zMpKqNxR4DPNgErH/2DFL+DksQr0gMVgOaNWeyK/fEjf/Tj5xPRRVtS+iT4bWO1bmNW19PWjjBodYX/CMNqEK4xVPZzv+pcAeyRiNP9oQ47Da9kFkkdS0ZAYJ3kSYxbKlcrNCzqDHwafDRLQ6qLwpJBhDLaaZ4CabXrOEKeXEc0hE6rilV9fKw8eB0/QSLU4cjw0gv2sV59RErb8WHF37hek2N1yYsdw/0Pl1tCUm4IxoGtuwtPBsLUHr2jcVMOB9+MtMn3F1iYopDUb4olHDJLMiVlV41pTIO5qrIPZXLhLWr+yahiF7x1tm2cg0HcBlUOxlTtJfyNrUudgyhE9nVs5qsW84+Q1zxvcaXTgqThq9TI8dDsod6bIneHGbeZp+4Bv03pQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 18:48:22.4682
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fc9c6c3-c0fe-47a5-5dcf-08df1290c08f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8850

Adding support for new vIOMMU events:
  * vIOMMU Hardware Error event

Also, adding support for the additional vIOMMU related flags
in existing events.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  5 ++++
 drivers/iommu/amd/iommu.c           | 37 +++++++++++++++++++----------
 2 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 8241ef922519..f26a9059a356 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -138,6 +138,8 @@
 #define EVENT_TYPE_IOTLB_INV_TO	0x7
 #define EVENT_TYPE_INV_DEV_REQ	0x8
 #define EVENT_TYPE_INV_PPR_REQ	0x9
+#define EVENT_TYPE_VIOMMU_HW_ERR	0xc
+
 #define EVENT_TYPE_RMP_FAULT	0xd
 #define EVENT_TYPE_RMP_HW_ERR	0xe
 #define EVENT_DEVID_MASK	0xffff
@@ -251,6 +253,9 @@
 #define EVTLOG_SIZE_MAX		SZ_512K /* 32K entries */
 #define EVTLOG_LEN_MASK_MAX	(0xFULL << EVTLOG_SIZE_SHIFT)
 
+/* Constants for vIOMMU event fields */
+#define EVENT_VFLAGS_MASK		GENMASK_ULL(31, 27)
+
 /* Constants for PPR Log handling */
 #define PPRLOG_ENTRY_SIZE	0x10
 #define PPRLOG_SIZE_SHIFT	56
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 56262f6b1f70..43a5690721af 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -859,7 +859,7 @@ static void amd_iommu_report_rmp_fault(struct amd_iommu *iommu, volatile u32 *ev
 
 static void amd_iommu_report_page_fault(struct amd_iommu *iommu,
 					u16 devid, u16 domain_id,
-					u64 address, int flags)
+					u64 address, int flags, u8 vflags)
 {
 	struct iommu_dev_data *dev_data = NULL;
 	struct pci_dev *pdev;
@@ -894,13 +894,13 @@ static void amd_iommu_report_page_fault(struct amd_iommu *iommu,
 		}
 
 		if (__ratelimit(&dev_data->rs)) {
-			pci_err(pdev, "Event logged [IO_PAGE_FAULT domain=0x%04x address=0x%llx flags=0x%04x]\n",
-				domain_id, address, flags);
+			pci_err(pdev, "Event logged [IO_PAGE_FAULT domain=0x%04x address=%#llx flags=0x%04x vflags=%#x]\n",
+				domain_id, address, flags, vflags);
 		}
 	} else {
-		pr_err_ratelimited("Event logged [IO_PAGE_FAULT device=%04x:%02x:%02x.%x domain=0x%04x address=0x%llx flags=0x%04x]\n",
+		pr_err_ratelimited("Event logged [IO_PAGE_FAULT device=%04x:%02x:%02x.%x domain=0x%04x address=%#llx flags=0x%04x vflags=%#x]\n",
 			iommu->pci_seg->id, PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
-			domain_id, address, flags);
+			domain_id, address, flags, vflags);
 	}
 
 out:
@@ -950,6 +950,7 @@ static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
 	int count = 0;
 	u64 address, ctrl;
 	u32 pasid;
+	u8 vflags;
 
 retry:
 	type    = (event[1] >> EVENT_TYPE_SHIFT)  & EVENT_TYPE_MASK;
@@ -970,29 +971,30 @@ static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
 		goto retry;
 	}
 
+	vflags = FIELD_GET(EVENT_VFLAGS_MASK, event[0]);
+
 	if (type == EVENT_TYPE_IO_FAULT) {
-		amd_iommu_report_page_fault(iommu, devid, pasid, address, flags);
+		amd_iommu_report_page_fault(iommu, devid, pasid, address, flags, vflags);
 		return;
 	}
 
 	switch (type) {
 	case EVENT_TYPE_ILL_DEV:
-		dev_err(dev, "Event logged [ILLEGAL_DEV_TABLE_ENTRY device=%04x:%02x:%02x.%x pasid=0x%05x address=0x%llx flags=0x%04x]\n",
+		dev_err(dev, "Event logged [ILLEGAL_DEV_TABLE_ENTRY device=%04x:%02x:%02x.%x pasid=0x%05x address=%#llx flags=0x%04x vflags=%#x]\n",
 			iommu->pci_seg->id, PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
-			pasid, address, flags);
+			pasid, address, flags, vflags);
 		dev_err(dev, "Control Reg : 0x%llx\n", ctrl);
 		dump_dte_entry(iommu, devid);
 		break;
 	case EVENT_TYPE_DEV_TAB_ERR:
-		dev_err(dev, "Event logged [DEV_TAB_HARDWARE_ERROR device=%04x:%02x:%02x.%x "
-			"address=0x%llx flags=0x%04x]\n",
+		dev_err(dev, "Event logged [DEV_TAB_HARDWARE_ERROR device=%04x:%02x:%02x.%x address=%#llx flags=0x%04x vflags=%#x]\n",
 			iommu->pci_seg->id, PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
-			address, flags);
+			address, flags, vflags);
 		break;
 	case EVENT_TYPE_PAGE_TAB_ERR:
-		dev_err(dev, "Event logged [PAGE_TAB_HARDWARE_ERROR device=%04x:%02x:%02x.%x pasid=0x%04x address=0x%llx flags=0x%04x]\n",
+		dev_err(dev, "Event logged [PAGE_TAB_HARDWARE_ERROR device=%04x:%02x:%02x.%x pasid=0x%04x address=%#llx flags=0x%04x vflags=%#x]\n",
 			iommu->pci_seg->id, PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
-			pasid, address, flags);
+			pasid, address, flags, vflags);
 		break;
 	case EVENT_TYPE_ILL_CMD:
 		dev_err(dev, "Event logged [ILLEGAL_COMMAND_ERROR address=0x%llx]\n", address);
@@ -1021,6 +1023,15 @@ static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
 	case EVENT_TYPE_INV_PPR_REQ:
 		amd_iommu_report_ppr_err(iommu, event, devid, address, flags);
 		break;
+	case EVENT_TYPE_VIOMMU_HW_ERR:
+	{
+		u16 gid = event[0] & 0xFFFF;
+		u8 src = (event[0] >> 16) & 0x3;
+
+		dev_err(dev, "Event logged [VIOMMU_HW_ERR gid=%#x address=%#llx src=%#x flags=0x%04x vflags=%#x]\n",
+			gid, address, src, flags, vflags);
+		break;
+	}
 	default:
 		dev_err(dev, "Event logged [UNKNOWN event[0]=0x%08x event[1]=0x%08x event[2]=0x%08x event[3]=0x%08x\n",
 			event[0], event[1], event[2], event[3]);
-- 
2.34.1

