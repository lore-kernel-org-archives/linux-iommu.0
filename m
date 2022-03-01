Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBA65C433EF
	for <iommu@archiver.kernel.org>; Tue,  1 Mar 2022 08:57:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 88C8D404B7;
	Tue,  1 Mar 2022 08:57:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id b_PG2fm5yRfB; Tue,  1 Mar 2022 08:57:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0C713400F6;
	Tue,  1 Mar 2022 08:57:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D9D63C0033;
	Tue,  1 Mar 2022 08:57:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DB01CC001A
 for <iommu@lists.linux-foundation.org>; Tue,  1 Mar 2022 08:57:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C956760DC6
 for <iommu@lists.linux-foundation.org>; Tue,  1 Mar 2022 08:57:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8Zbry4SjsEJf for <iommu@lists.linux-foundation.org>;
 Tue,  1 Mar 2022 08:57:50 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2062d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8b::62d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2C72660C1E
 for <iommu@lists.linux-foundation.org>; Tue,  1 Mar 2022 08:57:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eR91YhRtGTNErirJJEHAiwo1PdDcewPQNeXD/2lTeaJoieNh7cT312QUOyPMckcKwe3r1wlzmq8XwF4XqswKo/KtW5E3mkWOzxvMXFYWRiP/SvLmciRzarkkjtt3GKtEgS+/VkN+r2omwiINE6wDfwXD1Adwmr6HuPxxm6UmVuwB0M6Z2/+ZtF5ApR/9EJQLE32gb57LWxM5JJJzvvO59XGVB9N1rWph0pheTkkd5qn1MqUOSWmb5NjZwRvYCS1NeQGshsTqwajXn43p26SMEh3B3zLYkKi7DQBEycanrilrltUk5MqWAdzw7kHWtEX6uoN7bJs5E/qIcy8HkPP7UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Rf9lpMFquW3nbFbNQKQAmpmYWx7fF1nWE+HoVg9sMY=;
 b=S/bEJFQ2feZV7apkZbH6T3U+gHyEgQZ9+VGAgDdHtViWm7wp3PUZqepD648vXKj6+MO/x4Lmo2QrXUlIvfdh1pAlFKanzQSPN1Nxzj3EsG+/bLJEOkpuTmI2y2dVODKa1jrPRlPbH7LcZ1b+kUASM7kKo/aZBLMi5VgLP0b5AzAgzAohK0WhhHtYbOSvb3//7bvtydo1Rc0nH3AQG4kui94pj0pR5H8D7/ncF/dd8g0krEIo3twtEq2PY4zt7mIboREaCJvGLQJzJLVVnIt8Lp0Y3llptEERlNp20V5LrUVrXC8zG3732htsfUFYLlvFFHftz5TDaDaDOl0XzoTbEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Rf9lpMFquW3nbFbNQKQAmpmYWx7fF1nWE+HoVg9sMY=;
 b=nw+ZYxPOndS+nkbMeQqAAQuUgtx6Ml8XHGoe+TvVpL1LRRWpLLxbW6B961Vt9DXCj6fJBDh0prVNTPDoANQOj2rvpIz1e454F05ax8n2mlNlHZwKM6mFgzqtTz+4R20FXpj6C+ttXIpSyMnVlkT5kYtnj7w9NgcOF8TLcgmzrlw=
