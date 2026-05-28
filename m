Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012046.outbound.protection.outlook.com [52.101.43.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D4531E825
	for <iommu@lists.linux.dev>; Thu, 28 May 2026 05:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779945559; cv=fail; b=ZI0nBnJl6lf6WDOyc+FRpbvHj32xLWr3PmH0ke8FF2YZjcEWjVkOUOgE25NxccOke3rCN34x21ByCemIPzGNqpiO0RKvzhYmnoduEXX6W8eQCfP5FE5TD1MfH2E6C1zZWvTqEzpsyIKFnm7m0ZCULOEjPCzwGojZNTX3UHtTObI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779945559; c=relaxed/simple;
	bh=U/VcJPvqyi2GAvL96daTF//aCtYcDfWpehfSDMbchn0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uXqd3yZEgk/VnAeBVLVAlTDwGL1Bk0CL1mqsIw+N/Or1R4swDi/sN7RReRJoVczror5+UGnCj/NZCZES19ny3+yxybcWMP4JwHcKY5YJzNARYzZ1WnzU0QbDMAj7Gy6Dyz34xdgvxBqbiZDSWGMEQuVVem7xaJSAP3O7DzOBIls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dWXMC948; arc=fail smtp.client-ip=52.101.43.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dWXMC948"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v+KwxZdQE5ja4sO1O3gptXiIuJs0R8OSPixIIqgfYYoCFM4GjTi4nGtyu56BaghKSc+ODKejNREfRebwHZ7s6+tVSb8/gvoZJGWC5545Kwo76nmMoKT2L+n3KqF8dB3kFXeSitGWDU+M1hlnkXPGopFpRnGGNLcFjqvpqdZmPFzojy2H811gO/4Xyx5FXybZ/iHYfrMMfILhP8pE8qJ7GLTHLxbysai1SsL4H9IA7rwZoQkrmJ9DkS8N+nQjvNojJU3TBM1sEV/O8MVXuZQh7i69W2Xc27BqILVjRVLlNRmq2ef1722n9QJ0/MRTS5XIhxPlFLzGtyyAKcNkNWZ6fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XOqGGBi01P+ukGhHZgDuA/KrO1d6ZT/oPMAl1f1kj74=;
 b=DKPZVMthewTtTbxgHn6Gjb1GLSYXwzqe9RO1FyfKkWv54pyqWJ1fuYYZPtMBlg2xmnnB4+iIc/tTPxQqgKz214C9w8SztbqBNxaEpcrTFe21QMeXzO4BdZHPKpn1xPEJXDw1bqGbBL7ndVfWj9wG9++AJB6anm9eFhPfqNXD0lnVez2hoAjMqA8bFkCQXJcHYwwRuqfcMOy9W4QDDYRCdRZMF2xa2UwthFfPIwnjMHse980zTmPmfjzAd80s19L84BAtulKlFlxCHqfDkxtdkulsUmUCHQzzapR9WsZ11nhTrmlunHf7sJRUfk/rygML4gAeBoPAxLsuS+q0Qy/WBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XOqGGBi01P+ukGhHZgDuA/KrO1d6ZT/oPMAl1f1kj74=;
 b=dWXMC9480QegZai+neSSgkrD6a+ZRSlAVyT45NHTA8khId+sKQYeT8a2rXL56cr8lJ2xrPF9ZO05rPMMY4vGwOEkTMdKATcUJ+Y8bYUVVno4UYj/4josOT4umSkhabjNRlz4PLmTXUNA3YaVnONzw4ajhqdYGPBJ6GCn8Cia+EM=
Received: from SN6PR05CA0026.namprd05.prod.outlook.com (2603:10b6:805:de::39)
 by SA0PR12MB4495.namprd12.prod.outlook.com (2603:10b6:806:70::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 05:19:15 +0000
Received: from SN1PEPF00036F43.namprd05.prod.outlook.com
 (2603:10b6:805:de:cafe::1d) by SN6PR05CA0026.outlook.office365.com
 (2603:10b6:805:de::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via Frontend Transport; Thu, 28
 May 2026 05:19:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F43.mail.protection.outlook.com (10.167.248.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 28 May 2026 05:19:15 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 28 May
 2026 00:19:10 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jay.chen@amd.com>, <wvw@google.com>,
	<wnliu@google.com>, <dantuluris@google.com>, <chriscli@google.com>,
	<kpsingh@google.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v2 15/26] iommu/amd: Introduce helper function for updating domain ID mapping table
Date: Thu, 28 May 2026 05:17:27 +0000
Message-ID: <20260528051738.596013-16-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F43:EE_|SA0PR12MB4495:EE_
X-MS-Office365-Filtering-Correlation-Id: c00db1b5-10de-41f6-0595-08debc78a901
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|376014|7416014|56012099006|11063799006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	NOZSBAWmGcxftYA6jy5Ne64mCuIm5wkUG1oveiZGqCtwBNAQ944NZDQlez4HJIhVjCMse6IDRxMVaPh3DZoOhK8+00fLpRkdxoNgqtyT5gUkHl9R1Rygz4T7VKhxS3fXRCZoL1pYXz16JuXzHL/VUaS6LlzHEMTg5M4gsnfkqI0Qa9SJbzD66nUoy8G0e32lAu/sLrqTvdFG+PnZ7W+PQtcxdIT8BMjJ4Z/pykEK6aeA7djLQCvNzZUdimtlIxd67PP6qnKHkDXAWmnh0QHh+ds6dR/IVAmxs4XY7IhegkgD7+d8xUwkzaaHKo2xf14ar2184/RZjLD5mOvtkWd4iXzS6tKQ5eBcnSUXKHhA35EkKvWPeKhCj2jAw1fnGKFAxgmZv/irW95gSqebqO3/zZAp0fieAQqKHk+Ou+6ewJbMgyZg0WhF9+SvbauswQGCXoGPCAHlSjed0RQmDu31h5ZTm/P21Moqq6ZPpbWQWXF1YQbSVluOoWKIx0KZ9Be05JGlTYbeP3WJPILAzxEyct7IRaiebKDA71nCqHVuSLXKGxmjUJo9y/PwaxEamxzoP7BHpF+soZPlqcIOd8T1OclpE61Tv7WvWC0K3nzBuuLF2H0Rcbc+9Lxv7vT095bJsdChcupsiaxIjuk/53H7sGbOiJgihzMKQ7Zpa6MS5FRIqwaCXw7vAbepCXB7BFLRk+EcM4z00Aam8FRkp/4ZLldarng4YXJNJax38xUc1HI=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(7416014)(56012099006)(11063799006)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	OLzw3lh834rups5fkGX7eOPkBDEWh6oydmAo/jp3vVF4DUUfC8mpEUkZvGFDSFMFbIu9lcmH33dboFaXp03QuoNPBA/Fbhf/VhjoSWwQf5ngjTJk46x3gBEThUGM+haKg/ryi9BuFjEh8/IcKiCeeE5MoEvQxzXgBty2jzO0BMGZGv/+nkB1jrbxoq5LXMtpn6bF4+g+Ir9fg/7lGuzTj0U756uxfW/5k3jdTsEp1qZdmzN4umvjbPLfmvEXu4ApJn1WhE6/IBT0gqY69MCShFsbm+RDNcixYENx6tHLFyWT58xSTj6lCskaYM+cJkLc2/RTqx2c0YTsMujOsfAXjtN3gfzayIEiO9uIrWlToZfEybAaPNNgnlLQiaH0shycUmTFhF3LeYal02EBmCFzqGZ7j1b9B9cy1cAk5jfWhQJUW+WGf1/H01+HIz7VcoHq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 05:19:15.0033
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c00db1b5-10de-41f6-0595-08debc78a901
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F43.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4495

AMD vIOMMU hardware uses the Domain ID mapping table to map Guest Domain ID
(GDomID) to Host Domain ID when it virtualises guest IOMMU commands.
It uses GID and GDomID to index into the table to look up host domain ID.

Linux IOMMU driver programs the table entry using VFCntlMMIO Guest Domain
Map Control Register.

Introduce amd_viommu_domain_id_update(), which is used to set the entry
when attaching the nested device. Clearing the entry is done during VM
destroy.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_viommu.h |  2 ++
 drivers/iommu/amd/nested.c     |  5 ++++
 drivers/iommu/amd/viommu.c     | 46 ++++++++++++++++++++++++++++++++++
 3 files changed, 53 insertions(+)

diff --git a/drivers/iommu/amd/amd_viommu.h b/drivers/iommu/amd/amd_viommu.h
index 8b57717c22a6..b6fd5ffc3b82 100644
--- a/drivers/iommu/amd/amd_viommu.h
+++ b/drivers/iommu/amd/amd_viommu.h
@@ -18,6 +18,8 @@ int amd_viommu_init_one(struct amd_iommu *iommu, struct amd_iommu_viommu *viommu
 
 void amd_viommu_uninit_one(struct amd_iommu *iommu, struct amd_iommu_viommu *viommu);
 
+int amd_viommu_domain_id_update(struct amd_iommu *iommu, u16 gid,
+				u16 hdom_id, u16 gdom_id);
 #else
 
 static inline int amd_viommu_init(struct amd_iommu *iommu)
diff --git a/drivers/iommu/amd/nested.c b/drivers/iommu/amd/nested.c
index 08f74ebb3523..ce16c8404c28 100644
--- a/drivers/iommu/amd/nested.c
+++ b/drivers/iommu/amd/nested.c
@@ -10,6 +10,7 @@
 #include <uapi/linux/iommufd.h>
 
 #include "amd_iommu.h"
+#include "amd_viommu.h"
 
 static const struct iommu_domain_ops nested_domain_ops;
 
@@ -245,6 +246,7 @@ static int nested_attach_device(struct iommu_domain *dom, struct device *dev,
 				struct iommu_domain *old)
 {
 	struct dev_table_entry new = {0};
+	struct nested_domain *ndom = to_ndomain(dom);
 	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
 	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
 	int ret = 0;
@@ -262,6 +264,9 @@ static int nested_attach_device(struct iommu_domain *dom, struct device *dev,
 
 	amd_iommu_update_dte(iommu, dev_data, &new);
 
+	ret = amd_viommu_domain_id_update(iommu, dev_data->gid,
+					  ndom->gdom_info->hdom_id, ndom->gdom_id);
+
 	mutex_unlock(&dev_data->mutex);
 
 	return ret;
diff --git a/drivers/iommu/amd/viommu.c b/drivers/iommu/amd/viommu.c
index 3636093732ce..3f7c17d400d0 100644
--- a/drivers/iommu/amd/viommu.c
+++ b/drivers/iommu/amd/viommu.c
@@ -40,6 +40,8 @@
 #define VIOMMU_DOMID_MAPPING_BASE	0x2000000000ULL
 #define VIOMMU_DOMID_MAPPING_ENTRY_SIZE	(1 << 19)
 
+#define VIOMMU_VFCTRL_GUEST_DID_MAP_CONTROL1_OFFSET	0x08
+
 LIST_HEAD(viommu_devid_map);
 
 static int viommu_init_pci_vsc(struct amd_iommu *iommu)
@@ -367,6 +369,22 @@ static void __maybe_unused free_private_vm_region(struct amd_iommu *iommu, u64 *
 	*entry = NULL;
 }
 
+static void viommu_clear_mapping(struct amd_iommu *iommu,
+				 struct amd_iommu_viommu *aviommu)
+{
+	int i;
+	u16 gid = aviommu->gid;
+
+	/*
+	 * IOMMU hardware uses the domain ID mapping table to map gdom ID to hdom ID.
+	 * If the mapping does not exist, the hardware would generate error in the event log.
+	 * Therefore, initialize all gdom ID entries to map to parent domain ID to prevent
+	 * unknown mapping scenario.
+	 */
+	for (i = 0; i <= VIOMMU_MAX_GDOMID; i++)
+		amd_viommu_domain_id_update(iommu, gid, aviommu->parent->id, i);
+}
+
 void amd_viommu_uninit_one(struct amd_iommu *iommu, struct amd_iommu_viommu *aviommu)
 {
 	pr_debug("%s: gid=%u\n", __func__, aviommu->gid);
@@ -379,6 +397,7 @@ void amd_viommu_uninit_one(struct amd_iommu *iommu, struct amd_iommu_viommu *avi
 			       VIOMMU_DOMID_MAPPING_BASE,
 			       VIOMMU_DOMID_MAPPING_ENTRY_SIZE,
 			       aviommu->gid);
+	viommu_clear_mapping(iommu, aviommu);
 }
 
 int amd_viommu_init_one(struct amd_iommu *iommu, struct amd_iommu_viommu *viommu)
@@ -399,8 +418,35 @@ int amd_viommu_init_one(struct amd_iommu *iommu, struct amd_iommu_viommu *viommu
 	if (ret)
 		goto err_out;
 
+	viommu_clear_mapping(iommu, viommu);
+
 	return 0;
 err_out:
 	amd_viommu_uninit_one(iommu, viommu);
 	return -ENOMEM;
 }
+
+/*
+ * Program the DomID via VFCTRL registers
+ * This function will be called during VM init via VFIO.
+ */
+
+ #define DOMID_ENTRY_GDOMID_MASK	GENMASK_ULL(61, 46)
+ #define DOMID_ENTRY_HDOMID_MASK	GENMASK_ULL(29, 14)
+ #define DOMID_ENTRY_VALID		BIT_ULL(0)
+ #define DOMID_ENTRY_WRITE		BIT_ULL(63)
+
+int amd_viommu_domain_id_update(struct amd_iommu *iommu, u16 gid,
+				u16 hdom_id, u16 gdom_id)
+{
+	u64 val;
+	u8 __iomem *vfctrl = VIOMMU_VFCTRL_MMIO_BASE(iommu, gid);
+
+	val = FIELD_PREP(DOMID_ENTRY_GDOMID_MASK, gdom_id) |
+	      FIELD_PREP(DOMID_ENTRY_HDOMID_MASK, hdom_id) |
+	      DOMID_ENTRY_WRITE | DOMID_ENTRY_VALID;
+
+	writeq(val, vfctrl + VIOMMU_VFCTRL_GUEST_DID_MAP_CONTROL1_OFFSET);
+	return 0;
+}
+EXPORT_SYMBOL(amd_viommu_domain_id_update);
-- 
2.34.1

