Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012044.outbound.protection.outlook.com [40.107.209.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE99457E79
	for <iommu@lists.linux.dev>; Fri, 11 Sep 2026 08:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789115662; cv=fail; b=h2WCjD3Q0L95sc+hrq85ryIq0/d6PlUhv1COHrvpJS7MRZofTOOOpDSw33pCzXGK5rsgF88fRfpkhSu9xG9gOVIK/W/g0p6nc8rZAlmJvvUu7Cq8cJtSlRgvYtUL426QbPT2gCAGiHUKWUv3a/Is3TKe8ziZGMaiuEiedqL+dtQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789115662; c=relaxed/simple;
	bh=ZYsexnbXX9fuocQT4W2HldCgCIghLEf3uf5tvFafS+0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ePRvdtA0hbCrzDFJL/JGLLiI7r6qce/2K/RVQUZ/ZQrzwirQmIwPcwtXhVlW5Xf8e+3Bdf77Tk/06S+vPvBEkmy136tKuVW5KDkETT/9VAk6rmDdZVCLNVun/5gmE49FCe0Hoijj1ebzRZqYyoWYTixy8jhxNWeSmOibH7907vg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JXBB//uM; arc=fail smtp.client-ip=40.107.209.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JXBB//uM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m76N4OvgwzZibsIO78ropmpFL9tCC9txKOp4WOY6NFazxzv5quntyXaWCyWd5hJlDCk9kXTy6E06/Vx+97p2NEURLcEVl8wsNhuSppIgIbHtLIcCi1VZ6XUAy4Xi4Arqe3phViRZ9hYDDakGCmCZmB12FO60HuOaL04Umvta+CFZBycIv3fxVyij9MopQgAAxUKheAo4zd7DTLW5Zdm59Nn9j1UeOTgyPm3ZA8kv0yorTAd59HPxDSbMse0dSC27pXlxc5hxSKpA0opmjwTTSEJeVnVJoZzBXDih66YcHX2Glh3/biWbrID+44SSfeqpBb3CAqLb0GIxlec9jusNug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AL+PIbwEknnp80w/Bt38soJRtT4PTrcRXX+npJp6gtI=;
 b=HZWRRX/1sLh58UqnYpO4JXQQkvmUWpcWgm13/97glQd8QeCFxE5QjobXcSSuxMSlwKRTfu8qVV+3GKVe3DpQy9XBrhHdDlvKqJXxXOSmGqZbx3B64M2KqIXvv3UXk1WBMcSWpwvsCD6dtFXo8nEGqvzgKZhpODbJTA3EVIbmhaE68M+PXbQ9Zw1sjdZb2RBYrADisrp2EEUq8FMQlZK8LxvV1imW7WyHoqqpg4jtixyDnwug8zXySvsj1kgSQu0LPw+EPIUg6EWB1gBywPdaFSulsUcIOg4QfvxEopMkK0YTlmps9DJPByqBQ5PSlTANHR3uA1nFpSKj3fXBUyshsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AL+PIbwEknnp80w/Bt38soJRtT4PTrcRXX+npJp6gtI=;
 b=JXBB//uM1F941EDQpmwEL/o8GarTp2KPhGCyFkvnm3vgvFPXTZKBvRcEi1ucDAg0a7JW0E91Fh2kC6boYBFM2XypZguI8Epur6kFVeeQjRcW6tzXvRhSRd59SbVe8Tkv4NjsUfZcKHrnzJFkSnBboZaARNI8XquFvaHLIkZO7tM=
Received: from BN0PR10CA0001.namprd10.prod.outlook.com (2603:10b6:408:143::31)
 by CH0PR12MB8464.namprd12.prod.outlook.com (2603:10b6:610:184::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 08:34:16 +0000
Received: from BN3PEPF00022BD9.namprd03.prod.outlook.com
 (2603:10b6:408:143:cafe::15) by BN0PR10CA0001.outlook.office365.com
 (2603:10b6:408:143::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Fri, 11
 Sep 2026 08:34:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BD9.mail.protection.outlook.com (10.167.248.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Fri, 11 Sep 2026 08:34:16 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 11 Sep
 2026 03:34:13 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 0/4] iommu/amd: Cleanup and fixes
Date: Fri, 11 Sep 2026 08:33:49 +0000
Message-ID: <20260911083353.4812-1-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BD9:EE_|CH0PR12MB8464:EE_
X-MS-Office365-Filtering-Correlation-Id: bff6367b-f1d2-4564-47be-08df0fdf771f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|82310400026|376014|1800799024|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	FM91Zl1jBOkoOAY/IzdbipCDogQVfHe+1W62lznwm3VTvl1ncf2QCOBxOdrTS+We7TE83IWZqjkm+7HjdHlknu8tYR9AgRFxDfFSWNFbpN47aiVdxVU0gFP5oqybiM0Kr76qhZVNfiDBRgCljmoUGY7MxX+hqx94lmtPMxM/oh6yGWdrwQ010X9/SLvl5fh/rmEBktzNRDtgEVGDoMswBkjSgBoBUhdklI3ZF8Kj0G1xpwyMgfeYig4yHuhnAFCGkA5jHiVnIC4reVFfbOcyViGFZZrGttjEejqyVlRlmN3EE6xz/s2gXds565oo7AeWFjekxdwOOYBOFrXl1CQGSq/ddSmTBN81dBZAFXjvhNPl6sJax8OkklC+gVHglZosUYnSLUXDS23KnQjbh8LPXlqOdb/CB0ysASRXC3y978wHtPbCE/V7rO7OKA/h3Rmeg1Bm2Ty6OBgNEThRXDwgWXNbQop3qclfGUZhSC2p3cgwi3YwZHaGail+4DPhGZp22s6ZUk6Equx6KfYSO5PXwqN42SiwgYzjaQxFWrpZBuMQPfMiCFRAnMxXSRRcbI/QRaXzxQfi+iHrorK08qDVW69w7jwKRJof03/ih6uQbgqshpAUcokmMRdltwf+NLm7+wDJpD0S1G6zIHO7EIMBcf42dKMb8Zn0x6DfSaMjbOQx1kVFdbVKI+mvam/lB2OrK+9u0Pl4RsqBIJmmUyQ9WQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(82310400026)(376014)(1800799024)(10067099003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Ya2O8kXVIIhWsLym3OLkczJNyR7OysKVE/T9qXpPCjhnNgjPa/k+8NWAMZV42IuSrbTaLVUQbmP22qVJ1ytkSy+mxbZnk6dRweiEn2Jco2icTCSNMkNgYHp9ccYoJ8qi60b2scJgO3rxgeX8S/FDrB/UJD/RAYcx4aFoKW79Y/Jxe3Llz41MSUPpFBK/2os6Fi2cUrjQUo0d/ZdMOSnu2MnlmN8CQ/ZoNgxsoQRh7QZKS4KjgD9TzJz8H5o5xC1bpakl3utD4+u0YheFAayFWG3az29YnD992ATmfVWTV/PUiRpqzT70ycdxxjeRJf1lqDsA5/2elIrqlfMOOSMS/CPM8/MCn51kEHayqt9Glx2yQTRVmCQJbnGgoiiq/AhpOEQ1+UIAHtNrvpOex7vOo0B6IDZyGdlZP9oFQK94GbMZjF3LiJmlOEbDBAd4pN7c
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 08:34:16.0172
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bff6367b-f1d2-4564-47be-08df0fdf771f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF00022BD9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8464

This series contains few trivial cleanup (like removing redundant
checks, unsed macros, etc,) and fixes.

Vasant Hegde (4):
  iommu/amd: Make iommu_sva_set_dev_pasid as static
  iommu/amd: Remove redundant check in irq_remapping_select()
  iommu/amd: Remove redundant checks from interrupt handler path
  iommu/amd: Remove unused macro

 drivers/iommu/amd/amd_iommu.h       |  3 ---
 drivers/iommu/amd/amd_iommu_types.h | 16 ----------------
 drivers/iommu/amd/init.c            |  2 +-
 drivers/iommu/amd/iommu.c           |  6 ------
 drivers/iommu/amd/pasid.c           |  6 +++---
 drivers/iommu/amd/ppr.c             |  3 ---
 6 files changed, 4 insertions(+), 32 deletions(-)

-- 
2.31.1

