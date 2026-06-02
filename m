Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010071.outbound.protection.outlook.com [52.101.61.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0451D335BBB
	for <iommu@lists.linux.dev>; Tue,  2 Jun 2026 20:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780432354; cv=fail; b=KzC6alZ1+W8LM59EzDJg1LVq6vg3ZCpn0v+1jV/YTqdonHOeP3g2AEjlf2R9IZYKrKrokMVCOdl3aR+a1M1Zc3Cyq8EyqgjF4/GLw9mpPW52ldTkFmUnJLNwUcOEMSKBXkq+8FOG/9MfhdUOk4E+QNOIXPoCUNnb4wIDhhACWQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780432354; c=relaxed/simple;
	bh=EVHTXv6lMPTZwpqqAeIz0tC4J23HYHMRY0O3w3MARso=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KP295n3GpHqgpYBKKgkbCxGMG1Vm8Qx7IWPmPL6aR6njIe431Us39QWfYpSZR791aIxA2W0Bn4iW+eHGxeMq6mcdTOcuXNX/Nh26C500h2PJHD9pv+wkJBEpX/nUGdHOn7HbP5jNYTqJaYUjV5EhLc61TaeUS2pm/NkGQzULx9A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HhDReQfh; arc=fail smtp.client-ip=52.101.61.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HhDReQfh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Eg3Tf7BKbkv24KwAOAZj/CTSMwdUd5Jeq0/JL0Xe4GpGNG+5bE1ZvhhTgN3I098hx/u/xAROogatZYjtuI7ovtLB7G9o2gsudFqycKtjZAWw4jkwGZoUV7J7F2LvLGlmBUcMdUtjtO7Of3fMKrYFuZYHOqCxaLCFWHtx6R091x0wKXDzrChspW2LqVDvlmAsTj2wfzxTdddRw9mEoZ3IpkTo8OcLioRd+MHvYfE8kgnNC/dam3X/DtjBTkxq+WYX8fZKu3Go4MrPzCXRQxN9CYHQOOVG7zQszt+dxycKP5WzN5PLhSYZowWrncx6VhoYu0ByIgyfXzMQ7RvY+tWXig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ok9QcQrichUM6IEKMrfbqKW4ACDvRAi+XpzKvuEvIg=;
 b=cghxWxUhnVcyb6G8tkeOiZ/txJdPepENLHRBIfEmdbqmZ0sEr081X2STcPa4BAgNXy076PpVi/si1LM0gmmpj9lmG3/eOAKt/vDmluhVNxwm+ibbNrrN5MEj5ge9aE+Y23tzLqo9o9LmiSA31JqJMa7yjElwJvCIxPCtoW7P7ZcfrUUnhc6IvRy560AZuHfDvVyOdEMFDY/TaR2dwx2ZyELz0oOMoV4x9C+RqlmsUIkyLE5/8DmAghwm4txOLlvlFOZgS1WWntBmFtFwXOYhctnh9cfbZc8gr3hH/NoaFYCQg0R8gVIuqD7OPg/m1fT2sLwrbYpAImwAIsFejcrHPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ok9QcQrichUM6IEKMrfbqKW4ACDvRAi+XpzKvuEvIg=;
 b=HhDReQfheYIeazcbBdtORzbGt3gPGqH6m4BdP01D5+v8A7Sqv3Gr6U4dNFjnf9csXQSEOTGn+SbE9UZaV1X+ahE+ekZrj3hz0Q0F8rCAOcpQuKWxTA1ihrQt142B2CWjY6PVzBuxFte2eTUzZP0qKJh71b90IHrwNnSjRvX58WIL2Ou0nhhukOvkJTVdiQ/XVhHMVrWnjHDy4U70kMp6HnMuEGFbaPx1IJiNGuMlz6gRLT5bu5RuMHWz3HnS5cstlss6p4YYPuiihYOntj6A+LJ2Olg8aQ9Vn8WBpWdALh8U0sWMEZ7z8+t6GZCkiSjkXqDUOa3CXi4QcWFrIGtxnQ==
Received: from CH2PR02CA0022.namprd02.prod.outlook.com (2603:10b6:610:4e::32)
 by LV2PR12MB5776.namprd12.prod.outlook.com (2603:10b6:408:178::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Tue, 2 Jun 2026
 20:32:24 +0000
Received: from CH3PEPF0000000F.namprd04.prod.outlook.com
 (2603:10b6:610:4e:cafe::98) by CH2PR02CA0022.outlook.office365.com
 (2603:10b6:610:4e::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Tue, 2
 Jun 2026 20:32:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF0000000F.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Tue, 2 Jun 2026 20:32:24 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 2 Jun
 2026 13:32:01 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 2 Jun
 2026 13:32:01 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 2 Jun 2026 13:32:00 -0700
Date: Tue, 2 Jun 2026 13:31:58 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>
CC: Ashish Mhetre <amhetre@nvidia.com>, <robin.murphy@arm.com>,
	<joro@8bytes.org>, <jgg@ziepe.ca>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] iommu/arm-smmu-v3: Detect Tegra264 erratum
Message-ID: <ah89vg26255v4lqF@Asurada-Nvidia>
References: <20260601104845.995005-1-amhetre@nvidia.com>
 <20260601104845.995005-3-amhetre@nvidia.com>
 <ah85c4u011WNJQgE@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ah85c4u011WNJQgE@willie-the-truck>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000F:EE_|LV2PR12MB5776:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f6fb7b7-e389-40df-6d4d-08dec0e60e2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|82310400026|1800799024|3023799007|22082099003|18002099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	sCCTGzjkQ9nNpzyvh3yEOWew/2D9r0Vuh+nqINps45ZT3+h3O9e26J8vqWy6eZbIi99mQJra4SwvpnecdacHUi6hvMjW4KFlx9ljm9EntXDM2+yboN0mSsZjNNzxzNggBy/czJNJHpUA3xWnM6ioWuYkk8p34VEsVw5FC8ax/WGM7Z2JZOJ+RwyYpwzrVWD3MTLcgryiJTO889kH9rgIPSNRZ4gNTPdxZBMoYL3nfRGrnw/ebztCO+D4mULayDIq1ySNCr95vg+Z1oZaewBf/0daP/QzESSMcTYes+47RKf7R27jY0GTz9mgMNQ3yTV/vHHeIh1Bi67cAN7Y4COeWWKypWivgD+xdG4zRHc+rtEwncioMNFuxUSHJOakwwV1/02xCj8fB2jMSe8ypx7rBhqWlv9P8El/qpAwCSZPH5my6CwHsT3ZR3vGp38jHp7vrckwuFgT8/DiMvGx0YEIipH8bhjGdq8vOOI0nw2cKpwFJr9DTqUYNOnUYwCUdAdgwvIHylWmGZFXjdM5AVgeVjBoqACckBFgcsbU/bf2jLYQyk6yFLdtGRfMoK1k9vo4G5VV2H8puXvlyMkgtb6ROKT/EX7LeT5o3o53FfAucRBB2JPtP9fAbj399AOAtTuYUpvBWRtLrq+Cgmnh6fqf4PBa2myQ0it5yRrv//q9cxfgAiDLJXGNPM5e0ZOM6zlHjEni76EfDkOWjEcGMzO8usi4FRwosDt7KvITkow0OLw=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(3023799007)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	G80tG+C9w+1WhDES+CEtTi1XYt5AJd7PEolxzQKnw4HxWaC32YwNpH8ui61Jj+YdkhosW4KI9KiZbTF2emxGDjZvdI5U9aG/2D34MteuwjkCv4oSYL9hs2LK9lD9yOpeDDeXDWQ3tOecc0YYKBTS5LskB097ITw7kgMKMT5UhbxritS7TMg+46zSzANgH30lCUUxgkwcEp9iP1zATJl9OVKgWmybll+FcVfsUKYEH4SShHQtNe6W87uNMpqPUlmoUmblYNH6x+t2TraUL8/S6MFP5m456j7Hf9DQCWt4cB241dK7taROqclZ5+FQsND/4ntIq5srmsvPNl3py9P42x6Nn/mkfwOMd7roQCli8fTZtN+IXR1vFnxC94XG3qDPgAkTcGUCuwceVprsrevviqc7sBRY3whIGlQZRNJDwffBVjf5DZRbLRkTvqxsm9Th
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 20:32:24.4414
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f6fb7b7-e389-40df-6d4d-08dec0e60e2c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5776

On Tue, Jun 02, 2026 at 09:13:39PM +0100, Will Deacon wrote:
> On Mon, Jun 01, 2026 at 10:48:44AM +0000, Ashish Mhetre wrote:
> > Tegra264 SMMU is affected by erratum where a TLB entry can survive an
> > invalidation that races with concurrent traffic targeting the same
> > entry. The hardware-recommended software workaround is to issue every
> > CFGI/TLBI command (each followed by CMD_SYNC) twice. The second issue
> > is guaranteed to evict the entry. ATC_INV is not affected and must not
> > be doubled.
> > 
> > The erratum is not flagged by any SMMUv3 IDR/IIDR register, so it
> > cannot be detected from hardware ID. Tegra264 boots from device tree
> > only and has no ACPI/IORT support, so detection is through device
> > tree only.
> 
> That seems odd to me -- whether the hardware has the erratum is
> completely unrelated to whether it probes using DT or ACPI, so I find it
> really weird to have the workaround enabled when booting with DT and not
> when booting with ACPI. We should have consistent behaviour between the
> two.

That's a good point. Yet, for ACPI to detect the erratum, we would
need a new IORT model or flag, right? That would need to go through
the entire ACPI protocol to update SMMU's IORT spec and the header
accordingly, which we don't have a use case to do so or to test it.

What would you like us to do here for the consistency?

Thanks
Nicolin
