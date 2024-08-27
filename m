Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357C21C4601
	for <iommu@lists.linux.dev>; Tue, 27 Aug 2024 14:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724768778; cv=fail; b=QGhdUoSlldqFpW83havS8yZva9PFDOrUu90IAkrVpo8a9LpdO+P9D4otAFiLlTecUfq+exWoT6p+HjboMYpUK4y0HhRnE8KOox+MwAYV0MjmZ23cFG1VzGIcssVHb0grdAqgvc8Hq5DUra1GNJ0QukYr3HLU6jljeg8SW6KSxqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724768778; c=relaxed/simple;
	bh=97/YT7ya6AGG3PORv+DDhDysxVNH7AkF+unZidp8dfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hFSNM8r03laxSX5LX/6qkHKkf70BNftiNPY47eLhsVCbwOG64xJjGqJ/9pCIhnzTxioa+m+2OWNse3xyGFzf6T5jra73fu/bs5gsp3uoYjk/bLJKx1zkygaiU3gEcodmjq/XOu6FzFb7NxCBlKm3crdEHNvdxchUsKx/gmBkWPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kY59zRgy; arc=fail smtp.client-ip=40.107.94.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kY59zRgy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HbV9WilCCwU0g1HV6Or5ROswtk7I0/2JRu5+pDJW6Ejrgg73NMrG5jeu4vSZ/se6usnVEn29KJChhwCGOs1jpll9BMtpry5U2QIcrEv5hayh1BkhvapcV3ybuUKRfb2rGruspMoPrvMLPJOkKMgyr7iI5swROWS8f+cNnat5LgFg1EHEHkVpxmlrl4VwXSk4XoRKWSOORrMo+o+LM19UtsejiTFkKfGSSE2CrUuqrvfiAOv3TufpB+eQUFVvHEyA5kML6k4V1K1ykmR2K90/FC8Rgfi0CziNR5tHWkQ2L4uASfT6BhQA/2h4a9ve0KdCyK5aFvmGRfscoYoASP3fUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4g2K2XzkDAAMf8Qbe064hXU+zNApRgeI6a102fn5fRg=;
 b=W+YTrpRBPGURQjnPG6TM6yLSd0b2qWN9vacFbuE0jmxDcR2osSvfyj8sn0VhUQeUhL7bcHlz8f11HiQcFgqXPKNcyU6hD1WBAiDIlFXaX4/Fvna26afF3LVO9i5arBHX4CEHkh/ovgLtJGPpvYFOG8hBkM6lob+NbYom4+O/MKKyswo4vsE1tDnv8R0awaNM2V78ZO73j4sSupYEhiK+BB/qJL5xCgt6f/HSUt8lfJ478KLZ1L3BBEkO2Gs+6qKsG+MtYQt/wZZaMRIQOSsNgENIrSeZ022e7f+qbogKGTmEglz9rR+/5sMbEd223D9UCeW+cXhfSuJe9ZrfdO7IbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4g2K2XzkDAAMf8Qbe064hXU+zNApRgeI6a102fn5fRg=;
 b=kY59zRgyw8lYKcCJ/+GCzKHuZ6XSCB+T0O+zmR++Xws2NyCiel1qxGZBc4UCNOqv728GMDomERaMhjwr5Rg7P9/gM9BaHhjTvgbJhIVo7oVErPv7jLoYubYkWf1WwvXoLVzQe/jq7bQ5PKNzMclYwWyMpgRbo/sMbZFMfF0X8f29MoInrCF0vEcg9AMDxV7r6EvOfDwDZicBz0V3b/1VKEF4srkciz5E0jlSKZTxCOJVZtVLrlfyhm5HFca1h4ac7j0Y5/fSXRbzi2FttwTCNpj0F03euY/mXl0fLL9Y9tw4eE7Fp3TcJWh8x8S4Z6LYr8LUuHU9lc+CBTAyn6gQuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by SA3PR12MB7831.namprd12.prod.outlook.com (2603:10b6:806:311::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Tue, 27 Aug
 2024 14:26:13 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 14:26:13 +0000
Date: Tue, 27 Aug 2024 11:26:12 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, yi.l.liu@intel.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iommufd/device: Enforce reserved IOVA also when
 attached to hwpt_nested
Message-ID: <20240827142612.GN3773488@nvidia.com>
References: <20240807003446.3740368-1-nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807003446.3740368-1-nicolinc@nvidia.com>
X-ClientProxiedBy: MN2PR20CA0007.namprd20.prod.outlook.com
 (2603:10b6:208:e8::20) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|SA3PR12MB7831:EE_
X-MS-Office365-Filtering-Correlation-Id: 357f8f03-69ce-47d5-3652-08dcc6a433fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Mumw7SUt3QaApuPWJeJVIoeydcDgJ7hpmAz27bAXok5H/XNsIWAh7hNt3Kud?=
 =?us-ascii?Q?PKdSFB0+pkX+RrFXU6O5h/YQSfsTRh18+WU1QG9sLUNam7DO3NeaZpNU7Sm9?=
 =?us-ascii?Q?NnfZJgEJ55MgSbMdiadDMKJFhY2lghD6FiStMZoE+FD8QJ+M9H7bF5iG7RD6?=
 =?us-ascii?Q?KqMF3/ChEezZllDTj71XxjoCLLtLHMWuaAjE6jo74i6aYDaXGnpXwUdb/Ir8?=
 =?us-ascii?Q?G3XIlvc0KM+Vso9lO14h/I/+0LOzpqmPvBgVkbHbjonMbe8+wpHBlb0awxy5?=
 =?us-ascii?Q?2jYFZpbXrDPi8R6GnXyx2DFwhN65sHPwqjQQCE3/Fc/2wEM/0nu744uE7Zul?=
 =?us-ascii?Q?r4afhFcY0ImPZiPEZ+qPXVmzwCheLP0A1iZBGdK248aP9oXkmwErMraLNVMQ?=
 =?us-ascii?Q?iAP9VTk0WmezP1nCK9kErCNYvQRp+fDFqzXcp9S1RoRAn+d05amT0f1BAovj?=
 =?us-ascii?Q?SZaDwffDtYDu2jlxKHCuSM5Xjgvhr4OhefE23NEruHl9sui9eTxddrKjZEbo?=
 =?us-ascii?Q?tEQtNwUsUfAt9+ecznJ1xHc37NWdu4L13H9vfL03K91rf+3AZda34CY5G1mX?=
 =?us-ascii?Q?bom59AtDX9amV0Llz+8CmKODzjTrMLQoIDp2Zo6OefOU1Um7Tz+sK9nC6t8x?=
 =?us-ascii?Q?52iiUNMiFGiBQDYTVd2q5MeHh1txsH1DqTNHsIty1oIAq54no1kuBHbg9Qiy?=
 =?us-ascii?Q?u7xz0poYsYQZYWhrEZvVqEq33vYQF06iC2e5QAKWLQc74NK/rsteyczvH+d2?=
 =?us-ascii?Q?2C9RJc/fCwy+p/76AV+Mj8jOJLgsdZk0JW5CF4LbOJl6CfQLek66i5DBa8zi?=
 =?us-ascii?Q?AsK3BAdKJThq6/KRIOYBAlp+V3lif/n/CHkDJQ8yocEdm6dT5X8QkphH2DM0?=
 =?us-ascii?Q?dwNUTozL3vKPnSLzMyvTeFESeIsv8vBlrYagSBK5uemltoZ8NYmU30f18YTB?=
 =?us-ascii?Q?OKn9U4s6OuVRjd1vpFsDZNTzIkFTB3P5z1KfhMJroDzMfFHDq4dKVIFBCGKC?=
 =?us-ascii?Q?yycThiDrNuGxZgBrR6BCwCru2leSPWancmHhhD840aM0nEk38jUNYxl6uioN?=
 =?us-ascii?Q?DJPYXu3asD+dYQhO6xKOpYDWKgw2YvvSaW2woojxRr8LqwJpxCo77Uyyo3XB?=
 =?us-ascii?Q?eYSQ2mW1iQhHGiohD/QNXTlOtNbx5RmBoRdZYGqB18b0fdaV9/wpZyRMxRvG?=
 =?us-ascii?Q?dmKaLN3Br8029picQhZK8kvPE6caL1ELnDrqHjukLnTZtuxekBrbObJfLmtg?=
 =?us-ascii?Q?LMw7flJpQNQ1513ICk1dUxatXtu7hn6mF0TxIsrN/hYF/Jj7YwIlTMZF1Y5B?=
 =?us-ascii?Q?FwbnPRX29gzlA4y8ToxCbtH5nX4tIQ7t54EqYZajFKsCNg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KdpkwfQjufNeDEKWiq0BQmWv7TvaaLUGrmT9kxyy6OJQNi/PZ/LG6StHsvVe?=
 =?us-ascii?Q?oefMOShiJhGqwvxUEpmQVHIYqxfOShbT0B4rUXHULqKd5a5QrrAjDU8+Pb+z?=
 =?us-ascii?Q?3m9KFYWuCuHrmP8NZX6P0OAL8EvjeUFNc3+KgwO1XIYN911j02Nm4SsaCLiv?=
 =?us-ascii?Q?YvWNhhS3l2FtA0YKhlWrpfFi3sCOs81y1FNhXL8DIG9PJhoeea72t8AITCCB?=
 =?us-ascii?Q?Fr+GqKyYOkFY5EmdoUYgOLuW+1wtZBG5odf0T14bZ2inyIFfgXx2mdKKc5Ma?=
 =?us-ascii?Q?wpewxHdMMJ/ciK+a1BWWQ/ov1yxP/3zS1KNsrWFIGAcKR1n8zOIzntiweNwx?=
 =?us-ascii?Q?vUH02lvAbWxDlZ14MqHLHfw3NrgZXe96Az8U41Q1aRlwYmxnGxtYLjitxz1o?=
 =?us-ascii?Q?WXLj4Uptmxg/MFsiXXkETEFzgLaBWswFFsIibREz3khy3vjjhlJVezv3U2sB?=
 =?us-ascii?Q?9E4ZHN3ek6GTt5Fnci5q7MF9CiQzHQzFNDmqKpGi91OmLrNMCuMcHKdpeuOJ?=
 =?us-ascii?Q?+oRB6BECUpE4HrJO+aLc9j77P7yIFeOnS3DUzPQJF7nF3aiASM4I4D6/QZcO?=
 =?us-ascii?Q?mkgezb1Wv1frvWM5Dx9FUtKAQBUyjFwKk5Qxne8IVYAJInkAIwP0n5Ft63sh?=
 =?us-ascii?Q?WtdMSLtOlG1IS4/BFF23r/rTO9V/nrnVcKLQf+T2Ltd0K1D2Jov0oNQOkZ9N?=
 =?us-ascii?Q?RFaMVtUmJzf3eNizxyk34sMSB1PjCEO63ZSm0WuUOr7IW7xu/xDJD8U7Kims?=
 =?us-ascii?Q?Tb2LftJFHcZAvH5FaCJconOpHe4UMSnK4YBYMchu6lMGs6VGxGX8Nijkvg6Y?=
 =?us-ascii?Q?NaAnGQ7WqqITu1wJFjPeID/Zzi3Ju9Y16ntPdj+bgzKlgu7k+3XF5pme1hFN?=
 =?us-ascii?Q?kqqB7TcYI6omcey0TSLEk8XawpPZVdsagmo3CyR32hpbN3ilvHePw1NQ3MZr?=
 =?us-ascii?Q?WEADma59LP6uzZYDfU8CSJoY89auSTzElq/dihh98ufJfJFOWMF4Axyw7qCS?=
 =?us-ascii?Q?totlOxvrzQqdPK1cFu1l87MQkfkrG27VhLL3yAOuPnPjxtZhYgi3pkgY7gEv?=
 =?us-ascii?Q?YXaPYX0Kmd+VwWpdCiaJAdHjZ91DedvxxlrpZVwvBmRjFQfOr/uQB0HVb+Ze?=
 =?us-ascii?Q?Is8xQcQyOR7QM1ZApRowXcyerkMK9EfDQmk+CJINrT9eKXTKkANETMR3yxek?=
 =?us-ascii?Q?rWJbJ17N2iVbt2Fbj7zKJ9BYM8CptoSIneP0q3kdSOzrH4uBzV0JC6r9H4qS?=
 =?us-ascii?Q?1Ch3NYqcuzI8wxVYma/4VhRxnGWkJTIRdvCxmhNHjlrHxvrNqZXciIqkUxPt?=
 =?us-ascii?Q?lU85BX7PxF6YbZL1Lpdszh7/sTLHV9b0157pGF4ORuBHIPIDgGT1U8xDRefS?=
 =?us-ascii?Q?x5PKhST8Owb8yLQoTWg5gj5dMMIgwPpu4nyWpVvryqZBXPc2PKD09ctoA062?=
 =?us-ascii?Q?x56/d7UowW7Fa1Bbb7oQB21oQ1ceCfwjRv9S8lP6+wDWUvRQzNmgf4f/yudO?=
 =?us-ascii?Q?cEYH5LQ1qVRKa/kHrsw5CyzDEdZJdeLuWRxBe7gpyU5XkBatXGgFTlY2K7oX?=
 =?us-ascii?Q?2ScqQgvWDILN60jXDgI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 357f8f03-69ce-47d5-3652-08dcc6a433fd
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 14:26:13.2055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JczUJh4BUhnuEx52yO+Jg8572xRKHz7Urq1O3a29k3qXIqB4BYRXtr92WzvITsNb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7831

On Tue, Aug 06, 2024 at 05:34:46PM -0700, Nicolin Chen wrote:
> Currently, device reserved regions are only enforced when the device is
> attached to an hwpt_paging. In other words, if the device gets attached
> to an hwpt_nested directly, the parent hwpt_paging of the hwpt_nested's
> would not enforce those reserved IOVAs. This works for most of reserved
> region types, but not for IOMMU_RESV_SW_MSI, which is a unique software
> defined window, required by a nesting case too to setup an MSI doorbell
> on the parent stage-2 hwpt/domain.
> 
> Kevin pointed out that:
> 1) there is no usage using up closely the entire IOVA space yet,
> 2) guest may change the viommu mode to switch between nested
>    and paging then VMM has to take all devices' reserved regions
>    into consideration anyway, when composing the GPA space.
> Link: https://lore.kernel.org/all/BN9PR11MB5276497781C96415272E6FED8CB12@BN9PR11MB5276.namprd11.prod.outlook.com/
> 
> So it would be actually convenient for us to also enforce reserved IOVA
> onto the parent hwpt_paging, when attaching a device to an hwpt_nested.
> 
> Repurpose the existing attach/replace_paging helpers to attach device's
> reserved IOVAs exclusively.
> 
> Add a new find_hwpt_paging helper, which is only used by these reserved
> IOVA functions, to allow an IOMMUFD_OBJ_HWPT_NESTED hwpt to redirect to
> its parent hwpt_paging. Return a NULL in these two helpers for any new
> HWPT type in the future.
> 
> Suggested-by: Tian, Kevin <kevin.tian@intel.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
> 
> Changelog
> v3:
>  * Moved to_hwpt_paging logic back to the callers
>  * Added a new find_hwpt_paging for reserved iova callers
> v2:
>  https://lore.kernel.org/all/20240806050201.3717816-1-nicolinc@nvidia.com/
>  * Corrected the ioas comparisons for future hwpt type that returns
>    NULL by the to_hwpt_paging helper.
> v1:
>  https://lore.kernel.org/all/20240802053458.2754673-1-nicolinc@nvidia.com/
> 
>  drivers/iommu/iommufd/device.c          | 52 ++++++++++++-------------
>  drivers/iommu/iommufd/iommufd_private.h | 19 +++++++++
>  2 files changed, 45 insertions(+), 26 deletions(-)

Applied to iommufd for-next

Thanks,
Jason
