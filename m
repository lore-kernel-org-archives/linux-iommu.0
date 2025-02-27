Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E969D4EB38
	for <iommu@lists.linux.dev>; Thu, 27 Feb 2025 16:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740673911; cv=fail; b=g1goC7wwqbscFFBGKT4DJxt8FbkOZso3GY5HtWysoE0vBMnamuIhjEX53Z7tjJ6u+TWwzgTvzRB7SPTuyE/g6tL3DWxGeoZSNMI1s4ruuUojGLsPZ9sePKVw70ZoMhcMhgo1i3pNB9ZtMBDY1YCu1ARLz09iKedm5q38XkcgUB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740673911; c=relaxed/simple;
	bh=P+bdEH5sQ1G/3i/QrlYstqrfxo5v4g/XjLKnKfCo+A4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XX1qxv8Xqqxv7i7j3nnOCg3Nu9gCTaG3/VC8WTKbcGpd9CXdzIdVORW9TtWQ0SY5laGuEW4ilczzvxWHayF4JwwrFtSF2WdMXLJOfaKVHQsdxaDoqKofkk4UIZdTqa8LClvCZYSle922Daliat78IdD9Z1WayLP+ULv4hMBBR+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=U1ztI04k; arc=fail smtp.client-ip=40.107.93.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="U1ztI04k"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h1VDxHltgtWPzZqT1hjbFbCodmaBSfrCXzn88xN+AfPx9X49YYbl6AKCRBem1/vIBwu0qlYj1Wgwq42QiLwuS5oQbvH7gC4tLrDn5/3SgZ98FRI8lmguupZOb5wwq5+7gz5Y4qRflhdWkUGgACctCV9GpqRU5vb+EQkrFVY7/0FQ9Pu8+v83KrOBOrVkUFaBUUL+686UU5Cmshm0g+snZujPQRm4oYa+1fs7XODkVtBBsQ0WkLRLNifNF6bdCLtiyMOwJa3YBOHuTTH+Yb3CXYautbrOFETjQPEK0lVPqO580N9s4nMUekOGeJEujKRhKXbrgH8TDOOwfCi0LrmoJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CZ36c1UJoAdHe+f3IUEejAJkPt/tdI4KMAA7NwCAdVo=;
 b=NK743gbiN3uS1fLCozBuj4PcCFZiBN6EJxnShm1hdupku2UqyVOPv/Yy60g8G5fIzOFIC92/41UgsvR0h3cD9A/UnVwWfoYvxYGtKzC3h+ii+v0VOgEXExhWfh8GqWu+iSlGGK5eoo7CowBmPG2MH7ADi5iu3ahmhVxyufliF91nditqPwcl8Tu0JB5Pu5P7K7O8dWQe8DwR0AkXoAbX5xpFSrQhKYk8FLW4zotwbUEw65gwcjclaqK3eEcGtjDgdKY6dGBCh098bZJjI95vv0W1eAJJ8nMfGNdUKac2KbEgViLzGSgr6FWURqHpC6wN9g4a8EXSkv+mgs/0kqx58A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CZ36c1UJoAdHe+f3IUEejAJkPt/tdI4KMAA7NwCAdVo=;
 b=U1ztI04k2Pd3/DM8E8bZoQs5CL/kBflcguUZinnFsYo9p5QWNoF9qX+HhvU4E1/mmJnkjtOHef8bZNB29rzIkVOyzCHlnYNlY/GWLotOBhmuZam2IeXg4OOwUm4lvj4RTWP3+/4H4SyJYaDKLkcFibUR0cNBP/7tPTrueRfWW4WKv8b8a5kDjccY6NhianMVHqKh1WS6/Iwg3xz02Az9L9FYdXOaTgiLAhnTAGHKW/UJAlF1PrWWLobKMkE/PHaduWs4Vw719MQfA0zjzIRAES1slNTF+xbOKvQED21H68oEOx/5Ugmf/oXKVdVIuq+wdsNtyGAzbyhBtY3NTiTWBw==
