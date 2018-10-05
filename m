From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] iommu/amd: Clear memory encryption mask from physical
 address
Date: Fri, 5 Oct 2018 10:31:01 +0200
Message-ID: <20181005083101.GD3630@8bytes.org>
References: <1538689210-14524-1-git-send-email-brijesh.singh@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1538689210-14524-1-git-send-email-brijesh.singh@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Singh, Brijesh" <brijesh.singh@amd.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, Borislav Petkov <bp@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, "# 4 . 14+" <stable@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Oct 04, 2018 at 09:40:23PM +0000, Singh, Brijesh wrote:
> Boris Ostrovsky reported a memory leak with device passthrough when SME
> is active.
> 
> The VFIO driver uses iommu_iova_to_phys() to get the physical address for
> an iova. This physical address is later passed into vfio_unmap_unpin() to
> unpin the memory. The vfio_unmap_unpin() uses pfn_valid() before unpinning
> the memory. The pfn_valid() check was failing because encryption mask was
> part of the physical address returned. This resulted in the memory not
> being unpinned and therefore leaked after the guest terminates.
> 
> The memory encryption mask must be cleared from the physical address in
> iommu_iova_to_phys().

Merged and on its way upstream, thanks Brijesh.
