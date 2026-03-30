Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAE131F992
	for <iommu@lists.linux.dev>; Mon, 30 Mar 2026 02:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774836305; cv=fail; b=GJfSG2o4hLWmv9lGBGSOWWPPsfS9u0FPZVUoOQ6wlg+NSmb4V9FM25RZNusxrf4h2tU3LpjB614vg9JdD+j81iq2CBEFgs+hIGHe8rlB25FPwtqGyZKDTtZOHq+Aok4D7CVGfkV3E+vQR+3yjQCeZ5n7k75UR3vnpt8kRJTQGg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774836305; c=relaxed/simple;
	bh=LYn+SHSLPV6u0ohYMJaggNZj3A/loDem8jwnn8X7WmI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GkINkqd1kERZKoFTM31DT4YlU3g1ZpEspSsY1DA80joG4tbF2DBsiQPHfXjDsTcSeonAEdETiagzWYM06vd4YMP5c2CviZhXv4WONFyEtL5g/oJIP68zV7KnPANQzS3lLlJ5Ot5QgySY6SItMw8QM84ZAv2yh9ME7b0UXSYl4Ik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LU8bPmJK; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LU8bPmJK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774836302; x=1806372302;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LYn+SHSLPV6u0ohYMJaggNZj3A/loDem8jwnn8X7WmI=;
  b=LU8bPmJKwvQ9Dg4BgpFaUVrnrbYN9DzK/QLGPbNfQKQyuVfG00pOQCEm
   FeRYg8fNM/kD+/v8cSWhjHqe3l2KfumWuOLtyijj702qGhgMVfNUWVon8
   IzJBFSh1egrFWnc6UG2OMhbhJ/Yv3i48MoAk9kVJN90l/mZY9YObGFNyz
   kzSBNWioy2PdeEOj3K5r/goLIwmKgtvkpgopTgUQUqplm0ILMFLApmA0K
   LjOHeFhfOb8GAs5N1zEg4lvAsxfJ6QnEl17JMtsxAS3kEj4tmqj9cDRoN
   s72BR4DspSUbBeGjqlcj69lq4X+q2A7wPxaRdZfeNy2ct8qylw/XKuqNP
   g==;
X-CSE-ConnectionGUID: H6i397PdT761jSNQpP+fNQ==
X-CSE-MsgGUID: JbKscmZnQSS/FkO23IO0Og==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="75935495"
X-IronPort-AV: E=Sophos;i="6.23,148,1770624000"; 
   d="scan'208";a="75935495"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2026 19:05:02 -0700
