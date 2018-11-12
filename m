From: "Raj, Ashok" <ashok.raj@intel.com>
Subject: Re: [PATCH 2/4] iommu/vt-d: Force IOMMU on for platform opt in hint
Date: Mon, 12 Nov 2018 09:49:36 -0800
Message-ID: <20181112174936.GB30341@araj-mobl1.jf.intel.com>
References: <20181112160628.86620-1-mika.westerberg@linux.intel.com>
 <20181112160628.86620-3-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181112160628.86620-3-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, Bjorn Helgaas <bhelgaas@google.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jacob jun Pan <jacob.jun.pan@intel.com>, Andreas Noever <andreas.noever@gmail.com>, Michael Jamet <michael.jamet@intel.com>, Yehezkel Bernat <YehezkelShB@gmail.com>, Lukas Wunner <lukas@wunner.de>, Christian Kellner <ckellner@redhat.com>, Mario.Limonciello@dell.com, Anthony Wong <anthony.wong@canonical.com>, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Ashok Raj <ashok.raj@intel.com>
List-Id: iommu@lists.linux-foundation.org

On Mon, Nov 12, 2018 at 07:06:26PM +0300, Mika Westerberg wrote:
> From: Lu Baolu <baolu.lu@linux.intel.com>
> 
> Intel VT-d spec added a new DMA_CTRL_PLATFORM_OPT_IN_FLAG flag
> in DMAR ACPI table for BIOS to report compliance about platform
> initiated DMA restricted to RMRR ranges when transferring control
> to the OS. The OS treats this as a hint that the IOMMU should be
> enabled to prevent DMA attacks from possible malicious devices.
> 
> A use of this flag is Kernel DMA protection for Thunderbolt[1]
> which in practice means that IOMMU should be enabled for PCIe
> devices connected to the Thunderbolt ports. With IOMMU enabled
> for these devices, all DMA operations are limited in the range
> reserved for it, thus the DMA attacks are prevented. All these
> devices are enumerated in the PCI/PCIe module and marked with
> an is_external flag.
> 
> This forces IOMMU to be enabled if DMA_CTRL_PLATFORM_OPT_IN_FLAG
> is set in DMAR ACPI table and there are PCIe devices marked as
> is_external in the system. This can be turned off by adding
> "intel_iommu=off" in the kernel command line, if any problems are
> found.
> 
> [1] https://docs.microsoft.com/en-us/windows/security/information-protection/kernel-dma-protection-for-thunderbolt
> 
> Cc: Ashok Raj <ashok.raj@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Sohil Mehta <sohil.mehta@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Looks good to me

Reviewed-by: Ashok Raj <ashok.raj@intel.com>

> ---
>  drivers/iommu/dmar.c        | 25 +++++++++++++++++
>  drivers/iommu/intel-iommu.c | 55 +++++++++++++++++++++++++++++++++++--
>  include/linux/dmar.h        |  8 ++++++
>  3 files changed, 86 insertions(+), 2 deletions(-)
 
