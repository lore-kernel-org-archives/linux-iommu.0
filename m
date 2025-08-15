Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301D52FF651
	for <iommu@lists.linux.dev>; Fri, 15 Aug 2025 10:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755252391; cv=fail; b=mW9VmcDqFZa2tqSLjn1tkYkhZKss2kTQdPB1V+oN8pMC5zd0lcbKm17okcemNAy2P5gmPnLwbJ8SMuxoUcWWoE7SzsrmMyYZJSfSe2ceENlAz2T9iYBsXnU1QDoSIuySdAJrRfkl6w+FZRUPFqN0GLEZ7ipLMcuhbgyCx05YUro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755252391; c=relaxed/simple;
	bh=KroVvwNaignzoCa3xImK0zk3ly+ilBwbu8xKWsYrVPU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VZ5s09CKVBtlneKDSFIDUKW7EM7fDE6RCCEutatRWFNMmt9+xIgZrILjYw7+0nptG78dblMFM3dle0iwRpfw+/qFnlq4in/Ip/8VY46WCyRK0QQ6AoUwDMnVKAoiK/fu9Tb57SFJmO+xeo5fZwBol64uk9YgeWFG4OpJelzOwF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kj4dMrce; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kj4dMrce"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755252390; x=1786788390;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KroVvwNaignzoCa3xImK0zk3ly+ilBwbu8xKWsYrVPU=;
  b=kj4dMrceGxiGuqaYaUFFGq1HgnhnTvX6LpsBbTnVXXsxrerXNa2+7xt5
   bc5ePXLJ0dtHcsND/rxFhSWLff2uGDpQNByEv+GPj1FgiAsCVV9GtXFKq
   hJl2QTIsYxOxylWMbNULZ/WwXAb8e14MFw5VlK264B2gdlTJh1Yp+w7iH
   YlCprBnpOqENPR88h6SfWRcegVEM0bPPqTRGGygffTIQ9awdTgJFgYPSr
   xbXZ2NJOZ8xETjpX2wGb//RfD4V2hOpSol7yguKkSEENcc/6xVaM2p2vO
   cBTmVy7+G8iXRc1sqxUx4vJCyTFTeSzQRV+HUe6Dc7j6ikpY8fDhBiCZJ
   Q==;
X-CSE-ConnectionGUID: 2HyqI8hUQFetZ2rEHfL2fw==
X-CSE-MsgGUID: NNPFlQOYShWVBo2K4WybYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11522"; a="61208608"
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="61208608"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 03:06:30 -0700
X-CSE-ConnectionGUID: xZ+TB9WYRXejZTD+POPHXA==
X-CSE-MsgGUID: h+3LGeUESzKOI7TejPRLeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="197977556"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 03:06:30 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 15 Aug 2025 03:06:29 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 15 Aug 2025 03:06:29 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.79)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 15 Aug 2025 03:06:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dsSPxoZKy98fjlWt2Ol/+N6PLF5qi8f8hxv0iVV+fAGlwDhBJFeBUBKH4hfK96BDtMt+ZoNl942afcb3shTVK47KbFq3dZQUkeS6bHkl2WpVXeMjodvM2IM7wuvsxgp5a00Z7Q96fJFIczRtWFSnNKt7TIJg/FdTPhBoXkWxaD3Jeg1TRfCZSG/5kmTjXA1MTrUoOqw0C9rJbcIkiO/lMVqS6cIWmAG3CoQ+qAlrIu3CYk86SnNPkmFk/a4WYGWKbGruPF903Pvn2S8vEMNb0jO4dja+xy0NDGqpyEoPgu2eIZVAC9PTFmgxy0JdogMoXW70Gx8jOAccfuHtOm7Bbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KroVvwNaignzoCa3xImK0zk3ly+ilBwbu8xKWsYrVPU=;
 b=ObGfwZg/YaZ/yYXZSqLrW3UIMscg6DZfQ0fsnrO+ixkh1S0g/FScQH6BLSsFp2SQxs3i3FIBCFpgktqX6otmNX7CuJcV9gvDOkj1+Rp7ODHLzJAELEa5k0AIfcbE5+yN/BbNR8x5tNdz40b4CVNNhSYI37UKqjmMHxXxgTITc2daKfqA6XRAmJI6aAXu6NIzgD/W2x3U4Ys7auSxxvJ75YTo+MZFoTLSdCjWLclhTiTiEdYULy+PC3JuqDzIuGCVTN4RCLVMW+oQAIjdin/yjvDlDViFHt9PW87So+jKJNEOkjnGbr/0JZ0xHwqdU5N1u+3UV1amOLtwRyJZwVoy5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ0PR11MB6741.namprd11.prod.outlook.com (2603:10b6:a03:47a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.18; Fri, 15 Aug
 2025 10:06:26 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%4]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 10:06:26 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Akhilesh Patil <akhilesh@ee.iitb.ac.in>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "praan@google.com"
	<praan@google.com>, "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"nicolinc@nvidia.com" <nicolinc@nvidia.com>, "jgg@nvidia.com"
	<jgg@nvidia.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"akhileshpatilvnit@gmail.com" <akhileshpatilvnit@gmail.com>,
	"skhan@linuxfoundation.org" <skhan@linuxfoundation.org>
