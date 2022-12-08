Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCCC62C
	for <iommu@lists.linux.dev>; Thu,  8 Dec 2022 04:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670473623; x=1702009623;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1CsM+zBPAayoyGQXCxRZhzGW0ol8P7PLjOQz+aoIiSM=;
  b=DJ79/7UMGAGbZ47MelpMuEZFIBBieAwQqjWQMPWn9HLjvWvaAIojH8/3
   L7EhIU6RTAqDGZzAF3vZwqWzn8oKxcCG3WVFbPVKTMOxMFl6tGzuovTwy
   eJtcPh8JUzkAVFuY+y00yDNqg9n2PcMLHPDLg3cygTXFLmsjf4Vd2LVio
   pnXxGyAgKOE6mCw4eB346LXMizGb7CRMbEbGeApKmiKFbsUQqJf3lp+Yf
   vzoMkIECtc0B4QVxh9xvhAsSIfKOpzBnqfffEuFRhInKo+JSTQxeEwuF4
   yM0en6f9Wz7PwE19szVsuCrVt7ZpONbhm76Tm0CkkllH/t+RbQeKDQClB
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="296763628"
X-IronPort-AV: E=Sophos;i="5.96,226,1665471600"; 
   d="scan'208";a="296763628"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 20:27:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="789152712"
X-IronPort-AV: E=Sophos;i="5.96,226,1665471600"; 
   d="scan'208";a="789152712"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga001.fm.intel.com with ESMTP; 07 Dec 2022 20:27:02 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 7 Dec 2022 20:27:02 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 7 Dec 2022 20:27:01 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 7 Dec 2022 20:27:01 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.102)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 7 Dec 2022 20:27:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O44axxRSa3/4c5O54WdMoBsblC1zjNwpyLSM06rpgqK2bCN5kWXiBRorVc6aummBR9Cb+uFxw55l0mU7NN7OSanjmnOlD8tuo7sZmyCUsgdatGWkW4ODheKD0ywjrj4s18NvsP2oukDR9SiXgoRf5PXFd8f0dUbQD5rOdTM10eUngRPb3vop0bxmDELTOlV0Y12HVDq2OQQyiFtMNGQR/aIMMejG6pCysE06Qdlt8wi7pZXX3HsWL2KrBSYUjIwOgZzWlNMYSDka0P3MPDOY9+SugvxsRQoooUNMshLaRNHYqT6oQX6nGQy7gMeau0GMhE/J5B3devJAWZdtcmRcXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1CsM+zBPAayoyGQXCxRZhzGW0ol8P7PLjOQz+aoIiSM=;
 b=l9UuuxFUoc30hK9F/hkFSEx9caR0Y0hzaaLX1M3WNfwK/oZWWBzXh3qk+0BHYMn5Y0UXe9/NzAMKb7pyc34uUDsuBpJcuFtBGNKKUuUSIpzMWxgogKhz5TUM32wa6DTIkidXpFdYq03NB4y4qeoEnw5DpcdSaqNjX8DFUtWG+5Amae/6PDt2qwraunHCqk6O8Ok7VpBH3Qck2xgzh6Jx1gnKca8jJqsniBi17YrL6IZAiAOdb4I/PKPvVBokacmMHHZqQDTlTFyDNBowY3S/ALelkjn2q/Y8rhSy9IHQPQVOKUN2pIdRUb3uQtr+ZDfiYQcMusaqsZ31KE8n+Skyxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CH0PR11MB5473.namprd11.prod.outlook.com (2603:10b6:610:d4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Thu, 8 Dec
 2022 04:26:54 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::c9ee:bc36:6cf4:c6fb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::c9ee:bc36:6cf4:c6fb%6]) with mapi id 15.20.5880.014; Thu, 8 Dec 2022
 04:26:54 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>
CC: Binbin Wu <binbin.wu@linux.intel.com>, Eric Auger <eric.auger@redhat.com>,
	"Yang, Lixiao" <lixiao.yang@intel.com>, Matthew Rosato
	<mjrosato@linux.ibm.com>, Nicolin Chen <nicolinc@nvidia.com>, "Liu, Yi L"
	<yi.l.liu@intel.com>
