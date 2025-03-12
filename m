Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E9B1CA9C
	for <iommu@lists.linux.dev>; Wed, 12 Mar 2025 06:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741762527; cv=fail; b=rQTvzfjXjtCGyx4fmkvP71+8j5vC6j9Ar014tTsUH2/e63i9TjzdADf2XjMAAVLsR55vLytidKcjAu77htD9xjUk/forj3zHUldv8KhuAFCk5Aud3EUEsWmmjVfMBKENuyuOV7TQVbuplLlZxSwKR34QY3WmrW+Ju3of5R6klQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741762527; c=relaxed/simple;
	bh=Jn6jzyBoLxdtP4748kMMidHwa676Ghrn2NJz6WdswiU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L+0MzBLXBs7IOQxfRKasVDuMW5rU3SFg2xZQoTZZJcLt3sMZ0s/TGV5b6p3Ylv4BQPii6oGUNNSzc9FTJONpPvjQluxihE5fffn/EshnRS483AdNAbd4lJuqW/qrJvi1Sb0HoOeR07xeAnUEo+aFSzrqdO0DfSu4+R8IOjPqAIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g2et291L; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g2et291L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741762526; x=1773298526;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Jn6jzyBoLxdtP4748kMMidHwa676Ghrn2NJz6WdswiU=;
  b=g2et291LwmROjEQrdb09ZwekXzs1ec87/LtQ7HDPG/jJn4N5tiR6TNuY
   POmnIoxVCCCMk4WMX6K6Vi53HSQxy8E8cmYnVRSStHiE4dz5anH3OiCX6
   TtRyh16HgYFWVN/KReUAoMQheKVOKKkCK1JWBrxCds0QlJ6d3KBOVBa+a
   uNy30dlx0KaeZGf9rwUgGN/3p248pKxy/Z7hT5VNuLQpa49gDXEi9YzHu
   g3omh2IblSBGwUmfV4WBRO2DJje2JF/rAzv42xgeKMHm74M5WGGjfM4Fe
   0Aj7ZluDtN7N7gpr5jTe7tT+3SZCYh5cwMPwjfsXEpOYdPGK2RmVDszeg
   w==;
X-CSE-ConnectionGUID: BN9MNnkRTtuIsGZOlo2uCw==
X-CSE-MsgGUID: uL0jZPY8R9CPYaS2bawzIA==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="42701152"
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; 
   d="scan'208";a="42701152"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 23:55:25 -0700
X-CSE-ConnectionGUID: ew1yik6HQOm5+5xeIn1t5g==
X-CSE-MsgGUID: R+QOXZbjSC2d035z3a7ozw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; 
   d="scan'208";a="125583217"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Mar 2025 23:55:25 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 11 Mar 2025 23:55:24 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 11 Mar 2025 23:55:24 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 11 Mar 2025 23:55:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bN1NpP3DRN9H0y/7NTX7DaQnFPx/T4SexZf6qeHtJjgLX4hy39nNJl0sODYBlCu3nVLbEhSFTgIoM2XpwxCCJe+wc15VOAUTyegWQCo07Cgwfubgvi01nWj96ZxyOM2sJTULnGMffRZmnyl5rqUkJDltGALTj5Eo8pTnBPrATlyTv47kcZXF/ZVA8BRLPBDN4Yjk7gAOhbYi4uN28HdxY7tX/aDfNGv9zofFiBwWhPRkbjtKhzZqdIHHEWnHWbw6EHhJkxKnudNq5Pzdew9dr4HwMIwG7H7SkBi3Md1heNf11hxhSTsuHEDh7TrGQRX6DmOXIC3yHaVAia7d875jdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jn6jzyBoLxdtP4748kMMidHwa676Ghrn2NJz6WdswiU=;
 b=llnDVBjn8/M7ZavF23ukYcbrLUT+ZRGwUdjWBFLIq3rLcb0Bb+vfJ6O7coaDC1SW2cD//0/IVyveQ2zk5fxOpQyZwX7G6R2YVkGHblEOca3WvRlipN/b2gf7V1U8wfM9gL3iFY5YCFlzmx3N0v9PZutD8/16KadSLNtsh9R6AhB25gb3tPb57iZOvzvNkKhGaNwJwaav+xoMyPcJHkfLMMDVEMkVSvssnRfvWqtNwU/TMoiMxH2BU2itNSp6OLiqDkdCeVPZfxQw6ew5k4MgYhNBzv1r2cH3x6IBXQRkmUenIBahSTXN/4WfY1PL7x4D3DKW+eT9BeDw1R8OeBBdeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM4PR11MB6065.namprd11.prod.outlook.com (2603:10b6:8:60::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 06:55:07 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 06:55:07 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Vasant Hegde <vasant.hegde@amd.com>, Jason Gunthorpe <jgg@ziepe.ca>
