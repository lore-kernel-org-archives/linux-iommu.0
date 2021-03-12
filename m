Return-Path: <SRS0=dgoC=IK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C2EC433E0
	for <iommu@archiver.kernel.org>; Fri, 12 Mar 2021 08:55:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB1F064FD9
	for <iommu@archiver.kernel.org>; Fri, 12 Mar 2021 08:55:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB1F064FD9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 829FC4ED73;
	Fri, 12 Mar 2021 08:55:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wBB2UQxZgLD5; Fri, 12 Mar 2021 08:55:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0D8C74ED64;
	Fri, 12 Mar 2021 08:55:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D95B4C000B;
	Fri, 12 Mar 2021 08:55:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D9D96C0001
 for <iommu@lists.linux-foundation.org>; Fri, 12 Mar 2021 08:55:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BFF0E6F9C5
 for <iommu@lists.linux-foundation.org>; Fri, 12 Mar 2021 08:55:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eQiJa0wXT8hp for <iommu@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 08:55:17 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AF9106F9BC
 for <iommu@lists.linux-foundation.org>; Fri, 12 Mar 2021 08:55:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S7B3/ugyri2Yy97KCglr6+dI1LKUnv/G5y8AE/qNigTYiYVoIOoCzo84KBD1EOm0Lk2kGRziLsP80ewXfYO0rP80bKlm0EUAo9+JMJaRCXzrFaagFwJ0wsAoYIKPYCn0nA0SqjHlXuuYw0dvlYPRoubd8GzTGkIAwQIqkD/oRA97D7ke3WXpMAJpNWLECA7kQJ5lWo53588WWWkdTb/44UqpUGpFNOgmdayTJkv/xLMWuOgjda6THwJ4iC3NEdt4NPsvhii2XVnE7/h5tjvSy2MabhmQymDVigqUrhWH+DW8ngPbhabzwKwhgZWyGaP/Aw9oW1CFHW11V19t2neUrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YKOpEox4WdGiNtD5QFzqwVWgT4ZniAT+dHSiM0V6Hts=;
 b=QVhAvHrYRpx9AocLRN+RbrOqKFdfkJbNDvkPsZF6o/dnyz8XeQsBWfz5AKMzqCdvcL770TIKncCTFA3xnH8Urb9qC6Pii7YBKpbd4PZAh8Z6JFQmuLdeYZcaKXDoUuqAKGZh7BvsX+LQIOFwI30LKUPJrJA2i/Htmm5FipidEekv6C5U0coFGnaxZG2gC6/CfC7Hga4/SHPjZ8ZYg0CGrpapmJTJkR1d1dJ+ddEN73rG5DDseRTwBWqy3g40O4JWdADoSOFVTPSqOJ3gF4goRpdymsCkQ+hsuMsDBvzDDyTMzrjGSWpqpqeU6+lzHzM1WC7uTggqNtQXAAutDByfzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YKOpEox4WdGiNtD5QFzqwVWgT4ZniAT+dHSiM0V6Hts=;
 b=2PkULhzXWuVM2fwtsk4kkLNbfMmEtHsOZCTlmTHesWlk88rMHwI1O7Tjk+1F7rmA7wAq35NDOmERnej5vSwwLG1fixBcmsgEUdP9QDuTwsB0No8d1EuBr/S7vRNelX+x4rzcTZrq0SEGwHFQ/l9zazxIBKIfUCGwCsUN5ac0Z3M=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4597.namprd12.prod.outlook.com (2603:10b6:a03:10b::14)
 by BYAPR12MB3144.namprd12.prod.outlook.com (2603:10b6:a03:d6::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Fri, 12 Mar
 2021 08:55:15 +0000
Received: from BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::a95a:7202:81db:1972]) by BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::a95a:7202:81db:1972%7]) with mapi id 15.20.3912.031; Fri, 12 Mar 2021
 08:55:15 +0000
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org
Subject: [RFC PATCH 2/7] iommu/amd: Update sanity check when enable PRI/ATS
Date: Fri, 12 Mar 2021 03:04:06 -0600
Message-Id: <20210312090411.6030-3-suravee.suthikulpanit@amd.com>
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
 Transport; Fri, 12 Mar 2021 08:55:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6d34620c-a661-4028-1bc3-08d8e5348d71
