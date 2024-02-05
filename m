Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40AB1AAB1
	for <iommu@lists.linux.dev>; Mon,  5 Feb 2024 11:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707134273; cv=fail; b=HvIT3ETxfBeYu917nJiAAE2ocGk3UqCvlFC1noNdKWjeSyP2P3gMbpqkteM9OyWJSu9dk9AMRtwqz29H2jH62O6JLg8107l3MqLk+RbjgPfcCgG6B/O+R8q003hhJFhFJ9EsHbEn0UPsYgY92iLfRAAQtuUxW1eD5jRuGbCYXBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707134273; c=relaxed/simple;
	bh=YWIkeZqTK6BJ/juANmKaYJqGHZPhdKa59RU3JwXJKwY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XUc6c/SN9XCB7P+uHy9k/1DVzz95X3On8sahiYj9LdUbcUTkdo7PudI6st0a3MssBnEub/H3DwrULxuKOXAgjb3WfyxEebPAffvTp/0offRQmwhBIaO6aDXjE3OOASf8Xt39pIYAIdkIBew7XXNJqikp+jwXS/BHWdYd/hFu6CU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=x0QH/vQe; arc=fail smtp.client-ip=40.107.94.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="x0QH/vQe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iyqmNMX1OD8pOsMXrqe70E1WAEiEtb/TLkSnTppEtEWNXFgV2xvf+dxJ7NtPGXbBygPWfMkBKatf/BftmNlorioTqmMDT6o96bTjToavzYdZYUTCnLK+K0bWFneZHhDu0Em/6+QNeLCYDIHBoCkVSkMdD59BI/syzyCOiHRHHA9IOKveFIaORFapPF6QCi4FQoZEk0JXPGmAXs6ovYbhkNc6BCxQ+9kms5b/b9UuVuFbdadiNdyfvB+HQP2jk7loxUoFSSyPjDSskC/z0vpFDoefC/XLsLyK3UV43IXj2X96kIjnf4Yp3lzROH31eNiqwwu/krOsFNO73P2VLTxbIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9mMz7p6iN3VHLFMVi5BbPOpSkqlShqqEkgB3plSikdw=;
 b=ocQ311L/yu1B2Ql9M1w+wSkgkd/1uYYv2XFAuAXsgQ86+pKtXpqRMqqnYMEBi6hV/lbykYmJAbTEu/Oh+5kk/pkeCFb1732h3HSvqkvd98+TrpeGIQ0v6pqogEQkVC3zvn7I94i501+604N+7hRZY9zqMufvrQViU6Q9FYDD2hNDqp4IPBNA+KZ3ozmq6oR4BxgvnqcRUelfqXnSYVQq/jaa0gFe0AMCkV8wV2csPqbYog952Lj8FcSNKoIjmuMZiV7G61A+thHfC0tosshq/tetVTr7nyap8UhRLYVeHVWQ0aNtXUxH1F/4Np+jCuCQgdH/Yvjuh8iObp1emo3Vlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9mMz7p6iN3VHLFMVi5BbPOpSkqlShqqEkgB3plSikdw=;
 b=x0QH/vQekjgmliUFq6u7Zp33pWok16a6XSS2KKBTMsBNfwUyw3H9VQyPKUQYRw0GDHOpB8Hh6OX2dyyh4X/0mTVc0QYHafOSd3JKDK9Md7xXhl0l30VQO1T33pclMWg6CDPzP8ueVNZAnCUaeTpT43ITgSGCM1d7NFpAJYXqvfM=
Received: from DS0PR17CA0024.namprd17.prod.outlook.com (2603:10b6:8:191::29)
 by LV2PR12MB5917.namprd12.prod.outlook.com (2603:10b6:408:175::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.15; Mon, 5 Feb
 2024 11:57:46 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:8:191:cafe::f9) by DS0PR17CA0024.outlook.office365.com
 (2603:10b6:8:191::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34 via Frontend
 Transport; Mon, 5 Feb 2024 11:57:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Mon, 5 Feb 2024 11:57:46 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 5 Feb
 2024 05:57:42 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v7 02/17] iommu/amd: Enable Guest Translation before registering devices
