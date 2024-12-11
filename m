Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECEC2210C6
	for <iommu@lists.linux.dev>; Wed, 11 Dec 2024 09:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733908304; cv=fail; b=iwfDxNjVjOjRX0oy8nkaF7BiHLZXSvHukuXrGwH//qpetNNa33FqnceHLJl3mCJbtWdFcL47L6G0hKW0zIY7BtMCnugbUKS3DJehEX8YQLcvXraBGGEigiD5IjSpjB9o+qaPSudkjecltLWJxFuHHtqpNCk8vznsH9TohXLUbY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733908304; c=relaxed/simple;
	bh=NYO+Wn3XTuBMTMfLPwtjt1xPzTm+scEIEvUZd0BAEhk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OrKa7k07S9KXSRgsWqd1Gybwx2v+ApMUlqIvk6Xqz/MSVt0Nu6cX0JfTvP6md3EvHN4oVv099HTrgAzZTZj/3BTMgFwCydaMRtdv/NMW59UB6Djp7xYSmk9+v7n8MHfNUd0fQ5XEtACpXGGS/Oe6kovsPpluG47kGXeOTvqMSOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eVPU70Tq; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eVPU70Tq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733908303; x=1765444303;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NYO+Wn3XTuBMTMfLPwtjt1xPzTm+scEIEvUZd0BAEhk=;
  b=eVPU70Tqb/F0zqW/x7GTDjHvrqz3rPgA4T1P7CSWOyyiBXN/vXQvSvW2
   JzT5sC6bPVcKnVLYfpnz62lDDT/79ysnX2C0SUgIDPvWAjaIUNz+y0j29
   Eg8wFB509XubaaUTzcf/DhCjAJX4lLl5d/WNa4tTPXA7el9C3QR1g5S00
   ltUeDCCOgXgd2UKuVl2rqlfPllwu/wQFoPoGXFFgVnpJOF1Vw9OG2aufq
   KlKLfq+27+VYOjPMoyP1rm+jlaglpxdrVGJ+FhPs7kTffB3gV6bMjyWSv
   DK8VDWWrpqBeiUlR7XevhsgUjrCRS9bWp3FRwQWTzxaTErH8LoScbbsBy
   w==;
X-CSE-ConnectionGUID: WtILONZKQC2ynRuEeeCgCA==
X-CSE-MsgGUID: VyylPSyuTnCM6eUy0OzvUA==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="33599231"
X-IronPort-AV: E=Sophos;i="6.12,225,1728975600"; 
   d="scan'208";a="33599231"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 01:11:42 -0800
X-CSE-ConnectionGUID: GOhzpGePTeW0VqfeJXuRfw==
X-CSE-MsgGUID: fdgR9YBfQkqtoy7yOXJfiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="100271555"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Dec 2024 01:11:42 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 11 Dec 2024 01:11:41 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 11 Dec 2024 01:11:41 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 11 Dec 2024 01:11:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IGZhPe74YcJyCaoeLXhMRW45WoUtOefrFDSwlNpKU088tbURsDMygzXtv/ULgcnwgTOWVTQiHf2iM6a8FGm3oCckuejbWoZhVA4RO9ug85RIKsxVLcujCTKKvBMJb9lzNZx5kMUpzxR4nTJ5+aFzMFgtNpLHzTC7TcEDaazBfwkSYPqTkQUQmmXBT6QXZGDmT0SHT8j+35Yw+b4SLtqGy/SDlhch3ablA+mukdvA0VIBrX0I+jqFR8K03mhlC78UhRzToJ9C2Jxri2keJAASBrSi17PYxZmP60LmxEoqJOLeWgXUELVFACoEDCRVO6N4fllJgwEyVaCCNtuc9atO9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wN4DC5dUsOL2TY/UNIksVdbxdU9Jo5qAQjT9Myj77rM=;
 b=FJPgk+o+KZ71yZWNLWgIBn40cDAYvlfdjnGHitfAWsHMaFtKo8p7gJ/2ADWc+GRTMlH3CGOvMbnYSz1ZHBBJePHMZGJX0r5bd0w3gddgqAvJYb3z4yM45gcdHjB+sXI+LR3yKzJQYoUwUJ1BnSoqGqb+HDW+IfaesjNPkkm7vULIUme6ADfVEeM/s+YjnwIGr4R7c1MjwJS31yuZl+sF0fcOSKTAL9pwgI/ufTphgBI0MqvJT9n1gFjpqfOoQLgdlI/5IizGnWwH8Vk8AWX5wJTk+chOugyEnEI1WjocemoW6WjxKHEr39wDbpVCswMfI98zhI/4p95kC+MLcyIOmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by CO1PR11MB5091.namprd11.prod.outlook.com (2603:10b6:303:6c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Wed, 11 Dec
 2024 09:11:19 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%5]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 09:11:18 +0000
