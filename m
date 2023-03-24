Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E927E
	for <iommu@lists.linux.dev>; Fri, 24 Mar 2023 07:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679642410; x=1711178410;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5tTfHt49ekXLc63yxWp9mhh3A5XDRkPtyMUCZH1JWoE=;
  b=EglWk2ugEYGAN2ovzG/AVZw4WfgVTSJXV8RDbmjo9oNiCJR5U5RV/JWz
   WnYO7zMXnk5lkxBAKlaDmZ1SojPJhrLzL4O48uN9S9t5J+DnNkc9kvtwr
   j56HJioyThq0oH+ftxLiHdmdLhcPrEc+tHMFJfe5XzIdSvox4oZV9qpSE
   sb/XRmC7w3oZmnsMMYfTTjUuFkEiz0+XNvc34KOPgzKTHy/Eii33+1/9a
   FOge7YLd4e7qVkpRUkrNu2peqDRmLTqpa9JWSnhJTSWHwHMTSdnawX/Mk
   Pda9Q2B4XixZo7q82Sekl/+zc8UGDwOYZ6/puHdXHn/flLcv29DdtRNsa
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="328128817"
X-IronPort-AV: E=Sophos;i="5.98,287,1673942400"; 
   d="scan'208";a="328128817"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 00:20:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="826144740"
X-IronPort-AV: E=Sophos;i="5.98,287,1673942400"; 
   d="scan'208";a="826144740"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP; 24 Mar 2023 00:20:10 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 24 Mar 2023 00:20:08 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 24 Mar 2023 00:20:08 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.44) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Fri, 24 Mar 2023 00:20:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O8keSaZ7ABkQFZ9AvOw6rn+5kQc4ZV6qmdQDRlwM0o/3YO9WgirX1CeF/I+hlCn6Xz0iYAWRq165ZGOzgHRea1OiYXRFk79yD0DnspQc3TdmQwQUEy6XCgRRCUmLzAqEnjb3rh0QWGLJDE0Lf+1JBSN83Bkc1OsrNLHRsRrHjtcpH7380Giptf3O1sIFiv1TLAnnUmpORSUnhGaAHIFCenEgTJ+w0ZfyRvMxVGUxx2jvd8cScNB+ZnN04w7By0Pmv1Vy1ScEvKNn7Q9vsDYWJIOGCkXlwe5HoM7prM6WVuPFd+bFyr23uz+esBq+S6J0j4mgOehyetVaCqMDW2FKiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5tTfHt49ekXLc63yxWp9mhh3A5XDRkPtyMUCZH1JWoE=;
 b=Yn75ljqmwTS4nUrLqZwdN5Hg9nVFF+tx8S6XPTkY3/W8itV/Z0abc2BVed7ok5ljLlAq5NyexSdVDIhJZpZv5itPi1AGxOhJAdBxw9gL91110fFjRjq//ghvMK25ZfkBNkes8SK82AiwFy6MexvUG/PDVs8srVd16g0QUfcLgBbbs70m2nw9AkQNgYY9llSRewU8QwHJm7eB4ntsDfS5NQq+aREMC2KApNcCh0y3f+dcN81pXtYiw3HI82n2R/j6TkJtmGoVMqWDUqmTllPC+jigtAEERt9S6gLO+r8lxxRqKzDmaIwQnXxKOW3FpKVt8pLyfvFxzxcAPCOcCF+ajg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA1PR11MB8317.namprd11.prod.outlook.com (2603:10b6:806:38d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 07:20:06 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%8]) with mapi id 15.20.6178.039; Fri, 24 Mar 2023
 07:20:06 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, Joerg Roedel <joro@8bytes.org>, Robin Murphy
	<robin.murphy@arm.com>, Will Deacon <will@kernel.org>
CC: Lu Baolu <baolu.lu@linux.intel.com>, Nicolin Chen <nicolinc@nvidia.com>
Subject: RE: [PATCH 4/9] iommu: Replace __iommu_group_dma_first_attach() with
 set_domain
Thread-Topic: [PATCH 4/9] iommu: Replace __iommu_group_dma_first_attach() with
 set_domain
