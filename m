Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011000.outbound.protection.outlook.com [40.107.208.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70653340409
	for <iommu@lists.linux.dev>; Mon, 27 Jul 2026 13:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785159051; cv=fail; b=ca64XnTA3RE+QiamkQjw4KVMSqSNKhsgdpA0oR2l58ZODbVEio2IDW7/Y3rb19esRarxW3awoOT/xugIwkdJNFcv7PjOavzevsgEPPiC3x4xzr0Kq4yyY7oFunHn13VhX2KFN6Zv1xVurLIF9bwHa5l/3u+bJYSFwOv8ZHE9uwc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785159051; c=relaxed/simple;
	bh=tfvnafvRf9sDrprdlKDMHNwka7POr5VDgR1kmvcC72k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z0TYQdkdYdqbODhMqoH+hAg+tRrlDm+haPST2OkhE8pDQ/KA9zNJvzArJ2ttI10V0jSGh3LOLmfEpmwCcnZWYT2UeksFqguLFORohhqtfsV8XYBi9DhY4fFiqLL8aOZ4Kg2eALBfrkV6xb7q9Y32+LW1+XD7yyA1c/dKJbcollI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AqnX/SH9; arc=fail smtp.client-ip=40.107.208.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AqnX/SH9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gpo+ioP6NLXRyFuY4xkW9rpuT13v7oZPcp9QJ4dA7Yy1fF6aDD8lnHI1iWXu1rl8/iD93XIEvNmuCJgDXI90gUh3iZCTmN8EBLXkKt/RxPdP887yodKvNw8drdUbxC8tqQc0AOefuoFtF1THLQRSp0eRxEbfqsBX6qaazv53RxeVAeUbd0sxGD5SqngG3cf0zSlrfPTwzZUzay/8eSrlEAxODcTW0l06w6MoQbKiEGIdj3CYDZC5/JPYDcN9BXgJe6JEqLMkyx2birNPDpNwa0/4T0fW+1Q3OMcvFDUTPlKugQtEhRoDSPuAvtK6Drk1PLpPGZQChlJ9yLtDnEPUrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fdrImW39cIOVEmUyWyn2qTC+XA9GlB+RHhUiV2kr1pw=;
 b=hkaLn6SQapL8onBcydCg1E5GEZIkMVwNSVZO/tqH8p3vTbaTHLNCtwDDHuoNjeLT6cIf6YMY3/lEs+jdo7JliNCVsLIG7LmSJ53D28zlAHfInv+zwdU+roi5gZSp4C9NI3BexVqpiUHq5dKg3+bWjgCQzgeJOa/CasfYaLKL6gCNaKdg6oVxTgFqFkmX4d8tlVpYrW8CQNJ1XCrtcfnN54jnzvT14gNZS7EoOTU04Clcs6p6ioia+G/KAYgvjOd7/ufgaJoRyehvxEex+EOxEopdfGNELi2mzxNqFshk0ZckAtMtP/ZqJ5K67kP/ty5pvrS/bNBII9u/CF5o4kOrvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fdrImW39cIOVEmUyWyn2qTC+XA9GlB+RHhUiV2kr1pw=;
 b=AqnX/SH97qbg0wOWN80T39GbpAU6PAMuDX467zfWSxOo7UeQEgCPEpOOgZM4+9s1Y1BxgNtU3R8yNPHi43/7lmR04SDjmlHITEXRMlIx6x7b4+tex/nL+89S3wwuIHdvKMGyl2E0NuICXalA/2RilRgUB2NhxqT12lp6CHoX3ic=
Received: from SN7PR04CA0195.namprd04.prod.outlook.com (2603:10b6:806:126::20)
 by SJ2PR12MB8847.namprd12.prod.outlook.com (2603:10b6:a03:546::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 13:30:43 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:806:126:cafe::81) by SN7PR04CA0195.outlook.office365.com
 (2603:10b6:806:126::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.13 via Frontend Transport; Mon,
 27 Jul 2026 13:30:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Mon, 27 Jul 2026 13:30:43 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 27 Jul
 2026 08:30:37 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<Sairaj.K@amd.com>, <jay.chen@amd.com>, <wvw@google.com>, <wnliu@google.com>,
	<dantuluris@google.com>, <chriscli@google.com>, <kpsingh@google.com>,
	<alejandro.j.jimenez@oracle.com>, <joao.m.martins@oracle.com>, "Suravee
 Suthikulpanit" <suravee.suthikulpanit@amd.com>, Vasant Hegde
	<Vasant.Hegde@amd.com>
Subject: [PATCH 07/24] iommu/amd: Add support for AMD vIOMMU VF MMIO region
Date: Mon, 27 Jul 2026 13:28:56 +0000
Message-ID: <20260727132913.22475-8-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|SJ2PR12MB8847:EE_
X-MS-Office365-Filtering-Correlation-Id: c66d2a51-c1cb-40e9-5932-08deebe34255
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|376014|1800799024|36860700016|23010399003|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	xuMz95czsFh7MAePl7YSZ6TIB1yPYpU19td3U4opb4I0eDfo82iVTeNYlLCQBiCeNdCyxVfg0Hm3y7gbz8Iw4n56WVRwu61vnKhyRDWMB0AJRQOnWw6mFWYgRAEjfeslddV43k3ObBcHE4cEnS4lQdDVf+pLBU6kNBAywqCEgsV5iNGZ9xMZYhvSLAbESTvgOc3ugaPG8thiVZYKvSLEpj2JdwfM1xqNI2kDscp0tAchtObyYxnSF6w1vYRRHXNgTfLDtHL8cZpe2jo3eTkH+dNsJD67n/35/y4ha5arBuUshkH/0gfj8QYy459t/bRzH2HkFZFSaVeMMd0kunYDGIhO4zQ4WElb8ffyGV7DqxqUJvYuQu7bze6VGISBL/Dw0G5qbQNxHYRUUaUs1dti+DeKgljp2s3284rfFLg3QkwFhmnVW0wglbfaU3VuREsw3k/OOuRncKh7VnYZU1B2ejXd1vCEMK9TEyu/Uawn4hnmgc9hCZu7KAPFtLRZFjKL7EHwxzTMhO6mOgAB0/YUx/MIGiIJr5LASHSYkMijZywyYLhVC7rdrUO7ye7QcZ85srG2qeckjREpg+UEkQoXm/56E6wd3EKah4RRo84jl1Aq/XtmS2dW9aAkyDAUQmnB5byR1FfoCW4ru6zTfCYzDSOkUbnC2LgEcsVk7x8IeAv2T4fnPET0ClOtk09fzpI/EWHSF3T/aTqmVfNp30KB5Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(376014)(1800799024)(36860700016)(23010399003)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	di9BGZR518e5CWFSfdqUbLJDO3a4aJK+LSs5/z+eJsDgV/BITZpAANA0Hk+xU92StYhinHRvaNt1Qd7+kILliuF3FQrGQt63THojtHnBgYnrdHfDIU7FQdj+6/t6Clt3+6O7BSQIDLw1n6wa7Xmb2kfdh0+GMSxrLBUvZEwehU6dxvcZJ7y/yhhALR3hVfMvkQp45bvhgDzi9aOo2y2TwxWXsy/Y0nAl/tdx99fyBdlIqgY1Lw0g6cRrmjejWUoGUrRCwYRtWmKQJ/McU8Kz5r5sukW7O0kqEcm3sIJMZfHDW+YHECTO3LgKSNRAKYEit5x3BzPqvOdKRmjVMx8UUF7d3jt08GRK9KzL7vYhhHx8woxahJk/uncWKf15IbnTcre6xQUffVdBPozQjma4PdJbTMCNKhnsQ9YO7Gmd8q2TAsWhREf532+aLP3P4+5P
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 13:30:43.5550
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c66d2a51-c1cb-40e9-5932-08deebe34255
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8847

The AMD vIOMMU virtualizes guest MMIO registers at the 3rd 4K region.
This is achieved using the iommufd_viommu_alloc_mmap().

Co-developed-by: Vasant Hegde <Vasant.Hegde@amd.com>
Signed-off-by: Vasant Hegde <Vasant.Hegde@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  3 +++
 drivers/iommu/amd/amd_viommu.h      |  7 +++++++
 drivers/iommu/amd/iommufd.c         | 17 ++++++++++++++++-
 drivers/iommu/amd/viommu.c          | 10 ++++++++++
 4 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index e88e0bacd1a9..cc7049bbfa14 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -540,6 +540,9 @@ struct amd_iommu_viommu {
 	 * Indexed by guest domain ID.
 	 */
 	struct xarray gdomid_array;
+
+	/* Offset for mmap() of guest VF MMIO; set after iommufd_viommu_alloc_mmap(). */
+	unsigned long vfmmio_mmap_offset;
 };
 
 /*
diff --git a/drivers/iommu/amd/amd_viommu.h b/drivers/iommu/amd/amd_viommu.h
index d0c4fdd00809..447692b9101c 100644
--- a/drivers/iommu/amd/amd_viommu.h
+++ b/drivers/iommu/amd/amd_viommu.h
@@ -12,6 +12,8 @@ int amd_viommu_init(struct amd_iommu *iommu);
 
 void __init amd_viommu_uninit(struct amd_iommu *iommu);
 
+u64 amd_viommu_get_vfmmio_addr(struct amd_iommu *iommu, u16 gid);
+
 #else
 
 static inline int amd_viommu_init(struct amd_iommu *iommu)
@@ -23,6 +25,11 @@ static inline void amd_viommu_uninit(struct amd_iommu *iommu)
 {
 }
 
+static inline u64 amd_viommu_get_vfmmio_addr(struct amd_iommu *iommu, u16 gid)
+{
+	return 0;
+}
+
 #endif /* CONFIG_AMD_IOMMU_IOMMUFD */
 
 #endif /* AMD_VIOMMU_H */
diff --git a/drivers/iommu/amd/iommufd.c b/drivers/iommu/amd/iommufd.c
index ec3c14e18c7b..9f76bfa1d6ea 100644
--- a/drivers/iommu/amd/iommufd.c
+++ b/drivers/iommu/amd/iommufd.c
@@ -7,6 +7,7 @@
 
 #include "iommufd.h"
 #include "amd_iommu.h"
+#include "amd_viommu.h"
 #include "amd_iommu_types.h"
 
 static const struct iommufd_viommu_ops amd_viommu_ops;
@@ -44,11 +45,12 @@ int amd_iommufd_viommu_init(struct iommufd_viommu *viommu, struct iommu_domain *
 			    const struct iommu_user_data *user_data)
 {
 	int ret;
+	phys_addr_t page_base;
 	unsigned long flags;
 	struct iommu_viommu_amd data = {};
 	struct protection_domain *pdom = to_pdomain(parent);
-	struct amd_iommu_viommu *aviommu = container_of(viommu, struct amd_iommu_viommu, core);
 	struct amd_iommu *iommu = container_of(viommu->iommu_dev, struct amd_iommu, iommu);
+	struct amd_iommu_viommu *aviommu = container_of(viommu, struct amd_iommu_viommu, core);
 
 	xa_init_flags(&aviommu->gdomid_array, XA_FLAGS_ALLOC1);
 	aviommu->parent = pdom;
@@ -68,6 +70,16 @@ int amd_iommufd_viommu_init(struct iommufd_viommu *viommu, struct iommu_domain *
 	aviommu->gid = ret;
 	pr_debug("%s: gid=%#x", __func__, aviommu->gid);
 
+	page_base = amd_viommu_get_vfmmio_addr(iommu, aviommu->gid);
+
+	ret = iommufd_viommu_alloc_mmap(&aviommu->core,
+					page_base, SZ_4K,
+					&aviommu->vfmmio_mmap_offset);
+	if (ret)
+		goto err_mmap;
+
+	data.out_vfmmio_mmap_offset = aviommu->vfmmio_mmap_offset;
+
 	ret = iommu_copy_struct_to_user(user_data, &data,
 					IOMMU_VIOMMU_TYPE_AMD,
 					out_vfmmio_mmap_offset);
@@ -82,6 +94,8 @@ int amd_iommufd_viommu_init(struct iommufd_viommu *viommu, struct iommu_domain *
 
 	return 0;
 err_init:
+	iommufd_viommu_destroy_mmap(&aviommu->core, aviommu->vfmmio_mmap_offset);
+err_mmap:
 	amd_iommu_gid_free(iommu, aviommu->gid);
 err_gid:
 	return ret;
@@ -100,6 +114,7 @@ static void amd_iommufd_viommu_destroy(struct iommufd_viommu *viommu)
 	list_del(&aviommu->pdom_list);
 	spin_unlock_irqrestore(&pdom->lock, flags);
 	xa_destroy(&aviommu->gdomid_array);
+	iommufd_viommu_destroy_mmap(&aviommu->core, aviommu->vfmmio_mmap_offset);
 	amd_iommu_gid_free(iommu, aviommu->gid);
 }
 
diff --git a/drivers/iommu/amd/viommu.c b/drivers/iommu/amd/viommu.c
index 014ae16bf58b..ee8c09f13035 100644
--- a/drivers/iommu/amd/viommu.c
+++ b/drivers/iommu/amd/viommu.c
@@ -131,6 +131,16 @@ static int __init viommu_vf_vfcntl_init(struct amd_iommu *iommu)
 	return -ENOMEM;
 }
 
+/*
+ * Returns VF MMIO BAR offset for the give guest ID which will be
+ * mapped to guest vIOMMU 3rd 4K MMIO address
+ */
+u64 amd_viommu_get_vfmmio_addr(struct amd_iommu *iommu, u16 gid)
+{
+	/* TODO: Add check for sVIOMMU and set gid[bit 15] */
+	return iommu->vf_base_phys + gid * VIOMMU_VF_MMIO_ENTRY_SIZE;
+}
+
 int __init amd_viommu_init(struct amd_iommu *iommu)
 {
 	int ret;
-- 
2.34.1

