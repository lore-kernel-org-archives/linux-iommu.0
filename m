Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0068435958
	for <iommu@lists.linux.dev>; Thu, 20 Feb 2025 03:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740023799; cv=fail; b=NsQn19E04Ejcq6GPdGYajXeUilmemyh7eoYJm3p0HPJQ1SLGzrrs4S903oW5lYRz7v/qKj8EpmLfbgcC324QkF+ImSWAlAEOQHKejfeN6a0mJJIlbLkVwEZWoS+EcyvTCbYU9VMKiiyYNmHfhgka9U1C3C7phBr/XYFFBjWAOY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740023799; c=relaxed/simple;
	bh=4Jb++hk1Y/hUcpJmb7HdUyib6AmYZWDcVF30htZrDy8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BlgZ95kAPTNHN7TiH49DUI/TRTo30hD4Z+QUxApQZa/vkzockZIm2+MKum/kyKKtmbb+IhGFalzM7Ht8p75eOdqUy8S4l88DbHOUMYMY6tltsHBx9QcAg43VLLu3DOP8l2hWYJbV0juIbwH8SWTZzCPklCp2EbgCoJ0ihwsPnM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=daUrX9L1; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="daUrX9L1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740023798; x=1771559798;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4Jb++hk1Y/hUcpJmb7HdUyib6AmYZWDcVF30htZrDy8=;
  b=daUrX9L1dqs4T+emrLTDgSo9SYuQD4Ode9Aqk6P5AqrcheCErGpymBGi
   ajlOLty4rOoQcNB/0bbT/DC4AOUvlMfml1E+mWcVYVUdRjxOrLJ6Qu0lT
   aVTBJZOgQoH8GW33xJZBqIiyGNdA4N/lCzUPhaylwbEfnCrWebHl4DcvO
   BBXMvr7qHhGH7IgYiqi1MxxBI+mAIz87XV6KRsJJzRob593qSkaHcMCZn
   J771hx/sMoY2cloz7XkirJ+2/UnQH24cl39v4cwPe2VhEIMo+/S+Ukrdp
   wUXGCZ6L2GWqmFvKTYz/u2T/wJ3XmfP12J5sUZjEbxX45b/+QLsl46/lm
   A==;
X-CSE-ConnectionGUID: gxnJQKpVSuyOFiXe7EXrzg==
X-CSE-MsgGUID: ep5IrRwyTdmC8oupEfXxgg==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="44705366"
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; 
   d="scan'208";a="44705366"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 19:56:37 -0800
X-CSE-ConnectionGUID: XlQmHxTMTlSRYWf3ttW3yQ==
X-CSE-MsgGUID: Y4GEqjVTR2ig9iL+IAYBrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; 
   d="scan'208";a="119897610"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Feb 2025 19:56:37 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 19 Feb 2025 19:56:36 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 19 Feb 2025 19:56:36 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Feb 2025 19:56:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AsZf2BsYHkRHocsYKpw/U56+O9/+ew0L9Ix7GSm1ZmxzUrSioTRH79rRr8rH4x8JpW2TuA4PN7BVhxylN9jLys/pr4c+gbYlp4IehrFBlLclBz0SS5uvf944S9xhe7eea/x5qHpqZqfVGjceN528Wv9OYWJ91J0Lg6fcUcXO5DjzzJ29OdabPxTseLFdSv2lR034IYjC2z8iB6KSNlMmd2i1tAPti/5oNusXn+uwXYHZ4RyVgrIMsLy8a1M7gIoh1Rz8LMVCUGROevqoP8cYH5eaDVqWizTdsS1eeSqrryg6IVt0oqJ6hu62eLW00Nr2ItmKpqa1UV9SrQ29+exlvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L+CovkmpHx7a8pcciSz8nNDe/T8ZUoNVQmnggjZSmMI=;
 b=X5K/PHpra0WfFxwG2UW8IkdWP4AkJ5BtMRfwEj9Hpi4618+oJUx7esUnFEuecbbR5xac1+KrCR0WEbrYAy7InO39OEAvM7Na9jPKn9CQDQyE/ZKMLRdsUfd+c6ozzdC4hBWeQ0edSPU53WkpmoB1wbjRZuv7C7aYZ5gI4KdWQNNmbAtUGx7jT6y6BekIOvBCGvKVh0hVyZEUKpQxedmgKD7EUc+xHXNrvU1qGuwJe3uxwgy7uyvoAwpaUvEvcv/+8L2h5QWTX3v4hV7mYIfy9rRHruZKlXKry3EDjywEoppd1Npx6zSUdra8f9Xa7VPJssopna8O5OfdgRQXvug5bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SA1PR11MB6918.namprd11.prod.outlook.com (2603:10b6:806:2bf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 03:56:34 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%4]) with mapi id 15.20.8445.013; Thu, 20 Feb 2025
 03:56:34 +0000
