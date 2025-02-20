Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9DA5223
	for <iommu@lists.linux.dev>; Thu, 20 Feb 2025 03:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740023202; cv=fail; b=XJgkPmX1wU/S7VoM+o51UAjazY3oovbZVoWrQYCFxGGJGyu95TnLeTtwTTQ4TfbD3pHQVjrWh/49AWzVCV34M7AbT314ZUK2F3rJRL1MWCPJ6zAv3Q0FKptwWz8Do303vsldcfqQ5eMVtz6YEt49j4b0dBILuHCxZyWr9eIxjZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740023202; c=relaxed/simple;
	bh=mXPqeeW5EdmEnPlpcs2+8IpeeKWTWBgrIlqVivkjrY0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dPMv+twzJVzfZf4mi4w2WmJe8r8C9TVv32xUpfP6qUN928FIMuV8mg8TzL0DzBgZnOOKFUHU4tysrH06qsdTAsAw5R2Z39tANavrTzG4HDCw/zSlDYmUD1FfHPRGczErSkq7i6dO5bIeXaVJpNrERguxzfGn7DVSA3mPeoFKlhw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jSlfEsrm; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jSlfEsrm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740023201; x=1771559201;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mXPqeeW5EdmEnPlpcs2+8IpeeKWTWBgrIlqVivkjrY0=;
  b=jSlfEsrmixVDTFrMeTngBrVKacjgSmIc/9LnH9Nhz0HwB2q8koyPORCC
   hON3rgzEz4RsLXKbt9fsf+Qq0Yoz01mnVuFNm+KJTE+TuwyPgWWwe7ntg
   ZM+aCIA7tGpXuDKePN/eHmV5VMPd3IX5zuV+/ahTNr18hf9UhR0nY0XQ/
   W2LqTAcMTe0JrvWeG/y9AiDJEBdEZV0iiSkdspMb7PF13ZT0McTFSOaX9
   WLLU5z0tCMN5HFuVVd0xCtbkeWg8F3YXMZPoqh0MwjV31RLVCC6Pjji6i
   uAMV9tXCA2mGEB9pZt2FWsodFdE88UFzb2y44sfEJL15atXG9qpl1FvR5
   Q==;
X-CSE-ConnectionGUID: 1HhY8wWcTcuKrpma8UUcnw==
X-CSE-MsgGUID: nIsRIc7tSSy2rtOi0Hf2Sg==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="66144366"
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; 
   d="scan'208";a="66144366"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 19:46:40 -0800
X-CSE-ConnectionGUID: 66Za0LPQSiiSXdepJzBSsQ==
X-CSE-MsgGUID: FYX33DGOTyG6Jeei7iNTrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; 
   d="scan'208";a="114898462"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 19:46:40 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 19 Feb 2025 19:46:39 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 19 Feb 2025 19:46:39 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Feb 2025 19:46:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uzsdFwXc+rXedv4lQQKx3MxPR5FTE7B8QnLB1gyGha83lJTdG8gEVx7l8EHsx08V5qKHmF/5V2jF1FmLWlEIZqJGOU9UkNcyXOigJuu5k9eja6BhyMpbEnqIdy5E7Nw5xrQU0cSzltpUxmxq3umD9Dcu2r5kovQXwsGb64et25ryst6yl38czr5smHUcxBTnSi1lpJ0DN1pbRl1+UbM7MY5oUG0mhyZq3eF5CU3k8O3VY6uBOcPr4x7NtagLXR7EcXR6Tk0HahnYbkJPw0eW9+3BK0tLLmVhCvxYpTodFYdja+FXiEOcmRqhVHE00faDNtMWChV0i5VJBMqRunW45A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SLfIhz5uwIsQJMSCWZzUZiqstKFZW7FKDwfcn0T/GWw=;
 b=xkF1tHTFDI3vxh0F3VbUftQZds5WiHEzgR83xcus6+MqPK8p02RF6w5+Q2V/cevGyKlIRzhZtHkueaMcmhlidPKH7JYT3OAVkMSNvl8/hI9GQuzuesF/L4Yq8AdXOGJWR9XlhLkBLBzxXbNkO7JkrJkjxTi+i7X5gHTeGgdOG9oPnT2U3Kvuo3CffXVJvmBcqiFs8s3kV8AA2xXs44t7eYfJ5ifSLbKMdJ3rPExS3uwBgnfc3gGQMxXem2MT9p5UfN33BYpQMY2eEuEWqqY2a5BMnFQf6cuJDns1SY0OLX4OY2SFGm5fHzRXHRhFRPiHSd8lEatcxXz2O8oHSsP6FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by PH0PR11MB4917.namprd11.prod.outlook.com (2603:10b6:510:32::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 03:45:56 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%4]) with mapi id 15.20.8445.013; Thu, 20 Feb 2025
 03:45:56 +0000
