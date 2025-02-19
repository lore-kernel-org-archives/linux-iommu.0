Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC281DED6C
	for <iommu@lists.linux.dev>; Wed, 19 Feb 2025 12:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739968003; cv=fail; b=ZhbAij2SWW8c9gPmpgyGc4uE81Y17ZY6rh10BIuFGON6ZUxnPu2ppQT7MZwoPPHk1vFi3NPGdSFreO5o+i86wv/Nn2x3yNTw0OrtWJIheyb8QyA03hky+dGgZDV5ZFb+9LqkuAS+H7x7Bt95htU9z3gopuu2I4OJK4eloDiQ2w8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739968003; c=relaxed/simple;
	bh=LIWSovh3u8ctUNP5buq8msvrH4tXE3hkYAfpgKYLbJg=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AeKO54sK5FM+o5ytD/bcfVgeBcKD56UAh4XHbUnO9bGly8Wj1hbNrGdUrOrUCclcrcdCVOvkmqQWSo3WFZXLQzahll6mmlQQCbNOPlxWr9dKroJNzOIQbVZRHgaRYntubSgJaboZvfj3Z0KnifsgJ/jgKMW+0io1R/GrM9GlD08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gyu1cEya; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gyu1cEya"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739968002; x=1771504002;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LIWSovh3u8ctUNP5buq8msvrH4tXE3hkYAfpgKYLbJg=;
  b=Gyu1cEyaqUvB3oUUAuD1EhwKIEH6k1fv0AUtOWYR7Gdb7OzYmBPdkU6H
   QQfdSaKufrJ+7/uXGZo1Lu2K/TuGNokFHZ6ALWfKfgr42E+gA3NP5MDuw
   zd8aGZVmcS5Pk/vEW/yufcIs6xzC+d5t317MxtgkRljLVQ0aUnbPUrXe3
   uA5hQb5+Ly0QYLjnKBBodLMcgao165ZVzZhM46KQ6yijU5ph2E+yTC8FF
   QqAeoqyx+9hC+xcjJO+HbAMqcXefkg/2Idt1CDR73WZChF44nakKHRStg
   cNyuJZSyjc0lBoJemVe275NJkTUN8LLx3THOIRX0CbXnO/c9S9yNrs812
   g==;
X-CSE-ConnectionGUID: 9ZN8f8LzRKKdkO2uZOALBw==
X-CSE-MsgGUID: fDUU8C0TQcqWaT1KHL7kLw==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="51341439"
X-IronPort-AV: E=Sophos;i="6.13,298,1732608000"; 
   d="scan'208";a="51341439"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 04:26:39 -0800
X-CSE-ConnectionGUID: AP7M9dvvRUKoPo+qhm33kQ==
X-CSE-MsgGUID: tx3irXFtTOuZIu2u35UO6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,298,1732608000"; 
   d="scan'208";a="119678966"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Feb 2025 04:26:40 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 19 Feb 2025 04:26:38 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 19 Feb 2025 04:26:38 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Feb 2025 04:26:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TPFTe7CDd8MegkQFvaXYvK1NJBhOKTrfkp9JfAPiBD2acjz4VQ7LpwfquaveFRfWiRiMMacsursS4lcX3gjxD3P4x7otv9VYvwqMVmiE97NRD8DQUjcjY/FvyvV+WvNf+p1TEYjfEO+49IHz5Z1mWr7TFRL5KA3WBpoYUVQpnpODSDdS3QgjeeaeZAZ5ne4SfSLNgRYrIvC9M/3QQ5lDnfSQ5dk+9OJt7l2Di3eJiQOLFVcgHtoxWfrO9ApjewbhxIq11SlmoWh3vKn6Y/7PEtQ4xsjuQgcvQcW/URWuZxTJq6txZzT8e578H7ioZMT7mRo4Z2U098Rn9ZIfiDODOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/vQhNgRCkxDubpIcMk9uflyD3enhByLrbNg4PhJF5js=;
 b=jEJrAm1cnB5XV02NxddjV2SPF2Jcpjm2uhpvjiOfKtkQJKaMV+9r38tBQH0vZ6qwDwv1Yga6AWeZYM52RvjlOcur6a9NfYYms1aJ9LL1g9HUJa72aCPQepsauDzvZW8FNZp/HIuNN7ek9RenBoH+L2BXx0Q1fBRUJGl85/CR+9SEbhYIL6pWm7/y7y/oCJSAxhtAPO/bZ3BaZoR+4OsZ8GFG8hi/0tm4FcHO5WnDBhzL9JlcN4QMmzbKG4NQ3j+B+WFKBSx/c7NrxUtKS7UkNLS3JmJf+W13dTFcXzDzHhuX43iU78butov5Mo9vBauAu/BRlM1IHgrg6kUb6VyNjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by PH7PR11MB7595.namprd11.prod.outlook.com (2603:10b6:510:27a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Wed, 19 Feb
 2025 12:26:31 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%4]) with mapi id 15.20.8445.013; Wed, 19 Feb 2025
 12:26:30 +0000
