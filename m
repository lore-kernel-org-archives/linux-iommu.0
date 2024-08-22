Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7622178372
	for <iommu@lists.linux.dev>; Thu, 22 Aug 2024 11:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724325810; cv=fail; b=OcWAKnfNF/qtV7Rl/Ig4AHGibGiI24z6taTMhBSitalCFEEB0+C9Nlly54SqEXdcAe5KS4+soFtov8cW050rTSCiL+2MwpeHRpqwiAdtnsu7Sw/O5U5buKDDYQEwSR8syOSGqZ7boPnCUQuMafWYJvcqkJA9j8TO+CbC9cv6e7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724325810; c=relaxed/simple;
	bh=uBenGu7QJZumerx6mn31wEBEt96pmC+ighpbHoYtYoM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nxd4LKd9CJNxpCgmCR6W5gtgAzAhN0Wgpl8XlLR5cr8KU0xRfcDtMXjqRlHsFCbiqpbXcolZoXTwTga6PzpUXOuGhALBXdku63rSHiGA6NONeYwniePzag1gVvZnqLo2sGBlMV92smlrz2wvus5M+JHOjLfj32U4BM3j3EtV8Hc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KYh01h87; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KYh01h87"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724325809; x=1755861809;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uBenGu7QJZumerx6mn31wEBEt96pmC+ighpbHoYtYoM=;
  b=KYh01h87D4lIDxBICNix/9Ozb/+MOBxh6v+qRgZhZj54h1+l3y+34suG
   3AXSz8QQYc7WLWXbvJMLhVKvxPaBm822Ow1N5viNv1c6qmE2FVtUquETU
   ORDscFF0lg+gfggcmsPIL58PvXOA4bIc1XCxhqH+aUsMc9nP0dEF4FTx+
   +B1D0PQn5E/CtfYV7nncUzGTtYMAdIt/KxMst6ofLJ3Pz8mh7gtEu2uBB
   Svar/X439I+Mjey5YbJQ3GnNbhAhQZvo+A0N/ortb6sSch59pSv2hn3my
   mZv/5uzpowMj8W/9iiy3p3Vzn2S4wBYrpFDbfbZPhhdp7tniJZaExyk9N
   Q==;
X-CSE-ConnectionGUID: zNTGpTQyRQmAPQmyUrbtHQ==
X-CSE-MsgGUID: YzpRptsSRuWkpJIw+okf+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="33886293"
X-IronPort-AV: E=Sophos;i="6.10,166,1719903600"; 
   d="scan'208";a="33886293"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 04:23:28 -0700
X-CSE-ConnectionGUID: PI9rRw9gSqGEJeS4Fug8+g==
X-CSE-MsgGUID: zciK63CJSJ6IwOnLsyYdnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,166,1719903600"; 
   d="scan'208";a="65752373"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Aug 2024 04:23:28 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 22 Aug 2024 04:23:27 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 22 Aug 2024 04:23:27 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 22 Aug 2024 04:23:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bdiDxry+iwrmo7+jExPPWWF8iBFot2cvXovvtJuJmQTjQXR40lgMtdSN5LrgUxPbmzwyZRc9hCjh/WeOsD1ujL8VxexVcAthGEz6+merCYB9/St16pV/2higAsSKJuGCELjPNzWo4MlBYSpah2HGIQTBFTzuzaihnCalZEbrLpsq9YdOXdrdZkpnC92GOEy0S8jTR1UwmntJiNxvRwQ4mcMrHTgZgKUkaPSVShKcvprGmSWP2eTw6XnUiPlvKQ6lrgQtM8PSBn+j3SnGfTckgUBjMXdtaK/1s4hC4f7D8TnlP0JZjdHvGhRY+4izSke5uVNU9LQkdkCHRjfG2ibW3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h7SS2teSzLqdrHg2oQ25Zz5RcPIfR1E1Vb/ZqO+DPeo=;
 b=U00w/yxaSGVaqh6dIOf8iPRqb84kq9hbrtUAaANiqY+j1oKuCiMWU5RV95p76TF42EZVAEblqBmO9+0IgzO6aI1uhgTrn+4TGeXeAly0uSmYwBxZyM4Tw+zcw8hefDbuMjeq0Bs7JjE5lsmMrUizOyZzO1q+kAUG8a4YMcGMtU1IQIvIYEqQibROUHVt1jx+M4R8aJWGlSHXTqHxNFR4X9lxbqr+T0HIXHr1vUBWVAThqVSjuondyBPyl8k81WuldloRw3aKCJK9fsbq94f6xpSHZZFXnpnTfHv35AfqsoUkYe8qIXJ9L58kQZmtUNMkJ8DycjpT+8IXQun8Ui7QUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by CH0PR11MB8086.namprd11.prod.outlook.com (2603:10b6:610:190::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.16; Thu, 22 Aug
 2024 11:23:24 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.7875.019; Thu, 22 Aug 2024
 11:23:24 +0000
Message-ID: <67436cba-3d05-4528-9519-231b8396ed51@intel.com>
Date: Thu, 22 Aug 2024 19:27:39 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] iommu: Enhance domain allocation code to take
 additional flags
