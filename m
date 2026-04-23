Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012055.outbound.protection.outlook.com [40.107.200.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385E92BEFF6
	for <iommu@lists.linux.dev>; Thu, 23 Apr 2026 14:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776955880; cv=fail; b=kbEHztDhNdS7mX8c6cpyWtvMRgeLpzvWeTjrNGxwVeg+cPTY4zbAyOKNpbDRUYIPSHEOhLDbWTphxyfhsHio7dL61u8qnlEvdKLrJV9AplCRTlJ7Uc+REutAUzW3OIG4pEjUSAiZqrtLnqOB/5XnZ8+JdqLfavgFR8s/OaYulQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776955880; c=relaxed/simple;
	bh=Pm8/S7DC8qkzCUe9tb0clUI2vmyV0EKwV5CiVQiNRD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=p75tYMdQUV8apoS8VUpYyMT5k8qPZuPDzdTUbAT5YrcaMLbbj0QBuQYXlOOt5JuzfvUkbGZQB/4v/9K8jtshJx8V2YYB5/qNNnD4w9TTJnBT5XCenMpa+Ws5OEh8AJObBs1mq8GG9mBZ4IM3YiNK4Urpk8mfBdsIiHRHbNw+Qp8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nX+KPYXI; arc=fail smtp.client-ip=40.107.200.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nX+KPYXI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gLrlRKm7Xp2UFcJ3+HYU0wmGtN6GXKpsPEmdfNQai9V5lnfp27NiHOSgkulxkcU+0VlW6jtEfWjl+vDziEAjqQwaNbwUGJOLprLXHjrObmDowX2TaJiCIPPjbfz4sVAj/6tGUFTFjkHNWdf6ebmzTFlzfDvi9KbX6P7BWcMoWiWSlYI1/ZAjvwK/3lJj79FW6Bw/NfyktLZBm/JRnifkhbp0zW3UGBNkmcuY+IrlqJa9Wmw8liq5jLiW7Vu2gXBzARvek7ucpI/e+48bgVBchNMBsSSJueQ5pEF/omRbu2ye8L8vC5f9J0aLG7SHo/wZI94Mr5CHPYHeVLYz2yfnQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pn7yGpd+uj72wP9yHPRrkCYzRPfwbjxHpYnsX4V5MNg=;
 b=AT/u6ABXxrBp3Cwq4xopJa+RaW7j8Y9NnuJ80OAhYX2Zt99zgrnIfEj/E82OIRDFcsmHk4DI463H1IU3c6m0iYra2M7gziW343yb5IHfAXjxRyhT90VZvK/QWKVr6ADGmjfS7B5CJ3h+VMz6VOT/eFiWv11Tk2PYWw/YhghHDqGNjIjTeWc+4MnCXK+YBGo0AauA3eLW6AMb6U6gCXnQT8MfL+P+1wqGwjjj6mkEqrwtqW2nl0h46rPiS2MI1peEInFlm6Xg+Cn9nqX1gBddmTd0yvdAVPWjmxcFWDZzdbjdACKekdBKS0lGDibv4o237srJ/+h07+NsD3P3klg1hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pn7yGpd+uj72wP9yHPRrkCYzRPfwbjxHpYnsX4V5MNg=;
 b=nX+KPYXIfKsCtR+gOD+lHFaKcaa2exCRTzNAngNR8TKVLCV5lNISGQWjdq43CV3iRyy6nvUpf2qpZZAgTZ2Re32ap7G3gAZlyjwCJk9Soe/UAa99zvRz7DPvi+ULJXQDatovTyv+3DQpxAfdYeIBRqOu2pux9xWupaZFR0lcYkPGEgSNY/F6ZCtlOY/r7GTm+JQzH1BQfU0n6Vwy1WOTGLEVyHH0LKijfZyqbXFvvtdnBa4lcnT9NG7DzegvTZqWzsGRS+lCL2Uq7Ycv2a/BLDZHYZlJ2oZbpPJDo8gWybRU11pgD/shg36p4NT6FIKb9kdoTjtqTWcGUZhSdCSUhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by LV2PR12MB5727.namprd12.prod.outlook.com (2603:10b6:408:17d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.20; Thu, 23 Apr
 2026 14:51:11 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9846.019; Thu, 23 Apr 2026
 14:51:11 +0000
Date: Thu, 23 Apr 2026 11:51:08 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Jacob Pan <jacob.pan@linux.microsoft.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Alex Williamson <alex@shazbot.org>, Joerg Roedel <joro@8bytes.org>,
	Mostafa Saleh <smostafa@google.com>,
	David Matlack <dmatlack@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	"skhawaja@google.com" <skhawaja@google.com>,
	"pasha.tatashin@soleen.com" <pasha.tatashin@soleen.com>,
	Will Deacon <will@kernel.org>, Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH V4 01/10] iommufd: Support a HWPT without an iommu driver
 for noiommu
Message-ID: <20260423145108.GM3199414@nvidia.com>
References: <20260414211412.2729-1-jacob.pan@linux.microsoft.com>
 <20260414211412.2729-2-jacob.pan@linux.microsoft.com>
 <BL1PR11MB52710F2441FB52E2D94D37868C232@BL1PR11MB5271.namprd11.prod.outlook.com>
 <20260417145946.00004418@linux.microsoft.com>
 <BN9PR11MB5276DB15491F949DA7D8F0A78C2D2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20260422160315.GL3199414@nvidia.com>
 <BN9PR11MB5276317325A185589BB76F118C2A2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276317325A185589BB76F118C2A2@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: YT4PR01CA0481.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10c::23) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|LV2PR12MB5727:EE_
