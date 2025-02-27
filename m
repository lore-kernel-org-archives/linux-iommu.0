Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8367D22F01
	for <iommu@lists.linux.dev>; Thu, 27 Feb 2025 01:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740620277; cv=fail; b=FEsAMLc9bBbjECvHQEEIR8eeGpPPrLCqo71FROwQM3vNTT1+LkSlCyXmHDTEJUCcn8W+v/4o7CmIJriApsXMZWyKIJZk32m0qkgGKc5ccncJFghfKlXVNF+6vEKP2YJskFqzeHfVip2zO1Rvy/2EY0uaTpybwMKLdPJ6pH4CS6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740620277; c=relaxed/simple;
	bh=Un8/RmTVuGE+cmPQAO+FSy209aj1lGMIgzmZyuRUT/8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=K0qnwvp2Zl4mSLRzVpakkqc7US/x7MkB86tSZ30tIu88HPwO8VyZ0BnT8+luh2SgE2dLg5GebpD2/H12jo22coHK5UZSNVLAa5jXx6MUu2MCfbVwyBh0vhtB6q89IGNWL/Hkk62wmqC4+epe3LcYLouJx+4d814wuevFyqFkfvU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HS8FKOtF; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HS8FKOtF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740620275; x=1772156275;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Un8/RmTVuGE+cmPQAO+FSy209aj1lGMIgzmZyuRUT/8=;
  b=HS8FKOtF38squhUo5RCa3jrCKdAo49XWRcZUiAyIMkkBl67T9jS5RM/K
   X1rJty1X8k9X/Sss2mXeU62s16WuGVcPm1dfsgTRF3Xzl73o6BZH5+7wz
   AeBtt6PhuqnLBXT2NTWnd5GNn2mDGdn/C9lC5QRYZZk8BBgNCjOVsEpRs
   KWGvnmktYpq8/5CPLUCgv0+57fekCw/HTiOQN+QnOQH5nTd322O21i2sv
   rv2lE3YJK3E7HCIhfLsHBDOF2vOa7V2FvfD+NKbjUb7GVHOK3RETwk6nO
   sAii5zxVoe0HPzz3MqTXjQQjDVlPpwbziMfauYkBx2pLIUtueDHz1HfAL
   Q==;
X-CSE-ConnectionGUID: NiC2o3OXQ7WbvgLynfpK9g==
X-CSE-MsgGUID: C+dzJsMtSCid6j86brQpew==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="41377661"
X-IronPort-AV: E=Sophos;i="6.13,318,1732608000"; 
   d="scan'208";a="41377661"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 17:37:54 -0800
X-CSE-ConnectionGUID: k5OIMv8iTK2vBcDgy2yZRg==
X-CSE-MsgGUID: ZfejqsZ7S1uO30GCXilzcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="122130888"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 17:37:55 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 26 Feb 2025 17:37:54 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 26 Feb 2025 17:37:54 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 26 Feb 2025 17:37:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xcpVkBEDxvwVFhUWfd0g30dlgA2mdKjqchD4ld4GshDrXqoZKtig5NXJZIiD1e7Q5j8cUATnbi1DUykngi4AgpaEL7tr2Ig+VClwJls0wER6YIQr7l+NXZE4npTFYZxFe5AJXNJ7TlrtfR2KnCRwMISO8GM7myOFZYn92CBGqXs2yaPpGpgaJfLnE//dTn8OMn9bOMVWI0ZdZjqNOQpRLR9AFJ8yf+HJca+MiVT0Fm+i/7OBsxBGno7wNFVsu0MlDPuHP8gme4ze/3vX8mtQzxmaqNUZBG0rGomu2YevDy1KCNVLwzUI3ibrb6911rfuYqFmjJ6BcDoAw81orV/POw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uVcZlMIeSf6OX9YqmVhfQ+QbG/ROKrLThiTgkVJhlnw=;
 b=QkmzcTT6OyLN4mInuRnMrOMiqCQjKTynPWc0iSfksz28tneYM/BfZI2dIB88FKQEDEZwGGB6zPnu9aRzUkQgIc73OgAljCFmLsL4U+0CU7v7C84i1STMp4U/vCibSq8hD361xyDcvuPKxDcu5Qe6Es9OAuk2bwAXkuNvpPa/L7ZxGOn3IjH3JypoJJgf2oYX3PliPhBFut4O26Im5s1hUYgmFJpX3+oSEJiwNGHXQfG/5PwolcGynQHpZACy8/JUQgFP3cP8+SFUj3VqgXTPn5PGrMyZIuwHWctDyW1xF6OiaJtHkVB+xGLXkTVA1rybgOHHiOE56CNNQDFXaCQ+mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by DM4PR11MB5993.namprd11.prod.outlook.com (2603:10b6:8:5c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.21; Thu, 27 Feb
 2025 01:37:37 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.8466.016; Thu, 27 Feb 2025
 01:37:37 +0000
Message-ID: <d6b97c8e-f126-49b3-b752-92fe3069af51@intel.com>
Date: Thu, 27 Feb 2025 09:43:01 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 02/12] iommu: Introduce a replace API for device pasid
To: Nicolin Chen <nicolinc@nvidia.com>
CC: <kevin.tian@intel.com>, <jgg@nvidia.com>, <joro@8bytes.org>,
	<baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>
