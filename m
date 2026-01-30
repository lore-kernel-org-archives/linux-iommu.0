Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010056.outbound.protection.outlook.com [52.101.46.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813992E888A
	for <iommu@lists.linux.dev>; Fri, 30 Jan 2026 19:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769801735; cv=fail; b=OY6J5ezo8HVa8I0EVX6teI+FyW2QFfGhnO5YAS4DPXUNB7EPNrGkdmOK27j5ppO30Q0vy1i3OnHbH0VsCC+KcvhuahZMWDy8W/FF4N3bVkGa4i8WnuQuaa4Q5qqX64/FjWuRoSZ32QnO/r/gdI/2Gt8eWrPm8pL1L1R82DMk1KE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769801735; c=relaxed/simple;
	bh=n1TJVgygCkcUVLp65hhjCpfZgr7MiRZ2OIsDme0WHKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uSTpHF5HZW4PKG3yxdGAVuO1SkIz3I1exbQ5sKPq9MIbhLm6mNQoF6Guz86Bd/JjMff0+Zf7fiZu4phZjKT9A9L917iAQ06CYX4CDcHrRZ2sHR7q+yKHoFVO+7IycObbN1XbxQZ4loQmF8KceemwiJvlPcmkbsrrzu2F6M8aSDQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hQI1ocv6; arc=fail smtp.client-ip=52.101.46.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hQI1ocv6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OZRU/VwKXOcffHrf1flV6BHyUJpYGf8WXlb/5Z0cfUne2zokboH8aUpvZluelvRPFsMB0hrmDcVsabCK4KBjxsC1MgJ4uSR6I86QiA1r4lmS30ylKl07PmM/467S0wS4y1o5BwWL3RA6OzoDZWICOVGtQ9Poor5Rgy3gfQ3/Jo2gnPg381fm1/M+/VpBt3SfkrjI60AbDC+VaVIa4kqxjNPm2p8bC1yC7RApoXgnoVmWNIoqmvv3TNJ+g6n2d8T8eg3k19wfmVY3eG5GFnWpFoVVooPY3CNURecnkj5hD0qvCEyIZrR60MaxHuV4Vik4sB9aAAAtF7QUpbC8yU46IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n1TJVgygCkcUVLp65hhjCpfZgr7MiRZ2OIsDme0WHKY=;
 b=yF2WE5JyB1nllbJs+airo0Si+120cSJB5iU/cIICy5p8Zajx1pvBNIG9T7KYLjl6DwcB5KPMjGTa5Ascwx51jGMBA/m9PoH34oI7Fsja34EoiGvVZP3m+jM4s5fUnXSO7Iw42y78NjcKrCz9gu+Szpk9g/iRbXPs1wpcTX3uubUDRCZTC4/KFRq7FMr4Zk2frwn8MBH5d4Xubqpw4U3197ny29bX1t6bwZc2StT9nP5cCmNp7GmNUABYsD9B4gVATxMmUSEeDT2BUOCD8lr8Pdz4bwV42CfjImjNOEMStWT5RELhEn2RRwFpexbIZ3JZrTU5XxiTdQj/KNqxDNn4Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n1TJVgygCkcUVLp65hhjCpfZgr7MiRZ2OIsDme0WHKY=;
 b=hQI1ocv6ufe6AZ6aOi552uSsOlga05iqObEFgjbGiA5ovDMVKbeTSldQzpwt4ARU0BFks1SQIMYPrdsIWLzNlKuKb9StoBNvvDYISssLln3MA0mWLe+a27DEGFO+MyKp+gmP/bdFz41HH/HMmW6OMc4SrGsui08Unzwi5evWY7Ln3Uh8DKpzzTcvdIIB4FrJUxbDE1FaVKZp+YMQS8wnkpTug6EAWH+j1PzrjeUnahJ2JJGyfusu4s23Gf5mlut7wA0BKkufVfW+lMJ6WMfq544IyhD5nP0SRMwEzl5L9UbWAGHsv1rrNXmJvJZ1x8XTUxoNDzWWI67SWRfCpLgLtw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH7PR12MB6634.namprd12.prod.outlook.com (2603:10b6:510:211::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.11; Fri, 30 Jan
 2026 19:35:30 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9564.010; Fri, 30 Jan 2026
 19:35:30 +0000
Date: Fri, 30 Jan 2026 15:35:29 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Alex Williamson <alex.williamson@redhat.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>, skhawaja@google.com,
	pasha.tatashin@soleen.com, Zhang Yu <zhangyu1@linux.microsoft.com>,
	Jean Philippe-Brucker <jean-philippe@linaro.org>,
	David Matlack <dmatlack@google.com>
Subject: Re: [RFC 0/8] iommufd: Enable noiommu mode for cdev
Message-ID: <20260130193529.GJ2223369@nvidia.com>
References: <20251201173012.18371-1-jacob.pan@linux.microsoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251201173012.18371-1-jacob.pan@linux.microsoft.com>
X-ClientProxiedBy: BL1P222CA0014.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::19) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH7PR12MB6634:EE_
X-MS-Office365-Filtering-Correlation-Id: a789338d-ae5a-472c-5694-08de6036ba40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8/2rMI5UGba0ni7yyFMaVnY5StqOmM8TT2iWDjDyW3+fCeE2JaoQcW5GpSJE?=
 =?us-ascii?Q?Hy6FUNx2TAWYMB/0ludW99dmuqx22yjOeurhJzXV7HYX69kZL2QLrT8iBvPw?=
 =?us-ascii?Q?5AfObghdSnSV9GY01LCPf5UdPmPgAnL5oPfEvCsvJViiNc6sQBy2AeSAYthU?=
 =?us-ascii?Q?PpEYgri02/f867Opv2ddB5itwPZc46MTjIhRc3LIHuIaIZWuDYUiTy2OEBNh?=
 =?us-ascii?Q?gf1OQWQYbGW3pEFPriWeBRDuP2ntp1w/5y8Q5CIr0+BUViKfG0IPQvSSzpDu?=
 =?us-ascii?Q?sWJrpHzLe/jL7eiJcdEj0Bdy/JogJyv9LrQiX/hXwmKoaVyU5hSCsxCFg5f7?=
 =?us-ascii?Q?HKT0jK8uVXQGnL7Uc4QFOMcvoHGYNrtSAFxyO7azqBV7wmDiBlLchALmW3LX?=
 =?us-ascii?Q?hkCZCFp74RhHnUn3eX0fU6Kg7JRmv3VALP3VPOPYINCRnH730FkZMP3pu7Qq?=
 =?us-ascii?Q?q3c6/EczTjcql4ckn76H2Z1087wVNSLv8VWnghR/i7rfvLmmNlM7z54RM7Iw?=
 =?us-ascii?Q?yHTkkln95JMw0aAeJWDSoF5UhO80LSt4Wl5IDinq2VRT4Sv7HZuwhkFoSrhT?=
 =?us-ascii?Q?02KqmhJP4wnMcDiAIZlEJUgs2cO1YqJmdjpb7cEHD2oXGGr9pAprNo/aXnzx?=
 =?us-ascii?Q?SmfvP+mCKbi/N1SaA5LWFcA5iFCTFPqEqj0o60WfnM3mSyU7BmYzdzi+7Kqm?=
 =?us-ascii?Q?HoFbpq9CywuWhZ7twFs4B81AK+koxCFJ2/BAgo695FnAw74FHTKfVoRH51/8?=
 =?us-ascii?Q?haR2/3djuW5rh0Y9EhRrvDaV2XJxh2syJYmjHb29N+lslF3t6TD93rikjGGX?=
 =?us-ascii?Q?6Bwqje2+88LFp0ji9lL4i6QjfWJa8jlp4WB8rL93WnVXdZOvYX6D3vWUV1Bq?=
 =?us-ascii?Q?OOJ9EEYNuuDuQ9uGNAYzcBhU400DhJnpaQNrdiDJGIm20qopedZdFUygvH/N?=
 =?us-ascii?Q?ut0Z1rmvrNb/Hfrh2G8M6pPlJQ1mYlFnKFc8vuQ1tSpPvEYBuXULcHjis/Jo?=
 =?us-ascii?Q?9cYwiW7jsQ4asQDZCId0IJ6oAf3hLbz2D4cMjGhbAMyZTrNoJHemIfJvjKJk?=
 =?us-ascii?Q?uH9OyAsrzp8RiiORiMrlDXAo9a7SwFI/FUsWkBTmLbzTYpebpo7nowEabH9G?=
 =?us-ascii?Q?h3ovFq36D9ZAQKQiIcfsNSXuaBabETiY9NH+cSBh0J4rN8c+OOyIRDKNl3c3?=
 =?us-ascii?Q?3TrqyHB4T+cy11lYZP+48JaHAYEEtjjexXJj2cnI/FXg8fY7aFgp2breqAz/?=
 =?us-ascii?Q?h0NonOjKED3jr96ZwIzJBTLTxhlv6glEXaShm2XraBkPYLpHPM85FpE9QxB5?=
 =?us-ascii?Q?J6K4hAcWl+6KIZfmorTYzMa421wcDkbz68ivGoFeHag+bHqT9n5cTZ4MkLUQ?=
 =?us-ascii?Q?gIa+GiXQ9Gbdi3feRkfSnrM0soE8BpzTW1BAB3KUiInlzZMKpsPqtLZhxbxI?=
 =?us-ascii?Q?8/u0UN63movBP5be6zSgEcUfs3+jJlXmLkp4l9cK4w7rj6Eyt+avqB6BiuOx?=
 =?us-ascii?Q?3a86xT2H38MswjJ79FTLRoqawvYmGBUT/PT++e199ffVBo2uDsCHSUvzDMV4?=
 =?us-ascii?Q?tObS44DXNxiLfyevRWzb4kautXTa7qEeZK70d5Xf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tKwDNUb9B1003itgbFSZFfL+ymKJm8MR1mc4UXy4fyHoqp9xDzT3OWnQs2/6?=
 =?us-ascii?Q?l3qNTo7nD7I/pQFRzqQskB+npXioIsKGshdS3msTpNLyjeDQ9uM9n1iWwBjs?=
 =?us-ascii?Q?ivM/WnokDBacC+Wcdb5nXlCT2mmCAbquesggUjU/UuBMdnF5bpXT0DTLwPQs?=
 =?us-ascii?Q?ziYMEwwz1p67koFA8NkzFP7i6M6CsdGoMW+Us5uA3DI+8VkR6hZqSn3O1gAb?=
 =?us-ascii?Q?janVI1vZGDJhzrcqGYv/Y+qUNjy+VPaWR9ubi7m80iaF3jJpfuhQQMizNNq8?=
 =?us-ascii?Q?nap+zZ6Gcj9kF/JF/TG5iE+H623QLfx1O/jybmneYJhC2c6uskJc0ndLEA+b?=
 =?us-ascii?Q?ojhUYf6W1I4KDrGbWuPxRpgAyXXbnO5rRABFAv71Fe/EdPuUe13z+A6jOjSQ?=
 =?us-ascii?Q?K2+laJsebLJAMptVtxBrf1K2p8c9+Y656h/Krxm5McryWDJ4lt3rhaOgotr1?=
 =?us-ascii?Q?cBeUVedj4v623c4Nlh3OVLb678E4Vd02EyXJyStAHBWnYFG7iU8d2S3goOEq?=
 =?us-ascii?Q?b66MJ90mtWQj2Xc1vjpOyFgeF82ETQRZhVInApnobvHSF9tYDTacWcXnWrkh?=
 =?us-ascii?Q?q+g1ONW7Tutq0em55j+miaA1ejljQOs1L64Zv60/T2/SseTE7P1a47JYNreF?=
 =?us-ascii?Q?7ARZfvg8x0w5gAWgOFvkutvzJae0mH5joSomlQAvYdTBX1AcBJcmv9lINzFM?=
 =?us-ascii?Q?yC2pSvH5hPn0jl2uhLU5/qV3j3aZ6u5Yf14A7r5s/Kz8tKLG0yyB+emeKBwN?=
 =?us-ascii?Q?np/2LprgWgnnbYkP5VvnUqsqCNoOzpi3rcbgExHvFhAw6Y+vGGkzZF5q9omq?=
 =?us-ascii?Q?j+x8P1tRJgYCCxEaYUzDZxz3wyZOMp6sUu/KGEGyoFtpA/AlUVVGQIgv6uVg?=
 =?us-ascii?Q?M2f5P2NCDoGIg6JVxp7iRvhnQHoyIYof0s53zJaivKHanWyerPmZNAD/2JCW?=
 =?us-ascii?Q?QqwhDjJxXAbugpvOvF67cVkKDiDyUpDNbm91XqT+d0HTAueA2dxLGWT+5vcP?=
 =?us-ascii?Q?1Ga1wO1dwtQtRcQhH2hrCxsNf2hYgzoeIxeZTos3BU4XNUD/gdb4n8zBnNUT?=
 =?us-ascii?Q?y2WQYoL0ZhF3YwMUHswfsoTWD05pD9NtSp8yHogGELjsPoP3jx5T2OLsTFnT?=
 =?us-ascii?Q?Zzc6deR/y9w36SoeUIasxLt65869kVygOd26JyZfqvlYliAMxfFFm94wNzNL?=
 =?us-ascii?Q?ZTY7w1Pe6TUzr3zMPBMAFObUDbpDVJAw16NPgVML8M56bMx4T3LTXKLyLn0F?=
 =?us-ascii?Q?BxUOpG4LAroyXjwL1HRhftqgnaiHQQNF0ZclUvSMm6ZtM6501K4TjHf6xZpk?=
 =?us-ascii?Q?FviWbQxaqCtlbGKj+BZc6r9sZX1MCNDYMFPfu7Hv+xE5rSNT7IBzWGHqZbdF?=
 =?us-ascii?Q?F7Rnpa3XKfK5kamExqc0XC7+7boFy2ZZmjrPT41Y7wghEKDziABXJOJmNyUp?=
 =?us-ascii?Q?mkF/0ULnTBcJ+8gc2RoZDgktLUJB5dRrnN8+Iej/X+MfrMXJOjw3t2jaZIGk?=
 =?us-ascii?Q?ZTz/Ti5yT19o4R3dzzrgMFFx8e6uOeuf7089U9kx6Q2EmkxSzBBrLW51SHzg?=
 =?us-ascii?Q?41No9LAGUBK/bGumP8FlxpT4Qh+bDyDCHPgYmfWy/ERYwcgKmyI7AQUkVFmm?=
 =?us-ascii?Q?ck0OMRsyIpBVWy3AOLjEK8S3nHExNKGcaQ3/vi1V9lUZo/rUHNMbt/YNIiCn?=
 =?us-ascii?Q?QyJKGzd5lVcv3iJi/E/noY5cstZJfJt6vjC7m2dRO0o8H0q4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a789338d-ae5a-472c-5694-08de6036ba40
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 19:35:30.4604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qG9zcBSlu4VsJu860WR0WXYJDrkFBqeWs5/xKS+SF2F2/JZm0xXzqlK2JxlQIbAY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6634

On Mon, Dec 01, 2025 at 09:30:04AM -0800, Jacob Pan wrote:
> VFIO's unsafe_noiommu_mode has long provided a way for userspace drivers
> to operate on platforms lacking a hardware IOMMU. Today, IOMMUFD also
> supports No-IOMMU mode for group based devices under vfio_compat mode.
> However, IOMMUFD's native character device (cdev) does not yet implement
> No-IOMMU mode, which is the purpose of this patch. In summary, we have:

I tried to build this without the fake iommu driver and it worked out OK:

https://github.com/jgunthorpe/linux/commits/iommufd_noiommu/

Needs a little more checking than I might have done, but can you take
that and try for a submission?

Thanks,
Jason
