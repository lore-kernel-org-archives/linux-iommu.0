Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazolkn19012059.outbound.protection.outlook.com [52.103.66.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0E2261B99
	for <iommu@lists.linux.dev>; Fri,  7 Nov 2025 16:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762532382; cv=fail; b=Tvr3fxiX7A7TnyNtrzi4ynVMMaQuPhqa4Goh5WMy8yt2lxoFgCw1F8ZHBD8k03TshtECO2VjPHPVNwwKmcQKUqQfzxbRaOGeBnc0gJCY4IrEJpUStKMHkS/ZWhmtm7PiUTNoh3RiDkKPIj/svWFEtNO7sSfUfvqDQhf/Zus0Oxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762532382; c=relaxed/simple;
	bh=QSE0j5QhdOb66o+g+q1whVtQtiu+AzWyqKuwl9Z/7S0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qjv17PcyW2SgQ9pbvYwop7iPu9A4b3w96cULPvkbKTEtNte50BKHTgMuOA6YKcks3rzgj/30hsTt5zWhWANyBWVyzM4NmSUfZoO8c4dR526iheD9ohJHEhqLpJl57pLZxr/XiXyIjkr/F8Tg9mvkRLC5YaH0lRP3gSOhZBARl6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=eh6mMGSA; arc=fail smtp.client-ip=52.103.66.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="eh6mMGSA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZoZW46YkKNYDL5ghtuGfwcgEldOi6blc/debo9Wbi7X8l58JC/4//vkE3QYPreXZvYtYJPasSBpDctDreM5rnWsneBxTF8RKKeUZGou1TIU1yYV7cc10DvB7xv8wGo1Eo2bSrv9WjW7ReTz91z6wTTv057DJ59NOdRPd/PG3DqejUu1pbjcQ6p3kYskxk5f0UBCqzQ29SFSufoHmhIzssDyzEIb2eOImkrV2P3nHP/tCtMjufs5yHWJf3K2DMhYvlpu3A1+6Li8ie11RbGLFEaDF39QFzzyA5U2FrYCI5iI+PzyvQd37BHRkmQgvm5mk4eUDA86dv+jGIIUGUKvGXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NDpXqhwEjDQ15Cpg+EGpW5PSojODf1UUgBRzaoxGzg8=;
 b=sLAvHGPB/nm22t+Nv2GWeTeKo0U4XSsRNdTnP3E+qOviApzNwDnxOeIf5tCm22VHEd9WvNLHJlCYVd900q8l+fVgBsVcyZlD0yOZ2h1uXppJG03uqsoXtnI+odWHer4wwu9FbNeeM9PuWAhsV8xUVqABsS4WB0T5jvYvHyzC0yb36dTFU0YdsXdGMzZqIk4RO32y/fU++te9Wy2d0H2TZZo/oqkEywzATuL/pohX7DDWeLFXuvvy3bUtskK6MQru+iAFmNJMzC3ocB9Jy2u3TAbUcyWmuT6/8u+ed+r0nB9gMTSylgMZ+6i0WhIxqn/4xwCB48SVj9qP8opxOzc7Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NDpXqhwEjDQ15Cpg+EGpW5PSojODf1UUgBRzaoxGzg8=;
 b=eh6mMGSA7xb2WnL14C/prGttQXKDwmjLNFBnhGMqO7M4roe9AJq/5d4ALq3O2Y3kQqMfRjsfkAUOE6C6TE9NR0Fpbyv0ffUsSaI819trDT5TLq8lFx+9Netjy4rvpydLmEzWr2GDaUu8+MaXXU4f4SVGA06veNUVnIgPugCA/R0gL2qfD7Aa15d8yzfVcfP8JFI9O5nq/9IkGzaVkkN0s8jLfmLYB7MTKvDETSWGLdMUYZQqEC/TZ/kDnwoF9jqf/zOV7MEBKCDQLERVnW1BLZKyA3x1n+lN3aONAFQ/Fj0Z/UH9m7MoFhkYbET6JM6QXJwL5UqHEmqb+FOdboluAA==
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7) by OSNPR01MB7555.apcprd01.prod.exchangelabs.com
 (2603:1096:604:318::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Fri, 7 Nov
 2025 16:19:36 +0000
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::5e86:f04a:37e5:64f1]) by SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::5e86:f04a:37e5:64f1%5]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 16:19:35 +0000
From: Wei Wang <wei.w.wang@hotmail.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: "alex@shazbot.org" <alex@shazbot.org>, "suravee.suthikulpanit@amd.com"
	<suravee.suthikulpanit@amd.com>, "thomas.lendacky@amd.com"
	<thomas.lendacky@amd.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"kevin.tian@intel.com" <kevin.tian@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>
