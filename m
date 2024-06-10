Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BA2481C2
	for <iommu@lists.linux.dev>; Mon, 10 Jun 2024 23:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718060697; cv=fail; b=EncjyZCDesv5MJpjnJy82ay0R9R9z3wms1tDoT3fu//ii4ekHABzUboA+o+legW9hDbUZjXgK+Rsp7ztu0ehDDSXHx2O/AulZ5pqtvxtNyKiztgQ6oeF4WSyku4AsCiXypHz0auks/H7lAilIXmn9tRIaOKIh0wOkGPXb5NRYKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718060697; c=relaxed/simple;
	bh=xbFmiHE1/usglybq5PG5dAfEWVuywkbiUoSqlkLcaYQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aO2jj2ahG+HJ2qfL6tSDKogp0iEkzn+xV3UL3LuENzI/tS1zGMzZN2kekWQPF/bfiGDdqdBmmtBsn4CPIpkL9WFHNtah6rggRwG8MpDQHH0RCn1gnDFcjIZP+QWu/VHT2JMAwPAJbFAmxACt7/a/LtJtiY0zrKVIGlBMxy59Vnc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Z2WUH0qo; arc=fail smtp.client-ip=40.107.94.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z2WUH0qo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mSGv+oDjzuoMR+IhannMzoqpWkRWonNyBIi1CUrgqGe6vd/MOfximpRivf1Nskf12IzXyL0y9Nmf/0RNu8ry16qX++p19HzyfhaLuXF1ZfZBRffR1TRldKHz+SAfuciRntd83acu6ZWLxEr2mIla5v9F6xMnWPNhfeDUid4I5pCC/nH0L5WGg2Gt3muA+k+FYMNDpvn0SY6ZWq0Y7gwqwM8JFj0szE0NiJlbcFsy/T4HjGH9KctYGFgYI0tD8Tm21QBYMwIL7w7rOrOQ9TCU6AEyeTa96R6j7yqAtVnxL15XgitgX4SxD9fgVUPfpoMOZnU2xytMfdmVxwXKD6kBOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6CyaCdjlOUcFKaeWuYbBNysV8MexrY+9hlmVhNGVXhY=;
 b=mWqu1oI1Em2Bkly6Mjhf32S10PPSW6AN8owH7vlKjewEtK+y+o6ytisoXgtTn40YHl5wC+EjCfMIc77Ipfavr5UV49mzw4NsC1VJV6+DC/nCHSfTRU+NcCKLxa6Wb9CT19M4NLj/Ki2il/FzS/T4xSyKUZRFh5gqqJv2cPjoleKaBTaL6UdKJ6ygLSzJU3+GwhtFMmUdo+oThsbuSc4f8iU192SNBpjB3Ps4krSCuXoVszd3QHswZwp65rEm7iArjGH54NOEF1PgCHCeA+LW7aGgkqpRRFMjJPzVyrFKslZs0y1vqBkkyweDKRr75PXi9/ehRhJqEqOElM6cuZMZcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6CyaCdjlOUcFKaeWuYbBNysV8MexrY+9hlmVhNGVXhY=;
 b=Z2WUH0qofkpXeeO3zj2Uyz5YUKtM2Y2fL/GytKmVQvSacZ13Y0bd40YU/9+YMtLQvZgDMmx0AOpNd3pvWssgNdhSUFCySs2uAMki2rJje/utkAHstnjdRRmG/g4nh4o6hmASd1rl+5rMchWv+rESUNtmEahcK3hlqQajP0VGU2pj7xsMNcpEkFgJE9bm261bRbEN3zhpBWkbUJFNyBCSxQIeNYwS6jf0Kdnirpi9mXoYEvJ5E6j6qrULn0l9msYoQbUJzr2E74Q3TvMAQsfSWNdapUuLhlD1/Nn3WRA6UMrI0bXGAylGQaCMYHDf/P5ZF56H6PHulxTNdsXbMV2Ggw==
