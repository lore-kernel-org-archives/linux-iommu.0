Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793854259;
	b=KOG4D+EzeVP58KGjfC4ilzFb5O/SX+6Ftq2tOaCkLg7LOF3g5QT90fS3FzM/sEaEgkXo
	 lvQ2NfcMzL/MilLGA3+BpvbEej81d55CX6MTJdkBqXIAfMltlthm5cWCfr4sVZkw7WTRK
	 22Er4s5jFMvNbbAkP4CZuJijy5eLnEVwQ8eCPQeLFtLlADKa7soWMtqehDtq2OGikZB7I
	 LW3JvX7elR+OgmGRcO7e7sL2dYNqiqTGbRlZYNzZRcJw0AIugjtv1GQgHoB3pms5QQQm4
	 Drm7LSTVXk3zQifuAcwW58ObKpXURnRoaaAgquNvdA028emFWufkulP3p+J6lzHiUzw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793854259;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=tgRUdIbBQBz5iTQNkpzhL2WPYS48IyB3LVUBTDz1yZQ=;
	b=tGp52T6JcBtAhY+2DkQUIwytv175dXkGjlKBd/+TOQTA8n2m9B1tdGfGkSx/S7dyulDm
	 cDqeeCLmLTweis7i66huiYRD7PcEU30kcv6CPS0px6vyy7o1384ekMHRkPYmbaPlOgUBg
	 UAiFYGfFXWTSbCOiFZq2YDKFBvRxGTSbplycnywMdk8+iRU6NPxGX8rkug/WYB1YPa3Nb
	 x8RpRJvguAZZmXDd6U2gj8sEllqwBOUcCsdpSdNqoQhHomtRsDBbXWq69ePsm6nnLS5TC
	 pNYyb2HOrcRXa7qS3q5BWNmO057HT3OlpjgunNoGAEXLijFKUiHFz84Thh2mTgVDc2Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=5nsawFeO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.53
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010053.outbound.protection.outlook.com [52.101.193.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68414606A33B
	for <iommu@lists.linux.dev>; Thu,  5 Nov 2026 04:50:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68414606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=5nsawFeO
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LPiCYSNuuuHg8W64jfahcdAxHk3s+gvV0jGFeKGYo4MhtpYobc1vSTeBU3IUuk7Eh5DL4kmBbCEeoyf0/AtD7cDOSimWBYDFz8jY0YCC7o/U6ANXZO1HoZzRdHZgJF5PMQSk6oIMQKERuVPjWdfu+xsKJO1QFWaS2pDVCtnI8FuCdquXNR0amFEDW9+tbDHmzyRE6UzNAa9yfl3j7wGhBd36q9ZqZcC4xXYL9N2CZiGCKpnvgeF5ZedvOsrvuouhelwE1eB6srORzSR4SvgHNBE+ouuHhlk3OL6OGRPNaJaOa7nZxOh48Q3f5eh3pzAxbgwTlahMi79tv2AaE9g9MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tgRUdIbBQBz5iTQNkpzhL2WPYS48IyB3LVUBTDz1yZQ=;
 b=pZboEpUlx4NjcNxlY4BO69vWqHOeAWEcqISoTy9PoR+f0gU9R66uJLht2dnJmUqrUqNb0MPJ74fPfmgzxkFEOxVngy3gUoWglEwXe26PZggvMzA24pgVNuu469VidGSfoZukumc/6MLIGWe6yzwwdHzzjltk+9MEGlxlPDKVBzBEX2lDZiNAaJdGtZCyUp8ZxQCPWsqi3CAF3f9xvEaUZDIM860in5w6Ud67JeNPDMY0jlED6zM5yzqsRlxuPKZNcLIhfIkPbaQwhEZQ0kWhroihw6DYTnIuGSP127sZM9Fe1lbbJaVpr+/mZnle2DC16EMQx6D/P4Yk2FX4cwnFYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tgRUdIbBQBz5iTQNkpzhL2WPYS48IyB3LVUBTDz1yZQ=;
 b=5nsawFeOO/7+N/5goAq3dnbjTHfwqti3Kud7F/bZmL9nZ3BVEf9Xg0oe/oL6pNGTaDe1k76+3a4lLH6Y1x/gKba/HfEpIWDYQhF/Gui9UCp61zHq3TP+f41q9wlSa+9fkZXqUDHu2acxtxtblrWszMsudeR0a7hQegJKSbb+gF8=
Received: from BN9PR03CA0988.namprd03.prod.outlook.com (2603:10b6:408:109::33)
 by LV8PR12MB9083.namprd12.prod.outlook.com (2603:10b6:408:18c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 04:50:52 +0000
Received: from BN6PEPF00000074.namprd03.prod.outlook.com
 (2603:10b6:408:109:cafe::2c) by BN9PR03CA0988.outlook.office365.com
 (2603:10b6:408:109::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.12 via Frontend Transport; Thu, 5
 Nov 2026 04:50:52 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN6PEPF00000074.mail.protection.outlook.com (10.167.248.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Thu, 5 Nov 2026 04:50:52 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 22:50:50 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@nvidia.com>, Vasant Hegde
	<vasant.hegde@amd.com>
Subject: [PATCH 10/12] iommu/amd: Return -ENOMEM when SVA PASID allocation fails
Date: Thu, 5 Nov 2026 04:47:59 +0000
Message-ID: <20261105044801.399466-11-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261105044801.399466-1-vasant.hegde@amd.com>
References: <20261105044801.399466-1-vasant.hegde@amd.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PEPF00000074:EE_|LV8PR12MB9083:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e554357-1c8d-4c6f-65f2-08df3af85eda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|82310400026|36860700016|11063799006|56012099006|261021123027099003|261021121427099003|261009223027099003|261102123227099003|261026140227099003|261026121527099003|261028144727099003|261022105027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	iie+fil7PMPS+XCcPoS1uL4+2LBM1pQXfJDWauSRdzhPj/vsN2iAmNxjwLGg71w7nDOpt0rHswgQz4VxtBy7a0k1uiry1Ag6pw2/j4Q1qTWDLXaS8LBgqftxlPoxyZMcCwor7aJHBWaJhOElCTa6+aaz/eSRkTdvHYLrJkQUVOlUvvpG4TzPectBw1P9mXEs0LcJHt6+npcnqCckNfLjMU1eyeSLG3485wLoWtOaHfLj5UJAAvecE/PJFIaDSM8Q6yUFoO9jyXPDdgW2z5I2Bf02uH6ytowlt4nM8aO7Zv7ppLDnfGOtFv+9eNyL2ujVRa+zjD4Rk8E99XrC0WC9YzoOytUuw0RXeI+uQ1ab4gehWPMtu4w80YmwiId7wXHkGTzCHzKtplCbqCmW6bizASyt3A/AMZ+zAIf+VI9OzHLcm/VDi1kqttszviYDykuqTPfk7lwXHBx88PJ1J+8NvncgWF+phg2T5kromtNXJbgSkfArW4GJ927Pk1+HHLqlHGIy01QihfIXtgl6qBy8l7w1x00jWy38o+Sr2M6z443ajkMLWunOzPWXDUTdUyJ/L3yFOYTNtAQx6mJ79nflXd9wuxeiKAfZ0i8C0Kd9uOQV9DdJGlCEb++qvD06kJ0XYR3kg7gqIXokHZvgnBb/b3KqcpbpiR8Qif/oXIEuTl6+vpqo7a5owPFDs2sfVFoT5LHMoT2u23OGKs3bQOLg6A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(82310400026)(36860700016)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(261009223027099003)(261102123227099003)(261026140227099003)(261026121527099003)(261028144727099003)(261022105027099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jfbkavqbqTuzixaoGVo7AeKHyIOhFgQ/BHapuD6G3nPmFhWn9HL/+HiiYUKHuTeirL11N61HKAmzc8qwei4cLgtEWCKdp2wbuu900a5WUon7C3odhT+TpISK8HhyiAjyw2yVfk09jKdWkDESvpQWSNCwE7XJAUsRSOqmGC8kc6PqIfR6qWdUYXqWSaFY2M2+k2XLcqLHjZ5PhHtdL3Nntjvyv7c6CPWbMKZlEOeKc0rnhvvtEfvkeqI2mK0S4e+WPbyIxoPghjPzZDoMR5Z/u/NMOsmJKeyO0E6Q+ZOaP9OjlzIx+IQFzJAgZmbwXtJDhpojtV795w3zLAnKWh+wYx+weArkNgJYYA8BzxSF1zEkDJBgx2mpv9qsV7QMv6RbHY4hGIfjtl+ba8sXazqhR2OVIcTtqlSnF4qNSpkXO4Ih2nC7APP4kfbM7l8jTiRR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 04:50:52.7127
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e554357-1c8d-4c6f-65f2-08df3af85eda
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN6PEPF00000074.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9083

iommu_sva_set_dev_pasid() returns -EINVAL when the pdom_dev_data
allocation fails. An invalid PASID or a disabled PASID is an invalid
argument. Running out of memory is not, so return -ENOMEM and let the
bind caller tell the two failures apart.

Assisted-by: Cursor
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/pasid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/pasid.c b/drivers/iommu/amd/pasid.c
index 214e7dd2ae76..9e1bf3343092 100644
--- a/drivers/iommu/amd/pasid.c
+++ b/drivers/iommu/amd/pasid.c
@@ -133,7 +133,7 @@ static int iommu_sva_set_dev_pasid(struct iommu_domain *domain,
 	/* Add PASID to protection domain pasid list */
 	pdom_dev_data = kzalloc_obj(*pdom_dev_data);
 	if (pdom_dev_data == NULL)
-		return ret;
+		return -ENOMEM;
 
 	pdom_dev_data->pasid = pasid;
 	pdom_dev_data->dev_data = dev_data;
-- 
2.31.1

