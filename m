Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7756C12B71
	for <iommu@lists.linux.dev>; Sat, 12 Jul 2025 02:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752287217; cv=fail; b=XQ1J2Ih7RgOgHd3279qpMUWV0yUQVgBi6mhf9q58X91nkluI5futbFFlk7+SF6wce+Ru9YxMnY1VZRD7KPa83T828dmZCiihEQ0Nh9uuy+gRqyUP/JVeXQ8E862ITN7bIL3kgxFcy/Aw7aoUAVCc7Qz85V8zz1Vqzh83X7IQhNg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752287217; c=relaxed/simple;
	bh=m1z0c+cZRdFoBE9lqWKdBvWi2GMCXos90ikHOCXCJJI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VT+KRm+PIyJzr2iuSQfUAyjFByM3K+mlpQ0N+qaWFoTDXFR1t58VmxxIM5ZJ6HVg4Vv0DivPB6mpx4CCXRIfJakJZtWJJX7QRJzxkjBXlOGPKiHRrH5824+aCo8OzyL6H51L5N6DdDL35elf8uWIZQGonStBQtamAGhfpnZ71EM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=F7jndW4v; arc=fail smtp.client-ip=40.107.93.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="F7jndW4v"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bVGm5BSi84dQIt8YOpNXYdEIzoRyE+4wTj3sUy/L+bEIel41UK5XIFcAVRi4KhFqYxTG9MifXHr+5TVpEvE42LC8CYM3q89XGAER7KaA8/b2xaS/9rvyxdCB7owqu1paOmLL+5zsTG51WWyPYrBbJEHlbcsSm2oUVB2FcxLHcBmsaw6E3eKBJdiSFZ0FJMLCYkd4nq7KmdrjwowgdHldXAITz/NwnzOhmho7AGrSTmQFPhPnp7rWlrAbtX2QRQjUCzHm44z4koD3zJw4Nni+8ibIkCfteVI2SR27eJCEX2x9r5CXZswtS1+o4EzuAnRzxM9RkwANRbxJZs4n6/i7WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kh4uNxWUktFpzhugPknhC9aWEZbq9682p43rL+QsaTM=;
 b=K6Ka3/WHRQ8SL5CIPkpsybgZ1P6Th6iR3DrUObGcHfeOeGC3JOhh8QOYDdzjvbogqIK3cDL+TBlPVDVPpnUHJqwCaEIA7P3Y6UMHr1MXZviAaywxUNxXIkFzEzwbY0QcLH2WOZqTh4X7WxSNzn7VTATNZ9zyvZDwl09Q6990TCmksnPEC9VdDqGIXsK+tv4UIGBjGpBqo4nCdBBsx03rWpV0VZ3nVzXmljIvlfz0GNO7+Ag2v4/DYTFLS51pBOmWqKd8kCjMDhxcCoYJgG/JgVjFsgb5fAYQlOu5RI8mx68CMbV98A4obipuC4kQQzS5mbX0VSksEhinb66MXWzZEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 216.228.118.233) smtp.rcpttodomain=linux.intel.com
 smtp.mailfrom=nvidia.com; dmarc=temperror action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kh4uNxWUktFpzhugPknhC9aWEZbq9682p43rL+QsaTM=;
 b=F7jndW4vY0PIfG98B79URmOXqt/h5HH2wFhUqSPtf2WD4oVwgqJKYwY6XHb3TgI6X7k3hdFRcBeTNMOSgmtz2HO2/K8GgT/LbAM/1OVYj3vfWBSqk+ZU4M/nlI7eKpndb9ugcLS7nSE73UM6Q0DsFxQZGb4/DtGt31rjDmFnhBfW6J6PKF5bQhcEGvPU+JrnHUAAwb3JLSyO3PZcg+ThOxBaMclPK5HTYKK657ALDWHS5WVbXCIq4FdcwK9T56GDZTdlGvYO59MA9eKzr92bXJmYdXsCDk/VqdSPhiEQK9TnhatvYzkq2GLHoJ8Yb5dEq5j73miVNjn16XtmD8zqrA==
Received: from SJ0PR03CA0185.namprd03.prod.outlook.com (2603:10b6:a03:2ef::10)
 by SA1PR12MB7150.namprd12.prod.outlook.com (2603:10b6:806:2b4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Sat, 12 Jul
 2025 02:26:52 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::d2) by SJ0PR03CA0185.outlook.office365.com
 (2603:10b6:a03:2ef::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.26 via Frontend Transport; Sat,
 12 Jul 2025 02:26:52 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 216.228.118.233) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=nvidia.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nvidia.com: DNS Timeout)
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Sat, 12 Jul 2025 02:26:50 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 11 Jul
 2025 19:26:45 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 11 Jul 2025 19:26:44 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Fri, 11 Jul 2025 19:26:44 -0700
Date: Fri, 11 Jul 2025 19:26:42 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
CC: <jgg@nvidia.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<will@kernel.org>, <aneesh.kumar@kernel.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <joro@8bytes.org>, <robin.murphy@arm.com>,
	<shuah@kernel.org>, <aik@amd.com>, <dan.j.williams@intel.com>,
	<baolu.lu@linux.intel.com>, <yilun.xu@intel.com>
Subject: Re: [PATCH v4 4/7] iommufd: Destroy vdevice on idevice destroy
Message-ID: <aHHH4sOeQnR7xSK8@Asurada-Nvidia>
References: <20250709040234.1773573-1-yilun.xu@linux.intel.com>
 <20250709040234.1773573-5-yilun.xu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250709040234.1773573-5-yilun.xu@linux.intel.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|SA1PR12MB7150:EE_
