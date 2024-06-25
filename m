Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459F126ACD
	for <iommu@lists.linux.dev>; Tue, 25 Jun 2024 03:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719286527; cv=fail; b=jJuAWO+aJqBUsNzzXPCAIdsh3MUHpWNWOFBEKPogIPR2acr3ba+AfUBidRxLX23r7yKrgNtyvFbj6AE5OcWB19UDolcsc6Y1ntt7arkeqdEJjpH9rU16UwHrKTfp530OBnk8moUGhEpH620wOCoNNqBE8vLNLGaXyp9uQmB6tBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719286527; c=relaxed/simple;
	bh=VYlaT4LsfvezrvckvPT+8vTz4UbF7VqgBRRtHAHCfRo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hxE7baTOJ0I8lMRdflPeCuOT8wwr9v9GsuU9CbcK9LBbf4q2ptAdJXKQ7Nl4c+TYxyVkWa0N3ytA+NZl8SpVlz7ctG8fgI+T5+hOnOBAYtuIfOtIVtXn9l/87ocGn/7FxvR9IfinfPGzXouMlRDxTRcLoRozew4KSWAK9zTvtBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VliVBA8j; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VliVBA8j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719286525; x=1750822525;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VYlaT4LsfvezrvckvPT+8vTz4UbF7VqgBRRtHAHCfRo=;
  b=VliVBA8jcCfmm4B9z/HEBPltjCVv4j8SNttz4h007V+hAQY8Vc9vPJ1I
   73PqXr6DAEi/CiLkp3472ONDAXl3uJ4ZT+3PF16a7ad6+OpNCGEKmJs5j
   v8dvIfEta3gNx0xC/SvoanLmYqJIVcjIuM7dKk44yeyJC2vOiJzBnBjpe
   NixWCOGIun5cttKlZkZVlsS/8j96Zo+rle3j8FXdob2bdjAGUT1x5dIgN
   SVJP6GhyEFmzeet3jqkUXNKQHg8Ckk5DPus5MB7prV8wv7Q/BocsR6rIh
   LZq4WW5aQX8IWapFKTCJlqWsypJH4YlrmMz8CdHgzKF5B9mnipgBgVyBt
   g==;
