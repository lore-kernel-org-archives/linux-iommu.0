Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D050E190665
	for <iommu@lists.linux.dev>; Wed,  7 Aug 2024 02:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722996744; cv=fail; b=F9htnDaqsYA+FayVKR1z5CSKm+SFBA2QTHrYLDu4iaiYHlTRIq92yXb5k7oTJHbNuRjLaOmon5kordVyVA05j6FRkD4PgpKBtCXQRRzVGzbXz1yx3fP/11S3vLr7ABaWoo0uchPu6mRMcti0eA85HS1ENVyjzDt2mVe8G3jJ038=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722996744; c=relaxed/simple;
	bh=FOtxfxaYAoIk8xIeO1iXUaPa5UG+9sm2MTVP87KN7e8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HxU8UPmaZoQjGZZ2/WohBsR4s6QWkuvGeQNqWlhPlkfSq3C8HkGt+Ae0y+rhsmmXtoo7uWR6vG9CTCE11tZ5/wX1svuaC/0Rhzjs8FMCc31PDmycf4oX1gHWLzhSUO7ywMLW45GiKImJK12lgWNTDWhI6sVx5s/ABm13Rac597c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bp/J4BE3; arc=fail smtp.client-ip=40.107.93.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bp/J4BE3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j6eqBUrCv37N5tzuNHtJ35SuLadlsE73zgck5unkwrtP6QpgO29pjZ7y388H8gRmIsqqluRhyeymvXhsqkDu2QhWO1buJE6H+SaCoF69joqIpkFo80d2dml0j39xXxHehmjY1p6caTojsIYHpOmmcDn26GcL2gK4O47B+8NrwtAs3nUjeBzdTFGUJLiKDYHFDRMqAefIOkxtJUNsQdYPsf1sPKhr0PCAWIQCDAtLe2Iwmaf94Y27mTvn5ZLxtxtRYK2uafqbgNGSSaOZXqPGqQmNrX00DdUz5oiZDFnGKDoTtDUFfoFfVKjTJHSyk7SQ0wo8yJ6ym9zyw/ahTBaGTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PH3fZGMEtUGhGnMQbl1O/tOUaALDMgL8C8OqKbkEp6Q=;
 b=oZ/o/d3vENs+g1uFx572K2gMyTK5v1uMIrYV+DkQsqorNfAvWi1/RstbtFsLpcHfxi1rhjKyRgT75LqUuOzsasgoGa367KjmF4QABlpX7Udke8Ko/G36RTcoufJvpBs+s/fVLmCuflLsS0mgub8/dEr/VhxRNaKsdA92G71qD4GuIFABguwVMdoUVzq8MUWea2KXcfQHYjaDE47zVm9hmvs7p1WzehmCM+Jcb0bz0OED3Y9zXDobSsCFriS10UFVuFjUT9NjMCD0qFE7gaBSi0sYucISY4GE/0bay9D+UAN5c/MGiDVNsISTzu5Hx5Aaxfx+B6SFUqxuBLODJ0Wpcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PH3fZGMEtUGhGnMQbl1O/tOUaALDMgL8C8OqKbkEp6Q=;
 b=bp/J4BE3UIJKR/uqWsUhOdbGjwbkXwY4B/tUbDiPUZwKvJMbLmSEiLt9oWeqEqOhXefP6u/L9GILEK6dsbZFDcsSnKo7qXOGSk9enpWNjHAbxogFJGN2ld/fzlCgYkeOG6Nq76AxtfqwHrt9BQbdd205TSDnD7D3aFUH/AjHhFxxz8JVJqTk/a4Gkr50Xauh6gZMgrYERVifVJMtwndKXv74tyze8iGJLhAp04Cm4qgC9BPqdvckUaIWYvmgQwo4xK6hCxHbkFBUfqv5HN1kq1Kp7+dhETHsxOaPzeO3nXsk1ObREz+YjtutQA7Uc3n1CXN2qC2U5BBHkhsnd+nd5g==
