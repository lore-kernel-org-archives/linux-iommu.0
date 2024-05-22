Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF17A3D
	for <iommu@lists.linux.dev>; Wed, 22 May 2024 00:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716336847; cv=fail; b=Ea+4HTcsejqJGCQ0yvsOQHU/n3VootvSH3VD1qWPPU3rcs8xlOCKeTdPv2orrr7xuVjbxEeKK55bhohF3Tfsin2DmqJThmUJpUYOmQpdEMEJ8RNOb6eXPGai5G6qtR+fLSeyQuNfW8lIjMVQ7aRuPVBvh6mru2LnpUHpMPbgGOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716336847; c=relaxed/simple;
	bh=69w8G1kPmvZZOnSRgGGihU1ccTd56a15DVrRlyhCy/k=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wmpq9Kub+1ebbbP+XmgF07lri7SjTWUsbhY1dNdsne9GOjl5UFg5dBkneIhQxIPwj5DcQm6oxpo5TaVq6eRaV05v8MS2AfH/UTpofQLf81t/VzKpXVpr42kKCF8yldI5BMWl/VOJxhbrzGYUTfwhWXCwBYKkDEtk4AL/s/pHOVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=O2pmAO4F; arc=fail smtp.client-ip=40.107.243.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="O2pmAO4F"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A6pKEURBjJ/gpouMW4G+sj+TcyKpPrWZB2kKtYZcygRfn6U7jzWL9vjxMZE+vlTjnkO5vSzWK0BoznTTO8vykEvucnjAW/LIZ+gjOxb9spWQPfJMY3GiTDaZDajHv2HgbAXJdfXyPhmx38T4IQp+OyEu7GUG4rzQk8xJlOtQyJAIKzkEcwL12TcSWonLvG7mxQWJ+TpCA8dVISKmbCF5aJCqC/U9It/dkRVOJTWdENtSIyKFwX+VT4GHAnPkoXYkE/IYa9/0eqQ9Ot6ChsKgNaRYv7uf5MAgR584GcRiZhfySTTNRHh/jqDF60CZJk01dkA2hkhSVz8pmwEmAIZbVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YmN3OeyLwKZKU36nOy4NyEaoEB3HZIlQUUAQyS1fY1E=;
 b=FCetXeRvSZm2IbwCZJpn2tZTPKj5LXlLRKPchUNPVBSavIs+GIqfMq0hq3ZyDYz8bp0gi+/Mlmt+lLiw820aA2b4GVcNtWKFxgvU8FB+yr9zUJomsnfLxe9wMz/sTrNuDwIJctNPjFOSyO8LbXW13KL/Nah5oxwm+AMslDSGlYZ9Gv+SH10Is8brqG3tu6o3B49fdyVXiPoMBokPsttyuAVd+4epQipOPkafSaAVSvTa7dMS8A21JhT8d6YbnD4HLtsUKSzV9HW3oCPyDX+4XkUGQRfDkJXzpd4W4qaNt0BahNXSPAHD7Ckq0YewOUZKrOTexyspYC51vwLTyRVuVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YmN3OeyLwKZKU36nOy4NyEaoEB3HZIlQUUAQyS1fY1E=;
 b=O2pmAO4FDfhkzxLoPwCgEjoksMFa43iHctjBWaK2+aDRJf73Qtf/uTVkigOsnqctTpZgIzJ0DOjyQ4hvRWGcd+LlTnt/NB+0K/oTX2zgmSifMSVlVtDnNQnw4GJC+aCK54+tJaH/7uWWq4aW8NH1eDG/WOJgZAX2+PYYYTe1hoN+s64cp5Z5Ik9OzRC8DFw7nRKKCAwDz0C9ZgfBDTT0DktxIZ6DAoWcaHsoeLv7qYRk4G3wnvCCM/chJiDjZQR1AQ0ZXfsp+fTlTh6C3lWwHMlpjZplwwaL/hwp/hTxxYkswCsu6TzTBRejumjtPSUh0XkpqY92CSEIfY0I0MoqhQ==
