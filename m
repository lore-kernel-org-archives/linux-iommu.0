From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 09/16] driver core: add iommu device fault reporting
 data
Date: Fri, 6 Oct 2017 00:11:45 -0700
Message-ID: <20171006071145.GA24354@infradead.org>
References: <1507244624-39189-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1507244624-39189-10-git-send-email-jacob.jun.pan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1507244624-39189-10-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, Lan Tianyu <tianyu.lan@intel.com>
List-Id: iommu@lists.linux-foundation.org

On Thu, Oct 05, 2017 at 04:03:37PM -0700, Jacob Pan wrote:
> DMA faults can be detected by IOMMU at device level. Adding a pointer
> to struct device allows IOMMU subsystem to report relevant faults
> back to the device driver for further handling.
> For direct assigned device (or user space drivers), guest OS holds
> responsibility to handle and respond per device IOMMU fault.
> Therefore we need fault reporting mechanism to propagate faults beyond
> IOMMU subsystem.

We use struct device all over the system, and I don't think we should
bloat it for fringe case IOMMU bits.

Someone really needs to take a step back and figure out how to move
this into a structure that's only allocated for device that actually
can do physical DMA (and/or have an iommu attached)

This is the 3rd iommu field, in addition to 8 dma-specific fields
that we carry around for each struct device.
