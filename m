Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5345E155398
	for <iommu@lists.linux.dev>; Thu,  7 Nov 2024 20:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731011174; cv=fail; b=jWIUoC2DauIbxKqu9cbcjLNUDpSoFwYpsy2VQ776iALJSWzVt9cBPyJPRjgNC4PwgSJCXt+QUXrP2Q0/L0CxsL2iLDx1/tiAz+eQOcV2kg0fcKgzIgzS6jhLgsd+fDJQ4DcejiCURBUpVR0xGtMgUhGt1eIup59MS1Mxy1UI2Mk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731011174; c=relaxed/simple;
	bh=dUEAiBlHyDalpDprD1Rd0qjDOGHRgiGF3F/RILHcmu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qhr/lGbL/ReaoF8nIwClGhW0CfenTLJ3Cd7xPIC6aAwDToyzEF6hcD8rvQCU/NgGcerjbmCKk+5/qQK6GT8GoNw3sgL2jWTltiifWkSI1l9FTSQQVIuqM9HEqgs7qxngBbqrnrxTt5emA0LOaGMmeRbFiMgk7ANBzJDZrGHvEW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZdIsGaqg; arc=fail smtp.client-ip=40.107.237.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZdIsGaqg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=USddlGhZDz5FRH60EGn1Fp1Izg3oaGg+c9GMIHTBujAlBR/JQLHF4hEwIbWReGu7NNtAhTggt5tCDc+0YjlnjFdBEfmKUc7M7EXZ0d8dIlImXTA/sR7IpEVVUDGUy+mJZXs/SFzi+t1fYNErP/7rhOEQFId6jJhzcd1BbYYHKbJKFnQX0fH1a8r/5zY6rVRGEor8Rl5fXo7ieblzV+3QXL4qyvMlOPClNFv9tGJoIvT80xyGUqHSeXmOqoRcPhOuxSw83OuTWf6ZnSoTos+vQEB5HeI16EdZHQdqY3+a19Bjs2IoTFV3GF3NBeF3VhfsIYxLjzDF+BgV/Rz2LOnGfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7yuBeF7TecXsHrWThqlf5P4LVmgWoKFP98vuTHgVsqs=;
 b=LYkH5L9P+Qf4L5wfdytNhZicd1u66mWb42EAdQijRGVgZJQYQ+gIkFZ00G9yKSV5BsHc8WWSponeF70F4jGpZDmPZddUyol136lkoPvG2qnwy9wdinepvT0D64wSPT8UeUiQlwGuqoNkqEY5L0NX/WSppQO3MXxDYcmsbCTNmLrypNVnP6IqG5rdXu7GlxQx0LIL+nkSxvANoBf/TB66zsjklvhpPRdXe8HOsZjug/pM1g5VLikyChlgpu5g3vJZczg0ZGpfbxQ4YA4JY1QGb21gn4xHR81gu9fEfz3unVvT1wMJDkwuZe/ECSvUdCsbbYBn/oTUFGJC5njjOQUvhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7yuBeF7TecXsHrWThqlf5P4LVmgWoKFP98vuTHgVsqs=;
 b=ZdIsGaqgd3stFz7XeZ+GT83f1d7IJjdJUy9vfG2wCsdERhjooxYYQiihXzW9NxDyUCQ0Tm5FUwO/hkL4xSF0z6Ai5lJX+C1ahZ6MW7NBmZZ2NP0Q5Tqtx9GQEv7SrfyiOpKMsK7KnFC1Dlxr3ppNwbht9ISvAR+xL5R76qISVHtetBB1gRss/oAkm9PDi2F/KfTCx9nhqNHtUdg5CKQkJYmyC1Dm14wYglSq71K3JnZcZzF2izBl14TTQMkHGDr6WRoccTMvVyj/Ev8GJZo3vPylE3jeMWKnx9ODOqNehoxxI6pidlxlw5BIQ0JZ2QsWQdb89FQQqiop+dQzypwULQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DM6PR12MB4299.namprd12.prod.outlook.com (2603:10b6:5:223::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 20:26:09 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 20:26:08 +0000
Date: Thu, 7 Nov 2024 16:26:07 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH V3 4/4] iommufd: IOMMU_IOAS_CHANGE_PROCESS selftest
Message-ID: <20241107202607.GG539304@nvidia.com>
References: <1728321203-189608-1-git-send-email-steven.sistare@oracle.com>
 <1728321203-189608-5-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1728321203-189608-5-git-send-email-steven.sistare@oracle.com>
X-ClientProxiedBy: BN1PR12CA0026.namprd12.prod.outlook.com
 (2603:10b6:408:e1::31) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DM6PR12MB4299:EE_
