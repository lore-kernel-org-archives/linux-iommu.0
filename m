Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BD542AA9
	for <iommu@lists.linux.dev>; Mon, 24 Feb 2025 04:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740370643; cv=fail; b=EkDRZsUBHWUqKG0vHPLKGJJPtCgd5eg9H0kmtv10TmuQtCkzolIj3fgoNNUFXnhyWX5FgOh2S1RuMwVI6H/B5+u+y9XnXht9Fnxfv1hvRSUl7mkxdeVW66rEApm9z5WLQ06jRrazm7H2tnZSe2DQYauRlHojlLzQXUeFBUpgXVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740370643; c=relaxed/simple;
	bh=TdO2cZmthLN+dPkRvd1rAbDfrmKa0WcsZ94GsUINP10=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=naCONXAgddtmpVdeH9vANBunwQ84WYpKSK4rPJzRyOyCw2akUYZqzdGqzqiKGfv9kBMFWHGXV5kJX4n0eM6eyRPHWIvnXbllWE/hZQ9dU78mqg6LT0NpFOgC7SwUd/ES5xI5U+zOs1LRzKByqqRUN4OQpzKb4bOhR8AmsA+iCiE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ft0nR4Er; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ft0nR4Er"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740370641; x=1771906641;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TdO2cZmthLN+dPkRvd1rAbDfrmKa0WcsZ94GsUINP10=;
  b=Ft0nR4Er2d2G9l3vndz9IBH6mG0pnKf3IR5/VJUBPC54xUvt4c1JmU7a
   hwYF3qkuzQgEQZJXRFnhcti0Rdof6hxTxhA2golfHVrnvnLB48lbPstti
   BaiW2BTWMIVvoXEtB7Ln4wRKkG0sLU4AYSTbQqMZBLE8jG6r7jko2k54i
   UpADIkGDtQNRClYMt9cO/kuN6U3yhK/nHaXUtMjKzkoqLvpmAfOCkERWr
   Unx73t4RzXajhmUZ6dsJyXd1UiJc7WbqsVv4UZn+0Rd41sNYp6zd9087C
   7RJXt96Ubux1ZF9ZHa8uTtNgZJiXuRNuwEgpQjcMb2YXs64V8mllgIjke
   Q==;
X-CSE-ConnectionGUID: i50kSyNAQHGipFH5eoP/nQ==
X-CSE-MsgGUID: XSwShU1FSrqhbZ+/JHHcxA==
X-IronPort-AV: E=McAfee;i="6700,10204,11354"; a="43943130"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="43943130"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2025 20:17:20 -0800
X-CSE-ConnectionGUID: O9hGgB5kTUSqKHWt+dobsQ==
X-CSE-MsgGUID: +YsiIGOzRZuBV55ZxSF6og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="120571435"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Feb 2025 20:17:20 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Sun, 23 Feb 2025 20:17:19 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Sun, 23 Feb 2025 20:17:19 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sun, 23 Feb 2025 20:17:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wFF3IFp8onhU3ogvRwNEwLQIgyGgIqQQeluPcgLuZxRhJIgM4FUxeTo5YUK+r60XMdUHl5h0tH8K72WT0HwKsck0jADCEBQwS7ZDwp+H7IzF65F6AaBy04GvPQeolkDmWYtRe3pBDK+0QwEqGX6F1XJsHytIA3kC6hbOD52VgvOEU3I+aL8kMnGgaZgbI0vliapY7ubG+B3no6hNitrTGYvomJeCtOIh1Snjv/xsql/3dskaVqYs0xtVjNk8vzJPm5+f/78798hz+Fepp9jpYy6dQOupZRzTP5jD1EL+dbMtlyEn0bf/wQs2lPJcKF5vhvcXfTAnRW/pkPJZZK/NtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vBPHmziSdC5iOdFDHlp0EnGoMp6CKIXo52iH9FpAEVM=;
 b=CeSv1MEbx5tPhY4Gr04ykV3n0OAqylxyQmlZwFxV2cIzzrJJcs9SialxvGBXsUossSHwcLe2iyfBD0hSRlC9GtNaOLVc3QEyz+mBWTD/MhEMvQ/g5h1e6MsSK8ti4X4ooxYXgypvWz7bEHEmKh8I2jTHWM0/aVQDAbj/IL2lJU+8ZutVCvOsBEwHgPW3gxVnIBSQNlZDTgOxrmMxpH1rIJEWAY5PUk8oHE93F8poOXTfqettrs6pWYarL1xJVNoU4QEpmorSzxHCe42jQbxvLj5h0B9J2sRKZhKDLfw4l1YyWhDyn3uqMwR9bwihtL+6pzhbFQYKt7oJHpltjsHYhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by MW4PR11MB5909.namprd11.prod.outlook.com (2603:10b6:303:168::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 04:17:12 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 04:17:06 +0000
Message-ID: <00d27f28-0aae-4940-90ff-2a764878d949@intel.com>
Date: Mon, 24 Feb 2025 12:22:28 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] iommu: Store either domain or handle in
 group->pasid_array
