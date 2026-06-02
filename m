Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011043.outbound.protection.outlook.com [52.101.57.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D59309EF4
	for <iommu@lists.linux.dev>; Tue,  2 Jun 2026 21:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780434433; cv=fail; b=i2M5fodHya0iPvk1j41+yjn06H22LNLzwGuZ6ojD/OnlQ56QzAlQ5qRjUocXfZrro2MrLJ/bnoCInVI5FKboD3OxQO/Ds97iAMxx9nFChhJ9o6KX8iwoWvFEE7M9ge2+vz5PbrYlUIjYWUjZOOmbGu/gr5zUuemlUa6bd5yDxBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780434433; c=relaxed/simple;
	bh=k50uyfRZk+2x52PURnx7WnI+NeRR12M3qy8QfH1n0D4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dmMyMEuXyvvwEOI//t22mf6t79dFQKjBKfEsO7EqxOSALo0fc7OEWQd+98IjDUFi4JrgEkhcCy1wAVcP9LjSNGwurDVCxsiI0TEsGtGwvEvATfejBSL0uo7j2LxarrTsbLe3kxKzLoyllS0Gd77wTcVUnx4IvodpJ7Q2UAIVVkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=D2xPwoEF; arc=fail smtp.client-ip=52.101.57.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="D2xPwoEF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YWBvZO5wfRH/6Ntt/P7B2iudd5WI/GQpsu8czv6Nn6RXZ9nsoxL+5ML2tJtZ8C43D6AGwBMq0mDQi2xSoFJBP4yNewif7i4fBeL1orY0fF72RhsQNfiu4L1wtpGvRt+W8zUVD+ZDukHx8LKKmBhXk+Nnb1UXDTdGgjo3Jdi0vSng8rfjejdO7/KlKijamKkU+tMymUEoQEn1DppqIvcVcOq+EyU8Xj1ABcPFGgxlCweYcAitYTo08e/XQBWSY8olqIvPSFQmc7TOsb8aGC7jKZ1zh6wtnxiABZnXCALxPQ9OVjzRSLMjI0aL++HqIMyE69UiXZ2ICpXRdqlaJrE3Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0VrRhDMs//pfjWvMtl0p6S2y/Xfy899r0rDeBGPgNOs=;
 b=djBrF9MgZltdiwhAqGMpUYH2nTcImpC8hgTprFHzfTtcq6Htm66Lk9An56QCO6f9me4F/u6gkOTxf15IMhHpQ/TJhAW88b4u5RV9g43KEOSVlQRSzQUM9ILSqJpIagiQO2FBKr7QWaVj6HnV1TnCCzl6V1trhzIVtptpy6MllrvC9u0XEXyeDsUqvSPEN/hwi70rWrlhwtxRNez7hPlUikytrUPFJw1W/nA9+zZC+3bYblVWDXZMzVUoaDGEVKZznBURBG8EXWcow8y3JfrP3nenLqVYpcweAUlH31SIe7HPPWrc0UYu7Lh58RaRvQh/a4XEsm9XAR2P4vv/Ug/oqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0VrRhDMs//pfjWvMtl0p6S2y/Xfy899r0rDeBGPgNOs=;
 b=D2xPwoEFcww4okwNblsxZz3vFHOelnYxh+fWoNOiegFlsddW+c+sGFp9Ftf/9KcQ5ehAyvCgV/gLbO/AlWGMTD39epbwEZV+L04zW02BHwt440417hbR1Nv0aXC0mgkCVWAOFCa07bjHEDh+VsRVQoho9h2ETSJxQglivOfQ4a44/2/95WAWWu7wZrnNl9rN2P0DCFjShzCobUEPXuJOlYjd2WDKIbNSuBacpXPw9FKhgnF/yl87i/9Ix+6i2fuASItSTDNgkOza5pTZC1r62+0Jjh1CgZkSiEQ+ULMpPcCUVumGgFTaYzE5adnUU4Xcac8ROTYdo7aXm6JJNvakOg==
Received: from BL1P221CA0044.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:5b5::16)
 by MW3PR12MB4473.namprd12.prod.outlook.com (2603:10b6:303:56::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Tue, 2 Jun 2026
 21:07:06 +0000
Received: from MN1PEPF0000F0E4.namprd04.prod.outlook.com
 (2603:10b6:208:5b5:cafe::1a) by BL1P221CA0044.outlook.office365.com
 (2603:10b6:208:5b5::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Tue, 2
 Jun 2026 21:07:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MN1PEPF0000F0E4.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Tue, 2 Jun 2026 21:07:05 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 2 Jun
 2026 14:06:47 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 2 Jun 2026 14:06:46 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 2 Jun 2026 14:06:46 -0700
Date: Tue, 2 Jun 2026 14:06:44 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>
CC: Ashish Mhetre <amhetre@nvidia.com>, <robin.murphy@arm.com>,
	<joro@8bytes.org>, <jgg@ziepe.ca>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] iommu/arm-smmu-v3: Detect Tegra264 erratum
Message-ID: <ah9F5Fy4KMqbStcq@Asurada-Nvidia>
References: <20260601104845.995005-1-amhetre@nvidia.com>
 <20260601104845.995005-3-amhetre@nvidia.com>
 <ah85c4u011WNJQgE@willie-the-truck>
 <ah89vg26255v4lqF@Asurada-Nvidia>
 <ah9EO-djR3Tf9ohf@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ah9EO-djR3Tf9ohf@willie-the-truck>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E4:EE_|MW3PR12MB4473:EE_
X-MS-Office365-Filtering-Correlation-Id: 8013b1b5-a01a-4bac-8ad5-08dec0eae6b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|376014|56012099006|4143699003|3023799007|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	SZd+5c+K5AdOXdWwovQ62l6PGJaN+e0sfGbOcsZP9GteH9jbrESQfZWOl3M0iovqkyJhUSMQfsMp5AHZjH1gT2thAu2u64AbTe/pOYxPuGlcpBvxV92t505EII7ouWjf0TI2sGCx7gStWavWeGsVBtXxm8luAf9Yij1Zowb/05ql0LAvkWx4QIfz/iXmmC62UOweibmh8jJ68V6s9K1OsnOf4lgc0b5mnVJkd0tk4wFl76XbP3wz+Eei0nd91g4P+mmJC/U/jm4Dg/ibGkFi2oSqrCJRsij1qZ7dYuKJUizr+OTTHzkEzJNoDFyMyQ4/Xk7cvr84zpS6ShMfogQk4VsusBDY4E9Hn2i2eehV5ar7DRWxm/JFIR6r44LzTdwb3tlviRkQ24iLMhrEapGndUbqX5ajVc2MbmqVAkR8toQcujCuaQmUWoK+0VTXrbI8GBYGO01I5J9j46aPikXnDryfGj+meoyo891Gg4dGPPA9ScZayl9zOK+OKFjs+u6+TEUnu+GySIkTnXsX0Nelm+pnABtmh5DKobFQvfA8I6DpePf9GPeM48LF4LIIpULna1XO6s2r06B0UOCzSL+fCTbRaTzGl9cYGF1ikzwddUB57C/SN+lQHhpFklZAQicpsmBFvx9vpP3d3p7ppp8Zi9XXgUOZmbK8TF4nHfy72OBEzpSjKuGEUpAnwlYIWsX+x8XgM9CowPFe1pARrmGYQsgz0/b+b9fl/pOQHYA3R84=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(56012099006)(4143699003)(3023799007)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wiGNHpoK6p0mOZbSLKiKBwaJOPHd8Sm8w2seQxqjzzWrTAC67iTYEm2gRTgRG2HJiSsr4O2P5kol0ncU89CQmC22wPKnUxaJBr/nZVlbi5ewahCbVaHwBmVqJ7nOh4j2pj5Ijrwfpzol/7PJGgS5JsT9R3a10NdlHnQ5YTf56zy+zaSr/q0FPonNeBy8PBiF0Xs9y8uaOI3ahGjZueiZ4tP0Bu98nExe2Bviuxpb/d40MKfXNzzHjQDrWkt7fZWgV63lydl1s8Wc0mLwp3xqGlbLUlu1sTOpxay7AoZckyzom+rS5rvDQQ3hBAecRCUT3f6ChioEJsn/Agm1wWt8dbgC4fEwaMZAJxHFWIIMq0EUOEW78e2OkgOiq8qKRxQfJuiUUeuQEqhV39JkBDVRIpAMWdvOQ1mP+NJZ1UIJ5IkokdxVKA/mbxtcs6v+SHL2
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 21:07:05.6741
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8013b1b5-a01a-4bac-8ad5-08dec0eae6b5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4473

On Tue, Jun 02, 2026 at 09:59:39PM +0100, Will Deacon wrote:
> On Tue, Jun 02, 2026 at 01:31:58PM -0700, Nicolin Chen wrote:
> > On Tue, Jun 02, 2026 at 09:13:39PM +0100, Will Deacon wrote:
> > > On Mon, Jun 01, 2026 at 10:48:44AM +0000, Ashish Mhetre wrote:
> > > > Tegra264 SMMU is affected by erratum where a TLB entry can survive an
> > > > invalidation that races with concurrent traffic targeting the same
> > > > entry. The hardware-recommended software workaround is to issue every
> > > > CFGI/TLBI command (each followed by CMD_SYNC) twice. The second issue
> > > > is guaranteed to evict the entry. ATC_INV is not affected and must not
> > > > be doubled.
> > > > 
> > > > The erratum is not flagged by any SMMUv3 IDR/IIDR register, so it
> > > > cannot be detected from hardware ID. Tegra264 boots from device tree
> > > > only and has no ACPI/IORT support, so detection is through device
> > > > tree only.
> > > 
> > > That seems odd to me -- whether the hardware has the erratum is
> > > completely unrelated to whether it probes using DT or ACPI, so I find it
> > > really weird to have the workaround enabled when booting with DT and not
> > > when booting with ACPI. We should have consistent behaviour between the
> > > two.
> > 
> > That's a good point. Yet, for ACPI to detect the erratum, we would
> > need a new IORT model or flag, right? That would need to go through
> > the entire ACPI protocol to update SMMU's IORT spec and the header
> > accordingly, which we don't have a use case to do so or to test it.
> > 
> > What would you like us to do here for the consistency?
> 
> Gah, I now realise I've mixed up Tegra264 and Tegra241 because
> tegra_cmdqv_dt_probe() is only called if the compatible string matches
> "nvidia,tegra264-smmu" yet all the cmdqv stuff talks only about
> Tegra241. So I was surprised that the ACPI probing code for Tegra241
> wasn't enabling the workaround.

I see. Numbers could be indeed confusing :)

> But if you're saying that:
> 
> 1. Tegra264 never uses ACPI
> 2. Tegra241 doesn't have the invalidation erratum

Yes.

> Then I'm less worried (even though it's a shame that we can't detect
> the erratum from the hardware itself).

Agreed, though I think the compatible string is already a life
saver as we wouldn't need to go through the whole ACPI route..

Nicolin