To: Jason Gunthorpe <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
CC: <iommu@lists.linux.dev>, <joro@8bytes.org>, <will@kernel.org>,
	<robin.murphy@arm.com>, <suravee.suthikulpanit@amd.com>,
	<baolu.lu@linux.intel.com>, <kevin.tian@intel.com>
References: <20240821133554.7405-1-vasant.hegde@amd.com>
 <20240821133554.7405-2-vasant.hegde@amd.com>
 <20240821163147.GZ3468552@ziepe.ca>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20240821163147.GZ3468552@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGXP274CA0018.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::30)
 To DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|CH0PR11MB8086:EE_
X-MS-Office365-Filtering-Correlation-Id: 8789d4d7-363f-460f-f194-08dcc29cd5e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eFBwM0hoSndyS0RFMWRxWUVIMEM1ZmhjSHg5OGFwRXhaRkl2S0o5V0JMQnJu?=
 =?utf-8?B?OXVBRVFtTWRZOHhibmh4bnA1Sjh3bXNUUmlNcXJvaTQ3WmkyZGhDazQ1V3dI?=
 =?utf-8?B?Z1BUam9KMFFYL2NsT1B2SU04TGcxNUs2Rm1SaHBQaWQwT3F3V1NLeWlHSHhu?=
 =?utf-8?B?R1NXL0MvOUFlV3pEckV5T0xvdHZyak4yS25najhRNUlJWjBoNkVSZEdDSkNV?=
 =?utf-8?B?Z053NldhaDRRSlVaYkV3aU1WOWh5bmpJTzZrMEtyOE12Um5sK0tjLzhicDZV?=
 =?utf-8?B?UVhEcFphTFhRbDBRbDdIMS8ySjRiWVo2TzJMUTNyenI0RmNmdWMralA0NU91?=
 =?utf-8?B?Mks4cUF6Skl1bndiUmNCRmNQSFI0cmVhTEpvODhTWkptd0hXazlrUzVvR0hE?=
 =?utf-8?B?YTQ5Z0I2Mndyc1lWOXgwQ04yMG1BMkdKNmtSQTFLKzdDc1pGUVJuaWRBWlBh?=
 =?utf-8?B?RmoybVFxQlhoK2VtMlBrYWVidDJZczgzOGJFbmhlei9pRVBDT2NkeG9XWVlH?=
 =?utf-8?B?ME1KZ0l0c0ZucHFCeGlDOG1na3ZuT2gzaFNWR0orRXIvSG1ZQkZ6NXVYQ29m?=
 =?utf-8?B?QVNjSDJ2ZHBqSE5DcTl2bWlFZC9KVDE3VlhKMUNNZkFFazJ1aU9Zd0dYRjl2?=
 =?utf-8?B?enMxWHNxdWVmUHlBeWRaa1JlRlBzRGZqVjJ5NHJzU2hvTE90Mnp3ckVwenNn?=
 =?utf-8?B?bllJY1FEeTN1TUpNUUxnZ01IRUlzU0VBOVMydUZnSXAwanZmb2UxemZidlp5?=
 =?utf-8?B?WUw4VVlrVkFJOW8wUU8wRytySEZQMTNMaExEL2ZNdlNTM0V1ekltMnVQajVG?=
 =?utf-8?B?akJGbFJtWkl0Vy9XOEJhWFZqL0NRRzZiWjU5dnJiRkp6d2p6RFcvcFg5dk1Z?=
 =?utf-8?B?MEczNHY2Q0pETzZMaWMyOUc2T0ZJTHZsQ25Pb09kcmtwc2s1eVR3dVl3cWJk?=
 =?utf-8?B?Nmg1WkxScnVBNGRIRnhnWHBFS21OUVhGYW1kakVnNkNES0tzNFVMaGZBV3lG?=
 =?utf-8?B?NUxENlB5bWVjVWJJdS9PVURPN2R0Z2NSY0xIbGw3NndkR3JpcUp0aStORFo3?=
 =?utf-8?B?c3N3QWxHc3lSVTkxc0ZZQlFERWo5TFM0TkhmRE9VV01kVlJVd2VPZE51QUJn?=
 =?utf-8?B?aFYzWWs0bW83TklHdzQ2UUUwRjMzRnlCL2FNWnAxMWorUWZ0bXR2dU52Qjhl?=
 =?utf-8?B?L2hFSVNLckY1UHorZGZwV3NGUnhLQUV4Y0NmSnVqay8zeC95bTFRU1R6bmo2?=
 =?utf-8?B?TzFKMU5sWjIrTDZBRE9aWnhLQUJzY3JnZmpEZW8vVU1VeCtrWnNRelJhd05N?=
 =?utf-8?B?eTFOak5mcGs0d1NSOURMdVRPaExlTmRrR04rSzBoRmZFb2k5RlRnSlhFY1J4?=
 =?utf-8?B?eHNGN05tQlFWdTJCVnNCN2JZQzUzSDUwaEFUWGNSWFdEZUlabkxNUDI2VDJC?=
 =?utf-8?B?dEdsbUtlaWpTeUZoMGxIUGp5SW9TUlpKeG9ERDB1bE9sY0pzazFuSExKVUdI?=
 =?utf-8?B?bVB6Z2wrUU5FNm1pYUNVbHYrNkcxbFVic3pZQlI2UE9icGZpWXJNNnZPcWY3?=
 =?utf-8?B?ZWNqWmdwc3pxZWhHUlFkeDBZWUpSMERQQzZBM3JNYmp6Q2tueEgzdm9SZkdq?=
 =?utf-8?B?UW5tUnUvMkQyTlNEVEs0bWZwSjhHUHFNN2F5UUhubVo4WFU4dlNnMU9SUDRD?=
 =?utf-8?B?TVp5SUZkZkszZXB5cmFldzBFN000U0Nqai9qQjlaODdobTNMdVFiN3RjejFh?=
 =?utf-8?B?eGhCTG5hWWM5VmFvOG1QeWJEZzJkeHlKV1FmNC8wRmE1OHp1S0VQbHJmb3Qv?=
 =?utf-8?B?SENSSDUrNTRyRkwvSVgxUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekpENjhvK0g0dEk2dC9MSW96SjhGKzQzYkpOV0h1aG8vYVBpY09ZK3Jpa3Zi?=
 =?utf-8?B?TjlYcWx5bU5SYUo0eC80ekVEbVB5UFdpZmJlOVRBc25LV2N4bGRYcUNkaXEx?=
 =?utf-8?B?THZjUmliK2hHY2NDOEIweHBmckl1MUM2a0dsTmpyT2krTjZuVGpIaWw1bXNo?=
 =?utf-8?B?WGM1RDcrK01tN0JXS2lSMmo0QTZjdWxCVDltY24wRXNrY094b3BSSGU1c1Jw?=
 =?utf-8?B?a0dWL0RmelhyZ2RWSTdIQlhQZVdrZUk5ak5MYUNzRVZSWHhqdGNBSHhzeFRK?=
 =?utf-8?B?R2IrSjZEN2xlM05SdHhZUmhrd1E4LzVqbHF1MkRUczYvcGh5SVEybGNzSlg2?=
 =?utf-8?B?WWZBTVJ0NFl0T2twbkQ1bTBLRnRobWxqS0xBUkdTeVBuUGlYMXQ3ckt3NVhK?=
 =?utf-8?B?N0JrU3N0L204eDVoWTI3b3c5L0pwWlBNNE94ZGFCaE1qMVdSVTcvbld5Rk9l?=
 =?utf-8?B?SER1bm5sOVdCMVV0QXlMNzdVMzA5aCswd3hESlZMMUJyK0VTaStOekJ4S28x?=
 =?utf-8?B?Y3JlWnlSK3JIaWd3bzJBTjFOT1hmYnEwaFo0ajBiRUpENHNzVk82MXdDc3Z3?=
 =?utf-8?B?Ukl5RzVtOS9ML2s0NEh1MDNObVhFM1UwKzNGWVJCZFZMSkNCVmFxL0pQYTBv?=
 =?utf-8?B?YktUSmRnTWs4SjMyc2YxVmd3eE5udzhlL01MWVBtblB6WG9Pd1piVElJTWpk?=
 =?utf-8?B?QngrY0pwZlN1WTJndVVWY2JwRHdzRGJrUkVCSnBDT2l3VGlnNFRnMVZBVEtk?=
 =?utf-8?B?MW01R3FmVUhXK1BSRVB3ejNyUWp6Q010TmRBeTFoaldVdkxWRUJxU2dJTHV3?=
 =?utf-8?B?b1pUR3VZMytBamNja1FMaFpJQUxxRXRDcUNWdU9VcURUQjQ4dmFOa0RBcytt?=
 =?utf-8?B?REhvaUFtUUFEOUtZV1JIbzgvZnV2YXZJQXVjamJmT3lLVlY5ZVNjRitUR3dX?=
 =?utf-8?B?MkNVcEN4bU9QYTgzV1pEOHpoNlcweTZzODZrSkhCYlVqV0owaUxoYUVqT1d3?=
 =?utf-8?B?Z2NDZGtDZlV6MG5VYUZBK282c2ZpZ2NDRFVyZTdLYnRYSFFJL1gvMlZGYnds?=
 =?utf-8?B?TkE4UXFLRHBDbmlkNHV1TU1hRVp1cDZVSmNONTZ3NjlxRUpwNVhoZkxHdHVp?=
 =?utf-8?B?c1JoaWNTTDh2Z09qMGl5UGltc0hMcllTYmYvaVR5dTByVnpHQ09WT0JPRSt1?=
 =?utf-8?B?N3Y5RS9qQ295M25zV2Z6dGNKS0NteFhoV3l6dW5YclM2QVdnWG9nS1FKYWpH?=
 =?utf-8?B?bktSSDRlamFGaW9FQ2hkeHl6UXJLQ3lQVndqNk9VYXdkNE9MY2pHS09xSjg2?=
 =?utf-8?B?b1l1bEtKdmZ2Y1h4RUhGbHQ3bzZvU1VPNks5N2VXUk9ocERDaWYyKzhXdU9s?=
 =?utf-8?B?bmp5d2I3dWNramk1Tmk3VHlBVHVNanF2RFVTN3hCV3hoQmt3RFRCcnE4cUZi?=
 =?utf-8?B?MkU3NjB3L05MemdSY2VyaGYxckRpc2lqNnMrQ21lb1QwS1dtLzVBdStNUTg2?=
 =?utf-8?B?VlV1Q0UrVkNVQ0llTHJoN3dGNFh4YWRiOFlHSEtDMm1KcmpORVdMczhtNDlj?=
 =?utf-8?B?TUhsdXdMQnhwV2o4Syt2bGMwYjVwRmlRVzA2VTMxQXh5UXNTY2JSc25jUURi?=
 =?utf-8?B?aFlnb0ZhZmNjMEZDR1NJNFgyUnY1TlQ4V2ZDWVdDRXk5NTNweEsxcExJWDlL?=
 =?utf-8?B?b3V6QjBrbFV3MG54WDE5Ni9KNmJXY2ZBNGh1WnlWaGh0RmtuNlhjcnMrTUpK?=
 =?utf-8?B?UFdoR1FiRFZFa1FDWHJ0QUZCVXdlTGxha1RCcHpONEJ1cXVCTUZ5UUNjM2Rq?=
 =?utf-8?B?VXRabVVKRjRSbVg1bmFRUVhVMVhjcnRQS2t1S1dmaTRwM3JmSmFqYS9oNG1H?=
 =?utf-8?B?QTVGVW9GZ09QUWlQN2VqclFZclZUeWt0VFVyNUNsTk5maGxMMVNudFZEU3Y1?=
 =?utf-8?B?ZWdBLzRNdFJDMFZCeDZ0bGI0ZXRuQ1oyVDhCM2xXTmZJTXluNFI3ZTJOdUV4?=
 =?utf-8?B?bjl5SnpPaGV0czFuem5nYWdQbEpXMUVuZFo1Z3M0ZGNHWUR6RWpiL1RsNlpK?=
 =?utf-8?B?WEtQVEJucVRBMjRLZVBNRTB0endPaEpWR00xR2hRM1dMV3hxWVQ2cVIxOEk1?=
 =?utf-8?Q?trT9y++S/xH6OSDx3X+c9vSWY?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8789d4d7-363f-460f-f194-08dcc29cd5e2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 11:23:24.2022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gse5IBm4k2sBhndfBJNOo2QulO7llDvLH0w98RWISlJRzzxHc+gV2JMJvK8FJ54nNNaLfTY+d2GTza/fMt1yKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8086
