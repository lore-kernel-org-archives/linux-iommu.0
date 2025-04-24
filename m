Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4F91F6679
	for <iommu@lists.linux.dev>; Thu, 24 Apr 2025 07:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745480264; cv=fail; b=pvj5BPzyYb0fsEJcX066No815u2LzCQ29fmTgK92U+MG/G+TBkRuZycYpOAXgI3Jg7x0EDiZAsVyBbrWC5hno2t6ey1o8CmmQGWgW9ymx7CJd1x9AtY62C/HyyDPBHK5w55MpIM0Qj1Wn6IrpHTEh2prAJ//CusLCcrFUl0FKtA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745480264; c=relaxed/simple;
	bh=wkW+y2mh3IwxvVIFizf9stY+4L1uhjRiSkEQHJ9xJco=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XhAOzOMltb4tuFasC4QaGSA0oPiGCqPgpG7aeXfv8zIpubN1nuBVZ6bqOqCkIR3k7UDUDbah4Qp137Z6WDToNn1qvQX9cIt4rM+5KnHQkSmUg9X5recSpVky8UWWiCbJCB4eaeI3XCjg8tOcviWzUJERpnc6ly8XhtRWZY7Fncw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QhYtVzbH; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QhYtVzbH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745480262; x=1777016262;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wkW+y2mh3IwxvVIFizf9stY+4L1uhjRiSkEQHJ9xJco=;
  b=QhYtVzbHAt4i0Q4nEI0u4AIqO/rO0a1CeM9x7YQjnNSmu2BGU4w47hbs
   8GkzfRkMNjGCZOVe3Ohhma/h4UuUflMpMcdc7slcso3Hsues6V+EmLejn
   f1w1CPCyYid2csl7gy5iEL0aE27dqWHpiNosx6eermIkLACqubprUaHGb
   rcaQd+nb9rueHieOH/CSLGYd0QkDYZt2L3hc8MdUmLc0TXkYI+JPRjIRr
   UwmgIW0EtETsROXMPPpP2XEHQPq/ElrjyMK3wXzeSFhzUjSrmaINb+OM8
   4T2koMggaPZ8SGxJ2kVUxUJ8krMxAQxlsoP8VqHeOJT8enYic8ooXqutU
   g==;
X-CSE-ConnectionGUID: gZhoryWBSou2LYWXLzL4Gw==
X-CSE-MsgGUID: dTtnGAdMTZyg41f7C+h65g==
X-IronPort-AV: E=McAfee;i="6700,10204,11412"; a="46806263"
X-IronPort-AV: E=Sophos;i="6.15,235,1739865600"; 
   d="scan'208";a="46806263"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 00:37:41 -0700
X-CSE-ConnectionGUID: dZY+cCMnTXmmYak0I2Angg==
X-CSE-MsgGUID: nAXaLRRfTwWYwmEQJJPY9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,235,1739865600"; 
   d="scan'208";a="155770125"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 00:37:41 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 24 Apr 2025 00:37:40 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 24 Apr 2025 00:37:40 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 24 Apr 2025 00:37:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T/AmSoD9KnpuFlM7EQeF+NkzFDf0RNwm7hPN8FV360KkzUVVLEOs4VRNPHLh/VMpMw1GqlqXzYG+VgOjcepzzRi//WKuWTv2ELI0SD6WBqEaW2BJHODP/ZaSCGM7CeNn+SOPsFfzOqL1B4irjPzRuX/iAyRws0/G9SfTaAtY7YVa+UerHrNIV3Q2a23gZfI6pocj7u3UI/icEJIPLKID+TZOfulCL1z4tGGC16riV304S7jey8rbq6ZOAjYCFpGyJg5mIM7aE0oOCPcddznLO2Reu+OIqa9C5i9hV5gf5N3cwHwh3UM6o0PfO8CmYxXmgvU0q0+Ff2bbp13hKswUcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5DyJ5a2ryYt9WJQKkT1AihkconaBcZbzkR8uqLOFwug=;
 b=n+XSgNYHglKo3ykqPsQiNWz7lQZNSxCa56mm7LqX7HOKCoJ8d8Aa6NJdkeJHngnQuSV1htztAVTnWVRAI31VGLJrUIaOL04/7MF3lNArrOY4HQzAq2w+Zu1LFTykfE/XuW/98Z4t7KCoZaMpOADRxRDpuST8f2Mf4YKm0kfrYLMppyrOgfNltLY8WYAqttqe+VoXAGf1vpy42RbgWg8dVVpw1xrXNch9Ese8ldzkrpGzky4EPhokc23Vubvz9LPE3Ly3uiFgYfy6D6jvV368x+O3sgjeyU4mMvozb9Wppf5cvMHPgtildqryuc0LwSZrW0+ZQ5J5NBWLz4QNT5Vn7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA1PR11MB8801.namprd11.prod.outlook.com (2603:10b6:208:599::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.38; Thu, 24 Apr
 2025 07:37:16 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8678.021; Thu, 24 Apr 2025
 07:37:16 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/3] iommu/vt-d: Use ida to manage domain id
