Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2059.outbound.protection.outlook.com [40.107.95.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5681F171
	for <iommu@lists.linux.dev>; Mon, 10 Jun 2024 12:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718021093; cv=fail; b=hM2sPaU95/yZiLlWfdh+c5SF4LANLUFuh6GRA5bNo2JDcQHnVZryG0giMvV2SVfv2iytBaantaO3rmbi7b06GhgFWJLvGEkPTvPemuTvfry1jfsFEEclOkZiyBaMp/2SHOl9DZdonvOmj5g/Ueh+eW80cyCIXF3HGwxgkgF/nMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718021093; c=relaxed/simple;
	bh=eSfh/IaALT210cmEFH7QmtHYOnVrtjS6m1zm/MjXDDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lUTWm4MbSRE4GkxpXOzY/Zy2fc0uXQJlwiazgUGK8c7TOJHH7MZC4GFVdCib53FiZ4icBAeThxvpTwgrp80KUqXX7nScGHtiqWrvQAN9qdce9SRbQTWdcGne8eF8iCH2LFBDZZcYOf4/CDUt+gCPqxs4M0a9D1Y6blqXb9m3Y7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sww0ylM9; arc=fail smtp.client-ip=40.107.95.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sww0ylM9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CTCh1Ximc/ZUNZkdWMCiRJ1vmJOCzkN9juFMAwQTdU5poOoeYkFvFRsg28AZ9dKtExtTKr/DA21tpj3nJqZEGmGE31V8wWPcJDhXX6MHIBnQH0iNUmM6VhrtsU4aO3WxNqYr2YOVOnxr0tzO3IBJtfGvEf64ePZMaE/X/cYVbekw4pCRGjXhs7xdK0xWCnziVoitgsOS83eGnt8jI88Lsvfg00zwSJXWXRZeTSTUUG7DX4GuNdScph348D0rX/XsfrMdIkgoWGs1AMYMwQdKV10J4DlF64bIBdrjiHpQYbHVxWvu1XocW4IN7W4ALHvcYFg+F0RMWF8bZUznnQGV/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wA8jYMkFCrehX9YcdRhjxfrLUSU6kgJvqM5ZgAOSZCY=;
 b=LLHSe3olYyB9O+eeGVtM0pOTZCuNGybcf5QSkDWKq1EeuAwhH8Bwy+AXAE4Tz5XgAoY+dG6GLigEpAs1NKwRroY4QppdRBaUHz7WZuOcaXT44w87jtHIaAJn+9HHOlHXUTpDnJGKa2BpSe1AbrEKbsUWVuMarT3zSa9MjFEdJ/fYBoI7a3k1C2EAdrSme3ZAXiOUnTfyGeIM9WVixMQPxepoJt8UqTKoWP2J6GXeTN/9fx3pcYNN1lRpyxAmXaUcoJ+gOegTjZM3lO33GbEV5rZP6k9VM2xcWeHkbaRUgDpWXHcz47/i3EIKU0uey4/u0oWCTWSl9BnAN4ybFYGBpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wA8jYMkFCrehX9YcdRhjxfrLUSU6kgJvqM5ZgAOSZCY=;
 b=sww0ylM9oAB/J5eGKhi1ApEEKcSvr4OB+G+LfQBuH7xW1y0cAqAjLbGgp/M650FBEoE5z7w010/WvibIe0zE1cVP3f9PXyCfXDdam6PLybxMw2z7bN98+GWGVtKo4ccFA/h5YA2v2S5TNqhb7Xu5Koq8iRPmUUc7/+TwOzvcCXSUF5EfI00Szvwx50t2NHNNR0JPEYxqHfamAuR0vNjKHUOLiK+b1x4/E45H1rw3JE20qWTCh5kGkUwojfuyppkiZ1n7zliLZouy1hQCwcrVFgjrywpOMwFq8+chSFzFuPF4iJef9iWS8XazJ5dJze7GGY7bR56JO6v+IB4Uv79rUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by SA3PR12MB7922.namprd12.prod.outlook.com (2603:10b6:806:314::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 10 Jun
 2024 12:04:48 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7633.036; Mon, 10 Jun 2024
 12:04:47 +0000
Date: Mon, 10 Jun 2024 09:04:46 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
	"will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>,
	"vasant.hegde@amd.com" <vasant.hegde@amd.com>,
	"jon.grimm@amd.com" <jon.grimm@amd.com>,
	"santosh.shukla@amd.com" <santosh.shukla@amd.com>,
	"Dhaval.Giani@amd.com" <Dhaval.Giani@amd.com>,
	"shameerali.kolothum.thodi@huawei.com" <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH RFCv1 08/14] iommufd: Add IOMMU_VIOMMU_SET_DEV_ID ioctl
Message-ID: <20240610120446.GP19897@nvidia.com>
References: <BN9PR11MB5276AC43120376A2502D3D148CF32@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZlfPPwsnY6P4SoGF@Asurada-Nvidia>
 <ZluWXYQjroz0fqqn@nvidia.com>
 <Zl03rsgZl/msa3I+@nvidia.com>
 <20240606182423.GF19897@nvidia.com>
 <ZmIDqgfINXfB0i3L@Asurada-Nvidia>
 <20240607002707.GJ19897@nvidia.com>
 <BN9PR11MB527604637EC37B3B03FBBE468CFB2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240607144917.GK19897@nvidia.com>
 <ZmN5WZkvDeIS7RRH@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmN5WZkvDeIS7RRH@Asurada-Nvidia>
X-ClientProxiedBy: BL1PR13CA0412.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::27) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|SA3PR12MB7922:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bd5fff5-9764-482a-844c-08dc89458636
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?G1a4cfYV53N3vvkL1tZJ9BHNGhB3ZH9ZO7hyeoZYjQyJQC6bs5BGS0FCB2c8?=
 =?us-ascii?Q?1CJOGyFo8a3vOPzFZJt0lpAOLoYWICCa2pVX4VPP0IpCDbHR0WMUSeUE8scA?=
 =?us-ascii?Q?YxF8F7BxCCuFEAqgQsCy+pqrMXXhebbRiKMXNulb0gAPato2azELUXGVRBo8?=
 =?us-ascii?Q?Flx59UFEc+lpf+F4/D3B3d4KXeSBj2wzfzqE8WciBIh8qfJAmbGxN+mzrdsy?=
 =?us-ascii?Q?6ou7tluY9YWfip8jSrB1lkcjGGwekERVwHOc/ug/XbmlRkYyxnVktWv7QcUd?=
 =?us-ascii?Q?ci8F/LOKhK+XQw2iK8Q5f5a+BzK0H4fXy2udKHjX1uE7uwf+85eL6QXIp5DB?=
 =?us-ascii?Q?vOPGF+OrtPcHuo6ZjDsZcrmyJItJE4Fe1YMAEzu5Giv6pQcZLXK/XdKSYs0c?=
 =?us-ascii?Q?V/tkTDqGsS2tF/QAZk+hcDVUFMDygG6AjT9Ieo48VIpcqRWwzS+AnVjdAZYv?=
 =?us-ascii?Q?GA/HX8h7AwxBQlGFleO7M30zY2kIrU4qLnPeMIN1Pz6RhSNeBkGMi+5k4a2u?=
 =?us-ascii?Q?3s1y99BhP6/2FefwcAdRoOjLCUcvndXfQw9GnRjBmaU3gkBq5EYVywU/Lqh7?=
 =?us-ascii?Q?2oP53h3TRhEPPfDfMl/Tl2Rs9hxDxcRANnsw/hwL07ICvVHTRxa2yj/s8fDa?=
 =?us-ascii?Q?k3f33BlBTZpRnGc9559N8bx0XBy0y12yv0+OwhbO4NN4/kwozThFKyfT2puF?=
 =?us-ascii?Q?FlkvTpxxBT9a/C64szPAfX7MYMgSQj+wirZs4e9+A+mSoyKTbhWMeuGC1T0H?=
 =?us-ascii?Q?/RZt+VXXIjNUgLOLE4C5vVkf/LTpwlviOO/D/Dq1dBE4wlTijbj+QUrb0Z8v?=
 =?us-ascii?Q?4jIpdcoMBOpYcpiqqNchBLfVUQZbunGFj1x0HK0PAxn9uVdA96dMyy7f8VMr?=
 =?us-ascii?Q?rbL/M/cl1N2q1X5OphQJUfP6NQdAqYpE1ivdzuhidKu37DfT/z6LkiQIs6p4?=
 =?us-ascii?Q?Q9wEJ1SRndvkYxUq8/bIMeO66puirDuzUYqY9TQBFYe1cOfFVj+1kNJkfODm?=
 =?us-ascii?Q?1LcF28GsUhxD/R5M4UCYPP1WXg3SIMqKsMC5+/1sfpPea8neTsOL91OIGnYC?=
 =?us-ascii?Q?Mi0XQrnUFu7plLPW8sHMXV3QH+NGGMQDK7TRI3S5Dsu1CiR7Rn0E1xW6STti?=
 =?us-ascii?Q?Ane2VCi7qCPx+uXcG1KWVuSqpX3U4bK4LNsLv6NJsGbQOzQU0f9b/4ae3XiB?=
 =?us-ascii?Q?mZpR94+zqWpLsSiABw0Wa13nNSkA7m4cgGUEaVVONQIC/njXMh2HpnA06YWV?=
 =?us-ascii?Q?mmg2IQCZiqijn/9SaJAACU3kq5zidqVY6jkZh8pq6wlIplL2y7Lk5qrE+BwN?=
 =?us-ascii?Q?cAtrf2jcMFaw322vU+eVKmq5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?875xRoxFDky81HnxUPlbLvNDdqq7geWFoT616I26fOg6xjbkFSr8Rc1mzmIL?=
 =?us-ascii?Q?aPJ1fKFBEKXdm8iUNCfqSHNZKnlfog8dJqyYzr4ZfoGU6h3aEJiof4QMtYma?=
 =?us-ascii?Q?ZxPmFzfgItJZLSbjOkZu5vbUr/2qvnBb/PSxMoLZUKeM3v2B2Wr9das4He0h?=
 =?us-ascii?Q?omInQWVBYgalhHKnQq2LblNcNTb/W7t0020i0vCbt8SD0j1nt7ij3ipdbCi5?=
 =?us-ascii?Q?11YZ4Yn4NWC3r6ExS35E0B7u9n1nEtRbi1vFNotB/0DK6SQT1Lhl3svkEoWY?=
 =?us-ascii?Q?86TyaN+uASOHG3IVsOb5TQZ+XnGfBoongRPpR+K6ANN+tKU0vjP0XabRDB6k?=
 =?us-ascii?Q?2/YPe8WD00fAljYZkGEqtBh5Q3uqrsVWKHIwroSCU/ck3ULgu8sHuUoTLPqy?=
 =?us-ascii?Q?0+5eIEQukU1aKeGvp7hFA486i0owK+Q1bfsT+IUnuBqMieCzVOEDHCbhu4LA?=
 =?us-ascii?Q?/uk4WTSCjhHCtPSePibKVIHJaU9VUqKtDmCmWGCpE27c/reh9ZEceVFrndjR?=
 =?us-ascii?Q?x3yuB4vDRi5tAJJPTzPJJLoavYgxUmFZJkLkJ78jrCOJCzS8oZ+6XcvkZ1K0?=
 =?us-ascii?Q?hSVtIISKFDtTFbutKQcM7w91mlaBCpJN7FK+jo+/jexwQlFRTV5PaY2BmN3h?=
 =?us-ascii?Q?LoE2QfATx5ivu4FvG2Fv1Gw9zckv16/O21YVibtkHWS4kBKlKF9+KPegJrBp?=
 =?us-ascii?Q?DWKuvTssYZpWesTPCaQwaqhSi8B/LKEwE1uP3mgGM1zLb7jSnAfBISdtvrbv?=
 =?us-ascii?Q?KCJwZh6Nq/shmvlk/G+q7cVMFpvuGJcV3TgRgoe3C3YN/b0sTI0cxD1pOOMv?=
 =?us-ascii?Q?Woo7yRo13rlL4RiP716Hc9ZdmNzO0CVLVH6XqFcRSjs2e03ysOSXg4IYKu1w?=
 =?us-ascii?Q?cEIsigPAbl71DY0b/u/0fysk9+avBMvgdvlqNyiL2k04oy/AybOFMOJNmaq1?=
 =?us-ascii?Q?0QjOPbCh/AG4CHXDKrffMLS732rvG1Mt5q5m9FvZ80MmSsZy0EntDwOgFlpb?=
 =?us-ascii?Q?1rWgJv8BecvzUr/5+MFDnzaXP+ODJ97dmqNHJKWDF+mUjZkRrkf573jgEnSP?=
 =?us-ascii?Q?ECRWnt8YBTZNADpzyxhPE8Wlx5uvVdBrXXHWgwKEWfeyc9ZSdYLGfvk+RnaH?=
 =?us-ascii?Q?1SpxsX0ol4e+eGjs67rjMLiJvpB8+fLW4Yt+8lTuL+irufYu+gMWrcLXDqQZ?=
 =?us-ascii?Q?dc34odiWQfP9VZWd6GejmXHFWee07QS7/lIGZDReZTBLlGMzIecyELTHPxVW?=
 =?us-ascii?Q?qn8vPmuRChTcDk/vSdma8ZSqCaidt/sHno8wu5/PSOBoJ1bvRoC5CRWqfYTW?=
 =?us-ascii?Q?6VY7+DZYJysPdZK6/puIPlukXzAiwSPUywhn8lSDLQtruBDLgED+NAqKTbMl?=
 =?us-ascii?Q?T4sG0TFGJjLAqjA3WoEUp/iT23HSk5XZYexstdsOi9lkwCBpE697UyZBV4LL?=
 =?us-ascii?Q?ruO4yHKjzAWaWCNwfCkzBvbkbRhAzeq1xrH7UG2YbvYvOnEfjQM0s4Dvkszo?=
 =?us-ascii?Q?zbCPSyOSUOcmgxTtYsBQimeeJjmtpV/gV0nQn+1dEgo/wmHn/GL24nKmX9rn?=
 =?us-ascii?Q?OpspAB5nENSleoI3dHOiEY2GRvyrvy1BbKJx7qO4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bd5fff5-9764-482a-844c-08dc89458636
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2024 12:04:47.8942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IkRx5QB9xRR8HDPHeaUTIiO1fwDCOVx7WEWNqtfOP5nwKKZ/YdvTHSaf7YDwn2ap
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7922

