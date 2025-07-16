Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD0B2F3C02
	for <iommu@lists.linux.dev>; Wed, 16 Jul 2025 11:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752664076; cv=fail; b=BtVYhpBIt58DMiL+5n02G6UPqf70zNCZTDvbysN0ij5byiMmfrOQzsriEZ3+5UwDvJNjr/P+03A4lrTOKLNRHTcceHP/WEMRT8h5JpTsgkrpV9RbCInTBrLA0w3QcbT3eqtNzzM5n9AIgLSspd2J2fWAoNyY19BDJYxJhVEiraI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752664076; c=relaxed/simple;
	bh=sCKFJ2WOoOdu4tmZ5CVjoKQvP1PO59hCwh2MxGrHzDM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J9wiRlV04ERtCtmNr3b9cw0bVOQ2fZIbRNyvWx7yI1fJ/DwKnuUhbW99+K4V17krStDUuI8ZXY6OtAwvUKnT8S8e+rBJQcneEpjchE5fWTcKzozCk3Y+AAzFFcScvV0dTBhHZ2oU36HeKtB1wUuy5qRf8EsggIwBkfROXBEDgHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VmHydvdk; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VmHydvdk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752664074; x=1784200074;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sCKFJ2WOoOdu4tmZ5CVjoKQvP1PO59hCwh2MxGrHzDM=;
  b=VmHydvdk3C3jPo+UTgLcE500CUkGB3KMaSspTrdWOFAxGa6qt4mUhiTn
   Vb/e/tbwdHdgDGsbG3O1XVmlhzIpLyK4KywnYero6uyBQIYsm6c8LS/uh
   CC7B8IT981rCSFJN5NLsRGlUC3UAK0w7mef7Bz7w3EcoTjhMwqWoHeMpj
   W5kzru8GpUalgVpV92tl2905HMQcpBOxirRW+CmtMs8aFqvitrG8Srq61
   yhlWFja5UYY6u86ZIskquPC7rfdOIHemo+hTT9DN0gLt+dWQ8wz9uxLGi
   YJEqlb95jDpWySDQGqFYl0PNnw5swPGAE+PB266XURLM0H6Zb8DAFiR4/
   Q==;
