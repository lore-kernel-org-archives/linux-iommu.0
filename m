Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27D60C433F5
	for <iommu@archiver.kernel.org>; Mon,  4 Apr 2022 10:10:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E722A41484;
	Mon,  4 Apr 2022 10:10:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8hjzSqEIJ_9V; Mon,  4 Apr 2022 10:10:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8605B410E5;
	Mon,  4 Apr 2022 10:10:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6DA5EC002C;
	Mon,  4 Apr 2022 10:10:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9F421C0012
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 10:10:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8DFB360C34
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 10:10:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id u34kmZknkcC2 for <iommu@lists.linux-foundation.org>;
 Mon,  4 Apr 2022 10:10:07 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::613])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D79A0607F7
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 10:10:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XWa4EplpySbsG6dEJL2ehXSEpVFh8cnGIJ6r8RR/oQqlnmZuO63zjRJzI0vZO+CEJhfIqOuoz0cnCDeOk1MHzAxpJgHXS755dsrLB14gWvYERh4m70wXNqRiRQ6nXCKvNibbAKavGjE9qBDXQbIubBamljwoNKPpiLTAeoiIln9ylsCiFJ6mACOaI1amTVNn8GjonRcSs0RiGXv2yDkjktlaJWpxzr1estCF16cnhoHlrxs9AYShtnr6B9PmPZy5t00cxqku8IbSXpSs7Bd8f4iEsz3sb0GijyklubEmrQulCZ4+fFVJcBDzvjY8xjQZdWeP7BvM0MWvYvWtZS8tHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PbSuXut4G/gqWCDxouo2cxK+YbTVHhiNkCzEIQM5AyM=;
 b=KFTPmi/yr4f0HK8A1MFMaHkaztiPitNv00q0nlP7AlwiSj2aUqPROW6Xn9EyUG0HK8V0vSYOBwNDCkvd0DqjM7uYRRZ2zsfvaYN3olZCKondTO74yqosGc3jEUyKSoaACxu8iT8d7OTbYIKoknb8H0T85foCUp1N4eELrQCoJzxVZhvekzoN0NwJ/CktJAo2TouYGXfltEIWzCQbD9CSohqj4I5Q0sVMp81582G9WGzcyN2LC4TYwqdCKwXJu32l1vzgwVrhRK95tlq94Blo/9S526kGhHRyR6ff/n2UKYflSFb+49aKNNfeVbDTnsVo4icqBY8iC7+U/kz+X005VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PbSuXut4G/gqWCDxouo2cxK+YbTVHhiNkCzEIQM5AyM=;
 b=dCuv9D9IE6cFqeQDJdtV1IPDHAjnlUIAV3cWdGF2xkB6q1ESYdebxz2aY9Ib0SgC0Hh/772me1/ly76nAe7WSP2PBtBktSD/SefQfWzO9hPgaODDvKaffB9ZBxDkunKL7lRjrNSbrnJLwl77x7Bmb3evaoLvk1v1stxz2z/2SOE=
