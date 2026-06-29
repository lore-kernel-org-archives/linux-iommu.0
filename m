Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012015.outbound.protection.outlook.com [40.93.195.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51053449EA6
	for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 15:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782747758; cv=fail; b=NDsI39LDG6DnnEXYhXsvXfHnIrQbWSSXhsTY3A2bVSe0kasBILrEprjRz02c1EzBrQkT2KoefMXcLxrpWJbPkU+uaTzAPQY39+svn9Yr6QSYmzy/xWd+qkL4cqdRW04qu2yiaGteN9TSm4qHDFeCpMK4PISQUcHRmTxTVPl0Eps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782747758; c=relaxed/simple;
	bh=Jz7wNFEKFM67/zl0RlfU5cgUWy2dZd10OPbYX5YvGZo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nJiJIKmm/KES14v7NU5prNFMjbqod+13J+FOX+OB1pOF0h2zGUvh8JqF03n3Mn/F1oVfSe+vnVSQCcajAQRa1JyMr+paE5AsRmDH8rVa85rXTGfx5P78/w0fibtqYEMjRp8w6j8a6BJknoDC2FMn0LT9wicPUjlis88/Mb8+/5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=a2SSwkBe; arc=fail smtp.client-ip=40.93.195.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="a2SSwkBe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HMFKPutHrkGJZdWiAJn6KDoTki1uPvmy3TS4GqpP8MORd/ypJweUaUw7tVS80J2A5D1w2cZ1omkQoUe20bdr2ZAopQS3H8wM3Ydoo0ln48Wp9Jn8P1/Vw6e8aU+t9u1D/kCdu3DANZ1R6mj95WWDaq5w5ffHm/wtkUmNDub6XEQhxg5FXwmOYFbgveZkhL0FfenwA1mstmTg1N6G7AdHDHheK0bdK1nHwL5yBoF3qMNSm8AW3uSNHeU9awQvF+VpDapJF1Br7aZurg2gzxNXirBso7L+I1V2jQ7W4zVxSK0OTuHYFh3t1DhZHDmzr+xREukUa3MjHy8zkLZRHnF+NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J+9ed3MivaMe1GKITlTdVDfVAjBHvT3IopBBk7TuFdk=;
 b=p30DWr2ALn5J9++Ly+11396N0eSU57aErPMyYgqkM/8RrRUWXUhCQ2Lmj+p0YHCvJniQvd83IaNUVSDfbq4q0YYCyBoNtgek60X5HzNltAh5oX8GSsbN7meiTv5HRbcNDpKvOBWPdmoct04AhLbtDpYV99zctbvbqpsbFEPP5235Gc9epNKXBB9wSdc3Bx6pUtl6RULq8VUNNxRX9voRIOVIoVlOCUgFK7dIx9HoBIuDiUY8UNoF8yOhnHRGoGERmrJtut4tP6Tyexa0gPrfT61kw90wM0Jg1qZuFNQlDNP1q7uhCFobJKPDg/ikAYaBYe40MhiRyIs6xSy6oqhadw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J+9ed3MivaMe1GKITlTdVDfVAjBHvT3IopBBk7TuFdk=;
 b=a2SSwkBeQg6Po2gPJu8BDv6DbnJko3R4+fz49KU+tVwNNuhKr2poR6wjLXN9WI+lLP7r/tVwMdhReUFtIcxZPAaLuMHbhnQkPOA2oBI+PVT/o0gL3G+fuwxLDp323RDXbW944ZDKVRoyJR03ZvgivgtkKVfZBygbVbi0lUFHdkw=
Received: from BY1P220CA0024.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::9)
 by DS0PR12MB6535.namprd12.prod.outlook.com (2603:10b6:8:c0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 15:42:30 +0000
Received: from SJ1PEPF000026CA.namprd04.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::63) by BY1P220CA0024.outlook.office365.com
 (2603:10b6:a03:5c3::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Mon,
 29 Jun 2026 15:42:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026CA.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 29 Jun 2026 15:42:30 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 10:41:57 -0500
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 08:37:08 -0700
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jay.chen@amd.com>, <wvw@google.com>,
	<wnliu@google.com>, <dantuluris@google.com>, <chriscli@google.com>,
	<kpsingh@google.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v3 16/22] iommu/amd: Introduce IOMMUFD vDevice support for AMD
