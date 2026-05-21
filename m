Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011070.outbound.protection.outlook.com [40.93.194.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EB13F65EA
	for <iommu@lists.linux.dev>; Thu, 21 May 2026 14:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779373812; cv=fail; b=V/oKlkuzbN5bTXLmL2HNPFoG7lV6L93JIcQu5ffyciCqmpqfX+CrquOODmSeAjhY3xPNH6XxSzyiNgVq3zvRclAime801INVtSoYi4ftyBqHgFV9Hodj9qA1TfnThmTk7PBYAXNIQQ6fi1WRM2A/7WrX2UmY6Ykbob9Jh6zOn6M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779373812; c=relaxed/simple;
	bh=LnBlqJSuJsS53aMinv3Ghsa8qQOicYMP33PA0ZmYt2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MVFgk69iZ7ZkcFhpOtxiB3Gs4dWCjTFXWqN2GTfFrkRJA0T4pvykLZY+4LWzPOaMloVjLTPwf+bxA9shitsMFh0IvxtcLSgaiieeYwtFtfQnraiuTaQpgoI8Jyd4rtulwzXnk4xn4WBpj4zhEX3Bd6znsqAkGcqdPvNc6+Aa8Sw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OeNOCVXs; arc=fail smtp.client-ip=40.93.194.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OeNOCVXs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kQcnc2GzoXX+3RcfMUEggWXy50JH2HDjfr9sf07XN+pDUHQkK92aZ4pm1dRyDGed0PSQZGDSnWbaZ/lkRMSIyyi6xqnp4Yy0unvOlqsdXLk35U4wBzRA7hnclTGwM1MFW80zmzsKLobrcdGzANROXVfOsI61bZCuWNzdYEVVwqhAS1Ax245zl08GzDiyZ97WBnTFnD09x/lRQynJoWRMQFpvbb5n/2ynptV1G0aRUa22bZuvzM06cfvgD0LUTnyqz1AcOmZTNd6CMpNtbCQHObv69TlgATIp4i/JLp5V6D10Fx/WEmUZtZLm39UeNhT7R6TPnIYlVuoUwI7KplTWVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/bYP18Ifah+N8ZxUj/5MTRs0gjRDyYNosMgp5FrGAoA=;
 b=axtUIHAMqBGJoaV84ZCvYnRSI/U5AQdIqmM0Yf0Mr6XU33XS77ghMtj9ChZGmaRqsyJYlniygX0qSwCbTW4JXVOPMWHn3bVVjPT6ur2ApmvZpTnjFPYKXiVzJnf3D1h1gVqhducjs8MEo3dxoxhlWlvW2vZ75PEzstDIGLxarQhCrAXOqGCq4D92rIBSjp6Z5TIfbK5MAZ5bIucsY9nfmAz2OvjJse3L1aYUNVc5li7zPHDDBSui02J6KywJkJdFZZEGpo5FaRfDv7Aax2qOB6W84dtEF4+BZYsykgSDFURWh30Kaj/glFYf7SNcj1y3rCrNsICJXg+h/Q8BWPPVCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/bYP18Ifah+N8ZxUj/5MTRs0gjRDyYNosMgp5FrGAoA=;
 b=OeNOCVXsMPI9NkFFvOk7SRnTtZYsYQSHa4QXJ3Mxpm/2MTPAGYWFM6xDo+4C6hnUZXrfww1hWHKRtmXE8c/sN0wjtDjsFe7e9zOanBIXg29/49ZiE/apIB0rxwXGYZeKvqq4vxx/e0RwtBAMGfc838ljIFDiVY3ARGv6WDJzUZh0onnEXJM5QhOD/e/9SN73zT/bxUGUf2REL5lx3NdtEzILXH6yGDEHJIZRhIMVP62wA7TH1fJn15R8fdof986a7rOtUTOZn+2+tM1a7e+dkxzTikkGGLShQG9kS8wyFo3eYszwpEE8Nra0udx0q20zvKwFd1czUK1/7Dh6ZUuAUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DM4PR12MB5986.namprd12.prod.outlook.com (2603:10b6:8:69::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 14:30:06 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 14:30:06 +0000
Date: Thu, 21 May 2026 11:30:04 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH rc v1 0/4] iommufd: Fix veventq_depth boundary
Message-ID: <20260521143004.GJ3602937@nvidia.com>
References: <cover.1779070992.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1779070992.git.nicolinc@nvidia.com>
X-ClientProxiedBy: YT4PR01CA0030.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fe::7) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DM4PR12MB5986:EE_
X-MS-Office365-Filtering-Correlation-Id: bb45a539-94a3-40e7-4d36-08deb74573db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|11063799006|22082099003|18002099003|56012099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	Sns4Qj+CcNJ8p5lFK3BcvBsvfja4BYOIy8bLZXrvgTmB6SK9rNV9609g48xBFxFlBGbqnu5M0n2uvFesjt6cET9T53DW/ZcVzGqdw7MsWIw/aLzJGOdNEUvUQQJe1WQg1ECT89TCN2RtolKzSk+f3iWG0ZVkLdWMfgwvSJngpl077z0mDFWnd8AF4IXVN2MOnX/cMvg8cg0vJzfiSuQy/abBZ5dxmpGgpCxKrH3KYL+JZdZyNrhx5w3lT48+hNB/T+d/B/YtRkTnhS1VpGzYKVDgvoUNEOI+ZiwsC1t+L5BCOkopSaKFdMWHFX4KOhncFfHkx/dygUYgmtRKMTGwZkOTsHi3DNTXONHoUncgocJhDPzp+Sf+KKx5aDNaEO5YYIwTwf6wvxvk8JceZoX6+rSAo3xx6w/kAaIkr/uCn3S6BqEiqDdToFK0GhNRavgH4px4rdNthUqGnHxKghA2YZEf2LrN/U/ITRMQyERYL9vbA7Z9unfj/WvgJR8NNvhCTgUldvnKGmPLRMieaosSzgptw5r/axiDk61VkwqNnmb6PSrzmaPKL5/Lji8eY/R26TAU15kxG4Pp0AuJ8cOZcSg7x8UQgD0dZsHpZ2EqLVINuloXxAwmwdPw3NsaUsLBzJa59tQb8qlt1F8YpDJYnx6nhQBiavtGbnYVncA0Zh11JZrATX+EzaPr6VrLGtHH/6Rzs4PUhYv7ci57+lterQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(11063799006)(22082099003)(18002099003)(56012099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XT+Smvh0fokKS3DsdgSNnFNYKQHAGLv1gQlWZrkiXdGw6mxMNISLpviPJmwm?=
 =?us-ascii?Q?3KPuZhpa/kELiN33uNPOjoHwBywtt+mdRlUWl5rXLMm+MOXd2fkzCgsC59Sg?=
 =?us-ascii?Q?d7NS0Zq5ZehKUjXpuizdmb6DusXcXojYK9bXWan9oBTKnUDlcBKlOoyYrZUd?=
 =?us-ascii?Q?ou9W88F26sdGgHtO0iF0ETs8PqzuESFm0mDQ+QnB8i7cxJmfEOfdprfSsxdc?=
 =?us-ascii?Q?B2r8Sp2wSXGWeC3uzsxAVAoIncAx/jyS9gzI5IXEIJnB8l4IW8bCTXJRirbc?=
 =?us-ascii?Q?msWxqnCynCjzbuaCHl36XMydagATZ3YM4XPwle5ucWCCUMKpfVrXDH3ity++?=
 =?us-ascii?Q?ihkY/SHIhPk9DX5XVkd3vyuq5lQj66a2F9iLeBtaoxmG0eDrpCwHr6isiwo0?=
 =?us-ascii?Q?oIxBbIICtv44XGky92JY/4PmQD37+wseDlmnRhzEo2ZBBbYFl1mac86zUjxD?=
 =?us-ascii?Q?fGvkn84TdDYVqBumvlx6YMka0QbZOPwZfoZgArwI1fD/V9291uziK2S6ub/2?=
 =?us-ascii?Q?FYfp7wT3D4KBlAm5Q2/XE5c/H5QTJfav+F5T2BmIrchcAwsbzYVrfTQk6llH?=
 =?us-ascii?Q?UB7tuGONHhopw8mqKzfntT8301ZirjaS/+sZefIMMqaC9BIOI2LuHDUIhfCm?=
 =?us-ascii?Q?S4gCbJ9MWHiZG9vj/0SQJf83vEnAxGOjV9Bbyz0yaxFEB8A44CtDhcQN9ESB?=
 =?us-ascii?Q?qiz9T8Q9YGShggKSY0n5lBAiG43G2/TV+h3I7MLS3pQyZ3hkK4odT6WEJeQT?=
 =?us-ascii?Q?+crTFNj4QPCUAc73VKscV+GNo3v4xKJ8aRrK+OEnAIO6QjOqqjetFx4DPP3x?=
 =?us-ascii?Q?JMqQOC4zyVtVZ2TcBuMprdAoudxkLeOCJdy+EJB8ClghIEJfEhtGjMMztEzj?=
 =?us-ascii?Q?XNUt/z5BujRCGhVGPtnugely8xgzhm2bgnTT4BWXT01crfxKPf1Gw4VZ0qCK?=
 =?us-ascii?Q?TIb7jS3gxn+vi/H0l3GP4mT015z+gez4DydFU2+gOo7tJRNZiVpZo7S4NqYJ?=
 =?us-ascii?Q?OB9HBCjTQsGp3p5YduDu7nzen/097OtBXfwRnpTEsUw1HqVe+lZsSVCXXncD?=
 =?us-ascii?Q?FS/mrsfg98ef+0fXy9GFUQ6uf2/BsMz3J2a3PoIj8iLGPJfAtNxHmlUAzy2j?=
 =?us-ascii?Q?mih6RLLHeTMIbpllgmp2jxPXVNI1OanTjY3+7w+6YqZOCcYXxFCVjKrgutjU?=
 =?us-ascii?Q?DRqosOSDxDfPYwF4ZjvRRLpvB+YZ/1ItMSATaDLYHtUyt2txxHYqAlUjM6pk?=
 =?us-ascii?Q?yaWn0qZ0KdW49DN5neya+gZ9IIxLxib8LxAxvkFXG/dqt1iv/SnGOhJM3veb?=
 =?us-ascii?Q?fO1MAYCFJQH4OSfXUv6X+FjUxXewsZ8FsIrViLwiCXM3tNAFcUo4fLQc20MF?=
 =?us-ascii?Q?RWXsOzQZkG5/1M7FC1L9W9ylhSokRJrKis7R6BQrLxcqDMUDQPaq2hw3103Z?=
 =?us-ascii?Q?X6m3WXWADK9i/NTK/3fWCknigBaVZ64s2OvGg1uTstKOULP4EBpxYe2LPu3t?=
 =?us-ascii?Q?XJHK95XnJOQDoiEfdLtdW7Zh79J+OvS4mhofBJ+8yt1xAq4BGshbOe+rn5GG?=
 =?us-ascii?Q?FMEAckZiCzF9bWZpI3HX0xNISRrNrrKjouGhsCoToqOizGha4BXg7Zt4AOmg?=
 =?us-ascii?Q?um2LzK2NSNa/SRcyouyAVZMNJMg1VAyEJwn+FFHeJPlxiLCvOeZFdISLg8R/?=
 =?us-ascii?Q?07LRMcmJGEIsYXRrnOS2QOgu61pZaIvPh6nDtevqJjFNoxrf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb45a539-94a3-40e7-4d36-08deb74573db
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 14:30:05.9876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XhAc8YnLooc9SFSBfD7hH+BCMBQE4KTEWJgoR6s972RWE+4f2XJHTkqbON7dONKd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5986

On Sun, May 17, 2026 at 07:28:45PM -0700, Nicolin Chen wrote:
> The upper bound of veventq_depth has been missing for veventq allocation,
> leaving a vulnerability where userspace could exhaust atomic memory pool.
> 
> Fix it properly:
>  - Allocate outside the spinlock to avoid GFP_ATOMIC
>  - Cap the veventq_depth upper bound
>  - Fix event_data byte-count
>  - Add selftest coverage
> 
> Note that QEMU's SMMU has been already allocating veventq using a "HW"
> EVTQ entry number. So, picking 19 as the known use case, for a minimal
> level of ABI consistency.
> 
> This is on github:
> https://github.com/nicolinc/iommufd/commits/fix_veventq_depth-v1
> 
> Nicolin Chen (4):
>   iommufd: Move vevent memory allocation outside spinlock
>   iommufd: Set veventq_depth upper bound
>   iommufd: Fix data_len byte-count vs element-count mismatch
>   iommufd/selftest: Add boundary tests for veventq_depth

Please adjust for the sashiko remarks:

1) Put "iommufd: Fix data_len byte-count vs element-count mismatch"
   first
2) This "Returning -ENOMEM for allocation failures but 0 for queue overflows treats
   the conditions differently, which seems to contradict the stated
   intent." Seems bogus, I think adjust the commit message. We do want
   0 for queue full conditions.
3) Let's fix the "Will this lockless read concurrent with a plain write cause a
   data race?" by removing the optimization, just pre-allocate and
   fail. We don't expect this to be a normal condition worth
   optimizing
4) I'm OK with ENOMEM here, leave it, EAGAIN should mean it is
   pollable and it won't become pollable..
5) The sizeof(hdr) has been fixed in my rc branch. You can rebase on
   top of that and also ensure to send a base-commit trailer to help
   Sashiko apply the patches properly
6) What do you think about the "but done has
   already been incremented by sizeof(*hdr)" ? unrelated issue? If it
   is simple lets add a patch here to fix it

Jason
