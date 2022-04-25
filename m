Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BBAAC433F5
	for <iommu@archiver.kernel.org>; Mon, 25 Apr 2022 11:38:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 199C14045C;
	Mon, 25 Apr 2022 11:38:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WBUdngWxnJaD; Mon, 25 Apr 2022 11:38:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id ED137400CE;
	Mon, 25 Apr 2022 11:38:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C800DC0039;
	Mon, 25 Apr 2022 11:38:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 31090C002D
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:38:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2DD90400CE
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:38:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uyktEgXc3wf3 for <iommu@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 11:38:06 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e83::626])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 68916404F7
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:38:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OjZYNXTS4Ce+1OgmiLJbbnglGPlqvpy5B2R8umo+6GWrGeUp3lNVcVcf/gMf8ouPAJjbKDPtcjxp/khlJUwycknwkLpoTOkVVTuCXAsu8oRk9JIZeZK+r/bCLDGKcJ1pJg/TAauC4fL6iMy85QYn6M7KAFt9supOWg0Gw0SYrTSQhzC8gWxBiyCEkg8nb8Op1k1DFXibikYqwsopGB2lwh+Jq5tZji6AArUxblily3S/llowdxTye/eHbKLIyjDMyUDB/Oo0k6QJ1wTN0D64UfhSmOkN7Qh8kFh9aCebkhMRa7KR1Y1tQATSov0LcDguqfCuL/HC+azorcnISit++A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eEFRqykzlPyqROdlpAy7wuMXG/nAqlO1RxTa6UmxSrM=;
 b=GNPAwazT/VSiNEoDFWT3cXb21LyvijfisNJeinBUAfGJq90rvxPTbk/0WsMgdVWaKaBDJZzeAM68ka39oo9pktDT3yOcO49iNK/1pbi2PKyHF9tSdhFy2vzYYoF8SMWHpEs5vFgkvDWGielSNqEVqlMHUySuMiPje5v1LPH/g3P7y/y0vyv+NTRkLZGuGmIX2lBoRKxEeFqzG4CsbtFjC43yRxMjTUlp9IGiP7lp8TF7BqRqZr7YxAS54o+Kqliwrr4qcSJhrNcPNhBi3T3YM2crxXhMBHsak3B713N6xoFO4e6853Zd4ZAhoivEsomYl75lawXn5jz0FXlRKoVUHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eEFRqykzlPyqROdlpAy7wuMXG/nAqlO1RxTa6UmxSrM=;
 b=3BerdeO0Dqzj2nMJNde/iDhSvzlp/18jfZIRJQDswy2CJpM4ft04id6hPXmrPyLC9ButGbBnlmxMzbth02TXGMmnbWMCBKwxrYyO3DWeJ/fXtkRRelBcyv4juuM2DW6excljwllYbgk1M69q0t8IRkXufjEeSgDxWSrJAsZRv6g=
