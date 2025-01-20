Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1881EE7B6
	for <iommu@lists.linux.dev>; Mon, 20 Jan 2025 16:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737391459; cv=fail; b=K4SKGc0P9kV4Zv5HODNf8ZmWJLqk+5uua/lXPx8lB/4BxBdAVV6v4UvJPzYlPclIbLidatuUtF3dfjUeg6idxcqlZQ8c8fnLTCpLykhhmeoMOS3PFjVORCMlPUTjE/sCdy4ga2iROBDCN7o8GtSJTnHPcIdPEv2oDfeCNG2Paz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737391459; c=relaxed/simple;
	bh=Lv5yZQWW2VO5eTAOhFoWiq+iZQH/UVanoTuwfuc6OG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=n6oM8jzkcC53ZA9G7w8a3Y4gFSdTY5YynMMPhm2JjxEOF+5bBsq3wYul+7UDqlUTxW9d86HzV9RbzIQ0s9ZHtcigjPggvEzjWDplBZxCh/NDzgfhSgYSXQEUJ/cb9b5vLd8dqqozD4P1UUZx8qnNd2/qktunCT6YA53jqfOwpQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UaGUtUun; arc=fail smtp.client-ip=40.107.220.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UaGUtUun"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HoAXlZ9HzLCbFQwKSElnn8YprnYNiozSB6dD3zFiyri6TSYVuDBdTauvyWtoawaAVl5o6OckLSXQfKMzoeSUBXAYx851M57t4DIBTnlwXuLy+MIPwsI6FwFToudRMJjoIILJT8XTH+Gtb3bGSUS0/eEnK0Yal6TilF8Agn+jtaPeKEnLF8xs+a9chD5zoaDO1I5fOwhJEJyKdubMZjx0S46nl3rt+E2B/qw7o24ECq4go05kf3ZGzw/lcMQPT5rrOJVtdLZwhlUxjn61zFqYn3vpWeG9xhxy9unQBudJC4SwsIuNDvTMF04aS32qZ4Oy7TmgKovK4Za+S0YzeyOihg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0LItuT0I5LrWmyRn238JtseCZCcDyma/Yz8az2VbCIg=;
 b=mCpW6WjC5Jx1uJ59MaddDPQQv0luMWw0k6T8R8kaxcN+RoqrYbd45m0qsiQNuuHFgy1v79RMjHQN9Cm93/DkNQST6XoaktR/YngnM8mWCCVFDOhSkqR9HZniv04dryufithB8mkHev3IAE9B35HsWFwK//jbXZlFiRUHdEjFI/PAom+KzlWgc+tB5IBqHBZZjYihgiRuD3fcrO8gzCOtDTN0NuSQAtrUWCl6ukefVATkWTpdXwH6cc5yWNAj/yacbVEXo40PhK79Uj5vFchepznf5rXHEG89N0SSdWFIm8IDe4LfBxhNVWfBDeolG0BT10FD9DImUq7dfa4D0+0qrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0LItuT0I5LrWmyRn238JtseCZCcDyma/Yz8az2VbCIg=;
 b=UaGUtUunFgglUWGCgDZ7E0hkXUVjHeEKuwcgPfIcMzt+cXsK/eAiG2tQdhirmNwpGXGoVa0MwdSWuBHbfEWfLrO7qtfQbe8ksRLeM04+r+jQpUW4bIE8GYEBII/UMCfDv6g9YeG9nEIcyJFWll2VrezadPkpEWJrwKVbuN5pceyx7rlCjQUsSl6DOQm9r6qfLvotf5Q0gm5QEDoO4uAAOhC2RGJ5e1PIbAKHNr39RQsM13bO7ZAuQFHo6B48JqlxYZtlSZbB1SSXtTLDFZJpleJEHE4CmgNr23T/+sNeE9Jv62k3GZ8akfGpaKE1ukEKAHk/0u7LdHYLzRFVAQ4ewQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA0PR12MB8645.namprd12.prod.outlook.com (2603:10b6:208:48f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.14; Mon, 20 Jan
 2025 16:44:14 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%5]) with mapi id 15.20.8356.010; Mon, 20 Jan 2025
 16:44:14 +0000
Date: Mon, 20 Jan 2025 12:43:54 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, baolu.lu@linux.intel.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH rc v2] iommufd: Explicitize struct iommu_hwpt_pgfault
 padding
