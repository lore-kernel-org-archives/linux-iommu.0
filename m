Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AA479C2
	for <iommu@lists.linux.dev>; Fri, 24 May 2024 05:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716530298; cv=fail; b=AU02560ch/P5ufxg7CKRWA+FXVVYWegvKbJIX8lpOBRP04g/K15oODF+LC86gi0+BM9iLNeQQWCY+lkZXK7AIys5ed/GZHPawWKdwLHD5U9eRI6zWhE9JAJnOY/8NXdD5Sdd+fMEtmA7/F/S0/ic2VCPl8Q/KlxFkNkqcrNByVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716530298; c=relaxed/simple;
	bh=4EslP26xd5Dz0bvLUX+AXN0unBa6QERy0smCT8KmIhY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vBXUePKprjC6r2eG9YqGp401tS88eiZ/gH/vrgHet7mDWpNyu2gQBYgLEpGzP69Mutlvf1O9ij8TdhHEl/9KnzwAwl39TSYO4RtPVp3B3BLH+wt4wZSqHbGR9AGNwRfCtMOG/u53gSH7HQpl+jpjJrv8+vnYP0XESRPqdfM2fHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RMnPnrsU; arc=fail smtp.client-ip=40.107.237.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RMnPnrsU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lhw0xLpUhwP3PxLqVLjpL5zyaz7PS6pgDxPzIjW0ObMxriTrwe1CWPRCpX8liYfQdaTIo+wYTE5NfcoDG/n7NtCkC/TAFHKYJBxgwWm2AVJ1MkeUFltg5PdaUkIF6exlbxbcKeAmCrziUhstIg+Xn60cpZHu7o6ubCo14xCJfnC2GWjk80nksPMrPIbi1SNYasdL7GmOVnWYzytEtZXqGVq7lhOmF6YWi/03eZ3wZq1AI5SdqOt1NXGSE5BXvC51MUIIKarSQ9Yf3gWEqG3VFYFyq0Bx0dY/9g08fT2QHiYtw3M78XUX4Zl/tmcbMQx7oTDFZjzDKJfx88uq2U4gQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C8ga4IoODlvtz1cTJyYYxFEYpC9/q42pPmfx1uHiFv4=;
 b=b6unf0D6ImK0/k089ESJBGgKsEoW+R1757FEHo5XbyOufCY3GcdOXV7sQQ9jhbk9jRLiH+WtvsjFtaTCqNG1XCUUlHHWFasQ37Ue+8+yE4Wx2T9JxvcxhdcV/nkc8/w5iDOm3dbiX35ai4EnRAHpQApPolRdSplQK4Iuc9OKZL3nQQzBj4a7bSiX62/UtS5Xp4GMowOGPCefXuFAQPOc4KrmRdO9a/jJCbH9jTCeMLTWVTKzL2W+vNXg5fMBnigh1GFMeEFF6P+fx8REkde1Kl8j7FEIXxesEi85HFM8DQVPIq7n7cXxe8wCmmw2TVN0kEukiLxIYy8Vv/CVmgPysg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C8ga4IoODlvtz1cTJyYYxFEYpC9/q42pPmfx1uHiFv4=;
 b=RMnPnrsUb4Gzssk50kRGbjizAEDGS0ZSp1KBdVQz75QnDH95AOf8wV5vNhP76Bt4WmH6JnuBDjTsJ21vbFFyudJRv5Jmjz/SkhQcY4AZd+LpMiNLTgjCwNTZFLYcXQe23M3czF1DsApm55Jo8OTKQhn25Zgosm6JRFVibqYU35yzdJ7zn1wKIJA6GD5dIxCT9U2EZcKnbnBUczcSjiQgDJOMWD+2nVy8bwdGbYPiBE8lXk+fTWgdg5Yx4eKAlOSjHDogFo120hEuZFtOrankBDvZKdH7/b50TxDebHps/TLLI0pKS7HYCeuVPCKFsS/vOGbsrOEuDyeEwkJrbU0AdQ==
