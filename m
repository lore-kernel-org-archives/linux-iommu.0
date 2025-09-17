Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010063.outbound.protection.outlook.com [40.93.198.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB0A30CB49
	for <iommu@lists.linux.dev>; Wed, 17 Sep 2025 13:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758117506; cv=fail; b=p+uR0TZZpqbAMAP1p3M1HYy/IUBD1iH7VTqEiTnmIL74Fz8Ru0pkTR134LUs260HFeAF0EJAieOmKFCCJ82tcAV7WkRtKcbmbtz5NbBAXLg7dmjdi1CGjNGGQdw1IM0NvmMBJYzxud/slXdIzC8ZJMrIK6n4NoSJsJltSEky98E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758117506; c=relaxed/simple;
	bh=jzC898W6qxPCbTVrMnDID/Qs+0EnM+t6yuWc1JEVQLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pgMjpBGOfH/52S71GG3fGDVTImG9Qyxogd/tpfDq5eGrATXeqqo7P/OVX4GsQIZpCqyyZ4n+fq7kKALJ6kMdDy1axeo4GCSYJLpK+LMQ+R4RLI4UbbBAZECI1EtD2DyIzNokGtEnQMpfNewshnMnhELjOr0Ov8WSJUSCjhLh6lM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=X0xfm78v; arc=fail smtp.client-ip=40.93.198.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="X0xfm78v"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JlbJyq1iDgxXkeq1dVUu3d1roA7TPBoEFzcJldSrqD80HQlquFivr4/HOO2Wap6ORvv4jyW5UtpA+9PEdHglcA4AFnoBYExvDt9rKl00yh5mAU26dQtScKPZq/1XhWPPm4UHwmR1wUMNgvs5tGgOlTFUgBbV8+Cf9zNJeMkTR8w2Z9imzOaF1XRmwxIc0cQ4Sg8PaGYXfNgAWdr5sjySIUcVsaJmcrfKN6RDPRNHnBzxFvcG2dxWRatxulIvTzS2aDEl/3VPsV0q9loGIIQLiOAfIKtMGuFjRGxiqCk4hmgaV/ubV7SHxnZqtOMuhqm7hL4hBrIjmkAJUj56UK0egA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=69j+vfglTxJvihWwx1BIGiJTAyqH9lsxO37O+BHTvuc=;
 b=xN6t3wvi7tBYh0OnHVGh3PMrLxfxV30TvGzp2sO+DVL67JWNxPbRaO8ezq7bblWYMoWo7gnnSPUdaOwbdRv012NqRDsY1Gf0QpECzeEAeoirDSeA0D5uYacbFFxqYbnG4jKBbfcm9jnMXC+gm8iC4qlfkwbx7V9IZrE0pk6aTr/IHst8XNVD7MIZOtJrZo+tR/Mup1cf4CjiEoTeCNNaBPpCz/fRjJfrUW5K3ciyNxYmNPiPwjTkQsQjaPtxBN6zc7mGbAlkwl42IGdvjTO6+MSPFBa94j+7Huh8aiFuMgRyySrUKE89WaBso73+xLFftFxKBLsVBsPyEBN6TspTYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=69j+vfglTxJvihWwx1BIGiJTAyqH9lsxO37O+BHTvuc=;
 b=X0xfm78vg6WnFWfrGqk6NcC34905pHHV51nX9nO2u3iqNx+k5XPK78oeHBt2ACpUMTutlttxRKLlrpNUuDj1RiU+2LQCJYeHAlBLX8rg2SHViA6FFz7Tf/ewXRJ68nHN8N1T/myqWOc96dhQp3rLZ1pEun9iivBw1/7uWnYTTktAUUkUqb0Go06DLACjMfw2OUKgHKFAHrU0e11qrNdyoxPdRxx1Oi/D4J+Ulo3w476a/hAwgtdz/WnwSEC+LCEOHzfqfcyOsYISakt5d3/pOYzRWhfjjUQXqBKgiPWZTt3HcfJxWLg0LjDka+SRR1q/zWzaPIi4Kj02wvZwBGWXig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by LV3PR12MB9437.namprd12.prod.outlook.com (2603:10b6:408:21d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 13:58:21 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9115.022; Wed, 17 Sep 2025
 13:58:21 +0000
Date: Wed, 17 Sep 2025 10:58:19 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH v3 3/4] ARM: dma-mapping: Switch to physical address
 mapping callbacks
Message-ID: <20250917135819.GA1391379@nvidia.com>
References: <cover.1758006942.git.leon@kernel.org>
 <5f96e44b1fb5d92a6a5f25fc9148a733a1a53b9d.1758006942.git.leon@kernel.org>
 <20250916184617.GW1086830@nvidia.com>
 <20250917103644.GB6464@unreal>
 <20250917113248.GA1086830@nvidia.com>
 <20250917134128.GC6464@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917134128.GC6464@unreal>
X-ClientProxiedBy: DM6PR03CA0037.namprd03.prod.outlook.com
 (2603:10b6:5:100::14) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|LV3PR12MB9437:EE_
X-MS-Office365-Filtering-Correlation-Id: 382864a3-a414-4ae1-087d-08ddf5f242de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tUOhdLOQTmVEyN6tGecGB8xddrz5FNlknqjSxpAPSqQAQ1nZaesHJJ9+Gg96?=
 =?us-ascii?Q?NOq69xgTHO430ldoIDd8Xlq+lz1FmgOBX1AIUVGyS1L2b4dpfsqVt2XWNmSq?=
 =?us-ascii?Q?erwiadhrPZplLLO/pUKaJioV64nRNkeFxoRb8SWlNOCUM6MLlHLI5cODlu+S?=
 =?us-ascii?Q?KFR5LoYC33cWFicjt7JpRpRxI+Zw/c8JOUE2CusqvZuu/NgJ1r+jOzBwprwh?=
 =?us-ascii?Q?YMtaNdTgKK3VLhPl8934rccF+uA5zESQ0Rd0titZ12KRjlp58vQjyzSyOEvW?=
 =?us-ascii?Q?mvUzWX8RPnV+Vj+e5Vqdjzk4MjFnOhOMfytcTwAHsS8SgAMdpPvFWmYOdq/X?=
 =?us-ascii?Q?3sdrNzqqbfeWc3END0ngeqenA7mZI47l5hhAHiGEuKYC9ldRDb5KI5HgE9EI?=
 =?us-ascii?Q?GKY8ySAqNOLWZYXunMiMvH8Q4psVWyIW8go52KZaNvIU+lJO+6dfSJBno/XV?=
 =?us-ascii?Q?V7BFDNU76Ou3td7fkIhzhEuOJ8YO4la3rGgI1HsebpKF22ZOi87i7m74yG3f?=
 =?us-ascii?Q?QTnn9Zc4fbqUHKID4mmiwr7lXvuQyaAM/WVKRQTzOYI1jjOSVa3G1LlGzslN?=
 =?us-ascii?Q?yBKIzpieRvZC/PL8y4+6GdX3U7X5taS/dRLv2QD/XjV2Sk+u5sR/0QGefAP0?=
 =?us-ascii?Q?1xYh/INeXf8eyBqsIKXiSZ65a1uY1cJr+VZd4vSXrkmrHskHoI4UW1N9dBh4?=
 =?us-ascii?Q?zuzrQAJBwdogp20rgYOWRTSgLZFhvzMhBrCxUtlJ1WUZ+jnr4voj7gKJfpSY?=
 =?us-ascii?Q?kr2Cm4vj1qJU5NH4WqmBltvsIx38YrDp4DEPVOX6H+67EAT+svgqlJyVhp3w?=
 =?us-ascii?Q?YkytQ0BzIF4//6U8zahPqhrbXRtEJyjCMAepnbmzMR/XcSlWPHHE3YdprKaT?=
 =?us-ascii?Q?KlMX25XStHbtCjFjZ/6axdpw5KFYl6tnAfEzWdrFPKwGHa9xZsl3fIbDg/zI?=
 =?us-ascii?Q?27ttQNGtF3TVReRZRGZ/Xi3V8RYfH71H3WbwcjE77nelP2lTt5swuOgkvTe+?=
 =?us-ascii?Q?uM3a6zG2aIQCy1vjsn4VUc0ZL/l+r34tn0gEYkVnZS90WLLdsWlYaY6SXqK6?=
 =?us-ascii?Q?vwFySncmiUCK5Nuas7TabCdZFpd7HZ9ScD/TO0Skt8ecwSCrDy97lUp6A+Io?=
 =?us-ascii?Q?Vt2AX1nGoIMAF2LrwXEjEcMAAHtz+kLoMR+Nhd9OLgcVuLMgjE+8EXJsVsX/?=
 =?us-ascii?Q?mFVa+9TN06FNfOnv/p6ClPVlBZtzPezDWCipAJJX1fhDMFGIJMaA2YL1HREZ?=
 =?us-ascii?Q?bFqnSCENUWAuMV6584ffnKHlEkLOG+R3vv5nOAua5dBXR4lUMh4TYU8U4sXi?=
 =?us-ascii?Q?8UR1xSDtRbIcIiRNFCAd0vCgs7GNjgFQ8GQxrd0HEFXzEJ+vc3R5+R8S5jIs?=
 =?us-ascii?Q?dtZPWVA7B2+2i4PtB/a/83GFnMJDv+mjDC4qckHa7/WdvAIVonVn+Obd9mpC?=
 =?us-ascii?Q?y7nKZ+/ZtqM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nme7nLvgfJoDRIfV1N8zV+qSw1GssTF963i/12A0vwIA4AEg+EGHuIIsYIoe?=
 =?us-ascii?Q?Fdyyd73llKFLNrBWvVE3q3Kpt3CIlQGfSyt9LsOBXOjBp2dthKEfTTukaAhk?=
 =?us-ascii?Q?TKJ2V6tIhl1PCBrBABBCDqEvG3pcZCFBUfwJ3EsoXccAVz/n5xdRh5b/vdC7?=
 =?us-ascii?Q?3WiMuHJz01CVKt5TEJORh4O11pqU+3Ip7cwBZzuZnpAuSOCW0WQq9gYU7ywV?=
 =?us-ascii?Q?qaBB/IwrLyJMO7TPfHNE6Kqt0m4523+0SzUwpCjx26ZFFyCTvgZtVu1fDG3t?=
 =?us-ascii?Q?w7RbVCSvWCSP989dTePx0yV7CJZeHDfH3nD3wbCk2d8HcJJi5fyUibmVuFc/?=
 =?us-ascii?Q?xoIrW7r4O8WD2Q6iCXiUHic04VZL7qQbmjU95fJiHcbWY/TZK6jhsUi0lCDQ?=
 =?us-ascii?Q?PT48CMSt3lKZDvVBQZR0o5nucPd9yjLS9VXagktf6RkSzQAixSpXqZYazsnw?=
 =?us-ascii?Q?cGsz0GN+hAjGvpqF9p8f9MKNFxueOf4MfyiEYaX45LkKQOsbtAtpeOmOZOAm?=
 =?us-ascii?Q?8Sr9rDzbpj3rR4TOrRZLD2u4vjYa849/3leKyZRADizcya+LfxeZFkJEBTE6?=
 =?us-ascii?Q?XOYUkcmNM4T/4aTW5gN8nGs+FAA5hhnCY2sE5noagtMBvejYHQgWF4hIJwrp?=
 =?us-ascii?Q?SHycX3eGmsu4Y/IFvZbN5do8fUysOdaZiKCfG4I/GWFQbr6f+aWifMhDqcnX?=
 =?us-ascii?Q?vqk6M9cRFjHxtqZvv72h1SZfa8SbUimnboo+v91KCQ/YyvKQ1+THjkvLXwkz?=
 =?us-ascii?Q?yeekOr+gLJpB1dxa2EHMtsOz9s1xpMJAlF3SSNvi0pdoM5RbwAPN5R13Q8JO?=
 =?us-ascii?Q?OSlOQNihS94NehdmC5iwBP/BFeSndYmyASOyZzSWOPfw0nJn31ZzqFINFJ2y?=
 =?us-ascii?Q?bmf7EOyGJ3hbzPJoBeoDm29zgd+e/jVmwmZfJkgf6D87zTFGEmdIu2g8zz2w?=
 =?us-ascii?Q?oVSw8VkJ5ql1yYu4R3kYZoRMPJG2qokC/hZyZEVW2sswgJQPIIP0UU4fISCy?=
 =?us-ascii?Q?/7W2cwIw3dGpzafMBx+KsYsDQ+5dLZR+xeHMZEMfCmMu2ChRhiVnM5oCyLVc?=
 =?us-ascii?Q?MUNSVlyF0PD/WFnQL56OHS/d2rHJxt3oi/+hl4RSDBI9G2vftw7WQ0O45P3V?=
 =?us-ascii?Q?Xjglvja12grzJYoqeXs3Gp0PkrkpWKR5XiBTzPVYU6O0zRfojzotaz7KlFoY?=
 =?us-ascii?Q?WSak86gRv1tgSFxvmQwcWLFGuyRal4FhK4SmHHc70b7D8TJ6Cwqn2Aquhq3k?=
 =?us-ascii?Q?kyqyi4fSWClMUojYa0olbnfMHteK0Qc3zSpdBQJvV/2B5cEnQe/7aqj9Vz4I?=
 =?us-ascii?Q?jC5V5HYsZjjGgHjfrWuIHwdwsy1i0X+/OJu9dAmKxJtTrFraorqjX0bX67bK?=
 =?us-ascii?Q?Wy7T6TmkrSGv2wGblu6vl2enG09jPDU73+Cxds2gIQV3TiV61Zzee1d9carv?=
 =?us-ascii?Q?53zjFoOpLifVm/UOY5fCNrwnNfPUu/V877XcHFmnMg9iADZR6/AoTYbOpzh2?=
 =?us-ascii?Q?qIGiTkI9ZSO+IUReNTM+4KVe1SanTaUgA5unS3DSRGjI2FV+1URNF2wWz0yd?=
 =?us-ascii?Q?XzEKxQzbw2NrqPh+oIskIoAA5XnDPQ8+2IMMvZg8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 382864a3-a414-4ae1-087d-08ddf5f242de
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 13:58:21.1724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vZlQCGFZI3TpfK1PhBFAvTC2MOvISCpi1VkoMHtiq8l4CUhXtUz1vYlElx+n5SRb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9437

On Wed, Sep 17, 2025 at 04:41:28PM +0300, Leon Romanovsky wrote:
> On Wed, Sep 17, 2025 at 08:32:48AM -0300, Jason Gunthorpe wrote:
> > On Wed, Sep 17, 2025 at 01:36:44PM +0300, Leon Romanovsky wrote:
> > > On Tue, Sep 16, 2025 at 03:46:17PM -0300, Jason Gunthorpe wrote:
> > > > On Tue, Sep 16, 2025 at 10:32:06AM +0300, Leon Romanovsky wrote:
> > > > > +	if (!dev->dma_coherent &&
> > > > > +	    !(attrs & (DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_MMIO)))
> > > > > +		__dma_page_cpu_to_dev(phys_to_page(phys), offset, size, dir);
> > > > 
> > > > I'd keep going and get rid of the page here too, maybe as a second
> > > > patch in this series:
> > > 
> > > Thanks, it is always unclear how far to go with cleanups.
> > 
> > IMHO to maximally support what Matthew is working on I'd remove all
> > the struct page things and prefer the pfn/phys variations from the MM
> > side.
> 
> ok, my patches can be found here:
> https://git.kernel.org/pub/scm/linux/kernel/git/leon/linux-rdma.git/log/?h=dmabuf-vfio
> 
> I converted "struct page" path from all archs with .map_page.

Yeah, that's right, I would split this into a few series

This group is all fairly trivial stuff that didn't use the struct
page or virt address at all:

 MIPS/jazzdma
 x86
 vdpa
 xen: swiotlb:  (though make a phys_to_xen_pfn() macro)

I'd also drop the ATTR_MMIO checks from x86 and jazzdma
since the code is obviously fine with any phys.

vdpa can support ATTR_MMIO with the same iommu prot MMIO adjustment,
that would be a good additional patch.

Then there are more conversions that don't use struct page or va but
are not so trivial

alpha
parisc

Then the last ones sparc/power are quite complicated and do use
__va/etc.

Jason
