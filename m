Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 051EBC433EF
	for <iommu@archiver.kernel.org>; Mon, 13 Jun 2022 01:25:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8AAC282DE6;
	Mon, 13 Jun 2022 01:25:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id K4FJcuQdM24S; Mon, 13 Jun 2022 01:25:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5D35783032;
	Mon, 13 Jun 2022 01:25:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1CC75C0082;
	Mon, 13 Jun 2022 01:25:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7EC8DC002D
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jun 2022 01:25:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 601FA83022
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jun 2022 01:25:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QpQAkg4LWjy8 for <iommu@lists.linux-foundation.org>;
 Mon, 13 Jun 2022 01:25:34 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on20609.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8b::609])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9675082DE6
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jun 2022 01:25:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mmxapqFjoNXg9VIOWSk8eEtQQ/pnkpF+l50xCUPAqnMNo2lHCUBUVZCo/D2AxaUlGhTpgtngiwxCYMmRAKCzy52TZGYzeBNjDXJC8UrFDkhQQIYhDkeupqDM8UYEruChOy+sYS849Uec37LPxfIPgi5tDii2unmDJ3FhLRC7hqnqyYcS8jpAHyt/LMB/RKZcXBHqcdJjz/WVmf5IP6hfLM5rkJYwYCD4AmdY16UhVmN/qk6CeLKVWOn4YzbAKjYpX54GK2qdAp6Up5MVDMwI2ymJKBfS1KF4aOK9iTAGMggZ1vMbfh4zLvgjn6d6lbz0U0p1A7lxmDTvxkm9MDYVqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bUw9RNpDl65AFZ3Qsgqhtvm9+1bYJUp29uumqHFqlEw=;
 b=aqHidQ8UaAMjMlvm4pyHiQFj2KxjSJ7e5NaZlEuQWEySdts7SBTlf2Iu18nfrd5HZIkyUyTz9cg89bK89pBhDE59dYGL7sG5fEu7aWVYpoO2i7vsc6BwuyP2lzLuvuZ2679r61nE6NaW4qF/hqHDw7H5RDssz+h4tgYDK5EYUAJheKhQDV900gEFms/qcPZ6YmSfqwOaxZH6dEt6Y8vgw/vweqSeePyg5GGAX1riUWgo0Sm6XX4fvMQRuxcTUVYrVi2+YyyYoQpniZVL0vd6kMJCoJDHHM7YCzlARd0YuJMk9ymCFWFwg2S0VTaMvog/5HXFoufg82EA4k74h/Wuhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bUw9RNpDl65AFZ3Qsgqhtvm9+1bYJUp29uumqHFqlEw=;
 b=kL5w/QcergDcn77I/KD67iqj+DZgSwR6Mx522NFYJ2ZW7/Dl1L7YF+I0g0hUznzV+lSGncka1mBNN9OQ8jwrLN1pTH2Vly3kiSTLVoTJ+NvjdTGke4UmCRS64iQUrc5a6TUg8o/3hpeHf5E7rkYh6g/h5FMaQdYuW+xgOTjRYK4=
