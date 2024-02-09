Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E702C6BA
	for <iommu@lists.linux.dev>; Fri,  9 Feb 2024 11:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707478278; cv=fail; b=ETM9riwg4yiReBJGPk0G8GIntWakbNaTdfaqzNUhMk9ZtiR04dPj0L6f/XjFcqzt0eLUHvSzU3SV4iWURRSCQYH7RCIIQaYxO2FK1j+X6trZCnRpYvt4RPoR3rJdOcPmnkfPg1ZMBz2BP3pMddd9RGz1sV+MkBgtiNSiLsJI5uY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707478278; c=relaxed/simple;
	bh=1zM7w3DHdYds9ZFFzdkpvFbMRfPZxee/kP0ykOiTQTc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T04gULT8VsWRqXQkOuOYLA7ALRtwdWrbpA9uGt7IYLR/LaRXp4ZJdN/YE5KmXH0tTGTGAAaib7ctK7A7VUIkV44jugPTsSAxN3U7g1RaMUTlSeJDZeEzz6LX2Yw3Pvj1CQ2IELdtjvZt5M8Mo9tOlnlqAW8Kt9KBP9Ru0sVptHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AiOl24fG; arc=fail smtp.client-ip=40.107.220.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AiOl24fG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RThP+lU2qqbmaY6jMRLbcM5FDvmfSytZxJXrmnp72X56D2tkikB1/hWD2YDPU/zwahAe4Rn/NKKdOGiX7TJyWRJwFmKWvYSU3sg8BKn/hVTEF/uavTGjE+5xObBfxrAoM1/X1KGvjp30pK279xEe2JNykgUG+zFXsT1cwJJ4P1R9Xjs+BWOm4gRELqaQ0eAi/aGEfOAvNXxgaH9vVG0NcdFZNcV1gk+CNm8Me7bb0vzGYFdQSApX1Mlrp67T52Z+Ka+GFo8BYiConezzfWzBevjNiMGiqbHVQ2TO9vAU47tE/4Nn4zcIyPCj7Le+KT2n76tzz6gDHvEzcYlRFVHfRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FDOEQJLYXIrkckbhOoG1Uk1wBCKP31CheTVG+QCZm1w=;
 b=a2glbQxO1TW65Cbf2CWkp9gguDyWJKtuUYJJSwPEp+qFdedCq4lcLdW+TDi1cp5ACqjmqmQt3OW1w6GudS2jSGFN/5ETH3TInQSwXfZe84HlD6k6urLjRn6Uj2h9+CdsPB0Vqhp5N6wmx5LqYX5YamaAst3RhVo6Y7Ei+1F85k0JerIOQJwsi963QDgF8aD4R/FHaoz5pSja2iwJDBH6MDTGUZYFvMhj+l8YayLkfiXMtu0cpe166mC3JB94ve1glgghDFNR0Am+O/oSY2K6iUXC6F0FlawTqX6yeUWIzgtwLlX7hoDgreXaLomOFlZ5nGo1POU8BYvdrg1fyGjnRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FDOEQJLYXIrkckbhOoG1Uk1wBCKP31CheTVG+QCZm1w=;
 b=AiOl24fG4vfeCNJT/O26o79ga5x6GI6PAxfeKgld/m5iUdE+f3bSa8TBlmvBn0wos11dXDaqOIT+3flPUoHWD+q8EM/7tbFGLmdl561PHhkAuvF6CGAOxFXH2xsNdTqI2fzo+6AZ9jxIuhg+RPYghW5ctcNaLENOKQ76Wr4946s=
