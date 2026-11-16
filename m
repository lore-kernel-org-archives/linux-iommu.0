Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.21
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794831732;
	b=pfcc4GO66vBzGD2swqt0vG3oE5joGQ8q4WlcNOsQJJQv18W/IkaElI/JWXgNZlwkcHZM
	 B8KF75/LqvkC8vHUQFrTOZLVLvyka1fx8WumY9aKuKh7gVfrLuUFAQBqfMr1Jw2Lo9ZLX
	 nN28zrG6cQRKwDcSI4GxJx+MfugV3ryxG64KSoB+deKbnP2RkcRbY+xfp97DrWfwTWc0F
	 VaAFUbyhECyQe7T0/7/MvF6ckTj9qzzTomdL29MUvlL5+LLSMq1F5ABjbJ3zgesaMKfVI
	 SIZ/3gUXjCDAZde2aCVtjkhDPv/c0DKVWrYcFeDqsB+4G0teQaTC5BR3E8hBFv3MZVQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794831732;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:
	 Subject:To:CC:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=38++Lb8bJf5Lc+l0B40YqRasuGi8mv45+3hhgdT1+Lo=;
	b=UwbJzbwmpE865ctpaGCviVgg5+K3gvB5wS1YxTDb6HLn2In0WNWzedEQUoPmVc5oaU7U
	 LIzk/FzDwgA9dJVoKnywOaQqT1N92EfNjdgBSpTFNn0rG50yknjzXyXOgT8174EFxNFli
	 wAevBm6n96n5u3COa4UtJKgie39uZ6gGMeQAaokZKFOjcfzh4tW8sEqLgjbAl4YWwr+Jj
	 wlT6z6n/aMOrViZQ22d6jG+EpcM56IRMyI168BeV5Buyj1hzXs2wcviwSFz5ai26ajwvR
	 gLNrpLPMHmpUzM7btwGWsqv+pEhvQMUZQh5rPMxQZp0oHk5E16XCDXID60kH/TfUXUg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MB8l5n96;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=YQJesy70;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92696606A323
	for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 12:22:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92696606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MB8l5n96;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=YQJesy70
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794831732; x=1826367732;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/37rQ23KbwRQ3ThFyJWPzMYbcl43B1qK4WLPK7Tw+C8=;
  b=MB8l5n96es+DKLKLXtQDReyKlv518i0GEdvr4QXgDwofV1H49cE58kDL
   QUxDK4/pjEHMN/mBhcYmJ2E/3ZH8/QS7jfUVeKDapckzBGWTdXS3FHp9n
   2Sm5i+7YnAD7XS8HHwzFOl/0X6jA/k3K7EuUMkIP8YqTSnfF9Q31xot9l
   w0QWw2PXfGohBIOZVdqFX9orcpgs6zKKxrZmj9Bpt8nTGy2b+iQMpy8AL
   VtIsRYNspAp8lGL7w9BQHO6XmfR9fvxgsP9E8nZC7iuNEyVH8yW6akWuD
   kRk/erteYy5fxrgk6tmxC3ClhLbx0p97HIijq3llG7KdaoV1aCB5PcCdD
   w==;
