Return-Path: <SRS0=R2i3=CO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 286EFC43461
	for <iommu@archiver.kernel.org>; Sat,  5 Sep 2020 21:24:02 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 877DE20760
	for <iommu@archiver.kernel.org>; Sat,  5 Sep 2020 21:24:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="hp4DOEK+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 877DE20760
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2A103868C4;
	Sat,  5 Sep 2020 21:24:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KYYEgLi7D7Bm; Sat,  5 Sep 2020 21:24:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1BFF2867BC;
	Sat,  5 Sep 2020 21:24:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EE977C07FF;
	Sat,  5 Sep 2020 21:23:59 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AB098C0051
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 10:40:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 81DF1203F8
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 10:40:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MeFzSGACT9+N for <iommu@lists.linux-foundation.org>;
 Fri,  4 Sep 2020 10:40:38 +0000 (UTC)
X-Greylist: delayed 00:16:51 by SQLgrey-1.7.6
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
 by silver.osuosl.org (Postfix) with ESMTPS id ADA3C20381
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 10:40:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gipVP1SaXcuejjd99xg4+Dhlma80F2ABpU3KLN9kFjnN+Ale13cZSRjZcA2dimnof7+MJM6JyJlR6XPsB8IgQ2wGoRUSoMj9BKItl7jBjA39W0z2zv24+UdiOs3+IQKfTXyRpewBn+761xGdYofyvyDK7WaKNazbWfhvA6Wjee7ofheeOzu55ObG+yVVqDzTKjRhUkkyquaKyWG/mL9H+4gLS7GEBLkRLc2tp3NdGi+ipPCyE8qu08NMya6oRSRdRaVyc6nPpnPwq2C/pLNsc3AyjygIgWNNTeumPbwJDivB9lbmMTtPHlEQPRfGzPBTNgfoKgEB9pULM9QMPPwp+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6iyxn26Xq3Y4vv0uJJfTTzr61YocgAxwtGnO5tcObrY=;
 b=RQ6k9MSZMR9gEzA/8Akz9Pl1CK1uv+xlLFk/PEE2rB/YQ1tI75MEwZ1glMFt3EYorjOTAqtcraNs7vpd8LXKwWVIVnlfmYfTGx7A+3K4FsuUyud1gu8rrxIJGhZvy8UTlEKRPSI+YPFUyYy5oN1sRtwJSr8Szh9XG145xCGutdAlPgMsoQTnUIAaBjSheygcVvWfLhCn3uOK7ysNBbiY3iJoTjqjzDskgs1QN83v/pw3eofkGDyvrCiD0bGd6tBDak8fGPoYwWuoF9xNoti18IWxcnVpeiFgFJ3mzkumluymMPw5XgPbLC8R0giPYhk1cKQCxWLXPgyvqvwko1/mvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=sina.com smtp.mailfrom=srdcmail.amd.com;
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6iyxn26Xq3Y4vv0uJJfTTzr61YocgAxwtGnO5tcObrY=;
 b=hp4DOEK+TVfamIbYem4AyljgDmeDPKrMVM75S/+JSxJ8dGSRIO4CmB9uUAlsO76SK8JOOY0eIMzS+d18EtrJMDSBMtzv/a6crdu03tdJGJC+PWcQzVF4A7Auutm57kO7k56MWMuIu1/w2dFRfyf68bnpL3wNAcwgte3WdkL3deU=
