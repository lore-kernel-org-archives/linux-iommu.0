Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528692D79D
	for <iommu@lists.linux.dev>; Fri,  9 Feb 2024 11:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707478357; cv=fail; b=MZHRN6D8niJl8rZqVfb80jD1Jo6w3E0+IlN64ng6GvnXgkjb7/z0Rjnr2oRF+QGkksfAKizROYfhgARBSbyJHqR4MO/K89p/cg2Kg96/xox9tr66IstaK5t+KQgp1TnLgNFe3I1maYWtM1pAi30NSawAAKMqkYt7V48dfjrgvaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707478357; c=relaxed/simple;
	bh=iLAfWn2tQkukcFWJVQmGuHkl5XUlMCBp7zUsbgFQSFM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XMlnnver8kIDTtS4FMJq1oO2Njwus1Pup7qDkFshL3P0i0VneCPUnVaEMuvAW2fZTzXg5CoAtWmtkxw5A2CB5qikP0CCnTE5vFxPymgMMXfmVaUEkOPjzHTNfgNzfIBoCybcGlN6x5TeIrtTxZa0GCcBHPK2Sy3Ob4LlKlMT2BE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BrOEMWyT; arc=fail smtp.client-ip=40.107.237.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BrOEMWyT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IdH2JrTYMwGchwdQXuRzN2GaNgRrvJ4312vu4I1zi4uUBtmtRKLPv3zlaS9jkvIbRqpmEDSCF8/K7Isr+77UupeAKcxSLmgPLnb9qGM8aMCV4oUqjFcnD9rzMzegtv24fJtDeF4O16DLaPoBCgdEBIf6flTKt4hpKy5fDEFboR71LGrKotP+o11f1Rg3v4YpxsTxefh8mxpctl95kpG7ZUJ/adTLOpfYvvv/bTiXV6IC0bAKE6EHbWSDiRrLOpKSarglF421+KkBzO6ffA06LdsDkRcMgIxj3TQiEZoFqC7TVaE95zQiMIndWfL24UWquRNeEKW9lzpaRVjI55IFkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QA0ecpV43ZnEMoYj15nMT0Yevq1T4jV+35G+0VGW+gc=;
 b=YEjtBzD+KI3AJvWrd0MuT6W01MrkfKbCjcKbeTjsQPNjfh1Q88AKPdlGV+C7ERWTkcfE/4k9jIN0ukdQbvnLC7sw/Z6r6ZSaAwovWajQ1Rx+mGSXnAs/ITK6ZFHVHVPaqWTTkcWMajuFgTsx+NeYhxg2cztCeOPG1tD3/hE3vIvKWdP5jLUvPfNNlQ/NOlKTEY0PuVY5vEe8lqWe7MYoey6/bXqkVj2zeApz6eoov1U2Ym1y+SWR6nIKGakIWf2AEFEyochGL5xGbv3fjuImDhfeRicHSbUsjtSnfzVZxI4KSvWIfJvSW2RezvLjdZ6+QZe+agTfdm82XTam79PH+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QA0ecpV43ZnEMoYj15nMT0Yevq1T4jV+35G+0VGW+gc=;
 b=BrOEMWyTZWiy27oil8UI5XHTxyHcrUOM9krq3TQZ7ZDF0z/tXdDl7BHPrmRYbgPEPTZLRFPUrRRhkBc0YVQPPZnGcybZCuTdNtpUeXxgIM2CsRNBRQXu1v+wxHJ6UsjsSMjeVivE3jIkymEo60TJsc6lWwQ3m5XrBtwxOXBw6OY=
