Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010000.outbound.protection.outlook.com [52.101.46.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51FD227BA4
	for <iommu@lists.linux.dev>; Thu,  2 Oct 2025 19:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759431917; cv=fail; b=gPP81nos75+YKCAKcpMSkuEJ7mVh+TewI2xwFFrVbayxgmWEJeynGgL9yHF8Yly7EWV5i1u73z8uSjQvn8TIN4vTnDWAxAyncro6iItyCkLRTNSTVrKHMqWOvKSuv2FS/jVFUpz2QrkPJkeCQI1yWQ4XBlANOPhZtGBUXjDUQTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759431917; c=relaxed/simple;
	bh=fLJbu5AyX51LBEJYk4c6uKy1C5H672XVMOl+kwvs2os=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JrELbIapMdUBDO+7KPPgWrlcJS01mK2GQHj643PEUeoUKLasp52Zh9Hh6s82wvC/ocl6oO9x7KTQ56uM2Yl0JZsFvjEqNS2TrbLpDNH2MwSAusq3dDBHH9rXUJrhYdu4ZZ9woRPU5lA1LVjnPhoUM+6AgAITtM1AbDr4qZjBCS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CWhEKy+c; arc=fail smtp.client-ip=52.101.46.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CWhEKy+c"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cLAQL+jLZ15jVQTugjD5g5iesFv+vIlw8B8XG7e/x3RsvtS+2kB0zj8JgEGqQudMwAdoQKxZ/lbmjkIyJMDyUMAdIQu8DBx2ePFv0/BYJhoTjre8V1a6hi/2opZ2d/3CJ4gNVTkUxM1gm1CfCSoap7SoPnAPjh41aeMXCB5ZIbttPZ9dk543AoHh+pdmxbTEk9xcYr31xo9Qd9TuU1AW92b3bp20r/J+dZ4HQojY1cczL2gX3zHl7IC2ZSsY9sUKLF1Q5BJvk8ONr9dMfo20FqZDgZ/bKf9gxq160gR2GFJY5ml9WGKhwV8CT6bz//QeGfwTww8vbOYHKSud1/ye3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1R8wx9nUGSAF0jGAv0YZcffBs0x/8nvaqxi5Bzv1wHM=;
 b=hfYiodVrE5DMUm7ufSrs9claPsOfULnNF/xBtyrmG2iVNLsb5yeRmZrWEufX3oHBYAw4ESvRhC5xPUvlUR09O9FNwrFZvoxFsLyjDpfKU8IpqV8hBDRSpV5ashr0lWBeLaf6KJaNsKgEJyacM+iWWCMMzSexyzDedorytO1th3503AQD+RbqrBbAwPllquhbzlZYCogtIDgvMg5TOLG6BIJvttOUl6gDZwgWC8pkuwWVoda/nUWRTqof+VMwl4U5oDhqDcWMNmZr3S6Iv1qKSrktuwpA3ByW0CHGzZWRaFDI2bhWyqF+9YgFhL8FuK+E1JQw7scntx9A3GN0N3zsaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1R8wx9nUGSAF0jGAv0YZcffBs0x/8nvaqxi5Bzv1wHM=;
 b=CWhEKy+cm4WCUaDhwrjhRbQAo3Q9CmoegofP8RlaWpfsg7kCZi+yzd3mi08vQPkfMlGxmG79/tdfGEGdnCEaA+PfBgrZeQ6gAXB3daBqRKFSuqUkcbT/jgL7Vm2I8w/KJV8QHbY1jzTgjXY4uh7cexU3AmDLR2WnbWQzJvw/4VQHTic5+rA0x8iesFuV/qjcBGPEO+o8QEkxawoxkZgF5wHT+UFd6Eh2vz7ALcq7zKDCZcOKHbkakNrWZoKPkIjJuQ7ExILHv5PCW0jmRvPuU6QyhTISk5Zq0Uq2704Nl/zL6yxy/M2II9TLDrtl9v4973YJuXDHZ5sSoRjwGkkOxg==
Received: from BLAPR03CA0121.namprd03.prod.outlook.com (2603:10b6:208:32e::6)
 by SA1PR12MB7343.namprd12.prod.outlook.com (2603:10b6:806:2b5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Thu, 2 Oct
 2025 19:05:07 +0000
Received: from BL6PEPF00020E61.namprd04.prod.outlook.com
 (2603:10b6:208:32e:cafe::59) by BLAPR03CA0121.outlook.office365.com
 (2603:10b6:208:32e::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.15 via Frontend Transport; Thu,
 2 Oct 2025 19:05:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL6PEPF00020E61.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Thu, 2 Oct 2025 19:05:07 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 2 Oct
 2025 12:04:56 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 2 Oct 2025 12:04:55 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 2 Oct 2025 12:04:54 -0700
Date: Thu, 2 Oct 2025 12:04:53 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
CC: <jgg@nvidia.com>, <linux-kernel@vger.kernel.org>, <robin.murphy@arm.com>,
	<will@kernel.org>, <joro@8bytes.org>, <kevin.tian@intel.com>,
	<jsnitsel@redhat.com>, <vasant.hegde@amd.com>, <iommu@lists.linux.dev>,
	<santosh.shukla@amd.com>, <sairaj.arunkodilkar@amd.com>, <jon.grimm@amd.com>,
	<prashanthpra@google.com>, <wvw@google.com>, <wnliu@google.com>,
	<gptran@google.com>, <kpsingh@google.com>, <joao.m.martins@oracle.com>,
	<alejandro.j.jimenez@oracle.com>
Subject: Re: [PATCH v2 11/12] iommu/amd: Add support for nested domain
 attach/detach
Message-ID: <aN7M1QfaXG3YA7Xz@Asurada-Nvidia>
References: <20251001060954.5030-1-suravee.suthikulpanit@amd.com>
 <20251001060954.5030-12-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251001060954.5030-12-suravee.suthikulpanit@amd.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E61:EE_|SA1PR12MB7343:EE_
X-MS-Office365-Filtering-Correlation-Id: b9988f26-094e-453b-38d8-08de01e69a45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TSeso/5kMBFJ2QUTKCS6bTlwki05BGhGrhkbdyjjiKrM0uF7oE8Reqz6VlIs?=
 =?us-ascii?Q?ATSnyggKsTdxEiW15y4iaePkSfVuFKPNjFyMl9ZEXIOVlWryo7vh5LWTZ2I2?=
 =?us-ascii?Q?KgzzZUH4I0vJUPnNCDEOHI0qJlJa3GSLbdmh0m3G7MSDkBPIY2CCThjVetAF?=
 =?us-ascii?Q?8huKR3FGCJe1jsUGzHyx470aB27C5FrhjFhrzJsN5tk99qFUAo70lDikQoKq?=
 =?us-ascii?Q?Qw6sTu+PiuO9IqUWSVHXyyP0ubH2psM/EcipJjD8Y2G8enBrAJstDcqpOaNe?=
 =?us-ascii?Q?wdVuVCOsAM9ctdYV5UFdYirSNFN0jUX1I7LY7WDx+pkf4/EK3p5TAjeE7s/4?=
 =?us-ascii?Q?RZCVuh9Ql3lOa9BoIEAy0gYSZNOrrV7UClPWYHNLqRHLOfsXp6VzZXXpRaAC?=
 =?us-ascii?Q?Yfj0RTsaC3ivB5GbGzMucBQD3fym5sP47iZ9IonCBLKrgc0LGxcUyFTHg747?=
 =?us-ascii?Q?h4ypQlGfRLNOKT1C6AzQxMI9dIhEj1qeuRkz4Pl5GH3C1MJdhskO/p0Bemye?=
 =?us-ascii?Q?3Ys0QZVP8gSMgEBwW7cDnqMOph9kvpRQn0Mwp6gSGtzA6ADlueApgWj9JRSN?=
 =?us-ascii?Q?oQL3qlid820SmJ3Kx+aLUjMgZL3c6VRPuJ9nfMf8T3xaLOSeTkR9kECbn3bi?=
 =?us-ascii?Q?h+S+sRCMBj57oxc4LQOIFNHZQX32/K6quThFqzLCw2ZPdvAyKU229kmDIIGU?=
 =?us-ascii?Q?h3+35yea5MUlmFENkqy923Fe3SDHnbVmkEjxu4Xw+g5xVHqaQS5YTDHbeZBv?=
 =?us-ascii?Q?DwmqSFDrGlrxW3PzsB6mrtNzF4qFnadBStE/9dGN0qWKoq/DsMwFV37xvmjL?=
 =?us-ascii?Q?Z7TiRPf9UpT/SCP4kC1oDHQjh+l1TKu3URR2exEcuNZP2feIzC4FVv4Xu1eT?=
 =?us-ascii?Q?dSWqERmKn5aoVqKDlL9vj8jeENp6M3u7A9KyL8ZTNpeNH5R4CIvw/EoTBGRw?=
 =?us-ascii?Q?niAHKs3QDfMHrC1DPY8guRUfEcrOtLN2k+OCqOU/XNQSCgVyRoV3lDIbXv6w?=
 =?us-ascii?Q?elp+9HA3YzE5UwwNolQhYhFy6+HdSA1/BM92x6mWQBbtZJ/ZvjLZEQXGSW40?=
 =?us-ascii?Q?HA1XeykGKxdMHTWxRJn0+6u1LxP58tZG2st8cTZP/xsOsjDG0EAbqd99aHk1?=
 =?us-ascii?Q?ZcuGmOinCdVgieX5dvdcRXrmvwwn4BDUhMuQCO1FbJ4sXRsvRBGoN7p+KAZN?=
 =?us-ascii?Q?XqoKZtkqX/zh0Wyu9YX4IWqfeB9pbhpYdzsIFQDjVEsgF5eiGNK1gtZq6ilB?=
 =?us-ascii?Q?O/zE5zvI/Y9wVt9pYzpGU0qBmFa9+86AJTNV2i6y/mmoO1cSB9XPU/Gi1wk7?=
 =?us-ascii?Q?kgPombUbNemPLEgqVq793onCS025kOggsAK41UnP/pLJFfMvz+lrk5bGx3yA?=
 =?us-ascii?Q?dzsbkDwFTx3GAkqAbY3p2EI4miMHx0f9ZT32XL1E9RET5gisT54vjR+bUYLy?=
 =?us-ascii?Q?jb98qcwGu64rpnURYs7WtBgd9p8LBV2ePBazjK3tK2Gys4JeRXhxhiFFIBih?=
 =?us-ascii?Q?Vp9AJewAIzwJ6vju+Ir77Jt6OY3xnzjqMIAx9xic2fjJO44Kj5p4NYpvinA8?=
 =?us-ascii?Q?fE6/Om96X3Bxrk+yzto=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 19:05:07.4232
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9988f26-094e-453b-38d8-08de01e69a45
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7343

On Wed, Oct 01, 2025 at 06:09:53AM +0000, Suravee Suthikulpanit wrote:
>  /* sets a specific bit in the device table entry. */
> diff --git a/drivers/iommu/amd/nested.c b/drivers/iommu/amd/nested.c
> index 11a0237174bb..5a0c369ba283 100644
> --- a/drivers/iommu/amd/nested.c
> +++ b/drivers/iommu/amd/nested.c
> @@ -11,9 +11,7 @@
>  #include "amd_iommu.h"
>  #include "amd_iommu_types.h"
>  
> -static const struct iommu_domain_ops nested_domain_ops = {
> -	.free = amd_iommu_domain_free,
> -};

Oh no, amd_iommu_domain_free() with to_pdomain() won't work. So
you should move the nested_domain_free() to the previous patch,
pairing with amd_iommu_alloc_domain_nested().

> +static void set_dte_nested(struct amd_iommu *iommu,
> +			   struct dev_table_entry *gdte,
> +			   struct nested_domain *ndom,
> +			   struct iommu_dev_data *dev_data)
> +{
> +	struct dev_table_entry *initial_dte;
> +	struct dev_table_entry new = {0};
> +	struct protection_domain *pdom = dev_data->parent;
> +
> +	if (WARN_ON(!ndom || !pdom || (pdom->iop.mode == PAGE_MODE_NONE)))
> +		return;
> +
> +	amd_iommu_make_clear_dte(dev_data, &new);
> +
> +	new.data[0] |= iommu_virt_to_phys(pdom->iop.root);
> +	new.data[0] |= FIELD_PREP(DTE_MODE_MASK, pdom->iop.mode);
> +	new.data[0] |= DTE_FLAG_IR | DTE_FLAG_IW | DTE_FLAG_TV;
> +	new.data[0] |= (DTE_FLAG_PPR & gdte->data[0]);

	new.data[0] |= DTE_FLAG_PPR & gdte->data[0];

> +	/* Guest translation stuff */
> +	new.data[0] |= (gdte->data[0] & (DTE_GLX | DTE_FLAG_GV | DTE_FLAG_GIOV));

	new.data[0] |= gdte->data[0] & (DTE_GLX | DTE_FLAG_GV | DTE_FLAG_GIOV);
> +
> +	/* GCR3 table */
> +	new.data[0] |= (gdte->data[0] & DTE_GCR3_14_12);
> +	new.data[1] |= (gdte->data[1] & (DTE_GCR3_30_15 | DTE_GCR3_51_31));
> +
> +	/* Guest paging mode */
> +	new.data[2] |= (gdte->data[2] & DTE_GPT_LEVEL_MASK);

All these outer parentheses are redundant.

> +static int nested_attach_device(struct iommu_domain *dom, struct device *dev)
> +{
> +	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
> +	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
> +	struct nested_domain *ndom = to_ndomain(dom);
> +	struct dev_table_entry *gdte = &ndom->guest_dte;
> +	int ret = 0;
> +
> +	if (dev_data->ndom == ndom)
> +		return ret;
> +
> +	if (!dev_is_pci(dev))
> +		return -EINVAL;
> +
> +	/* Currently only support GCR3TRPMode with nested translation */
> +	if (!check_feature2(FEATURE_GCR3TRPMODE))
> +		return -EOPNOTSUPP;

The amd_iommu_alloc_domain_nested() should probably validate this
feature, so !FEATURE_GCR3TRPMODE wouldn't allocate a nested domain
at the first place, and then no need to revalidate it in attach().

> +
> +	/* We need to check host capability before setting the mode */
> +	if ((FIELD_GET(DTE_GPT_LEVEL_MASK, gdte->data[2]) == GUEST_PGTABLE_5_LEVEL) &&
> +	    (amd_iommu_gpt_level < PAGE_MODE_5_LEVEL))
> +		return -EOPNOTSUPP;

Ditto.

The attach callback function should only check things related to
the compatibility between a device and a domain, while this is a
domain specific validation. Better do it in alloc() IMHO.

> +	WARN_ON(dev_data->ndom);

	return -EBUSY;
?

With these fixed,

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
