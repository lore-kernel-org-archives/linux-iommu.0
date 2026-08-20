Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012052.outbound.protection.outlook.com [52.101.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6152C489899
	for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 21:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787262462; cv=fail; b=U7PPoek+wzxBWJDsTsL/Gt1FwidrTsRrFYjoL26jfyFPNhw49ygLeJsZvfEBjzG3t197ch290EYaC++3JAVZadP0xRrBIBDnGtRnNUJ6l2pzyPTW/gxcSLID/dge+QT2iXxgiG/tKZZ2WStcYNQdTVMUlWA5Vb+J6+h6Ggu7iG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787262462; c=relaxed/simple;
	bh=/cSyAWvCiUHEs42IyLzNuPmDE563g1BgjRR6qC2w1no=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oQGfox8y2eb68KzUvnYIkJMS7Uzy4iVUFBVz2pulWMg1ej3w3B66mHbXHhAjHgQdstxqB3P1plqRKnHyEI5gQW/KRoUlpHyD3dpivOLMqvh8beHojzZ+5bA+W/9rFNtWcfulkGhWIuVWhwWsLbfasX0rY//jbTFm5UKTmhp6rT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ILlmC1Vz; arc=fail smtp.client-ip=52.101.43.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ILlmC1Vz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FRmFibFvjbs2TxEgzQJG3aH9290aA0c9ja0jtwMMl4Eekg7eqyy8z5v5xQuo1KKH+uz6AJuJIl7dV3OKYw4w+4zv/4cAoNA5SYuIOcw9/0aXrpYsGZgl/xSJ+jdiYbkJ9JLFrvx9yx1i9iyzhre/2+MKFeui60+D6/1UTCv5yrcT23el+ZS+pHRHLXYOu6CgPSRHb4R674v5+VrhAGCpIawr4AK0MaBRab1KnaNgFMlKigEH8b6lUsSA5en8vBdoa8TSxkw1rzK16A8axeSsToqDiCS7ltgAPUUMD+rXeo5Xwqz1EcQt8KZT4bAD/D5BwAfTpSnsmeBY6Dvy33B78g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KX8ty22bBbN75Fhe8fVmHOio+zbfXXeW5R821IkdOeI=;
 b=wtI/a7JjMgInjxiXbf8YyukibQbE1xc6e6n05pw2qiYaKVIy3KtfOiRF8kWIiG01BtEeEwzQAKjvqkAkimmf7aVcgAmrtvnKg1aGkxDD2tR7moxEBuRm3mXQHmr09n2uvXhpzowzvMteKB+s+wVlZLkOJBYr7Voncwny9GUR5r7SbAjsl+2SbDxh+vAw+u3/GqGMy/ChBiC74bDzg6vnD60NXJuYufHS5lvvm5CIrIRYUvAg3U6mCGBz4mq9AUt9o+Lts9VwRCdEgFjeezisAx9EFZ1DQnU11O0pHuC+XKS8u5KS/GSq/mjADJCFFbzXMoHTtMBsZqtpXtvzHBSAOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KX8ty22bBbN75Fhe8fVmHOio+zbfXXeW5R821IkdOeI=;
 b=ILlmC1VzQqGnjlVH6qYzsPsh4nhZ134EvjlURIRuMOBKVGRomil4Eh+DZ3xAXX19DclTxgrRusdYw8xDyULanRCJaw4n5Gvg4Zni9Nwvdll3iOXk3rXnUCuCb9DIuScfZjr97CyJO+pg2p9SbjU0Qj/54xJO1FR77YEuYT+w69+2AlkopOAODk4/mrtRz0pxLHG2bn8NrsQKCYQbAU3XbKExrYkKtT47nJ4n1lH3JQPxCsmA8UXobq9fE31nhODEKvm+XoY7UwDBy352SFE8Op4XWyDnjXc2CuJFHNmxxFXkNL1Hu0LO400FYf5snocsYYg5VK5dYpS4gRRG8xsZ+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA1PR12MB8598.namprd12.prod.outlook.com (2603:10b6:806:253::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Thu, 20 Aug
 2026 21:47:33 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0339.007; Thu, 20 Aug 2026
 21:47:31 +0000
Date: Thu, 20 Aug 2026 18:47:30 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Andrew Jones <andrew.jones@oss.qualcomm.com>
Cc: linux-riscv@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
	tjeznach@rivosinc.com, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, pjw@kernel.org, palmer@dabbelt.com,
	anup@brainfault.org, tglx@kernel.org, kevin.tian@intel.com,
	fangyu.yu@linux.alibaba.com
Subject: Re: [PATCH v4 17/21] iommu/riscv: Report cache coherency capability
Message-ID: <20260820214730.GC244917@nvidia.com>
References: <20260820214150.545737-1-andrew.jones@oss.qualcomm.com>
 <20260820214150.545737-18-andrew.jones@oss.qualcomm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260820214150.545737-18-andrew.jones@oss.qualcomm.com>
X-ClientProxiedBy: YT4PR01CA0008.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::16) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA1PR12MB8598:EE_
X-MS-Office365-Filtering-Correlation-Id: 10e63cbe-62c6-401f-4950-08deff04a329
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|366016|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	oPGHzTvVuy0gbBU2IxXcLNCGzDo+sC34KylhQ6SrqaOD2qhaK3OclJPN3vUpCm4y279aS3TTliD1NuMaYK+MEyuxg/wIDbpicWapRrIAMo6ZUIaODFbLF7+PNkQqxF4sqX3zTXLoi0eMaQj6/oHEpC3qWNVCArL6bEruznVdMfMvM5ZcqS+m+bi/yFJF2Pq2gXdBHB+Qo4JIhC5LGf8LvsqHCMDReHBYDZbR1t896ZfmRDDrra6+2cRff5CstmEt1WfqaHoRf25EX4gE2BKgHANW2/lH8tMWi3Po3CLp8qCTevSgEl+FP2RCQJmoSuIYXSEskQqgKFQuNgfKoppmmBpmM5CgaRA7mzLPgzmIs5JQqnoeaRD1g6XqGxNCdCMReegwugeS8rBY+81WAT6SIC6vzx3BtEq643poAfnqRYiGJwdCTPEdM46aWq0PaICuTVSU+Cfnbk1DZuVALwZr7Ve1f62wJir7U0mzUfvbhOTVMMLit2Dsz6sC2Omz5ZwO7auKCCyjf/gMfHC+UT/axC2z3dAnZvSVrPGmiT4mciatGc0Z1aYL9MrwzIYUl9RB/Gtcios0RrSrJ/K0JE552+2lkfpK6v6DmsCekLRkedYNVYU1aSNMdQct165pkqN3Rpj/slRRTaWlz+mhtSdHqzXXwXQwdApdX8XOQJQR4GE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(366016)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UDYLtuyr7h2U2JQuHbB81nUH6NioWCs6aPsqZ+OO1zHBSkMvAhBGlWowyQ4k?=
 =?us-ascii?Q?ajYWEQN9YpcDCfEr3QmJIPrdtQyu3YM9MltTy6Tk705widlvhAVVCygyjsvF?=
 =?us-ascii?Q?rHzoxaim0fkJBKMWxN6mu3JmBQz+3tElgo7ZrsvjvoCKDwwg22IwJNlrSSZT?=
 =?us-ascii?Q?gXXNIhyejKuN7bOEbONQt1iJjNg39SDV9kHz2IMDR1iRnor5rl8I6b8fYxOB?=
 =?us-ascii?Q?LmgfNHVSTxrsJmMHsdFhxhBWgPOM9ERnllLVBPgYy4+Zc5UJmaddogy7f2pV?=
 =?us-ascii?Q?GyvncdG7FC1TAEE8a2RQH5xCLCwTlPUVJ/oaUozvjn7Piqa5wt9Qfby5qbtx?=
 =?us-ascii?Q?0pcqVZaNNb76budBVxroU+FJ+gXKASqqMizTCVhatdfwC1bOKCJJFx3shDwn?=
 =?us-ascii?Q?E4p7wEbXjOTEWiH4eC0jSivVfOzm4EubAC4NjvR/SF23wq+YwizO6A8f4dIh?=
 =?us-ascii?Q?I1ABJ/PW/77fDADtQcdyfdihOU7i+IOx6hGp35GLu85OZkbVwS24hXWsrqIX?=
 =?us-ascii?Q?pjEWPcznHQpAb3IdHZ+zrb0jVUKGs5q96I5qiY64ztynmENRxaVsMFi6QgRM?=
 =?us-ascii?Q?zVT2tA8b0WURv/lrycCwQrnpwifIJ/q2iDbi6SnUUzoqzOtujwhPeLQwNcuN?=
 =?us-ascii?Q?EyV4yTxitCqJuOQ968C6xy+nDszT5HivYoAYZ8PA+f4gemTkEV50aNvIQizX?=
 =?us-ascii?Q?8pk42P+mo5CcTX4aCwGJf1UNXWIJo8liGHz3uHJU2cslsmZWzRrb17NsNJWG?=
 =?us-ascii?Q?HKV+T7vPVJDQIiPZjvHh1O/3LTV+btPA3ZZXwGJUQzrj7T0xNVnXmvGXiQ9/?=
 =?us-ascii?Q?v7AfPjAcwk2bI70fr8vTzBMtIF9ej5WFPfRr6iQC9ENePLAF5Dy668j737Pk?=
 =?us-ascii?Q?ZR5OuhfW+YFpUdSlWUvxt1PUpO/mB8w9QYqjOPvluEditYKsLHOTcLc0CSsh?=
 =?us-ascii?Q?GhYOCUht8ZRnhdqSsSN7tnY1YUtkTr6rAXiOViyT6NZmzna/oOdrdbXwp4ae?=
 =?us-ascii?Q?H5rpVyaY9xnfxEZSK5egjk1ePMOUXiqimsNph8c2Ucaz/dHIkmULXnB8l9CU?=
 =?us-ascii?Q?UYhiLVmeCKO2bHKPaP7BpDBtQwgfm/PWnO63aKBwpNISrCoNix6TW5B4Oe73?=
 =?us-ascii?Q?tCHWyoi+IltsCWTremUequqmk7alZZdri2DkHqNi20KKuFCivQzs0wZCn8WQ?=
 =?us-ascii?Q?DZz1qSqVDyphrV0E+j6qlF6j8oNjbbsY/qhDhhQho/bd5zzeQFGeCPaxS1EA?=
 =?us-ascii?Q?bjJeMMRXSPja68sMuCXQB/Ow0yLz90qAD3UdAcdOqcJl4h/Clmf9gxbzk3PK?=
 =?us-ascii?Q?Y/caoYnxUpE/jTTwdc7ieX9H3+q88d0F2mcy/a7RUz+mxwH6327Q0FESPnUn?=
 =?us-ascii?Q?bdAaXd1c0P6ZO2zhST2XyCiFt26/q4wrtL48XJm1y4Lw7LvEwrrfUyLODPai?=
 =?us-ascii?Q?uZRjByVomOlYaOGudYuafP+iAU1qQqem0wYNKyMOEjJH8GYyTLBQxseUO1vP?=
 =?us-ascii?Q?W2LO/IFPKfwmGxayoXhHgw8uWoirOpFK8bN8I4ys9WVXsSUEbIFFU0G301B0?=
 =?us-ascii?Q?yVGpmjJN0S5ZxxJXj7HcqXg8vleFqYAg7TkvwUnRF0qd09+wPpwGOdKD0mh4?=
 =?us-ascii?Q?UuQLLZXN+1Jyk9XkXD+hVW0AJ9PZ7DluQXr55Wiok0cGleV8evfuSaaIvUyh?=
 =?us-ascii?Q?55jOWpyVIcPWtiPXGI+UOu7ZZxtoV1L+aw9KeFh5lXJOIEQv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10e63cbe-62c6-401f-4950-08deff04a329
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 21:47:31.6949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +O0TNKk1j3rv4fx+4GuL9g5qe4uEHmOBoJPGQAFSHo1tQ/Yw5fmD1A5/t1K2QfGA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8598

On Thu, Aug 20, 2026 at 11:41:46PM +0200, Andrew Jones wrote:
> VFIO and iommufd require IOMMU_CAP_CACHE_COHERENCY because they use
> IOMMU_CACHE mappings and have no userspace cache-maintenance path.
> 
> RISC-V page tables preserve physical memory attributes for IOMMU_CACHE
> mappings. Svpbmt marks mappings without IOMMU_CACHE as non-cacheable,
> but preserving physical attributes cannot make a noncoherent device
> path coherent.
> 
> Report the capability only for devices marked DMA coherent. This limits
> userspace assignment to paths that can honor cacheable mappings.
> 
> Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
> ---
>  drivers/iommu/riscv/iommu.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

You can send this outside this series?

Jason
