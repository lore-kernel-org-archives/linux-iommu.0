Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2052.outbound.protection.outlook.com [40.107.212.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5065684
	for <iommu@lists.linux.dev>; Fri, 21 Mar 2025 00:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742517367; cv=fail; b=BN7LImX/PJ+vJ6Us+xbRHlptHY8h07D72xaP6TD1xwoooLoQVZy4hOGOjlk0mTibp7awE7sOEYgLVSw9YoQIBn3SFsGO9jMy4/4vzwoV1uIKPuynm5V1Msim2uSQD9efknhIdyvEpDnQYpCRg35eYEpNKc1n0BlA5dhXZd8t4LM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742517367; c=relaxed/simple;
	bh=R631hTUezui1G7psNl9yGp9pq7DytMzWw61AMMNL0jU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VYLb5o0fmbjSqOHjY4nwUc5ot0xhaQXWrrUDm6/LFJ6BrfNn30m+6WQZ2+PC2+INPkPlE9t+q+QxYPp9idl78Kvqav7U6oKd5uzeXfrJKlH+Knms9deUSI8cRZE2A87jFHnNBETlCxhj6X2V88Rm8jV1MAFzr/F3QbkcBtRL7/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LSlItraO; arc=fail smtp.client-ip=40.107.212.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LSlItraO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nckCj+eWeSHWtUubzrPBn0EX3p+cs21vWWjWewidV+5deURnEXY9OxUmh5VBGvCLvZkFlnI8jVBbajYN2t//VoAa6tsQAaARA5kdlzlfcZIgOhTUqQDCbkFnIJWOpJtG9PGOa8X2b3aJYE//z0oeuG41MypgoGk4NgJuqsUOXdqg95S2ZW7cNcRYC3NPywJ+I+jrOpCJseMn65JGsYxueqmFoKvpN0eR1LWxJ5FJ6W4VQXAIMKnhybx6g98l4AVwL+14hzOFavo65BehbFi8ao+IoamrpWzj/wZrMr1J4xjAFb0Q7uhbGBQvBNZUnennJguTAXqGUAoqklrqnD7mSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y7pIvUbJpp0t6MMRVzV9+2KtAqOYlJL3eKwc02r3BpY=;
 b=JeJ6nPkFb6vHE9sjsDcbv6yJ8kE5VjN0mmimdi+vqYoaKi6lJvGgactCAKsL03Xq3n+SnW9lg3UzIyaumOlvQD2OXoldjlUyyOgaAy8LAtLFlloKsD602ABqeXwkwidtyiOCkRMk5HPv6rd0EfL2LDt1yk4UcSQWdrg111CrdGXa+eUwFvL8Dx4AFoQ7ziBt68+MS2PuMRe3D5Xn+Z+fWKILnYoi2anSSsHvf4R11pfybO6vXgWEukOJU0ww4DosZtvM53yoth3YJ8B4vzzo3zojyTFE39vMUcXUTaJxuS6trEJzzP1XwPSNctZy4A/hr/jtmIAbQEtMtnTWZ9V+Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y7pIvUbJpp0t6MMRVzV9+2KtAqOYlJL3eKwc02r3BpY=;
 b=LSlItraOv/TCvCaR9O6wyxqJd/lqgOzmiYmAbPfrY4z8Nu0jzAs45tGu0+FCCxolANUdthRQdvjnMJHk3PNiTm0HdWhXlRzT8CGf/RXYFhHYs1D/osqkLJGFz3fe75jnbt/uAc2oLARvL/9+IKA2FyyNqQZ7Km4NxfwZtV+d57kGoOwNnv5/4zhq0Cl/kYb7Ui75okvaWAiqsSJ8k8b3NW7K+9+fXf/5+qMLMHVaOsYNW2YrmfOjtlcJUN1k/pCDUScsMp66kPoxBShJC1ma+9wxkqSf1fBc9j+Il+OHklr2GmaDjKiyDeqK1YshmtVMV1yvyS2clfwksXDFEeLDCw==
Received: from CH0P223CA0009.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::35)
 by SJ2PR12MB8649.namprd12.prod.outlook.com (2603:10b6:a03:53c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.36; Fri, 21 Mar
 2025 00:35:55 +0000
Received: from CH3PEPF0000000F.namprd04.prod.outlook.com
 (2603:10b6:610:116:cafe::cc) by CH0P223CA0009.outlook.office365.com
 (2603:10b6:610:116::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.34 via Frontend Transport; Fri,
 21 Mar 2025 00:35:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF0000000F.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Fri, 21 Mar 2025 00:35:54 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 20 Mar
 2025 17:35:41 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 20 Mar
 2025 17:35:41 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 20 Mar 2025 17:35:40 -0700
Date: Thu, 20 Mar 2025 17:35:39 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
CC: <kevin.tian@intel.com>, <jgg@nvidia.com>, <joro@8bytes.org>,
	<baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>
Subject: Re: [PATCH v10 11/18] iommufd: Support pasid attach/replace
Message-ID: <Z9y0WzIo4Edu0D9H@Asurada-Nvidia>
References: <20250320134744.5777-1-yi.l.liu@intel.com>
 <20250320134744.5777-12-yi.l.liu@intel.com>
 <Z9x9sy7s2u18wVrG@Asurada-Nvidia>
 <783d69d4-5858-4699-812c-b8495a36e9b5@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <783d69d4-5858-4699-812c-b8495a36e9b5@intel.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000F:EE_|SJ2PR12MB8649:EE_
X-MS-Office365-Filtering-Correlation-Id: 11014f52-3105-4b0f-2bab-08dd6810572c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?koSf/DrgIMFGbQfWsSrA6A0oa+sKGYR4Isn70RwlhvwgkoOjB++UuEdEqr35?=
 =?us-ascii?Q?sGe/007SuFbt/shpoIhiqQzdViBmsoNOc/RvF0S79kvbzOMzUHuLFsqWj8/z?=
 =?us-ascii?Q?pozwsk5iM0D9S/NP+/nCdWvpxRYs+iPPstZ66dJEkUFAyUN+CVMRIQfdwOWa?=
 =?us-ascii?Q?AWl00F4EKPfmts56Csf/kCKDrMsWJVZL6Fj9lPh5t67VsQRp2BUe12siU/qE?=
 =?us-ascii?Q?S+cT4VBFrGbQzu+2u+RM3GdrY+PpN2AH7prFmGXztsUD5j4/AeAHts1MLtlF?=
 =?us-ascii?Q?YHh891FaPddD/sTlS5/oPSSPJRjL/e8pbwhwEozUUru84hUC3lVlB0WGaqRn?=
 =?us-ascii?Q?eU89oU/LaTavQ8g+IGMo3TqHxliRFjEhgbDuqmLA47R8dLEu/5vKjSYMEgab?=
 =?us-ascii?Q?DASvD0P2p0IMHKEpONwzmtxO0wSTHHmY3oAAvXOuO02w9W7nvBZu7fQ/kRtR?=
 =?us-ascii?Q?7LTKi/K71sYU/oYSI+1XIt/CqjpehjoGxqASZDUwR3x+riR9ApA3iOBUVALV?=
 =?us-ascii?Q?i9RZJoTOiFkNXlVoai3R0Csu8GW7qSKSSxva8o4hP4bnflcIv96ZDrMLrAw+?=
 =?us-ascii?Q?4twLrT19aqgfsVePpd8ONzjOoZPsbNlV6P3krvFaxl5ydbOAC5jZj0GpiokS?=
 =?us-ascii?Q?vFpX797YeFP41LZqfJUIWecbRz3ay/onZQX33zrhDqsyB3Eo2Ox+vba6K+/W?=
 =?us-ascii?Q?ZlC2KTDFuD47KGpVt4p6igpG16T6t4LQr9TMTj+BVf55NZXd75CFd/q/DrVD?=
 =?us-ascii?Q?d8lHYxS4BAcSyaI1Lk0FagiYvreE5EGR3BxsK6F9vYuBI+WGMM+zxbCntEaQ?=
 =?us-ascii?Q?ThQ76zMf6J3MJf1UoAmNyAaWQV5D0RAfg30gmW4xgyPhEy/CKx5KJtGtP+rV?=
 =?us-ascii?Q?DiVmmzftjOPeY0IURTi6hcO+rC/pzG5cDV/K/mQjhtO58KSpGbd0+jRMXT4U?=
 =?us-ascii?Q?4O84qdODdKjscZ3BuOrWDY2KPrE3SuWKgI2FzPO38cA3o6cQrDKU+O8t9R5y?=
 =?us-ascii?Q?2RoCyKpnFj+/Bx1HdDTPRaF8WhD3CVQ/8ZA3wIm8AJUyH7ezl1ZukEKKKpJK?=
 =?us-ascii?Q?kQTx6olmXHlosTIf3vITnn74ty06AWo6hxwsPBq9nZ/rk1PV9/zwKPfUNBel?=
 =?us-ascii?Q?BL92ogbVRcVjN3UA5SDVhuj91c8LdCqxujhCIDBhtuXabskafTQpydYk5krO?=
 =?us-ascii?Q?lY+dwutBADiACw7gyEnpb6ByCI/FKChwjttsSgJcIIApw18NVM2VUccfAWPL?=
 =?us-ascii?Q?BmEAuKxo3ZQ+PTVk23ySsRocdOfQdJyP3cuSZIFzjci7y59oF9TO96QYQVLK?=
 =?us-ascii?Q?lSROxLdpiyQmRYTFFh+hcrHyFrQSgyaY8ROX0UtlYS1vqTmzQwrbfCQ1IDGX?=
 =?us-ascii?Q?Goby1uxUlY+mxVUTZJDhjFuoB9G6MqNiTLuNzGfHwuuKWTBttmVjvYRRI0RC?=
 =?us-ascii?Q?wPaGnB1EHjU5w6Nl2mpJ52XHnnjdscpytTL4TLZ85pavv//A1k4furGERiPt?=
 =?us-ascii?Q?3o72iBWqrxKPZsY=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 00:35:54.6037
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11014f52-3105-4b0f-2bab-08dd6810572c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8649

On Fri, Mar 21, 2025 at 08:31:23AM +0800, Yi Liu wrote:
> On 2025/3/21 04:42, Nicolin Chen wrote:
> > On Thu, Mar 20, 2025 at 06:47:37AM -0700, Yi Liu wrote:
> > > @@ -579,10 +582,12 @@ static void iommufd_hwpt_detach_device(struct iommufd_hw_pagetable *hwpt,
> > >   {
> > >   	struct iommufd_attach_handle *handle;
> > > -	WARN_ON(pasid != IOMMU_NO_PASID);
> > > +	if (pasid == IOMMU_NO_PASID)
> > > +		iommu_detach_group_handle(hwpt->domain, idev->igroup->group);
> > > +	else
> > > +		iommu_detach_device_pasid(hwpt->domain, idev->dev, pasid);
> > >   	handle = iommufd_device_get_attach_handle(idev, pasid);
> > > -	iommu_detach_group_handle(hwpt->domain, idev->igroup->group);
> > 
> > This changes the sequence of these calls?
> > 
> > Is it correct to do iommufd_device_get_attach_handle() after
> > iommu_detach_group_handle()?
> > 
> 
> oops, yes it is. It should keep the order. will fix it.

Would you please also see if this could be covered by the selftest
given that all designed tests didn't catch this?

Thanks
Nicolin
