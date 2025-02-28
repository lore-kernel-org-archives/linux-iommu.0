Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E352D15A87C
	for <iommu@lists.linux.dev>; Fri, 28 Feb 2025 03:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740713032; cv=fail; b=JogEnk8AV1ES5oJ3pQ5gPm2IWG0+R7gOjUhorph6hMOLyFTvMpnt5vx09Q+z/xUVLSQRid50ak24kb325Uixq9hsbFG4rd2aFYRpQ3IKtYzRSJaoMBgRZwiZK7tKKaxhFP1ks6sW4wm9eThiNvH1gcHRnws99/c0CUK9yzAxKKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740713032; c=relaxed/simple;
	bh=3G+M2SKrARAWGdHBrg7tOpu/s0/2DJXKBI/kvI6IK2c=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nD71ZFzCr1dKQQAmV7SmovLMbOueu05X1mBp51EHV5uZDAiHtYESIPEBoQA1Wi0T7AYRi5xkh0u4gruDv4/XWCW8TFb8PqWvrD+q14RXaxwvalsJwLARUrfVqMOm7iXszWdZXAQCZh88A8uw03ONVBtHL9bOxp9U/uzb6Q7aUWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bMbvTR1z; arc=fail smtp.client-ip=40.107.220.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bMbvTR1z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oxYLaAyui9AQIIKk2P/1P+QrtRN0dRX/zff9LQisBJoXPB0Z4FvH9qu4BdVj9CgzWqg6QTtsmyJ1zSdrnNnB2an0kCRXnoChFEEa0AWJnOia3otucL8PLnHIeOeHaLpO3g2zX0czu/oT/0ONUneapMpdrAxAILl4RNrXjqtew/x7LuWtncSqVLVIz21jXuVr1rVHtzUwuv2rTiSXHoSbu/fsSK6PuckI/c7mwllzyJHjpo38yTQti8Qy8g3/pWn1ud9HshLDBgLoY+vB3+MnRqmzrFYAyfIBnOT3JEDzGZZH01pWQAXWeU6ckTlCJdQ7jns9AEC18pO66975x7pFjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ZOjkb8g+1lSWKdpJQ0VrjU7YjNEuVCIUjxxvP9pqfE=;
 b=BerPV7xouo8kQz+DozmwdtDuAbobQfNjI1+gxD8bzZGHeaixderUMlnFE+7bGgsp1tydcDuFiFGffF3r8qxCiomdEOyq5uyLmtnZR5MDEWw0L9ZWh7IyKXOczPHi2mk1t3y0DTmsIGivApaT1qIEwfuRjzYvEnYV/jQTyJV1m1CAXz0cS1NpBrjEJZ3O5cYvU9yhiH5KsVjvyCgAMM0cTZBOWX/0vB9kHdiWTn0wxbh9UesCTvwia9Qd63qVF61kWdjFdIZbQcD1uNFe1h96ug2RhMEsaHwBgmY97KO6LKFr5Dt3hxuxdO1AA1sJb7UImBbPxxxH89/3/b24zgY1kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ZOjkb8g+1lSWKdpJQ0VrjU7YjNEuVCIUjxxvP9pqfE=;
 b=bMbvTR1zdsv29ccsMt0eporktxlgxcROkeQFhV7ygC4lz/RHBb5Jv29LrO4v42WWm8c21VyEjhXx0dhEkbN3jh2xSDA9LhENxuVbqogYcq0+0otKcb5hBQ+j0fMTSV43Hik9yTmfxLd0nTQpsQHY7eoYWn5iok7VpKy4YJ1kOSYBf09hSkiO/xt6JUTmAv4saBGk33QxSd4pix4MEO/HUZyPR5Gia1cvs7Lz1+8YDMcTsgkgdtyKuu4F3YBNqiOFyq646/IHVrBlYMK96St3GZ6NPd5shGILKpKOAwklOPAlcIJAYET8aBtnEhVVh9MO9oFW8+Mqi7wsGZdYAywHAw==
