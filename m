Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12071C2DA2
	for <iommu@lists.linux.dev>; Fri, 25 Oct 2024 08:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729844703; cv=fail; b=IeOm/u8VN6SqqUMYyKY5SNi6A6wTctkKk6+eTstwe45eOpeOwMajTjR3VatBRp9nABEMvEvgFgeNFVper9MPq0tWzgMpvWDMW43RssLBmUqEJuyEZPWxexJyvXKcDpAOcrEiCDU8cWTA6562icaYQOUQ8G1sfBQHQFmAHC1d7W8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729844703; c=relaxed/simple;
	bh=r6LIJXSeVbTobDGAaNFdjmlY01BXer9N4GJlSm5Dxog=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Rh14jaAvirSvUwVnr6MtMXJucPSaKdfCwEsGnE9jxc7RD4uexbc/xTe8ihYCUpY6sTd0uFVUFftc6zdFn6VzeJj4vKiCQ9+Cs5wN8AJ3bRydsDyRaK/xUrR775v9TP+cMGSo7BDqqBmoZpVVl0gLm0ahjdq4kbZ0VyDBI1hbsmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lsmc05xT; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lsmc05xT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729844701; x=1761380701;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=r6LIJXSeVbTobDGAaNFdjmlY01BXer9N4GJlSm5Dxog=;
  b=Lsmc05xTXosRbKkVgLJg/Nz9dWUc+70wvq1vSkbhtC5oQ3KMm5OzCAFa
   b8LoRZcoDZx/1zU2IDolfIk9sBfXG7iWFLoez5p+WBigOB92Mhdqrij4W
   PKp8ZqeidlATaZRDLgPmeiD4e9QJ70jJQ3X+1Ed36vuARY7Mt9c/rtmJd
   /K0L8qHtiNjosKXq/tKIGVdloEE4eB9rMAkrGwneoVK8hb84SHD76CWwX
   MMSDPSTlo8yxFAz+rZxVAV5nyq0KseAnkfM86KxHrYxn1fpHAnU4pdvCA
   O2wLrfG0OD6DCkUojL67YjGPVmWCpkn+b7GMLvOY1Y3TSF1q8s3Mpfys/
   Q==;
