Return-Path: <SRS0=LjD4=JG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E133C43462
	for <iommu@archiver.kernel.org>; Fri,  9 Apr 2021 08:47:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 289C961025
	for <iommu@archiver.kernel.org>; Fri,  9 Apr 2021 08:47:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 289C961025
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D7E3B83F1A;
	Fri,  9 Apr 2021 08:47:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JwwcyVwVf8Rk; Fri,  9 Apr 2021 08:47:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8745B835C9;
	Fri,  9 Apr 2021 08:47:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 65E37C000B;
	Fri,  9 Apr 2021 08:47:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0A5E7C000A
 for <iommu@lists.linux-foundation.org>; Fri,  9 Apr 2021 08:47:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E278F40E94
 for <iommu@lists.linux-foundation.org>; Fri,  9 Apr 2021 08:47:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YLvBYapg_bbe for <iommu@lists.linux-foundation.org>;
 Fri,  9 Apr 2021 08:47:35 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CC55740E8A
 for <iommu@lists.linux-foundation.org>; Fri,  9 Apr 2021 08:47:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eA+X26ObniYWZomigDbWyBZX4vuIDTj3Yy2GkUXXZo7KrqdRZydgl+jbX7q5tybGKxGL2wJq+43yPrJsISgxj0h0jQlP3sljE5ru2Yri65yHofKb6mW3TSckYFZyJ8SQunOCi/fsKvY5P43VqrpNwNuxZn034xvzArgswjzotLeTFP/0LCmXkdSipk0AKLZEJS3Te8W57YXsBzAaq4mij81KQcubzJDq3VS39061W8b9zsjhRMycuIVYdE72xeiF4ZwbHfSDhpSRx6Sp+b3WuCzd0QzNCh3Yi9wL3fKcw/jZkvo7FEKSfY0SxIwzGBpVn29jd25PmKoATw8qfEUKHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W437qHzN0xTwIqfgWm8AG/ephKbNSH6ZbiHdR1qeO64=;
 b=fGSrpdj6Ng2QTs2osLTDY5mxYwB4d3cUUZCO7r9MTSZSJ/auqDEIij1hrwdy2xCmmPRRhAF6g17+hMN9W9ae+lT/vws6XPlCR2SayiJ0TDCGaUKBSU6Y661UxpqrAkT6bN1tMdKWZM0kowg0aqQMiSxSI2zQdL7J5yQmqXLKNC4+wF9P5lf3fdXApLcc2Krh80xi7DYBtNQDikPl92hBBvI5ysFOCgnkC5zmVKB+Yc1n23Puw1ymT30I8Vj0pYDLDNTWr9RsJOJlHoHEdWXlZUQ4zvjwYPUlS29mVSxlgXXe5JD4PBz7e5gARaOq62nU1BcBN2zZPdlrdKNPA9nNsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W437qHzN0xTwIqfgWm8AG/ephKbNSH6ZbiHdR1qeO64=;
 b=yUmWqDXn3pAmulN0Fq8qSaKqRpcX9Zxy5Yf4Q4buH2TL1y90BGV+AZ+gJW+Fvm3V+IxLowreFnRGVbOQua0/FSeDXi/qUOLOlWXllp06TtgheXCZHENeR5VSYKMQ404u6ugiknG/YvC3WI5gT0FIiifdRpJYksieG+g4p5Te66s=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4597.namprd12.prod.outlook.com (2603:10b6:a03:10b::14)
 by BY5PR12MB3889.namprd12.prod.outlook.com (2603:10b6:a03:1ad::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.32; Fri, 9 Apr
 2021 08:47:34 +0000
Received: from BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::cc86:d78a:bb1d:5109]) by BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::cc86:d78a:bb1d:5109%5]) with mapi id 15.20.3999.036; Fri, 9 Apr 2021
 08:47:34 +0000
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org
Subject: [PATCH 2/2] iommu/amd: Remove performance counter pre-initialization
 test
