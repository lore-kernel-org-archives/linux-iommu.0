Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFFB199FCE
	for <iommu@lists.linux.dev>; Wed, 21 Aug 2024 07:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724226623; cv=fail; b=FdpUMqkogtzPIpZwk5//Gd3l7a8DDUd1Bn8eGvFJVKiboG7fwybIhZQujUFnMgQVLxNs4k3bXoYqTR6YTUblHT5GQWwQ8nmUAgvHvywKoo5MssW44yYKxUHcvshwLCSWQnULurScv57VD5mQM3p3BcR4RKuZ6X3ojj3Y2aoxdpY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724226623; c=relaxed/simple;
	bh=2z/ZYAnB+jzUHvUeK1HUVhfpmo+yoSHFkxMFvFjg2pA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XxmVV+VLzd4hkEBUmBadSQ5Xk+Ozw6S4nvYkYes0R4cewJvWIv/B0/kQoEfZnoMckfF3w87w0XJ7F4/HCStPLbsoUAEXeiuzi+bSwx2FfdmoJnruN9l3FVoHMlxySpvKEIHwZZ5BzORCjCg5AiQAlln4y+q6HPw5+uEPCtkMcyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kRhf2cvd; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kRhf2cvd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724226621; x=1755762621;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2z/ZYAnB+jzUHvUeK1HUVhfpmo+yoSHFkxMFvFjg2pA=;
  b=kRhf2cvdL+n7jUVcT4JxIJ+urym1TT8+bFweVBOJFoKG/s4Y/xvvD9TU
   aiQX3widfWXVe57onIojB8aTvpNeQyCp0Nu3I8mWZdEkw5SpgDOB8VOXi
   KhTwHmDSoRS91/zGmj2OjoXZJRbSdSe57Xb2O4Zn+gfCJX5JV7F0Y7FfP
   M8zHqR2CzBMJ+o8SkJOyGGh5LoEDTmjsSKmrJhSGLyaTYAFGcCHKZphtc
   jz4OWoQFlw2unShkm220S89tl8JBIzYOuE0CPcVpUf7pX1p9ZKAApEQ0n
   zUFakvbSH5t6dIqMPdAyKt05vUBqYXL0vRDwSSbvIfHu/GuYVytnrhwnq
   A==;
X-CSE-ConnectionGUID: YkEVVmcWRiGXFgNxse39Ww==
X-CSE-MsgGUID: iTZMQ6elQtiVyIc1KpJERA==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="33989773"
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="33989773"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 00:50:18 -0700
X-CSE-ConnectionGUID: HEZX95JNRG2Vk/hihGOssQ==
X-CSE-MsgGUID: DvY1t35MT3SMCnPMn/04Yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="91760698"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Aug 2024 00:50:15 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 21 Aug 2024 00:50:12 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 21 Aug 2024 00:50:12 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 21 Aug 2024 00:50:12 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 21 Aug 2024 00:50:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L5VpoaSaaUEdgrChQ3gN6S1U2RSe3zm/33cpqhs1LAAB4b2ctCdDCe0yBhaqDgnWvCrL7AwM20JyRx/2iw6FW6T5LFRSWY/ha2ohV8E3QC1pnNGj2FZg5RMjApylq2wqBMG+Pfo++cZtXdZHwGjafxgonoc0mt8xNtlOWCyMtHsslGiRjzQbWlTJph4WW84yg0adw+yvLO+4PhhpCQ4P0QsydJoZleQiisZKdo1SYrSYzPDNjN6Z0gbs4W7XH+VRuVfCR4WIEE5GogoRJ6lapyUq6cGIhN1XENvFRYFSwC/ui5HRw/uQOS278t7Eg04bMLx/+Z9ZDuHztWTVf8OeFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dhgbXU9VF/eFuRKLMd6K6QvqEaNtZPTQEkrEOPXOgv4=;
 b=j8DCzG8Lt4ojeVI0TZ+ePOpoFNcshRlG/0wIwbZqf+6YBAfibh+rCe3/lG4vN2uvYIvNwcbSgcdEWUv310YO/PWRbVoIqcjomZThhv9H5WNN2fConYM8LATkn0LeIpSlBn9ArqzJX4dmxdDUBau16lXbhhbLGTubtLnXeJC9N1uMD0v6gH8N4Bn01xwdvPhKaZ8cihQvKH9AyNIuQXUumtjXofKsvRmdzTfAO/MHZ5JngdmjsMDuCQk7yjFumJ5djf5h9AAwB3lyxHCxOmlsSv+MK40Rvh6lwXgNdIQc4Rtrzk+Dmomj152/D8BPhsUrSTi4rNIscb1C/l8fHDAf0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SA1PR11MB6944.namprd11.prod.outlook.com (2603:10b6:806:2bb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 21 Aug
 2024 07:50:09 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.7875.019; Wed, 21 Aug 2024
 07:50:09 +0000
Message-ID: <dc2a13dd-db8e-45df-9ff9-370ca84b213f@intel.com>
Date: Wed, 21 Aug 2024 15:54:29 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] iommu/vt-d: Unconditionally flush device TLB for
 pasid table updates
