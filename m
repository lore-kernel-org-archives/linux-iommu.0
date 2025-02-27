Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0B41A5B8E
	for <iommu@lists.linux.dev>; Thu, 27 Feb 2025 01:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740619167; cv=fail; b=LNY2XhPcUIo4hiRDiWugwlu7XFuhyAqiSOzKrYK/P1+lh8rjRUzM3CJy13iScF0DXSlS7kPLoRygybbKtnf/PE7ln0tEFhcBwp8Fqv5StyJX2txkwD0mEEXKyI0pKkLsPAaX21Y6UC/0kE4Rgi4r83Cy1ijGUYBzUQWgYx+UHb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740619167; c=relaxed/simple;
	bh=V6QYeUhD6OeKGzfAz9onZFyHWCvSZsje1xjz9fYenfM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TCNBoA5o15qBDJ0Tzgzj50RppjqKN0K7VMmTnnHs5IGkqsFg3HRJ/8sTDACZRlZ0pzS7ifUnQf+B6o08fjhw4iXM3c4tnbwIfz1il95UtDrcA1BYG05J3393aV7dV/ZfAMG8K2oiWqtDzQGzM9dOCT201rRuemIo61S7JRfK46M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jzwve6su; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jzwve6su"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740619165; x=1772155165;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=V6QYeUhD6OeKGzfAz9onZFyHWCvSZsje1xjz9fYenfM=;
  b=jzwve6sudkbf4o2GzmlJGnWreIkTUkhKVrBtZRcOj5V3ibspkg6EocT8
   5uh5v3Bs3UCaLTQP8lPd/afRR3TSmliN4uxePCy0Jy9E/uW4UcspRJwaq
   izsVtsR0pE1aH3yE9aFr36e91bBE0D+7LHJG/u7u2tgTrihRRRhELK9Rp
   R444ve/s7vEX3OrUtuK0NmIU5/Zthd/1UCYkk1HTq4v3zoUXttsdcXsfP
   TVUiN9ZsIKXeDoiHEyydcY9+fl9XFG+DBW0qDLwGDJvTWgOp3wzEW4Hex
   ndKTdPYMUMgfkE0vOVoyIcPToU2kjkJWTm3AsCMzDIcWwFK96Pj1OcqVm
   Q==;
X-CSE-ConnectionGUID: OeEIz+LLRqOUim23d2PvvA==
X-CSE-MsgGUID: k8c7rBMRSk6eRaQ1OeR5Hw==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="41746467"
X-IronPort-AV: E=Sophos;i="6.13,318,1732608000"; 
   d="scan'208";a="41746467"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 17:19:23 -0800
X-CSE-ConnectionGUID: WQy5tAWRR1KT6CNmswmv+A==
X-CSE-MsgGUID: HjpuweTTQJChEd8DfQaT/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117377885"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 17:19:22 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 26 Feb 2025 17:19:21 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 26 Feb 2025 17:19:21 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 26 Feb 2025 17:19:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LqWOa6U88QTwFhuHklFJenOixtJf+9aPy5L4xjL3aX4hKAscTNnLiS6ZSAKqLgc+Z1KBsLEBfhgufvH9BjinIAhzJ8jypAAUaC9Ok8E9oZo23Xju0Dzs+/YUcO45sOecF/gIfmw0RXhViaq8macr8DOT5Od4vKdx6IGzQMyjvptHe95WODYXmsZXJl0LVJtIH9zf+3Exio9yZgs87kSYUXaVkQQehLyMesBfePKv294GegRLqJtOM+LUBScwwBGYt+Qwi8i2TS0j8ihr6hRSce4p4wzHKkfkceOAp67+A4TJ5ZSznHb/yiSoJWlde3sFUW8DoASyvxm6hWOPbi1t3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zE9oPoHHG3voNhGAqgVWI6aAaz3qQM0bMJ/Vqaz7mTU=;
 b=Hke1F0Zh16qHmrLhggP2uHmDIhP/B62fzN5ChaCBWJcnHuSAF4Ex0qeSvXPgsDZ/TvUwoM5JyxHs+cpvZLohr9RCMAISYwZsTZLSj0vhmE4mmNfDZi0kkpkGCKKq/TQ136SwqghzYWkBhG2JuCTvLhMGPZT5rF1xCmaIC3MgxLv6cmE93OBjCY78UwNJHFw0hkdgQIZkoPuRKUmHpzvH+FBdUobTne96hMQ9ypFCfCGNx2M2OuoX+OcZ8cssSiuwImomGlTjSsObRrwJc/IMWxLCoFIKvcmGKdLr43En605clKyopjD0cGEhvr/6Pwru4gaMV6FgnaXjjN0j+lwVrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Thu, 27 Feb
 2025 01:18:50 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.8466.016; Thu, 27 Feb 2025
 01:18:50 +0000
