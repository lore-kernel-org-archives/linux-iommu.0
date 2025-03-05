Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918CF2E3376
	for <iommu@lists.linux.dev>; Wed,  5 Mar 2025 02:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741142821; cv=fail; b=FQFYBEgYO5DRSPKpPYJn5xxzlT9bA0g9qSffl5bhyCsCTaUOIdXvtdhr2eN/tDyeyhu/vAwoJA4XQTRmaBzPXKXtc6eE0Qnqgjlo2/Ubb77keOXKDZTm/eInzSEc+lb9FzG2Y9gx5r5nUeZqJ9NCunL+JUt/864bgVYZfRU1HEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741142821; c=relaxed/simple;
	bh=/8UFRo+VimIkpgF0jKQuKKjm/lq3P5wsJNggmIReDAs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TFjlOZmxHUMspkPApha3A5UwjKmyX2eJfBkCyZlIJcl35dNf4S6VOs+8lm5F8LebaSzU95nLbBL0HxtiHSZhSqeyeibCxca+++yq2QLEZPgFeFiw3hgwtz3P+xezxEOQJcZu+58SCqL/qHkbhcFCY3gLwt+m23DKwFbQN2OUunw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZlKPEhmW; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZlKPEhmW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741142820; x=1772678820;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/8UFRo+VimIkpgF0jKQuKKjm/lq3P5wsJNggmIReDAs=;
  b=ZlKPEhmWVnKgRlKLOwqkc5shrZIWc4TkaJMKw0hvJe6m+je4VU/liEEV
   wnkRmmhf0ui2eYcvJn3lJx+RFgiF/UWfr8p/IT7PCJpLBBhmZcfA/TAVN
   +xrUgZhJ97oBCym7hLyr4MqVK1VqSSF8quDO6h1/6I+V1PKNlrZr5La77
   2eGIKZky4D7PEnydG4xOVtZRHHjmkaoyqsppfof++glaAj9hVA1hXxavC
   1OvwLMMdKzKtamBHwXpCWa+hKrQPgOlyLem8sGU+xdQvUeXm9pxx6Xmpa
   8hY0wSjQWmkIHPKbVOrvPEQjrwR8BGLRpSmd/L9Avv47uP/ERkoXoblhc
   Q==;
X-CSE-ConnectionGUID: DD6RdeaTSim8Hi7xIYc55g==
X-CSE-MsgGUID: iIXVf6eYQWO2jzzb1gceVQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="44897438"
X-IronPort-AV: E=Sophos;i="6.14,221,1736841600"; 
   d="scan'208";a="44897438"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 18:46:59 -0800
