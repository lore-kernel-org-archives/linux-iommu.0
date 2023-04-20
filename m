Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548F42F22;
	Thu, 20 Apr 2023 07:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681977466; x=1713513466;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yI+tWwHe+TuopAOGGDikKJC8aawHEe7kjPF82qN+oSQ=;
  b=McWFjAQ40ZAkzXc1QPbuPV8OsFmtKKeP6GAdVozGRqfcjA/lVWvbzVG7
   cpzJmaQOGjUKU3MzHs4maFwFuTns7hE9e196W7NSDDUqtSt81oVO99fBt
   yPbzZqbj9VH2wd0nAxkxWYk1RPdkd1w5dA29xa/vYgBjJDFRc6u0Z6wv2
   6OEJ7qmrZpAg5vslp+1WRIsEpTIKMWx6iT8e2sP3C/0BzRkxVxS9RSMHn
   dkdsyB1oiLIVJ+/Zo8YTDRzp6anmMMcTzM4+sQp2bnmiX5Xkt46S2C6lH
   0Q7gKP3Hf0+YABhBLRmgnpAutiSkyXZnEeKQm988m2bsipd3+FEeVbAmX
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="347528369"
X-IronPort-AV: E=Sophos;i="5.99,211,1677571200"; 
   d="scan'208";a="347528369"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 00:57:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="803264669"
X-IronPort-AV: E=Sophos;i="5.99,212,1677571200"; 
   d="scan'208";a="803264669"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga002.fm.intel.com with ESMTP; 20 Apr 2023 00:57:45 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 20 Apr 2023 00:57:44 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 20 Apr 2023 00:57:44 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 20 Apr 2023 00:57:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fR2GPfsww+rDiOLCLRfo4pa72vrFLngXE+hAscn17mZ09R6RGOVhi4rf7sBlFtnHcgA2/Q3VkeM3NTBdSGYDzZN3GtCv6L23craOP/vOHM8hIQS7wrG+NYu6u6UQygDfR9Ue2ZXc5agefpon1lYyMCpxgKZZsY1aedaLl4Xkd8qXyDfMETiSQez/YEajVX9PT4irFQUP3vDhLbTNihsM3ZJd7Pni+zcxEG6DOqqj0lTXeYlo4kXXqfsQL0rKLDObXKU1qRj/h5nSi4k8mU5+ohDBNS7UMfWdaL7QBH4ed/EVLhbOI8QU3bjR5YfONxmGnE4Ck7Q+h8lk0262AEgB+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bDulW9T2HbbXrLdcr6ylzgKgJKM+TYL1H05VxyRKVdA=;
 b=WVDS20xMpJbZMAPgDgPsk4KewoxT4nosNrcvLna3DPkqFxAkC/MXIdNzqW1vEI956mSuZ51TCpKYBa3j+k4f/V7hRtakt4VHtwsPwuMdO+QLHUhlkL3u8RWpkaI9o+fSGPzdcvWN6SFCydaIaYJODKMCA52u0n0g/lIK4Rlr9lTrDoXf6iS1B786hMiZ6DYu1PFKmnmRAu+UUY7HEDh4s/47sKbVW5A1VC5Nw72pD7umzjBJbgaDO4DExQQILTUvzT9ntJchfqu6pAKiVksjQ0VUO4gh9U8tt5ONoNQoruP3nrgd1IpL7OHi+zkKCkO5vGmJznFUJRtpp/zpetkkbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 by PH8PR11MB6831.namprd11.prod.outlook.com (2603:10b6:510:22d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Thu, 20 Apr
 2023 07:57:42 +0000
Received: from BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::5e54:1212:2071:613f]) by BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::5e54:1212:2071:613f%8]) with mapi id 15.20.6319.022; Thu, 20 Apr 2023
 07:57:42 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, Joerg Roedel <joro@8bytes.org>,
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>, Nathan Chancellor
	<nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Miguel Ojeda
	<ojeda@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Rix, Tom"
	<trix@redhat.com>, Will Deacon <will@kernel.org>
CC: Lu Baolu <baolu.lu@linux.intel.com>, Nicolin Chen <nicolinc@nvidia.com>
Subject: RE: [PATCH v4 14/17] iommu: Consolidate the default_domain setup to
 one function
Thread-Topic: [PATCH v4 14/17] iommu: Consolidate the default_domain setup to
 one function
