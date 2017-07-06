From: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [RFC PATCH 4/5] iommu/dma: Export non-static functions to use in
	modules
Date: Thu, 6 Jul 2017 23:24:28 +0900
Message-ID: <CAAFQd5Dd81w3AEyWq1L5uYN2Aw1a8UW7T7gkdtD3stMV58EjfQ@mail.gmail.com>
References: <20170705071215.17603-1-tfiga@chromium.org>
	<20170705071215.17603-5-tfiga@chromium.org>
	<d02d47f2-8e89-ddba-54d9-1d1f52ae394a@arm.com>
	<CAAFQd5C3P7Rpohq=5xoBs1mUtbQ63FbQ80-Rm08JEY-iDyipYA@mail.gmail.com>
	<f66b6ebc-9977-8783-4e6a-10dcfcadf60d@arm.com>
	<20170706141045.GA577@lst.de>
	<CAAFQd5Af_rFDpDjRP2Vb875nPCrx+8FV6wMFDHt71YQ5BWOOSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAAFQd5Af_rFDpDjRP2Vb875nPCrx+8FV6wMFDHt71YQ5BWOOSg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "open list:IOMMU DRIVERS" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Vineet Gupta <vgupta-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, Hans-Christian Noren Egtvedt <egtvedt-BrfabpQBY5qlHtIdYg32fQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Jul 6, 2017 at 11:17 PM, Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org> wrote:
> On Thu, Jul 6, 2017 at 11:10 PM, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org> wrote:
>> On Thu, Jul 06, 2017 at 12:09:45PM +0100, Robin Murphy wrote:
>>> I suppose another option is to just make the IOMMU and DMA ops a
>>> self-contained non-modular driver mirroring the VT-d/AMD-Vi IOMMUs -
>>> AFAICS it shouldn't have to be all that tightly coupled to the IPU bus
>>> code, the latter more or less just needs to create the appropriate IOMMU
>>> device for the driver to find.
>>
>> I still haven't seen the driver code, but this seems to be best
>> solution so far.  Given that it's not a plug in device but part of
>> an SOC that seems perfectly acceptable to me.
>
> I guess that's something that could work. With its caveats of not
> being able to avoid including the very platform specific code in a
> generic kernel image or do any quick testing of code changes without a
> restart, but I guess that's something one could quickly hack in their
> own downstream (i.e. export the symbols and turn the Kconfig entry
> into tristate).
>
> On the other hand, I'm yet to see any real reasons why not to export
> those symbols. Personally I don't see anything that one wouldn't be
> able to do in their downstream without the symbols exported in
> mainline (one can add the exports any time or if the kernel source
> can't be modified can just load a wrapper module that exports its own
> symbols...)

Sorry, I just realized that last sentence might sound nonsense. By
wrapper I meant reimplementing the missing functions using some
already exported functions I mentioned in my post to another patch
from this series, such as __get_vm_area() and map_vm_area().
