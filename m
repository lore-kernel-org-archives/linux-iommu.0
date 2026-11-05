Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.65
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793851646;
	b=IWvuOAHE3KpMc1PbGb2S5Nk1j66EvGcWcT/+d9GLvOAbj9idcJAzWCuQ+ZIKDsAXVF5p
	 PRNA0RWSi/Pe5tgqQ7Y8iKsw3bS+Jvk9phwn6lXRyG9UWfsU6u6cMP5B9NRKdUNgJrgP2
	 +MbfAvY9IS/OifklD9Lee6WE9grZp/R79GFUfo8qju6baUVzdrn6gzvVp+8dPU4nH/mJ0
	 Br6v52IFlF/FfE9Kn4rLKwHQTCIjBG6v0n/qrRVLAn6BRcqHYD2iEqwq+wBCVBME/Qq6a
	 g6yGkUdmmkkseHt4Vp//LrHxghCCrWnIlQBgIj9dAyg9hIwyaN4YplBsu0byBjFoJgg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793851646;
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
	bh=HTxhVY+1EE21/8H7RwyhCQJtYFpkl+jmsdqJcZmxWxQ=;
	b=ve8yLTFKgCGkmySJg2soaAmeUmtX3kLWguUNUzKxauDZJwpdhzpcYcYSuvpCyvtTNvSL
	 +HVMY1KERC0MGE9M/CpSa6wkYnfL6wcLn+H/gaGAPTZhEvu2VkC6uPD7kjvFidU3a9wc0
	 wpuvYfnmbgeNQanldhcMu3z0C0nsdwWpwR5uE1YYTGXSCQxw/gknXBDYawTUeKRbszrbk
	 hozh2unsEOkP00JanqN+E3W2jAwGh6ZOcJqMhGnLLT7rG9Sqyzr0viJa+GxQuTLc6zC6H
	 j5RRASVaLoNbnp1qv7jUEf+sokKzroUDPQWYyqAwYOi2ziEyMAVLlw6fWMJFFnPOEmw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=L+xrnxJx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.65
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010065.outbound.protection.outlook.com [52.101.201.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4603606A328
	for <iommu@lists.linux.dev>; Thu,  5 Nov 2026 04:07:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4603606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=L+xrnxJx
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PKurM/TqlGtWgaantjsaXaYdzlPafy7z/pckkqMEzALlfJ8IV+FW24/afWbMnilDPhu/grOJg69Zy2jQmfHi3QeEILC2QjWWSLm5+CFDTYj1BCDnVwJZZxOYBTkt8nlnTkev7mpjwPhd5YwXD3LrxB6Q929+z1HgqlIJkP0yea2kprB2K6sPDd/j82e9JEi1yA0599AdVTIihJjlmD1xHDVP+TMjeZYhZ8ErIbBHqLy72q4YTvMpQMms9bOuh37Br1sM7JWEov2MSxY8hoCQhCzifitsonx1ykYwR2Oq7ZnBsIBoQ9Dc0/TyBItGs7OrX8sxQWyvQude+IOzCgkDEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HTxhVY+1EE21/8H7RwyhCQJtYFpkl+jmsdqJcZmxWxQ=;
 b=mH+AmCjIE6MAwWa/16NCWSWrRzPIxTZc9+yE8RBMIoT4ukg1HeHwj5mqEz76FuaG/DF+FKclQ5ngxzgi5cE3s3Y9UDt3DzeU+J0489evgOkeT7hKVewxdz/8AR86wwausKKwsmiTNlt3r1sOf7YYYR/Ag1FFsEeGeU5F4kejjOOcfhX7B3fc6/sOF6t1BuUnq8/E2ud0ZwC7vDCIfVlgownKuOvvGTwZwIB5Y3EgA41Lel5zEz/vyrM0GUtP2OipkbWe0DlyQjMkWzxyb8iQzKqfOI1dkC2cIYMjhljMTkeXQfyvKlJAah49tvkZxq7BC909gcyPUE3GMjH1CRiRaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HTxhVY+1EE21/8H7RwyhCQJtYFpkl+jmsdqJcZmxWxQ=;
 b=L+xrnxJx2mCi0OYqzuwm5cKS9EvXByPG4N4LbZTVukrrZoLfI8h2BTtKESCz1t934hGiQz3MfVyO3/SZSNVKTgxX0/vYOZFcQVsCRb+xil0LmbRVzt+E9RBTENoEKayfURZrPapfrSOCuceVQi1HiV+pabd7CZgU4qeWTcZ4oNA=
Received: from MN2PR20CA0056.namprd20.prod.outlook.com (2603:10b6:208:235::25)
 by DS0PR12MB7873.namprd12.prod.outlook.com (2603:10b6:8:142::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Thu, 5 Nov 2026
 04:07:21 +0000
Received: from BN3PEPF00022BBA.namprd04.prod.outlook.com
 (2603:10b6:208:235:cafe::48) by MN2PR20CA0056.outlook.office365.com
 (2603:10b6:208:235::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 04:07:20 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BBA.mail.protection.outlook.com (10.167.248.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 5 Nov 2026 04:07:20 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 22:07:18 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 3/3] iommu/amd: Drop the iommu_dev_data allocation for alias devices
Date: Thu, 5 Nov 2026 04:06:17 +0000
Message-ID: <20261105040617.398870-4-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261105040617.398870-1-vasant.hegde@amd.com>
References: <20261105040617.398870-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BBA:EE_|DS0PR12MB7873:EE_
X-MS-Office365-Filtering-Correlation-Id: e0178c1b-5c49-479e-0f5a-08df3af249f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|376014|1800799024|82310400026|261028144727099003|11063799006|56012099006|261021123027099003|261009223027099003|261021121427099003|261102123227099003|261022105027099003|261026140227099003|261026121527099003|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	40fa5h33AqYcCOt1Djyx65iNDmV/VERZK9zwKZYcRkx5auakzfTIY5hEAjmQ3W9W7Gq6ApP7L13cL1iAtFkogPwZtGsRnw0lpehnBGlJ3MSHcrtf6+iVaLwd7OVxK/rDGdnLNQ/Y1emjBzBSbOnUvm8VG/sNTOCLPQPYFjPF80p4TBCQGtOSNvI1od7XrU8CMq7YAsNddN5uPS3Hym8HWK9RN96J4NQkAMxrNWIrHVMIxf9XgJRJkMETAxpkQXzMbFfbss6dCuwiRNoUJG9gc/A+cPcdvCJh5ouaMBS+D296+Qe4Pq00UCWLuz+K7uJgk3CrW7tI2o3C95ynLT4TMgTnD+XV8mClLk4QZOgW3IcZWhgg88GePferVTRc1uT3XCItWMpZvEjF4ojlUEF/X6aGOsUwMUvdK3kizBflVpmAw5WHWSj/rcdOxP5/3TdO+qTsHC06MWKvxnxRkniXEViVSsNAyAWKNkOj+e1XuCVESvDZBUY45A7XpmAwAF0RjSzBC8ctrCyyobGu/YSAqsGw2ZXVK3M3j9Vbt8lOpsqW8P/6oikCVZ8D5OZIQgVxDq0Qmzk7oIALoztJeX6Py0ytKFswEHXarr0l/UWi2g+jmULUck0proeB3o70W2wTOcuOVMIMtjwq2pmIbmbQ/87xcB73ba15E77AMk+6rjMTY2SOsYPrvcmIwpNSePH/r28ggVckACT7ElQQB0yg0w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(376014)(1800799024)(82310400026)(261028144727099003)(11063799006)(56012099006)(261021123027099003)(261009223027099003)(261021121427099003)(261102123227099003)(261022105027099003)(261026140227099003)(261026121527099003)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	W4UAVi4YuE2Tnkj82Z92aZAz0LJ1A/Ir8RI2tKKx6osglXDj09xwdmorarxDmxOFRP+udXXORq9r/ls9PKuGNPn4hvYTgdYYl3RqdET7cv3I39eFNEgSGTIL+ivlI82vBj6QK2Na0BwWMQUEXRHO3gq1uUtq/Qlzsux1eHHh5xya83fCq2Rd13mgcpgICs2lXNowFYyfVgkjUcp4782uuNasHrbcl/ep9AG1u3SRDKjRYmZwnrDy5yQ5l07cOHc1HL+VPQpo4COKovfAlUoz1/7hzHRWsErzCg8dhkGWQFJaSujyhv3YxFufnjSxj73xgwt1xs6WpUOMfGMs8OnXbBVk+PxNm7dQVjw6lmlZ0N/sOucapZ4rhDh1C0rkzNzrLQHp1xcJ7CSwGzJjbI2Sg1DSNI2ya7dPdJYtO1W4Zk1W2jSkBvRibpXZSOwQAK02
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 04:07:20.6486
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0178c1b-5c49-479e-0f5a-08df3af249f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF00022BBA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7873

A DMA alias is simply another DeviceID for a device the driver already
tracks. The alias dev_data object is never attached to a domain and is
never freed, so it serves no purpose beyond carrying a deviceID.

Now that the DTE helpers address a slot directly by DeviceID,
get_dte256()/update_dte256() can read the source entry and write the
alias entry using their DeviceIDs alone. Drop the dev_data lookup and
the alias allocation.

No functional change intended.

Assisted-by: Cursor
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 27 ++++-----------------------
 1 file changed, 4 insertions(+), 23 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 0720f82dbefe..4b57736b7c18 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -81,7 +81,6 @@ static void amd_iommu_change_top(struct pt_iommu *iommu_table,
 
 static void iommu_flush_dte_sync(struct amd_iommu *iommu, u16 devid);
 
-static struct iommu_dev_data *find_dev_data(struct amd_iommu *iommu, u16 devid);
 static bool amd_iommu_enforce_cache_coherency(struct iommu_domain *domain);
 static int amd_iommu_set_dirty_tracking(struct iommu_domain *domain,
 					bool enable);
@@ -411,10 +410,8 @@ static int clone_alias(struct pci_dev *pdev_origin, u16 alias, void *data)
 {
 	struct dev_table_entry new;
 	struct amd_iommu *iommu;
-	struct iommu_dev_data *dev_data, *alias_data;
 	struct pci_dev *pdev = data;
 	u16 devid = pci_dev_id(pdev);
-	int ret = 0;
 
 	if (devid == alias)
 		return 0;
@@ -423,27 +420,11 @@ static int clone_alias(struct pci_dev *pdev_origin, u16 alias, void *data)
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

