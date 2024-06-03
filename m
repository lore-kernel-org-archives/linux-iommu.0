Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B9DF9E9
	for <iommu@lists.linux.dev>; Mon,  3 Jun 2024 03:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717385154; cv=fail; b=mMQvUaLDbZ54uQEcLUt1ePgmoHKfVbOdEZzaXi/yxJ3l51q24dgvwyS373nkkqz1/SUIlwFZmbnAjzveWVPgx64UTGv5Gj5KGUbGDT8ZXIFVyrBz4vY/GXfenK0nG23BwBy5hy0Ye3ZMX1l2xQZpuisZH/smspGMvQiDE31+/u4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717385154; c=relaxed/simple;
	bh=9+688kxo/BiLGbiaHMVdETkPAplE26gGuyOPxE71o9k=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iAqUk1J6KqwIiR4ECAsiKFsYbc9PLgi2xFtlR0932IyCLYwi2ZJK3KPfk3T5ZaPsn/HatppyuHANLdJjl7mqa7ukheqBdoV5SvVf6DIDmKm2CJfq7b5v74SsvFa26vhgTS+KCp/KGriv/f6/FKM9duYnMXcdxBIFuenbT2AifFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=H2MrwpM2; arc=fail smtp.client-ip=40.107.243.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="H2MrwpM2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nJw+yBl95Z9XWqdmNugKlaThRlvxCNrILSzjfyadGIYeAkQ/joVeq6MD0uJVpxQtm8jmGxAyuywoImWYt5YydQa6wx4qbavXXeLjZ/8Sdoyd7+to/f6EFvrXDnW1ez6aknNvK8iFb/HonWCGMMnCqSgy3CZ4FpGy6irkXPMEkUEH+1L+JFtEVb1JNiyOnwbrOpgEAwKanVbfAH2EnJcjmkYDinB3no4B/+OVI3JlyKkAihdnN2UmXMG3U3ymhIdH8F9zTtSOpmqC35LDtq4q2HIZ2bJ7WNcW/Ky38x6y/jTeva6eDonJ6PsRQdUbCAlzajiAttrglHTc/NQnc1QQLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YnHvxF6gFqrRGEyXUB3BjNGI9i4SQZX79YjPNbHpuLE=;
 b=PdebG6nQ9DhkGl4gr+QLlgtd68wcGUFaBSDtRi4PnsHAmiLJYEVPFmXEwETtc1Vk4+SrekUsijmF1gIVNd8kQEdAqWszndqNCgQsdfiUOTiy+9kzrUIcpdjS2Vn+kFIZAHc+wu5rJuV6nG1fMHIJuk/gmn3xrjWLatDyMjubKqylV00abTeWEgnZfOgfBRSWwsicf5v6f0fM75rWAffjII4H2oNutdzeIA6K/BnKgRBNC1u5k6i6YzyX/Oo7NTC2BjMCtLAoYmluF4yxtX6bmPuTc2Vfb2MBkgVfb8tap9KDmju+CFr1pvskggWgpUwHDeDHPak4BlJQSeInZ25hZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YnHvxF6gFqrRGEyXUB3BjNGI9i4SQZX79YjPNbHpuLE=;
 b=H2MrwpM2FRYnjb2IZnah9zuT7UDKfpufjoiXY42qzFM2cvp5CqUrO+uNXoCk1rcNbGUAWhtSx4BwSZEdtItFsx44Ogv0seOWnqcLCYeNIAiLQRNYN/ul7vyltIPy3ZGLOiOJxXNgqm3NpnrsNpnkziqCNv/ncc2hGH235vYDoWABEXTE11zkZ6wehumGYLWWHbDwwf0zfAy8JfC9jEuEK0hZ490qn0ZJ4ZhJXpHXua+/jk3d8b7v6+F7SmUo6B2Lz2q0jqF+ZdmkRNNsbcSgFltJGnXiOPgpvuAusDSPFIlfwWAP3+VL7dHjMRK8piNjVCoUZuBHr9OL5qxVGJBJQQ==