Date: Mon, 29 Jun 2026 15:35:29 +0000
Message-ID: <20260629153535.15775-17-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026CA:EE_|DS0PR12MB6535:EE_
X-MS-Office365-Filtering-Correlation-Id: 57c6232d-fe26-41bb-864f-08ded5f5078d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700016|7416014|23010399003|1800799024|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	BCIuF/AvV82vsADYiXj4or3KD2GfUuVmRDyWnQJWrzv4tyWBB5JAJh7PL5mjnFI20qtY18LWpgNWXepCNL4QdKz+az7NSRAr1sY1NymqF6mDVY1vehacuMuH1aSuffxywDQ9r6L2A5T2mK13i5x9MXPRfHrMcTGqzdEG9aZbhZYYHZx/dw81i5EtuQttmBwEuiIVdyNu7hFH9KbdGlWnmRmVnDV3fooRgyFu9zS8FDZIsHwSsEOkRbW3AQXfaZWWva7khZzc9fCVBVn4awjNlE+TPZUpw8pgDAbAs5ERlu2JE8LRMQh4BIJyAVT1F2EI1ril6QcsrNXB2tWrSNZX5fuJg9dVh9v7Sm//kBG8iBU5sP5bvW3cLxaE2fFM3LyJn/gS+kwPfWtKsDlzlO8Rq0pTs/fSnGQNMdKPJKjfklsaYETaggqdaH8RCpxBA+YWujRJO3RrY08IqkU3C28Qn1GKXCuUgDdEyVDXGTrlghdoqHNKbwZwoxPi6DwCF5SpGA7j1fCuE99dFSV3YtAEr/XIX1M4WkMN3vwSp2/mXh/dwGbisi6RQ0aLTTu2TYAMCqj1xw8dUPd8eTc2gGdqYkeruuNDfyfKZHkTYVm4T9XmiMWy2TBzIItuEPXMyrQPnyF7JPo7ubOzF73qqolVIRU5Kn8z7ruxjzeTIPrfNkAh8Y36Bv1XSzRaIV853BeDB2qJVynYEL80mknlmkGTxg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700016)(7416014)(23010399003)(1800799024)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hRbpsRyRHQtok/6IqX4mRbeS5uYuw4L9O9wz8SfJ4tJmz4pZtx7yMpwybhIjJTjLMZGXW+yePdvnHSNRs+teFRhFNeMGo8tBXR/XzAtetUtdwOnxhO+DJqZ7jWxTLz2DhXssg0wOCEU/Jt0NqDWSmb6sgcuWH/WOi6bhHMosdh0pTa3R/QBbi2ZQRnKZjP2dZnK4PVsnzNsjOzC8kTPo+u4FPGmin6XMWKKh7xZclLMKGOAm38q1qepPrsxi79que8BdtII7s8scaIu7wfvvHPcQjWpo2758M2vG4eyCpdiEAz57kXaJWii8RlAGFId63aHsqJs1EEmrsAcIz+kuIHuxjFjM1wJrUu4mFVBMk1S9gNHmolZRUn3K5G1JEE6MfAPmgwqyDffs0NEUhwoa6AEMm3SYC3sZmeUB8/B0VD2yHgzVFDsq/T1KlhivG5YP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 15:42:30.2869
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57c6232d-fe26-41bb-864f-08ded5f5078d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026CA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6535

Initialize vDevice for AMD vIOMMU by setting up the Device ID Mapping
table using the guest device ID.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 12 +++++++++++
 drivers/iommu/amd/iommufd.c         | 33 +++++++++++++++++++++++++++++
 drivers/iommu/amd/nested.c          | 12 +++++++++++
 3 files changed, 57 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 03346258e2dc..027d9cfa5533 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -388,6 +388,11 @@
 #define DTE_GPT_LEVEL_SHIFT	54
 #define DTE_GPT_LEVEL_MASK	GENMASK_ULL(55, 54)
 
+/* vIOMMU bit fields */
+#define DTE_VIOMMU_EN_SHIFT		15
+#define DTE_VIOMMU_GDEVICEID_MASK	GENMASK_ULL(31, 16)
+#define DTE_VIOMMU_GUESTID_MASK		GENMASK_ULL(47, 32)
+
 #define GCR3_VALID		0x01ULL
 
 /* DTE[128:179] | DTE[184:191] */
