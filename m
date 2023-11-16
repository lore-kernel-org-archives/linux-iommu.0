Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA2B6FD2
	for <iommu@lists.linux.dev>; Thu, 16 Nov 2023 03:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HpodB+Vr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700104888; x=1731640888;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ylvR0bWQsF0oesywJrgHYYJv4/iIeGTm2XE/zeqwZ48=;
  b=HpodB+VrH3BoIADdd0TzYTpB4tFnMiq0UnYHpFfkpKl2g0pXkSifoDkm
   riHKi8C6OqeuQfW8/mwWIOCtF5sZHkRpr/CGRT0tYYc0MkSsTvSRfsouy
   3G+XHm9LumcJBfjhgQfrKWolIKsTFTfjyJZgctMv6s3d2VwoTRzW0JcuJ
   we1u7H8h4mgACDWpm0gXINqKiYfftH2KrX+eaxP08goBedxnnMyKvCFEj
   3FHyn/u519Eqt0wyj5fiEfDbck0reexmrK2iOnucBTsmEfOvTrfnWhfrh
   z9fT9WjT6MkVAE+qQ2dBIOn0C8VvMVxJE+F0CTga74qk2u9AoqMsPIvpF
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="455296686"
X-IronPort-AV: E=Sophos;i="6.03,307,1694761200"; 
   d="scan'208";a="455296686"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 19:21:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="768786126"
X-IronPort-AV: E=Sophos;i="6.03,307,1694761200"; 
   d="scan'208";a="768786126"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Nov 2023 19:21:24 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 15 Nov 2023 19:21:24 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 15 Nov 2023 19:21:23 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 15 Nov 2023 19:21:23 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 15 Nov 2023 19:21:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dBPsPmboLEJwU7QHrdodJ7EPkBAuC47+umI2VObn9Vy0rRrbeEYzQ4Y5qpDhC3A6gnUthlq8l3DbZLB+4vVJTvaZh0/APnhc6cg0RoP+P2NYvW7mK9yEZ7wLgY6CM7IWRR2Ktgeg00nxJ/tO9MXJ0L5ppQAGNnSGdM6nJzG5oW66gbslzbZYaoGkiJcLod6rVjdeo821BP/myL9E+94CHXXS8JS88mVfB9ZEbL6t4H0xNsyrYi/wYxU6lKcXcvTUpoMdmbYt3Gfd/CZACu0tDLJrNQAd7sp5tYzxuM6R2dvF7WSFiBcmQEVKzuC/Wgd6SqiaMtEmtDg6Gpwkxrjcsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tZKBtBhb/2n+1mLNKXVFwodqbHTJJDBgvbRP65XwLpo=;
 b=l2mEZEBanJdxH9nbUDtMNPUEoO7qFloxzjMeMAP0bbWq2uYni2g9+zO8OJd0bPpoehott3wklZj7hSpTV8phXjqb3obJSqxfgayB7/XKatW9lYZqWPJcd5ojlhtlKqE7/1AbMJezPR6rhuJlE+hvwSGnLAfx+hXvD8HTuAHPDsHyBzf663aunYWTMIbsgIvURtvu/vHqL3A1Dt2d8kcoHjLTtw9DLbbxHN1DExa4cBhJqlfz5DX3PUxLh0U898rN9IaicVqHnhvi5z+JuY2tO9eBvsQhalFdzv9xbHmP5adIbMVSDQlgiWlT/lC6Ri9xDG3GS++n78llTUVdS8FkNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CY8PR11MB7193.namprd11.prod.outlook.com (2603:10b6:930:91::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.35; Thu, 16 Nov
 2023 03:21:21 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a%3]) with mapi id 15.20.7002.021; Thu, 16 Nov 2023
 03:21:21 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/4] iommu/vt-d: Remove unused vcmd interfaces
Thread-Topic: [PATCH 3/4] iommu/vt-d: Remove unused vcmd interfaces
Thread-Index: AQHaGC/1kmvq40BVaUe2vwsfc5oS4LB8RxFQ
Date: Thu, 16 Nov 2023 03:21:21 +0000
Message-ID: <BN9PR11MB52762063ED9337AD624E62148CB0A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231116015048.29675-1-baolu.lu@linux.intel.com>
 <20231116015048.29675-4-baolu.lu@linux.intel.com>
