Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52864394496
	for <iommu@lists.linux.dev>; Tue, 31 Mar 2026 07:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774941580; cv=fail; b=ct/lEkQVhZob0jG7vbALEVl7U450fsIguXQWrLwOwSAMa189FaYD06pMmvHUA3j7+aQ6E0nMk06yasKhPBqPpnXwLUQ0V9a83L+b2b6nfGTBvjK3Mu/vFT3QgO3KS0RQw5gB9hI9Zfjqy4vVxCtFTrix0XqZX5TdeEDER6MdNac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774941580; c=relaxed/simple;
	bh=1hW+I3TMtS2ZKNJyczwPL8gUyoeGyRVLJpRaNaatzNg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=F5wJicRDTA6MPI0NZj+nMONiks9DBO/Vk/MGkKMHG/ktrI0x0aWN0Ft+8t0aeX3VhP3dvRclpmfuxOb0p/nHLTTTuisoGtmtS6xY+WXqYW1nRu8HZlUs2rWTzz1r8UchMThAP8uq+jLY7Rmp8t+4hfRY6ANDVQiOIuS6eqmE0EQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O8N42qfq; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O8N42qfq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774941580; x=1806477580;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1hW+I3TMtS2ZKNJyczwPL8gUyoeGyRVLJpRaNaatzNg=;
  b=O8N42qfqh2DnADDHLHycJPXrW2MDdVCEbZCG93jenoknelJCo4wpGtjM
   dglsQP8bSA+Vq5nPzoz1Q70Kai1kTBVtJPVqsoE+OgRyFt5law1fG5e+o
   XNduN1xGLnGWqQaijks5db1OADJsqBi4l+4narYvdACfckPhW9iy4JkBk
   pN48gEu8SDTktcyYrv/SxWbHjLfzgWaZIxFm7vdoR07jlm+D/3YXCQ/m6
   t7S3fP0o4yL76M0c3oxlZwYNkTMvtFlTgCVxwD/3KHMNkIcmpanNm5b2A
   NSyuo/v/GOZtBrT6Vmp08PThHqfIqUYsKyDo+oVLZuitT/jP46No+t9r6
   Q==;
X-CSE-ConnectionGUID: /n//w/i9ShODr53W7mK2dw==
X-CSE-MsgGUID: TFttw2hlSIqc41r6lEhk8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="86245316"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="86245316"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 00:19:39 -0700
X-CSE-ConnectionGUID: 9xe0H3FzSPODi+KepBmAMA==
X-CSE-MsgGUID: czG6u/VVQ4KXPyBRU6g2ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="226161768"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 00:19:38 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 00:19:38 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 31 Mar 2026 00:19:38 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.48)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 00:19:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YOYvEDvtXDf1zKJiMhFz7Gdk0LWffZniTyjuHfxJ+6/Gp5NZlwX9vS6bA2JqCQDhWv14JUXWoscvSQ7q49WhXrx8oXpVvY3h3TPRW9tO4B130HComyuDVbJOHIrLsAGVNypxZKN+z4yYa9ZIhDlUgBO6zJJN2ajP9RW93+y2MmZfUJvo12BEcCExcU8Ef8o/ZcZ/E0yq82PIBO7FEphwegIUwX21KQYXebeo1Mn7+F3nhKS1OeacsesWRlZbYHbWzVIuuS9PiY98Xzy8JZT/tqxDl/1mF4aSC44qS5QFdHOytbwTuNondQ5nR2UaVJu3ZeliLKgb8zxB9l79uylGwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1hW+I3TMtS2ZKNJyczwPL8gUyoeGyRVLJpRaNaatzNg=;
 b=HgvVIPfNR8iQsZAPXUrXdViWePSUVHF7iyUEgFYYtKLx4QQMlq4ieMdxDmzgBEwmP9k8vV0Af5ZJBlOEcMgJPykRulBKz/g1VKpeiLR8PCatr8gVY2Fu10e1SDuiOTKhaSaI9aJnnpGYFakrBpn6uXxKy0PQvQeRfBxlCUKlK0WTgNIe2iYwMf4mBakZEn9G8cm9P71KCKwR0BuSLtJvaUU7l0I3i2a4VyDN8cFSils74GApI7EGXLyRufbFWmZmImmFSKwnKI8x1IDuvLY7+d+/Ynfs5wCi7+aGKNIiX+89EnM/s5GztrvSeI4VsvdG2/pEPtQ5O2UHs9OqG899Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BY1PR11MB7984.namprd11.prod.outlook.com (2603:10b6:a03:531::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 07:19:34 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f%5]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 07:19:34 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "dwmw2@infradead.org" <dwmw2@infradead.org>, "jgg@ziepe.ca"
	<jgg@ziepe.ca>, "joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org"
	<will@kernel.org>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "Liu, Yi L"
	<yi.l.liu@intel.com>