To: "Tian, Kevin" <kevin.tian@intel.com>, Baolu Lu <baolu.lu@linux.intel.com>,
	"joro@8bytes.org" <joro@8bytes.org>, "jgg@nvidia.com" <jgg@nvidia.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
	"will@kernel.org" <will@kernel.org>
References: <20250221143335.49874-1-yi.l.liu@intel.com>
 <20250221143335.49874-4-yi.l.liu@intel.com>
 <a4a1e65e-3614-419c-a5e3-6ff2aa4f1369@linux.intel.com>
 <BN9PR11MB52764D5D3DFA97B187DAACE38CC02@BN9PR11MB5276.namprd11.prod.outlook.com>
 <6555deb7-17a5-4e0b-b167-fef6785a9961@linux.intel.com>
 <BN9PR11MB52768A3DA2D4961F9732EAD68CC02@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <BN9PR11MB52768A3DA2D4961F9732EAD68CC02@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:3:17::31) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|MW4PR11MB5909:EE_
X-MS-Office365-Filtering-Correlation-Id: aa4b4647-e297-40e5-afe7-08dd548a1905
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q3pjQUFjZ0VpaUk1NnlpMVRpZjJvcjFib2V0akpzWTBsblJDNVZINHl4UE4r?=
 =?utf-8?B?RHdkd3VJM2JacW5KU3BGS1RETGI2V2tZbjBKVTByb0F2R3pCWFhrTTJncnZM?=
 =?utf-8?B?RXNBZHpwWWM0ZWZzL2R3VHJwZFBFZCtqbE0wcWgwRFZicUpOSEtsNjdJSW5Z?=
 =?utf-8?B?L0s4aGpzcHpGajVjL2pwaTREQW5LK3ZXOEIwQ29ZNEl2N09mbEVTUGdROGxZ?=
 =?utf-8?B?K3Yza1E5bUVDN0pMcDhDZU9Bd1ZoMVdHS0dnZ3Fqd2V1M0pWQkMvMEhmRW1P?=
 =?utf-8?B?c1JJWEUraEJlK2xSdFJTRlJQRFVYbndKKyttb1BsdDREOWlWOFhMaDM2QUlO?=
 =?utf-8?B?T1JCT1ZpbEF2enpHa2dBZUFYRnhnZTM5ZThlRGRsRjRLUm1URHg4dDRjc3dL?=
 =?utf-8?B?M0o2ajB2SmxsN2FFbHAyc1VDZEg4K092bkhIWXJZR3dUbUdjWG41UG9SMTRk?=
 =?utf-8?B?b04xV0wwSHQ0S0pVVk95M1F1aGQ1THZWNWl5amVXRmVpWWsxUzdnRWxGUWF5?=
 =?utf-8?B?OFVrYXZKSk1ZMGsrZTRrOVFMQzROYnFyOGFhbkhTYnYvWXVtRGRQR1hTemxw?=
 =?utf-8?B?MVhETEsycVRKV215dStZQVJFT2RHcXRLMERmWnlOUXRSVnVjSEZ2M0tUMUly?=
 =?utf-8?B?WVlhOG80MmU0S3R5dkcvd1UrR3FBT1M3TUF1WmYwMHRpdk1Ba1dTeEZhTmNR?=
 =?utf-8?B?VkpqOW5sMnJkeW52N09UbVBhUEdGb0lVZlIrTEtnWTNMQUxmODlUZDA5NVpz?=
 =?utf-8?B?a3hGTEdDcHZka0tuZWI0d1RIT0RkYnR6dWZ6MitwaVFmNjFHb1dOQmxidWpV?=
 =?utf-8?B?N3pDLzZLbkN1M3c1elVJUnJoc2ViRG55N2ZQemM0dWdWZWdmU1BtTlkrRkox?=
 =?utf-8?B?QnlVOWxNelpQMXlENldzWkpxR1FLU2xTWGVCeHBhN0JTc0JQbmUwbFMyT1Vm?=
 =?utf-8?B?VndwVzUxMkRwZFU4ejg4Q3V3ekoxMHVBRHcrQkV0VVQwbGpjQStCOHl1V0lP?=
 =?utf-8?B?NHJ6bkE4QW95NGhVd2pLMk1aLzZzN0gzS3RqS0hzL2JxNGJPMkx1dUxtbDZS?=
 =?utf-8?B?MWJmK08vTXJQRGVjQUFGdkFHaUY0VnhPVTJnSjduTUg2dndxYkoyTjloTVpY?=
 =?utf-8?B?dnhCbTBNa243MVV4WlRQUitsaEpSYkFGTDRpcXprb29INFIvdHlmUVNDK0hE?=
 =?utf-8?B?OUtNdFBUYkVxcGdQSldCVkErRkVvUDJBUTZTdnZsR25KQThSZHVYMUZXY3Rm?=
 =?utf-8?B?Y3V4TnRUQlBHSCtpcG5ERlRVcDQvSEhVV1M5TmxxMkRNUDJHSWxTOXF1Wi9w?=
 =?utf-8?B?WHhhampoZUdXRlN6Ky9vUjIwbSt5V0tOY3owcGF3S2FOQXhvbU5pZVRCSUpW?=
 =?utf-8?B?VjQvZjg5eTdobnhuQmlnd1NKU3RaaDM3MmRITzcvTzVDQ3hvYlFHeDNEWkpR?=
 =?utf-8?B?MjVtRnZyOW9DQzFPZFJ1TUFrdHlUdWcwbkxCNElINUhDK215RUsyU3ZIbnI4?=
 =?utf-8?B?QXRRRWxlZVVJWWhSaU9xNFEvUkRkNitaSGJoTHBLb2N1bjByY1BoREdEWm9Z?=
 =?utf-8?B?Z3pWTytWa0UyREtnU1BJeTVhTzE3Q0ZRd2pmeUtPb3h6TG41OTJXWkNsMSt3?=
 =?utf-8?B?WlFiVlZDa1pGd25vNFBIamlaa0NwcEdPaGJTamRkYjd2UFFXUk5kT2lhczA0?=
 =?utf-8?B?aGRpZ1hKVGVITWxBNFduS0ttQXNKWGI0dW9YR2NKYmtQN2xkckJZcmlCbSta?=
 =?utf-8?B?ejkrdk0vNkttMUJZTmpBbnkwcHZpYVVRZ2RvY2pWVzluOHc5b1VNc1lMeGZv?=
 =?utf-8?B?QkN4c3FBbU95RmdkWUtFMlRudUtXK2s0cXM2R25HUkpqWDAyNGhjM1hHSjFI?=
 =?utf-8?Q?0UOAAiOnesXM5?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkUwWnp5eFgzR0xxNFp6OURjdEtFWDlSa1dRMWxUbHZYejFuQWtsTmxCSzFw?=
 =?utf-8?B?ZWczcG9FUEhTeEV4bm9od3hWYTZEZ1FGU0dFVGlMc2l0MDZBUVRoRmFOcFlw?=
 =?utf-8?B?QkQzb1ZFQmNjU1lSNjUzNUsvTkkyTE8zeHFuRG11QTN4SFVoWHRhMVhlNWlG?=
 =?utf-8?B?STU4WG9HaHZRbGtGOXNUQklKRDkya3RSS25XeVZkeHIzaFF6M0RwNkw1NC9P?=
 =?utf-8?B?UDBJVHcya0hlWmVKQVRVRFZLZVkyWWdYUGlpcjBra0IwY1pOL0dDbCtIcHg5?=
 =?utf-8?B?WkFIcmNldCszdmRId3h5RVVvVzRvNnUvNFd0endHMFY1VVZReG1SUUMvbE1x?=
 =?utf-8?B?cENIK2srRjBGQ0FJUzhIMjBMdnhPUk94Vzc1dDBLZDVMdEdjd2dpUzg5TXZI?=
 =?utf-8?B?TEdqQmF4RnBGT3dvRm16NThHdm5zaHZKckF1U2xmcmtmc1dtMVhFRVlBN2tI?=
 =?utf-8?B?bjhuUjVqRWxJNURkVmJxSUpOaWtLRkhCNEhtcTAvZmkyeTJXVU9WYkZINmJ3?=
 =?utf-8?B?N1BVMUQ1UjNYUDR4YlI1eElxUzAyNTB3K0ZzWGFMNnZVR2ZuTjlKL0FzTXF6?=
 =?utf-8?B?elAycSt1cVpod0dzbnRIQU9mdUJFb3JTTmc0N21EZlo5VjdhRW5EMWFoUGJt?=
 =?utf-8?B?V2lROXhURWNhVnhMb2NYSEhFVGRnWkdrdXFMbHBnbUVERkpSdTBUOVJiY3o4?=
 =?utf-8?B?VVFRazdoOExIWHNFbHkxOElxckxqVXMyM1FSYXFuOW5EQlU4SFRyWXJWdFUv?=
 =?utf-8?B?Z0V5eUtDa0tta3RDbDRkMHJNeFhyK1d3Sjc4RVc2K25VaGNJanpLSzE0d1dy?=
 =?utf-8?B?dmsxaWdIaVB3RnV5OUdvbzVRT3B1YTJQTEFucFp1YmxxZW1CKy9RcjBBTVIr?=
 =?utf-8?B?OVlZakEvczl6aGkvRm9WVlEwWS9SYXZoVWI5UlhJS0VvOTJNTFpLeEF1VnZi?=
 =?utf-8?B?L0xVVlMyWlp5SUFXOE5sS2JRYlF2R2twNHJmL3I2SEorUHVITndVM2pMKzdp?=
 =?utf-8?B?VEVoNnpjdkc5UjZZL1VrZk1LZUloTjgrbStZWlprcS9GbG1YV2tGQTNCZGhx?=
 =?utf-8?B?TmQ1dGM0aHVwdzc1U0R0eDhwekJFRFZjQVF5U3dNZUtKSFhWUFBZTjRWeTRm?=
 =?utf-8?B?c3loSkVmYzRLWVJxR2dvakNtN1laMzlrVXdBVlZqNUlSVTNQUFhXMUs4V0Zs?=
 =?utf-8?B?Q2lKNmlSU1hLcFkzc3QrUitlU0xwL3FjZjVNdmlLUVd0T2dnRmVrZS9mWnVZ?=
 =?utf-8?B?SmZ3YmhYdDErOW5xWkx4aHRsaEZVMkFZSHcxVFk2OFpXZ2o3ZlFYTkVrUmtW?=
 =?utf-8?B?MTBpWTZHWG5iR25uSURmYTdkZ2h0TEtJUmN5OTF0T3llck1IK2RmQkJ0alJY?=
 =?utf-8?B?L3dHWFNDOTBybG5RRHRiWVVMNEdpeW9EVjJEQTRmSzRYdjJFcUFiNkNVbXZm?=
 =?utf-8?B?WUl1bXZBR1dxL3ovZjB1NEFHVTBqeW9pQ2pQS2M0K20yMEluVWlMSkpKc291?=
 =?utf-8?B?VmNYMlBYSW9lUE05aXkwK09ueWc5Z0ptRnpDSks4SDZ0MGtSVWZjc0xELzBa?=
 =?utf-8?B?TERFeVpUTFk3cGVmMmhzVnhNc0RsSTI1L2JscDBOQ243YStjeTVPNmpqVDZF?=
 =?utf-8?B?bjV4V3RsY0pYWUJvNDd5akdaTU1RdzVYWStqV09rL1hPSjlzOHlEd1VmbnRP?=
 =?utf-8?B?aUh0bHI2OU1xaDZXOFV3blBSVHZYNmVQL2hweE5GQndBK1p0WEVLUTFtV2xU?=
 =?utf-8?B?MEZGUnJDUVVDVEM3eEplb3htckI5TVJUZUpCNnZyd2xnM01PSWVKdkZwNG9z?=
 =?utf-8?B?T3ZwbmdmVGhVSmJxMVIrYkNHU1lUbkQ1WUxmaXhhR2pLNVpybWhoLzhnTVdz?=
 =?utf-8?B?MzNpVzVpeUdReDJPUnF3V2hqQ2xSVTJNMlJpYThSVGNaNk5Ib3JOSXNFbVdX?=
 =?utf-8?B?WlE4QS94dEFSWHFudGl1RkUxMklmc3cxUG54R3ZWZTUzSVJxWTBJdGJJTFc3?=
 =?utf-8?B?SGJBTE9HaytGWUdnRFovVlRPaFlBVHpIb0R4MHVNUmxmUjcxUXFjMmtqU2N3?=
 =?utf-8?B?TlhTRE4yTkhYbWU1TXc2d09MTjB4TnZyS0NUUDFJckVXZEJxL0ZNeWZSZ0pi?=
 =?utf-8?Q?jjr2rQmHPEorMlNOBP6zeC38l?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aa4b4647-e297-40e5-afe7-08dd548a1905
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 04:17:05.9881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jEhu4y4C96W2lFnK5I94DvEz0E/0jWyiUS6OpmiChX7KBYA4YihnrPG0/4/p9SZ91EKbhX6nIBfCXEcZuxmgEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5909
X-OriginatorOrg: intel.com



