Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2064.outbound.protection.outlook.com [40.107.95.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056AA13B79B
	for <iommu@lists.linux.dev>; Tue, 28 May 2024 20:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716928432; cv=fail; b=DtFYAASaitF+ylQOc4nkmD+cojdR94zcH5RGRthSG7T7ddfCZyRI7UWGr1Ar1YOSKEUcrFw0R6BQXn1VI0OALkIeP+y2O88cdkr4Rvcph0aJUMlqolqLQiSelE3CFyYy9iv9+VEUjEjeoIsc8OEUxq9d2RZuB/nQ2jLBGtrDIhc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716928432; c=relaxed/simple;
	bh=yPSHtDPWg6CSgHGt0phVasuFXzajnYcsOhqyLxFH5y4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t6aDNYsAKhC2UcJLHxcaWOyrYK1zsFCU8NFlGMgUlmdKxtSha58kWWhNeNWqYNC2Au7IXJGvBpxjtpp/jPjziGyWyZS2TbJ4Gy9AxpqhgtAVg9sdKmQ3FqdHX1VGyXmUXt+hh0cu66k3tFD9lz83yNR6O76fY9auf+DLBzpBq50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FA8PMqcO; arc=fail smtp.client-ip=40.107.95.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FA8PMqcO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OOMZMmSpAu4saLvE8uavdjdmbYg66De9SczSKAHzeyGa8DBvcP9v6EDs0L5lFgvYmWB/WxPGzozckjWoZ58nxkLT79ALKOIBaz93dfVR7AJINE0ABWXLomQ4lS99fxbYBIqPivHqGaiWOvZhsRuma3TAutePcpNhGn9SGLNV/DHHToF5e3QljmMdZk561YoogMrJlksMqeQfkS7SSQQiwug+hV9Kixbdt8UrRP8JsCLs23l3+coquutlChzRFAV9FSaJtvvHjAKEqu339juL5plmNW4MLuID5OqYkb1pw9ZK9e89GwSJv3GTu9rP5HtGmYJTdfBWVLEIVvXSOLvGxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xmOiQMApXYtCBODx6nUJUQOMZ+RqsfTdu+mjq54iFPM=;
 b=gk5IK3fUWnuySmclJLs0DowHuEgkZl+MtWkOltrzWK+ur2cF4xYtd59dbY3eMIDyIM0Emxq78k93A33MpY8x5uhwYkBGkmUgFfYMrvclIAN+MSsTqrBjbO6Yr8UM9ry88VLl+3peO5rqIqlHYc7ZOlPlL3lL7unND0ZIei5iI5Pc/uj8oP5WzZfCgnc6//ZmL+8wb/bZQu249nJ2uTu0VuUe0fUSowAfpI6zdqiG490tAtGmyGkGQI7kkbuYDRHWn4EoMMSQWT8MQj5IZrOjxdOMEtv80xmdtAGMIIqhW5KhIJ4cns64Z1DRQmtYDc9Qj5gw95B37pNN4AIQSduA1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xmOiQMApXYtCBODx6nUJUQOMZ+RqsfTdu+mjq54iFPM=;
 b=FA8PMqcO3qtsM2+Ye23MvGtA5Upz8kZ4OWNJgShq/xzPM6dStgkCf0QMoYvmHm3fBzrdBd27G9n5oOEvkDG7ahhO/0UEFTRYPBqSBD19lzg1Hi2CRN4taCBJeAfisotlAn8/RPCmnlKygRHTrTBhsPtsN5pQQOQRrFp1FG6zGjoKHuJx5YAp4V6ErT66liA0WBQojHW27NoyWUitzXYpo9KQX6qWp2/yUkHUfeavn7Y2XHjhKT+vz+vQuiNpPadpCYafiIomg5bVDCnWHGf19ZV5ic/JJFdAACycV5eG9BDFzdBTL/bnac2pp+MKqdiezRZHe/RlMj/fm0iERQCM0A==
Received: from BN8PR04CA0009.namprd04.prod.outlook.com (2603:10b6:408:70::22)
 by DM4PR12MB6253.namprd12.prod.outlook.com (2603:10b6:8:a6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 20:33:45 +0000
Received: from BN1PEPF00004689.namprd05.prod.outlook.com
 (2603:10b6:408:70:cafe::46) by BN8PR04CA0009.outlook.office365.com
 (2603:10b6:408:70::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30 via Frontend
 Transport; Tue, 28 May 2024 20:33:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN1PEPF00004689.mail.protection.outlook.com (10.167.243.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Tue, 28 May 2024 20:33:44 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 28 May
 2024 13:33:25 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 28 May 2024 13:33:25 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Tue, 28 May 2024 13:33:24 -0700
Date: Tue, 28 May 2024 13:33:23 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: Jason Gunthorpe <jgg@nvidia.com>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"joro@8bytes.org" <joro@8bytes.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>, "vasant.hegde@amd.com"
	<vasant.hegde@amd.com>, "jon.grimm@amd.com" <jon.grimm@amd.com>,
	"santosh.shukla@amd.com" <santosh.shukla@amd.com>, "Dhaval.Giani@amd.com"
	<Dhaval.Giani@amd.com>, "shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH RFCv1 08/14] iommufd: Add IOMMU_VIOMMU_SET_DEV_ID ioctl
Message-ID: <ZlY/kxg0VJf7olXr@Asurada-Nvidia>
References: <cover.1712978212.git.nicolinc@nvidia.com>
 <c97a98a72ee3498c587e5898d6b899553ccd9b27.1712978212.git.nicolinc@nvidia.com>
 <BN9PR11MB5276A897A5386DFAC9A35F9D8CF42@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZlAoN3s96HL7ROth@nvidia.com>
 <BN9PR11MB52762A0BC67B64D4171480C78CF52@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240524131912.GT20229@nvidia.com>
 <BN9PR11MB5276BBD592021507C3A0EBB38CF02@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZlY886FT3HHLC8Cf@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZlY886FT3HHLC8Cf@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004689:EE_|DM4PR12MB6253:EE_
X-MS-Office365-Filtering-Correlation-Id: 46085eae-35e1-4cb0-193e-08dc7f55787d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|82310400017|7416005|36860700004|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SGWGt1w6bTQWFU6M0g2E6noE+2cDqymP6JBKm1aonXoWLF9Zvd+RmJ3kuOCq?=
 =?us-ascii?Q?DW6zPDVfRtlWTiHHrCnDgpcQ+B/2LX621AJUftOSyOuQXgWakemD5ymYiFb5?=
 =?us-ascii?Q?uhD2kKuLHm8fzuwhKdc2x8o3OI1mP/GWhGecP5JXxgG79uyonvKGgY0Am7s/?=
 =?us-ascii?Q?Bv99kXbNgAJq7IBO29BBS5uq2TEE0DvwkV0cDhQ6oG6X+IchUpmIKzZHoozz?=
 =?us-ascii?Q?9xnBZ/8fbOppahdvu077ix6VuCzRZUQXAqGxjEsJV7HWxv1gkRhGJDWRr0hA?=
 =?us-ascii?Q?m4QrLpoaP4oUsT5gbssC6mPC0MU5o87eTuAz1IuNhCTBpP8F26sFJU6gJNir?=
 =?us-ascii?Q?cFIKCNwzX8/EVpLld0m2tNgkMY1Q76lq9U+KhEw5As3o9YuahraMSPlAgs9L?=
 =?us-ascii?Q?wrPYFoHE1DNl2VtGU1uAuth0a9FXNJ6QNiIQy5nUxEadpEj8Q1OP/uHjUcm7?=
 =?us-ascii?Q?tpB5OxDVbliUAmez2s79EWNhiyuAAou1uPHs/8t1IoPKl/w1j8jmUsO4zhWJ?=
 =?us-ascii?Q?/gWcjLkeGowpsnJmg03zTUq0n3thUBQvilAzhsqLpxnh3D7J5WNJLcAwPmPk?=
 =?us-ascii?Q?eD1glWSbnF+h4Wdf3MPd57PJOxgBKfCqWisCzIR8eXRQGZW1O+RPXSj+zc+q?=
 =?us-ascii?Q?t5STT6FXXAxqI1CTdsOarvwy55WdL1Hgf5ZOwfQgqmotD1P7/djkYrHAmFW7?=
 =?us-ascii?Q?JdcEyrNSCGb1lpJmu544xcT0b8TqBYj3LXOn+jIebNL+7sy2FSNmRzefSNv4?=
 =?us-ascii?Q?Y3mx/EBUZF9NneKBuqKxHp1l1IeznJiz+2r9maXFe9dAtWTD4PRktyR0J1/R?=
 =?us-ascii?Q?1aDDvs1997+9toCxCp2Y+TBgVndTPcsjqUdZ9kTB1vKpi97uEiKWjdEiRMtD?=
 =?us-ascii?Q?bEyHi+fnXm+2ObOzg5Hg9Rvek7Cnv9o/PkbxDIFzNEeCwILh6KZZKBsVHYFj?=
 =?us-ascii?Q?Mr1C1qRwnxOazppm+WQ3JfnaqAGB4aFIg1zaCXWHM9x6DYXy5gzt8T6+A3kx?=
 =?us-ascii?Q?cI+KJkrpglZ83wb5wONPHTiROsA2sHoBLp6GjxOxDVrIDVoHr5Dp4UpbQRA4?=
 =?us-ascii?Q?Xg174mjq/6ZZ6azSqmK1Iik0yiw66Ckr8JgjGr4ec+obCGy8jwbe8fYAi5gm?=
 =?us-ascii?Q?A0E8yLWmwEAcNVN2vpzMXKBgCtV2SIVBlylpxtVGYw4dO1EloUiixkIkFDY3?=
 =?us-ascii?Q?IDtJ72Xj/wcWkSCUqyY5REqDy3CPmSbLzDgg5JuRo1LYy/H1sHNlvosJZXfO?=
 =?us-ascii?Q?zcLNgAXfYnV1/e9K/wjIAXA1wYgiN2KYdYtYgnuDmXZfKifW6uvcWPdl0XNj?=
 =?us-ascii?Q?/Xrl8zX94sNuOB+ndxFWM6D3d91zAEEJWSorO22IZXVuvpjuYDIGl34//bfm?=
 =?us-ascii?Q?3c2jPmY=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(82310400017)(7416005)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 20:33:44.8305
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46085eae-35e1-4cb0-193e-08dc7f55787d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004689.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6253

On Tue, May 28, 2024 at 01:22:46PM -0700, Nicolin Chen wrote:
> On Mon, May 27, 2024 at 01:08:43AM +0000, Tian, Kevin wrote:
> > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > Sent: Friday, May 24, 2024 9:19 PM
> > >
> > > On Fri, May 24, 2024 at 07:13:23AM +0000, Tian, Kevin wrote:
> > > > I'm curious to learn the real reason of that design. Is it because you
> > > > want to do certain load-balance between viommu's or due to other
> > > > reasons in the kernel smmuv3 driver which e.g. cannot support a
> > > > viommu spanning multiple pSMMU?
> > >
> > > Yeah, there is no concept of support for a SMMUv3 instance where it's
> > > command Q's can only work on a subset of devices.
> > >
> > > My expectation was that VIOMMU would be 1:1 with physical iommu
> > > instances, I think AMD needs this too??
> > >
> >
> > Yes this part is clear now regarding to VCMDQ.
> >
> > But Nicoline said:
> >
> > "
> > One step back, even without VCMDQ feature, a multi-pSMMU setup
> > will have multiple viommus (with our latest design) being added
> > to a viommu list of a single vSMMU's. Yet, vSMMU in this case
> > always traps regular SMMU CMDQ, so it can do viommu selection
> > or even broadcast (if it has to).
> > "
> >
> > I don't think there is an arch limitation mandating that?
> 
> What I mean is for regular vSMMU. Without VCMDQ, a regular vSMMU
> on a multi-pSMMU setup will look like (e.g. three devices behind
> different SMMUs):
> |<------ VMM ------->|<------ kernel ------>|
>        |-- viommu0 --|-- pSMMU0 --|
> vSMMU--|-- viommu1 --|-- pSMMU1 --|--s2_hwpt
>        |-- viommu2 --|-- pSMMU2 --|
> 
> And device would attach to:
> |<---- guest ---->|<--- VMM --->|<- kernel ->|
>        |-- dev0 --|-- viommu0 --|-- pSMMU0 --|
> vSMMU--|-- dev1 --|-- viommu1 --|-- pSMMU1 --|
>        |-- dev2 --|-- viommu2 --|-- pSMMU2 --|

I accidentally sent a duplicated one.. Please ignore this reply
and check the other one. Thanks!
