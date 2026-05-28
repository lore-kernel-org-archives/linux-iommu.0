Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011027.outbound.protection.outlook.com [52.101.52.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7685331716E
	for <iommu@lists.linux.dev>; Thu, 28 May 2026 05:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779945570; cv=fail; b=Sa1a05NIH9b4zbd6p4TUZhpCixZYsHgS6o0kis147m3RqDfh7FjU1dlzs8PLhZD0WbN8IfqQ1MYju50YYywFicacV02f7HAkhitegkaAV+vvtlnSa3kVtB75LITJWaHjsCoEaDjU0IurC95LxfxIe9aWe84Gud0yQYSZNZ18y5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779945570; c=relaxed/simple;
	bh=xZcRY8nknHRyQ8jR73yciPqIYBtft7gVPGk5MMp/xzI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kRiutO32F+zHldJysqyXwGobeD/Lp7RA76cA8cfmGl+PAEFEIL2yZYGQ4bhrcwjMuEpmPGGBBUbiFGGeBtmD9PX9RWw7NOSn4Lm6kNEo+3kmPrl13lpp3Y4aeewKBmCHAuSe7yrnX6ffNjleuM467Jow6hqzlonOmPVKBd1ANrA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=f7rQjCPo; arc=fail smtp.client-ip=52.101.52.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="f7rQjCPo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k2qkfv/G2/pW709vkLz3yJtOmbgm1UN2iGU0dATK/1JZwH9/XDlv2PEEiSLgG4dHajF3Hbus9cYjLCXCsVgb+qZM3w4Af+HElG+NEVDM49xsWX4Wi6wfZQ6vr6UYPjA6XqYh6aKEKribN9XRVxCARBa3yoUc/X6gCNdJPhyfFWmXMCHKtOU/5HebwZRktLFhz7Ct4uwKHGnSaWHfgECt8AAxE59cCNWwXnwPciJdOjbe4fwGeE45Z9NZWG3bLb51Cg1mss9Jlc889/yiCTL0dPiCCkoH0H5Hbtw7xccQBr1jbwhm+kT7CoG5QniA5DlWcBqO4/X9PMQ1/gMQqgsIPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=liUs//QCuBPnucrw5CaCgDgeIefNCbpXhRv3NtHnkv4=;
 b=uAsFkJwPw5uFIRkGEXcvQGhu4oWatjQFVoA7/TbYb3GXf4GMe9lchCE9/XDZ0hHPc6sbq5k1PAF0yAjzUESmpsXSShBHbZPglZ61L/TvOd88B6PmlzJVe0yQWRyVFgaAN/0uPj67OoSKNryPT5V+/0sF3c5lXJJxb1azfphVCW7IKHOKs4Kswc6A99XwUSxpNgsahFQ22tHu3rklfvFhLkVkbsbGXmu5+95y6zRMKf7mSsfPdiPZ2jsCsa6Uhg5vfwOT+OQjvMwmHgAO3DcGqWT6+pLE91x0k1WXJcIkWvLiSimapItXnkjBG0COPxX1I5Z8Bvka3DBRzhe+c6pNtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=liUs//QCuBPnucrw5CaCgDgeIefNCbpXhRv3NtHnkv4=;
 b=f7rQjCPoxwDRfFmPOwk8GfdvcDKnstCxKzltJTFRmp0QTKvUCRNEiwfydOzNmRQZYIu8dEIBUKGQglnn2CfUohccizlDTIj5xWcWwpvYaUE/UePVJv2TY6jmeEI+/4oniwJb3Ta3Fs65HWSP3/Yi27q5wsHVBUDD+Wv/6bQCdNU=
Received: from SN6PR2101CA0005.namprd21.prod.outlook.com
 (2603:10b6:805:106::15) by SA0PR12MB4397.namprd12.prod.outlook.com
 (2603:10b6:806:93::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Thu, 28 May
 2026 05:19:24 +0000
Received: from SN1PEPF00036F3D.namprd05.prod.outlook.com
 (2603:10b6:805:106:cafe::5a) by SN6PR2101CA0005.outlook.office365.com
 (2603:10b6:805:106::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.4 via Frontend Transport; Thu, 28
 May 2026 05:19:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F3D.mail.protection.outlook.com (10.167.248.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 28 May 2026 05:19:24 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 28 May
 2026 00:19:19 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jay.chen@amd.com>, <wvw@google.com>,
	<wnliu@google.com>, <dantuluris@google.com>, <chriscli@google.com>,
	<kpsingh@google.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v2 17/26] iommu/amd: Pass KVM FD from userspace when initializing vIOMMU
Date: Thu, 28 May 2026 05:17:29 +0000
Message-ID: <20260528051738.596013-18-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3D:EE_|SA0PR12MB4397:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d1b150c-b19f-48de-9b1b-08debc78aeab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|7416014|82310400026|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	H7B143QqUhuw1OZAQOv8P/cx29YQ5xrwKBrFlQHI77KD91ZHumS1luO5v6C6+Rvydp0tGCWmnk1md/mhLWLBE9s/VqHYFg5lgIkQRMHZr5bVzvyQvU/xB7yH35VDkXSJEgekAQI8itp98QYBVoXKeUKRbeWSZH2DYC8Qxri8OBc+WACFUu/MEarTpMg7SyYJIENCkVrJhLG2xGrpAOADXt/DvgLCy4/Da+liM0r0zNdnozhkOoh3yq39fJbuJFfG8QXYc49XJe+Ssr9iymxSUNQ3ZLf9w1/WMkwEogKFdNR63wwzRnKT9KzVcghhFsGUupSiWXP+1tn0FUP+iWQMrssE0d/Jbq9J6U3kgiyAdiWCHaEMtaIUHuQ1o2UfUCjkB1EhqWVHDsYEn12Z75Awi0NybgfIFqPJEIn3iDWrl00XRXbgK2BrvhaGipXB/C2rWp4p6+xEB5MC5FIHLXJgYDFqTKxwvZ22lq+DHyfolBZN78iZnMBziL2BD0uxfSPvpezykRbLVQ2XlcThxH0mNLyFxGnuYbSAvHZdZ+a7oFZM/IdXMeqk9nAyAzd8DcFzWQIBzkI9kiMIQy/FgEpMC3pYWeJcFy5owPKhcvze/tKrOacvt9jC+wBpMrw1vBRH0TWmfShVjs0W8bgjkyUkZZsbkVlnAn3GE85o3xpQjKfNPhCHLv9OdOnBo0mZA3U6C8TLGgP9KXQ00dIasABD1wiWkaXJKGWidJXyPM5gXgM=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(7416014)(82310400026)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	w+vEQPgJUOXj3dbinGxl6fVYwpFS3jQRaaW88PQSmDqoAw7xcuiDqMGcwehXHmnBc6Z4oYtrMjN5oboiKTmObJoOo7tJPeT45D6Pg7F3NuEH7DXlFi6g4wD/kRHlurMv7c3zaJgqYSPjrzGOl2Y0MoIuDD1Nzz5HIZHfUcX1YopGc2bz93vY7XuEeTMCeK0DhIxPvY84ICIyxAFxbWC3KaIVtXvmIhmP1jqu45yucVsJ1imJZlYbS3qhni5iqOQjAlezekeqbdq1rX0NoH1Shl/S3yIVrbD/dAK5bBK1g7hk5L8v4j10GcV9yzgre1LJu9RQKP5jS63BDYSptKuBL7ABx0Ls0RNyjAQaUE5h3MFV6EhOP6kx9TObj7lOyTEd2ugYEs8e4qNbFwbmOajK9oud2Y+iAfceHdTpb++ylqnTtA4kB/6FVrFvs+Yu2icO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 05:19:24.5378
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d1b150c-b19f-48de-9b1b-08debc78aeab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4397

AMD HW-vIOMMU feature requires IOMMU driver to keep track of each guest.
This information is used by AMD IOMMU driver to manage the following:

* GID: Each  guest is assigned a unique 16-bit Guest ID (GID), which is
used to index into various data structures for configuring the hardware.

* Translation-devid: Each guest has one GPA->SPA mapping, which requires
one trans_devid to program the v1 page table in the DTE[trans_devid].

* Extended interrupt remapping: The AMD HW-vIOMMU uses AVIC to implement
extended interrupt remapping to virtualize Event/PPR log interrupts.
A KVM reference is neeed to get the AVIC vm_id.

The KVM FD can be used for these purposes.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  2 ++
 drivers/iommu/amd/iommufd.c         | 27 ++++++++++++++++++++++++++-
 include/uapi/linux/iommufd.h        |  2 ++
 3 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 836d5cd08134..e9b49f0b9051 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -547,6 +547,8 @@ struct amd_iommu_viommu {
 	struct protection_domain *parent; /* nest parent domain for this viommu */
 	struct list_head pdom_list;	  /* For protection_domain->viommu_list */
 	u16 gid;			  /* Guest ID for the vIOMMU */
+	u32 kvmfd;			  /* KVM fd from VMM */
+	void *kvm;			  /* Hold struct kvm pointer */
 
 	/*
 	 * Per-vIOMMU guest domain ID to host domain ID mapping.
diff --git a/drivers/iommu/amd/iommufd.c b/drivers/iommu/amd/iommufd.c
index 6020f2caf445..7c7ef267088b 100644
--- a/drivers/iommu/amd/iommufd.c
+++ b/drivers/iommu/amd/iommufd.c
@@ -4,6 +4,8 @@
  */
 
 #include <linux/iommu.h>
+#include <linux/file.h>
+#include <linux/amd-iommu.h>
 
 #include "iommufd.h"
 #include "amd_iommu.h"
@@ -42,13 +44,27 @@ size_t amd_iommufd_get_viommu_size(struct device *dev, enum iommu_viommu_type vi
 	return VIOMMU_STRUCT_SIZE(struct amd_iommu_viommu, core);
 }
 
+static void *get_kvm_handler(u32 kvmfd)
+{
+	struct fd f;
+
+	f = fdget(kvmfd);
+
+	if (fd_empty(f)) {
+		pr_warn("%s: fdget failed\n", __func__);
+		return NULL;
+	}
+
+	return fd_file(f)->private_data;
+}
+
 int amd_iommufd_viommu_init(struct iommufd_viommu *viommu, struct iommu_domain *parent,
 			    const struct iommu_user_data *user_data)
 {
 	int ret;
 	phys_addr_t page_base;
 	unsigned long flags;
-	struct iommu_viommu_amd data;
+	struct iommu_viommu_amd data = {};
 	struct protection_domain *pdom = to_pdomain(parent);
 	struct amd_iommu *iommu = container_of(viommu->iommu_dev, struct amd_iommu, iommu);
 	struct amd_iommu_viommu *aviommu = container_of(viommu, struct amd_iommu_viommu, core);
@@ -81,6 +97,13 @@ int amd_iommufd_viommu_init(struct iommufd_viommu *viommu, struct iommu_domain *
 
 	aviommu->vfmmio_mmap_offset = data.out_vfmmio_mmap_offset;
 
+	aviommu->kvm = get_kvm_handler(data.kvmfd);
+	if (aviommu->kvm == NULL) {
+		pr_err("%s: Failed to get KVM handler (kvmfd=%#x)\n", __func__, data.kvmfd);
+		ret = -EINVAL;
+		goto err_kvmfd;
+	}
+
 	/* Reset vIOMMU MMIOs to initialize the vIOMMU */
 	iommu_reset_vmmio(iommu, aviommu->gid);
 
@@ -94,6 +117,7 @@ int amd_iommufd_viommu_init(struct iommufd_viommu *viommu, struct iommu_domain *
 	if (ret)
 		goto err_init;
 
+	aviommu->kvmfd = data.kvmfd;
 	viommu->ops = &amd_viommu_ops;
 
 	spin_lock_irqsave(&pdom->lock, flags);
@@ -102,6 +126,7 @@ int amd_iommufd_viommu_init(struct iommufd_viommu *viommu, struct iommu_domain *
 
 	return 0;
 err_init:
+err_kvmfd:
 	iommufd_viommu_destroy_mmap(&aviommu->core, aviommu->vfmmio_mmap_offset);
 err_mmap:
 	amd_iommu_gid_free(iommu, aviommu->gid);
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 0b7a3e5b057c..69aa44bba95a 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -1085,10 +1085,12 @@ struct iommu_viommu_tegra241_cmdqv {
 /**
  * struct iommu_viommu_amd - AMD vIOMMU Interface (IOMMU_VIOMMU_TYPE_AMD)
  * @out_vfmmio_mmap_offset: (out) mmap offset for vIOMMU VF-MMIO
+ * @kvmfd: KVM FD handler
  * @reserved: Must be zero
  */
 struct iommu_viommu_amd {
 	__aligned_u64 out_vfmmio_mmap_offset;
+	__u32 kvmfd;
 	__u32 reserved; /* must be last */
 };
 
-- 
2.34.1