X-MS-Office365-Filtering-Correlation-Id: 79c39921-53b6-46fd-37aa-08dcff6a69dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qPiJVVHQGUQOx3dBfVQBsxVsIcmMbq2/B1vEVXHUOq0olTPDOUVBZ8mxyROR?=
 =?us-ascii?Q?6Bbn4TIea+zDiDtiMj4sLBNArW0rI7K1I47XvWdrg0cJZuD03CUeKeCjY/NV?=
 =?us-ascii?Q?u75cjXYfiBv9Pokyw+9Zbzw1r5+6T/K+N6FFnUgW+ZlPpaV1nFijLdI5KA9s?=
 =?us-ascii?Q?5NkRWh2vrPvuW1VG4srccQyn1wN8+wdnjWxkVSgd9jMvAPF5QCrIWel4g+Yc?=
 =?us-ascii?Q?CQkoxd7x34kxqyG6szdOYbtM8KKKqdEVhCwhb/L101juPT8G5u7fbY8OrLZo?=
 =?us-ascii?Q?DZTiWP/PQe7ZdEcvQJvnRKOg/S5oCDhYJeni1vBlz4X5ZfWsWFsF691vp9nI?=
 =?us-ascii?Q?IcHOoUh1OrafkFNlk3iFq5U/YFW8T2Sa1+fXmk5kwp/7ygqLKnB43T2B8roE?=
 =?us-ascii?Q?SAijXiAyB+lw+elK7P9QxhQlbjxh8/FuTASCs6eSEWRn1D9YGxA/HFwsSBrj?=
 =?us-ascii?Q?JZR3YZxcqBAqmHtanA6/dsc7g/z06M4tcHJngQF7RX38yhF3P6dg72s9vG+Z?=
 =?us-ascii?Q?X9mh3W0xAxoBwEdv4QHThwVjhrI3z2xUq/SuRk0j2vXRnR8Za/Y7RmHB1DV8?=
 =?us-ascii?Q?Ff+8c3n2ZIFqF9KhjP955NbBZutsixESTFK5nulpztOO0/6OqmKjrocTJXHV?=
 =?us-ascii?Q?MPinZjtHYfbLsxGE+fJFnQlDNxs1oc0Td1Pr/aKSO+DJm3dJGlcQy5WId1sr?=
 =?us-ascii?Q?wFfQ+o93oaOM9wur1tMfWPr+F7Lsd58Mb1GUmkO0W0s475gFB7x8kV/5OtSh?=
 =?us-ascii?Q?A2oyb1JXmZO8jP32jypvrGQ6tcMYRXV/Y0JM3APSxIjKLApoKp82IyGtru6W?=
 =?us-ascii?Q?oS9p1VO4vLecnWnDLJLXyD5v8qtV1zQvgJjv/u68bhcLlPy9SMggb4fqJQTU?=
 =?us-ascii?Q?BZVUToS6vsi4WuDQawEKwCTY/uI3doZaGH98xmEYnFgmdy6AWnLt+mo7zypC?=
 =?us-ascii?Q?RzC+Aqq7vLU+aTlNZUdy5uepZe8pvG2rMHNvHcF58oKqgzNSphX8KEjnrEiy?=
 =?us-ascii?Q?tutB+UXrEPCi/25hsrGHiz96j3J0ageXnr8nQ2ZDpupFq5y9pKIzWQ9qYPVk?=
 =?us-ascii?Q?q/ekHVss9snzSegbnE1p8AQfhoU09mluKZkF2xhOJ5aag1taPbNVvo9SL//o?=
 =?us-ascii?Q?GCcOWmue4b6kt3dPzRTHQJfkAgCjkct00o04TNADwd45U86qiXHsqsIncck+?=
 =?us-ascii?Q?2w7434kv7hHyT3gKNGAjQ9SkYJVmLfrvEr8ICM2j1WCqwG4sbeVUpGBiT6lR?=
 =?us-ascii?Q?gl4peyLNXiprJmVW9aSWTu3Tdj/Lmcu7W5TPByeCSu96zJQcPbsGEVR8QLKv?=
 =?us-ascii?Q?wPI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+R6Ln9YDKZXPvG8EReBd6chU+SPQWkBUKBC1GT6ZDa3Ae/sdOsY3XnKUsjT1?=
 =?us-ascii?Q?ZURhzqiV3edftvmtX+If4TIhKCY0a6a7h+PwJ1AVy1HSKq3KKUuAB71lGIeM?=
 =?us-ascii?Q?I3nBVPS87Upd1MNKQzxWWC/cNxFziiagccn7DNGyY2B51NmZqnxOqGTDGgv5?=
 =?us-ascii?Q?HdsR1h24tYxcSYMF3zckxNTJtrDYKjClVnxZy5EvYHP1LUp5b9QfwI0pmn19?=
 =?us-ascii?Q?qx4PihwjgkvTzGmpIv37HqZEkx2qaDtH2085trq1DZxBf/vR/M8B60xBaCxo?=
 =?us-ascii?Q?ZR38hkGKv/iw8VJBPLZ+4tBqb61ALoq9OTLSSZQKriWZpILXwu0a3E3/Ni/W?=
 =?us-ascii?Q?5qmt9tnTpc13pSbvQjI9JH+zw2YuDh5YllP9IzzbgsCRhnXP4GZpGQ/YZRLf?=
 =?us-ascii?Q?pv0SZdtxrc53eo+XfImkplCtH6nplxJIVTHBGXj1WmptkKNjKy2BgwDYqnRv?=
 =?us-ascii?Q?0Bjl1EmhMkaFREW6PLttmfNwyykiMSSu6qh0WBhCPYp9IHpwUfC5jgWO1Kd+?=
 =?us-ascii?Q?igxU72XZMBur8Wuphx1uml5VH9FTail4h4wm/tGaUUpbU3Lp7OldGCdkyeo3?=
 =?us-ascii?Q?oJGdKR8MFJ+jQJ89jx/oDOhrsvG7iWWckBU/NaenhFm7ZLyagJBk7HN57b42?=
 =?us-ascii?Q?7hMiXOZwr2yys9MsisanDXQBvgIcLcNdNe/j+TR5Ua6uX0ujeTBDA3LG03T4?=
 =?us-ascii?Q?2/KCeMTM/Rs4mcltqwf0tri7YOyLQkJX23t6TVHs9uI1+sGL6pjWt8lLKEci?=
 =?us-ascii?Q?76H7b7vRSV4h0cTIlOvYtN8xHM9uoJBwyaNyFb0/Yh/h0/BavJVvfqj6O64G?=
 =?us-ascii?Q?LbeD8vBiDZzTBUsWX4Z+fH3R/j6yDyEQyNfrmCQFb0c0H5PCa5sr//RR/6jN?=
 =?us-ascii?Q?+M9zb6lkzTr53jMKwOJQaqCX/D1vrGubhsAnsHErNxcw/KMQjMLBux29PYj7?=
 =?us-ascii?Q?BDubGa0LEs1qLka+C/BHOjeQBY9CV3J+CjRI4bHp6yuawdXFiCn/Ld89jalQ?=
 =?us-ascii?Q?aKylMMJZgaDBsXxr+YuSFExJeD4A6bqANk0wtSyBr3qjewQUgY3e2cQOi/B7?=
 =?us-ascii?Q?UP41X02M8b6dbXhzJzbKpIONLhei0a3qqerqHTG+9wUMChqLFLIX/NOZqA2P?=
 =?us-ascii?Q?CQGxnMsMZWO0ERLabeD9txzhjNw0W2Mz212OLuWfAHQXUNtU5tzc9wcSFCZg?=
 =?us-ascii?Q?aLcg3DcxOc82KsszRDanioT5+Tb7zXLywX7N93s7VV0YGSbrVClrioeTUPV/?=
 =?us-ascii?Q?mJ3jofrtkYxVfW94SKaNLJB2+iG9FjW0sz3q2sSlTeIH3M5s+ADMw68YmUZ4?=
 =?us-ascii?Q?Fxkhykn/XoaqJfNhOJHe3aBMqzNU3tmmqHInt7UxgBTdFc0bgcvdG8JhK8Ml?=
 =?us-ascii?Q?EJKcLe4TqiWpboxt4aQhm0Zcw0S1D+1I5hKMo/wdn7Qpvy3Da8TursrviEAE?=
 =?us-ascii?Q?Zjok/tMIfuwDN3fNoj2bpERN/ZX+GJk7kxIqUf8KVUNX3s+uFMU5u+Dz3wi9?=
 =?us-ascii?Q?zfIYapBPsU+fn+5zBLQE51vKfe1pM/g1vZ37e5RD7r/IloIgyAX80LFbHZ+v?=
 =?us-ascii?Q?6Lec1IHAmXf8Rvlmh5J4p2VCjyUmsfGwZSI3oTTY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79c39921-53b6-46fd-37aa-08dcff6a69dd
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 20:26:08.9025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BO+Q+N4s+p9oah2TDSwwSH7l3mg/tEzBdtL7ZwxNOiSTdnLH1Dr6D+6+uR0tCTKG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4299

On Mon, Oct 07, 2024 at 10:13:23AM -0700, Steve Sistare wrote:
> Add selftest cases for IOMMU_IOAS_CHANGE_PROCESS.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  tools/testing/selftests/iommu/Makefile        |   1 +
>  tools/testing/selftests/iommu/iommufd.c       | 148 ++++++++++++++++++++++++--
>  tools/testing/selftests/iommu/iommufd_utils.h |  34 +++---
>  3 files changed, 163 insertions(+), 20 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
