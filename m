From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: userspace emulated smmu/vfio integration: how to trap updates to
 the table structures?
Date: Tue, 2 May 2017 18:26:00 +0300
Message-ID: <20170502182248-mutt-send-email-mst@kernel.org>
References: <52559520-f311-71de-a849-cac83d0c0e81@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <52559520-f311-71de-a849-cac83d0c0e81@redhat.com>
Sender: kvm-owner@vger.kernel.org
To: Auger Eric <eric.auger@redhat.com>
Cc: Will Deacon <Will.Deacon@arm.com>, Robin Murphy <robin.murphy@arm.com>, Jean-Philippe Brucker <Jean-Philippe.Brucker@arm.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Christoffer Dall <christoffer.dall@linaro.org>, Marc Zyngier <Marc.Zyngier@arm.com>, Alex Williamson <alex.williamson@redhat.com>, Peter Xu <peterx@redhat.com>, Andrew Jones <drjones@redhat.com>, qemu-devel@nongnu.org
List-Id: iommu@lists.linux-foundation.org

On Tue, May 02, 2017 at 09:30:39AM +0200, Auger Eric wrote:
> 
> I have been working on the integration between user-space emulated
> SMMU-v3 and VFIO in QEMU. At the moment I fail identifying a proper easy
> way to trap page table updates. This is requested to keep the host
> translation structures consistent to guest translation structures.
> 
> On Intel VTD there is a so-called "caching mode" (CM, see VTD spec
> paragraph 6.1) that forces the OS to explicitly invalidate caches
> whenever it updates any remapping structure (updates to not-present or
> present entries). Those invalidation commands are used to trap and
> update host structures. This mode was devised for virtualization. I was
> not able to find such "caching mode" on ARM SMMU. Is there any?
> 
> If not, do you have any other suggestion, I mean, besides the
> virtio-based solution.

Nothing really prevents us from emulating e.g. an ARM system with
intel's or AMD's IOMMU.  Linux normally isn't building these for
ARM but it's mostly just tweaking the config.

Non-linux guest support might be harder though.

-- 
MST
