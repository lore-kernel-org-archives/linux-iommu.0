Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006BA7485
	for <iommu@lists.linux.dev>; Fri, 18 Oct 2024 22:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729291911; cv=fail; b=tGswBHDNdDAtlDEZnNDErZxp/oE57BeKA/w+WtP4PPNxB6j0/gD0z7w8Opiyl2JV3Qf6Avws7MZEsyjhytNhjnUBLG6pGyyCcd+RtepOuMN3ydmbD+WEd+n+3nfADsjhr2tmMNhCqpc59ulTqEPpx4AtXxg3IiXjbYA1uOSX2s8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729291911; c=relaxed/simple;
	bh=cijnkhsgt5uohqIFr/YCl6S5tDY2wJBEZ+319Ymk1fI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WlL8NEGXqHgSEQL0IPqT1ekXL013jWYK/nQo7wNs4H6vy6wGL6dTfxVuW/aS+CC5Vpk6gvurdsvUZpIauc8s23lU3jpuv6O0Rs8JaR664p1Yg0aSNBNUM9AilJ1SpXakKseknOZZasXz2z7POw3lr83mTNohI107c7eRsHPLWtc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=j6KXx2WC; arc=fail smtp.client-ip=40.107.92.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="j6KXx2WC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xU09xPYc8kqGjQHPUy3Yxg597aMxU18IL7TUSfw9LAZYiFx5FsTEYUV6mhJ8wXZMtgamOBHMbpZJlvLxvdkFatIadkMj8iTaM4TvlLX0O0MERuZeO4PTopZEZYoYkUJXn+2WMVIfDesPyTElznq04WYK74FJsHTujLKSi2sAT3nIT6R+hcP/l209TcNEAQs44Pb3M5dKWVfLFN0KhxkrSpLwrtYbvNKXlKgSoeDoXe38HP8jAXKv/SbNrDaCUWPAvURk0fF3deBC5MfeYCWLp3k7Rrrr1gpKQDSJRP9hMZqiv1LeOUmzfuhs6V48Vaqj/ze9sBmSyX0pUpGXhTIw4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BXVccTb78YPBdL8XOyj7dYGXo2k0W4xgBXY8uVsp5tY=;
 b=xup3Ti5wg5VfoZ6ZhLhV7fIw8cBCk8vZ4eI+fZ7eY5TY52RVfvCUtNPdBtmJNFKH3ItrJZkseaFKrPv60GLVlmgP4bG/K5+w5xz4yv2tDUS6hIzkG3ZQM5xMRioKikIfa5KdyaimwVUN+lpuPVgzYIo4k6n62RCoqncceGjLLTq11PFeNf8ylkLGq+PIWHw8xSznzM252MoDVEuUJG6CBDQWHbfeGJ9Z3KT+vY7YtccwH0qRINPeqkWmIFvQkNhXJ7Nji3SXR2n3UV2hoK6/bxKoTQPCa6kmBhi67qFRtAEhBNpWBuituCgi8WXOq1PZccNgWZBG6W982mJJGS/u4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BXVccTb78YPBdL8XOyj7dYGXo2k0W4xgBXY8uVsp5tY=;
 b=j6KXx2WCcVx+WChhHQzNSlZGQ2wDUTgpBPnnj2ucou+g5B5D2kOyW3AYuY8I9eonWEuqsJzPZgnEJ2+YyeyHHy2sy+t5+fs80kmQASXY3k+R55s+dp9Q3PpSWeAwWt/MT9JqZuVdJ3nZ347K8s7LDllzBNswRWuE5UnY6BU2ilnIbD4Am59n7KU+cTisZ7v1P8p1oBuBBLTJ+iyTnDidlscaB8fGhdOIZysWHTSdWyJwQghOJeZv68DNxrCeujwQTcsWVj/yqCpB/iEGHARGCGHaCInlYS/rkYxLXJZo6pNO3N88jP7TQK5dvFIuPvsUnG3Yr5/PjJ57pYaJUxlYQg==
