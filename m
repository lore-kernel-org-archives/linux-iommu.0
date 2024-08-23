Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBA444C76
	for <iommu@lists.linux.dev>; Fri, 23 Aug 2024 08:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724403253; cv=fail; b=P2fSIQ3tdVPrjnq2k8sgg5E55TBmTr+cOQh5RwhC67lC/EtbqSyZDN8NMvyiQdbmOLdoG1FQPo/AJ6u/muJz0EkzYneV6NXpruW0MotssVYeYmkK4EpgnKOP8rGy5+rNkUqm53hkF7X6VObCYQMrTdkCQ7PSM+9WJum0JR7Idho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724403253; c=relaxed/simple;
	bh=+/lCo6AneQYcC2snzUGz2/ekiOt+XDuBzSdfYpCOcS0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Be0V+hedMHCb5SHv9naf1gR9SPJmWIpgSJVdbasSb39o7e1yUM/U+YcWhSfjpMnWlLAz3IouV382uEvFLNqt0vzcClYZNZodYSf6Li6Cr9DsnErwA4hZfmteJzTnqKefplSG1+mbp5v8MR3cxQyCeQWPWXcWlE0+FlEp1ZNWB1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S5+MP42x; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S5+MP42x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724403251; x=1755939251;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+/lCo6AneQYcC2snzUGz2/ekiOt+XDuBzSdfYpCOcS0=;
  b=S5+MP42xwr/xNwsqyA3VHBpo9mO03la6OeAovw/yB9WejlUe+WKP+uDB
   JBIONuMswnAp7jWnX4rlQ3P7ZfMKBWp4AeYhGa5pXsV50GOuHxYmyF1RD
   3ljpWnMp4OHqWiZrHvH7+vEqK2fFfS+6nUjFTq+bosoO3YsPNN5lP+1Wi
   CBm1HJ18ZVjIh4PmvnYpj4l28004OTxLeL3AJg4WS9hEeSo81xtqOmnRu
   MBHjUIuWfLsdVa5kU8HAJV81yhCJK/o/pWuEMeFM/XqMLoYju5We1HSqY
   FqTvNh/WsL+luRx+83CPLwp1t/3g3EcnpYRLnuTJfQ8M4bwJorTRdSGRE
   g==;
X-CSE-ConnectionGUID: Kv5QR2F/RyShttQcmV+FBg==
X-CSE-MsgGUID: law/LpbbThWtCF8PA2qvGg==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="45380767"
X-IronPort-AV: E=Sophos;i="6.10,169,1719903600"; 
   d="scan'208";a="45380767"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 01:54:11 -0700
X-CSE-ConnectionGUID: x9FIHgN8S/iv+zPR57IwbQ==
X-CSE-MsgGUID: PNsytnfeRc+buU7x9Dschw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,169,1719903600"; 
   d="scan'208";a="61437285"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Aug 2024 01:54:10 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 23 Aug 2024 01:54:09 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 23 Aug 2024 01:54:09 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 23 Aug 2024 01:54:09 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 23 Aug 2024 01:54:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AdIzt37a7FTQtbv9viMxI+XXrRGIKUSG8St/B6P4UpwomqVvlawQKy8m7lQUM0Q6oMTSfQFrybcJCLAqaTvbK7AXo4vuWnm47gZQElMZ3N0L3kuNQQd25BtCNAIlmTEK5Iz3L1y9T1Zjbv1Suk7mnPowlq96sxGb90vngdKMeq1YkC47UkpDG2vQBUfmct/KTrqv5T0VgirWqjf1rIAlgKuME869wsi3/Y/MX+DuGLxDAV1ZpmZNhILhOkgEhT0UzYMuQNdDghRh51Phy8lt4RvB+yWtu2wHjIMZAubFLk9sqaZCKsUVUh3KndZ5L3Bp5Y4XehzulXYDpMh5iF6z5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1rGRXHAhWBow4QxBzlAVjNXAsZI7NM+BaDCGmRT/UF8=;
 b=fxi/c1QhsSWW1PkmzI6kTQjr3NmI+RSdCpkohlaqevj292tRRbbIdZcU14ZqQC5BpVjpgVpb5AH+INYWqoWJ0r6OZsc4eO7hUEACk52ZhEL8QArDDcsq2TASmed4jWUY0ntQt1G6boDTNnZVCkFL8xGdxq8tleiLON2qyiX1VYVrRCO34oyavdUQ+4qqHCPucpA/v2c4mUUfUtDtOJw46i08zr4XH2/JzUGRPLBVF2yilfGhyB/OHkQR0HlR5hH3m865nSpORjfkgNCJW98sHxlZN7294KhAlLQ1CwpXn5cz9tynHfYL26cOBaHp+Q9i+/X1ABqWNNj5umBMfwYSwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by PH0PR11MB5030.namprd11.prod.outlook.com (2603:10b6:510:41::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.16; Fri, 23 Aug
 2024 08:54:02 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.7875.019; Fri, 23 Aug 2024
 08:54:02 +0000
Message-ID: <0ca31cc6-1741-40d1-b8c1-20e6b4fc955a@intel.com>
Date: Fri, 23 Aug 2024 16:58:16 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] iommu: Enhance domain allocation code to take
 additional flags
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: Vasant Hegde <vasant.hegde@amd.com>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <baolu.lu@linux.intel.com>,
	<kevin.tian@intel.com>
