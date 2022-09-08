Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2079.outbound.protection.outlook.com [40.107.212.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3841A7C
	for <iommu@lists.linux.dev>; Thu,  8 Sep 2022 13:19:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T+nlqyHwSSYwl8aTMRyyshYUcXuIkJJtabQjG8XUwkF2GM3pMnwamO74Lmm5uV2zxAzcVvpzb7ml+m9TviyMxbRXYZ7XnoPKhRiDWn6f8LOgwm9ZpuMhmk98sxScUOhDMVm+XSwWzKvxTtbnQRpzpVp9946IzZA0qzWWUjLIdfJZ9YeZMeWpmVvnPaMDjiqiFHQe+8SrlEmIaQQszawrJQAilMUBwgYPYgv5T9hS00JPp3K853eXvjYfEKKa2o40e/9Igc3cbaNTT3xSeOxKUPHkAOLj5jTXeWWmjvaZ9+Gz99GflJePff5T6v00DpK8uQgba+ATaVFwn9nAlHvUdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mzthWqcqYCk2ce6BIfqt3TyDsX/EcWN8IMkN517xaEI=;
 b=DS8muThpmMQjnYDuh0kOidLq/1NV0z7S2hnVEcD9XgZzt2RyR7vDPXQ1aZh3nabZbxqMBAm6BCbPwW7GeDaa+1oI//Db2BTrQ+yYDt6bptt6Hg40bvC744qjmjnKEJEhE7+jjLkCz+5lM/8X2+C661GX7p4wjVusvEtU7NRZocdP9Yv+H/9oM8hqGZ4GJNx5eVOaye9SDxQ71O7jjxHBfnKgL2zzdqrU0BbFjFtv2leZNN+sIYtz6XXC18151kQjrsonei6hVEsYXddJXTmk9LUBrNOTl7mPHem7zcjJqbbvPaPz1v6SR3jPA6jYlG7LXCPRIId8OB98I7e5i0oPQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mzthWqcqYCk2ce6BIfqt3TyDsX/EcWN8IMkN517xaEI=;
 b=Pa/zXLJAt3xfx2qUjGrP/SxliXt9+pnLUZbTOR4S7wA9E9IEZhGgj/y8tEFwpxjvuWRFUbAZSMgVfVgrqQLCiGeUWtaV6UZRGCWw2f/ZGcr2WaSmUia8BP5r1sgTsvoSa5WAYrQtCS6TuyxtDxoClS5UZV9BsPY+MAJvnD+jjHLG+31x3r9oKFdsYWvAP7HcUrQXSQqWy9p8fhemE9QZchs/rLq3yOYdB/avJAGAkQmadSENrHkgBiWQFx04L4FmFw5wYv+tsJgP/ecjp3VwDXAhC9lLNfY8pdR2P7cTSF8cjihYyWG1SY64aeDC2hk/DaB8hfktj5uEOYbMYc2YNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by LV2PR12MB5871.namprd12.prod.outlook.com (2603:10b6:408:174::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.14; Thu, 8 Sep
 2022 13:19:20 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%7]) with mapi id 15.20.5612.019; Thu, 8 Sep 2022
 13:19:19 +0000
Date: Thu, 8 Sep 2022 10:19:18 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>, Vasant Hegde <vasant.hegde@amd.com>,
	iommu@lists.linux.dev, suravee.suthikulpanit@amd.com
Subject: Re: [PATCH v3 0/9] iommu/amd: Add Generic IO Page Table Framework
 Support for v2 Page Table
Message-ID: <Yxnr1gBIGwdinIkr@nvidia.com>
References: <20220825063939.8360-1-vasant.hegde@amd.com>
 <77d2ea43-9752-b5f3-78ef-8cdae944eee4@amd.com>
 <05f9784b-15b6-2a9b-2d9e-19e1430f74e2@arm.com>
 <YxintMDEmzSXJUl5@8bytes.org>
 <YxjMQpGYaHfsiuL+@nvidia.com>
 <YxneJ2RqaatKmoYT@8bytes.org>
 <c11bd109-65cd-39b3-6d7e-2b29208ca2ca@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c11bd109-65cd-39b3-6d7e-2b29208ca2ca@arm.com>
X-ClientProxiedBy: BL0PR01CA0022.prod.exchangelabs.com (2603:10b6:208:71::35)
 To MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4192:EE_|LV2PR12MB5871:EE_
