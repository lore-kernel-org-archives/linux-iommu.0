Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1338815A0
	for <iommu@lists.linux.dev>; Wed, 22 Feb 2023 02:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677032087; x=1708568087;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1MC7s+VfvFVWYPSL5e8Q3JGC5svFMePEyj49taxLDAI=;
  b=lvdQLmZx9FnEpvYhqVy/++tnAl6k0Uh2C9HdWxZJSyw9YZXwYoRA8VrQ
   CczBzzqf6AWH2KVXvqyLkhVAssTNIlL5vqp1jjZVf0N5eHwqegXUHPQrF
   bBAubZavCI2BQWCslpCUPY9jd4++PBe7cHpIEwllukh1xtfH86XNoCh8z
   cvJg5tOmmmNgFFYQX5/Nm2uZYsHSuKDZKDerB5kIAKH/YyCFxFffKzlZu
   sjOscIVFcCpGHWsICnRR/OHsvwPtINN4aW/hidlI75/GhzMamkCsQWymV
   +G28AyWq4Ps7mCWGjSn+i7qEu+99OqFmEVgk5EOyBv78R6yhFLmTN/qWV
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="335009498"
X-IronPort-AV: E=Sophos;i="5.97,317,1669104000"; 
   d="scan'208";a="335009498"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 18:14:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="673931944"
X-IronPort-AV: E=Sophos;i="5.97,317,1669104000"; 
   d="scan'208";a="673931944"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga007.fm.intel.com with ESMTP; 21 Feb 2023 18:14:45 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 21 Feb 2023 18:14:45 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 21 Feb 2023 18:14:45 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 21 Feb 2023 18:14:45 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 21 Feb 2023 18:14:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M4/XE7Q4eExx74FTW66kTQQm81928BZR6VQPOp4NfdaIa3OU+TTlMJlpKoSqkRGzvBy/Po3/OYst8KSvAjSVJqPh71Jpa82UXDIm2HVh1HRYL6dRfgch0k7xzEk6bAGc/IUPgAcFF8To2kpZ6rt/KEDAYxXrevfNtpFfHzQOKXtQu1LJyIhzHNhFa/6z3sRhFxBKLB6AMitNhaGHmEenENYYnXuDVDeQeUzruNUXOfvsozLu/LyJmiOFXCFI/E2b2AFFQQoDF2sf6sF0Qd3RCdvpkHkMmWGucT9r1ydh+g9f5Kg4Z8I76/412O8zxgFD7e7udb4O7DwafU/JGrFJ5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gs4L8U5TySq/T0/zudpDcAy7SzPDv1o5K69xvqiWff4=;
 b=e9JdwhC3ILPjqf7IOOMNG/lhXSOuVakvj5ujGFUJ9Y2sCo1jpkMnI/QyjPmjKlOeMYrkR3P2AnjSOBcc/IcZE8WeXc5qCFh0xa+nIq0LvHrrvyC6nTBRHlSL40+3T1iJ9Kk02irKB0XUyQmPvdWpLQWP98Qzw9yiUvXvFMsC8ionnZn8vUAudQMlHgK3ACe35fKvyo6dSJ1q/WUvW/e8EDka3VMb6F6hmYGG1nAVMtWsUS68I3d8kEt/Zp1sYis8MD6q0A4PJlhhbdKIzjeiUsXfdEgMniEnOYKcqQQOyUa6JVpXAdGt6FBMaE4GpSB1lbcq2T3Te4j+l0/TghW7ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MW4PR11MB5797.namprd11.prod.outlook.com (2603:10b6:303:184::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Wed, 22 Feb
 2023 02:14:42 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d%9]) with mapi id 15.20.6111.021; Wed, 22 Feb 2023
 02:14:42 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>
CC: "Yang, Lixiao" <lixiao.yang@intel.com>, Matthew Rosato
	<mjrosato@linux.ibm.com>, Nicolin Chen <nicolinc@nvidia.com>, "Liu, Yi L"
	<yi.l.liu@intel.com>
Subject: RE: [PATCH 0/4] Fix hwpt lifetime and detach bugs
Thread-Topic: [PATCH 0/4] Fix hwpt lifetime and detach bugs
Thread-Index: AQHZP9V0AqzGAFoN9EapmYXn9NwL4a7QzpwAgAl3vCA=
Date: Wed, 22 Feb 2023 02:14:42 +0000
Message-ID: <BN9PR11MB527647F6F32BA61775F348E28CAA9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v1-4336b5cb2fe4+1d7-iommufd_hwpt_jgg@nvidia.com>
 <Y+2Isu/aAPm6PfeX@nvidia.com>
