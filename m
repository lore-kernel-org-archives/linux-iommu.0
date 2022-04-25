Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFF17C433F5
	for <iommu@archiver.kernel.org>; Mon, 25 Apr 2022 11:44:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 937DB405C0;
	Mon, 25 Apr 2022 11:44:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8TL8oWmVSEzG; Mon, 25 Apr 2022 11:44:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 45CA6405B3;
	Mon, 25 Apr 2022 11:44:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1A6FFC0039;
	Mon, 25 Apr 2022 11:44:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A4471C002D
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:44:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 844F660BF1
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:44:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ppvfHq04zhiq for <iommu@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 11:44:16 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20616.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::616])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B2A9B60B2C
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:44:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BpY7wcjiqSh+L5u3NzJ6GusjS/TQIxJWLfh0Iz65wYyD6wRxLlxTMZALGp9mAHD/8QsccY3gWkGZCFWX0BQFUet39wJB7gaoGeipcxEhE/dLUF4VpEQpSVcQMQ560MTTbJ0vI/azSQQSW3ywanpXfZKnYrp7rO1CZAtI4eIu/YfY4Uug6Uh29qcULRSw2Nl08/aHzJ6dVfXvn5hXErXyO3MkSqQl8uG0H8P51LW2uIU2eDvIA4qJ+W1IiILOab3Z0vmu4Z4YztnYbd4rnzN9lq9/0pFgahnOF4PRKes8qxM7q3zsyEsuGxHqQittwMmpBI4SxblYHnR550RdFeCEsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3+omGl/GVcnHxHBbaMYIAnWuqEKngXDNHOHwaCVTspk=;
 b=Fs2HcMXx2hBdlhIGPR7j3HzYpJ4DTC4AwufSPxGWRcqXcQ0yS70eg/tp7/8JN3jyRuM549WYen3Tk5q7wbZlPnMm4ThrOGhWlAt3lf4bl9z3Ost05IgFttBHGLDC0hXGCmjkwCcMPkxDjxPvVv/KdJNS7ens2Nr19nSyb9QLTb6uDnEEeegQMgpL1YpzxwArkgtFNe9hlPgv6Is18Vi538L1/3CSxBeuQHHaO4vWNXyWkAql/JFWndpoQthQT+volqO2lMAYDzkt6RwfmiBNNu/LLhWvLomBKQmsmWhaxZ7S5UDPhATyZIDRTVE0pI/IMXhZ+osfvyqWfiLaJ/2HjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3+omGl/GVcnHxHBbaMYIAnWuqEKngXDNHOHwaCVTspk=;
 b=b3yNeaF0tohqpqV4lc8RUBUwKS/ipiG0Qjfilc0N4R5FlkxvbD5F0lO10y5C7KblYzxPeaztXu04Zw2o8IZDmC2peLw+ygwFWeeIhf/Vf3u0EVjggGzY6FJIGnZfqS462CJLY0jdJGTOGIaIl22CE2MGO04lzgE2Y53Ri9CDQak=
