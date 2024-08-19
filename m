Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB1A15AAB1
	for <iommu@lists.linux.dev>; Mon, 19 Aug 2024 07:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724054066; cv=fail; b=l8YbeXhcfnejTQaCYZudpcbPSGgWHc48gntF9r8f3+Zauom//a6qt7dJeAfOQnXzu+p1sfvqTMhNPYFT5IZOdpeZws/JYoPiNZUbHifdwmdKssVSy0L+HsuBa1EkbfeHgvqAXzP+lRR82gViUl6twGwLN5yk1d634qBx98uE27c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724054066; c=relaxed/simple;
	bh=ROR+LLRyBoIdDyp0dT8TkUbzzqYuQ17DCGxJIUreTiw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=k48iLCH+v2Pgnnldmwl2XU8D/L08gpzjyj8UaOfIg7jDQQpdEKB9r7SUJozBNGPw7Ai6ZDVxq2wrg6V4aIQDmxCq8/NsRbCCa32jZG9iqvTAvdll+DQrmUO6KWnrDmpFYdvHOKrNHuqXX+GtJKpBKLl3+v91B3WJR5HkOFKxPI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BzZAAw1s; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BzZAAw1s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724054064; x=1755590064;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ROR+LLRyBoIdDyp0dT8TkUbzzqYuQ17DCGxJIUreTiw=;
  b=BzZAAw1sc6ZXF7JtHka54OKAwksKE9LbM3i+PUqIECxVvGgUToAREE1o
   9egsZ+d4Mjc2Ji+bf9+/Mck3jQtedokKqKNidqKQQPMwyBylkxp7UEKBK
   dgKk2J2ujvMjN67V3A/EkAtvveUsmtvYcJQcdAom7VxV6SPgpI7FLBfbL
   GnD2wCNDYO3ncZLRQFBVDJnIVvPO15zZOw0rPdrWzDrIku6spyqU/byxu
   ii8+tKUXVwlaovrP0EC54rxBINmlO+Aicis/YnttNAuN/kQLZvz/ruU0J
   xE3EvIo6xQriZ1Zfqs2zC4p89p5xAEiEBTLTamAgeo84nDhsXtqIEMYoW
   w==;
X-CSE-ConnectionGUID: E3XDnkERT4WCRcd4ozYzsg==
X-CSE-MsgGUID: 76PoFOeWRAOWKPmptW8kBg==
X-IronPort-AV: E=McAfee;i="6700,10204,11168"; a="33436624"
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="33436624"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 00:54:23 -0700
X-CSE-ConnectionGUID: V7vOP9RrRHe1ntcxF5moEg==
X-CSE-MsgGUID: rNHsCCahTyKAQHlE9A9PZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="91035107"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Aug 2024 00:54:23 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 19 Aug 2024 00:54:22 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 19 Aug 2024 00:54:22 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 19 Aug 2024 00:54:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=paXhB/HfTQUVAxR+umKipvNxAvHZu1fJT4wD5s7rPV0uhQY+WD48ugwWQak61JVpvZ9gTfouMVRaPP1ymTtD4xuHDKx0J8/kwt6kXiXpnF2rf6guRj3FAvl4cJwRdf5FfEDF3qDdmYWEvcvIHxuxzAGXYqsnLk1gXl0HX04mkNv9HDKHtmSPo4RsvumukMG8E2DwRQeRtJkQNcEU60h/qKoC6Mhyd9nGTiI1Kq4a8qVi9L/P2yTiRc2Gwj6gzUZHjGT7XpkpcibKoyHRGA7xnDaS9PyaYe4jtel4lCrk58ylKfKfLsG2SeMPsoUthpkIT5EqRIe5LOvMjFuk1aUsbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p7RGLaZpLwgGO7poMoVlCRzQcYhwoc84zRr+naEAbkI=;
 b=HeoyN/KMzqbojgkgFIfwYLRIP7bt0eqsTaBQw/bnwbOwOxxAdODKObfLPw3LDIfH6XGS5iaoVOp6VvS5ERqJnYgY3nGG8sTIEXH16Z4WrXPZ2Un0RZS6THMA0Du3fWZ2g9OJPCL3aW4MIgomww5mnV6vd4PNKEE0b9SNYFne58So8SwKr/rlxUs2xdr8PROwEW7bhsALVHVwJIdXuPNya4c+g3f07z/KW5+JoVcgzGdyptzdw9jpbqhhGrp7QRaAUcYWEs9M7tuX/HsLOq0GFuoifEID4l2+Z2eq0y/DzAA1NwAa6CC1nlBsoVEpEANvEeg+IXo018wsDPpDxUpt4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by MW4PR11MB5872.namprd11.prod.outlook.com (2603:10b6:303:169::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 07:54:19 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 07:54:19 +0000
Message-ID: <03553755-6404-4bb3-badf-5091755f36b7@intel.com>
Date: Mon, 19 Aug 2024 15:58:35 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] iommu/vt-d: Introduce batched cache invalidation
To: Baolu Lu <baolu.lu@linux.intel.com>, Jacob Pan
	<jacob.pan@linux.microsoft.com>, Tina Zhang <tina.zhang@intel.com>
