Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012060.outbound.protection.outlook.com [40.93.195.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432C130C62B
	for <iommu@lists.linux.dev>; Wed, 17 Dec 2025 20:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766005090; cv=fail; b=V9bconCltPXCJTJblza1WYQO7flccOkRu6kE54JMVbEBwcLEfboVJNYFdh18UTXd6UsfpCR9n7CNb4Dvw1pYfmrzT4L6P9sxIKvg5q7Lz2TfYQNSgouDyb2KuT2siOjDLDSm5RaEOVmc1qk8cI8uIz20Tjm2KmxP5ghYgK+qL98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766005090; c=relaxed/simple;
	bh=1NLbZQZhlqdMlNyO84HyIapB/H+MsyFVlGXqO2wJdMg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t+1aozzE0cTkHJCNw6o/HpcfIIHLCX5qpIt4PSsBLpqo21JGv/kazh9cWaYw2HCBygqo7S2oNCdRB/tPKGaDFAXnP6CrdQ2c2eXKCb9merpSBhjrXnbmrtHVsmvTqvIX0/69yVX5T2iZnHlba/2YIlLRUj7OWyg/GiV+GpfmPxw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oV0T5BH+; arc=fail smtp.client-ip=40.93.195.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oV0T5BH+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E7ZP66Ju0SGToQcoV9KU1OC+7QEbf8TZYYUZ6/fdJIQgK8w7sdTFCt9Gr6ievpxB00ZGmY+GLiaruW2P+cFtn05g1dUMa6lWpzexoMz5PpfVelZDEqJXytSy9s0m7xhTS1MHp9K4mrB7SEltuHoTAasYW2tlSEMs0HidVwrGBRqwsLcqoQDA+jMTvGPa45zPzA8DvS6Usq4UjjQbTyoxe3Ljbc5gQGUdwp/Y9fXcoehAm+cUNw7xOpyRgM39Xi6fdXsTX+UC0yOT8X6l2TNXsKkMBmizkEsSwWaWQsQwFwYO3O1nc5eZzWM9BYIE5hVvnay9UoJXI95lpcKq3UdqRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WP16lYyCQwT19HHXqFSushqR53QDgNvF6P8hH/+RJUA=;
 b=DGAi3vFquW+kBBLqXLmZGsHYYFcWUbHnoPOpqioyLGwfzwyd9GGMOG20rd0/4MBEum0lpNnzIxVoXWe1TQQfrvcl+ssg+4iz0J1fgKd1beLJMCyxDAZ0qjIbUdL0CA917ux77lwhAhgSileOJTOk2J/vJDPFxyKfMLrDQmfl/YFvXWU2h3V0bhZ97zaQ3LgDd+IW8l81nwkr/+TGae8jhc3PqDCMopUNPRz8TaUZf8aKnBTGX15eieKtPQqUrkADzftOGhnH0w8UENnLaVvHBV94WL51ZCi/raRfZsXuyTdzBkJO9GcwB1eQ6xeCZmPhP3uTdjMQR9IH55HBvYjtMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WP16lYyCQwT19HHXqFSushqR53QDgNvF6P8hH/+RJUA=;
 b=oV0T5BH+78l1awF/77pWNZgbwtJb+fL0+bJXNBqgc6E6KGhJJE8xC/p6QMzEBq9Ws5RtE7VJk8GxbLwzQLHwa426d+fPgozMJuMst2FvKeIN8jICxn5tajS5jtmaikG4cNgaKZ40iQMA9IZ1l1yN5isKwzmo/a2jQ4Uoz4fEyYLdiyd1W92nIee3PNeEWoQ1Y4SlPFQnMhQZrp4cOpYfBXJNqkHMJrYu3EW5CKoz7asu8/SiMfyAKzYzbTYS3NV8KKv3cXgOzAyxAgyiZ4+2MKl+tjpQ6vp0VkRsrz2yPIPx11Zs757q21vnFQUVLpzsn6BO0WAvXEFoKHBDtv7eXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by CH3PR12MB9341.namprd12.prod.outlook.com (2603:10b6:610:1cd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 20:43:14 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%7]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 20:43:14 +0000
Message-ID: <23df682e-6d08-4827-994e-1bbd89e5c903@nvidia.com>
Date: Wed, 17 Dec 2025 20:43:08 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 2/4] iommu/arm-smmu-v3: Add device-tree support for
 CMDQV driver
