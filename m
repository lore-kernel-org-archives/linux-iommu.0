Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64556BE46
	for <iommu@lists.linux.dev>; Thu,  6 Mar 2025 02:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741228892; cv=fail; b=PXPBJ+nO6siGho85nvjAsl6k43+IxdVY4M7fU2J0EqbgeMLS5mZhz17AAm42KztU31MwwSOfCgsgDG/TlOAeId7azJe4hEC15jwDOFybGkjDkah4ruQXcqyvTW+WJ0i8Yw4IFia4crUfXj0b/mSV7ZDmtAU8mHwpvqS75mAYp60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741228892; c=relaxed/simple;
	bh=uTopq6knnxewk4J6w/+EGQNrrJGkYAAlv4eKvr4dGvI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GMw8zDQDtWWgA2xqaxAyLLotQQ4kSdXuY8hoYb8dEiBQEe0r6SLCZGP8RKfwfgz4JUhD6qSxWTETgC4RxFAXj5AmMhgRa22UL4YKGINIotLRsfZfY9kYCqDEH/ZE8oraQ7YIZNbSZIgmG82T4+skBjoKm5uP+UL6ZNXCQraXnh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TCXrXman; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TCXrXman"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741228890; x=1772764890;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uTopq6knnxewk4J6w/+EGQNrrJGkYAAlv4eKvr4dGvI=;
  b=TCXrXmanYxos0MCKYI3kCThkeCXVlNWmNh4uW3RdPU1ldN8PwHyUl03u
   PQFWjsJ8ymH61d4IY2+tp73soDNEiyaKhl70kh+5DY6EhS4OfApRyY7+z
   fuAHoAJv3fBNTWYGSg83Apjww+XiFKpgd99AxJs8JTidrVVrVckATdPig
   qMpjTtzcP0vLP9/5tjYlxLHY4HSbj26ooyCNGx4wuqTtsUQPDi9dKNEt6
   o0THdknK0HGnW9Z7Lp5MmT4pxEVJudTN5nHxZt5cZDqRIfSG9E6UzxHRa
   l6+GaI5tCvm0mpJXPJqZX8XAFHte7hUjW21NCAhrYdE3goZ1RQgLuV/pq
   Q==;
X-CSE-ConnectionGUID: MrxpI//GSGaLCccYD6v8sw==
X-CSE-MsgGUID: 0+0486o2SeqXiPoxdOr3Mg==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="29808835"
X-IronPort-AV: E=Sophos;i="6.14,224,1736841600"; 
   d="scan'208";a="29808835"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 18:41:29 -0800
