From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] iommu/s390: add iommu api for s390 pci devices
Date: Tue, 6 Oct 2015 12:22:16 +0200
Message-ID: <20151006102216.GB20886@8bytes.org>
References: <1440682383-27688-1-git-send-email-gerald.schaefer@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1440682383-27688-1-git-send-email-gerald.schaefer@de.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
To: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Cc: iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Sebastian Ott <sebott@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-Id: iommu@lists.linux-foundation.org

On Thu, Aug 27, 2015 at 03:33:03PM +0200, Gerald Schaefer wrote:
> This adds an IOMMU API implementation for s390 PCI devices.
> 
> Reviewed-by: Sebastian Ott <sebott@linux.vnet.ibm.com>
> Signed-off-by: Gerald Schaefer <gerald.schaefer@de.ibm.com>
> ---
>  MAINTAINERS                     |   7 +
>  arch/s390/Kconfig               |   1 +
>  arch/s390/include/asm/pci.h     |   4 +
>  arch/s390/include/asm/pci_dma.h |   5 +-
>  arch/s390/pci/pci_dma.c         |  37 +++--
>  drivers/iommu/Kconfig           |   7 +
>  drivers/iommu/Makefile          |   1 +
>  drivers/iommu/s390-iommu.c      | 337 ++++++++++++++++++++++++++++++++++++++++
>  8 files changed, 386 insertions(+), 13 deletions(-)
>  create mode 100644 drivers/iommu/s390-iommu.c

Applied, thanks.