Received: from MW4PR03CA0275.namprd03.prod.outlook.com (2603:10b6:303:b5::10)
 by SA0PR12MB4494.namprd12.prod.outlook.com (2603:10b6:806:94::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Mon, 13 Jun
 2022 01:25:32 +0000
Received: from CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::b6) by MW4PR03CA0275.outlook.office365.com
 (2603:10b6:303:b5::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13 via Frontend
 Transport; Mon, 13 Jun 2022 01:25:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT013.mail.protection.outlook.com (10.13.174.227) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Mon, 13 Jun 2022 01:25:31 +0000
Received: from sp5-759chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Sun, 12 Jun
 2022 20:25:21 -0500
To: <iommu@lists.linux-foundation.org>
Subject: [PATCH 5/7] iommu: Add domain_type_supported() callback in iommu_ops
Date: Sun, 12 Jun 2022 20:25:00 -0500
Message-ID: <20220613012502.109918-6-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220613012502.109918-1-suravee.suthikulpanit@amd.com>
References: <20220613012502.109918-1-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4976fd70-a617-46e5-112f-08da4cdb9b84
X-MS-TrafficTypeDiagnostic: SA0PR12MB4494:EE_
X-Microsoft-Antispam-PRVS: <SA0PR12MB449495FB71787C1E69ACAC24F3AB9@SA0PR12MB4494.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /YvGtSBfGa7ZFQILTKcpqY3cMr/N45dLImgsDmm/vq+XwDi20jfwff6pw0MUJU89zrsisC/W2ll2WyLLjv58xltW7Rzr4L78EvmKCO/2cahpwR5yHq8z50zhDS98CBFHGDbtVubk+tKiv3+XqUeVdyJC1gooYC7NrFW8S8BcudnBUfIqTVHRrr2kZzqXEMaaidwMwBYKDE6uouGN4khgJ9WLqNqBrokvKCa+g5ANnPt8512HlMFpt+cYUE/PTLRyqZz7wD+V1n2Hf5Gd7BaHAgKkas1bYMGJwfgl7wL9EbrErkgVPl85uhhOPLRsc/1GmI2JB9tcmQA2Z2KE6LNKNWLRXJibkHe2cctK+fZ3YU/e+GLCc40lKsQIqEntnTFi6g2z/rukrcz/NFibq9MAIhn98JOQKRycES6O5qvbfKEs7Ow8HgA3ryRp+h+ePnzmt1O7BnmzijpeF5RjC7QmC5mfq+bRCeD1IxqdSUO+/02pA4cS5jpeO4GP3TDvWO302o1Q8LCmWwbn8PrRZqO5Q45M87BFj03pCIHq9zSoLePvtGOcHzoTQcO7HIvPPmXKo5bXtvDqgk3j0hm2rG+utrKk5idJDJBUJSdIeqqJZUeeldVCo/DjvDjhYPsmLh6pJ87EbhySJAjPmbVib8NER8EvLBccsn8996XF44+GoxkVh4Pttt8DM5VZVZUcOr5iIpScyNZD3Qskx+S0NaYSaw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(36840700001)(46966006)(40470700004)(16526019)(316002)(1076003)(186003)(7696005)(2906002)(81166007)(44832011)(8676002)(2616005)(47076005)(70586007)(26005)(5660300002)(86362001)(6666004)(70206006)(8936002)(36860700001)(356005)(83380400001)(426003)(336012)(6916009)(40460700003)(82310400005)(4326008)(36756003)(54906003)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2022 01:25:31.5144 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4976fd70-a617-46e5-112f-08da4cdb9b84
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4494
Cc: robin.murphy@arm.com, ashish.kalra@amd.com, vasant.hegde@amd.com
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

When user requests to change IOMMU domain to a new type, IOMMU generic
layer checks the requested type against the default domain type returned
by vendor-specific IOMMU driver.

However, there is only one default domain type, and current mechanism
does not allow if the requested type does not match the default type.

Introducing check_domain_type_supported() callback in iommu_ops,
which allows IOMMU generic layer to check with vendor-specific IOMMU driver
whether the requested type is supported. This allows user to request
types other than the default type.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/iommu.c | 13 ++++++++++++-
 include/linux/iommu.h |  2 ++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index f2c45b85b9fc..4afb956ce083 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1521,6 +1521,16 @@ struct iommu_group *fsl_mc_device_group(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(fsl_mc_device_group);
 
+static bool iommu_domain_type_supported(struct device *dev, int type)
+{
+	const struct iommu_ops *ops = dev_iommu_ops(dev);
+
+	if (ops->domain_type_supported)
+		return ops->domain_type_supported(dev, type);
+
+	return true;
+}
+
 static int iommu_get_def_domain_type(struct device *dev)
 {
 	const struct iommu_ops *ops = dev_iommu_ops(dev);
@@ -2937,7 +2947,8 @@ static int iommu_change_dev_def_domain(struct iommu_group *group,
 		 * domain the device was booted with
 		 */
 		type = dev_def_dom ? : iommu_def_domain_type;
-	} else if (dev_def_dom && type != dev_def_dom) {
+	} else if (!iommu_domain_type_supported(dev, type) ||
+		   (dev_def_dom && type != dev_def_dom)) {
 		dev_err_ratelimited(prev_dev, "Device cannot be in %s domain\n",
 				    iommu_domain_type_str(type));
 		ret = -EINVAL;
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index fecb72e1b11b..40c47ab15005 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -214,6 +214,7 @@ struct iommu_iotlb_gather {
  *		- IOMMU_DOMAIN_IDENTITY: must use an identity domain
  *		- IOMMU_DOMAIN_DMA: must use a dma domain
  *		- 0: use the default setting
+ * @domain_type_supported: check if the specified domain type is supported
  * @default_domain_ops: the default ops for domains
  * @pgsize_bitmap: bitmap of all possible supported page sizes
  * @owner: Driver module providing these ops
@@ -252,6 +253,7 @@ struct iommu_ops {
 			     struct iommu_page_response *msg);
 
 	int (*def_domain_type)(struct device *dev);
+	bool (*domain_type_supported)(struct device *dev, int type);
 
 	const struct iommu_domain_ops *default_domain_ops;
 	unsigned long pgsize_bitmap;
-- 
2.32.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
