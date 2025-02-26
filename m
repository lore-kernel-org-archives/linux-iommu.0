Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D96C26E155
	for <iommu@lists.linux.dev>; Wed, 26 Feb 2025 07:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740553556; cv=fail; b=fDTLd0LJkZZITn9W47AfmY1u5qqZqpKTCTB9qdVNGvXbgAjbIldJuorFCrVR63sbkFFaRDjJwpvircQU1zIDysbegNvPkeMEmXCB2NvXg8YA9UcD0c/zKUBtEQtPPd6/Yw0885NqQgsx+A9jTGmu/ZdJ3m+yHrtPOXOAmjvNVGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740553556; c=relaxed/simple;
	bh=KTTWJjCwRVBSJ9KJNJ0y2SmkvLoo+QJDtLPCV9T2zLM=;
	h=From:To:CC:Subject:Date:Message-ID:References:Content-Type:
	 MIME-Version; b=T9fNjp2PhGCp4GNlp1hfsKjTPAhAadplm2AJQu1JEYIw7N9EiQn6fUl7RAyWHie7ZmeGTcWKk5bqKOrj+Xr4MN7dTHzX8Jgo0nFReH52zIsYJmPuQzY2AjslFs4AkjsLcTM11eCH7enIiqYW2wV9HTpIs+8/6AXmvMaMH/lmwJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nOSMereJ; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nOSMereJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740553544; x=1772089544;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=KTTWJjCwRVBSJ9KJNJ0y2SmkvLoo+QJDtLPCV9T2zLM=;
  b=nOSMereJVvv7B4oIRp6PX5l0JdVTDRl01qe8KS20Tci997ehw66XQlBR
   IB5xYZuNSYuOhKDM/JICLh0vLgqy0APGp+bT4EtFN0Ihf3trXkFt2fZ+e
   MijDGU4Ygux0sF7Prygk94VSSaj8OAN1LBfJqcr4/FHLEdT2ltA27yNEc
   1jO0DnoOE0VDf/VGf/mQW1xSvpvqOk9KcJ4b0gJfrKWxn7JYRfH0tuLaU
   S7i/mh+jMOzfx86TnxaHxRvN3GiCdLLy/NuwMyixjhJ+rdiP8czeoQX7s
   nZgdmkFwjQKK6aneKO0qPOpLdONupvBM41uvkWG2JYBO5OoBjIMLH+1YE
   A==;
