From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v6 0/9] Fix kdump faults on system with amd iommu
Date: Thu, 10 Nov 2016 12:52:18 +0100
Message-ID: <20161110115218.GF9996@8bytes.org>
References: <1476963440-23039-1-git-send-email-bhe@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1476963440-23039-1-git-send-email-bhe@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Baoquan He <bhe@redhat.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, kexec@lists.infradead.org, Vincent.Wan@amd.com, dyoung@redhat.com, xlpang@redhat.com
List-Id: iommu@lists.linux-foundation.org

Hi Baoquan,

thanks for working on this, really appreciated!

On Thu, Oct 20, 2016 at 07:37:11PM +0800, Baoquan He wrote:
> This is v6 post. 
> 
> The principle of the fix is similar to intel iommu. Just defer the assignment
> of device to domain to device driver init. But there's difference than
> intel iommu. AMD iommu create protection domain and assign device to
> domain in iommu driver init stage. So in this patchset I just allow the
> assignment of device to domain in software level, but defer updating the
> domain info, especially the pte_root to dev table entry to device driver
> init stage.

I recently talked with the IOMMU guys from AMD about whether it is safe
to update the device-table pointer while the iommu is enabled. It turns
out that device-table pointer update is split up into two 32bit writes
in the IOMMU hardware. So updating it while the IOMMU is enabled could
have some nasty side effects.

The only way to work around this is to allocate the device-table
below 4GB, but that needs more low-mem then in the kdump kernel. So some
adjustments are needed there too. Anyway, can you add that to your
patch-set?


	Joerg
