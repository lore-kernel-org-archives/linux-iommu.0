Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517DC1FA854
	for <iommu@lists.linux.dev>; Tue,  4 Mar 2025 08:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741077646; cv=fail; b=Q98/eu2HMY73JfrcnpCm6ZeMFSGJfN8bKRG01SgmTesTquGebKloJE9TYhIiOqCxGZAlCT75uH107EAbqIkoKWemYOlP7VMDu//2/68fkaH7AfMuJoE3AFnGoV+JwaMb/NvtAjvluZ30qYyhHXxvDdesniOR4FqE4VNkvgOVFU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741077646; c=relaxed/simple;
	bh=9g2H/UTgzBYwHCABysv7cLP2AFyCoe9LFwLo1gNMVMo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VMUqWGN5geA480oi87hw2xJg7QimLHVkfnAZkqOu06nVak6Muk8HnBokYBAJ5GRLqkb6dOIFgA92T4LoHV4NYOZgg+EDgC2Qrp+B505vE7l3KsEDS0xZHOoUSOQipq0K4+IFfnUTDeAreSLWZxL2PCZM/MXxDRwFHAgB+wj/07Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H6QvHPGM; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H6QvHPGM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741077644; x=1772613644;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9g2H/UTgzBYwHCABysv7cLP2AFyCoe9LFwLo1gNMVMo=;
  b=H6QvHPGM12nw4Yz8HK+j3krzaPE+Ds7STYfWeaPeNE1u7grugYPVPJkx
   B8aclub5vqezR3DqZulJPdIt3UlZX2fYsV99lBnqlr/Kga/3wA280Jjk/
   ixO/YvulzZ7VOK+Lod65q8zBVRdXnTTCVdh63tnlnbpFPLN6yR7UA8rWh
   5Wep3bOo4lwS+LYarv3hOkAt2O7kSx3wEHOs/w+a6bUasquwlwGmlb0sn
   PAnsp8068p9UpeYf0PkBodRzE64f7MWixVMgq5klB6XPgq1gmb6TDC0DX
   QQyf3/LZs/JRUBfbieEQzrthTYVwfhPBx3r6OyfW1uPmtbhGi2pyuaIuD
   g==;
X-CSE-ConnectionGUID: YW/N7ozRQUamgCQ2zSFNUA==
X-CSE-MsgGUID: st9EVPSlTfu8ZQNl+zN8mg==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="44791671"
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="44791671"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 00:40:42 -0800
X-CSE-ConnectionGUID: EygJiOW8TW2uo1V8Rnv95w==
X-CSE-MsgGUID: CybjJnsWQ6StGFXQB3CbcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="118321032"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 00:40:42 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Tue, 4 Mar 2025 00:40:42 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 4 Mar 2025 00:40:42 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 4 Mar 2025 00:40:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aNGpgUWk61utVd56uNzwuo4NfwAVjWIzDwyUQfbQF8Jkt6Nq+0PEikgqPIjo6XDs5cip0c7pZjiUyt5c3V1HyB4rSsj0EovDWfqJbNKaspZ4s/BOwPmhAdsg/NdADbFxVRrK/s9tlwE9prrQUTfDwYgKf4f8DdZaTJhpRfLN7fzwSnkdlk+97u6+jbQztleZtUkhNkGp4Ux420NuQHqIW1JxGidC8/YvFOUJwlgQhhD9shYWud/PV2ZrkfihJJsJ38unqrMbxcxgp4lDNVuIIWarXAIV8mfEMBxQI5p3kDitKBgEbeLNmKuDPkIqmiB2Cf8eCdUwlVwVcke/UBUN3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3PUjoY8BEtL5rVwE5C2xbuiMCA0mKLeU+QQ22m8xbSA=;
 b=F1S2nbXGn6wAGiasL9TfHbaFEAoGeOczYCYZe2VlvOqvJwbx9Mpqag3NGRQRXCvgJ3yDT+DPM/ZGIVzFkTpKRLIfruPsvm/elCY6puxWKOnvGYdqt/H5IM6RQKJyM2z8AFFRTdeKn5m6KM9JJCNYy+Xyl4eG4t0PLv9P/UjH6CeiaK8/HfvvML1NTEbM2DP/MnANTIwVD1HiAXKIyRJ5aq9jBNcfg2c72NJtctP9CpA/usRfDSQ+bgq+Plv23MWwCHZfqC2+VyD7Wvibct26XmB1rz1RJEr7rsW+ay2jSLILsSDDRcgAoSbbhiMBZo+BL8zhpzpObhqVcIbxzA2RAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by IA0PR11MB8417.namprd11.prod.outlook.com (2603:10b6:208:48d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Tue, 4 Mar
 2025 08:40:25 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29%3]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 08:40:25 +0000
