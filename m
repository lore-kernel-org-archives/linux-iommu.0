From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v11 0/10] iommu/vt-d: Fix intel vt-d faults in kdump
 kernel
Date: Fri, 29 May 2015 18:21:51 +0200
Message-ID: <20150529162151.GB20384@8bytes.org>
References: <1431337974-545-1-git-send-email-zhen-hual@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1431337974-545-1-git-send-email-zhen-hual@hp.com>
Sender: linux-pci-owner@vger.kernel.org
To: "Li, Zhen-Hua" <zhen-hual@hp.com>
Cc: dwmw2@infradead.org, indou.takao@jp.fujitsu.com, bhe@redhat.com, vgoyal@redhat.com, dyoung@redhat.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, kexec@lists.infradead.org, alex.williamson@redhat.com, ddutile@redhat.com, ishii.hironobu@jp.fujitsu.com, bhelgaas@google.com, doug.hatch@hp.com, jerry.hoemann@hp.com, tom.vaden@hp.com, li.zhang6@hp.com, lisa.mitchell@hp.com, billsumnerlinux@gmail.com, rwright@hp.com
List-Id: iommu@lists.linux-foundation.org

On Mon, May 11, 2015 at 05:52:44PM +0800, Li, Zhen-Hua wrote:
> Li, Zhen-Hua (10):
>   iommu/vt-d: New function to attach domain with id
>   iommu/vt-d: Items required for kdump
>   iommu/vt-d: Function to get existing context entry
>   iommu/vt-d: functions to copy data from old mem
>   iommu/vt-d: Add functions to load and save old re
>   iommu/vt-d: datatypes and functions used for kdump
>   iommu/vt-d: enable kdump support in iommu module
>   iommu/vt-d: assign new page table for dma_map
>   iommu/vt-d: Copy functions for irte
>   iommu/vt-d: Use old irte in kdump kernel
> 
>  drivers/iommu/intel-iommu.c         | 536 ++++++++++++++++++++++++++++++++++--
>  drivers/iommu/intel_irq_remapping.c |  96 ++++++-
>  include/linux/intel-iommu.h         |  16 ++
>  3 files changed, 623 insertions(+), 25 deletions(-)

Applied with a few minor changes, thanks.