References: <20250226114032.4591-1-yi.l.liu@intel.com>
 <20250226114032.4591-3-yi.l.liu@intel.com> <Z7+fmawdDhATfOX0@Asurada-Nvidia>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <Z7+fmawdDhATfOX0@Asurada-Nvidia>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0192.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::21) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|DM4PR11MB5993:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c50c110-8fbf-40eb-5d5b-08dd56cf50cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S0NIRy9wUk1OdExQNEVDdUxtWnVxQm9NQTUwejFJdG93enRFb2dTQ21xNXRU?=
 =?utf-8?B?dFJMckRwdTVlVFoyVVVhYndtRW9xeHIrVVdZOTl5YUNCRzJmdnlFZTJUdWRR?=
 =?utf-8?B?b1U5TnRQZDRqQkcwVzYxa0dJMlBmTTZ4NEVGVjI1VXhwRUNHRmU2M3A1aWhv?=
 =?utf-8?B?OEVDZFJpZmZVdkdhYUd5SW1HSDJQSll2cjBIUjJSakFXN3J3dUM3NFhDZWZy?=
 =?utf-8?B?VncxaFd4TGZ5OHVsM3FnaDNtMFVWQ3hnTjRJbVVQdWRibGF4MG5peWVIYVFT?=
 =?utf-8?B?OTM4ZyszZUc4WU54Z042MzIrZEU0NERSK2thQ3BzeTBsb0wwVFNhVitkOGZE?=
 =?utf-8?B?QkdwUVZiSjVYNWg2MytZZzBRZGNRbGFvZ1pHeGEwRktYTk5vcTlWaFBSbXZ0?=
 =?utf-8?B?TVplbmlaWDF3bXYrNG9MY3hJeTBjTDFMdHdWVUVLZUZPOXQ4b0NhVWNrbk1S?=
 =?utf-8?B?RXhRZEJ4YUhXWHh4L3owKzNGSTU3QWJySnRkQUl2WDd4bmlQMlZ4SVRsVXZ5?=
 =?utf-8?B?R0tSa1hxaVdoNHUzajZ6aUpJcXVuUXBXOU42eDVqWHpPVFFxc0pFb3V5aUxw?=
 =?utf-8?B?Q0tlckt0YlgxWUpGOTJadytjT2xGVEorb3FrRHdGZTlYQjQrSVo2TzdzekZU?=
 =?utf-8?B?aGFPaDJSRzdFcjQ3OTdzckxWVkxINVJQZkNucncxVWQ2alUwME1qdGdwM3lQ?=
 =?utf-8?B?ZUlhSHhsYlM1elRrN092MEZHRkdKTy9KMXJCanRpR2lWVGtaMEcrQ09TWlFj?=
 =?utf-8?B?aUdqU1g2ZUREbnQ5aFptUUpOWk9FdGx3Z25UNGZPZWR2a0s0cFFjbjVlQ1hO?=
 =?utf-8?B?dUloMk9FeHloWjNXY1E5cDI1Rm9jZTRtZ1M4TjJ1T0ozdURlZWpDZ0xpcm9T?=
 =?utf-8?B?OEJQd0RhT3dnQlUxbFdQb2FabG1sV3NPUllrT29Ha0dlVFJpUjZkNGdrdk9R?=
 =?utf-8?B?azNpdVBQeXNHWG8yZk8rRWthM2RRZ3FjTUJiUngwYWhVZEhFNU9XTFdmaFlF?=
 =?utf-8?B?UVQ5SGpPNkVaeDFFeEo4UmFvV3lETkpEM0lSQ2lHT3RobzJET3UrTDg0S0xa?=
 =?utf-8?B?WHNTZ3Zjc0J6cmdnTXV1NnF6WVZHdVBSd29TUzlQbEVNSTVsdEFndmFHWXN3?=
 =?utf-8?B?YXVKemFLMGtpb29lcDA1YXZnOVFDb0ROdERXaXpJd2Jtb0hrcFAyWS91blY2?=
 =?utf-8?B?V3Mrcmd4T0w2UVVwMWhOb1M5QTBKdVdMTEdvK1AyaDJOMXB5M0d4U1drT1F1?=
 =?utf-8?B?YTdITE5JOTM5WFEydm95dzFPV3RaNFVYKy9Ha3IyenVqYjJpWGVtc3hKZTVY?=
 =?utf-8?B?NzlCZlBMUWRlelZ0YVdkbzZwL1RpUnp3Zks3bTJlVFlseXcwSEh6NUk0d0Ur?=
 =?utf-8?B?eHRxOElQZklIUWYzSU9kV2d6TmlZZlhybHJ3ODNIOUlOemRUSE5QQjd6WWhz?=
 =?utf-8?B?ODRqL3E5blJTQ1lVdzVNdCs2TVpuZ2R5VDlla3pqc2dxYm1obGk4SkVmY0tp?=
 =?utf-8?B?Yml4TTh5Q2M3WmFoZjcwNVQ0ajhFcDAvejFMKzhyRjlTVUNPdE5SOUNHclla?=
 =?utf-8?B?TFdXZGpvVWNCRTlIZFdaazRQUEIzc2JOZCt2MCt3VENpL2kzZFByaTNCY3pE?=
 =?utf-8?B?Tm85V0dtWXpBbm03TG8ydEZMVGxkMDZLeUp6OXNkY21xeWt0RkRJenRqcEdW?=
 =?utf-8?B?Mk5mK0dpb29CckZXZDNJUCtKUUJMVmsxK01hakdFYTUrMitsckJIaHpXZUtY?=
 =?utf-8?B?dzNjUitRaGZldy9YbHVoT2o3TTFOVk9qTEJNd3Zra0dKWkNTUFA1MmxRV0Rn?=
 =?utf-8?B?cmVhQ2dEVGhlM2xPK2JqeTF2cDV6bml4ejZpWG5wb0RkSENZN0VoRTlYbDJ6?=
 =?utf-8?Q?MwpAsM7b4jbmY?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFlXMWxVMys2YkMyczdOczFKUXlJdkh5VVdHTDJOY1RjVjhQUFUzcG0zM3dv?=
 =?utf-8?B?K1VrbkVwdWlKVEsyUUxZZ0RRdStyY2Q2dWJmOGl4c0pYWWZMQWFYM0FISFAz?=
 =?utf-8?B?aGtuVWxqaE5Ob0diUUw2aFVtNHVNV0Z1Sm9WK21qaWNodUFIeTZQdnB3ZllB?=
 =?utf-8?B?N0o2RWgxK1RKMmQ4TlAwOThMUXh3emtlMlQ4Lyt3NmcwOHBiMHp0MlFrQ1lI?=
 =?utf-8?B?WlJlbWJ2V0RmRnZpVkhJcCs5Ymg3aUllN05BWU9wWjN6cDFKWkdzNEh4WjVa?=
 =?utf-8?B?bW01NHl0N0hnMGhUS0dzTWNyV3M5YmpvVmU5NWNEZ1REVWp6eHFGbklHMENK?=
 =?utf-8?B?ejhScVU5VDVZSHZXNjBVTUppRWpDa3o3dHhBUGNWSlUwRG1EUmhXUk9rVWh3?=
 =?utf-8?B?dmROa3g5R0ZBTm05akM0OVRRQk5FeThwVmFZMWNJZWdCS0Y1MUFyTE5lajhv?=
 =?utf-8?B?SVNNcVZkakxnOThBM21ZRW1sc1F1TkFXaXlaZEZCUksvelR3UG40OVZoakQ5?=
 =?utf-8?B?K1JlMjJsZThkeVVjK1dDU0x4Y0dYMzNRSHFUWGErUGU4Z3g0WHVrcjhtYVJa?=
 =?utf-8?B?YVF4Y0d1MnNqTnY1VTdpQVhuS2ZMbUVxeTZiNUdCeWJMSVpqRjNLNlo3MVpZ?=
 =?utf-8?B?ejJWQm9VaGV1SElZN2l5cVZkazdLbUUwWHJ2bmlIMzZzeXhlcnR2MG5nK1Av?=
 =?utf-8?B?OUFGbUVzSU1KYXBCdU5Fek9jNFA1UWtLVzR2cWRwTTRHNmxjNmNZbXJhRWNO?=
 =?utf-8?B?VmJFekxKd3NZMzRTZS9EV0xvY0tYU3VJWExNcjJxY1JmWFhHQVBobTlna215?=
 =?utf-8?B?cldaZWUvUjlGVUY5L240MVNoWUd1TU9HRlVzb09Kd05ubGgvSVkyRHhaWjFo?=
 =?utf-8?B?ZHFrdG9NQU9xUTVPc3ZLWlZtSStzWGVEdldrRFo0NFBUd3JMazJpTTJFVVBL?=
 =?utf-8?B?bFArc0VNREI2REpiSnY2Z09FUUZQYXJ2ckV4TEdTMkpxWnZXRDhmeFRock9r?=
 =?utf-8?B?MkRGUUt1RGE2dVdVMXVIMURIL1U1M1d6RkJsMjdvVGkySkdpUDZWcHZReUFK?=
 =?utf-8?B?R05MZmIvdWVkYlJYVkxTMnhqeFFsdTI5cDJXL2dacmRWelJvNlgrVU44aXU3?=
 =?utf-8?B?ek9QWmdpSEhJVTNKM3czT3RTK1Axb0FFOC9CdWRLamNueEVLaUYxUThJMFhH?=
 =?utf-8?B?cVpGTkU1elBkZmdmQ2VwU3NJUkpzRHVSQXZuZ2hFdVpPa1FQMWJPQnM5WldX?=
 =?utf-8?B?dExjSEFJTVlTK3YrZFl4S0d4TXkzSXV6YUlIbHRnakttak11cW14Nmx1K2N6?=
 =?utf-8?B?NFhleUgwN0pjeUFwOVd2K3hEY3FidHBVZXRPKy9uajhkTngyVnMrdERaS3lF?=
 =?utf-8?B?WU1TMk5ISWFaKytLU0JtRW0wNG0vSGZtaDZhbVZDY1d2UmlNYWlZREgwOWlJ?=
 =?utf-8?B?T0tGUmpsRjhlYjUzU1hiRnMwWEFSQlRqM3d4djFRd2c4QUtJREhwYWgzYWNG?=
 =?utf-8?B?TWFnRExpTG4zeWRNd3UrTG1jdVNsRFoxQ3RXV2pwVnNvVXN3dUVIUmM1K0lu?=
 =?utf-8?B?b1ZFRTRndXMxeDd3SFpKMERPWGRmYzZqK0dIUHcwRUNXUnlEUXBoblRMOUl6?=
 =?utf-8?B?OFlySEN6RnVEaWRKalY2SVJDM240TXVkQUZqbXUwWVZRajY4bzBiVWtDdndN?=
 =?utf-8?B?a2RtZHBaOERuQjFUV29ETmhOU3J4eVU5QnhsekNaSm55V3cxSWUwUU44Q0tk?=
 =?utf-8?B?SnBETmF3U2Nqc1FtK3pmck9reGZFelB4QjhmWU5SbEl1M0JUSyt1K3RPNmJK?=
 =?utf-8?B?S0pvSDdPa3kzbk50aTFmcXgrZ2drWTlyL1JDZm5DOXgrTldJN2JueU1jb2V4?=
 =?utf-8?B?SUNadk5wT2Y1RUlQT3EyVGhYbUxxSzN4WTF6QmMzbVR1bVNMQTZmd2JzTVI2?=
 =?utf-8?B?VkkxQjdVc2tXeWpBRjRaQ2VLT3NtVW0vWjZNT1VHLzFqRHFrTlVrdlVkWXFQ?=
 =?utf-8?B?bHBMd05ZQkR4ZU9kVEEwU2RZS3d0UGYzZU9hVmVhRWxtRzZsUk5NN2Q3MkhP?=
 =?utf-8?B?STRJdFdjM0x4b0N6ZWVFN3ZrUHNTTnFhbFJNZUVoejY2TUhlSjQ0L0d3WnBT?=
 =?utf-8?Q?tixsA7AnlgRXu6cMN7qsk/RwS?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c50c110-8fbf-40eb-5d5b-08dd56cf50cd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 01:37:37.1421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2tq74QtevTmH4UKYu/p0JI7xdFwoz4/RHZTf87TXCt/aFbjcqNQkl0P1zQ93xpmvbiQFPd++xZLrPrhzyQvLfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5993
