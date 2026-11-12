Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=18.199.210.3
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794453950;
	b=bUbPOdugKydoOE4HaBrcrVB7w8PTpXk1reTpjz/Pq1QO6QgAfsjygzds/Newspbg0ALR
	 ZINHO7vhrFMDviFBAPczi3ltKdoEDaPgi6jmeOZtmv8cYvkfiXteFdUy3ifpJ3knY1f8r
	 kosfQSa2qGox1I2EewodffNpoRSfL7UV8xQhGjwfh6Pf4lzE541iHXY/yNJsyAfaky8iO
	 DJFRRW6ff+tLmbC1HbkxBtqIIxevEn6KipqgZ0C14u8OB39R3AVnH+Gx3inaUSkIKOyd5
	 lg7mXmmFZRN1y2I5H3+zsU0mPvhP20P+onZnZEqWd8t60hOF7KmOVTzQ1HCBLYWZYfw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794453950;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 Received:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=NiRPY5T8Pf/tuGCLBnAtRQZBabRvlx1q7IzVaPWqPcw=;
	b=CskGEMqasmEkTMUTHTA93POhH/5H+r1AskRcl75kAEIZi0UJapEySgtvbRV4vnJk0V60
	 WA70nvw9mq0u/liJHlLKmhkruoCZOrTNt/d5bY6kBIdimj8Pmwh6vMGLyBZMKBMWBK8YW
	 78WMUZriY4Cjh04i2RXprbxJuYnicJLua41yihFejLMFmlQNeqMiPASk723NouEd+GfsI
	 jd3fp/+zHTn8rtpwSOEpp1fjUojRFkianISvN84wQVFCekOJSSsQfoIzKbrnIH+1w1H9Y
	 4TngSsUru9vdgI5p1Cau5Ayu89toY5Q0KLf1rQSfDinYaZwL0ZeM4mT6wvAl7+fucNA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.de;
	spf=pass smtp.mailfrom=amazon.de;
	dkim=pass header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b=M3lyIlGe;
	arc=pass header.oldest-pass=0 smtp.remote-ip=18.199.210.3
Received: from fra-out-014.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-014.esa.eu-central-1.outbound.mail-perimeter.amazon.com [18.199.210.3])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698B0606A321
	for <iommu@lists.linux.dev>; Thu, 12 Nov 2026 03:25:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 698B0606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b=M3lyIlGe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1794453949; x=1825989949;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=NiRPY5T8Pf/tuGCLBnAtRQZBabRvlx1q7IzVaPWqPcw=;
  b=M3lyIlGeNVe5+5wwaUTlwkHogu8zWrJT8+Z4eGkaUsZdzaYrLOm5fOlH
   EXAHmO7NVopnX9OQF7+tFw4P9Bx07umjWnt8IQ0P0idP0rz/lnaaVQaEh
   ZgvyRpsSoFOwHgMxYNN3IlfWZIl+E69RiQKcTEy7C7O8eX2kuV6fTfcy/
   RR5DVd3MIY8rDq/1VDK5gvBM3KGquzScsPQKdbw7ONmcUcSDoXelCF1Ib
   2O8v98lEYS9ChwKMggxvJ1WoXQl6lvMGRX76EeK4ZEfVpcu09F3gkkbh/
   HhMgzzJV9BZPL5rsM7wuwFPya6rWisNX9SUCcuCTwIKOv93u3auN8+Ft1
   g==;
X-CSE-ConnectionGUID: Db3XrJHRRfOkuxta9X/fBg==
X-CSE-MsgGUID: WbD68xjKSoGZF1QoYqbJvw==
X-IronPort-AV: E=Sophos;i="6.27,208,1787011200"; 
   d="scan'208";a="22556009"
Received: from ip-10-6-6-97.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.6.97])
  by internal-fra-out-014.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 03:25:45 +0000