CC: Robin Murphy <robin.murphy@arm.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "joro@8bytes.org"
	<joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>
Subject: RE: [PATCH] iommu/amd: Add Secure ATS support
Thread-Topic: [PATCH] iommu/amd: Add Secure ATS support
Thread-Index: AQHbh3UOCMVRgdan70yjYJFDyKuOHbNX8z2AgAANboCAABr8AIAApFIggAAJnQCAABasoIAAQ3owgAIlpoCAAYmhAIAD6loAgAvA6wCAAqobEA==
Date: Wed, 12 Mar 2025 06:55:07 +0000
Message-ID: <BN9PR11MB5276F713B27471DF7100EE3C8CD02@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250225105829.52223-1-vasant.hegde@amd.com>
 <be9d2ad2-0f9e-4d06-952b-4cfd6ae53447@intel.com>
 <ce86ff90-377e-49fe-9c4e-d2ad7abeeec8@arm.com>
 <20250225145518.GJ545008@ziepe.ca>
 <BN9PR11MB527624C1DED16B3C049D13438CC22@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20250226011750.GB5011@ziepe.ca>
 <BN9PR11MB5276B3E410FD336A3062FA5E8CC22@BN9PR11MB5276.namprd11.prod.outlook.com>
 <4fba254e-ca47-4e7b-baf3-0228d9605c2b@amd.com>
 <20250228145636.GL5011@ziepe.ca>
 <BN9PR11MB52760B287D6878AD98A1D1598CC92@BN9PR11MB5276.namprd11.prod.outlook.com>
 <921dbe7c-1079-461f-a9b6-49afa4c035f8@amd.com>