To: Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>
CC: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
References: <20240820030208.20020-1-baolu.lu@linux.intel.com>
 <9047e540-a993-473c-9d24-8359cec67b5b@intel.com>
 <f9ee4657-eea5-4a82-8e01-0396948ed755@linux.intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <f9ee4657-eea5-4a82-8e01-0396948ed755@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0031.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::18)
 To DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SA1PR11MB6944:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b0aaf50-7b76-496e-e046-08dcc1b5e122
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UlRVcUh4blpOZkxhNEdNa1ZNV1J0Q0JjRndWMUJIOXprbDRrbHdKYzVMQUVM?=
 =?utf-8?B?eVdjd1FrRC9tZGUxZFhoWVRrTmJuNVZNMDBaamFod2ZoWHQ3Zml2dHg1MHVo?=
 =?utf-8?B?MW9FRzFHYTdMU3ZxM2FIeXFmam9qemVYU0pTazRmS1lFSFNhSlFVdDN0dVNx?=
 =?utf-8?B?YW9FaXU1M2tLcVgyeXVSSzJEaldlZHJGYzhVOUZuTEVwYUIzdVRHaWplS1hY?=
 =?utf-8?B?ZjdtTERQZWFiS1o3Z1FpdzY2QVNtcmRMTTRvaCtBa1lOZ1JycUxSZzhYUC9D?=
 =?utf-8?B?VXUwRjRmcElybVJqM0xsZkpkSUxpSlJueWI0K2o4eXBOMkJxYnlmVmZpZkVD?=
 =?utf-8?B?ZjBOVjg2TTVKQnpudTNHZDVRcVltZUdoaXY1SFN4eWtBWUVGYlFjWFZza3I0?=
 =?utf-8?B?aU1PSUxLZmVIWmlNVWNpYXZ2RTFvclNRc21FYXp5aGZ5eGIrOGZqUWhCRTBI?=
 =?utf-8?B?dk9QbjltVDRpRGNOeGI3ZStyV1prSEY0UGZCNXpnSiswVzVHbHJSWGNWNG8y?=
 =?utf-8?B?Z3U2TmNXUm1RQWlqREpiYURNWnp6VUIrMkFuTEo0QWNyWG9jYzUrbkVhYzhQ?=
 =?utf-8?B?QW5TSjZETThpQXdQd1hJcURkREZRdVNlSW1RbzEvbmIwQzVzelVFV0EwVnMz?=
 =?utf-8?B?ZEtnbVNWYVdRVlVIQU5YVk9oZGs5UWRNODlvUllQVzNRd1FPeWF6aXdGbzdC?=
 =?utf-8?B?aUkrYThOZEt2K2hZOTN5bjRiSERYVVZYUEo4OHVmM0d2NTd4eHE4OHd2VlFS?=
 =?utf-8?B?SFd3N2kyakV6bzVhZEhxN0FyTG9HSW9hQmZuSG9zQy9VcUlXVlkzQ0l6N21P?=
 =?utf-8?B?aDROQUtuN0NtTHBYaXlTSkJJcFVKbXd1ajU5bVBWOVlGT1lDR2NWVENRMmJG?=
 =?utf-8?B?QVlKcW9LOWFHU0VTRlQvVmVjSTZIWitFbjB3cW9wQi9tUTBVK1hJVUN4ZmFk?=
 =?utf-8?B?N2JuMnZXa3NlVDk5KzlCNDBzaGVJQWhTdFI2TXUvUUZZb2dnS3hRUnZITkRm?=
 =?utf-8?B?SlBhTFNYd3JiWlVUcFNqdXJ2bTVyMXE2YWVxQ2RBZ0FQY1l0UWZUMW81a1Z1?=
 =?utf-8?B?ckZOV0dsZEJKQXBGdElZbGRqalRUS1FRRWIrOTdhRnM3bENpTEJMZnFRUnhI?=
 =?utf-8?B?eEIrT1VDWWZmb21BTGZnUzl1SU5wY0lYbGVzY2c0d2llSXJQNXN6ZHV4NUtF?=
 =?utf-8?B?c3B4N0FMVW95ZG05RDkrL3BhajRDUDlRTUE1OXk5UEFIYnBoMExBQ29ESmRE?=
 =?utf-8?B?RlA5bzRCM3VJTG0waDc1dVhVMkZBUTdBY3B2TVNtM3F0MTQwQndnTzBKUVRI?=
 =?utf-8?B?SmtwclRnb2l0aStmZEpCUG9NMGNEUlVFcHlRcFlZVHZHUjZhSWJZTGZnMytk?=
 =?utf-8?B?WUNhSGgvamxZU1lGMHNlZkt5b0dQaTh0WVhYU2NSVEtWTkFGd0NsTm8vUERY?=
 =?utf-8?B?WVFnNDc1Z3E4SzR4UGVFZDJ6bGdvTlJKUVVTUzRCYTc2ODZISUR2Q2g2Zm1T?=
 =?utf-8?B?VlNHa3FEVnFRY3NsR05Rby9XRDF1dnhlR3ZrLzY0SHZ4dWYxRWdpOGxjamJC?=
 =?utf-8?B?NjNhaFo5SktSZEg3NmhXMExGY2RzRU1PYzFra08wUWtyTEV6ejB6K0hQWDR0?=
 =?utf-8?B?ZkdMaGhtcFN3dEJHSkpSdmhQQjNMMmk5QTNhN3kyOXk5RG5GdHo1MnJZQ3Ns?=
 =?utf-8?B?bUxxQ2FFNXV2cW5NRVFuYjNnamNtcTViNHd1K2RxK2pYVnhtb0JiY2FDdDlp?=
 =?utf-8?B?UkJXN1pGN2RDRmtOazlsWjRrZXl3U2NrYWxTb3ViYXJ4b09BR2NUYmt6NHRE?=
 =?utf-8?B?RGwxMlBpTFJ3OGhUQVUxQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGt4R0R1WTdIUU5CVnFWMzZGU3VXV2ZUdzJKbnhoeGdVaGc5bUxoWHpNSlJi?=
 =?utf-8?B?cktvaWxkU09UamY0ZEVMVExscHFjOUV1TGI2L0NRcmo1cnJnU0FrK3EyL2dW?=
 =?utf-8?B?UGNKZmEzeW9wTW1Ta1c2MTc1SmxzdGVKUnFHSVJPWG5iNVV3eXloTUhVcVFs?=
 =?utf-8?B?RTBSR2ZQZFU1R0ZxYVNvNUNjU1VQNGIvZXRpSUhqQlRhaFpZa3FacTVRbjVw?=
 =?utf-8?B?VTVqbmE5WDBuTDN5WXFKZk5XQ2piMG16VUpURTFPY0svZXprSDNDdmIzQzRH?=
 =?utf-8?B?THQ5czRuRWttazFSWTZ1K0JObEV4SlB5by9kS1RDN3FMSnRjdy84VlpTRStN?=
 =?utf-8?B?cTBTR3JOaUt6SUUwZGxMTjE2c2tNYmlmVXlNTVdLbVlaUVcxc1FCV3p1Q2xK?=
 =?utf-8?B?MWhQMEJNQWJCWGgzNWVVL2QyWXVpanZUS0tiOXphcVI1Y3NXNjhtK29JTlVK?=
 =?utf-8?B?UU1IRVc1eVNOVGVWMDR4dVBKWEE3akp6Wk1DdlgweFB3eUVRWGhMdEliUXN1?=
 =?utf-8?B?VTZkMEdqOVNISzdRK1RYcEI1LzkrZ09oai9jY0NNV0FIdDUvdDVvTmYvOTBz?=
 =?utf-8?B?UHFBdWVkSSt4UkhFU2t6Q2xWblRRajF3MG1NSVdDTkZBZHRNQjMwZHdLTDQz?=
 =?utf-8?B?TitFOVYyMjI2MytQLzEvaGRZUytPWU9KdXZTeldCMlNWcWxqRUdnUFFMU2Ny?=
 =?utf-8?B?aEwyVXpFWlovQS9JZXZUWEdZbkRZTVlXeUIwZC9neEtQK3RGNlRSTVRVR3R2?=
 =?utf-8?B?c0lYNytyZUVtSVMyOWlNWTU4YXpqSHBPcUw2L0lSdG1Hem0xei9wUDE4d0p4?=
 =?utf-8?B?OVhGT1B4Z2xWQUsvU3oxMURZK1NwSVNlWGZIMWc3YUdJZmFiY0kvRFhUVUkx?=
 =?utf-8?B?QmtWWlRuNUxNN3VQQXlBNW5HSU4yc0pWUjlPckRWcEw0MjBmREdJS2c1VWQ5?=
 =?utf-8?B?c20xTzVQUDRBSXRldEZsV2FkQzZIZW8xVzVlcGxsWCszRE12RmhpYXY5UnRI?=
 =?utf-8?B?ZWh2NkdrdkczTGhaVUYvdkZYSGxodHF0bzFhU3FoWm9JVmE5alhXbHhFaFZR?=
 =?utf-8?B?aFd1dVF5MzAvVnRNY0pMYmhseWNXc1NITHVaaStaY2N2ZWFsd09JL0pHZ0pH?=
 =?utf-8?B?K1g0NlRrMXFiVFB5OTZkNDlFdUYrSFZuZ0pwbjFCOThQT2RlY0JQR2ZKV0ha?=
 =?utf-8?B?UnR3d0FsdWRpbEpOQmExL3FVV1VyUXdtUEcrcGVocnVqZjdZbitQcGt0OHFM?=
 =?utf-8?B?QjB5WkhCVnNrbENQRDlJTXJmSmdsS0pDZVg0eXB0RmVURHNQVVU4OHhtbTJx?=
 =?utf-8?B?dC85a1NHRE8zQXJ4RnNybXduNDAybmdYTFV4ZXZrcE9RVWl4REovcGRoSk56?=
 =?utf-8?B?Wm1PYkVRY2lSVzNlK3ZsaG5jZXRYdDdHMC9uYmd6UGhCTE93WDBTcDA5eHZi?=
 =?utf-8?B?U3N1ajBDUlJ1L25MMTVsNmRQbFlWbTROTWhpT2lyYm1oUWN0M2FBUDNLdkNF?=
 =?utf-8?B?UTB2WFlsdjJQWkJRRFN1RExncytVeEw1cnE3b0QwZUNabXpTSVVwanhJY1h3?=
 =?utf-8?B?QTEzYzZ3UytqS1FSajM3Nk1QUnYrNWpYOERjVy9CeVl2c0FmU0xxajdKMUpD?=
 =?utf-8?B?VVlFdTFiV0VmNW9JekFWYkxWK2ZPNVVRa1lPczlGNE5MZFBJY1BLL3VMLzNn?=
 =?utf-8?B?Q0VXOHExVHU5ZUJNTmdGNFg0TlVPdFRuYUh3UnpYaG53Q1kybDB0UkZnQmJM?=
 =?utf-8?B?WVhoUWNkdTlxbVd3VFNCTHcyd0VZay9RQUcrblcwMVE1alVGYVFzZldSeXJo?=
 =?utf-8?B?czdRd2kzN0VWQkp0THNud05pUmpxQ2hZL0E1SnF2Y3lyNjg1eDdabEJEODlU?=
 =?utf-8?B?VjRhbTdQUDFVMzlwVjF1MSthWE5maXhjYmliVnpIME8rRGw3bmh4VllLUFcr?=
 =?utf-8?B?cTZucWpWZVBKczNnVFp2dXNjMGdxOGFvNDllNkFEdnFEZjdZWHZQR2hTV0oy?=
 =?utf-8?B?a2tRbkwwaC9vemJWWTdvRnluTTU3bFd5YzMzYUtGUDhXNUpLTEpKcE1QQ2pI?=
 =?utf-8?B?SlN0UDBZanJSTUJyM2NIOUlOWExEcExuZXB5NGRPNllyMFQxRFZDNVRJNjN2?=
 =?utf-8?Q?VfQJ/iP5oKn8JH1/6aO/iPCGL?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b0aaf50-7b76-496e-e046-08dcc1b5e122
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 07:50:09.3141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f8sKxE+I+61MmsUcL9gATTJgGMh/hA03cn7QfzrWcq4sbU7/PtyesBalpKnLndZYROt1oiqID3VggPSD5IaijA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6944
X-OriginatorOrg: intel.com

