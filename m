Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983F15223
	for <iommu@lists.linux.dev>; Thu, 20 Feb 2025 08:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740040438; cv=fail; b=kbf2tU5+u57MZFBuV8N4RNJuZwYJXuMOfwq9WkXRCdklw6s74zN3/O+odY6ioI3QXpcn4UeSNwIVwehASfnTWsNj0mW7WAb5v9vS8ILKd2Ubwxkx61Sx+LM3cvPPKCW/XQL3ogKlul1/czqFsqHJPrJDB+3Pqs8XDDY3TBgwylc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740040438; c=relaxed/simple;
	bh=fYS2rM8n6YbBT4GgXzcMjmC07znQr05Lj6dbIM8z+5M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cQ+HSfyVggEyc7zZZvE5wIF5gv3oX8wrHupmy4mgch4zWA3uNogxqKYjf6wy7R6rPmIaXYsJNYkdeoe42G4Y5iXbwWMjlKZjPV9rjDkZb3TIDzQDNpAhSHzM0ZhBG42Fj2Pg49+Nf+xm0rDNlpf7Dhn7D5B7X+KlBCWZCS4nwJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cy09XooX; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cy09XooX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740040436; x=1771576436;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fYS2rM8n6YbBT4GgXzcMjmC07znQr05Lj6dbIM8z+5M=;
  b=Cy09XooXg0jCyUOmpoRA2WoVyCl8j0hNkxVBy9s2ym/FzJV7ofsHlCTW
   0cMApo/X/cdHwxqSn6xIzOegcd9dtKkgmcYJ6ZLJR6d/LSTfzJsmBDG6U
   GoKIlRM+QtpcJrrjBZ3g2wxqOwrsYALV10bt8h1hxKkaHc8md/ZmJkPB5
   LXlpOBpucrJocGsB1Nv1qOJBiDkeYZo3gXuagTnNsa/XKJRowV9eZm6Oa
   Y9k/tKzOY6l5ayqjdweP5gDZ73AkE+YD0ZTA1gh5z0fZaq21DMoywcopl
   wL6aLQFW+JaeV5q9FPMKCiQIm4TBZcVZAMfLgbXDOb7sJwKlIrhDKnVo8
   g==;
