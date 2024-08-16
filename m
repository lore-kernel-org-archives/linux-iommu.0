Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5853E8289A
	for <iommu@lists.linux.dev>; Fri, 16 Aug 2024 11:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723808755; cv=fail; b=RYbi74HGj7kJL4hxwKbguIcALT6JjzXG6TD0XTYurWpaOcCR5Tm+qbxrL8jGuKCWQuobR30o+jTWKGl+Hhlapu9dDhL42sryioKFV8k6aCoe6+TKVuNzPSSaE7Nrx1Sfa/VnVxfyEwKm2cwjxkIay8ojnL6hxspJt3qdOPFvtNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723808755; c=relaxed/simple;
	bh=YbeeXe+PgJg0ogxZfgBSXLpsIfysuTG979R3tw4M678=;
	h=Message-ID:Date:To:CC:From:Subject:Content-Type:MIME-Version; b=sr1lBPkwIQINWIqJ2Zy5KJD9M+TRZ+OSzyb/9PY1Pa7dAQxOIuSUXc50B8DYc6r8LlEYNsDpuKRlKdVoQsRMbP9GbnskyrUVBKhVg+UPben5oTIpzjXph2BY27DT8q0Bw7+4/szgPCWqVxk6Onpt309D5ZKJ2phwndd0GBGqHB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PQCcpSwl; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PQCcpSwl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723808753; x=1755344753;
  h=message-id:date:to:cc:from:subject:
   content-transfer-encoding:mime-version;
  bh=YbeeXe+PgJg0ogxZfgBSXLpsIfysuTG979R3tw4M678=;
  b=PQCcpSwlh8FwUh52J0uWRXH6uEkaGtVYVpyG12uaJYD72rWEmF0fQKQm
   SnCqXBvZOcufNdzDZ5ifIboDREytCFZ8QcoTTiK9EBy2YlLXCnUmHQ0qo
   2bHyUnKlTVvBDHQ7yCM68ngUzFUhfMINggaVHiQI9KEo2B+LpCX7ly6/w
   O8uZDSSe1KgDNenJoR1xpf23MB0PIjaTrEggOC/+Lolf2Me2be9q2DNBK
   T5ItDIND+L65EvmKcF8QmeW+Y+hpmzRjdjQVw07eNNGtKBblitgcGTBxv
   Y7huNtS2oti3PXJ6yfHt6WeMTTjYOZvAplIGwdkiN+4NoLe0aijbnWL/D
   g==;
