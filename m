Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E103610D
	for <iommu@lists.linux.dev>; Mon, 22 Jan 2024 06:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705904691; cv=fail; b=k3LwPmAxjoGE8zz6Fqx+N7KuzYdJcNrSYXSrZo3AkfYwRPkQEB5OFYVuP5ZTAm0ldc+jd6qJYdP1ytOUnSz8Z4cbQLBSFDPOyaT/pMWwm005aZp5Pl29YgoYWLm3j1eGkOVAjRI2LPD0XYveIUeQGxwcK97RgcpWol+JQonopxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705904691; c=relaxed/simple;
	bh=nAcG17cTLOXPjfU4Y86sh8Q0KTm4M/FrRPvVhD+o/eY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=n28HPaz4ZfKuEp5zua82p8vJ/wBpKOfLvVS+wwbQJgBZN+nwAR9kAQc0KQCYvWtAY9i7GEUhRsXrLjz73f8gbbfaMvnafJhFqlakRjZDgY8tfvzsNq0MJ8aQOBcx43M7CRJ6Re24RelqS4nfkahL38LyZ9lyTthn9qBJoaZKP28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uMTleFpU; arc=fail smtp.client-ip=40.107.237.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uMTleFpU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U8Mclc8t24SmONQVpwHhZz/FWoiNUYXCoVD5gre+7YDg4Tzh3TQArb9WvPLfn0ou3Z2PZR0ZfIocjxODDH+iuKxTfSzFv+K+omdoEHZSCEoNLVSaBuu8UGZ9oKc0vCr+THvcwLT1W3iWSvSxW8iDQIo5klFSRbgOOMB7e7eMsDm3TlSgY2f1CvzzrbJ7QOdG4NIMMRtOba4kfKcNQLRT20Ozop9Uz/K3RilmDMcQyN3x7NYdbLEOJmbXzcGe1D1Q/x7qlUqTGmhHNZdsHv3rVyYIk07Jw9YF44HUFC8gBZyILU7ILzEtn5mPjLvupl/CBrnmSvr4weeSl+ENZ3Pi0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D2o22umQMf5QWri3K8RfsKsG2la1L9uWEO8pwlJyVr0=;
 b=R9Zr3/Re4uiigesV1nTrIXFo1xGgE+1SiL5AnrgVvNNH8Ya1GIAC42rChsgkvd1fgEtr5Vko0GL3YMILed5qNLmO8Au7HxP1i62zGAOT1GUvb8+9T3FcbkvhmRj0erLF01Y6G6rgrXnOx7u2d7mCL7XQUx6A9OoXDxxORJVEcCHfQREPeVrxxoqEgr/y/XzoSv3NvpeLK3rPU1kqRUvNp+CJSSw1sy0VM2CdXdXe52gp3SKRBEeMpLHP+LYc5dCBPINRd7o+zgY5qurLX8mS6EEk/NbPoHQuVs2gI/e4F+XtAvtbaOFL7nl7XhRgNDCLZV1B3eVZBvL2BeB0ZoegoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D2o22umQMf5QWri3K8RfsKsG2la1L9uWEO8pwlJyVr0=;
 b=uMTleFpUfCJelWdtpFJk4qKVJvI34Ri0kz746O8QeCjiTUF8X9V+hA6U3l09nfPJ1Df/o4qNonNq4jgKYEDMUNy/hdm60amdTvPRjun+REnUMVO+sherWwLzqiTV8SITL2I7UUzwZl00cxWIKgs9zaWBGaJor119dxEdemlfuUU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DS0PR12MB7727.namprd12.prod.outlook.com (2603:10b6:8:135::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.31; Mon, 22 Jan 2024 06:24:46 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::481d:7627:c485:9cb]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::481d:7627:c485:9cb%2]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 06:24:46 +0000
Message-ID: <c5be6a3f-bb45-58b1-a832-82c140299ac3@amd.com>
Date: Mon, 22 Jan 2024 11:54:39 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v5 10/17] iommu: Introduce iommu_group_mutex_assert()
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 wei.huang2@amd.com, jsnitsel@redhat.com
References: <20240116165335.6043-1-vasant.hegde@amd.com>
 <20240116165335.6043-11-vasant.hegde@amd.com>
 <20240119190955.GM50608@ziepe.ca>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20240119190955.GM50608@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2P287CA0002.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:21b::10) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|DS0PR12MB7727:EE_
