Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E6F189914
	for <iommu@lists.linux.dev>; Fri, 25 Oct 2024 08:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729844451; cv=fail; b=LPGPlciHL4L/HE/JRGu5s9TRNqjLLuqVafUVImpFCIaGut3aBEd1e5dJaXrIPDabcKeE6DdCXS9PG5Rq10+DcnaMr+eWi9B22+RwfyrgXXGmoZLlEZ5obFz8wpUSl3pt1NmWPPpGcO7ajjfiqi7mqi0wcOzBYR4iW2l5uGQZDL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729844451; c=relaxed/simple;
	bh=xP/sZoc8+afwRDru/Go+U1d1QYUXVvtb5N1R6E1ynUg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=D0Ci7ukHi4h06aRaEDdjAdLKK1nVk5NnRc8UW7Fn70vl6tjXjFRjVKDQF6/dr5tkMvhx0WSAFiAQGlU6oGB8uCCH2eJcVqOSCe8YaW084wp3SWgf6E3BXyxUdivoKFKb9q781Sxv4nhLNb3t91w+1VzktlDi2Md6U/ytxGfnlh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XqA6Uy0V; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XqA6Uy0V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729844449; x=1761380449;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xP/sZoc8+afwRDru/Go+U1d1QYUXVvtb5N1R6E1ynUg=;
  b=XqA6Uy0VWcnKpgSRaihXaIy4aHJt4pl+8mpocSPAehviNAdTXdBDnE7j
   JSbt6S8d98+PdooNmTwHZDcSVJt6sd/rL1KLggRx/P2OvJB5Pv3f/E2V4
   k8XmMIgUKYbSLR0yxR/23ApACY+if7XgjzEnEi4VAmdqEfNTAMV791fRr
   OaqiMp6DooE5xuNRU+aEuusar3+3bqRxXVr7Pv/9NXfJyB0qa3hJD9QFC
   siJ4tHERzwbmZNeSnj+AZ1GdJlG41W8dVeJKHHZxAlJxncgv4MwJlr8ww
   T7ciYkCm/7J/DUVCvwWV39MiqqGXxG5o0AbHlKuTZG/Ni7hc1eclE6AGc
   Q==;
