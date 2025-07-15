Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EB32C327F
	for <iommu@lists.linux.dev>; Tue, 15 Jul 2025 19:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752606855; cv=fail; b=o+Zz3iXG/067xMXEdMPS8fAhgenpwBKgBnm3vOqUcf1F/IJGLH8d/71FK7vvWCAaX2kNbDt3NoH5w4+QdVwMwxvZ8ZgbBdzpWK5vU2gs6t1YL54Pvu/rySXGGeaQDjaQaQX4RRbZ6LbAXxKdMncgbgWGT4Q40Q22rFb8Us8qXg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752606855; c=relaxed/simple;
	bh=b4Li+5WwtDtmHOQhnoOYftLWvapvHOTkMJjpcFJo1yw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bSn4vlGN0KIc8khgDbsPJAWN2fe0ASoHIMl6TZNuzpTkuotDBQyQ9RCqst0S7OMzA+qapvtpNoyiAm6MIzcbzW5pXASwfuTYrQJmJAtH0OUDI4zxXomqZfxzeEEaTjTFwzH1ELCc4RIi7p/2rjP+6MnL3HAI+Kf9jTB9MDD6M0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IejYcApL; arc=fail smtp.client-ip=40.107.94.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IejYcApL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yCXzfVpHJRxW9zjGcnBKSgo+NcbNV5G2VpfNhKuDI+KfahF8UDJyL9IxUYpxd/IHUiAxP8D/tdT1ax58gBB7Ph+ANwjjskeyc7iLGjYPDfM1LlLfcSM6eRzIinfWDk4lNaKiG94sEF2fOJVRYswiiKHPfGfRIYvmTJ5wq3epIdk0b44E8uYlvRXIQhxM0xK6mrQI8D9q8WflADfc6ZVh1ANHnTIU/yHyLSnx+d70ecVXlppS1oB+Y1icyv0LDlSnlKzGvn8qq+FJCgZLrrI/ixfi4qyPHnB4rvVKUpi3s8NiOOsHm2Ba+ZMoSMrVZg634ePF6k1oPonafPQgLwl98Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yG3LvAdLZIixb9ge6VBt+wLQvrOOH3oSs1fbxd3+JKg=;
 b=fXQAoUMG4U80sGX/jYuUzwxqQ5cvHL1Y31mTLtYhqPWiMJKxcjiKptkHSHMZ4o0MpuKwgdIvFplySDWCZPbwqX08eDHm2jTPm1BqfhEuuVxfAw+ZsvVVtQr6wfNxVezbDmagYEW25Z7GpGFPCCSRqCtE4ZxXCcnfqjqTkm/EosSMRN+8JhIlXPrWBkLBT0v/kv0OYdZjZ77lGqr/otdnAcP1bR3034aWj4rFwA9WPct8BILsskiANvBsPF7HppfjahQt30FkP31B5bdx7XqFzn05S2gqfwiWkaXe9VHITAk++9mqxv+6BCMJMv7sHBA3m8t5hkTN4uIHYPNey2yO9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yG3LvAdLZIixb9ge6VBt+wLQvrOOH3oSs1fbxd3+JKg=;
 b=IejYcApLM55ALJ0IXOwl4LXbPmfi0mPIqSVGpRQOyD4Rx2gqyoyVRdgbXsfyKFM8x0dX7BoUBWwdLNu5Q7R4U+JIKmR+Nn2RC35sScy3ijXfaxHoznpM0z4tfMsDB7EJttw/kwKhYbLbiSGwYu7FKVGCCNACenHO/Sr475h+V6fO7aU8UsWNiu/lRPPFFOT+ilcuFoDxn+68jpYRXdPfP+LSAGmxP5uEJxycKvMIERsf7wst8LwFW3DQlhYKWjPcq6DuJLKZJXczRLQdN1GkNNiKgsc13XZRbjSOUV6gfBDC3l063AnBUxRKVy4hLK/l7qvJH0ho3NWIovcgXO6Xjw==
