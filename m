Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DB017741
	for <iommu@lists.linux.dev>; Wed, 23 Oct 2024 07:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729667125; cv=fail; b=uGOZlGbNXh9iAmBOXeFYs3agsd5FlnZAT1BjF7QFi2i9jSEGeJ7+pNrRotiH+rwSNEh5n+zVnbuyEJB6FqCoYMO725ide09wz6ed+j1ixM+fZch8Cylsy90MDPFQewku4d3tQHkMHenCUTHtrog/AzgIBRoVPR8dk7Nzj5unv0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729667125; c=relaxed/simple;
	bh=eQtq7yViqpA55YeQmhuUpeMXaw0hZhS3VXkBCVKh5wk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FU8fKIBqAvAJfQPHWh8D6iECBrhvl2IwhFlP4nW3A2G6IRCQ9E6QHXPHgqZxb5KzQLGFJFVBqEOVDCQ/lhV1ZbJ+PelXZB4b1khV8L0mJ/7xMQsDSQeK7eR0anchkYb68XEywydqp0uxqR4H6fNrtNGf//UTnRFk+Q9JnCLgyQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=akj7ZlWR; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="akj7ZlWR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729667124; x=1761203124;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eQtq7yViqpA55YeQmhuUpeMXaw0hZhS3VXkBCVKh5wk=;
  b=akj7ZlWRErpOHZyCh3YzkYmI1D039T16kWClGOyPxjPtj0W/0/8RbwP3
   O8CoUzHSGYP8wUs6ZYvcHRKGwI9iskmK/gqV8v2HjDakBnt2P5+H+GfaH
   K1f0+y96lnHQ2E+nhE6bIKwoIsupte7lVLMivX3be6L92D4scSgr6hR1m
   YZLpH5e/+aGUiOROQArDhd/uHgxHU06ZLFQlA7BNn90Ua5qV1vSBXiWAh
   vP9Yh6V6zZOwNAYGLm9mi3ThQoQY6ZqO9ciLDQOCFkMdTXYjgVX4WsJPm
   CYDEVrgRlu+oTFIvmfcgm7O7Cpl7YiS0aqY8soh9uK2T6RKzXiHqQZUtf
   g==;
X-CSE-ConnectionGUID: j7cJtqY4TwCHescHPAovSg==
X-CSE-MsgGUID: kJwfEKZTRamdSGFqErcPiw==
X-IronPort-AV: E=McAfee;i="6700,10204,11233"; a="29131372"
X-IronPort-AV: E=Sophos;i="6.11,225,1725346800"; 
   d="scan'208";a="29131372"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 00:05:23 -0700
X-CSE-ConnectionGUID: eK/n06Y+QSCfxAEv3DxZrg==
X-CSE-MsgGUID: gmx3vM2xRgOOcQELzE9TaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,225,1725346800"; 
   d="scan'208";a="110907035"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Oct 2024 00:05:20 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 23 Oct 2024 00:05:19 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 23 Oct 2024 00:05:19 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 23 Oct 2024 00:05:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mXJvlSNs+t8cyOVryzGVH4RrPaPr/aw1qU4pPAqUWnYuBURxvUw4lLSlGivxF2Ldcugr4YF8/VCWPxp0GVTrFyNJVPz80WsDlGeo+av6J7Gsu77jWtHzeQEc4dL5IlH823zliSPYBy5cwiTutna3Rxgfg4xARHRypa4gCkpktC7N2OlgyLPp7mOAuZ2uNRbriSeE8ISZvJpb/XjmfQpOzJkwboO7ecHzlqePcnXptquPPwjMb8j7YhPd314nUwlhAu499TW5CFI+bxIBBAgZg4PU8tdyGQl0J8mvDiZjvovCHH4397uRqlTd4M7g9sGIh7tnWZNiNjzQHtWp6nBVfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5UuwExYA2hRSLJBCH6XmKV0eD0fckbmgTiTrGUX0sRs=;
 b=lhc4Pj0k6q76ToEbiyQCVxp4svwLrnmo59UdTQabdJKXs6Ex67GrpXr1EhFyTkXpwgewVxRHozFhin51i3bamfcs97GCkO4VK29XVxKSQoUW/mgoqPPF32gQvOnMzMbsgjdIXE3M7f2pT+5okmWlT70G/IiPlTBFZ9DK62QZClju55CJXrzHkBYs+vsLjo10DCpsLm5zNnlsvrgVSE5ZxzRry8QGoxDzRGHl3VMuqFP5pACOcLHMLLmyalqGnJDAhQlxSUaoV/W4eDEO2Dvsc5KGUovs4N22Vzn9oHGotx19rJB9w0T6ZZ/vQ4jIYTdH/S5Wq985DQHruBgOajUE2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 by DS0PR11MB7681.namprd11.prod.outlook.com (2603:10b6:8:f0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Wed, 23 Oct
 2024 07:05:09 +0000
Received: from BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::5616:a124:479a:5f2a]) by BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::5616:a124:479a:5f2a%4]) with mapi id 15.20.8093.018; Wed, 23 Oct 2024
 07:05:09 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Steve Sistare <steven.sistare@oracle.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>
