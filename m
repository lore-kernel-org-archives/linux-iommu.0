Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012006.outbound.protection.outlook.com [52.101.48.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08EF313522
	for <iommu@lists.linux.dev>; Thu, 28 May 2026 05:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779945542; cv=fail; b=LOKaP+sPigYbWc1vEzSworYWOaX/VjF+ac+lye8HGou2P8ealsfH0s89cUzZPsoPF1MZXR+OqaF5u3AykcJg/5GW/1k1QDfQCWVSXfjBpmkbTYj3an/nQZP1qjT7nFC57JDMK/JgZvEQWJtUxcuW89r70xfPIasMd+iFj8moYEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779945542; c=relaxed/simple;
	bh=ACaTyPfSIdzZkIkGItc+WWfLgD2VIZfLfmxQ270/PjQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c8b9uXYXAI9x7hPz1wSJFsX81Imoc5/Q16XROxR9jYAmX/BUwSazaTb20adKkzjctaBxCa/mMTHDTPOXNkwiLb4fxeYq5LD0YyElDIu8Gl7/Pkar9ARpWTnkLfX20Ifx2K8ZHGBZArD2wcZf/R5h5XLl09ba3fljjSzg8sFP+ko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OgZZTeh8; arc=fail smtp.client-ip=52.101.48.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OgZZTeh8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=trLTFehYvRRnu8PgAC903QS0UvPv/UMac1UdCbRCvYn7+vuRIA8ES9RikmXuR3HD1PyE8c5PjqqLo4Hxlfj803F6o+swqTQs/EByIsTBjUYNEGrD3DdtjD4G+UNuqzNIPmI/Kb5crhEj6TP0uW30KSx27fopcQClS6+XpYOaDX1FiDfR3hWXqwL9fvdb2Cnw6KwD20qXH/vEo/hcNnqAzJ5vzYg1yllLysLrZ6gJHQQwLXykvW9PYtAb/zHrvP3COaH5btwZQ3AyRS146zGgZ5/BTnaq/sLYdfyh94u4LU2UlHgzNyc9E70Jdkd1kx/hEHqgFPWtVzYr8hvnCLQzAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wv+PHbubPbFtyfR0yekV5N60fuFmsJ/EnEFDdFOs1eo=;
 b=G/+3fWhUlsLZ4luTA9pVMu7vMFEq9UOhNg4o4v7FUIgVIvmSTtKk0Gpxy6XbYDmLeIu+Lfi7IzYR0SH5jf0vu51j2IF1ycvUxWuEA4qLrsZQCjHL1DN/l00XqcZ7DTFZeVWY4A/SjY2DrCTif/zktoQnhfbMgOXwnlH8rRpe19W6U4XL+2x4AeYg8wj4tfEw8DC6W6P2DjX9Wu4x/dTQAlRsiigoEmKCP7dhQmFahbyxPo+N0lbBjVW4TP80wJm5phk9mTWT9kYsEcoRTCdfU0W1k3bJEnPHPE5ivKQFpSIqkN4szCUbw95qMuUK7gKx0HhsZvyamcnEm18NvpoDig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wv+PHbubPbFtyfR0yekV5N60fuFmsJ/EnEFDdFOs1eo=;
 b=OgZZTeh8h7Ajzin1C6GKPD+PDILtloRCdfMSjXDJu7EuGHdBh40sxeWMbrAl3v8GVqmJ5Q7/n0ZrxUpMB1TmOQK8p92rH4aV6rlJU3izcZ8Yya4e94WiwPTNvk2ETBcwJwnJm3Y9X2aIcV9Dam8ZClVZLLUJO9hf3WeczYCKIn4=
Received: from PH0P220CA0004.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::22)
 by BY5PR12MB4228.namprd12.prod.outlook.com (2603:10b6:a03:20b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Thu, 28 May
 2026 05:18:56 +0000
Received: from SN1PEPF00036F42.namprd05.prod.outlook.com
 (2603:10b6:510:d3:cafe::1b) by PH0P220CA0004.outlook.office365.com
 (2603:10b6:510:d3::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.12 via Frontend Transport; Thu, 28
 May 2026 05:18:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F42.mail.protection.outlook.com (10.167.248.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 28 May 2026 05:18:56 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 28 May
 2026 00:18:51 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jay.chen@amd.com>, <wvw@google.com>,
	<wnliu@google.com>, <dantuluris@google.com>, <chriscli@google.com>,
	<kpsingh@google.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v2 11/26] iommu/amd: Allocate and map vIOMMU private regions
Date: Thu, 28 May 2026 05:17:23 +0000
Message-ID: <20260528051738.596013-12-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F42:EE_|BY5PR12MB4228:EE_
X-MS-Office365-Filtering-Correlation-Id: 86e0b27c-6a48-4e97-809a-08debc789db0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700016|6133799003|11063799006|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	XtuRKcfhJdEeQUE24iVzQwXsOZoxHXaw5drqDUXq7OuOI14t3Dl775uoTZHYIVmaT/boBS6UdpeDAtr5/7pqvSpBJ2LxFfdDaMWdKmbdBXa/9EWjKwQiIRRe/NJvj8RSW7vaOt9ztpKB+qAGZRh0K8pd95SaqoP7rn03wUZ/Ss+fTJ5oVGKO2TZq/ri3/feJWUI3k0r5PXGThZThG+LXILPaIjPKk20xuBvxtxMKKvO1edGPnh2vKCOrVteKD65e7PUkd0C7FVxWmBzpMPMLfI2jaXmS4a3OqNnGzCwZ8CJy9CXhX/MyquTnRyuxd39wMAziBcund6Yu/DbeFcecD091xefvb8towWma5uw0CbUY8KE3UyrbGwr9A2eWjwZuC4VZqBVehiANt0C1Jn2duk7j1Ptnvk8jkc9li8LS3SNPDzocO1KNW0DGS4UU+wDhvFpi7l74dBClhMN8kZf+bO0Uvxq29+eCW9xfOjP2UzghXfPACFEQOySFRP/xM0c5tmn4Fbxbr8zOopb3kpQNKZ+FRPh52oMYzgZLT4sk0mvslktgiVUyLBUSBEyGvdaQlU67KrzfKntJn0LPNly15IDuZR4zz6UV20f4xXI6IWUmi8cZQlWM8im6YOMik8xPj4wD+sDQxt7BlF9Of/Mja7Nag4sOEvwYggcNG+ctPigjOGspwM/NOMjWqwWZpfP4tInYePG1EFt5L/dreA5MfULYKb8dec8Q2RDDUQONJjY=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700016)(6133799003)(11063799006)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	YEMSBndj5xpD/FNSSaIa2HkVGcb/P5IbJxj4/0sVZSdSKGuy4aEGxvQ9koi/FfvGxoCmBimOO+vZkkaseQDOETYBgATwWQ9rvQ1/+LJ7X2/obHNlXLfyO5p3gLdGeSDTaN8xHV4B6JiO6VwBWLgu8F4XdtK42hmWTtW5eM5vEnc42uCKRgP0PCIis25zJP2HpwX9J7vHORgtfjzB+SXT+opKvIWIn9OqamKQSnjddZw3f664m7A7nQaY5qFk7S2FmelKJC9+jY2ZFjlJILM2NifvVeHLLwbej1INgs1X31RJr2l23UkucvrSvXwt7FtN3sWHTznWVFje2Jyb387724d0zuIq99+VyiF/PadITe0H9tyEsUebTowGWQDNanSsymzoDgaAbuYigH7NZkVNB3qZanxnr8HFMdShmoyBTsBdHJhwmUkbMHvonEwj4FAq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 05:18:56.0220
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86e0b27c-6a48-4e97-809a-08debc789db0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F42.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4228

The AMD IOMMU Private Address (IPA) region is allocated and mapped during
IOMMU driver initialization. According to the specification, 8MB is needed.
Since the hardware does not require the IPA region to be physically
contiguous, split the IPA region into 4 2MB subregions to match hugepage
granularity and create mapping in the v1 page-table for each IOMMU.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h       |  3 ++
 drivers/iommu/amd/amd_iommu_types.h |  8 +++
 drivers/iommu/amd/iommu.c           | 16 ++++++
 drivers/iommu/amd/viommu.c          | 79 +++++++++++++++++++++++++++--
 4 files changed, 101 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 1aa79a26a127..279f458becda 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -105,6 +105,9 @@ void amd_iommu_domain_flush_pages(struct protection_domain *domain,
 void amd_iommu_dev_flush_pasid_pages(struct iommu_dev_data *dev_data,
 				     ioasid_t pasid, u64 address, size_t size);
 
+int amd_iommu_flush_private_vm_region(struct amd_iommu *iommu, struct protection_domain *pdom,
+				      u64 address, size_t size);
+
 #ifdef CONFIG_IRQ_REMAP
 int amd_iommu_create_irq_domain(struct amd_iommu *iommu);
 #else
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 02d359f09148..a5e2f32590d1 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -424,6 +424,13 @@
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
@@ -817,6 +824,7 @@ struct amd_iommu {
 
 	/* HW vIOMMU support */
 	struct protection_domain *viommu_pdom;
+	void *viommu_priv_region[VIOMMU_PRIV_SUBREGION_CNT];
 };
 
 static inline struct amd_iommu *dev_to_amd_iommu(struct device *dev)
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index d89664eba898..8b441f68bc47 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1808,6 +1808,22 @@ static int domain_flush_pages_v1(struct protection_domain *pdom,
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
index 14426649074f..90ed2eb92aeb 100644
--- a/drivers/iommu/amd/viommu.c
+++ b/drivers/iommu/amd/viommu.c
@@ -131,8 +131,66 @@ static int __init viommu_vf_vfcntl_init(struct amd_iommu *iommu)
 	return -ENOMEM;
 }
 
+static void *alloc_private_subregion(struct amd_iommu *iommu, u64 base, size_t size)
+{
+	int ret;
+	void *region;
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
+	ret = iommu_map(&iommu->viommu_pdom->domain, base,
+			iommu_virt_to_phys(region), size,
+			IOMMU_PROT_IR | IOMMU_PROT_IW, GFP_KERNEL);
+
+	if (ret)
+		goto cleanup_mem_attr;
+
+	pr_debug("%s: base=%#llx, size=%#lx, subregion=%#llx(%#llx)\n",
+		 __func__, base, size, (unsigned long long)region, iommu_virt_to_phys(region));
+
+	amd_iommu_flush_private_vm_region(iommu, iommu->viommu_pdom, base, size);
+
+	return region;
+cleanup_mem_attr:
+	set_memory_wb((unsigned long)region, size >> PAGE_SHIFT);
+err_out:
+	iommu_free_pages(region);
+	return NULL;
+}
+
+static void viommu_private_space_uninit(struct amd_iommu *iommu)
+{
+	int i;
+	struct iommu_domain *dom;
+
+	if (!iommu->viommu_pdom)
+		return;
+
+	for (i = 0; i < VIOMMU_PRIV_SUBREGION_CNT; i++) {
+		if (!iommu->viommu_priv_region[i])
+			continue;
+		set_memory_wb((unsigned long)iommu->viommu_priv_region[i],
+			      VIOMMU_PRIV_SUBREGION_SIZE >> PAGE_SHIFT);
+		iommu_free_pages(iommu->viommu_priv_region[i]);
+		iommu->viommu_priv_region[i] = NULL;
+	}
+
+	dom = &iommu->viommu_pdom->domain;
+	amd_iommu_domain_free(dom);
+	iommu->viommu_pdom = NULL;
+}
+
 static int viommu_private_space_init(struct amd_iommu *iommu)
 {
+	int i;
+	u64 base;
 	struct iommu_domain *dom;
 	struct protection_domain *pdom;
 	struct pt_iommu_amdv1_hw_info pt_info;
@@ -144,22 +202,33 @@ static int viommu_private_space_init(struct amd_iommu *iommu)
 	dom = amd_iommu_domain_alloc_paging_v1(&iommu->dev->dev, 0);
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
+			viommu_private_space_uninit(iommu);
+			return -ENOMEM;
+		}
+	}
+
 	pt_iommu_amdv1_hw_info(&pdom->amdv1, &pt_info);
 	pr_debug("%s: devid=%#x, pte_root=%#llx\n",
 		 __func__, iommu->devid,
 		 (unsigned long long)pt_info.host_pt_root);
 
 	return 0;
-err_out:
-	if (dom)
-		amd_iommu_domain_free(dom);
-	return -ENOMEM;
 }
 
 /*
-- 
2.34.1

