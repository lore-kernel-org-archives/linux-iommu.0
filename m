Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C906B3D6695
	for <iommu@lists.linux.dev>; Tue, 16 Jun 2026 05:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781589170; cv=fail; b=EQy6T/7VBulw+uKsWXWM16uT2JE5ApmRieA/Maz5RIOnDNxZzYiPWrELdPHFG65lmtpq3ul4ni0/iNQwZon8eCSXxYpLKfPjZSs8zWOVI5mvG1UzOL/UWZu4E47bssNpXFc2Y1CHQECD4C49fsfb3Vo9bMLGscc8xl7TJgTSywo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781589170; c=relaxed/simple;
	bh=xmGxRAkKFJcETSeubJuGehqs+rYvxKxw8Zsnfqsotek=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QVye09se36z4aClsznHKjVrzMCVTgMvYB1FFRBkcIbDbqgYYAhkEn23PsE7zgFVUkn/OLNCgS1WA2TdyT9LN/dN6p/7AI4lSJhiNvhNRCPLiZtGvpsQ2xoEHPrEPyvFihJXFYJRd+3xgIWmoPIaDsFPuWTSJYHAJ5xu8fqPz+YM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JlFF48u9; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JlFF48u9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781589168; x=1813125168;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xmGxRAkKFJcETSeubJuGehqs+rYvxKxw8Zsnfqsotek=;
  b=JlFF48u9acqTeSHU35HMHVQb5nZYGqBf+5gRnbSgZg2r2hM8JzcpglQ6
   F/Glt2APc2YhrF59E3ysmP1JT0aQOZYDioOktneoB8YvkZJKln3Kgh5Zn
   iwQR49f3X6RGwNv6acG0CVsnfgfhZWLsrB8gAWpTQ1aZUx6m4Mquazvyl
   lhbkYyjOnQKCPuppaHoIZajw2i3w+LBRbDN/9WJnySBddJgZjGcsv2oXf
   H5fywZpU9NyK7RRYiUscAi4+y9WzDwK4qZW3yDUndoMU+l+q0kG9NDn5+
   6P6I1q9IsvYlftmwLiRXspOwaVH2AF2fqfdEWwMvwBequaC9tZPghGSXA
   g==;
X-CSE-ConnectionGUID: JWk0ddsDQqq1eO0IhA3QAA==
X-CSE-MsgGUID: 8ysNwrmaSCq/OF+/ZbDkqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="93015429"
X-IronPort-AV: E=Sophos;i="6.24,207,1774335600"; 
   d="scan'208";a="93015429"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 22:52:48 -0700
X-CSE-ConnectionGUID: vLDmiRHPTIS/sSZI243LSQ==
X-CSE-MsgGUID: FL5ia9IiQ6KYlKfqcBvyTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,207,1774335600"; 
   d="scan'208";a="271741861"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 22:52:48 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 15 Jun 2026 22:52:47 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 15 Jun 2026 22:52:47 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.5) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 15 Jun 2026 22:52:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TF8Dazvev+gSfqvC9ew3I/HNjNdzXLt1lAPpnB9GRgFrfCSn0HBkT0YbFmQlbMJPhlI0riiP8JHQcZde/dOpfq43fYoGimKgj7YlUahxcGVOZS3f2DC9dodKHOKCzDO2CEIL7N3OHjgEttbSJqdPUpQOi1TtKlOcKk/B3gRmPWIHJZRrHa+ZOxKUyVHvgKy5GZvuCa61BDyd8n+ZjG16ZKDViiPSqdkE/sdsnUNkyPAYJqx9mNYr/rmRW4dxx//kwa9MSZoBY5/hwyL0ZuRGXUXAxzHlBVxYmvzJ/Zj99PghYrolQ1kZ6dwejFX9iwKPYG+0FacZX1vzkzvvcBqykA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cqL2LJiixaXJkCTW3FAyySGHQqrBIk0E0jKra4zCzz8=;
 b=cqQHJ7DInvWrOeUELClHJnBS6UGH/pjqwtpcDcnOI5ESlXpZOuuPPSR2sy72VeyGFJlG298Q8/Ze1m+++kxsHY4qafaB1NvBkUEyjp3jtiaS09Ex6oPsDpY6iuHstAcUCUVLARoOkquOFmN7pY05Rd8jReMEJoYwgUC3KG7BEdAjK9ebPGZ0n/Acin9bZZkZ+X0/J1sZEmBbf2J9XV2nJrNvYASpWFBI0f4PNiBLPYIno4OPwKfr9ejknC2GtdWuBcC/48YUq/mP6lviKOMMe7+Te/Vz9gR+grsD/19Mo+hsOKJ7rKtz62XH8qcnhCxzlYAqetB4JqitdqdX074A3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
 by IA3PR11MB9181.namprd11.prod.outlook.com (2603:10b6:208:571::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 05:52:45 +0000
Received: from LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7]) by LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7%5]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 05:52:45 +0000
Message-ID: <25810933-cb1c-46bf-87fc-7ee60ea42577@intel.com>
Date: Tue, 16 Jun 2026 14:00:52 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 1/6] iommufd: Support a HWPT without an iommu driver
 for noiommu
