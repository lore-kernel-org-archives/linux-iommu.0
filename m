From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFC v3 00/10] KVM PCIe/MSI passthrough on ARM/ARM64 and IOVA
	reserved regions
Date: Wed, 30 Nov 2016 10:37:14 +0000
Message-ID: <20161130103713.GB2724@arm.com>
References: <1479215363-2898-1-git-send-email-eric.auger@redhat.com>
	<6c9012fd-070b-6218-48e7-69b37f2559dd@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <6c9012fd-070b-6218-48e7-69b37f2559dd-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Auger Eric <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: drjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, punit.agrawal-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, pranav.sawargaonkar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, eric.auger.pro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Nov 30, 2016 at 10:49:33AM +0100, Auger Eric wrote:
> On 15/11/2016 14:09, Eric Auger wrote:
> > Following LPC discussions, we now report reserved regions through
> > iommu-group sysfs reserved_regions attribute file.
> > 
> > Reserved regions are populated through the IOMMU get_resv_region callback
> > (former get_dm_regions), now implemented by amd-iommu, intel-iommu and
> > arm-smmu.
> > 
> > The intel-iommu reports the [FEE0_0000h - FEF0_000h] MSI window as an
> > IOMMU_RESV_NOMAP reserved region.
> > 
> > arm-smmu reports the MSI window (arbitrarily located at 0x8000000 and
> > 1MB large) and the PCI host bridge windows.
> > 
> > The series integrates a not officially posted patch from Robin:
> > "iommu/dma: Allow MSI-only cookies".
> > 
> > This series currently does not address IRQ safety assessment.
> 
> I will respin this series taking into account Joerg's comment. Does
> anyone have additional comments or want to put forward some conceptual
> issues with the current direction and with this implementation?
> 
> As for the IRQ safety assessment, in a first step I would propose to
> remove the IOMMU_CAP_INTR_REMAP from arm-smmus and consider the
> assignment as unsafe. Any objection?

Well, yeah, because it's perfectly safe with GICv3.

Will
