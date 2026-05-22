Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E7F3A9D8A
	for <iommu@lists.linux.dev>; Fri, 22 May 2026 09:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779441106; cv=fail; b=g+04/pKC43VzNpyPgk8qUmclErr4ZW3dmDRauH/wFzfrN11b4v1Ae0gfAIzrUu2e+X+YurKn1aBG+ZDAR8mNeduAc2fjQ9u+78M7QX8XQlJNIP93JJn8/KZH1B0wtpwz1LTeS6UUxQOWrEQBFXDBJf3JWy0sgEQvre++HF4Gp3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779441106; c=relaxed/simple;
	bh=xgYtiMIPcoxWYW/4nQJQiNDpOOD1J5zVelMq1XYsAKA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=N/KqcJJ7ryyW6iQd0jzDoUCUIEQCCWSatInaluLPxu3nfcOh79/5dPi3RbA6r8BesrqMrVH7x27PyMOmx/jLNqnL/0OxtRz0vBadx2Z8+jMEZ5Igy/O1iTiWDSqVUwDGxsONKK/K7eHWxNNBkpVIxV9G06rReCpb3NDdqgmu7tA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WlF1ivyy; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WlF1ivyy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779441099; x=1810977099;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xgYtiMIPcoxWYW/4nQJQiNDpOOD1J5zVelMq1XYsAKA=;
  b=WlF1ivyy5yxTSqJphU5Nd7G1uOGSZON/tz+vT2+DWyAZU0o7yq0PQEXJ
   DMYX3MaNn/jb5N1jun6uPeWUW8TA/u0PovCalb6MRWp/Rfg9zrcBOVeRR
   w4YhU1pTIrV70YRu5RQHqpYAIIJBslMf2YzyHgnKUrrZaoZmA2s9LbwO2
   iSrY1NlulTYHNu6bDmOccxtvw537pJqxXwHAjSQ8+ftvNIuV23Jf40/9Q
   F0Q1uW7+Exm0m1y2WjKFBGq21loAdl27PikgoIA0FLsylKZM4KuRNciiw
   ZKd/VT8p8XXecf55fGely+qehlo+3ThjdKmNspA6E4rtQxfm3oUxq77vj
   A==;
X-CSE-ConnectionGUID: 7B/oK9MPRuWgfj7+iiGohg==
X-CSE-MsgGUID: H22TeH3JTsirsj14lz/VPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11793"; a="80549021"
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; 
   d="scan'208";a="80549021"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2026 02:11:36 -0700
X-CSE-ConnectionGUID: Z/WyVOLiQ9msW1jI/Wdocg==
X-CSE-MsgGUID: OHz82Os5Q0KXCAbUH9RcOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; 
   d="scan'208";a="234508187"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2026 02:11:36 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 22 May 2026 02:11:35 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 22 May 2026 02:11:35 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.18) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 22 May 2026 02:11:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kIdFt0899//LU/7UmrtF1Wf++DvyMf21QK6lRRMjnrQbxTUDCLm3OtXyJsGT++XHJTR9l+HaKkyI4dq5fepraZuLACuiKmFsVBJHo14N6JHiO4y7jCIMxoG5cCNkZv/Aiy7sAjINu7fetAGkSjkWjYF12aQTeKJJtDulAbdCY/lLoRua0i5/lmomMaGOiDJSJlJg3zhL7DiWIhQhaMa7cCRekDlhn7ucDYTC+9nF+bJSQbpj5IstvVmkYLYI9btx3eHxXFEKha5TrJ2x3EoTLwKKKpKfCZ7oCE+UIoWv4DIrr7eFhja2phwNj46EGQmFkMRyCxVBTPrf55HhGu7xyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TJrw/svUlGGhFnk4Se1D28o87I9W+ZS/bIcLjXeUlNQ=;
 b=a6sE1hOgCatJ3bvjyufCjJBX+BhltAXj7Te1PTR4xhyOCqsgYNaQvj2vlYXJIvOcQ3AsH3zeDdYB/yoANtKT6q+umbOt8S9OrH4D6flU9Qn/MoE/NVQRaOF4tzp9u10So8Y0EItd+7uXJYbXRkpqQKe7NVfdrYPdL6e/xe4QxkMlHZmF8OB/GvmSLv61FkTLSjpgGhwmCwvAZ+MH5466Y2Vm1wuYm1NmRtd6z/dk9vZjcj2mN2BGsidzmLPAqdA40HVS7JqtD/MyCY1O8VPPkzXNta/AX6pWUp55ZHKA2SUNBSxZ7vhtjheNvgK0nokxo+FLZ/VPtOEZjT+OOi+q7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
 by DS0PR11MB7767.namprd11.prod.outlook.com (2603:10b6:8:138::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 09:11:32 +0000
Received: from LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7]) by LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7%5]) with mapi id 15.21.0048.013; Fri, 22 May 2026
 09:11:31 +0000
