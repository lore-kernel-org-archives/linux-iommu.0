Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010011.outbound.protection.outlook.com [52.101.193.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BB044B69F
	for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 15:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782747763; cv=fail; b=p7cKh9lu3RrDVhKkUoLhmoneSjveDkNPR5RwQy46JCxR7LdRiDoQT5lwWTgm5Bb219lNKiYIoJXSmw8sBt/B2Jak7iID53ZtYe8qHbf/zmjVC23bVJqfrwXncHCk52gRZkv9pt7BbFB7h5II/SvRcc1Y5FTqlJRcmnPJw71bSH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782747763; c=relaxed/simple;
	bh=tDDS3J24KuOhsYe3E3Ld0u1HiK67V+QNaMw9f5jI5IU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LP/F7RId/3odh68BE4y0jVQWPOVXX0JK1CFLTdQ4/EPDS/mckDteyJnE6SNdEPWyVIPOecAB8V65nTJ+MZ3odwyOrgLZnwyG3JXVAPjqx+oEjY+DuUA52VGlkeiGRu9Rta1aRHq9sV8MBgVIh9etKLSZgLmSAIwqBvCgIOmtqbI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rYq+sV2i; arc=fail smtp.client-ip=52.101.193.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rYq+sV2i"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bjzzl8JcR3FMdMj1kiLt5U5kcjMZBJapz7Z5hcgeLbXz0MLq8W57CDwSz0cOcC6k9Gxd0t9XuMVEzcZX9vtcxwEteUZ+GDX201Kf1mofOyGb66bwE75P0twbsHEj1xFb++bnSxBmathwdj8pq5OpeAVTgsW8Y7VbLGyMRmHfehynUEnpnhzA9x0IgAHDNHW4TI2j6UDsl30VwUACLG+qTFqtnQeF7IE3n2c+8/fedv/7yE57ZyEHiDdavn45iz/EEhr+5PTSuruDokvqprwklxkeXbK79K8JWibUV/GKWxX+UI5IeWERACTQtDIRlnIdWobWAvJbUX/MHivsgQfb5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xmykcP0bwdjLM17o3d5GEUsNyC/U9xPW7lvYh7Q8pxI=;
 b=g3HC9Z5fJWDHZkBDdvwQTUZoDA71oitayOFlf7WGqO0fJ2bjfhOh0jPIPfE5yt3JI20eGMVPKaqKu7oxgjEsTc3PseLP9Ao1kkAkbDxH6PUy2C1eG43+WIH6rrYYQogk210HgmAWr5z/bLW3l26N9713b0V9Gl2vtAnB7DWjWNBQFX/9Zdy8WQ/oc8R9kUPe7BvN7B4fQjgrgDW05FVaoFnQ/lvrFLiBUm0eggMJ0X2CMX/fOiKhJmPvDYtnAPRjTRyzUvunT7CfYRWFFiFlj/jyQMc/PJy8b1/GNRVdIRba+uoqPtk+9JR0pfDhNhEsUzd8HQgPjL7dLtxP7EX+SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xmykcP0bwdjLM17o3d5GEUsNyC/U9xPW7lvYh7Q8pxI=;
 b=rYq+sV2iIDS+XZ9EV1Q2J1buMeUncjmvRly9qjnMzzP477kJLPUdOwYvsXGcTDPmM3Mh7IPrXHGH1qbklIjV8V/ZbY+VZy2T8rjVWCIxqPc34zqQqBfVD0oyi6CSFHV9WiZn8WrKKyEfk7WqAbMCSlo3RbpRbg6HpgNefggIWpU=
Received: from BY1P220CA0017.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::6)
 by DS0PR12MB9346.namprd12.prod.outlook.com (2603:10b6:8:1be::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 15:42:31 +0000
Received: from SJ1PEPF000026CA.namprd04.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::48) by BY1P220CA0017.outlook.office365.com
 (2603:10b6:a03:5c3::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Mon,
 29 Jun 2026 15:42:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026CA.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 29 Jun 2026 15:42:31 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 10:41:58 -0500
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 08:37:27 -0700
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jay.chen@amd.com>, <wvw@google.com>,
	<wnliu@google.com>, <dantuluris@google.com>, <chriscli@google.com>,
	<kpsingh@google.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v3 20/22] iommu/amd: Reserve translate-device-id for PCI requestor aliases
