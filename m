Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CA7DC433EF
	for <iommu@archiver.kernel.org>; Fri,  3 Jun 2022 11:23:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BB36341750;
	Fri,  3 Jun 2022 11:23:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bwa9b-eyUKiW; Fri,  3 Jun 2022 11:23:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 49D3B41608;
	Fri,  3 Jun 2022 11:23:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1EB89C0039;
	Fri,  3 Jun 2022 11:23:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 24636C002D
 for <iommu@lists.linux-foundation.org>; Fri,  3 Jun 2022 11:23:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 20F8041712
 for <iommu@lists.linux-foundation.org>; Fri,  3 Jun 2022 11:23:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3ebJbuc04GkQ for <iommu@lists.linux-foundation.org>;
 Fri,  3 Jun 2022 11:23:26 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on20616.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::616])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F257F41608
 for <iommu@lists.linux-foundation.org>; Fri,  3 Jun 2022 11:23:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nebft5QZsN2AFhRi0JOfn7ABGuWbPM7kuh9EDQ57iwpfaDxMLmT0r92CDnX4k7sQRehV1LweNsB6Fj3SuKF6nAXWC1iogIbq5q9UA9A3kO+BvgWA635avHJR3JU66ZfAEY++/b8UrrfJxA2dObuT9qo14EuthQNv3vR0GYj9O8f3cwruFQDwuDdKbbQDmjcG2ROALPoeYMFG7EELj7aBm85OzxHSKTrq5RpA9OA6PaCWIwyt85mAEIloal1Ct9y9vlKLfugXxpVWCWsj0iW3clval8xb/ZZkk5A74mpR7sL8lw8VdKRfJFdo3HHNKY0mMJ1i0783sNtnnQXmnVqauQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QRhvP+cJy8Fz5sn62yQBbjjQtoVOnLkvr+/YPe9MLUg=;
 b=eDBQSs8Wci5HqLbnXnzYddWlQwQPwdFTQ34PunNlOsYpkdZXc4wcDJIOacWrLZc9/2muQenZ1zK4YPKVRAHU6aJ/+CzqAkfa3oGCiU6ij1Gkx7rxre+OPK2Tjfcr2g/3CsznNyj9q7oW82EIrWekpis+PIIXTkhl2gkyrtjVuNDrqsrPFof8N/goMERI2O0xS81oQEYnbykmeIvSolx7SpLOmsLI1q4oWMxJAlMfwZNHhIK202c+kmWvsayjqqHRONIy+y28+EtZVDl/man18DlaDuC6qj+wX2gVyVEQhprm8uK8LMJZYTtSNvjUzhDfTm89v/0mmvsMh+bdSKX9LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QRhvP+cJy8Fz5sn62yQBbjjQtoVOnLkvr+/YPe9MLUg=;
 b=eSXoenWS98kEQU8LNUHsHRE636TWMwQo8z+FDMg0zdpUdr3H44dCjtaUp1GZSXhu1GB6Qn7dJ1aFwQXEjQrfGnPOWgUEvhgsHiIWNFAhiUDU039EMNssQKyO+3tgOf5PPF6O/hdRTrdYoHYMBpBmgoKXK4XDi1ykAYgu6QjzDKE=
Received: from DM3PR12CA0076.namprd12.prod.outlook.com (2603:10b6:0:57::20) by
 CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.12; Fri, 3 Jun 2022 11:23:17 +0000
