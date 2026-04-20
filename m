Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013002.outbound.protection.outlook.com [40.107.201.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668AE37DEAB
	for <iommu@lists.linux.dev>; Mon, 20 Apr 2026 17:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776704461; cv=fail; b=W8nFl9Zc1FU9ooecb/2uz+u5aKc4J20A+pfkV9c83WTjReYH4yyi9NuSeTD9DxZb5S4d5+wXF7U8J82HAR3o6wmZ7r1HGEycpVVucuIqZLfJgYvR5OOK9W0c6RXQSm5pHgxKD4AWGVLmcvYbX+Hp62zfK8LbnWl8CK7e9unIgrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776704461; c=relaxed/simple;
	bh=nkd5OYF/QkQBhwi3MeYWTrFetKxKFMmnZ0VJU1vR3+c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pUw9kC1Tkr7rWWckgPQy+wjm5+quLvTXeP8RGzqVkpFQNGYOdHQ01ZIrMnJWug6IlkVgyNCssnCV31BFOHWY14l337g6skQYWIPHgi16tIL5xKv+tKlaPzx2XhjrWEE3X1DS20Qk5T+7VpuafO3LVNjyedUMMiJDbLLkaBJ91Xc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PPV5p4+5; arc=fail smtp.client-ip=40.107.201.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PPV5p4+5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CgtD+wmyTkQoualWZLe+RKx37UM6lhWfknWQkG7lrik88O4xYDLa395qD4L9g41vze0RiNC7SmRQ05DC3PGd9k1SIbEp2RMTOUAZ0dLAscu3WCEpIXsT4ueDf4IBPIuO91M2k4dOvK9j6SiL4f5clCkgj6/rkF9ttq6nFaRbGLSEU2eTDTbhlF7zKjAHUgeF7ATRxKQxgZcz9yC/b+UIY0OhTncxQbcosgnjEhy8WvhCgIb7XYFIVuNTp6K4yR39WklysY67dgruB4pd9VCBpBUH2gCqQmQgUhpEkE6eMCIhU2j1AJ4UI9bC13bGIxqMBfZHrZisD2TEyua1wkvIsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=grtqdo6j2oEGUG6Ox9hRhExlOz9WmP8G/ErkHCBabds=;
 b=G0YNVFYHzLvo73PjixUbZKDAAMD+zHd4f0EvHI3SjY0uZRPS8j26UhElrFchcQEcGGqL8idnkHjHpPr4Mm4+ZU90DE4E+dunjoxWeBhRUDuRUiWkVU5U9kQzQZN8YyWom54L/KCIY9mT3rT8DI5jCv/fb+n4amfnFTc0B2MHgqlAuAlJSs7B3JgFNF5KcHPHuoLJEcwMfs3szSzBYvLohfJjB8EUOEuEzt7mcuJYvqDV427j7wgZcjYOhP8gKfcWg94VvTvwAZwMFywibWX0e6ckn9RDJsIAObZ7rc1sIQHQhXEEeLQNYhnVVfIlnYur+a3kEvTwFemQQC4hmq3siQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=grtqdo6j2oEGUG6Ox9hRhExlOz9WmP8G/ErkHCBabds=;
 b=PPV5p4+5lvpaPvEF4+ECVf0dvP0DBb1zMv2qUaKGFKCg7qvDl9vEpRvm127qSHgU9vrO7Vp50o5JD073HRyIk0esAMFbtbLD1ee79HQ/PIHS3u+gjdXcfYCWDJnwfeZqA2j3Udse9FQIzn3lXEXeyUdLXrHYNfL1wrTDA2HBok0=
Received: from MN0P222CA0027.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:531::35)
 by IA1PR12MB7637.namprd12.prod.outlook.com (2603:10b6:208:427::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.12; Mon, 20 Apr
 2026 17:00:57 +0000
Received: from BL02EPF0001A106.namprd05.prod.outlook.com
 (2603:10b6:208:531:cafe::eb) by MN0P222CA0027.outlook.office365.com
 (2603:10b6:208:531::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Mon,
 20 Apr 2026 17:00:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A106.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.48 via Frontend Transport; Mon, 20 Apr 2026 17:00:57 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 20 Apr
 2026 12:00:53 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <jon.grimm@amd.com>, <vasant.hegde@amd.com>,
	<frank.gorishek@amd.com>, <thomas.lendacky@amd.com>,
	<santosh.shukla@amd.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Baoquan He <bhe@redhat.com>, Adrian Huang
	<ahuang12@lenovo.com>, Jerry Snitselaar <jsnitsel@redhat.com>
Subject: [PATCH 2/4] iommu/amd: Do not convert IVMD exclusion range to unity range
Date: Mon, 20 Apr 2026 17:00:31 +0000
Message-ID: <20260420170033.6780-3-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260420170033.6780-1-suravee.suthikulpanit@amd.com>
References: <20260420170033.6780-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A106:EE_|IA1PR12MB7637:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c214074-1ba4-4443-c967-08de9efe6447
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	rSrWg6sEDtcC6fylDL7wKUpjKsXKRr4P8XmurImq1gT5ZGpGKTEGVwhwOtm9DFfeZgDo/BohW6Rw8BTylbuSGEQzJ5pXLcMr+/B4zhtqiLqrvdwcHp9AC6dhfuyfMdfCOLhMZeZgirA4suXl0W99k6XTjDHo+09grxE+aO4YqIFQMmJsXRERSbLB4gRvTvLAfAYpC3S3ggcquiJArUmWZo/IKNtJWzXdw/hVPG8tpXk3LeGqg3blbwBn/7ongt3t4JjP9ocD/rooax3i+5YxOf34gCwFuwQWdUqvvNgNE5vrDzwlSnQHLOelAoW/1hjsRp+oMbLRvEhsc8sx5jiHU3bUxdNCH07r+npBR2gnSs/xeZUmgZA4Wj/g+x5szVVKFKElMRsz310r3Ru+m1CCF89yHxtyDMIpLL34f2Z8p1pPn2i7DeOwTaxNlOn5zk4YtLEJ699cYvEyjjsk8DacDxkgIrZ1j4SwRa30DeQ/oq4PltACro24idBiEZa8qT6UHyS25nSN2m8Nh6HzrLe+m8malrqFZp67Az5hUCOB88l8TExsURmtjrReEWIBYHWujcx4IE7pgnF4yqGjBABbLjg62tUlMhxJZb1tZ+pVRQyIlb2DZQXxE+qEunH8x+CnHMfWFtK9lEcXPTL7S1Z+NHHImP9k8sI35uV7JTX13USWovkkluDtyO3P0MgIx3Ymn5KMKM3TRO+94RHcQYNlTQPj0/U4+G43IZq6v7GHPgvzuiohfprTH9PTIdaVUambgpWVu7otwX+fM7xWkT2Niw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2fRMw6M3uv2iNUH6foYE3zDmgW9TtH9QbBAKeE1wLdQCgM7tAMM5Lp/EfXOqyAytG3l8M6LjVaemdQ6WLWl0seHhN9Q8XPYnV1iBWQGopY/+lyVyq4VeCE4VcPdTU2I29QSFDhzmHK9QDUVoxmspcr9kpPThI83ko2Z99p8B20HEXDSgVRXQFN0QQLc04q8VNSQ+kqVaivWeYTFf8MutIZC8URkN3JWlmfFnoJnz1zDCAjmyy2LfZoNROKhpgJEGEnSNPecLJfHHOF2SAhDbsowxpUFwOUKcOSYCoa+b1UaGVGgVgvNNq2h0ceEJJKzdH1h3EQMnnCJepX3Yiblgoag8dQ8WTwFBONL1i3lIDg02E+1A/rAXAPTUJAsADyUvO29hLjcbUcwKfq7ZxboCC1ABh5BmKTn1Zj1HFKBxVpPLxhuilFAiYgVPOBzZt5Uw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 17:00:57.4044
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c214074-1ba4-4443-c967-08de9efe6447
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A106.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7637

Original problem was there could be multiple IVMD exclusion entries
conflicting over a single exclusion range supported in older Linux
kernel. The fix was first introduced in commit 387caf0b759a ("iommu/amd:
Treat per-device exclusion ranges as r/w unity-mapped regions") and in
commit 0bbe4ced53e3 ("iommu/amd: Fix the overwritten field in IVMD header")
, where IVMD exclusions are converted to separate unity_map_entry objects
in pci_seg->unity_map so amd_iommu_get_resv_regions() treated every such
entry as IOMMU_RESV_DIRECT with R/W.

Since the AMD IOMMU driver no longer support the Exclusion Range base/limit
registers and rely on Linux kernel to exclude the specified IOVA ranges
from being mapped this logic is no longer needed.

Remove the special case that forced e->prot to RW-UNITY mapping
(i.e. IVMD_FLAG_IW | IVMD_FLAG_IR | IVMD_FLAG_UNITY) whenever
IVMD_FLAG_EXCL_RANGE was set.

Fixes: 0bbe4ced53e3 ("iommu/amd: Fix the overwritten field in IVMD header")
Cc: Baoquan He <bhe@redhat.com>
Cc: Adrian Huang <ahuang12@lenovo.com>
Cc: Jerry Snitselaar <jsnitsel@redhat.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/init.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 866249d3673e..2e854f4639a7 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -2644,16 +2644,6 @@ static int __init init_unity_map_range(struct ivmd_header *m,
 	e->address_end = e->address_start + PAGE_ALIGN(m->range_length);
 	e->prot = m->flags >> 1;
 
-	/*
-	 * Treat per-device exclusion ranges as r/w unity-mapped regions
-	 * since some buggy BIOSes might lead to the overwritten exclusion
-	 * range (exclusion_start and exclusion_length members). This
-	 * happens when there are multiple exclusion ranges (IVMD entries)
-	 * defined in ACPI table.
-	 */
-	if (m->flags & IVMD_FLAG_EXCL_RANGE)
-		e->prot = (IVMD_FLAG_IW | IVMD_FLAG_IR) >> 1;
-
 	DUMP_printk("%s devid_start: %04x:%02x:%02x.%x devid_end: "
 		    "%04x:%02x:%02x.%x range_start: %016llx range_end: %016llx"
 		    " flags: %x\n", s, m->pci_seg,
-- 
2.34.1

