Received: from mgamail.intel.com (unknown [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DC946AC
	for <iommu@lists.linux.dev>; Wed,  2 Aug 2023 07:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690962107; x=1722498107;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lMf3vp64vmxhrMd11w6v1aF6rZRhNw5jy4W3a0L+jg4=;
  b=BmP0L1sY4DLeq+BCU7RcRfbvZA3GfSUK/nbncJ20/WHT3QlJZzRjQZuG
   a64P+Db0sph+eHHDGKLdvBSWdHHrbJPTQtwsDP8dHvq/NCmCww/dM5vgm
   VUmednjtOPobeyKNjo4OUSrmQ+sQN0Ie+pZjXl6BNYEhS7C0v7wx6RQoT
   AeEWtFQ4GSzJKFieXnNahYzO3RatLPxIrbjnU9pm+YJW9i9NlRJYqjgwY
   kK4O3lhgCB3DseC6+u37YfRyAB5eyNkUyO+nE3TB4i9bKZovpIYA9CIps
   nYsFq6i7zIvD1aC/abL+p3HvVTBEThs1CuTYgtNAfL8ryWazyNGuLXD6N
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="400452719"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="400452719"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 00:41:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="852784304"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="852784304"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP; 02 Aug 2023 00:41:45 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 00:41:45 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 2 Aug 2023 00:41:45 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 2 Aug 2023 00:41:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hwnb0kdGBhx+XlIUGrPyQMOplxvuBBazHoXBqOHMnue/PXAxTxdHhoWF5kgBJzylPWgo/PKhDurkrChqFOIuLzvx0ukqsL1TnPr+Cj3BZ5dEt4itBjfoGXel9W+zngslFrZ9SuEpJPXsiQ2/oJNRP8cygzXrV1NP0YM6d0NphLm3ZpZivocZz+OI4xfhStBobmEDhyKrRW58bt66fgMwsy55Rhk5R/MR1q9Y3VT+pNENwQN/lPruQNfsEAOeltRIUnlruXIs1+tbG3Pj8oNbtEEMkBo1RegsYpdMfJXSfai+xQ2vTNkomOTRlR7FfK4pm3Io8pX0D0kldN1xGtcouA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lMf3vp64vmxhrMd11w6v1aF6rZRhNw5jy4W3a0L+jg4=;
 b=dQGjQ1ONbBWUmTisTdi0/mdn7rcReAwsOS9uiMh6xr42oPORWR0a48/o2pkzxScTyCk58zpMjmZYmelwRmBZNSz1BwVy1IK9BGYu9qYrH8JvahY7VxSRNuJo+UdnrXKyV8VgEaZ1yLyHcgsn02FVVVCZCaRRE+XM4UUdxnzwu+kpwi/nvQm3FkClzNl8x/jfM9kAPMuVsv779WDKy0qIGZsyEPk3pwf/ChBQwFG3wohY2GYCoTeTqfT4kwu6IZp3OxXltonmaUqrketbufqYCKAoaFAO/IKodY7Oex+Cb2Wk8EELXaGfpzXGe2b8Tn469JdwXpeUmPfbI94ZErAh8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CH3PR11MB8433.namprd11.prod.outlook.com (2603:10b6:610:168::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 07:41:38 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dcf3:7bac:d274:7bed]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dcf3:7bac:d274:7bed%4]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 07:41:38 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>, "jgg@nvidia.com"
	<jgg@nvidia.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
CC: "cohuck@redhat.com" <cohuck@redhat.com>, "eric.auger@redhat.com"
	<eric.auger@redhat.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mjrosato@linux.ibm.com"
	<mjrosato@linux.ibm.com>, "chao.p.peng@linux.intel.com"
	<chao.p.peng@linux.intel.com>, "yi.y.sun@linux.intel.com"
	<yi.y.sun@linux.intel.com>, "peterx@redhat.com" <peterx@redhat.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "lulu@redhat.com" <lulu@redhat.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "Duan,
 Zhenzhong" <zhenzhong.duan@intel.com>
Subject: RE: [PATCH v4 08/12] iommu/vt-d: Make iotlb flush helpers to be
 extern
Thread-Topic: [PATCH v4 08/12] iommu/vt-d: Make iotlb flush helpers to be
 extern
Thread-Index: AQHZvh/ux21cFPi0W0WqfJDCTp/C8a/WrTBw
Date: Wed, 2 Aug 2023 07:41:38 +0000
Message-ID: <BN9PR11MB5276F7D08D44F3EBD88E504D8C0BA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230724111335.107427-1-yi.l.liu@intel.com>
 <20230724111335.107427-9-yi.l.liu@intel.com>
In-Reply-To: <20230724111335.107427-9-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CH3PR11MB8433:EE_
x-ms-office365-filtering-correlation-id: ad60de96-eb6d-4d25-2001-08db932be7a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uPumEZo1gKREhUITqw7XYbjDL9mOHsR7gV1OV5GVzc4AjlnOH9QX21pPvP9kPi4Na4jEioIsj7w7qAbXQC87rqR4Zbweap5DuO5gq1v4VFJqng1BG4ImKq4wleDJBkvZfCzzTHjw9owFzATjWoAlVC3os+veOuHSnvqpdHiB3Fj7DkLMAFATWTojPG4gXQ54tGTXsMtDFqwj3lYgwxr04s/a6Z7DA//Y95/s1RSXwUrlVBoTmtTAc8KNpt8X0q1EqOXViielQf1ptiC5IZZZYFIEQ+IdbJGlerD6r9UbykCP0h2BaHlZ7vkOhPt4tTXu+/IGEwdCdm++MyNubedjopW8FpXyu5h5Bl+7Wxe73eI7pXb0JbaBvOtiQGAwSviecQjtHXo0PbyoPbBjz+637kav5q3GSRWLKsr4SgYf3/WrCbFXMpd7PIXPjuKepS/ym9MHtqir1OZqdw8sNIH/vPEubm/U84+xqvkRR5VgEbmbP+d33Bz6CQPyqLPLUmDBW9V6mdVWpbHRwwqA2QVZkhKbfFqaufgr8nitpZhwbAxuB6DBoVs2SaQ3xLx7devD2amtVQoT3TBbwUsUY/TWktQXcfke0D9V+kqe3YUn5FD7dy71y4N9TaJUepWt3/MU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(376002)(346002)(396003)(366004)(451199021)(122000001)(6506007)(38100700002)(26005)(82960400001)(186003)(38070700005)(2906002)(5660300002)(8676002)(52536014)(7416002)(8936002)(33656002)(54906003)(478600001)(110136005)(86362001)(9686003)(71200400001)(7696005)(55016003)(41300700001)(316002)(558084003)(66476007)(66556008)(76116006)(64756008)(4326008)(66946007)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hqwAhadjrCdcjMTUIPnm0erbxhYCOsZlzC0rvpcMpv1Pq9QQvQmd8XLJlhqG?=
 =?us-ascii?Q?+rzJIR0Dh+S6XMGyCuxS9DNgDfY4SYnJdnJ+C3p91v+X9AaKv9iz3RQ8ikdp?=
 =?us-ascii?Q?ofNcYZRC8mCpIXK52bExAWc5za1Pedq5Y/3i5nYMuCtSgoEUy4d38FPtV6N9?=
 =?us-ascii?Q?wgPMYvhjHT6etddNS0BqPZOLWKs0x70RMnC96PnkrvkCY4csVWhh7Lpqe0JS?=
 =?us-ascii?Q?Tp659Sem32H0+NR3lZ12nthpBlc7m8JjRpB5PCJMkgu7JJvR3/MYqAyv9A+n?=
 =?us-ascii?Q?KCBtQrUBrcnvsbZCtaHmxr0jqNSAfXPkR9o68mp7sxsyJYMjKH5rsrToEQ5I?=
 =?us-ascii?Q?km5i35jKBPi5UrSt7kJbdS0YR+nM1Xv02tmL+orbIIR0/Ij8ZcCl19fL9ZZq?=
 =?us-ascii?Q?6oHwfZN1mLJQvarDjcNq/J8mNJn5h+t86xioRwGd9PsyfjOnahigNR1yASxA?=
 =?us-ascii?Q?pwpsS8FhAV8KLTtEcN60n51DKRYNZ5xZmbmz058GV21t1f3JRu6pjl8aBSPY?=
 =?us-ascii?Q?gJyao2zTtNnVXcmXxSgwHo22j4wDnUcA97RMlWVmORnzvrOYHSp75o7AzOTi?=
 =?us-ascii?Q?qkGW6ytRFP5VP4egpOWxG+O+Jt4qYPL294sOHRM9txZv//InMeJCp3ec2cpg?=
 =?us-ascii?Q?eziaFvz1IF2XSLvQ8QbNZb8Np8e7hqh+hKTvg1zxVJKicieDFqSj/ihXGDrC?=
 =?us-ascii?Q?Eq1JIFhPtj8uL/07zYSFp0rkA+RSnD5mlMNFdjeqVW3G4voOfS6Dy+tE/sZ4?=
 =?us-ascii?Q?slAs+QZGhS9jXr3Gxx1m9WtM5E1IkKrwksGLycGzlHR9FLhATGzCdIj1zx2m?=
 =?us-ascii?Q?q4F2/sQIIppqpWbUv8rHepXmHJW0TlRWKEdUh44OcyxAzRwgV+q0cGWDldGl?=
 =?us-ascii?Q?Os4GNPW4f7+uqD2fX32MBAzBRJab+6F9OCQl2DDzlE+SKtC+Qs83a4k65s9D?=
 =?us-ascii?Q?IvF8cx1q/md5nwuVTgBWJVm/+0RR12U20H8m85B80aX2eDLSAS17bARF/W+U?=
 =?us-ascii?Q?1pLVq7ipG68GWaeZxkqZBqrHri+ZTz4055njLXRSx6nlDq7vfoxv8oamKUnf?=
 =?us-ascii?Q?40Y1qW3LsBvS6v2TDbZk7Mb/pWhvqdgr19H6y7bW6ccEpKoic0d0+skfCb9R?=
 =?us-ascii?Q?wDgw4OJ/Q3zJXktbB11LJbldYilrCQqGhUOdBdBBK12YnEvc9xZ/9LZDodTi?=
 =?us-ascii?Q?3ZKLI4ajrl2xBbgdFQuoW8lUoZiP52A4dwfmSQC+1RORy0L7qZV51ddPrleC?=
 =?us-ascii?Q?S0vOrz6BaSDzuTxVvgU3DhuePbGbd3H/RHrsB/XNPEOUhJjqsVhAjviUbn8n?=
 =?us-ascii?Q?f74kRSWALX8Lr+5NxSM1BOfdBJts5YS4JGXOx86ud3Itv8OLViosbFMrC0XA?=
 =?us-ascii?Q?pZsLjpEhLZ8mTqxuXNuu/oIT+PHMBkPSJRDhQy3iZDuUe2RZT3NnweV1YNkh?=
 =?us-ascii?Q?K2o+oTxG4gTcvwy8KSyHNKhbND/IcXMrm3WH2kMU/7fDeo2IMxP37CXUPBCH?=
 =?us-ascii?Q?b+fsauSQQMjN1vPmvGCgaI4etcOJXfR69KFWXjsHGJYqSNcKPZL2p0GKwfTP?=
 =?us-ascii?Q?NZDRUZbAGjtZZO3Khs3iGUiYz+9tv0OZK2c6uy5U?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ad60de96-eb6d-4d25-2001-08db932be7a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2023 07:41:38.1792
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n5efqYEW++fyIv4a2sI2HQi26A0bG4ONXj6a0GERha7KofJQg9xzwd4XfO6uDYa8/WJ9lhsyH9QLe6vArxFlrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8433
X-OriginatorOrg: intel.com

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Monday, July 24, 2023 7:14 PM
>=20
> This makes the helpers visible to nested.c.
>=20
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