References: <20240821133554.7405-1-vasant.hegde@amd.com>
 <20240821133554.7405-2-vasant.hegde@amd.com>
 <20240821163147.GZ3468552@ziepe.ca>
 <67436cba-3d05-4528-9519-231b8396ed51@intel.com>
 <20240822124433.GD3468552@ziepe.ca>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20240822124433.GD3468552@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0019.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::6)
 To DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|PH0PR11MB5030:EE_
X-MS-Office365-Filtering-Correlation-Id: cd17179b-525e-41a3-62f7-08dcc351225b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UWFteG5rSkN3NURDUndCU3R6WnRxWGN3YzBrQUkyeW50c2NBa3NzdFlBb3da?=
 =?utf-8?B?b1BnUkJXeGlSUmxmY05jT3FLZVFWWnN5QzhtYjlCTTJ5ZjExQ0l2RjNUYUx2?=
 =?utf-8?B?MnAvMmUxcUdXb1B4dWxZcVRHbUd3ZnBycDFhb1AwSWhEeWZqellhcE5uRjA1?=
 =?utf-8?B?cFEzY2NZMzg3ZDlLWUsyYkRSUVFVdkZnazgvZVFEWnFxMDJHdVJKVWpiWmg4?=
 =?utf-8?B?T2xPRW9iV0FyRVlnVzJ5MmZYN2I4OXBFN3V5VTkxZFdxTjRraDdLMnd1OThh?=
 =?utf-8?B?Qm1neXJPb1pnMFU4bHRUUFJXN0w5QTQwTjBSREVLVEdEOVBWcmRWd2xnL3Ix?=
 =?utf-8?B?OWJnV1JRZmdyRTBUVG9Hb3piRG5KUXhSQWZFVVBtRnQyRVhxdEFCQ3VNeEVM?=
 =?utf-8?B?RnVxazdyQytJYVRacGprUVpaQ09FMlJXOUMrU09EQWxweW43TEtiM2x6bmdL?=
 =?utf-8?B?SWZmMGtzdU9xMzJHVW8wUFZlL04waVpJZTFhYWNmd3RFclJ5dnYzL3ZySTBu?=
 =?utf-8?B?UVBtamZVc3VYcVZGVkoyU3lzZ1NPbVJXQUFQV1dObld0dGxkNWo5MFkzbGlS?=
 =?utf-8?B?cVExS0RuZUliUi8rU2J1OUNFcU1mN0t2ZTVVZHF4VzhNeTQwTU5xYWtZRHlt?=
 =?utf-8?B?Nk83dE40ZTNlRnp4VkZaUlVuSUozY1ZOTlByM0FuV1A1a3dYREFOT1lnVlVl?=
 =?utf-8?B?L2puaDNMblA1aGF1QXNPaER2V2U3dGIyTWNQaCt0MGNFZEc4d3pVN0RiWjcw?=
 =?utf-8?B?N2JPYjJjUXAwbzJxZmtqRERKVlVlY2pPazlNOFpma2hYNHZ4dGtkdGhCcklD?=
 =?utf-8?B?d2kxTm44ZXlGV2pSTXNpM2ZjRWlNY1JYcTlXVFkwcDlCKzAyUnFPWXdoY1By?=
 =?utf-8?B?Wm5XL2d0dVF0bDF3NklFYTBBUmY1VmkwQ3V6NWVPODhZVHIzbVU2ci85Wmwv?=
 =?utf-8?B?MHRmdVB5UExpaFZ1ckN6TlVScU9jM25VZzltTE1WYXZmV3ZoMGgzcGRLd21W?=
 =?utf-8?B?b25zdWV4L3grS0RNQU4rb1JENmxNbm0rUUVXZjFsZHg4cnBBNjRPQlU4bHJn?=
 =?utf-8?B?SVRWVzRPelV1S2N4ZnlWeXVwMWZhOUlJTXVraGhRQ2trQlFacjRXQ1plL05Z?=
 =?utf-8?B?UXZ5STZjamFNV0JEYk9KS1NzWTlON2l6aE1YcTNqSUIzMXkva2FMR2lmWHNJ?=
 =?utf-8?B?RjRTNHcvNFBNS0NCVUx2ZUo4TlA0ZGw4RXlzMFNvSWhtL1RaeHJWaFVQWnQw?=
 =?utf-8?B?Z0JlS1phQUVpMzFsWGVnNnVqalFmRFZFTEk1VGJOc0gyM3FQYy9haGpFakVL?=
 =?utf-8?B?U1o0ZXViajVtOUJTc2xsLzRWS2UzZENaWXg4Uy9IMWw2NWtZK0Z2YWxZS051?=
 =?utf-8?B?a21sVzJPdFVHNUJmakJyMUh3U3RDOW05TytsaDErUnl0WlhCT1ZwS0E2TWtz?=
 =?utf-8?B?Y0o1UVF2c1JrMDRGeGhZS2hEZTRna3lIK05jUUxUSi8yYlZ5OS9nMUlKVkNX?=
 =?utf-8?B?MWRhUHNzYktZU2R1OURZc3JwckkvN2x3L1FVZzNCbkdZeGFCSHE4RVpteEY1?=
 =?utf-8?B?ZldwaG9IN3o2NkJtaFltckNYSDNPa3R1U3hncXJGS0JOR0hrOEQ3WS9hWTdS?=
 =?utf-8?B?UmlIcGhIY3NVUkhhb0xaV1diS20xTFJJN2VOSTBpaVB5UDJIdWdmTVV6VHlJ?=
 =?utf-8?B?ZUZJazRBWHRERkdzSU9SY2srczFrdW03R200U2doSld6Q2JoU2tWTXBXVkpL?=
 =?utf-8?B?TUtFV0YwK0VQM3NLdnlSMzVnaXNLbzZCZ2kyRENvN2FLNTFGQit2NmZDQjlH?=
 =?utf-8?B?YWJsMEdhSE80YnFOZWxzZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3d6Q1lWZUdBQytkWXBPL0o3NWdyUGdkZTFvZ2pNbVVhSkg5anJ4SklPdDlU?=
 =?utf-8?B?TVpXL2E5emRFYzE1ZlhVTTJic1ZFVTQ3THpQUnZCTzdrNnJGMVJjVzhZblJY?=
 =?utf-8?B?ODBlc1loOVFuVGowbEx5czM5Q0xpOWNOcTYxME8xQ2NsZ094VndGL2pnRTZG?=
 =?utf-8?B?eEc5YlVqcW8xVHQyaExpYnpSUzgrdFNrNFBJMHpURy9XYS9URnBxbG5aSE5w?=
 =?utf-8?B?Y0Y4S0Z2Y3dDYkNNeVpjazRtWTJ2aGx1aVZ6U0hHRG9jWkdQK3FRaGlBOHBw?=
 =?utf-8?B?U0lWRzJQL3BncE91Y2xDQ0k1YnZVMG5IdXQ1SnNGeDcxaHFBN1pjR0RHd1B0?=
 =?utf-8?B?ditvekE5bktHZFhuSXVjK0lTTzhaMFM1NDUveE5najJnSmlHbkRBaFlxYlF3?=
 =?utf-8?B?WTd4cU9ScnFTbllUUXdtTGRaWDI1Y01TUG5XRUZyYkJWQzBCQmE3OUxTbzRV?=
 =?utf-8?B?ZjA3bURZaEtsbUMzTlppbGlJSGZrWkQ5NkRublhQYjR0RG5YSFZyS1Y3QVhP?=
 =?utf-8?B?V1dPN1QwV1p2eHB6eXJTOFB6K2ZIOEs0aVZpb1FaREhrWGQ5b0tGbWM3ZnI2?=
 =?utf-8?B?d3pkSU1LUUp6RUs5T0NQY0pncTFhSHJsRDBXamhYR0U1V05kUVBXbEFZUGs1?=
 =?utf-8?B?ZFloM3BidXhRa3hIOHh2RnVmKys2K1pvbGpuczJtengyZXdhbDJ4MXhlR0ZJ?=
 =?utf-8?B?aXBvUEY0cXdjTiszSGRCRE00QkFVdVhjV0Mybld0UUFuWkdiMzZMSTNINmhH?=
 =?utf-8?B?RWgrdTVsay9GaHlXVm15aWxaMHRlZUlrM0htYWJDRmFhd011YjNPSHltdGtk?=
 =?utf-8?B?Vmc5Qko1TjRXbzZFQnpIWXpOTXpkRHdmcGY5aDlYS0g4eG1HQnU4dWFDelA0?=
 =?utf-8?B?S3gwV0luM0lXZFhBRVJNYmxaQnVBR1EralUyM2hDTTdvUFBIa1cwbklONUIw?=
 =?utf-8?B?VXovRFlyamlxS1NiVHE2MEpDbWcyNTB3N2M5MmhOdWJNS29sYllzekJsZTFk?=
 =?utf-8?B?d3NsTHhteUVjOWRBS0NnWTUxdi9Zd014dzQxUEZVbHAxWXRLbTE5ZWcwOXk5?=
 =?utf-8?B?RE1xWUV3NGQ1VFFSUFBCL1ZxbXM2NmZiNlAxVXRsTDRwTTNkNWtqdytmOGgz?=
 =?utf-8?B?L3RMbEZ3ZHhuSFhNOFJxTDAvOGNwRWlmOVE2MTYxOWpZZzVUSEVqTUc3Q0E1?=
 =?utf-8?B?bHJ5L3hpUlMvQUZHN1Bvb09VRE1qUGhZOVdUUnZlTTFMTUY4NFY1M0p4Z05F?=
 =?utf-8?B?MkttTlhZRlVYWXBNRFNQbllUQVlUUTFndHUvSzZ6UWExMGhEWE9OVCtXYWxG?=
 =?utf-8?B?cWxnSzVsZnJlbnROOXE1K2pCaS85UzZNem5VeFRFVjhOWkdORlJJOVNJaHFJ?=
 =?utf-8?B?Q05rVHZDdG5maUJ5WFBOM24vdlBVUWFWRTlxd1RML20vN2lwOEVLdUtvU05n?=
 =?utf-8?B?QmlCN0dMNkpYV0U0a3FoSHBzQXFsUjBCbWtDRWQyWTVKRGUrTjdEeURkTy9G?=
 =?utf-8?B?cFdTV3NNMXl6TFFxdHRFSVJ6UGxaamQwaTRFMnM5cXh1SVZDS0FlRlk5Q1pT?=
 =?utf-8?B?WWhBb0RnQ2dLdkhNYktCT1BGcWlISE1WZUtuTTE0UlQzNWV1UE1FMlA1dFFE?=
 =?utf-8?B?Z3FuUTJDcnZXazdEb3VzMXdmK2lKeGZ0VkxYNXhmTFBMWjRGdEk0TU1kZjVI?=
 =?utf-8?B?N1pvZEVYVWR1RXJaaW00RnVINVcwTkpCYlN3SlZ0dVZ3K3dRQm5WYklMSURH?=
 =?utf-8?B?OFlxVThndFNNNTRlQi9Ea2l3TjdVREpQSk11ZUxSeVVmaDRNelNaajFxL2cy?=
 =?utf-8?B?cm9LSFpYd2lha24rY2laMVcyZFlYTVc3T2FJYTdnZzZUR2tUSFhqdkYxeFBM?=
 =?utf-8?B?dU9FczVvSGp5NUZJT2VoVTFpTzdEN3VRcFF2M0V2R3F2Wld3a0tFT0lWcE1N?=
 =?utf-8?B?clJLZkFIbGpaNkhpbFR6RHdtcnFLZkxHSTdYRmVMaDFXMkVWVDY0aWNrTGRy?=
 =?utf-8?B?OVdsZzZ6dnlobkVOZm54eGdqNzBiWE1HYk1wOFZrQkovTHYzTUFKMmM5SURO?=
 =?utf-8?B?a0F5dHplV1dzanpZdk1HVkdIVm5Ua1N6QmlJbVI0WjBWTkNVTzF5SzdrU2JG?=
 =?utf-8?Q?ctT4jnmCb9VkbS/zbMnpOoK7E?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cd17179b-525e-41a3-62f7-08dcc351225b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 08:54:02.1938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QswKA2FA8M5pIQNq+kXUfM8MwPZgOdMdgRHOqxkIj5l9RRdj4/KPt78S7paKvxOOxmJtUlVjrU8OXX+yuMiinQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5030