X-CSE-ConnectionGUID: JCZyXFAsSAmFtCHOzrIqrg==
X-CSE-MsgGUID: LhPcrxMRRCu7xORVdI61ng==
X-IronPort-AV: E=McAfee;i="6700,10204,11165"; a="21957752"
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="21957752"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 04:45:53 -0700
X-CSE-ConnectionGUID: u7H5rXVCQie/DtbIMtHc+Q==
X-CSE-MsgGUID: lTauL1yGT5S6S9+rScQyyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="60438258"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Aug 2024 04:45:53 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 16 Aug 2024 04:45:52 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 16 Aug 2024 04:45:51 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 16 Aug 2024 04:45:51 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.42) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 16 Aug 2024 04:45:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s5KHc20Glwk2+cswQeH8G4DfA4Q2pKKypbBNlpQyGVAka99kO+TXrYnvD9TYx43uVx7MuqNUZBRw3wwZ8kyBwuC7hhKpTy+j+Pd06UQdh7xVi7+CUY50PZeVph6l2WF659blbY1f9SF6uVWoi9xuPttAR4iVQSaM88PC5qwq02IQxXRlfX0mB9llyyPniP1LoznStXeNp0aqO3c3IhkRgb71knBoPiLEF1T/5JGh6kXpK0ksYbVw5SttU5KalPhPv+BjA0fbkUlCCtDX51iFlovKe8Z4UCD0BCT/dsvIQR8xIt3lcZmTFnanXesamadGvnX04+FgX1TJJ1GUF/Wzsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7qHTVQL6e0+etx7J5q4K5fTp4OC6WjBkVDiRkGD+4ZI=;
 b=h5lBfCLqN+D7Rj/CXYVCxeZS8bIMJwz8CsKkSARsgPkTTRTytuqnZVcoqiekMjnGuI70DEBtyfmD9yJ4jUhizvKEf03I3P/dSCORKmP1N8XSv81O/TW0ChklPKk6l+OJABQB4zczZoxRnkKjabjPxzcdIor8MMPwhS/C+jx+YPtWfVnLOHV10O0p83ZhD8U6NuXKbnmAvIvLIVtB1ORAkJRqX7Ntyp0Tp/5FIC+mIXyIHMa1bnd01ClXwgVT1fVgbv0QLuWWvXAQUbnLIRxsECbzIA4bk0x+MxvL9FV9393Docb90NutXG1mrkA0ISwuVChcqR19U63peFMLiYIwNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by CH3PR11MB7201.namprd11.prod.outlook.com (2603:10b6:610:143::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Fri, 16 Aug
 2024 11:45:49 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.7875.016; Fri, 16 Aug 2024
 11:45:49 +0000
Message-ID: <0bf383b7-ed96-49ca-b1da-d1fff48e161a@intel.com>
Date: Fri, 16 Aug 2024 19:50:05 +0800
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, Lu Baolu <baolu.lu@linux.intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>
From: Yi Liu <yi.l.liu@intel.com>
Subject: Two opens about iommufd pasid + IOPF
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0172.apcprd04.prod.outlook.com (2603:1096:4::34)
 To DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|CH3PR11MB7201:EE_
X-MS-Office365-Filtering-Correlation-Id: 981bfc22-be97-4f5e-25cb-08dcbde8f95a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MFF5OWtSRU1JRFVIVzhUcVFudXVaVGFRcHk0MHd0RU1yUzlNRjVuY0thTm42?=
 =?utf-8?B?WkRQYTNJSEo5d2FibVptMTl5V3NMdUFyMXY3Slg4Z2dFV0h6SUY4dVFFVjZv?=
 =?utf-8?B?MUxUaWZhVVdYK2kvRjFmNWxUNWZqOE9sMHp4cTlSUHJYNWRKVDdBWUNhd3l5?=
 =?utf-8?B?OEZyMlZ6aXZ5VXJKVUc5dEFyWUllZExGdmpKZnpaWHdVODZsMDlnMlY1NUsy?=
 =?utf-8?B?SHRnZFlLYU1OU2JPVUgwTEZlVlRrdEFzVjViSUFvU2JxV1V3Z0E1dm51Vkc1?=
 =?utf-8?B?eE9LeWdrRGdLbXFWQ2VHNzkwT0I3SWJKbkxpOUJlQ21Zd0lsMVJaeUQwL1FQ?=
 =?utf-8?B?ZUo4N2k4aHRMazlDSEpuaTgrcE9obzB5cU5RbU5UK0R6RXJ6d3FJVjFOcXFD?=
 =?utf-8?B?TWZrWUtRODRqckk0My9ZbGFoZXJKT3JtM1AyNEtTZzlKdXJNUThWcCtPMmF5?=
 =?utf-8?B?Umt4Y3JtRWo2V25RcVQyVjZ2QjJCenE2ZmJVWVVLUUJxU1c2ZnVMU3RRejhk?=
 =?utf-8?B?UUcxTW5mcUd2RXJTcUhVQnJTWWRiK0Z5WWg5OVppQzM2NUl1dDZwRDNzWDk0?=
 =?utf-8?B?bUxNcWlvSkN4ckk3NmZ1RkJtOEIvaHFxa081eXhZcFZLbzFHL1RwcmRZMXRM?=
 =?utf-8?B?SW9UeGpGa1ByYkpLYWdYdjQvYWQrTFJCbmNWeUFQeWpSRlV1akxqcjRCK2NM?=
 =?utf-8?B?K2N6NENiVWt3elVHVnFndktRUGJ4S0M3TnhobXk4aGRxZC94SVF1eDBqSGdB?=
 =?utf-8?B?ZzlDbSs2ellyZTlSODF1Yzh1elVxTDU5ZTNzYktjaWJDQlZNZWJjSmZYcHFn?=
 =?utf-8?B?ZlkvY1pYRzV2UENxU1NXcmsvTm5PYTMwSlFjMkgxcys0bmlqZmxlaUpiL2F6?=
 =?utf-8?B?Z3lZS3grZXYzckRDSUNDN0xiMHYxczR1MjVGNHMxV3hKQnJsUVFnVHo1dFl4?=
 =?utf-8?B?RVk4dW44emZ4cWJFQTJTSVdqVVB0cDNVdkgvSW1jck9IRGdlanIzQUtHZjJl?=
 =?utf-8?B?UXpPNVNsVFljWW03VXdhQ3lDd1ErcmVYK0dWNWhtR2NOY3VKWGU4dm00dlV0?=
 =?utf-8?B?WjhKVWt2Q29CTmtKOFFLZUExeVRZQklVUVNXcm1VRGk5VmVqQm9MeExUK1N4?=
 =?utf-8?B?RXFoT1lvYUVPNnVmZmNDWlBuNWVEYSs5OSsxcldVenhCSXNEWE9uZHF3WFVz?=
 =?utf-8?B?UlVDaVRtdkh0eVBySUh5S1FOTEVJeVQ2cWYzNVI3OUYwS0MwWW1YbmlSMTFn?=
 =?utf-8?B?L2N3eU5xdGt2aGdkZEt1R25BZU5vNkd3V2xVQkRwaHdyOUtmcTB1cWVpZGVx?=
 =?utf-8?B?bGhEQUEyK2JjYm1MK3JrdXRjRHBHbk9aMWJMdGFlRFVpL0VsT3Z3MnBxVkhW?=
 =?utf-8?B?aS9WUDBzUXdDRzFXdW8xVjB1bzY0YVdrN09CWjNETFA0TDBuWXhVVnVIWXJ5?=
 =?utf-8?B?QmxpU2gxekptUmpzZVl2T3NMWDFlR0VUZGNHTjVVSkxLd1cxdU04cEVpRGZX?=
 =?utf-8?B?bmpCWUMwaFNaUXlNRXdhNnk4b2dRYmthYk1yRnB3ck1JZ2svV3JMUUZWb09i?=
 =?utf-8?B?M1JOTkQ1bDZhVnB1Y3NlamlMalZZeGMrSkVZb3p3YWlVYVVtMkQzVmFPVlJn?=
 =?utf-8?B?aURYUFcyZlNVRFE5bkpKVFJmdUUxQjd4bHBTQXg4NXBuTENZcHZPd2pFZEJw?=
 =?utf-8?B?cjFzT0NDaXFiTjMybjIwTDZMNEhWNEtvWUVEYisvYTM1dU1Td1BOSnhQVFk5?=
 =?utf-8?B?ajNQZ2R6Tm1YVlpJYW01VlgwQ0NuRlVwQ2ttNTFOS0dxRXFYMkdBS1JvY0VY?=
 =?utf-8?Q?2xDiZWEaz1iGM2GZRGaMvKE+WA58LEjqRWCw8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vk0zRklad09EYm5iRTFscnNncDVYaUVhZWNCYjBVaE1weVZlWld0QUtYbHB6?=
 =?utf-8?B?SzVwb0VGQTdVb2Nnd2lSMjlBY2EvbHUxZGhtQlg2dkJnc25TeXBFVDJDSXdq?=
 =?utf-8?B?TlJZd3NiM0tBbVdrL1Jkcm1oZCtTa01EZGpjbThlU0ljcUJzd3A4RlRvQldn?=
 =?utf-8?B?eXE2My85OGtlYWlveTZoNUVRaGw4V2tjVjA3aFUxcm5TYnpnOEhaaWZtNm50?=
 =?utf-8?B?SE9UT1NsS3dPNm5VZHhqbE5VSVFONUM2REw4d0xXUzhManBlczRHSTlNTk54?=
 =?utf-8?B?OVhObFRKVnRYNExEYXBnd3B2eVN4bWY3NkcwOXJVQzNUWXZoaDZtQTRSVWQy?=
 =?utf-8?B?NnhMT3hWam9aVkRoQjIySC9pT1lBNG5HUVNBUXNzUE9HYTVDVTM3RkJEaHRk?=
 =?utf-8?B?OHlvcTM0eFlwV3NNbXVCMmhHZjFSc2l0OEdBOTdDckN0b21SODl2L2o3WCsx?=
 =?utf-8?B?Y2RzNnJlc3VMcW1BSmhxd3o2Qis1NVo1ZlVnTTN1SXM3KzRGbzJ0WUNCbDdT?=
 =?utf-8?B?WktwQzN4bWY0QmsyOXkrWWkyYUhhLzI4RTdKdVBWeEZteGE3TlhJbGlIK1VX?=
 =?utf-8?B?QktDOGo0QXcwRHNudmdsNkFvamh2aElPcjByZ2ZNMnNhZGd3ajRreFZ4OWlq?=
 =?utf-8?B?aFFuTklLSzRsdHkvOTd1L0d0MGVycUZSTWhBelV6cDNCdWZWc1ljUnRYcG9x?=
 =?utf-8?B?MGVNbVJ4Vkl1S2NRV2c5R0NBLzdLd1lyblRHTmVVMzFtdWRnVGJxemo5SGlu?=
 =?utf-8?B?a1hwY09rcDBQOXNqUUlhK05jb2V4NU51UFVXaEJwUlJVWjlkSmNWQWtOelFJ?=
 =?utf-8?B?VEVOcTFSMTF2TE5GZWNXT0xoSWZxcUdMeVM0WlFKaGh6S1RWb2dYNVVIdDZ1?=
 =?utf-8?B?WDNBRGpNYTEvMFdWc2ozblY1MFNhL0EyUmkzZFJpbXJBTUJPaWU1Nis0cWx2?=
 =?utf-8?B?bnFlamtCVEx2cTFDVms1bXVoZzJlbHc1UnZmbENMNnNkK0R1c1RncGViYnNB?=
 =?utf-8?B?aWRrZzM4OWhaQmlNclZNdXNCZW9QVjI0L1VYUGlSUzVTQVliaVN5b08vUExH?=
 =?utf-8?B?WWpSbnE4NkJmTDlEWEl0NGVxOTNjbXY5OHVPTmtxT2FPUXBZekgraVljazBJ?=
 =?utf-8?B?czlGempqcUJUTSthTXNSOWttSjdrdjVkNjd0QWNxN0VpZm0rd2Q1TDN4eS8y?=
 =?utf-8?B?ZnFiTndzRkwrQ2Z1RXVwN3BML3lDRzBTakF6K3lleG50V0ZtdGxpNGsvMzVB?=
 =?utf-8?B?ZlBGTEgva1F3N3pZaWcxRllQSHJ1WHowYUtPdW0vUjJjZDZJakVGc1BCYWJv?=
 =?utf-8?B?NjVpVE5lRHlXdG9qV21VY3Y3elV4RFhYK2lwYzF6aUtvMTBXdlh4eVdRY2ZH?=
 =?utf-8?B?THVXNkRjaE81S2x1MDVkSVgrT3lubWhubVhTVSt4U0lsM3h1MXh3RW9lVWlj?=
 =?utf-8?B?VWRXUVo4WG9SdXpLTUQwaXB1Mk9SbWk0RFFTU2V5NlBNMWJxNFg5bExVTEZ3?=
 =?utf-8?B?VkFxSFNMUkl3NjFETVMwZXRMVS8xRlFLcUYxbGNZek9JM2NjTldMTUcrUzZU?=
 =?utf-8?B?YVZVK2RVelBuZlJPNEwyNXRPSGJOTVgvNURPQ21FT2JjUXE2UHhXTTVZU3dC?=
 =?utf-8?B?Q2V0aFFZMGxCTUpYRld5c0lzWlRzL1V4U2F5SzQ1VU12ZzhhcHVJUkZoUHlL?=
 =?utf-8?B?TmZXWWx1c2dyVk5DdllrYmRxUnM2blBRSDR0dVBzenNlaVpNU1RTdkF6SzFK?=
 =?utf-8?B?Zy9UTml5d3RxQmQ3aGNhd3BUL3pCem05eDlKQjVVNjJyT2hoQzRhNnV3aUtF?=
 =?utf-8?B?MmdDZHZnczkyamlIUUxieTVNcXhZZStBQmU3bDYyMUV6a29sZkpNWEJZRkkz?=
 =?utf-8?B?eWMyaGZXeWd2dEdqK2lhK2JLVmRFbUFFVDFoc1ZSZ2ZQTmZkOXFTQnNIUm9r?=
 =?utf-8?B?TkRtNStRbzRnRVlqOFBmd0dsZkFDRXVHbXhHdnRSRUhuRWVlbGFzelFVQjVm?=
 =?utf-8?B?Mi90SVYyZlJpQkE2MmdRektIVWNLb2NxM1dGS1lKcjdDa2ppL1FGR0RLc0lV?=
 =?utf-8?B?RG9iR1VXb1lJWXB3WmRPTTNLY015NzZKeGRpQWVBWWlva0czalVVVVhUWU1R?=
 =?utf-8?Q?cPdkE5pui0g1j7PkK+zVqSDv4?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 981bfc22-be97-4f5e-25cb-08dcbde8f95a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 11:45:49.6372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HOp9BHPurwXRPcSveaxxH4/Nyif9iijuko1mX/fGDVcFjD1eVL6bd7cGgwYVhNfzzkun1v9ghznRlWH3HpASEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7201
X-OriginatorOrg: intel.com

Hi Kevin, Baolu, Jason,

I've got two opens when rebasing iommufd pasid series on top of 6.11.
Would like to hear about your ideas. :)

1) How to retrieve attached domain for pasid in the iommu core. This is
    needed when adding domain replacement for pasid. In the before, it can
    be done by searching the group->pasid_array[1]. However, the
    group->pasid_array stores iommu_attach_handle after the iopf patch [2].
    IIUC, iommu_attach_handle is passed only when the domain is
    iopf-capable. So, if the old domain does not support iopf, then it's not
    able to get this old domain from the group->pasid_array when trying to
    do domain replacement. :(
    Not sure if any side-effect if I always pass an iommu_attach_handle even
    if the hwpt/domain is not iopf-capable. @Baolu?

2) Should I enable/disable IOPF when attaching/detaching pasid to/from
    domains just like patch [3] does?

[1] 
https://lore.kernel.org/linux-iommu/20240628090557.50898-2-yi.l.liu@intel.com/
[2] 
https://lore.kernel.org/linux-iommu/20240702063444.105814-2-baolu.lu@linux.intel.com/
[3] 
https://lore.kernel.org/linux-iommu/20240702063444.105814-8-baolu.lu@linux.intel.com/

-- 
Regards,
Yi Liu

