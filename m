Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010034.outbound.protection.outlook.com [52.101.61.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24FE4A92F4
	for <iommu@lists.linux.dev>; Wed,  2 Sep 2026 17:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788369782; cv=fail; b=TRjKixzGW6tg6FDQVa0/kJrgE44o2e5x8kWfIs1up22x1XhkaURsrS7GLchPgMgqQVcYYR8xS0X4swSGQRuvq9nkfwWJxWwtVV9FrFQtVC31KZ13FxM+acoUB+H+tV7Wjklh2iCDkE0SrEUbeL1FY7YqiRQhak8xbW6rRkAmSo8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788369782; c=relaxed/simple;
	bh=wC6Z22fuNzLn3x0wcF2bOsdLLzM/YYp29Z0wkbijubE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JiCBy/BDqwYklsY+bxlY6lMcQJXMQZi6K+bHvDgk3n8A6mZ6Us4Xi4+CbVJZLlOEO6oU6MAN4NV8BZ5/HwtQCnaMPaQ2QXo2gwUpP2tKn4m8VPMYUt1b3Cq19CAJxMX4PNIBXqOPOjd0y5Yo96HLVt4UC1h7eJyVrCr4z2mJmN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mkyWEyYX; arc=fail smtp.client-ip=52.101.61.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mkyWEyYX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jh6cav4TG6gg2cplg2qkM5jQSb+mmnO0FTCzmTt9U+rkiQ7BQFl0VJSqL3SvwuNyQXDRaSDK464hZaBI9T0626RvpcJJeF8qcTlrwWV3SzjlJ3MsTCe5o0h1TnCxIbdAeZUclz/7Zqu0lx9vpbmuhplFzId0nW6zF4JJXzlRI5gVP+JcHbRrFsuMrWd3XTwdLwsHmw6simkEvO/pppvAZT+m+eTUXpbc9vH3Tiv+DFfSAghWz+kmM5D22DWkn0PbZqN5pD7Il1YzX+OEoZmVFKLKuhkOrPEv+slD3c5CHRHMMk1q7KLySuvlCxBpLbeajmvO2WyAJmZNnN2O6X94jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wC6Z22fuNzLn3x0wcF2bOsdLLzM/YYp29Z0wkbijubE=;
 b=cH4xiBNvDIzxQv5C3LpRxwbJ9xClkHh2dilAAqTq9WXJCbqy7sGycMGIDYdtQapHabNRi1YCb4OcQSxffpX3F0yFztVWHDd7KbbEknFbJvvle5YDuPIrHPNTYxLE1pYM3uX0/FMawmBM/hzvlOfM3eEC4L50BBkQ8i8u0LSIjhVKybJ7h2cWEkuGRiap8j9rcarQzaU7bQmroyAQJ/czHJfWLPTOBFyKHKI/51qMamGa5YwiD/I5R4Vmk+RASpEEz2mg3cGePeLh3ZBYGWBSOIo7Tl5tP6NHp0bBHVs67MGVSWGWlzmEaUuheBxo2VkmpRbtwA5K7yxzCHhvTGO2TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wC6Z22fuNzLn3x0wcF2bOsdLLzM/YYp29Z0wkbijubE=;
 b=mkyWEyYXB7tVHPyfIsDwGaALZWJBmyDbFLgyXm5/tq7hw7+piBaRHlH+zKdrLhlXQW2RLbBj/cJ2Nva1mvmz3kN3XUouorszH4ZGzEjYeKVmqGFExSeLcM5cXoWOMv1fmTEnbLKZTipIZR0YdQa2Hs813pQyUw2t4Wy/6nIzFmCqNoJLd4OnRVxw0kZYI0ty5Pvol4RioD+ZWJf0FIl94ARrTJ8bQTZmLHR0umgE/4wmUS3iIjb4u0T8ZQILjnuzPG+9enszQz0dmWV5VR8v54diroZhRHPsf6DWPlrjH29cXQMs5TWh4BG5UB4ccLER254JjY2HqY11Gb0Gy2LOJA==
Received: from SJ0PR03CA0192.namprd03.prod.outlook.com (2603:10b6:a03:2ef::17)
 by PH7PR12MB5734.namprd12.prod.outlook.com (2603:10b6:510:1e1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 17:22:55 +0000
Received: from SJ5PEPF00000207.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::3b) by SJ0PR03CA0192.outlook.office365.com
 (2603:10b6:a03:2ef::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed, 2
 Sep 2026 17:22:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF00000207.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 17:22:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 10:22:35 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 10:22:34 -0700
Received: from nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46 via Frontend
 Transport; Wed, 2 Sep 2026 10:22:32 -0700
Date: Wed, 2 Sep 2026 10:22:31 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
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
Message-ID: <aphbV1FSoop1YGOQ@nvidia.com>
References: <20260902121724.3494954-1-kas@kernel.org>
 <20260902121724.3494954-2-kas@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260902121724.3494954-2-kas@kernel.org>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000207:EE_|PH7PR12MB5734:EE_
X-MS-Office365-Filtering-Correlation-Id: 034f4dab-9761-45c0-1d79-08df0916d3db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|7416014|1800799024|23010399003|10067099003|11063799006|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	zz29q2r3nsxvNxo29vZ26wAl9w7/G6ArISjOgfXYw2GcYOJ05j0UsR1tedKimiiICkG7xZXaB4tkgjBjxugDlLLCswkNq0ja/da4n1o4PYgCDPRZa3KcrxStb6J60kn89VaBQiC46+fluN7jXbUTwE399UQBUk+FK2zl0Btxde0+6lanQtNmDZp+xDlTq0K6vG0MnMJ6zCNLcvuP8+rjzl5vVnDXYDcJ51AL2gI5vcwLdykWYXiz99CxwC/rkDvbT8X4EurBOl+iD/mfTvtqKLyDR+V1uIFj9lRL/1YpMX2O5sGdozCykz6nwMm05iNCQOi9eZtUG1mZCocLDezXomUNYM7cXA4862fYcahBQWkB1RcPdESqFZ5cPrxAdOARg7jQ9/KO9aSkgPGodAORr81DwulLQH7PL8AVL5eWCjFRHONN+zgbm61hQN4TTbdqTQii9IE5IpBBuUS2MFSIrehMbn022eooNZCxv7Il1QIFJPhImmG/Tar0USxTr4v7fFb1+nnPD80ER1QSZtpeGKDdUbFDsRV/bIsRrVjo9DUZSpVO6yov1ka43ICX/k11YjcIJ5QZXwfonrYRvSRnWmYLS9u8URqngrOsGhTJrmF9avXnPob/eq9ADRtvcKDRe4dFJJGCAElnhzEsFYAiyRfaUVBt+XfGM/utupxoGlUDMvZ/+Q+IAsenDV3WtWzZz2MJeze3fhc+8f0ObQbvCA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(7416014)(1800799024)(23010399003)(10067099003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GkPNNp5OB1EPhbTepf38boXk/wuViPboC3/+NyN+slMYKmKjHsq6tDLo9wb0tbthPkYbevJZi2dH2FIni3cZY/izTg17BGAT5t1UwjphDKoxwnCYisR5T5F8y12ASdLX+5j6F+GN4QCBcuThYXGvquL0d+XI0WVKkMTMzA3lXaBNBDzg0jPzHxCTFYrTHuMe7OAOLViQUZGglkSzclUCKAyra1nr54frg5eql62YVJRoYAZn/Y5cCVhJp+tWCut4FNXY52fWxSpiZYZRDPBOQbdtlKWEIpYNxgHeBpSGheyD3Htdoa2oXgdA5rQ49NQDSlP0nxpBuDQA2ogk9+ZzXuxfe1ifwZ/yFyqYxQmNvDnP1OyudyMYAmh9mmAWH3VCjuOj7V9lsbPNUPWBwZX1/dnHA4H3CItymNsbaMkk7SAtaex4+JJknFZTeFwbN0HG
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 17:22:55.7882
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 034f4dab-9761-45c0-1d79-08df0916d3db
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000207.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5734

On Wed, Sep 02, 2026 at 01:17:23PM +0100, Kiryl Shutsemau (Meta) wrote:
> +/**
> + * arm_smmu_queue_max_n_shift() - pick the log2 depth of a queue
> + * @hw_shift: log2 depth the hardware allows, capped for natural alignment
> + * @ent_sz_shift: log2 of the queue entry size in bytes
> + * @want: number of entries asked for, or zero to use @hw_shift
> + *
> + * @want is rounded down to a power of two. It never sizes a queue below one
> + * page, because coherent DMA is page granular: a shallower queue occupies the
> + * same memory as one that fills the page, and arm_smmu_init_one_queue() stops
> + * shrinking at a page too.

Well, since we want the cmdq depth, why not name the parameter
"max_cmdq_depth"? Then, no rounding and more straightforward.

Nicolin