Subject: RE: [PATCH 1/3] iommufd: Fix comment typos
Thread-Topic: [PATCH 1/3] iommufd: Fix comment typos
Thread-Index: AQHZCnzIEi8KZKZmqkO7WXmA0dhhMK5jZYfQ
Date: Thu, 8 Dec 2022 04:26:54 +0000
Message-ID: <BN9PR11MB5276665080263A2A8DE630C08C1D9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v1-0362a1a1c034+98-iommufd_fixes1_jgg@nvidia.com>
 <1-v1-0362a1a1c034+98-iommufd_fixes1_jgg@nvidia.com>
In-Reply-To: <1-v1-0362a1a1c034+98-iommufd_fixes1_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CH0PR11MB5473:EE_
x-ms-office365-filtering-correlation-id: 363687e9-16da-44c6-40e9-08dad8d46fab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IR+5ivDq4JE+f4QBgWenAaHkmZjA5LMmluCThpnV77TW0VNt67P/Vd/rRv31xUWypvXtPGd/UHw9y1mlusqSQtkEHRCBWwFt7LoruNDMmhP6noLIZWYmn7IxIwZLHShJbi325VM2A7TQwMR3FNkhj+17ezRnIn/bzDylxV2dWDfBrnN/PrzWCQL9MjUVgAOCp4Nlrs7fGjBQBnYCrvIJAkLyGeHH1t1Cfi/MD3FBENC1ssX2oOkUTzb3ZugA31RAglS5YJw0KXudV6oRbIi4qgZ88+IUyTXoHp1UKJ9zF3oerIHIxYPPGvxzm3+It2jwkQPRVTjIQyEa++nJeRP7N/Dj8Wcd2UFT4vfXG4Y6zhbzrNU+DkNHEDO7abO19r5EitLO7XAJcIK2/LHaAlz7fag8424B0JEvZxYvmzvND90OXB4qVP67GmEm4X3ojJWLxs7E0H4slR1b3ts7DzheaS7a/D9OM2Tvx428o0UkVAaWtkZSJp8FfHwYyy8D5A60TTSYkw7Yx2oc86W8YizMpRU3vOkf/Metu3umQpmFlI1Sd1A3okVqAdjVae9agvbyzqDwcs3X3S+Rc4E/Mnt8paab9PjZ8tsRVYUCUmG6HZoG/fesLh/36IlR6kKEkd5fqW2+DASI6JOHFlElrr5TbFTMODaQsz6K2MuVFXUd2VZFREa5IsRYpv9HTqDi0ZE0/pKIHtfXhGaEGLfl2N3geg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(346002)(39860400002)(376002)(396003)(451199015)(54906003)(558084003)(2906002)(86362001)(8936002)(5660300002)(33656002)(4326008)(38070700005)(38100700002)(71200400001)(83380400001)(122000001)(478600001)(66446008)(66946007)(66556008)(110136005)(82960400001)(316002)(76116006)(55016003)(8676002)(9686003)(52536014)(41300700001)(6506007)(186003)(64756008)(7696005)(66476007)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kHerraDtQtLHgLo4txh2INa0ceW2OCiN5zdOs7rpHKLQGcjPz8UJQ2fe9Ssn?=
 =?us-ascii?Q?yC48eNTKe1mFACNJm2GNib2Cl5Td/BEV15THJfPSRK8S3uQtVZiUf0dKS0Ew?=
 =?us-ascii?Q?gqQfhaYqSbvWHcnCgmA4KNqibxXUDkAQylOWDEpCaFb+6ENTRpc80QlWqEM5?=
 =?us-ascii?Q?x1aFOJaNqOcQ5lwhBCfcJ0FIO75WkLNv+ASv5clrBDYs0dL0vukza35V1WoA?=
 =?us-ascii?Q?MjchrYV8mlFv8mnTYASabWprOyusRYeoL3aVyGiFZaTwFLIpfjPGFY/oE9ok?=
 =?us-ascii?Q?jvZevkLhmuy9ByLhxcLBYa+rX9lAkhqePyf8wZy6TyuUGnMm3/MKcsQS5ilx?=
 =?us-ascii?Q?yigPGGrI+pqxbTAWRxgY7wicWiClVL1w8vPO0qJ3ktBgtzaXD0jTISCc6TnB?=
 =?us-ascii?Q?UOIXP1rklsh7mBAwAx0byRGurONQnxkzWDok4wX085rRTTBdkEfQzs+WirL1?=
 =?us-ascii?Q?4Jg8Oh0dt5KWW5BnKuWATRISmLVFvWvChFqtXJvnJ6/7+niaJzJ9woAh/7wb?=
 =?us-ascii?Q?8bCJ3zLI6MSu2sP3smVg7xGhmyz9HgcPVvt2eBihK8Vv9tmvkSKsbGfEj5pw?=
 =?us-ascii?Q?/fi3cehNkDCSTKmQ4a5QwSt7Cy10LBiXEibKtSZpt9QG3G5vQ3EGZ3cwMQ3e?=
 =?us-ascii?Q?Lp7+vk5U88/S1zdBV1nSJAcfn486alQSTu4QSRn2rxegCCi0O8JX+km8oCBL?=
 =?us-ascii?Q?TD+Qr6idIZQELvDmFBq+8lVu+JrmAooVMCYE+nSHeooON9w6GjPkdthL4Mmk?=
 =?us-ascii?Q?wggecizYTpWh41l7xwlkrj+xMJiAhnumIHSHfpBrp5iO3YVED7SZHnsUBmNn?=
 =?us-ascii?Q?5MN28fMO8AMa8zhdLaVIQ4FZLaVUrM29w4a8nNT9O+8wse+g8MOgocAoeuzC?=
 =?us-ascii?Q?RfgztUxPzKDoJNnWuqw98fxQulgVvRZoIucPtAyjTbZAa2CefKKg7hHvAvUj?=
 =?us-ascii?Q?RZzsxxgHaOEhZ9FoPFKGl13/aIdXfFVL+nk+TULcCzerwkSUkxZoHdeD/UWZ?=
 =?us-ascii?Q?dbsmuvTcTgJu7aSWIKoVwfmAIpc76RYnplSALr6jN5ag4GwI+5foFF62bFTG?=
 =?us-ascii?Q?dSQbmpQ68yiMbF1oIH8TAEcc7WyWIlEFg5d3oYPPRf5jRWZ0Uk5n+5ZO+5Pv?=
 =?us-ascii?Q?a+fvJx3XHSMSQRarAdNG2Rg3AJQPj1bXTi1RRsJThpBI1JyTYCfVtyO4YAA1?=
 =?us-ascii?Q?CSTnxgZ83G+Fr3SLzVMmHmo1m4Jd7pOr48EAYY/wkoDjJVe0FUM/wgv+QsER?=
 =?us-ascii?Q?NeHKEzOHxvnCyImK+F5jKYqR2C258FGSpSKJ/Nd1d1mfvxaYbx4/Fh0rat26?=
 =?us-ascii?Q?g/qY72obPje5yoyPY7xjjRZk1V10GZtLiiecBg1nwJ++1KTIyTFBJdJNHVya?=
 =?us-ascii?Q?iieN1ARWv9X+Xdy2eJZm6ZQ7hyTuHK/XMe89rKJf0rtLpkwU09A8A8LYUpRM?=
 =?us-ascii?Q?0oEmSULRk7c1v5RdZ5EWnYNV2YNQwDCd+qTs5t96nro1cVseYENo9++aP4/K?=
 =?us-ascii?Q?WIPttq7ET2opS9psAqA+CQtsgsItOcLuzqf+jh5o8Y4eyU6Kb1ebfuOCqbll?=
 =?us-ascii?Q?Gnoc/OX/KkNC9cM5EdgeHmb8NwkQ8QqsLloAeJfM?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 363687e9-16da-44c6-40e9-08dad8d46fab
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2022 04:26:54.4194
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6pS2Z9dc4S6gdk7NfwLnFYKX35p9pUUR1SrSp/5YGNBoNxQ7Tb/+ykqiMmr9f79lhTa1qzOiWTQhPTCXrL6i4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5473
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Thursday, December 8, 2022 4:45 AM
>=20
> Repair some typos in comments that were noticed late in the review
> cycle.
>=20
> Fixes: f394576eb11d ("iommufd: PFN handling for iopt_pages")
> Reported-by: Binbin Wu <binbin.wu@linux.intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
