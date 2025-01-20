Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9D816F0E8
	for <iommu@lists.linux.dev>; Mon, 20 Jan 2025 05:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737352761; cv=fail; b=bwYQqviyiwPrgHIT9b58s6JF+bN7BZQqr8USlEr8ULKJRd9X5n0dY4kKxu0I4SCUaGOX9WC4Gd/kyMyzZjbdoY31ukuASs3YNrvTIfTKaT1R+fPPCNRNBksTcSYIacquixHWC1LiKDXI9dILJKZ6V2zBBLvoZ+H4eOD+Sr3yyjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737352761; c=relaxed/simple;
	bh=fmR7wLJg1R2QPXkD7uXP+9AO5ekekKm+RV+b9PCDwxI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qMqQD0GZ1oZ7k+q1jumoO9s0Zy7GwTXMreVQqrFIAmo03SALgxtsTHMZS9AZRcUm5vF7nPvRkSJ5VOdPpQeYAu/1TBW/poTbuu7yvfO8qZFAqK0D32FjBG4T8WxmUmGp9wA7KNMI3qdv1xIS+zWqoCPARRKXJRK8CFZGJq2pPy4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=i4c0UVwd; arc=fail smtp.client-ip=40.107.93.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="i4c0UVwd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Un2Aw0uLHkVPt/IS8+MvKiuWCkF5399uz6qeMTZ3p1vlesfpnXcNaklmF7L6nHGj44V6+zSr+5ijHv0womoG/qSo5d4Qx+0Ebxv7zkzjbmlY63ZNaCDG05anoopQ4/L862XQyGLgXFjOEgkjC+sA1oUlZHvZ5pTDLLeXjNmAW+rGfeR+yIRJp6+o2cRcKqRSJbdbRe6xQxJ0jrFWigfavKqgwuy0WFnBSgZ35FFDdHKu8YxeQKk2+1bmyHQLlAUVRt6KcjNVTKP36dIZSqf4dBmtc6s/rWpaLo1j3QilftCMdE+5sbp+prvpAv8VGbmTpNxICBzie01VyxRqqtGZaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3J38cGq9plCQDOOqlKKT9OJig1Dbt/Iypelmai/oXZ0=;
 b=FYI9Dpe/puVAhHFFWTZWdUmnW0QaSA+jzlFCol32VP/2cPhQm8UoQY22weGLCbRFMtivo5+HdOF6+cLfWBpg/3fpQxVncrUUn7eXPQaDYIYBwVtL7TuzBOjPmYvPl08p3EWwW4hzVymr2N8y7AL1ld97lEZjGpglS7ORUI9PNE4voGZDeOo+lPXfgtMhm2oP0Cj9Fmb9RSbjcf37kECpVQFjgc9lxmdzBoQB2LQvya/6cJcs7TGSTroulB6WI8vFo9phNIwRSS4Zbt4UIqxxtYGdklOMgHD3V68cTXGbGdTH/XUKTqtzKDBtkd9MJAuml/BmabzTZfS7OhRH2R+6Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3J38cGq9plCQDOOqlKKT9OJig1Dbt/Iypelmai/oXZ0=;
 b=i4c0UVwdxoOuecqGwUvg9eB59/oyG+mALWT4wjiq0tlXhd44mIjqU/nSKZm0Hl8VosNdVL1da4y14o1/ZDQTwYek3wUHY4m9d/u4gq6EY8jrVsmS7JoGxPiQtDGErIm8AfMdbNVc4kc0uLwOcnU+YLT4oxDDjY4eJUXYv7zNDPJ8qKZVGwyVU6GVULSoUMDYfT6UAy5d+oXPOTQUe1g3THee6aIhzWTZSysC2gzf+u5hYEdKyn7yDmRwrnGMR/8T/KNKovzJIvqrQ9IC3Lnppm+ZzEscbbGkSIsIBVBBs5f1ye2WsGn5DHpsf+fPNTOXqn5DXtg/qBe3qlFEDZ0mJw==
