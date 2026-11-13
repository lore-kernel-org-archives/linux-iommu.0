Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794576209;
	b=QrXWP/mG+yCQ/zPFJ16Hm13hWvBaYa78fLBF5j8tTrsWdceD+kbJCXE/HjgSuWOKAHDV
	 IlEkbpHT6F31p6ZWOlcfNU7rTCmCDYhLKHO5VYs8cQk329dcjRwFmEtA29OtsBlU2MW7Z
	 gNRXp3c5y/CmwQ2XiF9FS9s5/cQohUjNbB7MK90TkqHNZaJveM5kQiRIfOHSpxP24TrAL
	 0GdPnKC4rttat/Unvzs/i3+WqVTNE4wxErHHC1AaqD9M3SNPrgV96c5IUqvYHFtpxAexz
	 9Xf0aLRacDXtfFqF4YJpUssb+3YKnqWq/SVdN0f4M8J2ULK+qFAenbtfEDThBhCpoPQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794576209;
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
	bh=/Bnkn8Vf1EEaYR7RLcnQOlbGPOhCMSEvnRNwN9pGwZ0=;
	b=Zx1F1i9D02CRGrofGXBvETgq4HgGwa8ImxnjD4UT1pQUowXF2+Vj0Ru6xktAQT9+w0tk
	 ac45oqWaGh+f3SM5Q4YXaIbonBAt1dAYoT28qcDCYrPYc+JXcer65BQ5Q8lIsY7VRZImH
	 +8voRctL8NZGv2E5Er0njgYDDkqhEgCwr2utHImnlpVw1RUWG7U55tA2JA1ojgboByn/p
	 6wCHmNuZ3fKhJQwr+msvohogdLdHOjiuSF2Ux8B7dpHxpA8H1uNewehL0ln2+O2c8KV3e
	 uAb0kpC4C1iaj/EmfjEvnKrEs+8xyCcqyO33C7gIzlVavdeeJiLFwUTOPTFyuQ4cjxA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=aPD2NMO6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.45
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010045.outbound.protection.outlook.com [52.101.69.45])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1443606A89D
	for <iommu@lists.linux.dev>; Fri, 13 Nov 2026 13:23:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1443606A89D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=aPD2NMO6
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ulchIREVUnZQYOJ+pXSxsIbuVkbRrBxs/WXTK4Q/Q6A2PcZzMhUVO8t5mrljbaQuBT38xLQEyD/l/2Wnb4di9GEQNSek1Ws3sLKCWcPN+SjBu0KJfkZXV+82Rv67J3qcPsIdOSZ9JLBGtltqKUJh5DDG8tQSjHyLFhIEHcioc3v4javCShXH4SWLfCQOXqvMl3k9UI683oQm63XRR8bs2lVWTATyxY/c7WsCy5CuO8IVXKUzs8uk6bd7u00PZMRIP5shC4RDzg+vL91jMK5p1rBH4e8xZ4fwQrp2XTJT6MVZmtCrgq1PKgVc+rZ4SQIxfBTrC9rqFw328OdrbzcxUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Bnkn8Vf1EEaYR7RLcnQOlbGPOhCMSEvnRNwN9pGwZ0=;
 b=rxNtOdGYaws+82plv2onkD4Mx72+wit4819ZtvSn3g8/UU59HbSzQqeOqk74i2Njv+ibChxambnYRXSv5CB5pcR4FL8TrBYGaq8TCdup2oXePfPDaVjlKOJ1Ey6lMfZtsgGgtsa1rnOTu3tiZ8j3tTnQWeM86anEkn4ZHNZYMB0jUpNzhR2EFfHLWq3rGu1MSXY2Kb1v93GcVcwkuW41NPAbFbSFcgx7EsyxBMRyI68iFxRYobg7eMJuKKUtM0ZdooMP2IMg3OmGeq+0Ri33gSBkpQ0LlMfHXqAi6J12XctMZgD26TpdtFbYAQVvN5h0NIEkn3T3v5oNzN0rQ4+fvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Bnkn8Vf1EEaYR7RLcnQOlbGPOhCMSEvnRNwN9pGwZ0=;
 b=aPD2NMO6DYxdpQAlqx6XsGc9JOYLVdjJA/lZwiWMbOxe1LYwWMatS4j1+LB3Qyta3jRPoYvvA8rm3rbhjI2xKWhkd/+UNk3pIIXNovnDkD+YlSCy9px0Z6HC3OQSm2oRJqVnhrFK9Yfw+ntz0JN6Jws4OzGjXLnUZ2WKbhujleWXLAVKE/FqSDCDQLXwQewxRyKKf/kJJccU+unbjkL3Y412SEyEvRDB4LY5+2aF8Xy94QuzC9/m4ecnKrG70QEoDakBZH9XQ/d1I/xAqyvhinlezCxfaoYQ4EUTvoVSDEp+YgaG+WBo5VJPPlPbAazjSmYl8Ih4Bpm+Z4uwBMYCzA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by BR2PR04MB007356.eurprd04.prod.outlook.com (2603:10a6:2c8:6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 13:23:25 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%5]) with mapi id 15.21.0615.008; Fri, 13 Nov 2026
 13:23:25 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 13 Nov 2026 21:27:19 +0800
