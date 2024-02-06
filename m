Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2057.outbound.protection.outlook.com [40.107.100.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E41132467
	for <iommu@lists.linux.dev>; Tue,  6 Feb 2024 16:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707235344; cv=fail; b=r32/A1HL9K0O555rwXPJjpyL4yyTs2wwDJ0uZkn/BLxkso+OL/9/wi2HFEe4KvotN9/VYoliIKn3YgxyjH17f8R64BQjNLa0bAogVAAAGYSsEkg1Dnwug+S6NO/9cS+842tyWrPMCD1Z9qCWme4P3hpHTSNzyyNupQGkXWsOB6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707235344; c=relaxed/simple;
	bh=wNjsurPkekANGU0FDW217h5hohVrHL4rFlkDYwbhccE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qqIWVtp5ZAG5Igu3niAIBZ9cg3XKB5b+/e/YO5WMvEFvMecTznRXOMtc+LZcsqZEtSLuT9YjNBueIvN5rN6q2VUb0cpKaWs8fGBsEe/DXwP6xKJ1imDmg2MqDROf4kGpQxbmhplUq44fvyr/QP8xHcaIR/maAfTmFErqQ5LHN88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=j4JAcT8V; arc=fail smtp.client-ip=40.107.100.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="j4JAcT8V"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W2c02zMVi+8tQ7hNoiGBAfb5h/WopnZvyT6trbQt+oR3utToZWp0nWxjpwTKdUWf/M5gmF4U3gYRqvIpY1vcrlXAdmWiGCeFk5teF509rtYUNpGTOpz4BJcrc7KSJ+LPWOBoFMY3lR6a28TO4f3qDNpl6NIvvfjMY4clQ1fuDywqMeEDEKaCemkT8OVJd5kgmGc8DmxU63QddWF8S+0p0sRGh287uGmWHy7Woz+JU2o0rp0TQpA+t8acTgZFuwOZ0YBAJ9YEI40E37mNnG954IKvo1zqT+nrzf0LJSOO9yNCfhdkuKMi4v/dgf9IBLG4orON+48ayzZHICYt9poI0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cb5w5IhujAQd4TBAquYNRvCaMzITvj15klyRVAqvL0k=;
 b=aL2LfDsUvllHsJLuBVocOhMp0f74oP9fQwVqDLwMvmw/QHgayGROU+gOpMlzBpRVtqhLM+Me6tD9J79qWKSLEVi7vd01xCg/Qc7oIMvpBhQ5kkqBTbbICiVOrum0xKj2Ed0tPfFdXby8Svju8i55ASVI83CALOjy87pT0l17yrXg3wyYXkuh/ppvkxCNK10BxnR2IvV+6zvv0/xjvDddO89N/WVWqz9ydrk/vaDnbZX34JYFxlh+hloCj4TB19d0W1qkLR0aydOCCT8o4p1q0/5zBKzqb1PN8X1w9mLh0uCZ+fMw/DgyAPpqx9Evc3fLN0t5PXRXUw0dPskzOE9R5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cb5w5IhujAQd4TBAquYNRvCaMzITvj15klyRVAqvL0k=;
 b=j4JAcT8VLW5aNi5wTq4Xh5gpJZfdsKb1U0sumLkYGr6xf+25xrQc2pJipQ+gneLUo2WMmHCU6eo9qNs4ygQQDCg5WwcRVIB5gMWXJgZtleRsfVl+4YiOmqSXmTIluJzV+MG2BhvFn0a613Q47CP2BBjCV3ta23NKA3GX9PzFssA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 PH0PR12MB7984.namprd12.prod.outlook.com (2603:10b6:510:26f::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7270.16; Tue, 6 Feb 2024 16:02:19 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::481d:7627:c485:9cb]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::481d:7627:c485:9cb%2]) with mapi id 15.20.7270.012; Tue, 6 Feb 2024
 16:02:19 +0000
Message-ID: <1602c248-b1cb-639f-8a31-05e147f0f633@amd.com>
Date: Tue, 6 Feb 2024 21:32:11 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v5 08/14] iommu/amd: Add support for add/remove device for
 IOPF
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 wei.huang2@amd.com, jsnitsel@redhat.com
References: <20240118073339.6978-1-vasant.hegde@amd.com>
 <20240118073339.6978-9-vasant.hegde@amd.com>
 <20240201214622.GS50608@ziepe.ca>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20240201214622.GS50608@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0049.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::24) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|PH0PR12MB7984:EE_
