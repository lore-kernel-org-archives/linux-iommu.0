Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2079.outbound.protection.outlook.com [40.107.236.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C471CCED8
	for <iommu@lists.linux.dev>; Tue,  1 Oct 2024 17:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727805304; cv=fail; b=G0NQnzpBXvNgre230KDQ/JqT+V8K8TMITXb9lIE1Of4U/j3peicuGe+G4uyhoO7ORCvDfPQ015Xr0RMhBLQb1KPlYqfcAoSB0v0RRYMBJAAJjTmYO4CwdrWHPOMNgIxzZ9W7UbDI+tBKZQ9Hh0X+pwFXBIazvxwqPdKi2z6BNj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727805304; c=relaxed/simple;
	bh=xz5uTQbA0Nat2xxQ48jBp9vC9jfovYWnKXJFMZEoHNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mFEeCV18uHN9wu0KGzB+Chd0SnbdzF79F8vjx/eYBNGBaezMMkGzTFNo6uX1CiVeZQuazesHIKfoL4SkBPJlJC6+/abDsJDkIIL8J68v5pITmQ+Y9OePlnB4EbTJEceVwQh3Tz9TcwRS6mKheVB0solFXeRKrnw5DLL3KkqJw5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fzLvd20M; arc=fail smtp.client-ip=40.107.236.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fzLvd20M"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vWctyhxB6iR/GICmOe4vE9mcQnaqzD8VH0f5Z4N4V0jlX9gwcvyAABZbrPGRLYcW2vOLZM/JDGl28kJbTtzeSvEVJ7Tt+rpR9186bisuBWtxx8kSuZ729ebvs5CGm4OIhEQfElPG60yF9HuCDs3EpYjD9BYlg3hHZnh8FjFryrMnRDx48BgL8Qy04b8vQxEIn0McPW9d4pNhCwfWoK26JLBwVmA6GYhv6wkaz9yNMJjH6dSrTnPpDblHSxClvMG3+NQ4ttPVUCbLN27l2holx/p5MT/1/Tp4hH25NpYjV+EFpUcbmaakq2VjCJEu7kqfAbzCG561fXYjFV7OeQxHPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m1ZEUfcF5xJyA7rPtvAjvDoxdo1raP4zI/dg1Hgunok=;
 b=ep+OiJUCCK5Mob921aqATPV7Vpp1csfdiwMgkwhCJ6trTy3AZkPlWO80jBJ1QqvHhS2uiffYfPue14D1xycSH2ImkNFFdzB7ihpECIkdaIhLdd55kWiB7CtGtrnZ2X5yoAad+bpFBG5Kd8dEcA2p7D2QUebB8YU9ucF5fnyBDBjEKTH3Zu8x7vUSt/up15Kox1FBp+UOcGyEQIqrPeN2yHIonx6Hn0YM+91pUnopHSRENtALjj3JY5o5eaIG9SjBpPLaJaTGBYP75NpDdxCPL59WdGt4LAdiKylLtcAwolrUHU+k4Z+t8NiMpnMIXBRBNzlEeJaupEgSBN5A9JWxYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m1ZEUfcF5xJyA7rPtvAjvDoxdo1raP4zI/dg1Hgunok=;
 b=fzLvd20MaI+9myk1Xegqz1shx3KkIapMTg19dhTCLwFq/h3TdmUEimLUSOQm/PZV/FnqgahnLyRs5DrZcNK6rktDq0ZawRAaMR6CZ8Ij3pdzfPJGUDGND4A5cLFj/YZD3z1vNUmwx3Tvtk5u2bL6ggbuDveuE3gqG7yYujta5xGgf4LPpThdnQh+hXbDQ91DIiBTvnu20J8uyRLvZRbkOqEPagBqaaE/AblDL7+RY8hgXlsoEL1ca6NwpPQ+YRBvNrJP+TrFd7Qka8lWFvsCaQZQt5DvDJG14HI6Hl9YigN+rE1NGq2o1GVlnOG4rOC23WKL3Pa4gDm+qHVktRMxiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by BL1PR12MB5827.namprd12.prod.outlook.com (2603:10b6:208:396::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Tue, 1 Oct
 2024 17:54:59 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8005.026; Tue, 1 Oct 2024
 17:54:59 +0000
Date: Tue, 1 Oct 2024 14:54:58 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu: Remove iommu_present()
Message-ID: <20241001175458.GH1365916@nvidia.com>
References: <20240930004235.69368-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930004235.69368-1-baolu.lu@linux.intel.com>
X-ClientProxiedBy: BL1PR13CA0280.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::15) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|BL1PR12MB5827:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d319b8b-332c-4a2d-ae8b-08dce2422ab0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DZ/mzdzQbspi65n9cSalkN2mTAdVZeQsAsTjXAY1DcVl7Wu8qUtWGqLQrmfu?=
 =?us-ascii?Q?CnTBI/WagAYxKjZZU6JIEcpk8aZBeC105lnLycy0ipOe21BlALMsjv9bSgfq?=
 =?us-ascii?Q?ZUgt78RK7kJqGhSptx49a6sq6noiAsS2bu0waNj4S8adXHmH/NU645uA53P0?=
 =?us-ascii?Q?sSd3isq3CKJjIz2doTMdCk/1zCqIVrf8ND6cAYBCdDsRZ+AjYNJA8g2cm0cY?=
 =?us-ascii?Q?wWNJR+ar8ObubiSfOCnPo5DaPu3YwiFT5BYDfAa42RmrIf7cZ+C1n9q97h1c?=
 =?us-ascii?Q?srj9kLV5alC2JJR35JeV2MSM1cGnYuNyZpFfUBufr5tkKKTDOIYMecj8Gn3h?=
 =?us-ascii?Q?4uNOq8BH76SAJahAg2dSxWqh52FvCl/rkRD+yeEXw1b5/kz6ZADOzezy1ubM?=
 =?us-ascii?Q?I363/E8MydEx+buOaY2JjHVXLkSqpg80GDo8hXoBlFPfzyNRabKdIDqRwCzc?=
 =?us-ascii?Q?bDXpV9oTWrsyGfD5eIjfl/MG8cxWSu7/jeTPnD0oEP4wVar4bji8POCBQfa1?=
 =?us-ascii?Q?yCZvDojP9yzvUYks6KGvRBdx+7MQKJL4hXLHE6nlhMukUbO3Den8ALaTB9bA?=
 =?us-ascii?Q?DaPRz6zmZAg/0/KD+WKcycDEfDG9ViF88zZQgTJo+pXrrL5SBqg9m8EtZStn?=
 =?us-ascii?Q?Eri53a+AS0D0ZbOFF2L8GoYDcTMF8jj9zyA6YTVn6AcCVpGCAVotS94skrHE?=
 =?us-ascii?Q?Oczn3bSBjvON5RqHOnBjxR/DwNbiFe0kDcg5k6yobhDqA/aSNXUrlLVJsh3a?=
 =?us-ascii?Q?NAy6SAvgW0dA6vkjdFqr4WvACeGOo4/Ge/o14+5Axks/fJilNTykPplEMrLR?=
 =?us-ascii?Q?aiv6yLQG1NVQhFpahEerzgE0mmBmMVJRUR/QBwE8f5g3kAdxGGGbzwBwTHna?=
 =?us-ascii?Q?ELr8iCU5JvlcmU7DgMbSijbsib4eGPSm0SAj50eOqF2JNfYGvJe+ZNg24M7V?=
 =?us-ascii?Q?0+evf9DXwnOOxQQNAuDfoP3WxYK3CxsxRDZMfnfnIxnwrZQviDddMqIsD9/Y?=
 =?us-ascii?Q?slHlaicUSvryU/LSlf56Y2DpBcwAIgPXKpAGwJhUV4J+EppcWAIY7o04ju4C?=
 =?us-ascii?Q?kiwaactEEFSwbF0vUsvbIAfoXIImiEMPWPckwaKJLkjpvgXeLXRaSg3LGeSa?=
 =?us-ascii?Q?wXlzXt7X7aZY1c5NpMLs+n+iv6lVpa374d7ewgQvRs24B0sf/L13P4CvF1Rg?=
 =?us-ascii?Q?4kROH7tND6X/oXR3LIAD1WIxy2PxGivmzY2srnU/PspqGDsPO7ebTvPpgUJq?=
 =?us-ascii?Q?Jpdz43kYxvkusbBkIPEIcaeS8sdckBswYcWnEhbIoUORTaFoqo9RTus1PNLw?=
 =?us-ascii?Q?5eBicFIJXlPvPjSvY4ahQEFkD7ZBtkerS2x/RSDbNqaUkw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G0d8z216oprItuteKVzdCz4/tjf68XcgqTIVC7CBJsaAYShXAHIwWAm8z9gi?=
 =?us-ascii?Q?RSm2E62KuIkARRanOnp0gT3O19MCH7hCPBRVrKYJwFiZZgIBY9EbQxQ5PHER?=
 =?us-ascii?Q?b5KuBV80OfmSi+T+Gfjjj0s0GRcTwY0IcG0yoV4eRwilO5W3bC9KQWi2jVmh?=
 =?us-ascii?Q?h5ncTyL8qpeVH0IssbpTJwnXgK+mSo/sPrlRGYwX0EyTSvf2kPuLGS5Uze9P?=
 =?us-ascii?Q?myDMk5La4y3Z21Wt9Ou8ZTzRdVX1lt/rbR3ZA4XWjlmy6VruHJXureFzyZYH?=
 =?us-ascii?Q?TM4pHJ+MXhr1jnn/Nv1nGLAWKV9BRYlVuG6fDYWnGZdZhgfvJ4EAdOAhp+LY?=
 =?us-ascii?Q?+9BPixHtjgsFYrW09exQb2nmqkodqA73xZrinsVpzOkFYiTE+XIkj1Ne92n0?=
 =?us-ascii?Q?wlLyVLkqbERcoCx5VJLEp4m3niw3dOisXnZB2oLHKcnHOKQRQykJKHRg7s1h?=
 =?us-ascii?Q?UwHNPvwX5QUmfioYlZmmTEGDE5dIPuZwUQwKpWxGh5OrF/jo7Fzzoh3QP0jH?=
 =?us-ascii?Q?NVRwomJyOY4w1MPAjTNRi31/Bla1MRXJ0vDCacPAnUrJEpJwaP453LEWSKww?=
 =?us-ascii?Q?yEk/scHIQ7RGfLAIKrQPh+Bc/RVnAuLh4DnNTcLc+Dzrq8mXhIV1+e2LsCZs?=
 =?us-ascii?Q?2x27T/+ro/OmVUGqPTCB8QM/YM+GKblAAxSxZa44gQzELzfwKevtCMOl6IvI?=
 =?us-ascii?Q?2BQ0N9x4t8upTmZgC0dyxX94TIZYkE871oZR6OvbyZDbUGRJwtlfi9r+R4Q/?=
 =?us-ascii?Q?O2zt4S4UAzK1nauEX1PUPr7wN8jZgbO991VTyfu32JgR3AOyyyS5gRAnHf8p?=
 =?us-ascii?Q?lGWR0/v+KD/R2Q5KlFzheG/2ZMFs5Eq3/nXmWjTqddZLM56z4kfEE1Zo08Ga?=
 =?us-ascii?Q?sVlE73BT3a2hL6uHePcBdUmgmpBwilXqB2nG1K3tYYmWSKdmnCymNeykADmG?=
 =?us-ascii?Q?uAuS+R24SL+EyzqhX4aK4uHn+q9PRw6Chw+aJUCoTqyZXlLmapIEjqbDSMYk?=
 =?us-ascii?Q?OeJqr5/aJH0LZgalIwzphnsQYezTKExm+PJALHLq93PJIgtFQuox5MXkegFl?=
 =?us-ascii?Q?XLjs0KMnwb1v5XEP6p/wTNKGM6d3OwCmDWBs6eN79vz4/imlqx4rDAGud1wB?=
 =?us-ascii?Q?2OBozJq4z7vOUU2SZ9+Zb6xBsdMsJ9URrt3FQMDN8D5Vupy5+738j0gb/xsU?=
 =?us-ascii?Q?+WYUqxIWvxTBJnvGlcKeU7QRQLnYOyEVasPtw8k6Ico2eubuY5Zm8KkQTcWW?=
 =?us-ascii?Q?cV/79SqfFSEfD6ZG92xbJgqIROoCRuGBA69DZDM3HAlzxpLOEGH03GvE0ecv?=
 =?us-ascii?Q?l1DNUxBnH8r/cCVXafqnonr6aXgXudYGmGBuAm75NGhkH5DJvNqeGIhyZvB0?=
 =?us-ascii?Q?i4My/ApTRQDT6S8QwZPNo4Upx05PVe+Lnt+JVBgxmiQ3J9eQroGEUqVj42dN?=
 =?us-ascii?Q?z1yzWu18qVQDIBHmMIurk7RqhadUmhJnabZOiGVMCAtHRj8ZzPYs2QpLIp7r?=
 =?us-ascii?Q?A0/WG96fWidFwbGX3C/8CqZuFdVvNlUPKj/WtqjyBAF7NC+9/y1PfQJX6j+G?=
 =?us-ascii?Q?Nx9zR32ZmtCGCRmbPzQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d319b8b-332c-4a2d-ae8b-08dce2422ab0
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 17:54:59.3572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VhlUstFvVcDewYdnN6BSbhAvERv8PCpdnqTF0+YlGGohkJHw4lNt1og4XfvpTqJu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5827

On Mon, Sep 30, 2024 at 08:42:35AM +0800, Lu Baolu wrote:
> The last callsite of iommu_present() is removed by commit <45c690aea8ee>
> ("drm/tegra: Use iommu_paging_domain_alloc()"). Remove it to avoid dead
> code.
> 
> Fixes: 45c690aea8ee ("drm/tegra: Use iommu_paging_domain_alloc()")
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  include/linux/iommu.h |  6 ------
>  drivers/iommu/iommu.c | 25 -------------------------
>  2 files changed, 31 deletions(-)

Also think the fixes should be removed

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
