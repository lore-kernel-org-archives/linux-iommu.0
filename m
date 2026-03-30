Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012051.outbound.protection.outlook.com [40.107.209.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD713A1CE9
	for <iommu@lists.linux.dev>; Mon, 30 Mar 2026 08:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774860260; cv=fail; b=DYqo36+rgFYCzvNc8WSfRojzjUr7rk9hyNdNvZujfpISqBYjEJbtO7hT+H0IeUnBvT2uKkJt3CN+d/NCaokN2/Cfg/vIhY+El4QtumP6s+YxE2rWemjO2KUm4HFLXEIVwMFAdKDzsahzroGKFVfFFUPIiXDkbU5IaaQ7JYYO4bg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774860260; c=relaxed/simple;
	bh=baOsvN0GSm98Kz6YlxonY7OPoOoU2+f4JiH7cLA+c0g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RSHYCb7LREtg8m8y9lJ+U+7RSu04QSWVRSftVj8gcuC/xmp4JpkdDLTAZ5ent41GS1SXoTQnFmKOehhRqslyL+gANFAqFEPIc28iHYC2q8JVfI6V0MxVs/0z1exakK0ivH8m9bpt7L4GGWoZOT7zpe9dltWUaPPw0Mjq2wBlYFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dhsIzHaB; arc=fail smtp.client-ip=40.107.209.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dhsIzHaB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n+ef3ZjV+xgTnWSENyOzf22tKNW54KnMYvlnLtTiRuvQxyV/uY44q+0Bh5/2tGCduzu4QxH0nGic1gR2Mz3Hwx/VtL/IcaLkrwYR8giFyXnhZTC7zU02LuG4ai6s+0hwkXgntbRtr0WIwR9vM0ezWoZlvRgCol6HtFFAbtly1mU4G47CtNuRgykYEDkOy7gxMWQg7t0QG+VNb8g6ZZahChpNVlhhXW0/CuW0rRvsgCqZzeKcBqo8kDpjpubWF5/xijIPTn0JpPihD2XhACNfDiZ0ZAMnNPG/9n0ZZD1g9YWjbRRlJB4gjHpgRxQ1ds0bWKJMw5bmKzoq1NnvHh0ayQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m/4LWT28+6tO+GNyw6QR4uF/m7l4CN6srT3RoFDkCis=;
 b=jTshhDUGtkCRuPffE/ghQV6E0gi5VdYXHIe51gH3dbi/zOLABakFh406MpbLttQNKrzg/3eqkN+4sOR+rCY41QQEerkjyQEQ8dFD0CLKNUJH8ITGw8j9kHO1bLX4g471/5T3Zcn3k5UmZbYDqQFaFhno3+x8iOKcF50JE94B2gSqm1TtgAbDp1wDqUV+SnUsjBOFnhxzh7QjGlDAeI7xAd1ZvbBA7MiJdDIesFvKc+fMrMgzFw903na0RwbTUnGM1ArQ6qMk6ISqMxHFNOmOva6xkKmCsMcCQ9khTWE6aFQI34bHxcABR/P1SRtU/DFe0PEeiKL67tasKLrgOtDTgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m/4LWT28+6tO+GNyw6QR4uF/m7l4CN6srT3RoFDkCis=;
 b=dhsIzHaBi02l/F7n+13ecr5oNU33OV5iN8iX8vtbmM0n+GO+a8lRkzKwpFI0hvQVFUYiR6Z5L7gDRNgbD8MWVnEaGBNrrAhLofgdVaj/yz4DEL5C4RxFph/WYHffXrmdLufk5kR7d+dId1AJrCYFqYGcaPCDsU67dp2xywr4Sa8=
Received: from PH7P221CA0003.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:32a::33)
 by DS0PR12MB8342.namprd12.prod.outlook.com (2603:10b6:8:f9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 08:44:11 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2603:10b6:510:32a:cafe::84) by PH7P221CA0003.outlook.office365.com
 (2603:10b6:510:32a::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 08:44:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 08:44:10 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 30 Mar
 2026 03:43:57 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jay.chen@amd.com>, <wvw@google.com>,
	<wnliu@google.com>, <dantuluris@google.com>, <chriscli@google.com>,
	<kpsingh@google.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH 17/22] iommu/amd: Introduce vIOMMU Translation DTE
