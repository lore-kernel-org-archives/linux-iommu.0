Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0CA3B992C
	for <iommu@lists.linux.dev>; Fri, 22 May 2026 09:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779441298; cv=fail; b=cRJDG7j1W3VMB5F2o6NsQYcZzKhB7Ke+6dtA/yawqtu5fAoKc2FIH5ttaqiuk9ALy+/702GKpd7KRK59SF6UrtOF6QWT3LbgUBZMlwKojR8fZ1zpJIBh4m1PT53vSZoZ6G1HbzvCDTMY1D2z0YJW5uV6mLrfEe9/2+EZnceIUX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779441298; c=relaxed/simple;
	bh=b6NX327txW6JNcqjzLWi6XWZuQpA/orrieYwRf2yQP8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BR1Eo0FzQiMvWFeh7K+QJLyp9Mjk2SqK7D6yKFl8m9cF1fWD9CKp26mDrqNWjVgV0BzXGjNykyt0TP+QWyuLXvnXAfknW6urhxFjKMhchjx0RrakMoWpRMmOmVFD1oJukJAyFPExFc7eCtVm4tbQDyRxF6uppCx3D2S+vAr4Spc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VgTuBBCC; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VgTuBBCC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779441295; x=1810977295;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=b6NX327txW6JNcqjzLWi6XWZuQpA/orrieYwRf2yQP8=;
  b=VgTuBBCCUvsK0+GQvnFnUbE0j4XjlTojWlg+d5s2p2mIF4ydrURb1KiE
   uFUCAQqVF77QJWm7oURIkWgbxXaCYwYvoB/8bOe4SH4nGv+32CfEUi9Oj
   B7+ROplLxrVYVwJCCfepr8kftz/IQzVbnPwi4SKzjckWwttqO7sEErZad
   NBNIR6a+K8o54zt6oQtFhHQLqv1qlcww0bkG6lZlbft134eTmDF+b7q26
   j0d35CHqFgRPJKcGc574dTuZZ2BoZUcjewYToW0LO10c8r0uPSflmfKrY
   W84bMyCWxiK6hEbB8byFodIXZrFPKzeeuNldGDiMEOstmpaxgSsaAFLNm
   Q==;
X-CSE-ConnectionGUID: f4HbLL6vRaOAcS+c+l45/g==
X-CSE-MsgGUID: yWCaLZioSzyGUrVTOL//9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11793"; a="80099689"
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; 
   d="scan'208";a="80099689"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2026 02:14:54 -0700
X-CSE-ConnectionGUID: wZ7mk52LQ1mnuqOx5UnTHQ==
X-CSE-MsgGUID: Ty6ZOcB6TxGtmVZuPVBgVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; 
   d="scan'208";a="278973383"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2026 02:14:54 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 22 May 2026 02:14:53 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 22 May 2026 02:14:53 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.25) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 22 May 2026 02:14:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aBFLT/yB8C4DxI5UbLZvZH94/TsaSHaJYrJJl6FeCGhJiIxd5aWOZFcD6dEhaHUEuaVD/EuRv+YF5o83LJAH+YmR87k453IUEyF4E0wQBSU96I8Fr+9/qSEiAG+WAaPtYyMdIGzP1sqNue4bUHYUi1At+8tCaDCcuOFY2QAJ1/vJTJDFOKPYC7oE3/DS8VSaJNj3kiTO/xMPGMQChcWAn3Zz16MC1RgFtaPY9Z7bra2tb2PjquCYF3jWZWBhradS/XM61aN9rglrwBhz+dwLJGe1UMcA3ETjdhZu1bgtEguZ/IYMWOUELXbiCR+C9FJHby4EKg/xtn0niswNr2BI9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3B79z2SYHx9+xnja0t3Mb2kciOdj3MzOME4U+v/4B+o=;
 b=c2qxfcG21NFD24K7BIDlugQ41gDbmKGJGxOq2w6YwyhrQ4V8IarIssqk1XugEka7LT1l8VJlmnDAMkrFn15nWegMD+ZI69iwC0KqvOjDyr14qZ4v3SUcuf7KoiZ9zsLuTwIi/8ftkZ0Amf/HgMpknwlXYYpLAl7wYLTx4ymlGjid6CqbRYi8NVQ8EIKV9tUETlY5eQECzlvwMCuWniAu4KI+Bn+hAtWU8WmOwOPBEGWvmvf4uQChvAzrXPnCONfw29Qct+NJTcjU+8ZzkAywHTBgEWoEqZalhFuRxIkbIEYt3vVtgniQvyR7W4g4IkJFbv2pFXk/fmDmTRuHkzVXFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
 by DS0PR11MB7767.namprd11.prod.outlook.com (2603:10b6:8:138::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 09:14:45 +0000
Received: from LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7]) by LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7%5]) with mapi id 15.21.0048.013; Fri, 22 May 2026
 09:14:45 +0000
