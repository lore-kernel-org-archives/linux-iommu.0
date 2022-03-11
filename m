Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C632C433F5
	for <iommu@archiver.kernel.org>; Fri, 11 Mar 2022 09:57:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1C78161201;
	Fri, 11 Mar 2022 09:57:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HBiNwlElru8f; Fri, 11 Mar 2022 09:57:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id CB5F1611D9;
	Fri, 11 Mar 2022 09:57:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9781DC0033;
	Fri, 11 Mar 2022 09:57:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C6F71C000B
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 09:57:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B23D240447
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 09:57:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jq2l21o_X23A for <iommu@lists.linux-foundation.org>;
 Fri, 11 Mar 2022 09:57:29 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e83::61a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AEF85404C9
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 09:57:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lcre631T+OQR+vS/RGLjsyz375mlU9jX5Ja1sps+p2ZOIIa64DkUUZ30f/HmeRdDLNtTr35z1JC44OXR2YkSqWE4M0UEj9fW8Ag6Iv4wKbcDZCeSreGH8t+CcjRvtdwV5BIOj85v/jKyEv48Eoatxyeo7XolwHqWviDcg6hbYIy1AMrTpKE6nJcVJe2L5m/5B5bTRNPNvB2qiQlRvogXOiKWwNBsOx0BUfz0vmPScL1vyJ0FTjP1KIbwfQJEfNw/GR+0aa/Z3Rt6RfjmuPmJL5vKGu+bpCfAob9HokWDNNd2KfBaUWJs/wmQIpz4PsWQiCNEgCauupTPYxGBFKAn/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pj6qfzSVJH0jglAXQ8r6xTN3MCd1XXiK1JCh/tcMHZE=;
 b=oTrfCjxvy6aWNGxZI3rw/k1EfkWNCzr/EozIAaFEgSao1EGS9eniOdktBu1cwDeGaVfZX+lO68KCpqkvnumhL/Tai5wffaYfDJoupYtGpOGGoV3NtEsKc3fGRiVcEM5cg1imB7/PrTU2Z7u6DwgvNfWuGN8IZWCWkYoHje5osgV8HxWz4JIS1NSZ2KfvMDj3gaWkCYQyIJflSsH1PB/oyXQezAyqMLw7nX/E/ajlpGk7B+LICOXXHpP9/GZ6E1gjcrHpUAFQ1CYIVseteFhIAFZQhd/AGhOefzVw8nC7ArYLutx7VWLmSFMSwTjCmrtkqmmHdOaNbpfiXzG8AtKf7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pj6qfzSVJH0jglAXQ8r6xTN3MCd1XXiK1JCh/tcMHZE=;
 b=V1S+Rvso5ETKljWEf5eqdJJtvqGB6I/0H9PjaOPlX3erH3N0ssJOVKwvFQNV23WYtISd+WKx796/gU1CO9/ZYrVkdZv1JKzR0y+fiisQHV39/5UKnmyxfwQRfcVelP604QB8tT0XS8De0Te2F9INfxSRPU3MkAUsEl0Wy/c0a7Q=
