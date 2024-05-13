Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25874146591
	for <iommu@lists.linux.dev>; Mon, 13 May 2024 05:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715577877; cv=fail; b=OrfiLABUofc/qA2UD7rKdIxAnZA4ZbMQi19/AgC476BxtmfaagkuGyMShCEiYzkWZ+rRTr8BxnDmI17h8HM+atvvYXRxqmvVIY5KnhJhi6MHv7M/csM6Tmnh1b1CAhwSg+CIBAOs//F1rF28vEthOkbAYFYTbyF4yYbW/jlOSSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715577877; c=relaxed/simple;
	bh=JO282q2Yd5V+ks6qGmD2qEAogpnI3useUBuo2XJdFCo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u5CFhsK3zD2zeK7PUw7b/0WSUoN+Fe5X6AoOCHyWOCHLBfhv+6MC1MNfmsEHVIVjcGH3vV05crc3uVJOYoTFrvuAkBKzOLDDIEAZ209RQ2nKvwrU4lHusGcFcZ1Cu7PhfOtVrK5z8kEfVpjgrwvx91q39Xd45fUL2kUBU+gFjps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KwsfcECy; arc=fail smtp.client-ip=40.107.93.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KwsfcECy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tni6RSiEiIeAYYv3ajlo1JtkdcpikbaEbZSe0I7rmrrPeUWe6Eo5VekfY9uBPUOJwaOo8m2hHwCfG/wuVqlVBykjBS0IFGoi2DS90Kw8KoBLJnfKIQc8wPFa/jwPAe5X2E8p39Gk3cA7YKDa3V9FOgcEkzemoHqv276Wm2QwIYmF8HYGazv3xjw2vDMIZ+j7C+VhPYSFrToHNpEkp7oA5GAncoSl8AbNH5QmJJoiEruLuS+CThWyEsw279X7OdMws3/9i4rKMGyDLUvhSWJ7zQ0pXeWqKjy0gBfxX+MgQ2pDf26xq5UYj2YhahrL094vI/quGgJybD1PXbd9T+jfkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XJ7Vu1bxN0t5sJ15S/s5XHnnbIqqFGqcMoB8MCzpzso=;
 b=T+X5b02xBdkXS/aUWZpIuYgHhQQfD6vbouNsWSgkVHEzI8i+NwyGfJvE0OYSCYWUcDRsCDkPLJAor4Ew90PNgY8BDXQNtuhv3AFtL/GIHc9YRb6t+2nwKKfITyFcY3PL+d35g0q5aV3kwys+HHRcw3EK46TE5yB+/IPeOzPWFIu8Y1oQNvtSPKUm7fJ8IZRzQ+O1fwp5hef4WqsoRkpAYd1ldwsce7rV4mWexST/5iCf+CoKX+IoD34pjJHML6t3YJQY1IWQgEoDVhYng0fyoK4OJoO3nv2+FvPu12y96ou3a/L3D05uj4qQ6/q2S22qIaUdKZkAnIjcFx1YuzDKDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJ7Vu1bxN0t5sJ15S/s5XHnnbIqqFGqcMoB8MCzpzso=;
 b=KwsfcECy28EQx+DWzlPjms/TEUNTgeGpv59/pTtC8jboq3Ur7ksDq3vAHJ40BRGx19+JGTyq/yXnEm0ab8sfkybh5U6XYHhHnl3d+jfObJsgHTm/q9IL6tMXnyiyWqvEcIjphh0FYZZZEQVq8KetllR7PeFI1rQUhzdQlDGq2onAmAsqE+lg9aZNK3hTvrllzDBsjIPef5oUxAcu7zzxTFuActemEPNAOv5E5HLIPDc1PjPIGD+UhmPf5SoPHry4bAGuG2kdMO+wyjCxfrO5g6+C5MNMkYQY994ZI8pSKsdjVaLPKrQETTY4V7MrJcxHtgk9Q7sE35PVIB2smVQkAw==
