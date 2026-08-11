Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012026.outbound.protection.outlook.com [52.101.53.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DAC2E285C
	for <iommu@lists.linux.dev>; Tue, 11 Aug 2026 04:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786421407; cv=fail; b=ElMBUbNAflswsbPxCUWu4djMsOjNhIORw97NouuC3LwilWZ8O+vBts/1N+LpE/beVxrR70QxarYESH33FAkhCedR6EE1TKfJJf/LjApYikk8vYeGB7UEeE8lbtxmq1Qo1xpGDZrgYzK9AFjHJnMK+6TVGx8HO3fQrrRWbTyWPMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786421407; c=relaxed/simple;
	bh=DZGX6m7O7935f0wrrneBN4aSBbQ4Zd7bqcUNIKORF48=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O0xPJuHPjQDoS6YXajb/VfDq/dDIu33ygOxppq3+rlgRWS8e/OrgnxGCwf9kzBrOGR3BO60RUFLutd8Kskg/P552Us4jbSrPMr172MU+DjnJGJANvBYx7QawQX5oIKAzq5ugGfNLnd3BDrXll+Zo0RVBjkxM3121s683eYGXhwg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BGFK8p68; arc=fail smtp.client-ip=52.101.53.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BGFK8p68"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D+uAZIwlXzrtaQf+cJGkrciyouh0Sgv67l740UPdMKre55n9Pmr9IT6bWwugw/X4LOm45jifzxTV5xvlgsJpuTKLZKS/ohbNmuepUGEsnFsXDGk91XsS6BgViqY9/SoTHZD/SdtQqBKuQE5uXkeR78tDW3A2F0Yk2L2jL7Bp7Gb5dVaHbheBenCTihEN1x25bZRoSefB+iBJuK4bFeqbANJh6mmkWiIrINGjg5ySi5gHP/YqYoGFqBqSbLxg8ikdtKswaK3Az8N6NrUXmlbZNJS7xfB4sDujrcVPol+YawhKdXa5wvHAaFwhsnzUWEh1Qy5a5NhRl5hArv8KgrbZMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O1zGqp3Z+io/7QXnnANt4ViqRkjCDz6EUwcDHZfLhBg=;
 b=UY5j/qBgqhjJh8MtHBXvNajXEEUJuH0c/zL3rpb8mG7kRdAKAtFZdyhqwITYw4REhJ17qWhLJ/GDglSXfzA4S7nXMkdJGRD15LIyIFkELjyqOqruS2iz7RG5Qdpiv8em9/pwgyxXr3eTanquNCYJbItyojMwnKpNpN44fGFUpDmzhG1tuHHgub1r3JjqmZCH8sfUgDLJW7zx+sy5W/q20T0WK7Usx83lR2GQEIx6aOBV/8mkPuqrka9AvCddU+4DJwuErflUzOss3kK+KlIO514aWkAE7N1023ISNnPgzCnIAIDhHKT7E/MYqLzfFmh64dEgfaFPwFFGU0YwaWJTfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O1zGqp3Z+io/7QXnnANt4ViqRkjCDz6EUwcDHZfLhBg=;
 b=BGFK8p68wPeD0J26qgk0l7hrkd1vE0/FdCvXrEzuYIUjyvuYPNoN6oz3ne5KUN4akYSa6KbvL94Pplrh/c6jf9uubxensgoF5TM/ZvRSnkQZFuYDfTIm4xxXVKNJU+muWRQOo+EtD6qU1Vx1BORaUCMSD9f/joHDTsGjB+oN4N4=
Received: from SJ0PR03CA0373.namprd03.prod.outlook.com (2603:10b6:a03:3a1::18)
 by CY5PR12MB6371.namprd12.prod.outlook.com (2603:10b6:930:f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 04:09:56 +0000
Received: from SJ5PEPF000001D0.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::55) by SJ0PR03CA0373.outlook.office365.com
 (2603:10b6:a03:3a1::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.25 via Frontend Transport; Tue,
 11 Aug 2026 04:09:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D0.mail.protection.outlook.com (10.167.242.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Tue, 11 Aug 2026 04:09:56 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 10 Aug
 2026 23:09:53 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, "Wei
 Huang" <wei.huang2@amd.com>, Ankit Soni <Ankit.Soni@amd.com>
Subject: [PATCH v2 2/5] iommu/amd: Introduce PPR_TAG_LAST_PAGE() macro
Date: Tue, 11 Aug 2026 04:08:57 +0000
Message-ID: <20260811040900.8572-3-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260811040900.8572-1-vasant.hegde@amd.com>
References: <20260811040900.8572-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D0:EE_|CY5PR12MB6371:EE_
X-MS-Office365-Filtering-Correlation-Id: 12ecbad4-4e09-4c47-e5dc-08def75e673c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|23010399003|376014|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	geFKR25nzJZtP2lFQN9sDStBvdSDPf/SEOf8CrdWeXrcScle0SC3MaAWlSu7jzOaY+viuDwIvUI1r9Wh5ABVDvlUlstoO+GOFvzikjjpodm1K5ZmWmZleoQ9eYlU+kA3LKB7D5/rvETjXdb8jlcdTUWKlnOc4W5SH/bjk7TILj7D9fieRI5LT9NwUGNYKaWzDoxPbYxEJZFb9TmAYv6jrrNCfXvcMm1vrVueS4IqH6aBv+6TmweGw+UGXyXJBRHvWUkqRTVfmcR3JUlpGr2CEx+YJfBI04pflYb8yLtDFkokS3qELN3cWuy26XiUWxXJ7yzElktYHN1msI6mOjEaJlJ61cZ+UIuqRFb/s2pcLJekffTQ99I3uDGHfIMe76AiySigVV82KI87IyJ0wM1TFXNr1bONW9p2nCuGdrydybvZUEQFwkWWwwivqVssLVc2ElugiAFPEthzMMwR0xazhp0KLA+RwLFcgRGewRKpRSj0Io7G16wtIK94DFRo9NoSUgGNbHFYu4AN5qR2YvlEF4Mh2g4uV/NwIoBm/1OdHrLxjTEKNw3HMg5/g2k/6bS2nFNAtWYWDryJcAGgJKB0F17q2MeVYbewUpftE+YGxO4pxEtI+FKfY3oaA6CQ0xMcMs58w8S92iu+Mv/7h/9IRqIzBhnqM261rv/V6BS5dAN7X0uFBoP4kM1XqIuspmHLRJd8Cji+kmozARkBCaoIgA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(23010399003)(376014)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	kQIE6xd7oGIzDE5KpXc6ixLTqsMb56f/r4pglIXQxqV3yI5dBeAiHGdwbkVk9SE8QaT4cS5OywXtkYzEzuEqnKUevKUmoksSAbrTa6o4LeneFHHpi4IbWUKlDWEngLSYAtOQ6bH9rdd+rPlmw+CrEQUOpCBwhT3/HLRIgnSjeF2TUfsWZ99YYsjN77AH/eBAb95jrjzhRxH1cFoW/8FRV+HUh+/xet5H48en0bhDwnWMk2xSmHj+rwn9npDYJcILpECLZ7eS8mTn7VUqPUpGzTccSR/6RLKEabAL3pdSiaPEu5os7bgbrbzbPzcc90D7WjlIs0J584hLs+AamMYkmW9ogyZOAkBx7RgLJMbhOJfYrnEC6cP8pH7ghOD5iPAhUMFdafSd0ceeEpKmyCDjvxZOJfSWQB8iix6MY2/xi9FGhLwbdfftKcU7GYXa0ifW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 04:09:56.2949
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12ecbad4-4e09-4c47-e5dc-08def75e673c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6371

The PPR tag field (PPRtag) encodes two distinct fields: the 9-bit tag
value (bits 8-0) and the last-page indicator L bit (bit 9).

Fix PPR_TAG() to mask only the 9-bit tag field and introduce
PPR_TAG_LAST_PAGE to explicitly extract the L bit. This way it becomes
easy to read.

Cc: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Ankit Soni <Ankit.Soni@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 3 ++-
 drivers/iommu/amd/ppr.c             | 7 +++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 3c292fdfa95a..a7aa9411b2e9 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -280,7 +280,8 @@
 #define PPR_REQ_TYPE(x)		(((x) >> 60) & 0xfULL)
 #define PPR_FLAGS(x)		(((x) >> 48) & 0xfffULL)
 #define PPR_DEVID(x)		((x) & 0xffffULL)
-#define PPR_TAG(x)		(((x) >> 32) & 0x3ffULL)
+#define PPR_TAG(x)		(((x) >> 32) & 0x1ffULL)
+#define PPR_TAG_LAST_PAGE(x)	(((x) >> 32) & 0x200ULL)
 #define PPR_PASID1(x)		(((x) >> 16) & 0xffffULL)
 #define PPR_PASID2(x)		(((x) >> 42) & 0xfULL)
 #define PPR_PASID(x)		((PPR_PASID2(x) << 16) | PPR_PASID1(x))
diff --git a/drivers/iommu/amd/ppr.c b/drivers/iommu/amd/ppr.c
index 1dde19a79e80..76296079bb8b 100644
--- a/drivers/iommu/amd/ppr.c
+++ b/drivers/iommu/amd/ppr.c
@@ -130,7 +130,7 @@ static void iommu_call_iopf_notifier(struct amd_iommu *iommu, u64 *raw)
 	event.fault.prm.perm = ppr_flag_to_fault_perm(PPR_FLAGS(raw[0]));
 	event.fault.prm.addr = (u64)(raw[1] & PAGE_MASK);
 	event.fault.prm.pasid = PPR_PASID(raw[0]);
-	event.fault.prm.grpid = PPR_TAG(raw[0]) & 0x1FF;
+	event.fault.prm.grpid = PPR_TAG(raw[0]);
 
 	/*
 	 * PASID zero is used for requests from the I/O device without
@@ -146,7 +146,7 @@ static void iommu_call_iopf_notifier(struct amd_iommu *iommu, u64 *raw)
 
 	event.fault.prm.flags |= IOMMU_FAULT_PAGE_RESPONSE_NEEDS_PASID;
 	event.fault.prm.flags |= IOMMU_FAULT_PAGE_REQUEST_PASID_VALID;
-	if (PPR_TAG(raw[0]) & 0x200)
+	if (PPR_TAG_LAST_PAGE(raw[0]))
 		event.fault.prm.flags |= IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE;
 
 	/* Submit event */
@@ -157,8 +157,7 @@ static void iommu_call_iopf_notifier(struct amd_iommu *iommu, u64 *raw)
 out:
 	/* Nobody cared, abort */
 	amd_iommu_complete_ppr(&pdev->dev, PPR_PASID(raw[0]),
-			       IOMMU_PAGE_RESP_FAILURE,
-			       PPR_TAG(raw[0]) & 0x1FF);
+			       IOMMU_PAGE_RESP_FAILURE, PPR_TAG(raw[0]));
 	pci_dev_put(pdev);
 }
 
-- 
2.31.1

