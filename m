Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA4C11C83
	for <iommu@lists.linux.dev>; Mon, 28 Aug 2023 10:39:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W5/rXUWzMEW1iTeRPSCZwj2T07Zvl5iwMFS6E4gJCQP504M0MEJ7MbnUAOUJ1tjAHmQtN456Im4JsNtM2SF0mCvLvgmJxfp7HlyzekfXrNCgvLYNVYJ4ho5sF+V0+9+snK+7PNth/Y47ntw5JklCFM7x1SmL4UNBirDXQ35AP6+CCOEtK/lfwZ2VpY60Jt63fBGE6GHu35UEIg92Z6KGxUg511jI2bPMVjZnZLgJaYCG8A+Mkynxz6CcurrAOPoQ9+xhSnrn1my4EfZbCncLoEpu1bRLo0AHQwx8nbke4vZa14ni+WN4v63LH5lG2rptPRmpPFljNZXOD4yG1rCJyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pIs8YhZ/xdzxYtraeDJEUKHaAmAJf95oY830VCW9wbU=;
 b=WA2tKgCbuctMshqijl/71Eu/boSGcNoGFXzFDroeDuqTy9lT8OL8WYQA+aux7IHDaORs/vLAwBJ4Zu6zNwFtubfOorE9cijeXKmGtemoOqqHXpEj+3d5NZIjIo+4xut0SEdqC4RNgC8sA3z5Ql5HOuaOnr7ogyonBYOLXt40tofu9gi21v6OX49Pwh10cH0bLt2FGGbIxdUDk1L+Q30SNmWUR2H4fN2w7zJacFBp9ocf02aTSuYg1JaQHMTiXZz9Ljr857JCkUjPTYhQIkLCG5FM2OE8hAi2VoI5zVgjbpscunW8EtSUeCoZlDsjAeW5t318+6SkYfk2cTQjfRX4pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pIs8YhZ/xdzxYtraeDJEUKHaAmAJf95oY830VCW9wbU=;
 b=WjEIavjGmdODO94sjSCAgaGGYgmfNHP2Guis889BPRziJuz2saoPkQ4Y3dsIyzjypKs0bSbaRK3ad570d6HrZhGnTMC6Dm43dOUYHrz1iuUzmpWCQ/Zu8sxlfhN15d1OlLBrtyYDaTqp288ekjh0f3NeOVtSCPM/ZZnqSQzmlzg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 MN0PR12MB6271.namprd12.prod.outlook.com (2603:10b6:208:3c1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 10:39:30 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::67ec:80e:c478:df8e]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::67ec:80e:c478:df8e%7]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 10:39:29 +0000
