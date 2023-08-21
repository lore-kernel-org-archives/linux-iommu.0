Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2077.outbound.protection.outlook.com [40.107.102.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605294C6A
	for <iommu@lists.linux.dev>; Mon, 21 Aug 2023 10:51:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C/SUfGUpdgdrc50S/sh5DHsjMWt7yxBjySpy7V3Rwc364K3jswf1cFkjsq3GrkUBtbEErAqxLYc0elK/5PlksfR9VVsmlV4eJbL0FYRLt/1xBdTujQfbN+CjexPkPJVZQz24U6i1u5rEx8QEmvBjg8d2x29rTRjwPv1KZS3oMiAmLLZSCpRUH3d9qzJTdCo+eyG31qcMeNlec7x4hXLI/EhlgYXhBJwba5BbvM+1ImUtuOG3dEIg4z1TjT+bUx9itkRe6hGBr7OczuPCtWwg/2iJrzcvtCAxokZ/RdMQx3aiy6GVl3UwZxrzZFd+arqFzzJTs+TO7RrGRpuaKB1lfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NUhI8itvRcOn1/7h1LZwpQ94qzZKWyx7Y3pP5Ch0LMg=;
 b=bfuMsFvcjfWnrrC/Z5ePFInoWW0G/vn0UZBeWuhjjX/V2DjJy44z3jJ0BnqsrZ8lHlnJUCsvb3ss8UeIh0uB4/3inXGqTtag4nwqzO7VxsE5WncKbM1tS7VP9Zgprbv/itKfOx7oGLCQVFyJNSCfUaUCqmZLqdFVh3wRjbo0djYvoL4VP2QI8ZDMIIpNIT+B1DkFb+uyCVXN+9sP1OmTgqdavzIgYmt81nk/nO9p0QkzrCf1nA7Dhc3MQ83SKeICpDqBCOae3atPmpyCHaUMdPoQNjiGmdoYvbBPdeG460rPAiFO1wa7kGBKURnU8Gh74jiLP6ITQ8v61aHZYWbbEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NUhI8itvRcOn1/7h1LZwpQ94qzZKWyx7Y3pP5Ch0LMg=;
 b=VQ4OQ8vvmy9OaAxFbdv4xphoI0Y6lLzgPW8/b/TC9W3iGFNDqjdenIcazmIg5rW9Xg8IhyZA3cVFNcIyBD2jky/p3ycyaPfmopVboXWBBbb/v1yN+OsLjOa4OXNhTp3mw0GSsgeYxDfZUnqLxjOj+o0LjkJqg365ftWPRTR6dHA=
Received: from MW4PR04CA0069.namprd04.prod.outlook.com (2603:10b6:303:6b::14)
 by DM4PR12MB7669.namprd12.prod.outlook.com (2603:10b6:8:106::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Mon, 21 Aug
 2023 10:51:00 +0000
Received: from CO1PEPF000044F2.namprd05.prod.outlook.com
 (2603:10b6:303:6b:cafe::c0) by MW4PR04CA0069.outlook.office365.com
 (2603:10b6:303:6b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Mon, 21 Aug 2023 10:50:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F2.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Mon, 21 Aug 2023 10:50:59 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 21 Aug
 2023 05:50:56 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v2 2/5] iommu/amd: Remove PPR support
Date: Mon, 21 Aug 2023 10:49:53 +0000
Message-ID: <20230821104956.707235-3-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230821104956.707235-1-vasant.hegde@amd.com>
References: <20230821104956.707235-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F2:EE_|DM4PR12MB7669:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fde85c3-8af3-46b5-f3cf-08dba2348193
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JJgIqCuv7phYzi2l1cY2LJ6j3k5slBjiNwpkJGlSxjnc6MFa5/UsfGNwYAg1Q9kxgvtZFUX/JtC6qAfnCZXm1S/FzVr6dUvgiZb6+ThBBQOstQBiU7pg+99aSuQ8Z1VyA6rwOB8j2OAoxYWQevbeTvNySu0NqziyaGbA4YPhLYd69TD9Q9i+QMRqKXwU7DFC18f8Kwbc+D3xQYKTP6f3w/MV4Adqmq6A8NSbD//xQDFmJHDNYzwXw7/logmTj4mhmsMhH/Yv9ROnR9ucUQlYW9bpIeZHSrl3TEitcUlv6mJdFZdsiAvkZbXUovZOrnHE8+t06SgjJGemm/ELC9C2Ldbtubm7P64Yf/p0dGKX+H/jMrjLRukusV/rkdOnXEBtZ2pp/jjLMNfqvzmE7PzkAfYHasl0Lth3tAbhh5KJzio7nrZt4rHoqVHeVt057kR/e4QGT5DYXeY0UlhTU5jVmhVzbEXTqTU23IfJb10Ull+MGOaSkJ2xuguYwrL4L+s/C1qJgP2w0xGGiUKcL0bpnVYDyGRrUZl/DGmJCVzSFvPnLsaeaAku1LVfmn9T2NPsLiMKDFtxJJvoXycHl5WsZFprnKnFYjRzFlLMau8AnYFGGNxk+6XH6aHgrhcQgL3H598IVgEzGYd8q1W5EabSfsi3qHY4Xpaybtf/Pqq3LqsC4sbBxpF88reCk2i+YT+WLGfhbtEsQNLKMEkGDL5WS3EQ46btm3LsB43fUaf0sk5ejbHNg3NMwo2H+Sr//JHvIA+Y6dlC5xgLoZEhqmtjKg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(136003)(346002)(376002)(186009)(82310400011)(1800799009)(451199024)(46966006)(40470700004)(36840700001)(54906003)(70586007)(70206006)(316002)(110136005)(8676002)(2616005)(8936002)(4326008)(1076003)(36756003)(40460700003)(41300700001)(82740400003)(356005)(81166007)(478600001)(6666004)(7696005)(40480700001)(2906002)(83380400001)(86362001)(36860700001)(47076005)(44832011)(426003)(336012)(5660300002)(26005)(16526019)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 10:50:59.7294
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fde85c3-8af3-46b5-f3cf-08dba2348193
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7669

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
index de28a18f8d1d..8b586effbefc 100644
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