X-MS-Office365-Filtering-Correlation-Id: a04bf535-d3aa-4693-f360-08dc1b12d43a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vV0z4FfuVgK4clbGFJM3+ibA+dH/ATq0v2C4atMqWnpmYqhJqrNI5OStMBZTzZxBaq+wuhvefsonB93VKDLkQHltoMzoKGUsz4L7w774H/x6zYEqISLZRr9ORXRZuT7FCdUtg2lZk5U1NqE8/AyiaWfml6KWazD42rZHuV69+NuIs7pVuvLIUeZIqHKnfL8DnBKQDhNGtQAMdrigUZgV2EVuzmZXgVH/jGkQvhSy9PK9wOd+hxrigiHIX8DvuJuZMTq9vdXyM7vBTzB/eXUEEPmqHeBBluSG2op4HvJ9Jdg5gEKPsEpPzaA3fn9sErmM4LrN/V8kOPQNdzHBbAbBEyEsV8mUBkR7JerMvlc9kXZzydPlsdkIJO57RXCL2HeXgKjYeZZQ2JkxdOzIA2oBhPDQKRTlhkmITmMZVlpgOC5V/BbKCsmuvfLyFCFfGLprEfequQcghGY1eYrPTtNsmYcRBmNM0ushWIxaRYE8QeuOMfuA8LJqB+CRZq1vgpSfrdln/TcFR9+Ti6FDeLJIJ34Z9gVJNPtmetdsRRvM6wmEmCq8WrZrwXGL5E3a91PjjFXMsGSA4KvmsoA+zlDxMXeQFAmt/g+vSqrOTbp30h7WZdLXLV4zjylXglq45pCKiU3/tdAHMAWn9QlMcD2KUg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(136003)(39860400002)(366004)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(53546011)(6506007)(6512007)(6666004)(6916009)(478600001)(66476007)(66946007)(66556008)(8676002)(8936002)(316002)(6486002)(26005)(2616005)(83380400001)(4326008)(5660300002)(44832011)(41300700001)(2906002)(36756003)(38100700002)(31696002)(86362001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eTV0SWRtYmtCQmxyRlRyd2UwbTM1MllJcDhnWXlYSGxPWHluSXplR1JMcTlr?=
 =?utf-8?B?VmY1bzhtZjZ0Y0RTaDNmS0p3dmxydDdjMy8vN20xcVlrS0JyeEtTQUh6QUJj?=
 =?utf-8?B?SjJWcTNoZ2RWWHJ3ZDA5V3lJWXJJdWdGSHdjM0RoZHlZZlZNaTdFTkxjdWdq?=
 =?utf-8?B?K0tPSU9KMFpzdUIxb1hXR2RtcmthQkZ5dnRiRFhObE1iTmErdWYzSUY4SmRU?=
 =?utf-8?B?YW1NMzQ5Y0FsWkIzRkZ0bDhLVzIvK3ZVRkZIM3QzQWRhVWRyUmNUeXVuQ1pX?=
 =?utf-8?B?WDdpY1RmT3RJbGxVL1pyckt3d2JHbFhaQnAxZFJEU3dkeVhmT2lDVFNudXJK?=
 =?utf-8?B?SVhFUkx5SVJQdlBBQXJOWUtqdlJvenhYN1QxYW11dlR1TG9Tam9FNmJQUFRt?=
 =?utf-8?B?Zm1qN0pERGF5bDQzak1ockNPWVNUZHlMTFhQNnlQMUhlS1RybllTbE9XUEI4?=
 =?utf-8?B?Vk1QOXJtUEtDOTZxYzBoalBJY2Y1SVNMUStjNlRiaTNDOHVKNXZaKzBwZ3Vu?=
 =?utf-8?B?SlJFaEtMVjQwMkw2dGRlVEJOZW02OWxNRXhPU21JQS9OWlRnVC9SVXd3VkMy?=
 =?utf-8?B?cVliTCtJbUxseW5ZZTRpakM1NVlWWGZvYVlHWVhlUzZZdzN0bmx0dE40Y2tF?=
 =?utf-8?B?V0lydUQzK1pvd3lmdzFiVU8vOTdFdjdHcFp0RnBCQzlGSDBPS01xRmRaWXZY?=
 =?utf-8?B?dmJ4cWN3aDYydVJRL1RJMm43YVNsWGZuOTBzZnRPZWJkcGo1eCtvN3UzTndp?=
 =?utf-8?B?NE13TDNBSEJLSHZiOWlFSWRPUXVKWTc2VTdhU3NHSlJrM1dWKzJpTVBEbDRP?=
 =?utf-8?B?ak00bklGR1JYMGNUZ2VtbExlRnZFTjdKYWdkclp0YjRmYXhYY0tydklEYUJk?=
 =?utf-8?B?dTFUNWs3Z1BHMUcrOVQvVXZhdzhBNnpMRDdRMFZqUjZWYzJRQUQvRjAwQ2ZM?=
 =?utf-8?B?TzZ1Y01HNlRQMWRKVTNRTUxUVEdBVzh6L0ExSjlkWjVnQTRNVlZMa09sYnFZ?=
 =?utf-8?B?eWxBL29WdVNzcjYzbnQzNXJOeVpHd0ZjUFlHVzBRZ25NL2krZkJMdE5PSXNm?=
 =?utf-8?B?NVNLc01MYk5TKzRhUzRnVUwra2YzMkovbWhwazhmcTZEQVdOb1hWWWJZVDZs?=
 =?utf-8?B?bE9XdEVNN2VaSklBMWk5c2tXMEQrL3Y2UXo5WVQyYjNnL2FNejY3eVAvL3dF?=
 =?utf-8?B?UnBxeW9neUxwSlI2MWNhTDhFV0lwZWJZTVA4ckNJZiswcVpaSGFWQmFhL2FJ?=
 =?utf-8?B?QWtKRnRzUStmUEpSdzFBUzFhZG5GYzErNkNWUzZEVnJ4MVQ1a2lYbFFDdTZK?=
 =?utf-8?B?cTh3ekY5TElYc1UrRzQ4RVQxVXc0MEZtZ1U5MFREVEdXMWhNS1NRTHJWZ0hy?=
 =?utf-8?B?Q1lxSTlZZGFLTVhBeUNOdlZTRWE5Nk9MQVhuZDltMGpDRG1vdnVmaXNnRFc0?=
 =?utf-8?B?WFdhTHludEcyaWp2SXdWMzRnaktRN2RjR3J1RTJVckU0SmpPRWUrdVZIK3N1?=
 =?utf-8?B?RHVseFlvejFsYW5UM1F6Y2Q0TzNubDVSNXdKVVEwUXp2Q21aMG5lQjJPVHNF?=
 =?utf-8?B?ZmtqeUJKK2NqQmVUMDhINHl4aUN5RFVhZDdQQU9DS3RWZDRIZUVKcjV1WW84?=
 =?utf-8?B?VndBNWtUdWtTMmJuU0o5UkpLUitrenZZdkp5dndUZkVsNnNPYTFCZ3ZoWUly?=
 =?utf-8?B?ZTgyc2MwVldlck84UDhEa1ZYVjZQUVZiWC81UVNQbjhLUmcvMU9JK1BMTldL?=
 =?utf-8?B?ak81R25YZ2o3RmlnU1hubEU2RzVRM01PUkpNM1FBZllodFBqVU80alZMZEk0?=
 =?utf-8?B?Y1NjekEwUTVmNVhoZE04VlEwM09kbTZUS0JFK2Z5SmFxUTZOM25EaGxDc0Ru?=
 =?utf-8?B?NnNRbDkzYkdpMjNleFVtcFJXWEMrS2l4YTNycldNNlIya0l6QUNXMlNFeVVy?=
 =?utf-8?B?VVEzTkFyb01qOFNONDBQNUhtT0ZoaloxcjRnREZSckxwMjV4M1JXc2pqMGw1?=
 =?utf-8?B?QUlBL0J2a2o3dmdrTUxTbjE4LzN2RUJCMGkveWpMYjdWZ0ZwZVdrdlZibE5t?=
 =?utf-8?B?b1l1ZGdiNkpWdGpsQi9NTFlZOWVPbVZMdzNuMjRoRVpDYWMxbkw0T0RzR0xP?=
 =?utf-8?Q?BJMidEcbKjSkcCRvvMbCWcQJo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a04bf535-d3aa-4693-f360-08dc1b12d43a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 06:24:46.6959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MVbBtPTNAqod6idnl8H8jn2ZWf8sFMBLkwIuP6+D0hHsOy1wxr+RlSboaUllTwBYafMrhKYQ25gk69qJN8UhGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7727

Jason,


On 1/20/2024 12:39 AM, Jason Gunthorpe wrote:
> On Tue, Jan 16, 2024 at 04:53:28PM +0000, Vasant Hegde wrote:
> 
>> +/**
>> + * iommu_group_mutex_assert - Check device group mutex lock
>> + * @dev: the device that has group param set
>> + *
>> + * This function is called by an iommu driver to check whether it holds
>> + * group mutex lock for the given device or not.
>> + *
>> + * Note that this function must be called after device group param is set.
>> + */
>> +void iommu_group_mutex_assert(struct device *dev)
>> +{
>> +	struct iommu_group *group = dev->iommu_group;
>> +
>> +	lockdep_assert_held(&group->mutex);
>> +}
>> +EXPORT_SYMBOL_GPL(iommu_group_mutex_assert);
>> +
>>  static struct device *iommu_group_first_dev(struct iommu_group *group)
>>  {
>>  	lockdep_assert_held(&group->mutex);
>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>> index 7f6342bc71c3..c983b6a1ebce 100644
>> --- a/include/linux/iommu.h
>> +++ b/include/linux/iommu.h
>> @@ -751,6 +751,7 @@ extern int iommu_group_set_name(struct iommu_group *group, const char *name);
>>  extern int iommu_group_add_device(struct iommu_group *group,
>>  				  struct device *dev);
>>  extern void iommu_group_remove_device(struct device *dev);
>> +extern void iommu_group_mutex_assert(struct device *dev);
> 
> This shouldn't be unconditional. Like this outside the other ifdefs:
> 
> #if IS_ENABLED(CONFIG_LOCKDEP) && IS_ENABLED(CONFIG_IOMMU)

This is already covered by `CONFIG_IOMMU_API` check.
Also lockdep_assert_held() is already covered by LOCKDEP config check in
lockdep.h file.

So I think another explicit check in redundant.

Is there  any other reason to have explicit check?


-Vasant


> void iommu_group_mutex_assert(struct device *dev);
> #else
> static inline void iommu_group_mutex_assert(struct device *dev)
> {
> }
> #endif
> 
> And a similar ifdef around the implementation I suppose.
> 
> Jason
