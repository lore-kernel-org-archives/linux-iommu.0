From: Tomasz Figa <tfiga@chromium.org>
Subject: Re: [RFC PATCH 4/5] iommu/dma: Export non-static functions to use in modules
Date: Thu, 6 Jul 2017 23:17:35 +0900
Message-ID: <CAAFQd5Af_rFDpDjRP2Vb875nPCrx+8FV6wMFDHt71YQ5BWOOSg@mail.gmail.com>
References: <20170705071215.17603-1-tfiga@chromium.org> <20170705071215.17603-5-tfiga@chromium.org>
 <d02d47f2-8e89-ddba-54d9-1d1f52ae394a@arm.com> <CAAFQd5C3P7Rpohq=5xoBs1mUtbQ63FbQ80-Rm08JEY-iDyipYA@mail.gmail.com>
 <f66b6ebc-9977-8783-4e6a-10dcfcadf60d@arm.com> <20170706141045.GA577@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170706141045.GA577@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Robin Murphy <robin.murphy@arm.com>, "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>, Vineet Gupta <vgupta@synopsys.com>, Hans-Christian Noren Egtvedt <egtvedt@samfundet.no>, Mitchel Humpherys <mitchelh@codeaurora.org>, Krzysztof Kozlowski <krzk@kernel.org>, Arnd Bergmann <arnd@arndb.de>
List-Id: iommu@lists.linux-foundation.org

On Thu, Jul 6, 2017 at 11:10 PM, Christoph Hellwig <hch@lst.de> wrote:
> On Thu, Jul 06, 2017 at 12:09:45PM +0100, Robin Murphy wrote:
>> I suppose another option is to just make the IOMMU and DMA ops a
>> self-contained non-modular driver mirroring the VT-d/AMD-Vi IOMMUs -
>> AFAICS it shouldn't have to be all that tightly coupled to the IPU bus
>> code, the latter more or less just needs to create the appropriate IOMMU
>> device for the driver to find.
>
> I still haven't seen the driver code, but this seems to be best
> solution so far.  Given that it's not a plug in device but part of
> an SOC that seems perfectly acceptable to me.

I guess that's something that could work. With its caveats of not
being able to avoid including the very platform specific code in a
generic kernel image or do any quick testing of code changes without a
restart, but I guess that's something one could quickly hack in their
own downstream (i.e. export the symbols and turn the Kconfig entry
into tristate).

On the other hand, I'm yet to see any real reasons why not to export
those symbols. Personally I don't see anything that one wouldn't be
able to do in their downstream without the symbols exported in
mainline (one can add the exports any time or if the kernel source
can't be modified can just load a wrapper module that exports its own
symbols...)

Best regards,
Tomasz
