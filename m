Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B00187554
	for <iommu@lists.linux.dev>; Thu, 27 Feb 2025 02:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740623050; cv=fail; b=LKdLztbZwK59NB4QXQWemsNgwnYHU4UbTTN8GE2MH4aCK96mR1F2rS+T3U5nGg0597j6AAWCWU08pmVInCuZG+8mEs6R5hK+rvvY+HpuqGOcAa7Y7TZDKhMDlHAUJNrBNv7FtdzZV1tZ4ZSCClMwrVjjND6acFF6BJulTGq/eyE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740623050; c=relaxed/simple;
	bh=nY8e12fGIkOFiPxm9OLujCtN5pMur3BEIl08PqZPOiM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sZPQtaZ4KWf7lGR9sqras9gIL+Ge+ab9Ni6i1J7Mpbkv5STv27k6Sa4w8HTABV5FziGXoTh90oMvjQsvjcA6b6KrRDAryRPUeu5PpkyFBdkkCTbu+Fw107BfAzmPXN+HmZj6Bz/WoXwIOP0pzkLWRFh24qq8IHIQSauJw+ccZfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZBLUkK0s; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZBLUkK0s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740623047; x=1772159047;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nY8e12fGIkOFiPxm9OLujCtN5pMur3BEIl08PqZPOiM=;
  b=ZBLUkK0slR0ZK1vbaCdaKNV32zIXz4XHxoR5i0n2lcnsmhhkFbpKE4KC
   pv2hLbe2YzHtaOm/daH2nOCYjzhNohcGJzQyBGZFSkZI7l/kxIoFwbpJi
   pcip6R96UaBrHD7P/mIr2IV2kBpIXmL5fekdjLvKtHMp/8GpmRmk2ErcU
   2aw5kiiFDegQLt5CICp6NzwvBfG4VvTTzq/NBCBveb/4uW+XzLxFJgS9Q
   gB/of4HVMSoV4tU39nqPqCTy+QmErnFN4r74c8y2tfzhgYzxzQaPvPg+T
   q1p3mcblMrOMKEIYxqlB2PFx+foOkvX5sGrg9Xs2ZQCOtim9RodwBG1dD
   A==;
X-CSE-ConnectionGUID: HsHVVVILR8eljMQ7GVpbxg==
X-CSE-MsgGUID: EC4xBlhnQ9+rDPusYEBdFw==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="41629140"
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="41629140"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 18:24:07 -0800
X-CSE-ConnectionGUID: dadClcaMR2S75nuwr9gVjw==
X-CSE-MsgGUID: FLSQ/NHtRS2jD++767+jfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="147709834"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Feb 2025 18:24:06 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 26 Feb 2025 18:24:06 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 26 Feb 2025 18:24:06 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 26 Feb 2025 18:24:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jx3Y5Dzyldr5Z4V9UtKjRRKu7ZXI3AVHb+m5eFxEuEoQN4W/Sspf4jBbxdbYtZmQw31FPC3EwT4HgY6M0jqQpG5qS4ZhugJZ9ncp+ulnX7a60ig/UKXtPnQuSWt0GpnhDOdxWuO5EYrhTa2BmIVYRNQ5jZv5yv+eCVv9XkVS13FvJ8PRfKNihphkwCfu2/qBsKq0GnS7vHfvT8kZRyQlX3iev7GBHWzdSUAx6LcAXdOlyzJ2CtSLVQ7eGshZ81cYMVeto/pqNfspLQVFJ8YV7s1Emc+kujZFUHN5IO867Gl592i81fkoG57OZgzO+QaZfIBfWYfastTuTv2zA32cAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iD5TuwWk48hsUIupCbY0yHVkgNA742+ql67sUMFlRUw=;
 b=KPWpNglrM2W7gKcemaRq3ZgHGVn/vyGG24GuAGB+PeAH+DTIaKeZzxkrnN3A4ihAFkwHXjGcdW/TJhghWN7ziFHQp6QVAXzM4NRrp7b1NfHd9lXiUseu+66ar3zHKpn0P/eRsLgsHIKY8oDWsT72APtHWsgFNZthAhPA6wSDTUclL4tgygqEq2pNiOHfrw6Mqoja0h7JXBw3sPxFQGVgnAcsvMAfOHtB2a7Js6cKY14Fe3bVz0qdZT9QPdYMwXX6ZTkmgXUD3jj1T2hQEWLDmv+CD+88yUBx/FRwkH1D3aGZZhPaPzSuEkHvSpVPP1GhJ5L4fPoCBI2Yqs2cNNdqWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SN7PR11MB6654.namprd11.prod.outlook.com (2603:10b6:806:262::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Thu, 27 Feb
 2025 02:23:46 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.8466.016; Thu, 27 Feb 2025
 02:23:46 +0000
Message-ID: <5809773e-bcb3-42f1-ae0c-e509c589f9c8@intel.com>
Date: Thu, 27 Feb 2025 10:29:11 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 02/12] iommu: Introduce a replace API for device pasid
To: Baolu Lu <baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
	<jgg@nvidia.com>
