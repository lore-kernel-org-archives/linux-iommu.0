Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA0E86352
	for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 23:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742514395; cv=fail; b=aPv0FWXkU59Hciv8BabpNNQtOf59GTag/qCE2lRo6yRDOOLuBxIchmDteEVbb8P7UbVV3Fc036Z5APbHYph9RIRJgHAHZc/ltKfQ+z9E8ERYpI4ZDtYyrtVOHDOxBW4RTFWh0iLLpfMgI7SSiZl33EO5OQ5t+GfbbJdt8TqifyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742514395; c=relaxed/simple;
	bh=MmGh9lMq9tVXWsyvFB14ToiboVDpZ5JrZW9s+nC5Zh8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CjKVlvyuo98oTwAunaM8NnjBSrflbZGXZyF9OBBwE7luQvfT13zk3yHe/0d26osdnvXuOC9jFJwbYeU1NLbh+epjn1KTYiHrY0x6yXWjkRQA/3FSGLpHo0lnv6+ZjShJHZsnR/SJov3IsQ2SrUtqn+OJeq9xKAIqGPGnZxharhM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DQtL4yQC; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DQtL4yQC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742514392; x=1774050392;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MmGh9lMq9tVXWsyvFB14ToiboVDpZ5JrZW9s+nC5Zh8=;
  b=DQtL4yQC1d/ovb1cgEDpQ+B6F/68deFrBoBBnzGG9Ysu+a8WAvKlva4g
   J3FA7uHsCBBrktVRXV93y7huQ+THY+h8y/Jet7qp6wkrekvrXizG0W9Qi
   G2n1qXsfbNvysVole0zA2wjYBo7UksyprYxyfsvMAOvc70JMbGX7Fl1+S
   3hFOJtS0PwpFdPoAkcAZF+VoFlPTTTdVNydJ4Dda29ho1ly73Qf7CQV3y
   0XEsk8SfhzHGgwPbTxYpQzR15M9A9NgDHKQPXvx7loWd7psjjTN200jAs
   //7q/nTV1L26/2CW8V4fKVrhFeL/IvYHmAauyI6NtDGMyqbZGBncExFqC
   g==;
X-CSE-ConnectionGUID: g9te8ahkTIK7+OXcO5iCxw==
X-CSE-MsgGUID: a1ecPELRQ7Sx3s1Adl5Y5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="43958953"
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="43958953"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 16:46:32 -0700
X-CSE-ConnectionGUID: YU4E+eESSzSuVyhwJtUz6Q==
X-CSE-MsgGUID: slhLtL0QRAiZqfYxG3CQDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="123265681"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Mar 2025 16:46:31 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 20 Mar 2025 16:46:31 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 20 Mar 2025 16:46:31 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 20 Mar 2025 16:46:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dRPvyuCCsbm7lAzna9//A/4HSCvff7axZvoMLOfRvI3A2sgTRZC4FuRihqQYo9mjwSH/wB2zsYU20hhG+DZUxI0l+LGahUdQSzhHZPRf1L6fN7JLs61uc3xClZatURjIJ5P1lX+biC4oKR0wkov32IWXCReHqMYNKqmk+Lhhf/HDCHWI3jEQnha9mIafbSKZA3cj2ORHa6QXV2k8B6wal3EVImFJS+a0L/xtMpQgvekrta/7ARQOonuePeA01p6n1nMd0EtahSxxxV3e9wlV8AZ/LThW+9mp/e4iWvdOFsa8g8/t5SfOlTQNPkKBTmpgJw8/VdRwry7OeuxfpsOiJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JmpHnLdK5NZyfCkCn/Ks70/bl3zppsLcVRgGgjFFmSg=;
 b=itoh9avneGgyWUo5TnxoFab2Bh0WrVsq51KHGbh9C15lzQtc+901cXrW02tBQYkE1lhC/CIBmjIHsrnGTQaJzYCQXYsp1ai3e0vwNwv8PrjYQDf/bzPIHOJETAIQd1npUdnLsK5uQIAdRN0pXNRtY1Sjhk7SUqSNB7jp2euluosOtmuoBnop5L3f01HroVgiMXieR/Z0eYafOVcdTzmnxlDCBAD11TJEb2xFb79+8ozIcRbIZdPMdyuer0kfST7MwQNSld3oX1ODIHF5rQzlgYpEq8a1Nbaab0oUWgQlDf3qAPKuc599Nf+sK389gpbTe33nnXrwzS9Yp7e5vA9FmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by PH7PR11MB7148.namprd11.prod.outlook.com (2603:10b6:510:1ef::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 23:46:27 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.8534.031; Thu, 20 Mar 2025
 23:46:27 +0000
Message-ID: <b17b7ea1-6869-49a2-9233-455b27100fa5@intel.com>
Date: Fri, 21 Mar 2025 07:51:54 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 01/18] iommu: Require passing new handles to APIs
 supporting handle
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <joro@8bytes.org>, <baolu.lu@linux.intel.com>,
	<iommu@lists.linux.dev>, <nicolinc@nvidia.com>
