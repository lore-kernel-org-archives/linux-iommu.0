Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469D6157A46
	for <iommu@lists.linux.dev>; Fri, 10 Jan 2025 07:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736493783; cv=fail; b=PSf7fmT4K2urF1UfvLak4RLfAPBiar1xSoyWpvo2BPVjc0KdvCK9QiMvmlm9RCR7PVBlZyP6xsgPeRzmyfQQ1qSpdu60PiPFKXNIadKOEzFpgDvd/ORHpFz1hrYjSqzowCoaFhcACfgX6VN41OUsbaKHu/gr0ZZ+weyEwNm/YbE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736493783; c=relaxed/simple;
	bh=D4j0IpszX5eTQ/Bri4QuPylsR+75TW4pmxsF/gCh8No=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=m9m1j2+oEVkGXAL83oelhqbYm1wBz0ODrn5jQwgx6saWM2hK8baySwEr89L3y+k5c+IODQrs4/FpwfXUx09Lk3iJ9tALfoWNjYz0wPYAKgB+UBXON9FghEHDIuZ9g+FWAGqkXVYMcu85+YA5JEAC6aTpef5n2E3wCba6EGAdVGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aN/JgvJN; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aN/JgvJN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736493781; x=1768029781;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=D4j0IpszX5eTQ/Bri4QuPylsR+75TW4pmxsF/gCh8No=;
  b=aN/JgvJNTdLYsd1NiKw6Q9KsCu3Sxo6ozwc37K1EfRqIigKy3yhLZVme
   lN/CUQXEVt8cBm6qsLEnP9nBpuKNWhb6VPjYBy9a0WF/kjUKpFCurOtP4
   OBWp2t/bPbW4+L86HZdR70l2yQRUHl1ojKbXnf6ehQhj0K/hQXpvoi0bl
   +A5ZDbAYll6Ae0//lu+taUQtefo9Q0a9fxVZBnI4U2BVRabkuqNdINGai
   maTBBzl3KV0Ar97TXjQibesTSm0lUpynRlU4GDiLCvFvxuRo9hY417Ioy
   sjNxv1wH58v372CoTf9ws5BeR/NHy1fB558fUAdoGrg4aj2SY3yXTBQcB
   A==;
X-CSE-ConnectionGUID: m6G+gmycQNemTzYW13K2lg==
X-CSE-MsgGUID: EWNf6KZJSPiG7CZwJXSCkg==
X-IronPort-AV: E=McAfee;i="6700,10204,11310"; a="24384189"
X-IronPort-AV: E=Sophos;i="6.12,303,1728975600"; 
   d="scan'208";a="24384189"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2025 23:23:01 -0800
X-CSE-ConnectionGUID: AC/X7gnKSP6T/GzJiiAaIg==
X-CSE-MsgGUID: yOWtbtANSZO4FaYlqFcx1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="140959984"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Jan 2025 23:22:58 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 9 Jan 2025 23:22:57 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 9 Jan 2025 23:22:57 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 9 Jan 2025 23:22:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iYki9XBMLNarqfxEYeD9EFcbT7WaxRmyxPwJTT1n/cnISXCrMne9fOSXw91jf1Hg7q/P6aCuW9qdLAlzLmjkynB7r12xAkCprMj26hzKpv1dw9RekTPs9X6/2ZvlANCkynF8UIlntxklCeXVSH1h5hC9r50L1K3m2JVvR3Zgj80HKttVTsM10naYCxJ4W+cbOJxHFptFV7s0SIh94+grKZ5BesDNyWQaDp7Bmlhwm3AELRT8vX3VU3uB6NNsGtAvoTmDeRGoLrjeRD7IYcsi66LJnMgiNIfTiF8qrbhV8oKqDi7b4+MH4ZJY37M8J/YfBXn8pDjkFvxs2qCDNOTsFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D4j0IpszX5eTQ/Bri4QuPylsR+75TW4pmxsF/gCh8No=;
 b=C87HSQQR53BDECYVIlhABzYRxX+FHavVOqPw2GOAf9LkfjNhPYV797HmLkruhlTGLy8SeIXg4T0xnNHrzkWct8c+tPko6cww2Jum02BNx9hR6ke9fratlAo/Dy9c/QF3Y6KzBSE8dipiOFs8tXO3Z5gUBhKfh0ctwit1tOg/S/DxuR9Z424s62dbXymgtXAyyR9eLkzvlg6o5JGPP447n2+8qA/fi28Y74jvQ4Bmz292E3YfDBZ+LdavKtYrlAlkONQNZsFhmaR3YMV6KjdnJJHrfsBI8XmCQrxqj2tfWVWpE2pDPzKdZmBBvvDJPGXYB1J9Ow0aDXQwVkJrgS3XvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SN7PR11MB6774.namprd11.prod.outlook.com (2603:10b6:806:265::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Fri, 10 Jan
 2025 07:22:54 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%7]) with mapi id 15.20.8335.011; Fri, 10 Jan 2025
 07:22:54 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>, "nicolinc@nvidia.com"
	<nicolinc@nvidia.com>, "chao.p.peng@linux.intel.com"
	<chao.p.peng@linux.intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "vasant.hegde@amd.com" <vasant.hegde@amd.com>,
	"will@kernel.org" <will@kernel.org>