Message-ID: <a48cb78b-fcef-4224-8505-48353e830285@intel.com>
Date: Wed, 11 Dec 2024 17:16:17 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommufd: Deal with IOMMU_HWPT_FAULT_ID_VALID in iommufd
 core
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
CC: Baolu Lu <baolu.lu@linux.intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>, "nicolinc@nvidia.com"
	<nicolinc@nvidia.com>, "chao.p.peng@linux.intel.com"
	<chao.p.peng@linux.intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "vasant.hegde@amd.com" <vasant.hegde@amd.com>,
	"will@kernel.org" <will@kernel.org>
References: <20241207120108.5640-1-yi.l.liu@intel.com>
 <b1e8ad5e-e149-4502-8242-b971ac1d4eff@linux.intel.com>
 <3f9e3172-dffb-449d-8bd5-23f9cb2de73a@intel.com>
 <20241209150514.GD2347147@nvidia.com>
 <95a85b9b-a17b-4df5-a1ac-7a0880950960@intel.com>
 <BN9PR11MB5276FE72F52332E1BD40AE288C3E2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <BN9PR11MB5276FE72F52332E1BD40AE288C3E2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0035.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::14) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|CO1PR11MB5091:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d1a9c1f-fa2b-4e22-92c2-08dd19c3c5fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZTlDeWVQZE5ZejQ1anNtMVdCUGFBcXdqSWN6bGRORmpBTGVOenM3b1NaMkkw?=
 =?utf-8?B?N2p3cjllYkowVDh3RHdKeTJmSm9JZGhJbUVtQVpkYnRoc0FOZHZ5WExpZVdp?=
 =?utf-8?B?UHdqdUllc25oMEM0bWxqUHFBd3I1Nnd3SzhQZjlaa3hneC9MMld5MnpNbmJ2?=
 =?utf-8?B?N0dSbWNGVEgxYXpwN1JCK2Y5Vm1MQXRlVFpUcEhucHM4VU1wdXhZSjBGamoz?=
 =?utf-8?B?VXVSejdZSzkzS0xqUVFWV2VZL01SYk96T2VPRE91di8vRzdrei84cjE4eWxu?=
 =?utf-8?B?K0x1eVNGMlpMUFdxeFUwbEZEK2xUaFUyOStaVTV2YktUYUJkN0J5VTQyRjE5?=
 =?utf-8?B?aytVa1VNOFNLYkJDQkt4LzNGSlIvUlBhYS81TzB1Y1RZWG1DM082UG05TmFv?=
 =?utf-8?B?WDI3SEhXaUZPaTdnZU1LSUlKR3ZjWE9oU0pua0Q3K1Zmc3pFaU41dVYvNSt0?=
 =?utf-8?B?QVdCOEdiS1NNNllNUVBOdW5DVEVTQzRXaGxmRUQ5Mmlwc1dxNGtPVWlyWW1I?=
 =?utf-8?B?R2tNTXNlZjF4OXhyQ0gxaHhsZTZIWmRvM1hldnFqaEtPdHF5aGpiTHBqbjNI?=
 =?utf-8?B?MUdBSUVRR3lBZmZ4Zmg2SjVrKy84TkhmSjlIVys4WURNN3QrclBydU1leXBM?=
 =?utf-8?B?RVI3WDg4UnQ4aDZiV0txT2ZCbEdlV1VleitnbjRzVjVhZGpRWlkvNlVKN0xn?=
 =?utf-8?B?cnpuM1ZqVHVheEx4cG0yOW9xb2tqTjlEOFQraEdFb2VPTm94ekJTYkNKdG9L?=
 =?utf-8?B?UGxyOXhRam5sc0FqV1MwZlV0WTMyL2dLampJc3huTjdVRndCWkduNjkxYmZp?=
 =?utf-8?B?bFo5ZjJ0dUFtSlBobExhVVNOd3dqS0RZVVBtQjVSQ01UMnFLK1dQSU54QlIv?=
 =?utf-8?B?V05RUUJuT3pCUTRQTXExWGh2bWN4TWp1dEV5NEo5bmk5SXlYV25yMW5KUWps?=
 =?utf-8?B?bEk1TWdCUmEzSC9Ic1g0c0xZcHBMTjFkVExSR0lmeG9iQ3JwNzBSZ20rZ1A3?=
 =?utf-8?B?OU9USHlwTXQwZjRzUXpCOXIxaU1yYnQ4bmtGMmNpYS94a3Z1Y21EYWlpL09q?=
 =?utf-8?B?WU0zWXlDRUx6MUZkVHJpcmU2RU1kUzA2S3lRMHdON1Bjcm9FYVNzQU03Rm1M?=
 =?utf-8?B?M0RtTDZSQVdtNlVMcmhJZFJoK3g4U2hYY1JYZ3Y2QWNISTRJYnRiRms2ZkEz?=
 =?utf-8?B?M1ZaZGEyOXFCQ0dhVXhneXBRenBFWDhHWHBzQndLVUh5SFM2aXN1ekFtcHlB?=
 =?utf-8?B?aUhrU3d6UEpHamVNenNpcnRPaTR3UVN6NWpRS1NBMHAyVHFKejR5bHZ6elZM?=
 =?utf-8?B?cEhkdEl5N2E1S2k1TGNyY2REK3YraWNxYWd1b3ZUblpLV1pZaVBXR0J4aHVi?=
 =?utf-8?B?ZXVlUElrZ2F1eEpKR01IaHVOYmlxeE5oWmR0a0hTcURyN01lWDl6VHFCZUNK?=
 =?utf-8?B?YXIrb2xpV3NNelRrSlJnZE1JTUg4Wk15eFZ3MUJuUldNYTdESklzaldJTHUz?=
 =?utf-8?B?THJaaWdCRjlJVktzUnVqNUg1aHRLenpvcWh5Q3RSMzRhWGpFTGxCcmRtNmYz?=
 =?utf-8?B?T05mUVNNYWtLdi9TQnkvVmp4c3hCOWI2Y2ZKYWxENVl5WlZCU3VjbjIwNDdN?=
 =?utf-8?B?dTB6MmN5RjFLREcvbFdRaFJxRUhiOUxYUW4rQUgvRHNPNTNRdTQyMkx1UTJi?=
 =?utf-8?B?ZEMySmNJQzNkUE1yaUNXOUdSYTBRdkI2VE03ZkNlSE04dU5oT3dzRDNXaHg0?=
 =?utf-8?B?WHNDaDVrL0R0eWIwSmtxeWdPYzVyVFJpZitkOHFnYnlrUnBlVWUwTWZyVjc2?=
 =?utf-8?B?MUlrZFgwcWc4VHdiZk83UT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkxJNTgrc3BPandaRFZ1VHpobm1Hd1VUNFZ2TGh1QlA0dGFMdHhFMGRRektl?=
 =?utf-8?B?MjY0R0pqc0V3SjlYdGVvRlB3OGw2aTNtR2czNW5EalhHUEpFWU9GbzY0VnBU?=
 =?utf-8?B?U0JHRGJqdGduZ0hXbGRVanNFbHZyYlAvZzNRREdzdWczUHE3QzM0OGlJWnFs?=
 =?utf-8?B?Z3ltcHB3ejhJeGxhbkd4YVFCSkNHa1Y0clZ0WlVnQ3lFSVlCaW53ZmdFemhk?=
 =?utf-8?B?WHZLR3F6NVdsZTkvcmtnWFBOTTMrekVjS2VwY3BXMjhZc0hzZzRMUTVhMk9a?=
 =?utf-8?B?a2FsOWpKNWlMdlJpcTQwdHFyc3A1ZXFlTERtUGlxMjBwZEI0MStqeWg3Zlpp?=
 =?utf-8?B?a0t4eU5xbXhkRTNVb1BCWnBJMFVFekEwOXFjaEZhanNIUkJWaDZwcUx4SEJ6?=
 =?utf-8?B?Sy9Ha3BIVkJZcS93Qlk1Z3BWUS93ek5QYmR5NS93QUFpcE90SjdyS3JTbE9W?=
 =?utf-8?B?aVNhbzhjTXJkWFhQZVp2YU1nWmVEa2pKc1VjV0d3Yy8yZTV3U1A2Qm5qRUNo?=
 =?utf-8?B?QlFXMFYwY1E1VTA2UGNDM09EQXQrdFJFbHlQZmYySzBEcXYwYmJyZkI2NlEy?=
 =?utf-8?B?dHBLc3BqdUxLMHZSYjV0eGhJeWVuSWdXZTFKTnUrNmtFQUd5QXk4UU4wVzVB?=
 =?utf-8?B?Y2N6M2dWV2s1QnpnQi8rVm90TnU1ZFRBR3VJWXNidGZuUDlTU0hiVzB2Qy9X?=
 =?utf-8?B?WFZ5YlUwUHRwNjROaFkrVUhjN2VsdEFGR0xjQlhlbHNXZjVMc0YwcnBRNHJF?=
 =?utf-8?B?dWxtYU0wbVlxSldhbFd1ZU5JWVlKMHFJNG5BVUFaY0lkWkpQaWxFRU9NZ0Vv?=
 =?utf-8?B?V2VWenRXUklhREcvMkdUY1BtSWswaVNQY0RFSTZaRngvNnJyTmpqQ0NRWmtu?=
 =?utf-8?B?MG5uWEd1V2xHUWpPdG9maXBZdW5OWDgvbUtXSUUxaE5HSXFmYUZIYUNkQzBr?=
 =?utf-8?B?RmRnRzhLaENSMFR5S0N2c1dVaWNVK1VKeDJRd1pOdHZrZGFWc3pkSXlUYXUv?=
 =?utf-8?B?U05aWFlPYXRFR20veWNuS0xtUlZrUEpnSjNwVVBiVjd6Zm0wUUNjZTlPWUh4?=
 =?utf-8?B?aWdRbEJ0dGxPdHNMRnBLblFPditFRXhoa3JTRTRqNHRGRVE5L2V1WWtVWWhp?=
 =?utf-8?B?MmpSMW5naW9rQ1BpTDRzdFpWMHdNYlAyWWl5eXBwTm1HMkVadVZCRmRMOUZu?=
 =?utf-8?B?TDB6ck1tSS94L3lDY2Zva2xBbys3VHowczRiYmJ3NnlER09BSElMVWFybjcv?=
 =?utf-8?B?QzZQQ01tMTNISWpQWk1JekppZzFOZjkxZE5abDl4UGRjeUlGck9Nb01yc0Vt?=
 =?utf-8?B?eCtXSS8vZWE5ekQrTzFpcGx0SU9rMmtDSXpzNi9md0EweVp4Z0kzekN2MEpN?=
 =?utf-8?B?YlkyNFJHTnB5VGU4VVhaeTgyd2UyL0wzamczMm55bGtoNWd6YVdmbGljbk1z?=
 =?utf-8?B?TG1CWGFydU4ycTcvVnJpbi9UOTNjckI5UisrZ0xSQjB4WjNpQ1M4WjdaNmJa?=
 =?utf-8?B?OWt4dmpielZzRFhTdi9WaVdnekd4SVJhTTBLWjdDZVc4MSswdjFjVGNmWVl4?=
 =?utf-8?B?QjFGMFdWN2Yvb2V3dy9GeGpkZ0xReGhBTlNKOTVScUc1UTc0U2J0bVBrMXAx?=
 =?utf-8?B?dHhMWnF3WVZ4TW43Z3FjVVIvNzV2TTBvcjNSY2JVVHhFVnQzUnFuRTVibS9S?=
 =?utf-8?B?RmhhMnJZODNtb2xWTWtnSUcwKzRCQzg3K2pOTDU0WmFGNHplWHdQWkw5d011?=
 =?utf-8?B?OU11dHVuaXVnSlBVK05FcW15SkY4YjZCd1ZPU2RwalpsMUNlTjBEcDZVdjg5?=
 =?utf-8?B?Y0hSUjl6Wkd2ZFRBcjRuNEt1WEc3R2VrRXBvTlAwMkhCUlp0Vm9qQmE3UlAw?=
 =?utf-8?B?cWxzMWhHVlU4QkpVM295MlZDc2puemR4aCtvdkNwSTVkYTNWTkpRTUo5d0ZU?=
 =?utf-8?B?QUtGck5ZVFp0QjBNVEpYZWIwZjFlKzd2REtPVFE1UG11MUxYY2dRWXJ3ODRI?=
 =?utf-8?B?ZENiVUtyTTBQZjNvSWd3K1B4ZUc4aUQzemppVFlUTW9aZFIrUjM2MVU0cGNl?=
 =?utf-8?B?UGtQcHU2RStFbEN2bXBGK003WHhSY2JHczl1MUpxRGkwcUJMY205WTFHTXVE?=
 =?utf-8?Q?KPEtxfsNiziCVvUSyrDAI6e1N?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d1a9c1f-fa2b-4e22-92c2-08dd19c3c5fc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 09:11:18.8706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i9oxCqVqxA3kMUs+Mkn3DvNVHPYajTWEQ56KCEOEUDqKeBcay+1kwMsP3u2wi01aS1Kt/oZWU4xG2iC/vkezRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5091
