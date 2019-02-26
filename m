From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v3 0/2] Add page alignment check in Intel IOMMU.
Date: Tue, 26 Feb 2019 11:08:25 +0100
Message-ID: <20190226100825.GC20740@8bytes.org>
References: <cover.1550602392.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1550602392.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: sathyanarayanan.kuppuswamy@linux.intel.com
Cc: bhelgaas@google.com, dwmw2@infradead.org, linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, ashok.raj@intel.com, jacob.jun.pan@intel.com, keith.busch@intel.com
List-Id: iommu@lists.linux-foundation.org

On Tue, Feb 19, 2019 at 11:06:08AM -0800, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> Kuppuswamy Sathyanarayanan (2):
>   PCI/ATS: Add pci_ats_page_aligned() interface
>   iommu/vt-d: Enable ATS only if the device uses page aligned address.
> 
>  drivers/iommu/intel-iommu.c   |  1 +
>  drivers/pci/ats.c             | 27 +++++++++++++++++++++++++++
>  include/linux/pci.h           |  2 ++
>  include/uapi/linux/pci_regs.h |  1 +
>  4 files changed, 31 insertions(+)

Applied, thanks.
