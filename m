Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532241E25EC
	for <iommu@lists.linux.dev>; Mon, 21 Oct 2024 08:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729501085; cv=fail; b=Zv7OsSny81BszipMj2Vlx4vXRwJuTalD3EQFp4+iD6S8AKbPlfRVdZgHF6/5I97jeJCco3U8mIVgr+h6vq/43s5zhtDpvD97C6LXNWO9zJSvo5uB854Vr84+r1N8x9g9my6eqvVJqy7SPEMOmFs4JPn2yXUQMVHVoKex7B0WfOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729501085; c=relaxed/simple;
	bh=e6SQ7vhB22Dq3q6lvLMArfmadErzNeHb50GhjdPCUXo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UhLeNH0rNiCXNLNnYutz2kEE1oDo2EWcNoqnvigHH8+cVwL3VAnFydfAWcl90sNSbG90hMj6qU3X+p+Zemdpw+7UAV62BxLV1sJZxJnwAEHjdjNtl2kDHMu8EdRiZJd8wgWVU+xtX0hTfSP22pXzJnIH+E7AGCZ2UWcZMGMCQis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dcIlgmV2; arc=fail smtp.client-ip=40.107.93.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dcIlgmV2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AJJVJP1GrNpV36w7YThdoGwNgt2OMApxf+SNh0lFlOnko13pINMj/rams3BJnERX4o1qO7gkjjcrTSU+At+S3AlMAll1nEb6aD8r7PJ/N4LXlCGaSqOn4RY5q1fKxF/rYmrQYkBeoEynN7gEQGyJuuEMWcE88T5uphspvuEPSo0Nf7bNbPLdnB1vDQERWv/rTLBBNrhvnhljb0xxwIx0Gfin5W89SY0k7eX/aWkfJ3jod0kroiqwknyCsqxa1YYG+PkFVM4fwePBUUxeMirQwFNa73ByOFHSxAUxMDnm8rEF4xx2qQx23XaWr/RNu3QiZQFTzggBxTe9O98WLxR7lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ob7oEJeyJ+GH5dxpHZNJ9Y+iSIdg2T4PeLOy6MqQHM=;
 b=veLAUhMvXY3MmiMKhVL/dPaIJldb1yGglgz6Q5cbrxbe5Sd4nYa9TNHv1Vc6G026VemIMTOZs0xKp+FWuMWeqCyxvaz32Vt/GMsMwjas5YyP/D7vOVrxjAsTrvo3uqao6HBCKPj1KF+P/PmqkTwISOpdIHT5xs5hCrlc8M6IdJ20permtCax5o6c1KWbSNhgCvytNjuo5Q7Vg+kBsJapOnkFFsK9HRvT/7nI0m+cmqvtR7U78YdEk0t1liJGXHKjOfnUNcx6WsInnMJiuxJGpj02O1eDWLlu0QEWSBL21RWj3ZK9pe6GtKoLZ4ERLKZTG9rhIg6+GI8nWI75iXZsmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ob7oEJeyJ+GH5dxpHZNJ9Y+iSIdg2T4PeLOy6MqQHM=;
 b=dcIlgmV297QD+6ZWeyGoIDQQY9y0bsG3rRj6ZyrEn40/mq5o/5H5sadCHcrSofXx5G0wFvtZMF9NyvzKSd9pL6LZtKBCZok0ufNQPahHWI8BMxr3psp2Il8iZmWrAM4MaTvvpiDJYsWTVyM5lU8QIItgtYU1QkK3/roAuXpK7J8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 CH3PR12MB8355.namprd12.prod.outlook.com (2603:10b6:610:131::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.26; Mon, 21 Oct
 2024 08:58:00 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%4]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 08:58:00 +0000
Message-ID: <98f083aa-5586-4354-85c1-af98ab5cac01@amd.com>
Date: Mon, 21 Oct 2024 14:27:51 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/12] iommu/arm-smmu-v3: Enhance domain_alloc_user()
 to allocate PASID capable domain
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, suravee.suthikulpanit@amd.com, yi.l.liu@intel.com,
 baolu.lu@linux.intel.com, kevin.tian@intel.com, jacob.pan@linux.microsoft.com
