Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605DD2576
	for <iommu@lists.linux.dev>; Tue, 18 Mar 2025 13:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742304355; cv=fail; b=T//y0XEm8ybFFARaHJa17hrfZzVJVvNZrZPzUgQtppvwMkFRBGF+CoadTs6Og7JxYeQvUZIQzoyQr+KG7Jx5yefeU7gXt54TmzDxBy9FVPeBRbse2fVnQk2UJ5lZG8+A8+4y36KAoP58grZKiZLZyMrVTSqRwB5DxS1pYDKvFGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742304355; c=relaxed/simple;
	bh=Hlvvd+WeZhwB/3Ea6B3fOAHBavskECKklVBPfb5UK+E=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CV6RannohyUhBsJo1Z8JbuoWD/+utWtpNg2GEV3+Q9Ft6JBD5wqlip0wrevawoTaO/kd+1A27VHCLboDwqQ1BSC+XeSUYBFciD7yG3kstGn97FFV9fVgtZYti3nSNqUHV6HIcfXszBCnOitNoBk5BpcwJ38p/JgmVGC/iA1E32o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E7nRg5j2; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E7nRg5j2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742304354; x=1773840354;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Hlvvd+WeZhwB/3Ea6B3fOAHBavskECKklVBPfb5UK+E=;
  b=E7nRg5j2dVlYDBw50up37AyyVgBB1mIrAuiV4U7ge1Pu8guas/N+qlNp
   EZKMBGIRNQJ7XowsWCzGtCwCSDvdQaXhh9OiTXdrBUCvRScLydDKYLYFG
   JY8kYDAGEkCw5S5gp0d53UKl5qUzzGlcyIy8kjrMcLCuWsEXzhJBXyrpj
   9UCZK44PFZqPXu50siCfd2XlzXp8EAA7/bFN3Ns8f3LpHORU680WwD4Y2
   ixzFqqZ90MCpw5iRfgs7O5lOAUYTnHswSgMrHNRocLrAQhVTP648Mkbtd
   8R+szmK6UouRD0AEzr1nsY1opPROFXm+2VJVGK3tTchgXXRC5/EgBrfUg
   A==;
X-CSE-ConnectionGUID: S2swvreuSfalrpRKXKUfug==
X-CSE-MsgGUID: tdQF6HEgQr6kl25Dbx6KyQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="43547720"
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; 
   d="scan'208";a="43547720"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 06:25:42 -0700
X-CSE-ConnectionGUID: ClAEqpl1QRybkoquTcDFrg==
X-CSE-MsgGUID: Xu1QmPHpQSGG8SzJe2xcpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; 
   d="scan'208";a="123198338"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Mar 2025 06:25:31 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 18 Mar 2025 06:25:31 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 18 Mar 2025 06:25:31 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 18 Mar 2025 06:25:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vIBJ4sfIEiNXSVk4UwK6+vJHlotZ2gLHuWiImqUZAudqxgQ9LlVTAREiuPYi3LibFaazzXCA00FsMAFEOqpfhBIvRcjC6z8KBylDKFkdmzU6hHh42evcoZFnl3EtdAoyO3A1HZz6dYrZR3vAiahg0caMaBrOMS7kYccL4gGzJwoX1KI1d630IPqjBNHR3f+RZ+85fWnZ3hSYZp3DrTMb12om86/ixA92hmY2+nMT/ZXKetzHajjwT4LUZEYUTQK3sH99nt85j2dX3ycOu1NcIh5JLNvb1TJuW5gXa1Fg6MVzA6fqjAHDTTaE4+l/Gu1oTIr+GyRuLHzzue3JZ5WgPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z5Xce00vYBlb0Se0btOZFXapqfcAraMj6PuvDpNsF/A=;
 b=v1XBQn21Fckllf0UW4cIVNBzgJY8I1+CUbiFI6nQWoxrxALOwedNuXi+Py2WPAfM8U+fay11ladb9zRNXI8ISdDedy+e+sWx9Gu4mGrNZ+7jApNaTeXo3fM7AIAjZCMQNBrX3wfh+hUAhzK/CgQz/oPz6PlFFLUcXQlBEEn+sqtMGP0iS8cw6eXwp2DLNYMxDE4/hsfiP8gpUtTIY0EA0BNNh7IY9LsYUCLFbZeAM3/Mb33VzG31YJp/0cQi6IreNHjUEa4O1XW32jIla4Nohzgp5W3EU7638h3037uckYYiiSP2Ps8bGjitHDXQQbFFORW1v4XgQRuuAt59nOfsvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by BL3PR11MB6529.namprd11.prod.outlook.com (2603:10b6:208:38c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 18 Mar
 2025 13:25:23 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 13:25:23 +0000
Message-ID: <92df8977-9e5c-4fb5-b8ab-af94f2abccb9@intel.com>
Date: Tue, 18 Mar 2025 21:30:51 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 01/21] iommu: Clear handle->domain in detach
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <joro@8bytes.org>, <baolu.lu@linux.intel.com>,
	<iommu@lists.linux.dev>, <nicolinc@nvidia.com>
