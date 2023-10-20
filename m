Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009229445
	for <iommu@lists.linux.dev>; Fri, 20 Oct 2023 05:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZemnL28L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697781265; x=1729317265;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2n5khtgqjfR3s5ogDckUEXhrhc1qRt8uoLV8jAT1PaI=;
  b=ZemnL28LG7eM71N4bdjHVlJ3YbZwGrr05gV3Sr/an5GCekhPqyYMQDL1
   gdC5TYQIHmAmor+zODh9A5Eu4e3nikp7LqUANoYlo+z4yGA6AqfvQyQyY
   vdyAkp1/6rujrLTpr68wpX5F8M9OoGQJRHFG82bNW+0z/or2s+13v3Lpc
   grDhEtIvX+MP15YXK0F1Ge20nYqQV9lEJrUv8hAfIy0FXzM2tntdq5WaO
   x/l62ngP1S5Y7LcGMA428pKZ2x44Gr/nYBgQme4xeBWphwJQxo066dY6e
   woASWpVuAbcTjgOQeq7xeYNATWt/zElDeMEW2gD6LP9c63xmdFAaJ/+3Y
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="389297164"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="389297164"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 22:54:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="827618802"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="827618802"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Oct 2023 22:54:22 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 19 Oct 2023 22:54:22 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 19 Oct 2023 22:54:21 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 19 Oct 2023 22:54:21 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 19 Oct 2023 22:54:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ONB1Og3/XN7rwbLN/nyPs3Ywx8ke1Ure1j5nvucOBVtGpRvN+CvegC9+z8rlqDUjwCJicWgq/JsW6fJADMe53OPUpOGkrQLu8+NXhhOgzIM2tfy5PYktZwv29N90FGBZOJXXISBwP+B8d3Ymwaf5QrNRSyGaAM/F3HYseQd7IHFNReod2H2D2LovncU3RcRNN+3+Si1tgherhk72Bu1WmyQQmkQIdd7s8895fdrHwEmCPJ3KqUxWnwe/0ZqluzUMYoc4XpyassN5xGUXaZTPQp9bG6ssxrsmEp4vSOgl6OJIidCbw88NOpE+ShkUp/iyadjseY0nLpmOoRbNRihLNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aiSPcR2Di3df/KaHdWubl0obssGGJOPjD9WVK1g0kP4=;
 b=Jrroa8J1oxzZ15Fn2t/85S+unpcpSomHdjahpB3U/r2slnZqI7h0hIxSB7NpYUGlRxSOzBqhfJYZ+j1qyglHI3X3uUUiBtkFyWHhBDca3DzamrDOGmfpiYlxX9Kqnw1ADxtmbhfWpieF9RTK5kt+mPRaF7NkDswIlQticbRdhC+BLWl5pLKKkXYmB5EzjW+nDYMAtNvBF50AVyRVmqA4TFToDuqCPVajEeF/aeqAhLtWIqxNA25LwneOYORhWdXs9XKiDdXUG7I7FfN5v7R7sMFWr0pNUiTtL7HKb8y9yWMwc6DsmPmwa65z5xlgDnA834PtjHIngXheJePAmy5jPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS0PR11MB7405.namprd11.prod.outlook.com (2603:10b6:8:134::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Fri, 20 Oct
 2023 05:54:18 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::7116:9866:8367:95b4]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::7116:9866:8367:95b4%3]) with mapi id 15.20.6907.025; Fri, 20 Oct 2023
 05:54:18 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Martins, Joao" <joao.m.martins@oracle.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>
CC: Jason Gunthorpe <jgg@nvidia.com>, Shameerali Kolothum Thodi
	<shameerali.kolothum.thodi@huawei.com>, Lu Baolu <baolu.lu@linux.intel.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>, "Nicolin
 Chen" <nicolinc@nvidia.com>, Joerg Roedel <joro@8bytes.org>, "Suravee
 Suthikulpanit" <suravee.suthikulpanit@amd.com>, Will Deacon
	<will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Duan, Zhenzhong"
	<zhenzhong.duan@intel.com>, Alex Williamson <alex.williamson@redhat.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Martins, Joao"
	<joao.m.martins@oracle.com>
