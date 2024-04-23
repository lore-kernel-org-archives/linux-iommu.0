Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A6E5103D
	for <iommu@lists.linux.dev>; Tue, 23 Apr 2024 14:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713883965; cv=fail; b=bA+yNhHO10xP9s5YqAV4pB9hi7FZVKAryipPf+9uE/VVnpU4Xif185qx3QJoQgDmHeknHvKiYFy1ml8QlchgO1mlT67zNK7IKenij5uRbUpgc5iynydb+992cef/bGi3D8TEwmu9yuMsFEeN+qHeAIk2URlzXIUFT2jcr98dNzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713883965; c=relaxed/simple;
	bh=RwoRAZaVdtWqFqfHW/ERFPq/btW7USfxVZwbIMhaXW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pw4TW12Ja/jSjVHQaa3ULOrsaYN7P4vFOZ2HL1hxwjWfFa/0BuZ8JraVjh9UvOdbT7JmdEh9+QW8xUUTLX6rHPzdlI6MGQle4Wtzkt60OoYR12bA8iQKPbVOFeL7lpL+g/L1KP6RVPcQ4VlwZnrqNmr68vbf4WcXFdUGhL7HXRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dUQC7KaF; arc=fail smtp.client-ip=40.107.244.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dUQC7KaF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LoVT7ziNxNkOsz5SCKfMHJkr+2U6NpLY/HR2zYfmuEgV9wiH+t0wuTAg+dXPGASxTcrCCrMI1LTNPXYCt9m0ph6kHDvN9sOjKdSGAYoKzoSvuXBm4aSBwGyI9p7tuGow3kBUUiJbo2AUSlW2uIpjk8JWm+Y02yeU5J8QxQUshxdMbedQDSWnlSAwfR5+qGsKz+0kgsNj3LHbd8tH9lHRPFjkqHPRfN5YWO4amT9EVG0Uj+PmxGh+DXsc+d+XUk+Vq/yUvUR9bCK9tlVVQb9AlHEQBYWfMevfrXfCEvRjq84E5DdM3+r1Gq75uSzVdlKWVG2q6Y4HpITsSPklauzfcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7dSJIXSYowpsNtp/XXu9RYhXW8Hi/bADjzPAb6shW/g=;
 b=D/eGhOkwlpGX079qF4DbzsfQ8ocjrlt1xfRXmWcOYyE7Zsyf7GJU7EtTuqzaE7s5oDnXrnI+Z/hWrQ7fQ7K179YyFXP2vlzzfqpSPOhUrOhHaCdw+fisdPcfZig8abIexnQW2jx0iTE/E1AHIVlr9E/q5pmsmf/JXn8jFJzI1s+xew+Qq1KGaKiZngyRTiZPxQGemNrYNKJ7u9BQWugRfYCYIH/1mKilDqePKrgIPIg9I/yIoW0jfSsnJPJlfKKBlKdXsYTx7oyBdAHY4VJa8ghdvVXfHkwslLiN2SPbnlAJZEHUk14XP/Gxsaj5B2Q7Ts+uwb6ibilHD3WYmi+9gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7dSJIXSYowpsNtp/XXu9RYhXW8Hi/bADjzPAb6shW/g=;
 b=dUQC7KaF1xDgrE/61AYP6E8QVXxy6wMKJThSlMk/XzTNzRvWrYRHDB6NFeDlkJH5AtNa/GKgqVvkQI0T20/vlptY7FWPO+sIfokjWn/pO1a530UIwBL/GsbdT683TxjPIbQNbBkr290K2W2S9lbMKFMm7VbeZi1RdfMsXi4knCRMi/QC5r2aN/irWX1BsKq8u5CvYyK88UieL0V4z4HvNDDC2NWox/zq3rEeR1dnYn8USW3MxZazvcDLCV0PhrbWkgXvtpxOmyLj4ruNEIoWr0Z2qGdl+jhllsea6YlX+SOQU3hEionJHAGLhVoIljHbKaMYhtXRj3mfKtmgTbBzZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by IA1PR12MB6603.namprd12.prod.outlook.com (2603:10b6:208:3a1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 14:52:39 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%3]) with mapi id 15.20.7519.021; Tue, 23 Apr 2024
 14:52:39 +0000
Date: Tue, 23 Apr 2024 11:52:37 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	joro@8bytes.org, kevin.tian@intel.com, nicolinc@nvidia.com,
	mshavit@google.com, robin.murphy@arm.com, will@kernel.org,
	joao.m.martins@oracle.com, jiangkunkun@huawei.com,
	zhukeqian1@huawei.com, linuxarm@huawei.com
Subject: Re: [PATCH v2 1/4] iommu/arm-smmu-v3: Add feature detection for HTTU
Message-ID: <20240423145237.GD772409@nvidia.com>
References: <20240222094923.33104-1-shameerali.kolothum.thodi@huawei.com>
 <20240222094923.33104-2-shameerali.kolothum.thodi@huawei.com>
 <3733929c-657e-4d24-b5e9-a5d946645abe@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3733929c-657e-4d24-b5e9-a5d946645abe@arm.com>
