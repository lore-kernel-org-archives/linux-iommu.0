Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4966D2641F7
	for <iommu@lists.linux.dev>; Mon, 24 Mar 2025 17:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742835928; cv=fail; b=sgzYOrOTQDdFLEd3fkxacgDlXUxD12iGqwvjxp06646b3J32QGpJmwGefyORAV1PfMSCssgyBzK7+GoxKegB1InX2KOrPPCTi+zevKdOC3Sta6OfZXLGRMuNFmlPlj8jcupmnKh28TmFOl1xaZTkPOP67cb2CyaN078XI2HamEI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742835928; c=relaxed/simple;
	bh=K9vJQGR8bT1c9m0tGwgiEOoxu7CLLNKDuDkaWCMLnWo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pABuP+M6uHYCaKvJ2JRR+9HShgxUoIAXIq/D0fq/lvcFrbzbtOBCdlzblAt0EHpua0IErzAe8onsmP6V4ycYGB1ReF+t2hCwnrlXHHbVYhzGpgMQ0H9Pvd1IvVyyqhG21x4h3lc3ZZM+dvm/fkIXePIpC/7i2ZTy0rCS82RJrk4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tGU9pVLL; arc=fail smtp.client-ip=40.107.244.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tGU9pVLL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UKFYd3BQesplI3Q7EuKKaW4lWpcsYb8wbB9Ykiif1LPfwx3mxmHiavXelqinIoJcn758IpDyD0Q5W2QkqmyYTcOTPkDbND477RYS5jOmZbEw7KtjEF/SKSWQuLsxneCSvqd4JRb2bc/AYutTXmrrba4PFXyY0BJQ6PxTjfkIEVXyYneGdSRPfo9xs+noPFocQSbrOcssNjZEIdf/IM1eq0nXu5LqV58ZF9DH8WBJ7YO3GAokfm9iK+d7DyG7cljmLYJhJ7CCKDsVfae7NusO5whz8N8gTe13drHQpdnUDPtIgiyEiE3Lxikh3zeAOzWMtAgyIV4ajY28HG/Sc/Rfqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gwu2HX1kbe040I2+lLxd9xZoywXmvH7zDXEeXXoKCAU=;
 b=yjx427fYe1mJ6eqezrXCvNXjd+PvpEp7K0BCzr6ttaDimh4YbATzC3+k4qGqwEFi27LY/FKPIByr7W223gfDm8e2fT/P8yr4u/0wJfRh8KttkX9cCcUZGP/UwLY7OYn/bh7y4NbYu8feSYNiKfIYq+saEk4pR9sKH/qe+os8z/yA1e9Ql7pLXnEIPQOYctTqNm1ZKWiKfHDq6nR2eUe4XpUg/ERaqFn0Ie6I+8FsQUmKJWm1FBDRXSw9TGYAWTxqV1SnRtjLkjqwKskL2Arx2KiQUr/gZ594tivGcpnaM4H6eVO/Z/huEApdUp89sDfEH7OVffNAJwv7ZyWgnDft1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gwu2HX1kbe040I2+lLxd9xZoywXmvH7zDXEeXXoKCAU=;
 b=tGU9pVLLwJti8yWpaAU9vSzNGcpZ8tIMIaZxFRH1XY0ZvuFVgeGvV2ashX894STQCXpIn9djrDeeZMvUSIQ7HG06ktNRiO/zFenfsfc/mvIfDSUbhA4PLCNP9+RAI8Pq8Hga3En3dm+TPDJJbjNkOs5DCFpqQp4alvrnnrfB4EC5K1sHT6OT1jXfrNlf0Hqf9gTcvWtap1yPyrWs32Fl/iyLiBAD6ivBtEH4LHKmxdT2EpWl9uQWk86Kzy3RwbhR9JkbIbZZy41C0xddivnU9FP4eT2WcGYsk17Oaonb7KoFbWBz13+65GAsYv+B6my22xk0CP11D1YbqSynvLA3Jw==