Subject: RE: [PATCH v4 04/18] iommu: Add iommu_domain ops for dirty tracking
Thread-Topic: [PATCH v4 04/18] iommu: Add iommu_domain ops for dirty tracking
Thread-Index: AQHaAgGbQz+tQ304AkiXBZjN074wDLBSL1Pg
Date: Fri, 20 Oct 2023 05:54:18 +0000
Message-ID: <BN9PR11MB5276CF5FAF3F9A914DCD8A2E8CDBA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231018202715.69734-1-joao.m.martins@oracle.com>
 <20231018202715.69734-5-joao.m.martins@oracle.com>
In-Reply-To: <20231018202715.69734-5-joao.m.martins@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS0PR11MB7405:EE_
x-ms-office365-filtering-correlation-id: de3b5a63-4450-4243-d9d9-08dbd131001e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aPa6HEziSLNTrpfeJAK1H7NoADm/qdygab9HBt0PWqVVgS44n1nfQn8MeaXel1/dwuEZQaapl7LUuH7lipsqZKgx4vx8PgkZXvHJpsrb096ONk1yIyfY0yxtsXqif7kMS0clGm9p1gxiv10tO8iNZ+UFJ0rt0uw11B2gtwZb4JLoIO0C5k/+gtn6q1FZhBIHt67o7lRs65U/VZkxU1F9Uc0w6wZBry+ZFlKxWtVtwomX2uj+gSwQEJsYLuCjzIxibCzvazVSiQG5PR89jvv3LlOtFmrwMLaQ17/hdYkJrljQbIx1r5gwU4V0P9Dvx34Vq4RRiS5EK1f5SDSAWYUssvsrXqgFkit1zOQfjntovnXMvBTF5Ru8KhMCk8pW44qXxvCd2m0XiCSp+7uKNkOedJSy7OJf1LPOGtGWd+MzES+Ulf0LOLvzHp84SKIXdYgYDA6jFdW7+XTAjytKiWNN0OJ6lUBsCDgOeVqKjN11ktwxDquKovrtyI3WHrHlQ/YhbC3MGYaCzuCxHKujIidYBOfZoKKnggnPzinjFourMrORlXbPDo3Y9cBClMQQLvKzNXLAxrxX+u60UYk5T8I+q634NvDpuOrw4IsvuAc1qc3Id2B6N/AESiyqsMV6rhz9Rq7mUPlGQrhdr5IcAnbETA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(136003)(396003)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(55016003)(110136005)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(54906003)(316002)(122000001)(82960400001)(478600001)(86362001)(33656002)(5660300002)(52536014)(8676002)(8936002)(7416002)(4326008)(41300700001)(38100700002)(9686003)(7696005)(6506007)(2906002)(71200400001)(26005)(38070700009)(14143004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tpRBTSLcOrFluFG4cUlNv2y09wZ3zHvOqmdn0PPYQlIjf9THCnO27r5Itr7N?=
 =?us-ascii?Q?hvKqPGEmsuO7rLniRplkrdEvZi31naeohEfOU7Fom+GosstZiDLnFHqAhPRg?=
 =?us-ascii?Q?GUJGdOYfjbNz39xAfdYnmCHFW9IssiDSHIpoRtPz2ta2rWonaI23uEdm7LO6?=
 =?us-ascii?Q?IGl3CinC2lBV4T6RF+rwmftK684rYxCCfGTTEXYlvdbFxJCxFIdKQay+x4E+?=
 =?us-ascii?Q?xD/V+UTYgS8/K84iSQj0Tf+dmLsZLwuSB6Hnmg8LxgZx4+L5mfHJmp+LhwLf?=
 =?us-ascii?Q?tpI8i+bHFZFMmqYAn/qqBb/p+SZuACSg+s7VA/uQiMYHiT8xKab1Vz5cxpQX?=
 =?us-ascii?Q?X4DXv0b2wYxkNQtkvn0z27LAlz/yLp+5wqp31sk/gucIUmxfa4UcphwFCFNi?=
 =?us-ascii?Q?vNTrEHcUrCBzcEatRH0+MiMmfb5EgMEVa+fSDnRDD4UnbfvHjD6lH1B2Lw03?=
 =?us-ascii?Q?ZG3Ety6msi+6tkR5muThPGjpfxWC8EA6OWjFminXjWmw+VN4UznFy64cmVm3?=
 =?us-ascii?Q?2ZP0dZU6jeNdd883L7e1yrDmkxOtULBRKKCh5lRK3Ap1cmq4FwMhMZDMw1wt?=
 =?us-ascii?Q?myI1WJ35LkjxJxF1pvVSTd4vJeVxM5+SZ0fzISCyNQxLqu6sjBZns2S9puCb?=
 =?us-ascii?Q?IhCRQOk/bCdgi4C/8t+LIM/BxsdJP9CZBkSVmg4RGyGPs56T9MSReN/7Hvy6?=
 =?us-ascii?Q?KF/QduB5DO68estZYbfPh8RaGo5sn7G1IusH3e6pUL5yMITKS1nEr1dXxVly?=
 =?us-ascii?Q?lE6NO0HV2kQs+xeaK4NjUFWf2fLqe+YjRLu5d/iZi76Ogwr/F7lVBQvaNMtV?=
 =?us-ascii?Q?5lAujLlmevuGJmD0If49s9grtnCGhA0JrC3ZmGdIu3nqk2AcxP20Q89YE+ZQ?=
 =?us-ascii?Q?H2d/jWGeQmGScCXRtflUyxEzyGhnBmEuMawkjj86Ll/XPAD1Ww3UlMMF9sL4?=
 =?us-ascii?Q?JF3MMQvwBtZ18E5txyuA1m3eDdQr2xfm4GoX9bQmrUCgRdcN8hjIq+SvlR0m?=
 =?us-ascii?Q?DxZAWLCQ7eDGdHXalsFif43maQddHmChTRUkvJWaj0KP3IhAZ6AJu55475O/?=
 =?us-ascii?Q?9YZxBJTfK2CCSVzaumZPYY7weXex5fMTx7ORJmrWHNeFHzcFUm5gg/+SlEso?=
 =?us-ascii?Q?XGulpvn/qcMoPxt8u13+GC3iZjZ7tQjj7Jhi2IL6DDLzZPbWo5ElILWH9Gk8?=
 =?us-ascii?Q?GdiEUrNjJutILAW4a6ma4jlkFoszq1L8QJT61W35xnQQgaS1ccjuVm2BQJ2x?=
 =?us-ascii?Q?9Lb+eOFfqH3JE8qACgwS/NfaZTzRSQjzY/pCXJzFvOfq6w7S7RexIN12uwQd?=
 =?us-ascii?Q?ThnkoAjcRkiOYsLUUnAdrXEA3nkm0SkMW/zzX8iTjxy5N9v5CeJVE/C66sq2?=
 =?us-ascii?Q?G55kv8sVAPD63VYrfYwO8xQiowhtAt6uty5WSThOOgoZ2rNpEWbQhFy79CIC?=
 =?us-ascii?Q?S8AQ4iDlwNzRdfLGRaEgUldaxOW/W53zXe0dJqlvnOTibqVd5IMa4x0rA3hp?=
 =?us-ascii?Q?JiNj2P1ZzDE0UcOEpZbXkxTdqtkMUibzb25b1MgUBi+9E0plAfRo6RyZ69rN?=
 =?us-ascii?Q?CdHJeoQ2LdOIXerg3wLHczYKLPoa+wtkRo3FRyfw?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: de3b5a63-4450-4243-d9d9-08dbd131001e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2023 05:54:18.8607
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8RvobVfXPuCY3oGNYDT1V/aZG1LmSi1k5Vd7s0vO1wvD0/Xqv3Cf+In4vg6+4yS/y/weuxNisxYkMX3xwphl3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7405
X-OriginatorOrg: intel.com

> From: Joao Martins <joao.m.martins@oracle.com>
> Sent: Thursday, October 19, 2023 4:27 AM
>=20
> Add to iommu domain operations a set of callbacks to perform dirty
> tracking, particulary to start and stop tracking and to read and clear th=
e
> dirty data.
>=20
> Drivers are generally expected to dynamically change its translation
> structures to toggle the tracking and flush some form of control state
> structure that stands in the IOVA translation path. Though it's not
> mandatory, as drivers can also enable dirty tracking at boot, and just
> clear the dirty bits before setting dirty tracking. For each of the newly
> added IOMMU core APIs:
>=20
> iommu_cap::IOMMU_CAP_DIRTY: new device iommu_capable value when
> probing for
> capabilities of the device.

IOMMU_CAP_DIRTY_TRACKING is more readable.

> @@ -671,6 +724,9 @@ struct iommu_fwspec {
>  /* ATS is supported */
>  #define IOMMU_FWSPEC_PCI_RC_ATS			(1 << 0)
>=20
> +/* Read but do not clear any dirty bits */
> +#define IOMMU_DIRTY_NO_CLEAR			(1 << 0)
> +

better move to the place where iommu_dirty_ops is defined.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
