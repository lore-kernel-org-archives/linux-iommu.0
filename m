Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011024.outbound.protection.outlook.com [52.101.52.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B40042E40C
	for <iommu@lists.linux.dev>; Fri,  2 Oct 2026 16:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790960237; cv=fail; b=L7/RNGDNuZMyTNQ1VlD5KARrnaQfNHgf3zMC+GFNNm6vwDWvkt4Oo7w5t+jKeRAQLNJPgigR5/bZFyDUhkKMp0G5h6hSn7CWb5bmDKxxXbSn1a0MG1qDcja6vy6WF1gKeQ+i3TcEWOBPZftISSJj65wt1OD6+K+mHT6sWePhGoQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790960237; c=relaxed/simple;
	bh=qTei+h8bZyYRo5GqZlt8hrCoJr6xMGDaY321nSbjmhM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RCr2o7ZufwQKcU9DxPbsbiqadKC9nUhv9hKXn+LGEVXFQPy4gXUVuPzpvpZoFCR8dusiZzlN8mBY0Yv4s2xrINMdNiSiy7TLxk5D9UrmPMdnGGdXtXGYTz7MEqP7kYKE4UpLI3M548qeffjKlBRnO+M8avHx54SwgwdLyd5Hv9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UATf6yHD; arc=fail smtp.client-ip=52.101.52.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UATf6yHD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fxuv3yyxvk2Aqqn/G74KtWcYJtqCHwcMyric17g/+uvAaZ6G1L/OijM+AmcdThKyP7eu4tIpW1Mg48AeTkpWuwLNPhKRhoEvgnVYHQjCQ5SyEY22MczYEf+VJcV9lKMur+BXt6qdV5KS6aCVX1edUp0tj4dezRTJu2/QUoci2dsdnJCokfALve9yqrUk+qVekgUNaJHYdg71aUcXl2VFfpnNCi/2baYuS4o1RlRnwJOjW6ZSstO5awlm6LcdPWh/KLV58e7vQjxZtAWGRxpzzw7NUat7Ja4LJ/QHaKFXqn7Yx5aE4GdGLmrLlykPXUoeKyspb1vK0FF81lLbG3wHRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vcz7E6rg7mDkodQi5uDNQ1QWRcuxfyIzjw9R+DrgHuU=;
 b=QFqqsnn3asCmG90Ddm+5Y8NrXAfEPqmCXSc6cQHAIFPEaGlmKNVARV/4zIxZUg0b5DZQ95aVcLL0dA63DSHtFcHtazTLxsZa76+co232kwBvZjjg30X3hfLHE9+lKmPvDmVl5k3y0pObMHB260SxXb+1N2vuKu52UVKRLce5V/ZyRrCZpjOFIeUkCv71yls3OBuoCTEIW1EUAjajrEYxbfaKuH2XsLJ//WWrJlXOHwclRBMzKGLmR1aUtbqdKY0XNGsQ5ANYdi7KfE9P/68OW06mfvXzxN36pY8/yLoZGa3QOhmwBpf27bVKfPA41T2jT0BzjFfvOdNYIdxkAac8Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=oss.nxp.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vcz7E6rg7mDkodQi5uDNQ1QWRcuxfyIzjw9R+DrgHuU=;
 b=UATf6yHDq92M6edlvVjmOhgLQx97Fyos88LtnVx+l5Bn1gNSKBKq/tpLF/h5H+vZrYVIhZevCSi4vpEJYHdAk+BDq1DSQ821hLphvxJoZUYJqXcOyTkyYcMe9xuWhjzpJ+BA79kb3nnBnjhKfwRcs3VEK81VW6Ho6HZoPrzHXds1baCxHd+vDbUtbCskt9yF09qdu+T5ALF0U25PFRmaqQ/SPzqioYg5nrfu3t2CpkTa/iIbDw89R7CzYR2ccrNbfkVkCg/LGLBKlOEmntRdF/2JtPUys55hQVPLPY5YRAWp6OnKdlu0G15zuUIzU5n+VOQ5L8B4RihMjmfvVKMjDA==
Received: from PH7P221CA0011.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:32a::25)
 by BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Fri, 2 Oct
 2026 16:56:56 +0000