Message-ID: <20250120164354.GN5556@nvidia.com>
References: <20250120062411.1589-1-nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250120062411.1589-1-nicolinc@nvidia.com>
X-ClientProxiedBy: BL1P223CA0022.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::27) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA0PR12MB8645:EE_
X-MS-Office365-Filtering-Correlation-Id: 10034123-028b-4179-de15-08dd3971a0cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?j4uOojxhTOEU7sGCr0hWAAIzc8+JNuQTP4GUMkZE1bPRxn3Gohuii2dsAmmU?=
 =?us-ascii?Q?+Iqu6CH8lG9+cwcrLRj4dqePCletipkNdFO+AlcMiCDyUchkzlPU/RPwzbFr?=
 =?us-ascii?Q?B3+LLf/f1JUY7Is5o9VFiIRo79kx0OG+GS6ybaX/d0e+lM5Xd67JQeh2EMnz?=
 =?us-ascii?Q?D9/X6ns1VoS1/V/siZQRhn12a/VUwfKhAUdYwveFe0ay/7Pa/XNNtiwUUlYm?=
 =?us-ascii?Q?P0SQlA9x2cwHdw7U7cbHdtleiNlJC+s0CFdryUx8jNxVhvN0PODkiarJ3efT?=
 =?us-ascii?Q?TC1FXGQLxEjaYcpK2LhSod3cs4yThfEIACiVqfAcK9V0PAu8z3VAk/0QKSGA?=
 =?us-ascii?Q?j1HBzSwSl4fHJKg1lHLIvDSRjo/v6/JLVHgWrkP5G3hGFeAD39+4Pfqesmza?=
 =?us-ascii?Q?TzjdPO+slTddOxaQo/MUAswh7jl6B4KfOy3Z+hjUeFKjNb9HLGROTikISwrM?=
 =?us-ascii?Q?c7lJEL2yvQYUdh17xbgfBjfLzBflecde9R8GD2mza7oifSLdGw4nAcg/56A1?=
 =?us-ascii?Q?HuRIGzD3FhkMnjWUQLnNFnCaMK3s3pbawOaHHL1xeFmCbaivZKXlSj7PJrrx?=
 =?us-ascii?Q?cUo+7RTzCq3clw0g+PqMFjykZ0GawmQ0ATeqLZMPhobP7+LBAnNrJh34Aqox?=
 =?us-ascii?Q?oJXe2fuwxsFWqcfzgHLpJdvfoqDSI91MwD+6cqKO2fm0lrRVJZbuYha1PxvM?=
 =?us-ascii?Q?WypI7bw9y9JUSn5DCEU+IB93gmp4VEGg+I0PnZC7RsdBiKsdFtQX671qekAx?=
 =?us-ascii?Q?370PU6R6T/7E4tjI21p+VK4kYmsC9VChPsrvNdJRNpv3rG4aniwJpmTIa12m?=
 =?us-ascii?Q?S+cplCmrI4ax25FEoAH8HinrRCF94WwX7uI2KQg/Ea3rEcsp0YWDpKSoOf+1?=
 =?us-ascii?Q?6gHFp8exuxgT2D/r+XamFWd+do8s0QCnrO5TrpEazYTWzQbgDusyZbMU/HWq?=
 =?us-ascii?Q?F28ELnJsdIbGJGwKRhFYcq7dj0CYxlW7DAVL2K0fyxVzVPJCzB4ON3jKvjdq?=
 =?us-ascii?Q?o5APaFJZbQBVoKBS9WKpjshcNyfSTwRjVtaAtTCIgXhtrmuLZAzyLojn2P79?=
 =?us-ascii?Q?ZxW97w6XToeOYZxoI84LFF2ZkOFxJV0mUa/d2u6xtA4G7GVkjL237tSMrIc1?=
 =?us-ascii?Q?/Nz+x2X6boUtZx59OVhuh34WKONJkwo/Yv2DrH8MzBEAY+46XCR2Cf36mPqh?=
 =?us-ascii?Q?ZOELIuF9VkI491+YBrY1cINbVexlxu0RWsFteDSEMRNxTzReEcAhog+W9n3x?=
 =?us-ascii?Q?5NJKshbQg1dx9x3dI1GDPIeQ2W++dS3VjJjd7RlNuSExVsywiYOziV/j/K84?=
 =?us-ascii?Q?MluoTW/tfVvtJ7Q47g8vkKMfDoWO3BBRK94UAi/yK9j8U6WUAn4FwfshQJh8?=
 =?us-ascii?Q?LDVsnyJwHCm7np0JBdl0xzwzQLkX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kLZi61lMp6I2xuiGg5fKaLKV4vGUDzICQF07euraBvEjkKJjZfq4oU2FEBOs?=
 =?us-ascii?Q?KYQ0WF4qx6Jkc60VLiORoJe+iD8tEcwcWe14tA8ns2oDRqMk6A1p5G4h8WJm?=
 =?us-ascii?Q?IH4UdZTRViHIQNVJlzBhOUKnLLw9MnNwy+iJ0uP+DI3JpYNhg5no1JhaLGqo?=
 =?us-ascii?Q?dxhd5gOq7ed0RyCILVmdsO/Ez1gDGbquudL4Fv//vp6O0WJxQxQAV36tRuu2?=
 =?us-ascii?Q?I+GL5oEva1VgQjFt+37C049vzeE+fjQKsDxxhV1ij2vcid7VddkUHXuLmReE?=
 =?us-ascii?Q?AUpyYMFZkTHGQo4MECfVSof+Z1WwAptfBazuuBB9HIiYstct/h0V1EPu5DHH?=
 =?us-ascii?Q?J3z9MjYKfamhqExswdJG8tsj9JoVKQ3qNcdpZBdLGCeCi21fiE1/H5ak4csk?=
 =?us-ascii?Q?CmnY0hlJTZj+wCsPghftvoZzObYj02K9m9jUxKHSzBKM6ig0O6hmU6EXrUYv?=
 =?us-ascii?Q?x39u+xbUSjmxePjdzKkEDa5/oM8njq36Gv9V8DvqqGWiRUoNNoUNlfY3tooA?=
 =?us-ascii?Q?exBP/NfvaWqujpNJ7JDP+iDBM67v4wAN+8hdk7rxebGNFQ51rqBdsLzrJtfQ?=
 =?us-ascii?Q?/eMrd25+w0kgZghRI6GTc1CwDREzZ0ZyjjXk0Pr7+Bdh5/GRI7Fsjb91gLpR?=
 =?us-ascii?Q?oFthn20tn9nZEN56PddSwA2Mr011xqDZHEJWE00R/YEorGOBZXpOHnIGcJVX?=
 =?us-ascii?Q?j31BKkgOsFCLA/bau0K9Ba+Za5S1UWo+HgeoJc87le650MVyiH13FuKO/Vrj?=
 =?us-ascii?Q?OBgsu9KLxCKrxeu6vARmeKx0Z3rzrbA0RwyH6eIGqNzTsOwevwOA39a7rbyB?=
 =?us-ascii?Q?43PLghDduoyFNuoa+pT69IiXXk1Oobbk+/UM4Ty3dkoCS/h2kSf5ncRZ1zym?=
 =?us-ascii?Q?F3J6soEIKJcqjdnAgJ8UXi9p/P5geNFIp6mGrY/W3udUr9FCuqVjrc8fSbC5?=
 =?us-ascii?Q?2R1UyU/xM8Fuzp01oxxJWYW1ZjplusR4SO5N+BJ0ySVXKmhD7aM9XnK3IzRQ?=
 =?us-ascii?Q?aec+PpPAxe5HzkwfSAxshWBVfXrtPAltbNQVdnAkZ/9sb9UyX3aaRJmvb1/y?=
 =?us-ascii?Q?sKC200XoTjWcPdNFf8tGRzueRwV6h45VWQiZomRoKZfvUFNogs82zUymViEq?=
 =?us-ascii?Q?t5Lt7VpcVhD4gHr22P2g8LFjJtCXiUCPV5cQ93LNhKPanaUC8NrJttft711L?=
 =?us-ascii?Q?uWNdGJFCZeWVtYncDpkhM7iCjj541c2liQ+xorbRy7xR/OLR2IY4i6AO0m0H?=
 =?us-ascii?Q?JUjR4J6DSp80h1DbmLW3m76HIssRJQpgL92LJLGqRzQJ+TkwKDYhfKQlLhog?=
 =?us-ascii?Q?rgEqWLWQsKNlxPiPbLE9NS81RCxNQKsswcQkaXm3fDVbq3GuRuZnSq+5RMF2?=
 =?us-ascii?Q?ubKymRRPBzh3g4Jkm8b61QWZXt70ovbVH3xWr5FxS6Vv1yrmq2QwMyf9tTNo?=
 =?us-ascii?Q?78FIehqifwyhPpD9tSC8mmrm22nfGDMgWP2ze9k8LUIqCcPkUUOvT/Muq73z?=
 =?us-ascii?Q?R5RC2i8s2ax7QkM062zzZlwVsaJUEjjDi1u7IAiLM1OHLbERZb9mnrv5brqc?=
 =?us-ascii?Q?do+OsLutNf+RQ6lYqKICV/4SCtnUg7FZwREtQJ59?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10034123-028b-4179-de15-08dd3971a0cd
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 16:43:54.9738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lm7Wqe9jaivX+Ee8STKMTB1aeSzQtZAV8UinWWAaBGGkAvw26V/YbnWAl4RHyfmK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8645

On Sun, Jan 19, 2025 at 10:24:11PM -0800, Nicolin Chen wrote:
> Though the padding could be done by the compiler, add a 32-bit padding
> explicitly. Update iommufd_compose_fault_message to set it explicitly.
> Also, change the __u64 addr to __aligned_u64.

Mention that this also leaks the content of kernel stack memory to
userspace since it was never zeroing the padding.

> Fixes: c714f15860fc ("iommufd: Add fault and response message definitions")
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/iommufd/fault.c | 1 +
>  include/uapi/linux/iommufd.h  | 4 +++-
>  2 files changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
