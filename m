From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH] iommu/vt-d: Handle hotplug devices' default identity
 mapping setting
Date: Fri, 22 Feb 2019 13:30:30 +0800
Message-ID: <fe6dcb4e-03c4-0bbf-c51f-5964b20593dd@linux.intel.com>
References: <20190222024455.20802-1-xmdong@google.com>
 <cf965dec-1bae-1d98-e97c-6a84c0c9862f@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cf965dec-1bae-1d98-e97c-6a84c0c9862f@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: James Dong <xmdong@google.com>, David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>
Cc: baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Jis Ben <jisben@google.com>
List-Id: iommu@lists.linux-foundation.org

Hi

On 2/22/19 1:06 PM, Lu Baolu wrote:

> Do you mind checking this?
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 6ecdcf8fc8c0..f62f30bc1339 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -2632,6 +2632,9 @@ static struct dmar_domain 
> *find_or_alloc_domain(struct device *dev, int gaw)
>                          goto out;
>          }
> 
> +       if (!iommu_should_identity_map(dev, 0))
> +               return si_domain;
> +
>          /* Allocate and initialize new domain for the device */
>          domain = alloc_domain(0);
>          if (!domain)

Oops! This can't be compiled. Please try below instead if you'd like to.
Sorry about it.

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 6ecdcf8fc8c0..b89f5ba6a3c8 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -174,6 +174,8 @@ static inline unsigned long virt_to_dma_pfn(void *p)
         return page_to_dma_pfn(virt_to_page(p));
  }

+static int iommu_should_identity_map(struct device *dev, int startup);
+
  /* global iommu list, set NULL for ignored DMAR units */
  static struct intel_iommu **g_iommus;

@@ -2632,6 +2634,9 @@ static struct dmar_domain 
*find_or_alloc_domain(struct device *dev, int gaw)
                         goto out;
         }

+       if (iommu_should_identity_map(dev, 0))
+               return si_domain;
+
         /* Allocate and initialize new domain for the device */
         domain = alloc_domain(0);
         if (!domain)

Best regards,
Lu Baolu
