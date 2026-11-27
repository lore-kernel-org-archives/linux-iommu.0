Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795779992;
	b=4iJn3NgZOIVYaxqI7EuP3zWUTP4diDvVzOfxtScxWUFIieWr+3c/XYwdBWAdDXxu3yHZ
	 T3eTYloNr5KDPz8iY+OMpCS6QowaocFhTQlyg9hp5rTs5NpAo0o9gGTpfZICa8N8VFGCG
	 N7I4D1bTCLmCnuxvW2Cj06j+ahT6iBdjjzdESsdaHaIWHxmaIhB+lpITt8MSQ5uW+A07V
	 I7unno+sHBuU3Ja3zXULtE2Pw00HzBWQNRA2XdvTVjvz4QbjxmbeJNnPUVHIO7HLCZZ0e
	 6JMNYdE2eV99dDSn0rTPAdSa+yLOuleIYX0wlAmwOK/h3b+TV9SUmJ2VxtX1wGjrCNQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795779992;
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
	bh=+8UbzgmkR1cxrBoYfCu2LfFJUbju5rAJKXqy7W2Z6qg=;
	b=BvnQfQKTFkpSsyDtM9m9RAKkvAVW1+IzO05lXb3bkx81TSVtoxgNertv8tdpa47zf9ss
	 Cr+OL3eQFMjCY9v/Kfn94THEAQSFlGwYoj+0BD+tbi/aXXqWTP3pjYgrPrnZAwQRRLw3g
	 +9FF3EwGTc8ET8g3CNpJH0VGaUG+Lz3+wNnWmxPUVchGaY89s4nPDtQ/mLUij3VZ4a8Ge
	 MsTlc5y9Bg2QxYUNhKGfFXs1e4av1enEpcIdZI6sqUPqg6b2ESpYIRWAe5ZW0hJnjEfJ2
	 5W4rkOYrjWSayLwiqF2IuhA7VPKaumlRcYucvE9LpHTr4QzEdvjzFcUGgplN58knA7A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=wbna6jtg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.47
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012047.outbound.protection.outlook.com [40.93.195.47])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90929606A692
	for <iommu@lists.linux.dev>; Fri, 27 Nov 2026 11:46:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90929606A692
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=wbna6jtg
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rAE6IHiq7dQwyukTjcJtG0/Jtq50dRjBdxmuMbYVcjTL4zDmW41oG5gYZAU3QMLBoWPBRT5PeDBGVVpj4TLvwLy0dW0SvwAzJ7xVtapiLCRelev0pdHAQsc/cfBMBbkC4cSF9pkM2c/Ljl4bNtgAu5UZ3C6NgvrygLoNETR51gocb6p8kJv3QjTNygOJu43KJuVLttMBgr8kK3zhvZfu/OHmqP3ERshEVDUQoQSG1pUDjNIiSnkHiRoP00txFZn7x+XQAykQ5pa6zWEtdfedK0wuh27JEGaCi95zKWLfpxF50zkkAzXUfbxhVQStUr7rMtsb/xMBy2QnVDWGMGf7WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+8UbzgmkR1cxrBoYfCu2LfFJUbju5rAJKXqy7W2Z6qg=;
 b=CYQ21AW7h5T22STQrxnSZwHYvIndDzRfFIXqA/ae/AP9WNoYHYPdv1c+S4r47suRWFdaIV81oDfdZohsmaD//t1gN7RQiTZ/nT3lVlViNfaS1WxdmyBVDdrpTnzb/P4FrcatXYw/e4wHKaiGKYYazC5izLVbGaS3cqpy9s4pg9JqQy3Y1G5IiUvgG7H+KqEhmhH0HLTCLujo6jGpsd3LDyKzposmCi+EPVyNKDkKHLpleHirbKe+kC5zsvJBOz4brqO6leV9ROVEhSeGZSnzvVWNqWPm1jQJmrRZ+471xKA2OQ7WBtIHzaZZQQlbi2elBOmGU4m12oqawiV98OKYGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+8UbzgmkR1cxrBoYfCu2LfFJUbju5rAJKXqy7W2Z6qg=;
 b=wbna6jtgVXN8JZRQ1zy9pCMWGKh/yJYUz8n3SXUlnltOozgDB1DKPlqGOwnsRH5btCFnbR+pBOJ+Y5jrJ2cyVapsgntgpQK/pIPaFnvPTODDmufuoXmf5vNIWyUEZ+A4jWbGsUPl/TJ6oWy06QuT+r/98TLaXmYdrtpZkjvnGss=
