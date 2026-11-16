Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.61
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794842573;
	b=CNBC/FuUasqVuHBTL6Dwp76CEeJOEc1RxuG/LLP8nrxAm1ydqQDU2ZlZbncqG3mI+6ut
	 6Cp45iyJqMBz2ijZIo9rcovNS5m2uAVDZaH9umNkL/76hWvpSX7r2QgoKKpw0PnYtGtA8
	 NU2HmYMp00vGXbLOUPgxwGmGyCVqmj37D09VibJOeqNJXgzv3zvS9a9bz7eztD/T6vPHL
	 b4ni4jBP3Um4qpKJq0KozydQOWfqPbp+E3ZXpNBoTqHtkVxaxXaaAy3nZLBRiVPKeconN
	 OtYdXdDAbfb+dRfFJ5ZQKYzsaI4a+JAxbqrb+cpf56z7bIInczNIgoLFlRuItYCa8pA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794842573;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=KZ9CU8eKAdktlIu25GiSXdTKIBoybZuUXEMFv52h61Y=;
	b=Qlc+M8aimmIGcUww2T9oS37TIDSLxA5MQlSNAWpuAqZmE6PPjWktf+Pq9X7/3k+3DjzG
	 afgyiCUKLv/BBo1J/SyIgAaiwAE81lcUt72faO9V+BYlxSglwvQRwnoF9qmxQoJa572GB
	 G2WivAxSyCTEnWU3S+a+1yLJXjn4lB81POraSVY0LCXtr4gCBGnJj9+pfONuCXeOEWucg
	 kily6PCFdM6eMQUYV15u7rsoSt/pqfvtnZHINpcIv/JWza91BuS47ffF03Fe4hG4elvac
	 kHd9eQi/F7lQHDYcg73WIYnYNnDyugeiZ1uWv7uqQTrZHPH4rVlb5ERzN6BeCXEFmmA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=w0ujMQNb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.61
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011061.outbound.protection.outlook.com [40.93.194.61])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD538606A330
	for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 15:22:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD538606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=w0ujMQNb
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tuFLQnq2zKFxSzEbYiHQTN8A4jLFKhR6oODveNDLCxQiJcTxi2ZCeibdVNvLJ35jdXbZX7DLEmP29afCdKgh1wI/MF+76NbluFNtVSVqj0ZE+OQ4mcNY5VvDzycJOB6WPwQmda1Ab6hd/dmvwz+biU/a+h0vwC9jAWzmsYF04b2gPcNFgg3zJG4FFKCVBIGjA79PD3Gepvbbd0J3AajXnzyq5RGTHNIzGZbbaDWV6usyqUinAKmRwT4PHNwalTro1RGejbV5edALcdw9o4NavPsj+FogxGjm4tfuYr9ZRrjNVoiWTVhT6dkEHKzQXH3SHGTduJowy29PAhw7MXIZ+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KZ9CU8eKAdktlIu25GiSXdTKIBoybZuUXEMFv52h61Y=;
 b=hZkVOHgvi9/KxbUWKqyLGq40ezE98iRMLAQyWqevfGFfjO0xRBk5Rz/Hgcy/pd1gWaC4WWxfqWWhhfX2UkXiEUlmdKVQtI/HWMud/XG5GBrgImUz9kIpKEM3cTZbFM1SN7kJsnUWl9hVWBYYDcJJUGvO9zxr3vTw7zp2N9YMen4oAyVPr24XJ9Igoix6VnO45X3Mm9q2PaV0FkGMVJi4UJjpWr4sH0rmORsSmfGlrEEaXmV/WRUYL05rSH3EeO/rxXEHjFRWNLt0inRndw5DDN9bqZWmlCey0xIkhJEEL28IrEOfxL0+xLEC8JwC6Hq36cGaDOEQr444jqqWVga0iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KZ9CU8eKAdktlIu25GiSXdTKIBoybZuUXEMFv52h61Y=;
 b=w0ujMQNbitFxgtVlSxkFpJDGX8OvR2YvW6EbYSbmLBgYc4itWDm7wFtLszfoKoOXA2pK4BwXA0FhAZkj/yHyMXHyod9L4Nz+KH9u9P22TjRtAkR9A37X9Gx4n75kLj0MAWee36rAKZ94Ta3Sopv+eR5GXJBf/sm4SeKrFV5ib88=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB6837.namprd12.prod.outlook.com (2603:10b6:806:267::10)
 by AT6PR12MB932818.namprd12.prod.outlook.com (2603:10b6:170:116::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 15:22:49 +0000
Received: from SN7PR12MB6837.namprd12.prod.outlook.com
 ([fe80::42e1:d1c1:d50d:b2d0]) by SN7PR12MB6837.namprd12.prod.outlook.com
 ([fe80::42e1:d1c1:d50d:b2d0%6]) with mapi id 15.21.0615.009; Mon, 16 Nov 2026
 15:22:49 +0000
Date: Mon, 16 Nov 2026 15:22:33 +0000
From: Ankit Soni <Ankit.Soni@amd.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	David Woodhouse <dwmw2@infradead.org>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, 
	Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, Pratyush Yadav <pratyush@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, David Matlack <dmatlack@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Pranjal Shrivastava <praan@google.com>, 
	Vipin Sharma <vipinsh@google.com>, Nicolin Chen <nicolinc@nvidia.com>, 
	John Starks <dev@jstarks.net>
Subject: Re: [PATCH v7 03/18] iommupt: Implement preserve/unpreserve/restore
 callbacks
Message-ID: <ogvxrnowo4jb4bwvybw5o5cyoefuj2yim5oropt6nmri6tseiy@hrl7srunm24j>
References: <20261110040828.1774343-1-skhawaja@google.com>
 <20261110040828.1774343-4-skhawaja@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261110040828.1774343-4-skhawaja@google.com>
X-ClientProxiedBy: MA5PR01CA0144.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b9::11) To SN7PR12MB6837.namprd12.prod.outlook.com
 (2603:10b6:806:267::10)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB6837:EE_|AT6PR12MB932818:EE_
