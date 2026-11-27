Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.22
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795779648;
	b=jlOk7//m6CMTJS21HlFRiy/07Y3pVgGChUEgQnrlcpE57DCkLwgnTU2BdVMwyclV2n+R
	 O2Gwyd22G5feyip1qJVWox/hRQqu/QfgWG3hTOQ0/Bt0SYd/UT0bypLOw0UODydJtNa9c
	 bkmjCveisCPMgUE4QFu2Axa5HuQ3oMBFHVxSBTvZ2ja8SPXbSKBQJx69tuqfRhl5VKAZb
	 Qr+nfMCWvajT2UK5sd6pZHiwYlJyRp0T6Jt4RAHIBLxfgXZyjuC5OdGPvOD8U1dD2SBJK
	 mME5aabANPmgVUdsXz4ST1hDbJxLv2AG93ZvDd3CRxsoUdI/g0L9dv2YEXWHbupnRgw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795779648;
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
	bh=aoF+H0lUGyD24KboAuEUBm7TaYznYkIEf4CPq6UNqvo=;
	b=Mnlr9NuY6Mhb4hnixDoVUPDLhOux+LDgDuo3JjI+pBmtzUSKgjAwZ0Ea0M228ALPd4N9
	 VGgF3Gk6h+O/ndvf1C2VTpuuDUeEooxUg2eYakl7nuSUQ5ibkWl4UGLgD5qLyD4wbtIis
	 PSW8T2UzuwrH5IzEfDwxenifGteqzl1guZtpBLJT+4KVnlO2HVXdJmNNr7/5gJt1ZDCkx
	 gs6HdjhQb2silJbO70OnnscaI+VU8zT7C7DAFLPCR1J9Hc3OySsbXVcnhhhRD4AKi3XjJ
	 xJ5C2b7HpoqzsHlk2YJJwcWUbLvxl+B+E/qUZN7jDXCpF8wyiqFHDZ3hYmMFKQh60tg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=AC5sA5QW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.22
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010022.outbound.protection.outlook.com [52.101.46.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7FF606A321
	for <iommu@lists.linux.dev>; Fri, 27 Nov 2026 11:40:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC7FF606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=AC5sA5QW
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KMrx0ZR2eIU5btXcgdHpONHZoaKxnRECEsU/MRwDomrBelo6EieLcWalunuAIi9M5lik0UJvrl3UdxlwNyhUg/WhNlSUhWPESUqPuJBC39ukERxTEIH6XdddIJ/8J5VCYVS4XfYwlr5YtgbF/nXQG6e5T6BbjUceP2E6jTHx9DpG8hVjSXJPnbuw8XOvKK7oKSJN6Do4/ZtBoM+ICwPGSSpMPtgs+OH9OtAE8iaKWAKuR+Qn4O8rorOwMdaaPe7lkE4DL+HRqnnPn1UcD87f2fArM4TBIQtxLTgWDHmFNUV9KVlViutuSuRdHdkl9oyzlo64awrMcVP702piKVY4hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aoF+H0lUGyD24KboAuEUBm7TaYznYkIEf4CPq6UNqvo=;
 b=HqX6Ar5OmtQrHk4Q8PKMAJRiBXo7pZIj0T0ZXO+YXGH0Zpddj8HRfM29SCP9wSPaHPAesVQH36EoOHNPkKgm+VTHU4/mxsn+JT35j2rk2ZKOIgbZ6gUIgf5Ip0PO1US2n3utLy7FFW/GO9KgNBlWf/bY4Xl5/7NZq/ZUtDGQuanEGNAsFlVO0KuoR+fFj3Y/sL18xLwXrjflTJmMYTeM9iCqpkEQzRdUFkXAjjxjgWR/bBmySX6T/x+wv7hSZrzvJAmnypi5Wp8Z37iY9IdUcxtXJSoMf3neiEGhma17zkbDPfe+mUxhoQ5l09LqQ6LPTNHHlKuKYFkRJj0XamdOrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aoF+H0lUGyD24KboAuEUBm7TaYznYkIEf4CPq6UNqvo=;
 b=AC5sA5QWVCnz9XLx57Gb5BFY5cfAnFtXQEcjwwapHv4vcpotdqfoUPLzrrdpFAWw4LDgVRoj47iuWFBn91ugXFyG5DZLd/6U74+rhhg2tCCYq6fmG1CK1LKGFNmKhJkRb5QCFRStO7ek+fRhgX3ViFbC/IZ9rU2Eyn4QvhRZrtk=
Received: from SJ0PR13CA0131.namprd13.prod.outlook.com (2603:10b6:a03:2c6::16)
 by DS7PR12MB5863.namprd12.prod.outlook.com (2603:10b6:8:7a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Fri, 27 Nov
 2026 11:40:43 +0000
Received: from SJ1PEPF000037B4.namprd05.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::41) by SJ0PR13CA0131.outlook.office365.com
 (2603:10b6:a03:2c6::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.688.6 via Frontend Transport; Fri, 27
 Nov 2026 11:40:43 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037B4.mail.protection.outlook.com (10.167.244.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Fri, 27 Nov 2026 11:40:43 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 27 Nov
 2026 05:40:40 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v2 RESEND 3/3] iommu/amd: Drop the iommu_dev_data allocation for alias devices
Date: Fri, 27 Nov 2026 11:39:34 +0000
Message-ID: <20261127113934.209373-4-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261127113934.209373-1-vasant.hegde@amd.com>
References: <20261127113934.209373-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037B4:EE_|DS7PR12MB5863:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e4a8b74-e1fa-4401-cf06-08df4c7b4513
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|82310400026|376014|1800799024|56012099006|11063799006|261026121527099003|261026140227099003|261021121427099003|261028144727099003|261102123227099003|261022105027099003|261021123027099003|10067099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	aqrcOwCpvaStb9ci9RphLKM5PzyuhO5+PWmdERiPs2PnS1Fh/poMFRI9gkJ+hkuYjLZvOMNzf4TWxsxpJp1kJ02PxWvZQzb8+SrXNPbiSHXcWy6Agl42kUiFJuzTzimn5xxfcgPGUL8ezW/hNiLPqj6XWa0fPSF6v9XK3/ICDWXzXCTtXKwW0JQakm3U48idj6br/IoHhlpD2Ch+ZFarOcJ+VMIYxQk51N2zsGJpdWUMTdYwRRpoyBAy4r0g0wyY2N5Ti8vfLIwmwp1ZppeoEVxciK5SToGFdNXRO8fVECtaA4AhIfYoWsCpjmcCs8EEa8IIpbvtD3vOtUWUsrvM3OQizD68lH6jYa2vQtqiCkKN1CeQEbtO6Yw55nXvZfNBhQ9KTlHPFzLnL7aIlH+ZhAjaLMpAa7OW6o5UfqclkNy7XbvmedWTTpEl3/WM5VRwbpOXfhOXqIrBQaqMTtMUMtijYbD8qRZpemg3Irg9fEz9ktRvny5y4WjzQWAXt5QYEh0egc3jKrZU56EP6SKnW8WT7U+fH5wSUgFpYzAmLtH9pl9hC8mtDH41RPZD6BUei9s9uSGK9KB5m38liyfT/YgSHKopV88HHvwxibY607Glr4aJNFJeeDeaSftEYeSQkGbA+TOEaXbgJ4RIGqipJbw2cyu0ew0lnf7k9JVNlTl3ZumpYRwUavEwMfYqm10Fdkni+S00z69J8iNy3rHebg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(82310400026)(376014)(1800799024)(56012099006)(11063799006)(261026121527099003)(261026140227099003)(261021121427099003)(261028144727099003)(261102123227099003)(261022105027099003)(261021123027099003)(10067099003)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hAmbszfA5Phc3ZUcsisyexg2dS3dJ9iaGhkdqn3JIFisKqKsPZCDDEtsLOajeD5ORmSVtyyjwHio3uz6Ed29Qshjy6VPMFaerdYCo1BJkNN2c78aDcFZH2hL4q/gvrBPY48Kq7PZq/Mubl85as7WElUu0IPrq7nCiWARTNrPYMIdMq0+1Irt29we5pvwBN7HyB3jADUjBWJ2Y/P6vgROOCO+g6ULN9YzGutOBFx4yfPQJonwCt1Q9YLO4M87rtFJf1PICshCLcplGOeS0ZvwVHGXzIVpFlBfdWrCMI+GDWFXaxU0G0/WymqJYBw/+M8sp91zvXlluwCwu3vJkBgF9rj+HT4E4WIF6kWq+45T1i5WesX3bq1ZI747TthSApUPYSLQ6HOFfiZ1btC7JgTUyAUDb2+vqWAEItq6m60AJrSGskWtLMNNN3xwUS73p7kl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 11:40:43.2255
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e4a8b74-e1fa-4401-cf06-08df4c7b4513
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000037B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5863

A DMA alias is simply another DeviceID for a device the driver already
tracks. The alias dev_data object is never attached to a domain and is
never freed, so it serves no purpose beyond carrying a deviceID.

Now that the DTE helpers address a slot directly by DeviceID,
get_dte256()/update_dte256() can read the source entry and write the
alias entry using their DeviceIDs alone. Drop the dev_data lookup and
the alias allocation.

No functional change intended.

Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 27 ++++-----------------------
 1 file changed, 4 insertions(+), 23 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index a1a07bbd1545..29a3374216b6 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -82,7 +82,6 @@ static void amd_iommu_change_top(struct pt_iommu *iommu_table,
 
 static void iommu_flush_dte_sync(struct amd_iommu *iommu, u16 devid);
 
-static struct iommu_dev_data *find_dev_data(struct amd_iommu *iommu, u16 devid);
 static bool amd_iommu_enforce_cache_coherency(struct iommu_domain *domain);
 static int amd_iommu_set_dirty_tracking(struct iommu_domain *domain,
 					bool enable);
@@ -412,10 +411,8 @@ static int clone_alias(struct pci_dev *pdev_origin, u16 alias, void *data)
 {
 	struct dev_table_entry new;
 	struct amd_iommu *iommu;
-	struct iommu_dev_data *dev_data, *alias_data;
 	struct pci_dev *pdev = data;
 	u16 devid = pci_dev_id(pdev);
-	int ret = 0;
 
 	if (devid == alias)
 		return 0;
@@ -424,27 +421,11 @@ static int clone_alias(struct pci_dev *pdev_origin, u16 alias, void *data)
 	if (!iommu)
 		return 0;
 
-	/* Copy the data from pdev */
-	dev_data = dev_iommu_priv_get(&pdev->dev);
-	if (!dev_data) {
-		pr_err("%s : Failed to get dev_data for 0x%x\n", __func__, devid);
-		ret = -EINVAL;
-		goto out;
-	}
-	get_dte256(iommu, dev_data->devid, &new);
-
-	/* Setup alias */
-	alias_data = find_dev_data(iommu, alias);
-	if (!alias_data) {
-		pr_err("%s : Failed to get alias dev_data for 0x%x\n", __func__, alias);
-		ret = -EINVAL;
-		goto out;
-	}
-	update_dte256(iommu, alias_data->devid, &new);
-
+	get_dte256(iommu, devid, &new);
+	update_dte256(iommu, alias, &new);
 	amd_iommu_set_rlookup_table(iommu, alias);
-out:
-	return ret;
+
+	return 0;
 }
 
 static void clone_aliases(struct amd_iommu *iommu, struct device *dev)
-- 
2.31.1