X-CSE-ConnectionGUID: MEPH2c/YRbaYZCOF1YdklA==
X-CSE-MsgGUID: FAy/g/gdTYSeNWrgIsLpKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11967"; a="3641029"
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="3641029"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 04:22:11 -0800
X-CSE-ConnectionGUID: +pwTRA2vRAikj9bxnQZPqA==
X-CSE-MsgGUID: B3VajjJJTBqbesQpOuQQxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="9466078"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 04:22:11 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 16 Nov 2026 04:22:10 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 16 Nov 2026 04:22:10 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.30) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 16 Nov 2026 04:22:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FBPaAvn1Zh4sg5bSAcaBoqf7e6HmVTBMl7B57z9aKLF5nZuAiSC03+xibHkP2sv33u2HVPA9kdFIrJm+r6ogjpNNaXY89PbURwQjM7Mh5DqMmnSMgygcdcbLEE3cJjwmuRg/BV3SauGELKfYGvaHwEMpV3+FxVD/ZKh0rnBGXEUgD2z6QgjKSQ7+/bQYQDL+xyYrSKlw+6mlp4InndAYrW3eF6ZrmAsmwL0f9EiWCl1spBMRkeO7QRuy+3Sz3dsBE9cfLXhrglq4msri4jyhqeaR1ZMDpwAKKHb6+qzsdUNv9B6UPhh4VIARfPKaq+9fSAi8TWbubUefPFAlCoOqdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=38++Lb8bJf5Lc+l0B40YqRasuGi8mv45+3hhgdT1+Lo=;
 b=BidRVQ5OWXPdt36CeuJ5bL19Ha3EwMDE5q9Mjiq9jERZEFuAXnXaTXMgG70+BxAvs6xTmnJtPYdmZtuae2luRv8bp0ZvHnQQHO8NL+3EHFajkUDUHNspRn67Zlu6bENK8zRbi65jJaMnzMn5uCvXerZqygOE1B5UjYYpvFXpXSFDvweNOZAvPGXA2PtbsYTYmduRHt2KBcCbBVG4NNWPsiw+5tU1l1l9rkPNXL3160jI0USeo2XsEATcWEhN0BhLfH1rh8uXCo/y2whYCWDdBjuZFXeQ7T5HTX8C1nmHabi5qaR7CZhocnzAk1deyj/uXfDTU6CyOV7YeVYncGjdpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=38++Lb8bJf5Lc+l0B40YqRasuGi8mv45+3hhgdT1+Lo=;
 b=YQJesy70YJY1zKHQ9LvpM5fN/svVh+V5DeiGc6RLs5UeBiPMneAueuP/p79/psygfiyZR8456MlPxTTvmQ+tWsUXydNq+zlL6Hj5OHbq4/bUhG8wf3BaWdJUna69AxyY1HiirFJiuPNyZPnaU1vzKJl7P5j9XXcWIZM/r0m/f+8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8508.namprd11.prod.outlook.com (2603:10b6:408:1b4::8)
 by DM4PR11MB6285.namprd11.prod.outlook.com (2603:10b6:8:a8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 12:21:04 +0000
Received: from LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51]) by LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51%5]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 12:21:04 +0000
Message-ID: <bcb4535b-46f5-42a9-b94d-0fd2a6c29096@intel.com>
Date: Mon, 16 Nov 2026 13:27:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/11] eth: ixgbe: use dma_alloc_coherent_node()
To: Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <m.szyprowski@samsung.com>,
	<robin.murphy@arm.com>, <iommu@lists.linux.dev>, <joro@8bytes.org>,
	<will@kernel.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
References: <20261106184433.761422-1-kuba@kernel.org>
 <20261106184433.761422-8-kuba@kernel.org>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20261106184433.761422-8-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1P194CA0057.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::46) To LV3PR11MB8508.namprd11.prod.outlook.com
 (2603:10b6:408:1b4::8)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8508:EE_|DM4PR11MB6285:EE_
