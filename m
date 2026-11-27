Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.37
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795779332;
	b=3Whh/neaZLRCVIrJNyhJcwIBrh4eF0Jlx4xRaZAfoxEbsq08ayoqCAyCLVj5G/U+C6vf
	 v6Nv+luMzekaVUo3NzcrhEoUpbBaKnLvP77TMhuCgsrvQCnavyDgBMX7wkzqusayO5coh
	 3JULzOVIrgNq1ipUpI3ok+iimtrIzwgR48ZX5VXYy4ZRyLZ/p72jJ8hRVb9dTHg9MX3w+
	 WGlO9LHmOnnqYpsGhh05JRQI10ihnOESQP4dpq/dEFnKs6u7RyHQoXrPSEPRPJMl4nJD5
	 XcEi4b4aCLjvJKxoXzQkUQAsg6rsd4FaT1JvqG17wFyMVh54UgUTix/Gt0HeWusahaw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795779332;
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
	bh=EQJuHYM9IIQ9VuEFE8qKCJ6g5qDilBQbk0QM5npKj98=;
	b=hTXqb8oPb7XNET3mIrNJo8tL4qbmoC2Ahm/FsaM+TkhtL6PRytkCct7omrD6DBnNz0vM
	 BpjZUOePNGDCPlltNMhgxf+6hfsLmuHeRExFadVW/2SJS9KJYB8j4gR5dcnn5rkvr0FPY
	 G+RvSDKUAiTa68G9Zw90G7sDoHLTv/mjnOqBC1T+Kxy13EjZ4uaBxTl3mdPq3fGhpD4Eh
	 ndhyA1s7arkB6vMdTXWLVeL061fzCKisXEJLDK5o1Acd4/DwQKwBOpKSGJM6U7HIR6Hc/
	 O8sRKndX67REysxYUtiaZaGLRdBEl2bHBAogiokqwOJKfBrlLpf4B/THRjbiw4Y+XTA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b="w/JUaEBc";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.37
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010037.outbound.protection.outlook.com [52.101.193.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6071606A31E
	for <iommu@lists.linux.dev>; Fri, 27 Nov 2026 11:35:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6071606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=w/JUaEBc
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZQRVjkFWQayMaamH+QPnjHskZLgK46zTy1KcjvhjvM6x3tg+DRL5tFsFI4Jcyb4OE+3/V5/al9zvlcb4j8+BeTEI7EYkpDl6R6HoLI1M+aRF67pf5bL4QI9Ttk4vaOfX9ZZzen2PIS3bRCDuUy2uTnbpS9lIiKqfPd3CQKprfem1VMmIbipOzqmJ33MCu42TbFzPxAtlAt4OL++Sfnm8hX43rglbQEoaHzlI4tijon6CYLqpsM3InSxMYsthX60jvX0+9QqZ43nqmv9sNdx+6BQp5UOZEs26ZJi5gCD0TbopITHR5d53SurxbrMBNod1P2g+kivMYv+mXx1/j3Lokw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EQJuHYM9IIQ9VuEFE8qKCJ6g5qDilBQbk0QM5npKj98=;
 b=K0zz7iuJUJx/Prp+ibjYa2BaG2YBViav8dYLM6+eRNDScLdGKgsxkoZcYFuzR4cm2esK6/77KxaUt91Ws4X4gZ3yB9x3bhXP/XR9l7BnULsUSP4bWJWN4VoILxEu2oKNrMVFrCs3l4dWURF26fOD3kGZltndzi/jYgMQ9U3NFvngZ/pMjqWrmNETPV7HW+jU0DUKhFXtr8QRfceMUpimZJAPhcqsLx1xKxk5ZyqyFC+t0ID4sK77CyrCTW1lWC4RsEVIAy6L959qLM8m/YzwfGlWW5bLlTSKnVYZn+wCn6qqxAFsdiBl7gMlpfwJm452i5kEdp/PHL8I7vR6ggARWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EQJuHYM9IIQ9VuEFE8qKCJ6g5qDilBQbk0QM5npKj98=;
 b=w/JUaEBcBqBtMEnx0M8cyvSi30Ukc7KWNHrrAh+AAmwe9gAZGwhvU/14dH8OceQgatkdbdXz4RD80VbI4Epu30D5v8FFrE8zF8rvdjjCP0HnukgGY202PjkadB+H1bHFnRUeN9L3rsqkbriRxbIyINwLxP5Y2IBCUdJxXbl7VSM=
Received: from DS7P220CA0009.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:1ca::13) by
 LV2PR12MB5775.namprd12.prod.outlook.com (2603:10b6:408:179::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 27 Nov
 2026 11:35:25 +0000
Received: from DM3PEPF000265BE.namprd04.prod.outlook.com
 (2603:10b6:8:1ca:cafe::5) by DS7P220CA0009.outlook.office365.com
 (2603:10b6:8:1ca::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.11 via Frontend Transport; Fri,
 27 Nov 2026 11:35:24 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DM3PEPF000265BE.mail.protection.outlook.com (10.167.23.251) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Fri, 27 Nov 2026 11:35:24 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 27 Nov
 2026 05:35:24 -0600
Received: from kali.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 27 Nov
 2026 05:35:22 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v2 3/3] iommu/amd: Log raw event log
Date: Fri, 27 Nov 2026 11:34:24 +0000
Message-ID: <20261127113424.209190-4-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM3PEPF000265BE:EE_|LV2PR12MB5775:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bbeb8cc-32e4-4fc1-a79d-08df4c7a8744
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|376014|1800799024|36860700016|22082099003|18002099003|261022075727099003|56012099006|11063799006|261022113327099003|261026121527099003|261009223027099003|261021121427099003|261102123227099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	eyTC1mX9UqJmfn2XB9jfKsm3ijqS9xjMSzK7rWNvnUNmLc+eHkKCsJfRh4ns7sAwdtsUEKnc81Oock0kXukz/JqhppbNk0oJJyG0ypMANclKIHoCWwI6sr3HdARu90MrDTiCv6eEQWQlGWkeZSay6uLexgnccOMnmQRbqcVdG2FWxKzkWO69IRoNSkorWxadTOtOhXqVDy9YK2kPULh9+wWEnvEWWep+CWila5MQRY59yQZgzE35LIkZlfsHGZ4rHbqf4CEWA//wLpi6amrWp43WhggvS0zLG590Gp0n2g6tT9dPySsSbQGqK3VGV/j7nkf+ZjIztlAUjXnyfW2vZV41vgM0W399uvglAnnpCUHb39Uw/ZO2sT/fAD/KsXIAZLX592/W7pYHhu6/4CN8O+NPfD8WuJKaP7RkbbZCb9sDgW2F8Shp58CfeHWvTIhn93p+l9m+UdhAv44gXA1DaP8iBJJS5P2GRNjpZs54BoVr3fYwVa6TQXFITNoVm3M4ynGsMVKI+jtVwAUAVVPavpOgmao+S+WjCvvX59SZF4Z1grYi+7vnEQnip//6qIodcBBJ20U8zl1pYqGB9qBkfC7tTfTjGzPAe/8ZkZPqYyoIokBVeTWfNRjNqI1z2Ao03oGlZy+ro5M3F9xP6YfeCJkuVJS/kgJJGittewueFDj90lDMy5ZIHLiDAds30BGBCe3ywlYK1/W3ESejtb46Jw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(376014)(1800799024)(36860700016)(22082099003)(18002099003)(261022075727099003)(56012099006)(11063799006)(261022113327099003)(261026121527099003)(261009223027099003)(261021121427099003)(261102123227099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	imIgAiZmuTGmxodamPfd0wmR2c3SMHyGmY35S2biEKKCaTLRUBa4mIAGQkB69Eijm1BcyWmBwYl01NBItIXdkHu7mepWhaoH/iEJHKm4VksaWFLXBimGmnnkm5Vhk8MsZIyeWwlhsneCvpJ/Pab99fHxJp8GQfc+KJ3sg7GCF9SzxxdCTBaU1NWi0fGiavbnK9oKWUjOkdFrrZXgrRTkH4/H98goya3+xS/sKSc+E0G1opvN5LtQT+2irJHLw+ZddnvOgzxSif2//Y3nFX41x30qBfSW2uTnjJyVdE31wPWPnJLABuZbYKys/lSV0kkvoFmhhIr+3ofPGtPqOHC2MQTPZ2ikRz9tGf2bPwBkDBCL3NhyzacAbCTnftqC9zepaoFLnyG7satF2ECn+73PqW8DHfiyj0FceowyVbVxfYmqZOWkEtoYIZeYWpv+bzgq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 11:35:24.8585
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bbeb8cc-32e4-4fc1-a79d-08df4c7a8744
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM3PEPF000265BE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5775

Log the raw event entry unconditionally before processing/decoding the
event. This is useful for debugging especially when decoded log doesn't
decode all the fields like newly introduced fields.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 7259f80a36db..0b87d4252906 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -939,6 +939,9 @@ static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
 		goto retry;
 	}
 
+	dev_err_ratelimited(dev, "Raw event: evt[0]=0x%08x, evt[1]=0x%08x, evt[2]=0x%08x, evt[3]=0x%08x\n",
+			    event[0], event[1], event[2], event[3]);
+
 	if (type == EVENT_TYPE_IO_FAULT) {
 		amd_iommu_report_page_fault(iommu, devid, pasid, address, flags);
 		goto out;
-- 
2.31.1

