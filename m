Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD3F4C79
	for <iommu@lists.linux.dev>; Fri, 11 Jul 2025 19:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752262782; cv=fail; b=XlEQRMGyokGBoz6NUkrNv3wZEVeKI11WPinHKpzzK9OwRcUlud0xhfCY7S/g4kes7xoi7uQ4I9vL1RJ+HnypHHWu71r57vdwPj/SZUfyKS9V4vEHKw+sQ2v3Ri6htAQhBQgBeeimY4ItMFXu8Y6gqQh+rFC4WmjL/by2PTyHr58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752262782; c=relaxed/simple;
	bh=rBlwmVmEsL8EEPq7H4PsBdvBBWT8UVARHuUZBNI93gU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h8/pYeKANz4vLmYvvKC4KeHq0G5luBV7fmmEEjfb8Tl1iw6xp4vgjnBBa3eNFY+IxKUv35eBaBPXQeXHjhdETqcsP/G/pPHehwax+gjUqBXUc6bXKzxN4XWdmkmqXKgUSxvKtlUJ+wmCrF0xc2+C4RT7ny5mFnCc4Ct4E7WyGZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=T+XjaPpP; arc=fail smtp.client-ip=40.107.220.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="T+XjaPpP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aLbzmLrUXAmOMk/UzaBv76g5fF+2SjFOh1JaoBjrT4heEHIqiA5yFo2CIdJVKiDU/NmnpCsjkIka4zjYaqdtdtd917UlVMFCp1CjAPMnPPXqahUvhHzyek9arFxLt3iMSbPW/BabNbV25ON0B0QfXvFGUBjPFAN/3G16BiuId86dIbjMr8VuhocH7Eg8C4G8UUF7gLB1JeXOrskZvzml6DHP/+c4PxXhTnVzq/Z8HhFDyewAXtjxfeb1eCYw5cGjQsY5Cm9Mgj0E2XQIl6OTbwHMr+cqb/x5R0OWh2xigqH4acYAU71YNVNET8Dguc/c1rBPjgeMnwC3Ii55cQD5aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fqmgAdW5ZvLuLVBAo+zL9aknurCdw/WMSZweiDz7Dtk=;
 b=xUhvrBawCMh2vh6R7w6dDYvQZMrNHn8PHwIKT4lG6sOxQiKwTM+EKSYyOmEFovqXvBaEbkzKzfPjp9aAoTGosaCSMCjXDyEsaBCPR5YVUioHlNpAbzr5Nn/97CMwX73F+s9qAmDRjGxJjxAlXL1Dp79JzZo1nWG9QNMrlufopxniSQhx+5ttvfTA8BnHcVxbWmSn9A9hLaKIu1sCnoTxX2QgyG2H4oKohdm4RVCDjopmhU8TA3sTtvwlXdzJDJTjWou3F+2hViQaNt4yZtAc/aUfs+r91jGzVtPpfwzfhqiaIGS5myKQghoL/83HvXXjPKyHqGE1DRKMf35WVRH+ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fqmgAdW5ZvLuLVBAo+zL9aknurCdw/WMSZweiDz7Dtk=;
 b=T+XjaPpPPMPnDJo10tH4vkMyxwmZRbf64ptlen78N4Ck/OCcKJUBFUNhHWxGM/ecneM3LvIVCz3ixix7qlpkAf1tpwI9caknQB7JXlF1CZ1kIZo4SCdILpMJyGLbk54gx9bi398ApLctlUaVTCKCAT41RY3rPA9LCRvQgMTUf7hhFkOznZC4kAQGKRtg8r+rajiIomHCGVomriib5kpDwxyhBeddEw6P6uujl36wn8OREQTuyxYLwzl5Zt239xHAT7dLGn5I1nygf1VCgKpwkFCqkLYKJpuwaQ+JK1E0RsH7N6VOkOV7b+VBFNC4VU89z0nSzcAdei6wqL4m2iGf8A==
