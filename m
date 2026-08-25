Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010004.outbound.protection.outlook.com [52.101.56.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E767C1A2C04
	for <iommu@lists.linux.dev>; Tue, 25 Aug 2026 17:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787680750; cv=fail; b=F52Y7MlOA0AAJnOtdHiZesy9KKil3NT8haUqy59HLNussYr/7TALU+ahYCh6ZQM6+zuqaL4o7Y1lo2OOfiNjL83arlTZAsuNUgRm2kIoTP/FFOioIJFKAHuYIBhh+s2wXL3c1vNMDEB9U+Ua3fRlQWwe0Srq9vnjB75LUV81ytU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787680750; c=relaxed/simple;
	bh=QqWfVBFwtBln+PEQRkTx0ra7rdcY93gCeZN23+QNs/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=shp+iNuXiqjOJ9HAVUfxLrcYUEaX7gVF5MStl4opfxq1n7GyGyP3uqQXZ4PMgbszEWO9p/XZI/RysjdAKxxiNmwJI3Srng7amfW1I0eSkG6qdQd60R6GVlblTnbK4Waj2H9YSk1+mPdharANCKDR5QZQLYs8aAF7IN2YtEz0ZYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OV5F90qK; arc=fail smtp.client-ip=52.101.56.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OV5F90qK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X/35FaJnxrppQjHTPQP0EtnW8tyaR/PdWc9u14tWxzbnYsG+25XjPRf/RwdwiZjOXaqBq9Kn1e9i2fS6HNa43iudCoeSdUAk75qTOdvdFiSROAzR4OFXO0P7Gr36Fnw3zUzCUAKJqfhTNq7j1z2cUE3ASt2b4IvL28lb8/qBUy1NxtEyZCT8lDIcK3WXAc+bF3TYwKs/pPgDP9wdg88BOUJDnM+P50pM1clrqyjlyYgSaZ9OPjVSL8mUYFVm1CoOQCsCj8wn2KS4D3JM+pFYYFMRD1hzls5M/FTuA6bCCdqLIP+0Tf13s1XM8iPRY2N5UHkuX+7WjXyh6r2MrX9psg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QqWfVBFwtBln+PEQRkTx0ra7rdcY93gCeZN23+QNs/0=;
 b=N3Wj2iwfIIc0L0E9swbQCrHI5UZXYbXMSOOW7NBg8giArhFARxrtvH6vWn+XwAHqbEF6Fo8Qu4USYpC6omWTMoj5D0a2Ip0fNmcGBQOjV6+T32uo78fQ1p2B/EnU9GOIYSxad0L7Wx0fDA2bYfPjD3g4WLUQYpkolySgFGBjyeqUiDz3riRkssYDOJ3U30chLt7eeSX4YCH1DV4V+xtLTyuxSy2NY4uqo+QONoX4EQf7XL6Cj+9vgEGTBQikpxVm8jOufY3lS07dt1QbDPTADc48FyGD+w6b5uC/oqxXg90ybJMUZ5ga1mMngLja5eaqv7D30au7H7o2W2hohPsk1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QqWfVBFwtBln+PEQRkTx0ra7rdcY93gCeZN23+QNs/0=;
 b=OV5F90qKB0sJzAHzlfuLnmjeNPV1SNpooA4iwmO3tlfxscwV1X5MmrQmuXS4dPsnZukfZkbwQD+3Zduv5lKhRSyUfQlYmKsm9M/z+MVjD8PElbHOei13M+pP3Lu5mKFccb2mEsSD7mxACiAAsIqYMnEdfHzJmvgGiTyHYShakWw3sZCtwIljFOsyPTqAOU8jl9gQkJPsauS9kc04mQs6489b45U3XHl9WbltQW/r8lRg4Hqn2/KGwa59FgqXOzvuhx1/GPbIpT4aA4aFO/mc25wnbxPmaaEUGV6DxUHexWf0Uw/HPGSPPs6vPGZzbwKTCK4VlXwWhW6nBfhYO8QJZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB9738.namprd12.prod.outlook.com (2603:10b6:208:465::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 17:59:03 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 17:59:03 +0000
Date: Tue, 25 Aug 2026 14:59:01 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Andrew Jones <andrew.jones@oss.qualcomm.com>
Cc: linux-riscv@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
	tjeznach@rivosinc.com, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, pjw@kernel.org, palmer@dabbelt.com,
	anup@brainfault.org, tglx@kernel.org, kevin.tian@intel.com,
	fangyu.yu@linux.alibaba.com
Subject: Re: [PATCH v4 02/21] iommufd: Add iommufd_sw_map_msi()
Message-ID: <20260825175901.GE3325090@nvidia.com>
References: <20260822140625.GM244917@nvidia.com>
 <r47pwpyoc4ynv57vtwer73dwikqkev5nfy7kqyba7sqzh5pryi@teiqr5a4cw4p>
 <20260824125204.GP244917@nvidia.com>
 <fp5myre5qaersxxshitgoupbzkx2zwo3rsz3q5jfdiarmtwknh@gmfhz3cxuc33>
 <20260824170417.GR244917@nvidia.com>
 <3gdj54zcs5dncgom3zlntyredyuh2xe5ueg7nd4pdrcksmnwfl@k3fyky4h6556>
 <20260825140334.GA3325090@nvidia.com>
 <cxbneh42ui3gbkoqrsnoatxoec5exzbprfbgxcy4iekqmbceho@gouiwn5q5uzs>
 <20260825165209.GB3325090@nvidia.com>
 <iltwtfmgnmofsroo7eqrvjx6yhqbptwutywq65mgm7adudz7pq@2mdg3dhvtoud>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <iltwtfmgnmofsroo7eqrvjx6yhqbptwutywq65mgm7adudz7pq@2mdg3dhvtoud>
X-ClientProxiedBy: SJ0PR03CA0113.namprd03.prod.outlook.com
 (2603:10b6:a03:333::28) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB9738:EE_
X-MS-Office365-Filtering-Correlation-Id: 214e5cc6-3683-4830-a809-08df02d28c41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|10067099003|56012099006|18002099003|22082099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	17DMXLq5KJvRmanP1fZandsLIImCDaYvIXgpk13ca6lueNywzN8DogeDjynae1hSJNPFfdYJf18xXGzuMYk2dOQlo33oE6ZEku2uYXvDAlo2WXQJQdEHxC5QeEyQfXPR838yp+NVBdyg54XbxMomcNcCuEaiKWScxcXqROhZgBHBfBlztDh/E6XH4AEdsnOFycSpzxG0teznQPmxh7QkGPWNvFs4eSGy/53aiXywijg5NtW+x0F9ohB/UrP6sjbPUyff7+LT2pV3vjEP5rH/AjQ1jKeAveoVWTF7Ge/94M+GH/AORo1iMdgylVXv3qt6t6yz/A35f3A/6nWup9y7wapYJzqhhtUFHxvdnZsiBmR+c9swtL2uyQHmj9Yh9DBIozZIdyHbUOvmYyqeGNIja9GShZdqvJlEQY6GpW1+NIhMfI78if9o4raqFGElTCzS3mptwiTCJ9vF40iQ7kS6ld2NRTpYbICU3cUU5bIfI66s0nJH9XP3WeGMsRFQi27qY7gowseyk50+lnAvdT6dB2Fmi+B7b4TXjyTjoqa/nOB6FC7PrcGjFB3hZAQgiWU7FnmKjJBXxHtGkwbpcHHHGNllj5UUROIkp6Zuesx5zUtETwEPW4S4XHmGCSPmbcFaHjcEq3jcMuCWLbccJwgmUbw4uBMHmChgVr9PlXi5R9I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(10067099003)(56012099006)(18002099003)(22082099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+PESwdCdqhXzGWuJLsCU0i03MoJaowAqnan3LuG1N6x7L3zeMjfiQV1Dqp4b?=
 =?us-ascii?Q?XUimc4OJo4gqeBlmKtM5gOUJiBIHcE3Zi5mWMShjiS48rKkGUbqqosmsiRnv?=
 =?us-ascii?Q?p/TZ+9cI0WbaKuOI2Fojf9AH6Hix7ih1coYu9t3HSqSOCCQpD2Uyjiuvipdv?=
 =?us-ascii?Q?zSXg6MW2/FLmkMq2Zr33j45y9HQqMd9gCHeAKc7btFTIGbvOQJcpbfjtuDeL?=
 =?us-ascii?Q?I4qwU4uvWqZuPpZ9g6DgqYo6Ik5PxSBTiRDaER0nigo5baODfmlbVxndSLi2?=
 =?us-ascii?Q?aSQ5cn1DalTOXWWZSgbvcswVUEuxZqVuVIzq2Fm6VMBWXYDKyMNN/5RQqciC?=
 =?us-ascii?Q?l5eedXkPWqXEh8BEH+2V9dNeRuVKDq3MHDbc1RayLzwyohf0fZevJjQGsDE1?=
 =?us-ascii?Q?0Ol50k4hq11defTN1YWoBsUFEmkBGC5uYc2pZYADU2Dg8qdCjpBW0HctyrOA?=
 =?us-ascii?Q?jkuCr23WMqb49W2OnrDBXD1W1R1zDAtWXy8taFZDRt2epvPMS4vHvyKVl0+E?=
 =?us-ascii?Q?e1BrqzVwaJI2BpX1NGS+24SqA4CQxO51F1Let4R7kVxNGCUayk2hYMepq7dx?=
 =?us-ascii?Q?aHq8t0wHPSFB0Phhx2dj/y9Fl40y3frMz1Eng4Xx9mDZGxVRvmweD8AUmIXn?=
 =?us-ascii?Q?ZwIKBz1J4iWg6E8Ana+dVNaUQCYPY0uKNkVMHJISJ9cG9sBMts0pk3ZJsWH7?=
 =?us-ascii?Q?WBoY4j04n7HCpFes8qqfj9EBpFsa0MgRr5BlLPSHhFnH+/xJ1tIR98UUSWlO?=
 =?us-ascii?Q?jYtAsiuTmGYq2LonKraXIxQmCJjN5GuPDJTZ1d2B9eAr7vd+LsGz+zx6QuSA?=
 =?us-ascii?Q?Bj55KYwivSZ1u1MHkZcdgqOWicqlzP2VSfyGHTnEJ/9pX7foKWB+xgquukSG?=
 =?us-ascii?Q?6yoZrA5FxUi+0gAdUm3Sx2S0akNyom5fvhNCEBD8eXF6um4tRSMLUq2eWIVu?=
 =?us-ascii?Q?8polVam1dt55VnetmFkja2sljLIXwWBi1I+UXL8lG3FAtRfp76dyIj7R2fWv?=
 =?us-ascii?Q?3qTdR8Fyx+VoVX/UvAAVIzZlYinjPKAoOSjEuU2JY+/35ahd/bW698Rj+E13?=
 =?us-ascii?Q?XZrQrG+F5VwwIqMLfn9ABL82rLtoB38HHtkDilIV20cfmHf69D7shKcmnqcB?=
 =?us-ascii?Q?z3p7xRrQNpp6941Q+6C0qnsnIX0XWLDp8EWr8raT6saVEptNxbR86nHbY8NK?=
 =?us-ascii?Q?tYbCww9+6brfJ/ZGnsnDmcSIkxRHOVubMK7UMbxWuiRZy9cjfUWrX3ngVeZa?=
 =?us-ascii?Q?h4dvo/9TdwzRzxeT1coAEDaM023b6Qwfx9IR9sp4jNPbBzXyWzOU9LeoKX3g?=
 =?us-ascii?Q?xLOOjDsXh+hFjgdvru7RfVdicpuUa3VFlXSTvHRoXgHBj/PdmYR/v/dR1a7f?=
 =?us-ascii?Q?BRJS+zOM07DRMjUUqTSdy+xPcfPCyzbkhsxEDKUlySeP4UQ6CFHcR5csa7Ka?=
 =?us-ascii?Q?1mMXinKBQwBxhx42wmVmI+XXxg1CLPcbVZwwx03e3MswPBRo+ASlMZwl7wFw?=
 =?us-ascii?Q?uvZFjn481TwjPd9tAP4mj3PSp/o3Yc4Hob9kYXOmgT+topOmU6d2OFfgQd8r?=
 =?us-ascii?Q?pnhuq84BOw7WMMu0gVzrGy36qprW4QizY44s9mku0qnjnvtUefqsccOTOE93?=
 =?us-ascii?Q?U9zf1RQjr9Ipk0H3pK3JdlNFqySoI01a2Eoat4+g/wouTOYILkHzlFkyLBcL?=
 =?us-ascii?Q?s3tJQCfBpFen5P3qCIk5eOc9XSatu+9bdHwySDREY964m+fS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 214e5cc6-3683-4830-a809-08df02d28c41
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 17:59:03.0926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LOYdIFQhanhcQ6PNKNdKaF5ci0FQJLo5fDwBDex8cJXB3ZYdugRtXQSP6k5yGkDX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9738

On Tue, Aug 25, 2026 at 07:38:50PM +0200, Andrew Jones wrote:

> The IRQ domain is per-device because it is part of the device's IRQ
> hierarchy. It does not own the MSI table. It reaches the device's attached
> IOMMU domain, which owns the mappings and MSI-table state. If a device is
> behind parallel IOMMUs, the IOMMU domain implementation must program the
> same mappings into all of them, just as it does for ordinary DMA.

The iommu driver should not be deeply involved in managing interrupts,
its is wrong layering. Having the irq side present things it owns,
like the physical page to iommu_dma_prepare_msi() or an entire
remapping table, is much more reasonable, IMHO.

Even the x86 drivers with their mixed HW still put the irqdomain in
charge of the msi related datastructures inside the iommu (including
irqdomain directly editing device contexts!)

> Right, the host does not use the MSI table. Host remapping replaces the
> physical IMSIC address composed by the irqchip with an IOVA that the
> device's ordinary paging domain maps back to that address.

That's what iommu_dma_prepare_msi() is for, it shouldn't be wrapped in
an irqdomain.

Jason
