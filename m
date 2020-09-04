Return-Path: <SRS0=R2i3=CO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0863BC433E2
	for <iommu@archiver.kernel.org>; Sat,  5 Sep 2020 21:24:02 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 381112074B
	for <iommu@archiver.kernel.org>; Sat,  5 Sep 2020 21:24:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="DOsKuNXi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 381112074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E59068691A;
	Sat,  5 Sep 2020 21:24:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fg6tYWrl7l8L; Sat,  5 Sep 2020 21:24:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 50B2F85FA3;
	Sat,  5 Sep 2020 21:24:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 357ABC07FF;
	Sat,  5 Sep 2020 21:24:00 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F1D55C0051
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 16:39:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id D2DDC2E0F8
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 16:39:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MaMM3qbClzay for <iommu@lists.linux-foundation.org>;
 Fri,  4 Sep 2020 16:39:45 +0000 (UTC)
X-Greylist: delayed 05:58:36 by SQLgrey-1.7.6
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2061.outbound.protection.outlook.com [40.107.236.61])
 by silver.osuosl.org (Postfix) with ESMTPS id 3D6DA1FEBF
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 16:39:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vta7GGS0R99+pIauok2g0x/BqJVIb2ILXnum4R7/hoj8Ve1ytC8IeRsLzNWhR0698iCJ1HXyOH+oujObO41TmdEMC0qnJhEMQsqgLcxRlcdEI2jzvycwjkuD29tXi8EhUTY/JSAOUpcNuY+jLkQGueWVqap/IgmIIzkmLysFMVAv8X8+poYfsGNUsgdCEySNT6LqJrnh9slzJASnMy21bamNDvuBG53dZa2jTEdIA4IZlLk6G5odW2V8voljCao3iZuFuQAaBnZmgHvgiELoUkkK/r7AroOU+otrz6yH3TJbHXcm06XgtOZ2ZVc/GfzGnJC+o8J1QCVfmCTZ1xWpyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XNMwznDTLy1qK3EycnGQSqW9gqxzUPWoUJlW8C5we6g=;
 b=PXIizwnDJBSFeJ9kOcxhuCCDTEqAk4hV3OVTOKuI2/UzzFuZpYlEPCTKIaAGlsZa8OIyqhRUsTAyrxjepjNwCpWzVM1k0GJibB194iffnO23GVfICX/A0Oosyb1HXA7gMARgVs+sEwPQH/5/bgqZJ9cTxPk13ziwTzv63WN9CblNTiFINAEBU21itYQ11CSzLmj72ZQhFyxGJp1dqEA0vTagwnLSS/rbVtB9udqFgb83TNB50Cmwpj+RH90+U5jPRmY9haOq/bLdmLMs/sphIm/XT+6jKdJX1fFvEkrYUdbQQ8Wceex7YbejbKU3eEcsJqTiRuBWWykRYh4ysCWwjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=sina.com smtp.mailfrom=srdcmail.amd.com;
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XNMwznDTLy1qK3EycnGQSqW9gqxzUPWoUJlW8C5we6g=;
 b=DOsKuNXi+9pgqIdRu0hMMEmePSWdqjxerWcZpCJdoEWP5hAQiiDXnksnEVG0OZ6wLJvNwLURPNvUNyyHH8p7u9p2azI2MdAj2t205o2A2rNfqA/RojempyTjHLj+N/peE2VkOGafBPl5zfIbCqgF39BKP3hpYK2ny1/Ieo75v9w=
