Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.60
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795779316;
	b=bODabUO0AmWqQE/WjVlAHmpX1PAP9GH7yoPbG5whvWDdtq4bocfYCGzvt2Uzb6YH+e/L
	 rAY3TBoA4ZipnexbeNWIZaPmxt+oAZcvsRyYfuiilmpOdDZZ3y4NWKk/DdOXJYsYkrL/T
	 ODXPbii6z3VpixCsCQjRuhCwAo946nGJ6bTtL+QiZuOdkBcdA0//6l0MwWolQETBChHTa
	 vdZWGYr4Z1KoDjJsimLZu6AQumXlkNu7CaLumf0uWz1uUckEg1K0S2gnUzQSd3g9vbuIE
	 DFmzEbm4ubdYM4ejpD1VuWOHCsA0XC8jrayng3FSuTzRbw0K8Ux7qoH9TiW+Ifrfu8A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795779316;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=akS56olETKgCx+YkeSs/yjI6WBi9V+GFFgdgJYCW9ww=;
	b=tCDtyKY16/M7+8RoYQudtQIdJ6guezrqmrPk71RKmWr4bqRK42rO/uU1XtupHOc+C+sr
	 JuVkP64rdEUYpNU72cqFhjJ2mSxNufY1tg4dKIMtAxWYfbcLSoSZq+DuDvGGbIWv7OkN6
	 8VZUwRX3kG1FzHK7M0sh5y7aW2BgBmzBzdObGsYlXYfM3kk5vRG5jzHCqlDwdjD87V2w8
	 ZDbGV5zMdLNqSAXui3snjo8ig2YsfPOs2v/43BJcgx0TN/EkklSp5ufkH/zFA01aCRgE5
	 mzdQWBuulfZe4t+teZUGqHgWu0gxacHKlGbKlly7VXiZTAG8drTVzFQdVtVNa0jSRCA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=NjcChbM9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.60
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011060.outbound.protection.outlook.com [52.101.52.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96E0606A326
	for <iommu@lists.linux.dev>; Fri, 27 Nov 2026 11:35:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D96E0606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=NjcChbM9
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HdQKxISvks6wWoZFsQQC74ffFW03xXlCRp2pRlqrImYbXcPFYPlI+pl0i254tYc0k4COVB/6c6Oq9hEJ59HfyXwDBV1Wx2p01411vrWcV/L8pRerF4//AKbPUYyAHET0uA19t/OcVCxzloDPUHhDAWIveDFGNRiRGTvhJkXzkGwz2sfBwD8/GFr2VvDexnsUYvRu4WAoCkkaPZrQ8m5QsszpUzBZYrlb+kig2HObdQdEM9dOC0SwzNQe7ztsLrrmhF/+OciPKeqUCeDpKuczMjCki/FWeBAukhtqOWKb01y5JT68JcIdwPXWkm9xyRfNe9J90MPe6rYHUgL99bB+7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=akS56olETKgCx+YkeSs/yjI6WBi9V+GFFgdgJYCW9ww=;
 b=NbxsOwbX9MpslpHawGcxTCha1zt89jx579cPoJQ6Zd2L26JBtwDgUAl6yOqR8l3aZmfVfVYp+p7dJjnk4va0KUBusgPKqL2vCDGrOIfgqecvhiXAjcBqUWfwFrGsb0AqwdBPiqNB4fEyh5fhgiiv29MXhQ6YllVvFfXn7HU45e0ojobRrbgUOUfO2CdKz/JdjHiP0buPUuASFILk5JaSVd2QIyWUdZLolWa2YPxQKcp7HSH09JTmat6n0Mspxwh5K0Son01FwLppT8pA4R+IAYrforQqgR+mjYd5AEkPlLHD2ZMgjvYresco4bHJqz0Z4Hee2zouYYUeT9Sk2LO2sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=akS56olETKgCx+YkeSs/yjI6WBi9V+GFFgdgJYCW9ww=;
 b=NjcChbM9K5fnG0pXnbC4ew1BmVxNA+TLpyueXWFmdqqP/Q1xAt5u1U5R3+51W55A9B3BZvUWqxpj0170g5T1Duv2xDWIP/w6f2KftIAg2OHyjWNiZ1OCTafLZrtJ5yvNxuJobKHf6/mfstFwahNTl6WjXwMtAqLT+iG5mRecYSg=
Received: from DS7P220CA0005.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:1ca::7) by
 SA1PR12MB6996.namprd12.prod.outlook.com (2603:10b6:806:24f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Fri, 27 Nov
 2026 11:35:09 +0000
Received: from DM3PEPF000265BE.namprd04.prod.outlook.com
 (2603:10b6:8:1ca:cafe::85) by DS7P220CA0005.outlook.office365.com
 (2603:10b6:8:1ca::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.11 via Frontend Transport; Fri,
 27 Nov 2026 11:35:09 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DM3PEPF000265BE.mail.protection.outlook.com (10.167.23.251) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Fri, 27 Nov 2026 11:35:09 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 27 Nov
 2026 05:35:09 -0600
Received: from kali.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 27 Nov
 2026 05:35:06 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v2 2/3] iommu/amd: Hold the device mutex across a page-fault report
Date: Fri, 27 Nov 2026 11:34:23 +0000
Message-ID: <20261127113424.209190-3-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261127113424.209190-1-vasant.hegde@amd.com>
References: <20261127113424.209190-1-vasant.hegde@amd.com>
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
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PEPF000265BE:EE_|SA1PR12MB6996:EE_
X-MS-Office365-Filtering-Correlation-Id: 38d5121a-c892-4ff6-3955-08df4c7a7e2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|1800799024|376014|82310400026|10067099003|56012099006|11063799006|5023799004|261022113327099003|261102123227099003|261026121527099003|261021121427099003|261021123027099003|261022075727099003|261026140227099003|261022105027099003|261028144727099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	mNLPoSje7hNMhrZjIK97l5xNLZ+mMGiNtVVMupzmPe1ksnT307FcX9OO8D3aH3pKjoO7Vx40FJB5uev/zQD4BGQECdWcIPy3ffquyWJbWKbqYRN9pml+EWjr2HS8X3X9m+vfcNruB4G9pgM60QMqsBGwaGoW/3Nn2VPI8CUx/FTsSw7OKSTNAk+iya1ubZTPVF22WFZJNoDbTFcj72ChK54Y3PL/pg2UnaMFL+tq1ehrFl360x2GrvGz8MFwwU0G3d8jau1VUq3yNr4nUJKCjLbZVXjNGMrKuWarX2sVxICFc059R7EC979CeR5rTENQJMS5vh1xWhVak8Y+HYu3LIwLEwpMxnNySYRUJUSGZkiEVCM6v6pyUinTVR5U5IUhv6sCkBttRhYUJWOoDzGrfecbtTuFd/rRorjEBwwKmllbFAeYxRVkh3pVQd8/shGJJYCnsvrgxLL621IguSy85KYMcSegShgoWsY8n04Qf5UAfsfcdgEsS2ujBYf2d2xrkZtOcx0aza5JkzK8LGpCMVUEqz7eXrR3/dxMQC04jbxi/A8ThOHbRlq75oUpzhELHJj4b8TfEgKiuWKIfdufjSuQtkjeE/fWIn4kUxHpQnB59sXey8EKJlc9R8JefSoZq+cmPxgBWZYl3EzvFNQVPbEhGItrkOchojPp/++BA9dIWfWt1N8BQ/7BYcYzC2Bd
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(1800799024)(376014)(82310400026)(10067099003)(56012099006)(11063799006)(5023799004)(261022113327099003)(261102123227099003)(261026121527099003)(261021121427099003)(261021123027099003)(261022075727099003)(261026140227099003)(261022105027099003)(261028144727099003)(261009223027099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	x+vQ46/SWWFBMjA5anybIM2XweJ8aJ4jDm9HqWAUCKydr9yMJFSrPQ2xqXFDFlJxCJkBAyPHFjG19L5QnGeKyLjqpdAPlxAscVrOo32FYzUyO/rZMtxcA/Bntmelf6XhgblW+wrkUn6akAmrwGogFeBAWc9udkyiAypI6HDcHnyHM4HpDTXrqMKh6L7tRzQOzySsZEy/RzHmQy55Hwp6qHPQAVB1y2xKP6o1SbZJ10vBEiWlqeL1tJjSq4vh6C57NT37JaVa3A7D1fjyruKa2QNuraQlk1dblBRNzwJKCVddnr10sScJOaUziifdqsH9/+vFOZo3RlWqVOK4LWg3kaJi0tR6TDTo9FORzop4vr6vou3XnxqW7wz3lkJigMiplscYcG6bRbAdsSB53ETtmkLaN7DDEDeuS/4I0eP5na04Vk0nvJLd6o8rAqCxkgWH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 11:35:09.5755
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38d5121a-c892-4ff6-3955-08df4c7a7e2d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM3PEPF000265BE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6996

amd_iommu_report_page_fault() read dev_data->domain outside any lock and
then dereferenced it in report_iommu_fault(). detach_device() clears that
pointer under dev_data->mutex and the domain is freed only after detach
returns. Nothing prevented a concurrent detach from freeing the domain
between the read and the report, leading to a potential use-after-free.

The fault runs in the threaded IRQ handler, which can sleep, so the same
mutex can cover both the lookup and the report. Hold dev_data->mutex
across reading dev_data->domain and calling report_iommu_fault(), so the
domain cannot be detached and freed while it is in use.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 9913b0108f5f..7259f80a36db 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -836,8 +836,21 @@ static void amd_iommu_report_page_fault(struct amd_iommu *iommu,
 		 * prevent logging it.
 		 */
 		if (IS_IOMMU_MEM_TRANSACTION(flags)) {
+			struct protection_domain *domain;
+			int handled = -ENODEV;
+
+			mutex_lock(&dev_data->mutex);
+			domain = dev_data->domain;
+			if (domain)
+				handled = report_iommu_fault(&domain->domain,
+							     &pdev->dev, address,
+							     IS_WRITE_REQUEST(flags) ?
+							     IOMMU_FAULT_WRITE :
+							     IOMMU_FAULT_READ);
+			mutex_unlock(&dev_data->mutex);
+
 			/* Device not attached to domain properly */
-			if (dev_data->domain == NULL) {
+			if (!domain) {
 				pr_err_ratelimited("Event logged [Device not attached to domain properly]\n");
 				pr_err_ratelimited("  device=%04x:%02x:%02x.%x domain=0x%04x\n",
 						   iommu->pci_seg->id, PCI_BUS_NUM(devid), PCI_SLOT(devid),
@@ -845,11 +858,7 @@ static void amd_iommu_report_page_fault(struct amd_iommu *iommu,
 				goto out;
 			}
 
-			if (!report_iommu_fault(&dev_data->domain->domain,
-						&pdev->dev, address,
-						IS_WRITE_REQUEST(flags) ?
-							IOMMU_FAULT_WRITE :
-							IOMMU_FAULT_READ))
+			if (!handled)
 				goto out;
 		}
 
-- 
2.31.1