X-MS-Office365-Filtering-Correlation-Id: 4297572a-112f-456f-2d93-08ddc0eb8f22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sV8eUJlfkT5kS4CvapVfNGGosHNoXJTjkVxuA9KXoM8RiqFY6XlpaHkuGmf4?=
 =?us-ascii?Q?QZfJRfo//9EpRwavTDfaKlWJERd6D99rW3tJ9QLesd6zeppl+lBvv2kPlBFp?=
 =?us-ascii?Q?u2d5iKMLxscG5FrEkZC0lDSHAblEYKr0mARu8nbpv+hqkvH2fOwq/0ht9UJP?=
 =?us-ascii?Q?3/3C76bj6yA3mgWwPNhiXnIVQKYuWxtT7niHAwdx6lCbEPVWlRhQVP99Ejgb?=
 =?us-ascii?Q?6ErkP/Mzm1RW4dXsYj+AIMSIB7RplVOYQjypG8nh3ud0Oa9s9dNWOV88f05X?=
 =?us-ascii?Q?mdrArCmNvAr2W5mKFcO5Wu58SbcmHV6xlTpDwnQd1h+r6jTcaLIFLAzQo4CF?=
 =?us-ascii?Q?sjYajiMtAsouhGyyOhEfnATLzilxlkQvj9BWpBDKEAwJwokFL39Cni5afKRm?=
 =?us-ascii?Q?4TCWABR2a690ofRPT2Tf2qghMceKcfpUHqBDpXPuHjT7xtp5CaH1tOvrlEbe?=
 =?us-ascii?Q?GJ37R7WnfO4EHFgF6+kB0E5Y/gym+oUyPlcUO+mz2AM0JgudG4qsRZ7amw8H?=
 =?us-ascii?Q?fvnq9kbSvCnjEgxKMFa62KZfR3rybhPeP45LoPPuYwhM/E1AyFBwIdqJq5Gg?=
 =?us-ascii?Q?R0o/fvZLHpKSY+pnKftLsfjJgEWWeEv8OoJa/3k92A0DseoyvpsGd8tPOl1a?=
 =?us-ascii?Q?BUeTZsE4waPJwkZAsu7zhJeOnv0tVLcIQdACEYh6p+/OAB1uXCBuIqwqg+R4?=
 =?us-ascii?Q?MXEFVMsPjn/cQ+Iy9WVNMAxzjXXh10SP5L8ARrlavr2+TUFnWUgq3caARRYk?=
 =?us-ascii?Q?/8UnOGmOHMe+XGWxZNYnpwZ2SXSJJ18GoZCleJ/Z65QDn8n7mZhrlk1z+Nza?=
 =?us-ascii?Q?ip8qRddF3NBIxK3lezSIKbuS2jQ7e+461LMtwAyfhG5FG83jZ0/BsZfEr+bB?=
 =?us-ascii?Q?AhAW3/pPrCOmkJH4owO4OnK6O/tUMVgKI1P4+zjwYFChDPcZrcTqL5Z8/hQn?=
 =?us-ascii?Q?MOqZIyS6Vkihd3treK6stO77uwdQPs7PQFfodDMGPFPyBXtF9r9LZfN/u6kr?=
 =?us-ascii?Q?4mx3to3LHGGQen4FQRn3PzVQFgghAADBPHe5Ck0PMd6SQFN4yw8TwKpzYtwN?=
 =?us-ascii?Q?WvCIAKsqV6J81byl4xJMmIMWbtoDaeAHPvM7NBcGZVf6kX/6qsVLzaTfs0ge?=
 =?us-ascii?Q?upUXqfCDSACMmRdl4EvDl+t80BgRnUOVG9Ksy6FHmgMt49qzT3crvpDUXaFr?=
 =?us-ascii?Q?5T87vWWXZE37bMsJwa+aF7Md6MMGhwOOXgJNQ8Zq8CBhTZoKPhQYeRpzLDws?=
 =?us-ascii?Q?OoiZqXyZDOa3UfUVRq1C/G3FlV+VMtxIrmWvNbc6UeB3a5GC0GFhl0IgXb05?=
 =?us-ascii?Q?y4VC2bAHulUsOtp5g/ZNrr4f8VBNUf9HvWMTvx+MiePBwvekd7LNwNt1FvZW?=
 =?us-ascii?Q?9Sm7UHAA9Fk9OmI/Ibq99iIbh7S7tvS35UnnLIJzDdOyDT8iMCU1ciBQBpyh?=
 =?us-ascii?Q?tfwAdLgGFBcJLUz2VUxlAwCTSZThSC+kBmGxgGm2BM6E56UrcixEIBMMnnq3?=
 =?us-ascii?Q?QuBB3aaOxuks+DFvuXiUDoQZYZN9EmIEFjMR?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2025 02:26:50.6594
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4297572a-112f-456f-2d93-08ddc0eb8f22
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7150

On Wed, Jul 09, 2025 at 12:02:31PM +0800, Xu Yilun wrote:
>  struct iommufd_vdevice {
>  	struct iommufd_object obj;
>  	struct iommufd_viommu *viommu;
>  	struct device *dev;
>  	u64 id; /* per-vIOMMU virtual ID */
> +	struct iommufd_device *idev;
>  };

And move this next to viommu, please.
