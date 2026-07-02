Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazolkn19013072.outbound.protection.outlook.com [52.103.7.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A226530C172
	for <iommu@lists.linux.dev>; Thu,  2 Jul 2026 16:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.7.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783008042; cv=fail; b=KXvgQSB/4EDvzO2Fk6wG1yDOhbjUzeLCEPTE4o54dvZ9nol2NRDz5PB+GDG2RbwT6xJDR5XN8XWiCS+6doFnk+HbRsGaJcNOTTUCwMQPMfBIxsswMro7UdttBqt8BrZF1tX2OIaavDCrXu7xvKhKQD8cJzlOtyLrP0atm7XEY9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783008042; c=relaxed/simple;
	bh=JxEOn87lsNp3A04d7tMbRWBpxcXut7lzATkyfAuiRco=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kl9tr7gXPnZcox3q04LRPfGtwN85L2RdC5F1ihObFrStkbcIeVE/DkjRaGc2Wb5W5Ux7MGbwQG8XUyU0RPN4lHE3yhk6wpBMWkp1wf5Fsn1dLN4bReqfX4vQg4Hkbd0w3HqZ43XXPZv4OtyxQnG5d1vgV9D7P0RmI8y5JEJoMsA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=nq3+2Kvr; arc=fail smtp.client-ip=52.103.7.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="nq3+2Kvr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iF6YwNRiFfYOaxWU8+mjNuvmUHcBRfcTRuPKoHSbXiGffRBKFScJWdEEUo0Dh8bjY+aTWLSkEDpT/9oCS2nMXFXSQb4ug3vBlDNaDKzqx7DaDxXPcXLjgqAxd6m2TIUloMVdfJqrx0cxoj/whMjvN1P6pAvqqsw4bAYmWA6R2URAZRwQ1Tzt6OSs/bkx4oU6n2xnNT5m8OCdq8q01BhIXR5s/fLTSwvMpMsJo4MePTEUUKeMAmzr/hKX7M6JJjsrdAbVbd/ZuIo9sgPKtFDp8qedkeLGaR6y2YlpltY/mqmkx0aEHvCbCdu2vVFUsiNY9kUw+8SIMMRi+bBLbZ+xpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p5YwvncL1BnLZPtSM2mUn6sazDhnHxxa8zPdGkn5R3Y=;
 b=sMsLDRez4ibO7vjTqX/1u0bFpgWbKDSqIf0tbybHVri8fCPV0rt7gDUDhOxx3uL7nmTykDaeU5jx9am5fM0J/tL88uda0setjNAHl0CfaMK0Rky24+YdwN0upGlOFJegUQQNTzAOehUs5CI2v9prMZAEoPpi046tq7mgTxAuIqglvJ37ALZzuMzrnRrwDPZfydm2x5g3WV833qu0qSz58cKa48J4ejq8aW3GrljhDaowuevPmmNs0K+TQTJbERmto55DxrPEQMKTMdjpEBnZprf1fBXoXENhydu7oLeEJb6XFYq1GOoKf95BeIRCm2MJXIfS615g2KqHaZLWtAGYQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p5YwvncL1BnLZPtSM2mUn6sazDhnHxxa8zPdGkn5R3Y=;
 b=nq3+2KvrLHGSw7tnkUAu6pQpYUsaSSXkfByDPNo+Mtfa4+6Sk9zrr+vBs3b0LVV1GRPBzNqOhjYsELlwdKli0Ulr9JkPLhuVllZ1InKuNyJhKnkgnwB2TXG/jz1O2iV24oBU+33wFYZQiZaGAE8VQx8RvfX/WNv5LNiwK301VFvuUV9gTRLzEGj9bKnY96un/rXOHvmOHNVMAe/F3pK8M3Q74if5LRug1bDcBgGxS7N4tiS+xHLmn5YFy/cattmmsoQGzdhijb+ItlaQjUCWLCQAOoQIpxD90VpeGncrgiOgg26IwuBAx/SiIsr67hogg1fAQ/+mk64dcpe8Pist8w==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by MW4PR02MB7300.namprd02.prod.outlook.com (2603:10b6:303:72::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 16:00:37 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 16:00:37 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: "Du, Fan" <fan.du@intel.com>, Michael Kelley <mhklinux@outlook.com>,
	"Miao, Jun" <jun.miao@intel.com>, "m.szyprowski@samsung.com"
	<m.szyprowski@samsung.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>, "chenhgs@chinatelecom.cn"
	<chenhgs@chinatelecom.cn>, LKML <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] swiotlb: eliminate per-map atomic contention on
 used/hiwater tracking
Thread-Topic: [PATCH] swiotlb: eliminate per-map atomic contention on
 used/hiwater tracking
Thread-Index:
 AQHdAl427ISAWK+xiUOEbDzqfvGrgbZLbReAgAN3FYCAAIy50IAAvYmAgADWmfCAAg1oAIAAJCiggATOWgCAAm4o8A==
Date: Thu, 2 Jul 2026 16:00:37 +0000
Message-ID:
 <SN6PR02MB415705E3CAC5BFA8EECDB881D4F52@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260622122114.2563254-1-jun.miao@intel.com>
 <SN6PR02MB415757A3F56268BE3AF01D35D4EE2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <SJ2PR11MB8498277BE45D32A81ED07D9D99EC2@SJ2PR11MB8498.namprd11.prod.outlook.com>
 <SN6PR02MB4157761C37193172603E6AFDD4EC2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <SJ2PR11MB8498300801245B279182EDE799EB2@SJ2PR11MB8498.namprd11.prod.outlook.com>
 <SN6PR02MB4157AA96B686F49F0800A39AD4EB2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <SJ2PR11MB84984BB3EE01F44D466EE39E99EA2@SJ2PR11MB8498.namprd11.prod.outlook.com>
 <SN6PR02MB4157CD254526EE6A93FC5B28D4E92@SN6PR02MB4157.namprd02.prod.outlook.com>
 <SJ2PR11MB8498E2E9F7D8ED129728C97799F62@SJ2PR11MB8498.namprd11.prod.outlook.com>
In-Reply-To:
 <SJ2PR11MB8498E2E9F7D8ED129728C97799F62@SJ2PR11MB8498.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|MW4PR02MB7300:EE_
x-ms-office365-filtering-correlation-id: 7bd8b4e5-aadb-4203-a0d1-08ded8530ee6
x-ms-exchange-slblob-mailprops:
 02NmSoc12Dcj/mAxI/NGvzdUkjNASRo/g+0UZyysfj5z0ZN84xIYbsI/jgZzXEBAJI7f6uoplfnDvqPmaLFIK/exS5gFNjVaIvO8K4L/J+U9q4f8V0xbCzBr79mSsYeREptqwbg3z0FafvrsCBXzVBSEdezITAjqcckyWfstK2i8VL47hiL86rSTjpsKTz9Ab823jIICXDTgdFdlxTtsqhRSqHRoA9s/hQy3vtZZ8HkSsKCk5+x3KmnaiES2UB4o3dwYxmrSxfGJBFLF3umUKrpUC4E6tNtr9uCwB4BA+b187TORsb2dRSUDWEtw5y64CeJGX6rG9IWKsJhCZl4kQgvLV4FnOAYhjKhg2B6dFcf0DC7tFRUsJ5QhS6+6c0dyc2KPKfvey0QjXRur6IJ+PAtYlALvl/EM3lrKYaQN2YkHD+jFzqEA6T2ITHPgko/kcLMdDXuwxj1835UXN8ssfEObbJRV3jsJP6SLamjlJk+lqvZFUjjW6VJRuOrv73xF/GfNj3w9g/LOAHpkgZX3DPFTXwh2Ohsvxelx8TPNMlkAUQfMlkTNubDvOYlMmu+Xuco4w4GStg1N3IyWozQImXeYxEycDgzxNvygkWNTP5XvfnUiSIl8zOqplzdMLvvcr6v5ZKihZvtBqactV4oExDvFNiP7tn3bBhSpLsFH8YxuRu85KM0HWXMoUU1cF8WanjMr4LLy8Y8o4GjhySDRkwLeRRXH3frV+/fkvVWGqrkv3/TpMqYlfpjYUgp1c+Fd
x-microsoft-antispam:
 BCL:0;ARA:14566002|51005399006|31061999003|13091999003|19110799012|8062599012|41001999006|25010399006|8060799015|15080799012|37011999003|19101099003|440099028|3412199025|102099032|40105399003|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?8hPyjY5N51mgD/YaGxLdCIW4wn4aWsLbTonmNBeocDHaJlut1e7yEdNiTN0t?=
 =?us-ascii?Q?OJl5EkjbmCoGiv5EQ4zakp4eZ4hQ6J3s60MEcIU2NiAFijw4yndqJbFULaao?=
 =?us-ascii?Q?t8YRiBPgzK1DcKDlJOvptc1RVm+RmUq2oFg0txCY2RENWNuWaDdaI7wf2pxW?=
 =?us-ascii?Q?R2cDVqo7y4l9T7EIpWhLE9LBj1379OUcJ827CcEtGLssk0jBlEJNwj3ykTv9?=
 =?us-ascii?Q?ioJBMP3I6Q1uRF/HfcDWboTIJU3wSXS2t+3KBI7RSYSQTPjNcNWE9pIbENI1?=
 =?us-ascii?Q?omboz6t/LuqvlQ9YKalFj7O3xprcbME2skayMc5VAQgZhT/MVglUFpzc/IYs?=
 =?us-ascii?Q?00vMYEsarKILGYKW0DqDdTANF04nk8oLKhrc6XKJdFG3bMPjVcflPrhk6wlj?=
 =?us-ascii?Q?g8KS3A34Y+EAdwqJYKylOyCGUG7S8oDuA8XJDrYd07nxv4ozi16OIVwzPQlk?=
 =?us-ascii?Q?NmQDW62XIIjaX8x9gH/ASQ7AXQwvGrDWFi9owLzX5ccZilgneXX8ffNuTLZH?=
 =?us-ascii?Q?vIwQIpYjPLc1cTVOqZHxQ2ld2UU4qtaeTDY+XEaxUYmQ13G++010F4LNBLA8?=
 =?us-ascii?Q?23SXnlrX+cGR9xK1BGJN1UTSHue9sws4PsZub3DQKJG/fCZrr6IvVy2PDsk9?=
 =?us-ascii?Q?Dd7laZ36NmsB/c2Co/W7y05zZJLe/AsS+HnARRwAg314UQ7EawBKAN4scRA+?=
 =?us-ascii?Q?eX+SAuibGRU3Yevx+p4OrLZfCg2jQa3nFycXK881JoTRpSy9ZyFWzEVTrn1l?=
 =?us-ascii?Q?5yvyjvdu5je17wEDQsR0wAOQjE3r/DkPIEBzsmaAVg886HmZIexWQDuWrC4X?=
 =?us-ascii?Q?8lfMzu95i9oK112n/hD3fbzF6o8PtY0oKKJyINfnslfJrq8wQccp5XNxnKw2?=
 =?us-ascii?Q?K9cdvB8RaO4lt95HDI1/QgUEkQj0NhiEcZ13YDj0vtieDCWse363ef2geUhi?=
 =?us-ascii?Q?4MmrH0H92j2R+chZmFjy5ncyfxz7cC6PfwmijcXcAbAfdUj89a1JDok0rcsK?=
 =?us-ascii?Q?foTlOMQ6OecHNmG7jZhBEPCmQatVIYq1l0kveUbr5k+QYYXDtlf1GuTt3oYz?=
 =?us-ascii?Q?cQ7qH1Wn?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?QkNyYXlufEumx7UPO7+RqDlMABxp4CmBq88GyfxkJpa26CKrCbTcaEPoymKj?=
 =?us-ascii?Q?KUnYwfij1m0LmIOhGCBg1UFecv05XjvPbv97jzBL1IQx0unVfEoJkU8C/4h6?=
 =?us-ascii?Q?P2qxX4vbq/Mxnw6j7hBx4ZmLml5WQUsA85J5h4SuD8E/sWFg0Z+Ctxc0z2Um?=
 =?us-ascii?Q?QgxpbRuHU1ap+GZqr2/5PXMxhOn029yVBfJiMe1bq+W+eyPvU6MOJVG035vA?=
 =?us-ascii?Q?SrN6F7jFI8Cfk9eiCiq2N4eVo+xdT3dKK9HmGoi2LkKU07kn3GlvQeee/M1Q?=
 =?us-ascii?Q?KAbFf3Cbtp/32gtIFqz1brhAtEe8mOIvg0sBgftsffMWUAFLUfAoJ5iHmMLE?=
 =?us-ascii?Q?Vz0/haqAGmA/jnNhljsXmR7UD+WKqgGTigVKNg6M9B9fEcpsVBBF7KWixNOS?=
 =?us-ascii?Q?+vXrpUeMx8b+z/wGD/jfKfxRt3+CfLUtBmTFilZ71q7gAXN2cMH19On5nk8v?=
 =?us-ascii?Q?UESfsPwp7DTYVj9ExHbnuGek3PMrUB/bjLnegbVzT/qybsviSX+r+QyPPmKK?=
 =?us-ascii?Q?+cYdH9L1AXV+RO3uTq395BRzMl2o/dnoBwO4uX68E9tyHfIXMnJCquVnEwDx?=
 =?us-ascii?Q?Z+Hf5YsR39DWtUCmxQRqb5CjTSywb6y+y/HciiRqIL3HHpLiPT0vapU8pzkr?=
 =?us-ascii?Q?Cv6x/9b7Pdmva8wGxZKBfTgvnRY/qIIGWm2SCASw9YBoUoUioOajhuebTTS5?=
 =?us-ascii?Q?jFo2wFuLqRVSMNkHUmxPeoqzG7a9MTACheqN+F02kVgSjHNe9JDfxdlp4iBx?=
 =?us-ascii?Q?dq3/ozcfWoq2a2rH1yAwpyr8aqTQGQsUcBW14zKQEAJIq8yOrKje8lkoK404?=
 =?us-ascii?Q?JoNEJ5mqFOF3QRC38I/dEjG73NXiURUl1T5hfL+7M5OaNe2vl4mDf/+FDQQF?=
 =?us-ascii?Q?XwHSt6OCvMTiD4/D/lbU72qhc1j208LPw/NrZPp+tWlrpcamVwVJuVXCKfW/?=
 =?us-ascii?Q?gvLLZ1lvOibaWIetbwciKJPOh4EDZ/LNZvi/9mp+8qMRRkSy8F8Sf1bIY5b6?=
 =?us-ascii?Q?XEe9ptj0J7LkXkd4aaAZ9J0fGSlMQcAgsuPArV64fUgYuzpE2Lv+n1R1uLN/?=
 =?us-ascii?Q?FbuMeg6FD1g7cfF3+lcwX6IH77tCvdV1hc73zYK7iRI/7jnRF6gmngPzMDbD?=
 =?us-ascii?Q?DJiDkWJc7XIsa5CDmw4mfiMQAYOskIRLOo4aDiZ8QZyx71a/5OLqgCkAbW46?=
 =?us-ascii?Q?+J21TEreZxVcvWW9vi4eFUdOHnTk+QtXPaZczhP8XfcEvcgjsV7qsYbS0V/s?=
 =?us-ascii?Q?+fsXOJ2lP21FfDAK8XHUhJKOwxoFUazXpOLpZlxF50P4KfqFkOdvm3WPVzJ8?=
 =?us-ascii?Q?tElY7SMLn1XP0oeW6bF3s81+zPUkGlEmCmbt6r/zqNQaT/mmhGX2MnL0dC2w?=
 =?us-ascii?Q?sNomz+M=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bd8b4e5-aadb-4203-a0d1-08ded8530ee6
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2026 16:00:37.6622
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR02MB7300

From: Du, Fan <fan.du@intel.com> Sent: Tuesday, June 30, 2026 7:54 PM
>=20
> > -----Original Message-----
> > From: Michael Kelley <mhklinux@outlook.com>
> > Sent: Sunday, June 28, 2026 9:30 AM
> > To: Du, Fan <fan.du@intel.com>; Michael Kelley <mhklinux@outlook.com>;
> > Miao, Jun <jun.miao@intel.com>; m.szyprowski@samsung.com;
> > robin.murphy@arm.com
> > Cc: iommu@lists.linux.dev; chenhgs@chinatelecom.cn; LKML <linux-
> > kernel@vger.kernel.org>
> > Subject: RE: [PATCH] swiotlb: eliminate per-map atomic contention on
> > used/hiwater tracking
> >
> > From: Du, Fan <fan.du@intel.com> Sent: Saturday, June 27, 2026 4:21 PM
> > >
> > > > -----Original Message-----
> > > > From: Michael Kelley <mhklinux@outlook.com>
> > > > Sent: Saturday, June 27, 2026 12:00 AM
> > > >
> > > > From: Du, Fan <fan.du@intel.com> Sent: Thursday, June 25, 2026 8:12=
 PM
> > > > >
> > > > > > -----Original Message-----
> > > > > > From: Michael Kelley <mhklinux@outlook.com>
> > > > > > Sent: Thursday, June 25, 2026 11:54 PM
> > > > > >
> > > > > > From: Du, Fan <fan.du@intel.com> Sent: Thursday, June 25, 2026 =
12:30 AM
> > > > > > >
> > > > > > > > -----Original Message-----
> > > > > > > > From: Michael Kelley <mhklinux@outlook.com>
> > > > > > > > Sent: Tuesday, June 23, 2026 10:35 AM
> > > > > > > >
> > > > > >
> > > > > > [snip]
> > > > > >
> > > > > > > > > +	pool =3D &mem->defpool;
> > > > > > > > > +	for (i =3D 0; i < pool->nareas; i++)
> > > > > > > > > +		hiwater +=3D READ_ONCE(pool->areas[i].used_hiwater);
> > > > > > > >
> > > > > > > > Let's ignore the SWIOTLB_DYNAMIC case for simplicity. The a=
pproach
> > > > > > > > of calculating a separate hiwater mark for each area, and t=
hen summing
> > > > > > > > those per-area hiwater marks, can produce very wrong result=
s.
> > > > > > > >
> > > > > > > > Consider a 64MiB swiotlb in a system with 8 CPUs. There wil=
l be 8 areas,
> > > > > > > > each with 8 MiB of space. Suppose the workload putters alon=
g with mostly
> > > > > > > > smallish I/Os, say between 4 KiB and 32 KiB. If each area h=
as 16 I/Os in
> > > > > > > > progress, the area hiwater mark might be 256 KiB (16 I/Os a=
veraging 16 KiB
> > > > > > > > each). Summing across areas produces a hiwater mark of 8 * =
256 KiB =3D 2 MiB.
> > > > > > > > But then suppose a 2 MiB I/O comes in. The hiwater mark for=
 the area that
> > > > > > > > handles that I/O will grow to 2+ MiB. After the first big I=
/O finishes,
> > > > > > > >  another 2 MiB I/O comes in that is handled by a different =
area, whose
> > > > > > > > hiwater mark also goes to 2+ MiB. Pretty soon all 8 areas h=
ave a hiwater
> > > > > > > > mark of 2+ MiB, and the total hiwater mark is reported as 1=
6+ MiB. The
> > > > > > > > old algorithm would have reported 4+ MiB, which is accurate=
. With
> > > > > > > > higher CPU counts and more areas, the discrepancy can get m=
uch worse.
> > > > > > > > This is a somewhat contrived example, but the problem is re=
al enough
> > > > > > > > to make the reported hiwater mark be unreliable.
> > > > > > >
> > > > > > > You are correct here, I like your way of thinking.
> > > > > > >
> > > > > > > > I'm sure the contention for the total hiwater mark in the c=
urrent code is
> > > > > > > > real, but it's in the context of a lot of other CPU work th=
at is being because
> > > > > > > > of the bounce buffering, including copying lots of data to/=
from the bounce
> > > > > > > > buffers. Is that atomic increment operation a bottleneck ev=
en in the
> > > > > > > > end-to-end context of doing DMA through swiotlb bounce buff=
ers?
> > > > > > >
> > > > > > > Practical benchmark show case the highest IO performance for =
each TVM spec.
> > > > > > > even if a few iperf (4)workers would cause the contention her=
e.
> > > > > > > My guts feelings, yes, the real workload probably hit the bot=
tleneck here.
> > > > > >
> > > > > > Just curious -- what is the NIC in the TDX VM? I'm most familia=
r with the
> > > > > > Hyper-V case, where the NIC is the Hyper-V synthetic NIC. That =
driver
> > > > > > uses dedicated send and receive buffers that are allocated and =
decrypted
> > > > > > when the NIC is configured. Most NIC traffic goes through those=
 buffers
> > > > > > instead of the swiotlb, so I probably haven't seen cases where =
the swiotlb
> > > > > > is the bottleneck for NIC traffic. I do see the swiotlb as the =
bottleneck for
> > > > > > disk I/O traffic, but the data copying tends to be the gate rat=
her than the
> > > > > > allocation and freeing of swiotlb buffers.
> > > > > >
> > > > > > >
> > > > > > > > Another approach to the contention problem would be to have=
 a separate
> > > > > > > > CONFIG option that is narrower than CONFIG_DEBUG_FS, so tha=
t the
> > > > > > > > computation of the hiwater mark can be dropped entirely in =
production
> > > > > > > > environments. Or the setting could be dynamic at runtime vi=
a a
> > > > > > > > static_call, defaulting to not computing the hiwater mark w=
hile still
> > > > > > > > allowing a sysadmin to turn it on to see workload usage of =
the swiotlb.
> > > > > > >
> > > > > > > That's counter-intuitive from my perspective.
> > > > > > > With global counters, the observation, which itself impacts t=
he performance,
> > > > > > > wouldn't be able to tell the practical characterization, that=
's commonly lower than
> > > > > > > max performance, in turn breaks the semantics of what's it fo=
r.
> > > > > >
> > > > > > Agreed. If the global counters affect the performance and throu=
ghput
> > > > > > significantly, having an accurate hiwater mark loses some of it=
s value.
> > > > > >
> > > > > > >
> > > > > > > Even without those global counters, if user wants to know the=
 hiwater value,
> > > > > > > snapshotting used value(sum of each area as current behavior)=
 periodically would
> > > > > > > produce meaningful value for workload evaluation.
> > > > > >
> > > > > > I'm a little skeptical of the value of just summing current usa=
ge. Doing so
> > > > > > tends to miss any spikes, and the spikes are the problem. If sw=
iotlb capacity
> > > > >
> > > > > That's current design when CONFIG_DEBUG_FS is off, and used as sw=
iotlb
> > > > > shortage indicator for user.
> > > > >
> > > > > Statistically that sampled value is approximate to the true value=
 as always.
> > > >
> > > > OK, yes, statistical sampling could work. The kernel queues a work =
item
> > > > that runs periodically to sum current usage across all areas. That =
sum is
> > > > compared against the previous sum to calculate a hiwater mark. An
> > > > experiment to compare the statistical hiwater mark against the curr=
ent
> > > > exact calculation would be interesting. I wonder how many samples w=
ould
> > > > be needed, and hence how frequently it would need to run, to get a =
good
> > > > result.
> > >
> > > Kernel doesn't do that sampling, kernel only report the sum as user s=
pace requested.
> > > Take a look at the flow when DEBUG_FS is off, and essentially it work=
s as vmstat,
> > > user set query interval.
> >
> > Agree -- the kernel doesn't do that now. I wasn't clear in my comment t=
hat
> > I was envisioning that the kernel *could* be enhanced to do the statist=
ical
> > sampling and report the result via sysfs.
>=20
> OK, thanks for the inputs!
>=20
> Based on previous discussions, to keep backward compatibility, how about =
keep
> hiwater as it is, while guarded by dynamic knob(default off), and export =
used
> memory from sum of per area as current design does, then user can still h=
ave a
> chance to track the overall usage w/o visible overhead introduced by glob=
al atomic
> counter?
>=20

Yes, that works for me.  A couple of points:

1) If doing the exact hiwater calculation is dynamic and defaults to "off",=
 that
dynamic config would replace being under #ifdef CONFIG_DEBUG_FS, right?

2) The mechanism used for dynamic config needs to be one that is
selectable on the kernel boot line so that the exact hiwater mark during
boot is easily available.

Michael
