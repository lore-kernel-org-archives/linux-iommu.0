Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010024.outbound.protection.outlook.com [52.101.61.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942923ACA61
	for <iommu@lists.linux.dev>; Mon, 30 Mar 2026 08:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774860178; cv=fail; b=d2vMAEoAQjU+qFe6pInfV/H94o3S15JVsfw3IOrgGAdblKAEINE0hgM+GpjnJBTHFNIpl3uF8VNXzNlPT5VqbD6gYPz0noyI4HYfMHElR1dRM98JfGjuuW/yBS6yL5udC/VGN+Vow07BPctClEGei9Yl8MvtR0AhD93eDkFY0ig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774860178; c=relaxed/simple;
	bh=yBn/R3b1fTFIetYCCR6x1tLlgxBpCGl2vWQarZ0Ih0I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kkFvNpgDFrZyEsV+H4tTzvGEEtthCo3mizG+JN3RCMUWBQ2p5sb3nGuQIYLVN2H28DD3ndAgzaTmKs24+XC6EHwM58fH46qCyacmoMmeSm0MDj/PSL/EmqVxFUC8HP9oyzFCW1nAHqKmIg6J9UYNNmh7Ya8/T8Sjpy3Zv/kx5ug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UDbjCx09; arc=fail smtp.client-ip=52.101.61.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UDbjCx09"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hYcp/lasZZZ/BY5E8VC8RDYO7L1NLn9I5LMhKdQbeFHR8WxtW0QjdKNk1YYGhcF3ZNVb2hy9webBz/KZtK0h9vEJXgteWPnzgak1j/F14Sj5QgeYefWtgU6fzS3pjqMMJ5N3C+GcM2b/iGS5/nWkGsazHc/wcHmXmiYdFJr0YagV+Fot4LrYAM+7s3uZrsbvxTw+TQQZlVNXmZEe4k4iwOgHMlqZFUKGdLRiytp4UTA4Hn28lGwKz18J5be+WMRKrUn0GJvV3UVns+58valhTwylWJLzNn1ZIZcrWdCH8IMaSH20E6oOm2/VAZWh3EwqFYALMocPJRuYgA6fja72BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yKF/s33bT+7ru4oJbgCrZyt3fA7xjdoZYs+zil/OFtk=;
 b=mWjRQwIGMP5zMezaCq68ABbN+TQayT1iA+VOItQL+ww8F3xq4rarz2bZRQ3HsUGTYKKIqol35vM/bQKryRsrXgPphJ/4m1l8CNz1TY6NxgT7nfvWYSnaj3KpXlCh7XhDaKQprV7ruNqkG+EFz5AfuScMliAVavYaFF6l/gjZ+BMIFVYucuIuGfnR955aOuT+uUqk24piSoSWZRZGzh+dl6XY5EJr8uS0hTOS9CpRilFUPuFx5fX+TSbeJXQOuQGxmMSlmUa2mYiYyUM9GM1wey8xy9MLvyOQ7KzPH4G4HuNV/GWsQrQK+n8fjatvS7wvh1hiCoYxuq9iyP1yYy2guA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yKF/s33bT+7ru4oJbgCrZyt3fA7xjdoZYs+zil/OFtk=;
 b=UDbjCx099tx1hxxF81x7K2V7VShBlTYeoUvcX3KRr9EU4v0m9Ca6Dg1oRLoujC1FrzxnoThf28HBat0ETaJ/CHaJLbcx9V6ZgPz26DRyQat2xL5U55wmqugj24lsE8dhrgDkEsOldmKmRu3NL/zbM0+wBytw740xzt2NhkNEbAY=
Received: from DS7PR03CA0236.namprd03.prod.outlook.com (2603:10b6:5:3ba::31)
 by LV3PR12MB9259.namprd12.prod.outlook.com (2603:10b6:408:1b0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 08:42:50 +0000
Received: from DS1PEPF00017094.namprd03.prod.outlook.com
 (2603:10b6:5:3ba:cafe::a2) by DS7PR03CA0236.outlook.office365.com
 (2603:10b6:5:3ba::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 08:42:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017094.mail.protection.outlook.com (10.167.17.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 08:42:50 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 30 Mar
 2026 03:42:45 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jay.chen@amd.com>, <wvw@google.com>,
	<wnliu@google.com>, <dantuluris@google.com>, <chriscli@google.com>,
	<kpsingh@google.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH 02/22] iommu/amd: Introduce vIOMMU-specific events and event info
Date: Mon, 30 Mar 2026 08:41:46 +0000
Message-ID: <20260330084206.9251-3-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260330084206.9251-1-suravee.suthikulpanit@amd.com>
References: <20260330084206.9251-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017094:EE_|LV3PR12MB9259:EE_
X-MS-Office365-Filtering-Correlation-Id: daf5520a-fb32-4f36-b539-08de8e385378
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|7416014|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	/T+Rdb0OoEuXzWiVoW95J7xsdT7e68B3+dRUEfdSbwUc5iqvTvEI3eJyh8OyJGylCZX3sQEsyv7YrG6kxsvfARMIhJWLWR1PG/vaobFu7HCpF4aFUGeLzT3uIPwo0fIp8fDjfHkNaz8feHNKxb2iM5lUk/3z/Sb+ESQpZPQCLdVM0PiBV0Nu6FjblEl7YEpifkkx2yvIk9+NHLAD8P+J01X73IweND07EgJOj5BKWo2N4nQn3+Xyx7gqXyefsYnn9QTjCdDuOw7+tjSKXjSeg+BnghgkU9/LSHWlPDXD1HBYd5Wm+btniMnX8urt39DoWPHUIS/hX9Rru+sc5kd9VfVBdCwkSHj7cYZeCPTBvJcijOza+Vb1FRzQswd3GHQ19avQIVC6vrXa+QwUIwMyojniGwlt/HQSQ9cmtmIMckPXMwbXLZV+VSZtSUIns3c789gWVmuK6EL1smnK1Ssz7Vr4J9We/wRrZ4nG6FqS7aiBO1wzlKRBTdEXtQQp89X1VFA+MO5eNkWOQHHCW9rEw6G4T4Hz/mTXetvEzNO3FoMLtkeF0vS/JBZjpbVp4erWcXIn4nkhfiPiWm6GRRyZ24blGScLhk4v7qiFdXPq5ziZ5HWZux6mhrykZxpeQNCvYuzpo7uiabRMEhgXVCfkH+aB2q72uKg6h3A7BIvCYPAw1yP40DaFJ1DZ6wKDQ9/aIgeOKoUMsAZdHeOtdTpMr0nCZ/pJ3Aq1kfKQYZ5GSHlZeEhmI6IdptNADHu4U3W5iJ+5IUMEhbavlI05Ex00QQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(7416014)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Lmd8bB7WklGqNyL8GlbjN6wbOXFfc0Bq7ic6PZ7yZNqi0IaF7isF1EOvYITHQYpTRebvTbhoj4bpIchheErzRVCPCmyCU9Xv6zUQf1Jb155+RWgSmQJRMX3MCZOFxoHtTXfSKNlTyaw0JiZhB48h+q9MbTOKNriZwIlacfEP3skVxYVM7FBeGrVkdtKOlgx5E+UuhaQlAaNbdn+8ZL0FbHz/GK73XbpoBc8exVAEz6W3+sSPtOgHW1nOQEe9n32gSqYsxkPdUb1KKxMwcxeRL4nFq6dfeGB7sx//VCBIh1i8NhF6oLrm65xLQJpoYlB2OvQasRUmfozHe6V6uagD/lu/duJt2XvYGlqfcI3AWe8FPpfb8MDRxn9P8FI+hN1A+0UkrHsdqklz68UG/s2jT3rstE13e5KCE3rbV7ukPLbkhsjsuXFJzQ/d3xV7GvvO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 08:42:50.2110
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: daf5520a-fb32-4f36-b539-08de8e385378
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9259

Adding support for new vIOMMU events:
  * Guest Event Fault event
  * vIOMMU Hardware Error event

Also, adding support for the additional vIOMMU related flags
in existing events.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  3 ++
 drivers/iommu/amd/iommu.c           | 58 ++++++++++++++++++++++-------
 2 files changed, 48 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index cfcbad6c28ff..31f7f426bab6 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -153,6 +153,9 @@
 #define EVENT_TYPE_IOTLB_INV_TO	0x7
 #define EVENT_TYPE_INV_DEV_REQ	0x8
 #define EVENT_TYPE_INV_PPR_REQ	0x9
+#define EVENT_TYPE_GUEST_EVENT_FAULT	0xb
+#define EVENT_TYPE_VIOMMU_HW_ERR	0xc
+
 #define EVENT_TYPE_RMP_FAULT	0xd
 #define EVENT_TYPE_RMP_HW_ERR	0xe
 #define EVENT_DEVID_MASK	0xffff
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index ffa65a97ba86..d1f997b9a90b 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -849,7 +849,7 @@ static void amd_iommu_report_rmp_fault(struct amd_iommu *iommu, volatile u32 *ev
 
 static void amd_iommu_report_page_fault(struct amd_iommu *iommu,
 					u16 devid, u16 domain_id,
-					u64 address, int flags)
+					u64 address, int flags, u8 vflags)
 {
 	struct iommu_dev_data *dev_data = NULL;
 	struct pci_dev *pdev;
@@ -884,13 +884,13 @@ static void amd_iommu_report_page_fault(struct amd_iommu *iommu,
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
@@ -927,29 +927,42 @@ static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
 	}
 
 	if (type == EVENT_TYPE_IO_FAULT) {
-		amd_iommu_report_page_fault(iommu, devid, pasid, address, flags);
+		u8 vflags = (event[0] >> 27) & 0x1F;
+
+		amd_iommu_report_page_fault(iommu, devid, pasid, address, flags, vflags);
 		return;
 	}
 
 	switch (type) {
 	case EVENT_TYPE_ILL_DEV:
-		dev_err(dev, "Event logged [ILLEGAL_DEV_TABLE_ENTRY device=%04x:%02x:%02x.%x pasid=0x%05x address=0x%llx flags=0x%04x]\n",
+	{
+		u8 vflags = (event[0] >> 27) & 0x1F;
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
+		u8 vflags = (event[0] >> 27) & 0x1F;
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
+		u8 vflags = (event[0] >> 27) & 0x1F;
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
@@ -981,6 +994,25 @@ static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
 			iommu->pci_seg->id, PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
 			pasid, address, flags, tag);
 		break;
+	case EVENT_TYPE_GUEST_EVENT_FAULT:
+	{
+		u8 gid = event[1] & 0xFFFF;
+		u8 vflags = (event[0] >> 27) & 0x1F;
+
+		dev_err(dev, "Event logged [GUEST_EVENT_FAULT gid=#%x flags=0x%04x vflags=%#x]\n",
+			gid, flags, vflags);
+		break;
+	}
+	case EVENT_TYPE_VIOMMU_HW_ERR:
+	{
+		u16 gid = event[0] & 0xFFFF;
+		u8 src = (event[0] >> 16) & 0x3;
+		u8 vflags = (event[0] >> 27) & 0x1F;
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

