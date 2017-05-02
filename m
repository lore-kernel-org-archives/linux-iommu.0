From: Auger Eric <eric.auger@redhat.com>
Subject: userspace emulated smmu/vfio integration: how to trap updates to the
 table structures?
Date: Tue, 2 May 2017 09:30:39 +0200
Message-ID: <52559520-f311-71de-a849-cac83d0c0e81@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
To: Will Deacon <Will.Deacon@arm.com>, Robin Murphy <robin.murphy@arm.com>, Jean-Philippe Brucker <Jean-Philippe.Brucker@arm.com>
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Christoffer Dall <christoffer.dall@linaro.org>, Marc Zyngier <Marc.Zyngier@arm.com>, Alex Williamson <alex.williamson@redhat.com>, Peter Xu <peterx@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Andrew Jones <drjones@redhat.com>
List-Id: iommu@lists.linux-foundation.org

Hi Will, Robin, Jean-Philippe,

I have been working on the integration between user-space emulated
SMMU-v3 and VFIO in QEMU. At the moment I fail identifying a proper easy
way to trap page table updates. This is requested to keep the host
translation structures consistent to guest translation structures.

On Intel VTD there is a so-called "caching mode" (CM, see VTD spec
paragraph 6.1) that forces the OS to explicitly invalidate caches
whenever it updates any remapping structure (updates to not-present or
present entries). Those invalidation commands are used to trap and
update host structures. This mode was devised for virtualization. I was
not able to find such "caching mode" on ARM SMMU. Is there any?

If not, do you have any other suggestion, I mean, besides the
virtio-based solution.

Thanks

Eric
