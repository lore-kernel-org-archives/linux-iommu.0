Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792DE21B9CC
	for <iommu@lists.linux.dev>; Tue, 18 Feb 2025 19:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739906071; cv=fail; b=kbs3az4sCCg5OnC8mmERiqFxLsLf5tynm/zi5NzzPQbav691xkEA+xogf/mhvZPRuMHocSiV4hJ5K0kPoLTR6lLi5MgOm2lMbwQTrKId+j//tkzJX+HojijnY8ARv9WWEBApDnGYwO0InjPIzy3dTtp5/pzpGVP2CYM8tnwWjOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739906071; c=relaxed/simple;
	bh=HNrtL1SFuw+FDK6gc4XbVjxYuZap6B4ewx3wAD3SfwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pRXaj5K7i7HbupqH0ITDhllzbXC0dThwae6xTg1X0S8Xx0vAimZ1vFYb995qhccJEzZe2JmB95+keKOmf16NeywRJsdG95qJWhscBmWMx8XuMnVg8+3X5FSEvyI+67XxGk1kzmUyJZxHj/CqIjQPy2LAzptyrZ65EFpvvgh6gp0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=a+HVzG1b; arc=fail smtp.client-ip=40.107.243.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="a+HVzG1b"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DZr16x7IaLLfiVegiPNI3h76lZcstlbLb1ZK515+7N3ZBQyyh2NY4WnVbq9Pexv3hfbm1XH6l8nHbgSatoAIJhAiJaJ395hwZImAXWKMj7exx69CwTDsitFZvMJBdZJ9oxJRYnllr+E8bhm++UZa4P0nj+XSiaaIluDERkQ17rzWIc7LObqg7A6KtHy3LNKvkw20c46JArYRd23a3AkZJX+DIAZ3WzDRKWO6903NvO2TCc99pCx6SaPo2Jvx55PHCIjE/inI8AcIDY6C0Ph3s+rj6yj/GLn7SUgCJiIWp0f4kGoQ6GNzZIwNBDnsW+T8IeoTJPHeXcUV4e6uxMuI2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qhCnTbKKFH8eMUWKBstOIabrf0G7HFpAxHXzdCeYOqo=;
 b=vaiQ/+IIxR6Qz6M2GQ55NjsD1C9Zx+H630YkGB8Mk1jK86gF2i3VnGQa+SbEqj+RQ/I5t4DtljebAPhWTE9tiyke+o78HTGcTPGX7EhXeWqTor3BWW2mx1xMCEHBOoOnEx2GuWb350DiKhY+wexPUbukDN2C24JIHMoG6VKuVpwIL+iy1DZC3Uu5VVHSdD4KLgwihcaQCwiJo5iD7oZC3AL7TJZCxRSu85IvQ5L6wjKzAw+tt9BsQWkrFL7dKglwfIVMHVSBY8F+81kHUgLd1ZFDgpXZY/IxE5veyXQ72PCyBZ93Xuf6arZT2iIbUNnUbzeVpZvjGJ4IVKoVKhUOvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qhCnTbKKFH8eMUWKBstOIabrf0G7HFpAxHXzdCeYOqo=;
 b=a+HVzG1bZNfP6nU5zAoukxYxZdSxyadMC/qL+5tlJBAnzKiGjgsLQC2EMxAEs7eUxxE1Rtxj41ZBNgZ2B8UDOymRfQRYcw7SWGd+k+Sf2jNn9AnyWC0iVAj9DirYL3TMI/3tsls1/v42tyzgeHgWDuvSk780mVq3/k3QyJONZVQBtKflDwoJnj0q8uTM1ntfwzs38LuvKULMx0/JdzMHeQjcftyRyVNqzRi37c2dklH10Ule6RJKxNcrligoZ0o5geamz491Hmapys5U5aoV+VGPIcKLialcfcx+BtIiy562bnoJd4qW6yXtj2T4B7+PaeydGDqbXWXgBb0/Rnlr0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA1PR12MB9521.namprd12.prod.outlook.com (2603:10b6:208:593::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 19:14:26 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8445.019; Tue, 18 Feb 2025
 19:14:26 +0000
Date: Tue, 18 Feb 2025 15:14:25 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: joro@8bytes.org, kevin.tian@intel.com, baolu.lu@linux.intel.com,
	iommu@lists.linux.dev, robin.murphy@arm.com, nicolinc@nvidia.com,
	will@kernel.org
Subject: Re: [PATCH 3/5] iommu: Store either domain or handle in
 group->pasid_array
Message-ID: <20250218191425.GD4183890@nvidia.com>
References: <20250212060540.261436-1-yi.l.liu@intel.com>
 <20250212060540.261436-4-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212060540.261436-4-yi.l.liu@intel.com>
X-ClientProxiedBy: BN0PR04CA0075.namprd04.prod.outlook.com
 (2603:10b6:408:ea::20) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA1PR12MB9521:EE_
X-MS-Office365-Filtering-Correlation-Id: 77720de6-8a4e-43d8-7d1e-08dd505075b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uemHsCTtpgEsYIE+Np4IW2O8ff9s6O+9NUwhgA6fdFIdraEzU19GlgMoFXuE?=
 =?us-ascii?Q?56s5yUVT1oQ1wkgk2nwd70DKxkAb6BlCPvGdcDL2o6wkh6HX2BQfkhT6PyGv?=
 =?us-ascii?Q?5HKjtKRHXQhTIVLPqdSABT7uw9wKh1/x8qZbke112CEEYh9yjZ3T1MaRRIES?=
 =?us-ascii?Q?36HXt4jdZ4+ZGWX+QdLoN91wzKauAd0KuNLmQ7GO0mzFm3dqQmVpo+OX5W0t?=
 =?us-ascii?Q?uRbFTUyj1PbqYbjqohWJFHSaDEB0mo8DaBJSdfKBWZr7i1krGpweJgtnDcJY?=
 =?us-ascii?Q?gC3WLwZ+Wmya6CgeevlUb6Sf09tDiMZuUMuSAFN8saVbE6BDhQEtn56Vahpv?=
 =?us-ascii?Q?htbTdJ8g5ig+aI5ESW2Akj/VQrba2YMR0qLOg0W8uijShR6lbsr252avDCI8?=
 =?us-ascii?Q?tpCmfq//VZLedG95KItATZvRSyOsjaQ6QGeP4cHHgQVz+Xb7K38xoBeynJUJ?=
 =?us-ascii?Q?5y5TdblCZC/LL1i4GnqfnXuPQLWfPgHrtBYDl53RW+cUUptCxM55kcTeTBWJ?=
 =?us-ascii?Q?yMJRvFoUHO1ZK/ow175HTLYIJ1dTsuTIdK2Z+kVXQi9xlBaoeOdL5RLkT+DV?=
 =?us-ascii?Q?g5F6NP256mUBa6+ugJXTxLbv0ZfKgeL26ROBDkwikHvyhZ9gUsK1XUBLnFKm?=
 =?us-ascii?Q?Zsh29bLHIdvMGG3Qh15ndqVHY90MG39jkdp3nyYPrbuCTN0lIPISLkwhoxyp?=
 =?us-ascii?Q?yGgbsuyIA1y8IPZwVSvhXkmTxq+iNcy72WuBUGDCoG7xXyFlwCm3MMgXNTAY?=
 =?us-ascii?Q?4UV+ndh6rkiwHjk+GyfWVY2DJMcE+19pj4R0eewSRD2K6IFK/UVB+OUkL/D1?=
 =?us-ascii?Q?3GbkZbjFkyHwN33w7Ad/pDM0xns22iZ+B933awIap7NssvPF+p7L4bkQgutf?=
 =?us-ascii?Q?rEV0pO9c+gmjw4x/skJHVcZlciAaFpo3KT7UQTFpta//kpVbe6PkutKUKPrg?=
 =?us-ascii?Q?p1XvLXURd4g/K/JiI3UuVfz2PFI7LQuSEPeuK9+MZAOQaoM8rXQxTktbM4vW?=
 =?us-ascii?Q?ewvOyLAYU6AfjQnNJbP/lWOrmmIYA/9+KGXv9sdvex6d5SM0I4/IG/VeEBZ0?=
 =?us-ascii?Q?eNPdKvLRviQqBlK5TTJgPq7f58yk/Al1w4DEWmnWJ1bM7Ua+U8C1CLW1MQtS?=
 =?us-ascii?Q?ruT1iqJPu2mmlBiqgeWM2Eo1TBwAxlXoEklmTfzO5mMNUtTiGPCXVGxo1jw9?=
 =?us-ascii?Q?/LBRjXRyT7uHYBziWSP2BeUHGtJc5B8FySktwd7sYlPAhVkySoWZI0Wj+ZUo?=
 =?us-ascii?Q?Bn1hv1Q8Xp2qjRIBQYVW2MJqyRMQ9RAbzUqnRLBtVy/Rzd9KDsoUxiy7a0sy?=
 =?us-ascii?Q?OPMtAi7RVsrYOQTy4PTFDXaqrBfJDUz+ekKYaGb+LBYCqMWr7zDbVD0SWEzf?=
 =?us-ascii?Q?/WXq6Ja/yfnV/NeN+RSzTSvw83q2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H1WIXOVZNOqrWl8Q3Uwx0U4i0p2piRronM73rr6ntecLu9mLhjKy2GyWgHvZ?=
 =?us-ascii?Q?Hv3QvHhhC0OT3ohWHmjWFMzH32B0xA1AScsI3Ofu45O7CrRUiaO6lCuXAamM?=
 =?us-ascii?Q?3Iml1ept1uhr8Kh9jhwWh4BOPTxiSDUiI+sfKdVuvWChkimkd0KjUvG2tHmM?=
 =?us-ascii?Q?/eA0Vd9iIiIkk7eOEkrS4aP396sfcpfTzaoV4RhsNRmL8n+IFTQaq1PTqlUx?=
 =?us-ascii?Q?hfK4IH8bPgiUM3Yuzne4JOq1psJO9UY3R+SCDgzh+Y0lYSSuzJ6jRHRsU4m6?=
 =?us-ascii?Q?1F6pg13H+3LmAJY3a63uhhRIWjrgj5lrXzLbNjI2r561DcVX8aCG/a2Ft4d0?=
 =?us-ascii?Q?u1hTLji7U/v03lXgysJtGdZvxnKwf7Q2ULlfSCGMhOz9M7dgMUC2eYzyQntH?=
 =?us-ascii?Q?CWmli6OENojbsAd25Htgl6Zbc9lYWqi8COcYJMDylbNLUb6pP69atXrkPyYH?=
 =?us-ascii?Q?IykT0T8Yp3hqqhvlkTJrGj9BSIe2hchJ9ujJ9Z9Cf0sI0PyNn4T2LuC9k1Gt?=
 =?us-ascii?Q?pk8UoWohiXNcG9RQwgg9HFVyfqZDApKStzeJfUzNsvPq+RmaLGof/gRuF4s3?=
 =?us-ascii?Q?ucFcMWBbVzSHrtAkUh4+p1FoK+2sQBMK55j6gaPxFINBOj7mw68rUFt+4vQy?=
 =?us-ascii?Q?X0SXKTzlHYFtpw0oE5ffU1ElIVXKkDyg++K/PzHcy00KRFvEpnUZuRUlg5h+?=
 =?us-ascii?Q?La5SAHSalNruM2dy+2k0PuRgPdR4NReosiVD8C7t7CzbpXVJkTGpQAc6d/WX?=
 =?us-ascii?Q?7+RDO5jINrQT4lcl1+GufFaO/1AqjuEB2FPGkCnzXzOmXCBYNufqWqSF6BAU?=
 =?us-ascii?Q?jrrD9FDukgsMClNeADOG6jh444Sn01O9IDhEnZL+E6jm4YNxXTISsajE+Kge?=
 =?us-ascii?Q?doJU0EDW8QuMEMkp6nzSayIjJFu7JsVdphClf2OTNiGjXrQ2mYw8PC5i07fG?=
 =?us-ascii?Q?b/1W01esLgvIPcrKSkAW5Gdv9a2/0D1D3U5FD8FDeD8jy0dLBWpVOvhdVCOI?=
 =?us-ascii?Q?k9Sh9+djmeH6QtCUH7GcQLDXLJni5/HJKXMtRu0vWrFcIR/NhVmZ9bym+Ody?=
 =?us-ascii?Q?axutk2a2kwSG58iBXg+5lD9SSe85XJPVcHPsA7wsi4ShEBBQ5nudVoA5wIx0?=
 =?us-ascii?Q?i4OPxi6k8TmIak2elDJHptGD0D+q+WM56u8O0jgpyCv6oVGCMH8ybN221zbM?=
 =?us-ascii?Q?j7KsGjhPegDws//SDbez2qgugvL35nu7Nx66RuW4BjsECXtV7G8bCz+qhfmp?=
 =?us-ascii?Q?DSzxttH+fk+xJr/uahjFu3d1L3CUyczn7UC2y+0145JZgQoDdFgHmObXOu3l?=
 =?us-ascii?Q?k2333wqRdDrN2GkYgB0NsLZgv1JVbhD+jrhj1arAzfwdVezyToxvu/rv2LNe?=
 =?us-ascii?Q?mKIFEXKTld4SpOCxrc8N9/Xp2H5JY3WbIW8h/Q3rNT6MbzgMu0JtVe5N6S7y?=
 =?us-ascii?Q?BcTJsWICoUHMRJgccFiDnU1z+ljRRDuF5t74MOea4u0BVC9L83n9aUYHXSJa?=
 =?us-ascii?Q?L7u5fM7JO3UZYi+O8fguX5bEaS0F06X6PPvFENdQxeRMTtUMZhd+NRutBqDV?=
 =?us-ascii?Q?VxcthsOSKNvNnxpDk4dCjQSoTxFfMozT4Xp40OtK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77720de6-8a4e-43d8-7d1e-08dd505075b3
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 19:14:26.1814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wMIYW41Pq26n4zSOb6o9yhWzcyzXvAYrF6Gg0SKn9L93eiEv/BIlgM2fQzAf6Hd3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9521

On Tue, Feb 11, 2025 at 10:05:38PM -0800, Yi Liu wrote:
> iommu_attach_device_pasid() only stores handle to group->pasid_array
> when there is a valid handle input. However, it makes the
> iommu_attach_device_pasid() unable to detect if the pasid has been
> attached or not previously.
> 
> To be complete, let the iommu_attach_device_pasid() store the domain
> to group->pasid_array if no valid handle. The other users of the
> group->pasid_array should be updated to be consistent. e.g. the
> iommu_attach_group_handle() and iommu_replace_group_handle().
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>  drivers/iommu/iommu.c | 47 +++++++++++++++++++++++++++++++------------
>  1 file changed, 34 insertions(+), 13 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
