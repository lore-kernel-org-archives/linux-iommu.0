Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59A61870
	for <iommu@lists.linux.dev>; Mon, 19 Aug 2024 04:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724042818; cv=fail; b=AIPFrhh0rFTCROR3OakND79I+37lsnnyLVOmOostr8fuKtlZcEVvuYTqQcVRCUXvVa+nUN2l7oYJmuj+edK9LugP6ZXB+o2fIRY4PEff+/glbgVTHOG4Vf+tBAQ6wsX0xj5hrQ7k2Y6lGOwRFeH37I6QDmmgCqruQOdeZp7t/mQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724042818; c=relaxed/simple;
	bh=VgNIa69h8E28MOEYKcjDFxnnUkRpTJ+WBqdIteZts38=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QU5MflN4x+lmrIb0sRj04gqa9jDYAHE8owKr3U6wa/YlKJ0CFiR+AFLwK0dq6R/VqHaSRLflKuZ4qguXb3+41kjQtTdcwsn+73kHA3mjm5P9MJXdSw8/MWG4KTYN9B912PrHMlyw9eE6vOQjJbfryldHiUXjHs+1v3oUeQF3Lqo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OMgbSW6V; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OMgbSW6V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724042816; x=1755578816;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VgNIa69h8E28MOEYKcjDFxnnUkRpTJ+WBqdIteZts38=;
  b=OMgbSW6Vtl6ingxoy/lSYJvjqVhSyMqnwSaV0rE5r3KnS6cn8zSb3RuU
   h37WRBh6/ISztw22aLLv41HxoeOB6Rovh7IrTuGbkIdUThOAJMv4iY/P4
   P+lymYinp3kHDA1FCiJrL7lwgu+g+ygCrcjWPo+WvXeW5N19kSbIO7Kw+
   jTx8gOsRJxV2BKNf/keVNR7mHLK9j3mfuMVjMdzhiJxDxD3wN1hPeTlkl
   FG53tXwZEpPUP3S4i1sRFpw7iBhZvqDXYLquVsmujc500R7GmMBZ1dpFV
   UEPjzaRGLMSZszJ8YdbNDOWuBW3GuWJmLfIAVWtSrh0BU6firf9gP4o8W
   g==;