Subject: [PATCH RFC v8 7/9] iommu/arm-smmu-v3: Wire up shared-SID STE
 ordering and feature gating
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-b4-smmu-shared-sid-ver8-v8-7-587307a77f3a@nxp.com>
References: <20261113-b4-smmu-shared-sid-ver8-v8-0-587307a77f3a@nxp.com>
In-Reply-To: <20261113-b4-smmu-shared-sid-ver8-v8-0-587307a77f3a@nxp.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, 
 Jean-Philippe Brucker <jpb@kernel.org>, Nicolin Chen <nicolinc@nvidia.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Thierry Reding <thierry.reding@kernel.org>, 
 Krishna Reddy <vdumpa@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.16-dev-7bc12
X-ClientProxiedBy: SI2PR02CA0041.apcprd02.prod.outlook.com
 (2603:1096:4:196::20) To AM8PR04MB7874.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|BR2PR04MB007356:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dca71f4-b494-44be-e77d-08df41894bf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|7416014|376014|23010399003|1800799024|18002099003|22082099003|6133799003|921020|11063799006|5023799004|261102123227099003|261026140227099003|261028144727099003|261026121527099003|261022075727099003|261022105027099003|261021121427099003|56012099006|261021123027099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	Oog0j7bEo+rISGBw5yoS4rJNjYqWmNEX+VEMzprB4xkHl21+ygL2SEVH1C4DO9fTOXc3sZHHwZMjT5i3oPl+BjnYTVSVfVLNyduZWyYxnhmlLuB7dgkH/Q6owsvkCLwYpYPeGidLZyALVKa8SpKWDf+x6hMyHognh1qhcXb5bkmgnj3ZWl8jNyZ1OKcIynuu5H/38qV4gKMpT7ld8kyPXQ/MjcUVK7gFO9ST8xLRtI9j1xxdo8+X7eA/9zKC8ARfVPFImdX9Eq+vA3Noy5py4/6pu+yf3Qc0PdMIje1V9JY8O1lbzk0vcGx+9VPerOWDia/QSkfp6/ROr62oWDHkFvxwJ27lJyPbQEcwHZeI+gp01O5o/rGhGWqmCl21+o3J7zmPeLGnOPW7lwc/flo+1cYYo32KoVQWuezzmGg5etUyruC2CZc/07TZPwiT4oASh6ivQgU9r353dO0p7hX6qhitWbHBe0OTZSMS/Zde/99LTb5Ac7Oz+n+qCi1y60VYgABXV8rZ8K0CfCzGty42pEWT4ePY+UDooNWkI4xa7w86FwAR1T6xGOhRhcGkZrpbIWj6hpysOt4oHXEJFUiEQtyXComYUi7+Kz3GPGyOa2Cp2Sq9j93JiI06+DsiMK8qFm0PyqchY1I6Pu30Xisdv9AsB/IhqsQEqjDvgdIHsP0c3PrqfNq+1ndoGrOY0zKVgybsX+KLiVVrozeOwbjyjA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(7416014)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(6133799003)(921020)(11063799006)(5023799004)(261102123227099003)(261026140227099003)(261028144727099003)(261026121527099003)(261022075727099003)(261022105027099003)(261021121427099003)(56012099006)(261021123027099003)(261009223027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bUNWOG9mTnpGNmlFbG5nSUFrcmQ4ZmFHTFZrUUZqalA4WmJpWS9aN05vZzlw?=
 =?utf-8?B?enF2ZkpXcnd3OVlyanV3a0MyZ3NGR251M3BFRTlMbk9iUXc3N1p5L1lJS1NW?=
 =?utf-8?B?MFBYVUlOZEo3SFJxb1Ryakx3amFRb3VNUUZIMU5TZjAxOFdvVURjNE5pTTVv?=
 =?utf-8?B?ZmFUYkJUbVlJT2RZTWk5WFU3MU1KZUpoSFVybjFXNmhGcitqZ2d4b2J0QWha?=
 =?utf-8?B?R2NNdC9SbTRiL0ZxMWwwTE1tU1FrYURyTm0yRFBERE1lRXRPdGkxdWhBNUtR?=
 =?utf-8?B?SGlXN2RmTHhVcW5jdThabi9od2dSZjB3WkNzNml6SFE3dFNPQ1h1MjFnWDNW?=
 =?utf-8?B?Y2pwSFZDcHRjc0l2SGJpdmFyYkh5NmQ5cmJPVDd3bkY3OXNlWVVQRXB2YlJv?=
 =?utf-8?B?OVNiZUhIdUhTTjJoT2d0Nk1rZ1pjK0pVa3d5b3F1NDgwbmljdXUxZEc1SE9J?=
 =?utf-8?B?NVNOWVR5QlFuaFZYaHEydldwOTRoRXhBNUV2dW9QeGhRMzhQdkpXNVhUalpH?=
 =?utf-8?B?ZGUxTjhLamljc0pGc2xjWjVnTGJhb09NZWhLcDhmZEZmMTRNU2JpVkd4a2U2?=
 =?utf-8?B?OFFuOFNUUHlpOUx5MjJlK3hDY0hJRnkwU3lKS1ErRHdKMXArRFh4dXpXME5B?=
 =?utf-8?B?VGMrcXFhdi9heVRjM3U4UVdvQWNsWSs3ZWx3dkJ6cjFUWE40WlFUL0krRDgz?=
 =?utf-8?B?UW01SllGQWltc3lQVU9OMXpNRnJKY0RrQzg5TUhhVitPb3ZvVTlrYWlydzBW?=
 =?utf-8?B?UUlxai9XSHBpZUF3Z1A0b3MzYTV2V2hENTFHU0lpcWpxbFF2QlVYWlVFZDRQ?=
 =?utf-8?B?OW9PM3RmKzY3Z1RKdnpvUzhwMDlEVlJEbXBKTG4zNEV2L1FXTEZCVXRWUzly?=
 =?utf-8?B?UE5oVzFweVlkcVFyMkFlbS9tNCtiaFVNcUZnb2NqeVZMSGtLZFhqQnlFYnBJ?=
 =?utf-8?B?U21URnRtUHA5QTl3WjQ3RDZ0SXhOSkJFaEhMNUNRS3BFeVVhdDBlVUp2dnRG?=
 =?utf-8?B?TFhlbTlYTGVtVDZkcUJqOHdHUUpOQWt3Uno4ZDdvMlJvTDV3akhlL3RjSm55?=
 =?utf-8?B?M1dSTVRqOVMrWVRibmF0NTM4NS9SaTFyMzZPN0pDZTUyYjVvNm9wcUk5NVl1?=
 =?utf-8?B?eTZRaVVCdno3TTBEckVpbzhWb0FLaWc0L21ieHlOMEc0K3lRMjF4YXpBanJU?=
 =?utf-8?B?RW13M1ZlN2RPU1NzNU8zdkg2Tkc3TkJRNk5HWXJENFMwVkUyWnN4UXZveEcw?=
 =?utf-8?B?NnEybzBnZW1wNThkbHhlTWVZYjZDdUk5UE9tTzJSN3RqS0V5bWhTMzBUZitl?=
 =?utf-8?B?cWhhclNoSk0wVFYxMkM1RjdFM3RjTFQvQnErMCtYbk15OTRmM3lHYXlxVVAr?=
 =?utf-8?B?eWp4MitEZjBMdlowaGJpTFEydzU1TE9ZUHRsVkxjaWZLUkt2Z0E0eGUvWE5H?=
 =?utf-8?B?TEpZVVovbndNQmdSYm9ZenhhWHhhRG9qT1JKSG9sUUh1Y3FXSStieVFVUHpl?=
 =?utf-8?B?dk9zR0JnS3lnOUQ5aVN4eXB1ZTdZaGNMRW9OZjFicVNhZFgxSGdKSE9yZnBq?=
 =?utf-8?B?a3p1OFFQV3FwTmZCb3UyYWhpR1pDUVM0d1cyM1N2MUgzRENDZlhXaTdvUng3?=
 =?utf-8?B?bjc5Z1UrNjFQTjZTRVplQnYrMnVxeGVEUzZlRXlGYW9sOStvU0EyMWNPNTg0?=
 =?utf-8?B?R2pWcHVGZjZFeXhLRHMwampmMU5KSFYrWkhhdFpyb1A5SjdlZ09KV1JxTDJY?=
 =?utf-8?B?NkFnY0ticnNTYnM1Rmh4NXgzUk9JaGEwdE9VaUxRQWhSKy9DZFVnY2lOSVpx?=
 =?utf-8?B?NkljV25TSlh1N3J5ZUQ3N0xRS1NLVlFtRGxybElGNVA3a0hFc1RoMUVTc05B?=
 =?utf-8?B?MkZPdStYckIrRFRxL0h6Z3cwU2g5T3B2UkhyRlRtNHA1cFJEcy9LSnE3S0U5?=
 =?utf-8?B?R29KOG9NbE4ySFY4QjlQL1lMVVdLMk1pZ2FmZ2JNTEhpeGNqdnE2SCtTNVhq?=
 =?utf-8?B?QWhnZkZoZlhmbGlwTVlYaDl4OFBKTCt3cWpWRkJ6SFFpOWthdjJub0RsSUZK?=
 =?utf-8?B?bEt3RmhrTFlmVzBYVytYaTFic2lZM1kyK2JmNHBuZnhNOEVET0tybVpzUWhK?=
 =?utf-8?B?L28rc1pZY3hBcUJYU2J1N0lmTXJPMVRWWnVzNUZRZVk1WFFUZm5kUkRDUGUx?=
 =?utf-8?B?VHlpWDVoMFdDdDhsYlhIZnlTRXQ3Wk5ROGlUY09sMFd5NGJVaWYyYWpFY3dF?=
 =?utf-8?B?WHhQdXJSdnhDRFY1cENCdlJTa09DRmFQNXBJOThnc1FOdE5ZOGVsT0R0czFZ?=
 =?utf-8?B?bktHYUl3bU1PNEw4WStOY2Y2OThhbHUydzNmc2s5Y2c5a3FsaTZwVGZOQzh6?=
 =?utf-8?Q?U7HNC80wlWOI/W1Ai+m1xWqSHi4rAqhajBOsF?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dca71f4-b494-44be-e77d-08df41894bf7
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 13:23:25.3780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4xDsrRZWTUc2EdQ8QyjH+SBxbbKPEs/zN+FHZzj65DYpYlBtErLPdpvvKuV2M7C0MWM5shPJEztblx4cVgp2RKmurqNn6k4xwjz1IOlUMg2cyB2TwWS/6jTC/TfXYydf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BR2PR04MB007356

From: Peng Fan <peng.fan@nxp.com>

With the per-domain CD table, every non-PASID sharer of a SID builds the
same normal-domain STE: same S1ContextPtr, S1DSS and S1CDMAX. Disable
PASID and ATS for shared SIDs as well, so the remaining STE fields are
common too, and let any sharer program the STE. This also handles the
case where one device's driver attaches before the stream owner's driver:
the first attach now installs a valid STE instead of leaving the boot or
firmware STE in place.

A per-device release must not abort a shared STE while other sharers
remain, otherwise it would break their ongoing DMA. Use a dedicated
release domain instead of inferring release from the STE contents:
group-wide BLOCKED attaches still program the abort STE, while the
release domain skips writes until the last master no longer shares the
SID.

Disable SVA, PASID, vSMMU nesting, ATS and IOPF/stall for shared-SID
masters since all of them require an unambiguous SID-to-device mapping.
Reject sharing at insert_master() time if either master wants stalling,
if the incoming master requires ATS, if the existing master has PASID,
ATS or vSMMU state enabled, or if a PCI and a non-PCI master would share
the SID. Other ATS-capable shared devices have their ATS capability
prepared, but ATS is not enabled while the SID is shared.

Resolve stall_enabled before insert_master(), and use master->stall_enabled
directly for CD.S, STE.S1STALLD and STE.S2S. A shared master can never
have stalling enabled.

Add arm_smmu_master_shares_sid() as an inline helper in arm-smmu-v3.h so
that arm-smmu-v3-sva.c and arm-smmu-v3-iommufd.c can use it without
repeating the list_empty() pattern.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c    |   7 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c    |   3 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c   |   5 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c        | 236 ++++++++++++++++-----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h        |   5 +
 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c     |   2 +-
 6 files changed, 200 insertions(+), 58 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index 853276dd5453..1fa512a655d2 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -168,6 +168,8 @@ static int arm_smmu_attach_dev_nested(struct iommu_domain *domain,
 
 	if (nested_domain->vsmmu->smmu != master->smmu)
 		return -EINVAL;
+	if (arm_smmu_master_shares_sid(master))
+		return -EOPNOTSUPP;
 	if (arm_smmu_ssids_in_use(&master->cd_table))
 		return -EBUSY;
 
@@ -310,7 +312,7 @@ static int arm_vsmmu_vdevice_init(struct iommufd_vdevice *vdev)
 	 * arm_vsmmu_vsid_to_sid() maps a vSID to master->streams[0] alone, so
 	 * more streams would leave the rest stale and none reads out of bounds.
 	 */
-	if (master->num_streams != 1)
+	if (master->num_streams != 1 || arm_smmu_master_shares_sid(master))
 		return -EOPNOTSUPP;
 	return 0;
 }
@@ -545,6 +547,9 @@ size_t arm_smmu_get_viommu_size(struct device *dev,
 	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
 	struct arm_smmu_device *smmu = master->smmu;
 
+	if (arm_smmu_master_shares_sid(master))
+		return 0;
+
 	if (!(smmu->features & ARM_SMMU_FEAT_NESTING))
 		return 0;
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index 7f89bb7a2e9c..f65c60652c0d 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -281,6 +281,9 @@ static int arm_smmu_sva_set_dev_pasid(struct iommu_domain *domain,
 	if (!(master->smmu->features & ARM_SMMU_FEAT_SVA))
 		return -EOPNOTSUPP;
 
+	if (arm_smmu_master_shares_sid(master))
+		return -EOPNOTSUPP;
+
 	/* Prevent arm_smmu_mm_release from being called while we are attaching */
 	if (!mmget_not_zero(domain->mm))
 		return -EINVAL;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
index 864d9f2350bc..a3fbcd88675a 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
@@ -215,6 +215,7 @@ static void arm_smmu_test_make_cdtable_ste(struct arm_smmu_ste *ste,
 		.stall_enabled = stall_enabled,
 	};
 
+	INIT_LIST_HEAD(&master.shared_masters_elm);
 	arm_smmu_make_cdtable_ste(ste, &master, &master.cd_table, ats_enabled,
 				  s1dss);
 	if (feat & ARM_SMMU_MASTER_TEST_NESTED) {
@@ -351,6 +352,7 @@ static void arm_smmu_test_make_s2_ste(struct arm_smmu_ste *ste,
 		.pgtbl_ops = &io_pgtable.ops,
 	};
 
+	INIT_LIST_HEAD(&master.shared_masters_elm);
 	io_pgtable.cfg.arm_lpae_s2_cfg.vttbr = 0xdaedbeefdeadbeefULL;
 	io_pgtable.cfg.arm_lpae_s2_cfg.vtcr.ps = 1;
 	io_pgtable.cfg.arm_lpae_s2_cfg.vtcr.tg = 2;
@@ -506,6 +508,7 @@ static void arm_smmu_test_make_s1_cd(struct arm_smmu_cd *cd, unsigned int asid)
 		},
 	};
 
+	INIT_LIST_HEAD(&master.shared_masters_elm);
 	io_pgtable.cfg.arm_lpae_s1_cfg.ttbr = 0xdaedbeefdeadbeefULL;
 	io_pgtable.cfg.arm_lpae_s1_cfg.tcr.ips = 1;
 	io_pgtable.cfg.arm_lpae_s1_cfg.tcr.tg = 2;
@@ -549,6 +552,7 @@ static void arm_smmu_test_make_sva_cd(struct arm_smmu_cd *cd, unsigned int asid)
 		.smmu = &smmu,
 	};
 
+	INIT_LIST_HEAD(&master.shared_masters_elm);
 	arm_smmu_make_sva_cd(cd, &master, &sva_mm, asid);
 }
 
