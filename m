Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB9F28B4F6
	for <iommu@lists.linux.dev>; Mon, 14 Apr 2025 17:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744653477; cv=fail; b=Eol+fAwAEToo9thaJJ3cuLN528vVLaxmZg5++Qpsm6zqrqjjlqNsH2ey9IYzRHkWzL5RqjZzX+l72W1UezixurBDecqnA9ejpjsWk4/qKYwLVjDkK/sZlQl09ud5BG57YOSAjl+xU5QrCNx8bXnQDHEe+JVtRmluiRwbBQqy4JY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744653477; c=relaxed/simple;
	bh=j9mN4QOjUVLatpLLwF4RbGE/VwK4nPxYFAStMn2Bflo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V161s6EduuMTENuvE1HzVdq9uJ3EsGTDetJP9oSUSOIIwbgskWAIUt25EHPcdp6z3Eq2aUx+/E1N3xj48ltr1A156lp36TiJHm/IFgIoE4d6vbTp8YoKRcH/XIDBiu7zeloiZg+vqzwS1WcjjHUzc3ARgoyvsX3Ngz/dAEZ2fgQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FYSYmdJj; arc=fail smtp.client-ip=40.107.244.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FYSYmdJj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hi+SFlvOgwQwh/KNHBDEKTs9M+ZsBXohIFPweTBkcR91XcEZ0fpQiN3H+5Cj3B4TOGHLL8PWjCqYa8ZVv7yGcH9qaRBqBTMrySy2Iz5k5TqB5N9wRaBOli4U+v8bdoXyaoHn5SDSGZX9B49OUjJcoZDYnuQ7PmUel1c1ZhYIi0/WSRD8F8Z1Y7nKWA548RNi03jzyAoA4riPOa57DAI1epTrrOUJB3pMEJIed57Xg0wULzyDLF1L+ztQNzCvxRtRpEERjbCPXLIcAb+2ek7MHBmxOHKHtyYD8DOJ7Xo9sdN7U7CuMrFXjqagq1oUuX6tZZJ8Ny4wFaxeyIkI/PsBFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qVXSVmtSATfMXu6q1mYP0qYLAqfbGQ5ZBK5wbxv4XOQ=;
 b=jvLfyTvP9arwHyIl1FuMlPLCWVfGWlp2SAWzi9e833aAs+bj14QEcJI82WhN/BiK5nc2ip6mGzm25RT4wqxR/eUgx1UTVvM5EURDqXQBZMNEv9j+azG+GeZeTGzPYnqGdve7rXZdqIG+wN1Y84sN4E8+ainL7tuxBBIRwcfegRCReLSPE5DMXvcHzIV/afQ3RozFaBECZfNwoqWW8A8GhkvGQ+mWD+bBLw0mDSr3wJgjzURWKKA0OojAQiFRvXvjkySIOiR6NAkHHvZXhWHOde+w24k0iUAToLlSvtCyd+t8rgdRmaHzCey8W67h43nuarvme+HXFNh4wSOCOCPN9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qVXSVmtSATfMXu6q1mYP0qYLAqfbGQ5ZBK5wbxv4XOQ=;
 b=FYSYmdJj/g1F0/pROB+uDf6zzjtPV9CbFr14mJoOtukjfSaXPuV2igjeuQ+gowJpVWKWgnd3wAKhSuKrlEEojoOWJ/tUM0BtvYtYMWqBefEcl2rVeNNLaALVhGu2FrJc4PFgbzcb4b/9T2aQSKsPL5cRSQRVuOOKLZMaYCi32ICfo/cEu338mwzoX8H/EAkYEpFUsZPj7mmOQW13T/xr1EaPWqxq9hUi/shl1zSDY+meSU9uy7siEG4EjSpXrf/m4BqQxyR9NcYKLS+iGRM8+bghK5azHNrYqVog/K3TiZ31VUH+YFxGgykItIJZyYR+9GafGTaXIS0dEkU+29zcWw==