X-CSE-ConnectionGUID: /OCmXlDHStCT7a1bJiVIKw==
X-CSE-MsgGUID: cSRjqEtWT/CqE9XU/t89Dg==
X-IronPort-AV: E=McAfee;i="6700,10204,11168"; a="33678555"
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="33678555"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2024 21:46:56 -0700
X-CSE-ConnectionGUID: +lpKtTcyR3yvVdmHPP3yAQ==
X-CSE-MsgGUID: Yk4CtqXrR6aGAiU3qyPI+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="90989195"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Aug 2024 21:46:56 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 18 Aug 2024 21:46:55 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 18 Aug 2024 21:46:54 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 18 Aug 2024 21:46:54 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.44) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 18 Aug 2024 21:46:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZGeuXrRO3ErUmpHMo0i5Z5rFU4BD/5/rHZvUXxHRsTrb8o8ZsBTZ1Nl1xxcZQhwgiQtBmqQrd4Ah/RxkmNr6P8Ps9izZH3+PJ6QpkgbwCKWRYiT0NJsbUc/vw6J6kHMRBTiVa9bY62KB8fP/JL+oEoK2OjbnC3MvC+3prD/qiaRWbn+tAlTLpJzzBEMjU0BqHv6ttDAo9ZzCX2/Q6rTZSgQQKe5/ABRLUyuvyvpbEOpD3O1ej9zY9KQXx/+nPfVcTp2+792K6ZdC5DNilZFoTF+Uax00fzeX3HMvyhpOio+xYq0DphjFn5j+QJF3ny1LmKFJJVoNf6XSs55NtHdSvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QXSsvBjuCn1TZvLpNeKPnSWG/F83bZ7Tri4Aehr7qa8=;
 b=BoIguldWu8hfD5Sin4l+0Vvj4vEpVARRuV7jKLn+6lqzjvl3hFTw4d/QblLDQ28jsH8/wfQ7HhDHAH/G9XdmjWCEQVIQIH8t5GgQI9ob8gRWyVkhcmyCWpb5P843yt0M8L4REnORnssqYiK72bIXTYFSfLaH7UFMhP1pbQYl8Mw+z/jN/UIFUCN0IkOw3GaiuzoQzXr9Va3bdgkxZDxwOW0ai7YVDifraCB4E9SdAnTnDZh2URXrE+0LX0BfsuJhh/pf76QwrkRj8UzemYcYrsgkHrhiZkPNaClWSI2VAngwOsogQ/BQRbNJjuWHO7SRntxoFNluKcO2UUTd96AjrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by MW4PR11MB6888.namprd11.prod.outlook.com (2603:10b6:303:22d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 04:46:52 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 04:46:52 +0000
Message-ID: <580e0907-cd58-45d3-8ba8-7344e5644354@intel.com>
Date: Mon, 19 Aug 2024 12:51:08 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] iommu/vt-d: Move PCI PASID enablement to probe path
To: Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>
CC: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
References: <20240816104945.97160-1-baolu.lu@linux.intel.com>
 <511f140b-2792-47b0-b366-cbbad6e80239@intel.com>
 <3631c0ca-4c8d-4cef-aa40-13e3acd22123@linux.intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <3631c0ca-4c8d-4cef-aa40-13e3acd22123@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0015.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::18) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|MW4PR11MB6888:EE_
