Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C87435E1A3;
	Thu, 24 Sep 2026 08:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790237001; cv=fail; b=CJScyZS/PEBcClJ8PRC6xTkDBMGOBaxahSxjOcja+xpF5ZrRhw9TL4U786NGwm8PKSohTOjtzgvtrKNz6SW9+8kVMsC3BZhqnlhT6Ty20Cpud4o5FadVF0of12cg3OBk4siHjD8e3xeiwcbB3tOgXh/nxl2yV6+ighVjz81iOiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790237001; c=relaxed/simple;
	bh=K5XFkHt83EzR4ZYFSBk9N5xlGyekIASmVBsBY7eupWs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=luz9oSbgY/UvyfK/u89NXJlzPwmQfRQVG1lEkm1c/gx63/fAf4U8SsQY1BvBmAUJtcuaOCxDIEFa8HtlfsVGgVgpagDUwOhSvIZoyHRlgDRJCET3D6u7UphdHjV1KDxzbLF6+W6CjFC6ODtfXm42CSy2HXJZ+LUwcqY3aB8rxlg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QipYZuJz; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QipYZuJz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790236999; x=1821772999;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=K5XFkHt83EzR4ZYFSBk9N5xlGyekIASmVBsBY7eupWs=;
  b=QipYZuJzHpUxJsOldWmiKE7yHEW41lj+DRbspyfu4L37xJdR2VSdAodn
   Pair1YtYqhCcXUvZunNruXAAYS6jRZtCjwDci2d5GN56PZyFugOEhYIz9
   uZ2NmngcW7WFZNszUrW38THUG9OjFOEPFVMUn+zaYMHvNnFSdRQ/jeyNJ
   lW55fGISb0mutNkflaltvzuEbwHFeonFzX28goE37Zjc3kPFkcKTCm4PR
   kqZtF12ape8jb5TKYNSDPv6EyfzVYmAW1fuV+cuIHTqTQOtSNma7jhs3x
   FswnF+FtJA4+t907EKEfSMaYM91FePJi9P7rDBoGesJ63ccwthuYBNEC9
   g==;
X-CSE-ConnectionGUID: U4X6XBsMRSedpyjBgVU+mA==
X-CSE-MsgGUID: porc/LwITuGLYbsD7Eli7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="102358793"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="102358793"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 01:03:17 -0700
X-CSE-ConnectionGUID: VoygboKSSgW3wo46UyXSkw==
X-CSE-MsgGUID: Vnxyl+HnQimE8cLVfUmuBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="274150549"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 01:03:17 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 24 Sep 2026 01:03:17 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 24 Sep 2026 01:03:17 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.41) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 24 Sep 2026 01:03:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aQHM18yB8W8sWKv5hkRuS4WfmYFad6bCO39qzjQ4pYiEaHQoL8HCXyZ9oJtzL0CDNA1NJmOXidoggl8caB2v3TcRNHNfcn72uFkD/jabbzhgrD3flL+0o5W5YIAzguoj4F7z2T8DCX6Mnb/cy3xLEJg2AM/XXhX6lg2s/2ESSJmQ8uXj4TVqFxYcwTv+wkTfOgbqdZbsmSmV1GS8rUl7VTt3Se4KQsWCaQTwqY9SxQ53htbNZLqxzKctV0Y9C6AkjAhObDb2ci+277/UBlnqc+DTNTgbkefaerEcAzruK1nt1CqX9v4RJrFiDPBWpiX1oP3Z9LPs7qrwgBM9VT7TJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K5XFkHt83EzR4ZYFSBk9N5xlGyekIASmVBsBY7eupWs=;
 b=NBW7sPrmwppu1ziSNEKXsqvObF0v1OjrLn4oWmov3FU1HdYWhY5McB7Aff4fwTmeoqGYJankTVP8FUMSDjlP5YSjUokHjeKErHh6JzOa3O0hZK7oVvbyhVR9eI6qoTzjcXDZ8X1Ps5Wr5CRW9DIWy8ZTGawuHvLCsgp9p5bIXRacLZYhMgMtiDLlPaV0UFfgIdz2BUPWztB5uaqAI7112dsjVkeIMx+TcgO4t+TSqTXdc4EWJvmkFLbfvexlSp/OVw+tYOp8RnZXuXG3Ab4h9dvW9NapfGk9Y8H4D0YfD/8ZZ3Uzws6JGUHiVsUvSs2ULKiLz9C31B0Ibjz45CPsFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB4835.namprd11.prod.outlook.com (2603:10b6:303:9e::22)
 by DS0PR11MB6350.namprd11.prod.outlook.com (2603:10b6:8:cd::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.22; Thu, 24 Sep 2026 07:48:09 +0000
Received: from CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225]) by CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225%4]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 07:48:09 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
CC: Jason Gunthorpe <jgg@ziepe.ca>, Alexey Kardashevskiy <aik@amd.com>, "Bjorn
 Helgaas" <helgaas@kernel.org>, Joerg Roedel <joro@8bytes.org>, "Jonathan
 Cameron" <jic23@kernel.org>, Nicolin Chen <nicolinc@nvidia.com>, Samuel Ortiz
	<sameo@rivosinc.com>, Steven Price <steven.price@arm.com>, Suzuki K Poulose
	<Suzuki.Poulose@arm.com>, Will Deacon <will@kernel.org>, Xu Yilun
	<yilun.xu@linux.intel.com>, Shameer Kolothum
	<shameerali.kolothum.thodi@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: RE: [RFC PATCH v6 00/11] iommufd: Infrastructure for vIOMMU creation
 for confidential guests and guest TSM requests
