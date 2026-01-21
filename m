Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE73C248F68
	for <iommu@lists.linux.dev>; Wed, 21 Jan 2026 07:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768981866; cv=fail; b=DXDMoMFu6BuqBuuQ4Zj43R3Lhan8aRWJA4nZJEziN8zbxE24DJDYQJMy8ZFbcNhsa9EtDxhrjyifEGA5mQXYhK7naxXCkx4MfBbf74n1kt8O7xzYHw/eQzHixCvYOogl1jex5lmTGM73MLzGUe6sgYajPXY/raeILGWTwCwOGE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768981866; c=relaxed/simple;
	bh=Sjmp7mqYXQkw4S/PE1eTj8rLq9XBrhSzIdw05lbf2Yw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=T07MwnMT4JgqOMVWwWtTB3qWE16I5+7zGfq+JDbYOLFTdsvp5DHUuPVs/Jy3wR/145QGiXXHHTvEbcyhpzzd00F80Smna77G8kArd7uL08LAHmMSpHkTUUVBBamL40ZlSGu79Zw2coD7SmVq73KDTD5F7TrbZfuLzGwpagUXnBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bp5thLHx; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bp5thLHx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768981864; x=1800517864;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Sjmp7mqYXQkw4S/PE1eTj8rLq9XBrhSzIdw05lbf2Yw=;
  b=Bp5thLHxPFsNxilOgCFaJs+zeqfZZCgBWUEZYXdTpC+bnekjkOfDqJwZ
   PbopjQ4qV1/R5pavN5Gj62ea2BTg87gUI+Hi4TXEtUyWKZ1lCtZ/NA30k
   num2KYa4FMhngrclvYf1vb+j8oAb8Ju1ZGuF18BK5sueSamZJZVxxi7kO
   /LFNZbe/v3eqdZfOjJ852ogFZ3YpC7Da/RiUJ/UubatakMXpLIp4MU3fs
   A5xsDog7+1UxqJJfJc1Ujc7epK8JcKjgYyxDFV/oNZ827jGd3LvtK+0ax
   +FtdJlezlgTDU2s+XovFAyBwvpyPC4/iZUGYeBVIJ71yugvvBHLFVQHu9
   w==;
X-CSE-ConnectionGUID: ffY4vpB2QgmHmODzhSgBgg==
X-CSE-MsgGUID: RNlaQ0HFQHadyNbhTadxuw==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="57766180"
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="57766180"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 23:51:03 -0800
X-CSE-ConnectionGUID: RtVAlUs1SLinPB3pM4Yuaw==
X-CSE-MsgGUID: aqZbMyjNTZ6ZmIwUYIn8CQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="210883689"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 23:51:03 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 20 Jan 2026 23:51:01 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 20 Jan 2026 23:51:01 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.71) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 20 Jan 2026 23:51:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=imwZpTiEa2S+rpTH/DVpugFPLUotfwjAT/pqnFUj31FF1HSHdP2H3BcqOJf+nf6Y9RbJtpK5Ktp+ZyK/L72CBVOB9uIop+JylmpUHaCefXK0Yow4ylsf7JHNsY6zFwsbFO6z82ZOkcoj1lVZbtOTrdIOvB5+BR0v7/YniDHJlHhPY8I7qiiFLqSnSxg0L0cebs11UcKzinyt0NvkhjseEHh14cAlI3BcZVU+lxqgM0NV+iVh8he5FFq/OqY8NnJUUjI7jj3takxi9fR5SWRzx+If3nIg4CddftX5eB3lm90Do5R8QNs2y1CF7MokkVIqLy54f7MGeAbZxqgEnkAmaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sjmp7mqYXQkw4S/PE1eTj8rLq9XBrhSzIdw05lbf2Yw=;
 b=ywjJiZLQ4L4dk24AeK7+6YUEBNMlofK7bkFb+9K3QhjwpWAUn0lAvMz2WT6yAkKf6UkxsPCt7jmxwLorzdl5kh5h+LQnYOCBhVipx2xrJXthNPvHiVqo8d1Gg+UDWVpW6KfxrUuzLCOveV4fTElW3+UJgVNwZByEdCtavKpKQBhlyq1cfrJamXpEw1X3+r/gdcVrhcMyCrsmjQu0LDJvIxXaFb2XJU9qJCwt47ouiIXcNob5aMyWIa8tpONsNVTfZ4saz3wGe0O3h2fzLn6EugNEmIL7Wveg4YqfNLcopMoSQ6s0REMJATS2/17zwotVLhh+wsLSJG1sPKlFnfdQ2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 by DM6PR11MB4659.namprd11.prod.outlook.com (2603:10b6:5:2a5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Wed, 21 Jan
 2026 07:50:59 +0000
Received: from BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::780e:4379:6988:f48b]) by BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::780e:4379:6988:f48b%6]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 07:50:59 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>
CC: Dmytro Maluka <dmaluka@chromium.org>, Samiullah Khawaja
	<skhawaja@google.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/3] iommu/vt-d: Clear Present bit before tearing down
 context entry
