Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1439C1F8720
	for <iommu@lists.linux.dev>; Tue,  4 Mar 2025 07:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741074618; cv=fail; b=Uu6HO+FKSpHursN9d3tLPVshHcBkqthIl85slVHsd+kVUdr/KrRA6us1OXEG0tI85UpXKdLsSy8roxEYS/WnB+u789jh8Z/qMjDlTE84YYBbiqlllds7S7HZ1neRaAScW9XyiJ7JnGg4m0ZIIHSQy52MT+Rq3TtEAL4n54C5D6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741074618; c=relaxed/simple;
	bh=jUyrUyDrEH1lKR2h5BlLe4PH0fQu53AG1qmJEJ2WKXI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aB49QVpSoLoDHL+wNzbSofVncXm4Mx+wnSJeKVtheIgYDMDGqCvhSzY0ecgDFTRztmyrzto47vPTOcRgcM2aPs4vCEeR3/YVfFrfOacI5DdQ38+c0o+VRXv6D7P7c1KX2d/MCw/0t92KMJ7jo4hHY0M6PBQDchNaGkt6W1Un1gs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cObEqdto; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cObEqdto"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741074617; x=1772610617;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jUyrUyDrEH1lKR2h5BlLe4PH0fQu53AG1qmJEJ2WKXI=;
  b=cObEqdtocEVEiFeeFX6LtyWl+j+iMeLlbyMW4FODVZyQHOWbpW4T7JLf
   M2ixp8U4WM51nAvC5niO4LNsgZgy+BRi1r7MFI4nQc1yKFNLGISDatnQ4
   o9HjcdJDVgtHqJEsL5f7BSl8TNNoDKMcFJScPR/d1o/YE8jxc7cJ+eVBW
   pqON2P4ldWzvgTuv2h1/luRnfgQdWl6l+Spf/u0k8VehFR7u+428e8BJY
   egfMqwFm3+29m97q3BborGb/Sc9WYxP2988fwT0RP9PLjxZil1SWQHs3A
   IZuZevzUk88P2aRkBKuB9dRQ8L8xlW76hBLwxlQ1WTHav0ZlsRjzhbftl
   Q==;
X-CSE-ConnectionGUID: DFocMkrMSu660Wf+mxjNAA==
X-CSE-MsgGUID: 8H4XkNvnR/y9k0q0N+TsBA==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="41689797"
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="41689797"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 23:50:16 -0800
X-CSE-ConnectionGUID: PRa2iVUvSJSOcOtzifp7wg==
X-CSE-MsgGUID: dua0ldobQTmJuLzLVVyLxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="123508581"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 23:50:16 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 3 Mar 2025 23:50:15 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 3 Mar 2025 23:50:15 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 3 Mar 2025 23:50:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t8etpcIfCRRV0VIfWpRTA47kFJ7nLd9gctzrOSlzbiTV3oYLtnzJQ0B//tBlfFVpGXQ/z+UKvJ9s3o0Jk3THFhrkVWv8zLaNIXeee226aAk+De4Uk6u3IVippBSiZCl3aQroUyXpnLyeGz0tfjC+Q6Cx68a5/8z6txygKb1Oba7r8VfWdba+ahBBREjwNkqFJGiTLjV14pgHiBD5TtcbuikoFcSX+IfJHC+t9lECJO1Zr4BXxYWDyyrqaRgzOQJP1P7MznJ0Jm6oDM2mwWYYSwpA/GqXbqauS7qQ/eJBCDbqMmWOpCRSTNm+frfvK7f8OxODjdxEwexO6aNvx/r8RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ejvMzJ60l0gen42p57MhLTkVL43NJBYRSK7DFALLM2E=;
 b=vesQjqGBjcLIk2z8ACxjTqS8R6G25Z9oeXNhJM4Phwx2ryDmbNouyfVidx4uNHi9a6c+TQz6ZMcF5Rd5yfBEmCb4GGdaS0yflEHaISlwNld62n3lbMYXBdx/omZcuD1XDEeeqwQs6zkjNcmnZM9k+W4MqrlPfqX7y3QxXZRnwU0UMn3wyxHQfyDXhBFvLK6ua0QbqTUDq82pqkB+RDbjXrIK4qcDuJ8cd/XQtYJGWFKj8oAi6SrtZ+B6xw7SIKxF6LQD59vk9DTxiFfZO/p7aHrVJZ0h6bduLhXJES4k56ivPhAE+lj7zCy6h4cEPcm+vVvMHq4OAikhJLn71EzGhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by DS0PR11MB6470.namprd11.prod.outlook.com (2603:10b6:8:c2::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.28; Tue, 4 Mar 2025 07:49:52 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.8466.028; Tue, 4 Mar 2025
 07:49:52 +0000
Message-ID: <0db75998-0e27-4931-9528-b05aeba395b7@intel.com>
Date: Tue, 4 Mar 2025 15:55:15 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/12] iommu/vt-d: Move scalable mode ATS enablement to
 probe path
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>, "Fenghua
 Yu" <fenghuay@nvidia.com>, Zhangfei Gao <zhangfei.gao@linaro.org>, Zhou Wang
	<wangzhou1@hisilicon.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