Message-ID: <7a6bd064-afec-4492-b703-f076c50d41b1@intel.com>
Date: Wed, 19 Feb 2025 20:31:52 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] iommu: Retire group->domain
From: Yi Liu <yi.l.liu@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <joro@8bytes.org>, <kevin.tian@intel.com>, <baolu.lu@linux.intel.com>,
	<iommu@lists.linux.dev>, <robin.murphy@arm.com>, <nicolinc@nvidia.com>,
	<will@kernel.org>
References: <20250212060540.261436-1-yi.l.liu@intel.com>
 <20250212060540.261436-6-yi.l.liu@intel.com>
 <20250218193909.GF4183890@nvidia.com>
 <1df9b532-1b42-40da-8499-503f53ba8998@intel.com>
Content-Language: en-US
In-Reply-To: <1df9b532-1b42-40da-8499-503f53ba8998@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:3:17::26) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|PH7PR11MB7595:EE_
X-MS-Office365-Filtering-Correlation-Id: ffc808c3-ed60-4cf1-0ead-08dd50e0a367
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MG40MEg1V0Y0ZDhzdmRtcjY5Y3BIcEV5K21tUVA4NHdCTDA3ZzhqcGxXU0xk?=
 =?utf-8?B?cVV4aW84TitoV1lkM1J2RUxMZlVuczFwNSt1aFFVQ2ZMbFJnTXh0bS9idU43?=
 =?utf-8?B?cFk1TU5kR0U5UVJFWFBOcEE5cXYzTHhPT2FOenNuajNERHVyV016WmFBUHRj?=
 =?utf-8?B?TndkeHdjZnpldzBOSUJYNHpXRlQxamdCK0FFM2x5YkRIaVAxcldsakxaam43?=
 =?utf-8?B?bUZjajlRUjNORXV4TGZYdm9kMHNWOVkrUTRoYmpOUVQ5VEh1OU4zWk8xc1FP?=
 =?utf-8?B?OWwydlIxWGNoemppZlg2V0RhbjFTdElWdVRtQyt1VXdNQk1rSGlPeEIzdHhq?=
 =?utf-8?B?cmxlM3hNSTJuck9mbnpvc21MTjhQS3QzbEpSdmNnazZPd1E5RXZmN1B2UUVk?=
 =?utf-8?B?N1MzcEdNUGpDMjg2NjNTeTBDbXVTbzlETlE5ZWpsNlE1bFc5MEhrZGJNQkJn?=
 =?utf-8?B?dENDT2kwZXFQY2VmdEhucW84MjNIbSsrTVNkYktlVXBmSS9DWjZ5RnFEQ1Jj?=
 =?utf-8?B?c2xSS3FSQnB0dzdpMENFOE5lZ1hFaTRDL3EvaEhLbkRDckZ6VXk3eHBZaVN5?=
 =?utf-8?B?QW5kTVZvVzFFazJYM0RTOW8zQm92SzNHMlUzdHR1dUozcTdxUjZRQlpJM1pl?=
 =?utf-8?B?dythOVBmbXo0WXVzTndQdStSRTllaTUydGdieVBSMVpFOUV1ejhTWWwzb2lT?=
 =?utf-8?B?K0tRcllaWmdhSTREODRsb2RHUngzQW53ZWx5elhzZmZZR2hyS3VjUFNyV3Bj?=
 =?utf-8?B?Sld4VG9KWVFOVVdSNWpNdUNkL0szbk05SlF2dWVEU1dxRmZsQ0RRU1R2c3RV?=
 =?utf-8?B?cjc2SVRtU2ZhcmZwRWsvT2RZUEFSZjJNNjh1TWVldVl3dHNiTGp4YkVwREgr?=
 =?utf-8?B?RHpiYkI3Uy9FUVV4elNZQXVtWUFmQlJmTHk1N1ZLM0VxdDVGdy9xQ05IbDBI?=
 =?utf-8?B?Vml3MS9DekordWpYL05WMFdZWFl1OFhzSVdtVFA5SUNNc21QQXluUGczeWZk?=
 =?utf-8?B?ZCtGT2V1blg0MW9xNWFJVkJVZ0lvTU5wblhPdEJCM0VhZWxSRmhPOXB5bUFV?=
 =?utf-8?B?QklPTjkwTy9mSVB6d1VBUi9FTU1GWXQ0RW5CNTdTYXh5MHMya1F5VW0xa3NU?=
 =?utf-8?B?TnVwbzJWblc5bmNlcmV4RkVza053T01tQXpYRXFualVUUUxsOFQ1Z0hDbElz?=
 =?utf-8?B?ZWRoV2ZXaVdNdHlNbFhRTmdybTNmeDFENDhjc2ZoRDB4bG0wTjE4REllOU9V?=
 =?utf-8?B?VUQvYjQrbkV5MHM3L1ZtYTlkRk50dGEwckt3UUE0Mjl2QmFCNElORy84SVYv?=
 =?utf-8?B?cHR1eWFqeFgrWm5OaWl0VDBnVUh5dXlHaDJ1WXNnTk5DVnRSRUNTRHRvZEJE?=
 =?utf-8?B?K2dscm9aTTU0MGlwdGNTemZUaDJmMmZEK2JXMmtRVDJSSXhKdWl0SlkwRDNK?=
 =?utf-8?B?M3ZxbTZ0cHpRaVVqK0ovMXpjR2Y0a1VMUWt2ZGtRcEF3cDkxam90bmNvMWNv?=
 =?utf-8?B?SnBDZVc4MU9FTlBVSGdBWmtwUzJlaE43R3JiZFd0R2RLcGd4SHM3OHNTZDJG?=
 =?utf-8?B?d2M5dXFJejRWbkZrdG5SMnZxcGhNM1BxUTFBSE9qR2tYdEZzTzUxRG9iUXdK?=
 =?utf-8?B?Zmd3QzFFZEhMalcyT2hTbHJ4V1BxY1JHT1hCb0I5RExtd1BwQ0hVMGVoMmht?=
 =?utf-8?B?Q2FUVUlmYnZxZ1FSUzVhZWdxS0V2NGFoMDUvS210OUpoRFQ3cStuVndIbVNl?=
 =?utf-8?B?NTV2ejIrV0xFTCtoYjc1akRFdUgzamhYS0syUnUvYkpFYXdERTFCVkZWekhI?=
 =?utf-8?B?cG9idzA2d00yQnlEV3MyYkpVWk1yRDVuRUVqU3FmUHRjTU5oYTAwN0xNN003?=
 =?utf-8?Q?Mki2drYYnQgxR?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWNVdUZNTXJqbTVKSHhZY3ZVTTBoTXBFYzBHK2NXRzdyREsxclVGbzB1QXJj?=
 =?utf-8?B?STQ0VkJJTDFjWC9XRVhTTVpvQVFEbStHQzJ4V1VkTHpmbDJZMUdBZUNzYzhK?=
 =?utf-8?B?dlRkdmdzNUdqRUE0RFcxdXpVRWIyT3dXeUdXMjljYlVzaHlXRXY4ZHcrWUlE?=
 =?utf-8?B?amczRjNGOUUwZ0g4THB2UHNhVXpvWGVtY2ZINVNid0FleDU5TVV3RTNqazN3?=
 =?utf-8?B?WXExSkJHYWNOaUppc3QvT0FNcDBHQUd1NWJRdVczSDhWdFdjK3YrdysxTWly?=
 =?utf-8?B?U0lEN041QmY4NnNFaHNKakFHeUxXbGROZ3NCNmltcWh5QU05Nm9WMTFOd2d6?=
 =?utf-8?B?RC9sbDNRSTJJZWtPY1pOeXY0Y1Z1ck12V2hESnZzVGtwSmtoQmo1eWRkRHp3?=
 =?utf-8?B?anh2S0cvUXBtVkFVR1htQ1VROTFleW5HNGJ2RWxHQ2VlOVkzK0JLM21JZUtO?=
 =?utf-8?B?bXU0VjN2NG9EUnVjNjVBUjA3SFRiMWJDREpYSWRiSW5ReFBTa3ZrWjdiUmta?=
 =?utf-8?B?WXMzZ0Q0NDM5M09nTlNpdHNHUEt6c244RW51L21RZGtyQ01jUE1WN1BwbGhP?=
 =?utf-8?B?OUYxVzBYNG5YTUVvbzU2dXNRcFlBZGVyN2U2bDhwUE9sMW1Bc1RDWjkzNWZO?=
 =?utf-8?B?M1NtYzNodnYzUTR4SlhuTi9OdWNYT1VwZjlMR0NSQ3RaZ0lWTVFLMklqR3JY?=
 =?utf-8?B?L3dCd1ZyQTlYQkVZTlRyVnR3OGpybUhpdWlNSlRPM2lHUWIvV0pNVzY4dVpO?=
 =?utf-8?B?OUdLdnFHQWJMMjZtTjFza1FNWVhGMDhKUFdWNWFaZGxyb0xMS3pRdnlMQ0lF?=
 =?utf-8?B?RWlGb2VLd3NieGJNbm4xYTJlTkkrN3oyRWtSemJodkd0YmJEN29CVFBKM0o5?=
 =?utf-8?B?dzlKNTNOMTUxYjUyYkp2NG5lOXBXMWNUZm52SUJ3aFFLTXY1ckp1VGNudW5w?=
 =?utf-8?B?Uml4a0hzOXRnSEFoWGFkdFZ6bjUyQ244WndrL1hvcTI5VFFvUGRDNlI1azJo?=
 =?utf-8?B?NThram4zcEl3b1ZsRnJoQ3hPTzNpbkxHQzFKck8rR2IwNG5CNHVOeFNXeFRl?=
 =?utf-8?B?UXNlWlp1UUNBV3FlbFY2NEdDaGY1dHZUc01mWWpEb1hxNzFXMFJSZEp2RE4w?=
 =?utf-8?B?b3M5bk13bHZUUFhnTW1iVFJBTm8wZzZjaVB5cTNTeGZxbnhVMFV4SVJ0TlA4?=
 =?utf-8?B?aUFsa2pmQ25sd01FaEUyL1FvYUJlUllhS0dtR2VpTDl5cDlqclRvSnpQdTBG?=
 =?utf-8?B?bVlJaEpRakVma0tIMVNEQnhuQlBqOFNRZkVNZ1pQdUd2cnRnY1hsSndiQWdi?=
 =?utf-8?B?ZHd5RzZ4NnRkZWdPTzQ0VlZzeHdWeVVlOW9mcWpuUkdWbVZTTTVkSE0zL3h4?=
 =?utf-8?B?YURuWVhjcitlckZMaHJ4azUvTjhwUXhUNTgvRUpEZG9tWnFKMUdFNjlPaStU?=
 =?utf-8?B?emsvSWI2YzYxZk5EOUpFVEc0VklyV1E1OCtTVy9ZVVJ4VFVWT01mSHJxRXZ1?=
 =?utf-8?B?K2dDSTF4OVFLRTlZSitYb0xTUVlEMzVHL2JTc2Y4SURNRzhRQ2V5NndvUnFh?=
 =?utf-8?B?L3ZGWmNBbHgvWDE4YXlCbTR5Yk1aeXc0YndMcjZwaDFycG5neW9mLzZzdmY4?=
 =?utf-8?B?bm51MnJ3UVozU2ZPZmVCUEZKcUZ0VVJsM2NlRThKc2V5cnJsVzAza0xzdTM0?=
 =?utf-8?B?d1U2SDhNcDhJRHo4NVJBTUJLd24xbkNKSC85ajh1cTJseEY1VW0rSklnSHBh?=
 =?utf-8?B?a2FGQ2YrVDVzM1VKU1phY2hRbWVYSk4yMDJOVDB4SUh1cWdFQTAwS0dWMUln?=
 =?utf-8?B?Y3llSWVEN2UzWHVCc0xVVW02TlZ2UTN4QUhhU3lkMWlwMG5pY1dsMUVjWG4x?=
 =?utf-8?B?VFYvZml3RzBiNklPWVFRaE1kTUp5VDdYaGJKa1FYd2ZNM3pja1JvL2thRFZX?=
 =?utf-8?B?TndvT1M1NUZWZEVCS0RDYUZUMEtGOEk5OEszRHNTbHNJMUIwdlZSWE90T0t1?=
 =?utf-8?B?Mjh6bzI2RHMxc1RQeWhRaE5FdUx0R3pob1dONC9iR1h3T0NRV3dVZ3hDRlN5?=
 =?utf-8?B?ZkY3UDJvUGl3YnIzKzExNmJpUm1TaXdzMGNwNnBtaHc2ZUhTdW56ak1CUUM0?=
 =?utf-8?Q?qZI8DQlyyFe8I1m9+3IQnDlMg?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ffc808c3-ed60-4cf1-0ead-08dd50e0a367
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 12:26:30.4067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 49el547mm+kx3VT63zP54yT+Mo0S33vIURG3LKJis0Ok+sAOAe71d0cGmGIqPyKgYocRKNH19604W0p6Z+eD+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7595
X-OriginatorOrg: intel.com

