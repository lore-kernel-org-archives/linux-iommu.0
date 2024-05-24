Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B216F8F5A
	for <iommu@lists.linux.dev>; Fri, 24 May 2024 07:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716534827; cv=fail; b=Ez1YzQBn9AxgACG58N/PiObIxsXh1n2dkNfEMgaOjc6bgu3hTyfkSKGNQf1jF2qS4SjHMOiitMsMnau1jgS//qh1lpvtCdXECjs++myxAmnadqFd0lzALyyRakZlfLcxMk1BJxUmvxouhHqQwwO90o+yqR/5Hj3b14MjaQbRVbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716534827; c=relaxed/simple;
	bh=CwvGq9lDXmrN8qhYCNguNDxMy8wDGhfX3ShHE+PV1qI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=T8ZclmPJ3wnuPS/WCfutVibjw2JZnndys3WbY98u4C689yGfV7CjnotQUNOezOsRBwTBUJAX/7IANccSy6dAvtvT+Ixb8yZYf0GC0tshtPiacW6eIynaeSxiqja8nTzta18IBHgZJeyQpumi7NtASMtGIBCE9dvdCEzGMLaHLWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W3/I0TEK; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W3/I0TEK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716534825; x=1748070825;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CwvGq9lDXmrN8qhYCNguNDxMy8wDGhfX3ShHE+PV1qI=;
  b=W3/I0TEKJbEKDQRJdiWfBr3qchSIVyCuPPyGF1HuKdk3DA6Baoh4iP3c
   LLMNKcsCKiTrHjHpYZZxSfE4+1vBafasPF4SXoRRo4JnUedjy02Psb1D3
   fRse3l4CZ9Ce5V2t8DPcUE/whrtYW5s+c7AiCTtdJFtKVpYceKOlr2gUE
   d8A1x5ReOJOj5iugvNV0rO8mgob10h3ukIFEIDIbV0hqN1h+ZBNzn7VND
   rxrW3Rj710RYVtxcUWWN/bu5FflrzaK1pL+HfF/E/HvfbZ8P/6o3UJP5C
   BpzLJmJtIO484Lprsv6lxBOV8KDW0QdBsJLJWWuexo6CD65UIdS2V7avh
   g==;
X-CSE-ConnectionGUID: V9qDZDsLTlqQPdlpkDNtnw==
X-CSE-MsgGUID: MEt7nDl4T4qGEJDqTkYrYw==
X-IronPort-AV: E=McAfee;i="6600,9927,11081"; a="12773303"
X-IronPort-AV: E=Sophos;i="6.08,184,1712646000"; 
   d="scan'208";a="12773303"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2024 00:13:44 -0700