Received: from BN9PR03CA0434.namprd03.prod.outlook.com (2603:10b6:408:113::19)
 by BN8PR12MB3219.namprd12.prod.outlook.com (2603:10b6:408:9b::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Mon, 25 Apr
 2022 11:38:03 +0000
Received: from BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:113:cafe::19) by BN9PR03CA0434.outlook.office365.com
 (2603:10b6:408:113::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Mon, 25 Apr 2022 11:38:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT035.mail.protection.outlook.com (10.13.177.116) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Mon, 25 Apr 2022 11:38:03 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 25 Apr
 2022 06:37:59 -0500
To: <iommu@lists.linux-foundation.org>
Subject: [PATCH v2 12/37] iommu/amd: Introduce per PCI segment alias table size
Date: Mon, 25 Apr 2022 17:03:50 +0530
Message-ID: <20220425113415.24087-13-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220425113415.24087-1-vasant.hegde@amd.com>
References: <20220425113415.24087-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4909580b-3cb9-4347-5874-08da26b00f2b
X-MS-TrafficTypeDiagnostic: BN8PR12MB3219:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB3219D5DAFE26043D22A1E2E087F89@BN8PR12MB3219.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: myoPSRBKdL/goD5VQBuGkFExMX3WfW6hfMpIhDQEFCU2K4t7Et6kw0u59gGU5va4mPrQHFI3ASTvRM2zdwnl6UEcgHW0c7Rbi4eESxGU3paxtx2zXey0EHNWIxuUVraMHmpGlw8xI+1b2f9uE/SLdO+OSytxchqBa1tYR6eBXqyC0dyy272rOQK0Jm8jTJY9L8WpiE1RBhDQUIaWnjh+YHu/rpz7pQ+UuKFrdjSYdQvpV/lV6lpLmR+uDUPtEHNb688G14RQAu+xG2NxKGfczAO32w2M5uCDQbdE6uPXDiBpILnlZZO9ao3cZcNKFawJSSNuHRJ9LuUAF7LZkWrDeVH+eh2shvIFTzHVEnbEsCxjRTXPsh/05c4XvBy/yRxifncAMeNfJGrCiWk/zg3wZqxLhvq4Ahd49upwhgg3w0puhxaIeETajQJA9FzEqKOoRgVg5qQPBU4isI4vCb/bewnujImI1IwnulZ2J7wzYcokD4jj+uATav0yMz/clVJN6k8/w3+WV+9Vdh6IzU9pMPv8yK0xPTpBtC3Wy4ATGNb4ojYa0DLMT/0kp/+BbmaTTVtBUkK12WjGMk8SBejOqgz1Uz1BLjFvJVSasWFJrjRhzvbrKz2IrKVbHEvemTtvE4OVUwIEahvs3qc5dLixEYvLeFTWnnCmQcujPRnoj0agFdwurSO6gvsCRj/lfT2AlKgUWGb723QyiRoTCqeOtQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(5660300002)(2906002)(316002)(81166007)(86362001)(8936002)(4326008)(8676002)(70206006)(70586007)(44832011)(356005)(6666004)(83380400001)(47076005)(426003)(2616005)(40460700003)(26005)(186003)(16526019)(336012)(1076003)(54906003)(6916009)(508600001)(36860700001)(36756003)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 11:38:03.6163 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4909580b-3cb9-4347-5874-08da26b00f2b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3219
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

It will replace global "alias_table_size" variable.

Co-developed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 3 +++
 drivers/iommu/amd/init.c            | 5 +++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index aa666d0723ba..4bed64ad2068 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -550,6 +550,9 @@ struct amd_iommu_pci_seg {
 	/* Size of the device table */
 	u32 dev_table_size;
 
+	/* Size of the alias table */
+	u32 alias_table_size;
+
 	/*
 	 * device table virtual address
 	 *
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index f8da686182b5..d4e4f49066f8 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -711,7 +711,7 @@ static int __init alloc_alias_table(struct amd_iommu_pci_seg *pci_seg)
 	int i;
 
 	pci_seg->alias_table = (void *)__get_free_pages(GFP_KERNEL,
-						    get_order(alias_table_size));
+					get_order(pci_seg->alias_table_size));
 	if (!pci_seg->alias_table)
 		return -ENOMEM;
 
@@ -727,7 +727,7 @@ static int __init alloc_alias_table(struct amd_iommu_pci_seg *pci_seg)
 static void __init free_alias_table(struct amd_iommu_pci_seg *pci_seg)
 {
 	free_pages((unsigned long)pci_seg->alias_table,
-		   get_order(alias_table_size));
+		   get_order(pci_seg->alias_table_size));
 	pci_seg->alias_table = NULL;
 }
 
@@ -1582,6 +1582,7 @@ static struct amd_iommu_pci_seg *__init alloc_pci_segment(u16 id,
 	pci_seg->last_bdf = last_bdf;
 	DUMP_printk("PCI segment : 0x%0x, last bdf : 0x%04x\n", id, last_bdf);
 	pci_seg->dev_table_size     = tbl_size(DEV_TABLE_ENTRY_SIZE);
+	pci_seg->alias_table_size   = tbl_size(ALIAS_TABLE_ENTRY_SIZE);
 
 	pci_seg->id = id;
 	init_llist_head(&pci_seg->dev_data_list);
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
