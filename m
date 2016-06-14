From: Wei Chen <wei.chen@linaro.org>
Subject: Re: [PATCH] iommu/arm-smmu: request pcie devices to enable ACS
Date: Tue, 14 Jun 2016 11:11:36 +0800
Message-ID: <CANta1d-wRGcU51P3Av7EXbvu7hJfUBk_Kd5p=7RDMW6u+v0gvg@mail.gmail.com>
References: <1465809617-13003-1-git-send-email-Wei.Chen@arm.com> <20160613124531.GE1605@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160613124531.GE1605@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: Wei Chen <Wei.Chen@arm.com>, steve.capper@arm.com, joro@8bytes.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

On 13 June 2016 at 20:45, Will Deacon <will.deacon@arm.com> wrote:
> On Mon, Jun 13, 2016 at 05:20:17PM +0800, Wei Chen wrote:
>> The PCIe ACS capability will affect the layout of iommu groups.
>> Generally speaking, if the path from root port to the PCIe device
>> is ACS enabled, the iommu will create a single iommu group for this
>> PCIe device. If all PCIe devices on the path are ACS enabled then
>> Linux can determine this path is ACS enabled.
>>
>> Linux use two PCIe configuration registers to determine the ACS
>> status of PCIe devices:
>> ACS Capability Register and ACS Control Register.
>>
>> The first register is used to check the implementation of ACS function
>> of a PCIe device, the second register is used to check the enable status
>> of ACS function. If one PCIe device has implemented and enabled the ACS
>> function then Linux will determine this PCIe device enabled ACS.
>>
>> From the Chapter:6.12 of PCI Express Base Specification Revision 3.1a,
>> we can find that when a PCIe device implements ACS function, the enable
>> status is set to disabled by default and can be enabled by ACS-aware
>> software.
>>
>> ACS will affect the iommu groups topology, so, the iommu driver is
>> ACS-aware software. This patch adds a call to pci_request_acs() to the
>> arm-smmu driver to enable the ACS function in PCIe devices that support
>> it.
>>
>> Signed-off-by: Wei Chen <Wei.Chen@arm.com>
>> ---
>>  drivers/iommu/arm-smmu-v3.c | 2 ++
>>  drivers/iommu/arm-smmu.c    | 4 +++-
>>  2 files changed, 5 insertions(+), 1 deletion(-)
>
> Thanks, queued for 4.8 w/ Robin and Eric's reviewed-by tags and the minor
> commit wording change.
>

Thanks, I will post a v2 patch to include above changes.

> Will
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
