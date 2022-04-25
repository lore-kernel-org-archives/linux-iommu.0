Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50E21C433F5
	for <iommu@archiver.kernel.org>; Mon, 25 Apr 2022 11:40:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1888060BEC;
	Mon, 25 Apr 2022 11:40:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DzPGN0J0COAo; Mon, 25 Apr 2022 11:40:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 81B1160B2C;
	Mon, 25 Apr 2022 11:40:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4FFE6C0039;
	Mon, 25 Apr 2022 11:40:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1FF74C002D
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:40:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0EA4C4024B
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:40:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hWK1FFj65VcJ for <iommu@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 11:40:19 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::612])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0B32340225
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:40:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FvLCZItBaGY8axbddpr0Gl/1aLefko8z5QDWUvGevD3wR8v26qjMjoCVB6t8eGUvCDlJPQU6ovrBLnRHIVitce9FVatnP+JQxjNdZF+CE+vlOpVmDvPujZPTmDbC46NQnzTDg/rNTO/62W5yLBS1NhbpsB9A9aPaVXlbzUjDd6zVD1JhoYZfkCPuwCbOe0MGlc4P4f6AS/geD+q9lfAU2XvUcAyPoEyRzMoJbkrkiZRD2ILaasaWYIk1CuiK15/HpMQ99p9PNfuc+MOY7SbeK85INNx3OrVLW6giaCTHgQJ+KP9hS8BoEr82RJtFm30cGzUihKfhjIXoCOzuydoblg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HMLsZuVLcj10kP2q1Uwq/cfotHV6ALk+cjqNQUgDN9s=;
 b=On4Udvrj863QGahmlAi4umFVQpaL0mllq92FOCrJi+cQ8/25ue3JzdO7doX94rhRBMyaFSZrVolf7M6ZJwGtiwZRlTem5pV9UcFKfxCmD0JnF/o3npr+X6qSMO5Jf1QCGiED1Ut5o8B2vJxPaaCxAUvdIi/bUij2Tf+LagJR7xBwI96TKYZGmAY9+7kvQba4vsWbNkXaLE5CyhGDDCUqS0/zbdSwHH0PsKoWP0Yq4LOLXBOvK9KuNNR2wqQF5jkNGpQDAM3wiCwIR1oP7kd0zrI0ePtdTF2aMWvJH/tC/cQqSaz4f7tzvvH/hbjpfXTEfjUJ+3lSzhYW9Zudv84GBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HMLsZuVLcj10kP2q1Uwq/cfotHV6ALk+cjqNQUgDN9s=;
 b=n2AQJ3aft/IL/Ge3vrBj3/vMyXH+1t/FygPa6lA6ix6F97s1gmbzTs7tezBPDP1rknbgs9/is194h9ki63qARFttDOmqTtUqsXpWIAOD9uum/f01l05F0aoJfsuFixwUDf7K98GpRwEltG3pID2kkihuayJZ7WC6HrIw33lcF/o=
