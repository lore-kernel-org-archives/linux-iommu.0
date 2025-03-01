Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3769B1D5CDE
	for <iommu@lists.linux.dev>; Sat,  1 Mar 2025 10:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740823646; cv=fail; b=nAjUOPiajXs29ej+ba5qcXeJOGINSyD+WdbdTJHp91I2ix72hrUNV7CmxkNqZkuAZV0cXrEdkcE/CIsMITNPtSNTfxhN7O18oGL+GSbm8TQqGQWNGEjPFJaYl2EP8hHzdKKQhqdIQ3Z+ZqXRHENZ9rRhZ505A+GMTgaZACTs0mg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740823646; c=relaxed/simple;
	bh=+dFmIMHcO/6GZKGrkJdoL7fZtUDZluVbrnMpvwfgc4E=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=k94gJFeXxnYZUk1SUgA8NAnl0DzxYgR45AJWIijDaeyUde6kJjFX7kdKl1fZuJHJt/y0uQc3SI8+EZ55EqUoj0AAflGDiDdBGyh0D/IG/jSvUix3PObaRy3s8WKUUbR/R/Ju95lRYRpVxmva6lDrjKFyYwWvYICBKICOtzPutzg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O268jVs/; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O268jVs/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740823645; x=1772359645;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+dFmIMHcO/6GZKGrkJdoL7fZtUDZluVbrnMpvwfgc4E=;
  b=O268jVs/uTNPJj9coPmFJ8NJSykcUQYwY+EOw0vxnI0EgRMK3TrFNRtw
   20TEtO9KHl5pWfRmMV5I0fdHKD3HYFttMV55GC92dvtwbOe0xdhiYFA6n
   yQjewaDe2EJqqqMP10FNwRbjBRpSK+Wnkz0jvskqYd7BBSqgqUDaYewaS
   j1kW3TqEgfrQkFBbnUnMPVIcNyUUEVGwGI2cFVcnoEC3l7IMGBmxV0cq9
   /a1sae30z9KoISUNkQc4m4gN7W93KlJ5f3hMay3Qv8LTpCXUYxRvLyIIy
   YTgwn2Uh3fHcVHzg8DOnTuhVs2Jh55IsV1dEz3g43Id8xWEDirWwBq0fN
   g==;
X-CSE-ConnectionGUID: lm+LC0yZTPaEq1MpScs8Cg==
X-CSE-MsgGUID: +7AdvukVTnGni5Yl8ln7ag==
X-IronPort-AV: E=McAfee;i="6700,10204,11359"; a="45533903"
X-IronPort-AV: E=Sophos;i="6.13,325,1732608000"; 
   d="scan'208";a="45533903"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2025 02:07:24 -0800
