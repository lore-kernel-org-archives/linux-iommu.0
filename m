Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010042.outbound.protection.outlook.com [40.93.198.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46F1282F35
	for <iommu@lists.linux.dev>; Thu, 18 Jun 2026 05:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781761906; cv=fail; b=mR6otkZDrfv31VcAzX0UnvwWKxcx5m+UKZr3s5xa1t9IZ8dcbTgnlfOSqeLrVZ7v0qbDEbd3bgKLnewlsY0sFitQENSWbNovqymYz/Zx6EmRBT9r/MS7c+2ATammDOqu4vOeqQFc+f7Fz0MK92MZsQKWGNnMwVBOpjMlE9ybhfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781761906; c=relaxed/simple;
	bh=YUYjbHoiAFS05Duczvrcnh6oznif4EGIZ4Abl8Yx1B0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kLIiWnv/frlMYou0SFahJkpm/0Gj1WSZVZIuA9bz/E0BnKzxJSU/j01bTlohxbJ7cZVLiod0V0k1At/YOIdnjM+FY6MjZY9Isa2pXaNUWMejRh1BTTiweGdfTDf6GzIY1WSeIEY9PQRpPwClEzoP+LMjz47P0t4a+TFcI64Oo8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vcblveBZ; arc=fail smtp.client-ip=40.93.198.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vcblveBZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OWFgTlQRX/nVLCxcngB85EcNUpOEplQVLbL4DobiNfL1RLZ+8jekmaCA1EZbZx9CUiVj8eRW0E/XtFRPeIcBkNfccj2anb6DSkqsedHjYj/Or2ySWfmn/rdbrRwPxno3hKmYIdEyIysaEJUngPSpKUQXnft5N5ZSAdCSLergtleP0jBjFuTVvXX4KVELF6TZflbP6xAaD2HItd8gVOxtDaSE6WybWGlfs6tPHCGQyHErMovvzpJjPh9yZ1COugP0OOSvfyPr2Ghx1cQHAaUH4lbn6148QZ05ioaikfKIX8sKabpMEXPd536narMsvev5izrdLC93Jo+dGOKDDZGLOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iSLG1/hzgZkL7wbAbue7vkmEOHOavb0E0XhRHb3lXdE=;
 b=S+a4Z3F/xOiq/ki39Pmq3Nus1ZQVG2/9CFpSr7/V/32luHBjaQehvDCki/N2ypiFkvjwgUaq2S7fuHGL255O1jYYezQBj/TGHVsuHKrGW0r+c6G2O9s8xI3UlCorVZJ7CMH38Nt//p38oMmSjNDxsQpoQW9VQ/fbhcQbayx548cGXeLNhPzgPJO10BL+Le0k00UOeB9XguYrW21lE8xRY9/GeALMBneyj8uWu9OXYqxmPRSZclSET8O2GpDXhI+7wGw7v0hCCWoRm1QyC2pm4BIq89dixxxAjngviBmfMq5QZykqpBrwM5zvZMikhdffVGhonf4nJc0ejdcCAw0FxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iSLG1/hzgZkL7wbAbue7vkmEOHOavb0E0XhRHb3lXdE=;
 b=vcblveBZlggnO2UaHN1lLQNm9slttbj+wV2irtsp3wf57Y3gzXXhlj98dLeLdsCv/DfuMPQC5lsHasclNPjw5L13dHHR2BKu19qNFrcXcDQRNDpp90jyEotB0a/SptL/ngG8f24ac1y1QHcBQE7e+2MiWIYHo/7ar3ZSQtaBwRI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DSSPR12MB999236.namprd12.prod.outlook.com (2603:10b6:8:374::10)
 by PH7PR12MB6717.namprd12.prod.outlook.com (2603:10b6:510:1b0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 05:51:42 +0000
Received: from DSSPR12MB999236.namprd12.prod.outlook.com
 ([fe80::8a48:f674:71b8:d21e]) by DSSPR12MB999236.namprd12.prod.outlook.com
 ([fe80::8a48:f674:71b8:d21e%5]) with mapi id 15.21.0092.006; Thu, 18 Jun 2026
 05:51:42 +0000
Message-ID: <7aea8ee4-3131-468c-8089-ff6e3e128d32@amd.com>
Date: Thu, 18 Jun 2026 12:51:33 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 22/26] iommufd: Add hw_queue_init and split queue alloc
 paths
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
 vasant.hegde@amd.com, jon.grimm@amd.com, santosh.shukla@amd.com,
 sairaj.arunkodilkar@amd.com, jay.chen@amd.com, wvw@google.com,
 wnliu@google.com, dantuluris@google.com, chriscli@google.com,
 kpsingh@google.com
References: <20260528051738.596013-1-suravee.suthikulpanit@amd.com>
 <20260528051738.596013-23-suravee.suthikulpanit@amd.com>
 <20260601133801.GP3195266@nvidia.com>
Content-Language: en-US
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <20260601133801.GP3195266@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0029.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::20) To DSSPR12MB999236.namprd12.prod.outlook.com
 (2603:10b6:8:374::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSSPR12MB999236:EE_|PH7PR12MB6717:EE_
X-MS-Office365-Filtering-Correlation-Id: 6289a97f-8a02-44e3-7973-08deccfdac23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|7416014|11063799006|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	zUU8JoMgbQd+UxCZXIfIq5I3X2a/OEPw/2KKDmBVuybYyR9/GiJIqiz7SdlJvtgBTUC8hiSOaxvrt13tPO70fXPdSz4a1gmbRjWJfMELs0uGggK7uBA+O58vKzc+XvUQrp7xdx1oJdAglIUBcP+PqB+zOi9kfYupQEinCcLry6A9D8kPpQNuBzwTqU02UxA939pzYVCrWU5NjyIym2K/6RdknF5CiIxERCAqU07djQYVaOumy13smcC+xQmRSKMeheAppWDGEkvEFQ07g/oPggn19t/V/8bau0qf9y5DZX5AQC1PqjJagP4wQJ8c47VpEMS0+MtcrgMCm8R0HBDkBEfGOpCIMimc4P7r/DWtv0RrDcLEQxCGpo7UcEgc2Ehs+6x+FbUXaDIZSxIn9+rTLfO38XRTPRdF6fkBwtnn+i10Uw0Zx/IY4NZS6RJ63i6/eVFkS3nWWRaOcXzq4DROFNd1CDaCiRtD3yr+Ay3OFW4bpppQ2hnmp8+wfd4CTZ3/ra4Ivp1lxAGmjWEl/5gBmON+8G52WnvIXzfno3+i6ZBu/8D53EYjYEU8XIJ0zVo4D1RQN1gUvnEYJMt5Z5KoBWuF1pR8I0WWHq2N+5pPTFJtk8mkCAToCzNnGSNnD6MXj+Ntl58jAFnW448sNAYRWtKQqtlMMROdsffiZDcR9F3QwQ+TMuJGqu92/qc41RRQ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSSPR12MB999236.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(7416014)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RG1Fc2M2MjluYUlNL0ZUcnNHVXdHTjRQTlo5ck5iSTN3MHhndTlSSklJaGx1?=
 =?utf-8?B?YlpOaVlabkdzeEVwMkJwUUVacE0rTlp5WFVYaW4xRW1zK3BKWnJpOFNPRVVs?=
 =?utf-8?B?K2V6d1BkaWFzRjlaQ3ZUZ1lhY2Rpb210M3dZQzFRaUdoQzBFRUUycG5xeGt2?=
 =?utf-8?B?bCtOdmhEN3lDQXFCdmN6ZE5DZUtzaDc4R3Mram04U3M3SFVqOEppN1RCQVVx?=
 =?utf-8?B?eFBiSlB6SklVM0d5UExkcDhBcnFZNkZsSVZXOWxzdzM5ZEZtY2daNUVHVXhy?=
 =?utf-8?B?dUVnVlpxaG5lMGpJLzh1MHdVT3hJZWM5MTdUU3dTZXBpV2NkcnV3Rnh2WGEv?=
 =?utf-8?B?NzZINTh0TTB5NkNsc3RUbFBnTEt0eWVjWnhEdHIvUURjRit3c2ZraWhFdG5N?=
 =?utf-8?B?NXM4a3ZFTmJuN3gyMERRdVlFS3VNZXAxOUx3WWdERnExV2o0NUFnd3h5Mm1B?=
 =?utf-8?B?N3lDNVpwUGdLVFkrYWxwMkJoSHg3VmxCWno3N28wTHdqUjFaV1BMM0o4dHNo?=
 =?utf-8?B?c052QUk4WUQ4STc4alozZ3NodUZ1cDNIRUdTbVJuTTdZekxXN082R2gwbDFu?=
 =?utf-8?B?TU5LTno5T0RnM3czd3d4b2lmOHA5MnRiTW5VeWVKcTJ0UFhvS3V5OVpVQmVo?=
 =?utf-8?B?QmJDUkFhb00xK0xudUIvU2hsRXc2QmhTL0Y2QjNCeFFVVUhoM3RlbXQ0UUlP?=
 =?utf-8?B?aW5qRXJjTW1UQkNudytWQ1pmQ0RsS0tvQTFOOUFkejdiZlBGRW1JWEpNTVNI?=
 =?utf-8?B?SFJ3cW9QT3JqMjY3UnQrSEh0V0pzVlkzTnQ5NWF5Vi9YRUlldWVXUnVKM3Fr?=
 =?utf-8?B?bVhoOHNUa3U0amtwZlpMbnhlWGdPZUFtejhoL0JCZ2pYdU01RVBLSVBwaTVF?=
 =?utf-8?B?U2gvTmVka05DVDZka1FaZ0dNK3dDOTlTejVSV0dSOExDZVZSMTdRK3NRQWg5?=
 =?utf-8?B?UGlxYnlGYks5TnVtbmpTb3NUQ0lWMEoydnF4aVVhOC9ueXZ2MlFXQ2pXT05a?=
 =?utf-8?B?WTlKZDZDbkcwckNFQkdXa095Y21yV0xBdVJLaXhrNTFHclVEL0NEL3ZqOTJS?=
 =?utf-8?B?bVRRMWtYYjhqZlR0dmdhVHhqVUwwRG1BLzZlTnE2TjUrM1lNbDNWSEJvUXp6?=
 =?utf-8?B?dHhOMCtYUU9EZ1laRW1xMkdRblBlY05UVThydHlONm1xZGh2bnpPQU9qMXZt?=
 =?utf-8?B?ZG5Od0FVT3ZrOENhNUV5U2NwNUd6VkdwZkg1R2NQdDV6TmVQM0hOUVozTE5Y?=
 =?utf-8?B?T1BPc1luY215RVB3RWRBaklJY1kxbFYwZ1FKcWhlaGxXWEpWRFR2eTcvMnp5?=
 =?utf-8?B?QVZaZGpkdEpUZkt5RXlmUWNLUTc4VXlrcXlLZENWNkhSM1puR0hpSlk5RlVS?=
 =?utf-8?B?Tm9FVFNvcU1jbklIR08xMWFtS1RaaFdNbnYwVjNzckNEOUNPb2pPaDN2UGl2?=
 =?utf-8?B?M0V0VWtMcE9FblZ0cm5GMFdiSk56U2h4NTdIeC9QclB0bUJDMVhZVkRHU0hF?=
 =?utf-8?B?N1ZjZnZzUFg5NmRWMytIZCtSNGY3WGtNckN0VUJsOFdhb0dheXVtWGVib3Q3?=
 =?utf-8?B?bHNpd1h2VnNSWmRQSU9pWWVYUTlsR25laVRweUpJNm9TZHNsQUwvQ0YyTTBB?=
 =?utf-8?B?RGJWaUJRdm85dENvSUgvTFN6bUJBdUJqdHp4SHhnb3dLS0RqTFVRNEdyWFYv?=
 =?utf-8?B?THZneXJDUGRabXJ1NGEvU2c3OWg3UFpVOFArcVRGK05KN0wrNUZTTWl3TE1N?=
 =?utf-8?B?M1hEbXZpN2xkMUIxS1pRTklFSERyQ3lIRU9rbHhoRm01RFd0THhlN3hwZ2JB?=
 =?utf-8?B?Nlh4UXFjTUZ1K1habTV1akVrU01iQjhzeERVWG5kclBIL3FvMGhQN29GbWgv?=
 =?utf-8?B?NUZlUG5ETW4raWxwRnJPM29KM2U5alErekFVTnhVdXVlSHBaU213NUlHM2Fm?=
 =?utf-8?B?alpDNHlTZjZEV3IxYnoxWXhlL2VOd3hZT0tKc2hWMDljK1VEWmltRC9CMHlX?=
 =?utf-8?B?eXJpOFVtSU1RZlJUSUtvU2ltakJLcWticGdCYzBMejRWVTJEZGZYT1krYkkx?=
 =?utf-8?B?V1N5ZnR0YU1uazYya1FLMnl1YTdqeHdrd3BmR3ZudVg0T2FCelM2WjVQQy9T?=
 =?utf-8?B?RFpOTi8ra2lQNHo2YmZ5VlowaHF4S3A1RUVleHZLQzBRSVdDdHVsWkFzY2Q5?=
 =?utf-8?B?VkVjNm9rMTFvcGZlUVZISWQyRk1jQ1JsTjhQdlNNSmFLOWZCNzNOMXAxTVg2?=
 =?utf-8?B?d3Nvc2pvSitUVCtPRDNKYzREN3p0YTdWV2dIZXp0VDd1SVV0dVN1ZHBSSW5L?=
 =?utf-8?B?RTZrcGpxMm1pdFBRYjFPaUJMS3FzQnppd3BrQU0xenhDUWh5T2diUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6289a97f-8a02-44e3-7973-08deccfdac23
X-MS-Exchange-CrossTenant-AuthSource: DSSPR12MB999236.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 05:51:42.3038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3/KRMsK4YFPzwtPsHoS1z3smuIZy5HLKJVz7SEbCBVU7STgZC5Y+lib0N8FFcQgO+YlfeoCML3yCb4vaStt8iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6717



On 6/1/2026 8:38 PM, Jason Gunthorpe wrote:
> On Thu, May 28, 2026 at 05:17:34AM +0000, Suravee Suthikulpanit wrote:
>> Add iommufd_viommu_ops.hw_queue_init for vIOMMU backends whose
>> hardware uses a guest physical queue base from hw_queue->base_addr
>> instead of a host physical address.
>>
>> Previously, HW queue alloc always went through
>> iommufd_hw_queue_alloc_phys(), an iommufd_access, and
>> hw_queue_init_phys(base_pa). AMD vIOMMU instead takes GPA from
>> userspace in hw_queue->base_addr and programs hardware without host PA
>> resolution. Splitting helpers and dispatching from the ioctl keeps
>> one uAPI while making the contract explicit. Each vIOMMU driver should
>> implement only one of hw_queue_init_phys or hw_queue_init.
>>
>> Refactor iommufd_hw_queue_alloc_ioctl() so shared validation and
>> viommu lookup stay in the ioctl, while setup is delegated to
>> _iommufd_hw_queue_init_phys() or _iommufd_hw_queue_init().
> 
> This patch series is getting pretty big, getting the viommu working
> alone is enough for one series, I would split getting the direct
> assigned queues working to a following series
> 
> Jason

Ok. I'll reduce the scope in v3.

Suravee.

