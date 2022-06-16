Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7E0FC433EF
	for <iommu@archiver.kernel.org>; Thu, 16 Jun 2022 01:56:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7B7EA83FA3;
	Thu, 16 Jun 2022 01:56:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IlpgRKSLBvvg; Thu, 16 Jun 2022 01:56:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5E70183F9E;
	Thu, 16 Jun 2022 01:56:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 45BB2C0039;
	Thu, 16 Jun 2022 01:56:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 44561C002D
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jun 2022 01:56:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 25D6883F9B
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jun 2022 01:56:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DGe7T3esOuD0 for <iommu@lists.linux-foundation.org>;
 Thu, 16 Jun 2022 01:56:29 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::612])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5C8DD83F99
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jun 2022 01:56:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oIaB7MW32D2IhbMdNuwkI9U7LFq2ND9Dzx8Nt+y/hE1d/WYrkFopdvQJJ3JpEJ3HzSyA7b3Xj6a78iYzq1XhKiNr4U05li7eZLZEDntv0eEf6I3y4bXnYxzKFvFjuTqdlfd2MEb88QuS4JxuCk4fK46pWV0oT3jdW+SityBzY8+dlwvujyq/GtStp0STKTgXIePDAN5iPk0Djq0QQIa8A1jGW8yphpd7UORQmTUchhiu+UXOEI2PTVBW3x2VTFhsRcpmibyVF6vfRw/2gyXYyTKKTOpax1/56leONStLc4Ie8+kMRsOTpSrJrEYpnNsLbttOSHxSo0XQUk/YX7Za2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kdcHRhTgueX+LGaMOWiL2LMugrtiMhTnC+n7DaMc+rI=;
 b=brAok2f66szniduhtiO0DyfLZABBhXTlWXMn1JJntSfqHarlxaf4FNO9Gsrc/aiRsoFcBRdEwqI393UCCTPasXKFAw6J4q/a3Jr0pX9ctWQ/Vzc1RCN5DvuTHOq2bwABmEqAwtURLfSmBvuo+NxLyTimGgkf3UERE6+zKoXnljVLLIOCh6lThFIR9e/foBVkiFlYmKIE+B19AF5PIED2gYYgCcWkZCTRsV1Vtb3OdR96u5wzdOb8ji0insY+X6Ovpg19T4eKCvaumZYQvkhTteKL++zbsBe33kTY2StHX6peOKDh5AVUkf4OaGswxrb6myFVBNrgLxHJxpvKHqO9Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kdcHRhTgueX+LGaMOWiL2LMugrtiMhTnC+n7DaMc+rI=;
 b=b1baO4rKsbzHMV8qQ4CZGGPU4mAKS15d+AXGIFvUgv0xkeb0OVx9UUJOKGkIAjY9vTlLoLEsKDRi9TeowAhgzydecOAYw7N4ozdQURXm44q8VwUZRBrE+nFzeiD9aNsv41goz9RPha+Yfyg2TAGpbPnj5Gu066eewBs3j0ZCeG0=
