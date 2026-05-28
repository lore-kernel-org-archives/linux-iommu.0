Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010018.outbound.protection.outlook.com [52.101.201.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8593C2E4257
	for <iommu@lists.linux.dev>; Thu, 28 May 2026 05:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779945526; cv=fail; b=VpNI48iyGD1cAMEXB67tdhac3v/8gUlXLgTEISLnWp+Mxc83OfJ7ATJORlImJAqarsW/4QGXsVkp2jvwFE42BJj7RoUt9Q6mwIAdy4IVJ0y1SCkVtfOjeceoziocsHJOFZUxAzJ4fyaRFIGGrfsfdhj+73Ww09LjiYGvlzUNgHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779945526; c=relaxed/simple;
	bh=AICmOGOWQW3w+LeUDez7HkxRGJNRLxLWnCYLvC/cmHg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Upcb3mNcHjmFgv/burz76kq7dRFRMxGgcXEfx6eUEIYORy+9QM447vSWN6yghQkq/LjWgTQX1agAGW/a8L8zEN+gHgGyG1INJDlq5qbu8DcnZMlFMmFFWLhszcU1723LIJayUDt3p2/X7gydYPHJJ+eZBgoWkn2Mz5fbWKjCGRI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qup7RkSJ; arc=fail smtp.client-ip=52.101.201.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qup7RkSJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t6Qu9GUUpXxavgMfd6E10PN82bJzcrlAuq/u3ejAjuP3GoBLcPQO4tyYNKMjv3iklKiKn+ZyA4nx/iDX1HLXKOHO8hRl+E56WZv033wcNYsuCO0vceMB6lEMF61z+ycvJ0ak3hIVCFxggOz3Qsq1fvuNZzZmb3I+GiRnDRyAwG2LfMj4TVmZ0W0Y//XnNPqkGVaJP5332oGfd+K9ZnyilOxytfd0lBxo+omB8woGGUYzfNJZ1BzVh9XFmX8UyiRj9/TRQxjMPTaOAKYXHqHMcnGtkmDli0HP/9keOJm8Sm0SA09cg7AwnL3d25fsViLSWbDYXGsXroWsf9CPmecEAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C5tJrYhaQPs3lgGY6anwOUe5aPcfs6He3NDyXP0tRSk=;
 b=WEA9X6EiscUcOqeVF13r37KO+bRntqlzl8JnbHHW4gC4vHVXqvGtuZHaQaxWSrBSX3Q75ziEh66+tIgP+qR9cRwi0Bc5wzLzmCF08F1hkwcyODWC4pryt21Ri1/4YAYId4gU5uo8KZ53xcaGBCGpasjPqlymFHXqRiE1JqrSsVD4KpGOW+1vHn1y8Ob6Qo89GPAWmhmynxx+QIqxWnk8hg3dDSqfe2wpT5trP3mnOW7+pzAfciyCXs/HGUwd0pRRpfsRY1RIrbnt9STNiJWnXxzb+an1C04AbCssYWIaGLMXVkFPYUGL+iFec34mkGs0UUepSSr5rSHXpi56URySIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C5tJrYhaQPs3lgGY6anwOUe5aPcfs6He3NDyXP0tRSk=;
 b=qup7RkSJtV2Jg6lsiw1Hx3I2YyOAxqGkmR6eYO1bnNoG5sOGtDl+A+KAsMi0Tm1zYOP/x1Q9mYu/xcZmQ3qFVYKh16ykfwG880ph38mY2OHWa8Dd+Xdmzn70WYCvGp6DMajZzzTzc3MtG/7wZO4fJ6XUm+bd3sDlCfrbmOjb8L0=
Received: from SN6PR2101CA0006.namprd21.prod.outlook.com
 (2603:10b6:805:106::16) by BY5PR12MB4177.namprd12.prod.outlook.com
 (2603:10b6:a03:201::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 05:18:37 +0000
Received: from SN1PEPF00036F3F.namprd05.prod.outlook.com
 (2603:10b6:805:106:cafe::a4) by SN6PR2101CA0006.outlook.office365.com
 (2603:10b6:805:106::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via Frontend Transport; Thu, 28
 May 2026 05:18:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F3F.mail.protection.outlook.com (10.167.248.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 28 May 2026 05:18:36 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 28 May
 2026 00:18:31 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jay.chen@amd.com>, <wvw@google.com>,
	<wnliu@google.com>, <dantuluris@google.com>, <chriscli@google.com>,
	<kpsingh@google.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <Vasant.Hegde@amd.com>
Subject: [PATCH v2 07/26] iommu/amd: Add support for AMD vIOMMU VF MMIO region
Date: Thu, 28 May 2026 05:17:19 +0000
Message-ID: <20260528051738.596013-8-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3F:EE_|BY5PR12MB4177:EE_
X-MS-Office365-Filtering-Correlation-Id: cba8423f-cb6e-4d16-7a37-08debc789248
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700016|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	jKRn57I1wJwCoFmAcst7wPZ617Voeg+Jk4OKSdx92xMRmgdi+8w4oZK93a5lA4YtXiVn0AQkPBeDX7OTyyV/BVzY7vCY/tOVTUla6TgK9zGlbDnzbxUofIU7BAmsgGitcjikEAG9YGjSpoqn4Dqzr3WM2VYhokqNQO28hncUK2mldosSTm89PV7fhK2EnXsSLJYJQey1ajqBsgKv0T6yUl8qUqAERJBOyEMLtaqTpg1LFktJ+7HKGAnLNQ5mQyD29PqI+Fe6WU4gWjeH5yFcp5UJhTov9fU7lrPlQeG/mMDvi2pmfwCMxy731CXV7lUu9UK/9NQEYSakAQmV4Ned5D4AApGoI50dW/7uSRw6o7m/P97J34fbRPTnX3N9otLvU/psFX2lsq9G9H7bcw2IxPYxXfx4xtaUJRP1N2iE9AumchTOqzcqumXNvlM7HZ8zVnQB3cN61IxxnQ8cA63esJjdao7DgUn32XjFdY/JnxrNVWnvPEBw2uHABBTXb/E70luImKOVM3Y8THIWj5qBPr8M7jZ2nIRI9ABWwVRd4BeRIvi7ggBDvfbA9x+qMyY5JOtWBRapWApeaj9J8El5oGYS5gfxPIZMnDUAkydsA80uJrOOBrFK4u61ZlWQ0HacrR+brjHa9oHy2YwxgKpdY7gfjDs9KKB9uTNrrDEb+CtpldqEFVPnyfoh8nJNTazw0O+Lxshc5z6mv8R04H8bv+OuxD3Twowu0FkgsMnvk1c=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700016)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	L70jSu0d796X8InpPBm3XanIYKMTrgqz1BKL9rFhvx4G+MUxuk9L4zWHifWUgGHcspw3RFGVP0bACc4pIqLIuTJIVojCHvnnBSSk3cUcu+E6ETcaq+FF6DmDFnKKwIBBDGpsM3X9GdkB4WxYfjEn/fDtA+F4j2MZcC/qhOaEO87GyBIHvPNi67yMeoxkdEMa3Rfyiu8QhN5GLJJdNZF7vlqpVDVFEdgBPhf2lB4rExaQPSS4+wVZsozrP3xo1mUKlQccQ/x8qEPMShdLjaLSyPg9TV0uPuZXPFkYJEmaM2+/HTl7kaAYSMp24IVl/ONlEjwZsIyQNaSmiw2Vw0Q45qgAHBSdYHO45itYBdWJiHJYtDdnxl7scjoLERHOXojeeA0sufUpFqGhYRjiTZQ/faoX9118XZ+8xLjIWKBuvirqaqG8mUe2Vcf/wgS+VTZq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 05:18:36.8852
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cba8423f-cb6e-4d16-7a37-08debc789248
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4177

The AMD vIOMMU virtualizes guest MMIO registers at the 3rd 4K region.
This is achieved using the iommufd_viommu_alloc_mmap().

Co-developed-by: Vasant Hegde <Vasant.Hegde@amd.com>
Signed-off-by: Vasant Hegde <Vasant.Hegde@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  3 +++
 drivers/iommu/amd/amd_viommu.h      |  7 +++++++
 drivers/iommu/amd/iommufd.c         | 18 +++++++++++++++++-
 drivers/iommu/amd/viommu.c          | 11 +++++++++++
 include/uapi/linux/iommufd.h        |  2 ++
 5 files changed, 40 insertions(+), 1 deletion(-)

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
index 785fa2d575f2..34524c1309c3 100644
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
 	struct iommu_viommu_amd data;
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
+					(unsigned long *)&data.out_vfmmio_mmap_offset);
+	if (ret)
+		goto err_mmap;
+
+	aviommu->vfmmio_mmap_offset = data.out_vfmmio_mmap_offset;
+
 	ret = iommu_copy_struct_to_user(user_data, &data,
 					IOMMU_VIOMMU_TYPE_AMD,
 					reserved);
@@ -82,6 +94,8 @@ int amd_iommufd_viommu_init(struct iommufd_viommu *viommu, struct iommu_domain *
 
 	return 0;
 err_init:
+	iommufd_viommu_destroy_mmap(&aviommu->core, aviommu->vfmmio_mmap_offset);
+err_mmap:
 	amd_iommu_gid_free(iommu, aviommu->gid);
 err_gid:
 	return ret;
@@ -100,6 +114,8 @@ static void amd_iommufd_viommu_destroy(struct iommufd_viommu *viommu)
 	list_del(&aviommu->pdom_list);
 	spin_unlock_irqrestore(&pdom->lock, flags);
 	xa_destroy(&aviommu->gdomid_array);
+	if (aviommu->vfmmio_mmap_offset)
+		iommufd_viommu_destroy_mmap(&aviommu->core, aviommu->vfmmio_mmap_offset);
 	amd_iommu_gid_free(iommu, aviommu->gid);
 }
 
diff --git a/drivers/iommu/amd/viommu.c b/drivers/iommu/amd/viommu.c
index 014ae16bf58b..9e6eb2f977ec 100644
--- a/drivers/iommu/amd/viommu.c
+++ b/drivers/iommu/amd/viommu.c
@@ -131,6 +131,17 @@ static int __init viommu_vf_vfcntl_init(struct amd_iommu *iommu)
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
+EXPORT_SYMBOL(amd_viommu_get_vfmmio_addr);
+
 int __init amd_viommu_init(struct amd_iommu *iommu)
 {
 	int ret;
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 83ed10610957..0b7a3e5b057c 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -1084,9 +1084,11 @@ struct iommu_viommu_tegra241_cmdqv {
 
 /**
  * struct iommu_viommu_amd - AMD vIOMMU Interface (IOMMU_VIOMMU_TYPE_AMD)
+ * @out_vfmmio_mmap_offset: (out) mmap offset for vIOMMU VF-MMIO
  * @reserved: Must be zero
  */
 struct iommu_viommu_amd {
+	__aligned_u64 out_vfmmio_mmap_offset;
 	__u32 reserved; /* must be last */
 };
 
-- 
2.34.1

