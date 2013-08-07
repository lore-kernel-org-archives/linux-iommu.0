From: Cho KyongHo <pullip.cho@samsung.com>
Subject: RE: [PATCH v8 06/12] ARM: dts: Add description of System MMU of Exynos
 SoCs
Date: Wed, 07 Aug 2013 21:07:01 +0900
Message-ID: <001b01ce9366$9f7427a0$de5c76e0$@samsung.com>
References: <003c01ce89f3$3abc4bc0$b034e340$@samsung.com>
 <27536111.odlCO093Zi@amdc1032> <003c01ce91cd$427fad70$c77f0850$@samsung.com>
 <1429191.3FDem6vW0S@amdc1032> <002001ce928a$f5a7f390$e0f7dab0$@samsung.com>
 <5200F781.9020300@samsung.com>
 <CANEJEGtQuKG5err-R7SxD6m+aJWVmn47X9NJLx7UzaRkKhUMoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <CANEJEGtQuKG5err-R7SxD6m+aJWVmn47X9NJLx7UzaRkKhUMoQ@mail.gmail.com>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: 'Grant Grundler' <grundler@chromium.org>, 'Marek Szyprowski' <m.szyprowski@samsung.com>
Cc: 'Bartlomiej Zolnierkiewicz' <b.zolnierkie@samsung.com>, 'Linux ARM Kernel' <linux-arm-kernel@lists.infradead.org>, 'Linux IOMMU' <iommu@lists.linux-foundation.org>, 'Linux Kernel' <linux-kernel@vger.kernel.org>, 'Linux Samsung SOC' <linux-samsung-soc@vger.kernel.org>, 'Hyunwoong Kim' <khw0178.kim@samsung.com>, 'Joerg Roedel' <joro@8bytes.org>, 'Kukjin Kim' <kgene.kim@samsung.com>, 'Prathyush' <prathyush.k@samsung.com>, 'Rahul Sharma' <rahul.sharma@samsung.com>, 'Subash Patel' <supash.ramaswamy@linaro.org>, 'Keyyoung Park' <keyyoung.park@samsung.com>, 'Antonios Motakis' <a.motakis@virtualopensystems.com>, kvmarm@lists.cs.columbia.edu, 'Sachin Kamat' <sachin.kamat@linaro.org>
List-Id: iommu@lists.linux-foundation.org

> -----Original Message-----
> From: grundler@google.com [mailto:grundler@google.com] On Behalf Of Grant Grundler
> Sent: Wednesday, August 07, 2013 1:07 AM
> To: Marek Szyprowski
> 
> Hi Marek,
> 
> On Tue, Aug 6, 2013 at 6:17 AM, Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
> ...
> > IMHO it is much better to have a simple driver, which binds to a single
> > IOMMU controller and leave it to the driver whether to have a same virtual address
> > space for all parts of FIMC-IS or MFC submodules/memory ports or not.
> 
> I understand this part. I having written the IOMMU support for 4
> different IOMMUs, all of which had exactly one IO Page Table and one
> IOMMU shared by many devices.
> 
> > Just make sure that it will be possible to attach more than one sysmmu
> > controller to one iommu domain.
> 
> I don't understand how this is possible. Can someone explain this
> better in the IOMMU documentation please?

System MMU is dedicated to a master H/W such as FIMD and FIMC.
Thus, attaching a master H/W to an iommu domain can be thought as
attaching a System MMU to an iommu domain even though such thinking
is not correct view of the relationship between iommu domain and
System MMU.

> 
> "iommu domain" to me means one virtual IO address space for attached
> devices that can master DMA transactions. The IOMMU then uses it's IO
> Page Table to translate the DMA address to the system physical address
> space and forwards the transaction.
> 
> What is the role of the sysmmu in all of this?
> Is the sysmmu just the MMU (or collection of MMU) for host DRAM?
> Or is sysmmu responsible for "other stuff"? (clocks, power domains, MMU, etc)
> 
System MMU is responsible for address translation of traffic from a
master H/W which the System MMU is dedicated to.

> I can understand we might have multiple MMUs in a system...e.g. every
> range of memory might have it's own MMU. But they share the same
> physical address space and generally live under one page table.
> Because of "one page table" I would consider them one entity from the
> the IOMMUs perspective.

Sorry, I don't understand.
Do you mean you are thinking that it is better to share one page table
by all IOMMUs in a system?

Thank you,
KyongHo
> 
> thanks,
> grant
