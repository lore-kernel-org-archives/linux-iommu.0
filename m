Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA1A3624D4
	for <iommu@lists.linux.dev>; Wed, 17 Jun 2026 07:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781680970; cv=fail; b=qRe7ttqF0wGkIu3w7hPYYixfZYGzacU/7+wTDxYiXdwuwbS1bN4OmdnFC/FsQ7cpZD4rVkeFED0q7SSWQ9PyF9ToqIIW+EfcapGueJaY7vaDip6x08F7Hg/VTbvNqmKzEhwLdeGgX/frZ/kvWPl7bqomawBg1SMJFQ+uRR9s6tU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781680970; c=relaxed/simple;
	bh=daHvQQ9J1xr9vyw8JeZefVIfStmgHb4qPyCzWVzbFfI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cgfmoag7j3klBFv2DLQ9eQSC5cq0gsGX2IWa/GxMYXHPWk3JjmbD55iZ0vOnsRDTzbHkpf64JGENcXBy+vFhFTJoqe77OC2Xmcf1tfLimUMnhRpwIN9sZf63yLdw9sPJJsJDXXLTcshcaCRLYc+ms0CVm3aWGzoufWiX5g1gxfE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dBM1ENHk; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dBM1ENHk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781680968; x=1813216968;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=daHvQQ9J1xr9vyw8JeZefVIfStmgHb4qPyCzWVzbFfI=;
  b=dBM1ENHkSYOWfiFcGnnra329ToFGjdv0YczbEZARZM4LO6I+H78eCZvQ
   MqYpUspDncsPH+mPp+vN21PpJwR0Notm+q6m1X05utnaLNERxVT4liwOu
   LPm94mhfqSfk9+iOmOlNa23XD1SUXrrWd+n4ZqybJ7Y+jTBl+HhKbnOS/
   Is1dAHqOohBd9hOOYQogHdcCR90s9Hmq4QS0n4L7dcnktUpgXTLwX382T
   josxdphTyI0xIghjfJPslmnGQBV9PIgClng/p1HbsMXDS18FfuHYUr2jH
   U08BmaS+VturdIPxR3AuiRWBYVIfg7n1FubIUh/YwBJmkLSJd/j+pxUFY
   w==;