Received: from CH0PR03CA0037.namprd03.prod.outlook.com (2603:10b6:610:b3::12)
 by LV3PR12MB9438.namprd12.prod.outlook.com (2603:10b6:408:212::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 03:23:47 +0000
Received: from CH2PEPF00000145.namprd02.prod.outlook.com
 (2603:10b6:610:b3:cafe::fb) by CH0PR03CA0037.outlook.office365.com
 (2603:10b6:610:b3::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.22 via Frontend Transport; Fri,
 28 Feb 2025 03:23:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH2PEPF00000145.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Fri, 28 Feb 2025 03:23:46 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 27 Feb
 2025 19:23:37 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 27 Feb 2025 19:23:37 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 27 Feb 2025 19:23:36 -0800
Date: Thu, 27 Feb 2025 19:23:35 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
CC: <jgg@nvidia.com>, <kevin.tian@intel.com>, <robin.murphy@arm.com>,
	<joro@8bytes.org>, <will@kernel.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] iommu: Add private_data_owner to iommu_domain
Message-ID: <Z8EsN/Vg2SVeChTp@Asurada-Nvidia>
References: <cover.1740705776.git.nicolinc@nvidia.com>
 <45c03a1bc86528c9194589cc3a5afe3eb2a15c9e.1740705776.git.nicolinc@nvidia.com>
 <f6d0fcb1-b974-440f-9208-257422bc01a6@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f6d0fcb1-b974-440f-9208-257422bc01a6@linux.intel.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000145:EE_|LV3PR12MB9438:EE_
X-MS-Office365-Filtering-Correlation-Id: ada24f50-ba7c-4658-dcaa-08dd57a74ff7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yrfbz/kyP5dY7fXw+UuaNHOWhWM8LRxpaT3RbFyc/XpBtCZnGcsPlIzE9u2U?=
 =?us-ascii?Q?bfRaAX5SqyJSSeijdearAjhEGlXFvpQkr1k0VM0Dlt6refuOU45Q6orQ5NJz?=
 =?us-ascii?Q?9ulSWmCJ9Rer/aKfcLnEdxsHwfqcu4YcHr+GReuSE2wAdbiQryUCcnbhMG+s?=
 =?us-ascii?Q?5bjEGtv/01cgxSrAkb0wOYNBedVLoZk7j9HnVPXusqM+QfvArl+eC2sGC67+?=
 =?us-ascii?Q?4fsWpMNziFzFXq0hTZjbmtG3XOVuTm/bJxrCrE24W/hhKBdZevBibCAxzkCR?=
 =?us-ascii?Q?CjKEMD2Gpow4uYmdqm1i6Jv8Bi3qaERWYAlSVSn8jlSmAK0vFFK/bPF6eb5z?=
 =?us-ascii?Q?qXgwrVfQ7rwhamhJr1fpIi4bVRZ8vLd86ocRY9LjaVCSfgGaFugWj8dqw77n?=
 =?us-ascii?Q?D9WbIJeN2qZDpKFanupQCBcoMVdbySOMXKB1GWm04yHJzOuJZYJ+sg4JrMX8?=
 =?us-ascii?Q?gdwnToJnBG8kR6FDar0U4QMuN415FCLOdaydf9yA0S2UuH4z1aOEDiDUXseM?=
 =?us-ascii?Q?mUWGj0HZ07cf6x8Apc2dZg6qyM6hSOW6WiT+5nVxAnJQwB+vD4VsMO+ItYbs?=
 =?us-ascii?Q?HFfdC5gXmQV2WEUmVTl/hzC2aajKedl2NRkXBQ5L7IqYQNm70dHumFtgQ7QE?=
 =?us-ascii?Q?5JVpsZaFTRpY0WkQ/nyAkEdyauBBmU2qxfLxQ9iqv/Ax/smD1MqXgb4oV5sk?=
 =?us-ascii?Q?EYOLntORAjG8TTJTdEkPMkR6sKdOkUBEGVvodtzegV22JUIZdeLL190brb9B?=
 =?us-ascii?Q?Uw8H8pA5yTFQ1dF5HSLkWK3UPO5c1IlPEQSF8CLQCtnCeFlkpINHaB83vfDp?=
 =?us-ascii?Q?FoPoHEznnbSdSpBX1SRlvqczRDSx00JXM6+kBu9BI17jPBQ3w9ANcxdX+bhq?=
 =?us-ascii?Q?Pv8D0IeOTGzMxP+Xr27Nlue5KxgVA4FDbLkXCk4kLx6yNQEZXU4smcn8M4rz?=
 =?us-ascii?Q?fwMXIRoT5hojhzXJB+Qbj2RAQ+wh03X7vTmHpYJ0mLtc9GOnrj2zAjY+nnAw?=
 =?us-ascii?Q?0h4NX1OZtvWKJMCCzkunI5Yg3/LGoTWLDhzHY79GBJpDLamvWF7hnDCKc/Ky?=
 =?us-ascii?Q?JtH2y1sKUxI+HVhRBmwGWb+RQRJLPVI3FGamLil9xN7wJWhHqK+ruKjsM1ij?=
 =?us-ascii?Q?W8LcBZgjapiYy583RqYGrRMpOyNseLyvSJwXt4kinuhS37IF2K9rrEctVSJ8?=
 =?us-ascii?Q?LS0tAUyOAezFiFyUN+rJINHO3KqgSlTaZ6+jOXg/AHHf3FajX00ybdupyxVc?=
 =?us-ascii?Q?CcQOwr6ywv1CyEpE2SrnfBMiNVEGIAN+dUDvk9s9EAHLiotF6OQp6nqQHDEU?=
 =?us-ascii?Q?vs5igO/IqGAoGaG6l8yZYe1/fn1ludkV1hSdV5HWu9J8n5X1RcDXxBHa+5+z?=
 =?us-ascii?Q?SI545UbqWKLC1yHpdAXvo3r83FgnJRJLIeQ6BLfhc/NIBjv0c+5SVp/zQEdW?=
 =?us-ascii?Q?5DEwepL+RJ88HVT4LdK2BOSJvF8E4cnbtv/VjPji51hjvudGNzmfcCWqq0f2?=
 =?us-ascii?Q?lWuHqHfCF1ijK/0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 03:23:46.7714
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ada24f50-ba7c-4658-dcaa-08dd57a74ff7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000145.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9438

On Fri, Feb 28, 2025 at 11:13:23AM +0800, Baolu Lu wrote:
> On 2/28/25 09:31, Nicolin Chen wrote:
> > Steal two bits from the 32-bit "type" in struct iommu_domain to store a
> > new tag for private data owned by either dma-iommu or iommufd.
> > 
> > Set the domain->private_data_owner in dma-iommu and iommufd. These will
> > be used to replace the sw_msi function pointer.
> > 
> > Suggested-by: Jason Gunthorpe<jgg@nvidia.com>
> > Signed-off-by: Nicolin Chen<nicolinc@nvidia.com>
> > ---
> >   include/linux/iommu.h                | 7 ++++++-
> >   drivers/iommu/dma-iommu.c            | 2 ++
> >   drivers/iommu/iommufd/hw_pagetable.c | 3 +++
> >   3 files changed, 11 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> > index e93d2e918599..4f2774c08262 100644
> > --- a/include/linux/iommu.h
> > +++ b/include/linux/iommu.h
> > @@ -209,8 +209,13 @@ struct iommu_domain_geometry {
> >   #define IOMMU_DOMAIN_PLATFORM	(__IOMMU_DOMAIN_PLATFORM)
> >   #define IOMMU_DOMAIN_NESTED	(__IOMMU_DOMAIN_NESTED)
> > +#define IOMMU_DOMAIN_DATA_OWNER_NONE (0U)
> > +#define IOMMU_DOMAIN_DATA_OWNER_DMA (1U)
> > +#define IOMMU_DOMAIN_DATA_OWNER_IOMMUFD (2U)
> > +
> >   struct iommu_domain {
> > -	unsigned type;
> > +	u32 type : 30;
> > +	u32 private_data_owner : 2;
> 
> Is there any special consideration for reserving only 2 bits for the
> private data owner? Is it possible to allocate more bits so that it
> could be more extensible for the future?

It could. This "2" is copied from Jason's suggestion:
https://lore.kernel.org/linux-iommu/20250227194749.GJ39591@nvidia.com/

> For example, current iommu core allows a kernel device driver to
> allocate a paging domain and replace the default domain for kernel DMA.
> This suggests the private data owner bits may be needed beyond iommu-dma
> and iommufd.

What's the potential "private data" in this case?

Thanks
Nicolin
