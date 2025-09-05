Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2076.outbound.protection.outlook.com [40.107.212.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947F02741C0
	for <iommu@lists.linux.dev>; Fri,  5 Sep 2025 18:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757097686; cv=fail; b=G0r5vSXw7tlZkQ90xgse9xGcH9DKdk9cbQh5GL3wnM3BTZebg6UxF/nHoOrefxQhvaWmvfZZMwKEjjbxJAlDC4QCAHC1QKxhC4dLFijhsZoOwwoGXTjtx2PTqpHIR2CMhAQKiibb6ERg/Jya0ESdjoHdQu8aM8oE4AR7aCgk8gI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757097686; c=relaxed/simple;
	bh=+64zTzuKAafk1SA9f6aZExD6S6123glxPaqMecFzs0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y0jC2U5xBXzz306AB3wPHThLFwHpigB9bnX2PmBvR8m7+NZb/QYCDQB/OFU+sUdCNum9smGtr3GT4rFxkZG6EqLcOG/FTsla2lrmi34G7GiDZgqsj4tIPkpzjl1dxsuUefLkBNiQCWb07ntDktt8P9j0ZGgrdi9DHb00Z6zxCjE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nbq8k0oR; arc=fail smtp.client-ip=40.107.212.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nbq8k0oR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HgkPz2jpAOPSYs+YVJG8k83wekvhsknqadFqMElcqQdnFv71IixHVnrNO4U4gaBeKpraag5HB9pUx9+bRzSC4AB9MZXU1fFCI/Jt4mSF+Zwn7flkn4HdsO43FE+aki4q0HxQSvKapjqdDDvXbxt9fYwX6326Q60hfRvanx2FQhBTfQJtN821sgE0iU4DmSvWGJSYu5Y3lt+Xfuepc92g8uIs6DuclJcAm5qPYRmydmPYLAPyHYmkBeOKNtW5MTbYR4EJOplHTZSvvSueDDlRBmWUOgf5xKpct3rwz/QveddyUP5WIzY+IcXliUqNoVtA1oHv6HKuW/HMLkfA6r1T9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a35ze31BLvA34ZOFH5iyc91LQjAUvIl5nj4ELqkD2NA=;
 b=vX5VSvAKdiaQzg+PUfLgxC7R59tU4lTirKPoKXeXeligc4GEVL399wkyNK0HA4RrppYDrmRNK+r8cgVH8XoGy3OwJpT6+MtxNmRWTQU7pAzVzv6D9453tAu/qJhBwPeuHeoKvVrybcGMn2yGMHI4ff2qSQ1ePOw4acmq/JWUv6BW1b7avpcl4QHE/8XAoCbJcje5YXfSvq0Ew+YzM8DKQBfjohaQ8cRx0XoZ87I0gxf5ejVdV8z7tsGMWBXWfWfRn9sBsVugtINKgLiCqUZu4oGzCuiUs1/6qgfWOAbfN2GZp0Bnwfg7HcT9ifmOzIsweHzczPbO3TUUcfuYouiHEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a35ze31BLvA34ZOFH5iyc91LQjAUvIl5nj4ELqkD2NA=;
 b=nbq8k0oRviJ/yp/dLaa0/asIcDkdNE6ndVdH0jq034E6kvPFc0xyAYlVuu4SBSKGpNJgdCeHJJj/yURLRimbVasE1fNd3JsDVGshxX0mpXaCzebuN/FtxQqjliLXvrmFJiXoNNuCx+W1wXFr5eocWYmlIo4cPDfAm3aofg59eSSZpeaed0W9GmtznwYjMVh24WQbLEDDcGhdj0oeHmsNPAlc4qfG6qy9/JUWzneZXTuDyp60/37OjJx4FRylJZstn39iWIn6Vn+L9ZoE2F3fNyVRs4JHYrNEDLXXuA3KeLO2VGb7PJrawFDfTN9hpwwcAVS5avroD8qKxkIFuSwQZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by CH3PR12MB9195.namprd12.prod.outlook.com (2603:10b6:610:1a3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Fri, 5 Sep
 2025 18:41:17 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9094.017; Fri, 5 Sep 2025
 18:41:17 +0000
Date: Fri, 5 Sep 2025 15:41:15 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Jann Horn <jannh@google.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Dave Hansen <dave.hansen@intel.com>,
	Alistair Popple <apopple@nvidia.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Andy Lutomirski <luto@kernel.org>, Yi Lai <yi1.lai@intel.com>,
	iommu@lists.linux.dev, security@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 5/8] x86/mm: Use pagetable_free()
Message-ID: <20250905184115.GQ616306@nvidia.com>
References: <20250905055103.3821518-1-baolu.lu@linux.intel.com>
 <20250905055103.3821518-6-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905055103.3821518-6-baolu.lu@linux.intel.com>
X-ClientProxiedBy: YT4PR01CA0018.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::26) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|CH3PR12MB9195:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c6c0888-f4a1-4f74-25a7-08ddecabcc68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?R0aq2IMUQi29yiLHqMcwWv8JtWf1sCcADnxJui48HhrTd1krn3p4E/G+qCNE?=
 =?us-ascii?Q?kLi2HJ4XHz41QtskRF3J10X/maXKLYLU3o2tN3+FCWUlGaCDRs0nznAguAj4?=
 =?us-ascii?Q?VJDoJ3or/c5usp2GiF2Cw7VeThM+ss8wN/9cybgpNF+944DdNWuaplTJnpPx?=
 =?us-ascii?Q?M6Q/Z1HQvrLI9uqCHqCsfZczJxzUA0nG3J8KsLaouD78gNf5yzUa7Uh8tX0T?=
 =?us-ascii?Q?v9G4ytuGhd9f+T895ogx3LyFC/fAwm92Ug9myqjv0RS1/EVH87JGFHWCnVCp?=
 =?us-ascii?Q?TzEFJmqIA+LDGmJ84k32cCDdm9qUKjwaUSe8yo+9j6msdo4CnL6dJCFGEbzt?=
 =?us-ascii?Q?nxCne16tPkAuW79corAGjJurmnytaY1lNc/ENml3GfOyZYdyWC4cDBG3++/+?=
 =?us-ascii?Q?XM+oge+t+yan9Cm6iKwoMHpERnljLYJQNVnMrctWDNXTRYfkSq4cmHVsTqHJ?=
 =?us-ascii?Q?mpA8n6RU7wl06LfXk/6mnzcRB/Vb9Mp4G6wwSTYXApW0HH4YWmf06gbyACjZ?=
 =?us-ascii?Q?tGcsljCDnO/pRF3KlWrdYEKz2nGyhK45Yp3ogL5wEWJetxGmH6XsrXk4N2/X?=
 =?us-ascii?Q?4TAUC5M3aOyqHMdK2EHvP7Dpyer47XUNp5Pa9hfvT8GjOFI7DhJlQh1/Qm7T?=
 =?us-ascii?Q?p+/luCIID5fJCAae88PT+2zfZBO2W/DSNyNNIJ8dmCL7kKr6Sg/+N6iDguNM?=
 =?us-ascii?Q?lAx3xXFgltHTqd+WT4j+gqJfOTAPM35ViXLZvIAa8FTEBP0xmXR+ydq3rDrH?=
 =?us-ascii?Q?0HXnuJDBIaQB+VCre0nK0FCFXkzXvYfNyZBn1gqL2PA3Xv7dLs/WAsUQjssO?=
 =?us-ascii?Q?5/tIMx0ApYr0J+dWxYomHawdgLOrrbEB7lobPpqhUKk/SYiDp5857GJvdLnn?=
 =?us-ascii?Q?E+vzKKnQNECZ505suF/unkYYJwEOkCjDYU+LcB6WDmnQHRR3SOYFtnbgUq6c?=
 =?us-ascii?Q?fkymV3oNSUfp4h9aKZlSWxazyxqEcgI7/J9YfGzSXUcvf059kv4jv/hL3PPj?=
 =?us-ascii?Q?pzOOKVh5sqLOVBpWg8MjoWVY4NTbjplqQ/3Up1FnUUYSjl9G8JQXcDjOpDnW?=
 =?us-ascii?Q?oyl5By1Ge2+URL609gzpcDRTKJb15JtvKmWtv+bfMLer+ZuC1MQAEjsmlrsR?=
 =?us-ascii?Q?0xF7f8EppHawAeikiKGkawmkYW7jMZIWDjQM+d71ksxdR6Dh93GPgh1Pbtwb?=
 =?us-ascii?Q?DZ1y4GmtN4FTef0vhXYdyJiWHZDDDHy4cr+mgkQRiWxBDqgfNepednL9W7cp?=
 =?us-ascii?Q?iOHpFX6S4s6A3JM4V+V0basRRvFWNIS73VRWxX6+3U1K8ztdHS6LLEBLn7vu?=
 =?us-ascii?Q?QGKtNhm4BRQ7334FTkqN1zk9JBTwccFX3uWp/qqvkDKm6Ppa1W/HsOY6Gmpm?=
 =?us-ascii?Q?KemqXeURQPAsvKuHwcs80SPYMq7HZzM5MwNh8Tc5UFHQcp8Y8XVbVRiso9Ik?=
 =?us-ascii?Q?ev503VflC24=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?N0c5J5Zb+7rSARyczVXrNmj7QgurHcrdDJ7ppXeZCXpG5wqSjSbvKT7+kwf2?=
 =?us-ascii?Q?cde2ocwneLIB5LVBcPEMFI3pWrugQAr/Bj0xQpUF6Z0CZEd77Vj5gHFAbInk?=
 =?us-ascii?Q?q9U12obtjV3SBiYlg98yc0jEiCR6c6kmwDIYrfy8Xa7LJKNAwc/UgegW0dG4?=
 =?us-ascii?Q?WkIzOe6MSOUlo07L91dMo7wZktj4356mhTbO76POC+G0DPbP1pzT26d3YM1a?=
 =?us-ascii?Q?zlgAwKaiAZ4OKs7YJMzvD3gyZmcdSzzCJn0FWEnP/9rra6puGira8WiknCRT?=
 =?us-ascii?Q?vMXGmFn31L0Ipn67gVBwVHZjs5Q1yHls5pSl3WZTKK0tu0eWcq0rUZwY7G/f?=
 =?us-ascii?Q?lkK24WOXxUL99dHi8u4aiSEbCmNOnaJ5oqKgAqJmab0UiQu0SBJ1pgkkoKY3?=
 =?us-ascii?Q?LwfSNvAJpZA/og9qMm5g4E1Zzl6WX4E3POt/dBbvd/FYDEagGC5l+S1LUmtL?=
 =?us-ascii?Q?TmqE4lGdGyGl4t3F63ZF8owtK7hONS2qEGlx+WH1EVEci9QFIvknbmvIEUy6?=
 =?us-ascii?Q?PxACfzSbL7L7bYDlVMQiIqJaJ9KXKwJ47X1VWKUDw3b5cDx4KGl2bAh5BLba?=
 =?us-ascii?Q?Lhc3EG44HUc4ypqRztiaiRwThqe/f4hiSEhP6M/NGPex/V2IccKcwcTfviIQ?=
 =?us-ascii?Q?OoY0GSYV7m579rq2mIC3t18GS0sOOd5rCRppkhwr1CX+Xa0M108V+ynN1MCt?=
 =?us-ascii?Q?B9TE1TH6b9ETYNueZCm44bFLHySBl+DOW4Og/IyoSQGqEIU2FpmTQ0SQWVbM?=
 =?us-ascii?Q?+388fXKFo+e0zvLOEMcLLntxpNrwmeuY747LSLMpG+M9F1ejFm6IdomS2mTp?=
 =?us-ascii?Q?3HXf+VpYWQpEqJikhfz9KjXnBTwAZwqCOjRq3ro30Xoar861vAzYEQQcmmKZ?=
 =?us-ascii?Q?10i8Tql4SwX7dMjDL6ox0vUqaX6/HEiEVovQtHzlxuiVXkoGjZSmW97xwWPD?=
 =?us-ascii?Q?a89zuGVFQvYcS8G8SZ+aTZD//M4mseIuETmHe7PgFdcGQdZ1C1guNXZn4o2q?=
 =?us-ascii?Q?jHiTvgkVfdYC/GfACPga3pF2H9JAgnLX7yV+sD+PS9GTtlXETIum0pJE/BJD?=
 =?us-ascii?Q?87lO3/UoO0FTgB34ihhGkyXy3bmgk0DUgCJKZ8KMjLcGLToCo4eS+Ic4wlp4?=
 =?us-ascii?Q?+OIVN2fG4AJd0p24iFkJ0DT4Gb0XdBd7hJMFQPcBaAKLYV2uXC7z5M5762tU?=
 =?us-ascii?Q?tQbIKkwxWZs2Sg/BVJ2xT13T6xfTR/qIFv7CGiRPe9wy3XfRMEcE35xp+4V0?=
 =?us-ascii?Q?qAyZCpNQnP01hWjF/XbDwd70P//P/8fK1xyhf3KLP0neF66DApG1xn+ag2Gm?=
 =?us-ascii?Q?upryBRz0IWmemrwrWZBpheW6TLm0mgDHfQT/X3baz+T7tHE+hp/LFjwpuQiU?=
 =?us-ascii?Q?HqqpyGwKdNCtJ3pGPm9GZZNByX5lB4CKaq1Bjopeabrdw5+PYWmsAS/LkvvA?=
 =?us-ascii?Q?D3PaACH8vg3Xm21FboIFVjlmr2J8t1qHggL1rDnajAQCvBCcY5YihSFnbj1g?=
 =?us-ascii?Q?yI0YIOvrokbITxbJNEWZfqrQq+N6jflG9P7Nuzx3m6vpVxezxZV6oaivcbzb?=
 =?us-ascii?Q?ssSl2jNieMXnUEZvAuc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c6c0888-f4a1-4f74-25a7-08ddecabcc68
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 18:41:17.0834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Be1xm2icIarNBRXQ6mnmU0AOLk6efi3/SKLCDyjvWD1GFoZeEb44jxvLMSmBj1ML
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9195