References: <20250224051627.2956304-1-baolu.lu@linux.intel.com>
 <20250224051627.2956304-5-baolu.lu@linux.intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20250224051627.2956304-5-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0038.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::20) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|DS0PR11MB6470:EE_
X-MS-Office365-Filtering-Correlation-Id: 67c368a8-5e24-44c2-8fc8-08dd5af1258a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bm43OEsxVnNNWXZTUGorWThqNG5WTmF2U1JQREsvTTM4Tk92ajJtWHNrMHhH?=
 =?utf-8?B?VWlZSTE1U1VoaUNPemxjRjM0VW9MNGw2TUxid29JOWlFUFo1czdISjFGVUdx?=
 =?utf-8?B?MUc2SVhEc2xaeCtxMEJqOVdZZEVZdHFiNllVbmMrQ1NBYUFGVE92WFdIVEZD?=
 =?utf-8?B?ZmJuSXhkTE5VREJhSjNzTDV6MXJCekxUMUtRcUJablVhNnhTN1Z6ZUkwNDl4?=
 =?utf-8?B?RnhabHRCOExJbTJ4ZXFaV0Z0Vno3ZUxTdlRtRzkxRjNBUlZNbkNXc2dLVGZJ?=
 =?utf-8?B?TGF2MitnMkZ6ek1HK1gvOHdLRFVUdVRsQWxmUUR2ZzRtUjhrT3VYNWVpWlhE?=
 =?utf-8?B?ajBKRUYzbkJNQlBQSTRDSmptd2Rjd1VRNlNndmk1T0lLMWVWNmZSWHM3eFpa?=
 =?utf-8?B?RFFaOHN4TThrVTVJMmwvWmlSakVuQTcwS1BDRVZmbmxsejFsZ1RtMmpweG8v?=
 =?utf-8?B?RHZiVFBmSmhCM2FnS21NUG52SU1veDhjWmdLdkVBNlFKeERva3c3dWpZZG1E?=
 =?utf-8?B?d3NuSVJQYktWMWZwb1B4VXliTVF3dHgrRU5ld2RydXNrQ0YvdFZxWHV4OXhX?=
 =?utf-8?B?Ui9hSk5lNTUwQUliL2lHTW9Ed0w4M0d6amhxRnFEUzNiZzg5aEtqQjRuZ2hB?=
 =?utf-8?B?YStwRiswdzZzUHgxenNtT1JIcTBHU0lISmVkQUNnQXVrMUdFTkRlT0wzbHhH?=
 =?utf-8?B?V2YvSGlYVEF6YTVoTFk0S0xidm53TWd4M2ZYZ2VRenJ4RWdwUEFtNVJEbS9j?=
 =?utf-8?B?bG1mY0lEeTVTSDl6TzBNamtUQlFhM0ZvVkNYQzlQUFhCaGdjMCtURDh5QzZl?=
 =?utf-8?B?Y3VBc2ZtMG1ncDU5N2k5RDNYVVNkZkc4R3JYREhuQi9qTVRoY1VjRzdsa2hi?=
 =?utf-8?B?UlQ3VkxXOGltSFRPblNDSExCbkxCTTZueCtIUG03andDYkVmbVR1VGQvK0g1?=
 =?utf-8?B?bmJWRmdYUUo3NkRlcXJIeW9MdzR1cXNwUjBvZ0tTdmRSWlNVTGRhYUNPSy9B?=
 =?utf-8?B?MVRpc2EyQ3RMOUJFRHBMMG9lZ1lTRXlZUjJwRFdEUFFYemJ6RndqRVNML2pR?=
 =?utf-8?B?NU5EK1Z5WGR3M2tDRVFocXFXdVRLa3BhVW5OYUJQVDR4WFRUWEVNQlZIWGhp?=
 =?utf-8?B?d3BEcmxuVGRYMjFzOFdWQUNOT3M2S1FQdkIyY052dGtWVVNKM3NEUDZpU0VQ?=
 =?utf-8?B?VHFkSm1WUkxSV1VLUnFoc010akZ5dStnWEV4U3ZLNTFkc1BacmgxZzAvTFQ4?=
 =?utf-8?B?U3BSa1h6bWJkSEhnbVFhdW94Y0EvT2FRN0Q4NTVsWEZnYTg2UXpZazVHNEhG?=
 =?utf-8?B?Q0ZramZJbHhEOWxFdGx0US9sRkdCMmRqdHM4UHM3bDFCQmVLTjdMWUZicVJF?=
 =?utf-8?B?eGQ4S2lwYitDendWbG5mMDNkZU5JMTZ5MUxnQ1JaQUlZcUlnZW44clQvOGVw?=
 =?utf-8?B?UmtmTU0xRGZCR1pCRHZGemM5SnBsVDY5T0VnZ1NCM1ZmRW5JbVJhTk1QS2Rv?=
 =?utf-8?B?bUZzN01QcUpIbzNCa0IvNVF1ckJwcm10Q2FIZ1ZoN1VtQzI5UHIwN2VERXZM?=
 =?utf-8?B?L2lQTGZkMStkUEhKTS9YelJtTVpOamF3Y1RVRm1xRUJLajUrdE02aXpNL2E2?=
 =?utf-8?B?R29ZWVhReERXQkdUMWVvUS9SeDBrbXE1MVA0Y0wyUGQ2YnVVT2FpbUpHUm5U?=
 =?utf-8?B?TmFXSTJOMEIxR281Qk5ybWJLSUVlRkxMZzZDL3RUc3htRS9RR1hJajEwQ1BX?=
 =?utf-8?B?N2JIZk9VR0E5aGV6aS9iRGh3c1ZkVjlNcDFxWDJqZTVMVGJZeHpwandja2VX?=
 =?utf-8?B?ZU5RckZyT3lSeDMwb3pQUjVEeUduQXpEWmpVSmF0RUVKcm5QZjYyc1ppd2hC?=
 =?utf-8?Q?qqn8SbIWRmPlY?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N013MHp5d0VsSEw0UXBBcnpSZHQrUzEyWFZLOFdwQ0trblZuMlpITzNDWVBx?=
 =?utf-8?B?aHhMa0FNckRGSFU2VjdjWmMzK2NkT2gydzlPdk5TY2FiM01WalZVSExpckJl?=
 =?utf-8?B?aFNaVTdVMTBrSXpqb0JnQ0gwa2NOYTNsSmgyZXdhS1I1N2FNd25kaDRsM2xy?=
 =?utf-8?B?d2NvVmFoTDJ4VjNkUjZJVU0xa053czA5S3dIVmd2L3FWOVFQS2x4NzBsZVU1?=
 =?utf-8?B?ZHFRbG5jN1J3RmluYzBkNUszZTFLbVNyOCs0K0x0OTNnQWNSY3pyL2QzZW9r?=
 =?utf-8?B?SGtiVjhTMkNYREhEQTY4dnBIRlY5c2tCQW83TDM3S3I4L2NOblBXZ252Titz?=
 =?utf-8?B?WjBpTWxmbTd6YlBWTzlpaWxhWEpHdTJUbmdBdjdhc1ZXei95eldHOFIybWNU?=
 =?utf-8?B?cktHMGJFMnAxN1piSjBCOWJiM2pUa3krc0JWckFtTTVuU3ArT3VFMytDcVZy?=
 =?utf-8?B?N2I1ZlJibEsrMGJydHhRMVNHRi9kRUx1NFNqbnVPMkdMZTVQcUpiYUw4dG5y?=
 =?utf-8?B?MGNGeE02djc3L1ZsMlZMam5WOWhxdzJwQTlUYURJRTcycE92bWlZT0ZhQnZ4?=
 =?utf-8?B?aU5hMm96RlJBZ3FJRHI4Z3RqZ0tQYXA4OGRET2RtWTNSU0lMUktTOHZkMEJv?=
 =?utf-8?B?WFlDU1RlTVY1UExBMGo5WGdKQ25OazM5RzAxeUV2Rlo4ejU1UVhHanBmWTVO?=
 =?utf-8?B?U3V5QldxUFdkaTlYbmZoQzkwOGRSK1h4MFZTWDVVd3JVNHFVdTh6SkVHQ2ZQ?=
 =?utf-8?B?eEtDTHhvU0l4RXRaZXBiOUx5VFZqU0ZPenFIYU05VmpkMTY0c3VVbXA2ZGQv?=
 =?utf-8?B?ZGJ3Z3FoYVRyblVWZnUxRkpraURIWk84cnJtYlBMSStvTmtzMnE2cWViRnFq?=
 =?utf-8?B?OVpndHVNV1gzSjlMeWMvM0RRd20xWjJyZTBCVzRXMmdxRktBSE1Wa1VlcU15?=
 =?utf-8?B?Zy9aK2VuWHZsMlIxa3IxZnd4SGZhczduZDkzUzlXb1E2MGRtNzJjU1U3RWtk?=
 =?utf-8?B?eWQwYzB3akpjblFvR0pic3lCNzB6Smg1akc5SkRIQ01sTm5kVldsR3BHMkVa?=
 =?utf-8?B?N0lVQjJyNE5OQ3NvY3lnZlJ2ak1yTG1KWjg2S3c4MHRURitHTzRad3JjY2ow?=
 =?utf-8?B?OC9ZeVV3KzBwbDJ2Mk9mb3c5TFh0UmI0bEducDdiVTdyQm5LbHZnM3A5QkRv?=
 =?utf-8?B?TU9jMjgxdUlOSkVTSEJJaS8zdmJEaVRHVXRRTm91eGtUaWtyVzh2Uk45d05u?=
 =?utf-8?B?bnBEYTRRRUFmNzV2a0grd3ArT1FVR0oyNDhCK2FpOU00dmlKTHZKaTAvSUhq?=
 =?utf-8?B?ajlhM0VHTmo3SnpHRkthNHdZS2l3ZmNtOFBhUkVFZkZuN1JJYnpBOFBhbjFy?=
 =?utf-8?B?NzdseTVSNGVPbnRvaCtuenRmTUNnS3hGejA1UlNYY0pIZGJ5VENFUUc4SFlu?=
 =?utf-8?B?d2F0eTVmejlFUXd6dzVlZ24waHJhU0YrUWtvdzFYMHU0TWtoa2tCSC9mbTlQ?=
 =?utf-8?B?cUpoMlN1M3BzWWpMRlpsRzNibmtvTGt1ZitGeEFhVEJPR3VzUmUvTUtEd2w5?=
 =?utf-8?B?c2xJK2pNZnZKKzR2bk04eFRJZDNBUG5xOW1mMlhzNC82NlZFNjFwZHl5cXNV?=
 =?utf-8?B?WXNZWkt6blQ0aEdYMXhmVjZzOEIxTFlNbUw2R1B4eG82eUdtZ3B5UlpsTjJZ?=
 =?utf-8?B?YWZaREdRVGl6bmlGTWtyL2Vod2ZQbnpHVFNta1FpVUZCQmV6RE1mN3Z3dlNx?=
 =?utf-8?B?ckhSbkJ4Y2F4SG4wNTZxWkhld3VWQTRzdnozTllZZjZPT1JmUG0yQUh1V3pT?=
 =?utf-8?B?TDhOd3Y3b1NPem5aSGNERXRiT2NlTkZRQ1hUanRrazE1anBBQjFwbi9QQlg1?=
 =?utf-8?B?dFJqa05mQW5YMDdxeTN0RTJPTXp4Zk90V1hrM2VydkhXU25UVzV5OERCdGRv?=
 =?utf-8?B?WVJyaCtCVEJ6MjFuSHlyMTg1dGNyZEl2ZFFiOXc5RUtSSHUybkc2cmZrUE9R?=
 =?utf-8?B?T3ZjTEl2TFNiWU1XU2pkRndMeVAxR1ZLY3BGQmZIVHlCeHA4TXdnTEVFOFFm?=
 =?utf-8?B?QWVPRUtna2RKbG1Ba0NqTXZzUDA5UTFWWG94QmlDY3dIY3BNK3oxV3N1U1kv?=
 =?utf-8?Q?aWsN/H2ygpRF+yJUJi51vP5RT?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 67c368a8-5e24-44c2-8fc8-08dd5af1258a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 07:49:52.2960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t5Cq7Kx7ouJs6I0VHZ0jsM/2TF4ltBbRSp4LUG7ZKaMfEZPTrRCrneC/OisgwRZ+WG9dTQLGpAoO8Adepu60aA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6470