In-Reply-To: <Y+2Isu/aAPm6PfeX@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MW4PR11MB5797:EE_
x-ms-office365-filtering-correlation-id: c251ff00-20dd-4740-b45e-08db147a8f49
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UaDLlGQ9K5T9nveo1xDUHsXNwPymMwXh8TBKLMVsaE1yNn5a//dvxAtVgBpuMhB6pD+ztVgm98yg59NKvhgmNG0qw2Qp6mAwdCcSWnAZ9nwfpC542sOuqMe4AXsqQWogzWHDBtUmgiQ4Z5QfXefL/CWWaMxagehFjFmyMkWnP1rmOKlKdHyBpVuPFp2ferhmE0R55AR03vRGJXYYzDM0RwI4QQIWkZf+pdr4vYY+8pCLTY+Cdm22NWt815/8VneOx7zSh0JuHqSsf1Nnu1VTTlnkyCjpC0dO3H6BlJ6RpTir/2Luv1iCx65LlHrY3II38x8/J3TP9vLETwl60TSdznWnnH3yYOgWrsd/TpODTeKI+ZYzsKJ/csKoIdlxz9+mAevWiZ/7ZA0Mm0FDUln3SV6Vyt3UXCRfAURgPtGZGZbSC72V3Gn9MiVwTHrdaeY12jcmSAmy2O7PGHWG5pprtOHpXo3SzguwxUIwQlgF2wlOS+VvweKm3NggsYKiZaDT5bRBWMFs1oZ8aPNiDwRfOu3PBZaosPLNGp3hLKQwBEu01yC/exKlMceurQtGHtPdUqmqXX5txPDkXs3I2/BvAVMcJDrX4M12Dc3rcyOso6kKh6QAfITheUjNe55K1T1io+M5nAmtx/RfE7G0alBbWyWsoK9JG8WNN3QG+N6R8vR2H1nWwiIGg+05Bgcziqjo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(39860400002)(136003)(346002)(366004)(376002)(451199018)(110136005)(86362001)(71200400001)(54906003)(7696005)(316002)(9686003)(4326008)(55016003)(26005)(6506007)(186003)(107886003)(966005)(38070700005)(41300700001)(38100700002)(64756008)(66556008)(8676002)(66946007)(66476007)(66446008)(5660300002)(33656002)(2906002)(76116006)(8936002)(52536014)(478600001)(82960400001)(83380400001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GMzGpo2awYuePdB+3LtGtYySPR8TqyZcK0LCm81KPP9kFtoZng67sYoGFx20?=
 =?us-ascii?Q?CgDyNwho5Ek5ygNH6/XImGBfhicItWGetyUWLFTIDNF6ooI8gMkVl9kX84H4?=
 =?us-ascii?Q?EmwXg0eBH+yEqnabNp58FKLW2aoaVRMWH8ee0ZcS3re/3YH8ibW9ufkYBPkV?=
 =?us-ascii?Q?y4ND5zSE4JSK2U7YPCquXZmjStBy7TAVli9Uox/aXQj7oWdRgQ+r+dQlBQpf?=
 =?us-ascii?Q?FI+b+F6CQ4O4gaVrh+Yu9zm6to9U1GQ+uigfEJ5asHayV2AduGwacx4BsUZF?=
 =?us-ascii?Q?ACQNVaO/8j9yq1fU45br+r424wxG6QM7BjTyawFlRUawrXUpXQDeWFXgCUu8?=
 =?us-ascii?Q?O0Ay/4SanPtF6g16HZzpxYvwT18fvX1Juc4ukOq37h5FBkJmZ0cjEl/fQ7Yc?=
 =?us-ascii?Q?AAbgB7kiXEPlXdMF3Pj5T/GwQTCcQEK3UHD1yJ2dI3QHQkYvcNJi/2lD7o3V?=
 =?us-ascii?Q?gx28Q35bxn4zTaSy/Ddrjcnom86/ao7j0+2PpbkzT+CYv1tqKWBts86b0uY2?=
 =?us-ascii?Q?5fIPDOE6vIHVhLYsf9wLlX+GwvnZaYZqPjww+DKMt7mzhG94p3WdESyExRoG?=
 =?us-ascii?Q?XKVi7Cf0vNgV+cnFQytaXO9mMVWSi5c5H8K0EAkaC3+ubCrJbas5ACkuBg0g?=
 =?us-ascii?Q?ZL45yuizWJ/qA0EtSmz4Z5ESHkbo4H/f99Ndc2FZPnEvm3xI/on9eFdFYi7S?=
 =?us-ascii?Q?bl00jjjOfncLCRXdLkz7pnpb9ug2nHyng4V4Iz8hz3gYdVerYc42Id2JuKtd?=
 =?us-ascii?Q?bwT+K/PoT+37aP0ljaj5AEKIyfe5abQCgsaSsE/9/dVviqTPQCdFm0q3FBHL?=
 =?us-ascii?Q?+HT+/Ddq6NZUzjZ2gHnb40RkgDtO6M8GfW8DOSzBBC0PAGXw3uopyrCJ0oc2?=
 =?us-ascii?Q?dk0AMnx4SwO8r7b/NWrYdhF55M4CRacOZvtfLma0lfLRDkPXo7cW430kCxQ5?=
 =?us-ascii?Q?aPKnoEjBCvyu/PNKW2kivFCUgdr+W6mkax2r0ObLX/c5mX6TKnOASzF0Do0g?=
 =?us-ascii?Q?cg0VLzo8XfgUTo0hTQhrRD2CNbhtyqTOhf7w11tyGwQbylBow89vQN2Wypay?=
 =?us-ascii?Q?HRLBbl5NQAUg+utqujwFxaSBTsN/jZgGl8cDZMJtLdjcpiOYiNsSEEuV9D9N?=
 =?us-ascii?Q?lw5rom3ETS5s+0/Q08ZH+oYr1M3UBE0QDV7le8QecSPVWgDFWAxBUqj3H95J?=
 =?us-ascii?Q?HGIwCsSzcYkOE6455a5ObHdbV6UZDOI7IMZfyuxV9wVbLKhgZDvQ3WGAhylB?=
 =?us-ascii?Q?p10r2IYriSluZCJ2VDByMtPNq2U/ZArb8s9lk+fksOpR9zF9Nv5/NG5sg+2B?=
 =?us-ascii?Q?Zaxe7mMVR5/kc9+bZqMt14CQN4hi5ODwNluYQoyAVhc05V2LsGNsGelzxkbk?=
 =?us-ascii?Q?hOFKW0pxCNu+xqDnfJGzpJKmUertPE+ivnMpjMQAgyr2pua6ZT96Z3lBVU5m?=
 =?us-ascii?Q?QpgdZV+kABUVmnBsH4FLoU0GsjND1opa4pmbsG/vFCMIm86tI+l174kogu/r?=
 =?us-ascii?Q?d61czTroo4cnPTdyYIzRlV9/VI/zW0Zkhu2N9JTXKek8RqLpHvgK3ZD2B6fo?=
 =?us-ascii?Q?4q8T+IPsfc/Y38jCqrlJPz4+Sc46+7I4OOsSG/yZ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c251ff00-20dd-4740-b45e-08db147a8f49
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2023 02:14:42.4970
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M6A13dgSF4Y6SK4XKChsPS/tl7dZWVYSDfzkjN22mkTsQR5CQEb9f8fLXVaYzUXs0pzF21sXrIrRVslZagFB/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5797
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Thursday, February 16, 2023 9:37 AM
>=20
> On Mon, Feb 13, 2023 at 02:02:41PM -0400, Jason Gunthorpe wrote:
> > As discussed here is a small series to address the confusing lifetime
> > scheme for the hwpt. This was some leftover from prior rework that was
> > never fully cleaned up.
> >
> > Make it clear that the ioas and ioas->hwpt_list are associated with the
> > hwpt during creation and never changed until it is destroyed. A
> > post-finalize hwpt with a positive reference count is always valid for
> > device attachment.
> >
> > This should simplify the nesting and replace series.
> >
> > Jason Gunthorpe (4):
> >   iommufd: Do not add the same hwpt to the ioas->hwpt_list twice
>=20
> I've applied this patch to the tree
>=20
> And my v2 of this series is here now:
>=20
> https://github.com/jgunthorpe/linux/commits/iommufd_hwpt
>=20
> Which is completely redone
>=20
> I will try to make the patches to do replace and alloc hwpt on top of
> this, I think it fixes all the locking and consistency problems.
>=20

with group now explicitly tracked in iommufd presumably iommufd
can continue to use iommu_attach_group() instead of switching to
iommu_attach_device() as previously planned?
