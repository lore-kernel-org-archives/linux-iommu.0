Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79969195
	for <iommu@lists.linux.dev>; Wed, 14 Aug 2024 02:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723603149; cv=fail; b=h3A2t/Vhx8iyoxWV7zvc3chdcSuOTN2S3qxnlygs41h6CKsaSN+GyMAsB0MZPM6L6N8nFsQIGaDenvBn7FG10dBKwZsCpAz90o4GZXBOU7HpAgKigWEskNIk0vFVMzzl2xTJQ1Tf4McLjqzIr8Gw7Nrz5/G/AQvoKLsyTLvrmGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723603149; c=relaxed/simple;
	bh=L/OrIvA4UpcfIVzR5LAW8EuUrUBpIDp4zxWWGu9oBck=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dk/49C6jnhmwwm9s8efr70CAyXvFiA3xvvTbax0DXbHJL92ts3A2XAhFiLEGyJZwxEBpG/LlbR/jwPVen7cjilj+7c+JeZiHwjLmAs/XCWIFEyqFO5N7XI7Ka2eKkuqlPBygENbRynn/45VR3//SDOYgrqbwbQEsD2v854hlzWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hzedsijJ; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hzedsijJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723603148; x=1755139148;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=L/OrIvA4UpcfIVzR5LAW8EuUrUBpIDp4zxWWGu9oBck=;
  b=hzedsijJOPvFM495jhdAQRVZLroekMg9Xvox4EXvYJqA7JUiIjTC1tMr
   faFF9EPc9uLf1SQJED4/oXErwgt16IekMfQEc+lHYKdAuUf1L/wHkw0Bm
   uErBUjUGHRzoYlzHJOoBsPdD45sgeG1thx2KWdq3fiIRt/cLiJea785Y3
   P7/qbeF4zp+wbul2dWm3YOeWMtoJGkCMOvDJJ0ySirn/H+3u3uRykt2EF
   CWQuZzzvlKxzw6iFChj3y1WcmkFTHKrazUuLHyxP9ZSLu6nM7pc0xWt92
   j/mhtEQD6De7XZf6zqzQUDxvTpKMQNI5wL9OuIPDiwNyEnHsTge+us256
   w==;
X-CSE-ConnectionGUID: c+dhMkbJRga8BKfv1AHxNg==
X-CSE-MsgGUID: JgNOaHaZQ1eLncHApnLp0w==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="33206812"
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; 
   d="scan'208";a="33206812"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 19:39:07 -0700
X-CSE-ConnectionGUID: JGwCORzFSXCqpPzKWRHuPg==
X-CSE-MsgGUID: LLU1nNg3TqydZGOil6fHOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; 
   d="scan'208";a="63795704"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Aug 2024 19:39:06 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 13 Aug 2024 19:39:06 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 13 Aug 2024 19:39:05 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 13 Aug 2024 19:39:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gW9rExGbPiN96GydmUZjr0TMG3IDGfjGLN7+j8TI4MJskSYj+G2p4Sfs72NpBvlKEwVeiJNWh8c4lzW9jpgWnT420bShxyVmLocumNaZZ5IAqjCZMB8NBZjdVNk6kqZFVTN4dSsslX9pV7Zpi3P2X5G3pA34n3BFm3Zbs/8x28yGEgT/NXv4koJfYZKROj4IkMkKfg3QHvVSTNfb/L1VYYgge+frg8CelUR3XaRxIB7vpJiF1SF4uP7W+8tho9fhx9ARqNSUrJ06f6oGAm8vQupJN3dPuJPUft5gi1cLoi9hbjcZHcn/Sqt4Zv+OOma1EOiRlitLPogRzluShhRMNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OnSX1FaYw/gsOSoHRplOrvxJV8xkhJuNbiMADtco16Y=;
 b=hPHTyHf12Zd9C3Ox8VUd1lsUedR5ydVxWgj2UDhm6qTG2z0P+hnVElTLtN4NOdf5pM6uKMTCaSQkQvojX0nbswE2Lwi6+1LjwR8oreytTWYQEqfyQ3e96W7e50LHR2NMn9r0JKOseBHLiWGZw/Ls18Z6ZaSsH6vmqnDXbnWJOuTWuC+z9eWDfPqJQz7YXohpDGGnW6TDMJfYaB3/NGnSq2zgNZzO22bX/FLhhK7WQZDGY0dSZ0w/IeM5f+eIc6OodqNJ17AOKavHgwNrTaaytCKxj6YCXMgAoHVEh2K/Y3opHum1HNi09eRXHCBt6cGZM1BTaNRXr7Rv2Foq6yf+Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BL1PR11MB5304.namprd11.prod.outlook.com (2603:10b6:208:316::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.33; Wed, 14 Aug
 2024 02:38:58 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%3]) with mapi id 15.20.7828.031; Wed, 14 Aug 2024
 02:38:58 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: Vasant Hegde <vasant.hegde@amd.com>, Baolu Lu <baolu.lu@linux.intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "joro@8bytes.org"
	<joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>, "Liu, Yi L"
	<yi.l.liu@intel.com>, Alex Williamson <alex.williamson@redhat.com>
