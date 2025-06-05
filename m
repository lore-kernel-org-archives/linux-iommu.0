Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C35E8F64
	for <iommu@lists.linux.dev>; Thu,  5 Jun 2025 01:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749085484; cv=fail; b=g5bUUyD3p1hS2yQHRt9rKJg7NSLVTVs5nk6yZySMbCAG07nHK++1n1GxxK/NSmyH7kStB0zZ0BjY/dELKXIk3tnKEOQa/90NRaie6TfYcqs/Xe5fDjyBQfMbe3D7PZKYctFyCBkr/6Mhf15jORmwDNDiZvKinjh4JXFCdwCq83I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749085484; c=relaxed/simple;
	bh=1SO+M2m1W3MMBD4TMbr0C/NIcD1SCj0Ay3CEYMVzc5Q=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LKNgG+okaxM7TCf/pZLGi0sP2HGnJz7NwqnYHpVniduBVTJPvAeDPVaqzRGm2fqd5XFaLvola64tUJneQdO+DQO1yRDnEKL7BG4Qk06L+HavfQ5fbxQJelAMFaq4MD7Ukt7MBuTE9NCQ/DGC/KLWpHTTUknhdRbEqSSk0uy2A4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JdnHvPaD; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JdnHvPaD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749085483; x=1780621483;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=1SO+M2m1W3MMBD4TMbr0C/NIcD1SCj0Ay3CEYMVzc5Q=;
  b=JdnHvPaDJ3hAc+5fmhlTFqeO2QY60KZI1mjzaOqdT/v7yAq4vgG56vG7
   JpKo0yZ4Acr8w3jS6LVlDH8yEPla2gAktzyWfQDftIDAYCOihV18lo5A9
   vwXeAW5vOOPqW7Fc+Qn8ihp5YHW4nejEQa+ftJK/iVLOqAdtVdN/1CVIz
   OsmhJ+uEbeuR2LwtxRm/UF5sBycxSdk/eVbuENgJph3cdOURIw2f4E9D+
   ELgjrY4IENcrSzfi9p35eT03PqgddxS0SZLSfy5pPoakXPGG+bBvuzrak
   IRWSo2FUsaRF1TTAR8NCFaO1RbQl12QQ3mhRQR47XJIpmdcq8Cy6tjCSV
   A==;
X-CSE-ConnectionGUID: 4PIJAptuQla/M9kXo1NGeA==
X-CSE-MsgGUID: oUykZhHSTNKXnfOLz18nTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11454"; a="51256688"
X-IronPort-AV: E=Sophos;i="6.16,210,1744095600"; 
   d="scan'208";a="51256688"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 18:04:37 -0700