Thread-Topic: [RFC PATCH v6 00/11] iommufd: Infrastructure for vIOMMU creation
 for confidential guests and guest TSM requests
Thread-Index: AQHdRq07BOB130WWqEurUaVXxg4wX7bdXiyw
Date: Thu, 24 Sep 2026 07:48:08 +0000
Message-ID: <CO1PR11MB48358E3116CC6CF34E6437658C812@CO1PR11MB4835.namprd11.prod.outlook.com>
References: <20260917140159.1163281-1-aneesh.kumar@kernel.org>
In-Reply-To: <20260917140159.1163281-1-aneesh.kumar@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4835:EE_|DS0PR11MB6350:EE_
x-ms-office365-filtering-correlation-id: 64108e88-5052-4ea5-9a32-08df1a102d3a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|366016|376014|7416014|1800799024|38070700021|3023799007|6133799003|10067099003|56012099006|22082099003|18002099003|11063799006;
x-microsoft-antispam-message-info: J81Bzswj4f34Gn4iV9jcizzdQads6LXmhGyh5Jwkb7xWbBfbT1q9eke87o1jTXxhc2X3zX6TgafYNUC7QhYDlXB6LCSlO3qluWutM6lBhhS5RrBDttENlDcBqRBJsudkbucjoQi6I+RMEAvrKqz+sXBczXGaqubNffufISqryvvvJ0E4u8uh4dWnOVA5ulzsPxX4TqWBcOVibiaNRrf2MqYgOsdBGB5qSg7lelQHkEj1duAtgPLow9Ju7cA65Fh3vaYoNUsImzqI/VKWzfvhRIwKEegn1zo/4ftGbx/CuOGjZjw804zraaae6lLBhU61K30RXenrY2Aq7GEGpqRMAM3ShjqqZDGLoahIONqr4snn54CVLcF29DrCr4eYI3AMBEsm5NgTqp0MTgetBCGy4mOVFvhImSKoecLJQKGDBDg/XZ7yNLM09LDBJc2Vt2LxknQ5mNBIy2PKgwr+8uL7xCUoAD24kDRVA5VkrO6D5YJ+E1GxoHL170Z1UxfBXAk1Vjj0V+y28y7Hw+iQfeTNzHVqgaHaOC6t85PiYY8Jz7f/9yL6atEs2rEOIeNv6Nz2KtWISH7GWKzkQxWMNj9g7bpdBAanq0QT9v4xTGYCQjFQLRu8K6Hw5ufjvar9ueY35D1STCdvqbCFDyx1ZJ1Bb6zz56lbVVYtoRCGcHTOMrjrdaoRUBnm3wadaixvHqZuQAW1GtQvwnDY0NvMTOQ1F5qa1RUHZ088tl4Kx4IAL8M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4835.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(38070700021)(3023799007)(6133799003)(10067099003)(56012099006)(22082099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ci+uHBSRQxhYR8Tz3Kp0IbvHh9Gt0B7xEYefBK8DIgT5HVVEzBKsks82NpjQ?=
 =?us-ascii?Q?9Kq6GmH84+jSDAq6fXjUoG4J1Iauk/l5bmD43cqsBAPetzBcxtKjT1HXESc9?=
 =?us-ascii?Q?X+2r+oAxbm95yZfCPscAixADrKQbtXp3PyKLONRo1rcqoceKzhh3G3/5wlKT?=
 =?us-ascii?Q?8UBGJSBpjE+sAr5TXFDojZrYDesnKh/IMISGCAbaInuIDAX43dKhk2402MDJ?=
 =?us-ascii?Q?J34lLAYMNTPHg0/7Qkepfec9JRxOnEib08K2MRIGZshlUAL7w5xjPFiTW5Lf?=
 =?us-ascii?Q?GZMp9noXkTBV2S6zgbUY5EKfOqHVfOnfME/HyBZPSInw4gVLqu8rbYQSM25P?=
 =?us-ascii?Q?zYan1bN9S/jjljTgeuuEle1G1K29u2VPEdtMd2QRS2LZnOPEDWelWKZHNoUy?=
 =?us-ascii?Q?d+P+Z3xkgfBaDspJIDAAfE+6o94KDipKTYfLbEMUAyKRGO4zYMRPtUUTf+Dp?=
 =?us-ascii?Q?cfAbZfbktp4rtossvUCzsPaQR5agk6rdoujCpDRPA56SIc1z4r0lI9lHGNDk?=
 =?us-ascii?Q?sMtBXaUhiIGr/w03VxqrrhBHY3pbB7Ka2jaLJsvI26YfEkPzLKNbqq3hj/6A?=
 =?us-ascii?Q?KUf6b1KGW8uEknflo6wH71PyW2Tre5sKUrjptY1eiCE/1A7L17DVOQk6AHlg?=
 =?us-ascii?Q?Mwi/Wm22GYLAECVKbSWAeL4wlrZhRFcIS39eX2a5CiS1txwO4BvaItWqmddh?=
 =?us-ascii?Q?hoXFZEBI2wstOeyWLSw+MFe0p3Xko531IqJRrU9GYBJkD59qUv8p1rT+lLhF?=
 =?us-ascii?Q?+TjHoHzESPwNvgi0VZclCl4FALKSYav7tuuwD6ypzdeHgvScBvWfYm4cKN1k?=
 =?us-ascii?Q?keaIjlSfuAF5De3FeSIAIE2z67WuCOCL1vpqSieBX+ntzqFuC4Q6akZKGNk3?=
 =?us-ascii?Q?PQIchA2cJ8nec92fjcIlnRokyNIRwaDpYpUcd8SEuAvjDyMWa7XC/O51LyvG?=
 =?us-ascii?Q?DgNj70AsAWK2syAje5iFAuIC+sPsSSMQTmitzWoW9JbJjSn5aAmsjoOx9bww?=
 =?us-ascii?Q?yU+9gXAfQY3XsgkMaUYQhQ0/yTlapMp6eyO7wcNgS4xCD355jyIpyCtUd/5M?=
 =?us-ascii?Q?l/BaMMqAFpElQJMUirOUC8k2i9xDa5kCbbUDEK1LwbuWZS86ud7CQoQxBGzt?=
 =?us-ascii?Q?9WUogrvfsmwwj0fJumq3HEJyDgin2t/lPb5HQpPiumTgsyYNreXlXdmLDLnz?=
 =?us-ascii?Q?a2hoHPlji5mENvB6fdGuqNbjoYD8S3dkMmRuGkqhUgdnBuIWiTQN7nX3P0bs?=
 =?us-ascii?Q?vre9uQi/pFlshsjovMHhN0+san9z9dgRu/Cg1VRLvyiv+jbWbPhtfIORKL06?=
 =?us-ascii?Q?GMJKHfUToaJ6RkbBQjgdthlEkDoTikXVzZwhiWnMZLT7580M+8Lt1m5nkqBS?=
 =?us-ascii?Q?FCJtonr86KkajOFw+PWHHpX9NXRvtBYYWrfXwGunC0HUKEMjy4JG06gQGVk2?=
 =?us-ascii?Q?iBd+4ZL+50EgpoYU7aY4ExQ2CQ2cznzSdeVDvvPVW8xld43VP+h3STduPAEF?=
 =?us-ascii?Q?GdOFaSYudEZakMkKajE7OXpbcYYhIPcM6e2df5g7pAJTh8qFhtJzolAt3NBv?=
 =?us-ascii?Q?jJFcEWk6QLrZnYitO4yE5Iq43Q+tx9Tex/aNaJMalC4Ab+rXt5M/Gqq6rtjl?=
 =?us-ascii?Q?wqNpTRve60t6P1IP2j/jbchbCV0RlxeFxUZs2SohP6q5mqAviDvN2p/40uhi?=
 =?us-ascii?Q?PEvGv8QhQ+mmeoVMTJD9Xuq3W0CjOT6mJjKVrX7g2SCEUaErJGrqYLBftxVS?=
 =?us-ascii?Q?qVWvXz2w6w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 33S1r2vpIPpJDIPk5ZhavjJK6f9dWEwg1AWNhARbqgvCKHL2oIqpFxWxyOshPaJ9KDK0nQoEJ6AJBw8W98JgzJE1tLthD+UMrZpHwz2E0yZE2ZG6sp9H4FH/V+zDVLNJe+7wyMAXLZYCck0sNTsTa9+QjIYwV0EluGw+jchDIchpEzKVNkz/bku5kMKg6NJPLiBYkf8cQ07jwCPNUydtCvDM+7RX/0hM+54FOda7op02u2Lp2ZvYBRmFG1QPTzOgEygTCjzqhdErE7SWDY9Tpzxkfk5GOvpH/NVHzx0xPO8KH155/6jpS1sdQH9uhEuRqWYniYQg/FunrVo2QKrBmw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4835.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64108e88-5052-4ea5-9a32-08df1a102d3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2026 07:48:08.9931
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cT8IAue+6XfWT2x7fgWi9JHbvfnQ/I+77z0IerY9y8YsgjHn0u8UjC3wo5VtOTHUicMmsmenX5BifPzDPVRmHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6350
X-OriginatorOrg: intel.com

> From: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> Sent: Thursday, September 17, 2026 10:02 PM
>=20
> This series adds the IOMMUFD and PCI/TSM infrastructure required for devi=
ce
> assignment. It introduces an IOMMUFD-owned vIOMMU provider registry and
> the
> IOMMU_VDEVICE_TSM_REQ ioctl.
>=20
> The series adds a vIOMMU provider abstraction that allows a subsystem
> other than the physical IOMMU driver to implement a vIOMMU type. It group=
s
> the vIOMMU operations with their module owner and private data, and makes
> that implementation discoverable during vIOMMU allocation.
>=20
> External providers are selected by exact vIOMMU type. When no provider
> matches, vIOMMU creation falls back to the physical IOMMU driver. Once a
> provider matches, its result is authoritative and failures do not trigger
> fallback.
>=20

I wonder whether this abstraction is necessary.

The underlying IOMMU driver still needs to understand this vIOMMU type
to check vendor-specific compatibility and provide the relevant hardware
parameters. There may also be further vendor-specific interactions between
the IOMMU and TSM drivers. In that case, the abstraction risks becoming
little more than a connection between two vendor-specific drivers, while
making it harder to maintain a clear scope for its operations.

Would it be simpler to provide helper APIs and let the IOMMU driver use
its own interface to delegate vIOMMU operations to the TSM driver?=20

From iommufd's perspective, the vIOMMU type and its operations would
still be handled by the IOMMU driver.
