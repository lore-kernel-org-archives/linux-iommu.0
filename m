Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010041.outbound.protection.outlook.com [52.101.201.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4973339848
	for <iommu@lists.linux.dev>; Wed, 21 Jan 2026 18:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769018702; cv=fail; b=dKIKxmmcT7EFG41i1QoVvCIdbt5gSkIsj370t7qLkjC+4wOJi4zz7eJNkajdmHjW/zZJWfxitn8MJZir2ADdnHfuZKtaGq9Ccd2YV1H2QGY/fRkKm2KzaC1FRkX2G3aHJRcInC5CT9dIjSl97h13bRQOBLgmItV8ah00tbSaxpc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769018702; c=relaxed/simple;
	bh=ZCFzMcyEAu0e8baLn1tIRzUm5HrjtchEI0kUScYRWtk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VQ3vgCBCWkYY4Jmp5869NGSqod/ILWv1Lz9vsFJZAH9eQUcp+Jj7ZiTHyNLzuG+aiuafTPqEr1nExPUknOmW/DW4zL/JzM0btntr6GJcug6YmAytNOONJuPii37C+cJBAWkwmZ8UFsLylsoaO9V+8liRLTuFi1p3Sp5/bOW2tsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pK19rrE1; arc=fail smtp.client-ip=52.101.201.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pK19rrE1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ldgl5C3LxBUKR5MtcLPqU+0I289jehkLZHXyspGYDbJdYAxX2vZRcaHS9tanKB7Oyw0ZI/2/ZjRviCKD/15tllNFQYE3qV/0NkDorATsBYPKL2nmpWJ29FnYiyVFZBQgNVhMC5QFm4OY1hqVBcCGfvejJ441HS9vgtk/cyAtErvgUNc5yvHp3A9AIoUrCl34Deq44hfhfMFB3F9uE47oxX+amFNYB4ewKrGYhcRvfmgd2Sirn0sqDPX6fg6NvZF2EkCkV9bKZgJhSoU/I7Dv70hNP2TFi6UJvrjaGEa+8rYgdwX9eEjn5oQmZ6TSD0wYlzMrzFj1z74F5jK0qfw6Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gE58OO4S3zhPSwZFXBLqI+H/7GFSrbqNa1yRTgUcDP8=;
 b=Vvyg/WJScWl+BVQtVZoTuRhHwPOdYKKGEb65vdpVC11kR606u+fRcEl/UjZpr86tuqVY9ReY9rpmIc/WcmnHLqXswuyYfdjFFblEcmn9OkJxHmBcxKyZHzPIt4k9LhFwi5bhtYAik9ZtbmbsevYOlpdfs2zWSOl2SZoVP5thpYiRqzMgyYn4ospmX2eqNtEEcOLpRa3NWKxXAQLdwvbALd7yncQBa9cNiV3Ziht+OHGOELbET9UcCX9rnDoHzOWdNrO7ognCHzUPvU2sbtJ4V4RDBtcquLxej0F+IbkywLX+soFq+SNuP8epdTM1x3gqL4skEVgBkH5Ov+18eU2cTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gE58OO4S3zhPSwZFXBLqI+H/7GFSrbqNa1yRTgUcDP8=;
 b=pK19rrE1+RRmxbVqmS5YjWfOixz5/QsfxqRDG8MN64tBBYKiRIvrkFMNr0YULRoneEyRDL457Oo1B6CfHE5riVV8KX6awHrfZbb5K/PRmNJRS97iBLR1rABb+lkNBG+wbMc86b/v7cPbtFczh6qW7UIIi2/60Eb288KxoMfu+S5JVqyY1szOQmSG2A4j/cAjFo1m4mQA00W5P9aKW7WH2FodSl9W605xHAAO49QUbgC8pQFcgZSqF6ZXWHGuIRF391qH7+3R67rXMt7LsZbkde9LYxZD24Uyol5o6mfopGTcQwztKloyuXy0HHOpds8JLiUCD3Bl3vxFCCpn9M1RkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ0PR12MB5633.namprd12.prod.outlook.com (2603:10b6:a03:428::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Wed, 21 Jan
 2026 18:04:53 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 18:04:50 +0000
Date: Wed, 21 Jan 2026 14:04:49 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Francois Dugast <francois.dugast@intel.com>
Cc: iommu@lists.linux.dev, intel-xe@lists.freedesktop.org,
	Joerg Roedel <joerg.roedel@amd.com>,
	Calvin Owens <calvin@wbinvd.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Tina Zhang <tina.zhang@intel.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>
Subject: Re: Xe performance regression with recent IOMMU changes
Message-ID: <20260121180449.GA1490142@nvidia.com>
References: <20260121130233.257428-1-francois.dugast@intel.com>
 <20260121131135.GF1134360@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121131135.GF1134360@nvidia.com>
X-ClientProxiedBy: BL6PEPF00013E05.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:4) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ0PR12MB5633:EE_
X-MS-Office365-Filtering-Correlation-Id: 59c943cb-ee8d-45a4-3ade-08de59179205
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jP6UI4zeqnLzGRthR01DO1mH6csc+pgC5KXw5qEoO5W1IrtJAJLA2vv4m8EH?=
 =?us-ascii?Q?YD34dPIzEUUuEpGL1l8qUzg0fsC1Qb+6I2vcyMKjV0n070tACESddd9QCJBv?=
 =?us-ascii?Q?8OYd9dcdnAw3iGrpYE1XKq5OYZRsmN4XS5H3+8l9Y0lFnPOeCDLomvNd+TyA?=
 =?us-ascii?Q?HaydAAtfSzeXGxjGGqtMwvdbg/E7mzTUFUpMDqwQHEajEDksegizXVutaioS?=
 =?us-ascii?Q?0/orqKGQ9jFnSAAbn4kpxAscuz3N7GJLiTAQmc1LvechhgvQ3AgGXbEnOogS?=
 =?us-ascii?Q?awJt8wEWglBbDzqHsld4Y0m+anFuRczCHk3LtW16jWmXs3l/buNweqSMhWOK?=
 =?us-ascii?Q?X55O1pei/wPoagNWLWQQqotwjiDuA0nykdA9iZPqYHLa91dzc1CjOgismPbl?=
 =?us-ascii?Q?+9JJ975pyUb1VFHQJOFr3oXnNuBrvNUynGumdaK+/AZDsr0SqavpBAMbn4Ug?=
 =?us-ascii?Q?Y5zR6eHNG0f7PVmeApuwaPnMrySYRQZS5e6e3DU4qVB7IGf6Emn5zeIq2UrI?=
 =?us-ascii?Q?LgOtkan+OuBz/6n/UjiCwrnZy/gsHPfF0s2vdI158XFuA2M1Hqg0+Tb4edbe?=
 =?us-ascii?Q?ZwsluF9iaQfpT64SqEd3uI9eD/TrwX7AiZ54OahYktXLjgS1UTsbRPfiEwtS?=
 =?us-ascii?Q?S+uwdKdvOXJizyK6Tof55GsgYtalxyBe+WWlZwu9O0s8+qJyIIn8dQ6afB4O?=
 =?us-ascii?Q?xjxNdzim6yLKj7MC+NqbpMPOKSzyHssDVvJ9d/frqz9n+v1KkkwQ6z309FE1?=
 =?us-ascii?Q?GlGZMMXfBtu8CpLtvo025mj4JE1nmXjZJQKgxouKFSXmdbXOCcSfvtHe5H22?=
 =?us-ascii?Q?4JbCIrCEiSuJHB4jA+z4bDhGKul0ontEGAffPlAGL/lrzYPnM3gxwAv+vJBO?=
 =?us-ascii?Q?PTdJ8rLghbAGQO0+JHZ5v/eWi4M5lfpZ8Z/emu0PstjCXQpTq/0Bs8QIcf24?=
 =?us-ascii?Q?ufA4p1eeY1ih3RUL3SrMn3X8n1qScpLUy/cPWgZg/xno8e31DMw5AXlsMUom?=
 =?us-ascii?Q?qaM+srJ6XRm+s2LmzSWFXgOXjfQtXf+F4UncJ4dctH5pMXnQOgY9K6TPexjE?=
 =?us-ascii?Q?PpTeuCZxC45X68hmrJDPSNwTyl8+tIeHy91SWFuev4DLSOdO36JassnHi+kd?=
 =?us-ascii?Q?5S4EwQsUCw/Ge+FMNuRRmjB4UcbXuq0ctpG68V9nMlo4NJOHfb9L9oG3mtKd?=
 =?us-ascii?Q?Y0hCrTbnMwrg+Y9hMhGUGxQFThtl8qoHwFYXxdIS5ogtafEbGepz5eH39qT/?=
 =?us-ascii?Q?4GTa0SKqdRhoYoXuy2oynwUOJC1S1gTt26/T7KfiwmzbNAxgQPPqNBqZQsoI?=
 =?us-ascii?Q?hbthibVgV4DUO+pAFGkitmGdPrArywYWWi1edhdILK4vxbvh1dSIWvxJYmlg?=
 =?us-ascii?Q?1UJ7H6bXtw+YlXxStKJCkqHc8cNCoBaiTIjhbY2T3fZAweLXiaaDZlQUNVfu?=
 =?us-ascii?Q?bExsISJfxmJWOz1sFGDPPFMpf+Utf8k6m4UGVx3406juA8E8eCSrePw9bBPZ?=
 =?us-ascii?Q?58HctjCfkcJz0kainDZt6g3908ZDWS6NYTfza2AqvgSnmC/Hqa1eUMLh+4Sl?=
 =?us-ascii?Q?hTR/Bf5U85EMXZHX+L0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EdqmYLzfN7OkNAJ3MNGXadwy3d16x7tz3OldFGQTQ1CQIymXhredlKo2Ym57?=
 =?us-ascii?Q?PdYzfKdN3VjXks1FHlM1STTgmIr8tnAz7QN4AwNqNNOwGsq49TmUJwcGBzWQ?=
 =?us-ascii?Q?C/WK8/hrRS18dP/v/RvGw73Y1w7hRjLJSYJ5N9zwV0s5DD93XTCkfrNWtVa3?=
 =?us-ascii?Q?ryG5Sb4ba4oEUig5J8BSYNsxnvoyOQga44io/4CkTx6ymMkFzLwpkyOaeWWK?=
 =?us-ascii?Q?Lw3DNXLBslou6a+sVQWkLP55FUHK/bAmAUESdf6hDkzmG3MTSbCwNrGEk2ZM?=
 =?us-ascii?Q?cuXYrHAgGo272vNTFaE8LodT5fXmdxIfrjarhMhgvfXtVgd+NXtHpNkUVKiJ?=
 =?us-ascii?Q?lljsTVw+AwaezpI3tN6vDZ+43bFzlbdN0AHwE1nnKyRawGaKIZVVOD0TXxf2?=
 =?us-ascii?Q?ju+LPwWr8NMYjqK4PHYgdGSYJh6/lrmu+HD/0B/QB8ltKjT1ks7o60dtETO2?=
 =?us-ascii?Q?SOnszWkEALlYFpG1t6282fvoke6VNkxMl2os0P8NylrM65QamQ7CyjjQ6xpZ?=
 =?us-ascii?Q?ByZ4R2nmIRVm3mG3uQkLS/eoxiXqQTmkiNRwKwg+Wks/wsZpHkGqLD+RAxJD?=
 =?us-ascii?Q?jDt3RQDOQ2TZt46LbwNpWyHdUdfCqpKxMzApJQW/f7iQ4FLViNbEU3+J10jV?=
 =?us-ascii?Q?iKsC/wPXSiRtI5hS1mTE/HAkkmiphKgg4JAYX2Cx6yzqMqgdm9Jf1vbn147G?=
 =?us-ascii?Q?ILhE7SDYNIKYqZPzgG0msaHL5EWiBX4HBMPeHU52FDNwHeih/GUPlshklKu1?=
 =?us-ascii?Q?G3bn4YyuEMOWDnXFK/f5jhKtsGtYzu6W9UZbA7xjHbEOttXmkw9m5EtAh3P7?=
 =?us-ascii?Q?CutsPay2YN01gYnvp9dz4y8JDMLzgMcFnAHSDcx+rcGr93oUGIvALub/r1bA?=
 =?us-ascii?Q?etPJJzyMhwxi2KwzC0wrAqJhwhZDYWr3L7nDClY+/9MPh4Qy7phoE1/03xFN?=
 =?us-ascii?Q?d+IsES7blWn9anE2STGyLIrDL5axSDLMiox5HoTgjlBFwNuTOko+8d2sX7IC?=
 =?us-ascii?Q?aqKGHgiGsXxZxNrzOBqOIPa8kyoBnAswe6ArnVwEyJaY3jvwDSIVZle7buVe?=
 =?us-ascii?Q?Eoi40mDhHITFYCtZSKPOiblgaWWRT8d7bCaT0NBE5knWBbUdEqJC+eADC4v4?=
 =?us-ascii?Q?gGFCBCoDh2jClIC8vhYTZUzDhnw9NclQJL+D/tdI82Wqus9cETUgIBHhAaXf?=
 =?us-ascii?Q?Fl/3A3+woeUJmWY5S2KCCjB0wverSUx6i5QqJAy0MSyp9w9fessHUSyMSD2w?=
 =?us-ascii?Q?0YI7g9dLydoo75H7ZXHrvjvuPaiWY4zrxOC/CQz1q/SWWpXrip26lTDeHbc3?=
 =?us-ascii?Q?19s3mXU2qQDZdg9KgyotnP6wa6iQiVAvpmuINI41DgT9zywSYU/rvrn+IQIr?=
 =?us-ascii?Q?JW3QcrPIDiA7jpbD8nSH3HAlmgr5kOU2axrn/7821Qffi39pBNKETC/mMYVt?=
 =?us-ascii?Q?nbWPccS8at2N2Ayjk3Ksl3//KZsApVjdjCY2r49I56YYWOWDWqA9siS76dpg?=
 =?us-ascii?Q?FQIa+bEpgcgxG19OLZ7WsWaVQZ9BFmFlKWmS8G6Xso6eNLMaP4qhX76x+cgC?=
 =?us-ascii?Q?WAH4dgiU6DG8QJlbK6PZiQqKmNV7D32W1qoiod38lHHZOwp859opzROwo3MP?=
 =?us-ascii?Q?X7svE/THBnWJE3sNyVXvqfflWqvyJZFmfwsFxFBGVQ6Tf+M+ybkV9Mo3wz2j?=
 =?us-ascii?Q?zHQGEfhtmR2ywEsKmDhJ0V2mP22HUohoRA5ofszxemLGqBeM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59c943cb-ee8d-45a4-3ade-08de59179205
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 18:04:50.5821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kZXlaSKfyMcCh8cBNQvhBdmP0zDKfZqlec+O1M8JvB/myHgm13rJhrKpy8o9H+6w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5633

On Wed, Jan 21, 2026 at 09:11:35AM -0400, Jason Gunthorpe wrote:
> On Wed, Jan 21, 2026 at 02:02:16PM +0100, Francois Dugast wrote:
> > I am reporting a slowdown in Xe caused by a couple of IOMMU changes. It
> > can be observed during DMA mappings/unmappings required to issue copies
> > between system memory and the device, when handling GPU faults. Not sure
> > how other use cases or vendors are affected but below is the impact on
> > execution times for BMG:
> > 
> > Before changes:
> >   4KB
> >     drm_pagemap_migrate_map_pages: 0.4 us
> >     drm_pagemap_migrate_unmap_pages: 0.4 us
> >   64KB
> >     drm_pagemap_migrate_map_pages: 2.5 us
> >     drm_pagemap_migrate_unmap_pages: 3.5 us
> >   2MB
> >     drm_pagemap_migrate_map_pages: 88 us
> >     drm_pagemap_migrate_unmap_pages: 108 us
> > 
> > After changes:
> >   4KB
> >     drm_pagemap_migrate_map_pages: 0.7 us
> >     drm_pagemap_migrate_unmap_pages: 0.7 us
> >   64KB
> >     drm_pagemap_migrate_map_pages: 3.5 us
> >     drm_pagemap_migrate_unmap_pages: 10.5 us
> >   2MB
> >     drm_pagemap_migrate_map_pages: 102 us
> >     drm_pagemap_migrate_unmap_pages: 330 us
> 
> I posted some more optimizations for these cases, it should reduce the
> numbers.
> 
> This is the opposite of the benchmark numbers I ran which showed
> significant gains as the page count and sizes increased.
> 
> But something weird is going on to see a 3x increase in unmap, that
> shouldn't be just algorithm overhead. That almost seems like
> additional IOTLB invalidation overhead or something else going wrong.
> 
> Is this from a system with the VT-d cache flushing requirement? That
> logic changed around too and could have this kind of big impact.

Oh looking at the code a bit you've got pretty much the slowest
possible thing you can do here:

	for (i = 0; i < npages;) {
		if (!pagemap_addr[i].addr || dma_mapping_error(dev, pagemap_addr[i].addr))
			goto next;

		dma_unmap_page(dev, pagemap_addr[i].addr, PAGE_SIZE << pagemap_addr[i].order, dir);

It is weird though:

0.7 us * 512 = 358us so it is about the reported speed.

But the old one is 0.4 us * 512 = 204 us which is twice as
slow as reported?? It got 2x faster the more times you loop it? Huh?

The real way to fix this up is to use the new DMA API so this can be
collapsed into a single unmap. Then it will take < 1us for all those cases.

Look at the patches Leon made for the RDMA ODP stuff, it has a similar
looking workflow.

The optimizations I posted will help this noticably.

Jason
