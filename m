Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CBD1ACEDC
	for <iommu@lists.linux.dev>; Mon, 16 Jun 2025 05:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750052299; cv=fail; b=CGmAEgMo5JJ7dJpjAgres8Ek+bkL1o4jIkRbWIv9NrFU7PL2R85c55zTh/30vnMyZJCnvGctdY3XDIYtSGPP1x0Tnxr6aAbnERYMXvkSr40fyyiliD+8zIu4/OwAR7TmyykqJ5T0lNBZK3pcC7Ju8ELx8DCjhXgeHVQC+un7C8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750052299; c=relaxed/simple;
	bh=KMb7tpyxeNWFik1+qYApdbFuF+V5UIFlFfuiX7HluiY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WE9rRBYJWNcnTDdxd28687yVAcK+gvCWdIo7omVOgKbafDjHNR5uOzQVUky8/pTyHa4WAy9+2QHyEN1nUyGpxAnzslqtADPyx/PWglGdb7yk0ppCa0LYWoWTICFZmkvUgynP512BY9P+PkZY3pDsgX2ZX3C/uID89zaH3tgkYaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q1AP8RUs; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q1AP8RUs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750052297; x=1781588297;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KMb7tpyxeNWFik1+qYApdbFuF+V5UIFlFfuiX7HluiY=;
  b=Q1AP8RUsLZFYeSFuk+7Bc+otV+wfWsejt6obJuRNApl3UlvZvGIb95+o
   jbMspG7HoS1yqCQz2Zeg+TdMNALr46aAiutSVH/iSau1qFl3/NqM+Zz88
   UinkJx899pKBaVi2yaObVWr82akuumVjD9oz1c5t0DT2h4YvRQhbcad3X
   B33Fl4+fTCdETX9hMeNlJSfeDeszKmcWHmYSCB2BYXLga9rnhxQS/3NWj
   UlKh/H4zZSoAyXYI1AXgy0T+oY3OXIxUa4i7VXjtantzuk9hQF6siu7vg
   aoLUz3PU2x7pefA1kFc9LBtcq5qx+jWNX0bAf7b/uJTYDfNg2E/ph4Nlq
   Q==;
X-CSE-ConnectionGUID: 0yTZSedfQvGU8xZPeExqkw==
X-CSE-MsgGUID: lH+WOfy/SS2qPn2NA2P4WQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="55859010"
X-IronPort-AV: E=Sophos;i="6.16,240,1744095600"; 
   d="scan'208";a="55859010"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2025 22:38:16 -0700
X-CSE-ConnectionGUID: grC9g/rhS/eDqbZ5Y+dp9A==
X-CSE-MsgGUID: 1S5eE8hOQDCYWFJ0g+vbpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,240,1744095600"; 
   d="scan'208";a="148274059"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2025 22:38:15 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 15 Jun 2025 22:38:15 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Sun, 15 Jun 2025 22:38:15 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.43) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 15 Jun 2025 22:38:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oRVHlb8O20FfLoDwCe1+9BY/SDzu3uZwW/cu4aeagZyKztkeF68rolsdi2YLvAVR1V/6zZ7fXo7s/n8bljCZ699+25fu4f+InRQsShvTTcDE1d2T+ebUrOYnA1IXG9bSxGiCgFJPA0lSmI+b8I2pEkpQfRcCv3fJw4Tae1vqVLseWdKe1KCgcQG9PpfK7eBLarvD2f7FEkmyWvabBSgK4Rv8JrFKpqf2n5h6xMwNKOvmQjyQeaVHSrGpaGiOO940Jy13HBg6K950yftNIMc/U49uqNL7io/Pohj8paGs+/XP+j0bKLnJ+dCR5ILFVkrun5ao2ogDTRHNexZLGdUVQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KMb7tpyxeNWFik1+qYApdbFuF+V5UIFlFfuiX7HluiY=;
 b=gS5oRBEi04ZuHKNNjpXb7IS2RjH4lxlkNYawgO7baFPmAY+wQvaVVv3jm9bPSwXWANNC0+6WJp1lmSTt5gFAD7gZaKYPnU+kKoKKGK4pCM1ExJaWZOFL78BXfUNzK5v8OMnNNdZLiblj2QYEfvkC/GAXfBrh53sO6RMpLiW38R2anGLBS97tqdl1mawsonxOBo2XiprHdg8JxhFSY/IRmZLDIcF8jkJIhRjtzp2BUJpmZPe9m1BtFLja4QxxOw1R+gEy6dpDFjWJ6vSXig9SQlH+FwWKvOtJau1XePPK16xLPrJSc2XYYtIePjgPRpjVy85/fJFbECMhbqyPf4GvMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS0PR11MB7904.namprd11.prod.outlook.com (2603:10b6:8:f8::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.28; Mon, 16 Jun 2025 05:37:58 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%4]) with mapi id 15.20.8835.027; Mon, 16 Jun 2025
 05:37:58 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Aneesh Kumar K.V <aneesh.kumar@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Joerg Roedel
	<joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>
