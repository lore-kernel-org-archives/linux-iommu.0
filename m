Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BED7C
	for <iommu@lists.linux.dev>; Thu, 22 Sep 2022 17:23:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gv4bn94LczHm4OyLG5qbaiIMcJ0V0TRCGpGTWfZSmNFNz1Bb0T1RMXozoksFoKQJwBJna0Ft9SXDw86fyFSlonEAEOaDHzB077jvAN6lfhzwmbaZnz7aZfNicSSfxulC7I62TPGYMzbE+WwdFxg1kVvsapEv571GVsmonAFx8ZX1pFJ+o8a94kuVV4qAUjuDIy2yzMGlk3bJgrzwYwZtX5t3Uu3+V7Hr/aaarMQG0gkZ56a+Vm1Cre/W2Bu0Hpc6VDJBNu3jipLPbR0ZydJWvRQ1r83UNnDy1runNxsDCWDx7Ol3XB56eWBksYiiicWWCNT00rhiU0Mo0H/nHrK1Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gzeSGeu/R018IrSfk7v5xNcf4zPHoWikeO3MbilyvGA=;
 b=dD+YA7UM40s+m3mdjzfQyXmpLEQZuBUtFZz35oeKI7PQ1vSoGpeFaDwQhibLVr1ctSUj/AqkpxJyVuHgslfb/BymNdyPxUg5GNyyFnCvOPnCuoUJBS45y3YoXLOoupy6sJLDzV+YCJZozogj3dvaS293PLSqmVN5/WrTIN5DBRWy1IDGcdITZX7sHDzKBsNh/89J2bDlXzdfKT6G7DzAMdjZzSgsBnjO5vlQovFpGcu3WwECZLo0kY64MHJPTtz2WRkZbyMr5uyByWHw5F7Bf466rpEAiQex1w5SxZ2u8vPHbbml2osEEZ2FCcNFP+9tqz9z3bQo99T+UpoEO53/6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gzeSGeu/R018IrSfk7v5xNcf4zPHoWikeO3MbilyvGA=;
 b=H5Zmxqy0FDwX07AzqkfDMTEJq+Zuzv11RvnFB/1d0izaG7PphQvh+GILJxpyzmy7K05TaANiDN4EJGp9zAZ7E49LkCcTD5Usxmds2kgaCJvMoTRSNLfzPwWCrVzh40IqHi62pnK2PYZBiA+u7ajbDUgQXPE8hkXTdGk2mpL4xrkwW/s1TmmrU6ej01BtgMu3Rnsowf5LS2h35K7qU4hS7FLIGud7Mfo6ba9/bAZ2ZgUoDrbMU/YTk3FMJWPrMJQI4mNTsL7BUJN2+OxLagg/2lfofW2nBtvA2v749ocGce3tDp87+MwBTJ9bLKVocwMGV22Vb8CnZ2bHhB/jpiyPQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM4PR12MB5795.namprd12.prod.outlook.com (2603:10b6:8:62::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5632.21; Thu, 22 Sep 2022 17:23:54 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%7]) with mapi id 15.20.5654.019; Thu, 22 Sep 2022
 17:23:54 +0000
Date: Thu, 22 Sep 2022 14:23:53 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	kevin.tian@intel.com, suravee.suthikulpanit@amd.com,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/6] iommu/amd: Drop unnecessary checks in
 amd_iommu_attach_device()
Message-ID: <YyyaKTN0ja5q0fFz@nvidia.com>
References: <cover.1663836372.git.nicolinc@nvidia.com>
 <b7402679fd29226d544ce6e3a31032c0d5656b34.1663836372.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7402679fd29226d544ce6e3a31032c0d5656b34.1663836372.git.nicolinc@nvidia.com>
X-ClientProxiedBy: MN2PR04CA0005.namprd04.prod.outlook.com
 (2603:10b6:208:d4::18) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4192:EE_|DM4PR12MB5795:EE_
