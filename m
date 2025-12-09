Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998D6217723
	for <iommu@lists.linux.dev>; Tue,  9 Dec 2025 11:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765281029; cv=fail; b=MA9e01QZyEwRosJkgcXWFirmCbsoPxqBkmcr9cuNoYiNNoPqC9Wl7r6Usgrlflm4lKL1rsDVBIkanA8/S3Fve4N/IBfOVj1UwlWtjgcFiW3iykLt3AC+Pbpfq9spc01rgUt+2kMHTPK7sdAH8c0Z30xX3s+40M4n7sDfP34a3mk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765281029; c=relaxed/simple;
	bh=IN15Q7+u/0v2ZaEbOrYLNGLfQj3BfKpu5R7YoEXzy0E=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=f1BRnZu910vuNRFK6tw2w8fvz9dWsCPxpqpFK509LOKv7erw5l7yf9Wi4Ujg7y/gOeJ+H61D3hoFG/o24RfJwDJkJ3MWn5RdG5sMGERJU0UUECnxGlKbbXRMDXCzpUPywQSlJWkBtRsDeXWZzFemzhBiitTJIBzdbBuuySO6vEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jp0ZopEW; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jp0ZopEW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765281028; x=1796817028;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=IN15Q7+u/0v2ZaEbOrYLNGLfQj3BfKpu5R7YoEXzy0E=;
  b=Jp0ZopEW6061CV3GHnmFMEBFHeiD8EsITk59+S5KX7N/YFNTTv3S40RC
   jFD6JBdl3VEGVfjlVNmOq+W/pw8KbzCL+1gTlpqch76/auQ6iroIj+ZlW
   8+Fjvf+Y78ir65z+HpwS/QcR7NpwEIlSjClDAURL3/bPlYE7ZQO2q53/F
   I6huss12K2/RbJHDaSCybU9AJNQBJcy5HxihG7DDBXiVdRdMW1TazMvVX
   JBQrgrpxv14sEuEDXGm9nGsMIUGbtPrNOyHl12uaaVvEdiodi0/ZmdIOy
   yPXo4r20sIwIgFNmlG5G3wJqAY23PSkQYuMDL23iLvZzFnMVKMFHvrdur
   w==;
X-CSE-ConnectionGUID: z/DjpBxNQ7i8kszEFh2HOw==
X-CSE-MsgGUID: jGPz1oLvQES7DBp0StHkjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11636"; a="78701108"
X-IronPort-AV: E=Sophos;i="6.20,261,1758610800"; 
   d="scan'208";a="78701108"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2025 03:50:27 -0800
