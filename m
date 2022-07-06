Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D49F33C6
	for <iommu@lists.linux.dev>; Wed,  6 Jul 2022 11:50:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=URnBrNOIxDNZxAxM7HKAZh4eWa9l1Wg7FiHh/r/j+VEHdQVb+vgGIkxJm81h1eEpgi2Ej/3iNGZpeDbeFxbHpNqM7Z9DEYig6VRqDOrTQlpAH5SqILroqbjfReyRm/THbNn0P1a1qzljH2D64N02zyQs6SgkKFW7cKTzRbbHrE3o4lbltXqyglsJgk0RrrwKgjEWhzeBv88o9wDotrrXWR2+59LBHeVWwQgxGA0XjCVo0Qv+z13FjwvkQzztwJr8YGQVlmaOZMdagY3Px6w0+yEeDMYL0atIrxaZexcxykdnxUZ4oZi+nzZMf1jWO//QeZdoo8BFrkUw/Rm+K8Cefg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nzO/r17gdEngAjjI1K0vPPUlGH9VYlfD1OJ1yXDoEsU=;
 b=mD4f80YF9m33buEkwy5CBJrdnCyzjywVTOwDwHa+5N5581SOy0d7jsFu71uwQ2NV9D5cYvd+3MyqiL9nRHn+3A9VRTw7utEfoPMESDDqw2RsWSztXDN20oEkVliwngR7xxmZWmCLN5SdHdZU/XbVndpnlaZ8TJpO/yGyD7FbRZJxhKNBQCx5oL+aJcOCFIIIA0REF9cYnmc05zSFgmIpZb9dI4Xs5JE2oHkk6dw9EM01Jq/DzJmtxqzJCusMgl5WfZL9SPS5sBZOB7f0Fv046m31VnWEBtIPldPqk46O+VkSzXJnebbmEyex1hjaW0xxHSUFsY8xB1jdbEEmBg5gTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nzO/r17gdEngAjjI1K0vPPUlGH9VYlfD1OJ1yXDoEsU=;
 b=TpgaF7Qi5yCGX4cOSJdih7botnK308rWY6PtdOcAyxuaxFmBJKuZi4qyoJQlicZ3WKUh4z/Pug4RbftIyRiH1jncYF7S8v2daH4Gy5xzNwrD6Yh7m8vL6SVfNDgFX0KpM4s+GHw736l55FP9Cxmgq74Pq+RpqoaHylCUOtdGbj8=