Received: from DS7PR05CA0097.namprd05.prod.outlook.com (2603:10b6:8:56::26) by
 SJ2PR12MB8807.namprd12.prod.outlook.com (2603:10b6:a03:4d0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 17:05:24 +0000
Received: from DS3PEPF0000C37C.namprd04.prod.outlook.com
 (2603:10b6:8:56:cafe::a1) by DS7PR05CA0097.outlook.office365.com
 (2603:10b6:8:56::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Mon,
 24 Mar 2025 17:05:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF0000C37C.mail.protection.outlook.com (10.167.23.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Mon, 24 Mar 2025 17:05:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 24 Mar
 2025 10:05:09 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 24 Mar
 2025 10:05:09 -0700
Received: from nvidia.com (10.127.8.11) by mail.nvidia.com (10.129.68.10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 24 Mar 2025 10:05:08 -0700
Date: Mon, 24 Mar 2025 10:05:07 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Nathan Chancellor <nathan@kernel.org>, <kevin.tian@intel.com>,
	<robin.murphy@arm.com>, <joro@8bytes.org>, <will@kernel.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 3/3] iommu: Drop sw_msi from iommu_domain
Message-ID: <Z+GQw2A5nzoxfiHc@nvidia.com>
References: <cover.1741294235.git.nicolinc@nvidia.com>
 <6d4b493d20926c8d14e29bc776639cdcf2095146.1741294235.git.nicolinc@nvidia.com>
 <20250324162558.GA198799@ax162>
 <Z+GK98/VSvYl518j@nvidia.com>
 <Z+GOkl21ZLtE3B/e@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Z+GOkl21ZLtE3B/e@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37C:EE_|SJ2PR12MB8807:EE_
X-MS-Office365-Filtering-Correlation-Id: 69681d69-f454-4448-234b-08dd6af61144
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VFdiFToLvOjqpbbcRi0qbqMXQ9sXu9PTeubkNZdjt5GgRaqehT9zCW3MaGZ7?=
 =?us-ascii?Q?ZmODDro2U5oK3FZ1HArG1no8VTYCMYKhv5BEp/zR1y9mehBmQGCFmOT5y4CX?=
 =?us-ascii?Q?nYHNnRgLpJJl/TUI1crtczuZYcW+2yAWj/Vs+Dh2KTAaYmZBiTYVKPMQCBzr?=
 =?us-ascii?Q?NOkLyJhEt3JMw8YNvZbAflgmLwhuuxcDCrvsYo6NMN0bxo1K/vTUXFqXTw0Z?=
 =?us-ascii?Q?dULO8oQ88XR6r7EvW9AfXDNLs3a/BNxB0t1FhRJqEuszNyC1UxWZe0En0B1J?=
 =?us-ascii?Q?FLfkF2T8itEqoOxC02yXpyHjm91elVldV54hr6gnDFhDT4CP520xzb6dS5XV?=
 =?us-ascii?Q?SlCROPvu3Ia8BvJ75y2+Ow2On8aKBFRri0Doha1hJHIZUck0DKQGTflxfZlU?=
 =?us-ascii?Q?q8288MRWNU83jZ3uqHKuQyG53ZsYwXH/t6djVhkEyuG3B2UUe71WIm9+TkSK?=
 =?us-ascii?Q?69qA2BE1HaeJJgm9JT7f9Dqcy7i1LNoEo+GRTeSQ94uIqJimhza9d1W3YI2l?=
 =?us-ascii?Q?A3KG17ePqJACSwoFp42FrXpxBu6Fy8HAVaIES7S6hNvLgU+KBpLqkzJdeY+l?=
 =?us-ascii?Q?PQ9J+oaG3lQ6xxPWLndRl5tXixoIAovZa3DfVOOL0g+ykqKVuD+X5MrpJVyO?=
 =?us-ascii?Q?b0HIMnNubK9V4bnVMm+Jf7oAMzGFtm5ev8xK236idPOFVIUB59uPWnbDdkv4?=
 =?us-ascii?Q?HoHkUlHKQRi/g9+y/GvYLrncmR6NUEiuMdSCoirpU/O+IFywg6ygy1wa9WTI?=
 =?us-ascii?Q?eUnSsNbXw93xRIPs+3dHdwVEBCSaSc45gw0393Y5z2Edzh/qS+Ej7GbXTnJB?=
 =?us-ascii?Q?kjssIr02RYKlpzFpTW3DOCqshswmhi9DYcTTxAG7FY6HsmDgmsGCypWL56ew?=
 =?us-ascii?Q?SWKig6+f5pDPK0M8f2Ac/IlpTgkWyY9DRAVB9CmXAL1DAukqLBFP2wW8J4uj?=
 =?us-ascii?Q?mXef0N672kWl0lQKD2weqpaaRydWnL11oFbBUK7XVCAqHFQX7GdzOYFoKQ05?=
 =?us-ascii?Q?t28uv2AluUICoRikbOlTYtZm0ZHFOHV3kBte9DWJg3tIycaP/X1PBUgqNzMI?=
 =?us-ascii?Q?4NzZQFLk7thMwKKx79/QEUybAm661ckk6zuhfMx+4PJgZVYbeGpXYAT6/dFP?=
 =?us-ascii?Q?Bb+YO0AMzB1azw8/SAsILpalyp1DxuSW+VDgDR5LZglpUEw+1Ot9yueyXMIB?=
 =?us-ascii?Q?Sz5GEJDaarc1MbYbeZ2eyqAlxX7NFsu2Z8Mc8taHGrkyaj7w4HKkkibsPl8z?=
 =?us-ascii?Q?XhU01mzNdBvHjsbWYoTD3BopcGAssDIw9HH1kR9hH5HWp1Uh55JzTEeUnMWX?=
 =?us-ascii?Q?MOFMmc6r0qSPhU+BLOn2I2NvlZB5+D9eQ//PiizS59YXyL4OdFIf+UUe0pW/?=
 =?us-ascii?Q?RO6BDFXAa3F3SR9etsJ5dddejOAXZK8PxufpOf3DBe2u34g1fwpKn8Ky3ZTj?=
 =?us-ascii?Q?FrPiqYXe+YdenWL8mYw4ld+h4p214oHrfzbXYdUfBqTk+DOZywh0nZ0NuFGq?=
 =?us-ascii?Q?84YEykb+CPO+cI0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 17:05:23.9249
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69681d69-f454-4448-234b-08dd6af61144
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8807

On Mon, Mar 24, 2025 at 09:55:48AM -0700, Nicolin Chen wrote:
> On Mon, Mar 24, 2025 at 01:40:23PM -0300, Jason Gunthorpe wrote:
> > On Mon, Mar 24, 2025 at 09:25:58AM -0700, Nathan Chancellor wrote:
> > 
> > > I bisected a loss of networking on one of my machines to this change as
> > > commit e009e088d88e ("iommu: Drop sw_msi from iommu_domain") in -next.
> > 
> > Okay wow, I will drop this series from the tree if I don't see a
> > resolution in a few days. We can try again next cycle, thank you for
> > testing and bisect!
> > 
> > > At this change, I see:
> > > 
> > >   [  +0.000000] Linux version 6.14.0-rc2-00033-ge009e088d88e (nathan@ax162) (aarch64-linux-gcc (GCC) 14.2.0, GNU ld (GNU Binutils) 2.42) #1 SMP PREEMPT_DYNAMIC Mon Mar 24 08:57:49 MST 2025
> > >   ...
> > >   [  +0.002355] fsl_mc_bus NXP0008:00: Adding to iommu group 0
> > >   [  +0.000533] fsl_mc_bus NXP0008:00: MC firmware version: 10.28.1
> > >   [  +0.002565] fsl_mc_dprc dprc.1: DMA mask not set
> > >   [  +0.019255] fsl_mc_dprc dprc.1: Adding to iommu group 1
> > >   [  +0.046820] fsl_mc_dprc dprc.1: Failed to allocate IRQs
> > 
> > I guess it is tripping up going through iommu_dma_prepare_msi()
> > somehow?
> > 
> > Maybe fsl bus is special and doesn't manage to set
> > IOMMU_COOKIE_DMA_IOVA for some reason?
> > 
> > I wonder if this is not right:
> > 
> > +               default:
> > +                       ret = -EOPNOTSUPP;
> > +                       break;
> > 
> > And it should be just break instead (return 0) which is what was
> > happening before?
> 
> Yea, I found the diff here too.

Or it should return 0 just for "case IOMMU_COOKIE_NONE" doing a
passthrough for !CONFIG_IRQ_MSI_IOMMU configuration.

Thanks
Nicolin
