From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v14 00/16] KVM PCIe/MSI passthrough on ARM/ARM64
Date: Thu, 20 Oct 2016 18:32:24 +0100
Message-ID: <20161020173224.GA32544@arm.com>
References: <1476278544-3397-1-git-send-email-eric.auger@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1476278544-3397-1-git-send-email-eric.auger@redhat.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Eric Auger <eric.auger@redhat.com>
Cc: yehuday@marvell.com, drjones@redhat.com, jason@lakedaemon.net, kvm@vger.kernel.org, marc.zyngier@arm.com, joro@8bytes.org, p.fedin@samsung.com, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Bharat.Bhushan@freescale.com, Jean-Philippe.Brucker@arm.com, alex.williamson@redhat.com, pranav.sawargaonkar@gmail.com, linux-arm-kernel@lists.infradead.org, tglx@linutronix.de, robin.murphy@arm.com, Manish.Jaggi@caviumnetworks.com, christoffer.dall@linaro.org, eric.auger.pro@gmail.com
List-Id: iommu@lists.linux-foundation.org

Hi Eric,

Thanks for posting this.

On Wed, Oct 12, 2016 at 01:22:08PM +0000, Eric Auger wrote:
> This is the second respin on top of Robin's series [1], addressing Alex' comments.
> 
> Major changes are:
> - MSI-doorbell API now is moved to DMA IOMMU API following Alex suggestion
>   to put all API pieces at the same place (so eventually in the IOMMU
>   subsystem)
> - new iommu_domain_msi_resv struct and accessor through DOMAIN_ATTR_MSI_RESV
>   domain with mirror VFIO capability
> - more robustness I think in the VFIO layer
> - added "iommu/iova: fix __alloc_and_insert_iova_range" since with the current
>   code I failed allocating an IOVA page in a single page domain with upper part
>   reserved
> 
> IOVA range exclusion will be handled in a separate series
> 
> The priority really is to discuss and freeze the API and especially the MSI
> doorbell's handling. Do we agree to put that in DMA IOMMU?
> 
> Note: the size computation does not take into account possible page overlaps
> between doorbells but it would add quite a lot of complexity i think.
> 
> Tested on AMD Overdrive (single GICv2m frame) with I350 VF assignment.

Marc, Robin and I sat down and had a look at the series and, whilst it's
certainly addressing a problem that we desperately want to see fixed, we
think that it's slightly over-engineering in places and could probably
be simplified in the interest of getting something upstream that can be
used as a base, on which the ABI can be extended as concrete use-cases
become clear.

Stepping back a minute, we're trying to reserve some of the VFIO virtual
address space so that it can be used by devices to map their MSI doorbells
using the SMMU. With your patches, this requires that (a) the kernel
tells userspace about the size and alignment of the doorbell region
(MSI_RESV) and (b) userspace tells the kernel the VA-range that can be
used (RESERVED_MSI_IOVA).

However, this is all special-cased for MSI doorbells and there are
potentially other regions of the VFIO address space that are reserved
and need to be communicated to userspace as well. We already know of
hardware where the PCI RC intercepts p2p accesses before they make it
to the SMMU, and other hardware where the MSI doorbell is at a fixed
address. This means that we need a mechanism to communicate *fixed*
regions of virtual address space that are reserved by VFIO. I don't
even particularly care if VFIO_MAP_DMA enforces that, but we do need
a way to tell userspace "hey, you don't want to put memory here because
it won't work well with devices".

In that case, we end up with something like your MSI_RESV capability,
but actually specifying a virtual address range that is simply not to
be used by MAP_DMA -- we don't say anything about MSIs. Now, taking this
to its logical conclusion, we no longer need to distinguish between
remappable reserved regions and fixed reserved regions in the ABI.
Instead, we can have the kernel allocate the virtual address space for
the remappable reserved regions (probably somewhere in the bottom 4GB)
and expose them via the capability. This simplifies things in the
following ways:

  * You don't need to keep track of MSI vs DMA addresses in the VFIO rbtree
  * You don't need to try collapsing doorbells into a single region
  * You don't need a special MAP flavour to map MSI doorbells
  * The ABI is reusable for PCI p2p and fixed doorbells

I really think it would make your patch series both generally useful and
an awful lot smaller, whilst leaving the door open to ABI extension on
a case-by-case basis when we determine that it's really needed.

Thoughts?

Will