X-MS-Office365-Filtering-Correlation-Id: 896c6e5f-5217-43c2-449a-08da919cbcce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	njWzrsxAdZTH4gg9CKbDOgl7RALQnWo2ES3IzfO/0WfG7vFolzQMiPtO5G0i4sxVGeKnyMr6vCrHfM+vsAQttUMZ59U98+elC2amlEkPdF9EMyJomjPV8qW+QmOCftZ/aeclpqrKBzv70w8XcxuGlEZu9y6vQ2nPcyRO9BWfIdGSYgqiKPpenUQ/pfG6EAwwZrbfOn2SKgOruAaQQP4TDnhFG8uAN3vmrtRe0VF46luu5l7HKvaA2Cs0UERFWW8jrWBmOH1ynENQdm6gp8BlcllzAYiMiAoa2O76RxQq2rRJfwtBuI5bW5UwEu2LTp+k2ls/URZSAetscd7Iyk+cOS0s9tgLaZZJQdN5L8qSKBAJDjnzwciKrunS7zQi4SXHgXrS97fNgS4nqonakwvdlC2J8Pt+bjqvFRqGUDTibLxpv2U/DQVnTd8cU0QluiSoe9BtZCNLma0geKsJwD7FF71PJPuMTjvFeWjCYg+9b1iaQ+Uq0csRmSO31r2m/LuAA4+gbhrjDUSDmDyJTlD7Kj4UNDFlTbJrC2J+jliDOV3eMNmGsgCKUik52lAiuD2fUbSkfnaN3WgBXalZAPD8wfzcmFs+s/1z8DNis2yAnHG9HYKNz/YjijS8Jf0YQY9KQO1ax72FpNp8BcVVP0jYjAUNpTBx9qjT44s98M2dX8cRSs1w3IXqvydb/2vU8t9C+2jsK2yOsSqrqpms0HmTXEVq8qV5HNuXRk4CEEkbUvDuCa1QHmiyTnlLHaVx1o53
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(39860400002)(136003)(366004)(376002)(4326008)(8676002)(66946007)(6916009)(36756003)(66556008)(54906003)(8936002)(38100700002)(2906002)(66476007)(316002)(53546011)(478600001)(6486002)(41300700001)(5660300002)(186003)(6512007)(6506007)(83380400001)(86362001)(26005)(2616005)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?INqPXvS2N09h+R491eTBjRTWgI7go9y9qjmyjmcJaOG+b7eKHjlxY09uJgpq?=
 =?us-ascii?Q?KrSju7QwLc/F6LE6ZwpJttlmONJLnjrN/WuPaw/0Omb/y8xasU/HFvtSN/Gg?=
 =?us-ascii?Q?a+jV5ksnrl1/RJSt5lKSUukjZFShUZtKWHF5R7DyufyqYfaXi+RE7LmjEmSC?=
 =?us-ascii?Q?1BCjr6t2sBY9dPrSsSINMhKL4PPVvYaJbPLrrLuW4ek0OEIHvSvBFLw7prKI?=
 =?us-ascii?Q?9+AZVQfyV2uq4FKPOQCcNAY8nRp0QCDrlAiyZvTY3G9H93e921d+4sOBpwbH?=
 =?us-ascii?Q?QmI7bAD8K5Q6caeoYbS4boURg1Anp48OkqYLNQSMJUNVlUk2BYviE+TwNOXM?=
 =?us-ascii?Q?EEIzq2dj69yGiA/RQs6z3how/g0SjMrfk6uUQZlNqomd4rsdPwehdrLaI8cf?=
 =?us-ascii?Q?SBFogxFe0MY9p7z57a44si8pYfpxyV/et6mHLouaNiAFZlZniQ9xfhVkF2gb?=
 =?us-ascii?Q?XSa33WIJpZo/li14tHm8jEYSG11OlkToiOiMqlq5Lkr4Dm9Azd8cdZf9nQUM?=
 =?us-ascii?Q?EzoXR2fCD2dlNNnCnzLbHE42ZxEL2mzAech/PLANkneyh/AMeHb5/AbvLtyv?=
 =?us-ascii?Q?QCEpPpcsLHLtkiFyqDGxViKDCQ5V/yemcHz5H4OjGNWB/sGBXmJbG1rTAAYX?=
 =?us-ascii?Q?iDH2JCrsjeatz1mzif9eIFMgpgYIh1DF2+nSkykHWYMHahRV4aQc3cPBZYzf?=
 =?us-ascii?Q?z1Fg5l7vYjnxyNkKljgp7NQ+21WJNGPPUAqL6zSBF7Cxoyqao1joxsmSAs5i?=
 =?us-ascii?Q?Ls1GSpE25kTZ4obLk1h5kx0s5wcAUiT+kZDyXI3cLCKy49O59m73opKS/i+C?=
 =?us-ascii?Q?43BJ6VEVkgC/7aFvXswZ8EyWij8lJMlfqGN/HQfgOYa/8iukrW8sTji6Woln?=
 =?us-ascii?Q?DFE9BSj/UNIZVN4yKMc7tKSTOkXgv1hYQcCa12dYu3dXQx1wKMAPlXEN8BHm?=
 =?us-ascii?Q?m2wzQOiIzGhgevc+WCL/z2sGiXJy4quGqwV+r3gEkyxfW4Lz0e+Y9h8Z++3M?=
 =?us-ascii?Q?Gc3b173MhOkU7CKFIqDAm/z5x05mDHWJPDQ30ELEJKTOEQV6DiTtBs6P/NjB?=
 =?us-ascii?Q?6mkIFv8TNtizuuOKvSqx/QKqeDIbCIrJaAFjf7uIG10HtWnJYzToFwZq1OHy?=
 =?us-ascii?Q?hnGM9yZqx3uj6sG9vrt3kYuANMPby6Mf893Qhs6U8I1H03KwKblNeJiwLPiF?=
 =?us-ascii?Q?fFzHe3hhEKLoJOg+SKHj5AxjALqkZyt5Mq5uiMB84ME2DqXRoptx8U1MrOEM?=
 =?us-ascii?Q?n1Cbra/8jF38EDdZreM3KF4eNI9U0nLYaJ6UhjvBO9r/r4+xqUFNJZe/dyM7?=
 =?us-ascii?Q?BEcZ0ZgYffGxGkS7Ke0Ym9At09BbgMj9Rww0jl5qCn6XXIaCgbzCaDS4ZjEU?=
 =?us-ascii?Q?X9oFtHYwMRwjomwlYVhgftdSqLLe5C/BCPEdvjk8xT7BwWPibh/HxvzJDUnX?=
 =?us-ascii?Q?kefapopHBC0nlvMJ8i8UTBcLeBdzgY33dedpAnTjoIWR5KcPgWRdoZM5liS0?=
 =?us-ascii?Q?EQBP3F9NMEHUfWxRniX/5691oWY5pJ3/P/cRF9nnYx7a4iraMHf2TmVpDjro?=
 =?us-ascii?Q?zuklCcrrbiX+yRmY0bSsh+9lAP4Qm6amReBO5QEC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 896c6e5f-5217-43c2-449a-08da919cbcce
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 13:19:19.6781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2fqMD9GvMEp5z5jhirUHuifz2wfMK3rzF9EIt7tPx9nsdKU2RgVtqy/mBrn7ZQTO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5871

On Thu, Sep 08, 2022 at 01:53:50PM +0100, Robin Murphy wrote:
> On 2022-09-08 13:20, Joerg Roedel wrote:
> > On Wed, Sep 07, 2022 at 01:52:18PM -0300, Jason Gunthorpe wrote:
> > > Why can an identity map be attached to the RID in v2, but not a full
> > > translation? It seems like a very strange design that entering PASID
> > > mode completely breaks RID support.
> > 
> > The reason is that AMD IOMMUs do two-level translation, which means that
> > the addresses in the PASID page-tables are translated via the v1
> > page-table again. In order to be able to use Linux page-tables for PASID
> > mappings the v1 page-table needs to be identity mapped.
> 
> Ah, and without a default PASID, RID traffic goes straight into the second
> level? That actually sounds much the same as what SMMUv3's S1DSS can do -
> seems I misremembered yesterday, we *could* in fact twiddle that to handle
> identity default domains, it's attaching a PASID to an identity domain that
> remains impossible without installing a full 1:1 pagetable, my bad.

What is the use case for having PASID nested under another level of
translation?

Jason
