Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45A710EC
	for <iommu@lists.linux.dev>; Tue, 31 Oct 2023 02:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aDaosrHo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698718467; x=1730254467;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=0sGaPNWz/3hehNt4HaJOkpWCtN8yDvuxyaQWg21mdTc=;
  b=aDaosrHo0vVGm8j2bLI1WHo/O96hcYFAS9tg9ZNg7Uw2z3DXJbN6V6CG
   qypTsJnnOzCxw5bwSun1pyisDf6OX+wtJcajUhtH3wLKWj4BL4GKyiaLl
   54UAbGkaGkFPZSSVlqpqKMjP4c00IpqKWW4ui6ZLqU0hc6Vpca6e3tQeo
   xEqGe0SUyTneHezU/lX4x6Ov3sbPOQlfyXLSMDK3THrV28taeVUdC1gOm
   ojlad40L67DRjjDWG5CR1p325WnoI2ytFgv+A8r1NEnl0DUUFtnxgBw7o
   4oc8SefsQBapVoK0pZPKKD3CY+SzNZPUu6fN5BWKK5QKRcuXkhhtUDrdB
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="387078886"
X-IronPort-AV: E=Sophos;i="6.03,264,1694761200"; 
   d="scan'208";a="387078886"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 19:14:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="789636633"
X-IronPort-AV: E=Sophos;i="6.03,264,1694761200"; 
   d="scan'208";a="789636633"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Oct 2023 19:14:26 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 30 Oct 2023 19:14:26 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 30 Oct 2023 19:14:26 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 30 Oct 2023 19:14:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JNy4OOSQMehO/PTa2zclbHKwRvGnh352FReZ9atRlQZhSziMhiqkOqkUBpNuI+SPxVdaLmQSLXQRIt7Qi3eGXhbsT1WtzTkPfUhUyX9LzTr+Xj74+zIWvyKugDqXuIFSphmvTxZkv1swsUN27eHJxy7u7vZeYInRZldexQvGQMw56PG/0PNeMG32Dms2S5fxafGA9aBd4oUO8GUN7pHurE0KVms7N/oTL77RRs3jWSKpelhwKjsuqC5HSo2s8Ab9CLyPgUbeLeiaviclLxSqLaVIKLrv2kandD8wYD4LeTiMJmgubG952QqZpd2cR+SFaWXMZPVuYPon6HQrOODFvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0sGaPNWz/3hehNt4HaJOkpWCtN8yDvuxyaQWg21mdTc=;
 b=bCrZOyTLciYyv26Q8mDxUkZRUI2bStYYqh12F6rfte/RQKFZ6nLVERup65YbVUYnMNaDsb3PcAHhJlv3XL6MjpTZ5QAXfhERYllN/UUcE5vL7ZQ23qNE3MBx9k8xnIkDZSXxAQ1IdRMKtGvpFJ7nFz09HcjgM2HLn+031HyRSy7nQY18F2Vv542VFm3lza8djQKs+hgrU+ryPKyGOnmBcuMAx4+bIeF28CuQHiJGWC0AyMjXwx2IekBPVqkRvwFKuodsuNnfsGIlGHWt8AlO6f0DYtFKYmQMVDHSwB3UI7JdrkQxO7qzTYS8JWV7bcBocKCUAE/O0hUOFhaiVc6Z+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH7PR11MB6721.namprd11.prod.outlook.com (2603:10b6:510:1ad::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Tue, 31 Oct
 2023 02:14:23 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a%3]) with mapi id 15.20.6933.028; Tue, 31 Oct 2023
 02:14:23 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, Nicolin Chen <nicolinc@nvidia.com>, "Liu, Yi L"
	<yi.l.liu@intel.com>
Subject: RE: [PATCH] iommufd: Organize the mock domain alloc functions closer
 to Joerg's tree
Thread-Topic: [PATCH] iommufd: Organize the mock domain alloc functions closer
 to Joerg's tree
