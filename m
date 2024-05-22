Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5716824B1
	for <iommu@lists.linux.dev>; Wed, 22 May 2024 23:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716421437; cv=fail; b=uy28P6ubJHdfXOjUM0JUnuVyUXGK4VjJa7Q2if/TxdmgOlQqfz/CPuv+SxTSngcjrsC/FAAx7Zp/g/W8rYR6zH64A92XQ0zdMSflTIm7S7HUAuyjdultIrIgciQGkTsxbOGeNfZKS/dGIBbCfIpy95uXWt2ljHWEAgUC2R1sa6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716421437; c=relaxed/simple;
	bh=6S+NCxkltd1eq6k13uF2TKTTirceVwwEftjpyv42e6s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=U8D1QKURACWrN0cr2Mo5Wp20PQmI43DQasP4Tt3Idlmc8ly9436klq/i/uLGqJifhmRgWuWtGO4g41M3UTIz328BLzrV2u33q6F7+EY86Weqo4/6+2kpdSLw/bQ2OkenCbA4svQm7RT/N+79g1mM3sLxFWTezp2QOiwEW5WB/y0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=go0SVbHL; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="go0SVbHL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716421436; x=1747957436;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6S+NCxkltd1eq6k13uF2TKTTirceVwwEftjpyv42e6s=;
  b=go0SVbHLwm7eWwH9iCcsF+lE3SxYG1WhSkAsXJBuu2mQgUtDyx8gOXiy
   LPR+TT4oHxaoi0IX7+MA/ELd+1o5M6VAjniMezRRudroDmfzH+GAQH0j4
   3mswCIUk/qYEA/noOUq3L/raO/ZE/az5wr3eR+HM9jxBeWZNVSitOWYZH
   yjd2YeojAuWDpsELGMLu8V+E5eJqkMFbdny/54r9tIj4S46JOmcv3zHAa
   gmS1wgWL9Pp5Ip2sGJE2GCPG6oHtn8jtkMEP+JVkakeBWZjTcCejFWB/R
   mQopQpPmF3Kstz/HsnFVB7+3jlKSS+30KF5lfGldCYXRFuskQBbf2dwXp
   Q==;
