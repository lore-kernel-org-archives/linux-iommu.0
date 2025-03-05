Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E9727452;
	Wed,  5 Mar 2025 17:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741196914; cv=fail; b=A4GQrcsxspJnwyddX40AlhDLojUGufobVPlOp/iaqh4cc1OSVlQ0iGVjiBskuBg0ZDcSdMztj0JG7VfdfdFU+9YumuEQlqOqlXBLfxgcW+PCDAHg0/M6JLIK+i5TJuqbu+sHbnBcMucIwc1JEqHZ1hxAUL2iW0G/+l7r8Z2f4+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741196914; c=relaxed/simple;
	bh=6IQWmfCUt2AXKtx96E+C2/x7UreywHJxW7i+fd/W/Oo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NfbjpKpIA7R7StvNgxYXDOuVfv7tbyvd3HhYvsI0Otyu44VU5AccprdYVu2XinQvshSJt9Bv9fCsL7MJr9ESosLYdrkiBdwKdpVFhDQI7AQ2iY7nobh3iTnwxHAbSzobbjqFOtO+UbleqUpm2HucfeowoTyD2/+To/92cAaZ9z4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ufUEqlMz; arc=fail smtp.client-ip=40.107.94.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ufUEqlMz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cw1qgAjaV6iUtQCOXObfklCyCraGKNRR8g+jeqXeMyt8/PcaaGkmHqPlI3oTADfXcNIjW/Irwz+02KQy4i1IkxNOCDlOUfHQHUXQM3r8Vp7O/13wL0dQAnsdxmbY54HMcqHETSy00tOTqzrLcKcuOLK3VH9ExPoTkKPDPz+3uwRxfjAjASjWxFJfeLxmUuyqNcUM3EYBNPSIWHZbagWBaMDwZpu3SKRP0pXU0QP1VMGnvppN+9ECC0bO464YxlSptGiBT+5grbRFWZ8jszmvwSGPkF0JImA8WHCI4kUkdfBZsi9mO4mxgn3LtiNQVKTPpoIzfQe1lq2/ujUtULwm+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VFkolJwb7UXVUaCki7EomyFqKxLYsISEINh0r4TA+Jg=;
 b=OPp3+epT03aI6R6N3HfJxzUUmE5D6I0dLK94PljRUF+aCi5bjwo69+z3NlqUurTjPj9vQ9PnqE/90P8Y0CH99VXn6A7Aa+gPxLmUt4xTPjQzbnU9g9SZCpxFyeLeSG7cgShlTK6QWb4xNefVfbF7lyvos6V/TH1oCQXzX8NPv1ii7hbJBC2T3H8tEudFjE61MRfHjxH/rxvbp04yj26Qg4oc4TelWio88ywYbNpyy1UBQ94TCqtzretHLAHUs14Bd30lhA7hTrLgbCJ9KO18IyPUivJne9FAC8IM8m2ii5wAxXysJrOOgJIqAs0FA6JQZ765PraWe/+UM/uYItMpGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VFkolJwb7UXVUaCki7EomyFqKxLYsISEINh0r4TA+Jg=;
 b=ufUEqlMzrakgE9pZ2xEPolj3M4MPyzM+6a2OozePIdqmNCAfoK891R5Ob+iIpglMlYVzqBKUYlVwqr04pMuKQGJc0eXUzBoG7ULCk6eTfvVgzoRETf4uxjnk+S7AeE9OMWpN5eqP2eHw9SBLOumBJs6z2+UgtZZ+F3l1EdJFNFakHRVkC5WcBeEaW9okojD42d61OWdNJ0ZUPzfQLyPM9clMIMbT1F/OcDqcaGe3S/rvLQsxiM/3nb5vJMS7OHtdGVCZ0ucI7P2dFws6Z5FNuj0TylhiKChHbjgRK7mlBXR5HJZSWp/2QkEWDl+fhFiFrMbmwn8/5gby9hHrNCbLvA==