Thread-Index: AQHaC4PsemmrW919o0WRSe6ZFSAymbBjKNGQ
Date: Tue, 31 Oct 2023 02:14:22 +0000
Message-ID: <BN9PR11MB5276AFBA21CBD475B49D09EA8CA0A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v1-90a855762c96+19de-mock_merge_jgg@nvidia.com>
In-Reply-To: <0-v1-90a855762c96+19de-mock_merge_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH7PR11MB6721:EE_
x-ms-office365-filtering-correlation-id: d67bd8b7-dc9f-4144-9600-08dbd9b7194d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n356BaNqihgcaU9SRmhogq0XxKAHdWRAi3W3/p20MhGA/6ZEESdKjoJ5gsSvH7TX7rFXqN2wKOA7NKZh+7AqjxA5zbW+cgcN8Dh/+2kfcdPKGzhS2Gfk3NzZduEi/Mw9fBu4gLypO5GsnRXId5oyOX/fOJX1mfVoMFvrsFFLPxpBKh+8DgmkMYWCX8HX70TH+I5mZ/EuMwbTU1hkbMne7voB+ELCGQgRPgM/ub+sshHi+W37j7+n9nnYFeEPR1RBfaQ5sae2Q29GSow289Y7OwCXSfXjiSckXJokswUFjkSZw6izdJvXBKF7hBBJAARDbAeBjn9d3v0dggmar2itnYsldEIaukBwtmqBeDhIsnElnAtljRk682dHgJgik4rNUaZp+XoQJNcNUZ3z7+hL/TW1Lt/QrU1ONtaaQ9A2kTccISh/4XXkAo/QJL7dwAab0RaP1PghGkR/hBwqDzdOJd8cUiotJunGyut9ocdnXwsDQJ/UKkRudhglKvmsUkpqqR24DrjmwfOB1zhHP1WGHWwg3eEDbPwlevUs9lls9EIC4zv1co3NNelBINol0p6QgKZM1FL04jHmD9kYuOZXisRSsIY9egD+QtOZXjoRXfN5yPWXP8VfzpfvdbnIsXmM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(346002)(136003)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(122000001)(86362001)(82960400001)(33656002)(38070700009)(55016003)(9686003)(41300700001)(478600001)(4744005)(7696005)(8936002)(8676002)(52536014)(6506007)(71200400001)(83380400001)(2906002)(26005)(76116006)(5660300002)(66556008)(6636002)(64756008)(316002)(110136005)(66946007)(66476007)(66446008)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rOEKXXXN2zhN+WK+vmvsaL+xNcGS+g46l9ZyTA+aAXXVEw06wRc7RZ9kpRkj?=
 =?us-ascii?Q?pKamK1OM1sx0bJZZJBt42QLVVNPFe/Emmi0chqDIL5bFr7QhDRM4nx6uL1OZ?=
 =?us-ascii?Q?P+LjPODcvQfrm42w6tt5c0iVV/BA5vwjmO2zqYMmzDiO1ilrtilzOUqx78Pa?=
 =?us-ascii?Q?NTydFTMH66fS7yMcRNC4xqQ0eb0opkZ+mhOqOpZTHjozIOYmrxMCL0RBB3xd?=
 =?us-ascii?Q?4tZRPRCJ1YgjihO+zWuqxwOgamdvDEqZ4huPP6p59h7SFlpUPSLdk8EcJzre?=
 =?us-ascii?Q?v5JuN66KXgwAnYYwfbnESEFOvlVd+jrUU+MYjczbkLhu9lApPEWXpbKAHWmd?=
 =?us-ascii?Q?CvC6AVkj+U3w5vZfhzS0ZUBCQPjNaTSgp+NFeMlMgzS1cXF1N/UZdYPWMd0c?=
 =?us-ascii?Q?BjW+voqhNI+wtw+fnWWhMT2DT7vd1GR0kknr/SJWcP8D7bLsVrTeDnvHomTE?=
 =?us-ascii?Q?sxbkBFUsxR2NZU9pM93bjh5c1TutstNPDGz8/id+zSeBUTtyWsrafz3HDuzd?=
 =?us-ascii?Q?scgWgBNoLKLvQ/M1yutmuPe7K4rEzegHGNxn/rNcBs3nVuzen7xroDh5QyLt?=
 =?us-ascii?Q?qfo0TDAhNjQM/S4+UM3M+AMmV0cZp2KGPwBd8XoXmqPmX0aQCg3jBFWkgPtk?=
 =?us-ascii?Q?jZ67QGgIoMPEjLTzkOEyq9QvbfLq8usk5d/KJdVjXaPY9fCG6qkiwv72rTOA?=
 =?us-ascii?Q?juL2b2PX6wKTFAxGLQAEtQd4Vwv8Fc6LvZz3oSEeW2GpUF2p5tvyjUxza+Q3?=
 =?us-ascii?Q?TxGHiq3lnh/4YKP5iFGrgCZV8xbmGAFHPk84rIFJuQ2M9d7xuihXn4Pe/Zks?=
 =?us-ascii?Q?3DuGF2Or0SmpDCYVuyECJqOwzEH0TtZ1gjTA0fTjuTQhLd5EoFLCFYcCPEOR?=
 =?us-ascii?Q?ZopleF/u5l2fwvpttGwVfv9/JExg/JL2ZR8clBTGru73Kc+xWxFO5J5BHBqO?=
 =?us-ascii?Q?PqSnsxqPttWbdf9ieJ7KfFGYN5rOm4PIadwqHCaU1H99CHxPQ46u/h7NY2ZJ?=
 =?us-ascii?Q?qS/ez3WuE8YujJMhU+Bu38Od+UED+qN0VRolpQ2+F8W0DOQ087rf2RCYBu2H?=
 =?us-ascii?Q?NP+FDrRau8ZY4CP56io76IpyaA1QQJvjLRMn/+Fg45lEgd32pF3lY7GurqlP?=
 =?us-ascii?Q?MYuMDPtpYWd9q9VadzdcfMIweC2+XLtucl6KOVXtHkjzXGjebU2HmWsk0tny?=
 =?us-ascii?Q?BQKzp6pshokhBz3Mtz6zTSzTW2BWr7yB5Sn9ewxv+Pr3LQ9XaXZRmLHTMC+7?=
 =?us-ascii?Q?PFscC3xMwGxAOcl+p0l9z8XtTC5hVLoQ8MO8L52JJyQ+BDzyREoiLbveP5I3?=
 =?us-ascii?Q?zQ0XDI+AF6W/I0FQcUbP5txicbUsbkwoEx9D5k0Rm1W0KUKxfXmdgpDUXnRg?=
 =?us-ascii?Q?pZaE9zg4/se8EOTT/t/lPJlVFvHRst1HrclWjzxO9ZfccyjEmHorfmFXp1uT?=
 =?us-ascii?Q?zJbBL9Cfn+olZuZjb2jTUURK7HIdcy44uBKKkWjs/Qc65c1CGWeBtEo8yOw5?=
 =?us-ascii?Q?ihb4QFznkQOfgcNiYd0EXPBp1xn57tOWW6KgJs8yZV1pRFcgc5jP3xF68EoN?=
 =?us-ascii?Q?nX+70E8sT1blzAJXEvT3tR8euj5TxDuUq6Xy5GmK?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d67bd8b7-dc9f-4144-9600-08dbd9b7194d
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2023 02:14:22.9585
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VPf2tHswqog0RzFVQpXYKI2YOw+968eQ5awma/mLOE59iFtqf4lTtO79IhHSk7rlvKOY/usnAFQFZrMvtYZuCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6721
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Tuesday, October 31, 2023 6:53 AM
>=20
> Patches in Joerg's iommu tree to convert the mock driver to use
> domain_alloc_paging() that clash badly with the way the selftest changes
> for nesting were structured.
>=20
> Massage the selftest so that it looks closer the code after the
> domain_alloc_paging() conversion to ease the merge. Change
> __mock_domain_alloc_paging() into mock_domain_alloc_paging() in the
> same
> way as the iommu tree. The merge resolution then trivially takes both and
> deletes mock_domain_alloc().
>=20
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