Received: from BN6PR03CA0066.namprd03.prod.outlook.com (2603:10b6:404:4c::28)
 by CY4PR12MB1591.namprd12.prod.outlook.com (2603:10b6:910:10::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.21; Fri, 4 Sep
 2020 10:08:26 +0000
Received: from BN8NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:4c:cafe::12) by BN6PR03CA0066.outlook.office365.com
 (2603:10b6:404:4c::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16 via Frontend
 Transport; Fri, 4 Sep 2020 10:08:25 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=srdcmail.amd.com; sina.com; dkim=none (message not signed)
 header.d=none;sina.com; dmarc=permerror action=none header.from=amd.com;
Received-SPF: None (protection.outlook.com: srdcmail.amd.com does not
 designate permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT027.mail.protection.outlook.com (10.13.177.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3326.19 via Frontend Transport; Fri, 4 Sep 2020 10:08:24 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 4 Sep 2020
 05:08:23 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 4 Sep 2020
 05:08:23 -0500
Received: from atlvmail01.amd.com (10.180.10.61) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Fri, 4 Sep 2020 05:08:23 -0500
Received: from srdcmail.amd.com (srdcmail.amd.com [10.237.16.23])
 by atlvmail01.amd.com (8.14.4/8.14.4) with ESMTP id 084A8Lv8031313;
 Fri, 4 Sep 2020 06:08:22 -0400
Received: from srdcws1054.amd.com (srdcws1054.amd.com [10.66.16.34])
 by srdcmail.amd.com (8.13.8/8.13.8) with ESMTP id 084A8Kft029002;
 Fri, 4 Sep 2020 18:08:20 +0800
Received: (from weisheng@localhost)
 by srdcws1054.amd.com (8.14.7/8.14.7/Submit) id 084A8KmY016606;
 Fri, 4 Sep 2020 18:08:20 +0800
From: Wesley Sheng <wesley.sheng@amd.com>
To: <joro@8bytes.org>, <iommu@lists.linux-foundation.org>,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] iommu/amd: Revise ga_tag member in struct of fields_remap
Date: Fri, 4 Sep 2020 18:07:47 +0800
Message-ID: <20200904100747.16463-2-wesley.sheng@amd.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20200904100747.16463-1-wesley.sheng@amd.com>
References: <20200904100747.16463-1-wesley.sheng@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e942553b-dcab-43e4-9eea-08d850ba7634
X-MS-TrafficTypeDiagnostic: CY4PR12MB1591:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1591980B2D41851A1472CF5EF02D0@CY4PR12MB1591.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y0Uh0UZqvQAJ32QlwoUwgp4eMAh0LDRYkVgJfXFqbIWVcqwC3tzMjnRTrVZ94iOw3CfcwXim+vN9OBBfbQtDVC1b9w3GHLm2k2fZxd0YhzvwpN8iU+jGZpKQP7iZz8t/GNTc3b8INMeozi7BJjWR6UW5BaBECEYf6QF0Ssw6cGyM3ZYsU0m4fiZj0FA/irZRViKDGBJ1JgxDDApY1UBCygTS6SkIo4CT7Z+WclNfR8ZV1QEsrtNkBbH+7ktC7oKCOBhaQkwYGC+y1zzcq0oOPnj7hVB4u/YiJUBDNbd1++ziD4C4MRR+iQ0csYP2NPNU36dxYU3B5hHwqyDMxfA0v6GKg1VB30UmfqY9Iq9ZeFAqW4s1WTfKzi8HUR/dZSAh8NxIUHJ2rId3TYlEB1wpAQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(396003)(39860400002)(46966005)(110136005)(54906003)(1076003)(316002)(2906002)(81166007)(82740400003)(6666004)(4326008)(82310400003)(336012)(4744005)(8936002)(26005)(44832011)(83380400001)(42186006)(83170400001)(356005)(70586007)(36756003)(70206006)(498600001)(5660300002)(8676002)(47076004)(426003)(2616005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2020 10:08:24.9794 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e942553b-dcab-43e4-9eea-08d850ba7634
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1591
X-Mailman-Approved-At: Sat, 05 Sep 2020 21:23:58 +0000
Cc: wesley.sheng@amd.com, wesleyshenggit@sina.com
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

Per <<AMD I/0 Virtualization Technology (IOMMU) specification>>
ga_tag member is only available when IRTE[GuestMode]=1, this field
should be reserved when IRTE[GuestMode]=0. So change the ga_tag
to rsvd_1 in struct of fields_remap.

Signed-off-by: Wesley Sheng <wesley.sheng@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index e5b05a97eb46..baa31cd2411c 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -832,7 +832,7 @@ union irte_ga_lo {
 		    /* ------ */
 		    guest_mode	: 1,
 		    destination	: 24,
-		    ga_tag	: 32;
+		    rsvd_1	: 32;
 	} fields_remap;
 
 	/* For guest vAPIC */
-- 
2.16.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
