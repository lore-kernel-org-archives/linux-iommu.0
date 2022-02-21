Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E0F4C433FE
	for <iommu@archiver.kernel.org>; Mon, 21 Feb 2022 10:54:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 96C56817AD;
	Mon, 21 Feb 2022 10:54:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id E6VkzDbkkv8H; Mon, 21 Feb 2022 10:54:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 650FA81395;
	Mon, 21 Feb 2022 10:54:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D6B64C0037;
	Mon, 21 Feb 2022 10:54:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 075C8C0011
 for <iommu@lists.linux-foundation.org>; Mon, 21 Feb 2022 04:59:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DCE8760B44
 for <iommu@lists.linux-foundation.org>; Mon, 21 Feb 2022 04:59:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OTeBhT7OBrKs for <iommu@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 04:59:53 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::607])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3796D60AD1
 for <iommu@lists.linux-foundation.org>; Mon, 21 Feb 2022 04:59:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KxrWtQ0+S0mJqTavfeVzqAXGODtFTvrf33xwLEn5oii8G3gLciCGLkhL4RlMZhMlWMqWvxtZuLLnheimNWVIWK9I10T75WKw2zsiy60pbMJmxizWoyklQrFZhnSf6s2HXu7HEjh4KwhmpaqFQiQbdzV8OqT3QNDqHl+V8h7bsQQwpi78U6d6DDRKMoOCXmdvj8NzM9GxpHQtRG6pRJUDjSHbd6qe5TtovAhtfEKCaeZJgHNPAVVV59WIve9hbcNpw+j2MRCjYZ6j3Q+bswdCoj4YgddQphvL7hQL+MEBzHINW1KTEHeve3LZ/6cbknxjqSz1hbEF4ggXO7A9OSHHcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X9rxhMUUgkNpROs9Xkv7htM0ru3G78/JBIcRe8mhWF0=;
 b=HHMh/q4pnSKrL2RS3vDRzfDdR0ZpvM9IQfGGx0HInUu9Hc8qxF9v9zhgnD2m22cA5wvT8yR0I5pab2koDQtNNf/8+6zpCHh8/NqboBu58rp6y1DWjSyXneyN06QFuLSLQFIEnST/HZFZBnZVlCMMTqgUa64BktQBjbcUUAdwc0ucRh0j17Q5h3hdgx4hUMokgqoOlIw7INwidT7+wVyKwGnse+t1y/XXARzBy/yHLgZFPwk4Or7VEBY+twnd4Qb1R32wgnyMNETHMigj2tdjuZ4Jd/T2zTpdn6RrsCS8cXs3fIf/tEDbzYKQDERmeNbBSVi+N4SdDSJdnG7xZllIbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X9rxhMUUgkNpROs9Xkv7htM0ru3G78/JBIcRe8mhWF0=;
 b=Vljx8oVPgCHUj+VbPsusrvsrhamrQRFav1SWKDxB8DnFYcIGazUnh19bk1rLXqn5zuOLTto2UDL951t6RbXjme/V4GX4h7NTFNUkNqZoZQEhe+0XYGYEo+HSlM/EhJJlk2oTf7wXokalr4i8O+8mKdK6KxYjDQUz44sMgGVnIhg=
Received: from BN6PR16CA0045.namprd16.prod.outlook.com (2603:10b6:405:14::31)
 by BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Mon, 21 Feb
 2022 04:59:49 +0000
Received: from BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:14:cafe::f0) by BN6PR16CA0045.outlook.office365.com
 (2603:10b6:405:14::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24 via Frontend
 Transport; Mon, 21 Feb 2022 04:59:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT053.mail.protection.outlook.com (10.13.177.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Mon, 21 Feb 2022 04:59:48 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sun, 20 Feb
 2022 22:59:46 -0600
To: <joro@8bytes.org>, <iommu@lists.linux-foundation.org>
Subject: [PATCH 1/5] iommu/amd: Improve error handling for amd_iommu_init_pci
Date: Mon, 21 Feb 2022 10:29:12 +0530
Message-ID: <20220221045916.19701-2-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220221045916.19701-1-vasant.hegde@amd.com>
References: <20220221045916.19701-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c982e80a-8b16-4a6b-bdf6-08d9f4f6fcc7
X-MS-TrafficTypeDiagnostic: BN9PR12MB5257:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB52574F75353E53D979856FAA873A9@BN9PR12MB5257.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8xAlsR6KsqJXtK3hexwFOIYqqvcpJxUpsq3T0RNirziM3uhfa9s9FQVBjSW2IAPLP5bEQkmsDjzGa9z6Q85Eiix/BDcrw+Q1iiN1bS4BfEQdEKBVxRxtx/Oz9Dpa0gauTQK6Kue2S77bW8us3lGG+gZcOK0HHoJKrTT6gRIHYAZ6iKku5n8ACI7v+UXq/H8vccqaaPwL/ecItcOyg5dg0mSwKCYHpUlPBH7ph+W0v3QqC1QiA+7MMNrJFF++A1/HQ5GecpkR5MNqJqU7WiQ2Oo5UKfh1SI/rrMl4NkUliXT+s3s4COIv/Z5Lvxoh9LJRPqdnsJBU4k2almwTuOCU+Z2XFxXyEQYuUrXaKqwHANlllRMmN3wyygbVR19fYb0SXNLWsWQg7tBlWawWHetDm1eDXNngMXxC9Ubef6SZpQQicT9un+eofYVryqAp6+SwMT2aU8uM9heYCC6ZRb50h09T2asEJADMdrRknUYYTxT1JtiwdNQkNDBHIC36zeJL/b3tNDDp7a8gh85kCl/jdVpGJ8q8mZc+krFkfFmYuf2h+tCIV2TOmvA5XBcPn+w7uJLCV+wDsEgRlRiDYOrB6l11etz/VJBT0JSH57sj6wjk/ldRTMbw0HiNVtZdTIJWcJ8lrWsK6DCEi5xq4VY9FnOe63JXvGFcpa5HEGrdahKDQapwJ3jcZxw2Wc3zYWOuvNctyTizvKgLTNRXLim33g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(86362001)(81166007)(186003)(26005)(40460700003)(44832011)(2906002)(6666004)(356005)(36860700001)(47076005)(36756003)(16526019)(426003)(336012)(316002)(508600001)(54906003)(70586007)(8676002)(4326008)(70206006)(8936002)(1076003)(2616005)(5660300002)(82310400004)(83380400001)(110136005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2022 04:59:48.5654 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c982e80a-8b16-4a6b-bdf6-08d9f4f6fcc7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5257
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

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Add error messages to prevent silent failure.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/init.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 1eacd43cb436..770ac679b682 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1942,9 +1942,10 @@ static int __init amd_iommu_init_pci(void)
 
 	for_each_iommu(iommu) {
 		ret = iommu_init_pci(iommu);
-		if (ret)
-			break;
-
+		if (ret) {
+			pr_err("IOMMU:%d Failed to initialize!\n", iommu->index);
+			goto out;
+		}
 		/* Need to setup range after PCI init */
 		iommu_set_cwwb_range(iommu);
 	}
@@ -1960,6 +1961,10 @@ static int __init amd_iommu_init_pci(void)
 	 * active.
 	 */
 	ret = amd_iommu_init_api();
+	if (ret) {
+		pr_err("IOMMU: Failed to initialize api!\n");
+		goto out;
+	}
 
 	init_device_table_dma();
 
@@ -1969,6 +1974,7 @@ static int __init amd_iommu_init_pci(void)
 	if (!ret)
 		print_iommu_info();
 
+out:
 	return ret;
 }
 
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
