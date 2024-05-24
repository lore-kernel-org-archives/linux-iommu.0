Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E26F1EB31
	for <iommu@lists.linux.dev>; Fri, 24 May 2024 03:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716521210; cv=fail; b=Fx0Lrt1KhIJEt4liiE1IwUXlciRKXEiopzjxu55czry6Ctfbu8+F3+SZso5YpJrVqyJsEJKADblgonEN3vZopOU35ca+afgNedRHB8nKnuhFCGFhbPbw2wlORqsglQSg3MV2FfJteI4E5LLeMyXJcFnd0/drXLQm7ZjZ7v8wZSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716521210; c=relaxed/simple;
	bh=DLFYYKUWS4cbl8f6yFqj7RJFyHeW6qu/RI6OJFtOf1c=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=shz7xpFchWZBt6bL8agqGWpS7hTRBrd88DUxbm0n4MtnvNp7p70GXCPB0RkT+D+Lv3dl0ZPxcfWiS4PZfucNRbAkFEu/7drqUXK2KeTtums+SDGOXd7eXFpMvdEYLA+VRKv08kDACAf9UKSJTF0TD69XnqKFgD9BNu7+tw8ahK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RCkCXr3L; arc=fail smtp.client-ip=40.107.220.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RCkCXr3L"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kxW7WSLlo8VsUKQBIBeGZyBbbyS7t+z2nXP/1yx6LyQ7Toab/EkNg55SO76nZEHlZaWBfGxGCS8tdudCzG60qhMAn/eBBpxBp2sg6Mj+T4lTt2qDt8x6Pvgf+vOOTaDRqskz3DbvLsgdIn+Xxb2VH4WSKBRumpK2QVodzGAoBlpxpekTi8/Jfs1eUM84YrZ+KeuRvF2ogrPg1QJh6Kn1MljTAGd8+rlpJ4F3ub7eGPAy7GkRVXk8Hi4k9OlTJ9rejTJ6ERfeEPKR/WV/9O0DYeqXxEUuW3YfKw1HfzJj/Lhp0KdYY7X2rEJzddy3j6OWX36LDq6Dijy+eDIcQmDQvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wH2JietVoOwDJN+WIiR0bHqB9uotAiFhUBCgGjzcJ9M=;
 b=Gvx/9bANWt/PTO6qvEawYN4Bb9LNPURsTVxaR+aOtjm36Hl7zUs5lJ1+IwmEk5QN5zuu0uhUgy/6T4zSRAQrkzU0frbKx9/rzTpb40qzav7RnVvYXOazwqmwC4SXlzz85qjJxPLXjles1O3lATLdzWmep/NKDqG2VZIWfhnogFtEFKPFiJ0LLIAYh+UliCKigAkpEjJTZY4w6skszvdN577URp+OykvM2xuqY0Jf0DT21CooLeTo4+FXLFfNcansxUZ4cMXle0UpL1HCUldp0aXP9esFNqut00rXnoI+3p8Y/1NgBkxy4S6OzBy24XbPycyImXkWRn/t54eKPknFzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wH2JietVoOwDJN+WIiR0bHqB9uotAiFhUBCgGjzcJ9M=;
 b=RCkCXr3LCpaJKcfBbuLjKNyGnRP9lsPgwUHLJ9ljPUke2tpIl+yFJoy/BFkOL6w/RJrSh3ofZwRQ+AhMYk76tZ3r+vVcw4ZRRerlaULrZVYUI3sWkb9oj7LXuMGkn8Y6/J4HbkJ/2BOAOR6xjnya+UK3S0vIyKwFI/mLHdsvgSdWVuKC5zDW8tK8JFVkBxnpjlMh3VxASJO8bl0CTyxb/5QNs722xjWx5KpBaSCz4YjcjvN5xla/lYQQdHWbEOlapOunuaAfhMxCQ6T20ZyFhk83Ipqmxww68hwpgouoXxHOKIU8M2bBX3PA+MfzFP9FOiUvk02ZLD8KEKr/IxXFwg==
