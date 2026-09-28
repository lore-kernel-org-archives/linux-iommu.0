Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1767D2FD1AA;
	Mon, 28 Sep 2026 03:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790566535; cv=fail; b=BZE/sMb9wYU9EXhNNLT2vVsAKn8c1bALMPnuyMrFEWZPieLBIK941YDRSjlEE1r1ARmOlCLzgnoTog+gB4wQDCBE0X9CZw0MJTkfdRWnGpA0Idp5FV25GTvfXHFqF3mgbp5dys5gTvY/2wN9jMCp8Ani2mADclzA8ar2GMNwbo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790566535; c=relaxed/simple;
	bh=+bUIqWCdCV0T2reY13LngZAa24DGM9A11VBs1LrdJOI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dfEtpzhmMqf9dhf4UECWT5VO/jpwRZuPdc+ukJwSGXG6cDj/+4Ms+ItwuQ+4QJ8SuV4PAPQ8kDJqoTnIEAEIbLE/HAPoD7XWKLprwMAYugd/EMPPFunw9I1ICkkoDEGQ6NJLk9NpEQN6RkJYi1c7jyHPFJd58MsNxkemEuDnVqo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O1SxIAd9; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O1SxIAd9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790566534; x=1822102534;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+bUIqWCdCV0T2reY13LngZAa24DGM9A11VBs1LrdJOI=;
  b=O1SxIAd9Dyh990wY4kTon7KGPB/Rq/UxvxMQch3h62W5PgK/ZXeaXcC8
   mmeaE6RtXwDE5IbLKSTO01hRls+b8TaV4rczdDi6A/wlrWJFl4343K+D7
   8IUOWZIrGBxWhO3HH5EFZ1VEJqCqU8lG4PsTB3PilTwia2OizCr+G0B4B
   968TEjDB2+JHTbFLeRK0OL8Q2i7mMpymUVH7X5o8hWauJE/1Ch0huglKs
   VkcIkrKEtniBCFmWk/t2prVQ09tb45+hSJrsEViio+zrdzJ1fzy+ZUFJK
   Uxki5ucYU8XUY+RtUJX51hWVv9J1+jn3yW8yo6OaklWeSCxC1g1jILHDM
   w==;
X-CSE-ConnectionGUID: xJSZxU+fQQqkgmphSyGoPQ==
X-CSE-MsgGUID: AmG+0BCpR52k9JOYLOYfaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="116787923"
X-IronPort-AV: E=Sophos;i="6.27,127,1787036400"; 
   d="scan'208";a="116787923"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2026 20:35:33 -0700
X-CSE-ConnectionGUID: Sn6x1mxySt+84vmcvsaVKg==
X-CSE-MsgGUID: pgH89x+8TUOuiBY+sOl1XQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,127,1787036400"; 
   d="scan'208";a="278278573"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2026 20:35:33 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sun, 27 Sep 2026 20:35:32 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Sun, 27 Sep 2026 20:35:32 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.9) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sun, 27 Sep 2026 20:35:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nqo5cW62ljVSuT6wZy3pb8RtdNA9lqhGsgDwNHMGShnfG8eHP9Z7v037jCVK2i1B7ASaUebbJCzFsPxG2hPryukgq3rPQpkf0I1VghXF1IhK2fMy+WyBpR3HrvW+eSnYe9W4JskFFR8Q+V1mDKZ3b3m9tyP7S8E/krSyINweQjg1Uqtp2Z6j/RIeZ6XW2u4Z7A246kLtorpUDZtLXSzyDjG+RalvwdxYDMQeheRO6PH2Dul+30xQ2nmHbxYzv2Sj/rI21+m7KkyIb92YdHZ85lqD97EZ5ldhbgi3drrU5JZJcoBw5iKDQBhvPUbZDmySz40upCxRNJ3T0IQvdWhe9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+bUIqWCdCV0T2reY13LngZAa24DGM9A11VBs1LrdJOI=;
 b=ViVgU0HjXjp+xEMD3wx3WrrCyMrzghnUotj/LF/qkDZwRp4Y03Z/kNmaiYlWJqCwbaE9RzCHOjITZRyy510bGSdMUB584M2oRvjk6QOw4slNdbJONtJTg8TJ7YAzEMie+6YgbAtj+MrkHyQf4Elfk5KnM/GfxEUny90LRac3nipow7o/oFGz7WTh2qwdQhPOc4xvZpsHcaOKB5aU5I4mntvGZtG1gWhO9stEs37RkTku59xm9s6reFNRMbi9zn5RAxTR2LMkFym5/cKN7sjXuN57V/hGNXKiLUQ5gVkMqjdCkjiSP4SmbkuLdGSHlgh3pY6Tp2mZE4Rv73q6g5E++A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA2PR11MB4844.namprd11.prod.outlook.com (2603:10b6:806:f9::6)
 by SJ5PPF4422C5374.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::824) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Mon, 28 Sep
 2026 03:35:29 +0000
