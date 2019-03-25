From: "joro@8bytes.org" <joro@8bytes.org>
Subject: Re: [PATCH] svm/avic: iommu/amd: Flush IOMMU IRT after update all
 entries
Date: Mon, 25 Mar 2019 14:46:01 +0100
Message-ID: <20190325134601.GB25350@8bytes.org>
References: <20190320081432.2606-1-suravee.suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190320081432.2606-1-suravee.suthikulpanit@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "rkrcmar@redhat.com" <rkrcmar@redhat.com>
List-Id: iommu@lists.linux-foundation.org

On Wed, Mar 20, 2019 at 08:14:56AM +0000, Suthikulpanit, Suravee wrote:
> When AVIC is enabled and the VM has discrete device assignment,
> the interrupt remapping table (IRT) is used to keep track of which
> destination APIC ID the IOMMU will inject the device interrput to.
> 
> This means every time a vcpu is blocked or context-switched (i.e.
> vcpu_blocking/unblocking() and vcpu_load/put()), the information
> in IRT must be updated and the IOMMU IRT flush command must be
> issued.
> 
> The current implementation flushes IOMMU IRT every time an entry
> is modified. If the assigned device has large number of interrupts
> (hence large number of entries), this would add large amount of
> overhead to vcpu context-switch. Instead, this can be optmized by
> only flush IRT once per vcpu context-switch per device after all
> IRT entries are modified.
> 
> The function amd_iommu_update_ga() is refactored to only update
> IRT entry, while the amd_iommu_sync_ga() is introduced to allow
> IRT flushing to be done separately.
> 
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  arch/x86/kvm/svm.c        | 35 ++++++++++++++++++++++++++++++++++-
>  drivers/iommu/amd_iommu.c | 20 +++++++++++++++++---
>  include/linux/amd-iommu.h | 13 ++++++++++---
>  3 files changed, 61 insertions(+), 7 deletions(-)

For the IOMMU parts:

	Acked-by: Joerg Roedel <jroedel@suse.de>