Subject: RE: [PATCH v2 3/4] iommupt/vtd: Support dirty tracking on PASID
Thread-Topic: [PATCH v2 3/4] iommupt/vtd: Support dirty tracking on PASID
Thread-Index: AQHcwC2VvMaBXrgIb02i18uUB8iH77XIPQlg
Date: Tue, 31 Mar 2026 07:19:33 +0000
Message-ID: <BN9PR11MB52768F720669177F49D84CAD8C53A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20260330101108.12594-1-zhenzhong.duan@intel.com>
 <20260330101108.12594-4-zhenzhong.duan@intel.com>
In-Reply-To: <20260330101108.12594-4-zhenzhong.duan@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|BY1PR11MB7984:EE_
x-ms-office365-filtering-correlation-id: 1aff795e-3146-47a7-ed61-08de8ef5dbda
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: GhCqyuIdEQekPJyCWhJgjZokioHA2xfujIzVs3EKq+8uCHBrtGIFxs1VhQBbYXtUIhrJgvGGAmI7mG1rb9tT0yP5q191cSWa+1gICHIzNs5dX00j20Bb1eVkmCA7dZz0c7U14MIXOaa4NUENGoC+nO59V+vyQuiOf4QVZTncg8spipCsWkhbocr6BXK/8ImUAf7kor1RXAfLYyJ7EQ4a9lQn3k1y/DffodR7at3fGuRCVwL+CFSSQYAWrReG4is8TpLuEcGtSz3UJoMMuD0a7vpCltCaMrx1mJQ5cm+s3wQK49895LysvvYa4CklENPwyV9tKt3gsLBb9d5LwgTwFNvzLFWx4NC4XTd7tCRNuMRb+E6sKpG5YDys9qB0xXvDnEmE1QWEuZNLnRH8zNbqZ5Crwu5Xo7UPirVDagWKPlh+zHkxTd249gHv+3BXAPERxDZkz9j8vf+hgCtfmF12xe2xrSLX7ueBeyPdSqDJrZh1HlUR8PBnw/cPPKwS7673FWmZuVX56gO/BluGp+DNiAY3M9GOdHY8zNqVTOhld9+WWh00vxntbQWRtXBeEgA7brYvD3H8BlwDwmi1Im8Mk216SWm4Ts5a1mMEHgGPrz4T7kPCXimAXxSXUT2PKGxKb7j/478h92zu5m6dGKpJxClrbCVw9XoUZzENr/T7L/mNFP9wSVSnl5Hn9izKXKfRM04Nl5MAVdoiZpAU/KUiLuq+l0oY2X6LtO9H3jQgT4Kw7lX7vDzfZrkd77d5el/d/P6IlRzFGS/8LhpyTvXeocRYtYuAZAknQqLM0uNRVRE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4g2930yHLIT9Jb0neqIiJIwqztPdFFp8aTFZA4iPTnlRu8UjbaxvSLjNefZj?=
 =?us-ascii?Q?rH/kWJyGiLp3LSKxvk/NXdZ9iDtj7kqjAn7AWpBG7+B33cLhAK1qPUMD74Kk?=
 =?us-ascii?Q?Hsj/Qf1ipX5UHSNhY3Y8FJhmb7PKj+XOMyAoKbzIUIMSR9DxfGuy+1YqWDbk?=
 =?us-ascii?Q?fXEJeRj7XiMNgXP2VTQA5oqsquuUzWqZrB0F+IPYCUD5jsg6htoXlREsVbGB?=
 =?us-ascii?Q?WQWS3QBAuZDdkBxtD6nOfl9H9rLwTZwD+dfTbYyQ3d8Ev/42UkT79up/MS3l?=
 =?us-ascii?Q?zwIicSTosmtvUgfAit3Llyk5bUS0ye+0f4ewmxx+1lk7dLRkv98nRYfzIXDv?=
 =?us-ascii?Q?gReoBHUbIEtPzyWx5/JOjfZoiOg3AxCPbIVFrc0v6UZWR4jyfFqT8Sa8DWX6?=
 =?us-ascii?Q?Bpzve2zT61bGDsLIKFtaVN9HOIO82XajIY5jluzC02APmYHb7Ah7DwO4PFLh?=
 =?us-ascii?Q?LarsaSN+APsEBHGazjYcJauNHgmBpTQQR9lzf7Xf39a+m+oCaedFNFeSvbAa?=
 =?us-ascii?Q?wjxAbVv33RzD5N2nGQpJNyHqrZLZG3uPBed2FBE+A6elOfzRk4pPP0hJHwld?=
 =?us-ascii?Q?E3xdm1juu7rvPVC6qRK7VEFQlOmhwj8AuKw8GE4aLo2GtqZQAAcJ7xzqad/b?=
 =?us-ascii?Q?F7vY5/zVF3GNjhx939H35Wq/Kgxs48L7bSiMZCJdjhMqh41MGxGOeqRfU68h?=
 =?us-ascii?Q?kO3EOL01xOdDM29Z3Mk9s2WlJ5PVARZWoAMKvq6p0GKKM9ooZSm74UJ+F5kJ?=
 =?us-ascii?Q?iNbdytkwfRf9Q0B1rvqBNI5N1QLzK+x91AHiR0aOVYdQzd7rsdIHxY3AlHYV?=
 =?us-ascii?Q?fBq/zLNHQMwLnkVSiF7KG0f5l24GuWyqsv70/D/0R+bonwW3twCVKZgwUGi4?=
 =?us-ascii?Q?hnr4m/Ooc7vtiF8NDC5LtXuwf3kXysvhsKicdBGKwtgyEXphrV3ncxjYib9G?=
 =?us-ascii?Q?SvCiZOcP/mKqC+q3OP3RDWj8U2siz4dyWBC0psabBnCzqVmBn3ofdhqf/o1p?=
 =?us-ascii?Q?Il46TFHwj+MHUkv2o35w8bGyZkRY100IKkFR5veh98GJ5+RgLFXQm4dKukp5?=
 =?us-ascii?Q?D0chVDcKJ05ggfeEWFQb7842H3t4G7CzzzV1HbdcBXDasj12veTE4qgy31Pz?=
 =?us-ascii?Q?5h3Rrsx6TWbHdvehSF7n4tnFg0So/rNbxlgKgpqo/ex0yLyvqo++JVWHU3iI?=
 =?us-ascii?Q?yLdLI5F29P6dPVwoXADD6bRmthvRqa6s6eIWrinIOrG+hbcx9eENw1j92Xpe?=
 =?us-ascii?Q?RvPLmXYbFmqyBEOI6Spv5SvEnHmpofVq42L+CJqDhVTNbdMmHpYoMUJO1kfY?=
 =?us-ascii?Q?vk/4/VOeliabVMJSHAGC01OMG3ICerhcxozIHFSqtGvV3akdeeGkG4aJ5lQi?=
 =?us-ascii?Q?kqH+96TJ8tx6qkP/jaSXAcqAZdAw2LZtcx7Em3hNKuQfhIMo/X2ny6/vEgLY?=
 =?us-ascii?Q?EC9xYD51U8oQcOUTJEk7tT5Ph8kfBjFTNzPW/2YFcH6qHo89gd4bq7vzU66A?=
 =?us-ascii?Q?gGf2nNrcEntyeS2iYBN68drHMsAwNKhhVshICeEmCsZ2/UcjEYLeZgE7+MHv?=
 =?us-ascii?Q?dhM/I5WLA3Hz8y6lvbZcMCn6ln79zvTwFligtme/Rdkic4ObIfVXo2HyAbNa?=
 =?us-ascii?Q?8d6OBw1vUHvpr61M5AafoMldK4yP4xZdQ9Mnl0GSneE7oCiEY7+tr88hd67Q?=
 =?us-ascii?Q?drrmLnmkKTivVtpzxBdK0l9mIlxooXFcnvVHgEpSDc5/ePu+?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: eijyjonLlsxvuQvJwjgV5h7FuKSOep2YhidNwZmdhWeJUSUSiDEqxt6vbq2dOCotYcFtfDEWaRZa/v9u9RCbasWT+mgiYGhn8W2DWGiqC/avO+NUxx0Df8HhtU95bUijMqqEiwepKosbEAfeUroWYGk9dRehTBGowtRxnSafh/wRaiEuFrEncBwLK3g1H5BTd6LuM1NXXccVabzAwX/jSBQ9etm5PpTA0u3VI2ncDLshAsxumXHNEZaPF79rPJkETifKWoQXXc4CpRRdQzf714KOZW5YD1v01ffJaQi9NrDk+XQJkfId3TDkcpYABtlw4jMq5oHyNwAZzE3YeWu9bA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aff795e-3146-47a7-ed61-08de8ef5dbda
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2026 07:19:33.9347
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oc67pSlW3hd49gg6HAFI8S3Plt4QBm4Pi0nVIXlSPoivz9Q6jO5q1oLCacFIBMDLFLIMNAIOVkqVDOPCsDaHsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB7984
X-OriginatorOrg: intel.com

> From: Duan, Zhenzhong <zhenzhong.duan@intel.com>
> Sent: Monday, March 30, 2026 6:11 PM
>=20
> In order to support passthrough device with PASID capability in QEMU,
> e.g., DSA device, kernel needs to support attaching PASID to a domain.
>=20
> But attaching is not allowed if the domain is a second stage domain or
> nested domain with dirty tracking.
>=20
> The reason is kernel lacking support for dirty tracking on such domain
> attached to PASID. By adding dirty tracking on PASID, the check can be
> removed.
>=20
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Reviewed-by: Yi Liu <yi.l.liu@intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