Received: from BN9PR03CA0353.namprd03.prod.outlook.com (2603:10b6:408:f6::28)
 by CY4PR12MB1493.namprd12.prod.outlook.com (2603:10b6:910:11::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Mon, 25 Apr
 2022 11:40:15 +0000
Received: from BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f6:cafe::4) by BN9PR03CA0353.outlook.office365.com
 (2603:10b6:408:f6::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Mon, 25 Apr 2022 11:40:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT008.mail.protection.outlook.com (10.13.177.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Mon, 25 Apr 2022 11:40:15 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 25 Apr
 2022 06:40:13 -0500
To: <iommu@lists.linux-foundation.org>
Subject: [PATCH v2 21/37] iommu/amd: Update set_dte_entry and clear_dte_entry
Date: Mon, 25 Apr 2022 17:03:59 +0530
Message-ID: <20220425113415.24087-22-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220425113415.24087-1-vasant.hegde@amd.com>
References: <20220425113415.24087-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d2b6817b-04de-494f-122c-08da26b05dbc
X-MS-TrafficTypeDiagnostic: CY4PR12MB1493:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1493CFF53586036FEA963D4E87F89@CY4PR12MB1493.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1t6pZ81Q3fw+e6G9LRoopeLduDQgi8g1szRrfVYi2jmlMl8bZR+z/Syatc++tp5BnHiE9I1P4n5pi1FLEGjpmCupCw5nD7UmixIxeACY73SJfN8JvLR6k3NeWPWByD3smaoR1egVWB/sWXksB1auu4vj0v8ZIdzIKSZdVZVHw4/MUv15903/2UpC8YQkVo7jkksz/c5l3Z+vldlQYQ/2Zc+a9bZFo6Eb9iXz0fNGaS8hZ6940BJThziYz6WFZ7FdpyoiP98AHaVY1odA3fcA8SDBgEokSeRRLLnjUrFiHOSIO3WoN72GHIBM59VMHyp4j160XHoC67b/KZpjK5JUrOjGcnfHbNYnLKTikgyu1/nDypx9290BWp/TDJduW249PsK2+qX0pYtl78jr/UgCuukZSNFVIzufYmU8NTduOee88TWivkyo5z3qLO9LwLMAK25onsSAM31THYr8uKSieOlosFi631ul6Xg4Pbgp+lQCgB1IJkPdXJaAELpC/IYfK1ibEbhTRgwwRyfsx7XbcBQ3BKdHqiTYDkvuOtqtJQdjeyb+PjLVo16bUSAE9W+DgbSMChVeC5nT5W1f1n1DWLW0zRqi/htFmX7E8osIXTHhps5emwccvU25uv1cFMwCdYSAC0qEchPcV0PFA0wtE08lvybvA6uxX/hch5Z48TABUPC3pNledlxE5NCg7d79vYh/vIFeHNibLjfsaAIIew==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(2906002)(82310400005)(36860700001)(81166007)(6916009)(5660300002)(44832011)(15650500001)(83380400001)(86362001)(8936002)(54906003)(8676002)(47076005)(508600001)(4326008)(336012)(2616005)(70586007)(70206006)(1076003)(16526019)(186003)(426003)(40460700003)(356005)(316002)(36756003)(26005)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 11:40:15.4427 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2b6817b-04de-494f-122c-08da26b05dbc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1493
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

Start using per PCI segment data structures instead of global data
structures.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 0d6230e493c8..689d3c355d73 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1537,6 +1537,7 @@ static void set_dte_entry(struct amd_iommu *iommu, u16 devid,
 	u64 pte_root = 0;
 	u64 flags = 0;
 	u32 old_domid;
+	struct dev_table_entry *dev_table = get_dev_table(iommu);
 
 	if (domain->iop.mode != PAGE_MODE_NONE)
 		pte_root = iommu_virt_to_phys(domain->iop.root);
@@ -1545,7 +1546,7 @@ static void set_dte_entry(struct amd_iommu *iommu, u16 devid,
 		    << DEV_ENTRY_MODE_SHIFT;
 	pte_root |= DTE_FLAG_IR | DTE_FLAG_IW | DTE_FLAG_V | DTE_FLAG_TV;
 
-	flags = amd_iommu_dev_table[devid].data[1];
+	flags = dev_table[devid].data[1];
 
 	if (ats)
 		flags |= DTE_FLAG_IOTLB;
@@ -1584,9 +1585,9 @@ static void set_dte_entry(struct amd_iommu *iommu, u16 devid,
 	flags &= ~DEV_DOMID_MASK;
 	flags |= domain->id;
 
-	old_domid = amd_iommu_dev_table[devid].data[1] & DEV_DOMID_MASK;
-	amd_iommu_dev_table[devid].data[1]  = flags;
-	amd_iommu_dev_table[devid].data[0]  = pte_root;
+	old_domid = dev_table[devid].data[1] & DEV_DOMID_MASK;
+	dev_table[devid].data[1]  = flags;
+	dev_table[devid].data[0]  = pte_root;
 
 	/*
 	 * A kdump kernel might be replacing a domain ID that was copied from
@@ -1598,11 +1599,13 @@ static void set_dte_entry(struct amd_iommu *iommu, u16 devid,
 	}
 }
 
-static void clear_dte_entry(u16 devid)
+static void clear_dte_entry(struct amd_iommu *iommu, u16 devid)
 {
+	struct dev_table_entry *dev_table = get_dev_table(iommu);
+
 	/* remove entry from the device table seen by the hardware */
-	amd_iommu_dev_table[devid].data[0]  = DTE_FLAG_V | DTE_FLAG_TV;
-	amd_iommu_dev_table[devid].data[1] &= DTE_FLAG_MASK;
+	dev_table[devid].data[0]  = DTE_FLAG_V | DTE_FLAG_TV;
+	dev_table[devid].data[1] &= DTE_FLAG_MASK;
 
 	amd_iommu_apply_erratum_63(devid);
 }
@@ -1646,7 +1649,7 @@ static void do_detach(struct iommu_dev_data *dev_data)
 	/* Update data structures */
 	dev_data->domain = NULL;
 	list_del(&dev_data->list);
-	clear_dte_entry(dev_data->devid);
+	clear_dte_entry(iommu, dev_data->devid);
 	clone_aliases(iommu, dev_data->dev);
 
 	/* Flush the DTE entry */
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