X-MS-Office365-Filtering-Correlation-Id: 15debca2-76c9-4712-5b42-08df43dc1549
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|261026140227099003|261028144727099003|261021135927099003|261021121427099003|261021123027099003|261022105027099003|261102123227099003|4143699003|56012099006|11063799006|10067099003|22082099003|18002099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: Tp41DzrWuVmC6BvHrSJlbb0JYit5O52MEudwy7/jBpFT3vCmZyx66P+eSz9KeExUgKQGG+TZucWj32GpXEYVfgdb6GrGKd2S+pcqWgrhCbGRS0/gmAEoKEUXgQKxeJe8LdP39A87qZvRaaVsd8xQsdQzV5t41ZrTACZO6iXcJTdDw2OpDf/QJ5/XFRIaet+3eqRItA7EfEEw0WAtPMoPCi/pbVtvXBLOM23IXkQk/Mp7J4NCcU4/VGv/vdXIsXqNoPg2QyIjgUBhw/tN3ghYot08McjQOyNzeLhf3Wq5Ifh+vTNgGyUrRikmlXPuYFWtew5sCVJNZdb6jjSWRBKya0T/sTAxcz4zwI+ysveRpmdS8Wy83xEAftl3oGpvjh5BYAlFql+GY7ewgKbUw+JTRRtQ06SmrcnSbPENIkNPE5mKqHfFePGo6Stquu0PurPh3wXnF9osck4D9jjO7Z3HY3dvUWGKWLKTRVVwcZ3l+/hhBWVIfwAmG8OHqugOwCBC1lDvl+EN8Qd3lBaC5pjaiVWom6x0AFjCloNL+VJ/AvpGC5T9KfhWQBGFBphrfVJ1H8TDtrvNCkAFj6nrfyXxFhMViDSJouNaO/0uiD67bVSXqtduqsWu+qYFswwGHvWh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8508.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(261026140227099003)(261028144727099003)(261021135927099003)(261021121427099003)(261021123027099003)(261022105027099003)(261102123227099003)(4143699003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVhMSVA0TG13bHpJWnBOYWcwZGF1NkhJNmRobFpWbGd0eGVlYXkyTldJNmMr?=
 =?utf-8?B?dnBRM2hoNllFWCtQMzJIcngyVEQzK0taelV4MjJzSnNuZC9WbzFxZWo1eDAv?=
 =?utf-8?B?M3JUekwzdEVLS2NGRVNSUVVXZmU3RUR1czM4S3V6Y3gvcXg4ZWZvVnFVTHor?=
 =?utf-8?B?eTgzSHF1ZUJJRVpobE53U2YrTk5ld3ViWDVwdHdoQkhlaVJ6Z3A4UGRJcy9E?=
 =?utf-8?B?OWNsS1hPeTI0V1ZoU0xlMCtMcjkvb2hzY1dVeDhTekVGU2V1SG54dlRmam5P?=
 =?utf-8?B?dk55M013R0JIc1lrRkp1UXBQbTFkTkNmbGl0eVpQbjJyWlZYZTBnQi9zVVd0?=
 =?utf-8?B?Z2lkRkRtanNLNnpxNVMxc0hhR1BzTGFsdnZoRW1QeHFRYzZZa0tOQVRaWlJY?=
 =?utf-8?B?L2l1aUhMcldKQkNHNVJLcTMyZnJxUXYzK3B5bEVlQWhyR0pISDdqRTFLYlpv?=
 =?utf-8?B?YmtKV1ZTdE5mKzh1eWJ0Q1lhQWpvTG01ak5iZTU1Rk9hK1h2VlNxbTA2YlZV?=
 =?utf-8?B?TDFOdnhXVkd2aG9pN0F6ODcveHNKQkFxMEJzQmRBamJseDZkWVpVU0hUMEx5?=
 =?utf-8?B?SEdrd1lSajVyOUtYRExZTmVNQXVHWEx0aHk4bTFRNUJhNFV6Z202cVZEVmoz?=
 =?utf-8?B?M1pKQ1FYUktMaEZrbHJVN0ExUms4NFhhczYydlRGZGxVM2FFMTJVMG85OEQ2?=
 =?utf-8?B?c1hTeFFra0FMb2dSUFNKRnRvZTBMYklSYXBqLzA2emoxeTYxMno4OFZzQWxG?=
 =?utf-8?B?ZWtNdUV5dlpiSEU2NnY1T1ZlTjFTa09WQXhMWXBKNHlTT3RrdUZXYTl3UlVx?=
 =?utf-8?B?V3BoTk14VUhERGZFQ0VIUEZQWERHekZZSmNIN1g2a2NqbGxkclFGZXM1dkZu?=
 =?utf-8?B?cmxjWGFPbFV6S21VWW9rRmJDVzRPZGtnQmVDTHRpdEhNL2N1MlZDQnluYjBM?=
 =?utf-8?B?bGtVUldLKytGNDRhYk96MDJjUGZWRDN5dXRNV1hKVkx3NWhEZUlCK2ZleDBy?=
 =?utf-8?B?MEIvdG0xeGNFeWdRQmhzNk5NUjZ2c3E5YVU3YVFMR2VOMXlVRjBITnFLSjl5?=
 =?utf-8?B?Q2FiSXpxRDMxMXhPb29BWDI5Y3BYUVV5TnBYQzFmTUNmNDFDNnpNZ2g4ZU0z?=
 =?utf-8?B?a2xOQVpSYVpTblg1dG1VL01ORWpZakxHaWVjTWgrZ2Y0QnBrV0ZHaHVwcVU1?=
 =?utf-8?B?NG14b2RoKzlGL21rQ3JHOTA4Z3ZYdlZEQWpUZHNWbFY1SnlxMlB0R0V2dVJv?=
 =?utf-8?B?VjhYMm5WdnJwdHN6UStFaXJBWFdHUkpEcVdmOVFuY05GS2lrZmMrUWxaWTJw?=
 =?utf-8?B?YVpWK3oyOCt0QXllWmMzUkFOU0NzUVhlN1NIS05JRkN4eGhmUDhSV2RVMjNp?=
 =?utf-8?B?QzhabmhFdCs2Nkc0aWJITUZGWFI2NEZ2MGtqMkM3dWxhQStjakt3YlRRSHFY?=
 =?utf-8?B?NGxuRzBGQ2hPejgzaU5GaWhUaS9pdVFzdytIcjlJTGNySDFia0drZWc4aWgw?=
 =?utf-8?B?SS9QRWIwNTE4TytwT1drMUFmL0N3UExQamVxYXpnLytyQmdMTFM2cWF6SDhp?=
 =?utf-8?B?VTNFZk5IbDBWTEk2cmhrZG15cWJEVGIxUUk3TEVCOXdxakJ0bml2ejd2UktR?=
 =?utf-8?B?dkJwT1ZTSHB2YTR6VXRHS1BtZVZUdWtuUU5UU1NhVWt6eC9uODVBRmJScVFr?=
 =?utf-8?B?TzJwcGtYSTc4QXU3S2lEQmY4SkZHZWxDcXZVMW5ETVk2M29VMnVPV1FaMUdo?=
 =?utf-8?B?OVlLUzQwSEJKUE80d3NCaTdiTVpxV1ZYNDdCZStDcU0zdUp6UUJ2Z0JSSlhM?=
 =?utf-8?B?cEs3ZnRtckZPS2MrbUJrdmJjREVGQ0JkOHl5VTYvWUhDZzdEK3ZGb1FaZDhB?=
 =?utf-8?B?d041MjRNL2daUWtpVmxVYmk3bzlVYnptOTVFQm80dm1PamtreGZCS0NUcmJH?=
 =?utf-8?B?eUJ3bS93dDhUYi9NUmlCVXpYRjV0YXFwbXRZSCtrM3czWWxNS1h0Tllya1Ja?=
 =?utf-8?B?bU1CamlLbjlaeHVaZnU4MHc0ejhSVWtoSmk5eXhITHc4clNucTJOVHNVcmU0?=
 =?utf-8?B?eUMvNitNbzNKR0ZiQnAyMGltZVRuZ1BNQnp2b2trcnQ1VFZlSjJmK2V6cnlw?=
 =?utf-8?B?SGxYTkk4RnpySkgrOEpoZ0wwVkVycG1tNnVMT3pmRks2Ry8xcWg2alI3eVcz?=
 =?utf-8?B?RjRPR0JkSEJjbGZkRWlzdldGaFBXajBvRGFyVE9oVGxiT2hWSmM5YjZNS0cr?=
 =?utf-8?B?a0tucGJBVzRTTDZ6WnV0V3RmMXE1VHFGc2FiVVVla1lhQ2d1Ny9ITVNVRE9S?=
 =?utf-8?B?S21LOCszaWZYK1lmaFNiVVRpanBUaE5yUzhDWWlvbkhUUnNSMm1XZnhUbHVO?=
 =?utf-8?Q?yp0Si1feM3/MAid8=3D?=
X-Exchange-RoutingPolicyChecked: Rm4XjkNyOjzDUwFx9z9QUIOo849ENg25bFxAw4FFCoKkuflg0mlz/M4hnBvfFIUy1G6+eEDtmawmVKPuGfU5KY+fqfqlpVWsSkLpeDjeGjQiHDvB3fPXFp7JZ5Z2Cz8iHS9ns8daDWJ2sUq3FdxokgxyVQg8yQs+jqicFJ59g64pjqolgZgSS5kIIq6Kns6kZBl6P1rIgbBcbyEf+CNGjSFJxuAaYzyxsZ6xTqj+KeWjLAov2H9wKUTcMjGW5J1g/mDnQ7D1ul/3H1OwUrl1smoqwjzvbChNspIAUEl+TgrmF0g5BhyVMwtLeEYpMP5uIw3j/xiW+yfG4nr0Lit2dA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 15debca2-76c9-4712-5b42-08df43dc1549
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 12:21:04.0809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ywOZptWIQYNiifbnwVU8IjvJrDMZmDUacViwFkB2JqRdriYhk924iTqkT064LfIXS6vUIv56SWRnUW1G8/IVPmGXrhzYXtP/oMYL7G0kJOU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6285
X-OriginatorOrg: intel.com

On 11/6/26 19:44, Jakub Kicinski wrote:
> Use dma_alloc_coherent_node() to place the descriptor rings on the
> node of the ring's q_vector, instead of temporarily changing the node
> of the device. NUMA_NO_NODE (ring without a q_vector) means no
> preference, same as what set_dev_node(dev, NUMA_NO_NODE) resulted in.
> 
> Reviewed-by: Björn Töpel <bjorn@kernel.org>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

nice!
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

> ---
> v1: no change
> rfc: https://lore.kernel.org/20261027022528.633359-8-kuba@kernel.org
> ---
>   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 20 ++++++-------------
>   1 file changed, 6 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index b9496f0bee13..6458cb2e511e 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> @@ -7083,7 +7083,6 @@ static int ixgbe_sw_init(struct ixgbe_adapter *adapter,
>   int ixgbe_setup_tx_resources(struct ixgbe_ring *tx_ring)
>   {
>   	struct device *dev = tx_ring->dev;
> -	int orig_node = dev_to_node(dev);
>   	int ring_node = NUMA_NO_NODE;
>   	int size;
>   
> @@ -7102,12 +7101,9 @@ int ixgbe_setup_tx_resources(struct ixgbe_ring *tx_ring)
>   	tx_ring->size = tx_ring->count * sizeof(union ixgbe_adv_tx_desc);
>   	tx_ring->size = ALIGN(tx_ring->size, 4096);
>   
> -	set_dev_node(dev, ring_node);
> -	tx_ring->desc = dma_alloc_coherent(dev,
> -					   tx_ring->size,
> -					   &tx_ring->dma,
> -					   GFP_KERNEL);
> -	set_dev_node(dev, orig_node);
> +	tx_ring->desc = dma_alloc_coherent_node(dev, tx_ring->size,
> +						&tx_ring->dma, GFP_KERNEL,
> +						ring_node);
>   	if (!tx_ring->desc)
>   		tx_ring->desc = dma_alloc_coherent(dev, tx_ring->size,
>   						   &tx_ring->dma, GFP_KERNEL);
> @@ -7184,7 +7180,6 @@ int ixgbe_setup_rx_resources(struct ixgbe_adapter *adapter,
>   			     struct ixgbe_ring *rx_ring)
>   {
>   	struct device *dev = rx_ring->dev;
> -	int orig_node = dev_to_node(dev);
>   	int ring_node = NUMA_NO_NODE;
>   	int size;
>   
> @@ -7203,12 +7198,9 @@ int ixgbe_setup_rx_resources(struct ixgbe_adapter *adapter,
>   	rx_ring->size = rx_ring->count * sizeof(union ixgbe_adv_rx_desc);
>   	rx_ring->size = ALIGN(rx_ring->size, 4096);
>   
> -	set_dev_node(dev, ring_node);
> -	rx_ring->desc = dma_alloc_coherent(dev,
> -					   rx_ring->size,
> -					   &rx_ring->dma,
> -					   GFP_KERNEL);
> -	set_dev_node(dev, orig_node);
> +	rx_ring->desc = dma_alloc_coherent_node(dev, rx_ring->size,
> +						&rx_ring->dma, GFP_KERNEL,
> +						ring_node);
>   	if (!rx_ring->desc)
>   		rx_ring->desc = dma_alloc_coherent(dev, rx_ring->size,
>   						   &rx_ring->dma, GFP_KERNEL);