Subject: RE: [RFC PATCH] iommufd: Destroy vdevice on device unbind
Thread-Topic: [RFC PATCH] iommufd: Destroy vdevice on device unbind
Thread-Index: AQHb2dRy0pZb6YCA9kCQvhSriVTQbbP/KocwgACgJoCAAOcYcIAAW7EAgAQtLwCAAA6p8A==
Date: Mon, 16 Jun 2025 05:37:58 +0000
Message-ID: <BN9PR11MB527633CA2F698E83E12BFBD68C70A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250610065146.1321816-1-aneesh.kumar@kernel.org>
 <BN9PR11MB527606182417BB7A35349F598C74A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20250612172645.GA1011960@ziepe.ca>
 <BN9PR11MB5276B467ADCC57BC6571CA458C77A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20250613124202.GD1130869@ziepe.ca> <yq5abjqotim7.fsf@kernel.org>
In-Reply-To: <yq5abjqotim7.fsf@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS0PR11MB7904:EE_
x-ms-office365-filtering-correlation-id: e1242c2a-991b-495d-10c7-08ddac97f3e1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MVZkNVpzKzFDZDJtWHJ6ODhEUkVMUEV1b1JlSXJzUCtWNXE3a0NGL2llTGMr?=
 =?utf-8?B?a1lSZEtmR1p6elFiZEFCR2JCM3NwaUlDdWNXeGt0V0FLbjQ0RU81MWhBajl3?=
 =?utf-8?B?WFZNSExBTmEwbVFXUm10WjNWZ0ZhbGtNT0tnM3lOSzZyOTRQc05BL2pPQmlh?=
 =?utf-8?B?cm9YekFId2UrTCtHTE5DOEtRR2FSQUswMGwzeUJQKzhyOVlyM3U1Q01rbmZj?=
 =?utf-8?B?dkt3SlpqZUNPUlkzQ1VYMFhydjcxUVVQSHpZM2EzZHNvYTQzV0FLZU8wYTFV?=
 =?utf-8?B?Y3lhUmFLSjd6bnNRalJBekYvT3ZLKyt1UGNBbWdjcnpKaUtjcUpmaDk2cnF2?=
 =?utf-8?B?cnRXZzZiMUFwblpPWm9CbmJXaTNwTGVqc2FrRmdJTkl4SEhjQk9LQVd5NE5E?=
 =?utf-8?B?V0tUYnFLRWFWNXFoUk5vS0s2djlNSjEwQk5hNzhEM08zV2huL2wvTlAwc05s?=
 =?utf-8?B?UlRKdkZuclFXZlRRek04eUZZVmZybzFhemJBTXQ3aVBCa3hKbUNoTUVEeGMw?=
 =?utf-8?B?eklheGJtZkJKcFhFUzFNZ094eVNoMWRRUVBzQndjQm1aZlhVaWpsaXAvQkVq?=
 =?utf-8?B?TkhSK2VpMktydVlzU25lWFBiUTdkWEdyWDkrVjNra1VzYkVrQVJ0SmlWejJm?=
 =?utf-8?B?R3NXaEZuQlJpU3paS3FEaVJhSWJsajRDZCt4djNFc1JnblhxU0FUOFNQK092?=
 =?utf-8?B?Vm5mMTJYQ0Rvc0QzOGk0N2VLQU1ZS0hGVERpUG8vYVQvZlA4Tjk1bjJ6YTNi?=
 =?utf-8?B?Wk80dmowdWxGTEkyT2EzRStQRVFtOTZyNllzaXVOSXMvenZkUiszbVd0T0U2?=
 =?utf-8?B?cWRKcTNUbXVTZysrSDk1WjlwbVhHV1FVVDgvZTI1UEQwS1NUa0pYVCsrdTdH?=
 =?utf-8?B?Q3MwbUJTTkwvQ3F0a1RJYVZZdEZiYldKQklITUZQMmlHaTEzRnNSOEhrWGRZ?=
 =?utf-8?B?UHZJREhVSksvM2JhQUJGd2pWSU85RGRHR0R2WVdCMExoVnJYY1l1Tlllc2gz?=
 =?utf-8?B?RW9WL0hLUTZ0VGI1bnRnY3FOMk5PdWZ5NmhkMzlvZzFhWGpmakpjSStycm1z?=
 =?utf-8?B?RWhENWhRNGFXNDVHWU9WNGdxaHNEMEdXeHBpQ21KcnpyYytlOU0zT2NoRVMx?=
 =?utf-8?B?OWRsbjRMMFMzNHZhL1ozZ2pSY2hkd09mYnZVMzQ2QVgxb1B0cXZobE01WTNR?=
 =?utf-8?B?RzhzUEpPVnZaZVdKOEpiNFQ1N2FpTDJWc3BhaTFEeVJIQkVWMUFyVVh2LzRF?=
 =?utf-8?B?eEc5TTdJQkphYTRTWlpuTUtHdkdPa2pQM3ZieEtUWmhhaDlXU0d6M3RKRk9w?=
 =?utf-8?B?aDdwQXdNaG8rbHRPQnhSWk5xdEpsOGdEckluclJ1TkV3cHRkOWRDdmhSU2Z0?=
 =?utf-8?B?enhJRG9hSlphSm5kaTlOUThXL1VhUFlTWG5pVnFETmwxazBvS0lqTkdCNXpR?=
 =?utf-8?B?SlM3QTdJWkptd0pHeC9SOTRqWExiWVJ0UnNkRko5d1JPQUFOWHBQQTh1a1FS?=
 =?utf-8?B?MmgyaEFETXcyUmxySHZLWlNoVEZ2SHduRXlFTFlKZEVqUE10Z1BHemhNckpU?=
 =?utf-8?B?MnV0dmhkS01xbFBKT0F6NHVsR0RuajFBWWtSNEI4WnlsS2RiWFZqZnl3NWtV?=
 =?utf-8?B?bkZZSUtMSWFWdFpwVkZZTlVlc2o3bDE0RW9RYkNVKy9jNm9RMVMyYWlxbGpX?=
 =?utf-8?B?UndRclc2c0dob0gyZC94V3pvb2tndExOcTU5bTV4NnNMOFhSMndHWmJjQzJ2?=
 =?utf-8?B?cXZWOENKSUpRbldrTnJPTGVoT0dCckdXZ1BzcmMvU1JSUi91enhBS0NVdCtv?=
 =?utf-8?B?VDcvSVNmbFZMT3R4YUVaSXdzRXZZbXZ3cEkxZHZEck9JdU5DSFUzMkxlN25m?=
 =?utf-8?B?Z2tNdHUrVC9BTFJ0NWxTVDZyN1A1VHplVGNIa0pTM3RpSVN3UkhEZllNUm9m?=
 =?utf-8?B?WFJxRmRVK1pxV0VhR01Sb1JFL3JEdE42L0w2NXB0M2NNWEZub0RVS2I2Ymw3?=
 =?utf-8?B?TlA1bFZOa1JRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MWRFNlZkdUpLTEdwZlhhbVU2Vkxoc2RFbm5XRTZBc3RtNExra2NadjlRSnRp?=
 =?utf-8?B?bGpCWHJJK1IrQUh6RU03ZUEvT0dBSnpKUi9nR1dOdytWZWJtOVVhbWRuZSt5?=
 =?utf-8?B?NEZHcVYveUoxQ2lUWWVpRUh5NytpbkxaVDlGQ1laY0NudXJIZFQrTFlGV0Nj?=
 =?utf-8?B?R05hdVhZam5uSXRLeWZmaFRqcXJpcVJMZ0pXT1FHVXlXOHg1c3FKNEpOTlRp?=
 =?utf-8?B?am1ST3Q3VWdsZVdlaUN0ZTFJaDd2aythN3l0aUhyMlREU0h4clZPRzJXWE41?=
 =?utf-8?B?SHprWWV5RjJNclBBQkJmM282alBtN01lRVk0bERVRU9uUUVQdk9RN3dRM0FJ?=
 =?utf-8?B?Q1NxVnpVUU5CSnFqajc1Q2d3MmlTVWpFenJNRUd1SUZUYjdYek11Wkl1aUlt?=
 =?utf-8?B?Q2tzbHhqRTVQREZ5R1dxVmFKZHhrTVhCczNTWFlTZ2M5aVYzR1VYRlZ3eXcv?=
 =?utf-8?B?aUpMZFJQdWxSWmJvZmZpYXJ4WWpnMmVWSzA2aVRMUTFVQ0VDdGJQL3FPT0lK?=
 =?utf-8?B?dHBlSGRmYUZkekp5TCswdmZGQkFHYW52bHloU0w5a29KYlNQWVJpYlAwQnFL?=
 =?utf-8?B?OUZJWFN0OE9Db2MrODVqV3ZObE5tcDRuMzN1UXA4TmlCRDFwQ05xVVBBdDNT?=
 =?utf-8?B?ZktVWWdUdllFR1ZIRFZnUk92OFQ1UnVycUZTeWFVY3E5K3puU3RmMUVnQkFy?=
 =?utf-8?B?VTF6RmgxUzltR0lSUERKQUxHZHo3WkNDVWF1VU9XUE9XcGhqQTV3THo3VGNS?=
 =?utf-8?B?c0VsMUpmUVprdG5UZ2M1WTFJeG9FZm5pUHhRb09XNUQ3S3VTSTd3Z0poOEdL?=
 =?utf-8?B?dUU4bzdUK2toUHIxM2t2N01DclJlZWRYNm14MEZRZlRZbHRldWQrVTRVdzZQ?=
 =?utf-8?B?dGkrRWtYenlITmg3L1pWOUlYNER6ZHlCTGZ2Vk9VOU40WDdJbERSVXB0eDRp?=
 =?utf-8?B?cnZVL3RuaUlOcEZVRGFBelZXZXdvSGJ5Y3dKSlk1WWw3bDVXdzh3T1dMaDBR?=
 =?utf-8?B?WktMNTI5bXI3cG1hQ01mblo2SmlPWEE1OEdua1RtMzdnczJUVmhpeEZaVk13?=
 =?utf-8?B?Wm43dnc4aXFGQU1WVVBRRVl5dVFVVjIvTFlRU2d6elVacDRBZ3ltTEJKeGtI?=
 =?utf-8?B?K1J6aHV5MDFuSndvMm9JdDMzdTRHWi9KMk52TDZ3ZUx1VVJXWUlydVhaeFNr?=
 =?utf-8?B?WTY1VnVvTzl3czQxVjdobTFVOGJ0SjJSbkE0dCtCZytpb3RqaGJDVEtvTmVp?=
 =?utf-8?B?TTBqcGoyb013OHVrOXZGb21TQXV1Y0FsRVVGY2piQWtBRHZFOVkyeTV6aDlB?=
 =?utf-8?B?UHJwRXpQLzZHV3RuWCtNbU84TmlHaTVad1puVXNpZVRJUUpBVTFxWFViRld1?=
 =?utf-8?B?alo4alJ3eFBvdjNIUUVtSXhvWk5va0FDSUZsY00wQW52WlMzaGkyVTlTNWRE?=
 =?utf-8?B?aVlVTmMzcC90Y3AxMXJPc25uSDB1QmdselV6MnF5aGw4Z05UWVhoTHNWVENx?=
 =?utf-8?B?M2xEZU1tTkJvcHN5M0IwUkIxUUw5ZU40SU8zczNwbnM3UXJwZ3lJaXdwU2t3?=
 =?utf-8?B?MDNFRldzR3YxY1FNY3lxY1MraVdvejl0cE1TTHFhWWhyYnlQZGhvUkxsNGxv?=
 =?utf-8?B?TUtQZFkyL0h2cHBXS3VoVjl5amFHNlhaOTRCTys3TGFPZUVIWTBHeXhJUUtr?=
 =?utf-8?B?WDdDNHJxbDFwT2ljUExGUWF3TGpESmNWbDAxai93UlFPSFFzdERzZzRoQllB?=
 =?utf-8?B?anN4VFlpaFR2ZE94TnlqWmN0eWFqd3dObFRpbW4vL3hwbTFoSnpJOEEydVUx?=
 =?utf-8?B?M3hOUHExMnZvaGI3eXBRb2pyaUVVZEM0ZDlKRlkxaEtpUFJna2I2SXJheVc3?=
 =?utf-8?B?Mm5ZZmRPL09XN2YwZDJ6SWpDMXo1bDdUNmlzOWt6ZG1WM01TdW5ZQmVVTHU0?=
 =?utf-8?B?NmxZeTlWN3p5cjZHN0lkN3VRQmpKOWpGSVc1Mm1FaUJybkFhM3ZyaDZQWnpi?=
 =?utf-8?B?ZUc1ajBMZmM2SmRKYTVXVVVhZlZ4RUhGR0ZEUHc2U0ZQeEN3WlZlRGVBTFo0?=
 =?utf-8?B?WGFoV0lpd3ZrMnpJUTNlZlRTdFdFbXQrczNIRGptWnkxeisxSzlRSDJ0VEp3?=
 =?utf-8?Q?ff34/V2fxWfu2hU8jGCBHTqOp?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1242c2a-991b-495d-10c7-08ddac97f3e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2025 05:37:58.8101
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /bBGHcri1nT/6NKvVYXUrtDt28Sh2v2WImzyaxbpdNbpZD0RrJwQ1/BC1ojDLSYfxXNZnig5Vzv+5QK1q9V5nQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7904
X-OriginatorOrg: intel.com