Message-ID: <e431af3d-b19a-45d2-a58d-e400d43141f0@intel.com>
Date: Fri, 22 May 2026 17:19:41 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/7] vfio: Enable cdev noiommu mode under iommufd
To: Jacob Pan <jacob.pan@linux.microsoft.com>, <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, Jason Gunthorpe
	<jgg@nvidia.com>, Alex Williamson <alex@shazbot.org>, Joerg Roedel
	<joro@8bytes.org>, Mostafa Saleh <smostafa@google.com>, David Matlack
	<dmatlack@google.com>, Robin Murphy <robin.murphy@arm.com>, Nicolin Chen
	<nicolinc@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>, Baolu Lu
	<baolu.lu@linux.intel.com>
CC: Saurabh Sengar <ssengar@linux.microsoft.com>, <skhawaja@google.com>,
	<pasha.tatashin@soleen.com>, Will Deacon <will@kernel.org>
References: <20260521221155.1375144-1-jacob.pan@linux.microsoft.com>
 <20260521221155.1375144-6-jacob.pan@linux.microsoft.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20260521221155.1375144-6-jacob.pan@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0052.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::14) To LV8PR11MB8509.namprd11.prod.outlook.com
 (2603:10b6:408:1e6::15)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8509:EE_|DS0PR11MB7767:EE_
