Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5398E20F2
	for <iommu@lists.linux.dev>; Mon,  3 Apr 2023 08:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680511175; x=1712047175;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IBTseO2uqGG70K3655c9+CeWxH3ci2xpm1FKE0weAQA=;
  b=Gute3HW/aiVgCOIszg2KmgBy+vrtdDwR9fC/PmSl7sewHMrojq2pxXkL
   OtYzmfMvPJ4pJYZ4vH8QgrDCSIyXyWaJHLuOTYsoQFsjXB23IbfBM9pT6
   UWpXCPuemgsdfRubKKPb8MsI0FaDrDNaapPCXtKVat2NhK13tRRI/pZEg
   iZ8YPAeOuBVUDvP2KRXa2wSbhLy2lZ+jGNI+LLRy32mpCYQO1U7pdfuDs
   23hby7bXQ18/0xjIxJ3DIxRJrUaXTwqoULYbLhCOwwKOY8btzTU7l3u3g
   X6k44Wcj+xILEzAYb4+At6UhlJKN3yO66g8uK/kpRIm1137OR3ex/UUJB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10668"; a="322239416"
X-IronPort-AV: E=Sophos;i="5.98,314,1673942400"; 
   d="scan'208";a="322239416"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2023 01:39:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10668"; a="829485933"
X-IronPort-AV: E=Sophos;i="5.98,314,1673942400"; 
   d="scan'208";a="829485933"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga001.fm.intel.com with ESMTP; 03 Apr 2023 01:39:34 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 3 Apr 2023 01:39:33 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 3 Apr 2023 01:39:33 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 3 Apr 2023 01:39:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GwWR/+WRhc1ct8Of+TsU/JDkHCcr5TEnNBifcZ9x7Bf6m/suyMTNa86g35H6JoghlqoWbBsoW2juP5jdVprjdiL6dqrH839oLS55b5WqOdB8oB9KgOATXRFzAbKiULlHXhFaoYbhz38nzMoKD/52n3Clf7Bpg9U6ZrpNTPB2ljruCM5HRG18yD0tIYlDLVKOuMzvtbO2TPQpUSi4KRRdu8q4QYjkSyL7utK+0GzAlI7ILaCUisRAewcxiDxUxfn0pFd1KKAToAGZ66E2jcgaTRSx2Ea1WI1LidSwKhu3hYBD/y202HUDOPYIiy7AAmSn7f6XzuiBXppAuDIkzQVTjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IBTseO2uqGG70K3655c9+CeWxH3ci2xpm1FKE0weAQA=;
 b=KSuh2b+Z+0Lb4sEhk/1jGVK+pJjbmWvsECwl+QSFYg283l1kz4pUZ7MKIja8fN0pvIRRWgtEtqYxY007snhAK2IoPvw4Lnj/+JkqyrYEFwGf+GVq4aWYUsH6BpmQVtHayIraHBPRi2/hWDWT7MuQDxanDE66HY0g7iN9pJ1gmK94b7szC9i+mx6+iZuQWg5jTTZme53FfFubxYSby7fiQuEXMHhyrgSVQt8M+INlgMuFZAdj0NgYWKRYQzCvm2pm3zI8O//iCgtEE4Ou+xw0lIDW1f0HkRflXPX8+iBrMlShfQ0WP3kIlFw+oCr9o/ijCUk3axtk8IdAJ9yzlBMNZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MN0PR11MB6088.namprd11.prod.outlook.com (2603:10b6:208:3cc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.28; Mon, 3 Apr
 2023 08:39:03 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174%8]) with mapi id 15.20.6254.033; Mon, 3 Apr 2023
 08:39:02 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, Nicolin Chen <nicolinc@nvidia.com>,
	Robin Murphy <robin.murphy@arm.com>, "jgg@nvidia.com" <jgg@nvidia.com>
CC: "eric.auger@redhat.com" <eric.auger@redhat.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "jean-philippe@linaro.org"
	<jean-philippe@linaro.org>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Jason Gunthorpe <jgg@nvidia.com>, "peterx@redhat.com" <peterx@redhat.com>
Subject: RE: Cache Invalidation Solution for Nested IOMMU
Thread-Topic: Cache Invalidation Solution for Nested IOMMU
Thread-Index: AQHZZcP3mH7GyOXUf0KLGMUJbSmHMq8ZL60AgAAJdIA=
Date: Mon, 3 Apr 2023 08:39:02 +0000
Message-ID: <BN9PR11MB5276462BC1879715BC15380F8C929@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <ZCoe3+1q5ZLJsmeC@Asurada-Nvidia>
 <DS0PR11MB7529BD4A1AE9E75E1408DA4BC3929@DS0PR11MB7529.namprd11.prod.outlook.com>
