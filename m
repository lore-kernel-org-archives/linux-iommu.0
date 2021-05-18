Return-Path: <SRS0=LVl/=KN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29DE0C433B4
	for <iommu@archiver.kernel.org>; Tue, 18 May 2021 11:45:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4DE061261
	for <iommu@archiver.kernel.org>; Tue, 18 May 2021 11:45:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4DE061261
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8F51083DD8;
	Tue, 18 May 2021 11:45:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kL0j8WN65SQq; Tue, 18 May 2021 11:45:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 587B883DC6;
	Tue, 18 May 2021 11:45:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2DA04C000D;
	Tue, 18 May 2021 11:45:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E7DEFC0001
 for <iommu@lists.linux-foundation.org>; Tue, 18 May 2021 11:29:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D8E1483B72
 for <iommu@lists.linux-foundation.org>; Tue, 18 May 2021 11:29:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nGaGzB9HGVE5 for <iommu@lists.linux-foundation.org>;
 Tue, 18 May 2021 11:29:56 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2065.outbound.protection.outlook.com [40.107.22.65])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E95FC83AB9
 for <iommu@lists.linux-foundation.org>; Tue, 18 May 2021 11:29:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UcqLhmThzU5WLlAJW2levJb6HxqEC4f/wQ45pw1RxStSX/P+XJisFA538qwE9Sug+8zMexyxD232V9E58udIHfkppQpLeNyA0Oj31qkNek/OPHdCiQKctxZ5ChPCx1uuOxoXYs13UA8xTsJoMdnkwZ3A6kJwobkhio1iMd0DCrXb4E57DsZfjFrRuLspzzxOVJ71CzXglGxhXivbrkui30t/740hcjLFvqlF0EuVgMbsJIM0KQ8gkkg+6Yp2dEwzPMRZi3V6mY29bCbqrR9eKs647MddJliApYs44rNn/oRx8FqhnFvsthdxulC3RjjJ9HHoi09+VA/Fdmj8MQvTsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RZN2gzulOaC1cK2GhNNFhiN210BLdEW8qKLN7Ke0SFc=;
 b=FjlvzqO8HgHplos+Skl3rlhHl2xFbrFKuDCNQbbDqYf2QT8+zg+24c2/jQ/Z3OoG5YhdE7JbdcuzpFFh9uiEcYK/z2ST03DBFZEcauB5rI5foLRxf9OG0TS4VSHg457sI7GaUs5QPgI6V2I6X4GilgeFowiUsBhbi+6u0pXwxgqrR91Q+NlUbvksQ8NHxQd0jzdTLb3NMhjuecu2aggAjDdRqToQql1DSa5TmSj3YrT2hqdFVZlP+CC9E43Emo3okkRPGTKDDAd/cAR267rR/QTEMTCvHO6uT7dvFvQFFxwzTVHGTs2TdHsiX9MoAzV678dNtzqzIX6pT+xkJ1gMCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RZN2gzulOaC1cK2GhNNFhiN210BLdEW8qKLN7Ke0SFc=;
 b=P3WQby90VA8gONZcXYqQJ76JQmFb9sEaM0T3dI0HeesR2XpLhGmMEWPx8fJBf/LHa4De1HkAn/eDdaSE4a6ptLarXh8kyvbxCSWFCXjCO0nYzPw16CZy1n7EqkJQmY+TRDqJfoAftocP21ctpPCAkhKmYFso629VXBrjZA93E7g=
Authentication-Results: lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=none action=none
 header.from=nxp.com;
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM7PR04MB6871.eurprd04.prod.outlook.com (2603:10a6:20b:109::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Tue, 18 May
 2021 11:29:52 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::b10a:ad0:a6f5:db9b]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::b10a:ad0:a6f5:db9b%2]) with mapi id 15.20.4129.031; Tue, 18 May 2021
 11:29:52 +0000
From: Dong Aisheng <aisheng.dong@nxp.com>
To: iommu@lists.linux-foundation.org
Subject: [PATCH 1/1] dma-contiguous: return early for dt case in
 dma_contiguous_reserve
