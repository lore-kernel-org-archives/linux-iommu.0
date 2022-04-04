Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE836C433F5
	for <iommu@archiver.kernel.org>; Mon,  4 Apr 2022 09:46:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 788D782969;
	Mon,  4 Apr 2022 09:46:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rUq9iH_Q6L-j; Mon,  4 Apr 2022 09:46:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4EB32823A0;
	Mon,  4 Apr 2022 09:46:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 230C7C002C;
	Mon,  4 Apr 2022 09:46:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 78493C0012
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 09:46:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 657D3414C5
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 09:46:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id e3kBZEFU-E1K for <iommu@lists.linux-foundation.org>;
 Mon,  4 Apr 2022 09:46:22 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20602.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::602])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 597BE414C2
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 09:46:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=czbNKW2OD94oXMID3K/vteinCjB4g5u2VkynqeesckG7OqHaL87+3wSivofOWmOZiJ6GM6nlycfIiPnurAxTRjChVNWzTF71reTsiFuI2CjFAoNOWbDot+IvNvzSUnwauObwMsc3Uasn0+El47BrYPcwxTL6J41oG1AIX4H52531N833fG0mFfl+car65GgSxDssVM4GQX+1pGpSI8Q8pxhWwdVgGixFWGa2ygsjPC+qpyp/Fp5pU/QdYY8FM6v/v3QYrVl4BMX8Kb0BJEGVYvfjbRmq0m4iTyvMBSCEW8B0++v6uprhrkBIiRIr0yQThFUhJJS+V/kIJL2xylkRtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eEFRqykzlPyqROdlpAy7wuMXG/nAqlO1RxTa6UmxSrM=;
 b=Uj+Yj4csk9+smX5o/H+7sWuXURoac1SxKFspNO6BLpkW5A0SheRjeLoPn4RCbrBr9Gli+mJlq2Qm8CwcYOG2gKhZJLmVJFy3x/5nx00+zkIF+/yUbYwSclgAjgrx4x1W2p3FVyRe/tRMQ2YLMCXsBqSbZmPvLQIhB2MYDoiAIGObd13EPlEhTu17gR72DeF9DUvheY1wIWncukBE7Nn84L17aX00pVBWG0FLpWKGb9bALQ96FgHWG4moKRemGga9MaN+/giZMiL5eCKvpTLF+9FhAbNtetApMnXClTLoD4XztQqJFpgRH1T5KmQd5KIujfqPrZz147/qdrTdlc0/lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eEFRqykzlPyqROdlpAy7wuMXG/nAqlO1RxTa6UmxSrM=;
 b=IPUw7cuRPUbjNUVwWnyzOEo/RnRm2apjn+si1A3xL111MGGNjLB5gbknkzBFrw7EVDJixr8D5spQn6q9ZrTzcnhn4XleMhkK//gTeQSEiNWF1TtW/pkeFuEeIww9jfnNbXpcTckEo0vxA0NiY+sXTNAP5C/Ji//qosx49cY9RW4=
Received: from DS7PR03CA0275.namprd03.prod.outlook.com (2603:10b6:5:3ad::10)
 by BN9PR12MB5242.namprd12.prod.outlook.com (2603:10b6:408:11f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 09:46:19 +0000
Received: from DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ad:cafe::2b) by DS7PR03CA0275.outlook.office365.com
 (2603:10b6:5:3ad::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.30 via Frontend
 Transport; Mon, 4 Apr 2022 09:46:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT022.mail.protection.outlook.com (10.13.172.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5123.19 via Frontend Transport; Mon, 4 Apr 2022 09:46:18 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 4 Apr
 2022 04:46:16 -0500
To: <iommu@lists.linux-foundation.org>, <joro@8bytes.org>
Subject: [PATCH v1 12/37] iommu/amd: Introduce per PCI segment alias table size
Date: Mon, 4 Apr 2022 15:11:04 +0530
Message-ID: <20220404094129.323642-13-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220404094129.323642-1-vasant.hegde@amd.com>
References: <20220404094129.323642-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3cc9ebf1-d328-4360-018a-08da161ff7f3
X-MS-TrafficTypeDiagnostic: BN9PR12MB5242:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB5242B17E9D5B618134A1F6AC87E59@BN9PR12MB5242.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N4n03Ut2//2XYG6RZnXhqRvec6CYMC/hddxGInZNMJ+L0k0R1sazsrHyYEQeVAac6r6o5nMmOvGpCqc6hEMjYZ0tlfcIzGLBsTl2LBnpUuo9BtlHVEEZyawim1O5LvWNGRhjJz6F3ImRv82M1lfMXIsjCLoilLT3AQOu8Ylld5v6s1JumZ0SVV6YzRkAUXT+1bSZKnC5vzgj/4Xq9GYtGqASfdgSHs1QuuUak2WtB4qLBT3Nm2gISbh0EcegeBDcgtav6TB02dDdHVN1M9NiUzLygMZKwIxija34KqH9dY8OrgzCzC9ZNwXjNk6/7G1TI5jJnpvvg+9ENbu5fSciQYHRnhQGX/CErbuUjxmUGB64Kc5opKlaFiMJe1kjyLfW0hQawd7U8a+yBI5C/VRVIfQwoGKpaCmT/cStVCCjqWGo1jNuzPHshOM4LOiVOz2kovbeASPCh0qp5g1n+ZkAJxCuTiNhpfwyi4uEQzpGTUN1WkI+AheHyb2orp/hlAq/G2vrSdXL72b2L8h3B+LsAvw63C+prIu/B7HehXTnlR1TRA/AuBvKR14HwnHckMx5N1qT2Zbit+67jgICSCgEXhFuzsloaMmjp4jtARF4sq35HlqaGl1/D1O92YFIU5aaLK3oz1R/1XS0X/UJa9jJhEglP6J6RDDmKRnsRb7cbKPneEJ+me7bt4+//cDTuNjLtVaZCVgC5gtGJVlx+NuOWQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(44832011)(2906002)(83380400001)(40460700003)(36756003)(81166007)(356005)(5660300002)(54906003)(426003)(336012)(26005)(186003)(316002)(16526019)(8936002)(1076003)(2616005)(110136005)(4326008)(508600001)(70206006)(8676002)(36860700001)(70586007)(6666004)(82310400004)(86362001)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 09:46:18.4948 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cc9ebf1-d328-4360-018a-08da161ff7f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5242
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
