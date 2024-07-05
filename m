Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1158139E
	for <iommu@lists.linux.dev>; Fri,  5 Jul 2024 00:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720140556; cv=fail; b=FREHpRxZp4uZpGDdQ6eS1Lc0ELb+zjp9MNFiDBL/L8mNc9a3xQ/dfp3U79CfGhAvCb2GP1WVR0daTIWe7AJogQtoXthWd70MTwGi4ib4YdUzuxtkDVuwoomITM6Wcv/UOmBeXH1mnQo+ykkvFYnV/kEKC0adf0n0k0s1wjNITx8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720140556; c=relaxed/simple;
	bh=lqJfRO6ZXFEPJC7tVQVQQeqyKOPYdI4WH/wZQlrqBRg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G5COuNDIBrEqJcf2IKX62O5kyOF8vHaHTSZxW9YYVvsj/YD9Dv3WgfaqMCU6XNmgF3hWtKhe78fP8E7b8aI7FjgSA8ThoWzor8b1NssNCqR4K252+YxzCtdJ5s0I9gqJBRFHJoOvzpinsfocXVRq06ums9qeTH/7yVHR/Ba9JhE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fahQvu5s; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fahQvu5s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720140555; x=1751676555;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lqJfRO6ZXFEPJC7tVQVQQeqyKOPYdI4WH/wZQlrqBRg=;
  b=fahQvu5s4BhsdQKkFyZB+XYxxm5HX56zvhGwsF4hJ5ITgHjZECuUCLXh
   uX/VenPmiwJuwC31t5WRaWkNxdEsMRFoo75fiLr/X0CoyLNzmdyf2K0Jd
   +wsbp+oVOC9D4Gtan9LcWJODMLIKePamcsNqmQAioYdwVz9IDC6rzopgT
   RZ2CWIkssIHVeypLPVW6LAGscMP9CUHMgYaA1wi2swEJRRWCD5PuqpA00
   ixASLElHkARYCeVz//rjxG3osSvRQM+ySUcwdBvY1FqcFLn5ImoaAwsdt
   O/PDKZywfDcNDglAn1hoZSRcluZqiT1c860Mh3OanBK76IbhqyN3z0X+2
   A==;