Received: from DM6PR12CA0001.namprd12.prod.outlook.com (2603:10b6:5:1c0::14)
 by DM8PR12MB5464.namprd12.prod.outlook.com (2603:10b6:8:3d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15; Fri, 11 Mar
 2022 09:57:27 +0000
Received: from DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1c0:cafe::f7) by DM6PR12CA0001.outlook.office365.com
 (2603:10b6:5:1c0::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.23 via Frontend
 Transport; Fri, 11 Mar 2022 09:57:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT052.mail.protection.outlook.com (10.13.172.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Fri, 11 Mar 2022 09:57:26 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 11 Mar
 2022 03:57:24 -0600
To: <iommu@lists.linux-foundation.org>, <joro@8bytes.org>
Subject: [RFC PATCH 20/36] iommu/amd: Update set_dte_entry and clear_dte_entry
Date: Fri, 11 Mar 2022 15:18:38 +0530
Message-ID: <20220311094854.31595-21-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220311094854.31595-1-vasant.hegde@amd.com>
References: <20220311094854.31595-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4224f5d4-742c-4dcd-13b2-08da03458c6b
X-MS-TrafficTypeDiagnostic: DM8PR12MB5464:EE_
X-Microsoft-Antispam-PRVS: <DM8PR12MB54640459C5DEC8E356EB399C870C9@DM8PR12MB5464.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YexUd2UFBAMDgzKZekAnnGvKq9B+SXW+1KrlQ1YsShHn1bwQu9qMNn+7WUbVlxp85FNCjCTTFybCz0KS79PMFic36HKnwCrGZP83+KF10ZBMYApu/4kqBYp8Rt8gT9JskRWfk+XdqNXJNPa8gRPgO+kNhjUeZbFmgzFqP1Q76FDPJnKgks7xAWKeW6q6tQx1Zf/AyxAiTiY0qwELwg7bP742pqBQS87HB/5cnOPpvlJaOUtw9jsff3NMf93bQ2uI4vNRXF/AySVKKtPgS60X08oJw+y9i4vjpQIRxlZufBvbH8jGbXbvJQfTyr9P7PyTVFohPQuthUYtVa8c75LWoQss0WBl0WIhvn2596EzBXa+pyFEnpwk05U3qrBzHqVJ6bht94KDYtpDgRPNIX1BgeFmgaqwr7F9YQkw8x69oaz1jybEFCHLPGIfIlomUsz0idCoKdo47vs2vRKsG5FRpALMQj5isTjPhYHcEeIsM8R1feK0Sc7NVYsBp1y/ugSTOpqJn1/66MYdAISXkm1BkQzNgr8ggaP23CSdOhM8W8J/zKCPSWPVsiykWeEWpKp+jjEhWTd436Woch9rszLuc+PnIaNTjItYgc00xrAbjjK1/6Zzxdeh/Jlk1wctEehWN6Di/OxchESPwxEDFyJ3ENaLkXi6WSdljHwkPvlkqzZ2/numEmf4cC2e0Ca0v2G+7DXX1+eu4yl/h8plSvpj6g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(6666004)(2616005)(8936002)(4326008)(8676002)(508600001)(5660300002)(2906002)(83380400001)(86362001)(1076003)(36756003)(26005)(70586007)(316002)(15650500001)(186003)(36860700001)(16526019)(110136005)(44832011)(54906003)(81166007)(426003)(47076005)(336012)(356005)(40460700003)(82310400004)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2022 09:57:26.8863 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4224f5d4-742c-4dcd-13b2-08da03458c6b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5464
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
index f6547d888899..c467ecc44548 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1531,6 +1531,7 @@ static void set_dte_entry(struct amd_iommu *iommu, u16 devid,
 	u64 pte_root = 0;
 	u64 flags = 0;
 	u32 old_domid;
+	struct dev_table_entry *dev_table = get_dev_table(iommu);
 
 	if (domain->iop.mode != PAGE_MODE_NONE)
 		pte_root = iommu_virt_to_phys(domain->iop.root);
@@ -1539,7 +1540,7 @@ static void set_dte_entry(struct amd_iommu *iommu, u16 devid,
 		    << DEV_ENTRY_MODE_SHIFT;
 	pte_root |= DTE_FLAG_IR | DTE_FLAG_IW | DTE_FLAG_V | DTE_FLAG_TV;
 
-	flags = amd_iommu_dev_table[devid].data[1];
+	flags = dev_table[devid].data[1];
 
 	if (ats)
 		flags |= DTE_FLAG_IOTLB;
@@ -1578,9 +1579,9 @@ static void set_dte_entry(struct amd_iommu *iommu, u16 devid,
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
@@ -1592,11 +1593,13 @@ static void set_dte_entry(struct amd_iommu *iommu, u16 devid,
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
@@ -1640,7 +1643,7 @@ static void do_detach(struct iommu_dev_data *dev_data)
 	/* Update data structures */
 	dev_data->domain = NULL;
 	list_del(&dev_data->list);
-	clear_dte_entry(dev_data->devid);
+	clear_dte_entry(iommu, dev_data->devid);
 	clone_aliases(iommu, dev_data->pdev);
 
 	/* Flush the DTE entry */
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
