From: Auger Eric <eric.auger@redhat.com>
Subject: Re: [RFC v2 8/8] iommu/arm-smmu: implement add_reserved_regions
 callback
Date: Fri, 11 Nov 2016 16:47:01 +0100
Message-ID: <79da09b8-ac1e-cebf-5393-7d67f002b3e3@redhat.com>
References: <1478258646-3117-1-git-send-email-eric.auger@redhat.com>
 <1478258646-3117-9-git-send-email-eric.auger@redhat.com>
 <20161110154606.GH2078@8bytes.org>
 <04ed9694-707d-260b-70c6-f367d292ceca@redhat.com>
 <20161110161331.GJ2078@8bytes.org>
 <f4537e43-0237-e478-eacd-b107458628b8@redhat.com>
 <20161111114223.GP2078@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161111114223.GP2078@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: drjones@redhat.com, jason@lakedaemon.net, kvm@vger.kernel.org, marc.zyngier@arm.com, punit.agrawal@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, diana.craciun@nxp.com, alex.williamson@redhat.com, pranav.sawargaonkar@gmail.com, linux-arm-kernel@lists.infradead.org, tglx@linutronix.de, robin.murphy@arm.com, christoffer.dall@linaro.org, eric.auger.pro@gmail.com
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

On 11/11/2016 12:42, Joerg Roedel wrote:
> On Thu, Nov 10, 2016 at 07:00:52PM +0100, Auger Eric wrote:
>> GICv2m and GICV3 ITS use dma-mapping iommu_dma_map_msi_msg to allocate
>> an MSI IOVA on-demand.
> 
> Yes, and it the right thing to do there because as a DMA-API
> implementation the dma-iommu code cares about the address space
> allocation.
> 
> As I understand it this is different in your case, as someone else is
> defining the address space layout. So why do you need to allocate it
> yourself?
Effectively in passthrough use case, the userspace defines the address
space layout and maps guest RAM PA=IOVA to PAs (using
VFIO_IOMMU_MAP_DMA). But this address space does not comprise the MSI
IOVAs. Userspace does not care about MSI IOMMU mapping. So the MSI IOVA
region must be allocated by either the VFIO driver or the IOMMU driver I
think. Who else could initialize the IOVA allocator domain?

That's true that we have a mix of unmanaged addresses and "managed"
addresses which is not neat. But how to manage otherwise?

Thanks

Eric
> 
> 
> 	Joerg
> 
