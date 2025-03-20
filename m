Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D3D1E49F
	for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 23:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742513518; cv=fail; b=PrZqD7Ku8IhIhIWcYiC5NFBucvC3GIFAAvaos/u7iJQTRjdEVIuegFSpdhAX07XKQitU4RQ/2hnD6wEdvx43G+11SpGcw/30XyWM7Y9unHzxOaPQYAyqjo8qQfsAr0Z+jSoFOZhQ47LWW475sap3XGN0DJBOmvhjSTAiVHPa78Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742513518; c=relaxed/simple;
	bh=I50To9cufDAneeLfNSTBZeKu3mImgviVesAv7DsFzzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JW2+jFfc5zEfD7kg0dyTft8cqdYUCj3qMvMbXYTJujCH36lB61ju1asM1QJLLDuc0lm4Qzyzb2LXie79EyiAtQs5Qkn4TuoNz6QXHia1uC3Gfe1QoM/NTZYeqOQm9X3ObkxUS4yUc5bQXJ94MjdtHaslM6e14LDDARJQ8Y6Fytk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=X0Pzy16n; arc=fail smtp.client-ip=40.107.94.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="X0Pzy16n"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KD5X2zBQ5blNmImxOGyRhNYygOHVugl0LSObbz0XB22ls/yb4ZitsZwVax845asDJIIMLRe447ZskTQTV8UIxmpWJIzq6u/g6JCPjcD8iUhWdYlB9doQder7AtgtF0lIo30K3KKKj1A+iC/A9TrtQhmKgrgscyBWm1IhEdOhGrqHiKuhSGcuNF7e23wA294c58owBrx1DL1I3D2pV6Se9nZY0wlge9ZaspQCvMxRp1yvJgJIwvW48JN4M48cdq7nfzlfvYHpWQLFqDXeWiqhQ8oPV5pfC5pevNwPjKaA4bB93AIw3qW+/meqtpPs5ZB4kghD9FidzxbZpYGOCQPgaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+v5g1X79Nhwj89L3xWecUw1hmE0vA+sDom3tDuPQrWI=;
 b=dTqYwmTKIpp4wDrUU8+dtuWYL45WOJ3RzCsav3xMKv3RgnhZmYT768nvmDakirPBIUNyZArlAqYpiL9/EiAbAXVT/LMKqC0EpTDNCvzPjYMWCN4MH2gSloMTvS2FJpMOX480M0fDB0B6nch/lofFai5kBbkHZwcWaVhonj63XaEfxtslYjGU5oapshDDpp1cpxFbB2keyJlky0nVNxqwmFaO9BhZmimn4OImvDxQSKy8VoeaManHpeaiCXKBfruVmTSNT2KRIYSZ8/Fbl5r6V9f58TMmbY4Y47yv0f9iO6UQNk+hskf7zJ6KE5lLzLhN0T2qQP7kEib3i37BQ1cP6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+v5g1X79Nhwj89L3xWecUw1hmE0vA+sDom3tDuPQrWI=;
 b=X0Pzy16nlhaxMc3hloAOVFQvUZg2gPXqZsuNwXMAg+Lyvj9FNeL09NQvphdWtdnoNPDeWAohrxfWHQ4XoSAQZl/jBQn2ZrfuJpIKRm+8UdxP3NYgo2iyXRMJgz25W4oCBakga6hAD9kg05J5wvuHk/1AvDE0ZQ9NBoVjX1youTzMm8CRIBgnRUSOkENCJnH12hiobRrZ7o98CRLtAmfXI8c1nCXNfl4j4Fsq75Ouv5IlTletQhHmSHolK5zvfRNBZJ7jY/zKKRU/m8Hf707a2IqIwC4aNx6bmKJuD13Ty8osVK4VZwTI+OKEmI+qXvX7Vj+ppsbbScUhlfiwBbRr9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS0PR12MB7972.namprd12.prod.outlook.com (2603:10b6:8:14f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.36; Thu, 20 Mar
 2025 23:31:51 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.036; Thu, 20 Mar 2025
 23:31:51 +0000
Date: Thu, 20 Mar 2025 20:31:50 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Yi Liu <yi.l.liu@intel.com>, kevin.tian@intel.com, joro@8bytes.org,
	baolu.lu@linux.intel.com, iommu@lists.linux.dev
Subject: Re: [PATCH v10 12/18] iommufd: Enforce PASID-compatible domain for
 RID
Message-ID: <20250320233150.GP206770@nvidia.com>
References: <20250320134744.5777-1-yi.l.liu@intel.com>
 <20250320134744.5777-13-yi.l.liu@intel.com>
 <Z9yVU0GSbl+b6C0y@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9yVU0GSbl+b6C0y@Asurada-Nvidia>
X-ClientProxiedBy: BL1PR13CA0356.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::31) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS0PR12MB7972:EE_
X-MS-Office365-Filtering-Correlation-Id: f1e07220-d560-4c6c-3802-08dd68076449
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?A9gCWaCcI2zQ/0c8AJGNmRUXmCiZ6RkvXnxAiJSmcMr3NgcBNah220ccaCum?=
 =?us-ascii?Q?cJtWU8zy1E9XJs9avsCFenNYqZ1mgYfe/OCaKjSdwu+PxF3yaPJNvOlWCbNu?=
 =?us-ascii?Q?WFOGstYkm/j39ALFxC61RjxBoNkR0v2yfq+oz95chW9kzrIvulzqS+/S6U70?=
 =?us-ascii?Q?Z1kSRHTWD71lwtrP9hJ13SZcUGmacwkIgdYWjnAQ/NCiy2UmtlcR7FHAld3r?=
 =?us-ascii?Q?a2nkp6tPJiexKd+Hx8P9zXwcxqqor315dHLDgVkzTmEsR6T8K4PZlUXZqI8F?=
 =?us-ascii?Q?ZEMK87ZguWvw1q2adItWHt7L22HKTuh577lLrfa2DUM8v9NyU/ZkZs7weaf9?=
 =?us-ascii?Q?NPWljJNqu9xfAOjkN+gSP6fwa4sqJbo97uAhrVYIQLCOMHUShAjOSfQeL7Im?=
 =?us-ascii?Q?UVxbeLz0wfKhn6AsZ+sgtIJZxtvA94riB5vZyxEttRcdHWzkgPlMLgLVX7c0?=
 =?us-ascii?Q?TcYUdQIXY+QrQZ6vTgYFm543mFz58sToaUsIpYUpk5tZvGTEqcCS9Am75VO7?=
 =?us-ascii?Q?KiBz/Hi3vGtOLBHxU9rxGp8dyLRE7OKa3pudbpdhakUM697R0hqGVXtzhIg5?=
 =?us-ascii?Q?LrrDMOyl9a2IVepf9CxJSOMAxNX3K+s3e8CUjOVvbXXJQo5RTMVJXT1vMjAL?=
 =?us-ascii?Q?NXMVSSgHZUNNqMERenL2ijLTHgGbXLV+s05r3bRWKwEsuXOC179+abHGugb8?=
 =?us-ascii?Q?oKXG+E3RODcNaNobe2clTGBiU18Tcoq26usvvVFR6sw7u60TCBEJIWraHbE8?=
 =?us-ascii?Q?LbIdakQKcAq31qOTK87v3w3TVZxPfTWF8/CgdAZO6B3liF2R6snlwsViW3Nv?=
 =?us-ascii?Q?r0XrvywvcjoTE/yhnGc7oFVqtXUgn2N86siyAZeJMYaPnksZ+ryYR5NuIYog?=
 =?us-ascii?Q?zu4GCS0YeD/pL3U/3avcVqHetmdKAIAY1E7PX2jE9pP/vGiLWK+gMOc4QexG?=
 =?us-ascii?Q?cTcS/S9GrsFqrA+Kh+dY/H6djUqwt6PZnXpeKP5BYsldYeFc75Byca2eEeH4?=
 =?us-ascii?Q?LWsEtihhHt7MV/UxKYzxoFMAXrVXfTE2mZoFYEAG9MiHN/klIyG2MQrM0eqc?=
 =?us-ascii?Q?r5ABqGs0l08abB/5lzRH1QzYKORQzrLwzxPPZ8zXLmvI+tWMaMfE/edOuf2P?=
 =?us-ascii?Q?em/BTgiLYVyqT8luBjhF1BMjZTHFDszoos5cGTmTuogl8OII38aOfGHpEWT0?=
 =?us-ascii?Q?Y2nOLp54FKyrRynkpUYOexh67A7kbZYjzjHC3SokFMQhIHhTjx6vyGn5fpPb?=
 =?us-ascii?Q?nRseGz7t9G7XRvhxEXcKp9ciN+SeWncD68sA9/xgONaYEnO9ItbFeueKpiiF?=
 =?us-ascii?Q?L5eDv1701AFTRpFIUP8M2NYUhM4mtq3EjkWHVZWw9Mph8T12z2lThZDAwHJW?=
 =?us-ascii?Q?CYO4x1y3XsSCPwDdBD5JeHNY0/ti?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/HmoTH6xUAB7uHlLFAkcZYZ/LTE8fDuXnY08ES2XBhCNTo2jduCcBVbBA/CP?=
 =?us-ascii?Q?0tz8yQ+Q7/j85nFkh2wI/clBAousSpzUL24jCVGk7CQQ4K6PTZ/2/45xrFnu?=
 =?us-ascii?Q?/MuBkaRcDoJ7OKKOF9mbHn/0He9DzkPXMXEB1gOFkWN0Hq7xmA9nUg0Zl3EO?=
 =?us-ascii?Q?pTcjJUWUqy1CoSTTs803bO1La8K9HClLaOdf3cAvjUiXNPwaeO7+nuwvtwy6?=
 =?us-ascii?Q?MOZqP48tNGjC+Fz10gM+JLZaglv9ILGnbIiw0jxXX6T3KrkKuxPpW+KKhXVx?=
 =?us-ascii?Q?jRe4JBJwm5olR7t9bB58G+0lYvoS6P35IKVT5hYL3TdRcQcbayT1Mt/EWsAM?=
 =?us-ascii?Q?lZCqCMOUjDfK+qxTJnkKvuONx9oA6vR24vS6Ae5aOMugJi4uA6Q3S8sQfYHp?=
 =?us-ascii?Q?NvYEQy5vPiC9BhK2UzB2u+Gzxw9QTGLJnDLQ0vm9aeQvmUBv5Bv6ZjU3G0tK?=
 =?us-ascii?Q?lrboi53p1hXvte/oa38JdMv3plsycSfwzoebdzXujKQe2U+dp63QYt3VQniA?=
 =?us-ascii?Q?zPkMyDDdKD4SGpW5SZQNw1uGaRfu1if6z7bZgj2tWYPoqebgTPj2ImxTB6Q5?=
 =?us-ascii?Q?v9f1NlI6I+LIoHxEWrkgTUdZcJRN7o0b6t6uLpSYXiDbHYVQC0qTHTVbIPnw?=
 =?us-ascii?Q?xh7djZtk+WjxHEOIER6uvJO2uUlKex0WVN5fSrAPQ8256VECqLRkP1iX7B1W?=
 =?us-ascii?Q?GhYvOO/CPOfu7JWzj3sIex2wpL6Qaeg2LGAzEh1eqnpFwdRmt7M+4ti7vBso?=
 =?us-ascii?Q?TUirbaDVIur3c1bduOgXtqOPNiKXL1SJtXLGaphTnV9aAtqBT0p5o4VLzCtf?=
 =?us-ascii?Q?CU1bKm0BUpTgpsiPp7qQ7Fkov0dvIViBCXUrxgiYIfiPjRKhFzAJOHgLQ8S1?=
 =?us-ascii?Q?C/ImNkkkUkh73r89Jng46uNGh/1FFXmORvCCj85bgLdaO8CNV8Giq8u8KIPJ?=
 =?us-ascii?Q?678HeA/AzJOpe5lwGnY0gohmyrtUsmnMkkwzNf0hMKfqnxZkBY8VdeHLJSsZ?=
 =?us-ascii?Q?ktjISN/p88dpV+4nM2KBl2g4MQerZtaPjdLdkayYEupGjkpWHof/pnNYRPzr?=
 =?us-ascii?Q?ElYPaPWrRrhmVcU/YhqJUAfbJSsxKeUBjeQsYVI72Sk9z/Las7pzjsX1BgJK?=
 =?us-ascii?Q?gSrvSo5r0XEihUIHYL74Jocwv75phRPcNzOZmeOWdrP2Q8FNwVNQ3jhcML+Q?=
 =?us-ascii?Q?7Hdjn4jY0nhqHpfevtL8njfbdBOxZfrVaads1+Ta+iSDEBLSqEtiqdIQvGHy?=
 =?us-ascii?Q?8yV4hVM1IUB+0um26SW9Nolsq93ZxyHzAKSkofUDs4YbXkS2WiOJTAPRDjUA?=
 =?us-ascii?Q?uUzKZiBy2thEjff36yob+CK0422CXN6PsUisFymZ/BhSWaFQnxCbDAXiHYtl?=
 =?us-ascii?Q?Czr3tYIhxnaMltY+qTJR3Cnb9Ztap/ejOy2IwIjOgV4MBPScSA06IlTInBJp?=
 =?us-ascii?Q?L5HQ/SxLuY6x5ZZCCRJF4nO7qlbvCmZ1nZs/FvnVcipEnnj1K6UFOJHeg6+M?=
 =?us-ascii?Q?YrePANxY4fA+dKcByvTG5TrBmV/TEkj5Z4wLgwfHpMzWiJBcCl7dTdiLNItF?=
 =?us-ascii?Q?yTczi6+WclK/M1zK0qRpWZ1lq55IePbO/k+5tLV8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1e07220-d560-4c6c-3802-08dd68076449
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 23:31:51.4270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3omBiLZ0XAwQybADg3IkHBUifDzPHn1NoPzfZiVYAIXeQ43Kb9f4CF524M2Xyrgf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7972

On Thu, Mar 20, 2025 at 03:23:15PM -0700, Nicolin Chen wrote:

> > +		attach = xa_load(&igroup->pasid_attach, IOMMU_NO_PASID);
> > +		if (attach && attach->hwpt && !attach->hwpt->pasid_compat)
> > +			return -EINVAL;
> 
> Should we also make sure that RID hwpt is attached before storing
> any PASID hwpt to a !IOMMU_NO_PASID slot in igroup->pasid_attach?

AFAIK, no.. If a driver cannot support the combination of blocked on
RID and a paging on PASID then it should fail the attach.

smmuv3 has support for this so, and I'd expect the same of other
drivers.

Jason
