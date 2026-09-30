Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013032.outbound.protection.outlook.com [40.93.196.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A98479884
	for <iommu@lists.linux.dev>; Wed, 30 Sep 2026 09:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790760282; cv=fail; b=ZDF1Dq4e3ZKK84QweFwNFiXopnZy1IlrmFNQ71koGTezf9LuJOa2yqQUyxgg0PhTm356S9YVvtc9cWzN/A6d2VhvRkWfBwjNGxsKvgT78xIZivOE1mgTu3Z5rnPvZfpS6179aX10fWZaIs7PxlFlBIRPUN5V+1Qd3usNUBiFPyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790760282; c=relaxed/simple;
	bh=3ZIzenLH7SCCBS2QKb5qCTeGDSN6emZ5k8mqLHBnh8g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NoTM/ZC4d8wI4UaLiMhukw7RN6NpmEGq3HpEvzL2UtwqlvyQt2K9hGSYXIJa/5ATFI7/ytWJOtz74FMopMEVhYm5r4Uw6xxQsPHc+bWR+0ghw1CeKpFPvF0jyGWtFSu7wZDgbfPXD5d3VbfRKbFwgE6GEVKowRfXvGIXeCikK7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qqN4tHD6; arc=fail smtp.client-ip=40.93.196.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qqN4tHD6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=knuGls1wOU/z6WMHN40+SblzcS4Uqq2iv3dgkBHinV8SDvjhsLlyUI8SlnvKcd+gzYjdJQB/puREFrTkGfpwboD02BbXPyd44zfmvLhWnkoaWKujo+3VMzuWTQYwlRpS6+4uYdZNcTF65y/AtJKBzJ/03VQVpqHg4mdj43cbn5m9fe+b7Fk7WyMvWra2mDJtt1nGHJqxWDe48f8L6iesfReU+eDJQv0R0UkGlyNPauOPfa70iCi21jH9olYlnOtvq4DjOI/2qXdzdoXOOEPy7elu5TvWQA5R37pCJ2Hrw9f2o8xP3BAJyzeXMSSLCxOrpimGcxiaZjBYLUYMhPDckA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nGmzWuU/35wUPVegAcZq1Hk6MG6EKKYGAL4lNM16bnY=;
 b=a/jq65pOohOR55rRi5oO+eqCAvKWVnZrRPg/wkgcSgMaYII/8MJpT9GLAdXq9o6SF4YqBjtrQsiIBPTHezk/fSIixXvw0yeIcNTWyhzIymV6dxPhzxYOqoQcdJmw6+DfrlGWDBC2Ia+2NdqjeR5ow5y8+A8AfDuR6qoKAGOSYA3E4AbBy5ACpW7JWJVjNY7cBnun3aqTrZtA19Va2MvoJkmBczn+2KltnwbZNm1M7YwACo5wSlBrLgqwWosQVPgFmC9ZZqSfwdl9j0WnioVDrQ7G7/gEYyNFNFlVHulbXvzQHWmp73KVdOk44nzg6Nu4U6atMkGgFlrXU0K4P3cLWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nGmzWuU/35wUPVegAcZq1Hk6MG6EKKYGAL4lNM16bnY=;
 b=qqN4tHD6CM0gAdyPeyQJAXrPz7P5LZT9HKOG262ZwpfapB+uJVccD39i9U2XMwtjFxuWICU4Xp0aH1ToK1UFhXUdVmL7OEa9X7/SVPeUN8kL9P4fT/AuCLOGlMFgaw9lg7GK8kbodVD1eVr83hoMuhk3kx6fliM0F3E5KZk5er4=
Received: from CY8PR10CA0006.namprd10.prod.outlook.com (2603:10b6:930:4f::29)
 by LVUPR12MB999183.namprd12.prod.outlook.com (2603:10b6:408:3a3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 09:24:36 +0000
Received: from SN1PEPF000397AE.namprd05.prod.outlook.com
 (2603:10b6:930:4f:cafe::ac) by CY8PR10CA0006.outlook.office365.com
 (2603:10b6:930:4f::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.16 via Frontend Transport; Wed,
 30 Sep 2026 09:24:35 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397AE.mail.protection.outlook.com (10.167.248.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 09:24:35 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 04:24:29 -0500
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
Subject: [PATCH v6 05/24] iommu/amd: Allocate Guest IDs for IOMMUFD vIOMMU instances
Date: Wed, 30 Sep 2026 09:23:25 +0000
Message-ID: <20260930092344.5616-6-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AE:EE_|LVUPR12MB999183:EE_
X-MS-Office365-Filtering-Correlation-Id: 4021ab6b-612b-4516-a7cd-08df1ed4a4cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700016|23010399003|82310400026|11063799006|10067099003|5023799004|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	8u682P0ltIDl1VPMz+hsuOhoYnoSR75sIboXv9qXJhMkyYtDG7G2icIG3YYfCNUOyFZcYCQCFRijdkg7pTphTB2bq0VUXXjW8CNQHgcmxfHWsV5Ngr6dcvP0SyiAmeMLf7uCKNhzwm7TUiMgsWbpjNaryQb6zArBYeyFN4ehlM+taP/II/NZ8WnbTcEyFSt8UgTqm9AZFEXMNO8IOHeB0BeUZrWW8oU6bZ2Wn0l3inUNs+eBQCgZHU/24iEvgOkiXttSr7U8OPKKYpYuIdEV6Rc210b/riRYWvCrT773PhedPIQwUQjVenQiNpRtIghYLw2nB862pPR5IR8+Yvshwnzr28M7suF8ViAWgK3ShTMjlCVZAZUMk7V4sIzU1/GYbZVETQmsHpkRU/uKSd9Jem/YPFNKTQZ46DI0P84LvaWHHcCoV1kzgUtCTgvVLgYwc1TkSUQtIM8Luzj5pRWAI89fgpJBd6Wh9jMZyzc3Fi6WIaMqyPOJtCEcme+TTsHxGrxscjXOtrjRTPjDMX+BHJGDkNodQDYOBNq74/HyNnmObYLfLmehFpfl9FcqnWtK7gSN8b6tx3xGKo14iquyLfiX46Zh2Mwe8Is6/Wo4eJI3zrBP+w0/Y6umadabV7yJjS8HrShGL0OBlDXsvQXc+9K80iGpDxDOlUEwnVdP/13cU3RP4dy9TFkZ4jj/Umz84a+pbsmyq9mHD0f3fsotDw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700016)(23010399003)(82310400026)(11063799006)(10067099003)(5023799004)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	dFAL+eCU5oBWk7pztZKX2dphKvtXIGC7J2CdKjOmHCE7XnEB5F/0fkKmW4KUPrgf5FxCzCoDZ8+8aaV0fghCOezeh51LxGfyWZR1lm4tQJHf/Mcf1kOk1yibDoKPzWHLX9i2+JmDdXbWUPZQQAlnGB3ZcLYYvo37xahkU0LmRMQVNhB2nm9pdPh40zc83+1/Sv9I+a1nV9PJTM8WQ12dUghHSudIm8XaMdqy07QI0oQOSETew261Mxeia3DoNS10fae8XI2CQ59oQeoboMuTIREYDY0dB4ZA2SGmFFXKezGHAG+7imwFcbaZxFHPgROdu3haaKtg2hSmq2V3PzNPgADznqMjWMAKdxUNw/GRbWsKi7RnyU/dSzQHzLsOp8mHv2+1yVx+LXdZY2jTV7PF76m269npIpFjFNipPPgbPyYmbk5hbc3CPzYAqJj576uZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 09:24:35.6132
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4021ab6b-612b-4516-a7cd-08df1ed4a4cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397AE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR12MB999183

Hardware vIOMMU uses a 16-bit Guest ID (GID) per guest IOMMU to
index driver and hardware state. Allocate one GID per IOMMUFD vIOMMU
from a per-amd_iommu IDA (unique within that IOMMU; a VM behind
multiple IOMMUs may hold more than one GID).

Add amd_iommu_gid_alloc() and amd_iommu_gid_free(), store the ID in
amd_iommu_viommu::gid, and call them from amd_iommufd_viommu_init()
and destroy. Initialize gid_ida in init_iommu_one() and destroy it
in free_iommu_one() with the IOMMU object.

Reject amd_iommufd_viommu_init() with -EOPNOTSUPP when the IOMMU
does not have AMD_IOMMU_FLAG_VIOMMU_EN.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h       |  4 ++++
 drivers/iommu/amd/amd_iommu_types.h |  7 +++++++
 drivers/iommu/amd/init.c            |  2 ++
 drivers/iommu/amd/iommu.c           | 16 ++++++++++++++++
 drivers/iommu/amd/iommufd.c         | 14 ++++++++++++++
 5 files changed, 43 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index b2ae17e3df34..f6cf412a9820 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -227,4 +227,8 @@ amd_iommu_make_clear_dte(struct iommu_dev_data *dev_data, struct dev_table_entry
 struct iommu_domain *
 amd_iommu_alloc_domain_nested(struct iommufd_viommu *viommu, u32 flags,
 			      const struct iommu_user_data *user_data);
+
+/* Guest ID for vIOMMU */
+int amd_iommu_gid_alloc(struct amd_iommu *iommu);
+void amd_iommu_gid_free(struct amd_iommu *iommu, int gid);
 #endif /* AMD_IOMMU_H */
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 688cd9240790..8c38775ff5c1 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -21,6 +21,7 @@
 #include <linux/iommufd.h>
 #include <linux/irqreturn.h>
 #include <linux/generic_pt/iommu.h>
+#include <linux/idr.h>
 
 #include <uapi/linux/iommufd.h>
 
@@ -404,6 +405,9 @@
 
 #define MAX_DOMAIN_ID 65536
 
+/* Guest ID bits 0-14; bit 15 is reserved for secure vIOMMU. */
+#define VIOMMU_MAX_GID		0x7FFF
+
 /* Timeout stuff */
 #define LOOP_TIMEOUT		100000
 #define MMIO_STATUS_TIMEOUT	2000000
@@ -501,6 +505,7 @@ struct amd_iommu_viommu {
 	struct iommufd_viommu core;
 	struct protection_domain *parent; /* nest parent domain for this viommu */
 	struct list_head pdom_list;	  /* For protection_domain->viommu_list */
+	u16 gid;			  /* Guest ID for the vIOMMU */
 
 	/*
 	 * Per-vIOMMU guest domain ID to host domain ID mapping.
@@ -760,6 +765,8 @@ struct amd_iommu {
 	/* IOPF support */
 	struct iopf_queue *iopf_queue;
 	unsigned char iopfq_name[32];
+
+	struct ida gid_ida;		 /* guest IDs for this IOMMU */
 };
 
 static inline struct amd_iommu *dev_to_amd_iommu(struct device *dev)
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index c80872ce0b60..7b4cb473019d 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1797,6 +1797,7 @@ static void __init free_iommu_one(struct amd_iommu *iommu)
 	free_ga_log(iommu);
 	iommu_unmap_mmio_space(iommu);
 	amd_iommu_iopf_uninit(iommu);
+	ida_destroy(&iommu->gid_ida);
 }
 
 static void __init free_iommu_all(void)
@@ -1885,6 +1886,7 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h,
 
 	raw_spin_lock_init(&iommu->lock);
 	iommu->cmd_sem_val = 0;
+	ida_init(&iommu->gid_ida);
 
 	/* Add IOMMU to internal data structures */
 	list_add_tail(&iommu->list, &amd_iommu_list);
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 2df81e29519e..d3378754cf87 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -257,6 +257,22 @@ static inline bool pdom_is_sva_capable(struct protection_domain *pdom)
 	return pdom_is_v2_pgtbl_mode(pdom) || pdom_is_in_pt_mode(pdom);
 }
 
+int amd_iommu_gid_alloc(struct amd_iommu *iommu)
+{
+	int ret = ida_alloc_range(&iommu->gid_ida, 1, VIOMMU_MAX_GID, GFP_KERNEL);
+
+	if (ret >= 0)
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
index e8e7807f2a33..69a0e61bf83d 100644
--- a/drivers/iommu/amd/iommufd.c
+++ b/drivers/iommu/amd/iommufd.c
@@ -49,13 +49,23 @@ size_t amd_iommufd_get_viommu_size(struct device *dev, enum iommu_viommu_type vi
 int amd_iommufd_viommu_init(struct iommufd_viommu *viommu, struct iommu_domain *parent,
 			    const struct iommu_user_data *user_data)
 {
+	int ret;
 	unsigned long flags;
 	struct protection_domain *pdom = to_pdomain(parent);
 	struct amd_iommu_viommu *aviommu = container_of(viommu, struct amd_iommu_viommu, core);
+	struct amd_iommu *iommu = container_of(viommu->iommu_dev, struct amd_iommu, iommu);
+
+	if (!amd_iommu_viommu_enabled(iommu))
+		return -EOPNOTSUPP;
 
 	xa_init_flags(&aviommu->gdomid_array, XA_FLAGS_ALLOC1);
 	aviommu->parent = pdom;
 
+	ret = amd_iommu_gid_alloc(iommu);
+	if (ret < 0)
+		return ret;
+	aviommu->gid = ret;
+
 	viommu->ops = &amd_viommu_ops;
 
 	spin_lock_irqsave(&pdom->lock, flags);
@@ -70,11 +80,15 @@ static void amd_iommufd_viommu_destroy(struct iommufd_viommu *viommu)
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

