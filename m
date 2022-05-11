Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2840C433EF
	for <iommu@archiver.kernel.org>; Wed, 11 May 2022 07:28:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8068A40B42;
	Wed, 11 May 2022 07:28:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QxHaFo4p85UZ; Wed, 11 May 2022 07:28:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 492734060C;
	Wed, 11 May 2022 07:28:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 04AE0C0039;
	Wed, 11 May 2022 07:28:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A46B3C002D
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 07:28:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 92BFF40B42
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 07:28:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TVnnpO9MypGA for <iommu@lists.linux-foundation.org>;
 Wed, 11 May 2022 07:28:07 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2061f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::61f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 652FA4060C
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 07:28:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kIeBgGBcEbpAJeFuqtE5r4YXt6sCXE+JIUh8MPxQjbvlMYsfbzB4yv5vw00Y+KdmAkAVQuye2EYkJhkgZ/EQDMdDOQiugoxysbqSj1eYypWpU5PTCaCWQAdoKe+IW1Q4cBbY3nWIH15eIrzpkE2lrTY0z36p5BzjF93gRwrHlhva9WSh2aVNdX4BlY+Htl7QSKUB6LX9iglVEQMk6fp0ROF70C1eY3VoGIcQiYgYctYWYHgxzywf82ztyl7/j8gwApZ3e3IWefUyKKEfduara0SEwOM8/UlYob4jDpbSA9p3UdyTvlqYJAt2eJuUEV7Av/Ebz2rI6c7FkL4+dTlXiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2bFmE81uXZid9kxupCScv4sBbzvpw5KIa/mU/joJRQs=;
 b=me+DR5s9APowyqyIZ4WsIwq0amqEjitX58gO3m8hf9G3cVextAaVL9/sNatmaIQeSKzhkcyAKynwBn2J4aPWTag8V6UaasUV/H/FzmDmOKSFdOIhckBq3xntWkAX03KnOGp38L4fE05hr3ZJ5ox+QmRZUoC7ENNNOYeQRgohTqN3XidXlN/rMBlW56BQmcwtqRA88J07wFiTCG+SgO23MdMtZXMkWpAywSt2/be1zcDUEQbove3yDVJylPETKBrjOOw9AXGqR5jRgedBXoymXw2OBJrQ7Dj7mxus73SVqalWWEql/C5uKJTCw8MIytHFjhUshYdHZIJgFQUItupV0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2bFmE81uXZid9kxupCScv4sBbzvpw5KIa/mU/joJRQs=;
 b=PljyBQTo6XRpmdWTQVPnWODno79L3LQg6B9CQP+HaVBnRAQQdYJePKlbmZz0q2Ki5fNO+z3lZ9CiU1EYm3dOtXqsr2JfxJoMCZ5qAiTGXXNR+jGtkfjN/cyKtKNLmr5h2ni9JwnaOwoxgb9jNFg8C5XNrfQFwKKsHxYMYtHX1jY=
