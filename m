Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10566E612
	for <iommu@lists.linux.dev>; Fri, 24 May 2024 05:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716528415; cv=fail; b=N7IfRVQ/8BMOl8Z1Uf3KedcG0ahd4P3i8am+nKSwkgcZlJDd+T+b2R8BnwlFRmYwNvsk9ouDzx9ItLhy6nzrSsTj/n5Qc03PlYTgx/pHUrR/d6w3j1REq580TbfXZ7yNYcWlmigUKxWLzt2NyddhV/8rFzLrs0BqjCqv9u2RhNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716528415; c=relaxed/simple;
	bh=2m7jdZF+Cfnua4KMHR2Rvo6TQv8iBiVfbaDUFKW7GXk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gqAT72xvVkcXSycN+GcZonjoLYZjBn2zJXNe3H0xK5+gIylaNkb+2tKHcOHNYv7b4J1Y5CRyKftO039wS1QN+F3N0JsBH+4tMrGJ2vts5gTBN/u+qyNZJGN6BZqlJgywvmO8PBwuXmtU28qs4SOzDTB3CXdCRsTkL2b6Ja0fpZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kNwclHHP; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kNwclHHP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716528413; x=1748064413;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2m7jdZF+Cfnua4KMHR2Rvo6TQv8iBiVfbaDUFKW7GXk=;
  b=kNwclHHPPfhsDS5mmunIh7ae6yQZw1u3ZALEZlIEUMJqvbMAyXqyxIga
   8NH6NEUR+nIhe0DhE/v5rbwhozcufUcYiqTMP9wFRzpCJX0jLoFlmSnxt
   BldqadWiihw+zksJhaDXBSg3X7ceeHQ+VVCrJ3UU5zhfGa5dkUmDQWDTb
   dWWsRYrRbmDCpyF/cqYnYV2K8T3G6pDja9F1rigaHF4fIqmO8+BhG/BkE
   GQbAAhCoWqXoNPboCd90ovpyhc0tfNjYr8TdEobLfosYEKRZLuT/nTGvG
   I9r/ucMYXJ9+DN+/EQedQMXgHkfaHVpOKq03DcUZ7+oxODQRf9V4abJuL
   Q==;
X-CSE-ConnectionGUID: /htgU3lyQR+2kqV8o7TCsA==
X-CSE-MsgGUID: x1hC3vevRu+Lm1BRW6ww6w==
X-IronPort-AV: E=McAfee;i="6600,9927,11081"; a="12829153"
X-IronPort-AV: E=Sophos;i="6.08,184,1712646000"; 
   d="scan'208";a="12829153"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2024 22:26:53 -0700
