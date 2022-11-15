Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2028.outbound.protection.outlook.com [40.92.102.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCBD7C
	for <iommu@lists.linux.dev>; Tue, 15 Nov 2022 02:28:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gnHt4id79AwZTX+zXy/fIYnhHySyhkWRLxle2Zh+6UfOHvR3K+yPZ6QrCAfln8jSYVTxgjtkCdR3xf/4IZcl+gTkFdFoDS5WiTbmB9+zu4WkBQwL8dtnme0IPB02/176igh5G0M0TTOkR/XSzzMSQncdxkeekNq6a4mDYH0cBu7ELfprcopJ+B/gkQ+MdgSQARAvoTNyP4onaDWAO5pq89b3ssPlirWOQ5UhzIfI2JUQVOPuWgTaYqCsaqE74IC+FcK5ESBtInbVhfXa4b8kV+nfE0d7/L2DZnV7/0soBzBRQOb+SkTc0T332MA84NZmFR3Vbl1mqA+PPNvFa048Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O694lQlATbSo21IN2QSLbg/yzDXSg5rBpbBQsRT81sU=;
 b=cDuugP23jvOcrwrf1iMMbCdW43SMq+xk+HYJA/kgQ2KYze3kQIfKsiE7APmuS/DPNyPSp/JXW6n7QCTU6De+w9GqNvxOxQ+A75Vts8ldkXXQUrUhbVcLqiF3Xpl7NcbU8BB+VhFFNcKcFTkDdzD0cJDkAnx9029nrRsgcKimfl3/2TpuG37p+9+bu0rT7rxHZ1n4ICbVtvywOc1BwT+JSVGze21zS++QjpJZZYB5E+gboK1mkDjoPrCj/b/2qVsD94rxQOi0z174T3S2IayvImZFcnq533kLqSpyTfZnBGeoSiL03uzKq6pz9EQH6/tmneRueurkPT1eFqf15Kn8pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O694lQlATbSo21IN2QSLbg/yzDXSg5rBpbBQsRT81sU=;
 b=kuBrjiiJoRrA6n9C5Wvlcoo0nIzXinbjQBBTRjUQR0umlr1MSXVQF1txr1P6NFBuZTzYsFPeUyxtARlBVp+F2ZhOLzfbrPbMwh//w18/J5Jcs2zZuqbOWqmYI3b7+9SRDapXyK/pJoVQIZnWoVyGABgWGhdB7W2vC6p0bsovGZvj3LAvLzdGTIJGXC5MW8RNm0BCn2wmAxbDD+ElkPlJGuBAqpp/V/pxmoPLGNPSRejjThWJ5XreSGyppB0MiiAOZzGFApr9SdhlhaYSVSnk2ft1Lf3/hVyqSlMTF8D9lTgNRJFGbxCprqzYeY7vGvXVC4Zw9rtnN7twPZFNvXtOzA==
Received: from MA0PR01MB5784.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:49::5)
 by PN0PR01MB5605.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:60::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Tue, 15 Nov
 2022 02:28:07 +0000
Received: from MA0PR01MB5784.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::2a26:9a6b:6c95:2cdd]) by MA0PR01MB5784.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::2a26:9a6b:6c95:2cdd%4]) with mapi id 15.20.5813.017; Tue, 15 Nov 2022
 02:28:07 +0000
Date: Tue, 15 Nov 2022 10:28:04 +0800
From: "leo-hou@hotmail.com" <leo-hou@hotmail.com>
To: iommu <iommu@lists.linux.dev>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	virtualization <virtualization@lists.linux-foundation.org>
Cc: will <will@kernel.org>, 
	robin.murphy <robin.murphy@arm.com>, 
	leo-hou <leo-hou@hotmail.com>
Subject: The arm smmu driver for Linux does not support debugfs
References: <202211141141302410923@hotmail.com>
X-GUID: A0CDDC7A-FF99-44B7-A385-9F980D81722F
X-Has-Attach: no
X-Mailer: Foxmail 7.2.25.148[cn]
Message-ID:
 <MA0PR01MB5784354703A7B446A6D85CADF6049@MA0PR01MB5784.INDPRD01.PROD.OUTLOOK.COM>
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
X-TMN: [+4AAeK721X8xtxcZZDfOZQF+eQ/KuVqAegaR7gdnN7A=]
X-ClientProxiedBy: SG2PR04CA0199.apcprd04.prod.outlook.com
 (2603:1096:4:187::13) To MA0PR01MB5784.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:49::5)
