Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3937F
	for <iommu@lists.linux.dev>; Tue,  7 Feb 2023 00:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675729989; x=1707265989;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CalQtsncbcrZFDxzfC25sQz3k2yZQ2CLxC38aBTNv24=;
  b=gn4H/uZC9buPwcP4rYUE1nas+CFyYE/q86mx66w4uLcurgwI3z1lGwmu
   HnAgbmE2v+4X3Cupz7xzVw7Fc2Sh4t1xjzQ/Mlg7XkU85GFzVi4z0+lgf
   2DeZ/Wwn1JTLgBL82vVhc/aCZstbtcN37ORQJvDu9Cgti0cDmATvWi3YX
   gNR+2Y5GHFH0Q/zl2lFDwWmA1baV5BCqWn9HS/d8b6mtsBD3m5Vgw3Jiq
   Do/9Pd/N0A8mc95J9axka9cZyWqPgpWDJEzP/+Wup27tZtYrds0YcnYNn
   yS3rQe/J/EnYsuPAu2jjknCa9664wLGRTSXpXMKg24XLWdz4xpXalZ9ie
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="313012997"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="313012997"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 16:32:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="995524511"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="995524511"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga005.fm.intel.com with ESMTP; 06 Feb 2023 16:32:52 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 6 Feb 2023 16:32:51 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 6 Feb 2023 16:32:51 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.105)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 6 Feb 2023 16:32:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ON81XMLjwlxgO8fuV13tlIeLxpC0OV7rcUK5vFiFiFyL6dNADyChc7poGEIgoM6z1YZPEUgb26P4DTlEuQX2Zd4FEC0RlAoOLFdJm2jOFdzNOacljiFI7ZwGxhqcbSPznF59oA0M3Eqgh5mYuVPgCSxENMi42Z1KaGMjQ7DfdHmnau2zgVvGkMLlnfYBjoGNwEySCSsl7kq7OvyGUBLOZlvR2XhMS5RbmJxw1EGCRdzS91AYAHJYgDf2G7Bt/FmiOfVsxeobutozU03H1J1LSyFsbzTtVQBwszJQxTa/yoPnKQG0LxFEDfwZaRsaEUfB+JKjHIDvddU+tzvhnaFwHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=02cauwNMvDIHGZjdq++hXNkzflWBpownQ1CkA288bew=;
 b=YigqceaSAiWY/uQ59jVqhHFsSyVHlp2WkriH9PCg2G8UdVgqIY5GgI79CaXxezZrm06mVuKiL1jC6JJuHWDIgEgAyJPaUQkpGrlzLHkp+8/+2MxMyd6I87ycAfCdidNa+UOtDUNkukci2bXyiviWQ687FNwDB/qXPEPz1TYgFC2T6ycq1Y2FD7S8Kn/lZv/2Wr1XklrG7I+V5qf6Uq539CNFlcW5/7p5eWXrl7zN06b/bc6P7qUPcmOE9pqsNN1peGQG3zdM5icy1/Y4hveCIKoevxGe8t46ylf27DydcGSAhwuTxOnq4LUxve4I0T0mKB6sFG0iU/g1FCloIwsIPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM4PR11MB7400.namprd11.prod.outlook.com (2603:10b6:8:100::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.24; Tue, 7 Feb
 2023 00:32:50 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d%8]) with mapi id 15.20.6064.034; Tue, 7 Feb 2023
 00:32:50 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Nicolin Chen <nicolinc@nvidia.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "alex.williamson@redhat.com"
	<alex.williamson@redhat.com>, "shuah@kernel.org" <shuah@kernel.org>, "Liu, Yi
 L" <yi.l.liu@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Subject: RE: [PATCH v1 2/8] iommu: Introduce a new
 iommu_group_replace_domain() API
Thread-Topic: [PATCH v1 2/8] iommu: Introduce a new
 iommu_group_replace_domain() API
Thread-Index: AQHZNtTMfIuYSgtAgESqEIXUquWnsq684BXwgABzjwCABCqQ8IAAcQqAgAC4POA=
Date: Tue, 7 Feb 2023 00:32:50 +0000
Message-ID: <BN9PR11MB52769E24B07CA7296D8BEAF28CDB9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1675320212.git.nicolinc@nvidia.com>
 <a98e622f41d76b64f5a7d0c758d8bda5e8043013.1675320212.git.nicolinc@nvidia.com>
 <BN9PR11MB5276BB497D32073A1F4CBE238CD79@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y90iOAmnBtqQtmiA@ziepe.ca>
 <BN9PR11MB527689447DD190FECE4FDA158CDA9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y+D/vWwRLD27slQz@nvidia.com>
