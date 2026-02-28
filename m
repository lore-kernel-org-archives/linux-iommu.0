Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E182517AF
	for <iommu@lists.linux.dev>; Sat, 28 Feb 2026 12:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772280392; cv=fail; b=c0Hag3jxQ0JPNLwRU6cEjb5tX2wfm37GIThx5dqtCzVRGMAghUJzozivA2ljlFDSKqVis/gzOBZQNLwI+dRe6oBaUcxaBcp9eTe6PBfBsGn8piGbAbgkXwR2TbCKxvSwobFObbdhH5aaFC1HoHO0FuGEYrjq4zPsEl8X0+bDWF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772280392; c=relaxed/simple;
	bh=t0IoxJTN4EVFMLlpVCMDYhFhWVJj1io+vuWvxPq9n/k=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bimSZaUUHB8/Wgspb6W7pJ3/PaMgmKdQGc1gwzeCvjgGwthCAmWSNfuTZFTA8s2zkr2RqAzLKNFnTU1YDfpOpE2UNDfYoxoD9f6v70gxDYj/nboawiWgc8K9uDo5aGNSIojpZZle7H34kAJmWwzGekAQ2Tfk0YPEJo8oGpygT7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BVJNGl5E; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BVJNGl5E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772280391; x=1803816391;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=t0IoxJTN4EVFMLlpVCMDYhFhWVJj1io+vuWvxPq9n/k=;
  b=BVJNGl5E48yXfRrhyUolz4JriLO2qRMkVaGCcGm+hD2Tbf5XardpBAnO
   l6c9kQRPz4pyLNHXxGcWuFzM7H/O4v3kypsVxlprOmFCDdHFndIPgEdII
   DxH3mV+ZEyqWeQevBqJKhCGgivDWa++jQpXihKGEGBJzPjMHRem3eYbfw
   cyEalvVbZupDtJBPTwOYJuDEkSrrVvjDgg2ga1ovPP0U3fTlMvvoXn4DH
   IojmXdmCuj4m3VqpIWRvBkVZD7vh5MXa3t19neyAp/u7np/5ZsgNeSd5b
   QoKw2oQSt88roApOGghGhFTkJlFFJFQ+m26UsFWtEBEGCm7Zam6Z+7lbG
   g==;
X-CSE-ConnectionGUID: nW+u6onsSpec00UcyX8NVQ==
X-CSE-MsgGUID: imLwFwfoS5el6ZH8r9Ye2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11714"; a="73460407"
X-IronPort-AV: E=Sophos;i="6.21,316,1763452800"; 
   d="scan'208";a="73460407"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2026 04:06:30 -0800
X-CSE-ConnectionGUID: OW58RxLLS0SMTSVcaD+Gpw==
X-CSE-MsgGUID: sjszY/PSQ7WwkQ52SEWGuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,316,1763452800"; 
   d="scan'208";a="214496034"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2026 04:06:30 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sat, 28 Feb 2026 04:06:29 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sat, 28 Feb 2026 04:06:29 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.30) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sat, 28 Feb 2026 04:06:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B7tVFzw7I0eOCF2Rdk+PAHc/bhveTWxLrTkYf/I6DXME2jZC+wZhRrPwriEUk3P+hAcRdgncoeMPMP3stW79IkyeKu9Wm/CU4AatDaVrBiBjgw/ngqL+RWb4taj8wcwwyfTOU9fe91KJ5KB5yWBgG7EbdwvAGbGI64ifHC6TD0CGbal/pAjy9v14+l2uM2bHbw+WuGzHvmJw8CUa3iuy7e267rTnz0FXXP+MJH64p6zKy5B8If7m0QYmaf24VGJWm8oAB5YC6BseIZkqs0vtxbVKac76+EN3FRLM6W3L/KQD0b7pChp7R2bsBMd9nTbJsGSUWfR6rtmxWKjXtZYTbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b+n5YriqBfq4H9DzIJdJ01U14IWmbvEfvatfKwgj1YU=;
 b=rDIw/n6gK3jv1VStp1tN2botknahwMl0cbOH+eTOyyW+lSyexmT3Tc6PJXKsVBS8PbHpB3rFhSeh+3z3xnsP4I/83ES3novLwqyZwij33GbG0t3ph6KP4juKf5AGtQllGu1SPnTOdYb8e4gUH0DXjg5hDOP7I+ERSaxPpSpac9xc8C93l3hvB8RdgBYKldn1xvBWBCZDDj5cjrIBzIFXkM9M3f7DFO117WSaPF0w3krfMluZk6xT4CPuXucdOS1G3gBSCvmt8Yb1u5xkLboQVXFu+2wckAU/zaHqRKtbx3gUILs5c62qGIvve0ZsuM7FIPSkhsYaoPobC6u+9a+uLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
 by MW4PR11MB7151.namprd11.prod.outlook.com (2603:10b6:303:220::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.15; Sat, 28 Feb
 2026 12:06:27 +0000
Received: from LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7]) by LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7%5]) with mapi id 15.20.9654.014; Sat, 28 Feb 2026
 12:06:26 +0000