In-Reply-To: <20231116015048.29675-4-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CY8PR11MB7193:EE_
x-ms-office365-filtering-correlation-id: 7b6b82d9-e0c3-410f-ac52-08dbe6531b2b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BNetAO1dI1e/AsU2Yo8JAtCyV9DdvyGzeahzfTbTgpWi9YppzIEmRxmkWFWEzY0mG+3Oh/In5ZDW+Z8tp11Um5IMIK8lk2P++cUpGa8Z7+kbXk8dBoKyyeHamNfU4V7nl0kzbRFWWbfhOMOI5QvxTbzU3U9wfJA5r6bS7Uciq3PZX6jO6+IJfiCoPkritcfpIwzPrGRQYw1fObnXqmXoi1kJxrRNAIESck9rBD4l6Rq63653mFVu8ymCWwNq7MxYOsW4MpCdXbBjfqjhHhJvwilm2ByCrVp7vIKL1tLUkpzGKViyXPHrxQ8EWu+EhEqMks7TmHKAEeV+cVlxmxtCktdpn9E/AUHz8kHAblGwnHiShQmqdRI4UKp+shGz+sO+EYORs8z/oCjXpEoX6D4Cpu5+7iBrZrC+o4aTsO56iwkgPKrU/d4jnSqYGT7y8W2wjym21+23fgQsWHoN6/dONGBeDcQK2XaoavphDUpmKzrTLeY3Ee9Fm9xlJNi6nHHE5NNc0+AEZ0JApI3iHnbcoHPmUjXoqW0hINer6sWkc+1Ft3xX3Zb+fclUY7O9EZWDNF49xvVk8L/f7fWkXjRzDl25b0z3mVKv3DxJgL8Gg2zKZ4mlLU9Bzx9dwGh6P9d4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(39860400002)(396003)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(122000001)(5660300002)(26005)(9686003)(55016003)(76116006)(38100700002)(7696005)(6506007)(2906002)(86362001)(82960400001)(33656002)(110136005)(71200400001)(66476007)(66556008)(8676002)(66946007)(316002)(66446008)(4326008)(64756008)(54906003)(478600001)(52536014)(8936002)(41300700001)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eqX3bDxweVgpoQmMCsmvNyNFOUz4cduQZOjfksX1xyQT7H8Z6+3ZUG2tGHtc?=
 =?us-ascii?Q?NM635NX25NAsdxypZo1v4zUiXHoJ7DdjfdzqK4UnJaRgO8F9c6OhhnbFoqIC?=
 =?us-ascii?Q?E4K94LlfHbAW3DVPa+TO2r2aPeY0s38gDHW+Xx5pt4Umdc2s9cUkKpUSJHs7?=
 =?us-ascii?Q?pIcSpxmuH0jUgzPwoDz0jyFLB1X+MhIqxY57s1GtqruT1JpwfLE/X++wcQ5U?=
 =?us-ascii?Q?5oSoZVZxPr2ztqxYzc4AR4KdXrRGOYk6SYd8pETm8ND0UNjigSOQkhBnRBGQ?=
 =?us-ascii?Q?lBN8wXlNCMFj82IprfvafZC3bt0k1HUJp8/ierpKui66bXToul9UAPUl5IZn?=
 =?us-ascii?Q?wr0vjnVGZq4VaI9AMKdVj6QM3wgYQqEjvoTxPQ8DaUrWA+4ck+sSUGnIjq0N?=
 =?us-ascii?Q?DtFDSytOGGrZSs9yldLjJslkCM/zujcBnZQflJpHSo6OWwOGvziW85MTtCSF?=
 =?us-ascii?Q?VHcwYmPrufE62CuBzzN9dsrnwluuobjlL7BFdTTAZJUhvGyAMVKhL9HqZXl7?=
 =?us-ascii?Q?I9t2dQpf3G7D+Vp7Mcoe9+DPiP9PVhrDohC+g4ZQKeftuPuA8UFkMPUsFylx?=
 =?us-ascii?Q?D7ymcWQPHCW6xSx73mFZ9mUvkQhvid3CHshjE0wD9x63LOWZbcqqM0EWVHlF?=
 =?us-ascii?Q?2r+Tn1bznlovGitkw5Bnr7lSRkHN5tmveZrHb1qd8tvf4WRoZDtjb2n9zfPu?=
 =?us-ascii?Q?RjflkRxuKySd4LRexHaNwJXx/jGuoV6Lq/xKfKYKPMhtOplMdXOU7Xq5PDYL?=
 =?us-ascii?Q?QlayyFylMHJP+a8OFv5U86aMxPTQSyT5BzNwYYocDW1MplRBFr6voqpI74ud?=
 =?us-ascii?Q?vGFUGj2qmUOjRZ43tsHikNJFMVOnvE+apBRF3/reuBggCXxUqP5FFlbRrl2t?=
 =?us-ascii?Q?pln9nwHHVVx3n4bJfyjJq4qgvm3FO8QdSioqdXoUw0WwR615RZaryxyGvLIA?=
 =?us-ascii?Q?4wIVFAElrXO1hwoHF4wt8bOfOJGvwHErcBcyzzclI8gq3ZCwVuOTt9UrPPxQ?=
 =?us-ascii?Q?+B5lXbl+B+sAbwpzi8ji3Djbh3si4gH9S8yP+6VEfpMiJf1uqnXjjbVphm9S?=
 =?us-ascii?Q?E2yCIxaSoVpHTGSfTIZ4QyWYbNnbBGw/5nD1olp3++8ZCWP+4RA32yXw5Lmo?=
 =?us-ascii?Q?pCobCOhJAvwGt/USmddvyyqH8pI0ZVB3R3b4HHMB53GPlKPR8d0nxG1FkrU6?=
 =?us-ascii?Q?nd9IrSBGC/yc1GQjr7G4sH37REcmkIRxfwFjRrVq6jtchv5eOI4mnk2RXi25?=
 =?us-ascii?Q?9MhKXnmGC79meYAmpMcvThjxgV5HLqorZAPdEyNhQ8cfjUPdXut3sPwrosgA?=
 =?us-ascii?Q?3gz7EeAbx91AZGvuP6YPDp/PDLB8yd6tOX8B27Eg0Ovwdc3LltbaW7/EDrik?=
 =?us-ascii?Q?qubyp3bVWbPEcXnfD8IMynR6BUUEzsYRueW/gA5Y5ZosYi5QTy1YvmXtwM57?=
 =?us-ascii?Q?E/oLJTcRj4gxu52fuECKlgclVUSgvDgMclNiWMFEpBJhM/xwTjlZ3T7BfzWh?=
 =?us-ascii?Q?PoDjE/wFDHYytY9lyZOsvvF0PJ3yWejQp5dxjDeHSi7uBQEdIEQSSe7gNrOZ?=
 =?us-ascii?Q?5Y1RMUaN2zX0PoSJ5ZvHY1TNcGwOwEhnBMWSCnh9?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b6b82d9-e0c3-410f-ac52-08dbe6531b2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2023 03:21:21.5490
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: px/o3tSUz44ulVtEvpKGQo7Qx4+JJLtuk0p7cy93v5gCSbtua0d9gt2jRsrzE0YoCFwn356xKTUyc8KdeRmd7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7193
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Thursday, November 16, 2023 9:51 AM
>=20
> Commit 99b5726b4423 ("iommu: Remove ioasid infrastructure") has
> removed
> ioasid allocation interfaces from the iommu subsystem. As a result, these
> vcmd interfaces have become obsolete. Remove them to avoid dead code.
>=20
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