Message-ID: <38126ea2-8b66-41a3-a915-af2c93b9c5af@intel.com>
Date: Thu, 20 Feb 2025 11:51:19 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] iommu: Drop iommu_group_replace_domain()
To: Nicolin Chen <nicolinc@nvidia.com>
CC: <joro@8bytes.org>, <jgg@nvidia.com>, <kevin.tian@intel.com>,
	<baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>, <robin.murphy@arm.com>,
	<will@kernel.org>
References: <20250212060540.261436-1-yi.l.liu@intel.com>
 <20250212060540.261436-3-yi.l.liu@intel.com>
 <Z7YMcISryMeilVpw@Asurada-Nvidia>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <Z7YMcISryMeilVpw@Asurada-Nvidia>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0032.apcprd02.prod.outlook.com
 (2603:1096:4:195::12) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|PH0PR11MB4917:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c7b9c5f-7389-49ac-882c-08dd516114c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WlIvWGZ6N2s4Y3ZVN01YNkxkZjc2VS9pYVAwSjREeGpROGtkODVRU2RzbDc0?=
 =?utf-8?B?alE3M09zdmgvcTdjU1BzTkYyenJnSzF2bCtzSXJHdjV2TEEvSjFsZVM5Z1Ju?=
 =?utf-8?B?M2JZQllWTXBxcFNKbWcyeVBCSEc0UmY0U1k1MkhzbHlyUGZybndpVFplVllT?=
 =?utf-8?B?ZTFRdlA4RnVGQ1V2RUFXcGQzSVdsc0t6c244eWpPc2gwellEMjd0WDc3VDY2?=
 =?utf-8?B?dGF3djZrSGYvcTh1bE1BL1kvcm51VHc4S29IMjV0QkRTVkw0YjJJR1RDZ2Iz?=
 =?utf-8?B?ZEl5K2wrYkdaQnpKVExaTU9jR1JhVUFPdkcwYklSYmJzbEZ3UHM1V0daSE9B?=
 =?utf-8?B?WVZHUzBvcXFnZDdsOXROVVlvclhuQlB0SERDU0h4aGZzMHJrTDh3N0hXRVlx?=
 =?utf-8?B?T0drOFJTMnJxVHZDMU1reWNDWDVlZjJjNWo4R3BGRDFCNDZCL0sveG8yOHFB?=
 =?utf-8?B?SGxrL05kNlNuU2lCc2ZnSFpBaFhzZFFYczBxcStGK0Urc25Sc21xbXc0NG5C?=
 =?utf-8?B?RkZKeHlvY0dYbFFSSUtVNVBiekVnR21zd3lwOXA0KzViWkNETDk1Tk5Yby9C?=
 =?utf-8?B?QWs5V2FJNmVYN3FCeFN4UThXL2M5dlpxcTlWNzlDN2lmdXI3bDF6QTkxaTVv?=
 =?utf-8?B?U1paWXdlbVBoeU4ydEZhM2pwVmxEb3NRNUlXSEZBTFhKRWdUaFhzSW1ZeGtG?=
 =?utf-8?B?cUN1Q3k2V2QzU2ZqNGZ4TVl5YnV5WmpaQ3BaM2J3bGR4WkRKaEdLNXJiaHlE?=
 =?utf-8?B?YjAwaEptdGVVT1N3ellQeEQ5OEgwRS9WT2t5ejVEVzBDOXNFQVFiT1k0RXhs?=
 =?utf-8?B?c01HbzkwVEFCa1R4ZmtNRlJHU0ZNaXhLTkpkK1Brd2NiSHBwb2RTb2tyYkl0?=
 =?utf-8?B?WWxXRzByZ2ZONWFvUWtSVW90NEY2bG1jc1BkVG96WmJFdWJIejVqOUR5WHZR?=
 =?utf-8?B?VE9DeDNJN2h2c1dMVE5EWEo5emxlakxKOWpZVmhzb0RUT2dIdVpxOFJvb2cx?=
 =?utf-8?B?Rm5MeXRMWlNEN1owaGx0WEVvQm05eVpTN0ZVSXBkVkFNUjRodE05dVptWWNI?=
 =?utf-8?B?UHRNa3BYaWdOSFFjbWU3MWc0YkZTdEdSOVBhZ3orWlNNVW43K1FLZkdxSWlk?=
 =?utf-8?B?Y0oyOGh3dUx6dlN5M3FES3dibUU3VW0wV2xxTFVHSmh3Vk80TlZ3MDhvRDVy?=
 =?utf-8?B?Y0J2NjVleEtXYzRiYnRNZTdCVmJIYkVkdTB1R05IWFUxYVVhYWthMDBnbGRk?=
 =?utf-8?B?dnNBQ0RhelF2eXhIamR0L21QVWthcVJETVF0TkRVdUpKRUJkcTBxVEVRc2xG?=
 =?utf-8?B?bkxkS2F1a1d0bnl5bjZSYnBuTlhyeWwrNVNMWWwvK1cwcTdjdkgwMUxIMmF3?=
 =?utf-8?B?WUdDTFM1ejdMekNpS1cwUjlRVytudlJ6VE9scmZNNVdnVWFnV3JudHJWb1Zu?=
 =?utf-8?B?cUZoRDM3dmZ5R2dsdGtiMkszdHlEVGpQajMwUjRWWHhsYnFnd1ZLeGJVMk53?=
 =?utf-8?B?THREQkJxSnlhR1M1SG1vL1lReVFrRkpjUW4rR3BWQks2Sm43M2tYc0ZVYkZn?=
 =?utf-8?B?NG80TW95M3BWRDIrNEp5UUU1UDRCeUY3dnpIYXVZanYxVmY5UXdBQWpJTFhY?=
 =?utf-8?B?UkU2cytKZk1XRFh1QlJaTTdsOE9pWVlHVjFKeEdBUTMwRzhGUVM2dlFSWU5m?=
 =?utf-8?B?Q1JKSGp5VkpaNFd2bk05b2Z1RzJ0Vzh4Wk1YKzg1NEhCYXh1dS9scGRnbmE0?=
 =?utf-8?B?TFpUYU5hZ3AxNVFWUDBEeE16Sk1PMzdiK0VNSzBQcHczTnMwdmpEanlweEtY?=
 =?utf-8?B?dnlTL0o5Y0k4MVBuODFNTFI0UEJRSkVHaXQraUlZajB6U2h0SGpPUEJ2UE1t?=
 =?utf-8?Q?sOlluY1klXzXB?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0M1TFprc1NBRXNWbEVpZUZCdkREZ3JyeUtxRGxkanJscWtZM3A1T1lBZXp1?=
 =?utf-8?B?dzhqYmhHd2sxTk9veHpwYjhsd09tb3p6cVB6Y0cvSTVCaEZYdTEyOEJiRFJD?=
 =?utf-8?B?YUlhb0V6RHkwMGFjZEtrajFOeGFxT2xXck1lRjQzL2hjY1dwME05L2tNM0Na?=
 =?utf-8?B?a0dIMVpRVUFKZTh6dnAxb1FDTEhuM1FjcE5NUTNDdk5yc2FYdFovRElHL3ND?=
 =?utf-8?B?RTYxM0hudG91N3FWVTdIZUNabExGbnZobVMrRnU3b0lGZzZUN2FiZVBhK1py?=
 =?utf-8?B?cDc0MktSclp2WWt4QzdGV01mZFQ2YmFNRkxVVEJIR2R3Sm9HaXlEWmNVRWlr?=
 =?utf-8?B?L3BLU3E1aVIyc2M5ek45YlNORnIvL0MxSGNDNkZGL1ZQWHpGcWlCN00wWkZ5?=
 =?utf-8?B?aFRGTUMxY3Z6THhLRWRiZzRvek91djEwVUZkbEY4MUhYOFU3b0VZc3JWbFZl?=
 =?utf-8?B?R3ptdlBUbE9OTGdvNXo3RUxOQnJOeUNOVTYya0JUMlkzZ0xFdUFBazM1SnZJ?=
 =?utf-8?B?VzZXWDdUMkIrNXFOUFJ5ZFZTWXlVZ3h0OVNTczQvWm9UblVZOHB6VWRyMGxv?=
 =?utf-8?B?WEtYbFpLNEIwMkVzdlVoR3NITk9NbFJZV1lVam9xT1hRSTMrREIwT0ZLZkth?=
 =?utf-8?B?d0ZLcWtxYU0rQlRhNklkNUdhK052b3hQZWZSZ2t0NDJobUdpTGNLT2xJWFVu?=
 =?utf-8?B?SDl6MG81OEhsN2Y2QTc0SDF3amVheUpBdVlZbGoxN2QyNzJUMUVWT1NUK0ts?=
 =?utf-8?B?VXU2MGNDYWhqYmNqVFFkK2tQejhBUXpxYU5sOENhTFlpQjVuSjE4dWRxc1dz?=
 =?utf-8?B?Znc4THdJTnE3bXVOYlpkWm5UT1BZMkdjSGN6eWxuRHM5S2tWNEZPanhBUDVv?=
 =?utf-8?B?a0hZdzRod0ZZV0lodm9ScGtIYXhqMllFTjd5MUd4UjY0VzVtYnJqdTcyZ2hj?=
 =?utf-8?B?MXZrNFRtVi8rdlRqS3ZSOTFORWhGUVdXbWJxUngvNHVmdkdOS0NMbmlWOFAw?=
 =?utf-8?B?MmpVT0F5WXdvdE12VnhUaW5rRzFzdG01QTJOYnZQaEVEUHJReS81T09kN0E1?=
 =?utf-8?B?QXVBOWRIUHQ0emhkUTNMcStXUFJkRTlCNGc1WkxKRE96a0lJRmN0bmpkcDFh?=
 =?utf-8?B?YmVOdkFsYmtzOUJvMGNSdWVkZkNzVkN4eFg5ZzhrQ01PRVhFSVdBUkdqTkUv?=
 =?utf-8?B?UkFCTWdIUGN2b2Qzai9vOTc3ZmRpUlUvYSsvZnhSZk5GOG5NZFFGd01wVy9L?=
 =?utf-8?B?Z3BNY3gybFcrVTBnUjBaNVpGTUdwTTBGNDZUMk1pY2grUDZoQ0ZweEltRVJL?=
 =?utf-8?B?QjNPMTlXbnJlRjhwRXhtd0VaVjg3blF3SjY0NmhhVjVUQ1lqYW1wLzV0QWdJ?=
 =?utf-8?B?Q1Iwd2hSZDMrcGtQZ3F4a1BzUkZTcEo3SUpPK3c3MFZDbTRrYnBpdjZXWVZM?=
 =?utf-8?B?NWlRRjQ2ZElMOURGZDd2WmZSb0FpNGwrNFVPWEFmSkl1M2lXWm9YVUxRcDdi?=
 =?utf-8?B?MkVZanJiNlhHdnBSQkVEY0dFaXVvcGErczdobmdnQTNSdFVveHV3WTh2c0w4?=
 =?utf-8?B?ZGR5akdTVXYxbFBCV1YzRnlQeWlzZ05mb2YrUlpId096c3lBd0tSTUlVQ3VD?=
 =?utf-8?B?UUZoemMwOFQ2KzFkMzluTWlpdjU5b2t2b3ByOHBxM29GNVU2RWNNb2wvdy9m?=
 =?utf-8?B?THN6TXlLSFNFcDdlNFlnRHdQNjZXRHJUbDhYZlNTdjhTa1dNcDI4T0F6cndQ?=
 =?utf-8?B?SC9oa25JVlFIT1FlM2V6ZHM3ZThyakROZ2VST2dKZFRQenhIV1RaQk5KdEVD?=
 =?utf-8?B?VW10OStla3pBTWFrR0F2MXFmRGNUaTRjTmZ2VHdlZnlsMG5FbkJLZzh0bEYv?=
 =?utf-8?B?VS90RVZpZlBCd0t3TnBSVjluQlNLU01UQWZkNFJHVS93Z0Z5OXh0SnFiTVBk?=
 =?utf-8?B?V3VGNUFkcGZ1VEhTUXBnSUZIOElnYld1QW1BTitDd0RHOElyMVMxekwyQVJa?=
 =?utf-8?B?NjZGL1NJb3RlejNBcXRCckJkcW1PNTlmNE9jbnYyQ1NmL0hzRTBvMFUxcTNm?=
 =?utf-8?B?MjF6c2FXbEN2UThjYlNuR1JlcWdJYmd1ZUphaGt2Vmg3cnFJUlE4QkhtTDE2?=
 =?utf-8?Q?Bc2dhKer29p8b5xsDMxWl51lT?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c7b9c5f-7389-49ac-882c-08dd516114c8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 03:45:56.2190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QW1hIpUmdTkVhb7/8aTezIO+E8w3oIZSYKdsgSTudTiNaRkTOMZe7xsrXzRQHWD8iXZDke/d8eNzgoeuhkd7QQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4917
X-OriginatorOrg: intel.com

On 2025/2/20 00:53, Nicolin Chen wrote:
> On Tue, Feb 11, 2025 at 10:05:37PM -0800, Yi Liu wrote:
>> iommufd does not use it now, so drop it.
>>
>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>> ---
>>   drivers/iommu/iommu.c | 35 ++++++-----------------------------
>>   1 file changed, 6 insertions(+), 29 deletions(-)
> 
> Should we drop it in the following header too?
>    drivers/iommu/iommu-priv.h

yes.

> Otherwise,
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

-- 
Regards,
Yi Liu
