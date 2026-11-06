Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793938907;
	b=dtLZ9A/TkcBJ5QfUthGUkKjJhnp6S3KyI14Zd7fGdbi+l5OYbj0vv9tgOvLO3pLiFP0H
	 zIwkaznJT8sewSdAVMrDJT7SPQ+Mmi1gSiGaQMwQNCSaaC+MIBBQ6qRMUXdSOL5R2pxpb
	 9k2R3d7EDC2SuEHKcyBIRWNmZn3NttU7O261kAxSQ+bYsOIqdPG7x2GX9UjxdoXBUUwqk
	 H0kJG9V10VT4aAKnAV8kRHwHoXP/n/DzO/0P7EPyK2IPntI4Wg77zcOBzUzU1RrFa25MJ
	 CMDw54fjPjXTv9eN8B8Eo9tH4CRgHy8yiX0nP+NhWMrrryQ8M1ZyAxevdGxNm17EOhw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793938907;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=gYExT9Cm2e2aD6c5bQnyuy1xxReY2qqw41s6xL7JvEU=;
	b=D+aoWquWMtr3zBaIFJn+Bq5Yc1X5tNaSx82yStsIrEGw9pGLjDpGOFvdXCiKIZ6fGTbF
	 lm7zrbsGl2NowfBnrm7Cuu3rEWJ3K3c2jmTuWL4pcxhHbh4yodra78Kxm6y8CDWro6GmM
	 d43JiwHkCqoYjA92leVnONpKna3g3R4rKdfDRK4PGC4X53QOqk/8wsR4HCvPU1UJKfeO2
	 rg0NIFfFDWsiZ8pmff9WjC8ico15kUftEIFOivcm2F1ngfmGSDCyNUXYvQC/HHNuGiRty
	 1w4N5L4J6s1tO3g8Th1g6O6Fqr5uXtoNBWLn7y9+noXKEFuCZBi/nlSqJ9pjHtuUYXg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=LwU8KQwQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.11
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010011.outbound.protection.outlook.com [52.101.46.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CE1606A31B
	for <iommu@lists.linux.dev>; Fri,  6 Nov 2026 04:21:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56CE1606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=LwU8KQwQ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=abmbWqLsfvYsp04XVPjeGt9NUg6GP3r9FyuiD5hheohLtqIjdI5ek3Fb1y7HTC7OiBruHO/OouY4HUFJlzMPl7vyFc+qeR3F0y/LtPd1BkpEizVFdzO6kfiQzzf/34ryBlDKi3xakv1a2igjLwSYWnnR/ImMebqxfGTZkLXsx49LkvB6Q96z+ESwH7I9zP7IGt89+imUlqHjoc518cbCihchA6JZUPSASWFGXWgKXpCWW3ijpDbsya7zg++qSWb8J3GKw7HOEIK7oCMFUxCC1mCsxOawVVWUtRRkfk7yIFlWAwFBJAaAKhMZSGG/zk/nk0ccmPP8XY1Y4NmgXgA52g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gYExT9Cm2e2aD6c5bQnyuy1xxReY2qqw41s6xL7JvEU=;
 b=hB811GxnindYxPE6jBkybHYJ9Fi8kkY/KdB8ffJXXVbasM33E7B1oqsY/1Fv2zICY+HOQnnQOavjOLupngmFRX7rdTxm9+mN2vykpTbRVXc2tgM6cioYU9qhFbiImlSE4DmU8oiRaLt9iExRw5bjeGLBdk7dvO8lqV5ECm0RWcAXIav4d94n2cXqYvpC061GfSe6iYv+hYuLFhJbQoFsLZS4Tkby8A/U8GBdFFPRngwU6rXtgid2eJvN1dKydXa/Xxnp2FHZkfEM3nd0cUMaI6D69IHVSKe3i9FTly+yPBUFgcz0/je+HkTauVuoQ9zQrfoY+/D+po//V6mEBFZwOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gYExT9Cm2e2aD6c5bQnyuy1xxReY2qqw41s6xL7JvEU=;
 b=LwU8KQwQvoGo14qYRC+7Lm77k4cGjOYG3vQLfs0aDYPq8sdM8PzqxvIjfiuvzOVaoVaqzAEmrAHI+PBzHf4wUD1RQinpIOzZ/L2ksEzsSk6yhaDC+TeYt9zi8NO5DT9e57oFaIuOuhII/hjTnnDF6N4x1m79jwIPb/oiEeKSrQc=
Received: from CH0PR03CA0258.namprd03.prod.outlook.com (2603:10b6:610:e5::23)
 by IA4PR12MB243497.namprd12.prod.outlook.com (2603:10b6:207:12b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 04:17:39 +0000
Received: from CH2PEPF0000014A.namprd02.prod.outlook.com
 (2603:10b6:610:e5:cafe::6f) by CH0PR03CA0258.outlook.office365.com
 (2603:10b6:610:e5::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 04:17:39 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000014A.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 04:17:39 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 5 Nov
 2026 22:17:35 -0600
From: Sairaj Kodilkar <sarunkod@amd.com>
To: "Joerg Roedel (AMD)" <joro@8bytes.org>, Adrian Huang
	<ahuang12@lenovo.com>, Joerg Roedel <jroedel@suse.de>, Robin Murphy
	<robin.murphy@arm.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, "Will
 Deacon" <will@kernel.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
CC: Sairaj Kodilkar <sarunkod@amd.com>, Adam Pelka <adampelka26@gmail.com>
Subject: [PATCH v3 1/3] iommu/amd: Drop unused global exclusion range fields and init
Date: Fri, 6 Nov 2026 09:46:48 +0530
Message-ID: <20261106041650.24076-2-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261106041650.24076-1-sarunkod@amd.com>
References: <20261106041650.24076-1-sarunkod@amd.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000014A:EE_|IA4PR12MB243497:EE_
X-MS-Office365-Filtering-Correlation-Id: 48eb184c-bf77-4fd5-62e8-08df3bbce52c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|261021121427099003|261022115727099003|261026130827099003|261026121527099003|11063799006|261026140227099003|56012099006|261021123027099003|261021130227099003|261021135927099003|261009223027099003|261022105027099003|261021133027099003|261022113327099003|261028144727099003|261026135527099003|261022075727099003|261102123227099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Bm+kQX6yeQwBTPUvUi5tZzzT2VNVJ02ZzXQn7bIHRKp8TEmEsFX1UAblmInGjsiRHCocptkhLLm+GY/4vMJ1KBt+K0/RfndngS3DrPSqKvHUeClnjimzuBV/pGyzyztxDQJLaDDAclmKc8IrFzvULWgQGVclPzvgNZJ5JvvHjSLCKMnw1wGCrO3F0AiU2V/qEWmsv93VtEG0g1Dfnd6RIJxjbTPFC/7M6h+t+TfyTHgpN4dVkqdDk93ZIdoOMNVcGMnxv/FLN6vJwHCyqb12/DicbwibCUlkz9kUur5Qce22qS9TCYnBENPtImmGRh5CPd41TjF2AbDPAwh8dfPmKt4H0tcu4hcO3qQBXq/1CW3DZQa9EvEQt4IQrFUfbzEWn9aeB1rgqguhYJI/5TE5Aq0WzcW/0Jh4QoCp/qPfCmm38lAsWNYYiB9DtshyI9CPFMnmvWhRmwcih0eemI4qEljVaX0/zNuEBHYx78D9gtq+HzgNTzn0Fsj2LXgFMT94iTLARnkAVl3GGsR2XimxL4synREcY6i/uq26/vxyLi1Myxk7wuVYBZDjce0bkc06stKStEX769HcpXsAfsVLAgjNxUPLrLkoaPYn0oDnAkAku4oOo03qfPmhR1ALpbwDskuxSXYk9CLGIqrhOK0MnwDHHHt7u47QLrXjgGtZypWBmCtH6dzXbfFsYtZLrBelIx/7SfSY7RzKEUOyD6eR5w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(261021121427099003)(261022115727099003)(261026130827099003)(261026121527099003)(11063799006)(261026140227099003)(56012099006)(261021123027099003)(261021130227099003)(261021135927099003)(261009223027099003)(261022105027099003)(261021133027099003)(261022113327099003)(261028144727099003)(261026135527099003)(261022075727099003)(261102123227099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hsXje55/nd4VnhhS2V0d6YIWVy1Dz8Rpn9hYF0ZwodlduRqxMm3VsGFwsWoolN6rFkYpSxthR0cEFGB3094f7HKQeWLsXcjsO8QHFvdsfYgKpTFK3LD4DAR3RUBgn6YsIoJnnxH8YISDLeoQquTyF/FQfOkuTLQAk8ccWG0ZfxijipgULOD46+avmIDx1yKR48XEc8Pc7JR/BLJrQhoOURECoMrBdrmBpcN8hjimz+M4SO0KdNXqjtWChZsMi/y5AwKvNBrvQmRt2+I/9qkMujZpD/27bmTKrrxhOiy5cEW8/EmZpqEf8/NW/NErXpTLbNwnXig4DdOkfNPcUAtyxUXIZDdfIrZgqxPSvuZkEzSLOs/foMH+n+7PrM/oChpv/PySe16Cl6QwSeX7NI6SuE22OAdSzvM7bkOZsro/16kpyvZQBBsI4vCli4echNwQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 04:17:39.4129
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48eb184c-bf77-4fd5-62e8-08df3bbce52c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000014A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB243497

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Remove unused struct amd_iommu.exclusion_start/exclusion_length, the
MMIO_EXCL_* flag masks, and iommu_set_exclusion_range(). These struct
amd_iommu fields were never assigned, so early_enable_iommu() never
programmed the hardware exclusion registers through this path.

Please note that the exclusion range registers have been repurposed
to SNP completion-wait store base / limit registers. So, rename
MMIO_EXCL_BASE/LIMIT via to MMIO_COMPL_STORE_BASE/LIMIT instead.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
Tested-by: Adam Pelka <adampelka26@gmail.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 4 ++--
 drivers/iommu/amd/init.c            | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 8241ef922519..678ceddd711c 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -44,8 +44,8 @@
 #define MMIO_CMD_BUF_OFFSET     0x0008
 #define MMIO_EVT_BUF_OFFSET     0x0010
 #define MMIO_CONTROL_OFFSET     0x0018
-#define MMIO_EXCL_BASE_OFFSET   0x0020
-#define MMIO_EXCL_LIMIT_OFFSET  0x0028
+#define MMIO_COMPL_STORE_BASE_OFFSET   0x0020
+#define MMIO_COMPL_STORE_LIMIT_OFFSET  0x0028
 #define MMIO_EXT_FEATURES	0x0030
 #define MMIO_PPR_LOG_OFFSET	0x0038
 #define MMIO_GA_LOG_BASE_OFFSET	0x00e0
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 8a410d4aa370..13c96feed64f 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -370,14 +370,14 @@ static void iommu_set_cwwb_range(struct amd_iommu *iommu)
 	 * Re-purpose Exclusion base/limit registers for Completion wait
 	 * write-back base/limit.
 	 */
-	memcpy_toio(iommu->mmio_base + MMIO_EXCL_BASE_OFFSET,
+	memcpy_toio(iommu->mmio_base + MMIO_COMPL_STORE_BASE_OFFSET,
 		    &entry, sizeof(entry));
 
 	/* Note:
 	 * Default to 4 Kbytes, which can be specified by setting base
 	 * address equal to the limit address.
 	 */
-	memcpy_toio(iommu->mmio_base + MMIO_EXCL_LIMIT_OFFSET,
+	memcpy_toio(iommu->mmio_base + MMIO_COMPL_STORE_LIMIT_OFFSET,
 		    &entry, sizeof(entry));
 }
 
@@ -1022,7 +1022,7 @@ static int __init remap_or_alloc_cwwb_sem(struct amd_iommu *iommu)
 		 * completion wait buffer (CWB) address. Read and re-use it.
 		 */
 		pr_info_once("Re-using CWB buffers from the previous kernel\n");
-		paddr = readq(iommu->mmio_base + MMIO_EXCL_BASE_OFFSET) & PM_ADDR_MASK;
+		paddr = readq(iommu->mmio_base + MMIO_COMPL_STORE_BASE_OFFSET) & PM_ADDR_MASK;
 		iommu->cmd_sem = iommu_memremap(paddr, PAGE_SIZE);
 		if (!iommu->cmd_sem)
 			return -ENOMEM;
-- 
2.34.1

