Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475F59443
	for <iommu@lists.linux.dev>; Fri, 21 Mar 2025 00:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742518052; cv=fail; b=PdWyIKD7EuD8BNVxzuHs3NklHSll4h6liWh46Qtz805uCQGRDQhrfoYJGYPcoDV5kuVXMdTaIzbYiKYE/0+qoepcq2i3bg3XnKqd7zdVNqzOgzkkupAhQHtdc2t2rM18ysygbVcQ4n5iD4bYDwRSdw+PbY8swmIbt1F6AoAF5HU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742518052; c=relaxed/simple;
	bh=ogkDm0dxvZggXDU77UwhQXQ3Rcj5fY67uG+ygoAOrEk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=g6aleQSe570QBLUstKn4Gcx+i+A8r49r0OqF5bk5RtcisJrPiA26oIGzW8ZzslqIVkzwG3FhiXAHyp44f8ehmHMgpT8CUdkjwDOzA/HDA1An1T3sLD93BoaalVUMS5OeXo2tF9FuleiFpsgWjziXsfjjna+hMe2wmE+4V7w7d1Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WC/FLBbr; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WC/FLBbr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742518050; x=1774054050;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ogkDm0dxvZggXDU77UwhQXQ3Rcj5fY67uG+ygoAOrEk=;
  b=WC/FLBbrEl13ejANJj0TICATT6UdcoJxv5WIXMTodmLJn45BmB40cqvE
   XJ8dtivWKsN1w389ING0wP03PDmvSCnVCAAK+ijF42VXMD0Tpd4hFKR6S
   ufTmbKQ4apeHkeDuqfIM1ENSOvFUXh4CESfXIejDwrGm7p2JxbEShVAO7
   tDVAQvT6MhE1rQte4FULk48phx2jv5qfZt+K29URJ8zswIIU9EU13Bnbr
   XclGPVoaUJuIfiK2KcqjLwx8yaUBOnF41J5Zjzir3OdvikLTUZdLW8eay
   3iLzBHD4q3Ck+TVDVNT4eOBjXwXEmv05ikMuRWDdHHVCdnKPlsHfA/Dji
   A==;
X-CSE-ConnectionGUID: g9qFNKraRC28zta8uw1LOQ==
X-CSE-MsgGUID: KEhQlXttSqKB9GFnG7j/5g==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="55159305"
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="55159305"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 17:47:29 -0700
X-CSE-ConnectionGUID: lXhHfircS8uc2CqKNJr1lQ==
X-CSE-MsgGUID: xshUYoQgQouqizE/15jGEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="128321319"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Mar 2025 17:47:29 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 20 Mar 2025 17:47:28 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 20 Mar 2025 17:47:28 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 20 Mar 2025 17:47:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t+rM1t0cVS+F7WWHwiYLAy0YXsWMBc4Rj0GyOAtRubqAd6wY404vsLvPavU8h+0MdNn5ssV9h/3SPYMzuwOVNFHu3/Q7uomMBp/WXlK3Nc6HFvaFTZRKCAqn1qTT6oiIKwZAWD+ypUaPfMRt99RzAQKLFsFtZ8UwLq8t7sqHleGiB6nHZKN7+KY7vd9a919xoiTCIkgbt1GniI8AOLOJ6tP2h32u4j6mZsRZP1WPcvapcdMMgWF7BON1BvZHGkulWirbMUA8A6U8mlPVtk4emQxatFikGnnfA6wmSH5gB5s2yqrw4oLXozLR5pYZUgv+WqnZcXQQOXv+K4ordDIpEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rlNGQtwNaGtGaYxuOfxbM77JY5gqFppPPUX7H8F0s5Y=;
 b=RZ9cJmRlqz3fBV7jSGyM1DqWnrU9I2FoFjWNuh8322XR4UK/bUV1zLTDBLSnK84jYk8HanCoz8dcQNwVYmuvU6ZBx9MzmHK5JGPabsJSdgArTo+2YmpgvDXSGY6Fl+lY6KG+yxZnB54VeMD1E+ZzKzXq6MfWjKeSRIGilzqTzyEZH18chqEJ29zKhKxT8BmtsiBFgjUD9ungBBsQGOPKG1fuONmDLldTX32KkHE/e5Tvfsiil7TRTVFZlmi/pD9mPe9KjarEk1klwOrKcZk77gzQWZY8Z68vQEaij7J/v9VCRijafR+HIFwdNjKeNoMfkTkG1S71B7EjRD0LHE27xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by MN0PR11MB6009.namprd11.prod.outlook.com (2603:10b6:208:370::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Fri, 21 Mar
 2025 00:47:09 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.8534.031; Fri, 21 Mar 2025
 00:47:09 +0000
Message-ID: <a73a832a-0092-422a-a7c2-fef23a6af85a@intel.com>
Date: Fri, 21 Mar 2025 08:52:37 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 14/18] iommufd: Allow allocating PASID-compatible
 domain
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <joro@8bytes.org>, <baolu.lu@linux.intel.com>,
	<iommu@lists.linux.dev>, <nicolinc@nvidia.com>
