Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0FC1F891C
	for <iommu@lists.linux.dev>; Tue,  4 Mar 2025 07:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741073968; cv=fail; b=kEKN7RYk3H5fKHzHByAJUvB3Nmw+NM+4L1LvRq4vIOpkMpgWyWh1RP6qAXuftOTrriBs5zSCwzcTkd+7zYOWNgAqiF/8rncrNROzDawZbnR+J+mVSgGvx3K8NRqcA/rA0EJ4e6bmwvSub/1kuOGIp9svfwdlqJUD/uN6ZdS6ojM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741073968; c=relaxed/simple;
	bh=rf+C/VdFXZxNA4+ITnis3fM4GkyuzV0JW5rFLF6q7wQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TvshAl8j9SQFr7xp2CUJd7ejWp9/LAxnyeXYqVF5o38Az5IFmxCOa8LTN8+vNwu076/6+A1M2ANoyo63Y6JPsR27062cMc4/m9Lw8YJuCmX1aw1Erd6L5fX14pFgOiCVyY2zmYhCnoPlxfuWjS7Hu3aq6EIT0dvwYpMItlxZsJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l/MwqdX6; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l/MwqdX6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741073967; x=1772609967;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rf+C/VdFXZxNA4+ITnis3fM4GkyuzV0JW5rFLF6q7wQ=;
  b=l/MwqdX6abRmLZmDDjR5rYGs1gl5DtJKIbR/eaz/mfs3uZO+HUsSQv9Y
   LE0spz0DrfqbFDf/852zpMO8QJSfSYXtPDNrqzK6tUkc5WOEjTldyQFOg
   nAO8lMBs/hg0wlozsk3bZI60DIjfEecLdodEOGG+nVGfkZureNW8AstiR
   dR0E9JsINP8mPornEeUikjB7AvAHgrpCRd+5Bv08NOKWqvsdcubKIEb1S
   QJVLLWgrx+JEMsAOXVKg5ajNGNpCPbCGaLOZDxjB4al0NQDzVsciQp9y7
   S4QFQ8fHTdP/cgL8HMJDP6YzMzjqSlC2i0W2UWqiCkhkKIy+hnhyjjVgI
   A==;
X-CSE-ConnectionGUID: t2IKJjbIQb+yHE9ljmzI4g==
X-CSE-MsgGUID: 7r0mVZWxRd6listTCptrQw==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="52959097"
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="52959097"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 23:39:26 -0800
X-CSE-ConnectionGUID: VpK/qc7+T1Sts/Vppp3+wg==
X-CSE-MsgGUID: YrCgWdaVQSmCeU+S6E7IkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="122910453"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 23:39:25 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 3 Mar 2025 23:39:24 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 3 Mar 2025 23:39:24 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 3 Mar 2025 23:39:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CUpKkwVKr6RvdU0HzZ8AaoTG9LBwX6Y4FSsyGq5AbATEf+Jzm53+GThPRntxgXN5EEOD6LaQNZoG31swcTqVgcLLZgcLcz6NBWIUsRyt3pFCTuMuVdzjgz0HEjcuQkb3BUdi++WTmmz/8mdXj3vVs2sF6AiUFBjnQnGIMuI42ARIzs6ScgHVeGu+z9ZpAe9cVSL+uvaX5Sgp5mk6wZcp3FKqDT8wvHtPcwe3KLNkeeZn4np/rhLTOnjbZu36H5vhOWuCZgrxgowpjbyjvRojesnYW05mMLD9yZeS6l1t5AtKI4tdChQ+FLRYj+eKPvSnvVv75rMbsGPS0Yc4LT/+qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nDLldu+Caco5GNjEXtoYbNWGcGlzatBsk3qQ4AMntpU=;
 b=fb9Y2WnqWTmheAgaIV0lAPzPtk1fh4TAQUVWAvgLBFmFDNjr6aZNxTlcSh3rHjWuON4RhtIf04t1bt2cwrB7Qw9TdYWN+fZGjDy9NGgiNrxKAz9Av+LzyOPKEOAPha6RLprgePBfN0rSGz9QzI8I4mk/XJKdueVyNXS/NOi6hhj8beLP0ZjUeAYtk2Tiwr/VVlq8m8VCapypTtDjZ34YWqfjAdMp9VP3DecNgHqLOTjICb4/0+0Ory3df6DwUIV5rrq7+qJLanLi2Y1SiNe2M4lBc5vJzXt2Hhs71CNfXsPxFNMsnTzCjuZZpsDfZX9kEBPFZ0oAizPgt9lHvxWRDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by IA1PR11MB6419.namprd11.prod.outlook.com (2603:10b6:208:3a9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Tue, 4 Mar
 2025 07:39:22 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.8466.028; Tue, 4 Mar 2025
 07:39:22 +0000
Message-ID: <5969af0c-8ad9-40f9-a6b7-aece0d408816@intel.com>
Date: Tue, 4 Mar 2025 15:44:44 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/12] iommu/vt-d: Check if SVA is supported when
 attaching the SVA domain
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>, "Fenghua
 Yu" <fenghuay@nvidia.com>, Zhangfei Gao <zhangfei.gao@linaro.org>, Zhou Wang
	<wangzhou1@hisilicon.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
