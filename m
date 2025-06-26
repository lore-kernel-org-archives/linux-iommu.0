Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF072727F1
	for <iommu@lists.linux.dev>; Thu, 26 Jun 2025 10:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750935535; cv=fail; b=cgrvtqs0UaPN+vhOKcP7agUKMxPQMpqXbHKG+YCoLlEHzpBHOi0LOLAY7sdWg9BSdsbsHDfO8Xa4zY7c0uGn6QS40PFQEgabCiDMH0GMJE8p9+ApJWgEtwyzQLMqsz9/C5ULi1oiziFRWoWCKGl/Vba5riIwtbcSTiw8MiBk1Gc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750935535; c=relaxed/simple;
	bh=gbCRHBaGhyLS+7EXq5O1NFe8dUP3D4Ix+F1Ni+kXpSU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PMetMo2DIrbUUxxyjAxPB+Gdpb00y+KaH9iYSFWK8Ulle9GNzl+Mz7zG4z/icDj9djbK1UosbJt9wkzvoecHBE9vNWepFm1TwAOm/CbqOVc8OVbEVzjZA+ytzceBQ0gimnRVKf7M08etsn30iCGRRIxg08vWMmgOhmKA/uHokZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vn/ykvgq; arc=fail smtp.client-ip=40.107.243.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vn/ykvgq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JVar0sEGMvcsSjdxhppRXJL5EKZiGJVbvp8BqlLX1Ys9YZyrXb/XacCQjs9ag8klQ5THA589kKLeSb30BwU+o99wsSvzNPv45aivIWqzEotNcudm/BcC1zkHq8Ntmeq2JTBoaEtZ0Wj7wncdFCdDHV9vxy/6ub6gXNuyTf2ECItt3ee82EP3blSoPC/tns04Qv8LxfiwQuej+X/ffF01wGdxp62NxJ9fvDAmraYCFCpIf41vH8uh4yXH19s+EwcpQsFYyzLTivwfDaiben3YjOEsojh9uSkE6tokT95WsK0rQs3B2qAxJE0TsNUfGW3WODRS1RCRUSX1wRw4X63fIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B5AJ7oo/3MgFOS1bM1RlnIKJa9RVe6K+n33kpJDqj7w=;
 b=roARo55XzPKrLCHuuGJ3jN+zGSfBXKiidCLBFrGVf/gR218z+jvfC4YTbloGD5FuXEJkcK/l4zVrYJ4cMjoqkMNBnyhK9f8mYFctKJY2ePdJSXqLc61RVkkSuakZhztIHM/C6OGKsPl9te0TWrGVlOIqcy7Qr4xbIDPW6efiYeBtMeQLGwYo1/xl8O6TyoPR+0+0q03H3fUxQRtkmzger/5btY4y3miKMXec7LQcmcqf+rOHxkfrdPx2QF3Doy3HYW4UOq0/lSJfIuZSQZg8NEDcWGsq8gLve5+R+iXKPkmcBoMmXnx8CrIVGtNNJwUBUfAERixrD0BLsKELIsPACw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B5AJ7oo/3MgFOS1bM1RlnIKJa9RVe6K+n33kpJDqj7w=;
 b=vn/ykvgqNK3qQh3Jq3OQjymD5//wUKB6LG3OWoB/fjhRzLUfeAvO4ncN0ODSC2o1lN1VAg7IU1IlFxoVlyg9hf2mNtn4l4I/VqXQYPtchlG8jkavyFGnQyU4vquzSf0mwHvNkdhn5tY9cbkcbuHjgcsmDXBokHqTvpECqniI9Tg=
