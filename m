Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC4731E847
	for <iommu@lists.linux.dev>; Mon, 16 Mar 2026 07:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773646314; cv=fail; b=nDnuquAHKhMT6voLSoKXvfrwAM2D+rJPB6jd9jEONDFx8ywmI/RvdugIRbkHSlQ/z2NOJcv9zn9+h05Uyme8NoWJR7b5bAZ+OzyzfYjLHW5rDs++RbWCxsFHXfaSj42PgKndwHeSc8SXkWjapSbh1ew05Vnygxlpg5YzPBVFv+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773646314; c=relaxed/simple;
	bh=8N4NyrxcWfpiHHimNTTCpMhJgKSf3CInqN6lUZP7KRU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=epvVDxiYhwLTlDOQ2cYJZNBQmS1CunBDsh/1K3IDyU7SONl4X5QbmDyjUL//+qu6t8CI0RicMby/3qtEB4ohs8kXkhcwykX4GYCK8ZrMAPa+Z7j40vAZ2bYyKka3nwwvt+WAw7zXX8zP+uPtOktCDP3ySJRDRC68GT5r308UE6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AblaiGuv; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AblaiGuv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773646314; x=1805182314;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8N4NyrxcWfpiHHimNTTCpMhJgKSf3CInqN6lUZP7KRU=;
  b=AblaiGuv2BNgC4cFq6F3alRold+1B+5VYIxiBg1A/ib4ns9vrV1+j1Nn
   TiMq8noMXuJhpqRv6rVUBgfrZFwy5MRqW5a00axV3lw2fxxHihchcA8gq
   zNiQR/QS3eKOUDUfWJHThISm1IEOpi407LcZsukSMtgn8i7AJisy1NYBn
   0GmeEB4MNYnu6r9AP5W0pPcy+rB7/w0Z7BSweYFRM9DoeLStkgL2ifB4l
   044Jg6Sezs/zghqcsRKDn+NlaDXyPOgHbYNUAgjjWwzRW61V19gTlfozf
   MikGoDKeQSKUNmYkXkk6hNgNZSBUnuLAEkvgWZhjKzxcT5MxIZUAJYT1J
   g==;
X-CSE-ConnectionGUID: gVLuPnmsTrC9eTL3zwIsXw==
X-CSE-MsgGUID: 8mDl/XZuQlOd6uZZkvBH3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="74548465"
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; 
   d="scan'208";a="74548465"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 00:31:53 -0700
X-CSE-ConnectionGUID: izE50iUrS5CcisTT+vB+0w==
X-CSE-MsgGUID: KvhH4NRoTwmWYnsKQvSpmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; 
   d="scan'208";a="219428764"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 00:31:51 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 00:31:50 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 16 Mar 2026 00:31:50 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.39) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 00:31:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PDCxh+VL9bKB/r9UpkGcdom9+nIJaXqAUUc6QMhp/2jZxPLKXFSsWowxa3clIWzUEZugJ+rUN1K64xdj/8csf/6Cz0xhgS361GETGIJTwNCBo7DABfJsiHWAw6MwLx/MzgKISd572FpVX8Wd/C5SWYoDFOJWFQhIRpajJXjisqS0U+qFhHsKe51Ku6Vtr++AnVHKfRVhzJdo+Glg0LVm7qL36l0XVFRp8jp6APH4N0FW5eT0GkdxL4QIRqhC/gHy+N3Q6fc7qrlXKHxR6eK18imPTFDkP4hqxOqqaZXLOFPRAqwh34vsfpYMLgjV/uxUMJz5E79TBqBUK3OcJHB9UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8N4NyrxcWfpiHHimNTTCpMhJgKSf3CInqN6lUZP7KRU=;
 b=KUJKXYNQMMBAwp81Pxypq8GTgTz1UTJHdNr6Rt68JTg3mMB3vnYDfb+aIeFpVpioNiIQYBmHJK2HITB/QSmhvXph35W7xKMvPiP+JVhWxQXJVcGnGcobiYoZb4BFS/DFTelnZLNSkYf3U4VDUUYr+EAqvVWLzI9mLJb5VS6Vx+AmMC3KWRM3ALTdmfnsfsxMy8yCOXqFYjUZ2YoGygqeOIOfCE+ffc3uMYvF6wz6whdSoWMHlIV02H6rxWZkbH+8fcaQKxkJqRf5R/OEvIVhJldEPUhhynUMXH6c12wiR2vUf9xYG5yIlKyK9n/jQ4T7rZntjdcq60LFy8scHFzpCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH0PR11MB7447.namprd11.prod.outlook.com (2603:10b6:510:28b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.13; Mon, 16 Mar
 2026 07:31:46 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f%5]) with mapi id 15.20.9723.016; Mon, 16 Mar 2026
 07:31:46 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
CC: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, "Bjorn
 Helgaas" <helgaas@kernel.org>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, "Williams, Dan J" <dan.j.williams@intel.com>,
	Alexey Kardashevskiy <aik@amd.com>, Samuel Ortiz <sameo@rivosinc.com>, "Xu
 Yilun" <yilun.xu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, "Suzuki K
 Poulose" <Suzuki.Poulose@arm.com>, Steven Price <steven.price@arm.com>