To: Jacob Pan <jacob.pan@linux.microsoft.com>, <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, Jason Gunthorpe
	<jgg@nvidia.com>, Alex Williamson <alex@shazbot.org>, Joerg Roedel
	<joro@8bytes.org>, Mostafa Saleh <smostafa@google.com>, David Matlack
	<dmatlack@google.com>, Robin Murphy <robin.murphy@arm.com>, Nicolin Chen
	<nicolinc@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>, Baolu Lu
	<baolu.lu@linux.intel.com>
CC: Saurabh Sengar <ssengar@linux.microsoft.com>, <skhawaja@google.com>,
	<pasha.tatashin@soleen.com>, Will Deacon <will@kernel.org>
References: <20260611172658.3421138-1-jacob.pan@linux.microsoft.com>
 <20260611172658.3421138-2-jacob.pan@linux.microsoft.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20260611172658.3421138-2-jacob.pan@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KU0P306CA0039.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:29::13) To LV8PR11MB8509.namprd11.prod.outlook.com
 (2603:10b6:408:1e6::15)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8509:EE_|IA3PR11MB9181:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bd34249-0285-4abf-192f-08decb6b7d2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|42112799006|1800799024|366016|7416014|376014|23010399003|22082099003|18002099003|921020|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: z2tmmT0gOmW7Ey+6GQ7ObtABmpWX6aCxM1bBzzOZfJkKvOLhz5mei/brOqC+13m0njhB3kyG7sBCcVlQOdNSRPjoGUf8lpe32smCB32jsSGfebcVXk1stIo/IvxFibPTmSjHwXTZHa2asB/XT9mh+T3YjT01VLAkSt9gONRsJgXpQLo8JP71hCR7nIBolq3lE3bWinKQBev427f+CWrcjhEtSgwJrQuDLF9plR/yk8mG1TRH/iZWRcSnEPG/kTs03rX0zum6ppYQ31dYOgq9ycXxSVYu6zkljsOJKBXRFvUg2kN9ZbFbAWvHl7xTi9U3fbxUyag4yc7/bxL11jAxp79op980eiaXQUHv282571lwnhml3u8A2LXUCZvGufy8Xc7a8dCpQx2SEUj+CxvH4AgVI6VD+t5tlE3RheyFqEW6cZ9axXR8Egej3/WXZgpqhSQNzk7Qhn3xb37z9q8BREWm80hSHaS5XqclxzeKcPShST3QI7XRhsi6/QfsqhfEvoIEv6gTZAOzSCvSUWkPZlOwouJtCdYN4ImGoctD0hAW9Pm/IZGcKfHK/o7XbLv3PaN771oBf9K/2B4SqFacv97a1f8D7CMXhs2GaUsCdwiwY5LKZBULJNId8ZdARSWP7DZVfkiGnXfJyLy6IRvvkiHgxDZ5KN9cZ3oy2mXDiTxgrA3tPixA/XGApCsg/ubpf81gW27PY2k5tl5jFt9m2XqXY+31fb54gH1xEf9MWwc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR11MB8509.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(42112799006)(1800799024)(366016)(7416014)(376014)(23010399003)(22082099003)(18002099003)(921020)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmZXQWo3QVIzRkJNbk1WVDJFS3pkU3JITDNqdWxLTjFacTQ3UHRidlk3bVFk?=
 =?utf-8?B?ejZlSnI3Q2xvS0NVR2h6aUpIb1JWMVF6ZXR5dm1RVUxteHZTbXFmVFdiUDgz?=
 =?utf-8?B?MndIRHB5T1JRSUszQnNNZW4xcnlBSEhQR0lFV2x4ZlFXMmlxWXFWS2RybEtV?=
 =?utf-8?B?UzBVRnZDNFNLMVlIcWZNYkphZnVhOFQ1Y2VIVU9kNm9NWno4bTdNZXVFcEo0?=
 =?utf-8?B?cld1czVoZnIySUpYOTMrblZaRGgxNHJXa3lNUFBmMXdVbU9SZ1RWMXNrOEZ3?=
 =?utf-8?B?TDV4WG9pNXNDM3V4TFovRkd2cWxYd3Yra1JoOWdTQlhOdEd5VURHclp5d3Ba?=
 =?utf-8?B?QnhlRGtXQndQcFJ4MTQxQVJxMURYQ2pwd2Nka2VtYzRET2NhaC9uTmFPZzFh?=
 =?utf-8?B?aTgzdVVlQUdxcWRpWUhRTzN1NndHek9ZY2d0dmdoUG42Vmx0T3d4UDUyVGxM?=
 =?utf-8?B?UXBnQW85KzQza0xXQmdLNHgwMStLSjJMTU0yZEZIdHdvNFBIOXd4ankzK0ZM?=
 =?utf-8?B?NmoxOVhnQlE1NWV2bWIrUmkrY2lES0d2WVRYY21ETEc0dDcrTitQL2RTNjNr?=
 =?utf-8?B?VHVHOEZPempHekJCcmt2em1qcDVWZkc2QWgzVmpZSnBTQjAzRVBHVVBPR2Vs?=
 =?utf-8?B?YVZmZm5vV0M2a1ZZbHg1Rmcwd1JsY2IvSWVMV3JQQkY0bmlTL3l4ekJZamFz?=
 =?utf-8?B?L3pIL3M0R1A2MlhabjUzSUlsaUcreGVwR29BWWtudEY0ZHdCSmtJenF0Rkp4?=
 =?utf-8?B?Ykk1V1JiU1J6MDlXazFWejZtMDllR3NxdjYwRVR1R3JZUnA1NDBrS1NVWWdw?=
 =?utf-8?B?WG5aQ25ZM3VwcmRRQjk3NThTemQwTlhCeXRiUmsvRUEyZGxwTWc0UlFCMklv?=
 =?utf-8?B?SnBFemtCVXJyK3JjSFBuV3pjWmhwL3RjOGpsUXQ0dmQ0NmdWaFU1a2tSSEt4?=
 =?utf-8?B?WG1FSzBmbVNOTkpJTS8wclU1QTJxZWdUVEVVQlQ5WmhudW1IRzczbW1sandt?=
 =?utf-8?B?YkxhTkNIUjgyWFdjVmVIMGF2eGQ4WEtMK05pbzVqMDh4V0tBUWpmTE5VSFkz?=
 =?utf-8?B?cXEzb3NCYmVSM25keG5JSVpmRHBSemVQRUNQTURDblFHVzd6dk82c0NsVVc1?=
 =?utf-8?B?dnltRkpPVXlDSnRIaTBXdWNnZU1rdWxGOEl0aDhYQXF5bjNtLzVVRkdsbjcy?=
 =?utf-8?B?OE9MNkM2dy92SXIzdkxaTmVwVzdrb3NEaW1tSE5VekRFRVd4NjV4RXNyQTBM?=
 =?utf-8?B?Tmg1dzQ4L28wZzQ4UGVFRTlyU3I3WmVDbHpMNEtvVnU5YU5DcVp1NG5SeFlV?=
 =?utf-8?B?T3lpUEtVcGRSa1E5eldyNW05THNSL3hvL3pSazZmWWx6TE1oTkJhZDZKc3p0?=
 =?utf-8?B?eG1xRXUyZ1YxanRNbVZvZHRKUGlKNzFqblo4Z1gzZjJtVVdrZ3oyNVk4ZEpw?=
 =?utf-8?B?WS8ycVUyMVRyT1lTYm15NVNYWjdyVXN0emZmSHFIZ1RyelNIQTVwMThPOGJE?=
 =?utf-8?B?WVczZHRkeGFhSlZ2UmV6ODZRNU1KZjNCRDVxZktTREoyU3JwM1VxSU1MSDZV?=
 =?utf-8?B?QjM2MnFxN05Fa0NLTjFFemdYQXVKZEM1VXpSSE9RcHM2M0NSdDBMdUNhUStt?=
 =?utf-8?B?WkJ2cUFZd1QxK3lxeVlXWkRGVm5xLzAxTnN4RVNHZDRZNU90MjluUDdKV3Q2?=
 =?utf-8?B?Mzhma3RCUUc4cER5N3Z5VkhwNU5sUXJTRHZodWwwajQvd3FRYm9MYUQrQUJV?=
 =?utf-8?B?eTM2TmZEYmhvYzhIS2hkREN1bVN2dlJmSnZKMHpUWWsyWmxSYlNBdFFKZ2dq?=
 =?utf-8?B?cUdQTWZQY0pQenR2dFN0ZlNFSFRySDRsMS9IY29XSEo3Ky9iVUMreWZPd1Vp?=
 =?utf-8?B?ejRWSCtnc3hXTTEvaWlKUmc2YkhsUlZ4RGdXQ00vd0tJRG4rWGFQUHJWZUd6?=
 =?utf-8?B?eW50Mm5lME81bTRnYU5oMURvYUN0M3drbUZFdFhyT1NNdVNua0xNcFVIVFlY?=
 =?utf-8?B?dnVWcDIvVlNBaFFPYVd6TDlMTDFBR2hyMi9WVzZ2UEV5bFZvTkNpTUNJR3Zp?=
 =?utf-8?B?MnBhK085L28xKzZsV3cyZlVZdU1GMEJCclh5R3dNVzg0TU12dmhobEM1bGZn?=
 =?utf-8?B?SVF6bmxncW9uYXJoTVovT3hBUUhYUGVPYnB1OC93SzJVS0VCaUMrSXZMMmlx?=
 =?utf-8?B?cGd4SUhNTzRKNFNWdGo0ZFozNHdyQWNhNlc0L1gvTmR3aGNkM21KUnJkRHRu?=
 =?utf-8?B?LzFMcjdPbHMrTkJqajArVHk1ck41WDFEQkdxNk91Z0NDWmc0aVcvM0NCS0t6?=
 =?utf-8?B?K2NSWGpZN1d5Q29QR3VCV2tRVjFsR2hMTWkzWU54WjJwcHRYZEN3Zz09?=