X-MS-Office365-Filtering-Correlation-Id: e101d495-bd79-4efb-56ec-08dc272cfee9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WlLo44YcgiauZddhoaLdEIP+hUaGlSaI/RSAF82PO5UClTUVEi19LeffNVg/JSrKQkz+u3Zj+dZJwUA00yvb4tLVM/+pRnRHnRNi9O5SDou9YvT58WskT62CWdyChjn1cAgDV7PeXtUgy5BevbdF4xq4ZI5WV9JTC7FvhFHyvZyklDzLt2bK6ejWFH29A5vSN+I6ZO/n46x3cE2M1hSb+yRWNz8D/SbMP/1Z74Thimc42O3WdJE/SGnjMhnVPgXE22DZEvG7Ol2ChVyVNWX/Gdwr6jHcumE9j0sqfDJElxCNsz0EZHbWGvpNpp09lsAH4UjHknpQ5o6BvY3+6SLCg3nij8hLPUzJmbJ4awVeMTbMBu5r1XXMrNwnUPKfuw5Vwtua8bbNH+pkP3M/dSdEKf06RZSN37/ibOyxteFYC32Gw4A+tslve/6+f2KoXumdNtMEYtxBo2HpHtx+Krv8NBjTaZETXe7e1qf6WlVxAyKcyDW2RW54M9Vb1mSFpGmIX40Z3t6fYcRo5Gk5AOtyId64lt4u43Ik41pWU2hxj6n2WUPlRQzmbiheovB8B7F32/P1M9hLzDWZNQ/8jbV8cNedoUn8T13w1Ou1jphExQUt9ljaJDQP6NOL0A5xIly1OZZu/G867t293gUzm6CGOw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(366004)(346002)(376002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(6512007)(26005)(2616005)(83380400001)(6506007)(31696002)(478600001)(53546011)(6486002)(86362001)(66556008)(66946007)(66476007)(4326008)(6916009)(8676002)(316002)(8936002)(31686004)(38100700002)(6666004)(44832011)(36756003)(41300700001)(2906002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RXJGOTd0SzlFcmhkUzJsSENsdEV3ZVNGVjFiVDJHcUR2ck1NWTVUcnhsZW1V?=
 =?utf-8?B?Mmc4Y0o0UWMxQjFrUSt0Tk55T2NpNWYyUjVFc1RydFZHcDUyYjdRNGt5SWdw?=
 =?utf-8?B?b25FSktjV3dtenVjeVkxR1hqVEFFWldCcEZQQ3d2UG1sQTI0WGdiZ2ZKV1la?=
 =?utf-8?B?MW02V21SbktVRkJiVGZCc0tDa2VyMyttM08wclNXZzdwTGNHTUpJcS9IWWxh?=
 =?utf-8?B?bGRFVnExbjNDMU0xb1AyZjJsWS9jVS9IMnpQUzNSU2RMRXh3azhDTWM2Qkpl?=
 =?utf-8?B?N0RmYVBlK2FtcFdBcksrUUNDa2prMHhuNUFSMXpidE5OOTgwTlNvL2NZU29H?=
 =?utf-8?B?MW5UTlBkU1FJRG44K2tENDN6NEsvWXFoY0srLzlvSGpqN1NrdWpSb2thcTY2?=
 =?utf-8?B?TkhKQ1RMZDNpWm5XWDIycWtIYlJ4NEhpN1JMbysyYU1ubUNkWCtpQmwzdzc3?=
 =?utf-8?B?UEc2RXRUYjZaQVdGZHhINGdwdTZ6S2pMNHM5c3l0dmViRE5yRjZGTkpEWTNV?=
 =?utf-8?B?eWVpWnRQT0xpc1laS0grTnlxdk10RGNxakNVOTkwaUhLQTBWK0p4UzVaendS?=
 =?utf-8?B?NjhNcFhTazlyQlpaVjhuTUpYV3RUdW04cVl3UEJGcjEwSTBGVU5qcXpJdlIz?=
 =?utf-8?B?alpDZVZsY2pSVys2TjlFbWJmaW5MeGZ4RFFudzE1aXdybkl1N0ZvVmRXRTY5?=
 =?utf-8?B?MGdVWVIyblBIU2VNR1RSU1NWR2g3S2xjWTNUV1ZJa2VqS0x1WnRPRkRWWk44?=
 =?utf-8?B?MG15T29XVk9aRHArNU9pNnVEQSt6RlFVZjJ4S2ZqdTBlUXRKUkZ3K3NOYWl5?=
 =?utf-8?B?ZEdIQlNJOWVPdmF6Zk1abFkwamVwdTdjMTNCaUwzU2lnR3NOYVJEZE1Ja2J1?=
 =?utf-8?B?NVJiRDhJU1V4RW0yZXc3ckJvaEo4amdWYlNjWksxTjY3ZE5DelVTV3Bzemcz?=
 =?utf-8?B?SWVneGZRWUUwUHpxSHppZy9UMnJxSTZab3ZUR2EvcXZNeWs2VDdDNmdySytj?=
 =?utf-8?B?eDNZTHA3cEwva3QzL0NLYUhWM3ZqM0lBQW9zOGU5QS9QdmtITnRJZnNOc2Q5?=
 =?utf-8?B?YjhUWDhWbE1yemJLNTFQSVJMK2l1Ky9pZEkzMDYyUTB4UTVSckRPc204ZkFW?=
 =?utf-8?B?cTR0S3poZVo1RmNYS3dxZElqUU1kMlh5cnZ0bC9NWTVyU2tMdlVGaUQyRXhK?=
 =?utf-8?B?dFBBSEFhTERkbmN2WnNTS0h0YnNidi93Ykc2RFNjVG1IdHdENjJIZUd5amlL?=
 =?utf-8?B?TFhtU21xTVhOTTUrZnBJQ1dLelVFWTR1emNnZWdOMkIzNmI2NTRrRXZBQW1G?=
 =?utf-8?B?SVdoa1MyY1IvT0VlRnJYbWlCMmxidnlPaWVId0g5MmhTTHU1TVhBSStKQ0R2?=
 =?utf-8?B?QUVEVUlxOW9qWndMalBOd0F2RDFhUjZGdG5xZWdVTXFwSS8wVWdGZFJZVWFF?=
 =?utf-8?B?N1NLQm9KK3g2Nk8xSFA5cDRtU0k3aXpFT0VCL0V1QTl0UFltVG9RR0ZoUXQ1?=
 =?utf-8?B?TTBPSThDLzZOSmkxRXk2STRMeWV0aVVDMjZsRE5xYW9OQjJUd2lJT2kwZHBr?=
 =?utf-8?B?aGdBbkZndlFkcmsrUTNMQmpzZnhiKzVTdEg3alFiNkFGMjBybUN4cUNMeTNk?=
 =?utf-8?B?WEdRa3k0aDl3N0g2eDdZSkZ2MGRHSzJGS1M2QkZBcXpGVWs2aitVSnpTaWxL?=
 =?utf-8?B?MGNOYU9oWUw1K1RpemRyY3BEU1NDbVEyQXNNS2FSMWp4N0xrNEZ2V2xYc3hx?=
 =?utf-8?B?dm5kcjlveG5jWWtUT0N0ekxRa1Fmd1VYNEhyOHhSbzEzL3ZmVzR3UEJCWGZ6?=
 =?utf-8?B?bFRaTmtENnZpMW5URXNTZnZ6eENMcnQwbXJhNDAyeHlMN2E5b1hoV0F3UlNm?=
 =?utf-8?B?bzBsUEp1TFp0eWhaeEVZRHpvdHREVzYraDFlN1g5MDNFZHVXYjErWGpLMm51?=
 =?utf-8?B?VC8zTUFIOVdSY0VuVENLL0cyeVR3V2E3S3Z6cEZzS1FLcldwalNleWdEM1BL?=
 =?utf-8?B?UzdxdVRqVnVwMEh4b2ZFQlhydTFIejJpSXFhbjdmYlRjWC8rWGI5VHBkcFIv?=
 =?utf-8?B?Qlp2WTVtcGZFTGlUWTBvdlRrUkMvdUJCd3p0ejIxYWZCelVqRk5WTzNHWEZw?=
 =?utf-8?Q?PB3oQwf/gKvXgm1p9TZCiH+vb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e101d495-bd79-4efb-56ec-08dc272cfee9
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 16:02:19.1751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WVjxWY6qGgxbOLggSmvO7kZXq6bphywMe2/UM47WjqxK7ZF56N4mLzuPXG+bcHl5j9pti5Lvyq9qcgeRimtwVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7984

Jason,


On 2/2/2024 3:16 AM, Jason Gunthorpe wrote:
> On Thu, Jan 18, 2024 at 07:33:33AM +0000, Vasant Hegde wrote:
>> From: Wei Huang <wei.huang2@amd.com>
>>
>> Which adds/removes the device to the corresponding per-IOMMU iopf_queue.
>> It also registers device fault handler. These interfaces are called
>> from IOPF feature enable/disable path.
> 
> "fault handler"? Not anymore right?

Yes. It adds device to IOMMU IOPF queue so that we can handler faults from device.

> 
> They should not be called from the iopf feature path :(

We enable IOPF feature (and device PASID) in set_dev_pasid() path when we attach
first PASID to device.


>  
>> diff --git a/drivers/iommu/amd/ppr.c b/drivers/iommu/amd/ppr.c
>> index b1751eb495fd..6b1fdda95514 100644
>> --- a/drivers/iommu/amd/ppr.c
>> +++ b/drivers/iommu/amd/ppr.c
>> @@ -163,3 +163,38 @@ int amd_iommu_page_response(struct device *dev,
>>  	return amd_iommu_complete_ppr(pdev, resp->pasid, resp->code,
>>  				      resp->grpid);
>>  }
>> +
>> +int amd_iommu_iopf_add_device(struct amd_iommu *iommu, struct device *dev)
>> +{
>> +	unsigned long flags;
>> +	int ret = -EINVAL;
>> +
>> +	raw_spin_lock_irqsave(&iommu->lock, flags);
>> +
>> +	if (!iommu->iopf_queue) {
>> +		raw_spin_unlock_irqrestore(&iommu->lock, flags);
>> +		return ret;
> 
> goto out_unlock if you are going to write it like that

Ok.

-Vasant