In-Reply-To: <921dbe7c-1079-461f-a9b6-49afa4c035f8@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DM4PR11MB6065:EE_
x-ms-office365-filtering-correlation-id: 6eb3942e-720c-479b-133c-08dd6132d344
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RldMbE1WU0MrL1NjdG1VOWJCV2Q4S0YzTjZ6UjVOZmlvbEZxT1A0YmpWSENK?=
 =?utf-8?B?aEE4Rk1ZRjQzUk1oRmR1eFRrUkFyaXloSkpQaVhsZjAyT3c1RVV4MHNzOGJa?=
 =?utf-8?B?NlFHc0xWaG9ueVJpTEpBMnpJbjk5UUNGSFJtUVVCeElUaGhTR0RnRHdvNTJI?=
 =?utf-8?B?Z1lyS2k0UGUwVXRrYVQ3RmFrR3lVbHBnMmxSNUJjOUo3bzNEdndicjJ0UmY2?=
 =?utf-8?B?VFlkQ1V4RDZ3U3RSN3p4UUJRSWRKb2tPcUY5NVg3eTh1QTgrd1ZxZDcrSHds?=
 =?utf-8?B?SUNCQ1JDYkh3YVJmT00yd0N5WEZIOGx0MlFQMjJkSVd3enJrQ2tDekVCRkln?=
 =?utf-8?B?VXdzUlZpTnh2V3NqZytWNGNKSXhTTlcvSzJ4QWJldExWRlM2bW9tcmJLSm5L?=
 =?utf-8?B?dFZxVkdBMXF2TVJubjR0M0VsYXgxMis1bTFrOTFmU05OSlYrdlJ2cStpQVcv?=
 =?utf-8?B?MEV0b0ljdFZHSGhHMmVEcVBuVWVMQnBIR1BVNTRDSE5YQ3pMRnJEUFpvZzhw?=
 =?utf-8?B?R0FKNWwzM2IrL2tiRzUrMkc0cnBybEh4clhpbGhBb296UkEzakZEMmZCZWt5?=
 =?utf-8?B?Uy9kQldkaWwxMDFCYW8yWllRcnp5cUwzOFZkME9PRHBUVmNETkhMVTdXQW15?=
 =?utf-8?B?aUM4TzVkdGpiaFNpSUo3V205ZVZrQVF3Ui9KL3NROG4xaGxtbDlWcnllbTdr?=
 =?utf-8?B?c3dBajZYTGQ2WWVzL2liRU54SUNRSThKZ2lFRkxHcE9Mdjl4ZmJPWHlRdkZo?=
 =?utf-8?B?WVF6emVsbmloTExtSlc4MFNKanRkbm9QRjFNazRUSXl5RlV4Q3UzZVl3S3FI?=
 =?utf-8?B?TWJPL0t5aU9WR3NWWm5CK016cENNRzFJQkJESElEOWk2aXBUTE1tc1hXK0Fz?=
 =?utf-8?B?eWVaSUxuYlNjTzJza2FMdUZuQ0VvYzVNc3EwSGpWa2w0SkRRODJySGMwSmk0?=
 =?utf-8?B?Vk16MXdGbitBTFpzUDBSaVd0Qkx3a2h2TnFVdlpWRk5LWFFZUXBhak02R3Vl?=
 =?utf-8?B?UGk4VS9JQ0xoQ29wNFdtUjVUaEo0STVqTWc0U0NqdXlyTSsweVpjNDBPNG8x?=
 =?utf-8?B?MGVOaEUxQlNOV0lBU0xjdGk4TFpuUUZIdnJ3UjFuOHBSWFRJWWtFeWlMOFJ3?=
 =?utf-8?B?R3ZlTGloMXlISmVBckt3cnBmamVTdFZFYlhrVHF6d3hrdWRqb21CVEpaVENj?=
 =?utf-8?B?Q2lBNUNCR0FXazhVa3RuU2dZY1Z0cXRCT01qSW4zdWs3Y2QyaFBIbGIyR1pE?=
 =?utf-8?B?dWwyTmZ6SjluS3hDc2lHMHRVdFowcnFyWUdxSXhGNUgyay8yaHRxbWlJMzg2?=
 =?utf-8?B?KzB5ZHIrOTBFR1NYTXNWYnVNRmlGelZLc2dxai9EV0JCMmZ6L1BjRzFPSmZF?=
 =?utf-8?B?Z05qbXBvUFMrS3owMEVrSXJDanNLRUVubW8veHIzdE4zVCt4c0dPSXhLYnQ5?=
 =?utf-8?B?UFM5YTNrYU40S0xmTjNZV2ZFWWhMbnZpcWN5aE1keXlKclYrb1oyQnZodzR3?=
 =?utf-8?B?T1hLektUcDVZdmdoZ2JnVkFmU2t2S25OT2ZqRXJheUJ0QXdUdFVCSDJrbjlO?=
 =?utf-8?B?K0pjRS9NeCtEM0U0RHNXZ21hUFZzdzlYYlFUQStYUG11Z2pxWlU1ZHMza3NY?=
 =?utf-8?B?TEtTREY3dW94djlWVzJaZ0MwMlVKWEpiOTRHZnFabmhYcnNzYnlNMmFTcE1V?=
 =?utf-8?B?TFMxTlo4UWhVbnVIcVYvdWE4ZlZ4R2JEb3k0QzhtMFF3OVFLWTRhdjZsTnJJ?=
 =?utf-8?B?dnY4RWFSK3diRDcrVXdnTGJjbmVvMHp4b0dySGVNaERGREJMQzlzVEhrZHF3?=
 =?utf-8?B?ZGlIRHN6MFB1VDkybzdESlJ5U0RSWjRaelN1R1k3OFZBeGt0azVNYVhIc2JC?=
 =?utf-8?B?KzdXbC9pY2VZL01HdzhVU1h0VDd6cmViZWdpUjBhV2NPWHJYdjNJMzhxSlYy?=
 =?utf-8?Q?jjG6j0+UBCEON69vUV7opeIN01KmXfE5?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dVJZbmI0bW12UW5mYnRnUzVGQTZrVVZvS2NYajV1aDVRUU1ueWNOeUQrRDZi?=
 =?utf-8?B?UG9aYXlRSlJRbWtWd1N5QlRpa2k1VG93Y0dCczVtSzd1YURmNWVHY3poQWRC?=
 =?utf-8?B?b01mVU56a1l1VXBQcmErUTcySm5Od05Uck15NVhRRzVVQzRvWkZ5OEYvQ1R1?=
 =?utf-8?B?TzBxaVF1enFpN1A0dVU3R3ZVZ0RJbTNBNjcwWUFXdy9SL1lTRkJtUG5FOGJh?=
 =?utf-8?B?Um15bmRjVUlnRVVKTzkwalNIUGVyOW1rTWJJRkNMbE16cmM5UXNkS1BZOGFn?=
 =?utf-8?B?QUNUa05iM2htRkxNUldBd29OL0VaMzdtMkpJK2JwZlh2dnB5eG9sL0dtN2Ir?=
 =?utf-8?B?QXI5b0FNbVZTK2t4Nk54L3NHaWMvSkxMZ2d2SE1ad3hsSkRETlVLUWRrMGFB?=
 =?utf-8?B?WDlBSmNqTEZpMG84cEtRcFNaKzAzUUVZSStpRVNVSkJNYW1YdHB0KzZBN0J0?=
 =?utf-8?B?TFpBcTN0YlJ1SHg3RzZET0NmaXppaGdpUmJSRktlbll3Y3R4T3ZGMElOUzR5?=
 =?utf-8?B?NEU4ZmJFUDA1ckcxMEhjeE5QWGdVMU1pZ1BqSnFETFNpdFNjSUVRZENpMGsw?=
 =?utf-8?B?ajhYS2Rqa0NBbmpUdXl5UXFyb1RhR2pJUUZBQ3V3L09YeVV2YkVWZ1kzUnRn?=
 =?utf-8?B?S1JKUDZ2aUgxTm9mazlhek1TbmFEWllycDdhaEttTnF0dE8yWnFRZzhWTDdZ?=
 =?utf-8?B?clkwMGxkSVZiM05BeFkxdU1YSFp5c0JxYlVHWkc5N081L2ZnTVVsTFl5aXdh?=
 =?utf-8?B?N0FOb2ZYNUNqMlBaUkh1R1JnTWExcHRqK280UEIzL01qRk5RWloyYlgzbk1N?=
 =?utf-8?B?ZVNLTnJFVDgwb1lMME42ZThUdXMxcUZWcFNPNk0vWU5YR1RLMHQ5TnFKTDBi?=
 =?utf-8?B?dWVTdVZoK243TkRZUXo4emN3Q2kyR3NTeG03cVVQTU9vVE9VdVROcVdyV1Vr?=
 =?utf-8?B?MmRSWEw5Yzd4UjZ5OFpOZ245bmVNbjNFRmhNWnlXZ2N6WGRYZFhpZlZ0MUs5?=
 =?utf-8?B?RmhBUk5mV0VaMFNXZTdvV3J2RU5yd0IwdGN0RTBrR3lwd3p0aXZWcHRNUFFi?=
 =?utf-8?B?Mm9JVnFHbUZoYU5DWFVsVzFZcnFaODVhYzlPdWIzY0tFNE1oM2J1VGo3bEtw?=
 =?utf-8?B?VTlna3pTSVRCcjhXZGZZQzdwNnlTNUlyS0x1YWRpd3pPUzBoaksxdk9yQzNB?=
 =?utf-8?B?RW1LcGZOeGNYZTgyV05UT3htWFpZSE9qTnBzNHRSNndaNjBOYVk4bGE4Q1hy?=
 =?utf-8?B?alBCUWNpWFFha2w3UzJmQmE3VmlQdGU2MlJDczVRZ2poRWIvRWI1SmxraFZn?=
 =?utf-8?B?SWR4OGdoRE84Y3VpSFNmRFpPMHpFSFJmMzFxdTlCZ1A5SGl5THJjcDcxem1G?=
 =?utf-8?B?cU1vaXhsSTZIYS9sMk9ZMDhxcjl2OW04UXNxdHNCTlBkcHZWZjJJcTllS3ND?=
 =?utf-8?B?ZHJRN2VqUDdDdFE3RFhBdUhwUnhBeUNuSEhzZjhkbmM3WkVMbEpyK0Yzcnh0?=
 =?utf-8?B?TE1FQW9EM21zRktkSDdKUWdyM1pGTlRTMnVZT0J2NWZBN3ljR2gwam9CT0dH?=
 =?utf-8?B?Y0hOWFJ6VjFhUEFTV2lBajk0TGMySmJMLy9WV3c3Z2pXUHJHSDQwOHpIQWVk?=
 =?utf-8?B?OFY5QW9pd0dTMWhRN1NyVW1CMnJNNm5PVUhxVGVLL2w1RlpvTVlseEw5L3Nq?=
 =?utf-8?B?bzc3VXFHdUxOalpYQ2Y1alVpN0k3bEpYU3NWMnU0cXRnRXoyNjlYS1JJSlpT?=
 =?utf-8?B?SGZTTEU4NlVJb3FUak1UZnNwcHk2RGFBc3RxRkYyN0F4a1Q5VEluLzM0QWpJ?=
 =?utf-8?B?TWdxQmVERFdrM3h2YWF5WjJmZXpBUzJzekFNT0czOXcxMjhQaitZSERkRDRk?=
 =?utf-8?B?cmIrME9MM2FSc2RiOUk3cjcwUTFXb21CZWdkZEw5WDluQ2dvQUZZYThhclBH?=
 =?utf-8?B?cGhCVkJIcllPdEtNVVhTYmR3dW93bUVvSU9zN3hDdkpQQU5CWWtnb1JJUGFu?=
 =?utf-8?B?bHdjRUIydnJLNjJLakJwbndvaTlWd2VEM0lOV2RJVFBHUm51UmJnMjRZdkcz?=
 =?utf-8?B?RTNvbjh6QnVrb3lPZktPMVd2NlJaMGJUMkNBWlhuYSt6NE54ZDNBQStjVFZ6?=
 =?utf-8?Q?4Go2F/lWRFaJgNFUcwCrXIeI8?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eb3942e-720c-479b-133c-08dd6132d344
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2025 06:55:07.6773
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v3p7m/lSTn7gWg7Mu81B5mkGPYxl1Y7gP7S50HUoEPkcJu/176bdSki6bhxbRM6+hAG8ErUOjTXz4K92TezBNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6065
X-OriginatorOrg: intel.com