Received: from MW3PR05CA0007.namprd05.prod.outlook.com (2603:10b6:303:2b::12)
 by CY4PR12MB1862.namprd12.prod.outlook.com (2603:10b6:903:121::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Tue, 1 Mar
 2022 08:57:47 +0000
Received: from CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::72) by MW3PR05CA0007.outlook.office365.com
 (2603:10b6:303:2b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.9 via Frontend
 Transport; Tue, 1 Mar 2022 08:57:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT044.mail.protection.outlook.com (10.13.175.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Tue, 1 Mar 2022 08:57:46 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 1 Mar
 2022 02:57:37 -0600
To: <joro@8bytes.org>, <iommu@lists.linux-foundation.org>
Subject: [PATCH v2 3/5] iommu/amd: Clean up function declarations
Date: Tue, 1 Mar 2022 14:26:24 +0530
Message-ID: <20220301085626.87680-4-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220301085626.87680-1-vasant.hegde@amd.com>
References: <20220301085626.87680-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f498dd03-f102-47a4-f335-08d9fb618e8d
X-MS-TrafficTypeDiagnostic: CY4PR12MB1862:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB18621DD3D84E4C494688B35387029@CY4PR12MB1862.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NN/fF3Tlv4J/61Bh796ucd6h97kxsMWH9qFk+96XAu3g9FSkk19507RfJvQmcwtqbheWOo+jZ/1Jr6bptwSnI1ZCCxHI8IPkM1hmQDugEaKaabZbD9MeovGDDJsaccr7hiUXMO2xE5mbIsbSQ5GBO2jDAG3Eqs4tHAWSKRKKQcDPiQ0GWp5hTqAkoUnE881G8aZEGI3GEhu7BDCkWLSVmEHjC73WnElkG9C/sQRiqgLZpGgAI/KmZfAgr/cCtvfopaxokiOAuK/vb/4QGXEvJI70WnVh0C2YejY9NSZEBXoRDeDfq7VdT7jxLke0r7OgB+zK5jpFNCxXEtXcwHFwGoTaAZhye6Vhv7ruzC2URbogkOHCtUyE+SFe3GL53rjnfpJnKcKoNwsXLcInRSQz6lKdbhMqhCuvrlM1GXDRGJQoTv0O0vbmMse9hsAKmAnmY2PgXXaWxCz+Jh5NaBtisugbM5zb82TMORmkwlprjbKAwtKZ7IZq4JB9LP2qULWVaWb+IApOjoDXVEdGTtoANFp/+ni2VXNOb/hSJZ819wdgUcGS9jlgSabPGWWYDZy4XuW4pFPVJWr5pE59J2+6dsDVyvzD9UBrHI55q5ExslT3TJmyrf48HvI56PVjGEqlne1Pk3Fqb+WXuKaGHlYAQZUJenMm8TQtOyAPjM4YzYMEjUAh147X09qLjeqgRTVzjWMk+4Ts/XgftFpihiyweQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(336012)(70586007)(316002)(426003)(186003)(36756003)(110136005)(54906003)(70206006)(2906002)(82310400004)(2616005)(36860700001)(16526019)(1076003)(40460700003)(83380400001)(26005)(86362001)(508600001)(47076005)(44832011)(8936002)(5660300002)(356005)(6666004)(81166007)(8676002)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2022 08:57:46.9671 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f498dd03-f102-47a4-f335-08d9fb618e8d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1862
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

Remove unused declarations and add static keyword as needed.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu.h | 4 ----
 drivers/iommu/amd/init.c      | 2 +-
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 416815a525d6..94d33626d692 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -14,10 +14,6 @@
 extern irqreturn_t amd_iommu_int_thread(int irq, void *data);
 extern irqreturn_t amd_iommu_int_handler(int irq, void *data);
 extern void amd_iommu_apply_erratum_63(u16 devid);
-extern void amd_iommu_reset_cmd_buffer(struct amd_iommu *iommu);
-extern int amd_iommu_init_devices(void);
-extern void amd_iommu_uninit_devices(void);
-extern void amd_iommu_init_notifier(void);
 extern int amd_iommu_init_api(void);
 
 #ifdef CONFIG_AMD_IOMMU_DEBUGFS
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index f7e7d208063c..07d6dd302989 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -661,7 +661,7 @@ static int __init alloc_command_buffer(struct amd_iommu *iommu)
  * This function resets the command buffer if the IOMMU stopped fetching
  * commands from it.
  */
-void amd_iommu_reset_cmd_buffer(struct amd_iommu *iommu)
+static void amd_iommu_reset_cmd_buffer(struct amd_iommu *iommu)
 {
 	iommu_feature_disable(iommu, CONTROL_CMDBUF_EN);
 
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