X-CSE-ConnectionGUID: Xt+aQbyRSGm2qqhcp7KZ6w==
X-CSE-MsgGUID: 9xy5bd55T++QL1c56K4mIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,325,1732608000"; 
   d="scan'208";a="117571658"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Mar 2025 02:07:25 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Sat, 1 Mar 2025 02:07:24 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Sat, 1 Mar 2025 02:07:24 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sat, 1 Mar 2025 02:07:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b5nlOxctM6TjzCui7/heWWgMJSxUvsOmH7QXvI43BlkUIC3IXpCRTwnwiKP6DfA071SzvsHriJtJyblbl19EA9pFvnLhvmCZ34kkZzyGrBXQHt/dQq8AgXnK2DFqbRKLMzGtuj0SRtxsmUO9X1vGnHiRrOd13YN6dvm0pbz2E6IiDNwjwn1Q2rQT7AsSAG5mdTK4QlwmRUqfbdG0qayqOtYIUj5Lpd9o4F4W3WZulazdP0EnE0o6y6cQmWxZHea5kAmMH0FV53Xqxlf6g08ipeXJdTwR8dvsrObax8hnbf2xe8MTMlKCEp+8LGJMZNYcr1GMrG3dzsK7H5PNV1N0XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EYtkOFXdpGOY4//2K/16o6yYXsiYtKVNtf20lvEd82A=;
 b=Yh11MZdP7bbO92Jv00T/GLbY6/7DWgBGgQNgjvyTaaO+bPmaItzq10PfMfBePhwCHeU1OWcxVQ7sMSdSBjnhuzxCRWcTpXDxFssYV1OMY3QkHb5zW2vTzupYe2qQvgbT+zKlLWTDGqDfpAhwfiE4Oze4c3TRMkKkEBclmfD9xDiQIXdF5H5mhVpYMTdVh4dUwBRbCZThfWsq7d0Qmfq1y6oQ+xmwXLOYLLbq559CTI1H6ZIi0XyXk0Q3LVb3GmoGGPKvqbNiPhj9rD5ztZYrOqEd6FcoVrifhWkmKvRRMgpBqi2EHwm9SgMIL+RHBYrm/4JCzA7SgsbbyYITw9pOHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SA2PR11MB5179.namprd11.prod.outlook.com (2603:10b6:806:112::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Sat, 1 Mar
 2025 10:07:22 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.8466.028; Sat, 1 Mar 2025
 10:07:22 +0000
Message-ID: <1b4e283e-32a4-4ffa-892e-42e94eb46572@intel.com>
Date: Sat, 1 Mar 2025 18:12:47 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 04/12] iommufd/device: Only add reserved_iova in
 non-pasid path
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <joro@8bytes.org>, <baolu.lu@linux.intel.com>,
	<iommu@lists.linux.dev>, <nicolinc@nvidia.com>