Received: from BL1PR13CA0008.namprd13.prod.outlook.com (2603:10b6:208:256::13)
 by MN0PR12MB6319.namprd12.prod.outlook.com (2603:10b6:208:3c0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Fri, 24 May
 2024 05:58:13 +0000
Received: from BN2PEPF00004FBE.namprd04.prod.outlook.com
 (2603:10b6:208:256:cafe::8) by BL1PR13CA0008.outlook.office365.com
 (2603:10b6:208:256::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.12 via Frontend
 Transport; Fri, 24 May 2024 05:58:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF00004FBE.mail.protection.outlook.com (10.167.243.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.14 via Frontend Transport; Fri, 24 May 2024 05:58:12 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 23 May
 2024 22:58:00 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 23 May
 2024 22:57:59 -0700
Received: from nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Thu, 23 May 2024 22:57:53 -0700
Date: Thu, 23 May 2024 22:57:49 -0700
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
Message-ID: <ZlAsXatxsopbz738@nvidia.com>
References: <ZkDWXnPW7CaX5TtA@nvidia.com>
 <ZkGZc5dvLigXcWib@nvidia.com>
 <ZkOI8ztR1mUMJ8oe@nvidia.com>
 <ZkQW6/OAQ8MzN6Go@nvidia.com>
 <20240521182448.GN20229@nvidia.com>
 <BN9PR11MB5276EEC2A1DDA9C92F96737C8CF42@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240523150120.GO20229@nvidia.com>
 <BN9PR11MB5276A896D215E1FA61DECDC38CF52@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZlAI5d6ktg7yncLE@nvidia.com>
 <BN9PR11MB5276422CE4B77D262CD292208CF52@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276422CE4B77D262CD292208CF52@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBE:EE_|MN0PR12MB6319:EE_
X-MS-Office365-Filtering-Correlation-Id: f1a9cd47-3e8a-4fe5-d4c4-08dc7bb67f5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|376005|7416005|1800799015|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LWijDOCUJXKzUJMjlBXSck0HT80VtlqEiH4VtFXYiEYRr+dNAbMqV9rYuWGr?=
 =?us-ascii?Q?zo/xfU6dR6JcxWnzGUZFgt4/g6BANUBhYkCjhxKulAfyRQkZtyG1+llYvPTP?=
 =?us-ascii?Q?T6qDh+5/haMt7RHcbAVJHdOPzdT4Huz6wxOKzEEqdW00r7ohmwRMgXL/wVww?=
 =?us-ascii?Q?rz1ROO2tQ8mNwl9oQ9JqKXS5nGdtPMsFteMAyc+i+W6ljpN8iRbeLUo5gwiv?=
 =?us-ascii?Q?YX491PQH/OusK8AxPQiw7Iz5SR+0HlyxuONbhe4HlHfDGvMxBoEfggfPX4Hr?=
 =?us-ascii?Q?uVX+gDLqI6VldcuqUogMT96/3/F1EB0U76e76cXhgvJbZ2fp7EyTE/1kS/db?=
 =?us-ascii?Q?TS81B16y/C21zQsSqCBgmxLVtqMWpCg7jejFPbD6i7HGcruh/4K9yEPAxIFA?=
 =?us-ascii?Q?ChbPFwD2jsqlQLS+BttuboT81fPEWcvpTK0q/DspvH6GGD+nAjmUDaDwBmI6?=
 =?us-ascii?Q?RrLaIY2+SWrDLwEfEfz70EuxDSREL4a+N7CFoicbjRN4DfbUyvcWcrXQfRuP?=
 =?us-ascii?Q?OZIElsJapRkAjZSxLk4s9rx22JN7BTSLYYZu7UhxWr5nTgaW5Z7YZ+kfAd7X?=
 =?us-ascii?Q?4T6FFh9af01FuOqlZMY3gNtiaHSCJ78Dz5L5BYawTGJZHhXtU+5/ym2V713w?=
 =?us-ascii?Q?OfrRehl5k4nvzQA9hOO73PKURATcyHtIOePWcQcvDphKJgfLXGZQrBXNYxkY?=
 =?us-ascii?Q?wYIxuBCeg1dXUUA3YRVDlcz/RajsVQTQnrlwQEAwR/lX0Ymbf45W+8z0iVHo?=
 =?us-ascii?Q?XX1G5JMuhIRVr3cxtEjvSuirDxB9Ac8Mi8qsLsoCH+djg49K7eJNJTcFD/8L?=
 =?us-ascii?Q?9JRcKrF9D5W1+UCCKy86NLsf0Ll7tJdYVu6KDV1fV7DYVUusQh5oe73KOFGe?=
 =?us-ascii?Q?WGYjdCEgQa5GV1QkPQ8SEW304OqgSe3GrSa8Y/WrTKJGmp4C9SHCVt0JgekO?=
 =?us-ascii?Q?h1Q+NkL8D6pzxLpARFvTjo1weOoUcEDd2f0xFmupMnPmRLqFM5iLGlIR8PL2?=
 =?us-ascii?Q?qO7MsLvbwaIqKoXCU/mzRpdWLo1uzmAG80lAXOT/hk4gc9iB+wlHDbmn7oWp?=
 =?us-ascii?Q?kj5hFa6/37lzFTBiPXfYy0jPTCAVYMjjuvC4tCeI6PixqBweUacKE3EPj8jb?=
 =?us-ascii?Q?CJ7C94maHyqfyrzafe+rxV0EI6/+TgYbTmjelt5Mz0XL6d3nvUQ6lZU0K/Fv?=
 =?us-ascii?Q?HGoWjia/B3PM7/8Bn5OvEX0DeymtSoU7C3B2SnU6IwWLqMRZ9ggxEreJ6vAo?=
 =?us-ascii?Q?ogwRLVOsSombr0vEkazupcBn6FWXnjl2ZS0KQ5PhsCoLrpp4BXpy/sKbPeir?=
 =?us-ascii?Q?FNVQEZD/tXxicqIbRQjV8HyvhFe+ispqYyjCBkeL2twvSTOReBT4mKY2W4Gw?=
 =?us-ascii?Q?IoqI1yCI5S1UagWqYrW9QiEUe195?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(376005)(7416005)(1800799015)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2024 05:58:12.8791
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1a9cd47-3e8a-4fe5-d4c4-08dc7bb67f5c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6319

On Fri, May 24, 2024 at 05:24:11AM +0000, Tian, Kevin wrote:
> > > > > > On Tue, May 14, 2024 at 06:59:07PM -0700, Nicolin Chen wrote:
> > > > > > > So, you want a proxy S1 domain for a device to attach, in case
> > > > > > > of a stage-2 only setup, because an S2 domain will no longer has
> > > > > > > a VMID, since it's shared among viommus. In the SMMU driver case,
> > > > > > > an arm_smmu_domain won't have an smmu pointer, so a device
> > can't
> > > > > > > attach to an S2 domain but always an nested S1 domain, right?
> > > > > >
> > > > > > That seems like a simple solution to the VMID lifetime, but it means
> > > > > > the kernel has to decode more types of vSTE.

> > And the narrative at the top was trying to describe the links:
> >   [ device ] => [ proxy identity S1 ] => [ viommu [ shared S2 ] ]
> > v.s.
> >   [ device ] => [ non-shareable S2 ]
> >
> > So the first case can take advantage of VIOMMU_INVALIDATE v.s.
> > the second case requires a DEV_INVALIDATE.
> 
> and one side-effect in the first case is to save one VMID for
> non-shareable S2 hence improves iotlb efficiency.

Hmm, how is that?

VMID is currently stored in an S2 domain, actually. The viommu
is a VMID holder to potentially decouple VMID from S2 domain,
because VMID is per SMMU instance while S2 domain is shareable:
   [ dev0 ] => [ S1 dom0 ] => [ viommu0 (VMID0) [ shared S2 ] ]
   [ dev1 ] => [ S1 dom1 ] => [ viommu1 (VMID1) [ shared S2 ] ]

By the way, we can also have (very likely our initial version):
   [ dev0 ] => [ S1 dom0 ] => [ viommu0 [ non-sharable S2 dom0 (VMID0) ] ]
   [ dev1 ] => [ S1 dom1 ] => [ viommu1 [ non-sharable S2 dom1 (VMID1) ] ]

Thanks
Nicolin