X-CSE-ConnectionGUID: 1BFVeNPTQ+i0IBppe2Dbfw==
X-CSE-MsgGUID: AtdlOIthT0mOji3OKMD4Gg==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="52240808"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="52240808"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 00:33:56 -0800
X-CSE-ConnectionGUID: ePypSCNYQrWiCoequ8s83g==
X-CSE-MsgGUID: ZSqqpGPZRKCoAQQ+Jkg4kQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,301,1732608000"; 
   d="scan'208";a="114960649"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 00:33:53 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Thu, 20 Feb 2025 00:33:52 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 20 Feb 2025 00:33:52 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 20 Feb 2025 00:33:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CHFqpOXcE/OnY2TgXBUWlcybCyuEX2c8GVtPdEPDZUnz0O+nG+O1RWjss1f/uKVD0i7hvHcpQE9Zfeqqr2kp3V6efRVPDN6Qs/m7yyFYEyz2rK6HCozJbk/TPCCAMSzsOFf2nBI69MzkdW7cgrtRXGxSJ3SHVE78+xUwkRQidDroUOwhdvjVLTDp9suokYi5y31+hOTXqbdZ5/prQ+DhAnjQPtyymYjHiNxPfgBVgO04/rEwHNXTZ+cDv5F6z5dUjT2we1ns+asKaD3IW1JwD2I/sF8bURIlUuc2zclEqtfy6uM7Gg4Ln/Ho0G0y2RA00Uj2ePB16dh0P1UoM9UPBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fYS2rM8n6YbBT4GgXzcMjmC07znQr05Lj6dbIM8z+5M=;
 b=wXFJfKO7eVTsEo9vs8JU8J3qSW81Mk6388GBwz/yAAIPRqJh47Vjjv3xlQkq4emmiSpQsMPD31Zfn/euk5W8LusSgB/r59Y/mNWRMMiSE55ethkloL2BgLbtzvmHgthLUrD6LkeY1ccVL2lMsFLlnTp/3RBM+SMHj7sePL+VIrO6j9TVv1piPCFYwrH9DQa3wI9F8ensWBTXxR0/5SmG4iQyccRVAv2oo+Cm1gy9PYZVP7v0QY68kM2QoLMqmaNZhZLufYE6dK3n36jtTpStVSZkncles/Gct557rjZxmk8zJNySOyqooX0Z8kZ0TB/wXltNIHcVz5Vs1urSP5lcwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS0PR11MB7802.namprd11.prod.outlook.com (2603:10b6:8:de::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Thu, 20 Feb
 2025 08:33:45 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8466.016; Thu, 20 Feb 2025
 08:33:45 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
CC: "joro@8bytes.org" <joro@8bytes.org>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "nicolinc@nvidia.com"
	<nicolinc@nvidia.com>, "will@kernel.org" <will@kernel.org>
Subject: RE: [PATCH 5/5] iommu: Retire group->domain
Thread-Topic: [PATCH 5/5] iommu: Retire group->domain
Thread-Index: AQHbfRQtOApD9F76406wuRSB4Ydiy7NNf2aAgAC8CgCAAF7pAIAACugAgAD48wCAAEupQA==
Date: Thu, 20 Feb 2025 08:33:45 +0000
Message-ID: <BN9PR11MB5276E36F15C40E6BF643F3EA8CC42@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250212060540.261436-1-yi.l.liu@intel.com>
 <20250212060540.261436-6-yi.l.liu@intel.com>
 <20250218193909.GF4183890@nvidia.com>
 <1df9b532-1b42-40da-8499-503f53ba8998@intel.com>
 <7a6bd064-afec-4492-b703-f076c50d41b1@intel.com>
 <20250219131054.GL4183890@nvidia.com>
 <a72d2d49-a3e8-4da4-8a2a-355c0fc03df0@intel.com>
In-Reply-To: <a72d2d49-a3e8-4da4-8a2a-355c0fc03df0@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS0PR11MB7802:EE_
x-ms-office365-filtering-correlation-id: 3d2e777c-3609-46ee-e228-08dd51894a30
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?a01HMUIwdVRqM3Ywa1NDdWNLQXVVZnIwaENFLzVPTlVlWWpMcGQ2cFhRMVNU?=
 =?utf-8?B?a3dNdTZBd3V2Q2NuaFVLcnpYYXRSaEhraUErZUFRckRTREIyRUpDcGludUk3?=
 =?utf-8?B?ZHhZWW9YMUVIMitiYzhKNFZ4RWNkSXozaGZoVmsrTkM4aUd6alE0UStGYklj?=
 =?utf-8?B?RGtYenFnSUxVanFiamFNYlFSc245Q0cxbzNrcjQwZWlmM2hmVmUvQ0E2dGds?=
 =?utf-8?B?UUtScHVwckN5WFBQd0oyckpvYzFhaCsydUlsYWhLdHZnSEVBaFNudDJ2N0Rs?=
 =?utf-8?B?QTAwdXJrdG1LTXBaekhOM3Z4a1VVM2xhc2JHTXdKemdVU0JWMUxxaDFIRlVQ?=
 =?utf-8?B?MEJPVFlhQWVMTlZVd1J0NEQybldJaGJZcmFXdmxsdkU4MDVPOStRSGVYMjRy?=
 =?utf-8?B?RWNrVzVydEJMRTh4WjRVNlJCOTNRdGY5YndjMDNoTzZtWDFWa1NZTUw4Nzcv?=
 =?utf-8?B?ZXZmR0tMRWZwNWh0SDk3QVFxblZxNTlzRmFRS0xEdVZKamQ5L0lvMGJkMmZi?=
 =?utf-8?B?c2FtYUhSUStxem13c2F0a0FET0JnckxiSktTZkQrQ05LVmx1eGdYRVBWa0to?=
 =?utf-8?B?TnhNaW1xWUVlSit6VzNvUnFJQnNrdmx0Z2xqcGoxaWovL0JNYXZMRi9CUzJI?=
 =?utf-8?B?RzNpaFRHcjArbUVBckdHNnd0T2p4dFpDcms4VkJGZ29nL1hGZ01Ibmk3VHFl?=
 =?utf-8?B?YzYwdFlQblRuaDVBb3R2bThKU3BadGJyUWVibE9vT3JwQ0lnT0NvYmxFWnZs?=
 =?utf-8?B?WlN2Sm1nUFdkZnpFbHgyYUJzdmNtc3d4Q1BSZlJoSWxBU28rK3FwZ0lYQ1B1?=
 =?utf-8?B?VzY5Z0tqVGUxcGttQ1BNZHZaWVpLRWVJaGcvckVqdCtwaFBvWmJnd2xpVVEz?=
 =?utf-8?B?VWxSVDdydkU5dzJLWHNhOVVjdnpQNnBqWGFxczJxRVI4WUw1dUJMbFR1bjJQ?=
 =?utf-8?B?Mk1YalZMOUNYc0Zhd3BuSTlnb1dDaEMvaFU2QTZoZGlxUTBvamFLUExHcnJC?=
 =?utf-8?B?TnBoLy8vM3BhZjNiSjBaVk11VElJNVREb0cxOFZrY05TZUdHTTJCTHdvNlJB?=
 =?utf-8?B?STArdk51OWFRMGwyVXdTZmZlZktTeEdVcVpuVTRaT2owMUVZMk5FR3dnSjVq?=
 =?utf-8?B?VTI5clpoVU9jWXJpeXNnK1c0ckgzQXoxM0tQQzFTdzkzcWdOZVhRaG83N0Ju?=
 =?utf-8?B?QUpwb0wvYVh0SXFyYUJ0dS9NaklCMGlUS2dEbm91bnMrWWc0SXZxazlodExs?=
 =?utf-8?B?eG9iNThLV0lDUzZJUERaUTNBRW56QWM4amIwUkdGV1JhMXlVSWJyajgreFgr?=
 =?utf-8?B?OUJRVUJFa2ljd3hLVit6bUMvTG9RSlExVkFVeVdudDdIeTJBRjRENUlSRzM0?=
 =?utf-8?B?ZUFuM2RoOW1ONCtQSXErc1JxU2NmN2NxUEc3czlmOVJ5cGF4bE9obnVLNmxw?=
 =?utf-8?B?dkppMnlwSDhEbmlqSFY0SHh4K1c2QVR1Yi9tclFyT1BSbHhpWW9Gd1Y3RU9u?=
 =?utf-8?B?bExrYVlNZm1Nek9PL1ZycngraUdlMWl0dVlVbmJWZWJPK1FSendzdjdGWTY4?=
 =?utf-8?B?dW5CVXBUZzYwdzFkR3c2S3EzTm5UL2IrTUNJN3FzaEhyZytvRFRoMWhzbFRV?=
 =?utf-8?B?TWpRNUh5Nk1SMW53M2FzMHZJK2hib3R3SGlweEgwMUY3UDFkSVZDbGgvbE95?=
 =?utf-8?B?dWRxM2JhMVdmejZjM1VUUHlOVTZodURxekhxWVFxckpqVXE0ZFBRQWNkeEZs?=
 =?utf-8?B?ZWxEOEErdUFQbnNOdStrcnRRQjFNZncwSXU1ZkI5V21KWGdPWldNaUsyU29n?=
 =?utf-8?B?em9nWW5sWlBOWXlpYUJKbno3aDJ4d1R3REYxZ2xUOHhIRzl0M1owSzViS1Q5?=
 =?utf-8?B?TzdHWE9hSkRpMlRtaEpTM0ZpZFo1Ris5R3ZsSG53T1JYQmxDUHVhM1lzS1Vj?=
 =?utf-8?Q?qGidbjCn7l2zjLS0wP3gewX181Aad/PS?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VmoxQnV6RERlZEd3dzJzaFYzQzRPMHRDb3pmNkx0bzNIUzRScEhJR0RiZUMr?=
 =?utf-8?B?OHdyMlpoa2FreFhrWCs2alJiWTZwUWFIR0t4UTBGNUJKQVgvRFh4Q2ZHNFhG?=
 =?utf-8?B?MHU0dTFObUZrdE9PUUNyRmRQNFkyTko0a3VqMU1rVWxMQnRzemhRcW42WWtv?=
 =?utf-8?B?Qm1tSWUwOEtmRHhaVkpwdmVEVm5FZFRFUURjOUl6ZXkyT3o3aklyRGVpVFNz?=
 =?utf-8?B?cE5xMkErdTF6d0tuS0diNCsyTUozc1lqSHk0STlBdHpjdUNuQXJwZS9OUDNO?=
 =?utf-8?B?cDdURkVtRzB1OXQzS3c1UmtCNVJmd25iYW1tZXpXWkNTdlU0OG9EajBTQTgr?=
 =?utf-8?B?N0ExM24vaDg5VWE1ektPL3plRTE1c1JXUWRsRy9TRlM0WW5DcUphV2Jwd1pu?=
 =?utf-8?B?TGpWR3g4NFRmak9TeFpIUE9XK0RiUS9WMEJxeFJkdituYVIwUk5MaVBJWUlq?=
 =?utf-8?B?dTlibkVYNGFoVVQyYmhNdHF5TjdoRDJnQWltOERLak5hYzVJZlBrYTZqaEYz?=
 =?utf-8?B?aU5SWDRNVEMzbE9vcFBlTGlvK1A3dy9WOUcwQ05qbC9QR1BOc001eU9qY0JO?=
 =?utf-8?B?QWQ0encranZ2dkxWS1o1Y1cxQ3ZPRWUvRzl0YWRTRFZsa1d6R25ESmcxSkph?=
 =?utf-8?B?THJEV1hNM1R6Mk5FUDBOOE8wZTMxUFFMdHJaOEhhc1FWdGJnVEtPNUVEMlR1?=
 =?utf-8?B?OHhwbE8vQVJ3a0RMNE9QcDArYUJZUzY4RGJwaVZCTFdpN2V0cGdBejFpVkpD?=
 =?utf-8?B?M0o5NjNWMFdUNTNEK2xyQ2pUUWk4ZUNOZnlxNU9xVGtHTDZTb0N0c1VNVlB6?=
 =?utf-8?B?UDhhbHVrK21JdU12UVBLd1lNemppU2pQU2srMzRzcWgveUx3SHpOTXlyRHRL?=
 =?utf-8?B?bFprbFc5SUwzSnVyR211OEpoZStvRDRGVzBFaVRPb1BMenNkd3NycEV4ZGlC?=
 =?utf-8?B?eTM2eG5FMnkzOHYxRktIVDRJOWNRQ1NmVy93SjJISzltYm95bWZHaG9IS3hB?=
 =?utf-8?B?eG0xcVBFQlVKQUlERGFhQVdCV05EY0FpOWE3cTNuODVJV3JqZy9QQjVoTStN?=
 =?utf-8?B?OFVnKzBtZzdjU0pGM3lyV3RzOFRZelhsRklObVppQldtci9veUdGVlcxSElq?=
 =?utf-8?B?S3RUZWR4aWoyWGNLUERDa0ZIaTQ1NTVkZ1NIY3BpOXVCMEMwTWdsdnRvZDdn?=
 =?utf-8?B?OVIwMzhlRFdpKytEMTNLL0w1ZHdvK3BhTERvOXozTGR6cjNxWVM2aHVxWkEr?=
 =?utf-8?B?NVJUeXRoRTdYOG5veUcvNUNyU3lvQlJHZk9hVWd0ODBUY2dYN3ZnQUZSU0oz?=
 =?utf-8?B?akk3QlhLVkxUcGk2VzRGN001SGRjR0IrZXVQamtlQmZsWlk1VWYvTU5MNkZi?=
 =?utf-8?B?ZkJHTnZpdDh2Wmx5MTFRMHUybDVrNC9CVEhnTWpvWDZRTE1ZVlNyeU5wOXg0?=
 =?utf-8?B?UzUxVGdjWEdDUi9mZ0JLSTdGWU5SUWM5Zzk2d2h2MjQwb3BiS1Rsc1p6Rm84?=
 =?utf-8?B?ekVuK3NUbDliVE81NDYySmRMQkgwRG1RUkM0R1M5SzZYMzZMZThVYkFOek1S?=
 =?utf-8?B?UWVXKy9Gcmd1ckxlV3pZaldpblNPNjIyUlhsemtIRTJGVFFXY2UrWTJtSHZw?=
 =?utf-8?B?amRUc3dYMWY2M1R3VEdJcmpnZ3UvK1BHVEFucGpWd3U1MVJpNXVZRFRtWWM1?=
 =?utf-8?B?ZksxSXJyVkE3L3o2OXErVml5cXcxeHluQmgzVGFYZ2kvbS9SNmFNek1ka0pw?=
 =?utf-8?B?bHRJc2NQQ3FnakRTV0FIakdQbkcrSDhyZ01XS0Z1dW4rNklDR1l0ZTJUdVcz?=
 =?utf-8?B?SFRBS2FGUEg2UnNYL0traHVDZDVtdnJFR0FIczZtbmFKMEZ2K0dqa0JMRjVu?=
 =?utf-8?B?RXZrUUFjc0dSNGpPbmtIelNCOVJSOG10am0rcjlndi9wblM4THZCa2dDSEUv?=
 =?utf-8?B?cEtTdVZmMDRrdHVuSTlhSXNXaHpBT01ESm5Ddmpia0ErMXV5VlI4S2VPOWRD?=
 =?utf-8?B?ckN6Y0NOUUc2R29icVFtQWVnVkFxOENYTEw0Q1pJdndqckdWNk5teDMvRHM5?=
 =?utf-8?B?VGh2UDVXVmE5QTBoV1g4RUljcTAyNnJPTHpWalgxUFRpdFNNQ29ldTJFdHFt?=
 =?utf-8?Q?xn41lQ1faCqza9MwM6CZaZtIw?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d2e777c-3609-46ee-e228-08dd51894a30
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2025 08:33:45.3449
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 68b1WFPXVlu8abchdTQFK2Y8jr1RdOMNVZrWwzeJ+bNT4MtVDfoMWbBeg85JTy9Cb+oGrNMXisoC84XLEo8FMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7802
X-OriginatorOrg: intel.com

PiBGcm9tOiBMaXUsIFlpIEwgPHlpLmwubGl1QGludGVsLmNvbT4NCj4gU2VudDogVGh1cnNkYXks
IEZlYnJ1YXJ5IDIwLCAyMDI1IDEyOjAyIFBNDQo+IA0KPiBPbiAyMDI1LzIvMTkgMjE6MTAsIEph
c29uIEd1bnRob3JwZSB3cm90ZToNCj4gPiBPbiBXZWQsIEZlYiAxOSwgMjAyNSBhdCAwODozMTo1
MlBNICswODAwLCBZaSBMaXUgd3JvdGU6DQo+ID4+Pj4gQW5kIHRoZW4gaW9tbXVfZ2V0X2RvbWFp
bl9mb3JfZGV2KCkgd2hpY2ggZXhwbGFpbnMgaXQgaXMgYW4gb2xkZXINCj4gPj4+PiBmdW5jdGlv
biB0aGF0IGRlcGVuZHMgb24gdGhlIGNhbGxlciBzb21laG93IGVuc3VyaW5nIHRoYXQgdGhlDQo+
IGF0dGFjaGVkDQo+ID4+Pj4gZG9tYWluIGNhbm5vdCBjaGFuZ2UuIElkZWFsbHkgd2Ugd291bGQg
c29tZWRheSB0cnkgdG8gcmVtb3ZlIGNhbGxzDQo+IHRvDQo+ID4+Pj4gaW9tbXVfZ2V0X2RvbWFp
bl9mb3JfZGV2KCkuLg0KPiA+Pg0KPiA+PiBjdXJyZW50bHksIHRoZSBwYXRocyBob2xkIGdyb3Vw
LT5tdXRleCBhcmUgbW9zdGx5IGluIHRoZSBpb21tdSBkcml2ZXJzLg0KPiA+PiBTbyB3aGF0IHdl
IG1heSBkbyBpcyB1cGRhdGluZyB0aGUgaW9tbXUgZHJpdmVycyB0byB1c2UgYSB2ZXJzaW9uIHRo
YXQNCj4gPj4gaGFzIGxvY2tkZXAuIFdoaWxlIG90aGVyIGNhbGxlcnMga2VlcCB1c2luZyB0aGUN
Cj4gaW9tbXVfZ2V0X2RvbWFpbl9mb3JfZGV2KCkuDQo+ID4NCj4gPiBIb25lc3RseSBJIHdvdWxk
IHByZWZlciB0byBwYXNzIHRoZSBvbGQgZG9tYWluIGluIGFzIGEgZnVuY3Rpb24gYXJndW1lbnQN
Cj4gdG8NCj4gPiBhdHRhY2ggYW5kIHJlbW92ZSB0aGUgY2FsbHMgZW50aXJlbHkuDQo+IA0KPiBo
bW1tLiBJIG1heSBkcm9wIHRoZSByZXRpcmUgZ3JvdXAtPmRvbWFpbiBmcm9tIHRoaXMgc2VyaWVz
IHRvIGF2b2lkDQo+IGJsb2NraW5nIHRoZSBpb21tdWZkIHBhc2lkIHNlcmllcy4NCj4gDQoNClRo
aXMga2luZCBvZiBtYWtlcyBzZW5zZSB0byBtZS4NCg==
