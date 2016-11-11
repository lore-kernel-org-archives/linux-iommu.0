From: Joerg Roedel <joro@8bytes.org>
Subject: Re: Summary of LPC guest MSI discussion in Santa Fe
Date: Fri, 11 Nov 2016 12:19:44 +0100
Message-ID: <20161111111944.GO2078@8bytes.org>
References: <20161109151709.74927f83@t450s.home>
 <20161109222522.GS17771@arm.com>
 <20161109162458.39594fdb@t450s.home>
 <20161109233847.GT17771@arm.com>
 <20161109165957.62c1eb61@t450s.home>
 <83b6440a-31eb-c1b4-642c-a4c311f37ef2@redhat.com>
 <20161109175517.174e7803@t450s.home>
 <20161110020130.GA19108@arm.com>
 <ddd8af9d-ad8f-78d8-3048-3d640b74470e@redhat.com>
 <20161110104601.0939ba9a@t450s.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161110104601.0939ba9a@t450s.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Auger Eric <eric.auger@redhat.com>, Will Deacon <will.deacon@arm.com>, drjones@redhat.com, Christoffer Dall <christoffer.dall@linaro.org>, jason@lakedaemon.net, kvm@vger.kernel.org, marc.zyngier@arm.com, benh@kernel.crashing.org, punit.agrawal@arm.com, linux-kernel@vger.kernel.org, diana.craciun@nxp.com, iommu@lists.linux-foundation.org, pranav.sawargaonkar@gmail.com, arnd@arndb.de, dwmw@amazon.co.uk, jcm@redhat.com, Don Dutile <ddutile@redhat.com>, tglx@linutronix.de, robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org, eric.auger.pro@gmail.com
List-Id: iommu@lists.linux-foundation.org

On Thu, Nov 10, 2016 at 10:46:01AM -0700, Alex Williamson wrote:
> In the case of x86, we know that DMA mappings overlapping the MSI
> doorbells won't be translated correctly, it's not a valid mapping for
> that range, and therefore the iommu driver backing the IOMMU API
> should describe that reserved range and reject mappings to it.

The drivers actually allow mappings to the MSI region via the IOMMU-API,
and I think it should stay this way also for other reserved ranges.
Address space management is done by the IOMMU-API user already (and has
to be done there nowadays), be it a DMA-API implementation which just
reserves these regions in its address space allocator or be it VFIO with
QEMU, which don't map RAM there anyway. So there is no point of checking
this again in the IOMMU drivers and we can keep that out of the
mapping/unmapping fast-path.

> For PCI devices userspace can examine the topology of the iommu group
> and exclude MMIO ranges of peer devices based on the BARs, which are
> exposed in various places, pci-sysfs as well as /proc/iomem.  For
> non-PCI or MSI controllers... ???

Right, the hardware resources can be examined. But maybe this can be
extended to also cover RMRR ranges? Then we would be able to assign
devices with RMRR mappings to guests.



	Joerg