Thread-Topic: [PATCH v2 2/3] iommu/vt-d: Clear Present bit before tearing down
 context entry
Thread-Index: AQHcidTzCfYiZ0yzRkeXiAiaNaQQUrVcJ3HQgAAUF4CAAAUHoA==
Date: Wed, 21 Jan 2026 07:50:59 +0000
Message-ID: <BL1PR11MB5271D3AE08DAF677E44449B78C96A@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <20260120061816.2132558-1-baolu.lu@linux.intel.com>
 <20260120061816.2132558-3-baolu.lu@linux.intel.com>
 <BL1PR11MB5271F1F4DF8B6D4052D626088C96A@BL1PR11MB5271.namprd11.prod.outlook.com>
 <a2c1531a-f720-412f-9f39-6a6b9fabe5e7@linux.intel.com>
In-Reply-To: <a2c1531a-f720-412f-9f39-6a6b9fabe5e7@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5271:EE_|DM6PR11MB4659:EE_
x-ms-office365-filtering-correlation-id: 52e8fda5-15b2-495e-209a-08de58c1d163
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?bU5sQUo5NTg2MUpSRlZrbmw4YUlRMzMxUmlxQWEwQzdXU0hxZEY2VU5rSE1B?=
 =?utf-8?B?STZlM0NXZXI0aWdySHRIeVR1Z29tRUd6dVZiRWRRblRGT3ZVTTVVeTRwV2xh?=
 =?utf-8?B?UjRTc2xDVEZqNEYzVzlFZVNjYUJtVGJRUUJmR1hVMUphM1FscFlIbWJ6ZmYr?=
 =?utf-8?B?ZzN3UzNqRGVUMnNXY3diNEwxaHJxNm8zWWoxVzh6KzY2aWZmKzdLY0RoK2ZW?=
 =?utf-8?B?cVdNNnFVZFVPVnBsbzNEUFAxMWxOa2JCdUxsTjJieXNIcnpLWE9BNGE3dnB5?=
 =?utf-8?B?a25ZZzNTK0NrRXEvamhoc1JqcFlDUjc0bGhXb1VnZXJmNEdWdkE1OG5iT1p5?=
 =?utf-8?B?ay9VU2NRUU5OWk5WSHhUN1ZTd1liYlpNR3dPaGIwaUFUOVBXbFYwUnI5R3Rk?=
 =?utf-8?B?eVBsdk1ub1FpeVUvQTRYMU9lbURMVkFnZmpiMHdEMStqQnFJWGxYRXpCR0VD?=
 =?utf-8?B?T1ZERGhtNWRETXJ3SXlaei9CdDZEdzFDOGJBV3AvVmxxZVQrcHhEQ2MzTEhG?=
 =?utf-8?B?YWpMSFR3MUdjdEFHVzBGVzJtZ2N5dEdBeWMvdC9wQkg1eUxXOXFCbmhBTHJq?=
 =?utf-8?B?dzcwMnhKL3poSHFPT3FhZHJjck52UzNCV2JjZENublBjWit1ZmlaMXNYVG5X?=
 =?utf-8?B?TkRtYlNVNldtaUIxZzJuOGRUK21Ja1VIeDA3S0srUWtGQ1FyOFg0STB2a2Vp?=
 =?utf-8?B?V3h3OThpZUNFKzFhUkQ0SXpHRDZFQ1cvUEkrVkpXWVhaQXp0bEFqUlZvY2JK?=
 =?utf-8?B?SFlCYVZPK3F2SFVpSk03TWNUL2k1WEFFanl2Q2puVjIwV051Q3lTd1htYjN2?=
 =?utf-8?B?ZTBiUHorTnlwcE42ZTNCSVF3V0tFYVdKUU5SZlNFRGRGVjlzOUtyZ3IxZmgy?=
 =?utf-8?B?akNrV0dvYnNPOTNrd2ZKRG1HamNwbFZJZEdyWHVjWUhINW1ycCtrZDd5LzZW?=
 =?utf-8?B?S05FcEczdWlXaDFoU0R2clk1cGxFOFhmR3I5Vm1OTzROVkdaQTVyVm5uRGVQ?=
 =?utf-8?B?MWEyMEUwb1NlQXR2M1FpTlBlenhTbTNYRjI5eVA0UWpKSk5wTkxKeW1POWVE?=
 =?utf-8?B?ZjhrVk4rR1JWcUFxOFVvNHB4TGVhdklrclUrYXdSbGluS25RK1RaT0ozTWc1?=
 =?utf-8?B?QnNzb0dNcEYwNXpPTDJVT1N6OHVKczRKVUVYTktBZHdhaitYV1pQTDNwNXpl?=
 =?utf-8?B?SjRRVVlWcENKK2JCTWtrbUFyeUZJWTRySE4za2p0TDFxZ1EvdFNKdFlLUmlE?=
 =?utf-8?B?SnlBUm1oNmdFckJRV1g1Y1BHWG16ZG1WaHBQQ1BQUUM0bXhNSmYyWUNBWnFF?=
 =?utf-8?B?VThGRVlBaFVFQk1UamU0d1lwYlZ5OW5meXpWTjhITEhiOUJZOFBFaVFqS3g0?=
 =?utf-8?B?dHRsUmlLZXJMLzY5VDI5YnJlTTROYVoyUFFjcmVnL1QxY0pITlNXVWtpam5B?=
 =?utf-8?B?L3EvUGxCdTNnQWRyZStkZDAyOE83S3FyVkpiMk15ck5kTUFFZm9mYjhwUkZ4?=
 =?utf-8?B?SHUvU2U2NHZHTVRMdTFHMVFmZmpXY3BzQVNIWi9adGJWOWZjL0ljMWdtbEVZ?=
 =?utf-8?B?TEZnV0t3SUU0YldmNGpscysyQ2U3UEYwdXU5S25UU3RrL2hyUmpsdXdubStH?=
 =?utf-8?B?T0FCd0U2ZWtMWTJkdTR6VXZ1VE5YK25xZGxrekloem5iRERFejJoam5ZTm8x?=
 =?utf-8?B?cVJSdUEwRlVFYjRFamJoekFqM1BQWnJSak5OV0NXWHpZcXUxRUF1c012YkZt?=
 =?utf-8?B?YnVWY20vYWh6dXZJUXpVby9MLy9zbE1FdmlvcStkRXIzZUJvaTdkMFNYc2hO?=
 =?utf-8?B?dG51WmZJa1dQSzcwR1B1TnByK3dGYVFFMlFSZFVmQm90WUpwakN2UmJBanVU?=
 =?utf-8?B?MXJxOWh0cnFMancwbFprQktPOXpWR040TThHblB5OVUwNjYxZlBhWUkxbGFO?=
 =?utf-8?B?TUQ4Mzgwc1E3S3hkRkJrSFF1L1VHUUJoWXRZR2hXSW55eUU4SW9ZZ3dZM0N0?=
 =?utf-8?B?QXFhaG1IallaYnY1QkoyU2lsYkg5Y3NNQy81dUxvei81TTVpbm1LVTVoVXFM?=
 =?utf-8?B?MFJkSFBYTWIxeUsxbk5PU1FwY3dkOXBYL2JhODRuVGQ1RWtvWWdvWkpPNGRT?=
 =?utf-8?B?ZFJHV0hIeWlzVElGbTBkYmxBUTZvQm5mZFExQzF3M0ZPS0NCY091SW82WlJW?=
 =?utf-8?Q?29AjmDvpYqwv3d/rZ0WWdpY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5271.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dHVVdG4xN1lNUFFGZ3QvaUpJVExpRDJ4M25DQUlJdTBjYlI1M3hIMjk5T2VW?=
 =?utf-8?B?WWQ4OWFJc3lQRW1DV0Q0VGlIZkZ3WkNBNkJscm9vSnFUNjY0UmwvUGNXNmFI?=
 =?utf-8?B?ZDJwcmErMUdjOUhCNmN6N011ZFBMTjhuUGRzS3NaZ3JMUW1Gd0RwdE5qazVW?=
 =?utf-8?B?Ym5NUmhMQjhsR3VWZTYwMmZBamJ6WVRJcGpCWlFWdkJFcmdWTjc1cG1MMFp5?=
 =?utf-8?B?bkEyTkRpdUdaYm56M3MwTE1kRnpkUW1rbkRLVk5ySTBHdHcvcFpoYUxrRzE2?=
 =?utf-8?B?MnRVV2sxNTdYUGtYOC83VDd2VnNaT3dTcE1mUXUzUzkzRGpDanRjNlNkSnFD?=
 =?utf-8?B?clBNMlhVVGZ6MzBiZFRVa3h3dDNvM1dkemJkV2N6LzNSNTFUSjQxaVJTMk5E?=
 =?utf-8?B?Z3Axay9QSG4ydWFyWFJVVk1aL0d1VkpCajhpSzJpNDZDcm8wRzhZSnlEbngy?=
 =?utf-8?B?UXFvUnJLcTZsUUUxOXBRZ25pOFVmZDZTNW9Rem1xTEM1b053OUFGM21JVFM5?=
 =?utf-8?B?YzBRL2J4UXBhdG11eHhLd1N3Z1JwSHhaU254MUFJZ1lhUk5NbWF2dGk2aGNy?=
 =?utf-8?B?RThhYVQ0bndROEI1cFR2dkE0YXU2LzQ1anVxbkJWSXBoZ21SZzlPOUpxS0s1?=
 =?utf-8?B?L0pRcVFTcEI0UTBzVU5qSmRFMkdIR2ZOV0hURVJUQ0E0OVFnSlUzUXRSeE55?=
 =?utf-8?B?dEk3cEVSM2hmaW5HaGVwUitBTUZTTkx1YmFnYU5QVVVuc3dvd0MzYjFOVzJp?=
 =?utf-8?B?SUlBOWd4cDBJSWtEbDNiTEpKV3pQZ1A0RDNoWHJtcy8wMlIxVDdrZ2l4cjNz?=
 =?utf-8?B?cnMrSytBZjhGeTIvQWdKejR1OHV2QngvU0FRNG5MWm9yNXNrQTg3cUxnNUlM?=
 =?utf-8?B?c3U3L21JNUtPMHl5bEZ4MEJUMC9RNGpGQnBWa0tkK1ZSM2g5VUJoSldIUWxn?=
 =?utf-8?B?clZRMklGQmNadmtLYXVZeElJRUNPeXNvNzdzL1VoRXpGS1I3K0dHck1TWTBE?=
 =?utf-8?B?dm5PUHJnL0VyY3hCdjN6TUxRZzRmRldrWnFjeXFNaU5pRGt5Q0ZGaVlraG9k?=
 =?utf-8?B?MHVKYitNTDAvVWdJVGN4L3BFeFFZcWxXSllFRGRHcjM5NXMycjcreFBDcWpG?=
 =?utf-8?B?d2hxdm53bHZmTW5vRm5NRGRzaVpRV0VsQm9WNmJBRkRwcUFjVTZqQ0tGT3NG?=
 =?utf-8?B?Y29KcXNFa0k2T0RKQS9uVTJjVDlqTTAwdVZ6N3cxdS9GbVBiZFBid3JYM2Jh?=
 =?utf-8?B?OFY0a1NCdlJlaWNhckNUdTJVdFcvNmNxRmZYTjhhVElmTGtwRW8zdEpReWF4?=
 =?utf-8?B?YVV3TS9tSjF2SEM0VmlrMkxxUmVJT3RMRWRHRWFndVByYWQ4UmdWRFZVL0VS?=
 =?utf-8?B?NXgycE1zTktpNG9GK3REd0hNazRxcHJPUzZZcmZnRTZPbTd5VTdac05MdWdS?=
 =?utf-8?B?K2J4OGR0aVE0MDRUY0hJSEowRldkeW9TTzJyMG9mN2hmSVgwQTVZdnJjbTNO?=
 =?utf-8?B?cFdiQWN4QUpSbFJUeU1Eb0JISVBMS1FrWkRheVQzN2tpZldjQWNrUE1CZWN4?=
 =?utf-8?B?TmU5UHZrQUJYMCt2Q0V6M01KRWt5M0N3ZysydDZpWTFvd05iVEpWQ2pianBU?=
 =?utf-8?B?ZkZMRDNzT0JsRHA3NXFNdUEra2p3NmdaOFREc2MwcWJKWFZRWHI3OE9KemtC?=
 =?utf-8?B?SDZUQUwyVldoSkJCZE5ZTWhYUVdUenVFRVlPZW51U0NJK3ZhRmdHYTBucVlk?=
 =?utf-8?B?Q0VDaDIxbnVBQnBLYjVxWk9OZlZJaXZES3JmOGVJdVV0d0pkMHR3M2d5TUZu?=
 =?utf-8?B?aHp5ZGw0elBzazZTeTR6TG85WlJYWFhETVlxV3UrRkNiakZhNmM2am8yZ25h?=
 =?utf-8?B?ZXQ3Q081Ri9ZakxWM3RJRnZRem16L1lmL0p0T1hXVVRZck50TFdWRHJKWXho?=
 =?utf-8?B?TUd2ZXNtYlRWK0JOZUZZaWhIb20zU2dWR2trMWpuZ2ExZzVkNklVTEhQZzBz?=
 =?utf-8?B?U21vL3ZjWG1CMXBOTkJEYnEyYWZTRExwR1B4TU9hQlBqV0pMUHhoS0tCYjNs?=
 =?utf-8?B?S1J3dDZsbGpVSnZ5TTBGSW91OXRoWEpENGlqZFJmSkR4bDBPbVRoRkd1RHN4?=
 =?utf-8?B?U0tMeTVPMVhkSzBHc2tSaFVVR1d0aFlwc1hIOXRYblA4WDJoWFRTSzZOYURV?=
 =?utf-8?B?cUVDZm9CY0V6VklUR3FmVXkza1Z5T3BveXl0ZVNBYXZseUtZZTJseVl4SGpK?=
 =?utf-8?B?d2xyYkJ4QkduQ20yM1JvVFlPdU9tbGV5Wm8rcVBZZElOcDZqN01MYWZyU2VW?=
 =?utf-8?B?Qys0c2hTcHZCQm8ra2RZanh4TXBwQ3RjVDJGdGhXWVVzbHdXNCtndz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5271.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52e8fda5-15b2-495e-209a-08de58c1d163
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2026 07:50:59.7443
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: npWdlzojVT/a86kFVx+U3I8HCA3hgXqiGqNhd6VZAGmgH7aYhtiZO7oYPhg5KYw+rRmA0Y3OsGf5y8SUO1n0LQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4659
X-OriginatorOrg: intel.com

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBXZWRu
ZXNkYXksIEphbnVhcnkgMjEsIDIwMjYgMzoyOSBQTQ0KPiANCj4gT24gMS8yMS8yNiAxNDoyMywg
VGlhbiwgS2V2aW4gd3JvdGU6DQo+ID4+IEZyb206IEx1IEJhb2x1IDxiYW9sdS5sdUBsaW51eC5p
bnRlbC5jb20+DQo+ID4+IFNlbnQ6IFR1ZXNkYXksIEphbnVhcnkgMjAsIDIwMjYgMjoxOCBQTQ0K
PiA+Pg0KPiA+PiBXaGVuIHRlYXJpbmcgZG93biBhIGNvbnRleHQgZW50cnksIHRoZSBjdXJyZW50
IGltcGxlbWVudGF0aW9uIHplcm9zDQo+IHRoZQ0KPiA+PiBlbnRpcmUgMTI4LWJpdCBlbnRyeSB1
c2luZyBtdWx0aXBsZSA2NC1iaXQgd3JpdGVzLiBUaGlzIGNyZWF0ZXMgYSB3aW5kb3cNCj4gPj4g
d2hlcmUgdGhlIGhhcmR3YXJlIGNhbiBmZXRjaCBhICJ0b3JuIiBlbnRyeSDigJQgd2hlcmUgc29t
ZSBmaWVsZHMgYXJlDQo+ID4+IGFscmVhZHkgemVyb2VkIHdoaWxlIHRoZSAnUHJlc2VudCcgYml0
IGlzIHN0aWxsIHNldCDigJQgbGVhZGluZyB0bw0KPiA+PiB1bnByZWRpY3RhYmxlIGJlaGF2aW9y
IG9yIHNwdXJpb3VzIGZhdWx0cy4NCj4gPj4NCj4gPj4gV2hpbGUgeDg2IHByb3ZpZGVzIHN0cm9u
ZyB3cml0ZSBvcmRlcmluZywgdGhlIGNvbXBpbGVyIG1heSByZW9yZGVyDQo+IHdyaXRlcw0KPiA+
PiB0byB0aGUgdHdvIDY0LWJpdCBoYWx2ZXMgb2YgdGhlIGNvbnRleHQgZW50cnkuIEV2ZW4gd2l0
aG91dCBjb21waWxlcg0KPiA+PiByZW9yZGVyaW5nLCB0aGUgaGFyZHdhcmUgZmV0Y2ggaXMgbm90
IGd1YXJhbnRlZWQgdG8gYmUgYXRvbWljIHdpdGgNCj4gPj4gcmVzcGVjdCB0byBtdWx0aXBsZSBD
UFUgd3JpdGVzLg0KPiA+Pg0KPiA+PiBBbGlnbiB3aXRoIHRoZSAiR3VpZGFuY2UgdG8gU29mdHdh
cmUgZm9yIEludmFsaWRhdGlvbnMiIGluIHRoZSBWVC1kIHNwZWMNCj4gPj4gKFNlY3Rpb24gNi41
LjMuMykgYnkgaW1wbGVtZW50aW5nIHRoZSByZWNvbW1lbmRlZCBvd25lcnNoaXANCj4gaGFuZHNo
YWtlOg0KPiA+Pg0KPiA+PiAxLiBDbGVhciBvbmx5IHRoZSAnUHJlc2VudCcgKFApIGJpdCBvZiB0
aGUgY29udGV4dCBlbnRyeSBmaXJzdCB0bw0KPiA+PiAgICAgc2lnbmFsIHRoZSB0cmFuc2l0aW9u
IG9mIG93bmVyc2hpcCBmcm9tIGhhcmR3YXJlIHRvIHNvZnR3YXJlLg0KPiA+PiAyLiBVc2UgZG1h
X3dtYigpIHRvIGVuc3VyZSB0aGUgY2xlYXJlZCBiaXQgaXMgdmlzaWJsZSB0byB0aGUgSU9NTVUu
DQo+ID4+IDMuIFBlcmZvcm0gdGhlIHJlcXVpcmVkIGNhY2hlIGFuZCBjb250ZXh0LWNhY2hlIGlu
dmFsaWRhdGlvbiB0byBlbnN1cmUNCj4gPj4gICAgIGhhcmR3YXJlIG5vIGxvbmdlciBoYXMgY2Fj
aGVkIHJlZmVyZW5jZXMgdG8gdGhlIGVudHJ5Lg0KPiA+PiA0LiBGdWxseSB6ZXJvIG91dCB0aGUg
ZW50cnkgb25seSBhZnRlciB0aGUgaW52YWxpZGF0aW9uIGlzIGNvbXBsZXRlLg0KPiA+Pg0KPiA+
PiBBbHNvLCBhZGQgYSBkbWFfd21iKCkgdG8gY29udGV4dF9zZXRfcHJlc2VudCgpIHRvIGVuc3Vy
ZSB0aGUgZW50cnkNCj4gPj4gaXMgZnVsbHkgaW5pdGlhbGl6ZWQgYmVmb3JlIHRoZSAnUHJlc2Vu
dCcgYml0IGJlY29tZXMgdmlzaWJsZS4NCj4gPj4NCj4gPj4gRml4ZXM6IGJhMzk1OTI3NjRlZDIg
KCJJbnRlbCBJT01NVTogSW50ZWwgSU9NTVUgZHJpdmVyIikNCj4gPj4gUmVwb3J0ZWQtYnk6IERt
eXRybyBNYWx1a2EgPGRtYWx1a2FAY2hyb21pdW0ub3JnPg0KPiA+PiBDbG9zZXM6IGh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL2FsbC9hVEc3Z2M3STV3RXhhaTNTQGdvb2dsZS5jb20vDQo+ID4+IFNp
Z25lZC1vZmYtYnk6IEx1IEJhb2x1IDxiYW9sdS5sdUBsaW51eC5pbnRlbC5jb20+DQo+ID4NCj4g
PiBSZXZpZXdlZC1ieTogS2V2aW4gVGlhbiA8a2V2aW4udGlhbkBpbnRlbC5jb20+DQo+ID4NCj4g
PiBidHcgdGhlcmUgaXMgYSBjb250ZXh0X2NsZWFyX2VudHJ5KCkgZm9yIGNvcGllZCBjb250ZXh0
IGVudHJ5IGluDQo+ID4gZGV2aWNlX3Bhc2lkX3RhYmxlX3NldHVwKCksIGJ1dCB0aGlzIHBhdGNo
IGRvZXNuJ3QgdG91Y2ggdGhhdA0KPiA+IHBhdGguIEl0IHNlZW1zIHRvIGFzc3VtZSB0aGF0IG5v
IGluLWZsaWdodCBETUEgd2lsbCBleGlzdCBhdCB0aGF0DQo+ID4gcG9pbnQ6DQo+ID4NCj4gPiAg
ICAgICAgICBpZiAoY29udGV4dF9jb3BpZWQoaW9tbXUsIGJ1cywgZGV2Zm4pKSB7DQo+ID4gICAg
ICAgICAgICAgICAgICBjb250ZXh0X2NsZWFyX2VudHJ5KGNvbnRleHQpOw0KPiA+ICAgICAgICAg
ICAgICAgICAgLi4uDQo+ID4gICAgICAgICAgICAgICAgICAvKg0KPiA+ICAgICAgICAgICAgICAg
ICAgICogQXQgdGhpcyBwb2ludCwgdGhlIGRldmljZSBpcyBzdXBwb3NlZCB0byBmaW5pc2ggcmVz
ZXQgYXQNCj4gPiAgICAgICAgICAgICAgICAgICAqIGl0cyBkcml2ZXIgcHJvYmUgc3RhZ2UsIHNv
IG5vIGluLWZsaWdodCBETUEgd2lsbCBleGlzdCwNCj4gPiAgICAgICAgICAgICAgICAgICAqIGFu
ZCB3ZSBkb24ndCBuZWVkIHRvIHdvcnJ5IGFueW1vcmUgaGVyZWFmdGVyLg0KPiA+ICAgICAgICAg
ICAgICAgICAgICovDQo+ID4gICAgICAgICAgICAgICAgICBjbGVhcl9jb250ZXh0X2NvcGllZChp
b21tdSwgYnVzLCBkZXZmbik7DQo+ID4NCj4gPiBJcyB0aGF0IGd1YXJhbnRlZWQgYnkgYWxsIGRl
dmljZXM/IGZyb20ga2R1bXAgZmVhdHVyZSBwLm8udi4gaWYNCj4gPiB0aGF0IGFzc3VtcHRpb24g
aXMgYnJva2VuIGl0IGp1c3QgbWVhbnMgcG90ZW50aWFsIERNQSBlcnJvcnMNCj4gPiBpbiB0aGlz
IHRyYW5zaXRpb24gd2luZG93LiBCdXQgcmVnYXJkaW5nIHRvIHRoZSBpc3N1ZSB3aGljaCB0aGlz
DQo+ID4gcGF0Y2ggdHJpZXMgdG8gZml4LCBpbi1mbHkgRE1BcyBtYXkgbGVhZCB0byB1bmRlc2ly
ZWQgYmVoYXZpb3JzDQo+ID4gaW5jbHVkaW5nIG1lbW9yeSBjb3JydXB0aW9uIGV0Yy4NCj4gPg0K
PiA+IFNvLCBzaG91bGQgaXQgYmUgZml4ZWQgdG9vPw0KPiANCj4gVGhpcyBwYXRoIGlzIHRyaWdn
ZXJlZCB3aGVuIHRoZSBkZXZpY2UgZHJpdmVyIGhhcyBwcm9iZWQgdGhlIGRldmljZQ0KPiAoZW5z
dXJpbmcgaXQgaGFzIGJlZW4gcmVzZXQpIGFuZCB0aGVuIGNhbGxzIHRoZSBrZXJuZWwgRE1BIEFQ
SSBmb3IgdGhlDQo+IGZpcnN0IHRpbWUuIEF0IHRoaXMgc3RhZ2UsIHRoZXJlIHNob3VsZCBiZSBu
byBpbi1mbGlnaHQgRE1Bcy4gV2UgY2FuDQo+IGFwcGx5IHRoZSBzYW1lIGxvZ2ljIGhlcmUgdG8g
aW1wcm92ZSBjb2RlIHJlYWRhYmlsaXR5LCBidXQgdGhpcyBpcyBub3QgYQ0KPiBidWcgdGhhdCBy
ZXF1aXJlcyBhIGZpeC4gT3Igbm90Pw0KPiANCg0KZGV2aWNlIGNvdWxkIGJlIGluIHdoYXRldmVy
IHN0YXRlIHdoZW4ga2R1bXAgaXMgdHJpZ2dlcmVkLiBJJ20gbm90DQpzdXJlIHdoZXRoZXIgYWxs
IGRldmljZSBkcml2ZXJzIHdpbGwgcmVzZXQgdGhlIGRldmljZSBhdCBwcm9iZSB0aW1lLg0KDQpK
dXN0IHRob3VnaHQgdGhhdCBhcHBseWluZyB0aGUgc2FtZSBkdWUgZGlsaWdlbmNlIGhlcmUgY291
bGQgcHJldmVudA0KYW55IHVuZGVzaXJlZCBkYW1hZ2UganVzdCBpbiBjYXNlLiBOb3QgZXhhY3Rs
eSBmb3IgYmFja3BvcnRpbmcsIGJ1dA0KaXQncyBhbHdheXMgZ29vZCB0byBoYXZlIGNvbnNpc3Rl
bnQgbG9naWMgdG8gYXZvaWQgc3BlY2lhbCBjYXNlIGJhc2VkDQpvbiBzdWJ0bGUgYXNzdW1wdGlv
bnMuLi4NCg0K
