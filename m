Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013003.outbound.protection.outlook.com [40.93.196.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A900922FE0A
	for <iommu@lists.linux.dev>; Wed, 22 Oct 2025 19:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761162784; cv=fail; b=PdJhyRm6JaKbzp+8zspJvHpglMe2GY57E58B53VKjlePSjDftiKggoAPMe83QaP8YNbIMvmpC2qGG0jHZtXWJYHoAI7sDi64YhFYfdwPV29W5PLmpxcUCXczqtwU36P5U7hC0VSC+ZJkox6gWwTfmC1uOvWj0kZos3aK4BV5Bbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761162784; c=relaxed/simple;
	bh=FTNVFxvwIL72mfU2WY+6j6ij+sBFC1uZioNHBKDV1Ig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ChmlaC7EtsMDoXQbeVOVJY9dPJabOGHJ4AqwLSZcaEDGaTyzmnicVitDsQrrsv1+YgI5bZHR2J1jn2OFQF52ascISK6fIS84B4cY01MPKr4bzkJuxyuxv5KK6X9G3nCVFbjY4fZEXaZRNNqxq7oBcWCmPVusKtyAKRj+OkDUBi8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JvTMqgkc; arc=fail smtp.client-ip=40.93.196.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JvTMqgkc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B+JyOGKSJznWZqLojV05aexK7oMpWUCosYzd7Bh24mT6tS2iTqE85FgG6hP72YonCC3DNc18pVVXVOZRJXf3cwCRo2O9m/0J5hEkOmPNueuhg4QbMYeZ8vCHi8Igiwr7VUdlSUIPFRI+8aUdcvdvfVZuVLrKQXWsD2PmyaD5fXfB5AY0ljcqg4XrEl+FOnLG9095Xn3HDe/OUIr7rZxGRFkyV2sIBSpokQLZIIXH9QKlW2NC+WeEtBPAsK4XZo5cVI3ITzJvp2eT25+GDkrrGgkVHyOqzFmTFg8qRDpKHQsEE/EYAq0CT9YKSxle8NAHzCvjuAL4lMAdGEDiUSnvhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9V/7HGBZxP0BnWJtzqPWtd+Wyz1Bz2UxuNAJzmzCz8U=;
 b=H9ow0/XgDdOF0PvbsCFQu1hLt/2ni9biP5zAGbgjNGMODcYhRSkEIT8TxnTvoAuf9F7m/rjLfpaa379PYp1BDs8qjzcWJgIRRDGiB94Ir0la3SpMJ5688067bx2GVdcDp+uB5F62V+tHT0185lNu/zmzuh/Oz8OdSnYhB3YDTQM7Ca2fZ/GwcMSrkqH2KCAHVnCSh+Ts/ySxoKa2Ckbm+ZDENqNxkXR0O48JRxiWfQBmwDUX5R3mOzhnUxqkVgzku3+5wk3fXSKHv6VJEdnXntN0WBEEPEb4esMIxtor3pfShm/uURZGw62gvALyrp/r8pG0UI6tc04BYQnorswATQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9V/7HGBZxP0BnWJtzqPWtd+Wyz1Bz2UxuNAJzmzCz8U=;
 b=JvTMqgkcvTXJxhiKXCRVNApSoINaId9KiUBj8/Uo0KMiOhocFGncHjRfRuPdQmubWwx/Tz+Gl1Ij6Zz/0EDIbQoKWco7GA4lrQNvWf5wXZZesWltSo7DsAh3Q2Z876FyO0HbALIUp78MBzHhjFlrGtodrCWXmDiHAyWAnrmLs0mJ9FXN6JzMEcuoFDfzPvIwNbwo5uXXEueImzoI+Nym41h18Gap9mUJJxLsGLyyGDZg5BV2R75chO5fJVYc+aiAco36/33GN5MzK+2wMLqij0RWKeTnG0J2BQD5qqgCMwz55D/B9Xs/k67p+p43InbVS6W9yaH6GDj2C5+Ry4ZQSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by MN2PR12MB4125.namprd12.prod.outlook.com (2603:10b6:208:1d9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Wed, 22 Oct
 2025 19:52:56 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 19:52:56 +0000
Date: Wed, 22 Oct 2025 16:52:55 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Jann Horn <jannh@google.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@intel.com>,
	Alistair Popple <apopple@nvidia.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Andy Lutomirski <luto@kernel.org>, Yi Lai <yi1.lai@intel.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Michal Hocko <mhocko@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	iommu@lists.linux.dev, security@kernel.org, x86@kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v7 7/8] mm: Introduce deferred freeing for kernel page
 tables
Message-ID: <20251022195255.GB262900@nvidia.com>
References: <20251022082635.2462433-1-baolu.lu@linux.intel.com>
 <20251022082635.2462433-8-baolu.lu@linux.intel.com>
 <dabf557c-d83b-4edb-8cf3-1ab8581e5406@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dabf557c-d83b-4edb-8cf3-1ab8581e5406@redhat.com>
X-ClientProxiedBy: YT3PR01CA0098.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::9) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|MN2PR12MB4125:EE_
X-MS-Office365-Filtering-Correlation-Id: a7437846-d6b7-49c2-f14c-08de11a498a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/QK2/gpMTV1T4QCq7XZ9QK9jnzW1RmFlgg2HRYTu52D7/zmMihlDwkWwna1w?=
 =?us-ascii?Q?S/J4+reUg3EXChjIFvpJF3SnX0wg4duXPEdXDPccX2MwmpgSe6HzhuEwUO5L?=
 =?us-ascii?Q?RsvVEhgi9q7Li0xKjuqCVoCqeDt3YjT12LmXxg5dB2mycaD+4Eoay2kAMyJ6?=
 =?us-ascii?Q?sWi0Z6EIPwS2RxuBpYAtccY5pZEnR3JqfAHX4ODQseo8icJt2ePI4LMdP/ni?=
 =?us-ascii?Q?qak8VWQuHdExbLkKRq2oQTTC+OnLeAhjc6d1V7elECO9VEgRTop65KuscIYt?=
 =?us-ascii?Q?/knecxgxUdcfhQBL7jffl9DmTCQge4mP+ZJNwNw8gCusUWjixwEr2NwT3qK6?=
 =?us-ascii?Q?wttazIXpEifp234vwYMMGgROQGZRo4KW+/GPwFPIVBd5U4WpQ6C7ZVoAKsFK?=
 =?us-ascii?Q?gy3EaywJ6eFKOPH/OWifDc8sqkqkbsmmE/N0uNR8oupEPzgX4CdktL5dwDK6?=
 =?us-ascii?Q?xMCFSa77a2jRd2jhW3h7KLUZFZqRgRuQhpBk38GuQNS2jnQIqpDEDj7O1HvW?=
 =?us-ascii?Q?O7DMunGupHeiwKfeLj2JM1d90NpSADsa650Xs0rwkXpeMrd36GDIJqhUfeUP?=
 =?us-ascii?Q?zy+Fz9zc4GDDH2aspVLR71s3THdqT2D66cwFNwO5nVcV+9WJrbCIvrIQ7xqw?=
 =?us-ascii?Q?MDLeQyNLWBtw4oFyMCohhHX791d4oUFoEpuNEeWFWHkbETaItwBSvjvh3Dtf?=
 =?us-ascii?Q?5WxWjj14KcIXxwydO6NyzjcWHzf4TFUOutuYFckAQTZjpS8DEhW1qiPdGkxM?=
 =?us-ascii?Q?EGLTR+tWB8nzQluckUKwRiKRDeU1vgmoM6o0HvkSk3UNsoyUcbKbyK4uakBr?=
 =?us-ascii?Q?k/9+8ZFL9AUIWBdjetBMvpVYzVbonlvdF4ESpI5j8ieW/xk5XBsgEk4PJqwi?=
 =?us-ascii?Q?7CN6B3LeoMqCTiOm1Mxt+CuagGz4UtrIyZaFTqxYqYLzI0WwqSiaicmaOr8i?=
 =?us-ascii?Q?VPZlRZQjhRFG9ZdY/JzlVLpQ8GS6zxk7f7aJ8OpAtTqYuX4jY5ispM2ksZ3X?=
 =?us-ascii?Q?gllakw5q0XnsMxNaqMrG81b/wAl8XmR3joSZc23lh2XyPV6kyM0F2CHa4LQh?=
 =?us-ascii?Q?8lctnp2PpsrHCQ6ZWjBY7m3Z61BB/kuyqBqOOFAmUpJDRhZyb76lQ0HCLLrt?=
 =?us-ascii?Q?2rppemOTNKgrrwWa5O/IyeFp6Yqe3CGyD2WaMy0QBF53pQlBs5YE3nAPaTfn?=
 =?us-ascii?Q?tu5Fz/0O5LDWekBOcf3to1M0CSmVIshKEDmn04YGpqYG08i1mVEAIYQOV9R9?=
 =?us-ascii?Q?gK/R3h23Ht9od4WW6In8B7yCAPLfEiscfhcYjFLMh5f+Etn2Bi4FRDQH6HTo?=
 =?us-ascii?Q?h/Wj0ekvtwOgIHYziS6SQk9a6LcuMkc/smy4CRUpgQ+THM+k1XxHFYmPOk81?=
 =?us-ascii?Q?dDSapm3KX/yPQfIdPEk4SZnFWwceP+uAtdKGP+Z/UN8alDlK769aCYjODwDq?=
 =?us-ascii?Q?+xYoz1WxAPGyoYit+pT31bjK7bNwGfMx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fCebhA9uBrywdR24d2qkFm+B5JVnlmNba3MSHLHmo8835Fv8KZItf6gBKpJ7?=
 =?us-ascii?Q?6d1/deaiSCxhZSBeGf4vpL/9hizh2/o7351svxh5SqI/76LNIct4Mn4rfhm3?=
 =?us-ascii?Q?rrZVVuKk+0umT0dxdXHSvh6po7UBNiqyHavEbURXSAUr5m0bcnlYWVS55kRW?=
 =?us-ascii?Q?KTeeSeNff31MODFFMoLhyUAGIUJpqPgZC/YXqtb2hqmiIvPUaklSndLBcssY?=
 =?us-ascii?Q?IM19auxw6FB91ypL33AlSrtd1ieyDVARYi9CQlqxSpqckOwAcKDANQni0Zie?=
 =?us-ascii?Q?9An7w9885O78zx4W/IgsLFfR8KWKIu9GNItD/ufiBpRj4DlfoXSlARJs35Fw?=
 =?us-ascii?Q?gH0la76KjcvfaElb6tGUOZ/WxT/mck0AbbwanlaRUJHK9acqwN/9F5sBlRjq?=
 =?us-ascii?Q?WqGFgzY7RC/PzJgjs0uyv+Rixs8kX+R1EI7MVnQr0nW5X1kLwXstn7NBLZPS?=
 =?us-ascii?Q?jvYAXpIejnY8TtPC3+dzgxxTNGDHxR6hrSdx7Q/8307hPoKxnKqv61+XehJ1?=
 =?us-ascii?Q?0NDk/M4So5MiLASbVcU5bLBgG/IgqFkPtbAYabkm5dHxwqlUmpvdQD6zfIXa?=
 =?us-ascii?Q?klDabpyOY2hi5Y58e2JU2vu6mZXrRY9LgS+hvErcXntDgxta37xj3IClDaId?=
 =?us-ascii?Q?dGnDQfYaCKyK+XG7U5N3JYH2rvXs697as2RTJVzwT7mNcMRQmPxdjCuvDcJT?=
 =?us-ascii?Q?czEONp0czVIDmUALpmXD99jj2W9b4TOLF4TR2DzVjexiY3fINoaUxxHIK4ng?=
 =?us-ascii?Q?Q7KIriUkM30tZiA53AXYT8G3nyZ0/oGk1dy9t7u+UJiN4STIWrnaL9LweFpn?=
 =?us-ascii?Q?EHun8AF+0aGfy9xRq2sYdb/t7qHMbjcFarbeUj5Je+Jqs3MVRIqsIKY5xjtK?=
 =?us-ascii?Q?a4mbwgULb75N/CuUh/6sil6hwqQUJsAssmF2QH9ngYW9hQkW0UKkFN98L/pM?=
 =?us-ascii?Q?MGaaiz5ZjYkX/JkqlHw5bO6UCakHPF88fOBF2mOVI5N5kBYMPi8Uh/2cAl6p?=
 =?us-ascii?Q?MrraOsFIK9d9qYNUuwubKGmMdaUBSUY2gW2c34Npe3chjUX5iv8CtV+CZevG?=
 =?us-ascii?Q?1TQs+MllmitGHTTim4WQhLFo9+p8G8g2e6wCmBAaFMIwgzver1EYyQBnzIMv?=
 =?us-ascii?Q?tLv9/mmaDHmyyIVKfh8cb8i0u3yXgiVfAZziCrTE0eLkMQeaHll42e7wOevx?=
 =?us-ascii?Q?kt6NJXGabKtwR4iJiCRgtkFMOCyLd8JW9SfuHkE9Sm2jNPT4rzSg0rI018qH?=
 =?us-ascii?Q?FkBZoiY8N+idiq7GD96QaVro+rogUWJiWHE8CIc7UZMPACgPfcPhTHLe3rPz?=
 =?us-ascii?Q?mv+EbenNyRRL1ms0dliM3jSSExXSKPAUntPTyYuwNjNGWXQ/bNP05aZHKWy9?=
 =?us-ascii?Q?HUFiBO4NVM67zID/fkuALQmEXqamTz3Zxl3FZJO/PaTWo4vTvb7RQ4Xua4Be?=
 =?us-ascii?Q?+VSX99FdrBsznNxusPLFpeijI1AgscR+BMkbjytgx+HEugutbsSf+0Pcv3p9?=
 =?us-ascii?Q?ciDPg9fDPYdyskA/rtweMyqa76P/+vOugqc7aRjg8OsWkCy+0sD/6ruogvrk?=
 =?us-ascii?Q?2DCE+s0t93ZQSGY4sME=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7437846-d6b7-49c2-f14c-08de11a498a1
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 19:52:56.8517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CUhotRrQoSOHdT/eyoKwCOCaiP27u2ck6/2IzFmcb3RP1tjtYeSKL7T1o9/klT5F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4125