X-Exchange-RoutingPolicyChecked: kQWBJqA7bzYdXFUQXl38OHHd+mNNfo1CzaidAI57GfcQwrcnPbrAmZAbcIXCcKw814Rz+wgYeAk7RtAPnu0KwkF8hZT7UBukrgp9QWyiobItVU+zVqkGNdqW1JzzHFzye3talP61DEqVwqQFFdvGxkUJvJDuBKVBaiXKxqrPUL02uWBQieBrynqLTgqD0TwlaZ6uC5bPfRq4MafW7JeuqKvgZQykRup5kNEYV4pGRo6QRpUcSpz7Dr+yCGoB/owU3nminbZcJeuqzdYalGq13QaeU555ZCLGPlSDv/OlU/fAIKuNptoWSD8nRnb61hlOzkLKzQgjaN6IDUZ+tVzQVw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bd34249-0285-4abf-192f-08decb6b7d2b
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8509.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 05:52:45.8202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bBuCrmrUsajLKfmjRow3s2AdoF7cXdDcMEfRlvtQfo2LMC0cJaYIipzWPv4FwX6wTyt3dJYSHcaSbBQoaXJugg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9181
X-OriginatorOrg: intel.com

On 6/12/26 01:26, Jacob Pan wrote:
> From: Jason Gunthorpe <jgg@nvidia.com>
> 
> Create just a little part of a real iommu driver, enough to
> slot in under the dev_iommu_ops() and allow iommufd to call
> domain_alloc_paging_flags() and fail everything else.
> 
> This allows explicitly creating a HWPT under an IOAS.
> 
> A new Kconfig option IOMMUFD_NOIOMMU is introduced to differentiate
> from the VFIO group/container based noiommu mode.
> 
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> ---
> V8:
>    - Guard vIOMMU and vDevice allocation paths for noiommu (Sashiko)
> v7:
>    - Drain no-IOMMU generic-PT freelist (Sashiko)
>    - Import generic-PT IOMMU namespace (Sashiko)
> v6: (Yi)
>    - Sort includes alphabetically (iommu.h after generic_pt/iommu.h)
>    - Fix comment: s/mock page table/SW-only page table/ to avoid confusion
>      with selftest mock
>    - Rewrite noiommu_amdv1_ops comment: explain why AMDV1 format is chosen
>      (multi-page size options), remove references to group-container mode distinction
> v5:
>     - Use the new IOMMUFD_NOIOMMU Kconfig instead of VFIO_NOIOMMU
>     - Use consistent wording referring to VFIO noiommu mode (Kevin)
>     - Copyright date fix (Kevin)
> v4:
>     - Make iommufd_noiommu_ops const
> v3:
>     - Add comment to explain the design difference over the
>       legacy noiommu VFIO code.
> ---
>   drivers/iommu/iommufd/Kconfig           |  12 +++
>   drivers/iommu/iommufd/Makefile          |   1 +
>   drivers/iommu/iommufd/hw_pagetable.c    |  19 ++++-
>   drivers/iommu/iommufd/hwpt_noiommu.c    | 105 ++++++++++++++++++++++++
>   drivers/iommu/iommufd/iommufd_private.h |  12 +++
>   drivers/iommu/iommufd/main.c            |   1 +
>   drivers/iommu/iommufd/viommu.c          |  14 +++-
>   7 files changed, 158 insertions(+), 6 deletions(-)
>   create mode 100644 drivers/iommu/iommufd/hwpt_noiommu.c


Reviewed-by: Yi Liu <yi.l.liu@intel.com>