Received: from DS7PR03CA0232.namprd03.prod.outlook.com (2603:10b6:5:3ba::27)
 by SN6PR12MB2750.namprd12.prod.outlook.com (2603:10b6:805:77::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Wed, 11 May
 2022 07:28:03 +0000
Received: from DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ba:cafe::ba) by DS7PR03CA0232.outlook.office365.com
 (2603:10b6:5:3ba::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22 via Frontend
 Transport; Wed, 11 May 2022 07:28:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT003.mail.protection.outlook.com (10.13.173.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Wed, 11 May 2022 07:28:03 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 11 May
 2022 02:28:00 -0500
To: <iommu@lists.linux-foundation.org>
Subject: [PATCH v3 23/35] iommu/amd: Update dump_dte_entry
Date: Wed, 11 May 2022 12:51:29 +0530
Message-ID: <20220511072141.15485-24-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220511072141.15485-1-vasant.hegde@amd.com>
References: <20220511072141.15485-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 739edf53-19bd-41b4-5df9-08da331fc8fd
X-MS-TrafficTypeDiagnostic: SN6PR12MB2750:EE_
X-Microsoft-Antispam-PRVS: <SN6PR12MB2750A48409FF5B37BA13D00187C89@SN6PR12MB2750.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bX+ZdbAkZHISDR0203wo7ndWvJBcmY3HeZGIsKzgGxUl1CedhVKo7HgAwlyHOvsij4gS4yH0XohO2EOMzCtnEWmGNWPoe1uD5mZPPFAV7uqTz2QzRCj3gstumQ0GtrDFQRiiwNtzZ2m9i/9Bus0rIiIn6pvD8UTJsODujRKuYAWxP36za1ysLttGdMxwCRgPL8eItB15tP0NYQ5A0KI6FkfZxAVr+AQUfmVGwZpdmFeQOwiZVYdQ6yIz+wX+wCFjlWMigOg9BJfdkDp7J/LNt91Y9huy9v6HVoSzf2Zc6POyWdGCcH3QXf753shgS9s02350HzIvMl7xHiyzXlBmvg4y0mg2lvzPV0bjp8yWDQiRq+YPPjY7OV5h5Rz9s+eZS1FReFj+J3MyAjCUONoZqps6cNuGUrUHskgX2ew0lX4Ul/e/R5nqrCcKgqiqEs2Q7JuVOm1kjYENsTUnXRPI6UiScRq2vC9IeJdJWRgANWb8QX5t6OygtIAxBCLpK8FeAqLkT6jzrxjiXiNjj3Nsyj0KdnGLG1Q6tuSxSk7nyBWGR/stFvAQG+4i6SYhSn5LxWzKSQgUy4hvSOh+9rmDXmDQV/hAjlponA+l6rzkYm+WL11TmSaIwyoDycBqaGYo5Szfcct1oVgua3UuneDRWNEJ10xfnfoPM2OIniER5KwUBoJRJZof8BbXC/isTng4eKDd0AiLc7wntaqmNFPClA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(70586007)(44832011)(36756003)(6666004)(4326008)(81166007)(8676002)(8936002)(82310400005)(316002)(70206006)(6916009)(336012)(7696005)(54906003)(5660300002)(508600001)(2906002)(40460700003)(356005)(426003)(86362001)(36860700001)(1076003)(16526019)(2616005)(186003)(83380400001)(47076005)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 07:28:03.4460 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 739edf53-19bd-41b4-5df9-08da331fc8fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2750
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
 drivers/iommu/amd/iommu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 6223af4ccc22..8c99e2e161aa 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -451,13 +451,13 @@ static void amd_iommu_uninit_device(struct device *dev)
  *
  ****************************************************************************/
 
-static void dump_dte_entry(u16 devid)
+static void dump_dte_entry(struct amd_iommu *iommu, u16 devid)
 {
 	int i;
+	struct dev_table_entry *dev_table = get_dev_table(iommu);
 
 	for (i = 0; i < 4; ++i)
-		pr_err("DTE[%d]: %016llx\n", i,
-			amd_iommu_dev_table[devid].data[i]);
+		pr_err("DTE[%d]: %016llx\n", i, dev_table[devid].data[i]);
 }
 
 static void dump_command(unsigned long phys_addr)
@@ -618,7 +618,7 @@ static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
 		dev_err(dev, "Event logged [ILLEGAL_DEV_TABLE_ENTRY device=%02x:%02x.%x pasid=0x%05x address=0x%llx flags=0x%04x]\n",
 			PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
 			pasid, address, flags);
-		dump_dte_entry(devid);
+		dump_dte_entry(iommu, devid);
 		break;
 	case EVENT_TYPE_DEV_TAB_ERR:
 		dev_err(dev, "Event logged [DEV_TAB_HARDWARE_ERROR device=%02x:%02x.%x "
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