Received: from EX19MTAEUA001.ant.amazon.com [54.240.197.233:28012]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.24.78:2525] with esmtp (Farcaster)
 id a211d648-a7d1-4746-9064-8bc5935316b1; Thu, 12 Nov 2026 03:25:45 +0000 (UTC)
X-Farcaster-Flow-ID: a211d648-a7d1-4746-9064-8bc5935316b1
Received: from EX19EXOEUB001.ant.amazon.com (10.252.51.80) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Thu, 12 Nov 2026 03:25:44 +0000
Received: from EX19EXOEUC001.ant.amazon.com (10.252.51.133) by
 EX19EXOEUB001.ant.amazon.com (10.252.51.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Thu, 12 Nov 2026 03:25:44 +0000
Received: from FR5P281CU006.outbound.protection.outlook.com (10.252.51.94) by
 EX19EXOEUC001.ant.amazon.com (10.252.51.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56
 via Frontend Transport; Thu, 12 Nov 2026 03:25:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DpB4t91xC72mSVwuWpWrvxQ4XeyNaYyu0yqlIzIVYjjdaTXxFELtmPdCG0u8IQmxeTuFf37msdOg4U72XRoL/Bb0FOjgGEFpbypI+4qAZIEPGd44J3123tL5pSoqoD64zedwHo7O/exShUxiO+1MkPa67wkNf/MXXnSV7hBmkgDpT33E1h59/r4PmRxc1cr6VoCq38X5oCVr3eSq9HRcG81VttBw2m/d66UWarV4KAQYmTpVP99KTJPmxv4gT6AWPRHrkB2X/o0NY0lFHrXbuQCugRV5AZAKgCUKZOf6UE7bKnEKAKSJp/WOwT/UdEqTDc/8lE5qh7H6LGtcSnuv7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NiRPY5T8Pf/tuGCLBnAtRQZBabRvlx1q7IzVaPWqPcw=;
 b=qAh9GM5aA+YpKXXNciR7pAOcK6z5oulE3P3GO0cmzcPV7HdX9Z59GRpkJCCBZIEuUhFuJZZiqMnkPcSmNvjUkIdQPdaTG1uEwg2VjpwGC6tcaVsS4R0sBbYCf7hKzlbVBfn613QU8h3Fo6I03MiRnVaBP+1R5V2FLpcmt8ICJm/kxgR8/0keU7g8rS3zLbk/61nz6lqH1hFrdiXhFbypFuCsQUo71uS3d+djCbfoW2Gjk/1nA09EENDkrMpwTBXkNPKZPoxUcGHlfjvmiAq/gC4baNMuCn9zqYTaCuJG942nnTG2OEjpeRogRVmJh7rXWezG2Zocdf0BGk5JuWImTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amazon.de; dmarc=pass action=none header.from=amazon.de;
 dkim=pass header.d=amazon.de; arc=none
Received: from FRVP281MB744463.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:20d::13) by BEUP281MB3702.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:9c::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Thu, 12 Nov
 2026 03:25:36 +0000
Received: from FRVP281MB744463.DEUP281.PROD.OUTLOOK.COM
 ([fe80::7b1c:7a5d:c405:6c4d]) by FRVP281MB744463.DEUP281.PROD.OUTLOOK.COM
 ([fe80::7b1c:7a5d:c405:6c4d%5]) with mapi id 15.21.0615.008; Thu, 12 Nov 2026
 03:25:36 +0000
From: "Graf (AWS), Alexander" <graf@amazon.de>
To: Randy Dunlap <rdunlap@infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>
CC: The AWS Nitro Enclaves Team <aws-nitro-enclaves-devel@amazon.com>, "Shuah
 Khan" <skhan@linuxfoundation.org>, Marek Szyprowski
	<m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, Andrew Morton
	<akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, "Mike
 Rapoport" <rppt@kernel.org>, "nh-open-source@amazon.com"
	<nh-open-source@amazon.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 00/40] nitro_enclaves: Add support for Nitro Sandboxes
