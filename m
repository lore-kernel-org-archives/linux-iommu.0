Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1423823AD
	for <iommu@lists.linux.dev>; Thu, 22 Sep 2022 06:46:16 +0000 (UTC)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.55])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MY5L60YzPz14S2x;
	Thu, 22 Sep 2022 14:42:06 +0800 (CST)
Received: from [10.174.178.41] (10.174.178.41) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 14:46:13 +0800
Message-ID: <d5dcd648-ec56-fd4a-48a0-14ac7faedb10@huawei.com>
Date: Thu, 22 Sep 2022 14:46:13 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH RESEND 1/3] iommu: return early when devices in a group
 require different domain type
To: Baolu Lu <baolu.lu@linux.intel.com>, <joro@8bytes.org>, <will@kernel.org>,
	<robin.murphy@arm.com>, <iommu@lists.linux.dev>
References: <20220921132607.43820-1-yuancan@huawei.com>
 <99c17173-45af-6892-4cc7-b17bad7dc645@linux.intel.com>
From: Yuan Can <yuancan@huawei.com>
In-Reply-To: <99c17173-45af-6892-4cc7-b17bad7dc645@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.41]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500024.china.huawei.com (7.185.36.10)
X-CFilter-Loop: Reflected

在 2022/9/22 10:23, Baolu Lu 写道:
> On 9/21/22 9:26 PM, Yuan Can wrote:
>> When alloc default domain for an iommu_group in
>> probe_alloc_default_domain, the expected domain type
>> of each device in the iommu_group is checked in a loop,
>> if two devices require different types, the loop can
>> be broken since the default domain will be set to
>> iommu_def_domain_type.
>> Return 1 when this happened to break the loop in
>> __iommu_group_for_each_dev.
>
> As I commented here
>
> https://lore.kernel.org/linux-iommu/50b8489c-bd93-c8ae-cd92-af429ae762b0@linux.intel.com/ 
>
>
> Please use up the allowed number of characters per line before wrapping.
>
OK, thanks for the notice.

Best regards,

Yuan Can