PiBGcm9tOiBWYXNhbnQgSGVnZGUgPHZhc2FudC5oZWdkZUBhbWQuY29tPg0KPiBTZW50OiBNb25k
YXksIE1hcmNoIDEwLCAyMDI1IDEwOjE0IFBNDQo+IA0KPiBPbiAzLzMvMjAyNSA4OjI1IEFNLCBU
aWFuLCBLZXZpbiB3cm90ZToNCj4gPj4gRnJvbTogSmFzb24gR3VudGhvcnBlIDxqZ2dAemllcGUu
Y2E+DQo+ID4+IFNlbnQ6IEZyaWRheSwgRmVicnVhcnkgMjgsIDIwMjUgMTA6NTcgUE0NCj4gPj4N
Cj4gPj4gT24gVGh1LCBGZWIgMjcsIDIwMjUgYXQgMDg6NTc6NDVQTSArMDUzMCwgVmFzYW50IEhl
Z2RlIHdyb3RlOg0KPiA+Pg0KPiA+Pj4gICAtIElmIEhXIGhhcyBhIGVuZm9yY2VtZW50IHJlcXVp
cmVkIChsaWtlIEFNRCBTTlAgY2FzZSB3aGVyZSBTZWN1cmUNCj4gQVRTDQo+ID4+IGlzDQo+ID4+
PiBtdXN0KSwgZW5hYmxlIHNlY3VyZSBBVFMuIEJ1dCBkbyB3ZSBuZWVkIHNvbWUgd2F5IHRvIGlu
Zm9ybSBjb3JlIGxheWVyPw0KPiA+PiBJZiB5ZXMsDQo+ID4+PiBtYXkgYmUgaGF2ZSBhbiBkb21h
aW4gb3BzIHNpbWlsYXIgdG8gZGVmX2RvbWFpbl90eXBlKCkgPw0KPiA+Pg0KPiA+PiBZZWFoIEkg
dGhpbmsgdGhhdCBpcyBwcm9iYWJseSB0aGUgYmVzdCBvcHRpb24sIHNvbWUga2luZCBvZiBjYWxs
YmFjaw0KPiA+PiB0byB0aGUgZHJpdmUgdG8gY2hlY2sgaWYgYSBwbGF0Zm9ybSBmb3JjZWQgc2Vj
dXJlIEFUUyBpcyBuZWNjZXNzYXJ5Lg0KPiA+Pg0KPiA+PiBJIGFzc3VtZSBpZiB5b3UgbmVlZCBm
b3JjZWQgc2VjdXJlIEFUUyB0aGVuIHlvdSBhbHNvIGFyZSBkaXNhYmxpbmcNCj4gPj4gSURFTlRJ
VFkgYW5kIGRpc2FibGluZyBQQVNJRD8NCj4gPj4NCj4gPg0KPiA+IE91dCBvZiBjdXJpb3NpdHkg
aGVyZS4gVGhlIGhvc3QgaXMgdW50cnVzdGVkIGluIFNOUCBjYXNlLiBXaGF0IHdvdWxkDQo+ID4g
aGFwcGVuIGlmIHVudHJ1c3RlZCBob3N0IGRpc2FibGVzIHNlY3VyZSBBVFMgYWZ0ZXIgU05QIGlz
IGVuYWJsZWQ/DQo+IA0KPiBPbmNlIFNOUCBpcyBlbmFibGVkLCBpZiBob3N0IGRpc2FibGVkIFNl
Y3VyZSBBVFMgZm9yIGRldmljZSAsIGJ1dCBrZWVwcyBBVFMNCj4gT04sDQo+IHRoZW4gSU9NTVUg
d2lsbCBsb2cgSUxMRUdBTCBEVEUgRW50cnkuDQo+IA0KDQpNYWtlIHNlbnNlLg0K
