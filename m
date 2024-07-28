Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2075.outbound.protection.outlook.com [40.107.236.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E59D79DC7
	for <iommu@lists.linux.dev>; Sun, 28 Jul 2024 22:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722206721; cv=fail; b=asKOK1biznOXLGyHTve4cZwNjRJZPuCYM3GjGEKSFBaG6dABJbEmBg3p/R6PNGWmOxAHYgt1zOr+6US6BntUiOnNO0zbF9qoDt5OdrnTHNI0v4cSktlQJD+wEjs7u26GzIzRf0N/ZmXl9Y485dMhSa3bP3g96tQixg8/GYZdhhw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722206721; c=relaxed/simple;
	bh=avvyZA8d9DZfXEroETBuInY9Zi88oDGG0ufA94gzFQQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wkoj8grRvULn/PazgDd/qTk+XoNhRranX2/Y8v0o90b5ixypxRa0xTfagWVyZPc3pKC0x83mbSjPKG7ug2rtt2aO8HVdcACzQRVplgRPYWYi2nQqHJhs/0b+weh1GkkLXWqfhXX+aqQjA9XOd3TI8ff13UKWZ+wEDoGyL1gbP3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qf5Z3pI4; arc=fail smtp.client-ip=40.107.236.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qf5Z3pI4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eLUvrfGYQw5isPijJqw2IpiLfXCmvajJgCNDf45eGtnvD7RhYoPuBH8iKgAngWBilYNHL4g8SXT3in02gdXRtDL9hDSf9Vne8rF1kfTSSZxj39f6Jigxavuacg/kCL2SMpZsk/tpQt5R5w2C/3WSCdVxvdT/ocA8av+WjYFyi+UkruSEWzliD7RvXXVt+HIVlrLg+2lTxtPwmRhnbnFArGs8uImqOve7kBGe3dSrWT/+wW7KPl5eLdYmup32LwpuF6ERnK9jH2e09vqEwxfZwsGkXB1Qr7RMKUyrD2igh2cmuReXhM9yQ+LcaaWoC22Poz6a22x4b7BlVbVPPbuzWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cI/OiTdXtgsi6NNmf2ubMy0NEsjWKNJmXMhqXXxmHfo=;
 b=go8Lhe5KYViU1IF1EhjyxtZ/IgTeHvXD7iDXGrJ9f+VYxmbn7M2KYHw+xbZDe96taBMRxL8lPpVSwLPghYSMa0KXr191o4hs/BX2G6NSCRCGnTAvV8u8tvTOcJPPl6cnf8DBqPo1GT6GlaDzmPwKMdxyTDm55Yq+J9UNDAShLotnzPHLaKm+M+FwuAQHuL8WndoMQazfCPAbTVYwzCppCFEGhy7SI8GeAmYYbzPD+JF6kCJ/YQSRnNRhKhnVmP9Drhf0kCFqqdodBm+WtmAr5rYOOMv2Qw3R+WbgOfHT8Xs1R2VZWJ6L1NmsbyVw/vUww7SOY/FRXu6eC7TV+XGXVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cI/OiTdXtgsi6NNmf2ubMy0NEsjWKNJmXMhqXXxmHfo=;
 b=qf5Z3pI4RxrBOKWQ4IIbRitPexIZOR+7gU0bywV2aB2C8U4Uyq81W+DpMfqdK4q5oegbQaczAdA9ZYRbodNCoLriE6XtdcxrqWHXumvi4qLdG0YX/+cZGhiqKUO3kXWWsH619qp5CK/2r5L5HXYB+yqr7B3eJUVMvqff+6rGRChiP4UzNbop7WzoyIDHDgm44cAXHphiwS2udpP6G6XoGH94awpLAUfTYjW4le6crQ1BwePh49mNhMo7MdLyT65YyRbFxarPfjEbtGZ2KpJnInQMx4D9jz2izuPdthCwYU3AC5DecU47K75mdecJ+vm6/i3WOLX72syR4M4s9iPdPA==
Received: from MW4PR03CA0127.namprd03.prod.outlook.com (2603:10b6:303:8c::12)
 by MN2PR12MB4319.namprd12.prod.outlook.com (2603:10b6:208:1dc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Sun, 28 Jul
 2024 22:45:16 +0000
Received: from MWH0EPF000A672E.namprd04.prod.outlook.com
 (2603:10b6:303:8c:cafe::73) by MW4PR03CA0127.outlook.office365.com
 (2603:10b6:303:8c::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.34 via Frontend
 Transport; Sun, 28 Jul 2024 22:45:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000A672E.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.11 via Frontend Transport; Sun, 28 Jul 2024 22:45:15 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 28 Jul
 2024 15:45:05 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 28 Jul
 2024 15:45:05 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 28 Jul 2024 15:45:04 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <jgg@nvidia.com>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>
Subject: [PATCH v10 4/9] iommu/arm-smmu-v3: Pass in cmdq pointer to arm_smmu_cmdq_init
Date: Sun, 28 Jul 2024 15:44:49 -0700
Message-ID: <01498fee0d3c3ffba7a53e46463671584fa3193e.1722206275.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1722206275.git.nicolinc@nvidia.com>
References: <cover.1722206275.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672E:EE_|MN2PR12MB4319:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f859b3b-027e-41b0-e159-08dcaf56f301
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qzelv20fQskrkNFG5O7QWUMc12JNHwOVVP1ly1gwG2nOQA8F5i8FRTtzQanM?=
 =?us-ascii?Q?/7terYoQgyd8Duu+EryoA9yGVUdGTbpqr7CqzDdWJGHraPSwX8f/ls2CL4bu?=
 =?us-ascii?Q?ef0rQPvbIhwdfiPPm+k5PUoM3bEM/ifIiZFmRjvbX22fCBwBP00+tZxovDP+?=
 =?us-ascii?Q?5X6cfYcbGALbE67hCYVN03DpDf8eBsqRly+4lYvINQIR+iFWWe7BRmykLvld?=
 =?us-ascii?Q?eOn6J8LxoRxqgVwjZwHDeuJwjoYZG1D8D4L8G5jVy3pFSJVa9j7vE4DqOSay?=
 =?us-ascii?Q?vRy98PM20DWW8kjWs6rlJOzkV9sUOZr/AZIuGhcpQ/AoviuqMJyxnpO9VfAY?=
 =?us-ascii?Q?nq59k+CCgvNb4jxYPShujeU+647aks1jxq0Yw89o4OR631JsIXp88Mf3IKzT?=
 =?us-ascii?Q?sh71MNYTTgm6kKSgrU3a8AvgBdOoqeUF1kRoshki/anhFN7O/Fmcq45o4JPe?=
 =?us-ascii?Q?+w1brpP0va9OM8/dUaUSVktgXV/KAgFvy1cvjDWJoc0d60aq0AprZ/AQ7X9F?=
 =?us-ascii?Q?bmQFz6O33xoX/6p5o5B9ACcQzRPWscK4oIIIr62htT9UzOiUOG0S0ACspxBA?=
 =?us-ascii?Q?8vQZuGF02q8TVyoTzdDDQNHCaI/ZHi9+V6Pvh0dU+UDOKPgBXzHNnBAhdEF1?=
 =?us-ascii?Q?dqzwdhVFUeBHL9ztrWEe72IdP990lU1s5pR8Lj5+2BOVobybnO7k6a19MQIW?=
 =?us-ascii?Q?vLOFsgQh7uureuLTKoLk3j0FseF3R7Rq5cre75D5CY/pqK3ArfJyg27KMPJg?=
 =?us-ascii?Q?DVi6KE3DiAQIGwKjAfPZF3ckxho/Uyz6PIQe5Lya/Gft/3Vsrv04aBUv1Hqa?=
 =?us-ascii?Q?k3tuxGSratd/Af5weyOs1/xjVyEWFXkwSbekEXh0FmMp0KBAcmf2F5EUWtf0?=
 =?us-ascii?Q?fAs98NBFjxf2f35jYj7lBeoQxsN/38Ai72N2ta+T9qEFxvulJQYPpdHPZjUI?=
 =?us-ascii?Q?PRI+d/usbzRHoy5rUvbB/SELOenmcgkeJBzKQb/mRMqNIU+XhFJFP8B2Znec?=
 =?us-ascii?Q?7RbbMhe7kl6Z+lp3lvYpwSVok0vqg4SCu6ZzAUnsuxP1NmnC0j280onKeYN7?=
 =?us-ascii?Q?bewfsmiMhIKDCrwFrx6kL3PM3F/2ZyNOi4GXARypLZV5BGAx8xI+XfHVr1gG?=
 =?us-ascii?Q?KENsHYhBXryBNvY8c7b3rLwYcDvrNbniLfQI71/mp/wI5YHvWU2i/+GkUsOt?=
 =?us-ascii?Q?UqKLYwHwJm1kH0zgtGW/nU8wxCjwFHiD8c+Qzp1xdNAcy5LND9tUrvQG4tNj?=
 =?us-ascii?Q?9zV7AUVQzFqvG1vVwuQNmudOcGgfmzGblh6zrJnMURW3FGBo+qKU7eJaqqb7?=
 =?us-ascii?Q?D2MlYxu1C5lyQoUoVePJXq7GbbG6Bb+QkVOmdtT2/g3TPse5Y+M5gTjJhMUx?=
 =?us-ascii?Q?BaEIq6TrSy1+xECZ6H2JdA3wGaXPy7ekjP3KR7vbuGpHM3eCPlK18GFuWUWw?=
 =?us-ascii?Q?JyzNMtL6lTcFEgy6tsGhJ/EELz+cANci?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2024 22:45:15.7865
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f859b3b-027e-41b0-e159-08dcaf56f301
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A672E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4319

So that this function can be used by other cmdqs than &smmu->cmdq only.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index d11362e9fc8a0..e664c40b14aee 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3555,9 +3555,9 @@ static int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
 	return 0;
 }
 
-static int arm_smmu_cmdq_init(struct arm_smmu_device *smmu)
+static int arm_smmu_cmdq_init(struct arm_smmu_device *smmu,
+			      struct arm_smmu_cmdq *cmdq)
 {
-	struct arm_smmu_cmdq *cmdq = &smmu->cmdq;
 	unsigned int nents = 1 << cmdq->q.llq.max_n_shift;
 
 	atomic_set(&cmdq->owner_prod, 0);
@@ -3582,7 +3582,7 @@ static int arm_smmu_init_queues(struct arm_smmu_device *smmu)
 	if (ret)
 		return ret;
 
-	ret = arm_smmu_cmdq_init(smmu);
+	ret = arm_smmu_cmdq_init(smmu, &smmu->cmdq);
 	if (ret)
 		return ret;
 
-- 
2.43.0