CC: Kevin Tian <kevin.tian@intel.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
References: <20240815065221.50328-1-tina.zhang@intel.com>
 <20240815065221.50328-5-tina.zhang@intel.com>
 <20240816093846.40dbd623@DESKTOP-0403QTC.>
 <afec1d30-4bb3-4d39-9ff1-eb8ecb26bed3@linux.intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <afec1d30-4bb3-4d39-9ff1-eb8ecb26bed3@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0022.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::9)
 To DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|MW4PR11MB5872:EE_
X-MS-Office365-Filtering-Correlation-Id: a5c9579c-57bd-4274-eaa4-08dcc0242181
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QVpsY0ZieUNZUjJYMnNIVm9tUHByQVM5VHdjUXFCM1lJdnh4SEpxU3NVaks1?=
 =?utf-8?B?em5JcVQwMUJVdU1JMlRnTnoxV0Y4dXZoMndIcWNBQS96eHRzOGM0Sk9DUmtG?=
 =?utf-8?B?c0luSGU5eDZMamc0M2lBdnZYTnVHK2tCaG5XZzQrK1FyeHczekowZit4Zlg3?=
 =?utf-8?B?bzJMT3h1VXExMDlMdVNNMGRJaGs3NU14YnovOU5jbDgvZDdra3VrZkFEUHZl?=
 =?utf-8?B?dUpZSloyWDBTR1k2NmR1YzlEY05acVlwcVVNNVdKK1lVaTNiL2pESE03NEY0?=
 =?utf-8?B?OGxJRStyQ0V3R1dLZGJCeU4wbmIzL1hYUGF4SnUyZk1hUFRlZlhmcTBWMkF3?=
 =?utf-8?B?SzNKOGdRMkUyWmpaTVZLL1BVMzh6ZmllVjRZbGVHektHT0ZGckNlMkI1SHJW?=
 =?utf-8?B?Y1NJU255Z2xhSFhmZDBlUGdDZnRrRkJ5eEZ3MU91OTB0SVQzejFPRlpsaXVF?=
 =?utf-8?B?b1FLQzJsNzdLVE5GMlVCOHdaZGQycTV6VThiM2VBUWVTSzN0VmE3RlNCaGZT?=
 =?utf-8?B?TElTL0kyR1l6bEdNSFE1OU1lVE1veW8zR0VwRGlVNUxUK2lzSHFJK1lQWVBo?=
 =?utf-8?B?SjhPUnA4WnYwKzVHcUx6MmlDWXZScnJPbEhqQW4wb2JhZnJpdWxTU2JFUTJ1?=
 =?utf-8?B?SWx2OXovL09VNWp3Qm53YlQyeFllV25IZHk2cGRWL3B1N2p5aUVYY2FSNDVh?=
 =?utf-8?B?dEhqNlowSHJtMjhJNXBuUVc2cFNQS0RvQjMvZ3pjWVlBOHQ1QXFiSjd3K2Q1?=
 =?utf-8?B?Rzh0LzRFTzdmdURvb2pNSGZ3My91R2lyYm8wUmt5U2E5c0hnSFVVbjIwRTdm?=
 =?utf-8?B?bURtd2g1RDIvRkp5R2RuOFJidTI2b05TUHBBTm1sejVCTnhlcW9za1oyTmVU?=
 =?utf-8?B?WldEWUZlall3L2x2Qldma3M3eUtUY3QvMmVPakxBZ3dXZGZUcWpQZ2c4WWtK?=
 =?utf-8?B?WTEvOVRUVitObEU2dVE1ZnJnb25pU2doR2NIVDFIWVcxUDE0VnJ4WEJ2QU85?=
 =?utf-8?B?aEw3WWpXM0gwaitqd05oTkFsK3Q0MVV0VUJuR3NEVk9teWhVWm8xUUN2T3R3?=
 =?utf-8?B?bDdSSWt6eGs3VXp0SmxSL044YW9WT21XWm44TXFPMTJrL3IreGdBVXZZdDdB?=
 =?utf-8?B?MUtaaEgycGxUUHRiWUllQmhqZkYvSTlQTzhxY0JubFpzQjByK1gxK2NLbkJn?=
 =?utf-8?B?cVpJMUZmVUQySlh4a3BSb1BCUkJpdHNmYmlxbjIzWDRTdVNKODFQWW05OHdr?=
 =?utf-8?B?T0hoWXdqUFNsWVhPZkpubzFTSGRWaGdCMkw1VVlrRDljSVEyNFlBZEp0NG9j?=
 =?utf-8?B?cE9JTnV5VTFuVG8zanhpTit5aGgwNXcwZUpBZ014K3A3c0xMdldTTnhXWlNw?=
 =?utf-8?B?eVRmQThiMzZFOHhIbjRyUFoxc1NCaVFUS0ZKQlBTNzhQOEZHNWFlNVY3WHMy?=
 =?utf-8?B?bTIzRUxIc2dDWW13Um9IenY5OWdpLzRzelI0bmpabFFXZDhCOHZTczRyekhk?=
 =?utf-8?B?dW1RVjZrejFubENINzgyVUpQamltbEVUNEdnZXk2NU1HWVQ1ejRaY202QVVS?=
 =?utf-8?B?QmVidngybU10bnpodVBsMlRQNVNGTWZJQ2dPVXZ6bjN2VTJlQ3E4UURKQy8v?=
 =?utf-8?B?Q1BLU1VpK21DT3MvSG9kcStMbE1aUHg4blkxYjk5WmUyWEFDZ2l6cm1veUJq?=
 =?utf-8?B?SEkzSkRPU0pxZVJkYkx2RkErRklhazlKT21QOVNORkovSTJLSElCMVJGNTFn?=
 =?utf-8?B?N3ZhWUYyQmdkTGdlUW1OTjZVR2p2WStod25oQlZSVkp1RHNFU3pncVdJYW5Z?=
 =?utf-8?B?WlhWRE1OL1VvaUZ5MVNvUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUt1WGZzRzB0c0FHaDZ4REh4RnNDRllUOXhJY0tURnp3QVN5ZTF2dVRxcXNE?=
 =?utf-8?B?WjY3dnhicnpKOWo5Ui90Q3Brd29vYTFiRC9QUzFQb3RyM2xNQ1YxT1lyc1hU?=
 =?utf-8?B?aGFuWGNKOTIzZjMrMGFDTHcxbHMvQlBQbzF0Z080QUlHU1RWeDUzZ240THBx?=
 =?utf-8?B?T2Q2aXhMVVN2Mmd0K2FxcGVHUjJid0hTem5xc0ZmNGdqZzNBOW43VnlUY0hv?=
 =?utf-8?B?VFozYjc3TW5RSzl3cEx2Sno2SmNqcEJ3OEVMYXYvbHVJM2VrSEpIWWQ1S1ZD?=
 =?utf-8?B?OXFZVmZuYXpOd1haK2RvSm5xalR3d0MwVVNOU2duZnlvS2wwSjdtQU1MbnNX?=
 =?utf-8?B?RDUxVk9yRXBSdmFqSDcvWlR6NzUrU0Q3TDdxbXNSMDAzSmhCUVo2MzZXUDdQ?=
 =?utf-8?B?SmFlYkg5bHpMQXV1aU9jS1M0QUN1OStFeElBaEJxdXZSWlhSMytzbXBSSHVw?=
 =?utf-8?B?Qm4rNUdKWHhoWTB1OEZUSGZIL3dKaGFUazQ3NEppbmhzUHlNbS9KbVRWT0l2?=
 =?utf-8?B?ZEQ5dTBOdjUyYTJqTzB6SkNUaGJmcU95S2tpMEszNW5NS2dzQ29QQ2RBQnpt?=
 =?utf-8?B?cTBrY2hlWHJEZnh4dEx4MXVuRGVUYnBPSkhsS0Y5ODc1Sk1ON1JCNTYzcHpv?=
 =?utf-8?B?RXVra0lsZG0zei8zYllyeUl0TkpQODVtZDdIVUNkelFLUWZRVWV6Ymk5T2Nz?=
 =?utf-8?B?TTdyWHZTdjUxM2c2cE9NTkx4RU5VWmhVZDR4WnhyL20vNkxKb3k1S2FkRWFY?=
 =?utf-8?B?Vll3K1l4UE1nQnM4dHRYaFB4ekhBOFZ5Zlc3eGRrVm1MZ1JZUnRncEtsRisv?=
 =?utf-8?B?RFlZVUlNNDVwZU9qc010MkFRZkxtNzdWc09GL2JlZWJwRSs1YmVvdU5KNEhK?=
 =?utf-8?B?VzdrZ2YvM0Ztekc0V1FIUG9PYVZqV1VtY2V6WjJMK1ArbGx3QTBBbXd6cllm?=
 =?utf-8?B?dHNlcFNqSUxSTVVHWWptUFEzZWZNZVZhSW1id1g5UjR6SGx2bGxlcEpnVTYy?=
 =?utf-8?B?VFhFelR0cE5qaXRCNFRCNnJTVFRJY2wvZWtpcnArMm9oalBMS1pCYTZrUksw?=
 =?utf-8?B?YWlyWVhKVGlqcGZPV3E3dGxvS3NRMXN6amRCVkFhZXVnclhNT3lpQnlkaDBi?=
 =?utf-8?B?RUV5V1RGUFZmM3YrWmxpak1hS1Fsemk3R1lYWlpGZUZzMlRzK2FqWkVWaWZF?=
 =?utf-8?B?Y0ZPR0tqVGJpcWZPN1dWY2hKMEtmY1BneGxzRWhpUS8rVDh6OVFVMzdaa1hh?=
 =?utf-8?B?dW1VY0UzOFhFUWx1QnFrMmJ4Ny9tSDVpdlJSUElLcG9Nd2VZbTliZ3k0anhm?=
 =?utf-8?B?OFY5ekFvUi9ZbHpLMW5qNzl5NHBralF5VUdKRk5tRjMzVlRIeHh5VXVkd2Iw?=
 =?utf-8?B?TTNGWmVwTWx0ZlhZa0dqd01KRVFmZlJZU0dkd1BEYWNuZEJJd3FzNnVIVDVn?=
 =?utf-8?B?TWZsQmVNT3VGMS93QnBJa1lnckJJN3l5Zm1qUHYyY3JmbVdxeENMWlBieFRh?=
 =?utf-8?B?UUN4SjRibTVxOFNxN3RsTGxJZjkzbjZkcmR2dHAvWmYwUzdxMXdSWUJUYWRp?=
 =?utf-8?B?VjJpbEtHUnphcXZENldQR1hvWmVpRHhDUjJWSkt0TnVZcXFuZEZsU1N6SldD?=
 =?utf-8?B?Y0hrSTBBNXV2SzJ3NFg3N2FsSE1ILytUckRVUDZMOUdMZDB2bW1TRi9nOWlm?=
 =?utf-8?B?azUwV2YrVXV0VGtkdWdJRW80SCtEQUt5NGo1WHJCUTZSdThVV1RGVTY0ekFE?=
 =?utf-8?B?N1p2NEI5dVpkMnJjVENNSVdzaVBsQWI4Q1IyMDJlcWU0Q2JnT3A3c1VNMkMr?=
 =?utf-8?B?NzQ2ZC9SZUxQZlpsRHZKRmNtNWlySVU4cTZmMXduQ2g4SUhFeHVxU0VrMzN0?=
 =?utf-8?B?b0JtWHNxMVBnd3ZPRFVMd21QclRobE5wY3pTY3E0VnpZNDlITFJpd3JTYWpj?=
 =?utf-8?B?VGZwT0Z3N1pTMzJzSWUydE5pc1cvcHhHSTBsdG1qRm1jMkpRckhsUWxjMEYv?=
 =?utf-8?B?YjQvWENIcUVGdzRFdTFiQkVuazhSRVZ4MXQyYlN6UE5VeGtmSzRZay9Kd0lY?=
 =?utf-8?B?ejFVV3FqaUtIOWhBdU1EYnNmNVZSWHlCM0VQMzlYc0orMmxCeGlIT29vNzBT?=
 =?utf-8?Q?nCd3oeyN5vN18VC6recnTNDEa?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a5c9579c-57bd-4274-eaa4-08dcc0242181
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 07:54:19.6193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nZjwLa0ciNnjAf1sYKVteAENitu+dGQ+uqwPbrNGqBCgdKEmSO8rDsF6lzg4cFbCPe7CV8knz2ZtDOmaoF9zfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5872
X-OriginatorOrg: intel.com