On 2025/2/19 14:52, Yi Liu wrote:
> On 2025/2/19 03:39, Jason Gunthorpe wrote:
>> On Tue, Feb 11, 2025 at 10:05:40PM -0800, Yi Liu wrote:
>>> @@ -2133,11 +2164,16 @@ struct iommu_domain 
>>> *iommu_get_domain_for_dev(struct device *dev)
>>>   {
>>>       /* Caller must be a probed driver on dev */
>>>       struct iommu_group *group = dev->iommu_group;
>>> +    struct iommu_domain *gdomain;
>>>       if (!group)
>>>           return NULL;
>>> -    return group->domain;
>>> +    mutex_lock(&group->mutex);
>>> +    gdomain = iommu_group_domain(group);
>>> +    mutex_unlock(&group->mutex);
>>
>> That will deadlock
>>
>> Eg:
>>
>> static int mtk_iommu_identity_attach(struct iommu_domain *identity_domain,
>>                      struct device *dev)
>> {
>>     struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
>>
>> And attach is already called under the group mutex.
> 
> oops. yes, it is!
> 
>> IMHO I would have two operations, iommu_group_domain() which lockdep
>> asserts that group->mutex is held by the caller. We should try to call
>> this function when possible to get clear locking rules
>>
>> And then iommu_get_domain_for_dev() which explains it is an older
>> function that depends on the caller somehow ensuring that the attached
>> domain cannot change. Ideally we would someday try to remove calls to
>> iommu_get_domain_for_dev()..

currently, the paths hold group->mutex are mostly in the iommu drivers.
So what we may do is updating the iommu drivers to use a version that
has lockdep. While other callers keep using the iommu_get_domain_for_dev().

>> Since the xarray cannot change for non-lockdepable reasons, it can
>> just call xa_load(). Probably re-organize iommu_group_domain() to have
>> a __iommu_group_domain() which has the body but no lockdep assertion.

another approach may be holding xa_lock when retrieving domain from xarray
in the iommu_get_domain_for_dev() helper. This approach is consistent with
the usage pattern of iommu_attach_handle_get(), where callers also do not
acquire the group->mutex. Thoughts?

-- 
Regards,
Yi Liu