On Fri, Sep 05, 2025 at 01:51:00PM +0800, Lu Baolu wrote:
> The kernel's memory management subsystem provides a dedicated interface,
> pagetable_free(), for freeing page table pages. Updates two call sites to
> use pagetable_free() instead of the lower-level __free_page() or
> free_pages(). This improves code consistency and clarity, and ensures the
> correct freeing mechanism is used.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  arch/x86/mm/init_64.c        | 2 +-
>  arch/x86/mm/pat/set_memory.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> index 76e33bd7c556..86b4297c1984 100644
> --- a/arch/x86/mm/init_64.c
> +++ b/arch/x86/mm/init_64.c
> @@ -1013,7 +1013,7 @@ static void __meminit free_pagetable(struct page *page, int order)
>  		free_reserved_pages(page, nr_pages);
>  #endif
>  	} else {
> -		free_pages((unsigned long)page_address(page), order);
> +		pagetable_free(page_ptdesc(page));
>  	}
>  }

Er.. So if bootmem happens to be under the table and we happen to free
it due to memory hotplug we don't go through the SVA fixing path?

Seems wrong??

Bootmem still has a ptdesc and a usable linked list, right?

So maybe this should be redone into an arch hook in/around
__pagetable_free() and all the above frees just use the normal ptdesc
free path, including the SVA work queue?

Jason
