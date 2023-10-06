Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2088.outbound.protection.outlook.com [40.107.101.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411F1125B3
	for <iommu@lists.linux.dev>; Fri,  6 Oct 2023 09:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aBm0eBMR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b1LDdh/xBQVcc3E2c8o0EUH8lIM7tneOHDUfZN2I3Gxu4AaR5qwrToTkRQaiQngmNOgbAcjX7fXcAEY6QZORJcIUp4fBpjeQv0m+PuYv+N1B8B2aI1eIoZ5jGBTIHBcVVNazLoUEXmV3auzNqWU2+BVT0aXzjZe8HdBBprmUEsG7P6hwy1pM+bTXmIbWS16oOARia2l41UqGSf3Ef5vErQSgecjBRxu55nm/c7Vc2wXgsmF6nINyepcPUVbpXuX7ZD+OOu9Su54ckeySUvJUZ9fe1QpTMnE8PPN4obLI3XV514eNgCairG8PlyOu1CTWNJPR3zEZz/iUQJfOD82OUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XAuEXsLn3UNyllXuv8ydj+EbMnlHSdPRpgFQ/DWSBYQ=;
 b=hCkI5l15MshMhSnsIkT3AEHz5R3oa0Dy+dPTeG4RaZDAqjvHOVYBk0ZwyScKtV+RKz6g3UeeKac6OZ7/rYNNBLOPwQsY0xEJULpDJ/iTkUoPrpqN58aYUkbdsN3rO4yT7xK8yeLGWnu9KfAuw9eCrcE3QG+6NNdKOEuknEam2kseZA3JzpUkfKDuhIyqdvYw0D2QpxtratA++cwOenBwj8PhR0X1B7M7NoFy7quFVSosjRpMFa0K0w5FwOfdCqtqde92ioM18mxMHTSh/MuN8ckMhn8o8foeddquPLpYDztmC1ig33pnYaWsVyuBSkDL6YLt/UJVm6gC6qQxTLkmoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XAuEXsLn3UNyllXuv8ydj+EbMnlHSdPRpgFQ/DWSBYQ=;
 b=aBm0eBMRH9upEqP9JYvkGeqvchjZFXlH9OEuL9dde4w0hrGJNbbI41lkJsel3p5G+LgWYNmg6VxY492c2xTQjis8JdBmn8nQfV3+AN2mdeE41OGHahozAoG8iYlqnq+ZXKtoatyaNYnmuUJOH5qLqZiO3QC6yDL7FdmNvRuyHqE=
Received: from CH2PR10CA0017.namprd10.prod.outlook.com (2603:10b6:610:4c::27)
 by DM4PR12MB7501.namprd12.prod.outlook.com (2603:10b6:8:113::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.35; Fri, 6 Oct
 2023 09:58:09 +0000
Received: from DS2PEPF00003444.namprd04.prod.outlook.com
 (2603:10b6:610:4c:cafe::93) by CH2PR10CA0017.outlook.office365.com
 (2603:10b6:610:4c::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.36 via Frontend
 Transport; Fri, 6 Oct 2023 09:58:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003444.mail.protection.outlook.com (10.167.17.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Fri, 6 Oct 2023 09:58:08 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 6 Oct
 2023 04:58:05 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v4 2/5] iommu/amd: Remove PPR support
Date: Fri, 6 Oct 2023 09:57:03 +0000
Message-ID: <20231006095706.5694-3-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231006095706.5694-1-vasant.hegde@amd.com>
References: <20231006095706.5694-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003444:EE_|DM4PR12MB7501:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c2bf07c-87a9-4a5e-6c08-08dbc652be7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yBPDqSCx7UnbQcQiKCA0jWXCyetouzd99Xi8sGU1WwkhuahWND03sh1DUMSJgY91YHgCcQlRoMuSpacPGDY0/T6t5D758vmSPg+D/QGJb6hmW+HER9k3inp2cE320GhmtEbdzPYs062bsOzaIcXqf6xxvk/Y1+Wuw6FJ5guq4MCpVIH0FZVwI15NODQeXMSEc2ZKGXZ1ibcxInnRZ2H6QzN6FlICG93GQU3FzVFCqz60wIvdctP8chmRD5/3z9tFzYnG4hkCVlyqjlcDGaSBuHu39rcuZdRnceLaAvPdEw9+yh/wlLss8eWLNEbYYZvmAfZaqtm8NbtcKLtOzq40mIoAJ6lnjmmrcWNO1wuJgu7aATVCN5dWsGXQVFvv8ztGCzo2mZfhwTDLa+yF7gVqwHc7b+e2OxjmeIADQvRFUR2nAdn5q8zMT8IMifc6srnuAbhBy9TRu9k8yK8v+QW62P+kfJyv3WktbcNvTAm/fzdESeKRHI8X/0NR8ImXKXilyAVfqmFy8p/hIW9z9bqSvbOCamyMMT2EueiVpceCwGV7EQOuOnfPgN9U5Cu2TzSF471O5rI71ICOyToIwtxKSs6+wBH92dvMOSTwOKeK1AF3TJ7HFZ6DkiCpNMNr9hqNq9dvl4oVRd/zipuCdnAp4lgRqzkPAqAu7V1PzUQg4yVX9r9KDoFgXS1aMHAJueuMxgcGYZYfgelk2Jb+ivEnRRlQ8oAgAq6AaF8azP0PnLaxvndp/pZZD7L048QD+vKHGDWMVMRm4qUbFjRV3L73AA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(136003)(39860400002)(376002)(230922051799003)(186009)(451199024)(82310400011)(1800799009)(64100799003)(36840700001)(46966006)(40470700004)(1076003)(426003)(47076005)(7696005)(478600001)(26005)(16526019)(2616005)(41300700001)(2906002)(5660300002)(44832011)(70206006)(4326008)(8936002)(70586007)(8676002)(54906003)(316002)(36756003)(110136005)(36860700001)(81166007)(82740400003)(356005)(86362001)(336012)(83380400001)(40480700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 09:58:08.7275
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c2bf07c-87a9-4a5e-6c08-08dbc652be7a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003444.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7501

Remove PPR handler and notifier related functions as its not used
anymore. Note that we are retaining PPR interrupt handler support
as it will be re-used when we introduce IOPF support.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
Tested-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/iommu/amd/amd_iommu.h       |  2 --
 drivers/iommu/amd/amd_iommu_types.h | 13 ---------
 drivers/iommu/amd/iommu.c           | 45 +----------------------------
 3 files changed, 1 insertion(+), 59 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 5b8a1e2dd3d0..86be1edd50ee 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -52,8 +52,6 @@ int amd_iommu_pc_set_reg(struct amd_iommu *iommu, u8 bank, u8 cntr,
 int amd_iommu_pdev_enable_cap_pri(struct pci_dev *pdev);
 void amd_iommu_pdev_disable_cap_pri(struct pci_dev *pdev);
 
-int amd_iommu_register_ppr_notifier(struct notifier_block *nb);
-int amd_iommu_unregister_ppr_notifier(struct notifier_block *nb);
 int amd_iommu_flush_page(struct iommu_domain *dom, u32 pasid, u64 address);
 void amd_iommu_update_and_flush_device_table(struct protection_domain *domain);
 void amd_iommu_domain_update(struct protection_domain *domain);
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 5be563d55ad6..25b731f3d984 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -509,19 +509,6 @@ extern struct kmem_cache *amd_iommu_irq_cache;
 #define APERTURE_RANGE_INDEX(a)	((a) >> APERTURE_RANGE_SHIFT)
 #define APERTURE_PAGE_INDEX(a)	(((a) >> 21) & 0x3fULL)
 
-/*
- * This struct is used to pass information about
- * incoming PPR faults around.
- */
-struct amd_iommu_fault {
-	u64 address;    /* IO virtual address of the fault*/
-	u32 pasid;      /* Address space identifier */
-	u32 sbdf;	/* Originating PCI device id */
-	u16 tag;        /* PPR tag */
-	u16 flags;      /* Fault flags */
-
-};
-
 
 struct amd_iommu;
 struct iommu_domain;
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index e78bd3bb8f9c..790e10207afb 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -64,7 +64,6 @@ LIST_HEAD(acpihid_map);
 
 const struct iommu_ops amd_iommu_ops;
 
-static ATOMIC_NOTIFIER_HEAD(ppr_notifier);
 int amd_iommu_max_glx_val = -1;
 
 /*
@@ -815,24 +814,6 @@ static void iommu_poll_events(struct amd_iommu *iommu)
 	writel(head, iommu->mmio_base + MMIO_EVT_HEAD_OFFSET);
 }
 
-static void iommu_handle_ppr_entry(struct amd_iommu *iommu, u64 *raw)
-{
-	struct amd_iommu_fault fault;
-
-	if (PPR_REQ_TYPE(raw[0]) != PPR_REQ_FAULT) {
-		pr_err_ratelimited("Unknown PPR request received\n");
-		return;
-	}
-
-	fault.address   = raw[1];
-	fault.pasid     = PPR_PASID(raw[0]);
-	fault.sbdf      = PCI_SEG_DEVID_TO_SBDF(iommu->pci_seg->id, PPR_DEVID(raw[0]));
-	fault.tag       = PPR_TAG(raw[0]);
-	fault.flags     = PPR_FLAGS(raw[0]);
-
-	atomic_notifier_call_chain(&ppr_notifier, 0, &fault);
-}
-
 static void iommu_poll_ppr_log(struct amd_iommu *iommu)
 {
 	u32 head, tail;
@@ -878,8 +859,7 @@ static void iommu_poll_ppr_log(struct amd_iommu *iommu)
 		head = (head + PPR_ENTRY_SIZE) % PPR_LOG_SIZE;
 		writel(head, iommu->mmio_base + MMIO_PPR_HEAD_OFFSET);
 
-		/* Handle PPR entry */
-		iommu_handle_ppr_entry(iommu, entry);
+		/* TODO: PPR Handler will be added when we add IOPF support */
 
 		/* Refresh ring-buffer information */
 		head = readl(iommu->mmio_base + MMIO_PPR_HEAD_OFFSET);
@@ -2546,29 +2526,6 @@ const struct iommu_ops amd_iommu_ops = {
 	}
 };
 
-/*****************************************************************************
- *
- * The next functions do a basic initialization of IOMMU for pass through
- * mode
- *
- * In passthrough mode the IOMMU is initialized and enabled but not used for
- * DMA-API translation.
- *
- *****************************************************************************/
-
-/* IOMMUv2 specific functions */
-int amd_iommu_register_ppr_notifier(struct notifier_block *nb)
-{
-	return atomic_notifier_chain_register(&ppr_notifier, nb);
-}
-EXPORT_SYMBOL(amd_iommu_register_ppr_notifier);
-
-int amd_iommu_unregister_ppr_notifier(struct notifier_block *nb)
-{
-	return atomic_notifier_chain_unregister(&ppr_notifier, nb);
-}
-EXPORT_SYMBOL(amd_iommu_unregister_ppr_notifier);
-
 static int __flush_pasid(struct protection_domain *domain, u32 pasid,
 			 u64 address, bool size)
 {
-- 
2.31.1

