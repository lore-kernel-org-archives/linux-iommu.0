Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B92917DFFC
	for <iommu@lists.linux.dev>; Wed, 11 Sep 2024 19:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726084372; cv=fail; b=jxvYnlfvkVPfJnhPjQb3GbHXEm4gMBR5L8YU8LvXtWglSY7WRd8yHAPAxsicbZ0/0SfwynJ8d2HmM8g9e/MfRdzRU1jFb9AavJsTuNDXrz+BuRv01ay3qcqk/lr5y5fIUS6nl972+ihcg7aDrf1HmnNdIlZ8G9OJ8Pz631FelZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726084372; c=relaxed/simple;
	bh=6eBLBaPlkUhXWNBUEZkqHrGZCH9gk2mccMKtIGRFFts=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iPi97m8SXmajRHniUyXxWhB5LQznmo6XceIe5odABjnOVzdXPZZAv4lZoll1VXTTGHhdRzgt4tT2gzF4/lqzjLlx+3jotdCB9/ogNsdKuhW9HD1ATF6rMhF6DB6on4M6enQAsVc9NAk6LwKrQShSnFH13MpoLpkDPltZitZ+nJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TGuVW6wI; arc=fail smtp.client-ip=40.107.93.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TGuVW6wI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KXiDMgzVAL1Yhe5hms01B90fd/cns7yLtK/twVchpEwM+YxOnRBsihqISdKMGoCrs2jxRh/4IoGNh12YSn5SFZtyJfmW8sv/cDcRaREk+S9/YhzYMJiJqf1gNreDsp09l0kxtQvH5kog1ThINZ8mPA7vUIVycnziYtUuIEcK7iIQoiaW18xs4W6CIY6/ryG+TxECldISKnAvYFUWmQGOqUKRvz95Kzgh9Umiy8x28c+BewDHUVCm+DVau1n+4WC8mF5sfxQaBkIGzzatej2j2/lkaLxQCtLZLZQJYBOgKlr9W3T3uNudKuSbp5wb+xZ9txNzfx/7Acqsh9f4GS1A8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C0KYMmtwimmIOZ2AoYDyDF7RGEXva8wqPLHX9Kmz5rI=;
 b=OnJUm6XFpF3TJYQV6oPUHzvNtKwOEFmDJJTlmygxgJiZBW07efbQiyMfSgCyDHY8ucmVatTU9ZLl9fodMTubIZpvFCEzDtXOCsQVsPRV/IMv8I4KqqysyHPElIQZWyH+yFnPff1/XmND8EoRcY0RWeuedhGFivcdcdM2KUWDpYRI+ldHKY6n2b3ld2Nqx0QohUWBRNDULCYXC2Cde8UQkNXB9IG48la3lCGN8T58Tu+IC8K6BpkvsHi2Khhs6grzJAziEuf4lqRYR7L9L6gh4bllsiIbZYL9wfDOTgdp5oBBWMzIzGOWRiUz80ozpvU/lb3HUVhOw4XwamHS5hvoJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C0KYMmtwimmIOZ2AoYDyDF7RGEXva8wqPLHX9Kmz5rI=;
 b=TGuVW6wII8tDMuEmAEG6YlKbdkahrR8GeYjm20Bc8EpZXpuJROXp4GrZQ0WkqhpzRtce5dJ0g97TY1Z+meTfdnTiKgDvOOc98EmZdQWChapaJ0r3h5eUsMZ6ULHg2wTgNUdKqcnFCxLdPizDMp+qpZrDSVixBHNRui8kpaihRpTzPO5iNHR0aroMKTkczHCpjveU2e29p3rQ6o1GE7/7jmCqAyrauXY7uv+nN0H5lXZFRIQefW0IZksEmH0WfQc88icZBpPAE8HtMe/FoF50kl1t74ixy0TjZMtNtO5J6bCdoYcEvGnK1Lu2Z/QJ+bHaa/oAoZXsYWvZmKXXvXduCg==
