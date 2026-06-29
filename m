Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012013.outbound.protection.outlook.com [40.107.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C11144103F
	for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 15:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782747757; cv=fail; b=TlSI4zXiEsnsOORoz3CocAaNAWJ6VunRakn3OqFXmPgdVVmsGV2ItUNG7p6QrnnHsC4GtyC5vj5Upt6Cc/Iyk2GuYW2U0klDuCkQj8bSR1mw0ywDB5IW/5bEWSlrS+H2COC22xF0UHHuKwIQdE9XaPwjlcO20Y5uLmFJEBMLIO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782747757; c=relaxed/simple;
	bh=dTGONS+ra0yNu9hrbGQg7m8q28GkCYFnwI8alnfy6gU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iDAH6eKKiGST3jrG+0oO+TBjrp3UnPFMzbAOsWlwZnxolOQjO/cyHwmI2Ouipe9nLL0/eB1xDV1Ravsuls+NEffJu5IN/slathCzhsRLFGtweMxmZ/EYqPdlbyi6QDVgKoKI2BWtzsoASfAYavZgzQiMHGTaknImHDCxFPEgWpA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uErSK4mS; arc=fail smtp.client-ip=40.107.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uErSK4mS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p8uLmMrkn9hj9v2QY/eRvUTvLMJCwT5p0MnFTiKp9K9IPpID7A4hCp7CgXjmkBrqnFabMVC55t6bjNCtcm9fG2AT6m+kTQoHbr2xOoR5X38bv+9SMv3wrOVr7amOviQoaMvg35bdUsiNxcGS1wpPCJAkiW6edTjdsLBKxWeLxUQRGGVJLJcAqvdlmwXEmdkmjccr5izxqwe6tgKFEX/Vq6Rfb2mPHfpnVdxJ1LNz00MYUH/02gjCNy9l/XZBjtJBEWbG8tolG9lKn30davPvP+Rbrk6Pz1o/438bdSxtkIj0SKzcYzLCigucSddT9S3yAmlWCjNLh93jgo35Hk4OQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pSrrsswmXHqDI9lN9QMxDfSEy89VuynXwpzAyMREHgg=;
 b=v1vpAVuSaaXatUARbxbYqkzJ9F2fEGKYZn04NrQL49y32wWyVMdLt7yN6BrXcKAzLsPHu5dGT4Tmu81c8Nq2S0ScuRLTFcSGrVEyY7OzCwwAafyB4OqcBMx0tTxoy78eBgKNNA1bO2BZ5XYjOfH/VQ35BSQyc4XzmdRHdEKW14Ah/ud59nsu17LPb/OenIINMlH+jQiihFsc2HSmnIzLzRrBl56qAfFQYhBWQwBVUA5CpBR3OrYlz0Eg49BnjAHOsxQ9SqNjVambotVbI+35O5bUHLNLEIVTZLN5HnJomPPDHVHqEvTFDIPZR3P/TdxX2fnPqogHf1yzJ7HppefSGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pSrrsswmXHqDI9lN9QMxDfSEy89VuynXwpzAyMREHgg=;
 b=uErSK4mSEI52z7NiSMdA95cFZeY0SILKDjle1+paXrZlFUiLNkj0FxOQrFZhlJQ7kPY7zNfg+cWLp0OO6+OOF4edHhC00bWdx9BLN4gZSuzB7mAVnBhxs1nJScl06F3wuUXjETqZNqsjwa7/EibpZ57pbYy+9p2pQRsCnTAEi/c=
Received: from BY1P220CA0022.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::14)
 by IA4PR12MB9788.namprd12.prod.outlook.com (2603:10b6:208:5d5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 15:42:30 +0000
Received: from SJ1PEPF000026CA.namprd04.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::5b) by BY1P220CA0022.outlook.office365.com
 (2603:10b6:a03:5c3::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Mon,
 29 Jun 2026 15:42:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026CA.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 29 Jun 2026 15:42:29 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 10:41:57 -0500
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 08:36:54 -0700
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jay.chen@amd.com>, <wvw@google.com>,
	<wnliu@google.com>, <dantuluris@google.com>, <chriscli@google.com>,
	<kpsingh@google.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v3 13/22] iommu/amd: Assign IOMMU Private Address domain to IOMMU
