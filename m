Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21DF285C92
	for <iommu@lists.linux.dev>; Fri,  4 Jul 2025 15:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751641605; cv=fail; b=CMwVzAA6ObSWa4GO/kUwttW5asJj38UpJEKp+PEGzzw+VMc668YWuIvi0qXLjx5V4PsTmEA45brptHd8ye1iURO2LPHqKaFc8HL+1o3uEKQ+uIFWmC0JpQircBblWTpKy3Yr/HYLFGXHqziORhJC11P+OpnKAXiZJ1811ZVTHJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751641605; c=relaxed/simple;
	bh=UNiad5TyobxxGNEk8wh7LHfdus9FmZ4/IGOQ4gDzK5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ISHPN1sW5aCCaY4R6rOhr1W7j+9T8Z1AArJVGXcqITatCdoOfRaCnp64+pM2K8tUN/V4wUmbeL6VoKzjWhtz6xKrs8CqDT69uGCVnzPEFnI7yn2vMMPlxjWTnfLlqnU8pHo0nQRLy/lDA6orA0U6V5RRIa7p6yft3g2pbz0ylec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mEYJh7Ws; arc=fail smtp.client-ip=40.107.92.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mEYJh7Ws"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IzLRPPDG2Lqu7YvjpOa6LRbY/lATfrImfVfSP3r9m17WMeL4TNwExRDOhhcwlDyGBsMaoTgUaVuCsMgbiPL3qCHoNPo3IF7FcgZioHPZ1vy4UM/G/rUoT6izvNC+MtzIPa5z5C1zF6IXJxe1UK6FugKjnmVat/vToCO3BCYH0/pbzRY+bq312ikRcj+ReRTHKySbRvthigW6aVEWxCGV6dyFRfcs3MCfe+wgEe9HvvDJHHXMom4donkFiswitr6x7NkcemQx+dObG25p9OyxCtOj1WXL0jDz/NvPuXnXeWZgsiiidNbazlkcZfd0cXt61xWVhCL+HhQh3/zAFdAdEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gxw+6UgxYEaCkOk+VhZ49KK8nOF8ZvjYBPTuYQtVEoc=;
 b=qE2/tCHU5lCVhhAbLK9sKEyM1/lquHgJ0HHmrjBFNDX2zkNxbs2ohdea0ngeCw19bdv9dSVvAyjYawFzN4qg7vgIDccML0BQWRFNnNWg3O3vP8N2qcGGEY73yjQAMmrUmIrXfsatHZ6QJjNj+juo1JT8WicoMx5IIM/roOS5NP3I9qtTi91nSCfQsvtNt9VKha2EsFyin7rgNPjfHn61RgIQqVbwRTYX2AD1TuRvIb7GOUM0QWT1RS5pZjVpX2RRcGRIfepQvQFumlM0OxLP3OmcGM+vwTncfQr6ImbGWQZVLeOLLb3HVizapf7/QZUh8acWBp+1BvVR0Se8DCNIiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gxw+6UgxYEaCkOk+VhZ49KK8nOF8ZvjYBPTuYQtVEoc=;
 b=mEYJh7WsMQTCsbDyKrn3QRn4d6x3mULGZKZJuBJrC69C0fZekNhuN2C6DX132u7jNFS3QMlkrG8GRA6kA1o/eye4yLQi7v0zcxIncxgNbxugvThKAxakm+XWFUADDlC+9I4IWuGhnKltHj2U3m0zc4/9/gJj5kXQO56breHJ7B+fdlXClnnttyZtOZ7oYm0f2eYABM1o5Zd/v0C4gKq4Xjt1whMTnEGl0MdR0Lm32A114aLJzfZSzK5i/jLdqSctZxr/zKMn+jaeNnb+bJ4beNgAjMdFObV7Ffo3wHlLfe09ahfAv7Ma5shbSMo5LyIaV4YokU07AJIETIdxs9YcZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MW3PR12MB4444.namprd12.prod.outlook.com (2603:10b6:303:5c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Fri, 4 Jul
 2025 15:06:39 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8880.030; Fri, 4 Jul 2025
 15:06:38 +0000
Date: Fri, 4 Jul 2025 12:06:36 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: kevin.tian@intel.com, will@kernel.org, aneesh.kumar@kernel.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	joro@8bytes.org, robin.murphy@arm.com, shuah@kernel.org,
	nicolinc@nvidia.com, aik@amd.com, dan.j.williams@intel.com,
	baolu.lu@linux.intel.com, yilun.xu@intel.com
Subject: Re: [PATCH v3 3/5] iommufd/vdevice: Remove struct device reference
 from struct vdevice
Message-ID: <20250704150636.GJ1410929@nvidia.com>
References: <20250627033809.1730752-1-yilun.xu@linux.intel.com>
 <20250627033809.1730752-4-yilun.xu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250627033809.1730752-4-yilun.xu@linux.intel.com>
X-ClientProxiedBy: SN7P222CA0022.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::7) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MW3PR12MB4444:EE_
X-MS-Office365-Filtering-Correlation-Id: e3c55a24-5a55-4640-3769-08ddbb0c6047
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?m9+buL7IQzsL1AegW9/VYBE8cBBLOMcw3Sm5HEHcLmFCamY4LWFwnA2aU8E+?=
 =?us-ascii?Q?MTsJPscx3XI0AiBMzZTaP64X6ELJ3u0LGCkvBoD0Oyd8GDUpkYO/Pe/uPDnP?=
 =?us-ascii?Q?r7JZTrfrhqPwJuA+ekZBbzqN+Pza/zbfvKRFBzikL7OM6rgmwDgUGZ+BA6sc?=
 =?us-ascii?Q?Wvp4pnMa/HAGv18MJvKsVZniaCTrlgkS5PMZhJKUy1ZibNvLzIhLLQlKeTk6?=
 =?us-ascii?Q?kK4GRJSJs5VhABgV17S8rY6HFxTjDz8teQfzQSNW2zfv2nJIP5z5WfQjFf6d?=
 =?us-ascii?Q?ZT4GcE0CKa0JKSd64URfFcXOxyXqqJbZzHhrW25Ns/SeEsI5tmotcVGG2Sn4?=
 =?us-ascii?Q?UnyFpMlTYWW8zwvwH/O7Oh2QQao7T2gmrs25WWAT0Q422asPEroZIiKtjiHX?=
 =?us-ascii?Q?A/0Sm+dPjWtEDZSDrWsqxVme/+ChrSeE23H8gY03KZ8FJfnfzUgcyLHj9ifg?=
 =?us-ascii?Q?GQvETxvfpJOTMAcMv4EftNyprcM6+S1hoclr7DcSa+cnF9uLgPREtvx+cfFE?=
 =?us-ascii?Q?MZFWNjoCzzz5WFxvYEy/viR2hhws1p7F3/P8nLnC7WJgIeojn3Royi3xS6aa?=
 =?us-ascii?Q?E37p2qT5HLMmOtX96i7fys4rqC0TWRXQsVwDW/Bhrj7PQOUQOEJyckPkh2ko?=
 =?us-ascii?Q?JPm0WQF6f7LVQSckl70jYbNCs/hLQuUgD1ba9wV98O8th+Ki7w4LOeA1OQyy?=
 =?us-ascii?Q?NuP2Z120HfHFYEpd1APlIZPGdJ3UW6rbYb6f9EBBXJwLljexUxHUPsZBu8cX?=
 =?us-ascii?Q?FnYiYStBiRECncwLwGat7zUAj9d1D/pIVHjS0MWy02G2t2/bzcrQ0QGDzj2A?=
 =?us-ascii?Q?93tyBWD82Q1HKcwnRX48/YWPVsEHhJewnZP/2bcHCbNNPwtl7LsU+Xm73E1H?=
 =?us-ascii?Q?dJmWGz9LQVCp5pvnKLfS5JKlIBwXQefH9v37Sf+XPES1xB/4+j9cWai/DC3j?=
 =?us-ascii?Q?ulybUa7mD80GzQh/TBo0Y6XSYSum8X78+s7j3e+5JhkuH3AUXqZ2uZJK3XsL?=
 =?us-ascii?Q?kndlCT/5vtcTyG3nX27Y9wg/udwfRlMJWhHSK1Gh+1EUcj74JROQr24hSLyl?=
 =?us-ascii?Q?8yukPv07y0j3/hcH+4zKuLeJoLNvMBVE8N1wtUOX2dEiVyjmTnKlgowbhS2X?=
 =?us-ascii?Q?WtWxoa/ti9NvgTh47g7zPf/1LYWSVuGcQf56bt6jRcovrWligcSJ7otIjJkW?=
 =?us-ascii?Q?YkryM/nZSNl6xEg6FL2S2f5tBgBd38/qOR66YB/9wwaTFcoi30FHy7wM00gM?=
 =?us-ascii?Q?zhfqKKi+VMMmLDQNOL/H4CQOtN98tzGtAXiQqhBnwt+UNjzEPpa9I98BDhYz?=
 =?us-ascii?Q?RBxF4AsWba/HuodHCKBx80GUeA2h6DdwPX8VZv+JUWCx4JT602tLbMYXoYKz?=
 =?us-ascii?Q?rbudxFuYfSYVtHfEzyTlP2B3vW5NyaaPJ9BgGSmzEtx+bMp3Lki4ftrVYXf6?=
 =?us-ascii?Q?/4SiU1R6BUo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?s3oJ7Es+VpTvTDnYnaNeZc84qLbLk9gBGRDnc/RaJUki3bJ4Mp2G6mGVnXLf?=
 =?us-ascii?Q?lQg1CGSk3tZKfgXidGx+AZcV4K9CHtxGx9TgmOPR1XHIvpEImo42pgs4Ljco?=
 =?us-ascii?Q?2IGAXbSDXXJ2JwaKeLhXWGmy7VA5W3sRcGDxnLTtizeN4VJR6So3loiFNksG?=
 =?us-ascii?Q?rrLvm+k+wApkpGZtsZ/EAybCfYjN89UdvWE5By7m8SpwXig8QxSu9HP/kI6b?=
 =?us-ascii?Q?DnehhY6+Kgkl+ox1O9iKlnV4qfvrze2EIB+BPaIY7ehJSRO3zuhawRTYXOIT?=
 =?us-ascii?Q?6vNQX/VQLkqDF2+Bb/YiJAWoBZ2wkrjh5395iQrKBdMXtsGCVCha4l17FlOe?=
 =?us-ascii?Q?JUqWUlMe4Zg0f+maxwmHeHYvPeL4Z59MVbpm3CRDD4y4uC/aBlBAAHaS5b91?=
 =?us-ascii?Q?goy08shLtJYjGc89l8PoF2Ykn+OdEX8mxd5clgGceSLRZZ7ijj1624+SPv7M?=
 =?us-ascii?Q?ZFbff4IAykNwIAiwchhcF/kbSvrf5TG4UjnoOpP2vvpyWCN56+18ytVN+GpS?=
 =?us-ascii?Q?q4qynEtnjAjDCAY+ChNplPxp7piVmlr+JxWIQFWYKXtzokugHjnq19leHCyi?=
 =?us-ascii?Q?pYSapIad946UrUteOkpm3PRDjNg5Zpyg+0A6/q4D9FXt4UzrmrQuMJD+dTZy?=
 =?us-ascii?Q?xxrkmIJw/IjCXTdDIt/iV0XygohjB+aKaLP7YbY2QfyfTV6KU6jUCIVbwAAk?=
 =?us-ascii?Q?sT60AE8UXnWnF4KG1zKJQwAXe/J5iRsA2vtxKKnTaPlimj0TbP11PmwPE9jj?=
 =?us-ascii?Q?Yb19F+3az6xDkwA0mAPXVc/fNCtGOjrfEEKgIHeZY8MEiIJvMSV8SNigMa1x?=
 =?us-ascii?Q?2MCxDdnC92ZyKT5X4ZRzOuLqA4RYICdK6bPZygxZ/Fb/ECpztdHjHyy4VhWu?=
 =?us-ascii?Q?SwBIv54pjjWakDJYJxQjg+9NYbTX0vBmxlDNaG8xbyb7Pq0jozjzCWlPpM1e?=
 =?us-ascii?Q?PX+8G38q9BdBO8P/gkPg5ZrStNIxgxdxRAWM3XYTiCD8OYOjUP2qNQ9oUiWP?=
 =?us-ascii?Q?24JG9bxMyEhQ6C8R+60DUcT9FprFRJTJIGlW2XAffNtbY0y2NJA3gmfIBr/d?=
 =?us-ascii?Q?SNiTj52Y9TmjIA+FROYCsxWXCP04Dt/YVrdwrTUU4MP/Flp/1ALOpQ7EfQWU?=
 =?us-ascii?Q?cpJ+DmU2Xk8VL5uM+ltzGxg4oisbIvMyKXc2LmDVIenNWJwmOzfIHH7ipl8g?=
 =?us-ascii?Q?TMNzzaFrJ1PEP5zTf8BaTSPminhErD81PpWWv/e+lLKd/5CF1XFOJcwxms8I?=
 =?us-ascii?Q?A5Y39tntnsOy9hgRgIjYzDn9IVxFvgRKwr3RNACThkwr4eVkT8bdD4N4nRDw?=
 =?us-ascii?Q?3GBU6bhbFdjUm7BqzLqcG75FWtj0tYnal4O0Rz9Jr5xEET2+vvn14nryE4jn?=
 =?us-ascii?Q?rZx43aaS3HefN3pt1wfRwAzcnOaylnAiRyZzU8VgVhZipWUZkmLJpsmBjugC?=
 =?us-ascii?Q?RUSBEcqIO4Y6ZxPeUTu/3JccqjnT9GfvwqdSG+XHLBjKWqSqugAuQLEQAIAT?=
 =?us-ascii?Q?skyg5KTiGbgdfNWz/HqrmTV6eV509pJuHbAyo0YJkhFtRz4fntVCqkARuD/K?=
 =?us-ascii?Q?mGabTgL+hktiinPZlKHWYST4MsXWWFMPiFusWHWg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3c55a24-5a55-4640-3769-08ddbb0c6047
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 15:06:38.9186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 08q3jHgBb3ZldY1XhFRTyKwdq74szBxk4MIXv+vneEkz0/DvwUrgmKs+JcOjfgtd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4444

On Fri, Jun 27, 2025 at 11:38:07AM +0800, Xu Yilun wrote:
> Remove struct device *dev from struct vdevice.
> 
> The dev pointer is the Plan B for vdevice to reference the physical
> device. As now vdev->idev is added without refcounting concern, just
> use vdev->idev->dev when needed.
> 
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> ---
>  drivers/iommu/iommufd/driver.c          | 4 ++--
>  drivers/iommu/iommufd/iommufd_private.h | 1 -
>  drivers/iommu/iommufd/viommu.c          | 3 ---
>  3 files changed, 2 insertions(+), 6 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
