Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010068.outbound.protection.outlook.com [52.101.46.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569D830DD00
	for <iommu@lists.linux.dev>; Mon,  5 Oct 2026 19:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791228698; cv=fail; b=KrDiy2L1oHXVrYVs6920SuLqLoRt/VkQl9/A87d4AJA5ZHFDcVjvpAmadEkQWP1u8KzhyE3+RLFxNwB/4ADUeRVZwlgrSRi2aAY+iyVw4F/9ICergDwuObWXlnhd99igh73/gLoaILaHSt9csWdb+FoSKDgeWBkPYMEtEWWNjlc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791228698; c=relaxed/simple;
	bh=NhJ9lzJmsG/g1i70Sf6NoTGmFsKot5mnhfjoPcROq50=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RZjeq2kE7HqasNmpPTyZ5J848CCy3800bFmIlEuNVPhVrAW7pngl4OVa/u3P8Z52T8eWmmsya4zfbYt4LO9atDwIuJMBMunCcrqSJ5s8e4Cpg1ojGSxN/sMBQ+i0zciPdp6D0D+BOS5Pw4hDNHMETJ7NznfvkS/Y74vivR27jhM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=f9dYtqng; arc=fail smtp.client-ip=52.101.46.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="f9dYtqng"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ACTP3r/P1EmyAZvHl3wxkrl1F4hgxm5dXyHYhUB4sETm2r6hutekUqS8TlXZCA2ANwcgoW1kO+P9MZgP03kqcRtzppC3Rzt6rqB+mw497XdWyxJufTFjdqDOT+1g9OY362/6AcWXtH7NkbKBMoYUJSyhQZrC+by++CYsMM5a4O5RNwbFCh+AsN9Hnj8cB7Si4q7e2Nm07dJKm2Mb8rQ2IArTTJQ3y7upx/M0xhzdMW7LkFrtc1WcQplFKixx7QuavPovLwdFlU+xfulbsIo75LEVUfOIPpnmCxDB0fDpdS49uVZ6tvGjhxWEDMQGDi9LlItLtUNi0PPNPCl30NJ8bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BqU9pgcThJ4dtF0eVzMbc1IEo4ssYQCUdUVzydpYQmI=;
 b=HYTBG6MJeSmPOfILYhCwVwcfjDhuYgIFG/QSqh03p4sMaPeAuGIT4sYjSnx3R4JXIwTp9xuq8eQLDyL94Quw/nuJn5qtUmhQNZahGgUlFQ0yqRBIrda5w7pUzoftvuCoTJ8yYm8o/k10ucRkGAOG+epqK8+WBerM2C40RzygKQ2FVyL8OpGK5xfORxYa9J9pcqbNg/lCP3AdK3Y6kciq+SJp4yAseV+u8JJERZhaA1Cu2Vi987+zvGvyGbNZKO6W3fQxLn5SJsDBYH+LXJRMRcOlCOMACujajMwsD3XI1dLS7vtFlHHpe5dW4CQN33VkrGrAl/KoU1UuPTD5+oT1hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BqU9pgcThJ4dtF0eVzMbc1IEo4ssYQCUdUVzydpYQmI=;
 b=f9dYtqngROcW1mvhFCtowqdT1eO/Y8kFA5G7TD57pNNm+i2OAbWlbMu1h9BBrXoPzrTd+RciiD7PASJ+w9wG4IYUPtNIstHbd2ynElLm6QkxnLC9heTIBXaH2a4ABlDvXbRzO/9m7xdJQr7D5tthLGPR529b1kiZAqrcftOYkn9fa8p0Eo2XXwM5xKIoPPcHhJbyL575jAf6nvpzZjOACcUdtd8eJx/Lankgr7qwLMHcwMu7xtVn8XWj+shm181u525qDQVnEZ1sIgdYeKhUbodNtYfK8Kc+KM5yzUqk9YshBfp9xb5rcfJup1+/n1o+wUggRYpz13/x3iQUTmxeyg==
Received: from SJ0PR13CA0119.namprd13.prod.outlook.com (2603:10b6:a03:2c5::34)
 by CH3PR12MB9146.namprd12.prod.outlook.com (2603:10b6:610:19c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 19:31:31 +0000
Received: from BY1PEPF0001AE1D.namprd04.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::8d) by SJ0PR13CA0119.outlook.office365.com
 (2603:10b6:a03:2c5::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Mon, 5
 Oct 2026 19:31:28 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.232) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BY1PEPF0001AE1D.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Mon, 5 Oct 2026 19:31:28 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 5 Oct
 2026 12:31:03 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 12:31:02 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Mon, 5 Oct 2026 12:31:02 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <jgg@nvidia.com>,
	<praan@google.com>, <kevin.tian@intel.com>, <smostafa@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <jamien@nvidia.com>, <kas@kernel.org>,
	Cristian Prundeanu <cpru@amazon.com>, Breno Leitao <leitao@kernel.org>
Subject: [PATCH v11 03/11] iommu/arm-smmu-v3: Swap EVTQ_MSI_INDEX and GERROR_MSI_INDEX
Date: Mon, 5 Oct 2026 12:30:46 -0700
Message-ID: <630e70ba13639e5bd86fca0b574dd47dddb7fb92.1791226953.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1791226953.git.nicolinc@nvidia.com>
References: <cover.1791226953.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1D:EE_|CH3PR12MB9146:EE_
X-MS-Office365-Filtering-Correlation-Id: 21ea8201-2555-4b37-d7ec-08df231740c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|23010399003|376014|36860700016|1800799024|6133799003|18002099003|22082099003|10067099003|56012099006|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info:
	MB8UzZa2dkmL34l3BApp7QnJQaJRL6fC3tdejYm+OaeyqFqPMLV3BSNVLu+UfQ/HaeUrQ/SLbEXTDwaQaecQOoeoSoovHTvSzr3bf3Amc5DcyfKx+z1v7Di/+RyPOOGJPEcK57mTf9LZ4Vtfh2sLLJ1tZBzNw5HQ6T3IYRrVOXjy0bZip3Ts1XL24IswjiFc2cjqCDJZONhtkeH7euqO8vcQcLeL/Bs66/yXZxDJ4GEAEcCwenCzxLVkE1ixVFAkciRtjvQ+ysYodnoqCOD06n+0lDSfDL6MvlxAsQB2Ld9fB7Ds0e6QA1k5/Pcjmm7EzIxY/N76oJyPry8iTLG6S5Z+3rth6Mb97LwY1caAt6SdMoYbrZEClX+sZMnaucb3lMZm9HFKTAceCM8jjBzAY9gbkXmgeMP1tpo3DqV6CTR6G9SA53on5MXklYCaoCpThXO+23yI5xgyc26Sqp3PrdAgOWN9RS2RMk3TA/zLmkWJS7jO9Xa02qKF/RPInhGnHHYH1ToMNhqtr0CB4BfO6sYObGsCknMyw+NU2WpLO9zyoarfj/xDK+p3fJzs1aqUyg+3eMTrRWyyPF3a+Jadg4z7B66m7bmciu/s2zLZhRYDXuCOlrTpfASZUIPwG8js/TVsEc/qjnZkit/5CEVWKK/B3q6Sje06ZQ91J8227cNpv7nA235KZMbajQkHJj5UHDcZGgnGswUVTVjFJpBADA==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(23010399003)(376014)(36860700016)(1800799024)(6133799003)(18002099003)(22082099003)(10067099003)(56012099006)(11063799006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	duDkKLLiWZ9mhs3AfUyzUCAGIIKVxe4fj1ZUEl83dn/2dMleDG/EJaL4weRrZ/FVHs3xU49vc6RsHlUmpjNVmw1GH7HbMBbKQpA8wPL7UfqZc7t7kqd0G9GeEv89C1N1m019YiodWFxGrBDpeZPM5mvIGUNwByA+Ha9nEYgNQFVqySw/BiZh+2Dl5k/5i1h2885+CdIFs18O8b2coKkGCSavUYPKEgH55tzo0sbsofWr8cf9gypkfHaXFDdiCUybCMmwqHTUM9X1h0XrWPH/9CyRvtfjsCQMuFAmJnz5LpfRP+16FxI9ta+rnQW0lwVvYYcJK28j39d6qp5ASJfvFvXbkvyyUmHGWx43oPbtNUrk8zGURQTpHZJZjNlBgy7HLb+zCPGmFb6ptFBYYInV2aphwJ/7nSfZ/Si6SUYo3E+azdVNvgfuGfC2CkVgF3+L
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 19:31:28.7630
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21ea8201-2555-4b37-d7ec-08df231740c5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE1D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9146

The nvec trick in arm_smmu_setup_msis() works well on PRIQ since its index
is the last index in enum arm_smmu_msi_index, but it does not work well on
the EVTQ as its index is 0.

A subsequent change will make EVTQ optional so it can be disabled in kdump
mode. This can skip its MSI vector allocation.

The index is driver-internal to select arm_smmu_msi_cfg[] register set and
the corresponding MSI slot. Nothing else.

Swap EVTQ_MSI_INDEX and GERROR_MSI_INDEX. Then, arm_smmu_setup_msis() will
simply decrease nvec when EVTQ is disabled.

No functional change intended.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index aeace4335abfe..6ff61565f7583 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -57,8 +57,8 @@ static struct iommu_dirty_ops arm_smmu_dirty_ops;
 static DEFINE_STATIC_KEY_FALSE(arm_smmu_erratum_repeat_tlbi_cfgi_key);
 
 enum arm_smmu_msi_index {
-	EVTQ_MSI_INDEX,
 	GERROR_MSI_INDEX,
+	EVTQ_MSI_INDEX,
 	PRIQ_MSI_INDEX,
 	ARM_SMMU_MAX_MSIS,
 };
@@ -68,16 +68,16 @@ static_assert(sizeof(struct arm_smmu_ste) == NUM_ENTRY_QWORDS * sizeof(u64));
 static_assert(sizeof(struct arm_smmu_cd) == NUM_ENTRY_QWORDS * sizeof(u64));
 
 static phys_addr_t arm_smmu_msi_cfg[ARM_SMMU_MAX_MSIS][3] = {
-	[EVTQ_MSI_INDEX] = {
-		ARM_SMMU_EVTQ_IRQ_CFG0,
-		ARM_SMMU_EVTQ_IRQ_CFG1,
-		ARM_SMMU_EVTQ_IRQ_CFG2,
-	},
 	[GERROR_MSI_INDEX] = {
 		ARM_SMMU_GERROR_IRQ_CFG0,
 		ARM_SMMU_GERROR_IRQ_CFG1,
 		ARM_SMMU_GERROR_IRQ_CFG2,
 	},
+	[EVTQ_MSI_INDEX] = {
+		ARM_SMMU_EVTQ_IRQ_CFG0,
+		ARM_SMMU_EVTQ_IRQ_CFG1,
+		ARM_SMMU_EVTQ_IRQ_CFG2,
+	},
 	[PRIQ_MSI_INDEX] = {
 		ARM_SMMU_PRIQ_IRQ_CFG0,
 		ARM_SMMU_PRIQ_IRQ_CFG1,
@@ -4965,15 +4965,15 @@ static void arm_smmu_setup_msis(struct arm_smmu_device *smmu)
 		return;
 	}
 
-	/* Allocate MSIs for evtq, gerror and priq. Ignore cmdq */
+	/* Allocate MSIs for gerror, evtq and priq. Ignore cmdq */
 	ret = platform_device_msi_init_and_alloc_irqs(dev, nvec, arm_smmu_write_msi_msg);
 	if (ret) {
 		dev_warn(dev, "failed to allocate MSIs - falling back to wired irqs\n");
 		return;
 	}
 
-	smmu->evtq.q.irq = msi_get_virq(dev, EVTQ_MSI_INDEX);
 	smmu->gerr_irq = msi_get_virq(dev, GERROR_MSI_INDEX);
+	smmu->evtq.q.irq = msi_get_virq(dev, EVTQ_MSI_INDEX);
 	smmu->priq.q.irq = msi_get_virq(dev, PRIQ_MSI_INDEX);
 
 	/* Add callback to free MSIs on teardown */
-- 
2.43.0

