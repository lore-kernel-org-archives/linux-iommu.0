From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v7 1/8] genirq/msi: Add a new MSI_FLAG_IRQ_REMAPPING
 flag
Date: Fri, 22 Apr 2016 17:39:53 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1604221739070.3941@nanos>
References: <1461085990-2547-1-git-send-email-eric.auger@linaro.org> <1461085990-2547-2-git-send-email-eric.auger@linaro.org> <571A04A9.1010104@arm.com> <571A1855.5020008@linaro.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <571A1855.5020008@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Eric Auger <eric.auger@linaro.org>
Cc: Robin Murphy <robin.murphy@arm.com>, eric.auger@st.com, alex.williamson@redhat.com, will.deacon@arm.com, joro@8bytes.org, jason@lakedaemon.net, marc.zyngier@arm.com, christoffer.dall@linaro.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org, linux-kernel@vger.kernel.org, Bharat.Bhushan@freescale.com, pranav.sawargaonkar@gmail.com, p.fedin@samsung.com, iommu@lists.linux-foundation.org, Jean-Philippe.Brucker@arm.com, julien.grall@arm.com
List-Id: iommu@lists.linux-foundation.org

On Fri, 22 Apr 2016, Eric Auger wrote:
> Robin,
> On 04/22/2016 01:02 PM, Robin Murphy wrote:
> > Hi Eric,
> > 
> > On 19/04/16 18:13, Eric Auger wrote:
> >> Let's introduce a new msi_domain_info flag value, MSI_FLAG_IRQ_REMAPPING
> >> meant to tell the domain supports IRQ REMAPPING, also known as Interrupt
> >> Translation Service. On Intel HW this IRQ remapping capability is
> >> abstracted on IOMMU side while on ARM it is abstracted on MSI controller
> >> side. This flag will be used to know whether the MSI passthrough is
> >> safe.
> > 
> > Perhaps a nitpick, but given the earlier confusion about what the IOMMU
> > flag actually meant this prompts me to wonder if it's worth adjusting
> > the general terminology before we propagate it further. What I think we
> > actually care about is that one thing or the other "provides MSI
> > isolation" rather than "supports MSI remapping", since the latter is all
> > to easy to misinterpret the way we did in the SMMU drivers.
> 
> The only concern I have is https://lkml.org/lkml/2016/4/18/283 attempts
> to define a PCI bus flag dubbed PCI_BUS_FLAGS_MSI_REMAP combining the
> iommu & msi layer info. In that sense x86 people may not be keen of
> having different terminaologies. Anyway I will follow the consensus, if any.

Yes, please keep that consistent. It makes 'grep' much more conveniant.

Thanks,

	tglx