X-MS-Office365-Filtering-Correlation-Id: ab3161ca-4db8-4170-ed63-08dea147c250
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	d8ZSnOXahpBVj7U3pevNkdFaBdZHgj8Upy7yrqtlX9jjk3OLv6BnzOdPO49y/RovOU4mRSk90RobtY3lTylZzKnDsQ8WU2+uaTZoflgxMpRfYWSui9g/Kva2q3wQjBxVc9GLddpxr8kWI+E98byL22fWCqOFwFrjeyVioCDF8Th8VPnvTNAHUxc6w6eNz7D32JrrqV7fvix3rFt5rBpfiDzVq80zMtWPPM9SNMQ276zkU6ZjK7vEpbk1+dQtpGK4sp/rhcZ5Inut95FwH3Kf+QMmh2Lrk6wqj4TT1b1/x3unEu1Nr87rUoJMSMprF8yqM5XakpK8o8n1dJ5KBL7dh8u0rvwvQiitT/ZB18+DVgM95y0wBq8+3HW1u0z3gqYwVWUpQ+lpTL04PP71ZtFCDFedtmuaJK4eq0XwPMWMUiWpd1LgIm3X2i0zSB+vOu4kk/CbEBwjL3l7Tsmy8oeO5IZUHllNic2BaBg/+4+mMy/3xcDgNFuKMZZA0i7C2NVOXOoO5KZ7WOyiuFgv78IzQZQSyMvo1Nd3Y5WN3LwC+7XsVoEouzcPFxrZdbXdXldvVNZPJS/QwPabS/AfKnESLLultAlYk8L/Vxku3FakIZ0xuPTBMHYdo1c5R5bcpediImwdT6I6KrpfAWb3ypRQ55YBk2Luq4q0WiWgdFv7IUXHRN3c4aDYXTXCruoKxAZ55dM3hi/6JUs0drG4I4sgsuKAhKtZFY0ENOiByWn2C8Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kBOme4xVcs8HiBWsnhLErO4zCeVq9jZuYtOa6rjbEecDHu7MhjkPILIeWFdz?=
 =?us-ascii?Q?KtQ8uQ0xDmfZ5pXIo15PCQQVRvOohwQqdfRr2lm3z3zToYpUOTdfqSdhIS5a?=
 =?us-ascii?Q?gR4IS19GSYcX0KHpJS7qzG9j/4gU+uixnlIL8LCu6UOkcurb6hikJ1qrx+Yb?=
 =?us-ascii?Q?7Hm0skVST+4tr0tS10gy1/taJJcXU2vkVX7w4j5OY61t4V2DPEVtDEPg9LkF?=
 =?us-ascii?Q?uYvZxroC9uXC1TEWBeFt0FPBtC5JSao1oJ4I5TmSJ6SV74aqDvXJc4hkFgS2?=
 =?us-ascii?Q?LMD9B+5KyB9/sL2BqwcvT5cZ/bH973Omr+wyJHEwFAtgLJkRyf9XqpvradSh?=
 =?us-ascii?Q?MDRhaouDOc1tYxeC/IrUncK7BuGoBILAXT3FzMt/e9vQZ0EqG8rwkX0zOho0?=
 =?us-ascii?Q?RqLNL5tvMRLZkrHqxv+MOYs7Fk3ELfsx32qZbByFT1OR81b+avXUY8dE2gIz?=
 =?us-ascii?Q?RbY7LzwU7fIxDY2INwwSz95/FnfWlm8bc4ASvh4MwvP170vei/WKrLPEQE5D?=
 =?us-ascii?Q?wklqs0UqmY4Zd+aHq4KmT8kg5TPlkg2HV52CNGdpic/1BMfqOVJfAmnV3Mnl?=
 =?us-ascii?Q?dif38SpvNxU3Nnqi+yetHZqvyRoKp6BjXbHtNnLnabbvjSAreRWRBQ/LHzdl?=
 =?us-ascii?Q?xtyFTwTuXmR15flMTHPv95i2NRCs81nj9UH9PXK4pfOO+TLIn6PDJ+ZijPx1?=
 =?us-ascii?Q?cOH5bhVPs3jb4I75kV6SLfCtxg9k8w8nYaXHj4F+M8zkIVXCwbT08uLIA9DT?=
 =?us-ascii?Q?1ndMHgFDgpZroUZ16ZcP+1aSSOJAHAHmNKzLLoBAsXiB6qZH8eCAVzJSdRnI?=
 =?us-ascii?Q?KFzz8CQSjos9pEApkUxXrc4vtWJ1XDg97vsJgF2tbF3KpvFJ5ffbJJWjX5Sc?=
 =?us-ascii?Q?HBrHl8cH7VWO6DTfYVIQkOZH91d7xnjB9p8wKgUGLOMB6mlFUdW7iU1XEYKT?=
 =?us-ascii?Q?EEOAgUvcj3SLKETdBhuR2i8X5sKXydBW9XI6EvYcyqEP0fVq3+Ay+PIK+Uzy?=
 =?us-ascii?Q?JVm13WcP/aQ76mEjn/sYZTUrjDqov79bqtrLB6bW5YOGbXEZUf2rVYpZmnO3?=
 =?us-ascii?Q?fBS+24R33vy6Hfh+AI8shZ9jYL5fdgUe4b1o8/14eSavjt/2n4CKWHFFmeFx?=
 =?us-ascii?Q?gamXsEHNZniZNPY1FCebmaTogwpt/ln+NphWmyySo+YALFmEW5H+w07RO4VE?=
 =?us-ascii?Q?iBxa7gem0uEoAmmmEylqKme2vzs1M4LbqGev19UDAwtbiKF9Ck86YNOZpBv2?=
 =?us-ascii?Q?Qngp161jL91mFTJw7IcuOBOVe5z6NpnnpvKELxOpX6NkO42v/HaHvEXUj6wQ?=
 =?us-ascii?Q?gcZyKwBwZmYe2mruP8G6vgQJd5fHJZBY87n0+a3CMgnYXpxECYs2M3HcSjUW?=
 =?us-ascii?Q?i0AFepZjFY9PrKA8Xe8ocNE7+NUOuKr9j/I7J2VHibWt+fx/Zb1SV3pWaAA9?=
 =?us-ascii?Q?O+ivopNarHvtks/Ma1EduRWFDGfl90WUIU5zrqFwk92YviGH4VzhtbO3ZUxe?=
 =?us-ascii?Q?z67lSvDXcORAONaGFvOKFN3HlggygSEtqabPDBGP3/6JFMP9JP0H1b89n7wI?=
 =?us-ascii?Q?IhNnf8UunK3hFMy+5roRYjhlMCOWKCmywp+rNjo+U0xwlz3PSgo3oudldrtl?=
 =?us-ascii?Q?WMoRliFPmwaAMCS4ZNLqOdzlvS5nTFnO3Oxd3R4G1naVM7rK0tExrdZcm5Jf?=
 =?us-ascii?Q?XF/XeNfeLJehsfLrNEhLD6586gVGhLMARRi+XxcVcbYCBJU/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab3161ca-4db8-4170-ed63-08dea147c250
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 14:51:11.0038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aCY6tBoEc96ZcFfNSuHl8XnTPRuK9y6BphA/dyGeo4QE1uOz4A5x3xPCnLE5y9kp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5727

On Thu, Apr 23, 2026 at 07:26:49AM +0000, Tian, Kevin wrote:

> I meant to avoid mentioning selftest like below:
> 
> + * AMDV1 is used as a dummy page table for no-IOMMU mode, similar to the
> + * iommufd selftest mock page table.
> 
> "similar to" is not helpful here, and is now not the fact any more.

The mock page table is still amdv1, just a little different flavour of
it :)

Jason