On Wed, Oct 22, 2025 at 08:34:53PM +0200, David Hildenbrand wrote:
> On 22.10.25 10:26, Lu Baolu wrote:
> > From: Dave Hansen <dave.hansen@linux.intel.com>
> > 
> > This introduces a conditional asynchronous mechanism, enabled by
> > CONFIG_ASYNC_KERNEL_PGTABLE_FREE. When enabled, this mechanism defers the
> > freeing of pages that are used as page tables for kernel address mappings.
> > These pages are now queued to a work struct instead of being freed
> > immediately.
> > 
> > This deferred freeing allows for batch-freeing of page tables, providing
> > a safe context for performing a single expensive operation (TLB flush)
> > for a batch of kernel page tables instead of performing that expensive
> > operation for each page table.
> > 
> > Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> > Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> > Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> > Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> > ---
> >   mm/Kconfig           |  3 +++
> >   include/linux/mm.h   | 16 +++++++++++++---
> >   mm/pgtable-generic.c | 37 +++++++++++++++++++++++++++++++++++++
> >   3 files changed, 53 insertions(+), 3 deletions(-)
> > 
> > diff --git a/mm/Kconfig b/mm/Kconfig
> > index 0e26f4fc8717..a83df9934acd 100644
> > --- a/mm/Kconfig
> > +++ b/mm/Kconfig
> > @@ -908,6 +908,9 @@ config PAGE_MAPCOUNT
> >   config PGTABLE_HAS_HUGE_LEAVES
> >   	def_bool TRANSPARENT_HUGEPAGE || HUGETLB_PAGE
> > +config ASYNC_KERNEL_PGTABLE_FREE
> > +	def_bool n
> > +
> >   # TODO: Allow to be enabled without THP
> >   config ARCH_SUPPORTS_HUGE_PFNMAP
> >   	def_bool n
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 52ae551d0eb4..d521abd33164 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -3031,6 +3031,14 @@ static inline void __pagetable_free(struct ptdesc *pt)
> >   	__free_pages(page, compound_order(page));
> >   }
> > +#ifdef CONFIG_ASYNC_KERNEL_PGTABLE_FREE
> > +void pagetable_free_kernel(struct ptdesc *pt);
> > +#else
> > +static inline void pagetable_free_kernel(struct ptdesc *pt)
> > +{
> > +	__pagetable_free(pt);
> > +}
> > +#endif
> >   /**
> >    * pagetable_free - Free pagetables
> >    * @pt:	The page table descriptor
> > @@ -3040,10 +3048,12 @@ static inline void __pagetable_free(struct ptdesc *pt)
> >    */
> >   static inline void pagetable_free(struct ptdesc *pt)
> >   {
> > -	if (ptdesc_test_kernel(pt))
> > +	if (ptdesc_test_kernel(pt)) {
> >   		ptdesc_clear_kernel(pt);
> > -
> > -	__pagetable_free(pt);
> > +		pagetable_free_kernel(pt);
> > +	} else {
> > +		__pagetable_free(pt);
> > +	}
> >   }
> >   #if defined(CONFIG_SPLIT_PTE_PTLOCKS)
> > diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
> > index 567e2d084071..1c7caa8ef164 100644
> > --- a/mm/pgtable-generic.c
> > +++ b/mm/pgtable-generic.c
> > @@ -406,3 +406,40 @@ pte_t *__pte_offset_map_lock(struct mm_struct *mm, pmd_t *pmd,
> >   	pte_unmap_unlock(pte, ptl);
> >   	goto again;
> >   }
> > +
> > +#ifdef CONFIG_ASYNC_KERNEL_PGTABLE_FREE
> > +static void kernel_pgtable_work_func(struct work_struct *work);
> > +
> > +static struct {
> > +	struct list_head list;
> > +	/* protect above ptdesc lists */
> > +	spinlock_t lock;
> > +	struct work_struct work;
> > +} kernel_pgtable_work = {
> > +	.list = LIST_HEAD_INIT(kernel_pgtable_work.list),
> > +	.lock = __SPIN_LOCK_UNLOCKED(kernel_pgtable_work.lock),
> > +	.work = __WORK_INITIALIZER(kernel_pgtable_work.work, kernel_pgtable_work_func),
> > +};
> > +
> > +static void kernel_pgtable_work_func(struct work_struct *work)
> > +{
> > +	struct ptdesc *pt, *next;
> > +	LIST_HEAD(page_list);
> > +
> > +	spin_lock(&kernel_pgtable_work.lock);
> > +	list_splice_tail_init(&kernel_pgtable_work.list, &page_list);
> > +	spin_unlock(&kernel_pgtable_work.lock);
> > +
> > +	list_for_each_entry_safe(pt, next, &page_list, pt_list)
> > +		__pagetable_free(pt);
> > +}
> > +
> > +void pagetable_free_kernel(struct ptdesc *pt)
> > +{
> > +	spin_lock(&kernel_pgtable_work.lock);
> > +	list_add(&pt->pt_list, &kernel_pgtable_work.list);
> > +	spin_unlock(&kernel_pgtable_work.lock);
> > +
> > +	schedule_work(&kernel_pgtable_work.work);
> > +}
> > +#endif
> 
> Acked-by: David Hildenbrand <david@redhat.com>
> 
> I was briefly wondering whether the pages can get stuck in there
> sufficiently long that we would want to wire up the shrinker to say "OOM,
> hold your horses, we can still free something here".
> 
> But I'd assume the workqueue will get scheduled in a reasonable timeframe
> either so this is not a concern?

Maybe it should have this set then:

``WQ_MEM_RECLAIM``
  All wq which might be used in the memory reclaim paths **MUST**
  have this flag set.  The wq is guaranteed to have at least one
  execution context regardless of memory pressure.

So it can't get locked up and will eventually run and free.

Jason
