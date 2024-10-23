Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD5F1D1E74
	for <iommu@lists.linux.dev>; Wed, 23 Oct 2024 20:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729714565; cv=fail; b=eaoa0X2rxLnPsWPXsTWwimivJwKaiBrD9FTPpPz1wsk+N47l3wEXwewYI8OoY/lNfHw1N0X/uVUOPH65Y8Fumzx8Ub2YJbur07ZqO+5c32o6GcZwZFW6Bk/rQEZdse9Hk0e8nRVvi6NSDlDqGLuI32HI8RpY4ZfrfdQDB84wAXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729714565; c=relaxed/simple;
	bh=YlKb3kEgV3OYdo6FfAK9eo04PQ+uQX1g8qAxtDmZUBY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OdQ0EgxtsKXCxqE+HwX/dbxmseq5gil2c/E4OzGeGaoUjk2uXy4YXklwmW6h83G61nEASQa1lAPTpFsnlzbVqKzsxODosDlGLQWas9J64S3j5+r1N1JK3nq4+KBvpJKP6KTUxM0SmR2QH47+VN42szkpRgdecXQdsz9LScsFefU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Sxn7IxGE; arc=fail smtp.client-ip=40.107.244.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Sxn7IxGE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wxl/MuVW6bMu1Trr90Fw0wECJcN2txeCSaMvbOYMZ2p/PUWNPyVp3dH/S/W9r/zkerhPUHvv0YkT3BX/tdknirjHUBd5aaTlQBfSlkvFVsdjjJxb3x//sW1jZivJRr6INtWrCje21OEgZR+lRcR3hEPwskAlF76X2To3Yg4PlS0nRgrpaQ0p8AKtfHkx6gsPfFpdAFTpotWx1/DD0tdovaXYBkTPFbNRdK1ZsgMaGXBt45qMfnPoJR3VCC1GH2q/rLP30laeE3m5yN9VRYDj8RoS920nZbxDxGwtcsefVL8eetgd5+vUyNcywV6f6RwDX8czjV7btdujcPGd67S/lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5wQfcuzSL4HSBQlY4o1O6czrlZojp8FMKFnXwCAsHwI=;
 b=LDxfzsVI76UQ0KV+4fOE2voF6otlN98qKWP/KLItITOsUXKVvl/2SQnKJ6sZVlwtbzGlPuwRlcnyqnt7FStgf3EXZWfdxZR3MUjdGJz1dZPQOygd1fJyxFFEsC9PCNeV6TwZQN8jXRAAnpHCbRPkzQoJp33ZiO6yy3dLKlvbX+elCQGm0asB/TPVcRWNmCCJr5es7bLF1/VjzzNZr4mNzOcspzMjURs2nYfArUEvV4yxvMOQ8m9wsrbwO09w/kJUmTS9NMeTvUeN1bWq6EHfL8LdTNyv5UMlMKDFzhnZRO8lZhiY9AAXBLVLPSPiInjiiWBI0pgCgA6tRdl1jqn8Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5wQfcuzSL4HSBQlY4o1O6czrlZojp8FMKFnXwCAsHwI=;
 b=Sxn7IxGEmPDvVt3VLYkN5h9FBcxFEFwJoC1atdHfPlPs36wnEndt43505ZmXzCMtiJC7+XoNlJGWM3h3BvGt7ivgw7ZdvCdVZidr9XCU/53i4WVfjSRiS2VMfIjeRYGxV8xDyrNGs1VvDjyT8EwahgLh+6BHPoRfZbC9ti+yinBCUGAs/8t9WcBzYNwpnykI+KJrQvyAnKCjOVSsLU3bCg1M25vMON43j+sVr617TgZ1OFIcJOncnwRE97px794VhlEFdnDSfgcyxfeDkQVK8KAFdM0GentgJMPMSi6+AfhttvZxBGSE4r5tRmwzuRfTWXXni5VLR51nEIXNtFxjOw==