Thread-Topic: [PATCH 1/3] iommu/vt-d: Use ida to manage domain id
Thread-Index: AQHbs/00mkoEpAB1GUqfy7dQi2swobOybihQ
Date: Thu, 24 Apr 2025 07:37:16 +0000
Message-ID: <BN9PR11MB527656492CD69CA4EA0EC7338C852@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250423031020.2189546-1-baolu.lu@linux.intel.com>
 <20250423031020.2189546-2-baolu.lu@linux.intel.com>
In-Reply-To: <20250423031020.2189546-2-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA1PR11MB8801:EE_
x-ms-office365-filtering-correlation-id: f9b15c1d-0023-45aa-f524-08dd8302d67e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?7I5LVfIuq1VrmoAY7WWMCz4Osd3cuC76Ejfay79XlbIoVRLielUWJgbrrHGq?=
 =?us-ascii?Q?z0fKoY9LNQ60FHmuSKJXsS5wiOFwPB27Vgxs6F5gOfkS96IAFOMsOIi5KzoF?=
 =?us-ascii?Q?Jgv9pJTHHbsepwZVplxL2pD46jEVPAfKrYidyfx+gyuW5GK4gSoe8P1LZdkL?=
 =?us-ascii?Q?wDcSkseVb5sK/grqVLc4lkBmiPfHVtfKK+YNPHm+mWOsRgV29s4DV/imia/q?=
 =?us-ascii?Q?ppYqgAp0ZhusZUepaqz/OO19HAkooh+KtB4TRr02o2NS4ojHvYdFhJ2YvmNG?=
 =?us-ascii?Q?MDo6SedyOu93cI6P3Gu2CXZkmSsefgElRulu600fk5Yyy4LSNaz/RIW5U69G?=
 =?us-ascii?Q?EKScndMUrLdgsIy4ZWKY9PGvL2JvjU7aF/2PL1CDs9rlpqrlBd0hoZFbvCSU?=
 =?us-ascii?Q?D2J94NaaZySp6OsMR3nXqmRStjR/xVHAY8yQmFQlnrLiIRzBl3TxexeUIUT+?=
 =?us-ascii?Q?4iXq5zI4vqFWadHkzjaC0+cBsxqdzaoZWMZ7uMFrHad7hq61yyxIHcsPJGB/?=
 =?us-ascii?Q?lFlZGKqUxRQ7xUndGa/hdd5sLRJX7F1Sd1eadVtxLLfSV8tqQHR1tWrhtzHV?=
 =?us-ascii?Q?VbbfYjxLE9JcLtEWuRVVXfsPLKyxEPI/sbeYhCqpuvLx/8/ztD6fOjfsSpF7?=
 =?us-ascii?Q?KvaqHEf1GYam1lM9Laxc3FHWZi1TK50T6B/JuOFspexweYyLPSPrz8nRWpS8?=
 =?us-ascii?Q?OFJwxsE4ojr8q1tlKA1jJBjxDjllYB/NEW24JdD4lomPLZLVKMJSgMkCVYJD?=
 =?us-ascii?Q?xr3XKzxaER102eWGMzs28jAWJmWKvy6vQGlWepc4SA4c/g1kK01wrSPSFjwH?=
 =?us-ascii?Q?18nUr9ZaRYXrvNi56qBGgJ8+OnFshq/jrhxb8yK0TwPEjdmx1es2e5Kz620K?=
 =?us-ascii?Q?XH1/M/OB1RQrQ11JZO6E5zzL4wwgrjWKRB8qmyUp/oFHxF8ujci8gwb+vWmL?=
 =?us-ascii?Q?Lt2OckKAbqa7695zB9qsUsdMuZPWrFdNyzrvQ39b089oXIXR0mAuY7VarMuF?=
 =?us-ascii?Q?+wXeovToyv2vCCtD11vlfRelxph5xapoWhwb1a1SMplteaQ+wUbgVBxHNY+e?=
 =?us-ascii?Q?oJngI8BWGjyPeS4MX+m89Z4TGh68gf0S4k5M3LeV40RWLnSpNXTtDMjQ2GKB?=
 =?us-ascii?Q?xnbLkXNRbnFidcUkVlOBMWwu0qmCFhy/rX3YRIu1DNI6a7suFB7GdIAgzpd9?=
 =?us-ascii?Q?8ixLb0uZj95JzuH3m/9md+2JIkpIgalThb8vTh2VDJxAdiwNuhD9Kd4NeyPv?=
 =?us-ascii?Q?a7tpMpBuPj8o1g4pZvwM7pvkV08cVyXO1QGtaEZZHXKjcugPvBwiLdfLL4F6?=
 =?us-ascii?Q?nxtWRuBbcgiqRglVKC7jUSjwOIE0AuUQkl02zYksbUCjON6UGFQ6tKiNOOeA?=
 =?us-ascii?Q?KWgrV68ZBnywbVtaS+iRU74uVBlZhE/NnRfec60mFCh++alZ6GWMsC25SjAn?=
 =?us-ascii?Q?BkE7CHiamY3s7E9qe+3kfYmUT7B2Tzsg+QnM8hHW6q/knsYe/d/jB/ehP4Ku?=
 =?us-ascii?Q?HgZtsCBUrg9Bw0E=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lvfJTNLQ+Ezc3H5wzx5Wwp+qZdBIjrt0aKnF/5VjydMbRbnTyhJhxUOC+0pX?=
 =?us-ascii?Q?+DMs2GLky27MiI3pzqjBjmGRP/g2Bdnc+Pdfip8iJHqAvCCOoI1qm7G/0mlS?=
 =?us-ascii?Q?RmPMaRrKRfR95hnNk+VlZWW2yZbdkWgmUTdMOKj14Oc8f0vvNalmwlgbuPBQ?=
 =?us-ascii?Q?PlrD8Y3GEKvAsTtrwxfa5YOqPUodRxpSzvIeKKLbRQIaorcwqu0DkcFny0NR?=
 =?us-ascii?Q?fW9P1H4Nxix841uZnU3ZgnEq2DvM79t0aVo5dd7NcxbpvLhnzp5QPEireiyB?=
 =?us-ascii?Q?D2/5TqgI3Q4p3T8KJ4LTMHo5SeplFiurT6peFFQp/Gdb6bc9ye4cus1k6DCd?=
 =?us-ascii?Q?Y51CBGhJ8tBOxVkyf+UfhhsjSPYfExgD+wKBJConKOG2P4UBPvj7qUg5eIel?=
 =?us-ascii?Q?rIdX0ivWUvMIfJDb/2QAObvTYdRDBwAVsvIyjTPJalOqF0MoXqhSZs52LstB?=
 =?us-ascii?Q?o3hIqwDGb7Dc/EBiFeIcTHVhMN7oSQG/yVVbqS8M1HtBpKFm6uTmBgVIHwYc?=
 =?us-ascii?Q?ShCRSd8sJbiIn7Gm/mjwcsizPE5RHUShknsub9O03CaKF0GN/Et6BUTWsy1A?=
 =?us-ascii?Q?16h2RJ+jvB0BN2qDK7WNE7geTv+UdhoBTFFkzhJjFrsfrfU2+R+NTqa5q6Us?=
 =?us-ascii?Q?xEFgnTe+NJfj+ZGfY6ic3y47qt74h5ecCWuwJ+wk4UD2XSwDdjy6LWOUvtCR?=
 =?us-ascii?Q?qRGqZDbZ2o6tyMY6QdKlDqU1w+nzx0HCaYlyMVh+Zd5iwk/Jlz4d5ybt1st2?=
 =?us-ascii?Q?PnD/u6zotEOB7rgJAUSAOmXyrMzjRxsDur3ubPFZG6TZoDWZTOksM9tzBv05?=
 =?us-ascii?Q?5/dd31pw8dGUmlOBWKBecZxI/geJDOICXoOKi9NIrbDUSpywiRQ9ZdZvAPkl?=
 =?us-ascii?Q?aqMGCfzrRHIhj9Bq70dGVG7YZ/W+aacz69o2Kg+ZQ5Ku0tr8kGSOGUqsmr05?=
 =?us-ascii?Q?dOmmURiN1spEigiEczsnUUnBCnjlo93H9slz0XKYSKS+EylB0h+JmmibpYeN?=
 =?us-ascii?Q?q1Doe+a0FLeUQwHAajk28jYI79E55XDjN5M0Cj5bUD9Z75H8GD9JfNrIaaPz?=
 =?us-ascii?Q?DvA4qZT4E+W99uXamJjkLXI6bN5nZ7JN9ibUbUH+ZF7gznqBl9X2n28idU20?=
 =?us-ascii?Q?Pe9DpNd+gH9J2huCeUkkcFqpkgwREaTfcPboPjg0b91SG3VTeXqK2ryn8O0l?=
 =?us-ascii?Q?zt/V6lpRYRXqIFpUjw6zwLr5R7atEDdOVFqsUoOwfSJcfH9RoEGEykdgEhHT?=
 =?us-ascii?Q?eI7IGaQ36ZDU6dZx8EXfQqLRn1Rb5VKjyzAnCR8XXiI9PKLLu2PRfxMJ0ofQ?=
 =?us-ascii?Q?cKYtD3gFEwo4v9DJZYFxm1YlpT+EPISW9dBI151AY1BJKQA7aQZlBa2hpvm+?=
 =?us-ascii?Q?gKYqzosY9jFz9TG160H52OR5YHMn4IJMCDtE8pNQs/EFbv5sq18PY0+hG5hY?=
 =?us-ascii?Q?wgXopYeTQ/dJvQu+SB0sC1YIdRzIlLvCV+YY8KZbn+LvG9HF6rQWUhwLKO/t?=
 =?us-ascii?Q?ejB5kn9yscFgIxJ1HtNFVX+rUxnxRqtaFTMP/P7+D0QRsFDiPQ0HUQ9A2C3J?=
 =?us-ascii?Q?l1JvGD/gn+Sd4IPvwFRztHqC/DUHFrW9oVWHRedp?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9b15c1d-0023-45aa-f524-08dd8302d67e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2025 07:37:16.8183
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D+xuBPkcP+YoWxo9RIL6RgLiEWnG8g9aHDn/uvGKl6flIMBXWY0LIUZewQtLnKoI/asw2vP4bOaZOXyGzqVhtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8801
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Wednesday, April 23, 2025 11:10 AM
>=20
>  static void free_dmar_iommu(struct intel_iommu *iommu)
>  {
> -	if (iommu->domain_ids) {
> -		bitmap_free(iommu->domain_ids);
> -		iommu->domain_ids =3D NULL;
> -	}
> +	ida_destroy(&iommu->domain_ida);

since ida_init() is in alloc_iommu() now, the destroy can be
moved to free_iommu().

> @@ -1399,14 +1356,13 @@ int domain_attach_iommu(struct dmar_domain
> *domain, struct intel_iommu *iommu)
>  		return 0;
>  	}
>=20
> -	ndomains =3D cap_ndoms(iommu->cap);
> -	num =3D find_first_zero_bit(iommu->domain_ids, ndomains);
> -	if (num >=3D ndomains) {
> +	num =3D ida_alloc_range(&iommu->domain_ida, FLPT_DEFAULT_DID +
> 1,
> +			      cap_ndoms(iommu->cap) - 1, GFP_ATOMIC);

let's define a macro e.g. FIRST_DID for min.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
