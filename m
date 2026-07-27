Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010068.outbound.protection.outlook.com [52.101.61.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2FB2641EE
	for <iommu@lists.linux.dev>; Mon, 27 Jul 2026 13:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785159040; cv=fail; b=TrffAoJU9drq51wJipgZIXcbLlRpJrhuYOobHAdvG0xWOZ12UGAWMpOE1Y9qY1XOiqOt+Bl2J9bPEuYWFCW0cfxgwjw/wrH4pOjHCncBya/fTL8UyEobvyvWIV0iRtWbYoZpDqcDxv/ZKGLXzBJ4v2l/k5eTPQ9AjZy1GVUkZH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785159040; c=relaxed/simple;
	bh=7ZvJpVnpGOnxBJOy3G12QgN+w1FTbs+loLfLchIPrfg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jeCdFe6Tw6SLrx214z8h/yN5FeH/sENRXU7G0s3SC/H5QDCL1B17kwFjJ8Dwate/+KVvL8iAg4AGVveTpfxodPmbOgnJ/lymnfvN/orT5jrxBmVrzMkez5e7XgmR99m0ocO7xhc0oCgs1OqiFQO4hgBCdPF3lGAKq3sBDZWUCOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ny6f60Lt; arc=fail smtp.client-ip=52.101.61.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ny6f60Lt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GP7o1HkKfkxjDhF7nu9v5kRIPnnq7nAVg03VLNAX12aI/gGOzoTTDODfvPMCbJfv6T8eXeC/sUiRG3W/goxPmryGJacVKYKm5yAMKiX0XW1Wk1et3sB4X0rSQ9uLbpdWWOwgWzr4r2fj43YV2oRNHtjqUfFMLRW6zhKCrts0c1HVKkZ67K49c1jcPZf+1lmED9TmlkCbc/MfLHNDp3NusceD8DRIi7mFvGFXfKp8YY9Kwi+Ad6JoeKbGz5hSA2P9NJWl4egmeZ/zSuwTYSngzTO1HJgj7//j+wyL37/u7rAn/q0Nnz0uWh9Mrjatl578D8QmE8+0YSnMj1mHZCU4GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BD0MVFkxtwaot/q9Am8NjtefdQQTTtjcfGaOhYrR3c8=;
 b=g9rvzPDCyP+PZXor6MPLZ4Pw60AUni0gbTxxieN9EIQwzmTPfGGUHQ/I7msNNLhDoR+4dgZAZH6Zb/V6twJRU5wquaV2oB0XJCK5P7fBlh9EFYjCd44QWj6MLqJgszPR3KSE0i1SMvsE6DEgnLebN4X9rsDXJSHY0uHeCEv+y6oX3V+GV7tdRn27mzBtr/LozmiaiQKjGhskN1409grPmMBA4Izsyo7yOoGRGOJctG/WtcCEtgwXm9MchwuHOYi+IolDCVtt+lPxQN11HPdwgI2cO+WQC3hgMl1xOcPF8ot2QXGo+oSuPz8bpq8+kuHFzoihg6rf565GrtWzBGnM7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BD0MVFkxtwaot/q9Am8NjtefdQQTTtjcfGaOhYrR3c8=;
 b=Ny6f60LtGyf2VCx/EcLE2vqio0FnNG3pQP353NuwCPFSapFIU9PdqrJ15vkcyIEdLl9ERM0geiY0h+IfMjngBAobyTCE0mFdfOWSyrlQ+lA3gV7qEIi2IURpMmm/pdUfVpTkW9t9eeLl65CkimUd07ljyGrqukYTvv5bxPY63ZE=
Received: from SN7PR04CA0202.namprd04.prod.outlook.com (2603:10b6:806:126::27)
 by MN2PR12MB4112.namprd12.prod.outlook.com (2603:10b6:208:19a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 13:30:32 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:806:126:cafe::a3) by SN7PR04CA0202.outlook.office365.com
 (2603:10b6:806:126::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.13 via Frontend Transport; Mon,
 27 Jul 2026 13:30:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Mon, 27 Jul 2026 13:30:32 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 27 Jul
 2026 08:30:26 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<Sairaj.K@amd.com>, <jay.chen@amd.com>, <wvw@google.com>, <wnliu@google.com>,
	<dantuluris@google.com>, <chriscli@google.com>, <kpsingh@google.com>,
	<alejandro.j.jimenez@oracle.com>, <joao.m.martins@oracle.com>, "Suravee
 Suthikulpanit" <suravee.suthikulpanit@amd.com>
Subject: [PATCH 05/24] iommu/amd: Allocate Guest IDs for IOMMUFD vIOMMU instances
Date: Mon, 27 Jul 2026 13:28:54 +0000
Message-ID: <20260727132913.22475-6-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260727132913.22475-1-suravee.suthikulpanit@amd.com>
References: <20260727132913.22475-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|MN2PR12MB4112:EE_
X-MS-Office365-Filtering-Correlation-Id: 369de5f4-a200-4058-5395-08deebe33b89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|23010399003|7416014|376014|82310400026|11063799006|5023799004|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	tCVPU1JJdu4hGZt0taezizjyL7vVWG7PJ4TgGkynZFJ15u4PvxhFYTuQMOiMGKxWPUto+9XtzMAaF2EhTk2Wu0Ke+baGkaqIYuV9FSIZUGUiIXzHAqde4defHSczXYLkoVJIQOTHGvpxupTFGM0YwiPg7N4xNQwrYWRMP+bC61i3mJCzIQts3llDfEC01Xe+SAIFjqW+HJlbNVEA0PucjuVcQBQyhUiN2dX6M9jElPRfDPk1TmY3J7TivW0jH2rOwRws21qHgiCReTBOlBJNQdPyjdq5dgTiwIOMfeBxITVw+6PGvNeH6nYNC34qygOJxGM/e+6RyO5qpQ8Cwo5sP7GI72E3AkC1x8gzwMC07kDlsWrcT+RAX+6xJ3vkKzqvcNkzErieYA0zFk+2a8dYvTe5Ol0cKnVtH6PJokW8BvZwiSzsPDYeqr83M/Mnv0gtALWw78QSwdiDTe3T+xNVkW4aoCIMejSYPcAohRpkqSGZxHSIpK6RGS+8VnvhFCnNiO+dMZ1K5wgVa4E9upwWxDU7hzavR/fGE6KTkRLyVH1eVHjgtfnPkqhzlKFCn8dRd54ed6Y6FsuGvRTq6KgD32QcNfv46S0eeGHfTk8G9/pjPNpE1fUntJXDHZpbt2ka3aRC4fEjHW5bq+FwuJmVFFh8xa9yLdKhm7s9Az2D2jh2R7t26wASdWaZVAzM713ot48MLVPhYpE8mq3R4UiGhA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(23010399003)(7416014)(376014)(82310400026)(11063799006)(5023799004)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1q+jsEjh9/VEJ/Yz5Vl9ZPLTIIO/w3XwhlBWxAuGaw9gWsYXjmfdkR/E2ZkXpjcqGt+ABwZpqjbAGIfWv9BGYXyccKt3z0CIlFT4lbS3uqK2FVg1VpwEHhNuBwjyI7BJAEZrRY4EK+K0Ayx3KfgvxJsaMcXHzZe+aABkjvy8Qg4zgaAAQcE46USd0+NfvXHZ1WcufmT71uEiaqqxyOulPtouKnBqhiGeSrHGaXQ0DzTL33ZP7xLvlC6AqFRjk8g7LAGPiBdccrCSRV/8rKlCW1Jk9a9/2KNDwmC6fL9oczxq1ZBnTiH+I3BA0JR69gJybalCdW5WlqB38Hzi79fovELF4YXtTw4JpTR4V1Rh+GSmZCVpUwaFOLsSdeOIbKdKS7hxxm45ierTTgZneO1+dD9jaX/3nO1PdTam6uTa3LHSdetN2Fm0Lpqat+r/r+2V
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 13:30:32.1472
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 369de5f4-a200-4058-5395-08deebe33b89
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4112

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