Date: Mon, 30 Mar 2026 08:42:01 +0000
Message-ID: <20260330084206.9251-18-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|DS0PR12MB8342:EE_
X-MS-Office365-Filtering-Correlation-Id: 805e6b32-91df-4acd-04c0-08de8e38838e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|7416014|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	pv8BTGMmibAHXRgMaei40Pn7C0Wjk5OsIVUqHyJwrRBgW4rYIZT7MWmv5dpfY3lQk3O2xdvmTM3jH6YVEXSuNy6+aAzgHBLA7cs8/Y2sLrx8yS/WzHqZ1sYJZTlVojlpZfBLECugy8KI7Bb8wU32RcW0VTo0VR8nDfWuHUpqill62Zeq0bPLXmB5/P4pvA5zB3k7dEbG39tmA2RSOj3+/AAEF7jVgDEWpYpFZtpM+THWou5GSjHXH5KVNYhH1oKXopIQhvFmNGn633yTSlW/RiPwVRxNgaaiQtsJIKX3OSZmISybExxsqfcDj8Ph8qqaKgxXzaH0OxVHRqn1o+lAQsZHZjGjk16REtpJSAPVLhgvza5NLtbPevcRO1W9SCt2hyeNu5yzXjdtwUuuxpt4m0E8RiMkEyImjuE1Y2nAc1xKMnYM25VyiM3Q9KRY8Ipin36IO/kAwc+eEtQBdJFwWqMvhYqRL2tXM8FP3d+QuTY+AE4tnr8nL+LF8iF+aogcwvxEJO/31hR+j6heZnxz8DYGk9DbcAUAN4Y4aWlPT9wcfOQ9oD495YIFPw3pBL4E9T2zlL5XTc1VlBxjV2CKstFFY16+1GJvW2dlWGBQJ5DJFCKVRqoOmsX8VnEooG0vgJPr1SyasVINqDDJzml52eCBfaVh1Pjn8emxclU6EElkCjTfKSMsQuq8AxzF43iXfTXIKMC32G1SZ58pE0QhRe98rhVgEnHSIToH2ViQOYofNuJkjbfyYekuvW01A3FuP+dwODj16sy2Boggl8dXDw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(7416014)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GzRRl9N5ZSzeZnf7gKKBL/WBBHmHvgAkFfbxlChLheoKF7lO8YwvO75NcBmf7AO7RcNtDzt3NLsd24Yrpbs3RyN7GjQxJilGczAn/v6E6Rt211NMdt49a+Bf4Vvg+qBP+pADFOJDs17QWqghqbsWuslPwA8XcV39RyK3vpsgV194gugH+4E8nXMYdmx2y52jaQejWKEm00FR6EblLlgymZzp62nqlAnXa73PfUSDTo9e5Z4SwqwucsR9U7EWpJ8vktpEi+TQ3oPtIkdXB3k855830CMBJpwt14GbCJvLNFJQLYhMvwJ5+8K6Q9QEBLqiojRUqCUZ1c++OvdIMYgvDHD7H6YQ2eQ8lg5Lw4+A2lzVx9V95EH3iIZ03uO7BnkZdB45mAfJS1ICL0bxIvjpAPAYYCjtMbJyWSHGmVrlkh9cx12Yi+A+1T+mxw2+Cy2U
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 08:44:10.8986
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 805e6b32-91df-4acd-04c0-08de8e38838e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8342

AMD vIOMMU requires hypervisor to setup a special DTE to store GPA->SPA
 mapping for each VM. This is used to translate base addresses of guest
IOMMU data structures (i.g. Command Buffer, Event Log, PPR Log) and the
Completion-wait data store (as part of the Completion-wait command).

In Linux kernel, this is referred as vIOMMU Translation DTE (TransDTE),
which is unique per VM. (Note that all IOMMU instances within a PCI
segment share the same Device Table.) The device ID for the TransDTE is
referred to as TransDevID, which must be an unused PCI BDF and must be
unique for each VM.