Received: from DM6PR12CA0021.namprd12.prod.outlook.com (2603:10b6:5:1c0::34)
 by DS7PR12MB5982.namprd12.prod.outlook.com (2603:10b6:8:7d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Wed, 22 May
 2024 00:14:02 +0000
Received: from DS2PEPF0000343B.namprd02.prod.outlook.com
 (2603:10b6:5:1c0:cafe::ad) by DM6PR12CA0021.outlook.office365.com
 (2603:10b6:5:1c0::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19 via Frontend
 Transport; Wed, 22 May 2024 00:14:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS2PEPF0000343B.mail.protection.outlook.com (10.167.18.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.14 via Frontend Transport; Wed, 22 May 2024 00:14:01 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 21 May
 2024 17:13:57 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 21 May 2024 17:13:56 -0700
Received: from nvidia.com (10.127.8.10) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Tue, 21 May 2024 17:13:52 -0700
Date: Tue, 21 May 2024 17:13:50 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <kevin.tian@intel.com>,
	<suravee.suthikulpanit@amd.com>, <joro@8bytes.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<yi.l.liu@intel.com>, <eric.auger@redhat.com>, <vasant.hegde@amd.com>,
	<jon.grimm@amd.com>, <santosh.shukla@amd.com>, <Dhaval.Giani@amd.com>,
	<shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH RFCv1 05/14] iommufd: Add IOMMUFD_OBJ_VIOMMU and
 IOMMUFD_CMD_VIOMMU_ALLOC
Message-ID: <Zk04vnqJPKsVtrdY@nvidia.com>
References: <cover.1712978212.git.nicolinc@nvidia.com>
 <3aa9bc1df6a2ee58a03c6ea6ededbc210a2d23a8.1712978212.git.nicolinc@nvidia.com>
 <ZkDR4Rp57cy9qSqP@nvidia.com>
 <ZkGYN36N7sh2vUmv@nvidia.com>
 <ZkOFkfHhG2h2fv/c@nvidia.com>
 <ZkQNxkYv23z7i6e0@nvidia.com>
 <20240521180555.GM20229@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240521180555.GM20229@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343B:EE_|DS7PR12MB5982:EE_
X-MS-Office365-Filtering-Correlation-Id: 75a76fa5-793a-44c3-8dad-08dc79f4159d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|1800799015|7416005|36860700004|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EkkbsSUwZEoiV7kGQbfnOnrMn7ZNli8E2uhUqdD6mrHi/2worLEWoWU3YOQZ?=
 =?us-ascii?Q?cp+zOor1Bjd3Qqxv+gokbyFL2tiSraWre7FerWEuqcA/SUXYTV9Vw77yIevP?=
 =?us-ascii?Q?hR/ph764PeYPRNPawPrVZ7/nNoQjR6do37shfu79MwgkQLsCmvDbUy3JzeAy?=
 =?us-ascii?Q?OGx8VCGvip+bU69p9V3OzYjM0Kumd3FMLuuslRk7QhKTRc05gm41vodq0LeF?=
 =?us-ascii?Q?1AzxcngNzlpDjtA07IjAwuUZYnisE7isvPFkmG99stJCcTkg/y84vxHwscr5?=
 =?us-ascii?Q?6X9oGo+wcqoY7xHm4JOquJrPfN83xP4aIon4JE02/izZ4DQUGm0MQy0JOuCo?=
 =?us-ascii?Q?sZ76kT+PXdKL/QM/fsEE1S5rq3Ow9IlBBIpo/CUDzcJX3rWdZl33Yc4OU/8n?=
 =?us-ascii?Q?AoWxY/Ygq7MQ33KGzcO0fDZTFBw88w/4i1ktXjnHDrZpKVe8DQotP+oslofZ?=
 =?us-ascii?Q?39+3Y49u+JXtH/0QAOywjO2GO5NHBCo+bsdGoD1P3HJffZP+pCzWMuLIqSHB?=
 =?us-ascii?Q?C7kPaBsB1Y+8QtehsK3cu1h4f+ODIhmEZUruOshOh6mcbF2FZDxPX8VuTV1T?=
 =?us-ascii?Q?Cn+vJxBgMtaV8ysCsjQl90LFOvH+SAw3FS990HQdroiTfaF2Ch6brBY43H3/?=
 =?us-ascii?Q?DZ+7E/AnmMNcRme8g1kgABVI/0PgUx5yIq+Nx028+gUpf+efKVqxKA7Agkbb?=
 =?us-ascii?Q?XlY3UXJ5IJyGtoLfTRC/GSQVV9dC5F1UmLC0OKoA3CKe+z4dDsxLUlg87zm8?=
 =?us-ascii?Q?9qw12Gts4dEvzK/Uurea/drn18fGKaXf/RNnwAVCVf0wUOLpMB0kWoQJZ8b8?=
 =?us-ascii?Q?WgGNpVSJtBt5YdzvqP0q5DHxtGNIrIxRDNJjhH9rmNF3o4n7Y7Vv8b+P65wi?=
 =?us-ascii?Q?yvh2crdp6D9hTWMe1aDnOaX6/YM78AVHNv19slw3J9wBt8cULocs9sFxv9Ed?=
 =?us-ascii?Q?jGYLjO0pBKUL9h4teJiE/gpeKnlTQoMTfQHi061DmTtei1CGLSA9w4KXRqI3?=
 =?us-ascii?Q?k1D77J3Chd3cFeBDDybOMlKsKh62hsTRncrnBPAmKmDagsFttBbQ/dmFZH5Y?=
 =?us-ascii?Q?ptllyg9OyrM7s02FBW9TI7Rq0DVX1yIFY9qU7hJ8pxXF5mCukf088u59rzlA?=
 =?us-ascii?Q?I9qorU8/kNIAUPOqI9VssZcO4bBZ4SA1n+Lp5bpNDH1Sr1fGhndi4SaHcvh3?=
 =?us-ascii?Q?75tiD//77LM6PrGruhQz8bxgLfG1FfoA7WqYosvEGqak1iLKa9yexCuUZ+sA?=
 =?us-ascii?Q?tuBMjKWLZcz/HVR93mtw5UeUIJkQCWeNfvReZBKC0OD2Ni4CeC+TR+yWA+nW?=
 =?us-ascii?Q?kkRq+W0y0RR4k+zBYKGp7ryT27J7wy3on19GhH5tDp/f4z6YmQMxkHQ10vOw?=
 =?us-ascii?Q?yStgws2H3TYFv0SI7EAQRTpHru7y?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(36860700004)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 00:14:01.9989
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75a76fa5-793a-44c3-8dad-08dc79f4159d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5982

On Tue, May 21, 2024 at 03:05:55PM -0300, Jason Gunthorpe wrote:
> On Tue, May 14, 2024 at 06:20:06PM -0700, Nicolin Chen wrote:
> > > I suspect 0 should be reserved as a non-set value for some
> > > basic sanity in all these driver type enums.
> > 
> > We have an IOMMU_HWPT_DATA_NONE for HWPT_ALLOC to compatible
> > with an S2 hwpt, since it doesn't need a data.
> > 
> > Maybe we can have an IOMMU_VIOMMU_TYPE_DEFAULT to be 0, for
> > an IOMMU driver (e.g. VT-d) that doesn't need to handle nor
> > be aware of any viommu object?
> 
> Seems like a good practice, and perhaps userspace will find value in a
> generic viommu object that is always present.

Yea. VMM is always allowed to create a viommu to wrap an S2
HWPT. Then, I assume iommufd in this case should allocate a
viommu object if !domain_ops->viommu_alloc.

> > That makes a lot sense. I'd need to go through QEMU code and
> > see how we will accommodate these two more naturally: likely
> > the QEMU core should allocate an S2 HWPT for a VM, while the
> > viommu code should allocate a VIOMMU for each instance.
> 
> I'd suggest that core qemu should allocate the S2 IOAS and pass that
> to the qemu viommu driver
>
> The qemu viommu driver should create the hwpt and then the viommu and
> perhaps return the viommu or hwpt back to the core code.
>
> If the vSTE flow above is used for identity then the qemu viommu
> driver would also have to go an create vSTEs for identity and attach
> them to all devices before the VM starts up. Then when the OS
> activates the SMMU it would have to mirror the real vSTE from guest
> memory to the kernel.

The entire flow makes sense to me.

> Not sure there is value in having the core qemu code directly access
> the hwpt/viommu?

I think so, though here might be some complication here.

On one side, it may not be straightforward for a qemu viommu
driver to hold a shared S2 hwpt, as the driver is typically
per instance, though I think it can keep viommu to its own.
So passing the S2 hwpt back to qemu core and tie to iommufd
handler (ictx) makes sense.

On the other side, there can be some future HW potentially
supporting two+ kinds of IO page tables so a VM may have two+
S2 hwpts? Then the core would hold a list of S2 hwpts and the
viommu driver would need to try-n-allocate viommu against the
list..

Thanks
Nicolin