Received: from CH0PR04CA0098.namprd04.prod.outlook.com (2603:10b6:610:75::13)
 by MN2PR12MB4317.namprd12.prod.outlook.com (2603:10b6:208:1d0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Mon, 3 Jun
 2024 03:25:50 +0000
Received: from DS2PEPF0000343F.namprd02.prod.outlook.com
 (2603:10b6:610:75:cafe::d4) by CH0PR04CA0098.outlook.office365.com
 (2603:10b6:610:75::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.29 via Frontend
 Transport; Mon, 3 Jun 2024 03:25:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF0000343F.mail.protection.outlook.com (10.167.18.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Mon, 3 Jun 2024 03:25:49 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 2 Jun 2024
 20:25:38 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 2 Jun 2024
 20:25:38 -0700
Received: from nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Sun, 2 Jun 2024 20:25:36 -0700
Date: Sun, 2 Jun 2024 20:25:34 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: "Tian, Kevin" <kevin.tian@intel.com>, "will@kernel.org" <will@kernel.org>,
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
Message-ID: <Zl03rsgZl/msa3I+@nvidia.com>
References: <ZlAoN3s96HL7ROth@nvidia.com>
 <BN9PR11MB52762A0BC67B64D4171480C78CF52@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240524131912.GT20229@nvidia.com>
 <BN9PR11MB5276BBD592021507C3A0EBB38CF02@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZlY886FT3HHLC8Cf@nvidia.com>
 <BN9PR11MB52762EA9B444DA71F551C3868CF22@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZlafEktUu5znDsNt@Asurada-Nvidia>
 <BN9PR11MB5276AC43120376A2502D3D148CF32@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZlfPPwsnY6P4SoGF@Asurada-Nvidia>
 <ZluWXYQjroz0fqqn@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZluWXYQjroz0fqqn@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343F:EE_|MN2PR12MB4317:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f118bc2-d8ab-409f-0bc2-08dc837cddb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|1800799015|7416005|376005|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iF4b5J5nZv/0P9dJhMgQuiQdVp9KpxTWjq3Ics6l1Qxyr4UgCoHA5lXaz+8X?=
 =?us-ascii?Q?hTHdZbXG3S9xmkBfHEuVLdx7xid5A+0VZV16YrWk8/xnUt5WkW5iakObv3gt?=
 =?us-ascii?Q?iss8Ab33AQQOjeBrakhUsIyNWoky1eP8FAxKout8G0S7OoZrhFZ3Arpn+Vxp?=
 =?us-ascii?Q?RqBn1mbL+1xchmzLfLKuXDrQ/4FzCoQ0AiXegJw7eULTOXVmqUYgBtqTFHwl?=
 =?us-ascii?Q?EIFBI4RSgVhR3crRDcQEWJDAPsU3gDfsQFY3lhT+s4PV+DS2wVg58gvMukCg?=
 =?us-ascii?Q?3iLsBSmUjMzs/rrU+WKCNnFUKKAQSY8epVBuowDCAhAp+YFiN4UjmYBV14Ex?=
 =?us-ascii?Q?1qK0BzNSvSkNF6yYJqdhoMoSuSOolyvMmoHWyCExNGaUPbkAFT8mx6/HWO42?=
 =?us-ascii?Q?Z/vaEW9jHgWyTdiHLZ815s40l3TP5q8B9Rz6qFN1+BtSncCB5pr/LV+jdY4j?=
 =?us-ascii?Q?HRzGSGwk5yUnQrqSa2/5gUV1bYc6RAD+pcOMFMzkEV4FCReeBW2R/1C9w2FY?=
 =?us-ascii?Q?nIo8zq4n2g9U+V73ZFkvW3BuXD6yx6uVZI4WYJUzEB60/A70JVm1vCpgivA1?=
 =?us-ascii?Q?+AgXMI+omPkamNw5EZeqft9l8N0CTNcI+6JLNNEqclDImt9QbyWSl+0ylKFn?=
 =?us-ascii?Q?BhpaFXbMZ5jpFXqHOgS3QB5FOSsnTyY1KDEExhUVaH0LCXMz6+UFyD/zURxg?=
 =?us-ascii?Q?M+gCQdjAQi8ti4ODKskDSOHfGvm4sIb+aLK4xlSn3t8a3fW6ZkwF2XzNS262?=
 =?us-ascii?Q?H38M9EhmMOCT1WXAcyZQWbP7zc4YN1wkHnY+VN1x31/Zq/1glGyMjnwSQL/c?=
 =?us-ascii?Q?x8HrsCvjwZZYUtdGi6I+6E49CQXnCMOy9Ey6/yEsF/qhE4nQcgrjwTWHjt0+?=
 =?us-ascii?Q?6wwJytXIv4wtePoDqETEHwloJg7xCiPa2FpZ7ZJuOwNbp3YPR7PSX/bnc3JV?=
 =?us-ascii?Q?aKxPxm76M5/y2Hu2+MXjW1HmBzM7biXgwrq7+YHyNWGrghYH0alNrmHtTEoS?=
 =?us-ascii?Q?yr4EFuiK1ZhX8imOST2/9fkr1q9q4lo4GzOcvPaEbDn5s7TLoIWNkb670uXS?=
 =?us-ascii?Q?ob12rMX0mfhErAH97QWtd/1k2+h0Kj98z+glmomFx+kCmSty2Xdcw6fUJTdt?=
 =?us-ascii?Q?aVplZeEQcX6KarvspXSGQAM526ZCl7stTgJOcmk9drdHXV9FHqNCbskypfAv?=
 =?us-ascii?Q?RiH8YQypGhegj7Ec62+aaqj+7OK3x79IAiE2si0IQeAY7ywBIyFSVEcgOa2L?=
 =?us-ascii?Q?dwyLOUqKBTlY96xjSZA114ubxb1XATpWkRkLP2k4SErhCK+cjjxcuaTmlvWI?=
 =?us-ascii?Q?Rw1uWvExggFywbzWRYk6Mgbn0WTJazfarfw2YpaqzVWVpE/XY36NM6f+B1JI?=
 =?us-ascii?Q?dPQIsbIDgveWl6jKEUDuAnaGXA4N?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(1800799015)(7416005)(376005)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 03:25:49.7240
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f118bc2-d8ab-409f-0bc2-08dc837cddb6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4317

On Sat, Jun 01, 2024 at 06:45:01PM -0300, Jason Gunthorpe wrote:
> On Wed, May 29, 2024 at 05:58:39PM -0700, Nicolin Chen wrote:
> > On Thu, May 30, 2024 at 12:28:43AM +0000, Tian, Kevin wrote:
> > > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > > Sent: Wednesday, May 29, 2024 11:21 AM
> > > > On Wed, May 29, 2024 at 02:58:11AM +0000, Tian, Kevin wrote:
> > > > > My question is why that option is chosen instead of going with 1:1
> > > > > mapping between vSMMU and viommu i.e. letting the kernel to
> > > > > figure out which pSMMU should be sent an invalidation cmd to, as
> > > > > how VT-d is virtualized.
> > > > >
> > > > > I want to know whether doing so is simply to be compatible with
> > > > > what VCMDQ requires, or due to another untold reason.
> > > >
> > > > Because we use viommu as a VMID holder for SMMU. So a pSMMU must
> > > > have its own viommu to store its VMID for a shared s2_hwpt:
> > > >         |-- viommu0 (VMIDx) --|-- pSMMU0 --|
> > > >  vSMMU--|-- viommu1 (VMIDy) --|-- pSMMU1 --|--s2_hwpt
> > > >         |-- viommu2 (VMIDz) --|-- pSMMU2 --|
> > > >
> > > 
> > > there are other options, e.g. you can have one viommu holding multiple
> > > VMIDs each associating to a pSMMU.
> > 
> > Well, possibly. But everything previously in a viommu would have
> > to be a list (for number of VMIDs) in the kernel level: not only
> > a VMID list, but also a 2D virtual ID lists, something like:
> > 
> > struct xarray vdev_ids[num_of_vmid]; // per-IOMMU vID to pID lookup
> 
> I feel it makes most sense that ARM (and maybe everyone) just have a
> viommu per piommu.
> 
> The main argument against is we haven't made it efficient for the VMM
> to support multiple piommus. It has to do a system call per piommu
> each time it processes the cmdq.
> 
> But, on the other hand, if you care about invalidation efficiency it
> is kind of silly not to expose the piommus to the guest so that the
> invalidation scope can be appropriately narrowed. Replicating all ASID
> invalidations to all piommus doesn't make alot of sense if the guest
> can know that only one piommu actually needs invalidation.

Yea, that'd be pretty slow, though a broadcast would be still
inevitable when an invalidation only has an address range w/o
an ASID, CMD_TLBI_NH_VAA for example.

In fact, there should always be a dispatcher (v.s. broadcast):
 - in the one-viommu-per-pIOMMU case (#1), it's in the VMM
 - in the one-viommu-per-vIOMMU case (#2), it's in the kernel

One of them has to take the role to burn some CPUs for-eaching
the hwpt list to identify the iommu to forward. The design #1,
simply makes the kernel easier.

The design #2, on the other hand, would not only require some
lists and new objects that we just discussed, yet also pair of
VIOMMU_SET/UNSET_HWPT_ID ioctls, though it also makes sense as
we choose IOMMU_VIOMMU_INVALIDATE over IOMMU_DEV_INVALIDATE by
adding VIOMMU_SET/UNSET_VDEV_ID?

> > And a driver in this case would be difficult to get a complete
> > concept of a viommu object since it's core object and shared by
> > all kernel-level IOMMU instances. If a driver wants to extend a
> > viommu object for some additional feature, e.g. VINTF in this
> > series, it would likely have to create another per-driver object
> > and again another list of this kind of objects in struct viommu.
> 
> Right, we need some kind of per-piommu object because we have
> per-piommu data.
>
> > Oh. With regular nested SMMU, there is only one virtual SMMU in
> > the guest VM. No need of copying physical topology. Just the VMM
> > needs to allocate three viommus to add them to a list of its own.
> 
> I understand the appeal of doing this has been to minimize qemu
> changes in its ACPI parts if we tackle that instead maybe we should
> just not implement viommu to multiple piommu. It is somewhat
> complicated.

Would you please clarify that suggestion "not implement viommu
to multiple piommu"?

For regular nesting (SMMU), we are still doing one vSMMU in the
VMM, though VCMDQ case would be an exception....

Thanks
Nicolin