X-CSE-ConnectionGUID: g8WNPBpWRq+AvfuUfsrgoQ==
X-CSE-MsgGUID: b2MbJkyfQJSrwSeMevMSNw==
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="28028112"
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="28028112"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2024 17:49:14 -0700
X-CSE-ConnectionGUID: KLvEjkXNTHOTzbEJZhmH7g==
X-CSE-MsgGUID: z3qbUeGwSJehT6rae1KLfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="51683611"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Jul 2024 17:49:14 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 4 Jul 2024 17:49:13 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 4 Jul 2024 17:49:13 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 4 Jul 2024 17:49:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YNtXliwvrcRJAsi0d2FzyA25h6XVUbFh7ULBqFU+fw4mOrNRg8/eshUVGrI8uzfC/Fq4LLNaJ0OgA5YM849eN3QuckWxFFrEP9vTdJSPtVikTWx0c4vKZlY7ZYx3cJugZ1nSP3JwG3xL6OR3qW6oUtE625lyhXhlIzf+fNOLsC3VMdzMu5ZitWLOvmVmBbLngOdC5SSFrkWHLjjRMcALKE2kTJkacJk/DLdbLdgP9f17nPMv7n2D7aPRXkFgGJOIET5/fbbDKYOUG4880x47p55VwdRvo39sKcJ8PHLXZjU1t/npI71yofmf85BR6q0fTr5ZazEGGsN8O6A8S7xnZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5CeEIJQzGT+g/BrcSxgczCx/hfZtVZjIsUZP0FE0ic0=;
 b=RHKrwbMmr3TZzH9GVYrjN0zQfmX4o6Q/VllPbPlHx8pXqNEf6ede8yk31Y+zxKaSiw9j76SwzWYB/wc/pR2Omr2K6yo1lcJPaTZZ1VHyEYNGR+aMgkfqJoDYhs+gzQ5AvBJBr1/3tWmHZP4VtzfInljabtlCL0bb0NYoEibwdCbxI9k+GAMCg9HdK9mGhESNZ9sGqgLTOrB9pI49Pv5Cfo7GRd7YJS0k3v4cxwpVzWhOMo+28YkOYXetytqIFbIe2FhxPwms2KZpnBnZQRvO7sH7VE706ysVbQnJSb4nO22t00/Xm51RtNORN9xYJjWrEdF5VQ7qtzUogtZHrXIZNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA1PR11MB7870.namprd11.prod.outlook.com (2603:10b6:208:3f8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.30; Fri, 5 Jul
 2024 00:49:10 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.7741.030; Fri, 5 Jul 2024
 00:49:10 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, Baolu Lu <baolu.lu@linux.intel.com>
CC: Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Jean-Philippe
 Brucker <jean-philippe@linaro.org>, "Liu, Yi L" <yi.l.liu@intel.com>, Jacob
 Pan <jacob.jun.pan@linux.intel.com>, "Joel Granados"
	<j.granados@samsung.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"virtualization@lists.linux-foundation.org"
	<virtualization@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
Subject: RE: [PATCH v8 06/10] iommufd: Add iommufd fault object
Thread-Topic: [PATCH v8 06/10] iommufd: Add iommufd fault object
Thread-Index: AQHazEpuGCgtLFWT+U2ig4MVK/B+ILHloqCAgABBPYCAACvCAIAAD2FAgAARFACAAQhnAIAAGPuA
Date: Fri, 5 Jul 2024 00:49:10 +0000
Message-ID: <BN9PR11MB52760E55FE52C5B670AA75058CDF2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240702063444.105814-1-baolu.lu@linux.intel.com>
 <20240702063444.105814-7-baolu.lu@linux.intel.com>
 <ZoXZZ2SJ/WdlMJaX@Asurada-Nvidia>
 <309e37d1-6066-4ba1-b30c-402a3c3e7c76@linux.intel.com>
 <ZoY01iLmzoV4fIPG@Asurada-Nvidia>
 <BN9PR11MB52769E10ED0741F5ED3E5B668CDE2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <fc7f5bb1-25b7-4a5f-8d6b-1fa17b1af534@linux.intel.com>
 <Zoct3LVVHhDNbPBT@Asurada-Nvidia>
In-Reply-To: <Zoct3LVVHhDNbPBT@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA1PR11MB7870:EE_
x-ms-office365-filtering-correlation-id: 3a94cbbd-2e49-40c2-b7de-08dc9c8c4840
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?39GhEufozApXUhOVjHh/sOqSXgyTAHrI5SUlVKL4mO9H45zCSVETWG7tOrua?=
 =?us-ascii?Q?oE/wTa9j7a86zb5vrwTvkyuhRQNjx7UnG+B86XkeUBMsGKtUBainZdVQcsnW?=
 =?us-ascii?Q?TUfRpKxANU1gQv5u200JJZoVy1kPH6GoKBxkma3xJsaQ5uj4QUgGrc+VUGZy?=
 =?us-ascii?Q?10hLoCXb3kiI19yRAHIyZhiu5SbJ5ykuVIOqyaROkLNubI5aJKQ8qqqRlZrF?=
 =?us-ascii?Q?lNPxgaRvnXsiAb0MlrbjaQPfsRfvtQOgVjFM8chBOyoMRrv01Oz8lUBDWJuS?=
 =?us-ascii?Q?0XZJdSu2r7z1teXkwV3YOltUqpAUDL888z1xecyFnWQ/Ai2m9uhn+HM6lJo5?=
 =?us-ascii?Q?7Lh6J2X9cvlsmnc8ySgxK1Hf+1q+y0wrofjt+0e1yRxyUJI2TSdf0uH+mKxZ?=
 =?us-ascii?Q?ayXgpzh3lXaUDg3l0pD/G6sBYsgH/eJjJwdFER31V5UwFOOOoj2Ww1ZWp71Q?=
 =?us-ascii?Q?QcSaOhLWZ/xLAG8C0Duh5DQFB7nXchenBaoqLPoY4Z6gqj5fE4Sl11xgVJDM?=
 =?us-ascii?Q?fQMbGUXelBb+z4mDrJH+LXNZJy6jPancSAmnIrngGQTe95hobV8Gqaa6jYYe?=
 =?us-ascii?Q?zbSA3eyI2547b6EHHzyeBJNlVrtOF32Ohc/Ck8oMfUrg5qhv1+RElMeqAl7x?=
 =?us-ascii?Q?2cGWZf8ylEE7t9191qrVptg3KFbwYT/4Qr6i+Y9nGQn1xY9kiH7Fkfch0WKe?=
 =?us-ascii?Q?CVWfDoYtFSZTPxjBUVkb1X7nO+f/0HqvoYC7hRblLcKkdGSYAjPwZcoBMaFm?=
 =?us-ascii?Q?fbCIvhu4RTbPKph6MBhMTIl1zgeVZyz0qCc5KV1kTY9Sa2ToVlhqS87yH2jv?=
 =?us-ascii?Q?bH6W46TjQ9tBpj6A7Wf3kJomb1PEZReTPfav0AieKt40JpTH9I3fKsHGcFPa?=
 =?us-ascii?Q?QkPHrrpmDsO5rGLOz4y52tlU7WXtBDO4EnB5o67LZ9xOS0teNZanEsZvBash?=
 =?us-ascii?Q?8GAEcp2H9oQUffSbyjfcWmxA86rlVINenflUU1o2cb7IJQiM4uHA7/97bF40?=
 =?us-ascii?Q?N53KdQFwQEyEQITqLR2ywvs6jb+xzbmzQSfTbFHNds5aHw8gOvY/r/WL+6wn?=
 =?us-ascii?Q?LIT35uBs7cOwPIKMY/a8aHVzUMR5Zd32RZJMAP6qLUqSI9xTRtW5TpF+Z8mf?=
 =?us-ascii?Q?P9Bi5slqEp2fLidmM77ZkkyiFRL5a+eIcFEWgDRjRU8BXaDb4U2kZS/p747R?=
 =?us-ascii?Q?moeDtzSPaH9RJwlKU3QoLw7/73tSKHcUnKfVgzvpdGQTSvwG9S+UQsVsAbVe?=
 =?us-ascii?Q?QXOEA1YXJdVpe8GmHCn4o9tOxtUpWCJyMu2qpZwctMlSG7gDN0KcLaW1runV?=
 =?us-ascii?Q?17iR0KqXokGWmAODzNPAReUlGCFMQC+n075cVlHA1+QkYyKVrPrPanBtJLQh?=
 =?us-ascii?Q?l4ZO2reuIO87ImcTkMXoBkdnQ9Y+Gp+ysID5/LKOz7gfPAGK+g=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GfgFn3LfgsdV/dxPhJA+fNvKBq1DCyKbVkAeouDfz2AkWXc0wpRRLxjLr3yn?=
 =?us-ascii?Q?xS9CmfxiCD4KJmWTOxCsXu7AbvEbRtJp6BSNG/b+16MKixnPwydDWndxyRI8?=
 =?us-ascii?Q?2J6oicco+8z+rjjbTHAByvfejbVK9mCUHwKRZKVvEtNs2/M0MbAuY8G3tjGz?=
 =?us-ascii?Q?0qkI+kzfijqo2l7+JBb/STEIWILoL8oF5A7KcN/JVRnk5AvqfzkHE3Kf9UKc?=
 =?us-ascii?Q?lF7+T5qUZqJt8VEsaKXsVV+qthuGX+pdJk/CqG+w8tztDufxETqFm2eFap+h?=
 =?us-ascii?Q?mRChoVNpBR08VXO7zwJYNZLfVmKop9snAy4+7VQ+otV6g+pq7J7D4ucE0gyT?=
 =?us-ascii?Q?Sv9K7jrkyGEkuu6v3BG01RqeZ01QmB/GIDPSByjLgwIfh2FQZhUOdK/9KHgA?=
 =?us-ascii?Q?A8sFOw0muHthtrF36hKYFM5HEx7TAUAimFtaTLxLksAAeeBLR1FYzdmSu9Gp?=
 =?us-ascii?Q?B7vEY2RZRWeCyqJ8OT2DXKlwYHG2H9Q7v4Z1w+aa0ajqfuJ+yfGcbKAQIgis?=
 =?us-ascii?Q?cruZEewP+l5+zOU84KGwPKyCWWiwy8zCJHJ92w/S4Z0P87TT6zTDJxNNbKgZ?=
 =?us-ascii?Q?riFC7HF9MqdjnW1+BMYXazruSihGc44g4gtLBVzr1Umq+96PTsPgyXI2S3n4?=
 =?us-ascii?Q?L4K9Pwhqehq+wLieKzCwyEv8rZt/5ugobDIlzqSOPc5Yfs0q5ehzWbb19o5n?=
 =?us-ascii?Q?QzaDIOnZimKlBpbj5aQxB0kWjyn4uXAPwHuUjxnHJ6QiF3JPEVarzjch8t9c?=
 =?us-ascii?Q?fJfov+HpKOCB5vXtmznNwTH+WNwm+C4HIDa1WA0oMr9zdJkkr81/SRFkIuqY?=
 =?us-ascii?Q?TtALK5LLivtD994Hq+/Z7KzRUg40JYSR03doNzskkM4mkRbqZNPWJwoApMjH?=
 =?us-ascii?Q?YMXk8OpfF06k6dgPRzoCMoWGJXjvvkTGBCpv60zI+MNo8hWxzyHMbELZITI3?=
 =?us-ascii?Q?l0mMesYn1xKvk6KLnjPHvAM9jveTGaWXRcG/zWGcuF2Xl7vKAWJeu1Ub69Ae?=
 =?us-ascii?Q?9GM7QKDyLNg/njh7TUIlhL3RMf8KZVdnYaPKwAkaoRbCkrkZwmJ6M57pVqDM?=
 =?us-ascii?Q?C7MNTubfkG6RtHnq7MvToBI1UoU+/aRofvSU6AiIsUtr51mJoQEulmqPnq8R?=
 =?us-ascii?Q?70CnkRX9q9ttjmYzxnucXm3uOGicxDbIzQmibph47MtDFuSASMDKZ5OHzSeL?=
 =?us-ascii?Q?cZvR3JD9WZhXgZ4LBg9hA4RPLcNhzKjShrZT2vgePTpcNnU4qouAjY06Y4Fq?=
 =?us-ascii?Q?GUtyFlAlK7HLKvmv9ahdHLuwmGoyee/mpQHcyzA2qKAzNGJrVzPPKERWYiTG?=
 =?us-ascii?Q?BcYP175Mo3DYr8q9wzdm5ImOX3fpa5PEqITd4ZvFk8la0t20nPRTqPxSiuYa?=
 =?us-ascii?Q?TbwHtWjKr0xmBJ7/xz42h6LcQK/WBnGyjRtqKClevxc9oOWB23QZuE7Pyjwi?=
 =?us-ascii?Q?fsJam0wsiog9WqAbieCWfUDx+zwea8Q/vkAHtLjsP3SocNDVXXtNuV2hMdnJ?=
 =?us-ascii?Q?Qaiig32K0Q2rxke0jIJFhUWZza7jTBWzh3SL39p4ZQQK0nhgAvW7qHitokm2?=
 =?us-ascii?Q?AaYMcg97uzu+8BqROyueAz5clS/lfyfBauUAVLXb?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a94cbbd-2e49-40c2-b7de-08dc9c8c4840
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2024 00:49:10.0963
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sZ6RhJ+mSTGWs7Q181vSp0d778kRuy5gyt81tKSqmmAj++N6/bUqXwfeR/+J2bnxEEjuwEjVrOlzCaiLbpsp0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7870
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Friday, July 5, 2024 7:19 AM
>=20
> On Thu, Jul 04, 2024 at 03:32:32PM +0800, Baolu Lu wrote:
> > On 2024/7/4 14:37, Tian, Kevin wrote:
> > > > From: Nicolin Chen<nicolinc@nvidia.com>
> > > > Sent: Thursday, July 4, 2024 1:36 PM
> > > >
> > > > On Thu, Jul 04, 2024 at 10:59:45AM +0800, Baolu Lu wrote:
> > > > > > On Tue, Jul 02, 2024 at 02:34:40PM +0800, Lu Baolu wrote:
> > > > > >
> > > > > > +enum iommu_fault_type {
> > > > > > +     IOMMU_FAULT_TYPE_HWPT_IOPF,
> > > > > > +     IOMMU_FAULT_TYPE_VIOMMU_IRQ,
> > > > > > +};
> > > > > >
> > > > > >    struct iommu_fault_alloc {
> > > > > >        __u32 size;
> > > > > >        __u32 flags;
> > > > > > +     __u32 type;  /* enum iommu_fault_type */
> > > > > >        __u32 out_fault_id;
> > > > > >        __u32 out_fault_fd;
> > > and need a new reserved field for alignment.
>=20
> Hmm, what's the reason for enforcing a 64-bit alignment to an
> all-u32 struct though? I thought we need a reserved field only
> for padding. The struct iommu_ioas_alloc has three u32 members
> for example?
>=20

yeah please ignore this comment.
