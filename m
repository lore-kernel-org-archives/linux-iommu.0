Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EBCAC433F5
	for <iommu@archiver.kernel.org>; Tue, 29 Mar 2022 04:45:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D09084169E;
	Tue, 29 Mar 2022 04:45:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id u4mH1J0Fqd2O; Tue, 29 Mar 2022 04:45:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 15CD6415B0;
	Tue, 29 Mar 2022 04:45:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DB1A2C002C;
	Tue, 29 Mar 2022 04:45:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0509FC0012
 for <iommu@lists.linux-foundation.org>; Tue, 29 Mar 2022 04:45:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id ED2C141679
 for <iommu@lists.linux-foundation.org>; Tue, 29 Mar 2022 04:45:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id F8p_kMmnSu5U for <iommu@lists.linux-foundation.org>;
 Tue, 29 Mar 2022 04:45:00 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::624])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BC39E415B0
 for <iommu@lists.linux-foundation.org>; Tue, 29 Mar 2022 04:44:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kKIL+vT9BsrHc7SyqK+OCzDlOaRF6/24ERkzLnDTfZbLCpRixUEHPX6LLasVSq/o6y9Ik7Tv0UOhj2q1AlJOQLRxtEkUf9ch4MoGI01A4taCXDwO82QWU3hi1bx09q8ab3AC8k+MHDi9XBeH6ssbaAf2wzJh6o0ta2cv/LpRyXM0W1C+eDVlgieOM9iw0iAH9KUgluT5WlhgwbxgpIg2NLbHiSNP3t5FVHAorBK6jfnvWtujJLSVhI1TpwXyBBJxVkQRnQQf2N0V3VC7Ea8sq9tkkJ46ToX2f+dMVxhdMfY6IyivMcqCadb7Y5buICs3IlRWR6Xbz8RfToTVfcwzgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9/mDeVmi1pnMSti40oqW7bEIw97OlGi5YGGOdUAyQ00=;
 b=l++GgG9HDzeeyAlD3Cz6nZgckHxO0thxlltfCJd45NjtOX/Nk0/JEnUfg5KltUDB5Coq25tjlukUIvkMuGT9P9JOCdb71JHdQnDmMxh5aO7VI4J13vmzohPsppVIaubJiym4bap4Z9xcmEnO1PquIcjZHap69YhpN9FeyLLfvb3zGZtyHhvIjtEYnsk/W8A062w3GJlhG7T2FCfe8CMmTfXllbiWzkhM4n3us6z8bxvyjdvM3axuziX427wa09S8Dp0pi6s3ZVDpFjZM6V1zFcoRYTBg5q9bx4a+YKEoLAPiY/E2CXQbZvN5FzYc9HuQL70D/puBN8pXVn79RpNL1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/mDeVmi1pnMSti40oqW7bEIw97OlGi5YGGOdUAyQ00=;
 b=KW2yW4jDwqoDZL7EJ5l5wfHu8JHcjChJXQSD0/DvQqMR4O41VCP0m23iZ71sTrL4VBhbCxbFWdNIielmoRKTfTJMSqf3vbpNo3hwl4J7ZIHG1ZQzDYw8QvNG++LKpyAwrmQ2KO/IR7xo7wYbg650x1CxxxU5dIof27O1c4FVmZoCiWvj2e/xcfNyfmIbZxK0Yb/6Plk0Y569OXyiLt4OPqREPPY6Sochgtvx68NrCii8yy8F68UXIvsKL00I17oUOi5hO3Fwm8/8LGrIUjs4tcx9+8kcTxlbgIXQeT49hOuSHvd2JjzvOxvaSPmnueLxgVtKZ50syBv/ODOJ5RZI3Q==
