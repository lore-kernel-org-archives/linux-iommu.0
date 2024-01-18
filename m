Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3DFBA5F
	for <iommu@lists.linux.dev>; Thu, 18 Jan 2024 09:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705568499; cv=fail; b=l1NWV6xLdM10T0KGErIRBZH5jwS1v6G5OIyh2QpNWCzCxuvMR3t2UzzVpFTnyJ+XPRFw6y7D4JJWfD+dZtNorEVzTvRFBAuo5IbO8R8Nn5HFve4EHy131/7rsHPYWBmTFSu3l/qd5V6cW51FeJgYPSC4uVq/u+yB1NCv7akk7XM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705568499; c=relaxed/simple;
	bh=2leLV+dz0F4V7rDghytgaQwFn1Lv+mKHheQssmPcigM=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=CpKlL1P5OVXBCDliBHJ2XXqWFlRhMjGpah11jDlBfnVa9IWuGFCTi4qZYl0Vvur3TDVQAeRG77QM3wiLOz104TC/SfUGV/dL7+cqrKpqcgU8X2QCsUX2ZMi8OcTyWuFZdJAI9XQpXHQqaKj0z7LqHthNhWe/KqodbPZa+Vt+Ot4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Bc0MmcwK; arc=fail smtp.client-ip=40.107.243.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Bc0MmcwK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QFR1iFP9OqzkIyblA/2y5UDAkLyvP2p878akZjGc5wtDb15EX+4l7CQCickouRYbYBSFtZOVk60uLJhLi9XPxC31ZjilOlMiJByn8Ea4ZweB+IRBV41nlNaw6Z13oqRKFuM0st4jwZMWjWCMSpklOG4naHGbi/EL5Z/WvhgFTKL54+kqnx38JyF7U27CqoyFABILSAibu4deOfsy/ynnAbbHgrVuTWRT4A4GAFc1lS/lp9H3Hr0wCp5+psRAD12eHEdxPQ/XoO1mgSquLNSmZ72g5dwNMrDuA+9cqYsCvSrZzyUTh89ieOZlkomx33XZTxadGHqbVQalpi/N7o9Z6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CNlV+5GcUx4hSgdNOA+2CurPPZkJjB3Ob8i2vWbB+EA=;
 b=eav/0OAb37tOAulFQ9wYelRgAEtDmeWr+aZcnv6Xqro95icQcMHg8Uryp8KAe6cVQ5jJYIWKkLx7F0F8qjpMRQq6JH7MHhioDa4B0ELSHFX5W0dtKNL/gU7eCwlGGOzSPdus9Qdv1/JDHpDf19DPmLRZN4D3GEUx0TvFXmF9FitsgPKubCU3lYiKdwlzIWTk03jE/bIX63N59Uh5eDN+VCNfnl+hwrFVK29mFlF2DkZcPHw+nsGOB5ObC5E1kzoPyTZFZ4VSHToMIE68mMeJ5neRKPVtI0nPZW4xDvHFWYc4xjqCg0KgSLNVFCKwzTl915N1hNIdLysYB0ifiwgmIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CNlV+5GcUx4hSgdNOA+2CurPPZkJjB3Ob8i2vWbB+EA=;
 b=Bc0MmcwK9yIrygQgE/XTrqBtWtKTbKfQ879imFcY9vyXkyOe0ytwI2veAHHypzrbJFM/diZ9WrWKX/xwZp8gLZ1S823xuIv8KlyTtrP2SS0QcrPcPOKC7rFodamwTMInr5xZkRP5tw8Oe7ZO4HZr/tsMKkAlEecZmkPTgBt4CAc=
