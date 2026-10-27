Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.74.76
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793101987;
	b=vdPYIbSF2VkUVthvvBEpRj3AKmmGnMtc6gSJOrwRM0V2+O4OQ9WpzIezQc64mvrjqjTm
	 zU/rztBPhF0AdYthNApx9DuA+hZoAPZAqcVELWf4Eo42LTiJYSbN6NTb/PWiuf1p+7cqa
	 FOV5r+oGlgxwx/sW3Uli52ln7f29rMfACIZrbFzP3UgLfSTVap1KVrwTL1GYP/VgZVkJa
	 FUobFRdtRtA98fxumC19NxrlArwqz7w+fhqEA5lsMDYTjc5tvO7vKoXQxOnsjjqrlX8qx
	 qtkYYkdFSC7aTv0dM36O3cdJy/Flv5DGc//YF5ZD+y77FfkCyudrwG3kApzdzfI+NNw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793101987;
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
	bh=HS3ncY4U2L6vqsqXlTH9a+WYHFdTNj7GDa+xyTozurA=;
	b=lGz/cSu4rC6tDND+Hkg1J8kKH615JYKmlFeEoIIR8SchQti9sUBIs3hlTbqOtZWkEO8x
	 pZ7pR8oWQMu4fxbLKKg2xFZpf7H0lsTkZDhB33Y/EJrvjORxh0sHpQB/JL+X6wSou5OYo
	 YO1bsbID62FLJ64gQDkiewYc2R/n4YQhb9IGdGDoyKwvoGiGoN7gyXipkrQcDu0dzAIV8
	 LZZ8o2L6h00qyeLYHtc583kZeSuzN7yXpSBe+NgGxTD0RsqHt3JmsT2xAHO/TaOLv+AMy
	 iy8ANEARoHvjEoPH636fwz/dLmUYtgvQOdvh4tXYv8D+wBcmLAxlOOdKoteahzGbBng==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hotmail.com;
	spf=pass smtp.mailfrom=hotmail.com;
	dkim=pass header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=VJUlNKpe;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.74.76
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazolkn19013076.outbound.protection.outlook.com [52.103.74.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F01F606A323
	for <iommu@lists.linux.dev>; Tue, 27 Oct 2026 11:53:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F01F606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=VJUlNKpe
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IbE1cvhkJayHGwuZ+/CE7eqDPaTWRTbQ+muXdTBzR5pFz+jdWVybcQz0+iTxeVsZKwyqxhfv/cOV3uW34XaGp7qgJFydYk3tvRAP2a7oLi9r+9rOpzTq1nJlLubaKTDKr2Io2iEzS0xAxYhhFP62gFaA82Aw7c4fLGl5Vi0BvKGUfM8aKpByxPfrb1RgRvvLwYS2yjqBVrB+jm9Vr+F9GBbf8G9Fryq+uyUN9F45QU/2yFMCt+J6XN7Jgbyq4qpwUH3kJtGgJEy8665ZPg0jsDVkyAsjQVWStu1WbhrMt37kHFVHpAOPMpN2zlVOB7cjwuF6ptS5AZ92z9h3jlc9ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HS3ncY4U2L6vqsqXlTH9a+WYHFdTNj7GDa+xyTozurA=;
 b=IUGiYi3PrTYN/gVEqHblt65xYg8ThBo9hAKhcc1QgQzMoscqEdMoKc59zcB2l71kSAlLA+teFp2hdjrSyEoSuMmaJHsuBI1XuM5Il8aygqtFHtQs1Iao8dTVot8jZwSZHbdBTymWVNrSDFPD7rdhJ85xTrRZeCA0TzokAOVA283ZcPhxGCRXGaVj209ZiCu0oHEHXXLFuLJrSpvbdei9DsVEYLWTbEUwwxZntCXwHyBwBMt0Tvhb8KH3uyeR8B/s8I1jbbXvQ32G0qI4BoFkobuGw1nQlJ/O0eIwsZffEtCsNltKSwwRwXmzkuwstzqDq6RrYqjO+SfhJzJUHVQSwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HS3ncY4U2L6vqsqXlTH9a+WYHFdTNj7GDa+xyTozurA=;
 b=VJUlNKpe1K0FnmjAvhNBx8BpFLdPEM9ESMBz6FGiTE0wwn5tUeZRy7631Br0/ADSYF/OPr7ZQntI2rI15yGXvTjNQcrwhGeh+fHcL79RL0QR9qzr7goD2eIZD+oBiaYoOQxEeayFrvLdy9HVB+w6g8GtByBXxcT+MhCVPmD7YQRsHl/lufvXviP5svKi4VAHAOwXr3O+yP26ZpS47JT77JMZJ1OOf/gdbwWKR6Sj+fQDo/y00JzcO0zNp7pVLckyRPAMeQ74T5L6v02+iPJTpJBFRQ3FmySKgd+fcMWBHX6TKaT+xA4YLiysNWqcccU5YFzH7NfQJKBqiDpRGgc/YQ==
Received: from TYZPR04MB7491.apcprd04.prod.outlook.com (2603:1096:405:40::7)
 by OSQPR04MB7948.apcprd04.prod.outlook.com (2603:1096:604:28f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 11:52:56 +0000
Received: from TYZPR04MB7491.apcprd04.prod.outlook.com
 ([fe80::a450:2576:3b21:6230]) by TYZPR04MB7491.apcprd04.prod.outlook.com
 ([fe80::a450:2576:3b21:6230%3]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 11:52:56 +0000
Message-ID:
 <TYZPR04MB749109BCE4854B21EC908E3AF3602@TYZPR04MB7491.apcprd04.prod.outlook.com>
Date: Tue, 27 Oct 2026 19:52:46 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 09/10] iommu/riscv: Add dirty tracking support for
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
 <20261020094106.92722-10-fangyu.yu@linux.alibaba.com>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20261020094106.92722-10-fangyu.yu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TY4PR01CA0063.jpnprd01.prod.outlook.com
 (2603:1096:405:370::17) To TYZPR04MB7491.apcprd04.prod.outlook.com
 (2603:1096:405:40::7)
X-Microsoft-Original-Message-ID:
 <59562aae-33f1-402f-a5df-3e612c225f3e@hotmail.com>
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
X-MS-Office365-Filtering-Correlation-Id: b66ed4b7-720c-4c68-8ead-08df3420d6b2
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799012|16051099003|12121999013|23021999003|22091999003|55001999006|24121999003|19101099003|2604032031799003|25010399006|4140399003|41001999006|51005399006|19110799012|8060799015|6090799003|5072599009|12091999003|40105399003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dDJkZ3VMODVtdDFkSEFxYTJ4cng3UHo1MUFrbldXTThieTdxUmRrWE5CSnRM?=
 =?utf-8?B?T3BZZnpqWVdENXVlWEozM09aRm94SUsxb3FseWFZN1c4NDdrY241TXJmWS9v?=
 =?utf-8?B?T1Z4TGExQ0FTRnZGd0l4UGxDUzNiU2tQWFA0OVdVNkJuVk42YTZZSFNBcEtu?=
 =?utf-8?B?NVF5ZEZ5UVIyUWpCaHlvcmk5L0J4NTZYL2QyZHVncGpQNDR6YWFQTWdSNGRW?=
 =?utf-8?B?Vm9FTUduSldDeDZ5Vis1S1pFaDlJTnJpM1hWbFlTTjhPRXpNclp2RDlPZlkx?=
 =?utf-8?B?ZTd0Z0huYUg4NlZwYTVsN2xPT0kxNUp1M2tyZ0ZJZkR4SVVqdzVuOUw2eVFU?=
 =?utf-8?B?WVFuU0RvSGI4L29qQ0crWVJocWl1RTFkY3lZWndFTVZDQ3dmZTFrU3ZMdVVC?=
 =?utf-8?B?M0h5ZytSR1htdUdKd3lhS2MrbTdXMHhGQms2SUJVSmtKSldsNUFEMFNGRDV3?=
 =?utf-8?B?c1UzY1VWWnJWRTdYa2krUVB4aXh1VzJrN1dYRStOYkdlYXM2QkNSbjI0WVRt?=
 =?utf-8?B?Yk41SnBNWHBTdlVBblhmcnNaUnlad1FaSjFGZUhack9hbzRYRGU2U1RWOVg5?=
 =?utf-8?B?YXorajB1K1lJMlVpd25JbU9tNk8zZnN4UlhmWVV3OTN2RTE1L1FvK3orN0JD?=
 =?utf-8?B?bmRjMENnOWU5Y2FwQ2VHK3RGeEtQbkZSdFJ2RXowSFhrZE5ySnJwMlcrSkdl?=
 =?utf-8?B?a2NoelQ1YWtoemNSWUJlWW54Wm0zSitxQVFuRFpOMDBnNEQ0TEVUbE1NZmRi?=
 =?utf-8?B?NDhjZ0dsNy9vaDU3VUF5U0tXUXF4OEx4bFN1ZUh5YTh4alpkVUtCQlhWMDNl?=
 =?utf-8?B?cU1sVE5NQmhZa083aXZhcVJQSmtCVEpWTEtNVWJTYm10aGZNUmJKM3hFU05J?=
 =?utf-8?B?UmIvREhyOE56MFZ1dFlhNGlkMDVqZ1U2a3RmaVNmRkoxeWJiZERnbDU1TzRS?=
 =?utf-8?B?SUxLZ0MvWktaaGZxSTJLZG5ReHh6RlVJQ1BVWU82ZHZIampyTWhXcWVSbEdw?=
 =?utf-8?B?NmJTVFV4ZCtXc1h1d0FFU1BjNThiUWJWM1dZQU8xd0F0aUVXWk9ObC9FRzJR?=
 =?utf-8?B?ajhZelZUNHl5b1lxWWNjZjlFb3VvejF0d0ZnL3FwblhzUk5QWm8xeWlzQU1Y?=
 =?utf-8?B?RUgxY1VnMUtDTkQ0bG4yUUhja1NrSzJrMERURm50MDN6bnpJK2dGa0dSeVJU?=
 =?utf-8?B?QmtXMlRZdC9LdDJpbFhyWVVaQVkwYmVOZk5FaTl0LzVTSTBsWStxU0dQNVNt?=
 =?utf-8?B?NWxSYlUzeHp4dVFhbUJSMDhmdzJYdEMxZml5aGd5R0lzcGE2Z2hvQlNHby9I?=
 =?utf-8?B?T3g4WkxobUQ2STMvUlVTMURXYnpXSXlrcGRkR0ZRNFdPaEp6RGU5bXlhQVg5?=
 =?utf-8?B?M0NkRC90clpqQkJuUllEbm5QQXAzSGRpa0ZJWXRrYytjdk9uU3B5b3RYeGlR?=
 =?utf-8?B?NzZaa2xIWFRPVURTazQzMW5PV1F2Q29pMEcxd21STGNzLzk0dHZFem9Hemtk?=
 =?utf-8?B?b2VyUThBc251eEkzZlYxbUhoRnBEa1N4citEWkVRbUVuZlpTeFIxMnljbXpz?=
 =?utf-8?B?S2lwZW5PVS9zaEZ2cU9MejJkV0NHd0N0RjIxY3pzY1BRdUFkaGtRUm9oeHZ5?=
 =?utf-8?Q?k5RN+/sdprpr7OZBIFDn0+MOcJMSjHE5is5wb9qZ9j60=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N29ZcHJqbE9XemtyWC9uNHE1cjNaRzdDcGFaNVlKZXBvb2ZyckNTWWE2UEZz?=
 =?utf-8?B?YjFrejdpVjZOMytad3ZoWmFURjFsUTFCL3V4am5jVHhFd01DTTBXNVY0a0Y4?=
 =?utf-8?B?bnVVM2xpOFFiT1RETXMyNytFSno2NHVjSUJmM1Mzd0xHMnJDZHJxR3Z3K3Mw?=
 =?utf-8?B?Y29hUklNZENzbTd0R1lZeVNrKzNkdmp1dnNaYUdhSnF6djYvd3RoV1cwREFI?=
 =?utf-8?B?WnFPdXNLZ3V6c2dheTlCWVRtaVZyWmo3RWY3bTVSbis2cGdVRmd3NE1OM2V0?=
 =?utf-8?B?eXlHUEJJekJ3ckNKVGxRU1VIZkRrdnhpNEEraEVCdTQxQ1gxY3ozaDZ6cE5U?=
 =?utf-8?B?ZjdTL3FMUmpEQlRaUWtLZUppRmQ0Sll6a1VFdGlWd1pqV1hnYnZPVlJkc3R3?=
 =?utf-8?B?bmxNd0tEQksvMTJ0TXJzMUdTTjRJQTBvWXpqVUZyaktXTENkbFBaY3Y1ZFU1?=
 =?utf-8?B?UHgySmx1b3lVbGc5U1VSSW1wRm1aTGl0aGxLNmFKMjkySitGc1RvaFFYMDd4?=
 =?utf-8?B?REkwckkrd1pUWmVsa1E1MW9TOEdYR1pWSERUZ1QzdE90QUUxcnlaTFZ1N1Ju?=
 =?utf-8?B?WUhjYXl4cVB0V05FYmVVU2JTaFV6THViYkRmUUZESldVOVRLT1l0OGRsMDdV?=
 =?utf-8?B?eloyZ1plVytSWkI1R3gwbFdub2NMS05oUVgwc2d3UjlNRVZDUWtaNkRoTDFm?=
 =?utf-8?B?eFl2ckk5M0kvclBVY2tYT1oxWDEwMkZhaCsrYXFEbFV3R1RXeTBMclpHK3FE?=
 =?utf-8?B?SUt5L0NwL3UzaHNzN3liQUduVXdvenQxZE80SGxYSkoza2RhcnZ0dyswUFc3?=
 =?utf-8?B?QkVpc3k4TGdXRlIwRlNMY0ZsMXFnRVFSOExaRzd2ODZGL0d3MWgwQmliOFNF?=
 =?utf-8?B?ZU1zdGRuQkVJQXhGVElZdVIvRTAvdS8xK3RjdWJMd3QrWnNWb3hJREhad3lj?=
 =?utf-8?B?RitQWVBMaE56aXhMd2tsUWQ5NzBLNmwvbFRzTG5zWEtSbFd4WkFKdlplWmwr?=
 =?utf-8?B?a29HblJSNGsyVG9lUzFtZzQ5a3A5QjduNGNMMGhPOGtMTVNEOG9jT1FUT050?=
 =?utf-8?B?UVFxU0EwbXA0dTR0RS9BTzROZUxHd1pZNVc0bUZvYU03UDJtUml5a21UOGEw?=
 =?utf-8?B?R2pGQUI3MFlXc0lqQmFZZkhTRmJVSldHVmJKMTQ2VDJ3eTg4RGZlREFSTTVy?=
 =?utf-8?B?YkVRUGV6M2FyQklVckZraUVIM3hiaDAyOFZYN3F1MzEwN0thQXFNNmltclBo?=
 =?utf-8?B?a2JTcjlJSmFpRDZyeThKcEdzaEF1UXh0MnV0b3RPMUdLcXBnbUlWVDRtVjdH?=
 =?utf-8?B?dXF2Zi9XamlzcXN5T0xNdmJkdlNmQnRYdGpIVlpVcE9DWk9IN0xIN2I0bXVp?=
 =?utf-8?B?a0g1M0pkcnhVRXR4RGxYa2UycnhBY3RzYlZabGNjb2RFRGN2LzdHOTV5aGtM?=
 =?utf-8?B?K29SclcrTmoxUjB3a0Z6UWxGN3E3NTJyT0NUUjgxV0NadjRpaWZMZlNtVCtO?=
 =?utf-8?B?U21wWkpWTThlTHpLWTZKMkRTTVRnTzVkOHhiN05FSXdLR2F3aEZqek52d1hL?=
 =?utf-8?B?UTNhY0hPV2plOGtoa2xFRzA4cEY5REJxS1RHK2tLTlQwS2w4SHFHVlE2S0Y4?=
 =?utf-8?B?NnJWMUZucDNWZVAwSXM5R3ZYeTJvVnBNK3VlK1QxZjIrNG5oL3kydDVDaDRS?=
 =?utf-8?B?Snl6WVNCUk96WmlMT0Z6cmJiU2tybkJySjlwcjVRY29ZKy9Ubi9tTnZyYWp6?=
 =?utf-8?B?QjNIbHpzd0NndE03VW9SKzMwWUxmWjhqQlFma1U1MVc2OFFRdjRhV3FtTnFT?=
 =?utf-8?B?UW5zRUpTTmVUWW9SOWRxUEY5MUdWaU9xR1l6WXl1Y1lCTnhuVTQ0d0tiME94?=
 =?utf-8?Q?W+j6vgV4r1mk7?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-c3e7a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: b66ed4b7-720c-4c68-8ead-08df3420d6b2
X-MS-Exchange-CrossTenant-AuthSource: TYZPR04MB7491.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 11:52:55.8326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR04MB7948


On 10/20/2026 5:41 PM, fangyu.yu@linux.alibaba.com wrote:
> From: Fangyu Yu <fangyu.yu@linux.alibaba.com>
>
> Add hardware dirty tracking support for second-stage (iohgatp) domains
> used in KVM VFIO device pass-through.
>
> The RISC-V IOMMU can automatically set the dirty bit in PTEs on write
> access when DC.tc.GADE is set and the hardware has AMO_HWAD capability.
> Wire this up to the iommufd dirty tracking interface:
>
>    - riscv_iommu_set_dirty_tracking(): Always enabled dirty tracking for
>      second-stage domain.
>
>    - riscv_iommu_dirty_ops: Exposes set_dirty_tracking and the generic
>      page-table read_and_clear_dirty via IOMMU_PT_DIRTY_OPS(riscv_64).
>
>    - domain_alloc_paging_flags: Assigns dirty_ops to second-stage domains
>      when AMO_HWAD is advertised in hardware capabilities.
>
>    - riscv_iommu_capable: Reports IOMMU_CAP_DIRTY_TRACKING when
>      AMO_HWAD is present.
>
> Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty
> ---
>   drivers/iommu/riscv/iommu.c | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
>
> diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> index 9310b818c038..e3791e912af3 100644
> --- a/drivers/iommu/riscv/iommu.c
> +++ b/drivers/iommu/riscv/iommu.c
> @@ -1376,6 +1376,21 @@ static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu_domain,
>   	return 0;
>   }
>   
> +static int riscv_iommu_set_dirty_tracking(struct iommu_domain *iommu_domain,
> +					  bool enable)
> +{
> +	/*
> +	 * Always enabled and the dirty bitmap is cleared prior to
> +	 * set_dirty_tracking().
> +	 */
> +	return 0;
> +}
> +
> +static const struct iommu_dirty_ops riscv_iommu_dirty_ops = {
> +	IOMMU_PT_DIRTY_OPS(riscv_64),
> +	.set_dirty_tracking = riscv_iommu_set_dirty_tracking,
> +};
> +
>   static const struct iommu_domain_ops riscv_iommu_paging_domain_ops = {
>   	IOMMU_PT_DOMAIN_OPS(riscv_64),
>   	.attach_dev = riscv_iommu_attach_paging_domain,
> @@ -1466,6 +1481,8 @@ riscv_iommu_domain_alloc_paging_flags(struct device *dev, u32 flags,
>   			goto err_free;
>   		}
>   		cfg.common.features |= BIT(PT_FEAT_RISCV_S2);
> +		if (iommu->caps & RISCV_IOMMU_CAPABILITIES_AMO_HWAD)
> +			domain->domain.dirty_ops = &riscv_iommu_dirty_ops;
>   		break;
>   	default:
>   		ret = -EOPNOTSUPP;
> @@ -1541,9 +1558,13 @@ static struct iommu_group *riscv_iommu_device_group(struct device *dev)
>   
>   static bool riscv_iommu_capable(struct device *dev, enum iommu_cap cap)
>   {
> +	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
> +
>   	switch (cap) {
>   	case IOMMU_CAP_CACHE_COHERENCY:
>   		return true;
> +	case IOMMU_CAP_DIRTY_TRACKING:
> +		return !!(iommu->caps & RISCV_IOMMU_CAPABILITIES_AMO_HWAD);
>   	default:
>   		return false;
>   	}
