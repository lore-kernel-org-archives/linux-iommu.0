Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02olkn2051.outbound.protection.outlook.com [40.92.44.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D6D1CF8B
	for <iommu@lists.linux.dev>; Thu, 27 Jun 2024 16:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.44.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719504184; cv=fail; b=Cu0EhtnDATpOgBpMXh+wSBAnBkSTQBzH8BY0Bn/dIaHzmw1tvPBV17tWre/iocp+vccrvbpbXcr1+875xDak+2gkJx9OGxl3gXO7QYxL7EcnZgwI29rmLQbZaUQeMbQ1ZVL8jyjTAdyb51mU0Uz4RfBL6Y0rK7bSjQUXA8+fAmE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719504184; c=relaxed/simple;
	bh=EeydmEFCSzA5KgZuixRSUdrx2eau9iPNhz5xxPpUn6k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Lb59HeTRCez1YIhoiXOkNjrhBIlPHvsWr2pYy/MJRA+NIPbgJWru/NdHflPY6SsIG85rlMrX8Zg63ykzZjDVWrRcOThCNAX7I23+yqiYZ8EYtSdtPGicusiHHs39qNkPH6aWSOmXGr8kq2yBRGNlBu+mOC0ClQXZiXgPwxjLWFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=AwuNnj6t; arc=fail smtp.client-ip=40.92.44.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="AwuNnj6t"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T94H8z0IUYVwJMXeKNGb9essLtbITesxCo6piHdGz5dRbQTW75rPIndxmcZ2tNn2jwlut+U5msIUZDgo1zGb+Ac13CjSEbE6MbLl7HrGSK39ZBgqvUofrB9LVjJGI8QE/Ne2gGEQ9rkgd9xs1r3Ys0Jzv18/lGLTgv+UZ0P+ISFvF6O2Ga53jeoqJXUjvVDVXnS2xX8AyClipuDLJ5vsUcnYVscOKw4za/GztQbFjXoWPdWkcDeDN3Q26k6OmV2TtDCQn+b/LIyFzp2qrxIfU5Ho5LdY7l35KFkYRRWY7g8WUjX+wSL/nJ6c0KuEPc6N3FJWotHFGMHqY0js5cqD1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d6p2xWeJyrMmJRxbPJMuMDfG+p7zrMeNT592PFL1mEc=;
 b=iockCQcBDQkzrPjn/PgSzD2jev0AKXkXFlj3L1SDyadhdGKqfSBjmDkTl7H4OVqzhZdnlnzwdkk4vRMbC0ME7bXR4KwkQbHUGJz6ulCWGRrlPWV3wvEK2rcmpj7fZY+cI/sifAU2pU7yGt0l5RCevMp+BPAOUOtD+jyzIFwmrMbI42lx+QFmWZ6OynSfpvPkCCUyJcIHpqFcOp8pHBumNbaO/KEe2XCNH/7BAz+B9O6t/byZcUtr+vPCb0HOhNRtIVo28yPXJeS03VVDY2T043XgAa8GWKD4k5aUBJ1FI/OCH6GOSwNMtJw++mEU+eCX11GqVqaEYFEMTLanv+XpGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d6p2xWeJyrMmJRxbPJMuMDfG+p7zrMeNT592PFL1mEc=;
 b=AwuNnj6tL6anyc9tcU39q3G0XF7YYuJa+bRNwnt1OJjLzK3O8C0osb5QIP7mcdzjydgp5OW3DrtCLkDxUnqqy5A7eLr0BLsBIcsqfYo/SLcT5vVX2An1PODRdwy7wr8TNFlMKLAmOGGvnqxGpeQMu7E/gl2x3EBRCTut3UtIG4uKJB5JC8GGMtNtdNQjOitkW77+2xLrlW4iR5zJJCVfEhJWHDD3fDiKbja0all285lsAyGcnKj5pi1WlWgMPyKmV9gNoP+FgOPUTEutLHj1fsucQmMaiX/wMXYnlQsFf4887xKrhxtqQW3i8dtTrNQXcOUlt5GPB5mqfZ7dj6CgBA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SA0PR02MB7177.namprd02.prod.outlook.com (2603:10b6:806:ec::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.35; Thu, 27 Jun
 2024 16:02:59 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%2]) with mapi id 15.20.7698.033; Thu, 27 Jun 2024
 16:02:59 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: "hch@lst.de" <hch@lst.de>