X-MS-Office365-Filtering-Correlation-Id: aabfb3e4-2c6d-4b56-217f-08dcc009f1ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NE5sc3dZdEhmeERzUXQxaC81cnR0UGlEeE9NVkIvdEpYSVZpNHIxMDE1dExC?=
 =?utf-8?B?M2gzd240aFh4TVk1MkNjQVlLVUsvVTNMTStGa1FVZkNqMmxvQzJlcmRqZExp?=
 =?utf-8?B?ZkhxZUh1aUdUejBEV1cwKzdnOVVmcW95S2NjeTBqWFFsdlBiOVg2cWNvWEhB?=
 =?utf-8?B?MXk5czRRK09UKzFJS0k5WjBNQkxtR0pId2RsaEZ2c3I1L1d0d1hESzFjZDFP?=
 =?utf-8?B?Z0JoQW5Da0FmemFOMlNNRlVCS0FYblR2aU04aElGSmhTamVwcnZBV0Vyemdt?=
 =?utf-8?B?eCtVeHZRUXBYVUtrbnFKVWFHSElzdStLaWtnRTU4SXZaeVgzYUx2WEFleGhh?=
 =?utf-8?B?b01QRmZrTk5QMlRxRU8ybnFmZWRZV2ZBL0VZeVh6a0RmQ3JPb3Ryay9lQUdo?=
 =?utf-8?B?amF4OTg2bXM0QVkzVk9GUWVKd2oveStvN0Y0OGhFN28rVVlaVzNwZFltRXJY?=
 =?utf-8?B?UVEzSlFrZlBoSFhBK3dQQUFpUDdQdG04MUw4Q1RnNkh0eHc5ZUZxVklLZ2hZ?=
 =?utf-8?B?R2Zac3JTWTZCQWsxenFhaGxJT2dSa0cwVGswaktDMjdhbUZ0VXV0VVNIWWs0?=
 =?utf-8?B?NFlDU3Jvczl2b0NrY2h0OFduZFk1WUp1VE9Ed3Rvektib3Q4aGFhR3BvSGxk?=
 =?utf-8?B?YUFTZU8xbk1ReFVuNWUwRzd1SDdLMWcrdVpHQzJZWmJnUFhLZU5BVGhZRDB4?=
 =?utf-8?B?K3RzVzl2dG9JbkMvL2RlK0hqVmRuQmtWWWhpSFNuR05qSzZxSTg0NzlodjZn?=
 =?utf-8?B?cVV1MDByQjhRNHNaUG0vaEpSWWFPQTkwQ0RvYndMSFZiK200WG1saVNKNkxn?=
 =?utf-8?B?R0tyWmMwQ2kwU3g2b3BDNnRlakxhTDMzdmJ3MGJZMXNmU0ZDL1FURHU1U1Jz?=
 =?utf-8?B?NTdUYWs3OUdSUXpqUDc1WjlOSDZmaTBOSFdhNlBDeDhJc2FmU1EvT3NvY0kz?=
 =?utf-8?B?S05lajVmMnNyUjZwUWpELzZHNWVQMTRCcjVQQkVTS2N5cnc4M2tSTERxUWln?=
 =?utf-8?B?ZHU0ak5kRUpmSkc1RTdtd0hiVkhPdTMwVUg4eHlPQ1o2UlBHQ1pQbjNyZWpv?=
 =?utf-8?B?d3ExVVorU0ZiUjdsRDRmaTd2RDU0bWRZOE1iUzVHK1dIdFBCSncxbTJFdzEr?=
 =?utf-8?B?WFlKdDIwYzdqRDcxRHlEMDFFSkhDT1IrQzFlYVBnSEVlUHpxeGlBalhJNnIw?=
 =?utf-8?B?UElCNXJjMW1CL1NGS0VhQnBCbThIVkN6ZVFZTW1mNzA5VVpmYmtDRDJUUCtD?=
 =?utf-8?B?VFhJaUVzQmF0QWNyaDREM0NneCtLeWZBN0JQcHpna0JwdEU4QjJXY3RTbHVP?=
 =?utf-8?B?NUlBUXhUbXA1dHFtekRoeVRNWjRTOTRGaTJuZnFYeTdtY1AzdEFjVzY4OXJE?=
 =?utf-8?B?Q0dRV3Bsa2paUDZQZGUzQ2xiN3lDNDkrS0FIQnBWOEF3TlU4ejR0WWxXTElQ?=
 =?utf-8?B?NzJiME92NFVIQmlKeTZyS3pYSitrTHM0UVV5dTVPaFRRZFpGQ0tGZUhGaGxF?=
 =?utf-8?B?U2lsS2JZdUtQV0VSTG9BYU1VcmF1VzZ1UHBDcG5GaTh3YlpETjVUd1JLQU8w?=
 =?utf-8?B?UnBraytQa2ZvOFRVVllhV0hxNnU4T2diMllpeVdtT1hITlRRSTNKaDBwc1di?=
 =?utf-8?B?ODR3Rm1FNHhJT0FPS3NzSEY2YU5QZUtYbDJlaXB4MFNPWjV4dnVJRG1UeHh2?=
 =?utf-8?B?aE9ieXB0UXFHTXMrWUFQUGdsT2E4MnFtVkRrQUU5VkJ5WTNUYWZGaGVZWkln?=
 =?utf-8?B?ZmJyVGhtOXdDZE13YU05M0ZIaXJmQVAyL2hSZk9OR3ZJeWl3Z0dtczhyRGs0?=
 =?utf-8?B?ME81ZjMyZjY4dWxjTDF1Zz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUdFOFJFQ21SOWdoZVJydUphQlJ4NUNpVVlrQkM3eW1UTmVZVzRrMW1CTXNI?=
 =?utf-8?B?ZjU5bXFCUnN4VTZMMGVyQzFFNDZOWnRpOFM5dFhabGg1bUtmQXIrVjJTV1k5?=
 =?utf-8?B?U3o2NkJrQ2JsOEJoZ3VUMnpvdXpFQXJNUzdEYWIyZ1BpMG5ndUZ2ZTloZGlu?=
 =?utf-8?B?d1JqUmJyeTBNN295bXZDeUVwTEo0alhiV0pMVldZOG5mZDB6aEVULytOU1la?=
 =?utf-8?B?RWJ1OVErRi9uWEdkMk82Y0YxYktOSU1IZmJ0Snh6WEN6NWNQM2s1ZlA3RjFy?=
 =?utf-8?B?WEFrMzdkSGNSdTZ5M0Y0VE8vSWhBU1NzNnNVQzRaWUpLTE1FdlVoTUdjZ1RL?=
 =?utf-8?B?ZXpVdkFMOElUczAvZGZhZ3IyNWtNY3F2dGtqQzd2ck1HSjBCNk94R3E0M3oy?=
 =?utf-8?B?M2R0ZFhnUnVYYnBBTUxIb3FQMU1leUdlTjlSZGhYdmM3L3JFVkx6bFRLTi9p?=
 =?utf-8?B?ZWU2Y0YvcEhVNGs3UEFJQmRuSEp5UktRTkpneTBQTmJNNk1OblFlaVo3UVhS?=
 =?utf-8?B?ZlRBSGxmU25wWm9KZzRuaEJra3ZhL2phVTVWZ25JL3RDTlExa0FzMjdFSlkw?=
 =?utf-8?B?aURJQld0TVpZK0hYanlSV2ovejF3cWNMN2hsV0VBMEdZVU9qZnN2RXNGamZX?=
 =?utf-8?B?blpoT3dmTUI5V0lBUDBQOEwyM1EwZFI5RHpOOUNpdFpBQzFYdEtGamRzRG1C?=
 =?utf-8?B?andXZXUrRTJvSXM3WVdDUXl3Wnl3cHFhdWdndTdVUEtzNDl2Z3VzcHg4UWFr?=
 =?utf-8?B?ZVN1L05ubTZuSXA5Mkd1SVF4QlhoUzltTmRQT1liYms0eXkyRmFveG9nODFX?=
 =?utf-8?B?QmpwOWxhQjJ2SUFVcWxSWnhYM0JwRnM4YXc1UzNCRjVJNXNiS1RnV3dBdWpB?=
 =?utf-8?B?Y1BqQU40cDYwVVNxaE9MMnlrYytYbXFPcUptOXR1TUJYOUpBZDhzNDRpL0Fv?=
 =?utf-8?B?OTdoSFJhVGVuYjBIUlBtNHdOQzZTRGlRTnY5d0dNT3JvWURZejdKTHRYNmY5?=
 =?utf-8?B?ZCtRaU5lZjJIaTJJelVYL3krbks4YjNZeDZHdEdPZi9UbUllOWdIUnl0N0pV?=
 =?utf-8?B?YU9wZ0drMG9mclZVcUtmTG1jcllJcWFlNlNkVnc0OE44VGpzNVcyYnVBYUNH?=
 =?utf-8?B?THdSNDJNY3lvYkxmYVZQVDJ1aE44UitlRk5PKzlKNVVzUDlJU3ltSUpiZlRm?=
 =?utf-8?B?bjd3dms4RGtsWWo1QzFBVHkzMEpvMkRoZEdodDJNdXdiQWVDVTdVZkZST01Q?=
 =?utf-8?B?UzF4NFZKZDB4WFo1d0l5K3RySktZSUdXVGlTU3ZVUnN0K1pFSDFSSHAyc0pD?=
 =?utf-8?B?UWF5TXkrSVptYUlRa09aeGxFVkF3SjJJelVqcXk2NkRaeHU4TGxBOXJYcHdi?=
 =?utf-8?B?L3ZHaGFuR3lXRUJhRmZWcVNZaDJnL2Irb293RzNTelpUQjdXalNhWU5CcWpF?=
 =?utf-8?B?MzA1RlRXMjVMQnB1THIvNkFWQytUU2pEdlJPR3BSOTNhQ05teUpZWGVQeHMz?=
 =?utf-8?B?UkZ2NEN1M003aFZFbFNZbjFxVzZzTUoxQmYrbk9DbUtUM3ArNmE2cCs0V2N2?=
 =?utf-8?B?bzhUbk1JZGx1cFpSNjhJSWt2WTgxRDV5VnZDNDYvR2FRQXQ1UEd4Zy95VnZa?=
 =?utf-8?B?ZDVjSEZRWHA3MUNSdEdhaUVqRUNtZHUxczIrZ1pPbUFuUit2SFFUVG9QeUov?=
 =?utf-8?B?U2N5WnZYSGwvQ3plbktyL1hpdUczemcvNHdQSGlOc0lyRnRMeXRzdnNLSTVD?=
 =?utf-8?B?SVZ5SUllQ0ZOcjhWQ1lZL05vNmNDSG5UOXphTTZmUXh6SktUa1RCUXk2ajVo?=
 =?utf-8?B?c1JyZVYxSFZ0WTFlUkVHdjBmUk54Ym5kNm1VTFNJUFdBMHo2Q1dkSlJjUWps?=
 =?utf-8?B?ajR4VG1BUXpOenpHZGcxYVlaTkxzQXE5VUQ3NWxWR0Z0OGdsY2tjU0E4eHpz?=
 =?utf-8?B?dGRFZUhkbWtYTDNQNkRhbUtnNWFMVDFuTktPQXNoTjVWRWMwd01XS08wMEVi?=
 =?utf-8?B?WGxrbCs5U0ZDMmZpd2x0SEtQRXV1eXZBc29rdEJEY2pUcmk5YVY0OWhET3F5?=
 =?utf-8?B?cHpXaUQ3cWVyQlIzRTc4VDJuMzgzT3IrTDhOeitLSWM1Rk9DU2E5VjlBQkd4?=
 =?utf-8?Q?PA2BIw5/XZXVlh4/Ce/TGpWW9?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aabfb3e4-2c6d-4b56-217f-08dcc009f1ac
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 04:46:52.4479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lxqqf3R5fn7JIY37hPdqbleuAIC8zcaYD3SY//y6VUxlNDnRO47X1mUya5V6MkiTCEM8CFyg2/UfXG9/K7Y4OA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6888
X-OriginatorOrg: intel.com

