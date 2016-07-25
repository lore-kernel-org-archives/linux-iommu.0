From: Mitchel Humpherys <mitchelh@codeaurora.org>
Subject: Re: [PATCH v3 0/6] Add support for privileged mappings
Date: Mon, 25 Jul 2016 12:01:05 -0700
Message-ID: <vnkwoa5l8rv2.fsf@codeaurora.org>
References: <20160719203655.16629-1-mitchelh@codeaurora.org>
	<20160722165107.GH16837@arm.com> <vnkweg6l9zla.fsf@codeaurora.org>
	<20160725095012.GC15864@arm.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160725095012.GC15864@arm.com> (Will Deacon's message of "Mon,
	25 Jul 2016 10:50:13 +0100")
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Jordan Crouse <jcrouse@codeaurora.org>, Jeremy Gebben <jgebben@codeaurora.org>, Patrick Daly <pdaly@codeaurora.org>, Pratik Patel <pratikp@codeaurora.org>, Thomas Zeng <tzeng@codeaurora.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Jul 25 2016 at 10:50:13 AM, Will Deacon <will.deacon@arm.com> wrote:
> On Fri, Jul 22, 2016 at 01:39:45PM -0700, Mitchel Humpherys wrote:
>> On Fri, Jul 22 2016 at 05:51:07 PM, Will Deacon <will.deacon@arm.com> wrote:
>> > On Tue, Jul 19, 2016 at 01:36:49PM -0700, Mitchel Humpherys wrote:
>> >> The following patch to the ARM SMMU driver:
>> >> 
>> >>     commit d346180e70b91b3d5a1ae7e5603e65593d4622bc
>> >>     Author: Robin Murphy <robin.murphy@arm.com>
>> >>     Date:   Tue Jan 26 18:06:34 2016 +0000
>> >>     
>> >>         iommu/arm-smmu: Treat all device transactions as unprivileged
>> >> 
>> >> started forcing all SMMU transactions to come through as "unprivileged".
>> >> The rationale given was that:
>> >> 
>> >>   (1) There is no way in the IOMMU API to even request privileged mappings.
>> >> 
>> >>   (2) It's difficult to implement a DMA mapper that correctly models the
>> >>       ARM VMSAv8 behavior of unprivileged-writeable =>
>> >>       privileged-execute-never.
>> >> 
>> >> This series rectifies (1) by introducing an IOMMU API for privileged
>> >> mappings and implements it in io-pgtable-arm.
>> >> 
>> >> This series rectifies (2) by introducing a new dma attribute
>> >> (DMA_ATTR_PRIVILEGED) for users of the DMA API that need privileged
>> >> mappings which are inaccessible to lesser-privileged execution levels, and
>> >> implements it in the arm64 IOMMU DMA mapper.  The one known user (pl330.c)
>> >> is converted over to the new attribute.
>> >> 
>> >> Jordan and Jeremy can provide more info on the use case if needed, but the
>> >> high level is that it's a security feature to prevent attacks such as [1].
>> >
>> > This all looks good to me:
>> >
>> > Acked-by: Will Deacon <will.deacon@arm.com>
>> >
>> > It looks pretty fiddly to merge, however. How are you planning to get
>> > this upstream?
>> 
>> Fiddly in what way?  Do you mean in relation to "dma-mapping: Use
>> unsigned long for dma_attrs" [1]?  I admit I wasn't aware of that
>> activity until Robin mentioned it.  It looks like it's merged on
>> next/master, shall I rebase/rework on that and resend?
>
> Fiddly in that it touches multiple subsystems. I guess routing it via
> the iommu tree (Joerg) might be the best bet.

Sounds good.  I'm going to rebase on linux-next as well anyways to get
the new dma attrs format and resend.


-Mitch

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
