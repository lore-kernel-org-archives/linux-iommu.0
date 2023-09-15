Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76CCD515
	for <iommu@lists.linux.dev>; Fri, 15 Sep 2023 08:50:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hYDr/R2T5sTTJxPOWDisozvhSLqFR6VxcmCk7sLAU+4L4I6qjX+z3BLn7b5lmxE3cR4OBWX8nhvqByAFuhsrwT2ta/RLQ2JpOCkY7GvuZtR94SBVzWmeGOLPyCrR0GfJMgEXwV4SQc3vrq8s5id9en+dQtD5Ab0wjesk4u/k4Kiqo57veWfMWiTO3RusDj6vX6BW0zn2m2unnJLTmECQgKrrPB7fmYpowsePzq1sU/0ygtRRlDSg+Q+h/TgCdLBUiylvP68TQT3dvq4WZHCc7w8do01AquGP4T41efsj8+OKz2DhEstSZypzmnNwEXiIpwlOwTzcFgGf5zsjT2C5PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/na7vt0SiJO7N1TIljELPr3oyEJHH3xaYHSzT9Ay5po=;
 b=ErM7GNThox2Xv2g/+mAUkZBiAujTdJZ53lFylRfCPR/tV6PBxPP/05B1Pc92sSdiWod3k/e7n3p6Sv6ByZGtE0YpyS79EDg/5399npdjmLwpbEbQ65AVJ3ItX8WNVGex7pNJgSNVv19TyCbVmiKOUlPRMoUT+ae+bUKneHcby8GWGvbLWCGveh0lFaIe/vc8FOGkzTOlWBZnbTDe7eAlJTqwRT+aUx0t+yZNKFag5z3FOpnWXuE8MCHdCNAg+cjWuApALhZ3AxZOtJsQXpWGK1zvvXnbixQdXKWD8LWdHmZIK5A8XUIwRKhMaEerKLqkNYGd+zIKlLo3NkCeZn7AOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/na7vt0SiJO7N1TIljELPr3oyEJHH3xaYHSzT9Ay5po=;
 b=VPAUSN2V9sSrJkgbDBLYChR/Z4cLlT3QYa1KFV3ZzorcNJPWM501iAdTnRy+JHFGTQampNAiL3e8llGXHCs8Jyfi0cGDGFu3kvoWDcP9f1F2Kp/tw1iBvUl+ZUXcjANJE9hDP2wUnfth2XqETYFzMfVUL/HFw+APxcgoT5nbQrg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 CH0PR12MB5219.namprd12.prod.outlook.com (2603:10b6:610:d2::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.21; Fri, 15 Sep 2023 08:50:46 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::cb74:f20e:dd21:d763]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::cb74:f20e:dd21:d763%6]) with mapi id 15.20.6768.029; Fri, 15 Sep 2023
 08:50:45 +0000
Message-ID: <2d863928-6ffa-4bf7-d4d6-689d779ad701@amd.com>
Date: Fri, 15 Sep 2023 14:20:32 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 04/11] iommu/amd: Initial SVA support for AMD IOMMU
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 wei.huang2@amd.com, jsnitsel@redhat.com
References: <20230911121046.1025732-1-vasant.hegde@amd.com>
 <20230911121046.1025732-5-vasant.hegde@amd.com> <ZQCWMFFgbbcBN+0n@ziepe.ca>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <ZQCWMFFgbbcBN+0n@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0067.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::12) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|CH0PR12MB5219:EE_
