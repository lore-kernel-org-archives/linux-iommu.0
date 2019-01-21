From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH 0/3] iommu/arm-smmu: Add support to use Last level cache
Date: Mon, 21 Jan 2019 11:50:53 +0100
Message-ID: <CAKv+Gu9z_mGwdZYMKPfM_g2MZwrCF5=f4WAdn_R6wJ1A9xSZ_Q@mail.gmail.com>
References: <20190121055335.15430-1-vivek.gautam@codeaurora.org>
 <CAKv+Gu8P-5hxZ8+OV_xSZteTvCLw-Sc-=KJM1i=3aWajcS9bUw@mail.gmail.com>
 <CAFp+6iEp-bzMrZz8cFUciTFKm7TwAoLdYpsSTD73kDfCRh60bA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAFp+6iEp-bzMrZz8cFUciTFKm7TwAoLdYpsSTD73kDfCRh60bA@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Vivek Gautam <vivek.gautam@codeaurora.org>
Cc: Jordan Crouse <jcrouse@codeaurora.org>, pdaly@codeaurora.org, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tomasz Figa <tfiga@chromium.org>, "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>, Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, pratikp@codeaurora.org
List-Id: iommu@lists.linux-foundation.org

On Mon, 21 Jan 2019 at 11:17, Vivek Gautam <vivek.gautam@codeaurora.org> wrote:
>
> Hi,
>
>
> On Mon, Jan 21, 2019 at 12:56 PM Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
> >
> > On Mon, 21 Jan 2019 at 06:54, Vivek Gautam <vivek.gautam@codeaurora.org> wrote:
> > >
> > > Qualcomm SoCs have an additional level of cache called as
> > > System cache, aka. Last level cache (LLC). This cache sits right
> > > before the DDR, and is tightly coupled with the memory controller.
> > > The clients using this cache request their slices from this
> > > system cache, make it active, and can then start using it.
> > > For these clients with smmu, to start using the system cache for
> > > buffers and, related page tables [1], memory attributes need to be
> > > set accordingly. This series add the required support.
> > >
> >
> > Does this actually improve performance on reads from a device? The
> > non-cache coherent DMA routines perform an unconditional D-cache
> > invalidate by VA to the PoC before reading from the buffers filled by
> > the device, and I would expect the PoC to be defined as lying beyond
> > the LLC to still guarantee the architected behavior.
>
> We have seen performance improvements when running Manhattan
> GFXBench benchmarks.
>

Ah ok, that makes sense, since in that case, the data flow is mostly
to the device, not from the device.

> As for the PoC, from my knowledge on sdm845 the system cache, aka
> Last level cache (LLC) lies beyond the point of coherency.
> Non-cache coherent buffers will not be cached to system cache also, and
> no additional software cache maintenance ops are required for system cache.
> Pratik can add more if I am missing something.
>
> To take care of the memory attributes from DMA APIs side, we can add a
> DMA_ATTR definition to take care of any dma non-coherent APIs calls.
>

So does the device use the correct inner non-cacheable, outer
writeback cacheable attributes if the SMMU is in pass-through?

We have been looking into another use case where the fact that the
SMMU overrides memory attributes is causing issues (WC mappings used
by the radeon and amdgpu driver). So if the SMMU would honour the
existing attributes, would you still need the SMMU changes?