X-CSE-ConnectionGUID: LHYZBScySJ6svrTzUK0Jlg==
X-CSE-MsgGUID: qexhPmhVRZ2/w0yeyBkCQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,184,1712646000"; 
   d="scan'208";a="64724889"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 May 2024 22:26:53 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 23 May 2024 22:26:53 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 23 May 2024 22:26:53 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 23 May 2024 22:26:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JLUin0xh5tZ4uquV9aYz/U6qAmvKaNFgZ9q32DTnn6VXLixGL5zSiSOO11H7Px8UDaCBId1xfJsxOk7jKQR9d5S81xVVZ590jwAGi1BoEi4r8QJcDwZ9+6o5jlo6/ePKcT0iC8YybDD4ul4gkKqzYMXLtscKdUQ8VK8JgCZJsmWx5vboY7ykbKaIc+a1FLzKwq6ig/fnVt0EW/JcVqsguCfGY7UTl9o+op6SgADQg5ExJwfpCNwu2Ni5pevRSV1Yzkhn4am81x7uPIrh4pfbfj7cOglrl/MK78o2v6FSPrsGlqOxho8nUvbIqbEIPFA5z6EdDedG9GXgfkNktiC1iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tE2utJy3WTeFyLX0oqRlgKcrsPcOxZOn3VrfWoywnCw=;
 b=QcO2wtJ7HWzsfboShLPTewJ1450P2PsNYxU02aLFMUT+EL24sxv8sXK25sqKTAhEqB1ZMoNQiLeznDdIE8fuXgXyIFfj37ALmbvZmJeTbUIegHTaofHiYFVuOnPpDvyaGYKgmObso8ynvBZZkMt+MtBqS5tKOxJ3PEos/GUesOnpNDyr9vXSWrSRA8jkxq820B+wglxzKHnYI/unlVjkkJjIE7ys8N4WsyEGCXkAgEbwdqlzhBZkta5XyMKPD5cVaDbytPGB0ObGlPmGbToEIOaVrXQLFTS7GlbmhNHeS+UNa74NweJCeWHE2o40AOHaDYJBRwkZsM8hi8oi6cZ+mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH7PR11MB8275.namprd11.prod.outlook.com (2603:10b6:510:1ae::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Fri, 24 May
 2024 05:26:50 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.7611.016; Fri, 24 May 2024
 05:26:50 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: Jason Gunthorpe <jgg@nvidia.com>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"joro@8bytes.org" <joro@8bytes.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>, "vasant.hegde@amd.com"
	<vasant.hegde@amd.com>, "jon.grimm@amd.com" <jon.grimm@amd.com>,
	"santosh.shukla@amd.com" <santosh.shukla@amd.com>, "Dhaval.Giani@amd.com"
	<Dhaval.Giani@amd.com>, "shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>
Subject: RE: [PATCH RFCv1 12/14] iommufd: Add IOMMUFD_OBJ_VQUEUE and
 IOMMUFD_CMD_VQUEUE_ALLOC
Thread-Topic: [PATCH RFCv1 12/14] iommufd: Add IOMMUFD_OBJ_VQUEUE and
 IOMMUFD_CMD_VQUEUE_ALLOC
Thread-Index: AQHajVVtTIyOrzFsYEOvw2C4tndA2rGT4ByAgBDBXkCAAW1WgIAAC77w
Date: Fri, 24 May 2024 05:26:50 +0000
Message-ID: <BN9PR11MB527672C2366F7F6DCA33FD948CF52@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1712978212.git.nicolinc@nvidia.com>
 <b0ee53af3f59602834e67ddf86c748ca304da175.1712978213.git.nicolinc@nvidia.com>
 <ZkDZ/YO0jqZOlRtA@nvidia.com>
 <BN9PR11MB527668B2398FE65771A429D08CF42@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZlAao39Zc+9moEDP@nvidia.com>
In-Reply-To: <ZlAao39Zc+9moEDP@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH7PR11MB8275:EE_
x-ms-office365-filtering-correlation-id: 702ad153-ec38-4685-7f9a-08dc7bb21d58
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?nN9Yy/Byt8LB984Zm0lODpjrLi71/V8W4uIR65W5SMHePHxYhvD1VRcEYQM9?=
 =?us-ascii?Q?Ce3FJUHVVKRj8OPaicCmUmkK7fWkc8nuXJDxd2WFI8hr3QLbeD7/D/vSCCRG?=
 =?us-ascii?Q?r29IAaY4LpUGzW/QHjpME9zakHYCPLTPZzbxw+vWBwmUoNWCbOwq2/7GaTdc?=
 =?us-ascii?Q?sjsBLjmAIxow+B07zRFF2s0F7TPrKV0+sSK1e2SXipYdZUIuqnzoGDgd2D2n?=
 =?us-ascii?Q?8E4xkGvRxC718pW56orOgZ4Y9nGLfesOgs4kcjuXsswY+1+XDK9XF3Rt/zsH?=
 =?us-ascii?Q?XzB5hCVyaF+Zk81Rfgiy/N71pSr0UeLJUeG7cEMtIaYGqpz8r6mklA8mD9uM?=
 =?us-ascii?Q?u7AnVXegLeuASCsxu5tucqdVGqJG4ffDtAhTMzqGV+ksB3mD4Odt0jU76pM5?=
 =?us-ascii?Q?IBXyDMfZUVra43uursU73Mv+sEeM2eLGaHvX9bGHQzJ0dG42v29K2X1Pkr/Z?=
 =?us-ascii?Q?Bse36jBcuuMNkvEAKN+KMo1IfQ6NBB/7Trldb3AHXHkuLKzX4hJW/6th+YzC?=
 =?us-ascii?Q?1wpQFUQoRXfT19OicBBfvgly3m08eLTHuSW3nhTQV4LmEbmo3uLb9eyu10mo?=
 =?us-ascii?Q?bvGdzeHhcw2dXLyfLu/LhuoFozpIzq6B6jSu98/mxegKVGfErHicifzimgBi?=
 =?us-ascii?Q?z6YfxQ9MgJyM3ePhM7xz2Gg70qyT/UpUIir5yQhK2S7Z46H55L10RuQFFSPU?=
 =?us-ascii?Q?8mJYTyDKVI2+5b9B7wXp5ESSJSKvIYoUXrZ+DEKR08a6tFBHXKOyglPteBHm?=
 =?us-ascii?Q?4lMJUdDZChIMmqHmwUPcX0oa0DdoNRDfxLYxnFf7F1/7kTuqgGyWr7M+H9+4?=
 =?us-ascii?Q?5EdHDD9/NZIJgVxF2wjc1Mzn6Pqv7EjQEsRCxOR8Wixj+o0zvF/mOG9Qv+Xx?=
 =?us-ascii?Q?Ncna74PDZDTK9uEHqUrGye8Sii0o3VqFKLxLi4XidG6DFzRqdnv234QUIlZC?=
 =?us-ascii?Q?iOuVv18/Y7vWrh0YMAIkIBqmBItpKBBIQql9gbBo9PU2aH1lXUOvUdpp20eu?=
 =?us-ascii?Q?BGHZesHUnOOUFq+zCwxwmkiwMSymJ5C09/5jj5GvDJFlDQ12gdwS5rsmAgiN?=
 =?us-ascii?Q?gUYKO6V0lP4+cZJu81VY4wVxSQ514W4MHp1Dx0z1bhA6VCzHIH/qhEXcWwSS?=
 =?us-ascii?Q?VYtiqZl+K7iiYjClEhgwUujBtvQ+rv3oBMj6Wn0NaUyVETwwKSnlJ6ue9iig?=
 =?us-ascii?Q?7nu/ZdvgLP6eJQIvMNwsOCnAsq77eIzx1gnZW2VqfDh47dAmC9Szz6o22qR/?=
 =?us-ascii?Q?5KUaWE9w7IVPgoN0ddF46opBy8HT3KuRjcUz1UTQpFKNg1Kbv+DO3sFioQI9?=
 =?us-ascii?Q?6svYBcDG5x9dJAFTscuZOlRZC8jyS1n8jxVjj+Te+ZjEtQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?s/kVAplEobrQBmySXqXo1aKIl9RUxkcyHkYanMUtgtVZH/Q4SmDZHRd8b9Qx?=
 =?us-ascii?Q?nt04bsrl5e0IpYIYUAPd3FHoy0pmYa+CLApqVz88+YS6jQwd3WCmf+67ucWc?=
 =?us-ascii?Q?7PFUCQYmlrFYmdrxmuDQ6Fuzkcz1nBqHQvb/skIi2M64tVF8Q6KHlpRLdnV1?=
 =?us-ascii?Q?Mk0yQvo9BPwAqYwLmLXshX1a9EdH4th6E1/4wPQUdBvlmy0rSExNDVuDY4J+?=
 =?us-ascii?Q?l3aDKbugBJxdodnanG8REFfLwAycikM8x1CrXMRz/Dq1m5jYVC0y1MzrKTGP?=
 =?us-ascii?Q?U1yZNb+pKr20PwHugeVfb1P1mRxY9lpOrR8X+e3e0RFeBY0t3bL4QslRiqyK?=
 =?us-ascii?Q?61KNzK8//rdR6Oh8wG8SZLN/CXtkSNYVYb7hygvs1I8YaM+BVm2R0F6RqoBw?=
 =?us-ascii?Q?qUmU/FGR00eyaB2Gt50KHPbh6quNLh6vgzHOHyPCskd4MIgQDcC9N0jHPRKM?=
 =?us-ascii?Q?avpPkxetA1pppMQnT8BNj4iwcZEy2QHxbMv2oEEROZRYZ3qO/qE/9xsYNex9?=
 =?us-ascii?Q?h3b0J7oVUPbNZYciJMH4dl637nmFT+0L7QzJgYjL2XKMWReXAU7CcR5SXPtL?=
 =?us-ascii?Q?nFeBXkPBIZVY96M+1Uh8NhMgi2ov/ixVbvKoPdNzGmFU4G/q4RlFwzm+3VuE?=
 =?us-ascii?Q?ESjdoWyjdQCEwB70barUJiODlBup1PneuV85OoDiffXsRz9S32fCYwsnGyfX?=
 =?us-ascii?Q?ogjHCrhUzCLtaUFqVDSD5ByPxJm+XIUKO4Lg8wW5sjk6DajutNQte6mg3NsA?=
 =?us-ascii?Q?mVFRBPYDiltS9hEhTpI7n9x0Z6cmw209UlBSc2ulxavXxJXr8OY7pLrMkU20?=
 =?us-ascii?Q?LKMScsI9HSMzLK3NVwBiMNOX1boW2qrlSIMIbkcQG4QpVCwmEG2VXEVxOXbA?=
 =?us-ascii?Q?0Ahhw1J7Z1KeqtM9FCoC42e4ozQenyEezS52l5YlvojGMM95iDW/qSnNMuKv?=
 =?us-ascii?Q?CHYwwkpkb4uNpj2I9g9o9GJxBqqz1cvceghmhZf/RfaDnazCu/VG8jmhbDhf?=
 =?us-ascii?Q?WPm5cpC67AsjNFi8EvMOodgWQJPGFH9QxJhQrJw7AERD307YhDC2Aobe2ENp?=
 =?us-ascii?Q?PhHDjPqGAvjcongzJhFyWp5byCMBCO1cW+TqE1ncm9/x19dwPX3ylrnuJYXz?=
 =?us-ascii?Q?8WHVa90RGtiZUY1itUMb6jhU5OzrM7o5JO+Tk6GSJr05TCUpzKgKUsi3AJOj?=
 =?us-ascii?Q?pwXzDjneSFvojrGVFLhHtxx+9yubz8c2+JGSYzOjf6H2J5mvJXzZUd4YSJk6?=
 =?us-ascii?Q?2zGplgQWTLXG6p+A6GhrCOOMJetKO+8qLZ1piOzMDQEqHYQSL977W2MaEUC0?=
 =?us-ascii?Q?jfd5eGhRghEeSBZ39W5ydzQOa3I+62fw0zCriEoqhVQsdwUmR6iWsMDVm4ws?=
 =?us-ascii?Q?MfBAWVBMSRChTIzlb2eWd3gP+CmpWtY9LekR4AxYeLSKGd5nehIwF6lOeGtF?=
 =?us-ascii?Q?Dj+zmivFIicVGrh9mGAMqn45QHnleqlOGKQxqD2BjU6H9O4ynlT5NMuw2Bvi?=
 =?us-ascii?Q?YNX/IEalmXIRbB+ytVGzJe6MAVMDHxnDAL4TSj4Dtc2712FczR9gnYsh/R5R?=
 =?us-ascii?Q?QDjC+7fKZVztoAZqgtmBMykrY/aUFiwTWSMp8EyZ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 702ad153-ec38-4685-7f9a-08dc7bb21d58
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2024 05:26:50.6452
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oOHzCux32tWobWx4ujz4yQ5GYP3nBXBTqjAvpg58+pwpfpaotmJ9FgRzgodrKIGjtCGkVkbwpZrDxM4xl3LXvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8275
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Friday, May 24, 2024 12:42 PM
>=20
> On Thu, May 23, 2024 at 06:57:15AM +0000, Tian, Kevin wrote:
> > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > Sent: Sunday, May 12, 2024 11:02 PM
> > >
> > > On Fri, Apr 12, 2024 at 08:47:09PM -0700, Nicolin Chen wrote:
> > >
> > > > +/**
> > > > + * struct iommu_vqueue_alloc - ioctl(IOMMU_VQUEUE_ALLOC)
> > > > + * @size: sizeof(struct iommu_vqueue_alloc)
> > > > + * @flags: Must be 0
> > > > + * @viommu_id: viommu ID to associate the virtual queue with
> > > > + * @out_vqueue_id: The ID of the new virtual queue
> > > > + * @data_type: One of enum iommu_vqueue_data_type
> > > > + * @data_len: Length of the type specific data
> > > > + * @data_uptr: User pointer to the type specific data
> > > > + *
> > > > + * Allocate an virtual queue object for driver-specific HW-acceler=
ated
> > > queue
> > > > + */
> > > > +
> > > > +struct iommu_vqueue_alloc {
> > > > +   __u32 size;
> > > > +   __u32 flags;
> > > > +   __u32 viommu_id;
> > > > +   __u32 out_vqueue_id;
> > > > +   __u32 data_type;
> > > > +   __u32 data_len;
> > > > +   __aligned_u64 data_uptr;
> > >
> > > Some of the iommus will want an IPA here not a user pointer. I think
> > > it is fine API wise, we'd just add a flag to indicate data_uptr is an
> > > IPA.
> > >
> >
> > Presumably each driver will create its own type data which can
> > include any IPA field as vcmdq_base in this patch?
>=20
> You mean putting a base address field in this common vqueue
> structure? Hmm, I think we could, assuming every queue must
> have a set of base and size info in the guest level.
>=20

We could, but my original point was just that it's confusing to
change the meaning of data_uptr. Let's stick it to be driver defined
data and any driver-specific IPA field is defined in that data.

Of course if we think the base address is common enough it can
be moved to the common vqueue structure too.