Received: from MN2PR05CA0006.namprd05.prod.outlook.com (2603:10b6:208:c0::19)
 by DS7PR12MB5909.namprd12.prod.outlook.com (2603:10b6:8:7a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Thu, 26 Jun
 2025 10:58:49 +0000
Received: from BL6PEPF00022572.namprd02.prod.outlook.com
 (2603:10b6:208:c0:cafe::c1) by MN2PR05CA0006.outlook.office365.com
 (2603:10b6:208:c0::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.6 via Frontend Transport; Thu,
 26 Jun 2025 10:58:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022572.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Thu, 26 Jun 2025 10:58:49 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 26 Jun
 2025 05:58:49 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 26 Jun
 2025 05:58:48 -0500
Received: from amd.com (10.180.168.240) by SATLEXMB03.amd.com (10.181.40.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 26 Jun 2025 05:58:46 -0500
Date: Thu, 26 Jun 2025 10:58:42 +0000
From: Ankit Soni <Ankit.Soni@amd.com>
To: <iommu@lists.linux.dev>
CC: <vasant.hegde@amd.com>, <joao.m.martins@oracle.com>,
	<suravee.suthikulpanit@amd.com>, <joro@8bytes.org>, <will@kernel.org>,
	<robin.murphy@arm.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 0/2] iommu/amd: Support for HATdis and HATS features
Message-ID: <tp3etuslicpk272nunywuklvkivkjyg5sx54o2n27jhngyykx3@mkj3rwgkfc2i>
References: <cover.1749016436.git.Ankit.Soni@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1749016436.git.Ankit.Soni@amd.com>
Received-SPF: None (SATLEXMB05.amd.com: Ankit.Soni@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022572:EE_|DS7PR12MB5909:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f057a2c-733d-4d0e-08c8-08ddb4a06e76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WPqXaRfdBBnd7r1/Uvok5wj19d5o5MP9FZJBCp64IyOfa2J5vJc19rLGiygU?=
 =?us-ascii?Q?IAbXxfs+6fNR/tbQ6Q9I7EL3eNtih0Wgezkm2qA9psTspK+ts+nwdy/ppYNE?=
 =?us-ascii?Q?uegr88KkG1x+XwRObEG5u1LIGM7D4KiRtf0uz561Zs8+e7ZJBHC2qi4tmDlp?=
 =?us-ascii?Q?165iEVNwmn1CPOXksEDNL7hwsx91KkmyuEn70pZE0WJAiAZAMFe+nwa3ShN+?=
 =?us-ascii?Q?xqTgIvUkJ8eiTKqNR+QHAqNq80ZMQKl8ZE29nra++qlRqEcX2sg/CMjdvK2n?=
 =?us-ascii?Q?MT75qiHMTRJFpP6o4K9R6MHIaFmPtwDP+zGyzGxwFVED4w9kqiQwJxKFSEap?=
 =?us-ascii?Q?hSGc/TKBcTjE3jK3ib0LZvxNusYu/SSOzmBR6Mfv6sqtCvwNkRSMK9pd26uG?=
 =?us-ascii?Q?uuU8ai2t4LjEmmTZ4nnNWZIzgQLC0VVQ7m6gOGsfWUwmz1B09aPrZ9KefM8X?=
 =?us-ascii?Q?8ACyLmHlpxv1RxNEhFU4IJyVSSZIaSAdNqOWbv0QO0pEBhsE2Ayvi1Bij/zd?=
 =?us-ascii?Q?3Ce+aPxd9pND4pjTZNK6M20fFNV7gHKCBzxCnuzDw9AXY7pD1P0s65drUGpQ?=
 =?us-ascii?Q?Y4ciJoStCoRbjCtatjhaHPi4yxyfBqwuygEER6cY/hQ3bIzT2pBNroj1hWhq?=
 =?us-ascii?Q?e6UfOASJPxPkgQ5TdtR3NbDCwTx5Ig0qp/XAtfm2ZocigWmCl2tsYxL5X/1M?=
 =?us-ascii?Q?rqi2ryM5KaB2x90xcWJnsS80G3mralYmvk/3tCAEz8W+sz22v+EAeJnK0b2s?=
 =?us-ascii?Q?DeO1QyjI+rDiK/0CBX/5AE3lqJ0zfS0MhjOi+gA3Pz3MWNd0jnYJBwXjtAt+?=
 =?us-ascii?Q?MEQfl2nE2sRONQ9V3Kh5JEyFYipQLIw2RJlnnXWd7FM5YXEaprnmNt7q6STB?=
 =?us-ascii?Q?zODUW6tmRXfiUZWEjVEmwvvO4cyKSmTJm+iwvbZ4DAs1++8SC9nToJqkwBMD?=
 =?us-ascii?Q?m7IrA8vJ/FO7Fdw4eR5fycsbDq7FO08Tqy4+tIZ2+eJ0tjLYsAu2LhCABCIU?=
 =?us-ascii?Q?Tx48GATSu0q+pvze+yMe+pD2KWDH8SxN6q0nYoS6lGIfLWwydDKjYA8jvYux?=
 =?us-ascii?Q?L+a4s7F7QSXHghsA9KrI0RG8DzQG9gmUR/nvGtF9aCME/98y2kGj1LbxmqWI?=
 =?us-ascii?Q?gpVuopWcXCqxfP/n8f+oyBcuMfoY5rwl3XUXOXpyVEw8GS0n8/f9DcmVb+bm?=
 =?us-ascii?Q?Z1mE/ecrNEe+7T38D18mPngUnAcP+H6kc5pEZSb6xUGtSL1pnMu4iAnUi3Zz?=
 =?us-ascii?Q?HQifGp+aLgxuQ26IrcWwBJma68uu39CuOa9aAm2cBcoymGkYe3QwhMKEOzNQ?=
 =?us-ascii?Q?Lfg+6etnAdDXZuxVWbFCuJuMW6ZEtIZ/7qeIrw0Vlm6Memj08e8j8eXpjatN?=
 =?us-ascii?Q?JWHCjluW7sZRMTjF/Uu0YFj9ccmxjzGZDyMZu15NTvYPuW2fMNU5C4oD2lhZ?=
 =?us-ascii?Q?Cf+USvsjZVRmiURwOuk7c69muQKu4uVRdRAR4YxnS2lnqe7dVDFcnCBSe25w?=
 =?us-ascii?Q?N/sPzE6lZU+LD2lyj4k6sXcPlFHVzcxXnowc?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 10:58:49.7033
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f057a2c-733d-4d0e-08c8-08ddb4a06e76
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022572.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5909

On Wed, Jun 04, 2025 at 06:13:23AM +0000, Ankit Soni wrote:
> This series comprises two features:
> 
> HATDis: When host address translation is not supported by the IOMMU,
> the IVHD->attr[HATDis] bit is set. For instance, QEMU emulated vIOMMU
> does not support dma tranlation for VFIO passthrough device.
> Support has been added to check this bit and switch to guest page table 
> mode, if supported. This feature is useful for cases where only interrupt
> remapping is required.
> 
> EFR[HATS]: These bits indicate the maximum level supported for host page table
> by the IOMMU. Modifications have been made to adjust the maximum host page table
> level, starting with level 4. If these bits are set to 11b, the driver will
> attempt to use the guest page table.
> 
> If guest page table mode is not supported, the driver will fail to probe
> devices for DMA translations.
> The interrupt remapping will continue to be supported.
> 
> ---
> v4:
> - Relocate sysfs PD_MODE_NONE check case after iommu_device_register()
>   along with return check.
> v3:
> - Add check before populating sysfs entries for iommu groups.
> v2:
> - Addressed comments from Vasant:
> 	- Added/Modified comments and logs.
> 	- Removed v1 page table assignment hunk.
> 
> Ankit Soni (2):
>   iommu/amd: Add HATDis feature support
>   iommu/amd: Add efr[HATS] max v1 page table level
> 
>  drivers/iommu/amd/amd_iommu.h       |  2 ++
>  drivers/iommu/amd/amd_iommu_types.h |  7 ++++-
>  drivers/iommu/amd/init.c            | 47 +++++++++++++++++++++++++++--
>  drivers/iommu/amd/io_pgtable.c      |  4 +--
>  drivers/iommu/amd/iommu.c           | 15 ++++++++-
>  5 files changed, 69 insertions(+), 6 deletions(-)
> 
> -- 
> 2.43.0
> 

Gentle ping.
