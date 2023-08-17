Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E0A80D
	for <iommu@lists.linux.dev>; Thu, 17 Aug 2023 08:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692261490; x=1723797490;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EY30rSe/Enq/sXVf89Xc75UBZDhryb2RXjDL8Oay5UI=;
  b=dSgEpTqy8oksqVgTOFj1B/wLBza4vzTzTNUITmK0lm0P2gghHVdqs1up
   t8GZTCKLC5rtfeAESqdhwvvYxDCU443KvTZKmM9xQa/tGmUa0ssX7OU1F
   5T04+x1geLuORGK9tiT4l0YyNjMalx4fBjwaJAiu6XDN+9AqwtlSalCzc
   C7BdnT8qokMUxJpJi3qTrqAj+Et4biScr3ZsGgqkN0ImcbPMv4BdCc7Jp
   5bJjtX0Em2zy1CkwkhJGfsBDL6uA8tUgz8cYdTzEvPuPiaQnrUiO/oFb1
   5FxM5J6Mkl3D/a/4W2KMJ2Xto6Cj+QNatFopTLRXqeXbjy1/D5uNpM/+S
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="353067920"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="353067920"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 01:38:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="769532415"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="769532415"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP; 17 Aug 2023 01:38:08 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 17 Aug 2023 01:38:08 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 17 Aug 2023 01:38:08 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 17 Aug 2023 01:38:08 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.105)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 17 Aug 2023 01:38:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hGm8jhNoi2KCpCaDoQiWMXPJkKoYFNS5kCVzRZ5xVQKQa9jxShxasx77HR2PpqHVFtNyxYbjHU8jRPY+TYjZb05nBIxPooaYX2U+nz3czbi9lBV27Rojch084evuKEJofDG+IyEsAxzXHSYdIuIvhaYRrrrAdNvhUawSv7W6s5e7Yrf9AKySYHusIqlXtVYrni4+fcLr2E/DiVbXXLakBl76YBb0FCBVw6rVgZK5SLCSG8G791FueXluivVMeR/NWeaFou4iPs+p29Jqvp6oHvFDty8zQIg34pu+N8sdG0Um5eHGGAQncAOEs83PmovHN1/+G/8XXuZl8ns++4fAQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EY30rSe/Enq/sXVf89Xc75UBZDhryb2RXjDL8Oay5UI=;
 b=Q4lNBlbaTWZSIeTOTgC1WBFH0YvyU0/iYR7hiHnuMmWjHbV01rAUaHvXd6zPq8HwNbYCR1EFayIgMvXIcQ9pOTutmL9JOxQaVFynIbgBRHzoHfLcMxXvoWBNrRIZ5ucbYnIcx5GIeJCGol6c6b//do11wEW1hLDx7xbATbKFfo8b/a1XWLqBEsxeol1Kt6FEoC05hJcy3QN6/XNrTbIPH4dG0CpIkK9rk9fTkoDfTewmDPohaZnc8B7Q3ONT3H76NZZ4vlpy8L85Z8RMCLsDQqCLTk3tbOOn035HBVRyA4BJto4c4j75msWizHnzWGgXOnVyer57lOxRcJncAHDeDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ0PR11MB5789.namprd11.prod.outlook.com (2603:10b6:a03:424::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Thu, 17 Aug
 2023 08:38:01 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dcf3:7bac:d274:7bed]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dcf3:7bac:d274:7bed%4]) with mapi id 15.20.6678.029; Thu, 17 Aug 2023
 08:38:01 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Yang Yingliang <yangyingliang@huawei.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>