Currently, TransDevID is specified by VMM, and passed to the IOMMU driver
via struct iommu_viommu_amd during vIOMMU initialization. The driver
programs the ID into the DeviceID field of the VFCntlMMIO Guest
Miscellaneous Control Register. The register is cleared during VM
destroy.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h       |  8 +++++
 drivers/iommu/amd/amd_iommu_types.h |  2 ++
 drivers/iommu/amd/iommu.c           | 51 +++++++++++++++++++++++++++++
 drivers/iommu/amd/iommufd.c         |  8 +++++
 drivers/iommu/amd/viommu.c          |  3 ++
 include/uapi/linux/iommufd.h        |  2 ++
 6 files changed, 74 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index b5a54617a9a1..38694ebdb083 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -209,8 +209,16 @@ void amd_iommu_set_dte_v1(struct iommu_dev_data *dev_data,
 void amd_iommu_update_dte(struct amd_iommu *iommu,
 			  struct iommu_dev_data *dev_data,
 			  struct dev_table_entry *new);
+
 int amd_iommu_completion_wait(struct amd_iommu *iommu);
 
+void amd_iommu_set_translate_dte(struct amd_iommu *iommu, u16 gid,
+				 struct protection_domain *pdom,
+				 u32 devid);
+void amd_iommu_clear_translate_dte(struct amd_iommu *iommu, u16 gid, u32 devid);
+void amd_iommu_update_vfctrl_mmio_translate_devid(struct amd_iommu *iommu,
+						  u16 gid, u32 trans_devid);
+
 static inline void
 amd_iommu_make_clear_dte(struct iommu_dev_data *dev_data, struct dev_table_entry *new)
 {
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index c50ba5cda82d..2c4844b44caf 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -494,6 +494,7 @@ extern bool amdr_ivrs_remap_support;
 /* VIOMMU stuff */
 #define VIOMMU_VF_MMIO_ENTRY_SIZE		4096
 #define VIOMMU_VFCTRL_MMIO_ENTRY_SIZE		64
+#define VIOMMU_VFCTRL_GUEST_MISC_CONTROL_OFFSET	0x10
 
 #define VIOMMU_VF_MMIO_BASE(iommu, guestId) \
 	(iommu->vf_base + (guestId * VIOMMU_VF_MMIO_ENTRY_SIZE))
@@ -551,6 +552,7 @@ struct amd_iommu_viommu {
 
 	u64 *devid_table;
 	u64 *domid_table;
+	u16 trans_devid;
 };
 
 /*
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 8d8f4f374d5f..40a4dc219a84 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3224,6 +3224,57 @@ static bool amd_iommu_enforce_cache_coherency(struct iommu_domain *domain)
 	return true;
 }
 
+#if IS_ENABLED(CONFIG_AMD_IOMMU_IOMMUFD)
+
+void amd_iommu_update_vfctrl_mmio_translate_devid(struct amd_iommu *iommu,
+						  u16 gid, u32 devid)
+{
+	writeq((devid & 0xFFFFULL) << 16,
+	       VIOMMU_VFCTRL_MMIO_BASE(iommu, gid) +
+	       VIOMMU_VFCTRL_GUEST_MISC_CONTROL_OFFSET);
+}
+
+void amd_iommu_set_translate_dte(struct amd_iommu *iommu, u16 gid,
+				 struct protection_domain *pdom,
+				 u32 devid)
+{
+	u64 tmp0 = 0ULL, tmp1 = 0ULL;
+	struct pt_iommu_amdv1_hw_info pt_info;
+	struct dev_table_entry *dev_table = get_dev_table(iommu);
+
+	pt_iommu_amdv1_hw_info(&pdom->amdv1, &pt_info);
+
+	pr_debug("%s: gid=%#x, iommu_devid=%#x, devid=%#x, host_pt_root=%#llx, mode=%#x\n",
+		 __func__, gid, iommu->devid, devid, pt_info.host_pt_root, pt_info.mode);
+
+	/* Setup DTE for v1 page table at the offset specified by devid */
+	tmp0 |=	FIELD_PREP(DTE_HOST_TRP, pt_info.host_pt_root >> 12);
+	tmp0 |= FIELD_PREP(DTE_MODE_MASK, pt_info.mode);
+	tmp0 |= (DTE_FLAG_IR | DTE_FLAG_IW | DTE_FLAG_TV | DTE_FLAG_V);
+	tmp1 |= FIELD_PREP(DTE_DOMID_MASK, pdom->id);
+
+	dev_table[devid].data[0] = tmp0;
+	dev_table[devid].data[1] = tmp1;
+
+	iommu_flush_dte(iommu, devid);
+	amd_iommu_completion_wait(iommu);
+}
+
+void amd_iommu_clear_translate_dte(struct amd_iommu *iommu, u16 gid, u32 devid)
+{
+	struct dev_table_entry *dev_table = get_dev_table(iommu);
+
+	pr_debug("%s: gid=%#x, iommu_devid=%#x, devid=%#x\n",
+		 __func__, gid, iommu->devid, devid);
+
+	dev_table[devid].data[0] = 0ULL;
+	dev_table[devid].data[1] = 0ULL;
+
+	iommu_flush_dte(iommu, devid);
+	amd_iommu_completion_wait(iommu);
+}
+#endif /* CONFIG_AMD_IOMMU_IOMMUFD */
+
 const struct iommu_ops amd_iommu_ops = {
 	.capable = amd_iommu_capable,
 	.hw_info = amd_iommufd_hw_info,
diff --git a/drivers/iommu/amd/iommufd.c b/drivers/iommu/amd/iommufd.c
index 685748a71b22..f83d69716eaa 100644
--- a/drivers/iommu/amd/iommufd.c
+++ b/drivers/iommu/amd/iommufd.c
@@ -83,6 +83,13 @@ int amd_iommufd_viommu_init(struct iommufd_viommu *viommu, struct iommu_domain *
 	/* Reset vIOMMU MMIOs to initialize the vIOMMU */
 	iommu_reset_vmmio(iommu, aviommu->gid);
 
+	amd_iommu_set_translate_dte(iommu, aviommu->gid, pdom, data.trans_devid);
+
+	/* Set translate devid in vfctrl mmio */
+	writeq((data.trans_devid & 0xFFFFULL) << 16,
+	       VIOMMU_VFCTRL_MMIO_BASE(iommu, aviommu->gid) +
+	       VIOMMU_VFCTRL_GUEST_MISC_CONTROL_OFFSET);
+
 	ret = amd_viommu_init_one(iommu, aviommu);
 	if (ret)
 		goto err_out;
@@ -93,6 +100,7 @@ int amd_iommufd_viommu_init(struct iommufd_viommu *viommu, struct iommu_domain *
 	if (ret)
 		goto free_mmap;
 
+	aviommu->trans_devid = data.trans_devid;
 	viommu->ops = &amd_viommu_ops;
 
 	spin_lock_irqsave(&pdom->lock, flags);
diff --git a/drivers/iommu/amd/viommu.c b/drivers/iommu/amd/viommu.c
index 28fe92ad9771..4626134893d6 100644
--- a/drivers/iommu/amd/viommu.c
+++ b/drivers/iommu/amd/viommu.c
@@ -428,6 +428,9 @@ void amd_viommu_uninit_one(struct amd_iommu *iommu, struct amd_iommu_viommu *avi
 			       VIOMMU_DOMID_MAPPING_BASE,
 			       VIOMMU_DOMID_MAPPING_ENTRY_SIZE,
 			       aviommu->gid);
+
+	amd_iommu_update_vfctrl_mmio_translate_devid(iommu, aviommu->gid, 0);
+	amd_iommu_clear_translate_dte(iommu, aviommu->gid, aviommu->trans_devid);
 	viommu_clear_mapping(iommu, aviommu);
 }
 
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index eff5fbd2da6b..d9e5c5f0d997 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -1076,10 +1076,12 @@ struct iommu_viommu_tegra241_cmdqv {
 /**
  * struct iommu_viommu_amd - AMD vIOMMU Interface (IOMMU_VIOMMU_TYPE_AMD)
  * @out_vfmmio_mmap_offset: (out) mmap offset for vIOMMU VF-MMIO
+ * @trans_devid: GPA->GVA translation device ID (host)
  * @reserved: Must be zero
  */
 struct iommu_viommu_amd {
 	__aligned_u64 out_vfmmio_mmap_offset;
+	__u32 trans_devid;
 	__u32 reserved; /* must be last */
 };
 
-- 
2.34.1