To: Ashish Mhetre <amhetre@nvidia.com>, will@kernel.org,
 robin.murphy@arm.com, joro@8bytes.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, nicolinc@nvidia.com
Cc: thierry.reding@gmail.com, vdumpa@nvidia.com, jgg@ziepe.ca,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-tegra@vger.kernel.org
References: <20251215064819.3345361-1-amhetre@nvidia.com>
 <20251215064819.3345361-3-amhetre@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20251215064819.3345361-3-amhetre@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0297.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:38f::6) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|CH3PR12MB9341:EE_
X-MS-Office365-Filtering-Correlation-Id: 53dda686-3573-471c-6e2e-08de3dace655
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MnlYYzhnYWd1SkoyeGJhWnZQcmZpTUZhcmN1OG00dGdTZVRHNmtJSGV2UHRY?=
 =?utf-8?B?VnEycHA4U3pUQ3htNDlRbTJXTUFHbEJVd3JHUUpGVjhHOXdRNnh1RUs2Z1VD?=
 =?utf-8?B?K1FWdzg4RVJnaVdMem51NHo4M25MVzFiL1VyTCsvTEpxaWwyRFJhb2ZNTUNS?=
 =?utf-8?B?Q25BVWhDRndjZmdjM2Mvc1BKTG5MNXNDdFhRWnorWFg4a2UwckxMWXM4Z3NG?=
 =?utf-8?B?UnVSdmtnY1NHdVgvbmhKQ3lWNklZeldHUjBYSzdVNnUxNTBhR29Eek51RU5M?=
 =?utf-8?B?Wm5Xb3ozK0ErQ3VVS051aW5DcW9ZaDZXeVVuSzN1SG95NzFhTFNvRHlYVllU?=
 =?utf-8?B?Q004OHBOdHpocFd1Z2RLcHZsODVwRnBiSWd4SjVjd0dXeGVKdWN0dzRDY3Qv?=
 =?utf-8?B?OGFqRUhEQ1lTTWdLcTE5dTdrQjhKTmNRU0hIQjhaTzFMV3pDNEo1bDlNeEMr?=
 =?utf-8?B?eTVxa0tkOUJUUUppNWtNeDVyRW1jQ0Nzc2JjNnVGTXQxVDNoTkpGV2NrREhM?=
 =?utf-8?B?OWl5TDNRUlBiT2ZKd24wejB4NnNzK3lJbEFpKzIxejUrcWhIa2EzTEFMak8r?=
 =?utf-8?B?REFZSWZqYm5QZkFSbmc2U3crZmptTjZmSEYzcHV5cnBDeDd4c2tXNFVOZTgr?=
 =?utf-8?B?RmZ5U1Uwb2p0N2kvTW16MWY2aktHWjJ1eE13QlFoZjdUWTA1d0Roc2diVjZm?=
 =?utf-8?B?d08vQjk3NHlFU1N4a2dnM3RONEY5SzBocE5SQlFSRnoyNTdkR1pCc04rU0Uy?=
 =?utf-8?B?UkVPbnpNako2UnRZVm4xK2FLeW1BeTQ0bUU4Y2xWeHdzcGNzN2xTSlNZZmt2?=
 =?utf-8?B?NVcrWEdJck9BRC8vb1Bkb2g5b0x6UnhyZ1k3VjdGT3pRZmcvQ1R2RDNKek5y?=
 =?utf-8?B?L2JGaXBGdk50bVdxb0lxRW1xekRjR2liUTVNMFBZSzlKeTZCWDdDQkFSRWxE?=
 =?utf-8?B?SmlodmUySUN2Ry9KMGRkTy91elhsNGZvU1BUeDJ2QStOMWZYeEFlck11ZlZG?=
 =?utf-8?B?endOa3E0YW1nN1FRNGlnN1BucEFHOWNXUGRYTFk0ZitnUHkrKzFiVTlpQktV?=
 =?utf-8?B?eGZUbnFxcVMvZXdKZmtjbDNVTVpRdGs4c1ZNYXcwQTZqenJZNTNFV3gvdEYv?=
 =?utf-8?B?cUtCQzhLRUJnbUdReWtJUFhkVS9oSVErZjhUTnZFT1lONDFPMUROUVNlWnhX?=
 =?utf-8?B?SHozR3VBVVArUGRyZ2lxalJENExXVXluNC9iYmVXQWpyNHNNK3puT2txaksz?=
 =?utf-8?B?b2QzUjF0Vk8ydGlJbmNOTjZXT095Z1NBNXNCVDVKaG9rbEtzZ1p6ZllBT2dQ?=
 =?utf-8?B?RUtoUEFMV1daTzFwLzM0QUJrNGNhbmZxWXhqNGdCNVh3OGRNZEdWUHNXYUcx?=
 =?utf-8?B?U09WVkwzaUJCYjVpS2d4TEg2NG9XR1lYQll4eFFOMGdwK0pVaTR3YW9tUUR6?=
 =?utf-8?B?YjNzOWFjaXN3YTFydkdwOEFPMzFLeVVsd3hYUE5KTWdIYjJrWXh2cG9DWkJw?=
 =?utf-8?B?Uk93cFJuM3haMTh4SnVpZVYyZU1hUzZ3Y0E4cS95dGhkQlFjNW9Ia0pLcVBC?=
 =?utf-8?B?aFJIak5uSS90VEpsMmZxTzJvMlJVSzRsZDB1RVNEOFBNNzJaTTJzb0phY3Rt?=
 =?utf-8?B?cXBFdU5raml5QUxjWWNralRna1FudWllNVpwcUtUR3NCUGRMMzZ1RUphemFn?=
 =?utf-8?B?RW5uZGMzU1RYTnNVckd3ZXlOZjkwcDlRYUhMNmJxeFZMcFQ0dGRhczU4NkJ5?=
 =?utf-8?B?YXRGVldqbE50M2J6WGRBVUZzcHZvOUg5K2ZtNTVIdHBJQmlXdmJ2elNzdmhJ?=
 =?utf-8?B?Wk4wN05PbndxWlMxbkRwYmtmSXVHTy9vY2IxaXlkNlUrVEorKzV4YzlNSlpk?=
 =?utf-8?B?TUs5L1dxMWw5UUQ3NFc1Q2FCU01ybDUvS0ZkcHRZMEQva2d5eVFYSVp4S2cy?=
 =?utf-8?Q?WOQh1c553tmGKt+48L8PygT/32PKt137?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dlhpZThBekNBemlRYndOajRBT2RMc2YxU3UxRHBpd0hiRFZVRGo5RG9Ea0ZB?=
 =?utf-8?B?WmJlUXdjWUNBeFloU0Vob0FLbWNxamZIRytQd3FPUXVqUTh0NG1lcnFPbWNT?=
 =?utf-8?B?Z0lCZlp5QkYyOC96V2MrK1JlWEJ5UGhOMzhsK0RSNVhzbUpnMTlDZHAzTzdq?=
 =?utf-8?B?YU5uRWVzS3BNalpLeE9vamJOZ1FJZUJ4QWNNSXp6NGVqMW11UXQ4S2RGSjVL?=
 =?utf-8?B?eG5GSFkxa3graGpXWHRPMGYwNFhHRlNBQXJNc0gwTU0wdS9yUGZBRkltNU9z?=
 =?utf-8?B?V05oYVFNQmcraExtU0pVN1BqOXBYanBKTmZPVlhYWWF2WE5mSFNQL1NFek9x?=
 =?utf-8?B?aWVaU2VLZmpWTFZnMVNPYm84S2hkSUZRa1BBSVpOdWRlMUM2VnhKUzhuR3ph?=
 =?utf-8?B?bXQ5cFB0NCs1ODZlbGtyUDkwVW52VDE2TG5hODcyMVlKek5OS3lyNGZaUmhs?=
 =?utf-8?B?T3ViQXpLOVY3Mzhjd2VzQ1BLazRJM2o1SVAxNjloYU96OTluVUwyZTRwTURm?=
 =?utf-8?B?L2diK3BESFhTK3RkRVEyMTN2c1JTcTZBN1F6QjRSMWE2ZUJMMjQyWlYrZUxW?=
 =?utf-8?B?ZW14RzRiS2xsbjVqem9iSk9ZcmYvVGx3VnRkVDEzY28vbm9yS3U1ZUJ1OVhw?=
 =?utf-8?B?LzY3VG4vbHVrMHMrcVpMUVJ2S3VheWl4RWVGRUVNZWpwcVlVQ1RTT29yZU82?=
 =?utf-8?B?c0JaNGN2bUE1NXN3UkdRVUUwV1oxbFI3eitHQTJUSWlGMjl3TFNoY2NNRmxZ?=
 =?utf-8?B?VnlteVR0UDhRYmFtMk85MlduSXFmMkVOQTZBT1lSeFF1UVBHYmdXMy9mYURN?=
 =?utf-8?B?QmQrdTdudzB4U2ZGbHpWUFFlQ2V6eUpYK0tjZDE2OXdiMVNpRmlKLzhkeVpQ?=
 =?utf-8?B?OWkwbk1sbHZVcVhmTjJmN2NmNzNveDV6QWJmM2IveXF1VnFLTmVwQ1grMUV1?=
 =?utf-8?B?clJIdDM5TGJqSzNBY3VnZCtsY2JTY1I5RkEvTWMzTXkyUzkxRkM2SFVaakF1?=
 =?utf-8?B?ZXVDZzJsb3hIVm1YRy9yaWhkcUxKcjFZK085ZFBqUFROK0ozTC9MUFBnWjlr?=
 =?utf-8?B?TU05cTJxelYwZWFmbmU1SW42N29UN2w2K2hNdllxOVJ3UVZPUXRNckR1KzZn?=
 =?utf-8?B?K21aQmh0V1NySjZ3alpDNTJ3QXZFWE11ckJyM3RiZFJWSGxwYUZ6cGE4ejNt?=
 =?utf-8?B?ckw3TnZNN3VGVmovTVoycXdjanFhMnFsYklCZ0x5VkpKLzg3V09JYTBqaHA0?=
 =?utf-8?B?RkxteExzZEZRMWJUclBnNUZUVEY0aXdOeE0vbU9jUTNURWF2WG9WMTdsU1hZ?=
 =?utf-8?B?anY5MVhKM3BuQ1RUVHRheXpGZnBTZ2hWdHBncGhsUzIzbFplS0tiT3lmbk1z?=
 =?utf-8?B?bXBLeUhlekFOT1J5TGdaSktJalI2d2ZMQlZSNE96M2VpbGRYbDVLOEJVWnp3?=
 =?utf-8?B?WWU2c1ZxbnQ0cDJNeFJPUnpGcm9UV2VTMEg0OGNrMk9KenNzK0tPcVlGZWdP?=
 =?utf-8?B?QStmdFU2cDdpckpCN2pqRHByTVU5Rks5OFp0aVdiR1RTME1PYUFoUjlsYVZU?=
 =?utf-8?B?Mmh2ZGxpNFY1dDV1VldsVmhpVXdobUlxY0VnVVA0TXdQb2IwazZETWliZmRx?=
 =?utf-8?B?ay95YU9sMXl5TFlnTnlwQ3FKQTloRnhvWGh6M1M4U1M5WWFHTUpOdXloK3RQ?=
 =?utf-8?B?b09HMnlnNWdXcjlKcm1sMTZsbDI2Mm9vb2hwTU9vTFdKdzBvNHMzTjlxWG5S?=
 =?utf-8?B?VGRnYmlEeGwxRU9lbnRNRVVISTRtbXM1b21RdEJsUCtOSG1iOGxlUkkxQ2M2?=
 =?utf-8?B?aW1qUTdrbUZHa0JROURmd3pJNENDbVdxM3grN3B5ZmJHUjRreUgreHJUOTRk?=
 =?utf-8?B?bjl1aEJuYnlWRmRMRTVIeHVCZGswdkIvLzhJYnh5clAwK084QkFUWWpQQW1C?=
 =?utf-8?B?d2F1MXJBZC9ub3l4MFF3OUFZYzRCQ1lKdXFyMG4yQjVleEJDc0ZKQVZvdTBw?=
 =?utf-8?B?TUx4MXRiWVE4dzVJMmVyM0FjdVpKOWZmbmgwQzZRQ3pnSzEvUjZOTjQxazRV?=
 =?utf-8?B?NHg5MjlRSjJYZUd4Q0xLZnkxQ1k0aUxTY2F1Z1RZb2tRa2I1S25TbW9IQVEw?=
 =?utf-8?B?T3d6dDVCbmwxZTF1VGNpRk9jRmlCQVdqNW53NDF3NmFsb0tDUnZMb2piaFBh?=
 =?utf-8?Q?0gldUZCaFbCy7fYKI+LhtuBL6NeWBrrwxlTEJFlwttVL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53dda686-3573-471c-6e2e-08de3dace655
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 20:43:14.4123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hOQJlrT2suQ+9RJ/1QtrcopS07dt3SzaAJ11UJcWBgt0aLKY8IzI5vrFWaHDhHttK5ddkGS8z+OwJAfst1O2sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9341



