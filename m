Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918898F55
	for <iommu@lists.linux.dev>; Thu, 21 Sep 2023 09:32:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CjGYHSQNhZ4vAVkez4tedEPm+bqGveFEpW9LM9Rv8HI/aF0kPhst+5YzyvBnvSi8Z94+KErfrN0ouHA6seqtLtshmpfK0Wnjz5z07zbAJQ3HK2aKzfrN0Hj09jfYFAU33l53nVNPQiHM2zDXE4Q9w2D/RwHFXeaCziedVff9yAU1vVGWwm0zeeNRuhNXc3C6PBTbW+ETOVpNA1OK7CepLiIrEXcsmyOhxcLcHRs+1G9wcmjWiIXyheuuPyJZctwl2TlxNYBx98Iucd8UjEiz87OqmmSAOcjCII2YqFG84xCDNxxaDjaAoEE7wAkFgjpeMh92uSypiBaFSKwHXrNt+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HI4okd0/JjKeTQfxrDmciyE3Idl5K6uQzs0Cx1yzLfY=;
 b=Jkfd0KGWWeJmgA6cYYxXnxbY2sRT0uKtp/bZ7OJXvqTEIcYjZdhc3TatL0x9EG4kh0LZm7QVbkfpYM5d4FyshN02bUlWVW9JlsVAYIuCICef9GD50ZIKWTgx+Ovh4HfsKYsI8eyyS7hSCi2TNn7eOI/0SzIR8lx5cm0wXzJHKNDFuZUqg2wiyQUVs2gvfBoNJN9xtKf9NO8GccFNoNwMjGRq6bwA6YXjd97qk/znJdqt5dNhoJNiVa53vaoGBnqj3kwc6NznAKdFsrWWtms1IFCBY9a7TSeCYNNWShGVCKMnz+WPnSej5FF+XXsFZptwUeNwYvxzV9kOJyDt7qle8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HI4okd0/JjKeTQfxrDmciyE3Idl5K6uQzs0Cx1yzLfY=;
 b=eExiTGnnk/jL/HExpAhuP5OBg0i6GbqlSW7jHj9T3VJ0xxyGHRjJFat/DpTWwMDUPTB8wllcaQV9joI49kDcOjsparhNxnbR7vbnthU6n4T/kJEmqiug7rQq2ZAZzJ4bfV9a8aotBPD9P4qfwNtRs2ANeEUsl6nsbevNooV7PzQ=
Received: from DS7PR06CA0020.namprd06.prod.outlook.com (2603:10b6:8:2a::21) by
 PH7PR12MB6491.namprd12.prod.outlook.com (2603:10b6:510:1f4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Thu, 21 Sep
 2023 09:32:33 +0000
Received: from DS2PEPF0000343C.namprd02.prod.outlook.com
 (2603:10b6:8:2a:cafe::1b) by DS7PR06CA0020.outlook.office365.com
 (2603:10b6:8:2a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.31 via Frontend
 Transport; Thu, 21 Sep 2023 09:32:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343C.mail.protection.outlook.com (10.167.18.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.19 via Frontend Transport; Thu, 21 Sep 2023 09:32:32 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 21 Sep
 2023 04:32:29 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v3 2/5] iommu/amd: Remove PPR support
Date: Thu, 21 Sep 2023 09:31:37 +0000
Message-ID: <20230921093140.6162-3-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921093140.6162-1-vasant.hegde@amd.com>
References: <20230921093140.6162-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343C:EE_|PH7PR12MB6491:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b03f9a9-fcd6-4512-d040-08dbba85aea3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Vd86BpQYI3pldH7IeCqjwoC6XjbwbBH99G9vDj69/09n675OobOyLKr2QK2z0an+SuxY2ozJdJX6r37KqsZOmr/FrqWlnidVb5JfK99E7S99tExKkMfdvP2p5jEvYtzaWry4RqCOtOf01me89Bz54ZSDbEHT2yec7sfhRHDQxA+sMh7xqtPCLDteAhNhinZWAMMrKZcHGjQSe7OQ2K3bTH4ySYjKGbfGAoCelFzIvEPaKOeNWlorhTDVqlBBjrNtOF/e9pNwkwEeQZPZI2RE6qD4KUZUTW7om4sr2Y355AyXT/3/GnDd8Xi8wTOBK2JoWddROVak+yi/875LbXpPik2HlBwDBOCSrt6oFM1QdaKslGKG7IG9IJBh0glDJ6Xh5cP8DvRWOfKoMaYdHSij+MpPNurA2CrIYbUKYcUsb4ZL1goPfMEoblPDVklcHBQupHMtL5A5+7QLLAU/4vHfoUsGN7epHoIlwvGow5KF1P1ydffgwFKbjEj7awTOOEgOEh1GsLeFO9fd+LiHdxuGucpX+jYSlQeglgaOqQI2j2ZJULRB+UExJftrAR6ctvKSN96qK0DGkw2UNFIDv2cWz/qKKvgZMJINqW1ohiqUJcNEVBPr9xTOp3KbnZpoTK1eMkK7jftJNCilmBbnxdf5rCWl06W6fQFwy/19g4Bxy/OiBEHWC6Y/aBYw8ZkgHis+eaE55XB1TyOzV37zrdmMThBbciG9atjSo3Qk/ehRv7P/LgX7+z9PXWVfpOB/PLtr86wQDEV1zF7GIfawLHweMA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(39860400002)(396003)(346002)(1800799009)(451199024)(186009)(82310400011)(46966006)(36840700001)(40470700004)(2616005)(316002)(40460700003)(336012)(6666004)(1076003)(86362001)(7696005)(47076005)(70206006)(83380400001)(82740400003)(81166007)(16526019)(110136005)(41300700001)(36756003)(2906002)(8936002)(54906003)(40480700001)(4326008)(44832011)(5660300002)(26005)(356005)(8676002)(36860700001)(478600001)(426003)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 09:32:32.5663
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b03f9a9-fcd6-4512-d040-08dbba85aea3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6491

Remove PPR handler and notifier related functions as its not used
anymore. Note that we are retaining PPR interrupt handler support
as it will be re-used when we introduce IOPF support.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
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
index fd0d7b2f30dc..5abf181f5ecd 100644
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