X-MS-Office365-Filtering-Correlation-Id: f19204a1-b268-4f17-1635-08deb7e21d3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|42112799006|1800799024|7416014|376014|366016|921020|56012099003|11063799006|22082099003|18002099003|4143699003|6133799003|3023799007|5023799004;
X-Microsoft-Antispam-Message-Info: el5Ftt76LWEWEdfrXr3gf328KIk8jkVyV65tEl/R9Il5mbLbZX/d1paM4+Yr4awPa2l/neePUuXygZQCvukvxxQ8jfj5nEV3uA91pQb02ppwDDYIyfHf7pYxAVFfA+tJU0Uef34t/SCQ3Jf7SptRreV1DEHLWJ2F2/+8TNeXMWhjela0GoA4zP4d8lhqoITdxU6IL46bLV2SPsfUw6zpfsa+tvFnKtEGsg2BWkAS0d91uKw+QH7YiH4KVsAcI43EwAKaWzUe2U0TC5gdcD98l0flULsujxCcexqd7EEBiwOaGi/ySMy+8A57szauuEFukYTxc383Z/O/w11WaAJyqW7gl0Tnf0TC610fFqlcekDgHb7o82LTmGNw0eST/pZsKLv/klCtIPmiutWvaEODovWagsx0sn+0SKtY/Blka82rJ4jGthr2Ohybr4VYs/HXZYJut6i7Uuw0lW4n2dA+P6ysH8faYMAzJ8o9URAjAgKxHl/e3XZ6J0vjvbzgDLD9yDRjK6YFNNyApnhYAY5vcC0Dnq71LQWwv/9Hjq/997gYXkG/zZgoAexdOJmI/SnR9vUpwsuEuq7jao+Sx8QG0m4Wa3Pd6snZZkm05im9CJcYseMFygow3g8l1BenHjJWsSSMWlRcHuNEghXH2VHvCm4PI/1OmuiiJHMlvR5qhj53WEkcMqmRb5OLLRHwEU7N34sZ8HmblA2P2IANmwv41eRj9u+ajHy79uHk9h7HsZ8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR11MB8509.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(42112799006)(1800799024)(7416014)(376014)(366016)(921020)(56012099003)(11063799006)(22082099003)(18002099003)(4143699003)(6133799003)(3023799007)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDFtdnM0STVSQldUeGR5dmtLMXdPZVpJOVh6dDB6UnZGR2tkdk5mWjlIcGhp?=
 =?utf-8?B?ZDRkcS9KMTFPU3MyMlp2TE5HUUYyMFd4R2xZcFltVVlUOFE5TEVBNFZhbFpC?=
 =?utf-8?B?QjNKeEhZU3N5ME9Xd0tRS1RUUGI4akdJdGZxM2l6TUgvd3NCT1FmNWhQK1Ba?=
 =?utf-8?B?N0xValA5dEZLRWNaSnFxSFAyT3FsZEovWkRzWlFWNjBtcUgrSnlDbFZjM1hy?=
 =?utf-8?B?Y01HalFrSE5EVXEzUGlDU1NZQzhDNlhxK3NzUFV4U2huM0NEbmhxUnI4OXhY?=
 =?utf-8?B?WFlWK0Q5NlVjcGR5OWttYVgvWHlLa1dTejg1bm04NFpkRmJCWGR5bDhXaWJW?=
 =?utf-8?B?Z2pvd3p4aXJTNUVVQWtNdC80dDZ5NG9TaEVwYXZ5cXJlZEE1VWI4UFNzL3l3?=
 =?utf-8?B?ZFVUeHU2RmlFZHN0WUd3cW1lbWJPSnpTNlA4RFd2TGZHTDA3MzBYekJSZ3ZJ?=
 =?utf-8?B?cEZraDhmcEFGVDY5amd3UG1veGJLQjNuaDk5MDNKOXR5bURJZG1jWmJDMkQr?=
 =?utf-8?B?Z0xXUnNVcTYrWCthdEFlcHYycG15Vkp1VTlhcUsxdm5Ya2ZzcjE1bm9OYk0w?=
 =?utf-8?B?SXRCOXVJbE9KWWo5bmhrZGFxSCtZay9IZ1N3Rmp4NWdvU0ZXcG1oSWQ2VUZj?=
 =?utf-8?B?MDVldW43eExwb1Y5RllKcStacG9ySTRvSTZ3SU9CU1pBNjF6bGI3K0xYTG9h?=
 =?utf-8?B?aWxkZk9rYnNOdTZUdUNuUmRTMjZpNVRSRmN5Y3IrOFdxZzBpNjh2dmhuMEdR?=
 =?utf-8?B?SWwzU3NIQ3VaOUhlQlpPL3ZNajVkdGlkczgwbWtYS2pIL2JITjljMmhmMmQ1?=
 =?utf-8?B?blBPQzhQSFF0bmdpV3dnWlIzRlc0UlNIb1ZCa3RQamtFbnBjS1N0WEROQ1Rh?=
 =?utf-8?B?M2FKLyt0UW16MHlRZ0dXZEk4clZOeERuditBallpbVVTVytJVjNUOGQ5VXBu?=
 =?utf-8?B?NWZFMTJSaWw4ckRON3NiekQraGFaOFdkb3NUc3lCMUloYTRyL2VkeWlUWWlh?=
 =?utf-8?B?OXgxR2hBL1VIQ01VdWJ6MHJQZ0xXN1dxR0Y5YXd5QW9SRG1vS05wZ0ZKYVVQ?=
 =?utf-8?B?V0tJV0dSbENoSk9Wa2p3dCtVZWkzMUdkREp6UzZIQlVHV2MrcmdYTzA5eXRE?=
 =?utf-8?B?dUluVjk3Mml2aWx0Rng3ZlRtR1Jwdzl6UzhMdkxQOWlmWXVjOEtUbldzb0VH?=
 =?utf-8?B?UmF3VWtXbTlpZlNLMHdjSHMrbzVuSUFoZ1p4NHVpRFNVdUlOakFUZ0ZhdXRl?=
 =?utf-8?B?ZXE2TVdqbGZsRmUwZHhnUFkxNWV3MUs1LzRlYWNyQkx5OE1QQXJFV05RTERT?=
 =?utf-8?B?eTgzajdoZEYwQ2twaXBiK3NTNEFoSXBTaW9YRXo4MzdIUk9SVjRvdzZrT2Ir?=
 =?utf-8?B?N3NVV00vZXp2N043RmFOUys1YW84MFYzUVBEanpsR21mWlZFa1dvVjFVOVhF?=
 =?utf-8?B?MWZDdm9Ic3hxWHkwdmlCeVZvWDFvK2QxbE15T2RlcE53TmxmdVZ6WUt0bTUz?=
 =?utf-8?B?ZXNaYzRWT2xRYzg4YVRUTWJzMWwyNTdKbzBobTRsR2xzVTVYeEpUQ0RMWnZt?=
 =?utf-8?B?Zm9kTmtCbmsra1RiejV3aTlRSHZWYitDNDNsaHpDU0FmdWY4cVRZSGkvSHo2?=
 =?utf-8?B?c3h4VlNQSmFJK1JzTWxlQk5jRzZlN3BMY2ozTFhBam1yNlQ3azZBS2FDTlpZ?=
 =?utf-8?B?U0htcy9yQTUyOVc3TTJ1Tk9MWE9mM1JFSUZpQ0lJK21WOGJjZVFyZ3BGT0Ey?=
 =?utf-8?B?NjhzczVOc1dLU3gzTnpVYXZVeUtjV2NWQnJUUGNsdmVvdzk2STRDclVieXdB?=
 =?utf-8?B?S3ZWbUVGSEdwMk9uanVSSDE4V2RWYVNuRWVzZzlrYTN5VVU0R2t2YmxQaU4r?=
 =?utf-8?B?SFZqaWlKSnkvVVVpUURtcVBsK1F2Z3IrL2JRckxDN2w4WUY0ZUxGUUhBMXlN?=
 =?utf-8?B?YTVCR1dCYU53RXZ6dEpDWkZpcEtSTGNNQTRxMmVxUmtrZE1UcFJ6Z1RReEdp?=
 =?utf-8?B?eTZ1OVl6NHRJWjVrbkprNTZXRkJLZjZqTjdVRkwxQ1NGR3l5OXB4YjhWdGow?=
 =?utf-8?B?c1RRNDlMbmR0WXg2aFhQc3hXQTh5VEdkNVNjenpRam9LNWRxczUzUk81c2R6?=
 =?utf-8?B?RVc5M3NyRDdiSDZ4enY2UjJKekxKRzRsa3BMdWVEQy9zQVVCcURnUFhvNlVK?=
 =?utf-8?B?eVZjOExSTk9HUVB4SVdNWTRzMS9GZk9TaEZwNmxVb1RjTTF1MHA2Tko4NDcr?=
 =?utf-8?B?UkpnQ3lKU254MHZHckN2S1FyVDlPOCtzeThYejh4V2tObHJlczg5QnRFWFhz?=
 =?utf-8?B?U1FHRXowQk1ZaTg4Q1JWSDhteDlvOFVUMDBnZTMvUEZTRWR0RWY0QT09?=
