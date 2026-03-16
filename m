Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A259134DB7B
	for <iommu@lists.linux.dev>; Mon, 16 Mar 2026 07:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773646097; cv=fail; b=Uu43dM2s3y0nhtkxvePBcRIi3igpIFjYzRPKFKqia1H/zAP30Adsr+J6xAD7tU2cbf4OgSVgpA+aPVd4Yw5Ez9ZqjM/K9TzzQZ4fuxAksWhPa0MgLH5lu9044PgpZOi5SscXQpuetzKTczabylGAUYh/eZ0eWQrOJsxkLtFBm7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773646097; c=relaxed/simple;
	bh=WvALz34KVP0H0RzfC2niyMWUfsNJeyFSnW73E0ZLc98=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ECAEMyjgWlxNhCJKgnhPtaUzhBI5rpQn/whpKC6oenzRYSBlPf6lpwo9SHqPOkfFhyzDTLZXL/BObIdAqTnAV2j8af7UIGqpex+pXRVkKV63IDkecuL9SdpET2ryQF2MQomVtR2v7bW86tLZ/A6Hgm2PFjxaQ9apedxhvSGUPUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kJ4tBu39; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kJ4tBu39"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773646096; x=1805182096;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WvALz34KVP0H0RzfC2niyMWUfsNJeyFSnW73E0ZLc98=;
  b=kJ4tBu39aTgp1gsEK7oTUYfTuxBIBcnx18o+WCZE3jIk/vBFzV2VVkwW
   R5Zv8en+fuxoMOSMl8jlHE2z5IhBdwqJVBNw5VFzdf5a7jK8z9eCm6QOD
   cv8sn1xBvLeH9I12/DLpJEwSdgdUE5ZvA/gyl5d2j5iJ+Rx0DydqX242a
   iPVzU5T3PhRB4KiEwm/YiugcTuIqrhlUde668kfIyRULwEiShEhyw+ay0
   mEMX2R7epBe0U8i7fd2CN5T5lQgVn+B3pgn/iCFLZh3nl2t5yHUjtGmXg
   svV0y9xFtmLbPJa+nURg4S9CTRMuzA8z9osKla7jUShKazh6WaRC0sOZc
   Q==;
X-CSE-ConnectionGUID: ijynejeHQnWSh8AjKX+w0Q==
X-CSE-MsgGUID: IiMGRUfVTCCKXWn8nCfCiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="74629382"
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; 
   d="scan'208";a="74629382"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 00:28:16 -0700
X-CSE-ConnectionGUID: EmArTp5oRvim49SosGhpUw==
X-CSE-MsgGUID: KbIhe1SbR1SBQiavo9t5cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; 
   d="scan'208";a="217686126"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 00:28:15 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 00:28:14 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 16 Mar 2026 00:28:14 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.30) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 00:28:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dvT1/HzkV1tvYZj0aHvASteScnMLXVzxU0skW+3SM9aGZ5/tOaNVYSk25Wjull7S1WnrNsBm/JHFr20r8INgIFE2FF07zMEzPx5faASofcRAQ9jU7TLVCxmqyVJKI5Gixwr0VGEtwg92sjxa1Ci+zOOXIL782mIjAwF59lbQWjq7DoJha4bW6ritsOXDpTT1RDV4FcngrbstpLq6cRrVcM2NbKiTZIVSBD9SzJ19PNXL579e/AshiZHJxFwgZn5FI0LIFjFa6x+cXFbDmkN0XdiVgRpwrYS9r+/sDPwiOhxcVE47alTVynir5c4kDx+UQtPo9hX4wFKPn8uvZdoMrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uGYScoRB3in5nCLEnRPSNgnmsI+y50o6xTRwFnLjueA=;
 b=Ksn4/vb3MX+sj2OLB9oEKDQ22yL5VnNYueD70QwymVLcBZ6Qe5zP/HoK1xa+kiYkVxinw92l3MvCv9u9DbuW+pStY02yFKSIm0T0y92jhe0XRVoZx/t3IgZgO78GipkP3PLARRomyAGo8XZWdlvWXM52/2RydlJSBs5WbRSJhNacF6DY6qqucltfcdEWMpBerts6aUGRyUy9wfJC/Kwq9qEyuUn4ybcQFFboLBB4HqIjxR2mBvAD70g2jfnnx9k12XLRSZjTzZd3e1UnZamH7kShmRl1axIuR5aA1yklflx9z3r0q0192iVuDDYkdR+PYOYslrnZyHwKXRFcmsbW6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH0PR11MB7447.namprd11.prod.outlook.com (2603:10b6:510:28b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.13; Mon, 16 Mar
 2026 07:28:12 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f%5]) with mapi id 15.20.9723.016; Mon, 16 Mar 2026
 07:28:11 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Aneesh Kumar K.V <aneesh.kumar@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, "Williams, Dan J"
	<dan.j.williams@intel.com>, Alexey Kardashevskiy <aik@amd.com>, Samuel Ortiz
	<sameo@rivosinc.com>, Xu Yilun <yilun.xu@linux.intel.com>, Suzuki K Poulose
	<Suzuki.Poulose@arm.com>, Steven Price <steven.price@arm.com>
