From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [RFC PATCH 22/30] iommu: Bind/unbind tasks to/from devices
Date: Wed, 22 Mar 2017 16:36:10 +0100
Message-ID: <20170322153610.GC7266@8bytes.org>
References: <20170227195441.5170-1-jean-philippe.brucker@arm.com>
 <20170227195441.5170-23-jean-philippe.brucker@arm.com>
 <1488534044.6234.14.camel@infradead.org>
 <20170303183958.GA15146@e106794-lin.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170303183958.GA15146@e106794-lin.localdomain>
Sender: linux-pci-owner@vger.kernel.org
To: Jean-Philippe Brucker <Jean-Philippe.Brucker@arm.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Harv Abdulhamid <harba@qti.qualcomm.com>, Will Deacon <will.deacon@arm.com>, Shanker Donthineni <shankerd@qti.qualcomm.com>, Bjorn Helgaas <bhelgaas@google.com>, Sinan Kaya <okaya@qti.qualcomm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Robin Murphy <robin.murphy@arm.com>, Nate Watterson <nwatters@qti.qualcomm.com>, Alex Williamson <alex.williamson@redhat.com>, linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org, kvm@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Mar 03, 2017 at 06:39:58PM +0000, Jean-Philippe Brucker wrote:
> Yes, it would be nice to have a common PASID allocator. But I don't
> think that a system-wide PASID space is workable for us. At the moment
> systems might have a few identical devices all supporting 20 bits of
> PASID. But consider the case where one odd device can only handle four
> address spaces, and supports a maximum of two PASID bits. We'd quickly
> run out of PASIDs to hand to such devices, even though we could easily
> have one PASID space per endpoint (from a quick glance at the specs, I
> assume that both Intel and AMD IOMMUs offer one PASID table per RID.)

But that shouldn't be a problem if we allocate PASIDs top-down (meaning
starting from the biggest value supported by a given device), right?

Then we can satisfy the devices with 16 or 20 bit PASIDs and still have
the 2-bit PASIDs free for the devices that need it.



	Joerg
