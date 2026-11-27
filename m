Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.23
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795779960;
	b=abplHroDMIgl4we24Q7MOKN8p67RhVgW8UaJrlar1eVdXHhC8lGlq74+ZQl1QOfmCTPW
	 /VPgRtA4RIYUgCwsHSTieGs8TMYuxvfZ12pLu+A3aTg04Ak2BtCy/Gx3d3fmFrZhYD9O5
	 KXogwBmTZP4abBDE084oImgAqTi3zK3/GPek7qaAkbC5TSiJZh/gQr9BNzttycHcGY5M9
	 oJmr0+gNhRGR9iyXoU6pwivr6729qpiy74bWO0YI8ehJB+GpHqCJtKiMGZ/uJ7+WfpAxv
	 q3SgJz7nrTQAL6YyfFIzxWbc0E1g/yoDMATZvt0WFj38076lkJdpYsL8IqCBUI19s7w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795779960;
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
	bh=Im+6fBMPwB9B/nZ6mxETQmmRsJEL6p/skqd1QUslVkI=;
	b=vOIQkWSzPJ5/OymWi7zFs4lwNy2hwwbGANTFLzlcyo5DodAGZA4l8Q8tFnAmlSZPv0Ce
	 BinUMQBsEqtsCU4OF7ITy6CZO2HmfXjLuEfITSzsK7KU3YVlj0U3llHrN+U6ROdsqH6++
	 jL/0+jq/f3AtuhMNouYwAIowODJKO47TivdvoEwAx3rTsI/Rbh+aNmDhcgXKNp3kW7u/o
	 b2dweghVyWOidRJIX0u2RGNh7h7haJCiBPkMul0dFRumPCTvya9opKh+v9RYcK4BdqNEg
	 ys60UcLgUW92qZ6B4l5O5uBTOCSsVcO49Q0z3C8lHy22z1H958qE0GAzNJvM5CXneDA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=IYY7KRel;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.23
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012023.outbound.protection.outlook.com [52.101.43.23])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F52606A31F
	for <iommu@lists.linux.dev>; Fri, 27 Nov 2026 11:45:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9F52606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=IYY7KRel
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RVGKkb3At01xcHCZOvvGnvBGYtLbrrdfXvRdWQA5Jm+LUrw4N82h1t5zwubjB8HkQPvmw4BJnkYJMXL6ctzSi0/vFXiT+szeCdFTj/hp0BoIZAwEIgZbRwdIoNrDb6tnBjRxpPGelZvwkL+ks0TZJ2LakviImeSQkeqsXpVlMWRWrmPHxIIg0rCSQ1gTh36/rNgXQV7/RIopw3KhxPgLz7hTOkHKN6BKJ57Do4Xp7LEHIgIlSl0K8tPCAVlbHEYVX9ri+FmQKEOeahsVl0ONo6kT/8+WW1hX1xZ6I2huBoZEcvrsU4jGDQQsVf+RGtZzqfySzYupb2DH7GHsH2zB6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Im+6fBMPwB9B/nZ6mxETQmmRsJEL6p/skqd1QUslVkI=;
 b=J3E3g1cJ/E95sE4Ka4uQ125vVND2DkVIgBGdYF0h//CdbgkvtT4/8HbIuvabcR4sDzmh77myK5E72lqlkZaFpcnSMr9r9FYI1zw/2gX0Df8CypSgQeT5EN42DrYM3/YuEF85ywzbiLJX7DkrEmOeLYqmBxX/jO543lcsz5GjeYV4DdrjQM0Fd8yvn/CfvbZyTDPDbTcIVfer0gM/de9SZjKXU/OBGsXGowOnKEXrHq5UaCtCfkA7APrGTi96n4/m82KaBdven7BkAlRkO8J0M8wUEFdBx2B4NcG7m1pLW09LylftDbaSx/JRJs62ZRAkyRjOpAR2bkwsM/5S+Ow6Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Im+6fBMPwB9B/nZ6mxETQmmRsJEL6p/skqd1QUslVkI=;
 b=IYY7KReljbdmjQokKmYbFDSJzvhwWTsPmFGNP8rI78x2Su+eTuMkDjHMHs6StsCyMEUdQqeI1nO19uE1gSCkyCPQL0mEUo5ZiV5XnVbt8aEnHcaCnQYVgsNBLaxTR49ERXipLiPu4jVs6sS7Acnn9vdgklaZ8vOjr6Y990uiUBY=
