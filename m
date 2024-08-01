Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828E81A255A
	for <iommu@lists.linux.dev>; Thu,  1 Aug 2024 13:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722518939; cv=fail; b=YapS5Mt+aq1Nbm+NK6umBMFZy0pc2kmOEXagDCBr+JSLECGPTc5kIobC8C0t2Xn/kWSMDepunwSHSTI4YleYelBQXZosqPJ+l1Ig+haAw2dYPK3PljlVbtlbByw2hDOian2YR06bu5RG0uysCotXKDwW4gNWUTnZIVdNz6HQmPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722518939; c=relaxed/simple;
	bh=S34wkTzprvUZ7xgOFjSp3BkAqySucwXJiETLKVHbFNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LM+o8LgrbuIuLJQMHKPY+7TfFxhTMl67U5JqZEGhvtvnzNQopssJuod4FRoikgbQ9elY4ygSKXFoSxm+fQzQPPYAOaYIpCYts2Hs9oN0zGAcdlcEO6YpOolA9Ut9spBWf0ZyN4k6Lxzw7hThB54S8IU6HdxPEcydqlj0fLjwCo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fkc3+9Nn; arc=fail smtp.client-ip=40.107.223.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fkc3+9Nn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tpRiXKSnMP1pSFKkKKPA0yNUttPyA456OLgtW/irXWzGLJ14u+swb7J+/xSyIOAN7YCtMjGW7LRhqXyDlijSk6j6wdTNZVOA1CJXiB78ltQ4MVOG6YhRZx/hgACjdviaYHcpykX29owVu5n8GULR7o3DrjiOmCkrD/klOTZ1b0Ei0tpiUxzQLX7JdXYnmdqwhL1Jtpdtz4aGBpcYRHRWFHGMPIBZaQ3PiBJf54lLZWMhIe9JY+OPPV83ixz+mJZO/bn6rukcWadpxF12RlTjboOcC46yItuERxwd3d1QBBgX37yq2u20MRN7UWuVM2toEFSsMIAXALt90J9iVTvAmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GzQL3brxwJ2ByT2dc3k99bWHVd5b4DirbKvB3KHrTVM=;
 b=q5C0gJzPF1Y4uu/xKhZegn5wzgZjac0WOlre3g73fnAc07ibFYIpT70DVq2a5LGznJrIYK+5zZGyNm+Tfp7XW6pChBZp+6hspxzsrZZktfmW03NnZZJ7A58pL397hEdJGaK77tF79xLOMrrDROyER04pugW5fTmHpZhE/+sXFSbtTBQbbyitRM9RL92sq+AY3cmHO4DnZrPgjZ9Idnpf/NX5zX/da75cQHyU5socs0OGrvoRDev17Ep17f8kTZx6xHyMKEE+mwBK0TZO1g83pg52wS3xYW9dgEb4O8Bq4gShPuYyIyYrjXYz2YYmePlbhae9MNFD5OQ2sFZYpZM0+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GzQL3brxwJ2ByT2dc3k99bWHVd5b4DirbKvB3KHrTVM=;
 b=fkc3+9NnPHPaN+W+mLSZSeEGJEuR/hMCDu868zwdSMzWUmQtua9HpiOTroASL+5v3JQY9uLVd+pcQ3As2YWhZfWRke90mpVOKf4xfHlls0IGL38J9ByxN8H8/HU0Enwr80poeaQhg5zFYXhSi4S5DJBZSZudH1lFt/YnXhNJny1aMGVC4bC0OM6xGc76EXaQfJsbLZNedVV2fYpAcHGGW1CbtlTO1suukUpky8cl/j1oS5MiwJni1JWBehp4yUzigiqd1jXllwhPoubVaFP4+/gF4VPF5Oic/AL+4JZz9mkDxPoCaO7b4PIGsnZ4zzrclUSUVLWU0ZCmV9093u7uQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by MN0PR12MB5786.namprd12.prod.outlook.com (2603:10b6:208:375::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Thu, 1 Aug
 2024 13:28:49 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%4]) with mapi id 15.20.7828.016; Thu, 1 Aug 2024
 13:28:49 +0000
Date: Thu, 1 Aug 2024 10:28:48 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iommufd: Enforce IOMMU_RESV_SW_MSI upon hwpt_paging
 allocation
Message-ID: <20240801132848.GE2809814@nvidia.com>
References: <20240728235106.2435208-1-nicolinc@nvidia.com>
 <20240729182446.GH3371438@nvidia.com>
 <Zqf2HFUf/75hRcUU@Asurada-Nvidia>
 <BN9PR11MB5276B125671FEC70EDAFF50C8CB12@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZqqBHKEJCm4XXFq5@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqqBHKEJCm4XXFq5@Asurada-Nvidia>
