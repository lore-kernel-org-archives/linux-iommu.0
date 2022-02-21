Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7606CC4321E
	for <iommu@archiver.kernel.org>; Mon, 21 Feb 2022 10:54:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D7EF960AC3;
	Mon, 21 Feb 2022 10:54:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Xzh0nNjU8CCo; Mon, 21 Feb 2022 10:54:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id AE7F460E37;
	Mon, 21 Feb 2022 10:54:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 78173C0080;
	Mon, 21 Feb 2022 10:54:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3C56AC0011
 for <iommu@lists.linux-foundation.org>; Mon, 21 Feb 2022 05:00:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2B36960B44
 for <iommu@lists.linux-foundation.org>; Mon, 21 Feb 2022 05:00:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BrWsnFUFcxlR for <iommu@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 05:00:39 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::60d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 52B5260AD1
 for <iommu@lists.linux-foundation.org>; Mon, 21 Feb 2022 05:00:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jbVQM3+MN3mD1LZQgN0HYXr17zQ8NG/Asi1vVS0I18oyvjxplSstgmbgxn6vmi9yD2j4hUyvBfas7Obn/d9kdDfj+K0MLao3jTuffN3JNRpCBehKA+VC8veVRTXacyYdqy/BCPMLwRIc1hBT+To/2re1jdm/fbj8EmFPl64LCsN5l214zbVSlmmLhB+0tHz+kfHuDq0zB3QNw+x8HUnxOaehEhGto15CZCYJEri/eL6Fbxvz9OWKpCfX/yZGqChWCi2aGi9MIL/F3aX5dwNoLzvt7jtyqCLy3KbgVgzwZSUFr47uArNYljPKMmmWyCqOg23SzDMJKFS59W6Z94u+WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8mH5QxhbeGRYhT2c0GWcYkoV1P670QnpOhhmtHOGyws=;
 b=dmfgfuwG94tovjjBbOT+jr+psuY03yqLZY3Wn+UVWSdMW6A/1W5P9naRVcrIoglaybt5xwU1ug00ndOtU9YxUpr+eFkIMko4ABpMySqEYVSyKPZFiXvWwK9wK2CgF2Oso+22lqcXDVSZ6xMusL4VhIM19GWfxowkG3jZ0XnPFrdpWVNRTt6SIM0LZkcn+DNNBgUOJg/kFNx9OIuFH8jso5LI8+HCcri4Ftcv6EOO6FOKO7XHeuctH+Qs03knyIWB6sv337aXOaYJvzhEBjY910aOl4qOYtGoX6VQLdBOGn9tklK/7RnDCDD9S+CwLH2OcyHP9B1i1Y7dGAYCvxrGJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8mH5QxhbeGRYhT2c0GWcYkoV1P670QnpOhhmtHOGyws=;
 b=TTZKtyla52WcFy0Y2JNGuNw+5Qf+OOL7nI8+2IMNKmltKGwLbVveT3whpDZGXOV/LwN4h+psoHigjIrRFwmMoqbmY2BNkQpj1Edm+QZmuCzTbGdv/PQlrXK3FxbRoDI6dB1CPJWWAxafIyhy+eAe3u2AHN/77o4R9blsJm36SR4=
Received: from BN9PR03CA0169.namprd03.prod.outlook.com (2603:10b6:408:f4::24)
 by BL1PR12MB5206.namprd12.prod.outlook.com (2603:10b6:208:31c::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Mon, 21 Feb
 2022 05:00:35 +0000
Received: from BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f4:cafe::e1) by BN9PR03CA0169.outlook.office365.com
 (2603:10b6:408:f4::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.15 via Frontend
 Transport; Mon, 21 Feb 2022 05:00:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT064.mail.protection.outlook.com (10.13.176.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Mon, 21 Feb 2022 05:00:35 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sun, 20 Feb
 2022 23:00:32 -0600
To: <joro@8bytes.org>, <iommu@lists.linux-foundation.org>
Subject: [PATCH 4/5] iommu/amd: Remove unused struct fault.devid
Date: Mon, 21 Feb 2022 10:29:15 +0530
Message-ID: <20220221045916.19701-5-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220221045916.19701-1-vasant.hegde@amd.com>
References: <20220221045916.19701-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 766c261d-8399-4c6c-ce7d-08d9f4f71865
X-MS-TrafficTypeDiagnostic: BL1PR12MB5206:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB520625629035166314B59ECA873A9@BL1PR12MB5206.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JBuTbF16lsN1WIVkgQsjfU62f/IciNNtoWLbOioiJPt9kdgoHQia61OltRpl51e6pXQVHpZSWsCcbsA6PS9dEXicuKvD1PaswqQhuM0TlaSNcb+CpJydVx6Q+POM0fCK5kuO9Vbr3qZW040tI0XOPnJ79hBQJl42vRNh0PnvG9P6Koo/n87vY9ToFsVeKD0vKEULLo+R14AMF2rUo3A+UcLfTbEBIgif5qW9ty39ZEMWL9OJKOuNENApEzAFmi6HujaF/Amhh5Tq90MeBCWZptLW3/J8HHtBHg0HV+DJD7/LAyQgbv/I5tpzcusAwPK6dg77wZhv83yqjYzrNCtVWtwKjHUJC82tXcovULbwQcXTeHSesZQH5Hj6go0I03wyoj29wbKWsc55cm/OqOc507PCGYN0Xu5NLEh33SCBN+TfD0+zweqAO0ppY9kZi2OVHHsWvCcizxSPiulEgcTyNAqQILRvFv+qSsXVzZ+KSLm8Z2N5zyc6zG/3c1qULFcOZyM7XSi+cHr8hfabwIsqINfOJnnsdRui5q+aUfPwmToK2T0OOMm5SgeiULPLNlEc6ai1lz/UVuqD3ezxg33xZnP0XSaEtAfVuo7nv+Hk+S1KCH7Ofp5IVb/v2z8J6M7l/3c/hp0Kzqt0OgnLAcjcCM9OYfTWfCie5l3WRtl2ytIpubuoWz3Xiwp+/H+c6SAkcSZInS1n0b7tf5BAEvpDqHTQM++FkJLfu9Q3j/4mTaAss3eb0pDh0TIT4IvdRRf4
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(16526019)(70206006)(186003)(8676002)(426003)(36860700001)(4326008)(36756003)(70586007)(336012)(26005)(6666004)(47076005)(8936002)(1076003)(508600001)(356005)(5660300002)(316002)(81166007)(2616005)(86362001)(44832011)(83380400001)(40460700003)(4744005)(54906003)(110136005)(2906002)(82310400004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2022 05:00:35.2279 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 766c261d-8399-4c6c-ce7d-08d9f4f71865
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5206
X-Mailman-Approved-At: Mon, 21 Feb 2022 10:54:02 +0000
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

This variable has not been used since it was introduced.

Co-developed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu_v2.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iommu/amd/iommu_v2.c b/drivers/iommu/amd/iommu_v2.c
index 58da08cc3d01..2daf37c21b85 100644
--- a/drivers/iommu/amd/iommu_v2.c
+++ b/drivers/iommu/amd/iommu_v2.c
@@ -71,7 +71,6 @@ struct fault {
 	struct pasid_state *state;
 	struct mm_struct *mm;
 	u64 address;
-	u16 devid;
 	u32 pasid;
 	u16 tag;
 	u16 finish;
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
