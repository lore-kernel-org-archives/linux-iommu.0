Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4004835A397
	for <iommu@lists.linux.dev>; Thu, 25 Jun 2026 07:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782372628; cv=fail; b=aoOq9OF7d9ItbiDWFVCLppcdG3MKL+2YkYikumiYbVLkkYRMyQ0g9ACL9mIj170qe/loh1nB4irC2ZIUu6EgjdvGUnvqaTq+zxgFJaBm9xvR1nGtQlI4rv+UxyTa2Sl7UlUtOj+ab0YbmatuSXzv5q3X/qLUrA6Pp07VGBqNZns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782372628; c=relaxed/simple;
	bh=f5GkQ/P2z3p6aEaFNemu3bLPJsk3Jljfqwy4UWYv8jg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Gt/xo2Z+tDHd+0u5pTsgf0Uf3zyI0W23kvuGvnbQbTgY9KHYxKep7d5ZBNiGX39XL68AIcerC/AnHDKddyQ9HHGGPUh5bjY/UOz6B6P2xkrrK7a/+DO5+8tm6lZ7rPBa6QPuO13+l9I+/5/ArBtUKsczaY2yzKky3e2QCCEiWX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e+m1Pxni; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e+m1Pxni"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782372626; x=1813908626;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=f5GkQ/P2z3p6aEaFNemu3bLPJsk3Jljfqwy4UWYv8jg=;
  b=e+m1PxniVug0c8sPFUTQ4/soLjO85bCyLb23ZQAkhiPJIt/OuSh6dV+X
   9jwTgorga0QtZ3ygzQ0n6PkrT7hYwJKeDkcqdKcr4YhHKAWfO3lm1HWEj
   vQuCJbz+7i7Ls1XaMLBsexhGaimjAbQGp3WCUVY7HqyxGeR9LBdIwMk3U
   3Jn3LCK6fqqwWAyu+C0QyaNGnpDtcEAmCRU4TVBPegMSM7rQniVcypGs3
   EEjsZq5iKQo6Oa2KMVAy58TiOPcjJyCAeGVFnQcNox0a0Tv4+NP8+ar//
   4Q2PCYsQ4MyltykRv26dJqcdv0hOdltkQ73JMhUp/TMjf3TTj0leP6ZYC
   g==;