X-MS-Office365-Filtering-Correlation-Id: 46dd0de8-985c-4e70-105c-08df43f578f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|7416014|376014|22082099003|18002099003|6133799003|261009223027099003|3023799007|4143699003|11063799006|56012099006|261102123227099003|261028144727099003|261026121527099003|261026140227099003|261021121427099003|261022105027099003|261022075727099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	CqiTin6KLUSAoC9SZZX1Qxip3YxadMF9YebA8j+xz8SEqQnHFg1D4Kykb9WkXG9I8sfuv61EEM+uoHhE8fteSOr7pn+g+5T47YsDN/PGPQLkgI+Dkc+N80EHoIP2sw/+X4vP2Ln3Ayh9VhvbkHVO5TzVwy3UcWY2cZrjLhtniUG4y+euQ8iSd0R7jGZa93/V/kg519r297ZWZErjiBp9BdMNoAl1ghM73fFg/syO4Et+OIAtOBxF+QgUZCpANUMQyj/45iqiSQ1aGpozRwmJ6Y4+4q/royOYsjJ3RjqkM4UO+zOa6I+tuiocpOJEodEQeBS5r52Oot5+xbQEvH38OPxkRtJ9/C4/wtCEcw+4bVtmcBGSn+MPkmW5BRDzgtFJzxiiDW6BQKIHulHQAiNJaTK+6KnFA4R7IvDCLmmf9/PfUOGQt1EDCi/CAJA7RFD39gWUtp2dVnvcNUnYc2V0FD6hOP7YT0Atfi5tx3aJOjQ3V5RnFWKhtIBIAde12vRdvwr98J0WScVjefSxa5DpV7O/h2oKbVXspCRkZkZp0AdCW0ZUXlGeIisejO6jy4BPuxrmriHXX3OgOndh5DKZOkrgrhTKnQ5JTjw8aV/eicrGgLRBXr8yYBUA+hK1zkgtTQsc7bDdoPlJgT0yeqoYX57cDYjGZPYWuovECsvnzvI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB6837.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(22082099003)(18002099003)(6133799003)(261009223027099003)(3023799007)(4143699003)(11063799006)(56012099006)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021121427099003)(261022105027099003)(261022075727099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t0uBofqFkD76eTIM6NnBidWi+OtTgMW9O7bNjuOPaaXfPwVrlK0d28qroBzR?=
 =?us-ascii?Q?u4ibkrOOdM6XaAH4SjrYIMnZvWiCheBx/qlW41QCG5VFOdhnFwQqGsHu0gdv?=
 =?us-ascii?Q?apAvYGGMvPlwkrz5w4Yn+SWsorCPmfkfEO1bzHsMaWKOwozE9WeS2v/fk9as?=
 =?us-ascii?Q?MumOoED82KykYxmPFTwc3fouQsm0l8ExKk1z9v4wTJ+w+r+8sOLZrPLRbOuK?=
 =?us-ascii?Q?1eOONzrUyPKfNp1atUAHwqnssJ9wk92ZPHpUvLBJ8Gfas9Wyy2CnGGhdRNwp?=
 =?us-ascii?Q?EZ+4BZtUJlnFhGs8Ru7TrYQMjhiC6NRtNJOpz7XP+U+yHwHf3pVHfrYD4L1U?=
 =?us-ascii?Q?MqYekIcLoq+Uq/WiaTEO8+PhbIG5ttioQQBFdnJSBHs0rhzwdEYojb1K5RUJ?=
 =?us-ascii?Q?JqPgcMNbqZF8asmeFA6dpdHSf54HUyt7sMMhTfYCDfGVgKqn70AmPw99R6dW?=
 =?us-ascii?Q?LjILlJ/wyNpJO1QgeowMziMCzootBvM1oLcA6q6x1yI9Pqe1IX8l/4+ZPZTy?=
 =?us-ascii?Q?ki6HxVKHzeRBB7+Xn11zgetnSo2effPv1VGrhf/4/IY+DKxLaSAOdiZfXw4X?=
 =?us-ascii?Q?3n7sPBzmt8xZ9I00dkohMluRFopkTStnbfw+ef31DikuB5Yc+5OQJYFrr3hx?=
 =?us-ascii?Q?aiuWnyDnQspj0GyWw8eFGooEERU+X8W8qHd/u/wETvJmnPev7BARTB8aJz04?=
 =?us-ascii?Q?a8jYWynLgkRPu78bFJzBtXpfvtBeTEKheBfZQXlB8uJqAybvvl+SOEi1VYis?=
 =?us-ascii?Q?O+Wc0wvHeLqo/vMu/JKS5uQfbuMwFgzHROleRAQihiRTjnyHmf0yrUjFooc1?=
 =?us-ascii?Q?PpeOZ4ugzCQ+svihhyhynVpfpgL1DB7p1RAVOP7XBOUdmF5gRT1W+HUEYBQq?=
 =?us-ascii?Q?4syfF/v4aJXilT39O2jnVEwV/c4fjoYOmGiUtLVezmhibBSimfPMKECVX2Xp?=
 =?us-ascii?Q?P7YFS1cDl6mWGt6Am1E9gIMNasMu6Mn4xsc59O1TZX995Y0BeeYA8RUOqGSN?=
 =?us-ascii?Q?7qorMwnPON1Rbkxprlf9OrweyCriQ5cyiHoaJ7DWkFcPuOYQx8GH10mYfNo5?=
 =?us-ascii?Q?1sn42OJrqMBNKaGM65C+CThP/NzS7VRr19UQlEs4b10kGC0NlUHv5i0K3gKF?=
 =?us-ascii?Q?zidZWaL7J6Tx9gI17kCnNV/z1iiwTsHiDwBqAaYcLDdjECzvRk8GlPXIzf5h?=
 =?us-ascii?Q?myEIinU1gj2NvISsiAxHEtskBHdutsmR3SgaWrs6kFmt53r2n2KJ0uHNxx0/?=
 =?us-ascii?Q?qJZ9Pk+nfutPuaLyp7jbRMMUaUMsVxuacwc6MnpE8x4vST2sMBDDYu8kaVqa?=
 =?us-ascii?Q?qWKqCvPmHbHt4xM3AWfcL7D1QTn807JcAAsRkiU6I/4GcRZ+mqQ286g2voo8?=
 =?us-ascii?Q?Iy6rwcyEM87rJvOF3g9yMVc9Aexq4q++ooTc1lx64KYN24RTYfqwHbSiUWpq?=
 =?us-ascii?Q?ndD6t2ry4MCiy9YZKnYtjIZb8T1MeMnGrtmWzXh5xn/LLbfO9iWLrLQ1WOmt?=
 =?us-ascii?Q?5Zi5X3qzQ2xPVjuxMIstKceRqCnM9pkB/OlzSaEz4E+kn//MuVGAaReQBDqX?=
 =?us-ascii?Q?dPEEpkzuoeGeXUDyZ1+x0P/5XKLuiLXwztE2NeZV7LKTFwxSs3ETjFTjzxuc?=
 =?us-ascii?Q?ADoQ2oRxc7NUVpqVQD9mT/m9lxjOHQSi4gckTp/RLgTp/lOIgjvpXNc1Whf1?=
 =?us-ascii?Q?oaj/bXSBLWma3OGTkNj2NMmIbWoK3XNrMVlTfdGbwhs5dlrrntKdze/3YsG7?=
 =?us-ascii?Q?WgQnpMmWrA=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46dd0de8-985c-4e70-105c-08df43f578f8
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB6837.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 15:22:49.0537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DhI73sCTSnv6bT07eu4fGOmgZ+AC5iLXr92EYz7Z1HrTfs9v1obybZYaLM7eIRdeOJdXttMQwpI7WhOicFLjWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT6PR12MB932818

On Tue, Nov 10, 2026 at 04:08:09AM +0000, Samiullah Khawaja wrote:
> Add iommupt ops for preservation, unpreservation and restoration of iommu
> page tables for liveupdate. Use the existing page walker to preserve the
> ioptdesc of the top_table and the lower tables.
> 
> Preserve top_level, VASZ and FEAT Sign Extended to restore the domain in
> the next kernel. On restore, the domain has only the preserved features
> enabled and all the other features are zeroed. This is ok since the
> restored domain is made immutable and can only be freed. A kunit test is
> added to verify that the IOMMU domain free can be done with trimmed
> features.
> 
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Ankit Soni <Ankit.Soni@amd.com>

> ---
>  drivers/iommu/generic_pt/iommu_pt.h       | 155 ++++++++++++++++++++++
>  drivers/iommu/generic_pt/kunit_iommu_pt.h |  30 +++++
>  include/linux/generic_pt/iommu.h          |  30 +++++
>  3 files changed, 215 insertions(+)
> 
> diff --git a/drivers/iommu/generic_pt/iommu_pt.h b/drivers/iommu/generic_pt/iommu_pt.h
> index 837d835e4fad..b50dc94231f8 100644
> --- a/drivers/iommu/generic_pt/iommu_pt.h
> +++ b/drivers/iommu/generic_pt/iommu_pt.h
> @@ -16,6 +16,7 @@
>  #include "../iommu-pages.h"
>  #include <linux/cleanup.h>
>  #include <linux/dma-mapping.h>
> +#include <linux/iommu-liveupdate.h>
>  
>  enum {
>  	SW_BIT_CACHE_FLUSH_DONE = 0,
> @@ -991,6 +992,155 @@ static int NS(map_range)(struct pt_iommu *iommu_table, dma_addr_t iova,
>  	return ret;
>  }
>  
> +#ifdef CONFIG_IOMMU_LIVEUPDATE
> +static void NS(unpreserve)(struct pt_iommu *iommu_table, struct iommu_domain_ser *ser)
> +{
> +	struct pt_common *common = common_from_iommu(iommu_table);
> +	struct pt_range range = pt_all_range(common);
> +	struct pt_iommu_collect_args collect = {
> +		.pending.free_list = IOMMU_PAGES_LIST_INIT(
> +			collect.pending.free_list),
> +	};
> +
> +	iommu_pages_list_add(&collect.pending.free_list, range.top_table);
> +
> +	/*
> +	 * pt_walk_range() will never fail as check_mapped is not set in the
> +	 * collect args.
> +	 */
> +	pt_walk_range(&range, __collect_tables, &collect);
> +
> +	iommu_unpreserve_pages_list(&collect.pending.free_list);
> +}
> +
> +static int NS(preserve)(struct pt_iommu *iommu_table, struct iommu_domain_ser *ser)
> +{
> +	struct pt_common *common = common_from_iommu(iommu_table);
> +	struct pt_range range = pt_all_range(common);
> +	struct pt_iommu_collect_args collect = {
> +		.pending.free_list = IOMMU_PAGES_LIST_INIT(
> +			collect.pending.free_list),
> +	};
> +	int ret;
> +
> +	iommu_pages_list_add(&collect.pending.free_list, range.top_table);
> +
> +	/*
> +	 * pt_walk_range() will never fail as check_mapped is not set in the
> +	 * collect args.
> +	 */
> +	pt_walk_range(&range, __collect_tables, &collect);
> +
> +	ret = iommu_preserve_pages_list(&collect.pending.free_list);
> +	if (ret)
> +		return ret;
> +
> +	ser->top_table_phys = virt_to_phys(range.top_table);
> +	ser->top_level = range.top_level;
> +
> +	/*
> +	 * VASZ and SIGN_EXTEND will be needed in next kernel for collector page
> +	 * table walk to restore and free pages.
> +	 *
> +	 * Use the max_vasz_lg2 from range, as that is the current one if
> +	 * DYNAMIC_TOP is supported.
> +	 */
> +	ser->max_vasz_lg2 = range.max_vasz_lg2;
> +	ser->sign_extend = pt_feature(common, PT_FEAT_SIGN_EXTEND);
> +
> +	return 0;
> +}
> +
> +static int __restore_tables(struct pt_range *range, void *arg,
> +			    unsigned int level, struct pt_table_p *table)
> +{
> +	struct pt_state pts = pt_init(range, level, table);
> +	int ret;
> +
> +	if (!pt_can_have_table(&pts))
> +		return 0;
> +
> +	for_each_pt_level_entry(&pts) {
> +		if (pts.type == PT_ENTRY_TABLE) {
> +			iommu_restore_pages(virt_to_phys(pts.table_lower));
> +
> +			/*
> +			 * pt_descend can only fail if pts.table_lower is not
> +			 * init. So the if statement below is dead code.
> +			 */
> +			ret = pt_descend(&pts, arg, __restore_tables);
> +			if (ret)
> +				return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static void NS(deinit)(struct pt_iommu *iommu_table);
> +static const struct pt_iommu_ops NS(ops_immutable) = {
> +	.deinit = NS(deinit),
> +};
> +
> +static int NS(restore)(struct pt_iommu *iommu_table, struct iommu_domain_ser *ser)
> +{
> +	struct pt_common *common = common_from_iommu(iommu_table);
> +	struct pt_range range;
> +
> +	if (ser->max_vasz_lg2 > common->max_vasz_lg2 ||
> +	    ser->top_level > PT_MAX_TOP_LEVEL)
> +		return -EINVAL;
> +
> +	/*
> +	 * Override the max_vasz_lg2 here to the one calculated using top_range
> +	 * in previous kernel. This makes sure that any later page walks use the
> +	 * clamped max_vasz_lg2 instead of using the full hardware maximum
> +	 * max_vasz_lg2.
> +	 */
> +	common->max_vasz_lg2 = ser->max_vasz_lg2;
> +
> +	/*
> +	 * Restored page tables are strictly transient and only permitted to be
> +	 * destroyed via deinit() op. Because we only preserve user-assigned
> +	 * devices utilizing pass-through frameworks (VFIO / IOMMUFD), any
> +	 * concurrent or subsequent map/unmap operations on a restored domain
> +	 * are explicitly blocked at the subsystem boundary (e.g., via IOAS
> +	 * immutability).
> +	 */
> +	iommu_table->ops = &NS(ops_immutable);
> +
> +	/*
> +	 * It is safe to override this here since this domain is immutable and
> +	 * can only be freed. This also means that for non-coherent pages DMA
> +	 * mappings will not be created using the DMA API.
> +	 *
> +	 * Note that the FMT specific bits are not cleared as they might be
> +	 * set/preserved/restored by the driver to handle special cases that are
> +	 * required for page walks.
> +	 */
> +	common->features &= ~GENMASK(PT_FEAT_FMT_START - 1, 0);
> +	if (ser->sign_extend)
> +		common->features |= BIT(PT_FEAT_SIGN_EXTEND);
> +
> +	range = pt_all_range(common);
> +	iommu_restore_pages(ser->top_table_phys);
> +
> +	/*
> +	 * The old top_table can be freed here as it is not used for any IOMMU
> +	 * mappings yet, because the restore happens during device probe.
> +	 */
> +	iommu_pages_free_incoherent(range.top_table,
> +				    iommu_table->iommu_device);
> +
> +	/* Set the restored top table */
> +	pt_top_set(common, phys_to_virt(ser->top_table_phys), ser->top_level);
> +
> +	/* Restore all pages*/
> +	range = pt_all_range(common);
> +	return pt_walk_range(&range, __restore_tables, NULL);
> +}
> +#endif
> +
>  struct pt_unmap_args {
>  	struct iommupt_pending_gather pending;
>  	pt_vaddr_t unmapped;
> @@ -1174,6 +1324,11 @@ static const struct pt_iommu_ops NS(ops) = {
>  #endif
>  	.get_info = NS(get_info),
>  	.deinit = NS(deinit),
> +#ifdef CONFIG_IOMMU_LIVEUPDATE
> +	.preserve = NS(preserve),
> +	.unpreserve = NS(unpreserve),
> +	.restore = NS(restore),
> +#endif
>  };
>  
>  static int pt_init_common(struct pt_common *common)
> diff --git a/drivers/iommu/generic_pt/kunit_iommu_pt.h b/drivers/iommu/generic_pt/kunit_iommu_pt.h
> index 9fc71db74234..7306de44eb00 100644
> --- a/drivers/iommu/generic_pt/kunit_iommu_pt.h
> +++ b/drivers/iommu/generic_pt/kunit_iommu_pt.h
> @@ -427,6 +427,35 @@ static void test_mixed(struct kunit *test)
>  	check_iova(test, start, oa, len);
>  }
>  
> +static void test_restore_free(struct kunit *test)
> +{
> +	struct kunit_iommu_priv *priv = test->priv;
> +	struct pt_range top_range = pt_top_range(priv->common);
> +	u64 start = 0x3fe400ULL << 12;
> +	u64 end = 0x4c0600ULL << 12;
> +	pt_vaddr_t len = end - start;
> +
> +	if (top_range.last_va <= start || sizeof(unsigned long) == 4)
> +		kunit_skip(test, "range is too small");
> +	if ((priv->safe_pgsize_bitmap & GENMASK(30, 21)) != (BIT(30) | BIT(21)))
> +		kunit_skip(test, "incompatible psize");
> +
> +	/* Map a large mixed range to populate multiple levels of page tables */
> +	do_map(test, start, start, len);
> +
> +	/*
> +	 * Simulate a restored state by clearing all features except SIGN_EXTEND
> +	 * and DMA_INCOHERENT. This verifies that the generic page table free
> +	 * walker can correctly tear down a populated domain when other features
> +	 * are zeroed. Also set max_vasz_lg2 as done by the actual restore()
> +	 * function.
> +	 */
> +	priv->common->features &= (BIT(PT_FEAT_SIGN_EXTEND) | BIT(PT_FEAT_DMA_INCOHERENT));
> +	priv->common->max_vasz_lg2 = top_range.max_vasz_lg2;
> +
> +	/* The domain will be freed when the test exits. */
> +}
> +
>  static struct kunit_case iommu_test_cases[] = {
>  	KUNIT_CASE_FMT(test_increase_level),
>  	KUNIT_CASE_FMT(test_map_simple),
> @@ -435,6 +464,7 @@ static struct kunit_case iommu_test_cases[] = {
>  	KUNIT_CASE_FMT(test_random_map),
>  	KUNIT_CASE_FMT(test_pgsize_boundary),
>  	KUNIT_CASE_FMT(test_mixed),
> +	KUNIT_CASE_FMT(test_restore_free),
>  	{},
>  };
>  
> diff --git a/include/linux/generic_pt/iommu.h b/include/linux/generic_pt/iommu.h
> index 13ebb72a67de..617fb9af6bef 100644
> --- a/include/linux/generic_pt/iommu.h
> +++ b/include/linux/generic_pt/iommu.h
> @@ -13,6 +13,7 @@ struct iommu_iotlb_gather;
>  struct pt_iommu_ops;
>  struct pt_iommu_driver_ops;
>  struct iommu_dirty_bitmap;
> +struct iommu_domain_ser;
>  
>  /**
>   * DOC: IOMMU Radix Page Table
> @@ -166,6 +167,35 @@ struct pt_iommu_ops {
>  	 * table from all HW access and all caches.
>  	 */
>  	void (*deinit)(struct pt_iommu *iommu_table);
> +
> +	/**
> +	 * @preserve: Preserve the iommu page table for liveupdate
> +	 * @iommu_table: Table to preserve
> +	 * @ser: Serialization struct to fill with preserved state
> +	 *
> +	 * Preserve iommu page table and the relevant state for liveupdate. The
> +	 * caller must make sure that the page table is not updated during and
> +	 * after preservation.
> +	 */
> +	int (*preserve)(struct pt_iommu *iommu_table, struct iommu_domain_ser *ser);
> +
> +	/**
> +	 * @unpreserve: Unpreserve the iommu page table
> +	 * @iommu_table: Table to unpreserve
> +	 * @ser: Serialization struct that contains preserved state
> +	 */
> +	void (*unpreserve)(struct pt_iommu *iommu_table, struct iommu_domain_ser *ser);
> +
> +	/**
> +	 * @restore: Restore the iommu page table after liveupdate
> +	 * @iommu_table: Table to restore the state into
> +	 * @ser: Serialization struct that contains preserved state
> +	 *
> +	 * The iommu_table is back filled with the restored state that was
> +	 * preserved in the serialization struct.
> +	 */
> +	int (*restore)(struct pt_iommu *iommu_table, struct iommu_domain_ser *ser);
> +
>  };
>  
>  /**
> -- 
> 2.56.0.506.g506a7eabc5-goog
> 