Received: from BN9PR03CA0459.namprd03.prod.outlook.com (2603:10b6:408:139::14)
 by MN0PR12MB5930.namprd12.prod.outlook.com (2603:10b6:208:37d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.20; Mon, 20 Jan
 2025 05:59:17 +0000
Received: from BL6PEPF00022571.namprd02.prod.outlook.com
 (2603:10b6:408:139:cafe::d8) by BN9PR03CA0459.outlook.office365.com
 (2603:10b6:408:139::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.21 via Frontend Transport; Mon,
 20 Jan 2025 05:59:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00022571.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.8 via Frontend Transport; Mon, 20 Jan 2025 05:59:16 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 19 Jan
 2025 21:59:02 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 19 Jan
 2025 21:59:02 -0800
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Sun, 19 Jan 2025 21:59:01 -0800
Date: Sun, 19 Jan 2025 21:58:58 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: "jgg@nvidia.com" <jgg@nvidia.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH rc] iommufd: Explicitize struct iommu_hwpt_pgfault padding
Message-ID: <Z43mIgD55kU+9UAJ@nvidia.com>
References: <20250118023657.142517-1-nicolinc@nvidia.com>
 <BN9PR11MB5276F3057E4F8DFA3F22E3C48CE72@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276F3057E4F8DFA3F22E3C48CE72@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022571:EE_|MN0PR12MB5930:EE_
X-MS-Office365-Filtering-Correlation-Id: bed1413f-9757-4cde-0315-08dd391792e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U3Tm1iCHmxnvOvEJriE1Tbq/ZDUcmWkm6eynyKpUz4LwmKNswa3yrCysTNhI?=
 =?us-ascii?Q?ZMN7osoY7jMCcFEYW1+VjICXNtw69pMJbvpr+sVfxUMT/K/izeEJzXHPvlvm?=
 =?us-ascii?Q?6x6hFiWxBZEzr1ZUF0atvnqSbyTPvg7ImNjv+gQ+uXg2U8kz5q4jznbakGaZ?=
 =?us-ascii?Q?JJC3bJT2NimaJOtuLqLPZJlM2Cc8wOEQWCh7EUhA+NrsZLV9GPnQURgjgohM?=
 =?us-ascii?Q?ULVvKbIGbhUQKT43enAOCk2PaXpHW6BEpzbew9WhjLzUSae1C4jcnuwK3m6s?=
 =?us-ascii?Q?lJjMGbMGSTA9O9F1w//xvKfvnLJ/OvnpfPHfQqJRyt0U8wI+l3w64ikXh25y?=
 =?us-ascii?Q?PsaYXNJ8y6yH5GjQVczPLgfInJ6P5ohDt4G3XCdWHDYZJEJAhWOCBNzMp+eG?=
 =?us-ascii?Q?TTExkiTLuQvoigWKHUTfYAeqQx+kidChCFhSShqTOL4f9zxiGqZueRAVinV/?=
 =?us-ascii?Q?JiLYbkkbLkHVP2HQmyYA2hU4fxAUlvJj7zbr+wBYHwSTdiFc9NDfxeF7unse?=
 =?us-ascii?Q?a1gRaIxqUArqlV6nhjOUSDzk+1sHbC7MtlmEheZgfHgxnyxTiHoAoWI9MJ4z?=
 =?us-ascii?Q?bvG1VJyEqCxj5SLitBcO7qfTVGRWyIIQx8fx8ol4cMtvvsOjhd8Jr772h85R?=
 =?us-ascii?Q?Oo3HVy3HnQkSRrR4JOgUU/nzAB9iledJY109jCnWtnVMJmy16saRJFnrE/Ag?=
 =?us-ascii?Q?hGDl/AzcHqgZLHYFRNMn030lT5uDpwzKy4sK+buOg+P7t2La6wXdLD3IL/nZ?=
 =?us-ascii?Q?+OAFY6oIC+ZGILhb9oVmRR+57do/WQcVOyMm3HnQa2jHlJKbMwHwZMlmVPuf?=
 =?us-ascii?Q?CiRWys5Arnoi2QiRNiAYdB8oa/c3seAica6XB/JhU7lArkbEZw/Lbsmj+9gb?=
 =?us-ascii?Q?aQy2QopKIELh9crzwoalOkqXegwerhczxd+8u3tSi0bhKn1d+kOfEdnOLC1B?=
 =?us-ascii?Q?RsR2OBHev34sZuKvZmWyVIVnKUgCPBiwVhnH+VqlcjX97OUTGx5OHe0X7UKG?=
 =?us-ascii?Q?9B98kY8+/iCVGvdMvMqIa7AnlkhSGJ46ea/dDwlsNjkBLUFvm3abqxoXCfw1?=
 =?us-ascii?Q?XbGuzirL4Zd2nfTC0+sKcneXAdCb6Z22PAnApyC1rm70asQ9C2X7hY/o8dsC?=
 =?us-ascii?Q?ovywm/7VAOEUZminn/wLIg/IyGDFfh1Ox1aoER5UEmRQapJFRLzzO1x+1pmW?=
 =?us-ascii?Q?ox92vGfgi/2ryFvfRlm+1eXIXe+B0/xQlBs5krgcWdRUbBlanMbKLTMoN1Y9?=
 =?us-ascii?Q?JVxlmV8uGbG6jVBn1CU7gKi6+GRtlM/KauTwSz4wEksqpb4ww5rKndFrx8Oi?=
 =?us-ascii?Q?pFoXMZKCamKcxkGJI3O9YhrRHGEwQ3LpFHqTtvKUsQDVn3OrsDnoK/N3BTtB?=
 =?us-ascii?Q?rfBQRO8yE2PAyTuvAN/nLScQi21LiwcbsqoVVF9QuUxseuhEr3C6gED4K1qO?=
 =?us-ascii?Q?2RzFQ3EV0d/Z6ZIRgruGPaJFFe6e/l6s3uDwkkrV11I5AdjQtpKMcSPQj1J4?=
 =?us-ascii?Q?6XpJVN0pei6E4No=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 05:59:16.6403
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bed1413f-9757-4cde-0315-08dd391792e7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022571.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5930

On Mon, Jan 20, 2025 at 05:44:27AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Saturday, January 18, 2025 10:37 AM
> > 
> > @@ -868,6 +868,7 @@ enum iommu_hwpt_pgfault_perm {
> >   * @pasid: Process Address Space ID
> >   * @grpid: Page Request Group Index
> >   * @perm: Combination of enum iommu_hwpt_pgfault_perm
> > + * @__reserved: Must be 0.
> 
> iommufd_fault_fops_read() doesn't follow this statement as
> hwpt_fault is on stack with that field uninitialized.

OK. I guess I should update the iommufd_fault_fops_read too.

Thanks
Nic