Date: Mon, 29 Jun 2026 15:35:26 +0000
Message-ID: <20260629153535.15775-14-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026CA:EE_|IA4PR12MB9788:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b42a049-ace7-4f53-5efd-08ded5f50718
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|7416014|376014|23010399003|1800799024|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	Q8jhY/8WG1C1WXcLq0PWWDI8qu07di5YyDPl63gutVHVNl+eBcIfre26Vvs4Fkk446zmh0kHpGSStvvWeWZMUmKEcTtnE20z5sDZZj3iKiIF+rMKV5eEMK/g6yoIK3bj/tjRThGNpCQC13Gj2fyTHZtkE1HoCOoQxFhdtkuaLt2q9V42BPk1ZpSH2uGoOVC1PW0OwrZyQudSwd1OciY6gLfpPw4wgksDSJBU5rMuTAHlU/1VAwjt53xpylLhuAK7rpW+60G6l9hOgfA5ARLzkxtgWj6EfJwVDbS+aTYvG6RWcCVsiHCzM2gtjUAu5I0gqmvh3tZvQ1lFDcqt+//OMzCenl51BNFpCkE2kuCJ+X1RYfPzfdtS6XAZ4ZwHui9uUxz17fME3HjJr7qLzjnQbNsh8dRdskq8RdSrS5vS9A+12U/F1KkJjikjrCj7tUNooRMzo3/dkPi1skH0Z3lJBEdC7MeKj0JUZAKYWUS4BALWniHC/o2jhNJOi7eGRCzOHOcnVWEjI3mdR1qHu195XrkNFFNbciYNTNrxIU4q+rypxOoNi9EScZmopxPteE91L2zb6bdnQJYenhL0TRAohn9LPo5AhRWd26j8123TU9k7cwRvaTjei5yrFPhIPaRGZPVwkyUmez0A0wliEF66agbIGl74e2fC7tD6SVwgK7Ed5tCHZAqV7zjGIe2yscZdaAD+N0UjRV1Ci5nt0fAy2Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(7416014)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	16o+F9vVd7xruWwCMAjE/1ZBXCVx9930arAVItTsVFyBz8D8J9edP51jkT3G0F7nX8erYy6QUKqiNK162n09BafseFcWenC5KXxTKD8r1gt7k2ijl5+sm/nQKU8maCJP4ZvkWgaQYVnRbvLe+UGdiDd6urCjSvd40CBS3zGLvxScQwIcj1ShYCDW9kWOpmOq8aA8wXnHTbHwVpSBxsSH3N1iN5xkVY+m++fua8ddUdJiP3q3oH+AiJZFlsV2+WiDcmpTd8w7WRFJkbr4DdJ49vWj5sNWCavW1JByLV/rdzuI4ciUb9bFmfMz6iPrCfXksgJ4/kjP+jAFQ1MeDaikq268uq7vgZWkYB1zs0McIzUnJaf4350LaQF+xS5GI+9DfSdsUadMVDlDd9p0nv0p3IcNVOkQoetjMfDMeOoR/iRPpS1GQ/CiJIui/FD0UsbD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 15:42:29.5171
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b42a049-ace7-4f53-5efd-08ded5f50718
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026CA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9788

By setting the domain ID, pagetable mode, and IOMMU v1 page table in the
IOMMU Device Table Entry (DTE) indexed using the device ID of the
AMD IOMMU.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h       |  2 ++
 drivers/iommu/amd/amd_iommu_types.h |  1 +
 drivers/iommu/amd/iommu.c           | 23 +++++++++++++
 drivers/iommu/amd/viommu.c          | 51 +++++++++++++++++++++++++++--
 4 files changed, 75 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 269d0f448b9d..aaa57840e904 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -57,6 +57,8 @@ extern unsigned long amd_iommu_pgsize_bitmap;
 extern bool amd_iommu_hatdis;
 
 struct iommu_dev_data *amd_iommu_alloc_dev_data(struct amd_iommu *iommu, u16 devid);
+void amd_iommu_free_dev_data(struct amd_iommu *iommu,
+			     struct iommu_dev_data *dev_data);
 
 /* Protection domain ops */
 void amd_iommu_init_identity_domain(void);
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index a5e2f32590d1..340929ae776a 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -823,6 +823,7 @@ struct amd_iommu {
 	bool gid_ida_inited;
 
 	/* HW vIOMMU support */
+	struct iommu_dev_data *viommu_dev_data;
 	struct protection_domain *viommu_pdom;
 	void *viommu_priv_region[VIOMMU_PRIV_SUBREGION_CNT];
 };
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index b9063a7d6a6e..e5dc34959c6e 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -406,6 +406,29 @@ struct iommu_dev_data *amd_iommu_alloc_dev_data(struct amd_iommu *iommu, u16 dev
 	return dev_data;
 }
 