Subject: RE: [PATCH v2 3/3] iommufd/vdevice: add TSM guest request ioctl
Thread-Topic: [PATCH v2 3/3] iommufd/vdevice: add TSM guest request ioctl
Thread-Index: AQHcr7Zg2nUMA9oep0Ot8T7R69iYtLWs1POAgAPcaYCAABtVUA==
Date: Mon, 16 Mar 2026 07:28:11 +0000
Message-ID: <BN9PR11MB5276CDFAE7606A066DB25FAD8C40A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20260309111704.2330479-1-aneesh.kumar@kernel.org>
 <20260309111704.2330479-4-aneesh.kumar@kernel.org>
 <20260313184957.GP1704121@ziepe.ca> <yq5a4img8gw6.fsf@kernel.org>
In-Reply-To: <yq5a4img8gw6.fsf@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH0PR11MB7447:EE_
x-ms-office365-filtering-correlation-id: 348c9740-40fe-4401-fd71-08de832d9458
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: WBCTlx7hWwDvrrVBXSlxRjNrOXhTcH6+XIOHdqbrpsARslaGR6d1Jhg6TT1EiJakLCvm5EvmEY9YZD6zu7zMFqADkaS11q9C269aszLv86eBsO+mGkgyH9zqzQnW6Qt8e+Lku1G4su+aNOT/RTUV0k5ezCxfqnIDvwORp83DpnHV7eDYaf9xli206W88zoNF2ph4Kqv/c1xWXPKAqhhNFb5zLmGWrzGNAbsepiI00d0tWBxxS0Kp+P5yC0jjUOzBQ64Wemdsf4izKjKhicg8wngBa7+hJEuLD4AAocOwhCETCRNyHrs3dBn7qPGcGoe5g6NmdtRsCjjfzMuh4rihMWrJPse1adZqbCd5f2BE0Rb+mXriiRODncv/ovYPHb1aNF3IP3IMJI9EBUr+V0claElnwuW0eJywPuyxyRJv/k5GBDwdsNHLe2VgmIEgBhSklD4IdwMyKw3QTl2SNYLkBMXOYayijO9u7cZ68jGGCKRy+/C9lHoKo4Z/b/AxVrpfdgvWQf8Wsk8KFpjlQ1tIomq4c6IA9mrbynE6dyT+/hfFUGfGObDTefPYxcDyhtya+AernHnU1tbU55unme1QcrEdYL1LCeO9TY8V2MwH5yGWxz9rnU299psVuNg6jMYY5BUJmc1RSa6qnE6eoWy6RXsJosmOsKA7yL18qSDLmAF17KzIsDQNMbhd1A6Pk6TWe4NfhfSaVoH/WLXAxUxdzYtL0EtyJk1qQftKcBOANEl+5yr97VXi9TZ4RdEIrmNteEYVQBoE2Dzm9GiD8xvJvuQbJfhHpKzh6sKa5V0/9A8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Fqt9Vvzty8IqcFLcik5CJZJ+ZTBipJA9+OeIXiwXGh4PCcaXoCwX/otHwxbb?=
 =?us-ascii?Q?yxeOV5AAmszHyv0mV4P8wEvT5etuDqmUtYYin46nxHEel1g8/5swr+7knpeq?=
 =?us-ascii?Q?fBGcn9Qos/Q+yqTDS5upM65ow738pNi8sus/5DYwTzSKsFvhwRKnJunmyCLO?=
 =?us-ascii?Q?HghFLULkXMz5bXh+wMk/uq7ME0cJqGlvbAeFSe4pZWEIuxCz2tNJBPTewYW5?=
 =?us-ascii?Q?U6PjTB+vzsH9bKGaS8yeAuESUQ2W3SBn/AvQm9JClLRNr43Eplae0WmooKNq?=
 =?us-ascii?Q?LmRIYF+E889mPAKYBxJajVtbzDSkp/sbX+xpVq+w1XhSWIkTCtgstT+lD6PG?=
 =?us-ascii?Q?4cBYAVLS+0Kxv6A9vBJevM1pnkshSgF0iyikghUZ/TadDbZQ+hxJZih8WrqV?=
 =?us-ascii?Q?F/irgHXZZDdlmqSx6wki6K3FcpzWYmz0UlSa1fStYBloMI9QaaCuEytVMgay?=
 =?us-ascii?Q?IAQID6tN8Bjrj6MlkL+sarVtN5HeLq8TA2GeruHRdwNVbq/5Xrz638ufxiAg?=
 =?us-ascii?Q?ijhaLyO+/obW8fcGN9pWmUd7IX6EVCNW4QGE0V7bnHurCtBzPrNYmkqTUacn?=
 =?us-ascii?Q?8yRV8dT0HxCfO5quiJLfSIHEkwAPCylpmuMG/cPz/l420Pm9tG+n10JLGn2R?=
 =?us-ascii?Q?H4Ixp9fKRy/07iAUjOTN661gYLc7m8FCDIkb23ieKiRGTswrmYVDsdk5nnPm?=
 =?us-ascii?Q?wX1BPQd7b179Z3JeDBKJL76jueI3jt/vgR2pXnv1MVT1dNyWFr6s8rRkKOPH?=
 =?us-ascii?Q?qjWtDy7dKqI0VhwOmGumNuDn2ya9sPby2Ch0wyWUD+kjzwGvlh95AW09rSpU?=
 =?us-ascii?Q?MiGydpNjmMaagkk6QE2kQB8MJMaTtShGxCxgeDbUmG+7IVF+Ig9CtRhWJh/a?=
 =?us-ascii?Q?D6soFkhPNhsxhVcBT15ARvYqaSsHMmqsggSNf8S8yyB4fVI2AkP9RWmA4a9G?=
 =?us-ascii?Q?0hoS6d/dzWZyBCEs3RscYw2fX92AGRDGtu6l3k39v9acJr6cPClROwfSkI99?=
 =?us-ascii?Q?6wKItWkaGMEiXd8xAE3uM4rqng71UhklxMLNDDg/Fg3kUTNIYb3kbo2CG7lG?=
 =?us-ascii?Q?SFdrikrOzC4Ft+b1vXJa6I9NOH2qUHSbMDotf41wAgvugdIzc0ibHpynMXDs?=
 =?us-ascii?Q?1oHRYHh4lzHwDQZTm7ukY62Vde6NL0WrbCDCIty10IGM2pJoxKtpsj1pxPy4?=
 =?us-ascii?Q?WBq0p+RqQbSKjX+eYG/NqHkmvVj1SRwPccZFLLvEUokk94wssj8ESZOisfWV?=
 =?us-ascii?Q?y/z1C6NQFE4x1Ia5uFZ+uDYe3BBuPz0t6e03xtsQ+QAOYxc7HVNGv3P8bn+a?=
 =?us-ascii?Q?GNBJTz95EI87moCzKyAVDWdaO5mXcIg8BFV7XiIXlTwyqgJnXfny3PAxkpdz?=
 =?us-ascii?Q?HFq/p4rXtJ1gpJjjOX+krmKYQp1Aqzx+xOjpQee0nBcDJZxIycBbCRgCRNhw?=
 =?us-ascii?Q?xjKnXqUQPeUc8eqGqioqNdKgoKrWuR2TVYsRD3MEg1Iv37nbWQC33ZbRRJ8h?=
 =?us-ascii?Q?jDdWqifNYFiDG650U7ytv2+5AueFNTzkGhop4Dd7P17RN0gSAuPmsK71nFOO?=
 =?us-ascii?Q?wNrr0IB/XzV7iQ1TDPQFQGCt2/Xnp0xdYackDHy92RxBMB6vz8PueNBb8f9h?=
 =?us-ascii?Q?CabbmBqewpWKHXw0x3IHjOCFUsWuJAuecYSr/dD9h+jscMq+jn7OPSr/0vyE?=
 =?us-ascii?Q?GezfdipWNDu2xno2oLjrdlncq/UkAXKKtMMMUkFqxTdJ+3Cn5rPAhTJEejXP?=
 =?us-ascii?Q?LqgzfPly8Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: efTkpOKA5Z5tiMriS1g8jdOTeMFu7tqjIfLmSoD4QNNcZyFSUNMRX/mm9oYIdW/oGoqO2F2hHknR4YsFpkpRKWrn8YHn7APkGaFfqz/DQz1BnMPdE92Tigvy13o0nGLjsxMNbbG9cW7vSk9D2rZ5DhKvWGuYfUTDQ/WKJAAq8iwEfTKCJmIOkJp29bclkK18Uz9JXPz68gUnixAaYC/k9e7CmPfEoeXoidJKRhSuPXKLex3yO9t/KqRzQTE0JRHxCXITC/AUta5xnnminb21b7kVGgXQStHyxWMRUvLzTsygiQfA+nxJ9n4rJQqMC8Qc0WoY6FER1ssf2OLkqb0EvQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 348c9740-40fe-4401-fd71-08de832d9458
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2026 07:28:11.8682
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jVWxImCIxJfoLPDznHwNNJzFlYeWLH9o63bUDRGA465NQIlfMv6NJJzyzCrkZ3ghr0MxXapAXjM1nX4MFDbYtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7447
X-OriginatorOrg: intel.com

> From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
> Sent: Monday, March 16, 2026 1:48 PM
> + * @scope: Scope classification of the guest request, one of enum
> + *         pci_tsm_req_scope values accepted by pci_tsm_guest_req()

from what this patch does the tsm core supports device types other
than PCI (though currently only PCI is supported).

suppose there may be other bus-specific scope values accepted?

if yes here better say that for the meaning of scope values please
refer to bus specific tsm definitions. Then in the following detailed
description take PCI as an example referring to pci_tsm_req_scope.=20