Subject: RE: [PATCH RFCv2] iommu: Add domain type and flag to
 domain_alloc_paging()
Thread-Topic: [PATCH RFCv2] iommu: Add domain type and flag to
 domain_alloc_paging()
Thread-Index: AQHa5CGX7pk7CM+gYUOgDC4/LHbhALITIeAAgABWkQCABrldAIAAI1SAgAAv1ACAAQvCAIAASv6AgAAwRACAABtSgIAI1n1QgABzcgCAAKNe0A==
Date: Wed, 14 Aug 2024 02:38:58 +0000
Message-ID: <BN9PR11MB527654EBEFE7CBDD37B7B4068C872@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <8e531f39-9d14-4d3b-8a52-c2e8ca026f9e@linux.intel.com>
 <098008f7-2b3e-405a-a096-947e5df560e6@amd.com>
 <20240806123452.GE676757@ziepe.ca>
 <6b197aac-c38f-4e6e-9d32-d74e1a5b3968@amd.com>
 <20240806173230.GS676757@ziepe.ca>
 <bbe564b6-5079-4973-8678-1068a53ddf70@amd.com>
 <20240807135915.GF8473@ziepe.ca>
 <e5da0709-86d3-4b45-82cc-d995a2686afa@amd.com>
 <20240807182947.GI8473@ziepe.ca>
 <BN9PR11MB52765C37F5401E9AA7113D748C862@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240813162044.GI1985367@ziepe.ca>
