Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012070.outbound.protection.outlook.com [40.107.200.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F04B313522
	for <iommu@lists.linux.dev>; Thu, 28 May 2026 05:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779945534; cv=fail; b=HrzQbkhXy6H+ga5XgiSP7JG9zM8z/vG7eUe5UotiycnMqPFTrBjBq+t3gdXyHPHMxeSopYO/nNAz5MzOSkQkq1d1dHD95yfrnD+ST9+hZKr6KoDCg/SBxmZunNasdhyznn53F/XySlI/pXCpqEJrzbkmD25l6huEnEFd8/FVe6M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779945534; c=relaxed/simple;
	bh=reYQffqwXyRQ0qLCQrt4dgroEyXAJv+io1R6HEOyqJ4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KoY/WYU3JveW+9+SzJ8RTewKpHzP2ZCUclhdHQCOZ/s10rMK3qFzdUs1pbSBPSpOltcsVAdPYw31NqpqZIFQQi6ec1KNmvqnzzaxRFSfXprUdbjIOvQHnXBKeY4RhKRWp+fqm0u0LQi7OUjza6sR6hkKAEyEGVCqp8cKA6EuxCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pNlfc8YD; arc=fail smtp.client-ip=40.107.200.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pNlfc8YD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f+KosOxJruqixRNn2gC2Z1lKBGXQha8JxZzhL8WAYrdpz78J0AdMtGXAHY7+WanPEwxZ5noHWLUOVxbPwpC87uSsz/u8iyASp0qkcahptrNW0WnVe9nkZfhCuh9Ja7ja+QgGuPFeL+Wf3HFpyeyBOwyn7EPKWXuvZBN9ohA4LmYe+PXHYxqwOLVYJueJQvIG0e5pQU9WU8xkSgY4Vu3PUOqFEJ/h5tQj4nbx7OtLntQQJ/kzKkfLlXc8f5Cq6qVe5nKZSdczUgYrTOMucqiawGZ3D9FdI2wJY5co7XWKjUudfreIsNMJ9M/caY8fILLnNAgsozGph95UDBHpNcD4qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dpXpK4qISvc8AcuRVTOCOrgjdQVbI2N2hQjOeBgstn0=;
 b=ORC5pFcit5AkwjSxdfDhQmT/2mTqPv7jB9r8nnuJDY4sDQMgRoZuFFjUl+lJZfMP50XtUqEsD1BEGn8SlQk9P58dBY26otphlaBipyUY9zoBOmB/e9RaaQISG2GMKDkFNCCUzc4O5QJDQIPxZxqfMAVQhcZQL7mB79epm4DBHK9BWQTMZIZ2dUtWNnNTz8lyukMvyAe52MfltqdA69kuN5aqbAn1Bljdc0zfSP37n7CBQ9wM2oIqwfnf6APCXNXWZXts8VvSKN/ZrHyTJrGRFDoA8kvaT8mSNbQwGpJYJYWDf4ud+YKGg+rtoi8x3JRFiZNj5/nssz6h8HbueosTGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dpXpK4qISvc8AcuRVTOCOrgjdQVbI2N2hQjOeBgstn0=;
 b=pNlfc8YDa8SnOZ9kYKtbRoXDgLFX4I93F7Ex6prNWOXMY0G8epnJSBRrFbTbJa8inTmPcyNV2Pjj3oDE7JHlQ7Y2F0pnpRFOY2Bmf8VkJlUC9nBUhCKhluw9fUSRM/NSTYYwtqmLLyyKz+ST6Ar9ZwpAG/Ca4oA6gZN8PVl+W/0=
Received: from SA1PR03CA0001.namprd03.prod.outlook.com (2603:10b6:806:2d3::12)
 by PH7PR12MB7164.namprd12.prod.outlook.com (2603:10b6:510:203::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Thu, 28 May
 2026 05:18:47 +0000
Received: from SN1PEPF00036F41.namprd05.prod.outlook.com
 (2603:10b6:806:2d3:cafe::e) by SA1PR03CA0001.outlook.office365.com
 (2603:10b6:806:2d3::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Thu, 28
 May 2026 05:18:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F41.mail.protection.outlook.com (10.167.248.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 28 May 2026 05:18:47 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 28 May
 2026 00:18:41 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jay.chen@amd.com>, <wvw@google.com>,
	<wnliu@google.com>, <dantuluris@google.com>, <chriscli@google.com>,
	<kpsingh@google.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v2 09/26] iommu/amd: Introduce domain for IOMMU Private Address (IPA) region
Date: Thu, 28 May 2026 05:17:21 +0000
Message-ID: <20260528051738.596013-10-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F41:EE_|PH7PR12MB7164:EE_
X-MS-Office365-Filtering-Correlation-Id: e1e7cd31-4e61-4843-e86c-08debc789859
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700016|82310400026|1800799024|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	tzuqzuvMhAdFeKUvoJWR8Zoxt88Oa/zsWYbcl5u7xHw5MWFH6F5sIyYZzpx9bTa1hNTMvZAbWNctqxIphAcQd/QUecQnXElOWn8PQJkZWpEKYs+GRGgFurgupPg+MPBrxXdPyS7mm3xfuB8CDh/QU3Gu6kLfCmPFa5pHJF2SMgk/eOG5ZmwjSq+Mjt9zTkE0YvH7QDKYm4XJf13VfbeQuVNMdtqeeue9pIxI4ktY0nPbr1KSIj6CWOmKnakuR5ED7+qbh4VRKYXeSXRr/cHKNebcHdbpcT1lTymztOrwCPa+dnlch8NVI3cAfeiWUaddr/t1Dqr/wE6J04Vzor9Xq/vn1y8tmr+jhRorGIfBMlXya6YtPEM6Q1NeoUMHobMb4rVCIHZtCdxgD1ullF6Iq3/+uyGVd9becpgBHFs+WyDubukbWGaTKaJuYCniMC07RauIznMqqV6hnvgN+zsq25mmJS++vveCliFL3vOpfqF44BuaWGDhk/TS0eDRJq/XAMoVDKw9vVYqgGwwlVTq+e0fgPPasl2lOHQ3c3e2V0bkrsB2DsgX5Xjd6cBS/SkTG8HU49xlka/lzmqeqfuebh7IAfte/F6isBCpHr8gDXC5bWe4XxdbuJAdJi9BPqdcDEEPPNvVVH+w9BWRN/fXe5bvpjVOoqpA5mWtJS+Dpp83BmAsO/FekH4ggK3Jt1ZDuVMb/DJ/um5p0g5VyckuS4uvZaOybBfvbrBf76ZGbHU=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700016)(82310400026)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zQoRGXkfoSel/j+gLPUaGCC14vhWuuu05yztuFJrQzuoC58tl5nGr0NNUNa777yxeySluUDk/iqN9/EUvgYkPascb+jcFEXapGo2Ru7iR/g4oRyfM1j6+YDmaU4ErnLYr1NyHR6ub/szsc0VBE7JLhHTK4Tk4oGauzcv9JNpkDeRQM8tbORKK6UW4RRIUJP0K2c8Nu83K99lf2MpyqNdwgb/4zZsyKDq6uHjkMDgQrSb/tqWAW6Bb6dMKb71YPLENFQhyd8WjK2c0TeYkDK/tlVnDKKtJkbZSgTsotbLzwdGG7oyzTnq0AxBkxtIoyg5a7NBQTQLhg5XP4D7R7xDBoasV8/EhGluyxJw8CCa72V7uQH2TWh6fVZ8tkUPK1V73c4KaPi3QzmxWKwou8g09yHNOwNpKzPhUaqPjMHQDVwL8XAsw1b3u8QPFqzsa2ZY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 05:18:47.0700
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1e7cd31-4e61-4843-e86c-08debc789859
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F41.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7164

AMD vIOMMU introduces the IOMMU Private Address (IPA) region, which is
used to manage data structures necessary for IOMMU virtualization within
the guest.

Introduce a new domain specifically for IPA region for each IOMMU, which
is stored in struct amd_iommu.viommu_pdom. This domain uses AMD IOMMU v1
page table.

For more info, please see section vIOMMU Private Address Space of the IOMMU
specification [1].

[1] https://docs.amd.com/v/u/en-US/48882_3.10_PUB

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h       |  5 +++++
 drivers/iommu/amd/amd_iommu_types.h |  3 +++
 drivers/iommu/amd/iommu.c           |  9 ++++----
 drivers/iommu/amd/viommu.c          | 35 +++++++++++++++++++++++++++++
 4 files changed, 47 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 2ce207529ea0..1aa79a26a127 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -31,6 +31,7 @@ void *__init iommu_alloc_4k_pages(struct amd_iommu *iommu,
 				  gfp_t gfp, size_t size);
 u8 __iomem * __init iommu_map_mmio_space(u64 address, u64 end);
 void __init iommu_unmap_mmio_space(struct amd_iommu *iommu);
+int iommu_flush_dte(struct amd_iommu *iommu, u16 devid);
 
 #ifdef CONFIG_AMD_IOMMU_DEBUGFS
 void amd_iommu_debugfs_setup(void);
@@ -39,6 +40,8 @@ static inline void amd_iommu_debugfs_setup(void) {}
 #endif
 
 extern bool amd_iommu_viommu;
+extern const struct pt_iommu_driver_ops amd_hw_driver_ops_v1;
+extern const struct iommu_domain_ops amdv1_ops;
 
 /* Needed for interrupt remapping */
 int amd_iommu_prepare(void);
@@ -56,6 +59,8 @@ extern bool amd_iommu_hatdis;
 /* Protection domain ops */
 void amd_iommu_init_identity_domain(void);
 struct protection_domain *protection_domain_alloc(void);
+struct iommu_domain *amd_iommu_domain_alloc_paging_v1(struct device *dev,
+						      u32 flags);
 struct iommu_domain *amd_iommu_domain_alloc_sva(struct device *dev,
 						struct mm_struct *mm);
 void amd_iommu_domain_free(struct iommu_domain *dom);
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 44fa1d6c64d6..02d359f09148 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -814,6 +814,9 @@ struct amd_iommu {
 
 	struct ida gid_ida;		 /* guest IDs for this IOMMU */
 	bool gid_ida_inited;
+
+	/* HW vIOMMU support */
+	struct protection_domain *viommu_pdom;
 };
 
 static inline struct amd_iommu *dev_to_amd_iommu(struct device *dev)
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 6f5ecc48f4ad..d89664eba898 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1551,7 +1551,7 @@ static void domain_flush_complete(struct protection_domain *domain)
 		amd_iommu_completion_wait(pdom_iommu_info->iommu);
 }
 
-static int iommu_flush_dte(struct amd_iommu *iommu, u16 devid)
+int iommu_flush_dte(struct amd_iommu *iommu, u16 devid)
 {
 	struct iommu_cmd cmd;
 
@@ -2726,12 +2726,12 @@ static void amd_iommu_iotlb_sync(struct iommu_domain *domain,
 	iommu_put_pages_list(&gather->freelist);
 }
 
-static const struct pt_iommu_driver_ops amd_hw_driver_ops_v1 = {
+const struct pt_iommu_driver_ops amd_hw_driver_ops_v1 = {
 	.get_top_lock = amd_iommu_get_top_lock,
 	.change_top = amd_iommu_change_top,
 };
 
-static const struct iommu_domain_ops amdv1_ops = {
+const struct iommu_domain_ops amdv1_ops = {
 	IOMMU_PT_DOMAIN_OPS(amdv1),
 	.iotlb_sync_map = amd_iommu_iotlb_sync_map,
 	.flush_iotlb_all = amd_iommu_flush_iotlb_all,
@@ -2746,8 +2746,7 @@ static const struct iommu_dirty_ops amdv1_dirty_ops = {
 	.set_dirty_tracking = amd_iommu_set_dirty_tracking,
 };
 
-static struct iommu_domain *amd_iommu_domain_alloc_paging_v1(struct device *dev,
-							     u32 flags)
+struct iommu_domain *amd_iommu_domain_alloc_paging_v1(struct device *dev, u32 flags)
 {
 	struct pt_iommu_amdv1_cfg cfg = {};
 	struct protection_domain *domain;
diff --git a/drivers/iommu/amd/viommu.c b/drivers/iommu/amd/viommu.c
index 9e6eb2f977ec..63360eef6b0d 100644
--- a/drivers/iommu/amd/viommu.c
+++ b/drivers/iommu/amd/viommu.c
@@ -131,6 +131,37 @@ static int __init viommu_vf_vfcntl_init(struct amd_iommu *iommu)
 	return -ENOMEM;
 }
 
+static int viommu_private_space_init(struct amd_iommu *iommu)
+{
+	struct iommu_domain *dom;
+	struct protection_domain *pdom;
+	struct pt_iommu_amdv1_hw_info pt_info;
+
+	/*
+	 * Setup page table root pointer, Guest MMIO and
+	 * Cmdbuf Dirty Status regions.
+	 */
+	dom = amd_iommu_domain_alloc_paging_v1(&iommu->dev->dev, 0);
+	if (!dom) {
+		pr_err("%s: Failed to initialize private space\n", __func__);
+		goto err_out;
+	}
+
+	pdom = to_pdomain(dom);
+	iommu->viommu_pdom = pdom;
+
+	pt_iommu_amdv1_hw_info(&pdom->amdv1, &pt_info);
+	pr_debug("%s: devid=%#x, pte_root=%#llx\n",
+		 __func__, iommu->devid,
+		 (unsigned long long)pt_info.host_pt_root);
+
+	return 0;
+err_out:
+	if (dom)
+		amd_iommu_domain_free(dom);
+	return -ENOMEM;
+}
+
 /*
  * Returns VF MMIO BAR offset for the give guest ID which will be
  * mapped to guest vIOMMU 3rd 4K MMIO address
@@ -160,5 +191,9 @@ int __init amd_viommu_init(struct amd_iommu *iommu)
 
 	amd_viommu_gid_ida_init(iommu);
 
+	ret = viommu_private_space_init(iommu);
+	if (ret)
+		return ret;
+
 	return 0;
 }
-- 
2.34.1