Message-ID: <dec4651f-ad7b-4a9c-8c25-2b68f8a85088@intel.com>
Date: Fri, 22 May 2026 17:22:51 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/7] iommufd: Add an ioctl to query PA from IOVA for
 noiommu mode
To: Jacob Pan <jacob.pan@linux.microsoft.com>, <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, Jason Gunthorpe
	<jgg@nvidia.com>, Alex Williamson <alex@shazbot.org>, Joerg Roedel
	<joro@8bytes.org>, Mostafa Saleh <smostafa@google.com>, David Matlack
	<dmatlack@google.com>, Robin Murphy <robin.murphy@arm.com>, Nicolin Chen
	<nicolinc@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>, Baolu Lu
	<baolu.lu@linux.intel.com>
CC: Saurabh Sengar <ssengar@linux.microsoft.com>, <skhawaja@google.com>,
	<pasha.tatashin@soleen.com>, Will Deacon <will@kernel.org>
References: <20260521221155.1375144-1-jacob.pan@linux.microsoft.com>
 <20260521221155.1375144-5-jacob.pan@linux.microsoft.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20260521221155.1375144-5-jacob.pan@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0045.apcprd02.prod.outlook.com
 (2603:1096:4:196::21) To LV8PR11MB8509.namprd11.prod.outlook.com
 (2603:10b6:408:1e6::15)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8509:EE_|DS0PR11MB7767:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e07e661-f032-4c85-f7f0-08deb7e2909d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|42112799006|1800799024|7416014|376014|366016|921020|56012099003|11063799006|22082099003|18002099003|4143699003|3023799007|5023799004;
