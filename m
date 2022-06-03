Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 958FDC433EF
	for <iommu@archiver.kernel.org>; Fri,  3 Jun 2022 11:23:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 34294404F8;
	Fri,  3 Jun 2022 11:23:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id enLMrLBJp-20; Fri,  3 Jun 2022 11:23:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0FC8240003;
	Fri,  3 Jun 2022 11:23:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DF640C0039;
	Fri,  3 Jun 2022 11:23:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 51559C002D
 for <iommu@lists.linux-foundation.org>; Fri,  3 Jun 2022 11:23:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3139C606BF
 for <iommu@lists.linux-foundation.org>; Fri,  3 Jun 2022 11:23:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iWYki6TZlOE7 for <iommu@lists.linux-foundation.org>;
 Fri,  3 Jun 2022 11:23:06 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::60e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E7BC460BCF
 for <iommu@lists.linux-foundation.org>; Fri,  3 Jun 2022 11:23:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dEM7YqKxo97hjfXMzPpiNltFLCIV0QpnYH5WoBTi6/GYbDzvLWXdD660PZsCGhmAOzkOsfhjcG7XJfJgCloxAM2sZf/1a1TXmSBU3u0NFsdQOIstq8pj51IOQrAGxwWMpzv5I/ORiASNlJ1MOt+dTWUzrWbIPwVUNIBDhfmaEbjdZsMuvTbp2IChIvPfieUErXI2rWYxfHWeqHj5q35FJRtb1icu0ncVGqJgKV2T42N4Cu9+DG6UUiQF6bQDh88RjEd0dYxZgjJiTmQ6FflVY39yVRtasRgUxJvssBRtMFN01/IFMkjoqLCE5HCGrDff+3BZnpsSgOxOnOXJrJJKQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZaOFmnTFLjR0OqoKpKbPH5iPBKqH/KRrA7bzGQvYYYM=;
 b=WOJWY+r1X+IG7fEuOZ6swBKYWwuibGD6BZARCoAOPEKFiW7bHdYilr3e6ikN9tznvv63s7WIsiWHLi87Ury+nfIfAh2Cskdu2gcGb2oEBk/gcuvFut+gD9YyJasns4ZC1NFpMw6zvgxqOBW7tC1on2sPnSfrQY0vVRvWFr/Gx9DLuDccnmYtqdSntzxxK7awrJ3eKwRJAPpSSZ47YQF7jMw3hH/2RUYOoCEMhXG0pFCUIaQZvFHnHHQpW06dKJS9TfwEvmVIBk4PPSg59B04LAdEOybxPv/nCOjN/Qj+0KrMyUtBGLSCgfoz4NUCh3mbqOKckhe0in3yI6AZD/f6GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZaOFmnTFLjR0OqoKpKbPH5iPBKqH/KRrA7bzGQvYYYM=;
 b=G/4yrSQ+s9l6EkbV2jzHyX1uI5WqAi5oXcXO7VUM9tOV/G0jy9JHTElzW1pub/Ebz1nL3oWYet/5KX2i0H8CRka3ggt5+e+mkmuqT9yuXe6tSo2mB25xzaadSDQDFmup86vqXF8ZCArEDccBMsBNFW7AwX8SYSKsAQ0Q5t0uBq4=
