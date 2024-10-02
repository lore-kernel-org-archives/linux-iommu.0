Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4161C9B91
	for <iommu@lists.linux.dev>; Wed,  2 Oct 2024 17:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727889757; cv=fail; b=FHUWjOvQmbXi/MaI+n9By/sZEO+3ALK8V/sCKE8FvzHXcsnilELCnlxRpG8DP3g5pf6iEDd68ZoNCavJgNZYZHdoQsPJFxTRwYJGRClTbN9wBd/YSQq0JptHJxZmufAa66rI/GVPOlUAEfQdcZeijA6symBgMRR9jl+0w/XmMYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727889757; c=relaxed/simple;
	bh=Fhh5y/M1Gxjg87ebdszwmOJ0E0D2p8afjbaxkV0mV4k=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mfleazD2VhP8ZKgE/F5SOd2eb5gGQHydG2nsNxUy5/PlV76BPVgKV7Tb1m6piajjN51+GZnlKBSzITSYGSZ7u5beMJltMRvtTlf3l+HwjSkOBrdzJH8Reui51GfQACZlrHO3zGf+yaMlg/DiIj7i5+jANHrTJW3RKlQkl3ksUZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lAJf3G2x; arc=fail smtp.client-ip=40.107.223.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lAJf3G2x"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rvaJjd1bovKXY36QiIDjag/iL3Ruh1qMINp4kc5wjj6KGsj6SpVRhqoZ+uokiA5tWWatkhaAX1ox1xHprwx+KGw/bmYBLOXcNW39rXkScUoh6PP7E7oHpuaus773HcyEpjZ6QIaAneuvcPMbx0mSVgtj/jUESS8gybwq2YRPW2nsWWc6WVkZNRHMt4wm0TqkxyWiQvJ1ETV2W3iiV/Pr9JWyI/M0AZ+vhP5Z9T5TWk0+DyhM9Y2M4nupJYPLip1bnaL096Fa2kfyZrs8HMlQ6cja/DVeIykJATP+Go2jy+ivBBRpkcMMc1lQzf57hm9oSFq3Fd3XMr/og89j+ezEmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RkLspb3hLne4i2Ww+142R3MQCEylWI1V6qojSqY0v9M=;
 b=ZIYaZYv4ytu54Rv9lvXqdaBGHk/pPrCJKnxXLg2fLO8eApw46oUXuMfAbG1jgp9fdL4M0jjDyaNV6r+M8sWSLhxc4Rii0Dx3f44Rygr3Zm8h3O7OjzckSkQl/z8UttlMrD05HkqRczbVli7xjjGO0QAhb9z+eZ8+IN+Gwus4eNt+HE4Ukuw5J45ZudQQK16wb5Obk1su3xJAsTlL9a+HrKVELDzEdli8drePvYztHWqcKdQ9oacnyurYvZ4P2bbKm3Au9TZnOfVCB5Yb0Z1e8V0IdEiK8O46px9BLgwqh/cn3MggtWYLXNqrGhShzf4/ttpINgns1O6vkcguzIl/mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=ziepe.ca smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RkLspb3hLne4i2Ww+142R3MQCEylWI1V6qojSqY0v9M=;
 b=lAJf3G2xCEGh+9HwLQ+p/vcrII3LWLuQW/X6770qaVKQtVZDsGCvlWSSv22JFgHIy4cGhQjQFQuO124tON+/MsiZIOfWAB0U68M5Mq8CXK9l7hcko8b6HJjHdBuJSEhT+ShH/CPn613DYrmhtjOkULLjLOGuoDsryLa376M1LUTsp3qUUE6D/jUhg/0zPea1AimirqOuq6J0kiwtTWPDKJJUr48i+1hSFSrADOZVSKnSD4db14zSE1G1sEbELvF/yGjJ7SITvaXzHVHRCz5EaI0xFxjZTiG2M2LbIYwYJ53UuF37sM4GuJkoS+WOg8cfKLOWqa1ZZZU79yDCwvmN9w==