Received: from BN0PR03CA0028.namprd03.prod.outlook.com (2603:10b6:408:e6::33)
 by BY5PR12MB4195.namprd12.prod.outlook.com (2603:10b6:a03:200::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Mon, 25 Apr
 2022 11:44:13 +0000
Received: from BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e6:cafe::17) by BN0PR03CA0028.outlook.office365.com
 (2603:10b6:408:e6::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13 via Frontend
 Transport; Mon, 25 Apr 2022 11:44:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT050.mail.protection.outlook.com (10.13.177.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Mon, 25 Apr 2022 11:44:13 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 25 Apr
 2022 06:44:10 -0500
To: <iommu@lists.linux-foundation.org>
Subject: [PATCH v2 37/37] iommu/amd: Update amd_iommu_fault structure to
 include PCI seg ID
Date: Mon, 25 Apr 2022 17:04:15 +0530
Message-ID: <20220425113415.24087-38-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220425113415.24087-1-vasant.hegde@amd.com>
References: <20220425113415.24087-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c4f5d356-6a82-4b12-3b08-08da26b0eb71
X-MS-TrafficTypeDiagnostic: BY5PR12MB4195:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB419561BB055E781F637135E087F89@BY5PR12MB4195.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hARNqIl/KHlruXLw+H8CKdtR30WI+7G61ZVKb/VXWhwkfwSF9+0Pqi9TMdBy1JjCh5rILVJe3xRyse1f6k3Vo1UC+ikhlF6SbWk6EdHxWLIxRnRKVWE3RlCk+j6AmlS+EbOYy5gRff/w0PkE0sN5qhED+u9fqffR31zt5haeEHKhlRit149F/Tj9cx+MJ2CxKoSBPAOneZ61anRuC4xTNN88LqNOqMZ0L4TtrnifcDRetdr3ahuu4PfXwP/WKELkFYTwlaUZnJ1FDHw6V1pXA1ObP/jSR0VQUmiSdUphOkET7WsWqjZrPfIpflg/ihZI3KK2LwBhd7viI+8nl6pM5J0L4J4hqnkMs63HfigUm7youFXXnw3BhErf8977CCraAxr9L/8gLNn4EUKbmtqc1KGTAUOiqZQwTe8pLDNjz1jRPnlQ2Ddv9nCn9eg6wIlu15avha5AGu8Iw7Fu6g5M9olEHuHwQ0rtbU1rtlJ5KHWAw6lSPNE96GSGxNutEQpIQM8TP3RzUjLY9jNKwyboxRFwrF8WTELrFPAZH99rM/7R4mxz3O0vZ10nwmJP+zeQvzfbMhKq4Ntby1KAlzAjl8TyDKAY3WPNe5tiGAFFchUk/dB2zi0gASEMa4gsHldq1emC6E39MHE/IfRQREiJW88YyWHy+0migMpub2ruF22vGVqzAXp+6GrMQSZvwNADZ3Vf5u2+yFmxGc/g7+NPsg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(4326008)(2906002)(508600001)(8676002)(5660300002)(2616005)(1076003)(426003)(186003)(336012)(47076005)(83380400001)(16526019)(86362001)(82310400005)(26005)(36860700001)(70206006)(70586007)(8936002)(6916009)(81166007)(40460700003)(36756003)(356005)(316002)(44832011)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 11:44:13.1731 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4f5d356-6a82-4b12-3b08-08da26b0eb71
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4195
Cc: Vasant Hegde <vasant.hegde@amd.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
From: Vasant Hegde via iommu <iommu@lists.linux-foundation.org>
Reply-To: Vasant Hegde <vasant.hegde@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Rename 'device_id' as 'sbdf' and extend it to 32bit so that we can
pass PCI segment ID to ppr_notifier(). Also pass PCI segment ID to
pci_get_domain_bus_and_slot() instead of default value.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 2 +-
 drivers/iommu/amd/iommu.c           | 2 +-
 drivers/iommu/amd/iommu_v2.c        | 9 +++++----
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index f2bbcb19e92c..a908f18a3632 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -477,7 +477,7 @@ extern struct kmem_cache *amd_iommu_irq_cache;
 struct amd_iommu_fault {
 	u64 address;    /* IO virtual address of the fault*/
 	u32 pasid;      /* Address space identifier */
-	u16 device_id;  /* Originating PCI device id */
+	u32 sbdf;	/* Originating PCI device id */
 	u16 tag;        /* PPR tag */
 	u16 flags;      /* Fault flags */
 
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 47946894aff3..5f48cddeaa29 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -701,7 +701,7 @@ static void iommu_handle_ppr_entry(struct amd_iommu *iommu, u64 *raw)
 
 	fault.address   = raw[1];
 	fault.pasid     = PPR_PASID(raw[0]);
-	fault.device_id = PPR_DEVID(raw[0]);
+	fault.sbdf      = (iommu->pci_seg->id << 16) | PPR_DEVID(raw[0]);
 	fault.tag       = PPR_TAG(raw[0]);
 	fault.flags     = PPR_FLAGS(raw[0]);
 
diff --git a/drivers/iommu/amd/iommu_v2.c b/drivers/iommu/amd/iommu_v2.c
index b186d33336e0..631ded8168ff 100644
--- a/drivers/iommu/amd/iommu_v2.c
+++ b/drivers/iommu/amd/iommu_v2.c
@@ -518,15 +518,16 @@ static int ppr_notifier(struct notifier_block *nb, unsigned long e, void *data)
 	unsigned long flags;
 	struct fault *fault;
 	bool finish;
-	u16 tag, devid;
+	u16 tag, devid, seg_id;
 	int ret;
 
 	iommu_fault = data;
 	tag         = iommu_fault->tag & 0x1ff;
 	finish      = (iommu_fault->tag >> 9) & 1;
 
-	devid = iommu_fault->device_id;
-	pdev = pci_get_domain_bus_and_slot(0, PCI_BUS_NUM(devid),
+	seg_id = (iommu_fault->sbdf >> 16) & 0xffff;
+	devid = iommu_fault->sbdf & 0xffff;
+	pdev = pci_get_domain_bus_and_slot(seg_id, PCI_BUS_NUM(devid),
 					   devid & 0xff);
 	if (!pdev)
 		return -ENODEV;
@@ -540,7 +541,7 @@ static int ppr_notifier(struct notifier_block *nb, unsigned long e, void *data)
 		goto out;
 	}
 
-	dev_state = get_device_state(iommu_fault->device_id);
+	dev_state = get_device_state(iommu_fault->sbdf);
 	if (dev_state == NULL)
 		goto out;
 
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
