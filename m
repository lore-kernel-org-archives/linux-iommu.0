Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012003.outbound.protection.outlook.com [40.107.209.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D452C3245
	for <iommu@lists.linux.dev>; Thu, 13 Nov 2025 21:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763069688; cv=fail; b=RUk64haazBNINHjvmzfUTr7+7r94D9nc94Ulfub61fgfAqkFDEEwKtIZagCcVt1Wd1iX3FUB5cE4BgRq0/uJ7r5RLB1/I6QYFRGft88s05EjUFxpNR8S01F9icFn+3F1O4/aAyE2pDwOIyOeqUU461Jw9teHeab14/qPyyyYMWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763069688; c=relaxed/simple;
	bh=2hn8poIm3rbkjfCqK5a3dxR1O/b6vzqIgSFa7BIZ3F8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E1k2CHYhX/VEyECfNBcxq3sJvOv70YTJbCHk7RRN9j0bk1jluwFRah3xcIV7w8C4KciivuCmRiG2uWFNR3t3nciRLmUXzdDcidRH+vY5ouQGAgQwRAdBS57412pzJUiWdLVa5ON5qjCVlXGz3JSSd9lOx2hgwR6hNLbCGK5hTHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=D+wZd/h6; arc=fail smtp.client-ip=40.107.209.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="D+wZd/h6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GV/NueUzHemsjeEx+RAXvsTUPA2Rof0i4p5jfxi9uSYI0gfK5fpbJlcBJ91vBKM9JkAfgvuFKNssAnqBfV0MgiomDlnIH3QpfTd2rhzhDdvou6ppW/io3IzbwASMzDUvEovUEZhkq8k17PyZZV3n7GERsCa5XkKZ30UZE9Gc5zpIjGuM0NYB/AadQyY/FRU30GvtHWFJm49X4tLEP7/+sTWyHYzovRBrkBYxPG+N2ZYsM4BE7sdLWTiV3pFLQAD65Vl58Kg5C3CUzVNj+P3BcC3Rwe4n3d2OZ5PIYzV5NP1UBiYryKdHMfxuysfJU6Jhv5Bisgujjs2rZeouza5ecQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=edmve0OZhJ3kKnpQYSjofyesHWRLRkdVwiPAk2Zi7nA=;
 b=TLUS0b+w0yV9BOoGRybM6pu1z2lA6F6PBP+3a2ucx6Lydnk2FSZnnAOXWVYJasyCNBK7QrD6rnTmNCt8I+Xa1V+f7u6Z0whb0T74FFFYiUPRUn3HpK0/2jYl8tK6L/NHlfCRBPxFZV/4UvHGzC0XHbUlvoy7wg5L9HTaWyJaAgnh79owvq6hWp7n9C/1gnAiXnmpnZr7Ph6znTCVr42SZuZH95CaMkEPlB0a0Tezvp2vBAlO6LjDIM/nkUwZQCPTEO72vU/HMrCFqAGhh5mN3RhlGQOAo+oT9GrpfwemLjy2q6HfbrtRPrMouL6OMMlVUdbWEgTkMOmHhbCovn5a5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=edmve0OZhJ3kKnpQYSjofyesHWRLRkdVwiPAk2Zi7nA=;
 b=D+wZd/h639uWgeH3CPSyuCZhbvQjpWCtkkRhnQiBblGrxDy63AL3hWdkuuuhhVfBNlUpYnTgTYUwZmgMUVVhbHNVDI6HWNm7gk4NMuJ6KASV+mqNaJ/LL7wl0GZMX6zN2ZHC7NYnG4hGn0apC4XwV2p7Rr63Re0FK3DAhqlW990iu3x/bsY43h63Mz80i4AIvHs7JWDIG8h9LIF2HhpLTY/ZFGr4mAjJi/fHnB4+DpOcL3OqDRCKNLKwlei1WzSBG4E65v5EO3z2ESQcTiRSiux8GmJX0AuyFYk0N9s7icRiXl2jgnQtCP5i/16vr4uhZfatCpZsY5N0FVe892O1KA==
Received: from BN9PR03CA0093.namprd03.prod.outlook.com (2603:10b6:408:fd::8)
 by PH8PR12MB7424.namprd12.prod.outlook.com (2603:10b6:510:228::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 21:34:42 +0000
Received: from BN3PEPF0000B072.namprd04.prod.outlook.com
 (2603:10b6:408:fd:cafe::43) by BN9PR03CA0093.outlook.office365.com
 (2603:10b6:408:fd::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.16 via Frontend Transport; Thu,
 13 Nov 2025 21:34:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B072.mail.protection.outlook.com (10.167.243.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Thu, 13 Nov 2025 21:34:42 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 13 Nov
 2025 13:34:19 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 13 Nov
 2025 13:34:19 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 13 Nov 2025 13:34:17 -0800
Date: Thu, 13 Nov 2025 13:34:16 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
CC: <jgg@nvidia.com>, <linux-kernel@vger.kernel.org>, <robin.murphy@arm.com>,
	<will@kernel.org>, <joro@8bytes.org>, <kevin.tian@intel.com>,
	<jsnitsel@redhat.com>, <vasant.hegde@amd.com>, <iommu@lists.linux.dev>,
	<santosh.shukla@amd.com>, <sairaj.arunkodilkar@amd.com>, <jon.grimm@amd.com>,
	<prashanthpra@google.com>, <wvw@google.com>, <wnliu@google.com>,
	<gptran@google.com>, <kpsingh@google.com>, <joao.m.martins@oracle.com>,
	<alejandro.j.jimenez@oracle.com>
Subject: Re: [PATCH v5 14/14] iommu/amd: Add support for nested domain
 attach/detach
Message-ID: <aRZO2IJ0wVD52iaX@Asurada-Nvidia>
References: <20251112182506.7165-1-suravee.suthikulpanit@amd.com>
 <20251112182506.7165-15-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251112182506.7165-15-suravee.suthikulpanit@amd.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B072:EE_|PH8PR12MB7424:EE_
X-MS-Office365-Filtering-Correlation-Id: d4047cb5-cf05-48a5-b556-08de22fc7514
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FpG49bhB/CFoPaBimDFJzoyANodXSX+fGB02WAng9l7MpjaCmMRA8xYbseg5?=
 =?us-ascii?Q?JTXtSkYKLqEhVdUKfmjfIsdykyKPvqlNB3jssKRP6JQb/5iF3EE4otRBD9hm?=
 =?us-ascii?Q?jHlMIHDS84iVnZKfcNpC0lyeXyN5kWe6H48dO8QbT7asX1ef6USaVOnq4kaO?=
 =?us-ascii?Q?vGhZrRJGNdvff8YgHfM62ZG9TikM1uwXKFxGxsKwvQFIx9FGOfh5Rtz7gxCE?=
 =?us-ascii?Q?k0qTMyS/LcCYFq0AQUG4ypthdPvIxPxQ+72uNoVsGvZX4koMHAgfy/ELiNSM?=
 =?us-ascii?Q?jutAd4KrBZ/SPPYCf2GWCQOSNylMDMf5JTrpVAZcRl8BCaR3CupJ/Guhp3Dk?=
 =?us-ascii?Q?ySLOAOZllJAm3EsO7GikWDskaeCOPqxMNQ18tdwhU7vXVGBBdDGfBExxqI3a?=
 =?us-ascii?Q?meVn0ZzAL7BOa2OAohzkAdBXymC5hVL4Y8HI5fy1rWfZQOTSKU8+fU/QQHRj?=
 =?us-ascii?Q?7tx+ax1/4vdb1+DlPvOfUa9DNC5fWXOy1XaIghJVVVtyMLHiFmnPLO3B26le?=
 =?us-ascii?Q?5uDvM5MFAkExcpbnU7/bCMlPC2FJTpqo/BCukBWkYuD4NKgu9o1KRujik57N?=
 =?us-ascii?Q?bfytRod1LmkztnbecgBK4b7qvxqhN+4jc9/MuMGCZ27BiHVng0n8EKKBQV0g?=
 =?us-ascii?Q?etDZlvZNivqd3/S2cUMb7esT9bjLvWnIpCLUP0OMLwpKyQoY5jASh89PHIB4?=
 =?us-ascii?Q?UGf3+MR2BMgnCWmt8GDMHKKYDjlbOlWJli9/0inc9QfyiCB8fSdXRjq5o3Dv?=
 =?us-ascii?Q?d7hU3c8R9BMQhsNPU4CA49saw961JZypJ/cCFE9bymplbOWC0bw2grK0Yyld?=
 =?us-ascii?Q?ASNJbqxvybfiI4Ndp82yXV81ZKG7+mPoG7HSsE+NgvCrappGSHaGcLW8aLQE?=
 =?us-ascii?Q?w4z5NoTLbLzUN5a00WP5g50xvhJX4TCVBUJ5n+vtbvUVlY+W9WR723I+S694?=
 =?us-ascii?Q?QLRkzFPEpuBUZA1jX0wZbzzlaMMOkB0vSTkLwupCJ1/d0W4OkXFS0B4XzH5P?=
 =?us-ascii?Q?gmYp6fHZJNDVplI1jDqahuxpk4qSkYcBW2SY8yZk/kknK/wUGZvVcHTKfrRl?=
 =?us-ascii?Q?o8RgBNrBRKAP5rEJQu7gWgmOcLaLlgmPl+L6CwCObnJbRHr1h0eAT0xfVXxd?=
 =?us-ascii?Q?/mG+oxzZT5meBzAmDf+LLRhhtGthkZ29Xhx4FXcij7pUyQEqwAXTGcqKr/gB?=
 =?us-ascii?Q?0yEwqwZ8d1Z7ZbEyf9kfdxDChTpFJvlW6QCUt/P7zdx3uRJCkhHQFK1ztwIp?=
 =?us-ascii?Q?gQRefJYjHDtppHwPlU5u5blNvcJQ2olYmk7S+1BscfhXXFY4OwlqHVPdGAwH?=
 =?us-ascii?Q?XOcZNlUZGD25N6P9pZtp6FEDRI4TYe8t2wWeD15VopJBYzxQNjpPKqumyFr3?=
 =?us-ascii?Q?xs+QfjGbGSPwbl2hN1UoQVEF/f15MFT7dBfPTXNi5BLwc67vtzNqa3SZt0mW?=
 =?us-ascii?Q?bYFbsqMN9pcXeSUmyEhjbkvC+fk1QCjw7Jf9rBZBhMAPfj5tKzqY+Wrn/hUF?=
 =?us-ascii?Q?6NUgks7KrtUR3iJrLGPU7iLqazBSX1EVhsO69V/Asfp5a77OUzMecy6CZXkg?=
 =?us-ascii?Q?WPbV7RgSoTBEoi7YrUQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 21:34:42.2813
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4047cb5-cf05-48a5-b556-08de22fc7514
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B072.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7424

On Wed, Nov 12, 2025 at 06:25:06PM +0000, Suravee Suthikulpanit wrote:
> Introduce set_dte_nested() to program guest translation settings in
> the host DTE when attaches the nested domain to a device.
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
 
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