X-Microsoft-Original-Message-ID: <202211151028018346134@hotmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0PR01MB5784:EE_|PN0PR01MB5605:EE_
X-MS-Office365-Filtering-Correlation-Id: b073e787-5ee4-424c-eec1-08dac6b107a3
X-MS-Exchange-SLBlob-MailProps:
	Cojqxok92mql2wCllm+5x2FJF/bjNawhvKr5FypNxYSd8Q8hRXCcoy9Rw50fUFkerqqXOFG2YI652PBeSV2G7v7zLg1LRZCw+Dp5srykm7sjeLcMkM0aBOdtWdcUKXrcAjlowVs49hPNF+HPuPp10ygv9eJsBg7lSUui45ZkJA4h7GER+DusiAwR/qvKzQeU04s1H9b/AF9RETMLSqGeJGDIiDAtKYtcLTUrn2BxkaNOwpGK7nfo7h1hfKg84cW82DFY5G+noGdSkRhn2Pod0dWb5btYlIfNYrii5V+vzdrvuPWGzromIXWBIDYb5c3u2Iw3udxJl7+hrEVwwB9KCIU+2uheL/vcLIregaIft8vbOZQizg7eQGuhUKJVNbrWiz3R+y9LlhXLZiEw5hETqhkCw2mAVwnVcVHL9Lu8u2FM7yKdAdRYV1mvBy4k8tZmRekK/PCpvFYNQJiKatqis9mH8cPFL7lMuAOa4YGn2v4uko5wBfpfCb3a0JR6xpFsKxvz9eGz4o9FJIJlRGM8YU40oi8sXEe15lW5SMD/YNNfZELIU4FHkIAobBCa+oHYaBa3iBIAEynXIFlKUWV3J57RoKnELTFlOr2rJvTUrrGLYTE0vIVTOmYbPQFaZ1vpZ4Qk+FTII781SVIrWDlFteFR122aB4ODDaZKM5owav2YVz5Aw1Po8XX3NswEk3SX
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	A0yx5g6pvdbw0d3fCVV2rXmciqHlT0fZMRkx78n8VvOUnlrFe3wQB2h/b3AfjO/Dn6JnFDhm6fpv4mksy1K5WujSRhKJDELzu35Zs8QY2iBRenDGZ/tufe+diMAJwYLOg24F4rrA4gyfwUmmdQUzBmexsoL8y7PFFJzaeXUoM+IamBuMoQgyFv3x5MSoCMgE7oHz/09TwiT3oAM7+y9guvPV6vSUYwMpf+1OjU1cNae/1rgx/jP/rrGxN7pjiPl1nxVAMGK4HyfmIyrcVV2MhwfDHI3tnq33OisHKCDM4kxwa0UZgNSs3tuoClxuTVYKlak2M2CeOz/mTzj/uAND+7MpCediFWxSrPFuk++fsEnmgIGsHiJjtXbcg+BV/T36TbB18kE8nxa59o5hggPzQmgfgxJT7ZOOC7znJog9DytusSvVDSgBUr3wXmaFBnIGd1YGDngVLFOh7/dlWeqUoleq3KcChMYjiqp2cfWDlu47AS3NzNiEazMEVaWhjWtfuSpE3YdKsVQB4Bh84eGuVKarBFzzElBnpsHdsyVAmFk0PMPDVn1KJNfXyparzAcNLCu4S0CkZF2x0tHXJ2l456Gzr0uMT8MaspHVyVHljSscKZKejkUGUwFFIK8VOFn1kv7oiZcHVVyGgMJbtuTHgzw/6yvjNDxkx/EN38fbj4n1jsF+gSnR0I545KXRuVJHiwg6lAXQbJGgyxis/l1GWbHcHYUNq1f5Myo5xFy3EWM=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?STVTemFGTlN6L0hGR25kSWM1MGR1NlRkVUhtWEZxTXZodDJwNHRYcEYrUW1o?=
 =?utf-8?B?ZDhJemFmUW5Kem9QUnFmcERsS3Uva0c5WWZaM28vUGhrU3RFZ3ZoQ3Q2aUxS?=
 =?utf-8?B?REJSNDRyWWZOejZQY3hiZm1DZlU5L3Z4eW90clcwRUVlWmtXdHlCdWxEMHdy?=
 =?utf-8?B?RVJqY2E1RXFnWGNWVWxqVlNIMlV3N1MyRG5IbmRuVDAwbW0xSmZCVVhJd04y?=
 =?utf-8?B?OC9MOFJhbm1lQklTYmNGWHNCcUVjZ0tWalNCSHVqWklBTCtDMm5mbkV1Y2Jy?=
 =?utf-8?B?NXlzS3QvSENxaDgxMG1weUpZYzdwU2g1RDlaQk96ZHFnVDBpS2U1QzNWS2NC?=
 =?utf-8?B?SUoyZDRNcldvby9jUlpnYXg2VXpZcW51QW9JRUlkTlZJV1BaY1VuSThlTXNo?=
 =?utf-8?B?cWorWDBVdXJsbHJBVkgrVURmbktuMHJqL1ZtY1E2c1JMS05IRUNkSDFaNVNC?=
 =?utf-8?B?ZkJpUVlzK2hORHUwR0FBaE5KcmQ1cDVTcWFhb2FUdUc4TEsxTHFFd2IxUnZl?=
 =?utf-8?B?bDZDKzZma3ZtMGt3TjIxS2hlV3BxNk9iRk5OSWh5RW5tMFF0SFpXVWR2Wk0x?=
 =?utf-8?B?NmRCakt2ZE9acjh6dExVK1o3T2lDemhvVVFoWVlzclY2dDQrdGJGcWxhYWFT?=
 =?utf-8?B?QW9vVUpaN1BhZHZzTUMvY1JneW5MVUJwYXRPVDhjQXVhb2pSY2hmY0NBcDNF?=
 =?utf-8?B?SFlIZGkwOXpzUjYzQUwwQ2dpTlVHa2dWSGd6REEyNkQ2Z0VCTThycjZ4NFFk?=
 =?utf-8?B?blNmY0R6WUlHOGtVTjdTK1VYN1Nrd2V6WUttM2NxcGxVZXJrYUl2VTZhSXFm?=
 =?utf-8?B?SFlFZTl3d054UCtEQ0R5NGdQS0xXWmdJSHdGT1Y2S0pUbFliZXFKclVEZGpr?=
 =?utf-8?B?alpVa3NMbkFIMUFFNzNnK214QTdqWEFDTG5oMWQ0WElMM0praWw1U2tEM1RT?=
 =?utf-8?B?TnVmTDdmY240dWpGL0FrN3pmcFp2anpiTWRGU283b3d2SklBK0YvS1lMRFg2?=
 =?utf-8?B?RG9nSkk3bUQ5ZXQ3cTJQVzNKcTV2TE5leXd4VHV2bjJXcXhxM25yV1p1RVI5?=
 =?utf-8?B?U3pLdEpUR0YrK3dXMlhMM2FPYURaeTNGMDJhMytwRHkxeVFhbXpqZkovZjNT?=
 =?utf-8?B?Y3FXOUZSV0txaVRZTzBHeFVmTEJZNGV3UUE3U2R6N21LMVdiKzlyY2t4R3JI?=
 =?utf-8?B?d3B3TnQ2ZVRuUzFHaER5VFJrQklTM0lRNTc4TW9zYVpkU0ZRWFI0Skt4eVNr?=
 =?utf-8?B?Wm5YNExaenIvRDl3bEpaNHVENUpzOXRtcHNCbEwveWN2L2tMOVlVOHpQNzhv?=
 =?utf-8?B?VkhSNEZRWmxNVXczb3Z5YkJlczU0ZHVqSVZTQnBXNjI1VzFXaCtHZ1FGeG1s?=
 =?utf-8?B?RGd6VDVDVzNITGpsaHVvWUxoTXBJUFUreXNzaGgydFN3QlVOSDRRbzlENGlO?=
 =?utf-8?B?MGF4Y2dSa3BPS0pNWjU4cmxKSTFXSmRDdXFzWXdRS0tkUEFUc2orbUFueW5L?=
 =?utf-8?B?RG5XZ2pNYlZuVWhqbDNreUZCZFpiTnhlNW1ZVm5sU1VKalQ2MEg0YlpiRHc0?=
 =?utf-8?B?QzNnQjJNbnZtbTVhSTZwRjFpaVJPN1hJVjlrek1GNkplRGhpVDMzazdEcGpw?=
 =?utf-8?B?Tk9QU1BoS1k5OFIzd0U1WEpjZVpYRGpacDkrOVBSZ2xPNXBZNkpkTmZaaTdx?=
 =?utf-8?B?Tkl2b29nY1NBMFRvTFRYZUthRWZZN2ExZDRKVHZLNFhHdXBhT2Y2KzdnPT0=?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-42ed3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: b073e787-5ee4-424c-eec1-08dac6b107a3
X-MS-Exchange-CrossTenant-AuthSource: MA0PR01MB5784.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 02:28:07.1834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB5605

CgpIaSwKCsKgwqDCoMKgIFdoeSBkb2Vzbid0IHRoZSBhcm0gc21tdSBkcml2ZXIgZm9yIExpbnV4
IHN1cHBvcnQgZGVidWdmcyA/CgpBcmUgdGhlcmUgYW55IGhpc3RvcmljYWwgcmVhc29ucz8KCgpU
aGFua3Mh