References: <20250320134744.5777-1-yi.l.liu@intel.com>
 <20250320134744.5777-2-yi.l.liu@intel.com> <20250320152353.GY9311@nvidia.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20250320152353.GY9311@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR01CA0011.apcprd01.prod.exchangelabs.com
 (2603:1096:820::23) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|PH7PR11MB7148:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fcbbbdc-7aec-4899-5dc8-08dd68096e66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YW1GWkpCVXhKVmNpUFhuR1pSZ2M2eTIzTjlwWXU2WGtyVyttVHgwWDN6L1JO?=
 =?utf-8?B?TDZlVEU4ak0vRlJDMmZqQis2NUg4UnduV0syUytzalI4ZGtUV3h1V1BVUWww?=
 =?utf-8?B?Q3VTWm5ZMiswR3YvNTl3VitEVGhNSHpUcUsyOXNjR29SdWZVMFZGb3ZWZ3E5?=
 =?utf-8?B?NGRjS0RMd2kyb2dleFJzWk1lUVQ3TkU5T2xrbkZzeG5qUnVseEtPRHdDdmcv?=
 =?utf-8?B?dkx6Z2d4VWpsZ2NsY29nYnhkY3MxNnJ2cEQyOVMrSUtpdUdydGxNMUZ3YUJ1?=
 =?utf-8?B?cWlmM0RSTkt6ZFFiZHB6TXI1Y3JHZFlXcVE3VzlBM0ovSE9nUE9ZdEpPbUlk?=
 =?utf-8?B?Y1lZWDFDUFNNQ2tpYjV3TEdrUzUzdDlzZ09TZURGS0RsODZGdldRWWRxRmNX?=
 =?utf-8?B?U3RTQzVIY2ZnOEs0NEUrbE91MHZVWHl2R2hYeDZVa3N3cmV3QXZFL0lRTlVM?=
 =?utf-8?B?eU5VajdZNCt1V2JDRVB1Mmc3ZnVXb29sbUd1QmxIV05ZbHhxV3dtaHpsNUhQ?=
 =?utf-8?B?VStjZUpaYmNFaFdzMEdob0lDd0ovblJvRThMU0RRR05kY1pLSC8wUDZEM3Vp?=
 =?utf-8?B?cmFHMnd0NTN3ZU1ZY0wxd3o3bjI4SmVpL1VSVjNQaDhNNXVxeENQSUdrMzdT?=
 =?utf-8?B?ckJOQk1Rd2NobFBaWHByZDROcXlqbXgrOUc1d3VMUTVJS2hHc1Z5Tm5IZGRs?=
 =?utf-8?B?ZW9JdFkvaEpLejdtQ3RuMGVZU1hDcEtXMVFXYjNmRk9kM1ZyaDJkQzFNcmN0?=
 =?utf-8?B?VnZHeGR0ZmxBamtsUXlxdHh2VUFCcUU3SzdhM3BXdE9LS0UyMHFSeTJ6NFpL?=
 =?utf-8?B?K1kxU3lET0JSUU5VNXpxL1dZZ2xyZ1ZNL1JMRkFWVDNNb2RBcmpJWFpZRml3?=
 =?utf-8?B?M0RCck9KZHRyZElyQm9MYy9vbWp5MFcvdGlBYzVZUDNTVlEvUnZrQUhyalQv?=
 =?utf-8?B?OUZwVjBWZFA3Mks2OWxWeGxlQ3hpSHJhTDhqK3Z6TUJ4b28xdGw2bjh2SGNm?=
 =?utf-8?B?bFg4ekZRYlk5Slpjb0hnZThSQ29Fc3REQUljVEhRSFA3SVB6Q2JTTEg2ZGdo?=
 =?utf-8?B?ZkQ3YjEyd29jZXBRbGpMTkZ1cHZ6dzRHL1JScUlBRXFZclZxMUpQTWJpUGR0?=
 =?utf-8?B?Vjg4Zk5mQlp2NVFaYjVGcmQ2TlFLb2kvK3hwL001eEZkQjFnZTZ4RzJNRFpH?=
 =?utf-8?B?YjB3dWRETVlWelE0aHNxMmdQY1VmL3I3a092SVYwdzBqbkljc1ZHcEFpMi9o?=
 =?utf-8?B?WTNHNXpncW9OQmpoL3N4SUVXMDVqL3hIL0x4NUZPRlU5RklNQ0wvditvSThZ?=
 =?utf-8?B?T3B5ZGxmcFo5WktBNjlWbkp2WkFhOVhnZE1LN3B2QXVaRTJOV09DaGl5THdz?=
 =?utf-8?B?NEZWTU9TV3lVK2NYUktESHBYU1Uzdko3emhYaW5SMXd0c1dqWjE4bWFIWXlM?=
 =?utf-8?B?MmdNTWlOcitPV1dmd0ZWUGUrbEJvUFJOWmNrY05QbGc2VzV5Y0lRVzA3cnFQ?=
 =?utf-8?B?SStINHgxTEQvRFpGMHpxU2Y3QnU4YjZNckpoOU5Odk14UWJVTVowQmR2V1lw?=
 =?utf-8?B?RW9nUU1Ib0U5UVJLNFRTNDYzRkw4MS9tVmh2RWM0RU1XR1padHpLMjJaQkhD?=
 =?utf-8?B?NTRHOHVqNmpnc2ZXcVFIZk4vYm5ZZEk4V3FhcFJPMXNKZnJkTDM5eWFkTUt2?=
 =?utf-8?B?ZzBiV0NkRmZTVTRLWU5EMlRGTE02NllwdHVrTEFNWkFUNzRlMTZFNXpaS08y?=
 =?utf-8?B?T2VoMk1wcWxxNmhqQ0ZmYUxZRGRQYzJhbDFvZkhpMkc3Mk1kUXRxNzRyT1VV?=
 =?utf-8?B?MWNXWnRMZ1RJUTFKZ2VYYjNFNDVOOXBhQUN6alNSRHpmclFqWkVCRGxPU0xi?=
 =?utf-8?Q?Ha4yuURSmDNC5?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVJtaUlhaFgvOUJWT29GMGU5OWgxdC81c3ppelNZTm5mNGcxR1h3dElZdW11?=
 =?utf-8?B?Z0o1QlpRbGlwbTJCeWVHaXhQeDhnS3RZc1JQZTdiTjdyK3hoUEFtNzFUN3h3?=
 =?utf-8?B?UTAzelpwSWdjZ0xscTd5R1FEUTZ5cEdjejRxVm5GZDBTSXFKNUFCNTBwRzFQ?=
 =?utf-8?B?RnBGbkFFSWxrTjRBZnpwcnppUk9rMTd1a2lXbjdjeTdtZzlGYURwMHpPODZt?=
 =?utf-8?B?cXRZWmoveWFQQ0YyYXVXZHVYWVpLWVZKNUFjR2Y3bEhUU1ZIcDdOUHJNai8w?=
 =?utf-8?B?eEkrOUw5SnpDWGVLbFA2cHgwck9nMmJFb0RDVDZ0eHJQdmlmSmRsYTc0K0Rp?=
 =?utf-8?B?UDJqVjczcFBTSzdxSmtIbW9pN0JxaGlzSkJVbitxVThZcjV2SEUrbHpLWWRG?=
 =?utf-8?B?Q0pNMW56TnZCczVEc0pDZFdWeUdDOEU4bm1PWStGVUJvNGdISk5ZR3gxY1JF?=
 =?utf-8?B?WFpyem9wVjBURENxTXlzcVZsZ3FCcFQ1OGh1REQwc0hZNVB3TXZHM0QxZzhF?=
 =?utf-8?B?QVRjRWVYc2YwNlprdlczUnFMVlkyb2Z5VVdyeVlsVzIyd3c0UFE3STVPN1J1?=
 =?utf-8?B?TVZvcGYzdldxVEd4cVpwQ2luUW15NGc2bXNmZm1KTCtFS3ZnTE44QVZIVDh4?=
 =?utf-8?B?OGVucGNQVit4dE1oWUprdmovUE9rSTFUUFJWQVdiUThFQ1BZWEpmOWF2OGlG?=
 =?utf-8?B?ZHpOaDVPZ1dMNnpuY21HOUhQakxuTjloS0RKU0drSVF1dEdFaWUxVWQzS1pu?=
 =?utf-8?B?bDBocERtSWdxMlhJZGNRM0piWjU5cCsraDU3UHJSMnpzQmxsczQ1NDJBRUZS?=
 =?utf-8?B?UWJCQXVTVW00NEZjMStyWWVIZ1o4eEU3bkFnUVJOOThVeGo0WDl5dGliNDZK?=
 =?utf-8?B?UXF3TkZ2RWQyU2lEUUgyblNDOU05QUdqZmhUczdzRmRSMTV6Ykg3TU05QlJO?=
 =?utf-8?B?UERSQ1ZhSEgyQmRvckxpOHNZenVMN1RNUHRjdkc0QWdPczR2YWpvNFg1MEYw?=
 =?utf-8?B?aEZIdGFDVEdrMm9YaDg5ZUpkYW5TaGFwRGRuOVhVd3RCN2J4Wlp6L0pRTWli?=
 =?utf-8?B?TFk1d0hrWTFFbE5kOUxWRWFVK1BpaWpUTjRaUnlKZ1lORE9IRmdxWStNNDBZ?=
 =?utf-8?B?OEozUXBNUVVhb1lWbS8yd3VnYUFjd2oramdJNlhDdlh5aGdKZFhvQ3lhMXR0?=
 =?utf-8?B?clJOOS9IazVtMTRscVVsZXRHRTBkeElaSmVXRTBiVWtwK0hjVERXdUtSNjho?=
 =?utf-8?B?VXNJd1A1RnJySnh1cGF6Umx4dEdjQWJzbmhROUdqdVl4dTkzMmhUWkZEZk1N?=
 =?utf-8?B?Y3RZVnJETDBoVDRvVnhXbWVCN3Jhb0JJQXNMcGJJejdqNC9kU2swblVGMzdU?=
 =?utf-8?B?dDNLYm9pMmVMc3ZpWDRoN1BPbHVqUFlwUXc5NkU0NHVSVWxXMzRISmU4S3B3?=
 =?utf-8?B?a3VkTlVVSXd3TkxnRDZhRnhYWUxuQWFicm1mUmJhZWFxd1RoRGxOdk5ld25L?=
 =?utf-8?B?YlNpVVFwZGdXSll3dHpwN0RtNDJyMlF4cVoxMmdwMWdKQUJLeVpTMzJIQW51?=
 =?utf-8?B?NmsvZXFyK1ZqdGcrMTZDbENCTXVMTXpjRmF6VTR3MkR5TzVBSDJkckdzbFhE?=
 =?utf-8?B?MFRtR1daWituTVAyN0IzWEVpUEd3UlI4QlpjYlg1Z0RNT0lUdVBPWERvYy9J?=
 =?utf-8?B?Mm9sMGxDZmpublhNQjJsYldPY0orWStHSmp6YTVIYzd1ejJGREgvV1BnOXk2?=
 =?utf-8?B?WllqZGRHKys2cHdNcTUxdEtXUTE5U0MyVzFqYjI4aDdxWlRlem1WZkplbGtZ?=
 =?utf-8?B?TFd1amFRbTVGMlFXSU5pa3hMemNTM3FZL2FFWEpMRXJNU3BzOFI1V3FFM1Ar?=
 =?utf-8?B?SnJ6d245bDRKUGlrMzJ3TmtaTGNaZDBTcVFBTzdjdWdHNktaclZrcmVKOFIx?=
 =?utf-8?B?aThNcWhPQzhIV0VNZTZCdGgyNk9kc05SNE5uSHphVXlTREhTY1pFUVF2VGUv?=
 =?utf-8?B?bVVxcE5BZDd6RkhacEgrYmZuaVQxMkpaTTRoaFJGWXJZSnNZNGZCZHVIcy9V?=
 =?utf-8?B?YTd3RUlGTFNJMHNzbFN6UWxlL05iOW05aHFhWm1WQnc4N291VmVXYnEzMGJs?=
 =?utf-8?Q?Yn36HNjg2gU1Ca8z8O5LSf33N?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fcbbbdc-7aec-4899-5dc8-08dd68096e66
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 23:46:27.6442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2z4FjSUnkfbOr+Cfof2Vhxcee6km+XBDQOGHEARYHwuHFS4TcFlfydtSa05uKn52Zsou2K271NkBoniw3rRemw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7148
X-OriginatorOrg: intel.com

On 2025/3/20 23:23, Jason Gunthorpe wrote:
> On Thu, Mar 20, 2025 at 06:47:27AM -0700, Yi Liu wrote:
>> Add kdoc to highligt the caller of iommu_[attach|replace]_group_handle()
>> and iommu_attach_device_pasid() should always provide a new handle.
>>
>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>> ---
>>   drivers/iommu/iommu.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> May want to provide a code pointer to the lockless paths in the fault
> functions in the commit message if you respin

sure.

-- 
Regards,
Yi Liu
