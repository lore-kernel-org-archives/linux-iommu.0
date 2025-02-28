Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA37D23DE
	for <iommu@lists.linux.dev>; Fri, 28 Feb 2025 06:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740723536; cv=fail; b=tn58kUJsVuEUfNf59uyZr8Z/vyXm0xV81aiSAdBcJT2qQNsx35eCAlqLCqPpKW9v3y2tDVfNW0yorVf7DHHtDIWgEa/Ma5RKx03LM+nyO8A734z3PAnsMCVim/EtAapX0mzMApfx7vfIyc6Z4oDgbvD1/+7c+0tLXWhnHaiVPJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740723536; c=relaxed/simple;
	bh=CoSAF39fGVGNba0AKer/XmlGqrfSOS4ohFDBLbciLuU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q5viQMBSjLZWdKpRWCQbTg0ilWoZULLJl07SrY7HDT69i/EIRlUe5gB0ihy6xioqg10gfH8UT8olSrJmoP8uDneXYe77f/jjmbvCzQp3C4yjKRY/3DenbOAISo5g0FP6WElkJaWl03gSC3xh/3192szKZM/u54oGfMSgcBcSohA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LxudMfsm; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LxudMfsm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740723531; x=1772259531;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CoSAF39fGVGNba0AKer/XmlGqrfSOS4ohFDBLbciLuU=;
  b=LxudMfsmoeHJT5FgL3o5IFDcGGi7HiLgkaw1m5B2GG3RKfH5B/OQioBC
   1Gl+9qWHotCLbVCtatTl2m5r9GQg57I2NIxU6YcVhHFEewqlT3jjpBAOD
   F1q4zw/y+psTEe7BJOQTTN7P2rzTDOI1YugCm8UvyK4JEXWKtpJeLcmz4
   po/8zSm++U3I5tykESycb5rcj0dsOZx8x437S25nFZzenZZ3yFITdGLz7
   eLYHwdziF5JXFnW116UdT1XFPNgybMpW9qchytOuPkA04Ap/1jTt63JY3
   bYxI/g6NlmUlBVPcVNKoXLJZcngJw1BaTF1mK+eJVU2LWHQ7BIrtX35sB
   g==;
X-CSE-ConnectionGUID: ivw5zjhITr+tyJZvPlKKfA==
X-CSE-MsgGUID: X400GZTnR+a5UL1nGC+Nzg==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="52277974"
X-IronPort-AV: E=Sophos;i="6.13,321,1732608000"; 
   d="scan'208";a="52277974"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 22:18:50 -0800
