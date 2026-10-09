Received: from mx0a-00823401.pphosted.com (mx0a-00823401.pphosted.com [148.163.148.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685B24D37DA
	for <iommu@lists.linux.dev>; Fri,  9 Oct 2026 12:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.148.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791548118; cv=fail; b=TTnI15pnfCihbZY3Oma5kRdSaKBCh1pBmCQXZt+csPXV8H1WnyOMGUIMMxzt689toFe+T1dKtkK970F+U/Cfsr1v3EhzhCz5gSp6k4WiHcvQ9ig82o0udZqft9TSM26jQKKtz34HA4OpiTbXwR6I/PrVpqtPwsFSupiib/gCQSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791548118; c=relaxed/simple;
	bh=CndRy8XQAsRFy00n44pSCXk6yVIKf46ul2r2SzREOw4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RRisPqyj5eorxSHFTn/7yV8JOI2lMjJdxr8chz2E0df459l501urs0mumn/Em3fZs86SIQB6W7h5K6o0gzqLACqXuWrNerREQy+fHHXCtd9r6FTZCxrRudaI+ymhMJVp7H2BQkvephgLDTrHAleNjYwTR2Cx9/lQFFmHxv9JR7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lenovo.com; spf=pass smtp.mailfrom=lenovo.com; dkim=pass (2048-bit key) header.d=lenovo.com header.i=@lenovo.com header.b=lXUPNZXg; arc=fail smtp.client-ip=148.163.148.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lenovo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lenovo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lenovo.com header.i=@lenovo.com header.b="lXUPNZXg"
Received: from pps.filterd (m0355087.ppops.net [127.0.0.1])
	by mx0a-00823401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6998HGqR2077964;
	Fri, 9 Oct 2026 09:12:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lenovo.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM202306;
	 bh=a9KYnmlxRMhMtgBpYxoxSYCDpZOuqqWKt2Y7pyX5lmU=; b=lXUPNZXgppeL
	xFz4jHfB/YzCzNVBeRfCjpoXIywfwMDfR9HZxDisnLo75EbWJsZIUb/6VmmU34ij
	z9MW1GNW9krAK0Lbrj1a5bHb59htA2YVOIawrzxgBIR7R+zyVmzSNzeW5a1nO+sw
	s7jLJxpqDcOOEIqI9HYQwBbFyfw3Hi3+iijL0F6Ik3B/KQXlgwLUedoS8U4QspXj
	8jAi/kzX30EmOPvnn2GQjZ+GRtv3/6WgOwCmnHVOzUmzvo2rMn3kZTuv6uV9C2PG
	d5J1EUnfhTytfvDzpbF6Sm268/JN1mlGCwCl7cUpPPqtjDsT/QJ4M4toPh8jHgV7
	NmBEirmPzQ==
Received: from tp3p295cu002.outbound.protection.outlook.com (mail-taiwannorthwestazon11010014.outbound.protection.outlook.com [52.101.230.14])
	by mx0a-00823401.pphosted.com (PPS) with ESMTPS id 4h5xeeuta3-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 09:12:04 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rk/mUrSgmWWrNL9GwMMgfOYMuceION3pIJqMzAnC3GHCIgd6MJfiRkMfvMBAbwhv1Gkxt4lojliD72XKUUzBFlBaS61po19vp7BbxfLJTHeLO2nDkUH2hfzqAiBtIjTaZkdMzTMCpZTbUNfE7I1tyjsgOfBsImskbPIfayXOT7H1PBSOiPpTRV7lMFOUHmoCYWy4AmMO4hzW3h3Piyq32hKA2CBL9Lk6lFc4qXiepKncCYl15/cvh+SmY1eS8nAfMD0l4CCjF//o9/+suLjuXHG+wAlwEQTXZE1g85WHwVMxi4djo3SBXecnwHHDQxeyy2Dp6ACQ1zfW8+B4517KoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a9KYnmlxRMhMtgBpYxoxSYCDpZOuqqWKt2Y7pyX5lmU=;
 b=Se17/pOH+MNB+X8QfphPKCB66cQewiEoZU3y9qFXin/Eq+3D4T+In+rtpBUAqqGBpl9p0Ck8NxJkYtR4XqRwRg6Jjhjp/zodT7a13/ahAe0mm2FwEPV43iJ+/iSSALY6vG8UB3x9FfZcRk/79sYW2JGkp41vDSf+czFXQZK+DcLjQpS0pyZsfWlmqrvpxltRXZE86h1+EYiuD5Q5CFNjojPUHjMxkCHOOHliuldjLrk7aW7+qt6B6t9K19HfeLBXGfYFES4C7Q3bDPkLW5TEzl1Vmc49rzizECfv1yuUP2m0Jdk2YaPXtUAMMmzjM0m2JBv5C4O0w1zQWR5BJDLGtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lenovo.com; dmarc=pass action=none header.from=lenovo.com;
 dkim=pass header.d=lenovo.com; arc=none
Received: from TPZP295MB0013.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:b::13) by
 TP0P295MB0167.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:9::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6; Fri, 9 Oct 2026 09:11:56 +0000
Received: from TPZP295MB0013.TWNP295.PROD.OUTLOOK.COM
 ([fe80::788e:e9ec:6aac:5820]) by TPZP295MB0013.TWNP295.PROD.OUTLOOK.COM
 ([fe80::788e:e9ec:6aac:5820%7]) with mapi id 15.21.0522.002; Fri, 9 Oct 2026
 09:11:56 +0000
From: Adrian Huang12 <ahuang12@lenovo.com>
To: Christoph Hellwig <hch@lst.de>, John Garry <john.garry@linux.dev>
CC: "kbusch@kernel.org" <kbusch@kernel.org>,
        "sagi@grimberg.me"
	<sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>,
        Jiwei JW10 Sun <sunjw10@lenovo.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: RE: [External] Re: [PATCH] Revert "nvme-pci: clamp max_hw_sectors
 based on DMA optimized limitation"
Thread-Topic: [External] Re: [PATCH] Revert "nvme-pci: clamp max_hw_sectors
 based on DMA optimized limitation"
Thread-Index: AQHdVvfRmYb5vg+eQEGROWicjtk3c7bzlZoAgAFVUlA=
Date: Fri, 9 Oct 2026 09:11:56 +0000
Message-ID:
 <TPZP295MB0013C6E51C73799E49B8EFF4B3922@TPZP295MB0013.TWNP295.PROD.OUTLOOK.COM>
References: <20261006120248.147654-1-hch@lst.de>
 <8cf8a8ea-c9c9-434b-aec6-e361280a88a4@linux.dev>
 <20261008123724.GA22096@lst.de>
In-Reply-To: <20261008123724.GA22096@lst.de>
Accept-Language: en-US, zh-TW
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=lenovo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TPZP295MB0013:EE_|TP0P295MB0167:EE_
x-ms-office365-filtering-correlation-id: b6940b4e-14e9-4916-062d-08df25e55dcf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|18002099003|22082099003|38070700021|6133799003|10067099003|56012099006|4143699003|11063799006;
x-microsoft-antispam-message-info:
 wsc5xJmaENtxRWc+lWY8BqYGVUN0NFxLIw1p+R5L4hmymyzmuRxVuj8FI49EcAynKl9kTDBVCDfMuSLLmZMhqxHxgFAfbFBeUYczOZaL7giSlhJgqXyLbYRtTG2zJNMaGX8oehBw2ZcvaEru/2UjzjacdORqMyH64B0ACtIcJc5Uf/qPhqhrTNL6UKvfIva1ao58vBDRbLE5R6uL6WkJvspOR8VueKvEKiytX69iM090c+a1Lce9gGdIFo9rDyPVZ6GAF8elXeT5M+BwkBfzZR1INLFPfm51A/LX+yVVfE43YKWDoj5VKy9t3//BKrmBihVEq8jCcWWSZ5GbqEH755dfrwyEYf9NqUxh0lHp2ekpwfzIhoTg/b6H9gojFfLGa6JPk3aAkCQIg8VF2bzhbzB5r+CQqtpWeNUHLHIildZUJZxNNWGRu4Umudgipuysw4MjHbuLxdy4sS4f+geiliSTJ0U/8XhtkjPg8TB8sA2/dqGltDXvPT54rkfinPFeX+YmiLMDsZhkJskQ4Bgmp/vJJcXC4NCpC1Bs1TMLa1fbnuDWAI665rB07z+KrwqzJGMHfdgt/xANbTlvDO7PzfpifiekhwlqZkGqbogUMWmZ1OcjBIt76mH+bqAUW1QqhBoB/a133smt7O6LTyWwOuhH54JqLh0JN6I4eeOvKX2tLMFI5L7cFT6Ktviu7cKDju1Eet7puNsPcRqHIi450aLZoJzkd8OJCzjnvPkFwJY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TPZP295MB0013.TWNP295.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(18002099003)(22082099003)(38070700021)(6133799003)(10067099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?PRy1ueTJoyyFFMwKyWH21BUBjOiIn0Jk1sAjviWsL69rmUsTtsvG8yV2lVy4?=
 =?us-ascii?Q?63lWDA7knarcXrX8k3E+rRdZVO2G2T1PmUDyo1tbsv5CWJRFQluXy0W7pcnB?=
 =?us-ascii?Q?iQAsi+h/nIPpCsQt6PO3sYFYErk1RrxCscXPQ7y9R2xPLEdOsDsKeG7S2kmo?=
 =?us-ascii?Q?1RbYShPhEFrjmCD7mDY8JPNVQZpQnDykrcFzw8iUcLcLBdyDpu0h8cVhtrwI?=
 =?us-ascii?Q?iAMap69QXgcaDzJHiWd/xQKQqHTmdoU39+iUi8scsSrE/0oZHGpY/EiV7+si?=
 =?us-ascii?Q?+KB9mWmufljnIzEDUUSD6T3xzzj4RunKzkuQ4nahjvWmbFVV7fbjT4bIFG9Q?=
 =?us-ascii?Q?xRnrgj14vup5pVfS8TN1pLQkr0Un5pGPFadUPU26kFAIg7AX4n3A1Ps4gTT9?=
 =?us-ascii?Q?YdKrCOGQcz26AjwvFUh6ehxfnISZjS89EpYA0sLyy6fQ2EuO4kloAYeW7pmS?=
 =?us-ascii?Q?7+NGLt1J6FUZVtiNUKSo0p7jg0taEGi7UH+WrR2+GQBV/Tz01yqfJod6V1cK?=
 =?us-ascii?Q?X2Tn6cosXudstZeNT1X8r1e4cLopEAh+hBaiFfNImRvqavKH0fLFkO1PQQ2W?=
 =?us-ascii?Q?rE8bywEvjWh39pirN/LnjXlmy7ex+OHSacIfWK7B7VDEhbV1slY1aQFLkhHN?=
 =?us-ascii?Q?iQFofPzGhmrHACWOOT9cfsqVMWT4atAAobugw/4SxxIS+PdaEkpakC5VmzLg?=
 =?us-ascii?Q?CIX5DRLf7Yz3kZhfow6xpUNxeRdj/gk/xVo8D5oUIktinlsSuINhaH/hTWqJ?=
 =?us-ascii?Q?QY4Zhumkmky29ooTX2Z1BPZdPDSjtA3WMaBB9mtl8D2QXth98Ktv+Ulhb1sp?=
 =?us-ascii?Q?1xpa2EQ3ag9TssLObV8qEHXzJAYVuudeJqplTkfRFTnvbg4hnBt2mvzpGD3u?=
 =?us-ascii?Q?6/V8bb8SLHcuev4Rn4acbZw1x+k71U+lJJfLnXCH3LDMbv4NbLx3+tK+j3EQ?=
 =?us-ascii?Q?+87U2hXsCvCM6FspxoYXKyGjR/72RVNMympFrQw/8oADP0fXB3y4vf0PVQG0?=
 =?us-ascii?Q?WFhniWQfPAmyGNPOQEZNm9lNf4uMgeO3EvXMGQrp+Ilo3HZIwtsJc0/BY0Wz?=
 =?us-ascii?Q?9tOyeRovvDm+HHdZOu2sPQmEKiic+3FESM8iXYPokCMHjYPR9BooSlx+jDkV?=
 =?us-ascii?Q?lXiDIp+K1gvymcrbj+/HM1YWk+zH2OpphESooVlTVsDTOdGysEddnXlQh+WQ?=
 =?us-ascii?Q?svEH92xyBrCOx7bqiKG62c1ksu4qcs9Xvc79YcnYczEMqLncTFUzgEIXkJFS?=
 =?us-ascii?Q?4rlooC9Rhvg3Qvk40Ue2hjlShPbEPYK8Uz1eZZUMFPQ1w4cUSPe/U1OBlgGC?=
 =?us-ascii?Q?Y9bwLGXLGz0D3JG4lotk8uTuP+o5n66GPpdakH69xnNHZ7I1Xq5u54aYvBLn?=
 =?us-ascii?Q?t/LiIZEK9i5ywUcgHpDJkzCfpPac0g6V8O2dz3/NUbTLxagRlH8PlrBxUHnA?=
 =?us-ascii?Q?mTEbI3VH1F5SlJSUn/OZzHKLoJ3VsPkweKTrFZyhGmsTQ/qAX/HL86oQTVd3?=
 =?us-ascii?Q?oex6k1dFf5GxWsdyiAWynPUf7oybVHhnwqCgiRH3VotVyzmQqDurSGnMS0nU?=
 =?us-ascii?Q?lKJD1UJVv2lw3t9xMzw7S/eqiw5Tm4eTc/WiK1a6FADO5zEIz8U+3mbHkNn0?=
 =?us-ascii?Q?ssj0k+1FIhm861ES+QmyC/5ife3HtZVdJC5YTscnAfUDmhoLHCQrXOuIq3K6?=
 =?us-ascii?Q?EQRQ4hWd+83jMjlUgn01N6ejjHqBvOjekfYWL+TgiltOmmE8?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	WwiY/R+VNiCoULw90cdZHr9DvMrvd2vmTsv+s9MvNu/ev1Qagrm+J5xXBWJeYkZf9cY3guyLnAV2AtdoV44DLYDx6wmq4wWllnz6rDXwOOEEtuQHmCKBUAw7MU0weTmT4tYyTTY/M2xhM4SnAAX1x/zt7G4M6ErOqM3yd+GYR1YiAn0GXbyyO15RCDmQbzpS2Q+eKoo0iqHIYfiSZkBE0k09IcL67N5+0IKUImdlyP5/Zun7wR4pfSMGjahJ76CyEY5vUGnSK4ZZ+MK1pzghp3xuzwPiptmFLWbBDk4mVVQi4guqR0LqurBvO+o49QwEzwLeA+2hMnHMSmaOKYQ3pw==
X-OriginatorOrg: lenovo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TPZP295MB0013.TWNP295.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b6940b4e-14e9-4916-062d-08df25e55dcf
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2026 09:11:56.1458
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +VBjTgfkCl0fzi24xdj3rPqyMSbqMCENHszfzb7y7odqLUsayFSEocfJNkR28XNXIaitXBVPGe+lV97FyU6dpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TP0P295MB0167
X-Authority-Analysis: v=2.4 cv=OpHaWC/t c=1 sm=1 tr=0 ts=6ac8afe4 cx=c_pps
 a=d0JMfj1Ci8/YIJrjcZcmaw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=2RTuljz969oO5usasWGy:22
 a=qMr132F7aASziHDET4f3:22 a=VwQbUJbxAAAA:8 a=8k6WQxmsAAAA:8 a=JfrnYn6hAAAA:8
 a=9eUaoc-G7gwYh5G43e8A:9 a=CjuIK1q_8ugA:10 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-GUID: efbXc0KlCEn5OwpBrviziiZqh0I3FwOY
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDAzNiBTYWx0ZWRfX9oANK2rE9iue
 Ohv2L0Q4tFPb8tezjMcFF9gDmnY5dEarBEzXg+jkWiQvwKFvV0o6ldzmpAEjmgv/oFvHK8ljk4H
 6zaB1oT0XFEMLpuyCYIzvvVwGdLnEdw=
X-Proofpoint-ORIG-GUID: efbXc0KlCEn5OwpBrviziiZqh0I3FwOY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDAzNiBTYWx0ZWRfXy/kwcuHMVpfc
 3xPOxyRhCbHnDp3V2gZ6+R/XtjLJDaKH7vhSSH+iC2rwmL2L7Ud+ljgn1ZCocDMdfewC6Izd32q
 5QOJtguWGeeQC2pwrhbJV9QwjxgMncUV4+JqN8PNoP+1e4yD/uB8GYjPKMaL+Up31CYkuz09Fmj
 QDsxOKRdrrBv12n2aR4CvCF9hbDaBq1IqxCxp2BTAOuRxjzyD6wysQctnpKslRqUCRgsZYTryEO
 WE/P5cTC6myLI0QOBCmCg1h97pdIHfXo9/WdZCA8W8fs102ZRYAKdANJmuy0UnaitE6tN7mtq/K
 4k/nbUClDzCWq8RG8jvnb2m3JRqmtLFGj9lHTwBB32ZDQZLxFxDQzAwDPZi40LdBaDVOXMAT0Mp
 OPEf4J7gxaq+imwcAHzlOrd01aMfxwXqIQ+tfpweQ+fkR/5qgFsmH6xZszwR4Ikmp9P52oPSwiL
 snkdVGzcfmcpTpdQfxA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_03,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 adultscore=0 bulkscore=0 clxscore=1011 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=-20
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090036

> -----Original Message-----
> From: Christoph Hellwig <hch@lst.de>
> Sent: Thursday, October 8, 2026 8:37 PM
> To: John Garry <john.garry@linux.dev>
> Cc: Christoph Hellwig <hch@lst.de>; kbusch@kernel.org; Adrian Huang12
> <ahuang12@lenovo.com>; sagi@grimberg.me; linux-nvme@lists.infradead.org;
> Jiwei JW10 Sun <sunjw10@lenovo.com>; iommu@lists.linux.dev
> Subject: [External] Re: [PATCH] Revert "nvme-pci: clamp max_hw_sectors
> based on DMA optimized limitation"
>=20
> On Thu, Oct 08, 2026 at 08:36:54AM +0100, John Garry wrote:
> > On 10/6/26 13:02, Christoph Hellwig wrote:
> >> This turns down to cause up to 15% performance regressions on
> >> standard large transfer workloads.  Revert it and hope the IOVA
> >> allocator can eventually be fixed to remove the need for the original
> workaround.
> >>
> >> This reverts commit 3710e2b056cb92ad816e4d79fa54a6a5b6ad8cbd.
> >>
> >
> > What was the block size and conditions for the original issue? The
> > commit just mentions that mdts=3D10 and we get a 4096KB max HW sectors.
>=20
> Good question.  The original submitter and reporter are on Cc.

1. The block size depends on the configuration of the fio parameter 'bs'. S=
ee below for details.
2. Conditions for the original issue: The issue is triggered if the IO size=
 > 128KB.

[Detail]
1. A NVME with mdts=3D10 (maximum data transfer size =3D 4096 KB)
  1.1 fio with bs=3D128k or below =3D> Passed
  1.2 fio with bs > 128k =3D> Failed
2. Another NVME with mdts=3D5 (maximum data transfer size =3D 128KB)
  2.1 The issue does not reproduce regardless of the 'bs' configuration
3. The condition '128 KB' is identified because the IOMMU scalable IOVA mec=
hanism supports a maximum transfer size of 128 KB.
4. IOMMU pass-through mode does not trigger the issue with the 'mdts=3D10' =
nvme disk.
5. The issue only appears with high-core-count servers
  5.1 Reproduced servers: 448-core server and 384-core server
  5.2 Non-reproduced server: 128-core server

BTW, with this reverted patch, I'm setting up the test environment to check=
 whether the issue does not appear with a newer kernel that includes the up=
dated IOMMU subsystem. I'll share the results by the end of next week.

-- Adrian