CC: "jgg@ziepe.ca" <jgg@ziepe.ca>, "joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Subject: RE: [PATCH -next] iommufd/selftest: fix unregister device
Thread-Topic: [PATCH -next] iommufd/selftest: fix unregister device
Thread-Index: AQHZ0BoSA9owTKDvVk61tzbPEZ4egq/uK/gg
Date: Thu, 17 Aug 2023 08:38:01 +0000
Message-ID: <BN9PR11MB5276B1D1CBBEC3C0AC7141A18C1AA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230816081318.1232865-1-yangyingliang@huawei.com>
In-Reply-To: <20230816081318.1232865-1-yangyingliang@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ0PR11MB5789:EE_
x-ms-office365-filtering-correlation-id: a075d289-a560-4e53-501d-08db9efd445a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vfqcLlkcu+A/pH1N21naoS4OZHm0LFATMHand+Bd3JEhncWDu7lR43H5b+147LJbCA2pWvSIMyQTBXKB9hJX18aLqO8bgSdFc2XBpZUWrkoU2mFkboexS23jYjDvNG4azgsjE7nhVK4VESNtypzYG7MfXtNv5JaqAWzyFHkebLWRCHScdFyd2CBrTGAGusN5PkPIM5gtKMS+UcorFe79PPgn/B6QnnF+0oVUYfIGclB6UWjdgBoqC76g99MWW9zUaa+C6LLF60JuuVg0I4OcR87ThW1KURFzZsKCAbkyV/ZzW1afN3EANcbMk9kgbDZL3rZAl0XOXufDgA4ceYUEeRwMStnNU0aud6h8QyGiL88mBJoNXTaD6pipxUemlXyg9q4Fvkkp6WAm61TTVSY9aHGGPPLm7QKx6Xt/FuEPoRI87eUiSd3USQyimGxKnOJF8bJPeHv9ZxTjT+mFnySQDElBlB2bVlfNJr8mRooSZ8Q1dFKuh9HGCI69jrWACxrpxnsKed2CNnWc1u8q51p+TrcHIJL/BsEGU7+YfDRrrnk/IMP2pR1n6t7aWLLEIAOCuY4QFi4ydT4ZVsF2db7bCzbzrmEQy2lhCesx3a64ECVupb0zDeRqD5EwqRDcf9+L
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(346002)(376002)(39860400002)(1800799009)(451199024)(186009)(2906002)(4744005)(26005)(86362001)(478600001)(6506007)(7696005)(71200400001)(33656002)(9686003)(55016003)(5660300002)(52536014)(41300700001)(66446008)(122000001)(54906003)(316002)(66476007)(66946007)(66556008)(76116006)(64756008)(110136005)(4326008)(8676002)(8936002)(82960400001)(38100700002)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?csITXshlHgNbIMd3eISh5LU5w4prX0adWQFG8nPS89kJsdo8DqJggYbMESNC?=
 =?us-ascii?Q?n2IeclNk8GlBeMT5gN0TzPozwnAzqtQzFNCEvUZlwabEoIAzHfYm+HjuCsyR?=
 =?us-ascii?Q?GK2wYL+1Rb6EtcFtBQ/UTZEgzT2OY12fuIW7+byv70+oJOhOfYSbu78Xex6/?=
 =?us-ascii?Q?vlTqpYqQqiD2nk2oL0kROpSgmGcY2XntYtDMahIM7+JCyAarFfnbWIex9fWU?=
 =?us-ascii?Q?+xwOw7mj/d4b4LIgw2LDM42mpXX1IpwxEVhxX6p/wQG960RBOfXYE++yXG1S?=
 =?us-ascii?Q?DxuILKvu4OMPlRclXQ/dDGwp5gtr6gMdix0ESb2e5tfsHUTF8WKDFDnsNzGv?=
 =?us-ascii?Q?8abng8JwGJarRgKy42GbxDJLZ2CBYhgcFSPUzEKlUW4ZSGPTj1P9G9GWrC41?=
 =?us-ascii?Q?alDeXxqkiH8k32eKALzsExJj37/zmOj78ho+CrOlxCkXzx0cv8vEftlQHcQI?=
 =?us-ascii?Q?58/B2TtOWYr3iIdr3+rSwM/T/bEiynoLMtdEm1UdvSabyMecLKO8cexI9elH?=
 =?us-ascii?Q?zhbceRAmQZ2VE9WF2EnlPzYpt+CtJF1/IO1SK9P9EEgdd8m8wqPkpRTrbdsV?=
 =?us-ascii?Q?l+UBlV8z7Xlu5O+ax8oYDZviwJd7/ABrYWLe6XhRnSn8JUx0+Pp39ih4XL9l?=
 =?us-ascii?Q?5E1+ntDB0+IwGXf1PYbgJBUM2z8YQSN0lQnxlaignt0QIyf6hx/Wnjjqg2YI?=
 =?us-ascii?Q?kjSOLwI2/8pnQRfjQX6lVJWZl8EPBXon7W9RR4OEksycxVw2Kpoe5N7Fj06A?=
 =?us-ascii?Q?G3tv5Eyz0BSDDhzhKysA2GUXrxxXEEKro8lHpo9g2ebzgVD8yloHgltjQXcf?=
 =?us-ascii?Q?n9uyC5HOjaGv61wBENNzhNInulv7MNCpqiYfjqmLBP0q6FtbgS0dpkO2P40b?=
 =?us-ascii?Q?GbaiKFMJJ7sD1b5d0tJ8uvF3TOiMCfp/OCo+h9fOemae4eUq//gj/0mPOFjG?=
 =?us-ascii?Q?fvmVYjMQrLU/ut6e+KNqay4PWukNOCV0YtYxWvc2EOk+3d2o3nMONe6xt0dj?=
 =?us-ascii?Q?oq324BlF63OsqWt8neQDoJPxOe91tnM7Bvkfdtw+6CT8KwohjO3GaqHE6Xzs?=
 =?us-ascii?Q?Aaz7GoY/G3gX6qZiAfvgTCVpSQjEmpXs0RFWadrGPoTPlvecZZ+5lo4IMiwd?=
 =?us-ascii?Q?kPL+6Giasy6RnlmRK5De4t9An7EYcw+1XSeB7FgzFf5EKesv3ggcirjSOF4H?=
 =?us-ascii?Q?EOJE5sOsLi3fGrsVGL0Yhh3eKUSwaT9h3eom/KKgBgpRDYziSEDQLMea6VKh?=
 =?us-ascii?Q?ztFFgapKeWzVze/DULn2kYK9WniEA4HzUPQcus8AvTQXVtVH2WfjEK/q1ssd?=
 =?us-ascii?Q?ixMzyrUvIN07Oqs/6Uk7PHaFGc/paxkFRyJW1xkqyNB1iusMIyLaAmEQ0uEi?=
 =?us-ascii?Q?U1aqOBr9Ocfyuf+SYX3N9kPfa9Sn8OheQ2RfhdqiG0mZhUS7KWYrtgGqYJVN?=
 =?us-ascii?Q?Yw/cWVZN4C+fshm9l65IWvc/L5B19gGU7uiH6WI8Aehon35KbE/IUWahLSk1?=
 =?us-ascii?Q?t3VC01zQ245qVd3z48Yb9mf8iFCqo/fuFCKzl8h6QYVQHc0Ddpz3B3Ep1Gf1?=
 =?us-ascii?Q?4Nn9/7fxDSeM3LcmEIFcK+HdqexB56Hl+wahOfxq?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a075d289-a560-4e53-501d-08db9efd445a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2023 08:38:01.3265
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JZEGQlveilF2TdCI8SNKZP9+6GUDnhmWQcalSi1OTllZk1xyKNlyO3aLrt7lQBSyrBS6QVIkDtSujMMRipqcgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5789
X-OriginatorOrg: intel.com

> From: Yang Yingliang <yangyingliang@huawei.com>
> Sent: Wednesday, August 16, 2023 4:13 PM
>=20
> It should call platform_device_unregister() instead of
> platform_device_del() to unregister the device.
>=20
> Fixes: 23a1b46f15d5 ("iommufd/selftest: Make the mock iommu driver into a
> real driver")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
