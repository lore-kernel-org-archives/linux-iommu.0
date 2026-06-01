Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012060.outbound.protection.outlook.com [52.101.43.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67B52E285C
	for <iommu@lists.linux.dev>; Mon,  1 Jun 2026 18:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780339061; cv=fail; b=cc/AqyIbbgW7i9d3XRb22JkQO18UjLGCR8tQv3Wd4UutxGucIrHVso7R6bxFjieLpZtmge2QfDtB7rlDrPZv5+Tdl/lVekYvNTHSAIJKPrAASVwUpl1/TzvMBmk/OsgljSdpOFV9pixOi4TsrVSdCnvC5tTMQhN7xmy0b8HSKMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780339061; c=relaxed/simple;
	bh=Gboju/j/hxo4Bjn+XaOJSiwOa48phN7qYDRls8mN83Q=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pYpS9OzIUq+UXL21oyBICsjaopD+cmOBO449CDnNmZEKpNvmE1NSOLGhheahdlGWnQnefxgbCQxKOSJ3CScpFLHQGkH+MJcQeIAfQRtMi5dKAsWMt/BrnX0qQ5HziNKgnk0txtdAW3ncY4ivclWSe0l1K7OFZhkmvb0p3r1npQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tiGj2YC5; arc=fail smtp.client-ip=52.101.43.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tiGj2YC5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XTpmloNUJ5SBhu7SemmzvDvg/gUjsiYcyd1lZZk3I20X52cbnlxbIhgj7iMyIQe3YBmteqNVSAVwoInhOVblQ5rECpBHHgRXp9Tt4gAECFGkWo+7g683cQASE5rkIy+ymNOOFiZHEBecdZh9tZCzuHlMwvXpKwyvUgg/o955VqzT7uvEtlyMaYvKkWiC17SiIfWp+R2ZQW3h+LqRJyzrZLWBtRJfg4pcRTJ6ZrBclEXYOFMTqwWC2po9m4fOaLkcRPbrWm1HYWixf9Z8sxVrEKYKsFfrVhXY1zSlC3vEaylgoN2vKrz8veucKRpvDezNzwG4Dg25ttvjcOsqlEylXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/M00uHPrpXxNXVNsPXsHUP5eB6DH2kYr3bGxAcpGoJk=;
 b=yQ6XINDgTz3xCr0xH8TzcNsRT+gc24eVoGl8Pqe+sRW9FHo5ec7sxXZMEbvcOdTPaBazxE/aKlBO+bGCHfPfWFXpt9abBXwpmHyLIvc9Y0U4sOu86Zp+3aQUehtVgK5q+40XYkjlZO8r9D41D//XfyghpZgvVrUWfOHOayUCSYyI4qsvf62xznWLj7MKEh7Kg+Fi4BSxUaERwj7oZfe1hlwx9/D2foYclPBzr2QwhHUj5VyOMajiCmFGnqnFV1u+ynNfBkvMh4c+CF6z4TgnTVq7dMI19SmcOVT56HFB4E4YBaTmUrbB3v4v4zkn+3NZx96ARZJUaSv8gKmYW4CXgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/M00uHPrpXxNXVNsPXsHUP5eB6DH2kYr3bGxAcpGoJk=;
 b=tiGj2YC5o+/PMpXvuVJr81G3qkCbs4VcDoXhjQmFUCOzJ0zTYh986HCrW9UXjTW760ZpMfOlmwKVUDMKaEW4iLrFGC8O5U5DD86e3VnoKjodypv3qz2I8+Wcpw1HCwSmORe5d4N7XmrbxhrTMFjCE6ctc2YVVqDVPqTRCAfdBujJUpwhBsWLkqQ5UXSVLhLu4qyjKcc4dghj2BFDnPSwGQsJXVicuvJK9u6VZAyh3xDveGFoE/3YPxtv1+28WvsIX08qWgZ4OKJacFJVbe7JPhpNRE5o6lqMIzaxmNCre8/fvejZjlsOIOfPmZI68QMPvkNAG9+myhSCGU/0EI/SfA==
Received: from SJ0PR03CA0371.namprd03.prod.outlook.com (2603:10b6:a03:3a1::16)
 by IA1PR12MB7757.namprd12.prod.outlook.com (2603:10b6:208:422::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Mon, 1 Jun 2026
 18:37:33 +0000
Received: from SJ1PEPF000026C3.namprd04.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::8b) by SJ0PR03CA0371.outlook.office365.com
 (2603:10b6:a03:3a1::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Mon, 1
 Jun 2026 18:37:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000026C3.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 18:37:32 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Jun
 2026 11:37:05 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Jun
 2026 11:37:05 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 1 Jun 2026 11:37:04 -0700
Date: Mon, 1 Jun 2026 11:37:02 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Ashish Mhetre <amhetre@nvidia.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<jgg@ziepe.ca>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] iommu/arm-smmu-v3: Issue CFGI/TLBI twice on
 Tegra264
Message-ID: <ah3RTuCc0sCNE/eY@Asurada-Nvidia>
References: <20260601104845.995005-1-amhetre@nvidia.com>
 <20260601104845.995005-4-amhetre@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260601104845.995005-4-amhetre@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C3:EE_|IA1PR12MB7757:EE_
X-MS-Office365-Filtering-Correlation-Id: a8b3a662-cc5a-4626-9868-08dec00cd7de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|376014|18002099003|22082099003|56012099006|4143699003|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info:
	unBglECXLg3wa8TM3s3l+ksEqDCNU1hlc90L5nNfAVNblSXxEvrrcdSG4+AUv521i/1Q0c8id2ddcHcx2gSskZFPfBXleRqkwxQuL4fATV5WJcFhEr0zPOcdLk8wfNXu4AWTWVEM1WpxM/wHQtrde/8RTjPGMoHZy1Qai53tkjisq8E6TBxbZPe5nZwkPzfC4n0JxOTwv77mb6YzAPaD9hjlPdvhuzVHwuzV/JhQewZ7wxoOJiivzeKR8S/dRtu/NN8K2rO9ab91dNs207DzcTMDPn3QGX/MQcz5fJgJdeE0AUDq6mhETmVbDAHSS8m6+xTsDyDsZNbzU7EFlhqWrhZY7FKTooq9w//1XjtSYB0vW50L9s3t8UxzM5L1N7gnxhYv5PA9JhODDb+ZxNuAm19LVBh+gojG6Ghy+zSIkyP5cVd3CJGcb1aGUjWzqyTvuhe1isFVPiCdk1yWOzEoFRWiWOSQ6s0Q2VKBn2f4fwn0Da3fW8KDulU+LQvadbKOVBOBOD0b4imSJCUUh/gIygikqTz4/PXxWE3ZV1Jt4/Duy914rFEXrrv2nCnf1iny3K/KwumI5g7KAdXdLN2Q/IcCs9SAZRE/pJc0wvmMttm8qs4IT/mF/VcxBxL5hAeRqL+YA6WD7wgufXSaP7tcmYGHZJ5EfnpfdbZ+DIzIq/W0tcoR9s3oLai/eSwXVcnNCyZwQVpINRc167EAU2xMqQaAcJ1ElZDsAQVeK9faq4Y=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vq0kAIM9HKH4B4GBa7HKA1LEgRLNgDeP2Z/6nl7VDg+A/96v6CXtV9F8ozBVUjditYC7iAGcjWAam+PMxmUeB+Qq+lOkDgZqlznCXV0FtyJLgdOJcnNSIGSOBYh2WDEpLCYvdLWwtq/Qds+0cBloHM9oXiwciYwh+C4uQjxyRWJoUhJNjkDwOTlnHfq8VIg/EM1znI5trvG9d0UjUv810YYSyzUQ3PvFmqecbg+oqJpbWif5rQMr+0w40mxw1H0STA55V9lJh9ig6rz4byDXUGSzb3D0YRQXi/f4vaIBBhGZ0y9durAb/tXO62wu4+q3qtxU0w9mRaEvsUgv5h7cVHCoSSZVMsbr//LiURsA90k9ZDQ4rU2ivlx/nuln474bqF4a/AJE8jnG4zRF2mLsnqiDALKA2HpcmkJuKEmaCeFjabh/YV6mx3Yi43FIivHj
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 18:37:32.5583
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8b3a662-cc5a-4626-9868-08dec00cd7de
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7757

On Mon, Jun 01, 2026 at 10:48:45AM +0000, Ashish Mhetre wrote:
> Apply the workaround for Tegra264 erratum ARM_SMMU_OPT_TLBI_TWICE by
> issuing every CFGI/TLBI cmdlist twice on affected SMMU instances, with
> CMD_SYNC after each. The erratum requires this exact sequencing:
> 
>     TLBI/CFGI ... CMD_SYNC TLBI/CFGI ... CMD_SYNC
> 
> Rename the existing arm_smmu_cmdq_issue_cmdlist() to
> __arm_smmu_cmdq_issue_cmdlist() and add a thin wrapper that, on
> affected SMMUs and when @sync is true, re-issues the same cmdlist a
> second time when arm_smmu_cmd_needs_tlbi_twice() is true.
> 
> For the in-tree batching path, register the Tegra264 condition with
> arm_smmu_cmdq_batch_force_sync() so that a full batch carrying
> CFGI/TLBI commands flushes with sync=true.
> 
> For iommufd VSMMU path add an arm_vsmmu_can_batch_cmd() predicate that
> splits the iommufd batch at cmd which doesn't need doubling.
> 
> Suggested-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