X-ClientProxiedBy: BLAP220CA0001.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::6) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|MN0PR12MB5786:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e4e5986-3fc8-4acd-343e-08dcb22de0fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8htscWR8gulnf7lhinh1yUEPty+AjCIjC14zTEwudw2pohC6CzCokRKvg7/7?=
 =?us-ascii?Q?ggxCUn8oa5jZkFLE+VjIRBRyAAcF15mHGKUpe4GI8dACPMW20jGThu6CR6ID?=
 =?us-ascii?Q?6Q6xKwQUNzLYd3+1USp14cZFTxBchQkz4WZlauaVH1+fyJZLHWhIJ57eb/94?=
 =?us-ascii?Q?NSDebvImCforbDMbgrnXH7b2KJewMo9RV8C78kS3LmPjx6ejcv9FPd1cKW6v?=
 =?us-ascii?Q?t2y9vS6pw6TJFM/rCN036eoux+wXNQQqDY0A9O8+Gu+NzSnw+Io4xWfLIEZ7?=
 =?us-ascii?Q?L4lPdKxkigSiEpY+O9bDpBJ4Sx6AUoysAtnpwVYXARoIGaTAbgo4506Wx83o?=
 =?us-ascii?Q?5KegVr/zjON1GbVsRJGYN7TTlgVJKidfXeii9v/8gB1UrSTYweuaREcIBKaR?=
 =?us-ascii?Q?8dFhFblBE13LPKe63p1THFsV1bxDnhJ8ocSAPslebxjhA8V+7iUGaWoHPMZZ?=
 =?us-ascii?Q?kCrNq/9q1NJx6jfGKLV3DJSTDWDHyerojl7LC5MAbWkYH7ne+KfSSjLXl+2a?=
 =?us-ascii?Q?CbjB3sfqIpcvKYIcl5eU7JTH7AyMCpNp1ACUEh4kk/lQbm8fMOfHCSKOS0eE?=
 =?us-ascii?Q?0lcKFuSQ0yeQt4VT5hS3144N8aHcIx7NtaWT1g+Rl9lUVXufw5hW8pApVXRH?=
 =?us-ascii?Q?GBWnUHK72cIEyLfYrvkdaAbPW4bwc/dGLjzQ3apNspD5WyTP2uW0Ptt0hdNY?=
 =?us-ascii?Q?CO/YkKfysEQoPbhHmlO0+dxlRYV8Ug+N9GOLuWze4LBRj5Ig2NDckAbySnVT?=
 =?us-ascii?Q?eB1m03vaT1ftoPEkNEngtJLwK3Q9LJYmmdgGvp7xy/f7YwSEDC7Z3G+1x/rQ?=
 =?us-ascii?Q?KqMcPfoOnU321N0dPZrAdlUE+u27s8uJJbZ713LeHkiyNJXW9Z1VtdO4oK3L?=
 =?us-ascii?Q?7kRUsGN83XZ55YY7ud8v2CGzu8tXPQeP4ZmLsZlz7bXaF4lf/Nud1qBoC0nb?=
 =?us-ascii?Q?xdtXMshSDybAJIx0BfAV8wBbddzFnIu1LJsNb+f7Igxh4KkOITV3NYGBHh9m?=
 =?us-ascii?Q?APswj5yV/de5Y2fnY/iJ8W03dZ0xsnyZ9uKB/rrnBlVDF0lnEnLL4BrgxWAB?=
 =?us-ascii?Q?zBvqMzxNR1yNO3Y6djjST/yXNO7p/9FLfI/86dKixMOKVKtDwuC8LifKSS9P?=
 =?us-ascii?Q?ZIVKzX4aXCL7nVUrcf5g4VgN9XDaiRAjNqD8egF/Ygz5KHjfDFltN/bVBvz+?=
 =?us-ascii?Q?WIhNB2YJEh7ygFAl80/ff6ZxdDQjD+AFVtMkg4ShbIgb52EcCeEGoeOxM50D?=
 =?us-ascii?Q?pi7VXpI0S9uLbo31WkRkC8U+z/UU+8nkjhT36PO+ItB3VoKeb1HdkyvSaJ9X?=
 =?us-ascii?Q?BPbeSSgt/xoCdvSAfpcvq906PsyXHhd7+FatHajheT4VcA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?J4a1aQRgLjZ5/r26PRlRMaaHhrCGdlCbZp35fspBBVVnMh7y54gEbSVd/AU7?=
 =?us-ascii?Q?1vQToPd2jbCn0D7VLlT9MPpvVhBuMMe97WI1nnGFWbkcja5/mTAdtawoxjwz?=
 =?us-ascii?Q?kqlTKNy76G+lhid9bILkQ2NGb9j3KMIJK1xl3opNuMblg448W30hwu/M2St3?=
 =?us-ascii?Q?+zL6k12S3xV7e8U7vVE9pzsFozCaKljtIJ/JDC2zKm1FgvhdjPqqd4upqwUT?=
 =?us-ascii?Q?u4nrsk6k5xR5su1hKuF3T9M4c/N/fHxsJ0YcpdDx/wt+6J8q37S8LB+ig/WL?=
 =?us-ascii?Q?ZJII6R73LIQ4Oi3vGWkvCoBoKOVSocN3orzQckiZkFualWmHJ+XiC9xIbTlg?=
 =?us-ascii?Q?nt8ePpOY/1x+GRmfmRaZ+0vBYx+j+6U9fn19csL3JSb2rGKR1MQ0iyVWkZPf?=
 =?us-ascii?Q?hLIgwhwsOajL0tsK8X/geaYZnir1RRZUwZlBdSvubTLP61H6q4egLoOPagmq?=
 =?us-ascii?Q?sMuwmhSi9T8KAQb7EMS3UikHHeHhWmw5pOB1+aycyFrNCb1Gqbrff2mJmZp4?=
 =?us-ascii?Q?hiRkCIM3rEWfZhy+HAApV85fjCe3NuqEggRUN0w26VgKLHVsu2uefkuFOdVy?=
 =?us-ascii?Q?47RYGWNY6c0zmCWrlWjcidmSVcWyytA8K1GT2kOicUQShwRmf1/6dfTsJt6K?=
 =?us-ascii?Q?SFGgrmcHxLbk4FoKmUFPxc2KrWtGfrC5B9kq0xebLEW4zUxgzlhIUuHY0zu8?=
 =?us-ascii?Q?qb88YrlhEfmu32nDk7p1X/coW0P0JY8quJl3SfwWjW1j9RMyXWqn0FEwRLwb?=
 =?us-ascii?Q?lUjuxgkVDE3eAstXmOfXEL9qicQ3STOXosXZUxX+bc3vxBSi1Mrw/5MD422S?=
 =?us-ascii?Q?U8R1syjMxPQQubp+PHvrzaoXgpBrV9xkoeTLlQJ13TEDwz+WtzrNapAaVuy8?=
 =?us-ascii?Q?K2LNl/Qwci5+EZj3rrqF4Cjjte/OZsCT+3lTMDUrZ0BgXASH2rVWAMyuFE1k?=
 =?us-ascii?Q?eBlhC2iuVbMMa67/D8DL6zcNGV7v3hVpVUB77KnBq1rR5OeYwiC080nDP6+u?=
 =?us-ascii?Q?EvcZXi6SXXF8rMlS/v1KJfaogj1x59w9JfCzUUPl+fZiP/CYaXAuKpXTO1ab?=
 =?us-ascii?Q?lO6qbxre3Vk+g2xRrh6Sjz8yNc9tuEj0nN/K6fr4gWyxIg8taADZDeJkm8YF?=
 =?us-ascii?Q?rUuHOzaGGfmdXT/TCE8ME8JmwZUubkAmq+8uoy5lUyjogAyZQSijVvqMtlXA?=
 =?us-ascii?Q?d7UmfNN091ato5wK6maGUGCTGEfFozXtH5cCtWpbNbPXFWOwPwrI1jgP6Nk9?=
 =?us-ascii?Q?3aerrb15S0YWYthYVKdKEfiWMPlWKa7mXF1sWqe5PkgUzWeprUkn0CPlsOci?=
 =?us-ascii?Q?21K04qYXgFhWLbyYAdmWuIBjo0D9UPmPdiTTzhNNUjvkw+hf0yR2kgkxH0K8?=
 =?us-ascii?Q?oW/ud5lC8fntV1Zc6caY8yYTNHHj+nIPhi9BSGJIB09rNm90AfK66kLM7IZ6?=
 =?us-ascii?Q?B2vqS4BZc3SUbBO7HHF2i3pZMtZ+A7EHduxRDkl3lNTjuz6mhboa3/9D+fIT?=
 =?us-ascii?Q?evWNGg47zKhbAaaPMPXxPk5A1QeF4MJLeYrmrQZGXuUf58k0swB9Y0xI+BCq?=
 =?us-ascii?Q?UqgGU/NGKgUo6eokbA3CwdgQBvXkgT9olE7a9uC7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e4e5986-3fc8-4acd-343e-08dcb22de0fc
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 13:28:49.8616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wm8YqeIxAwGFyWAKOt0kQMh8uIaaV8n7ySkX8JK0Hzg1KSB7dWVYxMzPf52Miq20
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5786

On Wed, Jul 31, 2024 at 11:23:24AM -0700, Nicolin Chen wrote:
> > If we really want to go this route I wonder whether a per-IOMMU
> > get_resv_regions() API should first exist then there is a clear definition
> > what types are per-IOMMU and what are not.
> 
> Probably it'd be necessary.

But domains can cross IOMMU's as well, it is not per-iommu you are
after but hardwired per-IOMMU driver type.

What was the issue with trying to fix this on the nesting attach side?

Jason