Received: from BL0PR05CA0012.namprd05.prod.outlook.com (2603:10b6:208:91::22)
 by CH3PR12MB8994.namprd12.prod.outlook.com (2603:10b6:610:171::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Mon, 10 Jun
 2024 23:04:50 +0000
Received: from BL6PEPF00020E61.namprd04.prod.outlook.com
 (2603:10b6:208:91:cafe::73) by BL0PR05CA0012.outlook.office365.com
 (2603:10b6:208:91::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.16 via Frontend
 Transport; Mon, 10 Jun 2024 23:04:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF00020E61.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Mon, 10 Jun 2024 23:04:50 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 10 Jun
 2024 16:04:33 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 10 Jun
 2024 16:04:33 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Mon, 10 Jun 2024 16:04:32 -0700
Date: Mon, 10 Jun 2024 16:04:30 -0700
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
Message-ID: <ZmeGfqp26c3sGBmF@Asurada-Nvidia>
References: <Zl03rsgZl/msa3I+@nvidia.com>
 <20240606182423.GF19897@nvidia.com>
 <ZmIDqgfINXfB0i3L@Asurada-Nvidia>
 <20240607002707.GJ19897@nvidia.com>
 <BN9PR11MB527604637EC37B3B03FBBE468CFB2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240607144917.GK19897@nvidia.com>
 <ZmN5WZkvDeIS7RRH@Asurada-Nvidia>
 <20240610120446.GP19897@nvidia.com>
 <ZmdbnGnp73yR36N5@Asurada-Nvidia>
 <20240610220110.GQ19897@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240610220110.GQ19897@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E61:EE_|CH3PR12MB8994:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b356810-416d-4b23-fac9-08dc89a1bb69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|36860700004|82310400017|376005|7416005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OJPRA/FvEUwv7udAP5emaVYI2o++U/yDjETj4nK4g8FSldgG8hXb5xZoP+db?=
 =?us-ascii?Q?vpxI1oySEHBfcHA+2/yJ126VrQo9XwnHsP0I34OjwHDsKrjy892ysJ85Om7U?=
 =?us-ascii?Q?4vePSXCdE5XMtmAf70Mp0QlMUlkdPYk8pBhWR7+qfk4/Rq0bkr+fISps4KkQ?=
 =?us-ascii?Q?XrlPX5VAAfAHC0UQPnTcT05krMiXaXbFebr9Wsz3Zuc2VeB0CeSqcgABILgd?=
 =?us-ascii?Q?eU/HID9oNa6pJB+obtWjYQuJnGTcCqnprYp0d1HifXFpl+sZUrxnQJiu7AF7?=
 =?us-ascii?Q?SN5pUk7FVMBbWaEtHhhJFTTpQJ918CwGT12JLUvx9PdubFZolCxgUUB9L1dN?=
 =?us-ascii?Q?K9ByeEHjwN41pR+RTxdt0ERn3L+h28m7C6bEj9RD/3uvv34BYpG6ugtuRtDp?=
 =?us-ascii?Q?iCtYwO/bYQ4Lx+X1l4eQpeyAfG2jUCzqbBfw11ePseonZWwMD5VZdFP63yWs?=
 =?us-ascii?Q?ML//a1oL/YU+wp+KmjpFzMcMWBKI1EYHUvz7KnyR6fWMb3JRUaSAdSz6t8Sl?=
 =?us-ascii?Q?36GDzT4wFCRwos7BsAD+KcrxnPyT+OtrIekWL+EWBcb7oD6NZC7dAyvFWwKA?=
 =?us-ascii?Q?knTdDI0eDquJtpZ0pYaIqxa4Gz613bbhnrjRZSaZeMunfhj+FADV1YfEeFDF?=
 =?us-ascii?Q?OzSl2krKqbiR+JgOgAZdKP38tHJTAmT7w7PAorVjcuarWxTz8P3wfFIwV3w/?=
 =?us-ascii?Q?OKZma38JL9lfpGySID0Gj0r0KMrzENHkbaromptJzdvuQnOj5H01+A5b9cvW?=
 =?us-ascii?Q?e9zBa/g7bWelLuncvX2bsxfFfvSNLB9wz63HmnYXtS8qd7mTZdF2nSvprIl9?=
 =?us-ascii?Q?vkpmUS9R6+4eVeYIHhQt07WR5K9GzLtaOdgnALVxK3s+3u4j7CFcrTtQFtIu?=
 =?us-ascii?Q?hYfaauXD3ZIRXfqFlzY5dnuHxy22Dvun8ES8TKSDV5EBHsAiwqzWb2M1MJPA?=
 =?us-ascii?Q?YMifP7VFF+yc9J9BofKhJgbVjxunSdXPJhWfX2kz0XrZpK+BbC4TdlJh4vSE?=
 =?us-ascii?Q?bSVGvLOA35cRAOw9MRk0GHPAyle44xrzGibnnpoBQSZcNZs/sBD0IXUqromb?=
 =?us-ascii?Q?6AAL0/1KxdhWpO1e+707dLGL70ELZc9VYWdxKJWIePL5kJ98jt6h6WdemwEy?=
 =?us-ascii?Q?bdwyRGRArpbkv2t8Ejmdmqq5/QzE4JGcnQJqx/fRawFCtcaH8TU3Uykkvm5J?=
 =?us-ascii?Q?0GAfrYrgu/BWzpA8oiU7QLnDc3uqUJu0kTK9btJghqjwMAyMVoJOu+Kj/YQm?=
 =?us-ascii?Q?0DqKTCuRViWOovBv7hpFgpvYdS/n3K79f8e+XP3DbNnX0opkpukR8P5sSFtx?=
 =?us-ascii?Q?P9efPJgrnXOmV+V5cFW9mYHXRRrNtTzGpeLZDg8pWtMDjZMydGBo34xc9nOt?=
 =?us-ascii?Q?5ENTVh1+7QCSPLPNSQ1Ba1aoN84GYtP3klr1RNRgjdcq9NMVvw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(82310400017)(376005)(7416005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2024 23:04:50.4136
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b356810-416d-4b23-fac9-08dc89a1bb69
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8994

On Mon, Jun 10, 2024 at 07:01:10PM -0300, Jason Gunthorpe wrote:
> On Mon, Jun 10, 2024 at 01:01:32PM -0700, Nicolin Chen wrote:
> > On Mon, Jun 10, 2024 at 09:04:46AM -0300, Jason Gunthorpe wrote:
> > > On Fri, Jun 07, 2024 at 02:19:21PM -0700, Nicolin Chen wrote:
> > > 
> > > > > IOTLB efficiency will suffer though when splitting 1p -> 2v while
> > > > > invalidation performance will suffer when joining 2p -> 1v.
> > > > 
> > > > I think the invalidation efficiency is actually solvable. So,
> > > > basically viommu_invalidate would receive a whole batch of cmds
> > > > and dispatch them to different pSMMUs (nested_domains/devices).
> > > > We already have a vdev_id table for devices, yet we just need a
> > > > new vasid table for nested_domains. Right?
> > > 
> > > You can't know the ASID usage of the hypervisor from the VM, unless
> > > you also inspect the CD table memory in the guest. That seems like
> > > something we should try hard to avoid.
> > 
> > Actually, even now as we put a dispatcher in VMM, VMM still does
> > decode the CD table to link ASID to s1_hwpt. Otherwise, it could
> > only broadcast a TLBI cmd to all pSMMUs.
> 
> No, there should be no CD table decoding and no linking ASID to
> anything by the VMM.
> 
> The ARM architecture is clean, the ASID can remain private to the VM,
> there is no reason for the VMM to understand it.

But a guest-level TLBI command usually has only ASID available to
know which pSMMU to dispatch the command. Without an ASID lookup
table, how could VMM then dispatch a command to the corresponding
pSMMU?

> The s1_hwpt is derived only from the vSTE and nothing more. It would
> be fine for all the devices to have their own s1_hwpts with their own
> vSTE's inside it.
> 
> > > > With that being said, it would make the kernel design a bit more
> > > > complicated. And the VMM still has to separate the commands for
> > > > passthrough devices (HW iotlb) from commands for emulated devices
> > > > (emulated iotlb), unless we further split the topology at the VM
> > > > level to have a dedicated vSMMU for all passthrough devices --
> > > > then VMM could just forward its entire cmdq to the kernel without
> > > > deciphering every command (likely?).
> > > 
> > > I would not include the emulated devices in a shared SMMU.. For the
> > > same reason, we should try hard to avoid inspecting the page table
> > > memory.
> > 
> > I wouldn't like the idea of attaching emulated devices to a shared
> > vSMMU. Yet, mind elaborating why this would inspect the page table
> > memory? Or do you mean we should avoid VMM inspecting user tables?
> 
> Emulated devices can't use the HW page table walker in the SMMU since
> they won't get a clean CD linkage they can use. They have to manually
> walk the page tables and convert them into an IOAS. It is a big PITA,
> best to be avoided.

Oh..the mainline QEMU smmu code already has that:
https://github.com/qemu/qemu/blob/master/hw/arm/smmu-common.c#L522

Surely, it's a pathway that passthrough devices shouldn't run into.

Thanks
Nicolin