References: <20250313123532.103522-1-yi.l.liu@intel.com>
 <20250313123532.103522-2-yi.l.liu@intel.com>
 <20250318114629.GD9311@nvidia.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20250318114629.GD9311@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0046.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::18) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|BL3PR11MB6529:EE_
X-MS-Office365-Filtering-Correlation-Id: 5451173a-6d97-4d72-a67c-08dd66205653
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cis1Uk9PeXlEZ25BZE9RSFVsZGpORDlwSHdvcjltM1RqVEZlYktLam96Qy9T?=
 =?utf-8?B?UzBQUExib1QxK2drd0JhNTVuZTJmMGpXV1JFa1FyVHVqWVdMTVB5QlNwOGU4?=
 =?utf-8?B?WkVkaUFMWFRPcXlYL1I5WnlXOWtsZ095YzdIQ1YzNUFaV1VOMUFadU5FN0Qz?=
 =?utf-8?B?K0pGVkUrYStDbSsvQTlBY2hzY0EyczF5amk1WGNGVVV5MUVNQWFVSk5nR0cz?=
 =?utf-8?B?bThUdHpyVVJreis1YTU2c1FPeFFic3JtcWVLbFBvQ0JRc08wdVhWdzNDalNo?=
 =?utf-8?B?VlZrdnJRbG9TY1Q2ZXdFaVprQlRYcEJUWTdSWjNuY2VTR3RVcDFqOWk1Ylln?=
 =?utf-8?B?OHVsZVZhdnVyczY2NXZ5YlFCeWhlUFVzWEF0YlRTaFFlbmNUVTY2Nzd0dG9F?=
 =?utf-8?B?Q3F4c3JybUs5QnlXbTd5cGdhWnlWem4xTzllcnp3NXBwM2MySXZVQmVMcnRq?=
 =?utf-8?B?bUhzUlBvT2NKZDhXWDdodlhZZmpmMVBaK0s4SDRiN2htM2oxNEFtUmlhSlo0?=
 =?utf-8?B?cUdJTnVraEZpamttdnN4bGh5R3VhZXg3R2ZjbkwyV3d2UkcyRWlLKzFoZGho?=
 =?utf-8?B?YkpLNnQrc1N4QmFqejNTRCtMQ3dpTXRsL0E3cFZDc1JPVHNRRC8xUXUzbWVX?=
 =?utf-8?B?THJMWnU2TkYzSTFQenNlWnNSeUZ4YzNBUUo2czNORWdLTVdaejVOYzFOM3ZK?=
 =?utf-8?B?cTF1MlBTUm1UT2MrVFVtWUNJeUtYYzhvSjJQL0F6WkFmalVSeEpwUmdYRG5a?=
 =?utf-8?B?ZVMvTjRKU0ZmcFRMdSsraXhDZ09oUkJ0anhBb0NMYnd2UWYyZk43UkpFajZ2?=
 =?utf-8?B?VDJ3QlhGTmFSclkrRGJwTi83VC9Lbjk3ekErR1hwTGwzNW10Q1ROWXNGSXNh?=
 =?utf-8?B?bXg0enFEYW5LRXRuZmkwK0ZDQ043dGkwU2tka1RVQWZ0OFpxbHIwTVBaNUNs?=
 =?utf-8?B?UHFXOE1IR3V5V3AyVEZZZmR6MzJxNjcycmZFSEN4T3N5K214VHBVSEZlRTU1?=
 =?utf-8?B?M0ZFVi9JN3hndjBDU0FoWWlFeTIyejR0Z0VRcW04Vm5OZWdvSEthSmxyNG9I?=
 =?utf-8?B?ZVpCRm0ySVNKeVNOQjNVQ1o0bTZSTkswTFFvaU1LV3BIU1RxMGNnWkdDWU5N?=
 =?utf-8?B?MDRjLzZDM0daUXJUTVpHdysyNlIxMkNEeGNvZmZiYXlqdFB1b0dabzFFQXZR?=
 =?utf-8?B?b2pDbVJlTDJsby9qTU5MNDh6Vy93WnArSjhkc2JzSHQ4bUtqQmpCMDN6RFN5?=
 =?utf-8?B?YkVJeHkyZUVneFNMM3NXWENhLzBkUXNxL1Q2WW1IRnBGOEJmSmdaNTdET0w5?=
 =?utf-8?B?SDdNOEc3MTdsaXVORG0yZCticHd1SXl3ekJNWnAwVHVRQ0VWVGVMVTN4NjEy?=
 =?utf-8?B?MGZ1ZWhmUi8yKytEM3hLY3BCMVlxVUpKQ2c3ODhNOWhjaFFIZUxabzRZaGxY?=
 =?utf-8?B?RzVUSjVGVVE5bmdJTjIxZnA4N2FRcFFGUytpeXVpSFFjZ1hhQ29hYmdXZnJj?=
 =?utf-8?B?TUNRTmRmUHozVTg2Qk9ONERwTlhFaVV3b0FmT2hUazJQdzZ6L0EwWkdEMmpi?=
 =?utf-8?B?OXFaTWJVK3VFcGt5Lzk2L09qTWl6bVZpczJlVzZUeU05SHVEVDFwb3NuYVha?=
 =?utf-8?B?aU9IcG9FSDlxY21oNFNTMDdCOGVjZFRBcndZNXgxUWxrNUNmVzBSUXY1aElZ?=
 =?utf-8?B?QStBdmtUUWx6bGVlT1lXbG05aVFxRTFybTVUVDRtVVM4OWRhNWJRemozOHZl?=
 =?utf-8?B?bUdRd0xvNUFKaUVkTXFRbWxpZmIxazB4VGxleW9oakNHTnU3OEVpWjJqdkpr?=
 =?utf-8?B?UytJNkpKa04rZk8xbU9MYTAyODJHNmlwSmZsNnhIMEtpelBHc2dlSk80TjBL?=
 =?utf-8?Q?OpQPWDZKiTP7w?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2N6NnRYVUduN0gydGpBM2Z3SlJaWHZrcnBQVzBtZ3VhSUpTbFIrWm5Ia3hZ?=
 =?utf-8?B?S05IUEw4R3p2UU5hdWRwTCt5OFdnL3NiYTR3VnJCK2NLazVZSjArZDVGVW1H?=
 =?utf-8?B?VFBmMnBjZCtKNWFqY3pHYWtpbmJYWDJsTmhMUWZTbTB3bnNpeTZDZ1NwRFEz?=
 =?utf-8?B?cGhDWkRGTU1rZlpIdU4yb3ZMNTBsQUVhZnBVN2hiSHpzRWtBTnd6UkFDSXl4?=
 =?utf-8?B?Nk1qRXRYMmxtaVRlUXV4NGNIOEJNWDFUYWk1TXJHSm1mWVVnenVXUE1QRDUy?=
 =?utf-8?B?c3lDUURqWEoxeUJUck5JTG5DZjNNZC9teHhlbS9IakdDUFAwR1J1TWNHNzlU?=
 =?utf-8?B?eUY3MzcrZGN4OW9Mclg1QUlwZWRPdkdjdlMwZjBPaGUxajdRanY4TlRlTzQx?=
 =?utf-8?B?U0QydWRJVjhHUjlOemJta3pzb1JTVHM2T0o2a0xXQXJxSjB1YUt2ejVBR1li?=
 =?utf-8?B?b201dm1WREdpSDI1YmRBU2U5T1ZUQXJNMlE4SmIxMWhlNytFRGlMK1hWTnVF?=
 =?utf-8?B?RGtYWnBRL210NVZXNHVpSFZVaVhGVGlQaitTUXpPYU93L0cvdnZ2OVhFOFVS?=
 =?utf-8?B?bXRPTlZPVUlzTmc0SnhNY0R2MkhuZVFSMVpOZXArVjhpeG1wK2dCdUt3THl6?=
 =?utf-8?B?WWtvNUhOVjFLVDBIeTYyNlF6ZVNiM3VIOG1tSk9wbVM1Z2tTMXUydG44SmpV?=
 =?utf-8?B?ZVZ1M24vaFdKZktpK3F1ZTZvTWxGc3JhdlU5ejU4R1M5aUVGOXE3eWVlQita?=
 =?utf-8?B?K1hHcGVoSW9BRWNWNEhQUE9MM3FtRC9USDdUVTgzVnpYNDJJU0xPMExqVHox?=
 =?utf-8?B?aHhQbkZPV2tQak8zNWxVN05LL2dmc1Y2WUhmazIvUHlSdThYcW54WHVWcldH?=
 =?utf-8?B?UXZXVDF5VkVsZU02N01NQXkvSTVmaEo4VFRnaUVTL0QvWGh6d2lpT0ZvOE5B?=
 =?utf-8?B?R2Zrc3Y5Q0E3VDJwVzQrbk5PUHBCSGlUMkVDQlBUUnNKTGhHcjMvZ010K3pm?=
 =?utf-8?B?VTdUdzJqbWpWRFJJM2pBZjB3VVNMNDF1VDJSTXUyM0NhbnhocEZMR2prTkFK?=
 =?utf-8?B?dmRHclZzOGFURTVib0kreW9KTFZCWlFLL2JZWmtIdHY3MUpwcEpSa3hJbW9G?=
 =?utf-8?B?L0pOSHpwZEZCUG4wcTltZVpmWkJSY3c4UHpBZmVSTmNzQTlMYnZlYXZabE83?=
 =?utf-8?B?eXFiZ2xGT1BleDZBMkxXYStJblNrenRkRWdCaHk1OWR4bHZKQUxCVHM1R1Vt?=
 =?utf-8?B?Wk9HdlNqSS90T1RibUg0cngrcmNLOXArNlRnODZBcHh1YUpUcGpOZFZMN2dM?=
 =?utf-8?B?ZTE2a3ZqeFVFaVRIa3VzYWVKS080cHhHZ1dHZVlvQ2xjRXJLNzQ5SmQ3bXNq?=
 =?utf-8?B?R0NTYmhCYi9mTFR4Y3FTRXJDUDJ0UFZnMGhQMWpvMTFEenpIcGQzaTNlbXJo?=
 =?utf-8?B?VTNJUXN2aVdjdmRXbUd1ZlV4aTY5QUpCa1A5ZW5rRlNmMWhOYnIycFJoVHJr?=
 =?utf-8?B?RUZBQ2JMRnFJWG9RNXplek5qNGV1UmxicmRmUXZUb0xxQk9CU3JFcmJDRmEw?=
 =?utf-8?B?ME93T2tKb2oxOFJhSTM1akFoRk0wdDJIeHNCWGpoUEFVbElmZ2I1c1MvRmNO?=
 =?utf-8?B?UDdsZjRIcjlRbjVnRUk5aDI5MEVZbk1EcGVsd0ZuZWIrNjV1S3VBVFBjMWpS?=
 =?utf-8?B?anpjSXgzd2RsLzVWVnlaVGViUi9ySEl3dDlRcTJ4dS9ES3F3a3A3SEN4bHM2?=
 =?utf-8?B?TnlGdVBzL3ZPSnVpNlZKTGRmSVlSVS9BVjhpbDJCTkkwbFJhMk5XVnhLaCtq?=
 =?utf-8?B?ZGdYUkJMMERDUy8xTWtTZzdXZFFrQTdHQWNFbGQ0VCtHVG5ZQlRwRDUvaUh6?=
 =?utf-8?B?bHZPNXdpTlk5WUkzSTRERDh1ZXFrM3J1UUlYWGtFRmdGSmxvNjE4VWU3Sm9M?=
 =?utf-8?B?M2pLZDNiUDJtOE1YSUhGQU9NTHlWdndpa3R1dEdXaWRCTEN3Nmowa3puMzJW?=
 =?utf-8?B?d01mWlpid3dNQjAvd0xZWmo3dUcrNi9vQWZzN1R6bkhWZ0FLckg5N0Q4eXB4?=
 =?utf-8?B?UTU5OC9yWkQwbnBUSVJ2UUdnNlJXUGlJanZ3MVJZbEdPazhPNmNpOW02Qjlm?=
 =?utf-8?Q?QXBBv73DewM0ENcpUllyuZf1z?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5451173a-6d97-4d72-a67c-08dd66205653
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 13:25:23.3433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f+iy723EkgJoAhNsFqqIv5oHvvEAjKyexOqDgSCHkGRAkbUuD7Y5DHb3+htw1rgcsG4EfjW3Q7Jz3Tuk2g2wag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6529
X-OriginatorOrg: intel.com

On 2025/3/18 19:46, Jason Gunthorpe wrote:
> On Thu, Mar 13, 2025 at 05:35:12AM -0700, Yi Liu wrote:
>> The iommu core sets the handle->domain in attach/replace. To be completed,
>> it should clear handle->domain in detach as well to avoid potential side
>> effect if caller reuses a handle.
>>
>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>> ---
>>   drivers/iommu/iommu.c | 18 ++++++++++++++++--
>>   1 file changed, 16 insertions(+), 2 deletions(-)
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> 
>> +	entry = xa_erase(&group->pasid_array, pasid);
>> +	WARN_ON(!entry);
>> +	iommu_pasid_array_entry_clear_handle(entry);
> 
> Though if you have to respin it I'd probably put the WARN_ON inside
> iommu_pasid_array_entry_clear_handle()
> 
> if (WARN_ON(!entry))
>     return;
> 
> Then it doesn't oops the kernel immediately after.

yes. I think at least one more version given the remarks in later patches.

-- 
Regards,
Yi Liu