In-Reply-To: <Y+D/vWwRLD27slQz@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DM4PR11MB7400:EE_
x-ms-office365-filtering-correlation-id: 843ffcd8-304d-4d27-0f29-08db08a2d7cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G1zb3BFUkQu/b1dzyTWNQ1n6KKSsdWDyIt0bWtQKF4rbs2M03keVY8zE8rDr8o/9H+DMfVx4g0Y/SzW/+mbO02aqmwh/XL2sZfKo/0+9v7KgCf1az34BFH4uA2sJvOMDkon5lyHNJUQJ3iREv2pJySKMJS7vMguFcLAUZ7pkKBs1i/Vxn/h1ZQGkBeFhrT1vypkvLWm2a7A9A1RgE2VpJlcmEqqVxXIWYCeDnsDSGx7HqEql/KkYH4vCe7vroAZ3SMSjcvo6nhGNrjExma5km2DR8sJXbOuLyBM1HMG6BlB0YkqcknK2dN+QXs1n87QO+/8JjapZXK/okaZZIl/ohd1kDL07C3EY4X/9sFVKG+y89nUejVj8L+PiPTKyWDpxPtzd0YHdsXbEG7rD0igKZJmlQqA6UoaxN4ui1h76Em3YxxHuxTtWN+7PqZKzNB025lCXYQXLriN4vzfOu9ucqMnGcyAd/mfVOVpOfKT5CdWaGE0mA8KNYAwZfPX6BP+DG7VkZ5HwnZj9++kBtF69hhnIGFK6/b3Op0nKybRO8xJtcwd7wf7RrRJstwdUoKzXjc6i9JdONgKOeg4weRwryQWBtdQHgdGRyaaSOJPW42NAuWz2pql1szj8ZSlmMfyayRULaGfZeZvAwouvW7djoC8IT87W5H6nkrvAHGHEdD59YaDVw01ubmaYngFvdwtnrRagtE/G3kZn/4w8VT4KEw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(39860400002)(396003)(366004)(376002)(346002)(451199018)(8936002)(38070700005)(38100700002)(316002)(7696005)(55016003)(71200400001)(41300700001)(54906003)(478600001)(86362001)(2906002)(82960400001)(52536014)(66946007)(33656002)(66476007)(66556008)(64756008)(6916009)(76116006)(4326008)(122000001)(83380400001)(186003)(26005)(9686003)(6506007)(66446008)(5660300002)(8676002)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WskfR0Tbc88pYS7QFhurLoTIaHcfLW+B+yPnLGNsb6rtKewzrBig+v8ElomD?=
 =?us-ascii?Q?CiQbxA4Y1LilOhJ4zIA4t29buo5CDAHWH6BpSTsu5Z/NtPvXsid7PDuN3LdF?=
 =?us-ascii?Q?rMTcnuMuMzgjAta7qWfOsK4i0JDKyo0yuPaTcwXX/Jq1couzs/O/qgkptfZY?=
 =?us-ascii?Q?A+kU3WxxNs1FJOL6sODww8mku968fCUkZ2CL7cHnUIRVKjx+t317oMc/lQs0?=
 =?us-ascii?Q?9AGk1ooyEkMeggPJ3sgywvgaQkx4Hmjjr+ZTL8ZmB4laWR4i9JmKppj0fxBE?=
 =?us-ascii?Q?PerVS3A/x++FcPaUNrh5p/f5GuO5EhHr/CJoOZVEVTSq01E5SaUltROmXbV/?=
 =?us-ascii?Q?/c5yH1lG1Uq+v2yKVzQzxHIWFK0hrwOJthM7ndqujwONpd1BByIDKM/EjyBR?=
 =?us-ascii?Q?zs0BssT2Flb2zOMXOKFBuO1jWsVInsEyf3jZQuWYZXptnmq1rr4SlKlhDPVV?=
 =?us-ascii?Q?FYm3PC76krM4KnagAwCxWdkV03CfizkasRYCIy6RI+MEEOAE73ikwE1scdaI?=
 =?us-ascii?Q?h+lrDax/+gohH4rkuGpcRnpxkTSDXIMvkx1T00o3SOr5a35y/GFM5hDqzgZS?=
 =?us-ascii?Q?0lwYHbTT1LcnEnI31f+t4vGEV4bNoBrDyJGV2fnbMiUwbAd+LWLTLmD+GpMA?=
 =?us-ascii?Q?SUEpppL/HF1KMDg/i4C8fgRXNvOwd5QiEnlWIi1ZxQHg8jKKg3/mL7NxX/zp?=
 =?us-ascii?Q?NiyJ7/pG8EN8JacYFdxGkSwwFlz25MImmcwtYRjhMkKHKJ1EpQasgmX+hgxr?=
 =?us-ascii?Q?Av0/Jc71PEmL16ur88mxc7ze4YpufVIwNJ1FzKuMtqp7pYdUY2lbTAMh0gji?=
 =?us-ascii?Q?47pGTNJtHh92L8HpLCQLduqekXCuCibT2ypO6IrVPG8cKQRxr30P21zN6Dp3?=
 =?us-ascii?Q?PEKgGixF6F3LNAQWTW0nyS+l0K1/OuRDY7lMYmqHao5g5Ta1VkdMfnmajYY3?=
 =?us-ascii?Q?9Mm9IlMl1TjL9AE3R2sFrDgm3afax3AWADjFc3bePCrRqmKhUVkj+TRZnJ6n?=
 =?us-ascii?Q?LRJFgYEcYwjxlaEZyrQmwLbCT1MsGOjr7zrfqfifuohXrdOEqHUVC0rVNJV4?=
 =?us-ascii?Q?ZL6KHlOG7zICAURIjc6csNy5lQPE2Ly4U6zZmf90xyWrfo0fPecOk10WyfUc?=
 =?us-ascii?Q?jXpxwuF9i++R/PtZO0eYTAthACDc90toaM9B7rqpJW5DjhtYqJg6KL92R8s0?=
 =?us-ascii?Q?FGwzkXUKtIioj0fkK0xUWHJeV7/myMXOE9BnSpxyFpd8chJ94KbtXZqJvVKz?=
 =?us-ascii?Q?Nb9+D+fEHBEppF6hQpzNlMyJ1GyFJk5HwhsI86tfDBn+9svv0yxLeU5s8i/2?=
 =?us-ascii?Q?CczuGiizBkcQweMfo4F9+09VgjrlBusjdq1XRxNL8eM7miFa07AUW2eHo8P1?=
 =?us-ascii?Q?B7cZ6DsDY+ckvnJuQEBYDbuZZVOM3m2mNR3dbtY833DM66WUWxkYf54JAR7E?=
 =?us-ascii?Q?/MEcwMFLuvQ9m7mg5U1z6WGFBqk2C6P6iiT6f/H0DdEAhwmZcGnVTmcB75t9?=
 =?us-ascii?Q?PhHr8lPnWV8bWEKiMLQh7RC6qxg2ojtaI6i0Zh2jGDzQu9DSneNOJ9o3d8nm?=
 =?us-ascii?Q?cLV/VzOglOBtecuytYP0wUVHI48JlhGtWHjndi0K?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 843ffcd8-304d-4d27-0f29-08db08a2d7cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2023 00:32:50.0631
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Aw4g5NbuqqPNQMKn60t5+KYp4be+QiFwcMeGYjChaX22aytwZW6xKlcT7lOaIAaP2fR5u/JDaqgmBTL3prC3cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7400
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Monday, February 6, 2023 9:25 PM
>=20
> On Mon, Feb 06, 2023 at 06:57:35AM +0000, Tian, Kevin wrote:
> > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > Sent: Friday, February 3, 2023 11:03 PM
> > >
> > > On Fri, Feb 03, 2023 at 08:26:44AM +0000, Tian, Kevin wrote:
> > > > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > > > Sent: Thursday, February 2, 2023 3:05 PM
> > > > >
> > > > > All drivers are already required to support changing between acti=
ve
> > > > > UNMANAGED domains when using their attach_dev ops.
> > > >
> > > > All drivers which don't have *broken* UNMANAGED domain?
> > >
> > > No, all drivers.. It has always been used by VFIO.
> >
> > existing iommu_attach_group() doesn't support changing between
> > two UNMANAGED domains. only from default->unmanaged or
> > blocking->unmanaged.
>=20
> Yes, but before we added the blocking domains VFIO was changing
> between unmanaged domains. Blocking domains are so new that no driver
> could have suddenly started to depend on this.

In legacy VFIO unmanaged domain was 1:1 associated with vfio
container. I didn't say how a group can switch between two
containers w/o going through transition to/from the default
domain, i.e. detach from 1st container and then attach to the 2nd.

> > btw looking at the code __iommu_group_set_domain():
> >
> > 	 * Note that this is called in error unwind paths, attaching to a
> > 	 * domain that has already been attached cannot fail.
> > 	 */
> > 	ret =3D __iommu_group_for_each_dev(group, new_domain,
> > 				iommu_group_do_attach_device);
> >
> > with that we don't need fall back to core domain in above error
> > unwinding per this comment.
>=20
> That does make some sense.
>=20
> I tried to make a patch to consolidate all this error handling once,
> that would be the better way to approach this.

that would be good.

>=20
> > > In this case the API cannot retain a hidden reference to the new
> > > domain, so it must be purged, one way or another.
> >
> > Could you elaborate where the hidden reference is retained?
>=20
> Inside the driver, it can keep track of the domain pointer if
> attach_dev succeeds
>=20

Are you referring to no error unwinding in __iommu_group_for_each_dev()
so if it is failed some devices may have attach_dev succeeds then simply
recovering group->domain in __iommu_attach_group() is insufficient?