X-CSE-ConnectionGUID: nnI+llkQRfyZISNqNu5cXQ==
X-CSE-MsgGUID: zN2nHioVQOCjocIUCyAIFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,148,1770624000"; 
   d="scan'208";a="249111815"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2026 19:05:01 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 29 Mar 2026 19:05:01 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 29 Mar 2026 19:05:01 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.0) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 29 Mar 2026 19:05:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cxtJJUQC+pHbVw+L1UpnJfm7q2uiOAmgggq0zqnAJ06WqRLK2pNDFwTXZBs/T5hpJkATlI0zJBYHoGkREeXnY68O7lsW2mbuLOVwVscuP5KciI2wDieyn52j4jJ/NKPEdYylYFMaqMdGU6BqbpSrMTimi3Fd4F9m/zG5c+6C+kfyVKf46/QO6PPwQwuVo3vHoXWq/KwVZnD09vlc985niYsXl9zOnS4g9TxB9AbDWvXJPVl0oofFgvSASlgBNclmI6hbSDE5ss6g65ai6BnM7oRfI5v25Hw7MElkncfEimUUb14/V3hhUSvex8ZIH8l0ykle3ZP5wvyZt5r7M1uQ3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LYn+SHSLPV6u0ohYMJaggNZj3A/loDem8jwnn8X7WmI=;
 b=NxvANbocIzym4FGm46yeY6DmrEV75aEC7bmRdv8DN1IS5gY3Li29VUOJ05y9dJGla70a0VHQlXSPwa1M1hUcE5MUN2Sv0rSuh+J6FjLyw4gFD+LG4bd/fxZQTjkPSiTB8SLzMUKpoSct4F8SMKexdCHRjyppBM8afG4I7xCLd0HREcdtb6JuO6TWs/O3Jstv6l6YbZuj6lwPwuHgx18npOd+6yOnUco4PwlGjZKnwOAwvGMBWhy/SApUhV7LQqrkpWuKFl/dQQfNY5Y25q7je8XCOLXvuENbl2vkWnP8zF3tL/FaAHbr6wDSym6LJ8edj3nozDMVXHN2fcJ7cNgBvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by SJ0PR11MB6767.namprd11.prod.outlook.com (2603:10b6:a03:47e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 02:04:57 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.20.9769.011; Mon, 30 Mar 2026
 02:04:52 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, Baolu Lu <baolu.lu@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
CC: Jason Gunthorpe <jgg@ziepe.ca>, "dwmw2@infradead.org"
	<dwmw2@infradead.org>, "joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org"
	<will@kernel.org>, "robin.murphy@arm.com" <robin.murphy@arm.com>, "Tian,
 Kevin" <kevin.tian@intel.com>
Subject: RE: [PATCH 0/3] iommupt/vtd: Support dirty tracking on PASID
Thread-Topic: [PATCH 0/3] iommupt/vtd: Support dirty tracking on PASID
Thread-Index: AQHclkfxNsmY1XUSU0OoVQI0Ea3M6rV01qSAgEbK54CAABLAgIAFPO2AgAWz8dA=
Date: Mon, 30 Mar 2026 02:04:51 +0000
Message-ID: <IA3PR11MB9136EBB1956F4AD9AB27A2C99252A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260205023405.41583-1-zhenzhong.duan@intel.com>
 <20260206004325.GB943673@ziepe.ca>
 <IA3PR11MB91365DCBEAF527F9D5D1EF22924BA@IA3PR11MB9136.namprd11.prod.outlook.com>
 <9df42fd2-8a27-42be-b827-59d7308dc910@linux.intel.com>
 <dda82f56-c39d-448a-b460-c118ff5750da@intel.com>
In-Reply-To: <dda82f56-c39d-448a-b460-c118ff5750da@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|SJ0PR11MB6767:EE_
x-ms-office365-filtering-correlation-id: 86e4a5a6-a6c2-486b-0c32-08de8e00bae1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: PD4kUmkSh9drNUDmmqUiIu4AFo1jWqT9mbHFiU98567J+eu229XHi2F2xdbRzLk4fCoIWRHOPT8eLcwtMvcOjRioSpl5T0v6x2T+zge+vk/tHeU20YUTle1/WtMtxQY6aiYEWZA7nAGq/+WWz5qhuX/kumVlW9FuS1jkC9thEh9TrzudvOb5lULUDsuVgZpBL+FYXZZ1LcHhrBc0u63Ry1IGis+IixWKj6J5+DbSi6zEcnOIkTcZR+Vxs5VQ5uuqg9GAtRwHbqKZG9vXKT0DhyXsJJlzWOgwbLUcFJ0XHjn8C7utLF8YxRQxKcfujOxeXy921aowmygnandIoKXHxL+t/9jYacnE5L92T+i716OeW0EeEqDy40caeWoDlxFWfEwSosrofFklTZdFca20GwlTQrSLZ+ACW0alDYnLeux1fjya86eu+NZlMXl1fZR2IaLyQoWponXvIl7APvGb7VsCvfSBsQSTjJLG4bivhnvy7UhEI/M96T9q/UC+zVL8RArx0QBNx9Mrqh0O/SU1ZOwqTCEa+4en6qPHs7c/6g25og8s1W7TeOxunqqw27Scp0Jd4mIGLp63LfB5npaYCZoZwlreSFLmwNujG/6wv1r+BdGjl0HY8H/ucGcz0So9i7YzQYh1cxaF8TloJFSJg2SJ8cVYr/PyoXS7iLY+F4VqyZdg1FHet3WGFv4MBx7TkPy9JZGKeCipsaJKk3mNsNOFMey0g3R0WRhUdpLPakiHb0hT4QZ1Pu+NhDC39s2knzAclzyqyuTybZ5uToEf7zWbYE5O6HaOEgijs2W20Vw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB9136.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L1Q2dVY0OU9hY3RJZmxoZkM1ZzFBTTVENWVZbllrZVFLaTA5SE81S2U0QXg0?=
 =?utf-8?B?Ni95ZGpCbjh3aUI1ODNTRUR5Q2NMQnNENGVsT3I2NU9uV3JETS96NU56L2Rr?=
 =?utf-8?B?VFpKbGsxVEtveGp1V1hpN29tRUdiMFFjQjFCYXZnMGhSM3NiS2dJcVVZTWtw?=
 =?utf-8?B?VWs1dVBhVWt3RHVaYXJWN2dzdkhodW9nWVNnT1pmTVY5MXZXZDZkbVAvZmha?=
 =?utf-8?B?NzVYSWw0Uk0wM1FsWjJ3RlpFSWlFK1gvVi9JWnVsYlhNL2o0MzNDUTFFTWVP?=
 =?utf-8?B?WFp0eG5wdlQ0dzhYQkd6YXJBNUk0RmFoaDBOc0cxVUlBdmlMdHFXZjdUOWZV?=
 =?utf-8?B?ZjJ5MVZyRHFxZnBRTElJZklXTUdKYnhkVXRUdTBVUE1TVVFmZk9oUjNNYkVO?=
 =?utf-8?B?a0ZsYm1WRnpJZTV0WnZxR3NpVXo2MzlVRjE2bDNqMUw2bVdtTnBDNkZZbDlG?=
 =?utf-8?B?d1k2c2ltSDdoSG9xMGNZcGJ3TGhPU2JqS0kzR1lNeTdmd1RwQllzTHhwTjdY?=
 =?utf-8?B?eHJaSDd6emJ4YzBsSnlvd1FFeEZKUHBXVjdxWUQ2MmwyNTdBUTBabXpEbVJl?=
 =?utf-8?B?MXZpUjJyWmNVcTdLN0hKVHFJM3pIc2dRa1ZJRkRoUTQyUlRzWTJLYmtxY3hv?=
 =?utf-8?B?d1lCaGc4Q0xoWkpvNkZjbFdldVRTaVl0TDNScWNXZDNkQ2RFK3ZhWCtqLzFT?=
 =?utf-8?B?ZTBod1dKRlNQcEJ4c3hZQ1B2VGhsSjVnWENlc0Viekw1dnZNTVhweDBxNDVa?=
 =?utf-8?B?eFZjNmZYNUVvaXlDQ3N3RjUwTDQ1WjlKQktRRklMbXJ4RlNmSEIyVFlnSUQ5?=
 =?utf-8?B?Y0Q2K1NmZ2RocDBGTE1Dc3luazJ5cjlQWnd6LytZWk9ZVUIrMG5MTUxySkVS?=
 =?utf-8?B?OUlJOWxyMTFNdzBEQWtHTVVzdk1RMkVOaFJvMW5maWEyMXB0ckU5WUNtSFY1?=
 =?utf-8?B?NXk1MC9jd2JQdmJ2UWF0TmNtVk5RV0VjOEU2dWFaOUxCQ0xVQVFoZFI4T2FL?=
 =?utf-8?B?UzRXcVZKeFNxTkswU2FMWFYzamRmRVIwUWxtQUxCQlViYThCL0V5UkVGeHJo?=
 =?utf-8?B?WUpUNC9RMWdOTkJWYWpQWGFkNGNSZWFTalA2YnBqNDI1THIxQ2dIR2hTdHF4?=
 =?utf-8?B?SDZWU0ZTUUVWMnpablBMUmJDUCtpVTIxSjh3VzRkdStFUElQYW1iWE9kMDhy?=
 =?utf-8?B?cDJTRVBOZ1orZlBUSWZkRjBaTXpDckxiUlFXaFcrWGFIeFJYMk0ySmU3UnhV?=
 =?utf-8?B?eklJSkN1Y2tlbytFRXBEbnc3cUprWlVSMExqSUl2TjZFKzJvNHBzY09QdkJQ?=
 =?utf-8?B?KzBpc0FIOWgrK1JQSVRUaE1HNFEzWTN3OUJwVnlhNUNqd3hHdExMQ213dU0w?=
 =?utf-8?B?aDZ0aFBybHpZQ0JSaHR1TzdaajI4bFk3RFFveEhVSHVSaGVQSEl3VmUwREox?=
 =?utf-8?B?eW9NS0ZOZTIyOXU3RjF6cDErbVZZb0dtV016OHZuQjZtOWpVTHRCZnpISlk3?=
 =?utf-8?B?QzZiUlBNUWJQallKL0R5bHNTc1VYbTJSQ1AyOWRiRWxGU2VpdjJHbDJsUFVO?=
 =?utf-8?B?djI1ZjQrbDZSanFHVU0wTUlBVlN1UUZLWlAvdDlOUWlqUFBCcUNycVdxdFpB?=
 =?utf-8?B?SXNFRHgwanIra2d2WGRNbGZaSXcyZFI0emlDRXZIeHoyRG1CTklMUXNmeGts?=
 =?utf-8?B?WDY3NWVRcWpBSGE0RWQ3QWJwZ2tvUkVucHBsaWUrY0lYR1hCTUJYVzBuY3hv?=
 =?utf-8?B?UVJLalBjamxBUVk3dGV6c1JwZWFxckVHd2d5dEhUS1o4Mk1BdXpPN056Sktp?=
 =?utf-8?B?dVJzemYwQW1ucHEycitmOVB4NWN3cjZjbFVrTkpmSFdEUm5WdkFZTUFTdXNN?=
 =?utf-8?B?eGpXRzd2TTNoMUx1SFlRZS9hWmdOTVRLVEZhcWtBMWN2RUd4dWJ1dndtdGZa?=
 =?utf-8?B?WTQxMHhXak4weFlmZWM3V0pFemVqamtTUEhkeCtjb3huUEJONE9nc0R4SXp5?=
 =?utf-8?B?UnVxWmgra2N0VHZZZlEybEM1TTB4QkdVaXljcXo3czVRWXY2Z25FdjJ4Vk45?=
 =?utf-8?B?bzk5NnNBRzd1eHBNUzl2M1B2Y29pWnNueW84ViswOG1IcEhmNnNjS0tLMTV3?=
 =?utf-8?B?bVdrZm1hb2V3dUxqcVJLZzgyU05YSHNxQ2xENk5ZOGJUMFFNWWRoK2xDbER1?=
 =?utf-8?B?bS9ndCswV3RuaHkxNHJhZGo5UTIyU2dhZXJabC9vdG8zRW5naTJQOVlRRVhW?=
 =?utf-8?B?TjNTM2tRTXJlMzc3bk5HZDN4bFN3U0NISGI0aXlIYTQ5TVFVTXZIY3NNak1j?=
 =?utf-8?B?Z1JqQUFUNXVHYTdhcGVSZGpnTm5qME9SVzh5eVVMeWJWUmlBcVpSdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: v0XNQSi4ygkMAWLyPvmqdFUC+fR1Wa9a4zD94dQo062+210hoDvJx/Y8UKk/9yBbTU3Ku1EdgqJngIx9nXcQEKXTSEzl3aA5v7b9zReweTYJCQMa4nTsVl+wuN3bVKsNZCsyb+hqRvcO00cW/Q0qa0i02vp/QKV0oa5newSfykQh1yBkXiZ4/xy1Hx79RAycBCQqoEwC4waoLWs36Sef6najr/KpvRzlrWznRMp/6moUiRv03WNtDUpE/WK4+G853SO6y0v+Dxdl9kEzNZY8kHTO2bodX/nq1GcYYfWgfHYlumDI4ClYgi3pXDF8iqZqD3x7sMXF+beqySWv8mutAQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86e4a5a6-a6c2-486b-0c32-08de8e00bae1
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2026 02:04:51.9192
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KUy+1xybc0sdlYjMo8OufDIyDv2hy1iQBOePgWKZreiu8WbwvTC+s4j613sKeQD7tsl6+BuRvSfo2pQgf1KuKQfZsQoTVVBhuPRJuvGNaXE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6767
X-OriginatorOrg: intel.com

SGkgQmFvbHUsDQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IExpdSwgWWkg
TCA8eWkubC5saXVAaW50ZWwuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggMC8zXSBpb21tdXB0
L3Z0ZDogU3VwcG9ydCBkaXJ0eSB0cmFja2luZyBvbiBQQVNJRA0KPg0KPkhpIEJhb2x1LA0KPg0K
Pk9uIDMvMjMvMjYgMTA6NTQsIEJhb2x1IEx1IHdyb3RlOg0KPj4gT24gMy8yMy8yNiAwOTo1MSwg
RHVhbiwgWmhlbnpob25nIHdyb3RlOg0KPj4+IEhpLA0KPj4+DQo+Pj4gS2luZGx5IHBpbmcsIGFu
eSBjb21tZW50cz8NCj4+DQo+PiBUaGlzIHNlcmllcyBsb29rcyBmaW5lIHRvIG1lLiBJIHdpbGwg
cXVldWUgaXQgKHdpdGggdGhlIHR5cG8gaW4gdGhlDQo+PiBzdWJqZWN0IGZpeGVkKSBmb3IgaW9t
bXUvbmV4dCBpZiBubyBmdXJ0aGVyIGNvbmNlcm5zLiBUaGFua3MhDQo+VGhlIHNlcmllcyBhbHNv
IGxvb2tzIGdvb2QgdG8gbWUgd2l0aCBvbmUgbW9yZSBuaXQgYmVzaWRlcyB0aGUgdHlwbyBpbg0K
PnRoZSBzdWJqZWN0cy4NCj4NCj5JIHRoaW5rIGl0J3MgYmV0dGVyIHRvIG5hbWUgZGV2aWNlX3Nl
dF9kaXJ0eV90cmFja2luZygpIHRvIGJlDQo+ZG9tYWluX3NldF9kaXJ0eV90cmFja2luZygpIGlu
IHBhdGNoIDAxLg0KDQpNYXkgSSBhc2sgeW91ciBwcmVmZXJlbmNlIHNvIEkgY291bGQgaGF2ZSBp
dCBpbiBuZXh0IHJlc3BpbiwgZGV2aWNlX3NldF9kaXJ0eV90cmFja2luZyB2cyBkb21haW5fc2V0
X2RpcnR5X3RyYWNraW5nPw0KDQpUaGFua3MNClpoZW56aG9uZw0KDQo+DQo+RmVlbCBmcmVlIHRv
IGFkZDoNCj4NCj5SZXZpZXdlZC1ieTogWWkgTGl1IDx5aS5sLmxpdUBpbnRlbC5jb20+DQo+DQo+
UmVnYXJkcywNCj5ZaSBMaXUNCg==
