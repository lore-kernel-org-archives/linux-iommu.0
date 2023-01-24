Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2058.outbound.protection.outlook.com [40.107.102.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FC46FA1
	for <iommu@lists.linux.dev>; Tue, 24 Jan 2023 15:23:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FD20flRsn+LR0JXwHPt0g/6qcEtFkHP37YoA4foJ2vTWHUtidDjlRS6BlzWWxs7De2G9d+Tgfs8CHliLsXUpUMsmQdpvLZu7uJjib2m3VkNCAAiG68q9YSHzqbmdY6RRPAaBDJEzI9KbBVIcvwaNa0FOXshosinQN6OeDB7dEoteFPKkYESPQS+LloA1eXoZxrD42980nE5BzASo2QLhna9yMNoI5qlKVa68LC0qtiw9fiMs3+34WQFOa4UXkIfQ0qIIh0V0mPoUrFhUzxMdBlst/l7CC0dI7Z/3quZdU8jG4LR1dio96jiK4YAhg2F5iK0J9/COpQKrLiK67JalLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YJiGbIAOuiLC3/LyMcXz0i4qE3CnMauoRlCzgfsXASU=;
 b=dYwwv19jUJJm2xzXyV9QGHgtD/8txqQ0K6RbDYYIIUFuIGH+IBHBzURsVI+S1fqQI+WjWRRg3bxc0o7ibcWaP3MW/PCa/ZKax6xtT1PcYYE+7fSytuvVe29HUhTJmmxxTbh37NSTS9otjhomuLpVqzCfokhXkxKeBxuAv6u3M6UMric6uoHzucUQwluLeHPjN1y4PmcpWBSHxOTA2KYzJeSdkZbF1HgPE8ImkbVTothVd29axPMkaeAUqpFaOFoVRu8IrlVUBQgjfkai4WTlj6hPLKfIDlF7mVcpzkTqSsoe+SkD33xXNZSxW0QCIZRyxgXp/afnSXJFjxLQqjU6ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YJiGbIAOuiLC3/LyMcXz0i4qE3CnMauoRlCzgfsXASU=;
 b=fIM5G2REOj2F3s026s1UTJjCQiE4z1Z7+xcTRvTvXU1mda+JtCyjT1PxOI2Et7JfWWzd6xobg8OeouTKjoaJold+7PGeL2xwfVkOrZF7zf5J6+/J5ArX9NcWJrQAtkGh9Dse+Xsp0XUcQ54S01xlYbZDTibo0goQg3LBWQ0Oyaqj8aC3MMGFMTWNMs93iENuihlGGdplh0mdHVxm3A2eQruiH7g+6bVXLgjFVtFrp4vIuB96Enm6mXBo7Dg0cdbg2IWUnot74hu+0gokKVNqgedTjW47QVsDZq9R5KzUYa4Dc8QU/gRfIGoqocefTR0vytGqi1Q46mngQHaWgkMi4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB7591.namprd12.prod.outlook.com (2603:10b6:208:429::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 15:23:07 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6002.033; Tue, 24 Jan 2023
 15:23:07 +0000
Date: Tue, 24 Jan 2023 11:23:06 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	Daniel Marcovitch <dmarcovitch@nvidia.com>
Subject: Re: [PATCH 1/3] iommu/amd/iommu_v2: Fix pasid_state refcount dec hit
 0 warning on pasid unbind
Message-ID: <Y8/32rScnCHTacQT@nvidia.com>
References: <20230124104355.119166-1-vasant.hegde@amd.com>
 <20230124104355.119166-2-vasant.hegde@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124104355.119166-2-vasant.hegde@amd.com>
X-ClientProxiedBy: MN2PR01CA0016.prod.exchangelabs.com (2603:10b6:208:10c::29)
 To LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB7591:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e1e4190-29c9-4a8e-6ca8-08dafe1ee52b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UdQb2AYZMpRUBRyX6Qb69AYDrPZ0JW6vLgFvDMYivFaqhZ9xDUZS7QjTNM7h4ntV5RpfyMZ/+zSpAWuhrRIqoWFDvV4x9kHx+cLZB1+0wnimA2+lxsaUPEQpE9DQgZ9ZrE3e/ScDWgvj5SSFo103LCrOSUWNHGjVpspal8nWOtHt1A02l6BaPCvT8LxX1PZZ7wIMSiAJ1fSrwoVBHTgiHsZFeK+KHBj1uaYLTta2g3sglu2P3a1KlIufMjTwc+X3P5DgLlfmp/YrYNrBvWoVXTnQm4FYnYWlWXXPSF/tDj9anlh7d1Eu1JWsTmOzXi/zlmieczNOtznuydfakqcbi8lVRAaxWy6VhporKpFAMZi4ICxu4DdiJivOgcQCIFtupp+0WT1pwKm0wIGdqJmK51qpwBYTBB2thYDKCOeEsGU3dbOKoNpCMaR8867MZk3WfZhnfX6LDoIGhb7L9v4usr9K9Nq+9Li3J2tzMwbh7TaA4IYwfthzhL72UbJtv+lDwwmKRZIO6GyJcHJuiuiiLUi5GrBXvTfTDISBADFy2pHoLRKMU+U50igRESXxqmaf5q5/uNjbCxtq3DgPdtbt8huJBdaDOuZmFGBzEr5qBPQN9e7f8OcZwQId9a7f6QFfeoBSxtBiXWeLLq2ENu0qLw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(396003)(136003)(39860400002)(366004)(451199015)(2906002)(6916009)(66476007)(6486002)(4326008)(66556008)(8676002)(2616005)(5660300002)(6512007)(4744005)(8936002)(26005)(41300700001)(107886003)(186003)(6506007)(66946007)(83380400001)(38100700002)(316002)(478600001)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8cjySP+0spwYw5vuy7CGnPr0Cu5J0ofYkldEaY9a9N8t0ojZI+1P2dzOTi63?=
 =?us-ascii?Q?aAqQ//0jRtSJkvaX4cK3S+TtgmMtn3R2KmRSJ1pdmloCva5klkauXBUx9TDm?=
 =?us-ascii?Q?q/uzBPHG/pM340eZm/hlRk4gHHo9u/7iuek7S+jyWIu0gie8NHh8URw5qxpy?=
 =?us-ascii?Q?1k0Z0VMtOq00sYDAXrcOp+jwQf7cFsgeukfEHP+PSLXhMCMZFUnDMlXmFaPO?=
 =?us-ascii?Q?uveK3Fp4eTO/79COfVZQzvKTqFjfLgB/FvmPoniLvnzWEvh3r6Xn8bVtMga0?=
 =?us-ascii?Q?ayyaheVNgz2XVLbEMLEeSKaiWZildfm4inZseZQHq05KjMKFUvrvS9NO+QJs?=
 =?us-ascii?Q?AorfJtSgedsxIXkwvjL+bxa5wFdeDf9SqRCE+OvUSzOsRWhzWOojD2TWFK4l?=
 =?us-ascii?Q?jqlpQy1xbrSEBvzFNyj3GjbsjSXVSCjS0EPrr0CzA0kCh1xeI73Y/2sRJVMV?=
 =?us-ascii?Q?lZAPewWjmOw6skw0OqRjbS6ettDw4I6PIeiQCm/xHFpMOZF5DstXhGnm9dZl?=
 =?us-ascii?Q?9Dswt5lqVPfQ33Wk6biRC1oBAUoyKoM9PTyt3SvhYGyRxmtDdY5Eb+SkNk8l?=
 =?us-ascii?Q?1MfQEhWFbkwpcw9j58UvIMRDBdufsDXkP7hcx6g/78QSPkdf3JJW8wdkjPl6?=
 =?us-ascii?Q?tNNt4xXhFSxOncmb/z0uZ5znCS6m4vV3l9HybDNB91EnNK4RIgVP/ewSmXsf?=
 =?us-ascii?Q?VhPzW4W2UgpXIrpG/O5DXexOJHpaahdhblDbB11liptXyvA+ySluaiXm9J8A?=
 =?us-ascii?Q?hlo7GPCiF0cWhb07fzMa+5J97GV0swYO6LigAfytt8jzq+/eBQyo4C3/qZhz?=
 =?us-ascii?Q?huqynYcjiicD+nJ+VjDNgFAycFPefeOjfv8cdQmneB3mX3cinbCQCMHvIRPr?=
 =?us-ascii?Q?c+/Xn2w+k0uzGfyWJJTKLYzAkswTI68OaVKXaVunkF89iWcOVgF38bHItqW+?=
 =?us-ascii?Q?Ghh66SARlZKNho1CJJXTuMaTTxaYKEbfvrR4JOK+AooXwM2gD2VEM2u3wk+w?=
 =?us-ascii?Q?qizEjR/1yiZVA8zwD+3qsI4XQ+66eicK3RpiLL6l98ypR95odjJVFwOuBiRt?=
 =?us-ascii?Q?ZuGOb7uPe8a7sgXHVMEOOWR+3bshWLaJCGazNqin0HjPcAoNXVNNOaYkR3w0?=
 =?us-ascii?Q?3zBsgyY6rciV/yfqg+OwEwNlD2Gl6fRpBCt9Ap3yL96YXOkkWJcjC4Cldxdi?=
 =?us-ascii?Q?T6I5P5zMcRjQt4XqtDvbld8o+CWg186RBWzl5KqSfgkCftMSQmFl+We61u1J?=
 =?us-ascii?Q?lVFlaDaugTDRmW+M2vsONGhmKZfLvGJnyMSaEwP9hIL9yloQS/6DnTgoDiIK?=
 =?us-ascii?Q?dqQ1TqEHPv08+5as8euz0p0jRkLYeSIVXF6QMoO4PfzbCkbrxe8ZcUn73DCe?=
 =?us-ascii?Q?aWB/u+nv7YgFrp0OTZ1W0mmntZGK/rfzKEso/eh6rEA1dqYph+bKbWw2T7mo?=
 =?us-ascii?Q?LN2KMAvG3w9W9MVRBwRaKmMQPAsX8Ky6XVyag24hy64VNcxvzdd1Ir7Gfb7b?=
 =?us-ascii?Q?jMfJDqDQdoLBWw2fXhxYI4AjFAMI0wUrjoPs31PSvr8wqRpvrQZb9TDPmD4U?=
 =?us-ascii?Q?YixDobB4HNXVHjTzaq20jRYe+6UNQ5ct/yfPoGnD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e1e4190-29c9-4a8e-6ca8-08dafe1ee52b
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 15:23:07.5054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0J8oeK+DNybhbXpoPrPXuOKsROl+RRUdIhEqvP5PKzDDSMf7TYEj7OGfuBJdWmoP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7591

On Tue, Jan 24, 2023 at 10:43:53AM +0000, Vasant Hegde wrote:
> From: Daniel Marcovitch <dmarcovitch@nvidia.com>
> 
> When unbinding pasid - a race condition exists vs outstanding page faults.
> 
> To prevent this, the pasid_state object contains a refcount.
>     * set to 1 on pasid bind
>     * incremented on each ppr notification start
>     * decremented on each ppr notification done
>     * decremented on pasid unbind

I've no objection to this quick fix

But the issue here is using a refcount for something that is not a
refcount. This usage model is should just be a normal atomic if it is
only counting the number of notifications in progress.

To be a refcount to have to follow one of the standard refcount
patterns, ie get rid of the event queue and consistently do:

if (refcount_dec_and_test())
    free_pasid_state()

Which implies the ppr notification done can do a defered free of the
pasid_state.

Jason
