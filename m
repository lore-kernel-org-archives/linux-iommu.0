Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2065.outbound.protection.outlook.com [40.107.236.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE391AA1FF
	for <iommu@lists.linux.dev>; Wed,  5 Mar 2025 16:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741193699; cv=fail; b=eyxgyt9a0h4phpyGNXM/edILgpwkjAPWPgViCIRZBoHzhPo3lgg0D13sG0Qb6BAY3EGkgC2IztmEwsX25x09IJbxld2kCr5tMk9YsMiAklGkHDioGjjTl/ZlTmhKuBqGXDUUFZ7789p7+96frxVZxUwMgoToxnVMNgPOuMCshk4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741193699; c=relaxed/simple;
	bh=cLzhncNliIYEcYPl4scREL1hJP61ugWWjXV1JUdFWdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=B/rVtumUz/myBV9ylfB2hA9MGVj/CPbfXnBnA+tqB4Uz3aHs+ccnHGO3mB/XHupcMp8vOeER1npvLabAQfxrdAnMC9gIfHJtdXrxtKy2NoTXnaCJUJovbpKyhz/LUoJDfD1zqdgb/1fl74WFtwG1Y8iM2N+lw+8p6eBFVV/y7uk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=n8L1jBNI; arc=fail smtp.client-ip=40.107.236.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="n8L1jBNI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SkUlFMttpr3z20OOb3AKNBcDSaq5fUpBC8wfEcUue6jo7TohE5LuAYHD9TRByJoY97QRn5F/prik9v4mYMU9LVKyWDKWlDBmhmLtEu8FH7cGaTgn91bJM1dd/EtA731v4p6ddLjaRTA1lkS1JND/2Q+OcPbmvXB3csIJiyTPxcbjIB6QvKcKxkzxiGUln67l/NpAyUgvZ74fWZ8GRcXkTFXxyQBrAPxLLZck4rLxpo6qmXeIDlNotf+Fbevq7DHfBJm9GsWEJm8MXlI7defqk1I4nlGZBzrGym79atQB3CpKMUYlN3XOz8CIkiInASgNYoarvBk9U6TauKCdZxNwZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cLzhncNliIYEcYPl4scREL1hJP61ugWWjXV1JUdFWdQ=;
 b=uKkwQMDjKqAaz2KcquHrcktTTlAou0GpHUx8XDs8wDGWX73jWcRjE4NAtwG9oWq1w9EqJnio6NAbAJWZMMs3ZpWJFis1GkgoaCZpFI58c//5WWVwzZQ33rVMf1lYmC/wphIl9RFzgahQRH8evTuOFhklKAWR93DK5fXt+alrYj+7+322CpJsl5Ix97wk/qvauKRnooIHB7FYbLjwl7ONcxGrymnHk1EA8RaQ7ASvmYN682Z4irs2Bds6lBh87xeuDsVXTqp2XntDku5u/NezbYSxQ/MR6GZX7Gbg8+Y+PQVw3aUzzLcivCv8MWK+X0YR8+TR4OiM4uyWjPh6lM42vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cLzhncNliIYEcYPl4scREL1hJP61ugWWjXV1JUdFWdQ=;
 b=n8L1jBNIX4UQxEjq8voINQOIjxf1cgJFyyPQSAPKauF9L3KO4jzOoEuK/cc6vQEsj0ciHNxtxEK1DfSo91D46ciRcsFZGmDlkJuuMDM+9MAcg+nSVVym6D7KO7AL5f0Wue9F3vggDMOBhhhDyB6Fh1S3S9TVUl0QWFdHhQwqYBxee6ERSkLaHeknT+TxxM5/3r4K8mxYOc3PZcVjRUp69afTpdglRgqX5cV7yrPvJ7PNV0EiyehX0V+FlG4jWsRUwnAvZPwgjFRy0luSRXZ3O+cyAiG/iDlx3QvORYKtP5c6I6Sf9nUefWIW+01/+qqFLB1FB/Rzb8wD3qwucL6iqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA1PR12MB7710.namprd12.prod.outlook.com (2603:10b6:208:422::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Wed, 5 Mar
 2025 16:54:54 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8511.017; Wed, 5 Mar 2025
 16:54:54 +0000
Date: Wed, 5 Mar 2025 12:54:52 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, shameerali.kolothum.thodi@huawei.com
Subject: Re: [PATCH v1 0/4] iommu/arm-smmu-v3: Allocate vmid per vsmmu
 instead of s2_parent
Message-ID: <20250305165452.GY133783@nvidia.com>
References: <cover.1741150594.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1741150594.git.nicolinc@nvidia.com>
X-ClientProxiedBy: YQBP288CA0001.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:6a::14) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA1PR12MB7710:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c740b65-077e-46ad-22ef-08dd5c0673f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bimW5wN8tN8fxBUc7OQyfdLKX2Ndqn7QjZ+W4TqPxGNBRTxS9j+w+WULvxpg?=
 =?us-ascii?Q?Y+zEiQbA5r/kd0yGC0xjPxCMAQyL+YHqEpCK59zCSHbecVjV1+w9c4xDKMbJ?=
 =?us-ascii?Q?sLF9ClvBoutCyxCQKp+9x2c3X7rUuf1kHRAYpQ43j8jFa1XXME2EosN3f8gn?=
 =?us-ascii?Q?vt4YJq0wAJgIGx21/TjOOxmgJGS7ltfGs21tdvubcAIpvDZbt16Q4jWRZWj2?=
 =?us-ascii?Q?DpT4dsk4Dxqua+Y7yAcO2mjuLT16/STYaBTzV7uhNkd2HknHfAtUF35iTWD/?=
 =?us-ascii?Q?WFVC2YMxMtfkbsfBVU9hr1+SL3f8Zv2vFLj1FaAiGBJLzDdXH+cQaqg0BqIm?=
 =?us-ascii?Q?T3ECGE+9uBNc1cQpCHx5S0BOJUWPTofmkYTj8oxHadGN2bqw1UO/wYOSBbKH?=
 =?us-ascii?Q?NUhgVLs3S99h8nwWSaglAY08BU0nWnfYEnDM1qIgUnByYdJm0I2jXpcshwcm?=
 =?us-ascii?Q?CT18J0HOTI8oVaXIvV254iLlDZKsjX2ZxSJaleCfEOMYl1bc6B+d1/mLw+B4?=
 =?us-ascii?Q?hZMySUIKZpEZ0mzHAwSTZEb//Hapfn1903M9/2xHL9LSrX3J25/wZ0X8/3Rc?=
 =?us-ascii?Q?EJjjQ/TnvERiR6DV5JxQ05fpGepo130P88hGBTGM9cPC6aq3T8Wj94Zxl/bR?=
 =?us-ascii?Q?iOfR/Dgl6FkFPy6xADATYa5OCVcI12KWTwEqoCMWMv/ekb7386mxoZlOeCjF?=
 =?us-ascii?Q?40DcMzOszFtuc3NzVbEnLS2xweNBY3FtRd3V3OqsXrWxP+PLzNVuqewm3dAt?=
 =?us-ascii?Q?gITeupoSJSJJso95lu3jTCcPCCBTwL70RRdLIUWAIm0iEebWkGIz86PSegbV?=
 =?us-ascii?Q?CNZOyBvxsDg/hUR4BhPhm5lAg2cSm24XrTH6jd3r6Q9LWTNsyjhc0p4ENayj?=
 =?us-ascii?Q?hOYOVG5wkPoMEquLhxdpXMgCEucIndxEznv0lWx7H/KkoXgoRja/BojWxFKG?=
 =?us-ascii?Q?YVHuprH3cuIcmy5PO/9s5QraYaZrsCIj3aXAxHudlnNyidQJERs4QvZ1pPdc?=
 =?us-ascii?Q?qMR/XqggV/qfI07rTVLLbnDsWMeKzer26lJhP1pH65jGn94tpzSBuAjPPq8j?=
 =?us-ascii?Q?3HRmUXLhxeRTG8rHawVv+K+keP0SOV8yq7pxfJiGB88j0X0G4hJODwejPeOH?=
 =?us-ascii?Q?7Lfg61/LEHlkMwVT2pdupY6nliQ8GTjPGJNCHeikcZq77x8+E80PJpoinG86?=
 =?us-ascii?Q?GfjiQCzN9D0RrofAOO9o4ovSX5n/F+i5dvUV2YwUWr/gzw/M2tMmIL5wHSSU?=
 =?us-ascii?Q?82pIpO8RBnOGUo4fLariSIz92Vfv+jTjHQ/2diJqjrrqj5QApdA/EUnQlCDG?=
 =?us-ascii?Q?KmrlFG7y9HQU53teCnHTbwdiY0eoKiL9QFKqh/3zzaIlU3wjVJEnsmPgmEdX?=
 =?us-ascii?Q?BYKLRtw6pug5EFDegTfcmlj6dbhx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KxtcBXfrzBuC0s188n6ZcIMQRg/Qr8Q/VacOSysdv/CHQBcq2qFBCCfZDthQ?=
 =?us-ascii?Q?OXT4v4yQbJsZ2iDqy9Qv2+A/NnKiiY+nPpB0WJo4HebNAMWMqfU+2nNQr50w?=
 =?us-ascii?Q?sP29eyWxUVPgjs1GaTznGTg2Teia36nUNb56Tob4EXWBi+EV37xwUQCNELx9?=
 =?us-ascii?Q?epwY0bPSu9aJ13p5vHTh2ZAucW5iyl+KcqIGdt1LWlFI8wd6jWI7zFO9VVZg?=
 =?us-ascii?Q?gy3a0y2+rG4K/0Q0uNsL8N4aENhzShhJFHjsQDnX/nMh+pbfR2eqMCM0CgMQ?=
 =?us-ascii?Q?+Iug3r1+qfTNlMYZqF6R6HFv0nV1WkEv7ZTBvTQBvMPT9SJ+H+7zRZ7rBCFb?=
 =?us-ascii?Q?tlVuXGxb3YKK9ugJkMegZHGbN552Oud+AULDGH+0ECwTvr077aCZhzxfLD+D?=
 =?us-ascii?Q?CwuQx9tMQ2bXto2UgcRiBl5BMtCRv41PAII/uHOnjBWM+9+keP5Ik1lcmDf+?=
 =?us-ascii?Q?01AYX8uYBIDhq1TiQW3q13fVk1SQwDa4f0QhRN+XwGsHFoqfMLXmXsZU84il?=
 =?us-ascii?Q?IroqOl3g+wWba+BVqyIW2hcNV1zqqb58fO/xfjYNT+LD80Go5iLQK64rIzOQ?=
 =?us-ascii?Q?o6OgPw3+NTaiu8NtaXcAlb/pSQ9jxnu9asUha7isv8mDqUk6DXG3yuiK8izM?=
 =?us-ascii?Q?9j37FY/+zyC+TNG5pNY76KypLaExQarKiI2STD0I9QEz50D3VM/fL72Z1H0P?=
 =?us-ascii?Q?RZ2sWGpivTFPfko6yoSv753Ife6H3rbcXxOzfAhn+AbxPanW4+LxZl6OGtz1?=
 =?us-ascii?Q?8+z5HP6KM7ANjM9PZGPNVlLLZ6Wh4FQRiaGGIUDmEhZzA56fionBq4RHCaUq?=
 =?us-ascii?Q?6RQoq3u2KxppgZL/njhC7JpBkHl6S27Db1+Phr+s9nn1Jq2XF/Lw3WlaY2TO?=
 =?us-ascii?Q?l9iy7HxCAmKfmVS5MTV1NEIg2Yd5lKZ0NW/TL39kzoXJqdtjxAny/SCX+wYP?=
 =?us-ascii?Q?vJimY8K/Nh0w+V1TaqXg7IsJkZ+X+0odMVNQsAcBH3egqNIC51tgEuKbpnNe?=
 =?us-ascii?Q?V1+4EAvZfxi1O3Og2d5iMiU21slNwh8Dj1APGPLQeC5I9FrznSi/72f/HUWm?=
 =?us-ascii?Q?4sxz8GLsFv7xMJ+ARTzZoBa5ZWLslmE347D59aAjIgLdYEmDyK+XbKxQIIfI?=
 =?us-ascii?Q?h/5CcfKLLySDVwWxkNm2IJi2XH2O/gLgTvFad/70sbEFCMtgzh8tKRpMucp6?=
 =?us-ascii?Q?9HvhRkafRtHpKOLJ125GjUGzDpUblPE+ZhmW5bL2bQr/BscV1JCl1PnjCUBu?=
 =?us-ascii?Q?3g7ETVZsu0G1sl/UVQoAT8Q7qHqGrl4KaMSkUaiVTvUP/zgPFBdwbjKKPmGD?=
 =?us-ascii?Q?zQp8VkKX+7XlwfSC0pn71eA5CIPKOA/AKb8zeTj55EoSUMyc7EEPEPCms4TO?=
 =?us-ascii?Q?VLNZrpBgLgla1kqXUIwXDejxXLpeBtAFCT4j3XYRLIl+dEHY3AxGbmcRRUgk?=
 =?us-ascii?Q?aG1FelvqSbWw7m3YGqwYBUXG48QXDMxsZGnDXDrszZa/uEJQAhkj5DwQ/zqV?=
 =?us-ascii?Q?MaqY12let8zo3p7stGiGEL+SPa61joXd+1lwDkUxjL95ly+4+Y2RJrVEUvCI?=
 =?us-ascii?Q?vfmx9fy5GkFumLjvThJLNqyMmAKpjVWaJ4qx1Qq+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c740b65-077e-46ad-22ef-08dd5c0673f7
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 16:54:54.3397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n5CvJXGRmMk3lVm8OSsWE27pD2WpNTF+XlflAnmD7yWdq+6t+D+VZrk0yBQAiwQm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7710

On Tue, Mar 04, 2025 at 09:03:59PM -0800, Nicolin Chen wrote:

> Have a pair of patches getting the functions ready for the vmid migration.
> Decouple the vmid from S2 parent domains and move its allocation to vSMMU
> instances. Note that a regular S2 domain (!nest_parent) has to retain the
> s2_cfg and vmid for non-nesting use cases, if the SMMU HW doesn't support
> stage 1. Then, an S2 invalidation has to be iterated for all the vmids in
> the vSMMU list introduced in the S2 parent domain.

I was planning to also fix the S2 to be able to attach to multiple
IOMMU instances at the same time as getting VMID to the viommu.. It
doesn't quite make sense to me that viommu would allow multi-attach
but the normal cases wouldn't. Did you find a shortcut?

The main issue here was to do this without degrading the invalidation
workflow and harming SVA and DMA API performance..

Jason