References: <20241017140137.6028-1-vasant.hegde@amd.com>
 <20241017140137.6028-5-vasant.hegde@amd.com>
 <20241018142303.GH948948@ziepe.ca>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20241018142303.GH948948@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0023.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4e::18) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|CH3PR12MB8355:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a31ecc2-32db-42ed-82d9-08dcf1ae76eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aFZuNXVRKzFQU2w0WmtBTGkwTmxKS29lUjRpbEhzd1h4ejc2Vnh6azJ3SDZr?=
 =?utf-8?B?OEd6NDdnMFVWWDJJQThvSHFQeHdVNVlzdUpFOXU0d1lkVEpZR2VOTUM5Q1E2?=
 =?utf-8?B?MWpkUlVrYUpFNzlld1NRQml1SGxLc3I4cC9FbjlPY1Vma2M3U3JsTCtGNkF2?=
 =?utf-8?B?ei8xUjVZKy81WE1EV0hyN05Eb1M1bTdJb2ZFRVhRcDF3OTJ4QlVJSGpRQVNG?=
 =?utf-8?B?enF3VjV0a3E1R1p4cDNZK0RiMGNZU0loOURBci92YVNGRTV6QldibUIvY0RQ?=
 =?utf-8?B?VHRYQURqWFE3L29aMzJyTFdVN3B1NmtLYTNyTGVWVjV1UDNzQXpBdmFVMTdJ?=
 =?utf-8?B?UFg1L29BWmdxYlplVUFXMTlmc2hWRU02b2ZPbnFOVUFGdkduTHh0eDVwRWdj?=
 =?utf-8?B?Y0RHaS9PSEt5SWI5bEc4dm5XRmV2VnJ6STM3cVRKcmoxWmdQeDdQUlFjS0Fu?=
 =?utf-8?B?enhod3hhcUVtc2VpWlpoWkRzZlM1K1lOU2pmWFdPUWcyVzBXelJ3cW5PaCtx?=
 =?utf-8?B?RldIaE5pNS9qMFd1STh6NkJvM1lHekkvUVNOdFRRaGw1S25uNzJYL0pMaWVT?=
 =?utf-8?B?dTZOaFFXV0VLNHVkcENHZFZTeUpmbHhvWFJ6SDc1aEVGZ0xlbGFMVDhKNFlC?=
 =?utf-8?B?UGwrSUZBNTNsc1Q4Sk9OK2tXUlVMMDhaN2ludDVkQjdiZVpEbUp1dUxZak1p?=
 =?utf-8?B?clV2ZnV5UlVlemduSGFzTzh3UitaRE5KM2dEY3JVZ05HVjFHaUJJaGpmOG5X?=
 =?utf-8?B?dDRvVlorQUY3QnlSVE0yUEJ5NG1jNktYbWUzNkRhMEhLVGhocHZaTm5uUVBP?=
 =?utf-8?B?aW9YWXJUNHhybis3ZVNpSGpXajJOdlBoV1A0RzRUeWtoKzBobWdRUUZaWndS?=
 =?utf-8?B?T1R4V0QvblIyWlN6MkQzbXVjc1Q3dU5URzNRVVhkaEJtVEt5Q0hrdlhpU1FJ?=
 =?utf-8?B?NmJoZ3prZ2ZjOXRsa1BuU3JoOUdERm5CdE81RGhHVkM4Ylo2TVBLOGUwYVBo?=
 =?utf-8?B?aGVyRS94VTJtSXpiT3I3cExyeFpuYlN2NkhhVmVKQWxSN0RqUWVpVHZJT2Ex?=
 =?utf-8?B?RXVZdzhTVGNJcGsxM3VGdzg1Z2ZKUUcyVHBIUEliQ29UL2svZkZJZXR0bUc0?=
 =?utf-8?B?VUlVVTdTZnlrYTBZM0xBVHFTaHMra1pMbWFHSlM5bDIveG5sODhuUi8wZWl2?=
 =?utf-8?B?ZEs5RW41SEpHdmpYTGd0clRXL3QzT2JrVGVTUGhhR1lFUHRKVlBiZzR6YTdT?=
 =?utf-8?B?ejV1MXhtbFN0VloxR0xNNzBlYk5KZ3JGdGZua2drZGJZaHg3WU5tUVNpdjIr?=
 =?utf-8?B?enA5UFphei9Ybk1hYWM4VkFoZnVoRHRwVVU4czBDMnlIcGVubFVsSlZtZzRt?=
 =?utf-8?B?N3BHSWhXekFBQXJUeldsOVBRVmpyd3ovd0Z0QWEwOWo3NTJrWnErWlh4UVhY?=
 =?utf-8?B?VU9rTGVyU2kzU0dqeU83cUlzYTV2MTAvdDdDRTN3NjhyV29MMWw0ZmZEdmt2?=
 =?utf-8?B?ZGlWN1JyRVBnS0d1ZUZ3OWszdVdjbWFyS0pjdUJzdktoUVpFSlRZZDFpU3VO?=
 =?utf-8?B?NVZaV3FXblNlWjMwaUpwZ2tJaUVNbldGZ3pocmtmU3ZSUlNWZ3RRTWJ3NnB3?=
 =?utf-8?B?bVBYUytxSjVFN1JOaDFGYWx5ZCtnME43RDh3a3QzVDZsVWlqdlZldDJISXBp?=
 =?utf-8?B?M1dPRzRhVUJFWEdiTExQcC8vbHZTaUUrTXkwMHkwZkFjU2N4b0xDUUQwQ0E5?=
 =?utf-8?Q?9E3z1pM7L/sYSXdZ0bm0JmEcOyC9FjUynloJv/C?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?azZuMm4yR0JUTnhBYlNKL2VSYmhQc0wvbmNHTFhjUnhOZWlmZ050UjFFQWJi?=
 =?utf-8?B?NkhVNXdPRVNGdEZ4VUJ1Y1lmb09qbDIvV0pSSmVNbERKcHd3SE8wVGlTQmVP?=
 =?utf-8?B?blVsdEtFamVJeVo5K0syZHVmcHU3dDEwRlM4bzhqYlVDakkyZTkrRU1IZlA1?=
 =?utf-8?B?Tm83YzNtT3dFZElxVEpRbkwvWDhIOVNuck1OcWgrbE9MckM2NytIc25LUTdQ?=
 =?utf-8?B?cE9XU0lFSHFsL3RSbjVZK1gzQnpJOW9zNWlKWnBiTzltbmptN3kvM1duSHI5?=
 =?utf-8?B?bW9TVjF6QVgzdkorVEpRUEJ3bFp5VmpWUEtTclhueWFGTWYrZDNvZGxPa05T?=
 =?utf-8?B?NS8wZE1CNG9VbTU1ak01MFB4b1d0NDZxZEdOR3Bjb0pqVGNXbVpDODhKVWhT?=
 =?utf-8?B?L0dMZzVBZHlIaFk1QjBZWUdJUVJzZGVhalJ4NTF3ZVByQ2Q4cWEvd0NxRHU3?=
 =?utf-8?B?OWQ5YlpDam5IbDRXZVBnZStiTEJhMmV5ZEQ2djF2c09MQWR2WHZ3aVJhZW9j?=
 =?utf-8?B?Yk12QzlpK09MVXdYU0dVN29ZNk5tZ01wVUI0VmxaN2N0c1RGd0J5QU1heTZ4?=
 =?utf-8?B?MHdOWlpjVVJ3dDVzK0I0WWQ1ZXBmZkduK2V0SG5nSDVGZnk2cnY2aXVWWkNs?=
 =?utf-8?B?dW9Wb3Mxd0VmRG96SlZlL3NCNzBVeE5DenIvTXZqbSt1NlI1WkVBa1lVZ2Ur?=
 =?utf-8?B?WGhITVMvSklST0d2T0xzeDBJTi9nTE9hU0d6aW8xY1o5czhwVFBOVnpzYlNp?=
 =?utf-8?B?d3JLdktYbmFoa0taQ0gwRUsxQ2J6UW1HbFJ4N01XZkR6SXZLRmx2UmJnQVR6?=
 =?utf-8?B?SVFRTlpyVHVyY3JRZnlzaVJ1T3BLK2FFeEVKSzZyU0JiZXdycHBxaFVBT1Z6?=
 =?utf-8?B?RW54M21xQU9DdGdCODFiemhwRHBhaWk4OVFDSGFCamRuNnhWenl5YWhVdzNk?=
 =?utf-8?B?NUhiNG5BYnJVWEhsanVLY00zQUtjRUl5SkVRd3JPZURscFVQclJNRy8zQzVt?=
 =?utf-8?B?T3dITHRqZ1VMZUdPNWE5ZFQwVWRDY1lUV1g0N0lmSXZhaW9HYks4aWlPY3Ur?=
 =?utf-8?B?YmNjUFB4clRHQmh1WG5LWWtYY2UvWkVqNmQrT1Bwa2VWSkVEeFhaTUJyNmhw?=
 =?utf-8?B?NDVGUm5md0RNZkFGQXAvWkhnKzFmQWZoaS95VG1nTkNXWE10N005ZXJNb202?=
 =?utf-8?B?QlM3cHNXK1BMb3NsSElNN01lMk56VUlOZDBZNmZpK043RXZ4U1Z4WWRUaW90?=
 =?utf-8?B?c2dGL2NEc0s0WVdMQnZ0RE5FNG4xVmlyN0tmK3l2WVY5ZTJMdEprbkdTdXd2?=
 =?utf-8?B?VUZaUUpHMElkWFBiK0lRbU9VZ0tseUxDc05rRzNMWTY2VU5BY0MvNUV6Skpw?=
 =?utf-8?B?WGR2R2xwWWdpTU4wTDNWM3J5UW55c2d1SVNlWWVzV1dDMWhnRlZLSDEveFNh?=
 =?utf-8?B?YVpmRzA1R09rcHNiU3Jha3g4WVExRS9mZUhyaitnVExSNzk5NTUxK3Jvb0tK?=
 =?utf-8?B?VmlQMUU2Y1FxNE5BbWJDcFA1ZFpVNU5Ca3laZkh4aDRLQXdDbWtWWDI2ZUtN?=
 =?utf-8?B?YzQrR3p5dXF3R3IxdXFJbTZKc1VxMjNjaEQ2VklLV2dUcjVQMTZFWjU2V3pU?=
 =?utf-8?B?V3lqZU1ua3cyU0pGMHQ1cFJRTTAyK055SGI3QTVlcFI2ekE5ZWdmNFVsYWxu?=
 =?utf-8?B?eTdOTGZkOHlsUGF1OTdudmliSnVaa05Od3k0MzdEYzVnNHI2RkxYR09BZUds?=
 =?utf-8?B?b3dSTFVGSDFYOTRpeXRCM1A4bDJ2QnlLSzhHWVZkVkZsU2ZLUEk1RlQ3eXgv?=
 =?utf-8?B?bmJRWlhwbUl6M2Y5VGJxQjRqZFRjaDNzQUlqTjVvQ1BxTXBJRmZBZFdNSlM5?=
 =?utf-8?B?di93TTlHbnRIZENQeElMdU5TckRkQndwUWVta0taK3RBUytzTGJxOXpkVjAz?=
 =?utf-8?B?SGEzNEpzRXpzY29iRmFQejhFRmlHbUptV04zbklHUXNrU0RZaWZ1MzlCdDVI?=
 =?utf-8?B?L3YyQ2FXck1pVGtUdDQyY1hHVTF6SUlab3dxb0xCbmVYVVd4M3d4bEJvNUdC?=
 =?utf-8?B?ZThYY3hqa3VLWS81eW9JcUhVR0JZY1lPMjFhS0htL0RxVE5EODJ0OU1INFIz?=
 =?utf-8?Q?mCXR3eu4sQArqxuIGCW95989g?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a31ecc2-32db-42ed-82d9-08dcf1ae76eb
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 08:58:00.4916
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T0jct12RfoXxc2FzIBeXp06les0pPh9CNsE7fy6FB9TYt/1udI95F0lITfBR5Abd3J2h4q8cEv93YHKcii3jHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8355

Jason,


On 10/18/2024 7:53 PM, Jason Gunthorpe wrote:
> On Thu, Oct 17, 2024 at 02:01:29PM +0000, Vasant Hegde wrote:
>> Core layer is modified to call domain_alloc_user() to allocate PASID
>> capable domain. Enhance arm_smmu_domain_alloc_user() to allocate
>> PASID capable domain based on the 'flags' parameter.
>>
>> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
>> ---
>>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> index 737c5b882355..4d4af11c5fda 100644
>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> @@ -3088,6 +3088,9 @@ arm_smmu_domain_alloc_user(struct device *dev, u32 flags,
>>  	struct arm_smmu_domain *smmu_domain;
>>  	int ret;
>>  
>> +	if (flags & IOMMU_HWPT_ALLOC_PASID)
>> +		return arm_smmu_domain_alloc_paging(dev);
>> +
>>  	if (flags & ~PAGING_FLAGS)
>>  		return ERR_PTR(-EOPNOTSUPP);
> 
> Swap the order, it needs to be after checking PAGING_FLAGS and add it
> to PAGING_FLAGS so it is checked.
> 
> Still need to reject bad flags.

Ok sure. Will fix it.

-Vasant