Thread-Topic: [PATCH 00/40] nitro_enclaves: Add support for Nitro Sandboxes
Thread-Index: AQHdci4z9EVwZ+hDPEy4KuDVM7DF1Lcpq58AgAAa9YA=
Date: Thu, 12 Nov 2026 03:25:35 +0000
Message-ID: <5ca9b6f3-f864-4547-8b09-1a7dac453366@amazon.com>
References: <cover.1794300002.git.graf@amazon.com>
 <e6f8e81b-3c49-4112-b119-778fb8b89f38@infradead.org>
In-Reply-To: <e6f8e81b-3c49-4112-b119-778fb8b89f38@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amazon.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FRVP281MB744463:EE_|BEUP281MB3702:EE_
x-ms-office365-filtering-correlation-id: 0a0aaf03-d6ed-4e80-646a-08df406c9def
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|23010399003|366016|18002099003|22082099003|6133799003|261009223027099003|3023799007|11063799006|4143699003|56012099006|260925021311599003|260925022911599003|260925021911599003|261028144727099003|261102123227099003|261022075727099003|261022105027099003|261021123027099003|10067099003|261021121427099003|261102124227099003|261026121527099003|261026140227099003|38070700021;
x-microsoft-antispam-message-info: T3U2x6qoO8yrCcBxqIVpIhUuc8rfnzL4w+c2kaV/y9YIVgovROIbNe14EtZtRATg1g+y7/RJ+NsKTZnr7vHXAZdRe3PYh6zJso0Y53jYScpELi7xjlsqwJTw3W1a7j/TuVQDKIwXW5Y5IBJPtHJOlZDNv1Em9LBofRkypb+/lQflqN7QPLJvIppclP7RD8fPymUeI/34HKIn1f4a3LZmop9FhRJrs32RA4h4dM8FaqQ3A8kTAnTi5afKb8BgHLuJK5HyCZdZ44w+Wq8JyHO806Odn9u38uNVrWw7SaexEMkQ/rZzdkdpT9AsIbF04RebyOUvE9b1RGr0vYzAlim0vh49agfdgd7eu+kIz8bv76NaG5z0oSJanyQjeOlxWjPDXrGHhfcN1EhjDM0BpUWQ+tdEKiPcly4kUmkFUIdvlbtXlsGv9pyAe9hKvezH6P26ztl1Gbg+e8xFqhnTj8ANAIxSeDOHXRH6prW4RC81TGW8MzsCfd3R4gq/oOFoy4I4jO8BfkhE9C1lygZroN7SU6Gcujk3lZzhGr5tvkIJKGaQuz/jpOT0VV7TIuudvequtQn8PBAGCcJ08siWUO3MrmRAdBYSlFa2cMPRQ5hBYu0MGK7pEo04XrRqbiTnH392NuhWQ8fmACBvp8zaxSycnO4MxaYVIxRKRx/gKsm8OUA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FRVP281MB744463.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(18002099003)(22082099003)(6133799003)(261009223027099003)(3023799007)(11063799006)(4143699003)(56012099006)(260925021311599003)(260925022911599003)(260925021911599003)(261028144727099003)(261102123227099003)(261022075727099003)(261022105027099003)(261021123027099003)(10067099003)(261021121427099003)(261102124227099003)(261026121527099003)(261026140227099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UjU5OUhzUFBMWXdqc1N4WFpuVjJOM1dhNEIySW5JWk8vTXp2T1k0dEpPcjFD?=
 =?utf-8?B?QVIvOVFNaW5lNGdBdXFnSlVta0Q1d3M5R05lRzMrQXdnRXo4UUFvWFREMXpP?=
 =?utf-8?B?Y1BPbkZQU3d4MHRyTk5VSzFRc0RDRXFlWUhFQ3hUQ3NUb1hFQXQ1Mm03a1Fl?=
 =?utf-8?B?d2NFYzVMNndwZFd5TUd5c2R4S1dPbFJhOEgrY21zZjAvWjdnQmRuNGY1Rm1J?=
 =?utf-8?B?R29YUHU5ZFZ1aXM0K05NdnlXYmJsekEwaG94Mmo5a2IwZUpFWEo5eUNEbEFa?=
 =?utf-8?B?Zmo0MUxrZXV0VS9aRTVqOWpRbTVMQXA1UnI1MTlQMXYzcjlMcDJyUnZxMUt4?=
 =?utf-8?B?KzdIck1vajdWOXV5Tkk5VmxWMDJuUStJeHlvbGFTb1pQUTduOGhrMVd3NnNE?=
 =?utf-8?B?UU5WWENxSkhGRVdpZUhjbFNINzlVVlo0dHQrcGZwak92NWFwaXhrcEVFRGVv?=
 =?utf-8?B?VWJ2bkxJQzZlMXErZElvSU9RTVJGbnRJQ1huZGlNYU1GYjhKV090TjVoN0lF?=
 =?utf-8?B?SUZhamwzd29kYmQ4VXhZTGhMKzVyVHNBbXFUc2pxVkFaRGYzRll2Yy8ySThV?=
 =?utf-8?B?Ymt5QXQ3VFdrYlQ4Um12WXh3eExjYVgrOTlwdUUvcGZBdDRuOWRDR1F1eldu?=
 =?utf-8?B?ZEVxRWo2K1FhZFA2aVFSMDBQNEY1RHc1VUxKdGZ1RC9HTGJjaStEZDMvM3d1?=
 =?utf-8?B?aXZnZDU1eklxVmhoUkI2YVNrSER0ZXQzOXFYZytrbTdLVmpYLzdBVWZXYTJi?=
 =?utf-8?B?Y1E5a05HN3FqeGJwVEN6MXlNdTRXdHk1c3dVVy9TejUxR3lBTnMwUkVJSXgz?=
 =?utf-8?B?aTR5UzhkM3J2aGNyc1VFVE5MMVhwYTRFcHovbHUvd0JkNG1hc2tXRWg2a2Qx?=
 =?utf-8?B?aWFHODgyR2tmbUV4MS9yeEh2OFZBeFNsWEVHamsrN0l4eDVwTUZYQ28wWm1Y?=
 =?utf-8?B?VHltS2xBTE5qdDZrNmVaR3JMak9SNEI4ZzA5K1BuWTdhUzVMSVk4b2Myc2RS?=
 =?utf-8?B?RllMMjhlcDEra2FKQk9uR0hLUSsvOWVuazNlQ24rNk9CV05rbzBuTVVZcXRJ?=
 =?utf-8?B?RWxNU3pxbGxSV2hpSHBGbDRVYUxRcWQvRFFWKys4OS9ERjBoWFQ3VFVOeDVY?=
 =?utf-8?B?T2VZTXcyUStLR2R5SVdLVWZ5RlFJUEVZbGRVT0wrcGVFU3llaDFudlJmTnNk?=
 =?utf-8?B?LytUVFVkN1FUZElwQlowVUgydUp2RSthZmduRG5TN1A4cVY5RmRvTHpWWkhI?=
 =?utf-8?B?S0pHM2gvYkRYWUwwc09BL205eE03SzhUdW1PMGJCajI4VU5jbk9YMVBteEFB?=
 =?utf-8?B?OTNha3kvTEJ5RC9oUXZwOFdtODU5YS9ISG1XUmFmZ1NEZjE5cXJ1RXdmeWFE?=
 =?utf-8?B?TUwrNnlDdkVmaktIcTlLbU5zMHFDMlV0US9DeSs3Y09FNCtBNUxSNHlQRXV2?=
 =?utf-8?B?Z05vdXlQMXVaOHJmdU9KMFhjanZOaFRJSytvQllEN0tvQlkwSlp2NkNQUUdP?=
 =?utf-8?B?c3hFYytWSDhRaXFWc1p2akFUbnNrVnBlRHZLWnY5SUh6VTc2OE9EdmNoQktH?=
 =?utf-8?B?TnBXb0F1MHNaWjZBMjQxalZpclMrOTAwdHBnRHd6K25rbm9PMTdBZVhCcUZp?=
 =?utf-8?B?NTRIbzc2cmRwbzhpQzI5aUdRY0VyRHp3cW5kcTQ5VlhLMHlrZUlzKzJXYnAr?=
 =?utf-8?B?WDdzbEg2V0lZYzgwOVN3V2I5aEY4NkhYdVpyckhYQUVTZFVnVStHM1phQnFY?=
 =?utf-8?B?YmhVekxpMWprVkxnV1BWMGdTSy9zdUNNR1EvQWRzS2NvdDFiYjVkVWJHMDhq?=
 =?utf-8?B?NFQvNk5zdXlxZGZKZW15ZTdRSVNiLzBlTS96SFhlUkZhU3M1MkpacC9vRDdv?=
 =?utf-8?B?YUNMc2ZJb0lxUUltRkpCM3VzYURLVjJDdWJwWW4wT2RkZU9BYmNjNnlrVExi?=
 =?utf-8?B?emRUWks4dS8yLy9hU2FpMHd6dmRVYmdGcUhtdHE1dTJPL2o0MzRJWEFmRVFi?=
 =?utf-8?B?ZGhZM252cTVpV2VHQnllbnlOdTY1dHcvVzhpR0I4aVVTcE4xbUFXU2ZTb3Za?=
 =?utf-8?B?emNENU9sU1dCNnBJL1IzNkJtUEMvTFZyeU1zR1JWU0wrSkFDUDZBeTRaUVZL?=
 =?utf-8?B?cWJyMHRBVDdTL05teUd6Mm9GaWZhSzk5MDh1WVRnU0cvc0tCOEx5OFpQWWZw?=
 =?utf-8?B?dGNnUjVSRDFJeHRuZ0o4N01GWWEweDJGUzdtbE1Kb1VaMzVTdVg5b2VBVlVo?=
 =?utf-8?B?QWM1dXdCR3Y1a0JvOUtvbkliV3pJbG9JUXM1VGJvSnNESGZudXpQUlpVVkxw?=
 =?utf-8?Q?fKpkgFiN/Pr5yRE5Qt?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FC7391697F16C344B4A9593FCBFD2E88@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: CGaPQ3PrOsn2BpHg74uS/XjdOJyxGGS8/NMZ/8R6lRA6+JZubqBgOGlcxIy+YCK6Ja47f4gCI3JwhKN2RJ/2HY6ERRWUFuwgb4ehCaXxVSJ3gbfWA/v3SO4gPZQcca2Pu41I9Ae/dCPg12Qb5qcpROhlahrJxc7sBxuGAjEBV52APaIy9RNBYKqi3jZuf4O7r14izNTCFrwz7FME2kYnDsdvdq2byq4xerPcneAXPxXzvAt0YauwPcOupJEMNtRrWCSAkzfdI2/XtE3DfPwaZdftJz6aNuAz7lLUDxKo1YN7PjiE7t7dJm41qsdJe/evj1Qzo71iGSfEZ/XqnogMqg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FRVP281MB744463.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a0aaf03-d6ed-4e80-646a-08df406c9def
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2026 03:25:35.9183
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5280104a-472d-4538-9ccf-1e1d0efe8b1b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KjilYsepnlgSOmbpXn3MEjYgJua1vBub17WEfokh6IKKJRbPLesrK7ooyUe/027f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEUP281MB3702
X-OriginatorOrg: amazon.de

SGkgUmFuZHksDQoNCk9uIDEyLjExLjI2IDAyOjQ5LCBSYW5keSBEdW5sYXAgd3JvdGU6DQo+DQo+
IE9uIDExLzExLzI2IDI6NDEgUE0sIEFsZXhhbmRlciBHcmFmIHdyb3RlOg0KPj4gQWxleGFuZGVy
IEdyYWYgKDQwKToNCj4+ICAgIG5pdHJvX2VuY2xhdmVzOiBBbGxvdyB0aGUgQ1BVIHBvb2wgdG8g
c3BhbiBOVU1BIG5vZGVzDQo+PiAgICBuaXRyb19lbmNsYXZlczogQWRkIE5FX0FERF9BTllfVkNQ
VQ0KPj4gICAgbml0cm9fZW5jbGF2ZXM6IEV4cG9zZSBDUFUgcG9vbCBzdGF0ZSB1bmRlciBzeXNm
cw0KPj4gICAgbml0cm9fZW5jbGF2ZXM6IERvY3VtZW50IG11bHRpLU5VTUEgQ1BVIHBvb2xzDQo+
PiAgICBkbWEtY29udGlndW91czogYWRkIGRtYV9nZXRfbnVtYV9jbWFfYXJlYSgpIGFjY2Vzc29y
DQo+PiAgICBuaXRyb19lbmNsYXZlczogQWxsb2NhdGUgcGh5c2ljYWxseSBjb250aWd1b3VzIGVu
Y2xhdmUgbWVtb3J5DQo+PiAgICBuaXRyb19lbmNsYXZlczogQWRkIE5FX01FTU9SWV9TSEFSRUQN
Cj4+ICAgIG5pdHJvX2VuY2xhdmVzOiBBZGQgTkVfQUREX01FTU9SWV9SRUdJT04NCj4+ICAgIG5p
dHJvX2VuY2xhdmVzOiBEb2N1bWVudCB0aGUgbWVtb3J5IHBvb2wNCj4+ICAgIG5pdHJvX2VuY2xh
dmVzOiBBZGQgTkVfQ1JFQVRFX1ZNMiB3aXRoIGEgbGF1bmNoIGZsYWcgd29yZA0KPj4gICAgbml0
cm9fZW5jbGF2ZXM6IEFkZCBORV9FTkNMQVZFX1BDSUVfTU9ERSBsYXVuY2ggZmxhZw0KPj4gICAg
bml0cm9fZW5jbGF2ZXM6IE5hbWUgdGhlIGRldmljZSdzIGVycm9yIGNvZGVzIGluIHRoZSBVQVBJ
IGhlYWRlcg0KPj4gICAgbml0cm9fZW5jbGF2ZXM6IExvZyBhIHJlYWNoZWQgZGV2aWNlIGxpbWl0
IGF0IGluZm8gbGV2ZWwNCj4+ICAgIG5pdHJvX2VuY2xhdmVzOiBBZGQgTkVfU0VUX0lORk9fUEFH
RQ0KPj4gICAgbml0cm9fZW5jbGF2ZXM6IERvY3VtZW50IHRoZSBpbmZvIHBhZ2UgaW4gdGhlIG1l
bW9yeSBwb29sDQo+PiAgICBuaXRyb19lbmNsYXZlczogVHVybiB0aGUgY29tbWFuZCByZXBseSBp
bnRvIGEgcGVyLWNvbW1hbmQgdW5pb24NCj4+ICAgIG5pdHJvX2VuY2xhdmVzOiBBZGQgdGhlIHNs
b3QgcG9vbCBkb25hdGlvbiBjb21tYW5kcw0KPj4gICAgbml0cm9fZW5jbGF2ZXM6IERvbmF0ZSBt
ZW1vcnkgZm9yIHRoZSBzbG90IHBvb2wNCj4+ICAgIG5pdHJvX2VuY2xhdmVzOiBBZGQgdGhlIHNs
b3QgcG9vbCBncm93dGggY29tbWFuZHMNCj4+ICAgIG5pdHJvX2VuY2xhdmVzOiBBZGQgYSBoZWxw
ZXIgdG8gZ3JvdyB0aGUgc2xvdCBwb29sDQo+PiAgICBuaXRyb19lbmNsYXZlczogRG9jdW1lbnQg
dGhlIHNsb3QgcG9vbA0KPj4gICAgbml0cm9fZW5jbGF2ZXM6IEV4cG9zZSBzbG90IHBvb2wgc3Rh
dGUgdW5kZXIgc3lzZnMNCj4+ICAgIG5pdHJvX2VuY2xhdmVzOiBBZGQgdGhlIGRldmljZSBhZGQg
Y29tbWFuZA0KPj4gICAgbml0cm9fZW5jbGF2ZXM6IEFkZCBORV9BRERfREVWSUNFDQo+PiAgICBu
aXRyb19lbmNsYXZlczogUmVhZCB0aGUgaW50ZXJydXB0IG11bHRpcGxleGVyIGdlb21ldHJ5IGF0
IHByb2JlDQo+PiAgICBuaXRyb19lbmNsYXZlczogRG9uYXRlIGEgYml0bWFwIHBhZ2UgcGVyIG11
bHRpcGxleGVkIHZlY3Rvcg0KPj4gICAgbml0cm9fZW5jbGF2ZXM6IERpc3BhdGNoIG11bHRpcGxl
eGVkIGludGVycnVwdHMgdG8gcGVyLXF1ZXVlIGJpbmRpbmdzDQo+PiAgICBuaXRyb19lbmNsYXZl
czogQWRkIE5FX1NFVF9OT1RJRllfRVZFTlRGRA0KPj4gICAgbml0cm9fZW5jbGF2ZXM6IFJlcG9y
dCB0aGUgZGV2aWNlJ3MgaW5mbyBub3RpZmljYXRpb24NCj4+ICAgIG5pdHJvX2VuY2xhdmVzOiBD
b3VudCBtdWx0aXBsZXhlZCBpbnRlcnJ1cHRzIHVuZGVyIGRlYnVnZnMNCj4+ICAgIG5pdHJvX2Vu
Y2xhdmVzOiBNYXAgdGhlIGRvb3JiZWxsIHdpbmRvdyBhdCBwcm9iZQ0KPj4gICAgbml0cm9fZW5j
bGF2ZXM6IEFkZCBORV9TRVRfVlJJTkdfQ0FMTA0KPj4gICAgbml0cm9fZW5jbGF2ZXM6IEFzc2Vy
dCB0aGUgbGF5b3V0IG9mIHRoZSBpb2N0bCBhcmd1bWVudCBzdHJ1Y3RzDQo+PiAgICBuaXRyb19l
bmNsYXZlczogUGFzcyBvbiB0aGUgTml0cm8gU2FuZGJveCBsYXVuY2ggZmxhZ3MNCj4+ICAgIG5p
dHJvX2VuY2xhdmVzOiBBZGQgTkVfRU5DTEFWRV9ESVJFQ1RfTU9ERQ0KPj4gICAgbml0cm9fZW5j
bGF2ZXM6IEFkZCBORV9FTkNMQVZFX1BDSUVfSE9UUExVR19NT0RFDQo+PiAgICBuaXRyb19lbmNs
YXZlczogQWRkIE5FX0VOQ0xBVkVfQ1BVX09WRVJDT01NSVRfTU9ERQ0KPj4gICAgbml0cm9fZW5j
bGF2ZXM6IEFkZCBORV9HRVRfQ0FQUw0KPj4gICAgbml0cm9fZW5jbGF2ZXM6IEFkZCBORV9VUERB
VEVfREVWSUNFX0NPTkZJRw0KPj4gICAgbml0cm9fZW5jbGF2ZXM6IERvY3VtZW50IHRoZSBkcml2
ZXIgc2lkZSBvZiBOaXRybyBTYW5kYm94ZXMNCj4+DQo+PiAgIC4uLi9zeXNmcy1kZXZpY2VzLXZp
cnR1YWwtbWlzYy1uaXRyb19lbmNsYXZlcyB8ICAyMzIgKw0KPj4gICBEb2N1bWVudGF0aW9uL3Zp
cnQvbmVfb3ZlcnZpZXcucnN0ICAgICAgICAgICAgfCAgMjU2ICstDQo+PiAgIE1BSU5UQUlORVJT
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgIDEgKw0KPj4gICBkcml2ZXJz
L3ZpcnQvbml0cm9fZW5jbGF2ZXMvS2NvbmZpZyAgICAgICAgICAgfCAgIDE5ICsNCj4+ICAgZHJp
dmVycy92aXJ0L25pdHJvX2VuY2xhdmVzL25lX21pc2NfZGV2LmMgICAgIHwgNDgzMiArKysrKysr
KysrKysrKystLQ0KPj4gICBkcml2ZXJzL3ZpcnQvbml0cm9fZW5jbGF2ZXMvbmVfbWlzY19kZXYu
aCAgICAgfCAgMjA2ICstDQo+PiAgIGRyaXZlcnMvdmlydC9uaXRyb19lbmNsYXZlcy9uZV9wY2lf
ZGV2LmMgICAgICB8IDE1NjggKysrKystDQo+PiAgIGRyaXZlcnMvdmlydC9uaXRyb19lbmNsYXZl
cy9uZV9wY2lfZGV2LmggICAgICB8ICA1OTkgKy0NCj4+ICAgaW5jbHVkZS9saW51eC9kbWEtbWFw
LW9wcy5oICAgICAgICAgICAgICAgICAgIHwgICAgNyArDQo+PiAgIGluY2x1ZGUvdWFwaS9saW51
eC9uaXRyb19lbmNsYXZlcy5oICAgICAgICAgICB8IDExODIgKysrLQ0KPj4gICBrZXJuZWwvZG1h
L2NvbnRpZ3VvdXMuYyAgICAgICAgICAgICAgICAgICAgICAgfCAgIDM2ICsNCj4+ICAgc2FtcGxl
cy9uaXRyb19lbmNsYXZlcy9uZV9pb2N0bF9zYW1wbGUuYyAgICAgIHwgICAxMCArLQ0KPj4gICAx
MiBmaWxlcyBjaGFuZ2VkLCA4MjgyIGluc2VydGlvbnMoKyksIDY2NiBkZWxldGlvbnMoLSkNCj4+
ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vQUJJL3Rlc3Rpbmcvc3lzZnMtZGV2
aWNlcy12aXJ0dWFsLW1pc2Mtbml0cm9fZW5jbGF2ZXMNCj4+DQo+Pg0KPj4gYmFzZS1jb21taXQ6
IDY2MjhlN2Q0YzZiMjVjOGQxOGYxMzQ1ZTNhMjBkMjE4MjlhYWU3ZTQNCj4gVGhhdCdzIDcuNC1y
YzEsIGJ1dCBJIGNhbid0IGdldCB0aGlzIHNlcmllcyB0byBhcHBseSBjbGVhbmx5IHRvDQo+IDcu
NC1yYzEgb3IgbGludXgtbmV4dC4uLg0KPg0KPiBJTU8gaXQgd291bGQgYmUgYmV0dGVyIGlmIHRo
ZSBzZXJpZXMgYXBwbGllZCB0byBzb21ldGhpbmcNCj4gbmV3ZXIgdGhhbiA3LjQtcmMxLg0KDQoN
ClVnaCwgSSBmb3Jnb3QgdG8gbWVudGlvbiB0aGF0IHRoaXMgc2VyaWVzIGlzIGJ1aWx0IG9uIHRv
cCBvZiBhIGRyaXZlciANCmZpeHVwIHNlcmllcyB0aGF0IEkgc2VudCBlYXJsaWVyIHRvZGF5OiAN
Cmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC9jb3Zlci4xNzk0MzAwMDAwLmdpdC5ncmFmQGFt
YXpvbi5jb20vVC8jdC4gSSANCndvdWxkIGJlIG1vcmUgdGhhbiBzdXJwcmlzZWQgaWYgNy40LXJj
MSB2cyBsYXRlc3QgbWFzdGVyIGFjdHVhbGx5IG1hZGUgYSANCmRpZmZlcmVuY2UuDQoNCg0KQWxl
eA0K
