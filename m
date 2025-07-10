Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C47E2EFDBE
	for <iommu@lists.linux.dev>; Thu, 10 Jul 2025 19:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752174528; cv=fail; b=rrc/ijSTqcqwcBjQgQhV1kK1HKlpzm1nSbAVuX8/wvgtskKFaUp1Xf5SgZICNxt8JjAk2QevFAmvzhOBKpf291FKTg9Si+rB6CfYs9hdQKPpW/nJHpQLbMchZmsVoshLgE2Uwd3rjsDi7VzkwpTEYp2lr9OIFrTsx8XhthIXhxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752174528; c=relaxed/simple;
	bh=8kUyoq5+QsyN95Y3LBUAKxA5lgVTbFQe2sfKwJ4v2nM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KWWsy186NUoXEW0fmyTOo8TP0/JkBBi++nr3gNP842ClbXkdT2HL1ZM48Y4rDCtC7Xq/JhoOqIgRLsIqZ7xW5+GUS1PJWutwh/O2+HtBfHvARrnqkWBA55ryspdOJTPoZdWZiKgH7ccmsLrEd7TlY4CKRbCEO4bFuJOPOkv69R8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=h5iQDBvB; arc=fail smtp.client-ip=40.107.223.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="h5iQDBvB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QI4Nta9+BAq/jjXPkiV0c8YlqwIx1nAyyoG2klXXqFAC0owpoEJvWj6ShlvO5AkP3X9F8hwUxdHSwExBYjN4/eLhHByNX8Ir3ofTUhHFTGggMclSd/Ein3u5v+7OxLnYkxIjxFNv/t9NYpMDPTMq9Hf51t2Fym4VCXk8seOp6BLxFpji/IR92Zhu6fru5hPoirmuxoY+xZFwyuuXbs8hE4yGQsCLI8hPYxflB5EE9cPyiNgjcxV220YIej7SObUJ/8me/hR/E/DmXL6w1AZZ4OnU0e4M25KVNGHIHeUH4bEdh4N/h7wK7DIizjXPE7ahgKZH6amvr7TsyzmMyy1gJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gsVOzS1926zFD6EgT4IeTcVX1/w7B/qZ3wEZFyXtgzw=;
 b=a40lYM4cxSyCk3FPRhHZHG799Z5oHENxlK2ryZX/mv9A9EB0/v6bt5PepCIK5p37k0C57IQpv2Wxi93qqnZcydk5/JT5MEVjqXrUQwravihN8YQ9e8JqPw9tejCfeEgZgdmUpWB0VD/yDPim3XJcyq+va08nQuq9PyheYxcc8+Yk5esCO26B7nnKX1qtLnkVokbzHAeOQ4ZVAOsrPD8CV4/MjIBEgqcIceYVlujsLJTI5jE5RrdW0p6kP+EBLURQAvv/xObPWTQkqHTQ6dyt1A6o2PtOSFSG4B9+GVZ7Ihk1bobD9GElOVQfLzyvi5rdsU/djAoLbWocDnfNII0qNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gsVOzS1926zFD6EgT4IeTcVX1/w7B/qZ3wEZFyXtgzw=;
 b=h5iQDBvBZ06vi1N3uxeThZ1ihzqsq32iU940eCV2gsZZY1ZWiLlUkEYV/saILSj7DPWVyTUqben4fmeU7GrnaSgsUtdAAjLN2G23+kA/knRrbZh6L5/HtBX8eoCiRZmAWSJB3KhapTD0NQiIkJQGjk4Nj8IQAlVeXQh/xw7QvdatTmNDhbqLzThjMuMCzByJtTI+JWymuXf3VN6eu8eFS+Gf17hLbiGGMjLBbK+llXUyxDpYHmb+xgX0Kg83VQ2gyzXMeeHJz7h6aqZoeDENXGA8EvRBQtNxDo8WbawsX9vnpxKAbHs8a71J6nKnTqBJx3+hW6cskTK/k8ImbxrwhQ==