Received: from BLAPR05CA0021.namprd05.prod.outlook.com (2603:10b6:208:36e::17)
 by CY8PR12MB7217.namprd12.prod.outlook.com (2603:10b6:930:5b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.54; Mon, 13 May
 2024 05:24:27 +0000
Received: from BL6PEPF0001AB50.namprd04.prod.outlook.com
 (2603:10b6:208:36e:cafe::3b) by BLAPR05CA0021.outlook.office365.com
 (2603:10b6:208:36e::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.18 via Frontend
 Transport; Mon, 13 May 2024 05:24:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL6PEPF0001AB50.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.21 via Frontend Transport; Mon, 13 May 2024 05:24:26 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 12 May
 2024 22:24:20 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 12 May 2024 22:24:19 -0700
Received: from nvidia.com (10.127.8.10) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Sun, 12 May 2024 22:24:16 -0700
Date: Sun, 12 May 2024 22:24:13 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <kevin.tian@intel.com>,
	<suravee.suthikulpanit@amd.com>, <joro@8bytes.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<yi.l.liu@intel.com>, <eric.auger@redhat.com>, <vasant.hegde@amd.com>,
	<jon.grimm@amd.com>, <santosh.shukla@amd.com>, <Dhaval.Giani@amd.com>,
	<shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH RFCv1 08/14] iommufd: Add IOMMU_VIOMMU_SET_DEV_ID ioctl
Message-ID: <ZkGj/RLTnqA+iN7l@nvidia.com>
References: <cover.1712978212.git.nicolinc@nvidia.com>
 <c97a98a72ee3498c587e5898d6b899553ccd9b27.1712978212.git.nicolinc@nvidia.com>
 <ZkDZE32JFyKprmpi@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZkDZE32JFyKprmpi@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB50:EE_|CY8PR12MB7217:EE_
X-MS-Office365-Filtering-Correlation-Id: ed09b2b1-81d0-4e11-139d-08dc730cf538
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|1800799015|376005|7416005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Wph9AMyYjf8/rdYLVxJxmi7J9CpWUtW4n7KJcYQle8gmU/6DCaKkYLckwfR0?=
 =?us-ascii?Q?tmfrs+zmPL45HUAREH+IBx8alzEhoKTlrgWBxzTd1o35NDIUfywn/p/Tvxcz?=
 =?us-ascii?Q?tpGwV4rfeB4nqD7Kh/cBhfBSVpP5NJ2/uXf3XpbUArIgeQBdUpoP9Ijkgaaw?=
 =?us-ascii?Q?dsq5bhbBk06Hz+HmFWTwQgzKD9/olz4r9rXTbGHXhZcLRuhKwOi+SVY67bcL?=
 =?us-ascii?Q?nUSA9PPjkDsrDMt6Fk/NET8622b769bfQ3UYQDZ1iMMkMDi2sCOiJ8F62YMV?=
 =?us-ascii?Q?8T7GcEXt0sQock3mpnYWAoenPBmSkMMyBP6CpB2+3TVb02EUnNGxY2PviiMK?=
 =?us-ascii?Q?tm4nSrPx+AxQMfXgkXUOI5J1L+O27RNpN+Iz+wgaOgalNIwS0fyX9aYgVLq6?=
 =?us-ascii?Q?ikyBk6pTqMO5A+ZPuUcnn07ivGmU+n0MGxlmwWxs2UDs9DFSd0sSDCBUsc56?=
 =?us-ascii?Q?OnXw3c8WmnhDLLtoOO2bCCbcnW8cwq5xtjCWek8OBJG9RyNistbtmOAJERkO?=
 =?us-ascii?Q?5+cV4aJUWCzEqF1kt3Gur9fzRRPbjtQIWtkij71pFBOP2Ax3W8x1BVKQu3pb?=
 =?us-ascii?Q?vrxqHlyT9/+ltvW752owkuG6DMHT0YNS+kTT+MeyVd7kO3e+QFxYbHBGBMEP?=
 =?us-ascii?Q?MHagzvJjh9ubMZbYVWjSClz1IVQQEj+JbrNmHaK0XVYdX51+8fA4I6kxsz3X?=
 =?us-ascii?Q?W2gS1jsnL8XjJPhAHMIqUX2gK5xuaq3A8cWnEwwTM6v7zb+YxE6Gfozppby/?=
 =?us-ascii?Q?s8lLpo0hEwAcqgSiYOcLFrGzaVUNQKDC6XkUR/ElWZ8RkI7qxD661xC7Z2d8?=
 =?us-ascii?Q?OsDD4Y/z2ZyOq9ripfp7moBQYSYKprOGcc+JZYsI9qD0mCIcHChKwrDgIsZh?=
 =?us-ascii?Q?dfvdm03+jlJ48o1yeEyhUXO6Sraelu9oY9THsVRkYoK+pbwzDEdtcqpdj701?=
 =?us-ascii?Q?07bsf9WoxZXelAOygg6pKKFAF97RIXX+0aIhqLI5w870wKOrH00qU2Rmb5qz?=
 =?us-ascii?Q?cfaSGqFWySabF+Q243TPDU0D36sNBQuO6dZQ5yFbi4v7WWHN7GtHl4dCL5yz?=
 =?us-ascii?Q?ImsWE59cQt5zPi4my0c7UrWLVpIBN+WBwI+Wm66+XyCMvlS3lKSXfYMfooGe?=
 =?us-ascii?Q?4mATNjl4KAnPq7AfoALX4OWXS2McojvgGFjgs8DkYauuhV5FkT7UIa9wnLH6?=
 =?us-ascii?Q?YOLKVhXGsfEU4yuvzSVp91pV/smdqASdsTXVA/8gt3LZwvdfTUuF1owgPsWA?=
 =?us-ascii?Q?1i9AqWlD7wkrY3kluTaKSbBuXfaFtvt2kd1Hg9N/j9vgAn1I8KiWA5BKy+aU?=
 =?us-ascii?Q?v8zwIErFUmiMcabp8Z7KeOJdYgXLQuhLc24LVJUO1KkvwCCk//cNWJQp3vBY?=
 =?us-ascii?Q?32ahc+I=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(82310400017)(1800799015)(376005)(7416005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 05:24:26.8788
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed09b2b1-81d0-4e11-139d-08dc730cf538
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB50.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7217

On Sun, May 12, 2024 at 11:58:27AM -0300, Jason Gunthorpe wrote:
> On Fri, Apr 12, 2024 at 08:47:05PM -0700, Nicolin Chen wrote:
> > Introduce a new ioctl to set a per-viommu device virtual id that should be
> > linked to the physical device id (or just a struct device pointer).
> > 
> > Since a viommu (user space IOMMU instance) can have multiple devices while
> > it's not ideal to confine a device to one single user space IOMMU instance
> > either, these two shouldn't just do a 1:1 mapping. Add two xarrays in their
> > structures to bind them bidirectionally.
> 
> Since I would like to retain the dev_id, I think this is probably
> better done with an allocated struct per dev-id:
> 
> struct dev_id {
>     struct iommufd_device *idev;
>     struct iommufd_viommu *viommu;
>     u64 vdev_id;
>     u64 driver_private; // Ie the driver can store the pSID here
>     struct list_head idev_entry;
> };

Oh, I needed a better solution to store the HW slot number of a
VINTF configuration that links a pSID and a vSID, which I hacked
into struct arm_smmu_stream for now. So, with this struct dev_id,
likely I can tie it to this structure.

For a driver, pSID is known with a device pointer, while likely
no use to the iommufd core?

Also, I will address the other comments in your reply.

Thanks
Nicolin