X-CSE-ConnectionGUID: P4kNBh5nTd+IaN3URlLWhg==
X-CSE-MsgGUID: 8WgDdjmZTluPqYMCXR4/kQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="40880537"
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="40880537"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 01:25:01 -0700
X-CSE-ConnectionGUID: d9bfc1Y2T324vbh5mww5RQ==
X-CSE-MsgGUID: GL/m5LDdTfOXgczOFmP86A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="111664687"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Oct 2024 01:25:01 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 25 Oct 2024 01:25:00 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 25 Oct 2024 01:25:00 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.175)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 25 Oct 2024 01:25:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=klyOGLkptduuSQIGYPvUDn/YQS0uqHOonqwU1tkrklUIVmaoOop6IKpRRsYlKvDqgy2CBYbG5HDVRRmiW0gNQKajqOv6hnnoAp8OdB7kE4eDWJaJacWg+MHoX9hBw5LLh293B3jeK20YFrsQXYFwxL1F5KOvLdBbXXbtFmr+MKX6oqV1/9BhHCDnbjbQe7j1s9pPUBkQO4ypNMJStCaX+0BO9HuKT4g30EGQScU16gs+FH+47EH21rVLyEVFYTBbx+NUbGCzaGfMEnCs2kyp9dyoP+zkSEl7Tjqetsl97L9yKsx2W0VtfQg1ThvrzgXrJeZ7oiN989Y7Ey+x95kskA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r6LIJXSeVbTobDGAaNFdjmlY01BXer9N4GJlSm5Dxog=;
 b=JKy8nUbe99QcfN9BAZbPOCsCb9ak0plaicBkBIpoOvVWpLK2UAtVZi0S6mnComFEG9P6ffen/LiaMMWjnJYE7rmMXWRh+ak+T6m+NSzmzG77RlSh/cQHNRSBgpKQZ8SvRYDPekC6wkrwQuAgLhZhiCunEMJeWPiEHq4mtuLnLcWLLp8PLnYkckfGG6mI2bTn2mChO0Z0iyaRXYnuGei/Qvwfhb36Z2hx+Kfnlvu5C/QURCZbtvSUn/MRt8wwby8xIDOo+dBuCYoYiyZCUB5AlYnHgJ4uLAzFsSqPM9c5OI4OtC9gFtGFGf5Jq+AVhkCHDYHTbzQGi9lajTdVToVfdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM6PR11MB4754.namprd11.prod.outlook.com (2603:10b6:5:2ad::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Fri, 25 Oct
 2024 08:24:58 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 08:24:58 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Vasant Hegde <vasant.hegde@amd.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "joro@8bytes.org" <joro@8bytes.org>
CC: "will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "suravee.suthikulpanit@amd.com"
	<suravee.suthikulpanit@amd.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, "Liu, Yi L"
	<yi.l.liu@intel.com>, "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"jacob.pan@linux.microsoft.com" <jacob.pan@linux.microsoft.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>
Subject: RE: [PATCH v4 10/12] iommu/amd: Implement global identity domain
Thread-Topic: [PATCH v4 10/12] iommu/amd: Implement global identity domain
Thread-Index: AQHbJTi1zdrcR7+xukSGtj05NP7kJrKXJDwA
Date: Fri, 25 Oct 2024 08:24:58 +0000
Message-ID: <BN9PR11MB5276A7198BBB05A3B86044048C4F2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20241023104207.5894-1-vasant.hegde@amd.com>
 <20241023104207.5894-11-vasant.hegde@amd.com>
In-Reply-To: <20241023104207.5894-11-vasant.hegde@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DM6PR11MB4754:EE_
x-ms-office365-filtering-correlation-id: 11c9077c-0f98-4e80-1178-08dcf4ce8350
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?ccj5EW7vXHAe2Q+LiOONi5pXHrBpYc23NypigSFYrZyzBEkgysGFJPhj0RZW?=
 =?us-ascii?Q?6UJdd5C12YipRlzHiSMP+HY2vyirjLR/T2U8yBmYZQzZXQtp1VIxvW47rOKF?=
 =?us-ascii?Q?5TU8Xx9V9WPCzecRVkS9K6VbqsnSvq86r97iZgsiMQxTjIREGNtRfvdZaMjl?=
 =?us-ascii?Q?GoO5GYB1pnvNHZkv/zwpkZhE5fbLQFuekhGiXXszZLwPx4nI6eqarDkg4sgS?=
 =?us-ascii?Q?0mmZ8VwBlyepjQBlDOhFe26vlgIGYjtPcnQ2VbmeqlhuPJYA5GR5WhVDstNF?=
 =?us-ascii?Q?UDQXuaUcPbfLsEQTBvSiVqEklycJd17Y7+AFyWv/aAM6uKsd7nuDj09JS+oA?=
 =?us-ascii?Q?JAhZ6nhRrA1pmQ7y+uHe7z7PgGBpMA6hSTPno+gyX94/a6b6jCh+Lg4SkYDL?=
 =?us-ascii?Q?qYUqFzJxDD3sf9162SB5Qsckpkmg0tAQiB9nMqe0FwGg5Wi2ssJPMRcKA9LS?=
 =?us-ascii?Q?woCDmoK32RCNZHeAHCnNanQQ6gZm/aPODaE0dgJ+7Lag7MNWsQ6/nS7VgmTP?=
 =?us-ascii?Q?YxY8SMoDf+nT+euuFrWLfBzTdjU27lnA6NS0ePmGBDIKuL4DQVAz5vSigdNj?=
 =?us-ascii?Q?ATNY/gNvAiqY5vx6MTKLiJwOUeOzeKHrCtTrm0zQqrTWob96ojt7TPLUyWyD?=
 =?us-ascii?Q?DgwspQUT+/MSuWLl/KWTCuw7DSIh8JfeuxyYCtBe7zxwg37SyqXGK8xrLHOn?=
 =?us-ascii?Q?kPOSaB/WXD+ZJfEySeLxPGInIzzcBsjFy1PX3ByqI0n5NymgvMFwGp+wchdL?=
 =?us-ascii?Q?jSvFFDcW7p7+Rq6saCQs4L8MbltlBcC5740FERljyQX8vTNZ82e2GV5iYsa0?=
 =?us-ascii?Q?K3rn1h/mGn6d/JBp2SqJVUNE5tkQLn7XXl3LkcJ7Yg2gUn0ovM3amtdKb9Y/?=
 =?us-ascii?Q?f7yRsaweVZBV6HGr8yrd79Y0EDQpdP5uICS3DsTjEYTtSfdKPGESeak7RZsU?=
 =?us-ascii?Q?7t8cdzHV0OWvrv3g9nZcAxFqWrEqYpVLcc3RueTDU7Au51ioq7rGIVxamwgT?=
 =?us-ascii?Q?CcYQXdeCoCy0u/p/zAX0dhce7p3t4jxFDupAdjYMWIh9P9qGejS7WdJ7Flfy?=
 =?us-ascii?Q?XXlybysCkvZ9NTfxSH8N0Fzp53iWEt/+qq2Fs9+hbJog+SJLA20ZEqgQhZuw?=
 =?us-ascii?Q?NjID/iAQLJMpAtwc+LlFHjC5Y/q85b8lNyq2ldoCsa0ObVOtRb6ZxSxGuMA/?=
 =?us-ascii?Q?+2XyE+T/QTSw32uC9ds9xZSqb0uJuhPl9ZLfDlxZdMD1nYcWo1roIRI/TsFq?=
 =?us-ascii?Q?fYXSBGLQ3mc/KgurxhknGpLOHM4CqRZMKgQ49wy8Z7SZ+JCaCUkuPJdV88Up?=
 =?us-ascii?Q?e33LJ3+0PBz8zoaC+8mbTCLb5jiNGZJYNQ33pQibDu72DyfcVEjAucDUboui?=
 =?us-ascii?Q?/uCpDEU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?v85RRf5vzK1lUhS20MJZBcmvY+ST0PJIhlVoy1Ik6eC3gqpaDap4cNJG7e/S?=
 =?us-ascii?Q?fEzsqmARFMdGLsUMNiixga9CqSoHsunsacJ1TGUstSh5Xy05jXYQbR+4TPtR?=
 =?us-ascii?Q?FOFxNF5ppfQgHqNxm1QxI/5TraIC9t04v/Da4M75CFCnP+gBM95zrsZqlNQt?=
 =?us-ascii?Q?P+Lbsq/VxHZGEjc1Aq/9uLYZQe3U5+7pBAmKw09pa45ShoC2gPbJREfPfGjz?=
 =?us-ascii?Q?JmumtLJ4BvO1YJlI894OYPCHHTdcWI/WCNAN+GEcdRyxZh4pIfdsNrfv8/Nd?=
 =?us-ascii?Q?NREPRmiA6yRgsvTMGDu/3VMpcuOG5HGcaEm0UdM6wAT887ICyDprBBmcVClG?=
 =?us-ascii?Q?JvFQWj1Nk4xwk5gTWKA4ioVQSAYHqHr8vcb0VklUvEhqZ2UM65/jM5wd0KMN?=
 =?us-ascii?Q?mWL62/vdUslcdzSQGd5cZmnf0Hoiv0Ms48lWCK6PWSQaQzTNWtNNIVDPoUx+?=
 =?us-ascii?Q?970mdbSSWgfBMqtnbrqL9AgRxcaJKPmxmRaQnKX8umU0C32HRw8BD6LHa2iw?=
 =?us-ascii?Q?GGPC4TrXGbTihr48X3N2ZZJXyOxwvoKHiiRyoeJMsMzqDSEl9hzOirLM3SEg?=
 =?us-ascii?Q?87E/Fw3itmHjCt9ZCwWLIU3NPWuVlsPNk63C+f3sHT20Xd1qZ/13AGX4xNf/?=
 =?us-ascii?Q?LX1VTXuLO8s5mnONU2EWSexIk+BQ6jchLzwXvRJt0IyioodKiCsS0yBzimoQ?=
 =?us-ascii?Q?ZZzEn6Pyd3COFmez3oYJOG3l+FkIUN8mWNUTGlOyJWY8W1zBSx4wJvUXuIxv?=
 =?us-ascii?Q?gk/0ynxfeJ8ME6vEXwmTN8AWqOlB23n+BQQ7qWwnzLb6vApNO65viZ3LUkFq?=
 =?us-ascii?Q?aEIic7H3++JT/PSOo+4NPkU8n+cYjXzu+pHgCszk5ahvFmSDkuhrwiAEQm4Y?=
 =?us-ascii?Q?JBxlHmc5/FabZxq9YO4EG7i/UOLslT8/Zg5KvZr7D28CiOsKaYCx0JyLpbA3?=
 =?us-ascii?Q?Ic90m56fPfBF35KN53FT1Jg2PdxKGWQdh0Tj9fOT+TQmtR/F4s+7ZcAnAsCU?=
 =?us-ascii?Q?QZQlXP3JiUc0rkXui0Ytsm1fHZaSNSmuFnyHoc7buXCEBxkjMYCxkrqv2NJZ?=
 =?us-ascii?Q?xHZrng8NhDrArrJ+IA38nV9QFuZXeQDc9/pWEBne4GALBFdMw8CyS7A3y+OM?=
 =?us-ascii?Q?8gLZ+aufl3NEYR+F2KBb3f0zK8jw7WnAieKdGpVZ9mjOf8SArWD2zmLDazZs?=
 =?us-ascii?Q?cYJ+nkEcXDmgjzyb7ZXmu/+YMiNpRovrzrSuPTQx8L+FVG23XXcfuXC7lFGP?=
 =?us-ascii?Q?ATmbq1JTPvEe+f4ccVgzYO7N3LtGGGb32XlnETDGngJnbGY0Rqrz97og2fkc?=
 =?us-ascii?Q?AX+ZFFykTFsPyvX4kyGyjUY47Poxw7nHbmy4qATLtbagwxtWf2Oss7Qw5JL1?=
 =?us-ascii?Q?nvXYLoT74E+dg6ebZ388B7GFNkcPPN4rdsqt6b9RKVFJ+gdVQUMDrUp6n+l3?=
 =?us-ascii?Q?cpXlL98l3JZa5UQexNf7mSIOPFJWaDwYWB4M47C3hbaDpvMOotT4kzI4HpFU?=
 =?us-ascii?Q?qFA1B7qfkdb1yYCD/mSoKtAPrlxC2w6+UHbG5ulMEzbvF7sRM3ZjPQIflnjm?=
 =?us-ascii?Q?wFcOrzkHh+dvi3+guXhOu8N/4i6aPCDC8hBrh1QA?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 11c9077c-0f98-4e80-1178-08dcf4ce8350
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2024 08:24:58.3170
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KzMkpqq0LUeR6LrUSljoopZjQvelBA3kJh8DBpBWnE81eplH6IVhcMYoZs3d4vux58UESkT3gy+qJpQoQG0DtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4754
X-OriginatorOrg: intel.com

> From: Vasant Hegde <vasant.hegde@amd.com>
> Sent: Wednesday, October 23, 2024 6:42 PM
>=20
> Implement global identity domain. All device groups in identity domain
> will share this domain.
>=20
> In attach device path, based on device capability it will allocate per
> device domain ID and GCR3 table. So that it can support SVA.
>=20
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