X-MS-Office365-Filtering-Correlation-Id: 50c6ce3d-cb13-4343-ce90-08dbb5c8d9a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6AsQZ/18YeBdRZY4QQWoUtV5pwvqmY0FknaFLLwUhlAW6QgvwXRa8wF3n+2jjCJvFZCCp6NUM8IcPvcKIpD/pR9x4Maf/xi8pboIwksYuRqW7RihSJmJGxunZ+0i7aFAFupqdsQ+DVpuycJEqxO87ms8iJxAeBWLEH3qoF6LL+UKScmIO2NwhNL20YZPy5dO2pQm9/5UIU11US7fki+lmbdSpjXbezeALeY+Z67BmOoM2AMZaGXA8MPWCF8yEg8qCFoAl1gMe2fP+x/GQWb8PeIm215B5Gjgj71yL/j8sTNFbcbvLVGobr+4cfmJSNoxUIllYCxtoEorfihGzHAhF486DretP0le6lwNKlGDGcuyxJgvmHWOQQFiSyW11Grjd9SdZFDs2v1+gQLS27gsouarTQypa4s9v99g3sifK7emudnzLctZy8oXotCI72h1/zStCp1LqaCnEyenhdpTwhTF8DsFjyYde0o0TDHmf5FPPm4wHpqxupMyJbI49OeSiuz9SginicBNIJ6/dSPHzfF+SpCAAovYLIkXSYa3GBPyfHOMwHNEqjt+d/87qeC/7Z1xGDsfl6cpKxW+8NYlAp8c9k//jkRgLE1Eu6ZEbA73VVJMNDZXTFvELP32MQBL/6Paor6Y90j3YPCxskPh0g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(376002)(366004)(39860400002)(186009)(1800799009)(451199024)(5660300002)(26005)(8936002)(4326008)(8676002)(2616005)(2906002)(86362001)(31696002)(38100700002)(83380400001)(36756003)(44832011)(6486002)(6506007)(6666004)(66946007)(66476007)(66556008)(53546011)(478600001)(31686004)(41300700001)(316002)(6916009)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RnNyQzROQTdYQm5lT2dGbmlmOGFPaFdWRU9PREQyeDN0bDBrSFVaakhEeU5N?=
 =?utf-8?B?aXozOTlraW8zcC9DMElmUzBTbmV5bVlEVERaZ1h3L1RJTFBYTktvVDVRQjZ6?=
 =?utf-8?B?aURQME9LMGF2TWVReS96a0lmSEhXUDhmenZhK2QrUHRyTjRFM2tpUjk1cmRv?=
 =?utf-8?B?ODFJV2tyc2M0VlduQkY3UEswenY2VDhubUpVYVhKQi9uazN3d1lDY0l2eHlR?=
 =?utf-8?B?bUJhTlZnY3VkRjJ5YithSkVsL0k1OGQvUnJTQU5HK253VktEMTVVSDNHS0Z3?=
 =?utf-8?B?OUNyeXRDckJNMUN5RS9FQUhnYnM1NHBCY0Y3M0Vtc29QejlQYUY3aDhucmRr?=
 =?utf-8?B?UnhPNEp6UzJVZ2FMejJ6M2NSNmVLTE5QNGF5amIzNU9KaXJsanVlYmpCQUp3?=
 =?utf-8?B?dGRQTFErNitxR2o3TERqbDVIRXNacEdWc214WnhVak5YSEZOT1YzMHRwd0Mz?=
 =?utf-8?B?alQ0VHBjM0Q0NVVZenFFR014TlRyamtRd3FZa280ZFRQRS9xUTBiTGhzZ3Er?=
 =?utf-8?B?TVQvVndGaVg0dzdFay8xbUxhUm93d0NyMXpTSmsvc1NTczY3NjRKRkQxc2F0?=
 =?utf-8?B?ZFVhWFEyZTlVbUZrNzhoWHEza3NvVXVTeDdNY1JRRmFibmlXZjB5Q2FFY1BJ?=
 =?utf-8?B?b3hRUXR1b2VFUm5icUFtbzhuRGxpNTVwQXVSZC9ycm5EM0l0QW5kT2libW05?=
 =?utf-8?B?Q0Nzamx0b1poMjdXT0U3NC9teEZrQkNPVDE4WFN0TFdiaU4zMzBteGU0a1V1?=
 =?utf-8?B?bzMyY1R2SkJ3VWVlMkh3QzdFSHEzSmw0akxZOEpqT2RXd1FnODV1NjYrMTky?=
 =?utf-8?B?ajQ3OWhMd3pGNFNMKzBCYXVFMXh0RUFRV1owanB4ZTY5LytOdTZLMDZEK2N3?=
 =?utf-8?B?S2ZxQUVDOVEyL3NOKzBJRTIxMDllakFkREVDbExUTkdBcmdtT2lYWXZxNzBH?=
 =?utf-8?B?ajA2Vi9Hdk11R2NrV1BTT1hNUjVzQVpTNk1BaHFrdTd2NGttYVhibXJnR3k4?=
 =?utf-8?B?ZVhuakhmeHN2OUNVaDR0bnp3cWplVHdhc0RGVjFvc3NtNHYrNkNXa3RTa2pj?=
 =?utf-8?B?U1ZWNFZ0dW1oVDRIUWdNU0xaa1lqR0Q5T0szcEhzVFd4VTcxcnNXWHZ4SFVI?=
 =?utf-8?B?Wkp3YTQ5Y0R3Vk5pQ1RnY3lmaWFJQTdtUG9Md3d3dkVOUHNzbU9uckw2aUVi?=
 =?utf-8?B?eFNuTTIxNzBFbkZKYy9QVkk5WTI3ZWROcytIS1BBd1BaTkk1b0puUE9Cd3ZX?=
 =?utf-8?B?b09hNUZmOUs0M3JCMXk5d2w1bDBscUNIWnI2UTBkRlN2TjhpK1VVTW0yOUEz?=
 =?utf-8?B?czU1NUZoSm1rSmNLMjdUc0VmNEhwT0xuUzBoVmJ6NDNUc3I3Q0RwbnIxWkQz?=
 =?utf-8?B?SndnNjJGQVRHTENZbXZ6VXo1YVM1aHZqNzVqS3dmMTVKbE56N2J4cjJmSHNO?=
 =?utf-8?B?T3NXMVJ1Snd1L3Y0aVh2aEtQQ3lPOUJzLytoc1V5YmllV1F1U281MDVSeTdk?=
 =?utf-8?B?QWlrRzErSUkyaFpPMzM0Z2hkaHBhTWZCcGNJdjNMekdtRVp1eHRKV0xHdmZV?=
 =?utf-8?B?Ry95MjZWN1JSb2Y0N20xZ2kxT0g1T2hoalVBa2QxdVlNR2hzVk84ekVqblRz?=
 =?utf-8?B?MTgyODRubVNKcU1QTmt3MG1jYWxrZWJKQmJkR2FHdGxETjRDdURtbmc0SHZQ?=
 =?utf-8?B?SUc1VVc0ZnV5L1grZVpjaGgwcUJDdkNrZTJJS1FDYkVmaG9QeGZKcmI0Z2xX?=
 =?utf-8?B?Mm5LdnBhV3ovbm9zYlFTcVVBY1RrNFhYZkNZNUVqY3poR3dqVE8wV05wMm9z?=
 =?utf-8?B?T2t6dm5LQ1hndXNpcjVDeGY5UHJidHVZMlVhVUZyUFo1bmhhT1JyYVdRV1Y0?=
 =?utf-8?B?Q3ozYldHTm5Ic0VBa2xNek9JUUxlVDRwWC9NcjdONnhTcmlRVVlnbkMreVEv?=
 =?utf-8?B?d0FyUXNOZzB3RE5IK1lHWXBSU3FQdy9qaVl6UVZEd0RLMDlwem1pVERaeUpB?=
 =?utf-8?B?R2VKelREZ0lFdFVST29GSzYyV01FTVpobDNqSisyRzYrdWlKakcvaU1tTUJx?=
 =?utf-8?B?Qm5pMUxud3VQdnBHbGNQMkRTL01mRGJFdzdqSE9LYjhsYXdXQmZSSlVPbTha?=
 =?utf-8?Q?Kmm1OIW6wMUyRx0+cC+R4gFsR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50c6ce3d-cb13-4343-ce90-08dbb5c8d9a3
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 08:50:45.6101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lkzqo15/e4ycxMftVcPNYm6VJ9htus7eLgcu5BZYiRhu6Rr4wDghp2lKnFN7BTuUZybBKdPTJ+caNV/E+6Dn+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5219