Received: from SA1P222CA0131.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c2::12)
 by IA1PR12MB8519.namprd12.prod.outlook.com (2603:10b6:208:44c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Wed, 5 Mar
 2025 17:48:28 +0000
Received: from SA2PEPF000015C8.namprd03.prod.outlook.com
 (2603:10b6:806:3c2:cafe::9b) by SA1P222CA0131.outlook.office365.com
 (2603:10b6:806:3c2::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.16 via Frontend Transport; Wed,
 5 Mar 2025 17:48:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF000015C8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 17:48:27 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 5 Mar 2025
 09:48:11 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 5 Mar
 2025 09:48:10 -0800
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 5 Mar 2025 09:48:10 -0800
Date: Wed, 5 Mar 2025 09:48:08 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Robin Murphy <robin.murphy@arm.com>
CC: kernel test robot <lkp@intel.com>, <jgg@nvidia.com>,
	<kevin.tian@intel.com>, <joro@8bytes.org>, <will@kernel.org>,
	<oe-kbuild-all@lists.linux.dev>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] iommu: Sort out domain user data
Message-ID: <Z8iOWB1vH+bBMPWo@Asurada-Nvidia>
References: <74a3bf91b52563faaf7ef7de065931e4df47e63f.1741034886.git.nicolinc@nvidia.com>
 <202503052255.t1N6KrAn-lkp@intel.com>
 <3699641b-c7bc-4fec-b8e2-828f5b1f2d70@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3699641b-c7bc-4fec-b8e2-828f5b1f2d70@arm.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C8:EE_|IA1PR12MB8519:EE_
X-MS-Office365-Filtering-Correlation-Id: 565b1a7b-3d45-4fe5-0353-08dd5c0def5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7t5Nr48OD31ZOFtZac+ALIIgFj0jKjdqMd79Vg7+NMwDAMVWJMa2AqENbvfC?=
 =?us-ascii?Q?MPbJMP7UybugQb5lIWMdCzOC0t7E4mVkWFHgwZ6NXFg21ojIpKOSCSDaSULJ?=
 =?us-ascii?Q?ya5G7l0mbuCOqgZ33zql8z2G8sfNSENfrQ9apynDrMqWt+rQ5giNIEfe24Is?=
 =?us-ascii?Q?0c9kINSNutDWDYAenopASSaKHmWkdutLveGqMl+rU40iBlcgTd+Frwr+wOSq?=
 =?us-ascii?Q?aBDogIO164g7K13NrYIGL4uRshuSiA28Xae73Lpx6gWfo9RjSP7MNE0auBn1?=
 =?us-ascii?Q?bLEc9ZEZY5EchtijhP0JXzBLY5tUBvkPW60xgxWBOaKTfkeK6T9sDVrqGGUi?=
 =?us-ascii?Q?emqfxAAGFLnEtX/OaftAKzSifTcBePLpq+7oIyeIsN9Cak5At5xm283eO9ic?=
 =?us-ascii?Q?7u0hredymaHimZHM7J9bNtUf+TPGEb1qkVK9KsUgHXhFptxsrO0pyDk4v8DD?=
 =?us-ascii?Q?XJf1zH9roCP0qjR5GyGrNNfdg+arw72QkRQu6Q5X3axBQqkNE02EbjXmpk7C?=
 =?us-ascii?Q?GrWTYxK2MIhMnq5kZhcDjRSnzzU6lQyNyKJYZbC3+tRhLvZOPCkYX4m0y0/s?=
 =?us-ascii?Q?6O1RZ6tHvo3+XwFZJCKS4M9mSakRImVKTfBMcXTx0GFHNPXOZsgmwH+ebE2c?=
 =?us-ascii?Q?gmBUd7JUq3ARPM0VQndMadd8H3BTBLsS5vJv1vgh1ltB9vCp0uc8M6M6Cx4P?=
 =?us-ascii?Q?oZGEweW4NPNiMKjlcY1VoGrZcisQmXYLRI9RhwZaSoH2dQDxJRcpCQh6L3fW?=
 =?us-ascii?Q?Zsq0vS1p2hSsB8BNfFWAcR31/VJ/qK9BxQpKNVnk2gfnptka/rpvwDVjBh22?=
 =?us-ascii?Q?MVshTwhh9mm83Hy0655lbegK126eaRfOkjig0nEyXincYOERiOQ1RWvnn25H?=
 =?us-ascii?Q?JClC7notXpkw15CQt3WcKKliDDOaWNj120oWCnIijjsG1ztGzuHm4EiPgQB2?=
 =?us-ascii?Q?7e1onRzP4jUs2fEcYZ1RFgHPxCid2bHUKkV+H0uCmFJb5krlEYTyY7Bwdodj?=
 =?us-ascii?Q?FvK9jGKUiaH08MCSY8OM/181JgRCyYnj0NBBA4IwCBzYXETboEGnvB2Kk5C4?=
 =?us-ascii?Q?JaH6EyZB6jlmRbNdmsiH3uw7cZIYHGCJydKAdibFeKa76y/atNjo5eA2Mx7j?=
 =?us-ascii?Q?erkXy0Gk14weSAcGD3Bd2fCxQLrjYfGlWpdN3q7oz9kLzxkuuOC2KW7Ve5Fd?=
 =?us-ascii?Q?r64Y6uGNi5TN7eZDsxPcvcLrw68bUMVXJ51XQt+/Xp/uXsCsclgIDiQvFyfl?=
 =?us-ascii?Q?wdyxzHriAb2tK1c0lxqCDCNgM4/BDVKUjTmKTH1jrD8b0jOkjZZvFUgN/2gL?=
 =?us-ascii?Q?52W+Letts9FLsLIexyMsaT/akLQF2utOrFuQZDzZKKs9P4FuFfi2USqVQkgs?=
 =?us-ascii?Q?TjF8Y64Po67msn4NYr6wdFoKI16+PZEBVdmXicdGrB23GeqezzJWmoF6kv2/?=
 =?us-ascii?Q?J12yFZvCiokkiDB6sSzv9dAqzcKMUaKO4wnTF8ordUb7Iw8fcHbJbnpAnDJ1?=
 =?us-ascii?Q?p/LGmmyRvkwkrlE=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 17:48:27.5277
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 565b1a7b-3d45-4fe5-0353-08dd5c0def5b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8519

On Wed, Mar 05, 2025 at 03:45:21PM +0000, Robin Murphy wrote:
> > All errors (new ones prefixed by >>):
> > 
> > > > drivers/iommu/iommu.c:2039:10: error: label at end of compound statement: expected statement
> >             default:
> >                     ^
> >                      ;
> >     1 error generated.
> 
> Oops, my bad... omitting an extra break here was a semi-conscious brainfart.
> Weird that my AArch64 GCC doesn't complain about this construct though, even
> with "-ansi -Wall" - I have to go all the way to -Wpedantic before it
> notices :/

Mine doesn't complain about this either.

I will add a break and respin.

Thanks
Nicolin
