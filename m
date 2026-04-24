Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013036.outbound.protection.outlook.com [40.93.196.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18BB388369
	for <iommu@lists.linux.dev>; Fri, 24 Apr 2026 09:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777022559; cv=fail; b=gLMIoIqWnROr514nczRwTA1He5Mmel9we/8xLx1ZrMBKE48hwGFZ4r7K1/TT07NThqoPqTbbY2KB9Ksu8BCzQ7GOLCKs2Yl3zeEXNZRJ/gzC/D8dePM+FfyOkm8O/efCPjPE6IfWEoBb++2WINhGmjUyUnlWwYLzZk2risxcKvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777022559; c=relaxed/simple;
	bh=+r+Tm1/KbXETD5mSdYWAZ32sbDQOrd1NFKSxRfYhOvQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZHolxtMGMmwuxHCVWuhZ2T0mwOL7k0GH+7CZegKPmptD9h7TAhP4GVWL+RGJxo4DmDXUd25kKmVtODrTr0vXFcGph8quAwnTAGwmdPC7K1s2IyNPbqSZ1UzWp5hk3XKM4elWbWRRdTmxGQ09h/oFhYJFAQ6YpdtwjpxF2oPA6N8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jg6KZJ8x; arc=fail smtp.client-ip=40.93.196.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jg6KZJ8x"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fe/A++MjZHP4vMr2CrUY52yUCO+1M3tVH90y4x3Lu39jiXr6ZKnB2l/uRk2vsmfac0u4TDkKGmEW8st94KZJkpH+my7ARQdAgZiNuStGl3KMkaF0sgCjt6kFNU5ItxPKM0X+Nr1mzv8HQBUBaPa/nrhQcjoILv9nafvaLTZ24+kDZLoHO5nh3oxCsdX+YWXTBnlLEClerGq0fPv7l99bfCRe+76xurBKWO6rHr1k8d6U7zh7mKDQnLWrRJ971HtxPK741O4uDlNXQBZdkcLEW03bze/LYyXDrTXaJ+NhGkaIKw6GeHbtkGzGPRtTpOarS/WT8oA70HJWBnJiwNZnIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lZTjZF+x0WUc1Mwuii6WsteW2lRfCrI+wxIKJzE9ZeY=;
 b=NeH6LkFIT0UO0rAW2rEpzx6b2ggsqN3nl90K4H7rVTBW+1TG9SiyUNR76ry8KvXWSH9xrfTbrDcWjkRriM/1IejNpb5wO3CgaYvCrbrLMmj5l48umhok//kv0k/mv5ZnwZ/a2JeOm/KNlqay1+ye5ks0izAZRFrCH7FhMEp0oiM312ScTEd2cbDEFfnQBQqwfhQbPezAVFM/gZZMtOUgfMpXQ5DmIKYusUMdcZS5n+cS868TOO/gDrp2nrW6hfh+e1zy81f9RYfiubIdTWaP6xbtt6/Js8pR33WcFnwvHXr2q65Yojn7h31CbpYAeiLTCbSTTEWHbT3yzB+dePHi0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lZTjZF+x0WUc1Mwuii6WsteW2lRfCrI+wxIKJzE9ZeY=;
 b=jg6KZJ8xzkss1mS/zGY56Cma7bucb4CyLXeqZ2DKr83n+Ql4YVkWmaNQ/IplwiNvqcYKUxgKLOnJv3AWAwutzhl1snIfam+G7Gcy7KwXqNa7cXUwpHPu2TAJs1iXpyoO2rpyaTGPrf03O1sqT8VUfjnIGWrfVus6nMNbL4zGx90=
Received: from CY5P221CA0123.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:1f::18)
 by MW3PR12MB4442.namprd12.prod.outlook.com (2603:10b6:303:55::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 09:22:34 +0000
Received: from CH2PEPF00000099.namprd02.prod.outlook.com
 (2603:10b6:930:1f:cafe::c5) by CY5P221CA0123.outlook.office365.com
 (2603:10b6:930:1f::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.22 via Frontend Transport; Fri,
 24 Apr 2026 09:22:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000099.mail.protection.outlook.com (10.167.244.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Fri, 24 Apr 2026 09:22:33 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 24 Apr
 2026 04:22:30 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <jon.grimm@amd.com>, <vasant.hegde@amd.com>,
	<frank.gorishek@amd.com>, <thomas.lendacky@amd.com>,
	<santosh.shukla@amd.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: [PATCH v2 1/4] iommu/amd: Drop unused global exclusion range fields and init
Date: Fri, 24 Apr 2026 09:22:10 +0000
Message-ID: <20260424092213.16976-2-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260424092213.16976-1-suravee.suthikulpanit@amd.com>
References: <20260424092213.16976-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000099:EE_|MW3PR12MB4442:EE_
X-MS-Office365-Filtering-Correlation-Id: 3300fca7-dd9d-4b57-014d-08dea1e3045f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	iQLi7a5YXfq0qiodz2Qwy+qmpTzSnyN+b6hKi/D4AL7wDRq9n16fP7p8mMUfrnPL9iH6SdTaP6vqprEn/WUya5ToxdYICroYkodN9VwnY3IDybpk3c5s3Pw2qfLQmF4ZlL91lg++JAebhUp7qkf1LIo20yUqf+SeH7Q/CcHbqfG+rMx6plJ2PkUYl7Js5Xs4Khz+mJMw4CN17jS0wID8mvH3n4YUsR+eRrCSsJQYhdTlXjWEumP6t1K6a5H3zBxt8Nql+7aeuVoJVqxzWfsQ1QlPZNckKRAodyAB9m089bvC/y3EZnYhqoegflQvNUhuF29scXTgZ1R+mra2PpPzBh+PZkfO59gdG8E/ZFGVHtI0Cr2t403B3CHQeR+ZidLnz+TTcPpbq3QRy/orE/jlREFJocxU5tDqxba7Aj3LpoVEf7mm9Aja4zToaL+TScUSXkCoOE9ZNaSaiRr8JmCaJLxlFcJ2VDv6AcPZxZgQ6KeKsRVHKJQ3RIh/oWyRRDAXDPVNluMlvPg9eMqfdktTXhR5aY52mt/1kWjh4IQrl7U3Mbh7h48PTRET4Q1oS7R95nxeo78zttqzLZwGGigRiw6woDw3969TX2DYclbem3N0VCssUMkeVnnAq9t3F2JtatYqAkY0XKO6/q1fH1cYCUMslHOAviGeZmuKJITgrAMwz4lRW1jZs41bknLjMAnfjdhmhmIerstsEplTPVPcEoSq8IpHXPGbMjdN9kGmN4nfsRfsbSmIXkpaHehBSUunRkaLRZ58VnPATkp19BT6jg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Kba726Tib4wisN3tfWTzPxraVHJY489H33Od2hg4x6vpZ71beGjIRKWTY8KoCzV6UBjxp3nvSDTl7k3qP5FUHdIP0NVwjmKOwbSBzKSGG3EmoKnhrfuhGwQrLPpLzb/UNqywh3U2cahY9X6E2Hsmh9HdIUIY6ew+dDtYNkB7PKN0sOjIqh1f1gmkEGs/NXxWKogMt/JhqPFNVuat6YrIY4VYuhH6v2fiUITWf8Hqi/32UUpcmBv3mcQk6W1tKqMC1PzNjbwWgtXQFkuhnW4Dq0GZhYcW7RaeNRm3832DuM8AGPKAZfx970CdbLWd84hWTZDJTrNGfA6RS/2KYHXKRG9notrLYy5moKlwoxDOJLlGR9pVW1+h2pvPuLmTwWnqZ6YOto6qSxkcawCpO8C9rnQ6usVXmgu0yQVOv5uRUcv6CHRbF9E7/K4KrwYgk9VW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 09:22:33.5620
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3300fca7-dd9d-4b57-014d-08dea1e3045f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000099.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4442

Remove unused struct amd_iommu.exclusion_start/exclusion_length, the
MMIO_EXCL_* flag masks, and iommu_set_exclusion_range(). These struct
amd_iommu fields were never assigned, so early_enable_iommu() never
programmed the hardware exclusion registers through this path.

Please note that the exclusion range registers have been repurposed
to SNP completion-wait store base / limit registers. So, rename
MMIO_EXCL_BASE/LIMIT via to MMIO_COMPL_STORE_BASE/LIMIT instead.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 4 ++--
 drivers/iommu/amd/init.c            | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index a481d8cbd053..6b0f1b05aa47 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -55,8 +55,8 @@
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
index a33bf3f5ed8a..866249d3673e 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -364,14 +364,14 @@ static void iommu_set_cwwb_range(struct amd_iommu *iommu)
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
 
@@ -991,7 +991,7 @@ static int __init remap_or_alloc_cwwb_sem(struct amd_iommu *iommu)
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

