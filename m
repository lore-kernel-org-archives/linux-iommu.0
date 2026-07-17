Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011052.outbound.protection.outlook.com [52.101.52.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6A82931CC
	for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 21:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784323033; cv=fail; b=STC8rR7ELs+Z8+obcdlxI/unsn/7zy7kd6fuR1cUEcoOA4iIL/Y0hYOW4O3hyB/eRw6LqdKVaQEFW/f86bn2kWYQtGytDnwOXwdhUx88DLtyeOMqf97nzWE6haRfJTUY00azSOGzgOsx4LqWEMiATXXxzexQvfJRnwDOh87+oo0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784323033; c=relaxed/simple;
	bh=2ToBXVtMisecpw40zoPSHu+bqDSS8wh5ZXYFXOnVFwQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cy2BWiEnpZwBHLV04uA74f5A14UJMuGIsGoBG7z55ngS7nlSl6Ejr1mx1neZ34HrWRsG58ryJ1cXyqDDMC7A2NSCg72Z6DZ2SsdL3IYnBowOjtNEwXIHFtFxsAtINVdIKzLIRg+9P8hhZeBZlgOVspxlBBUeVoqBojXN19o+d0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VjJyuEgt; arc=fail smtp.client-ip=52.101.52.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VjJyuEgt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T6IyvfebBC2/VfVbiaPMUIwhNOLnm33zrVNgnc/GYJx+huzkbm3VX+eM8OjHXC6qpDBIrpQuMXuj7+Z2MoRbyeXg4owOraQMG5o6o+ZqRBwRSeS18V4/OlU859j9uawYAm5+EhqJkyvSrtQkg/9AVXZ+Xd4aF74pROSrNIImdVqzstQ3oRmC/uxBPVCLwij47MYTgPxrH4QPsSHQpwtofdJGx2iSnnReEQua4VLDKTKxrS3QaTR4ZPXJo1hxZVkSdFLfT3LnpRrtRIwpidKIcRpwr629ArQP9rb06qUj18Zg8bKFDHwPicPgJ54eveo/tWDJoaLpdqyqa1WaL0VqqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1CT0EbR6A+J8pw2YOPlSdewjShPvq9O9oTH0IwGZ6kg=;
 b=IpElM/hnTO0pzXc9Js9r28Yingl/kHK4mRCfpj5IVosloJIB9AMwzAQH04BUwHwgQ54Zxe6V0PXoFTESqRtMwSKmNiLLqCFdQ4hh68DWpiYeYCr8MK9dZMp/MkXmUrpKraxKaTRXLvZ8CP/IHIV/8c1insmnIpkBkv2EdEBUMxBkfjIM8aOB461Q2QbX0/wE+w0POc3c4FfBu6rGqBPqXPGhpHJpFBArJelLIvP1N6rUbmUs4j/sY5z7F8IrSwIV0zSBN76UCyt+ctZE9RwZnm12PN0DMDqEoyvlmMWLh0v63BHgOe24d2RDX3ln8iMwOjpmJL9wtkr9dwPT2w3/uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=ziepe.ca smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1CT0EbR6A+J8pw2YOPlSdewjShPvq9O9oTH0IwGZ6kg=;
 b=VjJyuEgt5BJS5a6zepbkZSd/Fsjs11Jt558lQg+QeBI2O4eF7AH0P5nW7afk183yHvY1j6/fbdVKLwM7LP/tHXFVOGQe1Pq/uXCLdyrPVrxI4fcMcDApULE3M3W3ZBiJTW0/sN7ppPkUt8LH08uy1NyiFM2veVBq1XQ2y3S4rPW5b24GcbARbq7kGGmwt43wqgeNa1G+qncXY/jmgcPKHT1L0G1WK61z79Oy6urFnO6Fz1DMZ3jP0TrBkS57XIyXN3uPFrqOZUTjz4WRIKIY9A8xIOezcKSGpSWKLEPOp6yfByPXuxc4xecBpZ1CGINj2LmI4lvChctk6j+csiG9VQ==
Received: from CH0P223CA0008.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::19)
 by BN7PPF0D942FA9A.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6c7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.13; Fri, 17 Jul
 2026 21:17:07 +0000
