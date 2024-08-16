Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B74B1BCA1C
	for <iommu@lists.linux.dev>; Fri, 16 Aug 2024 17:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723830098; cv=fail; b=f8WTE7XiFmm0fauVivCPOg9AjVaZB+P4jvAp5AkAYHbvtcqqS6A2uorNtNcn0fSbAZ0EfVv6XTH6zXzJQ9fDZLjPLmlZLV2zqjQoC6H3t3caqxcJ2HDzJTBEQskYikb5yMP8eO8fnjEivtNLCwKN8BSOjh4COCT97zHd8XfD4Fs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723830098; c=relaxed/simple;
	bh=s9bXLS1iFMnEq52qOf5FlDJ2XB1cbda4LQdyrIVx12M=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JgNJQ67K8ZPT30WKNF56hgtKdMq+wtnjZcmp1GEEPbgHowp7fd3yiKgrnO96j6vKmUjPR5dRkE2sR4aXHglk8JAqsLQxDLAAarY9DQNq18vwMDEuCXXAHNFeSTBcA5ol3tmfU38yXRscdYfiW6IhUIwn2uugwYDkalWZMokWZ5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XBbUFxGa; arc=fail smtp.client-ip=40.107.94.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XBbUFxGa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CYe9Auy+7ztFK+BYCi0hcl7YjzhasiVwEJ+jhTqOGTTrx9Q6cjM/X5WnZSTLi73UAfl8jhAYbLWOLeWKxkLdVZK1NXAkXudKbf5Wd1J8RCWHuLtfhrESKcJT6KTp78cVV8JP4Ehdn0wOFfL0NL3KpqGl5/RQEZPJ+I2VrOXmW/OU7a/YD4c5jm7kGpqK4KjMRwUTHxq5jj9pH9LP6VG+qKwt+RCmqHMe5wB3PppmQF2I18DxOV0b/JccV+BC8fG8NQpVxXakRVnrFIy2YUipD/yQcObXSQk3o37xRUDOosT0I9ATOLLx9KYtEvIG7JLZGfvSZ6OlMzQ6p6ea2/ccQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=25+ZofvsjXoj9EkPTUia/NhNGB+/sxSSPSPwEpiMMIs=;
 b=xHtndRJJ6Sg0IlXYR7K/95bu8VqR85LlnaUEktm285mqJs3ivmbZ46qJUzkubdxpfNqMflCkfFzpI+4Fquu3Qb3eTK3x5mjvRdd9qB/YaLHzfePytydz0HHLqupVs1qmXwR6kDYrqTOxYK5zgQPBbIDQS1T6bfK1kMyx3AH4m1MzMPc+imjV5rQOKD+AdrTVc4mP9zRPcX68l4eOY1+ExWJJjMDJk21NMmUJUdxfpujllcjUz+3o1mVlZJDlPA1pPsP4lnl8jrryZm12gC8Y1Oo34Pv2wNeY3XrA6ufC/Alf6uNcbhQbcQztvNdDVLNI533cDSCV0anNlg5iuGJFAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=25+ZofvsjXoj9EkPTUia/NhNGB+/sxSSPSPwEpiMMIs=;
 b=XBbUFxGaW8umWDpNdjb3WCqu+DJGVFjhAmyE/Q9QSKxRLbIrZM56xzBXcA4/Iqxnf9PZ/mhJTRGnf4B2NEhXQhCxNZYfGV7pLlzP9C2rHbVHxKNYrIIDA7niXRdpcfeDQWfdvvD61x7WrXzeo2HDPwdIp8uLU062GEeOWIW3AdWlCzcuKYJm31Tul21mDpqaC30ztqZTCXcTRCMvVnVyTWPasv58d2KTmMelHwpAEQ/sVWGtlD5b98TEO5fTcmzQsNnxoHHX8ZVvYtDY8ePfL8Yb2ZQNmn88l+H2uPFh7+E9+r8kpuRINpoyFAKGztM5b/faHEOPjt46lxMYMfn2Vg==