Subject: Re: [PATCH v2 2/2] vfio/type1: Set IOMMU_MMIO in dma->prot for
 MMIO-backed addresses
Thread-Topic: [PATCH v2 2/2] vfio/type1: Set IOMMU_MMIO in dma->prot for
 MMIO-backed addresses
Thread-Index:
 AQHcTMpHV8D4LumdDUC0Htj3DzPtVrTmayuAgAAJP0CAANQ9AIAAEaB9gAAKdgCAAAEiHg==
Date: Fri, 7 Nov 2025 16:19:35 +0000
Message-ID:
 <SI2PR01MB4393E3BBA776A1B9FC6400D4DCC3A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
References:
 <SI2PR01MB439373CA7A023D8EC4C42040DCC7A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <SI2PR01MB4393DFDCB2788CB823DAEC64DCC7A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <20251107010349.GD1708009@nvidia.com>
 <SI2PR01MB43930E5D802B02D3FCD5ED9ADCC3A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <20251107141632.GL1732817@nvidia.com>
 <SI2PR01MB4393E04163E5AC9FD45D56EFDCC3A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <20251107155704.GM1732817@nvidia.com>
In-Reply-To: <20251107155704.GM1732817@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR01MB4393:EE_|OSNPR01MB7555:EE_
x-ms-office365-filtering-correlation-id: 9feb65ae-f7c0-4b22-42fe-08de1e197167
x-ms-exchange-slblob-mailprops:
 xgbIMsDSu2ZT1y/65awFWm7XKXdH+3US77y/79oyyoA3MRj6F2FkkupmXLLUh/Vu++4p1tErIxagoa3MCrN0UColU/1tePuxUi00FjWCf/vrJqmGKaNFmC7ZOT6UE5WCdeGK4t+Y0LvDt14xb9U5e/mrTr5W1UwbltGHpZLKg8KKuwMJT+oi9qrHtqMmNVEgXc/7W90VpkfQWIQyC9te1PzxDqydM5xCq7D8aRiPx3Zb8W79FXnexG+XYO3JITnkgER4oqTF4ccrRuD5r7qU2/7xO070pB1OjAey90+TfvnYsiRSN23zhPg0YxEpji9YGb3nZA+RmQp2Syuzx13sgGHEr52cA9GvE5yMtcPsd/0lAUe/r9u7UwveMTfMk9y1xmknQHqTQNOtlwE5BN77cMJ7j3oFCTSG0EOQirYVNgd4R6hAdaLZNBsssAYdD1N5fkYHajwVsT82qFs1Kwjk6bYiOy9HXQRY1PzQzWuaYpNj0kbFXZmioNGS28cHfS7VB5r18ol4IwL4EfBLGzIPcU+Yl6Ukj14CBZnzBgWcxmCr5OytKeSGCE95vuUHV7syOuY9dKabzLt64fyqj8KESGwcvHa27T0QTwfHEuXkg2kHISBm6qjcXDqoOBLqqgusaLwYMnAR6bIW4yRPZ9K/5iz88ul0lzJNOkISL7u5TDGdCoznADpkbs/FM9D+8C3fAx8dgtx4Ur2Vrm8p4HHMAppbpf0vQ6RmJyVOAii06MiU+uLmlZ9EW/HzCuBlDTEDLYa6XOGsQnWteQdSM7IZVp6zsZeHshe6
