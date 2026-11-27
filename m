Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.14
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795766347;
	b=J/63BBe01bj1RBSA3wmdVUFiltiq2j+kPCasbKhT+ZZNqE9hceQXODABfC6Phlu7t3hK
	 +f9qAgAylOtPHScZl2ql0VbFanwqtYyR/heoYZkPrK4n6jngBhbd/b0oiqhIg4Cekh/Bp
	 U6P2aBhKaij+Q+H3XGJFsR0xKOHHu32+PxUQM2SRRL97XWo1UDHYUszJigPRV3sVnRqR6
	 /tAK3/kCGWkxS0WGdqWBPnobV06x2xmY0iazAm2LPiL8U+sgIL6p4qf9qrn0Hwxjn9BgR
	 wjAgSxcsTnFvd0l0sAx0boGCx907nEpD5BcvaioyK33OY/PnZe/mo3tqH6hgRZocOeA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795766347;
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
	bh=Yd3nykYIdLV/RN7LZmaOy5ji/Wh9MOuDfXvCU3QmVEo=;
	b=APpjY5LE9bFhYTCyTGWNlpm+W3eM2Lxe+6uEaNJsPvkAeP1e3L1zFRCGP1ALiuAJ1YG4
	 6eSBQ3BdJOyuTqWkEoBnYYjmXNsbjbiM/udAqNo/xlZNMDfYlpOPQBdQ6uJjUuHF7Cs+X
	 XS2jNmegG+XvHnoHclVacUffhufipsvzpCWdruB8W2Xn4q5VE32TJ2AFnKQlB0mwHhebI
	 jbXIEkdj079LzTIlgW3lwkfbkdR1gxyVukQzHJmXnNHZpeIkV9hnzjMP7Krm6tbqPKt8U
	 /ZHj8ot2RBxJh7rGE4Z+/wgXQ/9Xir3KoUOOvv58gXQ5cyXUXpTv8y84jae6XMwcRRQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=naLSkNgD;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=gaQaItWX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24E5606A31E;
	Fri, 27 Nov 2026 07:59:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E24E5606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=naLSkNgD;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=gaQaItWX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795766348; x=1827302348;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Yd3nykYIdLV/RN7LZmaOy5ji/Wh9MOuDfXvCU3QmVEo=;
  b=naLSkNgD6iqUuDe/I8Ygt14KARvUKmjJlZdnM7lA0Ni6CISdXZDwRkvb
   Giw1ByLHSVzQB9UtlaiC0V3JJbaQONVSrXlLGvlUrohjfBNsSL674x2ky
   gO20tx5PMgaQvWoERPiiXS8kT//XuPHtUeZoLIS/RCDRdSeLEkBC0ADVJ
   ROawJi0gSPVLzqnF+djBMKWCGHEbyUHV/ExlneFLBTT0KpuNwrTvVC4Lb
   tdbh9n8W6WTOyE2goAOMT/xMxgzOOy/NOfkYAIKBEyhC7iw+7GammEPc6
   Enmb8uxd2aO65zlXOKOmTbM81RXoinuZGY2fGIQbRfi21QG8vy39/KnnQ
   g==;
X-CSE-ConnectionGUID: pmSF+48gTI6CR92ADRMlAg==
X-CSE-MsgGUID: 7UIcu5A8S5W/Lis3aC5zEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4630384"
X-IronPort-AV: E=Sophos;i="6.27,236,1787036400"; 
   d="scan'208";a="4630384"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2026 23:59:07 -0800
