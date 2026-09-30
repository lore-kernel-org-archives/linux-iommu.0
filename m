Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010016.outbound.protection.outlook.com [52.101.85.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97D7469837
	for <iommu@lists.linux.dev>; Wed, 30 Sep 2026 09:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790760375; cv=fail; b=tyweFA0ZUqQbZYtehNkBm8PkpbzrI6NzEAKLIdA8c6ZBgXaSaswX9ajW4NR9TNiSONub+rmIxzVaPokQjYKNwyfCYEkNck3ezrWaJRyx6ftZQxD8Avh4ZIW0ZZ9NYkbrRcz8bQBeS1/0BgvA5C3uYtK9mhsZBRmenWNHlwdWq08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790760375; c=relaxed/simple;
	bh=QTVlSa5Yurpk0wLZWqNr3RCKeTVft1M3mPnLXt+kkvI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DuCFaTnpAwKYIg9z9aCIy5VEzYNHlpkjfSktOxQyfQ+6nWsB8M4+Azukm4vZZEAnzsjvb2DkwOpjCzMmf2WmLdJDFVt8vmEMmYrAHiUoEJAdWqehY/aKzurH4bPK3ECyGbkfWv8Tv/oM3eSFGeo199bdXMNJJ2gbU5p65ZptPFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5g4McGdl; arc=fail smtp.client-ip=52.101.85.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5g4McGdl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tg8IoCe+Q+fG1PbHa0u/4yexsP4u8Dgv0NoHuGfzmibaOFDAiZh2M4lSsZHY+74pcFgX2HgZ/nrYKXMah9ubpw0lHMuP6VhbtD9kWUf82wYpt71KKLA+P33f9dOXeTkEJ4xUh6EK7TDkq8B9neR5+uTYFdw694JNyx1A/YaAdHFt7J65c+uJh+Hu5CwCOd55jnt2aKd+V59MlBIsC+jddUQ57FOEOksL5AkYcOgQSlRaDuOLwKuAA9lkTIZxETz9Avc6X11nNwNztwuEEvB116FqY1PARJ2phKADb81H7xZ6Jxo13LVXKVnDHGHJ2V5aREMFEWO4LbHs9YRtks0+mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jfD7oItNEtkNUAWOQV3o0eJrNWhKtdvpRj+YURbASBE=;
 b=q67hx5ENRDmUoD4zk+ht8POClbQYUvdPQ8W9LWtVV3GXC9pbCawH8KaRe4Z6zFsSrAMMxLrfqsE7i1XHzlDTK1d+3WihCml4NJqfVUCMQH/jx/ynBq2fXRVk7qk/nlPB1X4tckSyY/js4fF6xBFscXLkEHG0C5rDVgGWsf3NU12L21E+zTMhujt+9FfEtveKIdMLGAsDv4XZ+YDrX93g4cUuLV5sDJ0cSCP/cbrVHz20b4HOnrP71aCY4CLWZM6ApiOGlWXga9FLj31U9NvSVHjZSsiXQFQnDDSrhoxGOpuVBPlygE6fFgN86uBAEURT+bqpJLPr5IYjVE2fV7cKAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jfD7oItNEtkNUAWOQV3o0eJrNWhKtdvpRj+YURbASBE=;
 b=5g4McGdlreZ5uEfjnDiWHzgpoPCv685NP7GqK4O+ONfbeLBvwSPm0XCGbId4ITTnANOFTx4FA59+PfBTqBi4OzeJ6r6D5Yg0cRP7uGki1nNwZRzP/8Pr3OmDQozaIAyYIZ42I2MtiuG+QpUgF7ilr/5mdMJDGf3dut2f683V6oQ=
Received: from CY8PR22CA0015.namprd22.prod.outlook.com (2603:10b6:930:45::14)
 by DM6PR12MB4153.namprd12.prod.outlook.com (2603:10b6:5:212::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 09:26:08 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:930:45:cafe::79) by CY8PR22CA0015.outlook.office365.com
 (2603:10b6:930:45::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.15 via Frontend Transport; Wed,
 30 Sep 2026 09:26:08 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 09:26:08 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 04:25:59 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<Sairaj.K@amd.com>, <jay.chen@amd.com>, <Ming.Shu@amd.com>,
	<SooJin.Tan@amd.com>, <chrisl@kernel.org>, <wvw@google.com>,
	<wnliu@google.com>, <dantuluris@google.com>, <kpsingh@google.com>,
	<alejandro.j.jimenez@oracle.com>, <joao.m.martins@oracle.com>,
	<guanghuifeng@linux.alibaba.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: [PATCH v6 20/24] iommu/amd: Reserve translate-device-id for PCI requestor aliases
Date: Wed, 30 Sep 2026 09:23:40 +0000
Message-ID: <20260930092344.5616-21-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260930092344.5616-1-suravee.suthikulpanit@amd.com>
References: <20260930092344.5616-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|DM6PR12MB4153:EE_
X-MS-Office365-Filtering-Correlation-Id: 33ef4c75-5200-4921-8b0a-08df1ed4dc23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|1800799024|7416014|82310400026|376014|10067099003|56012099006|5023799004|6133799003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	P/wFK9lo8OxdPayrYnNxezOYj43OR1OQCLQhD2gnR42LY247N9oh3o3CekEiNF7hodkh/NznogU3diXKwiIE0a+UvLYKERDignsS3A5ssDgLiFo/7ny2O+lGMusU0Q/YGcKTDaL6O5MaXQ1Puv/EtZE2ph4ydJLxlDTTpKC4kJhesIm8KzuuIDzoSfxNlw39IjqFeht5vHC5SeukODICEmTensRABvnJwp5UDr4JmnLj3HXjPfnfY7fRVYqTdN5H6C0VXJCa5zr9D1QKEWQq+jxnH2FXWH6HXtJqI083jtn0rFLCySmcPC0IerfPerEOJDsuajypf8eVEGHIuM/UAUid7mZoz+2ywrEmnqyLYn533V1n0B1SR/JsVVimtVumVkgqTMBSMYipctyv4QvsiTx0LgLr/wXQOvBNfkzH/dgFARKz3HXw3x30UGo1GAjKroqgyxEIsdatcJGyBbFc7V3E+wnIA331sCknmGWSVJ0FMlKBqpRMoL5f9HVjhF89wVAzt9DA+FR+DwIht9DzezjG48eUgsysRKb1Rep3XL9TSmDH3GAEdBUHdR1MaMItJYxZbaQT9QY+JOyar+0xh20zBahHNlCDYBGl5ysMWSmWXVEqrm8PUt69TH7ugF27Iq97C66iJ357oSIYFPEFGDoFL/YmOGyrj2iaNm5nJX3dMDNYxp7vfdY7wM1ynZZLxIcezrut6nFZuNWwWBGyRQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(1800799024)(7416014)(82310400026)(376014)(10067099003)(56012099006)(5023799004)(6133799003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	SozMPNiNRO0Rxxy0hmETShLE9XCi46HiOHxe4eqx7CWZsWadm17pIS3R/oSikgzLYVBFyyABX45Wd7voDzhgdyfXqAB4cW+8u6Djramzh3Gdq5O9ZA3n4i0632ti5kL6EQVE2Hp8/MX2vnTCeObF4rib514Gp0W3z+/z0lQhOtt9eKL0dSJ7g94fndWrnWwN01uj2UtB68zBlxC8fAmVag0OX064AJVipmZoZ1TlmsQB4UY0ZaT94uVgjjGH0we4Z4RRKUQISEuofikU8yEYrJ3ZeCyGL8nezzZ7VRL+0X3qQrpG7e3eCGvBTx6i6BuuerRheeA2vkPfOFmWk/iAHWrybaXKIKfa9onyMnHrEyGCf9oKiHARMlKc8KfrLoItGl+jTGWGU/vZ4DFc2FG08lV3GL2jpurVXtxxGIZfgejXEZrRC2oyhD200y39nBvP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 09:26:08.4430
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33ef4c75-5200-4921-8b0a-08df1ed4dc23
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4153

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
index 772d99391b6c..44a342608d43 100644
--- a/drivers/iommu/amd/amd_viommu.h
+++ b/drivers/iommu/amd/amd_viommu.h
@@ -32,6 +32,8 @@ void amd_viommu_set_device_mapping(struct amd_iommu_viommu *aviommu,
 void amd_iommu_pci_seg_trans_devid_init(struct amd_iommu_pci_seg *pci_seg);
 void amd_iommu_pci_seg_trans_devid_fini(struct amd_iommu_pci_seg *pci_seg);
 int amd_iommu_trans_devid_reserve(struct amd_iommu_pci_seg *pci_seg, u16 id);
+int amd_iommu_trans_devid_reserve_pci_aliases(struct amd_iommu *iommu,
+					      struct device *dev);
 #else
 
 /*
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 17716a506f93..65550b070a12 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2755,6 +2755,14 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
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
index e0b637138260..f51a332fbc72 100644
--- a/drivers/iommu/amd/trans_devid.c
+++ b/drivers/iommu/amd/trans_devid.c
@@ -11,6 +11,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/pci.h>
 #include <linux/xarray.h>
 
 #include "amd_iommu.h"
@@ -88,3 +89,47 @@ int amd_iommu_trans_devid_reserve(struct amd_iommu_pci_seg *pci_seg, u16 id)
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

