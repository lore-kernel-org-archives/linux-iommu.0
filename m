Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332F32517B0
	for <iommu@lists.linux.dev>; Wed,  5 Mar 2025 18:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741200759; cv=fail; b=MxpBlGbZpAD7gHBStbogN5kPoadsvAX1UGIb0dhD907/fOurRnrHcOWGIJ4hrLHRwPsNgXOso/OOJ8a82u59s7otx1vfBeOhMY8+kTqNQKO6/Ck6Kw9cfEPQjuUKJDdUWv2eDAuwnGxauUD/7dtPQ2qVZX5mLaEBJAbNa+trLNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741200759; c=relaxed/simple;
	bh=NKs6lFlICBsRYG9CIrrfyaVyfqXan5xm8tWg9IsTIAo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EhzomAlAxAEO8Z6wcqGohsOp2tepN7jyEnHEoR9OgS6ed1zR/F1jdIMtF5bBDLbIWeRnKMvfV9eSrVoh38zPlwSghUfEr/+BDiFJ6fSjk50UnOAMywDmOD5BIa4qn/tvjF+jLutpjxg7G96YrYFLHxNL9fZ7ehynKhvNkjoxt3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TQF5PXnM; arc=fail smtp.client-ip=40.107.94.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TQF5PXnM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YV6rwsp2uPr8pNTe5ZhVZCTtizhuoNhZNoGDR9T+ALnZYIn8Z2xoao2O04I28T4QYCgRO7mnGYccq20ODnsWlhQnu0JPKrlx+ACzmr1QQ0mzXdw1tRaFsu10ArdfDaMlTqyXtDaYZOdCQ4wlAuOYaoW4M5/pJuYzHqqx8uVsZd69Prh4jqkdC+NDG0Czv6eLNCv01nEgE4Ktl9eb3AkGY3oHhBjAL7QhcKy8ZNsCkCWOfrosvnjYCkD4f+IehjMx6LrHMuP9CvJ1e5CRr+7rcShWz0XAeYAFhDF3/dlONau56fokzaXngPtkZHnXCAwDFyIDbWwLgXExGRl/P290UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZOCvXDqlbamWP7Ww2UIbs3Ut8GTwRMKsjTXebx+ja7o=;
 b=eEGQX0NMRA8sFI0kDU3XWLi+yXwQW9zuFPWYGJ3eU4r7A2LUAZw0x3/+gOmDrK8EZZnhHVkWKGhKuKurotgGAKietoyh0y6IB7atKdHttXTZeDQg3kT3TgaDNSn8MtVHvTrGT8MCdv0cjt3ephDyaYjrig+Vc5j3/uORWsbhqggBw+/o26FR3rTNBacOl3ALd9yi5KmErYdgM8BzjnHD2MSdnPLTkBBH+BQRcozhQU2rOiGXxy+89pvmw9mnl0PG7FkcSzRrxz0aq4TbJ2ZNP3biWN/mHVJW6mnLVBhnQGKugZXI8ZgZSAA8/FNHgw+JUDQB8xLDRhq8tdtB92oOrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZOCvXDqlbamWP7Ww2UIbs3Ut8GTwRMKsjTXebx+ja7o=;
 b=TQF5PXnMplXPj/ak4XWIBKT2+8TaTP6BNfvsYawO8+kr9ALyIDBAYMXEhZRi7km4oQHa07CZKFDbTvLGjmRpeZcvyGKLiwm8zzfUECiGGxTh8tvk4YNQg8NBvv5g6bsMzwH9yQGCU55sVn+2r96ZoHZtzsFu+hLsKZ5n/mwWEO9PBNN4KqfCrgiyfBxZlhIoTVWD3LuiLxNtNhTBhL+fLdH7p4Oua+g38E5d/ktE+C18lwNbHqpfM+GQZWTaXlDXZowb+akCzqCGzpjYF0YD5fVFZhnqUppgUzM3V3zKhODb1iTw1RBvRBWddBIKZhVYxq3+YdmHSfL5xmVXpiMGQA==