X-Exchange-RoutingPolicyChecked: AqYJaBSRk6T6v8PGUon7pxHvj3W1jBrvxTJ2ZTDT97XJlaK04EQgZcRrIZUCR44QdUvVMhlTUTm/iaZjC0HUBoZCELZghePMOF6LxbQ/31cBzjW8xbEvos54k86J/f8z/yY4wkTFvNp/FBGNCesrrdEX7r2pwafog3CSNcES81mgsz9bacEp3ghpU7UQM6oPrNSplGmveuRiAw/02yeHMQRUaHZWWN5ls+w0UecJ+nSCTgMpxIAsm7TsJ2vjTrU+fk343dR87urjKXivYWUxZNOY1VO3s1YX/LJ8ssDcul5hHF/87zBA+V2E81wUIHdNWnTcaqwzc4VBD2PBk8iXRw==
X-MS-Exchange-CrossTenant-Network-Message-Id: f19204a1-b268-4f17-1635-08deb7e21d3b
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8509.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 09:11:31.7508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E3v76T86nIRwQrJAwwqPNxHydwR8ql/VD6fd3sJoXqoN2+Jf9gj1hNgIZmgLcjeOyMPnPQvRl2ONwdttXt1goQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7767
X-OriginatorOrg: intel.com

On 5/22/26 06:11, Jacob Pan wrote:
> Now that devices under noiommu mode can bind with IOMMUFD and perform
> IOAS operations, lift restrictions on cdev from VFIO side.
> Use cases are documented in Documentation/driver-api/vfio.rst
> 
> Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> ---
> v6:
>    - Revert back to unified VFIO_NOIOMMU Kconfig for both cdev and group.
>      Use Kconfig dependency to restrict usages and avoid null group
>      checks. (Alex & Yi)
>    - Add CAP_SYS_RAWIO checks for cdev open to maintain security parity
>      with the group noiommu path. (Alex)
> v5:
>     - Add Kconfig VFIO_CDEV_NOIOMMU to select IOMMUFD_NOIOMMU
>       and its dependencies
>     - Add comment to explain vfio_noiommu conditional definition (Alex)
>     - Removed early return for group noiommu in bind/unbind
>     - Use consistent wording referring to VFIO noiommu mode (Kevin)
>     - Update unsafe_noiommu Kconfig help text (Kevin)
>     - Change dev_warn to dev_info for noiommu enabling msg (Kevin)
> v4:
>     - Remove early return in iommufd_bind for noiommu (Alex)
> v3:
>     - Consolidate into fewer patches
> v2:
>     - removed unnecessary device->noiommu set in
>       iommufd_vfio_compat_ioas_get_id()
> Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> ---
>   drivers/vfio/Kconfig       |  8 +++++---
>   drivers/vfio/device_cdev.c |  3 +++
>   drivers/vfio/iommufd.c     |  6 +++---
>   drivers/vfio/vfio.h        | 20 +++++++++++++-------
>   drivers/vfio/vfio_main.c   | 23 +++++++++++++++++++----
>   include/linux/vfio.h       |  1 +
>   6 files changed, 44 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/vfio/Kconfig b/drivers/vfio/Kconfig
> index ceae52fd7586..d3d8fef2855c 100644
> --- a/drivers/vfio/Kconfig
> +++ b/drivers/vfio/Kconfig
> @@ -22,8 +22,7 @@ config VFIO_DEVICE_CDEV
>   	  The VFIO device cdev is another way for userspace to get device
>   	  access. Userspace gets device fd by opening device cdev under
>   	  /dev/vfio/devices/vfioX, and then bind the device fd with an iommufd
> -	  to set up secure DMA context for device access.  This interface does
> -	  not support noiommu.
> +	  to set up secure DMA context for device access.

