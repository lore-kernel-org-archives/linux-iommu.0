From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v8 10/13] iommu/amd: Allocate memory below 4G for dev
 table if translation pre-enabled
Date: Fri, 28 Jul 2017 17:06:19 +0800
Message-ID: <20170728090619.GM24304@x1>
References: <1500627551-12930-1-git-send-email-bhe@redhat.com>
 <1500627551-12930-11-git-send-email-bhe@redhat.com>
 <20170727155550.GO3610@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170727155550.GO3610@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <jroedel@suse.de>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

On 07/27/17 at 05:55pm, Joerg Roedel wrote:
> On Fri, Jul 21, 2017 at 04:59:08PM +0800, Baoquan He wrote:
> > AMD pointed out it's unsafe to update the device-table while iommu
> > is enabled. It turns out that device-table pointer update is split
> > up into two 32bit writes in the IOMMU hardware. So updating it while
> > the IOMMU is enabled could have some nasty side effects.
> > 
> > The only way to work around this is to allocate the device-table below
> > 4GB if translation is pre-enabled in kdump kernel. If allocation failed,
> > still use the old one.
> 
> Not only for the kdump kernel. The old device table must also be below
> 4GB so that its pointer can be updated with a 32bit write.
> 
> If the old table is above 4GB you still need the second write to zero
> the upper parts of the pointer in hardware.

Do you mean the allocation of amd_iommu_dev_table in
early_amd_iommu_init() also need be addressed for 1st kernel? Seems we
don't make sure that for 1st kernel, like adding GFP_DMA32 flag when
allocate amd_iommu_dev_table in amd_iommu_dev_table
early_amd_iommu_init().
