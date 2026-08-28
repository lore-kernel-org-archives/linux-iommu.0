Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013058.outbound.protection.outlook.com [40.107.201.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8686F374A0C
	for <iommu@lists.linux.dev>; Fri, 28 Aug 2026 16:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787933063; cv=fail; b=auYvdrBm1OLyDor/aKGA2dgd2xtDZl7m39re0WAuC0os/YovBo+ImOqfMKum+zyHjR5fXGqU/cDSZcgBhciimMsf92Ym2qUS6ci5lzfQETeKSv4/7kTFIMN5I/8AxTqS3baG34cBT2hisduHuTBJw7uIY6i65JnS31Sm1kgNlzQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787933063; c=relaxed/simple;
	bh=MkEV08zH0MgXVnFGiz+YwDFRYH8Cl0OLLtwN0+9CNuA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fnq0MzBEAaI+EnahtGhvyru6AT56jaKFI3bIQY46WmuyvXj7+iE9BcIXVq9BfEPtr37WPbLNcbWiMXLcZIzgVUe9780O8RmSu7fZJm3xd0fW7sDpo34TDu7a9GcPg/l2rGwrljCIdFy11tK3Z31BquZGYb7QhrSJX9v6AUdb6Nw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bT182xNK; arc=fail smtp.client-ip=40.107.201.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bT182xNK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dUKBbOdo5zndIIw708nsQjgET391WYCMh87qP8AN6ArKYlzsUzf9vFowtoqwMSN/8IeBqC3B3Csl/IMRmCNvCWQMQgnhwqj7/7n4Iq5b4na4SaLJBgsS5RjJAf3tbOZTWgQbNkSPEK258WrcDjoDx2nFOX81wujtLWm7PtT9WOPRFZfe++DPdfF1ScmYvnptFx/QMYjiki0Y5k9nJ7E9E15Jpre3P4CIfoIXSdbW4JILbLvS0m5rovJ1fZFoG9LxRXQgeWuCgCSiVQn1WLky3t9S+ipKOX3kBWFhugCrkPXGOM+Cr0fASyIPB/cCqtSbTMXk8phoIRf+dp78qp6uDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xzm/MosNAtdpu/UGG/iqI18PrQx1edIr6waWOOpwkXU=;
 b=RBmjTJ5JWyE+P230W7wEzfJuHxZDTHSi66KLPVLa1+1266GutsB/rBlIol0FgBa3Fjdi6xnKIsmHK+j/vCeOyMKM3DKllQXpIAHZG4rSW+hi0L7HJKkBn3NvDsFQ4EvCkXVfC1ENF3d9i3ZCR/FkEADqa1Yj65C4Y//l4fFWpOOg9/sfZVFJXl38LB4mtB6PjASgh+A23a4Z+LH07XC9bOCQ34DKOXOMejGJ5/6uPrsX5qT+tL20BDWC3/hWA54KGD+tuYQu8u7+V7z6iq4BFHFJpqCMBbR0b5zMSyovZSVp+RXCEDx2X7GQALoH+TqiKl5LnTdkmfbtoSh+4BmVPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xzm/MosNAtdpu/UGG/iqI18PrQx1edIr6waWOOpwkXU=;
 b=bT182xNK0CNLYg4LpOZ8dqM0edeyiphFW585Xm2VTNgViwWh6AfV7E5+Dj6GuhlfJz5C93MOACtadB+vimTjA4RviGVABJbrtuFdepGE9Ulpjlm+gclesRvyxrVECHb1lthunKkRXVFkcjCQ3gz0K2FWOd7SqJbjHagkRyxqucSMDEJFWogvR6oJBdhmfsyITNY/vO08QYpMKuO8PpMiW3vZHoRC0cfDxl4L8AXmSz65BLp6Qrq8UA7U5jjqsmQgfjVsUKNRgIJf9WTK2HR7WaNWGGW3kcI33SpsNbUg+02WJHQqHd7SIB9r/0C3SV/LT5Kog0YFsvcvEzUkYCNsGw==
Received: from BN9PR03CA0360.namprd03.prod.outlook.com (2603:10b6:408:f6::35)
 by PH0PR12MB7930.namprd12.prod.outlook.com (2603:10b6:510:283::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 16:04:10 +0000
Received: from BN2PEPF0000A893.namprd04.prod.outlook.com
 (2603:10b6:408:f6:cafe::34) by BN9PR03CA0360.outlook.office365.com
 (2603:10b6:408:f6::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.7 via Frontend Transport; Fri, 28
 Aug 2026 16:04:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF0000A893.mail.protection.outlook.com (10.167.248.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 28 Aug 2026 16:04:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 28 Aug
 2026 09:03:36 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 28 Aug
 2026 09:03:36 -0700
Received: from nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46 via Frontend
 Transport; Fri, 28 Aug 2026 09:03:35 -0700
Date: Fri, 28 Aug 2026 09:03:33 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Mostafa Saleh <smostafa@google.com>
CC: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <will@kernel.org>,
	<robin.murphy@arm.com>, <joro@8bytes.org>, <jgg@ziepe.ca>, <praan@google.com>
Subject: Re: [PATCH 1/7] iommu/arm-smmu-v3: Ensure L2 tables are visible
 before L1 ptrs
Message-ID: <apGxVTbjoyD2kD5G@nvidia.com>
References: <20260828125409.1921538-1-smostafa@google.com>
 <20260828125409.1921538-2-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260828125409.1921538-2-smostafa@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A893:EE_|PH0PR12MB7930:EE_
X-MS-Office365-Filtering-Correlation-Id: a2e2075a-35fe-4c05-28f1-08df051dfece
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|22082099003|18002099003|4143699003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	1aVk2wW+XZmoc+/fi/lq/hov+yISXfWGLFlMuT1dzTLbkOvpf7/TNBFFErY2hIAl7SHQtOQXvF8HuqicxWcomTiiWRwq1EdQGyxiTJKSParD1rhiglLvZ66TXvWjoPkc/G2bMs6FbEucq9dA4SKiRiASl8mOIMBen4UUnHj10lj4QoXKNd2Y6jgpJdUE6T/vw2auC6jRE/jaoqc8GqzfgLkNQ7zEX1RrqSHEKeq2bBzWZs5nC59KHBu5zzPTpYOdkJ5JOmSKQwbCOs75jQjmRDPO+Hd3vGmWNLs5JSTSA3x20me35NzsfniPWLK9PJhzHybn8FQn09FWBDZzvQK5waRmWQPW2n2CbMzVmjBDS1sWufYazA0hc47ldO9TZgzrR12R/wSlauXO5b+sMY54HK6ck+CzExzGs/89wgnaVj/JHM2DvVq3n7Ws9T91bMGI81ocM51GBeXPMEio9Qt9xmGQ4OGIEJLjQtvKZKMAbpis6B4zjqKLb9skGKytT4YWLauVHdQ/FkL1ZefBFEh7/vixjdIRAhUFpdMoc26uGiU3Q6JNcgRsIlbyNuSrB4tJFMT/5N7opwSsygdQoclB9hP4B62Y2/XQD+geOu2i121VJ+SUjQSGUggmzsdYiRgPsM6D/3jjvrdBqfxYqLEd1ATjMKUtsz+/P3WpxlJR5D2rgSWrDUTuPWqx0bHvRREbSDXDpnbscUMI+3gMd1Ufew==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4fs30RlCE06oZCtKfopkPJ4/C+O7Db9TR9C1j+lUhyUG56hCkm+6QjUO+KJGYnKLH4F0Sn2J/aLLlBgorVgdBcBntO6jXH06iM0/2vYjuVcQinBP97Upy6a+SGTxQIAZPmOEmViDSayqI2cm7fQ5AmRdTDpnsC97HFlZmAao3Zsi2/H5ZJknXQMymD4bOdFriOwo4jZKSP2PxhplLUKtKz1DWmOJ+pL/YDC1WAXaHSnO1wRJAHR7n88RILYWCXGkEUC+QMZBAYwK1m2AbBHApwMO8fYIZsvXCWTaFwOL6Sfhk8BZWjEZpSvDCJ15Waaz8HeG2O/pTfRBKoZqWPDlit431KzvIS6/UD3sGLV1dn0mHzulAl1kU6qjkwH6Z8a7L55axmVYOcFWpnuKuPrPdmyaTU3hhMEW9U6sUAvqhaow96fSjUzEylUqGFNIsoUE
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 16:04:09.3832
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2e2075a-35fe-4c05-28f1-08df051dfece
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A893.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7930

On Fri, Aug 28, 2026 at 12:53:36PM +0000, Mostafa Saleh wrote:
> Commit 6fabce53f6b9 ("iommu/arm-smmu-v3: Add a missing dma_wmb() for hitless STE update")
> adds a dma_wmb() to arm_smmu_write_entry() to make sure stream tables
> and context descriptors are observed first.
> 
> However, STE L1 table descriptors are configured directly
> via WRITE_ONCE(), where before that they were zeroed with memset()
> inside dma_direct_alloc() then written to abort in via memset() also
> in arm_smmu_init_initial_stes() without a barrier in both cases which
> means that the SMMUv3 can observe the allocated table before the
> written descriptors causing it to fetch random data.
> 
> Similarly in arm_smmu_write_cd_l1_desc() where the L1 CD is written
> after dma_alloc_coherent() with no barriers.
> 
> Add dma_wmb() in both cases.
> 
> Fixes: 48ec83bcbcf5 ("iommu/arm-smmu: Add initial driver support for ARM SMMUv3 devices")
> Reported-by: Sashiko <>
> Signed-off-by: Mostafa Saleh <smostafa@google.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