Received: from DM6PR02CA0079.namprd02.prod.outlook.com (2603:10b6:5:1f4::20)
 by DM6PR12MB4059.namprd12.prod.outlook.com (2603:10b6:5:215::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.25; Fri, 9 Feb
 2024 11:32:27 +0000
Received: from CH1PEPF0000A34B.namprd04.prod.outlook.com
 (2603:10b6:5:1f4:cafe::c5) by DM6PR02CA0079.outlook.office365.com
 (2603:10b6:5:1f4::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.24 via Frontend
 Transport; Fri, 9 Feb 2024 11:32:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A34B.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Fri, 9 Feb 2024 11:32:27 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 9 Feb
 2024 05:32:24 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v6 09/15] iommu/amd: Define per-IOMMU iopf_queue
Date: Fri, 9 Feb 2024 11:29:24 +0000
Message-ID: <20240209112930.63663-10-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240209112930.63663-1-vasant.hegde@amd.com>
References: <20240209112930.63663-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34B:EE_|DM6PR12MB4059:EE_
X-MS-Office365-Filtering-Correlation-Id: 37bff51a-6a87-4835-202d-08dc2962cb69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hnHaQJP7xn/fbqxkB9g+yvWtBYgTL5pash8Qt3aXumpaGvs4uAPDEeRJrl5THef/OFx1uAac9UrNUKt0ciNbrgC+sGl9Atsypw5x+OqVPLDP0OQdF8uV2xi+aJtP2p9oujkoKOcNeKxw4dhsFeppBSd1q5tUtV20mEBnMPna85JQ9vCPlaJCeab6FLqI4IUZe4xpX469jYh8lpqzGg52Zi0ZevzF2cueDZ3OyxlJ0RlXuOANbPOZqs8ih3TEE53SSFiMij0+pi89l8EcadvSFSXnRqUwhRTn2c7JqS1nQKILdERkPk5hXZOGMtRx8CykYGzQ3RaCNh243w/vKx134cfqAt1Eife5+q1/Jw2qDPZ63sKkrbMSXaGMY5Gc1M7SkOw93ExoCan/CFkbWnKa7gkSC/pHf10fsbAWQE4U3+B+HBe+C683ooth5z1pyt1Npr6YndZvWG+qVR85I0bozI9hIyMHJbnwvDnISGgnIoVMxKTQgJKJKHGWglJ6bFykoLgPso1OQAYE+hvB2lyHYVxs3SUKZd5Vj1OmoNJ4atBhK6go0CxjRuXjufgPLj47HdgKzzWBtUrmZjbTLpItnObbHwLt+tzM4HlgJteP3ow=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(136003)(39860400002)(396003)(230922051799003)(1800799012)(451199024)(82310400011)(186009)(64100799003)(40470700004)(36840700001)(46966006)(41300700001)(2906002)(5660300002)(16526019)(336012)(1076003)(26005)(426003)(110136005)(44832011)(54906003)(70206006)(70586007)(316002)(2616005)(83380400001)(356005)(81166007)(86362001)(478600001)(7696005)(4326008)(8676002)(8936002)(82740400003)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 11:32:27.5341
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37bff51a-6a87-4835-202d-08dc2962cb69
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A34B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4059

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

AMD IOMMU hardware supports PCI Peripheral Paging Request (PPR) using
a PPR log, which is a circular buffer containing requests from downstream
end-point devices.

There is one PPR log per IOMMU instance. Therefore, allocate an iopf_queue
per IOMMU instance during driver initialization, and free the queue during
driver deinitialization.

Also rename enable_iommus_v2() -> enable_iommus_ppr() to reflect its
usage. And add amd_iommu_gt_ppr_supported() check before enabling PPR
log.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu.h       |  5 +++++
 drivers/iommu/amd/amd_iommu_types.h |  4 ++++
 drivers/iommu/amd/init.c            | 18 +++++++++++++++--
 drivers/iommu/amd/ppr.c             | 31 +++++++++++++++++++++++++++++
 4 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 54ec9affb1f4..f2084f90f056 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -45,6 +45,11 @@ extern enum io_pgtable_fmt amd_iommu_pgtable;
 extern int amd_iommu_gpt_level;
 
 bool amd_iommu_pasid_supported(void);
+
+/* IOPF */
+int amd_iommu_iopf_init(struct amd_iommu *iommu);
+void amd_iommu_iopf_uninit(struct amd_iommu *iommu);
+
 struct amd_iommu *get_amd_iommu(unsigned int idx);
 u8 amd_iommu_pc_get_max_banks(unsigned int idx);
 bool amd_iommu_pc_supported(void);
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 0abf590f6bc9..36586ff873da 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -770,6 +770,10 @@ struct amd_iommu {
 	/* DebugFS Info */
 	struct dentry *debugfs;
 #endif
+
+	/* IOPF support */
+	struct iopf_queue *iopf_queue;
+	unsigned char iopfq_name[32];
 };
 
 static inline struct amd_iommu *dev_to_amd_iommu(struct device *dev)
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index d25a706adcfc..d4fcb8c2b8ea 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1638,6 +1638,7 @@ static void __init free_iommu_one(struct amd_iommu *iommu)
 	amd_iommu_free_ppr_log(iommu);
 	free_ga_log(iommu);
 	iommu_unmap_mmio_space(iommu);
+	amd_iommu_iopf_uninit(iommu);
 }
 
 static void __init free_iommu_all(void)
