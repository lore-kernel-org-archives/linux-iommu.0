Return-Path: <SRS0=GTcZ=FL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECCC4C4361B
	for <iommu@archiver.kernel.org>; Mon,  7 Dec 2020 09:17:37 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57BFF22A85
	for <iommu@archiver.kernel.org>; Mon,  7 Dec 2020 09:17:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57BFF22A85
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 040351FEAE;
	Mon,  7 Dec 2020 09:17:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iXDqBsyU+8Bv; Mon,  7 Dec 2020 09:17:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id EE381203D4;
	Mon,  7 Dec 2020 09:17:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D24F3C0893;
	Mon,  7 Dec 2020 09:17:35 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4C4DDC013B
 for <iommu@lists.linux-foundation.org>; Mon,  7 Dec 2020 09:17:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 2CFBA203D4
 for <iommu@lists.linux-foundation.org>; Mon,  7 Dec 2020 09:17:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cFUwS+dB619J for <iommu@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 09:17:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2054.outbound.protection.outlook.com [40.107.236.54])
 by silver.osuosl.org (Postfix) with ESMTPS id 42E901FEAE
 for <iommu@lists.linux-foundation.org>; Mon,  7 Dec 2020 09:17:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cGJWmBEzGiK652Lpnw9/cm/1e3llKvs9sqhk116Byp0lbeXtwEMigiKR7HRrUCZ2NdP7h+iuL/15IMki1OR1Et4I73GlQk6TOoP+pA45/jfD9WEHSONf+BTyIVahE9efV6hZYi2Ii6Z7dGduVFkRX/CmXJkG2wct9cpK0aWohd1WGeMfS2FFS0rt5TZxJL5Vl6QV+fpkJVbaTk4V09oWW89M1+Mm+27cuilPxIgrh8ybbv/vhdMgeAQKjsnjtKP/Hj1h3PUGEilibdQ6sUiOapQy1jr+liZBeuwPJBSsvq0wCCc20x+UCIIifC56a3wp+qPz3+s9ccdYXSSwzvGHeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=boBKTk+JbaihSgrgWOTvvfuwNC/n/tv7SPKM9nfGk1E=;
 b=ZRJg5cwegXr8qVWyZMJ8y+TzpnuTZX1lrvBwqqsnecPHX+zD3883AD7idhqEwcxsEg+BFRZNEbqHVpDN6Kabcp3tKuIeiFKEsvG3lIbGZpLdnHOpWU9O3ZAArSLKXSXCTbI9CZL9+YciLZsN/0l64uXzkRV1twgG9Xnch1PM1fA6nZ6ccy20bNtANb45QL2UzVrRJRRo3u1NILgmn5UDbzryDM/ODqZLqIpUTNu4VRj8CDcOIq+TnsL4O3qf/75frhEMpJNL0Hl3weOG6B7woABQWDRh4Rmd3HkWAxOiyqK21OiJVXW17zvhUY5+OFRarl5JaXH/+A+gYX9IEcXzMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=boBKTk+JbaihSgrgWOTvvfuwNC/n/tv7SPKM9nfGk1E=;
 b=AKivIH/hK9VYRNuJyHq3bjxt0aQ9xn0DrA6c72ECN6/q+Wk0wA4Ez8OWRlIz7/+8KpCTXujOaZt8GhcuueKAw/drvzxH6szbgbyq1+1B0d+b5gCR45MtllZkRSz26sFEKBHg1FXJ3H9T2m06Ny68+D8HAmcn5rAfcdiw+cQsr7A=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4597.namprd12.prod.outlook.com (2603:10b6:a03:10b::14)
 by BY5PR12MB4164.namprd12.prod.outlook.com (2603:10b6:a03:207::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Mon, 7 Dec
 2020 09:17:29 +0000
Received: from BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::dd10:efd2:e325:53c7]) by BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::dd10:efd2:e325:53c7%3]) with mapi id 15.20.3632.023; Mon, 7 Dec 2020
 09:17:29 +0000
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org
Subject: [PATCH] iommu/amd: Set DTE[IntTabLen] to represent 512 IRTEs
Date: Mon,  7 Dec 2020 03:19:20 -0600
Message-Id: <20201207091920.3052-1-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.78.2]
X-ClientProxiedBy: SA0PR11CA0114.namprd11.prod.outlook.com
 (2603:10b6:806:d1::29) To BYAPR12MB4597.namprd12.prod.outlook.com
 (2603:10b6:a03:10b::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanolx5673host.amd.com (165.204.78.2) by
 SA0PR11CA0114.namprd11.prod.outlook.com (2603:10b6:806:d1::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3632.17 via Frontend Transport; Mon, 7 Dec 2020 09:17:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e53cd624-35b6-40bf-336d-08d89a90ebf8
X-MS-TrafficTypeDiagnostic: BY5PR12MB4164:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB416458038AAF76F27559A16EF3CE0@BY5PR12MB4164.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:489;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 34ykra/wdAPCsOhG0H+qbTOg0QLEn6RFZtpM3nmOsGa7IrW2hC/WDXEdwZTsWLRi15U1Okmq1xcY9oiQ5+YNg/sXCTUvfpU8GiZeZbMO9XWPPurPCIQTbiPC5Uo3mkob8iX3EGGwzYEGWskBzfzzSJIRtrE5YpW4niBX1709Ys0HpGrcPfDc1pKkAqDh/mYvtmVJ/SoSbrucSj0DI96mI2gC625w30tgZ5QOOt6PZmCKPXNfqEoTcdKogQB6CpzzKfM3q32GARX0R1tsAltUYOYtsWX9rlxiaIqIrH3z2F2f0e/h8L+WVORkJXj4stRciVJI4tmZZEoo+gWqFHQ+nA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4597.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(376002)(396003)(39860400002)(346002)(86362001)(8676002)(52116002)(8936002)(4326008)(478600001)(316002)(66476007)(66946007)(66556008)(83380400001)(1076003)(26005)(6486002)(2616005)(7696005)(186003)(44832011)(16526019)(2906002)(6666004)(956004)(5660300002)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?vUoWYwB18mVxPaFTM7nWv1yzKiYxQ3HQKvuuOPPi+rFnJXNGGTzH9MT08OAQ?=
 =?us-ascii?Q?w2v9q/MAUNx4d6AFo6ukzTh/slTBfNyA3VEPg3DCp9Ec1YOut4YwocEGfcOb?=
 =?us-ascii?Q?XzwYYieyvB0UhuwmFQMgQXOTli1ZCxZn20j/u6gARzTk1F3yCaF03VkMuuNY?=
 =?us-ascii?Q?+LJumlo81/porV9rR6QSKG+fFtda0jQsrPpQvw3xMhqaFsJYszunmMxdUaVb?=
 =?us-ascii?Q?RPEYcUMryg9fwI4oGPUCauKoPgIVzXJujd7D6gSrwCzXqmIGIBeg4Vu0r2dk?=
 =?us-ascii?Q?1Joip/86Arp7aM5TCLxIt4h4PCmAMVgiJYw20ni9PD1mvgocyjIeFe7IQ93C?=
 =?us-ascii?Q?bjnECE98TwZfTncAbMveNUGJOBvpKV27L50RGM4wAjMH8Uh5nsGy0BWaBxOU?=
 =?us-ascii?Q?/EGymaZELR5RNksZh30AndSFys00nz7tjImMaNdK3TzpZnXj1TOLx/+9pk0q?=
 =?us-ascii?Q?lbQzy/yI6voCCAMYs1tSWoriEWCBPqlkJkZmqABB7aHp8lanAo6KRJIWstXK?=
 =?us-ascii?Q?fSMCb8MxtRIGvFbUONLR1oCEbEfEdc2p49Hvv4kVHX5dx9FhK0QRqT5fPnNe?=
 =?us-ascii?Q?OhMzuQG9CFpfj0I4UtyuMy2h1rrbh8i1IsV6R0/GmR4HGcJ6AUgGzfMtPRL1?=
 =?us-ascii?Q?9ntyESB85iIFYQ+3fPCvfypxrG/MbB9HbTNa2ho5ryWjPzv/SV39jvOrh4tn?=
 =?us-ascii?Q?BQp0jt03ltYcZJu2g71YBzqpSSWp3zeZ0EUh8dAVI9n8GZnHWSyS++F5NQHt?=
 =?us-ascii?Q?XlRssYxcVXohR/8eWGeDdisqtfk98+LkXCoWCEoBKYKVSNabxEZRT+sRLUwp?=
 =?us-ascii?Q?P9MaG1jRpDI+j34IjD4P/vskiNm7rh8ur4yDnVQj8YM9xNs+BJs5t4uNHSIy?=
 =?us-ascii?Q?Tqtc9oN2vw1lqdUxmADc5VfOGdkaKMYnStWf1Df9RJrfSl0ocXTbmcO4aOXG?=
 =?us-ascii?Q?AyN7hIEzW9Qcaj9jCelfA2dKafWaEog8lF0GAlMaH9K8fRhL2ilUMh3Dof0C?=
 =?us-ascii?Q?hAfc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4597.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2020 09:17:29.6725 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: e53cd624-35b6-40bf-336d-08d89a90ebf8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p7+lv/8ZgFzWI/c6P+wQopLr12sdBLwHhPABu1p4Z/7YkJGqpkv+JgDqtpVwmAghEA+lKQQSsHE9dVfMg67nMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4164
Cc: brijesh.singh@amd.com, Jon.Grimm@amd.com, will@kernel.org
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

According to the AMD IOMMU spec, the commit 73db2fc595f3
("iommu/amd: Increase interrupt remapping table limit to 512 entries")
also requires the interrupt table length (IntTabLen) to be set to 9
(power of 2) in the device table mapping entry (DTE).

Fixes: 73db2fc595f3 ("iommu/amd: Increase interrupt remapping table limit to 512 entries")
Reported-by: Jerry Snitselaar <jsnitsel@redhat.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 89647700bab2..494b42a31b7a 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -257,7 +257,7 @@
 #define DTE_IRQ_REMAP_INTCTL_MASK	(0x3ULL << 60)
 #define DTE_IRQ_TABLE_LEN_MASK	(0xfULL << 1)
 #define DTE_IRQ_REMAP_INTCTL    (2ULL << 60)
-#define DTE_IRQ_TABLE_LEN       (8ULL << 1)
+#define DTE_IRQ_TABLE_LEN       (9ULL << 1)
 #define DTE_IRQ_REMAP_ENABLE    1ULL
 
 #define PAGE_MODE_NONE    0x00
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
