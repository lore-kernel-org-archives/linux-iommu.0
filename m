Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3A314E2E8
	for <iommu@lists.linux.dev>; Tue,  2 Jul 2024 08:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719909809; cv=fail; b=FgF1cHp91oXsk+Sore7bhNastLJilt3KpwGeUHfmt6BzmMEUZRARc25ldoyF82MrseKyS5MaY9DzhSaLgsHTIdzKW4jGudUtC+NNqbZuToYag25l5TyS64Z2EIoTANbabvtMFyoVBdWrOT85dyt97vA7iZTGsZTxKDuRuiiW6LE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719909809; c=relaxed/simple;
	bh=0KjE9x2jeFcaJFGa/hhcr5MdcurpdrnVTnIpN6xswSk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=poDm5qs6ylo3TKsZv36QD47Qrjj5Z4BlTqycNV6KDDR10YXxvXWO/cfcnphKYv1u69P0RBOCKBpdT8pVAa7mOS7vkvxjLLgLeAk9rLxZvMEZgs1ASrZz2pVk2MSg8oBGxymrzz7Bmes+xgIriMrId9VBX6BQsQR9y03/ChJCTfs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PZaIfOSd; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PZaIfOSd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719909807; x=1751445807;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0KjE9x2jeFcaJFGa/hhcr5MdcurpdrnVTnIpN6xswSk=;
  b=PZaIfOSdqNFemY/JEhRY3pOGd0Po7CggGpkYU1zoBZoZ7PwKGhjab4cE
   zD7n9rIVhs00fn1ssqkwqEXlI6abWtnn7j9NxisWiQKi0xjMuQFD5EU+F
   +g7JfnJ8kmYvEdRC/pxH2i/qeoCu/3y0jvmz07oGVxhTg/tmB2/Qi+Q6P
   FezqN5/ByOUKmydoaIhRYC4TU7EqxC+C7AdlsPd14YhO1WJtjcykhTOye
   yRM4XNlNN7tK0vZnWhImXyyh5Y4rqehXEbkwMNJiZ6gq3R71MHJez56OX
   MuTDVwIqbY09aWjYsu/rPILeSZtFgeZgnknE7VoaI19mQfmWKwYKfskpy
   g==;
X-CSE-ConnectionGUID: 1SUVz+7JT/uTMc0mhmVFug==
X-CSE-MsgGUID: JBY2sMlZS3O0xW4+XM8TDQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="27750435"
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="27750435"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 01:43:26 -0700
X-CSE-ConnectionGUID: aYinkHYvTX+y+YWDhQA6Zw==
X-CSE-MsgGUID: kEsJvqqvQAiT7ROEWjaoUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="45719081"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Jul 2024 01:43:26 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 2 Jul 2024 01:43:25 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 2 Jul 2024 01:43:25 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 2 Jul 2024 01:43:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y1nCMEL45n68X/yHvcxcz9/bsuNYJfJbKhLvkHFTP1+N3Tz6bSLTbyMpjID32rdTrDFbeag/ddy5RP808+UubNpn/8wgGwNX0XDrGWnKx947liWUNIKJ4alP3yE+mFBfpi/Bm6DGynHrq/Mm4v5845oyu66lFuy+UHRnmUEqc2488yeXpZmRVpswZ82UQf55ZeMN1bfPjI4V2Sj2pFZ2YwCbM/SwxLYMU7VP6DBg6lMXO5J2cEA71Y67C58/mkM0VZhfW4NWv1PlwC0kFyEUuVUgIx1Tsu8sVEu5O1qxs7DrrUdhZmT9UlSsr1ajowvtk7pJ1t2x4/aMG+Pnj3Wdcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M4T1syELegVBJ14LTO71Vr6irmNAiuD2uhKd8aKYkAw=;
 b=MAHaaOdzo8IVRfT7WwubiOHHDV+5RIMX/JsUkqU3juzZZ7DgUyfxbFKZVj9bh5qqIcqK6kja3Dk75PJXkH2LX4AVE93N7wfySmHzu2EvVAtm4v25YKypwmmnXbAkBh80Pqsw4EXGfQzrb2vwJRgJZANkXChZPfx5lTWqGA+U53pAF8RdwIPSYAmOk0gU5Ud3umIyeQ6liw3bYCPAHBSXy3rvN7mWi9KxDMqZj/W3lXxLWCcg0l8aywm6n7rDCHKQwGo7rKmeNzWRY17tjrRH96uIsGNnhN3xVhJtvwyYi2P8H6iFLQaznVnZJ/xchT+0E/v0jmuZPVgOT2W0gzcdKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SA1PR11MB8393.namprd11.prod.outlook.com (2603:10b6:806:373::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Tue, 2 Jul
 2024 08:43:16 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.7719.022; Tue, 2 Jul 2024
 08:43:16 +0000
Message-ID: <fb388a2b-9ffc-42c5-893c-0c620e6977fc@intel.com>
Date: Tue, 2 Jul 2024 16:47:13 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: lack of permission checking with intel-iommu?
To: Baolu Lu <baolu.lu@linux.intel.com>, Christoph Hellwig
	<hch@infradead.org>, David Woodhouse <dwmw2@infradead.org>
CC: <iommu@lists.linux.dev>
References: <ZoOwc7O5W0PUeja5@infradead.org> <ZoO0KxkU_JNO0av4@infradead.org>
 <4d84afa1-e2ce-4e1b-8fe3-1d3fb0db2ba0@linux.intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <4d84afa1-e2ce-4e1b-8fe3-1d3fb0db2ba0@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0028.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::21) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SA1PR11MB8393:EE_
