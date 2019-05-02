From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 RFC/RFT 1/5] ARM: dma-mapping: Add fallback normal
 page allocations
Date: Thu, 2 May 2019 15:26:10 +0200
Message-ID: <20190502132610.GA3107@lst.de>
References: <20190326230131.16275-1-nicoleotsuka@gmail.com>
 <20190326230131.16275-2-nicoleotsuka@gmail.com>
 <20190424150638.GA22191@lst.de>
 <20190424183310.GA6168@Asurada-Nvidia.nvidia.com>
 <20190424192652.GA29032@lst.de> <20190430152421.GE29799@arrakis.emea.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190430152421.GE29799@arrakis.emea.arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: tony@atomide.com, joro@8bytes.org, will.deacon@arm.com, linux@armlinux.org.uk, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Nicolin Chen <nicoleotsuka@gmail.com>, robin.murphy@arm.com, Christoph Hellwig <hch@lst.de>, linux-arm-kernel@lists.infradead.org, m.szyprowski@samsung.com
List-Id: iommu@lists.linux-foundation.org

On Tue, Apr 30, 2019 at 04:24:21PM +0100, Catalin Marinas wrote:
> My reading of the arm32 __dma_alloc() is that if the conditions are
> right for the CMA allocator (allows blocking) and there is a default CMA
> area or a per-device one, the call ends up in cma_alloc() without any
> fallback if such allocation fails. Whether this is on purpose, I'm not
> entirely sure. There are a couple of arm32 SoCs which call
> dma_declare_contiguous() or dma_contiguous_reserve_area() and a few DT
> files describing a specific CMA range (e.g. arch/arm/boot/dts/sun5i.dtsi
> with a comment that address must be kept in the lower 256MB).
> 
> If ZONE_DMA is set up correctly so that cma_alloc() is (or can be made)
> interchangeable with alloc_pages(GFP_DMA) from a device DMA capability
> perspective , I think it should be fine to have such fallback.

Indeed.  I missed arm32 being different from everyone else, but we
already addresses that in another thread.  Sorry for misleading
everyone.