@@ -559,6 +563,7 @@ static void arm_smmu_test_make_sva_release_cd(struct arm_smmu_cd *cd,
 		.smmu = &smmu,
 	};
 
+	INIT_LIST_HEAD(&master.shared_masters_elm);
 	arm_smmu_make_sva_cd(cd, &master, NULL, asid);
 }
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 20cbad032846..790a6e54c24a 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3209,28 +3209,18 @@ arm_smmu_get_step_for_sid(struct arm_smmu_device *smmu, u32 sid)
 	}
 }
 
-void arm_smmu_install_ste_for_dev(struct arm_smmu_master *master,
-				  const struct arm_smmu_ste *target)
+static void
+arm_smmu_install_ste_for_dev_flags(struct arm_smmu_master *master,
+				   const struct arm_smmu_ste *target,
+				   bool skip_shared)
 {
 	int i, j;
+	bool written = false;
 	struct arm_smmu_device *smmu = master->smmu;
-	u64 ste = le64_to_cpu(target->data[0]);
-
-	master->cd_table.in_ste =
-		FIELD_GET(STRTAB_STE_0_CFG, ste) ==
-			STRTAB_STE_0_CFG_S1_TRANS &&
-		(ste & STRTAB_STE_0_S1CTXPTR_MASK) ==
-			(master->cd_table.cdtab_dma &
-			 STRTAB_STE_0_S1CTXPTR_MASK);
-	master->ste_ats_enabled =
-		FIELD_GET(STRTAB_STE_1_EATS,
-			  le64_to_cpu(target->data[1])) ==
-		STRTAB_STE_1_EATS_TRANS;
 
 	for (i = 0; i < master->num_streams; ++i) {
 		u32 sid = master->streams[i]->id;
-		struct arm_smmu_ste *step =
-			arm_smmu_get_step_for_sid(smmu, sid);
+		struct arm_smmu_ste *step;
 
 		/* Bridged PCI devices may end up with duplicated IDs */
 		for (j = 0; j < i; j++)
@@ -3239,11 +3229,43 @@ void arm_smmu_install_ste_for_dev(struct arm_smmu_master *master,
 		if (j < i)
 			continue;
 
+		/*
+		 * A shared STE represents the group's domain, not a single
+		 * master. The release domain is attached to one device at a
+		 * time while the other sharers must keep translating; leave
+		 * the STE untouched until the last master is released.
+		 */
+		if (skip_shared && arm_smmu_master_shares_sid(master))
+			continue;
+
+		step = arm_smmu_get_step_for_sid(smmu, sid);
 		arm_smmu_write_ste(master, sid, step, target);
+		written = true;
+	}
+
+	if (written) {
+		u64 ste = le64_to_cpu(target->data[0]);
+
+		master->cd_table.in_ste =
+			FIELD_GET(STRTAB_STE_0_CFG, ste) ==
+				STRTAB_STE_0_CFG_S1_TRANS &&
+			(ste & STRTAB_STE_0_S1CTXPTR_MASK) ==
+				(master->cd_table.cdtab_dma &
+				 STRTAB_STE_0_S1CTXPTR_MASK);
+		master->ste_ats_enabled =
+			FIELD_GET(STRTAB_STE_1_EATS,
+				  le64_to_cpu(target->data[1])) ==
+			STRTAB_STE_1_EATS_TRANS;
 	}
 }
 
-static bool arm_smmu_ats_supported(struct arm_smmu_master *master)
+void arm_smmu_install_ste_for_dev(struct arm_smmu_master *master,
+				  const struct arm_smmu_ste *target)
+{
+	arm_smmu_install_ste_for_dev_flags(master, target, false);
+}
+
+static bool arm_smmu_ats_capable(struct arm_smmu_master *master)
 {
 	struct device *dev = master->dev;
 	struct arm_smmu_device *smmu = master->smmu;
@@ -3258,6 +3280,18 @@ static bool arm_smmu_ats_supported(struct arm_smmu_master *master)
 	return dev_is_pci(dev) && pci_ats_supported(to_pci_dev(dev));
 }
 
+static bool arm_smmu_ats_supported(struct arm_smmu_master *master)
+{
+	return !arm_smmu_master_shares_sid(master) &&
+	       arm_smmu_ats_capable(master);
+}
+
+static bool arm_smmu_master_pasid_enabled(struct arm_smmu_master *master)
+{
+	return dev_is_pci(master->dev) &&
+	       to_pci_dev(master->dev)->pasid_enabled;
+}
+
 static void arm_smmu_enable_ats(struct arm_smmu_master *master)
 {
 	size_t stu;
@@ -3386,8 +3420,7 @@ static int arm_smmu_enable_iopf(struct arm_smmu_master *master,
 	if (!master->stall_enabled)
 		return 0;
 
-	/* We're not keeping track of SIDs in fault events */
-	if (master->num_streams != 1)
+	if (master->num_streams != 1 || arm_smmu_master_shares_sid(master))
 		return -EOPNOTSUPP;
 
 	if (master->iopf_refcount) {
@@ -3994,6 +4027,9 @@ static int arm_smmu_s1_set_dev_pasid(struct iommu_domain *domain,
 	if (smmu_domain->stage != ARM_SMMU_DOMAIN_S1)
 		return -EINVAL;
 
+	if (arm_smmu_master_shares_sid(master))
+		return -EOPNOTSUPP;
+
 	/*
 	 * We can read cd.asid outside the lock because arm_smmu_set_pasid()
 	 * will fix it
@@ -4192,11 +4228,11 @@ static int arm_smmu_blocking_set_dev_pasid(struct iommu_domain *new_domain,
 	return ret;
 }
 
-static void arm_smmu_attach_dev_ste(struct iommu_domain *domain,
-				    struct iommu_domain *old_domain,
-				    struct device *dev,
-				    struct arm_smmu_ste *ste,
-				    unsigned int s1dss)
+static int arm_smmu_attach_dev_ste(struct iommu_domain *domain,
+				   struct iommu_domain *old_domain,
+				   struct device *dev,
+				   struct arm_smmu_ste *ste,
+				   unsigned int s1dss, bool release)
 {
 	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
 	struct arm_smmu_attach_state state = {
@@ -4206,6 +4242,7 @@ static void arm_smmu_attach_dev_ste(struct iommu_domain *domain,
 	};
 	bool ats_always_on = master->ats_always_on &&
 			     s1dss != STRTAB_STE_1_S1DSS_TERMINATE;
+	int ret;
 
 	/*
 	 * Do not allow any ASID to be changed while are working on the STE,
@@ -4226,13 +4263,17 @@ static void arm_smmu_attach_dev_ste(struct iommu_domain *domain,
 		 * and allows for ATS on the RID to work.
 		 */
 		state.cd_needs_ats = true;
-		arm_smmu_attach_prepare(&state, domain);
+		ret = arm_smmu_attach_prepare(&state, domain);
+		if (ret)
+			goto out_unlock;
 		arm_smmu_make_cdtable_ste(ste, master, &master->cd_table,
 					  state.ats_enabled, s1dss);
 	} else {
-		arm_smmu_attach_prepare(&state, domain);
+		ret = arm_smmu_attach_prepare(&state, domain);
+		if (ret)
+			goto out_unlock;
 	}
-	arm_smmu_install_ste_for_dev(master, ste);
+	arm_smmu_install_ste_for_dev_flags(master, ste, release);
 	arm_smmu_attach_commit(&state);
 	mutex_unlock(&arm_smmu_asid_lock);
 	arm_smmu_attach_release(&state);
@@ -4243,6 +4284,11 @@ static void arm_smmu_attach_dev_ste(struct iommu_domain *domain,
 	 * descriptor from arm_smmu_share_asid().
 	 */
 	arm_smmu_clear_cd(master, IOMMU_NO_PASID);
+	return 0;
+
+out_unlock:
+	mutex_unlock(&arm_smmu_asid_lock);
+	return ret;
 }
 
 static int arm_smmu_attach_dev_identity(struct iommu_domain *domain,
@@ -4254,9 +4300,8 @@ static int arm_smmu_attach_dev_identity(struct iommu_domain *domain,
 
 	arm_smmu_master_clear_vmaster(master);
 	arm_smmu_make_bypass_ste(master->smmu, &ste);
-	arm_smmu_attach_dev_ste(domain, old_domain, dev, &ste,
-				STRTAB_STE_1_S1DSS_BYPASS);
-	return 0;
+	return arm_smmu_attach_dev_ste(domain, old_domain, dev, &ste,
+				       STRTAB_STE_1_S1DSS_BYPASS, false);
 }
 
 static const struct iommu_domain_ops arm_smmu_identity_ops = {
@@ -4277,9 +4322,8 @@ static int arm_smmu_attach_dev_blocked(struct iommu_domain *domain,
 
 	arm_smmu_master_clear_vmaster(master);
 	arm_smmu_make_abort_ste(&ste);
-	arm_smmu_attach_dev_ste(domain, old_domain, dev, &ste,
-				STRTAB_STE_1_S1DSS_TERMINATE);
-	return 0;
+	return arm_smmu_attach_dev_ste(domain, old_domain, dev, &ste,
+				       STRTAB_STE_1_S1DSS_TERMINATE, false);
 }
 
 static const struct iommu_domain_ops arm_smmu_blocked_ops = {
@@ -4292,6 +4336,37 @@ static struct iommu_domain arm_smmu_blocked_domain = {
 	.ops = &arm_smmu_blocked_ops,
 };
 
+static int arm_smmu_attach_dev_release(struct iommu_domain *domain,
+				       struct device *dev,
+				       struct iommu_domain *old_domain)
+{
+	struct arm_smmu_ste ste;
+	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
+	bool require_direct = dev->iommu && dev->iommu->require_direct;
+	unsigned int s1dss;
+
+	arm_smmu_master_clear_vmaster(master);
+	if (require_direct) {
+		arm_smmu_make_bypass_ste(master->smmu, &ste);
+		s1dss = STRTAB_STE_1_S1DSS_BYPASS;
+	} else {
+		arm_smmu_make_abort_ste(&ste);
+		s1dss = STRTAB_STE_1_S1DSS_TERMINATE;
+	}
+
+	return arm_smmu_attach_dev_ste(domain, old_domain, dev, &ste, s1dss,
+				       true);
+}
+
+static const struct iommu_domain_ops arm_smmu_release_ops = {
+	.attach_dev = arm_smmu_attach_dev_release,
+};
+
+static struct iommu_domain arm_smmu_release_domain = {
+	.type = IOMMU_DOMAIN_BLOCKED,
+	.ops = &arm_smmu_release_ops,
+};
+
 static struct iommu_domain *
 arm_smmu_domain_alloc_paging_flags(struct device *dev, u32 flags,
 				   const struct iommu_user_data *user_data)
@@ -4537,9 +4612,40 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 				break;
 			}
 
-			if (stream->master->stall_enabled) {
+			if (dev_is_pci(master->dev) !=
+			    dev_is_pci(stream->master->dev)) {
+				dev_warn(master->dev,
+					 "Shared StreamID 0x%x across PCI and non-PCI masters unsupported\n",
+					 sid);
+				ret = -ENODEV;
+				break;
+			}
+
+			if (dev_is_pci(master->dev) &&
+			    pci_ats_required(to_pci_dev(master->dev))) {
+				dev_warn(master->dev,
+					 "Shared StreamID 0x%x rejected: incoming master requires ATS\n",
+					 sid);
+				ret = -EBUSY;
+				break;
+			}
+
+			if (stream->master->stall_enabled ||
+			    master->stall_enabled) {
+				dev_warn(master->dev,
+					 "Shared StreamID 0x%x rejected: stall enabled\n",
+					 sid);
+				ret = -EBUSY;
+				break;
+			}
+
+			if (stream->master->ats_always_on ||
+			    stream->master->ats_enabled ||
+			    arm_smmu_master_pasid_enabled(stream->master) ||
+			    arm_smmu_ssids_in_use(&stream->master->cd_table) ||
+			    stream->master->vmaster) {
 				dev_warn(master->dev,
-					 "Shared StreamID 0x%x rejected: existing master has stall enabled\n",
+					 "Shared StreamID 0x%x rejected: existing master has PASID/ATS/vSMMU enabled\n",
 					 sid);
 				ret = -EBUSY;
 				break;
@@ -4612,7 +4718,7 @@ static int arm_smmu_master_prepare_ats(struct arm_smmu_master *master)
 		return 0;
 	pdev = to_pci_dev(master->dev);
 
-	if (!arm_smmu_ats_supported(master)) {
+	if (!arm_smmu_ats_capable(master)) {
 		if (pci_ats_required(pdev)) {
 			dev_err_once(master->dev, "SMMU doesn't support ATS\n");
 			return -EOPNOTSUPP;
@@ -4624,6 +4730,9 @@ static int arm_smmu_master_prepare_ats(struct arm_smmu_master *master)
 	if (ret || !pci_ats_required(pdev))
 		return ret;
 
+	if (arm_smmu_master_shares_sid(master))
+		return -EOPNOTSUPP;
+
 	/*
 	 * S1DSS is required for ATS to be always on for identity domain cases.
 	 * However, the S1DSS field is ignored if !IDR0_S1P or !IDR1_SSIDSIZE.
@@ -4661,32 +4770,47 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 	master->smmu = smmu;
 	dev_iommu_priv_set(dev, master);
 
-	ret = arm_smmu_insert_master(smmu, master);
-	if (ret)
-		goto err_free_master;
-
-	device_property_read_u32(dev, "pasid-num-bits", &master->ssid_bits);
-	master->ssid_bits = min(smmu->ssid_bits, master->ssid_bits);
-
 	/*
-	 * Note that PASID must be enabled before, and disabled after ATS:
-	 * PCI Express Base 4.0r1.0 - 10.5.1.3 ATS Control Register
-	 *
-	 *   Behavior is undefined if this bit is Set and the value of the PASID
-	 *   Enable, Execute Requested Enable, or Privileged Mode Requested bits
-	 *   are changed.
+	 * Resolve the stall policy before inserting the master. StreamID
+	 * sharing is rejected when either device wants stalling, and the
+	 * insert path needs to know the incoming master's policy.
 	 */
-	arm_smmu_enable_pasid(master);
-
-	if (!(smmu->features & ARM_SMMU_FEAT_2_LVL_CDTAB))
-		master->ssid_bits = min_t(u8, master->ssid_bits,
-					  CTXDESC_LINEAR_CDMAX);
-
 	if ((smmu->features & ARM_SMMU_FEAT_STALLS &&
 	     device_property_read_bool(dev, "dma-can-stall")) ||
 	    smmu->features & ARM_SMMU_FEAT_STALL_FORCE)
 		master->stall_enabled = true;
 
+	ret = arm_smmu_insert_master(smmu, master);
+	if (ret)
+		goto err_free_master;
+
+	if (arm_smmu_master_shares_sid(master)) {
+		/*
+		 * A shared StreamID cannot use PASID because all sharers must
+		 * point at the same, domain-owned CD table.
+		 */
+		master->ssid_bits = 0;
+	} else {
+		device_property_read_u32(dev, "pasid-num-bits",
+					 &master->ssid_bits);
+		master->ssid_bits = min(smmu->ssid_bits, master->ssid_bits);
+
+		/*
+		 * Note that PASID must be enabled before, and disabled after
+		 * ATS:
+		 * PCI Express Base 4.0r1.0 - 10.5.1.3 ATS Control Register
+		 *
+		 *   Behavior is undefined if this bit is Set and the value of
+		 *   the PASID Enable, Execute Requested Enable, or Privileged
+		 *   Mode Requested bits are changed.
+		 */
+		arm_smmu_enable_pasid(master);
+
+		if (!(smmu->features & ARM_SMMU_FEAT_2_LVL_CDTAB))
+			master->ssid_bits = min_t(u8, master->ssid_bits,
+						  CTXDESC_LINEAR_CDMAX);
+	}
+
 	ret = arm_smmu_master_prepare_ats(master);
 	if (ret)
 		goto err_disable_pasid;
@@ -4811,7 +4935,7 @@ static int arm_smmu_def_domain_type(struct device *dev)
 static const struct iommu_ops arm_smmu_ops = {
 	.identity_domain	= &arm_smmu_identity_domain,
 	.blocked_domain		= &arm_smmu_blocked_domain,
-	.release_domain		= &arm_smmu_blocked_domain,
+	.release_domain		= &arm_smmu_release_domain,
 	.capable		= arm_smmu_capable,
 	.hw_info		= arm_smmu_hw_info,
 	.domain_alloc_sva       = arm_smmu_sva_domain_alloc,
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 444b88cc67c5..cd659590dfe5 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -1242,6 +1242,11 @@ int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
 int arm_smmu_cmdq_init(struct arm_smmu_device *smmu,
 		       struct arm_smmu_cmdq *cmdq);
 
+static inline bool arm_smmu_master_shares_sid(struct arm_smmu_master *master)
+{
+	return !list_empty(&master->shared_masters_elm);
+}
+
 static inline bool arm_smmu_master_canwbs(struct arm_smmu_master *master)
 {
 	return dev_iommu_fwspec_get(master->dev)->flags &
diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
index 8166cece943c..ffb0ac93a4f4 100644
--- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
+++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
@@ -1264,7 +1264,7 @@ static int tegra241_vintf_init_vsid(struct iommufd_vdevice *vdev)
 	if (virt_sid > FIELD_MAX(VINTF_SID_MATCH_VIRT_SID))
 		return -EINVAL;
 
-	if (master->num_streams != 1)
+	if (master->num_streams != 1 || arm_smmu_master_shares_sid(master))
 		return -EOPNOTSUPP;
 
 	/* Find an empty pair of SID_REPLACE and SID_MATCH */

-- 
2.34.1