Message-ID: <fc17e0fb-e712-824f-93f9-f9edf5707395@amd.com>
Date: Mon, 28 Aug 2023 16:09:16 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH RESEND 03/10] iommu/amd: Initial SVA support for AMD IOMMU
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 wei.huang2@amd.com, jsnitsel@redhat.com
References: <20230823140415.729050-1-vasant.hegde@amd.com>
 <20230823140415.729050-4-vasant.hegde@amd.com> <ZOYXoMPBQZ5KK9IJ@ziepe.ca>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <ZOYXoMPBQZ5KK9IJ@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0238.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::8) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|MN0PR12MB6271:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bcfbf90-fc07-4437-0f0b-08dba7b30eef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	V4rqtvHb3evYXpPULvYSUVVK3sYgZd8Lyx+I0Y6ALV+QmIzy2vvLBlYCntOtVeWAoVPPfcDcDsSTgvFNqyNoM2ZL2XKGIpDlXBVMFLbOhnJmYkc3XeePAa/wYHJFRvYgEorp56R5XgU4OYoFtIZ+ZQbqt2blQSFL1NgkS/cj29q/PsHDLdzbzamkoiNCcLg2p3N6NR/FsjL/QNnzMGy2t8WHmZILMN/3nVGoUaQixZeRUt6Ywp//UoGC6x4dSfyviPNiJEOeluwb2GTI71aVhpC0QTKBzvRMh/Gl2HAWGJc3ttXTGoc4B0aNMjqdM/wsGSnCILW5CcXMJ2Ya6h5Ij41BuJYTMPBoCz6U/d3c31vahhWYKLonhSh6OYY9h/Q+fVAUtyX/6W2ooGtrqxvZaYjTvim9LinYbLZJtWpDSj7N85falv5c08YtWfaTcyR+FaM2IE8ISySnEM7fjCnT6JHuRCiW/I7HBzDDtqnqXkZrmOiFN2c0KTjgbuKnCZ3Clhe0hlznCSKVdxOvip1yXta8H3p+RZGlDS24UYas/x6j6hxEnk2Nd8xwGrW23+JoBJRLp0DC2MAKhPkvAKjhsJV2H0ApT2yFKGew7EOLhjjgJ1INnREchnJgZaC3YILWW3cRTUHDm3i0REL3aFdbvw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(366004)(39860400002)(376002)(451199024)(1800799009)(186009)(83380400001)(478600001)(966005)(26005)(31686004)(2616005)(6486002)(66899024)(53546011)(6506007)(6512007)(6666004)(31696002)(86362001)(44832011)(2906002)(316002)(38100700002)(4326008)(6916009)(8676002)(41300700001)(66476007)(8936002)(36756003)(66556008)(66946007)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RmxraGRwVkh2YmtCbUlRbVdRUEZTY1ZBQUczRlV1T084MGZnUkYvU3dJZ1RJ?=
 =?utf-8?B?Z0pUTzFhZ3ZscG5EbmMwVytMYWl4UmJtUlRqckV3eHZLMlg4NWZpeTZDdlQ1?=
 =?utf-8?B?RjFmZDJzWVNJZ3VrT1NjS2RQbHpXMDdNaG1MNE1JamVHYUFuVnFuc0l1MjR5?=
 =?utf-8?B?RUdoakdtdEdSUENaUlVqNG5FQlVoNVVwMmpNZ1gxWlFMTE9XL3R4ajM3VWlM?=
 =?utf-8?B?R3R6NTdjZUptbHFlRDRMa2VMUGxvUlN4ZDZxcWVBS3FlSUlLZTY4NDFtbGQr?=
 =?utf-8?B?SjdnbHEvYmNWV3RqTDFpYkh0M2NoWTlTakRFYktTS3hlN2djM1Q3Tmt4Wm5F?=
 =?utf-8?B?dVF1WFFRVFJEdXpES24vZng5MVNPdUk4a2pjN20vVUxPd2ZseWlMU0lmUytM?=
 =?utf-8?B?ZWs5aGloWjJ2cEw0Rk9ER1ZybCtPZGhPeTY3SFRMSEh5OFIyVFdNUTY3Y3M5?=
 =?utf-8?B?ditqaEkxSnNEOGtMWUdpek5QakJ5ckwrS1RzUW8rbEtwUGZSa1o1TERwMDY1?=
 =?utf-8?B?UFQzcnF6aDdiVkFCT3VxeWtHYWtaaXoxYlR6RWlKWUVIa1FXTUs4RUtDVUZo?=
 =?utf-8?B?YUd0dTJMcWZVZ0x0UHRaT3VxekJpeWZaT1FUb3RuZUdjNGVPYjR5R1k3bXVp?=
 =?utf-8?B?cENGdGQwUHVNay9yUFhYUWpNQUh6alhkMEpkU2toNVl5Z2gzRXhMTGRnelpq?=
 =?utf-8?B?WkEySWhqdXRiREZWd3dRV1YrWWZ3bndmU0VHaUdjT1I1TTN6aW9lVnRpbXMz?=
 =?utf-8?B?MGtRSXpweDRmMnNsTHh2aGg1S3l2S0lZM3QyS3lRYVhSd2luQnRGakUrTXE3?=
 =?utf-8?B?c05oMU5UOHhTeWJ0dFRtQTZ4YUdmVXlVUHhHeHJDbmhzZy92Yy9XbXczVjRX?=
 =?utf-8?B?TlgxMWphWFVEQTFZeGxlQk5jZFpzdHB0QSswOUxIYThHUE5LampzZ0dzbExt?=
 =?utf-8?B?Tm5sYzJoaWk1ZmFGcTU5MDlGa0VGN01idERNeDhPdGxLQytFK3RTQVRiWVdB?=
 =?utf-8?B?TE5yWmVJcTZVbkFtdTBONnJndjgyRjRxWms5SVBJNjJTTzk2TWgwZ1dINXFM?=
 =?utf-8?B?cmpiWFg4amNOUzBDVnF0ZEJueit4VDZTQ1JQamtmeGZBQmNzdnpWbU1VeGRT?=
 =?utf-8?B?SEpTcEhzRTZjZlROOG5hZGhSZGxveEhlUkM0bTk4Y2ZnUnFxbU1RY2V3Y1g2?=
 =?utf-8?B?MG95ZFhDRCtuWnRRL0Z2QjZwRG9WbkszR0lJeG1ZdFJXbEQ0WjJndUFWSG03?=
 =?utf-8?B?UG53MkI3cWR3Tmp5ZExsVUxSSVFkTlUrVi9iNFJJaFFrSUlrdXhnYW1IR0Z6?=
 =?utf-8?B?cHRVZ0hjS09SZk1ibnpOb3pjY2MwYkVWVmtQbnlGbndleW11N1BucmtvM1FQ?=
 =?utf-8?B?SUNrTW9pS2l6cDRiRS9BMkdNczRSK1V0Z2FvVThKcHpYKytaaVJEem9HelUv?=
 =?utf-8?B?Z2MzV0dzTHlCK0NtZkx0ZzNDVXJCdEhyNy9MYUVRT3o3ai8vVkR6L0pROGVX?=
 =?utf-8?B?d1FHRWNjbklGWlc1VU9WblEzeXhndWhlLzJyR1REVHJUOGxZQmFVbURWd0tO?=
 =?utf-8?B?YlFnZGZyYWRUSU9RQTNYS2IvRXBsZ0Nqd3doL0Q4YjlVeW8rOFZuVTZmb0F3?=
 =?utf-8?B?eTBSNjZHam5sNTFJeThXSWtDZmFONk02V1NMZ2VRenhNME5lK3lxWHk4V1lP?=
 =?utf-8?B?WjJ1VG5HeDZCVHIzNmo3bDd5aFl0ZTFFc0thQ244am9FaHB5TlpIcURPWDBF?=
 =?utf-8?B?bndMY254RjdvV05nL2tKWkN3MFdzamJpMWZjT2JLbkdoVmtyY0RGVEdRL01k?=
 =?utf-8?B?MUczSzdDUCt6eU16Y2NpZS9nd0tldWNmeGpxcnA2RVFTRzN3emY4NW5pMGY5?=
 =?utf-8?B?RFM3cUswQlZTVEFRTFhPRGNKa0k3aXU4Nk1ybUhvTFFybkhlQ3NvVEx2Qkc2?=
 =?utf-8?B?cjZ4am1BOXlqVWw3aVl1bHp0ZS9KZG8yaU5QNGQ5eE14Y040SEhLeC96aVNj?=
 =?utf-8?B?aE9WZ05jOENyYzlBa01RUkRzNkNUWDliTzl0UVdwcWk5ZjByMURSZzBlTUZD?=
 =?utf-8?B?a3E0TXcvRDh6dzViMVFSRGZSalVkeUIzS3liOWtnN3FuL3NYWnIxZVplMm5S?=
 =?utf-8?Q?Gy6CeD6lT3bC7BFFV92Z2K/jQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bcfbf90-fc07-4437-0f0b-08dba7b30eef
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 10:39:29.8244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RLbQC10K6rxMRB+It0qNDb31ClFuCN2bnOd0BBm6yfREpQuriVTRB43AOeUvEU1jfcePRrjwDZFEo6ON61E7iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6271

