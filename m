Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B754CC433EF
	for <iommu@archiver.kernel.org>; Mon,  4 Apr 2022 10:06:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 64C3282B1A;
	Mon,  4 Apr 2022 10:06:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nLoFu292O-eO; Mon,  4 Apr 2022 10:06:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2074081759;
	Mon,  4 Apr 2022 10:06:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 05920C002C;
	Mon,  4 Apr 2022 10:06:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5B7EEC0012
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 10:06:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 56ED84093E
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 10:06:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gWFi1VOIkrrB for <iommu@lists.linux-foundation.org>;
 Mon,  4 Apr 2022 10:06:38 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20606.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::606])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5E6414091C
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 10:06:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HNEfoZ5NijtGPvv9+4Nilwo5PZ27LWGYD9pldX+hM7XAUH8r8a7HMNLP3HG61hrZR8iFLo5R9jYbPUjHlZSKbekoB88dt7/Hf6ECyPp0IowG/eVSEe3ErCGb97t+mTkrkD/zdIC5PCYE6YFYmAzuWzoh5cHKMGRkUVUvKE/Ws7WPJ1/UJG22aQIfUg8XRt6FfVIKvyLPBsY2BkAvmxdCTYRR3qfXa6QjJBXsIqXI3DPIjdPcqaIC8DQPtVLE8Fz80Dxosh/ybWRmDym5rGfiD9jhWatE4aOQP4HIOnmsDRSGuQeCbu7Flqe5Pg5xspHEDPIQGG5Jxa855te9rmZjSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vCmx/n5fn97+BBkSMmWyhUrO/Hpg6NbY2gRiCiZvOXY=;
 b=Zk5BlRDCuoUl0zRAv463ePaq/TSevd3cEeNmEHgB9eXWw5kOgJhxQYypMibC02OsnDzNpA2KXzIKEANL44Q8nVv03oLpmSXBcmlBCxJxnThmcz6Gg2iyt73ov5TQLbWZBegGxs9owcBO+2R/XonvVs+tJf/VFPMOrq1r7m0nPv/Hvc3MihWzxz/MQXfdqtYH71x2+qRZgQciugNelqRt8RmAl1mwziL9XYev7ZGsQX/Mo+G7Tktii6UYaHsc/+WpyOCoJ6IAz8RDq9egi1cvc9zQIGzUGuQzgXxkd5IAHRVnbJoGTQLAyfdn+ym77std9u46RxrsUhMDklDy7aXsvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vCmx/n5fn97+BBkSMmWyhUrO/Hpg6NbY2gRiCiZvOXY=;
 b=UYkKNZ2LEEouK2LYS6CQO8XkVEtaI4pSsrysXeXkidnh4qDwc48hb0KnBuS8I/+O19q/ehjVI24HzLT4Zu70Wt9F5V48KgYUnWz04FUsixY1K7xBraH62m5rtrrzmwLZHmaBhUtvh0CAXz7zttnEDOpncCn/Vp+cg8rpL1WdLb0=
Received: from MW4PR04CA0216.namprd04.prod.outlook.com (2603:10b6:303:87::11)
 by BY5PR12MB5509.namprd12.prod.outlook.com (2603:10b6:a03:1d7::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 10:06:36 +0000
Received: from CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::35) by MW4PR04CA0216.outlook.office365.com
 (2603:10b6:303:87::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31 via Frontend
 Transport; Mon, 4 Apr 2022 10:06:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT014.mail.protection.outlook.com (10.13.175.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5123.19 via Frontend Transport; Mon, 4 Apr 2022 10:06:35 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 4 Apr
 2022 05:06:32 -0500
To: <iommu@lists.linux-foundation.org>, <joro@8bytes.org>
Subject: [RESEND PATCH v1 23/37] iommu/amd: Update dump_dte_entry
Date: Mon, 4 Apr 2022 15:30:09 +0530
Message-ID: <20220404100023.324645-24-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220404100023.324645-1-vasant.hegde@amd.com>
References: <20220404100023.324645-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a41e10c-ddf8-4609-4034-08da1622cd70
X-MS-TrafficTypeDiagnostic: BY5PR12MB5509:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB550930779EBFA8945F23FC1687E59@BY5PR12MB5509.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ttwwbRIkn++0NhRj2twiuIuzL9NgsaR58hJcE9xZPDoYpImdPwNgO2+cmSAf7bnmQ2/jHVcF9mCWHTfwlEHvqFxMsDZJp3+4mjP2I6OSiXFioIXBJsTbzdm64Vxo4RjATvZVDBg7fBIpv6VCB8chw/cG3hqBIfRF/3paG/9D22Bwqnn2vnNzl4vNmQkEhm3o4DgTZjBUkN//gZfS8zePHtLLO22txhKPifYfSdoJsP5I9tzXhZSXx2eC6MuX+jXpnIaC5zLf5zI7vnRfBclpi9OuHRyLPDf3AqFRziKN0MnggK6MtmlkODgG7lHc/IJ6qLa02N1XuInHp/C+pH+OJZo27i/OALH/Dz+ZGu5o3fIjA+VBbpsY+27gJfmoQ+2nQ3KzqdWH46XXJ57YqAUgEM+EhzEbDTdkt5LduYfioAQbbJBKNkGkWGMfTpgJUZFc94WTujh+pxXBPFJGzd+z3nzBGM3FYDVDSVtDtIqLrNlEggqIqoHfFHuZFyxRbf5w0it/9mYChE9Gr4FZAmR62V/Z+N9MvPLiJLX1PCEZb99HyCmA/NoyQv0IRgu/Jd1DI+DrojBldov6IUjpkkVC/v61yBgCWeGqxatdgSIgqdzYWB/dMiU9YuIgrW/gWcKY8TeBxc1HvFzVaCM2oexcp7BKFaHYG5FXzwPEntUVC0RGURaGZCmnhzKLRDfzhivhRNR65Tv6eNYfdFVYluYfSQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(83380400001)(1076003)(82310400004)(186003)(26005)(2906002)(44832011)(16526019)(2616005)(40460700003)(86362001)(81166007)(356005)(426003)(336012)(36860700001)(47076005)(6666004)(8936002)(4326008)(8676002)(70586007)(36756003)(70206006)(316002)(54906003)(5660300002)(508600001)(110136005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 10:06:35.5856 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a41e10c-ddf8-4609-4034-08da1622cd70
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5509
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
index 81a7d3b617be..f2a9f7078b2a 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -450,13 +450,13 @@ static void amd_iommu_uninit_device(struct device *dev)
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
@@ -617,7 +617,7 @@ static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
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
