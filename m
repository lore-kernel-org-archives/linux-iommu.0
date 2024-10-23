Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD2F1FEFDD
	for <iommu@lists.linux.dev>; Wed, 23 Oct 2024 14:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729694704; cv=fail; b=b/2H0Dj7wOHNq7aei3CgjkE6MgOBsmtSrgsHH+p2mzO3UAMbiO3DRPwsOd9aIgpkKtwzQMjV0kyqixwY/tOYdVA7cp6KNRC7JjNmEUpzM+0h/3PK/tmEITzof6qrQvFQHrHJzZT9VuIPBbtoenYgVUeceUyViskHKPhoqTwqaEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729694704; c=relaxed/simple;
	bh=5O0MXu4OMC28wbOhFQEpiWFChMEeF9b6eTK5HwmeTvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=vAZUHCupTvs9GkTcrVRemwDzvpSiIrULbOWAdRem9dPkL8T4U6e0NhlYjk4n4Jf9mGRWnqMDghHPEj3C6JWwaoBF0BZtqxuDZbsu+Xj/FFHZ8VlAZw5jp5jt70zvMknrsrHPpIQ3J9wMSXt4vPQ/bHvx6SXoIB2AL4AWPrjF4bI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SZGFE8IV; arc=fail smtp.client-ip=40.107.93.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SZGFE8IV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e/ONUzryLg6YtTYNW7tc7rUUIOecYSIVM2z3zm6bcDuugmV1s7fqD+b2uTZcWutoyb/nH0SQ5MyQaRxzJZx4cYKSuyDlv8s3Hr9aE2Kzf1XwVTu95gUsvQevoYyNv3jTxDILhxvGYobf3ypj2yDfQHnWWIH+QuI/A96w/0MmPrEt5iJIjyzOHISdylifOvskg/OA+gx53irATerpC4GKe+55r9c8lnHLZLsRumm0QmljlcoOQckzftDN5TNZyxS8+QvMGGO6AZ9RRR2tYOEsSdlPU6RarZxqp+xZxsV9+S+1fGAkpbwZj95MkU0SBtGZRI2zdeDAUaqLlX0wCv6mzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qiV9AZhmTc9Sa5EUoDrV00W5TtYer3xQ4NFuwINFNZ0=;
 b=BOaWAy1Dhu/jLUvRBQU1TtClogxjaVSNXeu4Eztt7AM8v1loUmIMD2CBx9vNz40+FmH+G/B/nYa+ECCO4HctlD9XLen0/hxVJOW7pQaOrEY5SCB5VRdIMlb207Sd5E9lxGYCuJBMbVNjNaFNf6f/tF3S35c77nApAxOlLlSvAhVo3lBNu6kogx54J3kTPk7Crr06TSUfrCRl+lXwvbSNlrP1/5g2QXnmgyUNvcPII7RkjnYJLWf1A33gFpD+z/WLTRVJ+0rt/HVUL9quqaA08tR3UfYmXi7KGcBzxqDLjCQruOyamuRaHhIWTC+GEGk7R9Esuvyhrt550dFUSNQhEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qiV9AZhmTc9Sa5EUoDrV00W5TtYer3xQ4NFuwINFNZ0=;
 b=SZGFE8IVyTgG/r6feEWeyabUUoB8nO7ZbCF1id73Pk0tJONiBSd4JvpLfDTnvuhG0i8mNxl6kfSvqpqgVJi5mgjWnE0Tl8B8n1uApL9C2/IvofXuK8R3+xRfFLpwDaQHyormMxsiHVGNjl/rbekHVDqx08MjL8NQwaL2sO2+dzlJPTdHUNYBOqSey1av9FhXWc/1YNlqB23IqhOKilQFCxoKZ/Il7LkycTqG0qjN/VOXgtZ94BiiyrpRMgzSl+VAWqnjt+mAi457Hlza3R553N7rgWf48x2w0QZoE56+fClpBHnPNTWWRvL7lP6QyY6FNt0iRHD0AYTFHtE9L0KVhQ==
