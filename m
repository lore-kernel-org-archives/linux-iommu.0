Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31597C433EF
	for <iommu@archiver.kernel.org>; Fri,  3 Jun 2022 11:22:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E601941608;
	Fri,  3 Jun 2022 11:22:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 65MTQUxEcWML; Fri,  3 Jun 2022 11:22:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 69FC8416F1;
	Fri,  3 Jun 2022 11:22:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4434FC0039;
	Fri,  3 Jun 2022 11:22:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C929CC002D
 for <iommu@lists.linux-foundation.org>; Fri,  3 Jun 2022 11:22:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C66C860BB9
 for <iommu@lists.linux-foundation.org>; Fri,  3 Jun 2022 11:22:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PNEj4en1NFD6 for <iommu@lists.linux-foundation.org>;
 Fri,  3 Jun 2022 11:22:24 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20606.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::606])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 16783607D1
 for <iommu@lists.linux-foundation.org>; Fri,  3 Jun 2022 11:22:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fr6kFEBmEJ+NQ78qrZU9T/qxdJI6K6j1hii1N4bcdr9vd9k12Ah1Owj0FFMbq676yVbTcKa65ELGJrHX074AWURaR8C4uXGDba29/4K5b32n70IqYAfwZiNbwHmKot0v8Z4wYi+Inkg/thHBohszYngkVRiu2jTFm93rq/BSDLkwGjCN2ZDYhxItU8C3VQvQMKHcTMLrelbqWJx5K1hUGA3XEYiFCXakmyVgksoTbX7/y37WL3gZFAF7ISYCLoF954VsbFmqJA60S9Tl2qJsu1y34Xj6fI/L8yz00M+uXx+tkWPAoD43JYcajA2sNnZBVolh39EX9xOqzoiFE30b+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3+VQ2d/y2eg/s42u9o65uRMPH/VSuXzSNTd8/Er0lOY=;
 b=mUwPqXblaSuiKdOibo3HdfG5SF5lUYHr4qI106BFZiPhs5s1n2YVyIVxK9mmjIy4PGlCUoI8GDTyYIz/jctuqCRJZ1XppxCLXEsZzYbLmDOvlb+jUiYKpcAsd2hsAcRKLcpkYagMfu16yNGpk6Kj1pIcor9vizzfrEowITd8RFJjtNGxE2fc89+ZYk2+aTIWXrdG+KjPbWE5JFANHLe4iNYLTdPcQA2K/kXSwuusXwMYXhPGEOEay5Vs7OZ++q2rN0/ZCDLGJ3CqsExq8u8ygVMUyIUmaYzN7rEch4inmFiqjuuOyhFYVO2t9bFM62G0q/SBLoSrzNtI5FZlal+QUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3+VQ2d/y2eg/s42u9o65uRMPH/VSuXzSNTd8/Er0lOY=;
 b=JB1UPx7OwLsKWdeFPrjZ3zrmJVsLLmk103zfEEnbeKK06q1quSuXIgt57enUE0wgpbgqqijrSZSTuIlgfGk7oeijSKj9Ll85fXRplautxpW1x4eM3hI44AbILkNnrgiX+iHATmUrUI4hPAWQ6EOz8eUlGInTpQS1sM5SXpzDKkU=
