Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.14.66
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792773141;
	b=y3JpxkQemlr2gbiqC4PocjUnbtEs9i7EDZMofzcZO5boYBzTXQp9OX76tk4kC0p7APG0
	 kr51vxNB28K7CvqdKI91/Oxt4WawqJ+wKaWz/BlGMhLzCp1If5kq0sOePJboYVsp4bGZG
	 71yX64HktWo75UeVfGraem61HkzsMu/IBpjRAIUc4el1zoAURJbY1bErDa0h82xSuZg5p
	 cXwh6tHmlEfO0HYcNB8nc5Jc2gzFFJOsulGElgfAgjFqRAiuIKD8i5Zd87j5TB2MA3qxi
	 N9fR/vNVvUVeiHju2bcsDKB4M6VHiCNikt2rzJJabYDwxbj1q2z+r6InAQ9ec7OQnCw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792773141;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 msip_labels:x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-slblob-mailprops:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:
	 X-MS-Exchange-CrossTenant-rms-persistedconsumerorg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=yNR58pQ1Ye1t1Ka/Y/pcsX3AeXfMySlaeDo0NGARvfc=;
	b=WsN8c0mFjzRw9UHBB52yZgHXhTzccBjKLPU1VwK98OVgTkjXXKW+X/loiRqpxDNnVvnV
	 ILl24oDAQvOqDDs0rcWIT+NjfBVYRakevfkHidvZaO3qqH9WMFOS0Enl1MErcO14HYaqi
	 n4SGBeEZXsc4gIbTupgVzmNO8bmJX7pDpG963VOl1d2mFf6x48RJPYLkb6jtogki2XEte
	 DkH0rP8WCNjBXSchERk1sqGwDzXUdFg1CO/FiWmPYGX9HefCMsPEgd6l+ITHHtHEo7xfd
	 zgNM2iGoJyayVyKG3+lKavNA7VKQoFKcG22wilrA0/DpuK/W7Vr82wDZgWsNMkdzXjg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=HXdYpwuk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.14.66
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazolkn19012066.outbound.protection.outlook.com [52.103.14.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37755606A31D
	for <iommu@lists.linux.dev>; Fri, 23 Oct 2026 16:32:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37755606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=HXdYpwuk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R+oiNW1Zg8sayrISWasBlQALONdkqqZcgiKfNepIzzotZQWFOAkQlCQMK9AlZDkH5T9u/oTzPYz/DlOJ/0nkn1f6HHTqr0SvfVijShGKXNelAO3aJCF3GftG4Ndp5t5naGGdT00O7vyzonWcjKxDDDkOANnpDhoFVP+TVV3+01joz5DE2M0i21ajKqc+tszUWhQ1YlyD/f1KoMNrTfLI4sQ59rnULJ3wEt2z9xQq2CsRLkLiywlSo6+fIKrhdK4WJkPCfZNYjpIy/+KBFLygjjFIo53BS71lNAMTDNADjTh1aSal5WXFNld3iNqubeVWfuWke2H5Pg1RfuWkYLXbaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yNR58pQ1Ye1t1Ka/Y/pcsX3AeXfMySlaeDo0NGARvfc=;
 b=XT47HhnhkeizKxIcyM5GolhhXY+sTDoxsFk7MWMI+nJtCj4uUZC6A7iSrD+c5T1QQBqKQUC+iYGcIZclM7ltM2k6zGBwtAUoBMrRbMJ48foh1Jc5IHI5UmcUILalIIdm8eMZivdtwnYSl1AQCTl1+Us1n9SD86s2vyOstROqV1Lr4PW6LH6ijrRUhUoYW4mGhAJfzDO8m0It29ISeO3g2cvKSwk2Px3qDFv77yMrqa3Rk9BK2OVw3R3voz3vVPtuSVhxgb9EsDJZUPcRvoCWQgMLYmiP/lHBsQNTVyXyEAzn/a7cSi6Nuqv7KY7Abdz6bHpNmWzWDir3qSQ7T1PjoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yNR58pQ1Ye1t1Ka/Y/pcsX3AeXfMySlaeDo0NGARvfc=;
 b=HXdYpwukWPg68/MJ0YVKSV0RqePu6jOwJLm5kkvCSEZLSYZFbsBUZY98cQD/obpqL2xrr8FNzWEoytWHpwTEsmx8xXiGlXXU8VkGa9elMDxRHXfRfp3NGl5G0x1M2Gw49BddA7eh2PoB+Hdlq4rgaQb4nZ/fLR2GgPP6rDNKZ7t1MTo4xIONnZkSdtK6NA9z8xD7IWy0lrgsyCaFJlBHU617jHTk1qs0ZFFbQ5K1QABqsDfZCTLRlxS/lDces2RtNk11D6mHbNyF1cR7Zf3sOZYlEal/tZ3+vnN2+nwkkeJSYxNozJoEsK1IEzyyystSjGiSgFKiPKoKVqj4GeBLKQ==
Received: from RO2P152MB5105.LAMP152.PROD.OUTLOOK.COM (2603:10d6:10:ba::14) by
 RO2P152MB4730.LAMP152.PROD.OUTLOOK.COM (2603:10d6:10:59::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.19; Fri, 23 Oct 2026 16:32:15 +0000
Received: from RO2P152MB5105.LAMP152.PROD.OUTLOOK.COM
 ([fe80::f919:4e42:f4eb:ecc4]) by RO2P152MB5105.LAMP152.PROD.OUTLOOK.COM
 ([fe80::f919:4e42:f4eb:ecc4%5]) with mapi id 15.21.0546.017; Fri, 23 Oct 2026
 16:32:15 +0000
From: =?iso-8859-1?Q?C=E9sar_Zapata?= <el_caesar@outlook.com>
To: Vasant Hegde <vasant.hegde@amd.com>, "joro@8bytes.org" <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
CC: "will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [BUG][AMD IOMMU][VFIO] IVMD exclusion ranges block GPU
 passthrough on ASUS GA403UI, reproduced on 7.4-rc0
Thread-Topic: [BUG][AMD IOMMU][VFIO] IVMD exclusion ranges block GPU
 passthrough on ASUS GA403UI, reproduced on 7.4-rc0
Thread-Index: AQHdYkwdalKASy9EAkqg+eUxSukTOLcKqPYAgACqVjk=
Date: Fri, 23 Oct 2026 16:32:15 +0000
Message-ID:
 <RO2P152MB51056EC002C437DD24FBCAAF8D642@RO2P152MB5105.LAMP152.PROD.OUTLOOK.COM>
References:
 <RO2P152MB51059B868259A82B182943F48D652@RO2P152MB5105.LAMP152.PROD.OUTLOOK.COM>
 <b7d3a4f4-0ab2-45e9-b9b0-8ea9dc0b2b3e@amd.com>
In-Reply-To: <b7d3a4f4-0ab2-45e9-b9b0-8ea9dc0b2b3e@amd.com>
Accept-Language: es-ES, en-US
Content-Language: es-ES
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: RO2P152MB5105:EE_|RO2P152MB4730:EE_
x-ms-office365-filtering-correlation-id: 16b904f8-a8a6-4539-9e91-08df312332c5
x-ms-exchange-slblob-mailprops:
 ZpxNddEKiWzD4Xng0iSn3Bd/seARp6gsZ1iHRx6PUuUXK94r+Dk/qaqxYl36qUlRZ1zRupYLk121Wta6ObDghmjBqpd9Cw80z4offGlCV0Y3wMGV3nh61rmFBRHEBSvH6e0gLQ0yEfOKhxRA4mjEwfCMgfIiw9HZMU6+UuGBzfZEvkCleaf+f6MewsTMoHHOMTmw/ZESzXtRJhSEkfLZqHqMISPRb3b602lN0yOJ8dv1Br1Gn+07sHn+do5hmuZtNa6JJBspqfG+x0mc8lRpjwT+Rv5zZPMyYjEzpQrBGFhBzJzNE6y2YU8i9+DUsZUh4h/lRgYOh4B6bFbwH2bpqXTpFrcn06AudYAOkCbWgueoNE8H90sW4DVSq55LDp4P5pETZOXFB7nAh6bomu3Hm7kT+WAl3gFSDzf1+Tr6pnmAc/BD98I0SupQPGFRejulrXM34UpaJVWZB2gAxMBtmY5WJOsRWYMUojLFYMEfyya1tg7HqN8+mzm4ldL3pbVBEQeIuxW45tTMCmzrbOnjcssQrcZ4YR1APl/BKaI+2V6hFyG24hCA+DPK1bIJHJOA18e4xqZg61q+3qkumkZ21kr5g/szvHuP05h2cSrPAGb0TVjnI3VOdPb/a1IYW984jdF/FHEJ8mQHje/mPhdTcMc9Ci9zH4x/xKIbRzAf+2hk0nc9DygNZlA0FW2KW2hMtdB4wrjdszLORU49hjbi8q4NgrCUc5/s0HRUPbwS754mVBeK5M7CtbMZa+kilKTVUGFhchvk7474gAXu70aK7zQaairWP96GeJubTwt8AGvrk4sObzRCI7MPA/1xhgCazP1UVErgj5iAl25D6NHfPg==
x-microsoft-antispam:
 BCL:0;ARA:14566002|15030799006|24121999003|22091999003|15080799012|6140399003|24021099003|19110799012|8060799015|51005399006|8062599012|31061999003|40105399003|1602099012|10035399007|26121999007|3430499035|102099032|19061999003|440099028|3412199025|4302099013;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?zeV1uzDI+AP5E7bydXc/o8rP/8wgE+uxswioIrbXCrD6wxLfoeSUHpf4zP?=
 =?iso-8859-1?Q?L2ezovYibpYN69eIkEoWf98eBn1Ray2fap2ZxvBmszygZNFpcUmkn9tHTI?=
 =?iso-8859-1?Q?dmUmu1lA5HG5+1Qs00T0dSWuGM15d72PBql+YlI3Y/po3+JtbkcjGpj7T7?=
 =?iso-8859-1?Q?jFwyeOkSXELl41YDLpi5kKOXBG8xUzWxK5UsAVwRaj2oLyamdzYAfgjbef?=
 =?iso-8859-1?Q?oCcHZcC45qL3Nsaz4OqLeqfdpRfQRbU/hYbmPD+jNSDUqQUSnC9/1tNJdZ?=
 =?iso-8859-1?Q?EIHAHPFYOl2gssvwQoVekfUfCT/L3LFyxdRTTseK54pIaYMrrHj2orcJD9?=
 =?iso-8859-1?Q?bpnZA0PFDCPs1F4/rGBllm/FBvjWrbjefuU3r9rGiDpF2eTGI3JNiCvA4O?=
 =?iso-8859-1?Q?4gf6SG6ph21T5bj/U/fcwc/LCtPgz/l+n7NLEdPHE9z9hQl1CmfoJm+5xj?=
 =?iso-8859-1?Q?X916HV8SoPKdjNyerQg1yVayDbRSdlzIdEsGWy8SU/Sh9eZzbGNpgYDWjI?=
 =?iso-8859-1?Q?zp3StlaRpYxXZpnQ2ljQKkSY44MGKGdaRrl57dY8CeZo6DAVjqREsDQOCx?=
 =?iso-8859-1?Q?oSNx/RTma87EIAF75D3KTciKS7TZYlK1zXlm7LaMKxgVm39amPafIkJxKX?=
 =?iso-8859-1?Q?6i0sRy1PBNvT0B0TKrjP6p/cmimyt6amGBR5cuIeoU8MfP4pjwUiElFUa2?=
 =?iso-8859-1?Q?MoAA8Je9TUvIQwTMnwDo5PR0jK+iUKh163BR4A6/4Owl3sTDHA8gOMhywg?=
 =?iso-8859-1?Q?UWLz6XqcPMUS68QovMWITe6Tsq8NtdmW4esDVhGb3/28hzUExeNHz+2+eJ?=
 =?iso-8859-1?Q?8Ou73DcLPn497FR365MLB2O9o8guMu2GbmLCCV+/CVlt39lX+342hUWThO?=
 =?iso-8859-1?Q?P83oL9T5VEsciFmUQySExpbpAxXkgeU7f+bV8iBHW4RwoDfAoG7+Rh1Gc+?=
 =?iso-8859-1?Q?mm7tw51A3nLV7rz+Rx7z3DWUAyiJXP3UXwwiyy9RmaeJc04854d6g3+yR7?=
 =?iso-8859-1?Q?ig6T1bmmiuz6Bl7Uz2M0PydTXqanaofnU4vxILsPRl4/e0pecYqgZtxYIi?=
 =?iso-8859-1?Q?6l7nhawX4gcV/Q3B943p8Jk5lkYsv9LQnWwxFF2CKgXlY2RHinmlFA9KuZ?=
 =?iso-8859-1?Q?qd5TrqgfRI2W9yjEsXdT0D3FazFHV9Mp0WNNWp5TthWEz7iU9e6Klx8vNd?=
 =?iso-8859-1?Q?kGS+cZZXhNlZRQ=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?qAP4kTYxMkaZs20SG85XncQ5EQPeMcfjiJd5bCfQtomtxEjmQvLMQ6fenO?=
 =?iso-8859-1?Q?eZlOyOnGborqc4i/InpNPl+/WC+8zTWJjymr8OxveVEbKVt372iHIdOEte?=
 =?iso-8859-1?Q?vZDPfsr6VW2J3OrHd/rlstguqa+iE/hjjSjg0HGbfcm+tiGKUNLgQOzWT8?=
 =?iso-8859-1?Q?5TDD3Isq/3H4IesJ7sBdCOEHcVomnMIe9dAEY23wnpaHqQIPbMO4ghofYy?=
 =?iso-8859-1?Q?22G+GUyGQGrPgMK6YDdCULlby1ldMW7r+SHxkHCjlHvRAjwB9LvIAWXMSa?=
 =?iso-8859-1?Q?6izJLBBtRIKlfEQ+OJ5vPiQ/MhqDzaQZQVoWbUqAW+uOshe4ybIWzc+Trx?=
 =?iso-8859-1?Q?oFwSDcrkc0lRgpehOq4NMEiFA0K+motdaf3Uk39i+FWgOrZWauTUM2Vhzh?=
 =?iso-8859-1?Q?oy+vFnpZm2K2nt+fM8Jux0cwzEv5CodzCIzwi2UFVsDDtbDQHt60LJHl0s?=
 =?iso-8859-1?Q?QVS4tfZYAbrDC6tnhG6eiIDJoYFheYUcQERXPmUBmpGHmKcJ1QRta3TUc1?=
 =?iso-8859-1?Q?4AWV+IZ96AWwOemt9TkX7Xbd/IszEafYimFvt0ebmvht5Km29jGBlyaJr6?=
 =?iso-8859-1?Q?BxZRNc3s1ZLSZldV2sB4l1BZPn6b6UUb/IY/Gxh0zSZc4c7NcfGCCe0vfp?=
 =?iso-8859-1?Q?BblKVtwQZ6nooTyExjzStC2iA9+x2GwjQodL++351nBF9cf64mnedrwMxI?=
 =?iso-8859-1?Q?Sq0JbSlHM5x9OP2igtK283LtTo+WY6lGcNwE7h/D40CAxXTJnsc45qhBW7?=
 =?iso-8859-1?Q?EQ6CnjUb8EkzNKCbzXjvu/2M6P+snrfl6Vj85noniaG9F3QmNz8huHwXQt?=
 =?iso-8859-1?Q?1nZPBi2GE3lCQNrlLW5ZYY/XMyM6vAuwLp4Fz57sG91OOY1yyGlf0+el3a?=
 =?iso-8859-1?Q?AEY4ySbcfMdBvtF4Cz0/c9Vf51Bi+Xkn1e2PvUVsbNGH64WP9vGjKk6wZ4?=
 =?iso-8859-1?Q?H77spkqPR+GW4DjeG+wxbSGUCUQ75BM4ZDxyuq7fqSzr0TIxos414LdnJp?=
 =?iso-8859-1?Q?mE47ZG0Wv3tk6eeF24jxUiQEGLYk0W3axjPt+TnHZ9Xs30Bz6/vnJBK9cj?=
 =?iso-8859-1?Q?SQ8qK4B3UZM9aP7LIU3kxgnrQDGY148whR2UypVD727GDwmEABlnGUo+Yh?=
 =?iso-8859-1?Q?rtWr7fDA4IvK7PqUll+z+qvUVOWI7Mhr2W603jZPcLh0D5Ux6V9ra1ISQf?=
 =?iso-8859-1?Q?j0GMG7dEr70lQjZE3c9/Z+zYXuBvcV9Df9XGloZWfT8yaDf/vCVHYXWHH6?=
 =?iso-8859-1?Q?PM0NDOOVZ2eyhMzldzcnqEtlGIzVJq32gPWHkvDVAjsLPz74fN9six+dzP?=
 =?iso-8859-1?Q?iS55o9FpJ8+m9BafKAfKOikQ7kEUoACuIPKGAdP2226E2RTjzNL7eHxh0z?=
 =?iso-8859-1?Q?28kxouTDmw0z5D8FUDyUDODTVL/FVJ4V8BaJjNlppOAtvyL7MxCtA=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: RO2P152MB5105.LAMP152.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 16b904f8-a8a6-4539-9e91-08df312332c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2026 16:32:15.4983
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: RO2P152MB4730

Hi Vasant, Suravee,=0A=
=0A=
Thank you for the response.=0A=
=0A=
I can now confirm that the AMD IVMD v2 patch series resolves the reported V=
FIO passthrough failure on my ASUS ROG Zephyrus G14 GA403UI.=0A=
=0A=
After submitting the original report, I applied all four patches from the f=
ollowing series to an unmodified Linux 7.2.8 source tree:=0A=
=0A=
[PATCH v2 0/4] iommu/amd: IVMD handling cleanup and ivmd=3D boot override=
=0A=
https://lore.kernel.org/all/20260424092213.16976-1-suravee.suthikulpanit@am=
d.com/=0A=
=0A=
Test configuration=0A=
=0A=
System: ASUS ROG Zephyrus G14 GA403UI (2024)=0A=
=0A=
CPU: AMD Ryzen 9 8945HS=0A=
=0A=
GPU: NVIDIA RTX 4070 Laptop GPU (10de:2860)=0A=
=0A=
GPU audio: NVIDIA HD Audio (10de:22bd)=0A=
=0A=
Host: Fedora 44 Workstation=0A=
=0A=
Kernel: 7.2.8-ivmdv2-test1 (Linux 7.2.8 + IVMD v2 series)=0A=
=0A=
Virtualization: QEMU/KVM with libvirt 12.0.0=0A=
=0A=
Guest: Windows 11 Pro=0A=
=0A=
NVIDIA guest driver: 566.07=0A=
=0A=
Before applying the patches=0A=
=0A=
The firmware's IVMD type 0x22 entries, with exclusion flag 0x08, produced t=
he following reserved region for NVIDIA IOMMU group 14:=0A=
=0A=
0x0000000097d36000 0x0000000097d37fff direct=0A=
=0A=
VFIO rejected GPU assignment with:=0A=
=0A=
Firmware has requested this device have a 1:1 IOMMU=0A=
mapping, rejecting configuring the device without=0A=
a 1:1 mapping.=0A=
=0A=
This failure was reproduced on the unpatched Fedora kernels and upstream ma=
inline 7.4.0-rc0 described in my original report.=0A=
=0A=
After applying the IVMD v2 series=0A=
=0A=
The affected exclusion region is represented as reserved rather than direct=
, and the previous VFIO IOMMU-domain rejection no longer occurs.=0A=
=0A=
More importantly, I verified actual GPU passthrough functionality:=0A=
=0A=
Both NVIDIA PCI functions (01:00.0 and 01:00.1) were assigned to the Window=
s 11 guest using libvirt-managed VFIO.=0A=
=0A=
Windows booted successfully and initialized the NVIDIA driver without a rep=
orted device error.=0A=
=0A=
nvidia-smi inside the guest detected the RTX 4070 Laptop GPU with driver 56=
6.07.=0A=
=0A=
The Windows desktop was displayed at 1920=D71080 through the laptop's physi=
cal NVIDIA-connected HDMI output.=0A=
=0A=
After shutting down the guest, both PCI functions returned successfully to =
their original host drivers: nouveau and snd_hda_intel.=0A=
=0A=
GPU assignment and host recovery were exercised through multiple VM start/s=
hutdown cycles without requiring a Fedora host reboot.=0A=
=0A=
I also compared the four patched source files against a fresh application o=
f the original v2 series. They match apart from an indentation-only whitesp=
ace difference in drivers/iommu/amd/iommu.c; no functional source differenc=
es were identified.=0A=
=0A=
I have not tested the newly introduced ivmd=3D boot parameter, and I have n=
ot performed extended stress or suspend/resume testing.=0A=
=0A=
Conclusion=0A=
=0A=
The v2 series fixes the original IOMMU_RESV_DIRECT blocker on this ASUS pla=
tform and, importantly, enables successful end-to-end NVIDIA GPU passthroug=
h to a Windows 11 guest.=0A=
=0A=
Thank you for working on this fix. I would be happy to test the next revisi=
on of the series, including any additional diagnostics or regression checks=
 you would find useful.=0A=
=0A=
Tested-by: C=E9sar Zapata=0A=
=0A=
Regards,=0A=
C=E9sar Zapata=0A=
=0A=
________________________________________=0A=
De: Vasant Hegde <vasant.hegde@amd.com>=0A=
Enviado: viernes, 23 de octubre de 2026 3:21=0A=
Para: C=E9sar Zapata <el_caesar@outlook.com>; joro@8bytes.org <joro@8bytes.=
org>; Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>=0A=
Cc: suravee.suthikulpanit@amd.com <suravee.suthikulpanit@amd.com>; will@ker=
nel.org <will@kernel.org>; robin.murphy@arm.com <robin.murphy@arm.com>; iom=
mu@lists.linux.dev <iommu@lists.linux.dev>; linux-kernel@vger.kernel.org <l=
inux-kernel@vger.kernel.org>=0A=
Asunto: Re: [BUG][AMD IOMMU][VFIO] IVMD exclusion ranges block GPU passthro=
ugh on ASUS GA403UI, reproduced on 7.4-rc0=0A=
=A0=0A=
Hi Cesar,=0A=
=0A=
=0A=
On 10/22/2026 11:22 PM, C=E9sar Zapata wrote:=0A=
> Algunos contactos que recibieron este mensaje no suelen recibir correos e=
lectr=F3nicos de el_caesar@outlook.com. Por qu=E9 es esto importante<https:=
//aka.ms/LearnAboutSenderIdentification>=0A=
> Hello,=0A=
> I would like to report a reproducible AMD IOMMU/VFIO issue on an ASUS ROG=
 Zephyrus G14 GA403UI, now confirmed using an upstream Linux Mainline Vanil=
la 7.4.0-rc0 kernel without the proprietary NVIDIA driver.=0A=
> The firmware publishes broad IVMD exclusion ranges that Linux exposes as =
IOMMU_RESV_DIRECT. Consequently, VFIO refuses to establish an IOMMU domain =
for an otherwise isolated NVIDIA GPU.=0A=
> System information=0A=
=0A=
Thanks for the report. I believe below mention series should fix this issue=
.=0A=
=0A=
@Suravee, Can you respin the series?=0A=
=0A=
-Vasant=0A=
