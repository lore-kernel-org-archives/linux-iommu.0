Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD8D37419B
	for <iommu@lists.linux.dev>; Mon, 25 May 2026 06:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779690084; cv=fail; b=utbem8PH0IIiJk2qcq3vV8hw0mSnTRxg62rKx8QgPiNVmuytMGW7zxUs5buxhARzOmY5LkOfXeV4nTRMUjiTms2hAD9eJTJE2ivRZ83VmXST3KFSq+o51SZ+CcSBK/PCZieNp0obPMX6lXY0mdupfrmamz+9Vj8VYbZcq2gJ4AA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779690084; c=relaxed/simple;
	bh=0v+w7FbZP5di0NRm2g7d75X5Zy7oj3S1N5om5bpqjwE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SQNmo57KEEkrzafoBtqLag6AOph57wFGargEwouCJqe7TDHNFGmalvr5zwttd4tRaJ2WJLFf00NBo0EJB2bY91i7IYjKCJ5xnI3i8mn6JpLyRLXTPM4TIPL26djZhhDE+gxg9HyHJG81QcHltM0tNKthmGArKU5F8JhveRy+v4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M9Hoa+Cq; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M9Hoa+Cq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779690081; x=1811226081;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0v+w7FbZP5di0NRm2g7d75X5Zy7oj3S1N5om5bpqjwE=;
  b=M9Hoa+Cq5K9Hc+flY8afrH1aDcPYtABAF57hViY0JJzvK7/E8M6tElxJ
   7GivUzUhhLnhLXFy1Ef2ca184zPovzwCN/SZAxfP3pWb3AZwJsA+wHWJR
   c508LDtDA8EnXbGmKlx543azYCfAaANeJnmvsA2tlvMNvViyUbcZyEpoZ
   oyPMfL6W2bryTiime3RV9asAP3wRCDATRkRYtZNBsNU3/H2wrsDSJq+fy
   f0pBGFgWeir2NM4UvM93pYVVeFAIkuVD55AX/ZNPrT0yfTt3/SlesB3Ja
   M/9BNkYiFTyPB4ZQIPpKT+0K8PO24J+xkLxRCbx5FS4Iuyw4HIJPtkJ7O
   A==;
X-CSE-ConnectionGUID: N2l+djduSlOMPloaPLfETw==
X-CSE-MsgGUID: iHDqSQ5gQyC+MhqK9N1HbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11796"; a="84129975"
X-IronPort-AV: E=Sophos;i="6.24,167,1774335600"; 
   d="scan'208";a="84129975"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2026 23:21:19 -0700
X-CSE-ConnectionGUID: Lz941fCFQQqDOgjC1q5dNg==
X-CSE-MsgGUID: V4bWANxATBuVFM2jlGwDAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,167,1774335600"; 
   d="scan'208";a="235155676"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2026 23:21:19 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 24 May 2026 23:21:18 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 24 May 2026 23:21:18 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.62) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 24 May 2026 23:21:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dK0Su0/XJ6eWr9UeRR1EzHLZzx3DATM1hHSSYvEQ+YCP3Du1CbyqGka1Yd1O+MxIluD3j8g3576vJzVVEf/V6mVS6iyh3WHgZpDLanqCJ5eG3WDLNJyzCJTUiVyEWTxpsD79vpLGhbN+GjRA9x7VWkJH+Gke3D+B8CQ65gaBjMc+jN6X4XTFKZxZHE1xgGd4jQPP6xo00wshL0w9p2c8A1tZNJKmqquweGKAXWCc5W08r2GJ9W8S/8rE8u9FnRe4BgGBN5l/MrLVZvVQbQN8VB1N4hKAGxU4y5Kjh8DI4ZGO5+w5BHDOG2Jeo5mXb52gMmwJa+oz/r7xoR/hpujACw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wPvr9XcZ9fgNwcF2qRBVuADvkPl66RYNdBPVNMZIULk=;
 b=PQU2PXFpiUH1/jOt2LPF6xcBFDQpkei/PO4arjEQVLav099p/tnVACJO1BJx3jMU8CXgHIgXvUf869DZ5ENp7HRxfNtaueFqnWjRDow4d4xZ3n+sdav4rnz5u0xMQX4s97opZkIR5zVkr0cTkUeNb5ySAXNhjmBjVNTQydSL6c7gHOB0ndZbOnfGvmN1oq+DGgfTCtNJiyu7b9ockUw8DfAAWr3yIi0mETFa8nwI5el1SPXrn3RRcP4SCZyiY7xZND93yQqZ0Ec3kmd6SLczUsM6fMUTsaUZfm7N2RfUtfg+RgNNSF9RVnDl46wysIB27ALjxeIeb7n3/C5cha+f5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
 by CO1PR11MB4931.namprd11.prod.outlook.com (2603:10b6:303:9d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 06:21:15 +0000
Received: from LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7]) by LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7%5]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 06:21:15 +0000
Message-ID: <3ff06437-e125-40dc-affe-b234241129cf@intel.com>
Date: Mon, 25 May 2026 14:29:23 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 7/7] Documentation: Update VFIO NOIOMMU mode
To: Jacob Pan <jacob.pan@linux.microsoft.com>
CC: <linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, Jason Gunthorpe <jgg@nvidia.com>, Alex Williamson
	<alex@shazbot.org>, Joerg Roedel <joro@8bytes.org>, Mostafa Saleh
	<smostafa@google.com>, David Matlack <dmatlack@google.com>, Robin Murphy
	<robin.murphy@arm.com>, Nicolin Chen <nicolinc@nvidia.com>, "Tian, Kevin"
	<kevin.tian@intel.com>, Baolu Lu <baolu.lu@linux.intel.com>, Saurabh Sengar
	<ssengar@linux.microsoft.com>, <skhawaja@google.com>,
	<pasha.tatashin@soleen.com>, Will Deacon <will@kernel.org>
