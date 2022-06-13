Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D6AEC43334
	for <iommu@archiver.kernel.org>; Mon, 13 Jun 2022 01:25:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 495C782E29;
	Mon, 13 Jun 2022 01:25:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WSVR8SK9U6LA; Mon, 13 Jun 2022 01:25:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3801283122;
	Mon, 13 Jun 2022 01:25:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 152DFC0039;
	Mon, 13 Jun 2022 01:25:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7A410C002D
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jun 2022 01:25:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4E4B660E9C
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jun 2022 01:25:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dl_auaPipdUr for <iommu@lists.linux-foundation.org>;
 Mon, 13 Jun 2022 01:25:38 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20619.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::619])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9ED2160B56
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jun 2022 01:25:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c7DqqvMG2RaI6dx6uSW1InDp9kw2LYRhkCpHHBl3IrtnyZWGLrcxKNePX1K0raWLeN1vQ5iRVeCmMhtjyzyTxBjGDyyjCeMLAMd3v7cT1V4Hx8P6MYcASh02aKWofKONVQWpfMDhaO9j2qwg4Ndj9NLbPxF51NaXNoP/zPMPpR8tAVEQSJyWKhJ2hPYupnORCqWeN3FXttK/aRHGsXuuYz5Du08KB8INRexlKviBBQChrWre5ycklUknaTj7fkv0OCcZACsh3fYg9MKYXprNZ0wzrKCWMWTlvKXWTtOda4X1/1RgpzHCS4dBnUIyF9fB8Bcw3M3NzlcfZWsnxVreJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T1WwV1A5OPmAs77DVMmjVGwT6HwWPgdwMUAT35d8CCw=;
 b=atVYjPcjHPb0haJMjtwxuZYaJkZ7sRVI/MdjX8pgXhAbhPgMxq5pMMxUSYiNYxTi57RbkAlRfxYuq948+Doewk7hzsNIalAlgd7CVyVQlaleb/kBc+lrwVqouKJRh5vq+GAQEqdaQ8wyqbFk8mZnkKzxlbuWepdS2FN6zUosEZ1ZnhN48xaIIylVhzqZ5dgPpL7KVkViZlr2W1MYEbj4DupPda33bkA0KOI4d4jsOGwq1Ix8L/U4pgmXJS2LFoMuDDa+7GLlMpebkQEHoxwCl/aGnkLbP6lN6Mc4N+fhDgTD1xAVbKwGJqNu7YK2O2EO81m7vXRVBnyAYxQ7UdcfKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T1WwV1A5OPmAs77DVMmjVGwT6HwWPgdwMUAT35d8CCw=;
 b=frf8I31bMotYZGLdljDp7rGNZ6jWsWamE8Z1Rcidr7drZG50qM/6aL1pTqU3XlkjDMd/rk2OKlGrKghFWRSF7M6d/1prLWYMRr7p0OT2s1R9LSxusZ/4XvCHMsYBtUWCCSkQ9iYqu8wt7OGELStnF9rdRuTMNlDx4ssKjXXmGmk=
