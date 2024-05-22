Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57BB5644E
	for <iommu@lists.linux.dev>; Wed, 22 May 2024 02:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716344162; cv=fail; b=EWnKK4X+1vYha/jZpc9ztDTv3R8eUHPtCO9oUeWOKXj1S8l9Jp3I6Z6WNblyGHJ1iUK0qwUroDuKlPRR4RDyR10ct5lU0pYKl+E0j8ntb6Rver/wALg9RBJ7tJQFY2B2iDKXW1ZiUvoN93WXNnVekvXiv09GtCxV1ESHEA4gLm0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716344162; c=relaxed/simple;
	bh=5fdcwZKCQ+f80Ssycu85tah0W+YODFr2YXtKe7VFXZ8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wgl+UYAOhNyqwghJM+sWj4g7NBGMgyXU/Rig6iq9H+LzQmuFafEHofjpm/Ae19BeYrGBaoUdi7oZZQzqvydna6FuaURd/rdCj1epwqhVqrE/zRxxKV/mLUP4g82vQTbaGFvMabVuUZxHwYzhZMXwCLwOodDiLCXOwAD13nLSd8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=r+88i1aP; arc=fail smtp.client-ip=40.107.93.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="r+88i1aP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lu9zOCENK1+Y/uUTbr/OvcInEh4BDFzVbJTKKSfdYEHO92oVm2upFQU5+FojH3UQv+6VAF/DN5j5o2k+GxXWgYhdpoI/fm2qK0QgQCkCFhrl3RY6fyw12TkPBPSboxgXqiyGjdLdugH/w1Aae/DH27SY04fNsWmeelN+HpK40MgevmFkQ/u0DdMFGyrlpgdiKMS/Qs1IwLhHo2w1PJel2Z6H5sPk+Mte8MOSyd4ZUEZniNnKpL2WytO7q9Bm9ZWl63OZF4dfELFpVOaQ5Oa0gpJA5zxJVSxpNjh1xhHbaP+yxA9wpkgH6dgBpWH9MPRPc2X0Gi3VyR/WEKR9S1b4dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NcZUavtFnHT0129nuWel04QOugh/dDeqzwGqTJOrwzw=;
 b=CgmPB4TJqWZWZ0ZL1JjAEpVY3SiAdkYmE3y76esH62R4sxkfcdSEeVxj8JcKCAkfBj9WYYkHbTXQSwEXnuvS3P2nGM1Xv6P3sHPrgl9rF7xlNCDr2MgbaxBQL1b72v+/U7/NK2y5NDFktkHtcSiKZW5zDLUogCXJQHDwzykgY1IsCGfsYVsNYkqc6YbQJvxJN9LY19nm+K6s4ccq6D1PRhOX6AYwDihTXjmr8sL16Fgp7frNUyFU2RofEjPV2KI0lLwl+SgpFcG5nqLa7ireL+TJZu62F0mtZNNdPjcWn2hOc/PVf6pzJpWG5838msXxA43IClqgh4wz0HLDjVQ9LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NcZUavtFnHT0129nuWel04QOugh/dDeqzwGqTJOrwzw=;
 b=r+88i1aPUuk+hbGtW/e0equG73aN+/prIMAJs15coQxlRfDM1xUS3LovheHPrr3hOIXzuste6kU7ju2wc91FCSY/BIDBIBw9UnPV7nQm6Cdkrc/Sey3qtdTh3n0a9TDS5kM9rTPGeWJ5XLYMIbPuhjH7nB1dqqvzs3M24YGLZkhYjxwcUUC+wx2xgqE3Bu9TNfzsMnftx+rjm3YDaSOUh7+Pse8W0u5/gWjhpqe2MVe7dtCr5cpEBR2276GvaX/nnoKjFYLvn/mf8KxyZHhzgm1OlOSr19y+ThZ+sgdG+MnaBr7BuPWIVLC1u7zr7SZmshuU0fq3ZWSqnRxdvF+E5w==
