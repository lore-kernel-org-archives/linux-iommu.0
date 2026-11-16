Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.70
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794798039;
	b=pZkVFJjXBWbFboqY+kQJFWBa6F3Y9a+aHS1GB6lq6CnJoZ43ndFyCiRXKIrADYyDm4gA
	 qZI04ZLiJHyk98iLjVjUiJRINMw6C/NIa2FxOyfUTxIk6mW5kMbmJXDjFoBFrWtNjCjnY
	 bsCss4+dvf3tSfqNpsG1ulIs8OdVfqYqpixI1fXDiZYnelbXUxdbS6Lo5quFOQ3Vo3jLh
	 rLlGZQtke+wPaBkBa1Rmz8LZBtjh0zrOONRpFKM2hnrwgTgohifBqE7it01r8ddETA+cS
	 WKJ6gmERcOrmm/1HF8qBfYydxM1J7+0o01mPQWVvxI7JKl1i1onwv/XbocJ0ll8RaBg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794798039;
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
	bh=Ae6bwlTuudYGERs98XWGPQb4qytT4DEwkhzrvMre408=;
	b=izNay9ULH68Q5twyyrcUHYM3GRT4FOgeQDCqLjXVJzSUa13KwJDZbWbYArfkN0PHGnpa
	 5TghfkCT0chjIGEh7wRcoEUJAcqEcDIsKovDZnWPUReXs9hjFn6GWluw0AzXJ62ZTYmXs
	 pBhhJWTfdai2XI3R6qmBQbUx7SZkNZG1WE3+Z+waOikCH26gfSV/uQyGR0+MuNRToGLfR
	 Cece7mElz3NUD+nV7S0JownQFhyAO2oD7X8c50BAdHqEqVIIPTnHBaCoDnLS8lRx20CKk
	 R12RNh8sv/gSn53fYrBqhT4HScAN0xT4xP1q7vYRwazIXNr3cSgrdAi0He9X6fFo4dw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b="o0+n/gMG";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.70
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013070.outbound.protection.outlook.com [40.107.162.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD36C606A329;
	Mon, 16 Nov 2026 03:00:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD36C606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=o0+n/gMG
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N3CzL5f4Uawfw9oUxwCH1GEdQ30km70x+UoENS5D41y+D2bvTLlB4QoVIxjntDuvCNAPsD5M7mME4LERsC4zZ71oCafTNTX/PcEJvxhgHLK7uJZLgatPsujX+GXSO+QTu79ZNzbb3bFH9AslcDbU0ftIU3lAD0w7rsgva+ngqT2i9mk5F1HbebcX5OsWUvSf0SIskdJ2zdRykb8hdo9Ss4by01UfLSC5BMOY3Dlf9N+PqYXCc9MQqPvvpbKp7kkMhQwsjiUodWyeuyb0J8ljpGOviKcFxJgRZVwQtVvWZJncwwXqO5a8g5OhSyxfDb0ugjIjXk3bnWOKjemtz9pFCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ae6bwlTuudYGERs98XWGPQb4qytT4DEwkhzrvMre408=;
 b=KyEXNQZXICF1MVDX4CenKytz0EWWclQCNA1vMbq5/wuoMqQVL/PAg4xU0VwXCVgblhUtWrew4UghhiyMS4/Gk2ntih2PSX1d7rl46qBv9XndA6K//OipAeisG9FZS1d5M1GL+E3g6L7cpZHvXy9Pk9ZPGaCS+uc2VoG6TFPnWP4XPV1SvVmdgCStLEVsk5te2eqHvaKjpc6hEB6TwdDHhBz3eLUMB2jx6CiLHREtbajlwrh6fLMdAlE0J8T8rBOkMtQcsDHfD+2fpkeVSEhP2G788+fC//+Ya9BGQ3EKi5pIuz1D0ZcVYuIoOrTQ1YkxvPg5/e2MXGciletcX3Va0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ae6bwlTuudYGERs98XWGPQb4qytT4DEwkhzrvMre408=;
 b=o0+n/gMGFuNKlJ9eyz3f/XDnI2m9mpohYgqJrOetOvXx4xxWSH6CZdoxHKVvlRHoropTR6BROLxQE/DkoTc3B4OKwEduQ68egYNfBZniwVZ0r7BgUpSHbgF8YNjx6seaiDDg6Z7Nm0nN7AI37Y+S/5tKZzit5Nu/uvvF2CSbmIX3xIb7WtpOKnQ9Kduggnp+CniIXz1kriV1EjvvFnLtBufbEUZ8nf9Si2Y8QTiXtpVGzgkC2xsZ85AURb7qzRL6MLbt8nIMeNKKFvKyDtB0bCYiNOzCIsUqKvJ4KY0cpVZPjW/VfxvTV5s28i+njJnNb5zNcabMEtfVIzC3E3jlhA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by PA6PR04MB11778.eurprd04.prod.outlook.com (2603:10a6:102:525::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 03:00:36 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%5]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 03:00:36 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 16 Nov 2026 11:05:22 +0800
Subject: [PATCH v7 1/9] dmaengine: fsl-edma: unregister channels before
 vchan cleanup
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-edma-iommu-v3-v7-1-32794ba8efbf@nxp.com>
References: <20261116-edma-iommu-v3-v7-0-32794ba8efbf@nxp.com>
In-Reply-To: <20261116-edma-iommu-v3-v7-0-32794ba8efbf@nxp.com>
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
X-ClientProxiedBy: SI1PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::13) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
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
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|PA6PR04MB11778:EE_
X-MS-Office365-Filtering-Correlation-Id: 8224ccb9-4dbc-45e6-8f10-08df438dc95e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|19092799006|921020|10067099003|11063799006|56012099006|260925022911599003|260925021911599003|260925021311599003|261026140227099003|261028144727099003|261022105027099003|261021123027099003|261021121427099003|261102123227099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	8Vz+cqBp/+B2AXvGbiNNMbX4GbWEcrb7tqy927abQzEQ/rXzghcDP8cBGXoWBF63/T4QoBl9P/6oWhK3c50n/G2EBghi/eEBix9j9SJhgSFTAZKaQqcZ4/zXUenMfCyZxolQS/rvHSLsITDndyN0+c7vJbRcaCHdXTo8WP2QbFzhYKx1q0vRu6oZCB46jPGh6cs/UaNdrW0t3hmWNz0CHmsFnz/jM5Vlja0cbK0XIrzPk1Z/VSBuDMvsxRkQfBxQrh8RXjKHg0DsdLyYCE0y9swK0gZi6oY6mdNefVqYJo3MUfZ9I1OVbBVJoheS0u36IpcwLf6MpMEo8GvKHYljLCmqBB0Yv7FwUf7/awU/LXZ492c4B+BlkLhhTOMgm+E84aupUa2vGrOA+IwGQrEC1Yq9e0R3OSOdRR0FCzfHsS95e1IV45EtyTZNi4f58sYOJSNuK2Yr2AQM1k9xIzM2OKOHmG+/sk8vTp/bOkjVIJnzM0HA4dib0ZkKNoJVk1nmvpYnpZ2eulYiRXxXycjVTEZDjwku4r8wy82n2oYD7lkycduW3x8dnnwdnH0uJd7ZQa4+OkKPOsY2TjZe1I2wvqVQ2rK9JbgBzgm5T8sku2czHplsRMXYZikMloNHg0PA60wILzRUUzdONuI7E4EbzdlRRFOFzauLpKLGe3tuZr42Y2DOhkqq+9kNtdQa+nZEtCVBdA0RIMgLgC86tn3O+Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(19092799006)(921020)(10067099003)(11063799006)(56012099006)(260925022911599003)(260925021911599003)(260925021311599003)(261026140227099003)(261028144727099003)(261022105027099003)(261021123027099003)(261021121427099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q0dtN0t4RkIza3FuQ3l5eW92OG56M1h1UDVQNHo2TW92M3ozNU9JTUowQ0h3?=
 =?utf-8?B?aGlyYjNIbWwyS295U2xoNHZtaHQwTmVYUlFpbFFxS2wvajNRY1JBSlNaZ3ha?=
 =?utf-8?B?WDlHZHlkL2h5c21XRmFWUG1JU1RpSGNYaXRFMU9heXdnN3FLd2lRYytBNFUw?=
 =?utf-8?B?NUxzazA5eTdJdDY4OTQxOTZ2MVVsM3RKTEw2allqT0hhcHpBN3YrNktkdWQz?=
 =?utf-8?B?UU1kZC9kZUVCQ2NCa3A4c1ROSFZuZkNnLzFFQmdXODUwWjNWY2tORS84enkv?=
 =?utf-8?B?QS84di9OVUE2RE9QbzRqcWZJZXhCcSt6RXA4cXRYUmFwTXZ2YzBpbjI4YUFX?=
 =?utf-8?B?UFhIb2VGU3RnWjB5UUY1M090WlNKWFMvam84TjRPamk0V2daUzNGcmRleHM2?=
 =?utf-8?B?Ly94WnJ5cmJpYlRIdnZZUFBGWFBqcWZBWkMrandQRXBVbkxzMzVkWHgwdU5B?=
 =?utf-8?B?SG5paWoyUHViZHhpNXBFOHVjeTkxM09ncSs1N2FJbjV3ZlFFZUxlTUFyREtK?=
 =?utf-8?B?Rk5sRkljbXBVMUx5amxoc1kvMk1EdlZub1U5Q2RaZ01QVDUwNEh1TVdvN203?=
 =?utf-8?B?UnFHNjJUeHZzaEJHenh6SzZWN0FBUnFHTm5HZC9YM3VKNlhsem5uUVBYZ25L?=
 =?utf-8?B?ZGZXOGdaSFpaTDdKZitxV2FvVmhlNnh2Zm5qMFF1NzJBWXFHT09lMGFPL05F?=
 =?utf-8?B?S3g4ZlVlaHNCWXlVVmp0OC9TdmJZSS9ITEtvck12UkhpcjRPNW5VK1dncHYr?=
 =?utf-8?B?M0MyY0wwbzNPekI1cVZ1T0FYckVHd3c0azYxdmZOYlh3Rkx6MVFENlNvZGNz?=
 =?utf-8?B?cEJTbkhmSzBPSmQ4YlQxL2tCQzZSNUFjbDQxMHo5cHhWdG1oeDcxMEVIK3VV?=
 =?utf-8?B?NUxkSFVaZnEwQ1JHTDU1YVV1cWlnazlpY2lnOGR6ZGtma05KUTNNSGdtUWc0?=
 =?utf-8?B?UUc0RzRKYUtUWC9jWEhxK3ZBL0JpQUtXWWdPbVFsMTZycU50czY5U3l1VCs1?=
 =?utf-8?B?WnZzU2g0Yktlc2RXZ3JKUk0xY0QwTUU1dmZDdnN5WHNTYUsySVcwSWVKeUhk?=
 =?utf-8?B?OTlIazRQUk0waGxSSmtxejJ2RGw1RlkxTDRUZFczS3VIN3NCLzcyY0RROTgw?=
 =?utf-8?B?amFxVlJadnpNV1dtYWFlb1JsYXJaWVlGVlE5NG5ud3Frblg1RFVVcmZaaVFZ?=
 =?utf-8?B?V1FTNFR5YUI0Mm9QS2UwbG85YkJlRmlkSHpqOVR0Vk9RRFFKRStqdEJDSGZ5?=
 =?utf-8?B?eGtmallFOG9WOWwrbG82UG55TW5QRDdCejhVOGVRaDFFWC9jNUdtbHp4RCtu?=
 =?utf-8?B?SDMwQ003N2JIbzVjQzR3ZkpYTWN5dW9uQVRZVTZUY2EzNWVxOW1pM21UK29h?=
 =?utf-8?B?THFOZEJ0QkFGL0hvMWlFbEFjQXhDZTU0eUtuMjVvT2ZUNUJReE5RWTVRQ3JG?=
 =?utf-8?B?bXpZT0FPVkx6ZHducUpSQ0hMVEl5Rms0UUNhcFdnOTdqUFdDQis1dHdSRW5x?=
 =?utf-8?B?V0dYU0NqYlp0c2ErdXIrK1FQbXREUUREM041VDFFeG45KzdiQk01R1p6a2Ny?=
 =?utf-8?B?ZkRLSlhTZkZWZk1VVEFKb0cvVWxqSWFqK0J1RWtNSlNXV2dHZVZpUk5rZHUr?=
 =?utf-8?B?Y0hjU2hMZHBYajdOOVgrN3IrbFQ1ZkR5T2o4L3FpczYwa1BUckNnaXY1VGdN?=
 =?utf-8?B?UXdnai9CYk1Ed1VGdlZwa3ZNTXVoWDJEZlpja3ZIS3JPTmZZaXBXVUZ3T0R5?=
 =?utf-8?B?MkpTZUkzY0lxZS9aYkordnYrWmNFWjVvaTc2YTNmWEFLc1Vzb1YrS1FRYWIx?=
 =?utf-8?B?aktoMHBPR1ByaFdTb0RHeUxuUy9zOVVtM0crMk5QaUYrTnZMcitOWWc4U1M5?=
 =?utf-8?B?S1JENkhQYWYxaUZFa284YUNyd2M4aW95MGg0a0tuN1lTbWEyY3VGWGtDQlJ1?=
 =?utf-8?B?WEZyeUlZRGU0VTN2OEpKcFJZbHl1Z3hTMi9zWGRNOTY1MGpKbTdDMWU5SG1y?=
 =?utf-8?B?UDBoa1FaaDVnNnp2eS84NU5tQy9uQm9oVloxZ0pMU09HVEdqaHAxdzkwa25E?=
 =?utf-8?B?SWJyZnhhZlg5QmJtakhDRUltSE1mNWYrRmdzQ3VmenJ4WlFoRk5QdHh5OXFJ?=
 =?utf-8?B?SVRLRXpOQjhTSjc4VERLamZBRFovdFRjcVExWS82OE5CbXBSQ3Noc2tldkRS?=
 =?utf-8?B?aGFBS3YyWTRWRHZONnJXU0t1OFJWOWJhQndDL2djbkljL0Y2cEFhQjMvZXR1?=
 =?utf-8?B?UjRvNHJmRTJFWUZRVjJBWXI0SXFmV01hdEdkVjExa1RNVlBpcjN2WGp6OTc4?=
 =?utf-8?B?Q3dlVFBXNEcvdmZoY1ZwdW14anpzWjdoZGt0azZnSUQ2bHV4a0dEa2dHZEFX?=
 =?utf-8?Q?Fk8OB3m8BYJ6zOIi70DcYzwtx70z06cmQTgTc?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8224ccb9-4dbc-45e6-8f10-08df438dc95e
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 03:00:35.9082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GM7mnuuroH/QkJAIHI/hNA/JZ5rcbDLUQnvuHrjITMcg+NXjv/eG1mzSAGMUnMU9yoVRrhWOynhtWgzjI7a6zIygVzf900I+ZXHqKe4zN0QRd6B4mkHuRZW7Vk1EpfeA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR04MB11778

From: Peng Fan <peng.fan@nxp.com>

Since commit 4035726a6b72 ("dmaengine: fsl-edma: Use managed API
dmaenginem_async_device_register()"), dma_async_device_unregister() runs
as a devres action after fsl_edma_remove(). However, fsl_edma_remove()
still calls fsl_edma_cleanup_vchan() first, which removes every channel
from dma_dev.channels.  When the devres action later runs,
dma_async_device_unregister() sees an empty channel list and never
unregisters the channel devices. They remain visible in /sys/class/dma.

Keep the vchan cleanup, but register it as a devres action before
dmaenginem_async_device_register(). Devres actions run in reverse
order, so the DMA channels are unregistered first and the vchan list is
cleaned up afterwards. Remove the premature cleanup call from
fsl_edma_remove().

Fixes: 4035726a6b72 ("dmaengine: fsl-edma: Use managed API dmaenginem_async_device_register()")
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/dma/fsl-edma-main.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index da5139911488..7f82dcb7831d 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -31,6 +31,11 @@ static void fsl_edma_synchronize(struct dma_chan *chan)
 	vchan_synchronize(&fsl_chan->vchan);
 }
 
+static void fsl_edma_cleanup_vchan_action(void *data)
+{
+	fsl_edma_cleanup_vchan(data);
+}
+
 static irqreturn_t fsl_edma_tx_handler(int irq, void *dev_id)
 {
 	struct fsl_edma_engine *fsl_edma = dev_id;
@@ -881,6 +886,12 @@ static int fsl_edma_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, fsl_edma);
 
+	ret = devm_add_action_or_reset(&pdev->dev,
+				       fsl_edma_cleanup_vchan_action,
+				       &fsl_edma->dma_dev);
+	if (ret)
+		return ret;
+
 	ret = dmaenginem_async_device_register(&fsl_edma->dma_dev);
 	if (ret)
 		return dev_err_probe(&pdev->dev, ret,
@@ -905,7 +916,6 @@ static void fsl_edma_remove(struct platform_device *pdev)
 	struct fsl_edma_engine *fsl_edma = platform_get_drvdata(pdev);
 
 	fsl_edma_irq_exit(pdev, fsl_edma);
-	fsl_edma_cleanup_vchan(&fsl_edma->dma_dev);
 }
 
 static int fsl_edma_suspend_late(struct device *dev)

-- 
2.34.1

