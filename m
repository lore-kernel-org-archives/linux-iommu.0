Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F8A26B080
	for <iommu@lists.linux.dev>; Thu, 13 Feb 2025 15:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739459327; cv=fail; b=c06aQY0qXTg60TuPs+Fb9+TgejSd0ua/YFNzG60s28tNcCuqNyl5HjVPSrL1lSeS/ZJXFdUkroND1zqvaOPOlihHGInWkFIgljZQC1gDx0HTMkGlM4q8lzulOVRNJD7sfEqTPFjvcTsatWfwMIVdbvEq6PgoGC52MMR+8cidmtw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739459327; c=relaxed/simple;
	bh=oVRlS8/gcXd8oQM0k323Q5qrEThSsssueDYFkkTdlGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZMsghqltwSGg/VwtM0+bbm6yV1gtKrkDP8HutJCmxcWnUy+9yN6270LAZKXWDjW+MCKXxGmWAox/eTKP22cEoHu5CSgZR3oZnIMl5uO9H+NV/QQuwz1rDVzb7e1v2m98TuFt/n1+p1ZxM03rAVx54Hp/n2Xibt1rYgS/rFyYtqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mvmfKQLd; arc=fail smtp.client-ip=40.107.93.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mvmfKQLd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cXDLqXmi7oscfrbyKOqy0p/3Vt2lGPPiv+s1waOQXCMIp3wgZ0XfnwIEN3axBmCtx7CQ9azZxOgEEXi3fl115Dti7rkmkBbGeAegyPdyi5IVGxaBWD3F5DPaP/vAh7gyTOWpzYJbz5Xoou1RYjTdCit/bWn/hu75t6jDpG4AVkIDtNN2iZLhLZCUsudn5k/kgNsrV+3ULctVDnG6Z3/BJpN4hM1JOW/BmbTlLiOzWgcQzToEHeFmboo0+XL4Td5kZ1ZbdmYHbciviHvb58OHMKmfZchNB6PdXZP/qgYsPfqCxnOJQCFbu1q7meLFhfwSArKdG/+2LpdkHzGCOppRAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LC10qkSMP8B08Oo4nc2V31W30xaqq8sZqwWBDDKxmBg=;
 b=OTvVm1l9rowTIfQws51fiUogc9Vm+PblTTA6sE5fa/yEb0HrneL8wFp36ECDJ2sKN4FT/yRu4PuQKgXsT9Ogc5NLbgeK4L+RyiIkio24y1++VCHV5lO8E+9gH16p1ypuWL/KC7LGgz1KRKj7v5+L/QbE9/Vyh18Xn5XcBnHh2aG7/LbTnX7cJKF2xgathufwsYNkml8G4gM43V+hVOL0o7X/t7VT2TtYKqBW15JXWQOlt7xhqfHFCKSOWLsrIH//E3E7las9k6pBOFcFAbpJ32vQ6MOZGiKJ0gM/y5T18DL0q4Abi/+V81eowgwN7yvfjVEC3mBB3SO1wlm3w9Y8ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LC10qkSMP8B08Oo4nc2V31W30xaqq8sZqwWBDDKxmBg=;
 b=mvmfKQLdpjqdgfSIOzQPiF6dR+kvYre2oLy8k+QwxXWOUwjDNVfgLEt3C6TdM2faSX1U4HjmBxSyVhYOzvZVz6VnyeLCMAkAjDwfdXXIor+mSg3oHl22nRTmeRUuDYnBnAdfzjNJP48XInWS/5pQnL4zPynzFfrIyCVja5wD6XL5Nw5A4QlK7C0LoicPGsQSNRFUeaeOdPrh0Deok7A9ouqeGsiKuA0+aoTEDjMajV4gMSl7zI7xqE/w6ihIS3nozPiYsykj+GU3QFw5oqW74sfM3NaFHoE9WSlPkotwFydjFr5Pf3n1DLz9u6y5IzdjzTAPx0yqAkGLy8iAvECrFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA1PR12MB6650.namprd12.prod.outlook.com (2603:10b6:208:3a1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Thu, 13 Feb
 2025 15:08:38 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 15:08:37 +0000
Date: Thu, 13 Feb 2025 11:08:36 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: joro@8bytes.org, kevin.tian@intel.com, baolu.lu@linux.intel.com,
	iommu@lists.linux.dev, robin.murphy@arm.com, nicolinc@nvidia.com,
	will@kernel.org
Subject: Re: [PATCH 0/5] Misc iommu_attach_handle enhancements in iommu core
Message-ID: <20250213150836.GC3754072@nvidia.com>
References: <20250212060540.261436-1-yi.l.liu@intel.com>
 <20250212152531.GA3849539@nvidia.com>
 <bc4368b8-1d15-4605-82c0-a4db108fb8ca@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc4368b8-1d15-4605-82c0-a4db108fb8ca@intel.com>
X-ClientProxiedBy: BN7PR02CA0021.namprd02.prod.outlook.com
 (2603:10b6:408:20::34) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA1PR12MB6650:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f8ceaf9-d837-459c-ecf3-08dd4c404ad6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YF1O5bnD2LFxLNxzKogzMNyV7VitUM1/m8jxv2XMIWgcb6/wsRwDzljIsMn5?=
 =?us-ascii?Q?656k420VK5AsFKdQlLF1W0tNa9x8ZIjm6dLbnGyiX8ZLM3fsy7sw3wdRZjth?=
 =?us-ascii?Q?CaAkH58y+N2kRda4/C4XBqybEUPbeHXH6n87mjDi7fk6AbeNEsYfpivXRe/C?=
 =?us-ascii?Q?hUIaXCYqiFh0MGcMmChHZm9ul6EIjdDu0pfOhFS/L84KP008+C/08Sg+bbLq?=
 =?us-ascii?Q?Dp1lBkbI8D+t9dh9b3YqfuMVhpP5yeBBkxwvr/9nRWw+x3X26ocb/DfL/23J?=
 =?us-ascii?Q?E8470nL2AnT6brZ9/eM6mGRLC6TuDQ/ZOnwnsUcg4QUmMHf/SAmJI/bJpF/8?=
 =?us-ascii?Q?oVarr8BmxoW6izGhar/59pBwdSqNp1Ra6XE8DvyRYeQpFR/h8Y6a9gwNZi83?=
 =?us-ascii?Q?LKEZqAlProSsXNEJXitG+esp3DdK1l5vLk3nmkie7XFghSBIszsdjp0r6V28?=
 =?us-ascii?Q?BjtEzqHD4nR0tnAqMFD3f63m8GGlYV3srwHBDJLW0Kt3yfm+6fpUThLO+eFI?=
 =?us-ascii?Q?sF1URL7BrACnfsTDbSiezL0yVjloFqwsn1onVeOIuxBIkwnhv3KQ7C+JDCiM?=
 =?us-ascii?Q?zaVSvCgEBfGZzSo/cynzf/yXGvvcjLh1GgCXCtUv3Hjl+qvDNk/TZMmFUWBT?=
 =?us-ascii?Q?FlvNZMuuwKi0PhdXTpkxBpsM5rUDMdeECgUjvHt0cYd7rDed6W3YOPDedC3Y?=
 =?us-ascii?Q?YlHWiQReiM2df1ruKfqWcWJNE9Cbvk2SL9Th/IEUH79QQ4mNBQu8mG5xpkD9?=
 =?us-ascii?Q?7BRqCUT0hjkNOyFqNzfkvpvDizfLl4iy2xYvE5NrAsYicQGW4tQbvRc3wz6u?=
 =?us-ascii?Q?olO4+vlm2b6cDnh7RCe4guMCMuIcUB9tpvG/8DRBe7qqISBJJgdnKucmb9FT?=
 =?us-ascii?Q?0Sp+EfFY+HvmF0CariZDcg5ryMCHdpbuZNuosKsljfnpwhRf9eh2VDt1417s?=
 =?us-ascii?Q?SIbWTn0/436MmJVhUITgAbRSuUwLMUNAISZCzTTXgsWMvF3VIhHW/4SgL1re?=
 =?us-ascii?Q?birvkb0X3lwKcKTmrnXDkTOtFavzsAPhfx3hCZeX+3Qnt9spNUZS52N2G6jp?=
 =?us-ascii?Q?Q+H1MfO5AvLpZgkj/uuPCbn1ABzDthz70BhtaMgerKNWimNOwzYz6QkBeGpV?=
 =?us-ascii?Q?TSzAf84bKr8E3LdVU9cJu8x7o1ZHGwBJXEzMzRGaUuPaHwYBB8Hz3B4whnHS?=
 =?us-ascii?Q?b1fbaQk/nWd1JN1emFc5l+vCMrtIpfZ96AAhNmmamFD//ii2FnQrhzfzozAq?=
 =?us-ascii?Q?5ssRTVOyOqN9Azh5WwvI0uMSBTTjPpiHLf/BVMzwy4CXICXAq0h2aq5Iq7s5?=
 =?us-ascii?Q?QvvE7H+gNNdPXbMKqOgceLhTPGRNJSAjAw0nAh2SYIwAeTQ668CDl7Bv0F4k?=
 =?us-ascii?Q?NBbwZ20f412AB8yEH/cfHW6pQaOC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NiozydIPZCbFl6NlKeC+2YawUds6SEpH5fmPwP8iXmxl6iTvdtO7yRWRkcWa?=
 =?us-ascii?Q?f/ITt/O3WngeJBG9aQzgYfxCmd+nb5t9GOwwL+XzyBRdT3VgbXuMxU+uPjil?=
 =?us-ascii?Q?951V0NmlTPGECIp0zYXt4PKimhApCxw+PsxZ920CzeRIzBZ60QC/AqTvF1a6?=
 =?us-ascii?Q?qq4lMifT4foJiXV7iJoBG4eRxHS5K7tsLVC4DeiJhUyOBqkOArBaHHNihp65?=
 =?us-ascii?Q?mh2tFgEFQmZKvY6OUbmUW3i74AQZuVb/AGXCI4Qf7nlM7C21FzG1iAkC55ML?=
 =?us-ascii?Q?vC1xtniK1pb7LU+QfDn/W/X86+y+pIcdcXC/kdZqoD3Mn8WWyru09BgjMUa9?=
 =?us-ascii?Q?4XMr4FJXgF0e1Aiz72SxzTl9EpMh90lRrrg/ZOnjxIFE2R8OBbvQckrfpjAW?=
 =?us-ascii?Q?t+w838xde/UqJhtEktTruZjF+2xpCp0hQib04jJ8KaaHYDEXR787ZoUDO0F4?=
 =?us-ascii?Q?CjHDlcUsKz+mwNfTmo6gOGFYGIRYwUm47LOOMLcmxnw/qfj/TpXQLe6ZPY4k?=
 =?us-ascii?Q?Nw2d2LoTgE3Xi5mxFkesQCDXNYz1sbBYpftuFHMQ5rkgTyqfeDD5rArBdsPN?=
 =?us-ascii?Q?PAd0756MrbFZjU943w8abnGlu0hN0FK/wFYrDAzjqcg7z6L8e+l6N79Bcege?=
 =?us-ascii?Q?FyjyZ384qZDhx0AvpMhj5I7It1LNdMcJn4LLNgXfmO28EkTgD1MJKAF/yTeH?=
 =?us-ascii?Q?nf/X+UDzEjhVBliQqwpAZC1/0S2P87huoeJ6ySkI5iuKBUXs8AhJwKFsEgNC?=
 =?us-ascii?Q?B2NexFcldpJElQZBbXzXOUinPUgPghdjKmtwDb3CzazgwdcWawCrODtJ0Ro4?=
 =?us-ascii?Q?EO2Kia+9zfqMd6qJg2/BmR2OCyyVta9otkj7u4f7NByK3hDaZQkpRaVYxPxJ?=
 =?us-ascii?Q?n1ZGJQ5PoC6oMwHY7Ysqzwc0jt4P6VpfAGZ3iM2dyzukb9bezrrLuOsDj+Qu?=
 =?us-ascii?Q?el+hlfEM8+44iKbBIOR86oBCHPDO95zMi3kK8J1PtpxY7uNHmIHLUPdqdw1U?=
 =?us-ascii?Q?JfKYhKVlmCZuL1cpFf4IFK4IPA5YFrl93UZoDcKfaZ1VIFruM0J5vptyKwqx?=
 =?us-ascii?Q?8psEkMf+l008EWLE6/qLcsacu8Eic/NAnGnne77d91jvoT/HzHskTQtoXxOw?=
 =?us-ascii?Q?SZB1nVoTBNJ+20bWQq3esT2oyoFN/+J+A07rva/z2oAdb799/Qr3QX2yEhzV?=
 =?us-ascii?Q?BaTBZTZ1htG3pr9x9dQDF1yZq1ri5FlzbgllfuAd3opTqStNMF/w5cxj119P?=
 =?us-ascii?Q?2DZNljyUM8N3AOD4xH9pQw0qH3/ndKHLKNIfHxEhlc7IELnytreAaVUUdUmD?=
 =?us-ascii?Q?GK2lBSlrCgqnVTDyp1ZkmrT7V1hAa60PL51k5URKmGVg/nvoPZ7CC7BoIJpO?=
 =?us-ascii?Q?FgDylbpYyEzhs86fka4b88hIkORrZQBjkgbmLU1sS1btqw2awT0gwLAgU3Gv?=
 =?us-ascii?Q?tUR2GJQsc3qr9RzqLhDeMLC76pnrlYFWpEJSS2GVTAt9eUTjKEIG6YPNGGft?=
 =?us-ascii?Q?QPyggLPu01iiRlOIxD5ustr5iCgSZZdDVavrzJAXeO+LsP9FJNBWVPQc2t4F?=
 =?us-ascii?Q?vEYSYZopW31rLUCfpJ7o+Kums2+2vedvNlZvAUPD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f8ceaf9-d837-459c-ecf3-08dd4c404ad6
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 15:08:37.5453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gn2cqS4gft1ZenvpiNt/11TTKE+ENAaALDs646Y9q/ZePDIyqxdmBDU88gWiBBfs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6650

On Thu, Feb 13, 2025 at 11:16:23AM +0800, Yi Liu wrote:
> On 2025/2/12 23:25, Jason Gunthorpe wrote:
> > On Tue, Feb 11, 2025 at 10:05:35PM -0800, Yi Liu wrote:
> > > This patch series aims to enhance the iommu_attach_handle-related APIs
> > > in the IOMMU core. The changes build upon Nic's previous series[1],
> > 
> > So it needs some branching help to go into Joerg's tree ?
> 
> yes since all the changes are in the core. Current series is based on your
> for-next.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd.git/log/?h=for-next
> dc10ba25d43f433ad5d9e8e6be4f4d2bb3cd9ddb

OK, Joerg I will make a branch for you to pick up

> > > This series also covers the prior series[2] which only takes care of the
> > > iommu_attach_device_pasid().
> > 
> > Is this a pre-condition for your iommufd PASID series?
> 
> yes. The last patch is nice to have. I included it as it is just one minor
> step.

Ok

Jason 