X-OriginatorOrg: intel.com

On 2025/2/27 07:11, Nicolin Chen wrote:
> On Wed, Feb 26, 2025 at 03:40:22AM -0800, Yi Liu wrote:
>> Provide a high-level API to allow replacements of one domain with
>> another for specific pasid of a device. This is similar to
>> iommu_group_replace_domain_handle() and it is expected to be used
>> only by IOMMUFD.
>    
>> +static struct iommu_domain *pasid_array_entry_to_domain(void *entry)
>> +{
>> +	struct iommu_domain *domain;
>> +
>> +	if (xa_pointer_tag(entry) == IOMMU_PASID_ARRAY_HANDLE) {
>> +		struct iommu_attach_handle *handle;
>> +
>> +		handle = xa_untag_pointer(entry);
>> +		domain = handle->domain;
>> +	} else {
>> +		domain = xa_untag_pointer(entry);
>> +	}
>> +
>> +	return domain;
>> +}
>> +
> 
> Might be a bit compact with
> 
> static inline struct iommu_domain *pasid_array_entry_to_domain(void *entry)
> {
> 	if (xa_pointer_tag(entry) == IOMMU_PASID_ARRAY_DOMAIN)
> 		return xa_untag_pointer(entry);
> 	return ((struct iommu_attach_handle *)xa_untag_pointer(entry))->domain;
> }