Received: from PH0PR12MB8052.namprd12.prod.outlook.com (2603:10b6:510:28b::18)
 by DS0PR12MB7780.namprd12.prod.outlook.com (2603:10b6:8:152::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Wed, 23 Oct
 2024 14:44:53 +0000
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH0PR12MB8052.namprd12.prod.outlook.com (2603:10b6:510:28b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Wed, 23 Oct
 2024 14:44:51 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8069.027; Wed, 23 Oct 2024
 14:44:51 +0000
Date: Wed, 23 Oct 2024 11:44:49 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
	joro@8bytes.org, will@kernel.org, suravee.suthikulpanit@amd.com,
	yi.l.liu@intel.com, baolu.lu@linux.intel.com, kevin.tian@intel.com,
	jacob.pan@linux.microsoft.com
Subject: Re: [PATCH v4 02/12] iommu: Introduce
 iommu_paging_domain_alloc_flags()
Message-ID: <20241023144449.GH864191@nvidia.com>
References: <20241023104207.5894-1-vasant.hegde@amd.com>
 <20241023104207.5894-3-vasant.hegde@amd.com>
 <c683ddc1-981e-498b-be27-32d887f95c1c@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c683ddc1-981e-498b-be27-32d887f95c1c@arm.com>
X-ClientProxiedBy: BL1PR13CA0067.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::12) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic:
	CH3PR12MB8659:EE_|PH0PR12MB8052:EE_|DS0PR12MB7780:EE_
X-MS-Office365-Filtering-Correlation-Id: fec455c8-ba40-405a-c470-08dcf3713fda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?e/oiBdo6s3U9g+i+BsERffhdd8W9tAJgOhHxX7bNaQ8FtC04NfZxWE5jwFc0?=
 =?us-ascii?Q?TAGvcJD0J7Jgq8eQY10DzLF+YmN1Uo3y8ncwjcCj7zS3sFQ1G4J5kq8AFGgn?=
 =?us-ascii?Q?QAhgTLS6lAunSJh5/wqJfGA+4d7am5DuJ4B1xbgpYd6am/9fLEL3ieR+FBAL?=
 =?us-ascii?Q?S7rQjjauRe6/4Uq4h3zfhwQmbUGea0pzCX30WGTZ1UDQXQWsmEeTmMklf3jR?=
 =?us-ascii?Q?tb5wyrwKVlfS/ny7tuyikUuhT3G+FLABXh5YQFnaLSEz/cI5MB9Yw+F8ec4T?=
 =?us-ascii?Q?RFC2erljSj5HW6q6Un17prPBShbEfIHEJovp+eOXBb+yPYrPWmvgRMz2KOkO?=
 =?us-ascii?Q?t06T+PavY1yngYGbw6yTzPKYul3PiILA8kXchU2Qh/KNVYzS5kGAMfc917L8?=
 =?us-ascii?Q?u5j26drunaPX9lfKNJR92VmFiGWpRQpnY1aMeXOwfli4ZzuIfoVNjvqr/igu?=
 =?us-ascii?Q?nugKfCwjeFmF1zyOYPKzCskJ80cpCZJP2PaEfDSlKfz36GbepKPvkRwMmb3x?=
 =?us-ascii?Q?BjyMT6nysm2GcAmbWu6YVo26wq9KDG7VOVLps6pg6F1bMRJDORUJzvFO6o6u?=
 =?us-ascii?Q?QbozHke6g0Z+L9UPgGo2iLRQ9tLmreLKgj2Nd9ivwWNIereIzLQev7fKDbE2?=
 =?us-ascii?Q?UzaiCL2eGIe7AB+H5EU+wmxcCraZ5CtFnjnIMsKBMVOZSZmUO+QyKFREJEQC?=
 =?us-ascii?Q?NdvhHEScqsq5p9n2BN9IT6WiNGjCgVi4TolQt8c1UnxalbYyLies3XwjqBAc?=
 =?us-ascii?Q?ItZm+ledpo2KNcTcAlDeiRQ2e6JXBA7wSH8H7BC59IPuB2m8ZoKYEg+jlhM6?=
 =?us-ascii?Q?SRaXSg9dQQ5Uzm0t5hFdCDjB6NWljxsvJrqJNCvMlYEOww/1RBu95ap4rAD4?=
 =?us-ascii?Q?1tRkJkQZDOO9MmgZElqz9B4hd4U4uksZkeMR9nfm3aJtXpUnlsqEp4iDfXpI?=
 =?us-ascii?Q?zt6Ld+nqfy3Aq3e+37Ful04bAaa+n8bbU+EVvlD5Nwv32OPRjvw6sbkoqVoI?=
 =?us-ascii?Q?pF0IlpisYQ4uwxMvzdkOUBe8R277fLeh38W8pE1eeujlecIjq5tiggiDxINQ?=
 =?us-ascii?Q?E54EMm9I0u2rc88DJU/vcp34imgQOGP7XQfY+nvkzmrp2evoTXcskCttG3JG?=
 =?us-ascii?Q?o+ofNT15itsdFqYC8CAMlSU5+pYcNqLk5MLDfB+4+NgxUIkBUfWQjQT3swXq?=
 =?us-ascii?Q?SCCIpMrjQ+UgMJBmY/o78ei0Illp19S6pcLCvLTrvYDtCWkHXyNNZY6hvU3u?=
 =?us-ascii?Q?//TJ1Uppj5r3r4NjBx9CUUl4/9uoDjduM0j2pu11btpjXHzAOJP/zJG1IGRL?=
 =?us-ascii?Q?bwE/mrO8/QFfQVgq/lfDg+kz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB8052.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CJr69I5fxOIoRemmO2PIzOicXeqNAjbpASLqx14q8ifwSJiTZkB6ZpuMD1xD?=
 =?us-ascii?Q?yj8Fxw5Nfqj9htENdKNGZAfM0EBE5/p7r1cGcC0zR5z8Ro8J8wRL8u7V8cVA?=
 =?us-ascii?Q?cLkDweBsBr9JsLUs6usIMo6OnxaZ5m2x2q5GkKvzn3C7Tg7vZylokBakl3y4?=
 =?us-ascii?Q?VHoPPXdGUYJvPp5ecZzm9x604Sin3+bRLLeBzKbzJjnJ5nO8+eooxzxUv6Xv?=
 =?us-ascii?Q?+7tiN7pJxalrkhBrA8rC/FjxyG0kPy6BAku/xdWcz+fOBhCcV039WS8pl7u8?=
 =?us-ascii?Q?ZnjLUHG7tTvA8pRBNq3BgzQT9iK62oC2S+LkHVZKTotAdQkkqCaDjQN9KP0x?=
 =?us-ascii?Q?bYAyffIsY99F1U6w3TmzTT4PQN9E7KxJGOMmj3FuoQeuAUJooKUFGzHLi7d+?=
 =?us-ascii?Q?evBLcfzBxDfJ3wDOpIuQ5zhSUJjiDTwS7ac6t8b5/b1aOCRKaEqOAeshjKdT?=
 =?us-ascii?Q?tu+hUL0VYNJsxXSVRM7fpoPkQYr2Eq8FhsIzwfbNjUe7lcHx5FsQcXqq0253?=
 =?us-ascii?Q?cB8KAFQeD3Wp6Nsn7nUQHvc9PWSiqct6MYhC8Xg/DHlAw9pd1p4pYGA2XKWv?=
 =?us-ascii?Q?9wxRuJp0RoMVu6YXE3PmsYGO1U7NPosmChj1wA3M+d+Oq0lkusd9pbKkOQ5j?=
 =?us-ascii?Q?qGGnQo5CrG+AY21WaVUPDVuNLT8QxlJR5OWS7y4FjqoCYg3EFnUFa5YvFVlX?=
 =?us-ascii?Q?+BoHz5b+uwjCbW6Dlik/z5pO/NrpiINfbvrMTdi8P/KvaUPuPOepPDPIOmms?=
 =?us-ascii?Q?nQ73q1quATotWqX1kwFoLR86iRuOfpqnXGDO0vNT3IpIh31My0ox2/W0idfK?=
 =?us-ascii?Q?CxXORNVYmdtOoEjzqqHyfZ1WaazIkdzMywTi94p/4ebaqEfCP5mPa/DjiuGA?=
 =?us-ascii?Q?YZJrALH4DepzfyoBAWxFNh2fQ3ubCeifml5avDipBAm0fHuauzpxTNawI8Vl?=
 =?us-ascii?Q?DnwPO7amFiDm6aosZp5vwFZZ6vOWTz+8SGzcFFCmjeRtqfxkQp58hTZT7mZQ?=
 =?us-ascii?Q?+yOem0OnONVcHJCXhn/6nlVJ7z/DvzYe0jKSGFzODaHuiHUh5yxOO3zlAI4C?=
 =?us-ascii?Q?TlKCM0hyQ5uM0Mboa4TVxZdcqEql1lM9TXSuUhw3mYaQjeNmgwt07JV6SNsx?=
 =?us-ascii?Q?QotPL9hY2tgQP8tKKjamzJtEdkXIOddKGc2gZuPgnUeKJepzLjAc7y1SKbt+?=
 =?us-ascii?Q?4wTBn5jYA35RRDZG9tsVF1Ulgn6pRrlE30suMkW+hVHgdLKdjx4Lo9n4RmVg?=
 =?us-ascii?Q?pWeTr6XwSMP9NGMs7JYptGGkistYPFVFEUURw3TUiNGwKY+QyyMakEC5Cqd/?=
 =?us-ascii?Q?MLHWYwoG5xSuHL/szxz5EENv7axjhKPyXkPU0T7vrPRtIt0TNNIeDzGzLgJJ?=
 =?us-ascii?Q?nuVZLjs8Iam7eLjeKodlF2Nrv7QSD26sdQIRCnaQcFYkpiOWLwOg3hxdJEWO?=
 =?us-ascii?Q?x6tF2C9Zf4d3lueM98knt/eGsoEvQfwnfXgi6pD1ew8W0sbBQv/xjFNXirQ3?=
 =?us-ascii?Q?57gzjSphv+nAtJLe1zWcf/NHa7XfsqmpJ+K/NjWtw6qxFd86FRWypecJLsJc?=
 =?us-ascii?Q?Gd86Se0m3uqAMOc6Rq5pndt8o29m3THTp99r/Z5Y?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fec455c8-ba40-405a-c470-08dcf3713fda
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 14:44:50.9921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FSWmGQrnrns0EsOGnM/XIv7CC5GeBORL87p1qyajEjP/6ThtnTj1J4AGw85JYsIr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7780

On Wed, Oct 23, 2024 at 03:26:48PM +0100, Robin Murphy wrote:
> On 2024-10-23 11:41 am, Vasant Hegde wrote:
> > From: Jason Gunthorpe <jgg@ziepe.ca>
> > 
> > Currently drivers calls iommu_paging_domain_alloc(dev) to get an
> > UNMANAGED domain. This is not sufficient to support PASID with
> > UNMANAGED domain as some HW like AMD requires certain page table type
> > to support PASIDs.
> > 
> > Also the domain_alloc_paging op only passes device as param for domain
> > allocation. This is not sufficient for AMD driver to decide the right
> > page table.
> > 
> > Instead of extending ops->domain_alloc_paging() it was decided to
> > enhance ops->domain_alloc_user() so that caller can pass various
> > additional flags.
> 
> Wait, what? So iommu_paging_domain_alloc_flags() opaquely may or may not
> actually allocate a regular paging domain or a user domain 

There is no such thing as a "user domain".

> depending on the flags? But then per patch #3 we allocate default
> domains - the most kernel-owned of all - as *user* domains,

We are going to rename domain_alloc_user() once this lands and the
dust settled, it's purpose has now expanded. I'm going to try to do it
for rc7 when all the branches are together.

> return an unfinished non-user domain, in spite of the explicitly documented
> behaviour:

> | Unlike @domain_alloc, it is called only by IOMMUFD and
> | must fully initialize the new domain before return.
> 
> ???

That remark about "called only by iommufd" should be removed in this
series.

> This is insane. Please implement it in manner which is not insane.

There are more steps, calm down.

Jason
