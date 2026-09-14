Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012025.outbound.protection.outlook.com [40.107.200.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52F539E6DE
	for <iommu@lists.linux.dev>; Mon, 14 Sep 2026 18:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789411827; cv=fail; b=EvHgca1Gr6lg7M5E/lJbYkUCS676UXjSvFlS+5vO9KOgocQjvMIQKKC389HpSejTVzk/pyWhOOqrf3sezVST1f8DTQ6GA3NQxilC22RbzlKI/9+OqR471+BEhOsEFMgo2GYLmNalyq9p+1hHYgw3JtdUOf9GPIDDM8h+8Vxbjng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789411827; c=relaxed/simple;
	bh=JwxorQLBG0ZrHrMC8fZlTGXaGChrxmT5lHERbzJnI/w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hA3xCEB361ruFxcmBwubvA85QrdYs+HHwrp/LZDCeeqFN7ABlhefi9G7PgrG9dibFed8xZKLxRMRI/Dv2G/DLvg//33SKHLl6UXN0cvVZrgzmX7h7wajp/MXVdMGmi6v02Ik+4GT3ZHgF7Vl/l7HVnBzowsjyNydknGSFo2Rs78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fFsROjzX; arc=fail smtp.client-ip=40.107.200.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fFsROjzX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l3sNhLg5TV6I0FrgAb2y6KWPxDPUVX6DuTIRXWwra86nlKz6ZDnXn1ZYzIX3SxidU+esA1zu5H7vYFtbht5ai8dUCyINJ6GSLM9aNBeHBwzx5D1Inb9ukOZZu4NhldXtKlsxY/D9M1qVdPZWJdfqAY3d1+kmuPVqB91maLbRTiLvEOh73//mLhbIUBU8BVwIlSqnWZlrbfqKsM5ufLOLg60KfOeYP3Vuln8gjN0G+PMLqvEU2RyzWScq/BflWeTMdcZhTUjQ8B3nDHdLKEDtGvvJ0u6vpL2aPDvGj3AAfsZ+WHY56PWlLjjVMC0bc1gIERBuAmUnn8v4hWfsfkhZmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ln1f0dHidx6ac5KgMijDZnnmkQUNwIp/VGcgroP4uyQ=;
 b=av4kD39qVzv4TBbvdAp9c01Hpj7PlOD2BzmB+ngOqMzXfKpFoiRwzbMGbFRCdoH4mjUKOud8xuITbKgdtYVd7nbdt8R+mT24E++GWBBq+gRflkWoGNMDxYuFOX1m2RpNp8SNXallcg35pqV4yhcoI++HoNtRBd4LJlQ9xzwi4J906CAPHQB+DiDfmHILUJe3Igk8csNKgxFnp/2fs68vRxf26rxOiPsBm/C7RMkOCMux3fcDTb61Gp35U/+0EEkSBtva+4xfD68tYpWWl2IrN2bU9FI4CSVf4476Z3FFxAkz5gCza0XFexwqdx1itvDqHtE30w+mLF74AmXs1Zvy+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ln1f0dHidx6ac5KgMijDZnnmkQUNwIp/VGcgroP4uyQ=;
 b=fFsROjzXJROKfpKUDvSonuhu0gn2RZZxb4JXj0v3Bqu6gUTH/hUN+FMBQvffsE+KW3+KG/sN9k5z+aEHDWPgMllyd9h+BZ+ZqG9VMOzQnGczk/o5nYLFg9TBRFuQbT85nL92wPr/YBqnqWFuRNXC18qXdS+tCFgDNOHjrfSg29A=
Received: from BN9PR03CA0946.namprd03.prod.outlook.com (2603:10b6:408:108::21)
 by SN7PR12MB7451.namprd12.prod.outlook.com (2603:10b6:806:29b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 18:50:19 +0000
Received: from BL02EPF00021F6E.namprd02.prod.outlook.com
 (2603:10b6:408:108:cafe::8e) by BN9PR03CA0946.outlook.office365.com
 (2603:10b6:408:108::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Mon,
 14 Sep 2026 18:50:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6E.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Mon, 14 Sep 2026 18:50:17 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 14 Sep
 2026 13:50:11 -0500
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
Subject: [PATCH v5 20/24] iommu/amd: Reserve translate-device-id for PCI requestor aliases
Date: Mon, 14 Sep 2026 18:47:46 +0000
Message-ID: <20260914184750.222939-21-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6E:EE_|SN7PR12MB7451:EE_
X-MS-Office365-Filtering-Correlation-Id: 81e653e6-9311-4846-d296-08df12910568
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|82310400026|36860700016|376014|7416014|11063799006|5023799004|6133799003|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ApbT7+k3O7KCHhejs593rDIxo4flLNCTiKv/rwFogIYcBFyF6l2VQNT9viSv9hEzDLG/dnTU+ZikDUJm2NyXZRCJGTHfQ/u399ESu7fW57uokRHV4wY9NWxpWseYByMhIQag9qRBqBot8J8WlbZm1uFLBtFp33lqWu7mH/wHnbj/WE/dq55gz25Y5yQjVCcN+acUJqBCCDrkHPSrPYltMnvItEe1lgt/zn5A3GAzTFlMbcPafQ/Zr6KLoOqAADH8hTY+7aOjp5pW8OPg9wOPs/4ojeYwhTtPUYU04IdMx5ebdNCxF2B36qVLKanPhZRrkR8JmOVQo4I+MBeoqsnhzQrPfI3PGHXH+wrxamfvVA8+r7rsmUKrUDtNRiIkox3wQMtD7wYwXlsSd82LXjTxCFkLCJOU6mBOw1bnRaLz/rO30vrX7B2SQdrxzOaABzjxwtnBJxoFUapwVqywpcxkEhdzHIJABOvJJVt3Cg3K/rZ8dQ3LO7m6P1ZxrM+zTQDUaihmSQjcbyoU/Zb+v1UE++EQVvVwiRHvkzFZqVqtfLhaoU1b+MOOw0op2NHnxmcr0ezZhPraHlWeMF9D5E849qe5T6dhggqvotxmI8cqpZ2q+OgZpuF0pcETwEJdSjko3vH0gQKWPMfo7jt+j9X2G77NlkFnDNRCOCWGJHyhig06BmpTcdfViAatgtK79tupEvhEMIM4RF2xOKSP5+7Tzw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(82310400026)(36860700016)(376014)(7416014)(11063799006)(5023799004)(6133799003)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mjTCELuJ+JKyUuENFSoq7Sk07zIhXhL9pStPRYG1lopBeiDB6o7m4d6IqcOsaK5STDAZ/FSV+mUisIIfyFXLs5qatSNWkpYuGBbEHlObfek3T4s4+j8DmY6Mk26Wy0Rpl0twJZzO+lbu1L1bDOyXZV5ncGTboxzv/sPw3eGmQ1y9koA/7+XNXbwV3y9UW1WYSQEJnHsC57L62i2LDFz+f5Y/F5epSvdiQdZzhnmMCh0F5EPK7H07Fnoa7zPIRyqgSUAo8MeyM+LtcQWIUzYqq3pkwcs7Mojy20NhLCJkubDUoWIMoJOxl6U6tdrz/9O3nUn0lNGxxE2LAJKZRIi6Eg9M4MaM9TEswEKbKMk31KlJNDhbr8MoOdZtckt1ReVqQgSB6/WPQUWz7r0RngGUJkNdy01jBald7UHeipGdHZg/Fhu0my6G/NorRCX1AhJS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 18:50:17.9773
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81e653e6-9311-4846-d296-08df12910568
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7451

The per-segment translate-device-id pool tracks which device-table
indices are reserved for real PCI functions versus available for
dynamic allocation to vIOMMU translation DTEs.
amd_iommu_probe_device() already calls amd_iommu_trans_devid_reserve()
for the struct device's own PCI BDF so that id cannot later be returned
by the allocator.

That is not sufficient on its own. The AMD IOMMU driver programs
identical DMA translation device-table entries (DTEs) for every
requestor ID that can issue DMA on behalf of the same PCI function: the
IVRS alias from alias_table[] when it is not covered by the PCI
DMA-alias walk (different bus than the device), and every alias visited
by pci_for_each_dma_alias(). Those alternate BDFs are not separate
struct device probe targets, so they never received a trans_devid
reservation and could in principle collide with a dynamically allocated
trans_devid.

Introduce amd_iommu_trans_devid_reserve_pci_aliases() in trans_devid.c
and invoke it from amd_iommu_probe_device() immediately after the
primary amd_iommu_trans_devid_reserve() succeeds. For PCI devices the
helper reserves the IVRS alias when it differs from the device BDF,
then walks pci_for_each_dma_alias() and reserves each alias BDF.
Repeated probe and overlap with the primary BDF in the PCI walk are
handled by the existing idempotency of amd_iommu_trans_devid_reserve()
(a second reserve of an already-reserved id succeeds).

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_viommu.h  |  2 ++
 drivers/iommu/amd/iommu.c       |  8 ++++++
 drivers/iommu/amd/trans_devid.c | 45 +++++++++++++++++++++++++++++++++
 3 files changed, 55 insertions(+)

diff --git a/drivers/iommu/amd/amd_viommu.h b/drivers/iommu/amd/amd_viommu.h
index b3717a006301..c91ba854847d 100644
--- a/drivers/iommu/amd/amd_viommu.h
+++ b/drivers/iommu/amd/amd_viommu.h
@@ -34,6 +34,8 @@ void amd_viommu_set_device_mapping(struct amd_iommu_viommu *aviommu,
 void amd_iommu_pci_seg_trans_devid_init(struct amd_iommu_pci_seg *pci_seg);
 void amd_iommu_pci_seg_trans_devid_fini(struct amd_iommu_pci_seg *pci_seg);
 int amd_iommu_trans_devid_reserve(struct amd_iommu_pci_seg *pci_seg, u16 id);
+int amd_iommu_trans_devid_reserve_pci_aliases(struct amd_iommu *iommu,
+					      struct device *dev);
 #else
 
 /*
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 34915e5ff156..fd3d717650fc 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2745,6 +2745,14 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
 		iommu_dev = ERR_PTR(ret);
 		goto out_err;
 	}
+
+	ret = amd_iommu_trans_devid_reserve_pci_aliases(iommu, dev);
+	if (ret) {
+		pr_err("%s: Failed to reserve translate devid for alias of %#x (err %d)\n",
+		       __func__, dev_data->devid, ret);
+		iommu_dev = ERR_PTR(ret);
+		goto out_err;
+	}
 #endif
 
 out_err:
diff --git a/drivers/iommu/amd/trans_devid.c b/drivers/iommu/amd/trans_devid.c
index 195551fcfc1a..19a219519c92 100644
--- a/drivers/iommu/amd/trans_devid.c
+++ b/drivers/iommu/amd/trans_devid.c
@@ -11,6 +11,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/pci.h>
 #include <linux/xarray.h>
 
 #include "amd_iommu.h"
@@ -85,3 +86,47 @@ int amd_iommu_trans_devid_reserve(struct amd_iommu_pci_seg *pci_seg, u16 id)
 			 pci_seg->id);
 	return ret;
 }
+
+static int reserve_trans_devid_each_dma_alias(struct pci_dev *pdev, u16 alias,
+					      void *data)
+{
+	struct amd_iommu_pci_seg *pci_seg = data;
+
+	(void)pdev;
+	return amd_iommu_trans_devid_reserve(pci_seg, alias);
+}
+
+/**
+ * amd_iommu_trans_devid_reserve_pci_aliases - reserve translate-device-ids for
+ * PCI DMA aliases and for the IVRS alias when it is not walked as a PCI DMA
+ * alias (different bus). Idempotent for repeated probe; see
+ * amd_iommu_trans_devid_reserve().
+ *
+ * Return: 0 on success or if @dev is not PCI; otherwise an errno from
+ * amd_iommu_trans_devid_reserve() or pci_for_each_dma_alias().
+ */
+int amd_iommu_trans_devid_reserve_pci_aliases(struct amd_iommu *iommu,
+					      struct device *dev)
+{
+	struct pci_dev *pdev;
+	struct amd_iommu_pci_seg *pci_seg;
+	u16 devid, ivrs_alias;
+	int ret;
+
+	if (!dev_is_pci(dev))
+		return 0;
+
+	pdev = to_pci_dev(dev);
+	pci_seg = iommu->pci_seg;
+	devid = pci_dev_id(pdev);
+
+	ivrs_alias = pci_seg->alias_table[devid];
+	if (ivrs_alias != devid) {
+		ret = amd_iommu_trans_devid_reserve(pci_seg, ivrs_alias);
+		if (ret)
+			return ret;
+	}
+
+	return pci_for_each_dma_alias(pdev, reserve_trans_devid_each_dma_alias,
+				      pci_seg);
+}
-- 
2.34.1