CC: <joro@8bytes.org>, <iommu@lists.linux.dev>, <nicolinc@nvidia.com>
References: <20250226114032.4591-1-yi.l.liu@intel.com>
 <20250226114032.4591-3-yi.l.liu@intel.com>
 <5c2d63d1-78ee-4466-9574-a6e4a2da8ee4@linux.intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <5c2d63d1-78ee-4466-9574-a6e4a2da8ee4@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0042.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::23) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SN7PR11MB6654:EE_
X-MS-Office365-Filtering-Correlation-Id: c9b45fc8-e1d1-4cfa-f17d-08dd56d5c34f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SHUwRG9tVFFSMlNNUFRMYnJIT2ZQckM2NCs0STNDRStDT1M4MzlWTGUzUXJE?=
 =?utf-8?B?V3ZlWjNzTnV3UWJVcUdmenVyL2hlVklrY2M3ci9iMWwwcm5vRDczejJOaWRp?=
 =?utf-8?B?VzBncld6NnU2VkFOdENSOHJVMk96eGRSbTQ2Z0NYRjl4dUUwcVBvWWE1ZTEv?=
 =?utf-8?B?WldobnFZMXRJeWtyWmV2Mmc0Zld0TGhhSDNRb2RnMlRia1JCTlVLZU00bDJH?=
 =?utf-8?B?WUxtNEc5UEl1ZS91d0FNMkNNUU0wajNaZnZPYjNDVnFLdlBKeWFrVE1qbk5K?=
 =?utf-8?B?SUNyNTVlSHZBN1kvOVkzWlpjWTAvckt0WnA0QW41RGlqMjlUVkJJaW9QTG1K?=
 =?utf-8?B?UXJETDNaQkh5M0VGQkk4RW5oUkpFYzVCTXU1ODZPeHcyTjNlSVNEalc3Umts?=
 =?utf-8?B?YzFuNXM0bkYrbEVOQ3hDMCtadStyUFN2NkFvVzhUaE8zdDFvNk5NbTlDa0FH?=
 =?utf-8?B?T0IyVUhZZGs0dTJNRExna0hSdXFrR0NHRmNza251M2x4eDhPdVNTdGp0SURu?=
 =?utf-8?B?MXBzZ0syU0ZNeVBXVmp1SEEwdDRmcUFKTmwxSTk5eUlsd3Y4akgreGlZYWlh?=
 =?utf-8?B?YzRwZlNhQ1NuVmZFeTlDYVFqMnd4dW5IQ3lURWw5RFVSTWx0Riswb1RhQlh2?=
 =?utf-8?B?aG9PWTdmciswWjArVVBNd2lFcTBNV2lWZ0IxeGRKZ3ZKM2VLYllIUXR3VE92?=
 =?utf-8?B?ODR6NjdBM3Z2aFRjTGZxb3E2NzNTMFE0OGxDUWEvK0hTNkZVS0pDOFlrREdm?=
 =?utf-8?B?WVpyRUExZVk2UjdJbkswUXAwRG13MTQxRy9RQWRoeWQ2eGtoaUJFTFlHSVVY?=
 =?utf-8?B?VjdoOEVaV3h0c0hRamtheDZuQUFISE1PeWlYaVQ4NGxqVnJkMTFBQ3ZXbGla?=
 =?utf-8?B?ZzE2aW9pUmtoTVRZRmFyM25SaVpCTTFDb2VhQTV1eE9HRHBObEhxSUdYaVVv?=
 =?utf-8?B?TWxweHpwZGlxd3A3UWl5OUU5YUZIQUt1Skh2enJ1OHBLRGRUNmhkMzZ4elg4?=
 =?utf-8?B?UmhJbVpzeGU4YmlHNWRuOVJiL0JaSTlpanpDaG94L0FEY3BEaGpiVjM2dW5G?=
 =?utf-8?B?V2VDdHRsVjFFRjl3dmJzYUptSnVTK09zdHJyeWRZdjRyeHBBS3ZEZ09qT0V5?=
 =?utf-8?B?V0YyOFlKUVFSckRaVFY3RmhrRXNPNWpYVHJHajdLeENjQk9JYzZYZERLbFFG?=
 =?utf-8?B?eXNUR3AycEk1Qk1MU1dORG95cm5tak0raXhoQlg2VmJZRW9UNVE4dkhZRmFF?=
 =?utf-8?B?VURORDA0ZGJGZkpRWTB4UlAvUHArMTZQdEtoWngxcVhCdFkxRlhla0tZMXdQ?=
 =?utf-8?B?eWtyUFVjTTkxRHlBZGttRTBhNUR2K2s5K2F1OWV5Ujh2YXNXclhMRjJvSUY1?=
 =?utf-8?B?cUdOdStVTW5TMjBsODBjNG9PeUVEYW9IdzBoQ211UmZmREFzUE9jeVpNWUx0?=
 =?utf-8?B?ZzBabkwrbTJFNy8yTFhPZyttOXRoTEVRSkpnMTdpSU9lcUFZeXJhaUQ1bk1s?=
 =?utf-8?B?QW1jejRvQk1BM2JzWkZ3cnFpU1k1a2oreVRXTUwzczhvSm80aTdpQkNycHNV?=
 =?utf-8?B?NnQ2b2RpVnluNHZMU3hwblNjT1MvSTBZRE1hS2lkMlFVUEFQZm1jaG9QazBP?=
 =?utf-8?B?OW04THZOV3c2NTEreTE0Q3pLOWozaEwxeFk1b0grZkIrZGROdTN3ODUvVWxW?=
 =?utf-8?Q?RhPw5AdKVFc+tsi+TRp/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUdTT1VDTGhUUW1FeERSM0hsb3gzKzhCZHFtZ0pEdkhkRFJDWHFhTGwzR3dC?=
 =?utf-8?B?d0hyU1pJL2toUFdRMExoU29LM09MTHhCZklXSGRvYjUyRG9HK00zRDcrL210?=
 =?utf-8?B?QWZDU01jSzc4K3JxRUNhUmFBTk5oVHBzNi9nendzRnRYYnorZXNwOEVUMmlS?=
 =?utf-8?B?R0JsTkNuaFdzTGgzaDJCNlIrN2tFOXZ5bUNRaStBOUVFRUw1YjdBWDVmaE8z?=
 =?utf-8?B?SnRkcFV1L3J2SFVzb3F2eG9pMWNmWko3eWdENXZ2ZzExTXZ4YjltRVg4Wktq?=
 =?utf-8?B?azNGRmkrSXBsZWZ1Q3U4RlFkb3YxY3lrV085K3Fwc3BCNjZ3V3ZDeTYwaytm?=
 =?utf-8?B?cXhSTHZqMTN6S0UyTVF4bnJzOVFsWCtKWi9MekNER1RBanZ2emlXR21RRXpu?=
 =?utf-8?B?cFVGdkxxeUZRakdLM3RvTDB6RjZ1aTJnSmNxSVRLY0NkT0ZhbFJhamYwU2Y3?=
 =?utf-8?B?RDdmb2RMZ2M5Rk1CNU9sVlNFZVNSQnF4UVBRbTRmWWFQSkZBU3JPSURRQ1Jo?=
 =?utf-8?B?WWRBbWpMZk9XN1l1VjEydWdXU0g0UnlJd2lvOTNvc050N3d0MmJjemNXZGVV?=
 =?utf-8?B?VTJkcVRNdDBqQ2cvVWdQMWJ4R1dZMkFGdVpmeUZTeElOWkNPT0F3Sy9rbnU5?=
 =?utf-8?B?UjUxQ0lEc3Q4SzFNV2dvZDAxTEdzUHpVVkJTVFI1eEo5VGVCZ0x4RW44VW1o?=
 =?utf-8?B?dGJwcXNuaDF2SFFoY1BTUDFtSzNuYmd3RjlwOVBRYXJLc2JlQmdwSVhtSFAy?=
 =?utf-8?B?dStNOXhSUW9GYW82TEI4VW41RGhlZGpyVGVPcFZ2Q0xEV0JFVGcyUzhHUU9P?=
 =?utf-8?B?cXk5Y0pFUUd2M290ZTI4QzZCUHAzV1U0Sm5TSksyeTczcGFpTXp5Z1hzUlFj?=
 =?utf-8?B?RDhDak1XZFdMUVJGV1BOb1EzamxCQkZYM2tUYm9oL3g1YTl2NFZ1Ykx6dmhW?=
 =?utf-8?B?bjlqWnF4WXpHa1NxR0ttYWk4NHlaR1hHaFNkT09aT0NweGZUQU56eDhSVHI0?=
 =?utf-8?B?TllUR1dPc1FsZDdmTzhBUzMxNHRuZlRtYS9ac1lZYlpEQyt1Q0JORytSZDZL?=
 =?utf-8?B?T1h2aFJoSEx2SHlwOGowT0haNkREeWVIUHhqSzdqRk9tSVFKbnNLSVhialNS?=
 =?utf-8?B?NzgyVHFoem5vdllVRGVsS1dFVG9jeU50UG8xYzN1aWR6MjJoODJiOGoyNGI5?=
 =?utf-8?B?bGpqbUFIV3BJZDE4SEowSXBHc2FjNCsrNDFYVFpoR2hkS3l3TEJ3ellyTkxZ?=
 =?utf-8?B?OTU4WWEwdU9FMmNlcW9lZGNlUTNnYjVpYkhBdmNvdG1yOWVaYitSeHNYa09I?=
 =?utf-8?B?YngzRGJLZXhrb2lHZ0k1ZjdJQ2ZLM1M4Qit4OFpDZlJ0QitxQmdUTEFZS2l5?=
 =?utf-8?B?QUkweDNqY0RZamtSbm1SWk94amNvMFR2UDVUNTBIZ2xyaU1uZDU1R0lUTFY2?=
 =?utf-8?B?VUZxeTlTdlozMGpnakVwTjdlc0lWaklic2Y1RXFwbmlobVlLOXJMUy9oRWdl?=
 =?utf-8?B?MCszbXJuSklXdjVCaHdGV0dXQXNmMUI4aEJsa2thUXM4VXdIcHpObHRscUZl?=
 =?utf-8?B?MUZLNzFOcnpJTkVabFZ6MXEwdG5uNTdqUnloR1FHQXNZVHFXWDlLbENpWEt1?=
 =?utf-8?B?SEROMFhQcUIvQ1hGVksxRVJJT1FNOUpJMVRQUEFQcDlJc1FYeTk3WHRlM3Vy?=
 =?utf-8?B?cVU2eVJDcTRQWFZ6NUxYWE42TDBpQi8ySkRoUktxVHU1alpWRWViNzlCYlpB?=
 =?utf-8?B?WXlYZ1djL2NxcVpYQ3lZM2R6b2RUR2o5aVVKM0xmc3RXMzg4K2d5YzFHUllr?=
 =?utf-8?B?UE9BNENGUzRzRGtaRHEvdktheWtkNVV0L0tUSVRuSVJEMFlTSDFyK044RVh2?=
 =?utf-8?B?OWZ4ZXlHdXhWRFB6cUhsSVk1NGplOThGamcvZW5jUStKVmhud0NwUTk5ZUor?=
 =?utf-8?B?VHZ2MkFydXF5KzRoaE43bDhQNmNLZlJuQ0VVOWFoYk9STmhFNW42WElTNWVq?=
 =?utf-8?B?MXNPK3pvQ0w2ZGVBdkZzYjNWQjlUbHBnMEFkM3NpOGRQb2pXUzhzNDJDTHlF?=
 =?utf-8?B?ZmY4cm5ybU9BVHhwK1R3ejZsSjkwVEpqMCtBM3Z4M3RPOVRlMG9ZZm9xbFJE?=
 =?utf-8?Q?e45TYWFvRkaE0BtlNSK1CdEnj?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c9b45fc8-e1d1-4cfa-f17d-08dd56d5c34f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 02:23:46.4220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wyvcIYURC6peBehqlylcE9n7Umy+0UzjMcKk6qFg+f2DTieDS2cX2DRjKSs5eWo8KnzPLNvWd9eBBIHTlkWigA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6654
