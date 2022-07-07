Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AC3368
	for <iommu@lists.linux.dev>; Thu,  7 Jul 2022 01:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657159024; x=1688695024;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Hq/5+pANZUPh6zwhK1v8Kf6e9svE1U1H+upZjS7ivG4=;
  b=Y0ARGCDzF0K8ZBhinBs6uenBcfqr/GdYFDuegVdue8xtoEq0ezgSwdOq
   Zv+6aMOYgyg8YJLkzvB+TvFt5gCxIb4wEZsv8xNhExZ2swAvaO/flE4gx
   S9WYtHSZkn58/PR8EreV1EElVoo6PKsGYf5/Idtoqc31ivExfZfjn3iVX
   L8qTg2OGT6tItffViHQtnAEIBELoWDRAysmKBjOO0rIlLoqDlt7PBqQOR
   HTUkBRt40xMZerdk0RlDQRrVpSutQoYgsfEwSXWg2n8vu54bNrfpnA3i5
   khmRIWof5ZUfa4ezI1vdoHwhI4K0h2NtlmP39e5wiNWGjoV21Hn9g1O6G
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10400"; a="283933651"
X-IronPort-AV: E=Sophos;i="5.92,251,1650956400"; 
   d="scan'208";a="283933651"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 18:57:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,251,1650956400"; 
   d="scan'208";a="696334868"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP; 06 Jul 2022 18:57:03 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 6 Jul 2022 18:57:02 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 6 Jul 2022 18:57:01 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 6 Jul 2022 18:57:01 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 6 Jul 2022 18:57:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VaeRWJEskOQ9CY3ePUrfp6Qd6IuSjyk4S45krvC+I7vfG9BvXk2mFqCc3cF7J1fNf9M0rRPX8iCQNS60gt5GqiRxhGV1nMNoVUz1xhnra/ShRlZPjYhsJ3tXZ8TuHdrBb4I8rqi1o6XL7bClYNTgql9c8/iphS2tB+Q02CajjGZ2v49VDqj5J3kpgwS7lSU8czlZh8zOqiCqxETm461u6gYpXHN1JaozTr3wxv3lWJ8Htmr4Zl2jgkkk1U+dR6p+bEok0tBw1SiZAJsv2DD+Fd+WzWXNKmyqD6sJt7+ykTaXzh5gZn5rDWCitbLropOfrpycNgT6JfoIkUaLdg4Hwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DR/fvSQeEtP/Ca54uqFuwRFf5c/JA6P6eC9oRtkAkbE=;
 b=nwxtQy0PpIAHMRc8zfVHzaLZaK4DA1d8AMLSsEIhzZ6JH2HH3pKK++5iMScM7qW9QVgRrXSVa+xl2zI70NeanQEOfeb/OBKwSZ5yhBw2KixU5TIeyDn47yzQH1fZE9qS4N9PQShfZRsfnrsav2NUcImu5Y8fDTD000/POarYE3GHOtUT/g6Xvf6cVpYQDBeLpkQpCHTEVBs4FUJQ3ZlMb7CzqZRpQdMVn0b0ltvWsA8H4p5o6VpGc6RuA4f8XEoGD48wvLLJr89ovs5WVoNvqUYTFFKuZmatWVj868uwQ34sCgT0PqCdK31HNd3gj6e1MOvxYNLbUjCrwBxrLCMsKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH0PR11MB5112.namprd11.prod.outlook.com (2603:10b6:510:3b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Thu, 7 Jul
 2022 01:56:59 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c%2]) with mapi id 15.20.5395.021; Thu, 7 Jul 2022
 01:56:59 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	"Jason Gunthorpe" <jgg@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
	"Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>, Robin
 Murphy <robin.murphy@arm.com>, Jean-Philippe Brucker
	<jean-philippe@linaro.com>, "Jiang, Dave" <dave.jiang@intel.com>, Vinod Koul
	<vkoul@kernel.org>
CC: Eric Auger <eric.auger@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"Pan, Jacob jun" <jacob.jun.pan@intel.com>, Zhangfei Gao
	<zhangfei.gao@linaro.org>, "Zhu, Tony" <tony.zhu@intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v10 08/12] iommu/sva: Refactoring
 iommu_sva_bind/unbind_device()
