Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41661BBBD1
	for <iommu@lists.linux.dev>; Thu, 29 Aug 2024 22:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724970910; cv=fail; b=OebmXoyX54EUtA5OgPnrbtypchyxdFdlkCVtbY8dRpje+nSK6KOSxexdouZ4ulKkmJfWNz1U6K6S2Pk8RGMeWMSH8ALikjGpS8+7k6H7WsnidtlacZZHKi7kzz3ETW0bmWp4RJNbiU4RO0s4Ang7f0+a4ai1eh7gCCjfbI5rILs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724970910; c=relaxed/simple;
	bh=nNhekSTZAhhd8A5TVum0peg+CsU3pE+sBh1hJmgVSnk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tN9bGM4W+GPgwYz8txfPAlFuF4jWKP3wrhpH254/EwuaBwt+x3ToNezJ8uSkrtMKhI4Hmcpk58MGM5hHolojt7q86h7Ve0ydBN6u1FvEcjLDg5c+AKRxPGS0eohedOdvZtjmas6ijbBc6VBP2frGWpQmEhZrS/k7AdQsbbykGbw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KuHAB+Ep; arc=fail smtp.client-ip=40.107.93.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KuHAB+Ep"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BRUJdXQNB2NMSL4/hjdGiYQo07DKzebd+uI36C9Ic5kePi+NhxKeBRJiB4zIiVAzv0yd9ziMzcPaykeswRG3mAEYWVvBJEKBA1X4bljnJrlngrWSswAty5c15wGTnAZ/Mo6pqv15G85jDZU/5+HqjV7H68yvLyrgry36GKucsfztuD57vDd4gShAT4Et7aLE20hYAyk+nyMVggGYP5apCXP034OX8uXPo/dvHuAN4Elci/nV8jkCtDzHamS3mLlJZyhBn+E4S8tCufng6BKzRz0R66EfqfAHdJIAFUXrCkke8V21ryEbwlmTNeza5QXt+jxDTIPfospEK0rk64uzHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b9j2y4igiyHvwDhs8TTMfjgD8za7Epa1F90z5Gvfuwk=;
 b=QT1sKreORM4rGaWJHuKyWh7Y5JeZe9UoBZ9YC8ExMnHlCkhkGlmEznu9AXcGVB0Wy1ldHuWrwgM0TNAoj1LkMdeEX/mfHuCfuMj8BG+o17FVk3ZR1w2N5mptktxB0vn5fVnuOhkuoGRnLHU6o1lbegDwExBd3J823qf1ACQEIp9YppQ5IzrTyrffinyMgyX/wt6ECJw3ikQ9GN7vC59cFh4H2NnR9bWPH00LOzviMkJhouTU7cucIazuWU4PcBADgNOTpTt8yQKMe9asn/Od0yqE4vz+uVAU4/v0uPC1AxwTOV69/iMMxsbWpKf/maHXGwFwd6v3HJFU3OUnWzQQuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b9j2y4igiyHvwDhs8TTMfjgD8za7Epa1F90z5Gvfuwk=;
 b=KuHAB+Ep3yk77xYtLC1e+puD2CgzVUqhgbCiKhrfUKE3EicryKOD5Ns3N8eMPqd53Q3ju4x69KoOxOmln6TlU4PmFrDiy371oy23XBu0SUKfh9EdyIfYcB/Z5PDS683qFMUxF4Wqt/A9qCJLtsUSFFavyuw6iJxSxJTVXme1IZsYq7Y7oEQRrvXK494R9U7gfe29in9eckhr0L9kl6hakpNu8dKwaMrQUcrhyuC7WfUfZ3AsjysXhTAj0G4YA1+udnZhF2a5tteJKkzNG/rVV9KRVu+yx2L33Gb4y5wl+9rGcjLo4V7jQoDL6UBLEv51fxHQCahI9vyF6MaerDnKWg==
