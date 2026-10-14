Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013010.outbound.protection.outlook.com [40.93.196.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C0C376A13
	for <iommu@lists.linux.dev>; Wed, 14 Oct 2026 23:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792022369; cv=fail; b=cQJXe5IrlsWzVNscT2TmA6Qkb+ZljxKGZL5EMwTlgfcKkkmewDHyYgPCW2m7MGDWK9UObBp9WnAqpN5tbtFvbfum6CTvWOfCt9EUlD2x9QX/YSNCgZIT9SJil9sEy9X0EuT56sJZDvj0doi2oaO4OIE4N8ILdLl4PihIc7zeBw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792022369; c=relaxed/simple;
	bh=N9NNRFbXfpdUrhoPoK0E7vaa/CyVfM1ydg9TPdQC968=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ASdRBhEuhdcBVFFhGZb/pOZIlURywtBq3gVIewHfvDweBu3RUD6SwIazwp7gdy90Ki3jn/O7McdKjjqrlhwfkrdlGAT187Hsx43DcQMw1M4HxIz6yo2ELYyEPk15/oaVkGxREO7OkRZeGM2vWl6byOBz+yLNQ6V71yyX21hXYwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=W8dbq886; arc=fail smtp.client-ip=40.93.196.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="W8dbq886"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WQQwULCCsOUn0gKCryO4ErdkOfbVKLUOrCCbjf3kmvY9F7G2VUSrl/G/LxK5mFrw8t6xg/Bn2Vx4YogfPXdU9DGr2IFqm8E9eshTFiu9lRnNPfVaztB/LEvmdnvbRfIyrBM4KJI4LKU3/k06oB/ALKZJF+imwQYgKIWv+BGUlwHv2sOeyG8VtgG/TVa1Fj4wdb4xLYmFZCPN0sqmzkDcDOSr1WigAUS8rstSji2pg48UNVyKmAXptFpm5rb4/DBE1qQRStJ52UXXSTtlNeUif+qe9JiYwWlguxo9h+MQjeT+3HRLONJxSJx/Ad+fNUTiZinpKelXwYH29O6MQv86sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xhl4fTJdTJAOWHO4e/fOxLuBj4iaiXmuEEBX/ew5oEo=;
 b=jnJTKOTl5OrdC4UEcbgX4vKvprcDsATCxN13aagKNhLnOQ4GP7NUERwGNj7FEtwhlkGX1XpjkZCPWucdl9LStLaO3Gcr2FYETrziQi32oNQ260QYqfiEruJ7nCcLOaXcgbfUhounTh0gZlWqsoaoX3A9btfrkj6eFQ4rRxcq1mRk9nQ4SkTXBoKz5/O8ZJ8dm+44MsvrIu+YJ3Tx0th0odctwBa+1s+92AjCbS73GpcUvVwWwUSlSUTCHWos0dB72llqENKk1X7gUeO24Oyh/UyqG1nAL+LskTU4nYF5Mo/NCKR6N+Y1YHqblPLldT9TqdMQ3aAZmnYMxx/+x2MfHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xhl4fTJdTJAOWHO4e/fOxLuBj4iaiXmuEEBX/ew5oEo=;
 b=W8dbq886Xz/bclWGqKx0NqnyKFBHG5CkHAsLz0hAkn9/5789p4x1rejZd7nGM9acquhid2OQsInzdXhPaX6Urn+lTePA+fmmZpnAEDBf4RdgLN6NbvGgay+E54G7AjOODczt6prV32lasuHI21iPP/iIfDRziUJyu9p2X5u8BCvv9MMhBOZBP2y1eVHkD5LqdgXxSUOB+V8wUXjaVUd9zzv37DNzfg8KYg/bi2VMvm5SeS9Qn8jGRIZwbhifYpGg9Cs/8HqCW89bw5c8dkr/OwcOTBZOlZ1c1QGsvcPrkbHPfykX4O0Q1EWnQXPhoqrKT6JDJorkQW1wQ9fhJMxM1g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by MN6PR12MB8565.namprd12.prod.outlook.com
 (2603:10b6:208:47d::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 23:59:24 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 23:59:24 +0000
Date: Wed, 14 Oct 2026 20:59:23 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Shuah Khan <shuah@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iommufd/selftest: Check dmabuf MMIO mappings
 filled from another domain
Message-ID: <20261014235923.GZ13920@nvidia.com>
References: <179200036595.15213.9864724554843977359.b4-review@b4>
 <20261014211608.291608-1-parri.andrea@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014211608.291608-1-parri.andrea@gmail.com>
X-ClientProxiedBy: YT4PR01CA0079.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ff::11) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|MN6PR12MB8565:EE_
X-MS-Office365-Filtering-Correlation-Id: cf00c11b-0659-40b3-ead6-08df2a4f2c51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|10067099003|18002099003|22082099003|11063799006|261009223027099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	qjzNeq4Wvpcywh3PgvbgvCwDPwue5gBB5JkYnsPtP1zFeLc3BL4VnbuMCFx+d02CmrHX8ONN5DMrpsL2bQjWFA7i1Xq+GJzmJF9xK5Ue8N4tJS/h6TI9CqSGWC6RWtqQtXM1klvqljCF0h/StebUWtFj4q8NOpfdyjY0OxdDIvAk5rlZEdMlIkrG4es6GmvzI21/l7LNUapR3cX62nKrcqzi5JM+kAV76DtqA1CocTNb3PeN+0vdIc8RpYtzlGyIIeTiT97ZBLK0FU4dkapqZEwF/RbDqY6qjBwn7UEOMzLwFoQ8G8zU8XXWudm1EvoG6R2e2WXqbdBdNniWjxDZYkpeaCwpCi6mp9pqalCq9Q4o1hbi9xI+o0x68jkiFatA/nRdQWe0H3IwPwtiPKM2PzMb3tQP3HT95YwdiuIQkbkNxQ5UgcS0Qu9dARMiUq0gyEz/2Ip1shXc8tdMnOwHbMjNpARZCPLpO3OKnmeLxEMn80siyJ3uXkc80Ohs2oL8bNS2b2x9p9R+cwoIFBVvjWNBz5CAAAEI7HUfE4mCXC6mXvMyIkjzWRl+6vO6brCOn7ywv7dHf81gOrIpyhNIHHnw7W0DDR/6TB58Fp+HaQdOcR5XZ2zaTL+09Fw51Ibu2A+BOs7xU6OQsqIPzHHnkG81deLFzBnIYt85dp2bHMs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(10067099003)(18002099003)(22082099003)(11063799006)(261009223027099003)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XroTOOc/NnU6yOW4W/BMNpRjhvT8dJIlOnjXEc557/mLTnexhXSp0TI5wcNn?=
 =?us-ascii?Q?AvhkpL6GFbSK9CKp4nohF108SGJCI5qhXavH2BduFUJndZFfhTSfgL8FCOtC?=
 =?us-ascii?Q?Vo44Fggvxh4N7gqzRe4h896yekCGhMS+NECQeWNrlO9UZOUoNFYnvzebwfwt?=
 =?us-ascii?Q?uRkwciOVEW4oh/Hg/A/cQihA/89Y+SXq4J8fN1f8C4lIoY4a2iUSbw/xEJx7?=
 =?us-ascii?Q?S+zerJyyKTsGlJ9RSkZiMzYpYeJko3Pi+Fspznz8kKmdNjVcFOrygpO3QPQB?=
 =?us-ascii?Q?r/6Je++Ebe//0I0yIwqfEzjY+SDQogisESzL+jtoaZth+BPgrJkBgiIxbwOJ?=
 =?us-ascii?Q?cAmyeWROx0lwd0TdTm9jhxYagUuaJ1YxkRNDafSbiW0Y6TET5m/w2qVANAiG?=
 =?us-ascii?Q?ITQg2Lc0yd1LaR2p++/lJJTdNkYKJfqccrw7swjkkoeywAMmPAXxfTb2iDon?=
 =?us-ascii?Q?3LGFf/mDYDr+QSVVCLldoTwmDahSQdXxhrwJqDNf4UOtAN6dNz9Mrl8sXoEC?=
 =?us-ascii?Q?bCuuodJMIs2EbO0/JFklnYFaW5Cbix2BdjZ7YbbfpuOtvB1xlCG6mnFWRYf7?=
 =?us-ascii?Q?z/Rf63eoQvAd38s9r8n2+r7qpIalyQ1BqIAX5c8PtDHbx7rS8yJfNwiE/nRJ?=
 =?us-ascii?Q?LvSCRuC2LHu503kf0oOF4SO5fkCNUcc2MW/K6ZK4h0JM6IxTKWTYhlBASqBb?=
 =?us-ascii?Q?HKFjj2q9oyngrmEQ0QAY5Zr2/RdHblSrKH8FohulX2tIMAkpKCmydwrUxslo?=
 =?us-ascii?Q?SO0OmbF+XPRI14TsgI6GsZctTvE8sbmtmkFIvaEKj5yOIOlm5MtAnH8zD9ke?=
 =?us-ascii?Q?TuMxWr+F7Y7pHjx2lfqUSg3SlXfq2JA31SfDDB2B1mYxpD7Xepvpr/E4ss5T?=
 =?us-ascii?Q?0jNrAoJMdsg/XKYpMP6hmtqqc0AoYki+tuworXdWfgCb0lkuV0u0Z8YFZDdd?=
 =?us-ascii?Q?eTX3sJCEJzndGw7SmRND5fIZyAHVIzwitBkiz7YhmA52907TxdpM2MLmtpx8?=
 =?us-ascii?Q?LOadWDzF2qkLh751cgeBMN/cTDGgQ8FGK+gqXNNH4WUUnyMcq7ezfGpak9W0?=
 =?us-ascii?Q?umY0kmsLV0PtIynjz/i3/IIwLtdjDCH4kyG9k/Nib1GJ5y3Eog4Z7AsMZkIP?=
 =?us-ascii?Q?9CJL2lYMVM8oZhXCQDjN1al5sv5sDPaAvSHuLympUMs4PteRW7nch74XEvAj?=
 =?us-ascii?Q?RG/OiAq/9zquT8vWEHRXiDX91beJ+bnwEVPBpigAfLs+zbZUNdcGcL9xvPN3?=
 =?us-ascii?Q?qPWWW32EO2+k6HXUY6qxiXAttdj32h+ZBLq27cPzzzOcktxaN//JEZNY/fJ0?=
 =?us-ascii?Q?S30RMGiCXWSDE4XrvPvdfyAQIXW0JuuUi4Bzs5CeDghvx4q4wxBi59yEVd8D?=
 =?us-ascii?Q?lBf8SKWuWWmPG+g403oawuhsoMzLctLuLBW2brimtLhC57B2pa6eFuBImFlR?=
 =?us-ascii?Q?t+Oz9uXjjkiS/GjYsNCI7XGIE8OH9s+r0AcphCvfAkD3nw654cTcy7OjiGxK?=
 =?us-ascii?Q?B6DWdLkn9EcZnAav0ofDaG83X5uneZxXo+DJIFotDuJ0XSpTxxL7IBtk3g1D?=
 =?us-ascii?Q?InfCluDwW/+xL+fF7Rdu1T+45rwQgsdf6Bm039XxljdC93NLX7GfEcqGJ7g3?=
 =?us-ascii?Q?Du+jufXkw29i1BZBIX5WYYoJb/F8dMi6lDzj0pPH63Le7ls9lyKsByZdCwgo?=
 =?us-ascii?Q?cl3E7LaKBQc8eGpLD0q/zz8Bmf1p8hwMLih8IX61ZilMpKzL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf00c11b-0659-40b3-ead6-08df2a4f2c51
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 23:59:24.5219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZLmaUPAuP532AHRgTVbO9ShPV0f1Wf9EEQJejldVOrYhp1wD3W6hYwovgls8npk/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8565

On Wed, Oct 14, 2026 at 11:16:07PM +0200, Andrea Parri wrote:
> On Wed, Oct 14, 2026 at 02:52:45PM -0300, Jason Gunthorpe wrote:
> > > The mock page table has no memory type bits, so a mapping made with
> > > IOMMU_MMIO cannot be told apart from one made with IOMMU_CACHE. Wrap the
> > > mock's generic_pt map_range and unmap_range ops to record, per domain,
> > > the pages mapped with IOMMU_MMIO, and add IOMMU_TEST_OP_MD_CHECK_MMIO to
> > > check that a range is recorded. The check rejects ranges that wrap or
> > > do not fit in unsigned long.
> >
> > I'm not keen on this, the special mock amd domain is just for mock
> > usage, we should probably just add a mmio bit if we want to do this
> > test.
> 
> Makes sense, thanks.  For v3 I have:
> 
> - AMDV1PT_FMT_MOCK_MMIO (bit 52) in amdv1.h under AMDV1_IOMMUFD_SELFTEST,
>   set by amdv1pt_iommu_set_prot() for IOMMU_MMIO and kept by
>   amdv1pt_attr_from_entry();
> 
> - pt_iommu_amdv1_mock_iova_is_mmio() in fmt/iommu_mock.c, a walk like
>   iova_to_phys() that returns the bit, exported in GENERIC_PT_IOMMU for
>   IOMMU_TEST_OP_MD_CHECK_MMIO to use.
> 
> The op wrappers and the xarray in mock_iommu_domain are gone.  Is the
> extra export from iommu_mock.c OK with you, or would you rather the
> selftest read the PTE some other way?
> 
> Patch 1 is unchanged; if it looks right to you, it could go in ahead of
> the test.

Yeah I will pick up patch 1, I am just stuck on all these dirty
tracking patches right now

Jason
