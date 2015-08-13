From: Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH v3 01/11] iommu/vt-d: Cache PCI ATS state and Invalidate
 Queue Depth
Date: Thu, 13 Aug 2015 09:53:33 +0200
Message-ID: <20150813075333.GF12342@suse.de>
References: <20150811154525.21078.85310.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20150811155107.21078.24884.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150811155107.21078.24884.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, Gregor Dick <gdick@solarflare.com>, iommu@lists.linux-foundation.org, Yinghai Lu <yinghai@kernel.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Aug 11, 2015 at 10:51:07AM -0500, Bjorn Helgaas wrote:
> We check the ATS state (enabled/disabled) and fetch the PCI ATS Invalidate
> Queue Depth in performance-sensitive paths.  It's easy to cache these,
> which removes dependencies on PCI.
> 
> Remember the ATS enabled state.  When enabling, read the queue depth once
> and cache it in the device_domain_info struct.  This is similar to what
> amd_iommu.c does.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/iommu/intel-iommu.c |   28 ++++++++++++++++++----------
>  1 file changed, 18 insertions(+), 10 deletions(-)

Reviewed-by: Joerg Roedel <jroedel@suse.de>
Acked-by: Joerg Roedel <jroedel@suse.de>
