Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637E23C1D
	for <iommu@lists.linux.dev>; Tue, 15 Aug 2023 10:34:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cbsl1PntI5Ai50Z4DL6WnqkFkeHseLFvpDYxdbbCvw6oX/HTED9pniFR98wMsftL5CauoZvc7djPvpYQa2miGwkc875NOx/jdbSvSmzdz9c8oYeJPZz/QRDjQlS4iSGhUG4h8jFxdngY5K5MOngi76ORPdHpb0Dcb0naKXV3IvPolafo2jzveHxrOvc9L9LHTEkBO1g6NAVbWKgcHPmzeGG0pWmnWFupBE5IQjWyEt9c2Mz62gVE87l66Z0EFBb9iXC3d+rQOD6gOJ7r/Uq0hv+CR2lKVMlypHMdnj0VmXBWh6mKBkyi0CZUcBmPg9ouzwvcbyjKsytS1OfnKVSFVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Shzbk2z0vmp/4WqsbcY6tg9rYpdoLqQ0j5J2xbIHYME=;
 b=fZpB6muCkFudGs1lzYZlp0smaxWGFvXSQbfwa8iVaqOrVFRPmZHoRs8Rq3CEZdKGXBYamD8MjSKFVLluCTzAhtJodAXRhq9CMjmmOWb+TqKj1GSg0bs7bpKbuOu2+8UBK3nIZ9s7JzHp2Aaps5REMYXlTGcoagNjcx5K+0efEAdATmO8EkkVkymGqF3+i+gCPQpCiTIgUFzBgjbVeLWmrZzcMZU12lQLTb26vbSLFUYa+hfK3ScYpRTRMgo6oIRYvG/tSkaGQ2oXc62S/Xk52GZSrSLKLYoSzu1mp0xxobPPRPFwFa5LwNWO440ld1MI7vIEfb5ndce1D8IT7EyDiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Shzbk2z0vmp/4WqsbcY6tg9rYpdoLqQ0j5J2xbIHYME=;
 b=1r2a+QFieMAy/AjOgql4uDwpET8OtefGQCh4ysw03HPkqWyshU0KLZ4+Q1OruSAFlbG+12AY57Bm+IO5xdbUkCxwYTGpoPNgF06bdevbo6jfAdZvddlZzHcJdb1TSJUAncBa3MaO6PJCbLdSBd7qkTRbpKpO9TJiY765UBTwWvc=
Received: from DM6PR06CA0074.namprd06.prod.outlook.com (2603:10b6:5:336::7) by
 MN2PR12MB4190.namprd12.prod.outlook.com (2603:10b6:208:1dd::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 10:34:08 +0000
Received: from CY4PEPF0000EDD3.namprd03.prod.outlook.com
 (2603:10b6:5:336:cafe::ff) by DM6PR06CA0074.outlook.office365.com
 (2603:10b6:5:336::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Tue, 15 Aug 2023 10:34:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD3.mail.protection.outlook.com (10.167.241.207) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Tue, 15 Aug 2023 10:34:08 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 15 Aug
 2023 05:34:04 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 2/4] iommu/amd: Remove PPR support
Date: Tue, 15 Aug 2023 10:32:53 +0000
Message-ID: <20230815103255.565295-3-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230815103255.565295-1-vasant.hegde@amd.com>
References: <20230815103255.565295-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD3:EE_|MN2PR12MB4190:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d4a0c73-974d-4eb6-a4a2-08db9d7b281d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CuAiSFVNv6o41jFgnp96rs0jO/jCgfxDMeKN7KVioVFYxKm43cMYcCeFnIGg4AFlxOZh0RQCxMYIKNiD08FM4Efkp27gf4Lwgn5eaob7QZ1v0jynqaWLoySXb3e15gCTBnztBMDxOuQ4R0j7Qt9uJ/zz177U8/0C6laDfEk0nI3Po//UQ10I/6eishv1cl7JegDy6Oy2y7ULcqbjr/0CHaN7C/iKd5GZkg3hxIBWEBH3zDLVL0N3pu9CTg9aRq6+00bt60aScHFJ532Nm8NfleDxpXl/6cW9PHR2rvZOCFCaPvcU8lHprY+FNgxufT3w9AHDAFZAM7hdLeUQ7mz5EMYg7XAiWYdXpOrKBQ9/SfNW2DWs+XZZ4v6AT6TCtZ3V0scdVgG42IUq7ieWcGefglzK4bHgRwYk5NNsr7E5K6Ne32phsLywigVkIeOyoy5WTpWx5hTE/KSLBdrsLE8PfY+e2D2zFBKEurmIfGNU5y47bigqucLW8NirLUzQcG7nMxsivaJxtgKTxEe9FjJD/UZEhg8xcX1BvepzhLYBe/b+cBG4No2Pu7T6blQx7vorjB2t6EJvkEyMIrAwcb9nCzgLA2A9LKkaWtHDJKjwhClU3dprZsT0NjyAMJSNPSy+qieCeQRkS4UMwVxphcvlvFb1vP2aM3iDO32t1Rz5NPWEmtcmp582jmraMWwperyFZs+ujS0f7K/Rw9GToeZdHIa6bmzzYnCziolXB0B23pBUeFF5RCl23XOhkRrqkDufOvmF7Gka6ZwoY2gAlvGvcA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(346002)(396003)(376002)(451199021)(82310400008)(186006)(1800799006)(46966006)(40470700004)(36840700001)(40460700003)(336012)(426003)(16526019)(1076003)(26005)(83380400001)(36860700001)(47076005)(7696005)(41300700001)(54906003)(2616005)(70206006)(70586007)(316002)(5660300002)(44832011)(8676002)(8936002)(4326008)(2906002)(6666004)(110136005)(478600001)(40480700001)(356005)(81166007)(82740400003)(86362001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 10:34:08.1532
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d4a0c73-974d-4eb6-a4a2-08db9d7b281d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4190

Remove PPR handler and notifier related functions as its not used
anymore. Note that we are retaining PPR interrupt handler support
as it will be re-used when we introduce IOPF support.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu.h       |  2 --
 drivers/iommu/amd/amd_iommu_types.h | 13 ---------
 drivers/iommu/amd/iommu.c           | 45 +----------------------------
 3 files changed, 1 insertion(+), 59 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 1b8295db60e7..eb910fd348ef 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -55,8 +55,6 @@ int amd_iommu_pc_set_reg(struct amd_iommu *iommu, u8 bank, u8 cntr,
 int amd_iommu_pdev_enable_cap_pri(struct pci_dev *pdev);
 void amd_iommu_pdev_disable_cap_pri(struct pci_dev *pdev);
 
-int amd_iommu_register_ppr_notifier(struct notifier_block *nb);
-int amd_iommu_unregister_ppr_notifier(struct notifier_block *nb);
 int amd_iommu_flush_page(struct iommu_domain *dom, u32 pasid, u64 address);
 void amd_iommu_update_and_flush_device_table(struct protection_domain *domain);
 void amd_iommu_domain_update(struct protection_domain *domain);
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index a94a0a231b33..730fd254c12e 100644
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
index 9bd0c66ad881..2becbd0529cd 100644
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
@@ -2545,29 +2525,6 @@ const struct iommu_ops amd_iommu_ops = {
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

