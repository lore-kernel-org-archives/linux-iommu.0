Return-Path: <SRS0=+Hy+=DW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B73C433DF
	for <iommu@archiver.kernel.org>; Thu, 15 Oct 2020 02:46:33 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C16822257
	for <iommu@archiver.kernel.org>; Thu, 15 Oct 2020 02:46:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="pGZ++PVF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C16822257
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 019E08833F;
	Thu, 15 Oct 2020 02:46:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GjB2Fpz5UzDr; Thu, 15 Oct 2020 02:46:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 851AC88306;
	Thu, 15 Oct 2020 02:46:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 651C5C0052;
	Thu, 15 Oct 2020 02:46:31 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0D838C0051
 for <iommu@lists.linux-foundation.org>; Thu, 15 Oct 2020 02:46:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id F08D788306
 for <iommu@lists.linux-foundation.org>; Thu, 15 Oct 2020 02:46:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id U0HudiiUud92 for <iommu@lists.linux-foundation.org>;
 Thu, 15 Oct 2020 02:46:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 04A418831E
 for <iommu@lists.linux-foundation.org>; Thu, 15 Oct 2020 02:46:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QnCKTOYY3EHfQkY/LatAwwy013N6fijhteX4JkWVOOtG1PsgXE/ItAYrd6RDlMI3LWSezmjZ4AEhWQs6qFCY/7or5frlKDnRh+jGz2/Iv5ypmE/+sibzm2bP4jUFnpZBTaJUTXm+kzeT5QSHqi8wUPtu1KMhcnmNz6OIY5eXCZMTkauZeKxyjQNj9VJnC8cYAd59Vj/5u4ED0VJUR0A6L3VLzIN4sIoHoCPim4H1H2HvmTHcbIj+yiUt63W2HsVb394ahInxu/RupP4V5FTdnsv66KR8QpfN8eFvsCpYnGtRzFO7Hi6KGVyF31hSanrxWR4IhRIcnAAFeV3f2AmTRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HEspNFt1iJ40MPmDcyY5+CNkF/3BggXYMaKXV9e3RX0=;
 b=JqO50Qaq/Y50uzVio1t9lv2XWoy53TcmsODrYYlKg6S7/i/fspHFm3pQ4GMfTS0xyoP2ZC64rRjFvB+pnQlYsIoSYCyxQlq+Rb76b+jDTbXX/jdJMgHPlBQiDV3qwmQavRSKLU/R5heCd72qOfP1KBhtofsMBsMWktd4QTUcMy9N5PKOELpZCPB0sw+QS0R2kAbbXZNkcdpypnDnxox1Nqc7cmq8QzNjiFyZujsxXijN7qcezLdw5z0UhvKKJOm/cz3xFHI3CXOLhkii2VUUwFZMd5ieUSDDPZgFEX7EMexGW9ZSsubynzHNJIwl/SZJqIyrEPuQRXuElaMleH6pZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HEspNFt1iJ40MPmDcyY5+CNkF/3BggXYMaKXV9e3RX0=;
 b=pGZ++PVF7Qwknc0m+G1wy+eE+XPcbdOpXGcf/yx0OnjTqpKoCol04HeTZ6QLPS1MCoDI+eGEjAQJHTfZJB2jNeIj1+weQnT0ftxpvvvUhkltrs4Wi/y2IGmcFtM5aYvETGMrIBleHAMfvOAX7vOBR0r7s3Pe0wokv+CrVrj8XNU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1163.namprd12.prod.outlook.com (2603:10b6:3:7a::18) by
 DM5PR1201MB0028.namprd12.prod.outlook.com (2603:10b6:4:5a::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3455.25; Thu, 15 Oct 2020 02:46:24 +0000
Received: from DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e]) by DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e%5]) with mapi id 15.20.3455.032; Thu, 15 Oct 2020
 02:46:24 +0000
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org
Subject: [PATCH] iommu/amd: Increase interrupt remapping table limit to 512
 entries