Received: from CH2PR05CA0065.namprd05.prod.outlook.com (2603:10b6:610:38::42)
 by SJ2PR12MB7989.namprd12.prod.outlook.com (2603:10b6:a03:4c3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Wed, 2 Oct
 2024 17:22:28 +0000
Received: from CH1PEPF0000A347.namprd04.prod.outlook.com
 (2603:10b6:610:38:cafe::89) by CH2PR05CA0065.outlook.office365.com
 (2603:10b6:610:38::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.9 via Frontend
 Transport; Wed, 2 Oct 2024 17:22:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000A347.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.11 via Frontend Transport; Wed, 2 Oct 2024 17:22:28 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 2 Oct 2024
 10:22:15 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 2 Oct 2024
 10:22:15 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Wed, 2 Oct 2024 10:22:14 -0700
Date: Wed, 2 Oct 2024 10:22:13 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: Pranjal Shrivastava <praan@google.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Mostafa
 Saleh" <smostafa@google.com>, <iommu@lists.linux.dev>, Daniel Mentz
	<danielmentz@google.com>
Subject: Re: [PATCH v3 1/2] iommu/arm-smmu-v3: Print better events records
Message-ID: <Zv2BRcOjpLSe+1cn@Asurada-Nvidia>
References: <20240928005143.2378938-1-praan@google.com>
 <20240928005143.2378938-2-praan@google.com>
 <Zvr4vmU7u2BY3MLM@Asurada-Nvidia>
 <20241002135728.GD1369530@ziepe.ca>
 <Zv168jJMZpxGLFmR@Asurada-Nvidia>
 <20241002171052.GJ1369530@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241002171052.GJ1369530@ziepe.ca>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A347:EE_|SJ2PR12MB7989:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bdf6aec-1f20-41a8-3dd2-08dce306ca4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FfUiAZiTLaeWiEWix5gOg9wqnqooyRw/pRdOl5Jv3BLv+S3I9+vgO7DY86/G?=
 =?us-ascii?Q?WixDEYJ34ww/pKCsIAEnYBYINWRgZJjj5NcmFPv6FSSrQWRDGqQs4EOy4ln5?=
 =?us-ascii?Q?V3rAnQeI38XaX6U4dY+AKe3Gw9Xgh0cwoDQdnHiv5d96rz6F/+w2eWmBNJ1q?=
 =?us-ascii?Q?kfO2LKTCnJqdMcOUtkfsVPxA5ccX6/Tw1/fWQBAVGfbg3RnyStAP0Z8BTV5b?=
 =?us-ascii?Q?2XrUL/i1HegWjLvyYM6CXdEJpqsFQXn5cw3xffcoM+VpB7GJE3U6pgSkGy37?=
 =?us-ascii?Q?lrShoCZ87Mcb+CYxSvKzRmBbSZiykL/F24N0pxwEgsk6MO9mfOnjefaTRl01?=
 =?us-ascii?Q?pJ5xGsALTtFQs2xv5b1jCecmJFfAuRqsFpvOF04ieeq7ccmaX+v7J5il+Q7Q?=
 =?us-ascii?Q?E/IM6Ke4sS2D2jthIHpF+NQitx5MLKSI8OWy1dubu4zirBtJiSDdfoIR1oR8?=
 =?us-ascii?Q?qPaaGC4YbK9UPIHhbkkI4n8u4tjlj4hCL+vLfSVrU2YuUoDhhWdImg4php4y?=
 =?us-ascii?Q?/cD905JFDq4dRWoy89kDpvOzPntS7PKCLBI1Pzbphvp5zZ8MB0ltXpf8lCgq?=
 =?us-ascii?Q?JbMTq8+fUraESxaMdD5qWSDXEuMULSqBUk52/TmpfsUBhJuvWt9w4t1JAjA0?=
 =?us-ascii?Q?1XacLvyNFM77S1EyJQColigb3NKB43qmX1JJEA+zuSr/MBfIBlryDobreg+l?=
 =?us-ascii?Q?IQiGu/ayHKmMNIeQ9Ig5DxBmbEoZe1vK342XLVmijhnRNG0NK8sc+oWwAk3d?=
 =?us-ascii?Q?VT71+x40zusiH+1HOtm5mB1fvQ++xHp0zy+bBsg8c6cPbw2ffayZzmJfa9Z3?=
 =?us-ascii?Q?clMoIeQ0Nchd2uk+O0L2QtiIgMMp7ykOuKBhgYhswcmxFNtYkE5b9vgKTA8X?=
 =?us-ascii?Q?m0FOrMtFakYoMtRmjRQ/17ltXuuj+YiRWPDFUmyvXLTujUzIhvAsHnLvtUBd?=
 =?us-ascii?Q?fjr1zPaODroLqkuN9WJ/qTqf9EJUchkyry+Dh0IQVvLK/l09DGSbRPepo5/l?=
 =?us-ascii?Q?kb0u+Mi8itGBXnUXRh5J/d+fxDkwoIDjR5BZiEzZIfOxjVLC3V0aNrz9V1GQ?=
 =?us-ascii?Q?VhA6WH559b4d1R3kFSZpEmv+f5QHgscL24YsbYzV7RjycnaB9g0ql9m/C+ea?=
 =?us-ascii?Q?3H29HjY0xQBMNS73r1RNrrNeQoDFJUFdvlMF7gCRasek/lG0WZr+uD6OoTj6?=
 =?us-ascii?Q?r2OemRSSFwacO2uGLHZm8boZ+SOaZdmAFluDcw/dQj2KUAWhbancmnVEzO34?=
 =?us-ascii?Q?/TQY660so3tPMJomq84pvteZIjZkpsGYJFfrqd7vvcGQdHSnIUz9DOTHmEZy?=
 =?us-ascii?Q?4NFrhsueRdfY8ctJ1hM/zoADmBZg8VpBmWuJUbrPwJVSaT+L4VBIqWzUt0Df?=
 =?us-ascii?Q?gjFGaqRuubyywULHIkyGevosCI8f?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 17:22:28.1483
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bdf6aec-1f20-41a8-3dd2-08dce306ca4e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A347.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7989

On Wed, Oct 02, 2024 at 02:10:52PM -0300, Jason Gunthorpe wrote:
> On Wed, Oct 02, 2024 at 09:55:14AM -0700, Nicolin Chen wrote:
> > > dev_name()'s result can't leave the lock either, at least not with out
> > > some refcounting on the struct device.
> >
> > I found dev_name returns "const char *" so the string source is
> > likely in the data section? If so, could the result of a locked
> > "master_name = dev_name()" get away from the lock?
> 
> The name is allocated memory freed when the struct device is freed.

Oh, reading it a bit further, I found kfree_const() at kobj->name
and some of the dev->init_names aren't coming from static strings.

We could kstrdup alternatively, but keeping the dump() inside the
lock is just simpler.

Thanks!
Nicolin
