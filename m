Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EDC1332AB
	for <iommu@lists.linux.dev>; Mon, 13 May 2024 03:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715571891; cv=fail; b=PvO4uqwrpe648Y8ZiCWcNjXDWq9tcswm/w18Mekn8ZYnjHszWXetWOQ09Cl8BYzGj5GGosrfcZe83xofLeYuqngybd/SMIYliyw6LGT5ViLYIinRtXXY9vVI1XkIVK6ysbIrEJRzi89n/gg3QAZvh+syr/hsK+t8Ggz4U3Zi/rE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715571891; c=relaxed/simple;
	bh=pHJ/OPGguGiTCh1Tlh7qeKnk7Kpqq5T3YvLO6Xr1XqI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nonB1xv5iJPJmO7+1//fkiY1kiGmw8kXC8hKb/SHbK1jPS75D1OhMnizqZZLGS4mOlfWX2d/vEneQtMGzsJ6Mng/8JjuCcCxsaeohngOy8hzaQxNunawEWCsmBaT0xDaV/mIWEUrhHdmOJ4YqBvRnu4PrnzDbr0kVK2AkPEvt14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jg/RM0UT; arc=fail smtp.client-ip=40.107.94.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jg/RM0UT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mkdpkdz4RXhIyeq745VqGzZefcbMI1RxpMU1IbcI5pY0ZWa3Yua44/ALWoh6ls96dbpKhd8OJXqO7DzBlh+PmxejRXihxVSVDfOC1IPl3iTHDD41stsbKLZqMEebO2DMM3a1i8EQU+oygw/iNCq7FYsq9lQxvwM6SHzdFqvu001RIGjXprj3GQKx4K7FVq4LzHXYieNR/RRiE2RzHoOxhDDftUeuB1lBhMwiBju8qMFNgs2bhFb8i5eyIu/I7EL1sjmcI2jpk1MmemJEfA8ROz7nx8lTvWdtNygHpqqde4dpCZd90XY2Q4rX2TEzFCzqI+c7yCEaVI1kVQOQW7q0KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=et5YQ2UkNos6/+UMNWm1McQ9w37o9SaW37dEa0lbX3M=;
 b=nnUBwErvUPu/oPk2Zx6Ee0BhOrH8P7Iv84hFIa6PPV5rJQW8QlQQBYGaAzXNOacJrdOv4mTMDBG8pvZaJbOqSrOCG15cIyHxmcnmHcX/4nPG/CEqJe6Tjjb3WUQvBzpu5fzI7yIVxlReC+gMxwOQDWGydKmfGXf0bD4hj+H/jDkhf0kBGBanlsZ7mSOHy05mxqBPiBXFXwk5gsKDi1cQE6OTZRadX0gfTRg0sHHygg5YQEwiGp6wanesCPGz+9V2uXSBkzu2xvf56+HfixvyJbhEbvEvVxsOCABW9hk3oDcNTdy16Lu8JJmaxb2DTa2MOy2KHVe93qzT5zHVyr1EcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=et5YQ2UkNos6/+UMNWm1McQ9w37o9SaW37dEa0lbX3M=;
 b=jg/RM0UTUmt2ThbS20r4Ax9E917PDQiF2ZAmPYdjAq+bJzYcw8KBqE4EgxomPag43yFpIvubB5FQzGKIGTV8lmYPDQiD0orVpzUf97OCQEUf3A4C5MAzw6rwQUDOyL6PQdRJX2q+y3oejSl8TWC7S1aGnnkatR8cZv9ZqAY/qDpZbcU/z5pgAVyaSIRt2q2hXeQbrH75uBYDSp3rQtTe8MsM/W2xD5I07ore1zxtm1i4Mn5I5LaB52L7+4MoaSQUuObu8kLXBqtUpNze5TOvuxdct6F+c2Ljp9NgMl5o5OlI3+orhaAL9A9c32HWJevxa17LMJAtOGb0PFHlbPedLg==
