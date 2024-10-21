Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9924A29408
	for <iommu@lists.linux.dev>; Mon, 21 Oct 2024 16:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729527056; cv=fail; b=cTQkKnI6EYorNBOKBgvMrKG4MwLRLpBC6n5Gw8Hvw8qGioWYa+GiJNOIbkWJ5OxJK2+TY0+vcHhgx4ctsLSdTGScmjcA04ofpyX+DipImwchFw40CJIp+krAJwZXfm0Y2mW5uS9KHG5uIZZ4HNtIMivzAiR3DcfuRRk5wx+z8sY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729527056; c=relaxed/simple;
	bh=qU/UT4LMu0slR8cTNMU3c/FBiFoQ4UEX2JJLV1b44Nk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=keckGK4ra7sHZf4tl/Jcc/5c9pR51g96dkRczB5UOQR6+9XbK2jHDNndz/VRxzBR/M5tpLUXAY1CCT2s02VULd5QsO6ObAzY3cYKRUh6F2G8QPDvXq1L7eZui7/O+RMUuw7w0Dg1piB6aI+/T8PXOvjefIQ8qlwTh9txViai1Ck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kSQNNyXh; arc=fail smtp.client-ip=40.107.220.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kSQNNyXh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o7yfU3JaTs9q6K9wSoaBCRe1Smyp7Qq7TJH3MJHEQZ55b8dcs02dZk/PnwF4ZuCULw7gAWZglUktHs9tdwAXSwVtqCokR9pP/UqkWok37ZKU9CF+M6H5An357zYhDEIPZzwny35MIcV9jB48VMzxoODiFRLwHM+tNitG7bzvwXc9dD6j92rG1w1WeULfnaFBMGYFmBHOV3pKZEvO028M1gXp6a+ScR4hrOGUdbuAT15A3d1oMPL3fq9SX527uRYAUNiB5LZpI/nQlEm6sT6/vRC3IuuFZ7o8/FSMMy+DWnI9ZiRqzv4Mo/oc8PNlPOhOOksGXPL6zJbcwgUrl9Gbtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qU/UT4LMu0slR8cTNMU3c/FBiFoQ4UEX2JJLV1b44Nk=;
 b=UUa506lTvTbKlwNbEZMf/vqB1D43NOoGxlZ08mQAPxPb/z9MxAOU1TjR2uXNOob19K6Dcssen75Rk08O0C5rRGzop7mjtT9c+okS+XQATf731COtLCY6u9UkDPk/0hak9k/vucDFs21sD9VNFN0pQr1tZlIj6XsYEuhNKsrha4rYrzR2HshfpcRdVid50mfKJ9Y25nA0e+DIqvhy/duhhHHD+lqfn2Ybuq4wUCSpGikYoB291bUyuExpGBG2KE3pzPtYzJA+M13H4y4G6oTmnstxBuRWVh7UigVUJVsHFX4zQksk+Llq+HlJLuzBhBFeteqB0l0b8zCQ8NKQ2+y8qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qU/UT4LMu0slR8cTNMU3c/FBiFoQ4UEX2JJLV1b44Nk=;
 b=kSQNNyXhNf1xs5OwBfk6IwtQDRxOM3VSMl/zzL7eDDq1LZXqxqkjoxyVlnaUJ0EN2qH6dG0BfTrKr1mXHd5dZWJ9MerUeJZB5leZwjMRTuAuWl/O6y6JUKMwpK/6I1wQsxmN0toKWWrec26xN9GK/8w7JpwZUf7yXXVsCCbJ5W+9aGh9QNqE4awrzdhmHm2xy06Mvj5UyixRPRb3r+vgL5n7yagqfr+5739Td0f/+Ls+/60Rsbmt9WEDJtEoAPlFE8pMYCy+rRrW/irRknWxbkFsiRKrUWEmmyaZa7CWjWcbU81FvgaMa3TI7bmAdQuYy0yqDF+1dtdJQk8i7+dUpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS7PR12MB8321.namprd12.prod.outlook.com (2603:10b6:8:ec::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 16:10:49 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 16:10:49 +0000
Date: Mon, 21 Oct 2024 13:10:48 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH V3 8/9] iommufd: optimize file mapping
Message-ID: <20241021161048.GA13034@nvidia.com>
References: <20241017192418.GD3559746@nvidia.com>
 <c4574487-346a-427e-a97d-6e1ee366ed1a@oracle.com>
 <20241018001046.GF3559746@nvidia.com>
 <279c7e80-1d72-407e-bfb8-d286760a5e11@oracle.com>
 <20241018160430.GJ3559746@nvidia.com>
 <dc59dc36-027f-42c1-971a-8218c658c5a0@oracle.com>
 <20241018175951.GK3559746@nvidia.com>
 <55027ff1-05cb-4ce9-adad-8dca586a26ac@oracle.com>
 <20241018231011.GL3559746@nvidia.com>
 <561a1712-8613-4f88-ae60-7f12a4b7c244@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <561a1712-8613-4f88-ae60-7f12a4b7c244@oracle.com>