Thread-Index: AQHZbUX3UauLoHOmXEiZbNaR/K86HK8z4NQw
Date: Thu, 20 Apr 2023 07:57:42 +0000
Message-ID: <BL1PR11MB527116D60107658B42904FB68C639@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <0-v4-79d0c229580a+650-iommu_err_unwind_jgg@nvidia.com>
 <14-v4-79d0c229580a+650-iommu_err_unwind_jgg@nvidia.com>
In-Reply-To: <14-v4-79d0c229580a+650-iommu_err_unwind_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5271:EE_|PH8PR11MB6831:EE_
x-ms-office365-filtering-correlation-id: 5c444560-1b02-49aa-792c-08db4174eb56
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zmSpKrHaQicoU31uI4oDnZH4z9IEebODjvsH8vALPWq2biEKAmSl/VSejvah3xEBEI3Fb8wQ+BRAWK2Ns0OCIqt96+exBS4tYRfpYGmXEiZbgxSOWJxz54MBkSr93FC9jwCXDjmffN+t2Ms44cOLXjK7PFWL6hBdMbHRoakh+FrY516Gx7+iP6oYQ1bJvEiqKu3mrWVW2OK3b8uV8W7cUtyLkcoyKwmxtp2GUPh/P0vQ76Vve1dYJ01mncpmJgkT8MBSsZ+qYnBOFRmJeHHoXwbNybOTCxWlBJKDtuvzbB4ZfNww3zcJG3GdTc8AMCFWpSCsrszOCYahjSaTI4kADI/HvPhHqsvTp9pgkr5DRdClJ5IuisRvcXmdld38N3SV4wJwmmp4z3RMjxe9DVjvJStjIUHiho9Nhayk7sDPCPLsZWruJbKtB4enREEUPPTzesgnUcYUGOUozslrHR/7h74Gz4/gZtawfdYMpaLPGQjqB3ayEKhbbYDJgloO801GHc8gYLINdHvH29e3wddXlYm37hPDUFXpQ9JLWdMU7TSZwmgZ7l6yI1GaLQ6caykUZvAAwfsJAxrxtMdqnsvnULzMZ88tdEGw3ZJKxZwbDinbCW147M2HT/I42GEjDAuG2lE6IJkhv2FFcppJrrJNRw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5271.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(396003)(39860400002)(376002)(346002)(451199021)(4326008)(316002)(38100700002)(64756008)(82960400001)(66946007)(66446008)(76116006)(66556008)(66476007)(86362001)(5660300002)(52536014)(7696005)(71200400001)(41300700001)(54906003)(6506007)(9686003)(186003)(26005)(38070700005)(8936002)(2906002)(83380400001)(8676002)(7416002)(4744005)(55016003)(33656002)(478600001)(110136005)(921005)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fmH/j+NDuFRLYnQPIpOsFfosqNpyWcE7yJnn5hpFURtOTwzQt+6U16ani3cz?=
 =?us-ascii?Q?vSR7ZTFUkc0hODYzmULqgQ8RvQey54Q079EjdH1lYkUSOg8rqmKKBVFaMbB3?=
 =?us-ascii?Q?ZJ36gHwoEIUdfjerdeeQG8wn7hnCmgI5ImwigBZcIKUq8xy+riUj5G2RAEOb?=
 =?us-ascii?Q?NEvTjdvaBDxo62edhIENQaHOob7BcpjLg9lEdqL/Lc0gwJGPWiXuFDxBjz3v?=
 =?us-ascii?Q?1HPavE5TW9YDsY1jYIw7GVsQtbIpRsKgjmZSF9izPGLcDPE2BKihGgA1tXL/?=
 =?us-ascii?Q?y3qqW8lwyyhIRIzKzTvMNQ1XB3b6pUVddIlO7oWI6D6bHqAV+Jik2w2qKD6U?=
 =?us-ascii?Q?F8qqQUI4+6MuCALvprOShsw39pGkspD0X0xks8T0RBigSH9WD16dfDikTKvy?=
 =?us-ascii?Q?UPmCFTLOKYkxS2KKZMqVtRlP/WdzTbbvpRKi3JFS+9fiiyuTOpT9BYvCVAQp?=
 =?us-ascii?Q?7zpB1xTSmVS5rv/fnjGc76pDK8RALVlHeQH87TBKWlpdwvVyPQOy3bATB+dK?=
 =?us-ascii?Q?xcpZKdKmNSepKBgv5wdrxvGwq0sv5z9ykhZz4S97hAsSoEG+B27TMmqAR7Jn?=
 =?us-ascii?Q?MQxcQnoGuN614sT4lqgP13+KSbuISAX1XbIVg9aQuMzLaYeFR234gX/G8nxK?=
 =?us-ascii?Q?xMtDbuucd1aCjLGN0wj6cL8bvBefnHQOSQTEqWCoJHdwof+tXhi6vxdAweyd?=
 =?us-ascii?Q?b8IXHCVwIuXgXOG1Q5Ro8jwmK2gEOglvPdiseYIWjHrsriakjajAkj8wPdP2?=
 =?us-ascii?Q?600Rgr6Tb3jBwALRhgOVihl4Og2HRMHLOAzsk769DiVP+YhRbIueGkQBgyZP?=
 =?us-ascii?Q?tOa4doitfH2Efc/I/46T+vOj6L+hneVCr7adbXKdgDN5dvL27ZmWqQk3InDs?=
 =?us-ascii?Q?fcHtqe1pGOZF+l6ckapa20PndF+IX/W5khk7adZ8D67wDPENBt7qlDHSyNvd?=
 =?us-ascii?Q?DkMUio14Dc1Tf+xfXYPCwwNlH4YMO8aXZR86HebLwZSqarz4aj4FTg+GfzCT?=
 =?us-ascii?Q?2EmePz6YxEj7d/ZIlWBsKdWqElNwvwOIjYe7jF5jevD6M9aE20mibRinKRxE?=
 =?us-ascii?Q?VBzK47ewOaoVkR/9IO9cQauPg9tguM6iKRlTqCR9xAdFBlPAb7KlKPetN0ao?=
 =?us-ascii?Q?sYrMyZed0Q+RMohEkkcNtt9HwIYACuDa9vsasiSL16AqtCXIV+/RYYojOCCL?=
 =?us-ascii?Q?voa6/VYfVSUvenkRqfzF9Sl/2qtHDaUnSENPH9m3U2YsU2N3QMbfVewaIAHR?=
 =?us-ascii?Q?YdV1fOQz69m/af8ys5cnRvHhgJIYkPHcKL9UaSesxzCBawouDAEDCN3G5gKZ?=
 =?us-ascii?Q?J5KxuUuU+0C173Vrtp/ulE9Y5hAOzBd+YQmzdjtyfnY/uG/EWCYTRSzcJNRw?=
 =?us-ascii?Q?+kLfguJRaJEvjs0+y6IbDN33xfiQYmyX3skns4YTjWRCxzSUh5D23k1Jjf8e?=
 =?us-ascii?Q?mt7s4WchyHL0MZUwvMZpqTbo1Arf8Qjg9+WL9qfI1c4FpMCryQstN71BTNny?=
 =?us-ascii?Q?KXGn0LY/rfnpffnyffTQtTwQUEqP03HLmOF/rK3bXXzmA4pnwyeu9bxGWc9D?=
 =?us-ascii?Q?3NPgzCf0v1ab39mjw9QrUfaWnlp3L4bT4zD2v1Ua?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5271.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c444560-1b02-49aa-792c-08db4174eb56
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2023 07:57:42.3323
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YsECM1DR11KCf11hc+o+/Z8BjOMqN6Sx8HzzPbREjCV0z0CYJqlOCQUaWkjy0BTxVuns+hP8oAzH5RcLCN446Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6831
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, April 12, 2023 9:52 PM
>=20
> Make iommu_change_dev_def_domain() general enough to setup the initial
> default_domain or replace it with a new default_domain. Call the new
> function iommu_setup_default_domain() and make it the only place in the
> code that stores to group->default_domain.
>=20
> Consolidate the three copies of the default_domain setup sequence. The
> flow
> flow requires:
>=20
>  - Determining the domain type to use
>  - Checking if the current default domain is the same type
>  - Allocating a domain
>  - Doing iommu_create_device_direct_mappings()
>  - Attaching it to devices
>  - Store group->default_domain
>=20
> This adjusts the domain allocation from the prior patch to be able to
> detect if each of the allocation steps is already the domain we already
> have, which is a more robust version of what change default domain was
> already doing.
>=20
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