Received: from SA0PR11CA0187.namprd11.prod.outlook.com (2603:10b6:806:1bc::12)
 by DM4PR12MB6088.namprd12.prod.outlook.com (2603:10b6:8:af::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23; Wed, 11 Sep
 2024 19:52:37 +0000
Received: from SA2PEPF00003F61.namprd04.prod.outlook.com
 (2603:10b6:806:1bc:cafe::13) by SA0PR11CA0187.outlook.office365.com
 (2603:10b6:806:1bc::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25 via Frontend
 Transport; Wed, 11 Sep 2024 19:52:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00003F61.mail.protection.outlook.com (10.167.248.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Wed, 11 Sep 2024 19:52:36 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 11 Sep
 2024 12:52:23 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 11 Sep
 2024 12:52:22 -0700
Received: from nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Wed, 11 Sep 2024 12:52:20 -0700
Date: Wed, 11 Sep 2024 12:52:20 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: "jgg@nvidia.com" <jgg@nvidia.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "smostafa@google.com"
	<smostafa@google.com>, "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Subject: Re: [PATCH] Documentation: userspace-api: iommufd: Update
 HWPT_PAGING and HWPT_NESTED
Message-ID: <ZuH09DoinsRJ9sCq@nvidia.com>
References: <20240910204111.7969-1-nicolinc@nvidia.com>
 <BN9PR11MB5276142EF52299176BA3179F8C9B2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZuFHGHd2S+r6XzyN@nvidia.com>
 <BN9PR11MB5276C5EEA6AAF9540707AD238C9B2@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BN9PR11MB5276C5EEA6AAF9540707AD238C9B2@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F61:EE_|DM4PR12MB6088:EE_
X-MS-Office365-Filtering-Correlation-Id: 44e15f7c-a67b-4dd8-98d6-08dcd29b493d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eUJVQ2w1ak9CZFk2UXB0RitUMC9TbVNmVXFiTGRISWhkOHVkY2dRYkwwMFdZ?=
 =?utf-8?B?NzR2WmRkTktsNXJPczhuaUxLZlRsN2wwZzFuNjJNVHF1WmovUVkraCtHWWkr?=
 =?utf-8?B?b2l5OXljbFI3QW5XZkZiQ1UraE9rV2k4aE1EdFhtZk9COEFLL0VmM0poaEU0?=
 =?utf-8?B?a1hZSldnYUxGTWtzY0N4NWF4S1l0WEdSazNiV2hVdnI1NTB4R3BzbFFhY1NX?=
 =?utf-8?B?SDVaa2xHZ3N6b2dPUXN2UnNKZjBrVWJwRENqcGJ0RUN4emtpT2hpd0t4UURX?=
 =?utf-8?B?cTdxakIrcnFqOXZtOEZsVkowT3lIaHRWcklVd05JNFpNRmMrVkdjY2UwaUJ0?=
 =?utf-8?B?YVZSTFcwemNjUXFsNC9kM0lTRU5NYWpKZWpFL3dUdUt3U29FSnplQnEyQ0Jw?=
 =?utf-8?B?ZjlGck1wMTVqRVdqRFJsVFkwaStzT3VRNnEvTzI3ODZ3KzdxekJoTEhXbFJi?=
 =?utf-8?B?VWVZTktPbGlraHQyb1ZmNlJxQnVUYUF5NUJsV0c2YjNQVWE1RldDaEF5UFlW?=
 =?utf-8?B?RGdXOSt5ZnYvWk4vSEwyTzdYS2VVc213c2VSS2ZuRTF4UDU0MjJMM252c2lO?=
 =?utf-8?B?dHFhV0FxN2dqK2dLbGlRWUw3MEIrZ2JrVldMcmJjL3hCYzJVeEpicHA2aUpm?=
 =?utf-8?B?WmhyZEVtcDA3eUkxYUdDQ0lhbitNVktEM3F1ZG15cDVtMHNheDhrVG5nUUdU?=
 =?utf-8?B?MHpYaGh4MlpjcHBTdWN5cnRrWDFDQWNKcjRXR3dwRnpOR1p4bWtKTS9yV2p4?=
 =?utf-8?B?UWZHeVJDUTQzVW9ncU12NEdTZTcvY1k4UWh5WWxLN2JBcFlnZ0x6OE5MS0VL?=
 =?utf-8?B?VzFSbVhsYThFY3lYdVowZmdYbkxIaW4zZU9oZFI3S09VdGFXdHptUWdjdFBS?=
 =?utf-8?B?ZE5SQ05Yak1PSjlEUlgxNnNqUFFhaWZIL09hbFRkZXhpYUx5ZW5ydVhDaVNz?=
 =?utf-8?B?ZGxQWTJ1TUpGay9iZTNTZldLSXlFVFBJNlFMaWt3YUVtdlZkVHNPZ1FTYVdO?=
 =?utf-8?B?cStaRXExd2RDaVhlSVJTSWh5L2M3NzkwcDZiNnR2UmZKUG9CQ1AzQUtjMzFU?=
 =?utf-8?B?dW5NOTRZTHZ5aTNlNkxTRWRhLzhKNXVYUStSckQ4eGdpb3p2bDQ3OGN4NXc5?=
 =?utf-8?B?clFWYUNXZEk0SGhaZWtmVTRDSWNTTU5rRCtCYU1ieEtNSnlCQWZHc1oySmlY?=
 =?utf-8?B?RDhWOVp6cm1OcXhFTWUvZktocVJkWm91SlVhK2lLU0pVc3E3R210elVGeUxv?=
 =?utf-8?B?VnM5aHZYYS8wb3BRUlRveDNiUzY1UmNuWU9iSjNsSm54OGJrQ2hDakl5ZHdX?=
 =?utf-8?B?emk1d0xtWUtiNUlzZDQ0MDIvaXVrNFhubmRHVkxCNzhSUzZrUTYyS2JjVkwv?=
 =?utf-8?B?MmZhVGlRK0JyWlRKaVkwamxTL3RTS0NPWC9NSFlPLy9PVGlZVDFrVnB5eFBu?=
 =?utf-8?B?NFRnZmlMNE43UnNFOGQzdlJReFEvU2FSK0FDQXNkZlc1V0hpVmhlU1VxSHI1?=
 =?utf-8?B?TGs1aStndEJMUitoNVhJUGJhKzAwMlhiaU9pcXorcjcwTjJ4cGRwWE5ManBx?=
 =?utf-8?B?d1hRaG9iUE9DQlRNdFBVSWs0SHh6d0lnYkxNaGdqazRvck00MzY1UGtvVmVu?=
 =?utf-8?B?alBoVHRxYlRiWk5OZVovMFVjc2tKdGtoSjZSZitCYjVDZkw4UjN0UWp2eTMr?=
 =?utf-8?B?Nm1rdEdiWWZ5TjV4QXYzamxSVVdya0lXZmVHOHZOc2JRUzFkSzJob3lBTTA1?=
 =?utf-8?B?eTRMOHJYSnMydzNTMGV3dk11K0N0OEdVVE1sdkJ4cXpKMkhqVktNREdWc0I2?=
 =?utf-8?B?aG9ibWlwWURYbTZUeWdFVTIvemtadFNQaG1qK29XbEQwczBtbUlwb3lrbkpN?=
 =?utf-8?B?OHNEN1R5bVk5TmRNVkZTekxYLzhjOTBEN2NxU3ZFYWVYdUVsVXFIOUh2TG1v?=
 =?utf-8?Q?oTbJd2FBnvWhnpq1T3enf4ghoNhqOTHN?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 19:52:36.8898
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44e15f7c-a67b-4dd8-98d6-08dcd29b493d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6088

On Wed, Sep 11, 2024 at 08:06:48AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Wednesday, September 11, 2024 3:31 PM
> >
> > On Wed, Sep 11, 2024 at 07:09:15AM +0000, Tian, Kevin wrote:
> > > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > > Sent: Wednesday, September 11, 2024 4:41 AM
> > > >
> > > > -3. IOMMUFD_OBJ_HW_PAGETABLE is created when an external driver
> > calls
> > > > the IOMMUFD
> > > > +3. IOMMUFD_OBJ_HWPT_PAGING can be created in two ways:
> > > > +
> > > > +   IOMMUFD_OBJ_HWPT_PAGING is created when an external driver
> > calls
> > > > the IOMMUFD
> > > >     kAPI to attach a bound device to an IOAS. Similarly the external driver
> > uAPI
> > > >     allows userspace to initiate the attaching operation. If a compatible
> > > >     pagetable already exists then it is reused for the attachment. Otherwise
> > a
> > > >     new pagetable object and iommu_domain is created. Successful
> > > > completion of
> > > >     this operation sets up the linkages among IOAS, device and
> > > > iommu_domain. Once
> > > > -   this completes the device could do DMA.
> > > > -
> > > > -   Every iommu_domain inside the IOAS is also represented to userspace
> > as
> > > > a
> > > > -   HW_PAGETABLE object.
> > > > +   this completes the device could do DMA. Note that every
> > iommu_domain
> > > > inside
> > > > +   the IOAS is also represented to userspace as an
> > > > IOMMUFD_OBJ_HWPT_PAGING.
> > >
> > > the last sentence is redundant. here we are talking about how
> > HWPT_PAGING
> > > is created so it's implied. probably you can state that HWPT_PAGING object
> > > is created when talking about "otherwise a new page table object and
> > > iommu_domain is created".
> >
> > I don't quite get this part...where is the redundancy? And where
> > is "otherwise a new page table object .."?
> 
> the original text:
> 
>    allows userspace to initiate the attaching operation. If a compatible
>    pagetable already exists then it is reused for the attachment. Otherwise a
>    new pagetable object and iommu_domain is created. Successful completion of
> 
> it's clear to say that HWPT_PAGING object is created upon successful
> completion there. Then naturally every iommu_domain in an IOAS
> is represented to userspace as HWPT_PAGING. Not added by you
> but could be cleaned up while at it. 😊

I see. I did this:

+3. IOMMUFD_OBJ_HWPT_PAGING can be created in two ways:
+
+   * IOMMUFD_OBJ_HWPT_PAGING is automatically created when an external driver
+     calls the IOMMUFD kAPI to attach a bound device to an IOAS. Similarly the
+     external driver uAPI allows userspace to initiate the attaching operation.
+     If a compatible member HWPT_PAGING object exists in the IOAS's HWPT_PAGING
+     list, then it will be reused. Otherwise a new HWPT_PAGING that represents
+     an iommu_domain to userspace will be created, and then added to the list.
+     Successful completion of this operation sets up the linkages among IOAS,
+     device and iommu_domain. Once this completes the device could do DMA.
+
+   * IOMMUFD_OBJ_HWPT_PAGING can be manually created via the IOMMU_HWPT_ALLOC
+     uAPI, provided an ioas_id via @pt_id to associate the new HWPT_PAGING to
+     the corresponding IOAS object. The benefit of this manual allocation is to
+     allow allocation flags (defined in enum iommufd_hwpt_alloc_flags), e.g. it
+     allocates a nesting parent HWPT_PAGING if the IOMMU_HWPT_ALLOC_NEST_PARENT
+     flag is set.

Thanks
Nicolin
