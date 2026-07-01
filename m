Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010019.outbound.protection.outlook.com [52.101.201.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0973D6CDD
	for <iommu@lists.linux.dev>; Wed,  1 Jul 2026 19:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782933038; cv=fail; b=UY2mTy6mNy2duQjNIFjML9jNPuLMKQw1GbpezzGvN7VTxtP7sktpovUFdf+7SPPiLd5lU7/zDpF/QIbh5MUFznh7EeZxnLfEMRHlSqFGNE49enWQS2NoO2roGx53mAI6Zq+RTdALUC+xZK0Brdc+TbQwocEQsefDE6h8c24VEAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782933038; c=relaxed/simple;
	bh=wtwKegzYwaSMrZk3knU2HDBMxVMjxOXca5iaNFqmpi0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vDcPPAnSI+Y61HZVr/8vp5m3le/GBMW01z7xReB7HdxpEujH561PVm/jZstsDv/CfwkM+yT1CliF9b8JpntF1dRahUE5R69Ez5bu/qdumpkX1JezTW8Ngt3wicdsnI7qLWhCbEKzv79Cabm6m+mscvgdHGhYM0R/xSH1kJ1Ep+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kj+4Ab27; arc=fail smtp.client-ip=52.101.201.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kj+4Ab27"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vkHcqd/tl7YsoKSPRQLR0OOqras96p8MNQ9POCkHreaZG2BxGlaUsP2Ob/3G9KQ+rhtwiJWNoMdUs5n1Cl9sD50k4gsHNkWtrzGJ7E4sJtUMWituAGedjzzCqL2tomK8NxdPAOTBPYWLFDJEusfaNaFdtcaLV7lnlbUwHgylyGv9d7TO0yZjxkWWAie4bIDMjJt0B1EqAWYm1NSZfL9Kz5JAf/o9YvyFsP06Mbrk6aHgyay5GfEz1P0bFc2KamGVPGb4OYkMMNJ89tQhc9s18JOEik6kID6Wq/2wTPqMG+zS/H/d57Q7Px9XlWMouTFHQ1+D9aH2Lei2BBEVCTcOBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2QJO06gcJC7ZJfow1zzW1kF3Lx+GqqqFrZ9jbz0WWic=;
 b=PpYpolvVSS7Bo2JAR1UNPXAoeAANcL+CqnUVGrc3LT1DXjvha+4s0PeKM+vkvv+mJPc1V1aSLQB3Hgjeb7vfXHUIUtJQaUUvUhp6d3keZA1LZWnl1G7ZAQesDiP7didZRQkhp7ybBwJofhTVDA9BYa5ujPrWop02vj0CqRRoEZL3oK3dCz4eug3UChPbSpAMI03cfty83CDEfIE3X9m0SaDNqmi4DjmGr8GG490HM4XluWBpZYMo7Dihb4ZH+QyaQhVxeLDpx3aiEmC1/RxkdCR+OfzVX3cOqrd9NTO265zy6/+Zfwn3RPhbMrnh0D95uF7yAcF5MCY1Y3sg06MgFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2QJO06gcJC7ZJfow1zzW1kF3Lx+GqqqFrZ9jbz0WWic=;
 b=kj+4Ab27Dithh9NzK/q7hBjN6CNxOFnF66Qs1AqOMvI1uOEu6CJLruH96dnfgiq2oNZIdZgdao+9UimaeantvsaZAbjKhX/QA99nTX0Rrx1SlVQdW49maJZeW29qr68Mb6042g9VgY9xE2kZ2stPx7xIFTGj4dTFBcVoAgEyuff1lx0rbFhJS/k8JwxGlnIizoeCtVKkvCx8Nja1YeNYXpnn5hDHRWaHMW84rELO34SY82kOAVoZgjInM5OwHfr5O9cFvz0j3jt+g7SnBIxHmfJNx0wVzAr9veUqb1T+LaYRgmuEf7C5TKfscKUKdnz4OjS7vlcweF5txm7i9LBs/A==
Received: from MW4PR04CA0115.namprd04.prod.outlook.com (2603:10b6:303:83::30)
 by LV8PR12MB9713.namprd12.prod.outlook.com (2603:10b6:408:2a1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Wed, 1 Jul 2026
 19:10:29 +0000
Received: from MWH0EPF000C6186.namprd02.prod.outlook.com
 (2603:10b6:303:83:cafe::9f) by MW4PR04CA0115.outlook.office365.com
 (2603:10b6:303:83::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Wed, 1
 Jul 2026 19:10:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000C6186.mail.protection.outlook.com (10.167.249.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 1 Jul 2026 19:10:29 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Jul
 2026 12:09:45 -0700
Received: from localhost (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Jul
 2026 12:09:43 -0700
Date: Wed, 1 Jul 2026 22:09:38 +0300
From: Leon Romanovsky <leonro@nvidia.com>
To: Honglei Huang <honghuan@amd.com>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <will@kernel.org>,
	<m.szyprowski@samsung.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <Ray.Huang@amd.com>
Subject: Re: [PATCH] iommu/dma: free the entire IOVA reservation in
 dma_iova_destroy()
Message-ID: <20260701190938.GD65299@unreal>
References: <20260701092033.422867-1-honghuan@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260701092033.422867-1-honghuan@amd.com>
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6186:EE_|LV8PR12MB9713:EE_
X-MS-Office365-Filtering-Correlation-Id: 931864d5-32c8-445b-313b-08ded7a46ab1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|376014|1800799024|36860700016|22082099003|18002099003|11063799006|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info:
	xbMBponta7kJa5LURLJ9JZZJz6lLWSk4RlT7lc7h+dGTASk/JrkSHYhiN8ZYftVYM9XKmbIGL0Ycoz6Y2ptIG3VvGAFdK76iA6HIyn4RKhkUKAp+k7SRet/1snWkI/0KXl/7xt1MzLMpV381X1HuHz+smdOFxuCKG0xXzcXSoi4Vzj2Vn117qukswUdEPwnlR9kAVLM0QGDEEZsCLKJqjxisFJinht3UsGKj0FkiHOwctzVssluFlMtj7X/qAw2VB0KzaQ6/dOZrXCzE6n7H3TFM/7Fq5R1a0kCygXlyExVXUzweDtnn9cgkSa81Kvk0mBNbOQXHzDdKum6pHePAgwOdDc5qrOZd3z2narkneF9Kn2KtOCGappVQ6xNXdTSCwuv55E1x2F0T62fb7DHkSj3JJi1J1u927qNYWHeYuQSTkJTrkH9Gup+y5HKIV4N+mXHaqWWmBKi42goX4ysn/dnpO5PE4nlaGCFallcKmRpY86sHrB045ynPrAi5dROtcMdMZCZs3Fv1mnndjso7bHMyMVtYFFcJZLOrmMj5oMmRWEbpWE9vXQ4AS082oUMO9szXFAkJfhKIeNA55mTpzfXff/bmL464nCYLLh15Dx9BnZGVxs3SOZCf+0ONIYDO1HP1x+pSJZzCTBClkjKIyqVYRS+Hqnh9PbezXXYGOor1W1LwaEsjGMSWMU6dhbmDzqSs02LDtSqATfn+3duPrQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(376014)(1800799024)(36860700016)(22082099003)(18002099003)(11063799006)(3023799007)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Rd9VQniRyqJtRojvu6vZb3R+8QcPqQM0X1+oCUN+iWekVO1dPaK1qlUYe97rY9UDJ/8NEjqAlj2J6Ae543xAsDKlbiVtVQ9vQ9ZUA8dplDAI3Ra+RGYwUtoQDqCRUTCsl8erov2lr1gAcCrFr77XEQHGAaQxdLA0OzyS35ytt9jYb88E0AKicfXuG6kUeCDaSZkWnezTYxIJ5fhUeLhWV01vhtl6lF/FKK2aZotyQRCq+CUoDuq+NPf+EhrgrUOnNlrYtVzccitzm9BJbVdcSNz7ZTXN/ITJAZ1vLzh0OVjLGzAcBiYbWta8Wztscgfj12Vae33EM0z6kJpTaRN5zkOTkYIpN1PzLbZbF1RhazDrMcBm9cys3DWoXmeguMlD5a8T2JYolt3kxKqdUAEqpKIe72+kcLEgSp73F3I8Aa2eRMoHiH5OVVSiiiaDKUBT
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 19:10:29.4791
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 931864d5-32c8-445b-313b-08ded7a46ab1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6186.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9713

On Wed, Jul 01, 2026 at 05:20:33PM +0800, Honglei Huang wrote:
> dma_iova_try_alloc() reserves IOVA for the whole requested size and
> records it in state->__size, but callers may subsequently link only a
> part of that reservation, for example the drm_gpusvm mixed range case,
> where a device page range is linked incrementally.
> 
> The doc for dma_iova_destroy() is:
> 
>   "Unlink the IOVA range up to @mapped_len and free the entire IOVA
>    space."
> 
> However __iommu_dma_iova_unlink() computed the amount of IOVA to free
> from @mapped_len rather than from the full reservation. When the
> reservation is larger than the linked length, the tail
> [mapped_len, reserved size] is never returned to the allocator and
> is leaked, contrary to the documented contract.
> 
> Free the whole reservation using dma_iova_size(), mirroring
> dma_iova_free(). The unmap step still operates on @mapped_len only, and
> the same iotlb_gather is reused so a single IOTLB flush is performed.
> 
> Fixes: 433a76207dcf ("dma-mapping: Implement link/unlink ranges API")
> Cc: stable@vger.kernel.org
> Signed-off-by: Honglei Huang <honghuan@amd.com>
> ---
>  drivers/iommu/dma-iommu.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
