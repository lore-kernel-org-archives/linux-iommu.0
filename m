Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012013.outbound.protection.outlook.com [52.101.48.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E1029A32D
	for <iommu@lists.linux.dev>; Tue,  7 Apr 2026 17:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775582516; cv=fail; b=IeN221EU3Q7QNwJYiYB2i4m8JN2XQiksn+hwhgEoz201PR3YvaOMwe5Zf1ykx8IUav0af3rpNHuKYWl4LCzzD7u3fRjkI7E0a/S69DN9qpMou6sUtPEW1V2XgrDF7tojlXVr1BbcHdP9YVC0STyKtBcSOtIkXlq/C3t4RGp6fN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775582516; c=relaxed/simple;
	bh=Z/xu5avuw5Z5S2EPgEMS5MFdLmQm4ECYz5PFrXm4S+U=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mKz/SACmhyTU75vGKwS16QtHpejekNN0sNpEgxHEvQ1v9POOz9Sc3d8GrAgW6hJzP3qzWW0P3t54wWPNMG8847rlRE6Wvu85PDRQ+aWzxlZQhSMAlX5e8y/1sn3Ab79Mxxy94FV2J/ukdlxtxnO1l0f7seHIbfDI/xdtP/VU61M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PSvUVYu0; arc=fail smtp.client-ip=52.101.48.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PSvUVYu0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZaGztUYEdRsT41c9GeqjWhVK3EBZjt5SN0JUjKZhqInGK457Ma/dwy/iGTIVz9BkUxN67noPuQLqmJi16a4qbuSqFQUdJVYOqPn8DLOZ0N9vwmkc5Rd1zdQey04oHO3QbXPJjUtk+ZfZNcoxx4ZCD+CXl4r4Eag84ziSoTSofAR05kNQGvquwHqN7FW/eyi9LBu+NR0iXAizge71hjqQbnj9lDsGq1jiHtBGksdGtMYHv96bJa4w2JG5AyBLEOoWepIkWV93RKeTLXRy+FtIi6KVW5hw+2iWQoQlgZ1F12f3D18ir9YSITOTBL054Hqejb+UrScng1SXtqRLuAuXlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eL+8nYn2ysIrW0tuATWAAHu1idVifI5myy6QlfOsbO0=;
 b=QNCJ+QfUTIURmdOKmBcoN2V1qu232iF1wddRjxMMxtIO9DvyV6fhv0i7JM0zopri5IFKsGLiRl6Vf/Q83122CLQZJoDQS/4XDsmKNRgHsoew45xcQzNaiOVsg7bVlGNYADZfr0HydxUvs3dRGmxo6BR0Ro+aI/C+vvGdYdH/cYVD3iqpFT5HG7uwwBk3eoiJd7c1H7ucv6zfEM+seLSvJchtyjnBRaM56VwftwGShE31/qBkmrQ9tp5Sx18sjodPcUnJefRSJm1f1oLhS/BGI8mp+V/KsknvkN3/R+hnKxOGxFTg8x1ibKwYRhdCnJKpLraELopsNGgyeZcOPin7fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linux.alibaba.com
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eL+8nYn2ysIrW0tuATWAAHu1idVifI5myy6QlfOsbO0=;
 b=PSvUVYu0M+I/7XYf4u2sFurp83Vs00euL/ZkZ9Jodlq5yC1OHxsU6giaBjWFB8buoUCf31je8N/o0NzRf8S9OZYbpRo7d9GU3myo+S7NvB55vEwNHeFenwrvywkxYPqnBeDBIKHG8GAOm06QFl7XSOWXpFeUZ9NSomAwQrtobk+d4//IRURHuFSxfe7OkUTGNbgka9ADlQ5GciFwJud+JefL3Aq22xDZOlvpFE/vztLXHOlOwwyk/jQjcd6kPV7c8UGmQ4wkN9aVGahcEi994EQbfzoKs2hUf31oAdEIhlJ/VHx2O+2ORmElOoGo/cDONOR75OncvbswHpH0XjA14w==
Received: from DM6PR07CA0094.namprd07.prod.outlook.com (2603:10b6:5:337::27)
 by DS0PR12MB8813.namprd12.prod.outlook.com (2603:10b6:8:14e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Tue, 7 Apr
 2026 17:21:51 +0000
Received: from DS3PEPF000099DB.namprd04.prod.outlook.com
 (2603:10b6:5:337:cafe::4c) by DM6PR07CA0094.outlook.office365.com
 (2603:10b6:5:337::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.33 via Frontend Transport; Tue,
 7 Apr 2026 17:21:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF000099DB.mail.protection.outlook.com (10.167.17.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Tue, 7 Apr 2026 17:21:51 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 7 Apr
 2026 10:21:36 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 7 Apr
 2026 10:21:35 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 7 Apr 2026 10:21:34 -0700
Date: Tue, 7 Apr 2026 10:21:32 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shuai Xue <xueshuai@linux.alibaba.com>
CC: <joro@8bytes.org>, <kevin.tian@intel.com>, <jgg@nvidia.com>,
	<will@kernel.org>, <robin.murphy@arm.com>, <baolu.lu@linux.intel.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH rc v5] iommu: Fix nested
 pci_dev_reset_iommu_prepare/done()
Message-ID: <adU9HKS1zFocjub0@Asurada-Nvidia>
References: <20260404050243.141366-1-nicolinc@nvidia.com>
 <ad858513-09fc-455e-bbc5-fe38a225cc78@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ad858513-09fc-455e-bbc5-fe38a225cc78@linux.alibaba.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DB:EE_|DS0PR12MB8813:EE_
X-MS-Office365-Filtering-Correlation-Id: f5f64625-b403-4726-ebec-08de94ca285f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|82310400026|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	U0xO1f7js71f/4VgIQ0UPIQgu0xq59rFQjkRKPUEmcimazVRyqYmg5g2YBcUOqYfIz83VNT0MKTqCPYSNE0UPRoCDeHfjgExXobuELwc0b5pe1FCPBbG2jJHnT3FbhHd+0m/vjRKCyVYv/RgS2IFA0trW2rrLKflzyqcCkp11HJPAz2BbL1mqyaRhv1aPZu++O91OSEZKT0uXay89f6oSiOFgUk9FQbxK9YY35cIBr7ZxLjsqr9+Nh9gI0JhPy3I2U84AWj9RP3QR7DsCar3lOZTvFakBRSc1RsGtH1k8kJfeiDOWFII4XsNxJZfsvTuEQq3EUvoeh28SNbhpqv6FCQK7YT0m55cgcU+zHSStiuQqme5c/ZtQEnt+QspStfS/+b6YZu/dIGYhgXF9lmIKIo6InV0JZYuAfQm4b6HiLhir/4md/uaQ5+TKBQB1FCxA9OP5PVUk5WP/65V/16be8TUwAVROFNPlXfqUmCnyNB/FWCja21/3f72jsT3+9tgq+hVI+gGon4Iru0E6EgvTeQ2TL3UgPmLkEq6z2EjLC6msWQexoytboqU5VZAd+w39PEGrejF17gXSI+tJ4qJG+bH5vwWOtgBP+lRHNQSYlduWAKbaJgSrePb5VNVPF8JYQrvzzeps5lRqKwiTZF7ZZ05yFwsRBx0D4kiK6uN3yUMmnKn86kdQNLCZZah03RQapg26np6cKaErolY1gvznVyMaHt3e+LTbu+6QXuIA1w7unyo4iwbQJ12gZd+rqMdXLM41L3kwuPSQvZx/JN0zA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	boII82RqM3zEgvo+YmKDrO5loJbPnaXSAMm3u2dfJ7Eylha8+TWDfOWxfx7nfPHu6RluTNB04TbD7gqjw7EIelwh6th7AdhrSuMdQVdasdR166VHwYZl72yd/5AQi0XfXsUIFHQ2J95LzO2aHm47q5vfpTh4s9fsHYnBmZTMIHG6+kSSYPakFcax6bLWllN5wPou486PR3m6Z4DolRpiLdNYBP08wpB/BUKDq9sgUkL7sd1rCB4hHQZX2H/o0yTCstaZSZO0YM3vG/1PKS66hZbnjKs0Pw3UW07ueKMQwGbyIdO3K+CNMOschMjPbKlem/iQHrSjKe4VQ3DAhDp5MFScybYmt6VyzhDfKGqict37y1Dst+cicHyW0ssbp2R8cj+Vj4mlDQXUOpeFFHPWZXxAefXP1WgAw8e42dX1khU40TNmiBAlJ+QI5PUp13af
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 17:21:51.3475
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5f64625-b403-4726-ebec-08de94ca285f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8813

On Tue, Apr 07, 2026 at 02:36:21PM +0800, Shuai Xue wrote:
> On 4/4/26 1:02 PM, Nicolin Chen wrote:
> > @@ -3987,7 +4017,11 @@ int pci_dev_reset_iommu_prepare(struct pci_dev *pdev)
> >   		iommu_remove_dev_pasid(&pdev->dev, pasid,
> >   				       pasid_array_entry_to_domain(entry));
> 
> The max_pasids check is indeed missing in
> pci_dev_reset_iommu_prepare(). All other callers of
> iommu_remove_dev_pasid() guard it with a max_pasids > 0 check:
> 
> - __iommu_remove_group_pasid() checks device->dev->iommu->max_pasids > 0
> - __iommu_set_group_pasid() error rollback path also checks it
> 
> But pci_dev_reset_iommu_prepare() calls iommu_remove_dev_pasid()

I think you mean pci_dev_reset_iommu_done().

> unconditionally while iterating pasid_array. Since pasid_array is
> per-group, in a multi-device group where only some devices support
> PASIDs, this could call the driver's set_dev_pasid on a device that
> doesn't support PASIDs.
> 
> Note that this is a pre-existing issue in the
> original code before this patch, not a regression introduced by this
> fix.

That's a good finding. I will add the condition.

> > @@ -4030,6 +4070,7 @@ void pci_dev_reset_iommu_done(struct pci_dev *pdev)
> >   		WARN_ON(__iommu_attach_device(group->domain, &pdev->dev,
> >   					      group->blocking_domain));
> >   	}
> > +	gdev->blocked = false;
> 
> 
> One question about the placement of gdev->blocked = false in done(). In
> the original code, group->resetting_domain is cleared at the very end of
> done(), after both RID re-attach and PASID restore:
> 
> __iommu_attach_device(group->domain, ...);   // RID re-attach
> __iommu_set_group_pasid(...);                 // PASID restore
> group->resetting_domain = NULL;               // cleared last
> 
> So iommu_driver_get_domain_for_dev() returns blocking_domain throughout
> the entire restore sequence.In v5, gdev->blocked is cleared between RID
> re-attach and PASID restore:
> 
> __iommu_attach_device(group->domain, ...);   // blocked=true
> gdev->blocked = false;                        // cleared here
> set_dev_pasid(...);                           // blocked=false
> 
> This means during PASID restore, iommu_driver_get_domain_for_dev() now
> returns group->domain instead of blocking_domain — a behavioral change
> from the original code.
> 
> I traced through the ARM SMMUv3 path: arm_smmu_set_pasid() →
> arm_smmu_update_ste(), and the early return at:
> 
> if (master->cd_table.in_ste && master->ste_ats_enabled == ats_enabled)
>     return;
> 
> is always taken during PASID restore (since RID re-attach already
> installed the CD table and ATS state is consistent), so sid_domain is
> effectively unused. No functional impact on SMMUv3.
> 
> Just want to confirm: is this behavioral change deliberate? Or should
> blocked stay true until after PASID restore to preserve the original
> behavior?

I think it should be updated next to the RID domain change, because
iommu_driver_get_domain_for_dev() must reflect the actual domain in
the STE. I will add some comments in prepare() and done().

You are right that it's status quo for SMMUv3 driver for now in the
done() path. But arm_smmu_blocking_set_dev_pasid() in the prepare()
path checks sid_domain as well.

Thanks
Nicolin
