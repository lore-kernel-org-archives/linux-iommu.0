Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7266C1C6FFE
	for <iommu@lists.linux.dev>; Wed,  5 Mar 2025 17:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741197000; cv=fail; b=FBDPXF/pUYATVej50VwGD+BZSoIHgj+6NbcHV4+0ynvpTEMfjO7T3MlAxS4Tzx4IrDz3T04JVWUeGUni4UsZ6QVLSZW1mkJeNfpCV3KVQLk95QnJQ7ALLXk/Dd+yd5M2Y9WVk4u3ShcivgN1DFyEG00+IDygjtyeiOAWEKZilhI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741197000; c=relaxed/simple;
	bh=+ggeEFpzvXSI7zpMbOEYJm/MJXQb0z6WEbpXvryp/uo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IlzR7M2yTZT0IAC3H3OM0ATbm6r6XBYYgMIhF1Yw/NqfPc9YoqznCpPGPzAw/aA8wAyrjdCS8T85Tn6l7OkgfZhO4d+K+rF3an+4fCOhPwPrFAVyugjMW5Q5xT79FaAifCr4Gp+FXcECqUnGfCFMlYHVB2fj4qWRSdrzobmxK4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qjQdMxy5; arc=fail smtp.client-ip=40.107.93.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qjQdMxy5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UnJ3MtRsUfNnsJZJ88A6WBkp9u1fyAwPOTDlSO0IhxZNd7mO4R0B1GqQ+oq8hkwNVg8DG1HGhIvmblHxQQ3YiEv68bbl1NB2tBXJI6jlRWG0GwWI8QuA8ZTts+07mDQVR5+Xr+GqG2khaV53+Kpfm0Gfs76WN5g+gbNeXsLnC5mxUZvXT4WW1slhpV9AU9Aj8F7GpNv+NdWSCBqbnOQHsYxdC9cMqwKHAziGrVJn5VmfoIAxI3ZRp0yAy5zf+5xoL/Sc2WjAjN4QHAizc9kCVCx6dxkze4wtEdkGtlVFAGywiPIhA363IJNCt8v0NRgCWrrtJAb7QYfT2SvlRwjlMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/oowTyK1n4nkDWkv0vUzPTzEWL4FS7YnYVB1H7441Ds=;
 b=hqMV3NWKnBKOceDTpH9JcHsg4PWG273+OQS7GByTyICpHBc2RAR6OIQeeoVzyXuNDrCrnwd8GBhmDqzByhU0tRyyS0iIkcz0bXN4GvOSbk7e2mR4plbh5n44aPv9oGlMYfqgBKAdb6cjajuXlFR62krIcxPSu98K2rZqduejGic0qsWlNp91av1X+TTruXbfCiIz14cyvaCVBwBFia6soiVFNGhSFIMqYiGBR2ATSXUlL/E7lHl7MpUQXFYIuzR02fjEOKJLVDBC9Q5sM1qGSa+XotvWrFshz/DOFy2IMm/C8egXbEJUdr5KOC0fvHo9GpKW8Ipttvs3tsgPmChAdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/oowTyK1n4nkDWkv0vUzPTzEWL4FS7YnYVB1H7441Ds=;
 b=qjQdMxy52B+JBoqkqcDb9wlhylz8FUr3qExrMWGgy52lyAMFRYpUK97Sre5nyhfy4Kfo/uG4/W+Vb26fbSuz0YfomG6UcWYJi7X/GaoTRmiie0GXGU71DwjJZwTQQFbMPVOs9aUTyrJtGMoEV/GNYJ9NxmtBhYer+CZq1662FzH5+wptHkwAsPZIZgjrG4Mw+fxnBJX3j791UquB/nqd7mtFsHirUvzahD6vjTfFINE5kbV0OWwoI8fnIoT9lMEcInEaSnm8xfUjb+9ODd4MvM438B8+I/UZMhGxeHm6i+YiKZ8yqQmP1XcftAENrK5N6s4iqT3JeTBBI16n9niHPQ==
