Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2060.outbound.protection.outlook.com [40.107.236.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2116342A8C
	for <iommu@lists.linux.dev>; Thu,  6 Mar 2025 20:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741291838; cv=fail; b=G4Bzlx4aZwi7ZApLlA/CMOnPmWnOB0gQJDHNfIpC1X0/hLFHYYpwYpdZ4Ze3yUacUm4Dqd5tgyMbZ/2yhYjFwdeDOWYJxt/N5DusXLzfJQ/Yz2oSlxjQbb2EQllkVmL0iwyenDHIDQb+j1koPg7C6wttYtYXyLHDPyV2ilLOvkc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741291838; c=relaxed/simple;
	bh=7tvbPi+y3azQRVoFjadF4xXJoc1nn6naq+TpEhPvGTE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J+0M7xW5cSSwFyxqx3qndJkvXcmQOvcta6bprcqmV6/5HsMGTPY8O80Mcc9bbT3kuQJLbPBEQqC/JctRbhohRukLQAhsedFKE3iRrwuIA/RdX5uhVBJbN9mFO9ltPFj+uuaPXNEsBB/MuJezbW3iUHbB22wZmIWKnWXTdmR/Kkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=t4nr9u+g; arc=fail smtp.client-ip=40.107.236.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="t4nr9u+g"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TJhEi9YHN+YACQoSevgWhz7rglfpansvUucNk1vfqQkLobjVuAJcX3o4mrNX65UFSzv9Q0uqwydq6sX1s1AZ14YO+i71uJil3ktiD4GsmRf96oGAALXFFoHMZJmu6w8sfA1uca1nF1lHuD9JANnEUXGDbytHUs0+92KLpmO3uhV8nZKWICcazuGP3zFe633MeGtHdUf4JZVPYX+6adq2RoNHMMZ23O0Ho8gtIbd+DWowyxuG3W6LrJifTQsA4eb/VVwFIRX+9Rxr9X2fXjTE6KgKiuNRLjVYFiOrA/Y/RQziozYStC5uFDmsZwaE+Ca8Ivz34s+9rbRZyEOKZiXemg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bL2b0iAFCiKhc9W19MwEtlzE4DS/QA4+N3kjT/9YBng=;
 b=mOOyY2+5RgD9NO0dcKlnnrOASZkIZ/uBzh1Qd9pkN+JEdFjSo6nQZpXJuqlo6Ze84X78b0Wc/oE5N45f5R1H4BnIKz2h7juJXzta+1DVJmIOFPUHdtPNLJJt9J2qVplfH0FT97qrl4gBYE++Mp0X2tHosS3PUEt75OcO+AxkGpqTcQm2sqYyi7JQLh5Znbtx09sIEjW60iQ+tBDpCBdynM7s61+gB2WkS9AvVoCxiWMcu4dWjeBzwyjf51olqJ3FqOb1ZRpTHa35o+PjegPJW+vXVPoXOXrROwE8T1ZgHamO7xHPSfmB/oYTw0xoowfBC2UlfdOk99PRnZA9zbMSDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bL2b0iAFCiKhc9W19MwEtlzE4DS/QA4+N3kjT/9YBng=;
 b=t4nr9u+g3+xggOyBJWIkugsHsKKABhfjI971dicpt0dd3EabfiM77pKCFiGnm24sJO5kAOvpSXgQ5CDBvCBJTuINVXMCeHUiTEWASzLDsGt2PKiMBd6HjPclUZ0KgGKMz2mchI5umebWYXLdrXJg63VdOqEil5XX2PmWKYM5iUneEnedcxlhLvQ6k+Y+tXUP60l1tW2qGSQC10bh/a6LlcmJ48oQRXvWNd3FQpS7SgeDRh3+H2orV/9FXhDdhtOTRd+GqiZ1wLNEzKSrUhax9VaVVY6OcoR5zU/PVPiBpxETzKmka3XAY3vd8UC7NASNG3Bk8idmIdzjs5L7rejiCQ==
Received: from BY3PR10CA0013.namprd10.prod.outlook.com (2603:10b6:a03:255::18)
 by CH3PR12MB7692.namprd12.prod.outlook.com (2603:10b6:610:145::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Thu, 6 Mar
 2025 20:10:28 +0000
Received: from SJ1PEPF000023D0.namprd02.prod.outlook.com
 (2603:10b6:a03:255:cafe::db) by BY3PR10CA0013.outlook.office365.com
 (2603:10b6:a03:255::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.19 via Frontend Transport; Thu,
 6 Mar 2025 20:10:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000023D0.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.15 via Frontend Transport; Thu, 6 Mar 2025 20:10:28 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 6 Mar 2025
 12:10:14 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 6 Mar
 2025 12:10:14 -0800
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 6 Mar 2025 12:10:13 -0800
Date: Thu, 6 Mar 2025 12:10:12 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: "jgg@nvidia.com" <jgg@nvidia.com>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] iommu: Sort out domain user data
Message-ID: <Z8oBJJz27/Z8P0vR@Asurada-Nvidia>
References: <cover.1741034885.git.nicolinc@nvidia.com>
 <74a3bf91b52563faaf7ef7de065931e4df47e63f.1741034886.git.nicolinc@nvidia.com>
 <BN9PR11MB527602ABF245960E85402C588CCA2@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB527602ABF245960E85402C588CCA2@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D0:EE_|CH3PR12MB7692:EE_
X-MS-Office365-Filtering-Correlation-Id: 3abfc8b5-5f86-4702-9615-08dd5ceaf081
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?on6aufAzpKizlOEIJTwwaEbwu8jeHP5mBn22tbVu+xa55/oWRnXeZAJtnzHH?=
 =?us-ascii?Q?HhQEYxUD9FR33XTMLq+a9q1CkUdhgxq8b8XhcKzBqR+LOAkNX7f3s+qYHRlz?=
 =?us-ascii?Q?oeKq5NXTvB2hEHtfbZLqkCIXz3yl59dGoWZLF2Omrwp+Spb8eBOGrpnCaJOk?=
 =?us-ascii?Q?jP4adCVaU0Hqu846cUmQx7+ZoyDC1RFt9DkSQ9I3NK172JAenpDPoXD0uO7I?=
 =?us-ascii?Q?bn5Zq7x+8K/X6ueowXvVzBb7dVivW8VUxU1XVmllV4RKeiuDyRFVnjrFLq3V?=
 =?us-ascii?Q?mrdtgeqbdfNuiYPs864v3iTPM6Y4ZZQ3m6P4vV8H3CdLuZtrQ5WAvCgwpPwd?=
 =?us-ascii?Q?4Jbc4AzgU/WWh/mJdWECSt92GrljTx+jH01022OQty/1VNxrBS2J+qVc5x5a?=
 =?us-ascii?Q?OdDNFPGlxtmxg7unNQVhG3z+4bFm8/gz6ThhYGwEtt4jEnGLqEoTuplqp+I/?=
 =?us-ascii?Q?ZllxGF0R5swjoY2HnZuDoEkSfqgQh5pnXSKFYcTc7Flq2RSjVlSMDsH/ah8f?=
 =?us-ascii?Q?w35QAgwQgOHE6Y+veWPBtIOlSuzb7kpu6aNynQ6KOQAEod4EgJo17MIudtsf?=
 =?us-ascii?Q?YlrZX39G+g78t350C+z5QtpCu28oGzJI1+UWjEURQp+rr0NeCpIxn4FfZDu8?=
 =?us-ascii?Q?9wb+gZa/QjOZzNrD/01XLvsWG2F8tkKV1so3FcJWm52z2f01bOuQP8inQWH0?=
 =?us-ascii?Q?UcC/tQgTGruvsSpoJDy5GoKLpIhyVCEvg0/LKBc/sUvLNkCr5ipyfhJqx9nm?=
 =?us-ascii?Q?Ek1kx3NCJdvRpiNfRsLZb85TwNqsfD3BV5AKxWiM1X5dHk2L2EGhQDizTeKU?=
 =?us-ascii?Q?ySIyixWyjt7nqTg3Pf+fFCx3CI/CBFclXXgkh825pbnt/4E4Mwu4O/A/Mv6u?=
 =?us-ascii?Q?jI5EsTZ2C5U/7N4SqPLZpPq5GWTUJ0dUxAClX+b1itI8ydqaHJCDckSWFUbn?=
 =?us-ascii?Q?auFrcRTctBCwhhL3z+mb+TpT7MuK0MMdrJIdylftO1GVlFyA+dxkB5um+2WH?=
 =?us-ascii?Q?3LdOjOXXBd/ZGsRhvwmVt1VwF3weadCixZk1+QjIqZVI6ytUv/Noe//C1Lmx?=
 =?us-ascii?Q?kh8VF7/CXS9PzNIkzsbLYwVwcj54h8mxzbOvYGjGaLel79POZoktIhQy78GW?=
 =?us-ascii?Q?GwtxygKif3jAH64R6EE+NXPodol3aGblbrFp3mzgvsMoPP4Y+0cGMvPQ+48J?=
 =?us-ascii?Q?G2fqQljmE5Jl1NlFTBhWnmBQLLFsf4zKH+nMV4RkXsV1uLFsFgshl88E6dru?=
 =?us-ascii?Q?Tren2+vWjcCamf3ACAXzDElr4cHH3g5tK/4pR4qWqJu2hxSPLGk/eBvVY7o/?=
 =?us-ascii?Q?WtubNzagT3WTLq2GpgYNG9xcylWf37FTBm2zpjnRiEynNs+sjbbXO45OTnoU?=
 =?us-ascii?Q?S3JYtsAU0nhMKx27zDd3mkTeUlYDjbZnZntJp7uy7ff7HyjbA+s0C5oNONnR?=
 =?us-ascii?Q?Bzl908NKjDjnuj+raAraCyIxDgIkdrSQ97YvKY29uXPsm5QM2a0PyjSCr08i?=
 =?us-ascii?Q?wSrSYaUXkVcy+nA=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 20:10:28.3293
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3abfc8b5-5f86-4702-9615-08dd5ceaf081
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7692

On Thu, Mar 06, 2025 at 05:59:03AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Tuesday, March 4, 2025 4:53 AM
> > 
> > From: Robin Murphy <robin.murphy@arm.com>
> > 
> > When DMA/MSI cookies were made first-class citizens back in commit
> > 46983fcd67ac ("iommu: Pull IOVA cookie management into the core"), there
> > was no real need to further expose the two different cookie types.
> > However, now that IOMMUFD wants to add a third type of MSI-mapping
> > cookie, we do have a nicely compelling reason to properly dismabiguate
> > things at the domain level beyond just vaguely guessing from the domain
> > type.
> > 
> > Meanwhile, we also effectively have another "cookie" in the form of the
> > anonymous union for other user data, which isn't much better in terms of
> > being vague and unenforced. The fact is that all these cookie types are
> > mutually exclusive, in the sense that combining them makes zero sense
> > and/or would be catastrophic (iommu_set_fault_handler() on an SVA
> > domain, anyone?) - the only combination which *might* be reasonable is
> > perhaps a fault handler and an MSI cookie, but nobody's doing that at
> > the moment, so let's rule it out as well for the sake of being clear and
> > robust. To that end, we pull DMA and MSI cookies apart a little more,
> > mostly to clear up the ambiguity at domain teardown, then for clarity
> > (and to save a little space), move them into the union, whose ownership
> > we can then properly describe and enforce entirely unambiguously.
> > 
> > Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> > [nicolinc: rebase on latest tree; use prefix IOMMU_COOKIE_; merge unions
> >            in iommu_domain; add IOMMU_COOKIE_IOMMUFD for
> > iommufd_hwpt]
> > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> 
> with a nit:
> 
> >  	msi_addr &= ~(phys_addr_t)(size - 1);
> > -	list_for_each_entry(msi_page, &cookie->msi_page_list, list)
> > +	list_for_each_entry(msi_page, cookie_msi_pages(domain), list)
> >  		if (msi_page->phys == msi_addr)
> >  			return msi_page;
> > 
> 
> Above checks cookie type in every iteration. Better save the list
> pointer to a local variable.

Ack.

--------------------------------------------------------------
@@ -1793,2 +1793,3 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
 {
+       struct list_head *msi_page_list = cookie_msi_pages(domain);
        struct iommu_dma_msi_page *msi_page;
@@ -1799,3 +1800,3 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
        msi_addr &= ~(phys_addr_t)(size - 1);
-       list_for_each_entry(msi_page, cookie_msi_pages(domain), list)
+       list_for_each_entry(msi_page, msi_page_list, list)
                if (msi_page->phys == msi_addr)
@@ -1817,3 +1818,3 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
        msi_page->iova = iova;
-       list_add(&msi_page->list, cookie_msi_pages(domain));
+       list_add(&msi_page->list, msi_page_list);
        return msi_page;
--------------------------------------------------------------

Thanks
Nicolin