Received: from DM6PR02CA0080.namprd02.prod.outlook.com (2603:10b6:5:1f4::21)
 by DS0PR12MB8562.namprd12.prod.outlook.com (2603:10b6:8:164::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.13; Fri, 9 Feb
 2024 11:31:13 +0000
Received: from CH1PEPF0000A34B.namprd04.prod.outlook.com
 (2603:10b6:5:1f4:cafe::49) by DM6PR02CA0080.outlook.office365.com
 (2603:10b6:5:1f4::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.24 via Frontend
 Transport; Fri, 9 Feb 2024 11:31:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A34B.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Fri, 9 Feb 2024 11:31:13 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 9 Feb
 2024 05:31:10 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>, Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v6 05/15] iommu/amd: Fix PPR interrupt processing logic
Date: Fri, 9 Feb 2024 11:29:20 +0000
Message-ID: <20240209112930.63663-6-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240209112930.63663-1-vasant.hegde@amd.com>
References: <20240209112930.63663-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34B:EE_|DS0PR12MB8562:EE_
X-MS-Office365-Filtering-Correlation-Id: eb97e03c-198a-44f7-c276-08dc29629f5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	d4dpBJ55A3DRBM4bG0Cz1dhVse/lACX44OK6wEdn3zyYXg/5OvpYs5UUq+a0f1SymnFeX9WKzOy5oi7Ema1eOOx8GgcAm5rBC0QjvEnMFQKikFSrD/Q9bMmqffXe+GpZQ0QZXZc3DhmXqSnuOrhUMO7+5Psf1zKdCa44gcfIPawyatuxYX+o/yr9AE8lUSuiGQ1zOrrcjpUidilBWbcz4+Ux+eHZ8oK1iPUSp4yZx7pm5d46wtEBz97W47ASDTsaNLwWR2C0/suBx1HfxKVkVDbugckA9DesoSgLiUc1D0jJztU1jF/0+nd7cqcp2qG7NnUWlCrjA07it3E24sB8A6zih7FmX/57iVKJ2ZQe083cx6Ec+kGCs6B14TtjUJ7qMRK82jf/2H6oOTSu0UPCr7F318tR7k2IMCz9TSRXFgCJn5dh+hlF2O1OIidK2cUbXKjGQExWC1dntJfxBnRbT7yOMlMduRBKkqmeHs7wBbp5u/8ufTX8Wyx0szQL+8SAV17v8wf1/5f0w+0Zz3+I7ebw9Y074QxzzZJp5K49mqaeXBXYzAZqycHRNHKFtCVoRb+WT+31soqmz2Zft/4yACquoe6QheEBRNQiW1F12ak=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(39860400002)(346002)(396003)(230922051799003)(451199024)(186009)(82310400011)(1800799012)(64100799003)(46966006)(36840700001)(40470700004)(5660300002)(70206006)(4326008)(8936002)(8676002)(70586007)(2906002)(44832011)(83380400001)(16526019)(26005)(1076003)(426003)(336012)(82740400003)(81166007)(356005)(36756003)(86362001)(110136005)(54906003)(6666004)(316002)(2616005)(41300700001)(478600001)(7696005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 11:31:13.6267
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb97e03c-198a-44f7-c276-08dc29629f5b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A34B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8562

* Do not re-read ppr head pointer as its just updated by the driver.

* Do not read PPR buffer tail pointer inside while loop. If IOMMU
  generates PPR events continuously then completing interrupt processing
  takes long time. In worst case it may cause infinite loop.

Suggested-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/ppr.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/iommu/amd/ppr.c b/drivers/iommu/amd/ppr.c
index 673fcc30f9dc..d43a616c0c36 100644
--- a/drivers/iommu/amd/ppr.c
+++ b/drivers/iommu/amd/ppr.c
@@ -104,9 +104,5 @@ void amd_iommu_poll_ppr_log(struct amd_iommu *iommu)
 		writel(head, iommu->mmio_base + MMIO_PPR_HEAD_OFFSET);
 
 		/* TODO: PPR Handler will be added when we add IOPF support */
-
-		/* Refresh ring-buffer information */
-		head = readl(iommu->mmio_base + MMIO_PPR_HEAD_OFFSET);
-		tail = readl(iommu->mmio_base + MMIO_PPR_TAIL_OFFSET);
 	}
 }
-- 
2.31.1