X-CSE-ConnectionGUID: Cn2//yM8RaOkSR0o5swXJA==
X-CSE-MsgGUID: aAGZEIozT0eZO4slr/600g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="148167228"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Feb 2025 22:18:50 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 27 Feb 2025 22:18:49 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 27 Feb 2025 22:18:49 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 27 Feb 2025 22:18:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D4s7tS91h9t3pfLGx+szE1ayYxwbCGr5oxScxqy58Vc9Wr/TChzzz3WeQ7Jk1lWZewnxjF3n39AFqnSJwDI6dpaQwknxH1zs8DO7BtHnCKfEcoC0TnT1ZVmy8iUkoMOi5UR0AsAFjajphdMKgRgWgCRq2elgTdWzeGlGowglFzbZye4YCjeWePmoQ0l3YOuwRHvcSTsgw6BHuQwC3C5i9vIvzALq+3ShQy2Y9OMS/F+hZuoEmpP5400jGQBR5NSJUb1iuTD0jyGDyA1sWELf972Lfjza04cGsZpgBN9kO/fFzFiZLrdjZimdUyozU8dNcSRRbVt1g//AL1lkFwdZoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XlMvrjMRrcsqHdeACAjcdxTZrDFJxsuPaC6S1MDCXCw=;
 b=Px7pYbdtoReMqe+RjoZunSRbmGeHDFR5mnigiHw2IfgddFg2ep8aI9bJ12Pk3SSUozSJNv9XUCphAms5U+3A26WTZTfuuAmhDwhOslFEQ8qCtA3FuBphr25A5ni7xmB91EuOV9Fkj3DxorO39WzlnQJ+lOT13Em4vCQxrj6FZiaXtSrrK8V3rYNNkaGLp7frbkTZz510SwDimt8jh6qfjkrlQOi3KRh72xzJ0SWbyn6K3hRiSvSAU6N7CNX/DDL9h0HJTJE6YHVTtWXVQW/Z1HNciyr87skdfaN5Zo5WurZbEcn6MeVhUvhDNQqb/Bvt1tYcvv4LewWznIInasYJ3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ1PR11MB6203.namprd11.prod.outlook.com (2603:10b6:a03:45a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Fri, 28 Feb
 2025 06:18:47 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 06:18:47 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
CC: Robin Murphy <robin.murphy@arm.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "joro@8bytes.org"
	<joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>
Subject: RE: [PATCH] iommu/amd: Add Secure ATS support
Thread-Topic: [PATCH] iommu/amd: Add Secure ATS support
Thread-Index: AQHbh3UOCMVRgdan70yjYJFDyKuOHbNX8z2AgAANboCAABr8AIAA6H6AgAAmfHCAAijjgIAAhjcAgABnvAA=
Date: Fri, 28 Feb 2025 06:18:46 +0000
Message-ID: <BN9PR11MB5276245A0D71F8F169C6E8338CCC2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250225105829.52223-1-vasant.hegde@amd.com>
 <be9d2ad2-0f9e-4d06-952b-4cfd6ae53447@intel.com>
 <ce86ff90-377e-49fe-9c4e-d2ad7abeeec8@arm.com>
 <20250225145518.GJ545008@ziepe.ca>
 <b630b6c0-a25c-4230-8abd-a48b7dc27216@amd.com>
 <BN9PR11MB5276B090C61D1F059538AF7B8CC22@BN9PR11MB5276.namprd11.prod.outlook.com>
 <cc4cf4ae-2d29-4747-b655-df841661b82a@amd.com>
 <20250228000424.GJ5011@ziepe.ca>
In-Reply-To: <20250228000424.GJ5011@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ1PR11MB6203:EE_
x-ms-office365-filtering-correlation-id: 5ff7aff6-439f-41e2-610b-08dd57bfc288
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?tQ+1/pqjJkWvCvnNsqJfmjSFlIfyb7AMUb9peRPLNESeu+/UOhedEgRbO7kT?=
 =?us-ascii?Q?7RoMotzQ0SedUIC+OnhzKUJfUTeTr6sz1TN91+vh/j3qpmvSuJ4kGDMfRTAp?=
 =?us-ascii?Q?1hATtc11V5m89UClb2Z/28KjYzrwtujyTN1LJPiFqaSTR8kT/TBo8d6c+1Xg?=
 =?us-ascii?Q?ZBWcY05cqhO5nNdxWErDmzHWYdWDXtMmgy20aR2A9e2C2p+Pf3zR0sIz7t7R?=
 =?us-ascii?Q?MLmjsZjY5wAQqf8cbiICzue/rmL/rEcFpQaQxOML3Z6Pd0unj15jcNwBgK1b?=
 =?us-ascii?Q?SuLlmWbKvriB2UiTL8uJMCm1lDAGji4DiG0RoJXkfy3NF8h+8l+gSMndCu17?=
 =?us-ascii?Q?lxpas0Qn0dkgg2uWxU9LwMn0U3mLn6GNrUdVNhW9+6T7DfAh7aHJBBlpWAHf?=
 =?us-ascii?Q?EkROqW9kmGHXEc6D/Qtq/TLH4sH+RtR5TbC/h40XU8ujZGpZ1e8WY5yXT4jf?=
 =?us-ascii?Q?grTrXEkL2LPsim0Zs1UIUA3b85mkRYvKKuvyUovGBe2I9kYCqQLn6y8lUNJG?=
 =?us-ascii?Q?0KmVKtbEZXTnlnAR4Nhk1Oales1bM/fapQSGWg9vN4JDV1eFxP2sxCsPvCOx?=
 =?us-ascii?Q?h3rfwvulloIwVW+rklzmobaHOkniWNIwxGHVEH+8a5oAJLKu1rKgYZcc5G6P?=
 =?us-ascii?Q?ihbDxAIIE58UtkqmTXY8OH+DtganJ+uXc75BHyRMMTLdewzcJWFsRu9uvxqT?=
 =?us-ascii?Q?wt9BWdFKwxm/LjjqDRboqkySYktBP1IAv3cSeVFKCRUohq5yWy9ei8pZq7TK?=
 =?us-ascii?Q?ZGpEE5EJ7tBPbHxdEKyLCxv/WcRYuKjxrEXfxrsMFyQyuCeoGF56PoHoG9D0?=
 =?us-ascii?Q?CLMbSzmyOOSp+TX8z9uo8XJ0GnAIv5FvXvtIvaOlIWr5f6vp/As0iRM9FJqk?=
 =?us-ascii?Q?kCvHji047BoRBFCNlTza8vdLRYZ9ssDMP3vALyZV5seqd7XA9pa73d3wN/F0?=
 =?us-ascii?Q?9DnxR0h7Fm1ljiTt/15xeICQA8yJzCeP/lSHLXD63swWF2I83vUn39R3LiDP?=
 =?us-ascii?Q?sSkXYuB2+6CGij8K1fdAwBnZ4L6AMx/1mblmYmxDcbQBl8HgvS+ZQ1JWtJhF?=
 =?us-ascii?Q?vgXaqV/uqqxbQYpDNVxwuHxxKe3VmwiSnE33BAYmbL+gMtoltV1ASWecs12r?=
 =?us-ascii?Q?88m5ud42ZztJgN9fuoB82XEX/IjpJ7LvbLwebXVpFKe/o8Z3usHTwEACNtc2?=
 =?us-ascii?Q?+fauc1HNc0lgHmQS0T4RGjeAPX4F43OuNI4JkQ3HQkOscju+No9EaS3K7wGY?=
 =?us-ascii?Q?YgfsYSU33tr6ZqJV5AaiBwEiM42CtLGXej3cen8zFtj1IoD8uIHGUGQYl+dG?=
 =?us-ascii?Q?gXChiYolWfZeXUwi1By0Vvj413PGRLeGXynYpmqNAPqbjD/9HYEwx26pEHpE?=
 =?us-ascii?Q?MUVkNe1o4VU0FGZ56NarU7YrStFrbc4DOLAyQaAfNRtYmRTGWObiVTPEzQfs?=
 =?us-ascii?Q?Wpr21hsZkNMpXqm0Fwu/UhOcY5tHN102?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jGh5DGdI+5kedz5mG+ytD5YZxybfsp5xAy93IwrSIhQHLr0SVAvACnBuXXo6?=
 =?us-ascii?Q?SrWxMbVl+MA7ueO0EBgDev/mgMiEsQg3tyBNf32fTRRz65xspNsTDnicTIRl?=
 =?us-ascii?Q?e+9MFmJV+qDjQQxqo+Lcxm/w1xF37cW7myeYMjUwwJHKd8USh5vZmsJ0LIC6?=
 =?us-ascii?Q?8zeN2ib5SQ3jcu/1egEsHfg2XlMzGUMysht0RU/d1jakRhkQZpGImQSWN24D?=
 =?us-ascii?Q?93eYtO4epW3hwP0ls2krTMPt0mJUOcNFOmn/4stjxmPYWa0BzVjsijJw8a5G?=
 =?us-ascii?Q?27plyMkJ2Yz70KYUOiCDQdlKhM1M/iNw9VjW35cwjl0o19J8CcTkUugsv2NG?=
 =?us-ascii?Q?9OXR9J3aCc909/m9cdivAQtd87GWFwd17bri3ycySB4wrYI6HQdLt3sD7i9k?=
 =?us-ascii?Q?xmQzkydo8BtpmR9NWVpX3VSFkNxNu0bEsYIaeog7AWfRwy0FR9LunhlYouHs?=
 =?us-ascii?Q?dRdRCytvuWLDT53d3V4JkttGPzboMWlA3/dCQxDFYufIqnENSCDRFzuZ9HiO?=
 =?us-ascii?Q?yZTAwVZUfFkgSo1+Wigb4dAdjNcvKDH0AhzaCrkFk6Dgv6GFgJVbJIbv5n7k?=
 =?us-ascii?Q?ND2tlsGyzHXg8HfNk8zz9pD6Q1GZNR3K7L1XBrcjk/C7REJg2ybq3Rwv8Hd/?=
 =?us-ascii?Q?E2kg0luHt8oGKIY7NsqX12AjzYFLRr80chU/DikbbJH/o3B0ZnIEph/brHau?=
 =?us-ascii?Q?XNljmKw0pYKLEUhFWFYZH2jUNqOV98JCvfM02yFiJbKAUFRQ1pvRZMW5aqOU?=
 =?us-ascii?Q?alcHF1DjpNP8IfrPaSAzF3yH9Dljtmathk5tiV59P5D1u2n4AyBhq9NMBx61?=
 =?us-ascii?Q?YPVc+75Ouo9wtjhtbqY6FFbN2dCZf6sPSbnJMMpmYlPrWAfjWHEkoNx8zG7i?=
 =?us-ascii?Q?+rndBLMzm54LA+V4wI3kmE6n9jRVZgvx2s1HsFloqsKyiWwL1XcxC+fe+LD1?=
 =?us-ascii?Q?a8Vt3VkDnEUXk94JKh/eVCEnPvx8KVd3vrWynkrjXOr4fQ8HEgrnGvzVFFrp?=
 =?us-ascii?Q?zedqgiy/eqghaPMwTX8OROYuKyHzoG3TbjUQh/xHhHENzGXBrxfImQHSqoUq?=
 =?us-ascii?Q?aAQFcNCbIX8FV0IjKZNydBT9ou+FBma4PvwnAiYU9oaB0YlnGZcFla4rfY5Y?=
 =?us-ascii?Q?oD6xR7Lkw9ZPfwjqIJfA/ySriYb0ur03UFxJBB898ZzjAZEwzIqeMBZyj3/4?=
 =?us-ascii?Q?j1rrFOFGNvITMHfD3oVIjB3qdEAuWn/eURiq15cWo6s1fHH0lrVvYUfVENlq?=
 =?us-ascii?Q?UtPIkfRoLDWilgJ5ljo5I+DwWzDfuXKv6zAVgA/sz9hvGOdp1+Oon3G8bocy?=
 =?us-ascii?Q?xRvwgo6ocZJNZP9PgpVhaEHg7W52MsjcvQGZ+RLtNnfXwJ3QZLt7w+fIl0uw?=
 =?us-ascii?Q?va+Pz/G8PCBqkrSwPTWtgB7m4/fs7SiQNmp4ppVahOG+dpTlgEGBlqCw8mJv?=
 =?us-ascii?Q?dIPqYEFpmRHhcUtuw6z9qL0xUZJBDPu4Jdd82L8ATYnoMJeVC5qGxIAZ5Pyu?=
 =?us-ascii?Q?9QrC5gDKQM8K0KT8MVMdfydne517B+uoFGFJ7vXdVYXsmGMNMRET5xOAwRgU?=
 =?us-ascii?Q?TPWzuwDi9Hs9Nb2zvFgpQ3YedwHsKCkPmxZAbSJ+?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ff7aff6-439f-41e2-610b-08dd57bfc288
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2025 06:18:47.0169
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5i7U7zcZ3HDHvFvLO3kvbusof/JASUZ72uEVwsDtjffIoJ5Cwo6i/tCUEZuxg7C0la6V6bk7mV5n4tWqRNNhJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6203
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@ziepe.ca>
> Sent: Friday, February 28, 2025 8:04 AM
>=20
> On Thu, Feb 27, 2025 at 09:34:01PM +0530, Vasant Hegde wrote:
> > Kevin, Jason,
> >
> > On 2/26/2025 12:40 PM, Tian, Kevin wrote:
> > >> From: Vasant Hegde <vasant.hegde@amd.com>
> > >> Sent: Wednesday, February 26, 2025 12:47 PM
> > >>
> > >>>
> > >>>  3) TA is an IOVA and the IOMMU runs it through the full translatio=
n
> > >>>     to validate it. ATS is just used to signal non-present
> > >>
> > >> Yes. AMD does this when Host page table is configured.
> > >
> > > Here 'signal non-present' implies to support PRI.
> > >
> > > But...
> > >
> > >>
> > >> We need to consider various scenarios. For AMD:
> > >>   - Currently on baremetal, we cannot enable SVA and Secure ATS
> > >
> > > ... here it says SVA/SATS are incompatible. Any more background?
> >
> > Sorry. I should have explained it better.
> >
> > To support SVA (PASID/PRI), we have to configure domain with AMD Guest
> (v2) Page
> > table and host page table will not be set (DTE[Mode]=3D0).
> >
> >   GVA -> GPA contains translation and GPA =3D SPA.
> >
> > On ATS request it will send GPA back to device (which is actually a SPA=
). We
> can
> > support secure ATS, but ATS response will contain the SPA.
>=20
> I see, that makes sense. The TA is not tagged with a PASID on the wire
> so no iommu can support the #2 form with PASID.
>=20

PCISIG has a ECN allowing translated request to include PASID.
Just not sure any device has supported it.
