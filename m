Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010027.outbound.protection.outlook.com [40.93.198.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3ADC27702E
	for <iommu@lists.linux.dev>; Tue, 16 Sep 2025 18:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758048571; cv=fail; b=hh90NO1N+6fTuj7BD8bCTcMQ8oNnMgEGifMePwzdkJgZ4VAHSOwjjvdxO9U7y/LCFqq5KBplp9Oc4KsqCBYwYASYB09nxdQdk0brWJ8okE3EHuc8YcNvfLRMHtK0JYNk5SsH9431MbHSMjPwMCDoGDctathjHsFymgKCnkrwTas=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758048571; c=relaxed/simple;
	bh=0RHUGGgMUu/xMTow+K6xLO2oWaWjWKFxCWOvCGDb71g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=t+hpIKGXSWT6mwXXF/KuxxE5GpOtjfWZAiKKOxpvqHxXKfis+OKwbILQHAH9sRUEE5QTuThFdGup+n5Emd5+9P9wbXJgTiNNZ1u9mgS15jfbERqbztgP2SHHeiRJAEmnmVhkaiuf694JJHvLw/OwLQshXO9ocZFNtbr38zMdQrQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZZFmQruQ; arc=fail smtp.client-ip=40.93.198.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZZFmQruQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kWW1ZNA/EeZ3BJ5ZuwJUN+9HNmCYJRJlJwR3FjOxlens6Tf/sKQs4IEaKHqM6dwnhNYC7JC4HmwTevHrR57mQd5x1BPDZsGcUf74bAMzwvW69Hn9i7pw/J02ohDFNs5bD+nSIXY5ShWvQWCVZ6OGePKEmO7eJLwUkUv0q/TAxaWoXujxpC1YX4tqPBq8OYikl1Gz/Ik67Gbc4vQccK2z3GaOh3dOIteanRxfB9yGc+PkhrEW4NWh+JKa+35K/IgB/Tkj0PU3Gtd0oRtlEMEvu0nPj+x1qn7yAdQJ1WxjLUUOkt+mUgPMuvHEW629upIb4XS2owQ5ZtPTPf3X8htzWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ku/LKKQQfQEavExraf3qmZ9yVNJv2mD+vtJUjdHeWxE=;
 b=p2qk4npFSWLUV8AridcB3NQy3ejfJnwiOTmUoF0Iym73QG4K1Ua/2zoOEBqtlSZ14RtrucO93s9JNcYwf+nOLXnGveozjZFu5BEebcxHF0jVrCwJASPQzFLGsyXjj+XaO2SycSDFHqDhkxzXNZpwjO6I7cZaW0QAArML/MUbN73KT2CsciNBgBRJYkschZgTUD/TWtTRsGlFzJlcAFqgDGJtbe4qI4VuNPyMnIEhETvsFUPBHG8L+NOF3XEY88bRLxQDoDZroqJJnFEhoDuTl0rXAnWtJORzR2q8+iSrjRqhmJpsFGKmfmUMgTN+ELSebOXklf3VMxFd2nARx0gBTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ku/LKKQQfQEavExraf3qmZ9yVNJv2mD+vtJUjdHeWxE=;
 b=ZZFmQruQEPCQgQv+//8QBwiefeQpZk63wCMhq/Nj/NQ7/7/S9tijtsMEGbHDUznVmBeLm3jQHnRkz81C4s1k+zoWGO6gilv0UbXzvo1L7mMfd7LSumysNRvsxQ4eeezCdN2vCSoasd0atKQVSU6Opq3JQtIqFjSc2umkUz5t2ZD3ahvLAj8qq7ca9VICHgIDYojKPp0sjGbfJ9MdKtVNGx2A87pips0VAtgItEP2AZqvAPPgXYUmi6CjXRcFj2PSzObm9z4TsTwnf21Z21YaX0cofwGZkYEgy8N1/UD1sG5PCKxPrNilGUdjuLEn/0nX+RjBhDEgOeD/QVnKN7GG3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by CY8PR12MB7196.namprd12.prod.outlook.com (2603:10b6:930:58::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.23; Tue, 16 Sep
 2025 18:49:25 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9115.022; Tue, 16 Sep 2025
 18:49:25 +0000
Date: Tue, 16 Sep 2025 15:49:23 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Leon Romanovsky <leonro@nvidia.com>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH v3 4/4] dma-mapping: remove unused mapping resource
 callbacks
Message-ID: <20250916184923.GX1086830@nvidia.com>
References: <cover.1758006942.git.leon@kernel.org>
 <087c29da71fb41245b8c03f641f53d624be10d59.1758006942.git.leon@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <087c29da71fb41245b8c03f641f53d624be10d59.1758006942.git.leon@kernel.org>
X-ClientProxiedBy: SA0PR11CA0146.namprd11.prod.outlook.com
 (2603:10b6:806:131::31) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|CY8PR12MB7196:EE_