X-Microsoft-Antispam-Message-Info: yBE0NiEQxbrAgb4rpYped+as3rTgpB93rhkB+51zEQEcxi8I6ieDAnHAQ11vZodxB6raul8Sqv4gLWCvCJK9PMSCUPDZNewhjwZMPhVTIbF8dxVa94r8ibykzJBJao5/4T4HGQeEYod/VY4oi38PWt8+sqLwj2zSb8DFFTHZHRqBzV96ZzrLoyQDkuj7jKX22AlphrkyMIMFNeGtRcqk6kSCI96PCMBZ25Z3VI+kNZgRWzZEFr9z2C/GXZm7F314l208LuuSs9JXNeJMorKVt0J25hSO0+cmLISPpmHReu3rBWpBXtX1S7kCm+BEQ0Am+74ETnKaCmer9JG8jvG7+hpQTDRuTK0oZehGdj/CXAYecOAAbWpzFGwrueqQQAdIA61D32bJknsIOEUS6//6ffbUp9vj7DhZHxPm6mQPGingCp0eyLxzwbmNnDpvg+BWurK6WK7l9YlUsLEi2Cboiwj/V5DX96vdcFxGQ+os+q6eqzr4/fImdlABisL88hU+qsI3/TeuKhm6qgJZReptW6P/iwQ38fqRbMQARC+J4fOekCX5OMhbX6nV86vWKBDhpq0j+KboZGiVIq3gPCgx57RSd2smYSN+bhjmhFtwJLmbaUtZO+Zf+x9YlQhUADPaiLAmlHizssZtMNxkaAAXKSdFJglwhbnpephZfIrQcVi/0TyM+jL33nXA/QjKnbjx9aPW5ASMd3qybCwTK2JECwIHSZmALdhgxBEScmLkh+4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR11MB8509.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(42112799006)(1800799024)(7416014)(376014)(366016)(921020)(56012099003)(11063799006)(22082099003)(18002099003)(4143699003)(3023799007)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a09vWXBnYmcwd0RpSW9uWURHTUJyYlJtcXpwSUVxTFZXd3o1UVAxN2xjK2c0?=
 =?utf-8?B?YzRRa1hWTUxIa2o1Mm1iSytyeGpUdTd2Z2RIM1YyZ0h4MENyZC9PbGdlYk16?=
 =?utf-8?B?L050ZW5ZSU1MWGpYeTByb3Z2Yy8wcFlkMzBDRzNOTnc5ZC9SMHJnREl6SGtC?=
 =?utf-8?B?Q3VFS29oaWpHR0ZkYksvL0w2ZFZTcHlmTG15Vk9XcUpIa3NCYWtKbWlFU0NZ?=
 =?utf-8?B?OWtLWmtaaVZJQ09KYlRVeldUcnU0RGZzV1JuR0UybnM4MzZicytnRVhtSG1L?=
 =?utf-8?B?S3V3N0svUVIvb0dVQmhWYUowOU8zcVlKM3k4anBVc1p3NkJtQXVXS3F4SUQ2?=
 =?utf-8?B?SlBWeGprVXJ6MzUyT1oyWDVBOVdpQ1Y5cExrbFl1L212b3lFOVNmUisyOHhX?=
 =?utf-8?B?OVJyOFRTQlZ5V3k4VFE2OUNlcmdjRHM4VEVxbGZ1MTM5ckdEUWVrbm5DQWph?=
 =?utf-8?B?bEY3WDR3RkhHdkZQS3phTjJjLzgwYXpaOTZBTWZVdGJnbU1lTHhrRmhWamVG?=
 =?utf-8?B?QTYyNUFubHB6SHFENi9Da1VFVkEwbVJ3NVpJUWhWdnBtQWc1Qld4Qys4Z05E?=
 =?utf-8?B?eVlTekhNenloajl3bmpmZVBMRkJKNTVlODBMZEtIRFhjeXZydXFCMXgveUJK?=
 =?utf-8?B?UW93K1JGMkU4eVlyb2ZYbWVFWFdQYld6eFE5YmYrUXZmZDlpbDN0UjFpVE9r?=
 =?utf-8?B?TDNWYUpQSzFSRGxMQU9pZnZyNjVvMDMzVlBlSXYrYjV6N2hGekNOdDdGT09Z?=
 =?utf-8?B?Q01DL0xoTEVZMXVtcm0xUTlKU0dmZjhIUFI3YzJxUytldkVMS0tpWHRRcUxx?=
 =?utf-8?B?SE5RS2Z3TThvNmoxeG9mZW9aUVRwN2wrVVR4K296cDRFcklWcHprRzRuc0wv?=
 =?utf-8?B?VDE1bVg2QVRVM0lDRzcvVlYycDB6d3VRVTk3elhJaXNCQnFiNmJ0YlNzdFBw?=
 =?utf-8?B?NzVOM2VHSGlsaTFwUjlPU2I4L1R0RWpsU09iOWtoL2toZGEvSVpheXZ2T3Rr?=
 =?utf-8?B?SXdqQ2FHWUxBcVhySTdMVWFlSG53eVdzeTN1cHlmb3lDUSt1T1owOXZodlFm?=
 =?utf-8?B?YnZBRmcrMU45Y3NjT3J3UXQ2VzlsaHBDMDFvN2phbG4ydXE4KzgybFMyWEta?=
 =?utf-8?B?bXJweHh6RHpaYWwvSDlEaUUrSTMzS2FEY0hCM0hLRDIvY1hQR3JpbjNNOElv?=
 =?utf-8?B?SzhMQWFBcm00TzlTeGtES0p6d1h5WHdiaHZ3d1ErT2I5SUJrRHJoMkxxdTFj?=
 =?utf-8?B?cnd4OWo5SkRqcGE4MHora0RCUFQ5SW5nUDZLaVR1MUkyZFpqMXE1NHBObXh0?=
 =?utf-8?B?dWxNejQvbEluNW1pVG9ZbzZzT3RQeHJ1aTN5c1JDN1poNWpDUkhSSzZOQ2Nx?=
 =?utf-8?B?dHNLNGpuN01xSWprQVdEY3duc2cwT2liMkNGYkxnWHYzMU9yUlovVlBHMGEr?=
 =?utf-8?B?elJ0cDJreWZzL3M5c1pNd3Z1WWxMYllGUnhvV0hQN0RSWE80ZlJyNGZYT1R4?=
 =?utf-8?B?cG1uRkk5SmRyeUQ5a2E0RnRlMjN6dEFILzE5UG9xZkx0a1pCbzMrNGNxNzkv?=
 =?utf-8?B?OEVwL0FEQ3V0RDhYbHIwMld6ZktOR1lqNmc4ZC9BRFNKWW8xQVE3U3JJODFv?=
 =?utf-8?B?YTZhTVpSNXhTQWFDL29WWmVPOTJpOXg1bGlwN0g2TDZ6Y0tUMzh6YVpCaXk2?=
 =?utf-8?B?Ti9MSWxjeG5EdXp4cW9RYlQ5WFM4aEpvSVQ1OE1tbmREd2pQZk5RL0VUTnRL?=
 =?utf-8?B?UC9CcnM4UDNHQ2s1TEpoVzJDY2RZU3VST2tmNloweWhXdWFaeSt2cmhJMTB4?=
 =?utf-8?B?QnpmU0V6RXpLYnlGc0ZpcHJRdlNONTFoWGhVRzF6TmtDWEJNVER0MFZ6aVJT?=
 =?utf-8?B?cWRQVmprY25DNm9MKzhtaVgwZFZrZnM4TEdsUWdMMjhFcUREbHRCbXU5aEp5?=
 =?utf-8?B?Um1MaWh2dlF6MDhZZUFQMlM0SlBKUW5HVXkwejY3SGM4MkY2U2VPMU4rRzZp?=
 =?utf-8?B?Tkw5Rms2ZVhkM3ZwV3M4RDJ1cmUyMEkvZ014cjF1V0FnaUhtVGxDSm9qY0U1?=
 =?utf-8?B?WEtkamRRTEh2aUV3SmkyeFRYR2lNci9tVHpXeHdDZGZNWTAzVGxBVjJtQlQr?=
 =?utf-8?B?VVMwbkZkRERwUHBtTDYvTy95MDdpZkhXaEdtQUJ5MHNWWHQ2S0VabVNlKzJp?=
 =?utf-8?B?U3Z6eVljSmFuSWxqQ3I0MytHWm01SnNpWjNxVFE1S1ZyK2xOTmhnTFZ6eUU3?=
 =?utf-8?B?c1VHY21zV0k3blZsUzJ5NDZiODBISnBFMUpHYVpMdXJhcUxZZnd2RmVsVVJz?=
 =?utf-8?B?MHdjalJkOHk2a1Z1RXYxYm5mRGhFT2dhQXI5Z1F0RUFmUmhGZEROdz09?=
