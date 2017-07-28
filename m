From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v8 10/13] iommu/amd: Allocate memory below 4G for dev
 table if translation pre-enabled
Date: Fri, 28 Jul 2017 19:15:53 +0800
Message-ID: <20170728111553.GR24304@x1>
References: <1500627551-12930-1-git-send-email-bhe@redhat.com>
 <1500627551-12930-11-git-send-email-bhe@redhat.com>
 <20170727155550.GO3610@suse.de>
 <20170728090619.GM24304@x1>
 <20170728111439.GB3431@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170728111439.GB3431@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <jroedel@suse.de>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On 07/28/17 at 01:14pm, Joerg Roedel wrote:
> On Fri, Jul 28, 2017 at 05:06:19PM +0800, Baoquan He wrote:
> > Do you mean the allocation of amd_iommu_dev_table in
> > early_amd_iommu_init() also need be addressed for 1st kernel? Seems we
> > don't make sure that for 1st kernel, like adding GFP_DMA32 flag when
> > allocate amd_iommu_dev_table in amd_iommu_dev_table
> > early_amd_iommu_init().
> 
> Yes, exactly, the first device table also needs to be allocated with
> GFP_DMA32 so that it ends up below 4GB.

Got it, will do. Thanks!
