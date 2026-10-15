Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011024.outbound.protection.outlook.com [40.107.208.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BFA5616C7
	for <iommu@lists.linux.dev>; Thu, 15 Oct 2026 17:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792084979; cv=fail; b=tBtS7YWnn/Ez049sxgt7Kp9Ak25JToKN2TpAH3TFQVVe4wgV5g1FF3DcqWrsawdO65uewgW8XFwF0wRMse5MwGn2YJs18WsKety31XN2vgnpqUeY9Ki2ki0s4wjwpffwJjuj+xTG8V6+Dk/jIiKDD+VIelWyjFV1sIftrLvzCq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792084979; c=relaxed/simple;
	bh=lcLHzbS7NnIi3o4pu22feIqWu1E1/yhpU2X0hIG0sYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qzxUq3AhJ3Nkv6KULIiVB3trXgC94VijokhwzGSS1+kAXIlHDLKoDgySGXl4ElEdQYD+HWkfNFOQDtBfqEN54bo5Ux5az2IgVuhJo6pmWoMU8FaYbbP93MRlntVYHqzWCimg2DfAa+7H95Phl8V4ayg3r4uz7xCCYlhIAKkTAHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RS412tXw; arc=fail smtp.client-ip=40.107.208.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RS412tXw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E4hJEVJLji2qi7VhEMfGVydo1Sqs+pjU+s8jPc5XP5p8Xy2ggcFN4bqnch5Y16ZPIkj05an3ukM9JmOXHR93DizmGspP1uJ20/19gEHw7BWvhj7k1bhRpXv3qP65dDuOnY66gud5mT6N56n/DsgmRWo7Uz6360ynA4CeasLH6MK9+y2/IyHXbGlNWEEqHm8dcQCNgaJCMhmqLO+z0ZPDzktu/nnUyh13thwHy9k8qh45iDWcfb0WhW7ChHG24AazJsqryWQAIbe0qd3XiQWUNdCOgJVQJwfgHgsYHKQzoDY/BNM4gWkwxPdKCdYyoMMRvz2keH6kSyvWMiT5/AKYNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aluj4JBtP0ihLiA37Mo2LdMyI5nASFPNHBFNCfXqPes=;
 b=hvL4xZz4kB15maP36dSNC1W2HX2xYDmOi0nj3bmPoDHdtSgd+Co03oyKauBgPZfcgAe+X5ps/qBsg6Fr1yIliq+9Xwk7KKudJdRngh5hxfj9yCRREIKp2/EnJdU95t/cuUkmw1Nqi6lo4jbMUZw91109bOfgcDStNhHKu3klEN1QIPArPxSwaImeaVNgB51IfmSLypg6pohrVoiXlN8Hj+iRwe7lRHx7NkPsoXcMBTssu93F30W41rYToNYgKaHsscxaIMROB+u+bY+f8w5UFB6BNtyKVDuC7kMhuNNQChjeejMQU3HBWGOADzWKXK1Q+VUXSbjGMQP0IFy+xzEb8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aluj4JBtP0ihLiA37Mo2LdMyI5nASFPNHBFNCfXqPes=;
 b=RS412tXw7bIVBDsmadh3x3qa10y/eqYyIM8h32l3+xu+S/sgske/ehMGEictu9aN7J/FtEVcTDspjhacLlgJ6mmDoT/IGvif5GC7HdASaYCJeT53c8KeGrh18qUkqJipzID7o3viwLn2lWCFwCktTR2y2g4gUcfEwhNoNUJGClb2NZGDrWYV2Ww12ZN08gFc5M1zMwoFAxrZCIXWosJsNYb7r8pFKXnDvEC9rqw5ok7pz/CTs6m6t0wu2KmrXqq0Udv+AyfDwlUtJ8WmARttfqSrzHa5ttEusQWEriBPljFNrN2v7EaKCSeZ7WbjwwIoiA0iLbYo7RPWRY3TuilPtQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by DS0PR12MB379256.namprd12.prod.outlook.com
 (2603:10b6:8:3df::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Thu, 15 Oct
 2026 17:22:45 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0522.013; Thu, 15 Oct 2026
 17:22:45 +0000
Date: Thu, 15 Oct 2026 14:22:43 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Shuah Khan <shuah@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iommufd/selftest: Check dmabuf MMIO mappings
 filled from another domain
Message-ID: <20261015172243.GE13920@nvidia.com>
References: <179200036595.15213.9864724554843977359.b4-review@b4>
 <20261014211608.291608-1-parri.andrea@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014211608.291608-1-parri.andrea@gmail.com>
X-ClientProxiedBy: PH8PR02CA0037.namprd02.prod.outlook.com
 (2603:10b6:510:2da::35) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|DS0PR12MB379256:EE_
X-MS-Office365-Filtering-Correlation-Id: e25405c1-2038-40ef-0e38-08df2ae0ed91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|22082099003|18002099003|10067099003|4143699003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	ZkEhIPQ/Cz6+xLLU5scL4k9XvnkE3PH6ys+W1NGJ6+qxbnxvD8TG70P7LHrT9naD1Vibyl1AX+isoUWO3CKtPkP0R+lpMrMGe6gSmSPs2JpqAJSlXcp8mADSdhH62uyTtINFC3isEkR7CrfdeVs/WM78vaomL93SJ1a4FVZe3RxSFJVNZDoAPI+evZXd6kJolggFiOZKOlPq/IzNtMmqGbRW91D295mAgAsSVCAwlOlaumcb67T5H8KxjEPG8rMKpCluVI/jinRsviZiRcTtEfD3lyF7amRsw2CdDtPdH94odk9/y7wO9aLTXUnkAsePzyrQwmbHsdkJAQqn48Q2FI3HACAk4VIzMp39ysVn0UDKRz1RXZm99gM9pl4FhUYVuYoLBiK1T8vBybhoCW9nIeym76i/VgW4V39XuezCjfiLa3devlHnKKni+C6L0hAqIjf4237SqC3f00VUekhlNGk9hGXXWbuVhJiGkUdhoJau6wabE04bAUmMzbktTJrnUMs2BDDRpGd8ZhSQLeHTxUqCwf1NrZDe51xm5HfV3HkyxSfUELXb+nKw/ChLwbwAmXfW2//CesMYTUTNDg3Cj/wa1+WbySPx8EbnJqBzc1ZL0s0xHM5Xnwu9EwsotNgED+HYfyhX1lkezJ/OXHd3DuKscAAEnOhxo2hCrpPGaSg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(22082099003)(18002099003)(10067099003)(4143699003)(261009223027099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QBhHLvcBZzaYqVumNQKVxQSEvjw3d7w8w3ApAxk1QE8gDHzLp+bqutyNpRKr?=
 =?us-ascii?Q?9adhpvjN43M3PpCHkq7flYTz267mbDLBu4+xx90vFAqGlP2YCe6/Fm9t/kmS?=
 =?us-ascii?Q?GI/pGyh2HabZKmcf7LbvOMXagh197FVDVmzsHQkNaS9T5uALGR6c/XUafIoW?=
 =?us-ascii?Q?mu9KJkIQRcteDJw0X9CiG3An78KhPXwER/iHiJDuXsTWwLR9w/UEhT8MKAuS?=
 =?us-ascii?Q?q4kPGF20ICgtpdxxiXukn4bcVyrH40/VtzCtuLWEzYhaC6f3rAHDJzmBZBuT?=
 =?us-ascii?Q?X7O4JQgF2a6+UYAcsU304VTsnsyXzLv+boA2HJAa1A/7vS8qwTc+a90Y5WP1?=
 =?us-ascii?Q?CHXPHJ5EhL4zzzl4oswjTYZ+hguMXeXvGPr1EGv2KqyIYViy9BQTOqOUCn+m?=
 =?us-ascii?Q?808Kb111sc46oyMtUZmwE9i/HlOi9iRLBjDJ6unirS9CMQarant1nelaITJB?=
 =?us-ascii?Q?IFgFSbEzdh4YUWxX6K9vaVOFBF6dIqAY5TMFulE/OoS5fkt2C/m8Byrjn1FJ?=
 =?us-ascii?Q?pAv8jWNDpuu7svPWcLbEXmJ50vgct+Na5BEXtZYl723mR3OKaadck6v3P3g+?=
 =?us-ascii?Q?S35ljaEVBTgMc0VZ1zUf/gWyqpk++1xWxxoRkqbSAWRWgW5rfiINhThmb5s1?=
 =?us-ascii?Q?+9fZrBSe4AfBSYZibLuK7K2MSvo+8aaLazPpPN1mLj1Texp9r/cfdNqPYrsx?=
 =?us-ascii?Q?vvSbWuBxUFxzDs4PR6W1EKalUZr17NZwj9nMG0ct7LW75MEoc2uZbQTtU13E?=
 =?us-ascii?Q?iPm2XMIUk4uyfJOOGe49RcFCesP/7sXi8q1X5T6H0IvbZAQbl6LIXpbNEyOl?=
 =?us-ascii?Q?sEI4d9BNasFTvKKR0XXtm4r+6Akkb1ZNKMkK8X8qSKc85iDyC+ha5cIgcp1H?=
 =?us-ascii?Q?r9uiYtnIvK7d09DZ2J+J9vNt0HDdVDE7Ms6nu0opOOcV2TFUfEvPrjqUP/gG?=
 =?us-ascii?Q?iPsC9d2vifx+ltj348YhspEYjc3QGsWPxbgqzRH/640Vt+ajA5SrQVlBgzzZ?=
 =?us-ascii?Q?4BL7yDJL4VqE5rLW3/oW11+ugh0kums/EGEN3NkoOBxfVjyC3m3Luyt2pVnR?=
 =?us-ascii?Q?QI9kpWhEPGnXd3re+MdDVij7xb/hkzHTOJAn1rv1m9DsgdA1AWVPy3i4p9cx?=
 =?us-ascii?Q?gNzUHcWninZkjyGIdQpTPKwow79s5CGbucwHX76ktrbhnh9ohyPNwZ1yGGIe?=
 =?us-ascii?Q?BbYpNDG+IehiVtgU9ME3S9shA6ECdzuV6RGkFLyfx2C3HHHykEag02MQhazK?=
 =?us-ascii?Q?oYwhsCewOgiCsjw+J74S+hPbji+Sc+d4tSC6Tx6MruHvLUAAIhadK9XF991N?=
 =?us-ascii?Q?R2vgpMkB8mCrCSSdrPYk9kt6g3KQmX4HaPkUwU2avgdKpTWGVq6PWGtAlZ++?=
 =?us-ascii?Q?h5dlsU/l/lS60PVKQtdRQ4LREUygs1m+yDKRKnGNaVXeUpV3d/Lqt1CnB6wx?=
 =?us-ascii?Q?9URLE81A8CbOBAMb4kowlrRa1ujJIQDeRvjkgPaVbKyaLizT1jfw0gBoDnED?=
 =?us-ascii?Q?EhMlYIw2YNq74+Ybrt6sPK+ElHpMZJlV7mN5rSoNwQubDf3FW7TbScwl7P0l?=
 =?us-ascii?Q?9DUWJPkxuRa4H73PjS8l2/SGGWiIhSL7EERWOVGgKB256/A+A2G/Q7Ouxr5a?=
 =?us-ascii?Q?8nKf/5tvFctdzLr4MS/0K7fHcUO9yXCy1NbSyBCQdmZ9eAFZ2Mw4GxhKsIBx?=
 =?us-ascii?Q?d55WQMqWkBuC9RaH+gN2uXSqQob1M4qpkhnh4wYjd5hko264?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e25405c1-2038-40ef-0e38-08df2ae0ed91
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 17:22:45.7534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zQTg2GTfc0NKjWW5KndkInyJJVQ5mEeqCR3Jladxo3dMdrnU0kAmsZHsw4Lj5E3g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB379256

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

Too much AI.

This sounds better, but I don't know if we need all this code just for
a selftest.

Jason
