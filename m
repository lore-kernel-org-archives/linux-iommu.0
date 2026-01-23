Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010065.outbound.protection.outlook.com [40.93.198.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D931C1F75A6
	for <iommu@lists.linux.dev>; Fri, 23 Jan 2026 19:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769198387; cv=fail; b=bcxBIS0wzMWHj9Gwi90JpaAdkB8o9aZWDgOozHh0rUWkI4S8mZywDoCHYnW4q1Gz4G+7Ud98YHPuNiik5o0B/AQpQppxLzV2vXM5TWEw4YNnnDXG806DGEIN/H+j8IONo1Im0ESNx+9lOBBblRtdYY8F1arnt+fE3pxNisGpstA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769198387; c=relaxed/simple;
	bh=vUZYGmqJQhHKtYLo8FOhVKEqEhaHsketzVVqJo8tC1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SiuuQG6SKSPijcH3Y8R4JMYFbaQDHiICEF20QDx2sjRqZhkAAzgkN+LTDfiStUOxch/bMWe0q6/5Of3hBoIwxceGvtBnFeaAC/IYUJ3jrH6Eq9XZiZt7Kb+9wmETieZoktIBxtSnKpR0skNiGbcsNkece3Dwf5L5yJ3Y6TgSaUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lpYblUSQ; arc=fail smtp.client-ip=40.93.198.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lpYblUSQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gercXt/JQb4jCQhnv4LL+7TiSF/aOaDayiPp43qpyF5UvOU4r9uelzB8PtF0m5Fb70Zz6tlfiaGnqBopnbIJm3QbMB0MOsHAuKdJpnvLN9ASlg/aeReSgbQhGXS0z29mDBH6rZmvDDXXeFMyoxWwM6YwZVvqJHBfrhKPsA5pYGXHJ5Dod+6NINVFb01YLHmJ6Rg1lwHiZ55CsU2A2k5bnVjOKuCwZN7XhMOnrg2kmI+EisgcAJBdf5wmDyIbGMryffBh3kiVtYzNm8YmtZOziWl5gp16+bDBvGRql/NsjuvHWvL8yM0ThMwKdAcjnxIgKepPQmABzUnhT4x5j54cIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yWEaBSuKKtwBn2eSR075U5Z5M1wAEIAAleaHafzIPm0=;
 b=tQqZnoo+ZAlXnZUzYMa/TuHYRFOVyLyDIrTcjYtuQu/4TlxTwzQyUO0HcSK+PMejGhj+hq7nrDFaAgaTcVvnWRXeOebAO1fQh5Jcd/662LwYcbU3iWG+0JNbSa1dpTuYQ4p63Z/QbXnGqXCupvGxfsPtMja77kOpzeGZEBcSmxFMVUu7iZdSTWrIsxE5WtITlUeIjJCMZ6UB1M56TaXTtKOgDD8rMxdde5EOk0sqFdOo/OOS76F8QRTAbSvIZhc2JQYyLybS1fmKIgk/gpJG3ypxOf+mcy/cMVzHgAElcbHhRBVpgjx9u/tnpKw8fCdMyec6w4R6XC+xFimVFRdX+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yWEaBSuKKtwBn2eSR075U5Z5M1wAEIAAleaHafzIPm0=;
 b=lpYblUSQBvCZUiYsN7L3sBhjz0FjlVXz5PkKIdFQauSoSvsnbfCGodjxPVfeEW0pcHgu94ahGiOP9U5VrtTI0a9bLcY8+pJSmjmA9CqOShFXQ92WZe0LXzrLU4D2pOB7t2uKcVjr+rKCX8HrgeSH5TB3PoTAO9WK8DmwXMw617UBUj+mnrduCMMQGHcKDdMcFgekO4pMAqqTfuBDCTK20ZAMSU8xDOyfL/HQhGtz7ZC4FjzHMFvuSrVt3nFglvPvEquJmXhCY983TqH7S6bhBSBdidlt1D8wUuRtt1KETOTAmTkRdG5D7nZDPylVpLCpThulNAGfIKUITJ9RQk4spQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH0PR12MB8128.namprd12.prod.outlook.com (2603:10b6:510:294::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.12; Fri, 23 Jan
 2026 19:59:40 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9542.010; Fri, 23 Jan 2026
 19:59:40 +0000
Date: Fri, 23 Jan 2026 15:59:39 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Will Deacon <will@kernel.org>
Cc: Nicolin Chen <nicolinc@nvidia.com>, jean-philippe@linaro.org,
	robin.murphy@arm.com, joro@8bytes.org, balbirs@nvidia.com,
	miko.lenczewski@arm.com, peterz@infradead.org, kevin.tian@intel.com,
	praan@google.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 7/7] iommu/arm-smmu-v3: Perform per-domain
 invalidations using arm_smmu_invs
Message-ID: <20260123195939.GE1134360@nvidia.com>
References: <cover.1766174731.git.nicolinc@nvidia.com>
 <308ed579c724879a4a20b19ccdcb33e917597d77.1766174731.git.nicolinc@nvidia.com>
 <aXOqwymxe-nzYpwU@willie-the-truck>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXOqwymxe-nzYpwU@willie-the-truck>
X-ClientProxiedBy: MN2PR04CA0026.namprd04.prod.outlook.com
 (2603:10b6:208:d4::39) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH0PR12MB8128:EE_
X-MS-Office365-Filtering-Correlation-Id: 776d31e1-a778-4ef1-0cc8-08de5ab9f185
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3+g0jO87HELbcdoju/eHJ9WPJz4em/wDpEHL+SQYLHioZvdc9gK0BreiGfkF?=
 =?us-ascii?Q?ImyYMY0cEfLOIk12n/X0rkN6ig2jyzncSmsW6ebuVGnlmKeQcmutC41mwxQC?=
 =?us-ascii?Q?qMdDHr8RWbrWAndC7AAbhyDQbRHB+yI7LHbyQf4skUWCk90OcyKLEKUg155c?=
 =?us-ascii?Q?hU5ANe47iPIuQSvIvBluVDfjT//KDWRvHRfYQLmjin3nQbMTY6pFxMJNhkpg?=
 =?us-ascii?Q?INBS3pJDK4zOAutkgQLEaDgzeMDfV4eoTYRN6lKiEfXVGDiXSj8ighIc0wAh?=
 =?us-ascii?Q?9nMYwpKxMyZWs36N7K71ot6ivnHLfrZ4OViCc0hR5q59GWl9gschbjEWSeTj?=
 =?us-ascii?Q?fpDvAQD05TonYYCX4IAGEO2KWAFOnnpzFQvFwrQjLnApX+0W/le5O/DRBKpS?=
 =?us-ascii?Q?JumqjQM+z50oCB7EL6NFUjzdoC2Asz+MC4LzikuT+SOBShBuyq0rl/hAPQxG?=
 =?us-ascii?Q?BfjHjs74p+LhCxvaoKB7FVay1rvde1Y+400XUGJ1T1nfoy2zBPuvZxB3J6+5?=
 =?us-ascii?Q?6C2zBUmciHAs1LbhquGlMtszsWfOXWd1IFoiFCUeZn3G6gPK8gOMlzVpQsJn?=
 =?us-ascii?Q?dmuQF7AkE5fG3aGXUY2bV2i3JlZZRK6rh0NDKsNSsK3P6zn5SBZOgw6qsgik?=
 =?us-ascii?Q?F24rJCxUceThSjpc6WRambZOCweJJEoNCWCd8IZwgvY912tUrnHLaqZqtJbu?=
 =?us-ascii?Q?d69dUdiCBpY8yjngrTXHolAGDwNvIgOlyFilaJT6XO09PqHKYGswWUm8ByBg?=
 =?us-ascii?Q?k/gHX53LKHMwbiN14sQ7eCunD+3lyVcOjRCSH/d+Nbb4fOIaWUVVFB5uSXzv?=
 =?us-ascii?Q?fQ5mZpNVbOEt4LrP1c2GIn0GrQQktq/pFzkfqYJn/bAg9KVqyDqtnRQAPMwc?=
 =?us-ascii?Q?P4QganpNAcTSDW4x9ujr0VcADkOkV5DQm39fQlVsbiA81RcauYz5uB+a3o10?=
 =?us-ascii?Q?lLjKD+CBDUmVKtp0GgNSxZSQyD9Q9n1AJkBnTr706t2SU6smnmVIaZEV21Mq?=
 =?us-ascii?Q?haHET9+twOdtUiJDE/KDM9AOf18in7ldNdu6zoVfnwPaunWD5OhMdgITVKnM?=
 =?us-ascii?Q?YeVoqmso/hL/2qbqDjLLcaV7Yz0/He5T2CfiaOTSYiaHn5cn9IvxYJRjWgp6?=
 =?us-ascii?Q?VpTnjgnCkdx4n5BMTLD4T9LnAPKn1DNvR58wWe/4vnKX434bLnuM8vVH4BeU?=
 =?us-ascii?Q?9EwSKdknVSBI9h1e8rXXuk9BMsUw1W7LceJs/jBzaxT+6fZwY/hMdRFpfCWY?=
 =?us-ascii?Q?2FeX5aWvhq3O1EinJn8xNjyXOnHoPBpX830lXZi4OhksprmkkMoscgoZQNjv?=
 =?us-ascii?Q?zUSpt2Fh05jo9hZtdEYRAT43CLPzQPf9JEH+EMg3iTr+Em5MZ1ccqZHepcip?=
 =?us-ascii?Q?tAmPKGf8kCMlknt8hKa3yHKooK2l1lSH7aPxp/b2kFuHTfnXhN33tgkKnE+x?=
 =?us-ascii?Q?uVFEXAszBcg2TR/Qp4D0iZ7snikcGJtd4bQA4yYsC+qPfQmoYQSDxpZuw06Q?=
 =?us-ascii?Q?n3wRO7GqotAVQtK1Iv9o/EnIHX4pSnamOpVEMUPSAiJbBVBzyIMH9AyoGzJt?=
 =?us-ascii?Q?m1qWOuhP5VK9fdZwv1M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1LyJEIsc+upO3pr9qAuNQgqN4Q3HvNBnQ1EenLU6QUZUljOtqyBdCA36Q1NH?=
 =?us-ascii?Q?G2HtqVhijWUMB69nQ/FsbbKQ4eZs3wcMVf+ESkSmuiJckUc1z35eZzvmyBfu?=
 =?us-ascii?Q?pX1qOUR1+zNNNMWoB6ZSEd5EK8OSz/mQtMRxkmOqUqaVjprWlfF2OMpJ7Fms?=
 =?us-ascii?Q?pMQ49GDIOQa4i+ILgdf9NTYTroj+lajsHoGK5W6oIh3G45OKNf3YxJgpa0Uo?=
 =?us-ascii?Q?7qq5DmaBTsM3UNiBWXiw31xiXbJO7FsBwPokw19POJ+H7zr+/0LVyu2Skds+?=
 =?us-ascii?Q?DWlu9Wp9bU3Dlo5o5npPmjGb0tYJOkL0JWkbScFVuKJgpfB75Ycq5O1FX83e?=
 =?us-ascii?Q?uPsRuf0FUyafITHweC64/sUJZdRbyptPgnxyH7lVzulOaUvYKde48173GBgJ?=
 =?us-ascii?Q?IrVO2nL+2h9Q655DvrIC/CvEr1t4+gwTe8Vyhr/0usXtprRKy1oiYNPaBM4W?=
 =?us-ascii?Q?RiZf1eSzqPNmgNpPVcH6ku8eSIP4yC5IlU1576O6hTmsa7KSxMkDVvtxqcT1?=
 =?us-ascii?Q?YL9rSkYOJ74zK3tHW1bReIA5XL44OwNjxFMO20nYFredzVOqlykaUbuEAZTb?=
 =?us-ascii?Q?w1S/FCiASmHaODIbCI7s6X8/9IRZn0QwjqU67oiTwwXnXyRODjE5yDucOBxY?=
 =?us-ascii?Q?KiEXre5XNhA+PzQudlW/sC0AS0sfD+FN2LQ+O8wPOuH0sgB2K7vE66M6y6tw?=
 =?us-ascii?Q?fPUdHgBdQWVKUd2sS+219I138ByPAzJ1eaGh82ADMfc1erhTMFosiVTgwosx?=
 =?us-ascii?Q?GzVmjkBruAbTpGNb1BSvYZ4WhPNa8P5Mfu6lVm97my1QdN5g6l6ci2eJJjvu?=
 =?us-ascii?Q?uX70n46wrBQShqhZAx9m8Fyw0hTelZLwoyek2BDPpXU/qe9l6jPz8shYnwad?=
 =?us-ascii?Q?rRTWTIH5gcThHVjbpF+cGP68HWk0SvwwjvDbGjNpMPOeqvyBgO7UAZ2L8W6e?=
 =?us-ascii?Q?t1DRyUbWfJPGVUY2mB7yD93rEMnn31XcrfdBtMs2JWN1ZzmuFdX1RLSsRdW+?=
 =?us-ascii?Q?UlWz8NfzOJstp+GmP1n1uj1yB8a/MsmYQOwOygwKhB0RChRoDlvQNjjxWIb8?=
 =?us-ascii?Q?vyoIagQnmfIQAsroTTYfmLVivDMR9kg9KdS2h2FCqIk4xBpwXpU2wUPS2zf/?=
 =?us-ascii?Q?kMQ/8+7VxmlKBeziejO5BxdjX6u7H8jMyVdi+FNhA6bip9g7JiGRJAPqboKU?=
 =?us-ascii?Q?zopRJMVWZGG1fz14BwWp/MMrHFS4FsDelgeaVABVhWzJsPZ+8rTqg7S8DlW7?=
 =?us-ascii?Q?3DJE60nCY4i8wAxXaRTgCKqGgDHywz2VLYuMkbcc41gbaIGzX7kueMDRvWVl?=
 =?us-ascii?Q?mJeY5SS4eblNikQwq+ERK2b/J+QX7IeVihOEIxlmlSPaVUCk00j5syfKHpof?=
 =?us-ascii?Q?f76PsB4ezyx/SxEWPyQB/lEtSApA+SYgKVVW6iKFmXwKxi5SizlihpStIQEv?=
 =?us-ascii?Q?7Mzmugj7t4nHieHEFWRibJssVI7DIJsxnRNFEBDEuKhr1HHH50+ajBeBDlcn?=
 =?us-ascii?Q?V7oqo6SHJ0FKVFbC2owqModvsQBUPmHwGjyti6vJmIRIc8P2Yul6hcYmLZVv?=
 =?us-ascii?Q?1wf0lHyhoBDw9gx3J4NVKMdEXpNN2yBEZiEWEgbazxz1R3zfYDWqsya7Tg6P?=
 =?us-ascii?Q?K1MrO08//HpIoOpiB9abW8tqYUSzG5p1dy0SCd6ftQDa747xzsZozYyrDR/m?=
 =?us-ascii?Q?0+mxaD3Dxx0z1OugU+K0touk7h4I3+/mCKXwDF6MLr2N5HoKKQNo+mywCKSe?=
 =?us-ascii?Q?FHGnVKmNpg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 776d31e1-a778-4ef1-0cc8-08de5ab9f185
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 19:59:40.2165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KsNfpm4TGbwpGT5ocmJ5eKgmO2Hvd0jWrR7JspHipZV2N+DOGhzMLTn8djM4VwDF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8128

On Fri, Jan 23, 2026 at 05:07:15PM +0000, Will Deacon wrote:
> On Fri, Dec 19, 2025 at 12:11:29PM -0800, Nicolin Chen wrote:
> > Replace the old invalidation functions with arm_smmu_domain_inv_range() in
> > all the existing invalidation routines. And deprecate the old functions.
> > 
> > The new arm_smmu_domain_inv_range() handles the CMDQ_MAX_TLBI_OPS as well,
> > so drop it in the SVA function.
> > 
> > Since arm_smmu_cmdq_batch_add_range() has only one caller now, and it must
> > be given a valid size, add a WARN_ON_ONCE to catch any missed case.
> > 
> > Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > ---
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |   7 -
> >  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  29 +--
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 165 +-----------------
> >  3 files changed, 11 insertions(+), 190 deletions(-)
> 
> It's one thing replacing the invalidation implementation but I think you
> need to update some of the old ordering comments, too. In particular,
> the old code relies on the dma_wmb() during cmdq insertion to order
> updates to in-memory structures, which includes the pgtable in non-strict
> mode.
> 
> I don't think any of that is true now?

You are talking about this comment?

	/*
	 * NOTE: when io-pgtable is in non-strict mode, we may get here with
	 * PTEs previously cleared by unmaps on the current CPU not yet visible
	 * to the SMMU. We are relying on the dma_wmb() implicit during cmd
	 * insertion to guarantee those are observed before the TLBI. Do be
	 * careful, 007.
	 */

Maybe we can restate that a little bit:

	/*
	 * If the DMA API is running in non-strict mode then another CPU could
	 * have changed the page table and not invoked any flush op. Instead the
	 * other CPU will do an atomic_read() and this CPU will have done an
	 * atomic_write(). That handshake is enough to acquire the page table
	 * writes from the other CPU.
	 *
	 * All command execution has a dma_wmb() to release all the in-memory
	 * structures written by this CPU, that barrier must also release the
	 * writes acquired from all the other CPUs too.
	 *
	 * There are other barriers and atomics on this path, but the above is
	 * the essential mechanism for ensuring that HW sees the page table
	 * writes from another CPU before it executes the IOTLB invalidation.
	 */

I'm sure this series adds more barriers that might move things earlier
in the sequence, but that isn't why those barries exist.

I think the original documentation was on to something important so
I'd like to keep the information, though perhaps the comment belongs
in dma-iommu.c as it really applies to all iommu drivers on all
architectures.

It is also why things were done as a smp_XX not a dma_XX. The
intention was not to release things all the way to DMA, but just to
release things enough that the thread writing the STE can acquire
them and it will ensure they are released to DMA.

For instance on UP it is fine to have no barriers at all in the
invalidation code, the dma_wmb() in the STE store command is
sufficient.

Jason
