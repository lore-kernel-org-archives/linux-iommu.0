From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [RFC v2 8/8] iommu/arm-smmu: implement add_reserved_regions
 callback
Date: Thu, 10 Nov 2016 17:13:31 +0100
Message-ID: <20161110161331.GJ2078@8bytes.org>
References: <1478258646-3117-1-git-send-email-eric.auger@redhat.com>
 <1478258646-3117-9-git-send-email-eric.auger@redhat.com>
 <20161110154606.GH2078@8bytes.org>
 <04ed9694-707d-260b-70c6-f367d292ceca@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <04ed9694-707d-260b-70c6-f367d292ceca@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Auger Eric <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, christoffer.dall@linaro.org, marc.zyngier@arm.com, robin.murphy@arm.com, alex.williamson@redhat.com, will.deacon@arm.com, tglx@linutronix.de, jason@lakedaemon.net, linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org, drjones@redhat.com, linux-kernel@vger.kernel.org, pranav.sawargaonkar@gmail.com, iommu@lists.linux-foundation.org, punit.agrawal@arm.com, diana.craciun@nxp.com
List-Id: iommu@lists.linux-foundation.org

On Thu, Nov 10, 2016 at 04:57:51PM +0100, Auger Eric wrote:
> It does not only serve the purpose to register the MSI IOVA region. We
> also need to allocate an iova_domain where MSI IOVAs will be allocated
> upon the request of the relevant MSI controllers. Do you mean you don't
> like to use the iova allocator for this purpose?

Yes, it looks like the only purpose of iommu_get_dma_msi_region_cookie()
is to get the msi-region information into into the reserved-list.

Why do you need to 'allocate' the MSI region after all? Except for
IOMMU_DOMAIN_DMA domains the iommu-core code does not care about address
allocation. This is up to the users of the domain, which includes that
the user has to take care of the MSI region.

Besides that, 'iommu_get_dma_msi_region_cookie' is a terrible function
name and does not describe at all what the function does or is supposed
to do.


	Joerg