Received: from BN0PR04CA0190.namprd04.prod.outlook.com (2603:10b6:408:e9::15)
 by DM4PR12MB7744.namprd12.prod.outlook.com (2603:10b6:8:100::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 03:44:47 +0000
Received: from BN3PEPF0000B06B.namprd21.prod.outlook.com
 (2603:10b6:408:e9:cafe::d2) by BN0PR04CA0190.outlook.office365.com
 (2603:10b6:408:e9::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.54 via Frontend
 Transport; Mon, 13 May 2024 03:44:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B06B.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.0 via Frontend Transport; Mon, 13 May 2024 03:44:46 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 12 May
 2024 20:44:37 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 12 May
 2024 20:44:36 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Sun, 12 May 2024 20:44:32 -0700
Date: Sun, 12 May 2024 20:44:30 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <kevin.tian@intel.com>,
	<suravee.suthikulpanit@amd.com>, <joro@8bytes.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<yi.l.liu@intel.com>, <eric.auger@redhat.com>, <vasant.hegde@amd.com>,
	<jon.grimm@amd.com>, <santosh.shukla@amd.com>, <Dhaval.Giani@amd.com>,
	<shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH RFCv1 02/14] iommufd: Swap _iommufd_object_alloc and
 __iommufd_object_alloc
Message-ID: <ZkGMnuBJKseFHfp4@nvidia.com>
References: <cover.1712978212.git.nicolinc@nvidia.com>
 <43bab81816a7bb08fde868a43d62c439ede91f9f.1712978212.git.nicolinc@nvidia.com>
 <ZkDDlMouOmfTaRRg@nvidia.com>
 <ZkF7EY+COAPYNWwU@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZkF7EY+COAPYNWwU@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06B:EE_|DM4PR12MB7744:EE_
X-MS-Office365-Filtering-Correlation-Id: 219d48f1-32b8-4789-9da9-08dc72ff0891
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|82310400017|7416005|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5lNfoMs+I5QlPp8nN6DzlDMIfAd65jEpS5jlSLwNp+UEQYX/5pd5pvgxb6dx?=
 =?us-ascii?Q?YQ8uReJDxdwObVv9Vv84vhhfeOR2mis8At3hrvTB0CHStmlCAmcAwjnS2z7T?=
 =?us-ascii?Q?Y0BNNc46xvJVK2QHkGfeFL8sQqQikndryh6its7RA8ChSFR65MW96evrI4tN?=
 =?us-ascii?Q?imQf1RdwnHYtiljB4rCilzxWnwE324jWAhRTd/QeWt3KP1bGwwg93FUYt1I/?=
 =?us-ascii?Q?DMomjzCJvcY7tm4JYzzaP1FY3SzZVL6PyOfmqIxCnEjVl0w/Awj+6zekvj3i?=
 =?us-ascii?Q?NT5vetN8uu+Tf23aqdYWTsjJ/vvwZXkfAIdjK24xY3L25KzRDkSTXvEKlXgN?=
 =?us-ascii?Q?G7WWA1VkctCTIpLp94pNLLxULc9WMKv515d8Fp2KtpaSI7mtTdOlReHhM8qg?=
 =?us-ascii?Q?nehA0QgYa0q3aN4RTr8+fZrRRPhI3vw/3oaPm5N8kkSY3FvhmXLgvxLULGCb?=
 =?us-ascii?Q?9rkgqChUzHYze29JfQSjexXAggaYWsJiAb2jeoR8cRfx01BNZQbTy5X90Gdx?=
 =?us-ascii?Q?8vumFhVNOZeAp1rAy8FipDHX2bz9PcYVe0S+sGmR0/lmyq1wJ/5PXzeLvxio?=
 =?us-ascii?Q?20uVkK1gEanszNbGL3wFTXYCLrY1ETuAgtMIPQA0cY1DhBJ6AMtMqOnU7nxN?=
 =?us-ascii?Q?zkrAACBeQ4gDqshA3kmkfmkaHGTKbVKMZFSZViVZVm3UYzO2ldrUPGSMul4A?=
 =?us-ascii?Q?4lzh+r16mChPYXhnxJJbUm/8YluyGrb8isjbAVo/FURHrtAwG95SQsVW8n6s?=
 =?us-ascii?Q?vLqShFeREbUdFrctvo250uYnYnuqbtamnNFnw+pS3YioxkWdzUu/38z6igFo?=
 =?us-ascii?Q?HXCTqJrLsNkaAAHnV4ZIq8da0nVfPWCIl0pMTYql2ULr/ybZ7OxRfQK9dXTt?=
 =?us-ascii?Q?Hh3b9viVQqr/tJ13xA1NvnIkBnGeVX1+IbfITf61rM5GpSvwFOC6X1+JVcrd?=
 =?us-ascii?Q?5JfiVSq25DAss0wsUKr9ZAqA+iiPuzgi0N1jWZ00BOdtbdrdJIm/VjzaTC2/?=
 =?us-ascii?Q?0qMsvSvty0wxrWWVlYY8BFYHl8FYoSYIgvAwAwGubP64zuboBcWW5EtXkARR?=
 =?us-ascii?Q?ywdtG9W3SCXl8P89Trj1UqCiokXba02j5yJTHQd2HK7nXftXvyu1MYwcYCi5?=
 =?us-ascii?Q?4sKNsiw5AOH9ALrvu0d17my9I0ptqkjqzV+tXABmyyp4zK8B7a3HWzj25k+N?=
 =?us-ascii?Q?hvbV9FYHFk2chS+cqe7IAxP9J2OhSXwNGxd9c4P7SQnXQkKi+n1QDJk8qoGG?=
 =?us-ascii?Q?rbK9rE/vw2EiDACqm6/BQSS3Bkp5r0NIxEmSsewpwPdz2KpeqKOHZyIdIjcF?=
 =?us-ascii?Q?KNWIWK9mVWdpToK/zldDE5qANRI6due+Y6M3dp/bHp7Te+0pA+zHNYF6Y8Ij?=
 =?us-ascii?Q?BRb3DfIcXd8ycHIwC63y0R4yZmRC?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400017)(7416005)(1800799015)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 03:44:46.3724
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 219d48f1-32b8-4789-9da9-08dc72ff0891
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7744

On Sun, May 12, 2024 at 07:29:54PM -0700, Nicolin Chen wrote:
> On Sun, May 12, 2024 at 10:26:44AM -0300, Jason Gunthorpe wrote:
> > On Fri, Apr 12, 2024 at 08:46:59PM -0700, Nicolin Chen wrote:
> > > Currently, the object allocation function calls:
> > > level-0: iommufd_object_alloc()
> > > level-1:     ___iommufd_object_alloc()
> > > level-2:         _iommufd_object_alloc()
> > 
> > Let's give __iommufd_object_alloc() a better name then
> > 
> > It is a less general version of iommufd_object_alloc(), maybe
> > iommufd_object_alloc_elm() ?
> 
> With the level-3 allocator, something like the followings?
> 
> level-0: iommufd_object_alloc()
> level-1:     __iommufd_object_alloc()
> level-2:         iommufd_object_alloc_elm()
> level-3:             __iommufd_object_alloc_elm()
> 
> In this case, this patch will be:
> "iommufd: Rename _iommufd_object_alloc to iommufd_object_alloc_elm"

After reading your comments in PATCH-4, seems that we don't need
the level-3 allocator, if we pass an ictx pointer throughout the
core and driver. I will try with this first.

Thanks
Nicolin
