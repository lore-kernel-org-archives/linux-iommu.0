From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v3 4/6] iommu/io-pgtable-arm: add support for non-strict
 mode
Date: Tue, 14 Aug 2018 11:02:52 +0100
Message-ID: <feabf4a3-db1e-a22b-daab-fad831b473f9@arm.com>
References: <1531376312-2192-1-git-send-email-thunder.leizhen@huawei.com>
 <1531376312-2192-5-git-send-email-thunder.leizhen@huawei.com>
 <89cc2201-99ab-3f3b-a2d1-1766515d4375@arm.com> <5B597628.2020103@huawei.com>
 <04239cfa-bcf2-a33a-e662-ebc75e66782b@arm.com>
 <1d24541340334954969c58980ef85444@HXTBJIDCEMVIW01.hxtcorp.net>
 <5B7293E5.7040702@huawei.com> <20180814083500.GA28101@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180814083500.GA28101@arm.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>, "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc: "Yang, Shunyong" <shunyong.yang@hxt-semitech.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, Joerg Roedel <joro@8bytes.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, iommu <iommu@lists.linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

On 14/08/18 09:35, Will Deacon wrote:
> On Tue, Aug 14, 2018 at 04:33:41PM +0800, Leizhen (ThunderTown) wrote:
>> On 2018/8/6 9:32, Yang, Shunyong wrote:
>>> On 2018/7/26 22:37, Robin Murphy wrote:
>>>> Because DMA code is not the only caller of iommu_map/unmap. It's
>>>> perfectly legal in the IOMMU API to partially unmap a previous mapping
>>>> such that a block entry needs to be split. The DMA API, however, is a
>>>> lot more constrined, and thus by construction the iommu-dma layer will
>>>> never generate a block-splitting iommu_unmap() except as a result of
>>>> illegal DMA API usage, and we obviously do not need to optimise for that
>>>> (you will get a warning about mismatched unmaps under dma-debug, but
>>>> it's a bit too expensive to police in the general case).
>>>>
>>>
>>> When I was reading the code around arm_lpae_split_blk_unmap(), I was
>>> curious in which scenario a block will be split. Now with your comments
>>> "Because DMA code is not the only caller of iommu_map/unmap", it seems
>>> depending on the user.
>>>
>>> Would you please explain this further? I mean besides DMA, which user
>>> will use iommu_map/umap and how it split a block.
>>
>> I also think that arm_lpae_split_blk_unmap() scenario is not exist, maybe
>> we should remove it, and give a warning for this wrong usage.
> 
> Can't it happen with VFIO?

...or GPU drivers, or anyone else managing their own IOMMU domain 
directly. A sequence like this is perfectly legal:

	iommu_map(domain, iova, paddr, SZ_8M, prot);
	...
	iommu_unmap(domain, iova + SZ_1M * 5, SZ_1M * 3);

where if iova and paddr happen to be suitably aligned, the map will lay 
down blocks, and the unmap will then have to split one of them into 
pages to remove half of it. We don't tear our hair out maintaining 
split_blk_unmap() for the fun of it :(

Robin.
