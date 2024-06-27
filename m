Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2073.outbound.protection.outlook.com [40.92.42.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A33197A91
	for <iommu@lists.linux.dev>; Thu, 27 Jun 2024 14:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.42.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719500348; cv=fail; b=jYs9JYU6+AKdqndDGvu+sejKiYUVLCcw3JsuL4DGlgKh5mLraXX+i45HWbpfcPr6Wx1/F4M9biRAx6LVuLYXa2t1n5kjJXn1RijH//b0OYqq/MoxI55gtb/6ILrmxw7+vaB/1DynTVLKVMKZI7FBZiLfs8tLRTYzTh9rU23K4OE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719500348; c=relaxed/simple;
	bh=gbRvgSfQE8eEdWQvOPgOrLVx8N4iZK3OJXhc0syicsE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eyHSsrS3ekKGpC976MjgRmevYfoXq4wl6jtXC7NQZ2k66Cti/1pDOjQa/Ke4/ze1PtoSvCAQOnZWdii0fuR3bT//w/lknXz8oil1MsGzL0pt3G6IifKQ4u9ACm6IW2AIhT19/Giv/u9QQeEJuiPzsmn6gRO5xsosigzZ0Ox/QWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=iTF2HFL4; arc=fail smtp.client-ip=40.92.42.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="iTF2HFL4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kWFRMAIgFA2Z6O/VljRh+SIg7NwvOtQpSPyP18M1JpShlXKqA7R1fdoiIYlIxjy77TQe/bxYd0kWArsCqlZeXzZRRHs1kpE4IbXfNah+Z6bwM+oSGDuCdviMe9LfhmciKeE1JUzsIK1sA0OKd1o5zOzplxKIlLuMXBvW2cDqApI3IPkYhz2LLg15yCHj3ObqQxttYdkRlXXjON9Sro7j1WBP18vmW7yYodB+YFdDbY9bNDNTiF81IAWsWwndcQtWiY6V7iDeM5HTRl0IHsaKtsVldufOYoW6kyy9aGNt+ZyJNFtNwS9ITlbT/wQS6QMpZ7z8JSjdWTmDtr61pH+GZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NP/TXAPT9GP0tZ60Pj5MVZ+f2bWwsuKKiNQf1CRtEhY=;
 b=O49P3pTgQ+Ai9vj8spy0AAeTycXE4XNijAc0V2lnFyvKArWfnse0ywvCVIed8guZ8PBnrAPYh4gmDhD7AQ1sAz/HcwrfWD49zj6BiZwguHh1jkhVno9bOMKSKgBe6QtAhUpvIAImhkaZSxT0qX7qA69Hv2V4vIyQU5KzAGJZMJp3Jey9mDC5gHA01V6Q5gqQ1rDgdvCvZRZXDLi7O+IO4zEbcFdpGJATiL/mbxyHykvJ+p5pU5hGdL1WuwFTsI3d8uZGDE8xvaFOj7/0c5uBeIN8BZeuyRXO0MDjOgDBIcYDyll+I1pzssjkVbeiqn4gB5oegPuPAPW0g705QPN8oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NP/TXAPT9GP0tZ60Pj5MVZ+f2bWwsuKKiNQf1CRtEhY=;
 b=iTF2HFL48PS0A8ss+AnIjxysACbDIMtxftRCX2bAgyrGs8l3AC76x74mJrBHUvBzQQXWINV3t0Y2zopl7H6K28b01W87hY6Cml0YYDYhxzCOeVgaq/yeMb2BGu4Rcn1RWiMEoPNehS+XHYvdauKZ0lbWMO/kWoeHY2WaB7RO9hPMgo2iAhlWboKWQ4pJqXaPe5CdlCKj0U+epZDaz49W5F1vPdNlkaGdETM0AXynaEviGZboVc8IuTaK498fI8QscCyMKkYqOoHndqtgCgeVXjdntMZVhIjC+nzCk52XrC9S8uF0xkC2ZQEToZWowslvvZMWFTBQBmuXejbHP5+TVg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SA6PR02MB10791.namprd02.prod.outlook.com (2603:10b6:806:440::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Thu, 27 Jun
 2024 14:59:03 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%2]) with mapi id 15.20.7698.033; Thu, 27 Jun 2024
 14:59:03 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: =?iso-8859-2?Q?Petr_Tesa=F8=EDk?= <petr@tesarici.cz>, "hch@lst.de"
	<hch@lst.de>