X-OriginatorOrg: intel.com

On 2025/2/24 13:16, Lu Baolu wrote:
> Device ATS is currently enabled when a domain is attached to the device
> and disabled when the domain is detached. This creates a limitation:
> when the IOMMU is operating in scalable mode and IOPF is enabled, the
> device's domain cannot be changed.
> 
> Remove this limitation by moving ATS enablement to the device probe path.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>   drivers/iommu/intel/iommu.c | 78 ++++++++++++++++++-------------------
>   1 file changed, 38 insertions(+), 40 deletions(-)

I'm ok with this patch. Just a heads up in case of anyone that is not aware
of a discussion in another threa which intends to enable ATS in domain
attach.

[1] 
https://lore.kernel.org/linux-iommu/2c9ef073-fee5-43c6-8932-a8cae677970e@intel.com/

> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 16dd8f0de76d..f52602bde742 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -1172,34 +1172,6 @@ static bool dev_needs_extra_dtlb_flush(struct pci_dev *pdev)
>   	return true;
>   }
>   
> -static void iommu_enable_pci_caps(struct device_domain_info *info)
> -{
> -	struct pci_dev *pdev;
> -
> -	if (!dev_is_pci(info->dev))
> -		return;
> -
> -	pdev = to_pci_dev(info->dev);
> -	if (info->ats_supported && pci_ats_page_aligned(pdev) &&
> -	    !pci_enable_ats(pdev, VTD_PAGE_SHIFT))
> -		info->ats_enabled = 1;
> -}
> -
> -static void iommu_disable_pci_caps(struct device_domain_info *info)
> -{
> -	struct pci_dev *pdev;
> -
> -	if (!dev_is_pci(info->dev))
> -		return;
> -
> -	pdev = to_pci_dev(info->dev);
> -
> -	if (info->ats_enabled) {
> -		pci_disable_ats(pdev);
> -		info->ats_enabled = 0;
> -	}
> -}
> -
>   static void intel_flush_iotlb_all(struct iommu_domain *domain)
>   {
>   	cache_tag_flush_all(to_dmar_domain(domain));
> @@ -1556,12 +1528,22 @@ domain_context_mapping(struct dmar_domain *domain, struct device *dev)
>   	struct device_domain_info *info = dev_iommu_priv_get(dev);
>   	struct intel_iommu *iommu = info->iommu;
>   	u8 bus = info->bus, devfn = info->devfn;
> +	struct pci_dev *pdev;
> +	int ret;
>   
>   	if (!dev_is_pci(dev))
>   		return domain_context_mapping_one(domain, iommu, bus, devfn);
>   
> -	return pci_for_each_dma_alias(to_pci_dev(dev),
> -				      domain_context_mapping_cb, domain);
> +	pdev = to_pci_dev(dev);
> +	ret = pci_for_each_dma_alias(pdev, domain_context_mapping_cb, domain);
> +	if (ret)
> +		return ret;
> +
> +	if (info->ats_supported && pci_ats_page_aligned(pdev) &&
> +	    !pci_enable_ats(pdev, VTD_PAGE_SHIFT))
> +		info->ats_enabled = 1;
> +
> +	return 0;
>   }
>   
>   /* Return largest possible superpage level for a given mapping */
> @@ -1843,8 +1825,6 @@ static int dmar_domain_attach_device(struct dmar_domain *domain,
>   	if (ret)
>   		goto out_block_translation;
>   
> -	iommu_enable_pci_caps(info);
> -
>   	ret = cache_tag_assign_domain(domain, dev, IOMMU_NO_PASID);
>   	if (ret)
>   		goto out_block_translation;
> @@ -3191,13 +3171,20 @@ static int domain_context_clear_one_cb(struct pci_dev *pdev, u16 alias, void *op
>    */
>   static void domain_context_clear(struct device_domain_info *info)
>   {
> +	struct pci_dev *pdev;
> +
>   	if (!dev_is_pci(info->dev)) {
>   		domain_context_clear_one(info, info->bus, info->devfn);
>   		return;
>   	}
>   
> -	pci_for_each_dma_alias(to_pci_dev(info->dev),
> -			       &domain_context_clear_one_cb, info);
> +	pdev = to_pci_dev(info->dev);
> +	pci_for_each_dma_alias(pdev, &domain_context_clear_one_cb, info);
> +
> +	if (info->ats_enabled) {
> +		pci_disable_ats(pdev);
> +		info->ats_enabled = 0;
> +	}
>   }
>   
>   /*
> @@ -3214,7 +3201,6 @@ void device_block_translation(struct device *dev)
>   	if (info->domain)
>   		cache_tag_unassign_domain(info->domain, dev, IOMMU_NO_PASID);
>   
> -	iommu_disable_pci_caps(info);
>   	if (!dev_is_real_dma_subdevice(dev)) {
>   		if (sm_supported(iommu))
>   			intel_pasid_tear_down_entry(iommu, dev,
> @@ -3749,6 +3735,16 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
>   	    !pci_enable_pasid(pdev, info->pasid_supported & ~1))
>   		info->pasid_enabled = 1;
>   
> +	if (sm_supported(iommu)) {
> +		if (info->ats_supported && pci_ats_page_aligned(pdev)) {
> +			ret = pci_enable_ats(pdev, VTD_PAGE_SHIFT);
> +			if (ret)
> +				pci_info(pdev, "Failed to enable ATS on device\n");
> +			else
> +				info->ats_enabled = 1;
> +		}
> +	}
> +
>   	return &iommu->iommu;
>   free_table:
>   	intel_pasid_free_table(dev);
> @@ -3765,6 +3761,11 @@ static void intel_iommu_release_device(struct device *dev)
>   	struct device_domain_info *info = dev_iommu_priv_get(dev);
>   	struct intel_iommu *iommu = info->iommu;
>   
> +	if (info->ats_enabled) {
> +		pci_disable_ats(to_pci_dev(dev));
> +		info->ats_enabled = 0;
> +	}
> +
>   	if (info->pasid_enabled) {
>   		pci_disable_pasid(to_pci_dev(dev));
>   		info->pasid_enabled = 0;
> @@ -4365,13 +4366,10 @@ static int identity_domain_attach_dev(struct iommu_domain *domain, struct device
>   	if (dev_is_real_dma_subdevice(dev))
>   		return 0;
>   
> -	if (sm_supported(iommu)) {
> +	if (sm_supported(iommu))
>   		ret = intel_pasid_setup_pass_through(iommu, dev, IOMMU_NO_PASID);
> -		if (!ret)
> -			iommu_enable_pci_caps(info);
> -	} else {
> +	else
>   		ret = device_setup_pass_through(dev);
> -	}
>   
>   	return ret;
>   }

-- 
Regards,
Yi Liu
