From: Will Deacon <will.deacon@arm.com>
Subject: Re: [RFC PATCH 3/7] iommu/arm-smmu-v3: Introduce smmu option
 USE_SHARED_IRQS for Silicon errata
Date: Tue, 11 Apr 2017 17:21:24 +0100
Message-ID: <20170411162123.GF17109@arm.com>
References: <1491921765-29475-1-git-send-email-linucherian@gmail.com>
 <1491921765-29475-4-git-send-email-linucherian@gmail.com>
 <b84e2383-1a65-3c5a-8e2c-28eafdb20adc@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <b84e2383-1a65-3c5a-8e2c-28eafdb20adc@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: linucherian@gmail.com, catalin.marinas@arm.com, lorenzo.pieralisi@arm.com, hanjun.guo@linaro.org, sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org, joro@8bytes.org, robert.moore@intel.com, lv.zheng@intel.com, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org, devel@acpica.org, Sunil.Goutham@cavium.com, Geethasowjanya.Akula@cavium.com, robert.richter@cavium.com, linu.cherian@cavium.com, Geetha <gakula@cavium.com>
List-Id: iommu@lists.linux-foundation.org

On Tue, Apr 11, 2017 at 04:54:26PM +0100, Robin Murphy wrote:
> On 11/04/17 15:42, linucherian@gmail.com wrote:
> > From: Geetha <gakula@cavium.com>
> > 
> > Cavium 99xx SMMU implementation doesn't not support unique irq lines for
> > gerror, eventq and cmdq-sync. USE_SHARED_IRQS option enables to use single
> > irq line for all three interrupts.
> 
> AFAICS, there's nothing actually wrong with using shared wired IRQs -
> the architecture spec doesn't appear to say anything about it. I think
> it might suffice to simply add IRQF_SHARED if we can see the SMMU
> doesn't support MSIs anyway - it doesn't really seem like something we
> need to treat as a specific quirk.

No, this is not permitted by the spec. See 3.18.2 ("Interrupt sources"),
where it's clear that each source asserts a *unique* wired interrupt.

Geetha: does your implementation support MSIs?

Will