Message-ID: <75d56ae5-917c-4ce4-bf1e-33cc8790d4ae@intel.com>
Date: Tue, 4 Mar 2025 16:45:50 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 01/12] iommu: Add iommu_attach_device_pasid_handle()
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
CC: "joro@8bytes.org" <joro@8bytes.org>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"nicolinc@nvidia.com" <nicolinc@nvidia.com>
References: <20250226114032.4591-1-yi.l.liu@intel.com>
 <20250226114032.4591-2-yi.l.liu@intel.com>
 <20250228151750.GU39591@nvidia.com>
 <a51a5480-b06c-4065-a3ed-49046121cae7@intel.com>
 <BL1PR11MB52713F95379F378437639FBB8CC82@BL1PR11MB5271.namprd11.prod.outlook.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <BL1PR11MB52713F95379F378437639FBB8CC82@BL1PR11MB5271.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0040.apcprd02.prod.outlook.com
 (2603:1096:4:196::6) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|IA0PR11MB8417:EE_
X-MS-Office365-Filtering-Correlation-Id: a5201e0c-cea3-47ec-9603-08dd5af83533
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MldrTWJyVTFDaUtPcFFZSDlBYmd6Z0NTNkVsVlVWUGhPajVOajNaMXVrakNx?=
 =?utf-8?B?THE3bTdtVy9lVldNRWpqdkRiMDhKbjFFZlU3YURoSUtTd3lyVTQrSVUycHE2?=
 =?utf-8?B?ZlN5SHFQZ3RyTjY0OWl3V21lb01JMTBwWFo0TGtubm1DWm00TmJINzhkYzk3?=
 =?utf-8?B?SDhKdFFHMUE1ODFha3Z5UElSc05CbllvcHUvNytpaGhBcC81NVdENlhWaFls?=
 =?utf-8?B?NHR0N0tpRXI4WTUrd3dLd2FrOGdueGczVFlxcUNVNkxaeU9WTUUzbU5MQTUw?=
 =?utf-8?B?RXlFM1F3VXNad3BaK3FUNEp3N0ZWZVF0NFB6SG44c0s1cHd5VzBvdzlHN1VZ?=
 =?utf-8?B?UlNsN25MeE9MajNCQnd4WXloaCtNamh3T2R2dzBraHRwZDh4VVRCdm9rVkho?=
 =?utf-8?B?SkltdVN5Vmd5M3lIYUdabzBhVDhzU1c5a3RhUHhJVjRiTWVRUHM2NkF4MEIy?=
 =?utf-8?B?cEFCMkk4YkdUclNLWjNpT255NFliWHgrSjRRTkhZSXpIc1Uwd2FnWWFCZjl4?=
 =?utf-8?B?blZtRmMvZ1JwYmxPb2hRV1dyWFZWUnJ5QnBwVmp3bnJNYU1uaTBPdldCRk5V?=
 =?utf-8?B?elBmcUEvOEdtREpybnJGa0o2YzBQMWNVdk5JRTkvTTZTNW1pVzlpcDJ3SUxa?=
 =?utf-8?B?WWptTHYxdmNNWFdiV29JbXdRSGFVZmtZWm5YcndvS3dlM2Jad09OSjFTYVJq?=
 =?utf-8?B?NVNkaWpkei9YWnBVWWYyMmlEQ0tGUDJyam9MU0lueXc0eUZ6emM1ejB2c3hN?=
 =?utf-8?B?ZnAzLzlvakUvcXljSnB5ZmxqblFXQmNoUmdLQ0MweGdNUDFJaXZ2Q0lON1k0?=
 =?utf-8?B?OWRVNUJUajdtM0hKeVlCVEh6dDIvMVZpd1g0cEdxMmZWbGpQRVdiRGQxMllv?=
 =?utf-8?B?NmtJZGhBcEY2ZjQrODc4SmVwbEFwTGRlWHRUS3RIVlJWS3BkN3dCNmNMUUZ5?=
 =?utf-8?B?MUo1TG5PNmVBa0tSV2pzYWRFemc2bHI2c1ZLcHVGUUhaRUQ5N0M0UHdveUJR?=
 =?utf-8?B?bFhXcUR1L0lXcUpJSktZWVhKRGZRNFMxejZPRStXeUJkbllwYzQ2T2Z2Y3c5?=
 =?utf-8?B?d2pvRndPeXRPemNrdGRiUlI5Yk1hS1lEZUlLUXAydERvRWxZeWlZK3JabS8v?=
 =?utf-8?B?ajRLR3QvZEhTNWVCOFJEd1JoNEx1V1RnVVZrd0FCVVdzRG5OK3I1L2dINTFu?=
 =?utf-8?B?Uyt3Y0o1cUFYQnUyNUI0TUg1R01idTREQzdJUC9kbWh0Y1habENXV3RQQU9I?=
 =?utf-8?B?NDlURXNRZFZhdEdwZGdremhhVUhZT2xweUs5MnN2UVBPRXdPZ29TQTV5Ym5Q?=
 =?utf-8?B?T0NTdHNDcXFPQ3ErOGhrMXVhdTVJNStXR1l6dyt5ZW9QcUhaZVhSYWxOelh6?=
 =?utf-8?B?M2tFL0NmK2xPbWwxR00vclBQcXd1OHZLckdQdnJzWTh0cjhIcVdPWHNJeWky?=
 =?utf-8?B?YVM4Ull6OHRHRXYyMGVIT0thWTVSeGNBZVU4ckFid1pSREsyRzZ6eXo0UnNq?=
 =?utf-8?B?S3BRSmRUUDIzUkZlalluZlo5M0M0aWZnSElyQjBBRS8rSVdpYkVmTFNPL2Nt?=
 =?utf-8?B?NW1FVGUveXdIMGpmb1lCc0FhSEJGTjF0L01reW45NnA4ZVZ6YWFvZXllUDBR?=
 =?utf-8?B?YTFjWmR6d25FQXE0Si8zKzhoaEUzZGJ6c3piNk5DdHZUR2g4VXVQc2tIemV6?=
 =?utf-8?B?czZ5YmJRR25DK1AvYzloSVo1N3FFem9KUkh2L0VzZzhvOXpnZCt4RVV6MUJD?=
 =?utf-8?B?V2pMc3Q0bktxbnIzM0djT3ordGRkL3NYM1I0U2NxQUYyajQ5NmR2SjBEMkE5?=
 =?utf-8?B?UGNvcStvREt2MWFMVGpKS0JwcFI1VStTTGhqVHVPenVvcDBLTVpubHRyZEZU?=
 =?utf-8?Q?0WzcJ/rPSuA+W?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWdtK0U2aVNVNEt2S1V3RVZkclhBLzM5VklEQ1YzRTJ4dTlUZkpkdkgxQVBR?=
 =?utf-8?B?eEZtTGxWUUVueUtRTDhhdHpUaG0yNWVxMlBKVmh5YTJDU3R6UitPb1kyZjR3?=
 =?utf-8?B?cGgxR0lxWFJ0cENFbk93bDFXVFhsa3VQeEV2MmlFMUt2b1ZMRHJSRjIyNktV?=
 =?utf-8?B?bWpRSzFTSEJkdHJRbzJ4bERmM2ZKRUk5dndXS3dmQjRqbTBIaUVxWStaY1F5?=
 =?utf-8?B?Sk9tY0RaTTQvblFjcTk2YXJwM2o2OEYvRXNDUGpQdkRHUG1jOEVGRUt2aXhV?=
 =?utf-8?B?Mzlud1ZJdnhHN3FXdXhmL3BPQ1VnY1dZZzlCYVdBVVNHemo3MGFmWkdjWHBT?=
 =?utf-8?B?N3VSbEY4amQrelh2OE92S3gvV2l1QlRUVVp0SncvY3UzNUE1aHlVTStuYmYr?=
 =?utf-8?B?NkQ1ZzFILzBGcGxkdHRUdVJVWEczTzdjRUFnUXczVllYdEI3VlljdXhqUTlw?=
 =?utf-8?B?d2ZpV1huUWhQTDh5VGxHWkwwbkhRZ2MvN2w2OXJEemFjZVAwTkpqNTJHYzc2?=
 =?utf-8?B?ZUhoaStQcXcvaHhJci9HaktRWnU4Q2NvMzJlQnZXc2ZzeDNWT0xSNmZkRytJ?=
 =?utf-8?B?dm5SNFUxYUVWSmtSV0RWbkNmclQwdUVJNlJOWVVXYzFpb1lPcWF3d3dnTHND?=
 =?utf-8?B?WW1JZkU5WUduN1dPdkF3bTduQW4vaTlLQ2Mya0VKdlBIY3FIRUtKbUFuck5j?=
 =?utf-8?B?dVplVjBaWEQ5bGREbzRCWnBHeG1XSVVxSTVKNmdNYzZtZHFLLzVpMGo4Vng3?=
 =?utf-8?B?Q285WnNXSlRxR2NIQWhzbUloMmQrVDQ3QjFMZWUvSDVRcGZLMGR6Vnl3M3pz?=
 =?utf-8?B?QW9hZGVoTU10UDVmZ1NLYkhoTlZicnFuaXkvV2I0QWk4NURXeFBTczdPRWxF?=
 =?utf-8?B?SFp5T0ZRblRkeUljUHlYcjM5emM5VHBFOWI1VUlpeTVveGtqTHdZOUQrTTc2?=
 =?utf-8?B?Ni9hWi81VmplTnlPazI2b21XeGQ0NVR2RC9BdkxiczdSa0Vva3NhUmZpZlpm?=
 =?utf-8?B?WXpmQTBGanBacTFpSzl2cFZuY2FKNU1GN0NKUDNoRGpqUGdPcFQ2QVRiRFR2?=
 =?utf-8?B?WUowOTNwQW9Lb1o1WUlBNHlhOXpTVEtJTUpnUGJXOFl3SGFkR25TSVpNa05T?=
 =?utf-8?B?RjRiYWlMc2hFdFFEOFV0M3JpaDdCVlRkVCtObVZ3dXRMSlUwamw3ZytiK1F6?=
 =?utf-8?B?OTN5MWpFVGZuaGNnTWZja053dmtqdjdRRndJY0kwWG5MUVB4azkweUVDV2Rw?=
 =?utf-8?B?SldpalgxMlJPQVpVTDM4KzlGMUg3dFRlbEQyVmdIVFNTRDJ6Slc5WG94Y0xH?=
 =?utf-8?B?RnpTRTZhTUJULzdua0c0QU5RWThzTTN3eVk2Yjc5dFlyWktwRTBLV0NqNWJE?=
 =?utf-8?B?eTRYZ1NzVzhzYi9heHFobGRaNHJFVnB6cWV3aStTOTRWTVpWNjN6bTJPM1JS?=
 =?utf-8?B?czdWSTBlc29TVVI4RzZSU3Q3Z3pBQVhyNUgvSnBUNWk1WElEMEFMejNFSm1M?=
 =?utf-8?B?YUhoWnQzNVFwNExTTUVmN21ueTg2VjFZUlArRk8vWnBkbGdzNGJ1S1YzUEpu?=
 =?utf-8?B?TVhXY2Y0cXpDLys2K1cyRFVTZWpib1F2dzF5U3JzT2l1UmdmT3p2OC9xd29K?=
 =?utf-8?B?ZllOM3Y1bXJFbmpYOEZBUXBIQW9SanlCQVNGL2x1TG9xLy9mOEpSWUFwVEFV?=
 =?utf-8?B?V2hGWVgraXZPYi9WbHEwS2o2VGtqK2RZQ2JZN2V2aUFLdDlTUHUzdFVoTTA2?=
 =?utf-8?B?Z2VTRFJuQUkzTWNCZ3VRa3J6Y2dFWktlMW9lZFloRllnZjUxZWNGMXZtNkxW?=
 =?utf-8?B?N3g4bkJHYy91OEdLbzZ3RUdZU0Fqcy9yQTYwMDZlNzQzZmtHSVJ1TU1kcExU?=
 =?utf-8?B?bW1ldmNEY1RZTHBnNG1ad25FV2tidjlrUi84WEFjMTRreHZrc05NQTJTVkVl?=
 =?utf-8?B?S3hHemdEc3A5bmR4c0xhZzhtdk1jL2pnV1VmNnFmNXAwUFhIQ01KbXYzYnpu?=
 =?utf-8?B?ckc2NG1qc1R5dXM3SC9WNjZaZHpBMWRBU0ZMVlZEd0Z0eWxZdGs5Y29ST0Fa?=
 =?utf-8?B?OFV4bTdYRjc4MzFWWVNFVlUwVEVHODZjR3M4bmxkelJKVCtDNmRndUM3UUY4?=
 =?utf-8?Q?Hl7jJp/S/jJdYIrNFhr1INSi4?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a5201e0c-cea3-47ec-9603-08dd5af83533
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 08:40:25.0263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rOArzMfnKOf29P7eLf7PwqdF6gVaKNzAwrkKj7dYTQs8cb3xJdHtz92plvn7ZYCJ0EHDw/YWw/uMUfqE4UO3KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8417
X-OriginatorOrg: intel.com

