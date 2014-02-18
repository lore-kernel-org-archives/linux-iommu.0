From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [GIT PULL] iommu/arm-smmu: fixes for 3.14
Date: Tue, 18 Feb 2014 18:36:26 +0000
Message-ID: <20140218183626.GC2010@mudshark.cambridge.arm.com>
References: <20140210183232.GH12826@mudshark.cambridge.arm.com>
	<20140218175027.GE11432@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140218175027.GE11432-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

On Tue, Feb 18, 2014 at 05:50:27PM +0000, Joerg Roedel wrote:
> On Mon, Feb 10, 2014 at 06:32:32PM +0000, Will Deacon wrote:
> >   - Andreas Herrmann took the driver for a run with a real SATA
> >     controller, which caused the new mutex-based locking to explode
> >     since we require mappings in atomic context
> 
> I just did quick review of the changes. Was the SATA controller using
> the IOMMU through the DMA-API? In this case you would need the IRQ-safe
> spinlocks to avoid dead-locks because the DMA-API can be used from
> IRQ-context.

Unfortunately, I don't know and since Calxeda has ceased to be, Andreas is
no longer working on this (I suspect his email address also bounces).

I can send an additional patch using spin_*_irq{save,restore} for the
domain->lock if you like?

Will