Date: Tue, 18 May 2021 19:28:57 +0800
Message-Id: <20210518112857.1198415-1-aisheng.dong@nxp.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: SG2PR03CA0147.apcprd03.prod.outlook.com
 (2603:1096:4:c8::20) To AM6PR04MB4966.eurprd04.prod.outlook.com
 (2603:10a6:20b:2::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by
 SG2PR03CA0147.apcprd03.prod.outlook.com (2603:1096:4:c8::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4150.11 via Frontend Transport; Tue, 18 May 2021 11:29:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff4df551-2829-4eb8-caa2-08d919f040d8
X-MS-TrafficTypeDiagnostic: AM7PR04MB6871:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR04MB6871460A0F5055A35B91B6CB802C9@AM7PR04MB6871.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:626;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1DFmXUdzZpo6e2xRG2nyF0YeofZkmtJWP4qoP6qEqnlUg/34FZrWgNdF9nH82dFdTewVVexb5x32h69oSnSzB3hy8n28PmZMHIFoofHhN+lW+UIzhilR6QE+DGjJ0I/hUN5BNVRpJTHbPMYyqq/Sj2wCBY7wfR4PjvlOBaRKA2S4ED96vTP+pabJNegusIReTTlgez6EnG7RUSNC63NU9fpT1SeqsA6W2NQwgnkeOiZz9+c7VBEuWFqO7mAvzOdH6EYi5yJZPV2PSdwJj6twRDXRu0A68RYwl+PXQdVuhX+2qOBJMPeT4Bu/q/cQkfpWROU/u17zJPBDt8U0bQ09PJ78HaJSSIGBJ04G/SdwtyfJnwtXk5z1/Nsf70n06oHbJzMPpROhcNi1AR42oe5uWfHCmGZsPxKtzYJLtah/kIMnedFRcKkCK09tPm3BFVPp/HY4xFH89g71nERk/02nPtve/3M08dW8w8894C9Z0oE+cWwQ7Xs/hc2k7dxv+aF+VxV5zl4CfgvaEFUKbM0KdSTYbD6HrNwchANEHkOKpRGz7FBDtwVAdoAJUm/hWXFPzK0QV+5U6YUC2xrcRBzyFHI4SzKSrnS7ox4U0cvNDl8o1mHrY8e3Exzjbk/9o6f1AN9BvzzAkP63eeQXQYZqc3b7KDKwWsL50No2nkr94sSvkGOFtWJO5H3CQM2oRLjI
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR04MB4966.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(136003)(376002)(39860400002)(366004)(186003)(54906003)(316002)(6506007)(8676002)(6916009)(52116002)(2906002)(4326008)(38350700002)(2616005)(86362001)(8936002)(66476007)(36756003)(956004)(66556008)(26005)(6486002)(1076003)(16526019)(6512007)(66946007)(38100700002)(5660300002)(6666004)(478600001)(83380400001)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?S49xjejyDziAis48HFZTDawC0ddNFq73gtAD7y4KmLPixli8KLv6uYDFtbvK?=
 =?us-ascii?Q?DvFOD2c/NN81cmdbOqM+Sk9aK7a3ByRxZvIzZzfRWBAHo4HzJKVKoSAdX4q0?=
 =?us-ascii?Q?nDTWpME7FpAN6oqBzqONpd+lkIVbgWBnrsb9cUu136tKE6OJoI25oIu9kGx7?=
 =?us-ascii?Q?EJTKt1JBRnMywDzOpaRf9x6pZRPqBVdr6z3eSB0FDHb0DnU4Q5kktYuxTp+M?=
 =?us-ascii?Q?TghkNcSrkGO5w9ZVnX/iks2YKEp5NNSO/CgoTN2zbdi60hl0vpdi8HkRJ8s2?=
 =?us-ascii?Q?jkhnjfsU8O3mc7S66hZu9xNfCjzuunEHN1nAZjWIqBtiPfnZsERekYL8Iztf?=
 =?us-ascii?Q?vz2UEESKrA94y03ZSybdWQcz59fAafbL9cc8uEuyBr2AXueQtbP5VvAO2uek?=
 =?us-ascii?Q?RSdWBLInIS+Epd4GIYuvey0MY5CH4Xh4oXoyEc13DsMiigwaLM3i4HjCLGy5?=
 =?us-ascii?Q?deO4ijKwR5tvopZXPQYpUDbclPMvzbuvdwXyM2I7MqnmUCyIcvtwYqO5t76S?=
 =?us-ascii?Q?OOX21zDLcWy0vYnKyIbd8cBSn4cBwsilY3uWnYhG20YLCGm+1YW17K0tDb14?=
 =?us-ascii?Q?8dvvqzIul0AddEmcue0lw/3qMnfAmLRS7gkoK1s159MD5z7CNzU5ZL9JWjAe?=
 =?us-ascii?Q?1yFWrkd1naG68LHGMzxwvYHcr8GbUl3h5FNE0O8MOHkGJfMTymVsHDyb9iMY?=
 =?us-ascii?Q?ZAzdcvxZLg1bszc9OqDo7M/bhYuM7PUZHzXF0x33BEpfDYMR/2Oflw7lfQ84?=
 =?us-ascii?Q?x91zmeRR7G9bEhRb8b/AsRjGkMTqT/uQeFSxYCgnStirm9emWJjO0rI72/UM?=
 =?us-ascii?Q?wa1HAw0NLGbMzL5Onu9CZoXzXH7u3DOXPYYoWPil1MkFj56GCxuM7SKa6ITY?=
 =?us-ascii?Q?RAah1AYBaL8UM0QytyDhqLj5Fm33q9Wt9eZ94ABG4IRzNxloYfcpFgMzpI9O?=
 =?us-ascii?Q?HymE7+fOLz2jAHRIaBsUq9I8QFMFFIBYVLzec3VQ0BbFsofQT6yPejioKggh?=
 =?us-ascii?Q?KlGKutYNUnwAi7R37v82sq9r5g4cKR/AmJVWILtvMc2ddG5zXNjJm/0nMmeV?=
 =?us-ascii?Q?+qSMB55IRV9L9ktfeJNEEx3TfrXz4oDex7oCcf5dNR54d95hzpv47rUecPoT?=
 =?us-ascii?Q?aMg3TCp1mjFEuPrpxVgvcznBf6v6NVzCEW2UlnwokgNRyF10Gz6feBYQqP4X?=
 =?us-ascii?Q?YgTDizyRbtJb7p9OxR6JqHfO2wJDD+hWbacX+akKaRAOX03OWFMXguNQ6oBb?=
 =?us-ascii?Q?L59LlaLSQFtqjqjhuWdR0e5GDu7XlwBRLp5L3hW+7dL4OResx6W3QXUBejay?=
 =?us-ascii?Q?EauFny8BmTuoFnYQvQmbSB08?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff4df551-2829-4eb8-caa2-08d919f040d8
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4966.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2021 11:29:52.3878 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T6xMNDhMEtZKjboprkVl+Z7ZMcL6OAPqWkQxGQDPD36Zu57v5FA8qJ5UzvTkthqv2S/jGxjiYqYKOtaSebVqRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6871
X-Mailman-Approved-At: Tue, 18 May 2021 11:45:01 +0000
Cc: Dong Aisheng <aisheng.dong@nxp.com>, dongas86@gmail.com,
 linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
 Christoph Hellwig <hch@lst.de>
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

dma_contiguous_reserve() aims to support cmdline case for CMA memory
reserve. But if users define reserved memory in DT,
'dma_contiguous_default_area' will not be 0, then it's meaningless
to continue to run dma_contiguous_reserve(). So we return early
if detect 'dma_contiguous_default_area' is unzero.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 kernel/dma/contiguous.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 3d63d91cba5c..ebade9f43eff 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -171,6 +171,9 @@ void __init dma_contiguous_reserve(phys_addr_t limit)
 	phys_addr_t selected_limit = limit;
 	bool fixed = false;
 
+	if (dma_contiguous_default_area)
+		return;
+
 	pr_debug("%s(limit %08lx)\n", __func__, (unsigned long)limit);
 
 	if (size_cmdline != -1) {
@@ -191,7 +194,7 @@ void __init dma_contiguous_reserve(phys_addr_t limit)
 #endif
 	}
 
-	if (selected_size && !dma_contiguous_default_area) {
+	if (selected_size) {
 		pr_debug("%s: reserving %ld MiB for global area\n", __func__,
 			 (unsigned long)selected_size / SZ_1M);
 
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