On 2024/8/20 15:37, Baolu Lu wrote:
> On 2024/8/20 15:09, Yi Liu wrote:
>> On 2024/8/20 11:02, Lu Baolu wrote:
>>> The caching mode of an IOMMU is irrelevant to the behavior of the device
>>> TLB. Previously, commit <304b3bde24b5> ("iommu/vt-d: Remove caching mode
>>> check before device TLB flush") removed this redundant check in the
>>> domain unmap path.
>>>
>>> Checking the caching mode before flushing the device TLB after a pasid
>>> table entry is updated is unnecessary and can lead to inconsistent
>>> behavior.
>>>
>>> Extends this consistency by removing the caching mode check in the pasid
>>> table update path.
>>
>> I'm wondering if a fix tag is needed here. Before this patch, the guest
>> kernel does not issue device TLB invalidation. This may be a problem for
>> the emulated devices that support ATS capability. The cache in device
>> side would be stale. Although some vIOMMU like QEMU virtual VT-d would
>> notify the emulated devices to flush their cache when handling the unmap
>> event. [1]. But this is not required by VT-d spec. So it's possible that
>> other vIOMMU may not do it. So this patch appears to fix an issue, so a fix
>> tag may be necessary. How about your thought?
> 
> It depends on whether this solves any real or potential issues.

What about the rule for it? A real issue should already been reported or
identified to happen even no one complained yet due to no related tests. :)

-- 
Regards,
Yi Liu
