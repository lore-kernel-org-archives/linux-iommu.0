Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2073.outbound.protection.outlook.com [40.107.101.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CEE1BDA97
	for <iommu@lists.linux.dev>; Fri, 28 Feb 2025 17:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740765292; cv=fail; b=IAMf7pGgvljpwXRv4tF1g3L2aSuBL7U1GMedExWSauj/0L8GEWk1UfzO4Bvxl+S15vLqRhLWTJUXjqIxiRS+6Wun60MB0cKtuzett6oAbIA2OwonZ/m4UrCw/xOI6UC39DqihrJBKhRx4C9eVx1OLBIL8M2UFfaEFBhNClzy0As=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740765292; c=relaxed/simple;
	bh=TRkdLeBdm8zTB/qKB93I+o7GacDPN5pyorvNtUkc90U=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CI6vcoDklycwIEiPqmvg30Ntt1+cYvu5SDXCg0gRn0ED4ID6iRrX/P2jvKLl6VG0lqPUosRBZb8d5oRUZaRWjft++fFhfkr2KVz5ZxiFZ9VqgnrMzXfr5Rd34mogIs31Erb9hVSVSHlYJxqAb+8Y7JF3MG+gArcPqhaxk2XS4DU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Sy4RvZhn; arc=fail smtp.client-ip=40.107.101.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Sy4RvZhn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jE6ImRXW0GvPncmgswBReZ24i5vRsUopBl9eaS1xRL17tqt7yMNz2XVSQsYwLZ/mdSiErGjfNFpygpqWpVm7K31lz17K7T6/72h1tpVBXjC88X5XW8ZRBVoBqruZoN3zl5+pl3G4O1rF9O17WmECaOi+rqX29NBp/wFbRpOxS4WjOrI5uHlIscR0I7PF7wiWvso8CdDDHKLt8bcgX2nguMVGmqYyKS06RWMWMmhQRCG9CpssFtawsDEgDvaSL2SIWzxSfzHR4zqoDwtDKwpPd+KGakiJ679dDpm2+HJ6Kb47O98O5KbFQtKyAX0x7k3wKNU4SStTjCmN3JKeaNbXWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hLpxfYTNX+NHAlD3GRdPQiBt63mAnPm24/9AEhjOO70=;
 b=savJCGMI4RCXRaNvAIdAGK9sNsXEp8I7mQ5pwikg+6qitLev0wIrqXrIolCSF+bJcmwTHkpJNOArK295zRXuO7mkxgB0NJMCWXFY4XbPZuc2hq5QWuoXpPiK5TPGZ+4pSld9RcOqF4zlVi3rW4YRPqxLWxsEoiV3xqoAx9zbzfu8lkknpbQASS6gxrXyfDuaQOFxE7e5iZAVUEcgJbP+53zoq7wh+0yDmkMzzAQOr6BqlfkkVNt5nIbiSKeYU90PghSAC3ps5OxEo2xG00oNrB+tROwgPwQmvifBE1p0vRIk3seEuGvXrmI7MVAPVfdxPIFv+HRs620LJ3PQajs9zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hLpxfYTNX+NHAlD3GRdPQiBt63mAnPm24/9AEhjOO70=;
 b=Sy4RvZhn/aghyDuARvY/Pebdz1N0jkbD2gTMV0IT6/9WL/hu8fjXJHg76k0u7ViksW6MDpTYzQfXtPosXkk8EIezcH6Bb2SPimLYJLRq/ou0KjD00PDlBHuxLiJiLqYQk+nAXj2mM2BVXjLPHxuleyDPiOU0FrDqwXsSo/n1BtXIlabezZjbP5x0rGZfee1u1dkaU8eapQqsCOys7PWBMj82FB6pmemzKLy2XIvC7+xsPCe/6xRxUJ32cnyPR9PUmK0U+uzkxnnw3kBt2BvoGXeycQPhgxEfWoSE1blBM2lEmFsyZC+4THGJwus3peg3xFegG/HqgYOybfbEZj/wyg==
Received: from SA1P222CA0172.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c3::28)
 by SA3PR12MB8046.namprd12.prod.outlook.com (2603:10b6:806:304::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Fri, 28 Feb
 2025 17:54:49 +0000
Received: from SN1PEPF0002BA4B.namprd03.prod.outlook.com
 (2603:10b6:806:3c3:cafe::b3) by SA1P222CA0172.outlook.office365.com
 (2603:10b6:806:3c3::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.23 via Frontend Transport; Fri,
 28 Feb 2025 17:54:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002BA4B.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Fri, 28 Feb 2025 17:54:48 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 28 Feb
 2025 09:54:30 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 28 Feb
 2025 09:54:30 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Fri, 28 Feb 2025 09:54:29 -0800
Date: Fri, 28 Feb 2025 09:54:28 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<will@kernel.org>, <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] iommufd: Move iommufd_sw_msi and related
 functions to driver.c
Message-ID: <Z8H4VL+OUfi2+5eA@Asurada-Nvidia>
References: <cover.1740705776.git.nicolinc@nvidia.com>
 <ece6ab9a0144eaabc285eb21a09da683d6d9951c.1740705776.git.nicolinc@nvidia.com>
 <20250228173212.GC39591@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250228173212.GC39591@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4B:EE_|SA3PR12MB8046:EE_
X-MS-Office365-Filtering-Correlation-Id: 46f466b0-be95-4bdd-7700-08dd5820feab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ff+DJDevWvAumKqM3HfC9cWEpCXKndkNnrg2cSLM6Pk1iZGnaN3zhCE8vFNU?=
 =?us-ascii?Q?nUSoECAlXBv2WJAX8d2nJmzxMCj6mKWRbPkBBEKezvZ8J97KmOEeDlEa8fKS?=
 =?us-ascii?Q?+6GK7jipAQGpJT/cBaLL+EQHG0KD/quw5X74zmR6OCKaJIo6q7BBl+JaBrEu?=
 =?us-ascii?Q?S2hb1R8cZGTfM6TbktMSsxml3qRQbu6Ork1Kk3cHaQe8dyMz5r2OKm4spIVx?=
 =?us-ascii?Q?KxC6g0guJ+V3bGc7XFnBOCcnrfhXuJk+NXSDr/L68frULzB+lqtMuBtt1Gc7?=
 =?us-ascii?Q?OU4/OQiM/zIGgOT8VDR4uvNJzoO7hqOROj+o3R3zVn5C55CWKgptZsG7DEFG?=
 =?us-ascii?Q?3Klo3aJFxJ8ZJzDRbtyGjHdGS7NMGsV9AwQpq9o9ffWOHoouXh2T/3DdgGci?=
 =?us-ascii?Q?DOYdV5rqX0h0JZ4H7S9ag7DMVHjOXvwjL8NUGdJHoouqGWK0OcCQ19nmjNeG?=
 =?us-ascii?Q?ebiNPDnDHd8PNS3xYYv9ishDhEvFtHoQBIafDciJrF1diAkigaEidhc1Zenc?=
 =?us-ascii?Q?MTRHZ1ZZ0scP8IxIo6aykOuJlTfUUlGS9/y+0HGZyK93+eoz+UCtIfGkazPp?=
 =?us-ascii?Q?6xVYSb1V2Q6G25OQ83usTbWTWdbk5VEbIPetol0iHGXqTmZ8Ak/ygih6t1LI?=
 =?us-ascii?Q?Pd+whHf107x/15AtR/k0yFwDOTcy/koLfAbN4MZyRu9xWBEKg3fesdenw+Zv?=
 =?us-ascii?Q?xTWwW8HWfrib/thLBaWDla8DujHdXW26CWYxdZAtOvb8AIDrQkdXBiYB+A+r?=
 =?us-ascii?Q?LsZNLGxif+4k1x16wJW2iM8qAdTp3hAIspnx3UIUUNAAvU3rkbO2xw2Url/x?=
 =?us-ascii?Q?M4ZS5IWvfaF312oy+yX+wzjanvjfyJO9HtcHV8StKrTWEdsUzGMF0lc/xEI3?=
 =?us-ascii?Q?Z2BgKpxxWha++0ay9o1fNm+4i0HcjWTAQrgiWIeKN7sdsWnWC+PVP0oQikf7?=
 =?us-ascii?Q?wuaoc8Y7IigvVJoCxnfWLSoul1O5gDl62c4xnipfiJ2f7IuRdRKo0jCiqEzE?=
 =?us-ascii?Q?aou90JsnK1xtpM43rmj+nr6PPTeTSHm31SlV/qJ2Eo5SB/wFKTp7efzqFX2s?=
 =?us-ascii?Q?c6fHefma8OlIO2byi2l9/C2bz5a45V3dRVkLDWcsg/qp3YgoRUHoCmtZmlRH?=
 =?us-ascii?Q?yB3OxdZOpl6DWAfhDikD4vjUXq/SjI61wDgX4O1blcvulMEhquKzS9XofQMY?=
 =?us-ascii?Q?xPbMB/5LcmJOG6qOFh/TPOEHBQ3b4uOY1RPtnVhhparwTjt8djh1SMtAo8eJ?=
 =?us-ascii?Q?BMy36Ilk7GPyYi8Z3Rfb1NfHHZmJc0UBdWUyrZsLE0mxI6uQCiM/XS5GVWRM?=
 =?us-ascii?Q?wInUZuJ4pJ3ggA/zExyRKZKPghqboAvWR2Z7JdkvD+SuT171MeHuCwpvpWhJ?=
 =?us-ascii?Q?6b6CJPCN0Z53ZBdMj0EW3HvtGL64/B8RewHW9DFrsAAF2cN+fiLQovpfwlLv?=
 =?us-ascii?Q?ZB/ipmNC6aA6KE9IW9dsspaQnrf4IeTFRFkGryubjnsR17PE6tKli9b3uhKy?=
 =?us-ascii?Q?j9HyNFqRPtDZc1o=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 17:54:48.9763
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46f466b0-be95-4bdd-7700-08dd5820feab
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8046

On Fri, Feb 28, 2025 at 01:32:12PM -0400, Jason Gunthorpe wrote:
> On Thu, Feb 27, 2025 at 05:31:16PM -0800, Nicolin Chen wrote:
> > @@ -187,6 +188,8 @@ struct iommufd_object *_iommufd_object_alloc(struct iommufd_ctx *ictx,
> >  					     enum iommufd_object_type type);
> >  struct device *iommufd_viommu_find_dev(struct iommufd_viommu *viommu,
> >  				       unsigned long vdev_id);
> > +int iommufd_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
> > +		   phys_addr_t msi_addr);
> 
> This should probably go into drivers/iommu/iommu-priv.h ?