X-OriginatorOrg: intel.com

On 2025/2/27 09:31, Baolu Lu wrote:
> On 2/26/25 19:40, Yi Liu wrote:
>> +/**
>> + * iommu_replace_device_pasid_handle - Replace the domain that a pasid
>> + *                                     is attached to
>> + * @domain: the new iommu domain
>> + * @dev: the attached device.
>> + * @pasid: the pasid of the device.
>> + * @handle: the attach handle.
>> + *
>> + * This API allows the pasid to switch domains. The @pasid should have been
>> + * attached. Otherwise, this fails.
>> + * The pasid will keep the old configuration if replacement failed.
>> + * Return 0 on success, or an error.
>> + */
>> +int iommu_replace_device_pasid_handle(struct iommu_domain *domain,
>> +                      struct device *dev, ioasid_t pasid,
>> +                      struct iommu_attach_handle *handle)
>> +{
>> +    /* Caller must be a probed driver on dev */
>> +    struct iommu_group *group = dev->iommu_group;
>> +    struct iommu_attach_handle *entry;
>> +    struct iommu_domain *curr_domain;
>> +    void *curr;
>> +    int ret;
>> +
>> +    if (!group)
>> +        return -ENODEV;
>> +
>> +    if (!domain->ops->set_dev_pasid)
>> +        return -EOPNOTSUPP;
>> +
>> +    if (dev_iommu_ops(dev) != domain->owner ||
>> +        pasid == IOMMU_NO_PASID || !handle)
>> +        return -EINVAL;
>> +
>> +    mutex_lock(&group->mutex);
>> +    entry = iommu_make_pasid_array_entry(domain, handle);
>> +    curr = xa_cmpxchg(&group->pasid_array, pasid, NULL,
>> +              XA_ZERO_ENTRY, GFP_KERNEL);
>> +    if (xa_is_err(curr)) {
>> +        ret = xa_err(curr);
>> +        goto out_unlock;
>> +    }
>> +
>> +    /* Not a replace case */
>> +    if (!curr) {
>> +        xa_release(&group->pasid_array, pasid);
>> +        ret = -EINVAL;
>> +        goto out_unlock;
>> +    }
>> +
>> +    curr_domain = pasid_array_entry_to_domain(curr);
>> +    ret = 0;
>> +
>> +    if (curr_domain != domain) {
>> +        ret = __iommu_set_group_pasid(domain, group,
>> +                          pasid, curr_domain);
>> +        if (ret)
>> +            goto out_unlock;
>> +    }
>> +
>> +    if (curr != entry) {
>> +        /*
>> +         * The above xa_cmpxchg() reserved the memory, and the
>> +         * group->mutex is held, this cannot fail.
>> +         */
>> +        WARN_ON(xa_is_err(xa_store(&group->pasid_array,
>> +                       pasid, entry, GFP_KERNEL)));
>> +    }
>> +
>> +out_unlock:
>> +    mutex_unlock(&group->mutex);
>> +    return ret;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(iommu_replace_device_pasid_handle, 
>> "IOMMUFD_INTERNAL");
> 
> Perhaps you can compact your code with guard(muext). Something like
> below:
> 
>          guard(mutex)(&group->mutex);

this is interesting.

>          entry = iommu_make_pasid_array_entry(domain, handle);
>          curr = xa_cmpxchg(&group->pasid_array, pasid, NULL,
>                            XA_ZERO_ENTRY, GFP_KERNEL);
>          if (xa_is_err(curr))
>                  return xa_err(curr);
> 
>          /* Not a replace case */
>          if (!curr) {
>                  xa_release(&group->pasid_array, pasid);
>                  return -EINVAL;
>          }
> 
>          curr_domain = pasid_array_entry_to_domain(curr);
>          if (curr_domain == domain)
>                  return 0;

even if domains are the same, we cannot assume the handles are the same. If
not the same, we still need to update the xa_array. Otherwise, UAF of the
old handle may occur although I don't think current caller does it. Or if
no old handle, handle needs to be stored.

>          ret = __iommu_set_group_pasid(domain, group, pasid, curr_domain);
>          if (ret)
>                  return ret;
> 
>          /*
>           * The above xa_cmpxchg() reserved the memory, and the
>           * group->mutex is held, this cannot fail.
>           */
>          WARN_ON(xa_is_err(xa_store(&group->pasid_array, pasid, entry, 
> GFP_KERNEL)));
> 
>          return 0;


-- 
Regards,
Yi Liu
