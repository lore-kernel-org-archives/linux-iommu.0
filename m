Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76922130A7D
	for <iommu@lists.linux.dev>; Mon, 20 Jan 2025 06:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737352933; cv=fail; b=OWjKzmv36xJPZfS/BLbmpKIiyyGBSbxA7HrPZzSD41lhQsSJ0imxl02j4zDVTvv6J4DR8D1hf26fdajxmPmbwuUXjLhMXsgQtPLVUQJ+RAaj0Bn6GS/F2+k3XBSPYNgQF6iRkJasewP4bm1jtxqTjfh/NaYFSOdbKrFrGLL5Nkw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737352933; c=relaxed/simple;
	bh=NQs+vJYdwIifYrx5TLe/FD3cYCvJPnUBRibRTCWE1jw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mFXNsn0kfzsM5WGOGUKsMi7kBXX16+QjJ34TvFpKQZY5GV/WzojV/FgNllAux2qnsj4QvhZK3FLYFwIwWv0yLDO0qBN9H0boOrZ18PxqNv/QFRrtNKhQTqJc9DDtUkXuPk8NRFR35EK7QJH5xsY9AjtJCvYWdoqNRL0j+lKSjR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bJQKzZmQ; arc=fail smtp.client-ip=40.107.220.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bJQKzZmQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=egV85xzy6NHWpJjTIKc6KrL28Rhnl0dUCTnCe1/6VNBk+wvOFYHehzgPNRPRJRpxXeUjWNfD2EeSrgv2+C9rKKqtjxzUX6EId+CDVOOBGVkdgi12dQIPQPRVzJCrZ24MM47DuVyh0dpWIeB/iHLm4UOEOcc6JnBgESRILB7Syut3zrMR6RbnU2D+5l4Djm+0mjSxK/eFCat7BrGYrwVb/CpLXX9ZsXHFJK/RNMth70Xj/YeO9R16qTiI5gpVyADTF9jQTnDKCGsiGVRBV87g+4QJ4eRAB8B8A3+tdCw6uTe6IC9EN7ToO/6c8z9kTso/eR/kgz8a+2jGe4wJ0YFrBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ts2ZYaply7ZbkXLlPxLNAJ+AVpRyUpa/XOHszRjpYmo=;
 b=O41ADg2DXbH0oY0LwF/Y65V9ab7M9GZ4TT4LyQ/o/ogZMhrOZqoHLUhLWmR73PqH26gmX/DqlepLYutyc5J3NWMDpGz+AfSyxViUEBeFEIKBXlu1M6PiQNVopxWdU15ILublLrK0Y3hmmluAxbsUWJxP5uLRcM3DdwV+Cfn4S9rVzwa7R+Y2RyLI5AFAjg5KRvJ+nODjs0GS4nT2I8siJSiadQ0KVdBsT2EUUK3oHmYHjx1NgNAg8/dI8zJYwLrfMR+O1cwwSDYetfsUxta3uWH9CdAl1kR5vzG8Nj0USGPjwkeJpVdZhG7LZo0LpOMTwLs6cjq/wGXAUj2dSXG1yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ts2ZYaply7ZbkXLlPxLNAJ+AVpRyUpa/XOHszRjpYmo=;
 b=bJQKzZmQGu4qD0DdnGnDSZwvnpvbCHcKAEgHbK5f1EFnvcI5+itE0UIkd4ObVh8JOgJXVVZ3VMU+ROiYiuSQ8vqAlT4CNS22GjWmtWewzeL3WLgkc23pPoEPAWIJ5ZbSTwYC7d+CKTBPlNv47pvnkQeukXcACZESNaAoWg/f8Zr5s0xkiKcIX157MqPHEdwByJw33MWJybMwcy7yVXoyrAxODTuG1OoFw02fHdissbYMRLaGC0rTH4p6OJQJQZH4FQJstdyTWWYpchW6B7A0uvxQ+mcQqzCHt7OT11kgX7optr4IflolJdcjZvctZI3uP8Mb8ha08+V4uykMB8fb1g==
