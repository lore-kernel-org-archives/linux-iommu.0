Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012046.outbound.protection.outlook.com [52.101.43.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EF337882A
	for <iommu@lists.linux.dev>; Mon,  1 Jun 2026 12:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780317792; cv=fail; b=VKJg9gemtqk9OtDlWptNrzybSpQZ1XhxOlByVYH19gMqRQi5XxbOSQf2Zf+eiIyfZgY/KE/KuSJyCf2Vd1b9l3QOZlfcfUGOzUxBKcRbjCyEy9GP8zOUUC40hs027SNTOXUoODDxeD+LqwtXz1V3jUiQQq923uqknrVjRBCH3zg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780317792; c=relaxed/simple;
	bh=LeXRyRLf3UbZoWzxTuByWXgtF9hj+UGE4D/yJb/EuxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lR2Ov/CRCNVbWxvT6i0NzYP+P95zi7nZjtmxTeIyjVcL9ktIjxIEoK0nmKTOKn7WG5Y9oFP/PFDh2xSVxfAKw9EBe6RcxY+875Airu0ktZ5PgHxVSyLV+ZCTQJdRppM3ZIKmFVogDqcPkVFej0bTHl5ab5dLkkXFrAy3MJKFBCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DsEwKUlM; arc=fail smtp.client-ip=52.101.43.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DsEwKUlM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BbM1IdM6XNEN3XihM5xfJU3/MzaGeQIcQAFdtrGBCKOzyol9OYK7diErb2cPN6jSDTMJy+P4tKy79F0XQ96xrYbxxqeIaQZjzT75clhPfs4etbnE3LkcjyJ/KrrvB9fWDqIC6BpyL31rX1hUY9w+/qx2rg2XBE0+WVEyYb7EWRKYFrS/5h/pyyhwDOW3ZXcxFokQh58sAIoTaLXZRqO+qMBJt/J31vnaLUtMSsYlB8XRJARqvsppdMiW81KqdSPs0k/APqUVbDxEmDFOx/9JrYxd+kWvKMyhF0FoWro8wny0lrHXCdJerV+s3hm1QeC2VD9Ro/rYO17zoQbX7QshPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g79bxhEW56YsFkOzMerAjOuIxAdpOKFLt4y60a/cZxY=;
 b=LyM9ujqC5mqQ0g1mrnq5uNrUPerjH9PiIyjuTNENN47y74jpGKBfew+VyVa9xGc2jDS5beaAxqeC9FGes2/Vi3rlvtpb6iffbVAyNF7SMQL3d2eO6Jc0aDewOIBvQBbxSYl8zCBvkCuNQwe2jcW7mdo+csi81aUrDyCNWy36mYg6BCLvJDOGcEStpBxdVmmKkHN/3oLA4sf3tdYqKbnzXpjkJPBtW5AAl6jXzmoNkSOdN7bNjKE1K9hokB8hWiIzKBWKKM2Wa6rkVz2761Dfgsbx4bTPnLwMpz4eAyRmRrTzJVvkorS0+PVCI47qSpstDlidrFLaViup3uv0AGXiHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g79bxhEW56YsFkOzMerAjOuIxAdpOKFLt4y60a/cZxY=;
 b=DsEwKUlMLJaHg/D6LXxQahqSpgrWMLxkhDtZDihjCiKN2PUWsN2mEfkdlClQvC38j09s8+TVw/IPv3GAWa7Ni1QGTUGiFRoRX+jNyj44X+0rAEvVdPjPO6MHcSiDXGO+pqLC+xZ5+LDh1zs4XIdLAQsofh/9HRWTyyUnc2rcGHaeCwx29HIdvAsM9GqupwDrb2MLPMdbKF3HXRKoYzD30DnY8qZrdjXNb7Xvs3dfA8ICEsYuxo84C0UDn0YP3K8Hkr7t41hjDg/izXID5tRg4M41d7OPRxID/OrEi9USZG94WrpCOPOQCsyF13dTU+ddl/ql0ui57kkjzcPGQW03zg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH8PR12MB6817.namprd12.prod.outlook.com (2603:10b6:510:1c8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Mon, 1 Jun 2026
 12:43:06 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0071.011; Mon, 1 Jun 2026
 12:43:06 +0000
Date: Mon, 1 Jun 2026 09:43:05 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
	yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
	vasant.hegde@amd.com, jon.grimm@amd.com, santosh.shukla@amd.com,
	sairaj.arunkodilkar@amd.com, jay.chen@amd.com, wvw@google.com,
	wnliu@google.com, dantuluris@google.com, chriscli@google.com,
	kpsingh@google.com
Subject: Re: [PATCH v2 03/26] iommu/amd: Detect and initialize AMD vIOMMU
 feature
Message-ID: <20260601124305.GH3195266@nvidia.com>
References: <20260528051738.596013-1-suravee.suthikulpanit@amd.com>
 <20260528051738.596013-4-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528051738.596013-4-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: YT2PR01CA0010.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::15) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH8PR12MB6817:EE_
X-MS-Office365-Filtering-Correlation-Id: a7ad60a5-c5f1-42ec-151c-08debfdb543b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|18002099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	PS75UA18pcxU/JfymLl9Ystnn9/X1WxB1jdUhzCjP8jWAlNHL/tsx/hISeFcsgpwV0Lg/4OdnbxcQj4/mlGzMrabDLdV3qb9dWgsEmbxJau08F75ZLQ6HYPMuPH9T0LgNJBZU6QikP4Occry+H/hv0fd1E590BfcpXwFcdc3dV6W9bU9mn9yL799qqNancUfHFvZBI6ByCcF4iZnj2tPSGmMZmT1ZDeICbCO05BULAC9BI3TUruvUoQ0wFZ0zwOQDgVHkfq2hH92+BM3TjXJi5ho4aM3eUBzBPFdhig6GmuYK6yTMiMuQZc2BAm/+Zmn7yxlct7pd+QC2BBFSp0aSkZECuEbDQAwEXDvrjwx2H+WsHmMD2l3PNs0BuRrWZ8q4ANW/vGIFj5i6fbBOWBS8+KYJpKCASyd506OTcqlyL9Y2YgESrFy6Ksr5HI5SfRAbJSZGZe1sqo9207Lz0mReQ9g+5CCeWUI+IRwLlThT032mQD2s6kJy6+cgV8eiIOnwkdAo24X6N1s45ED7ouqM3INcTBBstBF/gnDPDNB//6NqC0JtbsZNnRziicbNzpbC4RIBLA3/SKY9OaFGWMW2Gfu7wiH+TU1nolsy7nMFSl/TVbLtDhs1ToQHVAk+YFQrxkFKAC7+L6O0miGTNfiEmj1XCF5Rv3PxvD3H8KobOZOzXh+pL9xHieekIgy8AcT
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vxNhOBqwCEI0TG3JqOQQjxW/oRPMh6JDFbEIPJOcRfWiWtR6NjmzwU92h4z7?=
 =?us-ascii?Q?S1p1GaLoMuBHIk3NwaAkbN9NamexaX2gFJ+YrQ1F6xxvFLVjM+G1UO3emFUp?=
 =?us-ascii?Q?1niA/Ks4FClXXDBlQAHxUZZoaCpJ/OLyq+aiWXt2LLoIm4DikVWrXGE65C0v?=
 =?us-ascii?Q?pH/yZIvRn87eirdCNLxC+VLWWmrJAGGmkpC4X+mekoSfcpXG//cGtFWhb6KO?=
 =?us-ascii?Q?RmrHuBQZ6CIdlrDwYlqp9hIN9U0M5oRBWwGAX2kcFIqsJJop0bThm0CHn1iu?=
 =?us-ascii?Q?pDup4nfVEXniHsEZt0WT82SWL3vgGjvX8jPQY1gaxY1Xei03jU/K92+jEPGk?=
 =?us-ascii?Q?O91rmqr7coSQPXs/OwkveSuP+UqEEjO7K/FbncOmBISokKAMVO74qlhG5BRX?=
 =?us-ascii?Q?MBgMiKVemfgt15A1cNGxppuhvZ27ukLR3LRxnKb/9J18OPsX7FXENBkbViP/?=
 =?us-ascii?Q?qNXLE0KuTOZkQyCy/b0m6xFSTlzIYOzt5o0Hdck7guJFmJz3CJn2QWngxVGG?=
 =?us-ascii?Q?TAnLtZiIMYyUl7CW+y3uYtVwoR/yYvJfvod++FzlS5R6ATWHwfWE3EHOsKaP?=
 =?us-ascii?Q?S2tAGVZuue5D17lVPwo/Se8mWkAmVa1pqi+zHkC0vG8WKY2FCx5hovY0cwar?=
 =?us-ascii?Q?MC8GeozC3wUbCL3vL8Dfq53wqSufQDOsJuLlK0W+BoZtgXQYP+0A+sAu0iT5?=
 =?us-ascii?Q?7d6JnnLDCAnZ205aCuvGAMP8XhwA1tpNwKsNjPcPov7chHgvhhdXpHnvU6OX?=
 =?us-ascii?Q?JsFQC9KdjeMR1BbTfjhECo9f4IdDnfQjY4ISmyRakvpBrNc16VSHTGmXgC9F?=
 =?us-ascii?Q?r4roiRjkN+tjz3TNwDaKnnAMC8ivSSsEyNUV69eztiKblMAU1UKuPcjiY7et?=
 =?us-ascii?Q?XCP3QRLyF5/7RAxN5snua5ytLqVMxPhO9G0WJWBhoIQQ0s6LGn9CVDNIrvfA?=
 =?us-ascii?Q?SjPjQKU2xY7xvHSgrMQg09/2R/FOMV6vaYQNDmmFlQaqZVcbg5Sx2NDBcEK4?=
 =?us-ascii?Q?rlq6l5vKlY0k0Nq1km5VNnhyFeQYtTRgb0Xn8nSLUJxGH3PBmR8OBzccKuC7?=
 =?us-ascii?Q?bf65h5axP21Orjzhy1lXwQwFY8/tUgWW/BJ/fJnE/1zZkGR90h1kCH+4Jgj/?=
 =?us-ascii?Q?HmQBK8YvGfXIaF/vkeexA/pBCSrlpDEpASEsdYnkC/0SVl4LR1JJPhe5ehas?=
 =?us-ascii?Q?1dgVRkIY2Sk9vg+k2lcK3VomMnYqADQ7c0zBLLp2ipPXg9ogj9bgJk5Yfpxf?=
 =?us-ascii?Q?e80CX2f/SIy42KZADzFwK+ShjLr1irNpcFpWoYLDTfH27AIOsWvJzfNFFTNn?=
 =?us-ascii?Q?d5RVqkaM6PA1NhJ18X/b59Ko5Ni1oAsGzsnInUzDtdXy5Q2VnVQWV+cXfgf+?=
 =?us-ascii?Q?tdduA15GGuGNdcTU8JaHTjrtnDxMWA7WyoD7W/iMhXWULY8Xd4EK1mS+Y6ED?=
 =?us-ascii?Q?ORxGCv5DFpcsLnoo9ls+TfvT3C68wgC9bbWCHlwj13u9u4VyxTudnk1Zt6YM?=
 =?us-ascii?Q?GNLVwRUjHQyt7RVB6e9qAHWzY0BdDUIvvVEeGvfsryYh3GhZPJFurEYIfW6y?=
 =?us-ascii?Q?Gt7sFnh9iD9qXjA2YJWnimKdfTOvow4lgKd8wczQvZfEHgZNShb7L27yJM1K?=
 =?us-ascii?Q?7lVephEYNK3FEc3v9Ba1zB7anQXYATCYwsXTTMnH79atVhccwNpn6GTjIPea?=
 =?us-ascii?Q?AInbR91rp9LuRYzioLhmQyShFHOmf7krOueCTZm121X6h75o?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7ad60a5-c5f1-42ec-151c-08debfdb543b
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 12:43:06.6698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UyDUnZwsx7DuhDj15fboGuZl3ANGCTzDnfM6CK/JOyqdfzE1t3njTCluteaxZIRf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6817

On Thu, May 28, 2026 at 05:17:15AM +0000, Suravee Suthikulpanit wrote:
> The feature is advertised w/ EFR[VIOMMUSup]. Please see the AMD IOMMU
> specification[1] for more detail.
> 
> Introduce a new global variable amd_iommu_viommu, which is used to
> control the feature enablement in the driver. Currently, the feature
> is default to disabled. Once the feature is fully supported, it will be
> changed to enabled by default along with a command-line option to disable
> if needed.

Still no to command line option. Just don't use iommufd if you don't
want to use it. It must have no cost until iommufd activates it.

Jason