X-MS-TrafficTypeDiagnostic: BYAPR12MB3144:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB31442E93B2D061994276BFB8F36F9@BYAPR12MB3144.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KngpBwoENgKBx+8IQ7V8RuOggOSNtk7bdt6VkggZcFSbBjPef2803Tq+iknZJInfpKmywr0g8rvFxBkB0M7ZFbILMIn8uKeEMA/Ru0k9V7YfugbVjJuDJeHgVioZS2Urg+8JX8BDtEk91vkbIToxXlAISAmfPx/9WQ/uGD8Wdr+zHjv7J5bazcDvMQfMeXgNKXTJzzozf3OETrH/yLHwUsNZ9FHOLuxzHsKtE0u9LcX294Vq8yZov6ux2dUPAP9+IfBftMWGF671tePkUZ9x92YtzuZcDlGDGM3nJwH9lBjRsQS0lhgk7j2dmifHE2hVzwTVgLJH2doBWlLc9L1Rg7NeDngwmjerlOaq37XeyUuGFYB2qFhIqYx7VjHcBxhQY5JJPeaeV9mUpU0yQOhtnk8agNScLjtywyVHW813DnCcOQVsFclLNjtO4dCXjqZ5/2F4vWjzqGBqnBJale7yJ45/65oQbwmjTr3YOWTJh2zKGYG1JgrvTgAx61eOCyDM0Q6cu+gHcolvvRTfgtV5/J04w/6KHNqFFIfEamp2LC7V7/0Q0jLOhgO75W0dvMHr
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4597.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(366004)(396003)(376002)(346002)(6486002)(6666004)(316002)(15650500001)(7696005)(8676002)(16526019)(1076003)(5660300002)(956004)(66556008)(86362001)(52116002)(478600001)(44832011)(2616005)(8936002)(66946007)(36756003)(4326008)(26005)(2906002)(66476007)(186003)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?R0oVmubGDhR4/1xxlsfs/NwFjMxo43xNkJgFlNiCCK3eabCdwUpAxct6/u9y?=
 =?us-ascii?Q?kq6kwzrTNdfyGInOoGsmbaJDOmhFnSEdVs8s0bXkd3ao94v9AWK6QemmBgi2?=
 =?us-ascii?Q?S4xnjn3R6tLi9g+iMcY3QQcuaW8xXFXTKc61EpTQRSEuJGiFaO010hZbi7Pe?=
 =?us-ascii?Q?rwKf3+0AbZPri74+11Xg9wg71DdKgijzkic6oMeUVXkiLDk/7MHr59jpBDCS?=
 =?us-ascii?Q?B6+euA3DraUFlPqrslHZul/EI9VeM39dVC534WzvKw4nQi1D5thRdRaxZc5E?=
 =?us-ascii?Q?zxd3ApIuENrWOfJ88Q+E9u+DhMb+E/G5hTFaK0StEaWfiD8I/8cB852XDQmY?=
 =?us-ascii?Q?C9V2lVjuRWer6O/oaIhieOvrpuPOAJorCeJyZ86pQ4CIUp77U9nbfLVw2qHA?=
 =?us-ascii?Q?h2o+UrLaOfRv5kWB1LuL0LxiZpMp3IOzDS4VDy0pFdQ4+q1sZSHlNMIErzdv?=
 =?us-ascii?Q?KUdtGNSxs/ZU1KSQ7h8bBZTTvaJDkYVOBP+o6eBTVS51hUgrTC77I2caXZFy?=
 =?us-ascii?Q?dxZZuCUYXOt1ZCwzdRphv0a5i/kvBxj2CSsOJX75gkrWKL1BaNfJzx/vW+tX?=
 =?us-ascii?Q?KvRbGdw38BuiWcW22Ys1gbrnipIY+tVWZeXZGiYj3TaiIVuFMX4+gawsu0/N?=
 =?us-ascii?Q?FIUY2wdhH4E3mnPWpnCNQ48/ixwVk4EdAMeaPRUZ3igbOdRN0Q3/QE0b6q1a?=
 =?us-ascii?Q?R0EhYFQBeIIlezz6yMXZ9xPxZe+uHugtZEh7xiDuMo2iJ+EWNWpSIiPgcEPD?=
 =?us-ascii?Q?IrVc9SlMg+x7bWDmJhK/LoExPdfwwxLoWJR51SkhW2IyMWX9Vn0lMPUPgbvl?=
 =?us-ascii?Q?kuBhYoc/Bo+b5A+X76ZWf1EbP6yF0q69biN7blSQiQCL3DWQSaICTJrzeRyk?=
 =?us-ascii?Q?i89qP5c/MMI8tHNZPDntCdwsX2pmsY5LxaJd3wfTtscNzkcJN4BBwjreeuk1?=
 =?us-ascii?Q?DAUXT/7MP9h6uIMnQXjYHQKhVeiuF1op1dYABiVBLIcAixxU6Wnf/3BVrpZs?=
 =?us-ascii?Q?zQ9ftLkoBGUMW9IebQo4qRrt7WDmo6vB/o/8kSYwyyIKbsKZ7dCOLqyk6fWD?=
 =?us-ascii?Q?d+2HqPhRYasJm5I9AZqCNexOtenFEc7G+GzjU10it7NTQ/L0ksWkxzWS5ENc?=
 =?us-ascii?Q?vKDQPF+bMUNGpEDbjph86du+mUVSCzBbYo98qhZ8S6sSH8dWagzN6HKthEF3?=
 =?us-ascii?Q?V2kyY04nrXwkdOQXDJ2wVzFbCEABiw2fb/PSqG/8uKf3lmesiSgrXAfN5OsF?=
 =?us-ascii?Q?aoiSYihO48YGcaeK6wDG6xGjzhAcnZ/gXhhw0bDyG1/RYM2XvKwZjP+cT61S?=
 =?us-ascii?Q?NpI4wQeI2cW9Fw7JVw+tCmCZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d34620c-a661-4028-1bc3-08d8e5348d71
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4597.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2021 08:55:14.9484 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wc8tBBJLm7wXZqK/blKNo8ecmyGkMrNupLyNKX8gvOlYUC0CpmAcmo6Hix7T2dng1PF6P6RKlcye5827dOx7Hg==
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