x-microsoft-antispam:
 BCL:0;ARA:14566002|51005399006|31061999003|19110799012|8062599012|10112599003|15080799012|15030799006|8060799015|12121999013|461199028|13041999003|40105399003|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?Windows-1252?Q?16lu/rX+1AYHXz/Ykm9JnUI+suCHoyxgsidYr1EtPGlnfvD/YAInKdE/?=
 =?Windows-1252?Q?Ll90VPnnaAr6Ju1wBvVbLEEeKQVFT/WsbD33yl9bk2k35CxDw3XPmmtk?=
 =?Windows-1252?Q?N0i/XUp28XtUtj948sgu2ghbquPvBo2Zr7+1fzKWy/nrXOGxtX4bv6d3?=
 =?Windows-1252?Q?GaEqsFF7LQumaGd/ij9rjj1rlgAyryfToV/gu50sBdr4llklOUG7tztS?=
 =?Windows-1252?Q?n6TOEGnqUuxDVxJ+rL3N/9ifeL5GgFSIQHpLvSDPmaAIblpR182A0jQ1?=
 =?Windows-1252?Q?3WGC8cPy/QDovznIcDpbPPXYMJJukSxcHw2JKu0s864r/hUbkjKnKxAt?=
 =?Windows-1252?Q?pcTs7mI1DDZ4y+lcv0aXqDAj8lpcY7iF7bEuMY+PV9o0n1FBVHZVr0aP?=
 =?Windows-1252?Q?Z7qOG3GmBhz/YaEFX5DFq8IQTEUkvbBu9XOmtQN6U8rYvt7PuAcEEHH7?=
 =?Windows-1252?Q?qSu7DB/fyuBu+tOjxOVL/YOGl6HlJKQKvqXeuO64A2982ueJFprOC3zM?=
 =?Windows-1252?Q?ahKIJSds9x58aZpxdT+rTmN7r+GhobuItX5bNcZ/VVc/LRoxqfcttYz0?=
 =?Windows-1252?Q?2b9oyD3tKJrL7JDQBTyu+l1wcm3iva0G9UuPEhUTAvcJ/Zwdpx1MfLin?=
 =?Windows-1252?Q?yySdNnnnzUyKxKXLBve+9897vr9zLCi7zwIGPmlHilkPlT/Z39hRC9L2?=
 =?Windows-1252?Q?1ktSp4jIekbPjhFS4zWHoCclX4aKF8fqzQS1TuH/cpFsuf7Ou2OGPDTt?=
 =?Windows-1252?Q?Wk1PUFfa/pcGxwfpUfeGLf/TGyzFDRBjvie96CA5weTJCQTGlqGSVl2s?=
 =?Windows-1252?Q?kXVH5wpTB5369gVZ/HwRU7LRQcfTRsUEH4KZoV9kTJ1fDjA26gwufXKZ?=
 =?Windows-1252?Q?/F+kOPPQny4bD3+IrliMtgMUYwsNeKmzY7GH1j9b88RR34hC9/HXdWv1?=
 =?Windows-1252?Q?G9M7IkYizN+wD6vbHHb57dhgEmSaYMDW4vIHnITxxAJU0iEpLFqVUEBv?=
 =?Windows-1252?Q?NjD8QTl8svX4n+eDCu+ryB40veg1CHeDaZHde29CsSN3eaz79IcpJKss?=
 =?Windows-1252?Q?MkOk+Sge7o9iECv6INBjHxa3uYHgtbEEB61+P/RZyy1aSk/HGnIYZWcH?=
 =?Windows-1252?Q?C5I0fuGBQad4eXQU4A6gou1aXp/qpShhHuZ/cn9xWzKHb1HtoajKNTp9?=
 =?Windows-1252?Q?AJkBKBBnApWJsW8knZ/SkmwrC5VcFgImyD6wPVAWqYjuCzD8vC03fz6K?=
 =?Windows-1252?Q?nNL5Zq0GjWMS9T7CTV0iwruqTZJsjCwkH0rFAd7H6bsxz1UASR6JZ+Ui?=
 =?Windows-1252?Q?3xgTCdWGYJ6m6DDanmFncNAWHsCaLtv8jyM2Occ0OkED5mp5ZDOdGl7Q?=
 =?Windows-1252?Q?4w6AlUSLanNNLeOZqVnQIl0+fQr0I1oBvCE=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?Windows-1252?Q?30rzHyvS5HsBcRMxPP5gGt24a0fnMJSV+TPTQZ6ssc2f+CozyJmDWFJs?=
 =?Windows-1252?Q?sJk1HSHihAbhoInRi+Xj1e4gPQdu7UTwimSiai5K3OKc76m7tSJZSjWJ?=
 =?Windows-1252?Q?wfVDEAcdkjKxi//IC6WyHjxlVvC9+oCVb1yaVkiGL6fjEz6jQdp3AxJr?=
 =?Windows-1252?Q?gtzXxnf12VIjK2WePkW21o8h7ZJwT1FepiAhytJITZakacYLQFjcq+Ak?=
 =?Windows-1252?Q?kxMe4SJt6VlBd5Zpg7GPIRAoeJ1GlJMiMkb7wZAm9u6B7istP0qM86tR?=
 =?Windows-1252?Q?ZJ/G5AHfX+L1s52gmAazQbjKZe9YaT52q0j98n+4+DdOmp6YlxT09y5m?=
 =?Windows-1252?Q?l5BC7f1XFcyy2kv4bQXyTMSzOecXp3asoMMgXybGrxSww/PRIYdBLILk?=
 =?Windows-1252?Q?5f57Zv2s6KlhU3eUi6wB05LUv5cmno23IGy+CrSzHYa52MXC76Ixo3ki?=
 =?Windows-1252?Q?Qy81vfqRzr62QsH089nqzKRewYgbYT3NcuctQj0QoKPozNlnBNFMT+GX?=
 =?Windows-1252?Q?WrMvSx1JLkbuD+tEtG0vtYyTNTP9kX5nKyHl7EcvWGBkKa0ls8WpxTE/?=
 =?Windows-1252?Q?HNVu6iWdsAmk3XSrNEZIFZoW5cQZl8BOjGXXMH4XPahIg1mI/uXb1CGC?=
 =?Windows-1252?Q?d+WulgaiUWOdZ5nYQeDfWiaJTCaxU84lHt3M+FOyco5OHBvLnSYvvtSC?=
 =?Windows-1252?Q?OtPfKVBFGG1f1zgLJd4zCopaISn/MEUj5YrsAzMdVVY7l+WKELH+HhBp?=
 =?Windows-1252?Q?XiOxlrcJFT+rMHx7/QuHORkulKg4zK20YvP4zh8h6t9HVz5R8K1QVC4W?=
 =?Windows-1252?Q?fmgi0HU3qqvDN8g+dWORnRXZLa/AkO9YWCc6dWq5QF84D/FKpN8ca2X/?=
 =?Windows-1252?Q?ks4O9KDLoIZCN111igJvxE1TY3K5hbUHMNxrG+fgHJAk/BrmBBrchbod?=
 =?Windows-1252?Q?rW0Vwq2GvZmlEGnIOQjhxKzIz3jD+8M2cdhBlsZvaH7TWA3W2OzEo8nK?=
 =?Windows-1252?Q?0eaV4XrfMhfEquwIsZ1Jr5T3s1F2TEvvHuZRK2H9fCds+moVc+oXB3/K?=
 =?Windows-1252?Q?FXKH8dZH465I/neF6VPRDbhOsQJQFiPVo4UewfrASy0XQaT1vAY1Dpcn?=
 =?Windows-1252?Q?iqhUVTRI5mCC2Q+XPn0780e/CMoyva8uCUV1oj/S83xSO9AAS11hwY/H?=
 =?Windows-1252?Q?Olg3sbkntICg4+4X3o81ImcopQJDBzacCAL8uapVQiFq3QsWn/I+PtRN?=
 =?Windows-1252?Q?ya2liwjBaWitTXCgIErxoDBsDzd/cI88pvq2iBtQ2jQr9nDTMnZFGQWv?=
 =?Windows-1252?Q?OCWwYiI2YXPFWU1j6FIf7ypNO0Q=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-9052-0-msonline-outlook-827b9.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB4393.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 9feb65ae-f7c0-4b22-42fe-08de1e197167
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2025 16:19:35.8506
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSNPR01MB7555

On Friday, November 7, 2025 11:57 PM, Jason Gunthorpe wrote:=0A=
On Fri, Nov 07, 2025 at 03:49:17PM +0000, Wei Wang wrote:=0A=
>    > (are you aware of any real examples in use?)=0A=
>    > VM_IO should indicate MMIO, yes, but we don't actually check that in=
=0A=
>    > this type 1 path..=0A=
=0A=
>    Is it because VFIO type1 didn=92t need to check for MMIO before?=0A=
>    (not sure how this impacts this patch adding the VM_IO check for MMIO=
=0A=
>    :) )=0A=
=0A=
> Okay, but it still doesn't mean it has to be decrypted..=0A=
=0A=
I think "decrypted or not" is the job of the 1st patch. For now, MMIO canno=
t be encrypted, particularly not via sme_set(). If MMIO encryption is ever =
introduced in the future, a new flag (probably different from sme_me_mask) =
would need to be added. =
