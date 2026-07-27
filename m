Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011047.outbound.protection.outlook.com [40.93.194.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95CF41A4F0
	for <iommu@lists.linux.dev>; Mon, 27 Jul 2026 13:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785159137; cv=fail; b=nJ4LAhtHmfmWSkpIEJM4vLO3wegIeDKiDFL3PnWvlwutSVLxPTo3o6uIByyAbjwrtB6VPoNcViK6xuThFjBvEN+BiSb7gjbxqPV0z4SK57qfTrYRolEzHNSOs+CupSbkExL3HiHuN0f6fbvs691HoUB3DWEq2487pswtBOjqrnk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785159137; c=relaxed/simple;
	bh=fAJpa+RzempSsCw7QXBRXnkqrtiFgeudnPC85DgdaRk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FodlQv0WNrlyz+Jr5CAiQVaTw5UmYFJ6XQ5hfUnrfrCyMeRhrOzsoed3pPufTiIzoa112SMDoehMZsdxL5LsYxLGkh8rVgAPFspFDT1qNd+4VQftbWZp+ogFgvj3rLS0fUWTfq5i+1dK7Cgjfuzd/OFh4F5YtVc0oZGZ2DI8uIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3tcvqX5q; arc=fail smtp.client-ip=40.93.194.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3tcvqX5q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wMwqIz+QXj+ooCzDVvKGtCnln37ITGbfWQiKY6pN64Fp0T+FuZ958NG11SGCwsQz+/S5GrEFn+EVgMfCi1dA8SKHRjRM1Ij6gyOBI9QsjQncMO0QeOAKe1DWTUUoxrZenDRYwQmAjhY8tqKhoUeQ1go7uBWO57fu1219NLv/d0P6JM/jKzp9vnRe/UOxz73HXpVfVYLeARRd7hWDNvqm/FfPf00EGU5yGjfIp3/aLfll+RWSbJzwSshtgATi6jxE9OO2hq8qTdfiEFWtkadYtpGMoVI7Q+1CO5/Nx1ieAX/NA3JXWTsg8tJNWrGKhmH5DcsK3DyS3/gClt1tUhr1rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fHPQlQEUrpSEAoJD+ixQWbcxz5X55nZqVASQ/GQC5nc=;
 b=mrsDHWcCBVNXV3GzDGxiPpuw7YF5VrlGipf/2JCiQvQpYCn/zU6xBJAO1zaMij8nmvF6pWfICC82dE6ACVacsnXbHbRQjn7iEb9vI0xc2tFjgQZMO1HMiF0sQfED/HvRzfKXqkb6T7tsHuBDH8EoGNdHNYKA9Ky2xgauE5/qcEzWyIO+CBt7mGk2HqUL4zwUVElz0khZtAxkYBj6xiXInQBsTKSPLxNIbzdnUWSn4bbVMVGdT2ZZYD4AbHihHUMPLPtMdocpbtca2RQrrf/FVMHVDHWkov3az6u/MkdkxHEMdqT4Ou5Ytq+cacCOaMilM38Zrtc4IdR8FnSQIi2rKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fHPQlQEUrpSEAoJD+ixQWbcxz5X55nZqVASQ/GQC5nc=;
 b=3tcvqX5q3rCbPPhOjDVZtpeJoO34e9Ln1Sz0zpHuWbnCRZ/4DsjuUoWu1qZGoru69Y0svNoAsT09Q5aXK7WW00pEDwQ1fe3GC/jKFpDX3e5tR0cacDmw2DLsgyxdWSwqYn0XgywiBUJxAQjdEktA1XLVHgfSKCpW8Oa/njIipUE=
Received: from SA1P222CA0188.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c4::16)
 by LV2PR12MB5749.namprd12.prod.outlook.com (2603:10b6:408:17f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 13:30:54 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:806:3c4:cafe::44) by SA1P222CA0188.outlook.office365.com
 (2603:10b6:806:3c4::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.13 via Frontend Transport; Mon,
 27 Jul 2026 13:30:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Mon, 27 Jul 2026 13:30:54 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 27 Jul
 2026 08:30:48 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<Sairaj.K@amd.com>, <jay.chen@amd.com>, <wvw@google.com>, <wnliu@google.com>,
	<dantuluris@google.com>, <chriscli@google.com>, <kpsingh@google.com>,
	<alejandro.j.jimenez@oracle.com>, <joao.m.martins@oracle.com>, "Suravee
 Suthikulpanit" <suravee.suthikulpanit@amd.com>
Subject: [PATCH 09/24] iommu/amd: Introduce and map vIOMMU private IPA region
Date: Mon, 27 Jul 2026 13:28:58 +0000
Message-ID: <20260727132913.22475-10-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|LV2PR12MB5749:EE_
X-MS-Office365-Filtering-Correlation-Id: be214da8-b9ba-4c56-5214-08deebe348f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|1800799024|7416014|376014|82310400026|11063799006|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Qy9Nc9f8/ro1zPj+swkrVeKmMeMlVAsWAcKkcZFxfZtT+14hh3OR58er2EhbEwiiUdwO1VS9bgtC5UWJN6AREQ6kzbdbb1aH6gqyE5Wt3BgDf4ShrfrKr/Li9wOV90gScHrhjDUq0TGE8EXvMV+oQfROaEnbqQ7BzrEIPG0rIdUCDa3gPA8Jq62sgGSr6ZPc6MfD6/PHW98Bm8/COR4XGgkKjSBLPgj/wY+TfUzlc4zm4uF1R4teSu0STX2kgDmzPceWs0egjLFmIqKvA+WvLxBvjQzsKpFvRVzJb+7jZMRnMBrL3lcIm1U2K4tkZzJxPqGI/gFVDkf73GNWqDHfYGREzxesUa9EvAWuy0xI6p4zkFdc/FhtnJH91+k5zhOYXy9gOBIbmNq8YTkQkPE9x2xCuqT2vKyUv55oVYM0xwLNUgPvOS8nHXlJyEnZOhkZ20hk7qhsBpqzK4SoXCJ47NfexVihoRit0qI464+/b63g0hKeDejp7HzdqN4w7F2y0wMXSKqtq7Bqz8VkQkl32gVBPXFuNjikLOBEeKPwztAz3hhpgiroXDfXhOvn83ZKIahh4Rc19uOu4dPFQrbYGCot1kckMmoZQXkZZkK1HShfi/Z5b3D2WW6o133RHIAK7dQyXGjwDFBBKkBKwj6UP/Z4kCTU5U8ehnPr500GwocrD5OtLlAD5A86X9IwDSP/5St6ukydrY9ldBgbUY98aw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(1800799024)(7416014)(376014)(82310400026)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	DAKi8tTZM01kW9c7Bv8Ed8Y0FTqHolcBL5uRLiWvGAq0A8SrDoR9zJFFD1PzLg/IYL/wqgn89aE3L1OEQp+/N+KmhB6zLAEPIOONfMHKbrX2qTjrwj+k3CiKKHHakJhnY/ITR33hN06Wtp+q6Xj3AUH86SriTdEuUvW8WSLMCHXfkf5xv5WTUIo07IkzWQYQdfxs2sB03a4jcww5vow23n096IhX30IrOmQLssuJR0CC9UvMYU1NIrLaNmhO+gwV1v4kdF2CIp2lm1fBFZjUGfHm+FPVwQLquJ0FrUgkr9oRmMje6hchER6qYuu2Ab+XFFXVt8KNdjX9eFtWATLDzREbfz5Nk+WsSdm030zt/fJmbkJ8VXIDmFw8wxFdyQlioNRuk7IaJ5Ed/GGZ3yHfev5SproQ8OWxy0qzUWsc4eXHuCgOx8XYxXeZR5VCYmHF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 13:30:54.6666
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be214da8-b9ba-4c56-5214-08deebe348f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5749

AMD vIOMMU introduces the IOMMU Private Address (IPA) region for
guest-side IOMMU virtualization data structures.

Introduce a per-IOMMU v1 paging domain in viommu_pdom, allocate
8MB of backing memory as four 2MB subregions, map them into the
domain, and add viommu_private_space_init() /
viommu_private_space_uninit() as a matched pair.

Register the owning IOMMU in viommu_pdom->iommu_array via
amd_iommu_pdom_bind_iommu() so map/unmap use the standard
domain_flush_pages_v1() IOTLB invalidation path.

For more info, see section vIOMMU Private Address Space of the
IOMMU specification [1].

[1] https://docs.amd.com/v/u/en-US/48882_3.10_PUB

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h       |   8 ++
 drivers/iommu/amd/amd_iommu_types.h |  11 ++
 drivers/iommu/amd/iommu.c           |  19 +++-
 drivers/iommu/amd/viommu.c          | 159 ++++++++++++++++++++++++++++
 4 files changed, 192 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 2ce207529ea0..dfbc4a75a07f 100644
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
@@ -100,6 +105,9 @@ void amd_iommu_domain_flush_pages(struct protection_domain *domain,
 void amd_iommu_dev_flush_pasid_pages(struct iommu_dev_data *dev_data,
 				     ioasid_t pasid, u64 address, size_t size);
 
+int amd_iommu_pdom_bind_iommu(struct amd_iommu *iommu, struct protection_domain *pdom);
+void amd_iommu_pdom_unbind_iommu(struct amd_iommu *iommu, struct protection_domain *pdom);
+
 #ifdef CONFIG_IRQ_REMAP
 int amd_iommu_create_irq_domain(struct amd_iommu *iommu);
 #else
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 44fa1d6c64d6..a5e2f32590d1 100644
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
@@ -814,6 +821,10 @@ struct amd_iommu {
 
 	struct ida gid_ida;		 /* guest IDs for this IOMMU */
 	bool gid_ida_inited;
+
+	/* HW vIOMMU support */
+	struct protection_domain *viommu_pdom;
+	void *viommu_priv_region[VIOMMU_PRIV_SUBREGION_CNT];
 };
 
 static inline struct amd_iommu *dev_to_amd_iommu(struct device *dev)
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 6f5ecc48f4ad..e5d26d6d4715 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1551,7 +1551,7 @@ static void domain_flush_complete(struct protection_domain *domain)
 		amd_iommu_completion_wait(pdom_iommu_info->iommu);
 }
 
-static int iommu_flush_dte(struct amd_iommu *iommu, u16 devid)
+int iommu_flush_dte(struct amd_iommu *iommu, u16 devid)
 {
 	struct iommu_cmd cmd;
 
@@ -2399,6 +2399,16 @@ static void pdom_detach_iommu(struct amd_iommu *iommu,
 	spin_unlock_irqrestore(&pdom->lock, flags);
 }
 
+int amd_iommu_pdom_bind_iommu(struct amd_iommu *iommu, struct protection_domain *pdom)
+{
+	return pdom_attach_iommu(iommu, pdom);
+}
+
+void amd_iommu_pdom_unbind_iommu(struct amd_iommu *iommu, struct protection_domain *pdom)
+{
+	pdom_detach_iommu(iommu, pdom);
+}
+
 /*
  * If a device is not yet associated with a domain, this function makes the
  * device visible in the domain
@@ -2726,12 +2736,12 @@ static void amd_iommu_iotlb_sync(struct iommu_domain *domain,
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
@@ -2746,8 +2756,7 @@ static const struct iommu_dirty_ops amdv1_dirty_ops = {
 	.set_dirty_tracking = amd_iommu_set_dirty_tracking,
 };
 
-static struct iommu_domain *amd_iommu_domain_alloc_paging_v1(struct device *dev,
-							     u32 flags)
+struct iommu_domain *amd_iommu_domain_alloc_paging_v1(struct device *dev, u32 flags)
 {
 	struct pt_iommu_amdv1_cfg cfg = {};
 	struct protection_domain *domain;
diff --git a/drivers/iommu/amd/viommu.c b/drivers/iommu/amd/viommu.c
index ee8c09f13035..d35125a721ef 100644
--- a/drivers/iommu/amd/viommu.c
+++ b/drivers/iommu/amd/viommu.c
@@ -131,6 +131,161 @@ static int __init viommu_vf_vfcntl_init(struct amd_iommu *iommu)
 	return -ENOMEM;
 }
 
+/*
+ * Allocate backing pages, mark UC, and map at @iova in viommu_pdom.
+ * *@out_va is NULL on any failure.
+ */
+static int viommu_priv_alloc_map(struct amd_iommu *iommu, u64 iova, size_t size,
+				       gfp_t gfp, void **out_va)
+{
+	int ret;
+	void *va;
+	int nid = iommu && iommu->dev ? dev_to_node(&iommu->dev->dev) : NUMA_NO_NODE;
+
+	*out_va = NULL;
+
+	if (!iommu || !iommu->viommu_pdom)
+		return -EINVAL;
+
+	va = iommu_alloc_pages_node_sz(nid, gfp, size);
+	if (!va)
+		return -ENOMEM;
+
+	/*
+	 * IOMMU spec mentions that the vIOMMU backing storage memory
+	 * should be marked as UC.
+	 */
+	ret = set_memory_uc((unsigned long)va, size >> PAGE_SHIFT);
+	if (ret)
+		goto err_free_pages;
+
+	ret = iommu_map(&iommu->viommu_pdom->domain, iova, iommu_virt_to_phys(va), size,
+			IOMMU_READ | IOMMU_WRITE, GFP_KERNEL);
+	if (ret)
+		goto cleanup_mem_attr;
+
+	*out_va = va;
+	return 0;
+
+cleanup_mem_attr:
+	set_memory_wb((unsigned long)va, size >> PAGE_SHIFT);
+err_free_pages:
+	iommu_free_pages(va);
+	return ret;
+}
+
+/*
+ * Unmap @iova, restore WB, and free @cpu_va.
+ */
+static void viommu_priv_unmap_free(struct amd_iommu *iommu, u64 iova, size_t size,
+					 void *cpu_va)
+{
+	size_t unmapped;
+
+	if (!cpu_va)
+		return;
+	if (!iommu || !iommu->viommu_pdom)
+		return;
+
+	unmapped = iommu_unmap(&iommu->viommu_pdom->domain, iova, size);
+	if (unmapped != size)
+		pr_warn("%s: unmapped %#zx of %#lx at %#llx\n", __func__, unmapped, size, iova);
+
+	set_memory_wb((unsigned long)cpu_va, size >> PAGE_SHIFT);
+	iommu_free_pages(cpu_va);
+}
+
+static void *alloc_private_subregion(struct amd_iommu *iommu, u64 base, size_t size)
+{
+	void *region = NULL;
+	int ret;
+
+	ret = viommu_priv_alloc_map(iommu, base, size, GFP_KERNEL | __GFP_ZERO, &region);
+	if (ret)
+		return NULL;
+
+	pr_debug("%s: base=%#llx, size=%#lx, subregion=%#llx(%#llx)\n",
+		 __func__, base, size, (unsigned long long)region, iommu_virt_to_phys(region));
+
+	return region;
+}
+
+static void viommu_private_space_uninit(struct amd_iommu *iommu)
+{
+	int i;
+	u64 base;
+	struct protection_domain *pdom;
+	struct iommu_domain *dom;
+
+	pdom = iommu->viommu_pdom;
+	if (!pdom)
+		return;
+
+	for (i = 0; i < VIOMMU_PRIV_SUBREGION_CNT; i++) {
+		if (!iommu->viommu_priv_region[i])
+			continue;
+		base = VIOMMU_PRIV_REGION_BASE + (i * VIOMMU_PRIV_SUBREGION_SIZE);
+		viommu_priv_unmap_free(iommu, base, VIOMMU_PRIV_SUBREGION_SIZE,
+					     iommu->viommu_priv_region[i]);
+		iommu->viommu_priv_region[i] = NULL;
+	}
+
+	dom = &pdom->domain;
+	amd_iommu_pdom_unbind_iommu(iommu, pdom);
+	amd_iommu_domain_free(dom);
+	iommu->viommu_pdom = NULL;
+}
+static int viommu_private_space_init(struct amd_iommu *iommu)
+{
+	int i, ret;
+	u64 base;
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
+		return -ENOMEM;
+	}
+
+	pdom = to_pdomain(dom);
+	iommu->viommu_pdom = pdom;
+
+	ret = amd_iommu_pdom_bind_iommu(iommu, pdom);
+	if (ret) {
+		amd_iommu_domain_free(dom);
+		iommu->viommu_pdom = NULL;
+		return ret;
+	}
+
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
+	pt_iommu_amdv1_hw_info(&pdom->amdv1, &pt_info);
+	pr_debug("%s: devid=%#x, pte_root=%#llx\n",
+		 __func__, iommu->devid,
+		 (unsigned long long)pt_info.host_pt_root);
+
+	return 0;
+}
+
 /*
  * Returns VF MMIO BAR offset for the give guest ID which will be
  * mapped to guest vIOMMU 3rd 4K MMIO address
@@ -159,5 +314,9 @@ int __init amd_viommu_init(struct amd_iommu *iommu)
 
 	amd_viommu_gid_ida_init(iommu);
 
+	ret = viommu_private_space_init(iommu);
+	if (ret)
+		return ret;
+
 	return 0;
 }
-- 
2.34.1

