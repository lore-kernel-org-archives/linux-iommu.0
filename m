Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013025.outbound.protection.outlook.com [40.93.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6FC1A262A
	for <iommu@lists.linux.dev>; Thu, 28 May 2026 05:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779945500; cv=fail; b=HLhSz0QcN+LB65BGIvfVLUx237T868UiADo9MLCSXCuGCCwLtemKnCJWdfKPWzeq1k0vdTwkap83us8s2LnMBioQ6pikWhjHo55DeusdYnYpBVx9eJZT/nOBtkFXPdSnNsEXCsDa5840jA8QBOZEACdlVdtXD5ZRA9YbsAlSdAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779945500; c=relaxed/simple;
	bh=5kFyqaWgCNyXfWEjy+33hFAM6QsnSe54BwzRdZvcKrM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=czRK2B0CzcA0KxffrHLrizxpKk0EBo7AYxJ4dErqJISxF08YCB+slx5sc4yJMDwHO/IwShbgzuz9ZGjUP0EZrbvHiwZMaJcelEJ11vpEm9YeYyMBONEK7RV9nyGpq+Ql4EfYxaRVmrZbPWrCIx/hLdWGx0THn5Bch2lhM+kHgzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IREAsgr8; arc=fail smtp.client-ip=40.93.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IREAsgr8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uMPJ+4yTaB8COwEB2Q2UJe59weiKloz/1yJIMPr4NHHdUrsZ9ayMY/QKZKm3H3oJzpWp4wRlVWO6YJFOOh2zNCsWeDz7EZorMqYJTad4ZtA16/ja56ZegyPcO3L5c74j7JS5jE+ZTwQaAQc3ffGeinogsASV/LgCIrgXJceSdKAR26F8ih8SNACgeeaE8IPcOYbKkPcFEu2o/QR17fHLW9S0l/cYibNsSTfVJ4gKXGn1jKRcqiqa6W2txI64wcmJgrONwDfylJg1nwhB97Pv7ba10sjFhw1vz4yOhNz1fUodosPHCYWnaxhzXXpoQIJOSBdW6kdZtOUT1jlhzR8r3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tn+cvTpnS6/vo37XynuieszjwqOF2/DJgkEchgffwf4=;
 b=OAvhBDzlRO0WiMMfJW4QpRXMlwziV6qqz2oexsfBN+MRmhJ0Zj5b6LYnIwSnshDCntnvQ+F/UEjOQub/anqD8aBmZWAJnktL5Es6Fvh9eHpSXQAL6ehekmeRJBryDvjaJTxoKNWhM+lRvL4Uicf46rz7qpxTvFMECBJyW6wh5q4c3wn+VJsEHRfFGviigt7lYizYJ5o1nPenLMukAhJBIMUIKl/ntUIwUzy2JM2MOoG1rWbkZVBXyuEDqbiv6peX3mFwYr1OnvtPGfaKPbD1XENW5ZVD8fBJsPXqBJFQELrAF2zgAKa6I1i4zW3+B09j9XxXkj2VxHA+7M/wBbY5eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tn+cvTpnS6/vo37XynuieszjwqOF2/DJgkEchgffwf4=;
 b=IREAsgr8V9UTbU9GOA4b6Kn+mhgZRrg3j5KAWW6q3nLTtROkuNA1se9Y201wj9pwEdnXRf8UjxBzA3q4erbR/MaAic7ZjhB2Ix8RyIhcWAmGoN1zur9hl3W1D8/XKZaRHtD9Kg2rszZvAKS2lHQKNuL4ip/+XIPpGtZYWSGN6lc=
Received: from PH7PR02CA0005.namprd02.prod.outlook.com (2603:10b6:510:33d::22)
 by SJ1PR12MB6265.namprd12.prod.outlook.com (2603:10b6:a03:458::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Thu, 28 May
 2026 05:18:13 +0000
Received: from SN1PEPF00036F40.namprd05.prod.outlook.com
 (2603:10b6:510:33d:cafe::12) by PH7PR02CA0005.outlook.office365.com
 (2603:10b6:510:33d::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Thu, 28
 May 2026 05:18:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F40.mail.protection.outlook.com (10.167.248.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 28 May 2026 05:18:12 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 28 May
 2026 00:18:06 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jay.chen@amd.com>, <wvw@google.com>,
	<wnliu@google.com>, <dantuluris@google.com>, <chriscli@google.com>,
	<kpsingh@google.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v2 02/26] iommu/amd: Introduce vIOMMU-specific events and event
Date: Thu, 28 May 2026 05:17:14 +0000
Message-ID: <20260528051738.596013-3-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260528051738.596013-1-suravee.suthikulpanit@amd.com>
References: <20260528051738.596013-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F40:EE_|SJ1PR12MB6265:EE_
X-MS-Office365-Filtering-Correlation-Id: f2a91032-582a-4abb-c8b9-08debc7883d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|36860700016|376014|1800799024|6133799003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	JB2RoAg0IQwKVUdqrTbqyr73Q+LfdLPDCntRIaTOe1i4Oy1V8cK3sw2py4sjjypqjmKmr2sudz1Vh50GyKQvtb5MJ1XLJ5i7Mw7ndsGCTwtO7C8Z89vgAeT8Mi9SSbSb9Qw/9uPyYjnPoB2GsZhgNcoX6hp+l/zm4hgdyhoSMEGK1vsFAN34C8Nh4Buz6M+T3Zpb1BdCkwv63+KHfFlHE09t2DfWwuqa9ShI1/3XtQb7ukzyDLXfq52cUhvO1KyLAisrNURRQHKNPFnZYQvQJuwNShlAIh79Maj3SrfpkyWdgtfLJdvDnGljT+tfU+0SJRkeOcYLNaneg8Hd9wDkhEOF+LWXSMlJF9y9lYjlbBZ/Mob+TgWVb9J8UFzVEcY9NWQ7Kv0/kRzXX0P5TEBlntEdTusrWbQ80UXp3o1J+SsmCxOB7JTVQpiGVdlQdnS62Y26ed23Z/KOzK9tdqy/7o+Qo1liCc5vOcHvVYXwALR8gHponoSyi2UdkpOaE3TWsJi3ggEF9tNrFhsZFoSEHUeBbqNR6+WtwZQSGPqC6D3kEbLGSMG7cxUvjcdsj5rdhk/b3p5+pKGcNA0bveU8J6Znr2sQq+pM7WVtS8OaBCLhc0GdeTj9IxteovNRoePPCpIY2fPKRJ1cb/V/7EgnOH/GN52k7ogEPu5e0c4j/u+WF05kaSq0uw3kefls9IWU8dvs2ST8lVkfk6jMga4PZpPQjB3ujlQcFk88gLfOvOA=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(36860700016)(376014)(1800799024)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Qcdx+Mxt9dHXM2Wc9R3NZ1wlznYfWEXXnAenZ8s92pveoit1UgwKOIbi1MhHL/ebK+iTL6kkCeti9ShC+z//k74faL91pHq4EGBsRuooYTEsHgrKT//XNYz5iDXlrLHA8uKEuqpQmf8nHjfEMlmWaSqUXIWUrSmaLxMFiNtLdNnAv9CuSYdg7NO9vFdDiDRK+QQqIbKFQrH0/4t9QbAc/CD8vUKtvbPy5O9K4p8rS8OmFEbckHAPvOcNZdO0FGSzKHgjIZ6kMFmriLNcaXDjGXRTiXVhzr3P4+d+d+WQYN4eOeBXJxoXk4Juj5eaYWvhvhORJDkwmB9pgT7s63BYGHfBB+OecWhxfgLhG5/nkRO3bHu8UkPz4XTJxtmtZ0MipqMkqM+OD0zHMIJJrOoIzHmJLzA5bBlou9qPjQnfOBzT//bncyuaAdolmxWR9Afl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 05:18:12.6226
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2a91032-582a-4abb-c8b9-08debc7883d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F40.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6265

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
index c685d3771436..31af02d12afd 100644
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