Thread-Topic: [PATCH v10 08/12] iommu/sva: Refactoring
 iommu_sva_bind/unbind_device()
Thread-Index: AQHYkC3RawHjE5fI4kOPQdVz+DQ3s61yKD+A
Date: Thu, 7 Jul 2022 01:56:59 +0000
Message-ID: <BN9PR11MB527661C920696BCA56C064F78C839@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220705050710.2887204-1-baolu.lu@linux.intel.com>
 <20220705050710.2887204-9-baolu.lu@linux.intel.com>
In-Reply-To: <20220705050710.2887204-9-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 06dc1d9d-a3ac-4954-7874-08da5fbbfac7
x-ms-traffictypediagnostic: PH0PR11MB5112:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r85PD3n1pf0XgEYe6rHVBOlxaWWexvi1+gKzdWiuhiAPJJw/vqi1eQsc3TYNZJITiOtU1Lw62/zm3lAuIMqLRDwsZv/LePk/ZHOcx/dCPaFlgku7itcz8qkRXPy5BrJYFq207MTuSklv/m+UJdrtZDkt5plWi5WSOYXwmTsjM27kHQwuJqaMM6jZH4t1nPLc3KPYis/fPNTG3srkquphQ3NKoXWab5kZNYNxLQkKK1ouEoVzo58MIymm7AGWQ5Q5olQ2w2EUKofdWPU9XfKz+jVwKPUM+++POLRqBLKuK6PGfgz63yWypPYewrpkKiIa3K+XEyzV7HGvFady2YFAJEjW+zH+KAp352LOzMsYnUwYUmiQW3D8lUuokgIrsKVi0iEEkBIJ4DFSE3f3t9afeKihZoUW8jQQZbG+SRWYXGmPgddzn0aUXV9fm3WR/LhRIyY2yRRNBNwZowdJOLZax4io+isJ6FddlG3Cn54SAkr4gHGUiP2qU6MuK3STVwy8gif1Sf2jjJsw7qBnxczQezPWuTCZ6+y/zSZJm9fwd7dRiC2vj4WVO43hh3xFHgaddAzXwvLDoLeAlfxyya0sK/Y2DuBGHNqiz6d9jaLL9ktqkcyaoaGUMYEgIobNu5Gq49x5XIiwCEwK7BvuX0UEzG5QdGsRe8UVQQjWuZb2YOmnYNrDk3xQ93kWvaiLwUd4EgODlLe3n7E1rxOPaTBN0T6suu7ZFYJ1Hg6IJ6/WNJV3wuPg1wVNbPOBwhEwiSbxPd8GjE6TmhD80SDSBEticHYo8nyj4kqYbJLJbrboaBb7uHjl5KuQNipcIKAlIS329Smo8JUW0oZHVe77ApcpMQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(396003)(366004)(39860400002)(376002)(136003)(478600001)(38100700002)(2906002)(71200400001)(66446008)(186003)(33656002)(6506007)(558084003)(110136005)(7696005)(41300700001)(66476007)(4326008)(54906003)(921005)(7416002)(316002)(86362001)(5660300002)(82960400001)(8936002)(38070700005)(26005)(52536014)(64756008)(122000001)(66556008)(66946007)(55016003)(76116006)(8676002)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yK38aRMERcZLBJJpLYdfc9vycC6z9C9acztcvTySOSB5shZ14KKIe/iPoKQI?=
 =?us-ascii?Q?B6OdPkmNNgffmO7G123L2SjR+tGtaee0BC6n+NtKriF4V6ODf7hA53CcFK7V?=
 =?us-ascii?Q?v7q+4XGik4GvoaIayIfE1s9QszfrkXcrixs7NOASpXYVaj/iPbAWS7blXvmV?=
 =?us-ascii?Q?1vHxTHQ9HCegMy+MRjl207o+JJUdNanfFCAd7plxVFOw17LfwoYVgq4KT8xk?=
 =?us-ascii?Q?gn+tOw4yaQF6ZeBeixAuJROe3fjiwmDtPD4z0QHe3WmWF2a9GSaK8ia5Gbu6?=
 =?us-ascii?Q?B8EOACzx+VYPqZvIdH/R6gNzplW37CitiOgHJFLMbW/W37iL5guQpKnq7I2I?=
 =?us-ascii?Q?J5nkI4zkwPl1CRN704VrwmKPjpA8RDuVArj4fJ+ZqFlTw6vUB9JJlztYyRtr?=
 =?us-ascii?Q?Cd4M4x/qyltyq/atGtBHjpt+73azHmaHzNEnp7TAU9LwoR0Jhtpte2Wk2RDn?=
 =?us-ascii?Q?IsyJn47hMdqjHsQHZBELLOiSUfB0uBASAe8eu7Zk605zS+GxnfuwUAIPFm37?=
 =?us-ascii?Q?UJViRXcP53uR7i9GOg4m41SnUIOFhD8QWG0AEepXtSrB+c6uE0Z/Ut5Vypby?=
 =?us-ascii?Q?D/CnmHRAyJIZu51KcvmcGV4k/7Do2ISUFt6BDw/oEzzCrkhhmJdm+y6kXaiU?=
 =?us-ascii?Q?bxiqo+uKwjN1fLnfvCV71hg3H93SX+ibaCDN4RflMk7roV82ilOniPUbvYoa?=
 =?us-ascii?Q?OeVi3AtbHBNquwVzR9znWg230ay2qvz91b0L3WFY07Vun00JuJq54CdDcG3f?=
 =?us-ascii?Q?IFUe/aBP6T4dgkVon9wuzQOndMzpgOhRM6HvRa+DGK2NO545hAL7sFth0gJ1?=
 =?us-ascii?Q?bXelYCDa/abmWf9jaaFhz5pohtp8bEnCpdn4+3HqsO6omRcJDZfBhee4BMKa?=
 =?us-ascii?Q?97gQr3ENvtTqABKbHk7ca7c5wWf1rXt1OitbL9Nwjb8/vJMaU6f1Sc1jxEWe?=
 =?us-ascii?Q?ORAF6QsVJYVITjjXYV5CQreguA3Fanis9mRD3UQiSs3qqJPk6Nd7Oic2jaIn?=
 =?us-ascii?Q?AqPtfl2QPVqLcQJ+T30Ni9vxR3GWDmdLI3GTueqDTCQFrsPmnMdZnnjVg61q?=
 =?us-ascii?Q?6jB32ZPl6bQ/8c7hnP3PseLHDmEmkqFeXki/or92eHWpY7JizUt95OW2EGLR?=
 =?us-ascii?Q?AXyBabbfpcOnNZkoHR3mbIl2ijvpX1qSPleiqGZlnpiiG7nFHQWzc3pwJUn0?=
 =?us-ascii?Q?rJ3tQw7/a9xBmqoA/FOCjHX4avV1hbZ16H0fwo2reiY6DjeXAz4H5p+aRs1r?=
 =?us-ascii?Q?AglaGJxM3OTvJQeG5o6Rr25OM7HqS5I8P4V+HCzi731vjKyOqW3sCiiqj1B3?=
 =?us-ascii?Q?ZxAGoxggXeMeeEOCBiplPMUuIVSo+IMeDjVP4FNXLQ6+7pvRN8ikL3N/mbVO?=
 =?us-ascii?Q?WG0pq4Q5+3C458hHhOQQN2LyHvClPHm/QKsGEUI/7l8OyXdfWWlSjYRp1Wh3?=
 =?us-ascii?Q?/RRwysDiMDdQthvz+RYje6RCJFDFkdPAIF1nbcM5LZQknCNq16QUjW72Fhe+?=
 =?us-ascii?Q?irf1wVrftsWmmcPZjQ52V87VmTTVLBO9EzZw01AxwPir7AMGTbz3v/uzikYp?=
 =?us-ascii?Q?6N+SSmxGYbzWDU5SFfbhiG5By2xpHwRip8Ah/lsI?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 06dc1d9d-a3ac-4954-7874-08da5fbbfac7
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2022 01:56:59.7089
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GnUcvRkafYbihE+MgjSoYvaLzf71Kw6e0AOdRpxBO5V1Z2Whf0F7hMLNTlBS8oWDVEadzBgrbY+BgAvh0P8/vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5112
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Tuesday, July 5, 2022 1:07 PM
>=20
> +struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct
> mm_struct *mm)
> +{
> +	struct iommu_domain *domain;
> +	ioasid_t max_pasids;
> +	int ret =3D -EINVAL;

-EINVAL is not used.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

