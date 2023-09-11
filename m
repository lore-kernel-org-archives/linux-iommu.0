Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2052.outbound.protection.outlook.com [40.107.212.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9B1C8F8
	for <iommu@lists.linux.dev>; Mon, 11 Sep 2023 12:13:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dHVGsBq2NteYWWeoQ9/cIFDjzThSbNENt0w9fILtHHg3XLYb00ah51gfmj5/r8gns6Wl86v0luOOYz2NNLh5VohZOm5nsaQV2BD5qkBwduqLKHqe5Gdahgs1LyzsQp/Zal+w9fPnd396YnXblAOBtIQqKkmblnZNrSdzF4aCqIRnrsEJi+fYEKDIIwfhxC8p7/9mqdRYbTR7yZbZR4hxKlldbkoakOzGuQ9+voeNbTYRllX9A6p1XMmv0vuMqD+Px9Ak6bU2fn3KXqH3wAEAidTeeWGdSyJ3gHZ3EwYmVzXgJAvgSD2YU3/HIoh275eZURsein5XwyOJjd4hSTj20A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nnSqBBWCjIpj3tUavCOFP/PYzszWgT5wLPNR4/pA8tM=;
 b=nbgBgTuew7VGG5gWezjocejCMvl46BxUKSoYMLI5rriCyY4lRdzx++28e9l7yzhtWa7cMboKyxWamsVuSooqz1HsxK9qR9fClBjdKspBdAsoHvnYrFTWYZCT9H5IlFTMAQ2W963pvj3ss7zNDIKjzf/tFAPYcH5Oxk/EuUeNoU/o8i+lXPSCYXOe/tcO0njINZnDnVSkq/pZZIvm5eFBBbjITa5EE1uf8tPRtQkyp1wuYy9k4iQo01E2GyA1F/PQ3vwdTN7ZUiHMB/ZBLTRO38PkGIZw417jz+qS0NpBTS/ka5+ElteJGPKBmsyU//Xag+38NZXhtTAbEGPsIAQH+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nnSqBBWCjIpj3tUavCOFP/PYzszWgT5wLPNR4/pA8tM=;
 b=g1fFufF2sHeFBfSrahWopbq4y/UK+L/8jOPfefmFlJqrkv+USB3oNNbYsEJQNVyLXvV9e8+LsU76vj7xrRWgM/i0I8cgjRT+gzRAH8/1qfubEZk86S/OfyryYyIhuQSOCQbeeQcLcVSLfBjJAxTObOdnQR6jZlodV8IsB3XAk18=
Received: from SA0PR11CA0016.namprd11.prod.outlook.com (2603:10b6:806:d3::21)
 by CH3PR12MB9219.namprd12.prod.outlook.com (2603:10b6:610:197::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.34; Mon, 11 Sep
 2023 12:13:27 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:806:d3:cafe::8a) by SA0PR11CA0016.outlook.office365.com
 (2603:10b6:806:d3::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.34 via Frontend
 Transport; Mon, 11 Sep 2023 12:13:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.17 via Frontend Transport; Mon, 11 Sep 2023 12:13:27 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 11 Sep
 2023 07:13:24 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v2 07/11] iommu/amd: Define per-IOMMU iopf_queue
Date: Mon, 11 Sep 2023 12:10:42 +0000
Message-ID: <20230911121046.1025732-8-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230911121046.1025732-1-vasant.hegde@amd.com>
References: <20230911121046.1025732-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|CH3PR12MB9219:EE_
X-MS-Office365-Filtering-Correlation-Id: 945c998f-ea07-4597-a2c9-08dbb2c0812f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	r60Yhdw5KSKgtn1FY1VtMcHn4hAfsmKNvkQhsgnnPRViFFc2RZgdc2OHgzXZyypQq5TbLlntapA82oyms1fGSsfgVeK3YGLJsdCuGr/EGVuwVFQKSXEb7n8hqC9+iLmDMtTZVgx+YC5V1n4Zf7sWIXSA46VXcdPwlVlwFd1Q4hUWlsoOWnknHXes1HJD0qjePuxCp2GD/HvYuXqjzbFC7JgxDS6xwklZ9rPXvb8oAqX/nu1xlx1P/IXUJ3Tl2F/SM7ZrGuBJ9o35Y8yIjf/2HFaUP07QXTaNnxEt/GRHS5iadPpoT7VZAmOI0uQczpkCwptlmbtxM3gUjFq19sn3utY4ukhVAhxt1I+wlMtDtWhctmxqVCRya/oDbYGZFtIGSv0xZY1ErBwCiv6s9mwxO/jR++Ewlb/leSCLhL4uaUIMtiWLTumbV4Ofmpj7rbF/owfmtLn9el1HRiYJlKiVsOiOG7gJaqItt/bvUC2ptmmp71IKzDFMtXaYqG9whN0bd/IjIw1kM0pHUCUK98K+/UXEk7PwveDGKSYXDUPJLWtlKW90xXs3KsOq8440vk3qOpDIXie3ka5ujEVPtMVIusF8sN8PEtWmuFhXUjl5Mvo5yHaxyL0pOFW7zXxDi6qhXfAuTPxWceFZjd3f5GeS2+Du3YZnOUKE9KX7zL2fSIyg5oz71zCncp/ddQ0K8SwkpmK2jAHX+++Ze5V3Z6coMm3DXY0j9mMtIFN5X6E3NLVJEKmmg18naQOz77cyKlQ7rdv/gkqLWCLM4N3eZgP4ig==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(376002)(396003)(346002)(82310400011)(451199024)(186009)(1800799009)(46966006)(36840700001)(40470700004)(8676002)(2906002)(4326008)(44832011)(8936002)(41300700001)(5660300002)(54906003)(70586007)(70206006)(110136005)(316002)(40460700003)(478600001)(6666004)(7696005)(2616005)(16526019)(47076005)(426003)(336012)(26005)(83380400001)(36756003)(1076003)(36860700001)(40480700001)(86362001)(81166007)(356005)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 12:13:27.3279
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 945c998f-ea07-4597-a2c9-08dbb2c0812f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9219

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

AMD IOMMU hardware supports PCI Peripheral Paging Request (PPR) using
a PPR log, which is a circular buffer containing requests from downstream
end-point devices.

There is one PPR log per IOMMU instance. Therefore, allocate an iopf_queue
per IOMMU instance during driver initialization, and free the queue during
driver deinitialization.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu.h       |  4 +++
 drivers/iommu/amd/amd_iommu_types.h |  4 +++
 drivers/iommu/amd/init.c            |  5 ++++
 drivers/iommu/amd/ppr.c             | 42 +++++++++++++++++++++++++++++
 4 files changed, 55 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index f7ec33a81fc1..a85503259727 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -52,6 +52,10 @@ void amd_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid);
 int amd_iommu_gcr3_init(struct iommu_dev_data *dev_data, int pasids);
 void amd_iommu_gcr3_uninit(struct iommu_dev_data *dev_data);
 