Oh right, I forgot we had that.

> > +int iommufd_sw_msi_install(struct iommufd_ctx *ictx,
> > +			   struct iommufd_hwpt_paging *hwpt_paging,
> > +			   struct iommufd_sw_msi_map *msi_map)
> > +{
> > +	unsigned long iova;
> > +
> > +	lockdep_assert_held(&ictx->sw_msi_lock);
> > +
> > +	iova = msi_map->sw_msi_start + msi_map->pgoff * PAGE_SIZE;
> > +	if (!test_bit(msi_map->id, hwpt_paging->present_sw_msi.bitmap)) {
> > +		int rc;
> > +
> > +		rc = iommu_map(hwpt_paging->common.domain, iova,
> > +			       msi_map->msi_addr, PAGE_SIZE,
> > +			       IOMMU_WRITE | IOMMU_READ | IOMMU_MMIO,
> > +			       GFP_KERNEL_ACCOUNT);
> > +		if (rc)
> > +			return rc;
> > +		__set_bit(msi_map->id, hwpt_paging->present_sw_msi.bitmap);
> > +	}
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_NS_GPL(iommufd_sw_msi_install, "IOMMUFD");
> 
> Stubbed out too if CONFIG_IRQ_MSI_IOMMU ?

In that case, the other caller iommufd_group_setup_msi() could be
{
#if IS_ENABLED(CONFIG_IRQ_MSI_IOMMU)
	....
	iommufd_sw_msi_install();
	...
#endif
	return 0;
}
?

> I'm still wondering if we should use a function pointer, how big was
> this compiled anyhow?

Hmm, you mean the size of driver.o? It's 192K (before) vs 212K
(after).

Thanks
Nicolin
