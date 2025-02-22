Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554043224
	for <iommu@lists.linux.dev>; Sat, 22 Feb 2025 15:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740238524; cv=fail; b=SJKEDEM4Np+wz8iWmFsbk/fQ1vCkXC6yvwbJ4JNIIHyqNUmi+FLdNrM2CYynx99WRbrToUbNnvm8z+pOxp+4yKXof973KWsk3MZWG7xTb9qAbBhRx+QOEVA45guyDb+oqMOchhTLpwtYSwwpHNqDILmvxTMHdXS0XEh7unkbmZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740238524; c=relaxed/simple;
	bh=jGzNoZUyekF4AKjH3kYpFL6XYH+MvlohP9o/TMjrVO8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kA7xfUFu4nGCG4/lbMLS8TA4NdyxT/g/y4XvexfmoxUhxSJbmS4TFyb+1nANzTy9JK34raQL3JBSeEGd0uSBypxJWeBG1Jgz37I8uozqVA4iqONv1Nt3Iwf40V4/PGAFCrhPl19xrcqHtQNiWzwc9fKMvJ+Og5MJ1EUl3hOUlQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PxPxDFZL; arc=fail smtp.client-ip=40.107.237.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PxPxDFZL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bl55z1v1aK2A2x2ECnKyKO+oZ8GfDCO9p5mtI8FYUugQJhvuT+PVO3b7ME2CPBor4XhG2EX1Uvx4BgcEv2g7SCPsJ8YlrfHxHrmxhqLyuhQqnxC+/4TUax5oTHXI6TxUsgOqCcoWZO6IGKr+K6oSy+N2dnX9/FF/ewrO6jpgUYcfIcCPuTZcKDbFUF4bv0CUEjGk9/q6JwPHHC2OcCRQk93yh/CgTGZeJFR7yUVdOs+bL/FGBBvJb1qZ+cpIsOyM1NdXFLBnKVhrN0VQdnwMJgHXvwg1AwXp/F+pmKL3opppOpZNUuUuE1YLCyh7quZXLP6EuIPTk5FjOs2MePnFDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VvbG7QvpcOnAW7tA7QO+qevhYXKorv2Mm5JcMfX7iPc=;
 b=oYH0X7KwmdgXpExtrF0ssaURce8TnSYPUcTWOrMhLxFtSdLaxw8p6Ki6FuYwuCHJ+Wgx+CPnv29rrQ6eefwYjNlXp1b6ATkp1LoIr++/Qzol/j5iYpYSyuJu6oGpGDh1ko+ImxpPhfjHY0kr/4M3KYNpZQuUW/eOwT+bvLxRWHc2ypH3ET+ChcY2J1Js5Pqbxkvl95iNbzy8r+k4BJ7Q/DkknjL9dl01UK9RrKbyTD2bEFgf35a1yTlvjJsnJgnv7aZNgzyOXtrQWFO7pNZOKKu0oyuJzwJSGGcPEdCdy8Pn0ZU9dgOXWIgZnrULqOZQpw4aBSrBLIeGtwft52g6VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VvbG7QvpcOnAW7tA7QO+qevhYXKorv2Mm5JcMfX7iPc=;
 b=PxPxDFZLG/8BT8Niuzg2JwHnEEgBi6eI1J7Z9ftPiOuBs4ftidpHWjnKLOEtZBTauLV9J8LSAW/bQAEkQOBdbIYscXFs8VY6xk32Wxx/QIg7tb6EXC4HWQwFi11vWG9BR2wLC1ozIlKPnx3URNYliRRMen+fkv0z4kQWF2bQrJwLPmuxgTAo5sTLTva415K44WTP8DvpgNiBhts5DjurgwbdxPqWqERojClrZwOGiB7s3ydl06aFblUi7ndpKwADSOYDNxk5zuvqz8nGwq2QksrAh39l+u6Zz3mL7odYtnuPePeH6ZZhy2jaLp5YVYb4HYYNfV9cOmpErtqy/4bxTw==