@@ -2104,6 +2105,16 @@ static int __init iommu_init_pci(struct amd_iommu *iommu)
 	if (ret)
 		return ret;
 
+	/*
+	 * Allocate per IOMMU IOPF queue here so that in attach device path,
+	 * PRI capable device can be added to IOPF queue
+	 */
+	if (amd_iommu_gt_ppr_supported()) {
+		ret = amd_iommu_iopf_init(iommu);
+		if (ret)
+			return ret;
+	}
+
 	iommu_device_register(&iommu->iommu, &amd_iommu_ops, NULL);
 
 	return pci_enable_device(iommu->dev);
@@ -2789,10 +2800,13 @@ static void early_enable_iommus(void)
 	}
 }
 
-static void enable_iommus_v2(void)
+static void enable_iommus_ppr(void)
 {
 	struct amd_iommu *iommu;
 
+	if (!amd_iommu_gt_ppr_supported())
+		return;
+
 	for_each_iommu(iommu)
 		amd_iommu_enable_ppr_log(iommu);
 }
@@ -3130,7 +3144,7 @@ static int amd_iommu_enable_interrupts(void)
 	 * PPR and GA log interrupt for all IOMMUs.
 	 */
 	enable_iommus_vapic();
-	enable_iommus_v2();
+	enable_iommus_ppr();
 
 out:
 	return ret;
diff --git a/drivers/iommu/amd/ppr.c b/drivers/iommu/amd/ppr.c
index d43a616c0c36..39ea979c7134 100644
--- a/drivers/iommu/amd/ppr.c
+++ b/drivers/iommu/amd/ppr.c
@@ -106,3 +106,34 @@ void amd_iommu_poll_ppr_log(struct amd_iommu *iommu)
 		/* TODO: PPR Handler will be added when we add IOPF support */
 	}
 }
+
+/**************************************************************
+ *
+ * IOPF handling stuff
+ */
+
+/* Setup per-IOMMU IOPF queue if not exist. */
+int amd_iommu_iopf_init(struct amd_iommu *iommu)
+{
+	int ret = 0;
+
+	if (iommu->iopf_queue)
+		return ret;
+
+	snprintf(iommu->iopfq_name, sizeof(iommu->iopfq_name),
+		 "amdiommu-%#x-iopfq",
+		 PCI_SEG_DEVID_TO_SBDF(iommu->pci_seg->id, iommu->devid));
+
+	iommu->iopf_queue = iopf_queue_alloc(iommu->iopfq_name);
+	if (!iommu->iopf_queue)
+		ret = -ENOMEM;
+
+	return ret;
+}
+
+/* Destroy per-IOMMU IOPF queue if no longer needed. */
+void amd_iommu_iopf_uninit(struct amd_iommu *iommu)
+{
+	iopf_queue_free(iommu->iopf_queue);
+	iommu->iopf_queue = NULL;
+}
-- 
2.31.1

