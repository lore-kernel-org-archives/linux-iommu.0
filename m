Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013024.outbound.protection.outlook.com [40.93.201.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD692AE90
	for <iommu@lists.linux.dev>; Fri, 23 Jan 2026 17:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769190506; cv=fail; b=eit3UMys1SnoQxB3hf4lroSMUVgu/4Y1cWB0ZX1nmA5YOKez03kz7KUqnmps5A157JUxRF8Yz9YiiLjMgXfgjf4U36U2uhb2CVElvZICEtxFKuPERksONTxqe7pPyJa0gZL0qhQME0ALT/TZ3vLeLhE12C+grsJQZJI2tssqubo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769190506; c=relaxed/simple;
	bh=TGqGkvaialT8P4o9Aa40Qq8rV8MGMsaQhYJXC2szVNA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JygUFSloA616hA+ESJVJUVjFlQIcvrhnxDppwE3mB1Yyf/LohA/e1G3Luehno0ZYDDFLCw+JmlWhNAr5x6Mhb1H7Xdf/jdpdqRBcedN0FpMC9h07o7n02lFu0a2bgC1s57ARcrfa95DXkR7rvjEqrBCbcBMZ7vTIbTM/71N6Uf4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZhtBBEwm; arc=fail smtp.client-ip=40.93.201.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZhtBBEwm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ct0/yBBoIHTPgIfx9Q6/ZAUFc5X2daxgFKh+z8g4uVypzISEIEu4mCnAF+02g8eW0goj/kc1wdDE//TS5ldwgE9/CUaDS+KrRhMGHdViUkA7Ux/3GCwSu67psa9FitFDldTgc5ffs89eqJ16yH4DYWC4mu5A+YpFmIAf7XiKmkLPXB92YsXBUS8X9xolqjG9VP4kP1kcynP7PFRrsdSPCe0A5izzxqeTcR4zhJP9Lo/vITmHlY9QwKCk8Zyr/luak8tVOMTaLmv3ljjot7BHmsEBH3URQ5PUO7GJwv23M8y25EZcY/Zu5wF8rLtp1sebsx02+jLUbTH259BqY4/LgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mAIorRGJJo8DOc34zdo1Edph9vgemrFu5ghacBGh80w=;
 b=InMXe17q2m67wN9alh77ZiWe3z/q7lyAWH4pkJ3/wcUm0Ky2Mvetd9xvZg78Sv1fhQWrl+8i5QaAe6PqPiR7wA9vetzal5Mc8L28/BVhEWcaIlCJ7sUuga1i1rGffOeLgG4S9PLbCez2ZRs70kPo1LjQBJaT21SFCWmjv5JdpAvK2JV//fjdH2tSfLY+gf6ptHk0gFqhWet9jX2iw6i+xyNDYTlkX6NiXWKYu1zt38oMSjjwFOA98Hn01CGRN6d+oUz4unfD4ujrrKFfpH8ktoW2P7c/bYUz4hfne2GvBQ6TUAtEbXR/XMp29JRzjaxBk9P/ZptEWTysyhhubOXgxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mAIorRGJJo8DOc34zdo1Edph9vgemrFu5ghacBGh80w=;
 b=ZhtBBEwmggwgFkVs7I2EUUV4TrRG+FsRE1yHa0aF65pt7XbDP463cshMog3zkiybwQu5V8LBfXOXigFNaz5E+vhSXxdVKfefuZi6h+JXP+/91jieg5nhyWhHPZUrtmGDmKCVhPEZhVAj1s51rKI7XzLiD1p4tEJne5Xyf4aux1vk8okAdjBzaqoyEeHGuAsj5ZHPMyHaN0xB1msiW3zNBQDqRfUlbrBvGO1xh7CDIb9C/vaKqPtlRIafbyQNpeu396VFwoF1SJc8coLax6fcCK+X1AWR8JxSIoOoJtfbBrW8tRXFN31/aYrKNqN14924comE58+d+XQIpjHcqsMXow==
Received: from CH2PR02CA0005.namprd02.prod.outlook.com (2603:10b6:610:4e::15)
 by CY5PR12MB9055.namprd12.prod.outlook.com (2603:10b6:930:35::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 17:48:19 +0000
Received: from CH2PEPF00000099.namprd02.prod.outlook.com
 (2603:10b6:610:4e:cafe::bc) by CH2PR02CA0005.outlook.office365.com
 (2603:10b6:610:4e::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.11 via Frontend Transport; Fri,
 23 Jan 2026 17:48:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF00000099.mail.protection.outlook.com (10.167.244.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 23 Jan 2026 17:48:18 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 23 Jan
 2026 09:47:55 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 23 Jan
 2026 09:47:54 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 23 Jan 2026 09:47:53 -0800
Date: Fri, 23 Jan 2026 09:47:52 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>
CC: <jean-philippe@linaro.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<jgg@nvidia.com>, <balbirs@nvidia.com>, <miko.lenczewski@arm.com>,
	<peterz@infradead.org>, <kevin.tian@intel.com>, <praan@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 7/7] iommu/arm-smmu-v3: Perform per-domain
 invalidations using arm_smmu_invs
Message-ID: <aXO0SKsi/k8slP/B@Asurada-Nvidia>
References: <cover.1766174731.git.nicolinc@nvidia.com>
 <308ed579c724879a4a20b19ccdcb33e917597d77.1766174731.git.nicolinc@nvidia.com>
 <aXOqwymxe-nzYpwU@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aXOqwymxe-nzYpwU@willie-the-truck>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000099:EE_|CY5PR12MB9055:EE_
X-MS-Office365-Filtering-Correlation-Id: 401d3fe3-4b91-4b6c-fa65-08de5aa797d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?J/kAahR6qCm11QrTp8+4fPxewnYPP6ftVYk2KBXbHLuea3qtANV7HaYuvXLB?=
 =?us-ascii?Q?RB3AJhJXiN4kH9KWpYuuJ4CNBhbHa55WwtaVaKLC64bKCvG+9eiGzSHGlMFI?=
 =?us-ascii?Q?p4KUMIBjyFZT0FBXfgfvG7hHIKHutpCeNs3/h5hmRjWToIc9lsedwnprCnML?=
 =?us-ascii?Q?U/za/6NjC9MFaQnUHliQU4llb8XwBoVabDxh0qpAPvuKjScats8xoosTYKaZ?=
 =?us-ascii?Q?eLp74R4ji391teJ/op0ZNSLU+5bxX34wc+LvHrLqtZWJVRnbnpFYhtPczTyE?=
 =?us-ascii?Q?UpC3RJI7rrmlY8jP7Vz+tzWhF2iBxseensIkEIGhZIlxZx6SEtuUNijNQp6h?=
 =?us-ascii?Q?1Km852L+lrUMJPklhlAA9EF28fk87qduVZbslDRmYskkcnQiQVT1qaSHbL1L?=
 =?us-ascii?Q?toua8WKQYElJo05HSYNtGJCeUV1he8oqdHAWmvhRt8P1Z9T4UeoQKwRN6T8V?=
 =?us-ascii?Q?DpiCS0IkQsBL2QCml8HnTLgqQDiU8ZHhJJ2xfFPaLeJ2bDoYQF0InAdy0MVN?=
 =?us-ascii?Q?vtSflnW+nkC5duyB7WNRKXT9/jesdAB6k+cw20qdJ4lmWE3Cuwm/+N/9vCVb?=
 =?us-ascii?Q?I33MCyod4YE6ij0SpnSqM5gwnYPnKrhdJ6k+p4+Y/slgFf+gm+ZFgNbi+IG9?=
 =?us-ascii?Q?zd3fNNzvBD/yT+F/ahhI+5Uj97ZBSRjeb5SRN+SU7NnU5GkUGsmWY6Unag5m?=
 =?us-ascii?Q?tunH4UJBykrayw9YVXpU3Qomr6ZvtMGF6RC3yImVX+rwr0mLfd4P4uGxkOab?=
 =?us-ascii?Q?WiAjAGDhE1MdPriwh4v2JT7GQOaLFP4ZZoPax9tjwkAGnkPtAgLsy0LDfl0i?=
 =?us-ascii?Q?5M+y2NVH8ZZKwMdxqYwS5L5Zk59WbvNoPC1STE9iAMWc+zEmLHKbNog401zP?=
 =?us-ascii?Q?tJSjaxHPy1yGPv4yZ9HzhpZpA3guNEFbQUyjspi9owtmkpeP/I9KHGRn/Nis?=
 =?us-ascii?Q?7Gr39PEhhirqp1+X9O6/iw28Cx9wpND8Dcd+b/xcXLavYvJGPVm7F1LNFg/2?=
 =?us-ascii?Q?9ZsE7wPcZvTGj341CxNUiB6YNP/tv90InIfTppYI+mLrBjrAc9ca6kk1nHLm?=
 =?us-ascii?Q?SL5tf1InwMWoL4KYMsPaLjGf9hF9NoxfupObetLXxGxSpMWVOWBiZGDf8nH4?=
 =?us-ascii?Q?EmSeLENpvfh9bC++i57VZNUBJTxz2W9d/5H0kPElR7fxTodi+gfkKfzdzs6v?=
 =?us-ascii?Q?YrIXgX+Zu6JbJBt3eABx6l12NCZwbYbSXcZJKwGwl82xU7SPsnqTCXi5NEnr?=
 =?us-ascii?Q?A6ls54q+Tc2kHeNjn/os/6gEyOPP34v5o2FmLujDaXULwd0YjXuHZmPvPSLk?=
 =?us-ascii?Q?OKrSrBO9JydSHAbmTwSXkOoGTnbXizGdpUEk5K0NrqjkpW/426IEUQJZ20gI?=
 =?us-ascii?Q?SAaJ34l9siX3WmSU75Z0dJaItK5xwXMWs+1/S00I7s9fFl/RPLoC+IbPYVK+?=
 =?us-ascii?Q?JkgFzdeOq4gTmbmIDqJf2GSzd2/vXe/Yv9peUUWnR8r+7kHpdmpEmnvSRevz?=
 =?us-ascii?Q?hB4TjA4DXXVi/wMc60nUU/7nkfp9TXLug2ST9BrxJkkU1YeGichY/U6Qfrxg?=
 =?us-ascii?Q?Ag4ZhspD+FcQmnTVjTzJl7cEnUeN+YzsOqMzFlzZF33IW8x7xt68QFNOb9GN?=
 =?us-ascii?Q?NZwptMQpZzRx4HGDd/CltTnYsAeD6vFI+zXjEZTDV0VUqnvRIzWKldYWAuIJ?=
 =?us-ascii?Q?DdHkfg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 17:48:18.5124
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 401d3fe3-4b91-4b6c-fa65-08de5aa797d7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000099.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB9055

On Fri, Jan 23, 2026 at 05:07:15PM +0000, Will Deacon wrote:
> On Fri, Dec 19, 2025 at 12:11:29PM -0800, Nicolin Chen wrote:
> > Replace the old invalidation functions with arm_smmu_domain_inv_range() in
> > all the existing invalidation routines. And deprecate the old functions.
> > 
> > The new arm_smmu_domain_inv_range() handles the CMDQ_MAX_TLBI_OPS as well,
> > so drop it in the SVA function.
> > 
> > Since arm_smmu_cmdq_batch_add_range() has only one caller now, and it must
> > be given a valid size, add a WARN_ON_ONCE to catch any missed case.
> > 
> > Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > ---
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |   7 -
> >  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  29 +--
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 165 +-----------------
> >  3 files changed, 11 insertions(+), 190 deletions(-)
> 
> It's one thing replacing the invalidation implementation but I think you
> need to update some of the old ordering comments, too. In particular,
> the old code relies on the dma_wmb() during cmdq insertion to order
> updates to in-memory structures, which includes the pgtable in non-strict
> mode.
> 
> I don't think any of that is true now?

OK. I'll update those ordering comments. Combining your latest
suggestion of using dma_mb() v.s. smp_mb(). I assume this will
be just doing s/dma_wmb/dma_mb in those comments.

Nicolin
