Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B458E198E80
	for <iommu@lists.linux.dev>; Fri, 16 Aug 2024 11:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723809341; cv=fail; b=Id+Q6hrjWuBwkm0cmZUKUjFmVD6P4/7PZwJ+9t2c45RQDe+xEATLgCootLoeetixCKL1CJ0IfBxXQthR3lhbNsN0Fvos21kGgxL9dtE3hfExlvpYqfS5QPcy8b4nvGb6mOBUH9DxXmKFJJm/u3czPYW2TMGcD4q0q02WrFifHwU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723809341; c=relaxed/simple;
	bh=AnoN1Tv+ehJ7kou0DMLwAZzffq7kko/E7hWZvFdz69o=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ApEZmZCb9JWbuvAOM6HFNO4I0qI/BhIU11ZAcdNI9NYTdAjw92C6v2+yqQkFiz/8TyNMdQvCGTCt9Z+PPcNpWp22lgq5W8RJce5GGBgOIJaCBhTU5VzFs5xMQo3Y98XLNVyJMlXp310B4fKs2ikIAEzFi8taxS1TJRHQsC+9KDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JGFgV7P5; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JGFgV7P5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723809340; x=1755345340;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AnoN1Tv+ehJ7kou0DMLwAZzffq7kko/E7hWZvFdz69o=;
  b=JGFgV7P5WJ9ZxJ7NiY0indkJfLybg18ZTd2lCAxuycoQRzsYDI874KlR
   9qHO7EQYzmI2/wvhw6fz+PlHK4dlS5TcHONEbuuS70t0rYOZyG1/aqkjM
   BVPJR7T2+DTM72NjKxRwtGzKQEyVG5SQ3mxjYLBONZ7g72yKX5tgw7x2C
   HMSs/1+6amYlLxsXfNayT/ZxRUL201chtGMs2XadnWe4uOe+9fccDd/R3
   j4PIF89n21DJ8Ki7EMGYTm8YLbayDvCpKOEbVCe3MjAiE0I+xBZq6nqIq
   t2q2Gpk+h2pqUlklZGJKxVd46XC/HXMY2py7so2gnzzjDkcHb0suooh0r
   Q==;
X-CSE-ConnectionGUID: 3IsoeF36TTexcUgnUCefEQ==
X-CSE-MsgGUID: VL7ES8taQLmeka5r+vQ4JQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="22261120"
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="22261120"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 04:55:39 -0700
X-CSE-ConnectionGUID: vvQMOWBiTXO4jtJ2PwW/oA==
X-CSE-MsgGUID: Lb/4IO3RROelAFb3wUomCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="59671628"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Aug 2024 04:55:38 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 16 Aug 2024 04:55:38 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 16 Aug 2024 04:55:38 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 16 Aug 2024 04:55:38 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 16 Aug 2024 04:55:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WeKX85HcM7zwyKZKUGLqzLKcDKoMeHVfEy6O4uAlopPHbTR03nAZDxgFeRiHhM/kw+D+OMNw99wMKEfrIKS9CGhbpgF/pYhT3OMvdv9uuXuNtj62Qn9oQEocQYNifs9LWI8h4j7C2NNas/LEGns8HbCP+j3atOgr2nQL06ks0INNBawHV3PXIffb7OeLmVUnOU/FgX+FCAkcyeNlH2Uc7kKxkGiF7rfehYKatdDv2Tsq46SdDL7Q/iBX2Kj3SwuYfLqJQrdJ+wYYBnSSPbltPMAgheniTKnFaWxMbZJ8GC/0ZgFPTgRUJAkdB6K/OAFwjVTKmQMZfxtEHxMy1XlAOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YOOmIY0ky12dX08vJRw/vDFM9QoD1qeIlJ6RBF72vjM=;
 b=FPpf8ShtFIxgcwKBo0trYBhxX2a8noHt6x3Usv5WW9vMA6la5wAuazvE777wKSvcdRTd6jVHDp4dKyjxwR1lgLAvYWg6KEapWAYqievVX2c0Z8neO+CDY+1ZSjD6bctn+0tB+/In0PGHCkCRKMi1bhdgFIawOMl+9pwFKt69uVMW4rQsQgRl+LDDHAHfair5HzInFuWx/wVv3QwWdIFdmkRfSo6Rp4CcG/3ecIBQGZ0rENeNyHkwqZEdl/mNB9Qd6cTdAkxrXfrSUcfnJe2BjA2IAyiEv5p7KBx8roQ/rsFrNH6++0F4c/YlkCx4eJ7TrynlEwtm/MrSrfPAFTZK+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by CH0PR11MB8144.namprd11.prod.outlook.com (2603:10b6:610:18d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Fri, 16 Aug
 2024 11:55:36 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.7875.016; Fri, 16 Aug 2024
 11:55:36 +0000
Message-ID: <747f7c55-5920-4590-8546-920f1f86415e@intel.com>
Date: Fri, 16 Aug 2024 19:59:45 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFCv2] iommu: Add domain type and flag to
 domain_alloc_paging()
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: Vasant Hegde <vasant.hegde@amd.com>, "Tian, Kevin" <kevin.tian@intel.com>,
	Baolu Lu <baolu.lu@linux.intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "suravee.suthikulpanit@amd.com"
	<suravee.suthikulpanit@amd.com>, Alex Williamson <alex.williamson@redhat.com>
