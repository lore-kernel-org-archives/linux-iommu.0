Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010002.outbound.protection.outlook.com [52.101.201.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212623019A9
	for <iommu@lists.linux.dev>; Thu, 18 Dec 2025 17:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766079340; cv=fail; b=HdK6IznxlLPLmcJgvfyshtNBO4wpjviRCS/7OJ4v89e4bLfEaIoJ7PrS87iuQViBJD0CZsc9hOLTFjWJIyCIZSANWLk7s0cS1AOrZSzfi01J1ah3Xs0RigQg/XVCgIqkHVdHM7YGtj4fifPLMjA946kQqBnJBD+EAcQJ9jvHgZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766079340; c=relaxed/simple;
	bh=K4JyTnrS6UegQjT0AtqmxBHeylNpqqjHio2mvNRu2Z0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=detm7i3CAIeikTGI8yDl5DSHYCNXDKVJrHfCzWuKWmT4JynMAnSchY8gJLeE3oRJmrKEeQIZbLglHPuPwWpCxjydi3f1mA5D1FqlzS589YS1KRqQsILeJSWi3X3yEJeTXj8VBxgh/yaobseIxJ1riRyqx6CEZy+SRRtYe71YbuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aibtyX5P; arc=fail smtp.client-ip=52.101.201.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aibtyX5P"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QCByGnsKK+OBin36MpkgaxqG8qx0MfZClsbQ0ft89ASnPkT0oegVS1lmu0+xtayDkPii5E5OWcGDQmQLGH5Em8douNz3Vj8XDqpmpTrasmFLcOK7GeD7CTxKbXW0S956BzCyKqm1HBRiBDEUYgCL2qq5I31OZ24r5LgC/7WMzX8eegAQRNKdDge9T0ON7p0542It2gmSR45+eKka2JBgRi6gdFXzZMbgNXvY4OJkjLRwyyfaJ7gJ6Ha96TCHhNuz9bgUytXu7/FD54FSviuVsguJeFmvteNrPaDbZ3PuGBsbpLGhd4Q0wqNME80+SMopV1whjGloIO8ZbKCu9yN2ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ab3TSzJWWMVOJoLWYrwS6xO5gKMAFeW0qCdN3NKEyJ8=;
 b=w9ActZundPp1dd7Oqf9gR2AVGUK+tsclwnbSODDUOIRhTp3HY4nievenR2wEijMRqqxF4Q6XcUYRzycxJNhecx4EXUxBL143473ek5Ak+F6b2we9UAvkZ1kVSaPaeVXzhye3milqT1k7apz4LxjMjCS2ykMYkBM7Uo4cY+Vb2CCSTvb+jQ7xEYg7JQlOnYnYJpoclPddNp1uZ2x8MVXxWQE3CQLQwOcYjioXpZ9XTkZeLsS2MZfjfRyw5YdCsGPcn1nt5vCsfIyezr5lacC6No6MK101+/nhnVul7+Zh49afxwUYjZgbO0uTjMgIinAokLMihumkPex1hYYPz6Ci4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ab3TSzJWWMVOJoLWYrwS6xO5gKMAFeW0qCdN3NKEyJ8=;
 b=aibtyX5PncWs7WqD6CQ1VvF8t6u4XiavSdcSPsRS6dzS8W0+uwjo29k3sqXylScdQ4PFBftWQPiO2dZeYXn0umE+U6e325Lld1fFlUAsGuqz9Zf8IL65BBL3BU8HyXjJqvRInO3kPN3DxAIk8pVZ3128IddWgl9FNmV7kH5tub9wXqnIDFutR9uzkv0EfNne7c8JMqfgl4CVDMaxFEiJPAYu7F7kQIeF7Sf3C+px/XDz9R9f95Dzx3noQ62ppND64x2b2VdSneHPIwPA3g1Ks9i6Vb2bDh/ncbUe/UlTa+692JBJY9guYfokkaEvmTRmpHEPWGzgFezjEGQafRBiNg==
Received: from CH2PR05CA0010.namprd05.prod.outlook.com (2603:10b6:610::23) by
 MW4PR12MB7432.namprd12.prod.outlook.com (2603:10b6:303:22d::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6; Thu, 18 Dec 2025 17:35:31 +0000
Received: from CH2PEPF0000009B.namprd02.prod.outlook.com
 (2603:10b6:610:0:cafe::12) by CH2PR05CA0010.outlook.office365.com
 (2603:10b6:610::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9456.5 via Frontend Transport; Thu,
 18 Dec 2025 17:35:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000009B.mail.protection.outlook.com (10.167.244.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Thu, 18 Dec 2025 17:35:30 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 18 Dec
 2025 09:35:12 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 18 Dec
 2025 09:35:10 -0800
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 18 Dec 2025 09:35:09 -0800
Date: Thu, 18 Dec 2025 09:35:08 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Mostafa Saleh <smostafa@google.com>
CC: <jgg@nvidia.com>, <will@kernel.org>, <robin.murphy@arm.com>,
	<joro@8bytes.org>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<skolothumtho@nvidia.com>, <praan@google.com>, <xueshuai@linux.alibaba.com>
Subject: Re: [PATCH rc v4 4/4] iommu/arm-smmu-v3-test: Add nested
 s1bypass/s1dssbypass coverage
Message-ID: <aUQ7TAHn5/2DNyhw@Asurada-Nvidia>
References: <cover.1765945258.git.nicolinc@nvidia.com>
 <6fcdd663d62dcab4005401bac2d23d18dd28e0c4.1765945258.git.nicolinc@nvidia.com>
 <aUQwKot1Ao0lE-C1@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aUQwKot1Ao0lE-C1@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009B:EE_|MW4PR12MB7432:EE_
X-MS-Office365-Filtering-Correlation-Id: dd09cb72-1fcf-4eeb-8ffc-08de3e5bd74c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dpxEiRePvGegemd+sz2ToNCfh9Ek6gtXAaS+hiUGZu7zu0dm/U5Nz4JJSYKK?=
 =?us-ascii?Q?d53cCkfSsji1d9v063+u2HRRL85RdaGkmgDvcu1vMleXzUHT+QAqaGDGuT7b?=
 =?us-ascii?Q?PeZTkUUjHPyJ2H4wPO+Riuw9YktjNmv1KzhbZAaIQ46KIPj4iKuc8wZ+LyH/?=
 =?us-ascii?Q?7puug+Anmdg6CWJYG/FQcryHIej9QLkA1O8ROLfFU584J0pecffbt6ahQHMk?=
 =?us-ascii?Q?W4uCkJLheNcRWpUb7KYyWCXN9toGeWQcIe7UX6aZBXnItGGnAhjkn+6/AbAj?=
 =?us-ascii?Q?0C+IOE/h9MjdUDinBoMiBoiS0WYBv5mKmSG6GUbb8nglbHXrlCEPlcEsGMuc?=
 =?us-ascii?Q?0n+wGRHXOOB3Bep343K4aYYEsvCvzDGgkr525VhSjCUgm1WBHSnj5RxNB3Oj?=
 =?us-ascii?Q?puWqqMYqiK6QP4qupvNquty2FpWpGJNwnxGjiVkVPDuh3wQJlqwpf4TksCVZ?=
 =?us-ascii?Q?6ZytgpWhYvHZ/Fi+N4Tb8khq+6x15rWzoKSqw1ed79eWVPjExk63BdGIrAPn?=
 =?us-ascii?Q?DSRaHY7olZ4krKJpXt/Iwwxpcip02ap6z0TPNw2jwD/ktWPcSF8p8yhAspBl?=
 =?us-ascii?Q?kTnlhL64+76AJA+uxe0Rm91n7s5MTAfP/ZfP9TRB0oLrQvWcKen8o/lzEgBE?=
 =?us-ascii?Q?g/n5yH3w/ovTsVw2wQPX4mmjBL1N2KyEvRNnYoMQPpqox6UOyWOnD0rmgpNc?=
 =?us-ascii?Q?u+30K1J0QD7C+WYvQbFAdl5ba9F5kVeF4rVBCgjrj7bR+nT+9nK3aiAyshDv?=
 =?us-ascii?Q?KgBlFTUkHg+xxPwfDDbUJ/VQiKdYfVFXjIfEBRY3u4XlNWeJXkcSVefZfuJ4?=
 =?us-ascii?Q?uoyfBqLXcU1OEGnuy6PfF9Se7XFLffzdHgcRd1i+7HZSUgKYUl40gH6Wavgr?=
 =?us-ascii?Q?eRCqWubBg70rAV7Tqrdmj/4KHMihkV2fd9RZF10+Lt8/JzuxVwLoQj7tMdWG?=
 =?us-ascii?Q?oejEaHtz2cTLBAKgdmkKol7AKBc8XrZGD1Oxdl1Q+O2PZBMxMJIHgCB1vSiI?=
 =?us-ascii?Q?qWnltQacEeRFC7HWpc9u5pCMmp6DGuIhHF5JmlwSmSVwZmNzwzNk+2beODJc?=
 =?us-ascii?Q?T5cymZLOQUE4b/56LueTsnZGRpFGA0jevFkiLvLJJ60HXttNmYhCC6AWzoJ1?=
 =?us-ascii?Q?A+Z6Lb19LCH+KGaxIQqZ2pcoDDTTg9ELhqjhP1UOcRBTCNyGVk2aX7XczPsO?=
 =?us-ascii?Q?Lz+xiumEIsr1Pf58+HtKssDepr2gm0DNlsKzFQcn57oRgXG789qqxOdK9PxT?=
 =?us-ascii?Q?un2a5uu+je4/SSC3aJspIIYxCbNogdNjUgnSJceEriA1qUkLzmNGXMywRror?=
 =?us-ascii?Q?JPvjllk/zkUGFDqTeWBeIHY9NqlpkiL6daZTPu2UZaSPHJNUOCoxoSJfIOQJ?=
 =?us-ascii?Q?71c6bGEK06wGkRL44x03lddV2DYfhfxJ0nm1xmsH6YAazgnrInbmRH41jScf?=
 =?us-ascii?Q?o3ehM63HbTYU9DMPas9f+7wbZBYbmx0C5jzBJceVY5PNGYY4hI9WJ/cygYHt?=
 =?us-ascii?Q?kFcLtFXIAua2QsXL4xT8sfm0wjdSYpkhAVBoHb++JScdYPQOCeKbalS8fK9w?=
 =?us-ascii?Q?EuI0VE/YVEyo/gUfB2k=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 17:35:30.6741
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd09cb72-1fcf-4eeb-8ffc-08de3e5bd74c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7432

On Thu, Dec 18, 2025 at 04:47:38PM +0000, Mostafa Saleh wrote:
> On Tue, Dec 16, 2025 at 08:26:02PM -0800, Nicolin Chen wrote:
> > STE in a nested case requires both S1 and S2 fields. And this makes the use
> > case different from the existing one.
> > 
> > Add coverage for previously failed cases shifting between S2-only and S1+S2
> > STEs.
> > 
> > Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
> > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > ---
> >  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c  | 46 +++++++++++++++++++
> >  1 file changed, 46 insertions(+)
> > 
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
> > index 5db14718fdd6..8255a02f4efa 100644
> > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
> > @@ -33,8 +33,12 @@ static struct mm_struct sva_mm = {
> >  enum arm_smmu_test_master_feat {
> >  	ARM_SMMU_MASTER_TEST_ATS = BIT(0),
> >  	ARM_SMMU_MASTER_TEST_STALL = BIT(1),
> > +	ARM_SMMU_MASTER_TEST_NESTED = BIT(2),
> >  };
> >  
> > +static void arm_smmu_test_make_s2_ste(struct arm_smmu_ste *ste,
> > +				      enum arm_smmu_test_master_feat feat);
> > +
> >  static bool arm_smmu_entry_differs_in_used_bits(const __le64 *entry,
> >  						const __le64 *used_bits,
> >  						const __le64 *target,
> > @@ -197,6 +201,17 @@ static void arm_smmu_test_make_cdtable_ste(struct arm_smmu_ste *ste,
> >  	};
> >  
> >  	arm_smmu_make_cdtable_ste(ste, &master, ats_enabled, s1dss);
> > +	if (feat & ARM_SMMU_MASTER_TEST_NESTED) {
> > +		struct arm_smmu_ste s2ste;
> > +		int i;
> > +
> > +		arm_smmu_test_make_s2_ste(&s2ste, ARM_SMMU_MASTER_TEST_ATS);
> 
> Shouldn't that be conditional on "ats_enabled", I see the callers of the
> new tests already set ARM_SMMU_MASTER_TEST_ATS.

I will fix that.

Thanks
Nicolin