Subject: RE: [PATCH v2 3/3] iommufd/vdevice: add TSM guest request ioctl
Thread-Topic: [PATCH v2 3/3] iommufd/vdevice: add TSM guest request ioctl
Thread-Index: AQHcr7Zg2nUMA9oep0Ot8T7R69iYtLWwzX1w
Date: Mon, 16 Mar 2026 07:31:46 +0000
Message-ID: <BN9PR11MB52763E9AF5B0634E75FA082A8C40A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20260309111704.2330479-1-aneesh.kumar@kernel.org>
 <20260309111704.2330479-4-aneesh.kumar@kernel.org>
In-Reply-To: <20260309111704.2330479-4-aneesh.kumar@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH0PR11MB7447:EE_
x-ms-office365-filtering-correlation-id: f5a0fd30-582b-4823-079e-08de832e1443
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: xR31XHS1tfKjPjCKkK0p9IGdT4t61RyqsxJ1wKs8BqweMqo4exEHkbMgb5VdtdKvI5we2VQHfckgOqnaCMnAweO7QEUkMu4nXj/rjiavOwk/JzPjgxkWvhiot1YlhgeW8N5vfYoS5ntL3MelSV6uIOX3rM+ZvAJ+AeP6i6zPxNT5NLRY7SW/frPv64M2kw4/hYWAOuClggAnwKjLmc92v2wiumHC0/sAA/IBwfcNIQtJTwHycMra9mV67FNkwwKS8z8y1fdjV5ewX5QqLLzW2aoCv+lftfvgQYqodibivtXNPzFKx7quupOakevVciiNEkFK1Tt3SyTDxbra0novJRIey060Ryd//an+1GZOwr6g+7oqo/pnt0XbFAyPgyfvJTSTj3Q0O772HCTvCWEj7cc6rymFxb/2LxMEsJTeHdZCV+3xi41O/4iE4CHFoxKlEwOP//ZTCDtVfgg4G75dbCO6fRINI7g6/NR8BsYjmzQTR/GAq1g5O0yQGQqN3v7j5gn8W4lc6y5KoTPbiYbt7dbUY/fFOdP3uXD+dMBkvT0s2TF1xanIO5j0tWGDUP2QzMVxznhrrQk6Q5O7hXDtXzoZR14JoRJQdup+co+krJppWPxz2Ayo40UpXn2VYVIsWOoY/TExyR5ud1B8CCUyhlsWUmxwn3bgyaLT/ay4ca/ZAjIT2NOX2CeRKgd89Wad1RxhXas3okyO2JpYgbrRxMibpQUiMr7p1oyO6KQ+HhizFozE58BxyrPr/JaRDgQjcFnqOnzESWn89WvrpOkoASAqVA3ANLEF2VNMGVmI4CI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?e6l0IDexROql7uNF6P9c6CRy2V/X4Y3AFAxOJikc7fNddA72wtheYiYrRiKA?=
 =?us-ascii?Q?J5kG7NdKnMM2s2+ObQ8UzJbR90eO5i0IBmZ4vk0mlnWqrMylFiKQ+XxJer/f?=
 =?us-ascii?Q?KXk4aO2abRnpAMzPGE7Fyegp5MmwMqclbsK8PLpZ1jqe79M3ujiSTHFKcSuk?=
 =?us-ascii?Q?DwGL0emHMGTwtR07vvWKLbfsDacklwuoohZVGitW30d/ndCUjhYGJMIMl4QM?=
 =?us-ascii?Q?Qd1C9JHVdTEIpgU+KeEEm5uPWMZ2mIxV3e9S0hmSV2HAs3F2N6SldiaKhE2u?=
 =?us-ascii?Q?0hya6nM0ZgP0IhZr2QIuyJ5NRzP68Zdu6nIbkeJK+jW1OpKDeEMG/ymiCvZH?=
 =?us-ascii?Q?cxCmhhL2un8ZguD3dLvHy1YURUgGMY78dHAP/L0be59ssh8MrTYtgbEyUf2w?=
 =?us-ascii?Q?iIy8ylvV9xOD9kkTQqqJcgsbjngN6H5bzqwTAPPFHmYDUGOWHFGoOoYitjz3?=
 =?us-ascii?Q?jtCdjER/DZ0pryU9mYLKiqyMagIYv8PvlmlgGhIivJqDWEqK858XtObszqYr?=
 =?us-ascii?Q?g1+eguQhQvNBim5xG19DSss3D/0bh5cm8Xk0OtNEaYScDHvlfeEwAQims/MK?=
 =?us-ascii?Q?rP4dwg7zdhcTk9c0OF6bIymYG6yx9AslGwz2/DrV086V48g1Bt/88cKPXthw?=
 =?us-ascii?Q?SpUNUov1PI4RGwK7lY26g5pTBTK3kw0bLsvxQRa/c3TLPnZ4SOXZHSosVNAQ?=
 =?us-ascii?Q?JEn+7j8rpJm5Rr2rKg6WnPHEyyFl9zg0TDRnVTcANvmmbvYlwUbgdp1vcpLh?=
 =?us-ascii?Q?k3VAqGl55KwHaXUsunW61e6F83YXMaWBR9O8ycPomT0O/cUvfdczUfJw2jYp?=
 =?us-ascii?Q?mWJOcvlJwoIGAAuMBvlabumo27Mmifuwh0WeD6es0usaImDV7yW+dt5lFXwS?=
 =?us-ascii?Q?z6ldIarSt6Yj5nm2xDfIXI0x1GXRE+wNaw+KcjxgQG6z2rHNkmNLV7FdSS6n?=
 =?us-ascii?Q?mDFhg7Hm3FDvaRfZg4C/bVUkU+PPuZDS3vqNZZ2R86/U1bRy1JTB14d8M0P4?=
 =?us-ascii?Q?C9R4gL8sxtONky75sgAY3dTa/veJoXvSqsQD1ryvhA9O7LN1TSzmyDImk2d2?=
 =?us-ascii?Q?4ddm9FhjJvOCAmsDGnAox9Myy382QAXWrR+PjV2JB4LdJSnpEi2uWSHkURy5?=
 =?us-ascii?Q?UNqIl11XzbZwgn5XHDoBnwToDB3KneGo49MbZjFQrYgR2AJiRP/Mq0Qqbmpm?=
 =?us-ascii?Q?SVvEH69hlGxqjMiNcpEwCt+rrByq/Jt1lczkLFOULrekK8J6iJOJy9XhVso/?=
 =?us-ascii?Q?zhRKU2n6LYau4HEmTa/lFmrznw+BWBe0rele3bP2nql58c8ta0Q864hv/XX2?=
 =?us-ascii?Q?5KLk5s985GyYIcUcnNVFQBPP4wCiZtq7YgjR21mPYCnrIuJsQKGrfKQS8pOe?=
 =?us-ascii?Q?ah3HJECun5zGIF01hhLBaI4MHEqHVwtcK4xoA43d5roDRQdtMrgRWqBr03Cw?=
 =?us-ascii?Q?lgYktjmapiVyGD6eTmOEvi7uqXvai2A8rHMlciyzR6zeGfC819XLAbf5vL+Q?=
 =?us-ascii?Q?9OcEJKVADqgNIMAlpR224B9RvOS88KbD2YRKEwsSqjKNY8q/1iElaUc4ZrQB?=
 =?us-ascii?Q?M85x/XKmSaKpUI5RLN+JXs2P4gTwh+oo9P6J3gjanHpvWzyQ/uVMvK7riNlh?=
 =?us-ascii?Q?r9kddHDBFM6IX7ZB03UBwnXdVXBevo28NY7W0x6+ghXh9WztaXrcMxQUYJoV?=
 =?us-ascii?Q?2go30xcN8n8s8KpxyHMhZLsyj/e18QtmZ0KO3oesob0Z6w/KBZ39hbhqjDoU?=
 =?us-ascii?Q?wUoSRwqAUw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: vq6497XKNhhNiVYI2ORvcWEKbwNVUI2H/8m5X3hbONQ185g/uSWwFRaoB9uLLWeEVPwkcH8h6jDQ+VfSesNyY2aXa+ocz6MGq+P6/twytd3qalPj6pKqOotNc3SCjfgcklYjpAyxDw8RvvCPTtWQb5Jvp6IdiMIT5b3+X3sQtoHF4G2WfEafY5iZVuuBEi4C0ehL+dFXuUSDh9Z+Xuz1rBAJwg99FMpd7qWuD+Rv1tqThKg2SX8lh3MZip3YYtr7rQ14vmQyCJSkg2dyxGEyRIBzG/p8lmK4i1TO/kXvJcGia/bMMjHDdfBO0UzxzvBK2v9lp0VuendNzM3iwdtf0g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5a0fd30-582b-4823-079e-08de832e1443
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2026 07:31:46.4336
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ubx+JOs1jvj8Y1JhYXzrQ7Xnr3dFK15WaJTJW1LtHYcGBKftBqOv4EGYlHRPP7HvAJlZcuMsnbnHReUcW9NX/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7447
X-OriginatorOrg: intel.com

> From: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> Sent: Monday, March 9, 2026 7:17 PM
>=20
> Add IOMMU_VDEVICE_TSM_GUEST_REQUEST for issuing TSM guest
> request/response
> transactions against an iommufd vdevice.

Does adding '_GUEST_' in the name give any meaningful context?
It's a transparent interface connecting to tsm. why do we care
whether this request actually comes from guest or from the VMM
itself? will there be a TSM_HOST_REQUEST in the future?

I know this has been made this way in many places in this path.
but from uapi p.o.v. let's stick to the minimal required naming.

>=20
> The ioctl takes a vdevice_id plus request/response user buffers and lengt=
h
> fields, and forwards the request through tsm_guest_req() to the PCI TSM
> backend. This provides the host-side passthrough path used by CoCo guests
> for TSM device attestation and acceptance flows after the device has been
> bound to TSM.

tsm cores use "TVM". let's be consistent here (regarding to 'CoCo guests')
