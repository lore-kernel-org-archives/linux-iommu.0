Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2065.outbound.protection.outlook.com [40.107.236.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E624915B0E3
	for <iommu@lists.linux.dev>; Fri, 28 Jun 2024 16:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719591399; cv=fail; b=SlXs5bR7KoXgR50IxGiIgePNHVYt/iyX7tXtq/+nSdqaHMd/ZX6WDca3YXYbSeoTxMJjZzSwO2SodLqlL1scyNHfJNpL+kMdC5xm7nHHnsJmvR3NOsGm9hWIrWCTSu9yZp9X/jRMNrXlM3kmII79VHwNcp8woI/gEEtYg/MsOq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719591399; c=relaxed/simple;
	bh=1GSK6OinQyZJDVY0b0wctaJKb3YK3YRyBXtqln3WmP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JOrfcbJHXmqO5gQcCVXjR3VjdjqNZWTi0cxdlY5j2AOsVMP8YZ6LSMgowmW8Wcq21cBTh+GEhcjMXnulqK9jfFNh3EKunm8/D4a/QRW/PhcJ8Hwg2Ih3eBguMnvbL86rd6Vkjx8dXFfyk702dB2M2uvQeLEGMjGFmmGYhXbWsbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MgkUy3aG; arc=fail smtp.client-ip=40.107.236.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MgkUy3aG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GDoKNFB5uTmIV6if/V5th4yMokdOG4ke+Dr7I/amFxHFwtan7u6YJcfwOg6sNMPh95ASt66qY/vYNY6UlcLYsOIvM1jrsm/vPotKLVvvCwd0Lp4no2+9o9erxrTBZvJiorH9GKhG+T2JtrQFykPczOcaOgBNS1+PBE3q/iMDL0Pa1JJZHbH5JHflHgRvJRvLvy0WCQo/m+7k1PziVWlFOSPY85cv5x6aZe+EENOcuEKVVcY9ultbpP3nBDIILWn4pkVksHZouP3t5gXCKdnKhWyJiAGP291zm3fVVLFCAVDYOJm/VB6J9RsS3q7u8HO8dFYp4AjyA/PiCUv3jeqJQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P2ZcUxNrg6UTcN7FFakGntyFrixd3vXbFRsbBb4hv3A=;
 b=HWTkb8ZUlFD/BxcLfB5MdNpvAZmlt+S4EkCu1meaEPXX2P6KYT+UNGmybCKwpX9qDOT9FSGzBUP03PeqeGrIdj51tyGiLHpIC57W/dzcOhuCeJxLu/cUiCKbpgcra3Iy79PBXxPqTC2UMQp/t+VYXGLJLS4goT/L41MvFtVByET3UmXvsGfhJ1/eILS+BurTD3U9C558JM4WmmLDGojXircsxwbaCMjq579pCBeCT2NtDXScWpfmCillHIU91/N93UuP6M7DYx+3GFG6DD9jdIXO6CD7es7Fr2UPKTKz/4UAuUjPIIhFeCDTDnIoOs4v0ZGDkkBzcpBLan9+PRYiDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P2ZcUxNrg6UTcN7FFakGntyFrixd3vXbFRsbBb4hv3A=;
 b=MgkUy3aGb33uUWkIgoF0Dg+Im4TJqjlCsogMGMqND5VawJryJgH1ZRUBMMW7EjoAqyQB+3fVrgxR0lWimL8Stkjj4YYHtGtXJG76vhTopcuAK+kJAA6YMVuAy82cysXM4REd6YJBJD5JID/DmzXsZdxgOo9bnsJQyvWJ7yjd7LnfCTY5LL2ZVstjFpXqYzI7oxgw+RYm51zg9AqjW+32UCfolfTk/z02IQbaEiTfYXRIx4LcuTTW97P+Vuq8oJzI+g0KVsYV1nyhhex7IeD6mzqMddFIEp/kN/uclr9V/Y7B/iuPlNnZ0Loq1MFP7EIHK1SBrZuaQRL1HqdnDvkPhg==
Received: from CYXPR12MB9280.namprd12.prod.outlook.com (2603:10b6:930:e4::5)
 by LV2PR12MB5966.namprd12.prod.outlook.com (2603:10b6:408:171::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Fri, 28 Jun
 2024 16:16:33 +0000
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by CYXPR12MB9280.namprd12.prod.outlook.com (2603:10b6:930:e4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.37; Fri, 28 Jun
 2024 16:16:32 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%6]) with mapi id 15.20.7719.022; Fri, 28 Jun 2024
 16:16:32 +0000
Date: Fri, 28 Jun 2024 13:16:30 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Joao Martins <joao.m.martins@oracle.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Avihai Horon <avihaih@nvidia.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
	Matt Ochs <mochs@nvidia.com>
Subject: Re: [PATCH v2 00/11] iommufd/{iova_bitmap,selftest}: Fix dirty
 hugepages tracking and selftests
Message-ID: <20240628161630.GU2494510@nvidia.com>
References: <20240627110105.62325-1-joao.m.martins@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627110105.62325-1-joao.m.martins@oracle.com>
X-ClientProxiedBy: BL1PR13CA0173.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::28) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic:
	DM6PR12MB3849:EE_|CYXPR12MB9280:EE_|LV2PR12MB5966:EE_