+void amd_iommu_free_dev_data(struct amd_iommu *iommu,
+			     struct iommu_dev_data *dev_data)
+{
+	struct amd_iommu_pci_seg *pci_seg = iommu->pci_seg;
+	struct llist_node *prev = NULL, *node;
+
+	if (!dev_data)
+		return;
+
+	for (node = pci_seg->dev_data_list.first; node;
+	     prev = node, node = node->next) {
+		if (node == &dev_data->dev_data_list) {
+			if (prev)
+				prev->next = node->next;
+			else
+				pci_seg->dev_data_list.first = node->next;
+			break;
+		}
+	}
+
+	kfree(dev_data);
+}
+
 struct iommu_dev_data *search_dev_data(struct amd_iommu *iommu, u16 devid)
 {
 	struct iommu_dev_data *dev_data;
diff --git a/drivers/iommu/amd/viommu.c b/drivers/iommu/amd/viommu.c
index c5c85e82c265..897355a143d6 100644
--- a/drivers/iommu/amd/viommu.c
+++ b/drivers/iommu/amd/viommu.c
@@ -71,8 +71,27 @@ static void __init amd_viommu_vf_vfcntl_unmap(struct amd_iommu *iommu)
 		release_mem_region(iommu->vf_base_phys, VIOMMU_VF_MMIO_MAP_SIZE);
 }
 
+static void viommu_free_self_dev_data(struct amd_iommu *iommu, bool clear_dte)
+{
+	struct iommu_dev_data *dev_data = iommu->viommu_dev_data;
+
+	if (!dev_data)
+		return;
+
+	if (clear_dte) {
+		struct dev_table_entry new = {};
+
+		amd_iommu_make_clear_dte(iommu, dev_data->devid, &new);
+		amd_iommu_update_dte(iommu, dev_data, &new);
+	}
+
+	amd_iommu_free_dev_data(iommu, dev_data);
+	iommu->viommu_dev_data = NULL;
+}
+
 void __init amd_viommu_uninit(struct amd_iommu *iommu)
 {
+	viommu_free_self_dev_data(iommu, true);
 	amd_viommu_gid_ida_fini(iommu);
 	amd_viommu_vf_vfcntl_unmap(iommu);
 }
@@ -303,21 +322,39 @@ u64 amd_viommu_get_vfmmio_addr(struct amd_iommu *iommu, u16 gid)
 }
 EXPORT_SYMBOL(amd_viommu_get_vfmmio_addr);
 
+static void set_dte_ipa(struct amd_iommu *iommu, struct dev_table_entry *new)
+{
+	struct pt_iommu_amdv1_hw_info pt_info;
+	struct protection_domain *pdom = iommu->viommu_pdom;
+
+	pt_iommu_amdv1_hw_info(&pdom->amdv1, &pt_info);
+	amd_iommu_set_dte_v1(iommu->viommu_dev_data, pdom, pdom->id, &pt_info, new);
+}
+
 int __init amd_viommu_init(struct amd_iommu *iommu)
 {
 	int ret;
+	bool dte_set = false;
+	struct dev_table_entry new = {};
 
 	if (!amd_iommu_viommu ||
 	    !check_feature(FEATURE_VIOMMU))
 		return 0;
 
+	iommu->viommu_dev_data = amd_iommu_alloc_dev_data(iommu, iommu->devid);
+	if (!iommu->viommu_dev_data) {
+		pr_err("%s: Failed to allocate dev_data\n", __func__);
+		return -ENOMEM;
+	}
+	iommu->viommu_dev_data->dev = &iommu->dev->dev;
+
 	ret = viommu_init_pci_vsc(iommu);
 	if (ret)
-		return ret;
+		goto err_dev_data;
 
 	ret = viommu_vf_vfcntl_init(iommu);
 	if (ret)
-		return ret;
+		goto err_dev_data;
 
 	amd_viommu_gid_ida_init(iommu);
 
@@ -325,5 +362,15 @@ int __init amd_viommu_init(struct amd_iommu *iommu)
 	if (ret)
 		return ret;
 
+	/* Set DTE for IOMMU device */
+	amd_iommu_make_clear_dte(iommu, iommu->devid, &new);
+	set_dte_ipa(iommu, &new);
+	amd_iommu_update_dte(iommu, iommu->viommu_dev_data, &new);
+	dte_set = true;
+
 	return 0;
+
+err_dev_data:
+	viommu_free_self_dev_data(iommu, dte_set);
+	return ret;
 }
-- 
2.34.1

