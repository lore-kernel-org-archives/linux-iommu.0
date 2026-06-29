Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012024.outbound.protection.outlook.com [52.101.43.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E55941930C
	for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 15:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782747708; cv=fail; b=jWwWlbIbqTiE/cUDGT7kkGbwvnXtMYR+iP71GEHOBICimD/rRwp8wyueimRM5X4vnVL9PoAMXt4AHkGe4n+oIdZH3DsZfZnWwHoty1NhCazZFzV6vxh44+96+7cWpm2zrodfo9n/Pt3wh812dcypw6dM6vKTYaOaqkBCLzo+a+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782747708; c=relaxed/simple;
	bh=7ZvJpVnpGOnxBJOy3G12QgN+w1FTbs+loLfLchIPrfg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oho15dl0Srm/1BSfrAOu+6u7UX08I8C44kON04eu9SR87Z+JmYPvP2jMSZygGa0WwHGul0CcJ5a6GScK8OBjTItnRxQhAoyG9LwQOzKS3BnR4Ei0pfBfIdPwdhLB11ciPoRi7Ctj7uYWzWiE3/zYfN+34Mvz0zXDEzpVMQhfXp0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YH0MLSLz; arc=fail smtp.client-ip=52.101.43.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YH0MLSLz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fffqQ3DimtBgUXT9K8bCDQT4985bQ++V7vQq5Mr3UtDcARr1THrKGr5bug7NDAAbeWp2t+2ctO8CpLt32gc3ZQ+51SHvMxKb4DKijy403QyojoYkQW8w2Uvuc8yD4DrStPiwRjDbQfa/2F3EbJU+NkcRgt8Alf03kfsW7HHmNYz+HsTzMQxZnX2YEhqTxMSbcsr6/1vNLLwTEGTK7CXCkNeqxV8JyAgAJILIUuS1weKw5uNdgYDhWIiz2F2VFyyGQz7g2P0PMzUXOP6eAWPJ1igwDLJ1JFflYE/PSLIOeqY6kBGwFyq3OsYW7pm/5pVl9ktjVZ6Ae21bQ1hZLiD+NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BD0MVFkxtwaot/q9Am8NjtefdQQTTtjcfGaOhYrR3c8=;
 b=T50w5/l8+qKbEDHmOOFg/V5OoIT0uC01q6RUomQfj5kGsM0e3KTTYHyfXNFp/t0a9vcfLwC0yy1PpnN93a4DlaY+5mFpHCzw3dnoUe2hFza79yyT4sauFgyywGQcZ8wLfrXxcJJO5DtEJ5yqpXg2ftBW3tj1WA1yaDGZ2g55rcBzj6yA3JrS76bCMQ8KG5kcgJ2pnVu31v326ZTUUAtd8d6HoC/OY6i2/mN8/BTXQO4hyjCsa3o+m9sfT4z2eDwifhVgwMnEWsruq12pBQoTC2Gux7fsPOv/jBGgteacfJ7RA2BvGuZHyzEySTQJrbMMo2HPLbPoe5T742Ky9ANqIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BD0MVFkxtwaot/q9Am8NjtefdQQTTtjcfGaOhYrR3c8=;
 b=YH0MLSLzE7aIwpeBJ86OHKf033WOWBaqi7vm9KCvOlEivWSlf6eU4ylQY7OVwmC+0BTO4KlNNbLvXMUqlh5pRGtkYNdRs9VXCpGS2OHtusBBTrbRf/7I8jlVXlJlaAmRWCJ+cMBajwsiZeq7fz37xF2/uDjToIlJ+pF7LaukRnU=
Received: from BN9PR03CA0320.namprd03.prod.outlook.com (2603:10b6:408:112::25)
 by CY5PR12MB6573.namprd12.prod.outlook.com (2603:10b6:930:43::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Mon, 29 Jun
 2026 15:41:38 +0000
Received: from BN2PEPF000055DD.namprd21.prod.outlook.com
 (2603:10b6:408:112:cafe::34) by BN9PR03CA0320.outlook.office365.com
 (2603:10b6:408:112::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Mon,
 29 Jun 2026 15:41:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000055DD.mail.protection.outlook.com (10.167.245.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.202.0 via Frontend Transport; Mon, 29 Jun 2026 15:41:38 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 10:41:33 -0500
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 08:36:16 -0700
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jay.chen@amd.com>, <wvw@google.com>,
	<wnliu@google.com>, <dantuluris@google.com>, <chriscli@google.com>,
	<kpsingh@google.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v3 05/22] iommu/amd: Allocate Guest IDs for IOMMUFD vIOMMU instances
Date: Mon, 29 Jun 2026 15:35:18 +0000
Message-ID: <20260629153535.15775-6-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DD:EE_|CY5PR12MB6573:EE_
X-MS-Office365-Filtering-Correlation-Id: f0ef7901-1300-4ed6-2a67-08ded5f4e866
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|7416014|376014|23010399003|22082099003|18002099003|5023799004|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	nonIuH4wC6SDepxwsCoxbskzDh7li9LMmEZjdRWOHwRSCiKfXGR/jKx6H41HU70Bnqqayw6rvXT3NKw1GKZTtDyuAyBoasY0wRSZSXcO1A7uoQ5Qzbz+pLQXHGGkx2gaq2DspecMKX5NB4X0WeL3n09ZjX4Q6kisLwLQI/4bwFV80g5Mt0QO1n/Nkps3DumjSI5irvRql/EOh0lZIJjd0vc5NVz+77egK9LM6OZA4plW6UQKMTu6pdB1uCQ7VNhbEdQLd5tr7Y5K5Ctkj966UDBpIGzl04Y1MaDBTl/rj1P9vvoumhlRLGgx3Xaqy09QlSrlj+8ZZWJ2+ak8bIIJf1Llz+/U504jduq3fCBQErA3oZX8K4aziRAPW1KSO9mbO9Cruc7UbDwJ+r3tcNWv/zYx8WIZITtLIWGR+ZWCtXkF/UqkdlMqlwt9Yd8T7oQ8dltO1cYpdHoDAHkC8gUBnXy93tttkG32FJb5oGuA3jxfsPKQ1/xyhf3I3Qk/o5uQE8AhtAxMMvvBcchtWnXfYWeEurc1ZqMYieVAX/Usxfg9cZhJ2LWaC1FLtChqqB9Dp1SW9cTOJ2ZBLztn+3xwGUpjV2kW90Nt+wKlSVLaeHzeN842/bFIsljBUc1xcAAGN4hzggK/ExzBZA0kYvIMb6yo18nPCtyTfuAPavOrGboQ30XVHCi+SnP6H/JSv2mmaMnfSV3+U18e2DDPZPVwuA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(7416014)(376014)(23010399003)(22082099003)(18002099003)(5023799004)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	m8l/goeHeLe4B2E2FiCfDGQRZMDDvTLGGBqE0lRRJHpVKQdVDDS9WH8RXYr8CRfqkNgL1lEPdzo2fvM9h04tn2jIAQuuum77+FicBXJpKi3ur3yHPQqrz6a/U/A/k49H5BwN0VOkYU0CDQRG4KDhp/ddXTMtDrHmKdKglx4jIAJqraA/AIunp+WO9SRQSZiR+J6dxqBG8UI3nEhLU1nKmP8ZrGof7hj1W2OrMZw2b0hUPdoRl7WhV/RhnNoD0gmIvrshEHycsRnaaqk8X5zBcaG+/+ne106lA9eZLSLJO0/+y8S6CL/cy3XJo4M8h/CaWKin6FAZbi5krVgD1PRlNzldeXWbHRwZx1EALpY9d88As5FOFjfWVpPqDzIii+aFc7bGLPZp8g1AWQaeOEa2u4WOdaCGpg4WJ8rzZKE5XtoyzmqLG/Udq40LwOPSmDM4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 15:41:38.0520
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0ef7901-1300-4ed6-2a67-08ded5f4e866
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6573

Hardware vIOMMU uses a 16-bit Guest ID (GID) per guest IOMMU to
index driver and hardware state. Allocate one GID per IOMMUFD vIOMMU
from a per-amd_iommu IDA (unique within that IOMMU; a VM behind
multiple IOMMUs may hold more than one GID).

Add amd_iommu_gid_alloc() and amd_iommu_gid_free(), store the ID in
amd_iommu_viommu::gid, and call them from amd_iommufd_viommu_init() and
destroy after copying struct iommu_viommu_amd to userspace.

ida_init() for gid_ida is done when vIOMMU MMIO is mapped (next patch).

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h       |  4 ++++
 drivers/iommu/amd/amd_iommu_types.h |  8 ++++++++
 drivers/iommu/amd/iommu.c           | 19 +++++++++++++++++
 drivers/iommu/amd/iommufd.c         | 32 +++++++++++++++++++++++++++++
 4 files changed, 63 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 17fc0b5b3fa8..9f2a1a8a6d3c 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -228,4 +228,8 @@ amd_iommu_make_clear_dte(struct iommu_dev_data *dev_data, struct dev_table_entry
 struct iommu_domain *
 amd_iommu_alloc_domain_nested(struct iommufd_viommu *viommu, u32 flags,
 			      const struct iommu_user_data *user_data);
+
+/* Guest ID for vIOMMU */
+int amd_iommu_gid_alloc(struct amd_iommu *iommu);
+void amd_iommu_gid_free(struct amd_iommu *iommu, int gid);
 #endif /* AMD_IOMMU_H */
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index b5327bf6814b..00f964d5b149 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -21,6 +21,7 @@
 #include <linux/iommufd.h>
 #include <linux/irqreturn.h>
 #include <linux/generic_pt/iommu.h>
+#include <linux/idr.h>
 
 #include <uapi/linux/iommufd.h>
 
@@ -413,6 +414,9 @@
 
 #define MAX_DOMAIN_ID 65536
 
+/* For vIOMMU, the GID is 16-bit. */
+#define VIOMMU_MAX_GID		0xFFFF
+
 /* Timeout stuff */
 #define LOOP_TIMEOUT		100000
 #define MMIO_STATUS_TIMEOUT	2000000
@@ -509,6 +513,7 @@ struct amd_iommu_viommu {
 	struct iommufd_viommu core;
 	struct protection_domain *parent; /* nest parent domain for this viommu */
 	struct list_head pdom_list;	  /* For protection_domain->viommu_list */
+	u16 gid;			  /* Guest ID for the vIOMMU */
 
 	/*
 	 * Per-vIOMMU guest domain ID to host domain ID mapping.
@@ -768,6 +773,9 @@ struct amd_iommu {
 	/* IOPF support */
 	struct iopf_queue *iopf_queue;
 	unsigned char iopfq_name[32];
+
+	struct ida gid_ida;		 /* guest IDs for this IOMMU */
+	bool gid_ida_inited;
 };
 
 static inline struct amd_iommu *dev_to_amd_iommu(struct device *dev)
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 50f26c8123f3..73fba8be40d1 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -252,6 +252,25 @@ static inline bool pdom_is_sva_capable(struct protection_domain *pdom)
 	return pdom_is_v2_pgtbl_mode(pdom) || pdom_is_in_pt_mode(pdom);
 }
 
+int amd_iommu_gid_alloc(struct amd_iommu *iommu)
+{
+	int ret = ida_alloc_range(&iommu->gid_ida, 1, VIOMMU_MAX_GID, GFP_KERNEL);
+
+	if (ret < 0)
+		pr_err("%s: Failed to allocate guest ID (devid=%#x)\n",
+		       __func__, iommu->devid);
+	else
+		pr_debug("%s: iommu devid=%#x, gid=%u\n", __func__, iommu->devid, ret);
+
+	return ret;
+}
+
+void amd_iommu_gid_free(struct amd_iommu *iommu, int gid)
+{
+	pr_debug("%s: iommu devid=%#x, gid=%u\n", __func__, iommu->devid, gid);
+	ida_free(&iommu->gid_ida, gid);
+}
+
 static inline int get_acpihid_device_id(struct device *dev,
 					struct acpihid_map_entry **entry)
 {
diff --git a/drivers/iommu/amd/iommufd.c b/drivers/iommu/amd/iommufd.c
index eee29c26169a..ec3c14e18c7b 100644
--- a/drivers/iommu/amd/iommufd.c
+++ b/drivers/iommu/amd/iommufd.c
@@ -43,13 +43,37 @@ size_t amd_iommufd_get_viommu_size(struct device *dev, enum iommu_viommu_type vi
 int amd_iommufd_viommu_init(struct iommufd_viommu *viommu, struct iommu_domain *parent,
 			    const struct iommu_user_data *user_data)
 {
+	int ret;
 	unsigned long flags;
+	struct iommu_viommu_amd data = {};
 	struct protection_domain *pdom = to_pdomain(parent);
 	struct amd_iommu_viommu *aviommu = container_of(viommu, struct amd_iommu_viommu, core);
+	struct amd_iommu *iommu = container_of(viommu->iommu_dev, struct amd_iommu, iommu);
 
 	xa_init_flags(&aviommu->gdomid_array, XA_FLAGS_ALLOC1);
 	aviommu->parent = pdom;
 
+	if (!user_data)
+		return -EINVAL;
+
+	ret = iommu_copy_struct_from_user(&data, user_data,
+					  IOMMU_VIOMMU_TYPE_AMD,
+					  out_vfmmio_mmap_offset);
+	if (ret)
+		return ret;
+
+	ret = amd_iommu_gid_alloc(iommu);
+	if (ret < 0)
+		goto err_gid;
+	aviommu->gid = ret;
+	pr_debug("%s: gid=%#x", __func__, aviommu->gid);
+
+	ret = iommu_copy_struct_to_user(user_data, &data,
+					IOMMU_VIOMMU_TYPE_AMD,
+					out_vfmmio_mmap_offset);
+	if (ret)
+		goto err_init;
+
 	viommu->ops = &amd_viommu_ops;
 
 	spin_lock_irqsave(&pdom->lock, flags);
@@ -57,6 +81,10 @@ int amd_iommufd_viommu_init(struct iommufd_viommu *viommu, struct iommu_domain *
 	spin_unlock_irqrestore(&pdom->lock, flags);
 
 	return 0;
+err_init:
+	amd_iommu_gid_free(iommu, aviommu->gid);
+err_gid:
+	return ret;
 }
 
 static void amd_iommufd_viommu_destroy(struct iommufd_viommu *viommu)
@@ -64,11 +92,15 @@ static void amd_iommufd_viommu_destroy(struct iommufd_viommu *viommu)
 	unsigned long flags;
 	struct amd_iommu_viommu *aviommu = container_of(viommu, struct amd_iommu_viommu, core);
 	struct protection_domain *pdom = aviommu->parent;
+	struct amd_iommu *iommu = container_of(viommu->iommu_dev, struct amd_iommu, iommu);
+
+	pr_debug("%s: gid=%#x, iommu devid=%#x\n", __func__, aviommu->gid, iommu->devid);
 
 	spin_lock_irqsave(&pdom->lock, flags);
 	list_del(&aviommu->pdom_list);
 	spin_unlock_irqrestore(&pdom->lock, flags);
 	xa_destroy(&aviommu->gdomid_array);
+	amd_iommu_gid_free(iommu, aviommu->gid);
 }
 
 /*
-- 
2.34.1

