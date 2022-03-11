Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ADE7C433F5
	for <iommu@archiver.kernel.org>; Fri, 11 Mar 2022 10:01:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1753C612C6;
	Fri, 11 Mar 2022 10:01:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zc4JhCvNme9e; Fri, 11 Mar 2022 10:01:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id CFD776127C;
	Fri, 11 Mar 2022 10:01:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AAAE1C0012;
	Fri, 11 Mar 2022 10:01:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CF28BC000B
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 10:01:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BE45D61290
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 10:01:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JlXF3h-0Pt2s for <iommu@lists.linux-foundation.org>;
 Fri, 11 Mar 2022 10:01:48 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20605.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::605])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 034FB6127C
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 10:01:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hXy0Z8NwF5cxAdXX9VNf+fLmnlBlqKvaFaCoeYnIRiKi/rB9oaThoe9JdQREIfP2lsTiUSScul3jDqrEWCoubAbsdvyc6tv2Lc2ORX2yBKgTNS6oDVKD4zbYFU4c2jkLdY0euTqJx6gER5S58u2W96wKCKk3MG4lTusnqBhnOUAeAx/HstroQUTOQnVqYxchG09ppFTG1+n4S5xRCWgISm4uK9c4jZZ/CTHBtIo+DEbkYFSfOnQbGIeOsd0Ij7ZQgV9SoGfWZWxO5kROBia5x3aH3pJQl79qNMYCSZaLIH0qI/QwL4+V1RmpxuqSL+N+fyXtb545baAg/NQtmuOZmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vCxHvbtD7UAv/Ktgl3cPXhaefaGavDO6oZT34ony3RY=;
 b=edSgLmbqYeRuc3FLW/06dUwDuKeBmNCOKy4H3TNW1rCDVedPNfA6kLGiY8DheRun0nw8JliBHWlJUTdzD+q1SDbPh09IC4I3yw4BarMQe5AyfO6LhdUVcVinaTobIuEtE/4r7WKWmCoQclAmEpVbW48Nhw2hIHcBcQ2+z2egLej1LvoB57vUYQ8JJeNS4EB/fsQwxDy1EKwwWMV8npdsPX2R7uEGimm6EXJAvepdoPXeGxCw31KP4kVOgtRDzPuFdubZsCCloWb8losRtzmyGEUCT4sQxI9fi3QBPTYAzrMtN2q8cjpZtZPPNGvOWVUOgSPYDJI8bX9MCtAGnGGCBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vCxHvbtD7UAv/Ktgl3cPXhaefaGavDO6oZT34ony3RY=;
 b=BVS780IxZj7AIel0vda1Y2PxhmQ0bH3yhq29Gmeu79ItwtUFwQQ+qSB9dypIVp8w4hxwptJ1sYj+8N/tp0D2Q3rDZ6n/FxlIPY+rsS7G7Swl6MlJESD2fAMO5J5NgZFUhI4fKBobeuRu2R0WIaiPkLcBYq1kPWDFxvow/b3L0jo=
Received: from BN9PR03CA0315.namprd03.prod.outlook.com (2603:10b6:408:112::20)
 by SN6PR12MB4701.namprd12.prod.outlook.com (2603:10b6:805:e6::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.16; Fri, 11 Mar
 2022 10:01:38 +0000
Received: from BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:112:cafe::95) by BN9PR03CA0315.outlook.office365.com
 (2603:10b6:408:112::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.23 via Frontend
 Transport; Fri, 11 Mar 2022 10:01:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT021.mail.protection.outlook.com (10.13.177.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Fri, 11 Mar 2022 10:01:37 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 11 Mar
 2022 04:01:35 -0600
To: <iommu@lists.linux-foundation.org>, <joro@8bytes.org>
Subject: [RFC PATCH 36/36] iommu/amd: Update amd_iommu_fault structure to
 include PCI seg ID
Date: Fri, 11 Mar 2022 15:18:54 +0530
Message-ID: <20220311094854.31595-37-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220311094854.31595-1-vasant.hegde@amd.com>
References: <20220311094854.31595-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 10117b05-7016-40c5-8aa8-08da03462206
X-MS-TrafficTypeDiagnostic: SN6PR12MB4701:EE_
X-Microsoft-Antispam-PRVS: <SN6PR12MB47013769B7E777E6D5287906870C9@SN6PR12MB4701.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IkIAzeoyhpYGCUkJ/YNJdj3YMswv55hvaKgxKQsV4SeAOcGuAqySKcE1HTNEGWeEgUGhsLRKwDLqeUr6tU+8i8rchN/vnCnouVEPn/X+bSm93JtL6c9hsjkMIPruYC4VB7VckdDgyFTXBW7pdld51CJqOTAqlwq+UwV8t1rgv4I95+hIR60JAznJNo67+GJaM+y3OyeLVwEicYSqpzqfoxpQDMD1C+s/K37bD0UbbVaOJFGk9JaH4WDpquDKC7MqfKx58v2vg9OISrnlxFZqTFR2gbzvx50hfXuOZaYI3vhPaEL61aQpg99kUM96Vf0f67tdWeCb5BQLVJPZSQxG4akAf4J/FR0B78NrL//y3qgZDAr2tZHpFJEyfaAilNH0zwXXJNgIQXxry6BcnnbKSe1LxyT1CZz8RkjdHCqEKKA89HTaSJA6H7J6ubtVOz2PzSaeJskeks9Mcn0CrGWknp65OMigGKCKu+nFj4jfssnii2oNt6huM55eU40nXBGjesfsQD6hfYaCSClWM2FC9agP4s/rtkd9mmKIGZDbJbKFCc7tW3ViHH12yD3n7dH2TCOSQ4HMbOkbu1n+7mDKI/+RON7vBPHenYMvhuKZn25A6WBd4BKDQ1DzlqBaQGb88xTrZd6o249EsZnh/Xg4dpw9sXvYdIrM6eNx/b/hbgfDWoZ7j++0ITahZ9A7MbeQE+XnseNlQ9Ql4z94GK9a7A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(40460700003)(356005)(8936002)(2906002)(81166007)(36860700001)(110136005)(44832011)(5660300002)(47076005)(83380400001)(70206006)(6666004)(82310400004)(316002)(186003)(336012)(426003)(16526019)(8676002)(2616005)(1076003)(26005)(4326008)(36756003)(508600001)(86362001)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2022 10:01:37.9169 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10117b05-7016-40c5-8aa8-08da03462206
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4701
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
index 47fb919907eb..47b62a3a76a2 100644
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
index 2821c7e348f2..001158d6f493 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -699,7 +699,7 @@ static void iommu_handle_ppr_entry(struct amd_iommu *iommu, u64 *raw)
 
 	fault.address   = raw[1];
 	fault.pasid     = PPR_PASID(raw[0]);
-	fault.device_id = PPR_DEVID(raw[0]);
+	fault.sbdf      = (iommu->pci_seg->id << 16) | PPR_DEVID(raw[0]);
 	fault.tag       = PPR_TAG(raw[0]);
 	fault.flags     = PPR_FLAGS(raw[0]);
 
diff --git a/drivers/iommu/amd/iommu_v2.c b/drivers/iommu/amd/iommu_v2.c
index 763bdac38a42..490da41c3c71 100644
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