Received: from BYAPR05CA0089.namprd05.prod.outlook.com (2603:10b6:a03:e0::30)
 by SA1PR12MB8858.namprd12.prod.outlook.com (2603:10b6:806:385::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.21; Fri, 18 Oct
 2024 22:51:45 +0000
Received: from SJ5PEPF000001F5.namprd05.prod.outlook.com
 (2603:10b6:a03:e0:cafe::c2) by BYAPR05CA0089.outlook.office365.com
 (2603:10b6:a03:e0::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.8 via Frontend
 Transport; Fri, 18 Oct 2024 22:51:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF000001F5.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Fri, 18 Oct 2024 22:51:45 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 18 Oct
 2024 15:51:45 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 18 Oct 2024 15:51:44 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Fri, 18 Oct 2024 15:51:44 -0700
Date: Fri, 18 Oct 2024 15:51:43 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Steve Sistare <steven.sistare@oracle.com>
CC: <iommu@lists.linux.dev>, Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian
	<kevin.tian@intel.com>
Subject: Re: [PATCH V4 9/9] iommufd: map file selftest
Message-ID: <ZxLmfyfXJ2wN72DD@Asurada-Nvidia>
References: <1729286856-127844-1-git-send-email-steven.sistare@oracle.com>
 <1729286856-127844-10-git-send-email-steven.sistare@oracle.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1729286856-127844-10-git-send-email-steven.sistare@oracle.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F5:EE_|SA1PR12MB8858:EE_
X-MS-Office365-Filtering-Correlation-Id: 28b977f7-da5f-4233-7846-08dcefc77106
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6IPtHyCcRWod+sVXDF2gh6UU4FwKFrZvdw4Bcbg2WXsmP0ncRMO3kE70cGO7?=
 =?us-ascii?Q?w7je8qY9Yur5AiyN1E1/YgWQDKsjk+SQg5tmFuXyHeq/in+VEx3q9Wtn0BzG?=
 =?us-ascii?Q?jtTSLRlm0nakrN5jf7EeOWkr8N7S1kOfwjz0GQuJ6UBz6/Y2XqY9dlwqd5bM?=
 =?us-ascii?Q?/5/tm+h9kKOSdGm6gzsQ/ZGSNA/0IDuEREiJHDtncShwNJvhlV3LZj4iTo/4?=
 =?us-ascii?Q?rGcgqpDeklRAeBMwnAycc3wQrDylAJPXDDpe1OnnbRxaiIsp1P0A9et3TqpY?=
 =?us-ascii?Q?aSqQF0j+9GClPeda+mnUBdD4hpfqdIyr4JZLwrGqG+1gN8ZpfdqutrL5R9K3?=
 =?us-ascii?Q?JleUwFLVzZjahDcGVmR07x9ZlMIai5Q0k4XOivvshoFM/x/hSvDzX0KA4aoD?=
 =?us-ascii?Q?pQHdxfQdMf0JlLwbHdN4gIT2HpTaOgaWUjftGLVh6BibVjdP7SFMAsUdsjrS?=
 =?us-ascii?Q?lgRHegwIzaFp7OBiiDaL76rWzDdhSgpTdMjgfsiEatepZUBjzpTJOnAPY06R?=
 =?us-ascii?Q?9CHHDqUtFf6DM3Zb7KbAUdBdmJgF0o8rYtsSLS8kgWnlqle1GpRJ9EeF0qeS?=
 =?us-ascii?Q?UdjHmjFczypKoBrrsxIWUqcmmcwgAJEwF3uVHjqLLeUKpd471wuEE4ZDHWeV?=
 =?us-ascii?Q?zMi8pNDHOCNgAoOicfGBskz1lrOBNWCwmTpuQanMKzUQygnjGPpKuKAME1oM?=
 =?us-ascii?Q?WqPn+aU/ydPATkx1VyxE9UgYEwAYS/OGi04cw0a/I1Blcw+ZXmKKPkFRhNzA?=
 =?us-ascii?Q?NI9xBLiXssKZjuxUMYlZYnmAfqLW9fGuMHxIgMxZucValIctDX3JyqKcP6F+?=
 =?us-ascii?Q?55ck8aD7jSs6XjWvX9+aTv1xOezemQUmEE9NqUQqqnWF5CyM4FtcBKrdPyG5?=
 =?us-ascii?Q?ho3ycq0sqRGJ4pmIJXWyrlfzhyLsO+CeHLg3DzbQGJfZac8VUUHXP3Hka+SG?=
 =?us-ascii?Q?CkZ9l6XWoDrE/C5dVmjtNQUyF/MDGbjPociXE6XvaydzFrMJ4ttYOv7arByC?=
 =?us-ascii?Q?Ot+6tBRnxwe32Udzu+YLHAjvU7en7tOLuIyBfhj9aL+S4xDZhimFveUcTP3B?=
 =?us-ascii?Q?6Y8LM2GPgItkmeBJ96LykEJjq/7xZIYAZpDyvIewlWyJoJ2hcI0InvVFVvkY?=
 =?us-ascii?Q?3lczP8/cr570kCYPc3w4BeM9XNH4iW2vZSJwX9ttb0ml2kXYsWk3nXYUUm5X?=
 =?us-ascii?Q?dp15SQcraLDnV7t/+uda+AxjQ/PemOAVfpaXkwENN3tNop0tKlxMZok2D8J+?=
 =?us-ascii?Q?PcGMPUf2x4l/iQOBssQHUYYw7IInFQuUgY00FOMLe/PhoKMdbAeCraiFeQ6y?=
 =?us-ascii?Q?ghuoxo6ZFtjmkgvZ3596V1c/hNl9ebK7avtoPcg0zh99BJQe9CwMM1mq7IEL?=
 =?us-ascii?Q?l5W5erIMaRavg0Is7xqJ47YZnJNTYOVlwg9QaxBYtWHdrnIjwg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 22:51:45.3391
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28b977f7-da5f-4233-7846-08dcefc77106
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8858

On Fri, Oct 18, 2024 at 02:27:36PM -0700, Steve Sistare wrote:
> 
> Add test cases to exercise IOMMU_IOAS_MAP_FILE.
[...]
> +static int _test_ioctl_ioas_map_file(int fd, unsigned int ioas_id, int mfd,
> +                                    size_t start, size_t length, __u64 *iova,
> +                                    unsigned int flags)
> +{
> +       struct iommu_ioas_map_file cmd = {
> +               .size = sizeof(cmd),
> +               .flags = flags,
> +               .ioas_id = ioas_id,
> +               .fd = mfd,
> +               .start = start,
> +               .length = length,
> +       };
> +       int ret;
> +
> +       if (flags & IOMMU_IOAS_MAP_FIXED_IOVA)
> +               cmd.iova = *iova;
> +
> +       ret = ioctl(fd, IOMMU_IOAS_MAP_FILE, &cmd);

For a new ioctl command, There should a TEST_LENGTH in
TEST_F(iommufd, cmd_length).

Also, we might need something in iommufd_fail_nth.c too.

Thanks
Nicolin
