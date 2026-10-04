Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011056.outbound.protection.outlook.com [52.101.62.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8377393DF5
	for <iommu@lists.linux.dev>; Sun,  4 Oct 2026 16:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791131728; cv=fail; b=cJj5H7JAVzCwSDp/ER/X2JtZagFjMB3TjNH72Q0XXc2a1/EnvprjjbORt6nb5ZqmBY7hmVK795oEwevAGEohcsMlyVaXA0GgRy/B2OIzBaJrzEm2p7VYCh1cTRJheLns/gkiCvycfEDKC7ZrvHPtWO+oI1+w2OIOnDNNtl8ABS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791131728; c=relaxed/simple;
	bh=GOAjdFuKdBSdsldN5WGys2fRZHUMjGjYFFr78HPNUQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=l4KbG76nKs6nwITJ2NOJYDNMyCxwrUJSzTVk7WdluzLKUnEaRbd8VcoUFrFS0Anm0DyDrvRuCvMF2SBI/Whc5O0lY/MhMEvIAnTwWF8Oa5Cb7FBu9ZhIz8sMUHB5kpX5uPPYstxhR1MV6TwoQr/BAwGpzk9aOA0Ub5nDJMt7buw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YUeP7fTu; arc=fail smtp.client-ip=52.101.62.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YUeP7fTu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hT/xvkO/L8Yr7M8ClaQH6NZwTl1fZmHQEi0ErIPMt1UTBK2IcMwfZymJ3JJACmSsMjMvX8Nd9Apr4BOL0bmwYdyiu4hjuzTnWMR2GzPTvwAYNyHRnbewBbP7S+LjBX62l+prc+MiFXRk0lPG2AXXuwS7dBqFfidDmvOOEEjfWagVehZg7VGj9zsGV6X6wQnEmIdIv+Fl8YIvKMXDQkzkwpFetw3e+TxrlpsAidv9xdI86Z10jqpBHarAUA4IqdeunCwT8098OkYN/5jN5sR1gWeJo5uNGgWmUoumy8NWidViu+lDot+NXLFLMpf04+Dx7BNDM4zXHmXEU0rj+in/Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5YgX2AoQaapIat7rVM8bSTabZ6dH/M92RBQDHYFs5nw=;
 b=ZzzdCAQy3XwdBoc5DT7C5UbVFpYovUQat2MladTxvDV/aLPvX0s2suGxOJX7LucC8jfq5IODL7DVXFC7NMYQSUC5ieys+fV5dZUZYGIzg7rEhwmpNKoqlS6UDH8CkVESWaXVtanK+JWnmrGJFkieCnBQqBycRfTgBgPAXV0x81MWqpbxp3vOm+V8qXpGVkwlUhGvpBmCwxPa4YyQWspAVglZgGZYJ0tawZaLwPV5kh40rDDHHH1qFS79sbZkzRwaPRHCTMdptP1fhgsX1LsxIkgBo+NzYWQMyq5NCwWAb/Q6QW5MEFM3xH81QHn2DsSAeTngDWnsOs/FRY0we+g9Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5YgX2AoQaapIat7rVM8bSTabZ6dH/M92RBQDHYFs5nw=;
 b=YUeP7fTumXJrXgl673cZKDcQLZ+efyJp2kgxKXPNyyEkUvOBVoOvMGOKWFI6YKLArTAFG5jD26GDo4gBnSp000cCnUt6bUUm47Jg+WSOCZHxm2+b+eakZOWsuJ3euha9pkdq+rutXcvwJGXQJs/iDZibxtuSr/51lF2r2YSmFhEjp0Q6KoKUBVMBz4u61nhitcJdrzVSDvpGGLT1UmpcgiyJ/YshPbXKz54XgP79YcOQ/3ga0ZgLSI0JtJc+vCEGq76lOlgMoXeaV0X2sA9XEgy1bi5Brpw78lwq/FNMZFkU7Mp9FKx4keSYBCDMdg8Ma7Gc2r7VpgKwEyG9r7jEWw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by IA1PR12MB8357.namprd12.prod.outlook.com
 (2603:10b6:208:3ff::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Sun, 4 Oct
 2026 16:35:04 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0472.016; Sun, 4 Oct 2026
 16:35:04 +0000
Date: Sun, 4 Oct 2026 13:35:01 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Will Deacon <will@kernel.org>
Cc: Nicolin Chen <nicolinc@nvidia.com>, robin.murphy@arm.com,
	joro@8bytes.org, praan@google.com, kevin.tian@intel.com,
	smostafa@google.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	jamien@nvidia.com, kas@kernel.org
Subject: Re: [PATCH v10 06/13] iommu/arm-smmu-v3: Add
 ARM_SMMU_OPT_KDUMP_ADOPT for kdump kernel
Message-ID: <20261004163501.GB4064@nvidia.com>
References: <cover.1788130528.git.nicolinc@nvidia.com>
 <d661395d986d3aa78af200f55e43740996ee8a0f.1788130528.git.nicolinc@nvidia.com>
 <asJTsw-oWDlSqNa3@willie-the-truck>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <asJTsw-oWDlSqNa3@willie-the-truck>
X-ClientProxiedBy: VI1PR04CA0116.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::14) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|IA1PR12MB8357:EE_
X-MS-Office365-Filtering-Correlation-Id: 60515a4a-9d2c-49b7-fbf8-08df223571b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|7416014|1800799024|18002099003|22082099003|4143699003|6133799003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	gKvg0zPyupSW5xGMT+DH5XlgqTxyHrZVyffjpUkfUjrMvZJO15yqmDNZkauWdHm724clahM58P/sY7ZB+SgwWtpLMbcgSDjDPG2AcX7hSx1NpY0FNTLlmaOuesaNO+/4dApeXBlG93V5sr78lmbk08llcm/z5xblfYDD/6ip29Kput8v++SBSUcYE5yCsihBpNe4craGCHWdAc2N0A5Cc3lLvmflV5YFTqzqJqNs8nVooLFLAVGO3HIJ6lWZh1iJhYHdhFqmLDicClmHofVzSVoq2V/MPRO0c+bD3YIBFjCULfrrQt1ES5otFeB6xB48SovM4kxHHFFgJFnpf872GWQYctpUD8IzGn6WQJRhY8s6gFmngFIkvmRY3i688BTgszT0smQIBwx/cXDEJAooAsTwa8ZyU92Q7lZMnqLXLBX16d9y0i0F5ZdBUeA0gG/Q6h1eKwDk+aRt8m4yk1WYacbqlbU+9Dtjo8tpCNUMHu/Fj0ROspewjIqGRJpAwgtS6NEFKv1QpK7u4gBmkR08jXMpA9uZY0sXQ8x4KglXbLICAw/zDl8HoFWRjaguEPcujuPBFztSANdSr0zN91Brx1fTzcU5YJNRTM7GeMUHqu0fo1F5jyEFOEKgrA4IDCtw2wuh1lRS7i8hzumLjWdbIGPgzl3PE96akYXmELexX6Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(18002099003)(22082099003)(4143699003)(6133799003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/s3Nf6Mu712YleWEsbzTPHZch2pacxmoQoXJRquDASqkzclwzYNvCChU65IA?=
 =?us-ascii?Q?gRUvt/x5ezcYk3oqrXsI7q9xe9ktUoLgp+k7G2cmtysW0/l8QMBzTnpEG9aX?=
 =?us-ascii?Q?PHUBdelEJb/z9l/VoflDWGkVVkbTFyJADTXkx+WMbbgFmTJEGRyvk2TMYMak?=
 =?us-ascii?Q?VKlzk6+RHZCHHy5W5k5DZ3s9CbDZqypra4DT7vMqWEyupK2xvqDtx+ES1kTo?=
 =?us-ascii?Q?wwivBVVcX4RSfxppVoABNN336dgHseQzH8YBZUrcHMtV4OPSf06+8nhxTOAI?=
 =?us-ascii?Q?o1lS9BYDKW3FKmaQqycnxvWRkVaeu5mkTL94G+4rxrczHGO5Hckl+KiXoBCo?=
 =?us-ascii?Q?fKIKFPo/4bH6nLLR5d2qAXXjYrEKTe5+RV0s+WyNvwBBZ1k9TQ3BnCQsRSjn?=
 =?us-ascii?Q?n00hV4t3qv5tgQeNmWa/tuYlWyix1uUrStuF2IeIP1pyGqMd+RjV2VgW3zHc?=
 =?us-ascii?Q?qX8Nz17Nk/T+auN2IMfg82FwDyxj+iJP1Fkd9xMvqwv1/iJPTjOksqpP1L91?=
 =?us-ascii?Q?0j0U6V1qNISUccL2nzebFYAvk+DYMde+wEiMKpnXR5gwOzLpzwMbrY0Y7/XT?=
 =?us-ascii?Q?uPEyj0HyMudqoU+imtQ3FUn0sSoZECB3vZysL6BNyeNlcFOnOy88c0NeDUQO?=
 =?us-ascii?Q?g8YfMCUstXZWCSvATHoP0+5sSRaqadrOeY5+q0VsgaiDz9cQidCXofdZYimG?=
 =?us-ascii?Q?qZrsQCodie8+E5AkhD+4mUmMXTHl12MajzBeXOf3ZJS3KsXsQzOrNSXqvPmy?=
 =?us-ascii?Q?Be+kNC6rKdDZ6UTSAvbfzgOnoF1Onn7Pg+4QmwQc3RkJYlF8hju2WjPgVorD?=
 =?us-ascii?Q?iH1r78koLcLgcYEu8BEXCILJpbYUwu7pgwyY+tmvRM8RcXllF/fT1OGwols6?=
 =?us-ascii?Q?PBwRiCmyXAjqEdTnv6IvUkszwLC0snqjNlsBt36/PkJclUrSA+Beu0HeZtF/?=
 =?us-ascii?Q?RMUkQiYpg3O9NeBjqwDV7q6pvEps9m6rnGLOPGY3cWWO17vhP/pXeO5SH3hr?=
 =?us-ascii?Q?KfB1rlBOOvbIMp86AuIyXIQgVxn/W6zKbjebyoCvS5+cWkpk8ENW489wy3oD?=
 =?us-ascii?Q?b2wQARJeeee3fw5vPLU8wSag05Vml2i17ZMsb9TrzMb1PgpbMjkQD6mVA8M9?=
 =?us-ascii?Q?2XRyPZES01M5KL/a/psf3YORw1yIMJkcfqwElOJffdbbLJwZlMX4YQnY+9kZ?=
 =?us-ascii?Q?lUixfHkSuDm125ZE3ul2MBEdboCcSIRSOWDcjtAkwbsCLohz2mJqlaCdC0CY?=
 =?us-ascii?Q?Yoa8zlFfP9TvG8CoDqQ43lJRW6soHVzkbgMDWzOV9UPpizvIDxaKjQ8LS87Q?=
 =?us-ascii?Q?pZnD9tpgsgd6JNkaA2xUeLSGF/RQJiW3Ql5qgKs3Kdtq4dqt93xdq90+5lbx?=
 =?us-ascii?Q?KTDJHYcUjLqtb0D56ed3uXMW6ZZ6kVBQIpbNmeORXmNf9GoAXI0fy44xyYXE?=
 =?us-ascii?Q?yjYMIpF8zxXYOYQ5jbLJIhGfcOANBhH1PH/bXtkv5NSYgIil8D50vkHo5Ibq?=
 =?us-ascii?Q?3L3/lN1gP7cjdyqllcSDQjMcTDUBfuYP9Jzh6XrLJfvGlNgjqpgFwbyg/H7T?=
 =?us-ascii?Q?eEc07p7KfyNxRTVhO0mqNMPKS4rEfqlREDnBLsrhI9qAEiSvL5P+dvnsb+zE?=
 =?us-ascii?Q?5L0k0xFP38FL3l9KLk/YIgWTFP+nBuAFd75R+rHrpBMDr/R5gkixpgv2Dral?=
 =?us-ascii?Q?MclXlnbOW/kPK1/nI2UbbxbqNqZV1hA1EDYOJKuGBudnmuCb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60515a4a-9d2c-49b7-fbf8-08df223571b1
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2026 16:35:04.6781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RlNUO5CZlPeW3vjMeCj1zQ6uALyBuagxyA/0XAFixbEdTCwoqU0Vk/gx7xQvG4oq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8357

On Sun, Oct 04, 2026 at 02:25:07PM +0100, Will Deacon wrote:
> >  drivers/iommu/arm/arm-smmu-v3/Makefile        |   1 +
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  21 ++
> >  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-kdump.c | 229 ++++++++++++++++++
> 
> Please don't put this here. The live update / handover stuff is going to
> need very similar logic (see the RFC from Pranjal) and I don't fancy
> having to rename or resplit this file when that comes along.

Ah, I was thinking we'd put most of that stuff in here, but a kexec
name would probably be nicer.

> > + * Note:
> > + *  - Adoption only starts on an SMMU that the crashed kernel left enabled, as a
> > + *    disabled SMMU (CR0_SMMUEN=0) could hold meaningless register values.
> > + *  - Values read from the crashed kernel's registers get structural validation
> > + *    only (format, size, span, alignment, and ID range); the physical addresses
> > + *    are not vetted, as the kdump kernel has no record of which pages held the
> > + *    tables.
> 
> Can we at least check that they don't point at the kdump region?

I don't think it is necessary, I  was on the fence about all this
exisitng validation even in the first place.

Is there any easy way to do it?
 
> > + *  - A structural inconsistency at adoption time tosses the entire adoption and
> > + *    makes the SMMU fall back to a full reset blocking in-flight DMAs.
> > + *  - L2 stream tables are adopted lazily at master-inserting time, to bound the
> > + *    peak memory use against a corrupted L1 table; any lazy L2 adoption failure
> > + *    rejects that device alone, as its blast radius is bounded to the bus.
> > + *  - Only a coherent SMMU (ARM_SMMU_FEAT_COHERENCY) is supported, as the stream
> > + *    table adoption is done by memremap with MEMREMAP_WB, which is verified on
> > + *    the real hardware. Callers of these functions are responsible for gating
> > + *    ARM_SMMU_FEAT_COHERENCY once during the probe.
> 
> This is an artificial restriction and not one that I'm wild about for kdump:
> we should be able to support this for non-coherent SMMUs as well. Is there
> anything more to it than using MEMREMAP_WC in that case?
 
I've forgotten why it ended up like this, it was some complication
that seemed hard.. MEMREMAP_WC is not the same attribute dma coherent
would have used, I'm not sure we have the right stuff to be able to
flush any write combining buffer? I'm nervous about that at least.

Remember this is not just reading it but it has to operate like this
after the fact. In handover you wanted to use the dma cohernent
preservation.

So, I think this restriction is mostly a lack of the right MEMREMAP
flag? It is not insovlable just work outside the scope of this series.

Jason