Received: from SJ0PR03CA0232.namprd03.prod.outlook.com (2603:10b6:a03:39f::27)
 by CH1PR12MB9693.namprd12.prod.outlook.com (2603:10b6:610:2b0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Thu, 10 Jul
 2025 19:08:42 +0000
Received: from MWH0EPF000A6731.namprd04.prod.outlook.com
 (2603:10b6:a03:39f:cafe::55) by SJ0PR03CA0232.outlook.office365.com
 (2603:10b6:a03:39f::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.25 via Frontend Transport; Thu,
 10 Jul 2025 19:08:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MWH0EPF000A6731.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Thu, 10 Jul 2025 19:08:41 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 10 Jul
 2025 12:08:27 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 10 Jul 2025 12:08:27 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 10 Jul 2025 12:08:26 -0700
Date: Thu, 10 Jul 2025 12:08:25 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
CC: <jgg@nvidia.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<will@kernel.org>, <aneesh.kumar@kernel.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <joro@8bytes.org>, <robin.murphy@arm.com>,
	<shuah@kernel.org>, <aik@amd.com>, <dan.j.williams@intel.com>,
	<baolu.lu@linux.intel.com>, <yilun.xu@intel.com>
Subject: Re: [PATCH v4 2/7] iommufd: Add iommufd_object_tombstone_user()
 helper
Message-ID: <aHAPqdZKfdeEMDs2@Asurada-Nvidia>
References: <20250709040234.1773573-1-yilun.xu@linux.intel.com>
 <20250709040234.1773573-3-yilun.xu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250709040234.1773573-3-yilun.xu@linux.intel.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6731:EE_|CH1PR12MB9693:EE_
X-MS-Office365-Filtering-Correlation-Id: cbb8a8dd-7df0-4618-2157-08ddbfe52f3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Qg/E+Dz1/xMXKxe9HweM0GFKGxQ/ipuaHfD50cSY0zXqwWya63VhGDWk7noA?=
 =?us-ascii?Q?nOjpFRv7k2CnaH/zdJf+3fketgnReGJj1ybEFHlRUIttg+IDdChYFiEHSrOX?=
 =?us-ascii?Q?N0yfUHFvnkiZl2ppayNx9HCPg7NBgZAxdioa+4B67Q3KzmseZrsLxDI5zIa3?=
 =?us-ascii?Q?HllprrsgVX4o4nZ/kSTPPMyup0pgPOCo3196F1teUJsDbQQmh/SD+e9xxaHV?=
 =?us-ascii?Q?BrHZsXMXUiQ2mlHsbdVjPO6niTqPeXkhtFmTDm06PcAKutF0DQhTOJYc2XYG?=
 =?us-ascii?Q?0zJeQZwgDzERvdYwNFZaVyYBfuVcpFBS9E+Z+pywzP8jiVI6Tsvy+Wpya0Zv?=
 =?us-ascii?Q?0LPXBhwAq0rnqCDjTw/2JFgVXLp9/+o3QRUSzaAeOhw1yrfE+W76hcqT8UvE?=
 =?us-ascii?Q?+W+dYBf4PXJm13eqD/OxV0T6OYe6p5nz5zatWV2ukDe23vGmOsobPIoJou1/?=
 =?us-ascii?Q?c4+JYV6r0NoWYEGOUIfV19fZatJoZoINGpOXfByT46wMaG+JvyLvtgpl9JeR?=
 =?us-ascii?Q?ItgtVPHeB2OPI7TS9WwHMu7D3TbW5aOc9VYvUdhDtsYTzkWRVYCPAfSfQzCe?=
 =?us-ascii?Q?Uk4AytNQPh4WUkVlQh75FW7K6dQ/3Nj07JixGARrvo+M14TBilt8f9AtEP9f?=
 =?us-ascii?Q?49nlL7szj5pQzRyb0ZNvxKOheSg2QmaPNqf5qvzosF+Z1RrG2BJe8yA5Foa1?=
 =?us-ascii?Q?yqcjO0ievIeXQEXhaFjwpxl26AZtMMC7ex8wUTVgcXBpdYg8NTYHEP9vDQOC?=
 =?us-ascii?Q?517jqQ72js4+r6tebfiCEMNM0Lic0ZOEyOpTaePZi9ivV55twUiKIU5XVmGH?=
 =?us-ascii?Q?JSelnvQ3P/l6czPzHonES79NYzSMVLg3W0neKcbCv4Nc9Uzo38T2kEx7bHzj?=
 =?us-ascii?Q?ArdSLU/sK/HbEL/Dx4nrOyM7vold5E2H4JpWFE3h10p04YmAmMPTfRKC0UYo?=
 =?us-ascii?Q?b6FWQrHHhXp3wQi/jlc2JZHGcjmN4xqJx2kDC7yMK5EMn+QSVFNsc0NW8SJb?=
 =?us-ascii?Q?zSk92ZLrlwRV4mSAD+XYbea8WtLCu+Prn+6qiyxrwKRvymUnbzwO/NrSqzjy?=
 =?us-ascii?Q?4OJSynxOvLAr7dA/YRAJu+pf/Jrx0H9Dt3KmqjJKWIdjyUKMI8/SJKTS03AC?=
 =?us-ascii?Q?2r3ptTq74KB1kFTKGLoznjklKRtOSR25qPRkA20hQYJpDK8QJjrirS5opk/U?=
 =?us-ascii?Q?4dG8Z/yW11hiECiojxz9IqqwjLvXATFvdjuRXESYFd2Lxs3aHeDSUljrijgS?=
 =?us-ascii?Q?/KSyADHbiFU4ZCiA294msIhD+3xovwrgmInIiKANMS4Rx9B1CiUnGkSN3Weq?=
 =?us-ascii?Q?CpWnVgCNOfRpviyNAysE9/7JGZo1QBnXrZ9q6GAaTFaP6VWne2FBf4fxSUS0?=
 =?us-ascii?Q?bN/YqGlsKf1O4cde4nj9IOZrJ2QskEWLEeTNeQsKiryRDqdDnyUC7DXjhBZb?=
 =?us-ascii?Q?zqvfS1XiNxW73MOrcUr6B8Mianfltw/o9x2IGKaqEp3MFmVOczR2BmJkbml0?=
 =?us-ascii?Q?vLGMgiPD88hBZhroWZuYeCwO2O04tjKHR99F?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 19:08:41.6369
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cbb8a8dd-7df0-4618-2157-08ddbfe52f3c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6731.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9693

On Wed, Jul 09, 2025 at 12:02:29PM +0800, Xu Yilun wrote:
> Add the iommufd_object_tombstone_user() helper, which allows the caller
> to destroy an iommufd object created by userspace.
> 
> This is useful on some destroy paths when the kernel caller finds the
> object should have been removed by userspace but is still alive. With
> this helper, the caller destroys the object but leave the object ID
> reserved (so called tombstone). The tombstone prevents repurposing the
> object ID without awareness of the original user.
> 
> Since this happens for abnormal userspace behavior, for simplicity, the
> tombstoned object ID would be permanently leaked until
> iommufd_fops_release(). I.e. the original user gets an error when
> calling ioctl(IOMMU_DESTROY) on that ID.
> 
> The first use case would be to ensure the iommufd_vdevice can't outlive
> the associated iommufd_device.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Co-developed-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

With one nit:

> -	while (!xa_empty(&ictx->objects)) {
> +	for (;;) {
>  		unsigned int destroyed = 0;
>  		unsigned long index;
> +		bool empty = true;
>  
> +		/*
> +		 * xa_for_each() will not return tomestones (zeroed entries),
> +		 * which prevent the xarray being empty. So use an empty flags

Since the first "empty" and the second "empty" are different things,

> +		 * instead of xa_empty() to indicate all entries are either
> +		 * NULLed or tomestoned.
> +		 */

let's write something like this (correcting typos too):

		/*
		 * We can't use xa_empty(), as a tombstone (NULLed entry) would
		 * prevent it returning true, unlike xa_for_each() ignoring the
		 * NULLed entries. So use an empty flag instead of xa_empty() to
		 * indicate all entries are either NULLed or tombstoned.
		 */