Received: from MW4PR03CA0033.namprd03.prod.outlook.com (2603:10b6:303:8e::8)
 by LV2PR12MB5726.namprd12.prod.outlook.com (2603:10b6:408:17e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Thu, 16 Jun
 2022 01:56:26 +0000
Received: from CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::6f) by MW4PR03CA0033.outlook.office365.com
 (2603:10b6:303:8e::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14 via Frontend
 Transport; Thu, 16 Jun 2022 01:56:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT027.mail.protection.outlook.com (10.13.174.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Thu, 16 Jun 2022 01:56:26 +0000
Received: from sp5-759chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 15 Jun
 2022 20:55:57 -0500
To: <iommu@lists.linux-foundation.org>
Subject: [PATCH v2 5/7] iommu/amd: Set translation valid bit only when IO page
 tables are in use
Date: Wed, 15 Jun 2022 20:55:39 -0500
Message-ID: <20220616015541.11207-6-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220616015541.11207-1-suravee.suthikulpanit@amd.com>
References: <20220616015541.11207-1-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 67e5a6d3-2418-4aa9-9322-08da4f3b6c24
X-MS-TrafficTypeDiagnostic: LV2PR12MB5726:EE_
X-Microsoft-Antispam-PRVS: <LV2PR12MB5726E4F647DB3FDBA6340D38F3AC9@LV2PR12MB5726.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +14xx/wwDk5ovVDzJbQX+h+ua79tA9PA0IPTwEPoueSPAf3bWLP76HxKTKfRF9/Oyy3guQo4lffgdFT3XN0xtDAl5A8xQj/Nlzylm07m4ILKdo0W5uAGQOKzO90ZLxiMvQ41ZDVEDNbikUwhUML+952QlsGIUin9QoKV05TELy3iz4oUFoVzbMubm7bmMdDHZ0p0vaZjZa7AobD/328o5MU2cgkCFIz2+BinzwuBg7c2dbuK2gksFhsTuIxzpvHNUKoDebG9lsGP1lf2MH5NaLQnwvjeg0pr38YqdDsHUvdJu/Je09F80qUc7duYD8jakGb+iv4hFQm7QZ5h+PvB10zJpQAgcandyddkNrSEGL6d4Va7AsW9ALok6nFb6mW9Gk7X9lqDRMoJeDMNgzln2khd8lXhq5DG261dNOU4fGWe8QjF42bkCgPrfBDIY/I7YNz2qv6kYaUt10oHUfWi966fUBR3W97t52rhVe8kuvo4Wh0qmTV//kycUiNZDP4Mxkc90bhKyYnm1ctMZnJAyiGDFKiiRggoTC+ej3JUZr76wRZtTfwVx/pc9Pt57eskcUVlS+cHVFuwLW8gkEYLgzrF05Ofx/GDyq5/yJqT2u6pDZAWUXxwhRQxu+H355vqQx7jq5lP3fMYOXY9MSaDZta8wOeMdlujqnFQcyaOCPUkAEfgiJX8mpTJ/KA2+b6L63u8hqBOelst2e5Cx2IvLA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(46966006)(36840700001)(40470700004)(26005)(4326008)(7696005)(336012)(2616005)(426003)(86362001)(36756003)(47076005)(6666004)(2906002)(316002)(356005)(70206006)(6916009)(70586007)(8676002)(54906003)(82310400005)(81166007)(16526019)(44832011)(36860700001)(40460700003)(1076003)(186003)(83380400001)(5660300002)(508600001)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 01:56:26.0628 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67e5a6d3-2418-4aa9-9322-08da4f3b6c24
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5726
Cc: thomas.lendacky@amd.com, ashish.kalra@amd.com, vasant.hegde@amd.com,
 robin.murphy@arm.com
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
From: Suravee Suthikulpanit via iommu <iommu@lists.linux-foundation.org>
Reply-To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On AMD system with SNP enabled, IOMMU hardware checks the host translation
valid (TV) and guest translation valid (GV) bits in the device table entry
(DTE) before accessing the corresponded page tables.

However, current IOMMU driver sets the TV bit for all devices regardless
of whether the host page table is in use. This results in
ILLEGAL_DEV_TABLE_ENTRY event for devices, which do not the host page
table root pointer set up.

Thefore, when SNP is enabled, only set TV bit when DMA remapping is not
used, which is when domain ID in the AMD IOMMU device table entry (DTE)
is zero.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/init.c  |  3 ++-
 drivers/iommu/amd/iommu.c | 15 +++++++++++++--
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index b5d3de327a5f..bc008a82c12c 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -2544,7 +2544,8 @@ static void init_device_table_dma(struct amd_iommu_pci_seg *pci_seg)
 
 	for (devid = 0; devid <= pci_seg->last_bdf; ++devid) {
 		__set_dev_entry_bit(dev_table, devid, DEV_ENTRY_VALID);
-		__set_dev_entry_bit(dev_table, devid, DEV_ENTRY_TRANSLATION);
+		if (!amd_iommu_snp_en)
+			__set_dev_entry_bit(dev_table, devid, DEV_ENTRY_TRANSLATION);
 	}
 }
 
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 0792cd618dba..4f4571d3ff61 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1563,7 +1563,14 @@ static void set_dte_entry(struct amd_iommu *iommu, u16 devid,
 	    (domain->flags & PD_GIOV_MASK))
 		pte_root |= DTE_FLAG_GIOV;
 
-	pte_root |= DTE_FLAG_IR | DTE_FLAG_IW | DTE_FLAG_V | DTE_FLAG_TV;
+	pte_root |= DTE_FLAG_IR | DTE_FLAG_IW | DTE_FLAG_V;
+
+	/*
+	 * When SNP is enabled, Only set TV bit when IOMMU
+	 * page translation is in use.
+	 */
+	if (!amd_iommu_snp_en || (domain->id != 0))
+		pte_root |= DTE_FLAG_TV;
 
 	flags = dev_table[devid].data[1];
 
@@ -1625,7 +1632,11 @@ static void clear_dte_entry(struct amd_iommu *iommu, u16 devid)
 	struct dev_table_entry *dev_table = get_dev_table(iommu);
 
 	/* remove entry from the device table seen by the hardware */
-	dev_table[devid].data[0]  = DTE_FLAG_V | DTE_FLAG_TV;
+	dev_table[devid].data[0]  = DTE_FLAG_V;
+
+	if (!amd_iommu_snp_en)
+		dev_table[devid].data[0] |= DTE_FLAG_TV;
+
 	dev_table[devid].data[1] &= DTE_FLAG_MASK;
 
 	amd_iommu_apply_erratum_63(iommu, devid);
-- 
2.32.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
