Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D6A6ABAD
	for <iommu@lists.linux.dev>; Thu, 21 Dec 2023 11:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iWPinQiv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e5uD18817SGnf1aHDaN0n62+fl7SQLG1mIDHYjcZ9yNjN9vUPu3z6MeEflxkTvnclDmShKRMm2wq7nEwsL0WIwmcH+dYnTNxEvu/WJvFbsnWfY9waF5nM+W8Brmzo6M5eI+OcgXJJFFxZ6X6DXnyHqhBn4CuPPDkKc9KGBl+aG+JMZD5XniJN+DJTmEX7Q+2Dku8G+hyLf6PJQb0xj119MtwSVIgsr5RwnSC5Zqvz5hkoLjLNOuC9QmlGIMFAe5nKkbG9lvbHVgH858mU/DcyWXfv6P6fUxkIFGxor8tFJXpD1JKhfyQbIrswbpFQXAkxIhVQGfnbpbbtgZCkzL2TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wzhFXtobsmAomd4uvfKcj7PhJGJQKAGtRSkKGF4pTW8=;
 b=ofiZex+LcgPSw9KtiwXnl9Uleb9ns/tqwSfbF7VHFXB2bBsjaoIAD5H59ktJlA+E0kblaEw4Wd6hIhJv5VVdx0dySVpiwuNQserxkK8uDHt3UTK5YgY0lARLK7fZLvFXaYgNg2rjx0y6EQmlS3wlUzhfVYSpzW6xFPLGQmBIgDO0H67kylec0VTnfdymcSGXv7EPd0rUBDQEwEK5rhsHQ/ojZrd5JJuLxdEESylQrZmo3Aai4lSZcnpkXeNNdAv60z0nUSefwZwn/eVGFmTchH9QxjUAhw/RFx8YljCBnPp5nLF+QrIxF9h/0kXDyQ5EE8Npe5JVvYkbSZKUBYpENg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wzhFXtobsmAomd4uvfKcj7PhJGJQKAGtRSkKGF4pTW8=;
 b=iWPinQivEFAMmakjaLPNa818zxcOLKA+NCxIeaXljglz5mHOF/lD34M3ECS/T6vzZjwbIQ1FhIoQxhNFROPtgyXuUeGD4y+qq+CHi+2GRfA4BNjynEcEMVj+phXw2NrM/rwGq2T0WU0Pd/Ih5vFEEXQzm4lltjg9m+Hxow0l2wc=
Received: from BY5PR17CA0019.namprd17.prod.outlook.com (2603:10b6:a03:1b8::32)
 by PH7PR12MB6833.namprd12.prod.outlook.com (2603:10b6:510:1af::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.19; Thu, 21 Dec
 2023 11:18:15 +0000
Received: from MWH0EPF000971E9.namprd02.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::d4) by BY5PR17CA0019.outlook.office365.com
 (2603:10b6:a03:1b8::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18 via Frontend
 Transport; Thu, 21 Dec 2023 11:18:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E9.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Thu, 21 Dec 2023 11:18:14 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 21 Dec
 2023 05:18:10 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v4 06/14] iommu/amd: Define per-IOMMU iopf_queue
