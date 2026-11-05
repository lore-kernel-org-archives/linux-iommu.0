Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.23
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793852730;
	b=VCAoQ2CNToTDqKbuzzIpW2VIevlxt3bOZpI6/H6Z0ADLe+Qu+OMmYAszKEVidVDhJK/u
	 WF0cvUz0PDViqswgc7K0UfitSW+mnzj60UsjS5S4ssUQCEf4QdTVaCDDm/4IHjVCrdXlp
	 9NYN4gpT/fStsoCjihy228GJaLfNzTj89YW06VX2ETc9YSSep8eILgO6kkUZLElBvFOsF
	 7GTsYSyq6ywcxu0K6cTSorJQ7KbanJeZ7iKmEkn3M/DV0XUS6fJ8csCKYBReuqV/SsKes
	 4b3NyOkFZ+hNXwTp+rSd4RObiVGcWsdWc4FEBuElCJjqOnyI5YwUE338gekz5eMiULw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793852730;
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
	bh=XP5lhkJNVbnwGXoJ+IxdEYdXw+P3w1LVls/yzxZWQgk=;
	b=Rmonn2fnXSqf4xfiIu7qviU5YZ0bi4V3YUQuEGQAUxjmw1t41kyT9akKmqBw7+rU+ZoT
	 eicqaXin8Fa0NVMZyW3r42Q95V6UbW1M7w6du1OWFdTwYvbu5cfTi8UCUU9ZzVVRBGFSO
	 oMiYm7g9Ij9bXfAKGT+I6vIPB3n8o3J1ayuevkhzHk1LNgLsiTetvJKVoD5D4s+KFHD/n
	 yNLegxCUc0Gf8xFQvFSLQeMN+Baj3TnUXGksP/FLOktOyfwlBuNd7xYtITPMDNfrekVql
	 OMUJ7oypjASw/zCVbIJ+01Amk+gIsfzqbq8hB2p92bWKwImu3zRGD/oiSdraATL65BQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=kAYkkNDk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.23
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011023.outbound.protection.outlook.com [52.101.62.23])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42A0606A328
	for <iommu@lists.linux.dev>; Thu,  5 Nov 2026 04:25:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B42A0606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=kAYkkNDk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LU66yCrXVJMhhEJvNmepehIDowtO3e9FFxSUfzsHW4T5nj/Lo4bu4eXxe9l56R0RpmwQFW0QatZSPywPEU8mcyTOSvzsSrvKMpTqc/18tXun7Imwu4BjnoUtks4Rpy7VeueyBlNanqE5paLSGfjAc30whhEw6oDspoqIoKDaGsdxR3gOr1w9+BQXPrGrCdF/A0rzbf146Gd2wbKhsTiC3DOQlMweI8iweGoBZ1od3JlCCfd4k/SXwchWZ1/jJfa/C5Pr7CqanMLP6TSjA33WBsUMLuSsKu9DI9rByIXG+6i2BdVlxNpYNzcB/ntQjO3n5uTFWhQaX1yWpA8AJJUCVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XP5lhkJNVbnwGXoJ+IxdEYdXw+P3w1LVls/yzxZWQgk=;
 b=sjCmZFPiSQ0sQDloKex2yrrZ/+c49dE+lWkyl3KkJDMn8CQ8mteqwQKOYGwXrNQ7aV46+8UctJQIeIcEDGVACaZj0XRx0MxxQ82pU+cBc5d4ZUq5Zw6u2tUEjOU0/xoZpcgNrrmeKcjUCdCxpCH2hG4c6j9g/SrrFIKV1Q911jVC9vJ03NoBYMB/BiyhFLuSsubs5CJRZDyJ+HQ0cZ9l8QbQdONDvDh6pox3Mw9xutg1k+aqZGSy1mx5uZVf6/0905e/v3AniUcYBdF3z712HdaXA323JKgaI34cLcSnucEdTHnr0D/vmKmXQf3jnTpo8ob4kJc3VLD65a8NsxZTUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XP5lhkJNVbnwGXoJ+IxdEYdXw+P3w1LVls/yzxZWQgk=;
 b=kAYkkNDkVR3h6frRihDW8/ULlFkZ6lNpadWYjYjJ2/42msTqTV/Gs5N83Z2F9o2jHs9ZGgkOYIY6opXvkq08aLXXAB4CvIEbDdJSVBpubL/4s3TB27zMSEJG2+o8uVgkPU0S+lHuC+dlz73O/zLgDaZ4wRIHGAf7ktd+1CXKmfc=
