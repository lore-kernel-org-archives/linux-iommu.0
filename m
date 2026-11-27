Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.16
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795780680;
	b=nlSxMf2RiexM+EYOfrXzcTylXKM2bmnTvzHoEGb1sv1DlwU9WW8mZHlpzO76kZgzng/Q
	 fBoutRbur+GuYJQMoQR+o5J2hQ7gM5C0SlM01MJSb9GGodfxup3CsbN2cjO15VQrQmwS6
	 3f2L1eus4D8/6I8R3h0iYpDCKajy7J6Rw1qMc6sJt8uhWh/MALFzAy7FxTZA8YWkvRx43
	 lgmr0krRnFrn7miIb8UTRiamnB20NaMHOlGlVYax1USH3eD7/Sa47tW1kJXDtZysQE4ad
	 IvKJPVgtDxo6s+Pvb1togi/ZjlpClewBv3Pg9zZ3bjH6fgu+TkL3Hak+vO3jYsSvc/A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795780680;
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
	bh=3sEcyYrDBfOwWJSUPmjqj/4QiQEKxUPpP61adJxFqYo=;
	b=PP8U7aJSTcF6zilqLIRp0ytjxaekFBL7hgeggpkbv7rHCn47M8diWlWGORkwXlGLAgd4
	 G9slLmgscYusZtFM6iUixf+OCr4pZZ2kNwmJ5Q6IbEJPYKnD6xgzqii56TjsrtOlSowMp
	 iYYMkq8S3QuM7SkIFy5nSj11mKmqNxq9DKqF8Ur+DUUab8TUuzD6jtlzHZIZ+W89Aunh0
	 B8+seVsYxE9z4YCcaa57Y4JinlvHkeEEGs9rCmSGkWvNx55Xw0c431WLBEiN9kzxaT3Gd
	 4IjiKeS/i9myA8w742EA9PeO8btPA1hOrNJIyBNLq2IHAOJAY8aeTLwbeHkG9HycdzQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=q510ciwg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.16
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011016.outbound.protection.outlook.com [40.93.194.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7064C606A32A
	for <iommu@lists.linux.dev>; Fri, 27 Nov 2026 11:57:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7064C606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=q510ciwg
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CFZyoZl6IxRNgIVpn5uKio3d82l7OOsKsqE/53tmYlN0/qnX/PUIfooe1zSr2azNJwxxxgWJa6NAEQnEMwrv6qv+/zIWdoJ4p7nbGYggNPlXOlrlmeAKqkHohsVAqvrerzv7GaLHTF9l5OTZsjRga43/GMFr4Ry4Sb2a1RL7zimrNUV3+4K0ceD9BlCX6hnlv9ogVrJZKGECQn5r8ovakSL1J+IeC46CAwcFErgaM0OIpiJ/IdkokHkHbywNIrGa+nvfP04bFb9FQ5mLj3fib48/5idt21VDOdXeRoemUQGQBQzkNkELUUo4TRSrqcFgAIVvxiyVm0vhdsAidaMjJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3sEcyYrDBfOwWJSUPmjqj/4QiQEKxUPpP61adJxFqYo=;
 b=sZTTd4a1DRDe7PtffxFc3i3EKFUdFtz/Uhowa+qcsawf03aY4uduGJ0YyiRMWOXqssSaO1A7aNK5OMZLtlYjS0qegymx8vLoxc5gToDjw7xhg/4wnI5gIXXbCpjDIQylyweC6KIKHd7mYUpSOxPhttp1z9kFRVBVkbyLG1lUrIxlW65lnTpixPUvqLMD9sU3iYsar53pTnUPY1TN1DCm9PZ2+5zIiejljO+Lyog/htNsQT8RstBhQJ3qqedDef6CR745GXaEXgExL3cbGJgYOhYGmzvltVSKLiDUALzxjBkGgp+ZkIgUcJ3yp/N3mRAc91remtBg7yvvh+Pl3dGRTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3sEcyYrDBfOwWJSUPmjqj/4QiQEKxUPpP61adJxFqYo=;
 b=q510ciwg2qb5nOiyDUDNZs3b0J2MEKbFlTY/B1Z4+xth2lfzVz6TYwU87Y+mBiDLTpiso8cpb3UVk1paPw9RpfRYBdQlnU3dcoxpuPsjtZX0wOH1NxF+7zC4VF7Li+DgtQHcynKE9ugKOwHjWnzmrpFinPEg+lulkykdinJuoVE=
Received: from DM6PR02CA0168.namprd02.prod.outlook.com (2603:10b6:5:332::35)
 by SJ2PR12MB7990.namprd12.prod.outlook.com (2603:10b6:a03:4c3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.10; Fri, 27 Nov
 2026 11:57:54 +0000
Received: from CY6PEPF0000004A.namprd03.prod.outlook.com
 (2603:10b6:5:332:cafe::b) by DM6PR02CA0168.outlook.office365.com
 (2603:10b6:5:332::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.10 via Frontend Transport; Fri,
 27 Nov 2026 11:57:53 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY6PEPF0000004A.mail.protection.outlook.com (10.167.247.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Fri, 27 Nov 2026 11:57:53 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 27 Nov
 2026 05:57:50 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@nvidia.com>, Vasant Hegde
	<vasant.hegde@amd.com>
Subject: [PATCH v2 08/12] iommu/amd: Discard partial page requests when the PPR log overflows
Date: Fri, 27 Nov 2026 11:54:43 +0000
Message-ID: <20261127115447.209792-9-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261127115447.209792-1-vasant.hegde@amd.com>
References: <20261127115447.209792-1-vasant.hegde@amd.com>
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
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY6PEPF0000004A:EE_|SJ2PR12MB7990:EE_
X-MS-Office365-Filtering-Correlation-Id: a2a9081e-5013-410a-8676-08df4c7dab07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700016|23010399003|82310400026|10067099003|56012099006|11063799006|261021121427099003|261022105027099003|261009223027099003|261026140227099003|261028144727099003|261102123227099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	FxLir0F3H44EUmraMefW/DHrW7Xngg1am8+uWyXgUeIFJ7mo3fKvgJQIPC21JLgBgoAAXc7sSxEFmFFBOb2y0zWS+/Jx68SdEqf5daHvDFzpgb1LySM2JbR/AAjeF1XdvFAXuAIoMgkLf8KXkeLkvVKUfVRrXuQ+scVKCHweL7aj9wEYpjf1y7OPcmGQNo8WUcIsO93/cUyEVsXtnANrxMoAv15qLYE/2jFFSv0Kblqf9nPKxmSMoaZ5vcZSTzCf8DSAZRMhrulc0Can+FPNc3P/pAAhNN74cCFsEc7goaVaHhy4rL1BYJ2PMGBf4LyPC0mbwCMNAxT2dqRgll27IK7YXRcxpflV8Sjn2p5SktU2b6RZS0oYxCjkju30S/EJpIRBJYx35xVrYoiMmJduud1L/rFF0Wm5vBPdmzOrfTYsiInDVZ4Sp5uzbL/25lPgF3cKNDq7zEjhmhJLNHjarqSGC9xSWXM25jOlbbOObKoIfSl5MnIzfPo3QQrir6CYcZSkFBOgk8Vo1mll7UgqFZ61V4ryt6BptA9kobNoo2IxCbG1cU757S/tx+IQimfMQjy/rgcqlZhi4uBOe3RiYOW2gQCCE2ZowEsVkr5YpGGCZfrrlYrlxe1mM3L+DwUOb+RxTYO+9H7zhpKIz0TqgbAdpaRcAg0zG9Pc5wKGbOEq639mZTnuVR6MxL8aJdrPYj6OYJsmkw5FwWArKHZsWg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700016)(23010399003)(82310400026)(10067099003)(56012099006)(11063799006)(261021121427099003)(261022105027099003)(261009223027099003)(261026140227099003)(261028144727099003)(261102123227099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jhXIUyqWNlKunU2gtMofm50iBoX3BHkL2njslP0H/R/7JA8RddBxJcd4SQHQ35tbB2ZsmQ8NiIjYGz1zS54Z8XLSoLG1HYfuFRNVx4zEOnzG3cPiDzMkQpRPSnUd7vp7QFG9v3R1JGYb0ySWW4mPQGLONK7X/jN+s6NDWC+bNanV7xDe+fodraHQ3mKWzhqo4/6Qmid10wm9wEcH8fTAGx8j6M6tIEqjRHN+e2FeWUrQl6aaXT5ZWuU0uuALeyMlQ+/jqMb6jSmnBQK6MjKdCzeac90g4RR1ISftMcg+7s98HqYYRj+Cs1rIwury2YCPFGexyRpGrteVriMr0KyhZyYpqHWQz/UOUTJAEFLRU/7nr/5+QKpNCKdMeA/cPRy/pjGr8Hnr4mh90ApzFfN+giu5G0wAbhqnj4P2tKDbxYmeMwgJc05uHDDnOEHduOif
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 11:57:53.3029
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2a9081e-5013-410a-8676-08df4c7dab07
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY6PEPF0000004A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7990

An overflow drops requests that were not written into the log. The
IRQ thread consumes what is still there and then restarts the log.
A group whose last page was dropped stays on the device partial list.
The next group that reuses the index is merged with those requests,
and the partials remain until the device leaves the IOPF queue.

Discard the partials after the log has stopped and before it is
enabled again. The handler has already polled every entry that
survived.

Fixes: 978d626b8f1a ("iommu/amd: Add IO page fault notifier handler")
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/ppr.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/iommu/amd/ppr.c b/drivers/iommu/amd/ppr.c
index 20ad2e46b240..795e31735fea 100644
--- a/drivers/iommu/amd/ppr.c
+++ b/drivers/iommu/amd/ppr.c
@@ -59,6 +59,21 @@ void __init amd_iommu_free_ppr_log(struct amd_iommu *iommu)
  */
 void amd_iommu_restart_ppr_log(struct amd_iommu *iommu)
 {
+	u32 status;
+
+	/*
+	 * Overflow stops the log. The IRQ thread has already consumed
+	 * the entries that were written. A group whose last page was
+	 * dropped is still on the partial list; discard it before the
+	 * log restarts and another group reuses the index.
+	 */
+	status = readl(iommu->mmio_base + MMIO_STATUS_OFFSET);
+	if (status & MMIO_STATUS_PPR_RUN_MASK)
+		return;
+
+	if (iommu->iopf_queue)
+		iopf_queue_discard_partial(iommu->iopf_queue);
+
 	amd_iommu_restart_log(iommu, "PPR", CONTROL_PPRINT_EN,
 			      CONTROL_PPRLOG_EN, MMIO_STATUS_PPR_RUN_MASK,
 			      MMIO_STATUS_PPR_OVERFLOW_MASK);
-- 
2.31.1

