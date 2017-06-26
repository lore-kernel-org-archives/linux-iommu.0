From: John Garry <john.garry@huawei.com>
Subject: Re: [PATCH v2 0/8] io-pgtable lock removal
Date: Mon, 26 Jun 2017 12:35:07 +0100
Message-ID: <9bbf18c7-34ba-6e94-53bd-3f75059c1bb2@huawei.com>
References: <cover.1498145008.git.robin.murphy@arm.com>
 <61b7b953-5bf4-eb45-c3e8-b4491e8fdca7@huawei.com>
 <f694a247-9006-3a3c-8a77-209b158eabf3@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <f694a247-9006-3a3c-8a77-209b158eabf3@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Robin Murphy <robin.murphy@arm.com>, will.deacon@arm.com, joro@8bytes.org
Cc: salil.mehta@huawei.com, sunil.goutham@cavium.com, thunder.leizhen@huawei.com, Hanjun Guo <guohanjun@huawei.com>, wangzhou1@hisilicon.com, Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, Linuxarm <linuxarm@huawei.com>, iommu@lists.linux-foundation.org, ray.jui@broadcom.com, linux-arm-kernel@lists.infradead.org, linu.cherian@cavium.com, nwatters@codeaurora.org
List-Id: iommu@lists.linux-foundation.org

On 23/06/2017 10:58, Robin Murphy wrote:
> On 23/06/17 09:47, John Garry wrote:
>> On 22/06/2017 16:53, Robin Murphy wrote:
>>> The feedback has been promising, so v2 is just a final update to cover
>>> a handful of memory ordering and cosmetic tweaks that came up when Will
>>> and I went through this offline.
>>>
>>> Thanks,
>>> Robin.
>>
>> Hi Robin,
>>
>> Is it worth us retesting this patchset?
>>
>> If yes, as for a branch (for convenience), does this one now match v2:
>> git://linux-arm.org/linux-rm  iommu/pgtable
>>
>> I saw it was rewritten recently.
>
> Indeed, I pushed the branch out before posting. Functionally it ought to
> be identical to v1, so this was more just a heads-up - feel free to
> double-check I've not broken anything, but I wouldn't say you need to
> throw the full test lab at it again.
>

I saw Will has already sent the pull request. But, FWIW, we are seeing 
roughly the same performance as v1 patchset. For PCI NIC, Zhou again 
found performance drop goes from ~15->8% with SMMU enabled, and for 
integrated storage controller [platform device], we still see a drop of 
about 50%, depending on datarates (Leizhen has been working on fixing this).

John

> Thanks,
> Robin.
>
>>
>> Thanks,
>> John
>>
>>>
>>>
>>> Robin Murphy (8):
>>>   iommu/io-pgtable-arm-v7s: Check table PTEs more precisely
>>>   iommu/io-pgtable-arm: Improve split_blk_unmap
>>>   iommu/io-pgtable-arm-v7s: Refactor split_blk_unmap
>>>   iommu/io-pgtable: Introduce explicit coherency
>>>   iommu/io-pgtable-arm: Support lockless operation
>>>   iommu/io-pgtable-arm-v7s: Support lockless operation
>>>   iommu/arm-smmu: Remove io-pgtable spinlock
>>>   iommu/arm-smmu-v3: Remove io-pgtable spinlock
>>>
>>>  drivers/iommu/arm-smmu-v3.c        |  36 ++-----
>>>  drivers/iommu/arm-smmu.c           |  48 ++++------
>>>  drivers/iommu/io-pgtable-arm-v7s.c | 179
>>> +++++++++++++++++++++-------------
>>>  drivers/iommu/io-pgtable-arm.c     | 191
>>> ++++++++++++++++++++++++-------------
>>>  drivers/iommu/io-pgtable.h         |   6 ++
>>>  5 files changed, 274 insertions(+), 186 deletions(-)
>>>
>>
>>
>
>
> .
>
