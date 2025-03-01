Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11021080.outbound.protection.outlook.com [40.93.194.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C441BC3F
	for <iommu@lists.linux.dev>; Sat,  1 Mar 2025 01:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740792753; cv=fail; b=ZlocSsWUjO8ZDzfxdUkTFvUmF4AwS5XGyOKvwUewpOdbDXFlj9puGjc4AI7Gl8esME1zFxgispmB26GCchhkmcva5+5iwueAsvQp046qssYQap2Bl5oNOWDFsc8+4g6ZRlP11p9GtpCFbxrXI+AXB6t7WS+QeaYA1Ekp5bJRpuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740792753; c=relaxed/simple;
	bh=19OiGQ9TEji7Xpwe3rtl01T+EYoNOUCVcG5v8JM7HDY=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NveKOpMyQWQ+V7GNAiTvYnDGKrg7yMggZrieG/ysZonHUpnCgpnfkBJOxs9e+LYw+X/8Q51yXN44cdHuZTNWKX8Zt9FANPwwyZNmMuylBPvC5HXXXQ3fwZt07cn388PWvDBUJMj0gyZJBujeCHqiycyal6vqh6TRB3cgsMSZ4gE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=iC48kcfY; arc=fail smtp.client-ip=40.93.194.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="iC48kcfY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jd/Ng3v92cgNNDboUzOx3CmePmuwq/o2yLQVdd/8xV4haut2ciWoYxWAk8G9jbLFQ+oYJpcIs2HsTtY53nsRlD692W8Ur8brPgVwgoHf8guTfIKItSYWnmL4DjlI+lkS3X/S3DeFOtJ/BoIieSbxIpAgElQd48EZkEa1a6P6Igcz5GfJy/+jvt6umDxgC/Cu82RFhYY7xatqz7ONx9pM9NHqyfacmrWoevoVHP5S9C139dICC6gHReu/wVxcVZCCQ74TQZ1WeVXqZ55uJ1rxuTJeJTi+WjHWi9ac0DPPfcK5KKr8yUbt+fmCcTITPLtCmYWzwzEXRDdJnaDZW7xzkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vr8BGAA1SmElHP64Wwf209LjnswTDZgJbDsdEJPgH30=;
 b=CMq2MkwHe0IZwtAC8yt+WgzfPgq8kzfffxX7ivDaOkK+zBOM7JwfYn20iVRWgRB3ikFImsxmYmLIYq/xSBFbkw66t7ftsRfvbDVsvziAlm1m8Aji/75sQh5odCE5TqX3oYObRwZNMWte3lMfgOzVufc0mFzGj5qyxoJZJWxO58LImeX7VNoCeTd9H4vqSUWWcmIDrNAwcFEKYraOZ4IQw9lqg2j1DaQdCvqB3q4D0bgyNnJ05n2kYVoBUDfMGNzr7w2WZh1MStirOrv+vSzyNQKSPtTZ+KVyMFLRoB0RKR8Mq6ccMSMQoIuJf/cupYfV4EQ7sWNwSGxRwdNZvpciMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vr8BGAA1SmElHP64Wwf209LjnswTDZgJbDsdEJPgH30=;
 b=iC48kcfYV3harK9e+Xrx1px1Wn9m7dLFqmfJkNcIzuFgcGxefwKkZ6RA3sqY6Ufx46VNrNdPXiV4YFZJeEpnDSPGQY+d9n9dIfXswUxPmZhrGRv6+WmjQcQFZG9JotX80NcQRA+GObNFubB7GZaPGpfQpiucc/koLz1Jq1VTNyE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 BY3PR01MB6625.prod.exchangelabs.com (2603:10b6:a03:36c::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.25; Sat, 1 Mar 2025 01:32:27 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%2]) with mapi id 15.20.8489.021; Sat, 1 Mar 2025
 01:32:26 +0000
Message-ID: <b46dc626-edc9-4d20-99d2-6cd08a01346c@os.amperecomputing.com>
Date: Fri, 28 Feb 2025 17:32:21 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] iommu/arm: Add BBM Level 2 smmu feature
To: =?UTF-8?Q?Miko=C5=82aj_Lenczewski?= <miko.lenczewski@arm.com>,
 ryan.roberts@arm.com, suzuki.poulose@arm.com, catalin.marinas@arm.com,
 will@kernel.org, joro@8bytes.org, jean-philippe@linaro.org,
 mark.rutland@arm.com, joey.gouly@arm.com, oliver.upton@linux.dev,
 james.morse@arm.com, broonie@kernel.org, maz@kernel.org, david@redhat.com,
 akpm@linux-foundation.org, jgg@ziepe.ca, nicolinc@nvidia.com,
 mshavit@google.com, jsnitsel@redhat.com, smostafa@google.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev
References: <20250228182403.6269-2-miko.lenczewski@arm.com>
 <20250228182403.6269-6-miko.lenczewski@arm.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <20250228182403.6269-6-miko.lenczewski@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0158.namprd05.prod.outlook.com
 (2603:10b6:a03:339::13) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|BY3PR01MB6625:EE_
X-MS-Office365-Filtering-Correlation-Id: f3f8d753-212d-4094-53f1-08dd5860ec43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?djJVejdKSU1zWTNTVFRkK2R1SkF0Si9KcHNIcHdOMWxOTTBvQks4Y2FNZFpP?=
 =?utf-8?B?L1JSTjFFUXFTQnpyRGpvdmduNUJTVVA0clhUN3ExbnYreGlxdmZ6OXNLL01q?=
 =?utf-8?B?amgwU0V0YTFScHUwSWtSQ0VaMVlKWFJHVzNwZTZtdEtIbDI4MHpaVC8rcUV4?=
 =?utf-8?B?T04rMjA4RmZNbEVBR2pla1ZPNTVYTHRhM2FrQ0JsckdON3RTZTg3M1NMOG1n?=
 =?utf-8?B?RjdIVWRlc0hiQnpla3FTSnl5OHlhUGJSemJXVGttd2pHRHdXekJ5M2ZHVWpJ?=
 =?utf-8?B?a1AvcnFlS2dsRjMzMXhhdThzbUl3UEZDeHVmVmlhNjVRL0E3ekc1c2Iyd2Zp?=
 =?utf-8?B?WGJBLzlkczdzZ1ZiWkpTVk5rQkFWa09RRFFacVl0Q0RLL28wNzZVMThIVE5r?=
 =?utf-8?B?WDhXOWxaVGh3QTdDNnQwR1J6N3NhVjlKckZFUkltQ1FPbVM1dnRyTXRKQWJF?=
 =?utf-8?B?RWJVNjc2RUNzb1IyMExGdTlwc1cvMCtPQjZ1eXRqVlBFN0gzTm9Gd1pGa0Vx?=
 =?utf-8?B?Z0VsUUFobXJzL1JpVzc3ZFVXdm85eklSRDhIam1WLzJ6aWxOZzQ5TXIwT2Vw?=
 =?utf-8?B?d2hRcTVjVU5jcUNVOWZoUmRoa0Z3TFc1enhWY3Q2SnJHSTlvSXV3MGlYdGs3?=
 =?utf-8?B?RHRySmZkbnVSN0d1aUMwOTFtWEtFQ253T20wTlJXU3lRcnVLai85UUV3c2tk?=
 =?utf-8?B?MVdQL29NWHVhNnBsUzlXSnVpNVN6SU1jNFg2eGRLd1ZWTzJFbzBkekFoWGw3?=
 =?utf-8?B?dlVheFFwdm04SmcvNzdWaVh6cmcwZWJaSlpwYTVqNVlXbDUvTEpYZXRPQWZQ?=
 =?utf-8?B?dWxpdE02MU9YZ3ZRTGl6MGc0b092Y1RndFBTNHp5a3hiOGxXNGdsSzlwNWNE?=
 =?utf-8?B?V2ZTbDBtZGNuQnpNR2d2cklXak1SNlE5S05nYTdVL3dQZ1UycDIyL1B6RDdX?=
 =?utf-8?B?TXRObEVoeVFyMklXNUJScmFTN0t1SUU4OFBFRmY4ZDBSaUFlYWhCd09NblU1?=
 =?utf-8?B?MmlWWk1IdmRkZDB4UlV4M2ZwdDNPU1JGTXp6UWx2cXpPbFBqeVhpM1R3TmlC?=
 =?utf-8?B?TjlzKy82aWx0T0RvMGd3YVhyS0FjMVg2SlVHT3owMnY5bVNZVXd1MHNaZldi?=
 =?utf-8?B?S3pKL1FjRHpsaC95YUluM0pWN0c5UDRmWnhKdjQ2RDQ3NTRNS2FETHhKcER4?=
 =?utf-8?B?eDhwdzdiNWwrQzl2T2JUZXltU0RLQlQxVDI3U0drWS9LWUkrLzRGZ0dLZHk3?=
 =?utf-8?B?NkRoZWpJUnUycnNGRWhTamxVU053My95WHdtZkh0TzdWRkh5dHM3Wml1SUpk?=
 =?utf-8?B?Q0h1OFhUR2RjbEw0UzMrRGJpRUQ5R2xZaEVRV3hJd01ZSkhQRUFBZFQxVnVz?=
 =?utf-8?B?YmNXWDdKR1pKV1VicHdlUkZ4UEpybU1LTmxkd0JGQ3dqZlh1Q3pBSnlrMjF3?=
 =?utf-8?B?d1p0UWtDT0ZJbFB5RHNJc1hadnlEQU1vVXErSDJkMmFKcURRVVpXQkwyZlA5?=
 =?utf-8?B?WXlEaVdtS0htd0FXZnl0N2dtRFppMVg3clpMOGtYbjVZN2VuU0hPMElibnNm?=
 =?utf-8?B?VzZFdmppeTlua2t0bGxIeHJ5T2M2UHFvbE1LdjZlTEZja1I1clpsamE4bEIz?=
 =?utf-8?B?N3FGM3o4NjBZQnhsRkZGL2lVeDRmTWVsSzNMbzlGUjduK3BWWjEzdjh3S0d0?=
 =?utf-8?B?TzZUR1l0MXh5ZUVyZFU4WTJzUTd6WlZVSXc2Q1k3NUhJbFJDWWpZQytWN0F6?=
 =?utf-8?B?TlQ2THA0bXg0alBZZE9MK3haTkxPQ0d3ZjdydWtZaXVIcHlKUmxzVHRDelpQ?=
 =?utf-8?B?Z1FSWUcwK0MvODZobmkwc3FmbjRwN3oxa0k0S3F6ZXFVSUpIWHgvT3kwT2VW?=
 =?utf-8?B?Vm93QWk0WjlYa2hjenJLVFRLYVpNTEpaYnpUUzNiaUFPeURBQldZMll2dS9K?=
 =?utf-8?Q?rC4RZMplUMI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Sk9CL3ZDT29yczBpNDVWNEQ2RFFRRHA3aE9DOWRFUjFrN3lxblF3aWFMWndx?=
 =?utf-8?B?ZTFaY0QvaFkzSmMvOHpCaEUwNlRKN3dDc1NFY0FjK1JZLy9ZWlJJUUd5bnFN?=
 =?utf-8?B?T3lqQmhGVEMzY1JCdDloTlQvd3FvK1ZZN1BWWHpEQ20veVJFMjdlZ3dwcTU2?=
 =?utf-8?B?SlBmZHpsZFhuSEZGVjBoa1YvU1lMcGkxa0FLVWIxWXUzNzBNbktKWjFxV0dE?=
 =?utf-8?B?QTBYZnFZUXlBVldsTGRScUJNUU02OWFaQlpEeVZaOTJyTC95WFlIRzV3T05V?=
 =?utf-8?B?Q1orS2JKOFNxSjJqenZDeGNqWWs2eDVNVDBsWFl0NkxkM3hsVWx4SnA5RGNV?=
 =?utf-8?B?R1IyT05uaURtL00wajZZUHc0QlBQVk1jWVZ4TGx1cWxaWUNJc010Z2xBL21w?=
 =?utf-8?B?R0lZU1hxNDZiTHRFMHhRRFgrOFNWTU5rSVZ2NFZoSXVtbWg4UWdVNHJxS1BN?=
 =?utf-8?B?dGtDY0UydmhGN01pMFlZWnBONlh3UnNoYTg4VkJzdGh4RmdJVlFGbWtpK08x?=
 =?utf-8?B?ejM0cnhWR0xMdUdpek1oNndQYkhyUzIzYStMQzBsbWRrdkpyYWZnNGJKNmJM?=
 =?utf-8?B?ei9UMGpiWTJsaEVGOEYwMmx5bllhaXlDVVBiS3YzNUw4TUhqNzFlT1lUNzEr?=
 =?utf-8?B?VjVZcXZwSjlmb0lpMnFjSWNLbEN2UWVFOVlvcndxM29QQWxsbWc5Zk5ST3Jn?=
 =?utf-8?B?N1NpNUdGa1ZHNEZPdFRuWTFXZ2JwSjlBaDRNL1pwWTR2eG1zcWFzRFVoc21s?=
 =?utf-8?B?cjJoMmo2RWJ4bFNYdGloK0htQllEZzhURDYxS2hxTWpRUUtVWnNzN3l4emtC?=
 =?utf-8?B?bHlVMHJuL2hCa1NZT3JaZk9McXQrYmZSSmJYdDNUREc3emNVWTdrbUdjdHl3?=
 =?utf-8?B?ZmVKbW51Q2VpbjNSclhiWmhlSTI4WHFreEVnOVJWMTNYYzl1bkxTQzFQQ1I2?=
 =?utf-8?B?WllhbEEyRUFWYXhES1ZuZHIrRXlxa3FYWVo1YVRwc0NadWdzOFd1WmpjNmJw?=
 =?utf-8?B?UFhUcnFSaEdJdW1JTjBsOUlLd2krS1MwUEZneDVNeTdOa3dFODBQOVptUmZS?=
 =?utf-8?B?cDAraU1xSkpranNlOVpydGxBVEVLYWRFUmxxTk53Z2daSjA2NTFRZEpnakxq?=
 =?utf-8?B?ZWQvME1LRVVHNkErbE5MbWJpWm1ySVNJZ3pnMldrdWUwSmlHS0ZYc3p6V3du?=
 =?utf-8?B?ZUNmb1ZBZjJsMXVFU09vbW52U3VaanFpZ25Gd0ZZZmVycTNEU0Iwa2FSeWM4?=
 =?utf-8?B?dXZZRnV5Rk1Qdmh4QVJlWDNtNFZ3UEhEZUhSbExOTEtGbmtwRTA4VnFOWmoz?=
 =?utf-8?B?bWdhNnNhRjNaVnpkQzVsdWh1S1pUaGFoQ3NTN2FsczZ0ZzFYcnVxd1JleGZY?=
 =?utf-8?B?NWdCdDUwOEdTY2ozZDJ0WHZrcWVxVHdqdms4R0pySGRXb2Z0TWpJYkVpTkdR?=
 =?utf-8?B?Z1lPVTRNYVBTQnpidlJYVTBja0JGK0RLeTE2TXk1Y3RTajNaajQrUVphRkVE?=
 =?utf-8?B?b0ZEdTUvK3duQTJERHZ3aEJVakY4aUZOUGRhazNyVU1hMWlrcXFhN0pEZUFl?=
 =?utf-8?B?NWIwZzlWMmNVUEJQY2lMTDYrRTFIa0Y4TFljdUZ6TDdXcS8zc2JYblI3cUlO?=
 =?utf-8?B?NkJzeE1Fd24yRVowMDBrS1Jub1l5VThLZkJHVlJaZUxDb21TSHB6a2JuRjMv?=
 =?utf-8?B?TTA1ZXlLK25KQUljTzk5R2wwalBJZ1dRbUcxZDNQbnR1aUhmN0ZxZGFxd2Rk?=
 =?utf-8?B?WjFlNW45cmdJYnErUVhxY0ZSeW9jeDI4cHppT1lCUEFwajRyU3dWNFNtVVFW?=
 =?utf-8?B?bjRtVk9Xamh5RDZJd2ZFL3FvZWtDd29Wbno3Z1hMa3FYQUdHOUFXRnB3djlC?=
 =?utf-8?B?ZDVnWkMyUUxBR2JaMlRmeXpkcEtNQ21OaW5lTHpZNkd2U2wxNGc2cFdQOUw2?=
 =?utf-8?B?NXR3Y0FLMi9CMEVLNUtTMDM2Szh5MmQraGNOaHVNdzNvclZZUURBY2NrOEFH?=
 =?utf-8?B?V2I0SnBMQXAwa25BSnVSS2RGZFkrNnlPenc1c2dQOUpmamdrZU5DYzBxM05X?=
 =?utf-8?B?d2Y1WVNwVlZ5ZmVYKzR0MWo2dVJ3dFZCazA5RnJ0VkpBalR4WTViUkF1ekJC?=
 =?utf-8?B?ZjlOYkp6T2FYZ3hsZEYwRjhUR3Q4NmRpbStkeUVaVWtmZTJxR2UxUldpMnZa?=
 =?utf-8?Q?scs0IGIujF90Far45/FL4YU=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3f8d753-212d-4094-53f1-08dd5860ec43
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2025 01:32:26.2129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jkSVHomtxr6TMzG+l43AHQGOKrmpJKcDm49wOXk0uAF7gzTTTvVpyQ59F29/cIwI2ZPN8EyyBgSKEGkpgrf7nU7kxBLQH/ZNf2NNWpKiQsc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR01MB6625