+/* IOPF */
+int amd_iommu_iopf_init(struct amd_iommu *iommu);
+void amd_iommu_iopf_uninit(struct amd_iommu *iommu);
+
 struct amd_iommu *get_amd_iommu(unsigned int idx);
 u8 amd_iommu_pc_get_max_banks(unsigned int idx);
 bool amd_iommu_pc_supported(void);
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index c866fbfa0dd8..56b6fdc89c99 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -773,6 +773,10 @@ struct amd_iommu {
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
index a20a7f998ecd..302e964b1eff 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1638,6 +1638,7 @@ static void __init free_iommu_one(struct amd_iommu *iommu)
 	amd_iommu_free_ppr_log(iommu);
 	free_ga_log(iommu);
 	iommu_unmap_mmio_space(iommu);
+	amd_iommu_iopf_uninit(iommu);
 }
 
 static void __init free_iommu_all(void)
@@ -2791,9 +2792,13 @@ static void enable_iommus_v2(void)
 {
 	struct amd_iommu *iommu;
 
+	if (!amd_iommu_gt_ppr_supported())
+		return;
+
 	for_each_iommu(iommu) {
 		amd_iommu_enable_ppr_log(iommu);
 		iommu_enable_gt(iommu);
+		amd_iommu_iopf_init(iommu);
 	}
 }
 
diff --git a/drivers/iommu/amd/ppr.c b/drivers/iommu/amd/ppr.c
index 673fcc30f9dc..9816d7dbcbf0 100644
--- a/drivers/iommu/amd/ppr.c
+++ b/drivers/iommu/amd/ppr.c
@@ -110,3 +110,45 @@ void amd_iommu_poll_ppr_log(struct amd_iommu *iommu)
 		tail = readl(iommu->mmio_base + MMIO_PPR_TAIL_OFFSET);
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
+	unsigned long flags;
+	int ret = 0;
+
+	raw_spin_lock_irqsave(&iommu->lock, flags);
+
+	if (iommu->iopf_queue)
+		goto out;
+
+	snprintf(iommu->iopfq_name, sizeof(iommu->iopfq_name),
+		 "amdiommu-%#x-iopfq",
+		 PCI_SEG_DEVID_TO_SBDF(iommu->pci_seg->id, iommu->devid));
+
+	iommu->iopf_queue = iopf_queue_alloc(iommu->iopfq_name);
+	if (!iommu->iopf_queue)
+		ret = -ENOMEM;
+
+out:
+	raw_spin_unlock_irqrestore(&iommu->lock, flags);
+	return ret;
+}
+
+/* Destroy per-IOMMU IOPF queue if no longer needed. */
+void amd_iommu_iopf_uninit(struct amd_iommu *iommu)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&iommu->lock, flags);
+
+	iopf_queue_free(iommu->iopf_queue);
+	iommu->iopf_queue = NULL;
+
+	raw_spin_unlock_irqrestore(&iommu->lock, flags);
+}
-- 
2.31.1

