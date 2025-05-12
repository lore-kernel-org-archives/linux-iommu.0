Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9C224BC04
	for <iommu@lists.linux.dev>; Mon, 12 May 2025 05:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747029064; cv=fail; b=oOE3xgxCgXxjz4f+bAcdzxLKD113YZH3Mk75ExfKBh4DkI0yeUyuaPfN/rfAsLg7Ik2oa0PJpVAkGwjTulfv2MLBrbKph3QEAIqkXyPhFdQKpaXdleRGE8F3D39o8/C/JohMRvhAg+xCxWM9dDzdcjk5xLZ+QgkeRsFORIWZiY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747029064; c=relaxed/simple;
	bh=8T09CvYWtp15rl4v/FKXnFb/i+ASNQZ9Ekp7VmCmu+s=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fYj9LM1MG1JhdrORaGX3d+OHKZIJUm5o+pNk1hdXBYJqZLTfogUb8oZBHyEVoqCUy/Vlx0pJV4X9078bkzP9WbiDERurhv540pDzvAcEz88kDvTGG7AsjaIj5XVzwFrEe8Nrp9NBP64EIqkoCDP/DDiBpWNHr+PWJgRV7gXO8Es=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fYKzvAqg; arc=fail smtp.client-ip=40.107.92.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fYKzvAqg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KNQrpZk6NApYFKs0LOeWWv/hguMxVDHfP8mKVQ8DyjKGAJBeO3oA2fvYNHabLfFJ3vS+217TIsynGhYyI4rxbNrjHxsGQIAjp46Jys6yA3t01+2Q2fFSvAYLHQGe6blzs3jLcoHZFZvj6fFx+7AoiLHzOG5OW5Msh1EQsCHxhECapLS7jPCSnp2Io3QALdNJl3qg7/BcEi0WLxlFWdZCD5I8nbbtpxyf39VSTnxF4xnVNJzXBep86bd8y8Uo2OHK79QJaiSxl1uRJghzYi4OgqWNS2HT2LwOs12uuiPjOidg039Q3UYyhfSg+bSy+jIusBgL75gVdHG5S9db5xEmhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ih53cRkyEAeXIN56G1S4Jb8IPuvsCZXMIjbQ+hXC064=;
 b=M03kYtUctfSRjl7ccAml5V6xV+yNMCcKdmOeGPmXzO7+5fJ7nDu8rzfOjoMAO7bdUHIK03u4nriSpzAoFDX2fvX4PUOkz901QBgppIGrHCMN9WBJMANH72xVVRWlyCn+A+7j7zhH8OhXN+1D8iOyC/MJ3xZmFfSytpUfD8f0Hjo2i7rUm5SSiOxZFpfmvm56uQ6bYYLjtHd4bCQs/MEzrJ+0LF1DFcVLphl+RlO/oKfb/PCi8x3rfTsNfrWSlvJ/e2gKn2gAx7mqJyO9U78I5yeD+dTXZoMr2zAA3omh/ot6ZvLT3wj+fo4S/vEb7BvBJthHHFyhk3c4Zv0weM+c4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oracle.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ih53cRkyEAeXIN56G1S4Jb8IPuvsCZXMIjbQ+hXC064=;
 b=fYKzvAqgwsYViMK+GN1jBbskepMmMILc/H7La65dBFaYbPxSpbMdjFHqWZMCZvbXYRotm/eTT4H7z3oYcxIpOpzZrjdAyCNQX4SXKt8C0x68ewxXtbc3CbLoVyhBQOTu6kDC3YnHd2CEj8eoEqoX/LQHnHPm/3GDlLYkCuP60Q0=