Received: from BY3PR10CA0013.namprd10.prod.outlook.com (2603:10b6:a03:255::18)
 by MN2PR12MB4079.namprd12.prod.outlook.com (2603:10b6:208:1d5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Fri, 24 May
 2024 03:26:45 +0000
Received: from CO1PEPF000044F3.namprd05.prod.outlook.com
 (2603:10b6:a03:255:cafe::b4) by BY3PR10CA0013.outlook.office365.com
 (2603:10b6:a03:255::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22 via Frontend
 Transport; Fri, 24 May 2024 03:26:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044F3.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.14 via Frontend Transport; Fri, 24 May 2024 03:26:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 23 May
 2024 20:26:35 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 23 May
 2024 20:26:34 -0700
Received: from nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Thu, 23 May 2024 20:26:30 -0700
Date: Thu, 23 May 2024 20:26:29 -0700
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
Subject: Re: [PATCH RFCv1 07/14] iommufd: Add viommu set/unset_dev_id ops
Message-ID: <ZlAI5d6ktg7yncLE@nvidia.com>
References: <cover.1712978212.git.nicolinc@nvidia.com>
 <6e57d7b5aa1705bdd547b1cd2aca93d3bf70dfa4.1712978212.git.nicolinc@nvidia.com>
 <ZkDWXnPW7CaX5TtA@nvidia.com>
 <ZkGZc5dvLigXcWib@nvidia.com>
 <ZkOI8ztR1mUMJ8oe@nvidia.com>
 <ZkQW6/OAQ8MzN6Go@nvidia.com>
 <20240521182448.GN20229@nvidia.com>
 <BN9PR11MB5276EEC2A1DDA9C92F96737C8CF42@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240523150120.GO20229@nvidia.com>
 <BN9PR11MB5276A896D215E1FA61DECDC38CF52@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276A896D215E1FA61DECDC38CF52@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F3:EE_|MN2PR12MB4079:EE_
X-MS-Office365-Filtering-Correlation-Id: de9f0719-6e46-4d8a-6abb-08dc7ba1566d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|82310400017|1800799015|7416005|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?txXGSRwL5o4ZDKAWyL3vDOyn9c+lRh9iFg2a0FdarlgCSjx+Pt24Etep95m5?=
 =?us-ascii?Q?d6qVlP8gnhE0YIloL3ajzYEQMmxLuxt3sIacITnBzUtyaXWQL6lqE03VmY7X?=
 =?us-ascii?Q?Yy8h6rEWkowuxfiF6N5XWTaScOZqKzV5XUek3JKznFhp5o0AqGfdDuTqUEo/?=
 =?us-ascii?Q?+XavvBX3JY/dkurxJf2AZgJFOF6bWqAd2l1+3YTOpZmeGsMIr8iH4lkgyFQP?=
 =?us-ascii?Q?+uSit5gxsBXTiS/f0AI1fPAlDs+fW/R+uG6R2RWKGNEGFy50CO2VCWsfJ2ND?=
 =?us-ascii?Q?pJ5xZDkYJTYVI0YQvvnaOKPvT4jTAluqAeqVJHuqNWrdDIserUfCuGh6iJXj?=
 =?us-ascii?Q?o3y7w4hQaWqOSUwRsxe6iVaHBWJuM2UwOQGU2SjqguOJke/ICcACVrmaSUra?=
 =?us-ascii?Q?QKCz5i97HJOboT0AH/7M/980nB3hhc2hBsCC1c71Q8U7ESJI8yHIGTSjUTl7?=
 =?us-ascii?Q?GBFelbnhEHOkbXK5UNIRwDFWWW048oepzEm3ZoqKmivw96bZ/YmP1ZN/NdPE?=
 =?us-ascii?Q?raY7Kml/3ZlDYMF+55aqecW9tytun3tJzzJyoIFCQNP57c/b6jc2s5Y5eKUO?=
 =?us-ascii?Q?4ABn/pBi3HhKJl398bD8HcCynKPYrlSFLDTOjyp2m2zc9b0f9DY98Fni03tY?=
 =?us-ascii?Q?wStPcJy0H4p8D8lLyWJFS9hsYs4e+GsRAqt31MzddMhhLOEvm8LO5wrreXTt?=
 =?us-ascii?Q?fOu/My+PzZ0Th7j+mU1Avn+ywAnsMaaISVvdxDjJ4RJcR51WFkMvYDKEyIiy?=
 =?us-ascii?Q?taLz71NFcWKWo0d1ZXHVu3LnR1h7aupVsgEFQBWfZR/r2UaVQlA6Gw/Z93JE?=
 =?us-ascii?Q?m/IOvMJL5MG3l5DbJd6UFvh6Drxx+L0ZV8G4sHxU4InICGICuS4/11Kxxsz0?=
 =?us-ascii?Q?7+C97UMSQ0NaZaD0yz4eIglj8cy8P7Nl3Ctg4lvwv0pr3PqbxIBd5k76P8Ii?=
 =?us-ascii?Q?CCh5iTSwrkWrxO1IwmdQQGL56WFubjhf1+EI2p3zU9Nesv7fhvDCeh+6W/mG?=
 =?us-ascii?Q?M9LND9zOcv/pEft0qSwGviT1rplEsnPJ/iHc2qOHHY2zH7Zh16AWm9UvEpcl?=
 =?us-ascii?Q?IB7ENe5fhS9PLFLduavih7CB2cpt4scLZWlSh71b5GhMUHGaWOWzVOuklnaZ?=
 =?us-ascii?Q?m4yBcWHdpDzucQT081vcp8rjGy3GsiF7TTxA1tEDHQ/yIFT6SCYsUKiYBb9k?=
 =?us-ascii?Q?Xtogv7u8+5OMZ6acKS2X9ehS3cVYoswMlO72JsqveRqWatPzjQfhRIEYtDhr?=
 =?us-ascii?Q?cAOuIrarCaMAIPgR1AC1bNBQnBtU6kpNwt9v0ReogkwABda5rCNaKBQW5N5N?=
 =?us-ascii?Q?dPzcYafxdcKtdtn09jRaZ8o4Yx8/8ga2w3xSw+tYaojKFCKcQpFpeWtFJp0k?=
 =?us-ascii?Q?aygki1yxJQStCvaP2RrDeMEiW7NU?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400017)(1800799015)(7416005)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2024 03:26:44.8636
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de9f0719-6e46-4d8a-6abb-08dc7ba1566d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4079

On Fri, May 24, 2024 at 02:21:23AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Thursday, May 23, 2024 11:01 PM
> >
> > On Thu, May 23, 2024 at 06:19:59AM +0000, Tian, Kevin wrote:
> > > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > > Sent: Wednesday, May 22, 2024 2:25 AM
> > > >
> > > > On Tue, May 14, 2024 at 06:59:07PM -0700, Nicolin Chen wrote:
> > > > > So, you want a proxy S1 domain for a device to attach, in case
> > > > > of a stage-2 only setup, because an S2 domain will no longer has
> > > > > a VMID, since it's shared among viommus. In the SMMU driver case,
> > > > > an arm_smmu_domain won't have an smmu pointer, so a device can't
> > > > > attach to an S2 domain but always an nested S1 domain, right?
> > > >
> > > > That seems like a simple solution to the VMID lifetime, but it means
> > > > the kernel has to decode more types of vSTE.
> > > >
> > >
> > > why does ATC invalidation need to know about VMID?
> >
> > ATC invalidation always requires a vRID to pRID translation and the
> > VIOMMU will hold that translation.
> >
> > On vCMDQ HW and on AMD HW the vRID to pRID translation is pushed into
> > HW, and vCMDQ requires the VMID to do that.
> >
> 
> At a quick glance VMID and vRID->pRID translation are both configurations
> of a vintf.
> 
> My impression was that vintf->vmid is added to guest cmd when it's
> about iotlb invalidation.
> 
> then vintf->sid_slots is walked when handling a guest cmd for ATC
> invalidation.
> 
> I'm not sure why the latter one requires a valid VMID to do the walking
> except it's a implementation choice made by vCMDQ?

Well, we haven't thought about a case of doing ATC invalidation
via VINTF/VCMDQ without setting up a VMID, as "VMID" is a field
in the VINTF_CONFIG register next to the Enable bit and must be
set prior to enabling a VINTF, though your understanding of the
HW work flow is probably accurate :)

And the narrative at the top was trying to describe the links:
  [ device ] => [ proxy identity S1 ] => [ viommu [ shared S2 ] ]
v.s.
  [ device ] => [ non-shareable S2 ]

So the first case can take advantage of VIOMMU_INVALIDATE v.s.
the second case requires a DEV_INVALIDATE.

Another conclusion between the lines: since ARM SMMU will have
the first case (with viommu), there is no longer any use of a
DEV_INVALIDATE ioctl. So, we would likely drop it in the coming
version.

Thanks
Nicolin