X-CSE-ConnectionGUID: zhaGME1iTr+n3ruYfuHknA==
X-CSE-MsgGUID: GS1Ng0z0SdSwCrXCs3ZhKg==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="52781585"
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="52781585"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 23:05:42 -0800
X-CSE-ConnectionGUID: U+HZ/lwxS3GRqPBqL4+8RQ==
X-CSE-MsgGUID: UFbxRi2/T+aSjfHtBfrbrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117547145"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 23:05:42 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Tue, 25 Feb 2025 23:05:41 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 25 Feb 2025 23:05:41 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 25 Feb 2025 23:05:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wefSuGNop9uHDHbkLp4abA87dtmXOUUJESZX2qPyex4R39s5hUr8fDWwAa9PoRvtG6/KEqSuUTiG/U66/gSJO8vfXj3LbUwuOeiT5BM/5TICz2llH1fuHnUhC8zP1actTxQJi7jNxDhIfat8vrVmpGGXPfFaR5vuGfktoc4Qs++4UWT4jDusHIOXfKkV7CR7htjzMx86FlpnqRwJsWb+z343+vHO5CeMFv97f2qHpxOir6pBl7qIp+Ugl40sjpmQBNjVIxMjFsx/sllKwTrHGquU0StKr8rpOcjxBtiX0Ele8WKE6Yw1Z/J0RYRLANtPbqdOb66E3erdMw5/nThd7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gepauyl0Z+MQYZ0X3Mpa0iQTx0G7dThnk20rUpDTk9Y=;
 b=ka+/QHmA3VkaSiX7lYFr2h7IxlyV3wscU2HqrGQjt2jVMNKzynSmqX/5SwvSupjyaKjUC+XyQlY0xzGXm249B/b75BU2LKa1UESldVjNO9d81F3XV34PH9vHSe7l6FR8yiPPLbpHGeGSY6iPHLX2z5TnXfbxoF2gLRhPDyR8TAAcsiUyT2j+Vc7loABg+98fdP68TUfN5O78uzIhjM6z98wloF1QLzhK2JhNBcNU7GUgQrN/bGhrSy4Q6xuaBX/WFoUB5FMDoX05emMrLLewKZMIh5patUUtf1oBc+WxnvyeFVOW9mQVwMBIFRrcQs8lZGvYm6+l0LMhuJCEpbG0jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA1PR11MB7943.namprd11.prod.outlook.com (2603:10b6:208:3fc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Wed, 26 Feb
 2025 07:05:06 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8466.020; Wed, 26 Feb 2025
 07:05:06 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: Robin Murphy <robin.murphy@arm.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
	Vasant Hegde <vasant.hegde@amd.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>, "suravee.suthikulpanit@amd.com"
	<suravee.suthikulpanit@amd.com>
Subject: RE: [PATCH] iommu/amd: Add Secure ATS support
Thread-Topic: [PATCH] iommu/amd: Add Secure ATS support
Thread-Index: AQHbh3UOCMVRgdan70yjYJFDyKuOHbNX8z2AgAANboCAABr8AIAApFIggAAJnQCAABasoIAAQ3ow
Date: Wed, 26 Feb 2025 07:05:06 +0000
Message-ID: <BN9PR11MB5276B3E410FD336A3062FA5E8CC22@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250225105829.52223-1-vasant.hegde@amd.com>
 <be9d2ad2-0f9e-4d06-952b-4cfd6ae53447@intel.com>
 <ce86ff90-377e-49fe-9c4e-d2ad7abeeec8@arm.com>
 <20250225145518.GJ545008@ziepe.ca>
 <BN9PR11MB527624C1DED16B3C049D13438CC22@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20250226011750.GB5011@ziepe.ca> 
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA1PR11MB7943:EE_
x-ms-office365-filtering-correlation-id: fdc93905-ca9b-4f6c-f9fe-08dd5633e67a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?ccDfeAmLGkPc+102LQyWNMPgB/p9mbdaQeQPneOupcUYn7Ej6ZWbgo5trWnD?=
 =?us-ascii?Q?bE6dE56EEWGvv3FA2mSytTLsBHY5XIdlrnCGNwYD/DESjXm6iUK/wcj4SJoU?=
 =?us-ascii?Q?s0GKtTIDOYMZUL8gQyqwons7Y062zWwJbtN3Cj1cFjR3tYUDfDpnQq9yATzZ?=
 =?us-ascii?Q?fwxJBnHu6B0M6aOQFS6FjnLS2K7+Y0PT7a6XWl9jnn8laSRG76k/jqcNZ7RT?=
 =?us-ascii?Q?LjIu+dhjHagJ097zTgCRA4NWaPdoguagBPdOQfsCsEqm+7DS875QGJyIh5fh?=
 =?us-ascii?Q?uZea5YZWEsRe7uj0nnSjWjnvzttGhDsqqYIqxrqsCBQ00GOT4I4UINKzLIUN?=
 =?us-ascii?Q?ErirvbOfGlZQWcKPPpR3T3IiWk84L+okUcN0L/dK41Y2taZnrLzxUEFtMxKq?=
 =?us-ascii?Q?PiLdJxhg64j2ON3N17yuLePjSqeic2fSIzvHQihlehcksIVb2wWGngfZjDAt?=
 =?us-ascii?Q?1lYhX0dIxe+h41JzdYCNmUeUMZbqc8wOKenyfRbsQd8STm/eGg4pSdak0Rwx?=
 =?us-ascii?Q?vq04NNJo21xSXRe2JEvL/By0jSk52KSzDnNDULaNRK3ojH2vw9dBCPEa1gQj?=
 =?us-ascii?Q?L7yXNhPwv5JSqLcpQ4DYP/KaH51kvPT5lB0FiS9tnlvUijQsuO4njC1Y5YBY?=
 =?us-ascii?Q?WFBq8c4C+ZmNHrilqLQhbrAxiCqns2Llem9ZnLXOm/Fj/cYmuJ1tOVHfiWbw?=
 =?us-ascii?Q?6igPLo4Np+KBX8yVJ47RSsKLw/vqjn40ouRQYMw6SRtDfhvKPIjdULS/h46v?=
 =?us-ascii?Q?cqMN/iaDl10YQYZfJ6scvlI6CkpOG4xXRr6X2X9OjW1cJYsJK9qyN3VReGCC?=
 =?us-ascii?Q?RXomemHcPPme/8ZP24bJR2vc2pi+li5La11k3wRcbUep/fwBcsuM/W4Z2kKK?=
 =?us-ascii?Q?HENuWhNFXFofV4w+Bu3esSpVo9UjPXi6P7Apzv5SrkzXXdC2drGAavQBGZ8/?=
 =?us-ascii?Q?7un3nZzmmnlROn5411tdgmQOPgu7HoCqb+r0yfSU9GYta6VjMNYFqAZhBzNV?=
 =?us-ascii?Q?2eSw1jiMlZgbgE9nfAHdl50EYzRC39434+lPvwgvo1+ubVUsxEPV0mktla9j?=
 =?us-ascii?Q?W8/sUq4zYK+07NiS3WEWK/Pk/3lvCPRZeVKm7YkZK6oVKoSXMU6YNPuhHbVd?=
 =?us-ascii?Q?ucmS4o8Ie17XkXklarOmbqUZ6J4D45OrWOunebDxE/yZ7lFmBVNyywTFFyJY?=
 =?us-ascii?Q?+GYy8asKGNCChbnWBGSeKcz2NllDy2w4o9c7NYPgSHAY4unf9jRL27kWKpA8?=
 =?us-ascii?Q?SHhaGX/D+Zq80maYPA4W8hxQdjIXmwBSrRtUpbRvJwIhzeDCyaovYdX4ITiC?=
 =?us-ascii?Q?q5E/pMJJKRntF+/RnA2hiMbGRhGrmn7e4KgJfUsn0+9kN9eeu8V2jXKZOVRI?=
 =?us-ascii?Q?Qi83s3975Qb8eV1K/ZwbTyt/vYf6ECoHZcNUVRhCXQjq7B2vwoiQLbVBbdCB?=
 =?us-ascii?Q?/GOsvP9wW2vGcVuPXft3MFJLss+ZwcOn?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kbPRPeOond2euP4+UXBA5QoHBVx5zRHvBscqNdsdu5Xqt44dGWcs9sg3/sOi?=
 =?us-ascii?Q?JmuWHJ/aWkCDgfJaCcMywvgX8yVx+KilpBZhRBfY2shOrximyScvp3jqGY3P?=
 =?us-ascii?Q?eXDCnsHn2Oq5wNR3GBXNsA6HBa9JdBRmzQMwgUaZwsazUfMOkvQ6CfB7eRP0?=
 =?us-ascii?Q?eFm4GCRQJ5uiEBSH2lXDaMmpXl0JdS6AqxwGsC4ZQc66MBCkPmHeRBAmrElu?=
 =?us-ascii?Q?oq9r0O1/Zq26pmHdZlEtrYoUrIWuTeSkFYc0bZGb62yxJwN2TR8QA13VHao5?=
 =?us-ascii?Q?RT7X2nwP87j3196VaZUccdp0H0GGbi6l+MEg0NVIKz61h6j08KeUbdEth8BT?=
 =?us-ascii?Q?X6TLFxuhiKSK5wjfEK9JtrogrRsnBcdiWeF7aJVkzorrJymHt063hzw8LdMs?=
 =?us-ascii?Q?MQ32q1G+gz5lLVt7Rm4zbukIJFYQMXoweyVqD044PPXyqxxICf41mLEEyAcA?=
 =?us-ascii?Q?QQ26xx1b2CJnh11qo205VDWXKbqLc7zTqQomoctXx+YVVRxqj5kyRogBKC2V?=
 =?us-ascii?Q?5H5AuPX77GxTewW04wQhudZUlDkjm1Lg4Y0bO2B81Pb6tRZxNXbRjxtro7C0?=
 =?us-ascii?Q?R8pS//NVN2U+9HOWjHU29zlOqop5LLbWGmDuYdCr3y1GpvxzNUWKz6dIjNYk?=
 =?us-ascii?Q?o3tcoAq/YqOEglERmevM1Ris5HuqNJGOgPfFouqeaaKd7jv+kzBiyfARDdOe?=
 =?us-ascii?Q?e2uQFC07Q3BF/CzxK6BrqTe+To3UP73x/9EDPLWG49SUsL9WKnpprw0EK6MS?=
 =?us-ascii?Q?0C8RWEQfJ56wwSgnsLouXIjBjTejX2vwMyfzl8AuwRRBEq5q+SCUDj4Q0D+p?=
 =?us-ascii?Q?YlrHp7agjgmY/LwDUFU8Yw7uDmvIThN8fynsrs9tqO7KTCGLGxEEV5jTl7LT?=
 =?us-ascii?Q?gRpFxzTUKWeu5oKOUIA/rZsSJy3dK9yCFc7QNddXI7puDqSgyRpsnDqI1T/Y?=
 =?us-ascii?Q?TDl7FLX0m82czn/Seop9o9+waXhO73WHfOJbslg0GYd8ZJdRaougzliKHOss?=
 =?us-ascii?Q?NQQfJWPPobH59gM3weTieBtKs0ffBtkVaxXFfJr/SO5UPUjHfFgY+PAmYMh5?=
 =?us-ascii?Q?g8z0wigC/Nzott+yY/GFWErRfs1KkduGQ44TbnukTxcbLiQFZzNSwj13698s?=
 =?us-ascii?Q?2VPZ01R2RWJ+lQjzylTrwueYY+gzmith43G6f2oMXRe+NZuwOmk+caCJKw1x?=
 =?us-ascii?Q?MpxCrtJE5BbTxHbDtD5kBpnAx7Fozf6ZeLU3IIJJ/A64IYPZ3WO/P1n/kfJm?=
 =?us-ascii?Q?T4wfwHYBRXsfIzuioDGSQhcJ2W9huGgsYGq5Wqv4mCA5NDHcVdNuX2IICOli?=
 =?us-ascii?Q?U2BOcbrGU3auL23BJSl2MFxBiJi2rgoFCKHIWRnUSXNfdR1F+1BWs2noQJbk?=
 =?us-ascii?Q?5fqM4IMDGGTXrqiAjnsytOpRrBfKzpDxb6vgoh71yjLCJ3yIzDHMbJzCuZFc?=
 =?us-ascii?Q?Sm0Po5WbR/qzFMQEf1mDTR4+yUzFkW2hEGVvkzx0y3CIlz1twjQP5beG3KxJ?=
 =?us-ascii?Q?59wDEInEWuzo0oM+CDz+kNarlhgB/yqPg84ukuqy01DewS3onEjE9BNV59Qs?=
 =?us-ascii?Q?xfhFfoyJ1W0qhnGTxbqSkXwyXaK805kA6DzmONUF?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fdc93905-ca9b-4f6c-f9fe-08dd5633e67a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2025 07:05:06.6569
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PbBeMHf1fEp5lam9s19U6bqWDKAmFTl9MLWR3miAKflPrrPz6+jZ9CY5CCVwbvofs7oolTf/lz0sgtzEE5mwEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7943
X-OriginatorOrg: intel.com

> From: Tian, Kevin
> Sent: Wednesday, February 26, 2025 10:51 AM
>=20
> > From: Jason Gunthorpe <jgg@ziepe.ca>
> > Sent: Wednesday, February 26, 2025 9:18 AM
> >
> > On Wed, Feb 26, 2025 at 01:12:38AM +0000, Tian, Kevin wrote:
> > > If above understanding is true, my preference is to support a sats fl=
ag
> > > in domain alloc (nested_parent only and PCI/CXL.io only, as the start=
). For
> > > AMD it turns on the sats bit in the DTE. for Intel/ARM the permission
> > > structure is created and updated according to the map/unmap calls
> > > on the parent S2.
> >
> > They are functionally different things, and have different
> > requirements on the PCI topologies supported (eg CXL.cache vs no
> > CXL.cache)
> >
> > I think they need to be different flags
> >
>=20
> Not exactly. They are functionally different but serving the same purpose
> to the user. From user p.o.v. it's sufficient to have a general flag for =
sats
> when allocating a domain. The underlying driver decides whether such
> flag is supported based on the domain type and the associated device,
> just like checks on other existing flags.
>=20

Chatted with Yi offline. Having untrusted user control a security=20
feature doesn't make much sense. Probably what we really require
is:

- IOMMU core exposes a separate sats knob per probed device,=20
  allowing the administrator to manage the sats policy which could
  be no ats, unsecure ats and secure ats (might be further set per
  domain type in case the hw doesn't support sats for all types or
  the driver doesn't support all hw-supported types in one batch).

  It's also checked against the device type e.x. CXL.cache.

- Then when enabling ats for a given domain type and device, follow
  the policy set by administrator: ats disabled, ats enabled as today,
  ats enabled with hw enforced security;

- Optionally iommufd may support a domain alloc flag for ats,
  which alone is a performance or functional dependency (by PRI),=20
  hence better to let the user opt. If opted, again follow the
  admin policy whether it's allowed and requires sats.

Is this way reasonable?

