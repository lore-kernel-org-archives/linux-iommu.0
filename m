Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAEE2B9B7
	for <iommu@lists.linux.dev>; Tue, 25 Feb 2025 03:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740454286; cv=fail; b=SAjksIgLpw/gd7k2OSy+S/SctVcAKJTuCYu3zvkGeUsgIgv8OowV2KXPqEmotvsC6EqxgW7xDF50nAjSxOsagn+Kzj8VxNZYYyaeQteAYebDmqVu3DsNf6Bf72P/GDmexKxytoKCVM8/a5PKA8UrC13ge3OUUG0qKNVf+h7xeXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740454286; c=relaxed/simple;
	bh=j3z0M4x/zt+Ug825zLSRvADuVdsYkFqCp30lzkTvi5E=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rHgxC8O62Z9/psKULMioWKeEgjRomPJsvtvadP17+HMeXUuKWbf3PpT/ZjOLKoiQyWWMYvTHjdgZ30Ey3VWUXHbXPheaAyuHlqTPnL/t5fTujdu5mpue+CNQuDU+7S8w5HpdkB8XVWytJc44XMHluqxAN9LkSc2+5frdyZgjmgk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gdh5/QDA; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gdh5/QDA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740454284; x=1771990284;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=j3z0M4x/zt+Ug825zLSRvADuVdsYkFqCp30lzkTvi5E=;
  b=Gdh5/QDA7xN3SB7noRH+URDWsOHNfGPcD+xb06Ts6SsB96nVPSTXO9/R
   AkuOTRwUsstT1RMJeMagWnj/zOp9+B1hhGk2tNtCcm+zjsyV9Kg/3oc1C
   2S95a7XgyAgSIMSYI+gZM+9o4gflEzScPcpNZBkcmXOP5IWUUZjV7P/dV
   rfNww9vDQYyEKT+IG2NWRrwh2opzQd23HBi3T0hmWImEB/FKrJ3u/lKRn
   U0NHoNg5YRhn4Y8vEa546H5jYeQknVJajSk5wtLKusZrhmDd/BEbicrtt
   1U/gtX7zTr7FIg/FtE5bkW2r7awlnKoyU7ULVB36iViEa5VFvmSdkrvUW
   w==;
X-CSE-ConnectionGUID: XgCdncflQxKyGWwZVDeowA==
X-CSE-MsgGUID: pmu52vzYSg6hsgfmEZf9fQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="28837106"
X-IronPort-AV: E=Sophos;i="6.13,313,1732608000"; 
   d="scan'208";a="28837106"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 19:31:21 -0800
X-CSE-ConnectionGUID: THM82iCxT/qQn2mlMv5UeA==
X-CSE-MsgGUID: UguKDje3SBqcr/bfV3uKNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="120363886"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 19:30:19 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 24 Feb 2025 19:30:18 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 24 Feb 2025 19:30:18 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 24 Feb 2025 19:30:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eHQozmWtYLsF/gpsjR22KwV8sOjZK0PySQVzs8YiVXQ0PmY7XBM+bR6y/AcUixeyjGRFAAeCDYr87inDId0fT0uAKk8BxVqjT0VtFxtviuIoMgHIcP7JQky86EM9ICiFrT65d4qQRsg+uE8NcpoOGExDy4cpmxVWlwE02QbeESamfZ1+1HJVGjLPPUYmecb9t+8LZajf/pfpzLtwmIt5/blo3OgYndUmE9m64BB6+sEJGWK9/yP4Nl5P8G0YK7uby68d+R8Tns7uBbzb8vkEKBUCLK7V//vxy1530zpGy3eyufrFUuTs/OmJ+o1atZcxtD1lu9FcpjPmJmQJrgpS+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HX8vQHSNaPyx8TL5NdZQmNBH7GJI+5xQ6ArAl/D8aJI=;
 b=THB0INAFBOfkYe/YkDA9txPL7TBhuB6DpTUO27GZNSaJ5dHIb8jghskaRD8MBW19YOcYe2OmWQqvWm3UgKeFxkk4xywL/hTqkAMSzW121iTLeSmm7uHR5icnTJXyyDSBaApufnXY7OqhkP+wqbq8ZhiiIjMu8pMwQ2Ywl2ptfU8mlChPAF6+gwblUqo7irJfKHwb+VoW5wwlmHJSpkGQX9q7uvCLiVA5pI+0JO1VfahpDO43UQRM0vklXdrHV1mrgkeblugeR8PUmtXVXWO/dmcF36jsAmYHMML4DhzY3kCIF5MtpqE/tvwJHmx6YyG1Ry2o2SWcrGm5/++U3ZomkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by DS0PR11MB7558.namprd11.prod.outlook.com (2603:10b6:8:148::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.18; Tue, 25 Feb
 2025 03:30:02 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 03:30:02 +0000
Message-ID: <4ee8b320-8355-42fd-a7a1-3c16ed1f4527@intel.com>
Date: Tue, 25 Feb 2025 11:35:26 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] Misc iommu_attach_handle enhancements in iommu
 core