X-CSE-ConnectionGUID: IO3b/KhIS+KVxfFLlPcicw==
X-CSE-MsgGUID: r7ZFO1Z5RIe2urPzoAz9LQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,261,1758610800"; 
   d="scan'208";a="227248983"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2025 03:50:27 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 9 Dec 2025 03:50:26 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Tue, 9 Dec 2025 03:50:26 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.20) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 9 Dec 2025 03:50:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cKIrIX5L3ob1tKblX/qkBgvCYiThs0o3di97+aqyaADjM2lYNC6mUGDKoAXFSeJE2EoCdo4nCa6gpWh6AUAABm7HuNuCGpRJMZB1Of96dG1B6iI49MnWi0tQ1Z1RHbvXeJZl6Wk9Bl4+gLv+T1rPYo/pRMZODIXBw+7uoKZyrUWc5pBG5Qy7vHsDl3tiNYckH9D1skztjr7GXKM1Tm6snQZde4darrn1jiIAWKw8xrJXJRCP/MysVWEucOt0wxS7fKjgqGDvuGolNy4sUdAgWDO0ULooxy5ySRwEAfByspxFUHux7jvbn+26tDWPKgcCXtLmcS+9nHS/CM+x12U74w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Z7cucKOeIJYXAYB1tOcXV2rIfzSCqpI0I2n+lOIWS0=;
 b=w8mWEAEm2b63E/64eiu0FyW8HKF6+YMbPODRjCxE8EaaA1XQ6CzVLAxZkTjdowyTN1kZ0URjHOaMbGBYcejy5j2cGk1wHPiqvVpRkH37uffAX/IsYJCGtjd2WPbmv/Qn3foa1S3TXn2v89knHic106eKGmc5fxBZEP6oZ0gQdzEB/2dYe1K1Gs3QfhCSkhpqF013IZsNVNvsAZpMmMItya66jirnC+usOIboBDhCPMNP9lOE3qruWI/nrmXpDRR6+8ncZVoxVef+A+VpfAR7wnL3N1fSoYBAwFSVyP5eW18+fSmbEiIFWHJTD6/rBN8q/wB99fzOhi+K2ciBtxJN3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB4798.namprd11.prod.outlook.com (2603:10b6:a03:2d5::12)
 by MN2PR11MB4566.namprd11.prod.outlook.com (2603:10b6:208:24e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.6; Tue, 9 Dec
 2025 11:50:19 +0000
Received: from SJ0PR11MB4798.namprd11.prod.outlook.com
 ([fe80::d946:6abf:6e7e:fd1e]) by SJ0PR11MB4798.namprd11.prod.outlook.com
 ([fe80::d946:6abf:6e7e:fd1e%7]) with mapi id 15.20.9412.005; Tue, 9 Dec 2025
 11:50:18 +0000
Message-ID: <695e0955-0de4-4059-aa77-66c54669f1a6@intel.com>
Date: Tue, 9 Dec 2025 19:57:06 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [iommu?] WARNING in iopt_map_pages (3)
Content-Language: en-US
To: syzbot <syzbot+57fdb0cf6a0c5d1f15a2@syzkaller.appspotmail.com>,
	<iommu@lists.linux.dev>, <jgg@ziepe.ca>, <joro@8bytes.org>,
	<kevin.tian@intel.com>, <linux-kernel@vger.kernel.org>,
	<robin.murphy@arm.com>, <syzkaller-bugs@googlegroups.com>, <will@kernel.org>
References: <69368129.a70a0220.38f243.008f.GAE@google.com>
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <69368129.a70a0220.38f243.008f.GAE@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0047.apcprd02.prod.outlook.com
 (2603:1096:3:18::35) To SJ0PR11MB4798.namprd11.prod.outlook.com
 (2603:10b6:a03:2d5::12)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB4798:EE_|MN2PR11MB4566:EE_
X-MS-Office365-Filtering-Correlation-Id: 96296be7-5876-45df-8424-08de37192023
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|42112799006|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NDJUOGlZWGYwYXlWT015enpDWldXLzhkNTFCdWh5eHVJZkw5QkZ3MElEQS83?=
 =?utf-8?B?dDVIelVsRm4rMng5dWswU1VKeW4wTVNlWkJHTjhXZkp5dEtxL0RTeFFsbHNF?=
 =?utf-8?B?R29UNHMyTWY3bkxRVHlPWldnSVVWbk90YnluNWVqSkNyQ04zUmRveGV5dmhR?=
 =?utf-8?B?QjV0V3BVdkVRRFRjL0w4U3B3bGJ1aHZ4U1BIeU56ZUtlZFNjUE1BK0ZpU2d6?=
 =?utf-8?B?NHlyNEx4VlVLNFdQdWFGMjlvS2VhT2YvSVRXTnN6SWdMeDl2cDhMamhjZmgx?=
 =?utf-8?B?MkVmQndTZ1VkdGJxVGpWWkptWTNaZVluQ0pha1FLc1Y2K3VLbytidXRhbDB3?=
 =?utf-8?B?UWozUVlEOG4rV00zczU4emdQQTlWNlRQQmhhZUUraDh4bkZFZ0pVVFVlK2U1?=
 =?utf-8?B?ckZXajJmdFcyZmgzTjFNODAySi9CcWNhMTVjdmpjeEdpM0crbjJlNXErYlBo?=
 =?utf-8?B?c084SUc5Z25rT2ZmRC9VNHhCUmNxY29VeHRpN2d4QXdGanpxd0wvNkFtK3ds?=
 =?utf-8?B?NXlNQm04RkQyYWVYcU5ST3grRHpZUVhNTklBemFmUEZ2WlBhOTZIKzVlTTk1?=
 =?utf-8?B?OXlkSW1sMjExRnNScGJPaDMvb3paTzRSK0dlVkcxaS9LSU5oQnpkZXh2cmdx?=
 =?utf-8?B?Z25LSUhLVHVZTzJEZ3hLSm9tZm1QditUOHcwdGdmNStQM0tHQ0JNbFdMSmFQ?=
 =?utf-8?B?WkMzNXovbDdxdXBYT3ZsVXVWbFpyRGJGaVZvNFJIbEgwZktYYWRyWG9Oa2dG?=
 =?utf-8?B?UXAvbzl5YXpuQkRnNzNjRHAvaE5ubk1GZDBFdDUzWVAzOXpPR1NKNWVJZVdY?=
 =?utf-8?B?Q3hzTWp3a0NvTGdheDd2MGRxV1cwaC9uNVlVaG4vdzhFOW94c1UxVlhOeC9o?=
 =?utf-8?B?WEwwcEFCVE9OSjBiUHJrcUt1bFF3SzZXdjU0RzY0NWZhODh0alVLeHNZVzlR?=
 =?utf-8?B?eUFSZXVBMjNBakpEeFVpVjZYeG55Y3RhaWhVWFRKV1MrY3FEZUtWUTgwNS8r?=
 =?utf-8?B?b1BrbHZDZDVnSVNMMDYvQ0orNk9YakFTTkMyaHdMSGlEZ056d1lYanhpYVI5?=
 =?utf-8?B?cVg5aE1HZU5FYXdxWFNzWEx5M1F0cTVQUzJ4MkxLbEpWUXV1T0llYkk2U3JM?=
 =?utf-8?B?bXNEWm1NelR6MEZMSWorajFybk5CUnIyTGpHdDAyMmRIaFBId0hqanc2K3di?=
 =?utf-8?B?U09qYnR2YTJ3MFlJS09SVlZnMXUrdWVHRzk2NHVwMG9YSUxlN2JMYWwvdVhH?=
 =?utf-8?B?S0NCOW1TYkZ1dDIvR2VkTlkyWHpTOEt0TnEyNWZVb0RUWjhBNmdxbEtaTFNp?=
 =?utf-8?B?VUZJbSt0ZHVPalh6SU9UVk9VcW9vV0EvbmR0N0hhdXFPR0wyZTRHZUNxTmpT?=
 =?utf-8?B?eTVEUDJKQkl5VllOLzVQMm9XSUR5VllJdGJNV0RqeFFyOUF3dXBpZElwUTFB?=
 =?utf-8?B?bGI4MjdBd2JjeE91dzZmakNwMEpFSjBtVTRROGN2K1JWV3g3QTB4RjhVNkhK?=
 =?utf-8?B?SDlCWW9LTS9WTEl5SjBxN1NqWUVTZno0clRFTFRoQlNZN0xKbHA4WnpjMVhv?=
 =?utf-8?B?cU9yTWx2WWRENlVMTXdHYWlHcTJIQWRiMlpTUjh4MHhVYmlSYTR1eXZqRWgy?=
 =?utf-8?B?SGVaV0ltcktCZFVkUThKdXFYUk0xeWZiNkJFNXVFRFVhWGZOMVN2dTFPUUQ5?=
 =?utf-8?B?VGh4MlF5bDkxTUg4THJWM1JvT2N1ajFYZHFEb0NML0Z1RXY1YWlhZHd1Mk5u?=
 =?utf-8?B?bGI5WHBDN3hmUStxZTJYMW5RMnQ2d2FETThkakJTamhGeHdVYmp1YmhOa241?=
 =?utf-8?B?aDVMSTZvcmZGTkNZSDE4MDJLV01oQnhsUWw3OEVwNkNwZTQ2ZGoxcFRKckQz?=
 =?utf-8?B?WXJhOVM3a1RBdG43VWRhaU1Sck9Bd0gxNkVtTFBEMFU5M1E9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB4798.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(42112799006)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0lEU3BIQUVQVThscmErUTVYajFHYit3YTBxQWM3SG1YZnM4TmFoUU1VeEFD?=
 =?utf-8?B?WHA3bktwWkVZVzA2NWsvWXZMcmRUVEIvbnB4MEhvWmJ4a3FFMlNaYUEzVWV6?=
 =?utf-8?B?WkxGYUFLOEMvQXo2d1pib055TVNNOUJYamdUNnhHek10bU5QT1FyMGJHOGow?=
 =?utf-8?B?MFRDMFQ1aWR5bGp4UHcyVm5mVmQ4L2o1cUFzQlo3NzN1eXllYXdUZFcvWWc2?=
 =?utf-8?B?cmpaUE5kSjlvaDFPYW1sWUhraTBsd0xpbDBvUXlSSHdvamNYK1JyeEVLWkE0?=
 =?utf-8?B?TzhBRzJZeUhLWFFSdXQ3RTU0MVJRK0dzK1hrMmEwbmsvL0p2bDB4ajZ1eTRr?=
 =?utf-8?B?RFIzNWRhejA5MkcwbW54NHkwVCtaRmR4eU5SdzJNUEJ5YjVSZnROTlo5dGVG?=
 =?utf-8?B?Vkx2QWxvNWlnQ25qT2NuQ3FSOWkrTlFhalpJaDhnNU9KV0p5dnhCTEJzSm9q?=
 =?utf-8?B?R1Iwb0VIQ1piUkNqTStUYUtrdFpqSUx4cVhhRytZL1QyaVRHMkhHZFVOVlhR?=
 =?utf-8?B?aVFIejZQQ0JhK0h2Q1FmaGtsTHBCdFJtcGhhck5SWnQxV0swTjFlMzFJaksy?=
 =?utf-8?B?VTdPVHpUVEUvdloxeDd5cFVKMjZ4dGtzdjhxT1l0MDBja09aeGtVRWJCVFJN?=
 =?utf-8?B?ZFQ2YWN0S2Z2cjkySXkwR0RQQUo4L0pmT0dzWXhBYTVscHRoblR3SDlqT25N?=
 =?utf-8?B?UnV0ZjFWdlR4bnAxOUYwYUN0dHVyQ1RxMDdURXk1dmYxbFdnUFBGV2doeits?=
 =?utf-8?B?ZW9qSE1JNFZLRW9MOEc0TUlQdHJTbDQ5Ym1LK1RJZzZyN0YvejVnemcrd0ZS?=
 =?utf-8?B?ZUVXTUJlR2d6SWV6OWVPM3FEMHQwWW1oVEs0aFhNbkZQendYWXducDRkRGtM?=
 =?utf-8?B?OXBPUGd1NUpKelZFa0FTOE0yZWFIUUdPUDljY1NONVNQcnRnVHBISlJyRUcr?=
 =?utf-8?B?aERoVGFBcVptUFYydUlaUjMzYnovc1lxNTZSbDg1aDE2bDFNUmNid2Fid2Fs?=
 =?utf-8?B?NkdNZTVSTy9nMWpHNHRlbklPd0lLQnRkK2ZzN1g5cXRpczhUcEhtNkh1SEx0?=
 =?utf-8?B?RUIzM0FIc2VhUnZHNHFyM0VmeTVDdVU3czdNanNxU0N3RVVRL2pCZyt2Rnho?=
 =?utf-8?B?c1djM2xsY1ZmYmhhMHNXN0JFNXhCZmdZcmIxUmNZdTFSemN2WjRjdlJObXlN?=
 =?utf-8?B?NHVmV1BvbzArbHJ2T0pLWlRWL2JodWVwWFVIY1RSZ2t0dGlqUGc2OVhLZ3li?=
 =?utf-8?B?MWpWOGc3SVZtcnk3WVRwbjdkcEJDM3NjU0w1SjlrdGdGeDlpemRRSzlicUY4?=
 =?utf-8?B?Z29WUFJpbTMxKzFzVGttTjVSMXNmZ3FnSVhJWGdUOUFMc2pObENFNmVXeFdN?=
 =?utf-8?B?M1FINHN4dkplZHQ2UUhyc3RZMUNxTEdZK3J6L1pOMW9XeFpJUm9vdHJBWW85?=
 =?utf-8?B?VkQ4THAybGtydUNuTDNJTjBKNk1neWp6Sk5FL2lVd1ladzlubDJSVEs0ZXd2?=
 =?utf-8?B?MFRnT3YxUlJUNlBsa1BybE1LbEpMWTZpQ25pc29GMFFiRGdGbXRBdGpDOXYy?=
 =?utf-8?B?elNpb3EySzUwdjdQWlJ0ejhqNy9KVUJDRlE4R1NqbVJydDFZNlAwR1pOL0Ev?=
 =?utf-8?B?eWZMRDE4aVVlUW5DdUp0V3oxbGRwUmJ1eDFBN2I5dTYzRGFFU1JMcjZhRjJD?=
 =?utf-8?B?REFlQThWdGVZRVFSdFZ3aG40Z0VpM010eXpVSTZnS3dqK096N045WUpzRlpy?=
 =?utf-8?B?R2l2bTRzUkJMVHBpemFHNVZ0T3lYQ0NsUDlaYXM1OTFIZ3ZuNjc1UlZ1OUQ4?=
 =?utf-8?B?VmtOYlpCRkhjUzc0RjlzcnlWVEtTeVF1YmRpaWlvWjRNYkY0Y0kzVGJ2NzRm?=
 =?utf-8?B?aWY1clFWT0FJVmpwRnJrY2JQN2tuOHpXRkkrTVRmUDhkdlRqZk4xeHBRZ2Rj?=
 =?utf-8?B?QTVPa0ZrbTFPSU5ZTXp0ZGhTR01KZjdrek9UZEdCV2ViaUJCK1lkaE1pRUFl?=
 =?utf-8?B?QU1SeUcwVG90WlhKMW5tMENLaWdOWlNmcFNNQzJPbVJMYzFlK092QjNLN1cy?=
 =?utf-8?B?Snc1VXhpWk8rRENINkdiKzdBY3JFdEhDdTFSWlAzT3MwazY5SnlpYjU3eVRs?=
 =?utf-8?Q?wG3vS+Y9Rvl685wGx5eX0jkIw?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 96296be7-5876-45df-8424-08de37192023
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4798.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 11:50:18.7986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xNDce5fY8T2osgC0/jnuPQUl/vJqeoGIKS7zcNdYjlF+STqh4cGyqL6COgdL6jJsfaZiDFZhQF97+iBfEJPaLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4566
X-OriginatorOrg: intel.com



On 2025/12/8 15:41, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    05c93f3395ed Merge branch 'for-next/core' into for-kernelci
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> console output: https://syzkaller.appspot.com/x/log.txt?x=14eb7c1a580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3b5338ad1e59a06c
> dashboard link: https://syzkaller.appspot.com/bug?extid=57fdb0cf6a0c5d1f15a2
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> userspace arch: arm64
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17dfc992580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12a926c2580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/6b5c913e373c/disk-05c93f33.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/15e75f1266ef/vmlinux-05c93f33.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/dd930129c578/Image-05c93f33.gz.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+57fdb0cf6a0c5d1f15a2@syzkaller.appspotmail.com
> 
> iommufd_mock iommufd_mock0: Adding to iommu group 0
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 6739 at drivers/iommu/iommufd/io_pagetable.c:292 iopt_alloc_area_pages drivers/iommu/iommufd/io_pagetable.c:292 [inline]
> WARNING: CPU: 0 PID: 6739 at drivers/iommu/iommufd/io_pagetable.c:292 iopt_map_pages+0xd7c/0xdcc drivers/iommu/iommufd/io_pagetable.c:376
> Modules linked in:
> CPU: 0 UID: 0 PID: 6739 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/03/2025
> pstate: 83400005 (Nzcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
> pc : iopt_alloc_area_pages drivers/iommu/iommufd/io_pagetable.c:292 [inline]
> pc : iopt_map_pages+0xd7c/0xdcc drivers/iommu/iommufd/io_pagetable.c:376
> lr : iopt_alloc_area_pages drivers/iommu/iommufd/io_pagetable.c:292 [inline]
> lr : iopt_map_pages+0xd7c/0xdcc drivers/iommu/iommufd/io_pagetable.c:376
> sp : ffff8000a04f76c0
> x29: ffff8000a04f78a0 x28: ffff0000d66f4810 x27: 1fffe0001acde944
> x26: ffff8000a04f7b00 x25: 0000000000002fff x24: 0000000000003000
> x23: ffff0000d66f4a20 x22: ffff0000d66f49f8 x21: 00000000ffffffea
> x20: dfff800000000000 x19: ffff8000a04f79b0 x18: 0000000000000000
> x17: ffff800083ce6110 x16: ffff80008052b3c8 x15: 0000000000000007
> x14: 0000000000000000 x13: 00000000ffffffff x12: 0000000000ff0100
> x11: ffff0000c72f5c40 x10: 0000000000ff0100 x9 : 0000000000000000
> x8 : ffff0000c72f5c40 x7 : 0000000000000000 x6 : 000000000000003f
> x5 : 0000000000000040 x4 : ffffffffffffefff x3 : ffffffffffffefff
> x2 : 0000000000f03fff x1 : 00000000ffffffea x0 : 0000000000000000
> Call trace:
>   iopt_alloc_area_pages drivers/iommu/iommufd/io_pagetable.c:292 [inline] (P)
>   iopt_map_pages+0xd7c/0xdcc drivers/iommu/iommufd/io_pagetable.c:376 (P)
>   iopt_map_common+0x204/0x420 drivers/iommu/iommufd/io_pagetable.c:420
>   iopt_map_user_pages+0xb4/0xd8 drivers/iommu/iommufd/io_pagetable.c:461
>   iommufd_ioas_map+0x2d4/0x3d0 drivers/iommu/iommufd/ioas.c:276
>   iommufd_fops_ioctl+0x424/0x54c drivers/iommu/iommufd/main.c:533
>   vfs_ioctl fs/ioctl.c:51 [inline]
>   __do_sys_ioctl fs/ioctl.c:597 [inline]
>   __se_sys_ioctl fs/ioctl.c:583 [inline]
>   __arm64_sys_ioctl+0x14c/0x1c4 fs/ioctl.c:583
>   __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
>   invoke_syscall+0x98/0x254 arch/arm64/kernel/syscall.c:49
>   el0_svc_common+0xe8/0x23c arch/arm64/kernel/syscall.c:132
>   do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
>   el0_svc+0x5c/0x254 arch/arm64/kernel/entry-common.c:724
>   el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:743
>   el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596
> irq event stamp: 1160
> hardirqs last  enabled at (1159): [<ffff80008ae21fa0>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
> hardirqs last  enabled at (1159): [<ffff80008ae21fa0>] _raw_spin_unlock_irqrestore+0x38/0x98 kernel/locking/spinlock.c:194
> hardirqs last disabled at (1160): [<ffff80008adf99f4>] el1_brk64+0x20/0x54 arch/arm64/kernel/entry-common.c:412
> softirqs last  enabled at (132): [<ffff8000801f96d0>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
> softirqs last disabled at (130): [<ffff8000801f969c>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
> ---[ end trace 0000000000000000 ]---


It looks to be an overflow error as user gives the below arg. But
this should be expected. no?

   //        start: int64 = 0x1000005 (8 bytes)
   //        length: int64 = 0xffffffffffefffff (8 bytes)

> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup
> 
