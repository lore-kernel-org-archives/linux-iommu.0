Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010038.outbound.protection.outlook.com [52.101.61.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0581B6CE9
	for <iommu@lists.linux.dev>; Wed, 25 Feb 2026 22:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772057381; cv=fail; b=kE1bMMSaVNyV64h+q/1V+5qDQ8NveDJqA1qsG53MqqoVMv2MZ54zfZ46mPOrb6+r60Gm44eorzjEQM0nhI0WRBPx26a2oxGCV1oAZcAFLBEKy1p98Ipc2oFokZ42mok/dQlEhUf6sS9Bnp455mlanr4CDLe+ay6lUhWEIHhCM4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772057381; c=relaxed/simple;
	bh=4MpZ87kcHNcmyDr3X98firuk0UHRNCZv/tCxEwimHxM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bva5tCglieSEdIV59WYFXOmVJJIrexMz0r8Z1DkGpI9/SNZ44mhy92RhGm5TiEPpDe/PiYpsJ7U8kFSANAdCwqdAYvhHLkMSyDCvlqv8ovIEB/EJg85GPbdWnrqvzNTzglpf08yojtZ6piiGIYLaT27Xj9fwDF9gwyr3a+dNseU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SKoxrd1L; arc=fail smtp.client-ip=52.101.61.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SKoxrd1L"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wtcCAAZzqmkzSBkro/pYKIJ4pfs1jMNmKi/swDwnU9h/gzYq8DhIgaVbLIgZK6ileTyrS5tsii/88TETalQAdSz+DrLyDDzuXKyBvVO0uzI9Utho7LBmrFNuxQN6nbTcHkwk5bsY/QKOlesZu9GBnFzRJVYXyxnH1weu6NwiuZw8I00wehW/T+3Z1TyzeBplKDdioVeFJP4KfcYrJGVr04gTfdL6+PohGN448X4qViHoWrzc7pxsmhrPfgCiUmJLIGNuyhyznoT9XOIObOphLWJ/M7aiAIIy9m4F7xDLQim7UonIa2BTqy3xzmAd22it7uK3WI/2fft69q6hEdbdlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=35v5r0FWHZW1pnjyVzdBf2Unu5cTZHXefbutkVj9LUA=;
 b=MYZYmLD7nUz1prBb/yXJBQNhMvzNDw+cuYEoob21ooZcvtx0LjIgq1+ze9iWP60tg+mRM++6UHkfXERDNNzuAq9wsX361d9p8wTKuEgefup0jrHWYqH9HTNA/6V2bJ/DNOLXNLhvvn/3sfoJscydDpND+BHn/Dmu31n47PCULrzLQqQ3c/8sR+Lk/6s2aMPy8DfWNWWXHhsqgcWwN5FVlRft3oWVgMQpyZ2G2NapnRGnVogpS6hBIsvwCxcNjdJ+F+i6ytknCWCXjDMq/EzDspttP2YmAHnw6UhCMgrwmohycQGu8w8o2kMLYHWZUjwHjcXy/ATHk6Kftv60LK5u2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=35v5r0FWHZW1pnjyVzdBf2Unu5cTZHXefbutkVj9LUA=;
 b=SKoxrd1L71iNugSsBKtlx0zqVBz+iDqhdFX9Yjp36663WieIZ6CiZX/Z431yb0yQEnq9EpGrFfP1m56Lloid/XKh3cksJ3zLQ4vjRiuy3NNxl88u5NGWm3m1ZO9H9S0x1kpUa316ngLCAq/Gi4h6tWZOXBF80pBLdJLK4/Y0Wz8=
Received: from SJ0P220CA0007.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::15)
 by BL1PR12MB5970.namprd12.prod.outlook.com (2603:10b6:208:399::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Wed, 25 Feb
 2026 22:09:35 +0000
Received: from SJ1PEPF00002322.namprd03.prod.outlook.com
 (2603:10b6:a03:41b:cafe::a) by SJ0P220CA0007.outlook.office365.com
 (2603:10b6:a03:41b::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Wed,
 25 Feb 2026 22:09:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00002322.mail.protection.outlook.com (10.167.242.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 25 Feb 2026 22:09:34 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Feb
 2026 16:09:34 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Feb
 2026 14:09:34 -0800
Received: from [172.19.71.207] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 25 Feb 2026 16:09:33 -0600
Message-ID: <14caa56f-999a-ae00-2840-e97080b4f7af@amd.com>
Date: Wed, 25 Feb 2026 14:09:33 -0800
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
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <1c486a5a-7115-44fc-9705-18b292cb9d00@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002322:EE_|BL1PR12MB5970:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f5039b4-c55f-45f4-c0d3-08de74ba8f20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7053199007|13003099007;
X-Microsoft-Antispam-Message-Info:
	pYaVnyMShwVWQezYTUKIPB9+1XRgvMDa8DaU3XTOKPzX/IA/Yk/OJrWT1RN++i7+felbsT8iiALKwzR8b1UfMFM4G/RfT34EKXeHKD4VZ5pPP7qPNzvLdUC4yGCwQZ3mwgXlvmOm6wwHZ4VpQRut5uC3CcdQiYo8oeY/GofgsCS6cuV5ZlRJv2PUQkaIqSfkZc1JcFEtgFsbuYiKdxmze+qs5KowK7knxpKhWF7zlp/Wols1vdnlK0p8JQBjDiHB7By6in23vWtDOXLYOGwaDoSyfsGsU6vEuE64+ttmuiILYStdkKVaHPJI7tnKc5+C2PRX0E1NV/XeGTmwHfDc5q/UZau9E8GifUlpM1OGTVOoHBRve/MBsVMB3vmaLWJ4UxMX/WKZX/2N0B4osZMrzhGn94GnvieH/eae7p6w3ma0PkX6SH6E/Jk7V1msTaHClBgi9Me+N7/Md9b/Gq7TAisRyrLp+mN3Y+5tHRlKNVzrZew0CxpUV1Ai7qGPxSj725vr9GLgQ2I48j4IfuHGZtUPjhCJSg4YCnDVXf+NiomdCKoSqS8Tky/RgI9ATUEKNskIX4A4IzzoeeYqwJ9+6EYrLi2Fe91DRITSnBVoCj+h2CJmOlkLKChFHnp75IBSz8yA8zsWcggvLLxy6uNJ2z3O8kkyqqMxKrNIhdx23CFEeae2OCFeOYV76EcvZgMljb8fZWwLWL/U1ewhmFny8GFKyIKl37Hqix/MOXn9bX0giD022svk64b6XFT0Rz7ExrzIB3Qzt9AVGpkcpa22nW3YG0tviCWBXIVAFbx/5RTUw69V+4irzoXESE6l/rZNj5eydxVNK5JOvkboqT0gyw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7053199007)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	NId5jVyKml+x+AeXK8d4jjthKft+0lC8X/6+2MD7JD4tKH2nwguJu8Qqr1y461ee25VCRPrnXrAp0QL3/rCuFIsHd6pWuYsaCaAlV0fSWJwyYcKvPv1jNn3YhZw4ltSQu4b5aWaabkyjcvJZHILNRsDgd1A5d0Yg6Pba3UQ2/m1yLYji+YMtmGBEqmMBwxqUhsMnS2ucNXEfWf98EDW6MN/mQsh6umXqI+2ZLsH7cy+9ar3ldcK+EIp/wQPwY/cszy6o7sXB12eH+6fFMdDE42R4J3xviAhwZrSw6vyarw3/EdDDrznupREBOrITGy5QgFSB62ESCKGGI8GKCawoScOsLPKV4ia0YRgr8qBq2WTEgwtFupCZ2O+QE8nu2eX4Ky+Sw7Uc/uL5K4avngSgg/h6kt0pB4rsFScrpcf6yDdBeM/RPkNfrb3XyQQ7aOI6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 22:09:34.6392
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f5039b4-c55f-45f4-c0d3-08de74ba8f20
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002322.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5970


On 2/25/26 01:35, Yi Liu wrote:
> [You don't often get email from yi.l.liu@intel.com. Learn why this is 
> important at https://aka.ms/LearnAboutSenderIdentification ]
>
> On 2026/2/25 02:30, Lizhi Hou wrote:
>> domain->mm->iommu_mm can be freed by iommu_domain_free():
>>    iommu_domain_free()
>>      mmdrop()
>>        __mmdrop()
>>          mm_pasid_drop()
>> After iommu_domain_free() returns, accessing domain->mm->iommu_mm may
>> dereference a freed mm structure, leading to a crash.
>>
>> Fix this by taking a reference to the mm via mmgrab() before
>> calling iommu_domain_free(), and dropping it with mmdrop() after
>> finishing access to domain->mm->iommu_mm.
>
> need to be more accurate. The issue is that iommu_mm is freed in
> mm_pasid_drop(), so after iommu_domain_free(), the later access to
> iommu_mm is problematic.

The description mentioned this.

After iommu_domain_free() returns, accessing domain->mm->iommu_mm may
dereference a freed mm structure, leading to a crash.

>
>> Fixes: e37d5a2d60a3 ("iommu/sva: invalidate stale IOTLB entries for 
>> kernel address space")
>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
>> ---
>>   drivers/iommu/iommu-sva.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
>> index 07d64908a05f..523b8c65c86f 100644
>> --- a/drivers/iommu/iommu-sva.c
>> +++ b/drivers/iommu/iommu-sva.c
>> @@ -179,6 +179,7 @@ void iommu_sva_unbind_device(struct iommu_sva 
>> *handle)
>>               return;
>>       }
>>
>> +     mmgrab(domain->mm);
>>       iommu_detach_device_pasid(domain, dev, iommu_mm->pasid);
>>       if (--domain->users == 0) {
>>               list_del(&domain->next);
>> @@ -190,6 +191,7 @@ void iommu_sva_unbind_device(struct iommu_sva 
>> *handle)
>>               if (list_empty(&iommu_sva_mms))
>>                       iommu_sva_present = false;
>>       }
>> +     mmdrop(domain->mm);
>>
>>       mutex_unlock(&iommu_sva_lock);
>>       kfree(handle);
>
> will moving the below hunk in front of iommu_domain_free() simpler?
> Only when (--domain->users == 0), shall the code check if sva_domains
> is empty. right?

I am not sure if this can be moved in front of iommu_domain_free(). Will 
iommu_domain_free() be possible to impact sva_domains?

iommu_domain_free() calls domain->ops->free(). Could this call back free 
sva_domain?


Lizhi

>
>         if (list_empty(&iommu_mm->sva_domains)) {
>             list_del(&iommu_mm->mm_list_elm);
>             if (list_empty(&iommu_sva_mms))
>                 iommu_sva_present = false;
>         }
>
> Regards,
> Yi Liu
