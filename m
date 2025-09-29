Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010021.outbound.protection.outlook.com [52.101.85.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D262FF664
	for <iommu@lists.linux.dev>; Mon, 29 Sep 2025 11:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759147106; cv=fail; b=muAgLFrNRaW+2qZy3Aq+MR5/Ij/kNTnG6osKDZRKRMdBGj/1IgqFvjJtL9QPekNGA31brsrQ2ER7qrxx4a9MJNmoXbhB/UpY4VgPOT/mY9X/oob3VKMItDk6KfD+KfEh3szu0ofpN/oPTA1dSKXKxigWps8tIH3e+J4jxnXxWyQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759147106; c=relaxed/simple;
	bh=YscumPiIFNWNWFoUNGceCNQKck0HUgH+I9xMFDNieNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=t/KxXvhz6TosD7br5WH7S9cljIHBRJrJ8yCbxt7NGgnnx5p9X7Uje1EeWK+iZCTPztLVv519pyj9fTubOzaPGPItAcYMGxFhQ4sjYH9MDLfJR3JOdKprnjrb4ALviMBbagXXbScH/8TPxsNC6/BltcuA9783VMqnPJmcoPzI2L4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KysdAi+j; arc=fail smtp.client-ip=52.101.85.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KysdAi+j"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tUsS1MGipPVfbyFiZkUEOp0LNY1bF6BjBVRqCxTySS+7YLbIJoq6rdc36oRUQ1OHmxgFC8gwHvsGFfMhoSZb/+0uNGwZKy3fNyKylX5CcowL+TRdk4COCJJHw26wrSQ221GFFi/NJTX9BvLO8hU1qPW5lE85lLiS8Am0gotde80XaJJPqgxgzI84uflAGESjwLupOmkrKTv2Fbw/7UKObpTuFMRtj/3CtaYf9ZGaypwmQKuCkt5vSO9KVSq4qCphnGy10obyG3VDcBaROsleHUUq7vwh/fsMVMkgAmBIs/gprNEUOfVSRx1veadPQhH/CQtnZimSrejEJUnFj/KPCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cqYHPSwy+/aIut9cBLAqciypbJ3F1iH+ZVpiri8ioBI=;
 b=h+dCQCPZ51pReJqVbxav8GmkkGbtfJ3jj3mtzW//5IEIAd8DEeVOp632akF2hdhEcq5IeaEvnAKH0zMUYQBaGdtjDc+QEcn2ENZK5xp1rS3PnQ3bvjfWOuGn3FbUVNNqRg96xZaZmmUt9iY2+K+5MokCFSMG/P4+qyP0P0xivEgDvcPVOa1jr7eAgew4sULa7TWUseXX5tGLVrImmG8xun0Qq1BTD6MMXkSxZ9YSq9ttL27O+cbPj4tz1h9pcwx8Nk9rDLwnDcBLOaKUSigZhdT9nS/CP2rjt9rbB/OISq9xwcYnhdM3H4n9XgW6uoufGtkGWO5cOVSv1T07mo/Zkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cqYHPSwy+/aIut9cBLAqciypbJ3F1iH+ZVpiri8ioBI=;
 b=KysdAi+jalbEYlevolI8L2q2bM817IScejTbY2uEsP5HeibqjP6VznGFhCw4gfg0Qf5u/E/5Iph9LfBsHQHC5tnvEt9YcKmNFRLh/3ccFF8d8Rqbw5pY8/kxAg3HRrVo41aL7bNFhgPvREICz4lGpj3RHSR9MPHsTEhUhO4sSin9j97cp8wwrwJr1xpheN63E/wRPhx3gvAJqcSw0ev4Vb8JsBMKeixKf/l8OfSmqa1bmYiTnjDzLE2D1CUZADWrt9ermbnIXmimZ/URS56zhvk/2EeOiYYxN+j5oWWX45pruqYNkq4Ly7q/UIj545dc46jwwbHbNU0tvKCSteSCEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by PH0PR12MB5605.namprd12.prod.outlook.com (2603:10b6:510:129::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Mon, 29 Sep
 2025 11:58:05 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9160.014; Mon, 29 Sep 2025
 11:58:05 +0000
Date: Mon, 29 Sep 2025 08:58:03 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Daniel Mentz <danielmentz@google.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Will Deacon <will@kernel.org>, Mostafa Saleh <smostafa@google.com>,
	Pranjal Shrivastava <praan@google.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Rob Clark <robin.clark@oss.qualcomm.com>
Subject: Re: [PATCH 2/2] drivers/arm-smmu-v3: Implement .iotlb_sync_map
 callback
Message-ID: <20250929115803.GF2617119@nvidia.com>
References: <20250927223953.936562-1-danielmentz@google.com>
 <20250927223953.936562-2-danielmentz@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250927223953.936562-2-danielmentz@google.com>
X-ClientProxiedBy: BL1PR13CA0005.namprd13.prod.outlook.com
 (2603:10b6:208:256::10) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|PH0PR12MB5605:EE_
X-MS-Office365-Filtering-Correlation-Id: 7426dfdb-6a6e-4367-048b-08ddff4f72c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Zekmwt0zUBzZ1YnGRRrlOZwfkkHFQHxSQZcDqfXQbCJUlkgAG8kQz1CO85Ol?=
 =?us-ascii?Q?ko7gkmqyaPGtmCrykNXmdfIZ1iM0d9PEI+muY0hfDBA69vJeXpKb/9qMv8VH?=
 =?us-ascii?Q?kS3qGbmIcolT43iN3+ktW8uYCK+WmGaq5yv34knk/JIU8VI8k90yK/njMmLY?=
 =?us-ascii?Q?GIEm+4mccylei9NM6xuKndfQUwuHEeLjbVjArJrmHD1l17N99i7b2k/o5oqj?=
 =?us-ascii?Q?mGcfcwqP14eITg3N5IFappJb0Pk/roodtELyhCWd9jZ1Az4sAvrxVmrpaeW2?=
 =?us-ascii?Q?mrfyiVFKEtbru5bT4fb6EX4INg5J5ypmT/aGZsefKNfvkfX4JHTXUbzWWjRe?=
 =?us-ascii?Q?Mvrh57qDc67uVGDkdGObjS29ivp68jIaE/Zlfg/lBsvZ5HzVjJDUZT+hUsf8?=
 =?us-ascii?Q?niniLGZnsUdy4pAgUvoqIyGaNArN+HZrlhezRK0JTGBPmYpZO/zm9HoJQL+h?=
 =?us-ascii?Q?FmQVe1QVunlU9pIdoxtVTIXxiIDOEnDOXdU7cgFRemJOCLMp8BeGPJXCJgow?=
 =?us-ascii?Q?kD28BtkWKzZai+rMl46BRAQzBIaHMjvPdDlWujhtT40YeZLVFKJqITp6Dvn4?=
 =?us-ascii?Q?Pcl3N0nTjPTbdvnnLYCEHABra04rRpBz36WPdwouE/imqP6LEXeEfmqezll5?=
 =?us-ascii?Q?+2IcmwCfjSH3ojUTgqxKHtuXcB6U30O+ripFcOEYUKy3Lx6FtnCwWV8r58Z0?=
 =?us-ascii?Q?0CpqvsL0S+4/w9Vhi+t0mJz1RmNyKcXCvosX3Wmc+3sSXFUe+N/0bBTYw44L?=
 =?us-ascii?Q?Rioo6UqhqeBAdL//7qpquUDAGDdVYpPIVYKkpXVaKTMfFbWEt/T9ILmOPQ3F?=
 =?us-ascii?Q?2A8pAbGckYsHFr5U2h29WzR0UtrdL0uG73sdIconNAiaTi8xeEheCdFM3DA1?=
 =?us-ascii?Q?FH4I6JhgDe4iqywdl37NybKJtY7/N/taC5C8G1113LrBRzoJFsic3uRpZzPN?=
 =?us-ascii?Q?8VxVeV41c3Fe48DldCVvH3qeDquH4OefSwf/j+Xz3IXb4wIsua2QK6ExJnmS?=
 =?us-ascii?Q?2uUw1ZyVD51RSUE8rqaT9akBCvvI52ndwO4z1y9toQMyr/zOjOCdd7vtaK62?=
 =?us-ascii?Q?aB51wn0G5zOUedK3UkNVe6IuI15B08qDnxjdRkCidMb/xWIrgWNQG9qRPapM?=
 =?us-ascii?Q?j7ZC3rIRKa2MRXZH3gwWQjT0A7qAsFX/WifRDb8cPAAVtzBb31dtoFcAFiE0?=
 =?us-ascii?Q?uLLEQAPFUG3HyB0lYN5Y9gzRFNjxXZqI5Av5WSHnl55zhnbm98HsNuDmQYbg?=
 =?us-ascii?Q?HllUSpW9JMQWWyoMnyDZCtSb797N0syhEu4TTqnEAVGOLsy8lp0CKJMocNJN?=
 =?us-ascii?Q?kVr5hfuNpuqqZR2PrmKMI1KqIJp8L137EI5XSpvU5dBu8cPXcGsxhtiaT/Ya?=
 =?us-ascii?Q?x/07CPCkQFOAcqes3fgCEYgWuWvU652Q5kfUdO/YreV9luPnXgb0Oom+pL1X?=
 =?us-ascii?Q?ycg6oz1KlMIR+D9pFbOudZUL4cejzBWU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K7Bgqb0/WQCHSRvjz0RRJOzjMzi2da2LQFOvgD40tQO1IEd4swJr4ejEWWkD?=
 =?us-ascii?Q?ETiwEw4pDdFfKV1sZC6FoqPR7SyR52lR6/3e5VMgwjFzYblwVbvkmMhuYBT6?=
 =?us-ascii?Q?cE8gDRKvlKI59IeiuDkC8GkMQ2wJkUt2qJNfNCVbTbUlL64gf7sikLL7z/gm?=
 =?us-ascii?Q?Sb3L2c7ygHTVjXH15bSDx3Wm2Vuz/0VmKeKlRpYIKdX8MOR85741jMZ/Xsq7?=
 =?us-ascii?Q?rO6T096Gy+D8aHrESUFQ64vi0PPBS8g/8wPC/82bpVc3Wu0UuQe3+idi2ZLQ?=
 =?us-ascii?Q?JKiqcLA89IMUH0Wc9AzFBsbjIq2q+yxJ7rWC31YfRP9xrZgAjzorBCZPgeeY?=
 =?us-ascii?Q?ZYjGkv4BnUV2hnJyFQuMFzetHgNK+jD6t1nQvwEFLDNSlC47ViB3J/uLCqXh?=
 =?us-ascii?Q?laDTNDFBWf+U37FaGtDF+7TSdaCUg6SI3zIzdpLN1gcBFO2WnM0LBn7HAWx3?=
 =?us-ascii?Q?6GPn96LV3GjeMKFGyz7U4wbIf/jMz6/YxsFW+vNc++Gh2ehQnqy8q0txgjtR?=
 =?us-ascii?Q?pmy8uDkv8XXg0BshfqnEj+8ty5c2DkkYmTgO4KwneQ+mcXLnYNKJsjPaRUWZ?=
 =?us-ascii?Q?bv0FIuOrp+RIYNd0SAtQ2DPRn/Q4JWfBVkiECt/stlMX2q5DSfzWIrj4PbiE?=
 =?us-ascii?Q?PwGXRXY1lLvwgHdJzKDjWFXiRwwPbJHKLdHrgQTsFjJQBhI5posXRJrMwhN6?=
 =?us-ascii?Q?5yjrhjftHHXCJKhQqpUkj9KGS6vpUOjgxIQGkZ4JAMpb2qit6GGb37fWKdlu?=
 =?us-ascii?Q?jYmsStnJww/UfKvPCC0SHFCEfUe/LDE237/z18AwbzGAhNFdWvHZCu6iZaug?=
 =?us-ascii?Q?xCYSAYfT2Yeb77ybfabNHBvoKVwWT4ja8yFhowVQgZLcjX9+JR0JQSfqb1HV?=
 =?us-ascii?Q?N5l0hkAV/Gs60vS1WcJonl4TqIuvHrH1mi3oe9QDal02X1WMUoaHpQy0GFUr?=
 =?us-ascii?Q?OmrfteCmlZKfKfUaNcTVCGxFSFqWvUZxR5NCPKi2BqQb7sipq2atowWqkTBX?=
 =?us-ascii?Q?utHtWEWzVi/wvDTYEZQKZ9+C0TU5Jlm8gSkV5b7UpNBgS5BXRtDh5lG43SM7?=
 =?us-ascii?Q?IgOwtziPAdT7tlNizxXC5P8YR01S/l636osMuERKEXixeR7Xq82DEOmiV//o?=
 =?us-ascii?Q?ub+hSrXlvda/7a54ZNmdrHii+n1dd9vZy5a/G0hRAKFfjjsd0MUo7gtM00gv?=
 =?us-ascii?Q?d93dvZ2L4aqQkezQ8kFjOE7dMgEKq5ZX5u3kVGhvTrrqViIENaqTsq7UPPPT?=
 =?us-ascii?Q?bMR3rEK1tRNhhaXNJSkUM+9g2AJGHGhoOp/qsaQlCJ5WWRkTs4pFh4YZI0cv?=
 =?us-ascii?Q?QvVqo8uOvOo9lMrxHe/3EAwyY9Lg46do4koT9qcdmyq+9bPm+0YrT+xy8YGZ?=
 =?us-ascii?Q?w9oEja7zhsUwYoS/nmT+MuH1YJacLFDinXRrlA/SOislzqQ4H1VJv0UAY+Af?=
 =?us-ascii?Q?BRnw8av/l6eLoFPcVk9OGmXXr1YYT7aFmxAekZXcZFtlO/PW3zD0x0HQphIH?=
 =?us-ascii?Q?4W2B7qwVhOaQ/jSJUmuZ/wkOohtfjJlkkPxlzcy10xvvSQCR4IWYLPy1kJwT?=
 =?us-ascii?Q?ouEkpWmI6x+2aSgjLQY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7426dfdb-6a6e-4367-048b-08ddff4f72c8
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 11:58:05.1311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vjwdtcl2Y4I9Mo7m+uwH6DKec0mj+lv/9S7tkpdh9wtl64cr7gk731Ppo+FQiykz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5605

On Sat, Sep 27, 2025 at 10:39:53PM +0000, Daniel Mentz wrote:
> @@ -3700,6 +3713,7 @@ static const struct iommu_ops arm_smmu_ops = {
>  		.map_pages		= arm_smmu_map_pages,
>  		.unmap_pages		= arm_smmu_unmap_pages,
>  		.flush_iotlb_all	= arm_smmu_flush_iotlb_all,
> +		.iotlb_sync_map		= arm_smmu_iotlb_sync_map,

Shouldn't this avoid defining the op on coherent systems?

Jason