X-ClientProxiedBy: MN2PR06CA0016.namprd06.prod.outlook.com
 (2603:10b6:208:23d::21) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS7PR12MB8321:EE_
X-MS-Office365-Filtering-Correlation-Id: 1143640f-3190-4ff3-ca0f-08dcf1eaed89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VnZQdS2qvf/thorpdlw0DALfVvNp913HJWe8JcvnAktKCfvStw4bNkg5aR++?=
 =?us-ascii?Q?dMDFgLg8qIZnc3u2R4s427AQTN/zFrOLn8ne28umQFnjzuyk0Fz8+81n+DMT?=
 =?us-ascii?Q?PTdRhQ1uv/RIvatru3dJAlAJaGTMYNm98MqXhTQ1RSq54vws9bSf10x1YcCT?=
 =?us-ascii?Q?gh3t5sjkEjV2B9FGcdQUt2J1hv//XyOusm9AdXWE5bWu6oqKffX1D9MYoqBC?=
 =?us-ascii?Q?GT5Kk5gY2Qq+phoHQ/LeIFLQ+S9IV3nH3Ra7biqoGxs72rvwn3Jb5uB+c6Oc?=
 =?us-ascii?Q?xWfs9SdXn8GF3OdTnvfgej5lTEoMcXbkqWmaU8HPv8teOHxAn1yrWeDkysrH?=
 =?us-ascii?Q?JRn0oEOl1Wax3Wq1zJkFFnIdXON+AT/aTeumuHnlK026FyrYRGptzQhFw35Y?=
 =?us-ascii?Q?muQ+LNsw3HxMGLQ+lSGqI/Y61OSZa3rPIYE7TRXWC/aT4O1ttlZog92nfpnr?=
 =?us-ascii?Q?y2OmgjcA1RcpPpCXBvk0yZeCCpWq+jjR96EfN9t8o/Esw78CFvMYgnfomsPb?=
 =?us-ascii?Q?pFsxQsBluQNOOSHeuTUzGqwN1oLJjpXec4aC1AO5C9wpIqdOPeFrQt+ijoyJ?=
 =?us-ascii?Q?EM8NHqFXZipQaw5DKQYlr8viFoUShHBmeGJ/JgfIFm2buj5933F+jP8X326T?=
 =?us-ascii?Q?PZcuiXR8DMepfopIrb0a40JyLZAIq2gl/3L3nQ54qlTk88pJSoaabkgc9vPI?=
 =?us-ascii?Q?lnKY1DJwn5q60Bpxu4BPLoTONxqmy9xSVGFou+4u/BEUVqx7taK6sFj4JAVr?=
 =?us-ascii?Q?+vn60Be+2rfWbaH1xvBYmN9wgc9M4SIEPeVtkwtcNO36gVmkI2WKDw6Xjkas?=
 =?us-ascii?Q?SyRBul4dlRyaVzCLctKZz+ens8p4/THcINcZsITZLZrjo+UE+QYsXLNC6cIn?=
 =?us-ascii?Q?8BuJBwXVg63PWyi/gAfcmPJAERQJhsQESz3mKYZHK83GN8ir4ZAQ9DG2CZm1?=
 =?us-ascii?Q?wKyPQVickQv55wbJRjzgHQZbgBx4SAYGrvpyCBKvrmKL9e/CdC/ySr/idYqe?=
 =?us-ascii?Q?+X+IfqTO18x/hCIx94C6rrfYtM05cgk4l6fHByDZnsX6MbzI9UVWlGiN+8F4?=
 =?us-ascii?Q?fb5Q8EycsxSJ4l28yVXPpdzGep/HJZ8DIPueMBgBLC1jK/z9irptoAQM+nzc?=
 =?us-ascii?Q?0D5fUVUzFVyEf4yTLQQLGkCxDgJtAKw9c++5up+VJly5yVFa7GVP+j05YMs/?=
 =?us-ascii?Q?kmu9sJH+GeHpuhiMoVQtjII2q3Yb5To00w10n+3J8niUD98Q7qucEAbaeStX?=
 =?us-ascii?Q?UOksKAAzrkRHPQOQ1P5d5MyNVkyMGfNXQce/6aV3B/x1jl9HSdromipcpBfQ?=
 =?us-ascii?Q?Cqv1DL3EBfuBidHGEyw3QCjh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lhjzzyVAV7KrogkS1hM7HT6KGWxHDApKp8ZTlLgUWeOb3OZ468//f7jEdPUa?=
 =?us-ascii?Q?cqanHqyTfH99PWnj6A4W/hPiZZ5Ahb0zziL0qJdmyq6nhW4/nXjKBynogiYK?=
 =?us-ascii?Q?lZwflCWC3zPR0rLsc6te76n+iXzx7hgTWrmFYp4XhPrBWsS3GejHuHc1R2ct?=
 =?us-ascii?Q?kX6LJtA9lthyd2uM1Q1CAUYn6XznEQAKd6/2tS7dvgKu+NA7cJpCCYG1YIUn?=
 =?us-ascii?Q?dSXeWdw/mLsIImt0QM0WxnMqp5O9tDyLkAelrawFC1IaqlwGebwXLChxei14?=
 =?us-ascii?Q?CYRmVp+b2XJROBkdnDAR8eZUEOUqUnfPuoF2wa4BszUAKIzKk47njNQNmep5?=
 =?us-ascii?Q?ZD0K/0mfkPJEk+gevDbCXu8l2Y5NC8AizAd/pdjg5vzCUxvb+TsPbwEoUgXP?=
 =?us-ascii?Q?BYPrNf9WP6YlfXC34ZY1Z6/qexKOf97mqClEN6pDHMkbxUUNfQZ7y0Qj2sFt?=
 =?us-ascii?Q?wIV11KcpVcsXeX5EQl/s9cWo/q0PMejc7K7omuxgOuXfhQVq/jo6GK6N5uX/?=
 =?us-ascii?Q?zC5nk7l2arL/Rwu35D0INot1Mzhk315/uxZRZb0naYj7Jt2jQ/B/uL/BdAj9?=
 =?us-ascii?Q?J+oWd02BFSqb7uJ+90+Hyfp2ORtxLA14KsCuFbxdhJIasLk0Vh5wkMQQ62s8?=
 =?us-ascii?Q?pvCLagElj6tpWG6HiwLod1v+9MY70WYtz1c88tYWdNUFNn34vbiHrfIkdweP?=
 =?us-ascii?Q?ckmnzyXq9OXwU5Jalw+wqO9ZIbPQkFoiJ/MXNbkcS5ziNeRJvuTRs3DyjPSQ?=
 =?us-ascii?Q?srZ3ayH6yRAr8rQpwdr6pJRi2HZj4bZRppj6diefV5yRMALzMR916WmTcGFz?=
 =?us-ascii?Q?DcUlh3lItamXxt+r/xP+4z9EdbOl0v1wt85FPzIHv46r9o5yXlOCF2a6GLOR?=
 =?us-ascii?Q?RFjxew5vXL9XBjG4WU1EgdfcttHS9ri1gtG5CrQBMy3Kj0AVj8cCz8MNh8dQ?=
 =?us-ascii?Q?N00R4kbyYVj8slSRJxw4VDU3U3jDAlWdk4vPcfkSHZJDAUfR7ZO7M2UMAbEA?=
 =?us-ascii?Q?yqCHSjVXuRhVSgX7AA9lt5rS2bMqgT89Ul8WREOILdQ1+BjadQh3MOYXBMP0?=
 =?us-ascii?Q?MS5/cJ4mHJX3QkR9fYye8ZS3ueWkxx2m5x0vP5eVFin+HHzWHn/rnM5AHtsh?=
 =?us-ascii?Q?UwJ+3XLU2FfO8r1geh0EX0P/leq61JY1t/6Ymw8g/RKi/DpCeymrWjjCP63j?=
 =?us-ascii?Q?QOibYlxdJhRQ1iQ2BGL/LHibIljSEyjCIR94N9fEkbXdoohgGfZdHSDhdLv1?=
 =?us-ascii?Q?Ijtntigisrn5rjBz5MTqLftrn+bwf7feIf8lJoJNjQ1SWQXawFebAWWFnD6L?=
 =?us-ascii?Q?ZTfc8O9+QvN7xNtZpETj5yrYqT1Q3ou/TcrtTfbXvso0vF2idED30qm0uqbm?=
 =?us-ascii?Q?vJuOC8mxpB0S6GoT9ZsVIGqUvLkr38gWs/1EDki7x4Kxqk448x3QyKcKwRTw?=
 =?us-ascii?Q?mFSJxGlb2+kUcLieoO/qZfqDytYP/9e9QCww8+hHyC6MvNPSh9jCx//ve+Fk?=
 =?us-ascii?Q?VTXNnyEu59kB1aqmancq2F+S2IOvdaNJG0CGJY6RWsX2+st3T0krGn6iiouj?=
 =?us-ascii?Q?1zyeMfhe8+yK6Aav53Q=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1143640f-3190-4ff3-ca0f-08dcf1eaed89
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 16:10:49.1843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v2ktY2HvfeL4lFhZ53k/OWJrGEdRF/7u8KOYBORh/8GwbMzw7ByEwHwDdiHpjLEB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8321

On Mon, Oct 21, 2024 at 10:06:44AM -0400, Steven Sistare wrote:

> But, we cannot change the signature of the exported function
> memfd_pin_folios.

Well, we can, that is how the upstream kernel works...

Question is if it is worthwhile

Jason