X-OriginatorOrg: intel.com

On 2024/12/11 16:58, Tian, Kevin wrote:
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Sent: Tuesday, December 10, 2024 1:52 PM
>>
>> On 2024/12/9 23:05, Jason Gunthorpe wrote:
>>> On Mon, Dec 09, 2024 at 10:51:51AM +0800, Yi Liu wrote:
>>>> On 2024/12/9 09:08, Baolu Lu wrote:
>>>>> On 12/7/24 20:01, Yi Liu wrote:
>>>>>> IOMMU_HWPT_FAULT_ID_VALID is used to mark if the fault_id field of
>>>>>> iommu_hwp_alloc is valid or not. As the fault_id field is handled in
>>>>>> the iommufd core, so it makes sense to sanitize the
>>>>>> IOMMU_HWPT_FAULT_ID_VALID flag in the iommufd core, and mask it
>> out
>>>>>> before passing the user flags to the iommu drivers.
>>>>>
>>>>> Is it a valid use case for an iommu driver to intercept the
>>>>> IOMMU_HWPT_FAULT_ID_VALID flag as an indication that user space
>> requests
>>>>> an iopf-capable domain?
>>>
>>> For now we have no use case, so we can drop it from drivers, I think.
>>>
>>> PRI support or not is decided when the domain is attached based on the
>>> fault_handler in the struct iommu_domain.
>>
>> hmmm. It sounds reasonable. But I failed to see such checks in iommu
>> drivers. So attaching a non-fault capable domain to a device that has
>> enabled PRI can succeed. But the PRQs from this device will be responded
>> as bad PRQ. Might need a patch to fix this gap. is it?
>>
> 
> PRI is enabled when the device is attached to a fault-capable domain:

I see. So attach would be failed if device/iommu does not support it.

> static inline int iommufd_hwpt_attach_device(struct iommufd_hw_pagetable *hwpt,
>                                               struct iommufd_device *idev)
> {
>          if (hwpt->fault)
>                  return iommufd_fault_domain_attach_dev(hwpt, idev);
> 
>          return iommu_attach_group(hwpt->domain, idev->igroup->group);
> }
> 
> int iommufd_fault_domain_attach_dev(struct iommufd_hw_pagetable *hwpt,
>                                      struct iommufd_device *idev)
> {
>          int ret;
> 
>          if (!hwpt->fault)
>                  return -EINVAL;
> 
>          ret = iommufd_fault_iopf_enable(idev);
>          if (ret)
>                  return ret;
> 

-- 
Regards,
Yi Liu
