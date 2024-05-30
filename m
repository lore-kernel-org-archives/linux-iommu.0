Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6619143757
	for <iommu@lists.linux.dev>; Thu, 30 May 2024 04:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717043202; cv=fail; b=kbLYYaRyrEpIXgbgj9aENzgsDeSXLBq1JKhLnIh+4iR1wiePutVkEcTV1Us7+0CURvDMtRmuYii+T8r2xa6Qs0X7nlnpHhC+UaAUdVaRF2XLIeP/c8ZBwJ5W4ZiNsE5WDKGsBgnXFTXK0uTE8ZlgIfMoL1B9FHFXIxplvZ/HWw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717043202; c=relaxed/simple;
	bh=kZ5tPw9opuECfynNHKL+9Scet2JSpuF+GHRuOORPKdQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HXiRFfe2xMIXMdTJYS7VviTzOSZ0jPROQcDMznkjvV4TxX67OJ+gyRXFbW2hc5zSThjGIBh4PbvshJXRiLhsA9wQRHgSm8MSeJFC/SDOW4c6Gm3eUiRbf0Prx7ou8d1kkrDsnIHy206/yV+4QCRsttqvOt6j9DVjO3Y+dLj2PN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gUv0ujCo; arc=fail smtp.client-ip=40.107.237.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gUv0ujCo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qe3XckZniUh8FWIRI7tLwD6YirFheUscQ0rTLqE56aQRKARMzdEd99KTO+ZgEMPauywBc0hOvlezgWi6f5TTWq2+2dYVg3Mi5K19m6CE9wAuLFkAmorVMi5jEkJL+F3IZiD1vxyhsSt1UcNz+PET4DRQh/7oGv+qbaG5kPeFJhHo3oFyZ4YTnT4s4l8u+uNwh9XLhnY3NYElP285SML6KNlIA9V+f0AaflvHePNyRYvtv2yOaHP2lSTpOoEgH6n9Jy61vWYJMLcMYwcbYNyNZN6HwYQkfehGyMRH3ZGF4YoepEzd/9B/Qw7ZNj8OgKNSvshsiT6sP+bTyDlih8CZ5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ah2TLIMjiuLK6mRcusicIApJCfYyCL8/JQJKbAyPTQ=;
 b=TPMk+/c3I+fLqmU4I9lEkCA2cKE5rZ3nCQWJgIQ58MFECD9VwnYw+6Uih6Ztg5W4VjMCa1Jq2TsdJVGnYrm/Y+kG5tmAprwpVAO+Ciqd5LOCf4lJcEdqbVHcJOGZ7jHzYDyynaLur6VZ2G15/ssUCc/O8MdD7K9qhWCirXkrI0ZgWWZPSuoMO/vsKiJ4CBWt7EjFvBGimHkbEif4OO9ON1/T/wsI56m/VTPYG+F8QYLD7tiqonJzNQzQB0qJo//ahe/CDXC/Gjuq2NmtKDnm2CmQmDomCYlW/Lp42tyJzTBehuZnWvfm43Yf7zk6/FjyUmahx9bvhLUglhYFLlOQSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ah2TLIMjiuLK6mRcusicIApJCfYyCL8/JQJKbAyPTQ=;
 b=gUv0ujCohG7yy2GZ/8yhb3n32ChvbeUSUIzEg9H11b+asJlKHfbmz/A/gznJJcTCmM0wUENR4AxbWPkgSF5OlS/bikZCAXnznWBquMFh/m1NSQaKiBK6lbtUqIonNVVBU9+sUFIUvHTXxqajN/xqKunvaJn6mHxExTksDQc5e05oyXyEa7r4tYopXkWF6FHRqPVqQm/2BnRABeVVZzIv1p8rbyAdlEGVSLUe2JUGtwk3L/u0RXQYug6VKpGYw8P8QqdA8NErVVfpiWDtC70j0JS6hNYm9nKl3ivTSps5+aAQru4ag3OUKTQ2zyRuoyrei78xIDFx9/nB53IlON6jyQ==