Received: from MWHPR14CA0051.namprd14.prod.outlook.com (2603:10b6:300:81::13)
 by MW2PR12MB4684.namprd12.prod.outlook.com (2603:10b6:302:13::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Wed, 6 Jul
 2022 11:50:21 +0000
Received: from CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:81:cafe::80) by MWHPR14CA0051.outlook.office365.com
 (2603:10b6:300:81::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15 via Frontend
 Transport; Wed, 6 Jul 2022 11:50:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT018.mail.protection.outlook.com (10.13.175.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Wed, 6 Jul 2022 11:50:20 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 6 Jul
 2022 06:50:17 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <joro@8bytes.org>, <iommu@lists.linux.dev>
CC: <iommu@lists.linux-foundation.org>, <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v3 RESEND 31/35] iommu/amd: Specify PCI segment ID when getting pci device
Date: Wed, 6 Jul 2022 17:08:21 +0530
Message-ID: <20220706113825.25582-32-vasant.hegde@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: f87b83b9-e41b-49a5-aeb1-08da5f45b45b
X-MS-TrafficTypeDiagnostic: MW2PR12MB4684:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lWBr78TbdPDR3CkbZWkHM9quvccoKOH/EN4jRg+zx/59x/efprscYjSIHIcrn0WMnXzPcig17Z97JPN43ZNfPuWnN0zI/EQcg5xyQKj9goQO+Qu03M9S5BkbLSR93fJUqpq79U3C6Qj4lqR0saRwLYmlYh0uqgUs3yKukVblcPM3tPFYuF+gNeZ5WXRZxGeJs4/GSZGpq0DHlb6phfTL+A5uPXJzZ8v9wTzvcswnH1DoX1YaZMOPTkdvwJSLEjXX9CuRisjQP4yVMeItHc4f5DpDOToSfExWnVYV4lyQWo14p99pPeWmuv8qMKm6wXXuuWKc6F8kYcbBsvO+Ml8HeKG3+8y/4C1o4GqJcovvBjOT3akmGiHTyDKmHSStk9bnkLSCcMUdHspc9JMvVaC823xE6S/A31pv+xyzWB5+md1ZixkNdHbqObmfQgtuqBX5NHqmEFqPjC0FjPzCtbLNSkRpOk+ur9tMwyabWtrs5hTXa/QUNvfE50PrEU//m7d26MuZ8FURfyyUPNIQF6YIBE9GDWwgkn/t/rFJCH8u2QzQNIrJ9R083xr1dyN2wuLQio6+MnREpv90h4TgAhtVnxR4g+9NyLdSxQRWVXvlOc3b3IQldhpI+/BJaI4gHjTRUhvDn4pfZdrvUs9MiMdnp8jRgHmGyJ6lMukilYGb6YcI13GKH2yYzqP7OOLX2o5HcdbShA8AR2KxazBXdoAPZ1xuNhOCPWEUZ9k+5OR7o0q0db6wz5tBMTT8ZIwUekco5Q35PYQoKM9wqU0fKNliJbmNRDMNDE0uCNnbTbsFK41NZ3a/iRTC1xOMSpe3L7if3aOtQZCRFKaK7lwup0Uvl/OjbWHuNpnvwxbk/Pv5XTs9Q65/PSXsq3TlY2slRcEq
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(136003)(396003)(376002)(46966006)(40470700004)(36840700001)(40480700001)(40460700003)(83380400001)(110136005)(54906003)(5660300002)(478600001)(86362001)(44832011)(82310400005)(1076003)(2616005)(2906002)(356005)(81166007)(16526019)(186003)(82740400003)(26005)(8936002)(36860700001)(70206006)(36756003)(70586007)(8676002)(4326008)(41300700001)(336012)(34020700004)(6666004)(316002)(426003)(47076005)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 11:50:20.7604
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f87b83b9-e41b-49a5-aeb1-08da5f45b45b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB4684
Message-ID: <20220706113821.oV5klrbX4YZOqGTaHb2oApRKWFbDPRjuHL_adY07R1Y@z>

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Upcoming AMD systems can have multiple PCI segments. Hence pass PCI
segment ID to pci_get_domain_bus_and_slot() instead of '0'.

Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/init.c  |  6 ++++--
 drivers/iommu/amd/iommu.c | 19 ++++++++++---------
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index d35081d84460..9693f0b9e07a 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1962,7 +1962,8 @@ static int __init iommu_init_pci(struct amd_iommu *iommu)
 	int cap_ptr = iommu->cap_ptr;
 	int ret;
 
-	iommu->dev = pci_get_domain_bus_and_slot(0, PCI_BUS_NUM(iommu->devid),
+	iommu->dev = pci_get_domain_bus_and_slot(iommu->pci_seg->id,
+						 PCI_BUS_NUM(iommu->devid),
 						 iommu->devid & 0xff);
 	if (!iommu->dev)
 		return -ENODEV;
@@ -2025,7 +2026,8 @@ static int __init iommu_init_pci(struct amd_iommu *iommu)
 		int i, j;
 
 		iommu->root_pdev =
-			pci_get_domain_bus_and_slot(0, iommu->dev->bus->number,
+			pci_get_domain_bus_and_slot(iommu->pci_seg->id,
+						    iommu->dev->bus->number,
 						    PCI_DEVFN(0, 0));
 
 		/*
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 0751dda04a10..2dbe17e49ffc 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -473,7 +473,7 @@ static void dump_command(unsigned long phys_addr)
 		pr_err("CMD[%d]: %08x\n", i, cmd->data[i]);
 }
 
-static void amd_iommu_report_rmp_hw_error(volatile u32 *event)
+static void amd_iommu_report_rmp_hw_error(struct amd_iommu *iommu, volatile u32 *event)
 {
 	struct iommu_dev_data *dev_data = NULL;
 	int devid, vmg_tag, flags;
@@ -485,7 +485,7 @@ static void amd_iommu_report_rmp_hw_error(volatile u32 *event)
 	flags   = (event[1] >> EVENT_FLAGS_SHIFT) & EVENT_FLAGS_MASK;
 	spa     = ((u64)event[3] << 32) | (event[2] & 0xFFFFFFF8);
 
-	pdev = pci_get_domain_bus_and_slot(0, PCI_BUS_NUM(devid),
+	pdev = pci_get_domain_bus_and_slot(iommu->pci_seg->id, PCI_BUS_NUM(devid),
 					   devid & 0xff);
 	if (pdev)
 		dev_data = dev_iommu_priv_get(&pdev->dev);
@@ -505,7 +505,7 @@ static void amd_iommu_report_rmp_hw_error(volatile u32 *event)
 		pci_dev_put(pdev);
 }
 
-static void amd_iommu_report_rmp_fault(volatile u32 *event)
+static void amd_iommu_report_rmp_fault(struct amd_iommu *iommu, volatile u32 *event)
 {
 	struct iommu_dev_data *dev_data = NULL;
 	int devid, flags_rmp, vmg_tag, flags;
@@ -518,7 +518,7 @@ static void amd_iommu_report_rmp_fault(volatile u32 *event)
 	flags     = (event[1] >> EVENT_FLAGS_SHIFT) & EVENT_FLAGS_MASK;
 	gpa       = ((u64)event[3] << 32) | event[2];
 
-	pdev = pci_get_domain_bus_and_slot(0, PCI_BUS_NUM(devid),
+	pdev = pci_get_domain_bus_and_slot(iommu->pci_seg->id, PCI_BUS_NUM(devid),
 					   devid & 0xff);
 	if (pdev)
 		dev_data = dev_iommu_priv_get(&pdev->dev);
@@ -544,13 +544,14 @@ static void amd_iommu_report_rmp_fault(volatile u32 *event)
 #define IS_WRITE_REQUEST(flags)			\
 	((flags) & EVENT_FLAG_RW)
 
-static void amd_iommu_report_page_fault(u16 devid, u16 domain_id,
+static void amd_iommu_report_page_fault(struct amd_iommu *iommu,
+					u16 devid, u16 domain_id,
 					u64 address, int flags)
 {
 	struct iommu_dev_data *dev_data = NULL;
 	struct pci_dev *pdev;
 
-	pdev = pci_get_domain_bus_and_slot(0, PCI_BUS_NUM(devid),
+	pdev = pci_get_domain_bus_and_slot(iommu->pci_seg->id, PCI_BUS_NUM(devid),
 					   devid & 0xff);
 	if (pdev)
 		dev_data = dev_iommu_priv_get(&pdev->dev);
@@ -613,7 +614,7 @@ static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
 	}
 
 	if (type == EVENT_TYPE_IO_FAULT) {
-		amd_iommu_report_page_fault(devid, pasid, address, flags);
+		amd_iommu_report_page_fault(iommu, devid, pasid, address, flags);
 		return;
 	}
 
@@ -654,10 +655,10 @@ static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
 			pasid, address, flags);
 		break;
 	case EVENT_TYPE_RMP_FAULT:
-		amd_iommu_report_rmp_fault(event);
+		amd_iommu_report_rmp_fault(iommu, event);
 		break;
 	case EVENT_TYPE_RMP_HW_ERR:
-		amd_iommu_report_rmp_hw_error(event);
+		amd_iommu_report_rmp_hw_error(iommu, event);
 		break;
 	case EVENT_TYPE_INV_PPR_REQ:
 		pasid = PPR_PASID(*((u64 *)__evt));
-- 
2.31.1

