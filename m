Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F737198A37
	for <iommu@lists.linux.dev>; Thu,  5 Sep 2024 12:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725539418; cv=fail; b=mz1ZOtM05LsIx3Ps8viJpqugc3dcc4NmhAQX/eYUtoanOlwMeNDadNRFhOBF4l6jZ5blI9LUpaApb3koSQbcvq7Ap7xyv9X/BwO3czY47Vf+5007/Q7wHlap8xm2Tomzxki4qvS/6OD1O52YVpUkA+YFauI+ZtFbAJnYTSou//Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725539418; c=relaxed/simple;
	bh=oEpXjsrxAgSoLJ2X6++44HtoVtPs6mvKW1LJR5/EaLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y3tZQJAei4RvSPetdcrpwqEkpBsldr6eIZ48QhLjKTsjD57cn+C1ORw9bhWmLCQ+tTZQ20ezBP3R4KiVAHGAU8T7jFspIAsyn1684gQoXj4+oF5hcj4MmYxrGIapnisyY7aGvpeiFGofBEH9dommzlStFHVRV/4LjYbZCh0tSmk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=efIXoug8; arc=fail smtp.client-ip=40.107.223.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="efIXoug8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i4J/Je3GaTA91C935ErNxv4YgCtGxZi/Wf5/tydHwjhRniMe1LlXDiM3x60ba1jE/8G5EFNUWR5h4FVEgddKUmvLSQR13BKXvSSdQt75CE8xA7QlH0ZqVBhv3h9lvHt8MfYe4GaxXEI07xWF3sZ27/GOqMop7lH8YfSrEZSuKgBVhsS+x/pr5i+5S7pqXU2/IYXRnm4Owuio0Bck7+Kgi6S0lW4lQ8uz17TS8CSNAEFPr9Z2vD1HPoxJfBMNP4FsWcQ1RC4oLMDvnqYIotOGjS4yix9odWL/FHID3TkA7nYXOkDRwROWklldyakilE39CAYnUJRPLzucbqG6w7oxSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tqSoOYM7XT/AyVi/hfEgD1aYP7d7EhtOmZ2CemmMsNw=;
 b=XfHeFT5wwG+n08itF1DjYPb+3lTlDOaL4/dB8Jm5FER1RQIJ9QDlxHtT52nslYL5axCjadl646zl8bG4YuORf4Gki0CaE5AiUvsFnbk65d+tV5Vh3vGl6V71Ohkszebjx8Q2JQ+ohmgSvvu63V1zSUSiI97uDyD4RJwdiJ+LFIZ3BqbjyEXMS67odpitAF6GiwyZNsIdDBriqG03l4Q7fdAi+XqpBld42R5lKWzWTCsRlw76tKUXjweTu4GXPBobFCfZI4gsJi27/nZwBDmfsqVM9T6VgjV7Fnu5nWe/Gs0slE5YJGcSxkD/A31UZ8/OBs87JzDeln3wJEsjG4QOtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tqSoOYM7XT/AyVi/hfEgD1aYP7d7EhtOmZ2CemmMsNw=;
 b=efIXoug8TbJR0BPjXijngXmEvswRcOyR758b9p03CTDRMWwalyPZL34PXWvCSAb3PXxBnOkFyue0wC+jE9bvKNODo3uPAa5cPj4vk60yrpCmLnTdWdzoQVLKtswQhsBtJUrXdBv7eK7ZlotM9EqyCtzN8I9rYeikHYjNrRTWrS7xOftZO3XhMmmlByWcCBrBohIMLOS1ewIiH41p6l0tmZlquVXNDkAQTX0eEX4h3TGyywp/d/3CZL9mLj1Nel5HgMzFLkuJWm1VN27Rb3NUgJL/fOnczgidobjaWRDLqV1JnWCs64qBQgL0eg5l7kJobFBW8M5K7KGKWocqSkF13A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by CY8PR12MB9034.namprd12.prod.outlook.com (2603:10b6:930:76::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Thu, 5 Sep
 2024 12:30:13 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 12:30:13 +0000
Date: Thu, 5 Sep 2024 09:30:12 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, thierry.reding@gmail.com, vdumpa@nvidia.com,
	robin.murphy@arm.com, joro@8bytes.org, jonathanh@nvidia.com,
	linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	mochs@nvidia.com
Subject: Re: [PATCH next 1/2] iommu/tegra241-cmdqv: Drop static at local
 variable
Message-ID: <20240905123012.GH1358970@nvidia.com>
References: <cover.1725503154.git.nicolinc@nvidia.com>
 <13fd3accb5b7ed6ec11cc6b7435f79f84af9f45f.1725503154.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13fd3accb5b7ed6ec11cc6b7435f79f84af9f45f.1725503154.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BN1PR10CA0018.namprd10.prod.outlook.com
 (2603:10b6:408:e0::23) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|CY8PR12MB9034:EE_
X-MS-Office365-Filtering-Correlation-Id: aa965697-e9a5-4583-e130-08dccda67d92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?P+4qm2Z6gF1LlO45jPbvuzw0rfQQG4XUvCOz4fMUwLhib3+H+mtCyba6D4EC?=
 =?us-ascii?Q?1YKilyiJf/eP3pxOoOSn5lyn/uvf2ywsmM5didpOHAJ4UgCf78UYcHrJ9/H4?=
 =?us-ascii?Q?qKm+wKg+dWh+I7tVgPhTeJAMdtg7V4d9ZIjV0zOVuUjsctN/E05buty+/8Dc?=
 =?us-ascii?Q?svDe+WPsoxVHIDMlAe3PbxTao03XX4E3eUDYBrn8X01Am7ge6lgNt7OVf40X?=
 =?us-ascii?Q?8bQy93q8pJTJ+TuExcEiu4p/mQRVOeXHVp/cRWAZko8Fe7SnxV6BfPAt53Yz?=
 =?us-ascii?Q?M+DfXl7KOBreZ/DaaqyzUo54Elq3wkw74FFlqzTXBmsaWDsnXIvbayRxZx93?=
 =?us-ascii?Q?U7T+JGHCJ94vwAWP/Bs8NLM6d8LxqX7EEH4iHobgWXltY4v2n2eNR24vQ2LT?=
 =?us-ascii?Q?C6CzhNvfv8gd3JmibrmHN1LPvUchoayBBfLIf0NlFfnemSpbvGpzyjqtxyKE?=
 =?us-ascii?Q?qkgwDuQDtQlQHrg8GKyGX9kHF7E4QwgoOyRmXF7ttpBX6f6p7tJXJK0+BoYO?=
 =?us-ascii?Q?+k7WqcVXoeLirAc6lHT7uRVlH0lrB4flJunHwqlmBxQBHrWm6qalZIEpuo+N?=
 =?us-ascii?Q?zx+NgeQkn956eO1lNNfgAoqv8dqI4ISSJpwrim4+iESI4IRFDBBySoXh7CLB?=
 =?us-ascii?Q?JS6ZIrS039mnwtCRpHZuP7SmXVT6UwnhrzM3ZNo5WUNGbMMCZgpoyESyAFZZ?=
 =?us-ascii?Q?dobV2XAiWSBvlpnZCv5EeM5YdxVcJITi/UfPZ/beMhQwup56ISu3qBubyWG7?=
 =?us-ascii?Q?yUC/ISBMIqLEG0Dz73forB57XllB4XWkP8vwz0nE226CoV19hdwvVkouQdxT?=
 =?us-ascii?Q?Bm8/rAyvAPwDrUnwJ2Z+iNJ0mr9ekPaYDPblFRJp+qw53y+S2/y7AZLj1Jia?=
 =?us-ascii?Q?HKCgfbDUX9I6djYkd5dZHXdBF+gnC/gmCzoyYjhssz3f2ri1tGqz5s6EKkUD?=
 =?us-ascii?Q?L6c4ViI5MwlthwukrfYDYU8vPfrNG6MWofjXLOeKyRtKsiWzE/HOJBdVTtvd?=
 =?us-ascii?Q?A1Ig9iYzbStksigmuCRJFoRsDbDXlH3+4jJMLaMtwTcthhBuhrmSOHaVyQvX?=
 =?us-ascii?Q?2jfdC+YrYwaPRsoWfYqYNnlW32Z0UMme6FibsrvBmSz+6whXzb4xO7cGOaib?=
 =?us-ascii?Q?y5zl0iQg/IdSWhUE7Jx15GN8nq0Rx1Ip9YiKtLmfW3ls6lmsVUJMcOqOGrsQ?=
 =?us-ascii?Q?b2m7OIJMHsybzaTaNula2P3EzlQ00tH306E/fU8Qgvie0Lzz9SgVHdANPr21?=
 =?us-ascii?Q?KEdVO0sjuBeVNOx9xw7XaZeWPowwy4wkzLPEW3HPEZ1ULvaX6mkTuR0s5l1z?=
 =?us-ascii?Q?XafJvk44Fc6ZLueo54vJPts+BDDQzWsoj5VFsXwntT4/FQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3ZaKFBUXgeGw3pKj7G/cnZnIeivwV1ymhbgFfPxCFnr9hnNxd4tYs02eQCMU?=
 =?us-ascii?Q?i2z7hHEqZgRqtzipMX0aGsUGApKcwc7s1uaVTC8iO5uqYl3sFSYBWKUbXDqT?=
 =?us-ascii?Q?3jWX7/RF4HEgrEcN9IDBhoBmmZzYpknbYkEufWoeFR69H9Wzz9vKzPw8Cbyt?=
 =?us-ascii?Q?5D4WN6bJQ0mmE4JeJ2QHpV9JusWeYpcaqwEBQyGPYSjNTy4HCa3enENhJxTl?=
 =?us-ascii?Q?zsbd7xhloqloJwG44V8dZ2Hk+m8eFIeQ13qub4+jmInu88KacbN93WLoo0Tj?=
 =?us-ascii?Q?iCXXhx/7OJN9dCkAyUbjUMHr9n7zpj9zB0SsWV3VghN9vlgxF4y7ePDLXYKN?=
 =?us-ascii?Q?e9t+BR+3farD7ukAnGz72F4O3CqR/5u6+0Zb489lI1SKNk87SeCeU2ypkRmt?=
 =?us-ascii?Q?ut2RwQdtPDiZjKH0y2MkYIDi9s39YzFt1aQZVqBLeCAfkBUGlfPpRrEeqHoF?=
 =?us-ascii?Q?IJ84IqTUHQK+79tcBC1vNVIqFiJLTF6GxVcxFMTVePBPvatdC5An0d1fmYxp?=
 =?us-ascii?Q?oFFUMu3/ZsX3zNemJgPGaD+Vhxk1DAzpmYLxFUib2ro7VKmURp9zvdqgi1hy?=
 =?us-ascii?Q?EjWtnWXUEo9oPUzwLTmM6K86mlMoEJx3FVwWRT9pS5qynoY6JedsT+2A/Ifc?=
 =?us-ascii?Q?xkimAG1KCzdMdWlY5bNz0245pFH0lpzLuMJY98jw0FqP3ELP/y+HeM5HBESc?=
 =?us-ascii?Q?6ofkB8e90Qy943Ur+hDCLcWeS/NTkyDp+o6ibiuWJ93vTAwptNN3IoDy4nqA?=
 =?us-ascii?Q?qw2HShaO94goibndfFSqZtcEJlyNLqv/Ow8QCJhB17y4Je+lQNf7h047IPJX?=
 =?us-ascii?Q?mct4ENNPvQ5IfIBIGKdf1EDx4EadbGtMzmuuh3ZDmpr4LVO6e9G6uSCCHSJt?=
 =?us-ascii?Q?9bDU2f77PJZP0SemUgnhYdUAdPe7gKK9Lls3TxYZotudpWjRGXGvfFvknDrc?=
 =?us-ascii?Q?3lU8UtS7hIH3wl0kSZ8UA4uUTwciqM+SBxC6QA9T/Srnjqd70QbBQ++zAfnD?=
 =?us-ascii?Q?PWLKcFJq/5JuMAS26wvmBAH24zBlg6+/kgbxLLzOk/dmi6BlPnkBf6enRMob?=
 =?us-ascii?Q?56+gnR0u+gMne6bmjqYaGnGJ0wA8tvm9MrP1A+4qJMscKKDKAyonQ9PZ5zB3?=
 =?us-ascii?Q?ZtOKIR34ULQoHaM+aaOJQZBHRC/HCtwnLkwII8B907ef0w2wmJa+yLA1KPI7?=
 =?us-ascii?Q?5/+5vARyAFEpQxxe689HHfS0VPP0+03SBgNQGTU0U5d1VE8i3iyYRdqM36qu?=
 =?us-ascii?Q?zFRhYEnrdkR55Tc2qiy5KYYjU/pcouONKL1LHMEGg7dcYIJWKWQYcnE9FkUb?=
 =?us-ascii?Q?cUbp/J2p1prQA/3CvEorLaGP8oII/brhM5dbNXkIURN5AkOILHEF3prAoTZ2?=
 =?us-ascii?Q?h8VMbXQNIhcIlbgnaSftI5OWImCNDCBDhCk5jCNj+JLS+UDMJJ+lUuFiK5Af?=
 =?us-ascii?Q?I8FnYXixIYpuhoq+WILp7LX16wFZuPklbZNIuf98GQm3zqxYZH4hl7+knY+O?=
 =?us-ascii?Q?V5EpTGYkCWjwTWfiE07cgBbawIyP0nv3lnMLJ+WUCugOLKGNoUyW4i4AKwCp?=
 =?us-ascii?Q?dgnqB4S24sKC8XC6m7N4yggT6iMAEtaky4SFM0qy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa965697-e9a5-4583-e130-08dccda67d92
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 12:30:13.6472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VpwXbybVl1WV5vRdzSN+7870E45UEPbZJc/C4LFqlwMSyJEkKIoEWtbNrM2vLaZ2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB9034

On Wed, Sep 04, 2024 at 07:40:42PM -0700, Nicolin Chen wrote:
> This is likely a typo. Drop it.
> 
> Fixes: 918eb5c856f6 ("iommu/arm-smmu-v3: Add in-kernel support for NVIDIA Tegra241 (Grace) CMDQV")
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