Received: from DM5PR04CA0040.namprd04.prod.outlook.com (2603:10b6:3:12b::26)
 by BN6PR1201MB0083.namprd12.prod.outlook.com (2603:10b6:405:54::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Fri, 3 Jun
 2022 11:23:03 +0000
Received: from DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:12b:cafe::b4) by DM5PR04CA0040.outlook.office365.com
 (2603:10b6:3:12b::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12 via Frontend
 Transport; Fri, 3 Jun 2022 11:23:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT054.mail.protection.outlook.com (10.13.173.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Fri, 3 Jun 2022 11:23:01 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 3 Jun
 2022 06:22:59 -0500
To: <iommu@lists.linux-foundation.org>
Subject: [PATCH v1 6/7] iommu/amd: Add support for using AMD IOMMU v2 page
 table for DMA-API
Date: Fri, 3 Jun 2022 16:51:06 +0530
Message-ID: <20220603112107.8603-7-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220603112107.8603-1-vasant.hegde@amd.com>
References: <20220603112107.8603-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 184bc6c8-5ba6-4e98-cbbc-08da45536bb6
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0083:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1201MB00839C5C773CBA5AD6CDF45D87A19@BN6PR1201MB0083.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b3KerF3X0IPCADDS5d0GmSaxJk++ukrnkXClmZJLDpgNXMqd4hR4Z8TGc6Zp2XCFt+J7tgCGerfp/5R1rhYNANFfSZ/agn37JvuoBO/kyia2WUcvh5PeeKGduAYjAmTbnuNmin1D1jQRWG65Fb3+omXaqJl9eT8oWy88WKiE+k2ym+asHZ/SMOnXbNgcNoS9LR/VoJETJ5K3k+3mEKBX5VME+Ymohx0z85Bjs8UpwvNBRWua7odhFbFu6fpweZl3BqLGYNcvWIH/W4pmNsUgzMWSb+DvJJ3P3VKo7iSBoUOoaOMxQkd3EGVKeWyQfmnC38WaheFFH9t5BcuXjGnD99e4VTpZv9CL7RCuOuCj+ZbfVkvecVrPnjbvHGACEyoNB1HET4hpW/YuRcjXlfgrvBUz8SEOhbJrXTa6Y9Tfn0Dxg3Fv9KYosL6nMw2jIhUTEW3Kd0HssgBDbGfQmI3Bt3fCg0xx+PW/EuyW6ipHYPcQZx/Jx90rBFhmhIXHMaoT8VFZu0tGXpjETMqOjxxmBym7Eqpc0kThoo3Kv4aUKPPHM1bvMIyr7ZILNYrhOzF9psmXfUveuH2P09u/RFsoOEccntxJCPb034pqgz4diTYeRtXVmKAgsg/38ss/VpjJ2aR82+/cZQGH30fAcM1TAbXjbLSFfqWHKtfhdygASjjJ1rHxQgWqnflFXKxqy+MIsMG7cZk+6cwd5c3R/WZOyphx0Eus4bmi+8WPQQANlrD4Z5GkDAMbzQLoq4c+Jzeaxuca4R6qWdG6Jre0FPGjPw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(426003)(2906002)(2616005)(1076003)(8936002)(82310400005)(186003)(336012)(47076005)(16526019)(6916009)(54906003)(8676002)(316002)(70586007)(70206006)(36756003)(83380400001)(4326008)(508600001)(44832011)(5660300002)(36860700001)(356005)(81166007)(26005)(40460700003)(86362001)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2022 11:23:01.6996 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 184bc6c8-5ba6-4e98-cbbc-08da45536bb6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0083
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

Introduce init function for setting up DMA domain for DMA-API with
the IOMMU v2 page table.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index f2d939b7cc4d..e5aef845f01c 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2029,6 +2029,24 @@ static int protection_domain_init_v1(struct protection_domain *domain, int mode)
 	return 0;
 }
 
+static int protection_domain_init_v2(struct protection_domain *domain)
+{
+	spin_lock_init(&domain->lock);
+	domain->id = domain_id_alloc();
+	if (!domain->id)
+		return -ENOMEM;
+	INIT_LIST_HEAD(&domain->dev_list);
+
+	domain->flags |= PD_GIOV_MASK;
+
+	if (domain_enable_v2(domain, 1, false)) {
+		domain_id_free(domain->id);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
 static struct protection_domain *protection_domain_alloc(unsigned int type)
 {
 	struct io_pgtable_ops *pgtbl_ops;
@@ -2056,6 +2074,9 @@ static struct protection_domain *protection_domain_alloc(unsigned int type)
 	case AMD_IOMMU_V1:
 		ret = protection_domain_init_v1(domain, mode);
 		break;
+	case AMD_IOMMU_V2:
+		ret = protection_domain_init_v2(domain);
+		break;
 	default:
 		ret = -EINVAL;
 	}
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