References: <20250320134744.5777-1-yi.l.liu@intel.com>
 <20250320134744.5777-15-yi.l.liu@intel.com>
 <20250320175107.GD206770@nvidia.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20250320175107.GD206770@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KU1PR03CA0005.apcprd03.prod.outlook.com
 (2603:1096:802:18::17) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|MN0PR11MB6009:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f0bdf18-5d5f-4d3b-5dcc-08dd6811e8fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Qk0zMmwreGx2ODRHcmVhMW04V0gyeUxqTWJRR25HSyswVmVoVGpBWlVSOWVl?=
 =?utf-8?B?YU1FYWJidGNrTVhtSjZqdGdnVXR2cldQTHRnVHhwZkl2TGV2cUZGM3NFR3Nr?=
 =?utf-8?B?cjZTcFN0dVUvVFJ2VFN1TGtMaVd1QklmTi9KMS9QYU1uRnBrUkUxNS92bHhq?=
 =?utf-8?B?MlgzeUxla1IxMTVVY1U1T1dwa0dSRXc2V1hzRWdpSXJmYjViYzd4R3B3Mnd1?=
 =?utf-8?B?TGZOdGl3ZXlEMXV2eURoVkFhMW5oeEVQQTVvVEtKWHVOLzdNcHAyczJFOTBY?=
 =?utf-8?B?MmJLUW9wbnF2MXVpK285M05kYm9namVTWm9Db1lmbHdYY0s5SjNMdjdmWEVX?=
 =?utf-8?B?Z2ZVQWl2dDRZVkJLcjgzbUEyckhvcjdnQ0ZUZ281d0p1V0RNZS81VVY2UnRR?=
 =?utf-8?B?eDBYZWhiNGdBZ0xPeGJHNkM3RUVIdkZlZktTUG1vbXoveWphWjV3SVFqZTZ5?=
 =?utf-8?B?dGgwRnFOR1VMK3FSa1VmaU9mNThJKytRd09jVEwvVHN2QnYxQXNvb21SV2Vn?=
 =?utf-8?B?Qjl3TlozWkVJWXZGckQzc3JOYWVxVWZoL3l6WFl2S0w3U1NJWnVRZWJqTzFj?=
 =?utf-8?B?N01FZDYyNTBIa1VlNGl4OVlSdHVyOW54TWxOVEI3cGt6aGh1WEo2Y0ZIS2pH?=
 =?utf-8?B?L0NJa0ZmTzNKcUdKMnUvdGhPQi9KUkJKaEIvMUxTaFUxeGNBZWVmRmx3Y1JC?=
 =?utf-8?B?SnlOTEc2NXFMdXJ5WFcvZWNFdE1nWUJWdUNubExiaGI5cDR6bDdvbzR1OFl1?=
 =?utf-8?B?d0JwbXFLdm5pMTNMWE10aFU5QWNwZk9uWVo2UktXYzNTcUVsNW1vWXlhMDFs?=
 =?utf-8?B?Tm9MUVIzNkpzRFcxdytEN1RxZjVDdUc3K2orOGZXUFJGNGZGcWI3bHBFYnFW?=
 =?utf-8?B?QzNTZ3plSExJanpzdVpFeFl5STlQVXhwNG8zUSthK1BWUUhXT0Q0WGRId3Mr?=
 =?utf-8?B?cmhUNWRYNTR0RDNDUlA3eXVDZng3OTVwcnk2NjNRSVpRbFR5a3JrZXdCMU1S?=
 =?utf-8?B?UHFSSzIvWkYrNXN0UjdmMmpqaDRLcll6UnRSRFN2encvaWJVREhNMVlZcGRL?=
 =?utf-8?B?VVVqVVQ2RFpEcWpxb0dYT09vMUR3RTBZemJQdllacjFNYldqTW03UHVSNGts?=
 =?utf-8?B?S25xNVpNa3hXREJsS1R3K0NBNUFBM2xtVzRMVnZVdUhWS3R5NC9kQ2toNmIw?=
 =?utf-8?B?ampML29LYXdGanFEaGhyRWtqaTdxSEh0czR3YW5FSkpOVmhsaXRETVNSRGZq?=
 =?utf-8?B?QndHcndSMjlPU2M1RzVFOElyZHg4a0FWeTliaFJCV3gzeENCeCtwd1dyMUda?=
 =?utf-8?B?WnVSRFlGK2FuMjFaWkJBOW1welhMVnY1TVErNGNBZTlxYXArOG9MQmlUbTJ2?=
 =?utf-8?B?MTNyL0MxR2U3MWlua1RtcXpVbnl4SXdXNXpmTDhOTERXSU1zVVpsR3pMK1oz?=
 =?utf-8?B?VmJveGVIKyt0ejZkTjA4UzBSNUNORmJuUVNQcE9WZ1orYUhkNWhXSEtIcWZw?=
 =?utf-8?B?bkNIRHRZais1VjdYQUtVZUFLSlB3RTlsWEwzWHc1RXNhSzR3eWt5OFFKTVpw?=
 =?utf-8?B?VU8vN1dOdzVnaTZTWWx1aDFhdFd3alBLSHJLY1RRWFFCSGRlemdpZlBKOVN1?=
 =?utf-8?B?d1Z6Vm44cDZ1UTJNdjZKbDR1Zk1MbXlzYnFxS0RteGVabHBEdUIwSWRDdnBp?=
 =?utf-8?B?QmZvRmszaVhPUlVsL3d2aGlVMjZvVlNXLzM4NGQ0QTZHa2kzWHppRm9ZQXRi?=
 =?utf-8?B?aUhvYjROVVQzN29JZkNSSDM2T3ZvSTNueE95T0dMK2xLQmFBZFNFSnFHRWlq?=
 =?utf-8?B?NmhSd2YzUXZGOE41SFBGUi9qSXQwbk12NDd3c1puS1J1ZGM1VStKUjM2bHZx?=
 =?utf-8?Q?um1dNAgBBcDfX?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmFhL296czVYL0dvRkhVRkM0c0Q1bjdqb1BnZytFdDVWQWFxY1dYVTI3NE9z?=
 =?utf-8?B?ZEw2SmxZeTFkd0ZBdjEvWDR3dHVJMjErVTBsbmxNV2hFWW9BTjVLZjl5clhQ?=
 =?utf-8?B?VEZtcVRzbFBibnczRFpiRGNzK3dUclpnK2lqcDEzbUV6Tkx6d1o4Qkd6M3A2?=
 =?utf-8?B?NGFUUUE4Q3Q2Q3NXTFIyMWNQa0VYZUVUYlJ0eWtWL01vSU5qdDdXdlVCTjQx?=
 =?utf-8?B?Ykp3K1pGVWJwNXgxeDhwUk8yYTlxNzBJU09QQWhtTzBKZEI5QTdPNFFtT1VV?=
 =?utf-8?B?YmVIc0Q3RWxjZXJHTDFlWHZtRGt1eFJCUjJrK203MmdxSXQrZUVkbTF6MHl1?=
 =?utf-8?B?L001NG94ZWRKV29RTkcvWWlHZFNmVXZiYXVtazJISEJ2bk4vNFVidERybHpP?=
 =?utf-8?B?SDRVSXhlbnYyTDVHKzZLbjhDOUt4b2JkelMwQVF5NWdMdG9sWlZqLzB4R3cz?=
 =?utf-8?B?ckpjTG5aZGJyVlBIUGJiQU9iNEtQV1dETzBwcm5aK21zc1c0Ni9uUzJ0Y2tu?=
 =?utf-8?B?a3pKSnJvaml4YzBpV2I1NzB1YlMvUTRsb2JmUmtzTnJiRFR1T1gxUzJ0NnFm?=
 =?utf-8?B?a2c0VkkyYyt4MVZpU2V6UU9CNm5OL3VBUm04aktURlNuZDFWMlNqNXpUSEJM?=
 =?utf-8?B?SFlYcHVhWXNLOFQ1Tk5yRStDOGkzTnhzQ0l5Q3pRNWhYeTBqbGxkREg0MTF3?=
 =?utf-8?B?Zm1icElpQ2x2TXRZNHE5am12Vmxhc29KVFdUWkxzdjhtR2hROVB1c2ZMQlk2?=
 =?utf-8?B?bXVncVFweTdWTUhYUnFlS2I1R2pVQ1NHWFhmS1hqUGF5UEpsaG4xSXlMMXZQ?=
 =?utf-8?B?QUNxRWc2dlhkQ3o4eTdRWDhmZGFkeDNWY3Jka0UxSDJaaGJnd28wdHlCQ1Ft?=
 =?utf-8?B?bDJDajh2WlRYTDBCRWowWmtCcWFHR1ZpMExPZ3pYNmwyc29YcFV5enRtblRS?=
 =?utf-8?B?Z2MvLzlJbnl6M2JKaW5xS0RsenVTL3JXbE8xZUNzZFZGVDZHaGZEdHE3M0dS?=
 =?utf-8?B?YXNYSUQzanBtSVk1WWsvSDBNNFFnMmE2RTlhNVRNaUJBT1RUZkN3eC9odWxZ?=
 =?utf-8?B?aU9hQllmYUVuU1FVZnZjNHB1SWVGRDc0TEE2NjFaOHA3dkRuZWlJemIrV1o0?=
 =?utf-8?B?VjlFQTdxZS9zYXkwUERBT2xKUmVPQWI0M2l2dUxxMlFRVVF3VFVFQ2RHYWdp?=
 =?utf-8?B?anNTa2ZGTGhGN0VMREtjak5GbU45dzBybjNrcFJkMTl2VzhEODAxU2dLOHNy?=
 =?utf-8?B?NTZya0t6eThLaTdOZ1dKa3htM0xXRG45OFI2Q3RFVXliV0QvZFRrUi9JR3FZ?=
 =?utf-8?B?QjVXbnl6SGI3Ui8yOXl1Y2NYK1R2QmttVSt0cjVySDBiYVRzZ3Y2VUlwaFp5?=
 =?utf-8?B?bytuQTJLaDZabm93Z3BBYzlOL1YzL2V2V2NRVmorRHFNandCV0V0MHJpa3hj?=
 =?utf-8?B?ZFFDd3FjUlFGS0F5ekpGNVppTWd5dGRteHE1STNzQWJaN2orTmFOT2RsekR6?=
 =?utf-8?B?NThJcmJCUTB2djNqajUyUHlTb25FVTdYY0FYSUJqVmNlVWR6cmdkQllldGdK?=
 =?utf-8?B?OURncDJWNzNFZ0ZUdTJSbFowcG80clEzV1BKMUJLYzB6TG9DVzN3Y2Y2bDVT?=
 =?utf-8?B?WFVuckJoTlo3T0UvZTNKbXJEWXZWcU9xL0wweDZMelZtek1OcEJRaG9pakc5?=
 =?utf-8?B?dExxVEpvTDdJNmIwVE1DQ0FVcVluQUpoODhJT0c1aGFPdDVqemRlUjVqd1JL?=
 =?utf-8?B?cVRPWTdXUVFQVDEzcnNtdGlhbGlhUmJIMkVjYjdWTzJ1YUhRZDRhUUxFTkE2?=
 =?utf-8?B?dDQ5Z0FKVjR4QnB0b2pjZkVFemszTzJwVkZrRS9YNG5CUjVkTk9NWll6cWRB?=
 =?utf-8?B?aUV1QTVwYTVNVDBBQlNmUmxFR1JWZXBMcitjcWd3WWhsVEk4UStVbk85R21s?=
 =?utf-8?B?YmVZTDBScHh6alRlaXRUdk5rYkFuMEEvSldyckYvMEROUmc2SW4vUWdNdUVL?=
 =?utf-8?B?MnBzVHRwRkVOTXNtQXh5QWpJUFF2dmpDd0R4bk1rWDlRckF5T1ovWFd1QlRD?=
 =?utf-8?B?RUZSTlBJTC9vVm9Nb1RsTkU5UUhVU2RNemQyVkF3cjBVOHJrNU0rR0gxWTM1?=
 =?utf-8?Q?4stKhTyyU+QLhWiwjaOePrm3J?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f0bdf18-5d5f-4d3b-5dcc-08dd6811e8fd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 00:47:09.2635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +gJGRK1vcHyVVhcTPCv8xejPozRf1gHyxihog+mlB4ujmvQYdvAeXQsu1GtxzhoY/+k4tqKjPDzJD8zYIJc4fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6009
