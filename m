From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 2/6] DMA-API: Introduce dma_(un)map_resource
Date: Thu, 7 May 2015 10:09:50 -0500
Message-ID: <20150507150950.GK24643@google.com>
References: <1430505138-2877-1-git-send-email-wdavis@nvidia.com>
 <1430505138-2877-3-git-send-email-wdavis@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1430505138-2877-3-git-send-email-wdavis@nvidia.com>
Sender: linux-pci-owner@vger.kernel.org
To: wdavis@nvidia.com
Cc: joro@8bytes.org, iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org, tripperda@nvidia.com, jhubbard@nvidia.com, jglisse@redhat.com
List-Id: iommu@lists.linux-foundation.org

On Fri, May 01, 2015 at 01:32:14PM -0500, wdavis@nvidia.com wrote:
> From: Will Davis <wdavis@nvidia.com>
> 
> Add functions to DMA-map and -unmap a resource for a given device. This
> will allow devices to DMA-map a peer device's resource (for example,
> another device's BAR region on PCI) to enable peer-to-peer transactions.
> 
> Signed-off-by: Will Davis <wdavis@nvidia.com>
> Reviewed-by: Terence Ripperda <tripperda@nvidia.com>
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  include/asm-generic/dma-mapping-broken.h |  9 +++++++++
>  include/asm-generic/dma-mapping-common.h | 34 ++++++++++++++++++++++++++++++++
>  include/linux/dma-mapping.h              |  7 +++++++

You should document these new interfaces in Documentation/DMA-API-*

Bjorn
