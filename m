Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012052.outbound.protection.outlook.com [40.93.195.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FADA3E022E
	for <iommu@lists.linux.dev>; Mon, 13 Apr 2026 14:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776091566; cv=fail; b=Zq8pInlJAfulgtPNSLymG2IZVRDB4vudJhrAKqDf0Z1vMlw6njOxpvyT5x4gieP90OWj16szNNKIva1XNpbL/dgsWssmd4j/BV62Csp+EMcqJFuczP+jnBcEUh7UhbBaJYky/OQe5lvWfugJrtGcAhVt4bpIhstBX6WZqYgAHBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776091566; c=relaxed/simple;
	bh=NdyQ+CRmW2aLHcpNSVLzjgj69Ee8xMYPlDX53XY4Soc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Idi28piA2CEHIXdJiXeCQv+2L4ao9qi1RvsCnQt1xuCvh7JvQKyr4M8JHmEirL71FGEiCN2WTeNlSgCcab0ZftbTT14LEnb2n7UC8QzY2etV7m8GYLG2RUMRtMtNDXbiSg7D/Ik988+y2QcZbvaSeV1KFhpyNFL1+7a3u/2lM/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZUEKXFu+; arc=fail smtp.client-ip=40.93.195.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZUEKXFu+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y5qcn9jTTZjebq9CvbN8t0vb+SIW35RrQqhRDepfFO/mY014tJ4o6cvEimmzfvS0paBKgDYjVptmfCaQxJ7kNeek8B8fmUbBNj38nfU6ubT09wMXIFRRKg2+n5KjY0pq+NFvulcH8mYHu9BR88+Pyos2jcgCL70E1uuexQ3zfzSBe5v8wvsQDLB8oDKaYLIgqBFu22yzWPqlv0bVl3O215nXeViadAl+tQ3Ial0OE3J0EEnTDaf5DbMPb/e8wfRufRk/bZoZBqmG2liXW4Nhj0lQbU2LeqKg+TzWOjdJnWrD4EIX6Qpl6ilKfze9p3ByxlK5ASgT8NNXThGp6l0idw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cczewP1hc1d4hRSIJ/mPdq5yH63B27qmh+Tjx12kYX4=;
 b=x/sLbvh6FNe7J3E8bpGuWidcfBjpfTNF7xoyoH8dFfQ4ymgAKoHM7Muzz5+2ESknFyydqSw9ioMo//vHlPlU644LZXsaaIchh8X0CaVrMD9GzdTH0MTTddzU51Y9BZzFPdchdsQvvNiFU+OdBIxk6jHjHEDbB9fjaE16DDdmD4Oq7ZYyYE/u9y/Rf/4je6NbggoakmLgBXkeAX8kYaxbpvy4jsHAYwT+HKm6vXkV1P9LSrWqs9RkQZjFvIFIBmcZuFzvonuKNBhq70hfs19AMbDdVvhZr10tngk3GyDmBh5L2u1tYd0xVdak702kKT36+F874T1Pknf0zVUQUpt8+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cczewP1hc1d4hRSIJ/mPdq5yH63B27qmh+Tjx12kYX4=;
 b=ZUEKXFu+KiB09jCvQqevYLKe8+qDDM1ZHPNaPuY9LRq98TvmVyEi+KxENxDh2AUNo90fVPtpS6dAXt88sz3mjNR67HZqX4yrWLaMdyOYm30WtK5+5OIynCQOs0KkNS44UJzuC/1m2fmGZY5Y/muGyBFVPp8wgCcQQME7kgJB8GU=
Received: from CH0PR04CA0066.namprd04.prod.outlook.com (2603:10b6:610:74::11)
 by DM4PR12MB6181.namprd12.prod.outlook.com (2603:10b6:8:a9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Mon, 13 Apr
 2026 14:46:00 +0000
Received: from CH3PEPF00000017.namprd21.prod.outlook.com
 (2603:10b6:610:74:cafe::60) by CH0PR04CA0066.outlook.office365.com
 (2603:10b6:610:74::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Mon,
 13 Apr 2026 14:46:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000017.mail.protection.outlook.com (10.167.244.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.0 via Frontend Transport; Mon, 13 Apr 2026 14:46:00 +0000
Received: from BLRANKISONI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 13 Apr
 2026 09:45:55 -0500
From: Ankit Soni <Ankit.Soni@amd.com>
To: <iommu@lists.linux.dev>
CC: <vasant.hegde@amd.com>, <suravee.suthikulpanit@amd.com>,
	<joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
	<linux-kernel@vger.kernel.org>, <jgg@ziepe.ca>
Subject: [PATCH v5 1/4] iommu_pt: Fix pgsize_bitmap calculation in get_info for smaller vasz's
Date: Mon, 13 Apr 2026 14:45:18 +0000
Message-ID: <eb325bcc51b7e5ce98ade6e5838137285738bd9f.1776075533.git.Ankit.Soni@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1776075533.git.Ankit.Soni@amd.com>
References: <cover.1776075533.git.Ankit.Soni@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000017:EE_|DM4PR12MB6181:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e82e917-429c-45bd-ada8-08de996b6129
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	1fdZ6yXvV9A5+1r9hS21vXURFXxaPrWoCRuf6c7aMaiHbd83mDq7lWhXDJaihaC4yNCfcnJE6LmPARQzVhLIpcDdLnroA/yzLZexO9CnkmVmusOwsLaT9qcZDrvFL85FBwJbGhDHVsJFMF7DtLPxqyv+a1I9IgEe6iEBwd+rmF5TNpNY+8/PBULdQ51Zwo+a4Wp6IoDgYeg/hI8aQacjSH0FgtIbH/I/gtifGZJ1nRLFyuWCRXzNpHuL1Eh76+3dyqFlM5I2NYWr6f8/p1l5Yq1jKvxwRvBH+dQcpDOX9jjVFAZatBDtcz1Kcq0NJkYBVXoK3Vd6L1y4uibaFygoSy7wieOIKtbelhGnpeqWVYwVX9dR9gl3uaPcZauqghsVZgzotHJw5U8i2oEIkhHfsQqeFM3KK307NNzBZWQKpXhPWMWQlgsbd3+YzhwYF1IKYh05V1l+WyrHJ3I2tBRMqK9gUq6VNpJDORXbR7zLVRePXHNK5mfpDKYLCRfSzW/uk2nc7u38Pw+4fpmpbL9b6UpqCP/PEq980TxYlDm9yHTiSmS5BHKnrcKNVWtF1uZ9hHqZOKtm90mAURxAlP1gnXUeX0C8eLBMe6NR/fC35Lkx57eJiYuk1AAiqpOIutebvx+tG8jFZJf47tL58hxNAaeHc773rcY1POpEqRqroPz3GHmzbWM7CuBtwcvBexVnOkGTxs0qcS3LHtVAcAzKYjrfVCCzPzCrbk5n6/dBuqt95ygqax7MnwdKOfKVkCjZ1kfGRY6rXosU7fuJgAxCkA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3Bve3TGYPRWZJoXbIIcPmOeN/ih8lG7Jyk4rvE99tnUXAu22nIxTrf+4z1TGRxQc1e9IZ1d2CWwec0riECbiHLNgPVf7Jb7B4E+tOrVDS3sSWMQvMjg+dCAnR4+yc9bJ5CyqhQuKDodXLi1k9BtWaFZFU1wHtr3SxFXWFSLqJxHmvf11emW6frQCFtwrza+KKGt5nBKRTHzI1leSu+f7hDRjHQalJtzSU+hLL9aDpmYEF/wbWA4e2ewd6Bq9mVKglE3uaT+0TxlY9NOpvqYfrUQna8/nRIXoELdD8ym9EIkgYIF4Ly0uBUY2JqeCLFgbbRpZLc/Y773iGAGSdhdHlAQjlk+6Y0ngW654/d8oElNnbv6RnPRJ19pRFGR6w/OniqCow2MrjGsb6VXhvmpPhgCxfGJVsY0S/V8GroGU30A9wj0ynvTv9OfO4O+C4nkM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 14:46:00.3589
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e82e917-429c-45bd-ada8-08de996b6129
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000017.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6181

To properly enforce the domain VA limit, clamp pgsize_bitmap using the
requested max_vasz_lg2 in get_info().
Apply the same VA limit as get_info() in the kunit possible_sizes test so
assertions stay consistent with the domain bitmap.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Ankit Soni <Ankit.Soni@amd.com>
---
 drivers/iommu/generic_pt/iommu_pt.h         |  8 ++++++--
 drivers/iommu/generic_pt/kunit_generic_pt.h | 10 +++++++---
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/generic_pt/iommu_pt.h b/drivers/iommu/generic_pt/iommu_pt.h
index 3e33fe64feab..f150e3a7f545 100644
--- a/drivers/iommu/generic_pt/iommu_pt.h
+++ b/drivers/iommu/generic_pt/iommu_pt.h
@@ -1084,8 +1084,12 @@ static void NS(get_info)(struct pt_iommu *iommu_table,
 			pgsize_bitmap |= pt_possible_sizes(&pts);
 	}
 
-	/* Hide page sizes larger than the maximum OA */
-	info->pgsize_bitmap = oalog2_mod(pgsize_bitmap, common->max_oasz_lg2);
+	/*
+	 * Hide page sizes larger than the maximum. -1 because a whole table
+	 * pgsize is not allowed
+	 */
+	info->pgsize_bitmap = log2_mod(pgsize_bitmap, common->max_vasz_lg2 - 1);
+	info->pgsize_bitmap = oalog2_mod(info->pgsize_bitmap, common->max_oasz_lg2);
 }
 
 static void NS(deinit)(struct pt_iommu *iommu_table)
diff --git a/drivers/iommu/generic_pt/kunit_generic_pt.h b/drivers/iommu/generic_pt/kunit_generic_pt.h
index 68278bf15cfe..3672f1c7e4cb 100644
--- a/drivers/iommu/generic_pt/kunit_generic_pt.h
+++ b/drivers/iommu/generic_pt/kunit_generic_pt.h
@@ -427,6 +427,9 @@ static void test_lvl_possible_sizes(struct kunit *test, struct pt_state *pts,
 {
 	unsigned int num_items_lg2 = safe_pt_num_items_lg2(pts);
 	pt_vaddr_t pgsize_bitmap = pt_possible_sizes(pts);
+	/* Matches get_info() */
+	pt_vaddr_t limited_pgsize_bitmap =
+		log2_mod(pgsize_bitmap, pts->range->common->max_vasz_lg2 - 1);
 	unsigned int isz_lg2 = pt_table_item_lg2sz(pts);
 
 	if (!pt_can_have_leaf(pts)) {
@@ -437,7 +440,8 @@ static void test_lvl_possible_sizes(struct kunit *test, struct pt_state *pts,
 	/* No bits for sizes that would be outside this table */
 	KUNIT_ASSERT_EQ(test, log2_mod(pgsize_bitmap, isz_lg2), 0);
 	KUNIT_ASSERT_EQ(
-		test, fvalog2_div(pgsize_bitmap, num_items_lg2 + isz_lg2), 0);
+		test,
+		fvalog2_div(limited_pgsize_bitmap, num_items_lg2 + isz_lg2), 0);
 
 	/*
 	 * Non contiguous must be supported. AMDv1 has a HW bug where it does
@@ -452,8 +456,8 @@ static void test_lvl_possible_sizes(struct kunit *test, struct pt_state *pts,
 	/* A contiguous entry should not span the whole table */
 	if (num_items_lg2 + isz_lg2 != PT_VADDR_MAX_LG2)
 		KUNIT_ASSERT_FALSE(
-			test,
-			pgsize_bitmap & log2_to_int(num_items_lg2 + isz_lg2));
+			test, limited_pgsize_bitmap &
+					log2_to_int(num_items_lg2 + isz_lg2));
 }
 
 static void test_entry_possible_sizes(struct kunit *test)
-- 
2.43.0

