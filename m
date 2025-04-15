Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B0A27465F
	for <iommu@lists.linux.dev>; Tue, 15 Apr 2025 04:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744693114; cv=fail; b=hNwfsnB4UKLQ6DJMjyejm+wxL8agGczlp8PWTo2lyesDoVaAS6dkmiwNlArOVO81JzJT03zyjEaJHvBuKh/MvO1/PrUbE7tYbh481c2MuG6x1BkTEWtSvvMTRp+5ycB7IsTv/tKWGGzLUXRCAAWkXY/CIAZwvzB1xXx9eURmxdM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744693114; c=relaxed/simple;
	bh=BXHUV1l1jNKJhnTdLHAY2C4nhQv+nSv5ZcazTOhSmnw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pyBJWkUiPB8VOkCHADiZbQ5kGVXaWFgWQHw7JPIkeM2E5sh2sOaRal+KPq1WfTzJZc9V6NpF/LNjcyU7ayDITPLcp8OS2FbmFFIsa1gWnnB7QNffDrMjEYEei0lylZWbUmGxBi6VcOrAFj2N5Z1tNmNUjjCRPfVANkvv7ixjrJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZQGhVtqD; arc=fail smtp.client-ip=40.107.92.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZQGhVtqD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rSjHPDjn6nOovPxTQzOg32ssaGbo27XJrchDKdCnoS8VGeW8VRCF5YrQRmleJPOqqPlslQRKcOZiZgFAMx/XSY5xEK7cJIgWycGgf2OCp1ys4F0Y7SDBd4EuySADbmElS7uqNzaNnzHc0CrU5x3mK1DeYWJFN3BADgAlEs1lKAV4VvemXa+kwyA8sfyK0a/wrdomTlxpdxJK7GajETb9pvWVhb2P6vThDvQWRI7MOPbkEZF2GKVqPwqdgEsRuzGnf/Vb6EOP9iOPZyEiG1Ov354kkckBWuSiQnvLABZJNaZmpS2R2hEwJmB1u3R8bxdLNpEFaDd2CTSkc39mFR2I3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gFq52igyDoDFLgg8qEdSuk0DTG7Xqi0b4EZGCo8EvHE=;
 b=S/6j6EJLE1DxmFOWXNz3c2f0BntvThnM2s++NwwfHPYbMg2VZRWk03IbbVo6lCLmAM88Hq2uHBVUiV71frJtSlIldFONv55mOXDydQ7SLKD+DRguv1mLw5Ak/nlPqMXXtsGmbqawl+gPXFE66HTs83vLUNjYQeTxtxVGPjRRYakJkq4WVP3SH4SB+1SdJl9oDhYDKmmsWQNDDFqsECvZPcTiqpmQdh2wf/TBq2VL5oYK6qZs/nbzvLjH1Qq3vK9qXO7ZYB0BVMHJZuMkBQdW2RtNME5jOkDRZUabwwkNefCUczFyM2WJlt3CNlDvASH/akUuXBV2zgUNaqFnZ+JI1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gFq52igyDoDFLgg8qEdSuk0DTG7Xqi0b4EZGCo8EvHE=;
 b=ZQGhVtqDYziVgAyDYxVWm0J6SApmr0SmeAcTKf9BHXfZXA5iNYnEImB0t2RB8kXpf+SKrc2BUlnGWWPNF/Tf55Sbci0Oz9InqB+Xcbi5t4I6mZZC2wUhDV/1/ufNN/4EqP6Vkk+Va/HVUz/U/ZnYh1CFUpy9IcGGj75fbBD+h5NCB7kmzqqBCZMrjtnZEY+QoJNlk67FK5YE2oW05ylIG/V+V4u+6kb0a+T2Eo3ATiqowIEkZ5hYWiqWvoydGzRL184mTD3iA7ysmqGocT5iYfTCFEEfwvmUGuN+C13mGrzPSkconF7/ucxRRtupsQgD63hcc/6kgOaTAX/Mo060gg==