PiBGcm9tOiBBbmVlc2ggS3VtYXIgSy5WIDxhbmVlc2gua3VtYXJAa2VybmVsLm9yZz4NCj4gU2Vu
dDogTW9uZGF5LCBKdW5lIDE2LCAyMDI1IDEyOjI5IFBNDQo+IA0KPiBKYXNvbiBHdW50aG9ycGUg
PGpnZ0B6aWVwZS5jYT4gd3JpdGVzOg0KPiANCj4gPiBPbiBGcmksIEp1biAxMywgMjAyNSBhdCAw
NzozMTo0OEFNICswMDAwLCBUaWFuLCBLZXZpbiB3cm90ZToNCj4gPj4geWVhaCB0aGF0IHNlZW1z
IHRvIGJlIHRoZSBvcHRpb24gaWYgdGhlIHNhaWQgbGlmZS1jeWNsZSBkZXBlbmRlbmN5DQo+ID4+
IGNhbm5vdCBiZSByZW1vdmVkLi4uDQo+ID4+DQo+ID4+IGNvbmNlcHR1YWxseSBpdCdzIHN0aWxs
IGEgYml0IHVuY2xlYW4gYXMgdGhlIHVzZXIgbmVlZHMgdG8ga25vdyB0aGF0DQo+ID4+IHRoZSB2
ZGV2aWNlIG9iamVjdCBpcyBzcGVjaWFsIGFmdGVyIGlkZXZpY2UgaXMgdW5ib3VuZCBpLmUuIGl0
IGNhbiBvbmx5DQo+ID4+IGJlIGRlc3Ryb3llZCBpbnN0ZWFkIG9mIHN1cHBvcnRpbmcgYW55IG90
aGVyIGtpbmQgb2Ygb3BlcmF0aW9ucy4NCj4gPg0KPiA+IEkgd291bGQgc2F5IHVzZXJzcGFjZSBp
cyBzb21ld2hhdCBtYWxmdW5jdGlvbmluZyBpZiBpdCBkZXN0cm95cyB2ZmlvDQo+ID4gYmVmb3Jl
IHRoZSB2ZGV2aWNlLiBTbyB0aGUgbWFpbiBhaW0gaGVyZSBzaG91bGQgYmUgdG8gY29udGFpbiB0
aGUNCj4gPiByZXN1bHRpbmcgbWVzcywgYnV0IHN0aWxsIGV4cGVjdCB1c2Vyc3BhY2UgdG8gZGVz
dHJveSB0aGUgdmRldmljZQ0KPiA+IHdpdGhvdXQgYSBmYWlsdXJlLg0KPiA+DQo+IA0KPiBUaGUg
ZGVzdHJ1Y3Rpb24gb2YgdGhlIHZkZXZpY2UgaXMgdHJpZ2dlcmVkIGJ5IHRoZSAucmVsZWFzZSBt
ZXRob2Qgb2YNCj4gdGhlIGlvbW11ZmQgZmlsZSBvcGVyYXRpb25zKGlvbW11ZmRfZm9wc19yZWxl
YXNlKCkpDQoNCm9yIGJ5IElvY3RsKElPTU1VX0RFU1RST1kpDQoNCj4gDQo+IGFuZCB0aGUgZGVz
dHJ1Y3Rpb24gb2YgdGhlIGlkZXZpY2UgaXMgZHJpdmVuIGJ5IHRoZSAucmVsZWFzZSBtZXRob2Qg
b2YNCj4gdmZpbyBjZGV2Lg0KPiANCj4gICAgIHZmaW9fZGV2aWNlX2ZvcHNfcmVsZWFzZSgpDQo+
ICAgICDihpIgdmZpb19kZl9kZXZpY2VfbGFzdF9jbG9zZSgpDQo+ICAgICDihpIgdmZpb19pb21t
dWZkX3BoeXNpY2FsX3VuYmluZCgpDQo+ICAgICDihpIgaW9tbXVmZF9kZXZpY2VfdW5iaW5kKCkN
Cj4gDQo+IFRoZSB2ZmlvIHN1YnN5c3RlbSBhbHNvIHJldGFpbnMgYSByZWZlcmVuY2UgdG8gdGhl
IGlvbW11ZmQgZmlsZSBkZXNjcmlwdG9yDQo+IHRocm91Z2g6DQo+IA0KPiAgICAgdmZpb19kZl9p
b2N0bF9iaW5kX2lvbW11ZmQoKQ0KPiAgICAg4oaSIGlvbW11ZmRfY3R4X2Zyb21fZmQoKQ0KPiAN
Cj4gVGhpcyByZWZlcmVuY2UgcHJldmVudHMgdGhlIHZkZXZpY2UgZnJvbSBiZWluZyBkZXN0cm95
ZWQgd2hpbGUgdGhlIGlkZXZpY2UNCj4gcmVtYWlucyBib3VuZC4NCj4gDQo+IFNvLCBJSVVDLCB0
aGUgY3VycmVudCBkZXN0cnVjdGlvbiBmbG93IGlzOiBmaXJzdCBkZXN0cm95IHZmaW8sIGFuZCB0
aGVuIGRlc3Ryb3kNCj4gdGhlIHZkZXZpY2U/DQo+IA0KDQp0aGUgYWJvdmUgZmxvdyBpcyBhYm91
dCB0aGUgdXNlcnNwYWNlIGV4aXRpbmcgYWJub3JtYWxseSB0aGVuDQp0aGUgcmVmY291bnRpbmcg
YmV0d2VlbiBGRHMgZGVjaWRlcyB0aGUgZGVzdHJ1Y3Rpb24gZmxvdy4gQXQgdGhhdA0KcG9pbnQg
dGhlIGlvbW11ZmQgb2JqZWN0cyBhcmUgbm90IHVzZXJzcGFjZS1hY2Nlc3NpYmxlLg0KDQp0aGUg
ZXhwZWN0ZWQgZGVzdHJ1Y3Rpb24gZmxvdyBmcm9tIHVzZXJzcGFjZSBpcyB0byBJT01NVV9ERVNU
Uk9ZDQp0aGUgdmRldmljZSBvYmplY3QgYmVmb3JlIGNsb3NpbmcgdGhlIHZmaW8gY2RldiBmZCB3
aGljaCB1bmJpbmRzIHRoZQ0KaWRldmljZS4NCg0Kbm93IHdlIGFyZSBkaXNjdXNzaW5nIGhvdyB0
byBoYW5kbGUgYSBtYWxmdW5jdGlvbiB1c2Vyc3BhY2Ugd2hpY2gNCnZpb2xhdGVzIHRoYXQgZmxv
dzogbGV0IGl0IGJlIG9yIGFkZCBhIHRvbWVzdG9uZSBzdGF0ZSwgYWZ0ZXIgZXh0ZW5kaW5nDQp1
bmJpbmQgdG8gZGVzdHJveSB0aGUgdmRldmljZS4uLg0KDQoNCg==