On 2025/2/24 11:04, Tian, Kevin wrote:
>> From: Baolu Lu <baolu.lu@linux.intel.com>
>> Sent: Monday, February 24, 2025 10:58 AM
>>
>> On 2/24/25 10:38, Tian, Kevin wrote:
>>>> From: Baolu Lu<baolu.lu@linux.intel.com>
>>>> Sent: Sunday, February 23, 2025 9:23 PM
>>>>
>>>> On 2025/2/21 22:33, Yi Liu wrote:
>>>>> @@ -3454,13 +3468,17 @@ struct iommu_attach_handle *
>>>>>     iommu_attach_handle_get(struct iommu_group *group, ioasid_t pasid,
>>>> unsigned int type)
>>>>>     {
>>>>>     	struct iommu_attach_handle *handle;
>>>>> +	void *entry;
>>>>>
>>>>>     	xa_lock(&group->pasid_array);
>>>>> -	handle = xa_load(&group->pasid_array, pasid);
>>>>> -	if (!handle)
>>>>> +	entry = xa_load(&group->pasid_array, pasid);
>>>> Could entry be NULL? If so, a null check might be needed here.
>>> a NULL entry will go to the else branch in following check hence
>>> get an -ENOENT error.
>>
>> xa_pointer_tag() implicitly returns 0 when the entry is a NULL. I
>> believe this behavior is unintended. The comments of this helper says,
>>
>>    * If you have stored a tagged pointer in the XArray, call this function
>>    * to get the tag of that pointer.
>>
>> So I feel that it's a better code style if we check entry before calling
>> xa_pointer_tag() to make the logic explicit.
>>
> 
> Okay that makes sense.

I see the point, will the code like below. thanks.

	xa_lock(&group->pasid_array);
	entry = xa_load(&group->pasid_array, pasid);
	if (!entry || (xa_pointer_tag(entry) != IOMMU_PASID_ARRAY_HANDLE))
		handle = ERR_PTR(-ENOENT);

	handle = xa_untag_pointer(entry);
	if (type && handle->domain->type != type)
		handle = ERR_PTR(-EBUSY);
	xa_unlock(&group->pasid_array);

	return handle;

-- 
Regards,
Yi Liu
