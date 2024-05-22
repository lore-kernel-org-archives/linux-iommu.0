Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24A0199B0
	for <iommu@lists.linux.dev>; Wed, 22 May 2024 16:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716396393; cv=fail; b=IZutYpId5t7UYxTtUpgjpJ/vmTAN5YQHnC9Ku76Yv/CiD4m2n7jy3OAwpjmPYzSEv3NwTvGzpLU9Cj4tuXr/Bpg/PVif9Faf5ZOdBcY1tSDdzI4yqRNlFfrxi8p9uJu2fSnP+IEuJwBQkxONh5qnPfULGEqBFwuTKzu4d2AYR28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716396393; c=relaxed/simple;
	bh=x18STXpD3d29xjKD9C9lapUiG2WVNFiFxYuyPZrVeDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=suT06AGA8dLJGIWXDCXuT13n2rvEfnLc9oHd84LTX5YhEpJmfYUp+NQ1qDnuwsrVYr0hspsRI+1QeV/TztO5bX7IiC/VkL+DxNEtgdqqATxujM5357fI/IiFlZX7SmE8UvoSlOai3yJ/9LF0b14EzRIGtsf8IZFsZd2W4jEzfqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=T7MImrad; arc=fail smtp.client-ip=40.107.220.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="T7MImrad"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=URwSXMpVRG43WYYBNOBDvpVKHr2AuM0s/fBuQGis/6cYaO4CkWf05ISHX/u3lbr6Qhxo2CoYp8YtH6OJqV/NWAPCo+79TxO1G5uCz0AsibgG6AiqtWfYA+QYCo2n1RrMAyuLbwZYbPzElofS9EF4hwJEJxNHmLTOijXqo3yC4yBgSeoNG7mHB0Lo+AgmJzz5K9o6PHGsavrmqG3GYI3yMSkIDgZDwcyana/ij5I0Xp4qyLL2aQf38YEtMXs7mDLFyA/zyudVnlQMP66FOSfGrZ7KnkQe7/6v66S3TdLqRYBmOcJR1BIidl+xEYmfw4ByG0gGW6gWiHQD+Ix0azS5Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x18STXpD3d29xjKD9C9lapUiG2WVNFiFxYuyPZrVeDk=;
 b=IDyi8xDB1aNL2xHBS8oAvOFJIY0hzEOlmnHuEipP24MnocFL+GFQVcMldPNV8+nM7ifO6GBRUMn3HQNL6Vw9EZl+NGZvtYRCcws+eGjw1znl2ndoRgd6qne1CPxzezeEqqIXmw2FoBaSF9HZY3HVkEC4g5RWqOF/SfKXmduVRZoIsYjrKPz1CcCWFeVdT+CEa5wRa/fqOpoiOpcrA9sm9lO/soYJcRa302MafrhUnsDWpsW7vYXQJF4theYertxIiMfzE0AFkDnana+qQD9/+aeClqRL5NABF3o3y4u3u9alqPe002qw+aTfH1tKNNkDPZd22v3FRnuTuimLJuJklA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x18STXpD3d29xjKD9C9lapUiG2WVNFiFxYuyPZrVeDk=;
 b=T7MImradIZKWriuVhJkwRp5jUCC5SiESGdF/d75fpdkhNcBsd/A1kxE6+CszYMt32A6awhFsCk3NzIFWNnGjeat93t4f7fKVcrpXJyKPqwXcqyQLS9PArp3GlevYCbigEbYMcLBu9Ja73ztvYUwCgRk8Zg8SnyiCLklr0C1toUC7v+8UN0AshvIdR24oGm4bk+ofYMCOwE0HqmvwEB1NVuKeCk+I1Gms88yGxTSSQ1U4UjqD0yn/Nfyt0CV9e77lTIGF8xzJCSqwMO26WrW5WeMTwwGp7TYXoA9XhcGm/QJqM6lM1bF6XuTtJIYsC6zUoB0tVl8hBL7YtsRhyzqjRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by BY5PR12MB4307.namprd12.prod.outlook.com (2603:10b6:a03:20c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Wed, 22 May
 2024 16:46:26 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7587.035; Wed, 22 May 2024
 16:46:26 +0000
Date: Wed, 22 May 2024 13:46:23 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, kevin.tian@intel.com,
	suravee.suthikulpanit@amd.com, joro@8bytes.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	yi.l.liu@intel.com, eric.auger@redhat.com, vasant.hegde@amd.com,
	jon.grimm@amd.com, santosh.shukla@amd.com, Dhaval.Giani@amd.com,
	shameerali.kolothum.thodi@huawei.com
Subject: Re: [PATCH RFCv1 05/14] iommufd: Add IOMMUFD_OBJ_VIOMMU and
 IOMMUFD_CMD_VIOMMU_ALLOC
Message-ID: <20240522164623.GA20229@nvidia.com>
References: <cover.1712978212.git.nicolinc@nvidia.com>
 <3aa9bc1df6a2ee58a03c6ea6ededbc210a2d23a8.1712978212.git.nicolinc@nvidia.com>
 <ZkDR4Rp57cy9qSqP@nvidia.com>
 <ZkGYN36N7sh2vUmv@nvidia.com>
 <ZkOFkfHhG2h2fv/c@nvidia.com>
 <ZkQNxkYv23z7i6e0@nvidia.com>
 <20240521180555.GM20229@nvidia.com>
 <Zk04vnqJPKsVtrdY@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zk04vnqJPKsVtrdY@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0432.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::17) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|BY5PR12MB4307:EE_
