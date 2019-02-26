From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v3 0/2] Add PGR response PASID requirement check in Intel
 IOMMU.
Date: Tue, 26 Feb 2019 11:07:30 +0100
Message-ID: <20190226100729.GB20740@8bytes.org>
References: <cover.1550602470.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1550602470.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: sathyanarayanan.kuppuswamy@linux.intel.com
Cc: bhelgaas@google.com, dwmw2@infradead.org, linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, ashok.raj@intel.com, jacob.jun.pan@intel.com, keith.busch@intel.com
List-Id: iommu@lists.linux-foundation.org

On Tue, Feb 19, 2019 at 11:04:50AM -0800, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> Kuppuswamy Sathyanarayanan (2):
>   PCI/ATS: Add pci_prg_resp_pasid_required() interface.
>   iommu/vt-d: Fix PRI/PASID dependency issue.
> 
>  drivers/iommu/intel-iommu.c   |  4 +++-
>  drivers/pci/ats.c             | 30 ++++++++++++++++++++++++++++++
>  include/linux/pci-ats.h       |  5 +++++
>  include/uapi/linux/pci_regs.h |  1 +
>  4 files changed, 39 insertions(+), 1 deletion(-)

Applied, thanks.