X-CSE-ConnectionGUID: uQcQM8fUSyyFyvoPoyBb6A==
X-CSE-MsgGUID: nsgo1HwLSpS9mO4yOWd1bQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11080"; a="38088800"
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="38088800"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 16:43:55 -0700
X-CSE-ConnectionGUID: o8DCTdf4RECKPsXEcibLtQ==
X-CSE-MsgGUID: mCDCqli8RcSsa3GA2LYxpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="70863301"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 May 2024 16:43:55 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 22 May 2024 16:43:54 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 22 May 2024 16:43:53 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 22 May 2024 16:43:53 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 22 May 2024 16:43:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HGDL8ZSiSTZJ8Q2XFEefwCi4np0gnYW5VkXMj0m5YU8u3ZhxFxZD051HM209BslAgEHBwc7zqCQGe08KmGjRpt58sJIOgb0c3Y04lrX46Z0w5XdXyQ3qgmrBCcb1tSjhYuvt0zyDDKXV0KVRNTSfM9Bn7lnJ99PrFzi6yc4SGVEcsv6JkAT8xSiMduXzRCMcFpqd44vZuYshmXMx/KQm5yaHnEHFyoi5/Ke6cdIh7k9MhzQJCo2w4Q5OJhKfv8BhbRuxo267+u24JBxhxvv2WUVipk47HMknouL4E7opjJDGmjma+8f0doNJfnOJRnol53r/Z6vDAlXAvpIcpZx/zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6S+NCxkltd1eq6k13uF2TKTTirceVwwEftjpyv42e6s=;
 b=jyAGFSN6ufGwHplrC3oQ2A2SUEPrXH6Y5UEMdKsjObTxYMcPiZdN+zrMz9+ktQNwfRQK3yEZU4/EzZRscFpWfZQJbeRUxpX790X2wqLebYYOEEB93IpDm2XY5dW8KufqEeESBpKul+15tywHjrhF9ob9Dc7jrqQ/v1RV5gD5JTzC9XQaF4zMPWdLmrMCUgsxsGDboNevbvKSHdjWn/Jh9/9I07+2ZtiggxVtJewYhKmf8g1uCiM8dmIQoWBVwIT4iQa8M5CDhVNqGrKZxkYEBweDtcmEAwf+lImgiMJkWOuQY+WUaKVmv8+ZPpGo9y0fSORTPYmc6jRAT2IH4i1sLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by LV3PR11MB8727.namprd11.prod.outlook.com (2603:10b6:408:20d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Wed, 22 May
 2024 23:43:51 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.7611.016; Wed, 22 May 2024
 23:43:51 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>
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
Subject: RE: [PATCH RFCv1 00/14] Add Tegra241 (Grace) CMDQV Support (part 2/2)
Thread-Topic: [PATCH RFCv1 00/14] Add Tegra241 (Grace) CMDQV Support (part
 2/2)
Thread-Index: AQHajVVgzSKGnSPg+UW1Z+6EC5j/q7GjLESAgACIwgCAADIFgIAAPc+AgAADkSA=
Date: Wed, 22 May 2024 23:43:51 +0000
Message-ID: <BN9PR11MB527613C6094EDE9B2732928F8CEB2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1712978212.git.nicolinc@nvidia.com>
 <BN9PR11MB527641C15DD88FB0C44323D08CEB2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240522164818.GB20229@nvidia.com> <Zk5Lx7IqvnE2q7a7@nvidia.com>
 <20240522232833.GH20229@nvidia.com>
In-Reply-To: <20240522232833.GH20229@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|LV3PR11MB8727:EE_
x-ms-office365-filtering-correlation-id: 5a98653f-a569-4d6e-6d24-08dc7ab90905
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?t/HIqwlmw3A4f83QHb8cR8dI8dCqXLstIGQQRCfKXqCniSJCGXvn/+oCNtu5?=
 =?us-ascii?Q?ranc6qTbj/BLfAAHyqUPeWUdzDaQe52mQwMoRyz7wOWaPoRpgGxw6HUWAI/o?=
 =?us-ascii?Q?nfc85zuxsenhsMrvSUaTAt0BBxCSSAzlRYzRJfzd0mEThRnDuj40fSXDzRUj?=
 =?us-ascii?Q?dYXpVu5EG9ZEakQ4nQjVbovsezId/jhl9Kll7r2n7rpUEAHKFdlfCNp9pK1f?=
 =?us-ascii?Q?pXJs5EOalNftMrZ2K3X+Wbp3qIfN/8cGvXmWSSfaqBtYA6IT1ZOVm32UljbM?=
 =?us-ascii?Q?w1secLEUrjkveJUL9J7sQipVU2rCG5qWwZm4QWLkC9eIN7Z/ZKBaVgLAX4Af?=
 =?us-ascii?Q?H8AIxNSMQQqG6OlDA80NIgHEuRDUGepA/IhxZ1a2qKJfNxuL1/oo2Ok//JJU?=
 =?us-ascii?Q?5Z8soq9l79MMwuio0zffJiPOqvpL6EwHSR+enEQDROZpTARqv9pMPVB5GCGh?=
 =?us-ascii?Q?eFVc/qgrlbDpGv+zsgak0+rFjrM6fHE9n0zttzoMaWFVasm545qvsBeeSoah?=
 =?us-ascii?Q?KEYAAqL29Rn1FvTwWn6/v5+nSt3p9GjGodb0YcIUP9S2TOi42E8uUwrRSM5v?=
 =?us-ascii?Q?oXLa5G6LapVhKlWp0hu8ntVwL5eKIfLsUi3iFLoH+cYgN9wd0LO+nCU+Zrqd?=
 =?us-ascii?Q?lCCy+GRSCyRUmjHg+KM4452skwzPt2AWUf3bv9KJYM8GPtcITD9J7Sq8zoPy?=
 =?us-ascii?Q?rf3zri/rTlGfTvx/1x0VMq4UecNHagzUABZam6uei2yTHacWYrJKMTt0vbge?=
 =?us-ascii?Q?XstWdVD0ZqPpWWY4N7eIJM/EOMLWC1tJM9PsvTNS23XYf+Q8eQr868Gr4NLV?=
 =?us-ascii?Q?lO7DZEblQSmxbee5V1l9aY22b1E83opCJ8WO6o5uybz4bqRxTwcJJyR9sgwk?=
 =?us-ascii?Q?w0IXBDgUZfJQtTGBNWc86kKC0/DdGuvIf7Q9Km8qauMFQ1MlGab87iR8c+x6?=
 =?us-ascii?Q?Uic5coHQi88IuCr6RIpY1ZE6knMKBtctkbQfU11VzXpBHuqwvjGfXSriMnT4?=
 =?us-ascii?Q?eXsjBMKQQlf3xKq+EoYFFb9Slnz+UH5OCxab/6z0qx5TGhk8X6SdFX2lOKO8?=
 =?us-ascii?Q?KpDr1n9L8RYuyYXh7r6aA5aefc3xoRaPhxeM5zaNuXQn/WkJ0UISCScaFvW2?=
 =?us-ascii?Q?+QLkuvxHVjg5XY9bGv5lhaS7+GTh24ERXaGuEjqJWHnoABPVsILhh8B5dhOi?=
 =?us-ascii?Q?vyQGjzGdxhMG++Vm474KwIeg/8CzA+B5Lal6zGoMr2ckUXVhGMZVOHQav2YA?=
 =?us-ascii?Q?VCtpPZR2lSFHPuKYRQwgGDQ0C7JuOa7g4mlcZcg+DuPnmMXSvPRCBpoFB52/?=
 =?us-ascii?Q?DPsImfLpmciVgL28wYDUyCn6JQUtnVxoP6WKJQFHCIAEog=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iqPh/llYkh0X33q69qD/jGagbgC2/Xnl49FUeVYnJdT9oa1uZdxgAhtKh7zN?=
 =?us-ascii?Q?QRswdBUsSP6fKjZayHiezaKyFJWUdFmFYpurPToCEpYvOfW6/VCbDUdd6ZCu?=
 =?us-ascii?Q?JxNO7wAuI6gKxwloEjpiaBztbKuCMkqqmTCDjq5pd3dhj/68KfZIkrjon/vk?=
 =?us-ascii?Q?Cg+rHewX4C9faiN5xbG7xFSWk5tIlre6R5eeuQCrqFsg8IY3kUlZnerL8xoA?=
 =?us-ascii?Q?fVuGlMPNojMX1JtT6bPy6oNl4Y2BWmumj7PLlUI4bIz39ev0k1aCd1ZcwShZ?=
 =?us-ascii?Q?r51G26MscimlNXMCJCyyKxrpSCdPnEy23MUTybxAYxxYY/WnxqVT4T4yNr2K?=
 =?us-ascii?Q?cFRWVK830GqdQBsyRHicUTugYKi+vYeold/iVP2WAABCLjdwl6YTljXcTH4c?=
 =?us-ascii?Q?Jweds4D+RkKVSQGolrav74dEW6ECXtfDFiHtayktEfJfwgP+XuQ5s3nP/Ncv?=
 =?us-ascii?Q?dOfvb0mQuhEHZ57gwblRPocqYI72cYLgmCkxMiCiobFQb0HsOUItYfPQczgl?=
 =?us-ascii?Q?amgDTXAgtYDBvfHgP7s4MdROAPuXC9rVLK1AsGnKIOuNh3MBmkB5SWzyt7C0?=
 =?us-ascii?Q?vgDS3qFk1Dshm5Smk3pIUlo6Bv72WVK9RrSRjczf5MEmw1ZPe7INW2+KOKGs?=
 =?us-ascii?Q?/sgDe1EZvHkhj0j/uaaqPXmZgGurre0r5ZLfuzTpmLbtEMrK4F8hcBeYu4hQ?=
 =?us-ascii?Q?vugb0bTbiUsuVidfLqe1uuB04VzuSRYHRhn1w4poJwjYNr4lP6rNTcW8ghje?=
 =?us-ascii?Q?2mWErYD2c4cKzYYze2nsBv2p7AQ1NAPZef3PcjznDKOhLxM+t5B2ad8SW4Wk?=
 =?us-ascii?Q?zJdw4XteugXYEydPkq8N3EoFxI6S1xbDQ7Hc9HEBE7xLjATMDQ7lV2B43U89?=
 =?us-ascii?Q?xGMI/UjCzsnr4uIvqNeJ5x8J/ABBcyTJziKktIBUYkf1hqPFFZvKm+sw3rfy?=
 =?us-ascii?Q?PZ4cx8eKswrjzuKjpDxr5gPnhCjY15YLxynsMs4Xu4tg4LAQLX2d6n/pco3s?=
 =?us-ascii?Q?THB3LAAa72yLmd0mfZ4w3S4r0KGgaPwVRAk7/f8SrPSne9o02C6HdCCxSFfr?=
 =?us-ascii?Q?SkcieDgzDFTuDiRrGmXJNAyiOtkWxasUxkhper0pw2/Yr1Q7iNE1CL/j/yLY?=
 =?us-ascii?Q?gFSZvhSpkQ7qbKhyVtpPzBn257+9AK4rNkiqh+EElR/mmhsP1bEcgAAZFdTy?=
 =?us-ascii?Q?1H5eRodVuo87zs39ybF1c6aQSTVjqR3RlRR1VMWmgJSmZd5iaM/d45+qRgHW?=
 =?us-ascii?Q?iAdhMDkuINShJpZ848pk1l9DG4IenFtWbRBM7ZKWG9MSApviTtFqIIbNcCiQ?=
 =?us-ascii?Q?oyky9vhfrPpvZGqARQ/XFrD8pRF7zwPgxHcBN+zlNQR7LbCChWoFnkAGQFnP?=
 =?us-ascii?Q?8uEN1Ugy+Cyan0JZwRafWo6V0Vz0+9Bi2u6oOmL1Tist2tp3aLNh/eQFTFxf?=
 =?us-ascii?Q?re8XAa/VeW3lQzpwDvk5pI66xocsbHfu2xx3rFLGTx+ywP6palcmWuKsSXe0?=
 =?us-ascii?Q?Pj6BwRwY+HTqduOGJEpOY4zhVuoEDyUhU71GXfY0XVON3Wps8REkYUEAc8Lp?=
 =?us-ascii?Q?sLn0ZqLHmns50NdZK9eN4ayUbHH2jELRYuYBc93a?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a98653f-a569-4d6e-6d24-08dc7ab90905
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2024 23:43:51.8144
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9B62rw5v0OzlExL/41uNvhgRSO4b9e3GdasrAK/DBLgFHWlafo2DqW1C8M/24SdCnWb85/F6fjYtL6RYoIX7Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8727
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Thursday, May 23, 2024 7:29 AM
>=20
> On Wed, May 22, 2024 at 12:47:19PM -0700, Nicolin Chen wrote:
> > On Wed, May 22, 2024 at 01:48:18PM -0300, Jason Gunthorpe wrote:
> > > On Wed, May 22, 2024 at 08:40:00AM +0000, Tian, Kevin wrote:
> > > > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > > > Sent: Saturday, April 13, 2024 11:47 AM
> > > > >
> > > > > This is an experimental RFC series for VIOMMU infrastructure, usi=
ng
> NVIDIA
> > > > > Tegra241 (Grace) CMDQV as a test instance.
> > > > >
> > > > > VIOMMU obj is used to represent a virtual interface (iommu) backe=
d
> by an
> > > > > underlying IOMMU's HW-accelerated feature for virtualizaion: for
> example,
> > > > > NVIDIA's VINTF (v-interface for CMDQV) and AMD"s vIOMMU.
> > > > >
> > > > > VQUEUE obj is used to represent a virtual command queue (buffer)
> backed
> > > > > by
> > > > > an underlying IOMMU command queue to passthrough for VMs to
> use
> > > > > directly:
> > > > > for example, NVIDIA's Virtual Command Queue and AMD's Command
> Buffer.
> > > > >
> > > >
> > > > is VCMDQ more accurate? AMD also supports fault queue passthrough
> > > > then VQUEUE sounds broader than a cmd queue...
> > >
> > > Is there a reason VQUEUE couldn't handle the fault/etc queues too? Th=
e
> > > only difference is direction, there is still a doorbell/etc.

No reason. the description made it specific to a cmd queue which
led me the impression that we may want to create a separate
fault queue.

> >
> > Yea, SMMU also has Event Queue and PRI queue. Though I haven't
> > got time to sit down to look at Baolu's work closely, the uAPI
> > seems to be a unified one for all IOMMUs. And though I have no
> > intention to be against that design, yet maybe there could be
> > an alternative in a somewhat HW specific language as we do for
> > invalidation? Or not worth it?
>=20
> I was thinking not worth it, I expect a gain here is to do as AMD has
> done and make the HW dma the queues directly to guest memory.
>=20
> IMHO the primary issue with the queues is DOS, as having any shared
> queue across VMs is dangerous in that way. Allowing each VIOMMU to
> have its own private queue and own flow control helps with that.
>=20

and also shorter delivering path with less data copy?
