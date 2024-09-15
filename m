Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2041.outbound.protection.outlook.com [40.107.101.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844871EEF9
	for <iommu@lists.linux.dev>; Sun, 15 Sep 2024 20:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726433577; cv=fail; b=dqR8Gs58/oRC06KQSMuqtMLF7x081g1zqsxLI8Pf72IxCmsufEyU9XU7cmVTZAqVe2+YJsymXI46IY3OCas5Yl70MAJjeyJyvFyuRp/TQop+RSA6IBezKHctJMFhcpP73xDjIi/Re15r6ihdqrRSaFcOTfKXnuEQieBrjWBIIsE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726433577; c=relaxed/simple;
	bh=lfXXuAA2jDh/WbYD0kEoRB2VEj3UnmCw7q7TsWIt9UE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KrFd/TvbyeYOL1FtwoiFcs+bi35cQQ8gEf/YBjm2BelIKEco99F16ynaMAyVzjA8tp3+pTf/D3Uq0ap1P9upAfc2z2euRmetLd1c7JqpqLC2H7HhJ0cILxKZOR7MjP/wtrcQYCWkb5BptKJshgB8qBNIlnaG+dfCLpoa8ocP0cA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GnPG7IPO; arc=fail smtp.client-ip=40.107.101.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GnPG7IPO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ShJcdIQwAfh0vdyDCJRhOsmNPc+13WWvHvLuN+B6Q23j9c5jbgKCUomA/zk4OxpcHYOhYrPle+Jmp4d2eZC7q0uC1V1UYqpUxY87RM/67RbEvE99P83nhTMvXPiRze+BoAIXvjmkYhZBmTPXFj6q5KYLU2VtXbyDbsLl9aTUGg3u/rDRA7DWxNpl/P2MQqSmbj8r6BlbJjM2bhoxfwMoHU2uVFdox7bm/CoPtiCL4n2+m7PTMAdK/mAz4Yt9JyPxiLgnTzbxSDv4MzNlklMVTiqBPMqCTZom+QPi8SXkqt0VUKby6Ak7cdQBtg6Db5EkzoUrHeDdiFmFuOJ3lae2gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=avqs/+OyawQY0aLuBvKHcEdff8wTv37XXpKBLkMV1R0=;
 b=McwG9k4VEbKpx/x4lKXINTv3Wj9a0fs/Ani+O1JbrhsqiaRXH+CZFLi8t/xZCMEF9k0EquJE1SgRM6Uu95JuHgye+oK5kgxtX333VRePnL+AI24DUIGCTgJn+jUTcQHtWWK006cKE51qmrjh09a99JjXC6UIFHWwvahP7X6ErJqbN6O9QdDv54FdWgwb2xlZ3NqMLNb4D8uP/7dzchZLWyspBkCAZYr427MdLCGL9lEWOCV70IXpCgTLQ8q4LD3kY+SzJdXK/uBsS5FXG7Fq8k+pz3xdxpwP0vOR73g61Eo69Vh+FWse7AvTGsmpoeh1bRxW25WPEiFRcIqbF4DjRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=avqs/+OyawQY0aLuBvKHcEdff8wTv37XXpKBLkMV1R0=;
 b=GnPG7IPOhq62X7Vm1ufGdeTJ6ZOwnX6Jf911wHi8y6xTs/GQluEEin764yI4fxTgha/ictv48h+wtSnJUZpxvdVeZJR8oOrLNPaQF9ikS7C2aQUnNVG1WBTRpnOeluCO1k8oqZZf9zjg+TW3tKimLEm/vvmVVaQb9ExDxAPDpN8zQPLL4+KF2ck8v561IW8FQn94g15XBA4i1w18XGGKF+5H7WbAyvZaT+Fvko7ePAw8RaStjvntyd620e8ImAJ22eUDcqFHKI+ud9pTotJKeQiTt33TBQNo9zfZqpl83RhCcx7fbibTmILx2uuMqf5d9VJQKPtEVg3mgOJoY3gK9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by IA1PR12MB8518.namprd12.prod.outlook.com (2603:10b6:208:447::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.23; Sun, 15 Sep
 2024 20:52:51 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%5]) with mapi id 15.20.7962.022; Sun, 15 Sep 2024
 20:52:51 +0000
Date: Sun, 15 Sep 2024 17:52:50 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH V1 5/9] iommufd: IOMMU_IOAS_MAP_FILE interface
Message-ID: <ZudJIicC9EWogmWh@nvidia.com>
References: <1726319158-283074-1-git-send-email-steven.sistare@oracle.com>
 <1726319158-283074-6-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1726319158-283074-6-git-send-email-steven.sistare@oracle.com>
