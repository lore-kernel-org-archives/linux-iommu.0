Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2028.outbound.protection.outlook.com [40.92.102.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1001113
	for <iommu@lists.linux.dev>; Mon, 14 Nov 2022 03:41:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PWeD4qN4b19iZ9YIuC1LMHCfU36D6bf92drnmg9WKQiHHWQF30kac3Ccy24oNCnRqGTxYYPzczog/3M1OMWsEUb0+lYJh5ovcJGKaEg+bCbPVtY31j0htkQxQtKQ/K2SrkgjyCaTL4Z6HiwjaD+wNno93kghFxEMSIHtsAMxs5RKe3H9eOnlWMItS6qxqGYH3moMjzrqvkoKYwRPurUpTsZrS6AKnWiMj+naxmfvxhHk49PoVtQ8D+TcTQ/YjCrh0eb5vvOk5OW1AWDdfxmniHytd67NRDItQAtCJhmB2nd1oVSGGIvgQbhWW1sEqXubLKHyfK2M9RNJgiyP0yCu1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/lMmMb1DlSaWsGtY7KUwE0nu2DUt57n3ted0GVRHF48=;
 b=kBqAtiWXgt256JH8orGLN3OLGC7KefTSXd8jMmVn1dvHP5iWem7es+qGJHyCeK0b4ZfZLeQ3E8ONAk7u2aoMYtqJkRhPgEL5pFaHR1JD5ih8qtdw2rILZs9o59KIhOu0lPKNhXiPBiz8VSkdBPY/AYhMAQstt78G7s+hzas5cHTT1qSexHsMAg5U+1cg8E9O8x7aUDKykW07R/FhWeRmipLgsWk1e+KLN2qAW1ILPmoebFHB8wizsqRo14fwkaPRIm3IgIHZ/iiLk8yuZZwKAF4wKA0ZIKeTP0vwy2EhA05HravuaDleOqJywvXcgZjY8hF+CVM9sFoaqGez+u2F7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/lMmMb1DlSaWsGtY7KUwE0nu2DUt57n3ted0GVRHF48=;
 b=G3qFJCQL9WbxTbxW2n05+jjkFCOnDTAxxrOCr1Id2FU9g+Q19Fbb5RIRINYX3PGFkLZDTG966oPLRUz7s9M+xm383sKTKsy3ls08ZcdDzUq1nDlAQh8yMNZX69Ora/tuC4bymKf74hHdMwivh3ju4WsrAPQT2OfNitHLEEfh9TQZtWKC9czQ0WgN2H3KbL4izabx4BMDNjKtC+RKzUhG8uzQD0za1Qur3fs1kUCooAFzf4Mfy/QVR3hXo0Urv/AwmOYgK7mKXeO5iSTsWseXiVUeSxENjm3AHPIov0JicXtlITxK8uU0WwqzNOJ7vE/eGF0CDG8Psd/LpdQ0d3ybbQ==
Received: from MA0PR01MB5784.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:49::5)
 by MAZPR01MB7587.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:3e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 03:41:34 +0000
Received: from MA0PR01MB5784.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::2a26:9a6b:6c95:2cdd]) by MA0PR01MB5784.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::2a26:9a6b:6c95:2cdd%4]) with mapi id 15.20.5813.017; Mon, 14 Nov 2022
 03:41:34 +0000
Date: Mon, 14 Nov 2022 11:41:33 +0800
From: "leo-hou@hotmail.com" <leo-hou@hotmail.com>
To: iommu <iommu@lists.linux.dev>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: The arm smmu driver for Linux does not support debugfs
X-GUID: 06405233-BBCD-4829-81B6-37F26C197D05
X-Has-Attach: no
X-Mailer: Foxmail 7.2.25.148[cn]
Message-ID:
 <MA0PR01MB578424593BE70FB1C1941D41F6059@MA0PR01MB5784.INDPRD01.PROD.OUTLOOK.COM>
Content-Type: text/plain;
	charset="GB2312"
