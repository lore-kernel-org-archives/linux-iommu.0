Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A35EC5
	for <iommu@lists.linux.dev>; Mon, 26 Jun 2023 06:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687760011; x=1719296011;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ooi9ZUmmsY92UeXQDQYrytUZb+Dh95JvscMItA7x7hU=;
  b=Nyi9E5mDx5O35vCbgA3vUelffrGA9PwPa8MDhmQ6lA7y+vJXRf14ohEH
   Cgq48s8jzcZVxpNi8XogIlSjZd0p/v+XV7p9siLze5FhKH0nn10/iUyFI
   CP3o3QFwdM7coQ46gMbLT9xMXSkKoAJ+8bFfQWyRXPAEbhOGEkzzRpbBI
   oE0/dSOCyQTaLqH2D76643RytR4phlZ7RCSLvd6W9uN9/80kXndm7n0h8
   hx7zNjGe+l7ggqy+f+N20x27hKQIKPxxszpdkhO/ENpkYDO7sD/IcFRuE
   2r991w4aqIxCWRfx1her/RLaIXHWDVP1gVmIYiZg3NAPJFhinmnGL4rzP
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="364632028"
X-IronPort-AV: E=Sophos;i="6.01,158,1684825200"; 
   d="scan'208";a="364632028"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2023 23:13:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="860558814"
X-IronPort-AV: E=Sophos;i="6.01,158,1684825200"; 
   d="scan'208";a="860558814"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP; 25 Jun 2023 23:13:21 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 25 Jun 2023 23:13:21 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Sun, 25 Jun 2023 23:13:20 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Sun, 25 Jun 2023 23:13:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UewWkSG3ETvHnREYlOxYxYAgVvf6//CuY8IW3g87Iol21cEJsEIOyvCl82yTp7KBERmcrPlNiwe3wgxOvxJLIC6mOuLH+peLdHn4o92xko9IvxHIVu+/zydPg6cySjoFNefWXmA3OcoY8E1JQODEqE1QFopcRgAVcfoJoXUVthM07lo99RaMZfjQ/GioBYG1s4cDBBpRbzKgkfHJxRSUS9wxkBX7/h2RSqE/a54blxshQWpTmhKf3VZpgAVm5BB0cGY+Afky+K9pfbE74Xrj+0qzb8rKaaPSIO5G+QZUZ9xE6mbYb4trT0KWtzjTNiSEfBdu3uPGsxyzwWEiEN54wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ooi9ZUmmsY92UeXQDQYrytUZb+Dh95JvscMItA7x7hU=;
 b=Hz7K3dYdZuZpSGcV+V2BFztUWnaenE8umma3YnWYynq0ev51h7sCa9Mbl7fmgKEK+dDK1BQRNHGv4BpMWuy552xTAMaPMcmrvYLXVXpRWbXepPU89J0YAu9z6xrgCBdS6pkpO8HaQxzmIxEy8YehsMQbubSn1rlwYMk9WbnwTIxQtRJ8LA9WkZUK1BTkRRPxJa9NT5z12bzTCUh3ArBL3Q5yX8E+AhuRpKujAb/Tjttx9bXFemV7/RfPeGzrZeN7HGZcyIPblyW5vszwuITV7tpTTwu3UTGBrj4rle4APEuMAAUzrcWkM9Kz8BOyKZFqBZDt1dBiMvJsrKtimCWfnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS0PR11MB7766.namprd11.prod.outlook.com (2603:10b6:8:138::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Mon, 26 Jun
 2023 06:13:17 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::4f05:6b0b:dbc8:abbb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::4f05:6b0b:dbc8:abbb%7]) with mapi id 15.20.6521.026; Mon, 26 Jun 2023
 06:13:17 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>, Lixiao Yang
	<lixiao.yang@intel.com>, Matthew Rosato <mjrosato@linux.ibm.com>, "Nicolin
 Chen" <nicolinc@nvidia.com>,
	"syzbot+1ad12d16afca0e7d2dde@syzkaller.appspotmail.com"
	<syzbot+1ad12d16afca0e7d2dde@syzkaller.appspotmail.com>,
	"syzbot+6c8d756f238a75fc3eb8@syzkaller.appspotmail.com"
	<syzbot+6c8d756f238a75fc3eb8@syzkaller.appspotmail.com>, "Liu, Yi L"
	<yi.l.liu@intel.com>