X-CSE-ConnectionGUID: ppl04yRVRGmugqsVcEIQ7A==
X-CSE-MsgGUID: Sx3+v9dlQzCqc+Vf7OvECw==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="40880265"
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="40880265"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 01:20:48 -0700
X-CSE-ConnectionGUID: czZ+RO9RTTi4C9OEndM5DA==
X-CSE-MsgGUID: MeThFBhaTmOORFmGvAnn0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="111663904"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Oct 2024 01:20:48 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 25 Oct 2024 01:20:48 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 25 Oct 2024 01:20:48 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 25 Oct 2024 01:20:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vy8Kbw/kEYkL1U3PZLA7HlAHcJNQlGSWaubndMRhuJX1fOC7Wq1NEfKT5PRkue+v/ofd5G+Gg2oUAetB3mes8N56VgA6u+4jdfcBnlgkyesdt+MvSoKn5ULtqVgRSrB61BKMpyrG2JS7+GjnaIX0/Pro9rwxsv9MdcuztraX9MwEZJKJCBA24i++B+rHdvzJ9TGyJmsArTkkHjWaL69WA2ftDC1AuD/qcgYNU3tFGgqtmcX0zGhpd1kW8dxXV2JX953zCz3bsusK7wSl2Ui9D9vfEVTkNnIU3rrldAP3meFudhuetP9XUm7bbRe/OM6KVsczs+fhRb7AED/csoP8yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YeMOqq2McqZ7DyI17LL3Ze+EKLR76J8ghZbcj4ku+gc=;
 b=N40pyD6iXIIlz2sOVNX8qEZdfk0pjxLU+1b/Drcr424JjwGca3EVFCo96kvlMDne3ne1TvkldKCn3ptSUIN+duJYDgh/es1fXeN0dY7e75JTXp3/lM6+5Oh6yVNiv1ilEcOMlqxUi9qkZxGdUwWSyvfCQqjXuTk8q8mbh6nSNbf3K5Fq2ENsXXXjqhoV4b4pCqnnoC+olRtlIjYqQbIOscFattJgEyFwRxyBYu3ZcOWzb+5Yop0eseqn+J+QdW5jBTIXGpVZn82AiACq8A7KjK9aSZm+zymR8PVYC5xCH3PQPAWNK27MtWxKJBw4E7fco1OBak2YtNB1VvZa/yiCHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ0PR11MB5085.namprd11.prod.outlook.com (2603:10b6:a03:2db::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Fri, 25 Oct
 2024 08:20:45 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 08:20:44 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Steve Sistare <steven.sistare@oracle.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>
CC: Jason Gunthorpe <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>
Subject: RE: [PATCH V6 7/9] iommufd: IOMMU_IOAS_MAP_FILE
Thread-Topic: [PATCH V6 7/9] iommufd: IOMMU_IOAS_MAP_FILE
Thread-Index: AQHbJikTeTwjwu+2BEeTL5dN1flQG7KXISbA
Date: Fri, 25 Oct 2024 08:20:44 +0000
Message-ID: <BN9PR11MB5276D1CC86ACCB24E6C0BA8F8C4F2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <1729783554-56916-1-git-send-email-steven.sistare@oracle.com>
 <1729783554-56916-8-git-send-email-steven.sistare@oracle.com>
In-Reply-To: <1729783554-56916-8-git-send-email-steven.sistare@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ0PR11MB5085:EE_
x-ms-office365-filtering-correlation-id: 9280e7c0-18f7-484f-02f9-08dcf4cdec32
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?oHWvUKvLfEWJB6zCSZ5vUBxdeNJWnGjy3lj52XgdGyAifihop9LtCQ5FHZar?=
 =?us-ascii?Q?FoXUeYpT9C6LMj04ceYYSA5/8skKXdES96wNmp2bhwWBP12MxJ/Piq9qqsOi?=
 =?us-ascii?Q?cKM0GWYugTy+eOHtRBNpp9fuAKM/k7DXCogJ6Zhx7Gm+tz9ULnUU+Moc2+AI?=
 =?us-ascii?Q?NeqM5Y55uNNqPicmfPSIYe4uMZNi9U7pjkNfMsibw7OH2hkAEVSPwNTlukMu?=
 =?us-ascii?Q?B/u8FKQZkoSYWnUIJvACFHCCvssYjQ8YQho1203NZjr8xaMaz0UeUCQtGAUy?=
 =?us-ascii?Q?2XZGOtVgnmTRZ665dRSokmjYDFqpqiTzYVPTZuWlnnc+TcuknK66dIiAn/R/?=
 =?us-ascii?Q?zB1SJDG9ti5dW0wEjFagwcXykA9fjJGXFnJvA6K/zTCm1eDVOU+3rbaUzEzy?=
 =?us-ascii?Q?H7MZ0cL+JmcMNepKQu+AQBm+UIMG6JFMel3G5TBEf491VOxSrHVrI4BgtTN0?=
 =?us-ascii?Q?10CS6KVglKTuBjtPzki/bYDKHsdWsaD4niX7ENju7t9NxQjc+i7Jmm1M+YJc?=
 =?us-ascii?Q?ZpoYvRBQv61BfJnF6rSyfjYLNAi/MN4TGgNz59veggIfmjrbWPpDGoXbJdI4?=
 =?us-ascii?Q?RbbLNL34PuAlGRUDi5HIps9Xc50qEI1Rkx6dKsbzi1bzUWwsBtJZ7jft++F+?=
 =?us-ascii?Q?gzcrkyUz75YnxiqTIyrlrYlauT+GY1fiC2LQPHgkF7mv1JXk5hcS/Vzh8qK/?=
 =?us-ascii?Q?HZKwHPE1c8m2OSRMManOk7vr3AjOwYqEcxji+R3VZ1tV7ZYkEzdkB7pDULob?=
 =?us-ascii?Q?DCRpmOY/8wNWUi2IMCxuyApi/7aCwOtJRHyIZsY07ZAfdzdqCmuMPRH2/YH5?=
 =?us-ascii?Q?fDoS4HRz0JR2x2J6fdkjVdJ76NnQm+1k9hELq7Hf4rLwjaxtaDHnEzFJf2b7?=
 =?us-ascii?Q?MWUILprN517My2G9ySjfWYNfACCG7zwPPh0U6qazb5ssyi85tYaXWVtRkux5?=
 =?us-ascii?Q?jNdPmJl+HdMiA7sDs611rWMVRdF/YUW6W3v9f2S3BzMj18rfx98BfT2HnY+x?=
 =?us-ascii?Q?6AdeLuLRWpmdiwY4Nby68hd/By9nese3IokdULKaIku0NZl4IsmRXHdZpGEN?=
 =?us-ascii?Q?aXxs2417pNM/d4ZceQSsMqTvtG7gLPexvWZmJmoCYBMmQsyq01XzjH8ZkBsE?=
 =?us-ascii?Q?m0ZM1b/DoehJf+VkTdnoKGRD+lsy85iKLRVgri4m37hMGmN/G0QRmJg1Ol4H?=
 =?us-ascii?Q?Dgdi9aTQ7UFQx0Uz03xZ4+AHuAjRnP8t9o+8Xi5WCmfEjznOoikxNjbvrrin?=
 =?us-ascii?Q?DZoY50SNG6Y8rCL0yxY//dHHb65N8uLm5fBldr4S7vum0UbHltV1pUE5kvNS?=
 =?us-ascii?Q?qZjvqf5eF4o2Hp65oUmtnaPQvFLqPFaRxnoWFpPAOJWxMaYdueJyCofsY1aa?=
 =?us-ascii?Q?6/5SXLQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EDKh5sgsh05KSVRimqS78iYoW4iW1yAQA0VKEvUcP3skH/ss5JEYqNt9r7sn?=
 =?us-ascii?Q?mWx9Y3CfcgTli+K30jnT3h+4p/E9+gkSduSaQ/SbYYZ4huG4iGTvjQrMga59?=
 =?us-ascii?Q?/wnO7djRH7snBwdvzucLGg00VGC9Ln8V8N9SIWsylgjqQWQO+0Jw2BclddEK?=
 =?us-ascii?Q?XvBO2JBiR+9nb0YO0Qt3pum6lkEYH9oPSEtMZjWmrNkmU+88As/SbptoJPD4?=
 =?us-ascii?Q?CgUyGj+FjtAKDGIHOFvEeJ4gQyWAty40nGVUIdjW4p0PFGAGhLwK4rOIcF1E?=
 =?us-ascii?Q?g23JD/IY/fz0I5RNRKkyCJzRgTUwQOkEeQLmMcY2KfQrcEDw6asO2n9wL5Cx?=
 =?us-ascii?Q?IhD/UPu/dX2WOuK9kpdQTJA22+6kFU/ca+d5dJMF3GTmOj4KOib4M+TRPXCV?=
 =?us-ascii?Q?c5k9snl53u7bgNT1D//qftVHAhJ2LzrcV1jAvQ6a7DPiKzgoo/LyTRpqHToI?=
 =?us-ascii?Q?ZPkCZTjOQ7wUEEeJvV0wzHlcfix+DDJepE8GdGzoyOrqLiKmJK3vUBxogDtu?=
 =?us-ascii?Q?a/BbTQJUCHjm9a39j5GZL8h+1rf+Ke/DKHree1QYs2/K+YXQ9QronhGL35QL?=
 =?us-ascii?Q?7f7ApMEiap660W16bP2FOrsFeGpS0sajv84zpTthT4mTIMkK3ykOsyq5xO6q?=
 =?us-ascii?Q?URNOJ/kK+pPwT/51auKxgRU6a3NC++agWMN3cQfC7sL/wcg0tfCipEdiHXqR?=
 =?us-ascii?Q?5yWzAn9CwBts92X6WguIAWnfzrRrMxEFmcAbL87npKQwIQRAkXsA7Z7vrl4k?=
 =?us-ascii?Q?eLYzoUzjHs1IkFpoUYU1hITCEMN3UmrZmKCG5DtoQOzJ1Rm9vi3rZbHVjGvD?=
 =?us-ascii?Q?xucygDK6zp8+pfax5yJLWCI8MMxsyvFPgX+N5hvwDoY8c4gRqdFZuwFSf6a6?=
 =?us-ascii?Q?L14OOwshr3NkV3UA5182XGgc0g4OIiNPweEDh9fet4biUcxiRQrvRfhXeX0C?=
 =?us-ascii?Q?8flENu64xzxZI1s7nRx77fPIzfBjDbnwwoxM5Qhh+lZWq07jFBBwYGWwJfUU?=
 =?us-ascii?Q?IJh7BFMFayfXrHolkHuiT6+2lJaOBjse6e+HgxMzAW2LtfjlBoI/UKR4SPlr?=
 =?us-ascii?Q?9mRlyL+JeT4R0Ns8axk0fsO2dOycOI4SOD6NapH19WI3zS8yDb9/8n8/wKvF?=
 =?us-ascii?Q?AKqcP84L5Jsfjwd8mEMe3kF8y40sUEYFuBtkCtkTKw2U/bvsNMEjWtTdC7Ck?=
 =?us-ascii?Q?0P8SoL1II8D8hPmrerb+HgGL9YrR24agjfI7pla3fNrfsi1gy0n65d9OgF+6?=
 =?us-ascii?Q?AvUtDgu4fw5JS91hi6GGcDjEBNFr5+VQfhua5qHjoATHyxTlM7rb5jshsZNg?=
 =?us-ascii?Q?4rR7XPWd/0SWhpTIbirlgEyWVkxyoNpvnRETwHL92TSq2VPLWGiuF6pDfU64?=
 =?us-ascii?Q?45r+R+qKoOk4GAUtZOz1JAxNozND5D4BFZCPSAFkd4WZ3+Aw7T5Z8OmrCnQW?=
 =?us-ascii?Q?A6CrrycWRItb1CF2qLn9F2fj7rUXmmDnKqvJDjD18Ceq9g69HL4+1uyrcSY5?=
 =?us-ascii?Q?0yMAclVhkU5xYGEZlwEuBOZrRxldMmShiPpUTuD6NX26GjEGB7ri2Hhe1JCS?=
 =?us-ascii?Q?LqmlPur7vD92m+3PIYWh258zP2arZGeqt0Lg9QmI?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9280e7c0-18f7-484f-02f9-08dcf4cdec32
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2024 08:20:44.7425
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q8CYHG3lB5hbr73KCpe3O7F8G/xgLrOjwltwRpz3NVs2nkCYzQIy+STC+1XEaEMJLZOqUiGTA1/Xlvl9Ylk3nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5085
X-OriginatorOrg: intel.com

> From: Steve Sistare <steven.sistare@oracle.com>
> Sent: Thursday, October 24, 2024 11:26 PM
>=20
> Define the IOMMU_IOAS_MAP_FILE ioctl interface, which allows a user to
> register memory by passing a memfd plus offset and length.  Implement it
> using the memfd_pin_folios KAPI.
>=20
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
