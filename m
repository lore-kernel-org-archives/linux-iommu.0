From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH] iommu/vt-d: Handle hotplug devices' default identity
 mapping setting
Date: Fri, 22 Feb 2019 15:42:02 +0800
Message-ID: <21c17b44-af9b-2f18-f109-ba4bb0635e61@linux.intel.com>
References: <20190222024455.20802-1-xmdong@google.com>
 <cf965dec-1bae-1d98-e97c-6a84c0c9862f@linux.intel.com>
 <fe6dcb4e-03c4-0bbf-c51f-5964b20593dd@linux.intel.com>
 <CADcZez2q7aUL=ahHSGnfO2QDjKL052AePd=TsxkCK-O7EcW77Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CADcZez2q7aUL=ahHSGnfO2QDjKL052AePd=TsxkCK-O7EcW77Q@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: James Dong <xmdong@google.com>
Cc: baolu.lu@linux.intel.com, David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Jis Ben <jisben@google.com>
List-Id: iommu@lists.linux-foundation.org

Hi James,

On 2/22/19 2:38 PM, James Dong wrote:
> 
> Tried this patch, and the same DMAR fault message came out.
> 
> Guess it is because of the iommu code path for hotplug devices. If a hotplug
> device is rescanned after removal, iommu_bus_notifier will be called as part
> of the notifier chains to handle BUS_NOTIFY_ADD_DEVICE event. Along the code
> path, intel_iommu_ops->add_device() created an iommu group for this hotplug
> device, but failed to create an iommu domain because of the default domain
> type IOMMU_DOMAIN_IDENTITY imposed by current IOMMU command line option got
> declined by intel_iommu_ops->domain_alloc().
> 
> In your patch, function find_or_alloc_domain() is not even in the code path
> of BUS_NOTIFY_ADD_DEVICE event notifier chain.
> 
> Please let us know if your have more concerns and suggestions.

Can I reproduce this with a local machine? If so, how should I do?

> 
> Best Regards,
> James

Best regards,
Lu Baolu