Received: from CH2PEPF0000009F.namprd02.prod.outlook.com
 (2603:10b6:610:116:cafe::5c) by CH0P223CA0008.outlook.office365.com
 (2603:10b6:610:116::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.13 via Frontend Transport; Fri,
 17 Jul 2026 21:17:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH2PEPF0000009F.mail.protection.outlook.com (10.167.244.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Fri, 17 Jul 2026 21:17:06 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 17 Jul
 2026 14:16:58 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 17 Jul 2026 14:16:57 -0700
Received: from nvidia.com (10.127.8.12) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 17 Jul 2026 14:16:55 -0700
Date: Fri, 17 Jul 2026 14:16:53 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: Ashish Mhetre <amhetre@nvidia.com>, <catalin.marinas@arm.com>,
	<will@kernel.org>, <corbet@lwn.net>, <skhan@linuxfoundation.org>,
	<robin.murphy@arm.com>, <joro@8bytes.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v7 2/3] iommu/arm-smmu-v3: Introduce CFGI/TLBI-repeat
 workaround infrastructure
Message-ID: <alqbxaKVYFX1BZR5@nvidia.com>
References: <20260714104202.1664187-1-amhetre@nvidia.com>
 <20260714104202.1664187-3-amhetre@nvidia.com>
 <20260717201841.GC701389@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260717201841.GC701389@ziepe.ca>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009F:EE_|BN7PPF0D942FA9A:EE_
X-MS-Office365-Filtering-Correlation-Id: 442c223d-dea6-4aac-a97e-08dee448c178
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|7416014|376014|23010399003|6133799003|3023799007|5023799004|4143699003|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	j1KL3XNOyAPaS9KtfVJCeR8lJ7NbrNuDBqsp9PSTBAxS3fNLp+xdhQQpiIzOaW0jWH2bxSsgRJTMDnvIkXYz+KXSWMicUM9MfIWORTf+DuaBkh/NutyRkhJq6zJLjwBjBjPJvy8v3JyVkrmiO8GmGZc+O26YbtdKX5Z2iVgDjfu0FU+tDmhYOVK9SfzqPIO0lrYpvEd0N8R1WBvJM4BjmrLH5UfV+OC/6bxBTKo6b077MmMNwdr9M5J7rO/6/3ZWisdHN4GtFPWhf7/PjJ6VKLr6t1HP0oOWlSOSFxyn16dbDkGFSwCTv6JSGq4U8NsR5DxcXZqFev+AgRxb0RjS5RD1twxM10Z7d0bp/ufT1LZXrYsYDvHGpxoosB7oqNt+mdqpMjhc8g3Zqt0Arxq9G6opXIuhS8ubnchccJm/yZeUCouzY6W9/xDEqGKXbhAcDNDvzChNVzHexSouye8UxBlbrjvvZk0PGjgEZMcb4j719LL3PNeoqkSfoRud8UaWRNBHYQlNZPvbnvyMYhFRbehkadOrnDIIUuLrZ9zLsQsTeRccjYPBiG6szteKktQGB08HiFsYm1nhV0hVOqhU6VgWlf55W0lwzlNOiL2DCMBGbPdfm5EXfJ4SYTN6L5FLaJjHuw4xdMHzGftdfyy+Y3P4DBsQ4CervfHN0LVusMAwSSzP1pDFoA1J7w+17wLqkJ0jwwl982JxFDH1/AN7vQ==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(7416014)(376014)(23010399003)(6133799003)(3023799007)(5023799004)(4143699003)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	WF+oZbWQYg/Q+tdWeeC/9EYKxMlsbs2T2ZIlxl8PrzIrZsOpjAIfK9xyzUaZ3yzFn77yeF96Y18VIv5yjxGcL1QZOblssUXXAqmLev01PFy0dPKahEkTFcOgdBGJxfNt0sGGkE/pZ6hFj2PXL/Q7vbHuLhdDBT7JbpE6cYprk5Q+ktUOKVYFE89jMtY6kQYiwBQd3SWIY9Pi80RdFi8UUdqcJoiJk+svZTA9pOPkTK/7NlkuWURnxIQGMzEtXT8z93JQl3ARwcGKqc4E0FGhdZUBjLfHdTbirv0nUhGKwAgD4P+uSJ7aRGQNIZ3kD/DbFXF1oPUnSIsutXXGnBm4FJTHCXF5vnfvqP2vTHj3e/PskxDQLs9zhpA7ypIQ6upO/FoYOxRPQXg/7xCBCjvfJ4QHVzVFSCTGJurrOaHqocDlbdB6ZY460zlxtFi0D5XO
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 21:17:06.6581
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 442c223d-dea6-4aac-a97e-08dee448c178
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF0D942FA9A

On Fri, Jul 17, 2026 at 05:18:41PM -0300, Jason Gunthorpe wrote:
> On Tue, Jul 14, 2026 at 10:42:01AM +0000, Ashish Mhetre wrote:
> Because the VM has access to VCMDQ/etc it can issue commands directly
> (maybe not on this chip, but as a general comment), thus invalidation
> errata need to be made visible to the VM and we need to expect the VM
> will generate invalidations to properly deal with any errata.
> 
> Ie I'd expect the VM to see a "nvidia,tegra264-smmu" compatible string
> to activate the errata fix.
> 
> If so then we will already get duplicated invalidations here and then
> we will duplicate them again. That's not great.

Oh, that's a good point.

> On the other hand if you want to emulate a generic and actually
> functional SMMU device that has nothing like VCMDQ/etc then you must
> do something like this in this patch.

Tegra264 has virtualization use case. And It's built with VCMDQ,
which should be the default case than the generic vSMMU case.

> I was imagining a general direction that we would expose the errata
> information to the guest and the guest would have to deal with it.
> 
> Given this is the opposite I wonder if we want to do it. It does make
> sense for a chip that probably doesn't have vCMDQ and I don't think
> qemu can even create a DT description to trigger the errata anyhow.

I don't have the source code of the VMM used on Tegra264, but I
believe the guest kernel can be the same copy of kernel as the
host. So, its VMM is likely to use the "nvidia,tegra264-smmu" DT
compatible string, to trigger the errata at the guest level.

> But it starts to become confusing down the road if we decide other
> invalidation errata (like the CONT must be RIL thing) must be delt
> with by the guest.
>
> So.. Maybe add a comment why this one is different, or maybe just
> disable FEAT_NESTING if there isn't a use case?

Given the use cases on Tegra264, instead of patching the iommufd
path as this patch does, perhaps we should simply spit a WARN in
arm_vsmmu_init():

	if (static_branch_unlikely(&arm_smmu_erratum_repeat_tlbi_cfgi_key))
		dev_warn(smmu->dev,
			 "guest must WAR the repeat_tlbi_cfgi erratum\n");

?

Thanks
Nicolin