In-Reply-To: <20240813162044.GI1985367@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|BL1PR11MB5304:EE_
x-ms-office365-filtering-correlation-id: 6b547706-f672-4d91-b612-08dcbc0a3fc4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?u/7hBn699rXbAxwgPQxxnOqLK1eUwprGa1q1/hUNUU8YTEX5RKdfEN2D9blJ?=
 =?us-ascii?Q?9UuCYEziXiK8Se7A3jgLFQdWt8KBYm/xMOjK6toI45d3q6GTFkuUgsVOPZVe?=
 =?us-ascii?Q?vqmq97lTvCvGWZBj4BmcBCyci/vI4gOD9iLc60oNDXZhQFni0uv9VtTKSLXj?=
 =?us-ascii?Q?h2S7F+yrqAzD4Lmtk3rIMKc94803QCn8BB5F/fEcG+WFAdrnhJh9CDmBwVGt?=
 =?us-ascii?Q?02Yr7VqKShBhlWfnSMAOD1Mh3Yya73BP5L5Sk8DEtc7HqsHk/4UBpaSre3bt?=
 =?us-ascii?Q?QDtIVxRLzQgttR+6ab9WimJVPNyhIjxX1BOYHaxnNxbZ6VCO6KDIzxVhk3wx?=
 =?us-ascii?Q?wwwj532O5NRY9gyLx4Vv12kdg5cEC59Q7IeFPo75EXwQJ8p61cC+Vi50Wwdq?=
 =?us-ascii?Q?S/d5R5oqJj3SZ6TzkEFUcF4WMINAAiU29W6RyxseWmg1I1zrHzy8fgIplIC6?=
 =?us-ascii?Q?Y92U6ctVrTPU6R7/j0o5wZP4K5kFmF5ZkAPB4nCNnse58wPfp/Wdhgwc//2u?=
 =?us-ascii?Q?bSiakfzhKdTelRRZCQYSvTH9ETD0BX0JAzdMEN4fugRf+jSruGNI9zB5Piyq?=
 =?us-ascii?Q?W/fwHh8MKRypgd7A5W6bmoB+7UFUzojEqDtYrWAhlkJzP6V4PiJEvFVPjaWH?=
 =?us-ascii?Q?jUfr6ILcNeNdTPlHEN+J6qjT5hJ6c8v6Fbg0a3nniCJ0O9TN5YzSzc5NFlc6?=
 =?us-ascii?Q?ROV+KS4AOaNxQm6CGwFWzDkCU1B/ttiTnMWiPFtpB4kNrhb/zMOVYGagG6zr?=
 =?us-ascii?Q?lIacVu5wcqiCZbQIZPaHkCDNNWL4FqjO3NKzVmvGuMQbwcnvTbASY2MEfUK+?=
 =?us-ascii?Q?EoBiQpMH6KjKPkVYAk7ZMJ5UIzxkHYjRFvvJcuzI4y7bGOMLfZI7T+haFNR3?=
 =?us-ascii?Q?rasZEsDKCrDMGbtsjmng/mbWttL5HDeFyD7OnWKHnXe7P89pir07BRuHORCU?=
 =?us-ascii?Q?kU8iI4pGpycQGiK+9tKaHOenNZYV/oAIN8AyRVCn2VMlppbiBnk7+gShfGS4?=
 =?us-ascii?Q?TsmsHBCOXmMhLzqdguBp/s6jgsjphjEy2v3kM6EV7cQxsuaPAStYIpI0433S?=
 =?us-ascii?Q?ndxOjfm0+OaT9Wn7kC3wX6R5HJYtxIMECNK6zL4h+uuJqc6HNcb0G6dAQwaG?=
 =?us-ascii?Q?Kqq6aeXttvkDWZ+6WWrjZRb3nbDdDF6ylAQ6+2134lOIZ+Poq6kypnHEAFWF?=
 =?us-ascii?Q?8XpMUC/bMnTR1jVPwP4tw+DPHcruahHr4YPatlmQ8AbCZzgf9sipht/D/Q0/?=
 =?us-ascii?Q?zGmTPUutyEs552qRauGxRsadoNEuBhcgaLHE93npbKiWY3YVudStjazyty8h?=
 =?us-ascii?Q?tcW9fgkU2ILDGIkDgAs5sgtiLfPH7DEkADOuE8XCmccJWwLTeDiL4Ezy2Oce?=
 =?us-ascii?Q?tOzB//VZtUngLJb+we9sPzxIWAce3/qEkVLyOldkNib5C1rA4A=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HMAwSYdIGhVE0axcMz1rL21ipzV/we6e8E8cnPwNBdCJnt64FQ7oO3oRX4JP?=
 =?us-ascii?Q?2FDALWOPa6RFzywJ+vlm55tZUVxkoG6RNcF+pGzzSfOOBcSF3IFxpZxwuNlN?=
 =?us-ascii?Q?gCXdjff2oijmOvyvWVYkjerE721prpN/CGsYVbbK+a2fGWkEhBPCWWhDAW8O?=
 =?us-ascii?Q?zgavVBxt1LW9+SVQnK6XLbnjo8+N+G5I07oHikLR77cZrSnojrJ0U5PUO81j?=
 =?us-ascii?Q?wkrohRZ51OH1KNfIILgHbf7O+4AWafXkFTQnoDpcZusS5NAgrdxnaw1H9H2C?=
 =?us-ascii?Q?BxA40t4yuMSkzw+xa9O7VJv2vpg+V3X2VjCW1WhxBqWPORJ8OIMFtS63fUXQ?=
 =?us-ascii?Q?t5tedQPsdkXN0bscxIJ/UxJV1vBqLseORKmFvLXc/H4EchNrAfXKyDTap2tU?=
 =?us-ascii?Q?2sg+m4eTL+dWy6SL+XRJG1xLUMi4c02ftocysdOmBSa4llSEyha7BfLnCNKV?=
 =?us-ascii?Q?LDu3T9PCWaGqk27NZfQoSJ2cun/6GEer99qw918NaaYQlmNxpP0CpvaRBLzt?=
 =?us-ascii?Q?mT5o0if+SnqZEmorR4Y4PJ26C5SVgX7KdKGiB7IOdJR8o5E6fsvgphVJWeqo?=
 =?us-ascii?Q?dQKBGvflc7znurC8gVzI9+EawPfAp+U2CPTIoBoskOHESh+1GiEW0mm9KVSX?=
 =?us-ascii?Q?k1+6dw58QJC36nMlaDh7fSotu0Mpmz3CL0ouvQJkotnmjnk4pOLFVwmGzibT?=
 =?us-ascii?Q?477RYdOx35cRX8shCvhGhFjiHqG+1VZ7u4sP4CQAPOj8JI9czj81GP/S3Jf6?=
 =?us-ascii?Q?uM8wQbBTOlNDj+94yfexa73z3gqSlcC85bgxwrcpYbBlRsUn+l/Q0aHdcA6r?=
 =?us-ascii?Q?aaXaw36DsODZNGyc6j31wuBlyuG7KBzMZzLdKgM4BV/+dEDocL+rZgTCqJA6?=
 =?us-ascii?Q?Tn+2dQdZQMrQMqXsoPikEPWzqzAmt5B2fmbcrxkzmFvi+oLnGEmUZvFfls81?=
 =?us-ascii?Q?8knbmFNWi3CDhY6sPBCYWwLcKlyuEuj4gNEdY+zegWYT68Wgco8k2HUTIiCr?=
 =?us-ascii?Q?uTNkDfrLWgkh267jg5LqfO0a1BLQYJqnMLWwvg07CV277o8PLM4wbt+Ng8NR?=
 =?us-ascii?Q?X+c6p6Uyukvuf/1QU+TCWFJeBKnRGB6iAM1wk3HmEtRwHMuKQENBSN49qQo5?=
 =?us-ascii?Q?96SAAj0bStG36Cc3eF+HcV7yoARYXUZg96SjiF0KufaPZl1LhJJvdNrrNpmp?=
 =?us-ascii?Q?v6t8CTeUXumklG8Gvoan60/gwz7996cu9/08XHPgPliCepjdJ4aWgDzRqfJQ?=
 =?us-ascii?Q?8UVQdq/ZDMhPP/J/3sx0uMZ5ipRN3TElXiUR4tBXkCCXL1RV6B/wGlPQA5q3?=
 =?us-ascii?Q?C0cUFEr9e6SvJ/66nKRzgb4nA8eKao5SlCQ8UtX03fHVviNo9qiGkTG24SPs?=
 =?us-ascii?Q?89hbzGi9lfC5LOLWyoyWOKjYChYHJGo6jlaoKdlc41AyeL2Udvl8D6Lc7+6u?=
 =?us-ascii?Q?F1/c/WSdZun41X08TxA1JaZkJ5W4/Rkn9+O5GveMbJbr1LK2ApllpPWQPoK7?=
 =?us-ascii?Q?uLkzbKQ7HSaP/r+v1cwVPf2PhT/p2/jY/03nzwRrVoYWGjLeiwM0dfzeuab0?=
 =?us-ascii?Q?CMc0WV4JV9q60hnTyv3i/NA51Jn5fEpjx2tRv3EA?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b547706-f672-4d91-b612-08dcbc0a3fc4
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2024 02:38:58.4957
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0TiLYQfW6xsTzA524SHRUxSd6rDa82dr7nkCbPgoNpcV6eyWk9lDgfa4qrXQrY1kKsucpFDe0jU0qfZiElO09A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5304
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@ziepe.ca>
> Sent: Wednesday, August 14, 2024 12:21 AM
>=20
> On Tue, Aug 13, 2024 at 09:40:32AM +0000, Tian, Kevin wrote:
> > > From: Jason Gunthorpe <jgg@ziepe.ca>
> > > Sent: Thursday, August 8, 2024 2:30 AM
> > >
> > > On Wed, Aug 07, 2024 at 10:22:00PM +0530, Vasant Hegde wrote:
> > > > > Needs more words, maybe even two flags?
> > > > >
> > > > >  @IOMMU_HWPT_ALLOC_DEV_PASID: When the domain is used on a
> > > device,
> > > > >  with no PASID, the device will support later attaching a PASID a=
s
> > > > >  well. Some HW requires a specific domain format on the device to
> > > > >  allow PASID to work.
> > > >
> > > > I will add this.
> > > >
> > > > >  @IOMMU_HWPT_ALLOC_PASID: The domain can be used as a PASID.
> > > The
> > > > >  domain attached to the device must have also been allocated with
> > > > >  IOMMU_HWPT_ALLOC_DEV_PASID.
> > > >
> > > > Why do we need this flag? Previous one is already allocated PASID
> capable
> > > > domain. Is this similar to SVA domain?
> > >
> > > IOMMU_HWPT_ALLOC_DEV_PASID is the flag you specify to allocate the
> > > domain you will attach to the RID
> > >
> > > IOMMU_HWPT_ALLOC_PASID is the flag you specify if you intend to
> attach
> > > this domain to a PASID
> > >
> > > They are actually different operations from a user perspective. Today
> > > every iommu driver implements them with the same logic..
> > >
> > > So I thought perhaps they should be seperate, at least if we get some
> > > really crazy HW down the road the uAPI will still work. uAPI is a bit
> > > more tricky because you can't change it.
> > >
> >
> > I'm not sure it's necessary to push this burden to all existing IOMMUs
> > which don't have such requirement.
>=20
> If we are making a common uAPI then we need to have all the HW act the
> same. No implicit behaviors that people accidently rely on.
>=20
> So if we say you need flags before domains can be used with PASID then
> the core code must check those flags for all HW even if it is a
> driver-NOP.
>=20
> So what are the flags you want?
>=20
> Flags =3D 0 means the domain cannot be attached to a PASID
> Flags =3D 0 means the domain cannot be attached to the RID while PASID
> is in use

From my understanding there are only two type of formats so far:

  - a format only working with RID (V1 in AMD, S2 in ARM)
  - a format working with both RID and PASID (V2 in AMD, S1 in ARM,
   S1/S2 in Intel)

With that in mind we only need one bit to indicate whether a domain
allows PASID attach. The user learns the PASID capability via
GET_HW_INFO and should set or clear the PASID flag consistently
for all non-nesting domains attached to a same device (RID, or RID+PASID).

for AMD/ARM this consistency is mandatory as one device can only be
configured to a single format. no mix.

for Intel there's more flexibility but I don't see a reason to mix S1/S2
between RID and PASID, and now both are fixed to S2 for UNMANAGED.

>=20
> The core code should enforce this rule always.
>=20
> Above that we minimally need
>=20
> Flags =3D IOMMU_HWPT_ALLOC_PASID allows the domain to be attached to a
> PASID
>=20
> And you need to decide if the RID usage is bundled with the above as
> well.

A single bit IOMMU_HWPT_ALLOC_PASID is what I meant. Setting it
means the domain can be attached to both RID and PASID, i.e. RID
attach is always implied.
