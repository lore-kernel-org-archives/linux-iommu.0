Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFF6208221
	for <iommu@lists.linux.dev>; Wed, 16 Oct 2024 12:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729081391; cv=fail; b=h7ywVlYnCHHP6yRfmQbtm/nhlT6Wyc61Nmy9w7DpPrnriSMaOxyIaezqprxrEXBjrIVIXpCk4ncyJWe3Kw991ksGbI4AJnvBaq6bGjIWk1IGPnXTA8GmR+hi//1Q9ROWbmpsVIyBsNMpUd3v1czyqpkqFC0OtQxkCPLT2uouYP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729081391; c=relaxed/simple;
	bh=B7AEcF2C7LTLssCIpnPcIKAFO72AjTEEQQrK4ZdMxm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MaAQ4KEDMdy7/F8aN75TyVXWVDKp+Af6DXvPASGT+UeqXyNNsvvEu0yd4iTA85R06jSp5KomJ9CLXoDWiGXiSWmMtlA3jP64W/pklzrH2AzvsPaqOFcXt6nrY41HArpI2OUU/LB9ni0eIed0dcDJrYPQjw/vgM5DNFmlzYpNbcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=n1oxXf5n; arc=fail smtp.client-ip=40.107.223.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="n1oxXf5n"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lzr2a1t6+KqcN2MCcZhWwiakVll7KjFZ8JxrphvFrGtj86gB+7cyQIjpqDOyBAaNOv9PF+q2OeV6Jb3icS/5oi14BlXsu7WKvz/n+MMQ5hetAE8LLriEACqXF5CF3wry/XNK8p2ccKBnnY8+MAZyNrrSZIaDR/FHfRFB64wOF325wMKrlD6aGFUk36oUUFsn0p2vWxw9LDCnWebgmAmy/yDn5Zv7lIm300VO3u2nAi9PfKTT4oVi5JVffED2REkwXN9XVeWXlRy8f740TdNRmBD3L1cERgDsiYzoYrzg7UgY3hOPVr+KBJt/37wQN12Zqz6hEVcuUaQTP2H3plD4dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=feLpitFlcC0RwRDmbRNPh04wky1MDhNZG5Pq91nSoQI=;
 b=UFnX2aFoAMMIkdImS6Bw2Exdot3I/zHWGJQn1wwb5ZaCYcx8/MbabaH06ACrdoECK+/ZZ1nl8xQOfDEenrJA0VLqgt9Q2gEgzk5EPEM42n1P0dThiH5jp3BZL9V68KXzatr5vk2g5xnHboyMESS7WCOluD+qCHUqCfS4pmODo2CJeQhYYg8S0hLZtvphi4urjgPHosqAxEDIzC5yzQ1CkZ/K9FcfsYu6Dz0LpiOw4rhh7nh2O1i1aVbpzTt8x5srgUrTD+UtpDmmWmXLbYbqmhzNtA9f7iLkRXT4sPQey2XYaoH4fYn1ZoCJS0VATNfJa9AK9xTw5XWUGW3vXmtMMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=feLpitFlcC0RwRDmbRNPh04wky1MDhNZG5Pq91nSoQI=;
 b=n1oxXf5nqX2G5wdKXOml8dxiAV9HgPrBegmgcCJ4hJyXovW0XKR+tz4lfVG86uTMK5qTLNlR6CWX88qXKL46twaSa6bzNHulUDo0e/JqvjJZqWhkZANO/rYT3wQNLvhom6H2BOolzQy0M8tdT9lOOPzwwZreCNYqCSbAY065CyTGxCJ6srPx88e0yM4b7mL6zunQB53EFvt4m5zMNAWzcLYH2gCxTDoLQGR7kt09DKp0Gkzr8p+zo3tvIBUIUp0F3ANEEZj2p7P36RhB7AXnyKyGDadRtTzad9QELpP8hhzDHVLe4EXoi8ziuW+GRQzEzCkgAnSYmq1Fub8o+Rvo/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 16 Oct
 2024 12:23:06 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 12:23:06 +0000
Date: Wed, 16 Oct 2024 09:23:04 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH V3 0/9] iommu_ioas_map_file
Message-ID: <20241016122304.GE3559746@nvidia.com>
References: <1728067700-32092-1-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1728067700-32092-1-git-send-email-steven.sistare@oracle.com>
X-ClientProxiedBy: BL0PR0102CA0021.prod.exchangelabs.com
 (2603:10b6:207:18::34) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MN0PR12MB6101:EE_