Received: from DM6PR21CA0017.namprd21.prod.outlook.com (2603:10b6:5:174::27)
 by BN9PR12MB5097.namprd12.prod.outlook.com (2603:10b6:408:136::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Tue, 29 Mar
 2022 04:44:56 +0000
Received: from DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:174:cafe::3) by DM6PR21CA0017.outlook.office365.com
 (2603:10b6:5:174::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.15 via Frontend
 Transport; Tue, 29 Mar 2022 04:44:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 DM6NAM11FT022.mail.protection.outlook.com (10.13.172.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5102.17 via Frontend Transport; Tue, 29 Mar 2022 04:44:56 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.32;
 Tue, 29 Mar 2022 04:44:55 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 28 Mar
 2022 21:44:55 -0700
Received: from amhetre.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Mon, 28 Mar 2022 21:44:50 -0700
To: <thierry.reding@gmail.com>, <jonathanh@nvidia.com>, <vdumpa@nvidia.com>,
 <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
 <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux-foundation.org>,
 <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>
Subject: [Patch v1] iommu: arm-smmu: Use arm-smmu-nvidia impl for Tegra234
Date: Tue, 29 Mar 2022 10:14:36 +0530
Message-ID: <20220329044436.27732-1-amhetre@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 08fdd54d-ad79-44a5-8e92-08da113edfb0
X-MS-TrafficTypeDiagnostic: BN9PR12MB5097:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB5097E1F6715C2CEC503122FFCA1E9@BN9PR12MB5097.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ci5RbepwyKtYTD1hvAKunecfQa4kqyBD0oMepp0plaqWJsBQZXa8Bux8sLCeY1hqncGr9W9PNOvxl4EtUu1NeCo2AkOLQWOUiv3PwjMtFUIKhlQlcYrizGcuF480lpJ24Og5Dumopq3JYqIyvdMC0g3mfsSSqMNXSXt24j/s+NOskoBCtqxqXCWcteA5xRzIa4mw9kiwJKTNjDJ9NKCOdWla0hQlvm5cH7T5IFqS6mKUQRHXa/EFE2q2MRN6DGFoOYm5xsTu0R0dWFUCFMrhXqAn7b2NHHKgXyhLi/D9HUNhRPD2QT+Zd7trLMQv/2grIeRTXpLyhBoedbRNa5mzXw4vB2g0TsHuQ0Akr2p5xdK6DVz0PgahHFIHxeJrPdYxTSq7JNqCcLP6Ig9jp7fKA5YVML6lD79PI4Jj8jpRObGIf/D2VlP/xJXaUZimKkZhmWCCoN6OPfec5GH2qc6FdNMavqJUggHc027ZhEAm+fk5YRdB8cymwpq+QBeQod1dPL0vcJCkdC0VjkGklRx5qotZ1WWc6p5khB7JKQGb7VwceKvDMGEiKg8PDpTuObvFFbtis4C6J/IGRedol8W/VMZqtwQHN0otBPcV2g59vTcRrbLMtWY49mRTAy6H4rF4n7jofxE+NPNeASGHwlhYEwMCTzGeJ+3lyIUJj/5S6AztW9KqeW+3Dtpo1A1QeSFmz+VyXmNAzUF7eyiNbQIlAJx178L8EJCyfDIiK3bjH2E=
X-Forefront-Antispam-Report: CIP:12.22.5.234; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:mail.nvidia.com; PTR:InfoNoRecords; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(356005)(54906003)(921005)(81166007)(70206006)(70586007)(508600001)(8676002)(4326008)(316002)(110136005)(86362001)(36756003)(40460700003)(6666004)(5660300002)(82310400004)(107886003)(47076005)(7696005)(36860700001)(26005)(186003)(2616005)(8936002)(1076003)(2906002)(83380400001)(336012)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2022 04:44:56.3631 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08fdd54d-ad79-44a5-8e92-08da113edfb0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[12.22.5.234];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5097
Cc: Snikam@nvidia.com, Ashish Mhetre <amhetre@nvidia.com>,
 mperttunen@nvidia.com
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
From: Ashish Mhetre via iommu <iommu@lists.linux-foundation.org>
Reply-To: Ashish Mhetre <amhetre@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Tegra234 has 2 pairs of ARM MMU-500 instances. Each pair is used
together and should be programmed identically.
Add compatible string of Tegra234 iommu nodes in arm_smmu_impl_init()
so that arm-smmu-nvidia implementation will be used for programming
these SMMU instances.

Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-impl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c b/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
index 2c25cce38060..658f3cc83278 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
@@ -211,7 +211,8 @@ struct arm_smmu_device *arm_smmu_impl_init(struct arm_smmu_device *smmu)
 	if (of_property_read_bool(np, "calxeda,smmu-secure-config-access"))
 		smmu->impl = &calxeda_impl;
 
-	if (of_device_is_compatible(np, "nvidia,tegra194-smmu") ||
+	if (of_device_is_compatible(np, "nvidia,tegra234-smmu") ||
+	    of_device_is_compatible(np, "nvidia,tegra194-smmu") ||
 	    of_device_is_compatible(np, "nvidia,tegra186-smmu"))
 		return nvidia_smmu_impl_init(smmu);
 
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