Received: from MW4PR03CA0171.namprd03.prod.outlook.com (2603:10b6:303:8d::26)
 by DM4PR12MB5325.namprd12.prod.outlook.com (2603:10b6:5:390::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 10:10:06 +0000
Received: from CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::64) by MW4PR03CA0171.outlook.office365.com
 (2603:10b6:303:8d::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31 via Frontend
 Transport; Mon, 4 Apr 2022 10:10:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT013.mail.protection.outlook.com (10.13.174.227) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5123.19 via Frontend Transport; Mon, 4 Apr 2022 10:10:05 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 4 Apr
 2022 05:10:02 -0500
To: <iommu@lists.linux-foundation.org>, <joro@8bytes.org>
Subject: [RESEND PATCH v1 37/37] iommu/amd: Update amd_iommu_fault structure
 to include PCI seg ID
Date: Mon, 4 Apr 2022 15:30:23 +0530
Message-ID: <20220404100023.324645-38-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220404100023.324645-1-vasant.hegde@amd.com>
References: <20220404100023.324645-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb9951be-07fe-422a-df2c-08da16234a4e
X-MS-TrafficTypeDiagnostic: DM4PR12MB5325:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB53257FA37D7D83E25C607AFE87E59@DM4PR12MB5325.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RUvUi46f98SuyQegGFhAI6OMt3yIEQVPU+cFYRVIdLMA0Sh7jCJJ9MatyMh3LcUodt1KQz2kD0Jb9a+pcJyNMUsvk1qGD9tV+wWWEAESsQHt1vEZ0TxrHlJSluSxAdqpOOz0rMO+NBmsZEvp8cQFIDcGnQPq66pnSn02ZXTnXD6POWPPoPDWrgAzUwszbMKfaQjTVCGJMzNdrzhZS+mAIwjSNbMwvfZW0TeZu7rW2rEgVF4EG3wMfO8zX8XEM4yELMBc6LQ/nT/eFL37nhEKnXsibCSM/z7z//j5ByM0pmed4pMVIeyPN44n962RSJZLs1qLbn8WoPvYYm0xYHiPjYYcpyqnpwABEpIrzfG/EW4fTmPaFZ3UdTVkIwv5HNcNAlxTK8NNZJSD+s/mfZiV+2KGvkmfeKS4u+aZzZ8TlZiY69oGp8ci1VKkSWdtc9jucgaIFrirvxMVzDIbYBj7GHyv2lbMrwarviCRQX4ltCclOVNhNgTMop8BeRY2ubtOvn75VtgQeMPMIUD9Dag42gmqvZ7iif1YfVByv0MoKaz9o0ueL8es2KotL9YbROsCLs0CpmF22w8x9fsphW9GGDGEbBKpJu2eygdMujZWvsuKtUokabchw6byFll66eFdOcCDnMkBwZq+c3jwvzNcEchExM/j0HH/nr4d0TPWTdtthrgavvfxW7fEaBiT6qAi3EwxaieDwHxZuF/KmEXCog==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(82310400004)(70586007)(70206006)(8676002)(8936002)(4326008)(36860700001)(356005)(81166007)(44832011)(5660300002)(6666004)(86362001)(316002)(16526019)(36756003)(83380400001)(508600001)(54906003)(26005)(1076003)(186003)(2616005)(40460700003)(110136005)(336012)(426003)(2906002)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 10:10:05.0664 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb9951be-07fe-422a-df2c-08da16234a4e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5325
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

Rename 'device_id' as 'sbdf' and extend it to 32bit so that we can
pass PCI segment ID to ppr_notifier(). Also pass PCI segment ID to
pci_get_domain_bus_and_slot() instead of default value.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 2 +-
 drivers/iommu/amd/iommu.c           | 2 +-
 drivers/iommu/amd/iommu_v2.c        | 9 +++++----
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index f2bbcb19e92c..a908f18a3632 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -477,7 +477,7 @@ extern struct kmem_cache *amd_iommu_irq_cache;
 struct amd_iommu_fault {
 	u64 address;    /* IO virtual address of the fault*/
 	u32 pasid;      /* Address space identifier */
-	u16 device_id;  /* Originating PCI device id */
+	u32 sbdf;	/* Originating PCI device id */
 	u16 tag;        /* PPR tag */
 	u16 flags;      /* Fault flags */
 
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index c64a2382b4a0..e04d349f5f9e 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -700,7 +700,7 @@ static void iommu_handle_ppr_entry(struct amd_iommu *iommu, u64 *raw)
 
 	fault.address   = raw[1];
 	fault.pasid     = PPR_PASID(raw[0]);
-	fault.device_id = PPR_DEVID(raw[0]);
+	fault.sbdf      = (iommu->pci_seg->id << 16) | PPR_DEVID(raw[0]);
 	fault.tag       = PPR_TAG(raw[0]);
 	fault.flags     = PPR_FLAGS(raw[0]);
 
diff --git a/drivers/iommu/amd/iommu_v2.c b/drivers/iommu/amd/iommu_v2.c
index b186d33336e0..631ded8168ff 100644
--- a/drivers/iommu/amd/iommu_v2.c
+++ b/drivers/iommu/amd/iommu_v2.c
@@ -518,15 +518,16 @@ static int ppr_notifier(struct notifier_block *nb, unsigned long e, void *data)
 	unsigned long flags;
 	struct fault *fault;
 	bool finish;
-	u16 tag, devid;
+	u16 tag, devid, seg_id;
 	int ret;
 
 	iommu_fault = data;
 	tag         = iommu_fault->tag & 0x1ff;
 	finish      = (iommu_fault->tag >> 9) & 1;
 
-	devid = iommu_fault->device_id;
-	pdev = pci_get_domain_bus_and_slot(0, PCI_BUS_NUM(devid),
+	seg_id = (iommu_fault->sbdf >> 16) & 0xffff;
+	devid = iommu_fault->sbdf & 0xffff;
+	pdev = pci_get_domain_bus_and_slot(seg_id, PCI_BUS_NUM(devid),
 					   devid & 0xff);
 	if (!pdev)
 		return -ENODEV;
@@ -540,7 +541,7 @@ static int ppr_notifier(struct notifier_block *nb, unsigned long e, void *data)
 		goto out;
 	}
 
-	dev_state = get_device_state(iommu_fault->device_id);
+	dev_state = get_device_state(iommu_fault->sbdf);
 	if (dev_state == NULL)
 		goto out;
 
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