yep.

> 
>> +/**
>> + * iommu_replace_device_pasid_handle - Replace the domain that a pasid
>> + *                                     is attached to
>> + * @domain: the new iommu domain
>> + * @dev: the attached device.
>> + * @pasid: the pasid of the device.
>> + * @handle: the attach handle.
>> + *
>> + * This API allows the pasid to switch domains. The @pasid should have been
>> + * attached. Otherwise, this fails.
>> + * The pasid will keep the old configuration if replacement failed.
>> + * Return 0 on success, or an error.
>> + */
>> +int iommu_replace_device_pasid_handle(struct iommu_domain *domain,
>> +				      struct device *dev, ioasid_t pasid,
>> +				      struct iommu_attach_handle *handle)
>> +{
>> +	/* Caller must be a probed driver on dev */
>> +	struct iommu_group *group = dev->iommu_group;
>> +	struct iommu_attach_handle *entry;
>> +	struct iommu_domain *curr_domain;
>> +	void *curr;
>> +	int ret;
>> +
>> +	if (!group)
>> +		return -ENODEV;
>> +
>> +	if (!domain->ops->set_dev_pasid)
>> +		return -EOPNOTSUPP;
>> +
>> +	if (dev_iommu_ops(dev) != domain->owner ||
>> +	    pasid == IOMMU_NO_PASID || !handle)
>> +		return -EINVAL;
>> +
>> +	mutex_lock(&group->mutex);
>> +	entry = iommu_make_pasid_array_entry(domain, handle);
>> +	curr = xa_cmpxchg(&group->pasid_array, pasid, NULL,
>> +			  XA_ZERO_ENTRY, GFP_KERNEL);
>> +	if (xa_is_err(curr)) {
>> +		ret = xa_err(curr);
>> +		goto out_unlock;
>> +	}
>> +
>> +	/* Not a replace case */
>> +	if (!curr) {
> 
> Mind elaborating this?

If curr is null, this is more an attach op. In my opinion, this should not
be allowed to mix the usage of attach and replace.

>> +		xa_release(&group->pasid_array, pasid);
>> +		ret = -EINVAL;
>> +		goto out_unlock;
>> +	}
>> +
>> +	curr_domain = pasid_array_entry_to_domain(curr);
>> +	ret = 0;
> 
> Can we set the ret = 0 at the top?

yes.

-- 
Regards,
Yi Liu
