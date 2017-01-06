From: Rob Clark <robdclark@gmail.com>
Subject: Re: [RFC 1/3] iommu/arm-smmu: Add support to opt-in to stalling
Date: Fri, 6 Jan 2017 11:36:28 -0500
Message-ID: <CAF6AEGupLYDjBOYptRevM8WqwHDv1Pxcs1G23mj0QpwZU=0nTQ@mail.gmail.com>
References: <1483479056-15202-1-git-send-email-robdclark@gmail.com>
 <1483479056-15202-2-git-send-email-robdclark@gmail.com> <20170105115528.GG679@arm.com>
 <20170105120857.GB21952@leverpostej> <20170105140005.GJ679@arm.com>
 <20170105140720.GA25868@leverpostej> <20170105144742.GK679@arm.com>
 <d1a36cc5-265d-6971-f698-29b8d76e7884@arm.com> <20170105160755.GN679@arm.com>
 <611575f4-3e37-1f4d-ef29-94e6f65baf66@arm.com> <20170105172557.GS679@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20170105172557.GS679@arm.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, Jordan Crouse <jcrouse@codeaurora.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Jan 5, 2017 at 12:25 PM, Will Deacon <will.deacon@arm.com> wrote:
>> That's still got to be a per-master property, not a SMMU property, I
>> think. To illustrate:
>>
>>   [A]         [B]   [C]
>>    |           |_____|
>>  __|______________|___
>> | TBU |        | TBU |
>> |_____|  SMMU  |_____|
>> |__|______________|__|
>>    |              |
>>
>> Say A and B are instances of some device happy to be stalled, and C is a
>> PCIe RC, and each is attached to their own context bank - enabling
>> stalls for A is definitely fine. However even though B and C are using
>> different context banks, enabling stalls for B might deadlock C if it
>> results in more total outstanding transactions than the TBU's slave port
>> supports. Therefore A can happily claim to be stall-safe, but B cannot
>> due to its integration with respect to C.
>
> So in this case, don't say that B and C can DMA to unpinned memory. You
> need the third property. This property (property 2) is concerned with the
> SMMU itself because, e.g. the way the walker has been integrated can
> cause a deadlock.


fwiw, I guess I'm mostly thinking about case (A)..  but I guess in the
(B) case amend my suggestion about adding param to
iommu_set_fault_handler() slightly to consider the enable_stall param
passed in when both (B) and (C) register their fault handlers?

Or I guess the idea about increasing extra cell (which IIUC would let
us add an extra param in dt in the devices iommus property) could also
work.  Unless maybe there could be some cases where whether a device
can do stalling is also a function of the driver as well (ie. some
feature needs to be implemented type thing)..


BR,
-R