Date: Mon, 5 Feb 2024 11:56:00 +0000
Message-ID: <20240205115615.6053-3-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240205115615.6053-1-vasant.hegde@amd.com>
References: <20240205115615.6053-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|LV2PR12MB5917:EE_
X-MS-Office365-Filtering-Correlation-Id: 86d6a27d-f37e-4a3a-98b6-08dc2641ab1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zS7xU2Hv5gnEPpguwE9efHB61kWvb3SpDaQaopJkliT9YRdTuZTGwELqqDJBVzcRQHKJRz5P2W3zvUVSGmDyKq65il5kMOIon5OzTlUMUOJsF7X87suFbBnub7ePTYGHXm+kkK7p5ou1urga8EfjHzQcgBasZ1ca+U/1nBs5x6JiFY8P/hwdTGsgXi1GgDFNJ7noDlewddtm4kr5UeDjZN2DC615iag8ac0ApWwnKpS0MG/clmn/XYUjIrnS/B5PLrqfAR5zYDEssQ0S6c1CoW0m/yxh9ivS8XG3i1anT3i+B2eBRzOeaRHlC1ELle2cPR+PEgqOjQR4gOWWffOxEH8NBy1djVSLZpG6yUgZy/hHzppQBKcGrvkIoOk3+eoasAC7fKraXEwMKqUK5v7W2OQXGGW/iSmXzIkwSVEe5PN+81yBvcLoB0lQn6iqP4v/5FbpLul+NN83+N76fGzRgqkHgg+E3ODhZRnsCj5NsPz1EMyCk5IwqbLSKCtWfsxTzZ2qybw0+AtXMkmbPl6v9dKDasuL2bxenT9/TSEc+XArdQ3PlOZG6mHdkyDjJDLV4UnIsRynNc6whoBkBRWfgdZK8YwHVKoYd6hTdK0SYHLvl5Hy7QuPbeXBCiVN6RNT75CeYw6pLptSRx0+V8xnzBD9eM/M4gKlOHxaR9+BEt0dY/xRpWcqBCO1uDtYyN5fDiNAZsjQk/W5+tHfTlSuzl0C4fX+A2YRvrl9EGaOnvINj9pvvkkpcpxy0NJ1y7wuV8Z8NrW09D5oMUuQfIbZRQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(346002)(136003)(39860400002)(230922051799003)(82310400011)(64100799003)(1800799012)(451199024)(186009)(46966006)(36840700001)(40470700004)(36756003)(40460700003)(40480700001)(478600001)(1076003)(336012)(81166007)(41300700001)(356005)(82740400003)(426003)(47076005)(26005)(16526019)(2616005)(83380400001)(70206006)(7696005)(2906002)(5660300002)(4326008)(6666004)(44832011)(54906003)(110136005)(70586007)(36860700001)(86362001)(316002)(8676002)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 11:57:46.3113
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86d6a27d-f37e-4a3a-98b6-08dc2641ab1a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5917

IOMMU Guest Translation (GT) feature needs to be enabled before
invalidating guest translations (CMD_INV_IOMMU_PAGES with GN=1).

Currently GT feature is enabled after setting up interrupt handler.
So far it was fine as we were not invalidating guest page table
before this point.

Upcoming series will introduce per device GCR3 table and it will
invalidate guest pages after configuring. Hence move GT feature
enablement to early_enable_iommu().

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/init.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index c83bd0c2a1c9..959820ccfbcc 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -2769,6 +2769,7 @@ static void early_enable_iommu(struct amd_iommu *iommu)
 	iommu_enable_command_buffer(iommu);
 	iommu_enable_event_buffer(iommu);
 	iommu_set_exclusion_range(iommu);
+	iommu_enable_gt(iommu);
 	iommu_enable_ga(iommu);
 	iommu_enable_xt(iommu);
 	iommu_enable_irtcachedis(iommu);
@@ -2825,6 +2826,7 @@ static void early_enable_iommus(void)
 			iommu_disable_irtcachedis(iommu);
 			iommu_enable_command_buffer(iommu);
 			iommu_enable_event_buffer(iommu);
+			iommu_enable_gt(iommu);
 			iommu_enable_ga(iommu);
 			iommu_enable_xt(iommu);
 			iommu_enable_irtcachedis(iommu);
@@ -2838,10 +2840,8 @@ static void enable_iommus_v2(void)
 {
 	struct amd_iommu *iommu;
 
-	for_each_iommu(iommu) {
+	for_each_iommu(iommu)
 		iommu_enable_ppr_log(iommu);
-		iommu_enable_gt(iommu);
-	}
 }
 
 static void enable_iommus_vapic(void)
-- 
2.31.1

