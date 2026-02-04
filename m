Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazolkn19013074.outbound.protection.outlook.com [52.103.74.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453A12D8771
	for <iommu@lists.linux.dev>; Wed,  4 Feb 2026 15:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.74.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770218237; cv=fail; b=hyWZTw2oAB36UH314jzIAXgNpihNLORTXqhNa0b3yB/M0jsb0D6lLP03QfrCSePHbyLLDh4av+0fBj79Zftc6n5+96vAvR4G1KeEymw9YavCrQdNGRcETv+uOoIIW1ZukEtVnuWJ6X6nfh0mJGHql7ZHBeb3uMPuFYbWh+dmrbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770218237; c=relaxed/simple;
	bh=JobukY723ouN/zKSnH/2wz3SIseTLCTQRlgFOKyrnnM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=c7+oEDvREE456ADVLYfA49UTA2soiv6kjwODQuvdZlEVolXdPymgaIE/aVmOJkiUNTh+osuvbj5SFFBQ2PFP4vIKO/Z2hg8qvIpn4vO1pGU2o1j2VrLlWl2IuAcr6xhEoQeoAOqqEffQ6Q2a6uBi5e19tsvJqTWXGOX/W1DsNg4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=YayZP95S; arc=fail smtp.client-ip=52.103.74.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="YayZP95S"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZHFGEUihPpnu/OiO93qbAOQm50YO7eAGx4mUF1rSUp601pBb11B1KCdqwsIItlFTdAYFOyXRTRodxwqCcDlns0pUxUddzJ5Q7OuLQN+ko6xaf3vP7xfE0Y2JRQRka+SakfNOB9/qRK97Nc37dZi9HIIZ1gi7drtBozcFTIhskeFuvs2v2X5xSym1X/MjAE+1oqgKPSc5W+7zAZSh9S8tysd3Wp6hE+2zG43UM7uV8l0s+kaz5dHLYJiiD43d2Lfxh3PPZxghvgFLJWIWplogAb+9ivprkuBMwmoVVZSe5t+s8EqksHnE6Ql21f709+W0XyN3WN/H1QBUVMZAtsp/Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MdFRxRIBxBJhTuC5usbw+uIa6paWWPZTfKVoGxe+ujE=;
 b=DYnJGaDKkw0XCXr++yY3MnmqmVslvbakTDyoVHLHqhKXd9859B1p+jho7ACzN5rYbBiMB2CDgxWk8vGriLVr2DY8RDmmdgAyKkpPRduOCeP9cMTBaba2u1zRZFUVAl8HRFbMxM+iW8pkw8QOSgAfVGDiBL+Zp/5u2N7LuAe8pDHaQlld9PqBGVhELlTCkfYPcKUa+s10Oy5IQXj7mWc0HmDSRljYoKtXvyCm69R6q4P3Jw+rsY6xTzn9U7vEF6VsoRJRncjJ3FNPBqxG0A9VC/KzUyMr+B4Lqly/tut5E3x/c83g4VXK4SYNl5wQ89EdJytH+qRdqdpWgRWncLfnEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MdFRxRIBxBJhTuC5usbw+uIa6paWWPZTfKVoGxe+ujE=;
 b=YayZP95SzEnCOh1lyPeRBvEvwes13ncs8WwHd1msYw3pdgqH9FhBbZu31hIdGrf3jNw5lX3uz36b2uRaLpgEJgLuSOH63dgO6FBzhDmxwuwq+ChFICE4SA/ioZpZzYQcTBcV4ILZkIanhRmskttknjFCaKUcwthATIoJhmrfsAg2yx6bwEZZssV4gkzSh7GGtkNY64F/cnT5D99MDjfJos8MAVoFsrtbJoAjOwugV8ygfIVKuYC/v9NWU9Mu7mi4Uo3HeejcIMjQ0ieXlAee+SVe8e1Oqw03by38yFt72AlGudLW6QSAWylbClrB8qVsdeB6GpOrhJGdNKeLH54V3g==
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7) by TYZPR01MB5352.apcprd01.prod.exchangelabs.com
 (2603:1096:400:33a::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Wed, 4 Feb
 2026 15:17:12 +0000
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c]) by SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c%4]) with mapi id 15.20.9564.016; Wed, 4 Feb 2026
 15:17:12 +0000
