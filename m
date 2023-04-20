Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E5B320A;
	Thu, 20 Apr 2023 08:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681978044; x=1713514044;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/ckzCdn/T8hTSSuTtUuVXreQcLFA60BL/MtHY2rAEus=;
  b=gCBq0nmu60r1aqK78tQQsgox2CQw3VIyBluQ4kgfG8thGuY6SbPrGOrp
   1Mgbb78bDudFsxmaVUDGtKkk0OMuC6EEqf8MziwLULyVhkluWFgZx3T3g
   YaPZ7/u1Y6pQiT3ohQBQQKvSwxrf0txE3Z+3cBCKkuo36oskl3jTjtY77
   BcnaU2REtELYcqoAAQTSMBJy3+31iSCw7hxm8nSuGtLzxSFIWbvDhF2Th
   jgCsdLANXLreqQlY2U0U6rnpat+3mLTKlwOXCeEt6mOWDIT55nT4VYFT9
   PKez+dtzGh8ta+46MCVeDLia4PN2vITs9ttsPnaiT1+mEjkd6yfo9nOju
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="348428544"
X-IronPort-AV: E=Sophos;i="5.99,212,1677571200"; 
   d="scan'208";a="348428544"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 01:07:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="756407789"
X-IronPort-AV: E=Sophos;i="5.99,212,1677571200"; 
   d="scan'208";a="756407789"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga008.fm.intel.com with ESMTP; 20 Apr 2023 01:07:22 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 20 Apr 2023 01:07:22 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 20 Apr 2023 01:07:22 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.46) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 20 Apr 2023 01:07:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d/FhuupFJ+MzQzoB0VCPanwCC0nHyARut9If4qbKta8GVdgEWy6IJw94hIY6rJXJsvptprU8dPyB6wO1vMNaDISorF3CHBkv+slyzNLYzbNie5nIDx3KqoiLXDwPUejW0jgNxd27fhlH40+EnNKLkou4xTJV0EBpwOgLlpXiFwwJ6jFdgdH7g1YkXIqPNHSj0Xp3oCMAQkJXEkgDQbHCp4HfIOwfVApxSucJFe85UrflFziwzWrngLczQn8R2Eq8Hgm7ib7dYD9AnQnmu4xyb2gc4FS4WhWaPHQOrSGk/9SNajjmbTMuo32xn/U6s2qsldpqWz4wicTmAgxxikR5ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ckzCdn/T8hTSSuTtUuVXreQcLFA60BL/MtHY2rAEus=;
 b=Xxp+HRqMkTUFZV6yU78UPV/PtZaFOySq846/cPFVgY+py3EzvGcR/Xxh9F53z2LuQVOWS7kJOHCfbgG6nonJN3NzTjKFw+UfxkdhSjUCG7t8usFaMhLQFYtL/dlz7Hpm+YGiYWohcQvzf8zVVKWTCc2nmsRyjGWH81CtlbA5R1HK4CvKs2PKHXKTiBM6hrpZOJ5lHz3zsmOaBCTBFOe58/qcBDdfp0PHH4KPb+7kS3bM9qWMlYnqFaR9bC+DA3siuduc5Vk81XG+EtT+M/m788KjRfj+2AwMkfyAGCVcjctZVoER7OjqHP4k/PgwqM9F+m6iyTrkl1/zj98EkT1PKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 by SJ1PR11MB6300.namprd11.prod.outlook.com (2603:10b6:a03:455::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Thu, 20 Apr
 2023 08:07:18 +0000
Received: from BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::5e54:1212:2071:613f]) by BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::5e54:1212:2071:613f%8]) with mapi id 15.20.6319.022; Thu, 20 Apr 2023
 08:07:18 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, Joerg Roedel <joro@8bytes.org>,
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>, Nathan Chancellor
	<nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Miguel Ojeda
	<ojeda@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Rix, Tom"
	<trix@redhat.com>, Will Deacon <will@kernel.org>
CC: Lu Baolu <baolu.lu@linux.intel.com>, Nicolin Chen <nicolinc@nvidia.com>
Subject: RE: [PATCH v4 17/17] iommu: Tidy the control flow in
 iommu_group_store_type()
