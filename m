Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11021075.outbound.protection.outlook.com [52.101.129.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C821E573D
	for <iommu@lists.linux.dev>; Mon, 21 Oct 2024 11:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729510513; cv=fail; b=iOOfKArWtQedqrNHce7zWKe6YJbAO4YpGEGkbOA8Wv3PYujkezCdwU968A8B7/2pJeO2R1L39SiqjsjW/IwzrZmdidjU62+Vt//ROcpuTgXAKY7JHXja5dX5dXVQWGH6zkp7dEdwS61RMJm9QaqGdud5G3pNB5B9obZSs2mlDSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729510513; c=relaxed/simple;
	bh=PAHPule+IOod5p2Be2xIY4JdGBpyoKZrEhI5DXXxoFg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=C2Bg0269KaCLfQUEjY1O+30u8zZOJX29dam4Bwoc+3P6/jgqYoRwdfzudEpx9tyvj57krwzJFnC/qpT8zyNEaTY7DQpxZrsmhI3syYFI3UOYng942UcQ1/i6ps7naUIb+NCJnvyLTgadIklmZ9HLjblbpENqA+agdzYAhADJA9A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com; spf=pass smtp.mailfrom=jaguarmicro.com; dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b=LZlat5bv; arc=fail smtp.client-ip=52.101.129.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jaguarmicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b="LZlat5bv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pdHAHEw1o5jqcasr6bRrXr1DuxniOgKH0FrBerQF6llQMyt5j15d3cMBtnTfz10ibiwFf5JoVFGVlV5qCXygZSrHh3P53QYqKCmPmKvWT8G0AZb/EkRUyW5rxw3iWc3D7mszCPU5yXLbB6+vcj9tSiOHYM+30wOGn3ScezzcGMDtX885pHj30yj+vv7pSKZ1s4nfiZuDv+17UxJLkYhgHyaeJ4E40kinwkgf+b4/jRtlkGFucHhkWUIWccNDjLq5eeG9fnhBdz+eYUv25Bq3hWPA+UjNfndDdJzcDpluBGgNpJc7Cqe8kPs/XIy6338oE7FMoNvVbnTV2Q+0PNXC2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6mmKPPbs8kEPgx+jlr9v+RPc6rOBRQ5m+AHTD1kzrOE=;
 b=KmDJTifLAbAP5ZHd3EOz5xS5rPC//nk4+UXTvTDXSEmzcuxLlgJYxbSFSnCtWKrwm7CA4+9sFOIKOh+r/1vMjP7R96scJBQKuAcFpFV4YGjV9zLZ3TtuajiPlAZ/Kllf5sfozh7OQNl5Uq6ZZHgmSNkKOECbGU9txa+juw9NAlaQPtJDLH0N2LdR44XUq+aALWXCyDm0AJcpcHZDt3FYWEPn2rr7ysv3gQmQLZXKT0B02mfknXSFAtyZiR2dfw0C5gT1eqOEK1/iCsCJCyk6A9KMCTdJJlC+zKYg2rECCoCtxUj1npqVp+nJK2+Wratr/K7grMqEBRM/PKGgHm7/yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6mmKPPbs8kEPgx+jlr9v+RPc6rOBRQ5m+AHTD1kzrOE=;
 b=LZlat5bvWmsgmuI3vBbkrgMrZf1z9iHdZg30cwTq/OYCMSJT2qa4fZ9BZQ0rexKAc8YN0VVOJW9H0ck4mTJmYQIdkXwiDMC+6kFftHxwjXwTGEZPb7UeAQDl/nORKGoyo4U4ItAlVzpd8lLMBf+RP9ti2ThH1ODdBoY/nUDfoSpX03H0uWT5skUCL7Zy4+FKzGHLEaE3kCOlt4FvryFDBwjnxw5qHJ3QvBQWkYlqdjGwsrmr8JYyQcFgHD0wWInE3sAWHBZFXZeFMi88mz6vEdZAWagWFBTIK2Mm/P5gqYawXk9s0pRPge2KJFCWAl4si8yNLUk+HXdnW5B1hX7Czw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from TY0PR06MB4984.apcprd06.prod.outlook.com (2603:1096:400:1ac::13)
 by JH0PR06MB6798.apcprd06.prod.outlook.com (2603:1096:990:3c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.15; Mon, 21 Oct
 2024 11:35:05 +0000
Received: from TY0PR06MB4984.apcprd06.prod.outlook.com
 ([fe80::d3ad:fd6a:a537:55a4]) by TY0PR06MB4984.apcprd06.prod.outlook.com
 ([fe80::d3ad:fd6a:a537:55a4%4]) with mapi id 15.20.8093.014; Mon, 21 Oct 2024
 11:35:04 +0000
From: Angus Chen <angus.chen@jaguarmicro.com>
To: joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com
Cc: linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	Angus Chen <angus.chen@jaguarmicro.com>
Subject: [PATCH] iommu: Distinguish between sw-msi and msi
Date: Mon, 21 Oct 2024 19:34:48 +0800
Message-Id: <20241021113448.1894-1-angus.chen@jaguarmicro.com>
X-Mailer: git-send-email 2.33.0.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0047.apcprd02.prod.outlook.com
 (2603:1096:3:18::35) To TY0PR06MB4984.apcprd06.prod.outlook.com
 (2603:1096:400:1ac::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY0PR06MB4984:EE_|JH0PR06MB6798:EE_
X-MS-Office365-Filtering-Correlation-Id: 275890bd-119c-4247-60c0-08dcf1c46845
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bf+Z8mjeBRkXL9xveXo4k4XsUHZsxO4sZd79mEiCpmmUuOH+CV+mvJBfkhCu?=
 =?us-ascii?Q?+4VPgVhF8TW0C8RwGh/MIoxX3l7ECVDOnNL1tny23soqlEW6Uf+y3UpT01w6?=
 =?us-ascii?Q?zLeQqmhFdKx2sRrM5fq8HtTkxgw73IcAoZfTOlS7EOULtStm+y2ErYAAV8be?=
 =?us-ascii?Q?aY3WzFFhPm77WAmdVw7Q2iO9/RBblRNeaXpg5JkSoAi0RA9CCWfWMt0C439+?=
 =?us-ascii?Q?zJBgJQEpoK0/gMNp8JAaxsJ6/ug+4GyFcMJsNtr2fzQHFjeZle+2T4IHNNGg?=
 =?us-ascii?Q?cEZjAVUnJuucBlAuXPfUXesaxzhF4H1U9op7gIVvbvg0Mwn4FYY44b6quK9N?=
 =?us-ascii?Q?4Q3nrrqmdK4d/Vzv0XT1zbe7wG4kXrIwqQAaJMG2k/iydpYkchpkI508LIuH?=
 =?us-ascii?Q?j+5u+hqK1K0UVBu4s+JtyKtEpy71mHDedRLTp21PePW6QFSj9VGcz1YDfO5M?=
 =?us-ascii?Q?0rPSq16nw17RCMFV7OfNzSu8UnG0lFV2k8X3vmtWrIZ7rFvCqlQvlOsqfcpg?=
 =?us-ascii?Q?UOp/uRYAo0SDjDtPgZ0xf2q71TXr6uHnXr1TWE4Eu5qbVHkibkrteiIUcsRn?=
 =?us-ascii?Q?IY7qPFE/dIMU+w4PrzipjkAcmmHSJyX2rEo3Iz9e1OOjH9yhy+A8OkAPMEkY?=
 =?us-ascii?Q?1EzWm6d5UD65UMlNIwC7/OVw4A5ZgbQZuGkpAW2d/x7LIFuJ/y4eHOkeCRBY?=
 =?us-ascii?Q?yNuh75VaFf5aaLQ44KWKU1C5txe9duJMcuAbXaY0l2DNbvDlve6mfuX1lFLy?=
 =?us-ascii?Q?HB5v1y/f0Os5UJ42WXAjW37STNwFUfM0ZUeFAilfE3RsIB/VwE0I0vIPiQ1g?=
 =?us-ascii?Q?8BQLRajFUytabdjS/9TJ8pTpt73aAEZfcF2V+nIr/Qcn5bfJ0RhMubyCKpSK?=
 =?us-ascii?Q?rh653fE9E4rLR/O44b8rx7aFIqf3yMm/5JQwdozrVfZI3ISUr/qQALY1HrAs?=
 =?us-ascii?Q?47lvZIB5iVdxOUCSwVTdLpYKwKU471MMe7lRIbFL43NRt5B3sETUsQTxdUXd?=
 =?us-ascii?Q?GiEZsO8o+etf98QP5f0WMcIr9fJkq1jI1FnPhxCiSxr8CZjxaZrNL5oaRMl5?=
 =?us-ascii?Q?+LGI+Lj9pLRg1GsFwNMpq4ep2t5Ajb0JCvO1sg7ByWaewbOiv/CdM6o5/oG4?=
 =?us-ascii?Q?u/G0xuwoQQMRJuuIDbxq6GchcUGUvFQ+OkVreMaS621KdSni3fZ0K/rrg9Kj?=
 =?us-ascii?Q?84pzMxJjkeqxfrqf9chVZwSssknEiR5dMLyi7EIxgMjVe+07DR1pgjk9aHOy?=
 =?us-ascii?Q?RLIxVJsSS18RdLpIRMwFGV93dOzsfMsxS0mhHOcZH63A3XGHMfDwJwbjx6IJ?=
 =?us-ascii?Q?hFGZbHzsCj6VNslvNmPjFxppkHUOeC8bln03zo4XDmxu68FKE/sa0/RP78lB?=
 =?us-ascii?Q?SQ9TD3U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR06MB4984.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uZ0ACRbGl1uNwRUo+QpcWSpcmMSfbidBmd0Nxr3bne5lPJonKfhKL2XtdAzP?=
 =?us-ascii?Q?NUfLkVVn8I+YAbiHK27b/OODXBJLn07Gk7IMge6GkK29TQInRIzVJgK8p1En?=
 =?us-ascii?Q?OUE4vC8QCo73rl84DbZ0AOKZ8t4G1hpNpWEI9Ssflfrgp7u2g/rJ9QVsunyC?=
 =?us-ascii?Q?rXdK5wU3zNBeJWB9dhAoJtGIRgXxZJoB2TSwWL3MzZTQxSdRE5nCyKIgD+41?=
 =?us-ascii?Q?vrSwnQqAM7sCUw6UsajR0sm23RLniPixjGWtInllJQ6b7nRC0ia6Za52gzGi?=
 =?us-ascii?Q?GR6ps0cYe+FlzYrrKJ4iuQGVoxQ5nMSVqma+5WdtKRb3Qpwdg9gu6DrHLSLY?=
 =?us-ascii?Q?iqxvMxa9ZaxVnyzP3VeAIPrx7zSrOIk0Y7rbEDKpMVI3vpapjmujWDXiNna2?=
 =?us-ascii?Q?ShGHsFjan+wncF+YQuxAgGRN3jKAQSqelBTVV8PFrIzm1J1uGcyQGT9MeaQF?=
 =?us-ascii?Q?O6frTrfLL2sktO0oGkKlcrnka4Mo6RZSAMWIcrTfec2LM6iDZEgOloNQFjO/?=
 =?us-ascii?Q?FIfyXaMriyuCbWi1AUhjplMcU3R1c+DGYyoOMpI8aS4nxHiLTGHEICYAbsaY?=
 =?us-ascii?Q?gzABRXko2k8qqRmGSzUGIiEd6NcjGUtx0miX5AGu9CrM0tb4DZAL8jhwJcVa?=
 =?us-ascii?Q?GY3VlAMprAYWuZoUQ6VLUJuXsrm+6hbXmdtkneT2aazUkp20IIxMwo9z5k7n?=
 =?us-ascii?Q?/3aBwBsedTgdT5h02T8kp/y9YtoBkkO4F8ejy3YwMP9Vz/l+QOKl7fVLfUbS?=
 =?us-ascii?Q?CLcW6uxPsomDkksGBccyvcIGMPR5eCbxuOjJdvpiogNRTDyHQF64raoXBz64?=
 =?us-ascii?Q?o+vJje9nLzqXoD3bZYNziydkjRtms50YJmAQUsDWOH6ElNYT7BNXBDLNE4h2?=
 =?us-ascii?Q?eL9bfKKFfCx3gJUY54qIRee6hqYGscJL0BzLvqkWUj38vPZ8TyTzxcM1g4Se?=
 =?us-ascii?Q?4QnRsRhbky36yB55PynqtmpffaI6mpEENGK3iypfA+i5XclQuTisR3x4YGXp?=
 =?us-ascii?Q?XvzYL/h7MCmP9OVJz0s1t4U4D2zCqx/cXyXozb7ravAlOHk6ycEWHHHZtInO?=
 =?us-ascii?Q?IE/GarXT2dtvvbIHAL3mn3f7goKHRL5NGAOQkJyHWkjbT8RR3bW3bnetyR13?=
 =?us-ascii?Q?hli9OLfP7NFg/Tk4cUDYg9iAFXH7AT9IKYtoMo9Pvq14GaLPhgcwJINF4P6F?=
 =?us-ascii?Q?OGvbAfNQBMRys7QLmX+z/nplkbz3j2mNUZP2ym4Xt1nFoYVvZa9b4+MBDbm8?=
 =?us-ascii?Q?iuifdQvxeZBIVWJeKo2uZYrwDEw2hmha2HaF27iUL1gRJisZfHRctp0BKdbL?=
 =?us-ascii?Q?70Y/KfxDAFy/TO1Fb6RXLv0wOs7nRCt63vp9OjnB0MsPMhxHDxe87xNaBnSH?=
 =?us-ascii?Q?4jMK1C/pUVUa+TWf6DiYnNFsQzkyZ/xBmuceGuvwZZhBICPwIxrywt9keOiA?=
 =?us-ascii?Q?agAwOgXjsnE5pLvZUhYH70GUlQYj0y8UCJmEuGZlqM7yelsYK9si2YTIcYCM?=
 =?us-ascii?Q?/XAcgjASE65itue91V86FqpZJz1bo9ICm8ncQdAygy+BjmTLd/BXTFC5X9sp?=
 =?us-ascii?Q?VCEatLU7ZS/veEUsPXqoItVC271bMguSQIZlkqZCbXijRIzeZPLXmHP8YumK?=
 =?us-ascii?Q?5g=3D=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 275890bd-119c-4247-60c0-08dcf1c46845
X-MS-Exchange-CrossTenant-AuthSource: TY0PR06MB4984.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 11:35:04.7455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BzAAVs4V+FT8bP+MkI8MIL47LqCikshKDitCDTaAvWzdPorPy5cCnpR1ePfFbOREnvKi4nTQnBxJDVQXm+OH9y0iyqKBQyBQ7pFVApPW6Vo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6798

iommu_group_resv_type_string use the same string of IOMMU_RESV_MSI
and IOMMU_RESV_SW_MSI, Make a distinction for these.

Signed-off-by: Angus Chen <angus.chen@jaguarmicro.com>
---
 drivers/iommu/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 83c8e617a2c5..8a2bbb5c4a91 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -84,7 +84,7 @@ static const char * const iommu_group_resv_type_string[] = {
 	[IOMMU_RESV_DIRECT_RELAXABLE]		= "direct-relaxable",
 	[IOMMU_RESV_RESERVED]			= "reserved",
 	[IOMMU_RESV_MSI]			= "msi",
-	[IOMMU_RESV_SW_MSI]			= "msi",
+	[IOMMU_RESV_SW_MSI]			= "sw-msi",
 };
 
 #define IOMMU_CMD_LINE_DMA_API		BIT(0)
-- 
2.34.1

