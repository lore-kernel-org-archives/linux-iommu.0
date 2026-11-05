Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.57
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793854197;
	b=fraweQQnykicGKHgqCdc8fFENhXY35W03nSpdZaCvBPE6vVnu0dsxpCBkYoE3MDmQmaZ
	 PVUJIdVCFUHHWhotIB1Y6Zn7avJWLnaYuVquP2G2S7bcd8wWXknLffTQ8RTujX2WyhyDM
	 bRgCegll13AkcZRcShT2/Osn43iKM+jW4UDJUNoH8YK2ZACSHoHZ7NdIWXjB2GFCKaapY
	 TtW9cmuxQYEZsVteftfDi2VJK4F3eXRqt9dB/xkUPGDIWOk5jogXiAbbspBZOK8E7yyDF
	 TYaJv8jGa+nc7tUk26x6sM9ySDBGcYwJEe2jrHyGOVl5ja1J8dxLdkpGfWpnBWPL6/Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793854197;
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
	bh=Yha/ROPnmMaeb+L7NC5mLB2Ww9wkxhemGWSMSPSaD9I=;
	b=JEQS5mF6KXnPLwquEbK9bNw2sUXQijkpSABZXeg4Xht0lLTAAcKpKlAZNBqFUseDAz1Q
	 BiGl9nydR1RlKWnU7k9ESFziXIfXhA5JdAowx51vL+kp/A03SOw6DMYtzlXIPn8dOjSgj
	 64ztfFItTTLyIAjRfW05y7UGz6a21qEZgbos2Q1r1dNOsAGqSEw/aXHaSMu79Rpvnh2Lq
	 xojvBvtBfTf6b1VxRc4NJUAyi4Yp1eRvK8ucPYIIzW9QfPbw69qxo7vY5UpXK9Fi9i4k+
	 vGWxswx8b7/Ztz/K/Tm58GyeHu17yQY3qLrLAIUFu0oHHHjTO1WKSAY5Uo0xg9JLU/A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=l8JfAvAj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.57
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010057.outbound.protection.outlook.com [40.93.198.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D67E606A328
	for <iommu@lists.linux.dev>; Thu,  5 Nov 2026 04:49:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D67E606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=l8JfAvAj
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=InXG88AJgh/pBG6EvwETQrCxK0os6TBpko0Xqa/SJr//TCN9Y7wi0tfQwTLaikqo7l/I7eFg/iHW/mbhG2i1P2AiHJP58HUGnWEUa3DxawvX5CuLoINc6Ks0O2AnMVqcj442qIrrq//YCM3yxq28L6s97/o9K3ai/UBIYDeG+17CKSHYAWRl+fK26kPEkrQHNLb+6bXP4hntflxqrQhVMh8w1gnb9gzmKAS+n2/NuAKtySSY0K7X50kx4e9IhRFNuDYzERp3okGqlr1HFy23Tnn7X0OSkaoGPG2/ULeOH+AGRfyunCAYMx9cLtMjbnhOavJViyWi9p84ES79c762eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yha/ROPnmMaeb+L7NC5mLB2Ww9wkxhemGWSMSPSaD9I=;
 b=vnJL1JF9PtKJJs5IaCvGoM65d2s3X+/zJmuwTzE7lvWiAVO5nTa3CHv2l+LweYFH2BA9VA7ZFXXHqSnVo9GdCN8KtJwpVjmrgXs/u+Y8BOmYfFBS6MPE/vgVRBTw8G1n6xFOsbwlIpMQRuUKh6Ss+4Wj6UCo0VlBZC06CFJ4f5ULw+VFst0ZWpmzSNlY3bStV6HzT39gvWnSoTRS37QdhOrSRanbyE5dHtqYHQo0dgBImlyXUpk6qsDgrJ2EOmpBLm8ukxPI+SDBvUrGfsvuny/AItnCvhohJ05KseYjSQOhWuOX175creK3UmvnASFVsA8yYoWH4S2Fs/5szewoCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yha/ROPnmMaeb+L7NC5mLB2Ww9wkxhemGWSMSPSaD9I=;
 b=l8JfAvAj2+49Quub3IRyM3VS5/OGJ2jF0NS6J6xK8ZgfnnnbFW1pwp1AwuL1IQ2+HyusvM+4sWDdVgT8UtApo33kIf/G5Qc1qwKBx6Jm5i310XzBDoaUKNjLRNFclas9McpOKKZquCXxFMjP+OhIbEPqJcKwLpIxdmQLTZSu7iM=
Received: from BN9P220CA0014.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::19)
 by DS7PR12MB5767.namprd12.prod.outlook.com (2603:10b6:8:76::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.11; Thu, 5 Nov
 2026 04:49:52 +0000
Received: from BN6PEPF00000076.namprd03.prod.outlook.com
 (2603:10b6:408:13e:cafe::aa) by BN9P220CA0014.outlook.office365.com
 (2603:10b6:408:13e::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 04:49:51 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN6PEPF00000076.mail.protection.outlook.com (10.167.248.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Thu, 5 Nov 2026 04:49:51 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 22:49:48 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@nvidia.com>, Vasant Hegde
	<vasant.hegde@amd.com>, Max Zhen <max.zhen@amd.com>, Liang Wendy
	<Wendy.Liang@amd.com>
Subject: [PATCH 06/12] iommu/amd: Disable GCR3 entries from the SVA mm release notifier
Date: Thu, 5 Nov 2026 04:47:55 +0000
Message-ID: <20261105044801.399466-7-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN6PEPF00000076:EE_|DS7PR12MB5767:EE_
X-MS-Office365-Filtering-Correlation-Id: b470f0b9-f03d-4e79-482c-08df3af83a57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|23010399003|376014|1800799024|10067099003|261102123227099003|18002099003|22082099003|6133799003|56012099006|261026121527099003|5023799004|261021121427099003|11063799006|261026140227099003|261009223027099003|261022105027099003|261028144727099003|261021123027099003;
X-Microsoft-Antispam-Message-Info:
	+r9Jp9DrD42Rl+85lLNU9YWR+0+c6jdCz27IezA8ediCivT4YD5Qpv5WSuf/3MLz+zheE8EfIPkkCgr5ZT6jPEr9DjWh+jWTwjBZkEtU7smK9XmcvJ30dprEUEbOPZFrnCHACIhrP4CoKmox8UXGe4Q7//M4BM0cFwgdbdJvW+KNR2QsLXVv+pcnfekfLLKIZnDNdhFrv9gKN4zp/7uuLIUVSYOAMw56qeQIS4NSwuFIVy9cymfvmzjoxHY2TKz95czRj9swGIg8sDoeHE0umSQEdhz/3HL4DEQl96qk4Z4Up8lQRLYzGVEN8MyJhvJOzjNNyuOIBDrMBfm3+ifCi8DOAJ+dquWC2GV5vhuvLHljfTfUNzXv0IXTlchPEtzUWF5WWVR1O6TPb9ukixAOVXDjEfuMd7Wrk2Oe7UtQJcaliArb01tZYDoWSruRwjS686P25GR64sKQfCXmWg2EsDUANIFP/KEtj20ou5W+iQwO8W4MBWkD+Yg/PjQxsEby5T/Fg1yy7Yg+KUftetohYjSORas6Aq+cLDlwUZ3tSxOABYe5UGpFfsoEU4g3lV4P0TlHuXB5eKuWlmQwE+/hwU/tN/OTXEgMbTHMaMC8Y9XICI9C2CNlNuzr5SEU/B1Mcoqbb6K9ZJhGjUhELqm7weeA9fDtpfSFzA5sBXsn6nO5FU7qx+el/iotsqxE1PBN0Tuujb4uaQwaVq34zV5jJg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(1800799024)(10067099003)(261102123227099003)(18002099003)(22082099003)(6133799003)(56012099006)(261026121527099003)(5023799004)(261021121427099003)(11063799006)(261026140227099003)(261009223027099003)(261022105027099003)(261028144727099003)(261021123027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	gp4Wgrfs3/Vt4iexq1m/xkwKParK3N6hzqTKnBWGmBXwdZGs/YgHdhbeRxgv7IEzRCokr0uaK/ZelVrXOmMbUjLKJ2nr4IvVV3cWORb4p9IkgEMOFl+BDcI97lG6yvP2TNPO7i5s0zSKR6PNtBQerPIVL62KCwtZmuV5FUdMEMJqadOMXpk8WBcYftav85Dy/D1Xs4kSSqNAXFuq9koyo9wM65VUBkXeTjRtcROPxS4R2EzB5brsZwGsAFKenx1n5v3fqzeIh6edpCtkRhH1qhj9x+VAWguNaxXFbXZW3KJohbpFek+mlNmmXzXeQOqOMWnL+MgS0uWbJcwgdpsjigvSLJPB8pbc1IaSoVDx97mvT5UNbZvBB37hpiXyxoRo2Uq8aZsyup3cjcM7P8GWf8QBQLYdhnedPBcsClE5fm59Hg+Xtdc7CSMK+YRv51R0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 04:49:51.4538
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b470f0b9-f03d-4e79-482c-08df3af83a57
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN6PEPF00000076.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5767

sva_mn_release() runs when the mm page tables are about to be freed. It
calls remove_dev_pasid(), which invokes amd_iommu_clear_gcr3() without
the group mutex and triggers its lockdep assertion. It also removes the
PASID attachment and driver metadata behind the IOMMU core's back.

Split disabling a GCR3 entry from the normal PASID detach operation. The
notifier now disables and flushes each entry while holding the SVA
domain lock, but leaves pasid_cnt and pdom_dev_data intact. The normal
core-driven detach still takes the group mutex, clears the entry again,
and removes the attachment.

Fixes: a5a91e54846d ("iommu/amd: Add SVA domain support")
Reported-by: Max Zhen <max.zhen@amd.com>
Cc: Liang Wendy <Wendy.Liang@amd.com>
Assisted-by: Cursor
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu.h |  1 +
 drivers/iommu/amd/iommu.c     | 12 +++++++++++-
 drivers/iommu/amd/pasid.c     | 13 +++++++++----
 3 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index da93f7fb259b..b08df60afd22 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -77,6 +77,7 @@ void amd_iommu_iopf_remove_device(struct amd_iommu *iommu,
 int amd_iommu_set_gcr3(struct iommu_dev_data *dev_data,
 		       ioasid_t pasid, unsigned long gcr3);
 int amd_iommu_clear_gcr3(struct iommu_dev_data *dev_data, ioasid_t pasid);
+int amd_iommu_disable_gcr3(struct iommu_dev_data *dev_data, ioasid_t pasid);
 
 /* PPR */
 int __init amd_iommu_alloc_ppr_log(struct amd_iommu *iommu);
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index da20ce511a4c..3ecab557f6b6 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2044,6 +2044,16 @@ int amd_iommu_set_gcr3(struct iommu_dev_data *dev_data, ioasid_t pasid,
 	return ret;
 }
 
+/*
+ * Clear a GCR3 entry and flush its cached translations without dropping
+ * pasid_cnt. amd_iommu_clear_gcr3() drops the count when the PASID is
+ * detached.
+ */
+int amd_iommu_disable_gcr3(struct iommu_dev_data *dev_data, ioasid_t pasid)
+{
+	return update_gcr3(dev_data, pasid, 0, false);
+}
+
 int amd_iommu_clear_gcr3(struct iommu_dev_data *dev_data, ioasid_t pasid)
 {
 	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
@@ -2051,7 +2061,7 @@ int amd_iommu_clear_gcr3(struct iommu_dev_data *dev_data, ioasid_t pasid)
 
 	iommu_group_mutex_assert(dev_data->dev);
 
-	ret = update_gcr3(dev_data, pasid, 0, false);
+	ret = amd_iommu_disable_gcr3(dev_data, pasid);
 	if (ret)
 		return ret;
 
diff --git a/drivers/iommu/amd/pasid.c b/drivers/iommu/amd/pasid.c
index 87fd2688574c..214e7dd2ae76 100644
--- a/drivers/iommu/amd/pasid.c
+++ b/drivers/iommu/amd/pasid.c
@@ -79,7 +79,7 @@ static void sva_arch_invalidate_secondary_tlbs(struct mmu_notifier *mn,
 
 static void sva_mn_release(struct mmu_notifier *mn, struct mm_struct *mm)
 {
-	struct pdom_dev_data *pdom_dev_data, *next;
+	struct pdom_dev_data *pdom_dev_data;
 	struct protection_domain *sva_pdom;
 	unsigned long flags;
 
@@ -87,9 +87,14 @@ static void sva_mn_release(struct mmu_notifier *mn, struct mm_struct *mm)
 
 	spin_lock_irqsave(&sva_pdom->lock, flags);
 
-	/* Assume dev_data_list contains same PASID with different devices */
-	for_each_pdom_dev_data_safe(pdom_dev_data, next, sva_pdom)
-		remove_dev_pasid(pdom_dev_data);
+	/*
+	 * Disable the GCR3 entry before the mm page tables are freed. Leave
+	 * the PASID attachment and pdom_dev_data for the IOMMU core to
+	 * remove through the normal detach path.
+	 */
+	for_each_pdom_dev_data(pdom_dev_data, sva_pdom)
+		amd_iommu_disable_gcr3(pdom_dev_data->dev_data,
+				       pdom_dev_data->pasid);
 
 	spin_unlock_irqrestore(&sva_pdom->lock, flags);
 }
-- 
2.31.1

