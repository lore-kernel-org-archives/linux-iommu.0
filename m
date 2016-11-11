From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [RFC v2 8/8] iommu/arm-smmu: implement add_reserved_regions
 callback
Date: Fri, 11 Nov 2016 17:22:11 +0100
Message-ID: <20161111162211.GU2078@8bytes.org>
References: <1478258646-3117-1-git-send-email-eric.auger@redhat.com>
 <1478258646-3117-9-git-send-email-eric.auger@redhat.com>
 <20161110154606.GH2078@8bytes.org>
 <04ed9694-707d-260b-70c6-f367d292ceca@redhat.com>
 <20161110161331.GJ2078@8bytes.org>
 <f4537e43-0237-e478-eacd-b107458628b8@redhat.com>
 <20161111114223.GP2078@8bytes.org>
 <79da09b8-ac1e-cebf-5393-7d67f002b3e3@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <79da09b8-ac1e-cebf-5393-7d67f002b3e3@redhat.com>
Sender: kvm-owner@vger.kernel.org
To: Auger Eric <eric.auger@redhat.com>
Cc: drjones@redhat.com, jason@lakedaemon.net, kvm@vger.kernel.org, marc.zyngier@arm.com, punit.agrawal@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, diana.craciun@nxp.com, alex.williamson@redhat.com, pranav.sawargaonkar@gmail.com, linux-arm-kernel@lists.infradead.org, tglx@linutronix.de, robin.murphy@arm.com, christoffer.dall@linaro.org, eric.auger.pro@gmail.com
List-Id: iommu@lists.linux-foundation.org

Hi Eric,

On Fri, Nov 11, 2016 at 04:47:01PM +0100, Auger Eric wrote:
> Effectively in passthrough use case, the userspace defines the address
> space layout and maps guest RAM PA=IOVA to PAs (using
> VFIO_IOMMU_MAP_DMA). But this address space does not comprise the MSI
> IOVAs. Userspace does not care about MSI IOMMU mapping. So the MSI IOVA
> region must be allocated by either the VFIO driver or the IOMMU driver I
> think. Who else could initialize the IOVA allocator domain?

So I think we need a way to tell userspace about the reserved regions
(per iommu-group) so that userspace knows where it can not map anything,
and VFIO can enforce that. But the right struct here is not an
iova-allocator rb-tree, a ordered linked list should be sufficient.


	Joerg

