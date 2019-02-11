From: sathyanarayanan kuppuswamy
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH v2 0/2] Add page alignment check in Intel IOMMU.
Date: Mon, 11 Feb 2019 13:48:43 -0800
Message-ID: <5c93782e-623c-707a-6fe0-dfe78d14a600@linux.intel.com>
References: <cover.1548726944.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1548726944.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: bhelgaas@google.com, joro@8bytes.org, dwmw2@infradead.org
Cc: linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, ashok.raj@intel.com, jacob.jun.pan@intel.com, keith.busch@intel.com
List-Id: iommu@lists.linux-foundation.org


On 2/11/19 1:43 PM, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>
> As per Intel vt-d specification, Rev 3.0 (section 7.5.1.1, title "Page Request Descriptor"), Intel IOMMU Page Request Descriptor only provides bits[63:12] of the page address. Hence its required to enforce that the device will only send page request with page-aligned address. So, this patch set adds support to verify whether the device uses page aligned address before enabling the ATS service in Intel IOMMU driver.
Please ignore this mail. This is my older copy.
>
> Kuppuswamy Sathyanarayanan (2):
>    PCI: ATS: Add function to check ATS page alignment status.
>    iommu/vt-d: Enable ATS only if the device uses page aligned address.
>
>   drivers/iommu/intel-iommu.c   |  1 +
>   drivers/pci/ats.c             | 24 ++++++++++++++++++++++++
>   include/linux/pci.h           |  2 ++
>   include/uapi/linux/pci_regs.h |  1 +
>   4 files changed, 28 insertions(+)
>
-- 
Sathyanarayanan Kuppuswamy
Linux kernel developer
