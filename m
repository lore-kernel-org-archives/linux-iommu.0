Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010039.outbound.protection.outlook.com [52.101.46.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDCB331A65
	for <iommu@lists.linux.dev>; Wed, 15 Jul 2026 20:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784145648; cv=fail; b=RAoveZ8h2UsJPStMSewUmEBurTBn7UA7FYxYAJ9kql+kCTYrt/k+c7Z2bjtCP63SnvG0QdkfwYDCEepSnMepeGfIo6rCVMvXh9ZkAnElxWCr2XE34DC8iw4/j6WEcWpymZJMyi1lbs5tDnvSrDnPC+GbT+NBcpWQDAEtR/rykkU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784145648; c=relaxed/simple;
	bh=L5fMcHnRK9MCRkZyYGYc8maAiRStPcY1ZTBWDfXLESo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RHNzsqzd6bpVTWo9DWykzpKIprBjIPfYMqzFm8aboyCo508vcd25D3tvQf5c1A6jbGtGs9z8M5yktyHoDMcmxZ3sN0t8Z4/Ufh4xCf8pMcNQVLQXBv3exAG1ErXgmjiAZA5Y1gKPbWu0nVs9D9qmIG9I8ubdnzNeC874z0hKNSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=icdo5Zs1; arc=fail smtp.client-ip=52.101.46.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="icdo5Zs1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LLDfyrZogjDZINHUyC5udWmJbGUFokD+IK2YBU8vV5JcGEcmVuFY5T2PG3S915veS0UhjbjSGgoGFcmv4UQhXWu82iC6uvriH9AYhD4zf9TvwuyPUy72WkxDtr+ZzACg4ob8iSSekOMJE6oKVPru4x5wZWIl2rF8yu0V7ZehcXufyF9PCnJt94qhQAucE4UbkLm+MZrAWLQpChAczNX/A/R0YSIjxCi46EJEBK3W14SXlmhk4DVWOVFWjVNTbMGyTd0WpOIoacJFkbtLxk4iq8mQA8dPqdE4ObCuVNl/1KzCttz+lLRSfSXY/eXH9iP/i9oBZ7uSZtlonGtFRGxwRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5rPZVvWmeop85prAURhg3lKwNR451rceKHLcv0LaOOQ=;
 b=gixgA1M8aRCgU0fZUbUPcr45Cd/v64EpDjVxPjA9UhvKanpt4K63Xd3RqyJJwNQH1gc5L3HngLFc9xCJlZGVdvjB2bJSniragbnsUVQYPmBSQESH3pS0sS9oQv434nsRpqYt5Q9RlMc/0ZB7ezv14Lo7TRBjs/aAe0oocUdR43lqf6JvfIAqU57VWRCUqMWutWSEI1DZzuZvfyoD1aBs87Aeg/VQugBFmvYChlKTKaOgOa9mV3l+Iw+NvwjrMTLyU8LooCZ/rN49kpkyOBG525sv4lqGK5pDlHyGuKcDfvRo3ki/EDHwslwFE78xkbLFcsj11vpDSgeACyE8GJTK0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5rPZVvWmeop85prAURhg3lKwNR451rceKHLcv0LaOOQ=;
 b=icdo5Zs1SqmKcBKZQDrgLpcCwWYP8PQ06hpfq+qrS7AA79Y4xuH0cL7u3GYHz4Issgs4dCBzbEkuyWMmN7LFpTXQaNhUycMCEsbPMyzGVTMVcKaVNA/zkFBnuPl/C+75C/LFe4PBSpBNkeiRR7NgREdTRQZOYujMHUYkFrp7KIjHG1CFvEmEXVKPzIvqAQ2FA4A9zrb2QnoxGMrSMmtdDCCRnXZTK7LvosC+t8j9/BAqjeCAMNu8Sv25+8/+ZBHTLJDeUtRNk+LpK5XSxv+APNFujLx8Zapc+qFG1Hc2yadshAGRagEh35N4UvXzy5ZgI4YXSWzIlHhLXYiY1E9VkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MW9PR12MB999208.namprd12.prod.outlook.com (2603:10b6:303:301::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Wed, 15 Jul
 2026 20:00:42 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0202.014; Wed, 15 Jul 2026
 20:00:41 +0000
Date: Wed, 15 Jul 2026 17:00:41 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, Will Deacon <will@kernel.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/6] iommu/arm-smmu-v3: Support IDR5.DS and widen the
 TLBI SCALE field
Message-ID: <20260715200041.GI3775915@nvidia.com>
References: <cover.1784054606.git.nicolinc@nvidia.com>
 <3f0c3e7b7e9177586d7e545d8089ead4ef7890f0.1784054606.git.nicolinc@nvidia.com>
 <alfifgOM_YwTAP0y@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alfifgOM_YwTAP0y@google.com>
X-ClientProxiedBy: BLAPR03CA0068.namprd03.prod.outlook.com
 (2603:10b6:208:329::13) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MW9PR12MB999208:EE_
X-MS-Office365-Filtering-Correlation-Id: 52b5d5dc-d8e7-4df7-7ced-08dee2abbfb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|7416014|4143699003|11063799006|56012099006|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	2c0xtunGYBrz2mZ6erU0k4os24vPbSJwkS4YNyjW4uIMWMkpZKwB6fc+9WKWg1VKUuVW0nN8iCcnAAVlEq6JbMG3d5qcZKF3tky0UmTQp8kQooPSrbSwqyKgrq5jwWkoJ6O/DRnDDxGqfkkkDPNCiWY9TQRtDWYmdgdai5Q1iNje4Pphu96pgGtpazREH1msblo492CerR1NOMHP2XxkOS3ljq5EENdHApWqDktbmOxVIGg8o/PobFE6XscyeILoKsHs82qNpZIKSVGMm8iENInAPgu+n/Rkj0fTlR66WAcH1WN8H5lH9DBXiA+DAg0y1hbNY19pcIhxsHStqYx0SjN+r8EUit2qUzpCj5o94vJEwuCHgyerICBgLdXuAVkiLm2QgNisoP4tHEDk+ERxSSxJaTSXrNvSwoeI2frvznCgag7c+UF5xKLaRjnJJ7i78p46O8B2etUOxybhH4a8j40U+H4ZWexbBgqfkluO8SU6HniCq9ykwTJCy3h6jsE9T/Lw5fgEU/GssB9HubfmqROy/Uwrv49y4F5LTxxU5ThniKt3vdSYTb5lRH6tckQepMWEbQOsCQSESj2GtewaVsy8AtWHuVNZHpzcgi3VGDR1v0pbQdE5d7wGFNhpYgbvZt0DmXokeO1n9mDOMe/WXfL0FwPBV8KFmdDJi/sIEqM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?W1QXEDXNLWE9yfCvPgP1CGgLS3XsjyGPjMetTASH7jGcTv9CXEN1yIHbSjrR?=
 =?us-ascii?Q?QzVwOYaLzIKJ3KaRNoiaiNi6I/axSOfQ+v4x2MJ4yrXddaGm2I/+fLWUsF6B?=
 =?us-ascii?Q?lTFOccBA637QUGIDWAGf1Ce4o1LuApcc4fYo/b4i72B+mhaXzMq5c2YpDbwF?=
 =?us-ascii?Q?x0gR4NZpSFZuXPmytFXRsNciA1MnqoFLFpjj6WXtLTFlTmdZ6EY/JY1FUuhw?=
 =?us-ascii?Q?9cQa7FuXceWHw4wQuuwRudGE5+cutRzBGNwmpOzTnMaJWyRKQgC9zg1ckadh?=
 =?us-ascii?Q?dykej0veYRvQdjwUOqxAZETjZlSNGJ8uxLV7Wh5z7CjIdj3ghKv1eBfFQEvZ?=
 =?us-ascii?Q?XcydyG+JP5rbbQD4PsHZxsw2S9I5rbvDQDnc0oOQe62O1PRKC4cKcve5YtPC?=
 =?us-ascii?Q?bNvp/mHsLa9RmKuP+XPi3i9jVDxAy1qysEISn4B4HHskAPh5n6IEnla09kSp?=
 =?us-ascii?Q?GFKJGlgwuQMgHfJaWMgKRgil1ie2OQ9f/M8oELWkZ0kmgqyTxMqLCwlpLfwm?=
 =?us-ascii?Q?nLdrsTCPwCRVbIKtBgvsVwg/WB9irM5OIiNlzBx93zJpcGYcX3AH3vfsMxDu?=
 =?us-ascii?Q?bB38ElNPMpvZreiocoOtrtZDAKmuUTMrCxRc2yYNUkQHZlODoSNozj2FCQfQ?=
 =?us-ascii?Q?b0HmuGIfalB6ynLmeF7MG2Y3Qr3UmXQOnVxE1S+hdp19+J7bR/TrwS2Jt97j?=
 =?us-ascii?Q?DGxpBL7ZvcU2uipEtCs8FZnCJfIgeVdWfz8q84BmAlUQUOt0BmKqr9C9GEpH?=
 =?us-ascii?Q?LNUwk/kyCyoukjtZUPYQcA4Z7Zl3jTsu1qdKwHPBb8y6M/5pZj/qlEDBjIq+?=
 =?us-ascii?Q?5x5YUKxODE4o9Hdc2PmuHzLozt6xrczhbI6pz12hCqCSUIA2kmX+mE88DtYZ?=
 =?us-ascii?Q?oKe4mI0utcz5Qt4jU8qZCCi2/IlUirFLNvq+/7NTE4s6huAwQv1sz+nA79P3?=
 =?us-ascii?Q?ZlAyeXNBCHtwU3CpMyhIuJqMSxU/QMfAqufus7Yxee/EjPmJgRKlezlPruoV?=
 =?us-ascii?Q?YNXWf+knZyAPOrsUI+Na643QrHOrXDLDwAsTLBFRwdemFMkG6b/CJ+UqO6A5?=
 =?us-ascii?Q?+M1l9UPqzJuMzoTCw1qceoJWGuhpTJO1sRN9aEBrYiwla0XP4vo8YZKL/tJc?=
 =?us-ascii?Q?QtrwLMj8Mk96l5iL6BtZ1ibmNy/PTzDz8QYQQ1l4eN0mcom8/9O+K6Hb+gt6?=
 =?us-ascii?Q?TaiYyUY9kfp8+dNVc2pFaHEsK6XRGFf3XIYB0eCh+6VegP9s4KxCgitsQKBT?=
 =?us-ascii?Q?xMylK2rBbZq3P8MmKLnewvijDr+ptGr60GTXAMBdfoJOyzy58bg8M0S0epT8?=
 =?us-ascii?Q?Flg8eYvzQVcvrRZg90xdj0n/32rFnvi0iK3xjI7P02DpiNK8CTeruJGvJFqQ?=
 =?us-ascii?Q?Ge4zWwvRShEiEMKulnvcpBcD7vOe5Bxruqvznlc96BrhLN6ddwiIskE26YCW?=
 =?us-ascii?Q?dXoQ59BTiqS5JddYMnnqFJ/nnhzRUzJDiL+kiWwhRe5JJ260QMY2Wf40AlZs?=
 =?us-ascii?Q?osA3mxJC20tONUFEKh3huOtVJSfx7DwaGUoixc+LWbHTv7iqr3ucp3AivRjR?=
 =?us-ascii?Q?l7+h4dJljV1tsXQ+GBYNsb11qoDOsXNqzINc3kafX6A8CR2XpGPsJ7nodHzZ?=
 =?us-ascii?Q?qAqgwDs3IX6IUyr+6f1q/90kbAYkUUc1TZJhg5QuEw4SelT1uZaJTdBT7wB9?=
 =?us-ascii?Q?qGGIEtGmhdRy6LzvbM73xLxkP2MpthTgB+uDThS/7NlqFc/4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52b5d5dc-d8e7-4df7-7ced-08dee2abbfb7
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 20:00:41.8730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w5dCsWDACz/DLbg3PGe/aKzg8XwqaaYUXB5/7eusU0d++SKKc6I8T76XYuV7ZXV3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW9PR12MB999208

On Wed, Jul 15, 2026 at 07:41:50PM +0000, Pranjal Shrivastava wrote:
> > @@ -2446,9 +2446,10 @@ static void arm_smmu_cmdq_batch_add_range(struct arm_smmu_device *smmu,
> >  			/* Determine how many chunks of 2^scale size we have */
> >  			num = (num_pages >> scale) & CMDQ_TLBI_RANGE_NUM_MAX;
> >  
> > +			/* Keep the pre-DS 5-bit truncation when scale > 31 */
> >  			cmd->data[0] = orig_data0 |
> >  				FIELD_PREP(CMDQ_TLBI_0_NUM, num - 1) |
> > -				FIELD_PREP(CMDQ_TLBI_0_SCALE, scale);
> > +				FIELD_PREP(CMDQ_TLBI_0_SCALE, scale & 0x1f);
> 
> Nit: Not sure what the convention is for these things, but this cap for
> host is temporary as Jason's iommupt series expands the scale when DS=1.
> I'm not sure if we should note a TODO here or just leave it be for now?

That kind of looks like an existing bug.. Technically it looks like a
very large invalidation could be created that can overflow scale and
break this algorithm. Adding the 0x1f at least keeps this as 'no
change': broken under invalidation, but not broken malformed command..

Let's just leave it like above, my series fixes that little miss too:

	scale = fls64((num_tg - 1) / 32);
	if (scale > scale_max) {
		/*
		 * Range too large for a single command, use full invalidation.
		 */
		tlbi->range.use_full_inv = true;
		return;
	}

Jason


