Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9AF1E260D
	for <iommu@lists.linux.dev>; Sat, 12 Jul 2025 02:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752287987; cv=fail; b=T00Ssac39cmfDWpELAzA85kaifKtimydpnkcw7sh6WTSfuO+Ep70VEBH90RQkS8oCc4UM5hh0tSb8faGYvDPxWceNFi24dkj6MmSeuFUPbNSGEWiSMuruFXYg9wRLgbkz46Pq4e2VnYrPQ/A4ADfOe3OGTY/fox9RVbTqKbbhvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752287987; c=relaxed/simple;
	bh=lDvliSoMhRLqaVI2y5iyIsUhekzRSA7mA3rJY5p2+Lw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cv8VmYM8+EkHlEhe1VgXqkWmc2+k4f9TDiwKxffgXiMHlA6BsVX5GspH8gEt19uLj3+mom1irODkfuTZ/pc3D9SSJHtKMafRwWZ17GHIN8ZUePcp0sfnN12pRLpe/Lwp9M0Rn9Gl4/6v6WpJ7+M+HDyGVVXhbhfdsFLCNHx3WmU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OR0XYlnl; arc=fail smtp.client-ip=40.107.237.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OR0XYlnl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ueggdvHFoaSmMA6oWCEyb3oeVuDMemiseO41/F4GCsS4Bmbbw3fjX1VVZrbI7lAz5af+2TXAo2b411GJtZpwC9jLCd+QxWM2tKL8iM0zsuJo6MFUnzGl2sRIzxO4SDvHk1URIufzEnuGzXWi/yzbOVU+fg2dmtUnHupYJIJSZc5JBNKmh5KqIG5BMu0ySFd6EZD69vDb0AILj1AfiGy90pq7b/Sm1/Ie2rchr00DaXizNaUHEUwJv/V/3CpdWvxf8fTAWtGJjvHAVLagPcRMFYWX5WI0P2294wF1d3FLzYSreVTFG8UHzzXWW/hfl61X3/RjfMKkc83zEG/vkW2qFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7T7TZ7qEsK+ENx14MWyUcgpOq60CO+JXT1/XSCGIqbE=;
 b=vfAvO23njuwskK1EyjeQI4vm7YxDbnRtlj6vXUhoOJOe/+TqQwdiGAPu+LJKne85x043dRmADvE2xFdsBqDMpOY6yf8+T9odZWtF25xihueWH0NXAw9k7xuP5+UZecdgLucrXK7EjnGbZRqroV9p+QgOKWHwmXOXg2/ltvpfCH/w13lUI4UlPFLfZw/lCtGRYa8AVAJh7x5r+ba6iivHTtsgf0NdrAxetRvcAvg2Y84eY/Hj+h42pogSlHGuyAYvByzIryRmOohknKpf26Vh4M6kWzNU9CMuI4cRUSPBGwUPiDsQ7YnxSIpR0J28fGoLaJfL3aDasp8aqeHS8hHEiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7T7TZ7qEsK+ENx14MWyUcgpOq60CO+JXT1/XSCGIqbE=;
 b=OR0XYlnle0lmwfca1mhZwFJuWt5HbhC6wbmDfWK+hGucCZr+oI8aEiuit4jL5B5iIIpX9rMhHHSAiyzwNHIs5svg9EL/nK0OB37Fi4hBT4pJ/xRAHSUj4JPon8T6KuDX4Zhwz2f+6kKQlL7HJOBwIskD0qssCWyMOeYSUNIT/ZIRXPofRo48HtrptxXnZQjctsroX85npjM9+Nwub6DZFJPxKyp0KcSeTaZ8boorP1dVR9AdGdz9t9mrpIzg3rYEtUJ+IvsB8DOFXcSydJE9cyilYzMeK5tlyTPVhGEE3f3lNU6dkjBa3TaUAHN5IYeXGmXfAjkCYktW8E2GUenWgA==
