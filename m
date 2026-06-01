Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012019.outbound.protection.outlook.com [40.107.209.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF71A342C8B
	for <iommu@lists.linux.dev>; Mon,  1 Jun 2026 13:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780320964; cv=fail; b=DAIeqrUJwWKyN9+bJqEr5ULutTj865ofphxpPJtHbU7BSe/yGAOw90b6aXO2N4iNcDX42RyDMErPJkNaa19h4E0OyvG7uJHvge8yUInzo7zLRUjf0/A/ttv3o4U5lLcn+aGqEMLHtv5YuGy4lF34wikJOBbTbdoVTg8ES+GUBXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780320964; c=relaxed/simple;
	bh=Pa29zlG9rfsx8prnJ59PXBF+6C6P34/7vc0cHsleP0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IdHTT96fCf0rMXrPEfqv7EyqYlIG5Y2RYgwHSE7mi6TF6g5o7kR52HlGP+FoOWEet4lDlwtXyIsB92QufLFmQHdpHFdCcQSHOGJ3Rg5aBRKIvJ5Fm6rUgacDr9+k/MHKhZZ7Jwux8R6WqnW5Y+ZhDnkLQGxUPObd2mtDwFrlD5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ms33Lmre; arc=fail smtp.client-ip=40.107.209.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ms33Lmre"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tUnnZJJ9jDiB0ZtaOPe6hUox0x6di520JSqKPmcNC0G2CtTWvfrWStTgqBLkws1Cgae/4NZF31gBIrEcBn/LXeY8kYWr23NZdYtujS9Ifqc4gK93EPoVrqXT5gjcufRCRKcfG57J9A9LfVVaNdQi0nPcxO1NiNoN9I1u556iqw4v1HLGRnfuH1/lu4GrJXXEyuGOuoCS5ll2k+UtvR29FkXlGVkVas8JuS0F3Eqxg+4o3f8ZO1/bILVT+RVoyQtzeaTMglk7ES6pXSa+gZtKclQYVhB7IK5kxdCQ795xyOj1AcsTjsQuUZsWxD4AETSUCbJL1L+5MHku9+cdVCotMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pa29zlG9rfsx8prnJ59PXBF+6C6P34/7vc0cHsleP0E=;
 b=fOjkQIe74O82g20wDTL3HY0CdqVFNNtBIvJ5verTAhuy+qDxAxfYCosOTjYE28n02pKMWaOA2rHCFOeIx5jl/D+qDNyQKRHr/MXEs0SI+JEBh20OE0tBky4nPOB8RtP6R+bnKZ7j2KgRms82eKMoXO6IdWHvFn9yyD1eAJWvQvbMU0xF2gjW4+hsf+09TlGf/iZu/azGgZHKESuVTEMLmHgPBa93Sv1KX07iv+1+K2sVNaWQzyDBqMtcKNsZWOFzbADDVpQxt/6F6eul/giYFF9TdpV+J7alqfNRp/bJdqP6Cz8Np0DzZsDVOQQayplSs39ONj5KP5YQVggWji39pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pa29zlG9rfsx8prnJ59PXBF+6C6P34/7vc0cHsleP0E=;
 b=Ms33Lmre79Pd2XFjc8zYOrE3JkRNi8N5FMTXbE832ZRWpMKpT/DNmTFWmhGhhizOEGONXOJ1UMbE9G5S23GnqNBhrXSxWRnxF2QmCzICdzVeXik5XWH4LBR6uaPakbKh2wxNxV9BvZ3O3b392BaRrsd02gNr9d/M/yRFZUi348NP80hHgW2a0YPNLsC94Ot+ueiK3EL7/EHEH+1124N8gv1Z9bFaKjQ1/KUiN6qBqoVFgUMpWgN6JTeNGm6KcPfsj0HADZA16KbmwebtwtIYNSo6iT4PEaFTSVzRlx66MZ6aFPl/CRfjveI5dGnJBfscWoqh/gXhSajwLPmw+Y5Rsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 13:35:53 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0071.011; Mon, 1 Jun 2026
 13:35:53 +0000
Date: Mon, 1 Jun 2026 10:35:52 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
	yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
	vasant.hegde@amd.com, jon.grimm@amd.com, santosh.shukla@amd.com,
	sairaj.arunkodilkar@amd.com, jay.chen@amd.com, wvw@google.com,
	wnliu@google.com, dantuluris@google.com, chriscli@google.com,
	kpsingh@google.com
Subject: Re: [PATCH v2 21/26] iommu/amd: Map kvmfd to shared translate device
 ID for vIOMMU
Message-ID: <20260601133552.GO3195266@nvidia.com>
References: <20260528051738.596013-1-suravee.suthikulpanit@amd.com>
 <20260528051738.596013-22-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528051738.596013-22-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: YT2PR01CA0005.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::10) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS0PR12MB7726:EE_