X-OriginatorOrg: intel.com

On 2024/8/22 20:44, Jason Gunthorpe wrote:
> On Thu, Aug 22, 2024 at 07:27:39PM +0800, Yi Liu wrote:
>> On 2024/8/22 00:31, Jason Gunthorpe wrote:
>>
>>>> @@ -359,11 +359,17 @@ struct iommu_vfio_ioas {
>>>>     *                                   enforced on device attachment
>>>>     * @IOMMU_HWPT_FAULT_ID_VALID: The fault_id field of hwpt allocation data is
>>>>     *                             valid.
>>>> + * @IOMMUFD_HWPT_ALLOC_PASID: When the domain is used on a device, with no
>>>> + *                            PASID, the device will support later attaching
>>>> + *                            a PASID as well. Some HW requires a specific
>>>> + *                            domain format on the device to allow PASID to
>>>> + *                            work.
>>>
>>> Maybe:
>>>
>>>    Requests a domain that can be used with PASID. The domain can be
>>>    attached to any PASID on the device. Any domain attached to the
>>>    non-PASID part of the device must also be flaged, otherwise attaching
>>>    a PASID will blocked.
>>>
>>> Yi will need to add a check that IOMMUFD_HWPT_ALLOC_PASID was
>>> specified on the RID domain while processing attach on the PASID
>>> domain.
>>
>> this means if userspace wants to user pasid on a device, it should allocate
>> hwpt with this flag, no matter the hwpt is going to be attached to RID or
>> pasid. is it?
> 
> Yes
> 
>> I still have a confusion. Say on AMD, is it a legitimate configuration that
>> the RID is attached to a domain that uses V1 page table while pasid is
>> attached to domains that use V2 page table? From architecture p.o.v., it
>> seems allowed.
> 
> I think that is exactly what they have been saying their design cannot
> do.

ok. I don't think Intel has this limitation. RID/PASID is free to use s1
or s2 format page table. So such enforcement is nop on Intel platform.

> 
> If you want to use PASID you must install a GCR3 table full of V2
> tables. Doing this denies use of the V1 format for anything except a
> NESTING_PARENT.

thanks for the explanation. So if pasid is to be used, amd iommu driver
just programs the GCR3 tables and the request without pasid would use the
v2 page table installed at pasid#0. It does not use the
DTE->host_page_table at all. I remember the DTE->host_page_table uses v1
format.

-- 
Regards,
Yi Liu