Received: from BN0PR02CA0017.namprd02.prod.outlook.com (2603:10b6:408:e4::22)
 by SN7PR12MB6713.namprd12.prod.outlook.com (2603:10b6:806:273::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.17; Sat, 22 Feb
 2025 15:35:14 +0000
Received: from BN1PEPF00005FFF.namprd05.prod.outlook.com
 (2603:10b6:408:e4:cafe::c) by BN0PR02CA0017.outlook.office365.com
 (2603:10b6:408:e4::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Sat,
 22 Feb 2025 15:35:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN1PEPF00005FFF.mail.protection.outlook.com (10.167.243.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Sat, 22 Feb 2025 15:35:13 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 22 Feb
 2025 07:35:04 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sat, 22 Feb 2025 07:35:03 -0800
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Sat, 22 Feb 2025 07:35:03 -0800
Date: Sat, 22 Feb 2025 07:35:02 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
CC: <joro@8bytes.org>, <jgg@nvidia.com>, <kevin.tian@intel.com>,
	<baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>, <robin.murphy@arm.com>,
	<will@kernel.org>
Subject: Re: [PATCH v2 4/4] iommu: Swap the order of setting
 group->pasid_array and calling attach op of iommu drivers
Message-ID: <Z7nupvgSUCZAOTeW@Asurada-Nvidia>
References: <20250221143335.49874-1-yi.l.liu@intel.com>
 <20250221143335.49874-5-yi.l.liu@intel.com>
 <Z7i3dvyA/opurciP@Asurada-Nvidia>
 <ceb475fa-dfdf-4bcb-a4ba-8128ba86a39a@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ceb475fa-dfdf-4bcb-a4ba-8128ba86a39a@intel.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFF:EE_|SN7PR12MB6713:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a82bf7b-4f35-4352-cd1d-08dd53567fe8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sek7cggonYKImbPZHtd5Xd9Of9IUhnp9Thnx7/1U2howthK2S2Mj1HHZ4x/m?=
 =?us-ascii?Q?oqox2Wuc3S6Yj3AiNtm7usV45CjFoF7VflqIXZ8Gsma184jYQVck9Zd92pat?=
 =?us-ascii?Q?vSYfKfmhC/id5SKpOHv2QS8FOyycjaTTkc5PJ/8+/RpLNMgg0llXlA9Im46z?=
 =?us-ascii?Q?08xR8/J6MYvBHaZop2EmlyEs2TdxJ8akUhmYeLCDClIbyz3MFWnCDX1FELCO?=
 =?us-ascii?Q?oi0BcE6MM1mqLaqRqJo957+qLsiJzsbtBoywea6yds1oimlOcSSDfxT9/jVZ?=
 =?us-ascii?Q?wdJA6ljQEkmZRv3ddZNO+Fm5lkMM43ioY+uStkPg4Gc2B3mZnhM9tx4M8mb7?=
 =?us-ascii?Q?Fm2KnbcG+iyR4eDGuBH9I/E2FLEkaykJ00UkuywDJNAuZOma+cSskFZHRFQO?=
 =?us-ascii?Q?nN5IyfyylLPinQY9DYm9DMzAwQUx2tJY4wuzeeFvByLKS0lI1OTb1Yqbh0dZ?=
 =?us-ascii?Q?zGlTUZzHYc+1V9gePCutAgGD7Qx8xZS5NgKv1UdWewYYM2rjYQrYhBgPuUu+?=
 =?us-ascii?Q?LCCSfnjmQkKsOxSldK7japJ8rGzwUsAriVsEzr8zbMVFdFhPeHAJvoZAT2Is?=
 =?us-ascii?Q?MM2bNWUEUs33PmupovBeLUsme2N0dVL3mG7V/TpwR6xJZvV1MXIIjsntT/g7?=
 =?us-ascii?Q?ToF+CPoUWS9Ki6zs69nlWc1M5vtbpR72zXb7YH41nlof00fiOc1Rekuq3g0c?=
 =?us-ascii?Q?HNXncgYy5xaBWfISX7ksV0OCyY/Xrud8GNTPHhEm89qCZSXlabpKJb1fdw8T?=
 =?us-ascii?Q?XOj4/LI4wMIVk3MgNShDUHbF02g0bHrfQhWqCRi1miiwEGHYEpTBse6feNtt?=
 =?us-ascii?Q?HMHy3T8jzVxKM7b8WCcMjmnZBe9OAT8nNaqUY7G8prFu26PMZUvh4UUAAwnA?=
 =?us-ascii?Q?+W9orhE8++Z1lUCEyyrH2X5A5mGA/OOo3Uv/ZzBDO6ScWSElw441YVpwDeEd?=
 =?us-ascii?Q?LbrfW9qDGTBH3ZrMJYYODSb7TQUlBZOoaDkhWe99TZLKu/P6Rxl/EntYrH4r?=
 =?us-ascii?Q?jGk2Jg1zogKLvRDf2sO0trGHkwxvfmuN5jODgOr4sz00h4L5/fr/LfrCQBNs?=
 =?us-ascii?Q?dPJC81dHKmY8ldeqvpXPUWcpFtjshQwkxzMcEpwLTo27ZABv5piWMyg4WeBz?=
 =?us-ascii?Q?QKrSzUgT5hIDkRmvx0VFNwI4fJDVeuAyp263Df5owVxMt6RCLBUPIlMsVMUe?=
 =?us-ascii?Q?mtf7ktRCU7hjueMVgkQ05Tf1FgIOCMo736/33JNqqbLWtRDHf/SMLh3i0eo2?=
 =?us-ascii?Q?xK9hCpa38OnZdQXvlfRDCuZTsNTw5grRdeJrpwCBmwI7nXWcuNccGTIEvyMP?=
 =?us-ascii?Q?Y45m5tW+n2hiq+NKAH61nHpJsAyUoaKUawmBr1oHNAlsprX2xwaQQIw5QPQi?=
 =?us-ascii?Q?s7EizA0sVsz17SVMZm/rTvCbcUs7sAjv152UZvRtOJSaZ9G64a1wh7OM8hyn?=
 =?us-ascii?Q?tQp1jgbWX8LzuVQV/UjelrEwSkNJMaNAKPqFFItU6cvinUN3YNUCTDOXxlf7?=
 =?us-ascii?Q?4IM5LAxXH+Gd5EQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2025 15:35:13.2703
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a82bf7b-4f35-4352-cd1d-08dd53567fe8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6713

On Sat, Feb 22, 2025 at 09:59:05AM +0800, Yi Liu wrote:
> On 2025/2/22 01:27, Nicolin Chen wrote:
> > On Fri, Feb 21, 2025 at 06:33:35AM -0800, Yi Liu wrote:
> > > The current implementation stores entry to the group->pasid_array before
> > > the underlying iommu driver has successfully set the new domain. This can
> > > lead to issues where PRIs are received on the new domain before the attach
> > > operation is completed.
> > > 
> > > This patch swaps the order of operations to ensure that the domain is set
> > > in the underlying iommu driver before updating the group->pasid_array.
> > > 
> > > Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> > > Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> > > Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> > 
> > Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

> > > @@ -3388,13 +3388,25 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
> > >   	entry = iommu_make_pasid_array_entry(domain, handle);
> > > -	ret = xa_insert(&group->pasid_array, pasid, entry, GFP_KERNEL);
> > > +	ret = xa_insert(&group->pasid_array, pasid, XA_ZERO_ENTRY, GFP_KERNEL);
> > 
> > Maybe xa_reserve() pairing xa_release()? Same thing though..
> 
> there is slight difference. xa_reserve() will return 0 if there is already
> a valid entry. xa_insert() shall fail with EBUSY. We want to catch such
> failures here. You may notice that the replace function uses xa_reserve()
> as it intend to replace existing entry.

I see. There is an xa_zero_to_null down in the xa_reserve path.
So, they are different. And there's no need to change anything.

Thanks
Nic
