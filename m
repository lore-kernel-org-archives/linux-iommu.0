Return-Path: <SRS0=eQNl=EL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF29C55179
	for <iommu@archiver.kernel.org>; Thu,  5 Nov 2020 14:59:39 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89EC622256
	for <iommu@archiver.kernel.org>; Thu,  5 Nov 2020 14:59:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ELeISNDD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89EC622256
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0426487175;
	Thu,  5 Nov 2020 14:59:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ylE0FP9GnolB; Thu,  5 Nov 2020 14:59:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 649C587166;
	Thu,  5 Nov 2020 14:59:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4C248C0893;
	Thu,  5 Nov 2020 14:59:37 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B5E33C0889
 for <iommu@lists.linux-foundation.org>; Thu,  5 Nov 2020 14:59:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id AD2E7865E2
 for <iommu@lists.linux-foundation.org>; Thu,  5 Nov 2020 14:59:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dhZgtrgh+64h for <iommu@lists.linux-foundation.org>;
 Thu,  5 Nov 2020 14:59:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
 by whitealder.osuosl.org (Postfix) with ESMTPS id A960184CE1
 for <iommu@lists.linux-foundation.org>; Thu,  5 Nov 2020 14:59:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cl4uW9nzHpL2cL9Xf5WEZtFeO5E7JHL7iADMZula6An2FDZd9s+hOhOyrrH9F/buybWkhaFcaj2cX7TZxRqoOQDbVUrZ209plRX2NlDcnOAG/k96hzmXyXLxDZ/0Y6Zpv8z+wcOS+djQzMMMxueUWl9O9CPzwUEEupg+09r1Ff2xERL7oqSiINzxkYlBqb3m5c/cmJdMEF9rF/6Ekb6YONGlQML7KuAMGHWXIIkrdiO1FM3gxrSgYey0Xbv1vqwnbEOP5otFjC3acRS6WuDvEY46gpB1fSVDKWa2gGf4qe9XXPiI4BCcIukG0dIEfSv1a8p2QRn3gkqbnnVRbVa/4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8r6kb95/jr2zOC73gPjbGVkVU/gNndj5lRpi8kdnwE0=;
 b=VWbol/4FK8xKXu/fOjigrK0B6N5hPXrcl3kV7L6qwJgJeyIrDVxnG3HQD8JVp7fs4T89vfK4HB1RiVjkjaWVCxsyYWhHRBlXxKJ5dI35tP3Gfa7tBn3SHqxNL40oIR+RqFbxLoi5UE5JE5hHZLEnzX4fYsl2pyiBv5vMOo9vdst7rhGfeg8xU5w8wJ//JcfMt5ONBJrJVwRw41GQMuJdqF0Xxd+r7B0TVgfPy9B4fcUNPAX78Ymxk02JA+GQBouep5Mm2qqFvBQI99DSEai4qaauPQbr5h4jQ0rPK/zaw7ediiu/zDRrVnIyTK0lhapwCOvmIX9kzxtbaTUd6sAo3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8r6kb95/jr2zOC73gPjbGVkVU/gNndj5lRpi8kdnwE0=;
 b=ELeISNDDxOGGZ/rNyMM4ZJQFkkzscP57ZxlkhtYzDz5QegPQLxL0bc4bOyfrziHM6NrYc/Kuh+ZfKCsuqlACzprRPCoCDqkKR1x0UrKjrbr78GhH1ekoAST/cxbYUcp4K+yGMl0bWX8f5dIC3ULAZlNqkkYZbzaKZxsGXkdlSOo=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4597.namprd12.prod.outlook.com (2603:10b6:a03:10b::14)
 by BY5PR12MB4888.namprd12.prod.outlook.com (2603:10b6:a03:1d8::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Thu, 5 Nov
 2020 14:59:30 +0000
Received: from BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::74c5:c3c5:26ae:524c]) by BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::74c5:c3c5:26ae:524c%2]) with mapi id 15.20.3499.032; Thu, 5 Nov 2020
 14:59:30 +0000
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org
Subject: [PATCH v2] iommu/amd: Enforce 4k mapping for certain IOMMU data
 structures