Received: from BN6PR22CA0065.namprd22.prod.outlook.com (2603:10b6:404:ca::27)
 by MN2PR12MB3869.namprd12.prod.outlook.com (2603:10b6:208:16f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Fri, 4 Sep
 2020 10:08:32 +0000
Received: from BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:ca:cafe::83) by BN6PR22CA0065.outlook.office365.com
 (2603:10b6:404:ca::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16 via Frontend
 Transport; Fri, 4 Sep 2020 10:08:32 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=srdcmail.amd.com; sina.com; dkim=none (message not signed)
 header.d=none;sina.com; dmarc=permerror action=none header.from=amd.com;
Received-SPF: None (protection.outlook.com: srdcmail.amd.com does not
 designate permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT031.mail.protection.outlook.com (10.13.177.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3326.19 via Frontend Transport; Fri, 4 Sep 2020 10:08:31 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 4 Sep 2020
 05:08:30 -0500
Received: from atlvmail01.amd.com (10.180.10.61) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Fri, 4 Sep 2020 05:08:30 -0500
Received: from srdcmail.amd.com (srdcmail.amd.com [10.237.16.23])
 by atlvmail01.amd.com (8.14.4/8.14.4) with ESMTP id 084A8TuD031360;
 Fri, 4 Sep 2020 06:08:30 -0400
Received: from srdcws1054.amd.com (srdcws1054.amd.com [10.66.16.34])
 by srdcmail.amd.com (8.13.8/8.13.8) with ESMTP id 084A87Rw028993;
 Fri, 4 Sep 2020 18:08:07 +0800
Received: (from weisheng@localhost)
 by srdcws1054.amd.com (8.14.7/8.14.7/Submit) id 084A86Dj016593;
 Fri, 4 Sep 2020 18:08:06 +0800
From: Wesley Sheng <wesley.sheng@amd.com>
To: <joro@8bytes.org>, <iommu@lists.linux-foundation.org>,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] iommu/amd: Unify reserved member naming convention in
 struct
Date: Fri, 4 Sep 2020 18:07:46 +0800
Message-ID: <20200904100747.16463-1-wesley.sheng@amd.com>
X-Mailer: git-send-email 2.16.2
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e584953-5fa2-400e-7c80-08d850ba79d2
X-MS-TrafficTypeDiagnostic: MN2PR12MB3869:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3869E0159BAF4CC16BD7E810F02D0@MN2PR12MB3869.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1107;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OnvS8NLElfVBdxK6NV39tLji5Q7cdbUyCqCi3zKaTx/0DRZPf7HTekfYrjtHRCu80PegAVk2ZVXPve/yJMqZvSlsSMb6X9ACR4bWJW5zSiZ8YHM/SFS8NUk4UOIZk8K889h9eqp2P0XKOwBC28k7e6gv4b4nWZGtfFDTrfTfDZKKOrJOX/+sHLWBqGmb7zlvDozLMwbpFabJMFWJ9iLTw9ZcgH5oWf7SjlZXx2y97ZojFz5JJ6py8+gCuIO96Gq+DEgbotMAPP4UOS4jv+2AAP4WzfY8g/7smT8IXgeFGCA1/sNjzHugU+aQf1pxLRiMfFjL8SxVInRnVrtW7FX69CeZNod/T+Jp9TfrfFoOj5/sy9Ih3g0iMO2ADnwL5RAcCs3HW0EkVoa8jX2ogqWkzQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(136003)(346002)(39860400002)(376002)(46966005)(8936002)(2906002)(8676002)(54906003)(82310400003)(110136005)(6666004)(42186006)(4326008)(336012)(1076003)(4744005)(26005)(498600001)(2616005)(44832011)(426003)(5660300002)(70586007)(356005)(83380400001)(316002)(70206006)(36756003)(47076004)(82740400003)(83170400001)(81166007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2020 10:08:31.0472 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e584953-5fa2-400e-7c80-08d850ba79d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3869
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

Unify reserved member naming convention to rsvd_x in struct

Signed-off-by: Wesley Sheng <wesley.sheng@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 30a5d412255a..e5b05a97eb46 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -841,7 +841,7 @@ union irte_ga_lo {
 		    no_fault	: 1,
 		    /* ------ */
 		    ga_log_intr	: 1,
-		    rsvd1	: 3,
+		    rsvd_1	: 3,
 		    is_run	: 1,
 		    /* ------ */
 		    guest_mode	: 1,
-- 
2.16.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
