From: James Dong <xmdong@google.com>
Subject: RE: [PATCH] iommu/vt-d: Handle hotplug devices' default identity
 mapping setting
Date: Fri, 22 Feb 2019 07:36:58 +0000
Message-ID: <20190222073658.66798-1-xmdong@google.com>
References: <fe6dcb4e-03c4-0bbf-c51f-5964b20593dd@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <fe6dcb4e-03c4-0bbf-c51f-5964b20593dd@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Jis Ben <jisben@google.com>, James Dong <xmdong@google.com>
List-Id: iommu@lists.linux-foundation.org

Baolu:

Sorry that my last reply email seems not text format. Resend it now.

Thanks for your comments and your patch. Please find below our responses to
each of your comments:

> What does "I/O operation won't work" exactly mean here? Do you see any
> IOMMU fault message? Or, something doesn't work as expected?

Yes, DMAR fault messages as following came out:
[  354.939896] DMAR: DMAR:[DMA Read] Request device [03:00.1]fault addr 1fdfe80000 
[  354.939896] DMAR:[fault reason 02] Present bit in context entry is clear


> Do you mind checking this?
>
> index 6ecdcf8fc8c0..f62f30bc1339 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -2632,6 +2632,9 @@ static struct dmar_domain 
> *find_or_alloc_domain(struct device *dev, int gaw)
>                          goto out;
>          }
> 
> +       if (!iommu_should_identity_map(dev, 0))
> +               return si_domain;
> +
>          /* Allocate and initialize new domain for the device */
>          domain = alloc_domain(0);
>          if (!domain)

Tried this patch, and the same DMAR fault message came out.

Guess it is because of the iommu code path for hotplug devices. If a hotplug
device is rescanned after removal, iommu_bus_notifier will be called as part
of the notifier chains to handle BUS_NOTIFY_ADD_DEVICE event. Along the code
path, intel_iommu_ops->add_device() created an iommu group for this hotplug
device, but failed to create an iommu domain because of the default domain
type IOMMU_DOMAIN_IDENTITY imposed by current IOMMU command line option got
declined by intel_iommu_ops->domain_alloc().

Since si_domain is type of "struct dmar_domain", which is platform dependent,
it is hard to make this change in intel_iommu_ops->domain_alloc().

In your patch, function find_or_alloc_domain() is not in the code path of
BUS_NOTIFY_ADD_DEVICE event notifier chain.

Please let us know if your have more concerns and suggestions.

Best Regards,
James
