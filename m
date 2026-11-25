Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.17
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795577557;
	b=MOxI2Perbn6m6o35hoTc9bQUhPfpjtfPmHsZ5qoUEKJ+U8kmtNpnylEtcVchSsa+2VO1
	 kXIBW0npLz1s8xkiM0ntGftzqu0lle3E8H9IIUp+7hugQGiES0623Sf3sTiNek14sE0Se
	 1T0/NyWZAHwxqrAHuyGzS0n6JwUCDRo7CdOknEb3cprfmXP8eFFbFHSb9Lybe9U4uqIqT
	 INbiB7hzmTd1P89jd47EEbL+i3bX4TDSVya9XSCvue9imSEOvJzcMWT1iJQ+bDWXwaexe
	 QkEFETsaIy5NVvqmYY+q/IimIE7EKe9/HzyZSXNS65tgqdrmWfmvC5sOnRj6hSXbICQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795577557;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=g+ixnvCGKwXCm6OkiBk1k9fN9wQTNHYXEKDn43euCY4=;
	b=nWSsoz4NJVb0n58ZYSBSGrVh3tkvnGFfkXAePgeBPY/yGi4VrcX999Dqm4ACArVMBSpg
	 VpGzHRrKs1DicxIRm/m7+vkPfqP7kLrR+8qa727mxxMtYvyd5ICJCQK4UqRiksbA4w2k8
	 6fvd9gJrwxYeYXW87uYGNmFFFQODC/1GvKCDbzdK1mVrkhGVutxkUNir7on2fTSDCZUul
	 xFBM67mrJzNvthWzNRheXxBr4z16BMk8OsMNxx37AEG5/wMW49wHaNdky4rAUT+ZGz9nB
	 w4u604demIONsUTUciuyAxMt7/v+cjQCnhBuyBoWfNNvNhNMyRHZsok8dSRWGi3E+bw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AbiUcZo4;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=RycFl1YL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A95606A326;
	Wed, 25 Nov 2026 03:32:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51A95606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AbiUcZo4;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=RycFl1YL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795577558; x=1827113558;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=g+ixnvCGKwXCm6OkiBk1k9fN9wQTNHYXEKDn43euCY4=;
  b=AbiUcZo4V/s6UgoRxUtrHCB2+btQOijaL4+WxUpN9G9ktgApO+o3MhqT
   vJAK4QIX0jn7tv7bgVmwcCeQ4xI4XD/bouNJNFLeTi4UPGE8OK8JIyeR6
   GX6XKUQ8KXv7zZrNEIhZUJm9pljQ/3D5lKkB8V34fLgLR92zRfmJfTA2A
   +CwKgu/wZd6Qx9JHqTLahCm78TDOQJgFqm835lpIu/Dd9yLD8iVCOdovl
   QdR07uzWriQu3VBtA89vXA4F8FnS5xIQFgcETipGV8tdN0j3vqOWISFQ9
   UP3nTLaw4HN/IPzqO6jjM2wacJorGDG9JV+s0ZCRJVQXOfrNSVsWl0Ah8
   g==;
