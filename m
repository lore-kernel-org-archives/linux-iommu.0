Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2064.outbound.protection.outlook.com [40.107.236.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E57D1E1E00
	for <iommu@lists.linux.dev>; Mon, 17 Mar 2025 20:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742242857; cv=fail; b=EEbKzJauhH+TsEH0eznZgDdT6pne0yNTu//WnaWrXfoewZbE7joJDzPMjkYvww7IZIhwLES2XrIyEbi0dQknNXgKfReuweCMSdek3BgfZRvdBf0nrOdfj3DSNDoyZd/yYDTlrV9ooEzjdIznUXYnlElzW39hsW1KiyfqJbOP60c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742242857; c=relaxed/simple;
	bh=Vht+EgPhxyBteGpK0RvdvEt7ZWkZ6XWNIxXmo2mmOOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=V1/FZv+xPrjvk+ymXQ66O9fa/022FBqWqgslDWIvuC6LfG7fVEifV35c+oknBmuq6zlLQVLJn3p0+H+lFhOtJ1PxfZQvJFBDmL5pjSrBNOBIbXI93JLqouknEf7qpt6SGjuybv+cIFKMHJS1jLnl7M4u4TrU9F1wawjY2hP0kII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RC06zmDM; arc=fail smtp.client-ip=40.107.236.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RC06zmDM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IjSJWHRNdYarffVAw1asDCiH2RgQlJfWk/qKLw+/DHWZqQQVly8PFgFLPWVKfAF019rgEM+pWHsuiS93Xtg1vPlymdBeSIUHJ12QtpDjPcPJDa1jtI/WnYsJxu/ZY5k8TXrw5U5pR6kngx/MzPp8vkTqXdlFxrLThFhsG6L+paBbyK9MweADUf4oznP4iVWTZHMzhFJ/LS91ZxkFZVCcCSnmjefs30t+bu+oz8EnCdLZJjFYaXuPQP1fNinqzRsfNsIIAhKmMqZ8fTVlVE2qQZ55GdqvyJt3jErMLAHnWzoqEPU1dmT9eZelP1Ewd2+C27Lr+96XGMO/ob3cWP9Jxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U9j+uB/NCgipfIeQr6SjQE01o6koYtHYnOFuGvYh1PM=;
 b=uOgTcHRRY6YiR/XDrL8Db47v575j2zBYXAg4K3FNzzlbvWy/pDjh8DaFKGJaOjY7SAsx96eWYrPjTownYevsuJKpSNr6J39Ifca7VRK3ALWx9os66mbYx7bK2HevGhilPocn5L5HeERHGoNvgZ4Iyxu2Q8re6bRyzMY8CtcyU7pZKv3qWbTAdjIvxAzi1kWP332hgDKMhCla3Ts8crC/3dvH0J09kl+Xwdjm6HZWh55dn0JxoLODK+upvUoVgPJeM8VRHW5M/Msr6w9gZFK1/dE7X6FpEo/UO43s3j3nmsmDTBQ6EvmczXb0Q/SuCmlH8rRBRYteE1PuRRtI45QbJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U9j+uB/NCgipfIeQr6SjQE01o6koYtHYnOFuGvYh1PM=;
 b=RC06zmDMHAj4HzpWo2Y2X0CVyYGS1Yokp+EfNdnc1KJnMfoR5U9tn9HKqDcbsxdH+BDn2dU8Nr5lBnQl/kZpp8a24MhwKo8Cvn7VNL5dx+8ItzJmEXreBfvKvVuD0g3ukdCm58AEbYhL+KcwQoYS328FmRxe5QJrU3bzgkhqtMaqdY8IsfNvQtOQgQyOQ+FMrg4z0G0ExhSruMTVsuKYLeYB8ONF7OOEvXtmn3png6QkNT+Wr+TgDK2E75F/ZcUUs3K0buFHRGxM7x8zYa5xDvD17rsXPzd9NShfN4tewH719sEjXpBDEh/2aFjgDhzbZRRuMCensseIpKThY0DJew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA1PR12MB6948.namprd12.prod.outlook.com (2603:10b6:806:24f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 20:20:52 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 20:20:51 +0000
Date: Mon, 17 Mar 2025 17:20:50 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, robin.murphy@arm.com, joro@8bytes.org,
	will@kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] iommu: Drop sw_msi from iommu_domain
Message-ID: <20250317202050.GX9311@nvidia.com>
References: <cover.1741294235.git.nicolinc@nvidia.com>
 <6d4b493d20926c8d14e29bc776639cdcf2095146.1741294235.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d4b493d20926c8d14e29bc776639cdcf2095146.1741294235.git.nicolinc@nvidia.com>
X-ClientProxiedBy: MN2PR13CA0021.namprd13.prod.outlook.com
 (2603:10b6:208:160::34) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA1PR12MB6948:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ef19ce7-f72f-4a02-5f6f-08dd65913625
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xUvLLGm9Jro8LDQAG9QzDR1IfVnyay/MipnhAkxb/HNumRPtI5p7voZIMtHe?=
 =?us-ascii?Q?sJ7or/hdPaKYXtm2aBKE38veggsIL/zJ37PP6gzXvrPc9fHw1gqNNFaPHqEe?=
 =?us-ascii?Q?Bfn8SJIqWZNnvZUW4Kye6NS6R9nfw/ZuZRr5J4egmZJr3oNWIAEAGb51iLnN?=
 =?us-ascii?Q?TrKlSVWAjEFy8MI5C4erk2ZDFkIx4hjkYr61Q/xkDXlVSHEMAIB+67zsKdym?=
 =?us-ascii?Q?TgkX898KMt+FG5eJXGe+nc54deRV8grHU2tUli2o1F64K0SeKRptWR4YSyXc?=
 =?us-ascii?Q?+oaYWoP8rvAFwbTvDaRwQn4ldBhUZNG9Ls23CqZKyROdFlWHdfqz9xCbuvdU?=
 =?us-ascii?Q?n6Xjdlx3274nkclzH68pnDLDFWYQ0mHNGtL9sTBd4zmV42mC8T/znoOoGTkW?=
 =?us-ascii?Q?EJiS/q477ySjxokLm3FEgc8rWprrFuJioMd3qvL+MZAsA42jKI0hgmCa+Cnr?=
 =?us-ascii?Q?c65vVGUsuFgwmOuqo6TVUcylQNc63nTl+MOoCbWMBCKv6omsSXXrMR4vqcHq?=
 =?us-ascii?Q?GYfoLRfcGHvP8oS072lYVIeTwEScxiZ3Zb0ebGW3ElHpFQBe8IO4ImKmfFnP?=
 =?us-ascii?Q?F61nisfxJfhupQcodo/OAirK97w5SjsUqFgxU6rvBpWCEm1+Kb10xMzOsjxS?=
 =?us-ascii?Q?wXFOppFmRVyPici0hrSNV0Z6BO5QPz58NnjKDuzu8r6A1HFo//9kmxZrMQQP?=
 =?us-ascii?Q?EnmWfoO87dqZtNGHPJTt8zRk0yoqXJb45XFXxvXYlXkjw9YINAKQnJizxVbm?=
 =?us-ascii?Q?69EndsoqroyUw0rS4g/MxJzWdZAJ55SB8pL/V/LpxWMlczECvMaKM4BtD1+y?=
 =?us-ascii?Q?UDCe9bSjbRS0Tr6HDpdFqqxlZRWhOz31tBWW1oY+Op9BUetAR2Yrz+ff0bNp?=
 =?us-ascii?Q?9cberc7YS4y8y5RdQYDlzYBRVLOsx3Xz8hPVHDzlErCbBzu+Da70xHQrs7ni?=
 =?us-ascii?Q?4CcxDHRP7jqTM7FJDZgsIbk2JhY/wfCXeqWFZDZFqWfAz4aj/X9B9Glv2KaK?=
 =?us-ascii?Q?6rhpYx/EswFU87t0006ip2XVGj2d7ncL8Ak6uNo1OWEiwvE3TkqIiuEa8c/w?=
 =?us-ascii?Q?lktAfQnbXmcNimfqj2WdMA6X7vl0IvpSUAYsAlS/lq4WkmownbaZMVRXp8q7?=
 =?us-ascii?Q?gNXMkQgwDrGFbZnJV+Yjg8Xg/EV0HilMhAPakIdJxi0p6LjDlRCA6ezHacwp?=
 =?us-ascii?Q?JXvy2vXIDZAF1TDYIRigJOF5Sr4h9TNP1GDjBwDmQuPKehroOn41XJTYTCpl?=
 =?us-ascii?Q?WX4zk+DEAuutjTPfO1vZODpeev9Y6z1CYx6jVlafcWZyfVgXxu4DElMPfomr?=
 =?us-ascii?Q?WdcWW8KOKIhvDTcFUJkTUHVu6jYp/TcmfYBVEFlY5yKDa/UdTSrQGvzKdgCc?=
 =?us-ascii?Q?3pNduYx3iE9YMYKHQ8uXAYjdA2R5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?R95SK6XaX1CR1cQFeR+EYSdVd9fABIsoD4UP7FyKzh9rhQEHHxUImqCzhNNM?=
 =?us-ascii?Q?raGAfjt7HA3pcZ2pfR7Gz3uDgfzGfDSy4CPeHMwNUkSqD+AyZbzfLq+VT/C8?=
 =?us-ascii?Q?wHnOPLHT67NpIaIhrnoVrcy4lQVLeVTctmoIiWD/U8t3mLgvmEojjvlGMKAh?=
 =?us-ascii?Q?Z/3q0mG81Am4nxlJwVqwEoQCTSej79Mgzy3bXCr5rCtAHQST/2/l6NzbAsBZ?=
 =?us-ascii?Q?BxMBp2rqguhZAwcYxsN5RgpKtUsmAjI9uhVcXfRTH9vvJkRTt3X2+ccKA5kP?=
 =?us-ascii?Q?y/+RU/wmU83WrGEYrclRs9nt1sMna8I5Xuiqd/6G/Tw65pEx0qZ+p8E1GKet?=
 =?us-ascii?Q?T3Hpb8CyFHKhUYJFxCFyOQEuiZIVnLEiMs4H5JzffwbGkvUgkt11S+TKd4On?=
 =?us-ascii?Q?27IYNT/48HnJlk56RlySWV6eX1m1PPaXMNeJWoVEc7Don+yN0Hdgq8Ep7sio?=
 =?us-ascii?Q?BacXIjFKHUxj59BQC3ILGtirB1IyJ8/rXY6YngtZGDzuLJ70PpI2ihSppS3C?=
 =?us-ascii?Q?IYJ6h3PA6UAhGX57IdAVNmrtXQHrPuPPG6Iy+TSVRukTPX5PK5dn9H6x+Z08?=
 =?us-ascii?Q?gKjRqsYcuRqq1MZ9D1JaARvykkWYxj0DESWcENN889x6IqcJ5DeUgDnd/JGq?=
 =?us-ascii?Q?OQk8GTM3Sb2EwT22ItmyvzbhWEiOKtRfhNx5zrDFMJT1IRJmpZCy/o7M49Po?=
 =?us-ascii?Q?58iJlsQVAbe3qNLFvP6E1SnAQXW+/SJ7ejPB974ju7OUhKRWRMgGEVp8Eqhq?=
 =?us-ascii?Q?3A54YGy/HO1du7pruwFFOFPatFPaLuOR1rhbJqLazvzF/7DCkLwLlMfRTwCd?=
 =?us-ascii?Q?ZC1C5K+sJuY81jY2hjqzDo4cphKsnEYBfWeajmq8WtmjZ/0+ZAR48PQnzc/l?=
 =?us-ascii?Q?N9f9/XLWyt1teERBPZThV0BvE7fUqP/EIwAigibTdSa1nHaFFLO3TyaHgUDZ?=
 =?us-ascii?Q?ytjdJ4lxiO8LsV1IYKKJxzX8kaheLrbiImrYL6Hxbfd8/IZVHLwTDhbax8GZ?=
 =?us-ascii?Q?FFafBVY7GYm9/MFc7wvutPsMQAOKjxlEeXTHmzaTSsJ1+FhQBUeA3on2dQ+S?=
 =?us-ascii?Q?2iOBGm0mAib2VnbxJU5tWgdTTX7ma6U7JQdR8hKZVwTSTCnsqKerJ/c0OGaL?=
 =?us-ascii?Q?5zh7NHmR3soqtd6ApEUtTr8FvVpyjgrqbsACGaWmz9r+CYuq+wXZ7U55KRV1?=
 =?us-ascii?Q?chIunevzgw0pkQPpMWSPkduvkgPmcmmYaSQoOypBBpzKFDWk4ZlXiH2Xyfp8?=
 =?us-ascii?Q?zA6mEMs1745janpsLH9qPgx4ChKwPg3lu+DwI44yMDrv8QdHZN0DBhEAYyE5?=
 =?us-ascii?Q?8tgcUxJBWhgjT71cHC80E6aUXwJ2po8tiZTacvM5s5OklQ5MhN5dFqxgNCOH?=
 =?us-ascii?Q?d3+UQ6WymXZPP0c7GSJ0+Qc+d7peBtjqtx9OTJqHzxJiNtUhd8HCArYz4avq?=
 =?us-ascii?Q?eRFTS/a3tX60kgSOf9JCyokg8XcE0R9ofCN2yHyakJezBNOmO0MSbAHMVVww?=
 =?us-ascii?Q?QlU+pwg9m1rAFi3qte3F3edsZxWExUbM2pLzOCa/S15WDfRg7di6rDxttpZp?=
 =?us-ascii?Q?jQzjK0hXt0v/NGNA3nyA/PRRtKc1oR8PRziRwbua?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ef19ce7-f72f-4a02-5f6f-08dd65913625
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 20:20:51.1149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zXbFzhLe/4zyF42gjjn2uATj0hm5gZwAoudpoU0oFqhTE8Mns3TjAocJh8o3MCsV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6948

On Thu, Mar 06, 2025 at 01:00:49PM -0800, Nicolin Chen wrote:
> There are only two sw_msi implementations in the entire system, thus it's
> not very necessary to have an sw_msi pointer.
> 
> Instead, check domain->cookie_type to call the two sw_msi implementations
> directly from the core code.
> 
> Suggested-by: Robin Murphy <robin.murphy@arm.com>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/dma-iommu.h            |  9 +++++++++
>  include/linux/iommu.h                | 15 ---------------
>  drivers/iommu/dma-iommu.c            | 14 ++------------
>  drivers/iommu/iommu.c                | 17 +++++++++++++++--
>  drivers/iommu/iommufd/hw_pagetable.c |  3 ---
>  5 files changed, 26 insertions(+), 32 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
