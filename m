Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.57
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795780648;
	b=TmZX381f/mvCIE7sjPwbp5prHsugbnaxAi68FxgV/MdyVTkqU2OlxXUdAPxtXWK7I0nF
	 e068jqtTnXlk7wMNL3lqpwdKDjMaoSF1IKj3ghfygFwaF3nSoejZOC7QC7eU31ZvU034K
	 0xBvB0b2ORPqhf/BsLOBXhXPjrViJ51wdbmARtQPsl6MR5ss0RZtOAEJ22eCzHYLpivMR
	 BdFepYUZ7TUoKuw4+9WBAD7VpGaobcFjQsPM0cSlZ0ZYRdKyY+vLWiFzd1PXnKvCg18E9
	 pYqesDIJpbs6Mf09R937Z5AX6Ja7T/6P5pep3CMEaYFcicZlfVEi2GvVDIiruXYjnLg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795780648;
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
	bh=Uj0GAiJEYPw/jmGD28ifdNZ6OcY6n1fPJPxiM0BuWtg=;
	b=PQtaOu/GtDmUIIVkG45D8fdM/VJgPPMiubqIF9ZSHdjYfp13VMkKbZ/2zYcv89U3Y3EX
	 G1OyR6LbhmfVBpeJq+xLCQ0zrmTtL2dE3q8fvnG9Rq1E5hlxkVQUM00rTeXYE7LA4yHXS
	 EM4ns03RCXNwlvZ+AfJpakBiyXAyLfvz/Na04zgHlhwhwYyrkYZZW7Iugvfo3hotnVhAm
	 xm8nwCh1ASJIn1pGYe5V7iHyTj5KU0CMuHmCYC3ZbRGOiku1SHI17qc8o9GoVA+8tf8pF
	 PqRKaIj6AKr1kpg/dm7eD2e/+0JXHez8/srkkS87l84jVQQu7zpPd+XE9hkkYZ4OwCw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=PFvQTNtL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.57
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011057.outbound.protection.outlook.com [52.101.57.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349CD606A321
	for <iommu@lists.linux.dev>; Fri, 27 Nov 2026 11:57:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 349CD606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=PFvQTNtL
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nTP3AcrSYO6ySxzpA9tjcB3Q4bCz9m6FNjOgLFlr7Jn3uOkAlIcj+gFBzRQ/EhRcBXEdiimcswEdmQEshqYd+h1licM7LE+cK7tPHhnQ8hQCLp4+T/wXbtxINH/zN6uQo7R/nwsiGPWuohfBNBBdMWC0TIN7b7NU6dxU0kJZC9AXpu8rC9hU8w/T3gyscqR2cYLKE8OjyptyBlKMz7rF080Jg3WR4PuzEnZ0bSu8JP9dKzXzTpGjb/jJELzTtsMFVHOg5EKwxxB2qDazicqLOTONKl2TDN9LyfUWZatSL5UO4cs7iq8wK8MW1trpzjo1XgQZ0vfLv0LB6AAfmNOFPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uj0GAiJEYPw/jmGD28ifdNZ6OcY6n1fPJPxiM0BuWtg=;
 b=HZtQip6+mN552yIDMGWhvr7wEsLuzmTfH2nhjLtgNyYxCzt+Uq8HKxrTCBgZUx9okdg8Y7n/1mzVLYG9NZIcomFiSs2tOg6HpCthNwXa/Zw0epUvWekhJSfSqCOpi6Su+sT4ewdeBQgs+f8J+rJbRKtmbgjpFlFGcJVJ95Nf2UpDCp33UQ6Hk4PoFOiGYx6oygH1z+kvJq4m28WatJdVsAELDcXpNQCx6F1xfN4WOAF9RuxPvE2Dd/Zh2FN3xpDpRAqheA78PUn64tq3bcX4OOqGmfx/r9pb8sOPalUgZLhiPDakKrYzT93hm4grvNb++C1de6pnht9+2YD11+LQvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uj0GAiJEYPw/jmGD28ifdNZ6OcY6n1fPJPxiM0BuWtg=;
 b=PFvQTNtLnGxA4pQ7rfIev6+1jRNeVZyox8ZYiOh5D6tO9Axa/xFOmBxCLwjzvMD/RhirXbdM+l7CAg+M3WA1eadqRW9dlQiJMvbCsdU+QKDQfloVrDrrJ+HhyL79vgsdS+UjA2mr5Pcc94dBuK69ZmKojc49uwbNBT2VEhokCwo=
Received: from PH7P220CA0143.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:327::25)
 by CY5PR12MB6204.namprd12.prod.outlook.com (2603:10b6:930:23::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Fri, 27 Nov
 2026 11:57:22 +0000
Received: from CY6PEPF0000004C.namprd03.prod.outlook.com
 (2603:10b6:510:327:cafe::6b) by PH7P220CA0143.outlook.office365.com
 (2603:10b6:510:327::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.10 via Frontend Transport; Fri,
 27 Nov 2026 11:57:22 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY6PEPF0000004C.mail.protection.outlook.com (10.167.247.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Fri, 27 Nov 2026 11:57:21 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 27 Nov
 2026 05:57:19 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@nvidia.com>, Vasant Hegde
	<vasant.hegde@amd.com>
Subject: [PATCH v2 06/12] iommu/amd: Return -ENOMEM when SVA PASID allocation fails
Date: Fri, 27 Nov 2026 11:54:41 +0000
Message-ID: <20261127115447.209792-7-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY6PEPF0000004C:EE_|CY5PR12MB6204:EE_
X-MS-Office365-Filtering-Correlation-Id: c6bcb630-2bfb-4842-320a-08df4c7d985b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|23010399003|82310400026|1800799024|10067099003|261102123227099003|56012099006|11063799006|261022105027099003|261021123027099003|261026140227099003|261026121527099003|261028144727099003|261021121427099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	AwiweI51gWwHv99guAIIsBnp4jh+VZWpU+htRZ1aBYW/85+AlWnKv0iSMYY8FQJkrVvOmO17eijoDSBzZvRAzPfG6k4ty1eJqqN9nvOjWGJuUykiiI4cf8pkypQHOn8O3MDisGtcxpDLeGnu1pYRnJvWOPUxCQXfjmPQetKUBYAfnrL9jUB+0pfXEx08SxJe2FP3Mvi5zmSyaZjJMG6PMkJCWBK5Bv5UTT8tcDDhPzXkgGvLAq+k5t0kEaNRyVM5/n/MuTSRkjQVuFzFYDs0ZpG1cPYqtfY+IjGpciEX7vk2p8D5ne4TDMzGwybQi6uvVCAaPvNzNVfbdqt0u6QZcYj4mFDdGzoDCY1JyJcraqRC8xgPND3czug2JVWCcyvOBHv6ASwfdrJYOmxj9jyjEfM1TNLDD2rUvMBQ3f9mTfW7+YQmcb65eSMN0wkaXtD1Qxt/8ti07zcfpF7XiDkBAHMFx38RyTRrONHxS8AdrxnU6f6kFhYWOfTv944q9aunZvJhQuQYVpkamlFzu7L+FebDwaRpjfPQ1iXTWMrk3ZKjBzpIpMQH+nB5NGHGaTu6TuGbIbl0RV+R+1Se9g71LgQWaOMRHxTuBq6G2c5fAN3lHRrsbHSF34MnV6PePI28L4teCQHQ5xJ41XqQ0AG9d0dVYAUOsE6kpzbteXHXcchjVw1j79r64eXn+a+W+Oi8kOwzDEWJzO4BhZJPGTqnww==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(23010399003)(82310400026)(1800799024)(10067099003)(261102123227099003)(56012099006)(11063799006)(261022105027099003)(261021123027099003)(261026140227099003)(261026121527099003)(261028144727099003)(261021121427099003)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	d/mISOiYUioZ/l9iuTRTPAjwJmN5Bv1bAXbJuWrSXkMaAS4SEhdEof9dwGMZ3POdXAgbrxGyfExvk+0BA4bG1qDoJ1DtgSY4QaBA2npm2J4HK6VE13NN+Ycw9bN8LIY/OtO2ZjFWu8RhmtUq8nQjqPJ0rDZG1u0qd9LCffLnP9azUH/ynd8o0b6q7CHzEV8A/6QZ53ssQSQwiIA6d2oGaO9LP7lPGXoB0SK3J3VvnCm4KRGbUz7X3zQQcjPoWXdWZ+pXG1Fs8nDtEdMyKks8vh1PsECfoh0H27OzOuisbJG/aSEpUTOD+GgQQSeTO4SZO7krptvahZCt20zN6U0qVrDV0jT7pVwu0x3oOEIl6a9WypgrCUHf8O7fUWyaZLzotQfamyPLqG9hAKHhbWbo9ejcmnzpoua74nHrEXoLZXth50qFfVKjvLwbf/dpfLYA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 11:57:21.9721
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6bcb630-2bfb-4842-320a-08df4c7d985b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY6PEPF0000004C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6204

iommu_sva_set_dev_pasid() returns -EINVAL when the pdom_dev_data
allocation fails. An invalid PASID or a disabled PASID is an invalid
argument. Running out of memory is not, so return -ENOMEM and let the
bind caller tell the two failures apart.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/pasid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/pasid.c b/drivers/iommu/amd/pasid.c
index 87fd2688574c..a5ca5c2b8241 100644
--- a/drivers/iommu/amd/pasid.c
+++ b/drivers/iommu/amd/pasid.c
@@ -128,7 +128,7 @@ static int iommu_sva_set_dev_pasid(struct iommu_domain *domain,
 	/* Add PASID to protection domain pasid list */
 	pdom_dev_data = kzalloc_obj(*pdom_dev_data);
 	if (pdom_dev_data == NULL)
-		return ret;
+		return -ENOMEM;
 
 	pdom_dev_data->pasid = pasid;
 	pdom_dev_data->dev_data = dev_data;
-- 
2.31.1

