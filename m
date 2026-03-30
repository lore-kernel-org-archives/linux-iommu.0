Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010012.outbound.protection.outlook.com [52.101.61.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45093AD50F
	for <iommu@lists.linux.dev>; Mon, 30 Mar 2026 08:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774860220; cv=fail; b=t2Lqir/+EnAk0ytBZVb6vN9qzzU1v4ztLEjH2LrSWk4BOCDZPg5PanUyO6HwQasRMVv64Pk5MhaX8o9IGAGotMCgpIeBL9oF7gcboRYAcqmRMTod7e4J2na76grHhNmpPv44VvBUSFRuH1TyBcc0UVLOqHRMdSp3tcirhKyB29c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774860220; c=relaxed/simple;
	bh=6yrJ3sSJ5Dl8iifziE4fDmMIaU2eQbXSRfhBrUrSkWo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j60UVs1FJjObXZQPQystwab0LK+Hq1lFFtmqqaaI4rHmD/F6NmEN+NHdKm9JUZhPxebzl4uFEog2OiI8Yv9zvMiw8fRurQVLZXJSc6fqrYBCfrxh4w8lxDH/4TW6DHcx25KndxvQ4+fU9Fk0oLDN1oJtP99Zpaq/xd8yKRT8EaY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eCUWXSK2; arc=fail smtp.client-ip=52.101.61.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eCUWXSK2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hLC2LsqwFzCQjIgLPkRDcp+cA06gDgmBLwETfI705QY1nbPSYAjHlCSEoAnDHCo9XkWbEG90Yrdl1rWOCDSx3HcIgGcw2wyGExWFCA3Pc30W3FpKdx8Zye52UTz9K4a79byyohiO+si/OsEst+WuAsdF/94MhXpQI8QvOJEShRObzZp9oRJLCLAvO04mTSWH+cQGrYGCvQWCLU/+dtYbOiirV6LJVTbLf0wskgmUyvK03fJ+JZbvXdH10Gm9Z5TglcR7k8ZrwxEZGToWfADgqubX2vWGU2VjNnXI7K6xgdg3Uu3UpSOvQnFOJ8XkDOX/yOwM5lwH+hv97Fssn+LaGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vrKmASRNKmn2TX2p79fMRHfEFhtUAHJLfG7kyricmmY=;
 b=obhCTwD/RDOlBlPSjeid8bpmD/IVhSLx8hnobrY9Agv/to65AV9hOvViGAOwb9Mgx1YDZwvhsSLjIaNuXd0Ih1Kpd22gUELMMXFL2N1Wvc3cseBwHyDCBa8thAU4VFLzdk4WPEGUVkL0m32+SgPyeVcIlOQetEsDs16J0Ms1bhTNQxklsDVPhFxQ1v9od59TARA2C9B9r+JEcxnYb6GDEQ63dQtBz3OWcEdwN3KYABUDgsEzTCHDzuaPNBbo+XgLQEaZgubhv4aaDFnnu26YMOBs2lDuKxlumf5gioA4pu8eF1sOYYIcQ5fogg5sZrnEE2nXYgqSeh34OowOi8yujA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vrKmASRNKmn2TX2p79fMRHfEFhtUAHJLfG7kyricmmY=;
 b=eCUWXSK2qq/ql8KnOjYXMWjdfbV1rSsgxpb5U0Tj8mzSignZZGo/BAuXVmE2Hi1Hti4xdp1UcocN4IK3yxoKnZJevCixJYjSoDXZTmUa2LiFQtzzO3BrxuM0pdIxzD4vZCmQ/PkIIER/77pocktQKcJ9AiWGAsrLg0AITkdK4fU=
Received: from PH8P222CA0005.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:2d7::23)
 by CYXPR12MB9277.namprd12.prod.outlook.com (2603:10b6:930:d8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 08:43:35 +0000
Received: from CY4PEPF0000E9CD.namprd03.prod.outlook.com
 (2603:10b6:510:2d7::4) by PH8P222CA0005.outlook.office365.com
 (2603:10b6:510:2d7::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 08:43:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9CD.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 08:43:34 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 30 Mar
 2026 03:43:28 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jay.chen@amd.com>, <wvw@google.com>,
	<wnliu@google.com>, <dantuluris@google.com>, <chriscli@google.com>,
	<kpsingh@google.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH 11/22] iommu/amd: Allocate and map vIOMMU private regions
Date: Mon, 30 Mar 2026 08:41:55 +0000
Message-ID: <20260330084206.9251-12-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CD:EE_|CYXPR12MB9277:EE_
X-MS-Office365-Filtering-Correlation-Id: 727ec4c7-8ec5-4cea-cb6f-08de8e386de7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|7416014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	QXuHZlLAYW2Z9nyLQ7t/+SbLKYGmHYb2ooHpGSSHXQRoX+eYsjpNmGVesT0Tg18e4DopQCw0SCS7Okz34AvRQzjZ6pxgPGzQfAYP3g1zs6P30+ZTEXTMXNNWI2cbYZqHZDMbneVehlYeB3s8wPD6bOBh2YBHICkL+5TsEJXwVmKVx8hQIYPPppfxZF9XoGzqhItdM1Fw785WNWToGI42SpPo7yx98gKWjcaZFkefC4kZWNfOJPzzsuuR2QOPBqvJEHGR0fBh0FVMkw2q8l9XQzSD5RmQulaIJEoTqq1r42iu7OwOQSbupBhpM3qIkjwCzNw1qGWC5w29BJAkf1kIpG7aWhX60dM+dWq6kppIgN/SZaX9W92r8JLyJ0x+9VqdyzEbHzXT6zXtrbv4ElyMBMy3fFSUqYV7i1y0GKVs+56IgdbQOe3Om4PztsOnVybuut1Oo4hMWs2NoywAIDXRYZk6EJ9+W2C6YlawOCGTZV58cm+2EWq2vaZmhHyw9FuF9L6CwHGFpBvI+E6J9L2yPdNU9ck1qJrGuHPt7jI5y0mxIBj8DZXEmLG03jT+xY4sYEJdSl+KlJQNt7cRa/4x7+LLV8aC3OYkgUCOspRrUR+AigYi81gUoVVMyD3YNJOFdvwsQogReEENsFy+osZI01CSFUvLOETSeVHInIthxgL0eFFMI8RIR8QVSd/lAPUqfN5+WNVvEIZiPnBWCkXu7c0FTJ2U0ogporiftCwwGIqWsFhj8jbgCcqJ+aKevZSDWR7dGhqsVq2CvUdgvpwNiA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(7416014)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	iDLb/IHQOZKqcHFPVKoe8k4tkD5TBv8aGRC96Akio22KlBIkj8kEP6O3q3IXBnfGAoKpc+kNrvXstEDK0Iw0ZVACfdEbxRWr/xzJ4M5X/25j8P1YExWL6hXx619v5bUo1geqgIYOdB1ASvPi0UJiRsfTQ/cA/QnDYi9VIvOWlK25CouCm1ouqLMPYEOFoquXpO87yxZqJxXoCvsfiExf9EAbRMbibuDgPmPFyEd+Ui5A5xtAXkBhUgc2PCVz6dxs8XZDdRHQXAVZzxGO4DpEBUbQAaXxTtjc4/HLYxV05eCJLiooGA0jb2LUtE29Iv+TvnASr4JJ91MbcaCTdiakIhYKqWfxtswWYgeGpRorQv74/rPWNRWWjxOn9v7MKKi4AIBddTnBKEr2y/ii2dWRFdw30LikyNeEihNcoEH77rYJhMwN4LDJU+5zjgYDPcEK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 08:43:34.5523
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 727ec4c7-8ec5-4cea-cb6f-08de8e386de7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9277

The AMD IOMMU Private Address (IPA) region is allocated and mapped during
IOMMU driver initialization. According to the specification, 8MB is needed.
Since the hardware does not require the IPA region to be physically
contiguous, split the IPA region into 4 2MB subregions to match hugepage
granularity and create mapping in the v1 page-table for each IOMMU.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h       |  3 ++
 drivers/iommu/amd/amd_iommu_types.h |  8 ++++
 drivers/iommu/amd/iommu.c           | 16 ++++++++
 drivers/iommu/amd/viommu.c          | 57 ++++++++++++++++++++++++++++-
 4 files changed, 83 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index ad88c4118719..9bf07887b044 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -100,6 +100,9 @@ void amd_iommu_domain_flush_pages(struct protection_domain *domain,
 void amd_iommu_dev_flush_pasid_pages(struct iommu_dev_data *dev_data,
 				     ioasid_t pasid, u64 address, size_t size);
 
+int amd_iommu_flush_private_vm_region(struct amd_iommu *iommu, struct protection_domain *pdom,
+				      u64 address, size_t size);
+
 #ifdef CONFIG_IRQ_REMAP
 int amd_iommu_create_irq_domain(struct amd_iommu *iommu);
 #else
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 36ca9003dd88..2d96c72ba45f 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -423,6 +423,13 @@
 /* For vIOMMU, the GID is 16-bit. */
 #define VIOMMU_MAX_GID		0xFFFF
 
+/*
+ * Total IOMMU private region is 8MB (4 x 2MB-subregion)
+ */
+#define VIOMMU_PRIV_REGION_BASE		(0)
+#define VIOMMU_PRIV_SUBREGION_CNT	(4)
+#define VIOMMU_PRIV_SUBREGION_SIZE	(0x200000)  /* 2MB */
+
 /* Timeout stuff */
 #define LOOP_TIMEOUT		100000
 #define MMIO_STATUS_TIMEOUT	2000000
@@ -810,6 +817,7 @@ struct amd_iommu {
 
 	/* HW vIOMMU support */
 	struct protection_domain *viommu_pdom;
+	void *viommu_priv_region[VIOMMU_PRIV_SUBREGION_CNT];
 };
 
 static inline struct amd_iommu *dev_to_amd_iommu(struct device *dev)
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 07a0314a3fdc..8143cf03dcc1 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1803,6 +1803,22 @@ static int domain_flush_pages_v1(struct protection_domain *pdom,
 	return ret;
 }
 
+int amd_iommu_flush_private_vm_region(struct amd_iommu *iommu, struct protection_domain *pdom,
+				      u64 address, size_t size)
+{
+	int ret;
+	struct iommu_cmd cmd;
+
+	build_inv_iommu_pages(&cmd, address, size, pdom->id, 0, false);
+
+	ret = iommu_queue_command(iommu, &cmd);
+	if (ret)
+		return ret;
+
+	amd_iommu_completion_wait(iommu);
+	return ret;
+}
+
 /*
  * TLB invalidation function which is called from the mapping functions.
  * It flushes range of PTEs of the domain.
diff --git a/drivers/iommu/amd/viommu.c b/drivers/iommu/amd/viommu.c
index b7881de0b61e..27179d5087bc 100644
--- a/drivers/iommu/amd/viommu.c
+++ b/drivers/iommu/amd/viommu.c
@@ -133,8 +133,44 @@ viommu_domain_alloc(struct amd_iommu *iommu)
 	return &domain->domain;
 }
 
+static void *alloc_private_subregion(struct amd_iommu *iommu, u64 base, size_t size)
+{
+	int ret;
+	void *region;
+	size_t mapped;
+	int nid = iommu && iommu->dev ? dev_to_node(&iommu->dev->dev) : NUMA_NO_NODE;
+
+	region = (void *)iommu_alloc_pages_node_sz(nid, GFP_KERNEL | __GFP_ZERO, size);
+	if (!region)
+		return NULL;
+
+	ret = set_memory_uc((unsigned long)region, size >> PAGE_SHIFT);
+	if (ret)
+		goto err_out;
+
+	ret = pt_iommu_amdv1_map_pages(&iommu->viommu_pdom->domain, base,
+				     iommu_virt_to_phys(region), PAGE_SIZE, (size / PAGE_SIZE),
+				     IOMMU_PROT_IR | IOMMU_PROT_IW, GFP_KERNEL, &mapped);
+
+	if (ret)
+		goto err_out;
+
+	pr_debug("%s: base=%#llx, size=%#lx, subregion=%#llx(%#llx)\n",
+		 __func__, base, size, (unsigned long long)region, iommu_virt_to_phys(region));
+
+	amd_iommu_flush_private_vm_region(iommu, iommu->viommu_pdom, base, size);
+
+	return region;
+
+err_out:
+	free_pages((unsigned long)region, get_order(size));
+	return NULL;
+}
+
 static int viommu_private_space_init(struct amd_iommu *iommu)
 {
+	int i;
+	u64 base;
 	struct iommu_domain *dom;
 	struct protection_domain *pdom;
 	struct pt_iommu_amdv1_hw_info pt_info;
@@ -146,12 +182,26 @@ static int viommu_private_space_init(struct amd_iommu *iommu)
 	dom = viommu_domain_alloc(iommu);
 	if (!dom) {
 		pr_err("%s: Failed to initialize private space\n", __func__);
-		goto err_out;
+		return -ENOMEM;
 	}
 
 	pdom = to_pdomain(dom);
 	iommu->viommu_pdom = pdom;
 
+	/*
+	 * Each private region requires to 8MB of memory to be allocated
+	 * and mapped. Split the region into 4 x 2MB-subregion.
+	 */
+	for (i = 0; i < VIOMMU_PRIV_SUBREGION_CNT; i++) {
+		base = VIOMMU_PRIV_REGION_BASE + (i * VIOMMU_PRIV_SUBREGION_SIZE);
+		iommu->viommu_priv_region[i] = alloc_private_subregion(iommu, base,
+								       VIOMMU_PRIV_SUBREGION_SIZE);
+		if (!iommu->viommu_priv_region[i]) {
+			pr_err("%s: Failed to allocate vIOMMU private subregion %d\n", __func__, i);
+			goto err_out;
+		}
+	}
+
 	pt_iommu_amdv1_hw_info(&pdom->amdv1, &pt_info);
 	pr_debug("%s: devid=%#x, pte_root=%#llx\n",
 		 __func__, iommu->devid,
@@ -159,6 +209,11 @@ static int viommu_private_space_init(struct amd_iommu *iommu)
 
 	return 0;
 err_out:
+	for (i = 0; i < VIOMMU_PRIV_SUBREGION_CNT; i++) {
+		if (iommu->viommu_priv_region[i])
+			free_pages((unsigned long)iommu->viommu_priv_region[i],
+				    get_order(VIOMMU_PRIV_SUBREGION_SIZE));
+	}
 	if (dom)
 		amd_iommu_domain_free(dom);
 	return -ENOMEM;
-- 
2.34.1