CC: =?iso-8859-2?Q?Petr_Tesa=F8=EDk?= <petr@tesarici.cz>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "joro@8bytes.org"
	<joro@8bytes.org>, "will@kernel.org" <will@kernel.org>, "jgross@suse.com"
	<jgross@suse.com>, "sstabellini@kernel.org" <sstabellini@kernel.org>,
	"oleksandr_tyshchenko@epam.com" <oleksandr_tyshchenko@epam.com>,
	"m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Subject: RE: [RFC 1/1] swiotlb: Reduce calls to swiotlb_find_pool()
Thread-Topic: [RFC 1/1] swiotlb: Reduce calls to swiotlb_find_pool()
Thread-Index:
 AQHauIjoJBWSrCyO6UWzcncSceBiMLHa1Z9wgABomICAAA3OAIAAhiSggAAJLYCAAAn5IA==
Date: Thu, 27 Jun 2024 16:02:59 +0000
Message-ID:
 <SN6PR02MB4157D9B1A64FF78461D6A7EDD4D72@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240607031421.182589-1-mhklinux@outlook.com>
 <SN6PR02MB41577686D72E206DB0084E90D4D62@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20240627060251.GA15590@lst.de>
 <20240627085216.556744c1@meshulam.tesarici.cz>
 <SN6PR02MB4157E61B49C8435E38AC968DD4D72@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20240627152513.GA23497@lst.de>
