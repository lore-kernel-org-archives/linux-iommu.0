Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695BB171CD
	for <iommu@lists.linux.dev>; Thu,  1 Aug 2024 03:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722483300; cv=fail; b=gWTf4Wu15EM3kg+nl10sA38TAami0SKBnNYrrYwXE0AyPLZbneJxQj8zSsAX1OKGsaHRg/uPKUIKUnFawGyp5guA8U832EhwIOLLA1hyY8pJ8TLuC2SjxtQRJrGRJW09vUkGfxEcEAfmnRE084M5SvCCHdE5w5tQI+SYCT//vZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722483300; c=relaxed/simple;
	bh=jDNmRwOTHblC5WHvyK1XQ9RCaX4kSnUSOsckzwPD9c0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RyCE6C/S6MvJqZRdHELEsk1UMoJyax5k1aDMuwLvkmUl9X4bZ59obUQQA+9QAbltiLyCcTEfvvGLA0YF3XUkeBFZDJLwlYzIlycemXvm84/SPs/6Bjbf7cUZZ/yNfM9+qmxJvHtN+IM2LLEJupb3C3C2NUoAvrtvSQTLFV1HTbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mURWs+ep; arc=fail smtp.client-ip=40.107.223.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mURWs+ep"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZgDILRUl2FjQqLpFuPPmwz2urB6NzmdJjFg60Om6c8hUA7Q9h2QfyLTsDadA2PLhJvEnzgXHpvdRDnWL0JDcaz79NaqkBkhCvPaDst6i4MTIfDMkdR9JbaCzMINpNhKTjDPomOEKx5RD6xHcdA8M7ub8gTHpCwVwJwEOd1/7+x0LTD6+S4NnOhCPNlBtLYyZZgx8DEED/RZTJEqnoMwdzVOFhzRYquHDLZJfeKDM1FPPsP2S4hnk2AC4c+jtODiXxz5T64jcH3VkIAuTx9MvRcQS1YEqj+pJb1uryQt+kfEj+eiolaDdf1expk1Ts5u/oBGtmOqOV4hfJp1c/X4TnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z/JYYuNywcOlvbc7IRcLncHn6vGzXZYzbS9x8PuOD4Y=;
 b=n1Euq9VsARcmtiDCy4dXhnmSCvN7lWWzW85eGBC++m8vI6INIoxewntGaFYXLFM8sM/C5ijXm3hp7xZyACOF54OTUYVLhTMvL1Sed/gtPye2O4j6Q+iOUkczWzaMtDttDILNQ4yn1maE4ulYxoi6oQcblB0ZzOFQjS3wrv7WeNKXHxN1PN5ftrzJadvHt1EepZrw7a9KP3kDzuH3zERz1IB8SyU19kkVTdQUOivQpkGoueHPvVg06/JDWv0xxAYtbcZ3CkvHJVnljN64NX2EibqWJOeYdKr70sCr7iRlNUXHw+5uqg06JKOho7BlhRzxf2QEfnVhNIOiqilaVNYGag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z/JYYuNywcOlvbc7IRcLncHn6vGzXZYzbS9x8PuOD4Y=;
 b=mURWs+ep64grWcsL+UiNdEaoQGwGIw9VISTTkTLx/cjPqdwEZOR3jvIhQNBvNpKPwzfsZsApRRKocEL2cSC8UkDthidRkjIYUCbxtV/qTwN9lg0GK+krapCHmtVVjY+YugE+tw+dCC8by4ygDMq6fflrp69zo7iPwGXvt8N7Tma/QyonBVHhGJoVS8+BBU8VfN3zr+p3qxXe4VXiVNP8vRY0VghADx8Djibc5zH/00GvFTo7ggZV/0T6gYBwMq3qXbAB9WSA6wn+kBpd+76iCF0mB5TrT/6Hl3S+ZvzQO2Lg86W0MT6T5Flm/RrvaiAQC9fdqU+lwUPHD8LFNMm+mg==
