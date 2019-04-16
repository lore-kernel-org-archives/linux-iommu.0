From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v5 1/6] iommu: add generic boot option iommu.dma_mode
Date: Tue, 16 Apr 2019 16:21:00 +0100
Message-ID: <20190416152100.GB4187@fuggles.cambridge.arm.com>
References: <20190409125308.18304-1-thunder.leizhen@huawei.com>
 <20190409125308.18304-2-thunder.leizhen@huawei.com>
 <010d3cbd-ef74-ad21-c735-0af8b18955e6@huawei.com>
 <222946ee-adcc-1311-82a7-6afc9ffbc846@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <222946ee-adcc-1311-82a7-6afc9ffbc846@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: John Garry <john.garry@huawei.com>, Zhen Lei <thunder.leizhen@huawei.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, Joerg Roedel <joro@8bytes.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc <linux-doc@vger.kernel.org>, Sebastian Ott <sebott@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, David
List-Id: iommu@lists.linux-foundation.org

On Fri, Apr 12, 2019 at 02:11:31PM +0100, Robin Murphy wrote:
> On 12/04/2019 11:26, John Garry wrote:
> > On 09/04/2019 13:53, Zhen Lei wrote:
> > > +static int __init iommu_dma_mode_setup(char *str)
> > > +{
> > > +    if (!str)
> > > +        goto fail;
> > > +
> > > +    if (!strncmp(str, "passthrough", 11))
> > > +        iommu_default_dma_mode = IOMMU_DMA_MODE_PASSTHROUGH;
> > > +    else if (!strncmp(str, "lazy", 4))
> > > +        iommu_default_dma_mode = IOMMU_DMA_MODE_LAZY;
> > > +    else if (!strncmp(str, "strict", 6))
> > > +        iommu_default_dma_mode = IOMMU_DMA_MODE_STRICT;
> > > +    else
> > > +        goto fail;
> > > +
> > > +    pr_info("Force dma mode to be %d\n", iommu_default_dma_mode);
> > 
> > What happens if the cmdline option iommu.dma_mode is passed multiple
> > times? We get mutliple - possibily conflicting - prints, right?
> 
> Indeed; we ended up removing such prints for the existing options here,
> specifically because multiple messages seemed more likely to be confusing
> than useful.
> 
> > And do we need to have backwards compatibility, such that the setting
> > for iommu.strict or iommu.passthrough trumps iommu.dma_mode, regardless
> > of order?
> 
> As above I think it would be preferable to just keep using the existing
> options anyway. The current behaviour works out as:
> 
> iommu.passthrough |      Y	|	  N
> iommu.strict	  |      x	|    Y         N
> ------------------|-------------|---------|--------
> MODE		  | PASSTHROUGH | STRICT  |  LAZY
> 
> which seems intuitive enough that a specific dma_mode option doesn't add
> much value, and would more likely just overcomplicate things for users as
> well as our implementation.

Agreed. We can't remove the existing options, and they do the job perfectly
well so I don't see the need to add more options on top.

Will