X-CSE-ConnectionGUID: SsgGd/uJTzydURKJ83VqvA==
X-CSE-MsgGUID: g7+fONRzTq26+7fKXxSILQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,210,1744095600"; 
   d="scan'208";a="145689312"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 18:04:33 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 4 Jun 2025 18:04:33 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 4 Jun 2025 18:04:33 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.78)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 4 Jun 2025 18:04:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OFrL2NN9UbkPZESD+PNbytr0DplVSPBaRfnppKxEujO5yJnxDVPnOc6YJ3NmFZ5jGEhN4bzpk2/B3E1wby8gL87wLQU7dIJqaS7KUdbvPegCbZWlV2v3cRPnYK2Lsd3YcmrHYHF6WrrnrLkzUJTcusI2VC4/r64qC2WP8EMsiWyHgJNN0wnuZvv6lMZ9WPZGgj1g0saf4zy3PNiBIDcAzV4BOEOpMgN8SJG9rGHw0OrEBkZBL1Z1sXpb/DyojqR1U1058to7CAOHemUsJVyM8HjYpF6d3MIjElDHgPozn00vq1Jil5gzOZAX1M+PBocGs6R4HYIUYsc2BUt/DtCcRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1SO+M2m1W3MMBD4TMbr0C/NIcD1SCj0Ay3CEYMVzc5Q=;
 b=uCqphorZB39+2GKmGf6Npiuw+00mArFVO77cP25HBm898VbAndDpdjzdlX5HdsfbgiRnZGeRU3EeSzdmnS2N5jji6yRArr9PTnoAZOtNJt0xhCLatd/Rs6XGPL5b8gbPsQW44EYkyf2Fwx715tyioLg2xBC+4ZWu137MhDExus+l1LXSG66BL3iC+RAeY1lpRSWbAtTlDuORRVD9KPx6fEv8hZ7OeT27LBKI2u/yrIqnREVo/Q52EGXbBDG8ii0LrNhc41gnxEUfQK4DNpvNlEqMfYjzTbvERui2wBq/0Bv7dQDvdnOEwqaytS4u2O//O0tqEZZnAuwF0PRyuPevZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB6373.namprd11.prod.outlook.com (2603:10b6:8:cb::20) by
 PH3PPF76AA2D882.namprd11.prod.outlook.com (2603:10b6:518:1::d30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.25; Thu, 5 Jun
 2025 01:04:29 +0000
Received: from DS0PR11MB6373.namprd11.prod.outlook.com
 ([fe80::2dd5:1312:cd85:e1e]) by DS0PR11MB6373.namprd11.prod.outlook.com
 ([fe80::2dd5:1312:cd85:e1e%5]) with mapi id 15.20.8769.029; Thu, 5 Jun 2025
 01:04:29 +0000
From: "Wang, Wei W" <wei.w.wang@intel.com>
To: Ethan Zhao <etzhao1900@gmail.com>, "Tian, Kevin" <kevin.tian@intel.com>,
	Ethan Zhao <haifeng.zhao@linux.intel.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>, "jroedel@suse.de"
	<jroedel@suse.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>
Subject: RE: [PATCH v1] iommu/vt-d: Remove the redundant logic in
 first_level_by_default()
Thread-Topic: [PATCH v1] iommu/vt-d: Remove the redundant logic in
 first_level_by_default()
Thread-Index: AQHby3jxNyiF43XJukyxASPaPlllB7PpI4qAgAAGaQCACYLcAIAAVbEg
Date: Thu, 5 Jun 2025 01:04:28 +0000
Message-ID: <DS0PR11MB637325E3CD8FECC9A1D1213ADC6FA@DS0PR11MB6373.namprd11.prod.outlook.com>
References: <20250523081056.223082-1-wei.w.wang@intel.com>
 <01e5d0a9-715a-48d4-a2a4-2a0b5d99149b@linux.intel.com>
 <BN9PR11MB5276CFBD4CF795CCB3ADCD1B8C66A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <5fed2452-ae2a-4fca-8483-85ecf645ec1b@gmail.com>
In-Reply-To: <5fed2452-ae2a-4fca-8483-85ecf645ec1b@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB6373:EE_|PH3PPF76AA2D882:EE_
x-ms-office365-filtering-correlation-id: ab67dff7-db51-443a-1e95-08dda3ccec55
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018|921020;
x-microsoft-antispam-message-info: =?utf-8?B?MzhtWXQ5SUwwOUpsZlZLVFRCb0pxeWdVY3AyVWtyL2hOblZvN0FFTHBNVXNN?=
 =?utf-8?B?YXc4V2tmV1BBK3VIVit0cG5Fc2h1VGtwMVNrNUlrcTB4aGF0NVpqUnlycElQ?=
 =?utf-8?B?eGZBcDJwWTV2NXR5MVowQUFwcnBsNnlyZWkyeHd5SmpkTTJMQ3ppeGhUMzMr?=
 =?utf-8?B?V1o3TnBSVzBpMjBOR0VjaGxmTkhPYUk0d2xpWjRxdVR5ZG55TitwU2xWTEVn?=
 =?utf-8?B?cWJ2OG05czM5YWFqbko4bUdNV2hLQmtscEZCcUZlTUJTQWF5N013dnBRdHhQ?=
 =?utf-8?B?alEyYmtNZ2hZeVM1OHRkMmx5Y0o0dFhQZU5HajkxQzZkamt1WkttV1QvKzNs?=
 =?utf-8?B?S2Jsc3BBTGJIbWpqZlQ4ZU5GTzlUeTJRbnl5UzQyVzFLZUwwSUxqc204VzVR?=
 =?utf-8?B?RCswc25kWjhURXJVWURaU25jY25jMEpxY0J5RzdIQmtMSDNRRkFTSmdtRFBB?=
 =?utf-8?B?UXRzdlF5ZzJhOVRmVlFTUUNpaXV6RjIrNERpQlZGelplbUhQeHpDd1hpdERs?=
 =?utf-8?B?QWZQeUgzQzdHVUYxbGI1WjhlU3BDS3hyN2hnTCtOSXpMQUg1dExIc0lFL1ds?=
 =?utf-8?B?bUhXQVhBQnFJb1FicTBMWTZRZER1VWNJWnp3dTBZTU5CelBROVE4WmFhL0tn?=
 =?utf-8?B?QVZYQ01rUmZmYmdzcm9QSllqYWFtalVFakNMN0M2QkhOUTQraXhCK3RXRi9M?=
 =?utf-8?B?aWNMNzJWSWNjMXp6cUhqU3VIejUzdGx5U2NHSkc4VWhSUFNLRjhOTjQ4ZEwy?=
 =?utf-8?B?WUtNUU1SbVVyaGcrdVBFbE9pclF4VVdQNDB4UTQrSmJtckt3OSs1bEJLU1hB?=
 =?utf-8?B?bk1iRTlxSDJHQVZraGFPUVZuQjZIVnlhTXNWUHlIVmpJQUgvTWhVTU94RlRm?=
 =?utf-8?B?RkY0TDhLWjdldkRBUVNCd1Z3SFF1ZTJSemJjK3FKR2ZMZVZCNnFyd0FKZXNY?=
 =?utf-8?B?eWhRQjMwWUZqODZYaHRXWjZJZHB2SklkOWJDV3U3bFl5emEwL1FYTFR0clhT?=
 =?utf-8?B?NldmekFtTFM3b01TK2RLYXFXeGJucFVVWFhqNUI0MTJHdmk2U1BaM3BHREdz?=
 =?utf-8?B?NmxtZUtWcWZMNmdSNGZMaE8yczlsOWQzdnNncFRINk95Q2l1dDBKQTl4MEg3?=
 =?utf-8?B?TjNYVkd2NmZpUzIweEpIT2tPYWpYSjNtZ1NmVzk2cGRrUnIrcXBLVURyR1BI?=
 =?utf-8?B?V1dTTWxhMkJkM2E2eFc1eFpVamhORWhsVFZyN001K1ltZkdJeVFqMXZ3bmJv?=
 =?utf-8?B?NjZUL2NLcjlpblljUTJ4RlVLMUE0OWpSWGNVMEt4SXpmWCtGVm0zZjZ5OStl?=
 =?utf-8?B?Tk00eEV0S3Z4dFByZ3ovNXVjdnFiaDlqcS9SSW4rRHo2OUJOTTZjS0N0cjM5?=
 =?utf-8?B?RVhqSi9mNzQvRDlPYTR5eENFQmhiMnZhY3lrdWhHVmtEV3JnVzRKbW9yRDND?=
 =?utf-8?B?M2lOUTQ4OExqS2I3VStkUkRJZnA2b05PRGw2MENVUDlIdEpBd01wTDQraHJF?=
 =?utf-8?B?LzdsKzZsM3BVaGc1ZHpIMkpuQmFqamo3WHhxTUpPdW93N0N3Tm5DcUg4dExJ?=
 =?utf-8?B?RmFhczFVQ2Nqek8wZkZwY21hK1JQK3lNYnB6UW1qU0RtQzZVWCszUVFTa3Bx?=
 =?utf-8?B?TkZGL0hLK2NpcGZBcytFU3BNVTVDTWdMOWU3Y1BhVjlZL0EzNWpVK0Jla3ZJ?=
 =?utf-8?B?b0F3OU03T1FsdWg3M08yTWg0M2pkU0xnOGZYeHlzbi9Jbk1iejIxamxRTU9V?=
 =?utf-8?B?WitqNmpYWWdwK29US1F1aGtpOUVzNlNVcjlUa3RiRXMyVzVsaXhCcFExSGhY?=
 =?utf-8?B?Tk0ybTFLWnYvSkMrNUN0bWx1bmVHZkJMYTRFVWM3clVWMHo0TlZOYnRNTlFu?=
 =?utf-8?B?anV1RFRaS0V3dVNuUndtNFJaMGlEY3B2aHpxQ3NhTVByVlJRYTl1cDFJS3pP?=
 =?utf-8?B?Z0YyTXZ6Nzc5bXJqS09KeUQvYUFTL29TZEpxU3d1NWZmUFYxSnlHdVU1Tmpm?=
 =?utf-8?Q?JoX+Pzlg7wAPo57hMcN3t2SdRsN8iI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6373.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T0kwaFMzYklmN2JjNzYzOHF3NFFwaVZSTWx3ck1ZZWM4Z3ZxU3F2QUppeDR2?=
 =?utf-8?B?eDFlbDRjeUZjWUNUck1meEtUWlUrVHJ2RXZGVHFVcGpHSG5ab1h4TVpDYTVu?=
 =?utf-8?B?WDNxSS94NkdSYnNBMnpPY1dZcndqR2NSN1pVQXZ2eUZocUN5VUZCWFZ6NW95?=
 =?utf-8?B?UEZsWHByWmpUVGFMWENBdmZvVWtYTUEyZmZVQ2F6UHRWUENLTmFtRk1SVGt0?=
 =?utf-8?B?R2NlNHUxaWdvSm16UEQzYUM3c2JQajJSQ3grKzRHMWN3NEQrcWVLWWUyOVIw?=
 =?utf-8?B?K0hNbWxySXd2ZkoreWVaZzVNSE9jaXdubGl4dUFiY3lNYzI2KzY5RTlYMCth?=
 =?utf-8?B?RUoyNS8waUh1S2lWd2IxSk1vMEhaZjlzMlg5UE5sN21QeDZ3dFNTL0F3OE96?=
 =?utf-8?B?K2psdnJrN3MwSVZWZytMUGx2MXBBWDk5TUJEUE9VYWhTMC9xWUk2KzljM005?=
 =?utf-8?B?Y2phUmdwajFJeEZZOXlMYzJPMGFyMjJrYUp4VTlZSk9JL1Awb3d6T3dUbENz?=
 =?utf-8?B?VTMvR1ZNWlgzcjZBVVZmTVhad2R4MjkxZDQrU25WU0xlZXlmVnIyMHN1cjBx?=
 =?utf-8?B?dEd0K05lL2N0ZGVneWM2U2FkdFQxVm1rQzI1WUpOblY4enE1aWc4ajRQQkhP?=
 =?utf-8?B?MGNManZ5U1dxeEtxUDZiRVI1QStpZVdxMnZIaGVlZWNoVjlxUXVNREpaZjFV?=
 =?utf-8?B?SG82NUV1T0JWdFBWZWx6eVNsTUEzOUV2Tm44TWdXdjNTV3JyOEZoeDdmbi9a?=
 =?utf-8?B?VmN2SWRxRG9XQjUrQXB0SUdwMFB6S05ZWW80bk5hbEZ6ZkMrTXV6N3JaeDFI?=
 =?utf-8?B?cnpzRGtiMzh1M0RZbkZzc1paNWMxUWcvOVhvRFk5UlA0YkxYVnJFbVNobStU?=
 =?utf-8?B?elhHNDY5U1NDeVBZdWErSm1XcUEvaTI0eHJsT2tiT3AzdXg0QmFVMmV5REo0?=
 =?utf-8?B?am5VSGJpUkRVd2Npa1FiS3hxaDA2TlR3SnRybHR0SFcrdjkrSVd3YVBxOWNY?=
 =?utf-8?B?VVFjbmJTUUVZejZDRitjZC9UK05OK3ZkdEswdnlJRkxpWlhLUjBxYmZJVWlB?=
 =?utf-8?B?SDhyMUhQYkRhcU5PNng5bFVZc3Q3aTJVdkhDUHVENHVVdk53UFJVMk5oNW0x?=
 =?utf-8?B?Z3grMWZBcU5rRWZ2WDZ6SWdmUVhBUXpwMWZCMUw1WThJYUg2d1A2TlBOTWRj?=
 =?utf-8?B?cSsyQk5BSkF4c29heVhBUHNmdk9UdG1IeWhlMVdBVkFUVUdlbEFReEJoTkx1?=
 =?utf-8?B?VXU5bTY4Y2QvK3hhaHRKVW5wREZCM3ZvaFZ0TjdxdGVhTm5aVXlVY0FqV05U?=
 =?utf-8?B?WUNiSzBzR2lCOHRML1pYcTF4ZVJsYlZMWlNLb001Y0M2ekxVQ3NPcnFMSlBt?=
 =?utf-8?B?aXBEcmJpSVNMT0tXQ2NZUkpUOThBL3B6UWRuSWJhYTl2SDFYOEhNYXA4TnZu?=
 =?utf-8?B?N3BSUE5kMnpMdkoyRWZzVGUySjJCRGh4L05OZTU0c1RDRTNQKzNPUndXdDZL?=
 =?utf-8?B?eEVReU5MWmV4R1dJZ3pjTkRXZDBNc2QvVXg4eG5GVXdYcElSSmRHSkdJamZK?=
 =?utf-8?B?ak5EVFpHZE04OXptb3Q5YzV5eHM0d0p2YmJjQ01Xai9WbHRlS1JpSkRhZ25r?=
 =?utf-8?B?TkhrZG9jdWxjbVlURkZwc1dWRngzYWpXV1ExVFdGUE8wYWNLSzRvQlEwT293?=
 =?utf-8?B?MnFBMnZUOWwvSGQrZ3g5aHJoWXlNL1hvemxVWll1S1ArVDE3VDZhOWhBTE5Y?=
 =?utf-8?B?R25jRXNUZzBkbFF3d296ZW04dWZ0WDBmNStvS0h0OFJJTkpHcWZIRndRQlIv?=
 =?utf-8?B?K0tUNmhDV3hqYXRsR1UwQjg4eDhLTTlXNGhIUktreWkzSnlaVmFBS3UxKzF5?=
 =?utf-8?B?djdJY2hlazlrQ2k4bEZaKytEbUlDTzdJY05SNjJrTDZENHVFNzNhamRRUCtX?=
 =?utf-8?B?VlVMR210TEJXVXcxL0VORjZhT1R0M0NhZ3lyekE1dlpDSTVsc0VCeVcyVW5U?=
 =?utf-8?B?MWVKVVBDYlA1OEtMYW1RMDhZaC93ZEdHcXZ2ZEJQVG5TVU1OTkFjYnNDVG01?=
 =?utf-8?B?MGNPcUVnV1hjNnlkNEFCeDlHZHhrMVNkcmllb2l6anRseUtZRzlxS3FUSUd5?=
 =?utf-8?Q?6UjknLo5aUD2OAcV/SV+ERQQU?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6373.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab67dff7-db51-443a-1e95-08dda3ccec55
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2025 01:04:28.9557
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +g/Y+F974IdYX4VkUk84jCCiF5DBbdcP2iTTfz3deKmK3epmkLcW2o3YfnsJmyHSftIQei5kgT1Tz54Aq+hXOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF76AA2D882
X-OriginatorOrg: intel.com

T24gV2VkbmVzZGF5LCBKdW5lIDQsIDIwMjUgMzoyNiBQTSwgRXRoYW4gWmhhbyB3cm90ZToNCj4g
T24gNS8yOS8yMDI1IDI6MTEgUE0sIFRpYW4sIEtldmluIHdyb3RlOg0KPiA+PiBGcm9tOiBFdGhh
biBaaGFvIDxoYWlmZW5nLnpoYW9AbGludXguaW50ZWwuY29tPg0KPiA+PiBTZW50OiBUaHVyc2Rh
eSwgTWF5IDI5LCAyMDI1IDE6NDggUE0NCj4gPj4NCj4gPj4g5ZyoIDIwMjUvNS8yMyAxNjoxMCwg
V2VpIFdhbmcg5YaZ6YGTOg0KPiA+Pj4gVGhpcyBvcmlnaW5hbCBpbXBsZW1lbnRhdGlvbiBpbmNs
dWRlZCByZWR1bmRhbnQgbG9naWMgdG8gZGV0ZXJtaW5lDQo+ID4+IHdoZXRoZXINCj4gPj4+IGZp
cnN0LXN0YWdlIHRyYW5zbGF0aW9uIHNob3VsZCBiZSB1c2VkIGJ5IGRlZmF1bHQuIFNpbXBsaWZ5
IGl0IGFuZA0KPiA+Pj4gcHJlc2VydmUgdGhlIG9yaWdpbmFsIGJlaGF2aW9yOg0KPiA+Pj4gLSBS
ZXR1cm5zIGZhbHNlIGluIGxlZ2FjeSBtb2RlIChubyBzY2FsYWJsZSBtb2RlIHN1cHBvcnQpLg0K
PiA+Pj4gLSBEZWZhdWx0cyB0byBmaXJzdC1sZXZlbCB0cmFuc2xhdGlvbiB3aGVuIGJvdGggRkxU
UyBhbmQgU0xUUyBhcmUNCj4gPj4+ICAgICBzdXBwb3J0ZWQuDQo+ID4+Pg0KPiA+Pj4gU2lnbmVk
LW9mZi1ieTogV2VpIFdhbmcgPHdlaS53LndhbmdAaW50ZWwuY29tPg0KPiA+Pj4gLS0tDQo+ID4+
PiAgICBkcml2ZXJzL2lvbW11L2ludGVsL2lvbW11LmMgfCAxMCArLS0tLS0tLS0tDQo+ID4+PiAg
ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDkgZGVsZXRpb25zKC0pDQo+ID4+Pg0K
PiA+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUuYw0KPiA+Pj4gYi9k
cml2ZXJzL2lvbW11L2ludGVsL2lvbW11LmMgaW5kZXggY2IwYjk5M2JlYmI0Li4yMjhkYTQ3YWI3
Y2QNCj4gPj4+IDEwMDY0NA0KPiA+Pj4gLS0tIGEvZHJpdmVycy9pb21tdS9pbnRlbC9pb21tdS5j
DQo+ID4+PiArKysgYi9kcml2ZXJzL2lvbW11L2ludGVsL2lvbW11LmMNCj4gPj4+IEBAIC0xMzY2
LDE1ICsxMzY2LDcgQEAgc3RhdGljIHZvaWQgZnJlZV9kbWFyX2lvbW11KHN0cnVjdA0KPiA+PiBp
bnRlbF9pb21tdSAqaW9tbXUpDQo+ID4+PiAgICAgKi8NCj4gPj4+ICAgIHN0YXRpYyBib29sIGZp
cnN0X2xldmVsX2J5X2RlZmF1bHQoc3RydWN0IGludGVsX2lvbW11ICppb21tdSkNCj4gPj4+ICAg
IHsNCj4gPj4+IC0JLyogT25seSBTTCBpcyBhdmFpbGFibGUgaW4gbGVnYWN5IG1vZGUgKi8NCj4g
Pj4+IC0JaWYgKCFzbV9zdXBwb3J0ZWQoaW9tbXUpKQ0KPiA+Pj4gLQkJcmV0dXJuIGZhbHNlOw0K
PiA+Pj4gLQ0KPiA+Pj4gLQkvKiBPbmx5IGxldmVsIChlaXRoZXIgRkwgb3IgU0wpIGlzIGF2YWls
YWJsZSwganVzdCB1c2UgaXQgKi8NCj4gPj4+IC0JaWYgKGVjYXBfZmx0cyhpb21tdS0+ZWNhcCkg
XiBlY2FwX3NsdHMoaW9tbXUtPmVjYXApKQ0KPiA+Pj4gLQkJcmV0dXJuIGVjYXBfZmx0cyhpb21t
dS0+ZWNhcCk7DQo+ID4+PiAtDQo+ID4+PiAtCXJldHVybiB0cnVlOw0KPiA+Pg0KPiA+PiBUaGUg
ZnVuY3Rpb24gd29ya3MgbGlrZSBhIGRpZ2l0YWwgY2lyY3VydCBoYXMgMyBzaW5nbGUgYml0IGlu
cHV0cw0KPiA+PiBzbSwgZmx0cywgc2x0cyBhbmQgb25lIGJpdCBvdXRwdXQgcmV0Lg0KPiA+Pg0K
PiA+PiBzbyB0aGUgdHJ1ZSB2YWx1ZSB0YWJsZSBvZiB0aGUgb3JpZ25hbCBmdW5jdGlvbiBsb29r
cyBsaWtlDQo+ID4+DQo+ID4+ICAgwqDCoCBzbcKgwqAgZmx0c8KgwqAgc2x0c8KgwqDCoCByZXQN
Cj4gPj4gYcKgwqAgMMKgwqDCoMKgIHjCoMKgwqDCoCB4wqDCoMKgwqDCoCBmYWxzZQ0KPiA+PiBi
wqDCoCAxwqDCoMKgwqAgMcKgwqDCoMKgIDDCoMKgwqDCoMKgIHRydWUNCj4gPj4gY8KgwqAgMcKg
wqDCoMKgIDDCoMKgwqDCoCAxwqDCoMKgwqDCoCBmYWxzZQ0KPiA+PiBkwqDCoCAxwqDCoMKgwqAg
McKgwqDCoMKgIDHCoMKgwqDCoMKgIHRydWUNCj4gPj4gZcKgwqAgMcKgwqDCoMKgIDDCoMKgwqDC
oCAwwqDCoMKgwqDCoCB0cnVlDQo+ID4NCj4gPiAnZScgaXMgYWN0dWFsbHkgd3JvbmcuIFdlIHNo
b3VsZCBub3QgcmV0dXJuIHRydWUgd2hlbiB0aGUgMXN0IGxldmVsDQo+ID4gY2FwIGRvZXNuJ3Qg
ZXhpc3QuDQo+IA0KPiBJZiBzbywgdGhpcyBwYXRjaCBzaG91bGQgbWVudGlvbiBpdCBmaXhlcyBz
dWNoIGNhc2Ugd2l0aCBmaXggdGFnLCBub3QNCj4gICAicmVtb3ZpbmcgdGhlIHJlZHVuZGFudCBs
b2dpYyB3aXRoIHRoZSBzYW1lIGJlaGF2aW9yIi4NCj4gDQoNClByb2JhYmx5IG5vdCBhIGZpeCAo
anVzdCBjb2RlIGltcHJvdmVtZW50KS4gWW91ciAnZScgYWJvdmUgaXMgbm90IHBvc3NpYmxlDQpm
cm9tIHRoZSBoYXJkd2FyZSBzaWRlLCBhbmQgdGhlIG9sZCBpbXBsZW1lbnRhdGlvbiBkb2Vzbid0
IGhhdmUgaXQgdG9vLg0KDQoNCj4gPg0KPiA+Pg0KPiA+Pj4gKwlyZXR1cm4gc21fc3VwcG9ydGVk
KGlvbW11KSAmJiBlY2FwX2ZsdHMoaW9tbXUtPmVjYXApOw0KPiA+Pg0KPiA+PiBBbmQgdGhlIHRy
dWUgdmFsdWUgdGFibGUgb2YgdGhpcyBuZXcgb25lIGxvb2tzIGxpa2UNCj4gPj4NCj4gPj4gICDC
oMKgIHNtwqAgZmx0cyBzbHRzwqDCoMKgIHJldA0KPiA+Pg0KPiA+PiBmwqDCoCAxwqDCoMKgwqAg
McKgwqDCoMKgIHjCoMKgwqDCoMKgIHRydWUNCj4gPj4gZ8KgwqAgMcKgwqDCoMKgIDDCoMKgwqDC
oCB4wqDCoMKgwqDCoCBmYWxzZQ0KPiA+Pg0KPiA+PiBowqDCoCAwwqDCoMKgwqAgMcKgwqDCoMKg
IHjCoMKgwqDCoMKgIGZhbHNlDQo+ID4+IGnCoMKgwqAgMMKgwqDCoMKgIDDCoMKgwqDCoCB4wqDC
oMKgwqDCoCBmYWxzZQ0KPiA+DQo+ID4gc28gdGhpcyB0YWJsZSBpcyBjb3JyZWN0Lg0KDQo=
