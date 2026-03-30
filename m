Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012003.outbound.protection.outlook.com [52.101.53.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C263AF677
	for <iommu@lists.linux.dev>; Mon, 30 Mar 2026 08:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774860210; cv=fail; b=V6qUN88jWSBHRMDuUAzB7QjEy56LriPspflHGT4zRAh7fG+mplFmSZbQI83+HZ/cG4+i/apWOXhWaMjTFUxtHf1xQrrhpdoOhEQnH48BS0KzHxpQWAI8hgC7ClSrfD2LFR2ATLZOLL3uTSrVT05XIUyFkWPNqZWw5acqnn9tzoY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774860210; c=relaxed/simple;
	bh=rMcqzsvkV6FwcvC3nazbBpxF8dwW+eLHka3TA6ZHyqc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EwOC9oHp1RkOWwlO5TgNAyyfZfjm4sg6oHxIGczbHIegJG1+/k0tFD4Z8KVBvNkn5ZaumTHRHFaYfWgnYUVa4/59Up/45bcXl6PDLF0gxxuO1KySjlas1TVr+vWtxC2PEgFwdi36Gg8jcrDIFkCrcibDFG/a1oURlpWq+8Ll8BE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=z4NfyRZZ; arc=fail smtp.client-ip=52.101.53.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="z4NfyRZZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rudYQU+efDVl/bEwd/l1hzBs/vdB2ikfzx0thUk715zUkzdLVTFh6g6lzZBTbB3HaRzvFzcNUk3b5Ud6Wqq6LJsFNtJC1YTxer6P/VjFHYEo+V8OtLY99dQkDVPyVNoM3s7DISUidRWg8vaq04qfXocydl8qItRQQW3D268dLv/+J1wBhHtRoAzRBJZvh1jvghEhi4Vc1NmDfFs6sKYOKAbwPnSoGaTfGuHcfgRdHTOQ8MxdB42buFiF5LUCYkjmBW8ScSpmMxboLp/plordtSYQb3BitL3+nsx3XnOAt9jUya8200L3EfcC8iwqfysfwo6gGtsfJYLr83LPUCfNDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A5pwhFWDUTnS1UHseLB6I/6FMxeWs3Wyb7wQNBpOoTk=;
 b=FKCnHGvElrQic23IhV5f64U7QvuIA055h9BcheUHmGayZHezub/39j+Tl5y15rd4UU7bgie9D4RJGBfCnJ7dTI5mT7r7dFxMGKHAE+OokQp4WUjNpSKEvZyi/JkXFPQs6RHmLQym4KpIGtjxkqS16ijaH6t9AOH8tpW48ea8MWyrfkquwLjMnpLeAwLNocw97ZqKh2XOoPIJu9HIgFWmWpQ6Zb+V4QUMc+zwb1Siv+cOp1up0RvVyXVI4LkheP+25W9zWDdfj0cMbxtC+etq4sYTesvrkSmDuAelXBUFTyKWi7yZsYQNQgXqX2n6CWmreW2/EAlQmUPKI2gEQBzKwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A5pwhFWDUTnS1UHseLB6I/6FMxeWs3Wyb7wQNBpOoTk=;
 b=z4NfyRZZJa8nS3qEuw7RrYUl7EHKYoP1kA7+04aF3zFFudALv1AT6CYqdUEHEp/3HoHIUQTEQq+AMHtgkSKDE7Tm8hPHvPn2RNOHZ9A5/OycoHL33+YgBJ4xWxRmxEDCIBugXvMwlgk1bpBVlH3XQjDKjEAaDIvYylAtSnSi/wY=
Received: from DS7PR03CA0350.namprd03.prod.outlook.com (2603:10b6:8:55::27) by
 CH3PR12MB8709.namprd12.prod.outlook.com (2603:10b6:610:17c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.14; Mon, 30 Mar
 2026 08:43:23 +0000
Received: from DS1PEPF00017094.namprd03.prod.outlook.com
 (2603:10b6:8:55:cafe::4e) by DS7PR03CA0350.outlook.office365.com
 (2603:10b6:8:55::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 08:43:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017094.mail.protection.outlook.com (10.167.17.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 08:43:23 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 30 Mar
 2026 03:43:18 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jay.chen@amd.com>, <wvw@google.com>,
	<wnliu@google.com>, <dantuluris@google.com>, <chriscli@google.com>,
	<kpsingh@google.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH 09/22] iommu/amd: Introduce domain for IOMMU Private Address (IPA) region
Date: Mon, 30 Mar 2026 08:41:53 +0000
Message-ID: <20260330084206.9251-10-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017094:EE_|CH3PR12MB8709:EE_
X-MS-Office365-Filtering-Correlation-Id: c26d783e-1876-46b3-2bd7-08de8e38676d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|7416014|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	ckElwzkR+zZFTgBkukHECMXQOG/DEJJQCvJTKhGhld3TMn4TPq69951nCkpCdTVI1uUPxcsy8AmPjRq++/RvXV8rUwAug35jOcxKcSzIw58UyRH6zsxqDSd83gimAvT/sDk/uq7JFEVDu2baN0MAf988f7wjztOIvnbfCJKH6GvcOJ1cPGLf+Ny14TZvYSbH5Ms5kArr/lL+a/sH1SwlbWol1+zQwt0kKCpTZd8ACCuQFVx6XTgqaS8HDSfNJRJYtLNJqtNlaeh7QzYfE0qo0XmWaVFzdtsvjY9DGyHWkzAHPda+mVUCuPk2gikeQHIRLaW0NQpm/os6PxaMMdqIQ/bSZ/sUzIgAKIIIC0qN86dt2wR/MFcHXbaR3d7PEQKQ3V43bR+X3HTuN/zFQLqhK1jszPK3E6/leZRfG3jDK/mkpXtTm/Y6yxaq1hK8btOD8qDDZKuatKKHxe9deVWJoYmAgOTem38CyIFPzHha7fsOqU3I1TD48NJJ4eCajxkWOXPfZh9Debq2y6sjnd/hIjI2ExKMQcFIu0xeHinCm7q8h3L5GwpysHgbt5STkLRBoaPjb2j1beT3fAnRqhbJFy8qKgVebIfBTCiugkeirDDbyS+h1Kj5rHnRALdEY0oYa8+AHnCsWEkuXC/gapLSNS0lMroJKgDho7TQPCCvc28R63d3hz4zl/SZGY4Y5DLYqHruauysM2zh/hHobmNP/rEatZzouD1eUQVvGJHbDt7lpW8bZU+HnBsTkMLnR37VRrrvoKuX6egH2UAhMmfErwg2geFIpTSz6y96SmAC0j8=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(7416014)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	khYhApG1pFXM3P0gsMRiqxtcu3vKeTypTj19uYJuDZpBAENPdOTf6mQ6SyI6Y7R7gTmHn0f4wBRw9eLyRNbO2WDR1cNDuOyhNjY5vQetKh8wSuj71VkD7hErcv/k6yKJj2eRBMvbrEwXXVaIblCrJyKLa4KfeA8tpFftW9NmSNWL9YApNPI+fpez4yom3SJ7BpAaTrXdlBvN7+zR3hgQqLAGAmpgXB5UIrSa9xk0jx4sRrH415VjEgRWBmsdBAuSeWblL3RpiLJix7ryyKT0aNM5mFXcS9J7Xf8sKoSuIl3cCiQYnvk5rztnMb0qDGa1ajlyOnGyh5WRqjnztg0bBG4qd3Ae/hHINwUMPlUsBWOlrCg50WKB34Tsy7YBEz6LtLWeUsejdSCbvn0ekMBpv10WUEh3NBZE6Pchry/lQmyrMLtQRH9uNDDP+m/9x0t0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 08:43:23.7314
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c26d783e-1876-46b3-2bd7-08de8e38676d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8709

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
 drivers/iommu/amd/amd_iommu.h       |  3 ++
 drivers/iommu/amd/amd_iommu_types.h |  3 ++
 drivers/iommu/amd/iommu.c           |  6 +--
 drivers/iommu/amd/viommu.c          | 76 +++++++++++++++++++++++++++++
 4 files changed, 85 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index f1fafa21777d..ad88c4118719 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -28,6 +28,7 @@ void iommu_feature_enable(struct amd_iommu *iommu, u8 bit);
 void *__init iommu_alloc_4k_pages(struct amd_iommu *iommu,
 				  gfp_t gfp, size_t size);
 u8 __iomem * __init iommu_map_mmio_space(u64 address, u64 end);
+int iommu_flush_dte(struct amd_iommu *iommu, u16 devid);
 
 #ifdef CONFIG_AMD_IOMMU_DEBUGFS
 void amd_iommu_debugfs_setup(void);
@@ -36,6 +37,8 @@ static inline void amd_iommu_debugfs_setup(void) {}
 #endif
 
 extern bool amd_iommu_viommu;
+extern const struct pt_iommu_driver_ops amd_hw_driver_ops_v1;
+extern const struct iommu_domain_ops amdv1_ops;
 
 /* Needed for interrupt remapping */
 int amd_iommu_prepare(void);
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 53854a4f4307..36ca9003dd88 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -807,6 +807,9 @@ struct amd_iommu {
 	/* IOPF support */
 	struct iopf_queue *iopf_queue;
 	unsigned char iopfq_name[32];
+
+	/* HW vIOMMU support */
+	struct protection_domain *viommu_pdom;
 };
 
 static inline struct amd_iommu *dev_to_amd_iommu(struct device *dev)
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 191a52b657c1..07a0314a3fdc 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1546,7 +1546,7 @@ static void domain_flush_complete(struct protection_domain *domain)
 		amd_iommu_completion_wait(pdom_iommu_info->iommu);
 }
 
-static int iommu_flush_dte(struct amd_iommu *iommu, u16 devid)
+int iommu_flush_dte(struct amd_iommu *iommu, u16 devid)
 {
 	struct iommu_cmd cmd;
 
@@ -2720,12 +2720,12 @@ static void amd_iommu_iotlb_sync(struct iommu_domain *domain,
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
diff --git a/drivers/iommu/amd/viommu.c b/drivers/iommu/amd/viommu.c
index 76198bf4f4f6..2a6339076c6e 100644
--- a/drivers/iommu/amd/viommu.c
+++ b/drivers/iommu/amd/viommu.c
@@ -92,6 +92,78 @@ static int __init viommu_vf_vfcntl_init(struct amd_iommu *iommu)
 	return 0;
 }
 
+static struct iommu_domain *
+viommu_domain_alloc(struct amd_iommu *iommu)
+{
+	int ret;
+	struct pt_iommu_amdv1_cfg cfg = {};
+	struct protection_domain *domain;
+
+	domain = protection_domain_alloc();
+	if (!domain)
+		return NULL;
+
+	domain->pd_mode = PD_MODE_V1;
+	domain->iommu.driver_ops = &amd_hw_driver_ops_v1;
+	domain->iommu.nid = dev_to_node(&iommu->dev->dev);
+
+	cfg.common.features = BIT(PT_FEAT_DYNAMIC_TOP) |
+			      BIT(PT_FEAT_AMDV1_ENCRYPT_TABLES) |
+			      BIT(PT_FEAT_AMDV1_FORCE_COHERENCE);
+	cfg.common.features |= BIT(PT_FEAT_FLUSH_RANGE);
+	cfg.common.hw_max_vasz_lg2 =
+		min(64, (amd_iommu_hpt_level - 1) * 9 + 21);
+	cfg.common.hw_max_oasz_lg2 = 52;
+	cfg.starting_level = 2;
+	domain->domain.ops = &amdv1_ops;
+
+	ret = pt_iommu_amdv1_init(&domain->amdv1, &cfg, GFP_KERNEL);
+	if (ret) {
+		amd_iommu_domain_free(&domain->domain);
+		return ERR_PTR(ret);
+	}
+
+	/*
+	 * Narrow the supported page sizes to those selected by the kernel
+	 * command line.
+	 */
+	domain->domain.pgsize_bitmap &= amd_iommu_pgsize_bitmap;
+	domain->domain.type = IOMMU_DOMAIN_UNMANAGED;
+
+	return &domain->domain;
+}
+
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
+	dom = viommu_domain_alloc(iommu);
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
@@ -119,5 +191,9 @@ int __init amd_viommu_init(struct amd_iommu *iommu)
 	if (ret)
 		return ret;
 
+	ret = viommu_private_space_init(iommu);
+	if (ret)
+		return ret;
+
 	return 0;
 }
-- 
2.34.1