X-MS-Office365-Filtering-Correlation-Id: c18c114a-010f-4867-3ab0-08da9cbf395f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AH7PnWRuRkOs2wn6qhy6+2l2vTj/1R4tBXwsUepEI7MmQEu0lL4QwulRp5xRidZx9f8ienBd9Hr+O4gm2lbU5MaSOTQNMt7RKU2pZyEaNxjnw1FZSlgXcbGsYw0vJGjXfqDjVsIJAMElkLfSgLYUm/fXhUtXzmDHflphMgf1MA5PNf/JSLQHvFHNWajMxlAYaNO/WrhDV3LK/QgtrJjsTrsnfCYVQ4IwsVFSYauopikuSI2+tdhzUWuksTBEbYSd4r2YqVUd74cUa7TGpFTt7q44Lo5Yb18reJqKzLRa73HpBTCLCjEHE+lTcPnUiy4Ox58vPmxj50IGZHGyl1OONy5z0bDJ6Whm3UtO+zhMj/HWUuRTfM7rLVPHa6WTgfwxd4GiRobEUyZikNsG6Fc3x7OhOm1I4TxrZUV837fiximYydARGWAThQ/r+9EYvIjnKkcbbiNYNwqV1g2cefvdl3mo7U0zQq0pDC1IN0ps/4nqyRfxCqtoOAyKS3Iut7kV2v3Dapn4DLs4cGtQ0u0GUjaocNRngbYsMQGAaMf732W2/6XGS0wN3qDXh7dH6DaeSSDThu+ivDQj7dvyre/PG6Ybvehr5RWHOxZwxP6xi/uOqTymfQXAgYvI+rprxQB+ugrJmefMspCClknFuejmM9jgJkzujR/XmAQ7RfzWwt0gUDhgpkdE2+D9dkfTQ8N1cn3PmK5Q9ApNfjMQBoH4gw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(366004)(136003)(376002)(39860400002)(451199015)(478600001)(26005)(86362001)(41300700001)(4326008)(6506007)(8936002)(36756003)(66946007)(66556008)(6486002)(6636002)(37006003)(8676002)(186003)(5660300002)(6862004)(66476007)(2616005)(2906002)(83380400001)(316002)(6512007)(38100700002)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?He0C0U+EuLm5MGtushvRuaJStYddGsN7IjWjBV4YggjhylDGqCCPqeXPhIfQ?=
 =?us-ascii?Q?QvSd8IH5ZfckFbm8PBe+zjaaJdq+x8XmI43k8Qcq7TrY527N7Anu3xtHf33o?=
 =?us-ascii?Q?qMfz/CBl+BrulFn4KgWO44mmGyq4V2M+4TOjeDEbP8pjAilflfopoR4e5CJV?=
 =?us-ascii?Q?IZD48qPqCdkcGRGETBT9RZ3HAR7ZHPuanGzZJNP/rxPJgClaRYq7OoPdW88+?=
 =?us-ascii?Q?VNMryxFAxTqzlLHKk8R6iA7tlg3EQ4PxONywEmrln05S7j2LDRapdCH+8BRo?=
 =?us-ascii?Q?YvVWE19iRtBm53izECxlnyMHH40yu2bAUZb9Lzp1Yg/+ZLo4k1xprvSofZwo?=
 =?us-ascii?Q?t47V1xz1OeqfEd8VcVly2Bj1C2/euRuwjKCXzMnAWf9/hISjCZf+K5nAGW/q?=
 =?us-ascii?Q?7PyITRe9WeAeWGhfMpIuexp3VIkKBS4Z72fYY4oYIGDuB5lb0nkOB9JatlJI?=
 =?us-ascii?Q?ZNqulr5bNDSacaw8D5dZdsh/sHFfVQ+BbyDhiRsMfZtGvJ5XONaZMWJODi+C?=
 =?us-ascii?Q?wLnC9eKQK0vMk/Od0BpP/nC1z6jZ1aaaWKobb2bFoJBe/CEaRQ8QCfecjGjw?=
 =?us-ascii?Q?PmZUwV4RF3j4uNf6rWdUlXeDHNGNa6qnE4G//adRSKeCmj94ff7OWcAQlPmj?=
 =?us-ascii?Q?YCI+Gx/RZkr/AnbDiTX9y3x2DiL1szURnKCkloyqKuAea1ufdb7dFIQJwdff?=
 =?us-ascii?Q?8USxOXSu9LEFHQ0Ha3jQaxfx8k5RDlj7XQV9/PZvHoWpSAAoMyMBqiCEdXfK?=
 =?us-ascii?Q?+DH0J94cNqNbvb+8gSqsY4KWRZSPd+6vG5mt1QewgtRMhE4kYIc6AUvz4+p+?=
 =?us-ascii?Q?kIKoQ6FBS6yJvOk/EqVnTO0ZRCUYXuy0Wg1/x7bYh4Wiec6SxzYpwB1knt0N?=
 =?us-ascii?Q?uo8rshjA/T/jjSpfxt8Ub7rS/Qrk5+ZNd24zTTedgCozMtBY7c470dLkNfeN?=
 =?us-ascii?Q?SIZDJu6F7aN+zrxA4SYATG8jJCemAKt0Zfb/x9eKRWIEemz5esZ+7nT5CAkW?=
 =?us-ascii?Q?zmx4VsKtoy8t5oGQmXCGroFWZm0R4etKRHzq/+lZtq98rISnnCo+qdmtjgu+?=
 =?us-ascii?Q?ZJ8S/stPfwnULplL59Xtz5fd3DZHgqvqLXoY7FnJOU/Ca3CXCalL5O+xnYt2?=
 =?us-ascii?Q?3Xm09oOss32fcRBecmJsRh/zyti4fh4FEBlUZGE1HHve0HCQA4MyRYxPfswm?=
 =?us-ascii?Q?DpwAyigXrCZT3jDnTLH9w5z4OewzH0t+EIntQ6wugUvodQAmUshQ7XnVGzOv?=
 =?us-ascii?Q?bOLfJo0D3WCOinFXqXIthU6Oqm2wJKOV2IVtAV4y04Jit15Mwv6doDMlzHm1?=
 =?us-ascii?Q?TdOkUJAaXUJqkCUCcegiTM+xidwS6ECAWMUIftGFHt3JmMpe4x2Dr9phP/wv?=
 =?us-ascii?Q?ZUk8Zxx/2hFcDACLOgZYupstMq7jdmagx/Z+mFTYZF2JTEel5Gh/vKQ5N6dr?=
 =?us-ascii?Q?xWNs7M9YWRAt8+lYQwr65HrCCZLuGNkF/tPFUyR8E8FTR4MNbLMIncVufqx3?=
 =?us-ascii?Q?/CSJgu6N1OcL/lSPU9QoFdT0CBNMS7lY+9/qY5q2iQeuLwnA5hnVZYxKWyij?=
 =?us-ascii?Q?9CjFueD00KRyOE9W5AcOi7bPFIhxU2Ztd3tw3yOa?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c18c114a-010f-4867-3ab0-08da9cbf395f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 17:23:54.3293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K4mGBEaiu1G20uVlZ65EO60C8WPSVFAPx6eyN9GtMxfZdELg6PF//LhoWw8DBvhH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5795

On Thu, Sep 22, 2022 at 01:53:52AM -0700, Nicolin Chen wrote:
> The same checks are done in amd_iommu_probe_device(). If any of them fails
> there, then the device won't get a group, so there's no way for it to even
> reach amd_iommu_attach_device anymore.
> 
> Suggested-by: Robin Murphy <robin.murphy@arm.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/amd/iommu.c | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