X-CSE-ConnectionGUID: eBuLq5tyRT2SnRh958ycig==
X-CSE-MsgGUID: tjCEyBquTkaU5EFvxFFZXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4441462"
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="4441462"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 19:32:37 -0800
X-CSE-ConnectionGUID: GbMJe7DHR0mKTDz+tpsFUQ==
X-CSE-MsgGUID: S1jKT69hRnacfkJdMASDOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="13778176"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 19:32:36 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 19:32:35 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Tue, 24 Nov 2026 19:32:35 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.48)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 19:32:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L7BoAwQ5qC+3e/jyMvvmkuypiegBunMM7HCkXtQLj12w2AeAoMevaYuU4PzDB9RjH3ibKsk8bkvyx4r/gO/sN2U9l/iaCS/Y5WafzjHndwb/pKzRmFApah87YE7XRSbGtbULaFyCEu4QCUXEKmzzOPawq8VpW409cYG2R4YymAHEg45N5R5KkV68rbe6N/SF2WE9oA8iNki1pgbAFeLQ95NGGd3vKYvxAt0XiNbA1fzfx6p74Wa8DeIJp4oSE7RFYpFZOWPLGm0pv7WXDVc8cAxcRTQEBHS8X5JjwaBG9tQXiso8rlSmBMheTn6oUiCIzVqecrkcsASWR8mmFi0MWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g+ixnvCGKwXCm6OkiBk1k9fN9wQTNHYXEKDn43euCY4=;
 b=W+q8GArkdJkgUO38A/eKzz30ecMilL8hAQcZRLoNp7MNUrzgXUGp3elLJf9UILrJoooHgjnCksgy7hypW0U77jZKsKTEkSDZ70FQYvO5KNacOa0QlDYwgIK8WymIEW1uwQs3EMslV52I/HCqfAcSe7s96D2yGq5MOpGEZ67MizCPwoWd7jVebQqG6GQ3HcRVcJv+MkLqQwskRxgxj3StTFYtph4mKV0yfiItIztp16BKL+hi6Yj+Xf3t1uzdFi1tFxnM0HVMh2ePeYd5nmv6w6XKT9CPOI32rlNxi65E4g/RkeauI9Gq/j345XcQeSxDmgB4goBw4JhfpYpXYlUX6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g+ixnvCGKwXCm6OkiBk1k9fN9wQTNHYXEKDn43euCY4=;
 b=RycFl1YLgiXBY4x3/9iv//LEwYmyGGM1qBG5py+liXp1+X2g/OOy4sN5BGem4noAoV7rqEXUXzytS8IwVb8/eprisOjkInKB38o0qlsm3MZ1LbXUss8RXgVIG60k/9ecL/AVVIs8sQwWjioZibbZBPTvVnXHfpV6F9tdPelPnSc=
Received: from CO1PR11MB4835.namprd11.prod.outlook.com (2603:10b6:303:9e::22)
 by LV1PR11MB8817.namprd11.prod.outlook.com (2603:10b6:408:2b4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Wed, 25 Nov
 2026 03:32:33 +0000
Received: from CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225]) by CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225%6]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 03:32:33 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, Xu Yilun <yilun.xu@linux.intel.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>, "x86@kernel.org"
	<x86@kernel.org>, "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Kiryl Shutsemau <kas@kernel.org>, "Edgecombe, Rick P"
	<rick.p.edgecombe@intel.com>, "Li, Xiaoyao" <xiaoyao.li@intel.com>, "Gao,
 Chao" <chao.gao@intel.com>, Binbin Wu <binbin.wu@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 4/9] iommu/vt-d: Add interface for tdx-host when
 enabling trusted DMA
Thread-Topic: [PATCH v3 4/9] iommu/vt-d: Add interface for tdx-host when
 enabling trusted DMA
Thread-Index: AQHdcmB4VMJqqNYilEu6w0/Ho7paB7c71CgAgAEXIwCAAUrNEA==
Date: Wed, 25 Nov 2026 03:32:33 +0000
Message-ID: <CO1PR11MB48357A67BAC8849D342BA7EB8C432@CO1PR11MB4835.namprd11.prod.outlook.com>
References: <20261112043054.2664857-1-baolu.lu@linux.intel.com>
 <20261112043054.2664857-5-baolu.lu@linux.intel.com>
 <awRW3ESp3sBoxtJ9@yilunxu-OptiPlex-7050>
 <9ab1e5b7-fa03-473a-a251-91153fe5c7b3@linux.intel.com>