if noiommu, it's unsafe DMA. :)

>   	  If you don't know what to do here, say N.
>   
> @@ -62,7 +61,10 @@ endif
>   
>   config VFIO_NOIOMMU
>   	bool "VFIO No-IOMMU support"
> -	depends on VFIO_GROUP
> +	depends on VFIO_GROUP || VFIO_DEVICE_CDEV
> +	depends on !VFIO_GROUP || VFIO_CONTAINER || IOMMUFD_VFIO_CONTAINER
> +	depends on !VFIO_DEVICE_CDEV || !GENERIC_ATOMIC64
> +	select IOMMUFD_NOIOMMU if VFIO_DEVICE_CDEV
>   	help
>   	  VFIO is built on the ability to isolate devices using the IOMMU.
>   	  Only with an IOMMU can userspace access to DMA capable devices be
> diff --git a/drivers/vfio/device_cdev.c b/drivers/vfio/device_cdev.c
> index 54abf312cf04..4e2c1e4fc1f8 100644
> --- a/drivers/vfio/device_cdev.c
> +++ b/drivers/vfio/device_cdev.c
> @@ -27,6 +27,9 @@ int vfio_device_fops_cdev_open(struct inode *inode, struct file *filep)
>   	struct vfio_device_file *df;
>   	int ret;
>   
> +	if (device->noiommu && !capable(CAP_SYS_RAWIO))
> +		return -EPERM;
> +
>   	/* Paired with the put in vfio_device_fops_release() */
>   	if (!vfio_device_try_get_registration(device))
>   		return -ENODEV;
> diff --git a/drivers/vfio/iommufd.c b/drivers/vfio/iommufd.c
> index a38d262c6028..d4f2e2a0f2f3 100644
> --- a/drivers/vfio/iommufd.c
> +++ b/drivers/vfio/iommufd.c
> @@ -25,8 +25,8 @@ int vfio_df_iommufd_bind(struct vfio_device_file *df)
>   
>   	lockdep_assert_held(&vdev->dev_set->lock);
>   
> -	/* Returns 0 to permit device opening under noiommu mode */
> -	if (vfio_device_is_noiommu(vdev))
> +	/* Group noiommu via iommufd compat needs no device binding */
> +	if (df->group && vfio_device_is_noiommu(vdev))

