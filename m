Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D47813A265
	for <iommu@lists.linux.dev>; Wed, 11 Sep 2024 08:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726042014; cv=fail; b=f6Jegklx8qvmEePLBS2FsQU1YMgMrU9CBail5UXmHkEEI0gGCw4z8Jg/IKU49HlKdyqJZ1y63U2OF18Y+zjuweq7hygFsiTkdwHx14KOQTsnLjOn1xIHWQT2EQqjzzNTRetmGI6v3GTm7zLiHPsjdymUEI7dpuF6Eeyp5ppvgtg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726042014; c=relaxed/simple;
	bh=StgLVTQ4Q8CoBkiBUMWkTiuvdkF1UOA574Q0i0t2Sg8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=daUcddax1p9pNdbw1DFd+vmw8NctuJaB/9Wr1nHDyIi3Vl8roPNXhFh+lpQCm0326nnT/l0QoQAivwyDmDtwTGSiOyzN6Fp3xfLSTZ/wARQWu9SJesf5erv6/KCaNzuRX7P5PzYM5UivJw1iiEdeVhakXiTsx/NXtmnuCU9LFC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FVyJf46l; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FVyJf46l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726042013; x=1757578013;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=StgLVTQ4Q8CoBkiBUMWkTiuvdkF1UOA574Q0i0t2Sg8=;
  b=FVyJf46lnimInlJwi+y1tBjCOZLX9lD+SmxRlE+FVsDyb3tAuPp9STzf
   4OtqGiVodEs3/6xtvBeA18V8fhWwlXWq6ckrztm5nv89zOahOiIR6xUYA
   DY08ICwVn7tZK3v2clOWx11ijgnYp9o84dQooMF240mSvipfhEOsaBPD1
   Mlq3dy4cHtJrwCPULLG7V1iRpxHQQqUgVJNojwUUUsOF1/F8TM9vpxuaB
   9WOgy5vxr7+5ZqzsyjhTLFViwWEw7UG3afaOsfwfZhAz55QzfPKhB2wgn
   62kEGzeYsPO0oq/GPa0nY6cahowk2elTIugIO/YSaSn/77MecZdpUosy0
   A==;
X-CSE-ConnectionGUID: NdJtyBCMSRKjq3OoYF7bUg==
X-CSE-MsgGUID: bW9U7fl6SHG38ISzO0wyMw==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="13468522"
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="13468522"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 01:06:52 -0700
X-CSE-ConnectionGUID: BVacyo+GSNGxOehxaHR3Cg==
X-CSE-MsgGUID: KtGiSQnPQFurjbbhKrFNjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="67516778"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Sep 2024 01:06:52 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 11 Sep 2024 01:06:51 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 11 Sep 2024 01:06:51 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.174)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 11 Sep 2024 01:06:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GyVqK3emPxIj8m5nKKgh8NeJZhHc/RLcUl9TC3kUl8/Q+u+wnWSgLWE0ZwNLMFF8tMpdBtYzwYlcAgsfIBgn5NBCxOVkduW0KfJ9BKXSP3zd0klywNhg8KR8xXZfS2xECCpWCl71yd1efGHfHyRLuHYu4zFUsjfcOJ3PsHf8aQKTqSK1kAOfxCcRkP9RZkGV0OWW3qdZbOU5ExDYpzCxc+LVyJvsdXIcLZJKy4v5Jt9xLIneVsISeVBDYEV/W/476IxE2mVRTjGkMfzpBdDMcP0Y0WTsaQmLqaC2FNFAPV7R4x72+mVkg7wzSqN5nSQ2uzN+z5EOd9gB0TatqAMrIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=StgLVTQ4Q8CoBkiBUMWkTiuvdkF1UOA574Q0i0t2Sg8=;
 b=WNWUofaD3T+ShbMFnyCV8HhwTJloqfyhErTDxNpJLgO7nEdEG5hcpeN13iGAuNQmF79fcbsvVFqcq5t45LOBV3MCrYiGDPOk/+cFkH4nQl2KmOpYgU0n1qTAvYfoMZ0if+f2Zlp9WknkFmu+/HPlkt3nAKhBphbqoYVIM3jjeGI9kIe6//NccgvWSSzAW2Bv2P+UT75qg46CpaxDi15E0k1gkstueYG/MvktxAfcjMjO3xJXiavqP9eFRs5VPqQXd84OZLYnphETTMoIF9vaSSvnii7sY1sHnwMbwqaw0xXdlurY6giQmHty/TdNJl/2BQrcEnNxS4KGlNK0o3LoBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS7PR11MB5990.namprd11.prod.outlook.com (2603:10b6:8:71::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.28; Wed, 11 Sep 2024 08:06:48 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.7962.016; Wed, 11 Sep 2024
 08:06:48 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: "jgg@nvidia.com" <jgg@nvidia.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "smostafa@google.com"
	<smostafa@google.com>, "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Subject: RE: [PATCH] Documentation: userspace-api: iommufd: Update HWPT_PAGING
 and HWPT_NESTED