Received: from SJ0P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::31)
 by MW4PR12MB6876.namprd12.prod.outlook.com (2603:10b6:303:208::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Mon, 14 Apr
 2025 17:57:49 +0000
Received: from CO1PEPF000044EE.namprd05.prod.outlook.com
 (2603:10b6:a03:41b:cafe::77) by SJ0P220CA0011.outlook.office365.com
 (2603:10b6:a03:41b::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.35 via Frontend Transport; Mon,
 14 Apr 2025 17:57:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044EE.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Mon, 14 Apr 2025 17:57:49 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 14 Apr
 2025 10:57:34 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 14 Apr
 2025 10:57:33 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 14 Apr 2025 10:57:33 -0700
Date: Mon, 14 Apr 2025 10:57:32 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
CC: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh
	<smostafa@google.com>, Daniel Mentz <danielmentz@google.com>,
	<iommu@lists.linux.dev>
Subject: Re: [RFC PATCH 3/5] iommu/arm-smmu-v3: Implement pm_runtime & system
 sleep ops
Message-ID: <Z/1MjDaAM4Em53gE@Asurada-Nvidia>
References: <20250319004254.2547950-1-praan@google.com>
 <20250319004254.2547950-4-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250319004254.2547950-4-praan@google.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EE:EE_|MW4PR12MB6876:EE_
X-MS-Office365-Filtering-Correlation-Id: a6f89cc7-e5f1-48b0-03e5-08dd7b7ddec8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vqSZr+mrP9wQp8bBVOwzEhNdvwZIL2AqgB8etG7B5uIJb02srbjaddeOt/2Y?=
 =?us-ascii?Q?AhLfGSA0RsNPf2aP0yGjhdEP9RT+ebGnmgCNjyhZu45Wj+LtSnMyE2JTzepX?=
 =?us-ascii?Q?a1Q2JjAi8FEU5Mu0PAOR0mYZ28U7pjPgFTgQndMORehUptwN1XF4hpLqKkAc?=
 =?us-ascii?Q?+Y/mNMrDDeoQN0gq513Uco0xHlA4seLyzsvt163irNVWJ19WhG/r+Mj/BKfN?=
 =?us-ascii?Q?zVJmpF3XP8sZg4mtSDa0kdVpiMWREbHagHdiylzZyOoQY0Rjilsz8YKSKclQ?=
 =?us-ascii?Q?nMpf9Ro7PFcZAMekaEi/ZnOrgaEMYOtTa2c1Rb/7m+y5yxbnbA64kHEokkgH?=
 =?us-ascii?Q?NDkTTXBIcALG85ltIcjGyHehlrIeL8Rkc0i2uT2Z+P2jGbh7F0Q4RWBVt585?=
 =?us-ascii?Q?dyz/yMhw8LssbFI7VENCZLuiGiR8avLnxTgzsL2DWsjiTJUNK97vEFwcwNnk?=
 =?us-ascii?Q?Z63ShFv0/dBkemPcKQw31vFN9mWu7YgHGT9pF544oAa7CFBY+fdRljv5gmNO?=
 =?us-ascii?Q?KUxYmqjcCLdLM2g2TJ/WS/VB/IXsAZZ9tsx6f4Xr+S2BrzIFbWG4ZZWGKzAT?=
 =?us-ascii?Q?wXj0uYYgb8c6tl/4vkaGrzKuWhnKByZlwIimaA/v8dK4y2Kf0L+ZSbxO1yLq?=
 =?us-ascii?Q?C8Ylu6ImZqurbjZvP1BT0YHZtKJPxPq0bXHrqIsJ3MEN65Ef4PR/8D1WkhQd?=
 =?us-ascii?Q?qsJBdwqA9HwQGIhdlu+J5EOf/e6FydvEZ4itryYtb+JWCQHQ1hI5CVlJWWji?=
 =?us-ascii?Q?sNq9idPLw71mIajlvVfRvSgBmGRb/0PS/sOxMGOvCFrAh7Aut2x9jIlxouba?=
 =?us-ascii?Q?xmGdK8MJUGwFyV5dWpb33n8EqXK1hOHovN3Ruf9aJRd8esZ/UIJjmzDxovxc?=
 =?us-ascii?Q?z98ADOVJU602UHd7JuZ3hBxDtTMRtjOGNghNAwVvXtGOmRFf1Hkazuy9loar?=
 =?us-ascii?Q?gXh8ym6N0igyvqJ9ld0djoOlguwdgCMMec1EveBQ1yrSEQbXm+rftPgjZV1h?=
 =?us-ascii?Q?WHB7pxNhCy9LoGhJRM5lBLXm4MQ+hsByAPR6biCf8bxEHvk1J1iN7Ru4SsUz?=
 =?us-ascii?Q?qh/Dp8cnVB1oOPjkY3RaPXZ0QOza+DOzJ9gsXnpvSCiWbMTCDiIgBX/BLBMX?=
 =?us-ascii?Q?GbqvuCXHMBft4elZwQEs+E5rfFBgNJ2xP9PcAK7jxZbaBK2Gok3BuE7SFBH6?=
 =?us-ascii?Q?OyFGyz5k3pZbp1wQmV5fQK1HTsFQAL11PPvXFs8fn9YSd+EAEBkboL/1P3FS?=
 =?us-ascii?Q?LSjR1ltvgqhx74W1EpRbpPmzG6vn3sc7XhOagn1T91bZsNC7z1qGSocGjGc5?=
 =?us-ascii?Q?B0jdq+x3UzyyEzcaW/z1sfY2+MYxWofwdKqW8InqngFRoDIuGXm34L37JzoB?=
 =?us-ascii?Q?4rH1Xf5GC4yBXpTv6//8+t79EMb6PjLpifm/tK1xpQdMpQUOARW3+XiGVdQb?=
 =?us-ascii?Q?t8swBnpGtEV0LMCFq2lztzsBJCcO7CfQisAGSc/kg0QwEZaxsuLIAGUe1b3m?=
 =?us-ascii?Q?K+uF77MHO04660dTxynZsBVb6hn/dPGvqH4W?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 17:57:49.3850
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6f89cc7-e5f1-48b0-03e5-08dd7b7ddec8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6876

On Wed, Mar 19, 2025 at 12:42:52AM +0000, Pranjal Shrivastava wrote:
> +static int __maybe_unused arm_smmu_runtime_suspend(struct device *dev)
> +{
> +	struct arm_smmu_device *smmu = dev_get_drvdata(dev);
> +
> +	/* We might get the vcmdq */
> +	struct arm_smmu_cmdq_ent cmd = {
> +		.opcode	= smmu->features & ARM_SMMU_FEAT_E2H ?
> +			CMDQ_OP_TLBI_EL2_VA : CMDQ_OP_TLBI_NH_VA,
> +	};
> +
> +	struct arm_smmu_cmdq *cmdq = arm_smmu_get_cmdq(smmu, &cmd);
> +	struct arm_smmu_ll_queue *llq = &cmdq->q.llq;
> +
> +	/*
> +	 * Since suspend is invoked when all clients have been
> +	 * we don't expect more commands to be added to the cmdq.
> +	 * Thus, wait for all existing commands to complete.
> +	 */
> +	arm_smmu_cmdq_shared_lock(cmdq);
> +	arm_smmu_cmdq_poll_until_empty(smmu, cmdq, llq);
> +	arm_smmu_cmdq_shared_unlock(cmdq);

Hmm, I just realized this: with an SMMU having multiple CMDQs
(currently with vCMDQs and potentially with ECMDQs), should we
make sure all cmdqs (not only the cmdq picked in this function
by the arm_smmu_get_cmdq call above) to be empty?

On a system with vCMDQs, there are currently one standard SMMU
CMDQ and two vCMDQs, i.e. totally 3 cmdqs that could be picked
in this context. Perhaps SMMU might need a list of cmdqs that
any new allocated cmdq must be added to, so we can iterate all
the cmdqs in the list?

Thanks
Nicolin