Received: from MN2PR20CA0034.namprd20.prod.outlook.com (2603:10b6:208:e8::47)
 by PH7PR12MB6811.namprd12.prod.outlook.com (2603:10b6:510:1b5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Wed, 7 Aug
 2024 02:12:19 +0000
Received: from BL6PEPF0001AB76.namprd02.prod.outlook.com
 (2603:10b6:208:e8:cafe::5d) by MN2PR20CA0034.outlook.office365.com
 (2603:10b6:208:e8::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.25 via Frontend
 Transport; Wed, 7 Aug 2024 02:12:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB76.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Wed, 7 Aug 2024 02:12:18 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 6 Aug 2024
 19:12:02 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 6 Aug 2024
 19:12:02 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 6 Aug 2024 19:12:01 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <jgg@nvidia.com>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>
Subject: [PATCH v11 4/9] iommu/arm-smmu-v3: Pass in cmdq pointer to arm_smmu_cmdq_init
Date: Tue, 6 Aug 2024 19:11:49 -0700
Message-ID: <b59ddbb8e30303704fa054875162f1280c9512dd.1722993435.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1722993435.git.nicolinc@nvidia.com>
References: <cover.1722993435.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB76:EE_|PH7PR12MB6811:EE_
X-MS-Office365-Filtering-Correlation-Id: ad4ba053-e0e6-400c-0d07-08dcb6865d7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uv1ri9t4b7jK9nYR0EGvXxeAXB/O7ANEdYRCusa7RMCjEl+ToJKEFVJncqpZ?=
 =?us-ascii?Q?y1mNVAbsb2FvvtdpZBkJtRg7prwVIQYa+OCwYBwpwZjenUYHHXov/9FQG1dr?=
 =?us-ascii?Q?ky6nCTBFdKNKwA9YniRV2un5rRr09paoXVfjyaKHjGQ38Suxbz/XNCD8FV52?=
 =?us-ascii?Q?4r0x6Pi1C6y9H03nNC2Xfd8fI/pRiWtXDTCjJ1qHpgAaICyqxB/Zi7u+Thp1?=
 =?us-ascii?Q?QLZWJ3vfDO2NWYtjPKZpFGdNIbyM4ggQ15MS87nAd6nh9vhjfnw6yf6kzZuD?=
 =?us-ascii?Q?/JFYpibNriZvC+raAfm9ZXwEgptGeLAZmgNJ01OE5YnpsDl1mQPo0EhZtEbg?=
 =?us-ascii?Q?g1e9pNpRWhcZX3jKYeFDsON+xxuqeTs1UQ0+Z0V/A0noTLLNEJhEWJ1ABve3?=
 =?us-ascii?Q?HKzOOAyC+OxQUQC7GtgLzTwSQLnafiePbPOnqDO135eJV4PGAcqhAg3OqVkI?=
 =?us-ascii?Q?BizhLk1EZ2owfjYDu6G2PRwSSDX+XBPKSjsZsoCN0bNB8HpMJOW/xDP9S57L?=
 =?us-ascii?Q?QsueBQzh8yJo8tNxzUDANtR/3yYUnpyKssDgGSClnFfyJQqqlh/LuHkMKKq5?=
 =?us-ascii?Q?2KNMJu8czTbHwV1LVFqBKIE4MO/iaRHqjqRaceswIvKBU0r5ejzEoz/VefQ1?=
 =?us-ascii?Q?yES1oCDzyPUN3tXZ392bzQ+7jdOfLjolT3iMhxkrfno5OpCcZ/FV1TbRFTTS?=
 =?us-ascii?Q?xLb3SinNNhsG8OT4/9CDiI+moURhBvoyOQrtBUuZL++VVyw5KxoxvlWPwkV0?=
 =?us-ascii?Q?ncw+A8Hjsgu0BvbeWuLjyaA0edcsxGVcggYcr6KwyB6MG67iZUC1OWtA3yEz?=
 =?us-ascii?Q?8m0m2E9duTjNHww8ckmDHwgYdPdgN+aPj84ICHICSV+vx7EZtP4nkbaqyTXu?=
 =?us-ascii?Q?AxmXNvg5bRFmigW7Xfcw4M3bkiWSywSnfapI85+HlXVEvN/HcR/3zy8r+s7B?=
 =?us-ascii?Q?aALp6dpFo0NvYPWU4tDeMium4cy5SgeAvnAuVkn03r9RdBNj5u2TGcVG/mbr?=
 =?us-ascii?Q?FAWfbv40RudQDqDvrUl+l/y1RDqdV+vVuOKgpAlYbcqwjXaz3LjX4PI7+37c?=
 =?us-ascii?Q?ciFb/N7lqzxNAWCK79u/HFsqGdE+idcT3wjOCsJM2H7FAEEeEpzMjbKjSss3?=
 =?us-ascii?Q?+cgkisdn0poVwhnhEAUlFq/1iUDv6Zq4iwxn/TWQ+Z6OVP2RypHDUybwWBP7?=
 =?us-ascii?Q?Zq+4fIq7utBOg5Q8Ep1Ycac+J18sKjPhGs06mppcXsaMSNXoBx9M50OF39pd?=
 =?us-ascii?Q?92GqUUz03sGund/4KdW7rSR+kxlgyfdsvWSZGMUG6EHzbujnmOwYXod6itS/?=
 =?us-ascii?Q?M8fgTmsIrv8zw1fsOlh6bxtIRgF2SXj/UtYaKXzv0YTF3kiBufUF4DXPQLN+?=
 =?us-ascii?Q?2OXtiXWg8GsZKiKbHHjAi4bPA/xoF7Lrw0ykjAghQZ97hhc7wN0RB/AkZ+Qv?=
 =?us-ascii?Q?H9BYsYzM9NjJd7ttod25x31tJAckMReD?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 02:12:18.8111
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad4ba053-e0e6-400c-0d07-08dcb6865d7b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB76.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6811

So that this function can be used by other cmdqs than &smmu->cmdq only.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index d11362e9fc8a..e664c40b14ae 100644
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