On Fri, Jun 07, 2024 at 02:19:21PM -0700, Nicolin Chen wrote:

> > IOTLB efficiency will suffer though when splitting 1p -> 2v while
> > invalidation performance will suffer when joining 2p -> 1v.
> 
> I think the invalidation efficiency is actually solvable. So,
> basically viommu_invalidate would receive a whole batch of cmds
> and dispatch them to different pSMMUs (nested_domains/devices).
> We already have a vdev_id table for devices, yet we just need a
> new vasid table for nested_domains. Right?

You can't know the ASID usage of the hypervisor from the VM, unless
you also inspect the CD table memory in the guest. That seems like
something we should try hard to avoid.

> With that being said, it would make the kernel design a bit more
> complicated. And the VMM still has to separate the commands for
> passthrough devices (HW iotlb) from commands for emulated devices
> (emulated iotlb), unless we further split the topology at the VM
> level to have a dedicated vSMMU for all passthrough devices --
> then VMM could just forward its entire cmdq to the kernel without
> deciphering every command (likely?).

I would not include the emulated devices in a shared SMMU.. For the
same reason, we should try hard to avoid inspecting the page table
memory.

If a viommu is needed for emulated then virtio-iommu may be more
appropriate..

That said I'm sure someone will want to do this, so as long as it is
possible in the VMM, as slow as it may be, then it is fine.

Jason
