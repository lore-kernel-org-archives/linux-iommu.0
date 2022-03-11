Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8482EC433F5
	for <iommu@archiver.kernel.org>; Fri, 11 Mar 2022 09:58:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 530764034D;
	Fri, 11 Mar 2022 09:58:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LBtE5AInAWUv; Fri, 11 Mar 2022 09:58:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 20DEC40309;
	Fri, 11 Mar 2022 09:58:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E6F5EC0012;
	Fri, 11 Mar 2022 09:58:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8509BC000B
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 09:58:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6ECB384372
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 09:58:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Wdc15blJCymL for <iommu@lists.linux-foundation.org>;
 Fri, 11 Mar 2022 09:58:08 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20605.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::605])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AA06D84316
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 09:58:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BX3Hd+k2e7xuCiijO173F+zJ/vIsxEyZw1rveQ8czDXtGMrnIMGHiwiQAkFt98H1HkZ8m+XJE+qjyynA/FYQ2nyegx3byPtTtFD9U/lHVVCtMnEaMqZRVjr0htZBjDi0blRX+5ITvicytbEpK4YumkUwf5oGzKJQt1bETwyx6nQGhuB2R2OQc3I292tfBbvB7ctjGVa1cSa6yvQ5qIb6ONJ+PDsfWvo/sMKpOC17TQDn1x47TlcUXK6JKQM619QNRoPOxakcvKx0Dj7HcT2LPecKArpaF+KJNFP1019b6g5FTflpVHrhSMR/Hcs8rXihqziInIzfQ769MjRtvO2jMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8O1Mzql2oxLkVSN0CAEE52AmrLi7j8XH2MhQeinmdVg=;
 b=Qw3EyHz9fqKqVm6v1LjEqHe9ydxgJGA4qbCdXCpLR2ljjyE5Eouz+hpiXCR6VZeskid10ZL+rVwLemst0Z5wiA9ksy8sLKWlAFnaoqqo+GfoaT7LIkr/lZAZQL33HIR/eWgRbi2RKE2achIKDp1ib/gsOIAKXNIrDc+S1SD6A29rlq0oZE1/mRxAUC4JqE06+JE/OMulyATxAUUw99SRpJiuVBCzspy3Jc/vrww58ODRqplRq87ZscUK05tFhNAUjfv75iptH6m7Z6OR9uwkMZSCbTjKeiYCaFhnidd3687qCRunNyRwCQgiKx9AmR2yknOLowmSYXjzDx2jDiPekA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8O1Mzql2oxLkVSN0CAEE52AmrLi7j8XH2MhQeinmdVg=;
 b=u3B6zViqeQaf+CsjNcEL+glRYeZ6ItVa1mT/46R4JXV/dOUVSy5FsaHtu74nH8hJ47RWy9kBueUS+Qcpf1ZOlqzOR0zGsz+x8YQp/Q3VhE8eSG7ql1vQpVE/P0Cavd2/bvDp6L/mZZYoPqKRRug7wiCpQXj63crYHFzo85HDOnI=
Received: from DM6PR13CA0064.namprd13.prod.outlook.com (2603:10b6:5:134::41)
 by BN8PR12MB4980.namprd12.prod.outlook.com (2603:10b6:408:a8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Fri, 11 Mar
 2022 09:58:05 +0000
Received: from DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:134:cafe::38) by DM6PR13CA0064.outlook.office365.com
 (2603:10b6:5:134::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.7 via Frontend
 Transport; Fri, 11 Mar 2022 09:58:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT037.mail.protection.outlook.com (10.13.172.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Fri, 11 Mar 2022 09:58:05 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 11 Mar
 2022 03:57:56 -0600
To: <iommu@lists.linux-foundation.org>, <joro@8bytes.org>
Subject: [RFC PATCH 22/36] iommu/amd: Update dump_dte_entry
Date: Fri, 11 Mar 2022 15:18:40 +0530
Message-ID: <20220311094854.31595-23-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220311094854.31595-1-vasant.hegde@amd.com>
References: <20220311094854.31595-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c14ffd2f-6899-4c57-cde2-08da0345a353
X-MS-TrafficTypeDiagnostic: BN8PR12MB4980:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB4980BC0C6C5E9745039C9A0E870C9@BN8PR12MB4980.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V7bQj02XNcToLOVIxGoXMWrTx1K3I2y3F5ryxCkx9mgB2Q/l6dEWJDg4jtlsWuquKdfRDkiK5lLRTT8QeYG3NuHosInOXLD/p61rKpeQaO+FZ/egoBxcjdtG9K6j0V831c0s4woT3xOQg2OhhExeNnF7tlsqImu6RYkVRgSsgwJX3nOn8OAZUttJSnLSW/rddh+RuEN2NoKNPJq8TQlvVl7CO8OsWc8Z7fiOwqMk2kAKRtzbroySs5NLQG72KDiIRUSMBoPWzJw0JTPhHSWY7zoF+ONeMRptwzFhDnRd09IaO42sBtSYzvV50KnUqNBUmJToOcTN+HXyE+FUqdHj/zphIEMxoCV7jNYvszHEuh64+6QjCMysewp6WugdIFgtZwFRR6ue/Hx4IhhmeYahDVc69dyFZPLd6DJKJKLZP4T5PvI1/5q4JsXxBc1Xp2BdaXmdZYcnz0Yv0ernVMLiCdQjBfbP7gItknFmAHqlUvNH655VObIpryORKy11kGxRaxRNdGMCrEgjOQeXmCPlVyPNXB5PaC2Ma2pIWQf5uIW4vJBcXoHBQBtdLDpsvdvQZHipkOv0psoOYZeMt5AtwgMB14Ebk/YQcQz1PxLfAJwVtQdOM6NJx048LkL9cLJs81oHT2Hpv1K54OItQUCsorJCsy4TDCq3JoOYvDHJbgp3vhJU9941p1m1HUe6uA42YUwTzK2PcEzb0mCzU5f1GQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(5660300002)(70586007)(70206006)(36860700001)(86362001)(6666004)(8676002)(47076005)(4326008)(82310400004)(40460700003)(508600001)(356005)(110136005)(54906003)(316002)(8936002)(36756003)(26005)(2906002)(426003)(336012)(2616005)(16526019)(83380400001)(186003)(44832011)(81166007)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2022 09:58:05.3214 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c14ffd2f-6899-4c57-cde2-08da0345a353
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB4980
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
index be3eaa638420..2438cdebb296 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -449,13 +449,13 @@ static void amd_iommu_uninit_device(struct device *dev)
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
@@ -616,7 +616,7 @@ static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
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
