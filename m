From: Tomasz Figa <tfiga@chromium.org>
Subject: Re: [RFC PATCH 4/5] iommu/dma: Export non-static functions to use in modules
Date: Thu, 6 Jul 2017 23:41:29 +0900
Message-ID: <CAAFQd5A2uv4ZS_iLV8VvP1a4mPVmBKD+0hCVp-5n5s0aU0oqUw@mail.gmail.com>
References: <20170705071215.17603-1-tfiga@chromium.org> <20170705071215.17603-5-tfiga@chromium.org>
 <d02d47f2-8e89-ddba-54d9-1d1f52ae394a@arm.com> <CAAFQd5C3P7Rpohq=5xoBs1mUtbQ63FbQ80-Rm08JEY-iDyipYA@mail.gmail.com>
 <f66b6ebc-9977-8783-4e6a-10dcfcadf60d@arm.com> <20170706141045.GA577@lst.de>
 <CAAFQd5Af_rFDpDjRP2Vb875nPCrx+8FV6wMFDHt71YQ5BWOOSg@mail.gmail.com>
 <CAAFQd5Dd81w3AEyWq1L5uYN2Aw1a8UW7T7gkdtD3stMV58EjfQ@mail.gmail.com> <CAK8P3a0oDPL8s7XMHZw9u_PpqGLELGHSx4GaG3qbcxtjGOG3SQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a0oDPL8s7XMHZw9u_PpqGLELGHSx4GaG3qbcxtjGOG3SQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>, "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>, Vineet Gupta <vgupta@synopsys.com>, Hans-Christian Noren Egtvedt <egtvedt@samfundet.no>, Mitchel Humpherys <mitchelh@codeaurora.org>, Krzysztof Kozlowski <krzk@kernel.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Jul 6, 2017 at 11:35 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thu, Jul 6, 2017 at 4:24 PM, Tomasz Figa <tfiga@chromium.org> wrote:
>> On Thu, Jul 6, 2017 at 11:17 PM, Tomasz Figa <tfiga@chromium.org> wrote:
>>> On Thu, Jul 6, 2017 at 11:10 PM, Christoph Hellwig <hch@lst.de> wrote:
>>>> On Thu, Jul 06, 2017 at 12:09:45PM +0100, Robin Murphy wrote:
>>>>> I suppose another option is to just make the IOMMU and DMA ops a
>>>>> self-contained non-modular driver mirroring the VT-d/AMD-Vi IOMMUs -
>>>>> AFAICS it shouldn't have to be all that tightly coupled to the IPU bus
>>>>> code, the latter more or less just needs to create the appropriate IOMMU
>>>>> device for the driver to find.
>>>>
>>>> I still haven't seen the driver code, but this seems to be best
>>>> solution so far.  Given that it's not a plug in device but part of
>>>> an SOC that seems perfectly acceptable to me.
>>>
>>> I guess that's something that could work. With its caveats of not
>>> being able to avoid including the very platform specific code in a
>>> generic kernel image or do any quick testing of code changes without a
>>> restart, but I guess that's something one could quickly hack in their
>>> own downstream (i.e. export the symbols and turn the Kconfig entry
>>> into tristate).
>>>
>>> On the other hand, I'm yet to see any real reasons why not to export
>>> those symbols. Personally I don't see anything that one wouldn't be
>>> able to do in their downstream without the symbols exported in
>>> mainline (one can add the exports any time or if the kernel source
>>> can't be modified can just load a wrapper module that exports its own
>>> symbols...)
>>
>> Sorry, I just realized that last sentence might sound nonsense. By
>> wrapper I meant reimplementing the missing functions using some
>> already exported functions I mentioned in my post to another patch
>> from this series, such as __get_vm_area() and map_vm_area().
>
> We should look at the two aspects separately: one is how to drive
> the IOMMU as part of a loadable driver, the other is how to handle
> DMA to uncached memory on x86. You are in an unfortunate
> position of needing both, but aside from that they seem unrelated.

So generally I'm not in such a desperate need to have this code as a
loadable module. I can just hack around it in my own working tree if I
need it. However I'm trying to understand, why this is such a bad
idea, if I already have it working.

Uncached DMA memory on x86 is actually more complicated. We could
still work around this by not relying on the memory being uncached
(with caveats obviously). But here too I'd like to understand why
having my own DMA ops is bad.

Best regards,
Tomasz