Message-ID: <967d515c-f098-48ff-97cb-2de34f17aa29@intel.com>
Date: Sat, 28 Feb 2026 20:14:10 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] iommu/sva: Fix crash in iommu_sva_unbind_device()
To: Lizhi Hou <lizhi.hou@amd.com>, <joro@8bytes.org>, <will@kernel.org>,
	<robin.murphy@arm.com>
CC: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<baolu.lu@linux.intel.com>, <vasant.hegde@amd.com>
References: <20260224183056.2628698-1-lizhi.hou@amd.com>
 <1c486a5a-7115-44fc-9705-18b292cb9d00@intel.com>
 <14caa56f-999a-ae00-2840-e97080b4f7af@amd.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <14caa56f-999a-ae00-2840-e97080b4f7af@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0013.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::7) To LV8PR11MB8509.namprd11.prod.outlook.com
 (2603:10b6:408:1e6::15)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8509:EE_|MW4PR11MB7151:EE_
X-MS-Office365-Filtering-Correlation-Id: 0df652cc-b466-45ac-1817-08de76c1cc63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|42112799006;
X-Microsoft-Antispam-Message-Info: fsHevABh9vQETHzSylMwPLP/22nppBESXViY81dNqfN8/MJxj5uqiGfLQFBUEgaIzu7vxjaQdIHdvGnrxIp+bKnkBJeQx2XBDJK+KJmVlSHZcaAQZlwlGERhVhySIYi59gS91o0wghCLARGr9qGJgIim2QtfBvuGEXY91K9ZuCWy4eiChjcuAGf1QzDQsElG4EeVThRDm4rkAjC76ZRpGxvzj5C3DdIB1JR+vc3kcE/I/qiyGgBSFrpr8SRRL4l/ByHJtjo91sAH6Hyf9SRQF1nKATgY+BVPE7+jMBugsTXRd+dCJfSm6DhOWT9y/BVeAXb8XjdsvzGFoAgaw6ekfrQc/GL562DIqK7wYCPwGHd7hZ+sdVZFLj0V5D2Vt4XZx86oGZxAsCxxWvZG+qzcuZ6WMz1cIZDTWf5oJJCD1eCTSiYCcNom/51Cf9APAsWzoYFKDQrffiIwvs8kQExniZb09MFlQMnF83rC2NkNqDJbT6dt7yBSMZNdL8Y7chcx8b07M+2WrQLyW5sl5BY4gU0Z6BaqDzmT2R3YIWCNexWIh4YCttK3g8sI+DaC3doWQ4BmnaiUIADPbOrHn9KkXAQmRZVdSbz8U/1PlTebxnQp7BaYRdnKDJgIooTArcNRpV3+qshOH2uq7Y+7gSH8TiwZ76tiYQK1w6Ym939OK5eBIa5sZhUTlehf2+OAqGH9D3ZZArxI6b3v3hbO1DBp8TStJUxNHIAjxMBLP8LxlGI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR11MB8509.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(42112799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDN5Ym84NzFxUzN4SEg5YUdBeWhlemZiVzlOUEF4djJQWGV2T0xkaFNjcFpO?=
 =?utf-8?B?V2RDQmJnS0JEVGsvMTBZOGNLMG5CMFM4VTRqeDd5T3owNnhtMllXeC92OWVB?=
 =?utf-8?B?ZEhCdEx2NWZCNHc3VDZrSjBaTjFDZndSSnBUcDdnMk15U3F3ZmlZRlJ5U3Jm?=
 =?utf-8?B?M25RZlYxQnhYZEJEbFhNcUZsNkRxM2I4blFBT1NiOXlxN20wancrWXJqT3pi?=
 =?utf-8?B?cmhDMzU0SDliVzhma1NPUnAwREhVTWJYVkZVTFRIaGpzUFdFZStwWXkzSURR?=
 =?utf-8?B?NkpKdmxLY1JWTXhKZlJxa0xvZDM5MEdTY2JseDVDam9VR3JYby93L3A2Y1dX?=
 =?utf-8?B?VlcydlJ5Sy9xNTZTZkRiS1lIRTdkVDBReHRwSlRNZ2dDV1dGeDZhZGxkdGNl?=
 =?utf-8?B?WEpPcjIxZ1hRUjZVMUlhME53V0NIVVEvRnA5RUFSczdNMkxMeWhlTFhLVnZ2?=
 =?utf-8?B?Uk9ZaW5BVTJOVzNiemZSR0FTNHdwYW5WUnJlUnFNM0JYT3lNWlNraHhMaVFh?=
 =?utf-8?B?MVhRc21MeENOYjdERzlOb3VzeVd3UWJWVUgxMm94TldDbCtVR3I4L2lFSDhB?=
 =?utf-8?B?QUpDcmtubi9mMUNvZU8xc2d3dnhob2tLdUR5elBJQ1NUak9PZTgwTE5mOGM2?=
 =?utf-8?B?SG9CSlR0WjFQTyt0TG1FOUtnMjFqa1Q5Q0tQaW8vQTZWaW1kY1ZQeEw4eUp4?=
 =?utf-8?B?SXhmQmhNQklZTmp0bG5HeGJ3NjErT0tQaW1OSk5Ya3M3Y3psRExNc2d1YXAr?=
 =?utf-8?B?RWVHaHNsenNWTkdzbU8waXQ0NUR1bTNoeEN5L3owUnpVWjhTV3VMa0V3dlor?=
 =?utf-8?B?ZEpJNWxHR2k2YWl6UkxGL3NRSWpDei80Qmd3Ri9QMkxOMmcxSGllWUZXTXRU?=
 =?utf-8?B?UjhDSmMwSDRFUVBsdFd3dm8rYmQxVVZqQXpxRk9QSGxNZVU1dXNHaXdseGdv?=
 =?utf-8?B?TnRKM0M1UDAyNXRvR1RjL0FRT3JxYnkyU2JmQ2w4TjZ2VXp1clR2NmJRb1BL?=
 =?utf-8?B?M0x1WFRiajY3ZmtGb2hSWkhNc2JnZVdOUUF3NUY2TE1OQ1prV0Z0OU44RUQ2?=
 =?utf-8?B?eEVEcHFIY3lNQ0FiSEU5YTQvMVJiTlZhOHpJSk95S05KUXE3b1J2KytDVHA3?=
 =?utf-8?B?cjVUTEczaXcxcC91bldrSTlDR05jMldNeFpDMjhIVHVSTW52bnBaWFd1OTdq?=
 =?utf-8?B?QU54VDVLRTh2VnlkR05nZFRRMlNLNktVSHBMbTlXTUh2UzNvam14eXVmb25Q?=
 =?utf-8?B?K1d6Ynh0T1B3cE9WRGFjemlWNjBlRzFEdk0yMFJnajFST1E0N0JvZXBPU0V3?=
 =?utf-8?B?cjNSSHRaUCs5cnhqY1J5cTdmYlRPdWwrTStTLzJWdURIWjF5S0xyQVFiN1gw?=
 =?utf-8?B?VHVxeG5HQ3VtR1ZSeUZnaHY0OWpEOUs2YkpXbXdJdUxlYkdmd28vNzJnNEhy?=
 =?utf-8?B?UmxIb0RzV1FCenptNjJUV0JKQ2lqdVFyN3RHaE93cDlqRGVtVW90RDY3VURI?=
 =?utf-8?B?emdEcVNzY3ZtaVZicFZmNGJweStrZTlmTmFBenZMMmhjcERSK3NkYVpjUWl6?=
 =?utf-8?B?MUhQbUZSVEhSL2dXcTRDNzBIU2FTb1ozdGs1UytNWUNsYXlZcTcxRE85SHY0?=
 =?utf-8?B?bnBDTWpIdDlpV3hvd3hIQXVSajBzRFhEbklFV0Z4RitvaGJ3NTJzUmJrUm5X?=
 =?utf-8?B?VjFHTTJXQm5Lcmc4VGdOV0JqU2JNNmkxVnIvak1lSWpOZ21obHVjR253RkYr?=
 =?utf-8?B?Uk9RWnE0S25Kb0Z3eEpkNHlKV2FsSnNRU0RHM2xGTW1za1RwUExXUVhIVElU?=
 =?utf-8?B?MFlzQWxNWGJzdzlIVTRoWHBQbW8zVi9jVTlVZFE3bzdUZTFPSTQzKzFPaC9m?=
 =?utf-8?B?VnhhaDVpaDZHeFp1dmV1b0Ewa21lTE9LdHN4L2MyclJPcUI3cHU2QndYcEYz?=
 =?utf-8?B?ejZRM2l6bklIZ2l5RjZFY2ZrbzdDZVBRTXFweklVWHdLWE9iN1R5amIzVG4r?=
 =?utf-8?B?VEcxM09QNlBYTU1pa1ZDVVorUWVudTZyQUpVVXNTemFZRDY4UFpIU01lTEt6?=
 =?utf-8?B?RFpydUFoUHdWUm5aWkxBYlcwUnBSSURmQ29ORjNkUlluZUJDNFhLdTlIRnNO?=
 =?utf-8?B?L0FRSEI1bUU4bDBqSW9pWis3dkVsSUU5d2dsZUswY3NsZE80S3VaclZMWFRh?=
 =?utf-8?B?eERjRmY1TnRsUFBlTDBkSU5jVTRQNXZsYWNZNUNLWWlEL0RMVVlPanpTek1Z?=
 =?utf-8?B?b29BdUxxbnZZZWJqY3NxRWRBQWU5TmhqYTM2VjRoVGptUWRQSFNjWFhUTnNU?=
 =?utf-8?B?bUpMTG9ZZGcvcjNIREtJay9XWFlGZFpLOGN5b2NJVWZnQ2dEK0tLUT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0df652cc-b466-45ac-1817-08de76c1cc63
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8509.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2026 12:06:26.6777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zGeqt2+4L98BJn/sYo5T1r1tGXIAexlkURx2+ULk/j+eNfKtIjo/pJTY5PZjHNRZoxCgCAsHFVVsMv4tneqdtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7151
X-OriginatorOrg: intel.com

On 2/26/26 06:09, Lizhi Hou wrote:
> 
>>> diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
>>> index 07d64908a05f..523b8c65c86f 100644
>>> --- a/drivers/iommu/iommu-sva.c
>>> +++ b/drivers/iommu/iommu-sva.c
>>> @@ -179,6 +179,7 @@ void iommu_sva_unbind_device(struct iommu_sva 
>>> *handle)
>>>               return;
>>>       }
>>>
>>> +     mmgrab(domain->mm);
>>>       iommu_detach_device_pasid(domain, dev, iommu_mm->pasid);
>>>       if (--domain->users == 0) {
>>>               list_del(&domain->next);
>>> @@ -190,6 +191,7 @@ void iommu_sva_unbind_device(struct iommu_sva 
>>> *handle)
>>>               if (list_empty(&iommu_sva_mms))
>>>                       iommu_sva_present = false;
>>>       }
>>> +     mmdrop(domain->mm);
>>>
>>>       mutex_unlock(&iommu_sva_lock);
>>>       kfree(handle);
>>
>> will moving the below hunk in front of iommu_domain_free() simpler?
>> Only when (--domain->users == 0), shall the code check if sva_domains
>> is empty. right?
> 
> I am not sure if this can be moved in front of iommu_domain_free(). Will 
> iommu_domain_free() be possible to impact sva_domains?

sva_domains is used to track domains associated with the same mm in the
generic layer. iommu_domain_free() calls vendor iommu driver's free() op
with domain type specific operations. I don't think it should impact the
sva_domains.

> iommu_domain_free() calls domain->ops->free(). Could this call back free 
> sva_domain?

I think so. Check intel_mm_free_notifier() as an example.

Regards,
Yi Liu