Subject: RE: [PATCH v6 05/14] iommufd: Pass pasid through the device
 attach/replace path
Thread-Topic: [PATCH v6 05/14] iommufd: Pass pasid through the device
 attach/replace path
Thread-Index: AQHbUhnWrHEFSWhHgkCuA3x/XPSChbMOMeAQgAB104CAARTP4A==
Date: Fri, 10 Jan 2025 07:22:54 +0000
Message-ID: <BN9PR11MB527629FB9D1911A35A1A0C1E8C1C2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20241219132746.16193-1-yi.l.liu@intel.com>
 <20241219132746.16193-6-yi.l.liu@intel.com>
 <BN9PR11MB52767D0A44E2F75F1641ADF68C132@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20250109145123.GZ5556@nvidia.com>
In-Reply-To: <20250109145123.GZ5556@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SN7PR11MB6774:EE_
x-ms-office365-filtering-correlation-id: c5270780-229c-4c59-f7bd-08dd3147999c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?y1T+5heweftBKBJFscB5s/QVD7Kgoo7msGeoS1T4YAOI8CVrlE6m2p61FIvy?=
 =?us-ascii?Q?3hPdAv5aKXV5N6lk2vxy7ngR9zZatyOuf9J+UMis5iR3gSyb8bYjQHkRxajn?=
 =?us-ascii?Q?G7fLMn8vxva7zf+/CnLXkphkE6/q+ZovdLcGIPAEu0Xsm2DgHJLfeDyfumTA?=
 =?us-ascii?Q?de/gLyB0G5bnwSfjAfeJ9Ptylnk7BokyWYLgVM2UfuxJ1Nh1mWmT34KO81lb?=
 =?us-ascii?Q?cVz5CAHxSI6vC/IgxswL+6BynjBCED/LBrziAhMeLBE3qIJEAxgmph737GS/?=
 =?us-ascii?Q?iJgEbqf4CDXBLqWiP97M74NHKK+1bq1AM5PL6tSUhhekEK9w3hDjFwNSuKXs?=
 =?us-ascii?Q?JtOIn2uyEfvm5Sy5J+0y7Y6niTo2A/zABliFcwfVH7XJ0F90D5VXXpAtVf0U?=
 =?us-ascii?Q?MPQZiyzZmKlk6OWV9UEFTScJ6MkXxRPVJt48jF4ge78SPBVCqepjNQTq9yGB?=
 =?us-ascii?Q?Ld2dKVm5CGEOMsr3pcUPAdmyxe4ThXoCZe8Be2OuEx5TqpbBzHaLs0JRiAin?=
 =?us-ascii?Q?9uLYt0sFLZAFX5n3+s7m4wGbjlz4dAPNLq3GSZHqJdlcqp4mVqCvW+0W1b5Q?=
 =?us-ascii?Q?1yDwvM/of1gqOw5RlVJ/s8GrKLR55Mxh7WfP8hiujstQRgp5ZJdrE6oZVGgV?=
 =?us-ascii?Q?/wbVYUm47H3WTsyKuzIF5YfmRKoBAd2zcVQkYWT1eGpQEuAVcDc0oJU8U4r0?=
 =?us-ascii?Q?tSZR08aoIKD/HQrxq81XXsXwrNRCs992DBLdPMejYjIyuol8/yVR4qmm6RQc?=
 =?us-ascii?Q?i8i2r2rBief9xHnGvhDxpkbt85AllB6JgHToRYjSJCnWNIqnsCVtht8YAa67?=
 =?us-ascii?Q?xBrwBsnlwqaDeCc25lYkF8Fqlr96AcCIe5Uq7B4RmK5D/wjYVMDRDez7qsxP?=
 =?us-ascii?Q?YlaxquECAg+Ns9UtwWE1I5nWqMKOTAkw7gRwv12y//5ixsNt8TDO/tmdPI2j?=
 =?us-ascii?Q?5aw7k0AYuBIwpF/JLYd7J3i7T/3nR/F1DhBaltW5OybHdITCYilc8/Y8I2lp?=
 =?us-ascii?Q?ScELiDbtu9QSkohtIrFSdDUkwHUT63xsaoZx0HL1nxSYh5Uxaz63cWbGh+Px?=
 =?us-ascii?Q?+FBiC9LyTfrilnmue/J9aRBbu5/HzAiuGL2NMzKY/w7BdeFzNxo2I+4LoXrp?=
 =?us-ascii?Q?lE1OlVQd4iKUHh+lBehu0s4CwpAYzO/rhSc7aAVFRK/vvDZM5VcPFjm1Phfp?=
 =?us-ascii?Q?kmf/lAbC1P1DdISs1fp2BtJLXeiqzSx79TUM1g/BUJI5za3qWlDqKStpp7qT?=
 =?us-ascii?Q?5/5qQMD8SBmDWG6jBMXFBV96RVckB9QFq40YX7g+obJ5w293twMQEZJ9bruQ?=
 =?us-ascii?Q?hahfcib60s12A69x7zP9aNv/KHDyRNI9xZKQmn9Z8ErRahMnOylRZxT/hnUS?=
 =?us-ascii?Q?6JpNefVz0jACI4+UwOZAA8VUdA5Tbk3RifXQwuYFqlAbTwKheXrugw9vtkpo?=
 =?us-ascii?Q?9earguDpzkO1U+YkI9ixsw1FZ6vZyPk8?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ANwjkYn1PG8SEvJDrorwcTaHE1SY2b3AgVuDOkyKRpVRXmzDr8GzG8+KwqFA?=
 =?us-ascii?Q?cgchvOHuM5hWXKcBcVY8BrLY1UsXumEXT3WANZHbxtb/xOR1EClsdvgBbzqe?=
 =?us-ascii?Q?sk3aaNJRIRtJLyDl/Rec9JK6BEjgSUNbYdh7ofDTUSwdcSUnkaFals39yf2P?=
 =?us-ascii?Q?q0Kikc2fqpXIYqeM/y09E5V77mFV2p67MQsJhc2JaTxV9YanzC+ag01ptrbY?=
 =?us-ascii?Q?P5K/SLM1szSIGJ2byN7SGtHi5wM5Eys/gKHyclqB7t35qt/N9eB8ksEXyTj6?=
 =?us-ascii?Q?3kZRVZBq9GUydZhv1EoxaQXi8su0iCG0qdO0CEFdNjTMcavtA3YA1q/8cf+X?=
 =?us-ascii?Q?soGA/JSxgJCPuTqo2XQrkluLdfYD4QSsundoQoYjQ2PgkeGekjZxP/Ux/LUw?=
 =?us-ascii?Q?D34Gu+2vIXCP4aliIupftVjjzONKqphz2f3dNoS8r8fUkjkEaVWdabU7qFNn?=
 =?us-ascii?Q?TXZ0/Eh6WnpBShlkZSHHaT+9hBgshTQ4PBU8VG2ZeG6cK0vX5Pv1TMAcfyLU?=
 =?us-ascii?Q?YaD5aiBd8+xZcnquFDuR+OFnWVv3sGQ/hLGWDaH1pb5u5/GRCDn7Kc9/CEAB?=
 =?us-ascii?Q?2xB8BVZnrFjlpWuyGpZUc/BFq8rzs6u7OEv2LgO+3oybap4neVxAtpbV3WF5?=
 =?us-ascii?Q?yOgtwDpjR0iSxroUOVefz/a3B6XYtvyK+e0Sz4PeDogPb7J5LzAOx3QqBLCR?=
 =?us-ascii?Q?g37MCpisOGmf8Gl3xUr2VLiHF1BLIIHZjo9Ch9hcY4oZtCCMh7+gvg+czRfI?=
 =?us-ascii?Q?to3Dg+fXxZeZ1qHYfb23BuyfNO+zPJuzPQ1Fw0uwjwlBEY+q3++/w+4kb3qk?=
 =?us-ascii?Q?Sm7MXhJ0GZqj9HbAuQhg8Zwtzn1UTzeezVsSqAHzDf+yk/Nln101TzN8bTnw?=
 =?us-ascii?Q?QSPRM1UiHlAYmr8KwHZXMgqpCAwT5ebziyTVd0K9Cg4E2WTNguFqb+3Y818A?=
 =?us-ascii?Q?9OaQ79PUsJNbqxdYmRG4w8p70xpF9xFx+pJY1IpjeI4plIQP9aVQeDM9MFxR?=
 =?us-ascii?Q?kfPWNE5O/sLy5ax1RohoXRZ9j+WHxpOIphWv4P10oOAIzFOB8WVAtk7etJ2v?=
 =?us-ascii?Q?YO7yIohN/zudUzYOXMlcYHy89zV1wARQkoIJwQPtCyV8/cgRYjsBRo5XvSoS?=
 =?us-ascii?Q?WfQ9pnRLcUrkm/ODgqB4npjlGIkQ8tLnD7WiqWp/GCGtwORtocvINVdJbMit?=
 =?us-ascii?Q?mavnB2zL2kbrJm/aHJBQGwcNTY/k/HQxuNTE3MfxeNklpqWJwG4RHELpgE4X?=
 =?us-ascii?Q?n9m/+IQVQMHkh4Z8/boPkSYmbnW546ScnpwCbxIPKpqNx/4CTkKUnk9WOujC?=
 =?us-ascii?Q?rmRAKXdtb24EkZ8vLouzbyrTqdUSk/oSMHmjLdz/Oofhkmox3/y2HpgerFca?=
 =?us-ascii?Q?aggwlOlLGXZHOfjtaJqmo9quBrpbze+pqEhqeyDyOiFZO5xwMDWwJxi4LTjg?=
 =?us-ascii?Q?AFCotkY9Nd7e40qaP/Vwb/SZd9p1rX31HX5Z0gYqLnEiBrROm/uOtyMt7pkH?=
 =?us-ascii?Q?bA9ml9p+QsWUiWt6Uk1s2Sw8d2aLD0HfJw1OmCsvteJKb3PIMcrDd82+A/iG?=
 =?us-ascii?Q?cw1jXK1BZz9PXb0IUiimgnWUQ4I2Vs0deGDBeBiP?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c5270780-229c-4c59-f7bd-08dd3147999c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2025 07:22:54.5446
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SxL0qKdBjd8oQOUjQCjSaVTqZeOFVZ0UiLz9wZbs037vs4td3XRYC9saM5yvYpSQVytKu5wK/kwZruP3DKYyuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6774
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Thursday, January 9, 2025 10:51 PM
>=20
> On Thu, Jan 09, 2025 at 07:53:03AM +0000, Tian, Kevin wrote:
>=20
> > While at it, @Jason, is immediate_attach still required now?
>=20
> Sadly yes.
>=20
> virtio-iommu hasn't been converted to domain_alloc_paging() yet and it
> has a domain finalize function called in attach. I think this is easy
> to fix.
>=20
> arm-smmu-v2 is converted, but it still has the finalize function
> during attach only (I failed to fix this).
>=20
> mtk_iommu and mtk_iommu_v1 both have "domain finalise" functions
> by simple grep.
>=20
> Possibly more issues in the embedded drivers.
>=20
> However the server drivers (smmuv3, intel, amd, riscv) are all now OK
> without it.
>=20

Thanks for the info. Looks it has to stay there for a longer time.