X-CSE-ConnectionGUID: q6Ee/52mS4mkZULGTRv6lQ==
X-CSE-MsgGUID: zEPJ+t3fQoqW+0Bf4PQK2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="58563391"
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="58563391"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 04:07:54 -0700
X-CSE-ConnectionGUID: t0fL5hadRbeHM8qdZROi7Q==
X-CSE-MsgGUID: rOmdgJNnS9KA/jqe5Uf/HA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="157966275"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 04:07:54 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 16 Jul 2025 04:07:53 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 16 Jul 2025 04:07:53 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.70)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 16 Jul 2025 04:07:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X3Dwkfc/eIZoYhtuziG8ZHFDg5NHPspIJ+H3j5ZBRiNXCYIHoM9ubgZbZ3fzHMSww71Dk1/O9BE1w8SrgbgY1bn19K4Bw5nn2TpsVQyGn6I0z8ivtP1nKgB7bZtDfBD+GyzeIrwXkKgUksIv5empCWEr9S/Sf3JsE3cXWHhptiEERmddyQ/fxFExFDbBSBtBHHlEpFZ+svpSGCLSn77hI+arKmWUlnw2T2Q/7A7xQXNPqY/t+dYYoxXu0PD477HxEZln3QhKsb+HSBt/CYkb0NJpslKx7Y6fYSzHTRMkvH99mEbkcbStrnukcoISQx9QGdb71PqKi7L3L82JkUWbLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sCKFJ2WOoOdu4tmZ5CVjoKQvP1PO59hCwh2MxGrHzDM=;
 b=rPlS8a86TNKFUquUdrNd28fhtbHi5xoofurEu72iOfoBySbJ3lVKpkCLO9V+zr2nYqQtVtM8NOlY4IZPoR+CHiOi112BEWTMPlSfk8UMBMWTrHnEWdQJKJkcrEQlA0ZNQaWCreIaFq8r20DO7gE1/PPUMIpcbm2jUCGgeW9V04ZatNCIz+AraIbQrLNGl9GPG4xbiSHEHzc2NFx+eIYu6YAKIah5Cgdo2xX65qWgLXxH6ptOB1FWphw0KZjQsX17XlrHHVgaQo7NAJ0/gMvwqkUB9IanJR4PRAsHuYjuZJlY7AUAF81zsqttsYVRo+TL8gKpakQCTy1nygY6KdtbSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW3PR11MB4681.namprd11.prod.outlook.com (2603:10b6:303:57::14)
 by CY8PR11MB7825.namprd11.prod.outlook.com (2603:10b6:930:71::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.30; Wed, 16 Jul
 2025 11:07:51 +0000
Received: from MW3PR11MB4681.namprd11.prod.outlook.com
 ([fe80::6561:fd02:e89d:5b06]) by MW3PR11MB4681.namprd11.prod.outlook.com
 ([fe80::6561:fd02:e89d:5b06%5]) with mapi id 15.20.8922.035; Wed, 16 Jul 2025
 11:07:50 +0000
From: "Temerkhanov, Sergey" <sergey.temerkhanov@intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "David
 Woodhouse" <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, "Joerg
 Roedel" <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>
Subject: RE: [PATCH v1 0/4] Implement IOMMU SVA page fault processing error
 notifiers
Thread-Topic: [PATCH v1 0/4] Implement IOMMU SVA page fault processing error
 notifiers
Thread-Index: AQHb8aCEl7PcdxwiGkmkehlQMUvyGLQxu9YAgALjbZA=
Date: Wed, 16 Jul 2025 11:07:50 +0000
Message-ID: <MW3PR11MB46813837E82395797CEE39AF8056A@MW3PR11MB4681.namprd11.prod.outlook.com>
References: <20250710134215.97840-1-sergey.temerkhanov@intel.com>
 <20250714145658.GH1870174@ziepe.ca>
In-Reply-To: <20250714145658.GH1870174@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR11MB4681:EE_|CY8PR11MB7825:EE_
x-ms-office365-filtering-correlation-id: fafab2f2-57f4-48c3-0ef8-08ddc459012a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?Nfx3svyP1lRzScAenVM5dgxVQFzkpnOA0pfgA7BviAToladpn93KSfdov82s?=
 =?us-ascii?Q?SpvobpanLavNEJanrmUrF04VO/Pfvt6wxmzN0wahH254N18k9XOextyqO6Nk?=
 =?us-ascii?Q?mMibKmar0VIjzFHjy8qCjonuXwnIWXejSMKUCz2bagyJtpRW/RFR57tEumgP?=
 =?us-ascii?Q?sY5Rh1+hPN2X7+8EUfHYgqTfqs52W+uyAVmMbkoVprqIXgDJ9z+w685+ZdKp?=
 =?us-ascii?Q?8qK1FOzBMDAXSd1FWbBjcjoX31LU1UcekJX+9ny1c90WNB5yOxsXgkUEEDe2?=
 =?us-ascii?Q?1we6oIBXoCsX5GcpZWa6i5Fx+SKL2r2gGAjTuix/li0tgdEFYQWhyOICbCPE?=
 =?us-ascii?Q?8sum5z6olVCPEiKs/+ljwe6RP/mcggK7LrURIz6Ouc9GZubW5AUbVMc+sA0Y?=
 =?us-ascii?Q?TCPpXugIPtaV//WylDT555GY54L1MjQVYiR8nwaS+WwF5nKYfFnrQ2KY5jgu?=
 =?us-ascii?Q?GRkfktAEb03fsDLh6gd+iylwhlj/kRRzUFjcp+P2FdEC7kuSIQbvOb3u8UGH?=
 =?us-ascii?Q?Y7qgsYi8+36fzBxsm9obW1XHqcJgVq6BU9xdpKKdJYkFvbdILXkRMbft32YI?=
 =?us-ascii?Q?OMZhZJPU7dCk97ixR7vTBW4Omyj9RjQ9xhJsqi2P/cTZvJjdHKrEg0SNIcJ6?=
 =?us-ascii?Q?731AsuXWlQa+TdbQq8JAFC+AHqKptGiC0pXOVdUDaEFQMFP0Eg7p4/yhMBOa?=
 =?us-ascii?Q?w1fLvabie98cM8fI3s7F0dELxVXWIZNezJBpncCgWBTl268VZZofW/vwC/5O?=
 =?us-ascii?Q?mmHlg6a76i9+8d4y9yQIt8PMzLTjBg9h4MnSakz0jEfz1IVnnRR5lm66c9BC?=
 =?us-ascii?Q?DBr8+yBMngpaDDdsdNyVXRnDKxyD3SMcGjJ1aLbrkesB69PcmIMha1/2MdyK?=
 =?us-ascii?Q?oKd/ayCrVPOo1bIPGXZhSudjOSkfLbE1+lTFjhBmn7aSr2mC6d3Y5MR5fAhg?=
 =?us-ascii?Q?lPo2Ki0e2BAQHKAl9OKD6LJhBBriPIz7nc/MInfdCxHqOZmD6fLspk1JAJ/X?=
 =?us-ascii?Q?hvB9Ia3wpTkt12DIF+v/3Lw/RPD21W843qXKh4GyQAanT/rZMrpvYxSuokum?=
 =?us-ascii?Q?XfsrO4+UnLk8//uO0BGt92BFg9I5KL8oc7JNHFk0kQEducX1T5dpQYvKcqAF?=
 =?us-ascii?Q?Bid6nFeqsFJ5o9/oRzx3d+V6BsETrt+o/ASPqXKlFpqcnwph2MQ/2RjrTJs9?=
 =?us-ascii?Q?MVr1ojPGMsQJngik50JlXU7SFd+1l8WxB9IMLt9bok2VaNip2VNjOrbCLZrb?=
 =?us-ascii?Q?RkfWkNre3dCBXvdNdOa6OdqAKFlLkdRLjEq3PC0HGl92k90jWzWxFRlyL7lo?=
 =?us-ascii?Q?eX8QsEST/mEgH90VRwKNiz2SoVsCd1cFqiw5r2iXPH6Bqi7kapVso5LQxkPT?=
 =?us-ascii?Q?VVcWpUbCvS8czvm9ZASdcp3GjTbZI1s/zywUo6oKh8DL0Dk3TMiMGNuKJI27?=
 =?us-ascii?Q?RJjg+HLDRjrWUaQX2BZCxLCzWTJ18gVRubPFNLS72RhDYLm8Is1WfncRPdJ5?=
 =?us-ascii?Q?kr1Y2Md5Pr2rF4k=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4681.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QLqv1FeqViRvP4TTlXz2pNn1C9yvPlz5Itn/elOTz6ihb4YC7b0YPPfxQnpf?=
 =?us-ascii?Q?J1R3zKZJDXlFVwCbaNbaH7+Vdc/k9vq5ymfUJjAkYpL/DreTWunRvi4iqEvH?=
 =?us-ascii?Q?LUFt3MpbjeqhnUXSshcQ99793CktIwCntEz5fPCx2hIN9Xy1bmM4Ccw4KffR?=
 =?us-ascii?Q?mLS+Qfw0hWUTYjXOTFiIMGsnh2ZXRP1gwVvSsatRBDoqY4LjRqUVNdvU6rrF?=
 =?us-ascii?Q?TmWAbCaDscf34B7J+EYqkNvjaAEP+wuyAw+RpWJFsSqkSWTCYgLku4WZdo/Q?=
 =?us-ascii?Q?OHAOxCHLr9k9J3ZJ90ziqz7Wm5fjgduyX1UrKqBA9syUDkSXuX8YusLD3ejq?=
 =?us-ascii?Q?sznixQMZcsrTr3J4SqyXK8OazpRskd+MFkmxgnYTteX8BCdPrXNaMrM3rRvD?=
 =?us-ascii?Q?ZjFMTXlwlHordkQEIe/h/iKvYFJINxfzo1b0E02Hf1hsM8ojMZCxq9QWvA27?=
 =?us-ascii?Q?75JHDkj/ImoQZS2eAyyj6EuAIn4pET/gJaj+Dk3u8eZ7vVGEoloB0+hazbnK?=
 =?us-ascii?Q?1y9KL/fi11COPfvh25Xaj20kyqJMFvDOSd0IuStQY0UHZFv0ylUhAwiSgC9i?=
 =?us-ascii?Q?h3rDQofKSimZVQLAMn62CekmsOV5ikw5HKbBGH6BBTBH2giqeUDBNhdM1FIH?=
 =?us-ascii?Q?GuworsIceAglROwqy00+9oqYHJWs0hIisqL3S7dJiTjAHWZ4tZ1WfvCbM8RW?=
 =?us-ascii?Q?oZnmdAqX4fLN8lsrTTPcW4yC8W4s1eAOtAxLTqVrXIuupAKwnAGaisY5NZNQ?=
 =?us-ascii?Q?3namK+tmyrZpyJjwDLae+6SooYnksGyJjL7KS+23LQvcumfIMau1/QCxmHC9?=
 =?us-ascii?Q?vHljMgTHSs7dB6EK+f37NPNM8kbwxxkwXHFfpY0t0U2rifBNf/Gkja5pu0Mh?=
 =?us-ascii?Q?zSRJ+HbaKU+hb6Nc75MSApoav9vZx8xiQFSTMu3op8KzLC0XPrRsnU1uPzj4?=
 =?us-ascii?Q?DlPlqnJ1EGN+X+Ek8KAMDhKZlDrGn9hgZdbMlMwXBRpcnzGup+L+XkLvuf/p?=
 =?us-ascii?Q?odgsyd7yuSHR5w94ftufvjQvb9fxah98vRon6dzc49wWqxjHt+vnpJh+/7Ji?=
 =?us-ascii?Q?6u6u4pUsxZBDd8XSFD7TT3Bzt8C0muXYpoulz40AcNbZh/PxAf5xozID9Cce?=
 =?us-ascii?Q?uzk31fCeKt/JbbgIQ99s9vvXFPvEgORLsUeqNZGK6q0A15FxZkcjV6Vu82S2?=
 =?us-ascii?Q?6PDdjUdmancDFtKC5lFKegEzptqlkaC2iMTjJag9QjgnqQxd7ABPZ3g2w31g?=
 =?us-ascii?Q?VvgTpnsAAH9u1XWSx7IT9oI4bmH4CbGPGOdHua7mzFfCv1CcModRd+J9zHMz?=
 =?us-ascii?Q?cDRW4+eWyZMcrLX9VsTAV9fpyPjSXLXfI/AKaQGfqyVNF4lbyI/ITN08ypgF?=
 =?us-ascii?Q?mSPQ9c6F3hLhqKD1Noj/2hvHye1BNMqWdtuFpbhTy7qakT76r84XrGxdDQTf?=
 =?us-ascii?Q?2fgY45EnXmJV9/KlxqMvrb4glH+Aj5ZStug0MozQ0PjHWCVpzQJq93gbStgy?=
 =?us-ascii?Q?h7+KuHNYXOob3l7sG+T42doAQc9CrOBai7tgIaII1Gp1P701k6pZQy2ZQCVS?=
 =?us-ascii?Q?90NxQ0stML4175Esjg+1e5TmWXER0N3Qwi5sUlBB?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4681.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fafab2f2-57f4-48c3-0ef8-08ddc459012a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2025 11:07:50.6825
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u/V0UOSeQwViZdXFePnJ8QG9MTlArko7o8HK3SOFpu2QtBP2lVJr563ogizoLK5Hk2CCbJl+TMt2c6r34D6be5Z2ANJ8DjuO22IH/JLtLCE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7825
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Jason Gunthorpe <jgg@ziepe.ca>
>=20
> You need to come with a driver using this as well.
>=20

There is an OOT driver which would use this facility do report and handle p=
ossible invalid accesses (e.g. mismatched VMA permissions) during the SVA o=
peration
https://www.intel.com/content/www/us/en/download/858019/intel-media-transco=
de-accelerator.html

Regards,
Sergey