Received: from SJ0PR13CA0038.namprd13.prod.outlook.com (2603:10b6:a03:2c2::13)
 by PH8PR12MB7301.namprd12.prod.outlook.com (2603:10b6:510:222::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Thu, 5 Nov
 2026 04:24:20 +0000
Received: from MW3PEPF00001659.namprd21.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::40) by SJ0PR13CA0038.outlook.office365.com
 (2603:10b6:a03:2c2::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4 via Frontend Transport; Thu, 5
 Nov 2026 04:24:20 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW3PEPF00001659.mail.protection.outlook.com (10.167.249.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.0 via Frontend Transport; Thu, 5 Nov 2026 04:24:19 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 22:24:17 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, "Ankit
 Soni" <Ankit.Soni@amd.com>
Subject: [PATCH 4/7] iommu/amd: Allocate the completion sequence after queueing commands
Date: Thu, 5 Nov 2026 04:22:51 +0000
Message-ID: <20261105042254.399163-5-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261105042254.399163-1-vasant.hegde@amd.com>
References: <20261105042254.399163-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: MW3PEPF00001659:EE_|PH8PR12MB7301:EE_
X-MS-Office365-Filtering-Correlation-Id: 12b3d07c-e148-476a-70e1-08df3af4a989
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|261022105027099003|56012099006|261009223027099003|261021123027099003|261028144727099003|261102123227099003|261021121427099003|11063799006|261026140227099003|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	F5Kojb6V16HvN4a6Jxr/VE847tfjXq4WxpNnWjDbBpK00rznNsa/+xcQ+yFBDZAjapXxkA2gKJuMsD90l8xWppTj+kHxW3QiyCM0k8ThyUMiWIXGQp4g8i+n+qrWv62QQOirVPfT/BwrB7kXtn/rm5kJP23lOBswTs1ief/hxqC1JtnKGUURk9gZ126+XzebkiKynLKAgvNBhvY11c6zrhbPyu558joIZnJUMSG5rb+/olfk2K+kVNNNfp3bYlGZHQs9xPMiwxypM0HpHFaJFN8OsoW29tou99L+UqiIm3kGdOUdrUTgunIK0qIJMYeP2c09V4Ht3e9WdkyAUHovYiC6lds8Jy1sDjpmklOG06Fa5jE2coOTVydKKWOQV0PSU9Y2JcRyrF6XSMyPqOifhCUGapzLhuXtMp7PFc9xdhKkFe+zkir8Wjo6BNX5aDW09CVrcFjfXgG8WpJ3/EO24yy0OJHjkhRbyHbpPQ+2bp/vtaf93yu1kymMqJs0RAi7snHPB+DcAplOmXi5TJxodzweKTEmbC62HV7Fokb+tRrjRXVpKdZvucEWxSHpGxbrxy/xeYGz1p/p/HrlY9l/QslkExASui7bQvi0mq2KmMBhShC8NieSraYsse9276e086tOT72dpXkXH54nRv7pTmACPXCLvsj7qyMxHu2dSLmFywX5yb73Hx42V6jHxEzeWnhENtBSAR0NA3jNLVjXQg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(261022105027099003)(56012099006)(261009223027099003)(261021123027099003)(261028144727099003)(261102123227099003)(261021121427099003)(11063799006)(261026140227099003)(10067099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1Kkg9hju01tx4VkSG/vVi/oa6zyIFVsofNIo98MoarEl2GV4qNiL1Zlh+hUepdH2kwZZUO5PRQciz0jxxDxD87Y8ePmGzfOmzNrLUx8bVL2QUYCWE4p+aGo4Nplc0T4qwrDPLwqvfxWEb1BtTGgiHDTsGzRvQX6QdvdgwmJmWtIvY0HZSc71F/gT7FWzuxB6EvmaaEPHnQ32TrnumplWeLUsCeW/oG7p5gmOAso/sAqd/U/aPnYzBXGFaGLAYpKQC/r9ZzaZGD2+RPA6kDQHn5vaA7noBGzuORapSbdDqqEzujqaVdq7qSDmecjyH98HogxJhCipEKN3PnVpFfiqsrDZQySveHtrdZs1SnlhY4GFV93+i2q7aM7JiOIkDZZWQ4lD397fOEFmt0aeK+wZYbyfR8inY6Cj2id6bN6DhSktesariuVMy3utiLiR94L0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 04:24:19.9586
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12b3d07c-e148-476a-70e1-08df3af4a989
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW3PEPF00001659.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7301

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
Assisted-by: Cursor
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 50 ++++++++++++++++++---------------------
 1 file changed, 23 insertions(+), 27 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 9559d272eb18..a5fe524b5afe 100644
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
@@ -3469,7 +3469,6 @@ static void iommu_flush_irt_and_complete(struct amd_iommu *iommu, u16 devid)
 	int ret;
 	u64 data;
 	unsigned long flags;
-	struct iommu_cmd cmd;
 	struct pci_dev *pdev = NULL;
 	struct iommu_dev_data *dev_data = search_dev_data(iommu, devid);
 
@@ -3480,9 +3479,6 @@ static void iommu_flush_irt_and_complete(struct amd_iommu *iommu, u16 devid)
 		pdev = to_pci_dev(dev_data->dev);
 
 	raw_spin_lock_irqsave(&iommu->lock, flags);
-	data = get_cmdsem_val(iommu);
-	build_completion_wait(&cmd, iommu, data);
-
 	if (pdev)
 		ret = pci_for_each_dma_alias(pdev, iommu_flush_dev_irt, iommu);
 	else
@@ -3490,11 +3486,11 @@ static void iommu_flush_irt_and_complete(struct amd_iommu *iommu, u16 devid)
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

