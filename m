Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793852696;
	b=qQkZF1JdlAsU4pBvGDHChKC+C84uDxVr0spsy16odDL8oZiYrpSJWFIL69dwlkJHQbLW
	 LsUUQ5mjTUQ2anp6FtSZj1w+GWwEThRJmRJFMsiywCM6WoHM7Uf0DLziI2GHeo2L0Dyqj
	 GHxPL5dUfaZfdmtmmQqpoOKiRyO+QNJzfbwZFRtqNinR5D+zxCdcJUd2zvuVPG4lL7FzI
	 wX4S48SC3c4keu1vr2jGt2BwGCDqKp1f6jXOKlV1OTyAWLLHbvkkbCM1FXaCtkv7UaN6p
	 wMebkYOpOvRk30SSz+8Q+MVS5Q/1SbJVGp87VVq0iWgKQnqEbJcOituZKv5031r427Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793852696;
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
	bh=KwgpaD3glwhu/mC91TvL8s340bAdokyDVMF7nb06k18=;
	b=khBRcbwOMTy87QVx0M69LF0XciUjLPxS2q+UW7HJUn/2nbeh5D7aJV9QllwVtzHx0o8G
	 vofMFT0wZb1wYOO4xgJjKcn5BrYfuxsvxfuPFhtZpD+pLE7hJGstmN9H+ToXCkC1Ywd6e
	 XHINgYpT6WDolw6dIuwupo+FIh88yMBlbLc6/NaF07wDT4weyuBXXkr7WKy+4UH6jrtBD
	 UTI6o9CgAN7/zjjWV8+Sivk4wcbjibmFUc1mbKEpUyoaHInc2czSnpT283WUtMWe+oCIv
	 nAk/skF1e1IUmbmo8pyjNe1R3WNz13Uc9qhFP6ewwt8X/u3jDd0FLstqhdlFrb6Rxpg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=esatAP3X;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.15
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012015.outbound.protection.outlook.com [52.101.43.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A7E606A32C
	for <iommu@lists.linux.dev>; Thu,  5 Nov 2026 04:24:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9A7E606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=esatAP3X
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SO6mPTRnFUk7/4tSCQtdunVsvL4mvptC4BXjSC4n3R+sL8BEVlCb+UdcPExU4jKxSF7EC7LKEsgKr46kl7IRJzEEP6E++YuWve/stx5AjMs+y5XY/tf7KgF9iasMHPC6uedItX34iCeiJmjI7F87aoW0wD+HHja73v8s5QIhpFExOIIH7fo+wXmxl9Vsm+cFrL5NF+5LWqJEDJ47OEowDqvd0yu6YaoCao3t1B7HklYnVhOCNwa9oeqw5Fqegm9W+5sdOjIZdsl3c3aroCh3XRsJc4xrpB1qsRTgGKQAN3VQNeo8Udzwep5VmFpYCleFuL3RieZ5wE6Wxyir0RpsHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KwgpaD3glwhu/mC91TvL8s340bAdokyDVMF7nb06k18=;
 b=iUnq4Zb4ZkqcX7NVkLNOiWLVT3TtXwjQUv8nmVVoMh7TyhOKIpPamycDCYlrS4SRmQSn2BswdODUmer/rCR+ckRv8OosI61npP05rclV1UBQNrguLcg+20NdIKAbkTVEtg+XbFHlbaD0x5nBZlF4lNi6bDlcYNkGNYSHGgQn24uQ1I8WEedU0ZqGneEi69sWYRpw+JujKl9tCH3auvEqFfpOSe9ftMLbix88EWsrcHECNZsU0/Ls+aQUQVHLixKAVk1IeAvh44CMDj5MpvrgAUWy9cgOBi5SGbC7AkhYCGiwcRt45UWVIDMmAGMEc0CwkWbloUTt0kiJeh+LM6dl+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KwgpaD3glwhu/mC91TvL8s340bAdokyDVMF7nb06k18=;
 b=esatAP3XhDMM9fudGovYHPuQ6fPCefg+axqS/O3MuyRHGryMOOTVojk12GjpRGA4ar17qeOtaiRh9XDLVX7FqODkd7Mj6mAcv9SDEPE1Hduhc5vZ8o2ofX5WNuI2qYStN449ZuOsqF7UTWOkGyxqN9ClFBPATTiwfgrLmmqz55o=
Received: from PH0PR07CA0010.namprd07.prod.outlook.com (2603:10b6:510:5::15)
 by DS0PR12MB7727.namprd12.prod.outlook.com (2603:10b6:8:135::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Thu, 5 Nov 2026
 04:24:51 +0000
Received: from MW3PEPF00001654.namprd21.prod.outlook.com
 (2603:10b6:510:5:cafe::77) by PH0PR07CA0010.outlook.office365.com
 (2603:10b6:510:5::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 04:24:50 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW3PEPF00001654.mail.protection.outlook.com (10.167.249.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.0 via Frontend Transport; Thu, 5 Nov 2026 04:24:50 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 22:24:47 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 6/7] iommu/amd: Update device attach state only after a successful attach
Date: Thu, 5 Nov 2026 04:22:53 +0000
Message-ID: <20261105042254.399163-7-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261105042254.399163-1-vasant.hegde@amd.com>
References: <20261105042254.399163-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: MW3PEPF00001654:EE_|DS0PR12MB7727:EE_
X-MS-Office365-Filtering-Correlation-Id: 58d56861-7d11-44cd-4dec-08df3af4bbd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|36860700016|82310400026|376014|22082099003|18002099003|5023799004|56012099006|261022105027099003|261009223027099003|261026121527099003|261028144727099003|261026140227099003|261021121427099003|261021123027099003|261022075727099003|261102123227099003|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	whet1saR7J1FNnOJ/qcIRLy+cZL8IiI86H9rYAggV33SryNZ1CcRxq965T1FDmaZjhPyFt6s5RmWtE5GsdMC58oDKBkFgvgwf87PN0gvfKk5ahTBHiM47iA7eH6kSXWyQNcPuV/xtdRcS1cLjynUjMV/6CvX1oNXFaY7H/DjzkYA8JA7duc7LCfcXVPnshaC9fUnZnSjPghhldGlWXw0mDqLjZmNQJ6OyQesHVoYD0s/OjibU2wTYISlt54v96JwokXsxGjf1AAayNk4VLzVY3Qthk40lzW4n/aEyRaMCEqy2oeARp0R8uSWiB8FpXl/c3BJfMNGMshxKWKXAFlgv++m6liAfPdUiQEakfgVH0jgzOc1H39llOSuHMY/FVu9HOn9zXbeYeP3LEzNoxu26xXtB8Y0Spwmv5txoN8fKNvvsQEJWfRLdW7aguV/rYj46y269ZgkIfahDmhxmFYnyrFwbkbV1mB7mXLF2En6zmbOs1vip/pVK/g7Lf5m6TS07rzWEcJrXah9Zm68bMzkS/UtU/uG6eVMspCP1B00Kqj4aOysehZFNbiQPzpCIzipzxv++4d10Ywv8k5G0ffRDVpViXCyfGIGkKkpcyQ+aKk5FgOqtGBySbvC11qnKpCCODayttC6B/dlpjo22WLgprwfdqY6V0WqcMjKMnt1upJlPUAcoDaYUq8mROozcnYnF+at2uNhrrwEftz6K69L/g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(36860700016)(82310400026)(376014)(22082099003)(18002099003)(5023799004)(56012099006)(261022105027099003)(261009223027099003)(261026121527099003)(261028144727099003)(261026140227099003)(261021121427099003)(261021123027099003)(261022075727099003)(261102123227099003)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	y4sUFmRDs1czu+g55eVAYC+gJoHZpD5rTGl96wPW6NYCTmhtSCawJXlsqnBqGWbMMnryTMXntE6VUjkZXam0NuJ2XTEOGbcvSJ/fNMdBnK1FdhmHlRGNeCPjA5saYWeF71f7solJniXxZLKGjaUIwEYskHY/AIeoVwtGmPAOD2kdG/GUrIfYN5YVVex4ESeR1MgygDF0J13wcXfNIcjla54rSiynsCUXR/8Xlf7K0Y2yNYTK5eret2ErftJrqiUfZ0V1x3Rt9Yn8F1A5KRuM+xu/iHFktUjQY9NXV6R8uKXdSJVAI7W6zOZVRLbFJQ/Z+ajB0eDa8xxpf4KH1ydC5JHZsKUIUXbceYL46KP3l1xpZvtzh31UzNvbCgQ1oSgWj5tCigEx+Y886EBt1LfnxfPfbNBM8oaVlC4zeTgboyCsdDYkQIhoPDzhesMD4D58
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 04:24:50.6183
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58d56861-7d11-44cd-4dec-08df3af4bbd4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW3PEPF00001654.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7727

amd_iommu_attach_device() updates device state before it knows the
attach has succeeded. It clears defer_attach up front and recomputes
use_vapic from the new domain regardless of whether attach_device()
succeeded or failed.

Nothing relies on this today, since the core re-attaches the old domain
after a failure, which recomputes both values. Still, update defer_attach
and use_vapic only once attach_device() succeeds, so the device state
always matches the domain actually in use.

Assisted-by: Cursor
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index ed37d924fb4d..ff5b6abd6503 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3209,8 +3209,6 @@ static int amd_iommu_attach_device(struct iommu_domain *dom, struct device *dev,
 	if (dev_data->domain == domain)
 		return 0;
 
-	dev_data->defer_attach = false;
-
 	/*
 	 * Restrict to devices with compatible IOMMU hardware support
 	 * when enforcement of dirty tracking is enabled.
@@ -3222,6 +3220,10 @@ static int amd_iommu_attach_device(struct iommu_domain *dom, struct device *dev,
 		detach_device(dev);
 
 	ret = attach_device(dev, domain);
+	if (ret)
+		return ret;
+
+	dev_data->defer_attach = false;
 
 #ifdef CONFIG_IRQ_REMAP
 	if (AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir)) {
@@ -3232,7 +3234,7 @@ static int amd_iommu_attach_device(struct iommu_domain *dom, struct device *dev,
 	}
 #endif
 
-	return ret;
+	return 0;
 }
 
 static bool amd_iommu_capable(struct device *dev, enum iommu_cap cap)
-- 
2.31.1

