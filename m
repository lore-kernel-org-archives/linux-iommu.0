Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011002.outbound.protection.outlook.com [40.93.194.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA7448EBCE
	for <iommu@lists.linux.dev>; Tue, 25 Aug 2026 20:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787688905; cv=fail; b=uuAs3e60GdJypbMpQc2RaH2onFZ4nKUATBWU50LgOO08s3at9sNbKidEAVinaj1YVo7YVe8hiVqG+U2tVFlNCeeL27GdQTh6FkOzzDSLzT7y8U9br8KXp14BYwSE2KXHWgwTjGthZ9SQhUgCyfggufqoEfTZR8g5ko3ni9vQqyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787688905; c=relaxed/simple;
	bh=JAFdJbfhpd9YtqFUcDPjhL0eYAQRW5N++97prKwaVSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DVD7bBZwJmCziW3N2KFk3okqFsGvAAv1Vygku/udFKghslE2xK21guSwKv55uuBhxc8KM3jgKdu8+hQ859g94cZ79tvUdVq5GcbfoWwE+ovrYyEDY9NuuiT2yJ9EX1BZGBpyQziiBMMNYAFlafB9QOa4UdHm5jXZ/+e/vUqf6mI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MF5kMgyK; arc=fail smtp.client-ip=40.93.194.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MF5kMgyK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xf5D/J790MWrLAYNqEyZsARrjNNNlpR5W8/okPIUJoX0c5UgTAloA23DNIAjZRgLfiZeO7zgEgJsePdsCHd8b4rDfRVrW3ieE1srFEgHYPDOz/vEAtKJykq1ylXO8d5HtKDUmDWmRu1nknFvhpNItKbAs5Ogbp4p2TMeUDobcNTgpqDLKkXHO/gJcH4uiJjnT7J3WDY4Ba13wIaZlaX45bMDTioGvoFSP2LEeTv2Ti91aydTPYvO2gVUkbCFtyS8OZPMkYGfOXkxTs9rk3Hnbn3DDXm7pMywhSh0fdyaa4RrJ9wj33ZY8u88h/uHIuMgqsXCs9anM5bK1ZbiSh3eAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E1o4//8pgaISjmtyk2oMaKuZzOHzpumgPVoxUuFrFUE=;
 b=v7pXQ13oafD46MbrqxU2c6R0cajzcpDRaoil3MqlodtJ7iNVj79mFRFsrYlLMn8quDVESqy4kdSTzIY6hQf29r8veZlx6NEvLzcLdyoekQiUe5ZARiBO95/VF6pO+WCVXSs4NM6S93Y5c7xkfghkmNEQWy/8mZUxI0JCHKaQvs8dxZh2o+5d6mCKTylWe1a9NpzVO98AJpJBehzMKY9YaLO8ITTMaza+uR8+OsVGL+wtPNULLTTAJ9WuZ6+E0B0NJBrq3FWcr5owX9E49ghufgfOeScmu3BWTaShW+HKCHKbk1S13ffTj3xITUWdr3WCXVwN73reNT0aDKBiTdjORw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E1o4//8pgaISjmtyk2oMaKuZzOHzpumgPVoxUuFrFUE=;
 b=MF5kMgyKDdEnBjsGB3I6bPBEqUFbW8Mt0azybyUtAgQJvB/QiDR+dNnpHSSgik8ugTVJ/e51C6AzEG+Nyl510sSSjwW6xu/mFi8/Psoa5eoQ+ef6ds+dlvAt+n8uleNbIezBSp64bX3I2kziFHqDOltiHVkjFgyClP10hrjEGekSsbX64eSt2XUYyn/8/tJfY1Gm2Q66PY2UWQj2SomTOfkZpP3GlCKNjfMbzPT77EoQc5tRWp+dn7G6JCIpeimwt0ZV5c1wGJbBz4Ixt/B7VYdRr5sKpgdEKlLw2PmUJs926QQfxizQJAHzSC2cJ08nMXSHI29hI3U7vWHONJQKsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS7PR12MB8290.namprd12.prod.outlook.com (2603:10b6:8:d8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Tue, 25 Aug
 2026 20:14:56 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 20:14:55 +0000
Date: Tue, 25 Aug 2026 17:14:54 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Daniel Mentz <danielmentz@google.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v9 00/12] iommu/arm-smmu-v3: Implement Runtime/System
 Sleep ops
Message-ID: <20260825201454.GF3325090@nvidia.com>
References: <20260728210928.1050849-1-praan@google.com>
 <20260825133342.GA3332773@nvidia.com>
 <ao3j5FFfKQsctV4r@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ao3j5FFfKQsctV4r@google.com>
X-ClientProxiedBy: BN9PR03CA0785.namprd03.prod.outlook.com
 (2603:10b6:408:13f::10) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS7PR12MB8290:EE_
X-MS-Office365-Filtering-Correlation-Id: de8a441f-bcf2-42a6-4db4-08df02e587aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|3023799007|6133799003|10067099003|56012099006|11063799006|4143699003|5023799004|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	j5MLQmZw739WpsKPlRB5klohx8ARAAoB916I3Xb7aW+Jb7X4y654e8FGqSU6p/9EKWJYcz/r7NIVJJ525JKd0XFhviYeoSkreGBwNghFhgtEVe3g7efcGanQZ9Hy1r4lXXIeXLUIMWj1ZetZb99PzDNME7c08jh2iZoPJw9jdcj+3a0yDB3IOEEN7E6OjkY2Tf001a2bDzTSQ6gWiPzMojq1hxk6Y+pFR5PYRase+HkxCpnSsRjvTOwgJ4tZCUEgOZLRHCfKb6Yij7JE7P1jeHgzcbrifXVxAYUsoBCuMitfqgdws/cWJtlR6Dc5YSlNktQuFMjIQnaahAHp+IWZI9GmYU7hcxyQZj+7TAgNjFL7AKCfCNBrKO9Ebs2FsFNhnCvXwSUKJZT22srEEewQtLLkxlQDe6QufL/hsCJIP0m9qvaX5UXrjLQhxuaZuwHGl5AzDLb1fSZOAS9wSJmYWqCMtZayUfhyQORdJ46Sgn4zx4cYKC/EqvheSuTzzKzQR5YuFJixpIxj1fM255kTKITa+tb7JUxemYr72WgkFul0Kvb2JLJ8iJ5GvlnJeBA76tDvP1Aav0clzgo+SsbazVi4oR+vcT/9SXpachibUZZSJr/bxYeL24xxVu3q5xFHNJ2T3WexJ26lVLi6RWxcK6k85+MU6zt3jnfsCjigKkE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(3023799007)(6133799003)(10067099003)(56012099006)(11063799006)(4143699003)(5023799004)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZE9oekTuGvvoJBHvAN3XkvuBZu10GAJshhl0lx7YRKdlfUlXW8AYn7JYAcob?=
 =?us-ascii?Q?k6u1gma849NOWwDM5IEp3FlUDsGgIS3jlvesdIDtDPQuIyWDAa/B6ElpXOzV?=
 =?us-ascii?Q?TA52rM/y0Ej+4PZJBWEhSF7obOSFvpmEiQ3Z2WHs/xdTOwQauSLQ/tXA/iSd?=
 =?us-ascii?Q?ybkdzkuU6SF7eHJe2nVVEzxuV/KwlV7hbTtoEAv5YpK85DYdRIQd8TF4pBEe?=
 =?us-ascii?Q?81nYBIRa1XgDtwRyA/r7RLOyTY2h/wLru2/QuPPFebzhsN1JXr3mJmBkaDc1?=
 =?us-ascii?Q?zE3MFHJTD6pnfucTAuRkeXX+xjee/24bm+WvddiJxmQQQMOKpqLhZRGAgN/Y?=
 =?us-ascii?Q?HLNA8+SoDtjUDsHhLH8w8TQ33rn2+3NOAxHd6WIui+vSGpk05KrFTI4aDSMz?=
 =?us-ascii?Q?ZV1L4+1mrqYGF+bNZL6XpGC79G0usr7IipZ013+nn4xr1y9fX049w+Spva8H?=
 =?us-ascii?Q?hc39axitnB6jle0BgA8YZ1JmH+Jd2v6UYlPAip/89K5TmIIJ8SgUeT26ai+4?=
 =?us-ascii?Q?jCd5c/KS+1ux1VmqBGDu8uYF8BlDvbCDfIVLYLyamsPE3snMuXC4DSuKpy7c?=
 =?us-ascii?Q?Bm6A5Syp3XJ5yJzSSd8dG4yHeJ4TFOyj/awSkv0/WTnkH3mhnw13t4ndyu3/?=
 =?us-ascii?Q?XmqS5T88J+lzFTAVb2Y51TwUK1iuaZoaRMm4AcJtpMa7FHmgGBseqEr2dNoL?=
 =?us-ascii?Q?Ap6TnGZkGIyxWgoAi33+483zqyzHVlgCKUFUCrZK16j83Jt6FLK7m30tUFwh?=
 =?us-ascii?Q?J9YqKbf0zv85xCmni5vvhKQdENxmaadhEXgkt8E6ifgLT9NhunuMYeuKjeEE?=
 =?us-ascii?Q?nFdkqr14v0/OXUvAmQbL5u74L0+yYlKriPCg6/8T+6/YiGCBrwUWp/ji4dJq?=
 =?us-ascii?Q?+NemwPqg9UlZlaa9jVFtS2agl3CK16Az+WKnRpn//R3Hmz5AusJ8whCvickD?=
 =?us-ascii?Q?DQA/DyhOe+7Ke+C3rJ4ahIMDHFnmiFtS0IB1t+4/kNxnk6yKgY9nN17ahKou?=
 =?us-ascii?Q?d2jybGsNybjubHQLyEzlo1xYw8xRsWPl2oeGRCdvv9MGGf58n2HfW9VGkFnv?=
 =?us-ascii?Q?189jWLXwEj5XR9sMSQQL3eeFGN40FEOsn6u5oLQjItkTSHetmWE0u8c2K9/S?=
 =?us-ascii?Q?AtIHi0/N66hrx7mhcpbArMZktAOCvyvA7mxKACBupIVjhIUuDAulbBd/LamV?=
 =?us-ascii?Q?Kz3v0KpgrkMukLMYkNRLwnjEhsrqzK+4t9cOYBYI1kDcQ1AP3qiCLSu6S2h+?=
 =?us-ascii?Q?D7iBWxRE1kNqCedCssaTuemAFeWtx5VlIu7fVv1mOTEdy4RFnzZi0nkacqFH?=
 =?us-ascii?Q?8pxf3o39hVOYQ3ZSMQZ2SnYAr+X37n0h0+hb3oyqnj5bOLc9mvp1YQrSU31R?=
 =?us-ascii?Q?BjR4Q/qo4G61AC6Pgy9QmIL4F6DpBRYtuugl4y/RKjYyUZluMOI5fXIZFwy7?=
 =?us-ascii?Q?XStd+UD7BvZSMaW0VCcAqG9FjKzVdGxyFDNCQLEvNwDFltRM9OoYnr0Ah59v?=
 =?us-ascii?Q?efIIH18Ejh571axwbxaKaMAWsGSIq4YYOm5IEB4+kl/umKfkphDxz3qTkwZC?=
 =?us-ascii?Q?2Z6wrpK6OhSI5u8zG3pQV/5M0O4LSmtQTaeNabcgiCe79Mz4wsQBa0x/8o84?=
 =?us-ascii?Q?cMMQ2Qzb2PFHvLZo6Ov3HYet8V18ZSI1Ia0MC/yWRgwB7A3FZ6cd87wwz7uK?=
 =?us-ascii?Q?lJbvdbzT0/wojlfjEkcTwu0dcEmyXDH0s9w0zM6F7ugaMxCt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de8a441f-bcf2-42a6-4db4-08df02e587aa
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 20:14:55.8368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: In20h/vzpoWdYGlPxOq/3kY5sMBoEmZwSZQ7vEVDJovkHgleoRj7oWergOFr7Sig
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8290

On Tue, Aug 25, 2026 at 06:50:12PM +0000, Pranjal Shrivastava wrote:
> On Tue, Aug 25, 2026 at 10:33:42AM -0300, Jason Gunthorpe wrote:
> > On Tue, Jul 28, 2026 at 09:09:16PM +0000, Pranjal Shrivastava wrote:
> > 
> > > [v9]
> > >  - Replaced atomic_fetch_or_relaxed() with atomic_fetch_or() for
> > >    correct ordering while asserting the STOP_FLAG
> > >  - Moved arm_smmu_drain_queues() after the cmdq->lock wait loop in
> > >    runtime_suspend() as per feedback in v8.
> > >  - Refactored suspend sequence to use arm_smmu_disable_irqs() and
> > >    synchronize_irq() for safe GERROR handling.
> > >  - Fixed an off-by-one error in suspend polling timeouts.
> > >  - Dropped arm_smmu_cmdq_can_elide() check from inv_range
> > >  - Renamed arm_smmu_cmdq_can_elide() to arm_smmu_is_active().
> > >  - Removed redundant bitwise masking from owner_prod reads.
> > >  - Added comments to explain locking, gating and elision better.
> > >  - Added comments to explain secondary cmdq draining and gating.
> > >  - Rebased on arm/smmu/updates
> > 
> > There are alot of scary looking sashiko remarks, are you planning to
> > resend this with some of them addressed?
> > 
> 
> Yes, I was first hoping to discuss them on the list! Thanks a lot for
> initiating that discussion :) 
> 
> [BTW, I'm interested to know if you used some tool to pull in sashiko
> feedback in your replies, such a tool seems helpful!]

I have been testing 'b4 review tui' to help my workflow. I have too
many patches to review and I'm trying to move them all into b4 and out
of my scattered mail boxes.

If you setup sashiko.dev integration:

[b4]
        sashiko-url = https://sashiko.dev

Then when you load a series it just automagically shows the sashiko
stuff (press f to expand them) and you can easially quote them when
replying.

It can be a bit rough to ge there though, you have to get a series
applied to make it to that screen, so eg, the whitespace damage here
made that a pain.

However.. I had AI make an AI instruction for another AI to use AI to
to automagically fix git am conflicts to get *something* so I can use
the tool..

But I like that the patches end up applied on a check out branch and I
can poke around with my editor too..

Jason
