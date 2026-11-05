Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.40
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793852239;
	b=Jk1wvssods0ovRIfVsbEAyRsFxqKt42An8tPQajOSTVmpeQm11H804M5A48/OkOyOPTC
	 jJj/S0tDbW6puIcxPpGJLFiaKFqg/rvi6fmGWBUV5RmgerniNUz3JX36NeCZzFTXdGtNE
	 aelaZM6GePey+tVDC7vBDv1QTbFuSWAmGh58I3ngq6M4dgP02xa4aQM5ocMzzo6kS2i+v
	 k4JAQaZpEYCBSxnOEoNNK1c9jA8jZH/z5AiOMCV2QtBDW880WFeHwYH6F/E3k2kAgt5Gv
	 o/3pNrKrd/uPSHKrx9djk3H78wvvHx1O19ASiL6Q91nwiGWwfAoO2EE+BWzXnfgU+vw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793852239;
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
	bh=psQsaNNKS6DfMRgcksTfW345uJyB0dWreMzRkjM0m9I=;
	b=lJPQSavOicK8tX/8z2TnG9Zikv3/ZtJaJdj3qhTS/YaVp09bTbQUbqy5FLQSpeoWX9fj
	 i2V0e49mwl+CC60ExKARZEMhviMZV6882GLncclo2tktcAdOlSfYFFyiwXnP7474YFCBH
	 itMmVz4EjLyEnQZXVCYiciVeXLh2ibcwKF3gLkiW3oBbk/DhV/DVSs8pbhA9oJOdIxzni
	 3pkX277eGt3DckrcipGA5hp0VlVhAFywtIb4MErQ/+PvoOKbRkjsHcM876dhCjtxC/wqU
	 PtWj8dELwMkbYsR/G3pmpk9I6zJ+SyP/0peeApJCKlD3FUqrMZEZXoo8hvBFPcHoNvA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=YIOmOe84;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.40
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013040.outbound.protection.outlook.com [40.93.201.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3FB606A326
	for <iommu@lists.linux.dev>; Thu,  5 Nov 2026 04:17:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D3FB606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=YIOmOe84
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CIV2KZ1jZxuI753voZ0E2R1EzPhE/bjEgf1LYxit4Kxo0TFzn7+/ebxcn1/4IELqbh+sP43O9oZRS61dh8bJzLw5hq6ABK1//EEPPV0jmUeKMs2FkgzQs9EFRJ4PmshnGWxwlRWjIRA0XzV/Wro/jWYBwMKeeuSMlE7BDVZ5OheIB0NC2A94r1fDTOLrd3Hj9eJXfS8gnbiC1H0J6rR8qKzeGK0mH0eDn1RXvoNzoqj5spZ5ocG0CbF/VVxClx2Xyl8hLBOhxlJo6ydb4hsGr7MjbjI37gG96B7TOHecKL8Bj5VJZiQrOufaQGJh134vsSiRgHBvNUdBJPEKJPgidQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=psQsaNNKS6DfMRgcksTfW345uJyB0dWreMzRkjM0m9I=;
 b=q/glIT9UXWTIfjQCMvalkv07cmuVFYGiSErYhf7SqDPxe8/pylez1qW/5jb2iJfILk1kabwcbHn9Z2AeScIV0WIrHU+93kg7APfc7yVr35DSjI2wrYHKgt7G1urxsCqZ0pGXVd5U5Bfns2Cn6nf2rg27ppOWgRRdFP9aYY29MfFC2+1l/T1RLrQFFV927ydjqi7SClPIb+B13757abKg6lwrWhkWNpB5YkQip1GUIG9d6MFcNLIWbaDQAnR8JPHdFoNX+YXmslFRkMJuDz8MOf9e48sahzKDBvfks/3jHMbBeV1QNjsdAqbP10kDvEwgwrZUyEhrLxA73+U9igt0/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=psQsaNNKS6DfMRgcksTfW345uJyB0dWreMzRkjM0m9I=;
 b=YIOmOe840MSquF5RD1mY02IBTWjhlDggGiYZEzyn5cP6RjviB8cy3QkMdVg84gusmzz7Um6mbfZS6UG6I6gsc1djenlhRT+Flo+R6QcvwUUw1P6/+hVBuIMI02AWsoC8YbGD5cJR1VLL0COKD0rN7+uv5kiXeiPxOkfyzjLcWrk=
Received: from SJ0PR03CA0069.namprd03.prod.outlook.com (2603:10b6:a03:331::14)
 by IA0PR12MB8326.namprd12.prod.outlook.com (2603:10b6:208:40d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Thu, 5 Nov 2026
 04:17:12 +0000
Received: from SJ1PEPF000037A9.namprd03.prod.outlook.com
 (2603:10b6:a03:331:cafe::2e) by SJ0PR03CA0069.outlook.office365.com
 (2603:10b6:a03:331::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Thu, 5
 Nov 2026 04:17:12 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037A9.mail.protection.outlook.com (10.167.244.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Thu, 5 Nov 2026 04:17:12 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 22:17:08 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 3/4] iommu/amd: Call the GA log notifier inside an RCU read section
Date: Thu, 5 Nov 2026 04:16:02 +0000
Message-ID: <20261105041603.399016-4-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261105041603.399016-1-vasant.hegde@amd.com>
References: <20261105041603.399016-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037A9:EE_|IA0PR12MB8326:EE_
X-MS-Office365-Filtering-Correlation-Id: c5f8e578-29fd-4312-f2db-08df3af3aab1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|36860700016|82310400026|261022075727099003|11063799006|56012099006|261009223027099003|261021123027099003|261021121427099003|261102123227099003|261028144727099003|261026140227099003|261022105027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	C3c2gU/9T8u15JDMrGLP9DYsIRGbHNF4Wgz5U4E2q1pL/8TnswDqRuzj1vbTb+KoLL0U7yKaZnhj1bcf6mF/DNNhFujW8DllaaAoh7SYgW2cD9XIzg+6FiBw5B1r5XKjHURwj+iB1sR4m5UYZvS9kLymronwzqE0Jj/lf7Uaa5UdBlBCsdZkbiV7bOW+WnnABn9dY1y/mrOYG5JV7Lmacc5bkLXUqS1r0dBPltRJ0vp/IBMpBmZijNaBKjoT40JelhHqx/jFBPlWBw7SSLX+N7YvPrIs+ctZxxWcQFyNDWSGqKDf1CFUxQcXFWlssnEceYGD68nrzUTEV+VKPibLt437R3ZuZPieSTQWKp29QqhKv9lhgoBr3PuPguIQhAHRNUIg695RVBbiM3e/hlrVCBQJMNPkGLgJHBGnJ0tpIWOqgKhIf3I1rSNxs5lHl7/wViS0FpOE63x3KdKVTHZDurxAQ8LaFrWgA6I7wdLW0ptJYGZoxpLHF8Zn9jPe/vkKssO456102eL+JmQV4MgOgQrcDTFxwVDLy/z0GlgyHbdbJ5ul/q9oRUgeJ9hw7IJSbbHYy+KxlRJckX9WJ8Vxjlc8nxrMCoOsLM3J4LmE5on9z2U9gedvsEvYypECzw4svjjIDznQS+bAGTr29RQaPp+5Pk+f5lJvPw/ggvtTDbTdzKcutCiapVT9oWdAfff+rcGa+nI0spUivURX4Y5PGQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(261022075727099003)(11063799006)(56012099006)(261009223027099003)(261021123027099003)(261021121427099003)(261102123227099003)(261028144727099003)(261026140227099003)(261022105027099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hpqPwPqC4RA0490B5IsWofVjTfGQJ1+gEerhyDD1OLUnlUjj4OBAu8CWBTCMxhq+MaYdIIEhjCBEIX0s/Gqyi/XlN/F2lzxyc+6aNob0niF3INWA/WV+u+tHMY7JbSjEwYXzvPnl2JVWIZhEK6EhG+Y+yPLMRb3RM63LPZBq7MI19Xt7x5rcayRE2OeeL/rkV6I9v7jcn02xgwEQBZNeDHiBdjyoBRKyNUvPZdXiOBlOAL4nUUN5GmrV3P6FUvnxoTOas4UogBBu+BLJANNMlugGBvg8+HxU+zudbchwtwpLzE0fmoCqdM2Wy9aCwTZiQ0okIRiOUH6ln4f+zVDT7AnksP2xMVFpK6sFXq42aoL+q1sIYORfvhYq30y65hW+8dRvt2DdbRSJ4NpCaWit3yg/UVtofcLzrOE3H4z+xWUKft8S/hN1WedCq8yIvPpp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 04:17:12.3899
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5f8e578-29fd-4312-f2db-08df3af3aab1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000037A9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8326

On unregister, amd_iommu_register_ga_log_notifier() calls
synchronize_rcu() so the module owning the notifier can be safely
unloaded once in-flight callers finish. But the GA log handler never
entered an RCU read side section and loaded the pointer twice (once to
test for NULL, once to call it). The grace period therefore did not cover
the call: a concurrent unregister could make the second load see NULL, or
free the notifier's module while it was still executing.

Mark iommu_ga_log_notifier as __rcu, publish it with
rcu_assign_pointer(), and in the handler snapshot it once under
rcu_read_lock() with rcu_dereference(), testing and calling that single
snapshot. synchronize_rcu() now correctly waits for in-flight calls.

Assisted-by: Cursor
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 0efe6a58f6f9..8c09be157750 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1019,11 +1019,11 @@ static void iommu_poll_events(struct amd_iommu *iommu)
 }
 
 #ifdef CONFIG_IRQ_REMAP
-static int (*iommu_ga_log_notifier)(u32);
+static int (* __rcu iommu_ga_log_notifier)(u32);
 
 int amd_iommu_register_ga_log_notifier(int (*notifier)(u32))
 {
-	iommu_ga_log_notifier = notifier;
+	rcu_assign_pointer(iommu_ga_log_notifier, notifier);
 
 	/*
 	 * Ensure all in-flight IRQ handlers run to completion before returning
@@ -1059,17 +1059,22 @@ static void iommu_poll_ga_log(struct amd_iommu *iommu)
 
 		/* Handle GA entry */
 		switch (GA_REQ_TYPE(log_entry)) {
-		case GA_GUEST_NR:
-			if (!iommu_ga_log_notifier)
-				break;
-
-			pr_debug("%s: devid=%#x, ga_tag=%#x\n",
-				 __func__, GA_DEVID(log_entry),
-				 GA_TAG(log_entry));
-
-			if (iommu_ga_log_notifier(GA_TAG(log_entry)) != 0)
-				pr_err("GA log notifier failed.\n");
+		case GA_GUEST_NR: {
+			int (*notifier)(u32 ga_tag);
+
+			rcu_read_lock();
+			notifier = rcu_dereference(iommu_ga_log_notifier);
+			if (notifier) {
+				pr_debug("%s: devid=%#x, ga_tag=%#x\n",
+					 __func__, GA_DEVID(log_entry),
+					 GA_TAG(log_entry));
+
+				if (notifier(GA_TAG(log_entry)) != 0)
+					pr_err("GA log notifier failed.\n");
+			}
+			rcu_read_unlock();
 			break;
+		}
 		default:
 			break;
 		}
-- 
2.31.1

