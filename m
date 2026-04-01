Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010057.outbound.protection.outlook.com [52.101.85.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5BC38B14D
	for <iommu@lists.linux.dev>; Wed,  1 Apr 2026 08:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775030447; cv=fail; b=IoGMd/Y0piKTgAGJC1sgB5Q7ZHWxTU9zG3Fxgh9ipftb+fGkcK/LUud6RiFw4oMtmgQfZ3VGjAIkE92rAAPkXh/aRzBOVbe0ZqE+BSP1dx+oppCj7WEvhhBOp/CrOiZYJKXh/I/9ceTa4B5/eCNys5emVNAHJCXhmD4ZSrDxrQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775030447; c=relaxed/simple;
	bh=R59Mcw1a6re0REqBlRr/FaUeEldURX2CWjgryjDoM2c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MBr1fv9D4yTBlMtNGuMratO6uldqUk46UqxG7ugwJ401Bdx9g6Q4E0obPJP9aq+m/WYTN7P7b1/P1CONxA0uqKgisOvhU05JiMAKIPqSmTKm2cm/FXL7h1jjs3fkPC3Y2lLQLySexNUjTQ24Q8bHVIC3XEj5DYZhTjqiFetg8Gc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JtI3aErm; arc=fail smtp.client-ip=52.101.85.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JtI3aErm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YG5cY41j4KAWzwDDtYN5eK3OUcNStpYaajQDd/eSNKSqG7N+08dEgvbORfJEdiupKyQaOhq4Tzg+hPUsuLdz7AQU3vpxkELiDpPw8ZaOncrOYF6kvvoaX1kVKnoS2R8Ga6V+FTnoAbgqb9q2JbO1jXQC37ueAYVmqLAGTqET1TUzNhSgdD2guQwXKOlo21Sh6FHPVOWc0TiamoMcEcPAIuaDEPTmTfcS9Wo8kwS1cLZ6bX/sfvvE81x1bs2Q3wX9WUZ+YKH3nPEIgZ46YnY2V3ReH4MmdQGfLQIh92VbhLTpB5plgMWiNIQIydaYFWi6K47/flFUMDcu7OkPdAsNbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eimQEgzHKIOBIyYBcbQF3WI+iQ1zpUb4dh60uzzU04k=;
 b=o7i1iRPzziVIIAunSYHhiKOPmbsPyJNyBtj+kp+6z21g3Z9NPawRoxSi/8FhavBSr8qwUUyoV1au1Crcc2NUitf6K6mzWHHTzz699Qce+SzuFamQcuMdjwJuXcH4lhFKgaIacHh7nuPm7/mD+lcQp/RABoa2DVy3mcbYXTrdUbreHzfR08dBwlP8CSlKTmM18eOFUxKfo/JZL/f05TVTUl1kLwXOniLmsgdZCC9FjMnxu01xvKMutxSS40H0eD+TcZG1Q2WaGSvxFgf83Oedofkf5wL1l7i7qIv7jnc4Y5fPvciDw7FgHRt1NF3FPJXzDJPaEkd4+BxFnzyo5HWfkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eimQEgzHKIOBIyYBcbQF3WI+iQ1zpUb4dh60uzzU04k=;
 b=JtI3aErmBoOSxRIIF0365KUt8Gv3XBekV3Uyvx88lPJD+5hdlaktlYU2BZoEj7XSBVGX7Xly4YvsQY08dmCZKIrWaoAZyy2hRHPnvCfVM8EvwltMTbswvQRqsQE8OBQYQ/pbF4FyvHm//Zl9rg+h6ivboBYl0EXbQFwjSLoDSlU=
Received: from CH5P223CA0001.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::27)
 by CY3PR12MB9553.namprd12.prod.outlook.com (2603:10b6:930:109::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 08:00:43 +0000
Received: from DS3PEPF0000C37A.namprd04.prod.outlook.com
 (2603:10b6:610:1f3:cafe::b6) by CH5P223CA0001.outlook.office365.com
 (2603:10b6:610:1f3::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.30 via Frontend Transport; Wed,
 1 Apr 2026 08:00:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C37A.mail.protection.outlook.com (10.167.23.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 1 Apr 2026 08:00:43 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 1 Apr
 2026 03:00:40 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <magnus@dolphinics.com>, Vasant Hegde
	<vasant.hegde@amd.com>
Subject: [PATCH] iommu/amd: Fix clone_alias() to use the original device's devid
Date: Wed, 1 Apr 2026 08:00:17 +0000
Message-ID: <20260401080017.117549-1-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37A:EE_|CY3PR12MB9553:EE_
X-MS-Office365-Filtering-Correlation-Id: 65d55978-7bc8-4ddf-c7b4-08de8fc4c642
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|376014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	OKt+0Jy+lAUoULC1Wg0DwSwHisjJIAJAh7jWpXhJa6JrlMT2HoRaeeloDwOEGbEGTNKv10PBPKurfQyrCRVnhTjEDIG0BI04ZjLs1aC41rfkx1IeOcoR6yurek0fL9JQWPrG0nvAPDdyTa5ZW1AUeikqETFrJCk0peQqXs1g7vxnhuthcxnU+59mPKX1o3/cPSYKFslCQLK0wVozM0n+CgnVd9ypGUAewvSJIdKMKAoYNcAZBhNy4q7i8UY0K80ezsMUsnpeZf12uVILGQWicY8h6o7CSSuwpzZ4xLeRHb0uE4IGtMDIg7Ywk8VODVySRwJeAKhxBHsof4VCwrthvQ1yuudiJTLKwNhtmv2UFFmw3aVU1ROLvFpW/4rjRMgDOlCCKjUApBI5xxo2C1xZI+siKv4z81Qj3hc3AdETASbnIuWY6Oj6CePcXoUgTcBH6cxoW1D0+mNrhX2Mn0bvjxzdLxkIuqQSaYr/76cMZPybZGz0esBiR6fPNwi+70TobElhqP8bv9bLTfWXjlyNnBno9V+2qwgOj5oCoLokkofG2R29cnfzGdDf2BM4psG8gXX+RHCbT9W0kED0WR3JTdNdUc4ofENILlguBM/a1vEHpSI3+AgBu8WrDS7bOVXaPPd0TN7sCHw1puatJ71NAtoji11Aq8pCS4zRrizpRXC9KJ2LLIbsh5O3doqvmurf8WEbnd8VWtpOt7ki7Yg6bArn6h4wIyTaz9g7UIjAUl9JSg4ygOaPMiouQNZXjducc2K5bpf2Uc1p6TfOkEwu4g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	uRWnnO0ApTc0H4s4MA2HrrtcrOD9HWzwFYrkcp1meDNU4GfA2cVTcQ1jn4/GSeUGl/QdITJhqe0wLs8NzCO6GmH0JlJSij/V91NsldtbQGNm35A7xGo13DZXnHMZ0C7DuuXM8FD3KiMrqnn6Zd3bdhOZP/r+xxtaJfZjf6J/lnFPk00VO2BE3PCpc8NOzjfiLFfl3krMcTRmWRS2tq11D8QHXupma4/vhR+ho5a1zk1sUjPorvT4aLhe5OStPoS1Bfy97p6waWW+GF3iV3IRLCnd7b0yC1oU9HTfAsRNrm8yW/QSBAfikvOF6VR8m8c1/OEHsv2fINEKwFX1Lr1cbNfyz8snCZAVy0UxbsWCpbbCxn+aU6EQBLAPZX21KkCUl35zYGYA63LsvzcVPooMqxGDa97R2gGBkbR3z8Y2dpOAGErcYBbs4ujV5xTFCeqa
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 08:00:43.5010
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65d55978-7bc8-4ddf-c7b4-08de8fc4c642
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9553

Currently clone_alias() assumes first argument (pdev) is always the
original device pointer. This function is called by
pci_for_each_dma_alias() which based on topology decides to send
original or alias device details in first argument.

This meant that the source devid used to look up and copy the DTE
may be incorrect, leading to wrong or stale DTE entries being
propagated to alias device.

Fix this by passing the original pdev as the opaque data argument to
both the direct clone_alias() call and pci_for_each_dma_alias(). Inside
clone_alias(), retrieve the original device from data and compute devid
from it.

Fixes: 3332364e4ebc ("iommu/amd: Support multiple PCI DMA aliases in device table")
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 760d5f4623b5..6dfd942c76ce 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -403,11 +403,12 @@ struct iommu_dev_data *search_dev_data(struct amd_iommu *iommu, u16 devid)
 	return NULL;
 }
 
-static int clone_alias(struct pci_dev *pdev, u16 alias, void *data)
+static int clone_alias(struct pci_dev *pdev_origin, u16 alias, void *data)
 {
 	struct dev_table_entry new;
 	struct amd_iommu *iommu;
 	struct iommu_dev_data *dev_data, *alias_data;
+	struct pci_dev *pdev = data;
 	u16 devid = pci_dev_id(pdev);
 	int ret = 0;
 
@@ -454,9 +455,9 @@ static void clone_aliases(struct amd_iommu *iommu, struct device *dev)
 	 * part of the PCI DMA aliases if it's bus differs
 	 * from the original device.
 	 */
-	clone_alias(pdev, iommu->pci_seg->alias_table[pci_dev_id(pdev)], NULL);
+	clone_alias(pdev, iommu->pci_seg->alias_table[pci_dev_id(pdev)], pdev);
 
-	pci_for_each_dma_alias(pdev, clone_alias, NULL);
+	pci_for_each_dma_alias(pdev, clone_alias, pdev);
 }
 
 static void setup_aliases(struct amd_iommu *iommu, struct device *dev)
-- 
2.31.1