Received: from BN9PR03CA0266.namprd03.prod.outlook.com (2603:10b6:408:ff::31)
 by LV8PR12MB9407.namprd12.prod.outlook.com (2603:10b6:408:1f9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.24; Sat, 12 Jul
 2025 02:39:42 +0000
Received: from BL6PEPF0001AB50.namprd04.prod.outlook.com
 (2603:10b6:408:ff:cafe::51) by BN9PR03CA0266.outlook.office365.com
 (2603:10b6:408:ff::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.23 via Frontend Transport; Sat,
 12 Jul 2025 02:39:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL6PEPF0001AB50.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Sat, 12 Jul 2025 02:39:42 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 11 Jul
 2025 19:39:33 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 11 Jul 2025 19:39:33 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Fri, 11 Jul 2025 19:39:32 -0700
Date: Fri, 11 Jul 2025 19:39:31 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
CC: <jgg@nvidia.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<will@kernel.org>, <aneesh.kumar@kernel.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <joro@8bytes.org>, <robin.murphy@arm.com>,
	<shuah@kernel.org>, <aik@amd.com>, <dan.j.williams@intel.com>,
	<baolu.lu@linux.intel.com>, <yilun.xu@intel.com>
Subject: Re: [PATCH v4 6/7] iommufd/selftest: Explicitly skip tests for
 inapplicable variant
Message-ID: <aHHK4wfeLjikoLvR@Asurada-Nvidia>
References: <20250709040234.1773573-1-yilun.xu@linux.intel.com>
 <20250709040234.1773573-7-yilun.xu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250709040234.1773573-7-yilun.xu@linux.intel.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB50:EE_|LV8PR12MB9407:EE_
X-MS-Office365-Filtering-Correlation-Id: cb82262a-2e6c-42c5-df74-08ddc0ed5af6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|7416014|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/OGZT75fyQBggCYMjCJ5QJJRoWJ5Gr4tvCJVQ+UwW3QE6E2y7XiErX4d0KTK?=
 =?us-ascii?Q?24T057P1vG5GT4KvTyJ1D3dmV5UF+mSaDkt2pAMMZ56YMPyoUrBUiMoO2pR/?=
 =?us-ascii?Q?lCQQ3+svHhyPWVfnCoZnYSuJnrQKqTjrKvRc7klVzLDLTnhLKBOzxjrfO5je?=
 =?us-ascii?Q?eRR3xTJQYVy8clh/5NyhvhT1Zp7MGYSV6SZVwcwds79wuUveM3+73u4c4HQi?=
 =?us-ascii?Q?MQNjaWK1DWxW7Cy5TcvWokOjctsZRCFZNWJt9Y/CsBgZ3bY1uGESP5qRTw9h?=
 =?us-ascii?Q?fTc95D3ezb/CuT4Twzk6VAF7x3N3ARH3yXPDYG+iLgS9u0jBCYM3zUAfffpr?=
 =?us-ascii?Q?D1YWpClmUoG2Op0RE2ttZHpGEIjZl4ri8wDFmpruK7//kP4pn02AKAqIbOku?=
 =?us-ascii?Q?Vpk7pxxydnEaZys/FYeh3x6HOHdlWGgfgs58OAJ40L9Mwzo1qIyF+UuXUExC?=
 =?us-ascii?Q?xNjcItCDB9jtZfFSAwlLq2L8ZgJwI2zoNz3kcTIXeFyHB0fOvZEvxFuQgrml?=
 =?us-ascii?Q?/CNZs+jETIfZJa485tbxl6AcBWXuT9da9B38PN66lF62lQf5IDFSvX6EIPiY?=
 =?us-ascii?Q?TzDnHZUEhBVVqDtC1qj7aI+G2/Az7oF0oQ5AwtzZfXMFhYcp2nmoOWotNzki?=
 =?us-ascii?Q?Jrygl77vOwzqmiEWttCcPExBCCIT1y0h/ZmcIeX1KqNfvTkahAUfAct50UoX?=
 =?us-ascii?Q?ZhhCuwqWEJt/x0GrjV8SbHaeC10tr83Ui7YaAOFdZi5XBgvdjlQUOdN8YgkN?=
 =?us-ascii?Q?29ZFs8HizEBxFMwMVdVsooXXHjq4erW1TLqs9eJgx2UyQQNUDGZldWphT9xI?=
 =?us-ascii?Q?wNxV1IbUYkRy49ase+hLzuZyrJEhnCde41R6wtMTXWqF1OkDAcwIcoNuTYMB?=
 =?us-ascii?Q?njYrUWc9fBY3BZPc1dGzwpKgHlitjcxy1g4arQ/wbTNBOUM/Wccrf2sorcay?=
 =?us-ascii?Q?IDVtDLXDNKa5i3tVGi4MNLqwgog9JI/OcW6brFJ8qHeqAPkIc8QXlwui+jTa?=
 =?us-ascii?Q?mxlEaZGrIwinP1xPBI8/6dMPFry03sKdiz8aySPg74CVzzhBA/76WO93xoGO?=
 =?us-ascii?Q?moqYcF7ZggSmRrZncfSWsCPMsCZnDPWJz6VPDr3cEmm7mdWzUpSaTqfRRdDO?=
 =?us-ascii?Q?MX2wewVI8ixOrOgH23apoupJbnfwCVRGv2gRmlls7KngVgWYcQFma9C64EiL?=
 =?us-ascii?Q?t5zPdlj89b63OzKwYQuCEThdi3HBGdYGPxW4n7UPFIUpbGXIER3Xopd/bNZM?=
 =?us-ascii?Q?u4AztOhHWtfsXoyA6rrl6IbcI7kqSky6X8EBRlAKYO3TghIajp5XH/+jektU?=
 =?us-ascii?Q?SRhyOrzUla95ZHG/k/sobh+RWyRZdCFxvnT3FiAa4HGY1dgve+0NtyXjLD+S?=
 =?us-ascii?Q?ORm3F7DZqbbuKfbAjkBH7uzdyyotweoOQts5XqZPg4Nf0YzdmufRHzdE+4xP?=
 =?us-ascii?Q?M8qGuu1dNW/XEwxc1GSZv/KfrIuH0iC14DA5p5967Z3iT7LNFaz/mRKgEJWL?=
 =?us-ascii?Q?PMN9x0xg9dHEzDNgkz/PNS8mf9UY2RtPJI8v?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(7416014)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2025 02:39:42.0454
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb82262a-2e6c-42c5-df74-08ddc0ed5af6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB50.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9407

On Wed, Jul 09, 2025 at 12:02:33PM +0800, Xu Yilun wrote:
> no_viommu is not applicable for some viommu/vdevice tests. Explicitly
> report the skipping, don't do it silently.
> 
> Only add the prints. No functional change intended.
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

With one nit:

> +	EXPECT_ERRNO(EBUSY,
> +		     _test_ioctl_destroy(self->fd, iopf_hwpt_id));

Now, this kind of line wrappings aren't necessary any more after
the indentation changes. Would you please run this to the commit:
   git clang-format HEAD^
?

Thanks
Nicolin
