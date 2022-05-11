Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 501E1C433F5
	for <iommu@archiver.kernel.org>; Wed, 11 May 2022 07:27:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1348640B4D;
	Wed, 11 May 2022 07:27:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AEGvQbJ5Xt9Z; Wed, 11 May 2022 07:27:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id EDD924060C;
	Wed, 11 May 2022 07:27:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C8B67C0039;
	Wed, 11 May 2022 07:27:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3501EC002D
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 07:27:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 154F940B42
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 07:27:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5QerHEp-XSM9 for <iommu@lists.linux-foundation.org>;
 Wed, 11 May 2022 07:27:51 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20602.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::602])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C19954060C
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 07:27:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jvZxjw14QJ9hB6+BmKF07iIIewTZSVWnwEfFpHlA+Jt+6CuEKzLPz/dvwyagKqYVfE++mTJlAqMfqj8ahu5QHq0MmiA14urx5CFZXZH/tiVHdJvrQwTj10JGlf1hucGTz7bX5/RkpFMdtug+q5AXMYuxuB5F+fsp2yuk6q8XDh4dvvewRVzQqvCbP7O0GSLN0Zhnaa+9/ZfxEZ6HT25wAzJmTBRbZM+Ni3zX9eF9xj4bwCoRkcTp2rMI2nBW7MKEfONMl6D5RfDjxEayRylh9AfaNvpNTI8RsJUEt9C4voo9X9DVpdFoXlYr0aoA+rymyn0bYRa447i1UVfj03nfKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0xAHT6EiiqyRSsTRxSB0w6c+uW3A5USwLO4JE2vSWoE=;
 b=ekmTkmA10ReVJMpiSY4toiFBUuf75IYUsJDkTcBQs0bgynJSRCMpVepv+XdE7WRDgJBb1U4PMJADnmpXI2Vdc3C1oLKJDlSdy7XzjNxB9hHvk8rb1j2IHVrQBAKQgrCfWmRT93c0K/B/VBBBafYEUmFoS3+ZNiet6xtDly/ytspxt6yAH5Y5/0nVm7zrWpTrjInXBwdqmr/mRS0M+z5pe0sDWYwUBVYLMftipuoYGY1q3NwOf385mMAfNXFCDB9WYAiDkjLnmOptYS7B+Sp7R1xHon92I/pIU0bhNMq4eRH8bSfO1pZ7C1VDyzu0ocz0scNPKPmTXJfEqhwLNlx6ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0xAHT6EiiqyRSsTRxSB0w6c+uW3A5USwLO4JE2vSWoE=;
 b=OhP41JcYL8opEQY1qq9Ed5jBU1yUL302mDzeX38OFLEajrKNZcXpKLG3aA65ZTBN3WHRri5mXWAsdYYzhVLtpo/Qe8e5z5p5eln97JreaWqpzdeM8cnhoecTingcFZzAiz/FG5F1MM8RPFC2V6fCEBb1dlUsSxJb1MoQLbWnIiw=
Received: from DM6PR02CA0120.namprd02.prod.outlook.com (2603:10b6:5:1b4::22)
 by DM5PR12MB1931.namprd12.prod.outlook.com (2603:10b6:3:109::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20; Wed, 11 May
 2022 07:27:47 +0000
Received: from DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b4:cafe::6d) by DM6PR02CA0120.outlook.office365.com
 (2603:10b6:5:1b4::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23 via Frontend
 Transport; Wed, 11 May 2022 07:27:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT052.mail.protection.outlook.com (10.13.172.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Wed, 11 May 2022 07:27:47 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 11 May
 2022 02:27:45 -0500
To: <iommu@lists.linux-foundation.org>
Subject: [PATCH v3 22/35] iommu/amd: Update iommu_ignore_device
Date: Wed, 11 May 2022 12:51:28 +0530
Message-ID: <20220511072141.15485-23-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220511072141.15485-1-vasant.hegde@amd.com>
References: <20220511072141.15485-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed3bcef9-727b-4f9d-6c0e-08da331fbf98
X-MS-TrafficTypeDiagnostic: DM5PR12MB1931:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1931EE2519D8AF61ED3C2F8987C89@DM5PR12MB1931.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eg7ehwQ3KLxZ9lJ5Nwh0e16LI86EqF2DSqyOa9cTxKwrj8APa44hqJBPve2adnYYeZeLTA6c7dfXiedCCZQlagg+uEZw7I26KitV98z0/zvEJCpp5UYzSCE6oRqNFe0xoRcWB+uZfEjmcXLafx2mP/cjS2zSDhS2boZzXtTVrUx7iOl9mhFnTuudMC9C0n6AjOUoaVpolVLfSvVpEXCfuBQFHXvW81oGip/3t2KTMCmjt/uY8hNFbUrrm8xPwfGFxC9DA30ZIm80y6qS9ZbDAKZnBGRzBH5xxQRU2N3r9V8+eeQXvFBgO434M56A7e81AHeRy/HfEDn6CjvyX5xBMpsums6U/jy0H/YMYZ52AlKp4MBzx1paA9wYBeLAEfrM3nzXefdSpBIZjuRlqAWuRWuaJ+GaIJkk//4B6LlkQ/cDvORuveA5Ny1L7YWALhYVSJQvvX3jJZqF7oWNtotJEgkJi92+fGwc4kBuz8Yh/8wOznQJUdUeU2TQdfQciSKxZmnpBGKqSvt0Y+Mq2jjeHZHWtKXZ3ooJDQlnlGBa8rD5M8atX7zLkEGmsJikpdvMFG1Z41CsVrLIlcFSRMp4PkRhUfn0Ed84Q+ZabMeAMXIhrZQnxA17XweLVio+Sn+kjBKxCqiSlipWP0hL0cEWS+smgq8NNvFikVbQ8fnZCIrieos5hlP0hkd/4zLr/WtAl1IKAHfVZykcsHn0mrCVEw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(186003)(70206006)(426003)(47076005)(36756003)(82310400005)(16526019)(336012)(8936002)(44832011)(36860700001)(83380400001)(26005)(5660300002)(2616005)(40460700003)(4326008)(8676002)(1076003)(86362001)(508600001)(6916009)(54906003)(7696005)(81166007)(2906002)(6666004)(316002)(356005)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 07:27:47.6849 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed3bcef9-727b-4f9d-6c0e-08da331fbf98
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1931
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
index 678eceb808e9..6223af4ccc22 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -413,15 +413,15 @@ static int iommu_init_device(struct amd_iommu *iommu, struct device *dev)
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