References: <bbe564b6-5079-4973-8678-1068a53ddf70@amd.com>
 <20240807135915.GF8473@ziepe.ca>
 <e5da0709-86d3-4b45-82cc-d995a2686afa@amd.com>
 <20240807182947.GI8473@ziepe.ca>
 <BN9PR11MB52765C37F5401E9AA7113D748C862@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240813162044.GI1985367@ziepe.ca>
 <BN9PR11MB527654EBEFE7CBDD37B7B4068C872@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240814224045.GC3468552@ziepe.ca>
 <ad009d03-9a38-4b0e-ac90-13bd8ea0b191@amd.com>
 <12db4305-de8f-4b23-8957-959709ebd2ac@intel.com>
 <20240815130601.GJ3468552@ziepe.ca>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20240815130601.GJ3468552@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0095.apcprd02.prod.outlook.com
 (2603:1096:4:90::35) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|CH0PR11MB8144:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d5e954d-e43f-49b5-5f37-08dcbdea56d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Rys0TGRrS2JtZXlTS2xYTU9pQnRYNzl2bkh5cnhtbjBtV3A1TWRNdDNCWXhL?=
 =?utf-8?B?MXIwd0dYdEV1ZG1KcmdSeVpBaEdGOWk5S2hGY3o2SUpJTlBJTWEyWExrTEw2?=
 =?utf-8?B?SUN1SExDT2ZhLzJJU3dTckJiNGQyK1VXUktJVWtpZERjR1J0Wk9jTWNxNFRV?=
 =?utf-8?B?Y2RteWVsd1lhNkdqS3VDaURUNFpuRlVjYVllMDRrN2V6Zys0T1N1STdrZURC?=
 =?utf-8?B?L0RodUhkZ0dtTUpPZXM5czJxcGdZblZ3ZkptZmR2TC9kSEJzUGtIZ0QwSUl4?=
 =?utf-8?B?NzMzbmNBdnJQZlpUcjIyZ0xBVXdlNUhpS1JINXpQQzFYTmc3amo1clRlbWxZ?=
 =?utf-8?B?MFlIZjlYRkZiaWx1a1lxVWd3NzVZSjZLTHJiVjRBUjg4bGQ3M3NoUDVsamFZ?=
 =?utf-8?B?eFFWZENIcFkyNHd6dTVBOGIyK3UxdWc2UUEzODhScFU5UkRWTzg3ZjVwUEkr?=
 =?utf-8?B?TlpkTG9HOE5LMnRIcWx2WTJsUVBRQU9zVG50YXRMRUNFbU45TVJkVUhUbGNP?=
 =?utf-8?B?ZzVFNExVWi91emJTVEtralh4YXlvMnRsbUpoYlA1Snd2bTFFSzU1czcwQmdu?=
 =?utf-8?B?WnhwaDhjWnJoa1Ezb2s0dVU3dWFqTE0zTWNKK2x6a0pBMFNjREdXT0txSExv?=
 =?utf-8?B?NTRVVkhhcG5MN2p0bkxuNjJ5M1lKbGtQZTNzQUo5cXg1aVlCaGlDQjdwWVJF?=
 =?utf-8?B?YVI2dGJ4MHNURFlTVkl0dzRMNEtMYzBVMDg0N2xPNHhGdlVHTW0zM1Rma2U3?=
 =?utf-8?B?cnZZcFBQeWVHUEVkL2dwL0VVb1JqREkxUHpRWUpCL0wxU0hWR05mcnJEWFRi?=
 =?utf-8?B?UzJXU1pKV1BKTkxSaW00Zkc2QW9EQTl4NjNJZ2lJdVBpc0pRNm1SeDF2aHJ1?=
 =?utf-8?B?dUZOTDY1c2pQeWhGZWxBeVBNeC8vc3VDbkhJb1dHNGEyb2Y0OHRBM0dKem1m?=
 =?utf-8?B?bHQxQUZJVXhLNDZ5bUthVDlyQWk5M0pPMU1jeE5WaHNXenVtS1hhYlE0Sk1E?=
 =?utf-8?B?ZmxOZTRIWStKQ1NJMEpDT1NIdEJ3SkM4dGVEd0NnaEdsZ3hleDdtU1JjenZQ?=
 =?utf-8?B?ekFtNnhOSzEzeGNib3FVSEI2bTlwSlF4YVF2TmV1YVNER3ZwTUhIYUpZZ2dl?=
 =?utf-8?B?OWhtQU9JbUhrVXpodnlVZm1nbkJFUVNtYmU4bzEvYWI3bG13MDlHN0N5ci9U?=
 =?utf-8?B?cTdWOUZacmUxQWtMQWVZdEFsV2hXRHdjTFo5ajNVNzdXSk96NkV5eDJ0OTdu?=
 =?utf-8?B?MkFuTHVJQk5jSWxUTjZvQVh2c1RjRGFEc0lqall6MlhaR1J1b1BBU3VUUXFu?=
 =?utf-8?B?ZlUyL1JzZ3V1UnZXTlZTOXYzTlAydENnR2ZNcFdCQTdRNHZNZU1XWENjdUxQ?=
 =?utf-8?B?RGE5dmY3TG51MWdKVEQ0YXJuand2VGl1MCsyeHc4WUQvaVMwNkRoNmVaQ09w?=
 =?utf-8?B?ays0Y3RhakxORnJzd2grRkNaMnlqV09mUjVobUZQcE5mcDFoRVZtZ3dvTTIz?=
 =?utf-8?B?VW5FcjNLdnd2VXRuZ0hTcjhzL3F3cys0MnB3SFhNYUdMYmVhb1dMRmxMditU?=
 =?utf-8?B?OWx0ZTNPcmFoamNzZXVEak5lL0NRVGRLK3p5djMxUk9aZGdDZHkzNkFQakY5?=
 =?utf-8?B?VWEwVndhdG01ejIvaFM2dXgwL2tidCtHdFVQbmJ1eEdXOCtjR0NjTCszUHZw?=
 =?utf-8?B?RHVRaVlhYmNERUt3d0pWVGNtNGdHQVFvSEpUS3Vqek90b1BZMlNJSW5NbFRs?=
 =?utf-8?Q?5Zzi5ReBfheprP3xgs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWVQOFR4VTZUc2FtTjVHMStHVCtteU93ekVSemlrUGEwVFRyc3pWYjZzemor?=
 =?utf-8?B?NnhZNXhTV3lrMXpmZHp1Z3JRbUREWUhld2U5Ny8vQmYwK0pLYnhVWks0bXRy?=
 =?utf-8?B?VnROc2l2RGYreWJuMDlqK2RJOTZmV1ZKblU1M2dmZitQSkxadFIyRkEzR1ZP?=
 =?utf-8?B?UnBvRUkzdkZHM2tidTFYekJFbTd6V3MrQWZxenJnRStkTWczV2JTNmVRNEl0?=
 =?utf-8?B?dk9NRlY2VUdkVmpnOG4wc0ZTS1VwNTJwaU5GQUZSQ0NzT1pWOExrZzZxYWRF?=
 =?utf-8?B?anBwYjdvTklLNTNZcmJsbVBzeFhiVk91YjI0Y3dXbFdSQzYySVJvYWNOdUg1?=
 =?utf-8?B?VkR5bFJJYmtBdVp0U0RLVVc5R0N6VG9RZW5CNzR5dGpmTUhZd3Q0UEw0UGZE?=
 =?utf-8?B?YmhSazFpSHgycTFmVWU2WkZ4LzBVa2E4aDNON2pQR1F5dEg0dUZGeUhmdmU2?=
 =?utf-8?B?YWFTdFdQYnNnSTlDUTh2QjFVaFJaMTVoTDJjSjdFUnE0RFZRWXR2VzhqMGs0?=
 =?utf-8?B?Mm1TeG5QSStFK2VmblRMKzNKWnIyQjlVdXI5ZC92MDV5cVk3Y0pmeHpDUDh1?=
 =?utf-8?B?VmxyYVcxTmlYbjFyWndaa1B0NEQrSFhHU2NBQ3hVQWpaY21rQ1M3MjVERUV6?=
 =?utf-8?B?akVsZWhGM3N6aWZ6Yk03dmlvVEJRNklkV0hFZ0kvZU5od3M5R1NVeTNQQ3RD?=
 =?utf-8?B?NkxIYVhHbUxvZ3ZidjYySWl5akFEaWQrdURzdlNXR1Q2U2VRVVZyZUZlWUhw?=
 =?utf-8?B?blZtbFRsY2M2MVV0QlM2UEVGbGQ0WVhOMzFnRGN0eURMdG1oQkRxNUprSTc5?=
 =?utf-8?B?UW5wVWxUb1laR0dDazlwa0FKSlA5STAxeDJFYVdrV2RkOWg3SUovcitiUXBx?=
 =?utf-8?B?RE9OUzZuWUYwOHl4NXhDdzBsQUlrSzlkNiszOXJsWWNNdXNTUVdqOUJjZmtk?=
 =?utf-8?B?TmdKQUNFVWdYdGlLTlQvdW5FK1JnYUYvdUVYUU00bFhyanRtY2xPcm9tNWdi?=
 =?utf-8?B?RmRqYm9Zb09icXgzd0NmY1BJdWNnYXZ2Tjh0eFNKL1EwUHZncCtSSHZwOUph?=
 =?utf-8?B?L0kzWXF3c1F2cXRublVPams1QWx5T0twL0hMcGMwRURHdHF5TzY0ZWIvSkUx?=
 =?utf-8?B?Q0xTdFhaaENjMDJiWmp2aEtMZHQ3ZktRUlR6K3JXTExTMk5vOUlCdmtubFR3?=
 =?utf-8?B?c1VXK2QzRm52Yy9GdXZINjRDOWVUcEh5aFFDaCtsSFpXQUVGUC9ZZVRtRHE1?=
 =?utf-8?B?SUsveHA1YU85VnVIQ0tHM1cweDBtTWx6UFdaeGJMb3d0RFd2UVlkdklOMnFU?=
 =?utf-8?B?QzlYbjZsTVlzL2IwRjdpeDZHT3hKTXlUS2gyOWhHamhBQ1hsTzFCSTBpZFBh?=
 =?utf-8?B?NDVCU3ByejBmOVhvMkpUQ1l6Z1R2YWd3VFlZY0U4MjViRzVlaDJKZ003OCt6?=
 =?utf-8?B?MVBBazF6SWFDRUk5NXI5Y3pFVW9SMDlha2FpYkZPdGp1YXlDTWlMd1JvS2Ew?=
 =?utf-8?B?VHBMdkM3dGd3cXNiSnpwZzFxeUhGeFhTbGtoVUtnb2ZhdWF3T1JBa241aG43?=
 =?utf-8?B?NkhKcTBGSkJqSEZSZzNRUzlaNk1FS1hXZnpubndpZVhGbmlIemgyWDlPTS9h?=
 =?utf-8?B?M1RYWVlpNGRGNDdrTzVLdUI1L0tNMVlNQmd5dU9EK2NhR2xTbGRTU3ZwSStj?=
 =?utf-8?B?Qk1Sbm5xbGtua05DQ1VpSjRVZVRyY1F3SWpkZHBVRWRBTVliL0oybzFoM0pa?=
 =?utf-8?B?NzFsVlU4Q0Vqd0VuWTFXYXRnaVovekFpK29YS2JNVGRrRFBpWFdMTXJkRlg3?=
 =?utf-8?B?Y2NnQTUzOFBrdHlmVk1VbFRjSkdoU3JZcTZ6MVdBaDc5NG0wcnhQeFlzUjlJ?=
 =?utf-8?B?L2pKZWxiZTlLVkJ0Z0ZGNzVTSThvVDh0MWhUNUVoU25aaUxvdWRMbEVyMzNM?=
 =?utf-8?B?WmczSWNkbU0wTDdMdThRclc3WUlhRmhTTXdQbUdqNGlHb0xpMldZMzNVbzhu?=
 =?utf-8?B?ZHUyR04wTE9jWXFxcTNUNk9rc2xnYUJ3UTNhTWpGSWhrV0FNNjVUVlBuL0Rx?=
 =?utf-8?B?WkNORUhMdjMydzltV29jM05ZY2QwQnZUYy84WUovWWxjUlh1d0V4T2NtdElr?=
 =?utf-8?Q?Fwv8tlyNTW5Cg5UVQx5sWNOK1?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d5e954d-e43f-49b5-5f37-08dcbdea56d0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 11:55:35.9365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VK5XyUM/igLn3SNzX2l44F9kbuukIkfTJgwcul+L6qW64lFQ+EbJSu6Uvo0dZbt9zxY+e3T3kSQfkKHJ+srSgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8144
X-OriginatorOrg: intel.com

On 2024/8/15 21:06, Jason Gunthorpe wrote:
> On Thu, Aug 15, 2024 at 12:58:41PM +0800, Yi Liu wrote:
>>> Ok. Single macro with `IOMMU_HWPT_ALLOC_PASID` which allocates PASID capable
>>> domain if both IOMMU and device supports the feature. If not allocate normal
>>> domain -OR- return error?
>>>
>>> Also I would assume we want to enhance iommufd_get_hw_info ioctl to get device
>>> PASID capability. Is that correct?
>>
>> yes as the below link. I would include it in the iommufd pasid series. For
>> the flag mentioned here, looks like Jason wants it to be in the iommufd
>> pasid series as well. I would incorporate it then. :)
>>
>> https://lore.kernel.org/linux-iommu/b37a7336-36af-4ffc-a50f-c9b578cd9bda@intel.com/#t
> 
> You two should coordinate some submission here :)

yeah, will work with Vasant on it when this thread is finalized.

-- 
Regards,
Yi Liu
