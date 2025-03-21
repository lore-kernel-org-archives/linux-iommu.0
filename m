Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E4E7E1
	for <iommu@lists.linux.dev>; Fri, 21 Mar 2025 00:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742515834; cv=fail; b=TePvkiSVmoExBSvCo5yk657mmzT2Bdae8vjGUiqpFHZAQirmu2+wdgmafVRy61ok3LCJIgGe98Vs+6cYfBxmrHQkS0/djfVdJMR2G8O1zDfSVzAugOmThE7hVPHIpvAYlO7rwPn/jeNJAvWSS91T+fk9jZe9jwcfVUK/nn8x4tM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742515834; c=relaxed/simple;
	bh=uFxG8WVcjN0Qs3ra9fmwy1Cv1YwMjK1PN30ys4AUxWI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=X+KSC3DqcIbHuxNWmdKlyOPhrN9NN4jzyzsjdEDYD3zDwbojvD2RQGd/FxAhq2eDGgH/b3CTaYKw5+/EQUgWL24gnctDyHlYncOF3caXON5FrcQ8gzqKdJb3ee0nKVhn34RzXJIGVs+fxaggnBa0/iTm68yplcAIxaPinSm7CJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XTSBtqhZ; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XTSBtqhZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742515832; x=1774051832;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uFxG8WVcjN0Qs3ra9fmwy1Cv1YwMjK1PN30ys4AUxWI=;
  b=XTSBtqhZn7Q2pL7KMsSCsaZHjycJcKP0LiE5FENbxie3jtU0d565ISNO
   GSQ6AqOyvOvxAgBWNT6fA2kUEbM7v5x4Hjd0IYrD/+u9rsq6LdycQ5jp7
   AaVPWeHzufHOzLFgX9PS33XD1Y1Oh2rG47sw+z7jbb4Z5R9t6zoPDm1al
   Aju0NvIsTDPLp8KF8jx0soNjRE6goLt0T4rnrVOb1Znk10z2g/XHaDvGQ
   E0M4O+c/qsYXgp7fQPMvjE2ib2IdT3TUUrcRyK9I2N3AG+jHpOcwq9anq
   XA8z47/73AyWJijAax6wKRM4SX8mmKQvqc7TI9aGyl/+BvNUnYQjXYM0q
   Q==;
X-CSE-ConnectionGUID: DC5VaKLdTTCKYNCDG4io4g==
X-CSE-MsgGUID: k4OEvlBkSautVpZ7R7xIOA==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="66237338"
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="66237338"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 17:10:31 -0700
X-CSE-ConnectionGUID: NERdtE53QPKf3aaj/Bx9Mw==
X-CSE-MsgGUID: yEgkNvaeQpSwnVc5hFnObg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="123422085"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 17:10:31 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 20 Mar 2025 17:10:30 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 20 Mar 2025 17:10:30 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 20 Mar 2025 17:10:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tfMshlbFbXiMxWO9BNBgpyh3FVrg3vb1FOJD2JfD+82z1O2zKWKH5nuwRTozpiyoXKLxNWHUo3d06KCO3+Cgn30wqc7H95EYLkLmZ77E9qWDtLSjqe/YP+wz7sdgFFuA1uLLkQbZ/r9Tvpydt6OVA0aWJxSyEzXQGjL/UQ8wXJtIa/jBrFfpxr1eBucboRaJ4i3QB+5cPFLVUpWNZtk9HOOtOGgwmW02hu0fX1YBxtpo0IqPHb0RBt+1v3wcW1ZyQrgEzTOUPSN235e2F4cCWus1wjRw/zHqv/SUJRSYFlext4sJS/aIT0UFUyQimQ2deLvAuHkXi7VMbqMnjE6aew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=865+8pvwy26Gx1AmprOpR9JbwtdCmOFFNVndH7ei2IA=;
 b=JD1rWGWlSNJzOEJtS4XvmCWJVXCDOF1I5GsGN7E94VfZprm0hb7JSoeq6uBFnY7XhG3Z9KmZOcnZkLIeKE4BXPBRCjzn5zOVbITOkSGNr3HxmB87tHBlObgYDsy1YV/VHYtq5TFEd5jNMyUTj5w/tFrYCZNtajS22oLngAHp2Uw3luy2JxlZ7qkUWTvu2eU9di8Uw1Hy31FA/v7UDuX4IYcnoS02SPsLpdmF3TeT5q71yYwcovcohLyAVBc5Km2g8y8UOxx3k6Vym+wQeSZl9aaK84QrCVa5hEBo8FFVSfZATA+t2X+X623vTdA9L+UnSw9wwOmmpJI22x5DDlILeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by IA1PR11MB6194.namprd11.prod.outlook.com (2603:10b6:208:3ea::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Fri, 21 Mar
 2025 00:10:27 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.8534.031; Fri, 21 Mar 2025
 00:10:27 +0000
Message-ID: <03b7ee51-bfbb-4912-8c10-3bdf90df582b@intel.com>
Date: Fri, 21 Mar 2025 08:15:55 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 09/18] iommufd/device: Add pasid_attach array to track
 per-PASID attach