Thread-Topic: [PATCH] Documentation: userspace-api: iommufd: Update
 HWPT_PAGING and HWPT_NESTED
Thread-Index: AQHbA8HilXdinS6eGEuxGnxiyd221rJSKXpAgAAH+QCAAAjYMA==
Date: Wed, 11 Sep 2024 08:06:48 +0000
Message-ID: <BN9PR11MB5276C5EEA6AAF9540707AD238C9B2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240910204111.7969-1-nicolinc@nvidia.com>
 <BN9PR11MB5276142EF52299176BA3179F8C9B2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZuFHGHd2S+r6XzyN@nvidia.com>
In-Reply-To: <ZuFHGHd2S+r6XzyN@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS7PR11MB5990:EE_
x-ms-office365-filtering-correlation-id: 1f7e3717-1a2c-4346-631d-08dcd238af94
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?eGxFVmRIbHNFakljaWZOTlJqbFQ5VWRnVjJrdEZQUS9WcFFyUWYvWjg1MjRW?=
 =?utf-8?B?R0o3cUcwbThjeXI0YlIweGN2UXFmUzdYS0dwZzUvS3VNZGFLRlk5U1Z2emZC?=
 =?utf-8?B?QUZQVkIxWkFxeUFBRmtybmwvYVR5WHVUVHdiZ1JWUERkKzU5RjFjUmFkaDhX?=
 =?utf-8?B?VkhXeVZjQ3pDQU5wVFo3dUdNQ1ZleXB0NmZUNEU3MEs4aURZa0RQa2s3VThP?=
 =?utf-8?B?SkZsZmtrTWhlc0QrTC94VjdhSjEzSTY3ODhvTDNmbUtQaDdUL2thcy84aDNz?=
 =?utf-8?B?NkxqRHFRTTdHZ0hnWlVzd0xMOWdQR3U4NHJsZHFmL2Q0K05ES3VCa0tGdS90?=
 =?utf-8?B?MFVzYndMOUVZOXF1R2VsZkFPVWx2bW1qdFBwdDhRb2FLdUFTQ2R0SlNxMEht?=
 =?utf-8?B?YnJwU1hqQXpSYXpjWFd3OE9BR3FVOG5xRUY1bXdab3pvOXh6dE5acG45Nllx?=
 =?utf-8?B?Wk9CcnV5RDNJUDdCakF1UWd4THF5eXQvZE5ab2pmSXZFaEtxa1NPVm9MTU01?=
 =?utf-8?B?T0psc0ZaQ25vbkpvZGJ6dHhuSXJmZE4yR2IwZWt2c3VjQVJuc25wQ2Ixb051?=
 =?utf-8?B?OVcxek9UT1l0ZkVZblFuSG5uNm5ydEdENG9JTE9iMFhoYU1BMmFiQ1p6Q2FK?=
 =?utf-8?B?SDcwdDJ6ZldCbi96cmNGQlFkVmk5ZjRzNE54cW50anp5b2RsV08zRmx6bXEy?=
 =?utf-8?B?VEVMSzdNQWdPUFlyaHF3RlZDTkpFWGx1S3ljUDhua1hlRXEwU0h4UE9tZGlD?=
 =?utf-8?B?LzN4YUYrYVliOThXVk56aWo2UXZyMUF5TVNVdUpRSExkTWVCQm51cWVibHEw?=
 =?utf-8?B?bDZLL3RMMWpTZjdHODR6MmtwWEw0SEltRjRyZjJvSitkbVQxL3dzcXpPczhU?=
 =?utf-8?B?ZnYvbXdjYXdyOWFsSFQrM3VsUmZRM28rNzZVWG9IYko2RDJFWHJjSUFwVGRH?=
 =?utf-8?B?b2JTRmFUZEZyM3E2N252TGM4emRrNnI3SmdNZ3BVaEVKOGo5aHRBUEFaQ0Rx?=
 =?utf-8?B?RkhZVWpTTFJlb1M0T29PN3hNMXJWdEZ1R1hZVHZPNUdHb3dzMVliTG16OWFo?=
 =?utf-8?B?MEkrSEtwME9CYXJxSHg3dHNiYktFVUVWTUJ2UU41dFNEMDlobGlESWR1L2pt?=
 =?utf-8?B?OVdLeXZMWHZQaHhKeGl6QUpBTEc1T0ZGcXFCVnY3T2FKSlEyVXkwY1ZZNldm?=
 =?utf-8?B?OTZ2RE9mRE5FOTBWdzBoZndrS0NSelk1ekJXSVJheDdVREZSMXBHM0Fuc2JM?=
 =?utf-8?B?blVyTzl3eE9VN0Q1Y0l3UnVVZXdtdTZwempEaWFSdkZLY2NFamdHN3AzZ3lH?=
 =?utf-8?B?TXBPdnIrREM2YmVmbnRrOVU1dlFWRnlCc1VtVkJ5MjdDaUpwZHliL2dpbnVE?=
 =?utf-8?B?REQ0Y2t6UThMU3lOenF0MmlodG4xZ0FuTzE4TWJiWWRwQzhwVVJBRlMyRjd2?=
 =?utf-8?B?cFBBYjFQUHZIQ2RHRTVlTkxQMVJXRW9LL0xNTXZEdHNIaERGNmZ1dGJhRkhl?=
 =?utf-8?B?MDNKSDZGUUdTcUd1QjVROUhRcmNRdlNnWG01MFRhRW85OWlTMWMvdHExQ2Vy?=
 =?utf-8?B?UXUwZHJTWXZQVHRtQWJoOTJpTWhqSmE1Nnd5djdGTDV1TVpMaC9hcGFJUEUv?=
 =?utf-8?B?cGRYbTJZeEpUdjVOOS9EYWpaeThUZlhkUWpOU3NvYXJRM3ZvTXhrTy9sVGY0?=
 =?utf-8?B?bk1zODVmcWoxcy9sRjlHaHF6TGwzbjZ4ajhLUCtRVnpIdlVwUmxSSzYyZFdi?=
 =?utf-8?B?Nk1laXd4eTc0eWFsRHZDdnZHYnpQREpiUitvSW45amgzcWJIQ0wraVAvOFdn?=
 =?utf-8?B?VW4vdUo4OXNyMVliWkxJTFA4YktyeUdZTzZVajI0TzVGNlZ4dlhubm0yTDBM?=
 =?utf-8?B?TzJpMWlGR3BWMkdZdk41WWZ6MDhxSENOS2s5SWhCb29Uc3c9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MUFlYm43MEFZd0FvU0J5a3JFdllUOG5KRXpUVkhJMTVtUW5LK3dzRXV3VWdS?=
 =?utf-8?B?elJCYkFMVGZUYTVLdmdWT3NsalRpWklCS01HckpWUTNFeDRJb0IwYzRacFhI?=
 =?utf-8?B?SXJ6ZE5iK0ROSGRCS0liMEVTY1BWMTZOUis1TlROYlRZLzRjcWx2Z3BpQ0tr?=
 =?utf-8?B?YkdJTWw5NVNMbndodFlZSU9UL0tEemswdisvK096dDBOZ3Q0MUJJTXI0Y0VQ?=
 =?utf-8?B?Ymg1QTVHZzAxZWZleHVXRVpxTTFOeWtjY0VvL3BjdHJYaDZLWStNaFJITTNv?=
 =?utf-8?B?VVJVYWtVK3VUckUwN2RGQ0JENUY2TVdVQ3JwUXMrZ0loaVFHNXkvV29FVDBz?=
 =?utf-8?B?UitjbUxiN3RpUncxR3g1MmE0a2E5WEo3SitiTnU2UXpQcGZKWHgzc3ZpMVdp?=
 =?utf-8?B?ZStDWFFPSWE1QzVSQmNKU3MwMDFjOWVIbE82SjB1dVNmbmJtZWhqalJJR2xj?=
 =?utf-8?B?TWo5ZDZDL2x3dnNLRGFXckxQam02NEpzeC84dFNEQllTTXFqMWNKQzV0bElw?=
 =?utf-8?B?ZWV5dDI0aTA2STBPRXRaUkRFN1k0OC83cDBNVXpMVnp5N2xpWHQ1R2tyT0Vz?=
 =?utf-8?B?NWpTVFJ4R3JabThmS0EwQXlMU3A1NTZoTmJ3dnhnS3EzYlNWcDFsTld5VlAr?=
 =?utf-8?B?bTdlM0pHVXhxTlp5dk4yMnVRQ0NhQUdrdUpWdEhOdUY3ZUw2bDB1N05meHc2?=
 =?utf-8?B?Um4wbW4yNXZvSWFiN3BNQ2Y1MFAyckZDUVE2N3Zmc243bFVWNjB6cG50Z1NZ?=
 =?utf-8?B?TGFLOWVjZGwweE5EekN4ZjN2aE5TZWRPdkpjVDU3M1VtYWYyNEtoWVRoYzBQ?=
 =?utf-8?B?TjYxZm5KKy82ckJzcnNhUGcvOTlqVVNxOVJkSHUvNG80VStQMnFTekFpM0hR?=
 =?utf-8?B?Q05DWXNOWEZPdmU3Ni8xaHlrWHc0VUp4Y2puTzNWckdxQ3NRZ2VRTGtad29m?=
 =?utf-8?B?Y2RSMWtZVVEyWGhCQlh5OGR0MGFuaUUvOXRuRHdqdVB2UFBVdHZuNXRPWWVN?=
 =?utf-8?B?YkcrQWhuNXJqZm9NU0gxQUV4TW83c253Nk1GbFNHZzIvYzIvYWRnTlpDUGtl?=
 =?utf-8?B?VnBtT0JGZWZtK0l2RFJNaXJXQ0ZLeXNCcjRDMXoxbUNvRFY1bTk3cWlVTzVr?=
 =?utf-8?B?ekpwS1JNcmRTT1cwV05Gb3A0OHJyLzY2Q2thSFBaMVI3NzJLY0dERmZ6RXF3?=
 =?utf-8?B?VUpwRTRHckhRemxHcDUxWnlacTRtcngvYlgzYXh1SGp6OTBoQ3BWVXFTci9m?=
 =?utf-8?B?eDNvNVZkQit6dTB3cVR5TDMyeE5HejJIZ1hTL2Zxb0Zma004UGtzQ2MxT2FR?=
 =?utf-8?B?V3h1SEl3WHBmdVZaWXVGbTR5U3NETHV4M0RPdG9rN2JPR2VnR295ei8zemJa?=
 =?utf-8?B?YXY5UUFhNzJtOExTZVdsZFY1TGRWTmhsdzIxQUVhWG1pVHJFem9XY2RERVNW?=
 =?utf-8?B?K3M5NS9rZ2NBd3dCVTFQc1Rpekt1TTlBM0Z3SDhMVS9uaENGNXJhbWtqSklN?=
 =?utf-8?B?c2RvZDRReDZTeWMxby9KTjdaUVo4NGtQU3IyT3huTXFjNmIyRjY0aE0yU1ls?=
 =?utf-8?B?anN1aDI1anMrUHZZazB5NThQODdDVm1QK1d1REJNK1NOQnQ0ZG1KTVBEOEha?=
 =?utf-8?B?blJMSmtVUU50ZTRYMnFUOHVBcFhtOVN0YjVtTVY1SE5hcEI1SlZkWGswL2JD?=
 =?utf-8?B?aCt6UHdEMFVqbi85TGFpa09jclNxeVFxeGlLM1JKN3FJL0RlWUpmZjhxQ1Jt?=
 =?utf-8?B?TkdmSkdmVmV2c0tEY0dEbHhkcXhFTnFRZHJzTlh4UjVzNWZwQ1ZCNDhFOGtX?=
 =?utf-8?B?am1SaitLaXRrOUNiY3NCZ2grdzFNS2RhbmcvelliZUJJNzRkaUd4K1UyYUdq?=
 =?utf-8?B?L2VObGRzYS9NZjNJeE94MWl3VFRjSzJUdytOZXk4bW0zVzEvVWxHb3E0c2JI?=
 =?utf-8?B?VU8vb2dwMU9JelprTWptaTFsT1hnSTJncmQzQTlhbExlMHE4N2NHVlZ1R1gv?=
 =?utf-8?B?QW40WFFnTzlNTDFvdC83d2ora3RyYjJscytHZ1JYNUdwdm5kNVFtbStiYU9m?=
 =?utf-8?B?NUMyYm1melU4ZXNJa0dJWGtVL3YrZCtHUGxydS9DdnRmV2ZJQ2xMbnNzU05Y?=
 =?utf-8?Q?I2wDg5TtdXgT2wMd9r1Az0b4D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f7e3717-1a2c-4346-631d-08dcd238af94
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2024 08:06:48.4978
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GOShbeGVX9jlpMYhrlguRzDSHHIJqT9UHgUvMYgMWAB5TGdsI5NABTOlIn5asbgJZC9pYzAFRoqeJNeokrzGsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5990
X-OriginatorOrg: intel.com

