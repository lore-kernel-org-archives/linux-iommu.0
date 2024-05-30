Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2082.outbound.protection.outlook.com [40.107.236.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F68D520
	for <iommu@lists.linux.dev>; Thu, 30 May 2024 00:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717030733; cv=fail; b=b5K/nZXJL4BZ6cLDcEIQHNQmf2vTXkZis/LmHWQze/WJpdurt8dgHE2QtRUkMb+BErof4ht4heqfLHnRrCFPh6E2qnFWwI/sAJRklAbJfrshSZ+7icmq5+EaZ9f2uJBOtwiutlam8mXpAqlI87XrL7bQtpEY5Cps7Gt1vqVfNgA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717030733; c=relaxed/simple;
	bh=4SApNmrRlC6byZF0DScI4KCi+gqLL8i16fBWc/x4hRQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OUfWANb8B3W970qpGql/vb3Svw7Y0ABoL35rwfQWcBkWrvEOKfJ1jj8F7cHunAq1AHiGXFd30xi5n5K/nyBVsJpTo8zWFnoTZyugID3f1CBMdvyqwm3nMhJkJAhuqrZnL0nZD5fyuOGgWaMJDgVdk4/BRGygBlELDWKfS64LVvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=m2BNelbK; arc=fail smtp.client-ip=40.107.236.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="m2BNelbK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UY/H83I3B7XRSXwK3o4mX+xypr4yUzBnrE8cOCm5vgYZG3Z8MOS2jSaKXfvquedjqc946GVZsNxiJsPRmSpXptUrej/8K04ZJfXDcKoqooboqs0ozG0RAusbUB9moyNatYLHh8OpQSbNFSXqG121r834djRRgQ5vcJRS/nAcb+8rzAQFYSw5E2aeOzgCCZjIjKtTHTu4wShduB6U/bDsSr/lIGGomojOAhFI9c4FqThoi6j/AH11Le6ebQoEq4bYFV6U65vDmNvdN5pU/z+uIf7Vj/ap0WkUnW8dliyzcpwRLHF2/PtstOcYgvrAg+p9fMoT7PiGhbaO5V1BgqlXPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7PIyQSdMGgZJE10VqElhHjNieFxrfbjDqV7ruuARKdc=;
 b=BAIPA8WY9LnfJ4UE+lTa30//zWX9wz4FcxJabpc4V9Dz1s/HDY1P0ge9NcG910n+sYJCy8qLUQYD7Q+3VpJBD/dH/ctn9+btK5AWNzXaSqitAm6Q2YnH8v3lXIvBHUyZ4nnvkMC/7wj9DTD2wMQi9NEX9bPJ82Uzji0ZRUTfjg/7uK2P1FdKlBx/my9IQG74dCPeClLvlDZKHZYTzAbD77MOjC+ah2leRjU7zp4LekJ5BmV63IciMfeyWNHmQ4tZv9QVTMu9h/2FQYHPekaurk6lfPYGJjhp5J7MnFjeeNCCmN/R7IPGkVOc96h6lwRXb3i2TkWuf/73Jayja8d/OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7PIyQSdMGgZJE10VqElhHjNieFxrfbjDqV7ruuARKdc=;
 b=m2BNelbKcDLANIi5lk8zMVzUtdKzZ5WunuvP7sLTIxRYRwiEhPXlbb8ShZvCYU5CxZyaDn0kBJeYkkHxdZ328cHXKMoQqT/gGr7kodSSyWJnY8Pp2wE60PnnnDIAH2PB3A2E67luKUF95lvOhHukUJAyx7wyBiJpw6QUPoVVVqwfSE/FqXIoA2pT+Og97e9QG8NFmxwTAru/FpvUShV47u97Y7QBSDK+9NNwaSqtb5SYR5qu+0n5t0wCDSdhiiF4dUNBA5fJrIZY2kcenetGZeeYw/v3+hPat+xdEq8VLpfkqhGueB+BA/MlkEvsE8yD5qrLDaWfPpOvREg6UbOeZQ==
Received: from DM6PR03CA0033.namprd03.prod.outlook.com (2603:10b6:5:40::46) by
 SN7PR12MB8148.namprd12.prod.outlook.com (2603:10b6:806:351::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Thu, 30 May
 2024 00:58:49 +0000
Received: from CH1PEPF0000A346.namprd04.prod.outlook.com
 (2603:10b6:5:40:cafe::13) by DM6PR03CA0033.outlook.office365.com
 (2603:10b6:5:40::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.31 via Frontend
 Transport; Thu, 30 May 2024 00:58:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH1PEPF0000A346.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Thu, 30 May 2024 00:58:48 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 29 May
 2024 17:58:42 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 29 May 2024 17:58:41 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Wed, 29 May 2024 17:58:41 -0700
Date: Wed, 29 May 2024 17:58:39 -0700
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
Message-ID: <ZlfPPwsnY6P4SoGF@Asurada-Nvidia>
References: <c97a98a72ee3498c587e5898d6b899553ccd9b27.1712978212.git.nicolinc@nvidia.com>
 <BN9PR11MB5276A897A5386DFAC9A35F9D8CF42@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZlAoN3s96HL7ROth@nvidia.com>
 <BN9PR11MB52762A0BC67B64D4171480C78CF52@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240524131912.GT20229@nvidia.com>
 <BN9PR11MB5276BBD592021507C3A0EBB38CF02@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZlY886FT3HHLC8Cf@nvidia.com>
 <BN9PR11MB52762EA9B444DA71F551C3868CF22@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZlafEktUu5znDsNt@Asurada-Nvidia>
 <BN9PR11MB5276AC43120376A2502D3D148CF32@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BN9PR11MB5276AC43120376A2502D3D148CF32@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A346:EE_|SN7PR12MB8148:EE_
X-MS-Office365-Filtering-Correlation-Id: a070490a-16c3-412a-4296-08dc8043aa45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|7416005|1800799015|376005|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TDNRbHREclhJc256SDk2MDQxRUh6djZwc2JHUWwvZ3dIdXpURkZHZDZBRUIx?=
 =?utf-8?B?L3hiMkRxSkZUMHBnYmJMMHlBZ3hBY1F0YUZISlVTUEp1RU80c3pkV2hpUW5C?=
 =?utf-8?B?TVVqdCsydTNnaVdiam5sZHExcU9wZjRZVXFxRlNNa0U1bXR3d3BNNGR6b0Yx?=
 =?utf-8?B?SDlaR1dtMEZIanFiOTIyODdmQkF1L1FmQXdEWlpDWnFaSlF6TTlXUHpqdDJu?=
 =?utf-8?B?M0NSWE5jTWF5N3pORXZ5U1VvS0U2Z1hhVVpZc1diVGRjU2poV1NOYW5VUWQx?=
 =?utf-8?B?V1B0aUhzMHdrL0l4ajE1WVd1RXhCWXBSM3JQTlcxSUMzN1FjaXNkc3lUQ0Er?=
 =?utf-8?B?RU9YV2FsSDdOcThrYkgrT3F6ekFmaE5YMlluZndJYVZiWGx3cTRGeFRxUHhO?=
 =?utf-8?B?NHA2ZlZWNTVGb0dlblBMRzk2dWxrRGZrYVpiYWlMVTRIOW9nUXZaR1Viay8y?=
 =?utf-8?B?ci9kWE1vUm5pek52SkUxMmJUbzFNbW9PUW0xTCtLSkxLcjYvMlBkME5IbC94?=
 =?utf-8?B?ZnhCWCtQM042WGUxMHVwNkFqcFVMVFZZemhzZVlKRTZUaDVBN3BYaVE0Nzk0?=
 =?utf-8?B?bnhoZlltVVgvcjdydGJ1RVdFMm5rNEQraHF3dWNCM3BNTG4vK0xpaU1vc2ZT?=
 =?utf-8?B?OGR6V3lpc2N0UUdSSTZqNFZtbElSbXFacU9EQ3hvNlFYWk84TjZGUWxvRDZw?=
 =?utf-8?B?ODgvSGRFakVpUisyWkFwc1ZwSi9Dc0F1amRER3EyNVM5bmdYSTJ0bzM3cDBs?=
 =?utf-8?B?MFNXeDZHTTY5eDJ0OC90N21uV1FLd2VQQm5VUStsRnV1dUVReTEyUlBPYTdp?=
 =?utf-8?B?ckFKR2xBNUplL1lrVVZ5QXdzNVpzM0lJNzdjakw2U096MHJRYnM4MkNkT2la?=
 =?utf-8?B?L0xLWGorQ2xIbzJJU1J4U3hEUng5Q2xIMWU5d25LK3R1Z2paRUF5MDdva00w?=
 =?utf-8?B?cDdoYXFaQ21WRUl1MTBqNlUybm1xWjBOcWw4aEU0TGV6bDRvekZOSEZud083?=
 =?utf-8?B?N2JLNHhaUjhlMklFME5vQ1BZSUxjWi9WN3RIZGZFSVZoQmpBcnBJRkpjKzE0?=
 =?utf-8?B?MTduSVVLYXNVNVVadVRnL0dMZ0Z0TWxZS1BwYnB6RGxhcUgxc1Y2a3dMZ3Vh?=
 =?utf-8?B?bkdQeU5kUzBoTm4zamhVeTAxaG5kSXI1UEpXcVVvVDUrdko5VVJicURFTjVH?=
 =?utf-8?B?SzljVWlNbFAzOVY5RmJWUEJLRDk4cmlyZTNhbXJNejF5SEFKdFBiNjJMYXBh?=
 =?utf-8?B?T01NQ1pEOU8zMVJoZk53UVF5cThkQU5yUVphYUpJWUdGOHVHY1N2ajlOVUxu?=
 =?utf-8?B?Ri85cjdqM05WYnVVcnh5c0l2cWp6c09lck8zWjd1UVJ6WkphNnhXTUlEY3dX?=
 =?utf-8?B?aXhQWW9reFZmdzFybXJ2RXovQXBZbFBBVS9kOXpreWVHV1dneUpTTG55MkFR?=
 =?utf-8?B?Tjh6anJZQUxTTDZTNjF6VTlDMnpGbFZYaU5zTFpjWW51Ly9aMmpzbEJFaGhE?=
 =?utf-8?B?VVFqUWllb2d4WG9hZkp3dVRsMlR5M0RFQTlTVGYxc0c1QVFuOU9FUUNpdnZ4?=
 =?utf-8?B?anFJR3ZsenhoTzdTRTZmcmt2cEVvWmhDME9EbXdwYzhIMU1ubVc3N0R3L2Vw?=
 =?utf-8?B?WVNybS9ORlVoRkY1cUdSZUxLaER1QVBEOTU2M2hQZWRYRWV6QW81SlpaYi9H?=
 =?utf-8?B?MzVxQWVETUV5S1lkU3MvOVkwT0NWbEoxMDdFSkFkYVlJRDhyM1E2bkd6WHMx?=
 =?utf-8?B?QndFWDlsM0pvSHRqREI0UHU0UjBGYVJEUkRFN2VDYm5iQmdkTnRVSWJGSThj?=
 =?utf-8?B?a2F1Wmp6OXVUb1VMN2k3OXkraHVZUHNrakJnVUphZDI1NEtIU3gzbUd1cy9F?=
 =?utf-8?Q?nfliz6V31/7Hj?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(7416005)(1800799015)(376005)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 00:58:48.6191
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a070490a-16c3-412a-4296-08dc8043aa45
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A346.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8148

On Thu, May 30, 2024 at 12:28:43AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Wednesday, May 29, 2024 11:21 AM
> > On Wed, May 29, 2024 at 02:58:11AM +0000, Tian, Kevin wrote:
> > > My question is why that option is chosen instead of going with 1:1
> > > mapping between vSMMU and viommu i.e. letting the kernel to
> > > figure out which pSMMU should be sent an invalidation cmd to, as
> > > how VT-d is virtualized.
> > >
> > > I want to know whether doing so is simply to be compatible with
> > > what VCMDQ requires, or due to another untold reason.
> >
> > Because we use viommu as a VMID holder for SMMU. So a pSMMU must
> > have its own viommu to store its VMID for a shared s2_hwpt:
> >         |-- viommu0 (VMIDx) --|-- pSMMU0 --|
> >  vSMMU--|-- viommu1 (VMIDy) --|-- pSMMU1 --|--s2_hwpt
> >         |-- viommu2 (VMIDz) --|-- pSMMU2 --|
> >
> 
> there are other options, e.g. you can have one viommu holding multiple
> VMIDs each associating to a pSMMU.

Well, possibly. But everything previously in a viommu would have
to be a list (for number of VMIDs) in the kernel level: not only
a VMID list, but also a 2D virtual ID lists, something like:

struct xarray vdev_ids[num_of_vmid]; // per-IOMMU vID to pID lookup

And a driver in this case would be difficult to get a complete
concept of a viommu object since it's core object and shared by
all kernel-level IOMMU instances. If a driver wants to extend a
viommu object for some additional feature, e.g. VINTF in this
series, it would likely have to create another per-driver object
and again another list of this kind of objects in struct viommu.

At the end of day, we have to duplicate it one way or another for
the amount of physical IOMMUs. And it seems to cleaner by doing
it with multiple viommu objects.

> so it's really an implementation choice that you want a same viommu
> topology scheme w/ or w/o VCMDQ.
> 
> we all know there are some constraints of copying the physical topology,
> e.g. hotplugging a device or migration. for VCMDQ it's clearly an
> acceptable tradeoff for performance. w/o VCMDQ I'm not sure whether
> you want to keep more flexibility for the user. 😊

Oh. With regular nested SMMU, there is only one virtual SMMU in
the guest VM. No need of copying physical topology. Just the VMM
needs to allocate three viommus to add them to a list of its own.

Thanks
Nicolin
