From: Cho KyongHo <pullip.cho@samsung.com>
Subject: RE: [PATCH v8 06/12] ARM: dts: Add description of System MMU of Exynos
 SoCs
Date: Thu, 08 Aug 2013 11:19:24 +0900
Message-ID: <001501ce93dd$b38d23f0$1aa76bd0$@samsung.com>
References: <003c01ce89f3$3abc4bc0$b034e340$@samsung.com>
 <27536111.odlCO093Zi@amdc1032> <003c01ce91cd$427fad70$c77f0850$@samsung.com>
 <1429191.3FDem6vW0S@amdc1032> <002001ce928a$f5a7f390$e0f7dab0$@samsung.com>
 <5200F781.9020300@samsung.com>
 <CANEJEGtQuKG5err-R7SxD6m+aJWVmn47X9NJLx7UzaRkKhUMoQ@mail.gmail.com>
 <001b01ce9366$9f7427a0$de5c76e0$@samsung.com>
 <CANEJEGtDm6FYvx8DdiGofk5ViU8kWK-3QvTvtU66Mvhfn+sDCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <CANEJEGtDm6FYvx8DdiGofk5ViU8kWK-3QvTvtU66Mvhfn+sDCQ@mail.gmail.com>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: 'Grant Grundler' <grundler@chromium.org>
Cc: 'Marek Szyprowski' <m.szyprowski@samsung.com>, 'Bartlomiej Zolnierkiewicz' <b.zolnierkie@samsung.com>, 'Linux ARM Kernel' <linux-arm-kernel@lists.infradead.org>, 'Linux IOMMU' <iommu@lists.linux-foundation.org>, 'Linux Kernel' <linux-kernel@vger.kernel.org>, 'Linux Samsung SOC' <linux-samsung-soc@vger.kernel.org>, 'Hyunwoong Kim' <khw0178.kim@samsung.com>, 'Joerg Roedel' <joro@8bytes.org>, 'Kukjin Kim' <kgene.kim@samsung.com>, 'Prathyush' <prathyush.k@samsung.com>, 'Rahul Sharma' <rahul.sharma@samsung.com>, 'Subash Patel' <supash.ramaswamy@linaro.org>, 'Keyyoung Park' <keyyoung.park@samsung.com>, 'Antonios Motakis' <a.motakis@virtualopensystems.com>, kvmarm@lists.cs.columbia.edu, 'Sachin Kamat' <sachin.kamat@linaro.org>
List-Id: iommu@lists.linux-foundation.org

> -----Original Message-----
> From: grundler@google.com [mailto:grundler@google.com] On Behalf Of Grant Grundler
> Sent: Thursday, August 08, 2013 1:21 AM
> 
> On Wed, Aug 7, 2013 at 5:07 AM, Cho KyongHo <pullip.cho@samsung.com> wrote:
> ...
> >> I don't understand how this is possible. Can someone explain this
> >> better in the IOMMU documentation please?
> >
> > System MMU is dedicated to a master H/W such as FIMD and FIMC.
> 
> Sory - Exynos 5250 documentation I have (confidential version) uses
> FIMD and FIMC but never explains what they are nor identifies them in
> a diagram. Based on the references, they are related to the video
> mixer but I don't know exactly what function FIMD/FIMC serve.

Ok.
FIMD is a display controller that reads RGB data and conveys the data
to the screen.
FIMC performs various functions including storing camera censor data to
the memory, image post processing like scaling, color space conversion
and rotation and conveying the processed data to FIMD.

> 
> 
> > Thus, attaching a master H/W to an iommu domain can be thought as
> > attaching a System MMU to an iommu domain even though such thinking
> > is not correct view of the relationship between iommu domain and
> > System MMU.
> 
> This almost makes sense. I understand the above to mean the System MMU
> is a proxy for the FIMD and FIMC.
> 
> >> I can understand we might have multiple MMUs in a system...e.g. every
> >> range of memory might have it's own MMU. But they share the same
> >> physical address space and generally live under one page table.
> >> Because of "one page table" I would consider them one entity from the
> >> the IOMMUs perspective.
> >
> > Sorry, I don't understand.
> > Do you mean you are thinking that it is better to share one page table
> > by all IOMMUs in a system?
> 
> No. This is how the previous IOMMUs I worked on functioned. It doesn't
> mean this is how current ones should.
> 
> My example above was referring to CPU MMUs in the case of NUMA
> architectures. Each NUMA CPU socket can have it's own MMU (and TLB)
> and corresponding memory controller. All CPUs in an SMP system map
> process and kernel virtual addresses to one common "physical" address
> space. This means allocation and use of "physical address space" has
> to be managed as one entity (even if several page tables exist in the
> implementation - e.g. NUMA).
> 
> 
> Back to the original comment that started my question (pulled out of
> context now...sorry):
>    "Just make sure that it will be possible to attach more than one
> sysmmu controller to one iommu domain."
> 
> Does that mean the IOMMU now has to map to multiple "physical address
> spaces" or am I completely missing what a SysMMU does?

I think I have explained what the quotation actually intended.
Exynos System MMUs in a SoC have the same view of physical address space.
But they provide different views of memory to their master H/Ws.
I think this is what Marek wanted to say.
> 
> The "SysMMU" is the System Memory Management Unit, right?

Yes it is IOMMU in Exynos SoCs.
It is referred as "SysMMU", "sysmmu", "smmu" or "System MMU".
All are the same in the context of Exynos SoCs.

It is not an implementation of ARM System MMU specifications.

> 
> I still thinking one IOMMU domain maps one (IO) virtual address space
> to one (common with CPU and other IOMMU) physical address space.

Definitely I agree with you.
However, this discussion is not started from Marek's comment that
several System MMUs can be attached to the same page table
It actually means:
 -> providing the same virtual address space to their master H/W
 -> ** The master H/Ws are attached to the same iommu domain. **

Regards,

KyongHo.
> 
> cheers,
> grant
> 
> >
> > Thank you,
> > KyongHo
> >>
> >> thanks,
> >> grant
> >
