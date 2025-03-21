Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2071.outbound.protection.outlook.com [40.107.101.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D921CDA3F
	for <iommu@lists.linux.dev>; Fri, 21 Mar 2025 17:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742578227; cv=fail; b=ZskeQw4QYntiz/egcW327fbYkrit1y181uyQOaSaHY0KIZLfQcWqSkKgd2v8QDd9vYGeAgQJos8jAYhnkbblv5dV8AkKQURGDVlE9YUmjOBaQlZ8VRur0DryCxxZ2Tuso4Fp0RVKfrSvZWpu0BzE4C62BCZkndFjLezmzsw/ns8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742578227; c=relaxed/simple;
	bh=HbnrfWnmhNtkrdiui1n0SUA+mkB00cq9u9UR4TC3IEg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tBkRvmW+wSJ5ret3c8TXcJOfGwuTs+5dBRwPNmZNZEPBKq5/1n58t8SemKW9YvQh4hLXP7VTgh510yggtyxMWLZn/DWPmIUyJIYFcmLtd2weYYMgshh7m2qBe4vMbIPFimT8nDxLFSjHFLClzag/318tNb7q/MmBei7+4hdPq+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JdWwBOXE; arc=fail smtp.client-ip=40.107.101.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JdWwBOXE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GbNYmrg/foPBh+B0qBHAZPh4iIM4P4A3oGLHVrlyR+M/X+6s4Qc9c7Oplo3/1YSmE34GVsYiSxLJf8bs6BoNWieB1L8a8gU1sn8+/l4Qb/2yCCIlFAY8fB4I2bXaMqxevHNctp1cHcTIE6bRgWhmP7qeKWSd4JNoQqnyvUKeVEFYQyk1S204jWjH110kyjBGkrsQpmhp9thB+H8fs+n0gxi4ka2XN4HZ4KFXsMFjM4titlaNZ21mq/fjFQQg03oDLWcLg1yuwhWr06mkAysKqkETMNpsHrXIscU3nFm2lP7j7+gWg8fN6u2Eez5o++zmxJkPPnmEvgXJm/WcunraDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CHDG2fHlv77RQJM2w87+P+eYMfYm4hwkO4sBQKIJh0s=;
 b=V++eF0S5odNtBCZ13E5CKQZKTyqnbNqVUxmdXDDW4nrsgnCel66wB5mbwoITev7V0R3aacRAQYYDrj0YVVuR9mVMQjOV4MACgiCf1kC9UHp1kReCBtXYfGsq9Vzju6XSAiKxBrIuW+IiFYzyrhYObzYOGXG+u2RcdSt4SYxT376iiD3Imlh5ppqugbTtrUhuhvroWv0Wwpjkv0S4Nm8HBNT3v6GIOYCje2jrWM+Vi//PXu9i1m9EdpBQGBXl6Z08OIN0ZNlbITgMbiTq0bvfzvZKKvoIZpwY8IR0OHT2GybwiCADTCEcg9EDF238EpUhmp/98lB62Me+A7yLmb6J/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CHDG2fHlv77RQJM2w87+P+eYMfYm4hwkO4sBQKIJh0s=;
 b=JdWwBOXE9cV1MQMKGUiQYAcdEmmtDYBM6h3r+sDIC7dnK+R7l6SSeqPnJTRtoR+TT6wCgu7xcC4zPNB0xRmSf3DVYSGZNVj26cAwtSSf69MEXzKuiQdlIg0IJ7Uu23Sz8OfJfnZxtfGl+LomcCQftXN+XpExM7201tuvuNjrhI8/ipzgsTTlAB3j5wubfWNCxQrS1lMpmcL/H85r1muuieL5ChHSFtOQnGgSPcOPXUvcbTTCtWEj0e1GZoma95jb1jkOKCLzRoOXeJKqIar5wE/7JjJffIc+h+ldqkv0DaRJN2SNiGp/f8RgKy6AIfNNubyoAv0RBPU3kmjniSzjrQ==
Received: from CH5P223CA0004.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::24)
 by DS5PPFDF2DDE6CD.namprd12.prod.outlook.com (2603:10b6:f:fc00::665) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Fri, 21 Mar
 2025 17:30:21 +0000