Received: from SJ0PR03CA0289.namprd03.prod.outlook.com (2603:10b6:a03:39e::24)
 by CHXPR12MB999243.namprd12.prod.outlook.com (2603:10b6:610:2fc::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.10; Fri, 27 Nov
 2026 11:46:26 +0000
Received: from PH1PEPF00062F2D.namprd03.prod.outlook.com
 (2603:10b6:a03:39e:cafe::24) by SJ0PR03CA0289.outlook.office365.com
 (2603:10b6:a03:39e::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.10 via Frontend Transport; Fri,
 27 Nov 2026 11:46:26 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 PH1PEPF00062F2D.mail.protection.outlook.com (10.167.243.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Fri, 27 Nov 2026 11:46:25 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 27 Nov
 2026 05:46:22 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v2 6/7] iommu/amd: Update device attach state only after a successful attach
Date: Fri, 27 Nov 2026 11:44:34 +0000
Message-ID: <20261127114435.209548-7-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261127114435.209548-1-vasant.hegde@amd.com>
References: <20261127114435.209548-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: PH1PEPF00062F2D:EE_|CHXPR12MB999243:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ba310df-f76d-4caa-9c29-08df4c7c111b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|1800799024|36860700016|376014|18002099003|22082099003|10067099003|5023799004|11063799006|56012099006|261026121527099003|261026140227099003|261028144727099003|261021123027099003|261021121427099003|261022105027099003|261022075727099003|261102123227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	zRAJhzW20/eeHuu++A2oXHGN9ObED4figGL9KDDl3EMmNfLi5d9EyTU9apAl/r6eEAKfe3ihrffIlM+Y4lcZpaq2VhbSUiCaAj0+9f35FKFeVqf6y8OAAPcKu1+BkpkKfPnaPEbZ/G2ikWfq9omJokoTU6PCyDEcPeqy+R5MwMgHIwHV9zjYrPvGK6jG1QdExz9ka8ulEQL445E0EBnfigGjc64awt88ckGyov1j+cwLUUT09+omiKlEfCDlk34wntwULTEW8I+T/Yz3P5xLEqKchgrCTIvxXYlgCylFSew+mXEzWwASDpqBGbVDsu2T85tueV3AJ5d/+jwn4g9PfY8Df8JwRWOSEsYG+z9+9gSLg47Nbz6N4OyIVzniXWIJN0d3Sq5N/94lQB3cR7PGjbdHKli15cothMf59fm9jwaB9mQP5kjwFCC0heMg1GnL8EIbHDV3/XDZBCqNVBUDzAibLC4zZPdh8HUbQEiZx6mdzuEmR1mSKHs0S8TiF7DCYWgJmpKUrCla6YdLRatG0kSCneCFgtl0dedmT4eBIC6DLP24wk93qFRUiNyyIPvxWYdjoDuvd5lXDLTfFbpXyiciLXH2Yv2n6l91bNdK0wSmZ2h6CFNSjZb3PzS9nLXvcwtqu3SZrsp0mQZNLq8glZTXVkv0l+A5piOhRcacbBTXqlhov0iBix4B19Zh+19uVNUn8LjKZ/YgQZVuVAM+eg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(1800799024)(36860700016)(376014)(18002099003)(22082099003)(10067099003)(5023799004)(11063799006)(56012099006)(261026121527099003)(261026140227099003)(261028144727099003)(261021123027099003)(261021121427099003)(261022105027099003)(261022075727099003)(261102123227099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	si00FHA9TCnsA9I/G/nVNacrohpuBcxdPHzuRYzMuKHLBQYp47wQkogXmBl/TF6APg4ITtll2z9XUTc3Zid049Cwx6T9uUD8EZiApp/bwsVQqjRSFggZYpmyN7D9kVgUZ6TCbZ6Df959LEGGs44jAJsG7R+eVYDaZ2028PBOV6kVC+7/Hq0jbyizTL0Fn9BY/fmKtgsf0tA76EKy8N+jKTvD8jKCMxsiM6r/mXa/1IJeT0i9t9MjOtYPoR31En3kYBi0p8jHxYF+UIZt1zCaJObWvDGDdRwQSVKJBVkSadfWdNRMlpEA7rzIsZtZm19ketMyAUidJ/3SYBeQM+MxdKYRdgEvFANbyKyN/xKrQ2AKQpxs8S1ZBZU+bD6P12x0/bOtPANWy4OGmZLtdQ2S9vLzFEgxgVH2tXCLbeztxdkAFdypzB+rr18mQKrHLU9w
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 11:46:25.5803
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ba310df-f76d-4caa-9c29-08df4c7c111b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	PH1PEPF00062F2D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHXPR12MB999243

amd_iommu_attach_device() clears dev_data->defer_attach before it has
validated or attempted anything, and recomputes dev_data->use_vapic
from the new domain after attach_device() returns, whether or not the
attach succeeded.

When the attach fails, the new domain is not installed. Clearing
defer_attach then drops the deferred attach for a device that was
never attached to the new domain, and use_vapic ends up describing a
domain the device is not using.

Clear defer_attach and update use_vapic only once attach_device()
succeeds. An early failure, such as the dirty tracking check or
set_device_perfopt(), now leaves both fields untouched.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 49cccc969639..1c307310cc2c 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3017,8 +3017,6 @@ static int amd_iommu_attach_device(struct iommu_domain *dom, struct device *dev,
 	if (dev_data->domain == domain)
 		return 0;
 
-	dev_data->defer_attach = false;
-
 	/*
 	 * Restrict to devices with compatible IOMMU hardware support
 	 * when enforcement of dirty tracking is enabled.
@@ -3036,6 +3034,10 @@ static int amd_iommu_attach_device(struct iommu_domain *dom, struct device *dev,
 		detach_device(dev);
 
 	ret = attach_device(dev, domain);
+	if (ret)
+		return ret;
+
+	dev_data->defer_attach = false;
 
 #ifdef CONFIG_IRQ_REMAP
 	if (AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir)) {
@@ -3046,7 +3048,7 @@ static int amd_iommu_attach_device(struct iommu_domain *dom, struct device *dev,
 	}
 #endif
 
-	return ret;
+	return 0;
 }
 
 static bool amd_iommu_capable(struct device *dev, enum iommu_cap cap)
-- 
2.31.1