To: Nicolin Chen <nicolinc@nvidia.com>
CC: <kevin.tian@intel.com>, <jgg@nvidia.com>, <joro@8bytes.org>,
	<baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>
References: <20250320134744.5777-1-yi.l.liu@intel.com>
 <20250320134744.5777-10-yi.l.liu@intel.com> <Z9xqRS6CHLnPAT2w@Asurada-Nvidia>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <Z9xqRS6CHLnPAT2w@Asurada-Nvidia>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0190.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::11) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|IA1PR11MB6194:EE_
X-MS-Office365-Filtering-Correlation-Id: a3610730-84d6-45ce-0bb1-08dd680cc85a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OElsWW5UTGRWYWE3eEdNbjFHUHA5SE11SThXVkR0dVZRM3dCMkJtRUlDREpn?=
 =?utf-8?B?MDJiQm5WSXd3ajN5dHZ2UWFkb2Yrb0YwZ0h6c1VhbFdXdGxJdW9GMGpvZHZO?=
 =?utf-8?B?K01ibHJLaFF6clBlTEE2NHdBbVFvTmx6UWxRQ0d2ejViTEFndlMyY1RQdXVO?=
 =?utf-8?B?ZlpxbzdyazRZcDE5K1V1VGd6SldEWWoycjRsYStHWjIvTDN6d0w4clBxWWJY?=
 =?utf-8?B?eDJFV3VYRTJqZGp3eGVLSzU4YUNMWnpVZFZtNlUrTFlKa2twRU8rQlB2UVZB?=
 =?utf-8?B?dnI0TU9CZHhoa3U0VDNyckdYTEgrTkdNYkJseGZPN1NrQm5YNHFpQitRZVlX?=
 =?utf-8?B?cmpaM3ZVVnFDRVV5dEdBOHVKUDkvMEEvUHRUSFhNRnZSZGFNMitKU2E3cWxO?=
 =?utf-8?B?dk1XWUtHVmdTWUpGWHJiakdoN3BTR1R1bnVDZXNmc3cwMmVMbGFydld3N2tS?=
 =?utf-8?B?bGZSZ1RRT1FOUS95aFdVOVN2S0t6NEFpRmNpR3dyOGZhdDJiMWxZaEpKWUxZ?=
 =?utf-8?B?QWIwMjljNTVSTTg0eWFVY295TW5zZHhQbW81TFNXdjRZVFJYY1MrME91R0RK?=
 =?utf-8?B?cUFwN1MxT0orSkFrWWw3RUZoRC9uQ2xYQjNLZFVDWUZQUGVPQlF0WHhZeW1Y?=
 =?utf-8?B?Um9OQlU0emxXT0h5NWRBZ1ZvRmZSVzB6cXZSZXJzQ3NXUFN3VGowbzNzOWxZ?=
 =?utf-8?B?NGpQM2lTaGlzdHB6cTlaVWhucUx1anc4SnNESmt6NDVJMlhNbU9QWG9NYUcz?=
 =?utf-8?B?VXhWaHRpRFFFeU1GUlZjaWZHd24zRkM4NkJlamkrSE1PUW1HWlQxRkFheXFP?=
 =?utf-8?B?U2FnVVJnUWpOdmR5cTNOaldoMy9HRXRUcTVBelNLSGZYb3JlNko5WHB0a1JS?=
 =?utf-8?B?b0tJLzhBSDZEZ2FicWJiWkhoY3J6cHVUWC9lY2taZFhsQUtOQ3FRVlA2VFRL?=
 =?utf-8?B?K254alZMdFBTbFIxOUxvNDZXYjQ1eDZtRXhMRmkvSW9nR3BKMndmbzJ2THVr?=
 =?utf-8?B?bHVnb2syMjlWYi8yT3hoTCtNOUE4VTJpN2tjVDFnZGkzNG1ZQzRUa2RPTEhY?=
 =?utf-8?B?RGl2cWdERDdaamZLMXA0WHdJNmp4VFltWWRLdnFxaXhCRCtCWXdpeERUbTFW?=
 =?utf-8?B?SUg3OUYyNVMxZkd4eEozVmNmVEFqZ05ZTHdDYlhmNGJlVGlkVU50QXBVS2lw?=
 =?utf-8?B?NkVyL0JteGNCak5zeDFFR2I5NXFSV3hJb1BlV1J1enM0NVpOL3BkTEJCSjNG?=
 =?utf-8?B?UWFtZ1pmcG1NeW1nc1F3SU8rUVdTaFhpUmp0NStLd2czNnArSG9FaExvNERM?=
 =?utf-8?B?c3ZJeDJZN25EYmY1RFdmaUJYY1VGaTBldVdrWDlRZWN3RktaamNIamtPYkM4?=
 =?utf-8?B?aTRLY0tEeXd2WWMycFlyTnNMclV4QWJqaGIxOWZEajU5YzBndHlvV0pCcGJH?=
 =?utf-8?B?MGEwOFNKK2ZSYTZ4YXA4SUx0SHNiWllJM2R6ck5jbVBoRVlyeUQxZXZCSGxh?=
 =?utf-8?B?VDJpUGkyNVBJYlYwZmVmWCtkWCtlRjgyNEloaExzb1lNUTk0TG1MR2hXMURP?=
 =?utf-8?B?dnNMNEFNcDE0cWRrSGJFMG9NZTRMTFJjS0xGdW9ubDZsL3FzS2cycDNCaVY3?=
 =?utf-8?B?Vm5VMUZHNUR5UUszcXQ3dTkraTlQcFZxbEZabHFXUmh4cXhQbi9ZWVRrbjNk?=
 =?utf-8?B?blRLU0M4bWJoL0pPblFGV0lLOUdIM0dOT3NHRzJvZkM0d3hYZHByeTZWN3E4?=
 =?utf-8?B?bXQrYW5wYVFIb0dOSUpxOUhhNm9ZbjJHZ0gwSTNkRXErVHI1UDdwSUZRbkFS?=
 =?utf-8?Q?+KBGWBmP5hu4EoGkNvNmE4BVL3mJp6oSZ8CmQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnZMTndJeDM1UEpXdWYrd0tMWldyR2x2SUxSV0Z5cWVRd1ZNVmk2bUswby96?=
 =?utf-8?B?Z2NwZ2lLMEw4eFpST2l6UlAyYXJSa3F1ZTVLMTIySzlBQVhFYlZDZ3Y1ZkxJ?=
 =?utf-8?B?NmVYZEJTMldJRnFtVDlNSDlaM00rTEkraHNXQXJsTGNQVG0vc0lRc0xMRlU4?=
 =?utf-8?B?RGxBVVFJZnhiZkxVUUJkT2xVUGV6OTBkQ0dHbjJUWE5oYmlZSUMvMjZNZzRp?=
 =?utf-8?B?TExyRUo2bVdHaUtmdU1OVUVUZW9vUHF6dG9rYmVTb2RMbWVqRVF2K0lOdEIv?=
 =?utf-8?B?dkRNK2pCSG0xcGYvbVlCZTVzVVVvME84Z3hkZk1WVHZwalR5RzRiNHBFUFFZ?=
 =?utf-8?B?bW1sZjVFQ2lQZWNJN3ZFTUlzYUVWZUVnK21OSmFEZHZwUVNXd0xKcnJKbjFv?=
 =?utf-8?B?ZlJicDY3VHJTRlk2a2JkMDdyU1Z6QnhIQjBjWi9mQ1pqcmFRUjcrVk51Mjda?=
 =?utf-8?B?M3FxV0RlRmdrTXVKc2EweEJaTk9yek03U1FvcUMwd2lFdUw4c2JDTlJNVkho?=
 =?utf-8?B?c05hNk9wMU9KbVFtZmx3SkRvUWg0R0JTSjRYWFVZSjd2dmIzYkRuTGZSSFRI?=
 =?utf-8?B?RmpyU0YrcDBvOWFPRlhVblQ3YmFTSENJTXBIYjhZeE1uaWt5Q3Zmb0lEdWZr?=
 =?utf-8?B?NnpWSGRyaFIyc0dWU1F1NjhZSmoyR0dKaXNzN0locWcvY20rOEptSzVGQUdr?=
 =?utf-8?B?Y2dBeEF5QlNCTzEvZFVUbExaSzF1ZW04UG8wMHNQMndRVTdxMHhHOHhodGJX?=
 =?utf-8?B?YS9YZ0w3bGRzUlpOeFdHMmVGV28rVmVVcGdzckpTbVlpVjFoWFQ3NkdaOUh6?=
 =?utf-8?B?Z2xZUnVyQkVObFFDb2NFT3NZWTVTa3NuT0tYcXgrTzdNY1dyOXRvLy9uTWRx?=
 =?utf-8?B?ZVJaWDd0NzhSZkJLTy9CcmlxaFBaR2lXcU1lSENXQ3NLdkFEVGdaRlB0aVRi?=
 =?utf-8?B?UDZDVWZqUkdBQWhLb3UrVVozRmlaUDlEVEFMREcrM01HNFRBUFhTVGIrM3py?=
 =?utf-8?B?L08wbXo3TDZMYnhRT1dGZ0F2ZktRL2tNS0FzVHRkWHZrTG1oWHltZVdDUnYv?=
 =?utf-8?B?Z1YrL2RWNlZGOFlUMzhDc1JDZWw4MXhaNW9JcmdheEVCV2JMdUg5cW1zQXNP?=
 =?utf-8?B?VmxBM24xbThSMytaYWY3Z1Q2aUZjOWF1N2tIRFQxQko5Uk5nT1hQYUtNTGNy?=
 =?utf-8?B?Y3BJU2plR1FuRnVrbTdXbTZkK1JyMHdFYWd4UFp5WFNEM0g4WmlWSW4xVjlJ?=
 =?utf-8?B?VEVQNWpleGJHY3djQVJGemhCRjRiaUtDcVgrVDVyVDdTZnl2SSs2YnBFQkQ2?=
 =?utf-8?B?WkFiUUw4WWdFQ0UyTkEwOTVadE1PMVFtanc2NG5lRE1ta3dKbFZQSWtGK3lY?=
 =?utf-8?B?SFpIUjJmZUpYMlpUcHlFVzNOSDBISldJUzl3a1MvbzVsNTJpdjdkKzJzWi9o?=
 =?utf-8?B?Z25jU2NkTTE1aFljR1hUc3VLcUNaaXQ4RHBrdjcxcXFXK3lUQU9YcTVkUDdI?=
 =?utf-8?B?ei9iNEdTL1duZDFuR2RZWk1teFZIczNySjJYZEhDK3pEN2VNNDlTVnE3UkhP?=
 =?utf-8?B?TVpZWGRlVU0wZHpBaXRrSlNJRVhyQnA3Smh3dFphWVRldVFHVjdlWnh4Q0xD?=
 =?utf-8?B?ZWVPbnpqK3BhQng2RDBQMGFCNTI5NFBmOWNhdzBUdk5ha2lzV09OM3hJY3RX?=
 =?utf-8?B?S01HMlRWVjNoU3BzY2I1QnJyQzlLMllkdG0vbWNvSG9UelJBSE1DdnNyTjhj?=
 =?utf-8?B?ZzExZm9mTk5WLzJMd1hUTGl3V0IxeVRPdDJESjNhaVRySjByem5sTktsMzBp?=
 =?utf-8?B?Y3AvMzREaDVWQmtkQ0NNUXVxdEVIVkZ1K2pIVHArOHlWN01aa3c0NnpWaGJE?=
 =?utf-8?B?N1FUWEhjS3Q2UWhWd2x6VFFFNTR5aHhKaFF6T1JaZjRwa2RXR3dSTi9vQ1oz?=
 =?utf-8?B?UDlrOEtXU2R2Q2w4dnR1QW11T3ovL1F2OVN0UE5FUzF4RjQxUTdOR0VNRkl3?=
 =?utf-8?B?OVlubzBwRTFieUtRaWI0clp3WWQveDBCSzBvMVFFN0RmbnZXL0pDeUVmVlpD?=
 =?utf-8?B?V0w4OFUwWFdrSzlJZzNUOGhjaHRlOEwwazZOckkvZm51TEx1cmZNWW5lWlV1?=
 =?utf-8?Q?nkIyHtIADuNvqvW2izt0YmgIu?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a3610730-84d6-45ce-0bb1-08dd680cc85a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 00:10:26.9807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4/saDaVDVTM89uXsiMl4fiymxpE23d7p4P6hlc8gu83Mo4MIhjcPqoGdrtMAkO2msvePOs9RH4Z4UXtOip2uvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6194