Thread-Topic: [PATCH v4 17/17] iommu: Tidy the control flow in
 iommu_group_store_type()
Thread-Index: AQHZbUYFPy0HUU4rhEeIheeCXzTSvK8z45Dw
Date: Thu, 20 Apr 2023 08:07:18 +0000
Message-ID: <BL1PR11MB527193DB1A5F0951524131028C639@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <0-v4-79d0c229580a+650-iommu_err_unwind_jgg@nvidia.com>
 <17-v4-79d0c229580a+650-iommu_err_unwind_jgg@nvidia.com>
In-Reply-To: <17-v4-79d0c229580a+650-iommu_err_unwind_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5271:EE_|SJ1PR11MB6300:EE_
x-ms-office365-filtering-correlation-id: 334582fd-3be8-4a8b-9dab-08db41764282
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /RvAJQNn3sXLITkYeMontFbolw9pnXzgKdr5JhQD7boUdOQDjEN1I1AeuOxozUGFFciXbuM9ClOh42/1z8nOo/timEQhKOrgeKrBs83ElXj/a8qXogWsuhspnOj5uhsegwbpoC+RBny583R085IUiU7p4Poat6/3c62Dg+PLPNKoFmuigkca6iSxg/IZLKgA5OlmD3h8LZcI+Fx4fX7btm3D3LogutB2xkm7QX4hVrHjke1w6zlF7v7ybd9JB4dJi78zAUFTMgIi0pMrrt4ni+FtEZt6IXDWMFdn2qtIH8WqtJDt0G2rwvVjY18dewCoUjxMQ0BLK1HkcOXJSBxbGm8Ww93mrjvJW4j3wEatbpDGBlaEQVUDn008D7g0lDy6eLuek+EDaMiK4Yk38dhlO85nrsLRUwgF37SJRcgM5AgkITv1JD2KQl+FcbFYQ21jcVc1DTxiSEk8YPIlLiiFSRdZ7zTiEM5vX8WFjL4iDSj55IIGR28cv2F8njGleIW2ksbCh2t9ECWkAUKTdzgRafbPhEblxhASf9MydzojwEoKINnfsVz1oRehqhXCvy/mX1IdvsZW8YXMLR9wHqCu58yY3L25ODBVIchkG/jLyb1zHN6WZHb7M4nfsV9+QL46
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5271.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(376002)(346002)(396003)(366004)(451199021)(122000001)(4326008)(316002)(54906003)(110136005)(64756008)(76116006)(66946007)(66556008)(66476007)(66446008)(186003)(6506007)(26005)(9686003)(38100700002)(83380400001)(5660300002)(41300700001)(8676002)(55016003)(8936002)(478600001)(7696005)(71200400001)(38070700005)(33656002)(558084003)(86362001)(2906002)(7416002)(52536014)(82960400001)(921005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BDXgmmiGN0yEhnfaxWSi4HUBvGqfchFGYoH8tNRI/jTQiJYQd5L9qf7OwRWS?=
 =?us-ascii?Q?eIjZVrzSa602ziDP79sHtbMO6JvFh2dUFcRga15FPi46S3kCiLAPF0ZlhbMY?=
 =?us-ascii?Q?gNMlluq34FoU7609VYBBNAo8SPmkICOywOJoso8cg3urgCnPu2qmJWq8X5I6?=
 =?us-ascii?Q?18vjofTpp9eRfOdOJL6ZVuB0bhAz9/XMwaioWxD6otZIQgpxByN5rZU33ke2?=
 =?us-ascii?Q?EYxVt1yM8Eo8JSbPqCI9DlxUlWNL54ypNH8HhMfLYvSOccXDHEpvyOBGTg9i?=
 =?us-ascii?Q?JwAdgGxApoB5IXP/raIyW7v1iZJV3lvBE2XVYeudmHKwMjQPGsmKD+td4SOa?=
 =?us-ascii?Q?uePS9gzMZr3d52Ix7t12FhAfW5y61u1WjySH65kQ6BDfjg8l5atHd/kkG1ei?=
 =?us-ascii?Q?xVdO7OwowgJVTHDDujroBNqY0iMoAr72fuMZ3FHkyCjHKFwFFB4OBwr5y3Mb?=
 =?us-ascii?Q?y6kcj73MiGQtzZAHKMYYaNPKjJTcgmI+evVMV7PthKYHNJs3T0kwz5k+d2Re?=
 =?us-ascii?Q?WwUOaJ7Xg9elFZQCZliyOhJZM/pQCbuyWV7/+pIn/1dYV9AxKKaajC6DGuLM?=
 =?us-ascii?Q?N+pdBTMpfhyvHvG7bL39VlBODEq0Qic3nLum2N6ZhzDN0yYXn1u8g8/zaGvo?=
 =?us-ascii?Q?DowxiAA9JrE1hsoP1cBWEGmkgMV2+zX2D4JF0nVArP6NrJ5mke8E6us/06Yd?=
 =?us-ascii?Q?84zGIAOtqO/NszYSlYu0vXp3jhgNW/FM8ymT8t78n3H37KrLprN5whMZf2TB?=
 =?us-ascii?Q?DW1s/TbbiItAVDooB+kBLV4mB0kxo2FIZ3228vz6sGY/W+ghFcImQXa6zgQm?=
 =?us-ascii?Q?BGwWWIiXnIWvHwHgvQVoFIcLo5zGZoz6bXoQPCjrmcj8i+8NJfku07uzX6a5?=
 =?us-ascii?Q?caX6SvkAor2dmwK2AUbV7YKu2YaDiDJGPMO+nx4BbF/Yt5CeeMubbfclVkhX?=
 =?us-ascii?Q?FzDAy+POYjvXDHjneABFMzeVEdMIqISv2VKlBNPFJVziSwceTQtju+zKjRbA?=
 =?us-ascii?Q?rVgi8oAJnZLqZxCEFG0ELXibwYPGT18u5h3KYZLapvBBv8xm2H9S3ke+QmVb?=
 =?us-ascii?Q?sGVGl5FiDdf78XIR+ItMeg1+N+6PTbuAWEhqh5uR2H1crp48igB0d/6a8wZz?=
 =?us-ascii?Q?yl8lc19ouw6LAz8rv3p4HjKt+Q6pZ1Ve1Cum5bs6yMa2VzHoaCl9mq2uSpk5?=
 =?us-ascii?Q?DZnXecLRQpMYdfV81I6kcEeLNhMER/6AzNEUUVa/qCotjMcjHfsorTgqmApQ?=
 =?us-ascii?Q?Fk3vAqQ9o4NpdFidqgY1xeQvBX/HEBDcX6TVbqPkki8lua4Ko3yftplNa1rV?=
 =?us-ascii?Q?Op7hMQNP7B0LTV8YyuUvEpqaT2fQVMHwWWuffgjPcs3YBTZ8M1hmn/AhNlON?=
 =?us-ascii?Q?G86VoZ+npaRgjX1sXWG4u9uWsP95nR8rg2HSBGM5smZDyuAicgaqCvepF3fr?=
 =?us-ascii?Q?U5pLVdEFTfVmHObc6qbyz1N0HkrR/c3qV9Xn//rtTZKE/MJXIozYrgGyTxR7?=
 =?us-ascii?Q?L+FRN8S7A2nCNMtxft4fpM+xdlmk9p6hQ6LhDTxcbJGzyQoHbTdEiA/jxWS6?=
 =?us-ascii?Q?fWkWeIKxxZ2erzp6xR74+NIvQVqjtD/of9YAcNlZ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 334582fd-3be8-4a8b-9dab-08db41764282
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2023 08:07:18.0543
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vs/gbjdOS/C8eaPZZYzGV1Ph6nGDyf3FfukRSXYSwLgDRcmdAgW5UAsd8N4HasbXnrg3BE+s6Jcx3QpdpNsk1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6300
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, April 12, 2023 9:52 PM
>=20
> Use a normal "goto unwind" instead of trying to be clever with checking
> !ret and manually managing the unlock.
>=20
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