On 2/28/25 10:24 AM, Mikołaj Lenczewski wrote:
> For supporting BBM Level 2 for userspace mappings, we want to ensure
> that the smmu also supports its own version of BBM Level 2. Luckily, the
> smmu spec (IHI 0070G 3.21.1.3) is stricter than the aarch64 spec (DDI
> 0487K.a D8.16.2), so already guarantees that no aborts are raised when
> BBM level 2 is claimed.
>
> Add the feature and testing for it under arm_smmu_sva_supported().
>
> Signed-off-by: Mikołaj Lenczewski <miko.lenczewski@arm.com>
> ---
>   arch/arm64/kernel/cpufeature.c                  | 7 +++----
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 3 +++
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c     | 3 +++
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h     | 4 ++++
>   4 files changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 63f6d356dc77..1022c63f81b2 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -2223,8 +2223,6 @@ static bool has_bbml2_noabort(const struct arm64_cpu_capabilities *caps, int sco
>   			if (!cpu_has_bbml2_noabort(__cpu_read_midr(cpu)))
>   				return false;
>   		}
> -
> -		return true;
>   	} else if (scope & SCOPE_LOCAL_CPU) {
>   		/* We are a hot-plugged CPU, so only need to check our MIDR.
>   		 * If we have the correct MIDR, but the kernel booted on an
> @@ -2232,10 +2230,11 @@ static bool has_bbml2_noabort(const struct arm64_cpu_capabilities *caps, int sco
>   		 * we have an incorrect MIDR, but the kernel booted on a
>   		 * sufficient CPU, we will not bring up this CPU.
>   		 */
> -		return cpu_has_bbml2_noabort(read_cpuid_id());
> +		if (!cpu_has_bbml2_noabort(read_cpuid_id()))
> +			return false;
>   	}
>   
> -	return false;
> +	return has_cpuid_feature(caps, scope);

