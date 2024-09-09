Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367C213DDA3
	for <iommu@lists.linux.dev>; Mon,  9 Sep 2024 15:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725896373; cv=fail; b=p8hJZZbWxGWfhu70Rbo6zKa4hIqaVBkuOXJ8Dh16K5JHa9FUOBWKHeGpGDw8oHlMfgZhHj4hSX02/GVay7maGlAZfMq6akrEd4Ech0vfO51Dp3UtFKy1AY7I2icaahh9akcLVm+8VDcLMTafa0domCiJYdZqj3W/ymy0sgP94PY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725896373; c=relaxed/simple;
	bh=uJSgc+HbjGxoxqP8LcTFnfPBfCzmxFHXrQbAJRIxUcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PqEvab7Hnn/XMIcL1R/HkFKOiCpGYRAdujmoaBr92ypyy0SbYQ7GOcC4ABcC1d72vkIZfa6+JZI8RZ5reX3k0MnxStiqEnbm5uPRbNESlx4/Z4ZDYamM30LEXOYcQNz2FjNaem5W99JeYFKMh537WtPyoEmRsiCJPoEG1YP/4rs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WEUoz46D; arc=fail smtp.client-ip=40.107.94.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WEUoz46D"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SGyP12otlESxGZpPDRWLbLu8hLW279rpMRXg4onvYiwZ3GRoihpV2u52B1CN7b4WH9XGZsHARPLMQRu9CwxEabO7bIdR8pYV4z/kuBqbNO6IevECt5ZOIDFAsNuAGqlRv4PtJ7/MSXRd2fE47XZRKVgdcX8DHcPrbYclvgjDQ51NKthQpjKueKm6rJ5GWvygxR+8boE5t8oQeN6kUzckLX4vTcZX+duqv9IG9/9zu/EvLLjUC+NEkIwZNh8wJD/KfdY7tzHvuv64Zjple8YYZ5ttzFDhTuQUwxWR2PltlC5q/DHARWvlxVGgQ0XEEzMMyhNtckZcjqrGT/z2Zk9ysQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+glMV2PM1lYAbMNVrUt7l1d3HY1xP7qB6ixQzvrnsNo=;
 b=PK4m1W3A8vGfJncpDzg2fM23mHZUjc0hvqimU+7JEkCu/vf+UVKCYtG9UtszzfbU5PqXSXmkj7dZCE5ulWFPoXsjO76EhQ6u8U/tIJaf4z5x6jkgKtYRTHxeOpgZVClxhmNlB5d7kONHNmf+GfdaKclJhd3YTLgJ3vC2GUI7Za4q0OpBUBAEtBdg9149b1YIJGp/UuZXY6dYtTo2pJuGT5UmUI6wnBO/6cLpp5m+o1i4iOuMtzolS6MY01QeEtHv1aBMpJ/c09LddBqecNH/2g8TQFsvApWtWvifsNWON6SWhFzsyB1BnR/8vc/O3p9Kj6XLqakd+11AqfLpRW21vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+glMV2PM1lYAbMNVrUt7l1d3HY1xP7qB6ixQzvrnsNo=;
 b=WEUoz46Dip2EbZoL4qvQWFZHdntaklBWLR9nA9CNmkuWUVKhOCBp0jc8h+J44Qdkgl0Hy4MeYg80VfV4JYqkjLEwSTFzGf0Oaiallbn3/my45PYYmQBCJSKqwnRcA/zPX7CsrV0FyLsoiatYbcogKUkA4mokiK/4QGl7Xrj+oCK89j9Je2tTzo9a6iWEFahHoYl8wrkk1EtKF7XyLaio6VY368enDCk3MZChR0k+B2fGAj7V7zN+1+s603EMXil04mCLqGORHUK4vFGhnBrS3Fe9guIFauVhLF73pk4YjC1Qja7FJNT2Dw78BtFprAgFzlaTd+8hJ7eMQZ51S0dn3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by PH8PR12MB7182.namprd12.prod.outlook.com (2603:10b6:510:229::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17; Mon, 9 Sep
 2024 15:39:26 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7918.024; Mon, 9 Sep 2024
 15:39:26 +0000
Date: Mon, 9 Sep 2024 12:39:25 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Baolu Lu <baolu.lu@linux.intel.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Vasant Hegde <vasant.hegde@amd.com>, linux-doc@vger.kernel.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH] iommu/amd: Add kernel parameters to limit V1 page-sizes
Message-ID: <20240909153925.GA189374@nvidia.com>
References: <20240905072240.253313-1-joro@8bytes.org>
 <45a3ae40-6e59-43b4-ae57-d159bd2b54df@linux.intel.com>
 <Ztle72HfrjBjlJGa@8bytes.org>
 <20240905120531.GD1358970@nvidia.com>
 <ZtnKsf71piBohHt_@8bytes.org>
 <20240905175206.GX1358970@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905175206.GX1358970@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0427.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::12) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|PH8PR12MB7182:EE_
