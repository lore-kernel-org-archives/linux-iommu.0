Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010028.outbound.protection.outlook.com [52.101.56.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6DC42A158
	for <iommu@lists.linux.dev>; Tue,  7 Jul 2026 14:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783435200; cv=fail; b=JalJajiWtxB/MDeVuqmGmTM2lspx2Yl5SUtJp2Rwa4LgQfAnb2pJ1rLYGvf9/C3Y0HK7u6Hjgm9Xf9jMFcUXoNjOYyZeBXiJaH23OGRzYXnZKAhgzBSIyTwrmvqDjzuDOQlmp4Lhmr4wMPpU035PRC3HuaAU2T1sKqc0TfD9/S8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783435200; c=relaxed/simple;
	bh=08quEybhhp9nq/7JyU5Lk2BEaBiYdarwghYwfCNaqfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tK9cjxAWbUI2Q30ZEqBvvOJ/AAIko7JHzjrLbLooVAJPXPVox4xJW/V0SwM6OdFXnzpDZV5tdbnPHOc1imVh6yhzN/P03XfgcODnfyH9XOpLQuemn/by+9DrGTBQv1T8vcKuw2LpjwdYQ9bDYPBZk6GpfUvjRtSxXJUcDnWcAus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=o95OFKOQ; arc=fail smtp.client-ip=52.101.56.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="o95OFKOQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cJYeK8P6pQnniR8HLDrscbgxV5EWN4LBZn57qtCwRjhqTN+r1gYh0kw7AMgrCR50XwDMMcJB9mUkhv0TeLCVo0MweA/o1+EaOEUTMGKHGXqNpHAtsDhjjjpYmVdUAY/7wAQ+o1cXVVIGiY/6Nzzu7QubaYKOE/PlZ9xM0OxAT/Ubcroj1+5Nn8iMti53qhCSBEdI1UdYq7bbxCzDmtoQekT+Q9uSfhSn/mZAYazMHCg6PX588ItdMRTtVVV+Ve8NorZstSJglj63b4GcRZCKu+FdfczRZxQwZ5SOTZIYKWcNKI8ZWi3vIaExZtIaHWG/we/XPMRbpc838ZDFS3WFrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tgFtjwAVFSjk8CXwkvVPHuVVqXQDjmyH4I9e8ThRUIg=;
 b=Cfg436ue2aKG9ZH0SPrY32S7/ZaaThgtMfT6FaWdXHVCorCf6DBSdAbyA9hmeAbzlYhLmXr3hi0KXnNCCksDhFqWXP3Ir+eWO1a+NxUeOXld1qGW/UtDHbdmGHUyopfF9hpQUfUHjrtcbIAmhbapZSjkuZz2IN3FuwzRx22X0CQ+VYk59sPKqL09C/wEpopWxerLhoBUs+/jw+WOaoOaj+53gqEkQX1zdvmx6ZZcKGrj+jOnGi1xE6zsRGbOCtuZkMLUlup4JUp15ENhXcDftW1WkPmuw3CnFpakwX1fBjkYuPA0Z73Swi//i9fwff23TywQMiJ/fwl0D29gq9YxLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tgFtjwAVFSjk8CXwkvVPHuVVqXQDjmyH4I9e8ThRUIg=;
 b=o95OFKOQtZLfL38oACH6soX/AwXC0HIPGxyoxxq8c81irUE95Fd0eSmcIQ3/aLfxMb7YLBEhrWCO/7kdMwQ46gnGUk6SIgyUnmFoqEjY3+a52/qpu2sJsxPZtuI4vIsVhuiWHjUAbdQtfgObsSc64uttMaz3PuJTKKCaVqGEq9ozcH093A89PsnB50Ar65gpjDD0UBsrzt2QKobNIsJmW7CPHSRUkeApG8nCZj6WK85DMCSJCa7Oy+p0RP/LQCHBKFd7xSoyfmVfQyUTMKzFj5ppT2LZifFUM6aCo3s3yT2f3nV9tEsjXuLNzbdRQvcBVkObvoyoxxUFKc2YhTwB3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH3PR12MB8935.namprd12.prod.outlook.com (2603:10b6:610:169::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 7 Jul 2026
 14:39:51 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0181.008; Tue, 7 Jul 2026
 14:39:51 +0000
Date: Tue, 7 Jul 2026 11:39:50 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
	yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
	vasant.hegde@amd.com, jon.grimm@amd.com, santosh.shukla@amd.com,
	sairaj.arunkodilkar@amd.com, jay.chen@amd.com, wvw@google.com,
	wnliu@google.com, dantuluris@google.com, chriscli@google.com,
	kpsingh@google.com
Subject: Re: [PATCH v3 20/22] iommu/amd: Reserve translate-device-id for PCI
 requestor aliases
Message-ID: <20260707143950.GH220801@nvidia.com>
References: <20260629153535.15775-1-suravee.suthikulpanit@amd.com>
 <20260629153535.15775-21-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629153535.15775-21-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: BN0PR04CA0132.namprd04.prod.outlook.com
 (2603:10b6:408:ed::17) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH3PR12MB8935:EE_
X-MS-Office365-Filtering-Correlation-Id: 833f8526-82b9-46b6-94d3-08dedc359a30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|23010399003|7416014|1800799024|22082099003|11063799006|5023799004|4143699003|56012099006|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	rP95BkSGwSH4KTUj04IEHIETEVGyNWea2BONbZD+BQoFRofzbMKgqDV7kFkplGJWUHAVCD80MH7R7rf8cNAbZ0iJgrA66WlVletOOvDDjhMLm3fgsC0bA+NeWv1Xvyp99urMU986PKA287on8Y6QY+rhasGw3vqIthhgi9K8/TnzS+AketHtLrUQBGSRjuuIRnw14bx25KDvD51fykn9ZQlzm+GfQM4DF9hwI8KrT3oywfMiaRzp7Du9HI6tqZfBn0zMbZtLuEg8FcFmwmENZ8TR1/32dCFig7P+t9ldeBDThVPbwwzdorFOoZeL5pHaNsYMzTiiilkFewIOrIXpnN8hupXxjf/rKooZmoGGWhbeMFwKoieJRudVDcDa2LYNVuvz0eRv6rljoDkjQxnY9xD7vheZw+xdtQeIyhxw512unerfUeXBAY8Hh+ywAJT5NCM3Ln7clflUmMCVv0i5G5yF3tc89W9fH5hEG4Osd/+kAWudYdSk1fQvOxaS18GpgmgA0KMWUu+iy1kf8Z2YCLWuA33D/uPdaLlHvAWLMsszOHl51Onju+4j8QnwrZn8+IsxoRaI3qKG2tsOvLI9WzuOIHGMhjv3k01kkIQA/Z2c//eoLxAt2aN+bZDjJuAvXX+hfl8rz7m4abMTtZORduK6vLHN49VumP2mWO2lzl4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(7416014)(1800799024)(22082099003)(11063799006)(5023799004)(4143699003)(56012099006)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Gz8AAR6eXPetXs7u6na8aPxYgj8LxnWBiWPWG0vAilz/nWqcgDvwBaVzNKjQ?=
 =?us-ascii?Q?b1xJL3FcoXdZxOfbCFTIiOJGCDwHiiDgUN9Q/15U+Z5j7U1rvslrVtPxhCRC?=
 =?us-ascii?Q?SnDkTtV7i5xRX32EAlZxg0r7hVLA1nBCyZ9NshiYaa17fgZl3lrGXcvgaP4B?=
 =?us-ascii?Q?R93mkfFQfoCiG3KGrd3WEwcDC8amMyCwcq3a+w9ZzAZqnKxAv9Md9WbLmjpA?=
 =?us-ascii?Q?RrXPpQxRCpzQVsk+0xYM0lse/U28ZGDyps/u0rCHaedDKxuyME11ZG0ycXog?=
 =?us-ascii?Q?LY5mySYnKGD2EouhJ6WIPrf1OsJ+GWwZrWXDzBG1wJjFFBbuFIHgMpdSCI8o?=
 =?us-ascii?Q?z5gAWh767sVoy7C32/rlVf+dPvcmdIXlXxwfWRbc/pN2NI2wVYYk2/5XfALa?=
 =?us-ascii?Q?nFOR3suPdJN7MIRb2WHKS5zqe9lJXjPfkblUs8ciTFXySvguwCnK9nhcs32t?=
 =?us-ascii?Q?ioLXt84zGJUI23GLPgwcgjyac4eFoPzitKEbBUi3OkwKHzrk7NgVyC0aVqfw?=
 =?us-ascii?Q?JyAGFUXlnAXrRus1cq07kmHHmaKqcJsvGBZSsmJhvkbD7EloDzN6bUQ9VqD5?=
 =?us-ascii?Q?v2vrHvdTgvskMoVZfwH12/B8FCidOT7ELnKsOBmc7lD8NcKYKQVOzwVB5bqI?=
 =?us-ascii?Q?eS0gu5L8cIeIPxPlOkDh50gPgC943t6iZwT6EDq29p2LKApsBTwXSU1A5ayX?=
 =?us-ascii?Q?P99xacWTHEs41N9sfPpMUMvufXENOVQIgXjVB6rbC1HZF9DggaGAPtCg7guC?=
 =?us-ascii?Q?u/s7Am9WabS+fVq9GiJY9VC5h/D9r6Fcem/dW8Hmw5Oe76BXTXhW2MSgbCTX?=
 =?us-ascii?Q?nkC2b7fhmiXuUQba7EdhOqzOixAGWhRurv68hGMTPKSMbDTwUiYmbCH92KE/?=
 =?us-ascii?Q?427yCjJdirs6ctaDPVjtWpR2x/2QnRLSk2BbSi078cTsCAndsO6LAnSgSSJr?=
 =?us-ascii?Q?uLXm6LWxASQDs05plSyzzasud8M+XZia94/irorBW2kuA0a5lsmNF5xU4Wb/?=
 =?us-ascii?Q?1eKImJFt7uZTt2+A9h+XP+pASrx7A4f7k2UZRco3jfqJT6MqQGW/7VOCkOQ/?=
 =?us-ascii?Q?TJRlZX7cv+5+gqwSTMVffznkng3w/t9Q8pJ8zlyuqzlSgz415f1qAnYWLO4F?=
 =?us-ascii?Q?4bN7azzmAh4osBGP+l61xpNDVqo3vXlWj6CBwpEGL4Rvv9OG+oG0Fx+mQsBO?=
 =?us-ascii?Q?R/hx5iHV5YGMJFZxtbDfht/ALLPzrZUiGup+Zzqhzxa7zO8MsJq6h1PkRW3R?=
 =?us-ascii?Q?hLGindyVZSo6o16bOHvV3wOCWKB/ir00aktIKO/hk4seQOHLh7qdsVbPz05k?=
 =?us-ascii?Q?xuYEXOv5Tk9NmwYkPykLxGy6roA8YxzhU8pH51XRIoUoY/Q05kW25eySo+CE?=
 =?us-ascii?Q?u3pau4ToJCEkCpsu+ymUEMyE5UgUuA6qYP81iBoYn4KwFPu5T4QuJQ+Hz9gU?=
 =?us-ascii?Q?OPbLtGGJfgTk+URukiw7UI2GunjySNsFqsBYJ8q0zj509z+1agBILuV9WAX9?=
 =?us-ascii?Q?fSS825dQuGUWnEOSUQrZgyDrOQEbe++3dPi8ekvCTXBThUAPuWisWF3rkmgR?=
 =?us-ascii?Q?YeMuuD/opoCjgtTHN/q6JD6+ktFtiVfTZvhV9R5PlRYLaVB9FEcwPupJscaV?=
 =?us-ascii?Q?iCQ9Q3hOfVNsTCH7lXuHoNaLBBq955tCiyg8l7CkoCALorQv0Yp5pm9K1GiJ?=
 =?us-ascii?Q?VYIY2B5X79DChHeFMsPU/TAM76X3Nr/hbgkdMw1pFcRqAV0F?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 833f8526-82b9-46b6-94d3-08dedc359a30
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 14:39:51.4169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r7e+fOV2t8JK02ci6HQUW+c7ew0IOArnptzrExG76tkMoS4MGqebefQHw8NBrJkL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8935

On Mon, Jun 29, 2026 at 03:35:33PM +0000, Suravee Suthikulpanit wrote:
> The per-segment translate-device-id (trans_devid) pool hands out numeric
> device-table indices used by the AMD vIOMMU / iommufd path (e.g. mapping a
> KVM file descriptor to a shared trans_devid). 

Nothing to do with kvm

> Introduce amd_iommu_trans_devid_reserve_pci_aliases() in trans_devid.c and
> invoke it from amd_iommu_attach_device() immediately after the primary
> amd_iommu_trans_devid_reserve() succeeds.  For PCI devices the helper
> reserves the IVRS alias when it differs from the device BDF, then walks
> pci_for_each_dma_alias() and reserves each alias BDF.  Repeated attach and
> overlap with the primary BDF in the PCI walk are handled by the existing
> idempotency of amd_iommu_trans_devid_reserve() (a second reserve of an
> already-reserved id succeeds).

It would be so nice if the AMD driver could get fixed up to work more
like ARM with the alais devids.

ie on probe you allocate an array of all the alias dev ids, fill it in
with the information from PCI and then never touch the PCI again.

Then you'd just dump the whole array into the allocator in one clean
shot and this would all be simpler.

Instead we have these endless pci walks every where :\

But its fine like this I suppose

Jason