X-OriginatorOrg: intel.com

On 2025/3/21 01:51, Jason Gunthorpe wrote:
> On Thu, Mar 20, 2025 at 06:47:40AM -0700, Yi Liu wrote:
>> The underlying infrastructure has supported the PASID attach and related
>> enforcement per the requirement of the IOMMU_HWPT_ALLOC_PASID flag. This
>> extends iommufd to support PASID compatible domain requested by userspace.
>>
>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>> ---
>> v9 -> v10: Dropped r-b tag as the uapi description for ALLOC_PASID is modified
>> ---
>>   drivers/iommu/iommufd/device.c       | 4 +++-
>>   drivers/iommu/iommufd/hw_pagetable.c | 7 ++++---
>>   include/uapi/linux/iommufd.h         | 3 +++
>>   3 files changed, 10 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
>> index 54ffef9c17f7..f09dcddf777b 100644
>> --- a/drivers/iommu/iommufd/device.c
>> +++ b/drivers/iommu/iommufd/device.c
>> @@ -973,7 +973,9 @@ iommufd_device_auto_get_domain(struct iommufd_device *idev, ioasid_t pasid,
>>   	}
>>   
>>   	hwpt_paging = iommufd_hwpt_paging_alloc(idev->ictx, ioas, idev, pasid,
>> -						0, immediate_attach, NULL);
>> +						pasid != IOMMU_NO_PASID ?
>> +						    IOMMU_HWPT_ALLOC_PASID : 0,
>> +						immediate_attach, NULL);
> 
> I wonder if there is any point to this since userspace couldn't
> actually just use autodomains and have something work since the RID
> autodomain won't have PASID. I think if userspace wants to use pasid
> it has to manually allocate the HWPT for the RID and then why not also
> allocate for the PASID?
> 
> Anyhow, it doesn't matter much as it is so simple for autodomains..

hmmm. just drop this then. I was just making the PASID path to be on par
with the RID path. Given that RID path is not able to use it with PASID
usage. Dropping it would be better. Then the uapi doc can be

@@ -393,6 +393,9 @@ struct iommu_vfio_ioas {
   *                          Any domain attached to the non-PASID part of the
   *                          device must also be flagged, otherwise 
attaching a
   *                          PASID will blocked.
+ *                          For the user that wants to attach PASID, ioas is
+ *                          not recommended for both the non-PASID part
+ *                          and PASID part of the device.
   *                          If IOMMU does not support PASID it will return
   *                          error (-EOPNOTSUPP).
   */


> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> Jason

-- 
Regards,
Yi Liu