X-MS-Office365-Filtering-Correlation-Id: 59de6cb9-b4e2-461d-9587-08dcd0e595fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4YSaYoo05YM1vTJZYi01hCFyhiI5cKdZClfLO3ICm4EWsBkyW5dLgeWxBL94?=
 =?us-ascii?Q?nKCowQ4zwC4iBxsPXaYLLbdynLncWK6/MLaGbB6fQVf8LdQaUddY0/jPjacg?=
 =?us-ascii?Q?dbH6u+YWhvqD32hQsZmzoxH7FIu5quDTHL4UMy7vUSr2ISmsatht1zfpOdjJ?=
 =?us-ascii?Q?P2Bu0lK2NY7Eg/cOC2FpWEqbIV9C4kWCa5w3CJepUFA0ZawwZTug1dVwL2ld?=
 =?us-ascii?Q?EeR7HvoAPIMZzxyuTHYnQa15hRD+vfPCohdJpJghATsBUBjYvVzZGvPxlB3X?=
 =?us-ascii?Q?KPOAOYJLsbLd6Gv0SuGCIkn32XeSWTX5BnDeLV0xMTxQaEh/rXSzQBWnuasW?=
 =?us-ascii?Q?bhwpUS1O6uyP4aHzCqKCBVIJstu/SrmFGNCWUC4Xtqz5x4KxLlh/2NXO5R5S?=
 =?us-ascii?Q?QGzthqHxJUbma1zaW7G8de9IsQ8Ura6KsbOqUvgN23DJJHVXjdlgZ3bECuUr?=
 =?us-ascii?Q?QMu1FXRKZIs6qD+Mf8vrt1XmmCTJeyIukDH4dpjuk+tz8heUa5TXpIQnTl8v?=
 =?us-ascii?Q?jEq9Zk55r1GPUKk5xD92POzHmaDK6BAECwOzPK3vBcrd1glzISSZnHx/eSHz?=
 =?us-ascii?Q?NTEAGRtyIQXL6NJhs6JWJLptPQmhmTO2w5igGKut9RZRsvX1tOGVmxhfFFI+?=
 =?us-ascii?Q?lajaIz7ElV8qhME/HF0nQNdlXRe4/31w3ZqD7uKNwLFCNLXopjm8bS3Zrcq9?=
 =?us-ascii?Q?P1fKTK7x/pzWOtqMuC9PDPWNVGm/Ln7I220h4Nw7JsAPdtHjVXbQUIBIjSl2?=
 =?us-ascii?Q?ghkRxDpd7/clGmGmFh1tg2YUxmSleK/xfBlxeC8KDPj7Ag8DqO0sQGA9GPnr?=
 =?us-ascii?Q?+waoY9lCH6cuYozWJQxREwoLnnIN0Tl0Nz0s+goy0YjXnSxLoMXehGU+z9pq?=
 =?us-ascii?Q?rdDZd5y8/fHFZjkKqj9CR/8hQp1/lewVSGPPcXQACHxUrNguApQIRKYBZia9?=
 =?us-ascii?Q?2z/qlTP9SEHmN/PoI+p8zg/DoUPNHNwrwqtGpDR3MZmeQM0uXPBWQCId7PQH?=
 =?us-ascii?Q?yrxX8hvTPbCJ0G93YaCP9V1wz5d5NPvXMJtO3g3/zhaiwVG8Or2qcU8WMLWu?=
 =?us-ascii?Q?U469CBpBquOYa+xNYeM2wwi2/j2tX3HGCB9xRv+IWSVQt7G1JgR0ohNM2HD0?=
 =?us-ascii?Q?pYrAFCBuglwhUqTHfqqOoYPOuDDpDkd4Rh0R+zwWvSxZlAOPp0Xe0AwBIsBf?=
 =?us-ascii?Q?pOj6Wjyev0vItLW0VRQmH/uQPozfNosxfZHedYvPgACv+xr+Mht7oW/+yrN0?=
 =?us-ascii?Q?5IhN5Nr81NqveaWW0qok/OutubhSSp8AQ6odBy68w8BGgIaSeN7AWxTz2toH?=
 =?us-ascii?Q?4QgiqKNG2yp1Q4x4aC9Fq98xZOQsRsDbhGmjqKDpGnM91A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bgyWccommztdZwGYabatiY+zmjGmcyjxNiX3ZNiK03Q/cTGstp8iWPbAn7Q4?=
 =?us-ascii?Q?Re6VnCiCcWIUcLJt5ip9lKU2sbsgMJS9OkaNxpjvKFBudDz07UgsKuKa5PA9?=
 =?us-ascii?Q?xMQ1hCBS4O9BoPsX7K8Cj9wYGjAhQHybcZ6Spo4q2sOEraM0RZwVoLdJ4FEw?=
 =?us-ascii?Q?RMJGnEpAXND0tKyLIR19EUMuG2rmSr5emE/CcVXLuLQT/8yzeLB3RsrE8xHV?=
 =?us-ascii?Q?bwV0HVeukCXX6hryS9HH7zXP7B6FIsABPtZfjew2ySphzb8p1IiM8iUK/Z7m?=
 =?us-ascii?Q?v4JJyqdK3bcvRgYyJINdhJ9jITFpK2tDTIHgFmdinBnZOSxRPYiWxbqeE7Wl?=
 =?us-ascii?Q?HezD+dniveromoJzmqCFPExVHK/a9Wz7PdUb0weHmS/xxYNg5fen+1gApkIU?=
 =?us-ascii?Q?T3Nan8MJE8pZRyziBt7oKSyAa93YeCllWfHQo+7o6c4+YkwVgvuc5Y9rwhIH?=
 =?us-ascii?Q?t03LM+hVTtu5YvdtSjDueff5RIPGME0ySKeP+c3M0f3wAGbiORzURbcyXAUF?=
 =?us-ascii?Q?rUYHWNb8noQvCZ/wfc88RlghEGiY3IlCCjrLs84B4Xw7TbcF5/HmkWLmTgAR?=
 =?us-ascii?Q?ELhPceDNkZ2NiV21lcMASsGwFEYpU+rpFychGkuHJHnKUfLNK/5NgSTxGWdj?=
 =?us-ascii?Q?uwlfk8JRp+QD6LpnOcplcZgR4bshRWgUuDYit9ss+UvP1PUjSWsDptv0zTcn?=
 =?us-ascii?Q?tjneAPpG6JDSFvGem119YcjEjdeCUX3kuHzlyXc7iMRZBVtEEBsQbObJ80Ak?=
 =?us-ascii?Q?Mg6sHeWt/J1TPpdpVhdTz7RKKn0BHunRFAYkworBf1JzL0s/QUByReJB/zDZ?=
 =?us-ascii?Q?MBlLAYPG4uC64amCuV9MMHgIHV2aTg7+zv0tyuLjHUaQBICnROpl3eyKFRZi?=
 =?us-ascii?Q?P5BVzYjaD4NeXxjv2vYdZNfKueZLl7rQmDdcJolDHrgkn9nQ+sdcUaSKmp7s?=
 =?us-ascii?Q?F8/bqgzK95FhT3OxpCBnDlOi4LcMCgGBmqjTwbahuqWyF2Q3xTtDvTQp7fD1?=
 =?us-ascii?Q?5/XRjf8YX9mox104Hs4ArPhP0nsl9W6WDrBGYrxlS7sdKUGNTYetE0v3GQ5p?=
 =?us-ascii?Q?x31RRh8vkCLKk2AC0maTbae/QILvoRdu48WHM3jWUvMSAz3DGaO20wleUgAM?=
 =?us-ascii?Q?4KBo4/XaY/9rmmew/SAYvQGKNhsxeAlTFM+dvF0scihgF5iLGM9qNEoRVH8r?=
 =?us-ascii?Q?kMEnfJIFnKHZ/3ieEzWqfdxxHg+iOMNCxGSpD9ONd8BuZqMvy/Vpu9bMsbAb?=
 =?us-ascii?Q?OjGATokg1efm2SBPdaPRf6dkM9ITneQqRP5Ib6HwhTM7+vuchaFAfZu34b5v?=
 =?us-ascii?Q?+kyi15pYL58gsTTkC9y01/x/iOGaNTu85Bt20dWeUoMjGZngkTfrXDUWeyXf?=
 =?us-ascii?Q?RJdqu3Q1yN1qr7u5KdD+b6u3O4m1pMaSGrN93idEj02wtCNC71nNAN5vwRU/?=
 =?us-ascii?Q?FoNUgi21c/ozvSpeMzAF+dLgQwC5c1pO7zw3nLXN85EJO+MfKCdJqhQ5ezC1?=
 =?us-ascii?Q?sYWCpjAQsuVGwJD0gk5W+nufSRvLVT5kB+4zq/PXIh9CeL3eZMI8au2X975F?=
 =?us-ascii?Q?mdUYT5zvJxFpm0psoKDeB+kTJTkgdV3q8Tp1pDSu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59de6cb9-b4e2-461d-9587-08dcd0e595fb
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 15:39:26.3746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: apHbbPHZdZEVWKjxoGZlIuOLlodXQqPbKO5oi2VgkahIntOrC/lfDqfPdLCdUx1L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7182