Jason,


On 8/23/2023 7:58 PM, Jason Gunthorpe wrote:
> On Wed, Aug 23, 2023 at 02:04:08PM +0000, Vasant Hegde wrote:
>> diff --git a/drivers/iommu/amd/sva.c b/drivers/iommu/amd/sva.c
>> new file mode 100644
>> index 000000000000..c7c7e7cb5414
>> --- /dev/null
>> +++ b/drivers/iommu/amd/sva.c
>> @@ -0,0 +1,299 @@
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
>> +#include "../iommu-sva.h"
>> +
>> +struct amd_sva_pasid {
>> +	u32			pasid;	/* PASID index */
>> +	struct mm_struct	*mm;	/* mm_struct for the faults */
>> +	struct mmu_notifier	mn;	/* mmu_notifier handle */
>> +	struct list_head	dev_list; /* List of devices for this pasid */
>> +};
>> +
>> +struct amd_sva_dev {
>> +	struct device		*dev;
>> +	struct iommu_dev_data	*dev_data;
>> +	struct list_head	list;
>> +	struct rcu_head		rcu;
>> +};
>> +
>> +static DEFINE_MUTEX(pasid_mutex);
>> +static DEFINE_XARRAY_ALLOC(sva_pasid_array);
>> +
>> +
>> +static int sva_pasid_private_add(u32 pasid, void *priv)
>> +{
>> +	return xa_alloc(&sva_pasid_array, &pasid, priv,
>> +			XA_LIMIT(pasid, pasid), GFP_ATOMIC);
>> +}
>> +
>> +static void sva_pasid_private_remove(u32 pasid)
>> +{
>> +	xa_erase(&sva_pasid_array, pasid);
>> +}
>> +
>> +static void *sva_pasid_private_find(u32 pasid)
>> +{
>> +	return xa_load(&sva_pasid_array, pasid);
>> +}
> 
> No PASID stuff in SVA code at all please, all of this is wrong.

