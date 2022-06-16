Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92A9ECCA479
	for <iommu@archiver.kernel.org>; Thu, 16 Jun 2022 01:56:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 48DEF41A26;
	Thu, 16 Jun 2022 01:56:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZGXTv7zx8uGt; Thu, 16 Jun 2022 01:56:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id DD9D841A1F;
	Thu, 16 Jun 2022 01:56:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 81DDEC0082;
	Thu, 16 Jun 2022 01:56:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 990CBC002D
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jun 2022 01:56:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9649B40C35
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jun 2022 01:56:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RvXXIn_QT4DJ for <iommu@lists.linux-foundation.org>;
 Thu, 16 Jun 2022 01:56:29 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::60d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D3EDE4031D
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jun 2022 01:56:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lX73NMD5lJc1a8hzxdZhhXAFodZRpCPcnUTN5jhtuh1Y7SnIQ0rfjLsnqYbrANVz4DD6jq9piatWs4AiGeLF4kPSycKHxioV4htgPJ6Ude4XVepplvYuM3ELC9eAqHFDtiIvS9CwaUbIM89vp3X/ODCaxdZnGs4LbSwxV6MUL1RVhwvwIdLlxZHlGYlPcMN71b61oy1jTH/2hQqajrTZV1UZCRMkK+uDJd7RmaYjS7EVDrPBf2PlCIrmIp/IQ9llhoD0whh1PSYOGVQIAycUE/I/YawtXWRSKiCwZ2Av3ilA3WX/h0makRhUVXjM2sjxtc3BxQVaSor7653YuMqdjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KlOnohE9femW3fLUF/76CxBS48abokqdkHokag4ucAM=;
 b=hfHaBt9mdzIzwYt075XbpUvvxAW0u9khAJgAxs7izQrlXqcsysFimKj0bkYkDKDeqMddNtK1Vrh1g8h+XjkVV/MabQFWrV9lSNrQ6NoJgBfNn5dBOquMhp603fVLkJ1xJtosEa6QSXFucQwM3BntgDQzCW6HGSBQvrdiPgJfSuAs368kF8/LppQQdjfi/FXomf7bBS9bPGyx1dVQ3SomJgY3lnhHyzoPpNUyprQpuETnYqiGoZQMAz6fIzN2Qp2oMji+AkxqXhImWlglvRqWJI+al91mFxjx57GMMGF0+1Gk6/R24ne6X3FSUuEabCm8frm6oAIXu66ybyauUXdOxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KlOnohE9femW3fLUF/76CxBS48abokqdkHokag4ucAM=;
 b=x8L3bdNDbdOCG6i0dHtyfxGmWgbaBW9LJLwWgGfoB0nRAYmycrLj23Ff3lTRhuAAe8HBCwQGD2UVqv0fjcR+2hg5cm6Y1xG9fbvBSez1OTniwQ0T6c8EKIb8x+/gp5Po+1LyyLHYquIAAWNoQ1rq9IbqW3UynyHJd4oRSxrv3FA=