Received: from DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:57:cafe::f9) by DM3PR12CA0076.outlook.office365.com
 (2603:10b6:0:57::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12 via Frontend
 Transport; Fri, 3 Jun 2022 11:23:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT034.mail.protection.outlook.com (10.13.173.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Fri, 3 Jun 2022 11:23:16 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 3 Jun
 2022 06:23:14 -0500
To: <iommu@lists.linux-foundation.org>
Subject: [PATCH v1 7/7] iommu/amd: Introduce amd_iommu_pgtable command-line
 option
Date: Fri, 3 Jun 2022 16:51:07 +0530
Message-ID: <20220603112107.8603-8-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220603112107.8603-1-vasant.hegde@amd.com>
References: <20220603112107.8603-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 408a9770-dad5-4f0a-c17f-08da455374b7
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_
X-Microsoft-Antispam-PRVS: <CO6PR12MB5427ADF328021EFF1632B92587A19@CO6PR12MB5427.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j+si9vKxT1YMX/bJBVuxPSPDa573OtTz58PAAR4yV1fLQ7vxb7x9jmhpBrjNEawE2wIF234pXDXM4A8dZwfjdHtT0J6ENagAeJ+vawMHbG3+cnmRaovnlNPCNzd/9ppI+/q9UWzkjtS45U6PbGDhOb7hOoo3Ca5fxOUx7x36JVB7tHqXLZxgbKF8a5Jd8tMpI59nfp2U1Hg6boJufBOKlXHuFKJQcr+6DDZ850e1eb+NZwow1RuzJ4kXguL69AFfllzk/5mswxvedOobbLGGWG779Q2hRNpRW5uXOsK+suI4/ISkYv53eZlZzgnClyWkJVYP6S6dpOeIoCSVnQWCsGg3xLteVMWb6Ni7KIFeTLyiY/76g4zPclFz/oa9R6E+Mu5S3EY1AIh4nMOpP9rtdhcBrgBeTjbNwofQs8w/+CDASTJRGfagu+s7v81aPBhXQG76k2zEggr/3OCA5ZsseaocsBJQoyF0v4CIHl+p+nfr+CIx9QAYPQiQjxsvQr0yXx7mCp54NHKrkFRl0zyTN29EI3rtYDjIudvgHoBlXLzP+EFbqq+BuiTl+HTI0m4d0zLPsXKZaO2yglH+SAtJpbdTkAEZbDFJnV9suVd9LbLf6/zSeVPr8Q1exoTo44jTuVp+c47HXYAPPmCZikElhsN27tigAOvYneBdqlYpH2/8j7Sph8NwiYhzfKTCF/dx3PIpkqVDE0KZXOgNWbxt9Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(26005)(316002)(2906002)(356005)(508600001)(82310400005)(1076003)(5660300002)(83380400001)(16526019)(8936002)(186003)(40460700003)(81166007)(6916009)(54906003)(47076005)(2616005)(336012)(426003)(44832011)(36756003)(86362001)(8676002)(6666004)(36860700001)(4326008)(70586007)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2022 11:23:16.7898 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 408a9770-dad5-4f0a-c17f-08da455374b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5427
Cc: Vasant Hegde <vasant.hegde@amd.com>
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
From: Vasant Hegde via iommu <iommu@lists.linux-foundation.org>
Reply-To: Vasant Hegde <vasant.hegde@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

To allow specification whether to use v1 or v2 IOMMU pagetable for
DMA remapping when calling kernel DMA-API.

Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  6 ++++++
 drivers/iommu/amd/init.c                        | 17 +++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index cc8f0c82ff55..d912c4c8b610 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -337,6 +337,12 @@
 			             This mode requires kvm-amd.avic=1.
 			             (Default when IOMMU HW support is present.)
 
+	amd_iommu_pgtable= [HW,X86-64]
+			Specifies one of the following AMD IOMMU page table to
+			be used for DMA remapping for DMA-API:
+			v1         - Use v1 page table (Default)
+			v2         - Use v2 page table
+
 	amijoy.map=	[HW,JOY] Amiga joystick support
 			Map of devices attached to JOY0DAT and JOY1DAT
 			Format: <a>,<b>
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index d4d9c812305d..3fae018f62d8 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -3264,6 +3264,22 @@ static int __init parse_amd_iommu_dump(char *str)
 	return 1;
 }
 
+static int __init parse_amd_iommu_pgtable(char *str)
+{
+	for (; *str; ++str) {
+		if (strncmp(str, "v1", 2) == 0) {
+			amd_iommu_pgtable = AMD_IOMMU_V1;
+			amd_iommu_ops.pgsize_bitmap = AMD_IOMMU_PGSIZES;
+			break;
+		} else if (strncmp(str, "v2", 2) == 0) {
+			amd_iommu_pgtable = AMD_IOMMU_V2;
+			amd_iommu_ops.pgsize_bitmap = AMD_IOMMU_PGSIZES_V2;
+			break;
+		}
+	}
+	return 1;
+}
+
 static int __init parse_amd_iommu_intr(char *str)
 {
 	for (; *str; ++str) {
@@ -3397,6 +3413,7 @@ static int __init parse_ivrs_acpihid(char *str)
 
 __setup("amd_iommu_dump",	parse_amd_iommu_dump);
 __setup("amd_iommu=",		parse_amd_iommu_options);
+__setup("amd_iommu_pgtable=",	parse_amd_iommu_pgtable);
 __setup("amd_iommu_intr=",	parse_amd_iommu_intr);
 __setup("ivrs_ioapic",		parse_ivrs_ioapic);
 __setup("ivrs_hpet",		parse_ivrs_hpet);
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