Received: from CO2PR04CA0060.namprd04.prod.outlook.com (2603:10b6:102:1::28)
 by MWHPR1201MB2510.namprd12.prod.outlook.com (2603:10b6:300:e8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.15; Mon, 13 Jun
 2022 01:25:32 +0000
Received: from CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:102:1:cafe::2d) by CO2PR04CA0060.outlook.office365.com
 (2603:10b6:102:1::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13 via Frontend
 Transport; Mon, 13 Jun 2022 01:25:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT028.mail.protection.outlook.com (10.13.175.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Mon, 13 Jun 2022 01:25:31 +0000
Received: from sp5-759chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Sun, 12 Jun
 2022 20:25:22 -0500
To: <iommu@lists.linux-foundation.org>
Subject: [PATCH 6/7] iommu/amd: Do not support IOMMU_DOMAIN_IDENTITY when SNP
 is enabled
Date: Sun, 12 Jun 2022 20:25:01 -0500
Message-ID: <20220613012502.109918-7-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220613012502.109918-1-suravee.suthikulpanit@amd.com>
References: <20220613012502.109918-1-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d1cdab81-859a-44e2-736f-08da4cdb9ba3
X-MS-TrafficTypeDiagnostic: MWHPR1201MB2510:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB25105A75F76CAF896231E37EF3AB9@MWHPR1201MB2510.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qF7tI4+6LIfwOt95nDFwMBNxUZp9C6T7NFv+pANdZXxhW5bWJugOReB2JBFdiXxNVbnJ1PBpmRBBSH3P0U862gsCmcqu2I3Tf/CmXgZJvZR9v1RtzH026LmI1qoo01QpRsQZPMmqY/OJ88fVeJIEPRV9vHDwH5Di3HyJfqrRIZadMU/euRfxTFn7OGvUSyXOb823nsjAFuaB/oZ5vKIfXn/tOfZJH+Lw1edUdfX5qRrfeaBy9XCRCxxOi1Nq+VfLe2ZlHeiqM0graDJ7SpbC6BWPu0DzUc92Q4GTKbiv+RG7dmufyNM6V1pb2SmDT1IrgoDg/ejoBpLdlRkf7xeWJx3/Nh01vZpysUKKxZ3FbR5Qqps48doV4eBGJJrW9b5E2Xc0d17fWGVkA9lECqlY5j6D1OmRJZORBOcnvBkrAFIKuGOt6P+HeHszNXeCYCEV5S3sruHMyuZskz1kq1rgiWhb5mZ7ovdI7YyDOkoUJ30+kxwC6/bY/LyvWjUkcBFZk/kVhxFUME6coUncYAnMTC7zBT8CByfPfRskvq7SWrx+ii2nohrMIKTdszjcJHEwm4uglwKoj8RT38doPsk2+pNLzliVfNRl6dHjC3eIkUBesJAHfvEu4ZCDUmgoorQISxxLtyXZZ0IaTejciDnhiRDPCkqECOsKgAZ94mfIC6icNmndLUQU8Oejf/XhH0Dk2tx/cVKhiCtF83YDoqAkQg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(40470700004)(46966006)(36840700001)(81166007)(508600001)(70586007)(8676002)(356005)(86362001)(70206006)(316002)(6916009)(54906003)(26005)(36860700001)(16526019)(186003)(2616005)(1076003)(4326008)(47076005)(336012)(7696005)(6666004)(40460700003)(426003)(5660300002)(83380400001)(36756003)(82310400005)(2906002)(44832011)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2022 01:25:31.7200 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1cdab81-859a-44e2-736f-08da4cdb9ba3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2510
Cc: robin.murphy@arm.com, ashish.kalra@amd.com, vasant.hegde@amd.com
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
From: Suravee Suthikulpanit via iommu <iommu@lists.linux-foundation.org>
Reply-To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Since DTE[Mode]=0 is prohibited on system, which enables SNP,
the passthrough domain (IOMMU_DOMAIN_IDENTITY) is not support.
Instead, only support IOMMU_DOMAIN_DMA[_FQ] domains.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/iommu.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index ca4647f04382..ecde9e08102d 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2379,6 +2379,17 @@ static int amd_iommu_def_domain_type(struct device *dev)
 	return 0;
 }
 
+static bool amd_iommu_domain_type_supported(struct device *dev, int type)
+{
+	/*
+	 * Since DTE[Mode]=0 is prohibited on SNP-enabled system,
+	 * default to use IOMMU_DOMAIN_DMA[_FQ].
+	 */
+	if (amd_iommu_snp_en && (type == IOMMU_DOMAIN_IDENTITY))
+		return false;
+	return true;
+}
+
 struct iommu_ops amd_iommu_ops = {
 	.capable = amd_iommu_capable,
 	.domain_alloc = amd_iommu_domain_alloc,
@@ -2391,6 +2402,7 @@ struct iommu_ops amd_iommu_ops = {
 	.is_attach_deferred = amd_iommu_is_attach_deferred,
 	.pgsize_bitmap	= AMD_IOMMU_PGSIZES,
 	.def_domain_type = amd_iommu_def_domain_type,
+	.domain_type_supported = amd_iommu_domain_type_supported,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= amd_iommu_attach_device,
 		.detach_dev	= amd_iommu_detach_device,
-- 
2.32.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
