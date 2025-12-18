Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012044.outbound.protection.outlook.com [52.101.53.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B2125A2DD
	for <iommu@lists.linux.dev>; Thu, 18 Dec 2025 18:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766084276; cv=fail; b=PMjNlG9zWw+MzP4hG3HKppLDLH0PZwZblo92BUrsc3jaeNgiiKVj7G+wI6bbMtMzF0qt8NscDUNJYIY3ThjDGQdxnQGzPRRlnPjkguYri4BZTa8gfFpfq+FVT0srXU8U/rwyHhrpsYtAtQZ8OrUeTabTCddXxTj9xAPD0JPmS4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766084276; c=relaxed/simple;
	bh=Lj+cAgMS+Heuu4/agAXMOGuMuweuppLxYCaIY8bz/Qw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jKQBaC++mQcLtVuwsiYDf9WiXwBaEw1mg1YttDNWzOYsj6l8UJFUKe3RZ8OTWU55VfV7ca2ZLWD8ZnAv986Lhn7RFaLr7+bTjXTcg+gKeDQtHdoSr6O3haQ0wKbUwW8jtClszPNwkXtaH8MQcOGneKo0DXIbrN/3qofAiWl6Uxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Jl0ej5Gi reason="signature verification failed"; arc=fail smtp.client-ip=52.101.53.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Jl0ej5Gi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RMhMY4gE5fEE1/hnabxeqfAFXkxm1zjfoYyxGn/Qtydibyj1SgWllgzsaq5+3Uk8H/EfMym5+e0LH0cgH5Juhgl7N4+GwqG0LV15RdvEUu8wI/J6bCfBIAqKzLB1H3iAr2TvcvO3yYi1w/ocozcYlNvrrNM1C5/KMZrChpIClZd7W5EuMJTniM2yD/gOj9KRz6fxzhOUeQiDeWUlteiv6+HReTbTkzahtHEKtl6QQlu7QgNGVirBFnYiV+RqPA+6r1wQx9XLxS3HZ2EPNICz9c804GGndYuDzkgzebidoteUeahUPdqVPvQtC9UtO+/X1wn2ZZVa/pOYaTcLyFAYmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0a2OU7VST/fh/UzhYLY7S97uKhKimFQrMkwq3OMYwzo=;
 b=mleFbxNjW/EekN29wP49g8yhcsGec1wI5xbKpENJIXjI2kEANdYIKSKm/ok2ayk7N59O8DMnWwDCrKt2KCS4cFfZd6a3yT7RriutYcqb+JVBN2j56OTslRdr+BFl3z6J1r/Jk4HbvGLOq+Ogo3H2bogBcI/8BZVo+LKn0KvN0G8Zry1R/4oEtykf0p65Aa7CxjGy1aPW4sYmHf/gShiWwg6WZSce3Benk2UXbvt2TdUQNRSmeXf1GMHfoiNeLx0UCcZY46LW6ulBdLK6ofi/ygkOKR1699aASGd8QKTOzbFdKeUZT13Aiw8CV+TEQ+c96HKtwg5zIE+4BM1bmVhL5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0a2OU7VST/fh/UzhYLY7S97uKhKimFQrMkwq3OMYwzo=;
 b=Jl0ej5Gi5NIWrYt7XFJbJFwGqv7iP7tf1YVFZH449tPIyg25WGavNPWOmwGRIEoNbfqz2tMGcILWp8uSetPIlDh8G+tD2nYkRcdEwfxoEYVushMAhFQzUFl2rAeWibtzQlYPISQtJsxXXoYGhbnUhtRMa8cHY+tYCGWaWTe+Q2Uya2WZ7sVF+lIUffBXh1AH3fD4WdDje6qK0+Gi0iTG8DzUept5EPJA8P6TcAYHYhSusDeixsVtbMhNrctX0T/x3azntCYQKPgy9et+xEDk2EdQ7Ikrgz1Gg9y6RcK9nuRFg6RLZbhi+E8oEv9za7wdZb+JQs3y86JHXCPN1e3BBQ==
Received: from BL1P221CA0004.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::15)
 by SJ2PR12MB9164.namprd12.prod.outlook.com (2603:10b6:a03:556::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.8; Thu, 18 Dec
 2025 18:57:45 +0000
Received: from BL02EPF0001A100.namprd03.prod.outlook.com
 (2603:10b6:208:2c5:cafe::92) by BL1P221CA0004.outlook.office365.com
 (2603:10b6:208:2c5::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.7 via Frontend Transport; Thu,
 18 Dec 2025 18:57:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A100.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Thu, 18 Dec 2025 18:57:44 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 18 Dec
 2025 10:57:26 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 18 Dec
 2025 10:57:25 -0800
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 18 Dec 2025 10:57:24 -0800
Date: Thu, 18 Dec 2025 10:57:23 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jon Hunter <jonathanh@nvidia.com>
CC: Ashish Mhetre <amhetre@nvidia.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <joro@8bytes.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <thierry.reding@gmail.com>,
	<vdumpa@nvidia.com>, <jgg@ziepe.ca>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH V7 2/4] iommu/arm-smmu-v3: Add device-tree support for
 CMDQV driver
Message-ID: <aUROk0jRQoLmBRo3@Asurada-Nvidia>
References: <20251215064819.3345361-1-amhetre@nvidia.com>
 <20251215064819.3345361-3-amhetre@nvidia.com>
 <23df682e-6d08-4827-994e-1bbd89e5c903@nvidia.com>
 <5e9a0ce1-a0ba-4a31-be95-99f349ec6028@nvidia.com>
 <e7d3e95f-a885-4b13-ab4d-bc82793c5396@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e7d3e95f-a885-4b13-ab4d-bc82793c5396@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A100:EE_|SJ2PR12MB9164:EE_
X-MS-Office365-Filtering-Correlation-Id: 898ce602-c41e-4e35-4029-08de3e675463
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?9SIf1z0ctrHOUUEE+VMIn4KqXl1DA7bbEtWx83S/QC+0REiExjchzXAxck?=
 =?iso-8859-1?Q?qz8xwokEpg+mxpww64P+U2y9CNs//pdFT7v4X3fMeznFkm1TVmKlYoty5J?=
 =?iso-8859-1?Q?25zscQ499RedQgHBRWdH1OQ+xYuG8p8+GOkVp57fRdiiL1vnY6en7sjpu+?=
 =?iso-8859-1?Q?hT9B3MRdi62JmYMqD+51h2xdt7q4zt4zn9O6mn1K8VL2tJLdEBcpInQxaa?=
 =?iso-8859-1?Q?WoL/UkicAsdW9Q0smR5zQk1F2B/Po8QO7MDnn6uo50OS49bNdV9Ps6E0yr?=
 =?iso-8859-1?Q?zizJaF5q27WfCGBBdYWubDkT5h19fR6/CG/Ll4c3qJylLhxNGc6HDYRAys?=
 =?iso-8859-1?Q?iUh19PJqIOFybwwTesP3seoq350ZBRlZ71smAq6x88jZeKuaAXHUmijWI1?=
 =?iso-8859-1?Q?1hmFDujjbi+hpoGe1JWFGNATecNOuWK7c+q5UtaIt/i/qfsjv+x7kmMq7K?=
 =?iso-8859-1?Q?swXgRXYUXWlTgCfHhnJkuA+tTuAt9pJkkR+D5Zxq95Tvy+8lrLWKpXmHpp?=
 =?iso-8859-1?Q?vwQaNQVVl345sGvlhqLBl260zKFlSROoVBzgGiC/PnuPbb+5MJBoSrYHr9?=
 =?iso-8859-1?Q?8HYBODHfvFXT6Vk6VEItA5lplICE8hBk1C+H6hDj197o0XbgA0cGvtGCOb?=
 =?iso-8859-1?Q?KubbkGmPJ2ezbl65h7ZOqhC8v6U9TFiEsUfeKkRNvl21fgZVORmIuKGrfo?=
 =?iso-8859-1?Q?fSksYxCWJjOq1TexF2q0ntcnKglzYhT0brGDdhHS6Od9iAEWb78fmMOhek?=
 =?iso-8859-1?Q?Cdp0Vafg0Kig+H8uob8pccMjnyvI+5HiZ37Pm4ML4ks/QbeMFSPm2tcCLw?=
 =?iso-8859-1?Q?BmhCQ9FZEqIJbE6O0M9agFYgJpEnoaZtUHefkaPnDUeuKZEAoaOGirp6fc?=
 =?iso-8859-1?Q?4Xgr6ICfjvoSELqNjYnOSG8qV+MJNZwmudMq8Iq9aVxg+zfq7ExnNBDqwm?=
 =?iso-8859-1?Q?fhuNieiSagC4hItatM0IIC+T0HsnKjnq7YRTr77istDRhOmtrmz9kpW4hX?=
 =?iso-8859-1?Q?tTbspC9WCgYlv1XU798PUg/COtxA8riaG+UcVkZM0HPFT8fOMDAHrYey2m?=
 =?iso-8859-1?Q?dVbdSA66A3rIuLHATl1rYM2W9BxHqJEBWhKGIz5R7lyAse9Y4K8cPNE9QS?=
 =?iso-8859-1?Q?Q9sZcSmlhKTr8Vrvx7/65nes818XybqUhMrflPGDuEc7PiDpZBErUUMvJi?=
 =?iso-8859-1?Q?mwEc9dJuWjph6Muz56yKYzFRRSeskFsBwp/UN76UM04yRUXruiSYfYR8Fy?=
 =?iso-8859-1?Q?gImmRXyPD7ROJj3ciKn3ThBu/xOrVYlfjkJqW0+ir1UceMSNj61zTf2Z/d?=
 =?iso-8859-1?Q?CG3laOUx3KiM+0jS0HZQ1MhyD0ErN9ktSsiFmHqhHQgdZjTVQrjlh+55db?=
 =?iso-8859-1?Q?yD7ZfjSQfYibYm7do9zWaESXr0nhh/4PI2wB3cFEeIPUt5KYEsfDAzhROy?=
 =?iso-8859-1?Q?lDIbzcv2XM6b+TlX7VRcN7h76oeSnThkshz3MMIakp/2FVIG0Lg9hhuURk?=
 =?iso-8859-1?Q?8ufydm+Lkv3ICYBTSGcEtbTUG0OcC8zPmZ85lOExSQeff22PFSnJaS6GrE?=
 =?iso-8859-1?Q?FOr766bU4/YOXUNSs1CkMU6hmSl7lviyW9KUg9VaCRLLTdrcPN9U8YMY4e?=
 =?iso-8859-1?Q?44cVicjFqAl6w=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 18:57:44.9600
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 898ce602-c41e-4e35-4029-08de3e675463
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A100.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9164

On Thu, Dec 18, 2025 at 08:48:32AM +0000, Jon Hunter wrote:
> On 18/12/2025 06:32, Ashish Mhetre wrote:
> > On 12/18/2025 2:13 AM, Jon Hunter wrote:
> > > > +    smmu->impl_dev = &pdev->dev;
> > > > +    smmu->options |= ARM_SMMU_OPT_TEGRA241_CMDQV;
> > > > +    dev_info(smmu->dev, "found companion CMDQV device: %s\n",
> > > > +         dev_name(smmu->impl_dev));
> > > 
> > > This seems a bit noisy. dev_dbg?
> > > 
> > 
> > This info print is similar to what is there in ACPI path as well.
> > It's only a single print per SMMU at boot time. Should I still change
> > it to dev_dbg?
> 
> Yes, I would.

It's really not that bad IMHO, I am not against that though..

If we have to change that, we'd need another patch changing the
one in the ACPI path as well to keep things aligned.

Nicolin