Received: from DM5PR20CA0038.namprd20.prod.outlook.com (2603:10b6:3:13d::24)
 by DM4PR12MB5215.namprd12.prod.outlook.com (2603:10b6:5:397::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Fri, 3 Jun
 2022 11:22:17 +0000
Received: from DM6NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:13d:cafe::c2) by DM5PR20CA0038.outlook.office365.com
 (2603:10b6:3:13d::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.15 via Frontend
 Transport; Fri, 3 Jun 2022 11:22:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT058.mail.protection.outlook.com (10.13.172.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Fri, 3 Jun 2022 11:22:16 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 3 Jun
 2022 06:22:14 -0500
To: <iommu@lists.linux-foundation.org>
Subject: [PATCH v1 3/7] iommu/amd: Fix sparse warning
Date: Fri, 3 Jun 2022 16:51:03 +0530
Message-ID: <20220603112107.8603-4-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220603112107.8603-1-vasant.hegde@amd.com>
References: <20220603112107.8603-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b1b8ba8c-1ca7-4f89-bcd0-08da455350b8
X-MS-TrafficTypeDiagnostic: DM4PR12MB5215:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB52151554EA072DAE5C17725A87A19@DM4PR12MB5215.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4gbiazHGA87V8s339hi+3Y8zCibu2IgOuSgbfqb7TmDJQzjXcf1wB2jfm+k9ZN3ynxYf3qZEusWLMH/6ID9R2PkwF9EUJo5Pq8IBkQDxCEldmQDmE8ZLR4pVMU6/IFoeIhFxB76GwpgHtJLsGmtmqgo83pOPZIZ47vtTCkkkQyuf+Pie8HSzakDjdvS963Sde9ZUzFRu+vP5+vI8aF5LipvVrjlukSAxmUaQ7GQn+HMTXNNOP+4UhF/H5w+pgQEwYjwAL8m0xY5/da+JCKWVTY+c4pG2AnjldRpKsDYzhK1/gCL0XrHGpgubD6f6ov8FgdA+sQ9apsB7N7zmvQYtaAMBaexIutO7RD98WJhJKTThOgix+SWSjvzNIykIUT7JVy6EFpCqgecGVPkOOtSAsREiGsnaE/NxWGOv5tqj99H3B7/hhNqlIMUZjUeNW0HShlyVRDDlY9vQ7RnH7C9Jg5yczY4CtoentJkYIWIlziUhqHS5QXqawNh59NLvYMSb+NNbi0dsSfU326hPtctHx0E506akGIXF0LmOc8YOPfu+UOLJCESJ8a2IRvLEeZIGKsIRBfXjlnzlZtZIfqoA8g8lMY+gFiZF7i5tjML2yIzUwEMKb4nuiHN9Hh1rp26W643TTV1z9XLRY8Bb0BQvlu5FX1t62GkY8fggSmDAiMKNSR/qZ7ZgmK8ieiQ/FbaFmZfWLtlQQwze6tPMIkzR9g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(2906002)(82310400005)(83380400001)(2616005)(1076003)(336012)(426003)(47076005)(26005)(36860700001)(186003)(6666004)(16526019)(508600001)(36756003)(8936002)(316002)(6916009)(54906003)(40460700003)(86362001)(8676002)(4326008)(70586007)(70206006)(356005)(81166007)(44832011)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2022 11:22:16.4139 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1b8ba8c-1ca7-4f89-bcd0-08da455350b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5215
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

Fix below sparse warning:
  CHECK   drivers/iommu/amd/iommu.c
  drivers/iommu/amd/iommu.c:73:24: warning: symbol 'amd_iommu_ops' was not declared. Should it be static?

Also we are going to introduce v2 page table which has different
pgsize_bitmaps. Hence remove 'const' qualifier.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/init.c  | 2 +-
 drivers/iommu/amd/iommu.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 8483d98a1775..453afce7d478 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -96,7 +96,7 @@
  * out of it.
  */
 
-extern const struct iommu_ops amd_iommu_ops;
+extern struct iommu_ops amd_iommu_ops;
 
 /*
  * structure describing one IOMMU in the ACPI table. Typically followed by one
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index b558e8c30613..deb546266d42 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -70,7 +70,7 @@ LIST_HEAD(acpihid_map);
  * Domain for untranslated devices - only allocated
  * if iommu=pt passed on kernel cmd line.
  */
-const struct iommu_ops amd_iommu_ops;
+struct iommu_ops amd_iommu_ops;
 
 static ATOMIC_NOTIFIER_HEAD(ppr_notifier);
 int amd_iommu_max_glx_val = -1;
@@ -2374,7 +2374,7 @@ static int amd_iommu_def_domain_type(struct device *dev)
 	return 0;
 }
 
-const struct iommu_ops amd_iommu_ops = {
+struct iommu_ops amd_iommu_ops = {
 	.capable = amd_iommu_capable,
 	.domain_alloc = amd_iommu_domain_alloc,
 	.probe_device = amd_iommu_probe_device,
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