Message-ID:
 <SI2PR01MB43930D9F3195452DD6BC4C69DC98A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Date: Wed, 4 Feb 2026 23:16:23 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] vfio/type1: Set IOMMU_MMIO in dma->prot for
 MMIO-backed addresses
To: jgg@nvidia.com, kevin.tian@intel.com, alex@shazbot.org, joro@8bytes.org,
 thomas.lendacky@amd.com, vasant.hegde@amd.com,
 suravee.suthikulpanit@amd.com, aik@amd.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <SI2PR01MB4393C9B731ABDA050A336166DC88A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <SI2PR01MB4393E7518DD5EB5839AD136DDC88A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Content-Language: en-US
From: Wei Wang <wei.w.wang@hotmail.com>
In-Reply-To: <SI2PR01MB4393E7518DD5EB5839AD136DDC88A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TY4P286CA0135.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:37f::18) To SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7)
X-Microsoft-Original-Message-ID:
 <2f6c5bb8-015e-449b-89cc-70993a2a54ac@hotmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR01MB4393:EE_|TYZPR01MB5352:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b3e2ccb-7b73-464c-61d5-08de6400789b
X-MS-Exchange-SLBlob-MailProps:
	suo+AMQROd7KWLzCSB/8AXewUiiF+4xJTEp92lagfCazz65i3PwK9c8AiEetquOINXguw3f54+peS9lxTHzg1Lu4ePbBtfBWwUAp/qAl1Pw+Kmf0dbfaLlcNo7lptsEDSkP5dGBKOoV9hLWR62cy5X9kBn5cTwBQrB8cQcn9XmydCnsMuPz6CXRWeLZyuPKHdzxQVmZnkJPIWS0gexZxQ4Wd/JBxZPBf478d3Km3abLUbINgaX1EQJ1bxK2JWEWWJamqeKxuPGfaHKbu45Kbx3I1vWtndmYzHg+Bu3lhX4dyTR1pLA6JODySnhUrl6P57RBI0BtyqqhyszD4Y8JZencuCYw4JMDia7nV5KHTwfnbkANnW8o9hJvYYGSqb85o9cb3HW7U6SNNXEa8JFrevw9TKGxSZ+VBt/0uTQtVsYN9xZZGzmCUTXG96EV6KbTuM0dtjrSeBzR0HxinZe14lwsb+sED4gPw9iE2WR1BsR62qIxPCBCetYJsMw4gUX5kBpY0uULLgxYQ/KP+nS3JyQk/vWKfufkmSsjVlECYQrFp8cholWIweGVfzrEO1tcL+faaKPC9E/0VgMX6P3YFmtBjNRuS++9/1/hBNroOINgEGxa456Ay8GWi78eV2LJoOHlWjjT2SbHHUhkMl7Y4GovT6EQARK0ZCDPtvacm/oaUb7wqBdLVMnA22c9XXaGHfjg4SQC6HmfJLTE6JtUp23KtFzhBr1zmR/TfQW2zMm3sQNuKoxudb6cfCg+hO+X8C2cuY5f1xtJL5m5YGiUcfKYIUiKLJ2la6iQbxnSnHn6ZialdDyJQIixfTqnmzzhITH0HFLpXmx2Lqk7ddJU+OQ==
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799012|51005399006|37102599003|8060799015|6090799003|23021999003|41001999006|5072599009|15080799012|461199028|1602099012|13041999003|440099028|4302099013|3412199025|10035399007|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NmZENVZtR2RYM1EvUVBPa2RPa2FOQ1Q2WVY0Yko2SmUwUXVBWGg1alduWVhF?=
 =?utf-8?B?V3JPRENsZ1lQcytKeTl1MDdVaXB4UThzUE9Vbktla05oZmIzUjliTGdKNWdY?=
 =?utf-8?B?MUZFT25IQzBRb3QyVUt4U2pRRTVGZE4vZjBmVTRCODdZa2owM3VlZW5hZzd0?=
 =?utf-8?B?azlIY0RvK3UxNXhYN1hsZUtsYVE5VEV2dnQ5SGZERHdVZm5pci8zWlczOUhU?=
 =?utf-8?B?c2dsUzVma1Q3SkJDRm4vZ2FoUE53cnh2S25aUEwvOEtOd1R5N0FjSHA5K3p5?=
 =?utf-8?B?UGxveDVEUittUzF4ZTVVcWlsbTUxZDBFaVJIcEJ2N1NPOUpWbVAybk9vRUh1?=
 =?utf-8?B?WjVQamsveU9iS1FacUovVndDVUxVV2tiL0VqVmdmb2dIVXJYR2J0Wm9KRURn?=
 =?utf-8?B?cHZ2YXpNSHhLTUlBam5mbzkwSUhiNUpJQzV5bXg1R0ZEMnZ5RXFpK3JrMHR2?=
 =?utf-8?B?WHpidldBYmFGQ0F2UlJ1anZqN3ZvNm9aYlV0YldWbmpMdUcrakJCYSt5UDV0?=
 =?utf-8?B?aitQNzc4T3pNbmpFQzNSSTVDSVN5U3JxZGNYSkIxU3ArbFBjanIxQWdxME5a?=
 =?utf-8?B?QXNUaEkxQzlKYitJUW5SNm5leE1CV3NkTGdKSDNSQnNwa3pOcUNNTjgzaDBD?=
 =?utf-8?B?Y1RVQ1ZQeW95eFB4dkc5bEg1L2ZzODBYdXhqakVoVFFTZG5hQXBBaThHM0JN?=
 =?utf-8?B?VzF5T3M0bjU0M2grUlNZVlBTbkVzWnRmK0pFUFlBTHZud2tDeU5FTFFVaVFj?=
 =?utf-8?B?M2Q4ZzlYR3BpZUxOeHRoZUF3Ni9FTzByZUNzYjJHQThoWDFLSjZDRldYUXo4?=
 =?utf-8?B?b2x1NHV6VXR3Yy8xS2x4WnIvd1ErQVdkYXJVY3NiUUc4V0VvTG5GTlFOaWEr?=
 =?utf-8?B?WDViNkM1REF0Q0lLYkVDVTJML0J5SnR6cEJSTWZ2Z05oY3kzWW5WTjBMZnZ2?=
 =?utf-8?B?OFUyQVVTZVlvSFpBbzZrelJhM2hQYnlMSGhCd1h0NytYREVBT2E3ck1JS2Fq?=
 =?utf-8?B?L3ZlMjFFbWlFRnoxQ2h4NWVGeHhmS1Y5bWJrMHFRajVpb21IeUw2TDBRZjlG?=
 =?utf-8?B?YmlDNnlHanJnYkZ5L2pKQXltcHJlVlFpeGNhejBCR2FBVm5MZjUwSVJ5TzdD?=
 =?utf-8?B?MEppL2lrbmJqZ29NUWpBQVZQVkZkZHlydEhXQk9tZE9pZWVuZjBUeExQb1lr?=
 =?utf-8?B?dXoydzNRZ1JHZTRBNWtFbjRTR1JmaE4xMFhLakdvaVo5QlM2VHVJeHk0MnhY?=
 =?utf-8?B?bk1Pa2x1NEtnd3dydER6enVUdXZHaERpZDBEamZyRHZjaThpclE0dzkwOEcz?=
 =?utf-8?B?YWFJTXljVCtocTZ5T1FlbW1pNnhmc08wbGc4Z05wVEkzakYyTGU2ZFArQjBO?=
 =?utf-8?B?VEQxaklMZERUVWNsc2ROeHl3ZjFhdEwxSE1DWmo4R1pka1hFUTJQUldKYlBs?=
 =?utf-8?B?OFRGTTh3QmNKbHMwQVl6THRBcWVlb29FSkU3T0M5ZWVFbkxjdXFMSHVCYmN3?=
 =?utf-8?B?bG1CNG1CdHBHRGxmYlZNbGJSNG1ubU1HV1lYRmFrYXdhM05TTTdpWlcyZHln?=
 =?utf-8?B?dkdVem5tNUh0TXlEZkQ3Zm9OVStmUGhPaU1IQkJyQUY4NHBJbUtRYS9veVVP?=
 =?utf-8?B?QTdTemsrTGhZc29jUldZMS91VjgzWW9SSjZTUXVXM01IWEw1LzRRSmdnWEFl?=
 =?utf-8?B?YkVLbXJQV2pvTExRTGlZdm42eHFTQnJCbkdhMHNhbzJRSkE5d3Y0WjRqTnBh?=
 =?utf-8?B?ak9DWWZLV2JWWGR2dXpQcndYSFcrbHV0T0JPMGMvaWRwTTUyZDVMOXQydmVt?=
 =?utf-8?B?QmpZYTQyMDE1TVF0dm5Sc1VHdVZ6UmtRZkJ5TitrRERYOHhHelByWHBIMFNZ?=
 =?utf-8?B?Tm52TTJPUGYxck4zUmp1WnloYjNzZWF6ZVVBVWNZeTVwaWR6UElZeTBRZlpu?=
 =?utf-8?Q?jLcLunrRKwW22UxaZf2JSmg34/+ddENr?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MHdPME5XZU9qRE9vVW9Pd0QyY0pTMUNaOGhWMHVkL05RbThwUnF4RS85aURJ?=
 =?utf-8?B?cWRzTjZ6UUJueDBZNDFqU0QrMnFRN0Fkb1gxb05Rc0JUZWt0RitIYjc5Ynpp?=
 =?utf-8?B?ZlN1eGdjdE9QdkZndFhnZmowaTR0UjIzR0NIZlR1TTBLUVpQWnlaWGtmYjFC?=
 =?utf-8?B?emVhTWJCUzYzRjZqOEw4SmM1cWg5NWtGbExzWEJyTHIvTGZzL2wrY2lmSzFX?=
 =?utf-8?B?WUpEMGE0SEx1REYrTkFKdEFVQ1NEWFFpN3Y0TWdyamhyNkEwMVdrTlo4NE41?=
 =?utf-8?B?d0wxNVdObGZ2T2ZPK3NhNGMwczFLb3lqZ2ozTW94NWk2TGxNQmFPcVVkbUdV?=
 =?utf-8?B?RWE3SVdVelI5ZmJHcDhyR2V4S0VUQ1RnWkhRWnd5TXh0LzYzNHhnQzgzTlRn?=
 =?utf-8?B?cW5WM0tXck11VSsydEFRZHMvSmtnM3k2RU9FVEN3V21USTNUc3ZlYlZwemI3?=
 =?utf-8?B?NHVJN0VBbXc5WEs3blZrLzRsVE9nVW1oRmpGWmZ2SkdRTzV0QUViZlYxNFZq?=
 =?utf-8?B?bVlIalpmVEJ2ME9LRWp3alRGR3V4dlQxNmhhZ2JBcXZFVU5KcFpMK0VUWmxU?=
 =?utf-8?B?eDk4RUlzUVBrSGd5ek9HZ25PWFlqa3RWeUFPVGp5dDgxem8yem9UU3BERkVG?=
 =?utf-8?B?ai9oRFJJM3NIbEw2dW15clVNSDdQRlJMTUJtVmtBQjV2TllBMmgyOVpCMDhh?=
 =?utf-8?B?SFYxUjd0eWdld0ZOYnY3enQzZGVNOWJ4WlQ2NTlDbVNGbWJ5MlVDVDVJVkt1?=
 =?utf-8?B?UDc3L3RTL29mZ1ozd0dtZFhISHBGK2dDRVhlYk9TSElGQ0swbkgxTHVNdGlB?=
 =?utf-8?B?RWkyVUpiT2NLYnpSM2ZqS2lTbU9kRkdoeDZzM1hrZ1E0eHVXYXYzUXZ2ZmxW?=
 =?utf-8?B?S08rcGxuTFpaS1Z6TEV3cVVHMkFGOWlGNitFZHpWdVYrWjljVlVDRi9EZ1M0?=
 =?utf-8?B?eXRwVjlocGlJUGlOZ0x5SWZYbS9yLzE4MU9BWUZVa041MmdPTENkQk5KZEM2?=
 =?utf-8?B?cVEvYVFMTEpDZmJ0dUlmOHN0QXB5RnBRNFk3aFE2QzdvN1JJSzBUOEw4NU54?=
 =?utf-8?B?amwwZlVpdHhSZmdjQ1oxeTloY3h1TTZLdjlFcmxlaGJyVHF3aHJUbG1mNjMx?=
 =?utf-8?B?cWFkcHR4K3RCV3JoYWxEQW9lNkJEdTBaOEVvTWsvZjVGVTBPZkljaEZXOThJ?=
 =?utf-8?B?Z2JqZ1Q2WWlvRzRKQ2lpSmFhcFFCNmF3b0RUcGpDWU5MRkYyNTNCYWk5NTRT?=
 =?utf-8?B?QTNrK1IxL2JsNmVndnRBNFVHVGRJYXkyNXZiY25TbiszWmg3QktSOGl6M1FO?=
 =?utf-8?B?ZStna0FFUU0rc202d0YyLzI0T1NXSUhGeUs4ZGE2T043UmNtRFhXbzZwYkRs?=
 =?utf-8?B?TGw1alpYR2dYTzR5anFlQWEvdFkzc3ZGU0V1dU1NcDBiTUNabmhrMFVydEUr?=
 =?utf-8?B?VkpYKzFIUmxqMDkrUHJHWlg2a3lFWkI2T1JvSFdNb1h1Vzc2VDdwSjVjazlk?=
 =?utf-8?B?NXEyQ0dYM0tHSVVTQVF2NmwrM0U1dTJYYWJjQzdKNCs0ZUFDS2c3QjZEaE9l?=
 =?utf-8?B?WklkeE96K09DK1kzZmROSGpjSnRaZDVVY0lRUkltYis5UGtCSEpTYVV5ODRq?=
 =?utf-8?B?akVqZlQ3UGw5UnBKSHlCMHZHUUtZMkVkQUxSVHp1YkZVSzNoYktxT2RhL001?=
 =?utf-8?B?eXNWOFFBRWM0cjlLVzFxSzYvUEkvV2k1MXEvZzFGZElCYmd0SGNJVnZnRUdM?=
 =?utf-8?B?d2RZeHA1dEJrQlV0SE15RVo5TG5GVFZwbWlacVR2YWxmWXFYUzYzaTN1OUdB?=
 =?utf-8?B?OVBkbFZnQkIyUjJhWGxLaUE4eVJJRURVMmEwOXgydEpLbjZzK0pMQkZMT0tZ?=
 =?utf-8?Q?xeuutxgHsHU3C?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-5f51e.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b3e2ccb-7b73-464c-61d5-08de6400789b
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB4393.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 15:17:12.7542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR01MB5352

