Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108E4194A73
	for <iommu@lists.linux.dev>; Wed,  5 Mar 2025 17:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741195124; cv=fail; b=SOEgTuHvi74AbLolASXsA+o1kSlTGe2RDa5UxQR8VVh2BXKg0HPiFW9h7iXSmZSDCAi1L4OzBVcUO6V0VnAOv7C6JzgVTzYehDUzN9mzHXA7e5vnr18RDv9JPQB1WQ4h0MQsCPJrL0auXtdsZKZlAHxVwDrA1cUAWAOEk6erB3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741195124; c=relaxed/simple;
	bh=A0xvCQtRt+8TNwSx0mw5w8SZcvy1n1w6E57zv4RXJMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jBzYcnKr6UW4UrtO1lK6QYxRZU3bhytKx4S8KqLC3SYVa+6wCSUodYh5irgUPYRcNSoJpg2qGFM/sNjjksKKCCz7MjzMinEbBibzpsiPblmN4b6FwjiHvtWwe9OJV8SOa7ILgwg+qTJDinJe/t/Fq/tVkao1Jy+lA6CIz6Ky+Lk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WuXF43fm; arc=fail smtp.client-ip=40.107.236.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WuXF43fm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qT19f7kGCZdECVL90pfG+oYHk+4G/dsrZV2RXOAfj1ad8W49n+NZNyVlQF/kJtKl7cPRuQFTihYVRRt6iFRl5+bJl8CPyCFiU92Om4d09w+0u5txDFb4h2sfH0yNCd4o6CHlZl0W/I+iluxvPrXqZyCOa2erWDc23BOeyFOHSoq1YBDaa6weki4gyYw6KrSDz2Hz5muQhJeBLBr/Ksk4k6T0iashNmwZbBEOe8dw/tYcYNpUZJbM54dUKCjpc+RcKTFTLsXO46Dcx3ItgRIIuGSY7Rg1KZC5g08h8vUEaEAVwTISdH6AmMc6JVAPhE5IDVgaFUUFTdYt240IPGdnxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sHDhjW0BVG7nQ6YZDbOKDmxam8mBD6I185fHt4tCj2I=;
 b=TDfK5Cxjsa/eXMnNLUIVCzHgFw9bcXFRCqT1XTWeGJ9sNvD5w1dGPmngib8TwysYUMkBYSnYyPYWmUky/3cj+DvnD+r3Wkh8o3zJs7j3kCrMccziyivEVhlP1vlpZSPvEnGJMbvb09kxwMrvYRmaGUjFAgQqGgAeLYgyJ/WV6pwMvlsKXIC6FWbtjJBXZ6mKGcYf5PTKf9W1++8ZF1GXURE3t+ZIQE+/dSaf0jagHFe7eGNIhu0uKv2cAmhTcULkm2tmP/UXQp5zsiRjKCDFwRDeZr+UTOaL0r1NsUxWAqNTM7SXehq33bYXnq3rNld4KqVscQ5dATBJiihqjJ7Vng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sHDhjW0BVG7nQ6YZDbOKDmxam8mBD6I185fHt4tCj2I=;
 b=WuXF43fmqt/+NaYpJsCfV7K5uiWXzA6lgX20U4PdFnMd7ZkZkNOlK03wuYzmyzXRTzNKyLzOYxgoyIAooZK8LlXaV4UjXbzmfIs2/ez2F7DpAvdB9vx0+LSZMXSd+1ePGqyDUbIzxvzqC3YeD+oCk6EldqkWyfTW3wWoggIXFLDY9eIbnuqqETuJhqKHY7HSp6AjvwNp852ToCXLO3C8u0i4Jd7R/E1OcttKC1DXMT5vK0CkNwNpykhY4nRwCFTyv85IYR+GwwBHn0RrVPiZFx2bFL4Gw/3HrZbd62en64hHSBolE/+Ktuq34n2976thb4gK8JeaHa6zDmeXHUrJyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA3PR12MB9092.namprd12.prod.outlook.com (2603:10b6:806:37f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Wed, 5 Mar
 2025 17:18:40 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8511.017; Wed, 5 Mar 2025
 17:18:40 +0000
Date: Wed, 5 Mar 2025 13:18:38 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: kevin.tian@intel.com, baolu.lu@linux.intel.com, iommu@lists.linux.dev
Subject: Re: [RFC] iommufd: Use accurate dev_id in the PRI forwarding path
Message-ID: <20250305171838.GC133783@nvidia.com>
References: <20250305130356.126424-1-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305130356.126424-1-yi.l.liu@intel.com>
X-ClientProxiedBy: YQZPR01CA0066.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:88::15) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA3PR12MB9092:EE_
X-MS-Office365-Filtering-Correlation-Id: 53f2ee84-c0f3-4b31-e8ce-08dd5c09c5b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1hIiIvL6DC+H0tM61pUb8Ie68T3ebgE4YFOXx9MkirMgvkYmfy9JPrjTw4AD?=
 =?us-ascii?Q?gxVJ4+4bD99hn77LJuK7xJ22inYCiAV4gtp3GDpIN0PPbd5mldsej/9LaYte?=
 =?us-ascii?Q?PHtm3/9txVYYfJA8e09GY0snQ7++roLaYFNe4VaJwbtSKgVjBRdxVt+shBl/?=
 =?us-ascii?Q?AMxtpta0+D1mOienyMq3rJhjsnUjawar65qshFT6xBw8z8IAGtcAJd1UIwUr?=
 =?us-ascii?Q?pjEfGMWI6vERpFzBwXV/7CdxKx2Jbu++XkG94eka5/hzwcMTBWeZpGJpeljJ?=
 =?us-ascii?Q?D6gatqf70g8XHkGkNehxT/kWfDMm8VLyUHFsNrVcomboYa74E7PBl9S3l8ct?=
 =?us-ascii?Q?V2SxEnM9y4zom09/hiS16f5nhneZNFAntyTomLLQIIktA1d1tVkCN19G0J2D?=
 =?us-ascii?Q?zHEOJymI1MyaiW25qR0CDVCIK9ro93sU6GxhRwpVgdG1/5kW1W/yUINgaHUc?=
 =?us-ascii?Q?tejwJbqnUaPTYYGAfuKg3uChxDuKT/gkbrgn8GUkMgKn9vVpcguanj+MpS71?=
 =?us-ascii?Q?yQNkpXVa8Bk6Q8XrZABpyo4Ngw0W8iE7CiND6544VGGr/0pdzDHwR0IPbQWK?=
 =?us-ascii?Q?Zr+SD4DMkTewEK6bPdArlWujRaz61AW3dVZbEefkZo7Xd05XdjgG2QBIv2mw?=
 =?us-ascii?Q?i+CZF0PkjzGMdA2KTTenxTD/16hDbsa4eGqh00tpYSGmof59Ih/NyTiJF2nM?=
 =?us-ascii?Q?3w3ifNMQEqXIpDI4Ks/DqoN6D366ebYONMu+ctvuJiZ8gz+DLmTGEYWfIWku?=
 =?us-ascii?Q?j55Mr8Ghk2RGm8wbeBJxlCwhEJeDkbbmbfsAc30JCWtG+YJEebHtPLiWRWZy?=
 =?us-ascii?Q?Q/OUzyPWRJqLDbpnePy5GBs2WTEwydBGso13GsDhcSwKrJ2wLxMiTNAx5L2w?=
 =?us-ascii?Q?L02EUNs6JxT2vsvdjOlU0vwwOHa3dM27vJVsFn6fQv/GgaVRv3/7q+VELFAf?=
 =?us-ascii?Q?lUSEowTARUP2ho/3nUvrK8JbWhUtw+6Iy30eboiLbRj8rtOeES+VywDQcERr?=
 =?us-ascii?Q?nfQjkxo9PmbeqNu85GXOsTHwvwmhYSrnW1X3P28SZ9zyfZRtcVKT8tzlUGbp?=
 =?us-ascii?Q?Dci1gbkK1lT+z/cqwPb3oE0JCdn2h9bvDSN/f5Km2qpdf9vG76xuQfnPnISL?=
 =?us-ascii?Q?ZhtzuO9Q+5zsm8r2rBkY2pmLDue+UP/KaRjqnkdqLJ4odZV4/QUwffopUwc+?=
 =?us-ascii?Q?YKJQMAe8lNx7DzLfaxu0s2spzhYDL7KLDT7FYjI0PaQ5/7L/h/qbNQV2Xa7O?=
 =?us-ascii?Q?A9cuSzH2yecMLIULnEzAJbH416Nx5fk/hh6ImNmlmOKrmb0USpaAbP2LDk2d?=
 =?us-ascii?Q?0IcfMREbOo/OmR8dsQSx2edo7L/+yPydWFG+bVCo5Jy1qiYDjkxXFqKN4e1w?=
 =?us-ascii?Q?3JOdLIGHgjiLNZ5gTTF8clHNC4O2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YFeTcZGLcYNfTIoxchu0Sr+b6iGysDts3aFK2lU6GyRNOGPgUeMNb/szJpsA?=
 =?us-ascii?Q?OhvFlcrs4aUes8Ps7wiJlZ5oZZN3pYShmaBcOrAnJqTa6AuTXHyZWmkBcHPC?=
 =?us-ascii?Q?CsyOo6wABCiaHuSXZsAon2Ukb9LFOXC4nR1f3MqteYuQo/gRtuKjMmrN9+bo?=
 =?us-ascii?Q?PRckb/wuBYir3qeCER7NUvkbHnFSCLAehqOBvVanRIxleX2fSx5CyjiZ8kb+?=
 =?us-ascii?Q?Wt0NbuKXMEiDKSkh7kyfAfhBxUoAveAbHvd5PBrMhcxDIgWBkm8kD1Wf23TB?=
 =?us-ascii?Q?mNfhs0e36u+1xXvT9o0zPn01TWLtn8go+AvHAuaakMIGJLabpARRTT/+NGXQ?=
 =?us-ascii?Q?xBn7bmMiOky2T3GUDywVxjV4BF9zs+0VxmsEKUcDu9iF9G+B+P1xSYId9bg3?=
 =?us-ascii?Q?EhsLgLhOMhki4XLr9TIwbmmrZ9jk/cqBf0cyq+dHxDIZiq4Bn74x2qcjreDd?=
 =?us-ascii?Q?zCH9qZYHkXJpOjEqSZfvs2Px6u29l3d0j50JzTRpMqpjRc35GzCarUH5lVtU?=
 =?us-ascii?Q?FT3yweH5Fytbjjgg+Fl0PqKuF3zk8Nbthf+tDRle5gFvbe5pRcTLyXVIpKLt?=
 =?us-ascii?Q?jNmk19s0Pj54Dk5XqUOYvqvD3AhjGAjrBqG3oYy80naBiJNNYv9dqfxICtbV?=
 =?us-ascii?Q?zLGPLxt3Zgdmf5j5bvlWF51NVi060oYGxiYaon0fGUoa9Ggw9PQNpYSok4cb?=
 =?us-ascii?Q?OBN9vTysZrToYdjfO6JI+7YqUpKBA8iJ5yC/8K8d4vVxGAmTztCBkcCQ/WQN?=
 =?us-ascii?Q?bnJhVumSV5gVYydOYrUPsJ4y2fNiFUJEUfvRVl6tOaboET23as8DpDeHO154?=
 =?us-ascii?Q?B7A4078uXicjVIPr7toMIxi9yyytg8rM4s8wOAgYrl0W706bqUwr56PsxqVB?=
 =?us-ascii?Q?b2yCicgdmt1k6IXhHGv0KDIxDr9CdO6tiZyP93dubhVEgeLd0Lx1SvL3vetU?=
 =?us-ascii?Q?wtEJNMZVQhjmxD3snp83FpC8KzTxGRwDoe+yguOYISJ78toOdqMHmDMU4/Ky?=
 =?us-ascii?Q?0VrATKcgrK7jtCBK9cHikbuXQM0BtrKKZwWyovxC6s24k1fypDWFBmbPWEQi?=
 =?us-ascii?Q?JxKbzORS8BRfKGvFiOLLmFJCMkykBpFJaVWzwrMWhYbcdp7kWtXr1CjhVUHP?=
 =?us-ascii?Q?ud4JUL9EQpMtKEL/M/ZGmxx1eX79cywO9HSBCJpyjR3o8PKD/TTEStK2JJYU?=
 =?us-ascii?Q?stc1PtArUaOBvRN2abyupONtTQjv0JUojqikXJZhlhAJePHSI54OyZ+lOAnw?=
 =?us-ascii?Q?athQvq0DLA54C3QCYxltHhmOy48i3J9nf8IAjGxUNzJ6mPWLy3GjHvePRIdX?=
 =?us-ascii?Q?UpJAy8GdHUxZ+UkANadxiSJWjW1Iq76a8Bmf4f0CHeWjdyPMHHr4xpmaT1n/?=
 =?us-ascii?Q?Rpnxbt3gAA8wftwL0UW7FjGfNZ9zn5XMmRcbFRKyWrHbWk8HIlrILB+GOJD9?=
 =?us-ascii?Q?/Zuli5nk3K+UGvMdqxtdQkclyScUhyyygQpAq7L81jjAzp2AopmzmQh0p2SK?=
 =?us-ascii?Q?3uhbnw+mdmnw2Gxxpx6KqRua31cIl+25oZM/kWy0ZnXBSFf5n4ReoaA7QDK3?=
 =?us-ascii?Q?cAkorO5hz5KrZpmZ1H7oB4qc1auckMS9IRouveJs?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53f2ee84-c0f3-4b31-e8ce-08dd5c09c5b0
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 17:18:39.9496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f1GTpVcmnp/nD+8gXPOANJo9whqoxJ7e4KMQ3aVQq0g5860N/GoZcupUrqfzG2fU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9092

On Wed, Mar 05, 2025 at 05:03:56AM -0800, Yi Liu wrote:
> Hi Jason, Kevin, Baolu,
> 
> This is more a query, the patch here does not really work as there
> is locking issue. So I'd like to hear from you if any good idea.
> 
> Detail as below:
> 
> Existing code has a problem when the PRI happens on a device that has
> alias. The PRI reporting path uses the idev stored in the handle. While
> this idev is the first idev that attachs to the domain.  If the PRI
> happens on devices other than the first attached device, then the idev
> stored in handle does not match.

Do you actually care about this? Can we say that devices that have
aliases do not allow PRI?

I'm confused about how that can even work if the RID is erased in the
fabric, how do we deliver the PRI response to the correct entity?

Or do you mean something else by alias?

Jason