seems like vfio_device_is_noiommu() implies group path, then no need
to use df->group.

static inline bool vfio_device_is_noiommu(struct vfio_device *vdev)
{
     return IS_ENABLED(CONFIG_VFIO_NOIOMMU) &&
            vdev->group->type == VFIO_NO_IOMMU;
}

>   		return 0;
>   
>   	return vdev->ops->bind_iommufd(vdev, ictx, &df->devid);
> @@ -58,7 +58,7 @@ void vfio_df_iommufd_unbind(struct vfio_device_file *df)
>   
>   	lockdep_assert_held(&vdev->dev_set->lock);
>   
> -	if (vfio_device_is_noiommu(vdev))
> +	if (df->group && vfio_device_is_noiommu(vdev))
>   		return;
>   
>   	if (vdev->ops->unbind_iommufd)
> diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
> index e4b72e79b7e3..6f0a2dfc8a00 100644
> --- a/drivers/vfio/vfio.h
> +++ b/drivers/vfio/vfio.h
> @@ -358,19 +358,13 @@ void vfio_init_device_cdev(struct vfio_device *device);
>   
>   static inline int vfio_device_add(struct vfio_device *device)
>   {
> -	/* cdev does not support noiommu device */
> -	if (vfio_device_is_noiommu(device))
> -		return device_add(&device->device);
>   	vfio_init_device_cdev(device);
>   	return cdev_device_add(&device->cdev, &device->device);
>   }
>   
>   static inline void vfio_device_del(struct vfio_device *device)
>   {
> -	if (vfio_device_is_noiommu(device))
> -		device_del(&device->device);
> -	else
> -		cdev_device_del(&device->cdev, &device->device);
> +	cdev_device_del(&device->cdev, &device->device);
>   }
>   
>   int vfio_device_fops_cdev_open(struct inode *inode, struct file *filep);
> @@ -420,6 +414,18 @@ static inline void vfio_cdev_cleanup(void)
>   }
>   #endif /* CONFIG_VFIO_DEVICE_CDEV */
>   
> +#if IS_ENABLED(CONFIG_VFIO_NOIOMMU)
> +static inline bool vfio_device_is_cdev_noiommu(struct vfio_device *vdev)
> +{
> +	return vdev->noiommu;
> +}
> +#else
> +static inline bool vfio_device_is_cdev_noiommu(struct vfio_device *vdev)
> +{
> +	return false;
> +}
> +#endif
> +
>   #if IS_ENABLED(CONFIG_VFIO_VIRQFD)
>   int __init vfio_virqfd_init(void);
>   void vfio_virqfd_exit(void);
> diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
> index 6222376ab6ab..84381c500623 100644
> --- a/drivers/vfio/vfio_main.c
> +++ b/drivers/vfio/vfio_main.c
> @@ -321,6 +321,20 @@ static int vfio_init_device(struct vfio_device *device, struct device *dev,
>   	return ret;
>   }
>   
> +static int vfio_device_set_noiommu_and_name(struct vfio_device *device)
> +{
> +	if (IS_ENABLED(CONFIG_VFIO_DEVICE_CDEV) && vfio_noiommu && !device->dev->iommu) {
> +		device->noiommu = true;
> +		add_taint(TAINT_USER, LOCKDEP_STILL_OK);
> +		dev_warn(device->dev,
> +			 "Adding kernel taint for vfio-noiommu cdev on device\n");
> +	}
> +
> +	/* Just to be safe, expose to user explicitly noiommu cdev node */
> +	return dev_set_name(&device->device, "%svfio%d",
> +		     device->noiommu ? "noiommu-" : "", device->index);
> +}
> +
>   static int __vfio_register_dev(struct vfio_device *device,
>   			       enum vfio_group_type type)
>   {
> @@ -340,20 +354,21 @@ static int __vfio_register_dev(struct vfio_device *device,
>   	if (!device->dev_set)
>   		vfio_assign_device_set(device, device);
>   
> -	ret = dev_set_name(&device->device, "vfio%d", device->index);
> +	ret = vfio_device_set_group(device, type);
>   	if (ret)
>   		return ret;
>   
> -	ret = vfio_device_set_group(device, type);
> +	ret = vfio_device_set_noiommu_and_name(device);

the order of dev_set_name and vfio_device_set_group() are swapped, any
special reason?

>   	if (ret)
> -		return ret;
> +		goto err_out;
>   
>   	/*
>   	 * VFIO always sets IOMMU_CACHE because we offer no way for userspace to
>   	 * restore cache coherency. It has to be checked here because it is only
>   	 * valid for cases where we are using iommu groups.
>   	 */
> -	if (type == VFIO_IOMMU && !vfio_device_is_noiommu(device) &&
> +	if (type == VFIO_IOMMU && !(vfio_device_is_noiommu(device) ||
> +				    vfio_device_is_cdev_noiommu(device)) &&

now, the group path and cdev path have their own is_noiommu helper, can
the two helpers be consolidated?

>   	    !device_iommu_capable(device->dev, IOMMU_CAP_CACHE_COHERENCY)) {
>   		ret = -EINVAL;
>   		goto err_out;
> diff --git a/include/linux/vfio.h b/include/linux/vfio.h
> index 31b826efba00..45f08986359e 100644
> --- a/include/linux/vfio.h
> +++ b/include/linux/vfio.h
> @@ -74,6 +74,7 @@ struct vfio_device {
>   	u8 iommufd_attached:1;
>   #endif
>   	u8 cdev_opened:1;
> +	u8 noiommu:1;
>   	/*
>   	 * debug_root is a static property of the vfio_device
>   	 * which must be set prior to registering the vfio_device.