X-CSE-ConnectionGUID: 06zoZia2SoCo5T+m0+KbcA==
X-CSE-MsgGUID: 99o3QGl/QVixVCzgxjI2FQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="149508592"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 18:46:58 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Tue, 4 Mar 2025 18:46:57 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 4 Mar 2025 18:46:57 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 4 Mar 2025 18:46:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zLTW6flPiI5ZYxhE9uMjth0g8g04Codg9LJqFnuhAAPo/H9UXIv99jv4CeUuu3ul1yWjLNXyCV/WD6q20OcdQSym9kwxefz/MQ5Q2sndAWHlA0WMX2kYvfh3UTiM84FcVTrkNLQ383/besOCcj2fWOf+SPNSImJsT9uiR6MlOwklu0L3Meu0EGxkvRb9QdbIIqaYbT5/ul+z+o2MvioxYGz2zGe+vQN3obEw1v7iqWDQOpJ/mbRS5xblW/x1a10Ht60aBYB4RtuW+9RJ+CRd8VtD+3t/FA/QNg8KaDjLaruJ8nEBoPnuFea1y3PG5as2TYXUlS9ZvI8OEKir5B0+iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gmufwV9EGTZnbwMsPwjm//Xz2agR3FXFI059+FdBEwA=;
 b=RU1IbpUNKI4vG1jh1ogwCJV398jmFKPC4llrdCTDm9jsX+CD0/mY66ijByvKtzSk0NPT+BgAp4sCYVqSL+2EenpR7DMIoZU+2CB+A6pOFAOoqs+0Ik38PQjsK4q3dXQm6lLBI7wYlUec35uC6CvJOeHUqV0S+2mrkMBL/s/Gkir0Ppf32XHBc9p76xVdEz4UTWBRtpfoSvFfTPDhAZJEQJEBWBAAOBEp5uo++tgh6uZDtiOu6o5GEkZ3LO466Ptc/Ek9VS8y9w0T2VSXIFFft8roZiQQzdPQda8XiFcC0ejZIrP09KZkpUe8OB8dpE3hDRNEM98yXAyVmrcP7mXQuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BL3PR11MB6361.namprd11.prod.outlook.com (2603:10b6:208:3b4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Wed, 5 Mar
 2025 02:46:27 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8511.015; Wed, 5 Mar 2025
 02:46:27 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Baolu Lu <baolu.lu@linux.intel.com>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, Vasant Hegde <vasant.hegde@amd.com>,
	Robin Murphy <robin.murphy@arm.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>, "suravee.suthikulpanit@amd.com"
	<suravee.suthikulpanit@amd.com>
Subject: RE: [PATCH] iommu/amd: Add Secure ATS support
Thread-Topic: [PATCH] iommu/amd: Add Secure ATS support
Thread-Index: AQHbh3UOCMVRgdan70yjYJFDyKuOHbNX8z2AgAANboCAABr8AIAApFIggAAJnQCAABasoIAAQ3owgAIlpoCAAPkEsIAAF6wAgAANLoCAAASrgIAAABIAgAMaTACAAkGVgIAAgCuAgADJkgCAAM/JYA==
Date: Wed, 5 Mar 2025 02:46:27 +0000
Message-ID: <BN9PR11MB527617A588EC84D2539168198CCB2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <BN9PR11MB5276B3E410FD336A3062FA5E8CC22@BN9PR11MB5276.namprd11.prod.outlook.com>
 <4fba254e-ca47-4e7b-baf3-0228d9605c2b@amd.com>
 <BN9PR11MB52763A8885AF1678E05E8B528CCC2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <942a1a66-5c18-43e2-886e-df38cb3e7258@intel.com>
 <54db17d7-b150-4579-a33d-f1b5cc8943bc@amd.com>
 <6eb0ec90-5859-4605-8a2e-657f6f711d61@intel.com>
 <825ddadd-6770-46b5-936e-f17988534984@amd.com>
 <13e1e1d8-5870-44ea-a800-e5b25bafd344@intel.com>
 <20250303183801.GW5011@ziepe.ca>
 <24d8234b-ad59-4b7f-b210-b97d7b5dd998@linux.intel.com>
 <20250304141812.GZ5011@ziepe.ca>
In-Reply-To: <20250304141812.GZ5011@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|BL3PR11MB6361:EE_
x-ms-office365-filtering-correlation-id: 4cf0f4d1-b5f5-453c-de80-08dd5b8fed55
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?1FBJ+iPM7jR+99zX6DHnrELuREFvH+8tZejM2BpKFF/a6NZkAtKxhVQr22Rl?=
 =?us-ascii?Q?xYnUy9Ckk0XHTL5teumfitFjlZeCbQHzdXfJfwyHN+t+DyTq6zJvuP7I6kwT?=
 =?us-ascii?Q?XpEIYQP9NymkHayQUKWLIOdRoWPFZgwU7vOCAjvghyEal4b34tfIXDPeHns0?=
 =?us-ascii?Q?Krkn9yhNpx1q6VDPsmaOK9cfXDAP/mSigT60yrF08aGZFmAfCjNsVd+7H5cv?=
 =?us-ascii?Q?soHxRVDi1tHp2hwejoZJHu0YGO0YaOiQLFdczy7QHByOIF//k6jXRl65yts3?=
 =?us-ascii?Q?cRpqMzHrXsuM2mb+8Y/ju2AxIfVcRO0tYApFUAg6vjTq1UcyYcdK5CTkk+AX?=
 =?us-ascii?Q?/9RA3mGedSzfCYDzfaTcJAtTJ0yNnylKrBv7fFSHdmazC1CJbvZqLvcVDNKk?=
 =?us-ascii?Q?k+zMDHTfflsSmsqiR4kRBg599OhpVjmWNEE62kwCLF0biOv9st9bjTuB6fr+?=
 =?us-ascii?Q?dtl5bRsIYca4+twV21bez+MgMa18LfVblWFuLmcfQj62S8rtfAXuM9q5WrRX?=
 =?us-ascii?Q?1pnxkaBYZy9GhsOnSEDTzquEGlmgzhBmMe6uFl76AjR3KFPT0g/a8F1iR089?=
 =?us-ascii?Q?rRPm09it9A9Q48B5eW3wsl4rZQRxGFJph/veR43wRzrM41cVAMW+HFrpdJ/N?=
 =?us-ascii?Q?SsaaudSOX5KeAvRl5qSRBy+7Kw+zWRkcE+cEVaNt/w5tMvCi39//aFOHNxjW?=
 =?us-ascii?Q?l1oVcLxVr+jnyQyP2ERB+JU046esKeRb3YRWmfVYvQihO3fpvx+JXsDWp3hQ?=
 =?us-ascii?Q?Ql8C1yIuq76MRevGGIzdnU/CamYUBAMq879hzX9Cvxor6PRvryTeNngZwFN0?=
 =?us-ascii?Q?ZEWY490HBaGYIF4/XZvx4hzTKKkF0MZJB54XoQMa461IX0QGaNKSXEDgRnwi?=
 =?us-ascii?Q?cSv4ZkyM0Af1l9Wb3J/Xxo/pi2h6i3RCeOnJ1T2c0VRadvC9WuROZcbRIUSm?=
 =?us-ascii?Q?9xbqXCJo018FtdTwRkheaxs2qTHp3Xd7/bAGFUWD4aa732IeYHxdoz5PTQbL?=
 =?us-ascii?Q?XNzJMO2ghd21Ufemka/a6Jfxhdbwqh3fxMYJ9RQmZozA6//xSP5VBql4+sIQ?=
 =?us-ascii?Q?aqTZ4Aar+BELuMR4BLTvB9qesE3MPlORMUeboGU8G143wH60zhp4CYYFFaRw?=
 =?us-ascii?Q?gWoQVEzJsoaYNXVmV1Jz4xGhZ54iXdPE7s1zc24OVNdkxqSaNcArLPbedI4Z?=
 =?us-ascii?Q?AosirGDbIMn4xE+3SNF/vzOFmUB5X0kFrbN3trKPfuS7z1CU17XA4M7RuMrO?=
 =?us-ascii?Q?xMi0d2uehImBABX5RjBh6pPiAwaA7kxgeJloknIc14DvZER7ReSRKmo4IQ66?=
 =?us-ascii?Q?x9JBZdJK6izYBNqrHoL4QqGS/FpjvKn/sSWaB2FzE5CUuSulB88Z5wHEqTPg?=
 =?us-ascii?Q?tErqfY/A5T6ABbqvHzhQjpJ+mxsnWgzOngTxjPZ7Ql6bYuS47wwkl68luHVt?=
 =?us-ascii?Q?3J3M/peLFQl42jK2QFdpgSNp5zfgalTF?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TBm04PuepRoE9nXZeXNJXHMKSsOUu/yEs6ziU1Mivv0Z4kERXHHtu1i5mphz?=
 =?us-ascii?Q?d1vljhMXB6q13CLu8S2FzGskh0uEJM1M8xprLtcZp5TItSQx1b9T+B/cjRQd?=
 =?us-ascii?Q?ooaADs3Ta9a1cfCxcqlr9YHX4FqIyHTyCyeq2kOSklZXYfqGLtvQf3rICf+W?=
 =?us-ascii?Q?aOuwWtO42rtN/ATKe4tneyGazSCGpEQ5G9dr/W6P5PLQP3ZfmjzXltImLiXR?=
 =?us-ascii?Q?h/5v/mrxR52SItW3B1DZ5a6sTNAdnewNS/0j5b/ybbBXFGlpYOsD98rJXAk+?=
 =?us-ascii?Q?FK8H5wXB7eQ/OEBkI0Cp1xLcGPOdvuBkramAaUnvdYmLJ/WSymXVNLzv59Lz?=
 =?us-ascii?Q?jXrTyxdDzkFA+wtarpt6Z0hAlVdXyu8aOBrridM66xo0xxw0rBE2O7TjLWj8?=
 =?us-ascii?Q?lrS3j6Cg2s/jvz7UvmwM0TX9hLVQwf6GaJT82olNfCe8+ibnhz5IKaY7QAwF?=
 =?us-ascii?Q?F6qTac+Fotm3mWEU8MLzz9vi5XCFzmpc9DN6Seguba2M6tTeoIQmQEagGajc?=
 =?us-ascii?Q?pFkIabyuB7Umx1IYEu7fsmH9Y42k8zxk8uSLG8m+dX4ZI5SDSGv2saOsIDk0?=
 =?us-ascii?Q?yBcolI+h77iZkoGTJxAFQl9WVOQKT5ZVa+lc0WAkspbQqsgYUn8yigpj3Ss2?=
 =?us-ascii?Q?FtZDj5GCf7eLW0cdcMESMbz3K/aJT8cyS88jf6iEYtpSyvR9uTCP822dZi2z?=
 =?us-ascii?Q?90beq0M+7eVq9f14zkvSrAChLgqCPnpdJp2GXVyKqbG8cKuLO8PXEQSwA8kU?=
 =?us-ascii?Q?xYXh6x3Ywy5o8Y53rUhJcaIQDt528Ymcz4875ydKRhuFUoAyMp1a7nxEogBj?=
 =?us-ascii?Q?4XUHsnbmmKzpCdJ+IixFJEbXY7ux/0LR7kTzztsLzgfxb29VuCHLSbhEZJdh?=
 =?us-ascii?Q?GJ7Wu6mqjZ+ctUaWiNgFN7jhBmyNaGHxm0QPJFVRU3Ig12+1A8yyBNpU+WTf?=
 =?us-ascii?Q?/GIS4FABNlUsMpZGTYK994FGyGFSbCyASvLIsvYy0ERgtAs+8/5DQMmjXNYg?=
 =?us-ascii?Q?bPatyfEY2klyCnIzoy8R1r9wQCcP9B3xKsvVf4tnbIKrHc1y6VlpF3RxdLbP?=
 =?us-ascii?Q?2mc1VKGBsyH2gokSiVi/f9845w0+Let9SxSlC2/ri3DYIM2jBKvPl6T1+JXM?=
 =?us-ascii?Q?v13X5RNy/VTQLApJx/QlCYprmgU1F/97xjT5NPl4W+5PFYlo3GGNsQI5eO4A?=
 =?us-ascii?Q?QcgbDRjJBaBMk9TwE7VU9IgRhUc2cewmCx7qVi7KpeB6riLwS9FaZsDHn1ky?=
 =?us-ascii?Q?T/aA+cJtCzrvNoHUL3TJtwlivMUBlCOsawWgDIS9vWBwJUxf3gp+yQlgC6ZR?=
 =?us-ascii?Q?LN+tEi/fjJil8NBU8ebxdvVDQIjloZT4LBdiVdeJntg35QJvspH51Nvrpu1S?=
 =?us-ascii?Q?Q6Gsm/9Qn1918jZlnJFTsn846pr3N8rES7zZlbbNK9+aKDAYZCwZRvlXWqGh?=
 =?us-ascii?Q?ly5l/+trVe/0n9aXgYCovvASPJgBMmJBaRLiJf1qK/EkUcjFoj1ezcDAW0lU?=
 =?us-ascii?Q?6oiiv77bUFkSwggg1RK2t/b1kzEGz/IVBi60xx8bhiSQHXJqy9LQm5xikHga?=
 =?us-ascii?Q?eF0qtYORles24pGBh/OaonWD2nLVIB56+x8r0IqW?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cf0f4d1-b5f5-453c-de80-08dd5b8fed55
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2025 02:46:27.6248
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ky6Si8Wmv+s1VW+pJ/RacdK6SO84GvRi4VjYvlYLENt0NzAq86NukHMPc9oaNdDNCWtbouvNOJPMxNtaSpgB4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6361
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@ziepe.ca>
> Sent: Tuesday, March 4, 2025 10:18 PM
>=20
> On Tue, Mar 04, 2025 at 10:16:45AM +0800, Baolu Lu wrote:
> > For ATS enablement, I believe we have already reached some agreement
> > that ATS enablement is in an on-demand manner. ATS is enabled when the
> > first domain that requires ATS is attached and disabled when the last
> > domain is detached. That matches what we are doing for PRI.
>=20
> It is not quite so simple, we need ATS in some virtualization cases
> for VFIO even though it is not "using" ATS for PRI.

As discussed before we probably want the user to opt for ATS via
a hwpt flag.

>=20
> Today the iommu drivers always enable ATS for paging domains if ATS is
> supported. This is what I'm wondering if it should be made optional

that'd make sense.

>=20
> > When a domain attachment triggers ATS to be on, there might be some
> > cases:
> >
> > - ATS does not impact functionality. For example, ATS could be enabled
> >   for the DMA domain for better performance. In this case, it's a
> >   successful case if the device supports ATS but the platform can't
> >   provide the secure ATS that is demanded by the user's ATS security
> >   level. ATS will not be enabled but attach returns success.
> >
> > - ATS impacts functionality. For example, the domain requires PRI. In
> >   this case, it's a failure case when the device does not support ATS o=
r
> >   the ATS security is insufficient.
> >
> > - ATS compatibility should also be checked in domain attach path. If AT=
S
> >   policy between attaching domain and the device does not match, an
> >   -EINVAL should be returned to inform the caller that "domain is not
> >   compatible, suggest to allocate a dedicated domain for this device".
>=20
> But this philosophy makes sense
>=20

+1
