Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012012.outbound.protection.outlook.com [52.101.53.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C9038642C
	for <iommu@lists.linux.dev>; Wed,  4 Mar 2026 21:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772659558; cv=fail; b=bIEA+P8iHEe0cVWbhn3bEXAC0aymFidDFiTUBQX6egczc9f3C4iKfLD7hqu1vo60gNC70UNLHc6i86rplsVRX2M4ZRfzqWEhQJAu4Tt4ou2rtB6r8eYX4B6H+LKDivUKsXF8qL2w/GKGIukUx346ud1XyxYkMxIPahkzy1PIrs0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772659558; c=relaxed/simple;
	bh=Sx+/5vrk9gB7UWKePrcuBFvZHncQcrCkdnQoV/6sQ58=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hUOVFyaMAJ2p0MaoA/zkLoPuw63Bv0wh8i40vGo1jpN73NSfIJp9ljoq+Ryg/z1PMfOvFdoKexrvwGOy302/N+ewQm6++6t2IiwQ/xhR0mIf0NVLzZLIxRILB6Q81YW3nk0zfBFNYvhoz3yVpzGprap3ui3JpQ8S1/DwDeapwkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1YqKETgp; arc=fail smtp.client-ip=52.101.53.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1YqKETgp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M3GZNZZJsxNdCK5gK93km7/5h7uWnaMSbGeCcX1jMQONL+UAMPN9i7ChJ4CAVtrS0inyhv7Z3ZvzNF82fFEdKnjBEHLczV3PqLl9UU7tOf9l2x4drkvm6Rppye5z0BwJY2htSPgL7p1po0Sa8B5iUlf5p+1dO+CWsxXDpJU5sa4FvmrCWiVc0XRkVjwboJ9GXuqnzRgSIuj3cqgrr6ruce4VD72zxJ4RJrS/4LESM9XFwu4QtS2Lf8fRSA8b14LkrAE642xmQi0RJAURxY5xdoX+nxUJtxTZ7BUwvCxjvQLTtg9lhkbpTVSnzw9oaDsb0U47T5+EAEG8UdfYn5anRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/BghuSkMcbndV7aFopjQT93dx9stoBRyTvZuoo+OShI=;
 b=Q3zQYLQCma75Z5TqAXI8YR75UNc+RfUsAOHdnQz18UbgI3/3b9Bi5MTythlHJVwo1Mx4hjZd1WeTsKNvXr9DTU1lZdC7ocIvw34axSDXOgE8sUGUPYi2+HcDv6dm+y0zI+pMvPCBHvEBvkDUtMNeXkvvdRszSe1TuhgCDk+e1p+ydfAnH6u5ojJRn8Nh755wROarCPbjm6Jeeh6HLswc3qrWGhN6mSf6lz8aQIT2HxLdNmSAtY06gZE1S2Krkiove16KSKHnoDFx268JuoISomp2ds1v5hUr1T6/UV410yUu/EvLwiClUWTeN0OtbhVo5QMVOfWHVQHpfzNu7c2whQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/BghuSkMcbndV7aFopjQT93dx9stoBRyTvZuoo+OShI=;
 b=1YqKETgp1rD2pXYwvPQWtmYKWvaesamFAyzsI7uQ309wlf+lmwt1aAQ7BG61PcUIh9d2MNIUujLNdCrObXs8jkKfEiPmIcYJmmw1F6y8xG+aFftPfEZ0VNvoTQNnMsQ5y6+wqeaDe7CkUORktLAi11OXXQ/K9AmLOSU3JEzbsyc=
Received: from DS2PEPF0000455C.namprd21.prod.outlook.com
 (2603:10b6:f:fc00::514) by SN7PR12MB6957.namprd12.prod.outlook.com
 (2603:10b6:806:263::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Wed, 4 Mar
 2026 21:25:52 +0000
Received: from DM2PEPF00003FC2.namprd04.prod.outlook.com
 (2603:10b6:f:fc00::224) by DS2PEPF0000455C.outlook.office365.com
 (2603:10b6:f:fc00::514) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.4 via Frontend Transport; Wed, 4
 Mar 2026 21:25:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DM2PEPF00003FC2.mail.protection.outlook.com (10.167.23.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 4 Mar 2026 21:25:51 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 4 Mar
 2026 15:25:49 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 4 Mar
 2026 15:25:48 -0600
Received: from [172.19.71.207] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 4 Mar 2026 15:25:48 -0600
Message-ID: <fd00e5f0-c9fc-7ba5-29b8-38de1e26f923@amd.com>
Date: Wed, 4 Mar 2026 13:25:47 -0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V1] iommu/sva: Fix crash in iommu_sva_unbind_device()
Content-Language: en-US
To: Yi Liu <yi.l.liu@intel.com>, <joro@8bytes.org>, <will@kernel.org>,
	<robin.murphy@arm.com>
CC: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<baolu.lu@linux.intel.com>, <vasant.hegde@amd.com>
References: <20260224183056.2628698-1-lizhi.hou@amd.com>
 <1c486a5a-7115-44fc-9705-18b292cb9d00@intel.com>
 <14caa56f-999a-ae00-2840-e97080b4f7af@amd.com>
 <967d515c-f098-48ff-97cb-2de34f17aa29@intel.com>
 <945476d7-6e2e-b8a1-904b-09c8c87067a2@amd.com>
 <d9d16633-85a8-4e59-9188-289af13eea04@intel.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <d9d16633-85a8-4e59-9188-289af13eea04@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC2:EE_|SN7PR12MB6957:EE_
X-MS-Office365-Filtering-Correlation-Id: 4911eea7-c62c-4da9-70cf-08de7a349cbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|376014|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info:
	FeE09dzx3TXzsTLYLz2VbCMRA8f/S/YW9q587Bq5mT+jn1O+22rfLivSIOOHH7aF+N+o1EqUH5RznzRzkvtderKL6T+fBgifZDGqrZnbu4/Cw0zlnHCUkbyVeKHvSDkH/owqXHk+U5afA76EUrwjoW0PDZ5g3R11cfb6fJAm11D752eyuL6wfYDVvFAj1Q6Jtd0+J7mkSW66daNoDkILetjRSKudW0LKd1pey66wyyY7jtHuP3oEI0ACKKdxOpJtWFKjZiyuRpVyHTxZZs/dOUqEMRYWnTvYzTQ3QNICAzpSwdOgZEpZtW/DoGSSRVuWXXEJXjW/rCadZu7kb4LxiuojMpjz0yfUq/SSyho100JxGOBrvCF3F4Qfn/KPhARCfW245zIF09R8taA1Xe3907g2Nssd9kLPHtX++mHoOQ5p3tSwmFiAMi+5uaTficJYK9msxlWyCgkY5VLQyNGwDtcmZeUCKcZfx6Q5rMLio5OwNf1pFxu3oHhRwG3k/U3eIdDfWgA1lvQy9PhzbDISQSy6TthGstzRxloVwuyt8d/DAmmGPqWmw7GfbdUFO1eUAkixuWGxXKB6qCwYV0bPx9GDa823j+c8fABeaLpqztzTIyYmqquUJ2/Nqr1rxCQoptgtEp57qprWGxkhwOt6j/6i4pRhVaXQDMcPseMF4v8NQGP/+3rkbOedMDbGgPo73P0OX4l842QmY/9EYe8sHKjz/VowerPX68xbwNsnXCRoWOTdmPR7OxSA012lcJPnkbjfVDkkqq5wxwBKfWShvQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	PZWIW4UHR8gnhhk8C/YwpQ9FoCbrevFhNZyx7OTyLXeIOZ+ctk8N1hV3iShZ0cTjDTeBfMpX/P0Y0zpA97LdbFRhXDGhysvytx76YSoIC1Y3rmK6XX8dvylnWxfKDHf0h3Yh4NFpJJAESpq8tdOAaxYmWElC/Idl9Y2F+157WM/H1MLLvW7FfVKpFx8vllygwIAw0VQ7VtEAGMcEEq+Yq9KClRXjjdq1rZdqYgemJOxMBzz3LOfhnhsRAJ7fDX2fX5Gepu191yutS0GeGx9cPCLZ4ILBICi3KXOUBddHwdiEepq7eR0MRqbKNlqatti9oUW9r02nR1V7xAbfm4KeJ5Z07q7CXpyvx9IC6iO/DE5fo6xb3d2fNNq+q8lFTs4fNu6HKelA+gCRsQsa+TXKLcLUVqYVJUk2SI4SpZVsYnx0V90It/v0sTcg+yJGxJTt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 21:25:51.8800
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4911eea7-c62c-4da9-70cf-08de7a349cbb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM2PEPF00003FC2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6957


On 3/4/26 02:10, Yi Liu wrote:
> [You don't often get email from yi.l.liu@intel.com. Learn why this is 
> important at https://aka.ms/LearnAboutSenderIdentification ]
>
> On 3/4/26 02:33, Lizhi Hou wrote:
>>
>> On 2/28/26 04:14, Yi Liu wrote:
>>>
>>> On 2/26/26 06:09, Lizhi Hou wrote:
>>>>
>>>>>> diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
>>>>>> index 07d64908a05f..523b8c65c86f 100644
>>>>>> --- a/drivers/iommu/iommu-sva.c
>>>>>> +++ b/drivers/iommu/iommu-sva.c
>>>>>> @@ -179,6 +179,7 @@ void iommu_sva_unbind_device(struct iommu_sva
>>>>>> *handle)
>>>>>>               return;
>>>>>>       }
>>>>>>
>>>>>> +     mmgrab(domain->mm);
>>>>>>       iommu_detach_device_pasid(domain, dev, iommu_mm->pasid);
>>>>>>       if (--domain->users == 0) {
>>>>>>               list_del(&domain->next);
>>>>>> @@ -190,6 +191,7 @@ void iommu_sva_unbind_device(struct iommu_sva
>>>>>> *handle)
>>>>>>               if (list_empty(&iommu_sva_mms))
>>>>>>                       iommu_sva_present = false;
>>>>>>       }
>>>>>> +     mmdrop(domain->mm);
>>>>>>
>>>>>>       mutex_unlock(&iommu_sva_lock);
>>>>>>       kfree(handle);
>>>>>
>>>>> will moving the below hunk in front of iommu_domain_free() simpler?
>>>>> Only when (--domain->users == 0), shall the code check if sva_domains
>>>>> is empty. right?
>>>>
>>>> I am not sure if this can be moved in front of iommu_domain_free(). 
>>>> Will
>>>> iommu_domain_free() be possible to impact sva_domains?
>>>
>>> sva_domains is used to track domains associated with the same mm in the
>>> generic layer. iommu_domain_free() calls vendor iommu driver's 
>>> free() op
>>> with domain type specific operations. I don't think it should impact 
>>> the
>>> sva_domains.
>>>
>>>> iommu_domain_free() calls domain->ops->free(). Could this call back 
>>>> free
>>>> sva_domain?
>>>
>>> I think so. Check intel_mm_free_notifier() as an example.
>>
>> So if this is true, after calling iommu_domain_free(), the following
>> check list_empty(&iommu_mm->sva_domains) could become to true because of
>> domain free. If we move the check in front (before iommu_domain_free()),
>> the check could be false. That seems leading incorrect iommu_sva_present
>
> list_empty(&iommu_mm->sva_domains) can be true because of
> list_del(&domain->next), not iommu_domain_free(). Am I missing
> anything here?

Ok, I searched the code more. Yes, you are correct. I will generate 
patch V2.

Lizhi

>
> Regards,
> Yi Liu
>