Received: from SA0PR11CA0142.namprd11.prod.outlook.com (2603:10b6:806:131::27)
 by MN2PR12MB4392.namprd12.prod.outlook.com (2603:10b6:208:264::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.22; Mon, 20 Jan
 2025 06:02:07 +0000
Received: from SA2PEPF00003F61.namprd04.prod.outlook.com
 (2603:10b6:806:131:cafe::e3) by SA0PR11CA0142.outlook.office365.com
 (2603:10b6:806:131::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.22 via Frontend Transport; Mon,
 20 Jan 2025 06:02:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00003F61.mail.protection.outlook.com (10.167.248.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.8 via Frontend Transport; Mon, 20 Jan 2025 06:02:07 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 19 Jan
 2025 22:01:51 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 19 Jan
 2025 22:01:51 -0800
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Sun, 19 Jan 2025 22:01:49 -0800
Date: Sun, 19 Jan 2025 22:01:46 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: "jgg@nvidia.com" <jgg@nvidia.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH rc v4] iommufd/fault: Use a separate spinlock to protect
 fault->deliver list
Message-ID: <Z43mykycTXADF6KN@nvidia.com>
References: <20250117192901.79491-1-nicolinc@nvidia.com>
 <BN9PR11MB5276FEBFFEACE603E45517898CE72@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276FEBFFEACE603E45517898CE72@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F61:EE_|MN2PR12MB4392:EE_
X-MS-Office365-Filtering-Correlation-Id: bf451042-678c-4728-120c-08dd3917f8aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QzHA8fW8gi8EH5GaZxWoDY8P7tjciqft/c0ygCK8WKfwSYhZHV/saT7ZIpcA?=
 =?us-ascii?Q?ID84x4GH+n2v9gXRpuRxXtaV65X/rSYqGZZWGU01vJe1xbEgXvoY3S4i/bZN?=
 =?us-ascii?Q?ir1uf1VnrRd48cQLkobzlNVqHGcrSwZ8ywH/eT0NCmwT21RkhFmP9NvjduFd?=
 =?us-ascii?Q?FJEPuIU/To6l0UscAg7j9VVGRZ9HSv9EaF3Cwvj6+yDfYIwL9sKfnI2XpFMS?=
 =?us-ascii?Q?ZP7HEMSHdCG/OokSLKm/8pQAKpF/KcD8UqUVZaHRAzIxyaFqDMf3fdoXGvFy?=
 =?us-ascii?Q?mtXwXTS/+xfMPXhIWnWvySRDbebQDGe1MyWJXs3+ySmKA3hZ5IQightWag28?=
 =?us-ascii?Q?d2h1Whrx8JuWgCKH9es5MEnWVFaJ3BXVslzrkQqGUAaSD6FyexF22J0LnzMJ?=
 =?us-ascii?Q?yAZOddMOd848lsJTGZqe0O4ClAa/u70wC2VFq6OD45QyxZqgqfAsegcSl9FG?=
 =?us-ascii?Q?bxlD/gLd33FHgF5ht6mfaMMihLKBD0ZS24y/iOSuGCfQnWZVdF9usK6YNGao?=
 =?us-ascii?Q?mPqRPMxgUspCx6aw6hzQJqKwXEV+NRhpVAQg/K5AECrtdPJL+K6PGslEeN6I?=
 =?us-ascii?Q?XQ2sauKDo56AEA67fxUm3NEB3X+3yaCnQ4cdRF8E+UUozUiAFElJEwEl8QhA?=
 =?us-ascii?Q?5TQy8XQVIy2vj6UgY8wW631a3FkqCd8tQs3NxM2jDahjIqbopNiXv/5he+il?=
 =?us-ascii?Q?rxTMBnE/5IUG83ElrOwGsSd0LUDw0ZSifrcpWBnduA7YKQ27TxF0dfSIO0ej?=
 =?us-ascii?Q?MuMcO/lX9c59ANRPCUHoL6yg/WZmNg/wJqSxh0nKHOi4WO96Z7ConUJutJe1?=
 =?us-ascii?Q?+7hnUieX+NRLLojem73EHfo+xHaCdVXdY0GzcvTpfpUkN0LzfKIIh4cQ23SG?=
 =?us-ascii?Q?wxmCV15Q5p+oWJZ45DjLKO16v4Wax4y0H9fj0wCfkb/i2Q98cTvLchzuvNuV?=
 =?us-ascii?Q?c0lAW7RJL+w/GEWd9974s0rOPbbQevxDzTA68zJ4IYdYOeoIH+TfE+rGQQBC?=
 =?us-ascii?Q?Ofeqo0pKBuGpBnYiz9GgqXQc+CnlOykEPE/Q0qLYjDMVE5YN8LzuEETBzQNV?=
 =?us-ascii?Q?hpTmtCPClll0zwCbT8XT1MTV4mi9qxnqwSmxoDtN8Z26pT/H/YX2J+vfklFU?=
 =?us-ascii?Q?4Yi3+ChKmUWvYv1aRX+qz99eIOa5wh1phWfyc2yba2TVQEN+gqH/S0afDm/f?=
 =?us-ascii?Q?BFb9VqkUpOWiUcthacg/t4PGuPir8nz4N9ptmxKRF4kvunsMIT4OWn5GgpoT?=
 =?us-ascii?Q?EibO5jB0YT0SxWnWLOFX4MpCu+Y9gfobz7HuEGTKGXzxdWTqbMWr4XKn+CI+?=
 =?us-ascii?Q?Hpj+T5Kf4Bw3miqRwF0Fka91I1yaq6Q6cFpHkAZlnBotBKbGhSto7QBtpwiE?=
 =?us-ascii?Q?FKOiiQO3kz1K/0FtqfghdKSq5o9KGioLpsVWZgWmNgKQuuWXkjmrbDsTiNmV?=
 =?us-ascii?Q?M97YolEaygyWgZL5NnCifFafsEjOU+FjJs6XGqlZaYNdpGus4fxwjw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 06:02:07.3842
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf451042-678c-4728-120c-08dd3917f8aa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4392

On Mon, Jan 20, 2025 at 05:37:13AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Saturday, January 18, 2025 3:29 AM
> > 
> > 
> > Lastly, move the mutex closer to the response in the fault structure,
> > and update its kdoc accordingly.
> 
> Then this comment is stale.

Its position "in the fault structure" is moved though.. :)

> > 
> > -	/* The lists of outstanding faults protected by below mutex. */
> > -	struct mutex mutex;
> > +	spinlock_t lock; /* protects the deliver list */
> >  	struct list_head deliver;
> > +	struct mutex mutex; /* serializes response flows */
> >  	struct xarray response;
> > 
> 
> And the comment for the mutex should be restored.

Why? I followed Baolu's suggestion to update that.. The response
flows are in fops_read/fops_write/auto_response, so I think the
new comment remains correct?

Thanks
Nic