X-ClientProxiedBy: YQBPR01CA0120.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::20) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|IA1PR12MB8518:EE_
X-MS-Office365-Filtering-Correlation-Id: d56bde81-9886-4333-0482-08dcd5c85d4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0DiPzSp6ejo4EwMfAjUvaEtsiDOFkSwf05jW4hoNbYhT/uGEad2bB4kqciP5?=
 =?us-ascii?Q?q+lJvZSIaQZCDoJkRdkKZlUCReWHMk3dt8nRHsPyPyZFpiFRbEZ5agQ6LAgR?=
 =?us-ascii?Q?iRnxYPdzjgrc+e2XrhZUu7lCYAJv9hPRU+TxUQuYY401VHcFadIDs/SEkNAw?=
 =?us-ascii?Q?VwlE0DOs/T33PzrT1VSpUKOUh3jcFa1IyA79Vr/aigpSdRV6QvMwXa6Jtn94?=
 =?us-ascii?Q?CoXNjPPXzU5eFwvzRlP9zbs8oxEM5AIOohC7KUqfHAj5mPeP6WgXVKzTfZs+?=
 =?us-ascii?Q?MW8TDVMsFN0ei0PgAFh3m1PiZIP6UeaIishiZudBAZ5+55Jxq4qsZdgbVL4X?=
 =?us-ascii?Q?8261cNyttasOGTroTG4xpA5uKRdQnTcIMdSS5JZKItCZ39imxhux0rqMXsTe?=
 =?us-ascii?Q?2fVrALXQCLE/gU4VPGaZ1SUFf2p4GzmdDdtLK4cCDq6LTE3E/DkV7DFdWpMd?=
 =?us-ascii?Q?VJEhyQyFjZ76VDrT2NpRaeqY0ZOKNaTNx1Kx1I+rtMlUPboPMGXwdnwR9Yaa?=
 =?us-ascii?Q?i2nC1FomExEFzvMvA6D7Rbd24e3dFAfn37h64Rqxx2GrUvorZNQdg4MPfajf?=
 =?us-ascii?Q?fp85eYs3yBUamXVCvn7nl5DPPGgWhzzjl8K5s3n3NB9S1RetfflRzlO6N5VR?=
 =?us-ascii?Q?kPJW6LrZagYWRsXb0ayP8il5Iqci1Grv9SHagVJfzUXhkaM1ANRD9Vzb8xqZ?=
 =?us-ascii?Q?G/IJr/kFS4LsHoYNI8KqyNYMOiLkaum0+XyvdngB2xEQe6n4mtGSwF0qei5+?=
 =?us-ascii?Q?lLI6FnZVMLD9Wq4Y72RR0CYoNLM5Yl2uf2xqp6mDn78w3qi463VPhJeHVSqn?=
 =?us-ascii?Q?Djlb+Stxr/gWojDndLRwqwCLJoTFiTF0MYryL1PxtmhlUQ7mg33jRImBxewi?=
 =?us-ascii?Q?ZhKfs3grG67Nob3b1Ux9mpKgEbX5AFxCYRHynTS8gXYU8xyuYUhqGYJCPY7x?=
 =?us-ascii?Q?/3jobSLU4QLqI16YE/DpcOUzxudH8LRk1SsI9Npa3VcpHmH/Fu5bhYHClOqM?=
 =?us-ascii?Q?hYJDadFS89YlFs11H/iNfPVsx8fGbltCYx5Dp8JfisNLPFY1zPgpxxgdGFvP?=
 =?us-ascii?Q?W6x2d7H1Nrw0dFn4rf3ilvi35hAsVwcxU4bjeN0Bp89gzcie+CI9iDdzn60O?=
 =?us-ascii?Q?mdpgQYGvLQCyhrmYUjqRcyX7nb01dIB8GmC2BMATUTlDmc3JuDBPQek6hNQm?=
 =?us-ascii?Q?ww+I8TVFXFcYbXLyEtI2W/HNHL94VhsANB9UXi4a7QG6whFVUeUZm63RNvdY?=
 =?us-ascii?Q?3XDzwa8Z8CknDHi9e7vepK4jILGbGdeLon59l748RflB1vzaXmR3ikwTdvwO?=
 =?us-ascii?Q?xCxtoCd68qSVrhvD4qOkmgJRXq/t5m/T8uMOPwlXFxC8yw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6K49s31fH8joOtDzvq/5Y5ti7si2NoX49qDqXKfJU0AjnZBEF8MezEiqbosZ?=
 =?us-ascii?Q?JdFshSzU+FIsLPHEjaNMepE6/6TqAQM792pCbv9m+ZggA7vB2aeeiZV7qFLK?=
 =?us-ascii?Q?Ufj6HLB34pKETz16BktAY+4DnHKEKBDK5rg6vEKfp4XT0YpfLCPDkJemw5Oo?=
 =?us-ascii?Q?ssZS04xOTj7rc+i84mQCqu6bn0TKvHrRgvh1WfDPxRyl9GlXWy9DFZq9bH10?=
 =?us-ascii?Q?h3f19Pocrum1M43oszDoLjgU5acPY5KtJWEPY5zxILPCkPnznZGbbLprAeXC?=
 =?us-ascii?Q?MoxI/ospSEFdFTHDmJCPxht25IhgkZMLmYmwzL4L62jK24VndyS9+LIGoNDx?=
 =?us-ascii?Q?fYIWfpI6POMzy7tytjytRKdPbteAzsK/QBtZ6cg0SNcnVSbasf6+ekcVeudT?=
 =?us-ascii?Q?5AfhpZZacHLVKf8TZrwGrJjf9zcRHeLrmwN+URxPZW7jk4FEH4KKSRFDBHGF?=
 =?us-ascii?Q?yl5QiMpCA0RL0+k5rf2ZlQdqaBAShP+Nz9Ur1x6nGs9lqqhKrnMeXQGIrAjc?=
 =?us-ascii?Q?REC9w3ddCYfhafJyyaaOafbiOdYMssUCBeiZQng6v/H9/3H3+xBCxXro7OH0?=
 =?us-ascii?Q?SnBOA7r8C45JI7hgPvUBmUB/ePKz6NGjYwxeeRSu+59DJNKCKDTM1hvokqqo?=
 =?us-ascii?Q?ei/IyfJyJs/o2guzCeSgOwOrorPzlitGZkr4woRICGUKHLSMUVLQ9Q5gq5sF?=
 =?us-ascii?Q?XiL6mJybTYtknfvs8LUgRLJ9EAAanRePR3xMcmqXRTCR/JUtrP9D04ln6QOV?=
 =?us-ascii?Q?1N867duwJI3KDL8SDL8u1Nn77LINEYf2UqaLYYzF+VRZ3Aupsxa4rFEhp3U6?=
 =?us-ascii?Q?iha1kuffTpITSUZQjcC0N5DI0MRIhRWuLOSCdRICSxIzFEi/tAnEpDzZuaUU?=
 =?us-ascii?Q?u5fQlY+JN1Ok2WGQktkn27NpNBm+iU4fEThQjwoVAU/P1Maqr6G++pmspY/b?=
 =?us-ascii?Q?ZlIWBY0ORAux+U0TZ1f0+W85aQQXMcUsFxDp73KjBAj/tCkGMvoz5HR4HNz6?=
 =?us-ascii?Q?fhbwQqxN3HsHkyiDHPFXU4j/GpawT4Ig1a4gbITKBrUN11utLzBrjk00VaOM?=
 =?us-ascii?Q?SI5Oa+epP8pfxBLK/l+3+wfwE1KCL0pPTr7N7TWtWsjelL59gMxFEc+n4pLb?=
 =?us-ascii?Q?ecwfY5Nv3Pu7nz6pXNTn+KXG7zVrYX2lQxeLUoFVaMQUv8riESGC0XwsJKnc?=
 =?us-ascii?Q?PO/AWLFmfNLKFh9ysIDAUqzVb6FGBq0eUppK//XlToEJn31dJvZMOF+y+y92?=
 =?us-ascii?Q?GYqLPrRx3qtmW27gzQSqHAKSePk0SvZQ2Kb0oHzPf6FKLZHZri9njNftTDpt?=
 =?us-ascii?Q?wGYPNFWzjmDZXptjmsAquIWQrrLUGTPvFN7g9mwWb8gMEb189gx+lMa17aXS?=
 =?us-ascii?Q?5Wodx2SIUFuAvhA8KqtEYj6FO7CcLVFxTzcGiDuPa4fN1+psZhLLykVWo70T?=
 =?us-ascii?Q?lDrJfoa4q61IvIF6C7tMojCBIdZVBZu7G74wRBjq+oV9atdWz8G5BjgsScj1?=
 =?us-ascii?Q?1L+E6+5dyd16QegAUQGu8+y1FJ3ujZJuHDpWdx/Vb+YWdGQNJjkWjc9KJ8/G?=
 =?us-ascii?Q?nJaXL0paZKTqkf9ZPV9hkBkTITptp4o2Jm1I3CpL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d56bde81-9886-4333-0482-08dcd5c85d4f
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2024 20:52:51.6508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uaeyzG+cC7MyXBXAcq2kx36e9b+qQD4Z1wPq9ySE74MmPptdR+8KCfo3ovtXDlCf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8518

On Sat, Sep 14, 2024 at 06:05:54AM -0700, Steve Sistare wrote:
> Define the IOMMU_IOAS_MAP_FILE ioctl interface, which allows a user to
> register memory by passing a memfd plus offset and length.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  drivers/iommu/iommufd/ioas.c            |  5 +++++
>  drivers/iommu/iommufd/iommufd_private.h |  1 +
>  drivers/iommu/iommufd/main.c            |  2 ++
>  include/uapi/linux/iommufd.h            | 22 ++++++++++++++++++++++
>  4 files changed, 30 insertions(+)

This looks OK to me

>  /**
> + * struct iommu_ioas_map_file - ioctl(IOMMU_IOAS_MAP_FILE)
> + * @size: sizeof(struct iommu_ioas_map_file)
> + * @fd: the memfd to map
> + * @start: byte offset from start of file to map from
> + * @flags, @ios_id, @length, @iova: same as for iommu_ioas_map

But please check that the kdoc tools accept this syntax?

Jason