X-CSE-ConnectionGUID: AX2kBr00R7+PIrw7/jG+Cw==
X-CSE-MsgGUID: BAJKMsigR2G7lU/4ZNzAhg==
X-IronPort-AV: E=McAfee;i="6800,10657,11819"; a="100030196"
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="100030196"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 00:22:48 -0700
X-CSE-ConnectionGUID: ysDoMSRKQWC3d1zmk2BcWw==
X-CSE-MsgGUID: uF9b4xKETEuXhMPNcOSV1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="286103104"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 00:22:48 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 17 Jun 2026 00:22:47 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 17 Jun 2026 00:22:47 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.65) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 17 Jun 2026 00:22:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PrsfFMVsSSKR+5+w/ILEGJooIM5rXGBik0WjMiR401D4zHx3c390oYzNVZyveFb4oWzHPjC27B7MPhvG6+wy6gFEY3lZIfx2NyuXrViUOPkZDXaptqMVWL7uNwlt3JPbp/0gWIHv8srGTRllbkMZnY2QrdPlwozX0Ne0DqY/+aHvLLnB67A8MJk6aE2WKKDSe1LyRWF+wC7NJVEc7LCaZaLffAReHU0mu4xM9A3WChC3Q80vaO1QsFldihGjBWc4v3s7ytSSX01/rkNbX4RainuNeHBLri3RKDpfcz1o6sQxrHr6jARlJIJa2XricEhz5+0IouaoYXA9NHmS+djFtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=daHvQQ9J1xr9vyw8JeZefVIfStmgHb4qPyCzWVzbFfI=;
 b=d3G6Qso2+WXHYdpyEBKTwFI1FzHsE0PG+Fzji8yZOfzOYPIwhFLjjfUB6zPVQrQEP93WooF9M4H5Y/G9ecSZcYw1BJdHCd14E13bmvplaqWr/t9jKtvTMflD2/qCI3ZGjOHbn+hrMJOoY8epplUqpSsNYMAfsU4h88T2egTrz4WL59bq6XPgf5fQBKtmymI90paVLhGjt25brEWrwyrCR6Jq7pD0EiXGvkmbttYojQW2h/clXOcqc45Bp8jRxoijXVwES45yqWXSxsvT6dqoLIZ08l9QFOkz+ZNZPvxRlqNypY8vaUTDQolZugqYwemrwlTB+cPZ2TId+YHcOnaWJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3690.namprd11.prod.outlook.com (2603:10b6:5:13d::32)
 by IA3PR11MB8987.namprd11.prod.outlook.com (2603:10b6:208:574::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 07:22:44 +0000
Received: from DM6PR11MB3690.namprd11.prod.outlook.com
 ([fe80::7db8:f6b3:30f8:ee4b]) by DM6PR11MB3690.namprd11.prod.outlook.com
 ([fe80::7db8:f6b3:30f8:ee4b%4]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 07:22:43 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
CC: Joerg Roedel <jroedel@suse.de>, Mika Westerberg
	<mika.westerberg@linux.intel.com>, Ashok Raj <ashok.raj@intel.com>, "Chris
 Wright" <chrisw@sous-sol.org>, Jesse Barnes <jbarnes@virtuousgeek.org>,
	"Mallick, Asit K" <asit.k.mallick@intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 7/9] iommu/vt-d: Remove the 'force_on' variable
Thread-Topic: [PATCH 7/9] iommu/vt-d: Remove the 'force_on' variable
Thread-Index: AQHc89/uPQRbfc/6XkCDhtILcbE4hrY7BGcAgAdnKmA=
Date: Wed, 17 Jun 2026 07:22:43 +0000
Message-ID: <DM6PR11MB369013D2CF2A41A9CD9A3A168CE42@DM6PR11MB3690.namprd11.prod.outlook.com>
References: <20260604051540.592925-1-kevin.tian@intel.com>
 <20260604051540.592925-8-kevin.tian@intel.com>
 <2680e88b-1a92-42ea-8574-dbe5a62ad7bd@linux.intel.com>
In-Reply-To: <2680e88b-1a92-42ea-8574-dbe5a62ad7bd@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3690:EE_|IA3PR11MB8987:EE_
x-ms-office365-filtering-correlation-id: 7ff99d5e-6387-4f50-b4ea-08decc4138d3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|366016|56012099006|6133799003|11063799006|4143699003|38070700021|22082099003|18002099003;
x-microsoft-antispam-message-info: SF7yTdATHZqjy6eLeruBmfwNvEJtOBGAbc8YLN1ipWX+CO4nAsuMMDncvP0jz3scanwvCL6nkEBCfVSbb191+smss/p98bHPWiBEMUDcSodV9QqTdjkhQjCgya5fgwrcIKvOMk5eAhyPyu2hV552mUwRcQff01WM5R/9GnS0NmohvE1gN7OPw40StzruRuxLBaWckTFrVqp2FIybEZioHpiNqjGpt0nfItg6hzTYBRzZ502f7OPCEUkjIZTmbQvYp2Xg1sn46nP5qmKrhRl8yiY67TKuKEWsmuhoJYa/zdAFgTpR+ZoObFTJjjlDgQmIIlP60wiy4RTqJ0Aq4edKRipuUraz3amN8rEqfhCCHyXIF8ZAqpVR4Xmoyo700acruCS+INtpLE+gbw1LwrEOeaKNQFV1E9O0JjyeD0tJYmxx8uJHqFGKjpZlZRCTI1kuMFx25+vW3FufGBf6BZYF9HB2ofIUoB6l8aEPnkaGUW7Xapm3haCuTNb+PDI4YFRuFh0i22hfX8VWFpUQKRjEyt8+NdnPeTq+USwLqpsRMnn2mvdOga6Vj4Hhz+TCm8O1fHKeO6n04+uyflZH1HyVsHYmB+PghZDHS5Bcjz1xO+eBp+1YBEMAP31blPhkETmImQiF/U9f7RfVY18ZEfAHFB0GA3PObI7fKUU2OALaGUGE97qPSzo3WdZacCGKyVpeKEpVSAfWMXGi88FSXodGc4SNCgyu7ZvtRDrqxIoe9sKvpmdA45tSagAFaalpivSs
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3690.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(56012099006)(6133799003)(11063799006)(4143699003)(38070700021)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Sm9jdXYwNVZoelBMdjJOM25ubjRFYzZ4eTU4R0pCZFdncGVLK1NDS3BzVmpO?=
 =?utf-8?B?MnN3Rk81dUkrOGx6bjRjQWw1RVMvS25nd3hPUGY1N3RDbHNKbExHclVDQVJU?=
 =?utf-8?B?V0p3dVg3b2tzYzliM2h1NERDdEMrT2ZzSzBXYUhORXhhdUd3UDJtN01oNEUy?=
 =?utf-8?B?bGpueDJQbXg2U1R5VWQ5VFFobHZRTmFYZDg4OXluV0haY1lPQlJqSG5pTzNQ?=
 =?utf-8?B?bHNzeitwV01oTEoyQzJYeTM0T0lwWUsvbjM5czMzNGJEd2RRR1dMVmlUcXBZ?=
 =?utf-8?B?d1JhT0ZHQU9QV080dlpnWkhOSmt0N2Z1TDJaeEU4TTBrL2toV2VkT1JhaW1n?=
 =?utf-8?B?a1VJVTdwR1VoRXdKL2pldmRFWFJIK3dHc2c3RlNQeW9VUEt1TDlVdjRUQ2Rm?=
 =?utf-8?B?RDJCcTgvenhwMDFsR25hVHpheWkyVkRaSCs1NXg0Z05ydFJHelY4OU4vcFFr?=
 =?utf-8?B?RUpBdEJmT09xazIvOWtoOW15ZHJidDV6N2o4VDkyQ2wxTnowZjBOblU5Y2p4?=
 =?utf-8?B?VUdtWXZzVU1QeVIwY3NvdktXK2hPVDhWS1RtcUphUWozbnhXSEZDMkN3MUpL?=
 =?utf-8?B?YXBhWWpnUjkwOHlSNlY4bm52ajVpSHdDdEEzWEZsVTg5eGNNczFuS0ZTaVhE?=
 =?utf-8?B?L0g4UklMdUVFcWZWRyt6U3Bhanc5bmpwWDBjeG92ZVVBQVRCeEM4RExRREp4?=
 =?utf-8?B?MWJsdU43emhuRXkxc00wa0ExV0xCMEZPNzdvdCtJWXVreVpwODZ0eE52QU0x?=
 =?utf-8?B?WTFxajlIcEJWeFBoZmVud3dVT2tCS2VOdXl4bHJwdW9odTJaaFJFQlFxMGJx?=
 =?utf-8?B?dE1BS1NLVTROZUluSHpJL1FsNm9WQkk4TEhXSU9mS1JYTWtXWkRVR1JtMDI0?=
 =?utf-8?B?K2xJNjZUc1FONkVNdTgvZWhWMVlQVkNZUU5GM2tqMlNwdEo1Z28vZGFhTVhO?=
 =?utf-8?B?UVhBR0VTU0xHSmdLbVB5OTIxbTh4Q3VOWU1Md3hYa0FiMnZVcTlBZ2F3OW5o?=
 =?utf-8?B?bDdlUUNERjZmR1J4TjRYVlJIWjRnRk1LWE5kN0pYK3FkMGlDbWhZYlJRc0px?=
 =?utf-8?B?QjQxNkkrMXAvdDBmUDBmRXVhZ0FFblVIRmVPMGkrVU9vTVBrVFJ3UlRsZm9w?=
 =?utf-8?B?TDFad2pNakdUdWxGTmNBVVRuTGR1WkJjM0o3N1VkdzZjeXQrLzZqSG1iMmZ0?=
 =?utf-8?B?MXQvTGhEazBkSkowdjFPdWZVcnFSSlZ6N1dZS3hVbDg1QTFFdkhvL3ovcDI4?=
 =?utf-8?B?V2plTWZ0b1pNNTlBL3hzOE5sbCtUZkptQkdoL053bDFDRUh6SU9GaVFwSUpu?=
 =?utf-8?B?dnB4NHd3Vk51YXJseHpoYUVFMktqYllUREdYcVp5RFJGUVFwQUhVWUczSnlC?=
 =?utf-8?B?aldrMmJOV05MVFFROXFSQXIxeTBSQnVKL2lZTmV1TFUwd3Z2RHZpU1NtbVVa?=
 =?utf-8?B?KzB2cEE0V1JJZVBkbDMycTRYUEp5V2QrckpKcEgwTE4wQjd3VU9ManNuczJM?=
 =?utf-8?B?SmpyalM2ZGlDS2VMSnkxSXlkcGNmTCtUWXEyZzhHSUFyUWVBSWdjeWZyTXVZ?=
 =?utf-8?B?RkNpWEl0VFl1by9rd1A5dk9TSjNZTlgzcE9GZ3ZjelpUNlNHSCtycUZDRHBx?=
 =?utf-8?B?cW80cGxyM1E0WU9obStaczlWbkJocEZBQjF0aFhjeEw3emZpaHlmZ1I1VEFB?=
 =?utf-8?B?N2FYdkhER0tuOG1DWlpJRnB4WVYzTnVNWnRqZHpMclpzY2N4ZzBHU1dRQ3N1?=
 =?utf-8?B?b3RHbGlseENSTW9tRGgvVmdXVVpjdWxCNzAySklURmRuREhPMjh3MlN4bjlI?=
 =?utf-8?B?S2lMQ1k3TFZYOFJjRnNad295bkRuaGxUVzdUY2x5cVdhZ1lVSEZOR28vREpj?=
 =?utf-8?B?M1FaZTErSERaL0FuVkxNcEFWSFU0SmRES1dWL0lrNlREVlp5R2FiMDFnY0xa?=
 =?utf-8?B?MVNCTDhnU2hocjZCR09DM0pyVDBFUTJZT1oyYWR1U1NFVUdNSlFWYkhKRUJM?=
 =?utf-8?B?SDJjVVA2c1h5VEdTL0ZZWHk0THFYUC9LMFRjZ3I2dnNRSksyb1JHaU82b1Mx?=
 =?utf-8?B?ekkxV2RXb1RDSHZlQzlzV1lQZlcwUmFLclJIYUc3VFE0TG96STZwU0NzcXQz?=
 =?utf-8?B?a0V0WlA2clB3QkZkSjVUZUR2OVdmeURpTzBvbHhPME9qMm1KVVlrZXp6R2s2?=
 =?utf-8?B?aWtLMUZ2SmIyWS96ZGV0NnhtaTVwZzYvRFB4em1EYzZPYnBDYjc3NnlnWjlL?=
 =?utf-8?B?S2VmY0x5QVg1ck5mTUFBVDhYalR2aFRnQVQvdTVycUR1ZXFVdk1rTUp4OFZG?=
 =?utf-8?B?YmlxZ3Rqc3VwaStJV2lxcmFSTjR5ZzlXM2hNVVNpZmI2WjJUYVNVdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: h5+OS/rxRxBpcquTYYAYp9cRsyCtTOoCrVzeQR2nXLIYNyXrb7mpxvqqJue2HRLrP0VOkmTeKss/z3+uO2X0EdXnmexn0KqbiMmPjHGXbiMtopw9+YKIjhnAWCmVjIiHpLLULvI+ccZZWoEKeGqvL4Na+/athQ5oh9GBDw0p/PCGSkyLMWq0J70BgFXpHSYYGL32Ss3LFZpCPegOyJmWQgtx9yXryN53BHpuJS8ez7jm0SokvIXzVFI48EMfVx1cGfnLgaz944lrNYx0pi2h31SyL+VslttOd1KvrrJ27I2tlibhRoxGyRtTeuHI2KXSUgkFbYUowjPSrQCVnKeOyw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3690.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ff99d5e-6387-4f50-b4ea-08decc4138d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2026 07:22:43.1391
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KFr1qWUoNgnj2R3U4Ky6bwTS8bKHf8HhAGX4V8RfAZFhNHjqNVPB9wmda15GDVB+W/wIAnykc9vXdl3gxoS6hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB8987
X-OriginatorOrg: intel.com

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBGcmlk
YXksIEp1bmUgMTIsIDIwMjYgMTA6MTcgUE0NCj4gDQo+IE9uIDYvNC8yMDI2IDE6MTUgUE0sIEtl
dmluIFRpYW4gd3JvdGU6DQo+ID4gICAvKg0KPiA+IC0gKiBzZXQgdG8gMSB0byBwYW5pYyBrZXJu
ZWwgaWYgY2FuJ3Qgc3VjY2Vzc2Z1bGx5IGVuYWJsZSBWVC1kDQo+ID4gKyAqIHNldCB0byAxIHRv
IGF2b2lkIGtlcm5lbCBwYW5pYyBpZiBjYW4ndCBzdWNjZXNzZnVsbHkgZW5hYmxlIFZULWQNCj4g
PiAgICAqICh1c2VkIHdoZW4ga2VybmVsIGlzIGxhdW5jaGVkIHcvIFRYVCkNCj4gPiAgICAqLw0K
PiANCj4gSXQgbWlnaHQgYmUgY2xlYW5lciB0byByZXBsYWNlIGl0IGVudGlyZWx5IHdpdGggYSBu
ZXcgY29tbWVudC4gRm9yDQo+IGV4YW1wbGU6DQo+IA0KPiAvKg0KPiAgICogU2tpcCBmb3JjaW5n
IGlvbW11IGVuYWJsZW1lbnQgYW5kIGF2b2lkIHRib290LXJlbGF0ZWQga2VybmVsIHBhbmljcw0K
PiAgICogZHVyaW5nIGluaXRpYWxpemF0aW9uIHdoZW4gc2V0IHRvIDEgKHZpYSBpbnRlbF9pb21t
dT10Ym9vdF9ub2ZvcmNlKS4NCj4gICAqLw0KPiBpbnQgaW50ZWxfaW9tbXVfdGJvb3Rfbm9mb3Jj
ZTsNCg0KKzENCg0KPiA+DQo+ID4gK3N0YXRpYyBpbmxpbmUgYm9vbCBkbWFyX2lzX2ZvcmNlX29u
KHZvaWQpDQo+ID4gK3sNCj4gPiArCXJldHVybiBkbWFyX3N0YXRlID09IERNQVJfRU5BQkxFRF9G
T1JDRTsNCj4gPiArfQ0KPiANCj4gVGhpcyBoZWxwZXIgaXMgb25seSBtZWFuaW5nZnVsIGFmdGVy
DQo+IA0KPiB0Ym9vdF9mb3JjZV9pb21tdSgpOw0KPiBwbGF0Zm9ybV9vcHRpbl9mb3JjZV9pb21t
dSgpOw0KPiANCj4gaGF2ZSBiZWVuIGNhbGxlZC4gSXQgd291bGQgYmUgYmV0dGVyIHRvIGFkZCBh
IGJyaWVmIGNvbW1lbnQgYWJvdXQgdGhpcz8NCj4gDQoNCklNSE8gaXQncyBvYnZpb3VzLiBUaGUg
Y2FsbGVycyBvZiB0aGlzIGhlbHBlciBhcmUgbGltaXRlZCBhbmQgd2VsbCBzcG90dGVkLg0K