CC: "robin.murphy@arm.com" <robin.murphy@arm.com>, "joro@8bytes.org"
	<joro@8bytes.org>, "will@kernel.org" <will@kernel.org>, "jgross@suse.com"
	<jgross@suse.com>, "sstabellini@kernel.org" <sstabellini@kernel.org>,
	"oleksandr_tyshchenko@epam.com" <oleksandr_tyshchenko@epam.com>,
	"m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Subject: RE: [RFC 1/1] swiotlb: Reduce calls to swiotlb_find_pool()
Thread-Topic: [RFC 1/1] swiotlb: Reduce calls to swiotlb_find_pool()
Thread-Index: AQHauIjoJBWSrCyO6UWzcncSceBiMLHa1Z9wgABomICAAA3OAIAAhiSg
Date: Thu, 27 Jun 2024 14:59:03 +0000
Message-ID:
 <SN6PR02MB4157E61B49C8435E38AC968DD4D72@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240607031421.182589-1-mhklinux@outlook.com>
	<SN6PR02MB41577686D72E206DB0084E90D4D62@SN6PR02MB4157.namprd02.prod.outlook.com>
	<20240627060251.GA15590@lst.de>
 <20240627085216.556744c1@meshulam.tesarici.cz>
In-Reply-To: <20240627085216.556744c1@meshulam.tesarici.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [fWtQtpoQhh9P6n6U/S2eCRH68cq78H5Q]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SA6PR02MB10791:EE_
x-ms-office365-filtering-correlation-id: 1ccfd2f8-4b42-48df-fd03-08dc96b9af81
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|3412199025|440099028|102099032|56899033;
x-microsoft-antispam-message-info:
 BsbSx4tOIOspvZwvADszIlAXUTGXaCRozXth+6JQaQPAn0SfTb35w4X4aObwpY1VaEev85FSzl5DeVowJDUqOaPTofrjz3M2pod2Qg3aawudatsOu+BCTLLqz6PDWOQTJeg2OKjZJ34UOeGDSSiAxsSaZFf7iAPB4zdMGePrPuq1nz1xrJKURIl8gTtbdZrI52csjcZcfegKlfLkhO/J7wlZnh4Gqw+oBVf/KEQOp9Bcuxc+bio7bDr7dCLuW0AiItoK8EKxJFN1GYcF/Q3HriCbc43l7GqiQQ1xuHfK6KooDQ4Oi4i+OkEfo/r/Vnzvz4pNREKUw7b73ktipH0y1im1aOcUiT+3scA/Gn+HyVNPGkh0hFKzt+mkdGrVPoEyoDXpmUiro4efeFbqtsTj2I29i2/bz93uh2HJxjT41TSk2xMjjny3AdLyOzXneeXvcCRRqVdSkVwtBaGyniyjf6ntWJpfMeIsSfu8znmCBw7gTKtH42mC6fSTIIq1COCsJq6teNQOrZgk+zH/rjysDM21Y7kCB3c78vKsRfEMvU379jNApn6Z/kIHUqkvYUd4
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?CSY1WfSq/A2Pw+DgMzEvZv3FNFIh0U1azGBe4vhVn9kEzRkImY9cEyN3EG?=
 =?iso-8859-2?Q?3oU9nfVLKvrq1rJeNoeEpzmKZ5+r6MPX5AHc4gqJDjM9hQ4pMDcg7do47T?=
 =?iso-8859-2?Q?Q0UGPye7s/KFYUCCORn++d9kfXGYA8p/toQk5vG+c2403wQPHxuNvOwjg2?=
 =?iso-8859-2?Q?7LVvdoI/3jkwBCiMRBxkkkkCPOXp+3Tb0OjxdpHw9WTkoDJermq4tEDfky?=
 =?iso-8859-2?Q?wj5dV2taBnSYzdcNeXQfS2YyxiyfV0SbX/29m1mML1o+8U5b+jxGFZNfJc?=
 =?iso-8859-2?Q?UkQH6PppfP/rbutqlg2Zt+rRCsZ73s9PgO6gzie5kjyJmL5WEADtxfv6ZM?=
 =?iso-8859-2?Q?ejOgxlI6kukqzhmZl1hvogPw5bYXOJh/yDdjH915joRqsE61V8ONazaf0f?=
 =?iso-8859-2?Q?bSPjvrt2yBIb+83GXEVzpWTc6OYCHshoyFA7JT3F9IoakfaiMuY5y8/gPk?=
 =?iso-8859-2?Q?qjLZHEnj+q5EX0GEAthRN1GX9u88fkUxKbx9GrMicsWpFNjF9x406d2MdO?=
 =?iso-8859-2?Q?jafF5Sd550JjIiJKqRNqs6fInVja4buUergL4EL07/xleiKnMgWKm/Lg4z?=
 =?iso-8859-2?Q?7CFAweA4A/UBjOR2sytWRARLeZf51QKWVG9Shh/IPj79emyuvouDs2/o+e?=
 =?iso-8859-2?Q?3/MewYMCZF5gVGrZWYRLO+hqsyBMSbVxFI2Vb8T11ILzERnHx9rvOpHTE1?=
 =?iso-8859-2?Q?1l5zAKxb9Bhu0KaO07uwMocdAihB9XbVMhzsOCav01gpgQa+Na+NRvlM07?=
 =?iso-8859-2?Q?JECjlfG16pRu2KaSIFAzXLs8uiT+18W11+yd5RlOrPQ9XudkRzGgOBW8fo?=
 =?iso-8859-2?Q?4OBbnx0miojKb24121y3u3MVgeO1R+OO3TnDalErGIZhFMUGPfYRSOh5Jr?=
 =?iso-8859-2?Q?QkpIijPDwnX3ZmlTtSvDfz4wNFwRyhKvCyOfxByEIRpCNNCIr0n7Kp32BU?=
 =?iso-8859-2?Q?CxFJj1YuPBQcqZvzrfdIZAO9JN9m1yjIMr53MRWkxmLxPAay8DF/qnZx61?=
 =?iso-8859-2?Q?PyJrqO7Vf75dWBP/Me/jOavLh6Am+WOlvbQa4gBzvfmDxIPHw8vVYrFS8J?=
 =?iso-8859-2?Q?f5nmJ5Dwv6eGA3TdyvKCN2qqOulw91fHMILp1zeH9JP5y4utoqI/hCpEFS?=
 =?iso-8859-2?Q?oOCL50KWQK9ZsWF3s2lPSuymNsbpAAE6vwkT0+3NtHYzjztDABa4SZxbP9?=
 =?iso-8859-2?Q?y95Zp69A9WKa5SmXHSqrJgXqWWxzq8rG2uT6EQMjErV7KVd7KfhRLvT1YK?=
 =?iso-8859-2?Q?qgOSzR0Ypk40tQAJ6W6ZZcm/Z7JGP0L6uQi7X1VWk=3D?=
Content-Type: text/plain; charset="iso-8859-2"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ccfd2f8-4b42-48df-fd03-08dc96b9af81
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2024 14:59:03.7122
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR02MB10791

From: Petr Tesa=F8=EDk <petr@tesarici.cz> Sent: Wednesday, June 26, 2024 11=
:52 PM
>=20
> Oh, right. The idea is good, but I was not able to reply immediately
> and then forgot about it.
>=20
> For the record, I considered an alternative: Call swiotlb_* functions
> unconditionally and bail out early if the pool is NULL. But it's no
> good, because is_swiotlb_buffer() can be inlined, so this approach
> would replace a quick check with a function call. And then there's also
> swiotlb_tbl_unmap_single()...
>=20
> I have only a very minor suggestion: Could is_swiotlb_buffer() be
> renamed now that it no longer returns a bool? OTOH I have no good
> immediate idea myself.
>

Conceptually, it's still being used as a boolean function based on
whether the return value is NULL.  Renaming it to swiotlb_get_pool()
more accurately describes the return value, but obscures the
intent of determining if it is a swiotlb buffer.  I'll think about it.
Suggestions are welcome.

Michael