Received: from BN8PR04CA0048.namprd04.prod.outlook.com (2603:10b6:408:d4::22)
 by CH9PR12MB475785.namprd12.prod.outlook.com (2603:10b6:610:353::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Fri, 27 Nov
 2026 11:45:55 +0000
Received: from BN7PEPF000000A0.namprd04.prod.outlook.com
 (2603:10b6:408:d4:cafe::1d) by BN8PR04CA0048.outlook.office365.com
 (2603:10b6:408:d4::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.9 via Frontend Transport; Fri, 27
 Nov 2026 11:45:55 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF000000A0.mail.protection.outlook.com (10.167.248.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Fri, 27 Nov 2026 11:45:55 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 27 Nov
 2026 05:45:51 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, "Ankit
 Soni" <Ankit.Soni@amd.com>
Subject: [PATCH v2 4/7] iommu/amd: Allocate the completion sequence after queueing commands
Date: Fri, 27 Nov 2026 11:44:32 +0000
Message-ID: <20261127114435.209548-5-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN7PEPF000000A0:EE_|CH9PR12MB475785:EE_
X-MS-Office365-Filtering-Correlation-Id: c40b788c-9a7a-42d9-0a69-08df4c7bfee0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|23010399003|261009223027099003|18002099003|22082099003|3023799007|10067099003|56012099006|11063799006|261102123227099003|261028144727099003|261026140227099003|261021121427099003|261021123027099003|261022105027099003;
X-Microsoft-Antispam-Message-Info:
	es3oCi4/HjAqqiN5jqpOPXNZvdE8rqTWeWxoO3AyNxOeGvDBEsvESVZdJWxYqSkNu07W4RrVO+hJSdd7cOnUMDfZfIp2xpaQHb1Df8lX05138lYzqxS7QQrhCcoRsuDu0a00yDJ8KbNlMKfka54a/jPImUAdJhTxJEnpUlGZnsYVPdmQte1qGApqqu7Kb1yrBG1kl7SyLb70h1Zo4smBtFcUSlwwTt38tgx3p0oPspyScord7OF+wDfictTsgRVgWvwP3GUMLU1UgQijSrvgNQvE6LrB57e5N9nSpT57toyAKV6AgcFWDw6UOEQTzvjvS3sBk101LGy+lm5e8QekFTvxfK0WY0SjUJfz54kqDUjltvA+WWPdFH6iOZm3qZf9s/J9135px2rMw47INkF9cOTHg3B/JfzL9sa4pI/uLACjJhmCrX4tHpEApZUPD/0JYzgG39ytkdbcg88FXl+biwPa1mB29jUTu7QiQf56x98m+LEuHQ1vcOBQrFvp8mjFT4b7DcbskMOEiPBkOhGMDKUsSf6BN3x9v6s8T3yJkn0TCR8A+iuAZ1VqOhuvfglBnwfxGqWrbAO4CL7ZhEbgCBzzDRvNahBVZ2aQns6XU7naTuDmrGZhUOjTnjV8wfR/nDO7+J7PmfNZBW69ypA8/M2A4LT4/FuU26OTzmc/O10IxJkftstF6ZjyCQrfrd8yEvXAzmOD3VZiJrIEEGG2AQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(23010399003)(261009223027099003)(18002099003)(22082099003)(3023799007)(10067099003)(56012099006)(11063799006)(261102123227099003)(261028144727099003)(261026140227099003)(261021121427099003)(261021123027099003)(261022105027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	P06x+SpCsa8OIwnHi4r7MUygz+ffrhEqUaHIZ3Pup4zlV4g7Zg0agqzI+4eh/G6BM+/9HJ9pyNJdLc6VkRVfFYfuw6HtUOab5kbImgr8y98GIn9GSNoV9GGC0pECVpk4ZRXlZHE8brfQeS4AQzexKJN3IqDW94L3JHEk3xLtnfx/qe/GMmcl0l/fIUksf6AgE4HudWAekR7RuDyX69Gbt0hiyUl0U7SfjXXyUkMpVkx/SGRrlweh1R7Eok5JnZVbyCezxEUSW++jzDA7oAVNPVh2q/KYzgN0GcdVeUb4HIHRzBPaLTUfDmDWjnhNUIMq9J1kvtGfNNKCBnER6Jzom/YC3t/nBZDtv1I3JX84JVnLyHUUaP0eNG5TjTAMwheFgE10wnCVQkzH4vBBAgCm2WUdt6ANcwmWRlQLQnpPKQcZY4RpUc8eOOsbJw+bW11O
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 11:45:55.0280
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c40b788c-9a7a-42d9-0a69-08df4c7bfee0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN7PEPF000000A0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH9PR12MB475785

iommu_flush_irt_and_complete() reserves a completion-wait sequence number
(via get_cmdsem_val()) before queueing the invalidate_irt commands. If one
of those commands fails to queue, it returns early without ever queueing
the completion wait that would store that sequence number.

Currently this is harmless, since iommu_completion_wait() is only called
after some command has been queued. But allocating a sequence number and
not using it may cause problems in the future.

Reserve and queue the completion wait only after the invalidate_irt
commands are queued. Move the locked sequence allocation and queueing into
a new __iommu_completion_wait() helper, called from both
iommu_completion_wait() and iommu_flush_irt_and_complete(). The caller
holds iommu->lock; the semaphore wait stays outside the lock.

Cc: Ankit Soni <Ankit.Soni@amd.com>
Reviewed-by: Ankit Soni <Ankit.Soni@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 50 ++++++++++++++++++---------------------
 1 file changed, 23 insertions(+), 27 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index cd34ca735da7..a9bb8d50146f 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1436,24 +1436,11 @@ static int iommu_queue_command(struct amd_iommu *iommu, struct iommu_cmd *cmd)
 	return iommu_queue_command_sync(iommu, cmd, true);
 }
 
-static u64 get_cmdsem_val(struct amd_iommu *iommu)
-{
-	lockdep_assert_held(&iommu->lock);
-	return ++iommu->cmd_sem_val;
-}
-
-/*
- * This function queues a completion wait command into the command
- * buffer of an IOMMU
- */
-static int iommu_completion_wait(struct amd_iommu *iommu)
+static int __iommu_completion_wait(struct amd_iommu *iommu, u64 *data)
 {
 	struct iommu_cmd cmd;
-	unsigned long flags;
-	int ret;
-	u64 data;
 
-	raw_spin_lock_irqsave(&iommu->lock, flags);
+	lockdep_assert_held(&iommu->lock);
 
 	if (!iommu->need_sync) {
 		/*
@@ -1465,15 +1452,28 @@ static int iommu_completion_wait(struct amd_iommu *iommu)
 		 * command queued before this call (possibly on another CPU)
 		 * is guaranteed to have completed before returning.
 		 */
-		data = iommu->cmd_sem_val;
-		raw_spin_unlock_irqrestore(&iommu->lock, flags);
-		return wait_on_sem(iommu, data);
+		*data = iommu->cmd_sem_val;
+		return 0;
 	}
 
-	data = get_cmdsem_val(iommu);
-	build_completion_wait(&cmd, iommu, data);
+	*data = ++iommu->cmd_sem_val;
+	build_completion_wait(&cmd, iommu, *data);
+
+	return __iommu_queue_command_sync(iommu, &cmd, false);
+}
+
+/*
+ * This function queues a completion wait command into the command
+ * buffer of an IOMMU
+ */
+static int iommu_completion_wait(struct amd_iommu *iommu)
+{
+	unsigned long flags;
+	int ret;
+	u64 data;
 
-	ret = __iommu_queue_command_sync(iommu, &cmd, false);
+	raw_spin_lock_irqsave(&iommu->lock, flags);
+	ret = __iommu_completion_wait(iommu, &data);
 	raw_spin_unlock_irqrestore(&iommu->lock, flags);
 
 	if (ret)
@@ -3287,7 +3287,6 @@ static void iommu_flush_irt_and_complete(struct amd_iommu *iommu, u16 devid)
 	int ret;
 	u64 data;
 	unsigned long flags;
-	struct iommu_cmd cmd;
 	struct pci_dev *pdev = NULL;
 	struct iommu_dev_data *dev_data = search_dev_data(iommu, devid);
 
@@ -3298,9 +3297,6 @@ static void iommu_flush_irt_and_complete(struct amd_iommu *iommu, u16 devid)
 		pdev = to_pci_dev(dev_data->dev);
 
 	raw_spin_lock_irqsave(&iommu->lock, flags);
-	data = get_cmdsem_val(iommu);
-	build_completion_wait(&cmd, iommu, data);
-
 	if (pdev)
 		ret = pci_for_each_dma_alias(pdev, iommu_flush_dev_irt, iommu);
 	else
@@ -3308,11 +3304,11 @@ static void iommu_flush_irt_and_complete(struct amd_iommu *iommu, u16 devid)
 	if (ret)
 		goto out_err;
 
-	ret = __iommu_queue_command_sync(iommu, &cmd, false);
+	ret = __iommu_completion_wait(iommu, &data);
 	if (ret)
 		goto out_err;
-	raw_spin_unlock_irqrestore(&iommu->lock, flags);
 
+	raw_spin_unlock_irqrestore(&iommu->lock, flags);
 	wait_on_sem(iommu, data);
 	return;
 
-- 
2.31.1