X-MS-Office365-Filtering-Correlation-Id: 4094d5de-a750-4920-4fc8-08dceddd494f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VSCCBKSw4TU3s699JumxOS4QLGMB2jWASUqBEmYtxUA4UHRFT7rMNVNAh/dt?=
 =?us-ascii?Q?JxYM3AwW7hT7mrY7CmAOyiZX7TLf40kQivOcEf6OVEVjx7JNfhTLWciG5j2v?=
 =?us-ascii?Q?rjQq2GTAXTGdY9bsZDn9REGQ60Z4nnamW60PqYKM+LqnSamEmL4P7NbPkaUV?=
 =?us-ascii?Q?K+Vvv5Db3syoWvFE7sxt50PyzCsJ4TPPp7AqeO9cS09boFoE+RlcHG1flxdx?=
 =?us-ascii?Q?/6OLoApjiTrBxyGQy8mQnKeUuxvTUHtpnJvR2ppH9qn7VoTyaAM7mvOpc0xB?=
 =?us-ascii?Q?tqRb/pf0JcbgqimjWQMsRvLCJq/plTiCkRyJMRaD2GpR6gq7PwDKCl+8AlSG?=
 =?us-ascii?Q?6/LaD8PqBbSxyCSuOkUKdwJuPHY51CiRJ6jzlj5pxuYoO/Uc1Nucm6GiGekv?=
 =?us-ascii?Q?YqXa2+tLYyR5gn9ZyHWamuIWSBDotSeAzGIkg43mVnZetzFP+Yx0JJA6u/si?=
 =?us-ascii?Q?ER8E8DBEybTt6a6Ril7eZvrg0oFFmIBlTwi6oPp+IccbytK0LHkFSmI0/4vi?=
 =?us-ascii?Q?ZU+OfwgNPnJNVzJS8NWUVRmzAJLyw4UGspaj08s+dEewBsc/KlYOTxbQyn5+?=
 =?us-ascii?Q?qcK/UwBLKh3gD7cBgeY/VtXjLLeYCHzB2otEr+0X4gjgPJzojkSO6Y8NDy9h?=
 =?us-ascii?Q?Qbt720cJmSvC6Z+O6JDdZei4v+o4Ro6jAlTpkn7L5zKjZ1LGx0GOn/oeLVIk?=
 =?us-ascii?Q?M0g3MK3l1Vh5KLs+OgiING+SnAXGIYzzUdTK6FvuPBR3XtKAVFSTUOLIJmQB?=
 =?us-ascii?Q?IqtRPe2XwTm2rSDj+7qVaE8cq+S6NWz0xghF6BeMzHMzyDD19viow9yH9KNY?=
 =?us-ascii?Q?fRQzntLkZ03Bvasl2HxsPQbQfued2Djb/Htw43VaPAKRwugGG7GHkhvtwu7+?=
 =?us-ascii?Q?LOHTBhmtPs78XhJAf+F0vLuLPPJlP5y8bDWMfOlRToaQIF41hyEDYK+ornN3?=
 =?us-ascii?Q?WCDNepVPqkG7f0tjedXuaB34OaEcK5FyJUG5Umrjv0J76AAjuwLvWcHy/M19?=
 =?us-ascii?Q?uukAnHUokcPr0l8duv7eTmLlTt3uV4dmT0s2/7zlL8iTet00sYRxWY55czaJ?=
 =?us-ascii?Q?YeFm56ZalbN23NwJr2+PWbItVAP6CBA+DDp7bznxNZmG38QXrii7a1kx/Q0T?=
 =?us-ascii?Q?hu/CAC93tVf71cKVI63PGaITczyvg84+rBwhr49qj7Bu0qX/0ZGtoJzKbVyX?=
 =?us-ascii?Q?R8a+YOuHOpENsHNc9EoCnW93v+jDhvSXFAbTI4DmoUU1Iu46PNC05x5HcFxs?=
 =?us-ascii?Q?lPidZd9JihlWABJLk8/PG4S6Tju8HYwQa5qgIB2uhg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?m3PHTbtysCuia74msLkCoVYwkjmz9Uqt/XFm454MXqrU+RKlhnHJXTd2iuA9?=
 =?us-ascii?Q?HMxVINdqM9sG4593Hmjg7xA4BUnV4l9fseTwyWxQtWF3EZ7xz99xrAhDD+dG?=
 =?us-ascii?Q?MVfv6fjI/9UXzynMlkreJR9XAhjv09xdCvaDZuXwmmUo7hekSw2PFKeoh6CS?=
 =?us-ascii?Q?LxFGf3NkMPWuNN2+hapjZnqaZaLU6BumnCpoWvrP1XyaYh3HNzsmjv8Pxy9X?=
 =?us-ascii?Q?akwnBQ0NGSRYGN/Omwo2F0GgM9YN5pDXZqYrgFhlypSXUO/FlWSt2p/m23+z?=
 =?us-ascii?Q?+OJ9xBw3UgGsqRE3kPk7Yt2ysswSv5UJG/7BeCMiaBAxMW7EeGAHFJoDDGRt?=
 =?us-ascii?Q?j9l/DVnIYyfN2CvwJMKex7amG6FQ24E5eu7AKJWbm09xoUdyxcIh9OvMoLQy?=
 =?us-ascii?Q?cqJZ3JHuuSDEWcmpirlFzSEbqRodR2x6zIF96OkN+cXp0mv9xe20eQ7TE/hO?=
 =?us-ascii?Q?avgbdxmYu+75tB3PUns64dqWg6UN+b8a+efYz4IXKkPObt7HP+hwpEFUIY/A?=
 =?us-ascii?Q?0pg6PCqbg0E1kqFbCapIVIHg14wkngMbAIoyzSO3I9CFNz/u3ls7hjgXN5rC?=
 =?us-ascii?Q?s/piD3nc4JzY2SLBJbED5G+S/KgW0xQzY5OD0KzGmi0s98xvtWeJuvL1a04P?=
 =?us-ascii?Q?s2GkQnkWJYmy+NMI633mffv1t2DLbXrlsIH8f1M3BlpDp57XKrcva5dSw2I+?=
 =?us-ascii?Q?zGCrg/q9ZKdIr0mZBD2ea5O848vDdkhY4xjXJgurbmbSYGcenoVM354HjOGs?=
 =?us-ascii?Q?PQKJEPx59CDhC9A/8XZ62ZfJwYjli3MajE7B7Qkajl6D+DBaHV0kVO7YnW5l?=
 =?us-ascii?Q?0oxbESDO6Bpy4zx1WIHpdQW6tNBd/s3LDKgcqp9JpQRgyYUNId8LAEeDcnBZ?=
 =?us-ascii?Q?w8OaGXUFw9jwEhhMWepHG3AEBQ+Oq1Tx1OGhoYXhWClB8clDjeU7WhPhkn4E?=
 =?us-ascii?Q?nE2zixwOjxv2QBMlspD+zr3jxWWp1c9xSmpUno9l/IhD5Uqid9Vs1b4E7TRi?=
 =?us-ascii?Q?OHT4ExLlMqX6msFlhoCAF9awlhREoaLimy/5u+zQdt1tO7FQ8JNSNJpXrgOl?=
 =?us-ascii?Q?YfftJlMf6Zz0z0GFrCMxi6vYv/Cr8NsFAz4ZFxGAHeu6kOPegS0x6SE6cil+?=
 =?us-ascii?Q?H1KtMKUTdHoC5DGfpWAjMvY3Qec8WWR6z1gBnN7iXmlTws65Qd8ufj9AE6Kh?=
 =?us-ascii?Q?WQxYqbN6za0ZFtSmzoHnv17AUxFOBj1xUQESFfp/hoAX63YDLNuVgJIaPy3x?=
 =?us-ascii?Q?I9d5RnZrepRHcPnYmf9PBpt9FuFZFkaxBT4shKz1ePLPsGkwoLE6KrKlZwGl?=
 =?us-ascii?Q?QVpPFNpuOVrOzewk5v+XmYT0IPeaDA3yWdQBi2NcYSXNaLgtucA5m6r9aP9P?=
 =?us-ascii?Q?jdQvT+UEzQNmcyTT2n0bLX4u0HKozd9EUa9I7h+mneS9pa1gMK1lm+3TMJxX?=
 =?us-ascii?Q?aDj+sWKpkxuS/BMgA4Mx9Pmt8V287R/ivOcaU/FVgRuJrmHcVzWGjlYLjfMj?=
 =?us-ascii?Q?v+M0+jA/pZs0VxehaJT3YYfRMbSocz1PjqIcEIhCi2P7uHo2R9Wv09k3uhT5?=
 =?us-ascii?Q?uBeDOThIj+l4V7DVCQw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4094d5de-a750-4920-4fc8-08dceddd494f
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 12:23:05.8347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DTdwv8fz0DdOL/D0ILNKyyT9en795Yz1xcgPri3lBQABYarKyJO3Hydfy2BRiUY1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6101