References: <20250224051627.2956304-1-baolu.lu@linux.intel.com>
 <20250224051627.2956304-3-baolu.lu@linux.intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20250224051627.2956304-3-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::15) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|IA1PR11MB6419:EE_
X-MS-Office365-Filtering-Correlation-Id: 203c20c8-81e8-4352-f5a4-08dd5aefadf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZmpyZk5DRmdDOHdMODJUK2h6MG1LRUNQeWprWWVsYWlEeDQ5ZGZuSjhhcDVD?=
 =?utf-8?B?SWVEN284ak9lS0xqK2xSMzY1cEgwWDBiWk5rc0V1Z3RPaFNMVzJpNkFLR1A0?=
 =?utf-8?B?UDd3b3piaFNMM3dsY2VxMksyWk5xa0d3M1ZQV1NOZ0VwL1krcXhvRnNqaXp3?=
 =?utf-8?B?SXRQY1BzaEdVUWJOQ2FZRjhieGZCS2pxaldsQzVlMUFtaDdXY1JLNHl6RHc1?=
 =?utf-8?B?UW5GdEtzN003Sytjbk01R0pnT3UxZGw3SG9WUnUxOHNxbEJKNHdTU3h1OHdJ?=
 =?utf-8?B?V1dLTk1iYTU5MnNPWkJCM1lUS3FxMzdMWEhKVkhDeWV3Mi9KNytVeVlETzZD?=
 =?utf-8?B?c2gzZjlYNmFhNUZFVGRpZmJUWWNuT0thb1hkMXpDZTlQbkp6VE5PQW04MGhW?=
 =?utf-8?B?MkdTWUd6dGpJMGdyT2wrN3ZybTFlZlB0MWR6ZFZrWUF1S0w4U0xvWW1IK3lV?=
 =?utf-8?B?U1VuNlY0RDNmMGVGSUV3dmU0SWhjRzZUSWdtM1dreUFON1JlUWJvbXQ1bWNZ?=
 =?utf-8?B?WlJZZXRwVExtVmRnZk1Zd3IxaHFQMTlHVU02T2g0em82SUh2R2hhcFREejVB?=
 =?utf-8?B?cWpPQ1JlRlRqSXQ3aTlvYkJNdVJWRlBwQlBwWDhIVDN3LzFldmQ4TExNYTIv?=
 =?utf-8?B?dlpzcE93YU9RbGxKdlg3TXpwVFhveXQyNW90dmVZemJ3OEh0T3FhOExkbktF?=
 =?utf-8?B?NHBjNTVoT0o2Y3VDNExGTVJ2UnpPT3NhQlpXYTF3MWU1TXdvZ3JZbDhkVlhv?=
 =?utf-8?B?R2FITDltNERpcEFjdnNvbENTczZKN212SnRBQVVoMU9sSDRNMzZUL3NTQ1R5?=
 =?utf-8?B?VVQ3cFR3am02eVhJQXl4Y2s5Y3FadjFFVnRLRk4xcjVNSjN5WHNOMHAwK3M2?=
 =?utf-8?B?T3A5NEJkZXVJZnJhcndhT3Y1RWp0dWtIdUhTejlzRDF6c0NyR1RnNDhFVHpE?=
 =?utf-8?B?Z1lzK2QxaFRrOEkzK0IwNmlsc09lY3BUOGlQditwRXpTd0JKcjVTbTYrYWhF?=
 =?utf-8?B?N01lbFFoS0FwOWcvZFBwL255ODhSV3RneWNxK1dVdjNTTlgxTDBtZHlLdUZt?=
 =?utf-8?B?WnA5TDF3ajBpOFp4U0ZIc0piWlIwa0oyT0swMUtUbG1GYVJyUjYwS1RMdWxN?=
 =?utf-8?B?bnlZN01SVGlMSW1iYkZERzBUdkdjSDVPUWFETi9SNWxWbGxEbXNsWkgrUFlN?=
 =?utf-8?B?Y0ljTEp2Yi9XSUswRXBRdGhxdUlqMlBYOTd3aEU2WnZpbGsvbmpaYUNnODhs?=
 =?utf-8?B?YlJkZFo2aXB6YkZvbEdvZU9PVURqU1pkSEQrTUtxUGkzd0Y5NVZKVFcvd2d0?=
 =?utf-8?B?OVYrM0RnYzJIOEM4VTN4eW9STGdqaS9BTStOaGx0ajRYZnZVaUNKdHVtVkNm?=
 =?utf-8?B?aGxtWFpuZDJkVzRFL0hlYVZZVnhXNFNwRitLYzIwdHluWGJZSmNVOHdZMjU4?=
 =?utf-8?B?clcxazRQZDFNWW94VnkrdURPL3Y5UzRRdUc2cmNEenFxVHc0YnlROWFnWTFT?=
 =?utf-8?B?bTNueWxNcVRuTjVocy9Rcm0xYlQ0Qnd3bk1aNW9LS2NtZVZJQWd5Y05xTE9j?=
 =?utf-8?B?bytNbWVidlFRSmtSOEVkc09ReFFGb2VDRGduTnA2U2lPclhwWDFnWnZ5R210?=
 =?utf-8?B?VTlDeTl6S3lybzdXTExSc1p1eFFhaUFYK2MxNWtBbXRWc1JmM0NlUEJCQ1Mr?=
 =?utf-8?B?d2hTUWMyWVNVcnh4WUM3Z3ZIcEYrakwreUxzS3ZiYzJaODJqR1JzMzI2TnU3?=
 =?utf-8?B?a2NRMFlYNFFJYVlTUTZhWG5kVUxKbVFhUDkxYlhLYnVySFlkZGlWSXoxcE9W?=
 =?utf-8?B?RWRkVUNrd3Z6VFFPZkI2TGhXYm1TN29mY2dqeGp5YTZzSzRSaEwyaUc5RjRi?=
 =?utf-8?Q?rVSONd7cQhYzP?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ny9xT3BjOEVnWXdYZ1FNRDVJNUJPUDBqTnNoUTdJL3VFelVmT0ZlTi9CdXpV?=
 =?utf-8?B?MjlXekw2YmdoOXJWNjJtcVdWWldkcEpvWldzeE9USWlOMnltUWNuWHRrOGJO?=
 =?utf-8?B?NjUyZ2xnb2o0dU5jS2w3akp0b2lKQ2duMkZsWlhhUnBuc1VLZTl2czFvT0pV?=
 =?utf-8?B?TTZxKy8vRWtMaGRRSEpoY0ptRG9tVFd3c1kxOXJqZWxaQUh4ZnRUSWQ2WkM1?=
 =?utf-8?B?bkdoLzF5ay9qK3BVbXA0alpRdDRtUHVueE42Q3hCUjZzUi9ENEljZ0wrRWhP?=
 =?utf-8?B?eHNNUE45QVgzSDlNbERwQ2MwcmpiblVRNUtUYll2aUNObUlHWUNYWFRUNmF4?=
 =?utf-8?B?dUtlQ0pPSTFJYXk0ZGM0VWIxS3B0dTJDRlVGYWNaM1ArVFF6VHBKVWQ5czVz?=
 =?utf-8?B?eDF3cWU3NHRsT052N3NOZTFMbVZrK21hNHcyalNQQ3d1MjlxN2dHd0IyMUJx?=
 =?utf-8?B?LzJMYlgreEd6aDBhUExmODE2UGd3SkF6L3Vwa3FubnhyU1VsdnYxWStRMVBB?=
 =?utf-8?B?RDB5MjN2RjlZbE5hU0M0MEVwVndORUVubDNGeXFkbkY3NCtBTmplak9icTlt?=
 =?utf-8?B?L0wvUGNKc0dWM3p1TXVxaDVOVmorT3BCdjRPQVM0d0VlUFVKRlpBbSt0MGlX?=
 =?utf-8?B?M1pFdXpGQjhJeVJCOEphbXRWWGhxZ0lTTmxBWGpEME1YdHdXRWVLVnpRSHVi?=
 =?utf-8?B?ejdBWTlJWWZlcW5jWGp0Ykt3NUhKVVRmT2sxU3NXUmdVSWhxbCtEUFdDNzl6?=
 =?utf-8?B?NUl3TTlCbEpxcmEzbUxLL3VueHU2VGxOUlVnTlB1ZHdmTktKRjBESk9ZVUVX?=
 =?utf-8?B?S3NDMGJkZmMwTjN4cVlJUENoQ2ZlWit1azJyZEY1TkZxZkFyTEM2NGhUT2Fq?=
 =?utf-8?B?Sk5ZcTN2UGp5Z3MwZ1lKYnNwN3FLa095c0hRZmlJMVVKOURFS05KT3lsRzFk?=
 =?utf-8?B?TCtaOHdWYmo1cXRuK3JHVTZlenNaUWxSckdVeEFwVHhSTElHcTlKdEllSlNx?=
 =?utf-8?B?VUFJeFJ4dERESW94cDVQQ09yYjV0WWNvbDFTcWdVODFvNm4va0JlN0kzalcr?=
 =?utf-8?B?dGcvLzJBVmUwbExBNlJuTEphc3BXSmRIZ1RrMzJoQThEWWhXSyt3ZlV6QWYy?=
 =?utf-8?B?bEdFZ2ZFUk5zL3pScTQvYnphT2lxY29ESmsvTlUvM0VlTG13MVRYQmtHRVZu?=
 =?utf-8?B?THNGcURaVVJYRTZxYmFtWFZsaURuUTcxSVJzT2wyeHJZeTVrSStoK2NoWlhw?=
 =?utf-8?B?R1pyUG1NR1o2VzhaTmRuam9YZENjSVArYVFGQzloaUtidzlJVUNTakE3UFVv?=
 =?utf-8?B?QmpQdm51aC9uZjFkRFBxZGJlMHVDMURWaHcwNzJzdVVrSG5ZY3FhdGVmLy9V?=
 =?utf-8?B?NFZ5KzhyditQMHIwQ2ZoNTA4OWlKVTc0UEdOcE5rci8rMWFVUTJMYjA5dlB2?=
 =?utf-8?B?SGl6TlZyYVh0WUs5aTNqa3YyNlJLL2pmYk5VVW9Sa0FWRXRtYWMyaUdIWFNq?=
 =?utf-8?B?L0NSTFVtRUQ0eCtralJhYjBzN2ZnSERYNGYrQkdZVnFHQVpER2JsM3kwa1lK?=
 =?utf-8?B?eXBQRjFtVlRkZDlkeTZ6dGJnaUhKN24yQ090VnRROFZuMzFZdDBkOFpibWtE?=
 =?utf-8?B?bEpsSzgwZTBlYy9yYUZBNVkzbXd2RHpnNlJxc1ZNQ0g0QlZLS2xvMERRdFd4?=
 =?utf-8?B?S3NkaTFPUnFWOXowVUhJSEZnOEE2RVF1UENMOWN3cFBJNTQydS95U0ZoSU5l?=
 =?utf-8?B?dGMxdjVja3ZlRTZ1bXZYVzhjWnRwVHFPcGl6T0NDbHNNM0VUbjdTTHFYNzU1?=
 =?utf-8?B?NzQyQU1CV0VYeGNETFJPNmFTcHlJbzRZWGlEcVIzYjBGd01YbkR4M2ZPb2JJ?=
 =?utf-8?B?NDlpVWpIcDMrbkRYMU9qOE56UDlUK0thOEF6MHRyQkh6TmtBNUEvZEFhbjM1?=
 =?utf-8?B?amtHbFRFQTluN3RSN3JEZ2wxbGtQdDdKWm1SQXBnd2Z0VVBSUW51eUhFb1Rx?=
 =?utf-8?B?RTlFSjZ2cGpjWUFiR2NJYmhCdmxHREd4K0F4bVMyYkNKbUtzKzJkeGxPUThF?=
 =?utf-8?B?cUFER2c4emhYZDNaUTNHcCtEMmpTRUQ4Tks0aGdleVduV3hsU1IzWElBZzlx?=
 =?utf-8?Q?dUpbX0eg+v8RlMydsL7vs47iG?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 203c20c8-81e8-4352-f5a4-08dd5aefadf6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 07:39:22.0304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OG/7kid5bxuyay0p3feaw5aSc2i8k8Xi0zqIu4uBQgyCPamVAoeLpudq39xURY7RG0l7Zu3cR4oltzJ4Xzzgwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6419