Received: from SA0PR11CA0200.namprd11.prod.outlook.com (2603:10b6:806:1bc::25)
 by MW4PR12MB6754.namprd12.prod.outlook.com (2603:10b6:303:1eb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Thu, 29 Aug
 2024 22:35:03 +0000
Received: from SN1PEPF000397B3.namprd05.prod.outlook.com
 (2603:10b6:806:1bc:cafe::6) by SA0PR11CA0200.outlook.office365.com
 (2603:10b6:806:1bc::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20 via Frontend
 Transport; Thu, 29 Aug 2024 22:35:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000397B3.mail.protection.outlook.com (10.167.248.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Thu, 29 Aug 2024 22:35:02 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 29 Aug
 2024 15:34:46 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 29 Aug
 2024 15:34:46 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 29 Aug 2024 15:34:45 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <jgg@nvidia.com>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>
Subject: [PATCH v14 03/10] iommu/arm-smmu-v3: Pass in cmdq pointer to arm_smmu_cmdq_init
Date: Thu, 29 Aug 2024 15:34:32 -0700
Message-ID: <e11a3c0bde172c9652c2946f12bc2ceed4c3a355.1724970714.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1724970714.git.nicolinc@nvidia.com>
References: <cover.1724970714.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B3:EE_|MW4PR12MB6754:EE_
X-MS-Office365-Filtering-Correlation-Id: c97d52e6-fb9e-454e-7b4e-08dcc87ad2c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?o9vcSMFNHyrAJzdqfeygMpFsq2OV+NW/6NbEPtNW9inGkhoJr4UISk3u9Piv?=
 =?us-ascii?Q?Bs1zCTgfvPP9icRpPtkOHug7GRqvDwmwMift+x6pYTdW/13kum7D9i3L0YjI?=
 =?us-ascii?Q?Bc2KYmOYd7LDdBT0zjB2sUmUw9pHMlKvBadhrbfI6xGvCV4DMvQJll5At2nz?=
 =?us-ascii?Q?2l4Nzk6Bwc9lwhKE4zQltVLlk8dCtOcVqF2EOn5+/FgqDPWh+LEH/ribIAre?=
 =?us-ascii?Q?3nTcyFpkP+JJ5YIelDubCg/5QYIZKFzx7wbIMj2Owz8upjf0Lazq4TUWZoz0?=
 =?us-ascii?Q?eqnWh3XYOnnusD68mMZ0Kn5jD7MXwxRjhlUb2DEgulWkqlOHx8L4WWTqV6o7?=
 =?us-ascii?Q?HM0g0+P315USRK408fjnLJpjuhNsKfYqhnRRYKX5YkkvX1uBXFvCTIHaaZcn?=
 =?us-ascii?Q?JISyyLiu3JHSSgjYB4ELSV8B255wyC1bQvuDbYuFZR1SE/C1+HGFVvOjDH7t?=
 =?us-ascii?Q?xSPrzCnI53iLUbR6iFskfBgIPBpnzUOV10K38y78gow51yUZ0LV5H3/ZvQvG?=
 =?us-ascii?Q?VmgA9UIuV1qSUwuJLbRVSzPhxivqLW/FD+zZFKnDZsd3ozlgI2i01a79zvFF?=
 =?us-ascii?Q?q6/+oHhLKTxo1BNltC3rURvppqVvSSaasWm7IeFH8HFD7mhQm3xhdOZOyBJ4?=
 =?us-ascii?Q?V5b6wRcTrFQmyi4eSSW+XY0xeDEJk4b9TFqhenxbE4Vp8i8KHVlB8A+cFwAv?=
 =?us-ascii?Q?96KYyNMy3CY+VYkITs/P4A2uoafWQGHgBdpGPvHO1g8qo17SabgMbL4C0two?=
 =?us-ascii?Q?0JmaD8b9u+7us2Y6ShXZKPDuSX4NEx5sSWemi+SLPiCvnvQyaB7/eoaHr3gL?=
 =?us-ascii?Q?1Ner+fL0oFkllFtYX3L+2rlOqL1SzL58dkD3oB3qovVCIAowfHFhvhwbwqiB?=
 =?us-ascii?Q?a13Se1e7sr8RWFy5S+gmUA8ZihC/OTQU2EJqmK5J2FZGnRgq/RUi5yZP7Sdy?=
 =?us-ascii?Q?aiiKs/u0eHssDnSnL04fjThNut9it9DewnGajS3DPfgBO4SPmj0C2dY5VPbN?=
 =?us-ascii?Q?jpYFLGW/Xv6qq9OCP2THg2YXpwQNAv8ajF4Y5gfdMXHWGU5TUd1EWfWg3n0v?=
 =?us-ascii?Q?SMu5w2tlfcDBbMR47uxlGbBSdQuh7gj/wEZMiAzo7Zu0+nZZ7GPaM2nElKY0?=
 =?us-ascii?Q?FJTjEMw5eHvMi2IDO/XSDMbZ5oSYjbhRRbDzDqZMzIIyG103mMei6L7Z2Zse?=
 =?us-ascii?Q?Na9QucWNMuIpGGUitT0IN3O4p+7gyK8eo34pBhw1NAUuG3BvINOxqyFaHkzc?=
 =?us-ascii?Q?AJi1eQyhpTuf27FnmJNvkAJMDiiEduG1nsKsC4W7SZUgUSMExwVZeSrfV5bz?=
 =?us-ascii?Q?0GUOGoKuDfsnA5eqQV8V47lg6+w2d4fsMDRTVptgNQQGue8Ojci1iGJu2X6Q?=
 =?us-ascii?Q?P3y9fZwRGjIB3FnIHHjlRUtFsiQLwzpkCE3eK19URZdRAR16waG4x09/9pew?=
 =?us-ascii?Q?DLD3Hu5OlV6aRyTE2k23CRHgpczvIrvt?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 22:35:02.5822
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c97d52e6-fb9e-454e-7b4e-08dcc87ad2c1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6754

So that this function can be used by other cmdqs than &smmu->cmdq only.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 4a28cd2dc47a..22578d1aa268 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3564,9 +3564,9 @@ static int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
 	return 0;
 }
 
-static int arm_smmu_cmdq_init(struct arm_smmu_device *smmu)
+static int arm_smmu_cmdq_init(struct arm_smmu_device *smmu,
+			      struct arm_smmu_cmdq *cmdq)
 {
-	struct arm_smmu_cmdq *cmdq = &smmu->cmdq;
 	unsigned int nents = 1 << cmdq->q.llq.max_n_shift;
 
 	atomic_set(&cmdq->owner_prod, 0);
@@ -3591,7 +3591,7 @@ static int arm_smmu_init_queues(struct arm_smmu_device *smmu)
 	if (ret)
 		return ret;
 
-	ret = arm_smmu_cmdq_init(smmu);
+	ret = arm_smmu_cmdq_init(smmu, &smmu->cmdq);
 	if (ret)
 		return ret;
 
-- 
2.43.0