X-MS-Office365-Filtering-Correlation-Id: b5e00390-4bf7-4083-18d6-08ddf551c21a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fKiQdzI2iciI8vLbidUQ8PcE+Oq7GIXsOPXM1PvoHqZhTgDhDvDwnhdqL/k/?=
 =?us-ascii?Q?5HfsxkQD//NR6ouNZLnisgLCKGhd8ioTminWsPdSqA0x3dvubpaPyu/LsHIH?=
 =?us-ascii?Q?IZENgDydgVesktjfoRZvjuqXFgVP5GaRBZ0yCJr4UHBjlgDFPBfo6/+G64Mn?=
 =?us-ascii?Q?k+FjS7CInGWK+0HbdMbD+fqjsfpZwx/8mYy/Qy5K8qgQ5jyRn2FFyoqaRCcG?=
 =?us-ascii?Q?ldcJKLy4DopFXAUMB91bQYlz0lDbdfpFLPQ904bbe8xRadTAu1xlb3K1WTxs?=
 =?us-ascii?Q?VxYOdgy06Y3gjVXpvcxO5n7lDsR0AB0OpDzMPNW8NcDg8oPe++19FPx5N37B?=
 =?us-ascii?Q?3sz8naE8mQbgV3qtgnpX7W4CtDJxYlNFv0kpipbuolRAdEmZrfsLH8vc9dSm?=
 =?us-ascii?Q?23SVBOtAeojfqgbylxTx0yMc3mR1tn+k5REs2tGdzpU85ih1Uuwpnc1Nvl7F?=
 =?us-ascii?Q?M6uAPxnZGNYL+3NX+mnbrs/SISISF767+IswGDNC/rHsCWwfyeGh7A8S+OQ1?=
 =?us-ascii?Q?8r+z+dlp65ECVaLp9WqnPq5NDQmatfR+c1D1ft6iyUzAqI633TDSJiqGycHV?=
 =?us-ascii?Q?IMka0Y3R/jHc0K7NiGKh64HHao7pt9yZcGXrgmZBFt4iiLKt+EVWbgR+T0uy?=
 =?us-ascii?Q?L9AlvZMlbCYIYosp4ZrPCZ70PwKdiSwroX9lUlDq+dkBxDMvSzQTDXrfK53w?=
 =?us-ascii?Q?HrGU2ar/ljLsRNofTTzYATMyQAt9OHjyrtKoxoqmyj+p7JO0ZMtLTU33g20G?=
 =?us-ascii?Q?KDwFR10N26mcGP5FWKmWs5bqZvJxeKtN5WFJx1cqkvj4OFIFs+ihU0oFXJA2?=
 =?us-ascii?Q?Y5z5iXst59Puvv7CgHhQoDUtmnOJ1PWqPYjSivAd40dtG/l9Mn8jGY0VpocP?=
 =?us-ascii?Q?Pw5lkTYFnQhDdbsH+q0DhYnKRzX83WZphcmWcukIM9lxL/2+P+e312O/8nAU?=
 =?us-ascii?Q?qBAn1gWDr9ipgND4maLKAGcrezPOt10MFz8Fc3F/CZl3bq4lHeB925boMntq?=
 =?us-ascii?Q?EfE2bpYESwXtNYqKOJLzxYRd6PQ2aN1BbSRVvQnE/CxrMmKlD7/j7xAhw3pl?=
 =?us-ascii?Q?zJhqBUogSIsih3UgoaevfgoBwCvw7HU37gHyRXakrIdqM/nTntSU/CA3+8PP?=
 =?us-ascii?Q?XC8JssGGBMdYkFO9/1YeirOt0+GdQwAOWu0FksiQ4Il1DTPsdGjvkNcgCx80?=
 =?us-ascii?Q?2acSZ79gRp1BWxpL5sVGq+NKgpJG/jiML6/JudSZ8U/Ss6qIAxVSZwPlIRxm?=
 =?us-ascii?Q?YVuFGDw26ePNfNrVvCh7R2oJP8QtWUPcGZllcuN1oivxB2pZHMwHiE7qKdil?=
 =?us-ascii?Q?K2mbE2YXVHTX87x9UlM757Nj5VK4KRBlgGwG+EFQ5CqFUhqX/uUuHdqOLseI?=
 =?us-ascii?Q?jLmwgYNm5qUNdwk40hC/hOjLw37s8+zt/qALLm2RFn5LNJQswHeUwMGjMIV1?=
 =?us-ascii?Q?kM1bVsjHC10=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tV+xrkipnzKk+IlkDo5vf2MtLZIxa3ouSpYh0NAppe6v1KzgenW7elEur+fO?=
 =?us-ascii?Q?dfK+t/JDmM7f0MVk3GNXdq5rr7OXr5fcI1Vj0ZkYS8bNYl4krUG723IOsr/+?=
 =?us-ascii?Q?aHkjcq3TyaitzQ/JUd6qBmTBr/bxbMM9r9Abun95MtjxnRhQvjcDzRmLqNB1?=
 =?us-ascii?Q?gTKx18KrIzymkP0fqNKDHwd/tlylExnAPwdXh9bbu428rTZ2J5fBoVDjcr3G?=
 =?us-ascii?Q?9/MD8gh4P0EvO3GcGrlQpthO7LvzFbChzQsHimjtsZIqUbqCeJ8DJQ3d4Vy3?=
 =?us-ascii?Q?cRC23T3/ORIMppiCSe1KSigCsiJDUdlYI6vQI4V5NHhXKWvGJAtJtQA+BjnT?=
 =?us-ascii?Q?MMMz9zGfbIo2lqj03REv4KkEdsn3Vaa9xTwe5YI81LfqlN1f7vWwkvhPqv99?=
 =?us-ascii?Q?cAUaOrVtlZhvCBtRZ0cBdsfxTvf0yTjtw+sr72gjgISGnnTbB8dYh5kaJYvC?=
 =?us-ascii?Q?p7ZmjUUL76um8C/oXFGDvJ92HuTxVgZJvqg4asYNkqGCZVIKfolWWRbGztau?=
 =?us-ascii?Q?wR2vix1eGNzCbL6xLzwRjPhNKQNObrZlc0J88o+1r/JsSsBhG8HQhFyto46D?=
 =?us-ascii?Q?LcjrjyZwExe9Qt1SyzbIr/yFUANaJ4qkuiWkLTp70qneE6TJS6zQ5oB0o0Ac?=
 =?us-ascii?Q?id1OIBfjKK6cT2Ue8hPXbz8k4xcg6C77qW98T89Kveov/+lwYz7BH3XN3hUm?=
 =?us-ascii?Q?aYQzBnWoZ2X62giWhwsJ4q/tqoRAFBI62ZnwrNChwF3EVEvlDnrzF8nHpwYO?=
 =?us-ascii?Q?TFg5QQ2PFjfNEO49BlIn9Bu1SZJOVa4WSHbtpyU4GFyf/RIq2UVykgASp1rQ?=
 =?us-ascii?Q?UY3kJiDPTQmt75bokdhV1z/PVl669JdHuf1g1RySbYDaVUgpQLZ+QvZLqNcW?=
 =?us-ascii?Q?bRMALsNIFfSdkmDpUryM6kGWmgePhrOAziMRXniW+lSExMjGLhzFXd7u1w1N?=
 =?us-ascii?Q?D/SZAcR/WPDavYHp7wvCyPGAHj2TotskzpzB40e391aBvGJH865jpiLFW4Ot?=
 =?us-ascii?Q?MOclz4sbRmcwYTZpXRanNv3pEKkZ+QfZ70NoI9SghJPMhpiv/YJHyfUoajEa?=
 =?us-ascii?Q?N5a0VRYceIpobsz15EuhJmNFK56uF+VrEzpBqcL4xR5j6CZ0ibrcaqvavucP?=
 =?us-ascii?Q?OSGyGh9TQ7bIpW9OQdT+gugy2LlEKg/N3cyOrA0aCrfhDdjgE6PboaXU8sEA?=
 =?us-ascii?Q?X5XICiIWOVIyyX/ndbP+iOcX+oRXySwnp5fW7AAOARHY7lDBQNewgVaC7Fg6?=
 =?us-ascii?Q?5MIrrWhXwZx9W8so7Vpi0O1wN2heay9DWO0QSdu0kX6sVmKZEV3OCkVO60Cj?=
 =?us-ascii?Q?DkqWr4Srh1Ee83MYuPxgtuzaW6hZkgqXTe9PSh2vMmstmYm2LDrTFB5kHXYK?=
 =?us-ascii?Q?8qNXg5bTRiFUIEeOdfjiEgtmMR83nQxqzPpJW6MF2Qsrhg3mFoLBGYxeLM9x?=
 =?us-ascii?Q?vcQCmDNZjq5edfdNzcy0zWmli2kmj8fEQXybMPtnHPY3Ri0qhS/5mfIslx3Y?=
 =?us-ascii?Q?lz7+8mSXXYcokuVy3l+oh4DyA0exjFNMhBA6ytc6iL44JGvG0OE5fZxSkym5?=
 =?us-ascii?Q?chPXMloCsRlvWhifSwmVRsEd4XalXU99rFb7Rv6m?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5e00390-4bf7-4083-18d6-08ddf551c21a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 18:49:25.6205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JJOq1elhzSyKDj+n5FqwobWD5IQx5Be8BsyXYT8dbv9IEpD6IseBUyc8l3Xod9iE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7196

On Tue, Sep 16, 2025 at 10:32:07AM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> After ARM conversion to use physical addresses for the mapping,
> there is no in-kernel users for map_resource/unmap_resource callbacks,
> so remove it.
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  include/linux/dma-map-ops.h |  6 ------
>  kernel/dma/mapping.c        | 16 ++++------------
>  2 files changed, 4 insertions(+), 18 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Looks like xen_swiotlb_dma_ops will be easy enough to fix..

Jason