X-OriginatorOrg: intel.com

On 2025/3/21 03:19, Nicolin Chen wrote:
> On Thu, Mar 20, 2025 at 06:47:35AM -0700, Yi Liu wrote:
>> @@ -497,10 +501,13 @@ iommufd_device_attach_reserved_iova(struct iommufd_device *idev,
>>   
>>   /* The device attach/detach/replace helpers for attach_handle */
>>   
>> -/* Check if idev is attached to igroup->hwpt */
>> -static bool iommufd_device_is_attached(struct iommufd_device *idev)
>> +static bool iommufd_device_is_attached(struct iommufd_device *idev,
>> +				       ioasid_t pasid)
>>   {
>> -	return xa_load(&idev->igroup->attach->device_array, idev->obj.id);
>> +	struct iommufd_attach *attach;
>> +
>> +	attach = xa_load(&idev->igroup->pasid_attach, pasid);
>> +	return xa_load(&attach->device_array, idev->obj.id);
> 
> This helper is called in iommufd_device_do_replace() after it does
> xa_cmpxchg() on to the same igroup->pasid_attach?
> 
>>   static int iommufd_hwpt_attach_device(struct iommufd_hw_pagetable *hwpt,
>> @@ -627,19 +634,25 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
>>   
>>   	mutex_lock(&igroup->lock);
>>   
>> -	attach = igroup->attach;
>> +	attach = xa_cmpxchg(&igroup->pasid_attach, pasid, NULL,
>> +			    XA_ZERO_ENTRY, GFP_KERNEL);
>> +	if (xa_is_err(attach)) {
>> +		rc = xa_err(attach);
>> +		goto err_unlock;
>> +	}
>> +
>>   	if (!attach) {
>>   		attach = kzalloc(sizeof(*attach), GFP_KERNEL);
> 
> Since this is attach() and we do xa_cmpxchg() with an "old=NULL",
> should !attach always be true?
> 
>> -	rc = xa_insert(&igroup->attach->device_array, idev->obj.id, XA_ZERO_ENTRY,
>> +	rc = xa_insert(&attach->device_array, idev->obj.id, XA_ZERO_ENTRY,
> 
> Nit: looks like this should have been done in the PATCH-8
> "iommufd/device: Replace device_list with device_array"

aha, yes. we can save one line here in this patch.

-- 
Regards,
Yi Liu