Received: from DS7PR07CA0008.namprd07.prod.outlook.com (2603:10b6:5:3af::21)
 by MN0PR12MB6053.namprd12.prod.outlook.com (2603:10b6:208:3cf::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Thu, 18 Jan
 2024 09:01:34 +0000
Received: from DS3PEPF000099D5.namprd04.prod.outlook.com
 (2603:10b6:5:3af:cafe::1b) by DS7PR07CA0008.outlook.office365.com
 (2603:10b6:5:3af::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24 via Frontend
 Transport; Thu, 18 Jan 2024 09:01:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D5.mail.protection.outlook.com (10.167.17.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Thu, 18 Jan 2024 09:01:34 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 18 Jan
 2024 03:01:31 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 0/6] iommu/amd: Misc cleanup
Date: Thu, 18 Jan 2024 09:00:59 +0000
Message-ID: <20240118090105.5864-1-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D5:EE_|MN0PR12MB6053:EE_
X-MS-Office365-Filtering-Correlation-Id: 3979e987-3fc6-4cae-c9fa-08dc1804121e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DwVUY7sXmil+hjl0+Dv2A1o0eTqqEWlCrj15ZjUTaAU2FiP4mSgUCVar1vY66RTnI9C8nNZFzXeWbtyDmCrOMxy5kpv3WWN/5CUK+5zeXmpfJ1PCl2rxXOiQsVQhorQyQIfJskNwdsrHWfyRQzprs5hGZZDHmcm3woPnL5A5ffeF+DTWGCzhegtzBAOo96z6C0yjTFcNbOd/o+zKz3YfpACp01PzMkwJNcylhJRRb8T8sdPvSujvozAUFxcnb1TTGhnzuNzxn/BhKxJWoIlPEb/VTEK0RQc33qyMhHe/3Zm48YsiuoDnV3bbAfoj1lU083EN2pK1W2et8pK6M4sJMqfeoqE9YQg+a4Eli7k57dU5Z3IaxZPZsxnU/MYXHem6A31Dge1LBZAU8GWqaRVU6ECjUiEAndqXCG6ihCFu3xZe1tGjTrLAIEytQmnmnual8O+7Xi/ec9JxPiCAGZZn1tfYZO0kzlun0Djv9h2Jd00TUlfEvlBFQJH0nJ0//XCbuCZeqlXuz2gA0ANnMRnuPUgY4hzxw2o4kyjCsc1H3UZpYNfEz8aW3mfLz/MBZCYK/CC+gISqSdGyHx/cMJ3ulLLT3jXVpYu9lmdEUSV/7LbqtCyeqnDVNRM8KZ4WCxnytu2Zb+LSpund3Z+qwXTIedBG+Z7yY47mflFugOeei/ICb0kCw0l4ldwde3X4Hwh64ZpeUiyPeXEzAue4pVe3wgDmluD4AgP8IW5p+YaNJRojFeYZKS/DA/RnqVBL/UYpDPs9zCFYvXO5dOO8eCk0eA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(136003)(396003)(39860400002)(230922051799003)(64100799003)(1800799012)(451199024)(82310400011)(186009)(46966006)(36840700001)(40470700004)(36860700001)(81166007)(356005)(41300700001)(47076005)(40460700003)(40480700001)(36756003)(86362001)(8676002)(70206006)(8936002)(316002)(54906003)(70586007)(26005)(16526019)(110136005)(4326008)(82740400003)(44832011)(5660300002)(478600001)(4744005)(2616005)(336012)(7696005)(426003)(83380400001)(1076003)(6666004)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 09:01:34.1929
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3979e987-3fc6-4cae-c9fa-08dc1804121e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6053

This patch series removes unused macros, redundant check and
unncessary EXPORT_SYMBOLS. No major functional changes intended.

Thanks,
Vasant

Vasant Hegde (6):
  iommu/amd: Remove unused PPR_* macros
  iommu/amd: Remove unused IOVA_* macro
  iommu/amd: Remove unused APERTURE_* macros
  iommu/amd: Remove duplicate function declarations from amd_iommu.h
  iommu/amd: Remove redundant error check in amd_iommu_probe_device()
  iommu/amd: Remove EXPORT_SYMBOL for perf counter related functions

 drivers/iommu/amd/amd_iommu.h       | 13 -------------
 drivers/iommu/amd/amd_iommu_types.h |  7 -------
 drivers/iommu/amd/init.c            |  3 ---
 drivers/iommu/amd/iommu.c           |  7 +------
 4 files changed, 1 insertion(+), 29 deletions(-)

-- 
2.31.1