In-Reply-To: <9ab1e5b7-fa03-473a-a251-91153fe5c7b3@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4835:EE_|LV1PR11MB8817:EE_
x-ms-office365-filtering-correlation-id: c26b7e71-751f-420e-1214-08df4aa4bdf1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|6133799003|22082099003|18002099003|11063799006|56012099006|261022113327099003|261026121527099003|261028144727099003|261022075727099003|4143699003|261022105027099003|261022115727099003|261026130827099003|261009223027099003|261021121427099003|261102123227099003|261021135927099003|261026140227099003|261021123027099003|261021130227099003|38070700021|10067099003;
x-microsoft-antispam-message-info: qgIWPOPsZKg6oKWa5YqnJ1w3E10sWJji6YHwATrRLwzO0dDTYbyE1zFi/OKbCrv38Pa6tYgv3OduElvpjtB87P6Rk4mzG0L2u1sm+4mKLWDXBn6BILTqBpP/FBTGm0OFk/ppOikCfx7TqmZ/lXNg962D0Fa6Nk/KtEufJgg2OZUvRvJhD64bgM0SkQow63/O/orCqlBIuYJgzEQKplV+StDOv1tjZ2NE0Eo+zU/IIQtkg7/SA7aije9HUrHl0VjPzHEgsiJzIwyviz9orKR1rPqlUADn3MSU4WrCRiO4mhWWP/31SG0c3FL92bFUvk5lOq+gcTdUtN711Yf3Dd50YbxrqMmlQSkXd39cU37El2XoFal/z4ysNtaatxo33do2v2C9lXTs9ylvP0QD8bWLSpZaYupkIJjBh6KxpNAQQ2TUw+PBtPC7HkG/eFGS96fiFHNvu/SF0esklnlNdgRv/TAtNoGVC2wIwqE9fSM6smFwmCn4HccjfyRYrzNlwgVXczW8oHjhZ5Q9xrqkW12zfkTqZsH5UnxO+b8LcQhULnx8EfYEiWFF41nE+v+FgpW5iQ6OKM6j3qSZTRzW3HvefRIbugH/3b9vfKyaClQalScr7i4f4kTicHIA0oGaPfpAZfS5oryQ1D8/7DrWQvDgPvNt9TB76PVgu4eUTYVaKul4RCa8nBea0D+O0bWtwy+BaYB1D5LeZzvAkH/dJjm/uMBYCkV6g6dwI//8vG0rCBs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4835.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(6133799003)(22082099003)(18002099003)(11063799006)(56012099006)(261022113327099003)(261026121527099003)(261028144727099003)(261022075727099003)(4143699003)(261022105027099003)(261022115727099003)(261026130827099003)(261009223027099003)(261021121427099003)(261102123227099003)(261021135927099003)(261026140227099003)(261021123027099003)(261021130227099003)(38070700021)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cEx4cUVyODIxcVk3bE90Q05HdVVPNFhLaXNma29KREF2Z2oyMDJTcy91NmZS?=
 =?utf-8?B?dGN3S2RRYlprc20rLzYrY1l1K1RJWlBwZlVVbDZ0aHJvTEg3YTNnMHUrVlRO?=
 =?utf-8?B?UVJQYkZWMnhVblRKNFYzVjBVVE41elBuVzQyc0YxYVpMOSsweUhtVnpLbnNz?=
 =?utf-8?B?eFNPQVBjSDlZWS9xdUZ6U3BSWkUxMGIvV1dvVldBKzdHZHVIdC9NaERRdzdI?=
 =?utf-8?B?ZTZMbnRuanpUamFES2ZucmJqUWhodmxudWtSWFdKcE1JTnZpZ3NuQjFyaS9D?=
 =?utf-8?B?Q1ZaVEoxc1FpcmovUmJsT09QYUFsb1FBK3dZRWpzUnM4U0x1dTJ6ZVdGbEo1?=
 =?utf-8?B?b1BTU1pPakgxNHhmZHdSWXZraFBvblFCbXc0Yzh3ckpJNmZNKzVCVlFDUlpj?=
 =?utf-8?B?Qk80T1JvL1lNSGRobHppcUJUS3V3bUoyWExHQTVGMzA1SDdrNE5ZdkZXQ3hL?=
 =?utf-8?B?cjFhTXdIU2N0Q0ZxMFI4YmpZc2ZMVkN3bVFmY3hBMVpnOFozRjFKSzVQQTFK?=
 =?utf-8?B?MkM1NW1ZTTJtdkVTQlNqb0MyZzJ1RWFkTnJ2cXBMUjhIOUNWdi9Fd21wdUdM?=
 =?utf-8?B?TElTNExZOUhZTGdWWWVZL2Fud09PTE5Ga3NhTGhFUlRqT3BLajI0T3pvN3gx?=
 =?utf-8?B?aDJDam5lY0xoSGZ0L3hGeHNlNnRBM3R4NGdreHlQWHl4TkZCMnUxTndPTHhW?=
 =?utf-8?B?bTAycXB1UFNvb0xRS21jay90WTVsY081dmFvSWhtNlB4bURnbnB2NXp6MjlK?=
 =?utf-8?B?cVlwL0RrZ0NzV0dqa1oyT3Q3cWtBMGV5OG82bVlEUU1qdkFVbitNdHFJWkw1?=
 =?utf-8?B?bEM5elk2WVMyekZ4U2FMSjBveVB4S0FBc1k4dkZ1RXhrWElsTUwyS0NZd2M3?=
 =?utf-8?B?ZVN5SnFDTVF6R2llMlRKdDVmV0VlanJrYWE4eDhUL1JBcm4yMVd4WXBhbERj?=
 =?utf-8?B?TnZOdTdoeDhqK3QrZmRSdEpETzFjL1V5RG4wbnQvZkxURFNQelVKMTVMdFpR?=
 =?utf-8?B?b0x0bGlnQXQ3SjdZZEJjNWU1NWNpRTFLUjh4TXZlWEpQL083eGtkQVlYclJ5?=
 =?utf-8?B?bk9aeGFmSVkvNFNxL2lZV1A0a0lYVTJ2ZFVrRld0dWQyVlFKdjZKLzZzcmVz?=
 =?utf-8?B?cHdVTlkzTllqZkxWOENMV2ZtQmY0UW5nRDR0aUZPSXRwOHZqZEJuZGZJUUZW?=
 =?utf-8?B?TE9XNXZ5K21TSmtzN3dZSHdHbVd5Y1VjN3NaMXBVVEx3aE1OV3lYOFZaNUcz?=
 =?utf-8?B?SnhkWm8vWWg4OEJ2WEs4STRPak1UOXUwSHNhSGNCSnczRFEyQVJWSm5iSHNU?=
 =?utf-8?B?SnNmcUMrWUp0WjZwek1IcUFzaE9pYWFkS0pkNzF3WU9pTldJVW1mOXh4UjZK?=
 =?utf-8?B?S1hadTlFUnNOeDVJWmpreXQ2ekZVN0Y5REdqak1BWS9odklUSnJvRFVZb1hX?=
 =?utf-8?B?c2EvWE9RL0d3TUZpcmx4cnIwL3pkUm5XWDVaZndFcFA0N3pySDZteXBaYzI3?=
 =?utf-8?B?ZE1rNXprVVo3YTdsSGNBQWI1S01od1hiWkorVEZ1VkZ1VVdRRjNXaEFKUExt?=
 =?utf-8?B?N0F0dEplaEN4emZPcXdDT3FTck8xUlhQNTlTTFhBZk1CcjRnTnh2YkdPOVM2?=
 =?utf-8?B?RWt0NUhtUDNqMEJvL1I2RmU1bnpLbDMydHBsK1plOFFJRVVIQXdwSVNXcWRU?=
 =?utf-8?B?OEovVGtHZkZBdDluVUZxNzNmbmxTU0s4K1Jkd28ycTI1d0NOaUtRMzV3Rld6?=
 =?utf-8?B?OEhuclNpQm4vSE5jUjhGWTM3RXFyUGtpeUdRUkNOblJEcW9qVkNBWlpGRWlW?=
 =?utf-8?B?MUtqazdqRXY1a0U4RGtOeDE0MXIyVklweUdQNU9SaXVzdGUwbTlLQkdDZ2V3?=
 =?utf-8?B?MTFoT1BsTkFUN3gzUXN3aFgyQ1A4K1dLY2VJREg0RHpEQXFvVXZOc3pWV3or?=
 =?utf-8?B?ZS9jV1RkNXJ2bE1Eb1kyRE8rNUI4ckI0VTI1TmJVMUJzMW9sd1JoWUhHZFBW?=
 =?utf-8?B?UzBoRmk2RndiQzZRNi8xdS9yVGEvaThLY2VGOHRqMDArSHhtK0xJRUlzdjhZ?=
 =?utf-8?B?VWc0QUJ4b2ZIbTI4MkFtZzB1eWNaeDJsLzd6Y1krcGpZd1ovMlhzMUpxaVBw?=
 =?utf-8?B?UWtOeHZSbWlob3lpTTU1bno5Ky9oOHcwUFhoZDh3bEY3R2RPSFpQSEFCeGZP?=
 =?utf-8?B?VmEwMktUOWlqSHl4WWNoR0FRc2pqUkdyejFPeFlidEU5TElRTlNEODEySGp0?=
 =?utf-8?B?ZmtFSjR3UVdqbllCRVVuQ0VldStVbTJ6dTdMRUJpSmRSeVBVZjhudHY4aXhs?=
 =?utf-8?Q?3TidG/Hni4j0mvm3C/?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Tq00mw3AcrptYdLtdkFAdhj6Q+FfjV7TW/6cAYJglRxYeTXbD2MR5XR4nm7wVafgBKsvwIFP24VePdJUNZ/XAtCnyNc1ODsQWAG6tbvkdHmCnbGtVFavaY3K/6YXlYWEi0vUcZFsni7wlx0/pR0eZzFAAAbNXK6kuW9s4aKlzzz9EbBENSWbb5TMOLA+gbM3rVq8GKhPuVuk25HzfKwOZjIYdzZ3gtyGukaiJiNbS06DhplZjVMTrG8fRVHBFv3dGdb9iWyaNMupv7Fxf0YPIeTjyoqUr9JEvtoWnPsTWsUSw2Mb23QmTvXHipw788lfuBhrKBCwlwsfkd5w4CFXuQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4835.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c26b7e71-751f-420e-1214-08df4aa4bdf1
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2026 03:32:33.1330
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HcwbQ9ELjexJpDIQGPnI6/XtKnMDO51FtHK+D/dOohl4MjqXghnjiS0DMryD3/GdE6/fIbMx0UxQXkq4e9OzGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR11MB8817
X-OriginatorOrg: intel.com

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBUdWVz
ZGF5LCBOb3ZlbWJlciAyNCwgMjAyNiAzOjQ3IFBNDQo+IA0KPiBPbiAxMS8yMy8yMDI2IDExOjA4
IFBNLCBYdSBZaWx1biB3cm90ZToNCj4gPj4gQWRkIGEgcGVyLWRldmljZSBpbnRlcmZhY2Ugc28g
dGhhdCBhbiBJT01NVSBpcyBwdXQgaW50byBTZWN1cmUgVERYIE1vZGUNCj4gPj4gb25seSB3aGVu
IGEgZGV2aWNlIGJlaGluZCBpdCBuZWVkcyB0cnVzdGVkIERNQS4gdGR4LWhvc3QgdHJhY2tzIGhv
dw0KPiBtYW55DQo+ID4+IGRldmljZXMgdXNlIGVhY2ggSU9NTVUgYW5kIGNhbGxzIGludG8gdGhl
IFZULWQgZHJpdmVyIG9ubHkgZm9yIHRoZSBmaXJzdA0KPiA+PiBhbmQgdGhlIGxhc3Qgb2YgdGhl
bToNCj4gPj4NCj4gPj4gLSBkbWFyX3RkeGNfZ2V0X3BhcmFtcygpIGxvb2tzIHVwIHRoZSBETUFS
IHVuaXQgdHJhbnNsYXRpbmcgdGhlIGRldmljZQ0KPiA+IEkgdGhpbmsgdGR4YyBpcyBub3QgYSBn
b29kIG5hbWUgc2luY2UgIlREWCBDb25uZWN0IiBpcyBub3QgcHJlZmVycmVkIGFzDQo+ID4gYSB0
ZWNobmljYWwgdGVybS4gVGhlc2UgQVBJcyB3b3VsZCBiZSB1c2VkIGJ5IHg4Ni90ZHgsIHNvIGNh
biB3ZSBhdA0KPiA+IGxlYXN0IGF2b2lkIHVzaW5nIHRkeGMgZm9yIHRoZXNlIEFQSXM/DQo+IA0K
PiBJJ20gb3BlbiB0byB0aGlzLiBJIHVzZWQgdGhlIGRtYXJfdGR4Y18qIHByZWZpeCBiZWNhdXNl
IHRoZSBWVC1kIHNwZWMNCj4gY2FsbHMgdGhpcyBmZWF0dXJlICJURFggQ29ubmVjdCBTdXBwb3J0
Ii4gU2luY2UgdGhlc2UgYXJlIGludGVyZmFjZXMgZm9yDQo+IHRoZSB0ZHgtaG9zdCBtb2R1bGUs
IEknbSBmaW5lIHdpdGggcmVuYW1pbmcgdGhlbSB0byBkbWFyX3RkeF8qLg0KDQppbnRlbF9pb21t
dV90ZHhfZ2V0X3BhcmFtcygpDQppbnRlbF9pb21tdV90ZHhfYWNxdWlyZSgpDQppbnRlbF9pb21t
dV90ZHhfcmVsZWFzZSgpDQoNCj8NCg==
