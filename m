Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013053.outbound.protection.outlook.com [40.93.196.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFBD1D5CFE
	for <iommu@lists.linux.dev>; Tue,  7 Oct 2025 00:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759797902; cv=fail; b=gLa/d4SjB08Z013usahBYTpsmyFUZQBYwX+P2SV2U+JWHe61wI/4ykGOSAKxWoniGrgGycuuDI1BL84bsCU+055MDSOEzkafhm6RZ47P7uznk4fHSBIq5yC1P3a0F9bbP44T/Hyli9SwlI1BiLbFdalyDlTp9lgBajghkdcYx5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759797902; c=relaxed/simple;
	bh=3VI03Vl6cfbTv+Rq6J0megyYFb5aVXuS2zNGfuCy/T8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rAdFV73V+V3xy5sOnSs+2Nf6JRkp4tTPO7xDZEhxxEZMZ5VjVlQ4NXWHFjngXhnl6obFo1A3vr9sDFpdf1RZblwRXVwhEPFkaf0dfhA3bPERufyr6gC25NadBDDHxCgO+hUcxyX3snfPGqMtvIRuWv/wU1rPHytRQoUUG95KrjY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=X9kRhmbP; arc=fail smtp.client-ip=40.93.196.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="X9kRhmbP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mey0YXbTBO3qDo+4r9AfQDMewR6oRbvjhl53ooW97rVM8Jb3evKfHUq/IVeXtRkW4eEcChNPRe5tilCUsUOcLviltlgZlt8vW/vOcZo+LSGzykuV7Agt6zoyot3QcOJHgDp40uI5yhKkP7Ho3+BbNZtZ2KjKoxJAjAZJQgMZEV0zvWSVW/K70sRxtabuLoauzzeh83dv3eszt6EfA488GUdl2PORvl1mCF/eFPzRXJy2CRXUsm5MAWf7zwCS+ldjseGZ0i44+nW6v6SZSK2TGP4Bgz+TqSpYijvFV+jZKmWl1Z5LWIxDwnS7z1/DJPO0kkrR6YYDxFUxK5lO+eXMeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a/bYSQTTHtzmR8EKSUeP4pcVWy1ouqcJBIdJRUAr58E=;
 b=ayl8dEeIaANz2K51XDcu3CND5/WsGrz8Nw8Wi1NIwjbnZ7OgyMhYInFXDqc8/ZbkLNmLeeJ+K2rFaZ9ksn20YM7qTPcsftbc8PA0pcb1W0btoa6Fk/eZDs6GN75GJ8981vav/J0fL6V6ncFZb9LjDbvs28tH/PTBwq+otSlmib1Oz0vCEtNQ5DchsdsKRKT90n77t6teir2l8kPzPYhAeCLCjBfAf1cTFNDMFroAVtF//lrkUTVS+IPUjAFPLWW2MtR3j+83jQ4x7gQ4dM553E+zS9SgSQiTqYscGreru8cDZS3FkI/aYvgGLlhp/fbnKC4IheSSBwcie0VNOHmK7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linux.microsoft.com
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a/bYSQTTHtzmR8EKSUeP4pcVWy1ouqcJBIdJRUAr58E=;
 b=X9kRhmbP0xjQL9bVoYaIiNcno50d5UspvCEl5M06M9VfPjyz6zKMaNwgwaPZUOyc64H43tBKy67vyCkkbNNDmUbl1b3d2mSDWC/oA3sWzCjRKtRDbQxbAupg9vps1G318vOod9lb1HMFT/dv8dy/BdBAPPryQ4AtiRk+SZDljw8Y8vNKFI7cqptxueyoOO9f5gnCoT8OGqqMWW+ck2lAiJ4uhQZ3oSNzZIZ7A02+lvG0jzR0mOtXkSR/0uJRaiiHnMFjPf9GY1dMrfHk0oOzjR5dncf5U72SwKmdxA7ZB+JtMjFfmvuFQPpx4ZYPzNy8Hod5awVfGM9lraC2wonjpQ==
Received: from CH2PR02CA0028.namprd02.prod.outlook.com (2603:10b6:610:4e::38)
 by DM4PR12MB6061.namprd12.prod.outlook.com (2603:10b6:8:b3::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.20; Tue, 7 Oct 2025 00:44:51 +0000
Received: from CH1PEPF0000A348.namprd04.prod.outlook.com
 (2603:10b6:610:4e:cafe::d2) by CH2PR02CA0028.outlook.office365.com
 (2603:10b6:610:4e::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Tue,
 7 Oct 2025 00:44:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000A348.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Tue, 7 Oct 2025 00:44:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Mon, 6 Oct
 2025 17:44:41 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 6 Oct
 2025 17:44:40 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 6 Oct 2025 17:44:40 -0700
Date: Mon, 6 Oct 2025 17:44:40 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
CC: <linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, Will Deacon <will@kernel.org>, Jason Gunthorpe
	<jgg@nvidia.com>, Robin Murphy <robin.murphy@arm.com>, Zhang Yu
	<zhangyu1@linux.microsoft.com>, Jean Philippe-Brucker
	<jean-philippe@linaro.org>, Alexander Grest <Alexander.Grest@microsoft.com>
Subject: Re: [PATCH 1/2] iommu/arm-smmu-v3: Fix CMDQ timeout warning
Message-ID: <aORieLYckU9YLdVF@nvidia.com>
References: <20250924175438.7450-1-jacob.pan@linux.microsoft.com>
 <20250924175438.7450-2-jacob.pan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250924175438.7450-2-jacob.pan@linux.microsoft.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A348:EE_|DM4PR12MB6061:EE_
X-MS-Office365-Filtering-Correlation-Id: 201aa90b-7820-40da-44bd-08de053ab9f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gix1G6MAzllaGSeuxYTG96mo4qii3JTlu/yUgiLzuvfm/Z0RoXvAGC2vWnjd?=
 =?us-ascii?Q?MWk8mhXtjvofKZnpBc+cIRcifMoZrOKByjgvj2ibVzaIL/nHLV4FZUKegwwX?=
 =?us-ascii?Q?FMhj8NFbFRS7eSAdESdic+ZdFOiFv0yzZ4Rv54UEvbPw9BTNfJ5Exc/A0XY8?=
 =?us-ascii?Q?fD49icrSEo99rEwjNZjFvny+nHHGkSOrmHlzD6v46GvDHzlaSxopuHYzNdSU?=
 =?us-ascii?Q?frJ4Eo4Pdx1X8Jr2rcQU4nBpYqJPr2OtIhJROz0WlYE+DE0qj/adhQkkHZII?=
 =?us-ascii?Q?GbOiDHmIbzpiQwv0SVMX4X5JfAUD6BpqsYeIgkJwFPyr6f1DBozMkNmE+to6?=
 =?us-ascii?Q?Gql0gTvsjcQdTeb6kkLkp+ljALkHPT9JCXwysrQgPiRv5voKUFG4mG/590E4?=
 =?us-ascii?Q?Y3AUncZB39bhsvc2ddivEK4c12xcnSRKfd6dZP4DVfZwyYX3iEJY7bUrMNIu?=
 =?us-ascii?Q?2v4tGxbTUj5RMPaliy7UzbnOYPi7Ln2JDeY8+40ZETCHHKe+hf9Z9OtNn76T?=
 =?us-ascii?Q?dBf6kaajU27bst5CquopU8EB4gN8rVR921sv9S8YYm2XEMFpic6XLOsKPgiZ?=
 =?us-ascii?Q?2Jcvao6N2ERBFJsESeroEvXZI8KXpRptvwp2sQKBm8k+WWhs3Is5heJsL6io?=
 =?us-ascii?Q?d6UmX8P71QuEbDf+7ViST7+XWeCatER2Nh3P22c4oJ6i2JEJClxB/DgevmSS?=
 =?us-ascii?Q?iGIcbbQRDfCwWW1iFhXiGvRc6s37mvG28Y0OP1UbrKtumsLLZzx5/+jVyyrY?=
 =?us-ascii?Q?eRpa/aTZkD4EiKCnBKU7u05HtF3zV7/B1PwymwZR1x3dGFZVjvwVvHv4yn4p?=
 =?us-ascii?Q?wrFjpko/+8bBNyJEnalK/d26DnbOjyy4K7BNW8mY7jNDV3LLdn8clIa6G0Tf?=
 =?us-ascii?Q?9Xhua1qOTHNwuQYhvq69S4jtR6AHpX5u5VXHdIzVPHC/sm3kKcoxrm/pRjlk?=
 =?us-ascii?Q?KXHnL/9s1+Np8qTbRqyAWnJoeMBmiwlAT4Wa7gMBTvfHIpfy9fE3NBw+H7eH?=
 =?us-ascii?Q?aG7wKe18M9Y2GQWqsf6HXEiVVp0idYUGI8kHADV5/mY5DAoeZY/8k8xCgBJB?=
 =?us-ascii?Q?3xgVwN2HcaRrFrANSwVWq3ZPOjSFmguZklLIUQd6XsvpytGI2gup0pCk3bOr?=
 =?us-ascii?Q?dxuzUFlA1IaVLGIdIRW4cFfg3vnbdy5hVlG0Nd9rvZhTy0zmcdqwe9LNgoQo?=
 =?us-ascii?Q?ZyCnJjyccK0xQqssH7IaQHsrXkNHIFI9HoH19nDSJ5bBO33z1M3rYWlFF9ey?=
 =?us-ascii?Q?v7pC7gUICFubLQRcjUBwA92MHDrgsNr5TOmBuzUbT2UebJBlW3xbaYC5pw21?=
 =?us-ascii?Q?OE7NOSoSzMw6NJNrU3XdbzZJRvd3NLGUeRx2krD/dNF5oFQtqOgWNWsNJoEV?=
 =?us-ascii?Q?Zj4MTagUHcKYRpVRun4gFVzb0IiRIZ1oaWw9H480NgfveXw7vGnWqj4bMMM9?=
 =?us-ascii?Q?JTTu/IWaeHmVqOkE2df/MUB8abtwstJ4z5/pkRpPpb1U3XAwsTib2vQKqtIn?=
 =?us-ascii?Q?OtlmmZm7jXCHdVJr1K3/mTnavSWBMAAzLuI9VKFuYafyRRQyvuYSCoXCeRz/?=
 =?us-ascii?Q?CsTtJBpekvyR5ljv6/Q=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 00:44:51.7553
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 201aa90b-7820-40da-44bd-08de053ab9f3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A348.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6061

On Wed, Sep 24, 2025 at 10:54:37AM -0700, Jacob Pan wrote:
> While polling for n spaces in the cmdq, the current code instead checks
> if the queue is full. If the queue is almost full but not enough space
> (<n), then the CMDQ timeout warning is never triggered even if the
> polling has exceeded timeout limit.

This does sound like an issue that is missing a warning print.

> This patch polls for the availability of exact space instead of full and
> emit timeout warning accordingly.

And the solution sounds plausible as well.

> @@ -806,10 +769,28 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
>  	do {
>  		u64 old;
>  
> +		queue_poll_init(smmu, &qp);
>  		while (!queue_has_space(&llq, n + sync)) {
>  			local_irq_restore(flags);
> -			if (arm_smmu_cmdq_poll_until_not_full(smmu, cmdq, &llq))
> -				dev_err_ratelimited(smmu->dev, "CMDQ timeout\n");
> +			/*
> +			 * Try to update our copy of cons by grabbing exclusive cmdq access. If
> +			 * that fails, spin until somebody else updates it for us.
> +			 */
> +			if (arm_smmu_cmdq_exclusive_trylock_irqsave(cmdq, flags)) {
> +				WRITE_ONCE(cmdq->q.llq.cons, readl_relaxed(cmdq->q.cons_reg));
> +				arm_smmu_cmdq_exclusive_unlock_irqrestore(cmdq, flags);
> +				llq.val = READ_ONCE(cmdq->q.llq.val);
> +				local_irq_save(flags);
> +				continue;
> +			}
> +
> +			ret = queue_poll(&qp);
> +			if (ret == -ETIMEDOUT) {
> +				dev_err_ratelimited(smmu->dev, "CPU %d CMDQ Timeout, C: %08x, CW:%x P: 0x%08x PW: %x cmdq.lock 0x%x\n",
> +						    smp_processor_id(), Q_IDX(&llq, llq.cons), Q_WRP(&llq, llq.cons), Q_IDX(&llq, llq.prod), Q_WRP(&llq, llq.prod), atomic_read(&cmdq->lock));
> +				queue_poll_init(smmu, &qp);
> +			}
> +			llq.val = READ_ONCE(cmdq->q.llq.val);
>  			local_irq_save(flags);

But, couldn't we write a new arm_smmu_cmdq_poll_until_enough_space()
simply replacing arm_smmu_cmdq_exclusive_unlock_irqrestore()?

This whole unwrapped piece is really not easy to read :(

Also, the new error message has too much debugging info, which could
be trimmed away, IMHO. Though kernel coding now does allow a higher
limit per line, that 200-ish-character line is a bit overdone :-/

Nicolin