On 2024/8/17 11:28, Baolu Lu wrote:
> On 2024/8/17 0:38, Jacob Pan wrote:
>> On Thu, 15 Aug 2024 14:52:21 +0800
>> Tina Zhang <tina.zhang@intel.com> wrote:
>>
>>> @@ -270,7 +343,8 @@ static void cache_tag_flush_iotlb(struct
>>> dmar_domain *domain, struct cache_tag * u64 type = DMA_TLB_PSI_FLUSH;
>>>       if (domain->use_first_level) {
>>> -        qi_flush_piotlb(iommu, tag->domain_id, tag->pasid,
>>> addr, pages, ih);
>>> +        qi_batch_add_piotlb(iommu, tag->domain_id,
>>> tag->pasid, addr,
>>> +                    pages, ih, domain->qi_batch);
>>>           return;
>>>       }
>>> @@ -287,7 +361,8 @@ static void cache_tag_flush_iotlb(struct
>>> dmar_domain *domain, struct cache_tag * }
>>>       if (ecap_qis(iommu->ecap))
>>> -        qi_flush_iotlb(iommu, tag->domain_id, addr | ih,
>>> mask, type);
>>> +        qi_batch_add_iotlb(iommu, tag->domain_id, addr | ih,
>>> mask, type,
>>> +                   domain->qi_batch);
>> If I understand this correctly, IOTLB flush maybe deferred until the
>> batch array is full, right? If so, is there a security gap where
>> callers think the mapping is gone after the call returns?
> No. All related caches are flushed before function return. A domain can
> have multiple cache tags. Previously, we sent individual cache
> invalidation requests to hardware. This change combines all necessary
> invalidation requests into a single batch and raise them to hardware
> together to make it more efficient.

Hi Jacob,

Do you mean the configuration that iommu.strict==0? :) As the above
explanation from Baolu, this patch is not for that although it uses
the term "batched". Also, it would reduce the VMExits that due to the
IOTLB/DevTLB invalidation a lot in the virtualization environment.

-- 
Regards,
Yi Liu
