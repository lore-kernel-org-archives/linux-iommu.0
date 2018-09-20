From: Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: Re: [PATCH 1/1] iommu/arm-smmu: Add support to use Last level cache
Date: Thu, 20 Sep 2018 15:55:20 +0530
Message-ID: <CAFp+6iG5s+_vDsXf6+2PCCTizN+-nkGa8O8TSTjkwMMOzkgfNg@mail.gmail.com>
References: <20180615105329.26800-1-vivek.gautam@codeaurora.org>
 <20180615165232.GE2202@arm.com> <CAFp+6iFm29ufb2Pr7Gb-2O_aN3GQLH4rcyWhbQGZ3QiwCC8vPg@mail.gmail.com>
 <20180627163749.GA8729@arm.com> <CAFp+6iHnA1Jj8wKO08YYEBKVF2_3oEuOQOcW2boL=AYZ9+b=UA@mail.gmail.com>
 <20180919193539.GB809@jcrouse-lnx.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180919193539.GB809@jcrouse-lnx.qualcomm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>, open list <linux-kernel@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, pdaly@codeaurora.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Sep 20, 2018 at 1:05 AM Jordan Crouse <jcrouse@codeaurora.org> wrote:
>
> On Tue, Jul 24, 2018 at 03:13:37PM +0530, Vivek Gautam wrote:
> > Hi Will,
> >
> >
> > On Wed, Jun 27, 2018 at 10:07 PM, Will Deacon <will.deacon@arm.com> wrote:
> > > Hi Vivek,
> > >
> > > On Tue, Jun 19, 2018 at 02:04:44PM +0530, Vivek Gautam wrote:
> > >> On Fri, Jun 15, 2018 at 10:22 PM, Will Deacon <will.deacon@arm.com> wrote:
> > >> > On Fri, Jun 15, 2018 at 04:23:29PM +0530, Vivek Gautam wrote:
> > >> >> Qualcomm SoCs have an additional level of cache called as
> > >> >> System cache or Last level cache[1]. This cache sits right
> > >> >> before the DDR, and is tightly coupled with the memory
> > >> >> controller.
> > >> >> The cache is available to all the clients present in the
> > >> >> SoC system. The clients request their slices from this system
> > >> >> cache, make it active, and can then start using it. For these
> > >> >> clients with smmu, to start using the system cache for
> > >> >> dma buffers and related page tables [2], few of the memory
> > >> >> attributes need to be set accordingly.
> > >> >> This change makes the related memory Outer-Shareable, and
> > >> >> updates the MAIR with necessary protection.
> > >> >>
> > >> >> The MAIR attribute requirements are:
> > >> >>     Inner Cacheablity = 0
> > >> >>     Outer Cacheablity = 1, Write-Back Write Allocate
> > >> >>     Outer Shareablity = 1
> > >> >
> > >> > Hmm, so is this cache coherent with the CPU or not?
> > >>
> > >> Thanks for reviewing.
> > >> Yes, this LLC is cache coherent with CPU, so we mark for Outer-cacheable.
> > >> The different masters such as GPU as able to allocated and activate a slice
> > >> in this Last Level Cache.
> > >
> > > What I mean is, for example, if the CPU writes some data using Normal, Inner
> > > Shareable, Inner/Outer Cacheable, Inner/Outer Write-back, Non-transient
> > > Read/Write-allocate and a device reads that data using your MAIR encoding
> > > above, is the device guaranteed to see the CPU writes after the CPU has
> > > executed a DSB instruction?
> > >
> > > I don't think so, because the ARM ARM would say that there's a mismatch on
> > > the Inner Cacheability attribute.
> > >
> > >> > Why don't normal
> > >> > non-cacheable mappings allocated in the LLC by default?
> > >>
> > >> Sorry, I couldn't fully understand your question here.
> > >> Few of the masters on qcom socs are not io-coherent, so for them
> > >> the IC has to be marked as 0.
> > >
> > > By IC you mean Inner Cacheability? In your MAIR encoding above, it is zero
> > > so I don't understand the problem. What goes wrong if non-coherent devices
> > > use your MAIR encoding for their DMA buffers?
> > >
> > >> But they are able to use the LLC with OC marked as 1.
> > >
> > > The issue here is that whatever attributes we put in the SMMU need to align
> > > with the attributes used by the CPU in order to avoid introducing mismatched
> > > aliases. Currently, we support three types of mapping in the SMMU:
> > >
> > > 1. DMA non-coherent (e.g. "dma-coherent" is not set on the device)
> > >         Normal, Inner Shareable, Inner/Outer Non-Cacheable
> > >
> > > 2. DMA coherent (e.g. "dma-coherent" is set on the device) [IOMMU_CACHE]
> > >         Normal, Inner Shareable, Inner/Outer Cacheable, Inner/Outer
> > >         Write-back, Non-transient Read/Write-allocate
> > >
> > > 3. MMIO (e.g. MSI doorbell) [IOMMU_MMIO]
> > >         Device-nGnRE (Outer Shareable)
> > >
> > > So either you override one of these types (I was suggesting (1)) or you need
> > > to create a new memory type, along with the infrastructure for it to be
> > > recognised on a per-device basis and used by the DMA API so that we don't
> > > get mismatched aliases on the CPU.
> >
> > My apologies for delay in responding to this thread.
> > I have been digging and getting in touch with internal tech teams
> > to get more information on this. I will update as soon as I have enough
> > details.
> > Thanks.
>
> Hi Vivek.  I want to revive this discussion. I believe that Andy has pulled
> in the base LLCC support so this the remaining dependency we need to implement
> the LLCC in the GPU driver.

Hi Jordan, yes I was in process of gathering information about the system cache
usage and the attributes configurations required when devices use system cache.

Let me respond to Will's questions now.

Thanks
Vivek
>
> Thanks,
> Jordan
>
> --
> The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu


--
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
