From: Atish Patra <atish.patra@wdc.com>
Subject: Re: [RFC PATCH 0/4] Stop losing firmware-set DMA masks
Date: Tue, 10 Jul 2018 11:12:07 -0700
Message-ID: <1469c385-a586-3192-6ec8-cb15878acafe@wdc.com>
References: <cover.1531239284.git.robin.murphy@arm.com>
 <20180710180232.GA26285@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180710180232.GA26285@lst.de>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "joro@8bytes.org" <joro@8bytes.org>, "x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, Palmer Dabbelt <palmer@sifive.com>, "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>, "sudeep.holla@arm.com" <sudeep.holla@arm.com>, "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, "frowand.list@gmail.com" <frowand.list@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>
List-Id: iommu@lists.linux-foundation.org

On 7/10/18 11:01 AM, Christoph Hellwig wrote:
>> These patches attempt to deal with this in the simplest way possible by
>> generalising the specific quirk for 32-bit bridges into an arbitrary
>> mask which can then also be plumbed into the firmware code. In the
>> interest of being minimally invasive, I've only included a point fix
>> for the IOMMU issue as seen on arm64 - there may be further tweaks
>> needed in DMA ops to catch all possible incarnations of this problem,
>> but this initial RFC is mostly about the impact beyond the dma-mapping
>> subsystem itself.
> 
> Thanks, this looks very nice to me.
> 
> In fact it probably solves the RISC-V/Xiling problem as well if we can
> just add the dma-ranges property to the device tree for the affected
> systems.  Palmer, do you know how easily the DT could be updated for
> that case?
> 
Hi Chris,
I have a PR in riscv-pk that can modify the DT in bbl easily. In fact, 
that's how I added the timer node for the interrupt patch.

https://github.com/riscv/riscv-pk/pull/112

Obviously, the best approach would be to update the firmware but that 
may be time consuming sometime.

Regards,
Atish
>>
>> Robin.
>>
>>
>> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2018-May/580804.html
>> [2] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-December/474443.html
>>
>> Robin Murphy (4):
>>    dma-mapping: Generalise dma_32bit_limit flag
>>    ACPI/IORT: Set bus DMA mask as appropriate
>>    of/device: Set bus DMA mask as appropriate
>>    iommu/dma: Respect bus DMA limit for IOVAs
>>
>>   arch/x86/kernel/pci-dma.c | 2 +-
>>   drivers/acpi/arm64/iort.c | 1 +
>>   drivers/iommu/dma-iommu.c | 3 +++
>>   drivers/of/device.c       | 1 +
>>   include/linux/device.h    | 6 +++---
>>   kernel/dma/direct.c       | 2 +-
>>   6 files changed, 10 insertions(+), 5 deletions(-)
>>
>> -- 
>> 2.17.1.dirty
> ---end quoted text---
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
> 
