From: "Raj, Ashok" <ashok.raj@intel.com>
Subject: Re: [PATCH 3/4] iommu/vt-d: Do not enable ATS for external devices
Date: Mon, 12 Nov 2018 09:53:28 -0800
Message-ID: <20181112175327.GC30341@araj-mobl1.jf.intel.com>
References: <20181112160628.86620-1-mika.westerberg@linux.intel.com>
 <20181112160628.86620-4-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181112160628.86620-4-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, Bjorn Helgaas <bhelgaas@google.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jacob jun Pan <jacob.jun.pan@intel.com>, Andreas Noever <andreas.noever@gmail.com>, Michael Jamet <michael.jamet@intel.com>, Yehezkel Bernat <YehezkelShB@gmail.com>, Lukas Wunner <lukas@wunner.de>, Christian Kellner <ckellner@redhat.com>, Mario.Limonciello@dell.com, Anthony Wong <anthony.wong@canonical.com>, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Nov 12, 2018 at 07:06:27PM +0300, Mika Westerberg wrote:
> Currently Linux automatically enables ATS (Address Translation Service)
> for any device that supports it (and IOMMU is turned on). ATS is used to
> accelerate DMA access as the device can cache translations locally so
> there is no need to do full translation on IOMMU side. However, as
> pointed out in [1] ATS can be used to bypass IOMMU based security
> completely by simply sending PCIe read/write transaction with AT
> (Address Translation) field set to "translated".
> 
> To mitigate this modify the Intel IOMMU code so that it does not enable
> ATS for any device that is marked as being external. In case this turns
> out to cause performance issues we may selectively allow ATS based on
> user decision but currently use big hammer and disable it completely to
> be on the safe side.
> 
> [1] https://www.repository.cam.ac.uk/handle/1810/274352
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Reviewed-by: Ashok Raj <ashok.raj@intel.com>

> ---
>  drivers/iommu/intel-iommu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index ada786b05a59..b79788da6971 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -1473,7 +1473,8 @@ static void iommu_enable_dev_iotlb(struct device_domain_info *info)
>  	if (info->pri_supported && !pci_reset_pri(pdev) && !pci_enable_pri(pdev, 32))
>  		info->pri_enabled = 1;
>  #endif
> -	if (info->ats_supported && !pci_enable_ats(pdev, VTD_PAGE_SHIFT)) {
> +	if (!pdev->is_external && info->ats_supported &&
> +	    !pci_enable_ats(pdev, VTD_PAGE_SHIFT)) {
>  		info->ats_enabled = 1;
>  		domain_update_iotlb(info->domain);
>  		info->ats_qdep = pci_ats_queue_depth(pdev);
> -- 
> 2.19.1
> 
