Return-Path: <SRS0=1MD/=LF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 906FAC48BD1
	for <iommu@archiver.kernel.org>; Fri, 11 Jun 2021 13:11:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 432C6613E9
	for <iommu@archiver.kernel.org>; Fri, 11 Jun 2021 13:11:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 432C6613E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 11BEC83DE5;
	Fri, 11 Jun 2021 13:11:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IrDQdz5sRV-i; Fri, 11 Jun 2021 13:11:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7DACC83D61;
	Fri, 11 Jun 2021 13:11:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 543EBC000E;
	Fri, 11 Jun 2021 13:11:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 41E81C000B
 for <iommu@lists.linux-foundation.org>; Fri, 11 Jun 2021 13:11:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2859C60790
 for <iommu@lists.linux-foundation.org>; Fri, 11 Jun 2021 13:11:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=nxp.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dXg_7y99DjZz for <iommu@lists.linux-foundation.org>;
 Fri, 11 Jun 2021 13:11:50 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr30041.outbound.protection.outlook.com [40.107.3.41])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5D9CA606B8
 for <iommu@lists.linux-foundation.org>; Fri, 11 Jun 2021 13:11:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DA5aZoJKA+yfq1sz2Tts1E8A9lqVGIDvEYl6wwC4cVZ8JD6sg5KEN54TX6Oyw434Kvotm3VI0qcR/sBwplgixpkozGLSBvfspjtX5puNc6dvPE6RlqTI0d+zurdjeZWNe5XJR0R+6T4YauK4V0B6/L3awcgo5+a78UciLaVi/IhD20+f+7WnycbN+BwOf09p01ehFD0crdIfUqDWKT64ZOO63lyocWAmqM54oj3rVqQHYjhN/TPc4DUrvB8jxUMCHmRuG61zRhM7wV0VrdKhiMJ++tyVQ1n1cvCw6N1iBlARjzWTZRz5YOcewxIbtL4QQ6f5geGNx0syBuVx4mX9PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fyYlJwbZwH7LAKwO6QOWlqHh9/q1+BcF03xffIp9DS0=;
 b=IsP2aQo8ffqQ+BfYjNM9mGmTxTcHb9YP5C0L5oNL/PDIWnjMNz9hML2cUjbX0+CdY9k1xerKij50PamxZsvkZPOBo3MDKxDpRL35vf37I5heJqpnwRazfUZZJ6MhbtebadEouOYLBeqowKzgUqlwWCTehKYg9CPHFAdfN47O5+D7Nxj2C5RZFInjIiyscpcm6707v0nnSvcMBf0Yjp0hfjci9j8bF0F2l73BsyTMHKkcrqVKXdLIC6VFUZB5lGYHaZTwW6UXZjtMsOTFxdb7YeEqZ4maiPN1yXkmQwogNC+/FFHsGRDzrRXiiXF9GXPEsdtDqjIMgrCdfL01Yp9C1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fyYlJwbZwH7LAKwO6QOWlqHh9/q1+BcF03xffIp9DS0=;
 b=RVMR6SekLX++57F+lEL63PzlhVQvshdMJB0heLUKhtnv7Zt0WqvgY+jsZYyq7/tS6//QAdlbSXX9gCKWeN0+xvsgJ9Z5XnoJaZ3jiRnNXjsKa8u0CnAwMdUT1RgLIifOsaC5hpz5bluxkC6A2Y7AhA6LIpCigdkqFVVgmK+v4IA=
Authentication-Results: lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=none action=none
 header.from=nxp.com;
Received: from DB9PR04MB8477.eurprd04.prod.outlook.com (2603:10a6:10:2c3::11)
 by DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Fri, 11 Jun
 2021 13:11:47 +0000
Received: from DB9PR04MB8477.eurprd04.prod.outlook.com
 ([fe80::9daa:ab21:f749:36d2]) by DB9PR04MB8477.eurprd04.prod.outlook.com
 ([fe80::9daa:ab21:f749:36d2%7]) with mapi id 15.20.4219.023; Fri, 11 Jun 2021
 13:11:47 +0000