On Fri, Oct 04, 2024 at 11:48:11AM -0700, Steve Sistare wrote:
> Provide the IOMMU_IOAS_MAP_FILE ioctl, which allows a user to register
> memory by passing a memfd plus offset and length.  Implement it using
> the memfd_map_folios KAPI, and the proposed folio_add_pins KAPI.
> See the individual patches for details.
> 
> Changes in V2:
>  * changed names and commit message in "rename uptr in iopt_alloc_iova"
>  * normalized comments describing the iopt_map_user_pages interface
>  * submitted folio_split_user_page_pin (fka folio_repin_unhugely) separately
>  * replaced nupages[] optimization with folio-to-batch optimization
>  * added selftests for map file
> 
> Changes in V3:
>   * fixed bug setting user->locked
>   * fixed bug in pages->file refs
>   * replaced lockdep_off with down_write_nest_lock
>   * added ufolios_next to track folio consumption in reader
>   * combined IOMMU_IOAS_MAP_FILE interface and implementation
>   * added patch folio_add_pins (fka folio_split_user_page_pin )
>   * reformatted patches using clang-format
>   * misc cosmetic changes in response to review comments
> 
> Steve Sistare (9):
>   mm/gup: folio_add_pins
>   iommufd: rename uptr in iopt_alloc_iova
>   iommufd: generalize iopt_pages address
>   iommufd: pfn reader for file mappings
>   iommufd: IOMMU_IOAS_MAP_FILE
>   iommufd: file mappings for mdev
>   iommufd: pfn reader local variables
>   iommufd: optimize file mapping
>   iommufd: map file selftest

This doesn't apply, you need to base it on a clean rc release before
sending it..

Jason