X-CSE-ConnectionGUID: ytQpDNEgRwSRXuTAEgpFtw==
X-CSE-MsgGUID: 5TTeWBiaQi2R11c4Zh0Z8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,184,1712646000"; 
   d="scan'208";a="38788252"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 May 2024 00:13:44 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 24 May 2024 00:13:43 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 24 May 2024 00:13:43 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 24 May 2024 00:13:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vh5aKDb2f5Bxt5V8FZL5N7yvl6B+ByFbCapsT66UDM95L+xsBjlzngrJkAy0bcN/yQM0TdSCygGhoqOgb0evYeZ2wmzgzihtnSVhd4srykrTNoeSoCrBjJvpFi0rTSdERM9DuQ+P1Taf3dX0QXgvl+vKyGSdafMxNFbxqGimp7WZ46tFtumwNo6gFeKs+nBGwJpaQ1jwESmkH02cOir3nmMjcYeUtJIDOvV86RpCeOBkmaM2n0fS1RwrBKN1K6NnetRUnuL9Hkon475/f9vPrFkPII1plJU9VOt9ln1taX/+cPJwUjzw6gsKWT2Pd3S3LLDuFcdCa1F9s30REyGmlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LtowGOEWuM6ezxlapkIxLoYiA+LMP5Sv6tcZ10Hy8Co=;
 b=dlZMPKLWuqoEQLR5xZ/qO6Pi64ZpStaizaKdi14/L8Mur8KqPlJ1nIKVa/6w1uC7MG8+i3YYEYKXg2OuUF0TL1iOJJqUZXwcVFuvTUyELl74TGoFAyB+0sueFb8QdcWg0A1qldN+xhORtAprDRtKrLYBu6e4gIE8/tKjAYUwcjh+1v2fvRL0ZTn3UxRP2WvU12k00cqj0xJ7woTBhy7Pue/L6W1+3rExfNZvCkAvh5GzoeS94Xmy0LkuT+l1Q/2JGtyyWahIw4OtM8ieDoz1Bn7yx5Yj/YOIgTARYxbe6z6i32EuwD6wiksDfTpdfFrEcE5xaaZOmTpyjj6TebIE1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MN6PR11MB8244.namprd11.prod.outlook.com (2603:10b6:208:470::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Fri, 24 May
 2024 07:13:24 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.7611.016; Fri, 24 May 2024
 07:13:23 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "jgg@nvidia.com" <jgg@nvidia.com>
CC: "will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "suravee.suthikulpanit@amd.com"
	<suravee.suthikulpanit@amd.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>, "vasant.hegde@amd.com"
	<vasant.hegde@amd.com>, "jon.grimm@amd.com" <jon.grimm@amd.com>,
	"santosh.shukla@amd.com" <santosh.shukla@amd.com>, "Dhaval.Giani@amd.com"
	<Dhaval.Giani@amd.com>, "shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>
Subject: RE: [PATCH RFCv1 08/14] iommufd: Add IOMMU_VIOMMU_SET_DEV_ID ioctl
Thread-Topic: [PATCH RFCv1 08/14] iommufd: Add IOMMU_VIOMMU_SET_DEV_ID ioctl
Thread-Index: AQHajVVl26WkVBqVE0qDV+tml8yTY7Gkmr6AgAGEQoCAABbGEA==
Date: Fri, 24 May 2024 07:13:23 +0000
Message-ID: <BN9PR11MB52762A0BC67B64D4171480C78CF52@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1712978212.git.nicolinc@nvidia.com>
 <c97a98a72ee3498c587e5898d6b899553ccd9b27.1712978212.git.nicolinc@nvidia.com>
 <BN9PR11MB5276A897A5386DFAC9A35F9D8CF42@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZlAoN3s96HL7ROth@nvidia.com>
In-Reply-To: <ZlAoN3s96HL7ROth@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MN6PR11MB8244:EE_
x-ms-office365-filtering-correlation-id: 5634cbfe-bd2f-45bb-1191-08dc7bc0ffd1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|7416005|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?RooIVLcZ/g4rqIeSCzuoSZQ1PBmTj9j7xfQILSEVumBuFj81b5VpjPjkQeqF?=
 =?us-ascii?Q?uzCNYt99+0iXYsB7HzWJtNbfeggAaHpMJYBiB7RK7JGlL3r7IRBr7my1iyAg?=
 =?us-ascii?Q?v3qujRicMoQUGeqbsuwuwP0nASAZtTUxJphLV54joguPXYD+klHfq+bI5S/f?=
 =?us-ascii?Q?AwdbPOoWPgGCyeOuSpHv+PgS51VKbHhAAYTapPjjP2VYmBVvJ4c+fk2Q1hGO?=
 =?us-ascii?Q?8wU7eGjSrRaUhzsKNdLcu5DhK5UKe4Bl1TKEnVoayJ/dSk0yqTgwBT5sUNCZ?=
 =?us-ascii?Q?vb/VHXCspoP8pRadsbiW3mWPB3Xmv7OiPAUg00I8un6RI/pfg2JfK0VwH8iy?=
 =?us-ascii?Q?8E4y71I7sQBXCCqCGSGZ8M5QYUhw/SmKdmFEeVnSR+eBcOZtW/0F+EVLyA/P?=
 =?us-ascii?Q?ouCwf0/W0rxZoWV4TL9Fvw16Lu4gAeTsRhNI3g5gWPtpk3S0gtzxwmvA0cHI?=
 =?us-ascii?Q?aYcS/NwE3U5P0oVb1cT+Cy5ZOHayLZPkIYHTnPLxa3hxhUUBqYqaeTcwuuD8?=
 =?us-ascii?Q?Ki9ObgolidDmF2XpBormc1UiA7/F9pPXUMpEXBAi74qkaK/Hhb3XQWCLe5El?=
 =?us-ascii?Q?GcgQXAIc3pdV0fdSsTzXZYe9SX9SeXYW+BpCL9Ky0cnxE3icgI6lWgbxskfN?=
 =?us-ascii?Q?Zhaz2BqeK4ClwaYSP1TOtBvXb7UryXqMGnlWNoTh8yHHSuulGDRR/oqAfIJ4?=
 =?us-ascii?Q?d+sQdoDHJX+4YmvoAKf2V3tpd/zS4H5hal8KWhLURChlYCVsa9PmK8UI0x6w?=
 =?us-ascii?Q?4oQzRpiXBX6oMOjxtpNzhzvI4wuE3x4xyi+DilPDZkCzEksabu/QEVXVvioq?=
 =?us-ascii?Q?M6WwhYnwcVNJSMrsoWNA6OyPJ4KUNUeHqPY897n59lFuEXGyAFPu9nkcaZuU?=
 =?us-ascii?Q?IIz0v12zT+VawtpZzPwJuAJz/ePWXiIx0WwdktaXUP3OawLyMbKC536oCR9c?=
 =?us-ascii?Q?FHzzt+Ti2mid5w9mnQUBweV1BBtv6WkX2cB4RP5ZcX/uqqEnPGsNyGbnfLdX?=
 =?us-ascii?Q?YtvwtMowO8SaU6qLspNJ/HyXz4hLhjJkIOsQj+MsAbufKWlmeCrnbzQF2wp0?=
 =?us-ascii?Q?HegXwnBEPheL8RXLHCZBmXbilGbYzzV3LxDAVE+z5u1ms5EK8mfKh0DOXxCT?=
 =?us-ascii?Q?yFXvbYSCDwRt15IIS5X7WEUfqGYBLNTxQirZ7iEDxTPaAgAm3r5Ca3jhdV9A?=
 =?us-ascii?Q?j5b/VjHf6K2/iRw3Lxbr0HoLpnqNEnJF5qFsDRtpWZ4M865PVJ3KYGFbgpf0?=
 =?us-ascii?Q?KCjSiSzDwiyWDnxy0r7AhMKoQ3XcWzuAq3phkVGBlSXDGCDPBtrRlVG3gCUe?=
 =?us-ascii?Q?HF8N+v+0lK4TKHpxwB3gPl6F?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hgJw9xeNZFfpJou7CRYYF2E9PZgofVzJ59DCY8Wwvn13SgzzpyxpfGNRNy1w?=
 =?us-ascii?Q?cGsd2/TdadiMLBuRBPwygBdJNu+UxebJFk+YVgWd30Fozmu3FAQi9lHalM7E?=
 =?us-ascii?Q?TQJ8dmzqkqgUcm9Ucal7YYkjGG2kUJSUbgePaNgEj6oMux9wJRMmslZBvYTl?=
 =?us-ascii?Q?KMvWkzxwlofQ6eosIe0ogZ/G2O28SnPpJ6F77aQKpmPK5/wyNaHyhrDF7Emo?=
 =?us-ascii?Q?egqrlcvgedax0qO8zje+grEkOBXq5PktNBya2WOLgGuO/RgTAPYJ8T7cP1+f?=
 =?us-ascii?Q?FwPPS2jzOO4eg5wEnR8jwhW6wPvoSQS3hoxMN/uCj5xzpf4jON2pzWp3Vp7k?=
 =?us-ascii?Q?3H2o+YvySjglv6X/JIZvxR1J5YY4LfxdYJzTe1w84GyykQoGsZkqvl5u2UKh?=
 =?us-ascii?Q?S3ipO0IRb2NAOkBo8K9fDCka3M51fR+OGxg5Qwxi3LR5quPwjU84pcUmxbef?=
 =?us-ascii?Q?xHvvnL0WVeHzhvmK/YYqjX7xQL82MNapuCTxmZ6IMKPXJ5a6l8PNoojpVD/d?=
 =?us-ascii?Q?E1DXZWiuStlZ8Y4lJRFLU31JC+QLB5V5Z/S8rQXpyPHsAM00C3Vsq4Mci2Rk?=
 =?us-ascii?Q?hsTnTzjMEenJu2YUepN+CYSgFAEL13tNCZshra1aAMNx7uHGUIKXweifCvmp?=
 =?us-ascii?Q?lEQcR4NCAZxJAw5RFZo6/Zkhmmd5HaYXGlNJCVwLUKd1gXM/MB5bu0+arMGV?=
 =?us-ascii?Q?2aOpJmGk7xqXR4eid17AJArBNT6lB/bypGFe4oGIrS22Dkh16gGAQxALc3aR?=
 =?us-ascii?Q?jZqZOFTBghKQ2KHcuSi5vOrSwNiyP8uhme0nM/YartD/SBNbG0n4BvTXIGv1?=
 =?us-ascii?Q?nF91GEQoFMhtvZozhnAvhNkAVolOupDjrJxGUH3rNlxq/HuyvtFFVtO1oKmI?=
 =?us-ascii?Q?rJH/uc2CHp7i3/TLTNWV0n/JwJ6+olG0xahJ0EjDyLLoGLDp3xn+BMG8iYKz?=
 =?us-ascii?Q?KIvwjThRMq7jobcxoa98afc0DRDns9QsyUqQ5j+HpgDlpbZjHfMaXfLKLIIh?=
 =?us-ascii?Q?9ON+lNSzC8zloBuvqYtYSsyzNeV8hZUGCRlNqA9YL/7G9ds6/tCcGIeZxo8l?=
 =?us-ascii?Q?Ttg7TpYiVpr1D5NbIH92z3B67zjarCfxu05yG2j37rrzlwOkW6uvIIkGbah2?=
 =?us-ascii?Q?H2yqlkkqN6OBQ8oKjS2Trj4T64Q/bND/aIO2YHn3DXGeCdmNAsZApV7GEfeN?=
 =?us-ascii?Q?xHqx7v87OgsH293gx4e/N1s6AL9wD7L2cQkjz8c8L/09BSYDeP18jjQzrWWZ?=
 =?us-ascii?Q?2foWZD3qKbvoAGY1S+TKM7ILy1WzvneTAMgtQHYQ1GOGx8AQ8yTFxb3IUWhI?=
 =?us-ascii?Q?6Fdl/5quws5vPNTjH2xp0qw8nDVOTQzQbjEt5vvr0DVFjL0wqbamr8XKYSnw?=
 =?us-ascii?Q?n0QiPxmlvYQYgWWhKHacTR+uBsWA4BfG3yC1EdBld/QPGVpLRoC++aC5ZdfY?=
 =?us-ascii?Q?8d9XkeAb1NegqMnGEsp1TNCWd5DAcR67cuIHGaSwFCTzcrZ2R8gPoc1AZmWC?=
 =?us-ascii?Q?6rds1fLHR9ZQgJeKrqVlbFfPvdmE5Dw8LnSU/XTBkKPxkBfUQw1mWESew+xM?=
 =?us-ascii?Q?td4hpCJL+3pd6zCmHoIwbcIuDIwsW5yVHYy4qJHP?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5634cbfe-bd2f-45bb-1191-08dc7bc0ffd1
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2024 07:13:23.5194
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 43Ncx6yk2M1jsVB8yhRiQ++6txvqjFBaGOKxXDMD5caQZDmO1zKX/1yuwxpO2KEnUzCl1MfRkov2OxUDuDzPGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8244
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Friday, May 24, 2024 1:40 PM
>=20
> On Thu, May 23, 2024 at 06:42:56AM +0000, Tian, Kevin wrote:
> > btw there is a check in the following code:
> >
> > +       if (viommu->iommu_dev !=3D idev->dev->iommu->iommu_dev) {
> > +               rc =3D -EINVAL;
> > +               goto out_put_viommu;
> > +       }
> >
> > I vaguely remember an earlier discussion about multiple vSMMU instances
> > following the physical SMMU topology, but don't quite recall the exact
> > reason.
> >
> > What is the actual technical obstacle prohibiting one to put multiple
> > VCMDQ's from different SMMU's into one vIOMMU instance?
>=20
> Because a VCMDQ passthrough involves a direct mmap of a HW MMIO
> page to the guest-level MMIO region. The MMIO page provides the
> read/write of queue's head and tail indexes.
>=20
> With a single pSMMU and a single vSMMU, it's simply 1:1 mapping.
>=20
> With a multi-pSMMU and a single vSMMU, the single vSMMU will see
> one guest-level MMIO region backed by multiple physical pages.
> Since we are talking about MMIO, technically it cannot select the
> corresponding MMIO page to the device, not to mention we don't
> really want VMM to involve, i.e. no VM exist, when using VCMDQ.

can a vSMMU report to support multiple CMDQ's then there are
several MMIO regions each mapped to a different backend VCMDQ?

but I guess even if it's supported there is still a problem describing
the association between assigned devices and the CMDQ's of the
single vIOMMU instance. On bare metal a feature of multiple CMDQ
is more for load-balancing so there won't be a fixed association
between CMDQ/device. But the fixed association exists if we mixes
multiple VCMDQ's in a single vIOMMU instance then there may
lack of a way in spec to describe it.

>=20
> So, there must be some kind of multi-instanced carriers to hold
> those MMIO pages, by attaching devices behind different pSMMUs to
> corresponding carriers. And today we have VIOMMU as the carrier.
>=20
> One step back, even without VCMDQ feature, a multi-pSMMU setup
> will have multiple viommus (with our latest design) being added
> to a viommu list of a single vSMMU's. Yet, vSMMU in this case
> always traps regular SMMU CMDQ, so it can do viommu selection
> or even broadcast (if it has to).
>=20

I'm curious to learn the real reason of that design. Is it because you
want to do certain load-balance between viommu's or due to other
reasons in the kernel smmuv3 driver which e.g. cannot support a
viommu spanning multiple pSMMU?
