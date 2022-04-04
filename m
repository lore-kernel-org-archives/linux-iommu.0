Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4E0DC433F5
	for <iommu@archiver.kernel.org>; Mon,  4 Apr 2022 10:03:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5F74140936;
	Mon,  4 Apr 2022 10:03:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lr-eF7yzRFr7; Mon,  4 Apr 2022 10:03:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id F257440929;
	Mon,  4 Apr 2022 10:03:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CAB8AC002C;
	Mon,  4 Apr 2022 10:03:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7870DC0012
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 10:03:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 75DE7812FB
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 10:03:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RAzdBuulkyLD for <iommu@lists.linux-foundation.org>;
 Mon,  4 Apr 2022 10:03:52 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::624])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BAF24812FA
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 10:03:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H69C7Znd3FmIpQK/qlW+RwIWy/2IzfPlT4UNSWPRvwpBVDzYsEuGrZArDkWnBGL+dn6/QwlZLWIedjsptLn0eJNiLk2D6CWSjAWKwsxVjwO3Cf721f6DLAFNw1M/3K88EbMHlVRr1He/PF/yx01b78KHqYPuOg8/NN5ssJGUY7rk1PmAgzlD4ssj1Wdzw2XkeAFpaKhwFUvC4qQkvB3K6+qA+lNXyhGjGRfY8RgIYiJtK9JWmXTvMnHa+4yKyHsIBmgFitdLX8ZMJH3m7wjUCVdxIWlE0yKtt2WICjcwqmUca4VzZ0jnwXEapm4gAQAHAgMm/TVZQ/ELvB9H9AvI/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eEFRqykzlPyqROdlpAy7wuMXG/nAqlO1RxTa6UmxSrM=;
 b=P4gHJsAofG7ufwBEHMDQip8I2t4J1QrKedey5YizKui/hrQ2elMDNkRlmJagFSUK+hl3ViX6fKLhU25qSEwaGWCVb9L8ptLF4x6nL20bxcmOXdG2vWXxZBf/yfp6D7ebIsILbLP3jOsTHG5CMMKwURY3YppPHgbV4JqMA63r2wkiT+nfLLUKLmI+tK0EG/Gs7zYSkcv2ISFatgZ17EAeyBnnhrOOQ7rd253uT09wVmRJ09BzQDzNV7w/QhqlHgxaPwYLwbFJSJskJ3Dj0bC7flq013x/zKSCrYGStjwJKoAMGUQo6rgj0oBk02xRvYpM0YnkkifEyc4GeDGvC9N5rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eEFRqykzlPyqROdlpAy7wuMXG/nAqlO1RxTa6UmxSrM=;
 b=bpTOrKpp2YrwqzrVPzvbkJ1zzTGcqFnt2dwgfbEwULTw74ZebqQTD71L3UMMxeX9k9cgTQk38dd4NGKAN11kkL5zzgT4SttjH7xlbZWCx0yVmi+lRXwado3XDaODdRsH3pxjYlr/k7g1PIy8NC+dLM1HDKfvt71Ks+1IzsXCgJ8=
Received: from BN9PR03CA0040.namprd03.prod.outlook.com (2603:10b6:408:fb::15)
 by BN9PR12MB5324.namprd12.prod.outlook.com (2603:10b6:408:105::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 10:03:50 +0000
Received: from BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fb:cafe::74) by BN9PR03CA0040.outlook.office365.com
 (2603:10b6:408:fb::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31 via Frontend
 Transport; Mon, 4 Apr 2022 10:03:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT045.mail.protection.outlook.com (10.13.177.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5123.19 via Frontend Transport; Mon, 4 Apr 2022 10:03:49 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 4 Apr
 2022 05:03:47 -0500
To: <iommu@lists.linux-foundation.org>, <joro@8bytes.org>
Subject: [RESEND PATCH v1 12/37] iommu/amd: Introduce per PCI segment alias
 table size
Date: Mon, 4 Apr 2022 15:29:58 +0530
Message-ID: <20220404100023.324645-13-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220404100023.324645-1-vasant.hegde@amd.com>
References: <20220404100023.324645-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f717d3e4-8b55-4d09-68f3-08da16226a64
X-MS-TrafficTypeDiagnostic: BN9PR12MB5324:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB53248138FE6635936B4185E187E59@BN9PR12MB5324.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h5m8uWsIeBfkW4Pu0ZZYBejO+r0vT53bl7/m7DSoeCjr++xHudQrPKrh4wlhOCOmyGExaFwi82ywR9IbbV2fBip9rHQRAGs5ETSSt2KNDzSi4USlyDWMfobE+C0h9aKo+ooJ2xpYm9hjnzEPK+CMGkhLF6ejxaC6r2HQPed2KZaLXtcCw6/71DNIlb4Pqj7m6ceArSXPTj/JSqV8V4cO6cv+ukYgeN9aoM3rm2Pan0Z53p9iNSnXYLManqaEoyRdzp9tQZ2Bcdh9PKMSn8QVuSqIP1IEBrLHpzf22pZTCCc9aXD3KEoEqLDmz47Unq31ZnhM8E5yvnx2dZK0bctWqbw4rI3I8n4fnHmYyqi0lz4To23c5UIB0TQXrEqCqtF/jM8/nE4V9siibNVFAlBs0rQqejQtZKzMgmEyiX59aV4+hlstM0AJEsVVj/DBknX9taaFD30R76C+QVBZlawFMR1QPXsEc7IM3D0yMk8pTpJym3asuFOcSutt88eD2XtKEdNfcTqTReETsQzTNZAWwg/H0WJMLORIR5Kh5j8cfUtA9U/1aNQByVvGVj8VqVa7dGxEJ7iWNHylWJ/jIgoKcyqZ/DtjdNxUXY6aZMSR1w3iTKynyBKfV3kNdKgCXPajshZEvJ9cN7nYS9i9UJX6fDFme3Z2/fbXEN7Wct9P7zonYPM7tO/TebY5S0PCRr6iW8rPx6eY11aQ94Wo8iHw0w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(40460700003)(5660300002)(54906003)(2616005)(83380400001)(186003)(81166007)(508600001)(26005)(8936002)(426003)(44832011)(336012)(86362001)(16526019)(82310400004)(1076003)(47076005)(110136005)(356005)(6666004)(36860700001)(2906002)(70206006)(70586007)(316002)(36756003)(4326008)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 10:03:49.5229 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f717d3e4-8b55-4d09-68f3-08da16226a64
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5324
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
