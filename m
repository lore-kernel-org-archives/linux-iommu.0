Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012051.outbound.protection.outlook.com [40.107.209.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230CB3FFD
	for <iommu@lists.linux.dev>; Tue, 16 Dec 2025 19:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765912520; cv=fail; b=NWAKNZC3tuqJ48ups6xsLlWYBuxhrHcd+jqeHLlmcWN5sPv1NDLo4LvhBDNVDcfMl4yF+WJtnw4z48BpcRP+/aSMb9axgd7cfW10FiCbAa6bez6yYugizilsxRDP0omccJk6ALZhNAj1Kn30MPkK1V+he7gSeouTh/eTmP5RVss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765912520; c=relaxed/simple;
	bh=HwQ5A4big8N2iR7ZTfdGdM7SZPn8rcWg4a1l9YpJCkQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ILXWdnZnKR1aVNSvIKGIy3ATwHu2FHwXdJZMSBIQM/y1CXEgBchKsKxUJ3wX+1weQtUaYy0rpdlYIOTQXsTmnpPB+d9bxR1yKv+D7SFwT758M5tKV/AZQRQuBEjI5K+AW1lq6D+B5+tLgc8pwosFVRIuIYnrfzXeohCStycStXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Y22ISPy+; arc=fail smtp.client-ip=40.107.209.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Y22ISPy+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vRy8QErEBMlX4zaqumyMNeZqr+XJ3vKNlXHAEvsFA97q7ItP+mHI8lp13aM6+Yts1FL2I6pVdQPRxrjDLaCXVXMWAryuzEaOttYm4hPFfQeOSVBl8vZDmgNhnDHnqLgShYiD6pI25BYqMtbIgOqYb3pKAWeEZju8zmSssoQMy5B1VmbpzQg3cnanTRwBEYUQcnZJwb5g+4bN0+PgwAzloUa72HT2KSz2f7nuA0bMEO6HP/TLPmQFZDxfgoFsstlDLhS2JT86vYY9vbm/0m0T7LaebDT7ZDmivTV50uAyUQMcT0ittsXfufsHMMVRIFDq2UGc2Yt8w0T+dNfjJt+JUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UlLRO1MFpB3tGHbPpuN3jHextC3d85g5cPKcwWDJ+lg=;
 b=rCKsxyaytdtGTZ9+yMVrWzte7eVN+LTacFIg+IIiHwf2ESTHfYsnGuuLTQYwrfQZxwimEP5hP1BFDt8mJoO09E95W7wGgwUNGNvwpY3RVW75s72UOAnVVXLPHCX+6tX0FyQNR2/haNEHC3mvJ+6nh14SuVtIAZD8NiiVFH/Y+WXelUtPb0Fqgw0d3Il71bMSwSbUZ3r9au1FPQv1GJVTEKwe7rNJklqdsE5/BS+N3dZP+hfSfchex2/K4ks0zxTcfEztwsjeGC2baor7uBAa6UxliB+Mo6nvkehuT/vts6KoFUSyqzQWUitjrPeCk30nAHaOngqsCZtdhfVyxuix/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=infradead.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UlLRO1MFpB3tGHbPpuN3jHextC3d85g5cPKcwWDJ+lg=;
 b=Y22ISPy+iF5Wri6vkjCm0cXasGKOgOLfaoDWHPlrRcvAZGJ7konHPFVUVByGRKf5nGfNygOeueFedN5P7WKUZy3Gc2Ch0O8vIHKJZ1SHcIi11nC/HiwF1J8dLyq2m5Vrt6Ur9IErW3PX4zjSsl0pzRXMHt36SwMKfZmIyZfNNmm84tcM38fvBwpZYN3cGJBYZGT5B+E6XdBcwJGwFlVYAgVl6Q54x5IxhfntbWEPp1E6C9b30n0f3Ds/t1dhusSXTpBc/SuyOkEa/DnDK/VORx9tXnSNg/Qm7PWuK9Vi2avkRnyhqPEe2MgpVybzVOFRshQnpTsEjeXD0RtO+AjDkw==
Received: from SJ0PR05CA0209.namprd05.prod.outlook.com (2603:10b6:a03:330::34)
 by CH1PPF84B7B0C96.namprd12.prod.outlook.com (2603:10b6:61f:fc00::618) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Tue, 16 Dec
 2025 19:15:08 +0000
Received: from SJ1PEPF00001CDE.namprd05.prod.outlook.com
 (2603:10b6:a03:330:cafe::34) by SJ0PR05CA0209.outlook.office365.com
 (2603:10b6:a03:330::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Tue,
 16 Dec 2025 19:15:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00001CDE.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Tue, 16 Dec 2025 19:15:07 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 16 Dec
 2025 11:14:45 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 16 Dec
 2025 11:14:45 -0800
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 16 Dec 2025 11:14:44 -0800
Date: Tue, 16 Dec 2025 11:14:42 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Peter Zijlstra <peterz@infradead.org>, <will@kernel.org>,
	<jean-philippe@linaro.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<balbirs@nvidia.com>, <miko.lenczewski@arm.com>, <kevin.tian@intel.com>,
	<praan@google.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 6/7] iommu/arm-smmu-v3: Add arm_smmu_invs based
 arm_smmu_domain_inv_range()
Message-ID: <aUGvojnCaMKWM6QG@Asurada-Nvidia>
References: <cover.1765850465.git.nicolinc@nvidia.com>
 <f4261c5b30ce3c6942470433033d4933ec5eef3e.1765850465.git.nicolinc@nvidia.com>
 <20251216090926.GR3707837@noisy.programming.kicks-ass.net>
 <20251216135613.GB6079@nvidia.com>
 <20251216140410.GV3707837@noisy.programming.kicks-ass.net>
 <20251216141511.GD6079@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251216141511.GD6079@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDE:EE_|CH1PPF84B7B0C96:EE_
X-MS-Office365-Filtering-Correlation-Id: 218e48be-8509-48d3-7f35-08de3cd76d14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|7416014|1800799024|3613699012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nypnc31UWTyqIhpv6lrDnL1iDdBHEmkEvg0V6rvV27mAPL3C2R+08h6PL/zK?=
 =?us-ascii?Q?WzgCa4kvJY5kXldQJ4sEf4ABhTOwq+xHDMynlQGjezFiT5uSDo6NV+ligVts?=
 =?us-ascii?Q?cxRjEKYUzps0w5DQJU1msC5lt2Ss+USJmdd9fvuRMe3beaKIJAdQoKk6pzJ3?=
 =?us-ascii?Q?Mw+x0eQ8Rse3tsnEhrDuZxe1YRAH3G+tuqzF58Q+SKp7qiU9zwPkWbHTZ1HA?=
 =?us-ascii?Q?rU36Z5JwNzpaYgZHJLzIEGBiDD2fMpcDNjeJiKYP9b8usnBxXgWCPDoazw/K?=
 =?us-ascii?Q?r6S8XJoA0ilLdx9bUJNQN2ug4QDJdlq9QODKHFy+yelOLKSXhaHPCG0+uQSt?=
 =?us-ascii?Q?dvnn1r81p/gMZ9zX1TsoATZGgjxz49WF/0GNlVi2JTZGQD8wBg1H1D+qdqHa?=
 =?us-ascii?Q?x73KxKlpeVsNhk//Udq9vCnKZg5IpdlDmb/17cAttiVLRBqINPKfX7iEM+Bt?=
 =?us-ascii?Q?vBkGD3/AT173hpSsfD3ZZWdV2oqpGgMbNhUkbEwlcffjJxSLArFun4ldFy4E?=
 =?us-ascii?Q?WNzrOEsL32zxwWuA2s8tC27rxXGNz+34RqJ/Hj9cQ7dAn2i58hR0JfjYiLfA?=
 =?us-ascii?Q?WUXfKBoCbSwHRZNgfvCdEMLcTVfEkutU7pMYWh4vYaQUCCAESHk2gylxWhYZ?=
 =?us-ascii?Q?uflMGqGCNru+mPUbM7ErV3dzCIxJVmppIOhknC/tbFojCxfosFjAOvclvIXb?=
 =?us-ascii?Q?umWPD2577a7nTGDcw0BH1gM8cVEr9vAaUVobsPlDvaoOv9sZmio+vohZ2iWk?=
 =?us-ascii?Q?KzaevW0xIAqcPrftUIche3VUniUplgardiuopTKA/G6Gcxkbpx/nNS8FsNLu?=
 =?us-ascii?Q?XKNMcEEk6REtWKIQw63/qHYBGXLQE+LS/aXEk1/eduRjJzzfK5DT0b6xgCnV?=
 =?us-ascii?Q?WqVaVw1+Y9a9cn7rHGvxUKudp70RhveCrcUDYz6YeT+Hskz7NxlInZBvNQcf?=
 =?us-ascii?Q?h2dFTAaxa7KEI9O0QGbu6QgS14aRHQlIbjEq79nrjoEUmORqCkfHytItls72?=
 =?us-ascii?Q?WOJ1mmI2lWuLxXJgZRTBW6cwAdBRkHQivUhFtRr3CFf9rCDMf5FVtVhFKVwq?=
 =?us-ascii?Q?TUl3+/l6QDl/OfrTaaYqI46IZQyMF3Fa4dQRZsoPj9tlvSIBWkNKqqBFopND?=
 =?us-ascii?Q?1SRZI0MsRn2sbdpCPQVOOHPokPlkdzBW9cjtDtOoA5rd60G65L6NnkZZQCWV?=
 =?us-ascii?Q?0aXi/S+rcCZFP2inDv6Z95f0HUWEl/mhPpoYBc+tGICeFaaVBbqtBNx8OFCc?=
 =?us-ascii?Q?6HZjHGCirXvx3+kJcol+eez4qvG32i+Jfr2keg1lmNLDo2GJHl32Omp2B0zk?=
 =?us-ascii?Q?RAgayOZDl2L2hIZHLZ3Hg/x6GKMfkPI0RCwefRwiM0mU7MVXHpXJLSMeoqX3?=
 =?us-ascii?Q?oPg/e7EYpa7ZfkAjtzaI2Z8c4v4Ls+v4TsEvx2pmfhThGZXsyTTF8VX2SI0Z?=
 =?us-ascii?Q?24OrUeblL0KvGgTEJWvLYQcNDJfe/mdZiT5ikq5DHJwbdsI3/nzy8SODUPu8?=
 =?us-ascii?Q?NOlioxbCTR0Gg2KM3falXPoaVvCwjLcQ0s7zaLvyJpPNFSroGNkR6kZ9TrzO?=
 =?us-ascii?Q?653meLNY6gpCrUGciF3abkPvfH/r9J8sHby4uZE5?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(7416014)(1800799024)(3613699012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 19:15:07.7568
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 218e48be-8509-48d3-7f35-08de3cd76d14
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF84B7B0C96

On Tue, Dec 16, 2025 at 10:15:11AM -0400, Jason Gunthorpe wrote:
> This also has a pre-existing dma_wmb(), a fuller chart would be like this:
> 
>    arm_smmu_domain_inv_range() 		arm_smmu_install_new_domain_invs()
>  
>      [W] IOPTE				  [Wrel] smmu_domain->invs
>      smp_mb()				  smp_mb()  <--- arm_smmu_install_new_domain_invs()
> 					  [build the STE]
> 					  [post the STE]
> 					  dma_wmb() <--- arm_smmu_cmdq_issue_cmdlist()
>                                           Doorbell Write to Device
>      [Lacq] smmu_domain->invs		  [L] IOPTE via DMA
> 
> Nicolin, please elabortate more of these details in the comment.

Ack. I will add the chart above.

Thanks
Nicolin
