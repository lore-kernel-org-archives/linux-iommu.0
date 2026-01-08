Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2FE23B63F
	for <iommu@lists.linux.dev>; Thu,  8 Jan 2026 02:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767838956; cv=fail; b=PIEmH5glzCql769n5c15NgOjsZOdfdWl9JJoHn9iKNw14Y2yIE1UozY14e9LtdnhNKpsGUzAA7Oe3otGaB2B4Feem5Y/emSOfE5y/Hi6iXdurQVRuxcUiegh1ukjnXQxFr6cY78DBFkh6OXdpkesmg3QMzfJ6gDsU/oLZPXEeLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767838956; c=relaxed/simple;
	bh=LAwAzeANInm1GbsUFcoYJQhE0Q9HDXVjORQxsm8UbiA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Hnfv4lSKMrFo/uLGqKQBmTsL7sY5WFkaQFSa7ukWjxQwTOXMorExEv6jKNheE33MEl35M+CffIOZbvUDp4WCKT5ysYNfu6fopLRE56X+E7iKURs1U8/IZpcfdpqokrJyEehG2xwDbm2CbOzIhBa7XMCzJmV8CpB8gp6ZMh8rmGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ALnmxU3J; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ALnmxU3J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767838954; x=1799374954;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LAwAzeANInm1GbsUFcoYJQhE0Q9HDXVjORQxsm8UbiA=;
  b=ALnmxU3JI0zz+VEAKsFv7RXhfKPD0g+8O3DK3pg4lor99GuczgPOHriI
   axhwjjk+Ca+4AlF1qOPSm2ANOYKhdYuufw/NQq0wjsUkmu54KwsW7/jVq
   1esWUcUbSI+Gnna8qMJKZQ+fsXBTRfa+XYTas5JdLa3cUIqZ5xDpW+Umd
   9+ipD4pHN5cjFKFV6OL4xjv/9f4M2pmEKaej1qjYEfn/Px61IQzZB9Jcz
   81jg/+JcvHD6fd2JPHBLrjxlTU+sGN9siMV3T8AFwBDh+v5nErwBcIGsi
   m29FfZ+HfMmUlKQcdBdfayastN3MNtQTgj9usJdBTEXRm9Pqig5Pia1Mt
   Q==;
X-CSE-ConnectionGUID: w2lVzFeQRw+l8j8lvE7Epg==
X-CSE-MsgGUID: 3gb4HEPGQCGhS4BxK0yduQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11664"; a="69115903"
X-IronPort-AV: E=Sophos;i="6.21,209,1763452800"; 
   d="scan'208";a="69115903"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 18:22:33 -0800