Received: from SA2PEPF00003F67.namprd04.prod.outlook.com
 (2603:10b6:510:32a:cafe::a2) by PH7P221CA0011.outlook.office365.com
 (2603:10b6:510:32a::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.17 via Frontend Transport; Fri, 2
 Oct 2026 16:56:56 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003F67.mail.protection.outlook.com (10.167.248.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Fri, 2 Oct 2026 16:56:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 2 Oct
 2026 09:56:30 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 2 Oct
 2026 09:56:30 -0700
Received: from nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Fri, 2 Oct 2026 09:56:29 -0700
Date: Fri, 2 Oct 2026 09:56:30 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Peng Fan <peng.fan@oss.nxp.com>
CC: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Joerg
 Roedel (AMD)" <joro@8bytes.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Jean-Philippe Brucker <jpb@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH RFC v4 2/4] iommu/arm-smmu-v3: Support shared SIDs in
 insert/remove_master
Message-ID: <ar/iPpHX2FJ4UswZ@nvidia.com>
References: <20261001-smmu-shared-sid-ver3-v4-0-06b34fb2e691@nxp.com>
 <20261001-smmu-shared-sid-ver3-v4-2-06b34fb2e691@nxp.com>
 <ar6Vou12yzoZ2z8I@nvidia.com>
 <ar+HLlB2oyiz/cgD@shlinux89>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ar+HLlB2oyiz/cgD@shlinux89>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F67:EE_|BL1PR12MB5732:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fb0b9fd-1755-44b4-9585-08df20a62a81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700016|82310400026|7416014|23010399003|22082099003|18002099003|10067099003|56012099006|11063799006|4143699003|13003099007;
X-Microsoft-Antispam-Message-Info:
	7vxMDf9k+O6hQF6CHmEcQQbpsUGHHquUmfbdjU3h3QJ5mF3LMBmo3zz0Yct3al83w2yFf5Otf5xax7gmB6/HKD/QhlF/w6kuGbai2Wr+fnAqK/gA/y/7Ms9HxtBe+9FoDBRpL/+g1OlQw+wUkqiyd2PvSdR/TLB43pgVnT8i3duGysWaBG445Jzbu5htHI4xYjep2wm757Wpqmx3U4J8+Q7YribLiUDEMliH0ufIHEj4dfKJhkmbe+9f/70hjh5yOCL4V6CBJOAieKYm7+Uq88g1dWE6/Y1jPlFMkHO3JM98Y0LOpF1/4Cj0Td4Srwa7AYq8ZOHDnypwxKZTlBVJtXnJ80T+h1XOq1N6hbyX0XkUcRdvxrzu32eNoqEECxt6WbXwB26Ju8biGM64Jd8BhzE9yMevHk3Srz2e9SNi71kLS+akBRTPKnfvEg8zG3Zkonn9GYXxjNLTRs2VSVidjSgvNIdHEyrBQKXsSkixdptjz6GXOaxnCEP0rlmuV8/0qKdkKPXGySJRxxDrxbT5hsnXp4IcGfzZ1vMEn+JkK1GGGp+4nYkBRvXNsw9EMsB3BrnTL2waoHXtOvkwo3ud8L4/xeUMdIXCeIMb9OLqOcgUOuw0Me/b+LYAgNoS8k8YJjL8MJGe12O9jkIP7tISt4aiAO4i1zNLPz0lsbl/C0L/nbZg1xOnRvl+CAkhfmL7UAhZgoIGKTKtbmgYT3V2DQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(7416014)(23010399003)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006)(4143699003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	QJLk4okNNVkeceeynISsSpvrFL3mgg2Np31AXcu9CgyCZiOcVlBC7VPAb68JrMAcZ00JlozelLEEwbYkXwzIo1uF95nfjKFnFxuGgMjpGp7Tl7+cPpuVlhoMkoovbNfkOiieOcegd0OraodxTF+gEneouGYuSoCez1r5pVVpI+r9tRK19+jYMP42Law0MEs0DogLgVz329H58pvi5pe0ondOWFIOaXz0WVc/uwGXDi2jjEDiPvMtZh04pzVmchtEMHtk+KUzY+dxr9NQPavleszWi4wpR/+CmDC5ZwtPrYobSJTjai9zfLwHUSiDGWikVtmt9rviy9m2OtrUtbuBZYlXz5oqx0SP3flDFk/EbMrFl1S3EgAMmepoZVoV7mok7CRGprrGEtnsvuaymCzhWQ0aeklxGQ8y4QvMZFsTLqVGoSfzCO61s5BmIne2Bz01
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 16:56:55.7761
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fb0b9fd-1755-44b4-9585-08df20a62a81
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F67.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5732

On Fri, Oct 02, 2026 at 06:27:58PM +0800, Peng Fan wrote:
> Ah. So I need a patch list saying:
> 1. iommu/arm-smmu-v3: Allocate streams individually. Change master->streams
>    from an embedded array of struct arm_smmu_stream to an array of pointers,
>    with each stream individually allocated, to prepare for shared-SID support
>    where multiple masters will point to the same stream object
> 2. iommu/arm-smmu-v3: Support shared SIDs in insert/remove_master
> 3. iommu/arm-smmu-v3: Group aliasing devices into the same IOMMU group
> 4. iommu/arm-smmu-v3: Wire up shared-SID STE ordering and feature gating

That looks right to me.

Please also check Sashiko findings:
https://sashiko.dev/#/patchset/20261001-smmu-shared-sid-ver3-v4-0-06b34fb2e691%40nxp.com

Some of them should be gone once you fix the out-of-sync issue.
But findings like lockings would still remain.

Nicolin