X-Exchange-RoutingPolicyChecked: i5H9GBcA9pcFr0zOwpYdngghSAKwdfiICmVazosfidZulqw2ai9mbRgwk9H0gLnBZSiFL+/DOC0dSm6vMCnKOKmDSEqnnqIp+egc5CtySQrH17e6ZW8DXqxeo5ftQFf/YVz+2ix0AgP/mIzRrBRd/FZ6a4j17SwsAQjJHR7MCvbVQcjiW94zJqMkhVfTXvAIZhDU0k77LmBTW0uy20V9nVADZMdDvS6TULFu4NudbAJqZQpKciWgntKywiVkgoo3//6wiTmmJ04YBGiv5ESkojC3MMp8N8jEmY9F+1r9rkCZLff1TbL81ikUrrwHFiExXkcYtjOnmBDGMZn2MYf6lw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e07e661-f032-4c85-f7f0-08deb7e2909d
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8509.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 09:14:45.3403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JhZEpp/doOJWbe+f/YGbGTmyUp1p2rjcql62fsRauVnnH2ZkMT7fV0TOwVM0YSpY0/JQfZ/zP8mXCCTeUVYQLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7767
X-OriginatorOrg: intel.com

On 5/22/26 06:11, Jacob Pan wrote:
> To support no-IOMMU mode where userspace drivers perform unsafe DMA
> using physical addresses, introduce a new API to retrieve the
> physical address of a user-allocated DMA buffer that has been mapped to
> an IOVA via IOAS. The mapping is backed by SW-only I/O page tables

