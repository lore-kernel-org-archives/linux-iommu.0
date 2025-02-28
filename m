Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2042.outbound.protection.outlook.com [40.107.100.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2674F1F09BF
	for <iommu@lists.linux.dev>; Fri, 28 Feb 2025 18:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740766270; cv=fail; b=LL9VLrSvTbXlRuDT2hUjiw0LTPgO2qh4amoDcDLgaQsoSzA8CxLe+s6Q8Xa2mmXbDrEOs+LYI54MeEiz6t+Qh/enzgvEbVQSSTGQ3MWDKUZ/MiIRUYpLHCDabUnFJRKxY3/NKuOKJ/TitiM+WTWKjg351glM2GiTm0sg3JY8BqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740766270; c=relaxed/simple;
	bh=oKn+mz+T//gRheIulcRhpQiqqMv193ut3CSLZIGyjy0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ivt7yyLKbsJ5aO0zFmdOXa2dQ5LNntKs18Iz0OSnPHtgi3LEmvDPCvuHnJ4w1EXdDg2Hv70D9aCcfEo/B1pjP5cXgV++rVRt1V5Ohhm55gln9zIoHnel3vo9L0yB8Wlbj1vnhUs/QXHPAbDR9ULcBNVt8PjBhyrW1DEgEXmRwTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fFdVy6LP; arc=fail smtp.client-ip=40.107.100.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fFdVy6LP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tTUYYqoPxKauzQ7zMT+P874l59RtG2ypNKyIolaTV6iA+KHY5C4/YqkZZ7JtbrLopZuJp1mVqI2EJAsUTSsAS5eBG/Zc8bW8a3e6m4xCZRfGliHl350ZRf/+6AWrG4qpLsD3TksUdi+kLqmJv0efKEiY9u6Fd9knm9QYl/WdlXAgkRhm9i2PjPyJ3RHr5n25Dr7wvrnD/MOWKzJ9G0zuktmu25Mz51nUaAUh1Ps5yOKu8dhatQR0gH8f0EucpC5HMdFOjv+rO+OPZ1qpkq6GS3Lme0NGOUFXbZwxc4LYixKSUHykh7jZZwbZYO7Dgv0s/QjwrnqsBE6LosvrpGTQdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wN6FbwONKODgJuGDeixQSnXondekSykquzuRmBat3TM=;
 b=P23aVsWl9OS72V1/jLXkeUPCOlITqsxJUUXatu6QsmbbcGVX81pSxSB/RwsX+jA4+DeQVUOId1iNHQxhgK/dchQwofqymp5KWhfIklVlTJU5xkNx95wN4dpsNx7rYaHRgoZVnBNKomS2rLudl5DJwElc+61Dv68KtkHXDluEOZqCNIwlwThZLKkcWyYLV2e6bpta7S77VDRrfFaprNd1tXOHQ5XL4/jTDEpEHm23IH7VpkazpEElpmuIS7aI13PR7kmRordCBSR85PmJtbkATh6uG/PrDruhQZW58pkm+CKhNbNgi/cfX9uG67QOrQGklt3q+h6rUfUxZyMMld0iYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wN6FbwONKODgJuGDeixQSnXondekSykquzuRmBat3TM=;
 b=fFdVy6LPkx/as6HZI34XirKVatVyM28s32bfnXD9CkJbNpWjEfIvL+VJ6wo/6v8ZLbcBKrMe9+IIh1pQK9XfjzREsWd5JSW5kwgll+4sU+CuKWsVLPo+yXvgLGB569WBbMwKf3GWi+8fQbBr8HZ223bh7ldhpmTMcc7IcgSc+SWQctemTo1NZh3gfRH1+Uy6TgkWasnLhvzwAoo9s2BUNrwFI46SirpSAWSwR4NrbC3q7nk+bPFgGU5JohRkOdnXmbS8mtIbO1oUZOo7/iyxQb7BMTTCHn8XTiqQRP+EpcwJRCmreFLXt8vUU7tAO7f3GjGCMNCTWlG0LHtstzC8EA==
Received: from MW4P222CA0012.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::17)
 by BL3PR12MB6521.namprd12.prod.outlook.com (2603:10b6:208:3bd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.23; Fri, 28 Feb
 2025 18:11:05 +0000
Received: from SJ1PEPF00001CDC.namprd05.prod.outlook.com
 (2603:10b6:303:114:cafe::e5) by MW4P222CA0012.outlook.office365.com
 (2603:10b6:303:114::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.22 via Frontend Transport; Fri,
 28 Feb 2025 18:11:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00001CDC.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Fri, 28 Feb 2025 18:11:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 28 Feb
 2025 10:10:45 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 28 Feb
 2025 10:10:45 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Fri, 28 Feb 2025 10:10:45 -0800
Date: Fri, 28 Feb 2025 10:10:43 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<will@kernel.org>, <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] iommufd: Move iommufd_sw_msi and related
 functions to driver.c
Message-ID: <Z8H8I5UTiLfGNESS@Asurada-Nvidia>
References: <cover.1740705776.git.nicolinc@nvidia.com>
 <ece6ab9a0144eaabc285eb21a09da683d6d9951c.1740705776.git.nicolinc@nvidia.com>
 <20250228173212.GC39591@nvidia.com>
 <Z8H4VL+OUfi2+5eA@Asurada-Nvidia>
 <20250228180215.GE39591@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250228180215.GE39591@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDC:EE_|BL3PR12MB6521:EE_
X-MS-Office365-Filtering-Correlation-Id: 6987a4f0-5c30-461b-a735-08dd582343f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?B8dI/XfoKmUh++LCIqLa05UboQojzzWfhANxHPigGNA7MuyAvwgsJY90sBrK?=
 =?us-ascii?Q?QTESbImiNX3LfaCIf8T0C5KVjMxf8KHMG2iNAEtF85LOwLGGIY2rUTxowTsq?=
 =?us-ascii?Q?6l3S7S6FHL6RV7bv1+uE8AOBhUyMmOfq3pgWgZrkBQwQOA260iOxSB/D08H+?=
 =?us-ascii?Q?cSV/BHTxGFSXPW8bJ9AoCbP6D4f9Kmq7zY7BQySbR/ABN1r2ftDJG5T9ibrG?=
 =?us-ascii?Q?pPWDpFBEznQWXD5kSuNH7PoeZkz+qOP3DyAnfLWGIoX6FxkLIK6J/0w11+j5?=
 =?us-ascii?Q?MGVpd4cuSD2cQHNW2D7D0GsUH6LTL4Efo9/d/EA1QaVPGptZO+X1NAAk/TbE?=
 =?us-ascii?Q?EgTeLgw93I/JXQJwZSEqjh0OWu/SRfbbNTB3D06sVIeHxegfxG+jKq4wqK+r?=
 =?us-ascii?Q?na1gt5hl/YT3l6+oQiQXrwvKBk7Voyt5+N6VKRPzn6rSO29TaZ1h03mgHrE8?=
 =?us-ascii?Q?rGNZBJpHYIUOHzkg3eKYrxemmy56nEMzknAE7tkJvjigZn251NbrSa+6dmSs?=
 =?us-ascii?Q?n43u26Tu8iSjwhqJ2eOezMXVburXODsAlrZc1iGjQrL4hClgTjKpSicyg4Pf?=
 =?us-ascii?Q?zD9Cqsuk5+bM5cRtFLjlpQM+U+U0iYpRBTB5Vq7+N5GM2tp8K9oJ2p8tLP/4?=
 =?us-ascii?Q?2AA20IMvAxhe0P31o24nD6Voack3UIwbPZg2sRMglYOWm+lBDMYHlIF8/90D?=
 =?us-ascii?Q?lNNx8oHJjsjTr2bc0JFh5zWyMmJh2McGDBK1kg7o9JiWEUJDQaO/DP9zsr0W?=
 =?us-ascii?Q?MiduopjZG9b+E+XjLEmiqsBSq4Cv4BPbjAg9Nn8t5aWVoAV8O+ofGNf88iBr?=
 =?us-ascii?Q?lQze4JnbNCJ/2+KmxvVjvIdLWyZxBjOeEBAC0wGUxWFGYpEjo2yUXHCiDigA?=
 =?us-ascii?Q?jSMe3OvqV0O7Uq46HPQNAVZt1kQsi/AdcaYD+OJ6GfmFFRyW7Ep3ZD0uGBxc?=
 =?us-ascii?Q?pHKVybjcHNA09/3qKP6iTmEy05d/QM24xsHo9Wez5t0F7MZjJENMsbmFIc0A?=
 =?us-ascii?Q?9yiVPRAvoMziOEL9e6omPbvc7Dl6EIWuDY7J/tJffB0rEaEW5ljPETaQ6wnP?=
 =?us-ascii?Q?9wTFP/7CU2DTctMWMcx3VgNzVVR2q9diiB5F+UH7CEPI1w67bLZLhV4xfT4g?=
 =?us-ascii?Q?BJTh8DJFJ2fdCN4TduFkNBIqROApvxG/hkAfdQepXeqLZDNU7si9cOti+ZCr?=
 =?us-ascii?Q?YTaZfc5te2Z1NjQsHTdeKv4NcbLYCXR/3tsqgTrpnQ/P1gE1W6hSV/pQNkd3?=
 =?us-ascii?Q?39o3Hm3mltIP+WhLgICTVt5fmbvbdr1lrT0rvgGJneUzgAzDGayBL7JSXPSU?=
 =?us-ascii?Q?h4hJzHVVLHQUfJdzR8kG4hFMaTDaCR8GM0rgRHFOAYwYXZmj153zQTjMCnYu?=
 =?us-ascii?Q?MyHliLfTCEYFjvYJazF+WCo4TBYHDBF32qbbUHNx6et5ROzPgeklQfJ0bphG?=
 =?us-ascii?Q?ps/NEEGIruXRorsoX2D0Bxu8E5gs0nX5VIuq19+qoxkyH1caCA0BsUMeI2xs?=
 =?us-ascii?Q?171LT9tGNM1yZJE=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 18:11:04.2122
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6987a4f0-5c30-461b-a735-08dd582343f4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6521

On Fri, Feb 28, 2025 at 02:02:15PM -0400, Jason Gunthorpe wrote:
> On Fri, Feb 28, 2025 at 09:54:28AM -0800, Nicolin Chen wrote:
> > > Stubbed out too if CONFIG_IRQ_MSI_IOMMU ?
> > 
> > In that case, the other caller iommufd_group_setup_msi() could be
> > {
> > #if IS_ENABLED(CONFIG_IRQ_MSI_IOMMU)
> > 	....
> > 	iommufd_sw_msi_install();
> > 	...
> > #endif
> > 	return 0;
> > }
> > ?
> 
> Or a empty static inline
>  
> > > I'm still wondering if we should use a function pointer, how big was
> > > this compiled anyhow?
> > 
> > Hmm, you mean the size of driver.o? It's 192K (before) vs 212K
> > (after).
> 
> Yes, but use the 'size' command to measure before/after

Before:
   text	   data	    bss	    dec	    hex	filename
    722	     44	      0	    766	    2fe	drivers/iommu/iommufd/driver.o
After:
   text	   data	    bss	    dec	    hex	filename
   1888	    100	      0	   1988	    7c4	drivers/iommu/iommufd/driver.o

Thanks
Nicolin