Received: from SJ0PR05CA0080.namprd05.prod.outlook.com (2603:10b6:a03:332::25)
 by PH7PR12MB5653.namprd12.prod.outlook.com (2603:10b6:510:132::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Wed, 5 Mar
 2025 18:52:03 +0000
Received: from SJ1PEPF0000231C.namprd03.prod.outlook.com
 (2603:10b6:a03:332:cafe::59) by SJ0PR05CA0080.outlook.office365.com
 (2603:10b6:a03:332::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.15 via Frontend Transport; Wed,
 5 Mar 2025 18:52:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF0000231C.mail.protection.outlook.com (10.167.242.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 18:52:03 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 5 Mar 2025
 10:51:46 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 5 Mar
 2025 10:51:46 -0800
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 5 Mar 2025 10:51:45 -0800
Date: Wed, 5 Mar 2025 10:51:38 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v1 0/4] iommu/arm-smmu-v3: Allocate vmid per vsmmu
 instead of s2_parent
Message-ID: <Z8idOr67A0EG1/PN@Asurada-Nvidia>
References: <cover.1741150594.git.nicolinc@nvidia.com>
 <20250305165452.GY133783@nvidia.com>
 <Z8iWqOBga8Xdunac@Asurada-Nvidia>
 <20250305183151.GE133783@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250305183151.GE133783@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231C:EE_|PH7PR12MB5653:EE_
X-MS-Office365-Filtering-Correlation-Id: a280688b-1b51-4871-1548-08dd5c16d1e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1VqZO6+K41ou+aUA7iEMTJGHKBtlnc9tJEPKgyk9+qGqz4I7Z1wMMe5x7YzI?=
 =?us-ascii?Q?qgLu7ncBo+4AJTd2Y2rMbCvr7/vCEaTI0ZcpwQfNQ3pNBxw/vx2lMr1Ee3t4?=
 =?us-ascii?Q?y04xOcavbWzKWM0sF8Q2goAvgGbt6RlhmyNx4Tid1WDj5P6QoUmuxkMtVeFu?=
 =?us-ascii?Q?kZ3V0JtGYN7yxGmbNAR7nVP+JiR5l8Jc2su96Ex0BSFUaPRGw4OkfQrWQYqq?=
 =?us-ascii?Q?lZRm/cQjIpkJ22K8xnWkuGifsevGxu6w3mtoo59FGXVwGrjhDJf/cfTDHHYA?=
 =?us-ascii?Q?D530A8eYVmM0N65WeV7sJN+UgTDl1dhyuSG0SR3fBgbdYhrdVwn4t8tlwcmY?=
 =?us-ascii?Q?gjcnRFJkvzHKmkVTE9SyO9qQF3CcRQV2RMSMvSSlcDUJwlvXUj7sphRb1mwu?=
 =?us-ascii?Q?t5PInhUoSnAtxTx7EeEVuz5XvjKcTQ7i2tTXU/BKmh7vmJsf7/86aZmCvqvp?=
 =?us-ascii?Q?9ltG3vQUlc3AyDFawotxOBdPl8Pt62zk0i2Yts+hiyYhi18S7HNvN6AvDgRx?=
 =?us-ascii?Q?UrgjYHqaShlNteCOQpQDkjT/wkv8zS0v7OzOyJlt6JSnUMclix53XjTxLGQz?=
 =?us-ascii?Q?slf0F6htNobQMfO7ysLV1JdI727XNaiYaiko2KoqNQMtqSxRnsXr853pkdI6?=
 =?us-ascii?Q?GEbf5N8wKXmINVEAii2oTrTWoYrNnCox3rTIoORC+X0E61PFKralKpwUZcBw?=
 =?us-ascii?Q?4I1MDEgy9PCWoANGPuvviiZcq8Z5SL8MPR/3AIabK69NEhYY3ZmIb/qgH2/I?=
 =?us-ascii?Q?8PWQxRluLMkN86urZtsZmrImRvqPd896zk3MORhi8BWEW8s0k1YljokGHk1o?=
 =?us-ascii?Q?5amLXdBMhgzbLVdUw1Yur/AUOq8jt4LOyfs4iPbOzFP3TAC838/wDDKvyGdI?=
 =?us-ascii?Q?ryfAb/OdjtAu1sv1Ya9zymc1KZkvZH/zn4KrMynrrLqyPArrdahDWPy8wnc8?=
 =?us-ascii?Q?dVl99eRgXO5oas14vGZ3Hiyp8dSirjKeE85r83wPWMu/TBDzXmEJIvHhwfyT?=
 =?us-ascii?Q?F/rYVYYwAOMpqqSN+bb4fRlf0fwPo5NksqpW4AF2quBhn9Q8K/2hRFManDEY?=
 =?us-ascii?Q?o5iD2Oko83/6oyOWqBcKKkboMiUdmtvL2K/yGw978e0ApO4YoQaiTAEZoRXz?=
 =?us-ascii?Q?Er1DDcx652de6WqE6iYhfIsWa6Aeh7pDuFlnf4VFm3H6CNEfWUd0lFGj7epN?=
 =?us-ascii?Q?N37uSTZ6s5d/Wy4awOOCYNwT5rOWDHqpmGrhArTArM+vhK+rlDt0IWsKddyI?=
 =?us-ascii?Q?3B22Qtu5qDZQMtf503/3UbceUtbs3ao1RXzBqmeWq0Y377+LtQP5CyDNjQ1e?=
 =?us-ascii?Q?HjYaCgZWoNhTQPyVba+42gUgok0w8kfaxlUqjniZiuop+0zjIJ8Ccoe348ei?=
 =?us-ascii?Q?jHyubTXJ6pg+Vq5XYGMi0P/vYxHQ7nYk+soB2VZgYu7EvIaEQ7/4D/PQGMFF?=
 =?us-ascii?Q?0i39ZN4CD2Yg8uR8iZ6Uh7cvg5FVI9uarcsstb/dhDSPQlddhMFHx0Sw8JDv?=
 =?us-ascii?Q?J51CnyUjJ+Wbd2c=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 18:52:03.5977
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a280688b-1b51-4871-1548-08dd5c16d1e9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5653

On Wed, Mar 05, 2025 at 02:31:51PM -0400, Jason Gunthorpe wrote:
> On Wed, Mar 05, 2025 at 10:23:36AM -0800, Nicolin Chen wrote:
> > On Wed, Mar 05, 2025 at 12:54:52PM -0400, Jason Gunthorpe wrote:
> > > On Tue, Mar 04, 2025 at 09:03:59PM -0800, Nicolin Chen wrote:
> > > 
> > > > Have a pair of patches getting the functions ready for the vmid migration.
> > > > Decouple the vmid from S2 parent domains and move its allocation to vSMMU
> > > > instances. Note that a regular S2 domain (!nest_parent) has to retain the
> > > > s2_cfg and vmid for non-nesting use cases, if the SMMU HW doesn't support
> > > > stage 1. Then, an S2 invalidation has to be iterated for all the vmids in
> > > > the vSMMU list introduced in the S2 parent domain.
> > > 
> > > I was planning to also fix the S2 to be able to attach to multiple
> > > IOMMU instances at the same time as getting VMID to the viommu.. It
> > > doesn't quite make sense to me that viommu would allow multi-attach
> > > but the normal cases wouldn't. Did you find a shortcut?
> > 
> > Hmm, not quite following the question. You mean vIOMMU attaching to
> > multiple S2 domains?
> 
> I mean a normal S2 domain attaching to multiple devices on multiple
> instances.

Oh, I haven't thought about a !nest_parent S2 case.

A nest_parent case will not allow devices to attach the S2 but
always to a proxy nested S1 as we discussed previously. So, I
think the implementation could be very different?

Thanks
Nicolin