X-MS-Office365-Filtering-Correlation-Id: 61de9dbb-a70d-4d88-9b16-08dc7a7eb86a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007|7416005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?k2TDq3Be62nqyBqEx8sBtztZX2VSA+frdbxVwUJsi3OkuAiOMmM4/fPgYkkx?=
 =?us-ascii?Q?CgIy02ZhCTIE8QGRYAzPU+MKhFJoAa5LHPlzZPCncbYmOcKr8NFx7HKEVi2L?=
 =?us-ascii?Q?xsAWlt9886vOH7EoeyLd1uN3571TNt6q02eQz5cV+hVKa99FEepfeBkuQcBb?=
 =?us-ascii?Q?Gq79rRQq37nzc8QCOp79m2R0xmbCup57/i1MN5F/bcc/9NNGzbJmbX0AnkJ+?=
 =?us-ascii?Q?dDF9DaR+O8vQ0STDJVaI8zWzvJOwwUXW2001/aXIZVWk9OJvMr435OE1H5tB?=
 =?us-ascii?Q?6l8tWPBdarKKfug4+cfP+JCh1zzUzzVZpzjzPFq5t+/uJIzAIGN+Gdy7eol6?=
 =?us-ascii?Q?2MIJSj+bidla3+hv5bbliNPX9gYfRThwC/a2iaXRC2Wy6s93VJ53J89WQKd+?=
 =?us-ascii?Q?hivc9/9RIEY0mEXpLsCMRkplb/1LXDAy703+idWYT3PcIhsc7+rNQHyHbY4G?=
 =?us-ascii?Q?cfMeZl8ZjXd/uaWoRQYKVAgxqGr8TQ6WB1ZsLBhURFF/cncjUEmnL+UBa8nQ?=
 =?us-ascii?Q?z2erf18f7QoPCiNeqlepNWl9OzOsWBB4cO1AF2A5fsIU6bjjJ7IMAVBg1OZb?=
 =?us-ascii?Q?BS/b3HUtDCrayquWTYPgI5RxpJpsk1RArFAYue124FM4599ymllX6txjXB1S?=
 =?us-ascii?Q?GcJEZnjq5zKXmkzKt/NnB4cFadSX6co+bIQhejsVuZa3ZUCKv1G1AjWK29zI?=
 =?us-ascii?Q?R2G6gjdYbXkvk5/aAjOVoC/0233Hl3fUVMfzBrJlGbJB5OI91czTZdJuxXqb?=
 =?us-ascii?Q?SvuLhqM5ol1nLDYkXU8y/1WmwdFOpYGAQ+xvu5uY60Nt8SkTbTB9ruE5/mn9?=
 =?us-ascii?Q?RUfGak0mVC0PGBFCb+tPg988LlnbGXcvnsny60Sl0RpcZj0jMRq6/gy4UxLD?=
 =?us-ascii?Q?Oc5JMWfY1TnUf1UOjGtVRh3HQ3pQfltZVgKxDJnLLKhm1koc5sIA57oHLueG?=
 =?us-ascii?Q?oPDJ9jBOR4c0ueLeRDYPjIt0bFyqIqd/mZhvvgCV/gxeVWI4/BNVLOpL1YN8?=
 =?us-ascii?Q?LG4maYfqshHuaaGnlZBPxPPuWoMTpNCHn/lc9h5RHJH8ETPqp2iX4Kiw1Osj?=
 =?us-ascii?Q?fLWRF4hFUQtp0Pci8pW3h5HCRK+Ff2uXmcAqt+ILhZKZjmcFSQwQjvjiHQ1M?=
 =?us-ascii?Q?SwjchtLXN1Mdszy7Pda+lfedTiVq2Mi0AWuNKFzzrvEtd+/qKM6jgTutZfHl?=
 =?us-ascii?Q?IPMd6zq1rV5xoU5VbcLeShnYoORbbHNgN3YJn7j2jK+NyyMikH1dmHN8Ksqf?=
 =?us-ascii?Q?ibbT3V53L420K0kNPutZYoUpFmvDRQ7C8SxlZVcmnQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AQSZ44eadGE5q86pizPfpkKwY+XKTW4O74sGoanV9EbYoLTXfZnZDIMteAAD?=
 =?us-ascii?Q?jWQiVFLw967ggECFq7lxFxL6p2Yfn+zFBZtjde2w8BDcLI/ZX9IqRTf8UCIQ?=
 =?us-ascii?Q?zmIFjdO8/+ixq26qH3A0i53+8pBVtzejPZUoDy4lC7G72/Bf5bjXwD8VVxJh?=
 =?us-ascii?Q?DiXx/Am30UrYBfvsOYAiwxvkU5mC8C37qYToAj7U+MQXOrbEjkayMzBYOU0t?=
 =?us-ascii?Q?/+Wmw5/lSHXLCBy3hPGuleI0SeZyi7n5kBJrck78reoA5OtKWndikSEKjMvY?=
 =?us-ascii?Q?47eBukbLsAmT9rjese6QUrSiMW8Qe7tdj9ATFsQdBfKnejFAZOgxOZcybsBy?=
 =?us-ascii?Q?O9NuIOVjdAePMOKHKPlgAFV+BuJVvyaLhN7yhdoBKJbe01kOdpAuK0z5rQpW?=
 =?us-ascii?Q?iCwXH/E5N4lolYB4sacrYgoRAFh0zAOWLKMzVxutgoPjKtt0IxdT9Lvn0kxx?=
 =?us-ascii?Q?QH4K9/85tTM6rnMZv+eqdoZKkEWQBZG4Iqp+CbRkDAKynncyIETh6GfeXCRh?=
 =?us-ascii?Q?TxZUMvlYp39ZMqutBr8OmdeF8UMqEkgiihq/8jUKMNF30e0iuHZeZUCFWOFk?=
 =?us-ascii?Q?QmLPsfWAPrdnI3tWX2HCl6mSvNnDbtP7N4MFhgK4RMoxSqQbl0fxMsPoVlg0?=
 =?us-ascii?Q?VzhToXYN+U1QW1vHM6r5GpS2FQaXpDcukTN2QhXieqKHOR2KJ4EMJgvgVJy0?=
 =?us-ascii?Q?hQ/5gaok2jxgnfx/Xt/Oo0MsSHIRQ7mIeCbM/IMjRakJ/wjDWc5Hfzf+mlKy?=
 =?us-ascii?Q?14aDmb9RRoZf4HoRFp/AMfeDjXaEW2JeyxE7EKx7I9sR/HD8phNioqZv0pkS?=
 =?us-ascii?Q?S1githuE+1/QOP4VvpETiUW1Q68l6ku9XU4evE7xMj50XnY1PayIYyTeftIm?=
 =?us-ascii?Q?68bsPwMMPPt3OkvnH5Qb1x27mHrTA8+KV2BUyyW4djUJpcQbNwcr3oh85NgQ?=
 =?us-ascii?Q?CTONJuPai+wzELk8zKB9sVRFU27Kqe2eR5AfqAqU7UxzxjIJQW2ztcj1VZI/?=
 =?us-ascii?Q?E5UtAGU7nyjDwuAvs1s00Ja0xY+B6z4K1VwqhL2SwtkcJ0sBskBDmrWAJfCn?=
 =?us-ascii?Q?PFuuhgbNFxTUBcQtDMDuti5M+mTnMuPpFrUUND9T5yl2F7pzidaM/y6zK9Va?=
 =?us-ascii?Q?iIa3MC1jJ2DKUq+sPCFFOYsX8JXOrCsBreAX0FJOoD5AzbB3Gxjs5xkurLM8?=
 =?us-ascii?Q?3BSJZ3UW8xbXFuc822CVNoZ+oqh9/5PjH4EbPBGiTteBMeqUhrBHUeC92UK7?=
 =?us-ascii?Q?sEmTYq92Pk7zxdlL85bNDtaM9jDVCvdYoUQ2RJtJxy9lopWSWnC6L9ysdwt4?=
 =?us-ascii?Q?5glAYQairkIYRWqK0/9h3moWmXsEm5We3u1cTwOrFOZs3sWqJVbnBFOP09O1?=
 =?us-ascii?Q?RSpU3GNijYa4WiIKRY7KWOKtEzoXIygf101tYxtQYUlg3dc4Kp0C87G/dH9k?=
 =?us-ascii?Q?2Jqk3J6vyTsjN9nuvcO+C4sL01EGqwYmOohuXfHVQ0r1zGqem7U+1Hn6i28i?=
 =?us-ascii?Q?L/2/6NbdxpG/z+EoXsT4fuEc2qQUYf87rfN4othsP92Kyatj9SIz0ifngvyT?=
 =?us-ascii?Q?2UDjE5ppwAqYT9cRtmA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61de9dbb-a70d-4d88-9b16-08dc7a7eb86a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 16:46:25.9612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6uIjB6y3quVyMkyaKt+sldsND8fYcpEx3UJSa8pbfyjDJcCjv3qIX+Nv6ikwfCiH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4307

On Tue, May 21, 2024 at 05:13:50PM -0700, Nicolin Chen wrote:
> Yea. VMM is always allowed to create a viommu to wrap an S2
> HWPT. Then, I assume iommufd in this case should allocate a
> viommu object if !domain_ops->viommu_alloc.

Yeah

> On one side, it may not be straightforward for a qemu viommu
> driver to hold a shared S2 hwpt, as the driver is typically
> per instance, though I think it can keep viommu to its own.
> So passing the S2 hwpt back to qemu core and tie to iommufd
> handler (ictx) makes sense.

Yes, qemu will need some per-driver-type but not per-instance storage
to make this work. Ie the ARM per-driver-type shared storage would
hold the ARM specific list of S2 hwpts.

> On the other side, there can be some future HW potentially
> supporting two+ kinds of IO page tables so a VM may have two+
> S2 hwpts? Then the core would hold a list of S2 hwpts and the
> viommu driver would need to try-n-allocate viommu against the
> list..

Yes, it is supported in the API. Userspace should try to create
viommus with all the S2 hwpts available and build a new one if it
can't, just like hwpt attachment to a device.

Jason
