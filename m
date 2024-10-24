Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2086.outbound.protection.outlook.com [40.107.101.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5108A22B642
	for <iommu@lists.linux.dev>; Thu, 24 Oct 2024 19:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729797807; cv=fail; b=sfsSOEXq0soPttkze0LTlsMwR7w6/vL8IuE4eLy6ouYiia+CmR7mznLRz7mInGIkOsihFVLaZ+rE9XAAgo/Ia/ZjKq0SfMUBXlcpDF9o3UXSWyUknvnh0MtW57QmPEN8OWWeWJ2rMcqC1XGhT+x1CoX2J4xHNqVpObQpb0KVmd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729797807; c=relaxed/simple;
	bh=IckphjsnhxLL6R45zI2ekOYaSe7yfZPwmnysb0H3gsg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QZGtZi1IW0U/KbpBtgkKNmnquUdsNoU9XDzYResQiInlwEeNHGrOcFF/n9rXOBIhLT0mz44+/EobmhXdT+REE4gKJQ2yvCh8aqmxAUlpZqIcZR3jUtIfkNA1s1yQKKaE+4wX7tPxbW+KJ42jlIWNlGY6T7GAq6gM9F0YQ4hmkTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=W9kDNtAl; arc=fail smtp.client-ip=40.107.101.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="W9kDNtAl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hSi2x4pg7wMNEBYGrpaN1PRBXtPZEODa042cp8/tZFw3UGmtOnM0rOEBynGg9QmV4R2d0Y7ruhiNn2AN9hmRVi3EJgAJowd7rNTdzGZxyhA0a6v+gMGuC1Q0GRZGac7fvEkSD0vj8AYfiG5MsAAMYxPUr5mxcGMY2k0oqQ4RijyIwysqNXj6k9r4+b+jm0R9EHXwvV6dtqO6PrvoF/wJ9+ZVm1y9sqWnxghmU560iSDSP/0ceYfpzqiwjkcbIf53Ya99z3TPYz7CewAaMnGbizo8Q+as+T6HsLkgsWntGioRaRjZpPoT7/4YwFcWhvG8IpYjO69fiO459l61w531VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xL/8+z7sxcdMX8bJPHI27pNSFKNAT6nqVi4y3YpSPEs=;
 b=azAirLa5MK6Jul4bB4gU+MSrqO+i3yJX1ld4UsJ2h9q22nrV4R/KSm8YFtFlyO8zMG7eaGbGZ6HFRS3MF/Jw8FwLnnaiAwiV0jyzS7cOZ1RKB9dkwNi+1shXeezbN0Xs7P995jkSDY+54KOySLUqo5s7RZmZ7E9snoVSBvjxdh+DYmow0Ghc1Q174ZATTU9vRyNScbgHxLoS9wZmw2WIhrYBxWP2Bp7Jqs72koXlLLEZ2vMYkp1ysY2DELbDf3vZEVFsWqcROLCJZFlX6MZ0pYhpLgP+w2S1DB49O9x0f37hr+3FxYIS/mf2apQy9R9jjyKqhGAa9+oTryK9FKD4Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xL/8+z7sxcdMX8bJPHI27pNSFKNAT6nqVi4y3YpSPEs=;
 b=W9kDNtAlZ6JRdKgmGUsVc9L6bZpcMV5KaC8JdsxDCN3/ftFGypMHoo5goiVq0EBcNg8Yb5n9YCimAkftgWG+24L8tR6X5JlshsdSmqOT0sdgFO5SNM6cK+G4Hda78p4RQwQ3IGrHo5LRo3j+FxUaLy2r1rk8aFSbkeLKgHvwd4PmUQGmlPM804apvzR7izH8Hi6rSRuDi/zX6gkh7HSl9zMmsFG0I9UIGI2f/r2FpvKUG2HnO2lh48U9Sz7GYAvzfwWyQWd6vUEWElDwVd1s19nBVgG5sy9Fbc/yPYLIYKAwL0nrJlVA3+tcX0TKPpmdEv6ELGphrIQVdnz3p8B/LA==
Received: from MN2PR15CA0050.namprd15.prod.outlook.com (2603:10b6:208:237::19)
 by PH8PR12MB6675.namprd12.prod.outlook.com (2603:10b6:510:1c2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Thu, 24 Oct
 2024 19:23:21 +0000
Received: from BL6PEPF0001AB4B.namprd04.prod.outlook.com
 (2603:10b6:208:237:cafe::fb) by MN2PR15CA0050.outlook.office365.com
 (2603:10b6:208:237::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18 via Frontend
 Transport; Thu, 24 Oct 2024 19:23:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB4B.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Thu, 24 Oct 2024 19:23:20 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 24 Oct
 2024 12:23:05 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 24 Oct
 2024 12:23:04 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Thu, 24 Oct 2024 12:23:04 -0700
Date: Thu, 24 Oct 2024 12:23:02 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Steven Sistare <steven.sistare@oracle.com>
CC: <iommu@lists.linux.dev>, Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian
	<kevin.tian@intel.com>
Subject: Re: [PATCH V6 9/9] iommufd: map file selftest
Message-ID: <ZxqelgyWdL/Y71zo@Asurada-Nvidia>
References: <1729783554-56916-1-git-send-email-steven.sistare@oracle.com>
 <1729783554-56916-10-git-send-email-steven.sistare@oracle.com>
 <ZxqXnnANqpeFq7XA@Asurada-Nvidia>
 <e5c4a3f6-594f-40f3-8c51-80d5d03e1ffd@oracle.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e5c4a3f6-594f-40f3-8c51-80d5d03e1ffd@oracle.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4B:EE_|PH8PR12MB6675:EE_
X-MS-Office365-Filtering-Correlation-Id: 8501c636-e911-4b11-9354-08dcf4615260
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?u/0Lu3hDwI/b2ZE3r27WDP+RPir0Sf+h+Sl/c8sX0XmL1xuDljTXZow5Z1az?=
 =?us-ascii?Q?2L5de0gFo5Ld/ApR7iwo/LXjT1BVUghT0xG5Fwy7te0iSfsTnHu7FTMa6Aep?=
 =?us-ascii?Q?GvTZV3Q7bSpEItnBOD2C4hfBBNE3kik8z4DwsyXuIUNWr8/AkhSBTbWokwRm?=
 =?us-ascii?Q?YYkJhPrd26GP75Vw9ANNXhH6VmqIXLsg07MQ6YvKZzZBO4VbH8AZDnCmmHTp?=
 =?us-ascii?Q?Xjt9N5M4sSO7EoHuFvy/TUx3yPPIk8u9MfFCPljWsyG3FeIAQMic0GOe/jb9?=
 =?us-ascii?Q?z+iNlczKJsxlQsVrXIGl+jncHdqPyzc48oFg3NIKydvQxihFEq+Q0zN+h/lJ?=
 =?us-ascii?Q?c/BnwIe033MUscHpu8/k68pnS8gBG1z1nDVJzRI0WpIvUqN65NmrX418Bdlj?=
 =?us-ascii?Q?+yvOwzJN80l1jxOdSFMhgUWGYNP/ZOZ9WgPhLhBE/u7jc6Wb9b1YGOoEeDHJ?=
 =?us-ascii?Q?iMD/DQwzupYMaPOd90x4UpCeXAsIVyaKwyfnrxsoQ+SCRHn93v0atQokkMAs?=
 =?us-ascii?Q?tmMelNkqZgv+GPOJOiEI8CC1UxumiJ83f1dgGPjLZsgJHnYO4uNEJEUESGxg?=
 =?us-ascii?Q?a2P86D8AoDcDL2d65tU+Ov3GOFUL91F3GH9hY7Y3jklD/QQ9uuWnD4SY2xtn?=
 =?us-ascii?Q?scCljR1k1UVhLa92RTf+5Oi9TPXFmvP075wOe0HRKFulQ1tWy0aYxjqg5Whc?=
 =?us-ascii?Q?Nc1BqZVfqiThgaprSgstUAv8QC+k/K3QmJXHhRHvicajaaiwbZjdH5r6VD3E?=
 =?us-ascii?Q?zlTt3NR87adlM27/TNo0ijVLhCj3p0BkMAjxFAJOMHHyuJ6IiAq2l7ZmNp9o?=
 =?us-ascii?Q?rhYLh1Pa2HlHeuXxX0zbUgGlLBlqyFCbM3339V4f5F1h5jwjnBIF0LioL009?=
 =?us-ascii?Q?JdM35w213kAj+iRQFarQuO692okrJZrAlWgQbLycmHgltqmCWLeroUD4qnH6?=
 =?us-ascii?Q?ej7Xs8W63X46tVp1skwIXhV/9uLM11V5byepfButUx8zjciV2XmVo3en4wd6?=
 =?us-ascii?Q?yFCcKR3k9e1FTfLmmYLxyRHGCg1H3TO7i8FSuRwFFdfRE9AQfMv1unrOuGmk?=
 =?us-ascii?Q?FLGwJyHAXIrLk2+G2Ot0AsMwqnSEwknbqsIEy3lXng6EgC59Jxpbj98ERXVZ?=
 =?us-ascii?Q?TKtDlMhRmBxlFHPLtY3LEZ3P66stc+N5Nr3b+JyohzTB6chwwIaezhwKf1s7?=
 =?us-ascii?Q?/ATewXIDM1aiC1wn9bcXDuOOwiWsBFK77Ky+Y130NEMxOhav+IufEk8EvWbF?=
 =?us-ascii?Q?qoeb73cYBxrBX4ETAewZwfIy8L1bHiu4cGFW1E0r6a1ytwihrHKGxWv37E12?=
 =?us-ascii?Q?eG5HxKgHqTQngJYvI0+MVi1+tPEEBa1+nGdFKBskW/DCe4WttEwcW3UWtKZJ?=
 =?us-ascii?Q?O/N9ttBTernLzoIYZ+PUl5wzuxL+5AZZcHC/pX0QpletOYSa7w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 19:23:20.8802
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8501c636-e911-4b11-9354-08dcf4615260
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6675

On Thu, Oct 24, 2024 at 03:14:17PM -0400, Steven Sistare wrote:
> > iommufd.c:1529:9: note: each undeclared identifier is reported only once for each function it appears in
> > iommufd.c:1533:64: error: macro "test_err_ioctl_ioas_map_file" requires 5 arguments, but only 4 given
> >   1533 |         test_err_ioctl_ioas_map_file(EFAULT, 0, buf_size, &iova);
> >        |                                                                ^
> > In file included from iommufd.c:11:
> > iommufd_utils.h:636: note: macro "test_err_ioctl_ioas_map_file" defined here
> >    636 | #define test_err_ioctl_ioas_map_file(_errno, mfd, start, length, iova_p)     \
> >        |
> > 
> > Can you check?
> 
> Good grief :(  Multiple times I squashed clang style and white space changes and rebuilt
> and retested before posting, but I screwed up somewhere.
> 
> Should I repost the whole series, or just this patch?

Assuming v7 is closer to getting merged, I'd respin the series.

Nicolin
