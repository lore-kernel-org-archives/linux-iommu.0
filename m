From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH v4 43/44] dma-mapping: Remove dma_get_attr
Date: Fri, 10 Jun 2016 10:55:52 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA2307501069390A9@US01WEMBX2.internal.synopsys.com>
References: <1465553521-27303-1-git-send-email-k.kozlowski@samsung.com>
 <1465553521-27303-44-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mips-bounce@linux-mips.org>
Content-Language: en-US
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: "hch@infradead.org" <hch@infradead.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jonathan Corbet <corbet@lwn.net>, Vineet Gupta <Vineet.Gupta1@synopsys.com>, Russell King <linux@armlinux.org.uk>, Stefano Stabellini <sstabellini@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Hans-Christian Egtvedt <egtvedt@samfundet.no>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, James Hogan <james.hogan@imgtec.com>, Ralf Baechle <ralf@linux-mips.org>, Jonas Bonn <jonas@southpole.se>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Arnd Bergmann <arnd@arndb.de>, Benjamin Herrenschmidt <benh@kernel.crashing.o>
List-Id: iommu@lists.linux-foundation.org

On Friday 10 June 2016 03:44 PM, Krzysztof Kozlowski wrote:
> After switching DMA attributes to unsigned long it is easier to just
> compare the bits.
>
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> [for avr32]
> Acked-by: Hans-Christian Noren Egtvedt <egtvedt@samfundet.no>

Acked-by: Vineet Gupta <vgupta@synopsys.com>   #for arch/arc