X-CSE-ConnectionGUID: tUdDp1LxRiSv6wX8dLop0g==
X-CSE-MsgGUID: u6+RIUmfQ5CLvRdQ6z/TeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,236,1787036400"; 
   d="scan'208";a="14373680"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2026 23:59:06 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Thu, 26 Nov 2026 23:59:05 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Thu, 26 Nov 2026 23:59:05 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.66) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Thu, 26 Nov 2026 23:59:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JVhxLOU6SZMLv5Ig4upDU7qKOyvOLEUw/pwpZbMAisFEfpA+gs6YHW7Pyw6yk1rG0h2okMIGoWPuRpXREIaDOtm0NC50eb/1i9h9nJPU9zd9cbNqag1YB1mLx/RKvpzCOjxL6vfCWTpKx4J/2Kd18WlhP9FNJvZD6oSRzwidfcbBzBKFjTNQ5qcslsFuAXa9QOGQKh5e+KSPJXfZpTk+/rGr2w/WpmGKxjXWFur9zGIozCIUcH1+oCPthvhrqUQDTBU7ZTIEZltmYiC9gD8IrYDLVguhD7Dx8m/j9f4hd32L0JWDmy9d5Pmb8cTwEz2D7xXPXqQqZazHD/gozRY1Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yd3nykYIdLV/RN7LZmaOy5ji/Wh9MOuDfXvCU3QmVEo=;
 b=VkncoiqvxjGALLbwRvrH+R4umpc9WjTXjzjyoPYSZo8s158etTe2WAzmw9lOUSdAPumD82sk6ORZfvikHAbBUn+CA+pg5VGetpjRlHEs8Menx1lPdHxC38T+S+MIupf1tek89DJzcRL/K4xWWo7l1JAWdTL6lmCpySS5SVBTl9pwKv3lRY2xegDoblrEQgcdc85p2sXt6a+vQ8NhRuI3xEmRPU/Q3JRUb27xYJkaS/iINqzJEWLG3odSOF3QL8MUSMzrIyvun5rx7MkhrBmiFZ/jnK1owK81IJbyf706/rGyU6p7/I36WO3EClfNQKV61Eug6VVNPOd/1BNcqL9BRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yd3nykYIdLV/RN7LZmaOy5ji/Wh9MOuDfXvCU3QmVEo=;
 b=gaQaItWXY0Az4SNWt1jgou1pVBlVUFKEGyHwnVvaYD8lvFchoxT5MFgyJgIGZZziiLdXMgGXDk0yE9UPaY4MmPF80aukqYBXUtDM0HDlPf5L7mwZELWlWryl/qQHwcqSPXth4wEKLEsN0Oz85tooBCBmqckb/Ah1fc8DESd5gbw=
Received: from CO1PR11MB4835.namprd11.prod.outlook.com (2603:10b6:303:9e::22)
 by IA3PR11MB9182.namprd11.prod.outlook.com (2603:10b6:208:579::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.10; Fri, 27 Nov
 2026 07:59:02 +0000
Received: from CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225]) by CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225%6]) with mapi id 15.21.0662.004; Fri, 27 Nov 2026
 07:59:01 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "x86@kernel.org" <x86@kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
CC: Jason Gunthorpe <jgg@ziepe.ca>, Kiryl Shutsemau <kas@kernel.org>,
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "yilun.xu@linux.intel.com"
	<yilun.xu@linux.intel.com>, "Li, Xiaoyao" <xiaoyao.li@intel.com>, "Gao, Chao"
	<chao.gao@intel.com>, Binbin Wu <binbin.wu@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 4/9] iommu/vt-d: Add interface for tdx-host when
 enabling trusted DMA
Thread-Topic: [PATCH v3 4/9] iommu/vt-d: Add interface for tdx-host when
 enabling trusted DMA
Thread-Index: AQHdcmB4VMJqqNYilEu6w0/Ho7paB7c+MBUwgABWMACAAx3+MA==
Date: Fri, 27 Nov 2026 07:59:01 +0000
Message-ID: <CO1PR11MB48355684225D9EB0B469A1EF8C412@CO1PR11MB4835.namprd11.prod.outlook.com>
References: <20261112043054.2664857-1-baolu.lu@linux.intel.com>
 <20261112043054.2664857-5-baolu.lu@linux.intel.com>
 <CO1PR11MB4835EB7D858CC6C8A20F0E148C432@CO1PR11MB4835.namprd11.prod.outlook.com>
 <9a92bb91-3dac-4fc5-8f38-130b7442bdcc@linux.intel.com>