X-MS-Office365-Filtering-Correlation-Id: f9e1f285-e341-4c6a-73c7-08dc9a730445
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YVQyYXpQbm9QdTArajkvbExRUXUrZUg5dURZdy8zTDRqd2E1bDViemF2TkxR?=
 =?utf-8?B?VkREcXNtdklYWkM2YUdXZVovUUg2cmFJT3JVU1JuZkNkTHNtMWNMQUV2RXUr?=
 =?utf-8?B?Tm8xZCtrVzc4NlZST1ZKMjBLOUhJNVdxeXpOZzR5MGFZOUlrUllvYzV0dE9s?=
 =?utf-8?B?cTRxdjFFZzB2MVM4MlgrYzZIbVBIdVhLR0ZjSzZlYkdWRlk5a0JNMUxJUXRP?=
 =?utf-8?B?a3Z4dXMwVEdDNGZUdWx5ZVpKV2ZSYUI3ZTdpYm5zSEx4TWN1TXVhSmZDdW1D?=
 =?utf-8?B?aTBXZ1FwY1E4ZEIrMFdHMW15dHNVeEExTlloTHZndTN3Q2N2VEhXS0QxTkVB?=
 =?utf-8?B?NDBQQ3pCVDM0WFE4TVVQb0lLeVBNMENGNytJeE44aSs2cTgveGVBYllPcE1N?=
 =?utf-8?B?MEtqTWMrNWV1M0tlWlhoTDNHQzhNNnRUUmtEeFRnQjNtVkRYbXFVVVZvaWxi?=
 =?utf-8?B?ZWx0WUozVmY5UzJsNHNJRVJwWCszTlVwWXV6aFgwUk5TbGREM1pZazU0djNm?=
 =?utf-8?B?VklHbXNWMUZKN21KWlB3WC9RQ09zTm1LOTkzQTVRVHhsdWNoVGtlZ25mUG11?=
 =?utf-8?B?MTdrNlp1aXpmdm1OQzlXU240YURoNmQ4eHFmSHJPTHV0RThTTXQxbnlZejJk?=
 =?utf-8?B?MzJIdU9xamY3bTlpNlZ1Ykt2RVNTUVM3SVJnOVJheExSMFAyV0JPUW1QWjA3?=
 =?utf-8?B?MlNpRHBHcWMwazN3bThxb3R4L0pFaXVGUC9HM1pQaDY1NHZsNytMTWhoUnox?=
 =?utf-8?B?T212VW9OdUhjcUZmWDFld2cvMUc1UjEwZVJzT0RXeFMyaUI5eUFDMUxHaGV5?=
 =?utf-8?B?aVI3SGdsK1dTWFB1bjhkTGgyakdEN2cvRVM0ZEI2V004ZW8wNlBtUnJOS3JP?=
 =?utf-8?B?WkpGY01uc1J1clFTKzVhempYREQ2aGdPOXNOcEVTWlNxR2hZYmpwTVgvaDBE?=
 =?utf-8?B?MUxXdlRZTXhiZlhTbEcraXlrK25DbEVIZ2plNHZHa0tuaDhibFdMK2FXT2Rk?=
 =?utf-8?B?dktFN01ZTExIRGJHVzVWZmdLNTBkYkVuS3hseXFCak1pNitISTJ0U3VhZTNt?=
 =?utf-8?B?NCtSOFdQU2wzc3kxWWF2RGpUZGZtQWlvcXFVbG9PejJ5YmtqeWtXNTM0MER4?=
 =?utf-8?B?VUd5MTBWOUV6ODRjN2dUdnV5WVRZUDJ0c1d4NmVUOGwzOEkzUGlnNGxJcnRy?=
 =?utf-8?B?Z0o1MUxqamV4ZGpQM3hhSzNYdDVwaUMwdmsxczFGc3RKS0krVllqU3R2c0FY?=
 =?utf-8?B?OTgwRDVkOW9XYnJSaEw0SDJqSG5xUVp0a0JYOUFmd2l3c3JvWkFqbTg5dVQv?=
 =?utf-8?B?TjBUS0hJOVBRUEVTQWkySzNJT0E0WDg2Q0NjRmRDKzU1UlRhSER2eGJ3ZVdm?=
 =?utf-8?B?OEpJRkNPQStTY0ptcEZGRFpDN0YrT0lWU3paS0lNUmNaUnhZRkpIVUwxNVkr?=
 =?utf-8?B?QUU5NzR5OUJxSGRoNkNrSmZTR05HWEMxL3d3WFVyR0RIdkVGS1d5RCt4cGJa?=
 =?utf-8?B?SStIK2hlQ0MrUnZONDl3WEpkcGF4UFZzaVd0RDdZWmQwa0J0Sk5PZVFXcDVi?=
 =?utf-8?B?TnRSdlIyMDJoaTQrUG91R0I4M2hRVDE5YnV2UWZWRVpBdFdUdWtna0dqWVVL?=
 =?utf-8?B?d3Y5UzB1Y2NGV0lxbHl5azlCUGY5cm9GQmx4SXg0QmdaWk9XdlVselo3bFlX?=
 =?utf-8?B?N0tpcFpncnNXQmVyOG41bE5wc0FBZm1odmZUbkMwN3lvVTJlZlZDM1VPUEtM?=
 =?utf-8?B?eWU2OGNQMFlxSC9MMTcvbG5UWGhZa1hpdW1zeTh3UUtmUDdualN6MFB0SXdY?=
 =?utf-8?B?MExtd0NNWWdmaGV2ajVIUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0dsQzEvc3B5ekRvQzNWRVlaZER0d05TYmV4NVdteXVodldNMXFaWnZ4STRi?=
 =?utf-8?B?aFV5TmM0TjlhZ2Y4Qzg2bk5GVFAzdytBcWM4cm1ZS1kyTUpVRWFwTXNaYXVt?=
 =?utf-8?B?cHhWNnI3UTJGSkNJKy9COHBSM3YxcVN0dnYya0JWOU1FV0ZwUzVkRzd6akJx?=
 =?utf-8?B?OEE2ZStnSldTWnh0Z2piUCtBQnNtYVR1eVllZG5OLzMvdy90bStYNFV5ejJv?=
 =?utf-8?B?a2gwcUcrMDZrcnlpREVHMGVueHBJNzJHdjBTeWNWRzRadit2Z254Zk9xUER6?=
 =?utf-8?B?NnNMSGlkOTg0SEoyY3lsYkZOcWtjQUt2WEVtY0dSNFpBUmtpTmNTV2xVWGl6?=
 =?utf-8?B?WmNYbVA0N0ZWeEpiKzNJRmJ2MFpxdUdPQ0xaOEJjdXBBWFFOaVp1QTM4Z0ZI?=
 =?utf-8?B?SFVCT0ptb2YyQnZDVTBqMHBJWE5nWHV0cFdZSk9zOFF1V0ZPNzZFeUw2ODk1?=
 =?utf-8?B?cEVVNWFRSitJcGU0aXRkVHNlK3l1VmJVR3lJTXUyUGlubXpXR1FtSFUzN05w?=
 =?utf-8?B?T1A2T1NaeHZKSUN4NDA1a3Q3ZjhXdU9tdHYrZHVaWnRZUWVBQWVUekw3K08w?=
 =?utf-8?B?eEc2RmltanlqZXVlbDM5Qm5hUXRMV3BNMXpRVHhXV1U2YmQyM0dyMEwxMzFE?=
 =?utf-8?B?KytmY0o5eUdHZXdEUTBTSlY3bGRhNmlvOERiVk0yVHJtRVVsanBYbnR0eDVE?=
 =?utf-8?B?dlFHTEE1VTF2WFQzaHkzaHUyS3FCQkJIeTZrNXBxS1lyNlpqRzFINFJIWUpy?=
 =?utf-8?B?eUt1YXlOK2tMc3RzdDU4dUlRcUJoRUZDWjk1SEVocE1qSm5YdUVmSi85eHAx?=
 =?utf-8?B?UTk1MlBQTXlLT2l1RnFKVHh1eHh2RkM2QTM4YWVEamxqV1FYNG90RUNGaERv?=
 =?utf-8?B?YWNuR1V1T1ErdU5sRHFRaGtCVm1xSVZ6VmRUakZiZk54anF5OTZBS2dGM2RP?=
 =?utf-8?B?RDZwN0RsdGQxVWVmTkhvNEdoOFA3WklZS1NHdHVXQmxiMzB6UCtqdnM1SEpz?=
 =?utf-8?B?VWlid1lPNE5Ba0hzL1lFTEkySldOZ2tqZDdDNEp0MjFGM2hZdGR2dngzZy9n?=
 =?utf-8?B?dXVkQTdiZXFhbHk2d1JqM2Y5UFlWQ1g2VW40WEVSNXp1dmdxdmtxWWRGeWxR?=
 =?utf-8?B?SDFTZXFFR1FId1NockpjZGN6dU8zdm0xL3JRcm4zT3B2aXJVZFo4enhYVlMz?=
 =?utf-8?B?TlZ4UGdLOHgrRlBONFVCSUZDQ3AxaXREc1o0Q2FIZG13a1p6Njg4UEVJKzJX?=
 =?utf-8?B?b25uUlNZMVc3bEQ2TytnTnNCZ2dWdTU4OWdpcmQvR3pRY0R0aUd0UThrQWVL?=
 =?utf-8?B?T3NjZHZDem00MURSck9ZNjVtdjY1dENRZCtxUSswdnFiMzVYbGVCMisyYjZX?=
 =?utf-8?B?ckt1K1BmV2lnay9HZmlpRVBpOFgvd3dpODhqOUNJeVFMQm0wQzJoTTBwMXhY?=
 =?utf-8?B?NjZoZm1QdXpsYmVhUWliWlhTZ2swUG5GeUF6UXpWQldteHZoTEJnMjdIak1N?=
 =?utf-8?B?dSt1VkdMT081bTAxVFVtNEFLQWdWcjFiRDZaZWRFS0xMZG0wWGxtR3gwZlRQ?=
 =?utf-8?B?RVZ3dTZiS3lWOExhdGZhaWJoL2YySmJGODR6UXlieXpiK3pCdnNCNE12d0ZK?=
 =?utf-8?B?ak5ySi9YM0ZnV0d3TVI4NTFtaGdsZUZrT3hQZm5UNkg1aFZVOVptN0J2VUFQ?=
 =?utf-8?B?NTVOWEZhOFVQd1I2VlBCclAzdWE4WEhBS1ZNMW8ycmZGaE85SXBDYXQ0aVJU?=
 =?utf-8?B?Zm5LY2FaWmdTckJxdDM3L1grS0tmdmZrZ0UxT0JROFVHeDJqRGx2WEJsNzJ5?=
 =?utf-8?B?LzhXNUR4eGc5eUUzOXhmU1lFbnNrSEtCaVpyWjFXMno5cDVQRWljMnpmNHJK?=
 =?utf-8?B?Z1lGRFdoTHBtVlFnWndPU0lUUG53eGpjV3lQekpxbVUrSFp3QUF0THdhSFA2?=
 =?utf-8?B?eU9UVmdoSDVrcUdiRk11MTJRSnhhNVZEVk9UdVNxQUpKeTNEZ1EwTkhQUmhy?=
 =?utf-8?B?N0szOU13NWZReEpmOTloN3o2VkkyZE9OK3QvQkVJQUphdGJudWJrRGJWTXhP?=
 =?utf-8?B?Z2U1VXVWM2xBSkNmY3ozajlNa3JUNnhLMjZiQ0ZaSm0yRHFySVNwL2NRcHdy?=
 =?utf-8?Q?QUDiSGvYJnWwXQBCpdnsdtrBq?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f9e1f285-e341-4c6a-73c7-08dc9a730445
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 08:43:16.7162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LLp73ag2I1QpjDpLav0iBnWFo7powoq6sXXv7HzWGCC2xvJRZ59GU4ScMza0AnslTFR7EqaLp4DggmFv7Zw0pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8393
X-OriginatorOrg: intel.com

Hi Baolu,

On 2024/7/2 16:22, Baolu Lu wrote:
> On 2024/7/2 16:02, Christoph Hellwig wrote:
>> On Tue, Jul 02, 2024 at 12:46:59AM -0700, Christoph Hellwig wrote:
>>> Hi all,
> Hi Christoph,
> 
>>>
>>> we've recently had an interesting case where a device unexpectedly
>>> modified a dma buffer passed to it.  On AMD systems this caused iommu
>>> faults because the buffer was mapped read only (DMA_FROM_DEVICE), but
>>> on an Intel system everything worked fine as the IOMMU did not trip up
>>> on the device writes to that buffer.  Any idea why that could sneak
>>> through?
>> Sorry if this was confusing, the permission checking is of course about
>> the device reading from a buffer mapped read-only for the device
>> (as that is what DMA_FROM_DEVICE is), which on intel still allows it
>> to read.
> 
> Is it about IOMMU blocking "device reading from buffer" or "device
> writing to buffer"?
> 
> The intel iommu driver might use first-stage translation for kernel DMA.
> It seems not to block the "device reading from buffer" if I remember it
> correctly.

does the current kernel use the first-stage page table by default?

-- 
Regards,
Yi Liu
