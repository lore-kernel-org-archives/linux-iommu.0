Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5A42E339D
	for <iommu@lists.linux.dev>; Wed,  5 Mar 2025 02:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741143095; cv=fail; b=R6ugVT3reJ+dF2efWh8QbT5Upespf77PcWzEA39424dE1ApHUXIIkFCi1OzuA4pLq/6+OgsayvX/M1KbX3s7sN+qCv4nx8AnKtpxhP49H8AzN/at4qX8flToNoEamdnIhwIhgwXTUaXZdz4rNONxsDx+VZPhQWWjm+Wys51jQW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741143095; c=relaxed/simple;
	bh=qKDfqPBnjhXJ1df2Qrvj6r8BLYn8/tl5oclB1C7W9BE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lserbhXg7SeKVkRNh3fjSZ80ze9FQlc32zQm2hqqhBRVwReysK9L7A1JBW17+cSWFS0e6ajW7RF7/tTjtlWp4Ucem2nz4tVnuqh4V7CybDZOAaYfJPFdkJe3sJO/I8G/cZRv0w8WdsYhAhFf1b8VGMmsIlNVN5PsAIQRO317/GI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N7c/Y3hA; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N7c/Y3hA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741143094; x=1772679094;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qKDfqPBnjhXJ1df2Qrvj6r8BLYn8/tl5oclB1C7W9BE=;
  b=N7c/Y3hAy0XlNqLMct4cp0G9xMiFD7zxhNLJ5IHVyDy2mBUUrkswzKXU
   /dCJ2rx/qtnYyGHeKPYsi7g6c2Qq64V42X60ALYp78YEzaRmfDDtMpRy5
   j3gOg905yZ7CV8C/BFrIgOWdBTYxS9f8Nkv8llWMMt9SFMPbaxPmeznva
   TnXdaRa/kUrK7waEfN6be5KwopgBEYRw+GCJpSP0mtIxpKmGBdPiwguJL
   MphebeexSNX7SpAd7NgOHLxopnpDUt2kr2uWDpP6hvkbR+cSCGEC93h6u
   Esr78/NbxsnpY8cdlMJeaMNuXCxyAqbzbCXt4lV1zC6IS+bI/q+GdzJ53
   A==;
X-CSE-ConnectionGUID: 27DGrZkdQUCetMWs5A22ow==
X-CSE-MsgGUID: GTHbulxzS/muQXF8P7evmw==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="59500088"
X-IronPort-AV: E=Sophos;i="6.14,221,1736841600"; 
   d="scan'208";a="59500088"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 18:51:33 -0800