X-CSE-ConnectionGUID: 9LV0mgf5TMCCP8aV3mPBBA==
X-CSE-MsgGUID: iPcOrWaKSpCtzdLqJq4Aow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,209,1763452800"; 
   d="scan'208";a="203139770"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 18:22:28 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 7 Jan 2026 18:22:26 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 7 Jan 2026 18:22:26 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.46) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 7 Jan 2026 18:22:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Eb/W9MYDBb6fWqC5mX+4y3YxXatrVIvRGSX8OPQXqjXERrjdYozsfBAis4A7Agmc3xQXCF9qC6Tth+nmogw6yJr9+LVYIs2lTOJPBBh24qJHKj2/sOks/nMHLaMXtn/oSulZGlJVPrLtCJf2YbCzFMkgD2wDWSpWQjgfCzUDEm0JWktG5j1KtDOx4Y8JMj1h2/F6fp1Dh3GiaTpC8rtZRLRto/7+qEEvKRCgad2rFXJuewfhVxIymosH6S9udMvaIXi5WGOSkLo3Q+ZLV3JhlJ2r+pJbb5AVQdzhprbUACnBDgxB1KueHESM4EOFhlZ0X5MSSGYI2yjxCZRX0f7EVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LAwAzeANInm1GbsUFcoYJQhE0Q9HDXVjORQxsm8UbiA=;
 b=NmM1owU/PKQ3hSEZWhCDm2T1IInjqaUnA+LGKGlDtxh09I/G1tQZSyB2EHXpXSJwCSafg6yBKMrnw0jlayOmLFqU7XtqXzhClfDBD0k90HxKaqdCphgaKhE2AOFoC95FoIQIKpz7sTz/J44XZmFQI/5C05NvQA1ViO+q5LzyvDJdI3kR4BvGx4CNlW3zfGQaVA3F4rq8FUMuFZNQFZansmpE4EqvtCbuDZt+t2gwezD0WnQJ9iEVPc/Kx2l5uYC4Ykr5gUlW34zOt2YAXprJokn9K5aXQh7QjUyBOkCh9fcooVwxKc9lDEVzZAAWWoJmGC1ticy6NnAdpNw08OiL7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by LV2PR11MB9540.namprd11.prod.outlook.com (2603:10b6:408:378::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Thu, 8 Jan
 2026 02:22:23 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 02:22:23 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Dmytro Maluka <dmaluka@chromium.org>
CC: Jason Gunthorpe <jgg@ziepe.ca>, David Woodhouse <dwmw2@infradead.org>, "Lu
 Baolu" <baolu.lu@linux.intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, Joerg Roedel <joro@8bytes.org>, Will Deacon
	<will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Vineeth
 Pillai (Google)" <vineeth@bitbyteword.org>, Aashish Sharma
	<aashish@aashishsharma.net>, Grzegorz Jaszczyk <jaszczyk@chromium.org>,
	"Dong, Chuanxiao" <chuanxiao.dong@intel.com>
Subject: RE: [PATCH v2 0/5] iommu/vt-d: Ensure memory ordering in context &
 root entry updates
Thread-Topic: [PATCH v2 0/5] iommu/vt-d: Ensure memory ordering in context &
 root entry updates
Thread-Index: AQHcd1pONBzWAyEdQUC7AlJ00GGhhbVD7t0AgAAL+4CAAAVkAIAADl4AgABFfQCAAHz3IIAAdO6AgAJWSVA=
Date: Thu, 8 Jan 2026 02:22:23 +0000
Message-ID: <BN9PR11MB52766746A06B61D24198F9648C85A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20251227175728.4358-1-dmaluka@chromium.org>
 <20260105181200.GH125261@ziepe.ca> <aVwI_SHHGPl0xndu@google.com>
 <20260105191410.GJ125261@ziepe.ca> <aVwZkFQ-iQ7OHMi2@google.com>
 <20260106001418.GK125261@ziepe.ca>
 <BL1PR11MB5271B47577A94CE3780D8ABF8C87A@BL1PR11MB5271.namprd11.prod.outlook.com>
 <aV0exRxVUoOaJtVj@mitya-t14-2025>
In-Reply-To: <aV0exRxVUoOaJtVj@mitya-t14-2025>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|LV2PR11MB9540:EE_
x-ms-office365-filtering-correlation-id: 056c7bc9-fd5e-4fd6-410a-08de4e5cc21d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?vXDcuPQH4AJF02BiTWQmq7hJNCtRU4XpNiS/tw1/VbG9oZnyzoGF5M5Ogmxy?=
 =?us-ascii?Q?nlrmb/vwBNnKWPTggWM1erwnFUMw+Tjv4eDoEGjatZqFVfrdN+TExLCb3kP1?=
 =?us-ascii?Q?9+FtdFPlee1n4Eesgdc75tyu0x28g+HCYtck/WWLQ+/oLwOsUipafZPw1JEj?=
 =?us-ascii?Q?0Euxvy3HB/0Zd7QuHkDP22ObiOaHgbuf2k3nNFvNeVg6Zy+ThWC1OHLMVglk?=
 =?us-ascii?Q?L9AU9mkPHlp120PSHKOdCNXFGQcduhuZtHdF8TxvulDweMaO8ZyBQD4n1pSf?=
 =?us-ascii?Q?DrRqPXG+lIaRwydMziGOnPvb7wuZfIBpPnQ9pxmtbFxzOokCWUYdSiqhD3kk?=
 =?us-ascii?Q?AGyamNDX0BH1OxTS3rcQtWHmSZYtQwHK/3qy7WZfpLCQBjVVBPEFh1LdeDhX?=
 =?us-ascii?Q?ePNhTSwbSDVas1nTnKL/hS2PpDEmcrvO+97Le+vAW0IsQb63zLHSwn99s7Zi?=
 =?us-ascii?Q?6iXZc1cq2XZ0GEPvjsUnmXbTh9XrBAABhje8Ys/y6Av3AcOhVBPEwBdI7SXt?=
 =?us-ascii?Q?J1z4+ltLD3BuB6/ys8Fxw5SL1AaOQAjWUUenCnQ4SqeYzqbBVStrPpJbBT3l?=
 =?us-ascii?Q?Gcv7G/K4l8BF1/CN27e6l2epxU3NNVvVE54jJMoRilKZyGdMZSyiAZSRf3tn?=
 =?us-ascii?Q?KH3a3pXOcEQZacz812tdYAOoDak7W3vC0xvbblOxeQ1ewpM2s65XCKLaHSCx?=
 =?us-ascii?Q?SJmqih/Y4RNjAmbn5UA2IC95OlakJ5rwtmOAHdk14ahOLWoBzvVx/5nEF7RX?=
 =?us-ascii?Q?iT/k7V5ckRrQ5Jx6Hb1NAfK1vVzn7cDAEu6zarghudJNJM1voKH+rIb9FnRl?=
 =?us-ascii?Q?0T4CaKwSiDGH0vZJF2WP+t8xiWA/yKdF0kyQUecsSq2xUwq7P/AE4RzU4hzr?=
 =?us-ascii?Q?TaumyKFQBZxum3GPU4EJ6y1cikwS+s/Zpw7N8buhG4cQzwQ0kDva1DnO6zNF?=
 =?us-ascii?Q?pMdrxP0kQYqSMfQGWSkBETpQ5dp2yStg9qz2VtcFmRSbEVKDSBv7JFalW/pQ?=
 =?us-ascii?Q?CJV4PffA0gWwUd8ZrA3V6rDelPAt3XnNayyvYPQjx5k3QNu5+wHe8fgcjYrN?=
 =?us-ascii?Q?rb9BhGKjjPUjUwDQBe40Y345fhpiZPax3GZAmXxXm9rV0LuWGtnszn+mLpRH?=
 =?us-ascii?Q?dmk71ZmhmcQV+Utl7l85Tkmxp+XNDGsSlV9QVWFCmNCSRYuA1ZeUzY13k1Mt?=
 =?us-ascii?Q?F7S2w23WjGvUPqPPnmXA4TyhZiOTX0g0qw3uBk3MwF5ss+XDPuvbVdubZ+j4?=
 =?us-ascii?Q?nzx7ED7HnnfNcTPEgE2677L+/vIOwuAIMqTKKdp/YX59ADYZFa0CC3u+MrTb?=
 =?us-ascii?Q?VvEvDl+TvlZYeM45EhicvtlbONPReUTii1nINrGYSbjF29K1zQ/+3OJWQyQi?=
 =?us-ascii?Q?+PGfqHylQsgz8hl4h5ma+g2icMrYoe6XZOhPt6YnU0sqvID72F14voBtm2iD?=
 =?us-ascii?Q?14jLJRmXtUZp/lEi5q/vckVTXlqqBi+QFvvpkqCm+SR0Zeo+9SsqxkP5qjgp?=
 =?us-ascii?Q?nic4vhNdtLVhl3ZbHi1F84fjiEm0oYVxL2W1?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IF/T/14E9AGYqJMrNhUwdjCizShEeCrwT8uw041ueAKQ0y1zT4RLCOkStjkB?=
 =?us-ascii?Q?lTRKFNqQfB+DxRsAJZv5YDAWXCno9t31ilNTuszi+oEOx0uI8HubP5M4NSHt?=
 =?us-ascii?Q?HvSoKcT2ORZXSWkXiWcicGVGphbBwkUksaZ9ejWUz5NXKTqQQdQSJAybxTDk?=
 =?us-ascii?Q?7xBgmRfZ/6J3bcipfml+EBEvu1Yjz5nozxikX3pwQB3ZE37y1ULaCEhOSZm8?=
 =?us-ascii?Q?4Z9nnnq5NaalxuhqKTxylR/V1zGR+vcDdbFeJRuMg/J5AGzujS/SUp9h75OA?=
 =?us-ascii?Q?i0hFJZaXSOGCMQ9GJYaqRN1VmpEaMk0H43U4XPGnMeoNVcUvVPtOdLG1qEUd?=
 =?us-ascii?Q?qDz+1vUBkTmVy8GqBFclk/bTpLSOdpPcYrCKb3X0yvkrysmxks9QD6kelOss?=
 =?us-ascii?Q?ddM7owW9nOLYdPDKOMPbLUxDj8HV46upm/jPhvfyXTZrjHr2oovQhic65pjT?=
 =?us-ascii?Q?OzR+oYQT55aOGlik9l9A6Qi9IfIGbJFsAilcIMgOp7qfK5r6x+F5zxX13wgH?=
 =?us-ascii?Q?aw2WBV5pH+kqJcV226LXgO3qjq8CMb6dP32+kGzsD8qWewk3kIDgflYpLn9j?=
 =?us-ascii?Q?mY3sqBiJ4f4BdYk/JMpqwCpU6c0gZ5cxS3RwNiydrk/fOKtf4Gmhqq44rpKK?=
 =?us-ascii?Q?9LMq/+6IfiAGJcfDnrGVV03z2mbqvoS/9GIjpsAd99X9R1AbpEGN0b6hi/AK?=
 =?us-ascii?Q?ft4cXybx+9oa3TKdZpnHCVm+PK6vdivlTBYbHkOzDpQK3s6IqGvJkR2XML8r?=
 =?us-ascii?Q?Z8XOD74PWi2hmglrbefD1DpGcvdSEmtvWORzYQQo2xHzXhn8aRxvBmKgYlED?=
 =?us-ascii?Q?kVikbopbHl2jbVhCDVzreWOLQE8c+a/IkAqAM1KnjwFZ/vM4GiVViVsLuqGQ?=
 =?us-ascii?Q?XYGcxq1wuK0BTBNIsJPRIj7bG3S+pde62bXS+HkM5eQaN38B1dp1syyJOdQd?=
 =?us-ascii?Q?bQDYQPShgVTlAEYkDsKVAKcTIGdZpox2sTAX29S+2tM9PcsJFijIjdqMySXb?=
 =?us-ascii?Q?DbsWzGRGngg1XHBzU/wR7UmI9uMs+5GUuTM0xL0kaxGYPROptV9Gz9eEXpn2?=
 =?us-ascii?Q?OHsfPTjZsNRnnSPWQokDXJKoouC84hXL2TJ+aNNk2Rg+Wv7Mgk6Utc59AqZ+?=
 =?us-ascii?Q?NQbowBs6iOwvYfvx2ZugHEpAIwq3C2E8a/t68QZjP6uN4Ogrdn/tutv590lA?=
 =?us-ascii?Q?uAeWf2yDH6Wi7PLKysxM43oPOQ8QgaGzWWWRUre+xOl2kbP67nS+bX8acgAa?=
 =?us-ascii?Q?omG8bV1W5mmURwXXJbgCpid7eSg1S/WT7AdB9aYsjs8ife+xuAc/AkmMqoSB?=
 =?us-ascii?Q?N0A9UFEe0mt4ctOgFjhGVq8z9eBge9KfHIqoErJEbtxI5xVd2nDBJwM6cEFy?=
 =?us-ascii?Q?TS2hxg5lY8UQ/48pIJ/dH/Pq4JBnHHwC7X+FWYTdRti3o9DCfl41ZBho3zd8?=
 =?us-ascii?Q?SrpqtceX9wjOHe7CQwuoQDulsi/9FBTHF3rItwvxXtferjgZSQRmV/D8iIdK?=
 =?us-ascii?Q?k/VyA5SkPDJiL72jWJ9MpkccCyWHpAsI2hwDVKO0Ayvd8a9weaXnTduc0CzO?=
 =?us-ascii?Q?ZnrSu/KPY9Cyx9H541arMWBe1fwHtXpMQj7JrH3e+My1p3RzdU/3ItG80ikh?=
 =?us-ascii?Q?UvpabD3hohpzHRXjdlHcRYYgLh3y5uwBbUViykkL8fFjNQSKrWqXdS8+emqr?=
 =?us-ascii?Q?cMc9/7AFGihhFXUXZqpg7JMdMlXZBSKnN/N5JxSJijFuiHpXMmfCPp+VCdw1?=
 =?us-ascii?Q?D/EqhsiuPQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 056c7bc9-fd5e-4fd6-410a-08de4e5cc21d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2026 02:22:23.3737
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eEkhzSc0wgsC1MznxUDbLbmOiJt4VpRX1ARvX9pFXqGAwuyHZrNU+th2UP82mn5FkMAm+ghBWLfWDgH0LOeEVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB9540
X-OriginatorOrg: intel.com

> From: Dmytro Maluka <dmaluka@chromium.org>
> Sent: Tuesday, January 6, 2026 10:40 PM
>=20
> On Tue, Jan 06, 2026 at 07:48:50AM +0000, Tian, Kevin wrote:
> > yeah WRITE_ONCE() is not by definition to guarantee the ordering betwee=
n
> > CPU and device.
>=20
> Yes, WRITE_ONCE is not about HW guarantess at all, it is about compiler
> guarantess. And it is not about ordering, it is about compiler's
> guarantee to store the given 64-bit value once, with one instruction.
> But this compiler guarantee is exactly my point (see my last reply to
> Jason).
>=20
> > lots of READ_ONCE()/WRITE_ONCE() in existing code are meaningless,
> > as 1) between CPUs there is already lock protection; 2) between CPU and
> > device it requires dma_wmb() to guarantee the order.
>=20
> As I see it, those WRITE_ONCEs (maybe not READ_ONCEs) haven't been
> meaningless (I mean, they have been actually useful) so long as we
> haven't been using any barriers. Again, on x86, store ordering requires
> just compiler ordering, and dma_wmb() is just a compiler barrier. So,
> assuming this driver is only used on x86 (which is, well, true :)),
> we are lacking even compiler barriers, but at least we have those
> WRITE_ONCEs, which provide compiler ordering too (although only between
> each other, not with any other memory accesses, but that seems enough
> for our case).
>=20
> And again, I agree it is not pretty to rely on arch-specific ordering
> assumptions, and doing in-place updates via those context_xxx() and
> pasid_xxx() helpers all over the place instead of updating whole entries
> seems a strange choice. But that is how it was implemented 10 or so
> years ago, and overhauling that hasn't been my goal.

sure. the point here is to align on what is the right thing to do. then
we could have short-term fixes plus bigger refactoring later.