PiBGcm9tOiBOaWNvbGluIENoZW4gPG5pY29saW5jQG52aWRpYS5jb20+DQo+IFNlbnQ6IFdlZG5l
c2RheSwgU2VwdGVtYmVyIDExLCAyMDI0IDM6MzEgUE0NCj4gDQo+IE9uIFdlZCwgU2VwIDExLCAy
MDI0IGF0IDA3OjA5OjE1QU0gKzAwMDAsIFRpYW4sIEtldmluIHdyb3RlOg0KPiA+ID4gRnJvbTog
Tmljb2xpbiBDaGVuIDxuaWNvbGluY0BudmlkaWEuY29tPg0KPiA+ID4gU2VudDogV2VkbmVzZGF5
LCBTZXB0ZW1iZXIgMTEsIDIwMjQgNDo0MSBBTQ0KPiA+ID4NCj4gPiA+IC0zLiBJT01NVUZEX09C
Sl9IV19QQUdFVEFCTEUgaXMgY3JlYXRlZCB3aGVuIGFuIGV4dGVybmFsIGRyaXZlcg0KPiBjYWxs
cw0KPiA+ID4gdGhlIElPTU1VRkQNCj4gPiA+ICszLiBJT01NVUZEX09CSl9IV1BUX1BBR0lORyBj
YW4gYmUgY3JlYXRlZCBpbiB0d28gd2F5czoNCj4gPiA+ICsNCj4gPiA+ICsgICBJT01NVUZEX09C
Sl9IV1BUX1BBR0lORyBpcyBjcmVhdGVkIHdoZW4gYW4gZXh0ZXJuYWwgZHJpdmVyDQo+IGNhbGxz
DQo+ID4gPiB0aGUgSU9NTVVGRA0KPiA+ID4gICAgIGtBUEkgdG8gYXR0YWNoIGEgYm91bmQgZGV2
aWNlIHRvIGFuIElPQVMuIFNpbWlsYXJseSB0aGUgZXh0ZXJuYWwgZHJpdmVyDQo+IHVBUEkNCj4g
PiA+ICAgICBhbGxvd3MgdXNlcnNwYWNlIHRvIGluaXRpYXRlIHRoZSBhdHRhY2hpbmcgb3BlcmF0
aW9uLiBJZiBhIGNvbXBhdGlibGUNCj4gPiA+ICAgICBwYWdldGFibGUgYWxyZWFkeSBleGlzdHMg
dGhlbiBpdCBpcyByZXVzZWQgZm9yIHRoZSBhdHRhY2htZW50LiBPdGhlcndpc2UNCj4gYQ0KPiA+
ID4gICAgIG5ldyBwYWdldGFibGUgb2JqZWN0IGFuZCBpb21tdV9kb21haW4gaXMgY3JlYXRlZC4g
U3VjY2Vzc2Z1bA0KPiA+ID4gY29tcGxldGlvbiBvZg0KPiA+ID4gICAgIHRoaXMgb3BlcmF0aW9u
IHNldHMgdXAgdGhlIGxpbmthZ2VzIGFtb25nIElPQVMsIGRldmljZSBhbmQNCj4gPiA+IGlvbW11
X2RvbWFpbi4gT25jZQ0KPiA+ID4gLSAgIHRoaXMgY29tcGxldGVzIHRoZSBkZXZpY2UgY291bGQg
ZG8gRE1BLg0KPiA+ID4gLQ0KPiA+ID4gLSAgIEV2ZXJ5IGlvbW11X2RvbWFpbiBpbnNpZGUgdGhl
IElPQVMgaXMgYWxzbyByZXByZXNlbnRlZCB0byB1c2Vyc3BhY2UNCj4gYXMNCj4gPiA+IGENCj4g
PiA+IC0gICBIV19QQUdFVEFCTEUgb2JqZWN0Lg0KPiA+ID4gKyAgIHRoaXMgY29tcGxldGVzIHRo
ZSBkZXZpY2UgY291bGQgZG8gRE1BLiBOb3RlIHRoYXQgZXZlcnkNCj4gaW9tbXVfZG9tYWluDQo+
ID4gPiBpbnNpZGUNCj4gPiA+ICsgICB0aGUgSU9BUyBpcyBhbHNvIHJlcHJlc2VudGVkIHRvIHVz
ZXJzcGFjZSBhcyBhbg0KPiA+ID4gSU9NTVVGRF9PQkpfSFdQVF9QQUdJTkcuDQo+ID4NCj4gPiB0
aGUgbGFzdCBzZW50ZW5jZSBpcyByZWR1bmRhbnQuIGhlcmUgd2UgYXJlIHRhbGtpbmcgYWJvdXQg
aG93DQo+IEhXUFRfUEFHSU5HDQo+ID4gaXMgY3JlYXRlZCBzbyBpdCdzIGltcGxpZWQuIHByb2Jh
Ymx5IHlvdSBjYW4gc3RhdGUgdGhhdCBIV1BUX1BBR0lORyBvYmplY3QNCj4gPiBpcyBjcmVhdGVk
IHdoZW4gdGFsa2luZyBhYm91dCAib3RoZXJ3aXNlIGEgbmV3IHBhZ2UgdGFibGUgb2JqZWN0IGFu
ZA0KPiA+IGlvbW11X2RvbWFpbiBpcyBjcmVhdGVkIi4NCj4gDQo+IEkgZG9uJ3QgcXVpdGUgZ2V0
IHRoaXMgcGFydC4uLndoZXJlIGlzIHRoZSByZWR1bmRhbmN5PyBBbmQgd2hlcmUNCj4gaXMgIm90
aGVyd2lzZSBhIG5ldyBwYWdlIHRhYmxlIG9iamVjdCAuLiI/DQoNCnRoZSBvcmlnaW5hbCB0ZXh0
Og0KDQogICBhbGxvd3MgdXNlcnNwYWNlIHRvIGluaXRpYXRlIHRoZSBhdHRhY2hpbmcgb3BlcmF0
aW9uLiBJZiBhIGNvbXBhdGlibGUNCiAgIHBhZ2V0YWJsZSBhbHJlYWR5IGV4aXN0cyB0aGVuIGl0
IGlzIHJldXNlZCBmb3IgdGhlIGF0dGFjaG1lbnQuIE90aGVyd2lzZSBhDQogICBuZXcgcGFnZXRh
YmxlIG9iamVjdCBhbmQgaW9tbXVfZG9tYWluIGlzIGNyZWF0ZWQuIFN1Y2Nlc3NmdWwgY29tcGxl
dGlvbiBvZg0KDQppdCdzIGNsZWFyIHRvIHNheSB0aGF0IEhXUFRfUEFHSU5HIG9iamVjdCBpcyBj
cmVhdGVkIHVwb24gc3VjY2Vzc2Z1bCANCmNvbXBsZXRpb24gdGhlcmUuIFRoZW4gbmF0dXJhbGx5
IGV2ZXJ5IGlvbW11X2RvbWFpbiBpbiBhbiBJT0FTDQppcyByZXByZXNlbnRlZCB0byB1c2Vyc3Bh
Y2UgYXMgSFdQVF9QQUdJTkcuIE5vdCBhZGRlZCBieSB5b3UNCmJ1dCBjb3VsZCBiZSBjbGVhbmVk
IHVwIHdoaWxlIGF0IGl0LiDwn5iKIA0KDQo=