Received: from DS7PR06CA0001.namprd06.prod.outlook.com (2603:10b6:8:2a::12) by
 IA1PR12MB8237.namprd12.prod.outlook.com (2603:10b6:208:3f3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Fri, 16 Aug
 2024 17:41:25 +0000
Received: from DS1PEPF0001709B.namprd05.prod.outlook.com
 (2603:10b6:8:2a:cafe::b4) by DS7PR06CA0001.outlook.office365.com
 (2603:10b6:8:2a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.23 via Frontend
 Transport; Fri, 16 Aug 2024 17:41:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF0001709B.mail.protection.outlook.com (10.167.18.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Fri, 16 Aug 2024 17:41:25 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 16 Aug
 2024 10:41:09 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 16 Aug
 2024 10:41:08 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Fri, 16 Aug 2024 10:41:07 -0700
Date: Fri, 16 Aug 2024 10:41:06 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <jgg@nvidia.com>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v11 8/9] iommu/arm-smmu-v3: Add in-kernel support for
 NVIDIA Tegra241 (Grace) CMDQV
Message-ID: <Zr+PMiRKCYPgkB+1@Asurada-Nvidia>
References: <cover.1722993435.git.nicolinc@nvidia.com>
 <849c17b97ae0a38db1cee949db2488e4045666df.1722993435.git.nicolinc@nvidia.com>
 <20240816141926.GA24676@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240816141926.GA24676@willie-the-truck>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709B:EE_|IA1PR12MB8237:EE_
X-MS-Office365-Filtering-Correlation-Id: aded2c8f-3786-4fc3-47df-08dcbe1aa6d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qIVub+UdsVBZj6/7xLZYT1kwI5Qfo341R/KopwcbRQbGAQockPx0npQtSQct?=
 =?us-ascii?Q?6YemGaGNfFpsESk3GGK5itnFpwGDFIRVvI/DSZJmxhilC5myg7rb1XYdfBww?=
 =?us-ascii?Q?GBn+1F0LI6IZwDKGgCz3bF0jOxIvaYYxmmee6XlOzrdxkRnIHjW81jETyUCX?=
 =?us-ascii?Q?YZyXeDsSDRVuX+6bgHVQ29C9gnD3qaiREfiuTOmLf25ujlnNIEvjkrUVq+gp?=
 =?us-ascii?Q?lq9fbOYTO/MyQ2ebZSj6vb3Kax++qX8zyo4BZlrm6abE6amHj2IDV1aRlM9I?=
 =?us-ascii?Q?a7IObhGyHa0KDfjDRW7TSGKLJUek7GkwVQBgc8kiQhJZCzFLH+mhxw9xzULo?=
 =?us-ascii?Q?tldpLxKyA+jjQIH1zKUNS4C+12WjEkbeEMSmdzY/i6pclT3Oz3uHh22v/Iad?=
 =?us-ascii?Q?qd4VGrhMqhbOE8IAQXFQM2fwst4s0vcNBdpwW7zGhkH1pKr5EswFEX+LgKsj?=
 =?us-ascii?Q?u1CugCDEacvz/dwrUTIbzoau8Fb+oIl+SLQlL2kt4mA4q62PDpbN/vunYx9U?=
 =?us-ascii?Q?PWlfzPtnZb7SAmI3cW/dE3C30NW72wbv3SY8ufVnN+aGRRf2EeXWSvKze7zR?=
 =?us-ascii?Q?R/MDtqEtNW0sM28efj9UWeAeW18YMnTk+wmCDbYL7TbAXRHQjVA2O+1wZk6/?=
 =?us-ascii?Q?V4WBCB8GbW7zBltXl9sKkOWymyiP1kVQPXL2V92hHgv5iLZSrQvNwaCyrnPN?=
 =?us-ascii?Q?NzolheTTzAEt+7dAiLeRcV/w1tJU6Q7OOa52I/VnCO/i6zyO6lQIeV4B30V/?=
 =?us-ascii?Q?sfWCYYYD+jdBZj7eINXX5OzRX+zpvjhimv8CAdhiHADoY7TBxCbrvYYfJA+l?=
 =?us-ascii?Q?9JQ1b02sBb715TmqvftoVdvx+K5yH8E6xPZ89myRG0903D1z/Cf09pius/2S?=
 =?us-ascii?Q?XFIhdGZfyMi5/gykiB3N3WdacRAm9S3QzBlgNgAPro1aIZFpa1NLb91hIboT?=
 =?us-ascii?Q?dUKIDISEvKf+L5jvHXwwRowqEuedFE3Pup59cpV3UKNgVCcGe6AQTwM7UIJY?=
 =?us-ascii?Q?44uTsg18LTeIev7gZfA0AkxRVrF4cQpPquqPbktKWPOU6zWp5fqWHJuWN2cE?=
 =?us-ascii?Q?U3EY7/G+tvDQeYvaqDtJ6qTopFqi/QPLipyZDdCYtrVWiN6q9QWm2r6ykq+p?=
 =?us-ascii?Q?aNIBHBnNgvUw+UTNEyeZTvNipKlaDkvvQDgPy7wvZ81sBsGEFtcsEoEln69Y?=
 =?us-ascii?Q?nBv98UQ6W5N/Oq1QvpVLpkLgoX6+6+xFDE4VtSW38z8f67550maZN9imCGxD?=
 =?us-ascii?Q?d+0PbGo9TeBOdq0o8p2TqfWQFGpaIZ8mypJZWfE8J1D3ACJFZmFerrZSXC2G?=
 =?us-ascii?Q?7tg35Pol9/uSTOI8qgeVz+bUrqs3RPuqnwP38UcO4+HTdUz7Rg7/kzWhmkXk?=
 =?us-ascii?Q?B7xY8gCITocZZ1qie1H+wZE0BuvyIx2k1OBc/WteIMzFRgXUMSRnFFD8STvZ?=
 =?us-ascii?Q?ylAbxKzJ59BV9AGdZtafjQNZL6qX7C+r?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 17:41:25.5421
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aded2c8f-3786-4fc3-47df-08dcbe1aa6d9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8237

On Fri, Aug 16, 2024 at 03:19:26PM +0100, Will Deacon wrote:

> [...]
> 
> > +struct arm_smmu_device *
> > +tegra241_cmdqv_acpi_dsdt_probe(struct arm_smmu_device *smmu,
> > +                            struct acpi_iort_node *node)
> > +{
> > +     struct resource *res;
> > +     int irq;
> > +
> > +     /* Keep the pointer smmu intact if !res */
> > +     res = tegra241_cmdqv_find_acpi_resource(smmu, node, &irq);
> > +     if (!res)
> > +             return smmu;
> 
> Given that this probing code will end up running on non-tegra hardware
> when CONFIG_TEGRA241_CMDQV is enabled, please can you move the common
> part into the main driver?

You mean moving the tegra241_cmdqv_acpi_dsdt_probe() into the main
driver? I think this v11 puts a function call int he header already.

Also, would you please take a look at v12 where there is a little
change cooperating Jason's remarks?
https://lore.kernel.org/linux-iommu/c342c29e51ce3a14c30bd1145a933f415a55b85f.1723754745.git.nicolinc@nvidia.com/

Thanks!
Nicolin