On 1/26/26 3:19 AM, Wei Wang wrote:
> Before requesting the IOMMU driver to map an IOVA to a physical address,
> set the IOMMU_MMIO flag in dma->prot when the physical address corresponds
> to MMIO. This allows the IOMMU driver to handle MMIO mappings specially.
> For example, on AMD CPUs with SME enabled, the IOMMU driver avoids setting
> the C-bit if iommu_map() is called with IOMMU_MMIO set in prot. This
> prevents issues with PCIe P2P communication when IOVA is used.
> 
> Signed-off-by: Wei Wang <wei.w.wang@hotmail.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> ---
>   drivers/vfio/vfio_iommu_type1.c | 15 ++++++++++-----
>   1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index 5167bec14e36..9fbd2ba519ca 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -583,7 +583,7 @@ static int follow_fault_pfn(struct vm_area_struct *vma, struct mm_struct *mm,
>    * returned initial pfn are provided; subsequent pfns are contiguous.
>    */
>   static long vaddr_get_pfns(struct mm_struct *mm, unsigned long vaddr,
> -			   unsigned long npages, int prot, unsigned long *pfn,
> +			   unsigned long npages, int *prot, unsigned long *pfn,
>   			   struct vfio_batch *batch)
>   {
>   	unsigned long pin_pages = min_t(unsigned long, npages, batch->capacity);
> @@ -591,7 +591,7 @@ static long vaddr_get_pfns(struct mm_struct *mm, unsigned long vaddr,
>   	unsigned int flags = 0;
>   	long ret;
>   
> -	if (prot & IOMMU_WRITE)
> +	if (*prot & IOMMU_WRITE)
>   		flags |= FOLL_WRITE;
>   
>   	mmap_read_lock(mm);
> @@ -615,7 +615,7 @@ static long vaddr_get_pfns(struct mm_struct *mm, unsigned long vaddr,
>   		unsigned long addr_mask;
>   
>   		ret = follow_fault_pfn(vma, mm, vaddr, pfn, &addr_mask,
> -				       prot & IOMMU_WRITE);
> +				       *prot & IOMMU_WRITE);
>   		if (ret == -EAGAIN)
>   			goto retry;
>   
> @@ -623,6 +623,9 @@ static long vaddr_get_pfns(struct mm_struct *mm, unsigned long vaddr,
>   			if (is_invalid_reserved_pfn(*pfn)) {
>   				unsigned long epfn;
>   
> +				if (vma->vm_flags & VM_IO)
> +					*prot |= IOMMU_MMIO;
> +
>   				epfn = (*pfn | (~addr_mask >> PAGE_SHIFT)) + 1;
>   				ret = min_t(long, npages, epfn - *pfn);
>   			} else {
> @@ -709,7 +712,7 @@ static long vfio_pin_pages_remote(struct vfio_dma *dma, unsigned long vaddr,
>   			cond_resched();
>   
>   			/* Empty batch, so refill it. */
> -			ret = vaddr_get_pfns(mm, vaddr, npage, dma->prot,
> +			ret = vaddr_get_pfns(mm, vaddr, npage, &dma->prot,
>   					     &pfn, batch);
>   			if (ret < 0)
>   				goto unpin_out;
> @@ -792,6 +795,8 @@ static long vfio_pin_pages_remote(struct vfio_dma *dma, unsigned long vaddr,
>   
>   out:
>   	dma->has_rsvd |= rsvd;
> +	if (!rsvd)
> +		dma->prot &= ~IOMMU_MMIO;
>   	ret = vfio_lock_acct(dma, lock_acct, false);
>   
>   unpin_out:
> @@ -850,7 +855,7 @@ static int vfio_pin_page_external(struct vfio_dma *dma, unsigned long vaddr,
>   
>   	vfio_batch_init_single(&batch);
>   
> -	ret = vaddr_get_pfns(mm, vaddr, 1, dma->prot, pfn_base, &batch);
> +	ret = vaddr_get_pfns(mm, vaddr, 1, &dma->prot, pfn_base, &batch);
>   	if (ret != 1)
>   		goto out;
>   

Hi Alexey,

Just checking in — do you have any further comments on this patch?

For reference, the previous discussion is here:
https://lore.kernel.org/lkml/SI2PR01MB439311868FBFB7DDAD19692CDCB4A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com/
