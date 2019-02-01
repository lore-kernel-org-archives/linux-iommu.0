From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 2/3] HYPERV/IOMMU: Add Hyper-V stub IOMMU driver
Date: Fri, 1 Feb 2019 17:34:43 +0100
Message-ID: <20190201163443.GS32526@8bytes.org>
References: <1548929853-25877-1-git-send-email-Tianyu.Lan@microsoft.com>
 <1548929853-25877-3-git-send-email-Tianyu.Lan@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1548929853-25877-3-git-send-email-Tianyu.Lan@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lantianyu1986@gmail.com
Cc: Lan Tianyu <Tianyu.Lan@microsoft.com>, mchehab+samsung@kernel.org, davem@davemloft.net, gregkh@linuxfoundation.org, akpm@linux-foundation.org, nicolas.ferre@microchip.com, arnd@arndb.de, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, michael.h.kelley@microsoft.com, kys@microsoft.com, vkuznets@redhat.com, alex.williamson@redhat.com
List-Id: iommu@lists.linux-foundation.org

Hi,

On Thu, Jan 31, 2019 at 06:17:32PM +0800, lantianyu1986@gmail.com wrote:
> +config HYPERV_IOMMU
> +	bool "Hyper-V stub IOMMU support"

This is not a real IOMMU driver, it only implements IRQ remapping
capabilities. Please change the name to reflect that, e.g. to
"Hyper-V IRQ Remapping Support" or something like that.

> +static int __init hyperv_prepare_irq_remapping(void)
> +{
> +	struct fwnode_handle *fn;
> +	u32 apic_id;
> +	int i;
> +
> +	if (x86_hyper_type != X86_HYPER_MS_HYPERV ||
> +	    !x2apic_supported())
> +		return -ENODEV;
> +
> +	fn = irq_domain_alloc_named_id_fwnode("HYPERV-IR", 0);
> +	if (!fn)
> +		return -EFAULT;

Why does this return -EFAULT? I guess there is no fault happening in
irq_domain_alloc_named_id_fwnode()...


	Joerg
