Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013007.outbound.protection.outlook.com [40.93.196.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84E030DEA9
	for <iommu@lists.linux.dev>; Fri, 12 Jun 2026 01:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781226677; cv=fail; b=mYc4M94oHMFKZL9fjdInZuvyIAHINNtWDrp705On0UOqgWeIr+FfWqyXwCY3tk9hY3Tkr6jueeDHgMJc5EZtbCtJbpp8wFuAtTaKFsntjKcljb8e1uiKlpg5pE4W65P7Htd6k7WSFYn9Aj8RLVQFF/+TgTEB84dLgMCUYq85fwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781226677; c=relaxed/simple;
	bh=CfGmGhoDvipTzQtnHIQPwPtIMqJegz7yqjewxNt1JLk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BkEGW0IxBs26PdXDeMtEihPe9fGojn269xjV9XjylPPb3uMEb4DIf1LgumebumFL817GQxyZrVeYlYIvEb7iKjD+LAT8K4M5IlF7Qs87xBvrtZLU+YcJIwqFQv3HA3ODoVfPu5A/AGeNvi6Qqc69IR9+v02lUmyb+SaRwnLOkro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tH+l1E54; arc=fail smtp.client-ip=40.93.196.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tH+l1E54"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Svlyw2QqVvf1iHYWGSWXR9l7/G/vwv0HmkSKqoTA2aim7ZoPsmK276QMDXXgP/xCCKBLsMWtsY193986KhSAQetf7qM35vDlKm17449b7chpzwzqWW5QYvrEu8TDfg4lkO9qQzg1q69wLOmh2XdAykjBJdsWGKL9kIVV2QmtC1nLXjTw1lB92kVPc1ShJVBud8J5o7nrEfKV3aEwMMA9zZIei8vDKCN6y+XISOa5RIvp8bAtjIijNypNwtGcqAb+JUl7eQOh6RsntSU78bagfUELD9qUlOQ3k7Z5IBKoDcwGGGJhzbFiq5v1mv4hgdwYcVUzPO77B4G4gdPsrOwBxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TA4wUTFIIM6+AB46xHbsEe6D37XQ4D8dBfWRgbnv36s=;
 b=kqESlG6CmnjaNahQ0l67J0y1Ikos7e9Qh4+1u3rFjXi/nGz+6syhqUEPfjXAQXnFbnfUUNTNwn8Pi/zKhv6pxn0dQyPkdGY6LwyyVcIRv+s4Ru0nzgvm60Yq/JwC1Q8UxTmWOkTmODH5RHzK535ZvwhfOi8jzVErZVvJeR+S0hIirthPfS4fgMaCok98xyH16U8fDt9EepQsjXpKEIwlng+c/znI+Z442vIxfKnn5ugoxc1BmBAiDe+wtYSWwLsbrf0jQ1ADXcnnoHycM7sAcu+M1khxMtPPnvW+2BQ6yrEYeXwzCmhdvRfzCMmLvanXHWyTgJ/KwA6LnAbETd0rPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TA4wUTFIIM6+AB46xHbsEe6D37XQ4D8dBfWRgbnv36s=;
 b=tH+l1E54Bvnx8ViEX0iKNFJd8yHWjYoOjHzPKRbAsjqIWxSb5Me3i/FHbg8j4dvgnxdJDOL6u7oRpW82doIyv5pRFws6SD7pLgFuUnPAJKKW3pigimwxR5HMYeUnGOG6/RpDIF6YaTLdZRtZMEtW2plPbAGrQ1g4ul7FxEBoPlINz0aryiLHDF7a506zqn/yIbH2mr7U8BGTRJli7gkU3ZH+ftquVIGPUF/0k5aTbK9LtfE26EcTVqW67+e8IXLRCjXd47nX5UO0JqoMTccTfoyaAHzF8HGmyg9gwFN6pvtaS6jkV4jjxDpuWYVvT7aw4xK75whxwtxkogq5qJXntg==
Received: from BL1PR13CA0415.namprd13.prod.outlook.com (2603:10b6:208:2c2::30)
 by CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Fri, 12 Jun
 2026 01:11:10 +0000
Received: from BN2PEPF000055E1.namprd21.prod.outlook.com
 (2603:10b6:208:2c2:cafe::b) by BL1PR13CA0415.outlook.office365.com
 (2603:10b6:208:2c2::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.12 via Frontend Transport; Fri,
 12 Jun 2026 01:11:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000055E1.mail.protection.outlook.com (10.167.245.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.1 via Frontend Transport; Fri, 12 Jun 2026 01:11:09 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 11 Jun
 2026 18:10:54 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 11 Jun
 2026 18:10:53 -0700
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 11 Jun 2026 18:10:52 -0700
Date: Thu, 11 Jun 2026 18:10:51 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <jgg@ziepe.ca>, <joro@8bytes.org>,
	<will@kernel.org>, <robin.murphy@arm.com>, <nathanc@nvidia.com>,
	<mochs@nvidia.com>
Subject: Re: [PATCH v2 2/2] iommu/tegra241-cmdqv: Fix CMD_SYNC use-after-free
 on teardown
Message-ID: <aitcm2qzKGt1czEy@nvidia.com>
References: <20260611084205.686559-1-skolothumtho@nvidia.com>
 <20260611084205.686559-3-skolothumtho@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260611084205.686559-3-skolothumtho@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E1:EE_|CY5PR12MB6179:EE_
X-MS-Office365-Filtering-Correlation-Id: b7b14315-8e6a-478a-3e53-08dec81f7d0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|376014|82310400026|1800799024|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	OV780x1LeOHHXugfxCb3toPX3g/CfIDaB4K61NY/vjKZ3zO8SAB05tmi2y53NCYPtj6iSQIDO2q7Clyo45cdr8bcUeXpVRPmlESjFd5nYt7iBq5wrOfVAP3qIaYYL0+IJKa8zLbvWHTQlpA38pY/rVMmlFNVdMzRHO8Vml8v7xukyXrbiYIdcszra8PohgE9WL8t2QTWCtW34nxbwDtCSwBIIKy23GVVrUTIFn7dsIY2tshbOhHGsvH54dn3DaU5I9sDHPRjDUtZQymS3OY8vyx8tAATbBPIOEPmhzYu/tfW2izUBRaOzDBXSim5GnMk7D83fZFxJuv/E1shMBaQhyk5cj38/GofyrEYzcnxq41OL0IjFxHIA4CUQMEhitJxGI4avmgRtb3xY7fjf62XWAodSLCMattl73/xyhj9rAJpgHQaf0yd61qkLJLe0Ul3oiWTYCac8yoQqljbiALNpp4eQI3JiZXEKMQif2ixNDHVfZeTS5//b42NJ+hZg87ySMhgL/Li4CxTR4TpUi3P28bl/xIhmP3sqYFradYe/EGeQC6PzcNMfN5IWLbnWsVe0+enJVFluXi39MRbSCvcsHjboMKYmXHHXPPHlYgftBiwZRl2EB41M3/9qAs2S9cvO5yq+oBiEBziDlwwFhR97RvaJiybaR7sLbK20zcvOPovhpB0Dox1YsQX/E6lASbcgIhVJd+G+dsfU9OZoUPFXG64K6EaoGsNqZxLI0RfAPY=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(376014)(82310400026)(1800799024)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vSWqqLEys1YKWENSVQyN/DAHDVWuo6vh6vQV45c91zbfzOJTlYfymvMzjGLVARsweL7WsI1049qmjKcSbt2hPf4+I5yu2O6o0mb1kghYT44rZBETdxSPwbYkBNbnlYifxEtBUTxbhnjW5bcnpJeXfXBwR2yYAvUFpovgVPIm9Vddgy/pB2QYnp96q9/bOHTo1zto7XitmTRZzJus6z7T13gz4bz/uROypVgAwX4EvaEDy0A48DSfG2hbTOA+1s2Mh8vWAZVCFmBKpZOsYPnKmaFO23r/0qUGhgDej3+JZxS7voH8PIDBIG6H+Af9iXGFe+BRj5gfc8bpJJLFBVmn0xnficjGjUE5UszNNnG8tI0NwlDh69DnpFI6Q5qbUhHNkRkbyfzwJPYMMIWvBShn5/6eXGrmU8KG4OL18CzI9qoysp8Y1GPTMO5Ur3HJdd+L
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 01:11:09.8964
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7b14315-8e6a-478a-3e53-08dec81f7d0e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055E1.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6179

On Thu, Jun 11, 2026 at 09:42:05AM +0100, Shameer Kolothum wrote:
> arm_smmu_impl_remove() is registered as a devres action in
> arm_smmu_impl_probe(), before arm_smmu_init_queues() allocates
> smmu->cmdq.q.base. On a devres unwind, whether a failed probe or an
> unbind, the queue is freed first and arm_smmu_impl_remove() then runs
> tegra241_cmdqv_remove_vintf(), whose VINTF deinit issues a CMD_SYNC on
> the freed memory.
> 
> Observed during testing with a QEMU hack that makes the VCMDQ fail to
> enable, so the impl reset fails and probe aborts into the devres unwind:
> 
>  platform NVDA200C:00: tegra241_cmdqv: VINTF0: VCMDQ0/LVCMDQ0: failed to enable, STATUS=0x00000000
>  platform NVDA200C:00: tegra241_cmdqv: VINTF0: VCMDQ0/LVCMDQ0: GERRORN=0x0, GERROR=0x4, CONS=0x0
>  platform NVDA200C:00: tegra241_cmdqv: VINTF0: VCMDQ0/LVCMDQ0: uncleared error detected, resetting
>  arm-smmu-v3 arm-smmu-v3.0.auto: failed to reset impl
>  arm-smmu-v3 arm-smmu-v3.0.auto: probe with driver arm-smmu-v3 failed with error -110
>  Unable to handle kernel paging request at virtual address ffff8000891e0098
>  ...
>  Internal error: Oops: 0000000096000047 [#1] SMP
>  ...
>  Call trace:
>   arm_smmu_cmdq_issue_cmdlist+0x320/0x6fc (P)
>   tegra241_vcmdq_hw_deinit+0x98/0x168
>   tegra241_vintf_hw_deinit+0x5c/0x1b0
>   tegra241_cmdqv_remove_vintf+0x34/0xec
>   tegra241_cmdqv_remove+0x40/0x9c
>   arm_smmu_impl_remove+0x20/0x30
>   devm_action_release+0x14/0x20
>   devres_release_all+0xa8/0x110
>   device_unbind_cleanup+0x18/0x84
>   really_probe+0x1f0/0x29c
> 
> Drop the VINTF deinit from tegra241_cmdqv_remove_vintf() so the unwind no
> longer touches the freed queue. Quiesce the VINTFs earlier instead. Add a
> device_disable() impl op and run it from arm_smmu_disable_action() while
> the CMDQ is still up. That handles a live unbind. A failed reset is already
> handled because tegra241_vintf_hw_init() deinits the VINTF on its own error
> path. tegra241_cmdqv_remove_vintf() is also used by the iommufd viommu
> destroy path, so quiesce there too.
> 
> Fixes: 4dc0d12474f9 ("iommu/tegra241-cmdqv: Add user-space use support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