From: Dong Aisheng <aisheng.dong@nxp.com>
To: iommu@lists.linux-foundation.org
Subject: [PATCH 1/1] dma: coherent: check no-map property for arm64
Date: Fri, 11 Jun 2021 21:10:56 +0800
Message-Id: <20210611131056.3731084-1-aisheng.dong@nxp.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: SG2PR06CA0139.apcprd06.prod.outlook.com
 (2603:1096:1:1f::17) To DB9PR04MB8477.eurprd04.prod.outlook.com
 (2603:10a6:10:2c3::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by
 SG2PR06CA0139.apcprd06.prod.outlook.com (2603:1096:1:1f::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.21 via Frontend Transport; Fri, 11 Jun 2021 13:11:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5329cae0-2685-4c5a-f35b-08d92cda775a
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DU2PR04MB8536156CD113413C741DE92180349@DU2PR04MB8536.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: egbr9T1QOFGjgXUkQNLtW7xQB0kzQbAyyaf10HJN3KdD30MKC4Ds/Zf1bvn8qp3lp5cxpSDUUtMTAlBzmzPxL4BQ5kYRiwIaPn5kt4P/NGmcTF+zjNDa+8zDkaR8WzEPcbU+9k9SU3KOEiE4vZD25+0mCNbVQ9OlDRPhgog6xKXEm0PRtEfrBMw/7rx+wVgt+6b3e8a5/+5mBS3ZQ1gl+IkdvOIMSe0EcfmENHSF4CpnskiKb/b/6hhC7XM0DreJOnXEiGiIL8+4TC5TH+UPWLCb3r5klrltDWCUTn2he6+mOVaGzJV9fOmMzDRzHM9P5bcVfz7iK8PGNrm68kr3QpUqPJf2LqjPrmYYjuQfOmfgAiwaTkaqrI4NMsh/3TWG0aDFn0G609qnNT2saby1CHlSqmG4FdiwGf/g9A58YXCP/9rO5+WgFcAQf6XmlPU4y2Mu2G7ub4dBSRaj3mfq09hnl8bmBY98iG/mq8+VOao/fMDVyhYuial+oTcH+pNTgL5KS/0lgkdPJTJ1GPJXDXYuHNxas/TKfo7VtP+mAe+5rJSpO15I1wxM1kLZ8EPkWdZSdqvCyKpTRfJ7l1eIN4WD1Hv8ZP6cKIcmDPMJ+hq+B8ZrCS5GL46S5n7ZKyJ5WTTJC0i7bOZXGUcqYBz9MDwsw0jW0tSNOJDv+gGJwwiqieCjK93Ecaa5OjJuh2aD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8477.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(366004)(39860400002)(376002)(136003)(1076003)(5660300002)(2616005)(956004)(26005)(8936002)(186003)(8676002)(86362001)(2906002)(36756003)(4326008)(6506007)(83380400001)(316002)(52116002)(478600001)(54906003)(66556008)(66946007)(66476007)(38100700002)(38350700002)(6666004)(16526019)(6512007)(6486002)(6916009)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?amQN9Yc4VrWwNrRSpHC472m7nc67OZD6/ON3eHkvYTbkWq3UlgHaLj9XL31L?=
 =?us-ascii?Q?WHy4aFHL2ie6IwEJv74RKm1mLxA5nK0TdE7DX/cVfN9CljqlBR/HjNEGjM+v?=
 =?us-ascii?Q?7fSimNSlcJPlc3YUsp8hhm6BwgojCOYnP1vSG0XEW7XPfzeQ1cA+fTijL9pZ?=
 =?us-ascii?Q?Nu9CkJif8WIY92EKsON5xl0ZZh4z5ojAGbDFfRVp5mvwHvUv9trGgsE9YhGw?=
 =?us-ascii?Q?5DMixD10x+8unMQxlZlgwKlF8veY4B434G/8Qwh6QK3EXPDf7FLCeXXuZX9w?=
 =?us-ascii?Q?JPGqs2QS2bSTQNLDmPCmqpKMhPD7u2YIN8O0Zt6Aa3R/MgkV4fRElQyW9YTU?=
 =?us-ascii?Q?fS8+UMxMNddQ8f5DAfYk8XkVLpp6rDAE9bjYScglpk7T9pn1fl9pUOBGLJbV?=
 =?us-ascii?Q?rqTwr6OHKSl82lIZCDBtFFFREiI6KGmerTaF5K/NVKVAW1ybTn8UXf+yEUkk?=
 =?us-ascii?Q?AaO2UImvIs2/N1TL3FPgnWMms1EN7BymB2L6ggLJHkaAgLYJE7WC3cGMmWJq?=
 =?us-ascii?Q?IBvuDNEa5f6NgvOm5VwIcTehz9lm0FCOeicn+GMQu9k5r96xpM+FA+1khyHO?=
 =?us-ascii?Q?US/0+raRM/+06gJfRi0HmBRQo9UbkgwDVGaFejFcRdRPWwgvO5J8aFBZx8he?=
 =?us-ascii?Q?soHO70UB+NvVcVxJ5xXg2VtmZpn3494ak1GPubFeFzGx2iU3AoTMhDbZZOgD?=
 =?us-ascii?Q?JuLzo90FW29B+EX2zNPv2IQWdJSXzfa7581fd2Njg/5Qslri0wtGlHSP1JnM?=
 =?us-ascii?Q?nR5mMMbcGr4up9KrKSBbXLUhcqMBfvv0/v/K5tjvRf+N1ugR6EOA9wVnLc+D?=
 =?us-ascii?Q?/0SZgTdRwiqDSU0kqvPv94eq9VTGp0cHyk3hAms151siNMRsOzR2zWtaQ4Lp?=
 =?us-ascii?Q?2P7qq+/kG77L3nSed+oewsFWinZi3QHL+mFHHjhJ6MmBBIXFju0dvieH1yyr?=
 =?us-ascii?Q?wLkRe3rVJJmRPRRg4zBIie/QBz0R0n4D/5Um8XM5cjz2NBBzvGaxE1TZB0WG?=
 =?us-ascii?Q?6yALvGfpQZm7o8BeUJ6kwK22b9HBqfY+PwSAbQx/2QzDLeMsrcFzX33I+e4r?=
 =?us-ascii?Q?gl/D1FIXgs3uVG4Iybp/T6tLnm8JMCnLm4D9FiyU8coqxSiKShtKkZJ+GF6u?=
 =?us-ascii?Q?IpVTp2lJ5iJopw18QSl2Tv46kX/q41lsIcqlAsS096yf91Hm945QixJKqFjW?=
 =?us-ascii?Q?zYDeFb4KLFdnoFMnbV0/t2eG9wIT/HDXW3l07x0TKAfwpKxWL9NByu0L+XGP?=
 =?us-ascii?Q?aTZ40FugQWeb2mejF3bajajdiQGADs88Hgs/suFyhXvFv9A2/DNcVE+yfekf?=
 =?us-ascii?Q?l6MCNGTdLcMykBERLXiz/eFz?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5329cae0-2685-4c5a-f35b-08d92cda775a
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8477.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2021 13:11:47.0749 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: szZvpNX1Wa/o8G7xRdE0agBjb3LKZkkFXFrJaTJG8cORYq2GqmcLgl/yGdbdpPldcCoijjVI8qMH0/i15x5J3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8536
Cc: Dong Aisheng <aisheng.dong@nxp.com>, dongas86@gmail.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
 linux-arm-kernel@lists.infradead.org
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

Coherent dma on ARM64 also can't work with mapped system ram,
that means 'no-map' property must be specified in dts.
Add the missing check for ARM64 platforms as well.
Besides 'no-map' checking, 'linux,dma-default' feature is also
enabled for ARM64 along with this patch.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 kernel/dma/coherent.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
index 5b5b6c7ec7f2..d1831da7afba 100644
--- a/kernel/dma/coherent.c
+++ b/kernel/dma/coherent.c
@@ -356,7 +356,7 @@ static int __init rmem_dma_setup(struct reserved_mem *rmem)
 	if (of_get_flat_dt_prop(node, "reusable", NULL))
 		return -EINVAL;
 
-#ifdef CONFIG_ARM
+#if defined(CONFIG_ARM) || defined(CONFIG_ARM64)
 	if (!of_get_flat_dt_prop(node, "no-map", NULL)) {
 		pr_err("Reserved memory: regions without no-map are not yet supported\n");
 		return -EINVAL;
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