Content-Transfer-Encoding: base64
X-TMN: [mlquKHNRplkV0pNMYS8hgd+G9bOY3Lhhz6u1Dv5ESP0=]
X-ClientProxiedBy: SG2PR02CA0122.apcprd02.prod.outlook.com
 (2603:1096:4:188::10) To MA0PR01MB5784.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:49::5)
X-Microsoft-Original-Message-ID: <202211141141302410923@hotmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0PR01MB5784:EE_|MAZPR01MB7587:EE_
X-MS-Office365-Filtering-Correlation-Id: 43efcf50-c86d-4289-429d-08dac5f21ff5
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6Qi8takEIA3zICKU/NW4XzMZ5waovyhJYHmmSfXjFYMEW500JQuGYr4upFwwNOFOWzo547cUU9YByXLYtEjK0l+ex0D34+qiOkUd6v2tSFo9LH61qyV4T1UfRdoCJYMf3Opl3fsWvqIy9ojGCyEPNjg4stxgT/5OsxZPWLLvPPhIvB36effQurmbbJsLgaR2QAGyLVtcHu8cCvsx2ZHiSGpF5DM4WeQudF7QPWFRiNmF5frifr1xDSSCgAcFLqqqJuAyqdEdC7tl2kZX9EsihBPGFF2rMCy+Ptp6oXobJArtTeQa5ADIvZHHUZaos9kTPZg4uN6qq8ip+D7BmwdeHTv+VyTwAmTS4M9iY9FKbLyWztkJ8oknBz2T+MtiEtQAlMnK40wYF9YHtEIeW/cPGH/unhtfnztqM6BxvA6ndtv1o9bxeTMJTDbVkH7aCPKMCO2A2ibNBilVQeI3a51/yLjzcykoTEO7qx6oIAnrnYth9YMph7E/2c2sCM2QHP+bdbHuJPC1YjgzTAMC4L3AefjrW3MirisxJPi+LzREJRriJECpc27Z2lnRipsbIMJjrMV33MIHIHdR6s/QCq/mHHtgEW4KcJEUJfA0twKCMa/uBxMFrPQ5G6aQtUECoJY7hXmIa0+XuQ0lk7VrkvyETg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?gb2312?B?cnkwdGgzYm5iUldDUUtkRzMyQUNJWHZaUlVoaUdJdjA5L1Z1c1lQSUtya0M2?=
 =?gb2312?B?T0ZlTG1jYlZRRW5LREFMVmVYVnpyTEZ4QVM0Qy9JV3ErQWJuYXR3YzJESDdh?=
 =?gb2312?B?b1k3RHREUTVpbEpkYkx5d3JteHVlR0FtMmZBbUtzaGt1QWVJM1ZCcHNIV2wz?=
 =?gb2312?B?aWVMNGxjNFU2TlQzdG9FNXVUWmpOOXcrVmZPdGZlNXVBWkhIN0RmQmtKUE9N?=
 =?gb2312?B?NjBFdkJWYWUzcVlWcFdzNVo4M25QZVYzdWtuT3N0RE81eUsvUmlzR3Vway9B?=
 =?gb2312?B?VGVPQWVIUHVSb3FhVnlQREM0NlhsVEJCVGYwQTVPRFNUeFhkUGtPQWs4bXdD?=
 =?gb2312?B?bG1FUUdZZEZxR09QRmRaVmpBNEI3NmVrcWNvNVhWT1N2eVlMTWF4NWJWbTZK?=
 =?gb2312?B?MVBRS1FuTkxiTUgyUm5Bc0xmRDBtTlpaK0tNUXNEWHpZeEF5NXdFQjYzbmM2?=
 =?gb2312?B?VStGcmxiUXVuekowbFppN3c1S3AzYVNlYW5paUx6bml5RU03dkFrVGRwWk81?=
 =?gb2312?B?bnZFZnd5aHdTaWxYcVpQdnU2bHB3RFRrUDBnTWJTYzRxcjE1RElJWHcvUXlV?=
 =?gb2312?B?c3c3ckVzNnUzUUM0ZllIN1dNYjIweXhSdys4ODdsNWIxQzlSZ1luQmhoWjRq?=
 =?gb2312?B?RGtmaVNrU3dUZVhnWVJjSmhobWp0c0dUN1d5R0Foc29Bem5VR1lrc3lncE5D?=
 =?gb2312?B?ODdmT0drMGx3bk44VmxHaW44QS9mcDhGNlZYSFdCUHZtT2phYXltd0lVVGJp?=
 =?gb2312?B?QVJYR1VEZjJDUUJOTW5USjBrMW43MGpWWi93WFIyVEhSUHVHdVZtWmlNTlhV?=
 =?gb2312?B?RFBOTzhDWVVyZ2dGalZ3T0xSQkZMNEgzRzlUZmhyUTJqTFJ5aTlGOWFVcWRD?=
 =?gb2312?B?SEF4ays5eDZUa2dsZnBDaU5IMHdVRVpBbHFpb05PMG51TTdzK29DUGJFNFho?=
 =?gb2312?B?cjBoczJUMGFEbmRLTU1QMmxDR3VicDM2d2tmMHdEcnh0eTIrZnUzaDcrQzd1?=
 =?gb2312?B?cHBRVEpnSlp2ZHcyRGFZUkEwamlEQldoZGlmUkFHbVp6QSt5UEtjc0R3UU40?=
 =?gb2312?B?OHBWZDhjQ1dib2lzbW9jRGRjMEhxdGRDZ3Urb3J2cHQxOTFrSkFGc0xybzNk?=
 =?gb2312?B?OGRCd01kY3ZaditRTi9YNzJlUG5xanlJZlFKcUtxSzFBanJxVmlIQkxXNDc2?=
 =?gb2312?B?ZU5pUTBnOEpEV0RwL3NxQ1dla1dGS1l1djc2d2p2NkpUc1hGRWJjeWs3Y0J1?=
 =?gb2312?B?NVhpZlk5Z2gwOEtNY3V1cHpLRGVJZFpHbzF4ajBhWlVRaGxaYXlxMUpjM2Zy?=
 =?gb2312?B?aHFsQ2pXTXdqcEVzeDllSjlJTW1JOXQ1U3kyMGV2SzJhS2YzNHY5ampKZThJ?=
 =?gb2312?B?K0g4MWFaa1p4VWZaem1GWXIreEp6SXVqNUU4VitoTUw0T0VCM2NQWUhGZG5B?=
 =?gb2312?B?M3FWais1eHlVV1l4cW1TVGh6S2NhVFFjRkpjQUFkTnBtWjUyMGlNTmRCS2xn?=
 =?gb2312?B?WWkydGNUTFZzajF2SlpQZGZiYU1QOXlvNDhQdTBxaGkvcDU4S2Njc2M2Y1JN?=
 =?gb2312?B?TDFSYXFhcTlCeGVDNmpoT0NqZTRrT20wcXVIMnpaTXBiYnRyaHBzenIzZXFr?=
 =?gb2312?B?TVNQdFd0YU1kT1dlalhrM1VYRCtmUzdWOGVMNXZlOVl0OXkvWFdUcTRFUDdS?=
 =?gb2312?B?blZyUnZNSExUZnhxbGR4a3dFRnNxSW5ZVDVDdkFtMXh0Sm9kdkovTkt3PT0=?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-42ed3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 43efcf50-c86d-4289-429d-08dac5f21ff5
X-MS-Exchange-CrossTenant-AuthSource: MA0PR01MB5784.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 03:41:34.8718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB7587

SGmjrGFsbAogICAgIFdoeSBkb2Vzbid0IHRoZSBhcm0gc21tdSBkcml2ZXIgZm9yIExpbnV4IHN1
cHBvcnQgZGVidWZmcyA/CkFyZSB0aGVyZSBhbnkgaGlzdG9yaWNhbCByZWFzb25zPwoKCgoKCgoK
bGVvLWhvdUBob3RtYWlsLmNvbQoKCg==
