Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2059.outbound.protection.outlook.com [40.107.101.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC634652D
	for <iommu@lists.linux.dev>; Thu,  6 Jun 2024 18:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717699523; cv=fail; b=bl1EYpPwXn8HtPhrHgwSixM/kUHEgXO3lPYcThCFeVmsCcTretGF3QfYOsPTbJYzKqeuTRnHEIq16leT3vUUMa+5HckZTqxy8rK08cvTKTrRZ9HfdKaOBYOd45j83iFhc0LVM8J3v+s0BSn5p4Xas1pA54ZtZJ+1wDSsDREUzb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717699523; c=relaxed/simple;
	bh=y1pkgsDTsGQXeYq+O23ikZxMwuDFzGGVcGmBTXGnxMc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u919Fbf1PL+XY6UBg9Iok/2K+mwwlweHtuTybiIJ1xMkRVuwj2tMj3B7eQg87RQUTiEbMpSvOPr6GLVSN2v30gv5BrOdx9VKTkABPh7DKg2kstJcGy70sO9rpl5VRoDWg0Xwr9yqwDgOQh8Ays4OU4cnrZ+QHnU/05YAaAdg+ZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nFpH/lCz; arc=fail smtp.client-ip=40.107.101.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nFpH/lCz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VJT3qgJvuTfE7lQr29XneZ2oPS97+tHYIS+fGS4LR6VCxCNGes7wOSfu+9h3NKK+qBq7xrX+RDtgFxevQsr6adDHXcrXLGRXbzvMA9DHCo5A5SqABr3ol6/1khNg4GSBnWXZaG4eNFXTc9xmt6DK8VxkxxkZFTUXuZMCQv6YuNC78VKICOj8EJQNfDM9VrutgahmJxYr8mdtxugWUhYBOcClxyQUkHK23W1lfHFyiIwfWmO7giD63YA9DmdkNTZvPLQbUiqY5boBwpL6VwPVUTjcrTgMSri/0mkVtefvrKC95mWmsboH/l5tlzQO+LLI8KHoV2RsDAtYbcDONG94jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DYSgA8Ab/29JkzZQs4QF9l1tc1SwDPJ0O/tHJ4/BpDM=;
 b=Js7AQq9HVnOH6aaym9VVbcaeogFtX+OaaSi002fPosh/vgGS5rHi/crJqgjaM0JOQVpyidtRpl7U10FCuBvt03NMeoG23ezq+LoPaJkUb9AJUIlvvR/rht59ZGgr7cnmRjpLOaRWzLGQKZ2E7MdZ3t0qDCFW6ervJcLwEA+lP24kQVLG2n2igoGHdqLvs65fLqDW3vRTXi7zAAkAi5yyoiZuCQDjp0FU8i2UtHsRDLJ0mTOYbpOSwHqA21A67nVyeosnZ5ZDozgiyGWBq+k7irpzsSMDYQSXBipvh3D7o9FRs+ElScQYOZARy3xQrzOtCeLgCzkvw3hmzGhuqSl6Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DYSgA8Ab/29JkzZQs4QF9l1tc1SwDPJ0O/tHJ4/BpDM=;
 b=nFpH/lCzRCYtIrKRd+wK2xqGRYZ+qqecCVNmcT8Us9rj6pipNYAmVplGqp8/RNoDFwYQEmrgOKyCM00gdjmyd91HEHXHBLaCAAS13D1oGqDbkFCegsBcj8GR2pe1DhSxNJ0zz53xKkbSSYFMqD9IdHGwu9976qFtCcKnXnn0F6zeZlV8jP9wEEt4Tp0+FZOyCtvHZrCG/y2+tix+91pfZW5QbqgUWnX7pecOIe+Rkw9OMlrrzSIJZOOnboCebx+mEWHhdZkR4NgGKmJXFirBa8BhtOmrFpPeKbvCvOJYccAL1flDp6WZ0jjDVm8nVcGge1PBVuHtZ0RfOm9e5OD/+g==
Received: from PH8PR05CA0017.namprd05.prod.outlook.com (2603:10b6:510:2cc::29)
 by SN7PR12MB6716.namprd12.prod.outlook.com (2603:10b6:806:270::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Thu, 6 Jun
 2024 18:45:16 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2603:10b6:510:2cc:cafe::59) by PH8PR05CA0017.outlook.office365.com
 (2603:10b6:510:2cc::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46 via Frontend
 Transport; Thu, 6 Jun 2024 18:45:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 18:45:16 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 6 Jun 2024
 11:45:01 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 6 Jun 2024
 11:45:01 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Thu, 6 Jun 2024 11:44:59 -0700
Date: Thu, 6 Jun 2024 11:44:58 -0700
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
Message-ID: <ZmIDqgfINXfB0i3L@Asurada-Nvidia>
References: <20240524131912.GT20229@nvidia.com>
 <BN9PR11MB5276BBD592021507C3A0EBB38CF02@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZlY886FT3HHLC8Cf@nvidia.com>
 <BN9PR11MB52762EA9B444DA71F551C3868CF22@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZlafEktUu5znDsNt@Asurada-Nvidia>
 <BN9PR11MB5276AC43120376A2502D3D148CF32@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZlfPPwsnY6P4SoGF@Asurada-Nvidia>
 <ZluWXYQjroz0fqqn@nvidia.com>
 <Zl03rsgZl/msa3I+@nvidia.com>
 <20240606182423.GF19897@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240606182423.GF19897@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|SN7PR12MB6716:EE_
X-MS-Office365-Filtering-Correlation-Id: e74cda1a-7fb5-4d54-9c51-08dc8658cee1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|376005|7416005|36860700004|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZdhMbIT0O79yj3VZOEnF/4bEDwYHqQTQgdOXtMKNWoHip2NJiRdL72+ZvyaC?=
 =?us-ascii?Q?WP3+uTUUi/B2G3CA8LruO69NumOxEQtkVlNcY2oXr6gi8kIqoybTUZXI3URW?=
 =?us-ascii?Q?iBUefLwAfydGVW1sDa02umPfBQ4wASBb+ySD3zy8NUE/IMyxUWnkT0xvJKsK?=
 =?us-ascii?Q?+gW4sNAzzzXXS6WF08PP1/qUb2P1mQgQSst865UG++ES4TduV+ub/J1ua9w8?=
 =?us-ascii?Q?NR8laMCbXvt7o8KsinmID8QuJDPYmA97q7SMZEl+A8NZp3lSFCAr3lJNbwiw?=
 =?us-ascii?Q?FQg0stAMvQ9pW5urwD12RF9WM4q/M5TXFOgGkkHNdpnW3KoGJL7yQBSIZPuK?=
 =?us-ascii?Q?d4fgv4erHgLxmKlZUTtis6iA5rCLQBzBF7/+ggRLl4t55y0Xj6zeQ3OyGx8L?=
 =?us-ascii?Q?rwMtOfw3jKoz6GPH/WqTobOLsz2mQ/x+5dg3Ouf9y8TL/RfSsJ6jLiwfvn17?=
 =?us-ascii?Q?b2QpLvmGklUJY2dXRZcFF9bXHddENGBmNwdNUmcMWm8h61XpHqcwf0oRDe7k?=
 =?us-ascii?Q?bylCLFaQkx3rWUf2V4tK92jJJYdT1pYhhLeW7bK56oJX8G2N4sDMoGF/aqmO?=
 =?us-ascii?Q?jIDkgoCB9EQToT43yUZbreRa7W0dAcckiPz+zYqjVy1dXVGDeh0dwFnoMZXV?=
 =?us-ascii?Q?fdzxR911ApDdMzLjC4R48O/xOl0m0okgJ0QerDs9ZreONuavmmCagIBWTqgF?=
 =?us-ascii?Q?C4UihI/hJMAp+SS6Blzqlr8RCWZA+utk6zx3HTsaVi9J0B91mOwDz5j8Y0EF?=
 =?us-ascii?Q?7HstdLIJQtmF9t/PCVwheWMoYflZNAOxZXEV1li8l6pwDQkf+ZwYeoFOrDD7?=
 =?us-ascii?Q?j82mkKNdnQn09+0hvKDtMEdNslJtUen884bGShkbjffJIh1rWEp51/anG4N/?=
 =?us-ascii?Q?KMJkmaiyyWTbE0KoHKy9srBEDXWqbM4lkrZ3Hj1yQX3mp256kRTtRL69StPr?=
 =?us-ascii?Q?XeE076CqWd7Ue7rqRCthGzdv2MuYj3sWCGlWgbL1uXv9o4ElqnRz2LMf7w/p?=
 =?us-ascii?Q?S7KseQsxB7nqpSZ9uoyCfs9KxWR4wdLCupMcYBsCVIkKZtH1MDrwbOnGDelV?=
 =?us-ascii?Q?bo2c/bG/391YfRQKg6X3eYYoqDYTc49Mi2LK2lyTXYCrMD0ecgDJun9bFX7l?=
 =?us-ascii?Q?e/UR9rzaz1uh5pNnzTvarkFRMUb27aAqcFhGFxf4/ciARZ9ZtIlpi6OSjN5H?=
 =?us-ascii?Q?sN/vV5Acq7lta//BiK5oNsyLNFO/h0GDPYSIkkPWbLLk44TxbFerlRtwjwIK?=
 =?us-ascii?Q?8V9mKHJ/Qy9rPUhPsz0RwdEjZ+OikCtbnKuxw1VR7DGsx7QuRqAoEGbyAxVv?=
 =?us-ascii?Q?huASvjRZdjtOopwITvN/Mhn6j2Nj3BCpJiU4z/Iqfpe6eC0I13Q5x+eaQ00W?=
 =?us-ascii?Q?jIibkkOWlMYJ7GqLFt0aJ4/tvKB5SNlmloZunXnXcY1EVMDi7g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(82310400017)(376005)(7416005)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 18:45:16.4810
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e74cda1a-7fb5-4d54-9c51-08dc8658cee1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6716

On Thu, Jun 06, 2024 at 03:24:23PM -0300, Jason Gunthorpe wrote:
> On Sun, Jun 02, 2024 at 08:25:34PM -0700, Nicolin Chen wrote:
> 
> > > I understand the appeal of doing this has been to minimize qemu
> > > changes in its ACPI parts if we tackle that instead maybe we should
> > > just not implement viommu to multiple piommu. It is somewhat
> > > complicated.
> > 
> > Would you please clarify that suggestion "not implement viommu
> > to multiple piommu"?
> > 
> > For regular nesting (SMMU), we are still doing one vSMMU in the
> > VMM, though VCMDQ case would be an exception....
> 
> This is what I mean, always do multiple vSMMU if there are multiple
> physical pSMMUs. Don't replicate any virtual commands across pSMMUs.

Thanks for clarifying. That also means you'd prefer putting the
command dispatcher in VMM, which is what we have at this moment.

Nicolin