X-MS-Office365-Filtering-Correlation-Id: 353425d9-3214-4fd5-fabc-08debfe2b3e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|5023799004|11063799006|18002099003|22082099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	dMMgKgSnWkM2x34lM/UQOqfD3PzyV+p1HwQQWz3sDHXX+fDRbuFfHmE7f/gH//kYlBqT3fxywlTYKZrPDAJADZ4vYV8IbEyrwnRZxOGChyyT5rG9+1uXaYzMj27MKLW7VfgDjtSXEEmT/gt6Y3Drcp+su36ykgu9D9MDeYEZWItmxkuq7FposaeGotv+E+gTtKiCFex7ygrRKWjy4Au9mHmCPabf6aoqBUDJTp5EuHsaFeADoHpmSZ6ThaF6PCh9UFcpyXzhIAww2SCQcANvcJLFTsnC1tCCjaxa4mdepZz/oL8oRA/RNMDvwX7GLSIrBaCrhl7GgSxR9g0Sdlj2Q/X9O3jFrswbB+P5MFJu6aTuQ8IgiM3xXq7vGNwBvLpd+zdJGTHB0xIA8GBgyldI+PVNr5DkmechrkfZz/Q0m2ozrRSwcHRB+2gYPLCWR+JtJTO53crmZ1RS6EVgz8QQggLqzPpCg8B3NKgR1U28GHhEBl0SsDsYqcdGSQftesnDbIyv+jFHD0V6Lxo/c9Q7yuUhSDUJFFNgVVrjFpkyNSHRXqbbB2HU4Qzq1zGpABkS/5nfDV2IRv/OacNuVuzG2XerucH+WR/eNNXbuv3kK7JXM/aGW9dRYEBgSDT2M0MU2qokoa6h21cyjY6Vt5BD1TpacNbppjVAXPDggxxxc9yjeYHykbLYyISjm6m/16hp
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(5023799004)(11063799006)(18002099003)(22082099003)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EPMBCDWjm8cFV0yYYfJL36XD4JWTRQflYBuuZJhd/8mTsIsiByQtLqbvG3hb?=
 =?us-ascii?Q?cx7FdckkJJJ2l57J0UkgE9zx2FgtMzIxYKWBuyeFqilGWjVZimZWulHlCyS1?=
 =?us-ascii?Q?75r4tedgKx8QBovWVqgli5SUFb694BaeRUGUeeGJDJp5KAwMN2uKBhw91oRl?=
 =?us-ascii?Q?gRMnoi8P1R6BJC3+daAuSgkvfbGrDoze5P8yYdd1LvOS+DP0QZ1Kg/FZuln8?=
 =?us-ascii?Q?0g5eP+ILlOVm/Zcg2wLKGLg7LdRvqImfL+O78cRMlVqQ9zV27kIsqiezV/km?=
 =?us-ascii?Q?7YLa53pWvdf3yFFcAiV+I/Par23TTGof5QFKXZVm7mUWFn11Nq1dMsmGuR/T?=
 =?us-ascii?Q?YP0E4ij6eJDNs8u8ubYhrFhqN6QLPKpcBIl2Pa/xEDL99I9geefxsSxOmGQB?=
 =?us-ascii?Q?O55lrUR0JRBK/MeNwgLl0FqCMbjMPCgrwoZC/+oqsiLHXChcmik2lMh0yQVb?=
 =?us-ascii?Q?F4Wg2IDISMSPU4Vkvg5mxHd0tzkOMPz6LfkMWNVcsm0rYkrLS7atv2/w32FI?=
 =?us-ascii?Q?JjleAHDhul39J0tqSqa3BC6dvR+aV4IXhsaEEX0nDb3uEesQAq9C9ZpaUyBP?=
 =?us-ascii?Q?qIPAgQ2Pb2mM+VKX673ju1I08BzTgktf7g9bo6Ld6eEs/9FSKrGP9/nqqIiv?=
 =?us-ascii?Q?xNJ/+FFRj4vZ7569PzbgBbhdAC+4CYcDGxXfh7JJ5ioSyl4FC3rBHSO4ogK2?=
 =?us-ascii?Q?uRsOX10CAM+vCJmtO0fYOaP5271lnXDF++V+fX5cai/YgRHmpjs1kdrudj4+?=
 =?us-ascii?Q?FbrcBc3AcCEkyAX2LCWyitK2phkBpRup4+JsRMgAaom6jhBCtGOm6crnEJOg?=
 =?us-ascii?Q?dIOAMkWSJJUkhEiyDliTRdsSxD+8ON6mFc3hQvSdcTbSY+1pAkiw82jIQZ2n?=
 =?us-ascii?Q?o+2+ssUFUXn+XEBhbqon/FS7rozrInmtTdPwNKWpxEkD2xf8RxKxBdbMQmlS?=
 =?us-ascii?Q?ubRvqBK9Z0peX2Gz5udx/rFyfWnNvQYSJi11d1vUK2hS7Ygbq5aPgrpiZMNL?=
 =?us-ascii?Q?Uq4xFni5HI3eoaMng7W3NrMmaE38VMfr332jNcgmGOIFUaw+hj6aiOPLjDkO?=
 =?us-ascii?Q?EBXhJ+yZDLn/9bA34VDbZqqW0ri7EwnPEJaJDobc0BMeZ8f8IdirhBm3cpAS?=
 =?us-ascii?Q?www2+gQJKKxq5SV2nVljOUZPNBRiGb+7LHrPSNDtgXvtqj11abwJTrNM97gB?=
 =?us-ascii?Q?S3/8Hpz+Uchg4t/XaCJvi5ZqTWrTH+9ZwU3jrXzCK/U5OrQfBiDaRKE2ejBa?=
 =?us-ascii?Q?6ao4Yv/fWMlTt72Zgr3DSY+PRwUQtWB9pJ9dcEzic37MdGdgBeTCJuYEAJTi?=
 =?us-ascii?Q?KwLSVCi/jG2GLpZBVXPY7PTEjGHXaQKJP5jteLKpqvH/zYpBhZx2M+leiSkx?=
 =?us-ascii?Q?ung1uBF6NjJQPxzC9fO5R78jcgs/hSj5ddZ/QdxkXKm/o2Utc8jYFXZwcRrI?=
 =?us-ascii?Q?vHkYwo/yIv24//WExytTOcTl4QFOqvKwEhHBHpLQWLrCjg1qJumdWN9zT7Yr?=
 =?us-ascii?Q?jnnIO8X/r2HKI6RFjEE5/pgcELa108Cb8Lxvf6BJhkjHWpS8x0xKqy40nA9C?=
 =?us-ascii?Q?wgaaglGODEHDSTHymSYCfNRsdGwcCS6hjUtzoo6Y4ush0DnvWI6j4rSw6yBW?=
 =?us-ascii?Q?yv8ljkV2GPS2DiSRs5S4WqV76avpIi6NROXPYMNymiNpws/p7OqHlmAbwWH6?=
 =?us-ascii?Q?IPIe8y9vCmWEO2dtnQ0wnnI7NUDbwES4buL5qmhVVP3UlDff?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 353425d9-3214-4fd5-fabc-08debfe2b3e7
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 13:35:53.6742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MYZR+BfOVvAi4p0YuDZORcaHDVvUr5xXYgxQD9Sj+5aHL353irnelXFX7s5nvmNa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7726

On Thu, May 28, 2026 at 05:17:33AM +0000, Suravee Suthikulpanit wrote:
> Add per-PCI-segment kvmfd xarray amd_iommu_kvmfd_trans_entry with
> refcounted so all vIOMMUs for one VM share one translate-device-id and
> GPA->SPA DTE.

What? There should no KVM in the viommu implementation.

I can't understand why you did this.

AFAICT the HW needs some unused devid "TransDevID" for some
purpose. This is pretty sketchy, but OK..

The ID should be affiliated with every nest parent domain, or maybe
every vIOMMU.

It has nothing to do with KVM. You can't assume anything about iommufd
is constructing the viommu based on the KVM.

The only acceptable use of KVM in iommufd land is to get some CPU
specific shared information which this is not doing.

So no to any KVM stuff in this series.

In an AMD system there should be exactly one viommu per kvm per
physical instance anyhow.

Jsaon