Received: from BN9PR03CA0571.namprd03.prod.outlook.com (2603:10b6:408:10d::6)
 by MN0PR12MB5978.namprd12.prod.outlook.com (2603:10b6:208:37d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.24; Mon, 12 May
 2025 05:50:59 +0000
Received: from BN3PEPF0000B370.namprd21.prod.outlook.com
 (2603:10b6:408:10d:cafe::b3) by BN9PR03CA0571.outlook.office365.com
 (2603:10b6:408:10d::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.32 via Frontend Transport; Mon,
 12 May 2025 05:50:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN3PEPF0000B370.mail.protection.outlook.com (10.167.243.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.1 via Frontend Transport; Mon, 12 May 2025 05:50:59 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 12 May
 2025 00:50:59 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 12 May
 2025 00:50:58 -0500
Received: from amd.com (10.180.168.240) by SATLEXMB03.amd.com (10.181.40.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 12 May 2025 00:50:55 -0500
Date: Mon, 12 May 2025 05:50:43 +0000
From: Ankit Soni <Ankit.Soni@amd.com>
To: Joao Martins <joao.m.martins@oracle.com>
CC: <iommu@lists.linux.dev>, <suravee.suthikulpanit@amd.com>,
	<vasant.hegde@amd.com>, <joro@8bytes.org>, <will@kernel.org>,
	<robin.murphy@arm.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] iommu/amd: Add HATDis feature support
Message-ID: <hpvc46sa3t72tj32yz2mrcwzmp6ikg4npbulx5uhv7tj62uqni@ghloowl3sg3z>
References: <cover.1746613368.git.Ankit.Soni@amd.com>
 <a03c8eb9e998445eba8b18a40c53469eeef18a9a.1746613368.git.Ankit.Soni@amd.com>
 <6c9dfc01-89db-433e-9b7d-41dfb13038cb@oracle.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6c9dfc01-89db-433e-9b7d-41dfb13038cb@oracle.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B370:EE_|MN0PR12MB5978:EE_
X-MS-Office365-Filtering-Correlation-Id: 45822553-eb34-4f79-4848-08dd9118f8ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ay1dEr+yw/n/QRlEe9QYJHzz8MuhMT1r3tMPlgJI5Xa7h/bev7FP8JRAsfyl?=
 =?us-ascii?Q?vwRdniqHlgGmQyHv9+gBiwfIl8bQWYysbY8HgG9F2Dgyt3XF3jjJ3UAZbxtC?=
 =?us-ascii?Q?y13nszAXyjycSNLwPA2Slvs7uhK0hRkMx6RE0fC3N3lrBssx9PIaA92hgI/H?=
 =?us-ascii?Q?3w/5Vl/tJupUxm0oAaRIK+CPmWyRzsNzXiY17ORyphzAbzxKY2YDrK1VWnK3?=
 =?us-ascii?Q?/ly799LpGnB0VDd/8xJTxnfSqpD/iwtdb1gFxz7ghVRnOjyvcSnaQ+0hA597?=
 =?us-ascii?Q?x7vnV0kd1jQhIS+WARm6pF9ir38KY/hDEjWM2lCYEcF0eJndZM1FENjyL0+u?=
 =?us-ascii?Q?hPQ/a5cgrE1s80y1CN0aF0zoNmkWuaSooEH9chylSbMZFTjcVTL9zqw+tTak?=
 =?us-ascii?Q?Pybk1J6IC5n7rigGGg0tYZSJ8W302qs3fEi0BuAkpYCL6KIuSq7CHfvEhgNH?=
 =?us-ascii?Q?YFCRiDZaumJ6lW61UMJ11a6wMHkgp7YHwT2dGs59Ijk87mIBZkJAdA6N1vwJ?=
 =?us-ascii?Q?8anEo9gdMMFJSNHo6sqi3d7vJnTnLZVpwIMwNpCPzg2DKbn/enG49jHVVAPy?=
 =?us-ascii?Q?METNUqOsgWyLXCRAA1Q2OHKea7qUDn6NUQEtGphbZ2eQ+I506VdYcgN+AT50?=
 =?us-ascii?Q?XGmPLrqr1zVou3zhIC4lSOpgUkb6Fs3bNZhUinsRI1a746X2BQRSL1rPtMm2?=
 =?us-ascii?Q?XCMNXMxQgtLz3LypgyS0stm4ou6wGvI20aZ2NAnWf6bXwFB79xD30TZumZks?=
 =?us-ascii?Q?bo8vX/vswyyPuSFshcFiGPuXyKQ6x2sqJv1gvMiUwwIh9pUaw5GJ92p6T9O9?=
 =?us-ascii?Q?saftOLBbIR76Jk9Dnnpx+z96DYjswuwRgzuBJLE3OZR2tTRPGq71ZEwqVcGD?=
 =?us-ascii?Q?kQUq88ppE2HW97SBQJNGOyKMPM376aoPnoPSHXNDu+1yqC4DLnvWyJGwRdWP?=
 =?us-ascii?Q?LC/mOQfOuoi+2BQ7HPbBzuNudGnEFE/hotugKb5e7I2e4wV1OUyi/IngesUs?=
 =?us-ascii?Q?hV8Bt5Rt//iQ6l4Gcj+046mkjRp1Le5NIP4RlSZIno8gwWvKcXWGVWCi/7bo?=
 =?us-ascii?Q?dRR29Sg4kvJAtXuXZAiDiJvON/zVDimdlGmbRTRXTkEjDWFThxebSZdGN+pQ?=
 =?us-ascii?Q?1nP5bPokFk+UrBGLtNBiwBEsOkUmqgkP/D+0bjA5DdOzcXBbutb1neKMzrMv?=
 =?us-ascii?Q?V5el+VCYWEsUy5MZwADv2gCxNDlK9R+T+0ecz+wXP2VHMlCl2OHel6IpfyJ4?=
 =?us-ascii?Q?al4cEMTxFjgmR77hVkUEfBOpII/waR+orpW3cjo63c/d8f3ya2E/bdtpLcjm?=
 =?us-ascii?Q?t8vnnBFmglx/4yB07BwFlUfEkzrwu/bHD3eng3PFE6gMz9DGMR09Pgojpxzt?=
 =?us-ascii?Q?VVj6LKiYNHrQxQZX07Fq9dGJJ74unzyP5zvqIS3MCrJOipoGDBFOsSKYfWe3?=
 =?us-ascii?Q?0sao2XA/cRlsqTudOguS50EpKqoCldMWunjo73vcS30jJF8S4Ewxms+apr57?=
 =?us-ascii?Q?4jWCL3sQFM12m1+MCjjluoDFUVo9MCFGlTnn?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 05:50:59.3335
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45822553-eb34-4f79-4848-08dd9118f8ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5978

Hi Joao,

On Thu, May 08, 2025 at 06:04:12PM +0100, Joao Martins wrote:
> >  
> >  		break;
> > @@ -2582,7 +2590,7 @@ static void init_device_table_dma(struct amd_iommu_pci_seg *pci_seg)
> >  	u32 devid;
> >  	struct dev_table_entry *dev_table = pci_seg->dev_table;
> >  
> > -	if (dev_table == NULL)
> > +	if (!dev_table || amd_iommu_pgtable == PD_MODE_NONE)
> >  		return;
> >  
> 
> My suggestion in the past in the past has been to do:
> 
> if (!amd_iommu_hatdis || amd_iommu_pgtable != PD_MODE_NONE) {
> 	ret = iommu_device_sysfs_add(...)
> 	if (ret)
> 		return ret;
> }
> 
> if (!amd_iommu_hatdis || amd_iommu_pgtable != PD_MODE_NONE)
> 	iommu_device_register(&iommu->iommu, &amd_iommu_ops, NULL);
> 
> Also as a to simplify the attach/probe path i.e. remove the chunks in
> amd_iommu_probe_device/init_device_table_dma.
> 
> Or is it that the generation of an ILLEGAL_DEVICE_TABLE_ENTRY event means we
> still need to be careful here?
> 

Correction in my last statement, with above check in iommu_device_register(),
machine is not booting and INVALID_DEVICE_REQUEST is generated continuously.
so iommu_device_register() needs to be called.

> > diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> > index f34209b08b4c..4e9a57377b8c 100644
> > --- a/drivers/iommu/amd/iommu.c
> > +++ b/drivers/iommu/amd/iommu.c
> > @@ -2393,6 +2393,13 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
> >  					     pci_max_pasids(to_pci_dev(dev)));
> >  	}
> >  
> > +	if (amd_iommu_pgtable == PD_MODE_NONE) {
> > +		pr_warn_once("%s: DMA translation not supported by iommu.\n",
> > +			     __func__);
> > +		iommu_dev = ERR_PTR(-ENODEV);
> > +		goto out_err;
> > +	}
> > +
> 
> Strange place to put it after all the initialization has been done. Shouldn't it
> be at the top of the function?
> 

In amd_iommu_probe_device() driver is setting ir domain with 
amd_iommu_set_pci_msi_domain(), hence i had chosen this place for return.

> >  out_err:
> >  
> >  	iommu_completion_wait(iommu);
> > @@ -2480,6 +2487,9 @@ static int pdom_setup_pgtable(struct protection_domain *domain,
> >  	case PD_MODE_V2:
> >  		fmt = AMD_IOMMU_V2;
> >  		break;
> > +	case PD_MODE_NONE:
> > +		WARN_ON_ONCE(1);
> > +		return -EPERM;
> >  	}
> >  
> >  	domain->iop.pgtbl.cfg.amd.nid = dev_to_node(dev);> @@ -2501,6 +2511,9 @@
> static inline u64 dma_max_address(enum protection_domain_mode pgtable)
> >  
> >  static bool amd_iommu_hd_support(struct amd_iommu *iommu)
> >  {
> > +	if (amd_iommu_hatdis)
> > +		return false;
> > +
> >  	return iommu && (iommu->features & FEATURE_HDSUP);
> >  }
> >  
> 
> If there's no IOMMU group, how can we allocate a paging domain with dirty
> support for host/v1 pgtable? I don't think you need this part?

This check is for when amd_iommu_hatdis is set and driver has set v2 page table,
then driver driver need to take care about dirty support.
