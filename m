Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010025.outbound.protection.outlook.com [52.101.61.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0812C15B5
	for <iommu@lists.linux.dev>; Thu,  9 Apr 2026 18:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775760262; cv=fail; b=gFN71jL/G9fKVsTGzSJ4fgP7vBvottaBW+AE0gacwYT+aiiQBh/5egqEABSqVXOhUcz1ud7ZUDNPQdlpdmnapH8ydDANKrVHAX3uE9bpfWnKo3Mag4W/pr069XwKamzn1kogMSeUVttgqGvnTwL9PBLrUKVfOY9cHG7GI/LZS5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775760262; c=relaxed/simple;
	bh=qVn7jLlmdMSCrmNFvyzakqX3sCQELRmPfCmXHrlvPSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Wq97NhS0oy13rVlW+TP8kfjjbigksyu7F8vUNzPlZstj0XpVB0skmBklWNtrMd+4rthS2OzzwVuHVKs5bOpxhqNp+GDHiuft1eT49NbFwJ9rxTt/UzxJ04nOFV4JwCWwxwxHk1H4izFXCVjtlJ1HZ0KmLUaFqlmsQvo27KLv2Lw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VG00otHu; arc=fail smtp.client-ip=52.101.61.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VG00otHu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i6g6Q5DaFD7NpmLF8x+RowtwmlNQEx7f391hV9lx13PDLn3k1EixLvLe8izT6kAa6x2e8NazRSvh6PnZBVzUMJwZ/NL3MHmabHuk3hOs2c/I/mBlqlw3uGao4mav8i7mj7NnO/J34miiyqi9pMYK7u0YmUQjPzbI7Lith8h5KdZzmvubV33BV1vjGo1xVc272YPZ68mc/D3DWDfQ9EkV3MqMnPI+IxxJWFTB4xZNCXe1Qmfy81NFI8bqykLiZoBXNM9STuhZbPVBmf/7BozXeaPxfiN8xOeGU32/Sa3Ul6AYjUNSW+bIT74rrtbyUF6NRPJ+KfsVodjWh8FAPsARaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fUknfiOPEjdzbCzAV59t1x3ht/aLlKaW3SlxZMbXzag=;
 b=sYoH8W5xigAbD9tUVOeDLyIrLC5zok1dFcwIDQT1GNnn94NwQN7LtSGBDVmSlqLRISlFQ7sX+E5P/LK/tyR/81d8UzwhFtsAEavONeoBgXnsYKfvwzzpmzJYdsqMNkwo7cxcI26Q5Eaw3ViSWNq7SE/P750eBoIF6mBz0gKi9BvEbtf2CTkPZhgEaY1kW1vsZHbGcxWPBTA0x0EKBQiJGXMojPjZOSu8Jmh9SngWirnZHenkQ4Dw8olLSh3pyGHRW6kpzmyht6h6srA/0N/vQi0m0osKzl9jyyx+4TRVEt5tawNiAlbn8APm9O3A40FYye3GMbHVY0bVu2hF8QW0tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fUknfiOPEjdzbCzAV59t1x3ht/aLlKaW3SlxZMbXzag=;
 b=VG00otHutUcFcfWFbHzvaWeymMtMWQc8U+CzKTqketq1Rq2pSvZqjd8dCspof7/bTP7ACrnMQ5EYli5K8ZcxpjYoM1vXi7LKVEzN4/J1aKZeyfBtTMIf56yZXBPwJyI9uSEsltfR1H6z9nDg2RMQxLaRpdX8Arr0YInzThHrF9RHH0OH32mPLxoV59zJCO1mG6m0lYR9ZT6Ve0E4TNp8s9A/la708rWjGTwAgWq5kEFqZHogR6Yxq/WbjInc0v1qSKqzo5uxbxdY4AT5+/z+Cgji35YM225/1QZFmjHs/3r9PqRWu85lqvZ1AhFTruU6/k4KqPmF6afyV4PIY05rpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ0PR12MB8092.namprd12.prod.outlook.com (2603:10b6:a03:4ee::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Thu, 9 Apr
 2026 18:44:17 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9791.032; Thu, 9 Apr 2026
 18:44:17 +0000
Date: Thu, 9 Apr 2026 15:44:16 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Alex Williamson <alex@shazbot.org>, Joerg Roedel <joro@8bytes.org>,
	Mostafa Saleh <smostafa@google.com>,
	David Matlack <dmatlack@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
	skhawaja@google.com, pasha.tatashin@soleen.com,
	Will Deacon <will@kernel.org>, Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH V3 05/10] vfio: Allow null group for noiommu without
 containers
Message-ID: <20260409184416.GO3357077@nvidia.com>
References: <20260403051146.10210-1-jacob.pan@linux.microsoft.com>
 <20260403051146.10210-6-jacob.pan@linux.microsoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403051146.10210-6-jacob.pan@linux.microsoft.com>
X-ClientProxiedBy: BN0PR04CA0058.namprd04.prod.outlook.com
 (2603:10b6:408:e8::33) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ0PR12MB8092:EE_
X-MS-Office365-Filtering-Correlation-Id: b5f0d48c-cfdc-4a6d-5e48-08de966800f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	b3C3VrqHRcGbKCLiMREcDkvScSas8SPx4rYv+CoJaadnbSExw1+SpilS+RAYOBSQNvEDFtXOCLE6Toz/WX5fb692ZKGPIk7l+i3ET0RJdNcOPCxTFcLhqNktfVUhTubVQhcRMc0GCSjzqOn66I42L6j6EJqhQWXy9u6bq6gXiOk11QnWA7i/zWmT9grAVu0pwRNWPowEuN9+ouUzJwsMT1VBAUEhGr2h1Pm+mGat2ZMRTbcxhMykmOQHQLqfI5PUwktEoa2iR4UxoMi1GvbsU6lKoBrEKxNd+vyTM8IpK+izWeox5WEMYFYbW2QHLCuM6w9zeu2c0pnILlHEPGDKN53FGTZHDnG3JC7INvzV1mkpnur1LmnlgRZfmB4xtjJ6gwDR1xKUDuhzUgRjCecBwkBwB8J0tAMsV+Lj9CaSCOsHHNdZukvpjXD/l8dWAX0Hz87O63tiSa994OUCKSowglN1H+o9NNYMc7rBUzhoiQk1AWGrKlvW3jy3CpzfdVs1ZT08e8iShTNJLtc3RK/eZrni5t9c8tvryrUJuoWh45AWb7O0mwDKHQLywAJmlkqoFktNWUNwEmds1n9arHhYCwHxgqewnf8sv3WypR9CmZzgc9rikC54z8RWc73klJWgNWU/DOBsJpUyROlPK4h6Heom/UM8MKd9oUb+V6TUeYbRN2N98tJMMTw/Vza12X9BsDddxO2mHgL19R8JEegsW9mbR7tzGlO8x8UFMYMFNnk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cpm2FxS2KQxubYTCsQGV2LfmkTXRvGWm7yF4+hNK+ZD8pUVxfuQam37L7auh?=
 =?us-ascii?Q?s1HBa0q9qM3Vtw1Vu1XhaPRcdu2O0iT+upHo6pXSsKrSxLNp6EiL6Xxum2DB?=
 =?us-ascii?Q?5Y0Ypne07ebPpFS+nF63wthSXWFBSN+Zs5TkpCMWiCW09k2yptmllx3e5Mgd?=
 =?us-ascii?Q?5faqgVLbvECoITc3cQLxT/RzJs+vfKCs187Pd+zQleGgu/8YoJrJap0HoPFr?=
 =?us-ascii?Q?40FvFJaGOBuKT9xDYskpb/boflGNsN2y8XE/qgLvpLGnm4jKGZWgZyTapZYr?=
 =?us-ascii?Q?BLJl/wYHWs1lFk73BU903iVp6jn4+N/z85I+PbmWhF2HGd+lPgrUYankmCxh?=
 =?us-ascii?Q?1TJJl4SxYGLbdUOr64ZoyWciGeDZKICUienjFhXul6SAOTr75WthPk18sYx9?=
 =?us-ascii?Q?oimH3EQBKMQdMKZCL0UkfANaFzNp+0HPFICvhf/Mz0Q1OhaQRnnGGtw6h1cU?=
 =?us-ascii?Q?WFe30+wAZi8kSIqb5FiwFIyNmObqePL2RRbteuHnGcjj0G5WkL2X8zXAXei2?=
 =?us-ascii?Q?uatsW5JYRuQOKf5sLXfK4ZSCJJNsGQ9OQ7nfP2F+QnapZm0G/NInMFa5BiV/?=
 =?us-ascii?Q?hPBuKHzkjzlBrmyFhbjQcBxs5IiVq2JGfSHoM9Ghr2MK9SlRbZJCRq9wcTVR?=
 =?us-ascii?Q?tx+NDlQ7k8ldW3v1KeU5a29ibuEBdL8OG4nHUiVDcFlB99kDmEHjZf7sQ4IS?=
 =?us-ascii?Q?MxmVGk5eob8SmI4KObpLkTz/X6Bo2lvbdIW725O6o5npKfsi74ixW/frDlcW?=
 =?us-ascii?Q?M/QBK0CKXM9eAP9cO0tig2otdH8xe8GcpQJqTzALyX/9SbPjlDvfigAslDGf?=
 =?us-ascii?Q?muTKz9FT3N4DHPFH3bCGVXLboHQNiqxfSCt2E+BZ37vQe4D22Tvzz8WruDfy?=
 =?us-ascii?Q?WibMHFv20hlFQLpOHYlGWk0DBqiMkriGyrDQRIKrzc7BeV2NqgZoJBr1xeOL?=
 =?us-ascii?Q?q6KsUYfFyKd9rqgBP7kimZEmI302Uzxrt7NsoCBZ3w217oA77TVR2DXYJ1ZI?=
 =?us-ascii?Q?oAfL3kHlH2mIysbRJ8Tyi21IQ78xeIO9IDl0WXEZWn2/3j4sC7VRKCcBfXsl?=
 =?us-ascii?Q?Ncr35OQY5ierbY2X19ogg/M5B0Jhti1JvX4iLRvr0l/CWKqowQV4A3sDy6Mh?=
 =?us-ascii?Q?LEpwP++nytugR3Yso7Ds7WiRbKnhdE4Q7bFiP+doMiQ8Vylq4Bhh2/o51C6T?=
 =?us-ascii?Q?d6Dk3B1/g0h857L2vHx+EWIElSOaMX/UyvZKEv+QoP97HxuFwGBHw+2fXcb8?=
 =?us-ascii?Q?cNS4qqIQ7hlzu14Pf/5gG6NK/uk9m6q2+OKm1xnZnVEqmPUNavpKJMBrTzwq?=
 =?us-ascii?Q?dEXsPzc8atLQvGNOrxdwkxqljrURgmQtyPoQWVWtb+kMGvjmayuZ8ckmpUds?=
 =?us-ascii?Q?oc1p0GxqKahzETb0xE53wALs6QhWONgSX8oNW5qyCZmCoVT8U1X2EbefCOgf?=
 =?us-ascii?Q?tj1FTu0Iau5HmhVcXIBs3kwjask2M7jzpL3C0l8GT25iyA1gn6MUzIMrgWqp?=
 =?us-ascii?Q?k6V0iyxEKs/BM2/tkhE8P/OTiqnlJFCWfk2W0anRGIuikg5qKaZ3ElNj+0kE?=
 =?us-ascii?Q?6W5tULfiGfX0QXvAz+nZBB1ze94+bPrphHS+HyJQsA2mNcAAg/lXzXS0SRX3?=
 =?us-ascii?Q?eSsTMWDlKYPqibvb/MuAcB4UQQqhTZW+HZdRpid/FUxwYo8YUoQznQZsPa0y?=
 =?us-ascii?Q?2j4S05N4HPi5/fRuQ3lhVrogLOg13PIBC74sJ8ztUagvvlsw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5f0d48c-cfdc-4a6d-5e48-08de966800f8
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 18:44:17.1336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hNXy+Kbouy4J0AgVn+VlqTpBCDDdDHsFkrhCBgIoCgyBWrH+DNbmBEIryGexcuhB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8092

On Thu, Apr 02, 2026 at 10:11:41PM -0700, Jacob Pan wrote:

> @@ -598,6 +604,14 @@ static struct vfio_group *vfio_noiommu_group_alloc(struct device *dev,
>  	struct vfio_group *group;
>  	int ret;
>  
> +	/*
> +	 * With noiommu enabled under cdev interface only, there is no need to
> +	 * create a vfio_group if the group based containers are not enabled.
> +	 * The cdev interface is exclusively used for iommufd.
> +	 */
> +	if (vfio_null_group_allowed())
> +		return NULL;

Sashiko wondered if this causes a null pointer deref without pointing
at a specific case. Claude found a case:

@@ -696,6 +696,9 @@ void vfio_device_remove_group(struct vfio_device *device)
        struct vfio_group *group = device->group;
        struct iommu_group *iommu_group;
 
+       if (!group)
+               return;
+
        if (group->type == VFIO_NO_IOMMU || group->type == VFIO_EMULATED_IOMMU)
                iommu_group_remove_device(device->dev);

Happens during error unwind in __vfio_register_dev()

It also points out that the hunks are weirdly split between this patch
and "vfio: Enable cdev noiommu mode under iommufd" so that things are
broken at this point.

I think you should pull the vfio_device_has_group() and related into
this patch.

Jason