Date: Thu, 15 Oct 2020 02:50:02 +0000
Message-Id: <20201015025002.87997-1-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.78.2]
X-ClientProxiedBy: SN6PR01CA0009.prod.exchangelabs.com (2603:10b6:805:b6::22)
 To DM5PR12MB1163.namprd12.prod.outlook.com
 (2603:10b6:3:7a::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanolx5673host.amd.com (165.204.78.2) by
 SN6PR01CA0009.prod.exchangelabs.com (2603:10b6:805:b6::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.23 via Frontend Transport; Thu, 15 Oct 2020 02:46:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8f1a517c-5c99-4646-fc9e-08d870b48189
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0028:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0028F9D34B139E01DBACE98CF3020@DM5PR1201MB0028.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5JTa1d1h9lZRKGdJB9xrADLSmI9GRza8ScTyWCu42RlXBYw/InJE2ZErTMV0wG72/Gu9/EbZBZc9wCPozNJ7Ru2GSwvIUjKEt4TrnQZvA8A1aLNUeevfHTICiDpBaUA531WcZ6hst92DuAP9q3hu0riRZ8JUGwp34tr9zvYixy1d+G0Y2+JmCAG6LtG42km4vsKHrrZ2ox1P5KfYwYoTMVGRfkdtjlWVoInRzFb7FBvD+FU3boocCKP/BWKBrsR+0NHpTXvKzva08c1L3BYXM6/yTBUXt2j93vGatFQIlAC5nYvUUQUfGf8g2CiCItA0n8LNY4/EwOLCsDrte+WQSL9eZLB7Cwg8851flA4ugAVNZDr7LMRiYPp4xWTk33Rb
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1163.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(346002)(396003)(39860400002)(136003)(66476007)(2906002)(16526019)(8676002)(66556008)(186003)(34490700002)(66946007)(2616005)(44832011)(956004)(316002)(36756003)(4326008)(86362001)(1076003)(5660300002)(6486002)(478600001)(26005)(6666004)(83380400001)(8936002)(7696005)(52116002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: g3PHvb3q66AiFPtPWQgXNIpMru4lblaz/mQUg5Ca/7Y4G9DnX6Bn3r3i3hE086eu06aftErKtpgCVZQmf3aLWLFrFxcLvTxEduAMT+0VyMogff0m92aPyb27+A69VZaRwadYa+D7oQV9Xkx02+zVAI/6JIhpGre6V5bpBqThg4jxkI2YvFIA6ctaJlKl042D4sDwz5VhT2P27fhj8d//JXYs1B0wdD4WbRmooi4cTr6D1F8QvQ8ejs0DAaH+L3gUpH8dVVsBcJAgWFQsVGSwYoHjcHiywXMnIq4XwA4qcnMTpJtxVDBQsamjNQBjcGNpaAagxYxbun1H25CUuJEoPIQw8zRkqFk3mLAgW1Hmup9J1ewvJEoulmot5vLPUe7zUR9l+fT2bq+6QByVCO7dt29kgKhVcEPb/CND1FEFRKS1wCcknvttndVR6/h/55G8q7QIr2JiChF2KZ6laqVD2p6X3GttPsdaQrI6KhxnWzkeaukhqbMDfqMO0akj8IK+EfLzbyv4qBfGmRI51MXYKomWrruls/pNHbHdvl90lQX/p3auKa36sR9DcLb+nYunQLnX466WGoQUIFgpxfeIjTruNoHLDtd0nA8UAbf9I46hl1f1oBUq/hl8p0GR3EPpit8W9fyIlUxLw05gjhwPZw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f1a517c-5c99-4646-fc9e-08d870b48189
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2020 02:46:24.6201 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4aD3D5huqX6n0ht4xpzi3huxdOgoL0nvBA+AjLW6UY7WC10I5YxDZLX3/LtMohcRdaafM6YwksTJRwYHr6pu7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0028
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

Certain device drivers allocate IO queues on a per-cpu basis.
On AMD EPYC platform, which can support up-to 256 cpu threads,
this can exceed the current MAX_IRQ_PER_TABLE limit of 256,
and result in the error message:

    AMD-Vi: Failed to allocate IRTE

This has been observed with certain NVME devices.

AMD IOMMU hardware can actually support upto 512 interrupt
remapping table entries. Therefore, update the driver to
match the hardware limit.

Please note that this also increases the size of interrupt remapping
table to 8KB per device when using the 128-bit IRTE format.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 30a5d412255a..427484c45589 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -406,7 +406,11 @@ extern bool amd_iommu_np_cache;
 /* Only true if all IOMMUs support device IOTLBs */
 extern bool amd_iommu_iotlb_sup;
 
-#define MAX_IRQS_PER_TABLE	256
+/*
+ * AMD IOMMU hardware only support 512 IRTEs despite
+ * the architectural limitation of 2048 entries.
+ */
+#define MAX_IRQS_PER_TABLE	512
 #define IRQ_TABLE_ALIGNMENT	128
 
 struct irq_remap_table {
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
