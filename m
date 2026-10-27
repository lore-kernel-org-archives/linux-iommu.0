Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.43.78
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793101620;
	b=xlUNy3yucOfS0kTu1vRMd6VOwG3CxBteMFJWr9scBtRUyt/A4Ii4r6euFZVh+0jqNpIR
	 BgvGRnZrvpYnedUNv91fMx8w8QHnU9vJ4gjUbP76pCeq4u+IP2gUTXS8DSJuF7a8y91Ef
	 cwEVg6GtkhpTUxXW4FvxshcZjl68D6kjbflEec/RB8mQSDZ8KCopsuahaftguHve+M1EI
	 ZdFrwwKGPg4h1ZLdSoU0Yrhln3sSvyB/yBAuYFOf7ASao8wY8uLT0cuXqRS13Bp+vsVOH
	 RIVW6TR6yv/T7Ytw9Gf+6FKE2zJV3fibElwmy6CI6SQtGpBXrQXm5A81p9CFYday+lA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793101620;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
	 X-Microsoft-Original-Message-ID:MIME-Version:
	 X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=cFnyBiT/lrkM3aAVIKsMau7nQJGRSJcd83zTCarFwis=;
	b=VaGkT4xF7TI2qHrwb4sFQf5F8Ru1nEosk+8Jlt9YmL9bWazc8DYskRbXMwYUvJrE3EhZ
	 hCIOItp/6zaX+NJTE7ibfpSRXv+lFUUEup5rEgkdMBNucPkQKhtT0TjmPfdw9wWIDC9c3
	 HmeovApQQn3okZOt4u0KCCX8u9akuOgXAekB4TPOvBKAMG0l1N0ATEL9x3lSvNGPxIRnp
	 UYAv9R2G1WiA+NlTycnCcxDdG+Dpy0yp9shRSHZAHwGus3hFxPPJC1m6nYa9rIxzb2kCZ
	 CykszrxolIvcRYXNpdie8SC3EcqbrdN+fEvXdxbbfq5uDyUV1nadAHs19nKElefm+MQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hotmail.com;
	spf=pass smtp.mailfrom=hotmail.com;
	dkim=pass header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=ZceZXy8g;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.43.78
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazolkn19013078.outbound.protection.outlook.com [52.103.43.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F88C606B5FD
	for <iommu@lists.linux.dev>; Tue, 27 Oct 2026 11:46:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F88C606B5FD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=ZceZXy8g
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mwRe7BNhO/y9CiWWTObppQoPw/meAtEY2ulIcCWiisvrVzlU+7HIABn9ARnvpBTiMJ2g7BUGar1ZVnEqUApwA8+lsfOO7WfTYol85COvIKSmUBT2F5Wsohoez5C6LtfGHDh0K1kUMm9gs+mpRBdA/UDWBaEYq7xX5L0McHYxPCax635nFyGsXmK+y+Y7/tDKfGKw8OS0tivHl7nB5cs7KQ4lxsESMedsjmZ/UfgdqEE57Kvdwro75rEQN0AoDXulBjnNOkFvHZ/zjjPYSJS7+l1QRfJSPEAtfbRvVNlFmYN/HEDJCL6ZHcgDfzEJBLYtf2ZRvImenB2sjaijLak7/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cFnyBiT/lrkM3aAVIKsMau7nQJGRSJcd83zTCarFwis=;
 b=HZlZ5Q4uR1r1/1+eaW9LRvtZQGyumvx2iBo/0tmc0NMaw7hWcRAT9F3+1JZGEd5jHsn5hPSLx2cxoyyHIsb65249XJHuMKmA86LuCrntJ2wbC3d55j179xcBZUDHM4lhYyPrGygeOOC8h6v/Lx8bNNMFo4QN/6EIvzTAe387+2KQuIhax9HE91oBF0qwI2/kg59cKO1ki0SSgGYlohuCn7V+JHCOeMay96lkgRoKgCKg7HhKFriSXO5h4JIEIlcZrjIaxoT0YuPPQ3VHzxCzGrfMFdSDuIKLxU/zp86tLLkiB6SsaeZLQRUew3ed29i9YQp5P28+sfJGi/n12OI0EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cFnyBiT/lrkM3aAVIKsMau7nQJGRSJcd83zTCarFwis=;
 b=ZceZXy8gUobgaPs0LSMTMW75vInpwq5EbYxgXqjn6FrMZk8AcIYySfSrENR2rvzuSFB+oHYS1moB9lRU7LasI/CvNdXibUUjnrWodGH7efn9Sfa5NTqVDYlGhy42oi+U+Jr6yj5DwmZHB6p29h5dhOu5rgS0aq5huxAmpBjDMOzyp2P7orqiDu1d0EaQLU7xWRDCOwN9hmW850AQr5fE1EqpLfQnIuzb7/E4yo8FFq2BJ5s2ZVwuwryvt0QRzCYZT5YC3SwFvmJTwcnK1uCIW3UfQcXXH46tdaqtNSvhoiERgekMURsRhgIF8GIeJJJBePfFB80SZwVP9TMNBrupEA==
Received: from TYZPR04MB7491.apcprd04.prod.outlook.com (2603:1096:405:40::7)
 by OSQPR04MB7948.apcprd04.prod.outlook.com (2603:1096:604:28f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 11:46:48 +0000
Received: from TYZPR04MB7491.apcprd04.prod.outlook.com
 ([fe80::a450:2576:3b21:6230]) by TYZPR04MB7491.apcprd04.prod.outlook.com
 ([fe80::a450:2576:3b21:6230%3]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 11:46:48 +0000
Message-ID:
 <TYZPR04MB749148EDFFEE323B5280786FF3602@TYZPR04MB7491.apcprd04.prod.outlook.com>
Date: Tue, 27 Oct 2026 19:46:39 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 10/10] iommu/riscv: Add IOTINVAL.GVMA invalidations
To: fangyu.yu@linux.alibaba.com, tomasz.jeznach@linux.dev, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, pjw@kernel.org, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, baolu.lu@linux.intel.com,
 jroedel@suse.de, zong.li@sifive.com, andrew.jones@linux.dev,
 anup@brainfault.org, jgg@nvidia.com, jgg@ziepe.ca, kevin.tian@intel.com,
 atish.patra@linux.dev, skhawaja@google.com, vasant.hegde@amd.com,
 joerg.roedel@amd.com, tanchi25@mails.ucas.ac.cn, gong.shuai@sanechips.com.cn
Cc: guoren@kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, kvm-riscv@lists.infradead.org
References: <20261020094106.92722-1-fangyu.yu@linux.alibaba.com>
 <20261020094106.92722-11-fangyu.yu@linux.alibaba.com>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20261020094106.92722-11-fangyu.yu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TY4PR01CA0062.jpnprd01.prod.outlook.com
 (2603:1096:405:370::14) To TYZPR04MB7491.apcprd04.prod.outlook.com
 (2603:1096:405:40::7)
X-Microsoft-Original-Message-ID:
 <91c0077d-cccd-454f-8b5f-3984db27903f@hotmail.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR04MB7491:EE_|OSQPR04MB7948:EE_
X-MS-Office365-Filtering-Correlation-Id: ed54605f-fe48-4e5e-258f-08df341ffb9a
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799012|23021999003|22091999003|55001999006|24121999003|19101099003|25010399006|4140399003|41001999006|51005399006|19110799012|8060799015|6090799003|5072599009|40105399003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bzBzYmFaaWtTeUZPRE5YL2RxcGlWRHpOV1hxam1WNnJyM0JVSFg5cjU0aWhK?=
 =?utf-8?B?Sm00S0RMZ2E4OVhCRlZOblRjSmhYbEpFRGwwTGgrS2tkcHRFL1ZWelNYRENM?=
 =?utf-8?B?OU9xaWVuemlPcjBaQlBmemhqSmRiMXF2dUdmODl0QzV4TWhJVzVwcEFVT2dy?=
 =?utf-8?B?SW00MU03L2tBeGQxMFBWbXByVkl1RUFjQkFERTFKdkdSd2p6L3JFUjJzSjNl?=
 =?utf-8?B?TzVCTEsxeTkraXNNbUQ5a0pLTWdtZzNyUWJMdEMzbE9MaW8vY2RZa0dLci9i?=
 =?utf-8?B?NStLWEFVemxqa0kyaTRsOTBNVG9kcUtvWEV5by9UYXpTaFc2MlBkeHpBR3lD?=
 =?utf-8?B?Z2tJSkQ3enBkcVdwclZSUmVwUTFoWXZoUVlVUm41R2VsTDFCMFF4Nml5MlVz?=
 =?utf-8?B?RGgrWURpNytPUTk0R3RUWnhaNHM4eXNCV1MvelhDOVo4MVJkVVpHdTdwT1RM?=
 =?utf-8?B?RUI2d2NISFJLM0xVelB6OFFLK0dlTjZmWWxSY2lQWFZqSGNIWTE3TjN6MkFD?=
 =?utf-8?B?YkN0TmlBakRJYUtIQ3NocnU2MHZWSHZ3VWh4TG5JMUNKdy9mTWZiOFRIMXdL?=
 =?utf-8?B?eXZFN2pJSFBLS1pveG04R0FPUnpyeWEwY29TbUxOOEl3TDZxZEk3YzRMR0pU?=
 =?utf-8?B?ZTk1SGNhNHRJWDFqQ1dOMW9TWU9YZzE4K0JZN3NDZTFGb0U4bXRMNENnMzQ2?=
 =?utf-8?B?U2dGdDUxVlo4TTduY1NOVGt5ekRqNkQ3TG9YeFZzOWs0d2loRUI1ejFRTk13?=
 =?utf-8?B?MmRNMHVmNmhiWml4NDFxOUFTVkozZVdOdGxlREV1ZUYva2x6a0NQMFJaUk1H?=
 =?utf-8?B?bjltb2JDeDdyWGl1NENKU1FSb1RQc2p5Szc3OTJMbHh5d1JHM3Aza1plbm04?=
 =?utf-8?B?aWo3dUJ6TENFT3JXY1JvYnRTaThQaHdobmw1d3dOeGphK3pEN2ZIZWx6UmJY?=
 =?utf-8?B?Zy8xYXkvYk9hWFM3bHVNUE5nMDlYOUZ4TzNmZmxvS2ZWazRmQjlrRzVBWjZE?=
 =?utf-8?B?bCtBK0pVTjN2YVgwYnNmWC96RHRwK1o0THgrdXJ4UUFPaEswTnlObVhLMG9P?=
 =?utf-8?B?WHEwdE5Xbk1abXc1V2QxUllheDBOQ1FuMUFFemxYVDlDeklKaGh0YjArRkdp?=
 =?utf-8?B?VTJYMmw2MWFOZTl4KzVibS9JNmV4aHZpTkxxd3lJUjlpYkUweGQ5MXd2amlv?=
 =?utf-8?B?QzRYOVpQN1IzVElHM3RUc2llekVqNHFJK042bEl0aHpwd3loUW5aNVVCbGJM?=
 =?utf-8?B?UE9iN09FQkpvcVRnYk9pcmxtZXZSU3hpbkJlWDlGRTZyd3JRUFJNbWVxdWx0?=
 =?utf-8?B?eUVTcHliZ0VpYW0wM1hralYzSzNHS2ZsK1UzQnU4cVpSVUtXRSs2UCtZN09z?=
 =?utf-8?B?dStEWDc5aW9zRnhhcS84YW9vV2pUSzlucWYya2FGbWN1YWN0Qkh2ZGdEVlJt?=
 =?utf-8?B?NUxkZHJkRnM2K0ZvUy8vN1NlMm81SEt5OTQ4eHhRPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YXgvWS9tNHdUdThPM2t6TlpiSiszTk1HWnlCVmcyY0pLTnJGelorbHlsSjBp?=
 =?utf-8?B?UlFvVlpyWnE0VHZjTUtnaVBqbFQ0MExXeXlPblgyWkxhOW9kcytFMmdVZE03?=
 =?utf-8?B?eno1TExHKy9zcEdHd1JmekM2N2N0aHJGWTJTVzd6YmplTlZKOTQyd0lyWElR?=
 =?utf-8?B?a211WTNRaG1TTUFNTFpubjNySFFCSnpNTFcxemd0VFZieGVETkl0Y1JNRFA1?=
 =?utf-8?B?MUYxVk83TElSLzVrUm1BRHRpRkVnMG0yTUxJazVuNVhjNEd0Y21NVjF0a0FP?=
 =?utf-8?B?bDB5dTNyUS9oVFdOY1VpaHZLcnZsTjd0eGhmTmxybTRBbnM0UUVqMEl1YzJo?=
 =?utf-8?B?VjEwNXZSc0toZW82QnJiOFlYdEJJUHdzbi9GN0hjdGxxTWJaMDNRcm52YVFO?=
 =?utf-8?B?REFUa1lKY3VrVzB6WU9vUHJHMkxNc0VOYWJlbHBqckVTK0hKYkpHeUNnQTZt?=
 =?utf-8?B?L1dQWHhEaXlla3FNWXdpb2RsdU94ek5ZdVNwYjRsdkRTUVAxU240N1BHd01I?=
 =?utf-8?B?a1laSDEweE14c2U0M3g0anEzTEFzMDRDY2ZUeWlQSUVJU21YWS9xckwwSnFN?=
 =?utf-8?B?bWJ5b1hnM2ZYcXFIUDU4cmM5REJGazI5QWdwSE5xM09lZndUM1VlRERhdTIv?=
 =?utf-8?B?MHN6VytORytKcEszSjFXTGJNcnNOVUZ3UjI1eHpPRkYzTFFLcUtmcDFCUUJN?=
 =?utf-8?B?U2pWTktUeDQ4RlVpMTA5VEV0bkd0L1RrTVIxOXZ0alJUdFpLNHdrMWd1YzZE?=
 =?utf-8?B?ZDBIaVJ2K1hxL2dmNTRhVUhsYnpKNEhncVNNWjZheUxTWGc3N1dDUWNuN0JK?=
 =?utf-8?B?OGZsWXk0T2VoSHgzZDhRTmswZTR2YUpaakVqSFhSUDZVMmhESkNKYXNEcXI0?=
 =?utf-8?B?elBOMCtOelp1eVE5L0p3Nm1Zb0FMYUVZdGxwbExLRWtMaFFhVFl2NUFUOUFz?=
 =?utf-8?B?T3pPQ0I1VzNJMjlyeDhuZTRTbW4zUENBS3c2elA4bXFUZERPTzc1L3JZRVNp?=
 =?utf-8?B?SmdwWEF4dVAwVXBNalNyc2Vuays1bnhPNFJiUnJnTXFmcjh0dWczd2dnODZ6?=
 =?utf-8?B?UTl1OHNPYi9VU0NPdkpRMFRMdmg4Tlo4aXQvL2lDNi9LdTFYY3U2c3hvMG90?=
 =?utf-8?B?MUovcXkydnNwd2wvbTJRbjh5cHJoMGJ2RmtWRTM5Mi91aHRnUTd3VUNpNVRF?=
 =?utf-8?B?bktIY3hKcVBPb2Q3cm5EV3FRUlhkRXVpamE0S3o5VmNYWGNzUUptVnF6Yzcv?=
 =?utf-8?B?dXY1N3hwMUlZYi93UFl6b1hvMnpBb3RHZlJUM2pYb1dLUnNhb3dLVDRxZVZx?=
 =?utf-8?B?NkJKRWdrSWVkTjdXQjQ0MkRQVTR5NW1VcXh1Z3EzVXFCQkZLeENQRGQzS0lT?=
 =?utf-8?B?V2VsNjhaVFhGaXFlblF3cmRYT0hPWWRUWS91U0RGeWZjZHRJdTZWMlVLbkZJ?=
 =?utf-8?B?UEVzM1ZMeDl6S2pqU2lYRzkyVGpwL2E3UWt1aFdRV3lDdGxwSG1GODMzSVQx?=
 =?utf-8?B?SUdrTXJETmMzeU53VHo3VHh1S0tCNjZHZ0k1ZlhSNVNiZEZ4MzBteFhkQzhl?=
 =?utf-8?B?NHUvTWdkMXJTejliTlkxTmU2cXltbnBieEpWcHlnMyt2QitiTlVUTnkzbS9E?=
 =?utf-8?B?aC90WUtvbWJJVWRqWWhCZXgvNUk5eDVvVDJVUTJleGpTenJUeTBFQ2pFNENn?=
 =?utf-8?B?UWVvRyt3cVZsTjNsRjY1YVN6blkvazRRVjV3YWpWaUlVSElvR2d3aFdyTkF2?=
 =?utf-8?B?Q2l5VW1pMEtuUzRYT3NhSjNvSjBCSDRBYSswY0kxVDJiOGg1Zmg0MndYT1VJ?=
 =?utf-8?B?cm1DWU5zdGlvWWU0SHBKaDZPWUpHM0ZaT3p3blFiU0tWcWxLQmJvTEJ5Vk8w?=
 =?utf-8?Q?84tFBHjVWpd0J?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-c3e7a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: ed54605f-fe48-4e5e-258f-08df341ffb9a
X-MS-Exchange-CrossTenant-AuthSource: TYZPR04MB7491.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 11:46:48.2200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR04MB7948


On 10/20/2026 5:41 PM, fangyu.yu@linux.alibaba.com wrote:
> From: Fangyu Yu <fangyu.yu@linux.alibaba.com>
>
> Previously, only IOTINVAL.VMA was issued, which is insufficient for
> second-stage address translation consistency.
>
> Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty
> ---
>   drivers/iommu/riscv/iommu.c | 18 +++++++++++++++---
>   1 file changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> index e3791e912af3..a764a172c588 100644
> --- a/drivers/iommu/riscv/iommu.c
> +++ b/drivers/iommu/riscv/iommu.c
> @@ -830,6 +830,15 @@ static int riscv_iommu_iodir_set_mode(struct riscv_iommu_device *iommu,
>   	riscv_iommu_cmd_inval_vma(&cmd);
>   	riscv_iommu_cmd_send(iommu, &cmd);
>   
> +	/*
> +	 * Per the RISC-V IOMMU spec (sec. 5.5), the IOMMU may retain
> +	 * cached translations across mode switches. IOTINVAL.VMA only
> +	 * covers first-stage leaf PTEs, so use a global IOTINVAL.GVMA
> +	 * to flush stale second-stage translations.
> +	 */
> +	riscv_iommu_cmd_inval_gvma(&cmd);
> +	riscv_iommu_cmd_send(iommu, &cmd);
> +
>   	/* IOFENCE.C */
>   	riscv_iommu_cmd_sync(iommu, RISCV_IOMMU_IOTINVAL_TIMEOUT);
>   
> @@ -1175,12 +1184,15 @@ static void riscv_iommu_iodir_iotinval(struct riscv_iommu_device *iommu,
>   		/*
>   		 * else: IOTINVAL.VMA with GV=1,AV=PSCV=0,and
>   		 * GSCID=DC.iohgatp.GSCID
> -		 *
> +		 */
> +		riscv_iommu_cmd_send(iommu, &cmd);
> +		/*
>   		 * IOTINVAL.GVMA with GV=1,AV=0,and
>   		 * GSCID=DC.iohgatp.GSCID
> -		 * TODO: For now, the Second-Stage feature have not yet been merged,
> -		 * also issue IOTINVAL.GVMA once second-stage support is merged.
>   		 */
> +		riscv_iommu_cmd_inval_gvma(&cmd);
> +		riscv_iommu_cmd_inval_set_gscid(&cmd,
> +			FIELD_GET(RISCV_IOMMU_DC_IOHGATP_GSCID, iohgatp));
>   	}
>   	riscv_iommu_cmd_send(iommu, &cmd);
>   }