On 15/12/2025 06:48, Ashish Mhetre wrote:
> Add device tree support to the CMDQV driver to enable usage on Tegra264
> SoCs. The implementation parses the nvidia,cmdqv phandle from the SMMU
> device tree node to associate each SMMU with its corresponding CMDQV
> instance based on compatible string.
> 
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
> ---
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 32 +++++++++++++++++++++
>   1 file changed, 32 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index dad3c0cb800b..0cd0013200f3 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -4530,6 +4530,35 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
>   	return 0;
>   }
>   
> +#ifdef CONFIG_TEGRA241_CMDQV
> +static void tegra_cmdqv_dt_probe(struct device_node *smmu_node,
> +				 struct arm_smmu_device *smmu)
> +{
> +	struct platform_device *pdev;
> +	struct device_node *np;
> +
> +	np = of_parse_phandle(smmu_node, "nvidia,cmdqv", 0);
> +	if (!np)
> +		return;
> +
> +	/* Tegra241 CMDQV driver is responsible for put_device() */
> +	pdev = of_find_device_by_node(np);
> +	of_node_put(np);
> +	if (!pdev)
> +		return;
> +
> +	smmu->impl_dev = &pdev->dev;
> +	smmu->options |= ARM_SMMU_OPT_TEGRA241_CMDQV;
> +	dev_info(smmu->dev, "found companion CMDQV device: %s\n",
> +		 dev_name(smmu->impl_dev));

This seems a bit noisy. dev_dbg?

> +}
> +#else
> +static void tegra_cmdqv_dt_probe(struct device_node *smmu_node,
> +				 struct arm_smmu_device *smmu)
> +{
> +}
> +#endif
> +
>   #ifdef CONFIG_ACPI
>   #ifdef CONFIG_TEGRA241_CMDQV
>   static void acpi_smmu_dsdt_probe_tegra241_cmdqv(struct acpi_iort_node *node,
> @@ -4635,6 +4664,9 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev,
>   	if (of_dma_is_coherent(dev->of_node))
>   		smmu->features |= ARM_SMMU_FEAT_COHERENCY;
>   
> +	if (of_device_is_compatible(dev->of_node, "nvidia,tegra264-smmu"))
> +		tegra_cmdqv_dt_probe(dev->of_node, smmu);
> +
>   	return ret;
>   }
>   

-- 
nvpublic