X-CSE-ConnectionGUID: lhhNAwVyRbSwyhzB5BLOsg==
X-CSE-MsgGUID: 2fFyKsukSLqW/YraHPSuDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="83149698"
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="83149698"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 00:30:25 -0700
X-CSE-ConnectionGUID: NqjlN5gmSfmCrJ59usGFHA==
X-CSE-MsgGUID: xKukX71YRUeZfDZuC0Ms2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="246443063"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 00:30:21 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 25 Jun 2026 00:30:19 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 25 Jun 2026 00:30:19 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.53) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 25 Jun 2026 00:30:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NcOtXkMB6eVuqJCszxDERqfxN331dIuDZy6DmP7pzKJDuoS7hZxEordKGzY2yb98K5aNqVYzU3PobzN8LLhXUC0GzSYxblkQFW8CBUuC6IWYm+DKy4ZRNnUFr6zqRSKvjzVavjmDjQRjf5paJd6I3TPFaG2t8zGB/lRxHa5IDLeSE2WFZW/SrIotkhlzO2YiKnMJKpLzQhRtJKO1wJJ3DNvhNqEBcNjur/qt9NBl4yKIzJqzQFy67eVbDAWXsdcFV118vqelOww9JHKU9rpYBkQB02ncfcjnOm8q4GH4oJGQzbvM3Ay1n8ZDNWgpqQrQIMyq7PgoeHwI1NIEW9w0+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yzTrsBCDkYTItvNmY97k8Hb+uiyjPJSQXqPDybQ57Oc=;
 b=mbrD1IAv+ruMp6YhI4J689iB5oCze6ral05D9fvQSTVDDNfe5oYuOLlhfeAWiFjSNtZLKH0geis4nQEnZrJYy7SSgndQJKe4dp+LG2OTzJgWhYkANfXafGM8DEuLoi32QrnzWgfP9TpEwahSITuZHgj2Swr9WIx8xgBWRRXpZZrxmel8Ke4CaUCqmSwjKXUE9jTO2uhgFjf46l9PWXe1+/UYptfLjdiB+X2N+UTzUV+DyLS4v4qyaeoJGy25WV4se62oBHH4YnuH0ZLj8+YZMMAEBYole7AfFnm12wyk6yqIVnqF2wWsLgwIQABXE1ski84zGc3g0JeUe689aKD5ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ2PR11MB8498.namprd11.prod.outlook.com (2603:10b6:a03:56f::12)
 by CY8PR11MB7265.namprd11.prod.outlook.com (2603:10b6:930:98::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Thu, 25 Jun
 2026 07:30:11 +0000
Received: from SJ2PR11MB8498.namprd11.prod.outlook.com
 ([fe80::8db6:d449:e492:308f]) by SJ2PR11MB8498.namprd11.prod.outlook.com
 ([fe80::8db6:d449:e492:308f%6]) with mapi id 15.21.0159.015; Thu, 25 Jun 2026
 07:30:11 +0000
From: "Du, Fan" <fan.du@intel.com>
To: Michael Kelley <mhklinux@outlook.com>, "Miao, Jun" <jun.miao@intel.com>,
	"m.szyprowski@samsung.com" <m.szyprowski@samsung.com>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>, "chenhgs@chinatelecom.cn"
	<chenhgs@chinatelecom.cn>, LKML <linux-kernel@vger.kernel.org>, "Du, Fan"
	<fan.du@intel.com>
Subject: RE: [PATCH] swiotlb: eliminate per-map atomic contention on
 used/hiwater tracking
Thread-Topic: [PATCH] swiotlb: eliminate per-map atomic contention on
 used/hiwater tracking
Thread-Index: AQHdAkGVG27dVNXNe0yyBQUhGJEOBrZLbVMAgANqNeA=
Date: Thu, 25 Jun 2026 07:30:11 +0000
Message-ID: <SJ2PR11MB8498277BE45D32A81ED07D9D99EC2@SJ2PR11MB8498.namprd11.prod.outlook.com>
References: <20260622122114.2563254-1-jun.miao@intel.com>
 <SN6PR02MB415757A3F56268BE3AF01D35D4EE2@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To: <SN6PR02MB415757A3F56268BE3AF01D35D4EE2@SN6PR02MB4157.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR11MB8498:EE_|CY8PR11MB7265:EE_
x-ms-office365-filtering-correlation-id: 07bc7a1c-f295-4a02-bfbe-08ded28b9742
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|38070700021|18002099003|22082099003|4143699003|11063799006|56012099006;
x-microsoft-antispam-message-info: EluDAEXLQYUylFB/az0dB0EL9HjpDplPMfkPwf/NYWjHWfZKT8qR9TVIocS1hFUnJN4uO+Bn9xsfJvvTERDjY0P8z6rQGU0F1OH9LqwtYskEhoS87cvRXIGzBYrggTYq1GtE4ifIVtzexcbqFKuoI9dmoWOOu/gAw6n+5CeYMtgWF16TUH/RHWpQ7GQVbMNKu/fYHV8d4/O1k4gd/9ya3jxQz1FkfHfJiLc+ZHrcAEOCB7SOIPNnTiXEYL07itJSdqQxRfxUrkE/zMLoBxjy0WWMbyTWyUfYVh+ushinOK7IDzByQcsgDGS/raJ5Gyb9S3R2wmyKfy8w0FjdwwQOs4tqG9BgJLQg9DSKSAb8jvG6s+xuGMoqBTICsDiaGEFXUqbEX5Bw8VXApnfej3UxUT44NoX/ptBzWMGp4InxK9KzEo4Rq3Jco2j0qVtPYKGkvROOZeq/WVC3cAZlmQbeHiiQKFto+DEFAE7pEzC1wdvF8EeQInY/R3tJi+kJrRdqJ8XHTZyMJBrii+iIkB/aLSLR0hbIX9s0e9eRvDhfFeT3nMRvgpUztQxAtwWObUH1X1BU5vOpAKolYgG812W5ynWWdlceNrARMH6YS1WTU5GU2RgtGi1PHtH9SXmd3UiOVTxBbFOsw59EYZPywJpEe3RuffpECISoHeUcIoRCECnlkNyZ6/z8R6msu+rwVfE6Stz7ox9bvwkyXWJM+PUJtlySLVuBFbroPmTategY72Y=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8498.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(38070700021)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uqSqMiE1FxC9A2YXi3ybJh/Q//+t1Li9tVizECg5jzdzVNHl6Afdf0KCUe8q?=
 =?us-ascii?Q?geYYgmpJhfklwJIkpJrXX98miakaTrh4w1cjScIrQ/JFIO6muRX4tXg9KV6r?=
 =?us-ascii?Q?Caev/7WRXl6fTzzEuQreCgTq7lEn+Qzae+j+YYfGInjLTIW4srUwxj2M/ax8?=
 =?us-ascii?Q?4HU96VL1WPIGcciBsdx0NgdRUNbEUOMFNBLFgtDMpNWNXOkCF/ZpQotCVjZn?=
 =?us-ascii?Q?t1HnrJfYso3ubI5j7jpqsHGHhWsVNKIiR5+Q6QlW5p+Cak/h82gCE2VxSebj?=
 =?us-ascii?Q?TmaFEabxqETpf6RVb5LGnZgJy50VDqX+ikiOHDQv36JF2qNRaTwNRyyB4LV+?=
 =?us-ascii?Q?Cong2kukoH7N7Wvw33+5yTdIvPdFzDulYL5R7ODPwwrO/qhrFT1QwfF6eFJN?=
 =?us-ascii?Q?sy4UiOM5uD9SrK43jEUVY4B+bpcmdrSEuDsvDj7y2yHzNquxYYxEfdMVio1o?=
 =?us-ascii?Q?DmRUAvzQssReSz8cq6XDJxdC0WOd9l2JCx0yWEoP6/1CZ6C8Usvlb8HfLFn0?=
 =?us-ascii?Q?j4hFBw866rRXK9JM+5Idk1sScX/SsSjgWu/z3E2sAy5sk6x621I1/2x2Zpit?=
 =?us-ascii?Q?gRYo3QMHWR6LR4+uZw7BQXHh0Neexhk2JYVUfR5DzNkZECKmz+qFBdttcPa4?=
 =?us-ascii?Q?sQzqTi3HziGK6yX/sJ/9qMInn+X9pNi1kHzzTVoc9eBHpYWOghj4F5drEzGQ?=
 =?us-ascii?Q?e3a1snkwCzbLtTGB48tmZ4G6LW7FBogMLdxs+uiLUgXFD+87IwI65c09iB4K?=
 =?us-ascii?Q?L9eAW7DdkxgawtOr2oIszdwHFZfvlaQaHXEFQsZsTBqPXvI/XyFk+oC4iblh?=
 =?us-ascii?Q?cXcueuHwY4gLZUy4SFi7Ze4jQCE5YcQUyQ9T0FFKWX5ASHFlc2EaMlsli0zO?=
 =?us-ascii?Q?558q38pBDKYxApGwWnmb/WUqagkRuxaj8R4QYZEwY33sFZcPMvEnptZCMIfs?=
 =?us-ascii?Q?jlrxsePLiGCB5Mmeby7JeK+NDTIt50QioCW4SmpGnviF2Ual8bjOSAmRidgx?=
 =?us-ascii?Q?PPJ97VSm9tGqTHxKI8SnRzOnfPidQlaxokYPEya4DPEsiZctJwRqM42d2ert?=
 =?us-ascii?Q?IgyrzP9JtiW9d8DuHH51I8eg6SgS0L6krIdwXcjSgeV5wz/slzEU+pXh8ppU?=
 =?us-ascii?Q?/Isq9W5nYfU2/gC/SJi//36JljD+V/b8++tTr32FJ7P3X8Pge0aokZ/rh/YW?=
 =?us-ascii?Q?CJ7vTtbNfMNUm9y7w3Zow4EnFhb6HFDzLoCtqBp9xJQ77uyt1+8mkOv4N2b3?=
 =?us-ascii?Q?dE9jBsA1uDkqVghbyIC8WRSn2yvrjHLA56DjOO8yc9a5LndKPKMNAaJM0mmL?=
 =?us-ascii?Q?lyVZujS/LPmFpLJrw6XfvxwRPSEeh4W3TdEM4ucwCLY2W6QWd5vZqJLcKtMk?=
 =?us-ascii?Q?EC/8CqnUWR0nGQVJDHVJfMBFhJugwyZP/xhy59EFS2RapE8hTLgD+fpYnmqy?=
 =?us-ascii?Q?TmA+htRM1BNSodNsdcnseM/jHoXGBudwYFjvCk9ZM0SVrWPnBPTtZ7TjILvg?=
 =?us-ascii?Q?1yJoIY5BbUCi6uFf2V8zNGiRh+ChmPZ6WbI+PaiRBDf6sm4IrYxuWz9cpZSs?=
 =?us-ascii?Q?6+9lowmk8+O9kgJKMNTH6tILw9ZspD3apvPRx6CFmzUM6lvUqqPQ64jNl7Ln?=
 =?us-ascii?Q?teOuWOXNKpjaccZ9srYKIetCheEaWaf4hR+/nDeEG2XWeDXXD37BUMv3PQMD?=
 =?us-ascii?Q?5mvxLeb7aKRwBisY3rXzttQomZ9k+om5Ooo0icusLcApIFRX?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: EcT4l1kihaalxrs7h1BSbnbIV5ZwBnxZyhHVQ4I/nApmpvulkjEdgrK5H//wBUUTJC1PuNCZlXGCMtSNnfwWTL+piDqGkCkqdQIsck8zcevKbSBhBCvdje2nCf8fG8kO4514X/kiheWm8J6FQfX1NY2csEG6KuYhmcqnWg2OFjm8cPzdLaYBor1wnPqVQetI7lGSiFisJg1K7dRfKG2WGKISBG8VvAijyTLhLSRy/DhzgdMnBuZcFpZCW1Vc/Xr3RhEmUtqvl6y6v3vTa669aDDvNuSqjkzcKnlWYRZeoZM6H9wbjAWaj7aZvXfVbLNmuqKAmKruSogyWIOpYlNF7A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8498.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07bc7a1c-f295-4a02-bfbe-08ded28b9742
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2026 07:30:11.3073
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K5a88SgLYdZmXs/z9OjqAW7JzvyTjFgMWSJ5wezgEWBn88LDCmTgDz9hGnCDJReaNYzDIvo/vF2HWnIaeAL97A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7265
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Michael Kelley <mhklinux@outlook.com>
> Sent: Tuesday, June 23, 2026 10:35 AM
> To: Miao, Jun <jun.miao@intel.com>; m.szyprowski@samsung.com;
> robin.murphy@arm.com
> Cc: iommu@lists.linux.dev; chenhgs@chinatelecom.cn; Du, Fan
> <fan.du@intel.com>; LKML <linux-kernel@vger.kernel.org>
> Subject: RE: [PATCH] swiotlb: eliminate per-map atomic contention on
> used/hiwater tracking
>=20
>=20
> From: Jun Miao <jun.miao@intel.com> Sent: Monday, June 22, 2026 5:21 AM
> >
>=20
> [Adding LKML to the Cc: list]
>=20
> > Under heavy concurrent DMA traffic, inc_used_and_hiwater() performs an
> > atomic_long_add_return() plus a CAS loop on the global used_hiwater, an=
d
> > dec_used() performs an atomic_long_sub() on total_used.
>=20
> This statement seems overly broad. Normally the swiotlb is rarely used, s=
o
> heavy concurrent DMA traffic doesn't generate this problem. The bad case
> would be in a CoCo VM where all DMA traffic goes through the swiotlb. If
> your statement is based on the CoCo VM case, please call that out.
>=20
> > All CPUs contend
> > on the same cacheline, causing measurable throughput degradation at
> scale.
> > Both counters are debug-only (CONFIG_DEBUG_FS).
> >
> > Move hiwater tracking into struct io_tlb_area, where area->used is
> > already maintained under area->lock:
> >
> > - Add unsigned long used_hiwater to struct io_tlb_area.  Update it
> >   inside the existing area->lock critical section in
> >   swiotlb_search_pool_area() immediately after area->used is
> >   incremented, at zero additional synchronisation cost.
> >
> > - Remove atomic_long_t total_used and used_hiwater from struct
> >   io_tlb_mem; make inc_used_and_hiwater()/dec_used() empty stubs.
> >
> > - Unify the two CONFIG_DEBUG_FS / !CONFIG_DEBUG_FS versions of
> >   mem_used() into a single implementation that sums per-area used
> >   counts with READ_ONCE().
> >
> > - Rewrite io_tlb_hiwater_get() to sum area->used_hiwater across all
> >   areas (locklessly with READ_ONCE()); rewrite io_tlb_hiwater_set() to
> >   reset each area under its own spinlock.
> >
> > Result: zero global atomic operations on the DMA map/unmap hot path.
>=20
> Another result (as I describe below in the code) is that the reported
> hiwater value can now be egregiously wrong. Back when I added
> reporting the hiwater value in commit 8b0977ecc8b3, there was
> considerable discussion of the potential impact of the atomic operations,
> and the decision was to place reporting under CONFIG_DEBUG_FS as a
> mitigation option if needed.
>=20
> At the time, the use case for the hiwater mark was to enable a sysadmin
> to see how much peak swiotlb space is needed for a particular workload.
> This info would allow the swiotlb size to be set smaller than the rather =
large
> default that is used in CoCo VMs, and free up memory for real workload



> usage. I thought about the approach you've taken here, but my view at
> the time was that approach is inaccurate enough so as to be fairly
> worthless for the intended use case.
>=20
> >
> > Without this patch, the inc_used_and_hiwater() accounts for the most ti=
me
> > from perf assembly record as following log:
> >
> >        | spin_unlock_irqrestore():
> >        | - call    _raw_spin_unlock_irqrestore
> >        | swiotlb_area_find_slots():
> >  10.38 |   mov    $0x60(%rsp),%rax
> >   0.00 |   mov    $0x2b8(%rax),%rcx
> >        | arch_atomic64_add_return():
> >   0.00 |   mov    %r15,%rax
> >   0.00 |   lock    xadd    %rax,0x58(%rcx)
> >  66.74 |   lea    (%r15,%rax,1),%rdx
> >        | arch_atomic64_read():
> >   0.14 |   mov    $0x60(%rcx),%rax
> >        | inc_used_and_hiwater():
> >  19.74 |   cmp    %rdx,%rax
> >        |   jae    43f
> >        | arch_atomic64_try_cmpxchg():
> >        |   lock    cmpxchg %rdx,0x60(%rcx)
> >        |   jne    432
> >        | swiotlb_area_find_slots():
> >   0.07 |   mov    %ebx,%eax
> >   0.04 |   jmp    289
> >        | wrap_area_index():
> >        |   xor    %edx,%edx
> >        |   jmp    3fb
> >
> > Suggested-by: Fan Du <fan.du@intel.com>
> > Co-developed-by: Chenhgs <chenhgs@chinatelecom.cn>
> > Tested-by: Chenhgs <chenhgs@chinatelecom.cn>
> > Signed-off-by: Jun Miao <jun.miao@intel.com>
> > ---
> >  include/linux/swiotlb.h |   7 ---
> >  kernel/dma/swiotlb.c    | 109 +++++++++++++++++-----------------------
> >  2 files changed, 45 insertions(+), 71 deletions(-)
> >
> > diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> > index 3dae0f592063..a92496786cb5 100644
> > --- a/include/linux/swiotlb.h
> > +++ b/include/linux/swiotlb.h
> > @@ -97,11 +97,6 @@ struct io_tlb_pool {
> >   * @lock:	Lock to synchronize changes to the list.
> >   * @pools:	List of IO TLB memory pool descriptors (if dynamic).
> >   * @dyn_alloc:	Dynamic IO TLB pool allocation work.
> > - * @total_used:	The total number of slots in the pool that are
> currently used
> > - *		across all areas. Used only for calculating used_hiwater in
> > - *		debugfs.
> > - * @used_hiwater: The high water mark for total_used.  Used only for
> reporting
> > - *		in debugfs.
> >   * @transient_nslabs: The total number of slots in all transient pools=
 that
> >   *		are currently used across all areas.
> >   */
> > @@ -119,8 +114,6 @@ struct io_tlb_mem {
> >  	struct work_struct dyn_alloc;
> >  #endif
> >  #ifdef CONFIG_DEBUG_FS
> > -	atomic_long_t total_used;
> > -	atomic_long_t used_hiwater;
> >  	atomic_long_t transient_nslabs;
> >  #endif
> >  };
> > diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> > index 1abd3e6146f4..9b4130e3f8e8 100644
> > --- a/kernel/dma/swiotlb.c
> > +++ b/kernel/dma/swiotlb.c
> > @@ -107,12 +107,15 @@ static unsigned long default_nareas;
> >   * This is a single area with a single lock.
> >   *
> >   * @used:	The number of used IO TLB block.
> > + * @used_hiwater: Per-area high-water mark of used slots. Updated unde=
r
> > + *		@lock; read locklessly for approximate debugfs reporting.
> >   * @index:	The slot index to start searching in this area for next rou=
nd.
> >   * @lock:	The lock to protect the above data structures in the map and
> >   *		unmap calls.
> >   */
> >  struct io_tlb_area {
> >  	unsigned long used;
> > +	unsigned long used_hiwater;
> >  	unsigned int index;
> >  	spinlock_t lock;
> >  };
> > @@ -959,40 +962,6 @@ static unsigned int wrap_area_index(struct
> io_tlb_pool *mem, unsigned int index)
> >  	return index;
> >  }
> >
> > -/*
> > - * Track the total used slots with a global atomic value in order to h=
ave
> > - * correct information to determine the high water mark. The mem_used(=
)
> > - * function gives imprecise results because there's no locking across
> > - * multiple areas.
> > - */
> > -#ifdef CONFIG_DEBUG_FS
> > -static void inc_used_and_hiwater(struct io_tlb_mem *mem, unsigned int
> nslots)
> > -{
> > -	unsigned long old_hiwater, new_used;
> > -
> > -	new_used =3D atomic_long_add_return(nslots, &mem->total_used);
> > -	old_hiwater =3D atomic_long_read(&mem->used_hiwater);
> > -	do {
> > -		if (new_used <=3D old_hiwater)
> > -			break;
> > -	} while (!atomic_long_try_cmpxchg(&mem->used_hiwater,
> > -					  &old_hiwater, new_used));
> > -}
> > -
> > -static void dec_used(struct io_tlb_mem *mem, unsigned int nslots)
> > -{
> > -	atomic_long_sub(nslots, &mem->total_used);
> > -}
> > -
> > -#else /* !CONFIG_DEBUG_FS */
> > -static void inc_used_and_hiwater(struct io_tlb_mem *mem, unsigned int
> nslots)
> > -{
> > -}
> > -static void dec_used(struct io_tlb_mem *mem, unsigned int nslots)
> > -{
> > -}
> > -#endif /* CONFIG_DEBUG_FS */
> > -
> >  #ifdef CONFIG_SWIOTLB_DYNAMIC
> >  #ifdef CONFIG_DEBUG_FS
> >  static void inc_transient_used(struct io_tlb_mem *mem, unsigned int
> nslots)
> > @@ -1132,9 +1101,10 @@ static int swiotlb_search_pool_area(struct devic=
e
> *dev, struct io_tlb_pool *pool
> >  	 */
> >  	area->index =3D wrap_area_index(pool, index + nslots);
> >  	area->used +=3D nslots;
> > +	if (area->used > area->used_hiwater)
> > +		area->used_hiwater =3D area->used;
> >  	spin_unlock_irqrestore(&area->lock, flags);
> >
> > -	inc_used_and_hiwater(dev->dma_io_tlb_mem, nslots);
> >  	return slot_index;
> >  }
> >
> > @@ -1295,29 +1265,12 @@ static int swiotlb_find_slots(struct device *de=
v,
> phys_addr_t orig_addr,
> >
> >  #endif /* CONFIG_SWIOTLB_DYNAMIC */
> >
> > -#ifdef CONFIG_DEBUG_FS
> > -
> > -/**
> > - * mem_used() - get number of used slots in an allocator
> > - * @mem:	Software IO TLB allocator.
> > - *
> > - * The result is accurate in this version of the function, because an =
atomic
> > - * counter is available if CONFIG_DEBUG_FS is set.
> > - *
> > - * Return: Number of used slots.
> > - */
> > -static unsigned long mem_used(struct io_tlb_mem *mem)
> > -{
> > -	return atomic_long_read(&mem->total_used);
> > -}
> > -
> > -#else /* !CONFIG_DEBUG_FS */
> > -
> >  /**
> >   * mem_pool_used() - get number of used slots in a memory pool
> >   * @pool:	Software IO TLB memory pool.
> >   *
> > - * The result is not accurate, see mem_used().
> > + * Returns the sum of per-area used slot counts. The result is approxi=
mate
> > + * since there is no locking across areas.
> >   *
> >   * Return: Approximate number of used slots.
> >   */
> > @@ -1327,7 +1280,7 @@ static unsigned long mem_pool_used(struct
> io_tlb_pool *pool)
> >  	unsigned long used =3D 0;
> >
> >  	for (i =3D 0; i < pool->nareas; i++)
> > -		used +=3D pool->areas[i].used;
> > +		used +=3D READ_ONCE(pool->areas[i].used);
> >  	return used;
> >  }
> >
> > @@ -1335,8 +1288,8 @@ static unsigned long mem_pool_used(struct
> io_tlb_pool *pool)
> >   * mem_used() - get number of used slots in an allocator
> >   * @mem:	Software IO TLB allocator.
> >   *
> > - * The result is not accurate, because there is no locking of individu=
al
> > - * areas.
> > + * Returns the sum of per-area used slot counts across all pools. The =
result
> > + * is approximate since there is no locking across areas.
> >   *
> >   * Return: Approximate number of used slots.
> >   */
> > @@ -1357,8 +1310,6 @@ static unsigned long mem_used(struct
> io_tlb_mem *mem)
> >  #endif
> >  }
> >
> > -#endif /* CONFIG_DEBUG_FS */
> > -
> >  /**
> >   * swiotlb_tbl_map_single() - bounce buffer map a single contiguous
> physical area
> >   * @dev:		Device which maps the buffer.
> > @@ -1508,8 +1459,6 @@ static void swiotlb_release_slots(struct device
> *dev, phys_addr_t tlb_addr,
> >  		mem->slots[i].list =3D ++count;
> >  	area->used -=3D nslots;
> >  	spin_unlock_irqrestore(&area->lock, flags);
> > -
> > -	dec_used(dev->dma_io_tlb_mem, nslots);
> >  }
> >
> >  #ifdef CONFIG_SWIOTLB_DYNAMIC
> > @@ -1531,7 +1480,6 @@ static bool swiotlb_del_transient(struct device
> *dev, phys_addr_t tlb_addr,
> >  	if (!pool->transient)
> >  		return false;
> >
> > -	dec_used(dev->dma_io_tlb_mem, pool->nslabs);
> >  	swiotlb_del_pool(dev, pool);
> >  	dec_transient_used(dev->dma_io_tlb_mem, pool->nslabs);
> >  	return true;
> > @@ -1710,20 +1658,53 @@ static int io_tlb_used_get(void *data, u64 *val=
)
> >  static int io_tlb_hiwater_get(void *data, u64 *val)
> >  {
> >  	struct io_tlb_mem *mem =3D data;
> > +	unsigned long hiwater =3D 0;
> > +	struct io_tlb_pool *pool;
> > +	int i;
> >
> > -	*val =3D atomic_long_read(&mem->used_hiwater);
> > +#ifdef CONFIG_SWIOTLB_DYNAMIC
> > +	rcu_read_lock();
> > +	list_for_each_entry_rcu(pool, &mem->pools, node)
> > +		for (i =3D 0; i < pool->nareas; i++)
> > +			hiwater +=3D READ_ONCE(pool->areas[i].used_hiwater);
> > +	rcu_read_unlock();
> > +#else
> > +	pool =3D &mem->defpool;
> > +	for (i =3D 0; i < pool->nareas; i++)
> > +		hiwater +=3D READ_ONCE(pool->areas[i].used_hiwater);
>=20
> Let's ignore the SWIOTLB_DYNAMIC case for simplicity. The approach
> of calculating a separate hiwater mark for each area, and then summing
> those per-area hiwater marks, can produce very wrong results.
>=20
> Consider a 64MiB swiotlb in a system with 8 CPUs. There will be 8 areas,
> each with 8 MiB of space. Suppose the workload putters along with mostly
> smallish I/Os, say between 4 KiB and 32 KiB. If each area has 16 I/Os in
> progress, the area hiwater mark might be 256 KiB (16 I/Os averaging 16 Ki=
B
> each). Summing across areas produces a hiwater mark of 8 * 256 KiB =3D 2 =
MiB.
> But then suppose a 2 MiB I/O comes in. The hiwater mark for the area that
> handles that I/O will grow to 2+ MiB. After the first big I/O finishes,
>  another 2 MiB I/O comes in that is handled by a different area, whose
> hiwater mark also goes to 2+ MiB. Pretty soon all 8 areas have a hiwater
> mark of 2+ MiB, and the total hiwater mark is reported as 16+ MiB. The
> old algorithm would have reported 4+ MiB, which is accurate. With
> higher CPU counts and more areas, the discrepancy can get much worse.
> This is a somewhat contrived example, but the problem is real enough
> to make the reported hiwater mark be unreliable.

You are correct here, I like your way of thinking.

> I'm sure the contention for the total hiwater mark in the current code is
> real, but it's in the context of a lot of other CPU work that is being be=
cause
> of the bounce buffering, including copying lots of data to/from the bounc=
e
> buffers. Is that atomic increment operation a bottleneck even in the
> end-to-end context of doing DMA through swiotlb bounce buffers?

Practical benchmark show case the highest IO performance for each TVM spec.=
=20
even if a few iperf (4)workers would cause the contention here.
My guts feelings, yes, the real workload probably hit the bottleneck here.

> Another approach to the contention problem would be to have a separate
> CONFIG option that is narrower than CONFIG_DEBUG_FS, so that the
> computation of the hiwater mark can be dropped entirely in production
> environments. Or the setting could be dynamic at runtime via a
> static_call, defaulting to not computing the hiwater mark while still
> allowing a sysadmin to turn it on to see workload usage of the swiotlb.

That's counter-intuitive from my perspective.
With global counters, the observation, which itself impacts the performance=
,=20
wouldn't be able to tell the practical characterization, that's commonly lo=
wer than
max performance, in turn breaks the semantics of what's it for.

Even without those global counters, if user wants to know the hiwater value=
,
snapshotting used value(sum of each area as current behavior) periodically =
would
produce meaningful value for workload evaluation.


> Michael
>=20
> > +#endif
> > +	*val =3D hiwater;
> >  	return 0;
> >  }
> >
> >  static int io_tlb_hiwater_set(void *data, u64 val)
> >  {
> >  	struct io_tlb_mem *mem =3D data;
> > +	struct io_tlb_pool *pool;
> > +	unsigned long flags;
> > +	int i;
> >
> >  	/* Only allow setting to zero */
> >  	if (val !=3D 0)
> >  		return -EINVAL;
> >
> > -	atomic_long_set(&mem->used_hiwater, val);
> > +#ifdef CONFIG_SWIOTLB_DYNAMIC
> > +	rcu_read_lock();
> > +	list_for_each_entry_rcu(pool, &mem->pools, node)
> > +		for (i =3D 0; i < pool->nareas; i++) {
> > +			spin_lock_irqsave(&pool->areas[i].lock, flags);
> > +			pool->areas[i].used_hiwater =3D 0;
> > +			spin_unlock_irqrestore(&pool->areas[i].lock, flags);
> > +		}
> > +	rcu_read_unlock();
> > +#else
> > +	pool =3D &mem->defpool;
> > +	for (i =3D 0; i < pool->nareas; i++) {
> > +		spin_lock_irqsave(&pool->areas[i].lock, flags);
> > +		pool->areas[i].used_hiwater =3D 0;
> > +		spin_unlock_irqrestore(&pool->areas[i].lock, flags);
> > +	}
> > +#endif
> >  	return 0;
> >  }
> >
> > --
> > 2.32.0
> >

