Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2063.outbound.protection.outlook.com [40.107.20.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD32CA4F
	for <iommu@lists.linux.dev>; Wed, 26 Jul 2023 12:51:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LblF6K/Mgo3mac1OLCSaAQVBVaEtWUV2E5kisZ893LBKlrPeNutC/McxiuI0WMPbRzjeB8BkEukKURxC9DH70vRgcEV7lmwp9fW3dNJNzstynHaeXF54jMUbVxKtyfTUP1osknDHhY76tlPT4tzkeRpprSvJQaYoyuQyi9O0yVPUHKEGcASTyzIMi4Hp6z+YAe0gFLlXpA4SNL6QmgbhTJaA2JGOul0KL+al+ralLEQyo5zDRX5/BAcFepmDv1s3VemypUuqxJO8LHHC22VLjHh67YZ8DVKHJMirPSU/FbPlpBbeLkeb+dFcouUCra776BE25DLvtMlLMOdA0C6pMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n7ABRQgzH3yxqkBuenOCrDAxpd94TR9KXUr7YJzdK2I=;
 b=AUpTpnaSJDQ6L6kbVjm5JIy6qFOK6tRX/ZY87HgdZcvl0OLw3k/7FBi9zFm5vEC+dnQZe+g1VZfkE/5pY5hvnYQF8T1awd+S5MMYT5/e7avFgqAEUBZK/4GkN1PiAwvL08fuXvy0G9VfMtYpc6fl2NlPrjs2cA9FArTsQny946l3BNUfryGbBqycR1nfr7+GOm4JZ0JGeAQst+qKezAEpfulSgFxHlI51u4gom8YWQeYBz0JnTy8/KneSvH7Q0OHmiEplZscM/ANKZDOWVlBPMnePs1Q7Qkuc2eHmw/XThzoQoLHrjoab7e7eKuBZiJHqmQmh0/Oif8dA+mNnwbZQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n7ABRQgzH3yxqkBuenOCrDAxpd94TR9KXUr7YJzdK2I=;
 b=CjKLkmXEZ5gIH2Bw16jZ7zfv37jymhn8+0I6zfXrVHRXLuJPngwaX6KRlh2ZS6gtKlCuz3056vahinCar5qkemCEh0pJSgr6M+Tt9rdLRneaXEIuw2+23T0ZtW2gVmb/UHQVblAPCI4RVuGEQFOQQr9c513dMLqAFZMayLTGK1I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9380.eurprd04.prod.outlook.com (2603:10a6:10:368::16)
 by AM0PR04MB6913.eurprd04.prod.outlook.com (2603:10a6:208:184::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Wed, 26 Jul
 2023 12:51:28 +0000
Received: from DB9PR04MB9380.eurprd04.prod.outlook.com
 ([fe80::179f:1c4a:4573:acb9]) by DB9PR04MB9380.eurprd04.prod.outlook.com
 ([fe80::179f:1c4a:4573:acb9%4]) with mapi id 15.20.6609.032; Wed, 26 Jul 2023
 12:51:28 +0000
From: laurentiu.tudor@nxp.com
To: thierry.reding@gmail.com,
	robin.murphy@arm.com,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Cc: jgg@ziepe.ca,
	Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH] iommu: map reserved memory as cacheable if device is coherent
Date: Wed, 26 Jul 2023 15:50:59 +0300
Message-Id: <20230726125059.19123-1-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: AS4P191CA0028.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d9::20) To DB9PR04MB9380.eurprd04.prod.outlook.com
 (2603:10a6:10:368::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9380:EE_|AM0PR04MB6913:EE_
X-MS-Office365-Filtering-Correlation-Id: 457acad0-829e-402e-1174-08db8dd70783
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9GA3F3bTkU8rfHyzTuVlk5ki8efiUcYTfU4+EnmX7/HJRCVamLDciBCLz7t8X36M9tS4frCCmQTbGNPFMV8fzP629TjWbYpXGmazBOeTJz9pcpZ+HBHr9PjHWjVkEwcYsb9Ab2AcCzMOSf0ZB03/ZSQduDwVimronQC8ALzgad6uVuTgZIzsecrMqEkEKbFD6ruLbfbY2NErJVuxs4EO18x8ulnKwvNxoZvsNdc7xbNViUgkBb2ERbvSvR6POOKPni5HrmQDcQEgmZmp9g3ODy0sTKlozwycI2PafFpGRLaCSMu7dqi/uwZ6lOcTPCS1Hyfm530xfz8OVfYsKNgz+UbVSMnESa8IOBlco9pfJaXHsRkPEWTTK0WEo5jVQsofP3IsUwsCriAdhU4SfhzwAtSbcyB7Jz4PAsdBb4jOaEOkoUZtgE9kdLBTFsOFJcbcQUezjpA1dCKDt4s9JBBY74LPQpelL7FXr0E0PcIFFzPx2do5urAsNE4X7twXVscCxPzSFgOiqZbFd3qFYfOrcoC9MCFmnGAmxyoXKqXRksXv8EjBsFqKCw4plSH+MqLSO9TZdAuaUiBOAuCEZnmcTw+ignqEsPpqFJqthTdkAWBGBytpxJ7SY8pw4EugSgUO
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9380.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(346002)(376002)(39860400002)(136003)(451199021)(8936002)(8676002)(316002)(5660300002)(41300700001)(4326008)(2906002)(66556008)(66476007)(66946007)(6512007)(6486002)(4744005)(26005)(52116002)(478600001)(9686003)(186003)(6506007)(1076003)(86362001)(36756003)(2616005)(6666004)(83380400001)(38100700002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?d8UgU5amALT8dgW40r81x/qb4CdXFm54TRQmPgfEX7BUczdOkqvx3KwDO3rj?=
 =?us-ascii?Q?t+VZCHR/517yqfrboW6eZCEBNSIZ9WYtBY0SGk7+0Fh6F5RfBoyBcXtCTAKd?=
 =?us-ascii?Q?5/kJaKiYw/uhCr99TmGgsZ+GL3NiDN2N7WU7PdFx1Jw8ETSDY+VdFwn+4hLg?=
 =?us-ascii?Q?3AmNRxKCkEzKI72UbCpc3ZSpuFCMEH1C376CJLx4ElKUo7H00KbO5xNsN3jk?=
 =?us-ascii?Q?fh9IOCsr5mooAhs0oizIZABKZbeQHCW6ffog2Sjc8uRmd+pg5TELixiqPkC3?=
 =?us-ascii?Q?zHOPj4Vi2ZibQyrWqxj8/kL5bWeB9LIbIPk8VHObzQkOE0D2WUp2yggjW5Bh?=
 =?us-ascii?Q?YcUww+1UkKkyy7/m88dhHScNDA3M4UvvYtq3F99D4HNH6SzhPAz2lKXUSsuX?=
 =?us-ascii?Q?gNaFHmbWe0UQ6DIIJM1Yww32IkdHh1zSBcyIfTr3GcwDTIlxTWUhAQsoTMVr?=
 =?us-ascii?Q?5PNgEDZnxP4NUt26nVGzBvZd6GB/J3WyRWQJ06r4+IxKPHRLmPNHQ2svmJl9?=
 =?us-ascii?Q?wj5tcThJlilUpWoCJ8X8JM59BLkemVUQkPeRf+dZc7JBiYrPBWNjtBmU60Qs?=
 =?us-ascii?Q?ZFCLi6zdv6zGEi5RmP6uIivF0ABquGxFgp3dPz4giT3WGtHBzdloSJQ4Yamq?=
 =?us-ascii?Q?DcO+7Ph8WsdjSff6ZWcsgODG1FlKLwtTqMMUhAPSI3mbtU7MdsydgHA00dF4?=
 =?us-ascii?Q?UuDi8Yq5ffhFda4hjh4ETWy3CF2FoRKjpaUNioFa+WjevknqjoBCkytV+vW4?=
 =?us-ascii?Q?lfhtDU6w1Ex+oIszMu9Jh19ooUe2hheYQoDgyWJ8nloqtOjStM2KKfr3Anp2?=
 =?us-ascii?Q?Wq/xzH4WA1Cklvg654YSA176jPuA0OUxNZyym+JCuY69fNbJCYcDbSaXvngT?=
 =?us-ascii?Q?ltoENzlq4cFGQKTerE259PR94GKxAmzJwzA4x4qOVSHywIyAyjXCYNjc8QVc?=
 =?us-ascii?Q?EO3Da22s8e+hz2vG1X6gra6SsLbPXD0vsdKC01iwWmITdX731WGcvC6HpXSL?=
 =?us-ascii?Q?nG8Hga9zNFu6Spa/Mt9E/zgRXrWt4T2Pt9+2Ld8qvZMbbVZcDfywYZvaLFbO?=
 =?us-ascii?Q?D87/P0cQfJVSxMW3WGfKCZXnZf176ocBv0vNrdhdy/UchLas8Tf/4IoblbSb?=
 =?us-ascii?Q?FkDXPnftQekHMxhmSuVCvrd0b+tY91nbi331VW/AbNq5MuweV2q2P+1HLdmu?=
 =?us-ascii?Q?+jQIdAijgsM0XNSQQBdaFLNwx2GKxw03SEQZtM1WWi/4pW8G1/jtJGgtO7X3?=
 =?us-ascii?Q?869526nC/nXiepTEbyn/fR8UShLqGJuomVZbtrXM6JTtW5tZXlO5dKHsMoLx?=
 =?us-ascii?Q?5WtUYPLog+yYGxBVBpka4qsL1Di4tun2Be6i7c2HcVF6v8Awm8M5F9dZkX5J?=
 =?us-ascii?Q?0FIb4rkuiAlzxKugoFS6Kl1YDY51pMeZcbrkW8qbSLA0P6BG87TtWrahNoKS?=
 =?us-ascii?Q?FNoZsno0E9q4nhCaJZA62j2+AapvUM5qtfjSDjwGFqzh3VrHkx5SfK8mfRsb?=
 =?us-ascii?Q?+oM/2TicQzBG/g6MAwIACoSb77RwrS9b73EVdDOoWLYkjqeZx5rd6thMgLOe?=
 =?us-ascii?Q?hQ0Pg+wIezw+UUCc4GHbxlBu8k2SsE28UKTwr6Vy?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 457acad0-829e-402e-1174-08db8dd70783
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9380.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 12:51:28.8605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MXnCTenV6qYjr5MCg46BEsKOoAL2XuIE0ZkXtNsclBzqToycGMOvoi/2hVKVsSWkcxw8AZUE8ImxrxMrFPVQYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6913

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

Check if the device is marked as DMA coherent in the DT and if so,
map its reserved memory as cacheable in the IOMMU.
This fixes the recently added IOMMU reserved memory support which
uses IOMMU_RESV_DIRECT without properly building the PROT for the
mapping.

Fixes: a5bf3cfce8cb ("iommu: Implement of_iommu_get_resv_regions()")
Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 drivers/iommu/of_iommu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 40f57d293a79..ccb912049b88 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -254,6 +254,9 @@ void of_iommu_get_resv_regions(struct device *dev, struct list_head *list)
 				phys_addr_t iova;
 				size_t length;
 
+				if (of_dma_is_coherent(dev->of_node))
+					prot |= IOMMU_CACHE;
+
 				maps = of_translate_dma_region(np, maps, &iova, &length);
 				type = iommu_resv_region_get_type(dev, &phys, iova, length);
 
-- 
2.17.1

