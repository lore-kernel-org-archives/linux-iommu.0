From: Greg Ungerer <gregungerer@westnet.com.au>
Subject: Re: [PATCH 1/2] dma-mapping: zero memory returned from dma_alloc_*
Date: Fri, 11 Jan 2019 16:09:19 +1000
Message-ID: <cde0e0cd-1eb7-77e2-cc65-939c94a76f4c@westnet.com.au>
References: <20181214082515.14835-1-hch@lst.de>
 <20181214082515.14835-2-hch@lst.de>
 <CAMuHMdWOr0EsgFQF8tjJYLxKVXx+Jwn73N8SVKt8AQGLKQ8V-A@mail.gmail.com>
 <20181214114719.GA3316@lst.de>
 <5ae55118-6858-9121-6b3e-9b19b41550ef@westnet.com.au>
 <20181217115931.GA6853@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181217115931.GA6853@lst.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linux IOMMU <iommu@lists.linux-foundation.org>, Michal Simek <monstr@monstr.eu>, ashutosh.dixit@intel.com, linux-m68k <linux-m68k@lists.linux-m68k.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

Hi Christoph,

On 17/12/18 9:59 pm, Christoph Hellwig wrote:
> On Sat, Dec 15, 2018 at 12:14:29AM +1000, Greg Ungerer wrote:
>> Yep, that is right. Certainly the MMU case is broken. Some noMMU cases work
>> by virtue of the SoC only having an instruction cache (the older V2 cores).
> 
> Is there a good an easy case to detect if a core has a cache?  Either
> runtime or in Kconfig?
> 
>> The MMU case is fixable, but I think it will mean changing away from
>> the fall-back virtual:physical 1:1 mapping it uses for the kernel address
>> space. So not completely trivial. Either that or a dedicated area of RAM
>> for coherent allocations that we can mark as non-cachable via the really
>> course grained and limited ACR registers - not really very appealing.
> 
> What about CF_PAGE_NOCACHE?  Reading arch/m68k/include/asm/mcf_pgtable.h
> suggest this would cause an uncached mapping, in which case something
> like this should work:
> 
> 	http://git.infradead.org/users/hch/misc.git/commitdiff/4b8711d436e8d56edbc5ca19aa2be639705bbfef

No, that won't work.

The current MMU setup for ColdFire relies on a quirk of the cache
control subsystem to map kernel mapping (actually all of RAM when
accessed in supervisor mode).

The effective address calculation by the CPU/MMU firstly checks
the RAMBAR access, then

 From the ColdFire 5475 Reference Manual (section 5.5.1):

   If virtual mode is enabled, any normal mode access that does not hit in the MMUBAR,
   RAMBARs, ROMBARs, or ACRs is considered a normal mode virtual address request and
   generates its access attributes from the MMU. For this case, the default CACR address attributes
   are not used.

The MMUBAR is the MMU control registers, the RAMBAR/ROMBAR are the
internal static RAM/ROM regions and the ACR are the cache control
registers. The code in arch/m68k/coldfire/head.S sets up the ACR
registers so that all of RAM is accessible and cached when in supervisor
mode. So kernel code and data accesses will hit this and use the
address for access. User pages won't hit this and will go through to
hit the MMU mappings.

The net out is we don't need page mappings or use TLB entries
for kernel code/data. The problem is we also can't map individual
regions as not cached for coherent allocations... The ACR mapping
means all-or-nothing.

This leads back to what I mentioned earlier about changing the
VM mapping to not use the ACR mapping method and actually page
mapping the kernel space. Not completely trivial and I expect
there will be a performance hit with the extra TLB pressure and
their setup/remapping overhead.


>> The noMMU case in general is probably limited to something like that same
>> type of dedicated RAM/ACR register mechamism.
>>
>> The most commonly used periperal with DMA is the FEC ethernet module,
>> and it has some "special" (used very loosely) cache flushing for
>> parts like the 532x family which probably makes it mostly work right.
>> There is a PCI bus on the 54xx family of parts, and I know general
>> ethernet cards on it (like e1000's) have problems I am sure are
>> related to the fact that coherent memory allocations aren't.
> 
> If we really just care about FEC we can just switch it do use
> DMA_ATTR_NON_CONSISTENT and do explicit cache flushing.  But as far
> as I can tell FEC only uses DMA coherent allocations for the TSO
> headers anyway, is TSO even used on this SOC?

The FEC is the most commonly used, but not the only. I test generic PCI
NICs on the PCI bus on the ColdFire 5475 - and a lot of those drivers
rely on coherent allocations.

Regards
Greg