X-MS-Office365-Filtering-Correlation-Id: e5dfc096-e8cb-4f31-c9b0-08dc978dac75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7BmeofeI0yMh1d7dZ1IQ9bldn7DkdmTG2M4V/m6BrqbRK0bXegVqEW4pHnvO?=
 =?us-ascii?Q?68C2nHBwlzXz1uzFSmgPLCymKg77zSzOKVwPhZcgvn3aXn7HbpU9S4Xi1aWl?=
 =?us-ascii?Q?kAp4otvGc+ubdqM45Ow996/cv6qC82fXH9lE+xJ+ezOQKGhuNUyE9LVUEbu4?=
 =?us-ascii?Q?ztcpBlF6IvFRUzVdWkwZduhf++//OrX09/v+OMK8rJytxdqpNTA9eoy0TevO?=
 =?us-ascii?Q?hk0drG26Yg3tRqTGOPL/IcxFxmZgw7cnnmT2WyPWfDgBDXkaTp8UO4dkFcV4?=
 =?us-ascii?Q?lpjfVYHLBXwPTrgnDqAtTDgU3+ZUT+fpWgpLsvC72re5ucGuSG+0Ugr78GBW?=
 =?us-ascii?Q?orUiSvFKi132PN5G78M6vjIpROhQCV7QCOF+WtpMCh7iJ2ZOvnmqhZTPtsaL?=
 =?us-ascii?Q?lp2Kfdi1PGu9JuifERRUP0b3Eoqdz2rFeV2vezXg0hJ/pxKBwWghUsRt70+J?=
 =?us-ascii?Q?qYlx7y75rmAve9DWWlCtFkBXnxpnsIzXGYMM2GsAus5lnMfH74ht3kGCBmA7?=
 =?us-ascii?Q?ZQGkuKzU8q8aekCX7X+/zKXdrJKCxImOe/TGjw9Yt3fH92wlly7yxHX1Pwez?=
 =?us-ascii?Q?P7znMtNL8H/Qncg3aLk3qJ3L1QNBj1h02qR2pMbX6s5bJ3kHAsmk4cgVV8/O?=
 =?us-ascii?Q?uHrtT4erCIe9eh3XZ10YwjrWbpf4S2cwmEfCQD4styF41QcUchBuM97NfxC1?=
 =?us-ascii?Q?KI1SBIXlcgB//lopb1Xd44TWWK5xc0p5e5+APzBzh7puDYytTUSiirLuemHN?=
 =?us-ascii?Q?P0xiz9V3NKubqqi5WV7VSWDPI4ivEeCQEmO44mQmyJTqoUX4xqpd6e5QUhak?=
 =?us-ascii?Q?7lqP/PaZ/swbK7R1uhEnww2SYo2Cx1lP99CpdWIuQeX5M7RgegEpDvpRQRW9?=
 =?us-ascii?Q?okQU4cquTrhpEaOy8IXn/K9inKhYVZUvMgmsA+3fk1MQxZtZvrzO3j87nA+y?=
 =?us-ascii?Q?lVt21AXeZOqHyBQ0sPYKiRYHuy4IhmRmU9HHufY3BIwRSJBb7IF9tZPEpV5q?=
 =?us-ascii?Q?2vbCuAoVh7wOYHMGz69NYc3vBGWqoIwc6QVGzcWwCuS6+I7CBVOaaT2G6Itf?=
 =?us-ascii?Q?0Ki51x4ousKhsVWSxrIpNjVPTkmHJnSrDBdC0+Uyuvl015sPOv4WnjznaFAD?=
 =?us-ascii?Q?Tc/zjlGfGJ8SBqDNam0eu6O16IojUebbYxghhu+BQBDYZdptmxH/iHopeTA6?=
 =?us-ascii?Q?G/7cALTyGC2uMFSl5VU7V9GWTZZxH0V5yPuAee8lFoPya9PPR5gv6WJII2cx?=
 =?us-ascii?Q?qX1mhSDorGHTv1lYD4VyprsJmcmqz/B/cN68/eFfIRKWzbTl8jwg3peR+9Y8?=
 =?us-ascii?Q?P/qPGvt53SjNzCuPGAAyas/f4KGtFV56hTKIQQH8SnREYw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9280.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1kp8cF5iPT//GAIKMGWPkZSnsZQALREpiw/DEwzuGD29gGQFJF5G0pSm5VfK?=
 =?us-ascii?Q?n69AeMhAFaM19r1kG9qqQ9K4mi6b/2+5YYFkswxJiovYey1Efq8PiG6NLflv?=
 =?us-ascii?Q?p9lFXld9lkfsop9ZtJGoU1+30qVBRN/OycJbLZwZdkuBTPcm8wNFOXMnepXt?=
 =?us-ascii?Q?G+5c+jRc9p8z0V/2P5ejx7vWNtH9jzZox3hOY2fi+BcVseCkRAHyNrJmu+Si?=
 =?us-ascii?Q?Bb9Fmvh8hvDhDBWTKv2wizMTWWCpy4nYt39WSBAs7jtq/IWi8Tbxg1vUpZTV?=
 =?us-ascii?Q?5GM9Z75Feku2WaiDSyL/cDJ7oZftnRa2jr7vVc2NetzOO6lX40Jiv+wYJTZg?=
 =?us-ascii?Q?16yXPRyyrFPyBOYJWXzvnh2qk9+8ARA6aziQua6Q4D/gQlQfUzdxZbsSqUW2?=
 =?us-ascii?Q?wZUtkDQs94V6INXvO1UtQxCAtYas/dLCbwiay2Kg/Us1rGcHvqgRmjwZnQ3P?=
 =?us-ascii?Q?hyFcyUL3JVWCiYMlAD4rK9IliOixM/8IsmbtuCou8Mv4VL7bU1Edif5hGPPD?=
 =?us-ascii?Q?UGYh7i2Ge5ato6mo4SvAF2UQh77uTdxz3E8bibV4jKj0LZmNoNkfaGB0mIS6?=
 =?us-ascii?Q?6IwoWP1BEji+MbQF2KGjU6MvKabt1phhE6C8qHz20noi+1f6p7PaArK8skPE?=
 =?us-ascii?Q?vT9IbsyUuCBMqN76rjucCMkvOsArabuVT75FJqwgDTFXp1DiGYh4eed92G1K?=
 =?us-ascii?Q?sQGHFZCHwQgLs0mAxy9k0F/5wwEhkhzPxC7U0TDANd0JONx5+IZ6/n/kdMa3?=
 =?us-ascii?Q?l7+Zhs+G9DRfzPYjm47LiTv90K2iCA+4iG84095HNfuj0DhDJ5fP4vobpgm4?=
 =?us-ascii?Q?B7W8SCFnT/Ikv5XIRzTsT0EC+CnXm9AKkKrguaGkoNGrMu/Y7XDnsE1XEShx?=
 =?us-ascii?Q?bgvaQ8J9FSjZLuzbax/FGWs5WSP9CvxRd9GBGWlAn884x4wT+aiS7uiSFion?=
 =?us-ascii?Q?Hv7l2/mpiK7/V1rPti0oATeNrjf+/Z0VK8F2fY16mf8zVkyw4Qn93imfY0zk?=
 =?us-ascii?Q?Syrsm3UsmcReSwasjBdIZ0Fp8Z2ISXtfrxisBcSsu5nXtbtc9oC/YwMHMmmC?=
 =?us-ascii?Q?T9wvMLk+Hq4TpS3iiQ2AnaDmBiUK0Mvoj6nMi624KJgZwovyaPiYqmHI7XiA?=
 =?us-ascii?Q?qQ+3dGkvpkIxj4BNezDBGEB0liHco2vMpCE/mfFumdt3eumdCecqvpV+pJzW?=
 =?us-ascii?Q?h2S90KIIqn8V4xVlU2vNLrBcP/3N2NRfA+K/nvOopcqwToIU3vhKlNjEpzX3?=
 =?us-ascii?Q?6bGy+lGw8biWQzibresCgwzo2R8Ht6u1Y8CrU0Ka2yATpD1TXu86zxI2xXfh?=
 =?us-ascii?Q?AX+cjv59T1TTyAjgXjJEPpIjYuFBjb024CjrHL/rZplHWW6nQpvoBzRtg4XJ?=
 =?us-ascii?Q?4ACs13D5Wh4aZx56YVbyVH89RFFdU5OOVuGRFuokBpCwV45OO8PwlYJKKqGX?=
 =?us-ascii?Q?45MbVnHZF2P2zY8BtrYpU9wFRFRaftUGu35qbbg862CAk8R52Vtqch06MVk6?=
 =?us-ascii?Q?/hj3NOkKFTO2ClW1tuSXMtB4PR9kBMzYsV/AAqYm/DOfQ6+nE6wUO8+zTKqP?=
 =?us-ascii?Q?4F82v/QlCogwthwUg840T9apxeqqcX9e9BgsqaGI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5dfc096-e8cb-4f31-c9b0-08dc978dac75
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 16:16:32.0718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0xZvulFZSlwTRuDBF9s9Y+pCBFv2/SCcoWa8KywyA4c2Jj0gCQU81jcyODNckPph
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5966

On Thu, Jun 27, 2024 at 12:00:54PM +0100, Joao Martins wrote:

> Joao Martins (11):
>   iommufd/selftest: Fix dirty bitmap tests with u8 bitmaps
>   iommufd/selftest: Fix iommufd_test_dirty() to handle <u8 bitmaps
>   iommufd/selftest: Add tests for <= u8 bitmap sizes
>   iommufd/selftest: Fix tests to use MOCK_PAGE_SIZE based buffer sizes
>   iommufd/selftest: Do not record head iova to better match iommu drivers
>   iommufd/iova_bitmap: Check iova_bitmap_done() after set ahead
>   iommufd/iova_bitmap: Cache mapped length in iova_bitmap_map struct
>   iommufd/iova_bitmap: Move initial pinning to iova_bitmap_for_each()
>   iommufd/iova_bitmap: Consolidate iova_bitmap_set exit conditionals
>   iommufd/iova_bitmap: Dynamic pinning on iova_bitmap_set()
>   iommufd/iova_bitmap: Remove iterator logic

Applied to iommufd for-next, thanks

Jason