Date: Mon, 29 Jun 2026 15:35:33 +0000
Message-ID: <20260629153535.15775-21-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026CA:EE_|DS0PR12MB9346:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dc715b2-9734-45fd-58e4-08ded5f5083a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|82310400026|36860700016|1800799024|18002099003|22082099003|5023799004|11063799006|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	syx/y12B5ULZq9JzdWDrJXpJRNP1gcEeZUcA8NdLOcHNtgnkbLCs4G+hXlb7b/FVOX4U+aLyCGk4QylxiTeYhr4sJRJ0ukQniWEbvjk3za/qfYQFcKlaHmLn6i/wWShool1seD4sXsW7vKNDOnmEeb4Hcel8159/AtBMjib/2g2rkoRJl5c5EFm42mTLRLe/K3QFmgmS8o9vtq6OWaB/8DfcDGEHndlSCUE/GM1tzq275LqyOO4oV4SFqoF8i3inySuN7NLhLEIH44a0Sw2N4vzxW+sRln3qoxv8HeyCV0yu6VKEgfedET7Xf9Tz0amBWwCRb0+/wXlTqjBIUqgrsvTaXmOO5uOcVezezmFDUngxuxckz3eQDJB+Y5D/S5YWPdNSo7YKAB1/D25HkL15sViTEXHwdcOlle8Csu3S3rLapQdItP3+lDmr+YqD4xlID7g8P9jMjbP1dbtsotJLdZCPKBnvOQv+1JlrDaYy1D8Fu1WgA4r/Sj8KuFiff7dU4TUn2e2behsqKHI5H6gZVBeQeVlxJGGBuMNEWsDnmSb7HzEFNe7hZ945FW8yEmBcQ/3bl7diwf8Jazk//VU+nW0nlTdv9y/IoIm9DFB/qWorV+1sveqP4TqLpSBfCPzIAmz/OOwFnb36s68+xPyoG1SdoKPEKsGpJfvi7M6ix9WwWdK07fim19SnRW6R9a22hmtB5kQPTeD26GPEqMq1UA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(82310400026)(36860700016)(1800799024)(18002099003)(22082099003)(5023799004)(11063799006)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	QLuVbz0CpzEwlJd0bWgX1t3buwGukGsFqn0uu0Cp9qZw+1R/86iiN3DHu/Ot+oVdGdBgCCDn+KXl5DSnWANZa4kgadyUXiSmOSDV7APavk+F2Arw7WsSkmCicr7jY4xHxGG/yMYxAceM1a3WyH/xrRwOCenFOYx3M1G+91+nVv1w0s6pU2MPRp5zUGPu8Ud3lKQhsi8E69o+wqcIcE97avInJWQ5u6mCpO3ig8NONsBq8ce2gFJVtH43TQz+8LiuB61MgfsJUpdgid3sWuRx46cG/ot51jF5tHeC84tnWDFvdQbeeDorgacv3ftNuiAF99FSA2fDUHW0o8tLKaqS33OoOSQ1y57SkA3uPzandlFJ5myQFVJd0BXpIJlo3fpXoc6mTXnFILM4efGpMwI+xzI5eI/n4QgF54RG1wMXCsCppnxX02Gn8KxOuewSXGir
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 15:42:31.4237
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dc715b2-9734-45fd-58e4-08ded5f5083a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026CA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9346

The per-segment translate-device-id (trans_devid) pool hands out numeric
device-table indices used by the AMD vIOMMU / iommufd path (e.g. mapping a
KVM file descriptor to a shared trans_devid).  amd_iommu_attach_device()
already calls amd_iommu_trans_devid_reserve() for the struct device's own
PCI BDF so that id cannot later be returned by the allocator.

That is not sufficient on its own.  The AMD IOMMU driver programs identical
DMA translation device-table entries (DTEs) for every requestor ID that can
issue DMA on behalf of the same PCI function: the IVRS alias from
alias_table[] when it is not covered by the PCI DMA-alias walk (different
bus than the device), and every alias visited by pci_for_each_dma_alias().
Those alternate BDFs are not separate struct device attach targets, so they
never received a trans_devid reservation and could in principle collide
with a dynamically allocated trans_devid.

Introduce amd_iommu_trans_devid_reserve_pci_aliases() in trans_devid.c and
invoke it from amd_iommu_attach_device() immediately after the primary
amd_iommu_trans_devid_reserve() succeeds.  For PCI devices the helper
reserves the IVRS alias when it differs from the device BDF, then walks
pci_for_each_dma_alias() and reserves each alias BDF.  Repeated attach and
overlap with the primary BDF in the PCI walk are handled by the existing
idempotency of amd_iommu_trans_devid_reserve() (a second reserve of an
already-reserved id succeeds).

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h   |  2 ++
 drivers/iommu/amd/iommu.c       |  7 +++++
 drivers/iommu/amd/trans_devid.c | 45 +++++++++++++++++++++++++++++++++
 3 files changed, 54 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index f99225be5d07..7300f07e7a39 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -223,6 +223,8 @@ int amd_iommu_completion_wait(struct amd_iommu *iommu);
 void amd_iommu_pci_seg_trans_devid_init(struct amd_iommu_pci_seg *pci_seg);
 void amd_iommu_pci_seg_trans_devid_fini(struct amd_iommu_pci_seg *pci_seg);
 int amd_iommu_trans_devid_reserve(struct amd_iommu_pci_seg *pci_seg, u16 id);
+int amd_iommu_trans_devid_reserve_pci_aliases(struct amd_iommu *iommu,
+					      struct device *dev);
 #else
 static inline void
 amd_iommu_pci_seg_trans_devid_init(struct amd_iommu_pci_seg *pci_seg) { }
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 01b755a2baed..fd25c4c361f3 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3085,6 +3085,13 @@ static int amd_iommu_attach_device(struct iommu_domain *dom, struct device *dev,
 		pr_err("%s: Failed to reserve device id %#x\n", __func__, dev_data->devid);
 		return ret;
 	}
+
+	ret = amd_iommu_trans_devid_reserve_pci_aliases(iommu, dev);
+	if (ret) {
+		pr_err("%s: Failed to reserve translate devid for alias of %#x (err %d)\n",
+		       __func__, dev_data->devid, ret);
+		return ret;
+	}
 #endif
 
 	if (dev_data->domain)
diff --git a/drivers/iommu/amd/trans_devid.c b/drivers/iommu/amd/trans_devid.c
index e5cca409d134..7c57087bfa10 100644
--- a/drivers/iommu/amd/trans_devid.c
+++ b/drivers/iommu/amd/trans_devid.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/pci.h>
 #include <linux/xarray.h>
 
 #include "amd_iommu.h"
@@ -81,3 +82,47 @@ int amd_iommu_trans_devid_reserve(struct amd_iommu_pci_seg *pci_seg, u16 id)
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
+ * alias (different bus). Idempotent for repeated attach; see
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