On Thu, Sep 05, 2024 at 02:52:06PM -0300, Jason Gunthorpe wrote:
> On Thu, Sep 05, 2024 at 05:13:53PM +0200, Joerg Roedel wrote:
> > On Thu, Sep 05, 2024 at 09:05:31AM -0300, Jason Gunthorpe wrote:
> > > On Thu, Sep 05, 2024 at 09:34:07AM +0200, Joerg Roedel wrote:
> > > > On Thu, Sep 05, 2024 at 03:31:08PM +0800, Baolu Lu wrote:
> > > > > "iommu.nohugepages=1"?
> > > > 
> > > > Generally yes, but that requires to touch all drivers to make the
> > > > behavior consistent. We can start this effort on-top of this change, if
> > > > desired.
> > > 
> > > Let's at least use the same keyword that already exists though??
> > 
> > You mean amd_iommu=sp_off? I am not in favour of that, in the Linux
> > world the term 'hugepage' is more common than 'superpage'. So I
> > would avoid spreading the use of the later. We can extend that later to
> > the iommu.nohugepages parameter suggested by Baolu.
> 
> I see, okay, let me check with some people if the mlx5 part is Ok

Apparently we have cases that rely on some other single page sizes (eg
like 64G or something), a bitmap would probably be better. There was an
ask that this apply to Intel as well.

So, I think this would be better to start as a generic iommu parameter
with a bitmap, and do the pagesize fixing in the core code, after
domains are allocated, instead of in the AMD driver.

Jason