References: <20260521221155.1375144-1-jacob.pan@linux.microsoft.com>
 <20260521221155.1375144-8-jacob.pan@linux.microsoft.com>
 <18733b82-9f59-4a4b-b37c-69a2e367a0ab@intel.com>
 <20260522204210.00002858@linux.microsoft.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20260522204210.00002858@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TP0P295CA0047.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::13) To LV8PR11MB8509.namprd11.prod.outlook.com
 (2603:10b6:408:1e6::15)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8509:EE_|CO1PR11MB4931:EE_
X-MS-Office365-Filtering-Correlation-Id: d9ef016f-6450-4404-144c-08deba25d302
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|42112799006|18002099003|56012099003|22082099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: 8RFfZuJ26ltSVHW+Z0M5TumReIu53SCQKsYKQD2UAdlJVxLl9n7z4G9S9rtfoJgm4reQyVV+Dv0++ROhbsaVSMlMwgJ/Pfbcf19JeW+m38w60J8ra9B9U38nfHt58KFUwy+lQBPNxEnP8WYSJ79DKocx6kjWyQb7gckgVD4Rb+xXmJd0ArH7fTIsJ0TzJY6z7HDRwyCFfBtlhtORq6T3yoVu6ayBxpqbFJ35ED+jUOG8aYHD/lEdPNRCvDw34yr351pmcdwyFFtSqumU06qkOaZIOeQfg3/r7Iip1Trzm85MH72upB6iVzFUCH6MUk5LM57U27HAxCDLH3towCjyXwXZQVHuYatySGmxxnGfWYFHkQn8e44d4JrOsQf6tR7JUlgJ/ZaUTCH+TZQsFj20a9e3XMr4lo1XDrB9k4u60SlmgfNm94htE9NOoQ5elW8TOq8PX+kthkHTBJEtxO7eizpWO6DQhc355nJMidlgFiWS0Mrd9gQT3Wgu08piwKzSWxjZYlmFBp5OFft1DvjM+oN7IZ24ufvpJODKcmKJFnia8fNvC3OB9hG1peXyusARVDN2uQ5e3ZCt0HwUMaoc0FTH+xf16nIGoWtf25/booeeidnCIM6fZ4Ct2oAXEVqlXKLAcilHZ5SO45WKAojZAMn5AAfBHOARBHXB8vONg3uwbcw2Jq6/Xo2n2bibnk2c
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR11MB8509.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(42112799006)(18002099003)(56012099003)(22082099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDFYL3pQYW5nSlRUSW1VeEdMWUQ1WUJSOWhSajFvSi9ma3lMbUVHVGNTZVZy?=
 =?utf-8?B?TWtyUGFneXBEYmRFRVBTbko0VUw4WjRaTWJzL3RIc21RZlVBa2J6MEhsalBH?=
 =?utf-8?B?c24vR2VzMytBTmdZZTdNRmE1OVBob28vcjhRN0EvREloQnZVcWw2MFFzZi9P?=
 =?utf-8?B?L29uYjk3OUdHSXVRL0E1OWVtYUZkeFVHRmtMSHVWM3p6T0VqVGFLSlZMdXlZ?=
 =?utf-8?B?TFdrL3Q4cW5JdHZoRXdoYVNlOWxISXlYblMvNVJRUWwrS0p4RThaaTFxL0Q0?=
 =?utf-8?B?T0lJT01WMkxZVjVmNEcremRBbWswd0JSRTNDbWxDa0czMktXOWh3NERodkNO?=
 =?utf-8?B?OGZkUmJaeDNpWGdjK1ZCRTN0SU83NDhoSHFDQ1hyTitxUHkrcHFSWDlHaDlQ?=
 =?utf-8?B?cS9kb1R1YzdrNDAvb2V5Q0phR3lJOXhDY1ZmcXlXU2RVRnNyUzhJYUhGNEM0?=
 =?utf-8?B?a282L3l0YjVoSzlkN0RXNy9iWXRaQTFZZzRRSDlITm9WYWtlb2hFWGRsRklB?=
 =?utf-8?B?YndHa3pFa3hBZENUT0M1aUttOEMrcHkyL3NNWmF0aXkxQ2F1ZlhxWkliUzYz?=
 =?utf-8?B?cGNybXkybFpPZERKZUJWTWs1WHNXT3R2QTA2M1dsRlR4cnRtUU1tN3hrTmpu?=
 =?utf-8?B?ODJKUEt5aDR6YnVEZzM2YkNkZUxoaDZVZStVTXdRcFNhVE1yandmcUdXRnVj?=
 =?utf-8?B?ZjN0NkNEWWpXZVBKaTJ2TUF5UDBkek9sNzhsOEsrVGQ3WVQ5SzJCNGpDMER2?=
 =?utf-8?B?enRycFVTL2hoN3lSNWwwVzJWQ2NjdTl5Mmt3NWxBcnl5ZThibUNLemFCVW1q?=
 =?utf-8?B?cS9BRS82VDRCdFpReW90Z3FQN3ZLS2tUVGZPditWZ0hPc2crTHhHbFVSWkZp?=
 =?utf-8?B?MFJoM3AxdnJzTFdSbkZYK0Y4MVE1aE5NVHlwZ2VwN2lxZzlNVUgyell6NlFl?=
 =?utf-8?B?OWI0d2FMa25TK1VNb0ZwU1M3Z3NMVlhLcVJ4RFFnR1hJZ0NCNTZlcGY1TDlK?=
 =?utf-8?B?a2orN1lWYTk3U1VkSFljUHViM0JYVlVWZ3FOY3R6MVRpY2F4NFhyckxlZUpC?=
 =?utf-8?B?L2hvYU4rWjZEeThCUjdvNjJyeWVkZDkwVUk1RWpQUmVVenNUWUYvNVNnbmZ2?=
 =?utf-8?B?bXlVTERvblhKdHRtYVY4L3JjUE5YdnlKdGRPaGUzQWRhak8wRGhtQWFDVWp5?=
 =?utf-8?B?NU03UFhzaFh6MFZoWXBQdVBtdWpMVDdnd1U5SEg0M0xObmZmZU1KTjN1RGRu?=
 =?utf-8?B?UEZ1UTh0dzlwc0tGZjJHeHBDQVhLMjh5WDlWdVdWaEZNNXY2N3p5NWhqUHRl?=
 =?utf-8?B?bmlnM1ByYnY2NTBha0tGeE5UZWt2NHhWckM3VnhIdTFXa2UwWGhqaHc1Tllv?=
 =?utf-8?B?bUZsaU15dzA1a1l2YzUrTjBYTzdXSDBPYkRVMldBdFAzSGFQcEZ5eXN0ODdo?=
 =?utf-8?B?ZEJsWjBnS0hOQzlXZ0xuMGJCVjBuajhaOTNaR0lvQVo3UmRGbGtsL3pJREN5?=
 =?utf-8?B?YWxMNHNvVm96dWRYRE9KQUpSbnVFa0Y0aVNGY054MFU4TFJYaHg1L0lTaVpG?=
 =?utf-8?B?MThpSGJOTzlzZ0RXYyt0Wm51TVJOSnI2ZHJ3QitvUFh2L1V1S01OL3lMZ1Nh?=
 =?utf-8?B?MkY4ViswUWtjWjFQeDNaZDFhYzR2dTlZZW02ZUJoSnpZcnJ6bEdNdDgxVWtO?=
 =?utf-8?B?M1dMSXl2T3M5MzJ0amMwWmxYRktxQllGdWRjcjNlVndrNE9zQTBRNHNFdGJh?=
 =?utf-8?B?VW8wZ05RUVl6V1ZJTFhsSHpzRmJESk5ZdzFSM2UreWh5Y3AwcW9BWk96YzVs?=
 =?utf-8?B?NElFaXBOSC9wZW8xQUJvbGFQZmo4Z1hlWHYvTTZEeVZZbU91Nk5PeGV0Q3ln?=
 =?utf-8?B?MXhwQ0xUUWp2QU9la3NtYWliNWhxYjhTMTVWR1g4RllpTGgyeGswQUxyYU9n?=
 =?utf-8?B?QkNoWXhCMFNVOGxXdWM5UlVITk42OTdoMjAyQWhJRHhQTEZzWVp6ZTlXTFl5?=
 =?utf-8?B?NGFwTFNkR2NtWHJIanJlb1VhSHBndzNibmxwMkF5MGxYRk9PZXNMYWYxUVRx?=
 =?utf-8?B?bDJlUVgyMmNVZWFFNVRoVUpVV3ZEelhrVEJvNGVLbEZhQ3h6aTc3ZUJsdTdx?=
 =?utf-8?B?U0pLVWhiV1B6Z2dmY0VHcFd2SFZ3MFNlT1dvbDUycXBKL3BRNWUwN3oyTVVu?=
 =?utf-8?B?QjZLWWJGR0xGSEoxQ1RNRzF3Q0FtTUxZV3ZlMVhPU3MyODMvVzc3YWtiRzlX?=
 =?utf-8?B?Z3ZIdExoV0FyTUtVcnpFQlNaeXN1UUtjenF4ajlpbFkxT3JwZ3oyUkVFTnRr?=
 =?utf-8?B?QVBJbU5jaUF4Nzd2VGdHMUN0UkEyT1krK0c4c21IUkhMYUJZdWlKZz09?=
X-Exchange-RoutingPolicyChecked: FSfhyIYAbJ4eMGjtqCaqG/qV6NC/zuu0FxNlWblnQuNKu0vl49VzmD4uzUgx0MM1JBHsAvYpCOO72j/SlQqF50wURYwEW7LbQvOXSbjRr0RrzwCVS/KfLUDCXc4ofXu26i3VMVbeU61yrdfs7lz+gMZhFbMx6iLLZZbqfasBBjsnqrTb3Tig3zdphMFOKbkOoYadVBe7zU1h3iu3AHgTsMXNAyGOAmV9C5x4ZBLsNNh1XJIXTIaPoHjb5bUpqoa3OlJPBi7OlHSkbfJIbCprS+qKf016BtiyFODD/cnjRXZsNqMtAa210G5Xe002PeuREaabsvZBjb67l6Ykuyd5Eg==
X-MS-Exchange-CrossTenant-Network-Message-Id: d9ef016f-6450-4404-144c-08deba25d302
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8509.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 06:21:15.1143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vIOS9lSJkVU0y8Mwgrb25a6ecWcBtmWzXcsSz51Ou+CcokXlVhB9++VjjzdpXdu/wLxi5wjSa+DaN1+EPfOsZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4931
X-OriginatorOrg: intel.com

On 5/23/26 11:42, Jacob Pan wrote:
> Hi Yi,
> 
> On Fri, 22 May 2026 17:42:42 +0800
> Yi Liu <yi.l.liu@intel.com> wrote:
> 
>>> ++------+-------+-----------+------+---------+---------------------------+
>>> +| Case | GROUP | Container | CDEV | NOIOMMU | Notes
>>>       |
>>> ++======+=======+===========+======+=========+===========================+
>>> +|  1   |   y   |     y     |  n   |   yes   | Group noiommu works
>>>       |
>>> ++------+-------+-----------+------+---------+---------------------------+
>>> +|  2   |   y   |     n     |  n   |   no    | Blocked - no
>>> container    |
>>> ++------+-------+-----------+------+---------+---------------------------+
>>> +|  3   |   y   |     y     |  y   |   yes   | Both paths work
>>>       |
>>> ++------+-------+-----------+------+---------+---------------------------+
>>> +|  4   |   y   |     n     |  y   |   no    | Blocked - no
>>> container    |
>>> ++------+-------+-----------+------+---------+---------------------------+
>>> +|  5   |   n   |     -     |  y   |   yes   | Cdev-only works
>>>       |
>>> ++------+-------+-----------+------+---------+---------------------------+
>>> +|  6   |   n   |     -     |  n   |   no    | No access path
>>>       |
>>> ++------+-------+-----------+------+---------+---------------------------+
>>> +
>>
>> Does "Bloked" mean no access path or no chance to compile? :)
> By “Blocked”, I mean Kconfig prevents that combination from being
> selected, so it is not buildable as such; consequently there is no
> access path at runtime.

got it. :)

Reviewed-by: Yi Liu <yi.l.liu@intel.com>
