Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E60F53364
	for <iommu@lists.linux.dev>; Wed, 26 Jun 2024 02:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719369363; cv=fail; b=T3DGg1FKhj+wpaisuueuxPQql5i8l0gUPjUbAqeZwopFxgdvBvQZ5lcTXIbWZlQzuG7BejL/I+sUqH/ZG5o5JRzbgz8L3veVPBBxn36RlpJ4GQ6xRni57eKrvQdITIFuuePr2yK+AxszTxqbbafRhxlHfMtiTlW39PjMRUCWaZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719369363; c=relaxed/simple;
	bh=OoBz1RBXYHDGV849UOGhKpkp88vGoDSsMdB9CZ8nEC4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hF9b616FvBsjk48Ki+t33By2MJvXnYfzftanpyBcjxypp2WdOatYZp+2W/IitOlOk3goWSDdnRilJ2nUmZYMz1rjsAQ713HFRdEsaTz/c8816DaR1WKqpllkAWRHXxuO7fXxHKXKmhUupkW9FGuW/e7c/b9x7+FU+Ky9R8K8/vQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=az1XMElZ; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="az1XMElZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719369361; x=1750905361;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OoBz1RBXYHDGV849UOGhKpkp88vGoDSsMdB9CZ8nEC4=;
  b=az1XMElZUmXc1BVIn0CkKpNfg43f70vmq23IdKvQQ6pSPSu/SY3p9aro
   nmE3pXGUKLpx1V+jEJ/i4OG5yDDmV9wq1EfuN2ccTS9W2PC0Rg5eV0IuI
   JWRzWFnAEAtFDn1obPNZcxvdd6MW+w1VYSXHkqel1yzmHQL6sLp55HzdM
   2kKvyzMWfpfyARRtEHwvXAlGJmSlxq1UQLsrAkuo6shQWHvUomblg3N2a
   W4FNxXtdezB/DsmNFtsgjhwlW6I2450/85pcXqUGHNUIcX25ix1Q9CHYi
   QXGa+C898kUmVySJ68B3C8XPtEn0otlhev6Vgc0nJki3V8KSMSzDumwvz
   g==;
X-CSE-ConnectionGUID: K+CBrGEqTHCMmlOiXNVdtQ==
X-CSE-MsgGUID: fXMIEY1OQtS3DWZRmrXFKA==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="16247119"
X-IronPort-AV: E=Sophos;i="6.08,265,1712646000"; 
   d="scan'208";a="16247119"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 19:36:00 -0700