In-Reply-To: <DS0PR11MB7529BD4A1AE9E75E1408DA4BC3929@DS0PR11MB7529.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MN0PR11MB6088:EE_
x-ms-office365-filtering-correlation-id: fc205622-df23-4b4f-74b2-08db341ee0cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hEyO6YVxZiOtfY4F/lcChapaFdKSg4KGNQZgd9uJYid/saBb4Yi6FTZiKZ3E20btc9Q8SbiAa5mWBvSrmN2HQIHGzl8J0B5IYTdlrD/jLk0Vql2LVeCSlv0LJR73RArrCL7odt+Xi7n2MRKUWswYQdNL6WT+jT6zjkfFm2fl/uITWOzggzu86rDKB/Uk60yJrWyweZKWnF3nJXqzvJLY3/FJYjnjiSwhK4dqMZS1XWJna/jtI1wtxh8riqOMc7TGJmmHtJzXBY1XQFpjMrGcQKpCqyMDvu2YPqNRNn3UpEq1V6K3YCR6vveSHuHvELl4hzH2aqKRE/xrzkX5BFqR7jJ6aPw4HRx5N0RBNhmnTNx8pX80yrJ35SxSmawT0J1oXUYOj9nXOJ3xHeGjT2Ag1J/2CeDfP+XMOVSlWgXN+I4JuquXnJ6Z/o+iI68w7oTvvNSpkeZINByx6vOR4zf44dFVkFXZiTNf2IDwZvjcx0Ff3PY6TUU/WeaL6TT422GAn4cQnp90mG9bfzz/VfPj3d06mOKWLoVfyrKeCrITnm/rPSsHcdKET47t4p1ihiU3Dj8Mx5WIs242ojT+6zgFtiAjItYlWa+et3gqEJb6T5SGnD7hCwiF/gFiEqQ0wRT6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(376002)(136003)(396003)(39860400002)(451199021)(86362001)(38070700005)(2906002)(33656002)(55016003)(7696005)(71200400001)(186003)(83380400001)(26005)(9686003)(6506007)(8676002)(76116006)(66946007)(66446008)(478600001)(66476007)(66556008)(64756008)(122000001)(82960400001)(41300700001)(110136005)(5660300002)(38100700002)(316002)(54906003)(52536014)(4326008)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dCIHK/rElG3PCMAeTg/B/l+B0zaITevz1dmmX8a6uwdLF9oo86lHZKTBUM3Y?=
 =?us-ascii?Q?tlsE4SHWc5ci15Ae63oyM9KhXY5DjeGQeFG8uS2OZQaopFWtW0fhTU+O/XEh?=
 =?us-ascii?Q?ZdEXcaSMbFE3UWr1z03p60jaLcRgENB02/vDcP7A3DM6v77Q60G2BvuXOyR0?=
 =?us-ascii?Q?nq8xtWFOkabK/ur5tgVDRewreQY2JLUgzo4utpIZ7LKqmE4nvS5wWLv2xGaW?=
 =?us-ascii?Q?Bhg+S5AnqmZNUf5pUELJpt+/aM+xm1v/J9sRTcvPvNgl5VQG6nrw6iK09bqU?=
 =?us-ascii?Q?8DgvscF8N2J/qbn7hCFCXQCUrlkuIUOIejWzT9KKfTVV/6m/XfHJgBZMZXx1?=
 =?us-ascii?Q?qenfL3/siV2wZ8rJLvAMN+JzqMkdmP4Ajdy9BEYl1EcMl1B/RogTO1UH/sZK?=
 =?us-ascii?Q?9Oa7q9VfhikckOeU/54uCyU2irrreEyKuus3cGIdj+1ez0yrAZWoI5UqaeBX?=
 =?us-ascii?Q?uwatrVDpjHW4AHYpiktdCgyhVd7sEEJmWF5IO9QzlQvnIceMLxWwKrgQQdkb?=
 =?us-ascii?Q?kGpT7z1oRvGK45rOukVtzeqY/MK35SbrzewlKqfJpOWnDY3RpMvmgudD+5oM?=
 =?us-ascii?Q?vMxKwVrgn0mDH04Fz5o6m6wVVbhZNHa/qw4LUKklExmkMjoPyY4jGzB+kf0E?=
 =?us-ascii?Q?Dl23jpvAEJvOwhZoCHtv0URnHAQEnXOavQ9sLPK8iWlh/DrETOBu2OYm2ZY/?=
 =?us-ascii?Q?JfueUAAo0gezB0ay7GZLASFdwRtfYBZgvcdoMiqWHCP1d3XR/sKfgRDZnxKf?=
 =?us-ascii?Q?aRGD8Eg4fb+BdaAfbE33bEMq+2nH2OVHJJ8ErpI31uJdEaiNpr3Jvlrktw0m?=
 =?us-ascii?Q?/dc6isy2P9wU4jN176Wx1t6updMviy0ctm21gj+lMaN90HwnKFGgxpedPYnH?=
 =?us-ascii?Q?vKguGlytKWHaArkLIYPSPFgW2XjXse+HHh+BA8H3vwlbONdFxmiO7v18fOIc?=
 =?us-ascii?Q?0Bc9Okp/wGnSrkjGXaZNnI2kggi0xE4y5bw9tVZC7OJA8dvFA09wvtL9xTUt?=
 =?us-ascii?Q?AYaNhkWC8zcAJfRBiKi+6BTSPEs5W8xuddy5ojKNhDHJQgtAsAko5Ef738Bg?=
 =?us-ascii?Q?X04wDhbItbeJ8hxiweo8lRZeOs3kcPJEMT/RHPhLONBE6aHlebc9ZJGzxEBq?=
 =?us-ascii?Q?zmyIJgPsSimjOwhpm9c6shHrPgzRoQ1ie1ny4eAP+gOam9pX52bbPFx50Ci1?=
 =?us-ascii?Q?lwks1E1BBY7pwBlldBxn72/OW2Wtfg3dumr5DOgb6047Ad3utVzBdpMPLrEB?=
 =?us-ascii?Q?Bg3SoLFgIlS1vV5XL00feCeJPRRM1SxUNbEX/q4kMKe7inU+pfwwy52qvIVp?=
 =?us-ascii?Q?4/crJoMIPtd8yKJC03IvhVNygBzY76tVDTgnozXJBgN4iI+461XYROjUCvT1?=
 =?us-ascii?Q?BCSI53cDFOaCF3BKBQkQgO6QeNLXWsA7aM8oNylVV27pG1E6pw8HFuay06Dm?=
 =?us-ascii?Q?1a+vaY/q4GLJDLAfvXuTG6kDiYzG7bnEy2/BKwwjqxScdOhVTKYQYWLu4Par?=
 =?us-ascii?Q?bWAUdjjbIXdvSLgpOGbjzZif3yC3UG7sRIv/N52oM4i+n4R/1+QQNIvL+LBM?=
 =?us-ascii?Q?4FMvZ28csuJ9ndKhNKNNl4vlCXbbZqJ/zY0B267d?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fc205622-df23-4b4f-74b2-08db341ee0cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2023 08:39:02.7730
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tom6barURmiyzEx6HGMsJmSThKlNCkvfAlz+JzTlmHxWRqMHGP1ikwIh8svM0DtGx8uASrGoGu+4bGNhx1Q8Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6088
X-OriginatorOrg: intel.com

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Monday, April 3, 2023 3:26 PM
>=20
> For VT-d, except for the device-TLB invalidation, there is no RID
> information in the invalidation command submitted by iommu driver.
> Device-TLB invalidation would be somehow an included operation in
> IOTLB invalidation if the page table is used by devices that has
> enabled ATS. So guest VT-d iommu driver may not use the Device-TLB
> invalidation. So vRID->pRID conversion may not happen for VT-d side.