nit: /via IOAS/via IOMMU_IOAS_MAP/

> maintained by the generic IOMMUPT framework.
> 
> Reviewed-by: Lu Baolu<baolu.lu@linux.intel.com>
> Suggested-by: Jason Gunthorpe<jgg@nvidia.com>
> Co-developed-by: Jason Gunthorpe<jgg@nvidia.com>
> Signed-off-by: Jason Gunthorpe<jgg@nvidia.com>
> Signed-off-by: Jacob Pan<jacob.pan@linux.microsoft.com>
> ---
> v6:
>     - Limit search length (Baolu, Jason)
> v5:
>     - Fix next_iova exceeds iopt_area_last_iova (Alex)
>     - Rename IOCTL more specific to NOIOMMU, i.e.
> 	 IOMMUFD_CMD_IOAS_NOIOMMU_GET_PA (Kevin)
>     - Add header stubs for iopt_get_phys()
> v4:
>     - Fix ioctl return type (Yi Liu)
> ---
>   drivers/iommu/iommufd/io_pagetable.c    | 72 +++++++++++++++++++++++++
>   drivers/iommu/iommufd/ioas.c            | 30 +++++++++++
>   drivers/iommu/iommufd/iommufd_private.h | 18 +++++++
>   drivers/iommu/iommufd/main.c            |  3 ++
>   include/uapi/linux/iommufd.h            | 27 ++++++++++
>   5 files changed, 150 insertions(+)
> 
> diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
> index 24d4917105d9..4369447e2125 100644
> --- a/drivers/iommu/iommufd/io_pagetable.c
> +++ b/drivers/iommu/iommufd/io_pagetable.c
> @@ -859,6 +859,78 @@ int iopt_unmap_iova(struct io_pagetable *iopt, unsigned long iova,
>   	return iopt_unmap_iova_range(iopt, iova, iova_last, unmapped);
>   }
>   
> +#ifdef CONFIG_IOMMUFD_NOIOMMU
> +int iopt_get_phys(struct io_pagetable *iopt, unsigned long iova, u64 *paddr,
> +		  u64 *length)
> +{
> +	struct iopt_area *area;
> +	u64 max_length = *length;
> +	u64 tmp_length = 0;
> +	u64 tmp_paddr = 0;
> +	int rc = 0;
> +
> +	down_read(&iopt->iova_rwsem);
> +	area = iopt_area_iter_first(iopt, iova, iova);
> +	if (!area || !area->pages) {
> +		rc = -ENOENT;
> +		goto unlock_exit;
> +	}
> +
> +	if (!area->storage_domain ||
> +	    area->storage_domain->owner != &iommufd_noiommu_ops) {
> +		rc = -EOPNOTSUPP;
> +		goto unlock_exit;
> +	}
> +
> +	*paddr = iommu_iova_to_phys(area->storage_domain, iova);
> +	if (!*paddr) {
> +		rc = -EINVAL;
> +		goto unlock_exit;
> +	}
> +
> +	tmp_length = PAGE_SIZE - offset_in_page(iova);
> +	tmp_paddr = *paddr;
> +	/*
> +	 * Scan the domain for the contiguous physical address length so that
> +	 * userspace search can be optimized for fewer ioctls. A max_length of
> +	 * 0 means no limit.
> +	 */
> +	while (iova < iopt_area_last_iova(area)) {
> +		unsigned long next_iova;
> +		u64 next_paddr;
> +
> +		if (max_length && tmp_length >= max_length) {
> +			tmp_length = max_length;

nit: is this value setting duplicated with the one outside this loop?

> +			break;
> +		}
> +
> +		if (check_add_overflow(iova, PAGE_SIZE, &next_iova))
> +			break;
> +
> +		if (next_iova > iopt_area_last_iova(area))
> +			break;
> +
> +		next_paddr = iommu_iova_to_phys(area->storage_domain, next_iova);
> +
> +		if (!next_paddr || next_paddr != tmp_paddr + PAGE_SIZE)
> +			break;
> +
> +		iova = next_iova;
> +		tmp_paddr += PAGE_SIZE;
> +		tmp_length += PAGE_SIZE;
> +	}
> +
> +	if (max_length && tmp_length > max_length)
> +		tmp_length = max_length;
> +	*length = tmp_length;
> +
> +unlock_exit:
> +	up_read(&iopt->iova_rwsem);
> +
> +	return rc;
> +}
> +#endif
> +
>   int iopt_unmap_all(struct io_pagetable *iopt, unsigned long *unmapped)
>   {
>   	/* If the IOVAs are empty then unmap all succeeds */
> diff --git a/drivers/iommu/iommufd/ioas.c b/drivers/iommu/iommufd/ioas.c
> index fed06c2b728e..82bbc0c2357e 100644
> --- a/drivers/iommu/iommufd/ioas.c
> +++ b/drivers/iommu/iommufd/ioas.c
> @@ -375,6 +375,36 @@ int iommufd_ioas_unmap(struct iommufd_ucmd *ucmd)
>   	return rc;
>   }
>   
> +#ifdef CONFIG_IOMMUFD_NOIOMMU
> +int iommufd_ioas_noiommu_get_pa(struct iommufd_ucmd *ucmd)
> +{
> +	struct iommu_ioas_noiommu_get_pa *cmd = ucmd->cmd;
> +	struct iommufd_ioas *ioas;
> +	int rc;
> +
> +	if (!capable(CAP_SYS_RAWIO))
> +		return -EPERM;
> +
> +	if (cmd->flags || cmd->__reserved)
> +		return -EOPNOTSUPP;
> +
> +	ioas = iommufd_get_ioas(ucmd->ictx, cmd->ioas_id);
> +	if (IS_ERR(ioas))
> +		return PTR_ERR(ioas);
> +
> +	rc = iopt_get_phys(&ioas->iopt, cmd->iova, &cmd->out_phys,
> +			   &cmd->length);
> +	if (rc)
> +		goto out_put;
> +
> +	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
> +out_put:
> +	iommufd_put_object(ucmd->ictx, &ioas->obj);
> +
> +	return rc;
> +}
> +#endif
> +
>   static void iommufd_release_all_iova_rwsem(struct iommufd_ctx *ictx,
>   					   struct xarray *ioas_list)
>   {
> diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
> index 2682b5baa6e9..13f1506d8066 100644
> --- a/drivers/iommu/iommufd/iommufd_private.h
> +++ b/drivers/iommu/iommufd/iommufd_private.h
> @@ -118,6 +118,16 @@ int iopt_map_pages(struct io_pagetable *iopt, struct list_head *pages_list,
>   int iopt_unmap_iova(struct io_pagetable *iopt, unsigned long iova,
>   		    unsigned long length, unsigned long *unmapped);
>   int iopt_unmap_all(struct io_pagetable *iopt, unsigned long *unmapped);
> +#ifdef CONFIG_IOMMUFD_NOIOMMU
> +int iopt_get_phys(struct io_pagetable *iopt, unsigned long iova, u64 *paddr,
> +		  u64 *length);
> +#else
> +static inline int iopt_get_phys(struct io_pagetable *iopt, unsigned long iova,
> +				u64 *paddr, u64 *length)
> +{
> +	return -EOPNOTSUPP;
> +}
> +#endif
>   
>   int iopt_read_and_clear_dirty_data(struct io_pagetable *iopt,
>   				   struct iommu_domain *domain,
> @@ -346,6 +356,14 @@ int iommufd_ioas_map_file(struct iommufd_ucmd *ucmd);
>   int iommufd_ioas_change_process(struct iommufd_ucmd *ucmd);
>   int iommufd_ioas_copy(struct iommufd_ucmd *ucmd);
>   int iommufd_ioas_unmap(struct iommufd_ucmd *ucmd);
> +#ifdef CONFIG_IOMMUFD_NOIOMMU
> +int iommufd_ioas_noiommu_get_pa(struct iommufd_ucmd *ucmd);
> +#else
> +static inline int iommufd_ioas_noiommu_get_pa(struct iommufd_ucmd *ucmd)
> +{
> +	return -EOPNOTSUPP;
> +}
> +#endif
>   int iommufd_ioas_option(struct iommufd_ucmd *ucmd);
>   int iommufd_option_rlimit_mode(struct iommu_option *cmd,
>   			       struct iommufd_ctx *ictx);
> diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
> index 8c6d43601afb..3b4192d70570 100644
> --- a/drivers/iommu/iommufd/main.c
> +++ b/drivers/iommu/iommufd/main.c
> @@ -424,6 +424,7 @@ union ucmd_buffer {
>   	struct iommu_ioas_alloc alloc;
>   	struct iommu_ioas_allow_iovas allow_iovas;
>   	struct iommu_ioas_copy ioas_copy;
> +	struct iommu_ioas_noiommu_get_pa noiommu_get_pa;
>   	struct iommu_ioas_iova_ranges iova_ranges;
>   	struct iommu_ioas_map map;
>   	struct iommu_ioas_unmap unmap;
> @@ -482,6 +483,8 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
>   	IOCTL_OP(IOMMU_IOAS_MAP, iommufd_ioas_map, struct iommu_ioas_map, iova),
>   	IOCTL_OP(IOMMU_IOAS_MAP_FILE, iommufd_ioas_map_file,
>   		 struct iommu_ioas_map_file, iova),
> +	IOCTL_OP(IOMMU_IOAS_NOIOMMU_GET_PA, iommufd_ioas_noiommu_get_pa, struct iommu_ioas_noiommu_get_pa,
> +		 out_phys),
>   	IOCTL_OP(IOMMU_IOAS_UNMAP, iommufd_ioas_unmap, struct iommu_ioas_unmap,
>   		 length),
>   	IOCTL_OP(IOMMU_OPTION, iommufd_option, struct iommu_option, val64),
> diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
> index e998dfbd6960..26b4998439e8 100644
> --- a/include/uapi/linux/iommufd.h
> +++ b/include/uapi/linux/iommufd.h
> @@ -57,6 +57,7 @@ enum {
>   	IOMMUFD_CMD_IOAS_CHANGE_PROCESS = 0x92,
>   	IOMMUFD_CMD_VEVENTQ_ALLOC = 0x93,
>   	IOMMUFD_CMD_HW_QUEUE_ALLOC = 0x94,
> +	IOMMUFD_CMD_IOAS_NOIOMMU_GET_PA = 0x95,
>   };
>   
>   /**
> @@ -219,6 +220,32 @@ struct iommu_ioas_map {
>   };
>   #define IOMMU_IOAS_MAP _IO(IOMMUFD_TYPE, IOMMUFD_CMD_IOAS_MAP)
>   
> +/**
> + * struct iommu_ioas_noiommu_get_pa - ioctl(IOMMU_IOAS_NOIOMMU_GET_PA)
> + * @size: sizeof(struct iommu_ioas_noiommu_get_pa)
> + * @flags: Reserved, must be 0 for now
> + * @ioas_id: IOAS ID to query IOVA to PA mapping from
> + * @__reserved: Must be 0
> + * @iova: IOVA to query
> + * @length: On input, maximum number of bytes to scan for contiguity (0 means
> + *          no limit). On output, actual number of contiguous bytes starting
> + *          from out_phys.
> + * @out_phys: Output physical address the IOVA maps to
> + *
> + * Query the physical address backing an IOVA range. The entire range must be
> + * mapped already. For noiommu devices doing unsafe DMA only.
> + */
> +struct iommu_ioas_noiommu_get_pa {
> +	__u32 size;
> +	__u32 flags;
> +	__u32 ioas_id;
> +	__u32 __reserved;
> +	__aligned_u64 iova;
> +	__aligned_u64 length;
> +	__aligned_u64 out_phys;
> +};
> +#define IOMMU_IOAS_NOIOMMU_GET_PA _IO(IOMMUFD_TYPE, IOMMUFD_CMD_IOAS_NOIOMMU_GET_PA)
> +
>   /**
>    * struct iommu_ioas_map_file - ioctl(IOMMU_IOAS_MAP_FILE)
>    * @size: sizeof(struct iommu_ioas_map_file)