Received: from PH0P220CA0010.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::20)
 by SA1PR12MB8966.namprd12.prod.outlook.com (2603:10b6:806:385::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Wed, 23 Oct
 2024 20:15:59 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:510:d3:cafe::80) by PH0P220CA0010.outlook.office365.com
 (2603:10b6:510:d3::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16 via Frontend
 Transport; Wed, 23 Oct 2024 20:15:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Wed, 23 Oct 2024 20:15:59 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 23 Oct
 2024 13:15:43 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 23 Oct
 2024 13:15:42 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Wed, 23 Oct 2024 13:15:42 -0700
Date: Wed, 23 Oct 2024 13:15:40 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Steve Sistare <steven.sistare@oracle.com>
CC: <iommu@lists.linux.dev>, Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian
	<kevin.tian@intel.com>
Subject: Re: [PATCH V5 9/9] iommufd: map file selftest
Message-ID: <ZxlZbBP3XE6alSPe@Asurada-Nvidia>
References: <1729630838-24586-1-git-send-email-steven.sistare@oracle.com>
 <1729630838-24586-10-git-send-email-steven.sistare@oracle.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1729630838-24586-10-git-send-email-steven.sistare@oracle.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|SA1PR12MB8966:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a17080f-6098-4894-9eff-08dcf39f826d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JwFxZY/XMm+GM61AhHJ8JaiEV0EQNWF3SLGQdMyN3CpmyVl6l4S8pH8jQYkp?=
 =?us-ascii?Q?3DBYr9zVNTpFYC0nGRKbTuXRM7xHGdQ+r+U/Duen+YV+7sCU+pNQLGMboAC7?=
 =?us-ascii?Q?o7WEuE7Sn6LN9XihOaKTo6Obd/Xn+G5oOcrG/U6VKrLvkvoCW9e3dXFxNjrt?=
 =?us-ascii?Q?15CH2hIw0j27iHDYGqTVYlldXVgYhJd/6Ui2hQ1kFa3NBRzdZcAstkeveaYT?=
 =?us-ascii?Q?/9Qsrqn13lk9FXSRf6FEkawTtB3ykwTbNNcTOk/CNqKLqOdkP9c/DZEizwYM?=
 =?us-ascii?Q?7KFg1gfo9eb7MI3wegmqiagxhd4KYJMJm1VWPc6bvFD+Y2VFpaRLMYkdsJ9z?=
 =?us-ascii?Q?5ahvkZaSKJ+iLPOPRscCQUVEnUcfpxt9ZHuEPxOPtLPOK6w32uiR0zR1tpEM?=
 =?us-ascii?Q?dhOhZM2H2ivwZJ0KK8QQr6vZaZV+bYTwm+swbBS3KSpnDVkxrSZGAGprKKMA?=
 =?us-ascii?Q?GzPpYq+cpe9e8EsFozctHNRNCvasLAT5NobBME2XjkTvElBLgefLeOIufygm?=
 =?us-ascii?Q?YqDc7XSeWUOzTaVOrLeU6Lsof1JcDES2e82UVG5emFuH/DdtOFUH5JwXkfkx?=
 =?us-ascii?Q?Urz6TzpAZL89678bWZ+umJQURpGLfOSia9U6INBxNsuaoXuCK9XpKcrx+AD4?=
 =?us-ascii?Q?xROoIcP6LGGTcJNf8FpY7wqxVJmHf/2d7HE9TMhoDC9OMM7cjOgXuTHQ3kbb?=
 =?us-ascii?Q?zV1EUlG4LGDtTEiM7XdJzrQNDsOAHC6gjStlG7sbHCI0kEXmYl7k4OKWvph0?=
 =?us-ascii?Q?I3GZIJZQ5qg/lgR+L9q4DOPrtaYoV87DHFEtUCu4FGwiq4rLYjKsMIDOwDgE?=
 =?us-ascii?Q?pEZwRvPkAddPXZIyRDHRPRTQ5rDZYWl9vbl4uRTwJMLGfVh9bSKlMq6jP54f?=
 =?us-ascii?Q?lzZG9OLyhmH8EzDjlXolpFYOlVW3jhHXoANsDU2tZf0U+Qou3+qWBwUhJ7NV?=
 =?us-ascii?Q?BlQUFN42iTu27mwuSGG0d2CswhWW6VZER0S1/1dZCu4UUxAeY7vy8l0zJ6Bj?=
 =?us-ascii?Q?XPWqmVkAftWiB4NrHqZ413w7KQTFjH6iriWuJs9n112gqq3Npo5WjavRCP7M?=
 =?us-ascii?Q?EUNkUyQfPvDe2QgdTLtMbDx5O5mXr7GXwRuub1a+CIFPtqF7P6hDTf1XZPDn?=
 =?us-ascii?Q?/GhVEwcbEqfqlRNRplFOHq5XNu2N0H4bbj4zgI3PU5ldGb7DU0C9HUcaFGnx?=
 =?us-ascii?Q?HmXvYu4xMl1VaybuLXcQ2SMwXuhxrGrd8I3Pm3u5EvKSZXXwWHVmLsmfhyxS?=
 =?us-ascii?Q?Pd+EPaFKP9MUTMtMVgpqP3buDMUnP53YBVZQQRZyxP5iYxtx5ryUT4l+t/aB?=
 =?us-ascii?Q?NSsNRUUK2/iLbOhC1KdgkUe8SnsYMRU5o7rn3KrYlQRPp4kyPiDVmxc2I1tq?=
 =?us-ascii?Q?k5r1RSzssslwDsX+qg0qxklpONo/R2JhhIBOqJb9Vyld79s8gA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 20:15:59.2245
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a17080f-6098-4894-9eff-08dcf39f826d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8966

On Tue, Oct 22, 2024 at 02:00:38PM -0700, Steve Sistare wrote:

> Add test cases to exercise IOMMU_IOAS_MAP_FILE.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

LGTM overall.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

With some nits:

> ---
>  tools/testing/selftests/iommu/iommufd.c          | 136 ++++++++++++++++++++---
>  tools/testing/selftests/iommu/iommufd_fail_nth.c |  39 +++++++
>  tools/testing/selftests/iommu/iommufd_utils.h    |  57 ++++++++++
>  3 files changed, 217 insertions(+), 15 deletions(-)
> 
> diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
> index 4927b9a..3d62951 100644
> --- a/tools/testing/selftests/iommu/iommufd.c
> +++ b/tools/testing/selftests/iommu/iommufd.c
> @@ -3,6 +3,7 @@
>  #include <stdlib.h>
>  #include <sys/mman.h>
>  #include <sys/eventfd.h>
> +#include <asm/unistd.h>

Can we add it to the top of the list for an alphabetical order?

>  TEST_F(iommufd_mock_domain, ro_unshare)
>  {
>         uint8_t *buf;
>         __u64 iova;
>         int fd;
> 
> +       if (variant->file)
> +               SKIP(return, "redundant test");

Why is it redundant? A line of comments maybe?

> +/* iopt_area_fill_domains() and iopt_area_fill_domain() */
> +TEST_FAIL_NTH(basic_fail_nth, map_file_domain)
> +{
[...]
> +       if (_test_ioctl_ioas_map_file(self->fd, ioas_id, mfd, 0, 262144, &iova,
> +                                IOMMU_IOAS_MAP_WRITEABLE |
> +                                        IOMMU_IOAS_MAP_READABLE))
[...]
> +#define test_ioctl_ioas_map_id_file(ioas_id, mfd, start, length, iova_p)     \
> +       ASSERT_EQ(0, _test_ioctl_ioas_map_file(self->fd, ioas_id, mfd,       \
> +                                         start, length, iova_p,             \
> +                                         IOMMU_IOAS_MAP_WRITEABLE |         \
> +                                                 IOMMU_IOAS_MAP_READABLE))
> +

The indentations are a bit odd here. Would you please do git-
clang-format to fix them?

Thanks
Nicolin