Date: Thu,  5 Nov 2020 14:58:32 +0000
Message-Id: <20201105145832.3065-1-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.78.2]
X-ClientProxiedBy: SN4PR0201CA0007.namprd02.prod.outlook.com
 (2603:10b6:803:2b::17) To BYAPR12MB4597.namprd12.prod.outlook.com
 (2603:10b6:a03:10b::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanolx5673host.amd.com (165.204.78.2) by
 SN4PR0201CA0007.namprd02.prod.outlook.com (2603:10b6:803:2b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Thu, 5 Nov 2020 14:59:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b966af3a-8acb-4f70-0b4e-08d8819b6615
X-MS-TrafficTypeDiagnostic: BY5PR12MB4888:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB488854473B9DD32029715C65F3EE0@BY5PR12MB4888.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:923;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9YPHqZrrVr0TxKpodZmVd4ANUZAUCrQLeAaOo9ZxeEDK3ndcf/L/T1sYSafU4KBbjZ1EgYwqBAS+gsZsJV1trdsIsGO6CcBVHinH2YBLlero9kw0I+LQnsX5TjS0+Bh+dPl/mVE11yakRDi1u4uz0yrE3dCei6jRTeZ/zJEJCyDcwruMC3hJhiRukkDARf2cFXsWdf1tGyibn7AswHMopO7ZWPUKMxf4ps+/IKR05FgCqL4w2LZmidpsSv3+00QC0BL9herQjb88XurVPOlDRFw6oXYC9+C7VpTPw/VetYkvPNcNvckAML8TQBU5646K
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4597.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(376002)(136003)(39860400002)(346002)(478600001)(26005)(44832011)(8936002)(16526019)(8676002)(83380400001)(5660300002)(186003)(6486002)(4326008)(36756003)(2616005)(956004)(7696005)(2906002)(316002)(1076003)(66946007)(86362001)(66556008)(52116002)(66476007)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: s07BuAeP04/Gojyq1zrBEccQjA0O4fIiGkO2B1WdQiB48bf1oTpMKQqSZvOFgtpmF3CpfvgX9mHB3ZjYLndwpqmCcWSPihSJ+2K/iST+3a84DLKGGFb676xQFwTdNYek1KG8yBaJcM0z/JqJ4uNRUdVNbyRt8aOCR7BxjmL4C6ipcSA0VOzkKMfnH61eSxch0L6FdoQVSizXSjKdCBFnB9ziQ/vXo+jwiNmADTf8tJUddM3QupwHfgk21/PJqtpZVKPVteYPjtIevfnMJRtSKdaWMHOUZkLEnLZA6a3RQm20yJBR9P7iZ2YTxpJVZ8sln0FY/3FF1PqloGxt36/oecyQeHpbd/qJYoVnTaEk/hOuoPHpdiCmLsK2Gn7XD0wGSZLVtBYrNWwaMVKQ3ZKqaN5jyzXAMw7sVPUmNIOrFIk95Pun7gwp7hjXa3lheO6cbjiNZU/pn/l8TifY2tNnrzf+aJ5LjBPRSw+af/wzOpzot2fhQASWU9IiEGVI2SOT483Ek6nQ0TbnCJmCPqpfiOX3a7v9nPxlfinx1fofarYyw2TTtl8n/e5JsgIfCei3geqffbKcK9LkQSfmN6GqaltVieGxR3EIq6YgY0O2xcHXBxBNIqaglKIPHt9eeMqFcwVL4qu8GZZgbP/zgS8IYw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b966af3a-8acb-4f70-0b4e-08d8819b6615
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4597.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2020 14:59:30.6783 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4xALL6+sBRe1pQZvNySv3Ejpn1QGOQfFj0ws1Q2Bh9JsIsH4tm96cLr13VSUS2uwuViEv63jaQsVaZj/LmOVgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4888
Cc: Jon.Grimm@amd.com, brijesh.singh@amd.com
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

AMD IOMMU requires 4k-aligned pages for the event log, the PPR log,
and the completion wait write-back regions. However, when allocating
the pages, they could be part of large mapping (e.g. 2M) page.
This causes #PF due to the SNP RMP hardware enforces the check based
on the page level for these data structures.

So, fix by calling set_memory_4k() on the allocated pages.

Fixes: commit c69d89aff393 ("iommu/amd: Use 4K page for completion wait write-back semaphore")
Cc: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/init.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 82e4af8f09bb..23a790f8f550 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -29,6 +29,7 @@
 #include <asm/iommu_table.h>
 #include <asm/io_apic.h>
 #include <asm/irq_remapping.h>
+#include <asm/set_memory.h>
 
 #include <linux/crash_dump.h>
 
@@ -672,11 +673,27 @@ static void __init free_command_buffer(struct amd_iommu *iommu)
 	free_pages((unsigned long)iommu->cmd_buf, get_order(CMD_BUFFER_SIZE));
 }
 
+static void *__init iommu_alloc_4k_pages(struct amd_iommu *iommu,
+					 gfp_t gfp, size_t size)
+{
+	int order = get_order(size);
+	void *buf = (void *)__get_free_pages(gfp, order);
+
+	if (buf &&
+	    iommu_feature(iommu, FEATURE_SNP) &&
+	    set_memory_4k((unsigned long)buf, (1 << order))) {
+		free_pages((unsigned long)buf, order);
+		buf = NULL;
+	}
+
+	return buf;
+}
+
 /* allocates the memory where the IOMMU will log its events to */
 static int __init alloc_event_buffer(struct amd_iommu *iommu)
 {
-	iommu->evt_buf = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
-						  get_order(EVT_BUFFER_SIZE));
+	iommu->evt_buf = iommu_alloc_4k_pages(iommu, GFP_KERNEL | __GFP_ZERO,
+					      EVT_BUFFER_SIZE);
 
 	return iommu->evt_buf ? 0 : -ENOMEM;
 }
@@ -715,8 +732,8 @@ static void __init free_event_buffer(struct amd_iommu *iommu)
 /* allocates the memory where the IOMMU will log its events to */
 static int __init alloc_ppr_log(struct amd_iommu *iommu)
 {
-	iommu->ppr_log = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
-						  get_order(PPR_LOG_SIZE));
+	iommu->ppr_log = iommu_alloc_4k_pages(iommu, GFP_KERNEL | __GFP_ZERO,
+					      PPR_LOG_SIZE);
 
 	return iommu->ppr_log ? 0 : -ENOMEM;
 }
@@ -838,7 +855,7 @@ static int iommu_init_ga(struct amd_iommu *iommu)
 
 static int __init alloc_cwwb_sem(struct amd_iommu *iommu)
 {
-	iommu->cmd_sem = (void *)get_zeroed_page(GFP_KERNEL);
+	iommu->cmd_sem = iommu_alloc_4k_pages(iommu, GFP_KERNEL | __GFP_ZERO, 1);
 
 	return iommu->cmd_sem ? 0 : -ENOMEM;
 }
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