Message-ID: <a72d2d49-a3e8-4da4-8a2a-355c0fc03df0@intel.com>
Date: Thu, 20 Feb 2025 12:01:56 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] iommu: Retire group->domain
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <joro@8bytes.org>, <kevin.tian@intel.com>, <baolu.lu@linux.intel.com>,
	<iommu@lists.linux.dev>, <robin.murphy@arm.com>, <nicolinc@nvidia.com>,
	<will@kernel.org>
References: <20250212060540.261436-1-yi.l.liu@intel.com>
 <20250212060540.261436-6-yi.l.liu@intel.com>
 <20250218193909.GF4183890@nvidia.com>
 <1df9b532-1b42-40da-8499-503f53ba8998@intel.com>
 <7a6bd064-afec-4492-b703-f076c50d41b1@intel.com>
 <20250219131054.GL4183890@nvidia.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20250219131054.GL4183890@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::19) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SA1PR11MB6918:EE_
X-MS-Office365-Filtering-Correlation-Id: b792884b-402e-4a22-1fc7-08dd5162912e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TkliTXFFbTVZc2J1NUFGeVd0L2FWRzE0V2JBOWJDYWlIeit6N3o1WG15ODYw?=
 =?utf-8?B?dWlOUGlGeE1QOHpJTDRObTRhbEdTbEN3UDdxWGt3R0JmcTFpNThRSWFWM3dR?=
 =?utf-8?B?ZGFsTk5DdzZTaGJhRWVtN0pOTkxYQ1FaYUFRRWwzTDMrMERZRkVYdDc4bDYw?=
 =?utf-8?B?YXJucTlrRkZxaldDT1NiQmQ1SmdlQzNaa1RhNm92QWcyQktGYnpGQi8vdDdJ?=
 =?utf-8?B?WnB6N2VaVXhNU056L052a2toSmdkT2FURGpIVXlaellrZVEvSHJKTlEyTDB0?=
 =?utf-8?B?UlNLbjFHK3FBcytBWlV5a0dSK05LUjRlSnBvdXJWbkgzNDZuNXdrUThaLzhR?=
 =?utf-8?B?NGwvQ3hTUWpNVHVQanBlUzBvUUVwUFlhV3ZqTkQvd2M5SHZqQ2dlL0I1dEFG?=
 =?utf-8?B?TFVtazdyV2cvUCtBVmZFVFdSNDFjcW85N1lNbm4rYUdQTnBieXBmRUt0Qytk?=
 =?utf-8?B?ZVVpNHgxeURpbmVQK1liTnkwVGRnMjNmRFpyUG14VDI0QzdpU1BLa21aRGZH?=
 =?utf-8?B?SWJ4aHN6a2JiZWVuVXFOeURBdUJIRk1TbW9Yc1R0NCtob2lOZDNTc2grVGl4?=
 =?utf-8?B?QWR0aHNySklhbmRlRmRxSXNCVlJXUW9FWjQ1MHBhd0d5YnRtZVJMY0JvMTBT?=
 =?utf-8?B?NXdaT1gxbktObXNKa0h6VEh3SzFkYjhrT01wVHIxcEFTd3lyUmp5UUtWQjhN?=
 =?utf-8?B?dmV4UHhDNjJBenZnVVRDbUQwcHNHRTRWaVBrdGxtUjF0dFdVenArWWdNSEpQ?=
 =?utf-8?B?UjhiMmkwUXgzQWpIS0VKb2xJc29JZVppZDltdDhUNmFBNHlHWGRXQU9WaDg0?=
 =?utf-8?B?VVowK0xSQW9sdXk2Z0JGNWVhYUIxVG80OXZCcURsb3VJMmdQeVMwWlRvRkth?=
 =?utf-8?B?VVB1djZkSmo2NWJzWDBORU83aVZJNWcwYU5QdU0zSVduT2x3WWt5UThoL2ht?=
 =?utf-8?B?WklXaUVEYWpGQlI2YStpVTdkalVOa0JGdENjNFdXc041bVJqNTY1TjBGdkZ3?=
 =?utf-8?B?T2tOaVI4dU0wMmRUNWJQV2x6b2E2RXlPYXJWb3htbGtjRTZPcUFaNzNJWk1S?=
 =?utf-8?B?eFlxeHJ6K2Ryem1yRHM2OW1PSFFWYWRJR3BSOEFacGVqZmN6Zkh0YVRlWUw4?=
 =?utf-8?B?anBjU2R4S0s3ekN0U3dVRTE1YlpZaVdleDVpNG9FQlE3NGdHR09hVi9DMjVR?=
 =?utf-8?B?YXYrMXpoRkFSTXh0angwdUwrdnBPTHFXRkRMR2t4eUdrazNQcm5CemVzVTVH?=
 =?utf-8?B?a0l5c3JrUXVxeHZxU0RvcnZCSjM4L3grb3BnMEpGOFRIM0xvNlprWEZkQlJy?=
 =?utf-8?B?NGhPNURVZitNQlY1N1Npa0hSN3VtQ0RiYjJid0Z0aDlJWFcwRTlHOVVUVkpQ?=
 =?utf-8?B?RjZDQ2ZLcTc1QnBybVlrL1RjdmtWcStDQzk2ZzVYb05xRFhWK2NiNSs0cHFk?=
 =?utf-8?B?cmNTemwwSGpzanNHajdsZW1weUlmb2RheHJNSnhaQXpBdVJDZFBpbnZ6cUJi?=
 =?utf-8?B?VFJnalk3NWRCMW5OZnVBR2RnNzRON2M4MHpvWE53SWc4TUtGUkZCeEFJOUFw?=
 =?utf-8?B?RjlvRnNjNHJEWVFydCtKTVRwSkJ0RDZzZkhvT1B3U2Evc0xWWDVRWXhHM3g2?=
 =?utf-8?B?K1V3dklzdnRVSS9rL3ZBTC9zWWQ3WjVUVzJWS2c0MzBmdkl0VDJGenZUcHBy?=
 =?utf-8?B?T2dwODd0WWVNSTFRelg4ZjJ3V3FSQityTjcreG4zcjYzb0NIbVZjTXhKM3BC?=
 =?utf-8?B?cmN4VTlFVUUwRnVzVEUxdzdiSzc1a2Z6eEd0MnluNEpWVzcrMVB5T3B2TllP?=
 =?utf-8?B?VG5iQ0pjbGNITjA2V2kyc3I3LzJ4MTJSQW9tTjlZam1MVnQwVFYxdm1TbmZ2?=
 =?utf-8?Q?OUMImRc/yqIHO?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUF0Q1JsUnhiVWJkNW9NNFNadG02ZXc4OXdwZVpxSk80N05OTEQ4SktRNkt5?=
 =?utf-8?B?RjVxU0ZrSm5vL1QvalphaFlQTEZmQmdNS2lES3I0eFFuZzRaT3ltbm5rME1U?=
 =?utf-8?B?T3ZUWW9tc0NCcDNWSWhwWi9mTkhsRWtwSmZHL01NdFdHYVdvcGxUbTdjWFlJ?=
 =?utf-8?B?clU1Vlh2ZVUvZU5uUVNVWndsbVJUWkhycFVSRnRwaFZYV0lzcUlBcWM2TWs0?=
 =?utf-8?B?OGQ0MjZCQ0luSTQ5ZVgyNXE1UnRqY2ZpcjcwckRRaC80VVRZejg1cTUrZVZt?=
 =?utf-8?B?WW8rZkZXckk4MFpsdHJLQUpSWDROcDhva0FSZXhTN25tOTNKbDREalpFbUxP?=
 =?utf-8?B?T3hFRlI5Vk9tL0x5UTVmdmhyY0FIUWxvc1lLNXJXUVBoWEtOVHp5Z0VRWDkr?=
 =?utf-8?B?TWl1V3Z1Z3dhNUl6QUJuOEV1SjZCZzlHMTdrbnFuMDZIT1ZQc3BGS0pxUzB4?=
 =?utf-8?B?NUFyRkx3RDBlaVZjdVNzaVUxdEU3MGxIOTk1dG9OSWFlNjlEUUdXdUpTUzcx?=
 =?utf-8?B?UWRmOEF3NFR3T1poWmdhVmxlWVlhZmFFWWFLVG5pS0dnbVZ0N21tMHhQRmdn?=
 =?utf-8?B?VHc2Q0hHTFZqZ0RwMG8xWFVhZURiKzdiMGcvSlpQazJQNlVFRDY0QnRzTWlr?=
 =?utf-8?B?YitaQWJzeWNONjhhMG53RlpIYi9pelJGZlFETFJDY2tyditkUXpkS2YvSUdP?=
 =?utf-8?B?QWhwY0tGVlNEMFRNSlZTdmFGMGNyaWdrWlVwUndFQzNvdTVlNjBFdTc3LzZu?=
 =?utf-8?B?OHI0Q3A0ZVV4TFFQS3NqQ2ZhTGFGWWRYWms0d0dMcFdUSE84U2FlTTFPci9j?=
 =?utf-8?B?WmNQNXFXUUdTUUZMbTY1NzdubEFXTUlWQ292L1FRZ3lTaDJCc3VhOTNERzNJ?=
 =?utf-8?B?L281VkU5VDBtZkx4TWhpQnBuQys3cEpId0dsS1k5YXVOU1NOakd4alBRai9F?=
 =?utf-8?B?NkJDRlFxTHVya3ZyWlpPWktIVEYxQWRVWWNheFY1blZYZ1FsdnVKRjdicm5x?=
 =?utf-8?B?VTh0RVE0elZUb3RNUVVXZ0pZSnltb2dIYkxBSkJMRnVIazFrT1V4RSs3dnZs?=
 =?utf-8?B?STNxTTU1eVFzNnRXZU5MSDhQRHhWaEdoYmNvOFYxdXRQMFdtb3VNeGlaNVlC?=
 =?utf-8?B?RnJ3OE1kTTUzUHlvbUl4Z3BQaHJ0djliZ0tXSFFCdld2R2xXSU80R0JWSFpV?=
 =?utf-8?B?Y0I0N1BBS2ZpSW5pMlRCdUdXSmtacnlKZHp2ZklDMFJTQWU1K0dqNVk2K0Yv?=
 =?utf-8?B?djYxYUdjd01BUmNhVldXY3BtdENnOEwzRFhGQlNnd2lmQUhaa2hHVzJ5eFVz?=
 =?utf-8?B?dVU1VnFGQmhvdDMvak5LYkd5SEtFV29YdHdKeC92eWI4by9mRkJoNkRqbGdp?=
 =?utf-8?B?amRJZDZOSTlac2V3RmRycWRQbnNtZEN1alcrU1E3WmVHUjQyclFZNk14ZDlM?=
 =?utf-8?B?a0pVQ2dNOG91UnM0dk43MTVFeEpYZmI1YlEweFB6LzkyeTZRbkRMejNGZ3Bv?=
 =?utf-8?B?U2NBQkM0NUVaY1o5VEQrWHBVN2RUUDNMOHJlZDNvR3lXdGd1ZGRjdzZPdGo3?=
 =?utf-8?B?M1JFQXNCbEdvMDI5VkJMai9lNzZvajJTVVFRdHNadzdLdUlYcnljaEZYVVlv?=
 =?utf-8?B?TkJMZ3B2OUdQQmtSTnhMYWlPZFMrUGlkU29ZZXB2RG9QdkN6YzlCN3BuMWhs?=
 =?utf-8?B?SHFKMzIzNFBKa0t4RlFDQVR6U0xNRHhZR2NIVWtmcHhRZkJsUmFiSllyUjhr?=
 =?utf-8?B?R2tWRFE3UHZDR1VXdkFvRm9Lb3Y3cThJQTVtN3FBdXl6aGxiaG4xZ0FkRVVu?=
 =?utf-8?B?cHVORDBXa28wNnh6eitpOFVXdjZSQ0hQTDNwa2FYNk1VMFBnNmdBNldvMEZY?=
 =?utf-8?B?NDR0N3hIcDRJTFBNWXRaVGRIcEhFY3Qzc1RXOUY0bHR1ZFVHMnplU1ZXaXZr?=
 =?utf-8?B?dkJTVkV1Wm9CbnM3WnYyMVk2OHN6Q21JOU4xMVpKL2FDZHl4ZFoxSWVRbXN3?=
 =?utf-8?B?eS9ZaDlJK09UV1NLaTZ5S21LNlRiSFg5bURxYmpIaDNLcWcyZGZNVzFFL29o?=
 =?utf-8?B?VlRrUzRiVStkL3dZMUZOOEpPQ1A5eTcrQmUyVVJtaEJGeS9XaTdSeElPbFJL?=
 =?utf-8?Q?DRM16bDxN1oUq2npaNGijUSM/?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b792884b-402e-4a22-1fc7-08dd5162912e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 03:56:34.1833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IORP9rkEbwxisBFcVTwhZfVs/jJEyIjuyW0h44nvae1+nz+KyHTKpIfXpftTUa+VhEh7MvmwrBqcb3EdPeLlQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6918
