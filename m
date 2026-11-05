Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.57
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793854228;
	b=xDXCHX5Wmtm+1O5jSMfeq/UFdAtdzHRp8+XENS2PkMbscMxBfHPUsKxlMxzodiHa5Mej
	 Dnuo1rLI98yFK/2/6C4oopiaPEYhAKkTtQq0t7aNMiQ8C69D/7gYadp4ekckVOYBtVO87
	 JecXJ6TDMXF+sJNQnHbo9Y0Ye8Dyx8N1rW/s4p6EqSymXGDe/qAcBRTciZOFnSJUN+yCs
	 mB3PRErnDl4pL5Nzsl2OoNxMSWsG3YKreWEQ+r4qhiQ2nNC9sJ80NrnGi2dFVeiA8zZu2
	 iTA4T/FrmffImMbq5QJUflxtqKvRRYSfCIFFIvzDkqI+z9iuKnmdjdPkWL2K1aaBXUA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793854228;
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
	bh=kUYUSNhB83cZ+6CVzklYQWG4hjdkfkUH0Rb8/jqXXJA=;
	b=KqZnoHHssE4WUtW8G8Wo1KgaKjj+iyA4JSloqM4KDZy+TGnrftta/em3jwteRKMwUc53
	 ucnMCLNH72BiYHN/WGmYB9EWFYvIDu3P6N1yeMwFLsnv4Qohdj1sOEr9MQFQ21HW/FZp7
	 zK0RUokBpZz9YwSR0YwqiEyglMCAL01oOn/n7grOv1ib/izzGkUKiAgWSSSm66mGR6BcD
	 7nnRT+YNivF5psSczS4VRE+xwbQVKpHTAFRXtEe9KuugKoWaC3pZjAe8LSiyCqJX1E80G
	 qpTzmMgVKFeOXzFmBEI0zpcNXuI4Xaq2jwVfHBzvooDTLOH6nUwC5N+3eO2trwvidTQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=f3DIiT8C;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.57
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013057.outbound.protection.outlook.com [40.93.201.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCC2606A31B
	for <iommu@lists.linux.dev>; Thu,  5 Nov 2026 04:50:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0CCC2606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=f3DIiT8C
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KIBIX4Dd2S4L5AE0JXZqCiXVAO1WLSRKoG0jIPfpj2P2A6IxuXGJ3ANk1OB1akj7DNT2bkT07jw5If72Cg7q1rOsoeIHNgVa47xGOF4rSKttLW0bBMfDfOHmg2/mD4Od5Bacfhzy1eCUj13sp3DTAdrnUPs+pAp58JAlTW8xRng5lRiq/K/dCancVA7q+3d2vPf+nMIVpE2pCFO5y07+UFIDwixK99x8k4wqgeEvkLZSEs66Yq7eniWuOquBI95H7UxXswXYXDVnuYgFGqQJEsZyoQ2xga+Hhq+MnO3fgCCPIsl5plmTh/6hNmkgUIx/ZKWUMOGyyApzn9lMjmImHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kUYUSNhB83cZ+6CVzklYQWG4hjdkfkUH0Rb8/jqXXJA=;
 b=YDMVUHEKR9OjiBwMcQADntX2CM3+Gw8fz5Rjtb8JMyVZdHDNbBPyHe36H9o3r0hGMge3a9HUDPNZChYuVoO7HpUqZYVH2PRc+m/9YuKf9aHdmOE4YCvBzbDID80iiQ3m7kjGBC0FIatt/ZiBNz/0HCRIsqh4YWYs1w0nopw2tTRWbBvKrfPvj3xb2snjfvPdTMijxtDpp+vUKaaJStbcyY29d0w83eK9W28sQ5tfcfHCNuoG2UN1DHUZCWWslmLlvX/AkPAFbAYMeROQs9GpkWCajqB4yfCHEj2KqAfrC9GRBpiYFxMqOF47dHB8ZKTec/MOiFzbMliBhKWvua9SnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kUYUSNhB83cZ+6CVzklYQWG4hjdkfkUH0Rb8/jqXXJA=;
 b=f3DIiT8C/vpNIBFrjqSTlq3kO3viJjdOAHVqQVHcGH+xfVYPajaInP5q2Gmjk47E7JA+z4O1OklCmdZcA2ww+ewTRNCYbOHrXr6csnXppPLvYlM5Df8cMf6hsskg7juZnvOqtK7Is78aS+OiAYhNn6RehQyTmrYS7wVGQQ4+XQA=
Received: from BN9PR03CA0862.namprd03.prod.outlook.com (2603:10b6:408:13d::27)
 by DS0PR12MB9321.namprd12.prod.outlook.com (2603:10b6:8:1b8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Thu, 5 Nov 2026
 04:50:22 +0000
Received: from BN6PEPF00000072.namprd03.prod.outlook.com
 (2603:10b6:408:13d:cafe::6c) by BN9PR03CA0862.outlook.office365.com
 (2603:10b6:408:13d::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.9 via Frontend Transport; Thu, 5
 Nov 2026 04:50:22 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN6PEPF00000072.mail.protection.outlook.com (10.167.248.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Thu, 5 Nov 2026 04:50:22 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 22:50:19 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@nvidia.com>, Vasant Hegde
	<vasant.hegde@amd.com>
Subject: [PATCH 08/12] iommu/amd: Discard partial page requests when the PPR log overflows
Date: Thu, 5 Nov 2026 04:47:57 +0000
Message-ID: <20261105044801.399466-9-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261105044801.399466-1-vasant.hegde@amd.com>
References: <20261105044801.399466-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN6PEPF00000072:EE_|DS0PR12MB9321:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bc9448a-75a6-4aab-59f3-08df3af84c99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|23010399003|376014|10067099003|22082099003|18002099003|261102123227099003|56012099006|11063799006|261022105027099003|261028144727099003|261009223027099003|261021121427099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	fEe4THYQ3BJh5PCT1kRJvvLkZe1v39GWb5GbRFC2FzERDNNsYCQW2GPMtP+eiBGT+GGsqlqhanNJ0Gwp5qOsrqvj5/atEcE5npuRaWHVDQ8+brDxFAHHeKsZehkFqxuKPhpFcgFjiRPlTaVDxlyqbIIUfGGujafR4fIEg//TTMq9NVz0+n1+gTSU2Qk7YuBOXtdO4gl9XibxAxrrIf4RltKOYSZjqQyghkxvpxA6ZJ8e14zrtKd0u6qxN+NVSDKvTZIAUY8B3ZDQyyKPpQ7Vx4RNBLaCxId+XRuPlZBj+Kh29nMX66MEbci65ep6S0F23bhoHXOCP+6deT2ve3VwrfFldSe4yT4/2hr4UoK+cuLfKHBfFDoPQOIv/VJZ31nwVREHA5MIvyP2AZHfBD1QnFktDTHP36t+GYa1tOMzDXNttlf8moiD64VrL1kCIc9cRo+jWV0lDBN3PeAfqDyeKB5SQmu+0F2ZICBM0E6sVsuMT4JoTwZO1gnWZv1I+wPtEGQkbSFFJFGonmqhSMxgzNe6XLtE+Nwxx8uqJXhRY7H2vYCwoE/14I4Qi/oUZgv9LuUyWR+D41waY7jTz3+dSUJtO9Pp3EGfy8QQfn12srxbks+QZqBqEfHtvi89i4/Sm6LqqFx0FK7RB/1WilGEE4maUo9VKY3nQa/jLAULDrreSTb5XiEdBggMsre5nwQNpYj/DhOGOudfSdXGIlDn0Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(376014)(10067099003)(22082099003)(18002099003)(261102123227099003)(56012099006)(11063799006)(261022105027099003)(261028144727099003)(261009223027099003)(261021121427099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	gJccUECnU7ewr5m3TpQ8N8fu4Cb9eqSZLXXrbw6JYpsWfRgrQ04LyIQW/cGPjhWxYm3Hd+mftr569A9bmy4Zbd0IxOEW9oTtVZZL6cxlMSEE5hThNo8ku25t3y/Y0HTY0g7hGTqiigtMilNUPNhSOulYPFqsOlztmMWizhkC53wVURpZF6WlN2u8LB3o/Ca0Zz08cGM+jg7KsIjfFoqO+kSjePi7h5U1S8H2eyYf1/ZV+4kCbYavw5du4zLnjdyve9cHG9wyBF8kh6Vb1yljH2HTYVGBgHc4/psIldq+WQ0GFWLz9wNQmYHCZ4bauLxSEn8Grozq8FFjEaEU9BLhJGuLrqHo97E86QX1ucI9nOhwToDI04BowcV1w2vlUYY9/MSmn4Pgo9Ga+5/IbfU0LPiD1oTXneGpw6mX89atvsRrh5QUGf4ULUHPW6fQZdRI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 04:50:22.0891
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bc9448a-75a6-4aab-59f3-08df3af84c99
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN6PEPF00000072.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9321

An overflow drops requests that were not written into the log. The
IRQ thread consumes what is still there and then restarts the log.
A group whose last page was dropped stays on the device partial list.
The next group that reuses the index is merged with those requests,
and the partials remain until the device leaves the IOPF queue.

Discard the partials after the log has stopped and before it is
enabled again. The handler has already polled every entry that
survived.

Fixes: 978d626b8f1a ("iommu/amd: Add IO page fault notifier handler")
Assisted-by: Cursor
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