On 2025/3/4 15:34, Tian, Kevin wrote:
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Sent: Saturday, March 1, 2025 6:11 PM
>>
>> On 2025/2/28 23:17, Jason Gunthorpe wrote:
>>> On Wed, Feb 26, 2025 at 03:40:21AM -0800, Yi Liu wrote:
>>>
>>>> +int __iommu_attach_device_pasid(struct iommu_domain *domain,
>>>> +				struct device *dev, ioasid_t pasid,
>>>> +				struct iommu_attach_handle *handle);
>>>> +
>>>> +static inline int iommu_attach_device_pasid(struct iommu_domain
>> *domain,
>>>> +					    struct device *dev, ioasid_t pasid)
>>>> +{
>>>> +	return __iommu_attach_device_pasid(domain, dev, pasid, NULL);
>>>> +}
>>>> +
>>>> +static inline int
>>>> +iommu_attach_device_pasid_handle(struct iommu_domain *domain,
>>>> +				 struct device *dev, ioasid_t pasid,
>>>> +				 struct iommu_attach_handle *handle)
>>>> +{
>>>> +	return __iommu_attach_device_pasid(domain, dev, pasid, handle);
>>>> +}
>>>
>>> I think this is the right pattern, you might add a
>>>
>>> if (WARN_ON(!handle))
>>>      return -EINVAL;
>>>
>>> But it also isn't really necessary since the API works with a NULL
>>> handle just fine. We don't check for 0 flags in the alloc path for
>>> instance.
>>>
>>> However, I agree with Nicolin, this doesn't seem well justfied as I
>>> see only one caller that passes in the NULL and really the only value
>>> it brings is to save that boilerplate
>>
>> not sure if there will be more such callers. I think idxd driver calls
>> it as it wants to use DMA API domain with pasid.
>>
> 
> The existence of two flavors of APIs (w/o handle and w/ handle) for
> RID comes from the reality that many drivers are using the old APIs
> hence it makes sense to introduce new ones specific for limited
> users who requires handle.
> 
> But PASID-oriented APIs are relatively new. We don't necessarily
> need to copy the RID flavors.

got it.

> Actually even after this patch it's still not on par with the RID part,
> e.g. for replace we don't have one w/o handle.

this is because iommufd does not need it. But I got that pasid path
does not need to be complicated as rid path.

> So we may go another way i.e. leaving pasid_attach() as is and then
> make pasid_replace() accepting a handle parameter which could
> be NULL too. Doing so make it consistent between attach/replace
> instead of disallowing a corner case where one cannot replace
> between domains both w/o handle [1].
> 
> [1] https://lore.kernel.org/all/51eb28e7-0631-4965-81c1-cf9633e46019@intel.com/

then let me drop this patch.

-- 
Regards,
Yi Liu