References: <20250226114032.4591-1-yi.l.liu@intel.com>
 <20250226114032.4591-5-yi.l.liu@intel.com>
 <20250228152434.GW39591@nvidia.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20250228152434.GW39591@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG3P274CA0005.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::17)
 To DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SA2PR11MB5179:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f84da9b-84df-4542-68b4-08dd58a8dbb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q3d5NVdYZWUvbkt1Rmp5RWVPaThqVlkyQXRkV2dTWGxUY3VCbXpFOThCdnVM?=
 =?utf-8?B?NVpCUlJtVWh5cXR4MEVPdmR4bXhpZXpzL3dDOU0xVVIweTBGMzhsVGFIK2to?=
 =?utf-8?B?Z2tvKzBtRzN6MVkrcE9nRU9mU1MzaUQ5azRpQXpsbXFCT0xJQkl5aUw4RlpT?=
 =?utf-8?B?OHVlYTFES0RsSitTT05pV1dZOVltQTZPejdmVXdkTzhNQVllaUpGTTR1d0Rh?=
 =?utf-8?B?VnNPSXB1M21KNUN5a1daanFqV0M3cHVwM2RaaWhwcGJvR3ZmOGZuTktGbVV5?=
 =?utf-8?B?T25NaDZGYWNQcEM3eUo0YjBpRi9xZUpmNjhuU2JKZ3RZMVh6ZngvMGtUQ21h?=
 =?utf-8?B?N0xnd1pkS1krQVo5RUlOMG9XVDdCK3d6VjFBOExDbkc4emFsMk0yekNZWGR4?=
 =?utf-8?B?cEoxa2haR2NBSmhBVlM1MUlGSHlxaUlwOXpZTG1USG13SmRwbjdEV2dkVytQ?=
 =?utf-8?B?YlpZK2xHb3Y4WHExdUpLczR5VnFrREJ1S3NSemZuTm54TTNUc1Z1bk81TS9k?=
 =?utf-8?B?RXJYV09MdjRMam5Gci9Ia2I0L05JK05pdGtjKzNpemxwZDlVeUdsMXIrelZZ?=
 =?utf-8?B?L1Y0S0lscHpMaHVGMy9WZzExTUE1eFplNDRUVDJiN0d5U00wMVdnMU5RSWZ0?=
 =?utf-8?B?VFh4TE4vLzZ5bXVqQ1VrM3Z4Y0FTVVlBYUs2YWdEMUR4d3YrbS8rdk1Fc1p5?=
 =?utf-8?B?QXZmZmw3eU5vb2pZV1FjdWx0Z2hPSVlCYnJaY1lXUzRxdUFRWW5acjY0MmJH?=
 =?utf-8?B?bXlsNVJxZ1BSem5KdkNMdERtRVdXc0Z6eXNOV2szeHo0SlgzUDRZSTBGUW00?=
 =?utf-8?B?bENvam45RTBOR2RGVitsdFNZRkN3RlNkUUlzSGJ3bGx1NExxY3BFa0JrN0cy?=
 =?utf-8?B?by9pVTdkSnZQa0FuUEJINjMyeWdYZmJ0eUVRZHVXOU9SRFBYSEF1YitMTksv?=
 =?utf-8?B?VXBrbDR4SVpZTG5lRWY1TGwwMVdhVFlabDBYQlg1T1NXbGdWSFl3QnhBZnJr?=
 =?utf-8?B?eDAyUWxoa2Y0cFZuWnpNbDlHbUlCVzVZejVVVjVkRVNYcW1FQ0JSWVk4cEt0?=
 =?utf-8?B?UkkwcC9MRDlBYTFURVgya0g0TGRGUVJQV2Q5QzY1RGhiMzYyOFV2RDdRTEoz?=
 =?utf-8?B?ckJJV1h5MWVEMm5LR1FNM2F5dWxSR2krc2ttTlVReTl3OE52TlRoVndTWHJa?=
 =?utf-8?B?b25lVzBhQUdkaHFuLy81OUhzYXRQemNnbThhL0s5cjYrYThDcWF1NDZvV0Y1?=
 =?utf-8?B?UVJlK1FpN2NZbllIWnc1L2o5N3lsa2dQTERPM3VqUkpDVjVQTzh5ditnVnhs?=
 =?utf-8?B?YkhIRkJ5dFc4ZVU1dmR1eTNQNHRWdno3YktBMDJrTGhXeVdGdkR1NzAyamdK?=
 =?utf-8?B?ZGtVRFBRcXd0TUNQRHRLc05tYkNMNStuUE9VZ3daVVZQT1hRVWNaVnF4S1NW?=
 =?utf-8?B?UnZsdWk3d2h5MSt3ZURqeGg0YTc4VUI2V0Q4VmZlTUEwQjc1ZjhXdnRjMlhk?=
 =?utf-8?B?WmVJL21hVFdpNkFEN2hNeTN0UkxXMExXWlBBYlI2VGpZWDhWL0pSZzU1Nldj?=
 =?utf-8?B?bk5BUlJGcDNCdlVvS2NhMlJTTzhGOHB1T0xXVFNEL3Z2UUdCNWcrM0xpN293?=
 =?utf-8?B?V3dMN21SYi9MTks3SFhnNTBpb0x4azZVSjl4UElPZjBHbGwwd3VzaEpXVlhX?=
 =?utf-8?B?NTJ4UjRXbmlaOEgxVHpleVhOUXdrT2c5OGpMOGNER29xVW1uaWxjcStDdGtz?=
 =?utf-8?B?MHlyQlAxVWl4T0dXbDlYU2N3bHlYeFNJelVXR3FWSlBpaE1CbWhPY2tFcHB4?=
 =?utf-8?B?WCs1MklYVExJVGpER2FoL2I4QnI5VUI4M2hqQnVMUjdvVHNLUDhDenU0ZEp3?=
 =?utf-8?Q?i+TqvvUPNi9Bv?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjdyVmVaQ1NhYU0zZWVKVFE4M1B3OEg2LzB6RDR5L1NrSUNHNFNldllHRklN?=
 =?utf-8?B?QzZvUlJYSGdMVFUxRWprb1E3TWUzUjduRTEwVFRURmZnU0h1WThzN0tvQ2Y4?=
 =?utf-8?B?NzdlUVJCRjBUYk1HWk13cVBKYkFscHFrV1dFcEJMaHc1aHFZcm8yMWRDTlZs?=
 =?utf-8?B?aW9DaExXMW9zajlaSzFqc2Nad3VrUXVxVmxsWGlqKytWSTY0YUlsYUtVdGJB?=
 =?utf-8?B?UDREQ2xuVzFLbldDZVVrSTNLajh6bDhGakk4aUpCOTA3U3hneUVRWjIrWEdE?=
 =?utf-8?B?TUswcCsxczB2bTRqMXRaS1hEQjBDRlFIcWMwMHZRV0Vkenl2dG5taEQwREtU?=
 =?utf-8?B?dTBHdUp3QUhjWk1mazJDUTVYZ1ZzTjNHVk1qWVV6QmgvVUhrYXlJUDgyZlA3?=
 =?utf-8?B?azByeVY1SmI4c1J3UzNVSVVUZ3dKS2hWUS9pMEsvR244WVhseGR4dmphdExz?=
 =?utf-8?B?cGZVejJHc2tEWkxtaENzZndkWHBhb2V4WHpWeldJWWVzK1NwSEdPZmd2dDRv?=
 =?utf-8?B?aVdTS0JNejk4TzhzejVVZmRIVFpMMnJueFpKU0ZMeHRIYnVJQnhrQVdiVnk1?=
 =?utf-8?B?bDhQVVhrNWIzUUIzbUJMT3UwMmxWdXI2c2hTMnppMFhDdjNZSFZVd3kwQ1dz?=
 =?utf-8?B?aCtCZ2xCZkIyd1NKR0NEUlp4NmZVUXN4RjZIVXhiUmowS3NWaHRjZjFRMHEr?=
 =?utf-8?B?RllkVzFZc25qVGd1QlFXenZoYnRhbWh3SVdZa2liQUZ2YklDSUlFcHRMV2xG?=
 =?utf-8?B?QnRxQVBhT2FiOUtTb1FQNEdNRElXdkZVcVgxSm5hSURONkNqWEpjSGZKNDdp?=
 =?utf-8?B?QzJwNmQyNWowUWJqOGVtYnRVdlJXOGVLclJqb3FTREhUWGdqMVl3UysvUlVH?=
 =?utf-8?B?Qkw5KzVERUFlMGdXWDBCc1J0L0hxL1B4YVVWKzlzWmpwNHpEQ3lLa1ZCMDU2?=
 =?utf-8?B?ZGdOZGJzTFdPbjcyc0RsUlF5T0d3bVVnajhQTlJrbU9YOEhTTnF0SkN3MWVW?=
 =?utf-8?B?cTkrZ2lxNGczZVM0NWxUNTlaeDY4bTNOQTlpR3BRMHZ4TXVsd2hOOHBTamRt?=
 =?utf-8?B?VUhsaXJCWDlObW1zZ3NJZE5pNmhlYjlSUnRBWFlidlhPVXBLditROGtVMFJy?=
 =?utf-8?B?eTI1S3VnekVRbHVzTng1ZlYyc0xtaTVDVXo4M1BiU2NvRWxRL05tVWgvdVVZ?=
 =?utf-8?B?OEVGTjVpUTI5eFU3d2l6WUozTXNSalk3S0pnZTJOUmJOdXFyQkVYUDQzcHFG?=
 =?utf-8?B?b0hnUFBwS2xCY2Y2M0Z1ZSt2dXdTc2x0eno2TFZVOWdKbFlkdWorQUI3cFRS?=
 =?utf-8?B?Y3JyMnlFTUd5ZWI3M3FvNENsL0IvTlhkQ1NQYVRiOXh0MHZqQ2JDYzc1c2xJ?=
 =?utf-8?B?UU9hWlR6L25SQmZteFlTWUVvclhBV3VsYkRKa00xV3Z3S1hHcklYOTVIODlw?=
 =?utf-8?B?S0JVWlhFaCtvK3BPYVp2eUd5eVRwck9ucExKalpucyt6SjNYVStYQ3g4YnRI?=
 =?utf-8?B?WEcrd3o5VzRLb2dVRlB1dEZQeHpKUDhZQVhmS2MwYTJrSEg1ZXFWcUFkN29Z?=
 =?utf-8?B?Nys4Z3d1TE9jY0owWm9zaTdqVDRxbHhTOVRFY3NoeU5UanM2emJnemdKRGZw?=
 =?utf-8?B?TTJ4eDBKaGdhMWtaeXAzWDF3c2ZuS2pXQTR6YjNtTjlrMU9DRFo2QU1IeStu?=
 =?utf-8?B?SFdwUXp0VlVNS01jYVhiU0RySlNEN1B2aUJLekVQc09MdHlIMHhJbVo0OWpG?=
 =?utf-8?B?bUNtMzBLaXR5N2JJbHAyeXRQNEpPNlNxQ3BnY3NRQ1EzYmxrRlNuRkZXTE9F?=
 =?utf-8?B?SGNSbzhHWnQ4OE5Jb000ZVBRMlRjV2Y1eDZkR25qekR0dkhDd3NJeWphd1kx?=
 =?utf-8?B?QUUrMnk1MFR2aEVrNlpnS1R0R2VvWEY1M0RoNUxxdllKNzIwY1owekJuL1hI?=
 =?utf-8?B?eVRIZWVGMnc4SDZubHZoWHJ0OGo4bXZnbkFIK0RHMENXbmtvcTB0NFNUT1dj?=
 =?utf-8?B?dXpzQlVSRVdxTm1NdG0wb04vOHU4d1ZQN1g2NkphU2JFZkJoS3U1eXdIaUF3?=
 =?utf-8?B?cFVFNjNiWEIzcHNIaUEveVhaZHVuRXducWtFM2JiWDZ2R2J0cVYvakZuUzJw?=
 =?utf-8?Q?a3y7zAUDvaRvCuZdpuZtNg7UL?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f84da9b-84df-4542-68b4-08dd58a8dbb3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2025 10:07:22.3243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kHOq2sa39bX7uYQf9NTgyAXBaq0XgsDPzPySdOY/oo/C5Uw9L2dnfeI36NxAE+hWZbvB+Z4tIeQsfZqQRlA/JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5179
X-OriginatorOrg: intel.com



On 2025/2/28 23:24, Jason Gunthorpe wrote:
> On Wed, Feb 26, 2025 at 03:40:24AM -0800, Yi Liu wrote:
> 
>> @@ -471,6 +471,7 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
>>   				ioasid_t pasid)
>>   {
>>   	struct iommufd_hwpt_paging *hwpt_paging = find_hwpt_paging(hwpt);
>> +	bool add_reserved = !!(hwpt_paging && pasid == IOMMU_NO_PASID);
> 
> The !! is unncessary. !! is a trick to booleanize a value:
>   - Assiging or casting to bool already implicitly does !!
>   - && is already a boolean operator
> 
>> @@ -590,6 +591,7 @@ iommufd_device_do_replace(struct iommufd_device *idev, ioasid_t pasid,
>>   			  struct iommufd_hw_pagetable *hwpt)
>>   {
>>   	struct iommufd_hwpt_paging *hwpt_paging = find_hwpt_paging(hwpt);
>> +	bool add_reserved = !!(hwpt_paging && pasid == IOMMU_NO_PASID);
> 
> Here too

got it.

> Otherwise
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> Jason

-- 
Regards,
Yi Liu