Thread-Index: AQHZXC7WHgszLLxCy0mOSR+MEcYUS68Jiafg
Date: Fri, 24 Mar 2023 07:20:06 +0000
Message-ID: <BN9PR11MB5276DF7EE2493480CE7A05488C849@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v1-20507a7e6b7e+2d6-iommu_err_unwind_jgg@nvidia.com>
 <4-v1-20507a7e6b7e+2d6-iommu_err_unwind_jgg@nvidia.com>
In-Reply-To: <4-v1-20507a7e6b7e+2d6-iommu_err_unwind_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA1PR11MB8317:EE_
x-ms-office365-filtering-correlation-id: 9882c9dd-5b26-41e1-4c7a-08db2c38317b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Wl7PF5ZTFnaP/tlevZ2UfrfQ/fWDTgtjD7x6MJJ0/oGpE2wg7KIcqVj40QU6LmwaTyRh7n7otXOaHqPy8UUivd8ygC0nksP1Dn5NtMjKh2EE6PTp2h/vJ9KEceZygZlpg8LNw4oOxeG9hGltlfzq0oWGQjuApa0hDI06GqJ3gTl4C6PO2sAuoaP6GnIq1bvGHPscCEktqjA++Qr5W4qlj3WHMTgk9QozENw5d9cFPpIjd5ka4COEpXOyks3jDmadjxXYu2ivO4ydhPUNsibEgck5+G+VQLjZ4iFOWG0ZYJn9ycWc4p6Ot+Xrn9teP+YXqQ08RsZClhS5QW6jE3FvBUk4GBPowzp8da5I02GVyeOGqfMrhak80hC/t9kg+stQVqa8axVp9QR4LrVajViVrnwYyZP0VPsOMEtjPymlGj3XLs7KUkkoQMskKrvZ4HlCVqR0xC3kN5Lh0VH6TrWWHKkNbK+0U13Lpj4oW27zy3CAjvYFFbRGS/FzvdfwuEi6hwyWQgWodTZIAfrUps3L4sdzrSZFcpnCghxT9zrcprJxha2C3vHCpSUYKdz4NdA+OXElAxYeapE+8G52oUZxvZNcfpnzSiHy5v+4sSAXCbIpyebCdprduQ5CKyUxOlSc6rOiZ8fUq054tRGU92GNPhRMysUvpYm+Nmmx3LlAbUniuz48oT3SBRYIQFzRy8H/UepC8fgy47ChDlY8Jj0G2+LVHH3ursGAirOxUzTjLud0/A8OMwDse+ZpQnORiKw6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(136003)(346002)(396003)(376002)(366004)(451199018)(33656002)(52536014)(8936002)(122000001)(41300700001)(66556008)(4326008)(66946007)(64756008)(66446008)(8676002)(66476007)(76116006)(316002)(478600001)(71200400001)(7696005)(54906003)(110136005)(4744005)(2906002)(5660300002)(82960400001)(86362001)(83380400001)(38070700005)(55016003)(186003)(38100700002)(6506007)(26005)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VKqqc0HFEA/7nNp2lEGGl7SOHft/ADKMMN71UeOL5gTuEB8msHbJb+ullmgD?=
 =?us-ascii?Q?cZxgN64XeUOV/6+YB7PkoS03mnLCKcR8IpNcPoObPJ7uJb+ltU+Vupf1wpok?=
 =?us-ascii?Q?XuDB9del17P+Ax6aiV3m6zS3hDjg20R2ToWuWrpJCikbd0jONjnVAKmc7VWm?=
 =?us-ascii?Q?liJQnld6JvgKTnIg7LTgizrEHNffVy5fC9Av8aWdmQHVZHFHQS9ILltDjdAz?=
 =?us-ascii?Q?T+JBlFWZ8U6nq1oD26FDgakuUqt3cQRbT2jjo2EnE59hXMh/jcerDTD7c9zV?=
 =?us-ascii?Q?IJs66pF0lvuuMYXgOyLg9gfrmmfz4DiTYlodByahotqeJ2IQWQt9hJWYAj9B?=
 =?us-ascii?Q?e1s5fI3gAiFEap5S0/NQRzBBlOqIKZ5o06lXkmyrKuUfNx2vC7Cpcwn1nbRY?=
 =?us-ascii?Q?AhsO72yFVo+uvh3Z0JcJdrmmxeqxo6T8wNNZC1+aYYAX3kH/A7fd2ziw3Mj0?=
 =?us-ascii?Q?QDtBRg0RlKxy8rFdbH9aAUJHq19JHauHI7gM4Zm+umWraxqqabzmoFDxehuY?=
 =?us-ascii?Q?UjODSK+IlRF+RjIaltZtbQ++7LI651jMFhP5fC8VLIoHUlNy2WuL70aeG5Lr?=
 =?us-ascii?Q?B5JXEJf7lQ5KKGg37AbA+7gpQufu+mL2PAXrSKBOeCXFUcpiJvgwXZg9LBBt?=
 =?us-ascii?Q?TUk1el21659rwLo+NWutPW/CZv7fOQ7mXqcTuuDmTaGiGzhnpchUPRLOHCUH?=
 =?us-ascii?Q?ypZd6W34u/F9u/r4LkE3+xzKmTQeftaRUboFxu/zICmVn6vWjpDvN4H6OisO?=
 =?us-ascii?Q?O94h7qrQ+FAkUHyQ5oanABMkO+JLe2iNkH4Es52J60z/myA/EkZKUjRP4okP?=
 =?us-ascii?Q?j0Lt513XlncxTPM4AsfoICDQ3Hg/xxj8TYuw4sh5gZvtZYMr06DLtN6lpL7P?=
 =?us-ascii?Q?Pnu6zZxexk9IahKs1R+BOjqZ+ofX6gGAbfqPRdafuioe6dc45SGNZg7mxIAk?=
 =?us-ascii?Q?w2lsqUwkXdzdUrT5E+atTkEc4vFzR89GQwfLBtRJbmgeMLOcJ4YhzW8Xl3fy?=
 =?us-ascii?Q?53xzidP9zn5OtVW4yu21kaNnuAczQoCo4Dj24/r6t46XJO7zn3eLb3awbBtr?=
 =?us-ascii?Q?RkQjZevlImu5nJZltpsp6w5rY0HK5UZ4/Ij8Z/CpC/KT9seVNfer1wz1+Qv6?=
 =?us-ascii?Q?frbfCyvdoN4kD9NT/n9EHMJuX53GHwDU4kY4LhIGT5WHkb+Bmy+O6vXw//A3?=
 =?us-ascii?Q?Gv97NPxq+XXo2JKt6Qhv4Ekr/cNifZZTyOBzpWFvBzNekh2l7QbONWTGg6l9?=
 =?us-ascii?Q?EUjIGaxOJXpee5vDI5U0B6qeIf2ALgc/E2eGcValgEZlKSK9MjhJOxBCAvuW?=
 =?us-ascii?Q?hX3v8QSZ2TyWNp94JUPPI52voEFy1xF3FwieIMdbXAClkM6Z0IKjj8J0nUsQ?=
 =?us-ascii?Q?Yp6ULvtlZRK2MxG+w8Z/htHfE8X90YjOOB5VYVOEqDPLF9S/zZMONuGiTgcg?=
 =?us-ascii?Q?DLX/ZC9V2ktYU7NWRGJtyhE8vtszLhRimfCR9NQkfblFJD7pouk96vny63d6?=
 =?us-ascii?Q?IUJFh4tWRbhvdtH9uC1lj9q58CFMf8enpAIdGD8fSF4gM8r/Qogvxktd+fXB?=
 =?us-ascii?Q?7XGE88MzjaZLgYBg3mYTVLjUJLbeaXt1crHccffE?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9882c9dd-5b26-41e1-4c7a-08db2c38317b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2023 07:20:06.2386
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Np83D8yKFpbw40/reO+9S8Hhhs6THYzU2c/WDfhPWJAe6tdSIWf5XRcyWSfFOmJ0IrUJQ08x4hyDEoRDtUxU0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8317
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, March 22, 2023 3:53 AM
>=20
> Prepare for removing the group->domain set from
> iommu_group_alloc_default_domain() by calling
> __iommu_group_set_domain_internal()
> to set the group->domain.
>=20
> Add IOMMU_SET_DOMAIN_WITH_DEFERRED to allow it to do the
> attach_deferred
> logic.
>=20
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
