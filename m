Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCFD579CD
	for <iommu@lists.linux.dev>; Tue, 31 Jan 2023 14:15:18 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 21EDA2F4;
	Tue, 31 Jan 2023 06:16:00 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 99C563F71E;
	Tue, 31 Jan 2023 06:15:16 -0800 (PST)
Message-ID: <0e9f677b-846d-809d-9bc3-30906f703fda@arm.com>
Date: Tue, 31 Jan 2023 14:15:11 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 2/3] iommu: mediatek: Add support of unmanaged iommu
 domain
Content-Language: en-GB
To: Alexandre Bailon <abailon@baylibre.com>, yong.wu@mediatek.com,
 joro@8bytes.org, will@kernel.org
Cc: matthias.bgg@gmail.com, krzysztof.kozlowski@linaro.org,
 robh+dt@kernel.org, iommu@lists.linux.dev,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20230130102722.133271-1-abailon@baylibre.com>
 <20230130102722.133271-3-abailon@baylibre.com>
 <741920ba-8637-5e28-695c-699b46351590@arm.com>
 <f126c61f-6373-d6c5-59c8-24dea9d9d168@baylibre.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <f126c61f-6373-d6c5-59c8-24dea9d9d168@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31/01/2023 1:08 pm, Alexandre Bailon wrote:
> Hi Robin
> 
> On 1/30/23 13:04, Robin Murphy wrote:
>> On 2023-01-30 10:27, Alexandre Bailon wrote:
>>> Currently, the driver can allocate an unmanaged iommu domain.
>>> But, this only works for SoC having multiple bank or multiple iova 
>>> region.
>>
>> That is for good reason - there is only a single pagetable per bank, 
>> so if there are multiple devices assigned to a single bank, they 
>> cannot possibly be attached to different domains at the same time. 
>> Hence why the banks are modelled as groups.
> I understand.
> I am trying to upstream a remoteproc driver but the remote processor is
> behind the iommu.
> remoteproc can manage the iommu but it requires an unmanaged domain.
> I tried a couple of things but this cause code duplication,
> implies many hacks and not always reliable.
> Do you have any suggestion ?

If there are other active devices behind the same IOMMU, and the 
remoteproc device cannot be isolated into its own bank using the 
existing IOMMU driver logic, then the remoteproc driver cannot manage 
the IOMMU directly, and must just use the regular DMA API. There's no 
way around it; you can't have two different parts of the kernel both 
thinking they have exclusive control of a single IOMMU address space at 
the same time. Similarly, remoteproc also cannot take explicit control 
of a multi-device group if it's not actually in control of the other 
devices, since their drivers will not be expecting the DMA address space 
to suddenly change underfoot - that's why iommu_attach_device() has the 
check which you presumably ran into.

Thanks,
Robin.
