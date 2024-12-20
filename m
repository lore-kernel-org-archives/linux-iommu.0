Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D3B7D07D
	for <iommu@lists.linux.dev>; Fri, 20 Dec 2024 06:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734677911; cv=fail; b=cUBQr7Dk94CgborsXxuYxg585R+ahwX4nawQyZadX73Ls0SEALMhc/I9ethOm81Y8B1ZNk1EPAruD0lEGj3PFqb9PrJlOg5CY9U0icmyJluFmnRqSiXnDHoSrV8b0VyWJvj07G+XmwwjLquvRqNxdac/bXlWuDhKlmFBdAyILHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734677911; c=relaxed/simple;
	bh=FyFl0KZmJGp5HMsoUQYHmNpM8XX/h8GgIJdRby4X7sQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qP6b5YEdWrJLxq3JzTplR6Obd+ieo3GYLBHJSTuJ2MswrL5m414ksBkr6FqTF7w12QfJpIcjJc+3Hd//Gad0u49tWnY/BWV2eNzfQg4RkdERFCrAkNZ1tsDweg0o/Nf885CUGrNvJYPlZ/vk+cuB8skvaHLIHQ6BQP6NNAVn/dI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WfrjuBo1; arc=fail smtp.client-ip=40.107.92.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WfrjuBo1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I6WlG/b1oo8MG6w78oOAr/z682imY+lgaJ3MQ64a8iL7XH/h2YDxHYEgoywcpTBQR6MpVqHk57XT6T78+mmZAEnqtSilsve7jZVJXlWKzXRPJPFAdpVr82u/ruhvukc/KAxGQe6GvOLHUWmdIjHz/ZVUPqBeH4DOznC/79e591LM6BNweV+5GdpKmhN47pWuSTCWqUWy5EuTczsKuvkh9LVWF4LgvSUzM7I+zUQpDnr5UzP7dgQukpEQ5f0SPtvmtbAP84rkaGQtuuFMp8EOp6cYluRjh9DRwxrv7RraRtrp2v3bB3ljoKWXQlJOyP9l8nvBPI+7wFjHwojGbLOczw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XE+jZ9u6DyVUFvD0gk0U4t03jCbGHmElOYpe5QVXxwU=;
 b=WBZTp76jVV7irYG5MRz4uNXxp8gKB8XqptrtmfAwzL+wSNwl81wdeegWINhz8IuXzgCYY+AqOpypwLp0PWEn6Meb0SJIBG65hOJusoBqVz8FMqffSzNt6L3eZMiS5QlpW8GdU14m/cIkkSA4hluv9qrTkjSrlEVV3dIrKlOBj7HAw8b/lKO4yyrr1wek/sAg76HY+4bLChr0VDyp3+FV1Q/Vb92KAYTHnVlzk96jgl6awRyPyAuFN8rQKqh9aSoUNZbUUj3yn6wAI/MLdybQsePp8/xJukEKRZ8uuXMdaj4qYb69SOpD+xI6wPXhnG0pCsr2q/890q7InEHthGkGJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XE+jZ9u6DyVUFvD0gk0U4t03jCbGHmElOYpe5QVXxwU=;
 b=WfrjuBo1pVfiP7gh/LokCCf53tHCnVLIs7B8S8C1m/sRXOdb/YOfw3ODONDc10lg0v+dm3u82ZXf4hqH4j2lnVXzejc29qvHwZKLcyPj9nZttUdTw7dXRqnFTparzdsuOzJa1syNbUQQslOE60prKclFssRKz6sF46IxATHsujyEYNsi/MWS2Fl1aXtPjqruS29mJvYwmjKhv3Fce2y+nAnfCJbsH2eiAo1WI1BUX7g30P4OBqgPb30o72SlmdhYf0WdyAGjqLPZE1C74+XOVreBLpm0id2Q9XvbwfXMIBujkpF1Gbwob+Kwv838GC/zXFOkx+6MKOcZMAwyhwQhlg==
