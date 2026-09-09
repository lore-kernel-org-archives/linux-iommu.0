Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011033.outbound.protection.outlook.com [40.107.208.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E11A584944
	for <iommu@lists.linux.dev>; Wed,  9 Sep 2026 16:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788972080; cv=fail; b=Cbkw0/6mb1pCDnF/Vv3RO9dCFooehsNE22rOt8QPETROQrIVv1H+rtYnAWL2TyzYVMX7Wci4Pi34Ry8zco8XDlBhuaMiDRvof45A7mck7cHmMTrHUqrJ56fxMJ9Kj1uk7QRqtc3Cpx5/WItRWObkdeJr06D9rSh/bNX07s8Mo+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788972080; c=relaxed/simple;
	bh=2MIrqbUAW4Tjnfp0o91IFCovJEZCkHwf5hO8+2ObBh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VrYzNxPtLRlG5Wn5WiUtl2h24p6jQuW2zvzj4NzYYmqSOW4QBpp9CVWsrAobe2zm4w1vDlASvXvHtTeoxRSCeuc4a7JBoocSp0RlyUG0PuF2YoVuMdOBNBnxArzAqQO6bMx1ZlKWb6w3oM9vj/etSv0Gray+TITxFJ4hc6b+GjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ivozuRCy; arc=fail smtp.client-ip=40.107.208.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ivozuRCy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S84d8bUnBuKy1KbV88koIls5XwJmGCj55Od7KTHnJockNZXH19kphMb+XYpdq49VJYWfub4dj5smm8ZKgTo/J+uMvzr2qZisApLteojaA97G4vi2/OFbr4FQ+EK0THUCi5Y5nETMMu5z3Ugdwvc+fCX4CNfkELM5UmYxOEjMbuLNwOSfRxMf7fS0MCTUorMpyfPLzuh6b9RG3+mMrGJHqbbzYu32/OAJp+Vf6hyxRupOTHiuWgTPhoONl78f4+clrKbMOXSmQi46okjiYtRVQRvcoj05qD/0Qea6kgoX3eNndW4mVul4205IoUCodS76uEoj0XsCwdyQXcoDKQ27Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IoAK0wukU4A8hNIjRWi6wD/ypMPEkJdNInGE7CV+WAo=;
 b=wUNq+ASszrb9brUChmyQ40uEBRcpEiMNQEwUoyUdF8OGKZ0sNBSyGpQCC6GFRMRwcgGN4NqBOih2mxw9NzG4tDEsrV6L4te1k0Wi/o/qSqNW05NGIlNyyZhn9+PA7/oNq3WP7BuWafseHvsN/fMlF2TUFdsoeL0n7V5xLX988apmnIsbHJiU4srrKgnkKXeStsPl12YMYpzzX+L32HnO7I/EAcpXw8DeOjT+R1Jp3kVLbq2BxCNI5g3LBH9rElf7vKH3bNqTgkUW6/HxKiJmIxndT4kGHp3mowk571176lm0ylh5vEmYevEsauwmAZ3OGA7Q/HUEYXN21IhRKyfvgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IoAK0wukU4A8hNIjRWi6wD/ypMPEkJdNInGE7CV+WAo=;
 b=ivozuRCyADIQGpLyXxvMMoZlVwUMnZRFu9HZA0MU0ONekeqkIA9QEUt28Tw1tr3yXFAOIK0DUnE584nSmcf3y0Amm6yL55JghlPEOUscK670BPLP8J8hJuXDKDka3dNqqS/C5u5UD9aVgp7myiq5+t4IB/imyL1qvzNmdGHXVpycYciDYSHkRo82fIOCg9LjLvPLAbM7Af7GZ1dP2/VMfOpEyEDktH5rTPXtvoTGpYMVy1ZmvqpzjYkfbUnXzRRGRaMh0DZYTA+YK66MGNzI1WfTdHbaQBMFVkjQ7zczTqIl5mWSOmsvzU98VKZdmQ5g07paAl1uPPWel0jpKKgQgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by LV2PR12MB6015.namprd12.prod.outlook.com (2603:10b6:408:14f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Wed, 9 Sep 2026
 16:41:13 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0406.007; Wed, 9 Sep 2026
 16:41:09 +0000
Date: Wed, 9 Sep 2026 13:41:07 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>, Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org,
	Kevin Tian <kevin.tian@intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Pranjal Shrivastava <praan@google.com>
Subject: Re: [PATCH v6 0/5] iommufd: Iterate the cache invalidation array in
 the core
Message-ID: <20260909164107.GA4147563@nvidia.com>
References: <cover.1788127877.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1788127877.git.nicolinc@nvidia.com>
X-ClientProxiedBy: YT4PR01CA0456.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10d::20) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|LV2PR12MB6015:EE_
X-MS-Office365-Filtering-Correlation-Id: c377d30c-31c5-4064-941a-08df0e912665
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|23010399003|10067099003|11063799006|56012099006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	TDtOt/rNRVCO+hGB6V7+QMmW2TcCXklHyKQW3hNOKRHPM2bXapaUTxNVDPAG2XLiEVMPM78y06cEMjaT93jr2bt5O8AOsy5oLYaroIinrc3tgXMzu6SFJRXHzm67T/PAvib2NEV+SzSYQ8S6TtTHDIv+QyzPfNNKiPxweh9/TVrz7wLue+7F+KO+DzEnoz9Aa29WSOYNfgytl+UK6FcxIE4PFqP60IL0dM4c4NsPObs0I5umPkzmk1unBrsuv06A7P8oW2WcKZC3tVr49lU/A175HMqGYce16oQ8xc4RtLWmaeBI3Gt0/ikeV7GgcDqJlOPzF+znJBxiLX3aASjT1zDWtUuMGDSh5jSN8q2/2ARWTvimperPy2KJOJqxjSKgO8s2oqTgkie8Yp3Fiumb/G+UsOFFqcp8asH9RqNvHNLzlWNgds2Hjb7EgLezOlftNkpXA4l1xXrawlh49uaKh8YMoz9Bi7QogEfJkbW04V9VFP7kURjKHp652OPx7nHvgwxFynuD8wn8zbyq5v35WzOWdP+Y3jGalflQ2oGFomhhSYr9MgA+TA+UFFabZR+ngvpk2s3+/xryHuQDGDvuuxvsO1Z+Anv7quDvhIu19WewsSvjuCfvLhvMJozn5ras4GZQKKaOf1Yhz6lxwH7zNlzRpg1iXoODQ+GkdIjyt2A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tTGW5aS24AyaGZMIsmaUFXycsYdYU72tsEJCevwsk2CeB+Fh70tifIzrmP5B?=
 =?us-ascii?Q?ASBobl9NlRQVKUc6UntoioDsTCL5CLDWSl323VFIWqMQUzvYDQ9g8UdwN44T?=
 =?us-ascii?Q?U36O3yxMAUsy31wC3qFxfzvbK4PHBovcHA6WBpU/S2DRL8Zf0TXzUsZlRQXh?=
 =?us-ascii?Q?RWzVWECeB9MK2O5XHev/NUsShRgEBIMJoaaeWV0hZ7kUSKad8ZvQ95BzsM4T?=
 =?us-ascii?Q?x0ntXF3/GDZEgziB2JNCHMTZp5Fb1e9BUYXw7OXjQN90Tgb57ajC49JtgEGo?=
 =?us-ascii?Q?Pu1LGWUhEtWtXOtDiDBaKSauc0Xwap/mBTCwynjgqkJUGCYGdyULLs6UFdNl?=
 =?us-ascii?Q?OOXtWASHRp5P1jWhpKkjbCXqDqXR/n4jsPLdsPeWL8KSJJZozhL7Qz1XsuKk?=
 =?us-ascii?Q?6MkaHw+I+fVGMQd9B1n9fYEPSTbOGJjt6g6ynEcRVdA1djrcvbkHBFwo77fL?=
 =?us-ascii?Q?dXkxkmHjUcM1STzR0YBgB198qca+DoqUjpJTJPTjzGgO2R7XRbwOz9DWyxlT?=
 =?us-ascii?Q?9XJNCWzWZ9AIq2lYvsVRRXRWY3xeZ+s+D6drX4xegnNRqv6DLVgRIEWO6QaP?=
 =?us-ascii?Q?QESNCt4ZzUdHZJgfRX4gLGkVMw3fimq3Tj0OTr1Cb18YGd1bMfgN/7CXC/Si?=
 =?us-ascii?Q?cfBAhlAz1xfJ7XWCS8VSZMXkTEorTrZXFNYWuYrItFyGGP27qFL5MEB7Crzg?=
 =?us-ascii?Q?/ZeEvjHB4uwIgM6Os5S4cvyM3P8ax8fpNGiMKXZKCfyiROgjxmxF5ESPC8DI?=
 =?us-ascii?Q?anSawIXmn7XIvEuj3Eo0RxkqxoBqrT35UXwmnJvuBBxbA4O5cvdtEQW0IVso?=
 =?us-ascii?Q?RknCmbug6N1CRiRPdXw5kiwabFBXUpjnktWPunz8Oa4hsYpHL/F5B1JeGJVd?=
 =?us-ascii?Q?ABbUODAmrXZ+lrr2BLPCOFgyBxyP4mS2jVzR2JbCfh0rgfeNlMgiLwn97leu?=
 =?us-ascii?Q?J5k5lB2nxLh+Bfw/GhxXPJWRBZRYJMOFCJmUqVczdaWXxCmer9/GifHtsKTk?=
 =?us-ascii?Q?RjoKH4Pk8tddpYDQbEdZgBf9gZ+nwsBsEtRUObey/jMp9WtDwUsKpwACPkVc?=
 =?us-ascii?Q?2hBXoit1uSq0PQ0DGGCrHZ7HqlF5OhPenX/p/5OUv/gMV4i61ffpwH3IPg6t?=
 =?us-ascii?Q?iBFlwC5sRitpyfoWjDxcDVXuiC9DrLUFBR+ezoO+3X1N3Vjs+OhVko0zEM59?=
 =?us-ascii?Q?dF0YcK+lMrzh4B+C2pASRkz7ZHrlWybsegXESp9FgQT7HbOMWraoduaxcGLw?=
 =?us-ascii?Q?yFlnwXAJVokvaQBVKf5RAFhGOe67k8acjnFVqssC+I50ZXDiISc6qjhrOLHc?=
 =?us-ascii?Q?glpeyPV/kLCVjKLexoNWSR7zsh1bdy7zx8yE9IHt4YKEH0fsBkaik6Lmb6hD?=
 =?us-ascii?Q?f/oWtJsta9f6jGUWjXomaksPa935kaUl4H5ZyJBvAU8kTR8khT5fw9dIvgwN?=
 =?us-ascii?Q?G8m02rrhQtM8FcE4XJy+7eVh+BE0R5W/EW0Bijzb04S0wcW4D7ZyPF6G2j0f?=
 =?us-ascii?Q?11FUX+reGl5FsIv09TpZiv5k+uItRvjh8MAg/S4SBdoz5MLyrCQKfAQmUkCS?=
 =?us-ascii?Q?8QibsTQ1a9FVPZuGBU9rKgPVw8oR3ptrgSgS65lKgmV6U3aLgH9mZWTFhD4/?=
 =?us-ascii?Q?6uz2KlpB/Ypvi2W49TxOH0SWw2BqjAc2YrY9UXJDxXzdNau5Bn28NMm+6C+O?=
 =?us-ascii?Q?VCbCa9SEgEPDnSAfk6rd5pQDaBZhiVMnvjPsRyQOnyo+7QAk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c377d30c-31c5-4064-941a-08df0e912665
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 16:41:08.9320
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zOEWHX7P0a6BXR+S4k3vDvjXy8oByu9Adv5P64p3N8KZIy0fLVNet7xiavt4WM1Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6015

On Sun, Aug 30, 2026 at 03:26:37PM -0700, Nicolin Chen wrote:
> The vIOMMU cache_invalidate() and the nested-HWPT cache_invalidate_user()
> ops are each handed the full user invalidation array and must report, via
> array->entry_num, how many of its entries they handled. That makes every
> driver open-code the same array walk, with real downsides:
[..]
> Nicolin Chen (5):
>   iommu/arm-smmu-v3-iommufd: Reject unsupported bits in invalidation
>     commands
>   iommufd: Iterate the cache invalidation array in the core
>   iommufd/selftest: Convert cache invalidation mocks to the core array
>     loop
>   iommu/arm-smmu-v3-iommufd: Convert cache invalidation to the core
>     array loop
>   iommu/vt-d: Convert nested cache invalidation to the core array loop
> 
>  include/linux/iommu.h                         |   6 +-
>  include/linux/iommufd.h                       |   2 +
>  include/uapi/linux/iommufd.h                  |   4 +-
>  .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     | 197 ++++++++++++++----
>  drivers/iommu/intel/nested.c                  |  54 ++---
>  drivers/iommu/iommufd/hw_pagetable.c          |  25 ++-
>  drivers/iommu/iommufd/selftest.c              | 147 +++++++------
>  7 files changed, 282 insertions(+), 153 deletions(-)

Will, can I pick this up, or did you want a branch or something?

Thanks,
Jason