Received: from MW4PR03CA0041.namprd03.prod.outlook.com (2603:10b6:303:8e::16)
 by CY4PR12MB1767.namprd12.prod.outlook.com (2603:10b6:903:121::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.19; Thu, 16 Jun
 2022 01:56:27 +0000
Received: from CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::e5) by MW4PR03CA0041.outlook.office365.com
 (2603:10b6:303:8e::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13 via Frontend
 Transport; Thu, 16 Jun 2022 01:56:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT027.mail.protection.outlook.com (10.13.174.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Thu, 16 Jun 2022 01:56:26 +0000
Received: from sp5-759chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 15 Jun
 2022 20:56:20 -0500
To: <iommu@lists.linux-foundation.org>
Subject: [PATCH v2 6/7] iommu/amd: Do not support IOMMU_DOMAIN_IDENTITY after
 SNP is enabled
Date: Wed, 15 Jun 2022 20:55:40 -0500
Message-ID: <20220616015541.11207-7-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220616015541.11207-1-suravee.suthikulpanit@amd.com>
References: <20220616015541.11207-1-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4c0b7bf-f4ef-49c8-2889-08da4f3b6c9e
X-MS-TrafficTypeDiagnostic: CY4PR12MB1767:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1767492541490A7125FBF303F3AC9@CY4PR12MB1767.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TjbnYb7lJq9f+tne5tjs4pg/2T52H2JOm6V811sBr6D2QBc5H0BmV660DpOKil4QS0LByAS0+p6h//QwY8C6yQ/soxbGSC8Ixn8CRUuHxXr2q3ya0JORU6HJqI52Qu55g0Amelfvu+lHbyKw5nsB794Cxww+Gpc8HI1rqJtKKB3yqKkP66nd6TNLDZyk4RQ9l1uaDC9w82O2Pkktl68wEGSNIOp5FBM7jttbgTjKhSjCoUlyQxMHum86aCf3UkT7m0ana6XCGHEPnxh7BhianINRaYUg6JyTKVUFK9DWzFcFHBAS7Y8Mfr+a9FbWyljuxhAt5CQlXs6RQKuY4kwef+PWPSFLtcig30wTt5/zAs7CJq7bOWTdKY2MYUCpHA52pEu0xra6j7ak/EBvSFXrAdfId0Znw8rwg8liMMAAEYbdbeOeJG6pAit6PCdWlX+v6mFN3meB256bua1E07ZgqrBxt8hWFM6vNwviR6eCZImyhba2jCLtOoAVMerRm7lEN/suPPtFuSRs3CIr5AJz6d3WFYMZvo5Z22O3o2UAuJADVvLAJxJ7Rmtrya4KFaZ8HWWDwQ+lAs5sAkrCDre2m3kWCcN4eKv+Ve5PMQNIx+iVIwG+jv059ffRKjZw7JfsuemwA25VSenBXPNLL0n3cTdAeVLOqfat4v8ubhptyt2WtE3I4jzmj8RgPfvxOxrGCxB+wdqpbheo/c54Ivbf7A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(46966006)(40470700004)(36840700001)(2906002)(6666004)(356005)(5660300002)(8936002)(7696005)(508600001)(36860700001)(426003)(1076003)(336012)(16526019)(40460700003)(47076005)(186003)(81166007)(36756003)(83380400001)(26005)(86362001)(82310400005)(316002)(54906003)(8676002)(4326008)(2616005)(6916009)(70586007)(70206006)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 01:56:26.8597 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4c0b7bf-f4ef-49c8-2889-08da4f3b6c9e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1767
Cc: thomas.lendacky@amd.com, ashish.kalra@amd.com, vasant.hegde@amd.com,
 robin.murphy@arm.com
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

Once SNP is enabled (by executing SNP_INIT command), IOMMU can no longer
support the passthrough domain (i.e. IOMMU_DOMAIN_IDENTITY).

The SNP_INIT command is called early in the boot process, and would fail
if the kernel is configure to default to passthrough mode.

After the system is already booted, users can try to change IOMMU domain
type of a particular IOMMU group. In this case, the IOMMU driver needs to
check the SNP-enable status and return failure when requesting to change
domain type to identity.

Therefore, return failure when trying to allocate identity domain.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/iommu.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 4f4571d3ff61..d8a6df423b90 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2119,6 +2119,15 @@ static struct iommu_domain *amd_iommu_domain_alloc(unsigned type)
 {
 	struct protection_domain *domain;
 
+	/*
+	 * Since DTE[Mode]=0 is prohibited on SNP-enabled system,
+	 * default to use IOMMU_DOMAIN_DMA[_FQ].
+	 */
+	if (amd_iommu_snp_en && (type == IOMMU_DOMAIN_IDENTITY)) {
+		pr_warn("Cannot allocate identity domain due to SNP\n");
+		return NULL;
+	}
+
 	domain = protection_domain_alloc(type);
 	if (!domain)
 		return NULL;
-- 
2.32.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