Received: from MN0PR05CA0014.namprd05.prod.outlook.com (2603:10b6:208:52c::25)
 by IA0PR12MB8206.namprd12.prod.outlook.com (2603:10b6:208:403::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.23; Fri, 11 Jul
 2025 19:39:38 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:208:52c:cafe::aa) by MN0PR05CA0014.outlook.office365.com
 (2603:10b6:208:52c::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.8 via Frontend Transport; Fri,
 11 Jul 2025 19:39:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Fri, 11 Jul 2025 19:39:37 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 11 Jul
 2025 12:39:31 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 11 Jul 2025 12:39:31 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Fri, 11 Jul 2025 12:39:30 -0700
Date: Fri, 11 Jul 2025 12:39:28 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
CC: <jgg@nvidia.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<will@kernel.org>, <aneesh.kumar@kernel.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <joro@8bytes.org>, <robin.murphy@arm.com>,
	<shuah@kernel.org>, <aik@amd.com>, <dan.j.williams@intel.com>,
	<baolu.lu@linux.intel.com>, <yilun.xu@intel.com>
Subject: Re: [PATCH v4 2/7] iommufd: Add iommufd_object_tombstone_user()
 helper
Message-ID: <aHFocHh3kB0/wJ7H@Asurada-Nvidia>
References: <20250709040234.1773573-1-yilun.xu@linux.intel.com>
 <20250709040234.1773573-3-yilun.xu@linux.intel.com>
 <aHAPqdZKfdeEMDs2@Asurada-Nvidia>
 <aHEnnesvLL5te5rf@yilunxu-OptiPlex-7050>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aHEnnesvLL5te5rf@yilunxu-OptiPlex-7050>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|IA0PR12MB8206:EE_
X-MS-Office365-Filtering-Correlation-Id: e979dba6-87a4-4eed-9b36-08ddc0b2ac22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5g9a2N0ob9PzM1jKsRfNfxw6zS2XY8fG6gNUrxQd7ER/44AEMXgScrZxo1eC?=
 =?us-ascii?Q?AsIf7i1zaBRLndql1ahZ7mVT9q3TMe8viN65aom3p+Z+5OBsUncQd5/EHOB5?=
 =?us-ascii?Q?hGfi0y+id28bu0H8frsVJCnU2P2772hE4OEiz1PUd8rwLCeuzaud/2N7SvSx?=
 =?us-ascii?Q?f9l7dmq2g2vuoz1WtY7VA3+XThay6k8jm0txU0wvdGdfxHPIX1zqtdlVmOwi?=
 =?us-ascii?Q?nPUJlh7aSDWeMJNaO8DRgp66N5LU6IX0JOEZJPWkPzrn44tIMI4pp6ooolAb?=
 =?us-ascii?Q?kp7YTgsAMQlxb1sAInApyAsufNvuZQxHRD9+PjLc06qUB/R4p3j1Z3jAgBjh?=
 =?us-ascii?Q?KlLi/8DNC4S6YGBRUJ9dJsqX/KTLoldls+jAfgxQ4Di2qJBupgfFOAVcB1dB?=
 =?us-ascii?Q?WXJHXbHzi+HgzDvpIwxCCoYCM79lKxD9aH9YSLcErqvkAm4zmrXaamA+DZ4m?=
 =?us-ascii?Q?QKDxzuXcDhSVdSVarkouRbjJxhI8daXHKwsuG5cnGv1Nr5Mgyp1M6K7o/LVK?=
 =?us-ascii?Q?CdHm8/vIAmx7fU9Frntpw8/DGbtUEAqU9RFY7w9WAbNQV2E2m8GAPWKepdzc?=
 =?us-ascii?Q?aciOWWUVNGll/cg4wMtKR92E1AjN3V9VP8iYkUx4zdGiGTThHc7bpxhc1TKd?=
 =?us-ascii?Q?VuCL7XOp4skxx+A55avBOe948zjDPtfMu4qYNgRR0c9KH/813dbK7uV6ERy/?=
 =?us-ascii?Q?Gi9URMMfh/lQcG1SMb+A2PK9BL5Tk39EdTop3b35OMJX07hTYSuUXtR09A48?=
 =?us-ascii?Q?RIxyTpYmj4hb0P3fOtLh53d6ujR7n1onwKz8njLU6U+kYcZXGGY6tKbr5139?=
 =?us-ascii?Q?jnNj8l/drcRfZpobTt5umSS9t/SMS6iSnGTSv8Gg1tg9XY+TYosJgNFiWsPl?=
 =?us-ascii?Q?YbcFvownjhDm+Iw9F5yYjQcNErftVy/ix/wPuXOelxyo+YCxrd0gIErWi5FW?=
 =?us-ascii?Q?LePWkVguiwAffmL9LzP9kLJ5JXT+vPtkGFS2XBuPvNqe/jZBR0Y2ZBXRdmuN?=
 =?us-ascii?Q?gDO2jr9VDkvdUnKS0vfbf2/W1GZMJlnlm5x2JG7R6kIxwHd5SSU56nns/VDM?=
 =?us-ascii?Q?/LhVSpOprSogqORfgxOtK9d7FDLUc69cWcKcQj+D0sL0686tKW8cV316tv8+?=
 =?us-ascii?Q?WmgT+FxTRwR+i5SbpuT/TwUsOEowgA9zHCRSBHK4fxwIE1tGWSyxTeodnl9f?=
 =?us-ascii?Q?Ya0qLZzjydlyAkKKFyOANQ+uM3H5DD64syrIrOLvIu1PohA4WKYx5Hjkoco7?=
 =?us-ascii?Q?v5zOA1FYfDyhXJmLl+OKIDoD9WwMxr+/s5pakFM6/PdTsiheDgegUppnDdO7?=
 =?us-ascii?Q?xqwUBqo4mryG2e9LI8BfIz3drP7/GIbdgKq5Vs8RGbxnaLosGg6fZ33OTs7s?=
 =?us-ascii?Q?Sg4HC1YULR4ty3CUY7msS9+QcuR2h6eW4QNBlLY0vdEHEfQPIVb7Ki4H2okg?=
 =?us-ascii?Q?iohPN4hgL6HyhxufuKvj8uaIfxVKG5B3axc412LxIchOFcyKPSt8SzWDIaKF?=
 =?us-ascii?Q?tsA1MSClFwx7Tztr3mfFVkK7fo3S+KYibAfc?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 19:39:37.9426
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e979dba6-87a4-4eed-9b36-08ddc0b2ac22
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8206

On Fri, Jul 11, 2025 at 11:02:53PM +0800, Xu Yilun wrote:
> > With one nit:
> > 
> > > -	while (!xa_empty(&ictx->objects)) {
> > > +	for (;;) {
> > >  		unsigned int destroyed = 0;
> > >  		unsigned long index;
> > > +		bool empty = true;
> > >  
> > > +		/*
> > > +		 * xa_for_each() will not return tomestones (zeroed entries),
> > > +		 * which prevent the xarray being empty. So use an empty flags
> > 
> > Since the first "empty" and the second "empty" are different things,
> > 
> > > +		 * instead of xa_empty() to indicate all entries are either
> > > +		 * NULLed or tomestoned.
> > > +		 */
> > 
> > let's write something like this (correcting typos too):
> > 
> > 		/*
> > 		 * We can't use xa_empty(), as a tombstone (NULLed entry) would
>                                                             ^
> > 		 * prevent it returning true, unlike xa_for_each() ignoring the
> > 		 * NULLed entries. So use an empty flag instead of xa_empty() to
>                    ^
> s/NULLed/zeroed, are they?

They are. Just nicer to pick one for consistency.

Typo was "tomestones", any way..

Thanks
Nicolin
