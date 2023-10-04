Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F19134A2
	for <iommu@lists.linux.dev>; Wed,  4 Oct 2023 12:06:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O1NFtbrmgLE0Tf36CV95Taz9iesc27xT0REGcwBJ910KHY9rjpmk5/rjovtO66WG+fzTCnB7ZhEH3DBV1YLPHQZtBiGaZIoC5WWkEFN+FGumFtnIAZTrxg44LCeqYILUIZFN738n+cByo6OesFvmcNNNHofiervRJoEYTzq5U/yVFVMAYPqCbabLfd9Din+LkcNteB4rNrSsf9abSZpVvNAkHIz7IDaLjv08ZlEaUNJej/j67Llsj3PE3ntQIBu68jMmLz1TkEXD2BJfYqcFb2zovQ4azQ7kVhnEeXDiYa6ZWjjalw4fzrdE4e97GoquJKpPKjkuDkSfcGnejzEUtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i8J7PEKSmvCmzRzVeKazXJJ28sScksIBv4l1V2qpFmo=;
 b=PsmbLJ6QrGkaCfJCgcWGZuadI2DBMPoExfOHArnSep+pHa4i8pMY/MoulJUn+mbr1r4wkOgnpLy0myZHD8fJv3h+SRMr16KAYW7L3qDEkgqzh/hrCoZzqISsiiRnqx+iVeOW0Dgv736MHKUG8db3zYF7w2ZeUmtHSoSwHAC2Dx648+2vqky75sYbaDtEr3goNBqf44KbAwJxGaHs1IUUBDeVPaAtfh2+ytGX4zperXjGG4EPFiNESvTDdrTuJel4NVn6JDJwXq6HOyYpeVjMZzhYRf1kkQWAn6Nif9/fkfsv51ra7tFn05rXTEhU00rhW56Zw/1Iv5wD9c/sLOc4/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i8J7PEKSmvCmzRzVeKazXJJ28sScksIBv4l1V2qpFmo=;
 b=TrppIIw2QdSrJTnp507tlP445+G/QIp4F6uGgnCkZ+vvq4+uvHNrDWvx/Se8Co6uBb1x8j/hcBH/MIa5MALNyEZr7zB6mPIVKrjvbQ1G8H2inkQKZJ3hn6ZLxgwCoozvx3AaR3U7STxvo8PBP/z/dyCGYmTAdm/jx5og+EgUA7J0WH+4hEbyOiUdyLk9o3g7MgbjUp6ZnOWcRphLv13PAaut2yYy2MflUPbZhuxHnxc8sz/z6opczSnukErwfy2BRKa2WdneVMABUOnWa/G+4dnNzf+/Ei7GNQhe5nSJnhJfDzXEcN9K5IplAz8aiUAOM/ewePteB+qQ3CEbzLLyiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ0PR12MB6783.namprd12.prod.outlook.com (2603:10b6:a03:44e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.31; Wed, 4 Oct
 2023 12:06:46 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6838.030; Wed, 4 Oct 2023
 12:06:43 +0000
Date: Wed, 4 Oct 2023 09:06:40 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <jroedel@suse.de>,
	Jerry Snitselaar <jsnitsel@redhat.com>
Subject: Re: [PATCH] iommu: Fix return code in
 iommu_group_alloc_default_domain()
Message-ID: <20231004120640.GE682044@nvidia.com>
References: <0-v1-e4bb9f78c084+202-iommu_ga_err_ptr_jgg@nvidia.com>
 <39c620e7-86fb-4372-ab0e-9f772cdc60aa@kadam.mountain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39c620e7-86fb-4372-ab0e-9f772cdc60aa@kadam.mountain>
X-ClientProxiedBy: BY5PR16CA0025.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::38) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ0PR12MB6783:EE_
X-MS-Office365-Filtering-Correlation-Id: 6da774d8-729c-4c3c-5446-08dbc4d25fe4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xH0OcU1k5MvLXzhrH9bn5cb46YZw+UYKEhBuCAzwAJCBlgL5jjFZq3AhIzhYyMtv4iaWFPPSAUDwY8Hjxb75w1Bvx0yHeC641HM0WpBh2xUE7se/WEXQqkW2YBKNWvE027wdw3hAey3xeW0ZKsgQS6ip9PmfTupEWTGAbqToVd9hYZWSRozSe8ArESagOXaMGQ7QJ827tsYgcV2pKa8aJYy0n5Jkh+bNR5fliLaVgq1EguqMiDBAt4cUUnUfK3rBq3a4z83o8XzoyHpvXO3ykDieo/lSi2rtWV0hG+vFWI7M/Do+ZV+YuT1e4RG19VfRnOB3aJY0pcqXPXGO45Hsg/YqVSCrbVTkLfChf5z2Mtww90SzAk4yQrZAj/CfcYQ6QqNF77XBXtPw7crqChcp0/r9fyB8GYNnuTVrqLYlkjlRV6Bc4SjsB0IHDQMhW0beTSaWS1sRV9dFf59EvmPXM6JPkx3adP0adxpCU5xmehDUhavBcF0eFLN4YKsjGVLChDR0iOtwkFbC08vBUCM5NotTlw0bSFyKqndBWjYFdMq3CWKAiG7PNbebEkxzG5hnL5ssTqEbpF4S70s3kDWVIYKaJUGvEKqvvx/WGv6ajhQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(366004)(396003)(136003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(33656002)(66556008)(38100700002)(6916009)(316002)(66476007)(54906003)(66946007)(36756003)(26005)(1076003)(83380400001)(6506007)(2616005)(6512007)(966005)(6486002)(86362001)(478600001)(2906002)(8936002)(8676002)(4326008)(5660300002)(41300700001)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WvHQsTfTAgWYpP2PN3+qDbIh+mmv3PEENahjJVd5sMN3fMaIPzO96jpDeM3E?=
 =?us-ascii?Q?k+HZgT/wu48YvvdQCnhp4zK+7LjTIVDWJ0eAYoE9FAR/L5nT+FSrlopT2Na8?=
 =?us-ascii?Q?HDD1RSRM6L+mP7lKRRUrxM5R0NiA+a4M4ELuk7D7CtWO6cKTBqdc8ztfYySD?=
 =?us-ascii?Q?mN6sZDYfA9pOb5oENZ5ofJjX9XI118UmX/qJLfwaz/lJoERHq9aYRwIc6OIB?=
 =?us-ascii?Q?/q2WgEpp6tFRncFBq9BJ+um5ZKw0OrVqWfOhDsY+xGHGo/XE6Dq6BVQORzEu?=
 =?us-ascii?Q?CmP8lTqtng9R2UxZa2cLBAiRt0sIP3Ev/nUtCfcPAekEi0NYnm/cliYaGC9l?=
 =?us-ascii?Q?S1jZ+hblFcBFEt6IT3B52qDLW3ud1vfc1NqeJaWpzJudEU8MKLsIFVDJbvEz?=
 =?us-ascii?Q?4Smtw1fBWY8t2Ncba4idr63YaxZcsHd4gC9Le7hc8LFctyNKb1XydnPCGm9v?=
 =?us-ascii?Q?eFnItJSRC69CP6phHsIamEUuAiyTP8AHYNVpkwC66kvyc9EE+mEilnOsMMn9?=
 =?us-ascii?Q?SCaUgg01im8kKbGUN6TVdZk6zqBLJ9ZHDDMRbqHQQspUmKRpBVBVJlf1Mz9s?=
 =?us-ascii?Q?DdGSiSCIuso2YrS34+k6QmuDBIzGDP5hXET4O1dsaIxtmsTxcWmi5qJC2zb0?=
 =?us-ascii?Q?xBjsUZsaHKej92t0rCJVw4EF/1Ubw7w5QRv9YPRQ4O8i4Wnz9EMMtldTwXB3?=
 =?us-ascii?Q?NX3Xb3R0bfJ5i0uKj+hZ/3rC6aVj4Vq4QWPdHK2Cd65/bUtUuUT6gEnjgrQ7?=
 =?us-ascii?Q?g8jlGZgaDBLEiUHZy43BpsLhkePnHyzawLcfRg5NiChA9ZrYwBk6vfgkJcQA?=
 =?us-ascii?Q?A/RvN/+sYM0CzPDfnGSIx+OaCByQ2Kw/bwl7iKS17QeIPQ4arcy4eyzT9sHO?=
 =?us-ascii?Q?bE3/s4s9Qtt9J0xFQZY5WbvLYezpkKZEdJ8i0HBKg6H3Lk/37ehCEIQw/hEC?=
 =?us-ascii?Q?6lST1qAARpVpmlSM7BiOnp87heKN9B01FDAuntsX+le+bfBVvdSOQEKs5pV/?=
 =?us-ascii?Q?ZizULZbB3SJuQBALspEelD4OzEAghpCXA1TmIgurisKI1n0H5ATQda+IT55L?=
 =?us-ascii?Q?50OWPCcjz7JJ8VAOEJU7r4cznVcyZ3qlN6r0gWRCN3ImAs9ggv71V6lri6i2?=
 =?us-ascii?Q?qZJ0RFFmlgwqVFrnuwdq0H4T+EjSIwFNtoFqMtish7uUE/7pJVDea2+MSuCm?=
 =?us-ascii?Q?F3S6YoRPeaCnw6+DXz7E7WKURvsH76GgX9/HLd8N00LcsGM16DdIJEqUMc+d?=
 =?us-ascii?Q?HHbj3x+d7lmb1fwobxbNkzXJN4kYJUwvHBDKKc3ahqJu+zJymuBITxDThqjL?=
 =?us-ascii?Q?NmJqGwBp+BMGJErkRDbvuZJj8NX6o5SVV2x7b0CCPsFmN103Iuo/BNbLYdzy?=
 =?us-ascii?Q?pv0OPfdKDZx9yw6c38+U3kP1JlKGy21xKa9o2zvrbkCSV7ZC6qnMyW/mjwaN?=
 =?us-ascii?Q?umP81ir/wTxJYpWSnf1i2ZJK7NU6QR+SEqb/mouJ++WAIXZeMD+5iEvfWjvO?=
 =?us-ascii?Q?iGi9vhVty+YBik2ARDvJdvNsb999ORw4JawvhrQ7e8PhBOLzQ9FJ0vH8nmFa?=
 =?us-ascii?Q?Nptz33Z+SrmG1EBPWlU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6da774d8-729c-4c3c-5446-08dbc4d25fe4
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 12:06:43.4919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 90wfT5nwCO5HiHacZX4yNKBuJuOfzx4nCurUPkf+0cuxs0f9UMtMWcpoxc5Hjvz5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6783

On Wed, Oct 04, 2023 at 03:03:41PM +0300, Dan Carpenter wrote:
> On Wed, Oct 04, 2023 at 08:59:43AM -0300, Jason Gunthorpe wrote:
> > This function returns NULL on errors, not ERR_PTR.
> > 
> > Fixes: 1c68cbc64fe6 ("iommu: Add IOMMU_DOMAIN_PLATFORM")
> > Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > Link: https://lore.kernel.org/r/8fb75157-6c81-4a9c-9992-d73d49902fa8@moroto.mountain
> > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> > ---
> >  drivers/iommu/iommu.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > index 13b911e4323d06..f9f315d58a3a14 100644
> > --- a/drivers/iommu/iommu.c
> > +++ b/drivers/iommu/iommu.c
> > @@ -1787,7 +1787,7 @@ iommu_group_alloc_default_domain(struct iommu_group *group, int req_type)
> >  	 */
> >  	if (ops->default_domain) {
> >  		if (req_type)
> > -			return -EINVAL;
> > +			return NULL;
> 
> This looks like a merge conflict?  -EINVAL is an int and NULL is a
> pointer.  #strange

Uhh.. the power patch I was working on accidently collected half of
this change and I didn't notice :\

Thanks,
Jason