X-OriginatorOrg: intel.com

On 2025/2/24 13:16, Lu Baolu wrote:
> From: Jason Gunthorpe <jgg@nvidia.com>
> 
> Attach of a SVA domain should fail if SVA is not supported, move the check
> for SVA support out of IOMMU_DEV_FEAT_SVA and into attach.
> 
> Also check when allocating a SVA domain to match other drivers.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>   drivers/iommu/intel/iommu.c | 37 +------------------------------
>   drivers/iommu/intel/svm.c   | 43 +++++++++++++++++++++++++++++++++++++
>   2 files changed, 44 insertions(+), 36 deletions(-)
> 

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index cc46098f875b..a4048de66378 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -3851,41 +3851,6 @@ static struct iommu_group *intel_iommu_device_group(struct device *dev)
>   	return generic_device_group(dev);
>   }
>   
> -static int intel_iommu_enable_sva(struct device *dev)
> -{
> -	struct device_domain_info *info = dev_iommu_priv_get(dev);
> -	struct intel_iommu *iommu;
> -
> -	if (!info || dmar_disabled)
> -		return -EINVAL;
> -
> -	iommu = info->iommu;
> -	if (!iommu)
> -		return -EINVAL;
> -
> -	if (!(iommu->flags & VTD_FLAG_SVM_CAPABLE))
> -		return -ENODEV;
> -
> -	if (!info->pasid_enabled || !info->ats_enabled)
> -		return -EINVAL;
> -
> -	/*
> -	 * Devices having device-specific I/O fault handling should not
> -	 * support PCI/PRI. The IOMMU side has no means to check the
> -	 * capability of device-specific IOPF.  Therefore, IOMMU can only
> -	 * default that if the device driver enables SVA on a non-PRI
> -	 * device, it will handle IOPF in its own way.
> -	 */
> -	if (!info->pri_supported)
> -		return 0;
> -
> -	/* Devices supporting PRI should have it enabled. */
> -	if (!info->pri_enabled)
> -		return -EINVAL;
> -
> -	return 0;
> -}
> -
>   static int context_flip_pri(struct device_domain_info *info, bool enable)
>   {
>   	struct intel_iommu *iommu = info->iommu;
> @@ -4006,7 +3971,7 @@ intel_iommu_dev_enable_feat(struct device *dev, enum iommu_dev_features feat)
>   		return intel_iommu_enable_iopf(dev);
>   
>   	case IOMMU_DEV_FEAT_SVA:
> -		return intel_iommu_enable_sva(dev);
> +		return 0;
>   
>   	default:
>   		return -ENODEV;
> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> index f5569347591f..ba93123cb4eb 100644
> --- a/drivers/iommu/intel/svm.c
> +++ b/drivers/iommu/intel/svm.c
> @@ -110,6 +110,41 @@ static const struct mmu_notifier_ops intel_mmuops = {
>   	.free_notifier = intel_mm_free_notifier,
>   };
>   
> +static int intel_iommu_sva_supported(struct device *dev)
> +{
> +	struct device_domain_info *info = dev_iommu_priv_get(dev);
> +	struct intel_iommu *iommu;
> +
> +	if (!info || dmar_disabled)
> +		return -EINVAL;
> +
> +	iommu = info->iommu;
> +	if (!iommu)
> +		return -EINVAL;
> +
> +	if (!(iommu->flags & VTD_FLAG_SVM_CAPABLE))
> +		return -ENODEV;
> +
> +	if (!info->pasid_enabled || !info->ats_enabled)
> +		return -EINVAL;
> +
> +	/*
> +	 * Devices having device-specific I/O fault handling should not
> +	 * support PCI/PRI. The IOMMU side has no means to check the
> +	 * capability of device-specific IOPF.  Therefore, IOMMU can only
> +	 * default that if the device driver enables SVA on a non-PRI
> +	 * device, it will handle IOPF in its own way.
> +	 */
> +	if (!info->pri_supported)
> +		return 0;
> +
> +	/* Devices supporting PRI should have it enabled. */
> +	if (!info->pri_enabled)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
>   static int intel_svm_set_dev_pasid(struct iommu_domain *domain,
>   				   struct device *dev, ioasid_t pasid,
>   				   struct iommu_domain *old)
> @@ -121,6 +156,10 @@ static int intel_svm_set_dev_pasid(struct iommu_domain *domain,
>   	unsigned long sflags;
>   	int ret = 0;
>   
> +	ret = intel_iommu_sva_supported(dev);
> +	if (ret)
> +		return ret;
> +
>   	dev_pasid = domain_add_dev_pasid(domain, dev, pasid);
>   	if (IS_ERR(dev_pasid))
>   		return PTR_ERR(dev_pasid);
> @@ -161,6 +200,10 @@ struct iommu_domain *intel_svm_domain_alloc(struct device *dev,
>   	struct dmar_domain *domain;
>   	int ret;
>   
> +	ret = intel_iommu_sva_supported(dev);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
>   	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
>   	if (!domain)
>   		return ERR_PTR(-ENOMEM);

-- 
Regards,
Yi Liu