Received: from MN2PR22CA0009.namprd22.prod.outlook.com (2603:10b6:208:238::14)
 by DS0PR12MB7769.namprd12.prod.outlook.com (2603:10b6:8:138::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Wed, 22 May
 2024 02:15:57 +0000
Received: from BL6PEPF0001AB57.namprd02.prod.outlook.com
 (2603:10b6:208:238:cafe::77) by MN2PR22CA0009.outlook.office365.com
 (2603:10b6:208:238::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36 via Frontend
 Transport; Wed, 22 May 2024 02:15:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB57.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.14 via Frontend Transport; Wed, 22 May 2024 02:15:57 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 21 May
 2024 19:15:46 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 21 May
 2024 19:15:46 -0700
Received: from nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Tue, 21 May 2024 19:15:41 -0700
Date: Tue, 21 May 2024 19:15:38 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <kevin.tian@intel.com>,
	<suravee.suthikulpanit@amd.com>, <joro@8bytes.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<yi.l.liu@intel.com>, <eric.auger@redhat.com>, <vasant.hegde@amd.com>,
	<jon.grimm@amd.com>, <santosh.shukla@amd.com>, <Dhaval.Giani@amd.com>,
	<shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH RFCv1 08/14] iommufd: Add IOMMU_VIOMMU_SET_DEV_ID ioctl
Message-ID: <Zk1VSm4oTGVrZVaT@nvidia.com>
References: <cover.1712978212.git.nicolinc@nvidia.com>
 <c97a98a72ee3498c587e5898d6b899553ccd9b27.1712978212.git.nicolinc@nvidia.com>
 <ZkDZE32JFyKprmpi@nvidia.com>
 <ZkbnvnaiV9nCHQOb@nvidia.com>
 <20240521183011.GO20229@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240521183011.GO20229@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB57:EE_|DS0PR12MB7769:EE_
X-MS-Office365-Filtering-Correlation-Id: c96ab613-8c38-441b-6b60-08dc7a051de4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|82310400017|7416005|36860700004|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yU1mITQUy7/gyXQxsqyz/fMWMwlLP8jmT9tCCgfC/d8BU0jNwmZCvArmDRlt?=
 =?us-ascii?Q?ulRS37U7PYC5lwDiy6wjt0ibekudlb0u92p4+xuFernbJyvV+DAERff+6Ln3?=
 =?us-ascii?Q?ggACddA4n2exFtAo3uBP09XgrLuDPi8k01qOhsqAGKmKVuEl/ywJo+me8w0d?=
 =?us-ascii?Q?DqoaT6zLXcX7mh1rgcLnKDkeeX5LxQljPLS6VxsHKgmdo5u0LlXL13BEZC1W?=
 =?us-ascii?Q?k21YFPogD/gPcO/xeQKAApxdeVDVzhGv740U1HF2ghzstZlBoQKoZyFpfQ8y?=
 =?us-ascii?Q?b/6CjkaJC6tnafvw6I4QZFUC/g4fWmAm3VkoQ7eWUkl34KAPSNvtD16bfV6k?=
 =?us-ascii?Q?nsw3jIvwrjzpjuByImTYDj0cbU8VcA6GYKzRJlyY/w29ddl22ZN/D7181Q6w?=
 =?us-ascii?Q?7vVPBdg4yZmUR7Cx0j06T7c2ilJ5tQ4HXm27QXSrrY/i2fXR7q958wotKKaq?=
 =?us-ascii?Q?qzrRxzJL/bukydWL+xytCIOZ+Sz9zbDOBg1lkaoDB6caWdYsnFGUuoD+x/6x?=
 =?us-ascii?Q?hNCb+8j4H5UudnnpXHDhOefV61RemUTnRMIc17NuHYL9GNeLm2xAkPcM5dYz?=
 =?us-ascii?Q?zIFct8quj1PJ+ZMudKF8Pc6uABxpNOmxN83kJg89A7y1AzITQmTf2uyGp/6N?=
 =?us-ascii?Q?D7Jz72/MXjIzO88B1CADNoDiPrxISLH7LssBAVjJ0LLYK61k+SjCDn5TOhUH?=
 =?us-ascii?Q?aR8StL/Zm6emrKkgiNHAelT1nS2VbYtiljhqaQPOWuwdBHv7y6+VnoaQlYoa?=
 =?us-ascii?Q?vRF1KohHg+N+yItZumpijDUvTg0thONl0qqwyUKGF8r/zLMNCiqoy7K/At0H?=
 =?us-ascii?Q?rD8/08LQaMUq7EUiS0o6U6g2aHTdQnPH7p4jkftbnWO3KiUN3fOOhzTQJK/S?=
 =?us-ascii?Q?tWEcjKgxftVjy0wKO3uacdXA2MFOv0Jqiw2mfftpCdSFEUbEkU5RiFGMk0Vw?=
 =?us-ascii?Q?9I1OBDCJ+wQu/ZcUZKctH2vd1ZoPI7E+RopMSlxmOAAiHI7zvWR886ava8pW?=
 =?us-ascii?Q?5qJfsp2kygqrMlcGzbc3WtnrYOpMtGzILHC0u6GTv4yibhX7PEUzYVnzNlnq?=
 =?us-ascii?Q?dF8AX0ttbv+Ag8TFotrJQtFwI1ZmkCgWPF+jWAaEFaias+Jm/zcrh2A/BwOv?=
 =?us-ascii?Q?s6+MDOBaXOZm32cslSedOKxl4Mt+ivOAr7XlRtDlA/6P2/nxQv56SwNjnuhX?=
 =?us-ascii?Q?2luOnEQOEZeXyDp/yc+mmv3k+XEApEpxafpVr7RMZWpy/Eu3e8wsYhEr2dpJ?=
 =?us-ascii?Q?LA/4Bk6q8KsNtMhUBkI6J6eSUqABeBOSZeYssDwprNSnuNvzGATVuJ7WMptw?=
 =?us-ascii?Q?iVSc9cgMfjHc91jJJnolMdQVnC1va32G0B4yZ7ox+smK5cup2cco1a3PlX8h?=
 =?us-ascii?Q?Dj5nE4yNBNsqcxmWEiwMyGYund5O?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(82310400017)(7416005)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 02:15:57.2670
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c96ab613-8c38-441b-6b60-08dc7a051de4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB57.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7769

On Tue, May 21, 2024 at 03:30:11PM -0300, Jason Gunthorpe wrote:
> On Thu, May 16, 2024 at 10:14:38PM -0700, Nicolin Chen wrote:
> > I also moved xa_cmpxchg to the driver, as I feel that the vdev_id
> > here is very driver/iommu specific. There can be some complication
> > if iommufd core handles this u64 vdev_id: most likely we will use
> > this u64 vdev_id to index the xarray that takes an unsigned-long
> > xa_index for a fast vdev_id-to-pdev_id lookup, while only a driver
> > knows whether u64 vdev_id is compatible with unsigned long or not.
> 
> This seems like the most general part.. The core code should just have
> a check like:
> 
>   if (vdevid >= ULONG_MAX) return -EINVAL;

Ack.

> And if someone wants to make 32 bit kernels support a 64bit vdevid
> then they can sort it out someday :) I think this is not a big issue
> as all iommus seem to have some kind of radix lookup for vdevid and
> want it to be small.
> 
> Matthew has been talking about support for 64bit indexes in
> maple/xarray or something for a bit so it might sort itself out.

OK. In that case, the core can do the xarray maintenance.

And then..

> > And, we have a list_head in the structure idev, so a device unbind
> > will for-each the list and unset all the vdev_ids in it, meanwhile
> > the viommu stays. I wonder if we need to add another list_head in
> > the structure viommu, so a viommu tear down will for-each its list
> > and unset all the vdev_ids on its side while a device (idev) stays.
> > I don't see a use case of that though..any thought?
> 
> I think you need to support viommu teardown, at least from a
> correctness perspective. The API permits it. But isn't it just
> list_del everything in the xarray and that will clean it up enough?

... viommu tear down can xa_for_each to call unset_vdev_id().

Thanks
Nicolin