Do we really need this? IIRC, it means the MIDR has to be in the allow 
list *AND* MMFR2 register has to be set too. AmpereOne doesn't have 
MMFR2 register set.

Thanks,
Yang

>   }
>   
>   #ifdef CONFIG_ARM64_PAN
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> index 9ba596430e7c..6ba182572788 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> @@ -222,6 +222,9 @@ bool arm_smmu_sva_supported(struct arm_smmu_device *smmu)
>   		feat_mask |= ARM_SMMU_FEAT_VAX;
>   	}
>   
> +	if (system_supports_bbml2_noabort())
> +		feat_mask |= ARM_SMMU_FEAT_BBML2;
> +
>   	if ((smmu->features & feat_mask) != feat_mask)
>   		return false;
>   
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 358072b4e293..dcee0bdec924 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -4406,6 +4406,9 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
>   	if (FIELD_GET(IDR3_RIL, reg))
>   		smmu->features |= ARM_SMMU_FEAT_RANGE_INV;
>   
> +	if (FIELD_GET(IDR3_BBML, reg) == IDR3_BBML2)
> +		smmu->features |= ARM_SMMU_FEAT_BBML2;
> +
>   	/* IDR5 */
>   	reg = readl_relaxed(smmu->base + ARM_SMMU_IDR5);
>   
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index bd9d7c85576a..85eaf3ab88c2 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -60,6 +60,9 @@ struct arm_smmu_device;
>   #define ARM_SMMU_IDR3			0xc
>   #define IDR3_FWB			(1 << 8)
>   #define IDR3_RIL			(1 << 10)
> +#define IDR3_BBML			GENMASK(12, 11)
> +#define IDR3_BBML1			(1 << 11)
> +#define IDR3_BBML2			(2 << 11)
>   
>   #define ARM_SMMU_IDR5			0x14
>   #define IDR5_STALL_MAX			GENMASK(31, 16)
> @@ -754,6 +757,7 @@ struct arm_smmu_device {
>   #define ARM_SMMU_FEAT_HA		(1 << 21)
>   #define ARM_SMMU_FEAT_HD		(1 << 22)
>   #define ARM_SMMU_FEAT_S2FWB		(1 << 23)
> +#define ARM_SMMU_FEAT_BBML2		(1 << 24)
>   	u32				features;
>   
>   #define ARM_SMMU_OPT_SKIP_PREFETCH	(1 << 0)

