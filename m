Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011043.outbound.protection.outlook.com [52.101.62.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EFC43C04D
	for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 15:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782747719; cv=fail; b=s70qBNK6wm8NngOO17er+/j71BbiePudSwu4BQtFoINqkWkYUppscf/+6pPhqN1CPLGuk6ceGbG+1MGDyjWdItMyDQL9wgSFDXwRQMkREtY2gB45pI41IgV560vHT13PibrS3dogLq+0qilKZHhaMpAMqotWFQJFixqs17V6LkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782747719; c=relaxed/simple;
	bh=sjfn1jcu02YaHTg4PRvkIBpabPFc0q+/9g+FqEAOiEY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H8LRdtxQ35l7xRW1nqWMyDi4zm4DmyyvOTcBAvXv+Q0S3hUHT4GuufF15iQJQUZl0gUnIZoVPvA6h4VN2MoQ7i5l4LWlFjwz8epRKgFtV1v5LNXxvrQ+Jk3dLrB/2hWshs1hM1Ni3FKoyqqOg+S6ERgJ9VUgBlpq2qUionbOCrU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=28D3E91R; arc=fail smtp.client-ip=52.101.62.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="28D3E91R"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EyLt5vN7Ik9rqZbP6vCXDe8CHiNUQfspp3Ts0k0aq6LxIFFLNogSgGmBQgzIlVXYqwNvhQU6Z5tRJ3OOoqiDbhytjqxlEcKiwIQaYXE1U13n0o6SNQGqqMbiPE+RXqBJVfxu8o3GdY/dOaVQ2I1rTXz8F7ZSb4Nt3xoVA/Qd5n+50PPaLKjyYzRzYVEkxQQTjSYHwjtWtPLKzSdJNcv7pmogRzv/FqfrPf+M27hsJJlfa2bSV8dTpr5y21YPCCokntzKVlN9ikGMcL2Fg+hLPTPjHiYT1ed5iP5imP+GEjan5vGEZ4XxPNNn5ulIg9chX9gI1skilFW3CYwojojUZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8LMJoYktADuOPpa0QN3GVtC0PCN7AzB0WY1LdARyLPk=;
 b=mZOxmPjc+fKD4yodwqS40a9as6bJKbFioIZKXomAiuitd7JUu42HEiClR8FmnZxXl3Wax4F0mqFCgQC55m8bhRpAfHPyras0WbibLTn8AFWlJLgn2Xit58Vlfn/NaHz0PCVNZluL+fjCm31nSjos0iV/0l/g0xDZhjXE+/KwGI0cYXga6TAgDpPbNYj8nicbB3OJXA3hnd2RbUcJOute1PzHEbYoYmWqyffTqJn7OOTia6NII6Fy1iaI7zz7Ng6+42dC7gLSf4f/DHEGf9Cgred6iEobRH4cwPuftJ5UFifpytzZrjjYKSgQhWGQvuTYd+q/MMLA5VeKaIwCxfNyJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8LMJoYktADuOPpa0QN3GVtC0PCN7AzB0WY1LdARyLPk=;
 b=28D3E91R99be9U3OPWzvjrG3yMWcCJSIRCKOXeHvLGrseHXCieKSVsyjHgNzNd22Q75/ct0imAeFeJi+OWrmITitRXdjTVWNaiFG4phSfszpIk8IOvtQiPUUCx46mdwnZi/S/nzae/ZMRrB/J16JvjNh4gpbQc1TQrvOry3p1wE=
Received: from SJ2P220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5da::18)
 by CH0PR12MB8464.namprd12.prod.outlook.com (2603:10b6:610:184::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 15:41:49 +0000
Received: from SJ1PEPF000026C9.namprd04.prod.outlook.com
 (2603:10b6:a03:5da:cafe::91) by SJ2P220CA0008.outlook.office365.com
 (2603:10b6:a03:5da::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Mon,
 29 Jun 2026 15:41:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C9.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 29 Jun 2026 15:41:48 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 10:41:33 -0500
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 08:36:25 -0700
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jay.chen@amd.com>, <wvw@google.com>,
	<wnliu@google.com>, <dantuluris@google.com>, <chriscli@google.com>,
	<kpsingh@google.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <Vasant.Hegde@amd.com>
Subject: [PATCH v3 07/22] iommu/amd: Add support for AMD vIOMMU VF MMIO region
Date: Mon, 29 Jun 2026 15:35:20 +0000
Message-ID: <20260629153535.15775-8-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C9:EE_|CH0PR12MB8464:EE_
X-MS-Office365-Filtering-Correlation-Id: 52d83657-e47d-4e15-db06-08ded5f4eeb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|7416014|23010399003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	R+EIyL63VIX7EbO0ggjxQYYVTmGmv7D4+jyhSIE4Bcu9ZjftkdsZEQUBRQwjPdAXfpBq3ZWGS144uSwU9OxEVhViDsQX3GpJ5R+sT+/NacBY42JwkAYQFfptvX37v14iyN6XreySM1BMu0utwuFomlbTg+0QU6aa57WV2UItTC5SmNlKFQDp0VsSjhS0DJehSXK1+EQ3YPSZLMGe92pRjDUpm+K6sFClDXe0tyq1UnVOhvcyPrkZjPuOBv0l3cAtd2qkdqXvF8FqSryqMbQmucHDnJ172txAiMS4i1qXiedaoP3h6/aL4tm+GDRxvRYM/KTbeCjLvx0eMyhKXHh4mqa8lmNMIMBhDzGKXypYfkT2wWNFACaNak1ME0PIKnGJmaOiB63dvxDeVmwQtpC8gkIGFMCaFfvlONGZUPZogVyKFqfzkOaOvwDBR+v+zlV4IZ8JmLYTCCj9LRQ9MSyyd/Ft4zM98PBFdhlbMEJ/uLHOXUxSeUC8AP3f8jUyh+polQ/ak/f2Iwlu9G8612RWV+Um7ssHRXZy259YGS/sJXmv8WEIsc8UptA/qcOV40r2ahsXlX2wgpbbHulniR4FmyEhnmpMJ8LYf6+/rcHoodW5v/3XHaObwporfjDZqj2cXpqOMbpM8HfRj1pjJlEeGeOxevexiDlg5w9OKkkYFw7fQqvSk8EAL/Ra7G+NxRq8fuYYXXZarBYUjbx+QJ3BFg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(7416014)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3r8TKsK5FMQLdDpdfJRmV5FcHbdyXAOHATdKdKodaMJPXOsPBxXFB2nFI+0FzQryo7D3VhtF/s6dEegbixsCc1TvZleNNeMu+iZIQfpta4uUs3z4xxLdcp8lzyx0sUUobScx+lzbmJFvP/u+tcD2PdqHLS034hQvVbubshvtB3/z6PIi/z8cH/mv28c8QgtHstPvQ8nhIIzJsF54sIuuqQELQSr5+6WibASWu90dai9Od94FswqsTx8vNLZCU40h55+gevUvLli+VgK7eM7E6zzUb6SgDlGpuyBdREk93JY4JPxCmxosxwj5Xaa4dRLNpRH6xTo+fFt9bLNzEYNAMS8+AudMRAzlA+t+6wmsERT2NJUeeb/L7UooeYwCz1EmuozhJZD3KFxDGwDfJ9kXWCzbGb2UIb5YWpD5BoyDsxp3LmUImbncOe1jrpc8FcJ4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 15:41:48.5337
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52d83657-e47d-4e15-db06-08ded5f4eeb2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8464

The AMD vIOMMU virtualizes guest MMIO registers at the 3rd 4K region.
This is achieved using the iommufd_viommu_alloc_mmap().

Co-developed-by: Vasant Hegde <Vasant.Hegde@amd.com>
Signed-off-by: Vasant Hegde <Vasant.Hegde@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  3 +++
 drivers/iommu/amd/amd_viommu.h      |  7 +++++++
 drivers/iommu/amd/iommufd.c         | 17 ++++++++++++++++-
 drivers/iommu/amd/viommu.c          | 11 +++++++++++
 4 files changed, 37 insertions(+), 1 deletion(-)

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
-- 
2.34.1