Received: from CH0PR03CA0001.namprd03.prod.outlook.com (2603:10b6:610:b0::6)
 by SN7PR12MB7909.namprd12.prod.outlook.com (2603:10b6:806:340::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Thu, 1 Aug
 2024 03:34:55 +0000
Received: from CH3PEPF00000011.namprd21.prod.outlook.com
 (2603:10b6:610:b0:cafe::1c) by CH0PR03CA0001.outlook.office365.com
 (2603:10b6:610:b0::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22 via Frontend
 Transport; Thu, 1 Aug 2024 03:34:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF00000011.mail.protection.outlook.com (10.167.244.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.0 via Frontend Transport; Thu, 1 Aug 2024 03:34:54 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 31 Jul
 2024 20:34:43 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 31 Jul
 2024 20:34:42 -0700
Received: from build-amhetre-20240731T045122751.internal (10.127.8.10) by
 mail.nvidia.com (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.4 via
 Frontend Transport; Wed, 31 Jul 2024 20:34:42 -0700
From: Ashish Mhetre <amhetre@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>
CC: <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>, Ashish Mhetre
	<amhetre@nvidia.com>
Subject: [PATCH V2 2/2] include: linux: Update gather only if it's not NULL
Date: Thu, 1 Aug 2024 03:34:32 +0000
Message-ID: <20240801033432.106837-2-amhetre@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240801033432.106837-1-amhetre@nvidia.com>
References: <20240801033432.106837-1-amhetre@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000011:EE_|SN7PR12MB7909:EE_
X-MS-Office365-Filtering-Correlation-Id: 58137d62-c4d0-4eea-9853-08dcb1dae910
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?g40+F2WIVJ1cxmmVp57gOG3aqjSWOQCHdvRru1pglOlOhOcyy+VeRKVr4nkR?=
 =?us-ascii?Q?GDOBrZKBMtdz0eqIeIvXZQy5V+LKwPtMioBsft6nzED6/052KYMLLRoHvYNr?=
 =?us-ascii?Q?ZNTeu/x00X2E95I5PddCTVpC1Php4Vnm5u8yC3aLduwUOnToqECHbZH76raW?=
 =?us-ascii?Q?mIhHKQxqy1OyvCiPseflV4wewbSzOI+Lfh2gngRkrGtVuy51lE3oFqB9nUXR?=
 =?us-ascii?Q?obZA8fqGEdF23sK2df/hZFUc53l1L79uXTvBiuidxyLyXcIzD+9hkIIaJPcl?=
 =?us-ascii?Q?qiRoYjzQI3UxnKhu5l0QnR+T/Y0qPtsU4x3kcVH52b0J99NNXY9J/miQC2oh?=
 =?us-ascii?Q?9fB8hd1e5IXxEWfzmxEa+IsKoRhIj85Y4id8qZFoRaaof+ZEbOJVoP8ZA7Aq?=
 =?us-ascii?Q?dpoPil6qGywQKNKktqmVLx7JT1I4i4EPS4t0yCQbAiCltX8zrq6JInBqHR7C?=
 =?us-ascii?Q?FfYnd3/S5IEHpHhT3gY96iesiH23xqD4kYlSYSCN5RK9kyl3EfMdPoACETMo?=
 =?us-ascii?Q?MTSRAGJw4+TpnBpVSvviRrMkP1n/FCyesy2x63B5yJEUpGdiR1b59KnP9JXh?=
 =?us-ascii?Q?rTLP4m3+iMzL6tJP9QncKFw4hU9SR5/3GoiDmHCkWVWhdzyO9ArVbERg9OBc?=
 =?us-ascii?Q?iqwccK82ZWQ1B7pP0oBj7sSBfa3//gdq/1WXXFWU+nZ0jGXA6XdBI0yUH2ta?=
 =?us-ascii?Q?JFivADIgV5McA2Kl6VgjSvubDNwFxBX4FW2UWsa68CuDTHZi0CEOkokXZjnf?=
 =?us-ascii?Q?bMH8UDNsHrjK10Mu5QAmJCtes+PZA+uX98s07gZPJG5GdLZRW7JAMMyyTncY?=
 =?us-ascii?Q?fq/dYhoAL8iBbG2ghhHW2QFpLa+KwbRNSFS/29krX+2KlxTj637qwAGHn61Q?=
 =?us-ascii?Q?N7i7L4dO9sV4JFIDymRnmgE8+S210RX5p/gzgpzha7nRIdqAYy+oFzs3HOK2?=
 =?us-ascii?Q?N9ZuN15hqg0ZriDhy1iFEA6HLden6Ev2oISEPJhzFRWcec9IA8uQbKF7CDzz?=
 =?us-ascii?Q?7RVfO1zXI8D3TIREQo1vCBDKxFicJQhyQsXIFwjW0NdTlK+pFM5HB8C+Z6mA?=
 =?us-ascii?Q?phExHy9Yj8jUQ1Xb+pHUzNLvg9/QWRNuBsv2dKlCvV4pBccxiOXthZG058Ry?=
 =?us-ascii?Q?DV5U/KgeZqmjBbWXUu51f4KqRP4mblOZJzYodpbDx8aDhewbzh+TBK8ejl2h?=
 =?us-ascii?Q?ZomDFngnWPnmqSE49Zs3A+/U0UU9dhVvo9fLgvHtoREoJegtLu9HiicC3umk?=
 =?us-ascii?Q?xlPJSwQhuaB3vsjD4KvEYRfrHSBSFCLbV28JwvKGHkwKN0hGC/hC8KEuzFaR?=
 =?us-ascii?Q?V54QdlWj/LuQVDPilGh9e1B4ofeMUABsOptJi/VRIXXNsCz16UwlSds7853U?=
 =?us-ascii?Q?e1cYIwrXADkdYhP+QbkLNenI+b+iziPaF0/pUJZdsErTbr6dnvR1uy6Ptv2P?=
 =?us-ascii?Q?W4vwAK2sZBflz26TGWRnlwFgog+E/fev?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 03:34:54.9369
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58137d62-c4d0-4eea-9853-08dcb1dae910
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000011.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7909

Gather can be NULL when unmap is called for freeing old table while
mapping. If it's NULL then there is no need to add page for syncing
the TLB.

Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
---
 include/linux/iommu.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 4d47f2c33311..2a28c1ef8517 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -928,6 +928,9 @@ static inline void iommu_iotlb_gather_add_page(struct iommu_domain *domain,
 					       struct iommu_iotlb_gather *gather,
 					       unsigned long iova, size_t size)
 {
+	if (!gather)
+		return;
+
 	/*
 	 * If the new page is disjoint from the current range or is mapped at
 	 * a different granularity, then sync the TLB so that the gather
-- 
2.25.1

