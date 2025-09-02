Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2081.outbound.protection.outlook.com [40.107.96.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A58F2F7459
	for <iommu@lists.linux.dev>; Tue,  2 Sep 2025 11:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756813376; cv=fail; b=HRxTg0fTtBKxOMOUJ9NosBAvJTvtY+j4nwo3fGWodJFOv3toA3wmKs5jBMwWltZiUz+8lXQ8tlXW1pppOVHy8bZ7K4CxnoKcIlIhpyaS/o/S28qEMP8dBHipQjPt0IU258ZWQPiMXb6LRjg8F7/od19ENJG3miNVXjkCBMM8DsI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756813376; c=relaxed/simple;
	bh=sDIPItnlPowUfl8tUJMuZlq7MmDRaFvWVys0Jthid3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XmHBmBTo6wwxJFnssbRizJ/2ETMsSbUpa4X9vGcijs4HqRrWCQaWJQl0zo70lMXiQrAorDBFJINinaScKo8m4ficPXaN7qnfnUOCpCATZs1LLg4F67qrLKus51HQxXiczTs01O6Lc2VOMq2fpyJSpNRtqALSbLrrrnj6hD30tvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Je9tioss; arc=fail smtp.client-ip=40.107.96.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Je9tioss"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i/WtPjEBhbF1ZDacZM/T7A5Z9JjQujPQ9A6MACgCbOsPSiHcnwnRbVTqJTtt8pu6BbTfQm8rDlkEe+/rFSFK70gyYhZ3xw5cDFUKJfFAekkIsRbDaFJ2CuIISVTp1NY69CvN5SGPexC4mv12vbgYg7NyTmaBrZZCEomTnfufBFAyXCooKrh8zRED6V1BVbH/ya6SItJ6l3Is6/GZl24RSESdicMq2d1l40zlVsF+QG/V6kNQYhu3CC12YyBidX04d1Az6ys1rs2J4HRlrrVoFKVVEWl4C20fLw9GLt36WNf2/xwwqv52jqc/OP+AmyReT3R0itlUxojHtMnRYj4zGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2PFemYkrpnlnw1glKwC0RTjzUa3BO0zwFSMWT6WO8AE=;
 b=bscWQfKgEUZOjLH+dAuWEhUWqhlbXC6/MlXAjlFOMWJbeb3IT8AYMMdi/cWkEGUs4O/8gkei9ljbygda0SvLZOTTcCfKbmhcwGWRddBV/9A8KR5OUQ467ZWRoJHeDBYO5GNmxpREenQF3SrLr8wm1m8AQtqU392VwKUVNVueSbsV15McULZ8gP3VLFbpu9AgHo4FzNTQBYJYuY+tg8WtdUg0Pmt/ToKPP02bQCJLUJPZUlnn8VoWc4ZAw+l+aO2+4VK0PCC50aJtlU47yp5L0ypYVnsOOm3W9eP3N00e8AhzL5/F8FZsXMILt3mQfaIKXokAmNnvUO8wHj3x0UPKgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2PFemYkrpnlnw1glKwC0RTjzUa3BO0zwFSMWT6WO8AE=;
 b=Je9tiossHioZKK0QU2SfbCgFP6VyazBHjgkF2LwJ4BspgXtKbp6+K80T24Al9P1AbNStVaECDfWNYtM+OsfMaspQoPRpa5xKs5jv5iTmiXSuEiXMoSC6RxJJcUGYJGMdrdfdu/iwDs5N7UQ9e2GXG4Qaa+2Z7iFu/p/dTQ/560xUckgmVCOPnoUuURkALFNgqR0PYE5BkNiKWJN65oTL6FxBHUJR9MnuKTqMVwSxVfXldtdWlQjHexH2xwAFSo80wPmVAP7Zi0wzVSTnzrc4PDEV2HAtZv/zMf24jSz1LvvK2/DYYYwlPeM8gbgbLPfpMT2Cqo0ClCzp0dqhOp+TyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by LV8PR12MB9715.namprd12.prod.outlook.com (2603:10b6:408:2a0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 11:42:50 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 11:42:50 +0000
Date: Tue, 2 Sep 2025 08:42:49 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Sairaj Kodilkar <sarunkod@amd.com>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	nicolinc@nvidia.com, linux-kernel@vger.kernel.org,
	robin.murphy@arm.com, will@kernel.org, joro@8bytes.org,
	kevin.tian@intel.com, jsnitsel@redhat.com, vasant.hegde@amd.com,
	iommu@lists.linux.dev, santosh.shukla@amd.com,
	sairaj.arunkodilkar@amd.com, jon.grimm@amd.com,
	prashanthpra@google.com, wvw@google.com, wnliu@google.com,
	gptran@google.com, kpsingh@google.com
Subject: Re: [PATCH 7/8] iommu/amd: Add support for nested domain allocation
Message-ID: <20250902114249.GC186519@nvidia.com>
References: <20250820113009.5233-1-suravee.suthikulpanit@amd.com>
 <20250820113009.5233-8-suravee.suthikulpanit@amd.com>
 <d949f151-ff90-4e83-a85c-f22ef6b477f1@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d949f151-ff90-4e83-a85c-f22ef6b477f1@amd.com>
X-ClientProxiedBy: YT4PR01CA0066.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:111::17) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|LV8PR12MB9715:EE_
X-MS-Office365-Filtering-Correlation-Id: 2069d484-ae7b-4bc9-a2c9-08ddea15d86d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vvcDDdkAfru2UWDfM4sULdxYt2oATUKiFKHJlMfkTdS0H5K/883d0ipDkuE2?=
 =?us-ascii?Q?F6FJcQTSHDBW4jt4qmTTiYKFuGsnKb6uNUnA/B0fWqNRqBeQTWDx5cTx5hHV?=
 =?us-ascii?Q?PY75J6loMDGLBgsJ/YmgG/G/KAsU7+7t/i9MCdPd1FDy6R7LF1SwotYSMGhG?=
 =?us-ascii?Q?PHDYuAV5Aw7+5pRu3EXJtj6l7eSHmNxqpTLKU+xHBX1Tg734VfRMZRHJxDas?=
 =?us-ascii?Q?neK7my9UbNMd4vttlTOTZFzL2zuD6uR/3An5GHICzS41cphh2NdjbSFOUg0o?=
 =?us-ascii?Q?hQpSm53S7xHr4OfK3gcJ99EvxwjKj9ENHZ6WoV+alKkPGLoeLLA7Cg10bwL3?=
 =?us-ascii?Q?ou9acl46spoxQuP3jnhtS3oXn4a5W2Q1dwPYAPxH+kYzYiJe9epH0SpSnqBS?=
 =?us-ascii?Q?i4YlDyKvp2x/6asLZITAmaxN+nDWcupUkPGbh7t+pMK4gakkipz3Q5GqE5K7?=
 =?us-ascii?Q?xxx3vjg8mxj8H5hPeOTfqWPEK9AJcbLR3HTwoq+zuJX4e/8auHuB2dcpwDCq?=
 =?us-ascii?Q?N+SxICDsBh01eubzFicKsk5mdZeo2m5owmtxkEjYtu9wGOqSYQglH6MokCra?=
 =?us-ascii?Q?WObLWp7h/cIu7O1J2BxokvOA3jjOXM4iUvydakNhW28l8jJt5W2+GkKtbj1t?=
 =?us-ascii?Q?GqPLQ5e4LPqWBBASOk3QSzNc0vNJqNb99mguf87Xw7mqfjIFS4E56v4pvPyZ?=
 =?us-ascii?Q?/rYWZ0HBv1k+tbFILCbtGaoogKUuGzoPJibGcwdBtG1Wzzk3JEuezegFKq4T?=
 =?us-ascii?Q?kPdQv3TLucBTFnukL9EQ06RquCmWI4iuz6UUMTlpLbd5ZvOZ07/FKZRDLsHc?=
 =?us-ascii?Q?mxFENF6Dq1X+iI16tP0FxdM4slhd7QWu3UafqHXRO5znXjfk2zfmu46KwMdo?=
 =?us-ascii?Q?sALHdmfl/EOM20yL7gDWurrvBl4Ky7PYSUHY79TyojkSoJwS5k5X+OhzwCdp?=
 =?us-ascii?Q?BmscJoJa623k6Fqj3dGOxESuZtCuFp1C1C1OXkZ09yt42QpdQgnY42vKigEd?=
 =?us-ascii?Q?mYVyE8JSlGCqpW+XfbulOoaNabbjjfMO0SV7R46EKE27IuRNOY2sLtnW3+Sm?=
 =?us-ascii?Q?sAf3u4hNz25eszimdUnSSDhHOIyIV4nC9YxUNEDfSNUa5lwl9STsw/9Czthf?=
 =?us-ascii?Q?0i3GHWkEQwGJtCPJYRAEOcd1BoM+uFW/HQJ/+1g2I+Pzs9ApheIDDORYszFW?=
 =?us-ascii?Q?5U5rH8CmFq/CSxn8Wtgqevk666URukCblmiAhtHG5vt2XVrKjtCiRi+NuN7C?=
 =?us-ascii?Q?sNtzHtoxi2ncFXfT7/GqAuzvnucPJbimEUAlQjXLTs20y/LQ53wFK+WDO2qi?=
 =?us-ascii?Q?rSBHkun7aU3cHuEjl0zCVMVqCQtYXsCkvtkyRT8zdNIDj8+P3scDQK709q2+?=
 =?us-ascii?Q?M/p1A0kRO7JQFSIaszRlWN1+bsr0ErKq70l8v8bjDzW6rXldfzCGePeAru+H?=
 =?us-ascii?Q?BlkemsJeBwk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JUuJVz5HumkC194OKe6fj3gdhPRmF1dWpzwydpOvGT7aDXfIsUHc0sHZhXYf?=
 =?us-ascii?Q?F+zVb0q89zBjP2lfKu4xp9a7xz19kSgCsYnew+KUZfPm91CK6tAX8H3pacy2?=
 =?us-ascii?Q?nKb/VNh+OU0gfAygwzswgOTo8nSkibukxHGDx1tAZ0/Kr5kcjfYFVLxpLtz0?=
 =?us-ascii?Q?MBloc7yh7wwCyJ9EauvZujdGuaNkenTsx83+hKS/WL5FJL59gW7davTFeW4s?=
 =?us-ascii?Q?Vf6le44xpB2rT704FLUlx4kTJUzJ+G6g+tPjLxbl1AxZnhuvFFxefFpIYPW8?=
 =?us-ascii?Q?WyR5zaEKXvImvydKU3xlnrVeYr4C0LkuPCGNokjSpPhmqlP98M4VV2LmRGHm?=
 =?us-ascii?Q?GYS/WMjx6jHSZOw76zU95eOCsaX2urQtZuDkSOUTLTSgjlXxIFhQWiMBhNiW?=
 =?us-ascii?Q?AiEsjnkipklZqsYMocOUieFV8Q2DpAbyABiq6W/KBepYTaf3+LsxDc22LnVR?=
 =?us-ascii?Q?vqhBuRlUidiaKkas0ysyqzBH9oLLySaQn9RNLGvahOMM1MjHnUev4vLku8z0?=
 =?us-ascii?Q?oeqoB0qji6aOErHTi0tvSzqIYk2S2x2l/XaDK+fK6dPcV6DJxo1A0+M0J68G?=
 =?us-ascii?Q?W/Sk+VJ2HNwcBkUDTNgV9443FAxi65ptIw37sJr7tM/eTlesNEfSzjVcgjYu?=
 =?us-ascii?Q?zgleEXAdiuPjxGHWuDysxfJ9X7wufZOhXR/HRhKJ+LJaKP1T8mQ4G3znKJ4+?=
 =?us-ascii?Q?ALJLgJeVWUp7yQrsUD5yTMhD1wKweVF0/a+lN1M82oFOdv4AbEbtC6tKFNBf?=
 =?us-ascii?Q?cs+wJZXRZTs8azjKmCXHtqJV6AVvYVosJat3QYz+iqdGIxYnFCAkRRCJdVxY?=
 =?us-ascii?Q?6DQkk9p0487GyJrHhYjaGlcuV64pBILDcYHhzHZwMC5MjgPLwSEhGp6y8WRK?=
 =?us-ascii?Q?Gf5ZUpU4eB/dtN94Uk5/2IlEswJEoujHxChp378mS/zaISXzGvzp/Y1Fupt9?=
 =?us-ascii?Q?xkkcqQtcjjxke7eN6bYs27QpSU1lFrqyPwXWcG70SX/JXi1PiFxEUpiC3sl6?=
 =?us-ascii?Q?2qS5t1YcEo0nFZXZp2sI9uC7QH4nWUDKB0DyFuQ7cDLdWeZQfp7NYhHbLjL+?=
 =?us-ascii?Q?ILBy+P8iYQ7HVNg/cOpuCP+ElYcgXgKRGjy22/11oZdMgDxa34Blb1Vc6mQr?=
 =?us-ascii?Q?Xd+r8JLQzFR3n4epubQTKgJQNlrzVWopbMzhToGXJTKC1J4T/SjuTO+ETp2z?=
 =?us-ascii?Q?L3RyD8bhIUTi7Bb0gSAXRpQTKjr8dc01N9aJ94Ie4bpg+vzADFZU8RAwLthE?=
 =?us-ascii?Q?Lh5v+suf1nW/deJWBi/MWU5nK5xjeVkL++wC60o20mF5HJsWz/1q9itsfvFl?=
 =?us-ascii?Q?bdUYGSavHeMG2PUAwxWQLePNJWZ8xi6rmW0jDT+QUlxJC+l3boMNo73OzZSx?=
 =?us-ascii?Q?5wRJd+KzWlGXrY/H9tJZ+1XY9e9D/ZlVm1seZauJkAwB86HDBc+Vxsftty1L?=
 =?us-ascii?Q?9kF4zF8xSyhswesIdGaRvC2+wp0P5p0jNyk9UCwsCWf+f82hKx02t+mXL5JG?=
 =?us-ascii?Q?8Kv2XsSmsu2MWq4APLtU+AvnP0daMnnRs2dve5siWFW0fWfpzofm2TGkdhSV?=
 =?us-ascii?Q?3i9kREYSgkECRlPcYvo=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2069d484-ae7b-4bc9-a2c9-08ddea15d86d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 11:42:50.5100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xV1rls8rNMwYL6A/6sW1u166CR499BVc8pjc/Wp1ksH2y+ejplbRMYnBal6P5Kzm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9715

On Mon, Sep 01, 2025 at 12:39:56PM +0530, Sairaj Kodilkar wrote:
> > +	pdom->pd_mode = PD_MODE_V2;
> > +	pdom->parent = to_pdomain(parent);
> > +	pdom->domain.ops = &nested_domain_ops;
> > +	pdom->domain.type = IOMMU_DOMAIN_NESTED;

> > +	pdom->iop.pgtbl.cfg.amd.nid = NUMA_NO_NODE;
> > +	pdom->domain.geometry.aperture_start = 0;
> > +	pdom->domain.geometry.aperture_end = ((1ULL << PM_LEVEL_SHIFT(amd_iommu_gpt_level)) - 1);
> > +	pdom->domain.geometry.force_aperture = true;
> > +	pdom->domain.pgsize_bitmap = pdom->iop.pgtbl.cfg.pgsize_bitmap;
> 
> Hi Suravee,
> You are assigning a unintialized pdom->iop.pgtbl.cfg.pgsize_bitmap to
> pdom->domain.pgsize_bitmap. In non-nested domain attach pdom_setup_pgtable()
> takes care of initializing pgsize_bitmap.

nested domains should not have a map/unmap function in their ops so
none of this code should be present.

Jason
