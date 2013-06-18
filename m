From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: DMA mapping API(IOMMU) for ARM64?
Date: Tue, 18 Jun 2013 11:38:05 +0100
Message-ID: <20130618103804.GI9930@arm.com>
References: <20130618.053955.305832937374936961.hdoyu@nvidia.com>
 <20130618101914.GB3539@mudshark.cambridge.arm.com>
 <5159282.rrJMaZuYMv@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <5159282.rrJMaZuYMv@wuerfel>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Will Deacon <Will.Deacon@arm.com>, "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, Hiroshi Doyu <hdoyu@nvidia.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>
List-Id: iommu@lists.linux-foundation.org

On Tue, Jun 18, 2013 at 11:32:44AM +0100, Arnd Bergmann wrote:
> On Tuesday 18 June 2013 11:19:14 Will Deacon wrote:
> > I've spoken briefly with Catalin about this and it seems like there might be
> > *some* scope for sharing common dma-mapping code between architectures.
> > There doesn't really need to be any architecture-specific details in
> > allocating iova space and the interface to the iommu drivers is
> > well-defined. The arch-specific stuff is bogged down in the non-coherent
> > buffer management, but that doesn't necessarily equate to lots of code.
> > 
> > So, the best bet would be to figure out how to split up what we have under
> > arch/arm/ so that it can be re-used by arm64 and potentially other
> > architectures (powerpc has some simple stuff for coherent mappings and some
> > less-simple stuff for non-coherent buffers).
> 
> I'm sure that other architectures are interested in sharing the code.
> Best move it into the global mm/ directory, at least the version for
> coherent mappings.

Or we could extend the lib/iommu-helper.c or add another file in there
(we already have lib/swiotlb.c).

-- 
Catalin
