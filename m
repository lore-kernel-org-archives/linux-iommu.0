Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E36CC433EF
	for <iommu@archiver.kernel.org>; Mon,  4 Apr 2022 10:06:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F272F82948;
	Mon,  4 Apr 2022 10:06:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TRvZPOqYIlh1; Mon,  4 Apr 2022 10:06:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id F22EE829B1;
	Mon,  4 Apr 2022 10:06:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CA159C002C;
	Mon,  4 Apr 2022 10:06:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7FD92C0012
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 10:06:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6031B82948
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 10:06:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Km7o2sp-0FuV for <iommu@lists.linux-foundation.org>;
 Mon,  4 Apr 2022 10:06:24 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8b::617])
 by smtp1.osuosl.org (Postfix) with ESMTPS id ABBF781759
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 10:06:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cYBDNaAoGcC8H7iWjCOlsIV7jpDWUrcIMbrLSVFeD6XbESZrVJoV7ialXCaAPhT/QCV00ab3osoXqkUf/Dqg5rBx2QZAQ4pmF3w/roN6WQgjV2yrgsHMZnk7SU8zcjTdj5UrlcaOVl0zCMSaqVFUe5t1Co5RwLYE38N9Izp1YdVuWwskGLnGFF0JecMNQ46sQnMdkba+ICh81h+Lu/dzsrEmQbG2HgC7G0FLacEJro932nFNFVEFHh+0CVPs5YtKGczkM/SV11fXi7gQprosx4wHSZbJTGIO242C47wo8sIWIqagDBLLgdEUdHUoH6SkK5DbN3O8ll2a/GGCdzJAlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eYSUcjcRlOICubnnodFatZ73pAxyAZ1GjOAVscziptc=;
 b=OoThZ1mBgCHmHIW4ue7ibkV9knvHJ06a8o4CEhDQj/xfg5nko4+8LbfP4FpRdEPRL/spUYK+ulcYWwFEBlYfJUuGUMLrSGT+4jgQu8ebN0Eb9Lu5Vk2WPi2uIxi95X49WW1PGEP8ww+w/v1R7bRhWV2PJNl262j7PwXCPkjGj7sstIzXkl9jCRhe1XVN/QF0A3r6gan05xuUMsnMbXoqrJrA04SbKsF+GiinvefGbdzr97OzL+htfZQQmMOOrFrY2nGQyYMZoHSq5SoEv1vGvVEXgeQwasphO0h+A9gJEtDDxUQv2WbHINY+OYB2/ZJ07pC8AL2szEhxx/8FoznUhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eYSUcjcRlOICubnnodFatZ73pAxyAZ1GjOAVscziptc=;
 b=fNHN8+Vx76NauBYBDbK++R5lbUveO7L7W6YsxfISt6zpzUM2ZlFZU9JMV5q1nq7hnvybvyJpkRujQOegvuaT99jI6iISp60z9qHmVUnoxxhLi89fZPOKe9R3rdvnpKloy9aGVviTnlzHUTNTVp+1+AXSrVNW+a9o/NdRF3SrQi0=
Received: from MW4PR04CA0358.namprd04.prod.outlook.com (2603:10b6:303:8a::33)
 by MW2PR12MB2523.namprd12.prod.outlook.com (2603:10b6:907:11::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 10:06:21 +0000
Received: from CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::2b) by MW4PR04CA0358.outlook.office365.com
 (2603:10b6:303:8a::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31 via Frontend
 Transport; Mon, 4 Apr 2022 10:06:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT032.mail.protection.outlook.com (10.13.174.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5123.19 via Frontend Transport; Mon, 4 Apr 2022 10:06:21 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 4 Apr
 2022 05:06:17 -0500
To: <iommu@lists.linux-foundation.org>, <joro@8bytes.org>
Subject: [RESEND PATCH v1 22/37] iommu/amd: Update iommu_ignore_device
Date: Mon, 4 Apr 2022 15:30:08 +0530
Message-ID: <20220404100023.324645-23-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220404100023.324645-1-vasant.hegde@amd.com>
References: <20220404100023.324645-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 67bc3d57-8a7b-4094-48eb-08da1622c50f
X-MS-TrafficTypeDiagnostic: MW2PR12MB2523:EE_
X-Microsoft-Antispam-PRVS: <MW2PR12MB2523FCF9AAA7C09B25604C1F87E59@MW2PR12MB2523.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wIj63KjvFgc4WMQjSyNqeDT7QKjj5ZP9jqAUnFv63HH6TeES74rnUy4gzlbKRePXTyffG/S+fkk3BmTitFHh122R4gTgTaM/K+flC3iOZtO3a29nivOSJqFsu2FAdhkelKkn+XC2MSaU+RFCLpJ875psaP1SM24N8m9wL3yL11s65BS/vAw5xhknivl3eSclTaC2eFq2TMFJZndW+k+1DGjMnoLrMyOJZAe+QNERYSZp58SbW1LravKsTJpZHkdhmTfOX7DJiWzangK4eqCWc/JWDQ/EV1JwPUgkh67uJv4B88rEsy3gULDc5ylhZ9nmF3cJN+JmNqm797RQUqpQlJ2Ex8072OVTS5M66UR7pZth9b8AWHzz7B8ilK+1OlMiS/TbwDkOSoWc7gwo+5mX4wd33MjvvvkyXdrOddBkcv22al2jdGhhpYDaWMNJd99z4d+8T7fk7VAdMr/nC+oPcWi6dXjD+ZyoVmwhCVchcQ4Ksk3XDGTlIrflDW9WHk7IpHD2+btpeVG5vFKtGDvH6Eqx4oXSg2tqIXz6QYUqrVGzNGKt838HrT2hm6NgZTwAyV2lUpLc8Vwuowf3hfiTO3Jh+ICVQtRmMCs2PuJ4IL67OYFHx1HRj3fAM98HkimoexRB6uJa+K3Fw128OT6s2wcH2rLrFZlykbHEpWAfcPweDhmgnqOA5j2v0MkAR+fGvkTgGGFzWS1CbDIfv1AZkA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(86362001)(44832011)(1076003)(26005)(316002)(6666004)(16526019)(47076005)(186003)(508600001)(83380400001)(5660300002)(426003)(336012)(82310400004)(40460700003)(8676002)(70206006)(70586007)(36756003)(81166007)(356005)(8936002)(36860700001)(4326008)(110136005)(2906002)(2616005)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 10:06:21.5127 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67bc3d57-8a7b-4094-48eb-08da1622c50f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2523
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

Start using per PCI segment device table instead of global
device table.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index adc1747234ff..81a7d3b617be 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -412,15 +412,15 @@ static int iommu_init_device(struct amd_iommu *iommu, struct device *dev)
 static void iommu_ignore_device(struct amd_iommu *iommu, struct device *dev)
 {
 	struct amd_iommu_pci_seg *pci_seg = iommu->pci_seg;
+	struct dev_table_entry *dev_table = get_dev_table(iommu);
 	int devid;
 
-	devid = get_device_id(dev);
+	devid = (get_device_id(dev)) & 0xffff;
 	if (devid < 0)
 		return;
 
-
 	pci_seg->rlookup_table[devid] = NULL;
-	memset(&amd_iommu_dev_table[devid], 0, sizeof(struct dev_table_entry));
+	memset(&dev_table[devid], 0, sizeof(struct dev_table_entry));
 
 	setup_aliases(iommu, dev);
 }
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