X-CSE-ConnectionGUID: SoxulExRRdGUA54gCkjjyA==
X-CSE-MsgGUID: 9rYbnNp0RyqGvf9cscbGsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118461999"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 18:51:33 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 4 Mar 2025 18:51:32 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 4 Mar 2025 18:51:32 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 4 Mar 2025 18:51:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=njoTSON8AA0sgd3tNvhYyIG6zS0Rs3Ibhsu/ayrqEjonYOP/2oaP6tdNUZNwM6pvuTbunkCtf/dvt5Q+SjVRo43GnrH33r7cZkgCmzIEQeWlbgdUkKKTOkJcYvPa43Cl4EeyEqNOpQgNUEQ4BB1G6fPux9xwk7rfYeP+sVxyj0FfH+tjNULmK0Phzk2VRA+9uKV8/uHyDzP1ewLQ1zgU8919lTTQ4wYX0IYLWlAGRnrB8aHIKQ8DhkKcXL6nooUgHIAT2MF6U/pBDU14ajSTCNAESfrikixqLNBlZumQ744J3mICW1VY97UrURnFB5bAX9xHfIDC/COvprZiZz3G/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VHOXbXaMKOVB0PBQ5VolnNhwW6pFnwOh2S4LZvbs7Do=;
 b=dfyKFS57pwF1IaLmcB86Vvc81W6unDezQ2oQDHc65/MjhH+9Y7sLFEtOWgO/BhBNb/HjqB/l+7UVz1gsFb+s0ysn29Ct++Rhq9oERQKpvjfXQd5yIz4YgC2W2zKT08iOgnbqzzaecbuE2Dc4JzcsZgN6oVv+4bVEsYqY8l4SlvVTWERuTr2Si+lKmbGZfQLVJHzkedPtBpbb6qmIXtaliw4P1mLrMQTBWgyAMkZBxYsRX5qfFA/C0P4BPKme9iHagKkoxCnu5pNjdGmwvIl+o5/8ZJ1O0aW2Fsp/y/FztgYYDhshdKLC1NtXoEtLugYRsDrWjAq7Q1rQ9Q2M7B5vTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CO1PR11MB5107.namprd11.prod.outlook.com (2603:10b6:303:97::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Wed, 5 Mar
 2025 02:50:38 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8511.015; Wed, 5 Mar 2025
 02:50:38 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, "Liu, Yi L" <yi.l.liu@intel.com>
CC: Vasant Hegde <vasant.hegde@amd.com>, Robin Murphy <robin.murphy@arm.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "joro@8bytes.org"
	<joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>
Subject: RE: [PATCH] iommu/amd: Add Secure ATS support
Thread-Topic: [PATCH] iommu/amd: Add Secure ATS support
Thread-Index: AQHbh3UOCMVRgdan70yjYJFDyKuOHbNX8z2AgAANboCAABr8AIAApFIggAAJnQCAABasoIAAQ3owgAIlpoCAAPkEsIAAF6wAgAANLoCAAASrgIAAABIAgAMaTACAAkGVgIAAzJqAgAB9yACAANB7YA==
Date: Wed, 5 Mar 2025 02:50:38 +0000
Message-ID: <BN9PR11MB52769EFA077B3E552DA4235A8CCB2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <BN9PR11MB5276B3E410FD336A3062FA5E8CC22@BN9PR11MB5276.namprd11.prod.outlook.com>
 <4fba254e-ca47-4e7b-baf3-0228d9605c2b@amd.com>
 <BN9PR11MB52763A8885AF1678E05E8B528CCC2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <942a1a66-5c18-43e2-886e-df38cb3e7258@intel.com>
 <54db17d7-b150-4579-a33d-f1b5cc8943bc@amd.com>
 <6eb0ec90-5859-4605-8a2e-657f6f711d61@intel.com>
 <825ddadd-6770-46b5-936e-f17988534984@amd.com>
 <13e1e1d8-5870-44ea-a800-e5b25bafd344@intel.com>
 <20250303183801.GW5011@ziepe.ca>
 <2c9ef073-fee5-43c6-8932-a8cae677970e@intel.com>
 <20250304142030.GA5011@ziepe.ca>
In-Reply-To: <20250304142030.GA5011@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CO1PR11MB5107:EE_
x-ms-office365-filtering-correlation-id: 9781064c-1032-4b9d-6eea-08dd5b9082f8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?W2s10v5/GqjyAxGfkWWpOiWLp4MmMvpEr1cWUAcEk9FoYrq4g9PSmZXFCQL0?=
 =?us-ascii?Q?BjOHU6WpOBwRqmDqL8EtENFnW6YvQoYh3i7AzMiekl8FtLQKuuzidYHyUy/Z?=
 =?us-ascii?Q?qWuH1eS8uHgB9QxORSl58WJwIN7TQAffGye2tx6wbtNasUabx7jgZI5Gopzq?=
 =?us-ascii?Q?5YzbNiZ9/OsLTtgmhcb4fjQVwliYAoq0dHvjSqvJx5mOyUIRm56PotpBVkmr?=
 =?us-ascii?Q?xcBN93Lh+fo+0Ardrm8/ak8mK2x55nG2A0r0AnVmOE7l5AfBjw3XRA5kVJR9?=
 =?us-ascii?Q?FmgKoaT0VlDbdXd3LmIZOanlxfoDCtqOXdJDRc1aOjpclld1SaGtx03ijiL3?=
 =?us-ascii?Q?+0maDMN4SFKqROUalX0zw5CalBlwxPmgw34n2XhQ8K7PJNSY0gEoJxo3FlRS?=
 =?us-ascii?Q?y1oHFe46bhAi3GExPj3oAFRRPyGJKa1KM1pDiaEn1zKYrr7h7qtwGQw4jS5P?=
 =?us-ascii?Q?ZzmCIQQcuy+mdNAVo7Z9Y/KQGRV0kfVSBeYz2yzGaCxoMcRuB7JnIpswhvDF?=
 =?us-ascii?Q?ECMmZLCgusXWsP3AObk9mTSexaTC8EsT1gWRw29eKj5eLTMsIbaVJFb0v+Ek?=
 =?us-ascii?Q?d5wGBlVzbXiO0TRXkJxvir2PqMT48B7Wnjvmqo0baxoFXiTn0kpcHzAsDC8g?=
 =?us-ascii?Q?lwRZchtrZgmcuJcw5TKyXKPOGzhIu/FwB5xX+4bQ45h4uEoIddsjDIziFzsr?=
 =?us-ascii?Q?vFlRJx+ynifj82tU2C/HbmDyJWJ7vSxYvj6aM/ZyRlZozMTrAwVuD99ZUKGG?=
 =?us-ascii?Q?iRek4J6Hjo7ZVU5cVRAJV3aY1D19iqDfmTOGWk5sFwijaBHrWs2iaUdTwrTl?=
 =?us-ascii?Q?4U5KmJAwgu1FCzpS8EijjxMDLxiCIDrjSg0u5ju/r3YpofSHepJGByqb1Rdb?=
 =?us-ascii?Q?l+8pwf914QzfQwiJtyYsrbg4LNrjxjyEGRs8AJ2IWe+SEy5LkZCg1kdk9gS3?=
 =?us-ascii?Q?DMt/dnqqGbV/VVVPId4dNolS1bg0kgqYaIbfiCSdEsXEIQ9bLhtpNZWIXCqa?=
 =?us-ascii?Q?2tvXK28E9rUGc6dM9H7Gs3BbZHHLQ7gFQE1A/CrkX/XetihMmRUAcEqztEEW?=
 =?us-ascii?Q?rNPRrBcp6ybw7GtzLxNdCmQBBAOMPjg9MmHJzAMiYFs8q/YVCs0bXk/PXZB5?=
 =?us-ascii?Q?sL32iC2V66CpppVBbeiV69UNHdsPyNmA+xb0hEKJ0extemlm0xMX57X70l+z?=
 =?us-ascii?Q?pr7LRxPi8xPaxiRBf/a/zGPrw7Ihxjk0EoaNvWQa0ELNTJ27RN6VGW7exFLv?=
 =?us-ascii?Q?Y4RvgO+5en0dHiNeaLxsFL+TaPc96pzR5LbCaOL4IoQRQMGJJTozjF/NAMqd?=
 =?us-ascii?Q?iuzSGrYV9WpMNV5RqGO0bRPHMXPLhGyQsonvASo+SeUa/MIAq/LY7ZioVES3?=
 =?us-ascii?Q?Jjpj2+ugsUSvwOJ4i/ELxPXWmJ1LT2NXG8TwWM4myEGJYqnuj2wBv1nmObJI?=
 =?us-ascii?Q?NMj4Q9PuOj16lHvVUqJEplV7c3VcQZaM?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?91zer1a+zU5rsRrAs7QFAFsGUFZRNBE9Rju7OpL/3XIa7MhYALHqdlduTvNV?=
 =?us-ascii?Q?WEAydvAtSgprz9Cmnm7QRhsYrTQXhIaUuO0RBFniDyyjwmykViheTWAF7dVl?=
 =?us-ascii?Q?9y9Z3kAChf+WssmOoI/SnkMkv+IdS7UsZ7gZR3x+l72cWFyJ6WQfW6MJThp0?=
 =?us-ascii?Q?i5uFkAYCyoEuQ1UngMnH2IZi3kZOXB9jKpuEdVHzqMr5wOFaZZdWLIZM8cAw?=
 =?us-ascii?Q?GrHv4VQBfhX2sTpKYdR//yxiHGZCnsBGmtdeVYT/9VjPhdfExLEzp0PbVWct?=
 =?us-ascii?Q?MAqUoUOv68MkeeWLRUfVYnuHbtgfETTmUTYhk2UJUpbJEgYDMRekhtT29M3W?=
 =?us-ascii?Q?KrqXEvTc0T/X9QdiKAZe50GoWxuA7uSfy2ms5ZHIsMutAvYhtB+38v8ZBkd7?=
 =?us-ascii?Q?wMh5QyR9vqjuX8kGFbPfnf5iUVAp1Yn/uQoxKg8XLgOn+d8O8im4FBg2yv02?=
 =?us-ascii?Q?mFsOw0ddwOeTBLvRBkhmyyXhj4Ef9IY+Gu8Sg/LAhqEo4u4Yu83Ak+rPD32W?=
 =?us-ascii?Q?M6T1YsjCvimCohyWsUuHClDiHNoTBlVUOsYvAmz1FhPuRqqmNylwo93wjh4D?=
 =?us-ascii?Q?yAAsvLi0MYYZmM+6o1hxyUMVy/k1FHLopuUvndK5JzdbnxmFNdKo8M7ozMQs?=
 =?us-ascii?Q?bvcW6hzZY/lrhW+RX5Fy1xDbTq8HeYUhRHVvgwmzmhDFG6RN8L34EeRO1Ohh?=
 =?us-ascii?Q?I17N/0gPghnrS+G2xmsKAudCHjyHANgfHr/kMwVG33AjML03kRIAiZF2jtYW?=
 =?us-ascii?Q?FO7ssRNivZijpgc8cEZvvjQgvxXr8sDz7kLRHO9oMbeVJ8zHkSIPBrkO2cei?=
 =?us-ascii?Q?jod610bZs/VUHQYLjyBm8/HH3flJPODhyCQSrnyoAgFwIC0zptzl+ji+wEqH?=
 =?us-ascii?Q?U0aG8Tlin22v4NacT8SOtnQkHh3qSTkH8a0Iw6F3I6d1LWWgD8kSxualuygH?=
 =?us-ascii?Q?chXxNyQBCU1PfKbAdb9algE4ifMCzpUzkVglRn6aXXxtf1wyV7fv/r6zHe9Z?=
 =?us-ascii?Q?HJDzJ2vk/TXP0F1MNN9wyR0uT0VsNUJc6UjnGUQ16qYQo8RWSohOBLodwF9I?=
 =?us-ascii?Q?1qLZQ/28y9NPEvJoMfKGtAhIGe13gojX2CEGLMEt9cFkuY3bZ699SIHhekgO?=
 =?us-ascii?Q?p1gssrKCAuYTQj0LzMNJrPaOHZOW/YK5mF1NLNXhlhxYkb5uFV/o3zMpZEbI?=
 =?us-ascii?Q?RgbTARORA4x1tRoAN6Cdtr4sV62bOfEivLOjvkr8EVg2Znv9Zxao5r0LGtT2?=
 =?us-ascii?Q?A6Ulbj1y3IGZwAbLfw27Ltco9sRO2yptbFO8XtKuNKeYAgY5ILlZPYmvOigT?=
 =?us-ascii?Q?BOrPzYrg4I/tLAGp+qBT7byEt+3uTIPTa6ZfMAqORuONUuVheN1wOljBThZ1?=
 =?us-ascii?Q?CitWkmJ+qpGPgHtmoHZfzcP6m69gNMx71oGT9HENYf7anTJkG9YKB6q0YMZh?=
 =?us-ascii?Q?wOVsOHpMsyxMj1ker5Y9+EMnEAzAOugdXIK2/XFrP2H3ZobsrDHgDV7lmExo?=
 =?us-ascii?Q?OtyDgIzWq9EsZIBjVzx+4rDY3W4RZZ1zhLVk647G2y7EBtdpMMmsY04QE8IH?=
 =?us-ascii?Q?YLY2YAovuysKXcdCrF+SmtOblKAB6HXXV4hmOdGb?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9781064c-1032-4b9d-6eea-08dd5b9082f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2025 02:50:38.6966
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ygrvyrINghzLCE/7+dfD2fZE+qMcqFqO/l/E8/B91yihG0qpKc33hYSnv/a/G4+xZEDVnRm11KQphuifoNcX7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5107
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@ziepe.ca>
> Sent: Tuesday, March 4, 2025 10:21 PM
>=20
> On Tue, Mar 04, 2025 at 02:50:19PM +0800, Yi Liu wrote:
>=20
> > > ARM enables ATS when a PAGING translation is set on the RID or any
> > > PASID is used. Otherwise it is off, eg for RID =3D IDENTITY
> > >
> > > This seems like a reasonable thing to do to me..
> >
> > will it affect Baolu's above refactoring [1]? :(
>=20
> I think no, but when we get some conclusion how ATS should work I'd
> expect all IOMMU drivers to align
>=20
> > >   never
> > >   always
> > >   paging-only
> >
> > this can be considered policy to the existing ATS. curious, why paging
> > domain is special here?
>=20
> Using ATS with an IDENTITY translation is not a performance win, so
> you'd probably want to turn it off in that case.
>=20

Probably we may also need separate policy between unmanaged and
dma types. In some scenarios the user may care more about potential
ATS attacks from userspace drivers but not kernel drivers. In that case
disabling secure ats for kernel drivers would avoid unnecessary cost
of address audit.