Received: from SA2PR11MB4844.namprd11.prod.outlook.com
 ([fe80::61e5:7b38:b8a4:1abb]) by SA2PR11MB4844.namprd11.prod.outlook.com
 ([fe80::61e5:7b38:b8a4:1abb%4]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 03:35:29 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, Alexey Kardashevskiy
	<aik@amd.com>, Bjorn Helgaas <helgaas@kernel.org>, Joerg Roedel
	<joro@8bytes.org>, Jonathan Cameron <jic23@kernel.org>, Nicolin Chen
	<nicolinc@nvidia.com>, Samuel Ortiz <sameo@rivosinc.com>, Steven Price
	<steven.price@arm.com>, Suzuki K Poulose <Suzuki.Poulose@arm.com>, "Will
 Deacon" <will@kernel.org>, Xu Yilun <yilun.xu@linux.intel.com>, "Shameer
 Kolothum" <shameerali.kolothum.thodi@huawei.com>, Paolo Bonzini
	<pbonzini@redhat.com>
Subject: RE: [RFC PATCH v6 00/11] iommufd: Infrastructure for vIOMMU creation
 for confidential guests and guest TSM requests
Thread-Topic: [RFC PATCH v6 00/11] iommufd: Infrastructure for vIOMMU creation
 for confidential guests and guest TSM requests
Thread-Index: AQHdRq07BOB130WWqEurUaVXxg4wX7bdXiywgADIHACABT0D8A==
Date: Mon, 28 Sep 2026 03:35:29 +0000
Message-ID: <SA2PR11MB484477E4875E71E4C78854A18C8D2@SA2PR11MB4844.namprd11.prod.outlook.com>
References: <20260917140159.1163281-1-aneesh.kumar@kernel.org>
 <CO1PR11MB48358E3116CC6CF34E6437658C812@CO1PR11MB4835.namprd11.prod.outlook.com>
 <20260924192054.GA16465@ziepe.ca>
In-Reply-To: <20260924192054.GA16465@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA2PR11MB4844:EE_|SJ5PPF4422C5374:EE_
x-ms-office365-filtering-correlation-id: 47dc60b1-5875-413e-0908-08df1d118ae6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|23010399003|7416014|376014|1800799024|38070700021|4143699003|56012099006|11063799006|10067099003|18002099003|22082099003|6133799003|3023799007;
x-microsoft-antispam-message-info: oDP1Vpck9eAwcszCwfIGWwasY/xaCblyFT6JoS+CqHrhSzO4vziqF515xCmhw2z7uCB1uojaJS6MSRleWynqsQNn7zbJ4VKieqCHDXg15ZGRiTYilzh8P8w8fGeo1ALPn2H6iKRoBdJjFvUSZ8eU2H5KI98WD+ZbdobyGkizn0y5G4bCQQ2Ufd3R1/t06lkXRKV0COgkEYvXTXvjT3V4XcuJ5FZi3EcBUZsvtz9+UJE9h+/wB77yGgRLyOil70ZZabWpUTlExSwRZ4w1dCZ4+VRZMc7xedSsVA7Nr2PURQHM57/xuxoWyAWXXoJni7FUjtFZMmVWYtr7IxrMRZWpVJtAjBa5ZZbUEBdh4ibEPqFyH+6aIVQa6yuO662OOpqHoqFyYf0O8zAiEr4uPxIG2DJ5lqLZ1KBq7SvRXsAFsrWK1ZoYXFD+LS3b+oxuBhIIQ8XDZa7DgAQSXjihubD/xNKRCihW1Zequ2m/yRFykrbOx/hbyIJGHpp/xwyivfcCpmiyRHxFM0ixbSi3HsXfJNkB98dc/TqMnLqrpA+Vj4lfQPU61qoYxZGuYcGsa7P+UOAerEwqsmkHt6LriZimXItB21okaOy0mZQfuvCDDoETNz+N8qb3w4/ALCTRDHdvAOh+vQ1B/yUE++bA5JnWOyxjLC/MAxVW2fW8HT1qcHWh8+KeWMMg5DY2oT9jYVmheiaqHcjGxRn9Okjq6GZRW4Ibok9rLaT+s/LnzMnXd+s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4844.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(38070700021)(4143699003)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sZJX5qhebjiNzuwOAiS49snc10/e60MfO4p/g78lfQToDy54czi/o9dJqRuZ?=
 =?us-ascii?Q?PRBWqFjdjuETCNBCP8TVwkHrkVG2nWzFL9mDRXg6Yzge+1Oy9TwL4/Kun+HR?=
 =?us-ascii?Q?6jYVeoWT0ZRQ8qjO4dxPErA2vxvZuZN/RulohnZWDA5X4bWP6S+6X+lUpbAb?=
 =?us-ascii?Q?WF4NJiWnMChbtSGK1aIKg3DkQGERQ0/H1Nz0dEM5IcGBMONm82Q62SQnpwre?=
 =?us-ascii?Q?JM6R52FBsNPMOHl0ngc7p6SE6/duMofvoL/xZ0Ynk//1l/xyUx7nWBA4N6Ob?=
 =?us-ascii?Q?jw3KtRdNY8WACT5nGUw6NN6ZLiyH+Wx971094RGN138m6PECSVXZIYkr7SPz?=
 =?us-ascii?Q?KBUCEHZtk7MshcSn5xNwXh2EO3DlROTXc0GB57wSZswZmBHraOxC/I0s80XQ?=
 =?us-ascii?Q?tNo1yym4rtXLQyu4rmFcib4u8KKy09Jlw3ECSgtraF29+epVDFNgBnW7e+1c?=
 =?us-ascii?Q?GY5YZidgOYyVyMpFqoc0Wmeze3hUtuBXSGvnFmj5Rqr92L/J1JMcVSE8R0DU?=
 =?us-ascii?Q?6VO0+sQhq1o0YEnRrrj5RlKTmpKf/83/i3BaRlm9aZV4mdtNgbGr0tPY/aVF?=
 =?us-ascii?Q?uD6ZT+Aj/8bql9orPbq44qRO0fCMqheFQ7IMH/9aaLHBUgI+0tV5ME2XFEiu?=
 =?us-ascii?Q?2/YZRjtNLpdPWomkr5r9JGfvFkwpweDkQNw7+ubk2yNFVfH7MnqJVLqapN0Z?=
 =?us-ascii?Q?dLdhcbd3PX4MfB5xC2E+S1zTenf0hakXEx5z9WjrJm5So63i6sIzMO11wmaI?=
 =?us-ascii?Q?j3ygCd29M/zcyurFPOUFzEqhHRw1HYIQT0X71a6dJnqq8KSH+TYt6WaRx/aG?=
 =?us-ascii?Q?MRmoEYdV/f+VdQb1MkKt8wIDSPS2wd8GSwzvBZsECge/Pnsy2xlP0u2Knwk/?=
 =?us-ascii?Q?nzfM/ljfQIOw7lEYpEhDlaX9qMcMMeSXsryloK5UA1/0eUaK58ErqOsPwASX?=
 =?us-ascii?Q?6FzfJFx+wvT+0yVFQ+s31qoUOcpAtudsZ4NP0Hl7ARK1ouXYNdun1Wdr9Kre?=
 =?us-ascii?Q?R26szM8MpGRqit3TabFcNmbgIRoqRbcFDHQ2yTD696iDAdatKrHIIHW+LKch?=
 =?us-ascii?Q?OfJLdAOzuH80IHmJHORpxFIjqSHyhC55E7IGFoIrnRWoXg2w26HjmHM9epwb?=
 =?us-ascii?Q?Mug+vdTH+nkhCJX1+m6lAIuTEsJ0VkAPjUxr590StaEHmjWZLZ9nISe/0jNO?=
 =?us-ascii?Q?o1ZMkUt0KO2tYI5KVMDLvlhtLV9XYR/hRlsB+4j4f0A/icDIInSLsQNr3NHQ?=
 =?us-ascii?Q?8nznp12s+68gHwFRyWQiURPYgq1NqZZWQdQ52QBbjlIe0C8I4iXQtIo0RXlN?=
 =?us-ascii?Q?gd+8Tv4Tpk5AYXPpn2F8sblEyrqrLEyp4vDnn5prrJQyEybqGL9o7UwoA7Ej?=
 =?us-ascii?Q?L0EWnVC4k1zNUKPT71cOOhMGBPexsmQgP/6yiU/VRc2NDjYGYqKP6e0HeIm2?=
 =?us-ascii?Q?B3pOQxrD/W7hbzVqE8h4ij4Ml2X7m+1hR/5i8T/5gHuBuz/M8t7WagYEOvQr?=
 =?us-ascii?Q?TxGKO5W2xfsW7BvKHZwmRmdw4r7yoRUuLR6S8FY3DT/cABscVBjV5vuJ+VZE?=
 =?us-ascii?Q?CBydFN1Fmado+BCv5aJ8a8Z+Yfesq/aDJ7E4ng/PnYOYnlQrh4tA9NRT7dQO?=
 =?us-ascii?Q?JRb8a3G7P9UlPWpcV3smU82xyjcAt882mt8221eW40ce40k8F32dMTlM64NG?=
 =?us-ascii?Q?zzvitOwsmwF+lmppDGSMxjgM5lSaBdFT9C/wfnDKBBpodUnuif2EPb7ua0IU?=
 =?us-ascii?Q?PVNvvL2gaQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: PF+8taKlq/z7xcMdSZe5XlemJTHG3NmNvZFzrncJ8rY+ytntX9nX0JJ7CI9ZV+957z4XpQiCkblST9XZYCeQOz0nhhCBzXFcobF/OIuiITdsDECLBJmYpiUNXr5x4kTtUmeLFhBKHYwjNxaCnOkm61fr4TfPtdekGJaAQ2vmGAaUvlXu1gwsSy/0j+3wTZVbwuw8rZrUCe2pEBYO0WBW1YlwCIz3zRxz1GfTLAVxoZjj/oikc303gfiyorjNA/ndK4QcGwvIKIqLdCXbRjWrebPz2FBSJFK+3SoHI1GaKo+FMBWrv4EN+Q+7f6sVHuFcxazrproy63dwH6P3ZjsAFQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4844.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47dc60b1-5875-413e-0908-08df1d118ae6
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2026 03:35:29.1759
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UM7XjMOBRvKje+ec2l2eU2YeEtPTmBmN/XlX1m50AQCjJJ0PQUT2nq8gLIVoYAVruTLCTf49VAGtPZ/uj0dG7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF4422C5374
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@ziepe.ca>
> Sent: Friday, September 25, 2026 3:21 AM
>=20
> On Thu, Sep 24, 2026 at 07:48:08AM +0000, Tian, Kevin wrote:
> > > From: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> > > Sent: Thursday, September 17, 2026 10:02 PM
> > >
> > > This series adds the IOMMUFD and PCI/TSM infrastructure required for
> device
> > > assignment. It introduces an IOMMUFD-owned vIOMMU provider registry
> and
> > > the
> > > IOMMU_VDEVICE_TSM_REQ ioctl.
> > >
> > > The series adds a vIOMMU provider abstraction that allows a subsystem
> > > other than the physical IOMMU driver to implement a vIOMMU type. It
> groups
> > > the vIOMMU operations with their module owner and private data, and
> makes
> > > that implementation discoverable during vIOMMU allocation.
> > >
> > > External providers are selected by exact vIOMMU type. When no provide=
r
> > > matches, vIOMMU creation falls back to the physical IOMMU driver. Onc=
e a
> > > provider matches, its result is authoritative and failures do not tri=
gger
> > > fallback.
> > >
> >
> > I wonder whether this abstraction is necessary.
>=20
> The main purpose and point would be to keep the TSM code in TSM and
> out of iommu drivers.
>=20
> And we don't want a module dependency from iommu -> tsm either..

Yes, but the reverse should be OK (as you also replied to patch6).

>=20
> > The underlying IOMMU driver still needs to understand this vIOMMU type
> > to check vendor-specific compatibility and provide the relevant hardwar=
e
> > parameters.
>=20
> It shouldn't, if the user requestes a TSM iommu type that should go
> directly to the TSM driver, and the TSM driver should involve its
> physical iommu as necessary.

I was talking about what this abstraction provides. The validate/
get_param() callbacks implies that the related knowledge is kept
in the iommu driver, but I agree that they should be put in the TSM
driver directly.

>=20
> > There may also be further vendor-specific interactions between
> > the IOMMU and TSM drivers.
>=20
> This is the big question - how big is the entanglement. ARM's is
> small. What is Intel like?
>=20
> If Intel and ARM are small, and they should be because the T=3D1 VIOMMU
> is entirely handled by TDX/RMM for security, then I feel this is the
> right way for them. It keeps the code nicely isolated with only a tiny
> bridge.

there are more interactions in the TDX side, but all from the TSM
driver to the IOMMU driver from what I checked now, e.g. about
DID reservation at the initialization phase.=20

Looks there are some resource shared between the untrust and
trust invalidation paths, as iommu->qi->q_lock is also acquired
in the trust path. I still need to understand the motivation behind,
but this can be resolved properly by exporting a helper to the
TSM driver even if it's truly required.

There may be more... I'll try to figure them out. Likely there
wouldn't be a requirement leading to the dependency from IOMMU
to TSM.

>=20
> AMD is probably not like that.
>=20
> > In that case, the abstraction risks becoming little more than a
> > connection between two vendor-specific drivers, while making it
> > harder to maintain a clear scope for its operations.
>=20
> Glancing through these patches I think the abstraction may be too big,
> really the point is to allow TSM to create a viommu, I'm a little
> confused why there is so much stuff here.

that's my feeling too.