X-OriginatorOrg: intel.com

On 2025/2/19 21:10, Jason Gunthorpe wrote:
> On Wed, Feb 19, 2025 at 08:31:52PM +0800, Yi Liu wrote:
>>>> And then iommu_get_domain_for_dev() which explains it is an older
>>>> function that depends on the caller somehow ensuring that the attached
>>>> domain cannot change. Ideally we would someday try to remove calls to
>>>> iommu_get_domain_for_dev()..
>>
>> currently, the paths hold group->mutex are mostly in the iommu drivers.
>> So what we may do is updating the iommu drivers to use a version that
>> has lockdep. While other callers keep using the iommu_get_domain_for_dev().
> 
> Honestly I would prefer to pass the old domain in as a function argument to
> attach and remove the calls entirely.

hmmm. I may drop the retire group->domain from this series to avoid
blocking the iommufd pasid series.

>>>> Since the xarray cannot change for non-lockdepable reasons, it can
>>>> just call xa_load(). Probably re-organize iommu_group_domain() to have
>>>> a __iommu_group_domain() which has the body but no lockdep assertion.
>>
>> another approach may be holding xa_lock when retrieving domain from xarray
>> in the iommu_get_domain_for_dev() helper. This approach is consistent with
>> the usage pattern of iommu_attach_handle_get(), where callers also do not
>> acquire the group->mutex. Thoughts?
> 
> It doesn't matter, the pointer is unsafe the instant the xa_lock is
> released.
> 
> The locking works in most places that don't hold the group mutex
> because they rely on a driver being probed and the dma api keeping the
> domain constant during that period.

yes. Since group->domain is set/clear under group->mutex as well. So I'm
wondering if it is ok to add kdoc to iommu_get_domain_for_dev() to note
it, and just add the xa_load && entry_decode stuffs without lockdep?

-- 
Regards,
Yi Liu