X-CSE-ConnectionGUID: HeA4lggpS+CJs78Jlwasdw==
X-CSE-MsgGUID: 0NFiUqAtRtWwQpimuDQFew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,265,1712646000"; 
   d="scan'208";a="44281122"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Jun 2024 19:35:59 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 25 Jun 2024 19:35:58 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 25 Jun 2024 19:35:57 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 25 Jun 2024 19:35:57 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 25 Jun 2024 19:35:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UWfQ3ExDzFBRL+imP30k1WpEUNYADvWm9DxBAc8T+lr8VX+nK1y/AYyvPcDdZl/2AYztHJxpcUd9Clv9hat/apYu44F52DcYIxnTo2ibhRWe/XF8zc6Ic6mw0Ove3/97mtYEHEcgBIAAJ8mQCvsWWTtATqJZ48dsfwDSrg3XvSWzL7Mz0HJkEph6I9IrRyvVdqYRsr+fue5CTxbVAfbxIh4ZMnfbb4voCqCumnWwjKJhM6dO05fa8LtjH8WiNu/O+V9wzcWAGoj9EwLMY1BWqJmRC8Xl2WQ7TIY8yvQMkZZFUEb/zdKc34qt3KiNF6JEqwOmyqPmqAXTgaHFn+Ndvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OoBz1RBXYHDGV849UOGhKpkp88vGoDSsMdB9CZ8nEC4=;
 b=RvslSks5ZUn5B4HzEtnUytK9s2q9kTwn8mcNB73kYZsGFdAChFUPfyad1Advj8wLK4L9Inlij0YaM6Tmb86MPTOxsAg5PcN+axgC4hGRUZUL4bdT3CQ36cxQddyVzhRVRCU2gHSkzuAYQCRZOFpKpb4bXohAULFej+/xpYG3vDOGZ1Thp6b/Tx0vJGwBKRLwiG2dAmi+FDxKh6CUGr/JSrv1KbfCmeUdpI4/mqWTyxcsKt1cUF8G+bTq++FdH6m1eDcAa160kCfcNBpquQN7eWSqAA6lsnc1JU8uOqaZLGzc05n/iL9iwWTD464U9jlJki2uyptPKM4ee8eNQfaVZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA2PR11MB5083.namprd11.prod.outlook.com (2603:10b6:806:11b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 02:35:55 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 02:35:55 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Joao Martins <joao.m.martins@oracle.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>
CC: Jason Gunthorpe <jgg@nvidia.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Lu Baolu <baolu.lu@linux.intel.com>, "Avihai
 Horon" <avihaih@nvidia.com>, Alex Williamson <alex.williamson@redhat.com>,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: RE: [PATCH v1 04/10] iommufd/selftest: Do not record head iova to
 better match iommu drivers
Thread-Topic: [PATCH v1 04/10] iommufd/selftest: Do not record head iova to
 better match iommu drivers
Thread-Index: AQHaxAr2EmzDYwL66k2Pz1VycpxiSbHX2PvwgAB/qwCAAQI2UA==
Date: Wed, 26 Jun 2024 02:35:55 +0000
Message-ID: <BN9PR11MB52762BE81C4A4E22A916E1658CD62@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240621184254.45477-1-joao.m.martins@oracle.com>
 <20240621184254.45477-5-joao.m.martins@oracle.com>
 <BN9PR11MB5276AB80727CF5521D5F20768CD52@BN9PR11MB5276.namprd11.prod.outlook.com>
 <2d52d4ed-c585-466f-b428-c7ec24713f7d@oracle.com>
In-Reply-To: <2d52d4ed-c585-466f-b428-c7ec24713f7d@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA2PR11MB5083:EE_
x-ms-office365-filtering-correlation-id: 277a9d74-8135-4156-8dec-08dc9588b45d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230038|366014|376012|1800799022|38070700016;
x-microsoft-antispam-message-info: =?utf-8?B?dFZZY2ZSOU1LL09MWjN2OGJidm1CMDNpSy9iMkp1WDFqUisvNEszaUNxUzhW?=
 =?utf-8?B?NW1QZ2Fmd0hMWlFNZ1FqbnU0UHNqaFI1bXhGWkZMcXRQcnlCb2lvNm9MTmdw?=
 =?utf-8?B?M3NvcVg0MkdKSW8xNWhJZ2hqZHVoeWdMWGZENTJobDI4Q3RiNHN3TitTZHlh?=
 =?utf-8?B?VGhjci9QSTNZeTZONFdXOGF3cjBaL045cFdnYkMvU2pBRVdwcEpCb3N3WGFy?=
 =?utf-8?B?aHZzVlAyQ2t0aWtKUTlISFU4SmdKNEE2VG1icGREQWIyRUMrY20xR0p0NU85?=
 =?utf-8?B?Q1ZVcTFnbFdsZUxsNW9jS25rNEc3MmRqbXhMc2RTUFVTamFyVlhyMTNoYmcr?=
 =?utf-8?B?SzZCek5RWktSaEhqY2F3aWZjSTFJaGdvbHdaRU16L1l5aStFNFVaSEtrdGtn?=
 =?utf-8?B?MHZmaWNONG40dU14Yjd5S1AzUFJCbG9CMHRpTXFaNXFDMHVDTEVFSGpJYVpi?=
 =?utf-8?B?UXF2UGdTd2pkMUNOdlhicUwxaEt4MGVZbms5OWdJK0VURHJaN3BuQzQ2Tklv?=
 =?utf-8?B?enFYL2U3bzhmOVpROCtHeFY1Z2Y5c2picFhwb0RwSFB3OVFwQTh0eFVOL051?=
 =?utf-8?B?T2VKSHNlbHpScmlBdkhkYUFpZ3Bmak9FMmF2cklGeXF3Y1J1amdwaCtkYlda?=
 =?utf-8?B?Sm1qYlQyZFhCRUMzanBrbllpWmU4c3JWVzJsNTVOMlZkbTk3YVNNQ0NJTXlL?=
 =?utf-8?B?WnNRM1lZYXZIWm5wcUpQV1dhQTVSc3lLcStMSU5rZ0J0RmJlN24yWTU0SWlL?=
 =?utf-8?B?MCtqTnMydlNka1VxS3lLeFp1dm8yS1JGbVRGTlBBeFc3bkdNc2F0T3B3MFRX?=
 =?utf-8?B?MklNalFQYk1ZelU2THJnQUE1c0xYN2ZJckhESzBqL3BYM1V1d1hTY3B5TzVW?=
 =?utf-8?B?djBzUmFNN3oxZkk0aDU2ZTgyRXJFRkJkNk16eTRUdE5Pb043QnN3UnNjWmJ5?=
 =?utf-8?B?RU96RWR6VWVmd1AxbldhaGtvb2syTlVDZ2ZTTnZyNkFUdTlLRlBsTDNsUEUy?=
 =?utf-8?B?ZUx6dEZ4Zi93R3NISkhBTmJVN1F5dmlEMWQ5cGJia2VZSFpxWklISGZHR2xB?=
 =?utf-8?B?NmtRTWZCU3NpZEI5b21UaGtpRG9EYnl6eXV6QWlIRmFoaUlOb3lWZnd0Wncv?=
 =?utf-8?B?czFuWVNvRzRqbUo5ZllSUnYzSGVsTmY1NEJTaHFTbkVZVjdpaWxhRlgxWWE2?=
 =?utf-8?B?MDNPcW0rWWYrWnR5RTZ2UHlBZnJ1N0JHZTcyaERRUU9la2FoS01LeEZ2cUU5?=
 =?utf-8?B?L1pPVHZYMVBCTnI3c0dsdU5kSWM3MWVHZ1ZkR1Q3eFBscHRHekMwOE11MHhy?=
 =?utf-8?B?S0hVSGhOQVB1T04vblFJaFJXNmxsZXdVRkNsQWx6WmZpMjd3T2pIS2Q3b3Yw?=
 =?utf-8?B?YWwxR2k0K1lQYUhXbTlPeUZrSDJ5TXBpd285UWxJWVNLaXN5bzk0Nk9vMWFI?=
 =?utf-8?B?S1cwdURtOEx2QlN0RnprTFBNYSs4VENHemhUcURTaFYzdUM0bmFNTTlIY1NX?=
 =?utf-8?B?VHNVS0VHY1ZCR0toUjBZcG1BN3NLeDVqeWhMbG9WVTM3ZWNLVFE0clZtMklu?=
 =?utf-8?B?cFpMRnkyeEhzNnQ5TkNEd0dyM2tMWk1nOTQyZmxxUmFXeElyL3VXOXNrL0s0?=
 =?utf-8?B?YzNqbEpyK3ZWaVNHSmkzaWowRTB6cGZwSnNaUk9lT1YzZ2hTYWpDNFp5ck1O?=
 =?utf-8?B?QVVLZ1g4dWU0OTNEaVNraUJVS1RkanQzSnlRZWNuNm15TDhwcVlBNEFnTnRC?=
 =?utf-8?B?Y0grb3hWNUNnai84N29WbS9aT25uS1lhbEY4d1hPM1E3dmpUaUR4U0RHenFP?=
 =?utf-8?Q?b7iJXom6UxX5vMj484Ar13SBnuPaCs3mBD1Ew=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(376012)(1800799022)(38070700016);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UCs2YzYzOW9RTVVoWVlqWFhUbVFxMnZFc0dReGRuUEQrcnpyUW9pMzgrU0d3?=
 =?utf-8?B?N3JSb3F2MUh2d21obTF4T01NN3BtZ3pxbTNWNmEwRHU2M251U1ZGUTF5aDlZ?=
 =?utf-8?B?NUN3Sk13WndHVVJwVmNFc0lYekx4NkxWcXQxdWdtRXowaEU4aWVHdXhSRW1I?=
 =?utf-8?B?eG5HM0x1QjRjYis0dGZtQktsSndyd1ZrRm9vRmRmU0MvNlFDckJZRjAzY2xo?=
 =?utf-8?B?d2psb283QXBVRnJrVzJIcXVobHRvL0FJZEpXK0pTMWNtVlVkSjdHSlRxQTEv?=
 =?utf-8?B?RGN6Nm5pQWs3NEZRTldhTWJxRGRKVU11bHlNcVkwZ2M1akFVdmM4VWZTNWlG?=
 =?utf-8?B?TkJsWExKaDFvcUFlUkc5d0xsRVlMOGhNRktmb1NIZU1Dbkp2NmpOQS9zd0I0?=
 =?utf-8?B?eVU3T3FxUG9weCt2ZjRYd0NKRFg3M09qRGwvaDRwaTNIWlVvNHdGczVNcHpU?=
 =?utf-8?B?OW95cXYwRldtR015L3NrdlZaMWNUWlFZZGlFZFQ0bHFKWFRQR2ErMXA2KzRp?=
 =?utf-8?B?TUl2Q2d4TWhiZ1ZZZXBMVFZPa055UktySWVidmtjcWRjSWVvT05JVHFzREhx?=
 =?utf-8?B?UjlteTJ2cWI1TXNoaXVWa0dkNFYxNGZJK1FSU0VQaUZoZEtRQ2hqUTN3Ynh0?=
 =?utf-8?B?ZlFYNzhvd0Jsc1h2T1JSN1gwaW1GZ0NlTnhqUmNpdGhKV1RrSzhoTFZiQVps?=
 =?utf-8?B?YXFTL3V4V0RHR2U1Qmk2YVdwakMrY2h5M1NhNkhuVVNxa09JbUZRbkxvZExn?=
 =?utf-8?B?OHQxeHpCajFtVys0aE4wblBQNlVaR1FmSjFRdDhZQ05vWTBOUmQ3azg0RWJh?=
 =?utf-8?B?TFNrVDA1a1llTlZYNFAzTnkzRHUrYVVyTllhREp2TS9TZ1dsUVBIZ2xsalA1?=
 =?utf-8?B?YmZHR3RMRnU1Ty9mT3grZ1RPSUVIWkdTNS8reUY4Mklha3J3RVV0VWt1UThR?=
 =?utf-8?B?Rkh4a29nVTBtb0g4bDVzdjZHOUJZdmxUemRVN1FOSzB6Q2hQU3UreTBzOWZ5?=
 =?utf-8?B?akNURmNPRlBOL2hHenQ5akYycTdsVXZ5R29WVnliQ3QyTm5KRXg2QkVZSC9C?=
 =?utf-8?B?THp4ZGhERjVQWGZzZ0lsL1J5dEhRSDdvdkRjSUwzMnNNL3dWR0lZQlJLQnNL?=
 =?utf-8?B?Ulgyb0JHYjQ1bzM2OG5sWUpCUitaQXdiUCtGRFUvN2NibXZ1azYrd3V0OVdB?=
 =?utf-8?B?SlAvUllCdzlkTkZhZ25ReDFJSXR3REZ3bjhMcjFJOEtJNFJDT0VxQVFDaWhz?=
 =?utf-8?B?dXJYQjNGQUFxaDhkM3lSVlZmWE9VRlR3ZUpaNGxyWVhJUGE3QVZxbU05MExn?=
 =?utf-8?B?WHB5VzVTdDJIdWZiVzZqdzgrQjY0TUtJNWxQWUJ2UjVzelFvR25oOWJudnJN?=
 =?utf-8?B?QmtYWS9lVExranRxeG51d2t0WHh4MjJuZVVyQ0FBUURMOFJKNTgxdzhIbDFo?=
 =?utf-8?B?cmpnSzBGR2ZnOGJOZ3ZqVzF4T1BlZXg2S3R0dW8xVXVwWmd0NktIUmNMTzNG?=
 =?utf-8?B?SFR4NzBKTHFsQ3FuQndZSU03RWNSalUyWEtHV2xRcGlzVEt5ekZaU1ZnTm5I?=
 =?utf-8?B?SmdLMUFoYWtkalpQRTYyZEovaFJjREpNMmNacnRvamRtckk3anZ2Z0lXZ0x0?=
 =?utf-8?B?TTNWZnE3c1hzOGhpUzZ6Umd6VVBNUGJHYkJwSmxPcDIrWE1yY2ROTGRIN1pK?=
 =?utf-8?B?YXpkckEvTzUrdmlMZ2owakI5SXhNcExQTzdGTEplS3NBTTg2RWE0ZUxsYXVs?=
 =?utf-8?B?MU5LQm96NmYzZlVtbUQ0aGhLdkNiYVQzMm11UkZMUUZFRWphQkRiYTlQbStT?=
 =?utf-8?B?WEozVmpHa1pyZjNUMEZMZWwyRTR1TlhNL25OL0lDU1h4eFQxL3lZdk5vSXJa?=
 =?utf-8?B?V0QyUmh4TlgwZ3JyZTdWYkVoZHNndW5rT1YzNThoTEFMRG9BTW9nU1hzWE14?=
 =?utf-8?B?YjNJUUp4dUNvMllUbFNXNGpYcUNwZ2crenBDeUtGanIzcVRsdzMzQ2JaQmE1?=
 =?utf-8?B?YkpSQ2wrQzFRdFNmOFNqMi9pWVlaMVdnQUZEeTNpaGwwRkVFaW85bG8rZ3pm?=
 =?utf-8?B?YWpYeGh4dzFTNEduK2ZKaHk1K29LVEVOREdJMDhCN2FVWnJGbmszNTdEQWZ1?=
 =?utf-8?Q?FPb9ufc3c64diGPt9DgWh3FcH?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 277a9d74-8135-4156-8dec-08dc9588b45d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2024 02:35:55.3404
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dIUvDedt8LHyN1bDMA9ALCfqlqb0aH6u1fhOH1AdtwrxHqPApAYnaVYr9bwyQBQOyG4jqNn9qlcV37BBBfYaQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5083
X-OriginatorOrg: intel.com

PiBGcm9tOiBKb2FvIE1hcnRpbnMgPGpvYW8ubS5tYXJ0aW5zQG9yYWNsZS5jb20+DQo+IFNlbnQ6
IFR1ZXNkYXksIEp1bmUgMjUsIDIwMjQgNzoxMSBQTQ0KPiANCj4gT24gMjUvMDYvMjAyNCAwNDoz
NSwgVGlhbiwgS2V2aW4gd3JvdGU6DQo+ID4+IEZyb206IEpvYW8gTWFydGlucyA8am9hby5tLm1h
cnRpbnNAb3JhY2xlLmNvbT4NCj4gPj4gU2VudDogU2F0dXJkYXksIEp1bmUgMjIsIDIwMjQgMjo0
MyBBTQ0KPiA+Pg0KPiA+PiBEbyBub3Qgc2UgYSBodWdlcGFnZS1hbGlnbmVkIElPVkEgZm9yIGlu
Y3JlbWVudGluZyBhbiBJT1ZBLCB0byBiZXR0ZXINCj4gPg0KPiA+IHdoYXQgZG9lcyAnc2UnIG1l
YW4/DQo+ID4NCj4gTWVhbnQgYXMgJ3NldCcNCj4gDQo+ID4+IG1hdGNoDQo+ID4+IGN1cnJlbnQg
SU9NTVUgZHJpdmVyIGltcGxlbWVudGF0aW9ucy4gS2VlcCBpdCBmb3IgSU9QVEVzIHdoZXJlIGl0
IGNsZWFycw0KPiA+PiBhbGwgZGlydHkgYml0cyBmb3IgYSBodWdlcGFnZSBldmVuIGlmIGl0IGlz
IHN0YXJ0aW5nIGZyb20gYSBwYXJ0aWFsIHJhbmdlLg0KPiA+DQo+ID4gdGhlcmUgYXJlIHRocmVl
ICdpdCcgaW4gdGhpcyBzZW50ZW5jZS4gTm90IHN1cmUgdGhlIGV4YWN0IG9iamVjdCBiZWluZw0K
PiA+IHJlZmVycmVkIGVhY2guDQo+ID4NCj4gSSBoYXZlIHRoZSBiYWQgaGFiaXQgb2YgdXNpbmcg
J3dlJyB3aGVuIEkgbWVhbiB0aGUgaW1wZXJhdGl2ZSBmb3JtLCBzbw0KPiB1c3VhbGx5IEkNCj4g
c2VkIG1hbnVhbGx5IGVhY2ggd2UgdG8gJ2l0Jy4NCj4gDQo+ICdpdCcgaW4gdGhpcyBwYXJhZ3Jh
cGggYnJvYWRseSByZWZlcnMgdG8gdGhlIGxvZ2ljIG9mIHRoZSBtb2NrIHJlYWRfYW5kX2NsZWFy
KCkNCj4gaS5lLiByZXBocmFzaW5nIHdvdWxkIGJlLCBrZWVwIHRoZSBsb2dpYyBvZiBjbGVhcmlu
ZyBhbGwgSU9QVEUgRGlydHkgYml0cyBmb3IgYQ0KPiB3aGlsZSBodWdlcGFnZSwgZXZlbiBpZiB0
aGUgcmFuZ2UgYmVpbmcgZGlydGllZCBzdGFydHMgZnJvbSBwYXJ0IG9mIHRoZQ0KPiBodWdlcGFn
ZS4NCg0KdGhpcyBpcyBtdWNoIGVhc2llciB0byB1bmRlcnN0YW5kLiDwn5iKDQoNCj4gDQo+IFdl
bGwsIG5vdyB0aGF0IEkgc2FpZCBvdXQgbG91ZCBJIGd1ZXNzIHRoZSB0aGlyZCAnaXQnIHdhcyBh
IGJpdCBtaXNsZWFkaW5nIHdoZXJlDQo+IEkgc2hvdWxkIGhhdmUgdXNlZCAndGhlIElPVkEgcmFu
Z2UnLg0K