Received: from SN7PR04CA0164.namprd04.prod.outlook.com (2603:10b6:806:125::19)
 by PH0PR12MB8176.namprd12.prod.outlook.com (2603:10b6:510:290::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.20; Thu, 27 Feb
 2025 16:31:44 +0000
Received: from SN1PEPF0002636C.namprd02.prod.outlook.com
 (2603:10b6:806:125:cafe::5c) by SN7PR04CA0164.outlook.office365.com
 (2603:10b6:806:125::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.23 via Frontend Transport; Thu,
 27 Feb 2025 16:31:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002636C.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Thu, 27 Feb 2025 16:31:43 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 27 Feb
 2025 08:31:28 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 27 Feb
 2025 08:31:28 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 27 Feb 2025 08:31:27 -0800
Date: Thu, 27 Feb 2025 08:31:26 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
CC: <kevin.tian@intel.com>, <jgg@nvidia.com>, <joro@8bytes.org>,
	<baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>
Subject: Re: [PATCH v8 04/12] iommufd/device: Only add reserved_iova in
 non-pasid path
Message-ID: <Z8CTXk6mg742xdZ3@Asurada-Nvidia>
References: <20250226114032.4591-1-yi.l.liu@intel.com>
 <20250226114032.4591-5-yi.l.liu@intel.com>
 <Z7+sQOLeSk5hEcr4@Asurada-Nvidia>
 <1cf0cd58-3154-4412-ad39-0dab4b701ba8@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1cf0cd58-3154-4412-ad39-0dab4b701ba8@intel.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636C:EE_|PH0PR12MB8176:EE_
X-MS-Office365-Filtering-Correlation-Id: 723ade2f-1225-4ddf-3c26-08dd574c38dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?t+f8BoX9SLzGC6AKFYaG+1mfLajYTiGak6aA9fECyjy/D4qrU4cRtSLC1SiT?=
 =?us-ascii?Q?BySCK7POd7gSBwU+rTDZyIOxdyp/rJKaTtOthR5Fjelqq5k3s3rM608rjo2v?=
 =?us-ascii?Q?Y7c4iJ7BPThtoXOjEAatZdsKqP5LykRrif2csgXq2DSgRsFrqQF++BSsKVCq?=
 =?us-ascii?Q?Ddhpe7VdpOWCbrevN4LVlUmj1Bzh+7xdYlSvP15fXYWrfxUj2xHU53SK+9Te?=
 =?us-ascii?Q?mb91XJq+GeIDhkdvoAPQvp+3lrlqZR4s8WgpxpwJZidGiqb9HMcRhzjLdJzs?=
 =?us-ascii?Q?aCV7LEd2GVBFZRAxbOt0R6+p777nof+1tM+DyTZsEp+QT9VlHVOXcSVNdiNt?=
 =?us-ascii?Q?luPpdW3DvdriPH/ZghNSEupEBygr1lWj2xRhX/YRKWeTIQAzREvIOZ8RPk8q?=
 =?us-ascii?Q?0zRBf7tt3u9xibYcqa8ntb1tF1fCMVKB9mnXrKb2ddGTn6MUSTmlVxydpxMG?=
 =?us-ascii?Q?yJj8jM/LKPJBBnJcrjpWDqJ7JrQ7EOfGbDsb0QMPo6ab75ygc66sdUBIeYKF?=
 =?us-ascii?Q?rBgUQafAw2iBnY5dIUQv85ghkZzQGIaHxHFy4E/r/pGv5OGs9dFOz4WxHcLu?=
 =?us-ascii?Q?Gqh9/DEKRhsm2FswUt8A1hNqRKH840FQvp3jzl+oYZ1+FKTRuh30Lu3ChLgy?=
 =?us-ascii?Q?dVDLLYRrxNVbpoCDbPnHcKIRqUfUL/8/eBKtLUBhVIyzh7Kk47rQJLc1lV+r?=
 =?us-ascii?Q?VBYuydcbRDXVOvaTiV31kbXjaq6hMkwMwIpRow2X8BKwZcMSPbK5dn896Kjt?=
 =?us-ascii?Q?vX6sO0SXpZbAyV3qCLdLAOwtvLpk8Lgf0nXvLOMVqzRqcfHr1ifC/s4Y4ccl?=
 =?us-ascii?Q?W8FqOhuxxsLkVpHU8C8y29TSkTZfT9F+AfGAjUlnIpIUXuBoAxV1k2OmEzkp?=
 =?us-ascii?Q?NGs4z9qYpL1VLhlRqzj9qOND0espHOvulkTmE3nKpwTJz7b0luLVmGvEj0Vc?=
 =?us-ascii?Q?qB8XjAm6j2b2fgSJ/Uwoxr7G2j7+mxuKayeuu02jW2iOd6+7CIpwkaaRweOg?=
 =?us-ascii?Q?dill2ybmwW7IyNCAtlX2cHYWtDJgaoPO7FbKWPBeokl8RPuwvJ+HbdU4WIGA?=
 =?us-ascii?Q?QCzl8aU8tJG6p1cqUv06FoSyGFW2x9DUKnn98P/uGX/jDYld/+A17fJ7bDpU?=
 =?us-ascii?Q?QnUdua7slaHvJx57ihG2crLanWA2lUj6uvVQz4HQ573u5ttJF7bCwxJc2cIk?=
 =?us-ascii?Q?aPFLlv2EfmCj62vGz+c+3GjPXUZyo5FSus12sUuMhD9SwzdOH50/g6hvF2a8?=
 =?us-ascii?Q?BtTgzY1Le15FZZjQYR7TqCAJS9cq6Xw0RuPHsDnXkNotpdoEP57pEMvJrkIN?=
 =?us-ascii?Q?LqafGrYxUJ8tCTq7G5H4MkcPwFjsq9DqxJxB84GZNdKM/mv2TpQslF+3Q4JS?=
 =?us-ascii?Q?VgNGl14pwwqCLbQ8qEDtuUDpNuhME66S6BtIvIna1sCmwJGKrAHQAT3ebeNC?=
 =?us-ascii?Q?Vlv+vgPJDOtaCxH1lRdL5Dv56NwbuXEvoYDIDchsMxnIasRIIIYeqA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 16:31:43.8226
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 723ade2f-1225-4ddf-3c26-08dd574c38dd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8176

On Thu, Feb 27, 2025 at 09:50:29AM +0800, Yi Liu wrote:
> On 2025/2/27 08:05, Nicolin Chen wrote:
> > On Wed, Feb 26, 2025 at 03:40:24AM -0800, Yi Liu wrote:
> > > @@ -620,7 +622,7 @@ iommufd_device_do_replace(struct iommufd_device *idev, ioasid_t pasid,
> > >   		goto err_unresv;
> > >   	old_hwpt_paging = find_hwpt_paging(old_hwpt);
> > > -	if (old_hwpt_paging &&
> > > +	if (old_hwpt_paging && pasid == IOMMU_NO_PASID &&
> > >   	    (!hwpt_paging || hwpt_paging->ioas != old_hwpt_paging->ioas))
> > >   		iommufd_group_remove_reserved_iova(igroup, old_hwpt_paging);
> > 
> > I am a bit unclear about the use case with pasid and replace. If
> > we replace the old_hwpt_paging with pasid != IOMMU_NO_PASID, what
> > would happen those reserved iova on the old_hwpt_paging?
> > 
> > Or does that mean a device can multi-attach to one hwpt_paging via
> > different pasids so that only down the IOMMU_NO_PASID path would
> > it remove the reserved iova?
> 
> yes, and only the IOMMU_NO_PASID path adds it. So only this path removes
> it when the old_hwpt_paging is replaced or detached.

I see. This is replacing one of the domain in the per-device PASID
table, and only the master domain (PASID=0) owns the reserved_iova:

PASID=0 -> domainA -> attach_resv/remove_resv
PASID=1 -> domainB
PASID=2 -> domainC

?

Thanks
Nic
