Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012024.outbound.protection.outlook.com [40.107.200.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4784BA1D8;
	Thu, 17 Sep 2026 10:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789642150; cv=fail; b=hOH+/jTOp52i9LjBFXg7jHYYY+QCgPmWpk2/53Jm6MXxBxv+U4fpeoWRZ1mWB/vX3mswwVDST5gHz44nO0AdZgHhXbVngWo5JJYz0DcEDEcxqWIlYlAwduy+u/K6Lp3uYFnOcu5Hq82W+ijoYc6osbGlPBjhKlSJq+uT7oahy4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789642150; c=relaxed/simple;
	bh=MTD0IiGbvZwAYQatk5NW48+hwTwyfOlZPL11bVspnsQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YHA8Pa767+x/E3OuBZwCQyqqsJ4V9XLT2zGRZdTGIuKCwIdI592bPpZQM/4qKQF9OlXiYDwFFzmLSq7BC/iIqKgOk9Q4ojd7FTGO8ACZYTzNj7gHQlVR8fdHBH7LH6ShkaOnLMNCvxHEPtD0kyJtTEkXuzpp333DYEU0f18pWXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Q06tKT2c; arc=fail smtp.client-ip=40.107.200.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Q06tKT2c"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZJ9BanTIc8iC2nOojcjHuWRhVM/vqHvJJzNUiZ6K4jbc+nDsrFnD/uCrBnSN5jDQzSgaKziuPuZtdOpwF0TUvDbeqNbH2lNOGW4UQby7FoP31f2tHk2rmVSGKrK46urQGg5uXRi6al7RX5934NlP39b3gWFBj2GFDZpj15RAMA077j+t2T/KzYpN4tXj5QQ7ML8hKwaHFHeyQfiCc3aOD1QPyXsSf2yVFGVCcWobpyiryfiQeOpSXC7ZugYcbu4GgiqDTKhQJRIm6ROQkEztn3twbrGrX7uwvlnX8uIduIsMKr4YxZscBjooh1DxUQWNWRsJVSaHpRq5sqen9BwbUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F1owGIcW7/RWCI59royLJQkP/FjHeKKFdhY41c7GHMo=;
 b=oxJDM6fOYdRGaCF9DkCMkQEBm3Rub/cNob6/R7tUsFwPsgANmsjpk21J4W6LYVsBP4B6wwssHm1cd0y+mdLZnJUdbCOJW46r/V+tp89APPvaUZ7HvU8MU+X1JmE0BsdltrfGJFOfE9QH3K05DDrEwT1Fr3STM+AAmMfvNFemp9Si5k4S/OaQkJJQIChW4+g1wVUjo9y+aBe7sYj2yiHouvg51VNq+EUi64/J7WGpk3yiHuoEGiuOewXaByTkv/7wavklO9A4/cYw1cWwDH4f66u6qw9mjXC2Yoy43qTl/26D2u/hhhs46/f0f14/WjUv//1TEbtqCc6Ik/+FqcgHLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F1owGIcW7/RWCI59royLJQkP/FjHeKKFdhY41c7GHMo=;
 b=Q06tKT2cI4AW+GcCKvNzKIM16NIVBrAd9xwpEv9GbivRgJfDLnaimXypASLvstQvEycwUOa9CqdZunVrcdr0oKMFafyiXZ2IS2gO369exKV8yZFwRcPrlAkm6Opew/C11bLs+tR4OMGhtuVQLx46oI5mgVDNvoq+OjEJo8EwTWax2BEkWC/7Nm7IzNkufNukLQtrx+Pt6xiJah8WFeuNy+xz00uhf4UvlFwuzp300Yk3r3sDp1cB+YgsN9JGD2i/EdtjQdHnkiuHnXazyTB1sum3rZ8MTTrxNahqFEjJ6BKbD6xUJXD5OyMOiJmLxDSROhbWBtDE2t3qlK3M+w+wPg==
Received: from BN0PR04CA0046.namprd04.prod.outlook.com (2603:10b6:408:e8::21)
 by BY5PR12MB4147.namprd12.prod.outlook.com (2603:10b6:a03:205::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 10:48:54 +0000
Received: from BN7PEPF00000092.namprd03.prod.outlook.com
 (2603:10b6:408:e8:cafe::21) by BN0PR04CA0046.outlook.office365.com
 (2603:10b6:408:e8::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.12 via Frontend Transport; Thu,
 17 Sep 2026 10:48:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN7PEPF00000092.mail.protection.outlook.com (10.167.245.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 17 Sep 2026 10:48:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 17 Sep
 2026 03:48:38 -0700
Received: from sonangrm.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 17 Sep
 2026 03:48:36 -0700
Date: Thu, 17 Sep 2026 16:18:16 +0530
From: sonang patel <sonangp@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: Jason Gunthorpe <jgg@nvidia.com>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>, <rafael@kernel.org>, Danilo Krummrich
	<dakr@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>,
	<aneesh.kumar@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, Suzuki K Poulose
	<suzuki.poulose@arm.com>, Gavin Shan <gshan@redhat.com>, Vikram Sethi
	<vsethi@nvidia.com>, Anshuman Khandual <anshuman.khandual@arm.com>, "Shanker
 Donthineni" <sdonthineni@nvidia.com>, Mostafa Saleh <smostafa@google.com>,
	<rppt@kernel.org>, Thomas Huth <thuth@redhat.com>, Marc Zyngier
	<maz@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, <kas@kernel.org>,
	Kohei Enju <enju.kohei@fujitsu.com>, Shaopeng Tan
	<tan.shaopeng@jp.fujitsu.com>, Ard Biesheuvel <ardb@kernel.org>, James Morse
	<james.morse@arm.com>, Steven Price <steven.price@arm.com>, Sang-Heon Jeon
	<ekffu200098@gmail.com>, Omar Sandoval <osandov@fb.com>, Andrew Morton
	<akpm@linux-foundation.org>, Jinjie Ruan <ruanjinjie@huawei.com>, Sam Edwards
	<cfsworks@gmail.com>, Douglas Anderson <dianders@chromium.org>, "Florian
 Fainelli" <florian.fainelli@broadcom.com>, Chen-Yu Tsai <wenst@chromium.org>,
	Huacai Chen <chenhuacai@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
	Pranjal Shrivastava <praan@google.com>, Ashish Mhetre <amhetre@nvidia.com>,
	Shameer Kolothum <skolothumtho@nvidia.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <driver-core@lists.linux.dev>, Ankit Agrawal
	<ankita@nvidia.com>
Subject: Re: [PATCH v1 6/8] iommu: Introduce TDISP T=0 state for confidential
 IOMMUs
Message-ID: <aqvFcIkll6e2T6M7@sonangrm.nvidia.com>
References: <cover.1789010941.git.nicolinc@nvidia.com>
 <0421799346a09bf7f32727330ca1044de05f46ba.1789010941.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0421799346a09bf7f32727330ca1044de05f46ba.1789010941.git.nicolinc@nvidia.com>
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF00000092:EE_|BY5PR12MB4147:EE_
X-MS-Office365-Filtering-Correlation-Id: 17fd890d-418e-413e-9fb6-08df14a943fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|82310400026|7416014|36860700016|6133799003|10067099003|4143699003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	w2I/OvPfFxY49MOJSGWjmSQ52BUQsUaHbc4q3l01nDgqL9f5//kp50CXeiXYt+jFPyk1rqs6rAqoBgU6LiGeCmcMJF8373i8HHpy58Ub+2mTR0PzKwmG4ft75W2FjQf415JMgLSTsBRz5o7kKzhFsLTSj8qqiB78MkzX34FVKaJMjy+UXZ8LgAAU7BY1QH2csx4jbkcxJu4D9v8j0g/dplJN8DLLm9hGrd8/Xcp5F94kTLXTBQZ8yZ/0ioOQUtD4aeAujuf8OGmjMZCJbewb3QXkWTjqffBEMiG4chd/GlkMJQyHexn18AVgw//FzBn/Uefo3l8VVCzgRUjQ0+8kdPqBRdhnYWNXyofxuOppxJfwh020cx88wfHgo9MNc89zAsYfWcPW8A1OH8NLfqisdzCmhydNkvtHyK+eD+g4Ng8w4tY+32Yv8sjFflF6FGHgJ5jELLa2XJz73Z2vLiDyu0nGJjHCiL7vgNTDssvCqNOFa3rHwNzJwypLpvgTKQwTpEH9/KWicoul19k+UsFsMx4ABg7IARR3oYkIvEBOf5WOw0PHyWzakvOUc8sRcmOmpIdAUd5l0RhGkfAKjJzT1Ze4yi2I9IfbmVHdF9UaJobg2K8N+54YHwaC6Fq7HMQ0RL8o2Gus2BXWgG+mfxjf1lNibavPiQqpNhZZJdFIEUQojChJtXTAsBIWbNeHWqnBzyP8X6j0smxXh9SIdj7tDA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(82310400026)(7416014)(36860700016)(6133799003)(10067099003)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xOiblAuzD+2r769So9PEU+2nSQI2z61yjNHb4pJaAcRTxeS1g0OE9ePaB6gOmFWkDP1y147UlXbceGnGMzyYocWivhlCp7Zokco92+ZJ80fEfpOvXlzhpI2jfkEm87i3vwrU160bxwANeRngCGINT3C903B7XvaJw6GPDO1SQXqEM4yFTXe+f0npI7J5Qu60khbvPb6Rt45frEd3fHzR051sy7dC8f7i7dXY7D1/CGTJZLnUiBF6U3Ll7I3lmxWB94Dqu/nGsc+f0SJJ9EP9ckLvM7fSQf3qmUsUuxtY84P4y0kh1KaxIicJfUou4rCFO2y2y4cm9Q0Mql8pk39QXAqH/to/lvMZ285qBBe824t5wdssn7Yphn7t0/wfpTBS8NzpETnyc7MMY1i6b9bay9ikoGsXAu3oVBz+fMoCxSlOOMcZOLnZKEJXKLk/VOqP
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 10:48:53.1057
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17fd890d-418e-413e-9fb6-08df14a943fc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN7PEPF00000092.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4147

On Wed, 9 Sep 2026 20:32:49 -0700, Nicolin Chen wrote:
> + * @tdisp_t1: device uses its confidential IOMMU's T=1 stream. A zero value
> + *            means T=0, where the T=1 stream remains blocked while the core
> + *            owns required DMA operations such as ATS.

What happens when the TDI transitions to ERROR, and how does this bit
signify it?
A TDI can drop to ERROR asynchronously, and at that point the device is
outside the trust boundary again.

Thanks,
Sonang
