Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012033.outbound.protection.outlook.com [52.101.43.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549EF2C11F3
	for <iommu@lists.linux.dev>; Sat, 18 Apr 2026 04:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776488224; cv=fail; b=G4n+WI+RM6FMG5xxbJgCrYmHBdsgldlNm8q8YlXtPSEMldLaoc2eJT1JDrcUiOnCZh0NcoqvbOOyoozFsfTxEqLSFXSD3oELJmsRv/WWT/cQPyFWiY27L1EDYzJ/2HXyQVK6yd9iGR8reSMJJX8OPVfSwMOWNLIUQAo259RyjTM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776488224; c=relaxed/simple;
	bh=XkxmSvcArt0Ca2nShEqWS4r/LBnmB0EXR9KSI/qnG90=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=smu6GBOBp6kaPMMlQJWXqJTsAj7VHe2B43OZfcAmvYNqphEADXQ01iHWGLe4huFGVEffWnV64nR4vRQhxTw+xZlQMfO08+9NfrmXjmawEJ0hIjob/XC+ANCXXmfje8sdH1E7KSKdFauBV+2K9GhwRfG6dnPK3O7mDsUxHWoBwGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Qu49oqFZ; arc=fail smtp.client-ip=52.101.43.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Qu49oqFZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=psXKH/cdYkurCNBfbWrxY5EYLnTWpVxOct4F2JU4jNRP0mer+yTBTQPOcHtBrYGx9vTmb+JqyP0a0kl9nn+3pu2ZxBvNy6nbhmxVVo1avhEPWxEMg0zS9XwqWFKCEnycyBHvTf+wHRRw4BZCsG8mpjqEwc4UbZ0wqRSyc6UuSRu0/C1/TlzjX68Qe8IB6UR99OMKRUsB5veqDxTrsdMOXZmWUhmfttbn4QurcsuHLippnuFq0MbV5AXA2MLFDK8hnXy4xu3ZxqKwisd5NdOceGfLQ3NA70727k4C0PGxO6Kt3Txhu502HAqfGlwdIaAQRfxjhC1wU5M4FpfcgJReEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=88xEHiBEVr39Zts1sBmGULFz0TYB8urq3qjePRyne8s=;
 b=CdMCi4liZJxVSXaD2S0Vq8a5rWMf6GtOsvw564TGWO0JEeFuBq9o++N0xg5UVDZEGXBfsx6VYHKtvi9Sdqxcx6gHtblEsLZbXZ3CkP4IexyqOZqUJVnd5VR9iWp7iFRsI25lj7wyQw9AXkhTF6fEdntPaRaUNU3pC88HRBhNxIcsL6s3l4fYgGpvig7K6JLNgjOmNw5vN3hTBh0ewkAMJkvqNPfCaBdpVSsSlImh9FAqTQLDj1NhvK5aLglaobgmECGPHD2fCzfuOml+W8HUP/HCh3Sz7lFxCianQ9ThH5Dmv2viksphOP1dludEH5LTqeHiIBkVQkO1JqKqFWvpvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=88xEHiBEVr39Zts1sBmGULFz0TYB8urq3qjePRyne8s=;
 b=Qu49oqFZoCJGIeYxYNUEnG9Z6taEBfno/eL76Atv2awPHq/zfmcgVDeskka1jbHj9+M50Q2dPnTdafbBsFgaxGRg1LG6gzUl9Ip5rt66mHSD0ihG4rTAGzWUX1hXSPmFxKgOQi0PVs3cDNUymeXTnnjAzeZgTlMhb/36ohAm27MZDpFeM1PrFlMnbB2B+yPzw/nTkLMtjp8q/maX9/8bm6y2tfzXji0S9HDsGtwY3H+jmd6VplIO4N81XPkb3zInNo7e0DfmUo9K0yvXT0UeUaTjtjyi70H487F22tSqLN2C066V2tZY1yDj3lCKjwax5YvvEsY+8/rZ9jearvqeEQ==
Received: from DS7PR05CA0066.namprd05.prod.outlook.com (2603:10b6:8:57::11) by
 DS0PR12MB7512.namprd12.prod.outlook.com (2603:10b6:8:13a::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.8; Sat, 18 Apr 2026 04:56:57 +0000
Received: from SN1PEPF0002BA4D.namprd03.prod.outlook.com
 (2603:10b6:8:57:cafe::75) by DS7PR05CA0066.outlook.office365.com
 (2603:10b6:8:57::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Sat,
 18 Apr 2026 04:56:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF0002BA4D.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Sat, 18 Apr 2026 04:56:56 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 17 Apr
 2026 21:56:46 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 17 Apr 2026 21:56:45 -0700
Received: from nvidia.com (10.127.8.10) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 17 Apr 2026 21:56:44 -0700
Date: Fri, 17 Apr 2026 21:56:42 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: "joro@8bytes.org" <joro@8bytes.org>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"xueshuai@linux.alibaba.com" <xueshuai@linux.alibaba.com>
Subject: Re: [PATCH rc v6] iommu: Fix nested
 pci_dev_reset_iommu_prepare/done()
Message-ID: <aeMO0whi7pPKE7FH@nvidia.com>
References: <20260407194644.171304-1-nicolinc@nvidia.com>
 <BN9PR11MB5276D60096EBF15C5753C4BB8C202@BN9PR11MB5276.namprd11.prod.outlook.com>
 <aeKpxLiykT8O4k1X@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aeKpxLiykT8O4k1X@Asurada-Nvidia>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4D:EE_|DS0PR12MB7512:EE_
X-MS-Office365-Filtering-Correlation-Id: 92502749-c071-4dcf-cdfc-08de9d06eaac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	EFtj9ddkn2xo6lJW9sIkZ1h8qy5w1EBq2bcrvoDZ3KBkWlSQH6bhcL2CCEp3pI1U9INvdwnAOGpNGEXroJzXEXv7xQwcwTDVGVBrT2V/Wjvp3G+G8PwU2TTRjbGFLRiRAmcQes/zp6UrqKbYDnhfZTpR6AL5w/zRf/3rkdOflEmQ+TjDkAmvDfC7MUrE2Jh8J2Wld90tMQsRzxHoJgK9/27uGr8wOQXywQB0aQRLTbAhKe3yqcjC9uC3tmu1rCuynNxC/R98lnlImdxcjSSO4LMQPwACihKCujnOeoq6AnUmCgeo4X4FU1kYuNWAwJbrukTPPq1F6I2dDY0t94YMTj/MWYC3k9A9uGAQ/e81gHGAflwogc6s07zVIYbD7aAjUVsgOwYHioyO06QnUlaXMFcv7dMd1gQyxIYlL+yNFjngOU1GpGDC5+g/RhKG0Zd7SKvpiczKAMP6piVs7K/8QaDvHn6vbICOMIEJAuvrsca3eufNyPhuz71HFf3AKQpITA8PL0NPY6EsotfRQC4UWLjJ+KcGWdASwk8nDk5ooe1NeCb6+7iXVLCzRzQP2TXoWHzRBv2lCcHTfR0JeY4vfO5HxVxJxIzIYFF6Cny65TD955L9u0tqURvY+ihspN8PsxdXLUBK3b+ei3Ep9Dl1cGhNO5U+56S/qKbqEV1LOvq0t9Yqvupul8vmmvJukUpLfQ2l7lLJ0Qjnh7CSMlcaq6qkxQozhmXLGl/b71glJMoPuqlT2C3loLvcZWuDTrgxpOndOsWD3aMBTu8gVx4i1A==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/pnO6npDOxYyUXzFqneDoNTs1TtRnXotd4XQxAjhmRQyMD1f0+Dt0f8iyDdkoKVcGmY9wkxCACKl/xeoGDxiw1s2rcCcV9sThtQ5ro3vHtDCXqX1tM2zwSKrKZLaJu2ap5cawygZ86P6tUaj2x7PUVvZ93X3GgKv+9TJdoQexJcS0Ug6FogshCzo+gL78lKo+0aL2yu3PDw44yJyoZ1zbr98GTC2fx+w9Cpr29+Ovv5Tq01qPAlFfy3vrSky2xl+qM6nF5QVaWv82K0lBYEz9vbn4d/VAHnlfeq4AvVAvfdmyu/Y/i+PUEapoJaV3N/V86hdcehEhskIoR9IR8a4H0cBYg0dGtoinmphywLA5GotqC5LyTutm9/vGAfQCLJYEHrS0MQ/fMptY+vye6HAmvZE9QsW71LoOpw/mbFT3Kh3ZZHtG9j62tuwblLWIt2l
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2026 04:56:56.4468
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92502749-c071-4dcf-cdfc-08de9d06eaac
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7512

On Fri, Apr 17, 2026 at 02:44:41PM -0700, Nicolin Chen wrote:
> On Fri, Apr 17, 2026 at 08:24:27AM +0000, Tian, Kevin wrote:
> > one is that iommu_detach_device_pasid() is not blocked which can trigger
> > devtlb invalidation in middle of reset. but it cannot fail. so the right fix is
> > to skip the blocked device in __iommu_remove_group_pasid().
> 
> Yea, squashing this:
> @@ -3556,3 +3559,4 @@ static void __iommu_remove_group_pasid(struct iommu_group *group,
>         for_each_group_device(group, device) {
> -               if (device->dev->iommu->max_pasids > 0)
> +               /* Device might be already detached for a device recovery */
> +               if (!device->blocked && device->dev->iommu->max_pasids > 0)
>                         iommu_remove_dev_pasid(device->dev, pasid, domain);
> 
> > another is a use-after-free concern upon iommu_detach_device() in
> > middle of reset. In my thinking it will trigger WARN_ON before any UAF:
> > 
> > static void __iommu_group_set_domain_nofail(struct iommu_group *group,
> >                                             struct iommu_domain *new_domain)
> > {
> >         WARN_ON(__iommu_group_set_domain_internal(
> >                 group, new_domain, IOMMU_SET_DOMAIN_MUST_SUCCEED));
> > }
> 
> Yes.
> 
> > but I haven't got time to think about the fix carefully. 
> 
> I think we could squash this:
> 
> @@ -2469,9 +2469,2 @@ static int __iommu_group_set_domain_internal(struct iommu_group *group,
> 
> -       /*
> -        * This is a concurrent attach during device recovery. Reject it until
> -        * pci_dev_reset_iommu_done() attaches the device to group->domain.
> -        */
> -       if (group->recovery_cnt)
> -               return -EBUSY;
> -

On a second thought, we may not simply drop this -- IIRC, we added
it particularly to fence a case where gdevs share the same RID or
some corner case like that?

In a conservative way, we can still reject concurrent attach while
allowing the detach case:

+	/*
+	 * This is a concurrent attach during device recovery. Reject it until
+	 * pci_dev_reset_iommu_done() attaches the device to group->domain.
+	 *
+	 * Note: still allow MUST_SUCCEED callers (detach/teardown) through to
+	 * avoid UAF on domain release paths.
+	 */
+	if (group->recovery_cnt && !(flags & IOMMU_SET_DOMAIN_MUST_SUCCEED))
+		return -EBUSY;
+

In the detach path, it'll move forward and skip per gdev->blocked
inside the for_each_group_device() and defer the attach to done().

Thanks
Nicolin

> @@ -2484,2 +2477,10 @@ static int __iommu_group_set_domain_internal(struct iommu_group *group,
>         for_each_group_device(group, gdev) {
> +               /*
> +                * Skip devices under recovery: they are already attached to
> +                * group->blocking_domain at the hardware level. When their
> +                * reset completes, pci_dev_reset_iommu_done() will re-attach
> +                * them to the updated group->domain.
> +                */
> +               if (gdev->blocked)
> +                       continue;
>                 ret = __iommu_device_set_domain(group, gdev->dev, new_domain,
> @@ -2513,2 +2514,4 @@ static int __iommu_group_set_domain_internal(struct iommu_group *group,
>                         break;
> +               if (gdev->blocked)
> +                       continue;
>                 /*
> 
> 
> > the last one is trivial that goto and guard() shouldn't be mixed in one
> > function according to the cleanup guidelines.
> 
> I don't think this is mixing. The guard is protecting the entire
> routine including those goto paths. So there isn't any goto path
> that is outside the mutex.
> 
> > Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> 
> Thanks!
> Nicolin
