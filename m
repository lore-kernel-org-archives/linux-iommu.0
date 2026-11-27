Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.10
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795779913;
	b=nXzwqK8Ljg5xP55gW91Gf77H/X54KeuSAxIDNwTLbJ1sImD2RgQeIlbEQNXHuXPH4fLz
	 Vlp/2lWMqswGNp226Yuw9cZ7ScH29S0V/UzvL440P8Lai9ac+j6OhChtGQ7t4wT2QVclL
	 u4Pfsv48lR1dW2hNJs07XbAeTbrTjadjIWf1vlSRAV7nmWqKHJJiysKM5EQJgRd+Vfgls
	 Pa3fd4TLni9cY0oFuKm/FQDFrSQdAZ1c2J9lVUp2+/iUJks1MVR+4Bvey/soS209VuGgD
	 shKwL7ijMBjb6TqSKgd2Pg96sprYXz0KG2IRfDmacCdzFvGAYgO1J6Q6grijS4FJqjg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795779913;
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
	bh=17yhnFoZExpAPFh8cgQ2BM2dpZyZGQ6yHqtjEGBztIM=;
	b=Iot6e9MZH9Mpg8QPM2AamWTA5vDf1eCgUe1rz6how/3mp9EvbC1zWzoiyqKoCYLVibpN
	 Ut1kXKwUu9HPOuqgryafh/eK4Pu3jw5mvbM54WQru8QKx3mXJlwM/VZT48Y3vvq3qbfGC
	 ZxzRAev4tCWHXM2K6yONu/XQ3HmsF2PlS9G4idfYrtOg9xTz4vULCXnCvet+0MiwjyXfJ
	 Bipt1KwME1pu/vW21qHUPZpStPd0v/rP4zGUim31ylIuDY39GpZcGhoIFYQAIbhsENslX
	 FHiL4dcS+5RRs6Z0dJLoo+wTAI1bmtYksW3yajJSzaHZ+bxU4Jab5qW3vRUprgYFKzg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ZoWvpwRw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.10
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010010.outbound.protection.outlook.com [40.93.198.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99746606A32E
	for <iommu@lists.linux.dev>; Fri, 27 Nov 2026 11:45:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99746606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ZoWvpwRw
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uKxC+iuCZVUgW0CpcwmDjAg0vAjPSp6RtAjKtbAv0KQdXscAKopS5gkiNVQHx+AZ5eecK6RDaihsFHzfTxFQZ8HOXtrBShAqniys+yEJf0z0UKod3K9RFF4NgotJyEm5VP9G8u1GlC7vVZle0sen7+vIOLfPgoS2ihFBsV62FHCBK34MBpo1bQCAQRWp9z1ecnhhR/xwtTl6zwCRNMkEVStvOLoGwBOBMPyOK2qS5vdwL5mf1XY0DSGycMLvWQsAcd1PF/DQsQ4H9WSiHC5BVba2P41ApM940muF6bQ9IHiqrSTwCJH+mxUb/kV+AUsgZrK6alGBJ+me2R6e1KciPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=17yhnFoZExpAPFh8cgQ2BM2dpZyZGQ6yHqtjEGBztIM=;
 b=hcZyc8aTbdcdq0AdpJu/6C3o7mI/9VZVs+uF6UFmO5WW9tKkM/JdMVZyt6939AwSk5FI5vcDkOctH0EuRCbVxj9412iQyW4wBRKbt9jUD5xKMgDAepX+DQ+xEh1/W2/f6vC/KR6odxnm5rHyK7IsXi6vF+z03lFvvEZyJbCO4ltPeMA796N+oabITaekC/WfhZLYZbMSgpqeR0ouWGLVexnsak2NPH+SH8ohe7M4E1fuc8c9d3RxWqU2sSOYQqlyaNV+xVViG2q5IUSbkOfBYI5+i8sYBv4HNZalXAGf123IamED9JCvebSmVnBunJ0mKtQBzxTKN9oSTGBUwl8D8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=17yhnFoZExpAPFh8cgQ2BM2dpZyZGQ6yHqtjEGBztIM=;
 b=ZoWvpwRw9kwdAIlD+Ib+0kVeMUX2ZnW2GemGkLgrt1VW84rm8lcRuWPD+EBW6kO3UQAO4x5tC8tgY3gitZJ+jwLSwz11QJftXphNQJsZL78AblhQYDnVQA8rwP3vVz89qI1dueh8rh81vvY3wAnX2aHxbSU/ddpo9hrr6Lzs8Tc=
Received: from MN2PR14CA0025.namprd14.prod.outlook.com (2603:10b6:208:23e::30)
 by BL4PR12MB9536.namprd12.prod.outlook.com (2603:10b6:208:590::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Fri, 27 Nov
 2026 11:45:08 +0000
Received: from BN7PEPF0000009F.namprd04.prod.outlook.com
 (2603:10b6:208:23e:cafe::a1) by MN2PR14CA0025.outlook.office365.com
 (2603:10b6:208:23e::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.11 via Frontend Transport; Fri,
 27 Nov 2026 11:45:08 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF0000009F.mail.protection.outlook.com (10.167.248.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Fri, 27 Nov 2026 11:45:08 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 27 Nov
 2026 05:45:04 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v2 1/7] iommu/amd: Drop redundant flushes when the page table top changes
Date: Fri, 27 Nov 2026 11:44:29 +0000
Message-ID: <20261127114435.209548-2-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN7PEPF0000009F:EE_|BL4PR12MB9536:EE_
X-MS-Office365-Filtering-Correlation-Id: fc60fee7-beec-4c27-619f-08df4c7be329
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|261009223027099003|22082099003|18002099003|11063799006|10067099003|56012099006|261028144727099003|261102123227099003|261026121527099003|261026140227099003|261022075727099003|261022105027099003|261021121427099003|261021123027099003;
X-Microsoft-Antispam-Message-Info:
	jHa+W0pqvICGU+8v3QAV7ZFLe1KSCKvAGdquRvCU3I7NIceQJOKVU6AuvawQGFl1jf2obpXe3TaC5zkco6T0NiMgqhaFSUab0jPcAl3CNKuK7XZM8azrZlFuCSfhvgy0x/hsikLXSAg7xOZOatqUfJNhVfXwvA1qtu5esphplCncVx+V0UGIoO8hR3zTRyqEyb23k4n2gbTF42uM1zmbjAAOC0Hany9MPVJvlyi0X0KwXBfmWthst960gJOaMOIFntVAgZwYVIhm3kVldu5KerqaZnYjenaS5bhSe+qi7pHu0zjMufviWtDkmSSQIgTSWyqRHWWekUPWrseh6HhpQWweYthdzrAAS9af8yiPRdNfgdjwTbBQgbxrscc4x92ezSthdP+ReBupcFmnGGNn+hidyG43SX9cweQ0r29gDew++vBxW2PC8yXhjSAIWzb7htRLSDNIHdQudLFDrTkUf6KgUwGXQ8GwguuP/GbkBieTcrFnue/rdebQx0J2JuzAMEKJPSWLS/PjAPRWsJeDm07/zA1/QTkkgjhsvia6i4ZCuVnxBfeCG+XHwcajJgRqmiy4sNA/KKuFqiLoz5yExH0mp4GlGcR5rQlVbfQkBWyK//sx+RlA6rJmCEqul0BvhBjs0otxyoWNF8HNwrWu2+R5EqXCDOJCFdxWuYHT35RbfX7QVGq5aoXd+nJoUw0NJ7dGG1sXPffUfwEhWvwXeA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(261009223027099003)(22082099003)(18002099003)(11063799006)(10067099003)(56012099006)(261028144727099003)(261102123227099003)(261026121527099003)(261026140227099003)(261022075727099003)(261022105027099003)(261021121427099003)(261021123027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	lf/mKtLbPxsKjnDnCJzf5psff274lZcv3jIAea73qNu+jVziRwg/UXHxuYRHNEDWUUhwlblUXodguv9/qEZy+RpJvU4PXyWuK2OIbcpSaVGKg/em6pakFH9Uox2+itUxMwJj/PAMTnUuzHbWUG5B5W2MyNtyOP+noWhPM0eLny8xAQ9YLi7BwRRx+salwpRRMcFJLYZnJoy2UfVr6hNVYX/0K26tTVawepNclC7D+IMZ7wjbryjxtGMaBwUlSFL8hw2ZhzhbzRYFZslddQzALNeAsFf5gGBb2UPvcTe6oyej1n+TVG+EPzftshxhHT7/JY5BhAV+V4HPOF1eXj9Lp8We7J76O5ZvpeuhKaJkGmM6a05B3FsPaiSE7bMAdCclRoD5oEp400FUp3y7wN4sZAH/OUpP6AFrGthDjVGXFppoJOHjKDr1IgWAXpGLaOlF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 11:45:08.5294
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc60fee7-beec-4c27-619f-08df4c7be329
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN7PEPF0000009F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9536

amd_iommu_change_top() updates each device's DTE via set_dte_entry(),
which already clones the aliases, flushes the DTE and device IOTLB, and
waits for completion. Hence remove redundant clone_aliases and dte flush
from amd_iommu_change_top().

Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 0b87d4252906..22aef8ce98e2 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2623,19 +2623,16 @@ static void amd_iommu_change_top(struct pt_iommu *iommu_table,
 
 	lockdep_assert_held(&pdom->lock);
 
-	/* Update the DTE for all devices attached to this domain */
+	/*
+	 * Update the DTE for all devices attached to this domain. This also
+	 * updates the aliases and flushes the DTEs.
+	 */
 	list_for_each_entry(dev_data, &pdom->dev_list, list) {
-		struct amd_iommu *iommu = rlookup_amd_iommu(dev_data->dev);
+		struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
 
 		/* Update the HW references with the new level and top ptr */
 		set_dte_entry(iommu, dev_data, top_paddr, top_level);
-		clone_aliases(iommu, dev_data->dev);
 	}
-
-	list_for_each_entry(dev_data, &pdom->dev_list, list)
-		device_flush_dte(dev_data);
-
-	domain_flush_complete(pdom);
 }
 
 /*
-- 
2.31.1