it's a surprise to see some remaining vcmd bits not removed.=20

with a grep actually there are more (mostly in the header files):

drivers/iommu/intel/debugfs.c:  IOMMU_REGSET_ENTRY(VCMD),
drivers/iommu/intel/pasid.h:#define VCMD_CMD_ALLOC                      0x1
drivers/iommu/intel/pasid.h:#define VCMD_CMD_FREE                       0x2
drivers/iommu/intel/pasid.h:#define VCMD_VRSP_IP                        0x1
drivers/iommu/intel/pasid.h:#define VCMD_VRSP_SC(e)                     (((=
e) & 0xff) >> 1)
drivers/iommu/intel/pasid.h:#define VCMD_VRSP_SC_SUCCESS                0
drivers/iommu/intel/pasid.h:#define VCMD_VRSP_SC_NO_PASID_AVAIL 16
drivers/iommu/intel/pasid.h:#define VCMD_VRSP_SC_INVALID_PASID  16
drivers/iommu/intel/pasid.h:#define VCMD_VRSP_RESULT_PASID(e)   (((e) >> 16=
) & 0xfffff)
drivers/iommu/intel/pasid.h:#define VCMD_CMD_OPERAND(e)         ((e) << 16)
drivers/iommu/intel/iommu.h:#define DMAR_VCMD_REG               0xe00 /* Vi=
rtual command register */