Subject: RE: [PATCH rc v2 1/2] iommufd: Do not access the area pointer after
 unlocking
Thread-Topic: [PATCH rc v2 1/2] iommufd: Do not access the area pointer after
 unlocking
Thread-Index: AQHZo4EiQjWbqEjPrkiPmAw19pPoza+UsZrQgAB3DwCAB3rEQA==
Date: Mon, 26 Jun 2023 06:13:16 +0000
Message-ID: <BN9PR11MB5276FAD35733D4BFC23863628C26A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v2-9a03761d445d+54-iommufd_syz2_jgg@nvidia.com>
 <1-v2-9a03761d445d+54-iommufd_syz2_jgg@nvidia.com>
 <BN9PR11MB527648F55F4F36A24B50E6778C5DA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZJLmIr8NLEVjddWB@nvidia.com>
In-Reply-To: <ZJLmIr8NLEVjddWB@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS0PR11MB7766:EE_
x-ms-office365-filtering-correlation-id: c6546968-60f2-446b-8728-08db760c6e93
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tYiL1sSVNwkrJFK77ET9rPacwMXw71YxdYxB1FWGjGJAi0ZIwY7MYBjiLhfYKbecoa0QxVMKmRGhsBIApnVOxl3V3ChnRECSvSE5Ahr3TxRMt0nAZy6jEJEW8Vp+KBFLUDF+1yKOccNN2yqlLf0RgQrNO4SC5dPd2R5Ws+ZtBS5ljuaW/cbTP72ZFZzSxj1hYHad4ba5Jl+iRIG68rWORsimnzUtLGWRaUv+SWl2Y+kuGF77piG1HZBzOFY5j+5uczplUx5ikPuDwNM6sAEvW1pbkI87XGmC8wE3WaShkyRG8AHfDGDpmkCsg8SC5R77M0U0YMRhfgWWGHjJtt73KKVESXMTYIfy9LPwvqId6zHSOApbUePidWyrOW5aDEEZHndaZBmqJ/VmkPbJ5921y9FRu19MMiPDtBdyhSz2vCI6JtESca87Q1akQr7IpWg8KF01RubiMCCzQmtTKXpcM8S2L3PFukROwFAwETaYO7RWTVYsRslP3uBJn+cQrfrlugqln7WnY1tJlDY8H1ktfew1xnuzEb/CFfj6posahDlL+CMTazq2cY+b6fl5X2F1iqcCM73qgK/ISZYPBDx8kkvql3JCQo7E8uEDPt1iq1+cOoP+DSfEo97mWRe4a6c+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(396003)(39860400002)(376002)(346002)(451199021)(33656002)(5660300002)(52536014)(6916009)(86362001)(8936002)(8676002)(41300700001)(66556008)(64756008)(66476007)(38070700005)(76116006)(4326008)(38100700002)(122000001)(316002)(66946007)(55016003)(82960400001)(107886003)(9686003)(6506007)(26005)(186003)(4744005)(66446008)(2906002)(7696005)(71200400001)(54906003)(478600001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Y3mPgIuBCWd+D2Q3hFutqiKPj9lrNghXSVL6M227onKLCIR0iPg7qKd64Am7?=
 =?us-ascii?Q?o5HpzdupAh4u3CP2TjZWbXTJ/F0F3OF2YKMpmLJs8gkNN9Csc1w6JkQwXXWq?=
 =?us-ascii?Q?R6jMiWt1Tnpx5VlFdW9NallxP8E+KlAl5kdlwlMHlgpgHxLs8F44rbxurf6p?=
 =?us-ascii?Q?VfwJzMNvr5u5YkKlb+RXqIt3uwhXj5v0Tej7drWMyFuRjPj9inX+mUupx7mL?=
 =?us-ascii?Q?17ot3qBx1AK0RVckImVrTwTfI6OJnpN5g4czOJAFMHHrWe2Vcku4mQ3VCri/?=
 =?us-ascii?Q?EB8mmDwcc81CdTUX9vB6v/7ZoY8rMZFXxUdDCxYet738+dzYCdzmgV2ETO5w?=
 =?us-ascii?Q?q/YrcpLa2LwYyvL7yGWwRHHUfMHH+XvqUG+MAemz1w0UvXhf+jNaCuQL2EEe?=
 =?us-ascii?Q?9ksZOsf7lLuvacq87kjCg7InJWGhAC6KvrQf7NynG/e9pTOcP+9JlUrZj71X?=
 =?us-ascii?Q?g0mp8p/lY9nYBLjfd1aoOBY2+9VZBRKJPtOtZzBLD6ZBYrbcv8uNyXf2d4Yq?=
 =?us-ascii?Q?tEdEEN1GPBOkJUxygrLZJ9FZNK983A5uSD9lAW00epVCPJ8rEO3+SoEHkp7H?=
 =?us-ascii?Q?4aCusKouJAtQs5xob+brcEx8JoXumGL8U6DrJp6pF+v0WvfjZSaiQXZP14Kb?=
 =?us-ascii?Q?BdhVw0LYG7MN4W4jrT494jASVi+3QNCuPOrJVLp+aXzExok7b1TnAOk7ucvJ?=
 =?us-ascii?Q?YLK5g91fNGDbvUlZnU1V5usU31u1p+X0eS9aI4kgLH8Pw41xfgpbOWQMN4Fq?=
 =?us-ascii?Q?eCFFaNkf5/T3wX40Ncqh33J0ndVg+Vl2+iJVCzf5INao7UxmynLy23atZNy8?=
 =?us-ascii?Q?07lv/7YLS9Py4P1a9C9+kKqXrLIT+EjTBDr7i/qME/6q4mdqTeyA9dGLn5VR?=
 =?us-ascii?Q?S4tHyy7WApSeAdaxMz8vh247/KCLH2Ts3p3lsSr0keAiDJt6bQIVBg+WQj38?=
 =?us-ascii?Q?F/clTEsQa28SRFv9a5oIy/b3HTAlEPO9NKZhHJ+Bc9WVEM6eyDrOWB+P7c9q?=
 =?us-ascii?Q?X87bDvf0wxww+GGRDgTp8S2mVZ2R0nGXXlfsESlP/DnxR+sJJef/DyvlR5Af?=
 =?us-ascii?Q?lQREtW3LB1fRlXJpfvJAdkuRUZTZEhsoo+5FQB2P2A887Go+MiJoqayZCzRp?=
 =?us-ascii?Q?uR10M7tHun68X72KWwxfCvenLcf4Ngsd6fTn977ZMeMkPeokd/C49UBoPolX?=
 =?us-ascii?Q?WwF5lhYFfGds8M5YTd3VK4HWbXtnrGd6Gs6rllkMW3PqDnevKKrz8pwvpjWU?=
 =?us-ascii?Q?dNBQQsI2GwK92tW3520CDnSmyq4u/YBYmdK7LJfL/hu5TmjsJu+M+rpD1MhD?=
 =?us-ascii?Q?OF3iJGWA8F0RJL2lCrMq4Not1Pu400EwvEBbr1TtsT8pG23Ri6OC9wb7bPCl?=
 =?us-ascii?Q?h1zyMBzOttp4ufMNCnBLuohiuH8Ig94lK8QPKgH5Z5EoJCXsl4O04u3UMAtt?=
 =?us-ascii?Q?h2sE8zrlSYdqGfUzzW+xFBOsvVOscC2jSbUHtYGp5crDQJuF2yEFMcKf5CbW?=
 =?us-ascii?Q?9SBVuxsynAugyb/TSCaBPHOqNHoyT70WUDNtwZZh3vLV2YtJCy0KRbgFAh6O?=
 =?us-ascii?Q?1gGG85Dph5OUG3qn+wIJdGIwKoR5FB/3H+wSmbn2?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c6546968-60f2-446b-8728-08db760c6e93
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2023 06:13:16.9404
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kI8qFjqCG0jEVDPvxvHBl8MLhNX/UmCkK0ySovfV2oQ0f5UqyavOdFpO6HNhdSL9BKmU8CZmf0krLmgiz7Ac6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7766
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, June 21, 2023 8:00 PM
>=20
> On Wed, Jun 21, 2023 at 05:01:28AM +0000, Tian, Kevin wrote:
>=20
> > At this point what about a concurrent thread triggering freeing of the
> > area pointer and then adding a new area at the exactly same offset
> > and the new area is also attached by an access?
> >
> > If it's allowed and repeatedly occurred, then the counter may overflow
> > too given the new 'area_first' is equal to 'start' in that
> > theoretical case...
>=20
> Yes, and that is appropriate to return EDEADLOCK if we spend too much
> time trying to free the same IOVA.
>=20
> This is userspace harms itself, no sane userspace should race map and
> unmap of the same IOVA.
>=20

Makes sense.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