Received: from PH7P220CA0148.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:327::16)
 by MN2PR12MB4334.namprd12.prod.outlook.com (2603:10b6:208:1d1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.23; Wed, 5 Mar
 2025 17:49:55 +0000
Received: from SA2PEPF000015CD.namprd03.prod.outlook.com
 (2603:10b6:510:327:cafe::9) by PH7P220CA0148.outlook.office365.com
 (2603:10b6:510:327::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.16 via Frontend Transport; Wed,
 5 Mar 2025 17:49:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF000015CD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 17:49:53 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 5 Mar 2025
 09:49:39 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 5 Mar
 2025 09:49:39 -0800
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 5 Mar 2025 09:49:38 -0800
Date: Wed, 5 Mar 2025 09:49:37 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
	"will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 4/4] iommu/arm-smmu-v3-iommufd: Allow a shared
 s2_parent to allocate vSMMU
Message-ID: <Z8iOsTIa37XzNcW1@Asurada-Nvidia>
References: <cover.1741150594.git.nicolinc@nvidia.com>
 <564eda8dee4bbf4c6e1d1dd9ed6bd40cc1a2df26.1741150594.git.nicolinc@nvidia.com>
 <1b51a7f7bfc0419b8941cf7ee0601b70@huawei.com>
 <20250305165743.GA133783@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250305165743.GA133783@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CD:EE_|MN2PR12MB4334:EE_
X-MS-Office365-Filtering-Correlation-Id: e1883914-cd71-43cf-341e-08dd5c0e22df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eM9CIRWmWGQGgpM79TXilOizqAQvlR5ZZWMLbodUzl3phVg5qQs4Pj//4kd6?=
 =?us-ascii?Q?b8lYH/40KFaNbSe4eId50dzZ9rmP0mfv7IZ5xVAHrqLmU6r7UoBlfTtNZHQN?=
 =?us-ascii?Q?zl8vl5Pmzjv+RLWtIBU1x0Lq/fy4BCoS4FYLawe6kEYjzmd02XOh033JBGYo?=
 =?us-ascii?Q?nRfiHWsGZ6ddTqeDGLH86rX6kDFoN+c7l1Id2OGylWx7RewtD84PzfBBGXfD?=
 =?us-ascii?Q?QnuoECJg5HA90sD3gJZhamGzxspA5OQyHaogEVUoewJhawOX6/wMB71pq/S9?=
 =?us-ascii?Q?zzuZpvUB/8CoCKMJ+8KpiojjtIqqnz73NkiOaeedqj17OFLVuTw2yihC6NOe?=
 =?us-ascii?Q?3BXd33Kjo52hWM1q+wyoOLQai73qnraULu1DpYcctDJMvWCW6pQ+KyUxgwDm?=
 =?us-ascii?Q?zzl4hMuxHbsTQ8K2XAzmZyrrCL2BPvVWT+n0lwwrhe1r8uV+25AWU65d0Cu5?=
 =?us-ascii?Q?3c7Gz4EzY+6pws99JAltrJr386+5SqpHtTzJCfpYMVVPRf41O80eMnJRTd/x?=
 =?us-ascii?Q?h3ATXCuORyvczdDab+5Bc0sSfAeI4g7WuRfFF/FDde0MZWxfnVyV0WAyChep?=
 =?us-ascii?Q?5aqbKe7OI5O2ONqud5/ZzHo6Y5R1rZcOF40xqPGzvsoJgn0RTTCCS99oG++v?=
 =?us-ascii?Q?yQIlbkYSw7R1xtGE1t52mXswXBjVF56l4TiTLu/hZbBOuHIvtn2bsRrGabVS?=
 =?us-ascii?Q?PyRliR8Zf6ul3gNcg6xvEdypEpoCACRlNMk4iP92Yt5vigQlLeVSx9H9Qo09?=
 =?us-ascii?Q?Vw5D6mVffxmt+seofYGKmYecGT/Gh1Bp0HkcWTQ0OZSq8vWxGJtt1eVtF8vq?=
 =?us-ascii?Q?MeNSkRao+s7qzOdWQcfgKFH1IVifVmjMFa6+VaOhqHa7eU9TOJgl3bb/btuS?=
 =?us-ascii?Q?8KxFI8LTl8Py16ivKmRX4VCV7V8B6oHcGkMANJKYrjOR3lN5m15lUWn1XBKY?=
 =?us-ascii?Q?Zb8XQvske8pZhByDOg8cTWh61omFEr516zh9Qqhp9hkWIRrr68DqBQtIclUw?=
 =?us-ascii?Q?TbNqfJISqWmOaXg4/MhioL6UunYDYRYcaMNteoFeNhbsAS0hDO9p+ycIevZG?=
 =?us-ascii?Q?lAwwLhL4hrt6+LHXGjgnp//dDUS7BejZlqHY25O28L6g7h/UFWQ7O2pnYX6k?=
 =?us-ascii?Q?UXQMV9rmYMMJ+KD0CCXsK9xd1dpwqofG3aVGxAeqy1YWoUjSJRGgNtYAYIVg?=
 =?us-ascii?Q?dtj9BKYM6hCufDRsc1sZS90AvTHXCYRIQu4pnKyiydMyFlRwq+onwW9K4zOH?=
 =?us-ascii?Q?Tn/unP5FoD5bPk7Iq/dAEwfp+I+Es6Bq7yKlVLQCzcpoZAJdx2rgNvLJrNbh?=
 =?us-ascii?Q?+ntaaPV6EgDNx3X/KZVxkM04Z5nH8vnng5hjXGRd5tq1qWybY3W7A+smkUy3?=
 =?us-ascii?Q?5XpsJQlmAsHRA+R3HmM2YkbCbkX4EMFdkO2oCHrmuDc5o6F3Vbj91jyj7+fJ?=
 =?us-ascii?Q?ptwymGPxpwd/ORBxY0Sih2DHtxpzJH4OavXx3DopZbGwrA7jL1QE/lGY5O0V?=
 =?us-ascii?Q?UTR4R7M1EPJuOBo=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 17:49:53.9422
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1883914-cd71-43cf-341e-08dd5c0e22df
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4334

On Wed, Mar 05, 2025 at 12:57:43PM -0400, Jason Gunthorpe wrote:
> On Wed, Mar 05, 2025 at 09:01:40AM +0000, Shameerali Kolothum Thodi wrote:
> 
> > >  	if (!(smmu->features & ARM_SMMU_FEAT_NESTING))
> > >  		return ERR_PTR(-EOPNOTSUPP);
> > > 
> > > -	if (s2_parent->smmu != master->smmu)
> > > -		return ERR_PTR(-EINVAL);
> > > -
> > 
> > Not sure we can just relax this like this. What if the two physical SMMUs are different in
> > functionality/features? Do we need some kind of sanity check here?
> 
> Yes, a function to check if a domain's iopgtbl config is compatible
> with the instance is required.

Yea. Will rework.

Thanks!
Nicolin