Currently, PPR/ATS can be enabled only if the domain is type
identity mapping. However, when we allow the IOMMU v2 page table
to be used for DMA-API, the sanity check needs to be updated to
only apply for the case when using AMD_IOMMU_V1 page table mode.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/iommu.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 6f3e42495709..f3800efdbb29 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1549,7 +1549,7 @@ static int pri_reset_while_enabled(struct pci_dev *pdev)
 	return 0;
 }
 
-static int pdev_iommuv2_enable(struct pci_dev *pdev)
+static int pdev_pri_ats_enable(struct pci_dev *pdev)
 {
 	bool reset_enable;
 	int reqs, ret;
@@ -1624,11 +1624,19 @@ static int attach_device(struct device *dev,
 		struct iommu_domain *def_domain = iommu_get_dma_domain(dev);
 
 		ret = -EINVAL;
-		if (def_domain->type != IOMMU_DOMAIN_IDENTITY)
+
+		/*
+		 * In case of using AMD_IOMMU_V1 page table mode, and the device
+		 * is enabling for PPR/ATS support (using v2 table),
+		 * we need to make sure that the domain type is identity map.
+		 */
+		if ((amd_iommu_pgtable == AMD_IOMMU_V1) &&
+		    def_domain->type != IOMMU_DOMAIN_IDENTITY) {
 			goto out;
+		}
 
 		if (dev_data->iommu_v2) {
-			if (pdev_iommuv2_enable(pdev) != 0)
+			if (pdev_pri_ats_enable(pdev) != 0)
 				goto out;
 
 			dev_data->ats.enabled = true;
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
