Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010032.outbound.protection.outlook.com [52.101.201.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB3946D551;
	Fri, 25 Sep 2026 12:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790339965; cv=fail; b=UcLtjacwljqYrwFaxNDEy2Tt2OWTJ3zWZIRvg7voQOoKuyn7hJXPtsf0jaoxIqGF96ujAjV+Adlss2FNnigY5T9fIdKcmK8AB75tfMN6qqoShthMzOQgKULqB1/Yrj/XHqOu32GywCeEvhgb9AJIWdNAnysBu8zYLShP/TkxJ3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790339965; c=relaxed/simple;
	bh=irKTtVotnEek/whP9S1Kf1h/bYI8DQmO9mxMvZjsCTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uyffO2+Q2MUKk6TMaubDBKT7Z6vam4e/7bhoyT+HYKk8kR6QeJr++Lu6BaqdAZGw6EEDjnmebWcPkp18AkOXT/Ln734eIpu7MmIPLw3STd44EJ1RqucaE4Tg/2HlQTW1EDUd8Yb3G+0Q9gtgyAnfP7/5aMYTKM5ty4skARWXCco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=j0TKsIx4; arc=fail smtp.client-ip=52.101.201.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="j0TKsIx4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BR1USVs3PfLKZQIAjFx9yCkXnVrZmoS+ZJX6V5bZbKZfJs81oEomAAQ+tQEuxf7RJa2UlGL+YnYq0PvzC1YmY+mtXec/HCmY4oiCQ0tF1hLUa7Sat/L3A0DJXwWVxXmIhDanEBxeATzXqFLXgyOpIaUoph0zx4TmfK+EBAeRhp0of+y6+MErbPU5nI/QNIFHJic9YZ9/YpFxKnE4ndVJFUNKVTHaIta4EbceGlr4sFx1L3zRnMApFpReR6uD6jbqlGI4Ia/AEU5+SWlXPJsEUnVv8UnRupS2LgBdqxvuKtHrncLpFfsfA+6f5P+AGTUpY58Ug7nVkVeoscNLzvKv0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WECXalOCr/3D99hnQPBOZswAipMaQ4Z+5Yt15h3qSMg=;
 b=Z0D4oo826wENm9nLtJWhhgSVH89ZzskOQTjQUNPfOo+sPbjnBV9Ol3/KrMNlyM55NzGDfNI4rnQjyMP+xEvtRciFm+PxkWFGoZ3XXghCCaUhAwk5GMmJVefLPBnidAJduT7dgwzK8tjhkG317qZF3GsLTlIf3c51UzJEt8Uy+N/sjc2NthUucAssbhRzDoo0u1D3uob5v+0lc5L+wZQk9RhukyBHoPd4LxpTayCsTWxTWNciCcfhmNT561WPaQYJTi5UEEBv6hsG+YWgdN0B2+LBY3W9YTrw7gTL2VRaBEBLm2Mt/r/JaxpNeHkZTtWAE5qzjmy8Ggm5HfQGTw+P2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WECXalOCr/3D99hnQPBOZswAipMaQ4Z+5Yt15h3qSMg=;
 b=j0TKsIx4lpbNczTkuMkLCTiQOcc3V3PsfwXQQoUKPN1PgQIpFxJgdjYiXmGr6dVH/2FuRrXqmrlQQJn5xMertrrpFF4ngn85yEXRcKpQV0g0XQiotDzfuWfnxpF+BUulr76EF+NUIYU1AfBC5ALdZ2AfKUKBsYSek54i7m7Nhp8NP1QuAp12aIa/Ff3dyUvYT59+CQifBRloC9RD4ProuAm25noVncg9pk1qaHMrMsYAaEkxadu0jJyJf8dLFy8N9uo5m2VsPvjxWCCXcTx6hKeWcf3/f+AUFum4kj0oRd+807B5b5qGLu8wvOHd+QTSx5TG2XfGy+leLQq69VTzgQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB325698.namprd12.prod.outlook.com
 (2603:10b6:408:3bb::14) by MN2PR12MB4173.namprd12.prod.outlook.com
 (2603:10b6:208:1d8::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 12:39:19 +0000
Received: from LY0PR12MB325698.namprd12.prod.outlook.com
 ([fe80::b65f:1548:5b35:e2b5]) by LY0PR12MB325698.namprd12.prod.outlook.com
 ([fe80::b65f:1548:5b35:e2b5%5]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 12:39:19 +0000
Date: Fri, 25 Sep 2026 09:39:18 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: linux-coco@lists.linux.dev, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	Alexey Kardashevskiy <aik@amd.com>,
	Bjorn Helgaas <helgaas@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Will Deacon <will@kernel.org>, Xu Yilun <yilun.xu@linux.intel.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v6 08/11] iommufd: Add vIOMMU provider support
Message-ID: <20260925123918.GI9354@nvidia.com>
References: <20260917140159.1163281-1-aneesh.kumar@kernel.org>
 <20260917140159.1163281-9-aneesh.kumar@kernel.org>
 <179027891417.104879.5995584402952067518.b4-review@b4>
 <yq5acxu1kgmo.fsf@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5acxu1kgmo.fsf@kernel.org>
X-ClientProxiedBy: BN0PR04CA0116.namprd04.prod.outlook.com
 (2603:10b6:408:ec::31) To LY0PR12MB325698.namprd12.prod.outlook.com
 (2603:10b6:408:3bb::14)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB325698:EE_|MN2PR12MB4173:EE_
X-MS-Office365-Filtering-Correlation-Id: fabc8cee-1fe7-4475-f47d-08df1b020490
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|56012099006|11063799006|4143699003|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	2JB+Fk7Q9CJZGz+ztJWGStVuDuFhUn5Gv1+3hZl+mkB8ZSBMAHK4rMBNk9Qn5y41E9O8MPdRjqmaZktJBG92ABgmonIlH+1qzJNUvt8kxhIZ6g1Mu95xY+JbBEO4bCFkvLd7uD0tcL964q+XlLt9S9wGMhDgQFpJI7AZ+DIzZBOuDrbYxcVgcjJ7+FROInWdqm1rzo59KyN3NLmaBTqt+zLNB7ohpmSOXkLYTh9LlJuLsESm7vTCSpdGWwXTtSALPwfg3OhBdHpUTYbZeOK6dhgrZx2iuAtRDsQANd8p644kPWRgYR5D6Zfwk3MO1PzvArMJWO4Xd3BSIL1zCrB3ovCZcgE5IqAAhzkEJFJjMApa5Cu+6lRAXO27OZ/327yZCHKZxBKrB4cLhjKRZX9Wzmtp4qXzFomHT47uMMpTiFMVNFE//Ibvs/8QlarBUAtqE5oSfERZB8YQtTcCmTXovwk5rhDdOLgAaUCQ7U3sZLadYF0AJ79uqm64syC4PlbYyc/oEud1s4O6oZNOcTnkzra2dTsKI7N8E3Wfw1RMu3WsqNlDALsV9/y+nKLZRii3ceSD+EV3hzmyRYDLqmOwcsmpT/n1h2FwD4E2OAr7H/Eo1e4x+4m1QOwZulxX8ePRPXhZu5qh9vZ2zYRXMeKG3HnTEaTFaTBYvP1IyLGyNg0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB325698.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YOw+3xoriHu2V8Y+bxh7L5BVXohPOTkX/76wR4kv9XrlMZu1/UUL8wVnM0fO?=
 =?us-ascii?Q?AsOzWkG56RdfvMv6sE40CAqr5+asv/mtYaRWt15vxUEgirMwBsv51APz0C84?=
 =?us-ascii?Q?uvTtI4fDRCL9wh8UbVOETa7sg6ro0EeA0aBlCuzCYMhUmQUaoJX9CwhkZ58a?=
 =?us-ascii?Q?jbm0eU8OCXtl+zlKeANR6czAc/5dm0ybiCkhfmY+NTAV8YiuCmk4ujwbw7kl?=
 =?us-ascii?Q?7Thl1G+cxIErY7Qg2pXGhWBq75FoXGkdGe0XizwbbGFPFiCGufsAsUaZWW7M?=
 =?us-ascii?Q?eB/gMNeGUfBvTkNpL+ZClar8p6X1usCISKEYGiV/hLBtlkYkccCIXXGrZFYJ?=
 =?us-ascii?Q?GKM5oUfzhbJ33Ybd/YyIZZlsE0TlA2EmjKzXZgPVS/j5AnB0s3dVYEclGc0k?=
 =?us-ascii?Q?WfBjnoJw2Gvdvk/sYLJQ6kaGgJKMg6zLJY0HKnRngPqjDYmwPGy3bGBqGsmj?=
 =?us-ascii?Q?bkDSi2Idi0cFYYQwfYz7c6wneDfjpQ2m2GqMgQmlEqRqBRlQNkYfMRIrax5x?=
 =?us-ascii?Q?7GSiFpHNKGP9IfOlruM2oJpeq+dnD906XDfxrKXPbdKfH+5umoJBruO7TWEh?=
 =?us-ascii?Q?heHnLgAe3e9KOUpUM7aiEJDnCYpVOcYvRqI9VDGXgCW3ihuvTt7Hjlf3NdbS?=
 =?us-ascii?Q?aWwtrRjbBm4elGabndirtWuRiBacRwM50aoIUE+Usc3hvatqsA7Dvyr9fkPY?=
 =?us-ascii?Q?ZhuhV9Czi1nrnMwnCYN2vjZkCaHELYZHaALsaL4sET13TpWaYkMvQHrCVztP?=
 =?us-ascii?Q?jvH9vJCLFI4w7zWJOm3itBKBwcg8uujzhcGt03cG4xLHxOmid3CcPvBxue3b?=
 =?us-ascii?Q?wxUDeBMKyTXoMIW7NCIE91FBTVnsV+y/t3iBGOdSrw6/sRu00O7sr2ci5VW5?=
 =?us-ascii?Q?wFEV52oaOfLxNEuJU//CD7H2hB8tqya+Ggwx5Gch2U15OBcYvMSvaTzcas4G?=
 =?us-ascii?Q?Cx4C4iRhudEu66oSB8wvL+LHUWwYEJ2r7cfvCgAdZlkZYJfaq9YxSfAJWGYO?=
 =?us-ascii?Q?EtLnPnbssSagEXVv5SG9kzbXMJNEIfAg6X+lwXRp1tUbza28DKO5kaeH0wdo?=
 =?us-ascii?Q?BcfwuGQUljBqbKWcezSf95ckd/Sz3GfoqfkTnEy0E41Qi/oDYHe+i6nmT6ue?=
 =?us-ascii?Q?E+J5xP7DMK9x764gMFEWJun4r4N4CQKrmvLD0SLhNykx72DUYhxAyk4LHqAk?=
 =?us-ascii?Q?xBA3ZTuZc4D03UQ9MY3w2BUSdPImipFWKN3VPrconkbuHvdyJnZJDJXzW7j6?=
 =?us-ascii?Q?pJ2FtbrC+xoiNqLZgp0IGWjmgoHmYCI8vU/QlmqQSZWuFouDBgwH1xCK2+Al?=
 =?us-ascii?Q?hePP2A4iQaAi4AfE/6JeykT5dWZEvgfzW3oj8I7KZxrNmZkYrQY6LB/nRTlD?=
 =?us-ascii?Q?9LxtNdJOJWUKrDTodLyVlmxEhEb5PhtREjmnEiCTokUvf93dLZhX0yzweur1?=
 =?us-ascii?Q?ebGJCgSZLAkSknGHBdPO2HfILvSRXVZNJH7U7L0Gs4HF0Esa4a6Kc9o6BxbU?=
 =?us-ascii?Q?tEuQxlG3pW0QKuBHNO38/6G7hPJmmhSBU0t/pxX0Z/fd3WuYjbBTmj9ED9aS?=
 =?us-ascii?Q?/d63YVKgEu2hoQ3Ij4EUE3+1U3N41a/jvxTvUllp476aGZSp2+WfQkmT6gvF?=
 =?us-ascii?Q?LM/GyVy2IyNGfpmeVeiqoDdmWIuS0MChovtO8jwdx6enS8MP8ozQqMTK94VN?=
 =?us-ascii?Q?W2ZDNM4qhgS+hvxQ057MxOOJ9VT+mIvIpk8/y4F6FenwD61n?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fabc8cee-1fe7-4475-f47d-08df1b020490
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB325698.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 12:39:19.1302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gdi/+cpTNLrJNK9KzmEnfx7Xj+UXxxeycUzjm/Z3H4DnwTiGnh5IdPQZRrV13OGF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4173

On Fri, Sep 25, 2026 at 11:38:15AM +0530, Aneesh Kumar K.V wrote:
> Jason Gunthorpe <jgg@nvidia.com> writes:
> 
> >> vIOMMU creation currently dispatches directly through the physical IOMMU
> >> driver. Some vIOMMU types need an implementation supplied by another
> >> subsystem, together with private data whose lifetime extends across all
> >> vIOMMUs using that implementation.
> >> 
> >> Introduce a vIOMMU provider that associates implementation operations,
> >> their module owner and private data. Allow one external provider to
> >> register for each non-default vIOMMU type.
> >
> > This seems much more extensive than I imagined when I proposed this.
> >
> > I imagined you'd just have iommufd see there is a TSM attached the pci
> > device with a function call, and check if that TSM handled the
> > requested iommu ID.
> >
> > No need for a registration system because we already know the only
> > possible TSM driver that can handle it,
> >
> 
> Agreed, there will be only one vIOMMU provider. But, without a
> registration mechanism, what would the module dependency look like?
> 
> I currently have the TSM driver depending on IOMMUFD. Therefore, the TSM
> driver needs to tell iommufd which vIOMMU type it provides and register
> the corresponding provider. IOMMUFD does not call into TSM directly.

Just put the two new ops in:

struct pci_tsm_ops {
	size_t (*viommu_get_size)(struct device *dev, enum iommu_viommu_type type);
	int (*viommu_init)(struct iommufd_viommu *viommu, struct device *dev,
		    struct iommu_domain *parent,
		    const struct iommu_user_data *user_data);
}

And bounce them with a static inline

static inline
ssize_t pci_tsm_viommu_get_size(struct device *dev, enum iommu_viommu_type type)
{
	const struct pci_tsm_ops *ops;
	struct pci_dev *pdev;

	if (!dev_is_pci(dev))
		return -EINVAL;

	pdev = to_pci_dev(dev);
	if (!pdev->tsm)
		return -ENODEV;

	ops = to_pci_tsm_ops(pdev->tsm);
	if (!ops->viommu_get_size)
		return 0;
	return ops->viommu_get_size(dev, type);
}

No module dependency.

The iommufd side is simple, it just calls this before calling the
iommu driver. First one to return a size wins and creates the viommu.

We'd want to have a reasonable lifetime model where the the pdev->tsm
is guarenteed stable while a driver is bound.

Jason