X-CSE-ConnectionGUID: lgaM4P+gRPKsDtkYmjRbkg==
X-CSE-MsgGUID: eLSrPvKGQXWWr7X431m3Xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="123031322"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 18:41:29 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 5 Mar 2025 18:41:28 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 5 Mar 2025 18:41:28 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 5 Mar 2025 18:41:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZSp/jebq/LwpWuv/UGllia1Uins3nDCqLlDW11M///E/ZORDytxtEF3MNB4hskdHnTgxx+RG9nhGe0bfy4vuCB+vc5Vr3/7l0eFbI7/+jSmukdJAU4Lif5jbBrVT0TL/I5b8ko+vJA8qMBlHzenOtz4SkpiIpMsK+LmuyME5DeL+SZ21RKs83gbZza0qbrtmpZp8z7Pr+Uawq5oodI8F+6iax42BSkWH/W6SH/SZW/wsZvqDXSLBs5behrggCHXUZcrTbOsJeAbKIZ9/ZxY+t4HgHkAWHYz95DzLFRjm8w4WsKGie14UwgvnWKFFsuA+qaz2focoE1gtONiiaHi82A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uTopq6knnxewk4J6w/+EGQNrrJGkYAAlv4eKvr4dGvI=;
 b=U1756TbhkHDSEicZ5zlB2pciGy2g69Py2pKLAiyPTvcPeYkaX7DWeg2n85oT2fwuLFhFKKwjPHMUWQ1oP7rBHtulYZTE+FoE77sKrjHlXR4NaehYB9xPp3H2jTzxzUZ9TwkwyojvfoMB/gLf647sZACJK2TWv6DxH3RUO46Ez6mChQzaX53heZv+ygWK9XerzK/QzSbiF9NnwCZ8rLVZfCjm9SSbGhUZWrlWJyB89DESSXiiBio5px7AqHPGvY/22tBOZptDw6G6a+zCSpFnWntdo2JS66pfsguA65VrQbr4BLV9UrYuLqEFHA9Cf4KNHtstxwnx3/JKttEsvp96iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CO1PR11MB4948.namprd11.prod.outlook.com (2603:10b6:303:9b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Thu, 6 Mar
 2025 02:41:24 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 02:41:24 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, Vasant Hegde <vasant.hegde@amd.com>,
	Robin Murphy <robin.murphy@arm.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>, "suravee.suthikulpanit@amd.com"
	<suravee.suthikulpanit@amd.com>
Subject: RE: [PATCH] iommu/amd: Add Secure ATS support
Thread-Topic: [PATCH] iommu/amd: Add Secure ATS support
Thread-Index: AQHbh3UOCMVRgdan70yjYJFDyKuOHbNX8z2AgAANboCAABr8AIAApFIggAAJnQCAABasoIAAQ3owgAIlpoCAAPkEsIAAF6wAgAANLoCAAASrgIAAABIAgAMaTACAAkGVgIAAzJqAgAB9yACAANB7YIAA9KaAgACb7KA=
Date: Thu, 6 Mar 2025 02:41:24 +0000
Message-ID: <BN9PR11MB52761F5D8F288DFA03ED79F28CCA2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <BN9PR11MB52763A8885AF1678E05E8B528CCC2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <942a1a66-5c18-43e2-886e-df38cb3e7258@intel.com>
 <54db17d7-b150-4579-a33d-f1b5cc8943bc@amd.com>
 <6eb0ec90-5859-4605-8a2e-657f6f711d61@intel.com>
 <825ddadd-6770-46b5-936e-f17988534984@amd.com>
 <13e1e1d8-5870-44ea-a800-e5b25bafd344@intel.com>
 <20250303183801.GW5011@ziepe.ca>
 <2c9ef073-fee5-43c6-8932-a8cae677970e@intel.com>
 <20250304142030.GA5011@ziepe.ca>
 <BN9PR11MB52769EFA077B3E552DA4235A8CCB2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20250305172219.GF5011@ziepe.ca>
In-Reply-To: <20250305172219.GF5011@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CO1PR11MB4948:EE_
x-ms-office365-filtering-correlation-id: b7964c1c-e6b7-419e-4347-08dd5c5862de
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?NJzloGJnwnq7/XC4IQTdc2Z/P3vxV8ud1KANyy1+Dt1lGEI3TxSn0XSPMd25?=
 =?us-ascii?Q?jdzb5RVKh9w37vGNRpDiNh3Q339pjstz6XaSw8BWNErIta7OS6jVBol5/oxl?=
 =?us-ascii?Q?L6ZpM547IS6mfVIGVdD368cGM04NFQ5ywR5ARfiWdia4KaJa4Ba1YlN5xqFE?=
 =?us-ascii?Q?1Is03Jh+u0Q8siJ+avUIdCkT32UV4J3ssUTbXLbZrw2qQ5WERbg2z9ju0hPu?=
 =?us-ascii?Q?9xqazWYfC6auJp4zsRnYtgW9GP/tlvDnlAj+0TXPvcLrpHCd7FMwdf1AwAF2?=
 =?us-ascii?Q?8tM0YttEJwBmyQ70awkYWWwwmVGqeqGd0zDpIlgHWASbcccNxVm9g1GpRsvC?=
 =?us-ascii?Q?6VYHf+lGS4GREX+K7tDqUZKq+zl9Wn+LGroeYBBXnMnKvD+nGcOGnTm9HAo/?=
 =?us-ascii?Q?/Kr9Z5yJKVodp/VJUUS0JRvNe1WPbf3v6Mbg2ryjbB3n+SnEJ4O8nB5mVz0p?=
 =?us-ascii?Q?iJPGqsiEWr3I6CPiOicxnvieZobLgRZBLXkbIh/ZXAAqgvPOwb5ucVrV3dFY?=
 =?us-ascii?Q?mm15Q5esS84qZYpxx96Y++PWmWWHovs+rsnFrm7pslXlbKvSy0tCVrj9BK/F?=
 =?us-ascii?Q?Gtd2tz1+3q3dKuOv6y08bm0wkgIQm2hoSnvXqLaHPHusu+18kc5Uof14fdEG?=
 =?us-ascii?Q?U6ozBWZw67lJiBo4DQHwWGMrFp/fgd2xYb7VLIej71sseoSRcrOjwJkRtrpE?=
 =?us-ascii?Q?p67HvXv3wijl1nSOLgAhOIBSCd5oLiCRI3Bl1lKhiQxnNE+l//uwh26WI2wb?=
 =?us-ascii?Q?isrj0JLWTWFREItFQHrcy6WIcvDSZrSf5n5MW/kQAOA6z3qg5NkVz847gMqq?=
 =?us-ascii?Q?kkao15w4kYjoRTo6/qieeS6FUTIPjglHXMI9ES/R82ypESIWnVxLk5vP0NqC?=
 =?us-ascii?Q?4ne7feeFd7QzGN5ZZ4+/flRQn8IfMKrxc7ZqrB/H74MiLZzrkLtK508PyhIR?=
 =?us-ascii?Q?wdvQFhFm6OQF7NOsrsapm8r/0E6tpD2HK1GcSCTMrb4eUCuExHAsPpfN6Sfy?=
 =?us-ascii?Q?buqi1A0Z+Q+FKF6cUOcLYhRoRY5+FSPU5g/FNtXIIUc79bYlciB/zMB5S4s6?=
 =?us-ascii?Q?HTiEyhuv4xnWhgDvwLMA1DpIrGZQqDduge97qH3/MGyyEHnbuWN3D5z3R/he?=
 =?us-ascii?Q?DksGXWedlpO+jHt8dM2r/Y8gyboRMD2QRnqYcn1hkSgUcushHQia3pbRURca?=
 =?us-ascii?Q?lffSg53E5eJH3cvVhhy5zfw1iZNKKJQiqqnaOyFYB7dhQN2k4ArO096oJF8B?=
 =?us-ascii?Q?bDcqqyuGt/4icujDirp7tpYd3rZXaIYXsaAl6nGJ8PlJSTe043xS8CJ7ShQ1?=
 =?us-ascii?Q?sipuyxK2ldspp8PEiWpVybkXC1xiZyZp/x7paUNHQwBk01r3MFhQIezexCCX?=
 =?us-ascii?Q?aLR2WDp80qUUS8pK/+QdUKV8ji8lR0IVrrZyQBwLBv0qJbh7H3hl9Nc7OGWJ?=
 =?us-ascii?Q?0y/lsGeIMTZsxPQe0ZqBSRu7or2iWlSv?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ayrNfaNgoESbb+qivjqbQOXnMB88OVgq/KSmFV5NWHKQ4p0ZqNKmkPiJ8aSW?=
 =?us-ascii?Q?TI9R0wdcrJAXJqBTKNm4b/l3BRbqpMP3q/mBsFy3NY8YlGXK7rgEhwuokxqf?=
 =?us-ascii?Q?sf8qoFylUqCC53/35+HhQa+0EWJ8jDgYMy3YaRQar2+6S9puuYhGIopro5So?=
 =?us-ascii?Q?VOBOQQENSeYY+5F/vmhm+ekok5TrbJAPuy+ymVM1UORjXHYZpnQPWQyUUfZh?=
 =?us-ascii?Q?llBOtDpXYna4jti+2QTobzC+IbTRO5wNf69sOMFgAnrfrJmQfJQuL9eeIKDj?=
 =?us-ascii?Q?um1NV7ZRwZeo7jqoX6YPtSrBZfMyozkAK3LaX1q3zZaEA9Y/gMKEle3U6N9q?=
 =?us-ascii?Q?W9T5AinvTHVPNmso3IprZDCukcjseYOBoifdaIbuAJuEXzTd7eNvwajlRQm7?=
 =?us-ascii?Q?MKcX0UHM04NAd5jP3yPwPSOBbTmUDUWSB3JudN5E5B0fMRhPQkpoxjWb90z7?=
 =?us-ascii?Q?csuL9cPIrhsYekP5l470y6FHa0bb7sb64t7zXPwWyaPttaXyI/zuq91fg8Ld?=
 =?us-ascii?Q?9Qe2U4lVFE/QJP5KFEo8jVM1ktPThwtwZ1Ou1MWpz4z6Q2/8kjnCVA9lZigC?=
 =?us-ascii?Q?rVU39w4XhTYd11uRMvZaBkOQ70QUFwL0SI3hi1uhoCCY0bdFTbAwFDG0bzZn?=
 =?us-ascii?Q?d3kjPF4P3TRKdI2ZyZIOY7K612ORj2JHJ/zJveotUwU8EiYatOz+IX0e/qsv?=
 =?us-ascii?Q?7HiZ8fpyvk8Y6mQ/j7/dK+vpM+vMScqNUdavYBtO+OOU7voEc/lSDT53fvGm?=
 =?us-ascii?Q?MjOZ+9tzOe7snXtnDw1PxUImbBMzuJ1lmJbKEhREdq9Lv/LmwIH955hwZf91?=
 =?us-ascii?Q?hx5RHqjy3/lqa5gTVu03BZPIUlQvPaDxYHEXCleqGriGjNWdYDA8P/QHeM4l?=
 =?us-ascii?Q?6KJStMGZeeHGTZYewIeDZ3cAdaZLvCO4VV94F1dos5rKqUzawruCH7tjxUus?=
 =?us-ascii?Q?0aRmZqGC0E+j0xng9usiwqvo7/Mz6zFVZcD+aj/KZAgC5wV1esOv6iEqPTg9?=
 =?us-ascii?Q?nHGh57FpOz39L4YLf9gppHwtABmDY7ktqB2C+VbmcfgwS4xsQwt7e3SJKim0?=
 =?us-ascii?Q?fRNVg0P8lC0qBTr61QG1yi4DqWzAKnkPNfk6oQhSp+C6eUFx0pjtFKs0ANF8?=
 =?us-ascii?Q?W6k1x36rz8YjsAKtFbNub37HNRn158zuAEdetebCRCK+TAxmbnA3khVScQc/?=
 =?us-ascii?Q?sDAkPqm0eKBcgIRBUqggFVgSMryZnsbAqKqNoQsq9R1TPuEo60SzBY2F6bCD?=
 =?us-ascii?Q?cV2xsv5RHfR9bXOKdfYH42bl/t+gVWjw35zyHcgGKgsS/KEaG8C61sOhg5sy?=
 =?us-ascii?Q?dr/q5ggNnZvKsEcrU+tWfUbZyyUzwrkskDAlGFmoJYNcnXZarzRY5swzCz4H?=
 =?us-ascii?Q?A9J1pYSX9yK4Xi1aHSh6imWAAHIUNgJ7DTUYPX2xt+oryUhBYYjfBrBG5c0u?=
 =?us-ascii?Q?l+hdY8ntrZRybPWg4ITm2iotm7Ptw/oDb3y8uwDRHAkOj8E3CkE7qRv9/Rjy?=
 =?us-ascii?Q?DhYjq00ujM/ao4Sd5S+o0UptOwxjKfaq8IrxCbIN6zzC2Zd9PtehDWSnpVYK?=
 =?us-ascii?Q?baX6KS1B6QdzmqwYAMoLx4p1xUK4YpcBpTEau/W2?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b7964c1c-e6b7-419e-4347-08dd5c5862de
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2025 02:41:24.1731
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8urx+aodNT8nBAXPHl+M1HVFKoIX4NtjU62rFqvBw2i7sHiHgOgUi3BmaNWhbt3Hs7VHSwFMM3empjJp1dv2Qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4948
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@ziepe.ca>
> Sent: Thursday, March 6, 2025 1:22 AM
>=20
> On Wed, Mar 05, 2025 at 02:50:38AM +0000, Tian, Kevin wrote:
>=20
> > Probably we may also need separate policy between unmanaged and
> > dma types. In some scenarios the user may care more about potential
> > ATS attacks from userspace drivers but not kernel drivers. In that case
> > disabling secure ats for kernel drivers would avoid unnecessary cost
> > of address audit.
>=20
> That would be some specific iommufd/vfio policy IMHO
>=20
> But really, if the device is being used by iommufd or not is well
> known by the admin, they could set the general ATS to secure prior to
> binding vfio and just be done with it. No need for more automation?
>=20

Make sense.
