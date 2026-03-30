Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011052.outbound.protection.outlook.com [52.101.52.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983093B19A6
	for <iommu@lists.linux.dev>; Mon, 30 Mar 2026 08:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774860200; cv=fail; b=SvnvnL4TPKWdlSjjvZLNoqBSWllDjetFFNJp7Qd+dz2b3UUN4AH1M1oU4sjEY61ezXtDlwBrGnPsavGXqQ/kcZ8QIzWuAz3IxiJa3d7bywh0Oq8HDRKMGW/vOjW1PzuoMeTj0ArES+XM+befWA8q2SPjx6bsNX35NKhQPpxojQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774860200; c=relaxed/simple;
	bh=nS2eIH/ckNkMIya5VHkGe7agvbZ4HxQwx/hiSnQtcmw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tEkqUKwknj3RNgpwf5T8eJ93TZLDMgDdzu80bVoZCyp+k3/4JlkuBVfwPtpdrQXa56r7mrIMWQAck9pDCsEb3VPI65Lz3goeZISuTDFUuW5XMch4HJgpjQHb7RCDYDU5bJxZgJbVtO6h2i3rJB8Oi9hWOy32G/DoxLBxAHcfq08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5mzZQ1o/; arc=fail smtp.client-ip=52.101.52.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5mzZQ1o/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QDasrKukiCO5Rj+niuGvTQkjFghsCBwBwKalVMddahY+knuz2ijAEW4oyMWPOaUaUm3F8JIUz5f+L1XUfV89vQQLFuSxBALP4olS8xiU8ClCItqE8PsVz94ryDB3qmW+xn1wKsPJWPmBWL5509AaR5f23KycqLAPi1+Ln+d/g7PT2+tiisTtrYnf+t1JyYBjIc31xrTsbgOpHERDRlvViGI3ixOgXNdnWGQ7reiGuiHxwEmgJ48XmkJZIGKSamarsr1DasuSfnqabB5e04P0u4jNqKrx7D/bxdmZhQ3YgwxgqoK57z2sb4GhU/axBnzTRip3gF5A1NMirG/eFKhMHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2mHl/J7fVxbtBJUL3i3MKa4sBHoL11tGTDObUPim13g=;
 b=hfeGteLaK59UVdp+p/oM5vW1Md63lEQXNCn4wWvF6Wf3bK0fl/vSaKqMpOwf6iefvqdPHx91IHAbowV6VuL4yY175fx6fQg/VeuBy/rURdrdDLAKDZ7kkvmGAB7U3hyDEv4jTA43QbhIwTrgydTBgqCjOsLjlhgJ75TBjQRuTf7a5mNke2w3wvXAfvvySy0llRkAOxh+DeAIlg503aqpc+MDGmdkVy8kusC/YuB/Ojwt0aLE+qiA9YB3/cU/czR11a9SsIA/pHjR6kQNbeyhn5nGR2SpojGlWW/LKNliZZbH8gJDfNn9N9b1IOIHVQUuabClrEkZ36qR6TbCjZfyLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2mHl/J7fVxbtBJUL3i3MKa4sBHoL11tGTDObUPim13g=;
 b=5mzZQ1o/HWwsIjx1lYZ9NMjkcx6gHJhReaT4Z37YMxrPNFjoRd9/axuiK5Ba6fKuVfW3GqnRTrwWCaWHgjEHwIWiJ0vHccOp5kuEL+Rd5ChrF0ullLybymj2EvLnOXn/mtqmbgaApxpcLHSMZp9XeQZcQWk7KA/A+BWhNhf5ZaA=
Received: from DM6PR04CA0004.namprd04.prod.outlook.com (2603:10b6:5:334::9) by
 DM4PR12MB6278.namprd12.prod.outlook.com (2603:10b6:8:a4::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.15; Mon, 30 Mar 2026 08:43:14 +0000
Received: from DS1PEPF00017093.namprd03.prod.outlook.com
 (2603:10b6:5:334:cafe::71) by DM6PR04CA0004.outlook.office365.com
 (2603:10b6:5:334::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 08:43:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017093.mail.protection.outlook.com (10.167.17.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 08:43:14 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 30 Mar
 2026 03:43:09 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jay.chen@amd.com>, <wvw@google.com>,
	<wnliu@google.com>, <dantuluris@google.com>, <chriscli@google.com>,
	<kpsingh@google.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <Vasant.Hegde@amd.com>
Subject: [PATCH 07/22] iommu/amd: Add support for AMD vIOMMU VF MMIO region
Date: Mon, 30 Mar 2026 08:41:51 +0000
Message-ID: <20260330084206.9251-8-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017093:EE_|DM4PR12MB6278:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a919262-d182-4e08-bea1-08de8e3861e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|7416014|376014|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	mOwEWcVLBH3FUh/QRZ3kuPiNbMU6r01x4CIVFPZ8F7tTar7jO3HwQ3Nyxc7WPOS08RSb1CFi50WMVuz3I9TDkY2zx3cxs2UJrb5Sgb56PvNtLSAyIQs6jd5A7+zIqqGUvRqzhnBaDMuj9Ua0FBgQUw53TbvTCmoifXPTRvrzPKrZ1qJBfV+sHgY97wf5itMS4XPi8pQ1zW/MiPJBtfuRmGMJglQe8af+UrbfOpcssqys5aaElNzECJbnp52uPbsF4xff59xz6wUzO5ltJOQhlbLJRSvlXdof/zdmL9U+H2d/yGCqhd4HP31TxTo6nwT2KQER1iNkhwNqDAsyrxKMnxK/OiW/y2YTAdriZcZiiF1ZFl4Yfi4uYr3th8m47YxAU0Aqg3rkbPDdx+426UNYMnbet+LWPsGP9c/iYPj2/WwMPCROjeUx5Pu4BeoGcRAggljH6P/SVuGzn5mWcjX/m7JQJr/8ccWyMBWnArS9QCCv431RoHYK01i/OCDHCgBj5SlLrlExbsLjXnf4wf9hUDcdyrDKR/4Ir8n2w7oAgrryLheblU6jBUOT2mySjDX4DYt0l5sXU21Jn48LbgY5C/vybkCJ4s4DHv62hYWmb1kA93MXLB8whjDl7hWI12ju+ixvYT4LJuBi/GU80nDbB83ib0fPtvWJLfY5wU7tLtkGCMYd9V2osB1FMvXhBsVNm5EeujqBr02ewbHyOpSA0V1OISziYdVQ68P9jh/5RHpQ5kjL/v4Rly7DRdA6B6OoHON+cQvY5Ike1auT6Apz7w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(7416014)(376014)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	FTH7IMzq2yBzpeeJ/qA6oLn9wyQIUAkkTa3U2r6f4zHhTQqtsM6V+WAI82MZKFkmYAKRO7uf7N8UcIHucMFv/yXSG1M1m4r71ZTTWdwHfZBUyDtedXjLABFtaVAAGJblWDhyilr6pBzKzlWo3BdawVSiw765bZMdDlSGDSyUNDSLbqaai37lVSNqDlzkgOoM4oTYEGvdnSZUoXwqkHp28t9Q7s2bliI2mwPhsFrqPi5etvp8I728+bbnMFB5fkhp2M5A/d48KZ4nOLigoXr4cAWMeA6sgAF3AWImFXYnzOPWYh94rpnpcrfpPr24tTvPg2ylkWs18RF2SX9c0wsTjRyTVYDMqRCWAbEU+iNzFYDflWSb5sdlGOjoQb5ZY2sm9vmibzO41rKrZfl4wyZcmwUIF+P3abKFO8A/PvpImTf1y/f5C1shRhxzQnEIWhcn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 08:43:14.4210
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a919262-d182-4e08-bea1-08de8e3861e6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017093.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6278

The AMD vIOMMU virtualizes guest MMIO registers at the 3rd 4K region.
This is achieved using the iommufd_viommu_alloc_mmap().

Co-developed-by: Vasant Hegde <Vasant.Hegde@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_viommu.h |  5 +++++
 drivers/iommu/amd/iommufd.c    | 17 ++++++++++++++++-
 drivers/iommu/amd/viommu.c     | 11 +++++++++++
 include/uapi/linux/iommufd.h   |  2 ++
 4 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/amd_viommu.h b/drivers/iommu/amd/amd_viommu.h
index 45c2b71af4ba..8dbb12241e8d 100644
--- a/drivers/iommu/amd/amd_viommu.h
+++ b/drivers/iommu/amd/amd_viommu.h
@@ -10,6 +10,7 @@
 
 int amd_viommu_init(struct amd_iommu *iommu);
 
+u64 amd_viommu_get_vfmmio_addr(struct amd_iommu *iommu, u16 gid);
 #else
 
 static inline int amd_viommu_init(struct amd_iommu *iommu)
@@ -17,6 +18,10 @@ static inline int amd_viommu_init(struct amd_iommu *iommu)
 	return 0;
 }
 
+u64 amd_viommu_get_vfmmio_addr(struct amd_iommu *iommu, u16 gid);
+{
+	return 0;
+}
 #endif /* CONFIG_AMD_IOMMU_IOMMUFD */
 
 #endif /* AMD_VIOMMU_H */
diff --git a/drivers/iommu/amd/iommufd.c b/drivers/iommu/amd/iommufd.c
index 6fba5d9b1310..5dcd3fc3ba99 100644
--- a/drivers/iommu/amd/iommufd.c
+++ b/drivers/iommu/amd/iommufd.c
@@ -7,6 +7,7 @@
 
 #include "iommufd.h"
 #include "amd_iommu.h"
+#include "amd_viommu.h"
 #include "amd_iommu_types.h"
 
 static const struct iommufd_viommu_ops amd_viommu_ops;
@@ -44,9 +45,11 @@ int amd_iommufd_viommu_init(struct iommufd_viommu *viommu, struct iommu_domain *
 			    const struct iommu_user_data *user_data)
 {
 	int ret;
+	phys_addr_t page_base;
 	unsigned long flags;
 	struct iommu_viommu_amd data;
 	struct protection_domain *pdom = to_pdomain(parent);
+	struct amd_iommu *iommu = container_of(viommu->iommu_dev, struct amd_iommu, iommu);
 	struct amd_iommu_viommu *aviommu = container_of(viommu, struct amd_iommu_viommu, core);
 
 	xa_init_flags(&aviommu->gdomid_array, XA_FLAGS_ALLOC1);
@@ -66,11 +69,21 @@ int amd_iommufd_viommu_init(struct iommufd_viommu *viommu, struct iommu_domain *
 		return aviommu->gid;
 	pr_debug("%s: gid=%#x", __func__, aviommu->gid);
 
+	page_base = amd_viommu_get_vfmmio_addr(iommu, aviommu->gid);
+	if (page_base <= 0)
+		return -ENODEV;
+
+	ret = iommufd_viommu_alloc_mmap(&aviommu->core,
+					page_base, SZ_4K,
+					(unsigned long *)&data.out_vfmmio_mmap_offset);
+	if (ret)
+		goto err_out;
+
 	ret = iommu_copy_struct_to_user(user_data, &data,
 					IOMMU_VIOMMU_TYPE_AMD,
 					reserved);
 	if (ret)
-		goto err_out;
+		goto free_mmap;
 
 	viommu->ops = &amd_viommu_ops;
 
@@ -79,6 +92,8 @@ int amd_iommufd_viommu_init(struct iommufd_viommu *viommu, struct iommu_domain *
 	spin_unlock_irqrestore(&pdom->lock, flags);
 
 	return 0;
+free_mmap:
+	iommufd_viommu_destroy_mmap(&aviommu->core, data.out_vfmmio_mmap_offset);
 err_out:
 	amd_iommu_gid_free(aviommu->gid);
 	return ret;
diff --git a/drivers/iommu/amd/viommu.c b/drivers/iommu/amd/viommu.c
index 887a9eb8122d..76198bf4f4f6 100644
--- a/drivers/iommu/amd/viommu.c
+++ b/drivers/iommu/amd/viommu.c
@@ -92,6 +92,17 @@ static int __init viommu_vf_vfcntl_init(struct amd_iommu *iommu)
 	return 0;
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
index 3a2ac7234b9e..eff5fbd2da6b 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -1075,9 +1075,11 @@ struct iommu_viommu_tegra241_cmdqv {
 
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