Jason,

On 9/12/2023 10:17 PM, Jason Gunthorpe wrote:
> On Mon, Sep 11, 2023 at 12:10:39PM +0000, Vasant Hegde wrote:
> 
>> +static inline struct protection_domain *amd_iommu_get_pdomain(struct device *dev)
>> +{
>> +	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
>> +
>> +	if (!dev_data || !dev_data->domain)
>> +		return NULL;
>> +
>> +	return dev_data->domain;
>> +}
> 
> Not used in this patch

Yeah. Forgot to move to different patch after reworking SVA code. Will fix it.

> 
>> @@ -2192,6 +2188,11 @@ static int protection_domain_init_v2(struct protection_domain *pdom)
>>  	return 0;
>>  }
>>  
>> +static const struct iommu_domain_ops amd_svm_domain_ops = {
>> +	.set_dev_pasid = amd_iommu_set_dev_pasid,
>> +	.free	       = amd_iommu_domain_free
>> +};
> 
> "amd_sva_domain_ops" please

Fixed.

> 
>> new file mode 100644
>> index 000000000000..d18dc3f676b9
>> --- /dev/null
>> +++ b/drivers/iommu/amd/sva.c
>> @@ -0,0 +1,158 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (C) 2023 Advanced Micro Devices, Inc.
>> + */
>> +
>> +#define pr_fmt(fmt)     "AMD-Vi: " fmt
>> +#define dev_fmt(fmt)    pr_fmt(fmt)
>> +
>> +#include <linux/iommu.h>
>> +#include <linux/mm_types.h>
>> +#include <linux/mmu_notifier.h>
>> +
>> +#include "amd_iommu.h"
>> +
>> +static void sva_mn_invalidate_range(struct mmu_notifier *mn,
>> +				    struct mm_struct *mm,
>> +				    unsigned long start, unsigned long end)
>> +{
>> +	struct protection_domain *sva_pdom;
>> +	struct pdom_pasid_data *pasid_data;
>> +	struct iommu_dev_data *dev_data;
>> +
>> +	sva_pdom = container_of(mn, struct protection_domain, mn);
>> +
>> +	list_for_each_entry(pasid_data, &sva_pdom->pasid_list, pdom_link) {
> 
> Need to hold sva_pdom->lock if iterating over pasid_list
> 
>> +		dev_data = pasid_data->dev_data;
>> +
>> +		if ((start ^ (end - 1)) < PAGE_SIZE) {
>> +			amd_iommu_flush_page(dev_data->domain,
>> +					     pasid_data->pasid, start);
>> +		} else {
>> +			amd_iommu_flush_tlb(dev_data->domain,
>> +					    pasid_data->pasid);
>> +		}
> 
> It is baffling why dev_data->domain would be used here, and it isn't
> locked properly so this is a problem.
> 
> Looking into __flush_pasid it doesn't really make sense. The PASID
> domain definately can't assume that the RID domain has the the same
> set of iommus. Most likely the SVA domain has a wider set of iommus,
> at least I didn't notice any logic preventing this in set_dev_pasid.

Right. SVA protection domain will just add dev/PASID combination without
worrying device protection domain/iommu.

In invalidation path, I walk the `pasid_list` from SVA protection domain, get
dev_data/PASID info and use those for invaliation. Since invalidation needs
device protection domain I have to refer dev_data->domain.

> 
> Also, didn't you say you wanted to de-duplicate the IOTLB and ATC
> invalidations like ARM is doing?

I don't have the understanding of ARM. But our invalidation interfaces needs
improvement. Like current code does unncessary complete_wait() calls. Those will
be fixed along with other invalidation cleanup.

> 
>> +static const struct mmu_notifier_ops sva_mn = {
>> +	.invalidate_range = sva_mn_invalidate_range,
>> +	.release = sva_mn_release,
>> +};
> 
> Why an empty release function?
> 
> That can't be right, when release is called the driver has to stop
> using iommu_virt_to_phys(domain->mm->pgd)) because it will be freed
> memory. It should replace it with a global empty pgd and flush caches
> before release returns.

In remove_dev_pasid() its already removed PASID from GCR3 table, flushing IOMMU.
Also if its last device unbind, then it also does mmu_notifier_unregister().

I thought remove_dev_pasid() always gets called before mmu notifier releases.
Is there any chance of mmu notifier relase() getting called before
remove_dev_pasid().

> 
>> +int amd_iommu_set_dev_pasid(struct iommu_domain *domain,
>> +			    struct device *dev, ioasid_t pasid)
>> +{
>> +	struct protection_domain *sva_pdom = to_pdomain(domain);
> 
> Just call this pdom, there is nothing about this function that is sva
> specific anymore.

Ok.

> 
>> +	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
>> +	struct pdom_pasid_data *pasid_data;
>> +	int ret = -EINVAL;
>> +	unsigned long flags;
>> +
>> +	/* PASID zero is used for requests from the I/O device without PASID */
>> +	if (pasid == 0 || pasid >= dev->iommu->max_pasids)
>> +		return ret;
>> +
>> +	/* Use SVA protection domain lock */
>> +	spin_lock_irqsave(&sva_pdom->lock, flags);
>> +
>> +	/* Add PASID to protection domain pasid list */
>> +	pasid_data = kzalloc(sizeof(*pasid_data), GFP_KERNEL);
>> +	if (pasid_data == NULL) {
>> +		ret = -ENOMEM;
>> +		goto out;
>> +	}
>> +
>> +	pasid_data->pasid = pasid;
>> +	pasid_data->dev_data = dev_data;
>> +
>> +	/* Setup GCR3 table */
>> +	ret = amd_iommu_set_gcr3(dev_data, pasid,
>> +				 iommu_virt_to_phys(domain->mm->pgd));
>> +	if (ret)
>> +		goto out_free_pasid_data;
>> +
>> +	if (list_empty(&sva_pdom->pasid_list)) {
>> +		sva_pdom->mn.ops = &sva_mn;
>> +
>> +		ret = mmu_notifier_register(&sva_pdom->mn, domain->mm);
>> +		if (ret)
>> +			goto out_clear_gcr3;
>> +	}
> 
> Looks to me like mmu_notifier_register() should be done before
> amd_iommu_set_gcr3() so we don't have a risk of stale iotlb data.

Actually we need to update GCR3 table with PASID before registering mmu
notifier. So that hardware is ready to handle the invalidations. Otherwise we
will have a redudant invalidations.


> 
>> +
>> +	list_add(&pasid_data->pdom_link, &sva_pdom->pasid_list);
>> +	spin_unlock_irqrestore(&sva_pdom->lock, flags);
>> +	return ret;
>> +
>> +out_clear_gcr3:
>> +	amd_iommu_clear_gcr3(dev_data, pasid);
>> +
>> +out_free_pasid_data:
>> +	kfree(pasid_data);
>> +
>> +out:
>> +	spin_unlock_irqrestore(&sva_pdom->lock, flags);
>> +	return ret;
>> +}
> 
> But this looks fine, it is entirely generic.
> 
>> +static struct pdom_pasid_data *get_pdom_pasid_data(struct protection_domain *pdom,
>> +						   struct device *dev, ioasid_t pasid)
>> +{
>> +	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
>> +	struct pdom_pasid_data *pasid_data;
>> +
>> +	list_for_each_entry(pasid_data, &pdom->pasid_list, pdom_link)
>> {
> 
> Add a lockdep assert for pdom->lock here

Ok.

> 
>> +		if (pasid_data->pasid == pasid &&
>> +		    pasid_data->dev_data == dev_data)
>> +			return pasid_data;
>> +	}
>> +
>> +	return NULL;
>> +}
>> +
>> +void amd_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
>> +{
>> +	struct pdom_pasid_data *pasid_data;
>> +	struct protection_domain *sva_pdom;
>> +	struct iommu_domain *domain;
>> +	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
>> +	unsigned long flags;
>> +
>> +	if (pasid == 0 || pasid >= dev->iommu->max_pasids)
>> +		return;
>> +
>> +	/* Get protection domain */
>> +	domain = iommu_get_domain_for_dev_pasid(dev, pasid, IOMMU_DOMAIN_SVA);
>> +	if (!domain)
>> +		return;
>> +	sva_pdom = to_pdomain(domain);
>> +
>> +	/* Ensure that all queued faults have been processed */
>> +	iopf_queue_flush_dev(dev);
>> +
>> +	spin_lock_irqsave(&sva_pdom->lock, flags);
>> +
>> +	pasid_data = get_pdom_pasid_data(sva_pdom, dev, pasid);
>> +	if (!pasid_data) {
>> +		spin_unlock_irqrestore(&sva_pdom->lock, flags);
>> +		return;
>> +	}
>> +
>> +	list_del(&pasid_data->pdom_link);
>> +	kfree(pasid_data);
>> +
>> +	/* make it visible */
>> +	smp_wmb();
>> +
>> +	/* Update GCR3 table and flush IOTLB */
>> +	amd_iommu_clear_gcr3(dev_data, pasid);
>> +
>> +	spin_unlock_irqrestore(&sva_pdom->lock, flags);
>> +
>> +	if (list_empty(&sva_pdom->pasid_list))
>> +		mmu_notifier_unregister(&sva_pdom->mn, domain->mm);
> 
> Can't drop the spinlock before doing this, it is racy.

Yeah. Its racy. But we cannot call mmu_notifier_unregister() with spinlock held.
May be I will introduce some lock to handle notifier.

-Vasant