Message-ID: <1d64bb68-aa5b-42c2-9fff-fde3aa6d04ff@intel.com>
Date: Thu, 27 Feb 2025 09:24:15 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iommufd/selftest: Add coverage for RID replace
 between handle and non-handle
To: Nicolin Chen <nicolinc@nvidia.com>
CC: <kevin.tian@intel.com>, <jgg@nvidia.com>, <joro@8bytes.org>,
	<baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>
References: <20250226050130.5814-1-yi.l.liu@intel.com>
 <20250226050130.5814-3-yi.l.liu@intel.com> <Z7+OaMOs9nK6bwj9@Asurada-Nvidia>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <Z7+OaMOs9nK6bwj9@Asurada-Nvidia>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0087.apcprd03.prod.outlook.com
 (2603:1096:4:7c::15) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|DS0PR11MB7381:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b041a45-1bc8-41e5-25f9-08dd56ccb10c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b1RPUW9wSGxpUi9GZk95aVdqOENydzBvcFNXeDRueTFQQUgvclF4Q2lyRHJq?=
 =?utf-8?B?THN6S3Jnc2gwUkV5QlhoblRVQ2tsbm1SNkxEYzFZZ05yWFhrdXgzRnNES3l6?=
 =?utf-8?B?Z0g0Y0pZR2tBbmxiVGNnanVyRTd1R2FZNXVXeDdJcjkydVZZcFhER3AwN0FE?=
 =?utf-8?B?VW1OVkZtdmpBRVZZVXMyUmxXUlFWYlNTZG5nMitOdWQva3poNVNRSUthS2VV?=
 =?utf-8?B?dTJIZld3VEd0c0locmtaM0FkZ1ZUdVc3U25TUGRDWXlOL20walF2eElnczl3?=
 =?utf-8?B?OGMwenl5anNGL2krc1RiODhORHZYTzdpU0licWVaVVdXZW5SWmhyV0lqUDVG?=
 =?utf-8?B?OXI0WnV4Z203Wkk3bXUrTGk5TkhOVjlHaUI3UzNac01zQTNIaU5zamxFVVpC?=
 =?utf-8?B?azBjSXRBY2NrS3RmelY0czdSdkEzZGdIS1RXS0NqWWh3ZWkyOVJqOFZ5V0lJ?=
 =?utf-8?B?SUxTNmRaTk5KWmpIUEhzNDFhZUc3b0Z3b1JubkJOYjV4Ris1Q3NjUDR1MzIy?=
 =?utf-8?B?TzBLTXpEWnU2amVHdDN3NUY1YkIxb3FYcUppZU9iQlU0VFNtU3VUVlAyemxK?=
 =?utf-8?B?RkNuQUlvVUVidDRjSWFWVHM1U3RHUVVTcGJHT3lDYkNTTzhwa0V1ZEdHTlpn?=
 =?utf-8?B?MFJEbFZtY1h2cTREWndiZ0h2VFRwNHpwZDBSbVNHN29NTGxKS0JMTUhuY1Q2?=
 =?utf-8?B?V1BWOWMrSStiZnJHbTV1TEJiT1g3TXh4RDBZam00R0kxSmxHOHpNL25MUks0?=
 =?utf-8?B?MkdMVEt3UkwvMmUxMjV6cUFVaFZGTGxZNXNGMTk3RzBQSk5rVjNRNVFDMjdm?=
 =?utf-8?B?NXN4ZmtOenIzdXpXY2VZTy93M0JFQTRWOWo3cWN2bm41aThZWFI0Uk1LeVk4?=
 =?utf-8?B?VGViTGQvdDdHcFdYM1VPdEIvWTVKbWJvdllnTE5IOUlSbjdIWHBRUS9Cekov?=
 =?utf-8?B?bkI3LzArc1ZjL2RhU1E3NHpEdEhINXREU3JPTTZDeTY2Wmg4dTk2eEg5dGdt?=
 =?utf-8?B?dU1CbE1KbU9rQnFhQnQrcHZkeTJSTE5xT0t0UzdjUzVib2JjUzdwRVpwQy9Y?=
 =?utf-8?B?WnVRQklDTUE3eHZCZjdETXVpZTBqOHY1b0NqUHVZQzlOTDhGcDlWMWdQTVFE?=
 =?utf-8?B?bTRQR3Q4YVRqMzdONU5vM1FqeUw0djVodTZVK3NjWHQ4RFdua0pvSVNYdzkx?=
 =?utf-8?B?aldwMTR1cjZiNkcxYklKU29wYTliaEs5MFFyeUFCS0gzWTVhOVMvbENvNUYw?=
 =?utf-8?B?M0RTZVFjSDdNenhZWnUvblVQcmVYOUN1ano1Tml5VXQwRE1LTzAydVgybGVm?=
 =?utf-8?B?dTRxRk1udERzNHVjd3NjdWhaRnZZUjRrbzc5Z2lCUk5MNENXeG9FZTd3N0NZ?=
 =?utf-8?B?a1hqUlNObDdzYVFTVkwxRCt6RDNRL3ZBa3N3YmJhZFVNWFlNcCtmSElYUWZx?=
 =?utf-8?B?c21NcjVnTEExRlpYU2FYSHNCL0RxZlptd0RoRUQ2Z1RMS091YzhPeTk1YkRj?=
 =?utf-8?B?OEt4UnZhV3JWeXJlNVlrNFNNc0dhcCtlODY3L1RvZkJZcG5JZkJqYjFwTjZu?=
 =?utf-8?B?Q3lMelAyWldtV2F2dFc1MGJ1Y1JlUDRRVzN5R0QwdUpmWk00bzA3dllvekJX?=
 =?utf-8?B?QkRHenhlazN5RWVWbUgyOHVNUGY3dmJuN2hRMTMyei9iaDg0V1hZTWNpYVdV?=
 =?utf-8?B?NElxd243dTFyamtWYmJ0ei9MVlQ5S2ZPSGJLckVpb2JQeFZ1ditMRmJUZ3Yr?=
 =?utf-8?B?N0hnMUtyb2tQZmZPZTdzSWFDcnFqcDl3MFF5bXpqVjAzbk81Vnh2Rjc2VEo5?=
 =?utf-8?B?RzJkQ1pteXB1VndzUHJBQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TU1jY08xTnA5b1RTWk8xc2Z5ZFluMTh2U0JQcC91VGV3dXU4S2dyRzYvdGVO?=
 =?utf-8?B?VFVOR2VKUGVoTTRPMXVsQ2YwRHFEcUZDalB1OWQxZ0YxNVJYcDMyQWs4SnZa?=
 =?utf-8?B?VXRzNkNldm5vVXBKUnRmR3JEVU9VL2tML3o3VTBFRFNMQ2RIUXpWSjlBZWM5?=
 =?utf-8?B?VXcxRndPRkM0cDV2anY3T1NWeVhBVDJZV09tY1laMW15eDVQTmxENjRLZmdk?=
 =?utf-8?B?RnhOQlJybVAwTS84aFk2aC96OHlaVXBWSWEvNzVOWHhaZVM3NDIvQTVWYlpS?=
 =?utf-8?B?d0c1bk91TURWTWtTUmNlTnFRL21KNmpyN1piY1VYemh4VDlrOGVsd2hLNzVK?=
 =?utf-8?B?ZlJMZ2FJd1gxZ3daMnBhL0xWWHhXcGNlTGoyRnltQ1R6WlRSQWs3WjMxS3dx?=
 =?utf-8?B?aVJNd0JmMWRvM1BTY3ZkZFhFZWkyWHFISENtTVdjZXRsK1VxcEcwM1F4cGE5?=
 =?utf-8?B?SFdlTkowUVI0ZU1UdXBZRzZ1RUl2ZGMyZlZpL21CTG9EWEhmWHJQR2lPNm9V?=
 =?utf-8?B?bmk1NG1oeEcrR3Jud21KRWl1N0ovYmE4aVFseXR0TVh5bkpKZkZGcnZIOEpt?=
 =?utf-8?B?L255U3BpNWJBNElWOUg0R0NZL3FlSkZrRkYzYko5Zmt1WFZRd3FXNkF5YS9F?=
 =?utf-8?B?TmtObVFQSkJ4S2hXZ3QrSlFyNHlBWktYZHVmRnI4bjM5dGw1dUZYZXp3Kzhn?=
 =?utf-8?B?Mmh4N3JaRS9UdWUreFlOWXlwTVo2dE1DamlwbWdsRXE5RkdxT0xvMTJseXIr?=
 =?utf-8?B?OGRuVG4wMEMzT01tYzhYZFRQajJFdGNCTnJuQzc1cWdOY0tuV21ISUVLSkc0?=
 =?utf-8?B?T2MvU01PSC9XbmxPM29oUWFBRkZDeFJKWkk1cmxoUDduNnVmK0dhdkdCSWdD?=
 =?utf-8?B?VDZQR0x6Qy8xSUtKSmgvbDlGMjd2ZER5eTFZL2JNbXFyN3lNam13a3MyZ3Mx?=
 =?utf-8?B?LzBtakF4czBEd2dyT3BmNURnL2tySjU5dDhFZHBJUTZtMEFsUjdSR25pSHY2?=
 =?utf-8?B?QVZDZzZoTkJiUGRlN1hIS3VUWS9RdXZKTEhLZ3IvUlJrdWtFbDltVU0rQ09P?=
 =?utf-8?B?cTh2TktZTTlqclhaSitlM1k0RUJ4TTF3THYzMDFNVDNTY2tEbzRkeDVtRWVz?=
 =?utf-8?B?SEtQOW1vcThLZy9YL0E1OVMvRno1V3lGWE9OdVk3a1JXVkxJMTh1VFpFNTVD?=
 =?utf-8?B?NU0xS29JanRscWR4TXAxN1FGS0wvbnN6QnZlSGdLYTRWbFM3UVJkYytDcHFV?=
 =?utf-8?B?K3QvZ1FST2tpdUNvOVpFRjBDQzArY2JDTVhHN1gxQlNnOWtFYlAza3lYZGVm?=
 =?utf-8?B?T0ZQOHkrekdRMzVjdU9odUo1b0pLd1AzNW1qMWh2bWxiQ0tKa0NSczRTMitZ?=
 =?utf-8?B?VVR0UExuOTRIOVVsVVRNMEUvek1SRXIvQjhFZ1UzVldKcy95UHhHRzJ2RmRU?=
 =?utf-8?B?M3crcDhaakFwL0xYRTZabnJsU3pDYy90bmFaOVpaZ3pBZm1JcHpmbWZzL3RQ?=
 =?utf-8?B?S0RHelllRGF6VmpSbmhHNzhpajZ3SmdlZXhUUkRQK0FWSyt0RjhmNnZPaHBD?=
 =?utf-8?B?NmtrSkZuRFdWc1FNSHZvMnJzTC9SS1hoOUNaMUtiU2dtSlM0N0t1T2s3d3R6?=
 =?utf-8?B?OXJFYVdxUkROdC9ReXlXZWdmcTdJbGNMamRpZ1hUZHpleWtpV0R5cHRJSVl3?=
 =?utf-8?B?eExuZHo1MklMZnRYcmRiaE41YnhFMHUvR3kySWlqS2RhTW51RjBrUHJXS3Zt?=
 =?utf-8?B?V05PUERpdU5KZnhxditpbmlBeFB5SWozQmMzQ0YrK08reWJYM1NqZldoc3ZM?=
 =?utf-8?B?WTVHd0I5SzV2dkltdFlhanJ4OW5OaU1idHJwbHhLdkdZcGJsUWNEU2IvT3dZ?=
 =?utf-8?B?QVd0b0k1WTl5ZzN2dnVCaXJ5d25jZGVVdGV1Y0tHRCtJaHAyMG16a2hlMFc3?=
 =?utf-8?B?eHNuWStLSCt6Nm1XYzhPdG1ScGJiVmd3b3Btb0g2ZVpGU2dncDBZTmh3c2RK?=
 =?utf-8?B?cWtlN0ZoeXZpbTdrYUVjSHpNUERyTktZQk1lRGVjZ3dzcVVpaWViM01oNTcx?=
 =?utf-8?B?WUpoZll1ZTZzbGdqb3JYb3hRVGNyV3UrT1VRYjNhRlBhd2RZbVAvRTk0aEJT?=
 =?utf-8?Q?zYbFt7Hx0Lwe7RmcJSe2ecGNO?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b041a45-1bc8-41e5-25f9-08dd56ccb10c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 01:18:50.3808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G9WnTqNAlo65/98kEHqL/7x8udLbpuaJfn36SSlIlobMAWfobHA4VCio+vhhlCHFJg78QUwd7fUv3U42FGdvEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7381