@@ -895,6 +900,9 @@ struct iommu_dev_data {
 	bool defer_attach;
 
 	struct ratelimit_state rs;        /* Ratelimit IOPF messages */
+
+	u16 gid;			/* Guest ID */
+	u16 gDevId;			/* Guest Device ID */
 };
 
 /* Map HPET and IOAPIC ids to the devid used by the IOMMU */
@@ -1122,6 +1130,10 @@ struct amd_irte_ops {
 	void (*clear_allocated)(struct irq_remap_table *, int);
 };
 
+struct amd_iommu_vdevice {
+	struct iommufd_vdevice core;
+};
+
 #ifdef CONFIG_IRQ_REMAP
 extern struct amd_irte_ops irte_32_ops;
 extern struct amd_irte_ops irte_128_ops;
diff --git a/drivers/iommu/amd/iommufd.c b/drivers/iommu/amd/iommufd.c
index bfc4b0ec22a9..1d159b78e37c 100644
--- a/drivers/iommu/amd/iommufd.c
+++ b/drivers/iommu/amd/iommufd.c
@@ -9,6 +9,7 @@
 #include "amd_iommu.h"
 #include "amd_viommu.h"
 #include "amd_iommu_types.h"
+#include "../iommufd/iommufd_private.h"
 
 static const struct iommufd_viommu_ops amd_viommu_ops;
 
@@ -126,6 +127,36 @@ static void amd_iommufd_viommu_destroy(struct iommufd_viommu *viommu)
 	amd_iommu_gid_free(iommu, aviommu->gid);
 }
 
+/*
+ * Called from drivers/iommu/iommufd/viommu.c: iommufd_vdevice_alloc_ioctl()
+ */
+static int _amd_viommu_vdevice_init(struct iommufd_vdevice *vdev)
+{
+	struct iommu_dev_data *dev_data;
+	struct pci_dev *pdev = to_pci_dev(vdev->idev->dev);
+	struct iommufd_viommu *viommu = vdev->viommu;
+	struct amd_iommu_viommu *aviommu = container_of(viommu, struct amd_iommu_viommu, core);
+
+	if (!pdev) {
+		pr_err("%s: not a PCI device\n", __func__);
+		return -EINVAL;
+	}
+
+	dev_data = dev_iommu_priv_get(&pdev->dev);
+	if (!dev_data) {
+		pr_err("%s: Device not found (devid=%#x)\n",
+		       __func__, pci_dev_id(pdev));
+		return -EINVAL;
+	}
+
+	dev_data->gid = aviommu->gid;
+	dev_data->gDevId = vdev->virt_id;
+	pr_debug("%s: gid=%#x, hdev_id=%#x, gdev_id=%#x\n", __func__,
+			 dev_data->gid, pci_dev_id(pdev), dev_data->gDevId);
+
+	return 0;
+}
+
 /*
  * See include/linux/iommufd.h
  * struct iommufd_viommu_ops - vIOMMU specific operations
@@ -133,4 +164,6 @@ static void amd_iommufd_viommu_destroy(struct iommufd_viommu *viommu)
 static const struct iommufd_viommu_ops amd_viommu_ops = {
 	.alloc_domain_nested = amd_iommu_alloc_domain_nested,
 	.destroy = amd_iommufd_viommu_destroy,
+	.vdevice_size = VDEVICE_STRUCT_SIZE(struct amd_iommu_vdevice, core),
+	.vdevice_init = _amd_viommu_vdevice_init,
 };
diff --git a/drivers/iommu/amd/nested.c b/drivers/iommu/amd/nested.c
index 81a5ae00225e..524362aed269 100644
--- a/drivers/iommu/amd/nested.c
+++ b/drivers/iommu/amd/nested.c
@@ -227,6 +227,18 @@ static void set_dte_nested(struct amd_iommu *iommu, struct iommu_domain *dom,
 
 	/* Guest paging mode */
 	new->data[2] |= gdte->dte[2] & DTE_GPT_LEVEL_MASK;
+
+	/* vImuEn */
+	new->data[3] |= 1ULL << DTE_VIOMMU_EN_SHIFT;
+
+	/* GDeviceID */
+	new->data[3] |= FIELD_PREP(DTE_VIOMMU_GDEVICEID_MASK,
+				   dev_data->gDevId);
+
+	/* GuestID */
+	new->data[3] |= FIELD_PREP(DTE_VIOMMU_GUESTID_MASK,
+				   dev_data->gid);
+
 }
 
 static int nested_attach_device(struct iommu_domain *dom, struct device *dev,
-- 
2.34.1