Subject: RE: [PATCH] iommufd: viommu: free memory allocated by kvcalloc()
 using kvfree()
Thread-Topic: [PATCH] iommufd: viommu: free memory allocated by kvcalloc()
 using kvfree()
Thread-Index: AQHcCfuG9jlE7BqNqE+DSCvThxsjM7RjhHag
Date: Fri, 15 Aug 2025 10:06:26 +0000
Message-ID: <BN9PR11MB52769BA153FFF6A5339A0A208C34A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <aJifyVV2PL6WGEs6@bhairav-test.ee.iitb.ac.in>
In-Reply-To: <aJifyVV2PL6WGEs6@bhairav-test.ee.iitb.ac.in>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ0PR11MB6741:EE_
x-ms-office365-filtering-correlation-id: 0d3884df-fdd5-4808-b71a-08dddbe3656f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?vB5SW/ga9HtObDJL3KaGxlrVh2ePS/O4YKmO31+BukZEy9PPx21GfoJJ9e7/?=
 =?us-ascii?Q?RwiEqcXBmsS6D7GCjyPA2xR1HRT7mSKpqOU7/yZu9l9r10iZROxDKHUuDGsb?=
 =?us-ascii?Q?x3ov6qos6vQALqP9NyQ3JLwHt/2OQOFwxIsNohgh2IgT0AZW9PlAISQMZtcQ?=
 =?us-ascii?Q?UauVqO3+bv6cmHgYT0Z50EiyroNZdMks+dcxRKWrtbDPrqZfKDWNI9H+r7Aa?=
 =?us-ascii?Q?IAW0va2s28EaWu+f2yWKtg5GK+fR+qAYlYC37oIseenk9dZTCaXOPQKilxEL?=
 =?us-ascii?Q?Aq3dPMsV8LU1JDNkx4JsZ3QATpMywNUOfs93UZ2apXngSPqzRBW+uUAUZibO?=
 =?us-ascii?Q?q1l1uzEIi7KGEfZJneM3K5yZKf5bKeWzLs6YFkhQF/x6xDLQdI0HEVCwTNAt?=
 =?us-ascii?Q?zx29dl3/9H2UfDy3or6h3VDup9c1IkclwkM0iWec2Ew4W6jOxWmxZ6Yb616h?=
 =?us-ascii?Q?IiUX/1NLNvcrinb+Tcz3LSnj2YHAc4Oab6GIooSy/8lM3bcKfhYNwGG/ycNx?=
 =?us-ascii?Q?dXv0SUA9mxICx+ouVe8/GmfiUf/kHqpQFpbNMZK2352MP3JEF6ZMXpQDpmQP?=
 =?us-ascii?Q?xpX+7000WSiUFzwGRU4c54Mg/mj8bOdDYd3Gt2IbiZxCzRD5r4R5fenpWNcj?=
 =?us-ascii?Q?cHiGUA4+aGUan5Ba9cvc7BL5ziCn0/djLZSMQ8GjLrsBXJQci3tRuIrByD1R?=
 =?us-ascii?Q?2Jp/VpbBdnt1MHphjMDL/3RQDv3UQ8zEflO1kV8cfwF7gqc7cfcjuQEyAJCG?=
 =?us-ascii?Q?HYeU/BBnJ7zo938wdQ/PWLY2pxWzQ/iSw8MKW5uPy/xoG2bsmkE+P8JfACSW?=
 =?us-ascii?Q?Oe4vLURNRHqcM/sRFyZufhXt/mMkiAxr4FNhLTndBGPirtanmj+28Pfj0HYQ?=
 =?us-ascii?Q?9nEsJYWPmeB5JA+fx5dM2RydozntMOP85L1rKxbWleolB4OhJ8WCfRfEQ8XU?=
 =?us-ascii?Q?aleIB2xCSJ4PDkAoqCFz0+tbK7Yd5MrSmGb+XV9IWbCSjxpGAY3070xSE5vP?=
 =?us-ascii?Q?xmCTRwjwSDzZebgLvw7YzXLt9vY3B6VVxHCjyELyA1XQMJi6pS8tZn8E6C64?=
 =?us-ascii?Q?nGBnbAWeNadp2xlg3/tYxnqk9T+rC6x5QIQaoaEYyXmICwYDctJdMa5Z+SEb?=
 =?us-ascii?Q?efZOKcB1hmLLaUoD/Ebw5yAWkyDVFAtbg8XP7cgHFxdVj2IuR3EWIYzn7yps?=
 =?us-ascii?Q?vqM+x+KN/S4B0OE4OX/l/fXovB+TiOJq3fNZiNMx1LefCNk/Y81MjbtWu5G4?=
 =?us-ascii?Q?7pyjpWzY75JvnenFYUw5H5T0nF3PVNBU/1u4WueoEJwPgLlt++QXrhJgmKcL?=
 =?us-ascii?Q?INYUOsgVZAfZROycvld3zkvktBHUaqGvVF0RUocamaZqE6/W3zpUNo/dWrpx?=
 =?us-ascii?Q?C8GeJxgiKJgFaTnvxWigg9eijUqVOWMkLNT/Z+oynwmPYSdWR3U5+JSdGRux?=
 =?us-ascii?Q?cZErX0Dxb1PP5fI0ScB4AxzqK4P5WmP7yYrjdIiHQsmYhxFUtNVlYg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aF4yPAJJhyMHyL8xPbxXX9SlsRkZT+HAMC6THLl/V+H1RbKe2wHo1gZW29Zg?=
 =?us-ascii?Q?Lh3FTYOjnKeE9sv8Fn5D5gL6Cjol0HsNn0MI7RNQ5AQ4KJxriewp6/9yroLr?=
 =?us-ascii?Q?BKO4KBpDUCAwnhMn7fIf9KjdSzGcLleLk/KrkEEW970gttyzQmsOeGfsfkeF?=
 =?us-ascii?Q?EuOLebPB38nYjhV+bKomvjW15qp8TcmYFYOwZMdbvax21skXOA8yiVk6y8jU?=
 =?us-ascii?Q?xMphFKHdAbvOlnH/kYt3O4NXCYkDvqgNFzOxu6wQVu4t6IwO27LoEQiZtCCu?=
 =?us-ascii?Q?ydMBca3rZ01uEp+FdbfcGu8m8pD8u+F7WAt439R0x7MIFGnuMeXAbswqLUBG?=
 =?us-ascii?Q?d7PUxL5hkDfNPh/rgJuFmrKpuL3f3HVatuPS5ofTBu3AeYR3id3CWtAM28S0?=
 =?us-ascii?Q?2I0/2wnAk4MbkW2CIvLPjjs+70NrKZvcVn0Mi1Bpdos3BCcS/vRX02nTJNwu?=
 =?us-ascii?Q?3zB5/kLAHNx+5bu0pZX5dRqIlkq5N1f+cbEy5dP8WAXulSZ0EPTmmnSQL+r6?=
 =?us-ascii?Q?I6WR4PmqwPwGq8JKqp/yxTh/TD2nxA8u7HqfUi8slxd2qjvkubHmPs6o0g+C?=
 =?us-ascii?Q?3w6GKIm+arloXQMEsylBNego840OWlLDREdRFnTCD5oc2AZXsqwf3xWPmZnU?=
 =?us-ascii?Q?sTdAaoOGLzcvhXqUkclM20iKr9Se4L65/OIrU4O0KBVN2djAdaaUleiuJmmS?=
 =?us-ascii?Q?I3urxdGRKph3i1sgJVDrLxju/7tXtiAyRdKeZ9vsKT6jgWYqQoDnZrdLH85j?=
 =?us-ascii?Q?ZvAI8RxJg1NLOpDBP6Ct5ytNVeke/tnfx92mzPKgfHta2Wyq8oxnnS945SyA?=
 =?us-ascii?Q?T5JMXFIoEMxq1hC/Y+h0yPo8YtH6PF1NvJsk2/x2V7KEwwRPJzl48/4W+vqC?=
 =?us-ascii?Q?RWc3dpdHZbqUdDAcF4WJo/DP21VhPh9zM2ei5vc+uZqTYumvqFET6P09p8Jd?=
 =?us-ascii?Q?i5+KZaN5/JXVkyzi+XIsB8UTAdDjnhOLKYeWtgmumc/vIJiYMPecBF+hvnu6?=
 =?us-ascii?Q?5qGJlN43XMMNKybks19GdIDYkkaX8af3gX97i5luf4lYagQvNI38eaV/747I?=
 =?us-ascii?Q?KQb6p7Ma98+fu9WWT9ec0Wkw93HaWjM4Y9t6z4KMY0mdmWFKFSk8Vot2L0x/?=
 =?us-ascii?Q?oMmLo/XqJXPzE7cy/5yrs8XCNMywM+pDMJAmRWPotuORIaobvjq2X42iwQ0x?=
 =?us-ascii?Q?GVeJHuSGNPyTU4YScMArDXi92Imk4nfIxV1FTc49RpeDoQjcsmbR9WsY/RuV?=
 =?us-ascii?Q?EAgLRIq/kzMvUa2gKHnBSHYidellf+NwRwByGsljfR6tDywqHB7bBhtm5TuJ?=
 =?us-ascii?Q?OfOWpsTw29MbWzS6J5LaoPi6OtLqHd5VOPbK179wdc2kdRBHyfndgZcJgNLU?=
 =?us-ascii?Q?svQSoPlJf5wEzC/y28GJpoEuNesPdPRHSQLhDzpeP0XrfGQSZgEVG/mp1a3z?=
 =?us-ascii?Q?BkmTHNBoCuUbR7jlORyBSiJ82pLhoHCtcdQL+eV5rsvZ5lOlyYEu/UZm82xU?=
 =?us-ascii?Q?TZIKB74sr+VGZ5IoFNoP5YQskU4rjw816b+uChNAB6zwQF060Vkx6zkz4bJq?=
 =?us-ascii?Q?MLzysL5K0B4ljUQHLZ6dQMi5bNFDgOabCv+kePc5?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d3884df-fdd5-4808-b71a-08dddbe3656f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2025 10:06:26.2203
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eiIIQtizBUWLYUFtdCfd//N9q4aylByqrcPRBY6wiT/Eb+i/NIYCs3KHsb4W4OVarta0ya8ZgchMxp+MJk59GQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6741
X-OriginatorOrg: intel.com

> From: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
> Sent: Sunday, August 10, 2025 9:34 PM
>=20
> Use kvfree() instead of kfree() to free pages allocated by kvcalloc()
> in iommufs_hw_queue_alloc_phys() to fix potential memory corruption.
> Ensure the memory is properly freed, as kvcalloc may internally use
> vmalloc or kmalloc depending on available memory in the system.
>=20
> Fixes: 2238ddc2b056 ("iommufd/viommu: Add
> IOMMUFD_CMD_HW_QUEUE_ALLOC ioctl")
> Signed-off-by: Akhilesh Patil <akhilesh@ee.iitb.ac.in>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