X-OriginatorOrg: intel.com

On 2024/8/22 00:31, Jason Gunthorpe wrote:

>> @@ -359,11 +359,17 @@ struct iommu_vfio_ioas {
>>    *                                   enforced on device attachment
>>    * @IOMMU_HWPT_FAULT_ID_VALID: The fault_id field of hwpt allocation data is
>>    *                             valid.
>> + * @IOMMUFD_HWPT_ALLOC_PASID: When the domain is used on a device, with no
>> + *                            PASID, the device will support later attaching
>> + *                            a PASID as well. Some HW requires a specific
>> + *                            domain format on the device to allow PASID to
>> + *                            work.
> 
> Maybe:
> 
>   Requests a domain that can be used with PASID. The domain can be
>   attached to any PASID on the device. Any domain attached to the
>   non-PASID part of the device must also be flaged, otherwise attaching
>   a PASID will blocked.
> 
> Yi will need to add a check that IOMMUFD_HWPT_ALLOC_PASID was
> specified on the RID domain while processing attach on the PASID
> domain.

this means if userspace wants to user pasid on a device, it should allocate
hwpt with this flag, no matter the hwpt is going to be attached to RID or
pasid. is it?

I still have a confusion. Say on AMD, is it a legitimate configuration that
the RID is attached to a domain that uses V1 page table while pasid is
attached to domains that use V2 page table? From architecture p.o.v., it
seems allowed.


-- 
Regards,
Yi Liu
