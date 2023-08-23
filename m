Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F38C131
	for <iommu@lists.linux.dev>; Wed, 23 Aug 2023 14:06:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=edffwCQ5OuyOx+RTe2aoBzqq92DrC0FXMUh9uEaQmXgbw6hDouUmFPou9MbtSk/rou3zVR9BOzQ1tyJt/vIHdGoJIIgGqQQBnytzAfdKzGMqL+YRwseWDPCEjJRxNuyo2VBUAeW2mXcZrxDwxBYMOd451VKkbgmM2mxOJ/aZWfK23e17y4uJhViAiRqaWJ4ZGev4komwEJcuLz+TMeVMefpopeuNAbEwEMHg0/hDdjN5QLGsZmZzfkUvzbSxnl/o17OmSCmg0Gi0kqBWoMFDd9SCHS0Li4/DkD2XmjCKvqkKUO9EnD6h1QPxzbPzqTrRCPOqzosVsmGJyJ5e+ib/RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rH8c5N/1vmHcoKN7LY1wGRvqBPGMLNFEIGuJZEF9U20=;
 b=jt4SwtEb84UE6do/9VrsXHC+GMlGpCq2HTPaQVKMWCVEaGie8AAa4G3Ium25VGSemg9f2pVkRiuQVyG0WR8JM/pRjaxgcOypO82sD4cJgg/eL/+zl9gtMnZGVjG+0oTy8pLS3+50bRcedWt+F/TQoNt1Xa+TvAYEKsdW6fbfNnallkVEAjV+B2T62VNlefF+NaZYw4EkN16sNbiwLYOio0YgB/uKkaCcSSrkS0jqSfGyZn+IgMB5McZaaXf2J8E/pQ1F/lo2a6OGHXlfBu4z/SRe++ZRTAwq0MERg/a5bFjkmUGrLTStU4XMWG6Mtb0YV41HjF6OBOEJjo+JZxld+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rH8c5N/1vmHcoKN7LY1wGRvqBPGMLNFEIGuJZEF9U20=;
 b=GaY3ert940/Bu39JrR58t1UNGkJuhtGoIbZ+UjcpFXC0FBnhtJJs5z5MlkU+3Za8MDQCKUN5e8jSXfONj5cyPHXip47oSqkER1MvFwaxOKNfwtjwYCywjG6Bv9Gf/j+ERkhaHV6j4YJWCBBdfmbXaiE7M5qh7AVr/R3d5BIJN7I=
Received: from MW4PR04CA0146.namprd04.prod.outlook.com (2603:10b6:303:84::31)
 by IA0PR12MB7553.namprd12.prod.outlook.com (2603:10b6:208:43f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26; Wed, 23 Aug
 2023 14:06:27 +0000
Received: from CO1PEPF000042AA.namprd03.prod.outlook.com
 (2603:10b6:303:84:cafe::13) by MW4PR04CA0146.outlook.office365.com
 (2603:10b6:303:84::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26 via Frontend
 Transport; Wed, 23 Aug 2023 14:06:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AA.mail.protection.outlook.com (10.167.243.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Wed, 23 Aug 2023 14:06:26 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 09:06:23 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH RESEND 06/10] iommu/amd: Define per-IOMMU iopf_queue
Date: Wed, 23 Aug 2023 14:04:11 +0000
Message-ID: <20230823140415.729050-7-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823140415.729050-1-vasant.hegde@amd.com>
References: <20230823140415.729050-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AA:EE_|IA0PR12MB7553:EE_
X-MS-Office365-Filtering-Correlation-Id: 08236a6f-d306-46e5-9a3d-08dba3e22459
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ktMeCanQyxPSsiBtNaSD2KR4lOz0jff8ZKcrGD0sn3SnenV5fsCkzrHZAwKx81njPi4t3hGV6lwjaxpGpQOuBbKR+uVKQAJLfrIYQ+qeZNE57VJCxoNPZrlMwzt86L5au40S0NtC8Jv4EYH7043pIX1+TME4wZbZbKNw7P2PQAfrAidW4lJK855NjiWsVMRlxTZFsDA7/UqSVLGYT75i5D15uPPevbKNdn6Yc3whF0lsUjJQ0ucqAE8gXBZsKl3VWKxi8HNm12j50Vn/wptyqv6abeh4QG/MIJuG0sU8sTNUt08H6dRsKJvH/10CSZEFzxc55LrWy/JPuxmnIa0TE4+KYa//0MxCLIproEiLzdF5IOIuigBCUZWghTR7900Q7qV3U8hIEapa57KobZ8w5C5Hv+vq9I8upXlQkky3/SoG8xcZzui3dDUPx5NzXMqFp1gxCBTi/7pk53DRT6/9FDX9vaeRBbysb10YAMHSrTO7pZd9zOG9scot56FRJ91gDO21koK9KezYLvYGggnenyk+E6RYGszP/ZL3A/ys8wGbZiQKqdj8w6vb+16A7hPDKtTWARDrFQldw6CwPPI5oZXHkq7XeSwf+c/dFpr12eku8MohTzDqdnrAMfpx2x3KQDxGczGwRRslfwbOxMWCqew2o+fGtlIkBEsAGEXkKcwPcEgXDBUzSzhj9SPASiLQzaP+giCkKVGYQrUvdakDmRNXD9Byjly7RnYabw3KoA3Cli32PfjXXLgpIP5XNDTUPTP2VgFGohSWuUbF8bV1bw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(396003)(136003)(39860400002)(82310400011)(451199024)(186009)(1800799009)(36840700001)(46966006)(40470700004)(83380400001)(40480700001)(426003)(336012)(2906002)(36860700001)(40460700003)(47076005)(316002)(7696005)(54906003)(81166007)(6666004)(110136005)(70586007)(70206006)(478600001)(86362001)(36756003)(44832011)(356005)(82740400003)(1076003)(5660300002)(26005)(16526019)(2616005)(41300700001)(8676002)(8936002)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 14:06:26.9282
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08236a6f-d306-46e5-9a3d-08dba3e22459
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7553

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
 drivers/iommu/amd/ppr.c             | 43 +++++++++++++++++++++++++++++
 4 files changed, 56 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 31e6cb3ba5d6..5395d97486c8 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -57,6 +57,10 @@ int amd_iommu_sva_disable(struct device *dev);
 int amd_iommu_sva_gcr3_init(struct iommu_dev_data *dev_data, int pasids);
 int amd_iommu_sva_gcr3_uninit(struct iommu_dev_data *dev_data);
 
+/* IOPF */
+int amd_iommu_iopf_init(struct amd_iommu *iommu);
+void amd_iommu_iopf_uninit(struct amd_iommu *iommu);
+
 struct amd_iommu *get_amd_iommu(unsigned int idx);
 u8 amd_iommu_pc_get_max_banks(unsigned int idx);
 bool amd_iommu_pc_supported(void);
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 88b9e41b6fbc..d09ce37cd3e9 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -758,6 +758,10 @@ struct amd_iommu {
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
index 673fcc30f9dc..2e8d55657cb5 100644
--- a/drivers/iommu/amd/ppr.c
+++ b/drivers/iommu/amd/ppr.c
@@ -12,6 +12,7 @@
 
 #include "amd_iommu.h"
 #include "amd_iommu_types.h"
+#include "../iommu-sva.h"
 
 int __init amd_iommu_alloc_ppr_log(struct amd_iommu *iommu)
 {
@@ -110,3 +111,45 @@ void amd_iommu_poll_ppr_log(struct amd_iommu *iommu)
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