CC: Jason Gunthorpe <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>
Subject: RE: [PATCH V5 2/9] iommufd: rename uptr in iopt_alloc_iova
Thread-Topic: [PATCH V5 2/9] iommufd: rename uptr in iopt_alloc_iova
Thread-Index: AQHbJMWf332nM/vEyEyxvw7aOiHUe7KT6iOQ
Date: Wed, 23 Oct 2024 07:05:08 +0000
Message-ID: <BL1PR11MB5271D6A9C37B61345F4A22698C4D2@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <1729630838-24586-1-git-send-email-steven.sistare@oracle.com>
 <1729630838-24586-3-git-send-email-steven.sistare@oracle.com>
In-Reply-To: <1729630838-24586-3-git-send-email-steven.sistare@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5271:EE_|DS0PR11MB7681:EE_
x-ms-office365-filtering-correlation-id: cfc4fb59-e3f8-4dea-6808-08dcf33107cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?xMAKUVQ9X0+nvdmNtQYADX1k5BPwvAVFcI99A0v9tRQ8Ex/q+HbuE/hWSYsP?=
 =?us-ascii?Q?AbLdjyPvYxbijIOBeJfXjvwnYu1VFfn1Idh/l+A5vTfzEzz8RQG92FzhtnFZ?=
 =?us-ascii?Q?oloQ3XO0Sk02CqKvF03FySGIQ8ZtzXM1+Hye0UKfejxgYP3Iyd4qoUc8a1uk?=
 =?us-ascii?Q?jkhXFR7xcn4J53w7jIZ3caTj9e6RReHdM/gwp9p2EC9Z76+iMdhqmNNGRWWQ?=
 =?us-ascii?Q?8Teidv4/fM2I7l1raktAzP94/Ph8cawobQP+iiRNtxAiDjl6ewAAjicOnxGH?=
 =?us-ascii?Q?eVhznB88WLyfldq9Vp+nlKt6DQRIYUurAndE+7MhWZ+JR7+XNB6g9WiLoEqT?=
 =?us-ascii?Q?iT0+63BxwEDRqgrjkullHU33TxCFmNCImbneiN6xOiU0BX9+Zb2nbx9NSzx+?=
 =?us-ascii?Q?dyOsz/DfNL9T8zhYEwifTe8HvJ+OXI5jX8Y0Z0gy5yJdNobgscI6VTN60prf?=
 =?us-ascii?Q?DCENRZWRgymdLCpByYQHQjJwYKxIySvzsH3cC7zNa+U5CnAJyNizjo8y0ovt?=
 =?us-ascii?Q?bDJJaZ7fKxjC0JCX9SbDfl+K89Tbv6NPCDS75+7Q+ECLVbXjVQLuQhLlJ00N?=
 =?us-ascii?Q?AblRXwSFhgF6etjxW9kf1qb/DUEPckUVL1ue051Tu+qbKrN4/llvOznUpnaQ?=
 =?us-ascii?Q?1SygWbZ+B+eReMJbtIAmMe8F/dmGzHIVgJyzxiHFc76uHNJDolW2rzkvaLzD?=
 =?us-ascii?Q?aLJJ0wq5rMLiZ79uLzH+1DxwPtVKPjk8yRsWXOddty57kUdmCsiNvKDFJPaW?=
 =?us-ascii?Q?sCYK26fRuIHR4cB+/dhu+1b9zP/FMP9jnjn1Bny8OZIemHrNTV5hFv2hiWPw?=
 =?us-ascii?Q?XC9HSkWJGjt219uWfrK/v1CH4W+++aPr35FTqaaWpv45oAaavxc3VOR0sAaO?=
 =?us-ascii?Q?SK6j6Slv6ZQ9mrNJMKotQUwQldZ5/BJer2qchgxhRRtsfrUg80QZXp58plBt?=
 =?us-ascii?Q?6Zwd6uonIj5UJOC1RgXG+DkM1jAMWp/mG3qoq8Cfpj+YNkruhkKfaqjr+EGq?=
 =?us-ascii?Q?TqQ7iLhMvbw/7pDPdJwtWR/V6dPHSucaQsq61pOL/cMm8IwnOt/IMQ/6USF9?=
 =?us-ascii?Q?dg3Z0oNeUypys1sJUb1rTTdaEcw77x7wpRkbalsxF6D52qr8l3aXo5QHRTtV?=
 =?us-ascii?Q?hLPcmQ9IOzuTDxOW05aXOY6Hg2ZNIQjKLyzaYndgOiXdgymwn6Sh4F4VZPQ5?=
 =?us-ascii?Q?HDuP4mXDgE2nihWvn2D+eQPlhgilHdg6GEh9UiOQyMSexcYwve1yoaUAtYNs?=
 =?us-ascii?Q?Kdno1AiNmV+QCNb+/MBYyZNQDlX9201c5iaqz652ABEBVlkLPUnQqCbcgCW6?=
 =?us-ascii?Q?R9qKTlgcxQv5wEMucKaw3Pu14n1i+2EZuHJHQJ1sxu2x/p5Qc+7azBbUMpjT?=
 =?us-ascii?Q?7LpyzQ8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5271.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rlVOL/X515qNSSBrVVj/9zG/vdyOTzDJMA+d8vXEqNA9kcvcAZDKQjkBUx2a?=
 =?us-ascii?Q?2xUAnROrYvqhHVr9cN0IeCmBN83ktX2RnTrRvP9r/oA+tQLGHos4dE0D+cxt?=
 =?us-ascii?Q?xsQaaIRDrKXjKfXdE5kLdh4r7yugm5wvjNRWCVa4lHOftMTQm/bgBoYnvfhi?=
 =?us-ascii?Q?VfIv4Lx67JpCz3LRsgvdoMmEBLjuHeMNeGmFhiAwdICgC0KBUACYJnV5jo0Q?=
 =?us-ascii?Q?mIO2CpMH68+pSOEr7MuAmHl2v56StuFYsXxuJ0SH++hMoZYhOVbkvD8rgD70?=
 =?us-ascii?Q?HP82SdLb8ihfduhK8/WJDb9k7nH9VCUYaUYeFic7Eya+I7HJFJ2occ1TV04X?=
 =?us-ascii?Q?cI2Gu+0/jYu4veDna3gRu3z8jW4x8RdUrA8TjUukgyFSNf9yN7FIZkORZPhM?=
 =?us-ascii?Q?9FDvP9nZpxYM1PqFL6xzOvzBq8nsXFV3SGvKwvT3kxiz0dQ8iRHwGv3QvGFu?=
 =?us-ascii?Q?bW61csKRNiWM9RXfGu6mKZkP1J/vPp4LFsjq/JCYr2bX2I95+nG4GVY6qMju?=
 =?us-ascii?Q?3RKRZ3VXnM7nYBoMNBW2JG0maqigLWT2IDJ+Vul+Z6WsghWXiPvLEZpLp+ut?=
 =?us-ascii?Q?jU5RIN1g3OfccUHB1I7lW0pu8+rYydIIL5Uz2gw+bDm6M46SCzpMAa1J24Qp?=
 =?us-ascii?Q?UBLT/LVO7YSVz9GLFPKzDDzMvsYP4frdWAHTsUfz45x4DirJwiH4MzJUIo75?=
 =?us-ascii?Q?JRNosdQcUDhR9y7sX45eECoS7V+4+Q3r6PJ2HCKkRo2EsqqrwgQRBunh7cIP?=
 =?us-ascii?Q?MxH1E8ec+D2bC8yISLtxjsM0QKF0tc2y2o9JOn+RNldgKi+CY7x5qYkE7mxB?=
 =?us-ascii?Q?RhjRMy6otEKROjysMQI/fx1jf3U+hi051CDthbb9RN78KgRvpXi2MiULIaJ6?=
 =?us-ascii?Q?F2J9Qc8pcSAgeopmdyUoIKs192hP5/FFDPd/aHWLn8dEEH7pL8Y2/9GFzL+z?=
 =?us-ascii?Q?GJMyjlCR8K35zPL7xDlKz5iinFiPrbNnIeQrIB91TMkWQp3gia+h3UPT63Fv?=
 =?us-ascii?Q?RR2OokvEs+jpvwwXRjnUnpco0MS7iuyUf0uNkt+BN6V6cD/mgLg24vDURstS?=
 =?us-ascii?Q?U/TlIIXOpEUvKixSQsMgERjCxblVgDzQftHnkQ7GNcP24qVCgsXBe8bjnWkF?=
 =?us-ascii?Q?1UgZPMqV253CDKIuPYaM+Z8Qz/fkMYj9Z9jQWnIkeJXxyaflJCo0/HWz8DjJ?=
 =?us-ascii?Q?7y4koFWFv/BAArq/QU3/U6Zin+NI0nyIIALficT0Ir1S0nLvgg6CQSCLkrgR?=
 =?us-ascii?Q?Ia0W/7Evm0sfzEExrA2pjBpqUa6oxBcx1U2Tw1+Sc9AwwILOge8advTrhAN5?=
 =?us-ascii?Q?EBEat4ELgZFaZq2u3oPwNoe0gqTmBJqfD6Er9neul6OIuLu7CubBmJsdE4M2?=
 =?us-ascii?Q?rPDZFqsKuwPtjfV59l6O1LPDDBKC/rwmR+IXlVHB+qdz7vGRO1E0FaoHQpAd?=
 =?us-ascii?Q?0+N/hpZiJQHXfvFFjEGTA/uSuCoxvKM7p1OjdEPhv2SkUPukIVzhvrY3Fj/V?=
 =?us-ascii?Q?bhaGziltD6LM2cbltsO0sixRx0SFJhLg40QNzdXQWlO4Uc/qmF9HPU0cBhxp?=
 =?us-ascii?Q?ewGTXGe+RFdpwBqjyU1RQXCkIxxAbz80xsdwtwg0?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5271.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfc4fb59-e3f8-4dea-6808-08dcf33107cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2024 07:05:08.9201
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +aKmsvtXj2rQS1PcmTALZ4vVR52BBoMwoMwliSC2GrfF5Sa/bOBxP/9VTwrJy08of8qk/6MR+LcRXLe8HDGtUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7681
X-OriginatorOrg: intel.com

> From: Steve Sistare <steven.sistare@oracle.com>
> Sent: Wednesday, October 23, 2024 5:01 AM
>=20
> iopt_alloc_iova takes a uptr argument but only checks for its alignment.
> Generalize this to an unsigned address, which can be the offset from the
> start of a file in a subsequent patch.  No functional change.
>=20
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