In-Reply-To: <20240627152513.GA23497@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [qE0gvg5VJgMwG45s6rvsjfZIwXoxxqGi]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SA0PR02MB7177:EE_
x-ms-office365-filtering-correlation-id: febd5df1-5729-4a6d-15ad-08dc96c29dad
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|56899033|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 FwnbVCEnrekiFNnnwxcitXyxv5FnTvbouCjwiOobuBbeB7dToY40Glf+UC0zs2Euubqd8R8c1+s7yN4yw3LHTaTQUuawj5sl7SeV+ws1q4sCsDxPul5QQMiPoD4qsQ6vpQWAEnjJS+8MwPWQWIHQ+LdpK7fwCmT3i543RoUfYEDTlomWVfpjLfI0NjrwVsV6Uu0v0ecnFqhWh47w2CBl9du4cimmleexNAC/YVl5nzlu2bWP4LDzKyRNrRh8QdB1bV20QCAWs0nKWdo6RHZS+BLa/qPvs/KkeirUWMbLUdsLm3/6PYf+bvBO87H5emXlq8XqrOx0SZcxx28qA59R3IZzkEVawRVnf+quFO+HUzQRJIoT5CzHfiZD1jHkDpFL3mZkvIBKEy694c1eFYUrNK1z1mKfCRR6OA86+yhsD7F8m+gwSaEa8XSQpOozXJ7+9JQGiIwPHSxWPUqhtj3/7AxBdj+vG7zIgNwGiHp7an6JWmyesyAS/qP72DfPSR0K2/jSVLWocROILs2CdlE/9pQwof7aa7dkMrMvkDhSlCxpgozjqnQt4Q3GH0HDnd1H
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?RCzYSfD7qjg5JShhCWZhCaU7C3hBM9N9rlKPqM6pmpScQ7B0eOcvO5RsQE?=
 =?iso-8859-2?Q?wZbZrPNyJIL8W+EaSFrr0Wb9ivA//9HexTKVz8J+r6V7zt45t/tV7DDr7n?=
 =?iso-8859-2?Q?N7s0JFvxtGTW+7Y0fEVAocuFL5uUsm+3ENrvI3mAUMA90+xoVRR2txCR+N?=
 =?iso-8859-2?Q?ZLatxr+JLpBmRymYa2TQUJIZuUNF3znUKIcB/ZKzbr2nkzenGFJ7RApt1J?=
 =?iso-8859-2?Q?0xvdWFk9E8Y3uU+heEMZqssEiwSSY7/Zt5L1cg4bE7o6aMFTekJF1ClnMs?=
 =?iso-8859-2?Q?Uy/i4osJS+bv+W1pVeknBKtF/xT5wvMAsV5e6RAmDEcIdki/puEZtTov1i?=
 =?iso-8859-2?Q?2Kyjyik3OqCweG0Pa4B8Mv1eg4KuhMijjyFrbqL1617OF4zGpHxSP/8rPB?=
 =?iso-8859-2?Q?ZDCtv1st8vNfAhXs9H0H3Q9mkXQQTpYennhU8CwRGb61TC/mHp1qxBfb//?=
 =?iso-8859-2?Q?qBbskg3mz4gqUjSku16tZ/iaELlMf9h2x0qrXWXQyi8JIo782g3zHloy53?=
 =?iso-8859-2?Q?0W9q71diRf+14XF4yijtfwe9xDMTqhtzZdOzVtbUcJgRxbq1jLgPQSNrUb?=
 =?iso-8859-2?Q?k1YOXWWZLFPZP59JKoUkAERJcRda7QQV56pJd9jv2NNVe3SzR2XVBPwHIC?=
 =?iso-8859-2?Q?u02RK3ZiAZGIWq8QBWllIl6jd2rhQZyl0KK5RncGWRs5gddMEmMzG5dKOC?=
 =?iso-8859-2?Q?xbQ/u1JLg6Y9WzBmrWIosHJJLUOEUu7uogETYvlKEYuagpntnz+kEwG5Pm?=
 =?iso-8859-2?Q?njouI6BwZK/JC+fljyPXeuBDKqfyE3QAkX+aGP0xRQK/0k+vapBHzKVLxo?=
 =?iso-8859-2?Q?j38pvydR0LCEVf7dCrcFtzaFAOIYudfjVw3YZmAPIaU4FfcVPQ3LyY/Owf?=
 =?iso-8859-2?Q?UgECTnSpRfi2MB2aQkpnaVipT1ciB2hdaH9lAfdWb+8Ijlbve1wtN/Ct4b?=
 =?iso-8859-2?Q?hLo53jRKGSZ07lfYXbilA177ObYM3kqIlFWZoMU0cvOgHCxfOecJ70gd1v?=
 =?iso-8859-2?Q?zfxiTTlY4anq1Av0xAp7H2fO9T8O+mFUJSM+6hI22Kxng1SDUsip4qIJVj?=
 =?iso-8859-2?Q?FraCqBj00mNJkYsH4yeTcsrWhKr1u6H7hzeep/CC5w7i5dpNYWIJ060ITK?=
 =?iso-8859-2?Q?O6c2Ry6xQ5YdmzoLlNq84t5y3iW2xBZxotZJzYZjsWCYefAR2WcwiG4vdb?=
 =?iso-8859-2?Q?ZVO69chADr+XQLd8VVOgxtfJUVblnHKiq0dJ5E7mb7n5NA/bsDhglTwGi7?=
 =?iso-8859-2?Q?vass+11CLRai9T8WvfmEOCJGiVvzuuUd5FnHRjaBM=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: febd5df1-5729-4a6d-15ad-08dc96c29dad
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2024 16:02:59.2878
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR02MB7177

From: hch@lst.de <hch@lst.de> Sent: Thursday, June 27, 2024 8:25 AM
>=20
> On Thu, Jun 27, 2024 at 02:59:03PM +0000, Michael Kelley wrote:
> > Conceptually, it's still being used as a boolean function based on
> > whether the return value is NULL.  Renaming it to swiotlb_get_pool()
> > more accurately describes the return value, but obscures the
> > intent of determining if it is a swiotlb buffer.  I'll think about it.
> > Suggestions are welcome.
>=20
> Just keep is_swiotlb_buffer as a trivial inline helper that returns
> bool.

I don't understand what you are suggesting.  Could you elaborate a bit?
is_swiotlb_buffer() can't be trivial when CONFIG_SWIOTLB_DYNAMIC
is set.

Michael