Received: from DS7PR05CA0084.namprd05.prod.outlook.com (2603:10b6:8:57::25) by
 DM4PR12MB6088.namprd12.prod.outlook.com (2603:10b6:8:af::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.35; Tue, 15 Jul 2025 19:14:10 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:8:57:cafe::bd) by DS7PR05CA0084.outlook.office365.com
 (2603:10b6:8:57::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.19 via Frontend Transport; Tue,
 15 Jul 2025 19:14:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Tue, 15 Jul 2025 19:14:09 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 15 Jul
 2025 12:13:58 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 15 Jul
 2025 12:13:57 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 15 Jul 2025 12:13:57 -0700
Date: Tue, 15 Jul 2025 12:13:55 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
CC: <jgg@nvidia.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<will@kernel.org>, <aneesh.kumar@kernel.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <joro@8bytes.org>, <robin.murphy@arm.com>,
	<shuah@kernel.org>, <aik@amd.com>, <dan.j.williams@intel.com>,
	<baolu.lu@linux.intel.com>, <yilun.xu@intel.com>
Subject: Re: [PATCH v5 8/8] iommufd: Rename some shortterm-related identifiers
Message-ID: <aHaoczqqBIhZ7k1Z@Asurada-Nvidia>
References: <20250715063245.1799534-1-yilun.xu@linux.intel.com>
 <20250715063245.1799534-9-yilun.xu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250715063245.1799534-9-yilun.xu@linux.intel.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|DM4PR12MB6088:EE_
X-MS-Office365-Filtering-Correlation-Id: 02b0db7b-ca68-48ca-d0f2-08ddc3d3c6cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zkooCPE3R2JUC2jFBOheMIzxJfrpidBd0X4+ZMw7IKADAa5mwJ3G5lwoSSun?=
 =?us-ascii?Q?bdFEKxCEy9fgPXooW+2wfjy5mvEiwFQK4DDJbo2SGG8ZfCpAl6kY+U96QQ1m?=
 =?us-ascii?Q?CVmI6O1fzbrEkxc4MqYWtmZjQgNURG8pV7v6jXQCidKRH1Zx3PgmhwQoMPy4?=
 =?us-ascii?Q?6Fc7cNW0IljjwN7d4XMZN6g33md2uG87hBK0v7h0edqQjyrLc1VFyC63WTlh?=
 =?us-ascii?Q?IKaWOgbGUa3SFDueTJMsthb44xanyl6qb3llX9W403Kf4hBvezYfqKOTYem9?=
 =?us-ascii?Q?JR/E22r487mhGN6ZUdDlHsnlANT59TwQlvI1IBplXqa4w4sF+FnrB4XWlvBG?=
 =?us-ascii?Q?P4p9eYbofwbrocv0ry1r0KH50Y33ra9UFsRXq5+jYWABYvf0mrwuvruY/fI9?=
 =?us-ascii?Q?vKMo+0kfjywxg1wa9GHWkW4xxJK8pC/RkmDw1eJdzacwaxDLYAHoi3fIAp50?=
 =?us-ascii?Q?OMowWtXGo1S1Uw9LnoOPwolfeOCwRP5Cb738xjjOGyeimJQjkdryUOzikwpF?=
 =?us-ascii?Q?E4c33OC9/vqjUuiEBDErJyZDCi03D4j9uJ8JIemqW8MBXczf8eHNJYNzBt9i?=
 =?us-ascii?Q?THiVuvb3q+MS1reVlmMb9Qzaij2mwgM3ESJIji3SKdjnZfS+jPpC1A8W+0L2?=
 =?us-ascii?Q?A1cPxkUDBEp/RtcFdosvHEm24N5OdYS9Utg0rBuJfdtK3ReUG1JvgE3Jzdhz?=
 =?us-ascii?Q?8Dg/a2Vru4M90tkfEIOL+bAVIj3OVO7sFwyk47cC6OuaLvdpcX9tcKbFyjPb?=
 =?us-ascii?Q?NN9ZGOfzq5ZDlK2bu6vZ8VpLt4kQu49FHi6RfUNaoFznJtkc5NVbcnEKQ9c8?=
 =?us-ascii?Q?BCe9Yh1mtTwS+UOYnSpVkWywlYmXDzXEnZXCy2A6OcEOx1thpbxIRjhprCDc?=
 =?us-ascii?Q?kxq6EYIZX5q6SjLaOKsuPNK5y258J6TEXtIP0HZLFjogzhIURuz6Pu+h08tA?=
 =?us-ascii?Q?tRLNosqMpmUoBgHRC3MydVYDxy9jqi+K8KXwBNkCO9eo7pzF03K4QVOpwE+U?=
 =?us-ascii?Q?r2W7lXZ9mNULGz8t0/RQbMN2GOhRaE5IJDMeW7eC2S+TzzOfyEx0l/HWZHlV?=
 =?us-ascii?Q?1Kn/I79PtIqRaXZPwylyaJjUwgejswzAXYzblcsLHr0RRMQ+lWwKTfjr9Qw2?=
 =?us-ascii?Q?TVfcbTsM26JZ7+f1PkRPc/3i7US3i7EsEvt//WWdZzV4SG8Qv5H9teyDLyz7?=
 =?us-ascii?Q?ldTCvIlxQmnbfTlVEFz3LV85OcFii+8fAvW/g1m/mxm1LJRI0l4T61soluhv?=
 =?us-ascii?Q?vgxwnOU9Cspjwr2FZu23Rd5Vax+l7w4ByamTN62pMM8gH2x7w6JTf4FHYiSW?=
 =?us-ascii?Q?4jGgoN53Cu+ioJe19YKmqyDzumfEuMHr+MI57vbQL31jlXEcvaWQ2rr8h9Y6?=
 =?us-ascii?Q?XezIdflcVQIXwQfBt+Zzztj7wOHlhDDXmYGFI8Gnmvn5hPt0QlXaehdJdyqJ?=
 =?us-ascii?Q?osfB89qRcoatC5RjNE1PNXzo4PoAR6ORvU8GfO6AEe1b2KohGkkYfQNa0B1l?=
 =?us-ascii?Q?SnKNTQr8eCSeYqK6zyGU12BjWKIjQ43O+sI1?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 19:14:09.5340
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02b0db7b-ca68-48ca-d0f2-08ddc3d3c6cd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6088

On Tue, Jul 15, 2025 at 02:32:45PM +0800, Xu Yilun wrote:
> Rename the shortterm-related identifiers to wait-related.
> 
> The usage of shortterm_users refcount is now beyond its name.  It is
> also used for references which live longer than an ioctl execution.
> E.g. vdev holds idev's shortterm_users refcount on vdev allocation,
> releases it during idev's pre_destroy(). Rename the refcount as
> wait_cnt, since it is always used to sync the referencing & the
> destruction of the object by waiting for it to go to zero.
> 
> List all changed identifiers:
> 
>   iommufd_object::shortterm_users -> iommufd_object::wait_cnt
>   REMOVE_WAIT_SHORTTERM -> REMOVE_WAIT
>   iommufd_object_dec_wait_shortterm() -> iommufd_object_dec_wait()
>   zerod_shortterm -> zerod_wait_cnt
> 
> No functional change intended.
> 
> Suggested-by: Kevin Tian <kevin.tian@intel.com>
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
 
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
