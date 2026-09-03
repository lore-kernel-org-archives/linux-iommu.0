Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010064.outbound.protection.outlook.com [52.101.56.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1270C4C9019
	for <iommu@lists.linux.dev>; Thu,  3 Sep 2026 15:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788448236; cv=fail; b=lidbxMEWavQMqCmUBw6+ZpJx11H0OohUoACUnX0ktVcD8u9UH+QDLChLMWjgPmVRkFobDTi+VnT3TuEZ2+NXMkFL/Tipw4ZSVDGO0hcPfRoGuHlNlGTEg0d0U0NO4jc7xRdBs4VfrTDcs9pNkGPnC4QlnAY8M5iILoayXM6NoGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788448236; c=relaxed/simple;
	bh=KAv+tKkomeRccb5BzPsEXUx/fjGP1Z6KbTIOrHmYiiM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q2DThZHJ35wyqTqMPquuVdUaLplvUKPO/0H1rzWdBdzCEjZylqD6VSiYO3C6TSq8xQza+WjLg9rhWqF+CMelBP46gM9B0JedB+0YRMpcEHKyE54R2no2uvdlMgE2bFoY+Hyk8wk1lec3ykCLsG+8jfkbGcO4jfw+FXRGNdKdHWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ic7ZfKOv; arc=fail smtp.client-ip=52.101.56.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ic7ZfKOv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fh5mhI8Ac8OgDkIgGC1MCKOHZpgPvWDsDl9Jcf+PdtgxLwxgYw4iCxiuoJ2QIpbMV7ymrjfRsTXRg8JyoEv/PsGUbl5SqFaCNqkkEpqDMt/vkbMdtd7Fwkn1aStOnSTUnbS7e+OPltBz89CvJLO3Cy2TKZ+b1TRbuw4NUEQj487bkyaW4WRuvkcnuRspEwjEmsuOfirexm3lpe/VaNukufucsHBbC30twUKoHmK2VtCRqXckjFozGFLv9auCAwp2BqxqPlX7n4UYFLHl1nhUFQpDHOW+I4HG5bVEk5kasMw/40n/75OvnR23px6Mq7V5fHpg9ZvLTy8zyp+0pTaCpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/BlaVq8bikWvPCaZvzm7IB1Sd1ddd+GZl/KuLldScHU=;
 b=OkQedakLVrHKsJm7P37f8i15pbSo089V23N9ztnlhy1U6f+ItOqFsCGu+w4eZvUFZLW4BKigJr774Zo4StcC9cUcfBf+oycTR9jqrfqYDa1EV45qEnhXxTp+oVeDJDeuwYz7cAzpQGRQ7q0nPCvCN9ETJ6DML1dziiySw954Oz3AAvGTGCMcrX/AXpeTtfqbfvwAs1w1ep/f9iii/wVxQVyHIv4qig0/SWJouu+mha1OsdG9CoSa8PI3fLBmKHthK3XAWyvgnfXV3cYdXaMYqgkOUbXmgRim/jzIXy4XfaijEu9rr7dljPhVYL8wcpK0XBdfF++CfKqgtpu6NNFkVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/BlaVq8bikWvPCaZvzm7IB1Sd1ddd+GZl/KuLldScHU=;
 b=ic7ZfKOvGnSsYrPSPepRYde2Lwrbtr1225mJQdLXNTgQgi8vLxu9CCMlBHtV8sKAsfWh48hIxgCAJV/ajFpKDLsUxP/wcmu5aDiKZ+cJDr4O9yV6O3CYx6V0V9vItuJSrCYIVUbdkXnZCPVIBpN1YMNq4zjQNOrJuBoWSuPEm9W93VqmPYlyn1A1WoIQ531SC71fFfaNfX4ho1nKaliHXkMT8uyhMwC2DW8FP8O6GMiMAPuQ9nZPxDWD2CX/845q4JylL+vxbvFmbWis8oXxzMgw/wdiVjbrRqILJ4EMoKF5xELPPeLojKoYbgfLFtNNNCo0JH/87885qVH9tZUEvA==
Received: from BN9PR03CA0411.namprd03.prod.outlook.com (2603:10b6:408:111::26)
 by SA1PR12MB6702.namprd12.prod.outlook.com (2603:10b6:806:252::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 15:10:24 +0000
Received: from BL6PEPF0001AB4B.namprd04.prod.outlook.com
 (2603:10b6:408:111:cafe::15) by BN9PR03CA0411.outlook.office365.com
 (2603:10b6:408:111::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.12 via Frontend Transport; Thu, 3
 Sep 2026 15:10:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB4B.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Thu, 3 Sep 2026 15:10:24 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 3 Sep
 2026 08:09:57 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 3 Sep
 2026 08:09:57 -0700
Received: from nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46 via Frontend
 Transport; Thu, 3 Sep 2026 08:09:56 -0700
Date: Thu, 3 Sep 2026 08:09:55 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Kiryl Shutsemau <kas@kernel.org>
CC: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Joerg
 Roedel" <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>, "Pranjal
 Shrivastava" <praan@google.com>, Mostafa Saleh <smostafa@google.com>,
	"Thierry Reding" <thierry.reding@kernel.org>, Krishna Reddy
	<vdumpa@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>, Breno Leitao
	<leitao@debian.org>, Kyle McMartin <jkkm@meta.com>, Usama Arif
	<usama.arif@linux.dev>, <kernel-team@meta.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] iommu/arm-smmu-v3: Add a cmdq_entries module
 parameter
Message-ID: <apmNw4hMrkYqyD3j@nvidia.com>
References: <20260902121724.3494954-1-kas@kernel.org>
 <20260902121724.3494954-2-kas@kernel.org>
 <aphbV1FSoop1YGOQ@nvidia.com>
 <aplvJIuarj_ZrAx9@thinkstation>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aplvJIuarj_ZrAx9@thinkstation>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4B:EE_|SA1PR12MB6702:EE_
X-MS-Office365-Filtering-Correlation-Id: d2612337-e9d0-4e81-c00b-08df09cd7b08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|23010399003|82310400026|1800799024|22082099003|18002099003|56012099006|10067099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	7219CtuWN6XyetBBIozqkq/WNG8CLuFLrHGw9wj6VBn/z83beTuDNcKtL62xame+qCS2ms7/NyuxL4mkavYZsrSezvM+SJseQZlufEDP+o0P+dHoalvUvOkdrozBprrcWTbdeypMNpzUO9A57+KnDhK0kXxpsoPurj8TGm+U0k/CuXwe9doGzKCI+92X7uLAex+NRdfO3ZY4dv2jl+TaI2scPQM+UIfYWZCPzbvu8mN70WKNTwAzrI3/3vHhutz0NCe/zb0PtJHEcLLv4eik8rEdGBP0LmOa17/JmmgtSp3EiUU5TlDJOATuE4ilQaw6u0Y0zZ4fSzoeeOaXD4gijEUh4su+TE4OXnfvsLUcF5uAkWtQRv+K8wJg+0ZHy3nAUYVe3HbUwW13ETua3wGqvVRlJs0LcZxg9BTgmfPuy5uNu4aM06KT2JRa6xDlqmiGOnC3/wIArDcRg0m1E53NW3VX8D9wN+bKuzns/w4Bb/tfcKzV3BPirIqo2k4WBWQoLlDuXcQT9zn6woOvVznNyHEmyzHfgzb90F/Ih5w1kZcAhtCLVNnUkr/j/1n0/y7T6VHUEDyAd6CRevQ4jValmS2FvmUooM7phW+7oIx2fEO5S5+/pCPJhGcsX1NedWYRU9UflOnljuxhiXZD6aq91qzUL12BAkZRPwQXp0bfq05Zq9PkLe3y/ASTJ6QkowFsirvYs3LPzNzRzQSg3FLPkg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(23010399003)(82310400026)(1800799024)(22082099003)(18002099003)(56012099006)(10067099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	HlC24yZVs++fceGgNSNJhb2c5u3gGLdtOTp84lcurUDo6j1IqgFBHh3hIzugSOQHi9u/c3zT3a5OBlkx4lXGI4q+WETlv12mH1K4dBrhQXzZnZpu0+Kf1yCpNufR7t/701j607XnX1Qf327ZNRh2XXCbfoOaUlkMzGKJuCtA6Cs7LVeI70FGxPBjEoa3CDNjsharjvVHlcl1Hj8vOmHi2MAz/dgUyFH+WJfEQMvrfxbDPm54fsmGKYNFO18ehQD70rur1EfTUMvfcik4OgqNO50TjE1TzrRhbR10DB6tvAo16CkFnb3R/R8HnEQWaQuz2rRT+XMtC1Qbec9FOypyTfhmehLwc3y82xN7vS209c8FyNLVvWgk8WbCi8ggTf9lk9YTiFIZxGYlzWVUTa1m1YqBKQm3XYjJ5rylOhS3SLQLbLYa5jZgftToA6DK2mGh
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 15:10:24.5164
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2612337-e9d0-4e81-c00b-08df09cd7b08
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6702

On Thu, Sep 03, 2026 at 03:15:27PM +0100, Kiryl Shutsemau wrote:
> On Wed, Sep 02, 2026 at 10:22:31AM -0700, Nicolin Chen wrote:
> > On Wed, Sep 02, 2026 at 01:17:23PM +0100, Kiryl Shutsemau (Meta) wrote:
> > > +/**
> > > + * arm_smmu_queue_max_n_shift() - pick the log2 depth of a queue
> > > + * @hw_shift: log2 depth the hardware allows, capped for natural alignment
> > > + * @ent_sz_shift: log2 of the queue entry size in bytes
> > > + * @want: number of entries asked for, or zero to use @hw_shift
> > > + *
> > > + * @want is rounded down to a power of two. It never sizes a queue below one
> > > + * page, because coherent DMA is page granular: a shallower queue occupies the
> > > + * same memory as one that fills the page, and arm_smmu_init_one_queue() stops
> > > + * shrinking at a page too.
> > 
> > Well, since we want the cmdq depth, why not name the parameter
> > "max_cmdq_depth"? Then, no rounding and more straightforward.
> 
> The max_ prefix is better, thanks. cmdq_entries does not say it is a
> ceiling.
> 
> On the units, the page floor has to stay whatever we call the parameter.
> 
> Ask for 8 entries and max_n_shift comes out as 3, which the
> CMDQ_BATCH_ENTRIES check in arm_smmu_device_hw_probe() rejects with
> -ENXIO. The floor gives you 256 entries on a 4K kernel instead of a failed
> probe.
> 
> So log2 removes the rounding but not the flooring, and the number asked for
> still is not always the number you get. I would rather keep entries than
> make people convert.
> 
> The rounding is not silent, either: arm_smmu_init_one_queue() already
> prints "allocated %u entries for cmdq", so the effective depth lands in
> dmesg whichever unit the parameter takes.
> 
> On the name itself, "depth" reads to me as a number of entries rather than
> its log2, so max_cmdq_depth=8 meaning 256 seems more surprising than the
> rounding it replaces.

Well, maybe "cmdq_max_n_shift" is a better one over "depth".

Given CMDQ_BATCH_ENTRIES is used, I think cmdq_max_entries works.

Nicolin