Guest can still submit a device-tlb invalidation descriptor. Just that it
could be skipped as a nop here if the host always invalidates device-tlb
when handling the iotlb invalidation request.

>=20
> VT-d side requires vPASID->pPASID and vDomain_id->pDomain_id
> conversion.
> vPASID conversion may be needed later as we may disable guest PASID

vPASID conversion is mandatory when we enable vSVA on SIOV device.

> support at this moment. For vDomain_id conversion, there is a gap.
> Domain_id is not global today. So if there are multiple vIOMMU instance
> exposed to guest, the vDomain_id would have conflict between the
> invalidation commands submitted via different vIOMMU instances. Even
> we may make its allocation global, I'm also curious when and how should
> we build up the vDomain_id->pDomain_id relationship in kernel. Maybe a
> new iommufd uapi just like the vRID set? or it may be part of the
> device driver's attach_hwpt uapi (e.g. VFIO) as this relationship should
> just exist when the hwpt and device are attached.
>=20

IMHO we need a vDID->hwpt conversion i.e. the kernel wants to know
which s1 hwpt is covered by a vDID. From this angle adding vDID at
attach_hwpt makes more sense.

But honestly speaking I'm hesitating to introduce native format and those
assistant APIs for VT-d at this point. Supporting in-kernel short path
won't happen in short term. What we defined now may not fit the
requirement when it comes.

With that let's continue to define a customized simple format for VT-d iotl=
b
invalidation, plus allowing the user to batch the request. Having extra
packing/unpacking overhead is negligible compared to the long invalidation
path at this moment. Then we can consider native format as a 2nd
supported format later when in-kernel acceleration is being worked on.

Thanks
Kevin
