Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B7C1803A
	for <iommu@lists.linux.dev>; Mon, 23 Sep 2024 18:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727115212; cv=fail; b=FifsF8ZV0AIYoMrL+3tla4Fo2LijDj4P5oW4arm1AAcKfTU8QHcrXKan8n1HUAOoEH8EWJ/GDTPF8t8lqfk/7M0yaR/10dKCA32kxZbtIQb37JuI+HGB3peQRSg7bIybhFrhLCiUmpLE28JNVDrr7muT0KBZ+zkNVplKzyiIvwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727115212; c=relaxed/simple;
	bh=C69WE+Mu+endPYl24piyriLKwAJdH7/8ED0g3GAk2fE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kNTdw+Ww5trUOACJvNWgbHDPaSo4r9K476rOSO+FZr1WBzY9FRb8m00YRNztlVpM7y2TxN5l2ap1dTzoeIsMXy5IP8tytqObGMBjugpYIhetI3aDhIVaBr57CsssUCjPrrujRjgQg5+mU1F2/Un80rd1fegBlFzPEOFmXxWZ8Ig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ntXkRkAr; arc=fail smtp.client-ip=40.107.223.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ntXkRkAr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vh+pev2rKzN99GThOClYQ/M+7UVPZlJqclAa6HOk2Jnb90sBa7FL/u/pj20SP4JPGUtcuEQvgYwsULxZ/ysxS68GSFxLpL7WrZ5S+Q1/aZncr7XwZ8epcrt1BwJF3BW98WH9NjdOkRqJBe1/8ps7YWIFhUWUl4jdmpg3AH9PUf/9bpIm/HZTDL/FOhDd6l3TO+c0l1bmrgSYRHNHxPEZmHrpE8k+1pcD86NMl9sQhKLluPiQEcM89rcgTY4Ma1csiSJW6xgZmU/UPDjKsI1qwGK8Vq/GfG6pMjOcPvxd4nZddmrpteg9czsVDUac0KxdXweEg7cVggUelaqPJDewgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ePN5IQGbHbsWzV8chnaezqENEGx/2nGliJ3EmwNczE=;
 b=cuAM/AIX5xm9LgSY2IF/D6MaLymGfebvech1itLMA/71nutHWUktZOXFSHnJc1Z1Y4ta5hGG49zQ91+nHW+CrY0PClCZOqZ01qetQxd0gBih925FZNQUDfJcXLFs+SKBRTjNDWkQwKQA8AQ171vzMvwkeMJCE/Cy3SkIHU51INSr9nu+qhrYj2J1tztke5vQmiDZt0QzGZwtsShfxLmFNCIe2a81+1y/MN0B98UsVOi4hNwQqwyq0MhmJO37jgt6JPYWWvRGoaw3B/pTrj20p+hDsHGpuCpo6bAueGU5QRw69iOn0hSypS6Mhzvq3IDiXt9RuHuLTlQSJG5hf2EWaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ePN5IQGbHbsWzV8chnaezqENEGx/2nGliJ3EmwNczE=;
 b=ntXkRkArs7aXjn1j2gcylSezUSAkH9fhTOWjp5NlHyp0QkYNDhpUGwDvtSw6mmceD5YHWIE9FSPGWSFb1h8HbBEiwR55pcydZAyRbgfOVucdhA5+h/jL8qVZajSB6DdJJRsY+TT4fv2pTtwkfVHZjropA82o0hNFupaPg1zxAfdsA3i7xZ/J12pwxSENYiG76rZX8nMRVzswFApk61z7GuVhW0c2EiUF0MQqs8f+1vP4pyaM7+6mY2mezXlACuGHTyWeNz6b+BQCGSiVkpL1cS7aILlBaZTKGFlL6HJVuAprELI7JZS9k/WxP286ZzT2OlmuSmwabaDMzPRo1q6iow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by BY5PR12MB4065.namprd12.prod.outlook.com (2603:10b6:a03:202::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.22; Mon, 23 Sep
 2024 18:13:27 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.7982.022; Mon, 23 Sep 2024
 18:13:26 +0000
Date: Mon, 23 Sep 2024 15:13:25 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
	robin.murphy@arm.com, vasant.hegde@amd.com, ubizjak@gmail.com,
	jon.grimm@amd.com, santosh.shukla@amd.com, pandoh@google.com,
	kumaranand@google.com
Subject: Re: [PATCH v3 1/5] iommu/amd: Disable AMD IOMMU if CMPXCHG16B
 feature is not supported
Message-ID: <20240923181325.GG9417@nvidia.com>
References: <20240906121308.5013-1-suravee.suthikulpanit@amd.com>
 <20240906121308.5013-2-suravee.suthikulpanit@amd.com>
 <20240906163818.GK1358970@nvidia.com>
 <5ff8adab-42c9-403e-9822-8f4fbc259d07@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ff8adab-42c9-403e-9822-8f4fbc259d07@amd.com>
X-ClientProxiedBy: BN0PR10CA0009.namprd10.prod.outlook.com
 (2603:10b6:408:143::6) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|BY5PR12MB4065:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e13a3d6-eef6-4137-b131-08dcdbfb6b55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SjYvUzpTgzMWDa4HfTmY39r6aLcu2N1GBZijmbgEkUw1RRQuQMS2eYs4oJpv?=
 =?us-ascii?Q?yDTN71M+rBm9Avls8cnfgXXTrgXDtN5lRq+mI2h2v1XBPZc62R2Ebm/WE+DQ?=
 =?us-ascii?Q?27M6msPIWt6L4K/OSRTtgp1/C9yhOFkuPu1oIfQAZdBXzxW2kYPRi0JC5T/V?=
 =?us-ascii?Q?nPG8oOSoSJ2FAdOXX7+KPpY959St5LWamHBhsZhvDyFq7Pnh6nXfP9ZgQVYO?=
 =?us-ascii?Q?iYePkIxCRBAUEOG6SphnNEUvvHso0Y9XxhORpyKRYDQnqBmxSahvHjpm0jHN?=
 =?us-ascii?Q?1QoyshPhngAXPOZRFGyLONAY02yFbe8syW4rmfWenM+mfaz3/HnZvPAw2eoc?=
 =?us-ascii?Q?i7FDPJ5ooW96vV2O3N4DDjFE8GArk/p3tmXxvPJBSqCK/GEYId/4yfii+JBF?=
 =?us-ascii?Q?mFDV+p2U6Qvg/s3K1GZQRD0tQaylR5JFN3dNor/cnx0ecTd5ZKac8FwQTo/Y?=
 =?us-ascii?Q?dw8/RyUuKBRPNAy52J7arTXg1bMmQjH4wMDL4jPvEcygCv9iLMH5jX4QOCLM?=
 =?us-ascii?Q?IRTcjT2813Cj6YUmCcTwDTafqRlsxeoqjp6uR8fnM2h7SBGPLh/Cqh7kbEgm?=
 =?us-ascii?Q?TUdfiCJFBmpkzPQLlTb2HRZzYZE9hn6WTPEMBh5TAMZy6BhmMxH4VdomMoLw?=
 =?us-ascii?Q?rOFEvSjPjfVHHoU6Z4FKyEsWjfdPA12c3WFNiNGwr0dRIzjV3b4tt+bXKV0k?=
 =?us-ascii?Q?pe0nXuNk9d9BASbppzmRZ4YDX+JlyybLPT66dKuGJLmdLn9W8EprHUlW3p7w?=
 =?us-ascii?Q?mHYek6dqfx68mDewDZzM/H3duW/f6LZWOqlXYzcplyBjB8Uv9GxNOcOxwwpc?=
 =?us-ascii?Q?2a7zeXDhXQrtVXf81yLi8xVYaxId8onaJ3Oskg5qjVctUH8YrgGNCVkk6Vkl?=
 =?us-ascii?Q?2N66q1qCocYUpWCh4nJM2iMkGNTejVDwSRVSTDvglpLwdJ9yGRnxgDr48tV7?=
 =?us-ascii?Q?YJN3GeUE7443M8IRbdP2XG9hkjCjssuTOFoc5bgjsioqRKNbY8L0tNltyy+k?=
 =?us-ascii?Q?/T4q6DN1PDI8QwV7fJCYiPn0B/a/V9RccPkMuoiwDAb5WJHKHjfS0b4toozi?=
 =?us-ascii?Q?IGP2cRXbSAaLZGoSeZ5vCHO16mUvakrAM/7Bu+QnEgapax9ZsCSJ0ytG7lAd?=
 =?us-ascii?Q?FKZ7rEBzyk6s7JMB2v/77ud8ZfILHi0kjCGSCQvak86t0R2O5s3lnjKCGLle?=
 =?us-ascii?Q?Bx2GWQtHuzZf+DphcTL6IhSncV5m3Uqrx0dyG/kuy1eGn9+TJEEgSG96PrHY?=
 =?us-ascii?Q?oUh0h2HeqzSexRwGvZBOlXQviSAUq1iKuEFLbN4tvyrjizDgzqnRc6ciUvKc?=
 =?us-ascii?Q?EyqZLqI0tl27PozLluqTUZ0HwV0p6ATN26Vz6YCMNBRQ3g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hVatKf6b61UsCiWlpyCp5/B4LTaNS7y6q0inUZ8FbegDHEuUEB5oTtY1yeAz?=
 =?us-ascii?Q?zf+EFn5W0zTrzY2g5i9xlcaRzRQ0A6nJuutJXq7A53IDdTPvwfD7cgs351NW?=
 =?us-ascii?Q?P2g0tpzBXbZ2WVflExXDHbyt9tFrK2gvBmJGMyibXEG0vP+7Ky3judt0ajRm?=
 =?us-ascii?Q?gb6WXcX3AKXswPTxTCCC73N99Pqwn3V6xSb+DMaGgoSdw3iFJtE403XMv5fX?=
 =?us-ascii?Q?ELHOK1EIAk+XIe/u5ESsPudSsVHE3erfwXOJoBHyGGFnuXml7Yczrld6mzh0?=
 =?us-ascii?Q?hgUVVEjPeGiM8/9SkAiTAk1P2R4+P+o+C+ddBIUpZheCKC9LcWsEetXbMpmB?=
 =?us-ascii?Q?QDt09dfpLYyJrQtL4eSw1GMVQOLC0PF4mlPucuhzGC4rLMOdHMb3qA+5HmuQ?=
 =?us-ascii?Q?VT/h/q2JQ2+75Jj+w+lLZojFogLX1MoJyURkXeAQ/yo9/0Mtzp0Y+6ooshCk?=
 =?us-ascii?Q?EVrcmZN6aPBOhRxHl/+VlrCHcf6IEw7rrUv47yHCkVV60EaAAKM2J+I0IFed?=
 =?us-ascii?Q?rYeRYLuRfw7dx6pj2FcFfUG9ZX1ZTeIRSP9JWN18iRwqM+uDVySO08lAlV3h?=
 =?us-ascii?Q?ZrCZmDnwmlbSSmfR1sStwRchTIUjEJ93BksI1mZH9a0LwPO5q6m6z0zvhEsJ?=
 =?us-ascii?Q?2++juRAGuUN1e5E1WkHILBHgq9jx9B5q/lq3OC2JusTTSlRQQNLWcVYl8Hxs?=
 =?us-ascii?Q?vNm5L41Xe7UR3/ogXcM9i7o8njS+vK9AF7IwoqkxKzfTvSdtNPNWCMCUS7ob?=
 =?us-ascii?Q?0Et4G3cTOt/7pQaBDUIp2Cc+7cvxKqITrRWOGSCz/6L1M/tfDZ9VM5l5gEgk?=
 =?us-ascii?Q?X4WsBVyll8BUBy7Mr3p4wQeWxGefQl1twgTQOGGox5/Auus9cRD1DquW77zT?=
 =?us-ascii?Q?5QRL9gEwI/sjA62ZacobUnTY9R8FGRakI7ldwtzUAAtG87Ybf9fR10nCSF2w?=
 =?us-ascii?Q?FqZKoTy5lYg8JB+Z3j0hR0gKVfuOv72ZShQyfdkv8+SbwNhExHBJJWJAyT03?=
 =?us-ascii?Q?riyhzP/1zHhrWqL1CPE5xjjVZeT0cvKk0Lli+lOJ/xC5NniGoB5t4lgCmpbS?=
 =?us-ascii?Q?/7iFYQ7Gq1LneATc9ma6ydGNlxqTtQEpQAEO+QGxhfwC541+xgO+/5pIsn46?=
 =?us-ascii?Q?Lol5BPcXKAgUR4pz5zyj9DT6V2e2rIyiaQR0kHuxKGmeueb5Lp5eFNIkmIcn?=
 =?us-ascii?Q?k4QdwC7DSodI7PN+gmSr+LOPodx1N5iSoOROi3ezFG7GC3AalozMXGUzY7c8?=
 =?us-ascii?Q?6GeCscj2aqA5d2StdNJlsmSUB1Rmf5ekd2zGgcdwjQc+PyMK01+y6SKq9F4f?=
 =?us-ascii?Q?agRvZgivz/xlhI3+PESoRuNqahv8y7mQZMvEzwPR5nnkLwUHD2m3h78lY9qp?=
 =?us-ascii?Q?iaMvwxoezPDc7xBY7EAu8Eu/QEJQ0Zj+SXKI5Ho03CeE2t1zGXrkI5lkmesC?=
 =?us-ascii?Q?wgQVuvGxkhQaAbRQ2TAKSxBGrGZxjt7vQ5T/vRe1iqNm2kNwWYJIpkIV0bbV?=
 =?us-ascii?Q?3Gvaru0U9x52tVMGAznvw76iUhxZJd9FcgXEIcpT5314OqpWHVYqaXEDgrMg?=
 =?us-ascii?Q?RS+QW/J7R8LJYZ58MYE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e13a3d6-eef6-4137-b131-08dcdbfb6b55
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 18:13:26.5839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BAzByTLVWtOzvWdsevBAJCCX44uZT9CnD4fGiKSflhEbXFOEqFohjOyDZ0xnnI2l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4065

On Mon, Sep 16, 2024 at 11:11:46PM +0700, Suthikulpanit, Suravee wrote:

> > Avoiding flushing is only possible if the full 256 bits are read
> > atomically.
> 
> I have verified with the hardware designer, and they have now confirmed that
> the IOMMU hardware has always been implemented with 256-bit read. The next
> revision of the IOMMU spec will be updated to correctly describe this part.
> Therefore, I will update the commit message and implement the code
> accordingly.

That is certainly convenient, except qemu doesn't follow that spec :\

Jason
