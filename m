Return-Path: <SRS0=dgoC=IK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58958C433E6
	for <iommu@archiver.kernel.org>; Fri, 12 Mar 2021 08:55:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEE4064FD9
	for <iommu@archiver.kernel.org>; Fri, 12 Mar 2021 08:55:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEE4064FD9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C16876F9BA;
	Fri, 12 Mar 2021 08:55:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oX_2B24CJWtS; Fri, 12 Mar 2021 08:55:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 871DB6F93D;
	Fri, 12 Mar 2021 08:55:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 69AE6C000B;
	Fri, 12 Mar 2021 08:55:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3C0B5C0001
 for <iommu@lists.linux-foundation.org>; Fri, 12 Mar 2021 08:55:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5B7376F93D
 for <iommu@lists.linux-foundation.org>; Fri, 12 Mar 2021 08:55:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id f7N15Zr773EZ for <iommu@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 08:55:16 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 44C5F6F9BA
 for <iommu@lists.linux-foundation.org>; Fri, 12 Mar 2021 08:55:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sz2tn/RKalZWVq4qkHFAffFVMJTxEcTFnPDiJpYmk2UZYwGlKYY53XodxIva/1+YThaUOG+nEsiLKyd1vzN5P/WBavtlxc3fcsO24NS7zQTfa/7/JzOUHpPMcPmJMrhMy9EZ1ilr7y7ZY23xWsYUPfaK3e3WBXg04yl/9U0KWZ1TZI5wf5AJ0hA/gviczacpPRVi+8pvf1v4xavFmTRMFPwKAdfvtxRei4Lbkh0uSzaR/TCefL6NRNq5o0p56ua6bOW5vYow9z+hoZSvQ0dHD4o0lG2ONsIPXlMT2DfaxHCYlSTOUxs8gyqdQQE8rBg7plApZnteg68xa6B3xrjSew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cFvCOl7pDVDc/babDCR6a50y0Zb21Mlt4GifBf0Aj7s=;
 b=XOSgr4Y6AAn3zfRjuGEVKM3hMKdYKdweQ5uep50Mcxhz8xkb6SeN2vm+66LCq9mTfI+cfbNSsQxwy4wl3pDgSg7m5HgbfEobe+Be+eaI+jyhlQSuyXrhQK1qfsgJgQLIIP6SkEd4JpYsWru/2TlgJLCalV736zMBRyGrokQpHjbm/Rex2FXjYVbkkc5jP9lOPC+BOFc+VwXU9XWNB/ad0DNnwe4t44ZvM3TZ9SFNRP9+QjyUglWVaQwQM4A4PMFoSfid8G5pxWKKu4rcVxdh3BAxWcpuHfSyqb3p5ek5qmLqkdqflos88cc3p15Ofl9oA7aCTBHa1d2c+v+0uh6mZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cFvCOl7pDVDc/babDCR6a50y0Zb21Mlt4GifBf0Aj7s=;
 b=3MrEGF6Q8aIvt0eyX6iVmpQPsY31uT3sK3OWnEOhWgM7iKB8gECWNPScor0qTMjWiO+2Z1bgFHlNwSHTuhhWQ5RF74MxXQeKWEK1raF3T3vQUSoYS0P9cG54tR0E210Xyuk/J9q++N4fFGXttIOnkivfv1xFi/eMyc4hWoqUpU0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4597.namprd12.prod.outlook.com (2603:10b6:a03:10b::14)
 by BYAPR12MB3144.namprd12.prod.outlook.com (2603:10b6:a03:d6::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Fri, 12 Mar
 2021 08:55:13 +0000
Received: from BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::a95a:7202:81db:1972]) by BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::a95a:7202:81db:1972%7]) with mapi id 15.20.3912.031; Fri, 12 Mar 2021
 08:55:13 +0000
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org
Subject: [RFC PATCH 1/7] iommu/amd: Refactor amd_iommu_domain_enable_v2
Date: Fri, 12 Mar 2021 03:04:05 -0600
Message-Id: <20210312090411.6030-2-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210312090411.6030-1-suravee.suthikulpanit@amd.com>
References: <20210312090411.6030-1-suravee.suthikulpanit@amd.com>
X-Originating-IP: [165.204.78.2]
X-ClientProxiedBy: SN7PR04CA0040.namprd04.prod.outlook.com
 (2603:10b6:806:120::15) To BYAPR12MB4597.namprd12.prod.outlook.com
 (2603:10b6:a03:10b::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanolx5673host.amd.com (165.204.78.2) by
 SN7PR04CA0040.namprd04.prod.outlook.com (2603:10b6:806:120::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.18 via Frontend
 Transport; Fri, 12 Mar 2021 08:55:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ebc78524-69c0-409b-3661-08d8e5348ca5
X-MS-TrafficTypeDiagnostic: BYAPR12MB3144:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB31448CBEC17ACC46845B8798F36F9@BYAPR12MB3144.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u8Ck6vt2BalSkoa4p9vRVCvN7UhA/cI8ZdBA6lnIXZCWPwD0DHzY991lf/aakGY63KAj8YFo4xznsztGYlBYlHmbFvkOnNtC3ifMiSVDojfE4mVxwGqhkubUY1Unb40uGX7HXviufks/sasKtfQT0z7JODcJTP4OYdGaE0sWlT1Wh0EyPWchuHvLGNiPQGkgdu6rAREbjvWwt+R19sTtf39Ni0DOFvyrEf+9KxHUFSE17HNCrwjS6BdRjVovn12migTdLPoewDG9dFYKEVGijYvwCkA/a9RWVKV8h8rFiZ756oDCR1HMCCirxwxQE4w7flEa3jpqsOZSoUkw+Nabh3ZqOct97t0kgEGJad6oQYUsyw0y/x8adqAHJSVbVNvpoidmgyCYvmE3RJccr1sQIeyPHl041O375MF32YSC9JoeesGNCK0ZE4BpEwgkcON+f3P8S6TShcDKNXeUkaVJtmUJppXnNIYA9sV8BsjFz2OY1pTreI6gKD+TaOf73H22smK+IFznIoBmFw3mRG3Qja8LnHGkNp5yHfeL6NOAFwgEy4NwjEmUo0njX+Elluoc
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4597.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(366004)(396003)(376002)(346002)(6486002)(6666004)(316002)(7696005)(8676002)(16526019)(1076003)(5660300002)(956004)(66556008)(86362001)(52116002)(478600001)(44832011)(2616005)(8936002)(66946007)(36756003)(4326008)(26005)(2906002)(66476007)(186003)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?3DK/4bSQlZM2dInKCqOFRCQLbfhUFS0ZWVXEdR+onVhZeYC+hj75VL3xgEYX?=
 =?us-ascii?Q?66NjZcW8nPJ9Af6QrL2/RVmpChUOjUUo6w6dGotkWtypUI9gsEJ51MmGQuIo?=
 =?us-ascii?Q?Lcf8v5zazfFHjJLR+ATWp0zQM9rURA7vs2rJJeyE9eMIneCsHow+XGbdzk6E?=
 =?us-ascii?Q?K+925dAdUpjXiChDzd1gHtgMoaMPyaqDKo5EI2A20Ts+va2ZyTvDt4l1lwzh?=
 =?us-ascii?Q?DNC346jT4lag22YCRN8TGHDWiPvozP/huc1iyfxAoFpVZsMUM93gVZBPhdrN?=
 =?us-ascii?Q?Om623+bbi3sEz/3NH3pTuapHVSNRbW8FxA6FnEuzucxlmLRYBd5VTFCBYTkC?=
 =?us-ascii?Q?Of1RyXK1b77iT1+fO7uKPv8i0LCAyZS1zsy1mxheTTwPAskv4CwViCAdB6rC?=
 =?us-ascii?Q?Qsx+WuaM2JUkfxTOc87gRP2akucRe5Vnp+aoGkeM8060Q1OknfHSfirwDEtX?=
 =?us-ascii?Q?KkktO1ctzpN4Uaf27kClEBEGeCGHmhbgvXRn5F0rUZqGB/fGgEY0HtQAUnOZ?=
 =?us-ascii?Q?3lq6tqXsBnD5w4w3P3hH1uF/TAheDYqa+ieR7SXiJ4Yf+JWFnfmTBX45QJjI?=
 =?us-ascii?Q?NuYQo1ahlRP/x82W0ZTed+xfNRuBIfHNIBBKjWRphLkyO4pSOg3CXvjWjWRl?=
 =?us-ascii?Q?8QI3ROXc9bZ5ogQyu7tjy2Ex4E+7XR9RBUV4jtEzd/z2iFVdd6TNZ2mwNVEr?=
 =?us-ascii?Q?SdZqPbIk94/bFNUEtOm5n04iM1x6n4iZ8MtD4CktmQDaMeoaDdu0o0ZCAqvm?=
 =?us-ascii?Q?bOP0CEJ1nHuizJrGJ5qfWQmfT6OBpk4j+1PlDDdBAi9G6gE5mHa28lOP1oo2?=
 =?us-ascii?Q?FmiBLV8hJ1lzbVP95wNHVtdT2yNK4epC5x6jWxZNb2108ssQJrBXVDQF5W4m?=
 =?us-ascii?Q?Jk+zLv73D+I5B8YAZLX8+F3DfYr+M0MhHlNPx1lSN2FuVUQ3ftiimet6NWBt?=
 =?us-ascii?Q?JqNyi/fcDFJceWmCwD5lplPQ/SSbAOGA9tYU3DBFR8Y4mEZ0lDkgGqBC1tVT?=
 =?us-ascii?Q?olD20DDGQndBd6Q8JF8hn0H7spdWRC+z9tKS2cum6bZenogkPaU1LrJj4bLh?=
 =?us-ascii?Q?OcYwQLhttdxNt5nGCAnihay+zqHp7xp7rAcl1jkEqQ/UgMsx0SiJ4qT4RgJA?=
 =?us-ascii?Q?aWGmhvwfXqFMZF3U982k/+jtCKsoMw/gbX5xIpvaA9YvepkeFfLEEd/aSBxj?=
 =?us-ascii?Q?s6UgfmspQxA8cTyxDbmmiXnHJZpSCuXaxfWnQB4EkBJBl4vIhDAGSndPnzms?=
 =?us-ascii?Q?Ygtye33l9ps1zUGPHvDS8n0jORuvu0AM6uwC/qeQAD6lnvqYmEjYrFUpFBNZ?=
 =?us-ascii?Q?TJ+sSN/38mIg/L/ctj3esxHV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebc78524-69c0-409b-3661-08d8e5348ca5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4597.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2021 08:55:13.7110 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n8etoCwQLWXdPD5/9pU8ddi4rEg8Sb/KBNJ0Y+6MuGBTB/vL7AQ0zw5KD1f5fs2dZBLvj0xUxbqW4LzjPqeQRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3144
Cc: Jon.Grimm@amd.com, Wei.Huang2@amd.com
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

The current function to enable IOMMU v2 also lock the domain.
In order to reuse the same code in different code path, in which
the domain has already been locked, refactor the function to separate
the locking from the enabling logic.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/iommu.c | 42 +++++++++++++++++++++++++--------------
 1 file changed, 27 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index a69a8b573e40..6f3e42495709 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -88,6 +88,7 @@ struct iommu_cmd {
 struct kmem_cache *amd_iommu_irq_cache;
 
 static void detach_device(struct device *dev);
+static int domain_enable_v2(struct protection_domain *domain, int pasids, bool has_ppr);
 
 /****************************************************************************
  *
@@ -2304,10 +2305,9 @@ void amd_iommu_domain_direct_map(struct iommu_domain *dom)
 }
 EXPORT_SYMBOL(amd_iommu_domain_direct_map);
 
-int amd_iommu_domain_enable_v2(struct iommu_domain *dom, int pasids)
+/* Note: This function expects iommu_domain->lock to be held prior calling the function. */
+static int domain_enable_v2(struct protection_domain *domain, int pasids, bool has_ppr)
 {
-	struct protection_domain *domain = to_pdomain(dom);
-	unsigned long flags;
 	int levels, ret;
 
 	if (pasids <= 0 || pasids > (PASID_MASK + 1))
@@ -2320,17 +2320,6 @@ int amd_iommu_domain_enable_v2(struct iommu_domain *dom, int pasids)
 	if (levels > amd_iommu_max_glx_val)
 		return -EINVAL;
 
-	spin_lock_irqsave(&domain->lock, flags);
-
-	/*
-	 * Save us all sanity checks whether devices already in the
-	 * domain support IOMMUv2. Just force that the domain has no
-	 * devices attached when it is switched into IOMMUv2 mode.
-	 */
-	ret = -EBUSY;
-	if (domain->dev_cnt > 0 || domain->flags & PD_IOMMUV2_MASK)
-		goto out;
-
 	ret = -ENOMEM;
 	domain->gcr3_tbl = (void *)get_zeroed_page(GFP_ATOMIC);
 	if (domain->gcr3_tbl == NULL)
@@ -2344,8 +2333,31 @@ int amd_iommu_domain_enable_v2(struct iommu_domain *dom, int pasids)
 	ret = 0;
 
 out:
-	spin_unlock_irqrestore(&domain->lock, flags);
+	return ret;
+}
 
+int amd_iommu_domain_enable_v2(struct iommu_domain *dom, int pasids)
+{
+	int ret;
+	unsigned long flags;
+	struct protection_domain *pdom = to_pdomain(dom);
+
+	spin_lock_irqsave(&pdom->lock, flags);
+
+	/*
+	 * Save us all sanity checks whether devices already in the
+	 * domain support IOMMUv2. Just force that the domain has no
+	 * devices attached when it is switched into IOMMUv2 mode.
+	 */
+	ret = -EBUSY;
+	if (pdom->dev_cnt > 0 || pdom->flags & PD_IOMMUV2_MASK)
+		goto out;
+
+	if (pdom->dev_cnt == 0 && !(pdom->gcr3_tbl))
+		ret = domain_enable_v2(pdom, pasids, true);
+
+out:
+	spin_unlock_irqrestore(&pdom->lock, flags);
 	return ret;
 }
 EXPORT_SYMBOL(amd_iommu_domain_enable_v2);
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