Received: from BN9PR03CA0906.namprd03.prod.outlook.com (2603:10b6:408:107::11)
 by CH3PR12MB7739.namprd12.prod.outlook.com (2603:10b6:610:151::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.17; Fri, 20 Dec
 2024 06:58:19 +0000
Received: from MN1PEPF0000F0E0.namprd04.prod.outlook.com
 (2603:10b6:408:107:cafe::25) by BN9PR03CA0906.outlook.office365.com
 (2603:10b6:408:107::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.25 via Frontend Transport; Fri,
 20 Dec 2024 06:58:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000F0E0.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Fri, 20 Dec 2024 06:58:19 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 19 Dec
 2024 22:58:06 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 19 Dec
 2024 22:58:06 -0800
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Thu, 19 Dec 2024 22:58:05 -0800
Date: Thu, 19 Dec 2024 22:58:03 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
CC: <joro@8bytes.org>, <jgg@nvidia.com>, <kevin.tian@intel.com>,
	<baolu.lu@linux.intel.com>, <eric.auger@redhat.com>,
	<chao.p.peng@linux.intel.com>, <iommu@lists.linux.dev>,
	<vasant.hegde@amd.com>, <will@kernel.org>
Subject: Re: [PATCH v6 04/14] iommufd: Always pass iommu_attach_handle to
 iommu core
Message-ID: <Z2UVe/uQfQXUmZ+N@Asurada-Nvidia>
References: <20241219132746.16193-1-yi.l.liu@intel.com>
 <20241219132746.16193-5-yi.l.liu@intel.com>
 <Z2T0K5BXSCVgxwkA@Asurada-Nvidia>
 <02e60436-e93d-4452-9446-b0fc6e4c4192@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <02e60436-e93d-4452-9446-b0fc6e4c4192@intel.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E0:EE_|CH3PR12MB7739:EE_
X-MS-Office365-Filtering-Correlation-Id: f4b8fe13-9961-402e-87b9-08dd20c3afb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?y+agkUODwbN+6kKMmchbyUGq5RFliBwKwx8XhkEsclYb6xLvkTb5xvNnVzoK?=
 =?us-ascii?Q?Yjzkw/4UcFmA+2eI9UYmnlnWz/AH6+S1sKC6aG7x8fWqF0FOGkcYo0u4j18R?=
 =?us-ascii?Q?0blq24xcE8LWQWbQBmFlP6saHjrMitekP0LTQm7eqywYrtro8Me4jbMIdZLV?=
 =?us-ascii?Q?jtSPjdd55p0w03vKeOJFcprOg/wKpvcjdYBcM+LtTK85ohGNSxSvrFILGqry?=
 =?us-ascii?Q?wY53FBG9xKG5XIhb7mEESM8fqlnXv019pLdpHSLo5EVLJF0SPxNBALelTivY?=
 =?us-ascii?Q?7jg+FKD8rSJG8EDX8ZN/02vp1Htlke/NYOS4y2RSrcPGPmXnxJFFaIyTFaxF?=
 =?us-ascii?Q?mvS6AZ+iloJWS1EAdmwMfbkCC7iVuCJ1KAsIGNVHxIc4Bbp5Oe7zqLUjT7vy?=
 =?us-ascii?Q?SfSINKYfMId7ajOht2dJ17I+n5a8U4EtsIOkNgAeRqyP/Gl8yClIxupuUaNP?=
 =?us-ascii?Q?4Bv0ijy6edQM3KTOmr/HfbzgGiLttJNIbaX7tE3uF7SSY8G2Pi4+dSDlrsbd?=
 =?us-ascii?Q?U74fsEsxW11yIGYriGehVw7XhOHEDw3wOuA4vKX9HICySVRAl2BpTZ2v3Tyy?=
 =?us-ascii?Q?KPBpobPHSd1uDne+JSWXpfDvqt0SNRrGhmFR+nFm4dKUNYDmkwRIJ1kv+bG7?=
 =?us-ascii?Q?tChAZU/ltsnzELwW9rbQFx2Ao98GklPyLPyysavcGD+1bk1sc+NFRiDCqRBa?=
 =?us-ascii?Q?TL4QWM6E/jCEcsi2yY+MdT/jJGRO6zLEX3VVbR7mza0zeAPNYXCElPNokQ8h?=
 =?us-ascii?Q?xMCb++Kzumw4wIbGdbQWP2zo+4+4GVu260NEUw2ho4axk3RkuX95wqwSklnN?=
 =?us-ascii?Q?sjESjo+PSQPo6zpBFjh0UMjl/uSo7G4Rf3oPsj7L6blpt10rSRJ92bjjhjVJ?=
 =?us-ascii?Q?5lRWvUYFCQpMku17lnO2WqKZob7Rxg5/9fm+xDKcw/G0SEbxUl8FP1yfCmii?=
 =?us-ascii?Q?pNlMVloocgTOO1iQV2WaVOe55MR12d/cLfaDIx7AscUbTUBXBQkZE20J7Xp+?=
 =?us-ascii?Q?+vTl7KbxAJP9NHCOmq93ZyNVVTSeJQnzK8GKkr0nfMVg9Um9TDbTJBD91U1O?=
 =?us-ascii?Q?7P1/oK+AUYcqDU1xbK9bhMqnmVRCvTnWJZZ9fFnGkel55Yqb5ax7G6vFFbc0?=
 =?us-ascii?Q?Dm17XJz245TmgDow/sqsm1JRYQhtweeFaIqZUbkTgGLJ/46lOx9mKhyAZJ81?=
 =?us-ascii?Q?kKHBsJuaPgcINiMYgKv03i+KIGFXpRfwWbw/WR5zgyisiUl6MiOkfdaIC7+P?=
 =?us-ascii?Q?/884VvkTTSnmTIGcksbIb2Eq9ZjsS/CHHB+DVxprPnlVS9TUUTilppBV1fSO?=
 =?us-ascii?Q?jY+lvavzEFDMFIGAAxJC0AIl+R+fU5E+9PIwj814E6/t5Lqn1+JG8pPR9OaZ?=
 =?us-ascii?Q?9JcrJKrQulC0E9PUJOSWSF9EUah3np1i+5wY2TS+V7oTWxIIDf9vWIs/Yd4h?=
 =?us-ascii?Q?xpZp6adOmeoR8QhTR/3H0vUJIf9Goo2A5jit5NxTH2yhH8dDRJTv2sguM8AH?=
 =?us-ascii?Q?9/smhk8d9JXWWrQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 06:58:19.2740
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4b8fe13-9961-402e-87b9-08dd20c3afb0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7739

On Fri, Dec 20, 2024 at 02:40:39PM +0800, Yi Liu wrote:
> > >   static inline void iommufd_hwpt_detach_device(struct iommufd_hw_pagetable *hwpt,
> > >   					      struct iommufd_device *idev)
> > >   {
> > > +	struct iommufd_attach_handle *handle;
> > > +
> > >   	if (hwpt->fault) {
> > >   		iommufd_fault_domain_detach_dev(hwpt, idev);
> > >   		return;
> > >   	}
> > > -	iommu_detach_group(hwpt->domain, idev->igroup->group);
> > > +	handle = iommufd_device_get_attach_handle(idev);
> > > +	iommu_detach_group_handle(hwpt->domain, idev->igroup->group);
> > > +	kfree(handle);
> > >   }
> > >   static inline int iommufd_hwpt_replace_device(struct iommufd_device *idev,
> > >   					      struct iommufd_hw_pagetable *hwpt,
> > >   					      struct iommufd_hw_pagetable *old)
> > >   {
> > > +	struct iommufd_attach_handle *curr;
> > > +	int ret;
> > > +
> > >   	if (old->fault || hwpt->fault)
> > >   		return iommufd_fault_domain_replace_dev(idev, hwpt, old);
> > > -	return iommu_group_replace_domain(idev->igroup->group, hwpt->domain);
> > > +	curr = iommufd_device_get_attach_handle(idev);
> > > +
> > > +	ret = iommufd_dev_replace_handle(idev, hwpt, old);
> > > +	if (ret)
> > > +		return ret;
> > 
> > These inline functions feel heavier after this rework..
> > 
> > I actually have the same patch for a different reason, yet haven't
> > sent yet:
> > https://github.com/nicolinc/iommufd/commits/wip/iommufd_msi_p1-v1
> >     iommu: Turn fault_data to iommufd private pointer
> >   =>iommufd: Make attach_handle generic
> > 
> > I think we can align with each other on these functions with one
> > common patch: my series requires the fault_data and attach_handle
> > are common to all HWPTs, v.s. exclusive to an hwpt->fault.
> 
> yeah, I'm ok to move the helpers to be in device.c to avoid inline.
> I've three remark on your patch [1]. I'm now also considering to do
> the work in one patch, hence it might be better for review w.r.t the
> comment from Baolu [2].

I replied: I moved attach_handle out of fault functions, leaving
them to only handle fault specific routines.

Yet, you might want to fix the iommufd_device_get_attach_handle()
in my patch to a normal function where NULL will be returned upon
an IS_ERR(attach_handle) v.s. just a to_iommufd_handle, which I
just realized a minute ago..

Thanks
Nic
