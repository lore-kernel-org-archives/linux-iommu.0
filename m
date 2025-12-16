Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010040.outbound.protection.outlook.com [52.101.61.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8896A213254
	for <iommu@lists.linux.dev>; Tue, 16 Dec 2025 14:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765894518; cv=fail; b=CDLevXYImWoAtG6fp49wv4jqwKt4Mew49qWmQZOgArgIdRl+RAmZRwa/JDsH76761bZuAolT5Bly8gixkbQo356IPVckHM8yHBBdGCss0PCAYtFH+3E7fqx2aiZMtLt63ZjbBknC+Q1lyFem6YiQmcC2zL/6rOXAuzAYPUIhINw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765894518; c=relaxed/simple;
	bh=zi832yiUD+0oR9En5e81WNGnPh4aALCK5gKjgmMmv+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bHn5bt0HuUWj9Kspz2SNi+hTnCqmh4glH8s3f1o8bon82a9iVXBlzP7GxB2gZvFY5HZqT+UdWN8SBXvIdyWH60Ze7LkBOuq4ghsjUjC3bRIoI9GjeznHR3vSQAF9T+K6X6K44u679IlpxRwxBciBJmwhOQh3l3wJnsUfpjacA9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MLa9Wg1h; arc=fail smtp.client-ip=52.101.61.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MLa9Wg1h"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SXMWsxq6zC1aJjLq+eAl1LEodCxkUvx2MtApxA5IHg3wZTz1uR/9DsfS7ELpo37zu+NjMP4ETJmAmuT6bGlK4iIRQaA95+1IR4JtkYsvcUsrc25Eu6z3uwaK0922LsWvE88L5Id9hA9+esykKXeZmWn9mo65R1BSclO7nVl7Z9C1c5TD+vgItQ8AJgH3kwDd69qn24Ll+QVw4E9hfnGb4CtFpUy+aE8wu7xJdjaSnLbMrI4YO+iYZQBBW2lFoPt3ELtPhOfa5JCh8KTweJGheCdxrUvi+/vlFTyr1AofzHqzz+cJKucuBK3z7OmAX3VBkQWrVvxfVb4pEL4cQfgRIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4HQNYqcrifndsbZXq0OIgnt36zz5QSPlNvAW5+nhfaE=;
 b=oYL+VD1cIvNNMtv4pRpU+XmSfx/1kU5JQSQRkRZbG/KNmtt2Pmt//EgJHoCGNVX7QSg9DuBN8n4/eEqBRmo5fHdPWBYM4dH4aSL7+4AlV2Mq+ktrWE21KvXNdOGQeXmwmx+68BT4tK8rdK3cDbrxPuhmFyjgLL1uWDYqAscvHwuruk/j8KRjgi4qvJe5kZceubR0977Cf8aMXtHLKcigjCv2F9Wo3LMjLsCyIyng2nhSCCDbR9xydDUdTXV4flOzn2nGjFSU2YswnDCnmcXWtl4JB7MhEWkr5f5DWWZpKt5HCiQX4yvcxce0WSIj7HlPft4hWBSstXvbvmKd+gmfTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4HQNYqcrifndsbZXq0OIgnt36zz5QSPlNvAW5+nhfaE=;
 b=MLa9Wg1hfceSOq7drIFK7Mxvb6mu66529VV5J2Ci+HpVhEy8qlpjoQRqYibcWWV/jgYkkxHWsAMn4UqZa9zCKAQ8OTJAJa9owllBqcLw8u1trqXBSiec5E2CzQ2yvO2HaHcZWSef1Xw/3+mnm9Lisvek7+QH3oKdIKXOBZcdym/Fo6Y3k+sRhYG1pkcK3+1uQXHNXTqGfRpUP+xMD5juIcDuPCGd/DP6gZZkvtPIsIfxCEQK6EkMnIDxq7uaXxLm/uuTaf/HGjl6a7rKvFiAbBT5WaTW/Y5LK3uCLGRxcJt4f0KidndYtu0AUm0g3VXctl4HKvJPr2lYQq5cA3AwDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY1PR12MB9601.namprd12.prod.outlook.com (2603:10b6:930:107::16)
 by SA1PR12MB6749.namprd12.prod.outlook.com (2603:10b6:806:255::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 14:15:12 +0000
Received: from CY1PR12MB9601.namprd12.prod.outlook.com
 ([fe80::cd76:b497:475f:4de3]) by CY1PR12MB9601.namprd12.prod.outlook.com
 ([fe80::cd76:b497:475f:4de3%6]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 14:15:12 +0000
Date: Tue, 16 Dec 2025 10:15:11 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org,
	jean-philippe@linaro.org, robin.murphy@arm.com, joro@8bytes.org,
	balbirs@nvidia.com, miko.lenczewski@arm.com, kevin.tian@intel.com,
	praan@google.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 6/7] iommu/arm-smmu-v3: Add arm_smmu_invs based
 arm_smmu_domain_inv_range()
Message-ID: <20251216141511.GD6079@nvidia.com>
References: <cover.1765850465.git.nicolinc@nvidia.com>
 <f4261c5b30ce3c6942470433033d4933ec5eef3e.1765850465.git.nicolinc@nvidia.com>
 <20251216090926.GR3707837@noisy.programming.kicks-ass.net>
 <20251216135613.GB6079@nvidia.com>
 <20251216140410.GV3707837@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251216140410.GV3707837@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: BL1PR13CA0282.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::17) To CY1PR12MB9601.namprd12.prod.outlook.com
 (2603:10b6:930:107::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR12MB9601:EE_|SA1PR12MB6749:EE_
X-MS-Office365-Filtering-Correlation-Id: 8aa62a51-a82c-4d11-57cf-08de3cad86f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|3613699012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?povT3GWsPDZ+oXPyQ0TrC5HTk+RF7JrkVmhH5H98bR9BELVr1YND1/5tSuXE?=
 =?us-ascii?Q?EUReJ6cawiJk9pb4S7z7DavMrmM2zmCpPeWHPoCI+JvziW1CZ8sHEGTR/kpd?=
 =?us-ascii?Q?RtwNlL90u7yPda8/Iy8VnM/RDbLF3lz5pkZ9kiXeXxYybYTxuY4mIgCDcyEx?=
 =?us-ascii?Q?AuL2MIG+r3OEIGtc5aq3DpnrA0l7L3C1weHC55jOcjfnvfKCRga7K8vZxH7z?=
 =?us-ascii?Q?H2fIdnv0E76hycXagvPKlh/VV1AtKYR9Jd6Z++0AKYU86lhZuHA/UjuYsD3P?=
 =?us-ascii?Q?iKonqVvbn9aR46M1UX14m04VM67vcRyvUov+vk0hdJFYNuH4IkXaCeGdYWvd?=
 =?us-ascii?Q?MGU7F9VVeKGPh+S/wK3XZDBML9Si3BlqoC27BmhCLwvdemfdS5FFTyGGhnub?=
 =?us-ascii?Q?Ir163ZwT+80+NA9SYoL9W/y1MheOqv0Kn5oCm2daG9mOse0o/2g5axOM5yT2?=
 =?us-ascii?Q?TOyWJAxE8q2aXea5ByJFEXDoSoEYFDJTkO3mmVgkP50OyiumekmkT2m9Zqhb?=
 =?us-ascii?Q?vgVoqZ91CIFZmfsGToebSSVHty9HWcie062eVwPe0hJIn0Yt5EKtdowsNcE+?=
 =?us-ascii?Q?7RvrM2V4tA6dih6412g8iUrbWL+CWrYjM7mEehygnrVH5/TZpJZPH2Ts+vRm?=
 =?us-ascii?Q?lQ+GsvcjRzgUprndDFKExgw26eLErAbWq9UZsXFpjuFF/A/rS1bgFdsZELic?=
 =?us-ascii?Q?dEsE085ynWrNJppW+iKO++bFr732izCtFvZlauI9z/OCnnEz5uHnUoNakosT?=
 =?us-ascii?Q?5FlJweGDkFadJ65vZcXt3QBQTvJ+easVI7+ppi4zNTu7rE6MJ1S0XKHvuyHv?=
 =?us-ascii?Q?hbLjPHm4Th8pfADKw6U+h2LXJqZWiGhWSKZF11BHGbhurqmqu+luqEi+Sg3n?=
 =?us-ascii?Q?9roRsKgZm2u3wyBjZ6jbRsYB7YjGOBdExjyHEVoBvUkpUtkFqdBJKVgTwMH1?=
 =?us-ascii?Q?VVTqj86syQyLRsddNjvCN2iR0bLpItWYpFk0rcLO0b7Bn/wABqcovxW+uy0U?=
 =?us-ascii?Q?mNkomnzbKE9FqSizqS5z9WN6HpdIyMegeay2jQe8lmiyFdGMiXV8hIrkABdB?=
 =?us-ascii?Q?vfrZz5olVIPf6aAEl5KjPvLtbhFfNpIOEOPA5gTsmy+9n152Qz4CbONiuRRe?=
 =?us-ascii?Q?p1VSJ5NhBcUvzTkOLXf54aaY5PRTefKmo9GhnliAngyNInR8FEBvgRo10LsN?=
 =?us-ascii?Q?fAWmFbsOJXzjKHY4NLUN5N5T8b6aM7tw8MeOw2yww/W3NCiVUcpyfDjk2SXA?=
 =?us-ascii?Q?AKtW6A0kR6LG9FzmY28Tbjslh5XKTL+2k5clP1uq/QTSodInVJcBUUolTdBf?=
 =?us-ascii?Q?9VXECGRqRoMVdpSkWmW8gyiIf5oV/1w7HhkYTp7ALx5PyifZLSzGJGe9FZQe?=
 =?us-ascii?Q?wuOJ3BplbwapKNSv9SjFBMDl2rZx/rQeI7r8s9Tw9x+Yky78j0eE2NTlu7eL?=
 =?us-ascii?Q?vGaJnDKCupd7nzObO7ikP1zhLeu8rpPSXaD0A13jTOPwLiri7bTM9nCRQZeU?=
 =?us-ascii?Q?8l2hcj25fM3fOCFoIs6RadTEvH8D5ZUpLRF/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY1PR12MB9601.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(3613699012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HTKQ3pwBV9b/UIgsr5+/7A9UmDYBFbhyrj8dSx1fSR4aool4eviAR6XHD+ac?=
 =?us-ascii?Q?KaNkoCBAgXnPOkwH1oK2xU3Be+RZH9Pp9wuB8qXlZHN87rmZNkKIOQDWdj/s?=
 =?us-ascii?Q?izMtbK5nGvMl3RyqCu7JpCg/n3DrmUWquVg7gUz4nnGY6R2LYlXL4AhacNsw?=
 =?us-ascii?Q?m4fhiOMoMxiBAWS8cxQiWsz+PsW7GeAQ2F4qjNOK4uPUDGVZHNX/z+jxpC0R?=
 =?us-ascii?Q?Y40yl8g5mP9jSHwKnPdoUmqkUNLuuFoLqfMOk1QHa9exfTVxiJhJnZRW4ycO?=
 =?us-ascii?Q?YStWr4C2V2noamzB1nOkOh2SDzifXcdlkO8B6j4mxojuWLG053z+IwFfcW81?=
 =?us-ascii?Q?KRt1K3zV++GQT9TJo3q7yghUFpuUONSCB77sVu4LLOCgB457Vvr7X9vWL2D0?=
 =?us-ascii?Q?TmFJdtiKw+omaOQNlh90+3WV+hC85bvwfloI9pV24kILETykkZSrg0PnqgAx?=
 =?us-ascii?Q?Xu2YXxDbG7zyBfR5VaNINl3zH1XpV1CH47XysVwglOh6RBAHpO4nMBZS3jzG?=
 =?us-ascii?Q?tm/P8UwOAjVSrIrbHx3ni/s04ZdKslcJgK8DuCxvJr+D55xv2zttRs9TWj19?=
 =?us-ascii?Q?c7UulcCx0+9pIoTGf46UST8fO48Z8DVeP2U5jFFXF6ZWIIdXjEfROCoPNpKs?=
 =?us-ascii?Q?oFJ46J0RJvfD69LzwLwVRMfvwNVEmfQOHf05hex70yKpI2JEUqaxrEiXCBf6?=
 =?us-ascii?Q?G0sU1qt5yaNex6getzvz0oZZSw/5QcaVle5kEs/GFaLdAQU1x57lPcJqGlIu?=
 =?us-ascii?Q?aJLVpCojj4M+hDyfPK4Wqg7dkyXW7btgGu7gRw7wshIJGcSNDjB8nZ/TgwTy?=
 =?us-ascii?Q?HsHKqweWgR73iuq8d40Vp45q04gd1eU1hkKUED1rUNvuiSpc3UVDdZYsKnQi?=
 =?us-ascii?Q?Aoyy75tJ2WJVMNHLps/af0rhGiFA2pBOgb4NlfZQpPz3RZX1w8cCTYxsqObN?=
 =?us-ascii?Q?ESqsr3zQbrtZbk9zSWJc7gEXkwxB8/AovWd0HHjFzVTmlEEBAzeTdQ3qpYYq?=
 =?us-ascii?Q?5V3ahBAZuj9KyQcyYo+Bur92ct26tOFdN0akMYdyDEHpFEaE2RJOJMG1yC3X?=
 =?us-ascii?Q?ibLzdhbphxL+3zDaLTgEmWm/sxzWoAsFSCV9TyB9PEKdQehcbUmiMp8sSD6w?=
 =?us-ascii?Q?72pkkrMhvXoA6iaoM50ReALKw6xdxycXLgafKDPLzVc7hTMWRuSdY0URiQ8c?=
 =?us-ascii?Q?Q2NsWXGePtQ0x0rCCVowfgZGIlRsxP+58IxjwpQZcyV3dwriFXlEcIcFRNlL?=
 =?us-ascii?Q?cc1WWxcydW7Gsh59yKkGTSIPjeNDKdpJ47iFfRQLdYu/g5u/1YO7yEtK3w89?=
 =?us-ascii?Q?CWlEmJKbf4OX8xOjTO6EHSxH/U36/V/hap6xAgEOnHh17smN4BsfarGvW8av?=
 =?us-ascii?Q?NheuPwb2E9OJW8utBtilYbtW1C+MY3glCSmGLDQOUFZlb5jQPVeg/lzqgX6+?=
 =?us-ascii?Q?WbjGG6YPHdxrsADhQG5hwWWiL1PguXmB4s7C06SRBstEH9RnvdQyUPIbsjEs?=
 =?us-ascii?Q?XzBihBv74st/+y0sVHQ3Wiglt6yvfqFZqIKEsIg8FGEbHRRCihiFkzV5PNJa?=
 =?us-ascii?Q?vGLcDQhZz6Mlre5R5kU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aa62a51-a82c-4d11-57cf-08de3cad86f2
X-MS-Exchange-CrossTenant-AuthSource: CY1PR12MB9601.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 14:15:12.6490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EjUTdEaJiaXFs2EhE1iLm0OvJFD3kIrDzQyLgWlTvDRHggQgLJ66tP+n9Kie4kGN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6749

On Tue, Dec 16, 2025 at 03:04:10PM +0100, Peter Zijlstra wrote:
> On Tue, Dec 16, 2025 at 09:56:13AM -0400, Jason Gunthorpe wrote:
> > On Tue, Dec 16, 2025 at 10:09:26AM +0100, Peter Zijlstra wrote:
> > > Anyway, if I understand the above correctly, the smb_mb() is for:
> > > 
> > >   arm_smmu_domain_inv_range() 		arm_smmu_install_new_domain_invs()
> > > 
> > >     [W] IOPTE				  [Wrel] smmu_domain->invs
> > >     smp_mb()				  smp_mb()
> > >     [Lacq] smmu_domain->invs		  [L] IOPTE
> > > 
> > > Right? But I'm not sure about your 'HW sees the new IOPTEs' claim;
> > 
> > Yes, the '[L] IOPTE' would be a DMA from HW.
> > 
> > > that very much depend on what coherency domain the relevant hardware
> > > plays in. For smp_mb() to work, the hardware must be in the ISH
> > > domain, while typically devices are (if I remember my arrrrgh64
> > > correctly) in the OSH.
> > 
> > The '[W] IOPTE' sequence already includes a cache flush if the
> > inner/outer sharable are not coherent. If a cache flush was required
> > then the smp_mb() must also order it, otherwise it just has to order
> > the store.
> > 
> > The page table table code has always relied on this kind of ordering
> > with respect to DMA working, it would be completely broken if the DMA
> > does not order with the barriers.
> > 
> > For example:
> > 
> >             CPU0                         CPU1
> >    store PMD
> >                                         read PMD
> >    store PTE 1                          store PTE 2
> >    	     				dma memory barrier
> >                                         device reads 2
> >    dma memory barrier
> >    device reads 1
> 
> But here you have dma_mb(), which is dmb(osh).

This also has a pre-existing dma_wmb(), a fuller chart would be like this:

   arm_smmu_domain_inv_range() 		arm_smmu_install_new_domain_invs()
 
     [W] IOPTE				  [Wrel] smmu_domain->invs
     smp_mb()				  smp_mb()  <--- arm_smmu_install_new_domain_invs()
					  [build the STE]
					  [post the STE]
					  dma_wmb() <--- arm_smmu_cmdq_issue_cmdlist()
                                          Doorbell Write to Device
     [Lacq] smmu_domain->invs		  [L] IOPTE via DMA

Nicolin, please elabortate more of these details in the comment.

Jason