This is based on upstream code!

> 
> The only PASID comes from here, and it should be the only place PASID
> shows up:
> 
>  +int amd_iommu_set_dev_pasid(struct iommu_domain *domain,
>  +			    struct device *dev, ioasid_t pasid)
>  +{
> 
>> +static int sva_bind_mm(struct device *dev, struct mm_struct *mm)
>> +{
>> +	struct amd_sva_pasid *sva_pasid;
>> +	struct amd_sva_dev *sva_dev;
>> +	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
>> +	int ret = -EINVAL;
>> +
>> +	sva_dev = sva_dev_alloc(dev);
>> +	if (!sva_dev)
>> +		return ret;
>> +
>> +	sva_pasid = sva_pasid_private_find(mm->pasid);
>> +	if (!sva_pasid) {
>> +		sva_pasid = sva_pasid_alloc(mm);
>> +		if (!sva_pasid)
>> +			goto out_sva_dev;
> 
> No per-PASID struct. AMD enablement should go after this series:
> 
>  https://lore.kernel.org/linux-iommu/20230808074944.7825-1-tina.zhang@intel.com/
> 
> Put the mmu_notifier directly into the protection_domain. Assume you
> have a single protection_domain per mm.

Actually we have protection domain for each IOMMU group (or multiple group in
case of VM). Our invalidation needs device protection domain ID (not the SVA
domain ID which is created during device/PASID binding).

Invalidation takes three parameter :
  Device Domain ID, PASID, Address

> 
> Also amd_sva_dev is not appropriate, the list of PASIDs (and masters)
> a domain is associated with is part of the generic PASID support in
> the protection_domain itself.

You mean to say, we maintain PASID list in device protection_domain and then in
invalidation path (somehow) we retrieve protection domain and use it for
invalidation? -OR- someway establish link between SVA domain to base device
protection domain?


> 
> These details would be clearer if you start from enabling PASID
> support for an UNMANAGED domain.

We don't support PASID with V1 page table.

> 
> SVA should be a tiny incremental from that which simply calls the
> same invalidation and manages the mmu notifier.

Yeah. If we can get a way to retrieve device protection domain ID (not SVA
protection domain) in notifier path then it makes life easy. But currently I
don't see a way to do that.


> 
>> +static struct amd_sva_dev *sva_dev_alloc(struct device *dev)
>> +{
>> +	struct amd_sva_dev *sva_dev;
>> +	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
>> +
>> +	sva_dev = kzalloc(sizeof(*sva_dev), GFP_KERNEL);
>> +	if (!sva_dev)
>> +		return NULL;
>> +
>> +	sva_dev->dev = dev;
>> +	sva_dev->dev_data = dev_data;
>> +	init_rcu_head(&sva_dev->rcu);
>> +
>> +	return sva_dev;
>> +}
>> +
>> +static inline void sva_dev_free(struct amd_sva_dev *sva_dev)
>> +{
>> +	kfree_rcu(sva_dev, rcu);
>> +}
>> +
>> +static void sva_mn_invalidate_range(struct mmu_notifier *mn,
>> +				    struct mm_struct *mm,
>> +				    unsigned long start, unsigned long end)
>> +{
>> +	struct amd_sva_pasid *sva_pasid;
>> +	struct amd_sva_dev *sva_dev;
>> +
>> +	rcu_read_lock();
>> +
>> +	sva_pasid = container_of(mn, struct amd_sva_pasid, mn);
>> +	if (!sva_pasid) {
>> +		rcu_read_unlock();
>> +		return;
>> +	}
>> +
>> +	list_for_each_entry_rcu(sva_dev, &sva_pasid->dev_list, list) {
>> +		if ((start ^ (end - 1)) < PAGE_SIZE)
>> +			amd_iommu_flush_page(sva_dev->dev_data->domain, sva_pasid->pasid, start);
>> +		else
>> +			amd_iommu_flush_tlb(sva_dev->dev_data->domain, sva_pasid->pasid);
>> +	}
> 
> SVA invalidation should be the same as normal PASID invalidation. You

Its same (Currently we have two different functions based on PAGE_SIZE. We have
a separate series to improve our invalidation logic).

> need to track the list of PASIDs a protection_domain is associated
> with in the protection domain itself, not in special SVA code. Don't
> repeat the SMMU mistakes please.
> 
> Use container_of(mn) to get back to the SVA protection domain and then
> you can access the protection domains list of PASIDs & masters.

I don't think I understood this. Even with Tina's patch series, we can get the
SVA domain list. But we don't have a way to get device base protection domain.

> 
>> +static int sva_bind_mm(struct device *dev, struct mm_struct *mm)
>> +{
>> +	struct amd_sva_pasid *sva_pasid;
>> +	struct amd_sva_dev *sva_dev;
>> +	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
>> +	int ret = -EINVAL;
>> +
>> +	sva_dev = sva_dev_alloc(dev);
>> +	if (!sva_dev)
>> +		return ret;
>> +
>> +	sva_pasid = sva_pasid_private_find(mm->pasid);
>> +	if (!sva_pasid) {
>> +		sva_pasid = sva_pasid_alloc(mm);
>> +		if (!sva_pasid)
>> +			goto out_sva_dev;
>> +
>> +		ret = sva_pasid_private_add(sva_pasid->pasid, sva_pasid);
>> +		if (ret)
>> +			goto out_sva_pasid;
>> +
>> +		ret = amd_iommu_set_gcr3(dev_data, sva_pasid->pasid,
>> +					 iommu_virt_to_phys(sva_pasid->mm->pgd));
>> +		if (ret)
>> +			goto out_pasid_remove;
>> +
>> +		ret = mmu_notifier_register(&sva_pasid->mn, mm);
>> +		if (ret)
>> +			goto out_clear_gcr3;
>> +	}
> 
> The mmu_notifier should be setup when the domain is allocated, not
> during bind.

We need to program (at least with AMD IOMMU) device PASID table before it can
handle the invalidation notifications. Not sure how it will work if we move mmu
notifier setup to domain allocation path.


> 
> This is an issue we need to fix in the core code :(
> 
>> +void amd_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
>> +{
>> +	struct iommu_domain *domain;
>> +
>> +	if (pasid == 0 || pasid >= dev->iommu->max_pasids)
>> +		return;
> 
> We should probably have the core code pass in the old domain to this
> function, it is looking more like a mistake we didn't do that.

I don't think I understood this. Well, honestly I never understood why
remove_dev_pasid() is part of iommu_ops while set_dev_pasid is part of domain ops.

My understanding is in this path we necessary things like in AMD case updating
device table entry and finally remove mmu notifier.


-Vasant

> 
>> +
>> +	/* Get SVA domain */
>> +	domain = iommu_get_domain_for_dev_pasid(dev, pasid, 0);
>> +	if (!domain)
>> +		return;
>> +
>> +	switch (domain->type) {
>> +	case IOMMU_DOMAIN_SVA:
>> +		/* Ensure that all queued faults have been processed */
>> +		iopf_queue_flush_dev(dev);
>> +
>> +		mutex_lock(&pasid_mutex);
>> +		sva_unbind_mm(dev, pasid);
>> +		mutex_unlock(&pasid_mutex);
> 
> SVA should not be special for detach, this should all be generic code.
> 
> The mmu notifier is freed during SVA domain dealloc.
> 
> Jason
