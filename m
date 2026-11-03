Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.36
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793718886;
	b=p3gx1vtWAw5UWgzriE6KKCWn95JZxYBNGZpFzLpF9jdCUx8Ts9iqoOzntnMEvwrzH3vl
	 FMoY/7tZoULbHSchOgNACocu4x39GAMLWffOx9G0CliW6sEm/2GtteFWQ1ls7EoKdIuz2
	 QFKqnvJdRG9KN9d6CYLPdqXCMG/SNyWureXY11BpV/fVNbmzJq52ab4oVI4/Ng4yAt2xB
	 M+F8AKV5AclfP7VNlnNTS9HrvEbhLLdYh5o66bS/+PvlyB92AW+Ecn4OINGSEw1NpliWz
	 FmAQaqH8IthYRN/1wPZfFAPDCAPET2B/Lc5pzpi3DR9zlv+lr/fXWRY4qEAM89o7yMw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793718886;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Date:Subject:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=lBAimrTSGOcfjqkodrb+ZeB8WdoV0Ux+HNSAqP3SoUY=;
	b=mSJRl3ZPCRIcm/e8wrVXND2H8lfWcwrdn66/j7PGJw4kt8awV9BnXy58huoaZHEFMkZg
	 CQK8RuHnIfaITR5K+CjmECTQkd3b+bH9XfVo0NNwG1V+fp5Y7Q9jcSBu71EqXI/oAy0DG
	 on2mkbHcUNFxsn2etOahyzsnq/KcyJCIo88V4fqRfN7wwZceEZvUrVyLFuFiwG0E77kvW
	 7b2Ok2KsNWXHXbs5pTG+Feg41YwvdahP0Cp8akzU0PUGdPotoZefNw3NcaXDe5UDdL01S
	 mJcfkRlMiSDFuFJg5whr2tDOorZsfhnFxh7LB7jPeRNSMwoEBVtbMZFJe/+GrsZufqw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=oOIv6eht;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.36
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013036.outbound.protection.outlook.com [52.101.72.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3FB606A7AB;
	Tue,  3 Nov 2026 15:14:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F3FB606A7AB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=oOIv6eht
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ALnlX+N2Ava2fs8IIvRK7i+2p2KI/yGUbqHA28+5yrFukRHWQHehi2QJwpil757z0kVPtfRUYqlOVvgB4xgVR2Ry1EbJ0sJK/HbN8P83wEs42nYzKV0r85XGgBqAIYVZeyXi+6qE8NlNEmFCOw+oJbNcwaS8ezAQ6BKepZRzfhoe3JxKWGuJeiw1hLC3mk87RcdZdobwXHFELvsSmkF/YbvuecvWyUSDP10j7GaWFoQe86jKOMs3db9CF2qaNbH0Vo+wJsTR8wOHsuFzDRLurQR1jNL6eH79ynMnwLHF/iJlvg7TAtNcG94VYVS0DFpR49XUs9Fe5cYnyYA4DmPybg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lBAimrTSGOcfjqkodrb+ZeB8WdoV0Ux+HNSAqP3SoUY=;
 b=YN/69+hqIJjEpPOoOMZfL1vlaiopSUgHr1f5YG5deb3IFdOl85Y+4EURutYDPUYTna7jxM/mVwitMQoyQC0wVzDKlC06HCQU1gvU2jH0blDH2cJLaqOscTFnMzA5jVM+EWsdqp2Vh6W1AYDilfGBMPD6qKuzry7wl7SPkq5fvBsTT+T5/x2eJNWgyeyFvmtZ2Nag685qmKzYamE9Vy+XU1D0IX/IyvnDPYXApguoKSfBD7UXBCEgepjDZfamFyI/AvlSJoLy9fvQxNMXqzBsw3k9jSfN629tfTGd0PDZzzWq2qdpZcgNpIFMyWqqYtMWTSXEds6WKE+DEWmIUxfU5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lBAimrTSGOcfjqkodrb+ZeB8WdoV0Ux+HNSAqP3SoUY=;
 b=oOIv6ehtDg27Cd+UhMs2ToC87EjXjuW35+Pt0VgqG0DE+BYzHfgH8XlBzkEFWqSi7XS6c4eR08TLOLew9fZcVSZrMGkzPTednGN+gyEjKi1Xe/9IOWl1h95rVWvGDJu6xt2C5DwKlG8tGZ8L7+vJ71JrxP58h/CR6kQu2qJEjEvrx56BZ71tOv+JKZ1akSRnWeVv9QJAiUPl59LE/0178rwgEeSUOPGc2IiT599cuxEwMJeRp9cTK4gqLxvO2oF8fTKQkwmnPCwPKgL/GXGcl/h1i87Pjqn7Pnx/dnyHAvTRFHP7RVdZrd2iJrJrEHhk6oj7OQBDIkbEXkX7ZU3x1w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by AS8PR04MB9062.eurprd04.prod.outlook.com (2603:10a6:20b:445::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 15:14:42 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0592.007; Tue, 3 Nov 2026
 15:14:41 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 03 Nov 2026 23:19:01 +0800
Subject: [PATCH v4 4/7] dmaengine: move channel devices to the DMA channel
 bus
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-edma-iommu-v3-v4-4-470415d418c5@Example.Com>
References: <20261103-edma-iommu-v3-v4-0-470415d418c5@Example.Com>
In-Reply-To: <20261103-edma-iommu-v3-v4-0-470415d418c5@Example.Com>
To: Frank Li <Frank.Li@nxp.com>, Vinod Koul <vkoul@kernel.org>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Laxman Dewangan <ldewangan@nvidia.com>, 
 Jon Hunter <jonathanh@nvidia.com>, 
 Thierry Reding <thierry.reding@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: Frank Li <Frank.Li@kernel.org>, 
 Larisa IIeana Grigore <larisa.grigore@nxp.com>, imx@lists.linux.dev, 
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 iommu@lists.linux.dev, linux-tegra@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.16-dev-7bc12
X-ClientProxiedBy: SI2P153CA0031.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::7)
 To AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|AS8PR04MB9062:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d16b182-cb64-471f-a54d-08df39bd2f44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|19092799006|921020|11063799006|56012099006|261009223027099003|261022075727099003|261022105027099003|261102123227099003|261021123027099003|261021121427099003|261028144727099003|261026140227099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	CUi58d0Q4oUm5m+rjMXg36MwYtG8/vkIOxQmp6i3qRe+4kE33A2YS3+V/meImDrW4cl+H4VZhGwqwikpT/isLbMtyDxjfIO7JJzytCnMa8PIvNsHrc21iR3VlJwpSMDuvIfDC7Va9Dk6RbT4afcsYqd+PWurr6xTUT7bheosIV08C3+bIogntjZnQBOn05WYQtWErsu2QBtzTG6oAURmRZ1hZhzZ9ywRRaAi7L80b8RQrgRjzK5H2XqH0aCk5fUENmdcZfTJgE7+ympR5P6EQoVcJ/CxsU8yeB86sKcNGDg/qZfe3JigihjAsOR4sntFGwoIQgbF0BAoitb63ZS86Tp5a52i8SOTjuNzI/TuxaJfVGxEvLZ4Pw12Ez2VULHpRoDTFYPllPS3grYz0LTRzKPqPYhDl0APfA6tABb/lBVjLSc4lv6plRbrLbs3JcJ8HWBRixWjtxqwQmmq6isdsMqJb7Kz9BdS8cN41w6C1JKQLuQd9TbyS4d0CPahuCMYcofx/zMiS2Q4PPYQbOv638du1Az0/1NIPTOqRkJGTPhiYGB9++RmrQt/MYFG/5mgtPUIuFUHIlnDhFCtWkLKNbOOctH+uk3weHzZ2PMf20OYeJnpmlKPqLbzS50W43eACcP+E8hUu33NBXa8GfN/RQZpn+Wjw6S+htLkcg+cNRiWkWQZo1XnmtlCoQ8BhVArqLqMNFoOhoH/GCNYZziGWQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(19092799006)(921020)(11063799006)(56012099006)(261009223027099003)(261022075727099003)(261022105027099003)(261102123227099003)(261021123027099003)(261021121427099003)(261028144727099003)(261026140227099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cHRUUnZyWDNSUFZFb01tU2lKSTQyQlJsQitTTWtxUWV4ZmFOb040YTFQOW1W?=
 =?utf-8?B?cUtDSmpOanpjdGtYdWRRUHJ1QWpYa1kwRzZURVpwS05qSXRXc3JpaUg1RTE2?=
 =?utf-8?B?Z0JhWnQrTEp0b0U5a3FYVXEzNmxiOXZpN1lWSmFXd3NiT0hVTWltYzBIaHZL?=
 =?utf-8?B?cDQ1a2NuU1dGUnNLcWExS2VORGRZejdGbEQza1F5OUJMTzYrN2QxUUtldm5D?=
 =?utf-8?B?ckdlNEp2QmllVFpiZi9WU1BtTUV5M1pGSkxEWjFkVHlWYVFCaitEUE5TQzF1?=
 =?utf-8?B?SGJBR0srZ3FHWEwvbmg2VXVNRllWK1RCUkxYTVBSZjdGZEpEZm9kVVA0TUdO?=
 =?utf-8?B?NHdSTUVYTTNLS2FmcmRsbktPZzNISmJvbkJMUWZRcVVxaWpLcm5vOE9ZVDZj?=
 =?utf-8?B?RTAyRTdDaUYrMCtibmdmaGUvbkRKMVJWZlg3V093Q0FsdFlIRUhaODFBK3pz?=
 =?utf-8?B?ekE5VlJpRUVWcExVOW00MU5KZThmMENjOFlwVHhOZ0NuU2VUY01xcDZZazdS?=
 =?utf-8?B?cnVBNXNKYmNUekNKSHVvN1JmSjhmSC9wcXV6ald3bGYybXltUmpzQWlZTXBZ?=
 =?utf-8?B?cHRnWjJVanJPZDdKdFhqL3JWY1hVOW5SdGdRVGJtbTVZS1FLNkhlaU04elVh?=
 =?utf-8?B?NG9sUWdSaDE2SFJVQnRKd05xcDJyYkxTRm5lbC9hR2lZcTM4b2J3NlJneFFD?=
 =?utf-8?B?bkM3cFdUSWpWVVRqd3FjZ0lia21KeFZDM0phcmJMVWhFYkpIQVZDQWxNWVZv?=
 =?utf-8?B?dDYyc3lHSDNHdXVpZ0c0cGdoczAraU95OWw4WThGTlhWckl4YlhYTjhkZVFC?=
 =?utf-8?B?M1pqVDZJeXMybFk5aTN3c2VRckErYjJucEQ4Tjc1dTRJelE2bkRFczhxVXdp?=
 =?utf-8?B?STJZd21oTjlFaUVnNXI0SGJFdXlnbTg1REJka2taWGdrVU5Sa3hnbVdIV2s5?=
 =?utf-8?B?Wm5hMTdlYzB3VUFoSjlHMzJ2NmtwSkg3MnJiODNWUUR1VC9sY0VhSDdzWTQw?=
 =?utf-8?B?eHYyNUxVS1plaGNMeTZqdmR1aVFTY3B4enZWaWd3RnZSNmgrS2tRSnh1MDIw?=
 =?utf-8?B?VE1tdEpBQVdEQTN1WkxqNzVOWm5yVm5EMmU2NzI0NW5SZnVybVNObHdESlFB?=
 =?utf-8?B?QVZuRVQ0RmJJZDBrZ1Q1MG1yMGdHQm9jR3psczFvRFVSRExBRlBJa212bzFR?=
 =?utf-8?B?RlZJUm1WcGRET3RsdkJId3JaT1BhWUlYRzJBTldxNnJLYkN6M1oycFZTb2Ez?=
 =?utf-8?B?eUhXQXFscEtQZjFFcmZ2NCtNdmNOaFBIcElWVCttN05TSHEvczlaOUZkdkwy?=
 =?utf-8?B?ZU9uajNhUUQ4d1FXcWE0R0tCVW5YdVNxVVNtcDM2aWZCaDBhUGRqQUNuTlVN?=
 =?utf-8?B?WGxZSHhKNU1SMTlkcU9teTViVCttNHdzcTRpOVRBc3VNRTJrcFdkdTNXR3d1?=
 =?utf-8?B?TmhYc1dnRytrYUx2cmhBdGh5dTNtNkZYVkVzeEVLMDduRHdReUJrQWJaY24z?=
 =?utf-8?B?Q2E2NzhHK0NiSXUwOXN6MUEzU3J5bmlQZ1FWM0F2dnV0OXZURWdWV0hWNEx6?=
 =?utf-8?B?aUFWYllEb3oxSDIzamNBZFprRG5Ca2oybFZRY1U5TzBCYTdSZ1ZDWXNpcGs2?=
 =?utf-8?B?VFQ5YWVJbDRMclRTYnNYamRpdzRrTTg2WmFEcll1eHd5Um14ZDdveUlVNmY4?=
 =?utf-8?B?d2RRcHI1aHhHajV2UnNFdHVxNmpSMDBVNHc4NnVpYjg2RXNoeGpmSzJ0Wmxl?=
 =?utf-8?B?M0JMeG9wNDZxUEEvYlk5bDZYRmwzMEJUTEtHTDlnRCsxZGxTZDRieEZWcnRM?=
 =?utf-8?B?WVZOM2luSzZwMGhoMFFydktJOFhoMk1RT2lQdGluZXNlWWd2cFArN3dYRG5S?=
 =?utf-8?B?ZXFVNmYwSkloZXo0QVRXS2FzUnZBeUZGNnJoNkd2SGZvN1lZekhDOEc4WGZJ?=
 =?utf-8?B?UFhjVy8xWS9sTkt1bllJYjRKNlZ0dlJKS1BTRTk5OElKdkdmZ054VVZDS21r?=
 =?utf-8?B?ZjliRkRlQm90M2laMTVUVUVIWkE4S0t0cFNyQTEvNWlCakt0OUFmWEtmUWxy?=
 =?utf-8?B?RlF6WDZ1TzFDNERDa3NkTG41WDdNdDNTVC82M0lVem50SXhaRktPK0xsV0R0?=
 =?utf-8?B?VlUwWWZkbXFRV0IvZGRSZUdJTWRQSU1tRkl4clhwVGlzWGlLQWRiYzZId09Y?=
 =?utf-8?B?aXFleG0xMTlnbnZyK1dJaDMyY2hGQXovUXJObHI5dUd4by9USFErWVVPSk1L?=
 =?utf-8?B?dk96K3JBUHRyek1tN2tncWZhcFhET2hYbUx4UVc4RzRDYTBaY0p5OTE0OUdE?=
 =?utf-8?B?MFM0bnBsa3AyNkpad2sxYzVOM1VSaVgxY2RrZzFLK3lRZWdGMEE0STFpNGxo?=
 =?utf-8?Q?ddqbR2eMdjtRKlvX0V9Iusn4lN76rNR2SDMR9?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d16b182-cb64-471f-a54d-08df39bd2f44
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 15:14:41.5897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: btAxy55z9klrdsIsJbkVZV8G6W/DKTcMHGMku8X1HeRqZ9pL6+Vf0IEO/WdAAzXd1aC4em3j7RNSVs5zoDWbpOuLqbM/jcFbobynd2mwLxjKahBk+bAcvY/PwpREzcsM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9062

From: Peng Fan <peng.fan@nxp.com>

Register each dma_chan_dev on dma_chan_bus_type before device_register()
and make it a bus device instead of a class device. Setting the bus
before registration lets bus_add_device() take the bus subsystem
reference, so the matching bus_remove_device() calls drop references that
were actually acquired. Attach dma_dev_groups to the bus and set the
device release callback directly.

Keep the existing /sys/class/dma interface by registering a class_compat
named "dma" and creating a link for each channel device. The channel
devices now live on the DMA bus, while /sys/class/dma/dmaNchanM remains
available to userspace. The uevent subsystem name stays "dma" because
the bus has the same name as the old class.

Remove the post-registration dev->bus assignment from the Tegra GPC DMA
driver. Leaving it in place would overwrite the bus selected by the DMA
engine core and reintroduce the reference imbalance.

The DMA channel bus match callback never matches, so no driver can bind
to these channel devices.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/dma/dmaengine.c        | 27 +++++++++++++++++----------
 drivers/dma/tegra186-gpc-dma.c |  1 -
 2 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 3a297f2754915..fa6ebcf63af65 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -239,11 +239,7 @@ static void chan_dev_release(struct device *dev)
 	kfree(chan_dev);
 }
 
-static struct class dma_devclass = {
-	.name		= "dma",
-	.dev_groups	= dma_dev_groups,
-	.dev_release	= chan_dev_release,
-};
+static struct class_compat *dma_chan_class;
 
 /* --- client and device registration --- */
 
@@ -1115,8 +1111,9 @@ static int __dma_async_device_channel_register(struct dma_device *device,
 		goto err_free_dev;
 	}
 
-	dmaengine_chan_dev(chan)->class = &dma_devclass;
 	dmaengine_chan_dev(chan)->parent = device->dev;
+	dmaengine_chan_dev(chan)->bus = &dma_chan_bus_type;
+	dmaengine_chan_dev(chan)->release = chan_dev_release;
 	chan->chan_dev->chan = chan;
 	chan->chan_dev->dev_id = device->dev_id;
 	spin_lock_init(&chan->lock);
@@ -1128,6 +1125,11 @@ static int __dma_async_device_channel_register(struct dma_device *device,
 	rc = device_register(dmaengine_chan_dev(chan));
 	if (rc)
 		goto err_out_ida;
+
+	rc = class_compat_create_link(dma_chan_class, dmaengine_chan_dev(chan));
+	if (rc)
+		dev_warn(device->dev, "Failed to create compatibility class link\n");
+
 	chan->client_count = 0;
 	device->chancnt++;
 
@@ -1172,6 +1174,7 @@ static void __dma_async_device_channel_unregister(struct dma_device *device,
 	chan->chan_dev->chan = NULL;
 	mutex_unlock(&dma_list_mutex);
 	ida_free(&device->chan_ida, chan->chan_id);
+	class_compat_remove_link(dma_chan_class, dmaengine_chan_dev(chan));
 	device_unregister(dmaengine_chan_dev(chan));
 	free_percpu(chan->local);
 }
@@ -1306,6 +1309,7 @@ int dma_async_device_register(struct dma_device *device)
 		mutex_lock(&dma_list_mutex);
 		chan->chan_dev->chan = NULL;
 		mutex_unlock(&dma_list_mutex);
+		class_compat_remove_link(dma_chan_class, dmaengine_chan_dev(chan));
 		device_unregister(dmaengine_chan_dev(chan));
 		free_percpu(chan->local);
 	}
@@ -1650,8 +1654,9 @@ static int dma_chan_bus_match(struct device *dev,
 }
 
 const struct bus_type dma_chan_bus_type = {
-	.name  = "dma",
-	.match = dma_chan_bus_match,
+	.name		= "dma",
+	.match		= dma_chan_bus_match,
+	.dev_groups	= dma_dev_groups,
 };
 
 static int __init dma_bus_init(void)
@@ -1665,9 +1670,11 @@ static int __init dma_bus_init(void)
 	if (err)
 		goto err_destroy_unmap_pool;
 
-	err = class_register(&dma_devclass);
-	if (err)
+	dma_chan_class = class_compat_register("dma");
+	if (!dma_chan_class) {
+		err = -ENOMEM;
 		goto err_unregister_bus;
+	}
 
 	dmaengine_debugfs_init();
 	return 0;
diff --git a/drivers/dma/tegra186-gpc-dma.c b/drivers/dma/tegra186-gpc-dma.c
index e76c58f213d84..71a935d873868 100644
--- a/drivers/dma/tegra186-gpc-dma.c
+++ b/drivers/dma/tegra186-gpc-dma.c
@@ -1541,7 +1541,6 @@ static int tegra_dma_probe(struct platform_device *pdev)
 		tdc = to_tegra_dma_chan(chan);
 
 		if (use_iommu_map) {
-			chdev->bus = pdev->dev.bus;
 			dma_coerce_mask_and_coherent(chdev, DMA_BIT_MASK(cdata->addr_bits));
 
 			ret = of_dma_configure_id(chdev, pdev->dev.of_node,

-- 
2.34.1