X-OriginatorOrg: intel.com

On 2025/2/27 05:58, Nicolin Chen wrote:
> On Tue, Feb 25, 2025 at 09:01:30PM -0800, Yi Liu wrote:
>> The iommu core supports replace between the attach with/without handle,
>> add test to cover it.
>>
>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> [...]
>> +static inline struct iommufd_hw_pagetable *
>> +iommufd_get_hwpt(struct iommufd_ucmd *ucmd, u32 id)
>> +{
>> +	struct iommufd_object *pt_obj;
>> +
>> +	pt_obj = iommufd_get_object(ucmd->ictx, id, IOMMUFD_OBJ_ANY);
>> +	if (IS_ERR(pt_obj))
>> +		return ERR_CAST(pt_obj);
>> +
>> +	if (pt_obj->type != IOMMUFD_OBJ_HWPT_NESTED &&
>> +	    pt_obj->type != IOMMUFD_OBJ_HWPT_PAGING) {
>> +		iommufd_put_object(ucmd->ictx, pt_obj);
>> +		return ERR_PTR(-EINVAL);
>> +	}
>> +
>> +	return container_of(pt_obj, struct iommufd_hw_pagetable, obj);
> 
> Will there be any other caller potentially?

yes. The iommufd pasid series has another selftest op that needs it.

https://lore.kernel.org/linux-iommu/20250226114032.4591-1-yi.l.liu@intel.com/T/#mdea85bdfec37d86fe7275b0944df5d39e1858422

>> +static int iommufd_test_mixed_group_replace(struct iommufd_device *idev,
>> +					    struct iommu_domain *domain)
>> +{
>> +	struct iommu_domain *old_domain = iommu_get_domain_for_dev(idev->dev);
>> +	struct iommu_group *group = idev->igroup->group;
>> +	struct iommu_attach_handle *handle, *old_handle;
>> +	int ret;
>> +
>> +	/*
>> +	 * The test device should have been attached by the _handle API,
>> +	 * hence there should be an entry in the group->pasid_array.
>> +	 */
>> +	old_handle = iommu_attach_handle_get(group, IOMMU_NO_PASID, 0);
>> +	if (IS_ERR(old_handle))
>> +		return PTR_ERR(old_handle);
>> +
>> +	handle = kzalloc(sizeof(*handle), GFP_KERNEL);
>> +	if (!handle)
>> +		return -ENOMEM;
>> +
>> +	mutex_lock(&idev->igroup->lock);
>> +	iommu_detach_group(domain, group);
>> +
>> +	/* attach without handle */
>> +	ret = iommu_attach_group(domain, group);
>> +	if (ret)
>> +		goto out_revert;
>> +
>> +	/* replace with handle should succeed */
>> +	ret = iommu_replace_group_handle(group, domain, handle);
>> +	if (ret)
>> +		goto out_revert;
>> +
>> +	if (iommu_get_domain_for_dev(idev->dev) != domain) {
>> +		ret = -ENODEV;
>> +		goto out_revert;
>> +	}
>> +
>> +	/* replace with the same handle/domain should succeed */
>> +	ret = iommu_replace_group_handle(group, domain, handle);
> 
> Hmm, this is switching between domains with/without a handle?
> It feels odd to me, as we should do this in the user space code
> other than in the kernel?

yes. but iommufd now always attach with handle.

> Also, I think that any iommufd-allocated domain (via hwpt) has
> an attach_handle now, right? Mind elaborating a use case with
> iommufd that can switch between domains with/without a handle?

I don't have a usage yet. It's a remark[1] from Jason that reminds me
that we now actually support it but does not have any code to test
it. Hence, I got this test case.

[1] https://lore.kernel.org/linux-iommu/20250218195756.GG4183890@nvidia.com/

-- 
Regards,
Yi Liu