On 2024/8/19 11:34, Baolu Lu wrote:
> On 2024/8/19 11:14, Yi Liu wrote:
>> On 2024/8/16 18:49, Lu Baolu wrote:
>>> Currently, PCI PASID is enabled alongside PCI ATS when an iommu domain is
>>> attached to the device and disabled when the device transitions to block
>>> translation mode. This approach is inappropriate as PCI PASID is a device
>>> feature independent of the type of the attached domain.
>>>
>>> Enable PCI PASID during the IOMMU device probe and disables it during the
>>> release path.
>>>
>>> Suggested-by: Yi Liu <yi.l.liu@intel.com>
>>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>>> ---
>>>   drivers/iommu/intel/iommu.c | 27 +++++++++++++--------------
>>>   1 file changed, 13 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>>> index 9ff8b83c19a3..5a8080c71b04 100644
>>> --- a/drivers/iommu/intel/iommu.c
>>> +++ b/drivers/iommu/intel/iommu.c
>>> @@ -1322,15 +1322,6 @@ static void iommu_enable_pci_caps(struct 
>>> device_domain_info *info)
>>>           return;
>>>       pdev = to_pci_dev(info->dev);
>>> -
>>> -    /* The PCIe spec, in its wisdom, declares that the behaviour of
>>> -       the device if you enable PASID support after ATS support is
>>> -       undefined. So always enable PASID support on devices which
>>> -       have it, even if we can't yet know if we're ever going to
>>> -       use it. */
>>> -    if (info->pasid_supported && !pci_enable_pasid(pdev, 
>>> info->pasid_supported & ~1))
>>> -        info->pasid_enabled = 1;
>>> -
>>>       if (info->ats_supported && pci_ats_page_aligned(pdev) &&
>>>           !pci_enable_ats(pdev, VTD_PAGE_SHIFT)) {
>>>           info->ats_enabled = 1;
>>> @@ -1352,11 +1343,6 @@ static void iommu_disable_pci_caps(struct 
>>> device_domain_info *info)
>>>           info->ats_enabled = 0;
>>>           domain_update_iotlb(info->domain);
>>>       }
>>> -
>>> -    if (info->pasid_enabled) {
>>> -        pci_disable_pasid(pdev);
>>> -        info->pasid_enabled = 0;
>>> -    }
>>>   }
>>>   static void intel_flush_iotlb_all(struct iommu_domain *domain)
>>> @@ -4110,6 +4096,16 @@ static struct iommu_device 
>>> *intel_iommu_probe_device(struct device *dev)
>>>           }
>>>       }
>>> +    /*
>>> +     * The PCIe spec, in its wisdom, declares that the behaviour of the
>>> +     * device is undefined if you enable PASID support after ATS support.
>>> +     * So always enable PASID support on devices which have it, even if
>>> +     * we can't yet know if we're ever going to use it.
>>> +     */
>>> +    if (info->pasid_supported &&
>>> +        !pci_enable_pasid(pdev, info->pasid_supported & ~1))
>>> +        info->pasid_enabled = 1;
>>> +
>>>       intel_iommu_debugfs_create_dev(info);
>>>       return &iommu->iommu;
>>> @@ -4128,6 +4124,9 @@ static void intel_iommu_release_device(struct 
>>> device *dev)
>>>       struct device_domain_info *info = dev_iommu_priv_get(dev);
>>>       struct intel_iommu *iommu = info->iommu;
>>> +    if (info->pasid_enabled)
>>> +        pci_disable_pasid(to_pci_dev(dev));
>>> +
>>
>> would it make sense to move this behind the
>> intel_iommu_debugfs_remove_dev(info)? This seems to mirror the order of the
>> intel_iommu_probe_device(). Or you may set info->pasid_enabled to 0 in case
>> of any code uses it before info is freed if keeping this order. Otherwise,
>> lgtm. thanks for the quick action. 🙂
> 
> The info->pasid_enabled change should not impact the behavior of
> intel_iommu_debugfs_remove_dev(), and I didn't find any issue during my
> test.
> 
> Anyway, to make it more consistent with previous behavior, maybe I could
> move the part where we turn on/off pasid to the end of the probe and the
> start of the release.

yeah, this looks ok. And you may consider to clear info->pasid_enabled
when it's disabled. I guess it does not affect device_rbtree_remove(),
intel_pasid_teardown_sm_context(), intel_pasid_free_table() nor the
intel_iommu_debugfs_remove_dev(), but good to clear it as it to
reflect the status.:)

> Additional change likes below?
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 5a8080c71b04..76b317f1d1de 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -4096,6 +4096,8 @@ static struct iommu_device 
> *intel_iommu_probe_device(struct device *dev)
>                  }
>          }
> 
> +       intel_iommu_debugfs_create_dev(info);
> +
>          /*
>           * The PCIe spec, in its wisdom, declares that the behaviour of the
>           * device is undefined if you enable PASID support after ATS support.
> @@ -4106,8 +4108,6 @@ static struct iommu_device 
> *intel_iommu_probe_device(struct device *dev)
>              !pci_enable_pasid(pdev, info->pasid_supported & ~1))
>                  info->pasid_enabled = 1;
> 
> -       intel_iommu_debugfs_create_dev(info);
> -
>          return &iommu->iommu;
>   free_table:
>          intel_pasid_free_table(dev);
> 
> Thanks,
> baolu

-- 
Regards,
Yi Liu
