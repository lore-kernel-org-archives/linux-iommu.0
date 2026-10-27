Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.43.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793101430;
	b=it96wX0IC1UYipONCX9tTlkZoi8CREbffYMY8gtuPTJrV4AyIyNoIZ7iUFI3hZOj7cuO
	 Xh6affkovX18/oeEFRVmYAeGjvnofCCkXNDsECFxiTUfmbKyQHk4g3PmaA4p9BJ7Xga5H
	 sobIy3KUFh5711ULNY2yLRzaReb8VJvbcKbCkn241NQObKdgozyHFxWqQaSzJbGLFbe3a
	 +AU0tPzRo7EY2KUNT22gCk3JZm1s6J8nuKXlVR7OZNUG0eW8QOqDjDAVBVRRf9Vrp5ujN
	 x2omrIVEVe6Oi7LW6zqAz2CmXUoQ1SLs9CDUwIzMAJIKEzH4jGsKKJHe1j6NfQTrzkQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793101430;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
	 X-Microsoft-Original-Message-ID:MIME-Version:
	 X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SLBlob-MailProps:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=92eTut/geJv/+sVMPAKtJWpkqdz4Tv9qUIkv2ns7to8=;
	b=H6WY4n/+AgfXT3c89RkNN3gwTZiRvAW3a8RzZkDaLl/yGV6OTjR9IofUshlW+TYQKzqj
	 FaLyty1N+0ietjpr6Ss8IXEWbUWk0KiJ1MTbMZpyzInUf9HheiWZ8pU0eMqmGw6bauArY
	 dAuSekbTGlo7P3uBVPP9ZuwcBc8seoGnXaTpREUVIKkGlaNp04g9G8AfQtbQ+DW8HCLvL
	 1V54ahQFTF0XdjxEhoSTaHinlYNUGF7r6PwwrL5s2wH0QHI1YTBnzQIFzEMMOzQCHS/xY
	 ruGZmBmWmlcxkLS0kTFtYW9wgE96oP/b/gN71aOO2N70ZUVNUDr+QEVnbirCWrPbfAA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hotmail.com;
	spf=pass smtp.mailfrom=hotmail.com;
	dkim=pass header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=W6hMKnaq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.43.77
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazolkn19013077.outbound.protection.outlook.com [52.103.43.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8921606A9CE
	for <iommu@lists.linux.dev>; Tue, 27 Oct 2026 11:43:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8921606A9CE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=W6hMKnaq
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AiOOp7kIVsPs/ST4S8u5j9ONu5LJMQh8HO0MGPoyZ2cprZOA7aPcOd3wSR49Eyb1Ry9AQNLVY3cCB+S2RJHbelJg38twIuRtSfv+u31fBNQfJWawbkMoLX22GsKma5EQ5xKyn3V5ojG6abrYfRgZD2jOLlW8rqhWmZufR1OVypFFD5G/6JJ5cC3BwlysmUf4pOzqOnpRjcSqjKTa11YM6sV/HUP3XLa3P/Ziz1ZAvmArigRhAuRydas2fIdfM0S8mz0eIR00nn+WdXBqOTg78C4kceu53XNT19cWoJvsYY+m0S9IXH0AGu+XuDzlbVyt8Eslvu/dW7VWtR8sOgl4yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=92eTut/geJv/+sVMPAKtJWpkqdz4Tv9qUIkv2ns7to8=;
 b=EJ25885fVi368Je6sEDYvou+Is4o1+/WjFD1/QqPI31QAsrRtLYzYC0U3fpFOycMuqSjX4YYBMoPVz4rDfdwJTZYKBuOzw27/uyAsCY6jF40ObdoXC/GxaP/5H58dfgYfkZkHj+skdZUgxfhRLmSGlxEBP+i7IpyosnJWB4dBG4QMPZHbXZ1H0Z9WBhS5mu0em3MmR9uYcOuNH7HYCbgoHi+LibWAIsor2+99OnUmog+Vz61aO33n5AB1cFvSLauvGDYPVzdvDVcrQygqWuWz42frl5OAIA42E1ZEyNeb1CkTC0nNJF7pA5foAKr0V3ktJsDerk5W3SeDnI51CHnMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=92eTut/geJv/+sVMPAKtJWpkqdz4Tv9qUIkv2ns7to8=;
 b=W6hMKnaqSKd8sXcLeRBdZ6dlhBFOVtjipgLFzBD7yVdqtHUqi0VM0qQm3B2lNiesajBGHm6VH/BwJmhT53mhj8xuMvSbVBtVOcUnZPUdawkxuTBRqoax9cag7PAIrmo1OJiBVB2lPSyf47u6SADEbFjUpLVmXqJjwyYdjFozpAIFSOsYOK4UMfqoLy7S8Anbn7woxR7jN3ACCh8u6gx54kaPRRrat+BTfXSElW+N1uZb3eYdD5bjjfhzaGt+B0cOL94bqyi2EOeLdr9cH3twcKk/4hhMEJy/WGUOz4o36N9Tecic5gUNnUWHc39G3E1IT40vhFJPuGCcnXT33f+unQ==
Received: from TYZPR04MB7491.apcprd04.prod.outlook.com (2603:1096:405:40::7)
 by TYSPR04MB7565.apcprd04.prod.outlook.com (2603:1096:400:468::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 11:43:39 +0000
Received: from TYZPR04MB7491.apcprd04.prod.outlook.com
 ([fe80::a450:2576:3b21:6230]) by TYZPR04MB7491.apcprd04.prod.outlook.com
 ([fe80::a450:2576:3b21:6230%3]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 11:43:39 +0000
Message-ID:
 <TYZPR04MB7491539CAE8D3B333C52F12CF3602@TYZPR04MB7491.apcprd04.prod.outlook.com>
Date: Tue, 27 Oct 2026 19:43:30 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 08/10] iommu/riscv: Pre-enable GADE for
 second-stage domains
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
 <20261020094106.92722-9-fangyu.yu@linux.alibaba.com>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20261020094106.92722-9-fangyu.yu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TY4PR01CA0065.jpnprd01.prod.outlook.com
 (2603:1096:405:370::19) To TYZPR04MB7491.apcprd04.prod.outlook.com
 (2603:1096:405:40::7)
X-Microsoft-Original-Message-ID:
 <8024cefa-1444-4c4f-9d65-1f3765c989b5@hotmail.com>
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
X-MS-TrafficTypeDiagnostic: TYZPR04MB7491:EE_|TYSPR04MB7565:EE_
X-MS-Office365-Filtering-Correlation-Id: c0d09e5d-e818-490f-e23c-08df341f8ab0
X-MS-Exchange-SLBlob-MailProps:
	7J/vb0KDx3j4EGtrWC76yZtYjXYOkK333xSg9hEGOYRtPchb1QKtyGRvUyJwuN3QiIEalU8LWQfBWzjvfgUGrFesxRZnQjQGudosT4J1R8XE5r93W97CoH6G+JldbW8mRyjqyQCMgJyXmsxo73WscX2sToIAN87ubLxQ+cXK8mtm/W2fc4QqteaNRBho3mcvXzRHhEGJq+9y4vIZbaIieGYoFIivdnTRUDLZ95p0gYqGe17sgZ2aH/yg6WRde2rd62Cu42sHE7qYirl11z43qKQkKGSrkDFdiosP+6Vl5kENlTHvZ8aVTTBwSsBhjyRyKGxpez3JcHfQfGjg82Rlkg9AXdDD1C6uNBWJg7dH+dYubianxKxYdVRNCnQwBpEi0RlW5rsfhV4n3Tay8HCdnZXVMfFs8nH6q52xM7yjGQXO7IXCV9uLxHntS3U3oJzh5GZiTf0ilXKha817f2UsfnG/+a194PPLPh3qJQm9XOThQ30RQP5mZuehfkPdt091m3xsLmNbsHPPZIIq2pfS/8OzNPnP55EigXRi89QZ11TTQNjzZDGlBgNyATBdpnFedqrpe7t9mIm3e8iR02D/M9P3kDv/9vt6fkae96QkydSuTwSa4IbfrfbxOaPEPR6qf0N4vxy99kkQribJGXd3+L0Z4mi6VHawX47QstAGJl/qdp2ZLJZ6Uvn+9Tl4APFgD8yh0AQ08sJgIk41jw3uZ0uQNIw5pmsFesevgARxNb/I3UX5e+FeAzna/A8OLQ6QcBgYL6R5wms5o1LLMbOS/+RWCT6VkR6NinJpQ9W9vlI=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|41001999006|51005399006|4140399003|25010399006|19110799012|8060799015|22091999003|24121999003|5072599009|15080799012|6090799003|23021999003|55001999006|19101099003|40105399003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Tm1wNUVqL3JEVndld1ZiK3F2QzQzOTBtRlF5b21rWE56cTMxa1ZnYUtLT00v?=
 =?utf-8?B?VDdMcFRnMHZCeFRsY09LL2pma0dicTFJMHhtZXZaK29NTElweGRHOFlBalFz?=
 =?utf-8?B?TlF0ZmR0eHBxOExndkllN05iQWkwRDNSNkt5RDZsQ1lyK2gwT2EycmNGcE9q?=
 =?utf-8?B?dzh1U1Z4UFFYNVhNL3FJQUdRdm0wanJOaTNVYmVmMmxjRzJtT1czMFdjTG9x?=
 =?utf-8?B?WlU1Y1BXTEwxa1FGS0FhdXBHZE1CSThGcEJ6QTN3dGFKdCs1NThZR3NPV1RM?=
 =?utf-8?B?WjkzaGNVYzEzRm1pcVRreWRHUkliTGlYT0dqY3VqN2pQT3l0SlUvd0RMcDJZ?=
 =?utf-8?B?OVlLTFVYYzNwRUpGV2IxalBkdlNYN2s0bWxvb0hnUGZDQXlGeElVNmsvam1s?=
 =?utf-8?B?eW5FU3Q0VVJwbWIzckcvbGhPcnlHbTA4UWM0WndHVUtlN3RLV05rQjJOWE9V?=
 =?utf-8?B?RlZnMnNaeVJrcjgwdWpFVzlyeGMrMWM2K1Vrd2I1S3ZDOWRPTVVwamtuOVVI?=
 =?utf-8?B?Yk45RS9pT2ErOTR5d3JyS21PMXpBbkw2Z1VvQm9IUmQ4M1pFb2ZZaGlEMW5K?=
 =?utf-8?B?YklwVUM4cjU2WkhDKy9vdTc2bGdDTHBrWVBJQzdDd0J5alBBNFAweVloUVQ2?=
 =?utf-8?B?bGlmaC92VlJhNThMNzVHaytiMVAvVkFJdHdLRW5NeXJkUURGQXZTaUVQcGlt?=
 =?utf-8?B?eWh0NGlVbDdzZWdJV3VDcDJIblQzWXl1WXNPT1B2b3VrcUg4NDQ5dlpGZW9Q?=
 =?utf-8?B?MkNreGhBNHd1UUtGRnR1VlVNSk1xd01kSm1DOXZiN3R5OWVZa2dpZGNhQ2RN?=
 =?utf-8?B?amlzVXFnMXNoNFIvTzhGN2piWU1BLzFpMmY0dloyZkZiMGR2R3VnUmJpejBw?=
 =?utf-8?B?S0dXSFJTcVRrWWduNmJ5cnlwVE9iSEU0dkxYeW14eFJkQkszUEp3UHZlMVY0?=
 =?utf-8?B?S2dReVFqV0NObE5SRWZoTGpuQThVYlduTU83aUtGNjNFcE1ydElSamhFU1Jx?=
 =?utf-8?B?NzNNUVN0cFZnS3Y4M05YYWxDb3NaMVd5SnFsSFpyNEhTVHN5R20vV0NJc1Vl?=
 =?utf-8?B?dVlNWFpMUFFZRHk2azJTVGg4OXI0RStEeDlFWXNZZm9MVUQ5N3lCbW9wUU5D?=
 =?utf-8?B?ZUIvRVpIRGtlcms1ZzBORTBLUUdtK3ZFTThVRUZQQzZHc09maTFkU3BMRTBp?=
 =?utf-8?B?MXluV1Z1SFF5NXQ1OFYybmlFYlArODJJZnFrbWI5MGt3TFdEeER5L3M2cTg3?=
 =?utf-8?B?Qml0djlwMURKZDRPTlpIcmRST3hWN05qUnNZLzh1Yy9vZk4vSUVCMzNIWlZy?=
 =?utf-8?B?TXR1T0N5MU13aEpLMmptOW1DSWpYNEVrbXdtK0lnWVBXTWpxd2FhNktjUWF1?=
 =?utf-8?B?dUJMRjlDa3ZybGhhbzRZNXA2dG1PdDlNWENLcVdTcURmMU1wTlVESGpIYXRa?=
 =?utf-8?B?RGJSRHFTQUFDRGczM0tYVmM5TDBJb0dKQkNZaWFBPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dEZsR0Y0bDdOQnRHZmFWMzR5WWwzNkZ1MUtxU3c2ZGFTZTAvKzJFTHJ6TDd1?=
 =?utf-8?B?Y0RLOUxhaFYyVHE1bUF6aVI0cmVuNnI3cnUwUFhqQUxCT1gyOGtHM09uMkQ5?=
 =?utf-8?B?Z0k4eTN4YkpOZyttenkySDhMek10RFdqZm83a0RVaXZGdXNSbGFNbmpoaTN2?=
 =?utf-8?B?aGZISnVlajVGc2JPdzFMQUNBN0pVcDB0N2JRYmZIRWdDOHV5OVNKNGM5ZElS?=
 =?utf-8?B?WnRDcnZnZitMUTgwaWgvaTRTcGtzMzhPYjY3a0JXN0lCQ1VoSmJwb21nV2Fs?=
 =?utf-8?B?OE5nQ1E1K1prcjF6MDMxNFVkMVlRbnJ1UXordEdLUEt4M1ZLL0M4UytVZm9W?=
 =?utf-8?B?VzlhTGFBYkNEUzRxK0hWbEVyMG9HVkN3bkcvb0F0Snh5SExBdGNBYnd6cjZJ?=
 =?utf-8?B?UmhleWFiNmFEMUtKcjJjcUFxMHA0MU11QmlsbXVWdis2ZEh0VWptZndPaVZJ?=
 =?utf-8?B?OU5KMXJDL291aGFVbkg2ZzlKSUZuQ3ZITldpdVIxMlZ6citZS2lvL3EwaGtW?=
 =?utf-8?B?SUx1a0NzeWJjZzZab1ZWNmRSZTN3K3A1Y0c3V2VVMVhhOEFiYkloN3Q2djZQ?=
 =?utf-8?B?eXBBN3VsbjI2ZE9GbHpwdG04VkhxU0ZiZlBZbm5vcFNPMWVWL1NlVVRBTEpD?=
 =?utf-8?B?aUtSSmw2UXV6OHdsNUIrajZTMlFvL0gvZXBBRzBQaFBBT1VtR2x1aE5tTzFj?=
 =?utf-8?B?TnVzTmpiTEVVaXIwcmZuM0hDS3JsSFdQMFhyN3c4Z290SlRlODBBQnI5dU55?=
 =?utf-8?B?MHF0VDgzbnpBeHRhWGxORlMrV1JEU1BqTURxUDhrbkxoWUlhbTFYOWgxRi9T?=
 =?utf-8?B?TWRmdUxBKzVGL05wMnRXa1BFdHAvYms3aXFaSkVNZExIdG1FY0pkNmlzUHhk?=
 =?utf-8?B?c0lQWHlNU1RqVEpiS2pWMVhvV0Y3Q1RYeU9hZFRrMXNZVkhQZ014UDZtZ1FV?=
 =?utf-8?B?YUFTd0lwbVBqaDZJU2Q0SVd5RUg2NnhQOW5xWmgvU3ZtVUNqZFpYTnJPRkRD?=
 =?utf-8?B?YklQb2k1cUFVSHhvWVlNQUZSVldqTXRWZzVvTGRENnI4R240bXc4VS9JSlph?=
 =?utf-8?B?VXFkanpWd0FhbGZBTVR5eFNKU0loUW9OWEtTaGtVUENzaWFwQ1dOUXdZd05y?=
 =?utf-8?B?YTVkZFhnNzBabHlyZnBDQW9wWEpvN3pRZExKa0tKT3dYY1c1dmpvaFQza0pj?=
 =?utf-8?B?YmpKUW9vS0VDWElCc2ZGalk3RzlraGNqRmlWNFprTVJsYVhZZDc2OWN6SXlj?=
 =?utf-8?B?dTcxVUtUUGN1MktFVW5KV3Y0UHJRZnMzZ09CM21PUW1TZjAwS3BhQkhxWkJF?=
 =?utf-8?B?dFQ2OTJhQmc1TVJzSGVmeUFLdUVZams5UHBNZ1NTWElhbmQyT1ZvVStoV01X?=
 =?utf-8?B?Ym8xUC80cFBqTE5xWVIweEJjMmdRUlB4ZVhhbVJDTWNISEZRdmdaOG1YdlBl?=
 =?utf-8?B?RUQyUlZPN29VSjJxTkFDTVZSeVFFVW9RVVNFQjY1MVU4OTkyd0NiM0ZnbzFU?=
 =?utf-8?B?eTd2Mm10MkFFUjF5dGVlT2s3U0xDUWg2QnZlWGdoNFZlOFNQM0x4dTNGRW5F?=
 =?utf-8?B?S2tTVCtqNWJRQ0lEV0ZLblBMdFVNL3NZM0RqNm5ndFhsNTJLSmlnbnV0Y2pi?=
 =?utf-8?B?L3crY3lZM2RkNVlYVkZLcDkyMFkxUVJGK0hCY0JwNlh5T0lOelR3WnpIOWJM?=
 =?utf-8?B?UHdNcytKU0lPS3V1TVNWQ0dVWkR2WVZJV0lrdnNpTXkvUFViTm5rVDRFQk1i?=
 =?utf-8?B?aFhZWHVGczYzOTdwQVJDaWVGV2xERUxCOGpoaEJOdG9OeFVBNmRJYy9sTkFQ?=
 =?utf-8?B?ZDRBNVQxL3ZUVFJYSGliUHRVVkRBUm1Ga3RnT2ZBMGhFbXZtMWJ0QWh5bk9V?=
 =?utf-8?Q?y3ZTegkFKmfvK?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-c3e7a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: c0d09e5d-e818-490f-e23c-08df341f8ab0
X-MS-Exchange-CrossTenant-AuthSource: TYZPR04MB7491.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 11:43:39.1944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR04MB7565


On 10/20/2026 5:41 PM, fangyu.yu@linux.alibaba.com wrote:
> From: Fangyu Yu <fangyu.yu@linux.alibaba.com>
>
> Pre-enable RISCV_IOMMU_DC_TC_GADE in the device context when
> attaching a second-stage domain, if the IOMMU supports AMO_HWAD.
>
> Software pre-populates second-stage page tables with D set, so
> enabling GADE by default does not change normal behavior. When
> dirty tracking is enabled, iommufd clears the pre-set D bits and
> GADE becomes necessary for hardware to update the dirty bit on
> write access.
>
> This avoids toggling GADE dynamically and keeps device context
> setup consistent with second-stage domain attachment.
>
> Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty
> ---
>   drivers/iommu/riscv/iommu.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> index debce1b4201c..9310b818c038 100644
> --- a/drivers/iommu/riscv/iommu.c
> +++ b/drivers/iommu/riscv/iommu.c
> @@ -1236,6 +1236,8 @@ static void riscv_iommu_iodir_update(struct riscv_iommu_device *iommu,
>   	for (i = 0; i < fwspec->num_ids; i++) {
>   		dc = riscv_iommu_get_dc(iommu, fwspec->ids[i]);
>   		tc = READ_ONCE(dc->tc);
> +		tc &= ~RISCV_IOMMU_DC_TC_GADE;
> +		tc |= new_dc->tc & RISCV_IOMMU_DC_TC_GADE;
>   		tc |= new_dc->ta & RISCV_IOMMU_DC_TC_V;
>   
>   		WRITE_ONCE(dc->fsc, new_dc->fsc);
> @@ -1352,6 +1354,8 @@ static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu_domain,
>   			FIELD_PREP(RISCV_IOMMU_DC_IOHGATP_MODE, pt_info.iohgatp_mode) |
>   			FIELD_PREP(RISCV_IOMMU_DC_IOHGATP_GSCID, domain->gscid) |
>   			FIELD_PREP(RISCV_IOMMU_DC_IOHGATP_PPN, pt_info.ppn);
> +		if (iommu->caps & RISCV_IOMMU_CAPABILITIES_AMO_HWAD)
> +			dc.tc |= RISCV_IOMMU_DC_TC_GADE;
>   	} else {
>   		if (!riscv_iommu_fsc_supported(iommu, pt_info.fsc_iosatp_mode))
>   			return -ENODEV;
