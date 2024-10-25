Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2078.outbound.protection.outlook.com [40.107.102.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADFE20C313
	for <iommu@lists.linux.dev>; Fri, 25 Oct 2024 18:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729881605; cv=fail; b=HV9b9BZfKwLjabymiU9SohF7NQ+N3oeWuaWUBmR5GROCoXJhExUYNUIpV0TaGPJPZaSQUlcMUtf7C0T1m9kDZFZIylBm1ssdHIZIejdQSfOxLpfQ22NhCewiwJc//IgFThIfqSxpcbC0UvyxznGXhLeN1MUGLD9A8svo+ie0LA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729881605; c=relaxed/simple;
	bh=IUQPxk8jdkTf/tXTFFpjjND2KjMmlQv45tV35IZ1P1Q=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bejWCXCH6tVTMoSStrld6jb9FNuucPR7chgNUC28/Pj3Q/h0b2x+mREwM02PabveU/gYUoLOWPkbUhZ50mIUCCJ8Tyd1Yqqafs4RJRofp9C6V+3Q7mraWUKCKhPmvBKVBJAK1mW5m/FhfE2uJhXPY5c2r2IhLMf7rP8mSRyLyOI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lwXlbNYI; arc=fail smtp.client-ip=40.107.102.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lwXlbNYI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ftJRX4WOTze9I8jwHHkiqnrWjfzHp+9mYs34Rz8rMGzCaH/yhjMbvjdlY1lixMmt6EenaHZ7NiXpBiFQEgUTYvpfPThtChKFUMLPuX4L36vM4V7t13i4oRy5pq1y/6GT1TyJwPk+1sC2kNTDtvwkjw9Nv23857G9oTMfMlW0Z8kLpXV0CQjPIi07pcuTwyxPYwT6dm8YGgCI6m1WVA8N3/COD+BjQmFwVLjDo2G769rm+hEPQO9pxOWyxWkjKbIESHmjbzoPTqy2TyD/c7xtMwXCNJBRKwFTVZZpkr/EbCvkQCncAeW4TwOJ5xjAv2+5SzyYwnmL8Wk+62zHfTRIxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7rcMOQbYm/l1yvvkiyHml906BSohDh6SSkEE7P3s72k=;
 b=VIIJyzmriqgXRoXz/S+1EIUpx432z2FV2Ys9BKfRL5+URRcEM2fwfzhliuHyAVWOh8K4tarN/EtTIH0O7foRyJh1AQPrIoutPotRyJoh9r6zW+V3ECEhp8ysavWHaqHTS2B8svoruXVREU0Scs3pD6dAmwMsqH/omhyhlqz7YZWRFLfBquq4djN3KmPW8jGGacf8SLt53hnOMlamV3+xu8z6CkZmf4AA4SB/ldYPfNeZ0h/IGat9FSFHw2lQU9A6Zst7K0eieZHVAOHKI9ZY+EWL7sMof8EiaVaBJN8T4ryL1AZiu5sHUFEXw6/ldmsaSz3Jbn3KoOkN2Ok6Dr5Edw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7rcMOQbYm/l1yvvkiyHml906BSohDh6SSkEE7P3s72k=;
 b=lwXlbNYIF3aUQQrSNnuE4nS082EIMupmqNwoZeiqcNELF6ykfdm6FNrw/JJIAgjUxz1PiWPpnM4dwEJshFMb47Ln56kjoQO0AJ63lcX4UMhLhDUr7DhQE+GnZjBqeoYg+KRFonFyG44nMBscpP0u3dN29oecZo46drLYbyW2DHG3uMrDimlVxsK7qovJxIHwFGnPymregJHVjJOqQzJA9HOdOgY1eSFdDiayGZF4CbyVTAoIfthaamxc5WtRadkXbIIxzEwWxV2JpwsGBe79Fks9kQR1LFI07w902Pw9dAVjFfwhvIUaSurAyhXYkiUVIeEzz1iE2AVRhZmMh7yvkw==
Received: from BL0PR05CA0013.namprd05.prod.outlook.com (2603:10b6:208:91::23)
 by SJ2PR12MB8829.namprd12.prod.outlook.com (2603:10b6:a03:4d0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Fri, 25 Oct
 2024 18:39:58 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:208:91:cafe::c3) by BL0PR05CA0013.outlook.office365.com
 (2603:10b6:208:91::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.8 via Frontend
 Transport; Fri, 25 Oct 2024 18:39:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 18:39:58 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 25 Oct
 2024 11:39:42 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 25 Oct 2024 11:39:41 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Fri, 25 Oct 2024 11:39:41 -0700
Date: Fri, 25 Oct 2024 11:39:40 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Steven Sistare <steven.sistare@oracle.com>
CC: <iommu@lists.linux.dev>, Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian
	<kevin.tian@intel.com>
Subject: Re: [PATCH V7 9/9] iommufd: map file selftest
Message-ID: <Zxvl7J0mWkKPS4GD@Asurada-Nvidia>
References: <1729861919-234514-1-git-send-email-steven.sistare@oracle.com>
 <1729861919-234514-10-git-send-email-steven.sistare@oracle.com>
 <ZxvPhQZOBR7g56eh@Asurada-Nvidia>
 <2c7edd3b-61c7-4012-b825-4972c0efcec5@oracle.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2c7edd3b-61c7-4012-b825-4972c0efcec5@oracle.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|SJ2PR12MB8829:EE_
X-MS-Office365-Filtering-Correlation-Id: cde3eecc-8b97-48eb-de47-08dcf5246d6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/UgO69KFqzQn9X0eZP9ZyOgNuxyG808khJDdRMT8BZISY5ys3Mb9F1K3/U8c?=
 =?us-ascii?Q?EsRC0J7oE0hHRY2Q9pkyGqdo2dA8E1itg5XyCEpU7GGddYQ4vTNz4lTKyuRt?=
 =?us-ascii?Q?DCPCxDaHp88HnBX1iSuk/aO0Ywl5HmL5M4aOfz428J85VVgpfZ3IVxW1r/uW?=
 =?us-ascii?Q?gKiK8hZJhlwPZQJ8e5++tZ3JkWp+k0X6q41E2e5IffjjfwCwayABzl+zJCG5?=
 =?us-ascii?Q?ah2G/yGu9GauVuFGO8Nsmfj3qKxAxe3+A4hXYdXpKqvkYrvbpUVm/ZUtVC3+?=
 =?us-ascii?Q?0jc6nehCYDajtTEWTpu8ucrcpCZyNqwR4vRUkeesn8hpjNxUhjE4N57hysSQ?=
 =?us-ascii?Q?rYLDrfq86g1fYrtjkFs1DPopOHMGGZ/psD5OK1OlVZjXOYkEKxdqp74YyZ97?=
 =?us-ascii?Q?U4L8mEbHgCSJMqkHjg2y3FMhT+X7K4nsnB65SvMcn1wZQdpJXUdUXBz8KiMC?=
 =?us-ascii?Q?f+AIhMsOvjSJIEWsqpSBrXTPbPMIqUbWBX4vk32SUFaiebcqm2tlzdd5DUuN?=
 =?us-ascii?Q?N1BgBnVZtC5xH/1jKKqCyKHlOyjelkh6vCfuNL3F2CHwz9ndZy2vnxZHZ4fn?=
 =?us-ascii?Q?Y36GJnzm/dJRDVKyOiUQxXxv5EnRDSaEg7vVLb8uTi/bx4zLmzq68KGJF7NJ?=
 =?us-ascii?Q?R6L9dvtIWxk1G2ktbbOAFZ48uAjCi/MtOQ1PibnF1YjCoUkJ0qaL4xWf/gV/?=
 =?us-ascii?Q?VvK4i1Nf3PTScyHPyzdvu2pTK9fiYQScNwko/A0+WqsYiNNpuMleTPAO0b40?=
 =?us-ascii?Q?LNTkvfXYYxYqVKfKv/b61Ynd2Jn888t0Oa9mUxwceV7h9ooBI3JCkndqx04W?=
 =?us-ascii?Q?UB/WPUS0vj2ZR/PDGgCKAb9KEdugrD7lbjMUyPM42PRqb//8lreKVJXSYDCE?=
 =?us-ascii?Q?VYKuzjFQbsaCkIoUVyq2uNeHQwFe+w70tx5GYET/wsxGNgNvPvkBsjOY/3OK?=
 =?us-ascii?Q?u6ftks/57S1m74zHbqJpTwXFH2ojPwEeRdQrOontuCHcRCYFUFRrdVFGodm0?=
 =?us-ascii?Q?/1LGw6GNCw0rJenBiMcxnyiEAjX73a8hAAB/83Bb6U1L2K0n88i8KgmmA8Rx?=
 =?us-ascii?Q?AVMqypUEMAhzIcjyMHjBHim7VYOKTG24nr1faBEIMS5pkAMS6srgfEmWWy7m?=
 =?us-ascii?Q?9iRRrjQ4xVudQmwkdoBxGUraOryLsNVa6JrD6bGx++o5lHE9iUeQ5/pwlw0w?=
 =?us-ascii?Q?VWzC+F+B3krmxZw1u7NFXVrsAU5JP8SG2BQgJglm5PxcvosAR6+VjLpcszDU?=
 =?us-ascii?Q?2QQBO8TNjz4pXLXIVEuOw7EVEI65SbaG+gvlxz5a3WRrPV7J28aKfmHJ0ALP?=
 =?us-ascii?Q?+IsGUheL+8eeNz4bOxVmWXBWipb3WYBlJFoSIY5cDfAk2OK4YekZGIZzM6+E?=
 =?us-ascii?Q?jHRCVSPiVQDo0Y1q0z2bvQ0QoJJCQ6bPjysa4VkjD5v+k49OFQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 18:39:58.1215
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cde3eecc-8b97-48eb-de47-08dcf5246d6c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8829

On Fri, Oct 25, 2024 at 01:58:57PM -0400, Steven Sistare wrote:
> On 10/25/2024 1:04 PM, Nicolin Chen wrote:
> > On Fri, Oct 25, 2024 at 06:11:59AM -0700, Steve Sistare wrote:
> > > 
> > > Add test cases to exercise IOMMU_IOAS_MAP_FILE.
> > > 
> > > Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> > > Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

Reran on Jason's linus tree:
...
# PASSED: 204 / 204 tests passed.
# Totals: pass:194 fail:0 xfail:0 xpass:0 skip:10 error:0
...
# PASSED: 8 / 8 tests passed.
# Totals: pass:8 fail:0 xfail:0 xpass:0 skip:0 error:0

Tested-by: Nicolin Chen <nicolinc@nvidia.com>

> > The build passes, but I now see a few failing tests. Any idea?
> 
> Strange.  All tests pass for me, with patches applied to base commit
> e2d8fe9148b79ed1cbf0663edc988db7769173dc
> 
>   # modprobe iomufd
>   # iommufd
>   ...
>   Totals: pass:204 fail:0 xfail:0 xpass:0 skip:0 error:0
> 
> However, I also needed this patch from Yi Liu to make it work:
> [2] https://github.com/yiliu1765/iommufd/commit/ff0772d155c1ae2841e7b7ff0d7ca889271b81b2
> 
> Without that, most tests fail, even before my series.

I run on ARM64, so I don't have that for it fixing an x86 issue.

> I will try to reproduce your failures.
> What is your base commit?

I was using the for-next tree (rc1) from:
git git://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd.git

And it was failing, so I guess rc1 is missing something for memfd.
So, it should be a false alarm.

> What is your value of /sys/kernel/mm/transparent_hugepage/shmem_enabled ?
>   (both always and never pass for me)

$ cat /sys/kernel/mm/transparent_hugepage/shmem_enabled
always within_size advise [never] deny force

And I retried with "always" that works too with the linus tree.

Thanks
Nicolin