Received: from DS2PEPF00003439.namprd02.prod.outlook.com
 (2603:10b6:610:1f3:cafe::13) by CH5P223CA0004.outlook.office365.com
 (2603:10b6:610:1f3::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Fri,
 21 Mar 2025 17:30:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS2PEPF00003439.mail.protection.outlook.com (10.167.18.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Fri, 21 Mar 2025 17:30:21 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 21 Mar
 2025 10:30:12 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 21 Mar 2025 10:30:11 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Fri, 21 Mar 2025 10:30:11 -0700
Date: Fri, 21 Mar 2025 10:30:09 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
CC: <kevin.tian@intel.com>, <jgg@nvidia.com>, <joro@8bytes.org>,
	<baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>
Subject: Re: [PATCH v11 00/18] iommufd support pasid attach/replace
Message-ID: <Z92iIdpNz57WDYyS@Asurada-Nvidia>
References: <20250321171940.7213-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250321171940.7213-1-yi.l.liu@intel.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003439:EE_|DS5PPFDF2DDE6CD:EE_
X-MS-Office365-Filtering-Correlation-Id: 024178c2-2580-4cec-a42e-08dd689e0e8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YYKzWH+2c7otvW0ToiEk0y4N41xfMAjjPqQAsR3yXRtXsVShHacgLbKnn2R1?=
 =?us-ascii?Q?NHPLOHws+ur/rU2eo/IVkqG/Vaev5ydA6R8bOJaBIVoaCBHHIfLuMKkD1pf3?=
 =?us-ascii?Q?xpfM5u3ChkWOozdC47pOzITTJR4HH9rMn7j49y8T3SWk5W1SLMO1xK5vkoo7?=
 =?us-ascii?Q?F+KPzoGGsEpKjUKHtLy3QDnAVUYKYv4+hNBniiT2cLBeZ+1oC00V6ZYlUlb8?=
 =?us-ascii?Q?doJ2BTH7XHId7bN0D+U9nWg+ijXCeNh8ldv5zM2oRLxU1Opu3n3MA5AqO8qS?=
 =?us-ascii?Q?17IAsXFbfZMBTvVAnxO8jTPumMaf2HNQUUvOE/O2FerogXJdDJBsR7fSUCw0?=
 =?us-ascii?Q?YSKgYgf5f1aW8q4CZNa8p4N9x1JgL+g1brl7BZ1hwjcuZC245RhdOvY7irL0?=
 =?us-ascii?Q?Ji+QeBc7zH2K7uowDesizA5ltG6P3iC+6GWrHTO6KyATDaWU7lcPwYXg3gw/?=
 =?us-ascii?Q?nBc7rxXJ39z7v7XgMeUkKexsogpSkm/xj7YGBduT5VDfiRL37tg8xRrt34wG?=
 =?us-ascii?Q?EpuAH9ulBbs09kGj1X76K8pvebIqajaoUE3p9yG93Qa4AaVY95PCbRhXAgG/?=
 =?us-ascii?Q?wMFqAp4D6VGwVy0GctZ25KEJsugFOCsNUINjvlK0jEVKfQ4QS9f1RHQxI2iS?=
 =?us-ascii?Q?O2Rs8cL42OwyT5xZSgwBXbxNOAifxrtKSoqs8WXZFe7sJG4e06F/F8nd1DIg?=
 =?us-ascii?Q?eGsqwmotNouXfW115l0qfC+hodVmSCTqiCOMD5gA1LQ5Z6JRl2YSB6Ui67Wi?=
 =?us-ascii?Q?TCndP5wRw/K/t25eVZVLC1zc21Tf97z45iiQS3zT5zEGENTfcZkvRE8QgdVi?=
 =?us-ascii?Q?RSlrWiMn7RTMvKnoJ6fmp0e5gWsQyIKf+p4BVTKkz2KfV2+KVILULQm3zYdr?=
 =?us-ascii?Q?Gwxc+pXdEPSFZSlMW76CvEthghzyYXr40ZAMq4VGHUbIW4I7RfxkJ1kVv7oj?=
 =?us-ascii?Q?082+5SSIOkFcRBL0BtqB11V/aPgTV5YyYWgZ9xvRlI81guwadfjAHZ0nQLZO?=
 =?us-ascii?Q?Ut4h9m1rFsb6B8y8AeRGvI2op+QZ1ARPLYVkmZfAaChgdFe2f7jid0qL+AVP?=
 =?us-ascii?Q?qoquqtdhm6w/+LhTL2mZgaT41VFnjUl9oifIDx4spJDd82WCCwf5+eSodRvz?=
 =?us-ascii?Q?Y8l0ucVXiqE/GXB63bt3vHPxSUfq7uqrDE01zq6R8jyGDg3moD8L7rAEYfKX?=
 =?us-ascii?Q?G5IAZUkYWnilHGczkQjpqFhqAqHmh9UPCfd7UubyDKIeyxAp8rcUsBkNhH/H?=
 =?us-ascii?Q?/4AGu+L2or9dqIT8tU0uFVGOB2lKVTqzOIBTjvtFI9h9NWL2zhnOj86VH+PV?=
 =?us-ascii?Q?PddffzQHtrj7VvXHZkva+U636G+T62aWPgpEeOZuO00bGIi0y9OQmfSW6BCG?=
 =?us-ascii?Q?q7YNVWr2ElLKazhmQqR2Vx6VN9nbWqhpyUstfGZj4mJlg6/5ygidVLKZyyVt?=
 =?us-ascii?Q?ZuzO02sSVwCeWQ7RaDFKITPLWGbeKxun0dD0t4i28oPx6Oh+0xVvVmOctllQ?=
 =?us-ascii?Q?vvb8Eprx20HhBrM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 17:30:21.3291
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 024178c2-2580-4cec-a42e-08dd689e0e8c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003439.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFDF2DDE6CD

On Fri, Mar 21, 2025 at 10:19:22AM -0700, Yi Liu wrote:
> PASID (Process Address Space ID) is a PCIe extension that tags the DMA
> transactions from a physical device. Most modern IOMMU hardware supports
> PASID-granular address translation. This allows a PASID-capable device
> to be attached to multiple hardware page tables (hwpts, also known as
> domains), with each attachment tagged by a PASID.
> 
> This series builds on previous series [1]. It begins by adding a missing
> IOMMU API to replace the domain for a PASID. Utilizing the IOMMU PASID
> attach/replace/detach APIs, this series introduces iommufd APIs for device
> drivers to attach, replace, or detach PASIDs to/from hwpts at the request
> of userspace. It also enforces PASID compatibility with domain requirements,
> allocates PASID-compatible hwpts in iommufd, and includes self-tests to
> validate the iommufd APIs.
> 
> The complete code is available at the following link [2]. Please note that
> the existing iommufd self-test was broken, and a temporary fix patch is at
> the top of the branch [2]. If you wish to run the iommufd self-test, please
> apply that fix. We apologize for any inconvenience.
> 
> The series is based on Jason's for-next branch.
> 
> https://web.git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd.git/commit/?h=for-next&id=e009e088d88e8402539f9595b10c0014125a70c1
> 
> [1] https://lore.kernel.org/linux-iommu/20250226011849.5102-1-yi.l.liu@intel.com/
> [2] https://github.com/yiliu1765/iommufd/tree/iommufd_pasid
> [3] https://lore.kernel.org/linux-iommu/20250306034842.5950-1-yi.l.liu@intel.com/
> 
> Change log:
> 
> v11:
>  - Handle is always valid for the replace API, hence drop some meaningless check (Nic/Baolu)
>  - Avoid inline helpers in .c file patch 02 an 06 of v10 (Baolu)
>  - Use xa_load() instead of xa_cmpxch() in iommufd_device_do_replace() (Jason/Nic)
>  - Fix a memleak in patch 11 0f v10, it's due to an order broken (Nic/Jason)
>  - Make the auto_hwpts always be non-pasid-compat to avoid confusion between
>    the RID and PASID path
>  - Add pasid-num-bit as 0 for non-pasid-capable mock device (Nic)
>  - Misc tweaks to the patch 17 and 18 (Nic)
>  - More r-b tags

I am running some sanity with this v11 using the iommufd_pasid
branch, and will give Tested-by in the next a couple of hours
so long as everything works fine.

I sent a couple of replies today but I think they are trivial
and can be cleaned up later if we really want to.

Thanks
Nicolin
