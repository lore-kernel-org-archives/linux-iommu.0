Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795780170;
	b=gwn/KsXgIXmvn5oJugvE5Fp0hcIIWfEdfX92baaWaeQeAttdDB9siFjYcYdKcs8O2gQ/
	 BJrD98UFtzw5bKqBupG/rA0hT/efMLrDP4TigqIfiysTI1BXMQz0j3kKOX52wfaIVsQwJ
	 qEme+NZw1umJwhKoM7NMtsVMg4+RQKHSPidyYeI4cq9UXy/pxo5o71Y+oIO8kzWu5AKfx
	 2k0tcEvPt5aCOCTqwuo65Q/FaTGA1KsL43Q3/P1uX5ruRt9i9ISKEDir8aPUJzANX9Zpd
	 DN3OAeYo2IY2BKMKG+ZLRdfPOtqPv/EpGGr1ft0pdvflLsCHp/6g4WfbRKy9rRRPslg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795780170;
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
	bh=IgET9iB2H07gGtEM8liQ02tr8B2rQLGd2KwqxG3tlWI=;
	b=2C0tqjJt5fk6IDbYghnFTFJ/DJPYVbZocX7YF+APLloY/t7k/DBV+UuZ/91h8S+pAjXA
	 IlnVYyKw6XkOjVpSMvitXcz0YUBdjxLCgOI++HzymXBPyoZSGXuUioVoefUJIY2NelNoe
	 k+7QNWqZgUU1VzzWY37gaVRhND272Yq0K3MBCSZO6eXHzSob1J0KuGeaeTbl7i4cX8owO
	 GyIGcGSaSl4VH6nQol1NwzLURPkCd+T+svLdztkDSc6st8AZguKqYPATmlfUnWRZtfuQN
	 jYysYa01j5qMw7DLvCenr+1CWwQhWITVfK3h7PE5Go7xVpqbrJJRUCCBisXTeXzdtLA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b="v4UyuN/n";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.46
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013046.outbound.protection.outlook.com [40.93.196.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D75D606A323
	for <iommu@lists.linux.dev>; Fri, 27 Nov 2026 11:49:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D75D606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=v4UyuN/n
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vKA5CcBdhh2wbIYTAK9BYNERuvD/KPUg2dPHbpqLb2MpbFdO/unHNfBbq1sU/ezAX5CXniq55e/N9XI0fipTEqfacaYxrAw0Hnx0V5sJFuyZu/8plOakq+ns7fugZuvkE95ocdVNIj7PUwtztGTVyquMVGgzyf+AW3oZByW+nhP2VRG1EGhvfyUFjPyXhYtfmHdf57PT+QqgG+v4o5VZF0LQk9v7wG+DE+pavHN1viFqEA+AO/DdjYxJwTF4cWjJEBykRo/fgBQWJzsfWlHOXHzkQrazn9VX3WJBzyCiW5IiIVLPh9wCaSo27XAFaKblJxKuDNyypkjLstor4bDzrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IgET9iB2H07gGtEM8liQ02tr8B2rQLGd2KwqxG3tlWI=;
 b=G/BTNo20krYJSB7O1w/vrxzAIBO6irKKMvgdM3ZWi9Oyu/j7/GX2qJ/q3f+tZxSRWPAdQ4xV6hYd3BCXjpLy/QMha6MCVMFC99lJDuyEZoRrCHctdH4iO7OS26zsXJD6OJxzMImI3mqqkd+G8PX+1UD/ob5hlT5/y7ZmmQzlw3OFMXhbWAtn2v4iqbJGVTxIgmdYwPWgJYTUch9ICbBZKQxR9ZSF1Zvnps8qc1/e7oOVIiCgt1B9DSkikr/76ktE9Qxh6PjBzvLUWrla+ckfhss4M9lDIO0BLrQuaTTqiiiXIA7IlZSXxecLKMEhc5rLkQu100tyvWbUPN+PpaFWSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IgET9iB2H07gGtEM8liQ02tr8B2rQLGd2KwqxG3tlWI=;
 b=v4UyuN/nETwHFaoT6ZB5WIqWXlY7TFarUv651J0jNx+g0VHp4ayv3Qsis2LMWXuT6f70dWXlbdxJ4Uxd45VYMytDuMk9BhfV9volCLa42+LP9pxmTNNYNb85JMJdfcVvBiwfr0tkW8m5tTw38jWgjbgFPcvXKS2Go3OCfPmGii8=
Received: from MN2PR14CA0004.namprd14.prod.outlook.com (2603:10b6:208:23e::9)
 by LV0PR12MB136056.namprd12.prod.outlook.com (2603:10b6:408:3b5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Fri, 27 Nov
 2026 11:45:22 +0000
Received: from BN7PEPF0000009F.namprd04.prod.outlook.com
 (2603:10b6:208:23e:cafe::6a) by MN2PR14CA0004.outlook.office365.com
 (2603:10b6:208:23e::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.10 via Frontend Transport; Fri,
 27 Nov 2026 11:45:22 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF0000009F.mail.protection.outlook.com (10.167.248.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Fri, 27 Nov 2026 11:45:22 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 27 Nov
 2026 05:45:20 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v2 2/7] iommu/amd: Fix page-counter drift in multi-level GCR3 table teardown
Date: Fri, 27 Nov 2026 11:44:30 +0000
Message-ID: <20261127114435.209548-3-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN7PEPF0000009F:EE_|LV0PR12MB136056:EE_
X-MS-Office365-Filtering-Correlation-Id: 607c2002-fe11-4137-943e-08df4c7beb98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|23010399003|82310400026|10067099003|56012099006|261026121527099003|261021121427099003|261021123027099003|261102123227099003|261009223027099003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	XlkogivnpEdA3TZy2dcRX5MhScBLdOgEXDAHZx1HjLp66E3NZ90ePEF1cDhEgvWGc5cNR+HfSg8jL/gQtRIGXd04UM+YhpYy45tQtzyehmn+cDRVDjGuCDLhSSgitl+tUGMx9VVBE/WlWAW+nVC2Kf6HOq3HNG3D8pGLHR9RWau4/dBKsz5Wy0eURufsJr6J5lsxzQjzc7PnM9/hvfceCqtNCr0bLu0Lh5LSGmlgxaktIzWkjVXZO18XvI3PxXd1AIuur9TfJjYagMRCc83hYrhn4axpy4KfhDkKmnVmc5rvfG14HN4DiAxEHbWqW46L/BGC1fBnIL0vS7YSB3aYVc7x/SPAS1dEIpvprUC7uljXiXoBGEtwmV8iatdszdMft7W2EWlGRC/6uV6szYvv1U5uRCtHaD13TQEfNqaWG9Vxel5ZF6Xa0TxkqYHMx962lQkKeknbdhhX2pQhQRv/wZEmOC8Pjt/ymZf4M3PBcpXeB3YQRP1WXOPZRwZIVGs+eDCVrZiBaeSfmVsx9ag88efvVZ0xHbsg9mXRs1N2ZX6zgpJShLyiKeX2aCP25YPy9NJtQYdqsxFZEflb1dk93z8CwR7n3bPfu/greRVvSWui2mzE5VM4RD/T5eEqfWJIJv1+hqNIl0h/Ni0yi+q6iYl5ykCXaqPQq3bXFCWnq4eNoZIXYbO6kIUivQ6rAcK7Lnd/xMc/jsQPDMbh0MIUvw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(23010399003)(82310400026)(10067099003)(56012099006)(261026121527099003)(261021121427099003)(261021123027099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	eagik7hkmaa2Zp76amoWofr1EXnXnHRkZqZnie5CG2Z0cU60zXDgbQl3Lpzdpj+AJq7ZPVO3yR7u9uSdbZOPt62Sc9DDSxLbwyFb3woPJg5rhrGnB6KRVMSsiaCWaDtxQSDKfB104GTH5/ylzy9rxx8TkT+F+SFspDKz8xQDDPkvj/AlnVOVgfQLZZdYXzrAEPiEr4YXmMRvUOOIOo/UsVFlk1L0n+i4enAhNV62AqAY8hEEwMVnDsal7QrahoYwacAv4UNX2tVOC1tfWfcnoAA9kDYO/fjY+Sw53FLNKigRhn3+IRdsxbat2F4Y/oUVz8NhmYoic8uVMH8wevcr9724Ldo684NvlE7SeoLbnS77//6grFWiftu7aFuZQ6RGA54QxWExdku1Uxr6HcX7qH9ytBHkIVd6B1xm7KF0MefEY8uV47ZmlOaB74I4Ripp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 11:45:22.6838
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 607c2002-fe11-4137-943e-08df4c7beb98
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN7PEPF0000009F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB136056

__get_gcr3_pte() allocates intermediate GCR3 tables with
get_zeroed_page(), but free_gcr3_tbl_level1() releases them with
iommu_free_pages(). iommu_free_pages() decrements NR_IOMMU_PAGES and
NR_SECONDARY_PAGETABLE, but get_zeroed_page() never incremented those
counters. So every teardown of a multi-level PASID (GCR3) table makes
both counters drift negative.

Allocate the sub tables with iommu_alloc_pages_node_sz() on the IOMMU
node. That matches the GCR3 root allocation, so the alloc and free
paths are symmetric and the page counters stay balanced.

Fixes: 75114cbaa136 ("iommu/amd: use page allocation function provided by iommu-pages.h")
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 22aef8ce98e2..ba6492e9bf0f 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2002,7 +2002,7 @@ static int setup_gcr3_table(struct gcr3_tbl_info *gcr3_info,
 }
 
 static u64 *__get_gcr3_pte(struct gcr3_tbl_info *gcr3_info,
-			   ioasid_t pasid, bool alloc)
+			   ioasid_t pasid, bool alloc, int nid)
 {
 	int index;
 	u64 *pte;
@@ -2021,7 +2021,7 @@ static u64 *__get_gcr3_pte(struct gcr3_tbl_info *gcr3_info,
 			if (!alloc)
 				return NULL;
 
-			root = (void *)get_zeroed_page(GFP_ATOMIC);
+			root = iommu_alloc_pages_node_sz(nid, GFP_ATOMIC, SZ_4K);
 			if (root == NULL)
 				return NULL;
 
@@ -2040,9 +2040,11 @@ static int update_gcr3(struct iommu_dev_data *dev_data,
 		       ioasid_t pasid, unsigned long gcr3, bool set)
 {
 	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
+	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
+	int nid = iommu ? dev_to_node(&iommu->dev->dev) : NUMA_NO_NODE;
 	u64 *pte;
 
-	pte = __get_gcr3_pte(gcr3_info, pasid, true);
+	pte = __get_gcr3_pte(gcr3_info, pasid, true, nid);
 	if (pte == NULL)
 		return -ENOMEM;
 
-- 
2.31.1