Received: from DS7PR05CA0040.namprd05.prod.outlook.com (2603:10b6:8:2f::33) by
 SA1PR12MB7038.namprd12.prod.outlook.com (2603:10b6:806:24d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Thu, 30 May
 2024 04:26:36 +0000
Received: from DS3PEPF000099DD.namprd04.prod.outlook.com
 (2603:10b6:8:2f:cafe::22) by DS7PR05CA0040.outlook.office365.com
 (2603:10b6:8:2f::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19 via Frontend
 Transport; Thu, 30 May 2024 04:26:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS3PEPF000099DD.mail.protection.outlook.com (10.167.17.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Thu, 30 May 2024 04:26:36 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 29 May
 2024 21:26:30 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 29 May 2024 21:26:29 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Wed, 29 May 2024 21:26:29 -0700
Date: Wed, 29 May 2024 21:26:27 -0700
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
Message-ID: <Zlf/84H+cfAfaZj6@Asurada-Nvidia>
References: <ZlAoN3s96HL7ROth@nvidia.com>
 <BN9PR11MB52762A0BC67B64D4171480C78CF52@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240524131912.GT20229@nvidia.com>
 <BN9PR11MB5276BBD592021507C3A0EBB38CF02@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZlY886FT3HHLC8Cf@nvidia.com>
 <BN9PR11MB52762EA9B444DA71F551C3868CF22@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZlafEktUu5znDsNt@Asurada-Nvidia>
 <BN9PR11MB5276AC43120376A2502D3D148CF32@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZlfPPwsnY6P4SoGF@Asurada-Nvidia>
 <BN9PR11MB5276DC3F8F085FE0E699D9448CF32@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BN9PR11MB5276DC3F8F085FE0E699D9448CF32@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DD:EE_|SA1PR12MB7038:EE_
X-MS-Office365-Filtering-Correlation-Id: a6b122e4-2a5e-4166-b197-08dc8060b1a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|1800799015|36860700004|7416005|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OVYvWlBuZ240VEdEZlJUQTBQUUdRUzVmOG5EZk9kcld1STZUQ2FmbHM5bHRP?=
 =?utf-8?B?ZDhUOWRBUHRCZjFHOGZiSEFWcGw3aTJET3c1YmZobndBdmJrSUNvT3dGWWN4?=
 =?utf-8?B?NWtETEp3b1l6SFR2SXB5V1YrUmJSYzA1MFlYQ3JiZjNTY2FiZlY0bWJrWThY?=
 =?utf-8?B?REsrUE83Z3o4T09wNkFkV3NtVitFNXhKMmszeDducEE1dWp6UVArRExINmtV?=
 =?utf-8?B?V2dpSU9xRS9HUjN1TExPZForeUM5YnJZRUV0V3RMT1dEYXlPQkthd2dTRmJO?=
 =?utf-8?B?K0xOTGVQaG83LysxcE1TdW4vQWk0VXhLTnQrT3J0VEJFdGFxSmV6RllXbnJ2?=
 =?utf-8?B?SkthY0dKeUJsWUFDajNYR3JCR0dITGh0WDJENUxMR2pORzZIbXRUU3FmNlk5?=
 =?utf-8?B?V3Q1akZhazBzMnlTQnRRclQrTUFQSXZLbnJWRE10TzE3bVBtN2Vsdjk2QktO?=
 =?utf-8?B?T1pjRzBHbUpjWmVUK2ZpVUQ4bzJtSWhJTzlRdFg4MjZ6eStqblNQOXNXZmdn?=
 =?utf-8?B?WjlOU2pIVFF6M1pLUlZERGtvaE9HTmplc2xuK1YraUJCNEtQL2FmV3hYZlRS?=
 =?utf-8?B?cE92MDI4c1ViR2NSdlRXd01ENlgrV3BsY0IzZDFPbXlQR2VjMnVxM1FQR2hH?=
 =?utf-8?B?NDRlNkhJU0ZyZ1VMejVmNkZGTENzdEREeHA0dklNVnhEMThCQ1N0bHEyRm52?=
 =?utf-8?B?ZmxQYlB0dWxHMmU5R0wxUlc5b2pRRGthKzY5NmZUbFAyVVkyeHNuZWFYWFkx?=
 =?utf-8?B?MDV0Uk0wLzV3dC9wQ1phRm5abHlkbmsyWXE0NGMyay9QNkJQUjNEeURUOVFn?=
 =?utf-8?B?R3JBSWNqMHcwU29aakRkQUVwWnArL0xCa3R0MnNWN2pYK043MENUL29wbGhZ?=
 =?utf-8?B?SzU2ZFlaQVp6U1JycnhuYThLQkR3bisrdk5BVU5JMVFZV3V4YXFIdnVITGFj?=
 =?utf-8?B?bXhKVENhY0ZMVEJ2aUh4VzBMS1NIVVg3SGJKQnNkc3dndXRtaGRDbnVpRVkv?=
 =?utf-8?B?cUNYUVhjMDNnNkZDaHgzYlNXK2NqLzRZOTBnekhLVmZxTmRQQjYyNStZSExm?=
 =?utf-8?B?bjlQcjVpWTFiS3o1WG02aHdVVUVzQTBDTjAwTkR2cjJQQW4xS1pHWk5nbEo4?=
 =?utf-8?B?RkZwVUM1OFlkOUVwdEhVc2NxaWprZ2tWUnplNU8wSitma0hnUDVpMHlYYzQ4?=
 =?utf-8?B?NVdwZVdKbHMvVlM4RGF0OWVVMHhLdWdxQmw4SnpXcS8xL0wyOW5rMWoyaWNh?=
 =?utf-8?B?ejZmMWlZdmhlL3dFMlJrWVRydFlqZWxlQnZWWGcramk0Zys4eHZ1Zk5IekFW?=
 =?utf-8?B?VjhaMWJ1MEtnMVlpZFFVWkExNWN6Y3k2ZFpoazZuZS9aMFlvODFSc1hvNTJn?=
 =?utf-8?B?RzZkN2JOY0JoTzlKQXV6RWIxZlc5Z054TDBZL2hiQlJCSUEyRDdMb25uOEo1?=
 =?utf-8?B?cE5wNUxHazRwZVk4ZFFCVmIyWDdMZnYzUm5OWGtESG45cXF1R0hTbmpwQnk2?=
 =?utf-8?B?dGoxZDIyeVIxSmxrZVY5Nyt3MnJWZWdWb3FKTHRtM0ZNZ2VlSC83ajFMR3JH?=
 =?utf-8?B?cGphc1pYb0pMK1gzZjdlWHhXVk9QYkRvaHRDRWhhc0pQeGRjYlNFNkZtdjA5?=
 =?utf-8?B?ZkVqS0tCc29vTll2bnY2VXoxaEtyOUVWYlBucEhwci9mTGlQSjBlT1E2TWZx?=
 =?utf-8?B?Vzd6dHg1UGwxdDFWNzVLQmdTUUJCMTJtTi9hUEdOUmFxQ2laMXY5YmNoUnJq?=
 =?utf-8?B?Wk16SkNYeDBuSHFsRHVFNTc1anBsaEJDNHdibi80NXY1WkpyRWkyS2t0cWJF?=
 =?utf-8?B?UUJEZ1BVQ1I0cDVQemtsYTNMT2NmcVliUFJiU1Zyblp4TlRyTFlCaWNKOUpT?=
 =?utf-8?Q?YHl2BrLEQm6Qo?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(1800799015)(36860700004)(7416005)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 04:26:36.3872
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6b122e4-2a5e-4166-b197-08dc8060b1a3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7038

On Thu, May 30, 2024 at 03:05:05AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Thursday, May 30, 2024 8:59 AM
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
> ah does it mean that dev ID space on ARM is local to SMMU?
> 
> It's not the case on x86 platforms where the RID is platform-wise.

Actually I had a second thought after I replied. Yea, we only
support PCI devices at this moment, so their RIDs come from BDF
numbers, and then should be platform-wise as you pointed out:

|<-------VMM-------->|<--------------- kernel ------------>|
 vRID_a --|                       |-- VMIDx / SMMU0 -- pRID_A
 vRID_b --| => vSMMU => viommu => |-- VMIDy / SMMU1 -- pRID_B
 vRID_c --|                       |-- VMIDz / SMMU2 -- pRID_C

# x/y/z can be identical, while a/b/c and A/B/C must be unique.

So likely a single lookup list can be enough. That still can't
avoid the list of per-pIOMMU objects for some driver feature
though. So, I think having a per-pIOMMU viommu also adds a bit
of flexibility for the kernel.

Overall, indeed an implementation choice, as you mentioned :)

> > And a driver in this case would be difficult to get a complete
> > concept of a viommu object since it's core object and shared by
> > all kernel-level IOMMU instances. If a driver wants to extend a
> > viommu object for some additional feature, e.g. VINTF in this
> > series, it would likely have to create another per-driver object
> > and again another list of this kind of objects in struct viommu.
> >
> > At the end of day, we have to duplicate it one way or another for
> > the amount of physical IOMMUs. And it seems to cleaner by doing
> > it with multiple viommu objects.
> >
> > > so it's really an implementation choice that you want a same viommu
> > > topology scheme w/ or w/o VCMDQ.
> > >
> > > we all know there are some constraints of copying the physical topology,
> > > e.g. hotplugging a device or migration. for VCMDQ it's clearly an
> > > acceptable tradeoff for performance. w/o VCMDQ I'm not sure whether
> > > you want to keep more flexibility for the user. 😊
> >
> > Oh. With regular nested SMMU, there is only one virtual SMMU in
> > the guest VM. No need of copying physical topology. Just the VMM
> > needs to allocate three viommus to add them to a list of its own.
> >
> 
> Okay I missed this point. Then the number of viommus is really about
> the contract between the vmm and the kernel, which is invisible to
> the guest or the admin who launches the Qemu.

Yes. Everything should be behind the scene, since VMM can trap
and select, unlike VCMDQ doing direct MMIO to the HW without a
chance of VM Exits.

> but wait, isn't there another problem - does the VMM have the
> permission to enumerate the topology of physical SMMUs? Or probably
> the VMM only needs to know the number of relevant SMMUs for
> assigned devices and such info can be indirectly composed by extending  GET_HW_INFO...

I think VMM already has some kinda permission reading the number
of IOMMUs from "/sys/class/iommu"?

That being said, in a regular nesting case w/o VCMDQ, there is
no need to instantiate all vSMMUs to the number of pSMMUs unless
there is at least one device behind each pSMMU attaches.

So, the current implementation allocates an s2_hwpt/viommu only
on demand, when the first device from a physical SMMU attaches,
meaning there'll be only one viommu in the list until the other
first device from another pSMMU attaches. And the actual attach
logical always tries attaching a device to the existing viommus
from the list, and only allocates a new viommu (or s2_hwpt) when
all of them failed. FWIW, host-kernel/driver has a full control
against these attaches.

Thanks
Nicolin