Received: from BN9PR03CA0238.namprd03.prod.outlook.com (2603:10b6:408:f8::33)
 by DS5PPF482CFEB7D.namprd12.prod.outlook.com (2603:10b6:f:fc00::64a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.37; Tue, 15 Apr
 2025 04:58:26 +0000
Received: from BL02EPF00029927.namprd02.prod.outlook.com
 (2603:10b6:408:f8:cafe::f0) by BN9PR03CA0238.outlook.office365.com
 (2603:10b6:408:f8::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.32 via Frontend Transport; Tue,
 15 Apr 2025 04:58:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF00029927.mail.protection.outlook.com (10.167.249.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 04:58:26 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 14 Apr
 2025 21:58:12 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 14 Apr
 2025 21:58:12 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 14 Apr 2025 21:58:11 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC: <joro@8bytes.org>, <kevin.tian@intel.com>, <praan@google.com>,
	<nathan@kernel.org>, <yi.l.liu@intel.com>, <peterz@infradead.org>,
	<mshavit@google.com>, <jsnitsel@redhat.com>, <smostafa@google.com>,
	<jeff.johnson@oss.qualcomm.com>, <zhangzekun11@huawei.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH v2 03/11] iommu/arm-smmu-v3: Share cmdq/cmd helpers with arm-smmu-v3-iommufd
Date: Mon, 14 Apr 2025 21:57:38 -0700
Message-ID: <a746b90b0d1259aa6575cc23f788dfcf6acf9a23.1744692494.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1744692494.git.nicolinc@nvidia.com>
References: <cover.1744692494.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029927:EE_|DS5PPF482CFEB7D:EE_
X-MS-Office365-Filtering-Correlation-Id: 763af0f7-64d4-4e17-c72d-08dd7bda2839
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uVVtXMUNRnNPyKQoLJUk19CgAe6jTDMlbwWrF431H0aRe1aPK4coK/H5k34y?=
 =?us-ascii?Q?G12Jocu5Pxys/IhrLGvsVpLy3toVpSNBfL9VEq8wXVqFCkSF+YuYSVy0HcC4?=
 =?us-ascii?Q?UAHd3QkmYfsVum/8GyiE88EhOVwlGdtdQU0PrVeiMMyguSAN020S05tIpLar?=
 =?us-ascii?Q?llQDwKjTAiSwaID3QkRh3D606+pFhEFuyUYVUbSwhPgbFD/5EIhg8011AnS3?=
 =?us-ascii?Q?2H5VIzYcCmAK1+vtymtolCW0DKa7i/ouEkTcqpn86LVbc0dzCgXGaYyrJH6W?=
 =?us-ascii?Q?WMe/b0wXu+FrMYY7MKBhpoj0s0chFM5Htd2CHq5v6PPLKNLak630p7ICn0WQ?=
 =?us-ascii?Q?yWbbP9LlJt+GrMsACINJJgKhGl2KpNj+O1YEmoq3qXih7PLmvXoTLL2ErBN1?=
 =?us-ascii?Q?dD6PTUBgaj6dRyP4zwK1qygJnYkRQDA5lJ30KmC2SK7hOpg7N1e4Kkru0lGw?=
 =?us-ascii?Q?90XpFKDXaVAq9ERsXoFd8dV4FeKky2oiiUckdMdmHZfAj8lmQs9woLLHDl8E?=
 =?us-ascii?Q?nj9rfVS0KFlMm8+V5xhTln7Q0t7mKXg6BebJeTA/y2/8iOPnxSb6abw9w4BA?=
 =?us-ascii?Q?oERrM/nGsuOaqwjqkcCxfzWyKlLD9d7Tk4hcklrjMFLPIJsjzuzh0r7RncEE?=
 =?us-ascii?Q?aV3ueJVrRBN79l4s7J9XgQrP1kj6TiuVX4g4JJ8aP6i3LdGuwauV9YxWBPw2?=
 =?us-ascii?Q?IHAJqW9kG1WK6VAKFC1cdHj6sCB49/1isgDvZZDpFb9382DpZS1b054soh9f?=
 =?us-ascii?Q?+mq45ee4GFOxK5L+EsJsV5beM/znomQ+RFOpZgwoiA6MnsO1tf6HgctrAoEj?=
 =?us-ascii?Q?nTFhD7sJ1Qlc/OTNzLNPKuNJ3RQm5GrATuEw12oYbC6EbMZc550T9N/O5Q7x?=
 =?us-ascii?Q?K5htn4urcVUyY287+TLPh424Y+JufEcKvuuky9f6Kh5QK1P+WazdU9fzyccu?=
 =?us-ascii?Q?1JKb53Ne9n5DC3IzVAwDSnSqz1cp/aCDHvcecJP4qKYhs+2STzD6KKSNZQz3?=
 =?us-ascii?Q?TteZKHhpOXO96Iydg0rYQhXLM6BJ1RjDzNmu+/GhmQF1tFZ+sPBfOVpHxSpR?=
 =?us-ascii?Q?i2LBgBLCEW66QaAywqygK7Xmh6VrzEBLKMDDZAyb4MY4B/PVlNK3fa//IoNn?=
 =?us-ascii?Q?r4SW4RFbaQoG//0zh68KcnL9qZbl/lv0n/d3Cqp92xK8xCT1sagEexxa2HGd?=
 =?us-ascii?Q?Mw21bhRJrXMLh8EmrfUMPZlyx1wtEN57YbcvlquD0BtsuY7rAFBNhZEU8kEL?=
 =?us-ascii?Q?a6JVkcqFVwqby8l107kMgcApIKj0zXptKIhrdUT85KdI0LxDXfK89sH4NWxA?=
 =?us-ascii?Q?67l4dhf+tCwCQEfp/2pNP2rfvz4fJjaMax3VrGMO3KTMve89Lkv9Cem3GJJN?=
 =?us-ascii?Q?zOM9kjtgH/8Ki5lhocps1q1qcrDwrpx/kETupwEsVMi5b5Db94gJJSk0Nj8o?=
 =?us-ascii?Q?BwNRanC5YQsSpxNjc+VFhyw3yl2P+T34jXV0x6KCmFjeEckTgSXleCzI+FQn?=
 =?us-ascii?Q?kvhx/0AuVUsz6jMFYqBVW/OpJ0sgKL9v5zoW?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 04:58:26.2409
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 763af0f7-64d4-4e17-c72d-08dd7bda2839
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00029927.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF482CFEB7D

Allow arm-smmu-v3-iommufd to call them for nested/S2 cache invalidations.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 12 ++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 25 ++++++++++-----------
 2 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 5dbdc61558a9..4f3f4a40a755 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -959,6 +959,8 @@ void __arm_smmu_tlb_inv_range(struct arm_smmu_device *smmu,
 			      struct arm_smmu_cmdq_ent *cmd, unsigned long iova,
 			      size_t size, size_t granule,
 			      struct iommu_domain *domain);
+void arm_smmu_atc_inv_to_cmd(int ssid, unsigned long iova, size_t size,
+			     struct arm_smmu_cmdq_ent *cmd);
 
 void __arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu,
 			      struct arm_smmu_cmdq *cmdq);
@@ -996,6 +998,16 @@ void arm_smmu_install_ste_for_dev(struct arm_smmu_master *master,
 int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 				struct arm_smmu_cmdq *cmdq, u64 *cmds, int n,
 				bool sync);
+int arm_smmu_cmdq_issue_cmd_with_sync(struct arm_smmu_device *smmu,
+				      struct arm_smmu_cmdq_ent *ent);
+void arm_smmu_cmdq_batch_init(struct arm_smmu_device *smmu,
+			      struct arm_smmu_cmdq_batch *cmds,
+			      struct arm_smmu_cmdq_ent *ent);
+void arm_smmu_cmdq_batch_add(struct arm_smmu_device *smmu,
+			     struct arm_smmu_cmdq_batch *cmds,
+			     struct arm_smmu_cmdq_ent *cmd);
+int arm_smmu_cmdq_batch_submit(struct arm_smmu_device *smmu,
+			       struct arm_smmu_cmdq_batch *cmds);
 
 #ifdef CONFIG_ARM_SMMU_V3_SVA
 bool arm_smmu_sva_supported(struct arm_smmu_device *smmu);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index e9d4bbdacc99..8ad249f7dcbf 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -929,23 +929,23 @@ static int arm_smmu_cmdq_issue_cmd(struct arm_smmu_device *smmu,
 	return __arm_smmu_cmdq_issue_cmd(smmu, ent, false);
 }
 
-static int arm_smmu_cmdq_issue_cmd_with_sync(struct arm_smmu_device *smmu,
-					     struct arm_smmu_cmdq_ent *ent)
+int arm_smmu_cmdq_issue_cmd_with_sync(struct arm_smmu_device *smmu,
+				      struct arm_smmu_cmdq_ent *ent)
 {
 	return __arm_smmu_cmdq_issue_cmd(smmu, ent, true);
 }
 
-static void arm_smmu_cmdq_batch_init(struct arm_smmu_device *smmu,
-				     struct arm_smmu_cmdq_batch *cmds,
-				     struct arm_smmu_cmdq_ent *ent)
+void arm_smmu_cmdq_batch_init(struct arm_smmu_device *smmu,
+			      struct arm_smmu_cmdq_batch *cmds,
+			      struct arm_smmu_cmdq_ent *ent)
 {
 	cmds->num = 0;
 	cmds->cmdq = arm_smmu_get_cmdq(smmu, ent);
 }
 
-static void arm_smmu_cmdq_batch_add(struct arm_smmu_device *smmu,
-				    struct arm_smmu_cmdq_batch *cmds,
-				    struct arm_smmu_cmdq_ent *cmd)
+void arm_smmu_cmdq_batch_add(struct arm_smmu_device *smmu,
+			     struct arm_smmu_cmdq_batch *cmds,
+			     struct arm_smmu_cmdq_ent *cmd)
 {
 	bool unsupported_cmd = !arm_smmu_cmdq_supports_cmd(cmds->cmdq, cmd);
 	bool force_sync = (cmds->num == CMDQ_BATCH_ENTRIES - 1) &&
@@ -974,8 +974,8 @@ static void arm_smmu_cmdq_batch_add(struct arm_smmu_device *smmu,
 	cmds->num++;
 }
 
-static int arm_smmu_cmdq_batch_submit(struct arm_smmu_device *smmu,
-				      struct arm_smmu_cmdq_batch *cmds)
+int arm_smmu_cmdq_batch_submit(struct arm_smmu_device *smmu,
+			       struct arm_smmu_cmdq_batch *cmds)
 {
 	return arm_smmu_cmdq_issue_cmdlist(smmu, cmds->cmdq, cmds->cmds,
 					   cmds->num, true);
@@ -2096,9 +2096,8 @@ static irqreturn_t arm_smmu_combined_irq_handler(int irq, void *dev)
 	return IRQ_WAKE_THREAD;
 }
 
-static void
-arm_smmu_atc_inv_to_cmd(int ssid, unsigned long iova, size_t size,
-			struct arm_smmu_cmdq_ent *cmd)
+void arm_smmu_atc_inv_to_cmd(int ssid, unsigned long iova, size_t size,
+			     struct arm_smmu_cmdq_ent *cmd)
 {
 	size_t log2_span;
 	size_t span_mask;
-- 
2.43.0