In-Reply-To: <9a92bb91-3dac-4fc5-8f38-130b7442bdcc@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4835:EE_|IA3PR11MB9182:EE_
x-ms-office365-filtering-correlation-id: bf31c3c4-def9-491e-b4f1-08df4c5c4ca8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|38070700021|10067099003|56012099006|261026121527099003|261026140227099003|261028144727099003|261022105027099003|261022075727099003|261021121427099003|261102123227099003|261102130727099003|5023799004|22082099003|18002099003|11063799006|4143699003|6133799003;
x-microsoft-antispam-message-info: 8pR5YxBc+DpnbhP0V2iMuGQmvF8zeD5De4seLfwpWz8loQTw1u/iGWBMs5Qhm1HWvxgdbSC2pgvIysAgEIngvgYtrhAZhUVqLYyr0cnrARdZEuKRN5rCY6iWUqAv8waCaoRWstUQ2E2K6yEpIeiGAQXLFaHSDmGSesORYFo4XynEVOm4utaXf2VohAn3LzYbx4xyPHOpszbIb1BjokNXJu05ijnItFBDtbWkTkESrN8Bx1h13E0MNFS7yB4tZMnqz9Si86JmV9Qda/b71YWNa7nYFcOirpZ1hJPnUH3KTreVvzHVz2jziqYotR6gbE2bY2ODsA083AL3xgeWgIVplEeBIgAYv2rx66IYUWfWg12EZjh777GMIfFqfkagFTod3xIhNtxDgt1S37nwuk/KtuY4nqda7oCZKruC7awf4yIfSFL3OfOom77Evp7yU1VaoR4N3fjt9noInfoqtlQmaAKVmcffbLckoxyshOKE4GOGlHDkqFtiNdZPxheku28jaFfPJ+7bXDgktKiS9BTMmLNq/EVwUN+BpKsEym/qWa6fDMCTBfyzp227kxLUzE4gxFzM523cNuYQIJIs08oUEMmQJsvtpPznkFI/PsgzMy+RnG9MWdX/tBcWUD3zrLEGxFkPe7jyeDsAQVEDZlVDaBNjmB5rwhHm1imGdpSM1zKJFlw9FD4eoPOkxZDqq0HtuBpMvfKtjQIZUVQ5SzCbSy61olrvsbVWGSTQ0y/pYUk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4835.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(38070700021)(10067099003)(56012099006)(261026121527099003)(261026140227099003)(261028144727099003)(261022105027099003)(261022075727099003)(261021121427099003)(261102123227099003)(261102130727099003)(5023799004)(22082099003)(18002099003)(11063799006)(4143699003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WGIxWXAwSzhKS2FXWEl1aU51bUhXN2k5MGxtUmRFT0gwVytMcDJnZjdCZ2V3?=
 =?utf-8?B?UFp6RmtkaVMvRGExWlROR05KOXVESXdWZkNxWmRyZWpuVGV2c0wyelVwNGhI?=
 =?utf-8?B?T3B0T3l5Z2xtR0gwd2YvRWZocHJsODdldEx6V0FnMkg5TnF0WHhPUE9yQlJH?=
 =?utf-8?B?anZWMGNENDNpcFpWSk1hT2wvVnZYUFdhL04yU2VGVE5CWXV5dmV0Y0dkVmlD?=
 =?utf-8?B?bk1sUFozMm9DRGI0YWh3TkpDd3dUd1VpckM1MHJPUllsKzVSayt1ajArSzl2?=
 =?utf-8?B?ZG5MVHBpWndQcko1TGc3VXJMSkR4NVdJR2FKQzN2STRqQWVKTU5jS2M3bzFC?=
 =?utf-8?B?endGVkJpU2ZQVUoySGYraTRCY1lXL2NVZ1ZOSTVRajhhSWQ4dVdXTjRzQU0y?=
 =?utf-8?B?My83eHo2TmVpZ2djSXVqRk5IaGRPNGJRR2liZXppREtwdFpUWkhNOUNVdmc5?=
 =?utf-8?B?TDZpYnZxazlDSHkxeWVYMW1PaXNnSnJuMWdWSW12K0hZRzdVZ2lRc2kxRVF2?=
 =?utf-8?B?WWpVQlZRblJDcDlmRGVhRWVPWjZjU1A0THJRWmM4UUJzNzdma2ZIU1EyN0pN?=
 =?utf-8?B?LzBpdk1MVG9kRFg4eUY5K3o4ekNRdXlOQTZKUldibm8vL29GcElsRk0xSDg0?=
 =?utf-8?B?c3hVbEdJc0pJV1hZYnVicGlHdTVSOFhLV3JSWTZ3U0lySEg3YWdUM3dIQk1z?=
 =?utf-8?B?cVB3Y0V5Tms2WFI4TjZqMkVhaHN4c1BNRTdTeXRab2c4YmlpRGF2blluL2tv?=
 =?utf-8?B?Vzc5L3JuQk4zMjJ5TkdEN2ZHUU44V015S1Qxc3FPTm1qODEzUnBvVkFSYk1C?=
 =?utf-8?B?WjFpM2N0RGhHUmQyWmRqaVlXUDgwOU5sUGJ1WmJhcHZkNEp5ZHBGSU03Zk5J?=
 =?utf-8?B?S1k2TlRwVjVHNVJVQmYwUDQ2QmxGSGVxcEZqdFFsSlpXSVNRS0pvMmQzeWMx?=
 =?utf-8?B?aW45MklpM3l5UVpBbWw2V3liNU8wU1BkNjFmSytleXc2ZVdQVWNMaHAxWjhG?=
 =?utf-8?B?eFdGSzliWUtISjhyMFdOTWFkeWFmRWZhU3E2TTc1enNoVmhZVHg0a1pGZ0ph?=
 =?utf-8?B?bUNIZzJ1NHk0K0Z6clpCdFNiT2NOMlkwYWJtYnozN0ludHYramkreSt4bGxX?=
 =?utf-8?B?MEYzRm5VSG56QTRGVlJaYVkvNm16S2pINnNCQjQ5OUZCeG9Vd1gyaE1ySzhq?=
 =?utf-8?B?eDVoblB2em1jYW5ycXZ5UTk0OGp2cHlZMDJmRzFObkdrYWp5SFMvVmZDVzlm?=
 =?utf-8?B?Z1lBcE1MS2lOdjFGdE5ZeVJKb2FySW5VdzhBMDVXTGlQVFhtaDJmOWJ0QkVW?=
 =?utf-8?B?WFFibWo3THRKejMyMXVTcm1Sak05VWZtWjRFQVY1UWhycE9Wa0d3QVFwZ2pz?=
 =?utf-8?B?Y1pncHlzNnlXaXllNWcrd0QyeDNnS3ZTRU1neTlUcml4YzFIbFRmMVZOVElV?=
 =?utf-8?B?VnZxend1ZGNaZ1BrWFhVZ2lHMUxhQk9uYzRxSUdnTzdXQkJNSXRGS3grNmxJ?=
 =?utf-8?B?bGVBVXRJUUhSMVRVMi9EQ3plNE9vZkxuekNGbXViUFpqS2M4NDFrU2NBaGQv?=
 =?utf-8?B?amY4akEzSVZRLzVIZ0w3RFV3MWZOMHJPL2JkVGt5dUMyWlh6YzdJYVg0Q2wx?=
 =?utf-8?B?czBRVGRZTkhKeVErUEZjTWlRMktGVVdQMWNNZ2NKdDFRdmxFSFhPbHlYbDJk?=
 =?utf-8?B?RUw0OFdSamxyYWJBL0hXa0Qwbyt3Qk96aUt5dEVObkhIUGVXc25USE5LZkZk?=
 =?utf-8?B?WmtXL2QzdDY3QWJFZnFPT2x4NktmQmJpdWRLdzRCVys4aGJxOUZhQTYyYU5D?=
 =?utf-8?B?eldDSXowckx2UVVHQWFJUUVCTzlaQm1JUzJJY21sOXhiQlExWVY4NVlwT0RW?=
 =?utf-8?B?dmk2MGFNODlxYUd3L25IZ2Vwd2luSVNHb0tOK3c2Sk9lcUZlVmRmZzFrVWgw?=
 =?utf-8?B?UFE5UkN6cXkyYytuL3hiZ1pBYjBQaTMzTVk0VnBUTDlxVGlzM1FIWmkzM1Fw?=
 =?utf-8?B?eWlzMmF1QWQ0K21uWkRUZk1ianFsUEdBMmVTT2ZiWGV1aTVCWDhtOERGNnJq?=
 =?utf-8?B?bHZHM0lCTTE5OE9UODJsOUpzVTlTMDZvcGhlby9RNllka3ZXN3llY0JjaFh4?=
 =?utf-8?B?QVNXSE9WOW5VYlk4OVFpeUJLSGtFNHRmdVEzYWVIUHRCelVQd1RTTmxaZlhy?=
 =?utf-8?B?ZHJVVWh3WEJzNjJ3cnNhVVcxcGxKSkZuemlJQ09uNmVGUmc3MU1URnIzVWR4?=
 =?utf-8?B?QWFSaWNaYWkrZ29tbXF6T2VMQUdrc0diRURQNGVpK1Z1TnhIRnBkckZiVlUx?=
 =?utf-8?B?YXpYVHF0d01VMEVYZWgza1JDSE5GWGp5dnNwSkJXa2M3czROK3UyZz09?=
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
X-Exchange-RoutingPolicyChecked: i5sti7iNXXtDw/wu0WaLgop/dpAfEarLA2iiCJvpjxfLdhauak3LEAPJ+VCjamI9ZCUjpbZfdqRwg75RWHYTcpOZPKWVlVx7Z/v8UQB4Da37CKs51GH3LyrEeAHj7uq+uhvKmF67amESO7EysFXoJWY8zviydNwg8QxDAzvCsgpH/h9dDr5Ld/HNUvbmiWgD9vRqFlTKeR7VhkNyX9JHiRVxG5+0AEW4y038AdhHf64LYpMapPW0Foyh+HPwhWr9PTXor0VTnJkOLHTonrB0GEoHL8YRkIlkNVv6DHLP73Q2HGxv/R2D7yfj/JE4NjxNjvHGdzERPh6ZSf46YMXLlA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4835.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf31c3c4-def9-491e-b4f1-08df4c5c4ca8
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2026 07:59:01.6350
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ns8h18bfgzbY9MgDOTzlUQuJibKf8F0EfBBIkEQNBiTduRpAq6dH9YuhwiitaQSogjLB030bIgUCE58+5GX1qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9182
X-OriginatorOrg: intel.com

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBXZWRu
ZXNkYXksIE5vdmVtYmVyIDI1LCAyMDI2IDQ6MTggUE0NCj4gDQo+IE9uIDExLzI1LzIwMjYgMTE6
MjkgQU0sIFRpYW4sIEtldmluIHdyb3RlOg0KPiA+PiBGcm9tOiBMdSBCYW9sdSA8YmFvbHUubHVA
bGludXguaW50ZWwuY29tPg0KPiA+PiBTZW50OiBUaHVyc2RheSwgTm92ZW1iZXIgMTIsIDIwMjYg
MTI6MzEgUE0NCj4gPj4NCj4gPj4gQW4gSW50ZWwgSU9NTVUgdGhhdCBzdXBwb3J0cyB0cnVzdGVk
IERNQSAoRUNBUC5URFhDUykgcHJvdmlkZXMgYQ0KPiBzZWNvbmQNCj4gPj4gc2V0IG9mIERNQSB0
cmFuc2xhdGlvbiByZXNvdXJjZXMsIG1hbmFnZWQgYnkgdGhlIFREWCBtb2R1bGUgYW5kIHVzZWQN
Cj4gPj4gb25seSBmb3IgZGV2aWNlcyBhc3NpZ25lZCB0byBURHMuIEJlZm9yZSB0aGV5IGNhbiBi
ZSB1c2VkLCB0aGUgdGR4LWhvc3QNCj4gPj4gZHJpdmVyIGlzc3VlcyBUREguSU9NTVUuU0VUVVAg
dG8gcHV0IHRoZSBJT01NVSBpbnRvIFNlY3VyZSBURFgNCj4gTW9kZSwNCj4gPj4gYW5kDQo+ID4+
IGlzc3VlcyBUREguSU9NTVUuQ0xFQVIgdG8gdGFrZSBpdCBvdXQgYWdhaW4uDQo+ID4+DQo+ID4+
IFRoZSBWVC1kIGRyaXZlciBvd25zIHRoZSBoYXJkd2FyZSBzdGF0ZSB0aGVzZSBTRUFNQ0FMTHMg
ZGVwZW5kIG9uLCBzbw0KPiA+PiBpdCBjaGVja3MgdGhhdCBzdGF0ZSBhbmQga2VlcHMgaXRzIG93
biB1c2Ugb2YgdGhlIElPTU1VIG91dCBvZiB0aGUgVERYDQo+ID4+IG1vZHVsZSdzIHdheS4gVGhp
cyBpcyBjb29wZXJhdGlvbiwgbm90IGVuZm9yY2VtZW50OiB0aGUgVERYIG1vZHVsZQ0KPiA+PiBw
cm90ZWN0cyB0cnVzdGVkIERNQSByZWdhcmRsZXNzLCBhbmQgYSBtaXNiZWhhdmluZyBob3N0IGNh
biBvbmx5IGNhdXNlDQo+ID4+IGZhaWx1cmVzLg0KPiA+Pg0KPiA+PiBBZGQgYSBwZXItZGV2aWNl
IGludGVyZmFjZSBzbyB0aGF0IGFuIElPTU1VIGlzIHB1dCBpbnRvIFNlY3VyZSBURFggTW9kZQ0K
PiA+PiBvbmx5IHdoZW4gYSBkZXZpY2UgYmVoaW5kIGl0IG5lZWRzIHRydXN0ZWQgRE1BLiB0ZHgt
aG9zdCB0cmFja3MgaG93DQo+IG1hbnkNCj4gPj4gZGV2aWNlcyB1c2UgZWFjaCBJT01NVSBhbmQg
Y2FsbHMgaW50byB0aGUgVlQtZCBkcml2ZXIgb25seSBmb3IgdGhlIGZpcnN0DQo+ID4+IGFuZCB0
aGUgbGFzdCBvZiB0aGVtOg0KPiA+Pg0KPiA+PiAtIGRtYXJfdGR4Y19nZXRfcGFyYW1zKCkgbG9v
a3MgdXAgdGhlIERNQVIgdW5pdCB0cmFuc2xhdGluZyB0aGUgZGV2aWNlDQo+ID4+ICAgIGFuZCBy
ZXR1cm5zIGl0cyByZWdpc3RlciBiYXNlIGFkZHJlc3MsIHdoaWNoIGlzIGhvdyB0aGUgVERYIG1v
ZHVsZQ0KPiA+PiAgICBpZGVudGlmaWVzIGFuIElPTU1VLCBhbmQgaXRzIE5VTUEgbm9kZSwgc28g
dGhhdCB0ZHgtaG9zdCBjYW4gYWxsb2NhdGUNCj4gPj4gICAgdGhlIFREWCBtb2R1bGUncyBtZXRh
ZGF0YSBwYWdlcyBsb2NhbCB0byB0aGF0IElPTU1VLg0KPiA+Pg0KPiA+PiAtIGRtYXJfdGR4Y19h
Y3F1aXJlKCkgaXMgY2FsbGVkIHJpZ2h0IGJlZm9yZSBUREguSU9NTVUuU0VUVVAuIEl0IGNoZWNr
cw0KPiA+PiAgICB0aGUgcHJlY29uZGl0aW9ucyBUREguSU9NTVUuU0VUVVAgcmVxdWlyZXMgKERN
QSB0cmFuc2xhdGlvbiwNCj4gcXVldWVkDQo+ID4+ICAgIGludmFsaWRhdGlvbiBhbmQgc2NhbGFi
bGUgbW9kZSBlbmFibGVkKSBhbmQgY29uZmluZXMgdGhlIGhvc3QgdG8gdGhlDQo+ID4+ICAgIGxv
d2VyIGhhbGYgb2YgdGhlIGRvbWFpbiBJRCBzcGFjZSwgc2luY2UgdGhlIFREWCBtb2R1bGUgb3du
cyB0aGUgaGFsZg0KPiA+PiAgICB3aXRoIHRoZSBNU0Igc2V0Lg0KPiA+Pg0KPiA+PiAtIGRtYXJf
dGR4Y19yZWxlYXNlKCkgdW5kb2VzIGFjcXVpcmUoKS4gdGR4LWhvc3QgY2FsbHMgaXQgaWYNCj4g
Pj4gICAgVERILklPTU1VLlNFVFVQIGZhaWxzLCBvciBhZnRlciBUREguSU9NTVUuQ0xFQVIgc3Vj
Y2VlZHMgZm9yIHRoZQ0KPiBsYXN0DQo+ID4+ICAgIHVzZXIuIElmIFRESC5JT01NVS5DTEVBUiBm
YWlscywgdGR4LWhvc3QgZG9lc24ndCBjYWxsIGl0LCBzbyB0aGUgdXBwZXINCj4gPj4gICAgaGFs
ZiBvZiB0aGUgZG9tYWluIElEIHNwYWNlIHN0YXlzIHJlc2VydmVkIGZvciB0aGUgVERYIG1vZHVs
ZS4NCj4gPj4NCj4gPj4gRE1BUiB1bml0cyBhZHZlcnRpc2luZyBFQ0FQLlREWENTIGFyZSBleGNs
dWRlZCBmcm9tIERNQVIgaG90cGx1Zy4gTm8NCj4gPj4gcGxhdGZvcm0gY3VycmVudGx5IHN1cHBv
cnRzIGJvdGggdHJ1c3RlZCBETUEgYW5kIERNQVIgaG90cGx1Zywgc28gdGhhdA0KPiA+PiBmbG93
IGNhbid0IGJlIHZhbGlkYXRlZCBvbiBoYXJkd2FyZS4gSG90LXJlbW92aW5nIHN1Y2ggYSB1bml0
IGlzIGFsc28NCj4gPj4gdW5zYWZlLCBiZWNhdXNlIHRkeC1ob3N0IG1heSBob2xkIGEgcmVmZXJl
bmNlIHRvIGl0IGFuZCB0aGUgVERYIG1vZHVsZQ0KPiA+PiBtYXkgb3duIGl0cyB0cnVzdGVkIERN
QSByZXNvdXJjZXMuIFRoaXMgYWxzbyBrZWVwcyB0aGUgdW5pdCBoYW5kbGUNCj4gPj4gcmV0dXJu
ZWQgYnkgZG1hcl90ZHhjX2dldF9wYXJhbXMoKSB2YWxpZCBmb3IgdGhlIGxpZmV0aW1lIG9mIHRo
ZSBzeXN0ZW0uDQo+ID4NCj4gPiBIZXJlIHdlIHVzZWQgbXVsdGlwbGUgdGVybXMgKEludGVsIElP
TU1VLCBWVC1kLCBETUFSKSB0byB0YWxrIGFib3V0DQo+ID4gYSBzYW1lIHRoaW5nLiBJbnRlbCBJ
T01NVSBhbmQgVlQtZCBhcmUgaW50ZXJjaGFuZ2VhYmxlLCBjb21tb25seSB1c2VkDQo+ID4gaW4g
bWFueSBwbGFjZXMuIEJ1dCBETUFSIGlzIG1vcmUgYSB0ZXJtIGluIEFDUEkgc3RydWN0dXJlLiBC
ZXR0ZXIgYXZvaWQNCj4gPiBpdCBpbiBkZXNjcmlwdGlvbiwgZXNwZWNpYWxseSBpbiBleHBvcnRl
ZCBpbnRlcmZhY2UgbmFtZXMuDQo+IA0KPiBJbnRlbCBJT01NVSBhbmQgVlQtZCByZWZlciB0byB0
aGUgaGFyZHdhcmUgdGhhdCB0aGUgaW50ZWwtaW9tbXUgZHJpdmVyDQo+IGRyaXZlcy4gRE1BUiBp
cyB0aGUgQUNQSSBETUEgcmVtYXBwaW5nIHRhYmxlLCBhbmQgdGhlIHRlcm0gaXMgc29tZXRpbWVz
DQo+IHVzZWQgZm9yIHRoZSByZW1hcHBpbmcgaGFyZHdhcmUgdW5pdHMgaXQgZGVzY3JpYmVzLg0K
DQppbnRlcm5hbGx5IG9rLCBidXQgZXh0ZXJuYWxseSBpdCBqdXN0IGFkZHMgdW5uZWNlc3Nhcnkg
Y29uZnVzaW9uLg0KDQo+IA0KPiBUaGUgaW50ZXJmYWNlIGhlcmUgaXMgbm90IGFuIGludGVsLWlv
bW11IGRyaXZlciBpbnRlcmZhY2UsIHNpbmNlIHRob3NlDQo+IHNob3VsZCBhbGwgZ28gdGhyb3Vn
aCB0aGUgaW9tbXUgY29yZS4gSXQncyBleHBvcnRlZCBmcm9tIHRoZSBBQ1BJL0RNQVINCj4gbGF5
ZXIgaW5zdGVhZCwgc28gZG1hcl90ZHhfKiBzZWVtcyB0aGUgbW9yZSBmaXR0aW5nIG5hbWUuDQoN
Cml0J3MgYW4gaW50ZXJmYWNlIHdoaWNoIGludGVsLWlvbW11IGRyaXZlciBwcm92aWRlcyB0byB0
aGUgdHNtIGRyaXZlci4NCg0KaXQncyBleHBvcnRlZCBmcm9tIGRtYXIgbGF5ZXIgYmVjYXVzZSB5
b3UgY2hvc2UgdG8gcHV0IGl0IGluIGRtYXIuYywgYnV0DQpyZWFsbHkgdGhlIGxvZ2ljIHRoZXJl
IGlzIGFib3V0IHRoZSBnZW5lcmFsIGlvbW11IG9iamVjdCBpdHNlbGYgYXQgcnVudGltZS4NCg0K
ZG1hciBzaG91bGQgYmUgdXNlZCBtb3N0bHkgYXQgYm9vdCB0aW1lLg0KDQo+ID4+ICsJZ3VhcmQo
bXV0ZXgpKCZkcmhkLT50ZHhjX2xvY2spOw0KPiA+PiArCS8qIFN0aWxsIHNldCBpZiBUREguSU9N
TVUuQ0xFQVIgZmFpbGVkIGFuZCB0ZHgtaG9zdCB3YXMgcmVsb2FkZWQuICovDQo+ID4+ICsJaWYg
KGlvbW11LT50ZHhjX2FjcXVpcmVkKQ0KPiA+PiArCQlyZXR1cm4gLUVCVVNZOw0KPiA+DQo+ID4g
d2hhdCBkb2VzICJ0ZHgtaG9zdCB3YXMgcmVsb2FkZWQiIGFjdHVhbGx5IG1lYW4/DQo+IA0KPiBJ
dCdzIHN0YWxlLiBBZnRlciBhIGZhaWxlZCBUREguSU9NTVUuQ0xFQVIsIHRoZSBmbGFnIHN0YXlz
IHNldCBhbmQgdGhlDQo+IG5leHQgYWNxdWlyZSgpIGZhaWxzLCB3aGV0aGVyIG9yIG5vdCB0ZHgt
aG9zdCBpcyByZWxvYWRlZC4gSSdsbCByZXdvcmQNCj4gaXQgdG86DQo+IA0KPiAJLyogU3RpbGwg
c2V0IGlmIGEgcHJldmlvdXMgVERILklPTU1VLkNMRUFSIGZhaWxlZC4gKi8NCg0KSSBkb24ndCB0
aGluayBpdCdzIG5lY2Vzc2FyeS4gd2hhdCBhYm91dCB0aGUgY2FsbGVyIG9ubHkgaW52b2tlcyBh
Y3F1aXJlKCkNCmJ1dCBmb3JnZXRzIHRvIGRvIHJlbGVhc2UoKT8gV2UgZG9uJ3QgbmVlZCB0byBk
ZXNjcmliZSBhbGwgcG9zc2libGUNCnJlYXNvbnMgd2h5IGl0J3MgbGVmdCBpbiB0aGF0IHN0YXRl
LiBUaGUgY29kZSBpdHNlbGYgaXMgY2xlYXIgZW5vdWdoLg0KDQo=
