Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010055.outbound.protection.outlook.com [52.101.201.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4902C285CBC
	for <iommu@lists.linux.dev>; Thu, 28 May 2026 05:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779945514; cv=fail; b=e8pwUIHeAch5x3pZ6FnsPX3HIJuHWYymwzWKATnm3Fk8nFRHo4WmxnIF7PpF9+d1fr04dBsp4KcUAXvHZeV5nJYrDOfhq+SLqahkT0DciL02VM3cLgt+zpFZh+0Wd5L52nQeRNnz5d0tGNcCQ2wb2erBDrwhs0B5hHZ2Nu6WTHw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779945514; c=relaxed/simple;
	bh=G/i0zP+IutlgiRfeyMRDGrforDMb0KSwPv3D0llF5Bg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YywQjX/9E6n0K4i62XqpqI7JW/iiGb7y1fz4XjtL+mfkTw6qBvi6b6ybgGxeCv4EQDwdZ7Hjv/kja3SxT0q9jPhxqfv8ro9eg0roTPCTRs198cEAwYNrYng1Yvl1oyKcxTS9OaWOQptgNXtxRxFwGuuTa88eB1BWVuINxOiEP50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vziDhgFI; arc=fail smtp.client-ip=52.101.201.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vziDhgFI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n/Lzz+F7BxYkrSxdCnKQCG28G2QMpWePoKHOCMaq55jQyVmDQm2/sB6DFNKqMlgbVo5sr+sQ2gwbMr691I2FTIrFkQ/emEisa3JaCcQlvUOZznpyVxBRmebUtH+DVDkkAA6r62UcJ9AsO/PIa2gZ1PVcogdy+z5wRr8aaT6fBpFdcHqEick+f7sKzgscF/C1Ujc4ktD489qe+ZXhgzzFdrM4wUdHaFpDOO0WEbXVsTUGVFN2rZp9gaGW8PokmT6ZElqRz/vazbD/8rib9giQbXwKGdTzsnhufekvQbre+2Qe/M+YkcJ4yb3f0WQTT47WvUtlE0XrumRvhKqmWt/MpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZDtwgOA4UxIGBZsB0c9/EIOs3IcmIToykEuOOG/PjP0=;
 b=WJDYlQQ5W5xA0BUVOex+dF8l8zFoR7IebGcERinbVJSIf4BjCu7B3ZQi+v9V7o0MzMfgbxooBWJ9QWej6SWcbtmYrr2jBNdkr63g8ngbYJuDg5zX4ChuJZcs9hiLA24P1bEynRX0a8UUirQieRhprzBGh/KtCfJ5P6ZSa8kXqpkxJt5GrXlcVaypijLLmPJgMrnKWNMZW4jF/3LZ6zqxp5B7SXwkT+A45ut6i+s8OvIUA8KOq8n9BaZpy3H6Xm6dKY6BnzZUnK1enJTIqNpuKwA29VWyeH/I8EZnJARl/Rg5SS5CWLuI+212xFozxg3uWPdMDUiZUJ6aJ1yoRZ50Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZDtwgOA4UxIGBZsB0c9/EIOs3IcmIToykEuOOG/PjP0=;
 b=vziDhgFI9YeIQa9g7UaTtt4sBCZePe4QQ9E4hOJ3oKYlnRin1iVrz6YcXqtRIW77dtZZJxfD4U+9HzvIvfZXv/8Hs8nRsYtZmU7NmodXmNp8KAidxZAQmiKPYEssp2+L7x2DzoGo7aDBLxRhYg2VHN7AlhjiBLl2HRiNbfaKGDw=
Received: from PH7PR02CA0003.namprd02.prod.outlook.com (2603:10b6:510:33d::31)
 by SA1PR12MB999251.namprd12.prod.outlook.com (2603:10b6:806:4dd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 05:18:27 +0000
Received: from SN1PEPF00036F40.namprd05.prod.outlook.com
 (2603:10b6:510:33d:cafe::45) by PH7PR02CA0003.outlook.office365.com
 (2603:10b6:510:33d::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Thu, 28
 May 2026 05:18:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F40.mail.protection.outlook.com (10.167.248.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 28 May 2026 05:18:26 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 28 May
 2026 00:18:21 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jay.chen@amd.com>, <wvw@google.com>,
	<wnliu@google.com>, <dantuluris@google.com>, <chriscli@google.com>,
	<kpsingh@google.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v2 05/26] iommu/amd: Allocate Guest IDs for IOMMUFD vIOMMU instances
Date: Thu, 28 May 2026 05:17:17 +0000
Message-ID: <20260528051738.596013-6-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F40:EE_|SA1PR12MB999251:EE_
X-MS-Office365-Filtering-Correlation-Id: 928831fe-0fe9-4ce9-265c-08debc788c44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|7416014|376014|1800799024|22082099003|18002099003|56012099006|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info:
	L+dChwTJi02Cl5ou0pA9e08tNj0LibxvtoCGKNeCAoUB2txGr/lilema0dUnYS4WeWqlbsLT1EiKlWn5TrePLuulPYC79zrqOrGHOf8ytw8a3x2Inz3GIUuEmWmTRqo4g3v72d6d6GtAfb3dIeRmfPPda3QyvhBtQBDilBNc9JLoDboKN9/8X3jZwuEl0d7iGgU1RXJ675dmRLnnse9nIpvrrb5+fhOABEDTVS9Sy0+qrP0OIKIIhks0lARLmRxD4vjwC3q3kCrb572MFCHkG1wrI3eLSB1k1XUcn+djwhtKWF853rd4Da7849jSu+OWiDtIXUF2QEglJGqFCZhYQwY4Ltz0w796v7pHnnTsdeSX60K62eNJA6+dkwiriiltimjAi1zbkxYb1ukC8tROlEVaajadE/2p2wGWnwbrGkG5oPG0iDng1bB2Lnp+M9DSNbg0lxpYNL5EL0f12ujQTv3SWb28SbZkK6BkzSHG0XMtSzMwJyQ6HhK56B76dtSKGWdxR0NAF1fNmA/9P6yT8mb3zCUD8nodQfXNnWOVejzWbXqGjH+J+qNWy8X27NT7z9nrjTkExLvKpWbbMuK3zB/FDWt99RL3/+kcCMRy6TwPXsun5DVb+QjZtCEo8cedw7DgERm8ZLZ1FfO9YdyC7PsNcO7gEfZ0V/t4O6jNlpnWZJE0G8T5cQfQtuj4ozKydsmRKxamdWVAiN0/5kjv7O2W2zxg0IjN1Jpd2NjgqrI=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(7416014)(376014)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	sGIpg35EzJloYZFRxW5RT9RVpo1GV0tSigWnEd5JWPWUq3go2lfPJGy0Em8SjcD611OB4td/NW9s4T3zjTqrG84hi5Qw/yPD1/2XGXsiHVCUq5YIuc1OxtQgey2pBKCnVY4kMtIkyUnVhUf63SRF+a/AOW6W/zJ2c0H6wARnXfvVfdt/ReP2U33mkbQSlkNDdCAge5dmNgmf17l4qh1xyS4tykQOwVKeCn2f9mPSNmLaRJ0QT8WnW2TtmdKBvVAiPoPfvvQYR8XdI/SlJcId8NWQWgr0v4v9cUMJbVGmF34KHYJcoTBOEk/y1NvbyZy0YTtUl/sBR2RbyZI1ZdxxKKdcUluKQ1HUk//4ij5KsCP6/66p1flxwlSOfW9SgCKhw6nzt1mWrdhz+8VFVlfHRXGvhhFXCoWwYNuiHAlHaz/y745jN1cpGe83sK3+gIXy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 05:18:26.7895
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 928831fe-0fe9-4ce9-265c-08debc788c44
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F40.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999251

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
index eee29c26169a..785fa2d575f2 100644
--- a/drivers/iommu/amd/iommufd.c
+++ b/drivers/iommu/amd/iommufd.c
@@ -43,13 +43,37 @@ size_t amd_iommufd_get_viommu_size(struct device *dev, enum iommu_viommu_type vi
 int amd_iommufd_viommu_init(struct iommufd_viommu *viommu, struct iommu_domain *parent,
 			    const struct iommu_user_data *user_data)
 {
+	int ret;
 	unsigned long flags;
+	struct iommu_viommu_amd data;
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
+					  reserved);
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
+					reserved);
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

