From: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
Subject: [PATCH 0/2] dma-mapping: fix ia64 and m32r build error and warnings
Date: Thu, 29 Sep 2016 12:02:38 +0200
Message-ID: <20160929100240.7955-1-niklas.soderlund@ragnatech.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: vinod.koul@intel.com, linux-renesas-soc@vger.kernel.org, dmaengine@vger.kernel.org, iommu@lists.linux-foundation.org
Cc: robin.murphy@arm.com, arnd@arndb.de, =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
List-Id: iommu@lists.linux-foundation.org

From: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

Hi Vindo,

This small series fixes the build error and warnings for ia64 and m32r 
which kbuild test robot found and where introduced in the series 
'[PATCHv9 0/6] dmaengine: rcar-dmac: add iommu support for slave 
transfers'.

It is based ontop of:

git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/slave-dma.git next

The fixes are only compile tested for the ia64 and m32r architecture to 
show that the error and warnings are fixed. It is tested on ARM to prove 
that the intended functionality still works.

Kbuild test robot found one more class of warnings for the patch series 
mentioned above for the balackfin arch.

   include/linux/dma-mapping.h: In function 'dma_map_resource':
>> include/asm-generic/page.h:90:32: warning: comparison of unsigned expression >= 0 is always true [-Wtype-limits]
    #define pfn_valid(pfn)  ((pfn) >= ARCH_PFN_OFFSET && ((pfn) - ARCH_PFN_OFFSET) < max_mapnr)
                                   ^

These warnings are not addressed in this series since they are not new 
or unique to original patch. They come from how pfn_valid() is 
implemented in include/asm-generic/page.h, if ARCH_PFN_OFFSET is 0 the 
warning is triggered. On the kbuild blackfin build it is defined as 
'(0x0 >> 12)' so any invocation of pfn_valid() will trigger it.

I tried to fix it but was unable to find a good solution. There is a 
MIPS specific fix for this in commit 95486e4 (MIPS: Fix flood of 
warnings about comparsion being always true.), but a similar fix for 
asm-generic seems to tricky for me to attempt since the macro needs to 
be turned into a static inline function and that might be harmful.  I 
also toyed with the solution of '#if ARCH_PFN_OFFSET == 0' to provided 
an alternative pfn_valid() macro, but since ARCH_PFN_OFFSET is defined 
as an expression and not a constant that wont work. If you can think of 
another way I be happy to try that out and see if I can make it work.

Niklas Söderlund (2):
  dma-mapping: fix ia64 build, use PHYS_PFN
  dma-mapping: fix m32r build warning

 include/linux/dma-mapping.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

-- 
2.9.3