Date: Fri,  9 Apr 2021 03:58:48 -0500
Message-Id: <20210409085848.3908-3-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210409085848.3908-1-suravee.suthikulpanit@amd.com>
References: <20210409085848.3908-1-suravee.suthikulpanit@amd.com>
X-Originating-IP: [165.204.78.2]
X-ClientProxiedBy: SN6PR01CA0011.prod.exchangelabs.com (2603:10b6:805:b6::24)
 To BYAPR12MB4597.namprd12.prod.outlook.com
 (2603:10b6:a03:10b::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanolx5673host.amd.com (165.204.78.2) by
 SN6PR01CA0011.prod.exchangelabs.com (2603:10b6:805:b6::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.17 via Frontend Transport; Fri, 9 Apr 2021 08:47:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e79a77d1-8901-43ce-2da4-08d8fb341e7a
X-MS-TrafficTypeDiagnostic: BY5PR12MB3889:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB388993B20B7717E15C02EDC5F3739@BY5PR12MB3889.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z2xrYNTe/kFnEBYK3jOeNRx49MGYQXYOgiBHilLFp40Hega0ERCy62ZSq3O/jQgfAcCPTWcGRG5cLzlI8lr5JZ35Hx53R2TaP1bUGWJ1iC1yZ8ZE9aa3pHypuKlrSveWG/VaoUoAQYezzFpOAe6zRLDDyf2Q8lMVPdDyrfbYnMBeCaLXG12rv8jEvj5IDLuTlvLVYlW1SSI1CJimcFvSBZi+vFV9NWgRMdsGPSC5OaF0YpQxxYaA9fUWmOn7FlHUxiif4kBBTsDorq4NjaoT+wgf6PR64riM73B+jmpaY5oGUosO90Xysz04Ex/5crObFjKhQbj4txFkGU9vXimEm89U1irF3aGs+ZQ+PoKvmxyEm2dpU8QpNYWwhUAhgjKy3JqHTIJjyg/rl+PH/HpTgMH8Bqu/KtfI/vu3vltgFioSNXC/CkR0DwS3JMZf5vekT+48ubH29C89/GxaMIoTSwKHLPhzdO3xqRV4ewnlKXJ+GeTCb1R7qiYwPpbBMG0RMuIAEbKW7IiGyjHGUmiLoitlwUgXJWuydbnJ2qw1HgdQYera+kXy4xwBq1CUPZPL1YbVpIldwLDYU/K0l4ev6YwYvFHgMbE1MdbhgJKDC/nbxThT4B6DsSr8FPP9xJqH0G4FGYSybz9m19jsNBD0sYZPe1/qd6O5ovIIbRV/JRmDUpSMeB/afCN95G0KsVJkNVYQPhc+Q+ijOVD/lJliFMVghq5Sk/L+Ym1vcS5OGWSDiRMYQvm4OkVXo1YqqVkUh3nK2pGDeOSOeD6sZrwvtVsofcFOZ67OLzcdx/p4DHA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4597.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(396003)(366004)(346002)(39860400002)(7696005)(52116002)(38100700001)(36756003)(26005)(38350700001)(54906003)(83380400001)(4326008)(8936002)(8676002)(66946007)(44832011)(7416002)(5660300002)(2616005)(86362001)(478600001)(966005)(2906002)(66476007)(34580700001)(1076003)(16526019)(6486002)(186003)(956004)(316002)(6666004)(66556008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ngekihBaC1798PnYvI5KyriXmQLgJd5BFOcJj5Z79yLD8rHfIN7QX9uFry9e?=
 =?us-ascii?Q?a0Lw2C6zWxOftaoFZcWiKAjArKN6Z3XdwhU2yKNB5LDrUy0T1uE204/pRo+4?=
 =?us-ascii?Q?BCl61csnZo/9akDTImdSgS9h1x6XlBAM63wLeBSb5G3Y90g/E81RJPu509PC?=
 =?us-ascii?Q?qI/BYx7Za4Mbf4Af5w7EIaSiXVQuLlzKx1Be+If0EmvPTG5cEJF/wUwyzV6v?=
 =?us-ascii?Q?BCEVzUw8XSUHTyFRqBGI/oLjliS9Ithvc1xngi5tZMWI+j+DnI22uN+zvaJs?=
 =?us-ascii?Q?BeD9+d3jYugGnTOxW0xmHvEzBElpxA4OBkK9kUfSxnYlz5E67X9jL4xItmWv?=
 =?us-ascii?Q?ZmSfnTBjKVC/wLryMFcqIlYattXLMoOaHJX8EfGV61Y2jaHeFS8gjN4wQvcH?=
 =?us-ascii?Q?4EBSOj3nd4U/aPjCNzh6IK4Jq2QzoIBbo0ukfDfddiWmDUg1QXutH4n5hPjI?=
 =?us-ascii?Q?exHVWSEFbCK/8KkRvvw70cvm36qUJx8QhiAvAqJaowteVp7ENp6cghHcyxl1?=
 =?us-ascii?Q?spFtMV7BRwTc/TrSomLKWlNVpFuxvTrbTOUjlPTG3uvm4ZoW5Cc7WBE4/2De?=
 =?us-ascii?Q?k1keWv+O7xQjCw/LtmuvXWN7klIbHqGXoktYsPzFmsbZUz6qeMcIoeoXDsOk?=
 =?us-ascii?Q?VJ4VOipQhG7q/uN6BNhivEk2uLeJeZdr+B2PgRiX1iLuwZtICG97z12CZJo5?=
 =?us-ascii?Q?4+YqV4OlrskBxO4U4LUj11R+aoNt4S3DDINblzzLA0qyXPdYZUbQsUCiqOBt?=
 =?us-ascii?Q?wXj/WigZmsXymNoWq3Hu/kWVsa2Uv0ZlM9UzmV4CH2g1SRnvmeqIuugEgI7n?=
 =?us-ascii?Q?Iw+vLHoLIhcp73wH/LDlEaRk+z6rgVJArmYjky+ms4AKHN43Bx7EREOUMMua?=
 =?us-ascii?Q?mlqu7fd8y7IYHEyWyVXjTsfMFbva/ZQU/Cefc5mY8/rrpmtfQdOgjL5eRUFI?=
 =?us-ascii?Q?woAZcqC9PHa//9BBxqkPONBhYt3fRrLHpZ7RH9HPARg2xatxKKb9X5Ll/dWk?=
 =?us-ascii?Q?lWx+h7x6UmqrES6YoaqAjCkAv0lOjIJwYBCfbkIrkx75/NoDiDKv884a09wm?=
 =?us-ascii?Q?ojPg/X+rD5M69fJqQpYuuToLpAVUNcPWaCuMTN4HLF3cb8IdzeIQ4SY/fea2?=
 =?us-ascii?Q?ZVJB/iCO3Xd/NHAiNzEpaupuQb6UpBg8Xcm1spsr+bCrdM//6CRK+0xK+dBH?=
 =?us-ascii?Q?BuzYC11o1qB2TwnhRF8ps5/zoGFE5qnJuRx1PWnlomjLq/+0myuySD2d1S4q?=
 =?us-ascii?Q?8H6LYZdQ72iielE791mkyK3YXPV/V8R6ROghiWRWUxsEKKgxZGuGvZItWnZD?=
 =?us-ascii?Q?e93HEE9nruhldb+JFQ/ZIELA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e79a77d1-8901-43ce-2da4-08d8fb341e7a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4597.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2021 08:47:34.3258 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b3xJzhBX3XVYXkXubHR9DgvwIu/TP/o/C5xmMN9kqH0uZhJSay9Yjb3zyfA+1DXmMJryfd8fPgwXWShVI/a+IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3889
Cc: pmenzel@molgen.mpg.de, Alexander Monakov <amonakov@ispras.ru>,
 David Coe <david.coe@live.co.uk>, Jon.Grimm@amd.com,
 Shuah Khan <skhan@linuxfoundation.org>, Tj <ml.linux@elloe.vision>,
 will@kernel.org
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

In early AMD desktop/mobile platforms (during 2013), when the IOMMU
Performance Counter (PMC) support was first introduced in
commit 30861ddc9cca ("perf/x86/amd: Add IOMMU Performance Counter
resource management"), there was a HW bug where the counters could not
be accessed. The result was reading of the counter always return zero.

At the time, the suggested workaround was to add a test logic prior
to initializing the PMC feature to check if the counters can be programmed
and read back the same value. This has been working fine until the more
recent desktop/mobile platforms start enabling power gating for the PMC,
which prevents access to the counters. This results in the PMC support
being disabled unnecesarily.

Unfortunatly, there is no documentation of since which generation
of hardware the original PMC HW bug was fixed. Although, it was fixed
soon after the first introduction of the PMC. Base on this, we assume
that the buggy platforms are less likely to be in used, and it should
be relatively safe to remove this legacy logic.

Link: https://lore.kernel.org/linux-iommu/alpine.LNX.3.20.13.2006030935570.3181@monopod.intra.ispras.ru/
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=201753
Cc: Tj (Elloe Linux) <ml.linux@elloe.vision>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: Alexander Monakov <amonakov@ispras.ru>
Cc: David Coe <david.coe@live.co.uk>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/init.c | 24 +-----------------------
 1 file changed, 1 insertion(+), 23 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 648cdfd03074..247cdda5d683 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1714,33 +1714,16 @@ static int __init init_iommu_all(struct acpi_table_header *table)
 	return 0;
 }
 
-static int iommu_pc_get_set_reg(struct amd_iommu *iommu, u8 bank, u8 cntr,
-				u8 fxn, u64 *value, bool is_write);
-
 static void init_iommu_perf_ctr(struct amd_iommu *iommu)
 {
+	u64 val;
 	struct pci_dev *pdev = iommu->dev;
-	u64 val = 0xabcd, val2 = 0, save_reg = 0;
 
 	if (!iommu_feature(iommu, FEATURE_PC))
 		return;
 
 	amd_iommu_pc_present = true;
 
-	/* save the value to restore, if writable */
-	if (iommu_pc_get_set_reg(iommu, 0, 0, 0, &save_reg, false))
-		goto pc_false;
-
-	/* Check if the performance counters can be written to */
-	if ((iommu_pc_get_set_reg(iommu, 0, 0, 0, &val, true)) ||
-	    (iommu_pc_get_set_reg(iommu, 0, 0, 0, &val2, false)) ||
-	    (val != val2))
-		goto pc_false;
-
-	/* restore */
-	if (iommu_pc_get_set_reg(iommu, 0, 0, 0, &save_reg, true))
-		goto pc_false;
-
 	pci_info(pdev, "IOMMU performance counters supported\n");
 
 	val = readl(iommu->mmio_base + MMIO_CNTR_CONF_OFFSET);
@@ -1748,11 +1731,6 @@ static void init_iommu_perf_ctr(struct amd_iommu *iommu)
 	iommu->max_counters = (u8) ((val >> 7) & 0xf);
 
 	return;
-
-pc_false:
-	pci_err(pdev, "Unable to read/write to IOMMU perf counter.\n");
-	amd_iommu_pc_present = false;
-	return;
 }
 
 static ssize_t amd_iommu_show_cap(struct device *dev,
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