X-ClientProxiedBy: DS7PR03CA0310.namprd03.prod.outlook.com (2603:10b6:8:2b::9)
 To DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|IA1PR12MB6603:EE_
X-MS-Office365-Filtering-Correlation-Id: 3211e79e-44d3-4be0-1d22-08dc63a50544
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CwCfRNRejDDDU7PemnSEzsNoEMk3HBm8NH/NVTCwj+6aZfQ/MQ/s5kIbcjw+?=
 =?us-ascii?Q?96OBcVmY7keYYH2ZRbreoIOgZ15/wUYu+pxgrzBHGZ1sLOXF0lE4WU91Htrz?=
 =?us-ascii?Q?294Otn9EePhSMypw+Q+2qZJzA34q9hRVaqUR57IajyeQEXbCQJWUoz6/9sWB?=
 =?us-ascii?Q?fB9YY9PVhnxGBPrXACZ4+4zTwAoun8au0t40uYKWluTz3hBYG+j6BtkmWERw?=
 =?us-ascii?Q?9UDSQf2wgyIQF0hAv7Bq1HVft7p51h+NRKUSw5CKGRNpYwnI0G1LwPG1yDGN?=
 =?us-ascii?Q?lwZ99Aug9oaSXwYkbWc4qcyoSVnSY/RArka+q0ddv0xi79gRAtiw4AikSuaO?=
 =?us-ascii?Q?NwPAcuj6My3Mk1V0Y5sntlatchEIjbV3I0IhPWv6ChXRFr/xsvzivQg7J9Yj?=
 =?us-ascii?Q?zsc+4+MEAwj9aY8WVqk0QZfD6UEX0h0bnIFVfOXyvKI4HYCBW+3j0e9ebAA3?=
 =?us-ascii?Q?ILDfQacGzY7Zr9UT4wDaNxoqt8yTqFI/5WIpvySHIDZbc8p0fYLgO2/rfr+f?=
 =?us-ascii?Q?BsFDDsOIbJXV6YuXI9Q+jJ5fkgWpF34qCFjlBFQohHwlwG4m/bncrMlrHjLo?=
 =?us-ascii?Q?VVT2NRusQcT2K4rR8SGnycqZMrVpF6wo4zIkONp+t1Q9+VqLmXlToFU8qV3Y?=
 =?us-ascii?Q?7ocP3GzYj2xBV6l9zQds8Zljse3u7ItUdk0A/ZXsJydWSVGvvEoVs7A26Uas?=
 =?us-ascii?Q?YIV5hRLZ2TdmlhyzMDObfyX5sVLlwAJTEXJtBpb5heg+MVLrgpuUBUULgR+x?=
 =?us-ascii?Q?sCe5ZWr+2/UplXNFP1Ca64scXKeRi2jbDFTqeKVvHkTxkFdcXOuPrbJXCeQ9?=
 =?us-ascii?Q?gTXGYl1e1pSwCvLosSswT0PJw71oPOeffZU5UQDgmVTuPOthLvnedSCj1vCc?=
 =?us-ascii?Q?q2RhIwyrb+xPEfCDr42IQTAkF5hkC2VDeI/Knpfcsuthm9p/sGh9L14208A0?=
 =?us-ascii?Q?1FhMAS5LRgZ/hFLgn0q5GSGItvXf1iUQTE4IhpyVVvqNggODH6ZMJ1iOT0VY?=
 =?us-ascii?Q?avfJQvxVEPQ1IYOF+uoDdqtJ9KG74otibt6JodpvTdUi+O8+Xuv0Sniqifzo?=
 =?us-ascii?Q?/Icoq0J9Ye5HodpM0gvPkUK8NdrnavwW2DkjdLagHIMxT5TodI+x05YjpNyo?=
 =?us-ascii?Q?RLQlv+vGr/KOCFhqeKMuv5nbNZnT8L7Not9k1PQgfPBBZ013Ft7VA4bBiKwH?=
 =?us-ascii?Q?Inu2Yf/j6sVGvFI8qy2glDPQSHykUQxDqrQ/hfOq6Zvf4AlS6xAz0IHzpczj?=
 =?us-ascii?Q?+aStCW2afP8Y16JrHA0+kyvrU8RThNKoa5EmubCjeA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wMfzb3i7mf1mJsn0aQ6eSDhuky0cSwBX0Dny1gwJDitK1xY5zq+6U7j7acPi?=
 =?us-ascii?Q?20BP7CchVNGSbVkpvFXCm2KVF4ziFQaLe4VnL+R63IGCdL1fkc8v4sYkqtO0?=
 =?us-ascii?Q?6Wsm7U7SncgzH4kEDsdugW4KfWGdwGx4SmovPayKj8n+K+Qi2Gz1Dde93OqN?=
 =?us-ascii?Q?Ywlodsp+zdQwUXAV4pnFhKAVxKSFGz+CUayazC/ZGkxTJ2+SXXZbjoNiwqAk?=
 =?us-ascii?Q?TIpXesDRwnu4Sr/93ZlR1ZhFhUFhtoKTIWov57wYqEuBiv6JxmfqJfI5th+h?=
 =?us-ascii?Q?Dx0ctNKn008lnifWLhjdCKp6IbbxUys0FfcSSyDdx2DXi9Gffqo3PpunYs6r?=
 =?us-ascii?Q?n8U4CUHiTvOMgkRiNi+mFLHm+VEaRZn436puzm6XVpdDsp6vW3/gobvlUdjV?=
 =?us-ascii?Q?djgLVFLghO1NobIod23nsaDX2ViJx9gmmU3YqMHz0faO9btiT8Nc4AaGb8jY?=
 =?us-ascii?Q?JS3YhfLVbhHayTAgZnOyHF8Q1S0r6041yYPpJKHPPKkLUzSYizR1TejbawFP?=
 =?us-ascii?Q?al5T3yGYkU1TKrfLANNqKmL9whTrsjVcX5if69EWnivA1vNGzs2BXeUIDXdG?=
 =?us-ascii?Q?PiD9ix31BL96S4k/ehZGiOKiyefK30gwKum34gHrWgTbsDl2Q6Uw1fs0OV2d?=
 =?us-ascii?Q?/Hyjw64ytYF4l1EvWiBxPaYHTDr0yfiYCmy9gA/qL9Pf+UmjVEP/FavHBkYw?=
 =?us-ascii?Q?Y6c2cuDpBQxyEkQFU7CbNZJgmC4GUJi9hnAaf93KlmkaaRvtX0nDVM//vrG7?=
 =?us-ascii?Q?hthbcUttX3jvDQ66+SlxQna3zASPbFYdiUJkJHXjZpdu+RGn/i7Tb2LzOhLF?=
 =?us-ascii?Q?qci5Tl5QUvQwsjKxALBhMEWQPY3J3b49t/NqCqlymDZvX1qK+BJPL3lHN9P0?=
 =?us-ascii?Q?yI9/aSHclQ23eYXdEyQW8piRcCP5b+fJ3ZFMjk2dzNgahOmzc7USNK+wblKo?=
 =?us-ascii?Q?njVsaJdd1V1kJF3Hx9gDbTaiut8XhS/t0xU+p/1/UoBMyPgYqkCeND8g0wQb?=
 =?us-ascii?Q?vwQaWEoBdP/nWnimhizgYTeRBPvlJhpzf+k2blK9gdkitEzS9FNKCYoU4cTX?=
 =?us-ascii?Q?R+3N+1oqNeQi4nW9FSXopsPlrmRFnv3kK4GS+p2XKF5kqPSZY1YEZGLURTyN?=
 =?us-ascii?Q?qsxu8BbF/L88OR6Nw5uX37CJGtPkNPHwf1VVGL2wiGXViSt2caI/g9kSlSDR?=
 =?us-ascii?Q?A8/Xkjz7kvSR3bniMAc0+rjCzTlFw8WLPUtuhjF/erVAHLmUhibd+zHDUlOY?=
 =?us-ascii?Q?i/8pdTbzPuDp8PkSJTyHLjBF76kxV39YTSG+m/iMkfwLYGZQ8/6VN2RusRWP?=
 =?us-ascii?Q?BK6tOklBxRAh6MT6D9HaEPF2YbtWaehTK8zchEUKTTez2WORoi9VV+y2Qg5w?=
 =?us-ascii?Q?DiMeA6H2vs7ISvw1flxnbGvMy/PCesc5Cpe3UcWa7RsWrimUGjzXiK/zaRHq?=
 =?us-ascii?Q?UloJEokjxaVM0gH126f4ZE9IfwlbFSWFarOupU8qz0cdte6PtRViIz56ud1v?=
 =?us-ascii?Q?SbwLe29GQs8SfN+e0PgblN5fmQxkgTSbpwiCr+DXZVimcUb7K7e6T53ke0W2?=
 =?us-ascii?Q?PRrDP5w3HGCeX9KkNCw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3211e79e-44d3-4be0-1d22-08dc63a50544
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 14:52:39.0861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z788GdilZKQi/IeCbk29HNciMYeXS2wV0nVisqX0LVTg3MyPYqrR46JvGzD0ZnjM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6603

On Tue, Apr 23, 2024 at 03:41:30PM +0100, Ryan Roberts wrote:
> Hi,
> 
> I'm aiming to (slowly) get more involved with SMMU activities, although I'm sure
> it will take a while to get up to speed and provide useful input. It was
> suggested that this series would be a useful starting point to dip my toe in.
> Please bear with me while I ask stupid questions...

Nice!

I would like to see this merged as it was part of the original three
implementations for iommufd dirty tracking. The other two have been
merged for a long time now..

Jason