X-CSE-ConnectionGUID: eIFAZbjCR52/DfkzyN6ZwA==
X-CSE-MsgGUID: nSarVjP3TtmNNVMy5dxI5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="16413613"
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="16413613"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 20:35:25 -0700
X-CSE-ConnectionGUID: 3mqmwvJoTjq3/Xl5qunXWg==
X-CSE-MsgGUID: ToYApqLNRTy/3b+NVtKiZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="43601182"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jun 2024 20:35:24 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 24 Jun 2024 20:35:24 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 24 Jun 2024 20:35:23 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 24 Jun 2024 20:35:23 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 24 Jun 2024 20:35:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iMM0WL0Afflo8F5lBJn3nbdSP/Y57eLz6ahryYD7H5PdrWiJHl/OCUERdeJTbsson3Q2jzkoewfOs2P+1a+AsEQimmOWI1t2F4R7Jpvb719+KKW0YWaf20PuAsYeUyRBdPWp6FR6WkLdzobl+mGi/Szp3u2d05guTzqOkXjRJYkdJ0XjyJ/A/maU9tc8STC20EKZ1kQex7W60DP02j+6zgfEAl1R1PfeCTR3HWOPH+WwFPKP6G3lzN5+NeviFrEDT50wBmwELCdIwOaluE/SMHNhIqDWHn1Jj0T93NljiDVzVVHNK0ZTUmDHZLnOFfQYTDVmW68MXtusr2dQl4uOww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VYlaT4LsfvezrvckvPT+8vTz4UbF7VqgBRRtHAHCfRo=;
 b=CB6RDXqE5TCgxxNLYIxh0dNum6xXApP17SNW9yis5Jc2hIzZrhXhrvMBvdgSA2dtXcPvn0rl8GFjeuukgL/PKZb4xtsZzFPP6kbH7O4cOSd8ZYNeZ4Cq6y96dsdt1lPf2ggs2G3xJWNfbVMQUJyrDfdll/QD4ljpbwwg2G2LCDu47hqGNikwoQohn36Y4fNifpmmPpRrrh67mcsYrqJNSk4LjGbfvxtpMC2q32JTLNpnyRvn4V6qsLfa/qf/GS400FgsjCbixPiIJSQ5tE1vcE0HQWRqrDNFcxgn06+A+LQWCNvwh3Y7s5rESzf0z1pYpqhOlMgtoSlMlFhDLF5c8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA2PR11MB5148.namprd11.prod.outlook.com (2603:10b6:806:11e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Tue, 25 Jun
 2024 03:35:22 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 03:35:21 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Joao Martins <joao.m.martins@oracle.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>
CC: Jason Gunthorpe <jgg@nvidia.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Lu Baolu <baolu.lu@linux.intel.com>, "Avihai
 Horon" <avihaih@nvidia.com>, Alex Williamson <alex.williamson@redhat.com>,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: RE: [PATCH v1 04/10] iommufd/selftest: Do not record head iova to
 better match iommu drivers
Thread-Topic: [PATCH v1 04/10] iommufd/selftest: Do not record head iova to
 better match iommu drivers
Thread-Index: AQHaxAr2EmzDYwL66k2Pz1VycpxiSbHX2Pvw
Date: Tue, 25 Jun 2024 03:35:21 +0000
Message-ID: <BN9PR11MB5276AB80727CF5521D5F20768CD52@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240621184254.45477-1-joao.m.martins@oracle.com>
 <20240621184254.45477-5-joao.m.martins@oracle.com>
In-Reply-To: <20240621184254.45477-5-joao.m.martins@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA2PR11MB5148:EE_
x-ms-office365-filtering-correlation-id: 976497ae-2c8b-4334-f41a-08dc94c7d7c8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|376011|366013|1800799021|38070700015;
x-microsoft-antispam-message-info: =?us-ascii?Q?RM2r9sqIRc6kE8AeRgI/dXv4yA71RKpUR+uwvHEVOu3lwJGapHiCQZWWNJGi?=
 =?us-ascii?Q?RNHdgcvpN/1d3s1FsnW0n9HOGNhrgxM67X41XTlPeYkvxdhTV7rbfPzzdMNy?=
 =?us-ascii?Q?yNYVuo1p74ynCnM9hOa6KPxgLDfmqmczus1T3vVxVlZ8n5VJmnxeGH2zKjcU?=
 =?us-ascii?Q?wP/54HtsbbwkFhwhsC98ThHFBnRVn+VbsZtYBgO1L1w2Clazi6sHgp+pG8RT?=
 =?us-ascii?Q?dremwK6/XmB2O3hlQxQLIiPaqDp9fOUW/ARoL4z+PBTYwwRv5jfN2hx6Jkw+?=
 =?us-ascii?Q?StG8dqprz+sUoKOP9aym9jjXwTEHX2RMdjisJCPpRGg707PJSiw/IZyffOov?=
 =?us-ascii?Q?/fewNvxipOxNDGFsB9vEAYBiXFR0IklyIdvzcF8vAO4dqvnV3Q599z0289gI?=
 =?us-ascii?Q?Rc7qKz3xyfFfqQWqZGvtuJBQ3rVash1kJQg+rpzFkoWv2NA/ATJEOc4lubOv?=
 =?us-ascii?Q?BwVEzrzTtxPEyILKvPJMgIi9CibL07HgjQKkmNUHuceryCU7QU9DAPv5CJvk?=
 =?us-ascii?Q?lnmcsx7TV1g9K5d0BWFdz/j6tLoS8iHbGod8e69jD3SkxlDoMi+FFeyyVM58?=
 =?us-ascii?Q?KmQ+s3Chof6yvAGiOVkPTWDGRX+FYjUwjfhOeCOUQhXd+sEn+vmhTL2z6oeI?=
 =?us-ascii?Q?aqRdyYj9JtmIWhrdo0OpcaDvC+cwaW+OTdabCIgk7weU0i9llQnvHgxR7R01?=
 =?us-ascii?Q?2bTLOu2/sC8jrF5hGli7Qx8MS68ZfsNZygqW5AzFBxYEBIzFd+S8TuWP6HEG?=
 =?us-ascii?Q?U3Ar+VWLaurQmqdoG3mkDFEz3ux2s7Qbo1ayMWiCkO4LFloh7Q50ZjKdMcmm?=
 =?us-ascii?Q?5k97yjeIYTVyN3WyPnus48ws6lvWGfWup7hXqSV2BpEIr5sd+diG1+w1sCvs?=
 =?us-ascii?Q?vYYQ6A2zptsoFrgzqOmWlpnXG3tboHmshx853RrSPF1rCGLoq5cIFO1RGLav?=
 =?us-ascii?Q?u15JzEk4DX4FJokJkyZQafbP5REVXqI/Nug0g6kpJgmIbWlnmGuz/M9GXeBf?=
 =?us-ascii?Q?DnYGisR8xbZeq0yJeqOHk6aOJ3lHkUWKiJMC6KG3KnbF1go/icqbojW6tFid?=
 =?us-ascii?Q?Lswthcbs1EjraiXylk3fKVw3/pgeIMEfIZJhHtBSP9y2nkisqAEDUcWdswct?=
 =?us-ascii?Q?ZkCNeqvCNuMLkQBNhA9fLwhQQQmCHIdw4XpHDcfBGJwCAfrvC1j9voY7Twd0?=
 =?us-ascii?Q?x/0fV/RiXU5m0wJ66zkcYRqiFDdXCeK7enqy5/B/NweqUSeSThtxlHxusvP/?=
 =?us-ascii?Q?Hif6uPgb92NTucaPc6sHeGgXFz/ZiG/VH2GoO76sBiznz/1zfW5By5sXZawQ?=
 =?us-ascii?Q?BqmCLgW5++g6dOQs+2vfdFB5HszlMTHzmaHKnJj/sCnjUpkRUF7gF0Gbq0UR?=
 =?us-ascii?Q?rubKkc/j8Xp2rTxytd4J2N4VJvKKAujTS6ZFCz0f197WUNM7+Q=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(366013)(1800799021)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Byy8jNkVZiHo09B5rnjkB7w/W6yKG9vnQWHk3fVWDEvaqML/36dKlqaBtXhW?=
 =?us-ascii?Q?wPJyDuZl/0nSwaf2MwkqjXFHecPKZM/uNXP0PUNxSA+0kuWSaSCqYc/tNfSC?=
 =?us-ascii?Q?Cbze+HLjiBm1gvvbz71KymAPuhbsyIt7K69/Zv/c2qGfdZ9lgjMjfU0iC9DZ?=
 =?us-ascii?Q?jEoZcWEQ0qONpb21PXYxVS4g+xaHkTNSRSg06Xik2r52U6f24dVKnvFNF/Kr?=
 =?us-ascii?Q?R6GayKLCkxpqwKeSjkhWk59pdm0TkCVGltCY7ifctgqBWfoQFKuIvtxvLaMv?=
 =?us-ascii?Q?QkiKK/8SYu35YzNF/K1lE+nmyukTnynbe1mt7W4l0xetuR/5uPI7bcyTedLQ?=
 =?us-ascii?Q?I/Un733K+CTd6vOgdC8FKnh3jfwXW36I7iiAQ+nXZb9/4bk+mFYMMavKfWFg?=
 =?us-ascii?Q?Sw6I4aZuqOLQcj6TK7olNta42kQwe3MqVC0yntYwT7Iukw8HIC8oEB0/+TIV?=
 =?us-ascii?Q?31QPrrVI705BajSyjSzs7b7iRk6mk/5IfxDElso2w/xO6D+fP/7pfK30MtHW?=
 =?us-ascii?Q?K02rF5W2F0o1Zu05Slg8dIUR8bDPcQ75d8D0vJxT6xdNkGFRC+my/j76by/o?=
 =?us-ascii?Q?caDbTpMCDv4TKyS5igF2F9HJNvWZ4VrGbT8M9gNj9bsKDXub2P0GS4sFzRSy?=
 =?us-ascii?Q?ViGJ5I+o7RwwOTZXaphu3EAn4DJ4rbg4UUWd06pemvH0ai1dv9tth41RMORY?=
 =?us-ascii?Q?jevyQu+00n9OtMmck0eDZvlf/q7LOynjC3KrgGvA2tdjRTVEUbSAAQgGYLT5?=
 =?us-ascii?Q?0UUabhzp1FD+oo1Yic0b+2v5i3pMCLnnWq+E0bZNHWQGmfw3Aiesa9/Kjjlw?=
 =?us-ascii?Q?iilYWTYmdfZi8t0HQHLUxTEPPMfvSQlvdtejUPR8KucC/toMePeW8KEoY0GN?=
 =?us-ascii?Q?Gy/ADXa1BG6/6dayWdSdVb+AzCZbfBdUpVAD51t0aPGUZiTj4nyAieTTd9wV?=
 =?us-ascii?Q?RkPl5kD/YrjJvBvNgh6eBf9Cc484Uwrz07NLp/dQysXnWi1eOVB3r6HHFLd9?=
 =?us-ascii?Q?ve8bd7YUKGDxCCxwNnDA89QSfne+BrjIBoBIBXS6ecmdzRqZJX2BfIq/K9q0?=
 =?us-ascii?Q?DY2MS3H3w/ITa2JeRRnXkq/y2x65+EngrwDJRh/Z7gxsYBQ8qK5IxkZGUpAk?=
 =?us-ascii?Q?IiCdjXWUbTbm5IVrD4ZP73JEvhZewkJTf3DPJf9nWzY2T1HpGyZUwFEUPOV0?=
 =?us-ascii?Q?bXzTmHbKOs7psnXs/AeBON+5qy7cpJ/bQZ7OaM+nWTRlLESu3E/MhE+vTFbW?=
 =?us-ascii?Q?Wt6fPfLbawpnc+h97F43DyPNwq/i1EJ6c+PkQesX3uVaIS9GitgI2iyxzdcm?=
 =?us-ascii?Q?ro8b9v/gYzpRAe0GJTQwDADScfPS9gSqDM8OhvIyvol6uW5/41mK40vRYEca?=
 =?us-ascii?Q?pEImF6gU9m22xKigvYwJ/YCrlmLaLJkK8Hg2lY7dDe/xwRI5DvJLuMJQozBS?=
 =?us-ascii?Q?Z6nyHJ3YbOLS9Fa5a1Jz5zDY7m9kLb652UTRD0hlHVyy5OxQtffOrSFusNW8?=
 =?us-ascii?Q?imm1iOL7kKmSNBS74iK6VM6rdJJbOdODMEaPK/rPEZVHxDBr7WST7fZWIk5c?=
 =?us-ascii?Q?Bf2MJmsSdLAdZYse0OnDiSQmy68rd7gDd6qQDJTg?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 976497ae-2c8b-4334-f41a-08dc94c7d7c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2024 03:35:21.8885
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GDMFxDGIYr2Q425BM7ndMRoB2yrYTGcYbgcGu/DA+uJtOViQ6ywpREfCotnk1kGzlxjBMhbaJvCNWKEuEgTZTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5148
X-OriginatorOrg: intel.com

> From: Joao Martins <joao.m.martins@oracle.com>
> Sent: Saturday, June 22, 2024 2:43 AM
>=20
> Do not se a hugepage-aligned IOVA for incrementing an IOVA, to better

what does 'se' mean?

> match
> current IOMMU driver implementations. Keep it for IOPTEs where it clears
> all dirty bits for a hugepage even if it is starting from a partial range=
.

there are three 'it' in this sentence. Not sure the exact object being
referred each.

