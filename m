From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/3] HYPERV/IOMMU: Add Hyper-V stub IOMMU driver
Date: Thu, 31 Jan 2019 12:59:44 +0100
Message-ID: <20190131115944.GB19969@kroah.com>
References: <1548929853-25877-1-git-send-email-Tianyu.Lan@microsoft.com>
 <1548929853-25877-3-git-send-email-Tianyu.Lan@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1548929853-25877-3-git-send-email-Tianyu.Lan@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lantianyu1986@gmail.com
Cc: Lan Tianyu <Tianyu.Lan@microsoft.com>, joro@8bytes.org, mchehab+samsung@kernel.org, davem@davemloft.net, akpm@linux-foundation.org, nicolas.ferre@microchip.com, arnd@arndb.de, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, michael.h.kelley@microsoft.com, kys@microsoft.com, vkuznets@redhat.com, alex.williamson@redhat.com
List-Id: iommu@lists.linux-foundation.org

On Thu, Jan 31, 2019 at 06:17:32PM +0800, lantianyu1986@gmail.com wrote:
> --- /dev/null
> +++ b/drivers/iommu/hyperv-iommu.c
> @@ -0,0 +1,189 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#define pr_fmt(fmt)     "HYPERV-IR: " fmt

Minor nit, you never do any pr_*() calls, so this isn't needed, right?

> +static cpumask_t ioapic_max_cpumask = { CPU_BITS_NONE };
> +struct irq_domain *ioapic_ir_domain;

Global?  Why?

thanks,

greg k-h