To: Jason Gunthorpe <jgg@nvidia.com>, <joro@8bytes.org>
CC: <kevin.tian@intel.com>, <baolu.lu@linux.intel.com>,
	<iommu@lists.linux.dev>, <robin.murphy@arm.com>, <nicolinc@nvidia.com>,
	<will@kernel.org>
References: <20250221143335.49874-1-yi.l.liu@intel.com>
 <20250225001317.GI520155@nvidia.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20250225001317.GI520155@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0021.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::14) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|DS0PR11MB7558:EE_
X-MS-Office365-Filtering-Correlation-Id: e26673a7-4c3d-4519-8d3c-08dd554cb036
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Sy9hdDI4bTVLVTFKNzUyamxsZUlnN0NBZFZ5R3JqRTFvQ0E5SUJSUi9KdGRw?=
 =?utf-8?B?NVliNW12T21lVVpVSFVEaWUzd1M4ZUhpcUxJQ2FOZ2x6N0dYZmlSOFZJa3Yy?=
 =?utf-8?B?RW51YkVJNGxPdGJ5ZGtkeTdoNUNpRkd1RngvT3pkdFZzVmgrQWkxV3dzUUFl?=
 =?utf-8?B?ODNsSlpGYUFBNHVCRDduVFp2VnFpRzBZL1FKV01BVkFRMVFnWWdVenBPdnJj?=
 =?utf-8?B?dlRmK0M0VDNiREpHMEUrSC95UWJBdkNyanNnMytNc3ZQbEhySDZROThtMElt?=
 =?utf-8?B?R01VMTRmdjl6ZWNLYU5TQllsN1F2cENGSzBmVlozU2RzcnBKSlRyS2JvN1Ax?=
 =?utf-8?B?ekdCeU1PUXRhTW1ScitJSzZVWlhSVktKa3JHak5IeEtJUGpHb1krNFhqWTgy?=
 =?utf-8?B?VnNQMTEyb2JDdzR1d3Q4UnNSNnIvZXJiZk9hRVAya3VFTjVVa0llTlJ0OCtz?=
 =?utf-8?B?SlZHZFhhSWNMWXljRlFPbWE4ZTVsZWNTcFQzWkNVVHAwamRuL1F1R0I2dXZG?=
 =?utf-8?B?a2VwMmluM0xCcDFiTzMwNjl0TzlSc2tlcUZRWWpxOHVJaDdOWnFjanhYVlI5?=
 =?utf-8?B?ZjdRRElCS0F6bDZEWmdCMHJCQ0ZJOTFDTjh1RE5td0F4TnBOOW1EaUF2NzRH?=
 =?utf-8?B?Yml6SWVpT0pENm9GdG50S1VPK2ZxTU1ldmpIVmJzcWRmWFlkR2RKbWpTd0dR?=
 =?utf-8?B?d29WOXNHNktOZktuaklsU2hlL1BIdjBzUGQ5QmNua2xNc2dnaTNpNGdINCtw?=
 =?utf-8?B?Ym94S3JIYXNtR0FvekE4UHdrTEtCcXRyd1ErUk4zZUdzK0s5ME90eGtQVG1E?=
 =?utf-8?B?T3RKZnJHOWlqMWZYNjd0RkNMN2FkSWE3bmhoYkxXUDVCRjU0RFNXekorelZ1?=
 =?utf-8?B?UHZ6MzEzMDhFWmg3azdUWEhJS1VjMkE3ZWNWd1NjRnc4M3FpcXVRb1IxUklI?=
 =?utf-8?B?ZkFrVFRKQ1FZQXlIRGIxZzZvSDNUZnRQVk9nYlJFOVB6LzJnZmVKdjdiZGNk?=
 =?utf-8?B?UEdSbWNlVGdXV29kNVZDUEUrN0VKOW9MR2xocENTWWdLak01UCtFM1NyYWZr?=
 =?utf-8?B?SkZtWGpNV0FTS002bzV3OHdPcWt0QjdOR3V1elBHZ3BkcnZSNkZ1MGNtSGpY?=
 =?utf-8?B?WjN5bW9qZG5UQ3FsYVkzcFEzTEFHQXVnNXpjRVVsK2xMUDl2NXZVSXJTTElE?=
 =?utf-8?B?MzFRZ2doTlNkRGYwZVk5Z21rRk5YeE5wM3RUbCt5TzQvTTBVYWltSElISXZZ?=
 =?utf-8?B?YktEK3dSR2QxN00ySkpRaVdIMlp5RUxTSURHM0lMWlhlbUFlaDUxZU02REk0?=
 =?utf-8?B?T294amwzS0ozMGh3NHVJakVOb0RENlVBWmhCUWdQY2p3UXJDRmF3Y3BCYXps?=
 =?utf-8?B?MVJ5UTdnbWtUQ2NTOStCc3BIMUdGVThNdklLYXE2RENFM2cvQXRMdXZlb3o5?=
 =?utf-8?B?QTRidkVneHQvallHSG1vU2ZFZVFKZjRNcFNWcmpadTNTRDVBYUdwZ1RMTTNr?=
 =?utf-8?B?Y084RHVvNWlXZjhkTGFKek1HdVlyaG41RjdIQUMxd01xVFhaOThHbS92RGN1?=
 =?utf-8?B?eHFqTDgxT2JuVmkvM3YrbjNNcEJZelZkVVBqeTdWK0hHQkQrZ0VDQzdZWHhF?=
 =?utf-8?B?Mk15ZXBQZU5sd3FyeDdDVzhMUWJ6dGFUMU1iTmhmM0ZWWG9Yb0h2S1VHQXN1?=
 =?utf-8?B?SDg3SnJWT0RJSlZuL3ZEend1UDZ3TE1xQ0dLSDJJT05NMnJKV0tDeG5WZitv?=
 =?utf-8?B?ZjVkcFk1Y0VsYzZrNVl6ZEFrRkI0aTdqNmIwSUN0VnN1RlNhT1ZuTHc2V0pR?=
 =?utf-8?B?SGhlVmdwbFJpUU1XWURUZjBjc1dxa2dqTHd0TzlVTUxUbTEzSWxjRVZhNG9Y?=
 =?utf-8?Q?dKAT9UL5DCoyU?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emp0WENaVE9IS1d2Rnl1NTdaaFlIMlJac2V1UGdCUEIxUHlIQXhteDZYQUl4?=
 =?utf-8?B?RHdidkpTblpOYnptWjZ2ZXNEQ0tuMi9oTU0weStiT0cyb0VQaHVpb1hXRjEz?=
 =?utf-8?B?V1IyT3VzOEoxRlJjbHdrQTZxUGZ3Z0VTMFBqR3R1Tk9GaEo5YXBmRWRUZDlF?=
 =?utf-8?B?TkcyVEZnQkVqWFJrZEp6WHRhWE5lNFgyNXRkQVVpd0Q1UEVxUFVzd0FKLzBZ?=
 =?utf-8?B?U1phTlFTNlVzS0dWQ1UvbGIvWVlTRDdFUFVoM1o1NklZNTg0OWZDYjgxM21P?=
 =?utf-8?B?OHpXdG4wRUUyR3hQRm9lbXhqL01URXd5eVRmT2hTWW9UV3JMUkZHMjFJZTBY?=
 =?utf-8?B?aEcyMHV3REpSSVR4aDVUVVA0TjZDakJ4aHFwYlNBek9xVHlMWU5UR2JJT21F?=
 =?utf-8?B?VjkybUVBN3pCZ3EyVEdhOVI5azhIcUtvRVBReGY5TnBGTkQ0UTU1TjRvUjFZ?=
 =?utf-8?B?eFkwL0VVZUNoemNkUWRZVjcyU3lhc2NERmVuWE82QXNNTGZsTXdpek41azVt?=
 =?utf-8?B?QzJDVGdkSHQvOXlWQWdxZVFvTHpVcjJ3U2lOellmL2V4VkRzMXpoVGxDeStr?=
 =?utf-8?B?cjVYT3B5SmVod1Q0QjZySy8ydTVIdk9GcG0vemRzajdOckVPbVdWZWh1UTA5?=
 =?utf-8?B?RGNFQy9xTkR0L1dyTzY0UlRlOTlBd0JiOExtZisyM1ZDVGxGS2tXa1dremF6?=
 =?utf-8?B?RmZyN09SaTdDR01VWmh0SnFOb0FDVURVdVdqb09LSTJzV3ZyZVpobnlJQUVh?=
 =?utf-8?B?S2E4bTJBOTRwVlpOL1FGd05zMjBDU1dybG81ZXV2alBETkp1OXVyY3kyMEtE?=
 =?utf-8?B?ci83N3dSbzJvbEFxYVI3bDJxMzNyc1FndzRoRjZFOWRtOGd6aENZSTE4WVNE?=
 =?utf-8?B?ZFB1ZzFMTG9FQlFDQ2dXc0JNVVpoZC90bW5HcHdaZWhoQ2RoQjl0cWpheUE5?=
 =?utf-8?B?RDBpQ0RaNUhQYU8ycEVFTEFrUlVJR0c4clJMRVE2V1QvTHpqb2lBMGpaTlRP?=
 =?utf-8?B?QUNOVXRhT0VLY2gwekZDWndXMFZCTjY3cDNoNXZ1bk54TXlpRHBob21YNHVj?=
 =?utf-8?B?UUE2VTdybDJxcW93SXRoSi8ycWdUUkhDUVZwUWVTWmR1cUtvcFFjQUdtY2ZR?=
 =?utf-8?B?OWlRZDB6Rk13RHFHakxVZXNYcjZIaktFZUtFTmhibkVneUw0WGZ0Vk51UWJE?=
 =?utf-8?B?OXkwZlFlNVNHdHZJRHlEdVQ1S1dZUldpTWgvajMxRUU1S2g3cFJ5MDE4VStr?=
 =?utf-8?B?U0hqT2hHb1BUQ3oweUFOdU5pVWJRa2RKV2M0Z2ZORU8xYk1tNDFlclRnZ0Vi?=
 =?utf-8?B?VTNOZHVEOG5wM0NhRkxudnZSeXV3dEx2QlVqVXFnZXlCUzkvVS9tWHdJT2ZD?=
 =?utf-8?B?dzlIQ1dtcm9weWxlUkI4YkxTVGpFbktyYTNBN2hISzZ2bGhnc2dwcjlSYURh?=
 =?utf-8?B?T3pWRml6UHZ0dm9GMGozYTlxR05JOGMycldud2NqMy9pTkVXaWFIOEsxa3gy?=
 =?utf-8?B?UjNWbGp5bkNXRXRzNFhGY0Z5WkxobHdWcWdOSWpnQVNjL0NYRU5HVkRlWDk5?=
 =?utf-8?B?cW1EcGNHWktqc2F6c0w0MFNLamh0bE1ZZm1UZkZKUm40TnVTa3g4elJ2NVZF?=
 =?utf-8?B?dXVKR2YycXlFQXlwRUcvN3ppU1J2K3ZRZHhKc0FNeUR2NWRRd0lxend5MWxk?=
 =?utf-8?B?UFgyWG9Kb2JjL2R2WllOWDJTM0t0cDNtU3BqZXpJMFk4c3JhWk1LMUhGdkpH?=
 =?utf-8?B?cmlSY2hDNGRwcnZUTTlmRkVPOE1RL0tjS2dtcmVJak1jN2JQdmM4VW1oaE1B?=
 =?utf-8?B?aktJQkhvZnRvQW85VVgvS3FSSzNYQjFUY0RodUwwTHJTUEkvdjhLVk1JRSta?=
 =?utf-8?B?Ynl3SnVPbGRzQnIvanRVTUhCdjNVQ0svREIzUzV6TUYwdzgwU0hvRzNsTlps?=
 =?utf-8?B?RFNYRGROMHVFbURJdnArQXQwWVkzeEVML1dvYm5rTmtOakJ1L2treGNjTEJ1?=
 =?utf-8?B?cXVMaWo2TXlTZXVjSkZWMWFhYWtyenZiNEg0UlQyMDhjYWpYVlpqc3JTWERY?=
 =?utf-8?B?NERDODZHTG9nZC9OcVBoaW5kVzZBbGdLNjlwRlZFeTV1MVNiejFZZ1R4ZEhW?=
 =?utf-8?Q?lQbB6QI3X23USLtbNxBKM5IKb?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e26673a7-4c3d-4519-8d3c-08dd554cb036
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 03:30:02.2727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TAY7Bfiy/KpwLjjJXB3LQHfonKVsgUXC3yDzVxLLMNjWpKrF2OazsXbd5Ca/M/L+0rNzejqING6ZjdbnxvR1Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7558
X-OriginatorOrg: intel.com

On 2025/2/25 08:13, Jason Gunthorpe wrote:
> On Fri, Feb 21, 2025 at 06:33:31AM -0800, Yi Liu wrote:
>> Yi Liu (4):
>>    iommu: Make @handle mandatory in iommu_{attach|replace}_group_handle()
>>    iommu: Drop iommu_group_replace_domain()
>>    iommu: Store either domain or handle in group->pasid_array
>>    iommu: Swap the order of setting group->pasid_array and calling attach
>>      op of iommu drivers
> 
> Joerg, this also needs some of the iommufd patches on my tree, I can
> pick it up and send you a PR with this and the MSI stuff. OK?

I'll send a v3 given Baolu's comment.

-- 
Regards,
Yi Liu
