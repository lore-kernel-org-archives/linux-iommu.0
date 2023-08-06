Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5407310EA
	for <iommu@lists.linux.dev>; Sun,  6 Aug 2023 05:28:15 +0000 (UTC)
Received: from canpemm500006.china.huawei.com (unknown [172.30.72.56])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RJScd716vz1K97H;
	Sun,  6 Aug 2023 13:26:57 +0800 (CST)
Received: from [10.67.145.224] (10.67.145.224) by
 canpemm500006.china.huawei.com (7.192.105.130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 6 Aug 2023 13:28:04 +0800
Subject: Re: [PATCH v2 1/1] iommu/arm-smmu-v3: Fix error case of range command
To: Nicolin Chen <nicolinc@nvidia.com>, Will Deacon <will@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Robin Murphy <robin.murphy@arm.com>, Joerg
 Roedel <joro@8bytes.org>, Lu Baolu <baolu.lu@linux.intel.com>, Jason
 Gunthorpe <jgg@ziepe.ca>, Yicong Yang <yangyicong@hisilicon.com>, Tomas Krcka
	<krckatom@amazon.de>, Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <1690784482-30028-1-git-send-email-wangwudi@hisilicon.com>
 <20230801085504.GA26130@willie-the-truck>
 <27c895b8-1fb0-be88-8bc3-878d754684c8@huawei.com>
 <d5fc1f72-7428-4fef-d868-d06b85add635@huawei.com>
 <20230804165225.GF30679@willie-the-truck> <ZM1DqxXcBT2SOs8/@Asurada-Nvidia>
From: zhurui <zhurui3@huawei.com>
Message-ID: <015b4573-9d74-451b-8028-a1050ade7019@huawei.com>
Date: Sun, 6 Aug 2023 13:28:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <ZM1DqxXcBT2SOs8/@Asurada-Nvidia>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.145.224]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500006.china.huawei.com (7.192.105.130)
X-CFilter-Loop: Reflected

On 2023/8/5 2:30, Nicolin Chen wrote:
> On Fri, Aug 04, 2023 at 05:52:25PM +0100, Will Deacon wrote:
>> On Fri, Aug 04, 2023 at 05:31:20PM +0800, zhurui wrote:
>>> When tg != 0 but ttl, scale, num all 0 in a range tlbi command, it
>>> is reserved and will cause the CERROR_ILL error. This case means
>>> that the size to be invalidated is only one page size, and the
>>> range invalidation is meaningless here. So we set tg to 0 in this
>>> case to do an non-range invalidation instead.
> 
>>> @@ -1930,6 +1927,12 @@ static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
>>>                         num = (num_pages >> scale) & CMDQ_TLBI_RANGE_NUM_MAX;
>>>                         cmd->tlbi.num = num - 1;
>>>
>>> +                       /* Prevent error caused by one page tlbi with leaf 0 */
>>> +                       if (scale == 0 && num == 1 && cmd->tlbi.leaf == 0)
>>> +                               cmd->tlbi.tg = 0;
>>
>> This should only be true for the last iteration, right (i.e. when num_pages
>> == 1)? In which case, I'd prefer to leave the old code as-is and just add:
>>
>>         /* Single-page leaf invalidation requires a TG field of 0 */
>>         if (num_pages == 1 && !cmd->tlbi.leaf)
>>                 cmd->tlbi.tg = 0;To Will and Nicolin,

Not only the last iteration, it's the result of __ffs function. For example, if
numpages is 33, then the value of __ffs(num_pages) is 0, so the value of scale
is also 0. The value of num depends on CMDQ_TLBI_RANGE_NUM_MAX. That is, the
maximum value of num is 31. Therefore, the final value of num is 1.
So, if consider CMDQ_TLBI_RANGE_NUM_MAX, there will be some case not the last
one page but the beginning pages. That's why I use scale and num as conditions,
not num_pages. Then I should reassign tg based on the result.

> 
> Is "!cmd->tlbi.leaf" to be "leaf" or "non-leaf"?
> 
> IIUIC, this "num_pages == 1" implies "NUM == 0, SCALE == 0" while
> the "!cmd->tlbi.leaf" implies "TTL = 0b00", which in combination
> would result in a CERROR_ILL mentioned by the spec?
> 
> I feel this could be more clear by just checking the three fields
> following the spec...>
> Thanks
> Nicolin
> .
> 
Yes, based on spec 4.4.1.1 for ARM IHI 0070, after the TLL and TG table, there is a
description for TG != 0b00, and you can check it in the last point.

Thanks.
ZhuRui
.
