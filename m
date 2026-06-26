Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazolkn19010018.outbound.protection.outlook.com [52.103.13.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3723E5570
	for <iommu@lists.linux.dev>; Fri, 26 Jun 2026 16:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.13.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782489626; cv=fail; b=fA1mo5ouyyd7qyMAdv1aUy0VOyFvdUMnsTA75DnebGnR5Tbg/x/FR1jQHmiWYyZ+q9pocCEiSftusicxHQYnnJyPIDjs5a0wc2aazbfw6JXjYkP4vzI6vrH7LEpDK31Yt/GZlwHp1azP/zIYZnvnFGxCmMn06o88wsE9uPgRPrU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782489626; c=relaxed/simple;
	bh=Br5Aw0bPsBIDJV+f3ONk5lL11cnZIqJtH8VP1OH8ReU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MaDIm8WNvN8+7NMEiiGnHovIuNtDEXw57mmXUrh/VExutHBy4hPGIMUfED83rRx1pjLThGa5U5CycCSKj2o4wILLYn8y34vPiMR8K3sd9MVpasXzfdUn5mAdikCDEjLtjhRt5BCv3rX+FB8bcuqnsZ4EIFXhyec+j+WbwwsZFlI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=cU7fcc6w; arc=fail smtp.client-ip=52.103.13.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="cU7fcc6w"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=unfTEU81uWrbMnCwzYIOi0kjMZh53xu0hIRiva27Cw+8PZ9LT1WlGJrHPhw35QAAjG7QThsPrCLq6ue91xi7YVxhrTW0DIjkiK23aJIQbLQlzSEwLu5rEd2zQXITjkdre6lvSOe0/YWojTwYZQJn2m+aZEee7Gry9OD5XHU71rlMYAFcHtIQU7cs3OnqBcPkizTMEa+19PuWcKby555tTdOEOvZ7Nm+AF8L+Dyo/Jtqt8i1ZVFf2wR9rtouS1fir72F57poDeOLhGidcT/Qy0vutpPO5m+2iOiQw/4tQC5MndY9KRcTstzLVcpMc0woeu9e7f7g3M/Ob0nPC3FyBIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nP0xctpK24R/gws6aSE1ilZYF+AbvwyVseVCqde4uZQ=;
 b=s01kUqUkD8BjXwu9tvsSSaEPmdfXMijYTPS9EnUtgi+PhzZ5qS/IZYRHL7wFSHbq89evizzvd+3k2Lezwh1JN1DXu+vxxn0gzuZXdb+Hw1j/iJDDyZ01C7KIXFM2yifHHzqPoYZJ9jWeepMkyiANYLzBu8+doG1IVoAcgJKwR6duhrXMV528KikxZGZkpSuKSvG8xyNdFxmSCd5+s4Rj5Anbv5QTNwUpsECB6viLvZZWf4EIsHLSa/HT2GoDvKu2bWBTGjIM4IMWFttdtKnoM6qeeyrNxI5xcP/KsZH+RNZKGXrkkCHLPgl3EgLQ5UzpsZEaXvgdX08Gx97nGHVN6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nP0xctpK24R/gws6aSE1ilZYF+AbvwyVseVCqde4uZQ=;
 b=cU7fcc6wFQWU0HE8swGWQvuJEnTWmCPY70OVoZgvuuxEbo7fThhYXB1jClQNMlHz5IAOf/ISDj4ctwE9uKO31EfjZzuaOExsxOncT1iZgkG6SuH6DEyPaLdIe+ZlYMjthJ3p3v8bduwOpnHyBzIAvlLFDPGmcEXkPhs76a8goDL7X50pULdvwjiahQ4l5g3V/k/K/sOSW0CEt4vqWf3S9gJDgS674lIMo0gscYFBe1RAv7oCqdG9CVc8C+5XJk/ynOrAHKi81WQkW9+9g9U8+u1sNW3Cif0KHdTnx5/XiRQIT0UGtS+cTOeOWGnEPwz3L6IL8tueQHa4lC835c+zmA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SA3PR02MB10140.namprd02.prod.outlook.com (2603:10b6:806:39b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.12; Fri, 26 Jun
 2026 16:00:20 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0159.007; Fri, 26 Jun 2026
 16:00:19 +0000
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
Thread-Index: AQHdAl427ISAWK+xiUOEbDzqfvGrgbZLbReAgAN3FYCAAIy50IAAvYmAgADWmfA=
Date: Fri, 26 Jun 2026 16:00:19 +0000
Message-ID:
 <SN6PR02MB4157AA96B686F49F0800A39AD4EB2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260622122114.2563254-1-jun.miao@intel.com>
 <SN6PR02MB415757A3F56268BE3AF01D35D4EE2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <SJ2PR11MB8498277BE45D32A81ED07D9D99EC2@SJ2PR11MB8498.namprd11.prod.outlook.com>
 <SN6PR02MB4157761C37193172603E6AFDD4EC2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <SJ2PR11MB8498300801245B279182EDE799EB2@SJ2PR11MB8498.namprd11.prod.outlook.com>
In-Reply-To:
 <SJ2PR11MB8498300801245B279182EDE799EB2@SJ2PR11MB8498.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SA3PR02MB10140:EE_
x-ms-office365-filtering-correlation-id: a306d6f1-7cad-44d8-c68b-08ded39c05b9
x-ms-exchange-slblob-mailprops:
 02NmSoc12Dcj/mAxI/NGvzdUkjNASRo/g+0UZyysfj4/fAVtkrKiAqItxzCpDEeQolohwJQ7reh7Y7wCDBVG9I4PeFm/j7+qWbpbX7KlzX3Y0MyrbYKPoVLNONGEWn+cVIWxUeqIp5u1AbslUnKD4YCW62hmEs4FD1U5pCsQuV0/edN5siqmgrYg15b4pjAJZWq0iEFpb3qkJoETfIyJ1oecj2lzM5Qp+VR6nWDUyqFRRzAg4R374U4mjJ+6tObsGeysSuv0QV3VuRjM5XoYCUYHRm9qDvD4UgX7cL/EfKUlyiM9FLfXOlWbTXrGcvuZPN1Sak5b/BI2pB+Aiatna/YRmJakBerfNy9w+yHn83LaR7aP4ZHkLcXbcof7WTfbU7aLLJaGBaPMugn3539FDwqnxTCrsza7BYT31TIW+fuqWa9LAtzB8C5euXoiuB5y328iotc+chJZHZMmSGUDgMubQAFDU9jjtwGy6TGu1foT9+LAAPdzCiHK1pQQyeecrkm9BKzV2lpB11nnnFOlvmNr7fCo2DjMNWDniNgEPfWIRxdCY4LwJdOlbYSj9Wp9zVaIRvBSFGTQLf/ApN4iMf4i23FOvQz7gZRB26kkbfX+DO/Uijy3Gc2W1ufstihe4vF2irlMo6BHLKp/xh9z8pBSQCBlT4/2siTXJeZfpq6s9l91d7F7CXuTtf26bIjNM43+EX2nYUjp9HAS1tZPu1BMU0Xju1bBZk4B5eP42+m/lIOsLpLYUzksFUn27Klg
x-microsoft-antispam:
 BCL:0;ARA:14566002|25010399006|19101099003|15080799012|8060799015|13091999003|51005399006|41001999006|31061999003|19110799012|8062599012|37011999003|3412199025|440099028|102099032|40105399003|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?0IgsQ2akGgmrG32Cd9ady8akU/vo6c5RWWwka5yi9X+8bxf8F2KYsDJVU5gg?=
 =?us-ascii?Q?qY9viabZ2yCKdY4CiT4TuiBttflBEJfrcmOtVHE53VwWRLcmqmeFSmzh00vM?=
 =?us-ascii?Q?8bJ88y8lkXFt56rQouXLcjLDsaFwAvjEwnwXNUeYvWScHt8FhzDGuy4GiqNw?=
 =?us-ascii?Q?Q2xJ2Ofw5I9wApjSYi6ycsWjupA6faXFFoNegP9KXxHQtc+TNHcMwRKHCbz3?=
 =?us-ascii?Q?568WAnzhSuyTUCqDncV7YggL/jPFJ0HVD0HQSN1Yqz1HbivLFdte9WjLyph6?=
 =?us-ascii?Q?gLRYUY/VPcVot8NYON524itwmwDpZmo97EFUGaG+Fu+YMr/nDFuPUkj9qitR?=
 =?us-ascii?Q?Zef9SPCaePGcpAWlTIfyAnOan5197s3i2Hda/ZwfhPPijckofT8yiBfaG3qz?=
 =?us-ascii?Q?bMh4z3UdUjCzhZx5XzsMkGGWueEUn7vfn9gmVH3V+PL1tyYwfU4qltvyqi4z?=
 =?us-ascii?Q?LjHZPrxgMi8hy0dQumzNGnl+xZG4TFN40gXiYJdPkOCnB08+mnZHBgqKz55G?=
 =?us-ascii?Q?5ti/8L5Anf0eTY1GMEN0afvt8tp3GCACUaZfCfvbNbumkFJbFtcl6Dc/olG5?=
 =?us-ascii?Q?jPx31jG3C3UGTESsFO5Ye2eD07uiM0Xp6E5FbaNJwif91HPGTh7vTeJUS0wF?=
 =?us-ascii?Q?Ci2IwjHOIRAa2K5Uj5jz/4JmWpPMbvRIooILTwxhmIAUq5ybS9yz2bH88r3u?=
 =?us-ascii?Q?ei5TG4ZvNMgwz6H3x0Q4zJtrjVCB9art/3ziEypSDUH1ZpSt54Iy3c9Vqfct?=
 =?us-ascii?Q?NrrUurrTLp5NUkqHD0TQM1YpEI7d1j31hYAclxGauh/k/IIFZvexWJ0gx0v3?=
 =?us-ascii?Q?7Az0drOMTNiF8Zc9anAmjDiSD0NwrAoCSe5Moh1UCrYT+KL9oa348Ybe4Bwg?=
 =?us-ascii?Q?qu6v5j/YWWgg7ppu1Se/vFT5oZ6/WiGKIf11QEylrRT9fsfsCs5/HjoxukiJ?=
 =?us-ascii?Q?ko8TXFazExlg1XNrP4IjQmn5bXAgXfhijnL3E5BcY96F/OkPqpcfDarAWB5m?=
 =?us-ascii?Q?xv3U0+BuCGQ5dbFHNg9kUlaM0WwzcwuPFecBBuq997stTk4ZcZPPaIUmFscy?=
 =?us-ascii?Q?4bK5wvlI?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?iQMhy8aiYL9PsdPMieAGJiIXPN/NHjJ2coEcmkp/zkDQybJBTO0gxP1O6wtM?=
 =?us-ascii?Q?IFFe7udQLlZgZwsoi8vxDfT9ZkRXx4KASOluNBmnCpewJDV53+2UqrNFXrlG?=
 =?us-ascii?Q?j79CqVo9Uy5Y+eQO95V27QeYdxwnJkl9D2c9O81E/lZ4v739J17rqXxG8sll?=
 =?us-ascii?Q?hh0Q0c1cYfgeyL7HPsCyL5CbDZwwq2O3BXAppVQ7AO/sgu/fWOS0zp8xXJqw?=
 =?us-ascii?Q?Fbh7fSCNQJj9qslIvd2MRl+qBwu+op1A7mI/vflyMjQyQKiKQVtF/KfBnHIl?=
 =?us-ascii?Q?iDQL1GHznWDvObzFcCc+zv6gNyHbaaJUWSwieD8Z6yaTiGECvpADDNQYglh+?=
 =?us-ascii?Q?1Qxs7p7nsqi5ZFkAcKfBqVO2BgFP+yQDcIK4K4AXtrFg7GAKZvmSdrf/HYll?=
 =?us-ascii?Q?EfhzxTJyzY2D2S3qnxhLD2yiaXZwjDjXfpnIuuUTGbZRugm4TK6lMvHgLwVN?=
 =?us-ascii?Q?vpBY9Si6yxfDlmwggmQeF11Qadq5OJsEh4WLjze+tgU2zXuUT1l4TienJpIU?=
 =?us-ascii?Q?dbrOVefiGnC3tsPqw54XCCNBjZPHNdZWGmgj/TIrRqaO2xnJQI4lb9mhkiZT?=
 =?us-ascii?Q?1kq843l0UKPZLSVHAt+9mLKJdB/5kQH7paFDhEM9bLsQcBM78+5hOuOACegB?=
 =?us-ascii?Q?CtchLMXEHLWQKAzZXrkdn7b8wpTIFeZji4ZaKczuwmr53365U6ChOwtMS8+X?=
 =?us-ascii?Q?FtFmsbo8jj5uliM3Eko7sZi+erW9CNRpI+Pt9gfj67iT0HS9e54jp/N6jHcw?=
 =?us-ascii?Q?finHhXbVQYNV1rUW4hbZs5g8QISZj8THGspGlMBgI/wJJuGFaUJA+8iGRdDX?=
 =?us-ascii?Q?YjA0Y6LvwRz96zIbRRnS8PWPBhF1BJp/ems7yfoL6pB7zRQQgnRgq+iXW8jr?=
 =?us-ascii?Q?qbMsw4kI6iqqy2JWp6ZnyKRB9OYvczqqVE/8w+2Bgajy1NyHlueaUeu+m55v?=
 =?us-ascii?Q?rcounnhmlNUAns0wH5QwUWocT/xFyM0DNUHJTyZgUzST5tSxP6jAk+6tIc47?=
 =?us-ascii?Q?1Mm+BKp7wIQjIQoVG77bWYXl+XkAWORW7LlwW19jERoh6MZYr+SwG0LMpXUz?=
 =?us-ascii?Q?STGnOdwN10PFqMDPSNF7ljbbU2kDOtMknvhc+yHqUs409wD3+MXbvTk7mpPV?=
 =?us-ascii?Q?k9NqkwBHiORR3IrAcvYAAhFuNBO1YHtyHmYdYp7X+CKcj4jFu9WyjurS0qJy?=
 =?us-ascii?Q?AKjmXTzrfugHANfPYWVF+sEH3+L3T9wTV6fGBQQ+hPAyBei9q5wsZ28+/A7o?=
 =?us-ascii?Q?RSICtzumw5O2KmHy5F0ZnF7V28KKdZE4dJa/dCPLM7ehrpTRjqAA+jfjN4zs?=
 =?us-ascii?Q?iwEK9jJGrM6R5usW9osdJmwiwSjg+i2SHlU3nmXGqCVBKCZ0K/vFeUTkVyGv?=
 =?us-ascii?Q?nA6r7WY=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a306d6f1-7cad-44d8-c68b-08ded39c05b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2026 16:00:19.7283
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR02MB10140

From: Du, Fan <fan.du@intel.com> Sent: Thursday, June 25, 2026 8:12 PM
>=20
> > -----Original Message-----
> > From: Michael Kelley <mhklinux@outlook.com>
> > Sent: Thursday, June 25, 2026 11:54 PM
> >
> > From: Du, Fan <fan.du@intel.com> Sent: Thursday, June 25, 2026 12:30 AM
> > >
> > > > -----Original Message-----
> > > > From: Michael Kelley <mhklinux@outlook.com>
> > > > Sent: Tuesday, June 23, 2026 10:35 AM
> > > > To: Miao, Jun <jun.miao@intel.com>; m.szyprowski@samsung.com;
> > > > robin.murphy@arm.com
> > > > Cc: iommu@lists.linux.dev; chenhgs@chinatelecom.cn; Du, Fan
> > > > <fan.du@intel.com>; LKML <linux-kernel@vger.kernel.org>
> > > > Subject: RE: [PATCH] swiotlb: eliminate per-map atomic contention o=
n
> > > > used/hiwater tracking
> > > >
> >
> > [snip]
> >
> > > > > +	pool =3D &mem->defpool;
> > > > > +	for (i =3D 0; i < pool->nareas; i++)
> > > > > +		hiwater +=3D READ_ONCE(pool->areas[i].used_hiwater);
> > > >
> > > > Let's ignore the SWIOTLB_DYNAMIC case for simplicity. The approach
> > > > of calculating a separate hiwater mark for each area, and then summ=
ing
> > > > those per-area hiwater marks, can produce very wrong results.
> > > >
> > > > Consider a 64MiB swiotlb in a system with 8 CPUs. There will be 8 a=
reas,
> > > > each with 8 MiB of space. Suppose the workload putters along with m=
ostly
> > > > smallish I/Os, say between 4 KiB and 32 KiB. If each area has 16 I/=
Os in
> > > > progress, the area hiwater mark might be 256 KiB (16 I/Os averaging=
 16 KiB
> > > > each). Summing across areas produces a hiwater mark of 8 * 256 KiB =
=3D 2 MiB.
> > > > But then suppose a 2 MiB I/O comes in. The hiwater mark for the are=
a that
> > > > handles that I/O will grow to 2+ MiB. After the first big I/O finis=
hes,
> > > >  another 2 MiB I/O comes in that is handled by a different area, wh=
ose
> > > > hiwater mark also goes to 2+ MiB. Pretty soon all 8 areas have a hi=
water
> > > > mark of 2+ MiB, and the total hiwater mark is reported as 16+ MiB. =
The
> > > > old algorithm would have reported 4+ MiB, which is accurate. With
> > > > higher CPU counts and more areas, the discrepancy can get much wors=
e.
> > > > This is a somewhat contrived example, but the problem is real enoug=
h
> > > > to make the reported hiwater mark be unreliable.
> > >
> > > You are correct here, I like your way of thinking.
> > >
> > > > I'm sure the contention for the total hiwater mark in the current c=
ode is
> > > > real, but it's in the context of a lot of other CPU work that is be=
ing because
> > > > of the bounce buffering, including copying lots of data to/from the=
 bounce
> > > > buffers. Is that atomic increment operation a bottleneck even in th=
e
> > > > end-to-end context of doing DMA through swiotlb bounce buffers?
> > >
> > > Practical benchmark show case the highest IO performance for each TVM=
 spec.
> > > even if a few iperf (4)workers would cause the contention here.
> > > My guts feelings, yes, the real workload probably hit the bottleneck =
here.
> >
> > Just curious -- what is the NIC in the TDX VM? I'm most familiar with t=
he
> > Hyper-V case, where the NIC is the Hyper-V synthetic NIC. That driver
> > uses dedicated send and receive buffers that are allocated and decrypte=
d
> > when the NIC is configured. Most NIC traffic goes through those buffers
> > instead of the swiotlb, so I probably haven't seen cases where the swio=
tlb
> > is the bottleneck for NIC traffic. I do see the swiotlb as the bottlene=
ck for
> > disk I/O traffic, but the data copying tends to be the gate rather than=
 the
> > allocation and freeing of swiotlb buffers.
> >
> > >
> > > > Another approach to the contention problem would be to have a separ=
ate
> > > > CONFIG option that is narrower than CONFIG_DEBUG_FS, so that the
> > > > computation of the hiwater mark can be dropped entirely in producti=
on
> > > > environments. Or the setting could be dynamic at runtime via a
> > > > static_call, defaulting to not computing the hiwater mark while sti=
ll
> > > > allowing a sysadmin to turn it on to see workload usage of the swio=
tlb.
> > >
> > > That's counter-intuitive from my perspective.
> > > With global counters, the observation, which itself impacts the perfo=
rmance,
> > > wouldn't be able to tell the practical characterization, that's commo=
nly lower than
> > > max performance, in turn breaks the semantics of what's it for.
> >
> > Agreed. If the global counters affect the performance and throughput
> > significantly, having an accurate hiwater mark loses some of its value.
> >
> > >
> > > Even without those global counters, if user wants to know the hiwater=
 value,
> > > snapshotting used value(sum of each area as current behavior) periodi=
cally would
> > > produce meaningful value for workload evaluation.
> >
> > I'm a little skeptical of the value of just summing current usage. Doin=
g so
> > tends to miss any spikes, and the spikes are the problem. If swiotlb ca=
pacity
>=20
> That's current design when CONFIG_DEBUG_FS is off, and used as swiotlb
> shortage indicator for user.
>=20
> Statistically that sampled value is approximate to the true value as alwa=
ys.

OK, yes, statistical sampling could work. The kernel queues a work item
that runs periodically to sum current usage across all areas. That sum is
compared against the previous sum to calculate a hiwater mark. An
experiment to compare the statistical hiwater mark against the current
exact calculation would be interesting. I wonder how many samples would
be needed, and hence how frequently it would need to run, to get a good
result.

>=20
> > is exceeded even for a short spike, you don't just get a performance bl=
ip.
> > You get I/O failures, which at least on the disk side tends to be fatal=
 to the
> > application doing the I/O. Maybe the networking stack recovers well eno=
ugh
> > and retries, resulting in just a performance reduction. But I've always=
 thought
> > of swiotlb exhaustion as a fairly serious problem to be avoided at all =
costs.
> > That's why CoCo VMs allocate so much swiotlb space, even though most of
> > it is never used for typical workloads (at least in my experience).
>=20
> That's dynamic SWIOTLB is designed for.
> Only when the IO is so intensive, transient buffer/DMA pool is exhausted =
quickly
> before new shared memory pool is created.

I don't think dynamic SWIOTLB in its current implementation is very useful
for large CoCo VMs. Exhausting the atomic DMA pool is one problem. The
dynamic swiotlb also can grow in a max of 4 MiB increments, so if 400 MiB i=
s
added dynamically, there's a list of 100 entries that must be searched
to find space (and that list is currently searched linearly). Furthermore,
the pre-allocated swiotlb gets 1 area per CPU, which mostly avoids contenti=
on
on the area spin locks. But a dynamically added 4 MiB pool can have a max o=
f
16 areas because each area must be at least 256 KiB. So there's more area
spin lock contention with higher CPUs counts. And that all assumes that the
memory allocator can provide a 4 MiB contiguous area for the new pool. If
the swiotlb needs to grow after there's been memory fragmentation, an
added pool might be limited to 2 MiB or 1 MiB or smaller, with a
corresponding reduction in the area count and increase in area spin lock
contention. Overall, dynamic swiotlb in a big CoCo VM results in complex
and messy behavior with new failure modes and bottlenecks.

Michael