Date: Thu, 21 Dec 2023 11:15:50 +0000
Message-ID: <20231221111558.64652-7-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221111558.64652-1-vasant.hegde@amd.com>
References: <20231221111558.64652-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E9:EE_|PH7PR12MB6833:EE_
X-MS-Office365-Filtering-Correlation-Id: 00d362d1-5223-4382-7fd5-08dc02168661
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rLmt7oDDxtU3kOt+2I6zPd0kmXsxXStJ9dYLcCQVdh5CYKed8/QtWyTNmv2x55PEiLM24IJ28qJ2L+auqdEUdCsSHviTpvf6mWwmDGkBnbrsH+/xo30UOQr75PIsqTM3e72jqKVt6zwiph3yOP5d5BF2Vy90qB//m6Ox+IqYvqax+rB7z4PPAFCdOSwCwtK/Z41+8nfpZm3c/CTZzsE3yoD3F1S5TXXBIZCpDzR1G6GayhdSrnIzNifVq+/Mp3mt72dle8CSiGNtvzFGuWwnnQoO3w7qSe1bgKQ1Dzq2Hz0uMQ2+uvu+ehlXsxxANejLIc4HbMzSpFyxIWwiOujG53bSp8AD+AmhvJnrMxV5WZcxYABfPV2miHeomlwrwPcBMVNgp4scozC8LbPhScklIQahGgF88JICofAaYzRp7U24yj+AJU45a+2vqECB5HRrHzLGjXim/l/7P+ZeOZCbCl3XNPCDS/3JPiJSGR5Yj6lkfshG4gD43oLgTM8M3RSOSKDSOXAaAfkO0ligf88n5Ry+lHhDkxIXC63g/StltK1ClRMhCjME0qDoYVa9s1usg0ZrNwe70xGfG4mtulEYwcWr5crC9+pbSgw/pUw2ey6qCCnXmC4G/BjzOyjJH7cHlthQX8d3r9SkIW/e7Dex7tHceXKNl8ondfu7Hy2owUFoNa/0ZmbXr3WO2ejWxn6D6kbiiw+YmNPx/+GThITaaS45mj9n0rQHjPkn9pIvKBAEkVOMQsdNLGmA+87Y/G+zKdNSankROi0E7CzZNFpQgg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(376002)(136003)(396003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(82310400011)(36840700001)(40470700004)(46966006)(2906002)(478600001)(47076005)(2616005)(5660300002)(83380400001)(6666004)(36756003)(86362001)(7696005)(26005)(1076003)(36860700001)(41300700001)(336012)(8936002)(8676002)(40480700001)(54906003)(316002)(81166007)(82740400003)(110136005)(356005)(4326008)(70586007)(70206006)(16526019)(426003)(44832011)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 11:18:14.5121
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00d362d1-5223-4382-7fd5-08dc02168661
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6833

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

AMD IOMMU hardware supports PCI Peripheral Paging Request (PPR) using
a PPR log, which is a circular buffer containing requests from downstream
end-point devices.

There is one PPR log per IOMMU instance. Therefore, allocate an iopf_queue
per IOMMU instance during driver initialization, and free the queue during
driver deinitialization.

Also rename enable_iommus_v2() -> enable_iommus_ppr() to reflect its
usage.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu.h       |  5 ++++
 drivers/iommu/amd/amd_iommu_types.h |  4 +++
 drivers/iommu/amd/init.c            | 12 ++++++---
 drivers/iommu/amd/ppr.c             | 42 +++++++++++++++++++++++++++++
 4 files changed, 60 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 3a82f5297ddb..cfbb4a332f6e 100644
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
index 3dc39bbc05fc..5958afc57226 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -769,6 +769,10 @@ struct amd_iommu {
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
index d25a706adcfc..426db9ea3718 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1638,6 +1638,7 @@ static void __init free_iommu_one(struct amd_iommu *iommu)
 	amd_iommu_free_ppr_log(iommu);
 	free_ga_log(iommu);
 	iommu_unmap_mmio_space(iommu);
+	amd_iommu_iopf_uninit(iommu);
 }
 
 static void __init free_iommu_all(void)
@@ -2789,12 +2790,17 @@ static void early_enable_iommus(void)
 	}
 }
 
-static void enable_iommus_v2(void)
+static void enable_iommus_ppr(void)
 {
 	struct amd_iommu *iommu;
 
-	for_each_iommu(iommu)
+	if (!amd_iommu_gt_ppr_supported())
+		return;
+
+	for_each_iommu(iommu) {
 		amd_iommu_enable_ppr_log(iommu);
+		amd_iommu_iopf_init(iommu);
+	}
 }
 
 static void enable_iommus_vapic(void)
@@ -3130,7 +3136,7 @@ static int amd_iommu_enable_interrupts(void)
 	 * PPR and GA log interrupt for all IOMMUs.
 	 */
 	enable_iommus_vapic();
-	enable_iommus_v2();
+	enable_iommus_ppr();
 
 out:
 	return ret;
diff --git a/drivers/iommu/amd/ppr.c b/drivers/iommu/amd/ppr.c
index d43a616c0c36..1eb0b737afb5 100644
--- a/drivers/iommu/amd/ppr.c
+++ b/drivers/iommu/amd/ppr.c
@@ -106,3 +106,45 @@ void amd_iommu_poll_ppr_log(struct amd_iommu *iommu)
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

