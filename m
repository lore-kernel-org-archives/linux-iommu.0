Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32B53C05
	for <iommu@lists.linux.dev>; Fri, 21 Apr 2023 13:53:39 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CE2071480;
	Fri, 21 Apr 2023 06:54:22 -0700 (PDT)
Received: from [10.57.23.51] (unknown [10.57.23.51])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 266323F587;
	Fri, 21 Apr 2023 06:53:38 -0700 (PDT)
Message-ID: <c972e852-7630-5843-fabe-59664361df87@arm.com>
Date: Fri, 21 Apr 2023 14:53:33 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] iommu/ipmmu-vmsa: Allow PCIe devices
Content-Language: en-GB
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, joro@8bytes.org,
 will@kernel.org
Cc: iommu@lists.linux.dev, linux-renesas-soc@vger.kernel.org
References: <20230421122538.3389336-1-yoshihiro.shimoda.uh@renesas.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230421122538.3389336-1-yoshihiro.shimoda.uh@renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023-04-21 13:25, Yoshihiro Shimoda wrote:
> Add PCIe devices of R-Car Gen3/4 into devices_allowlist. For a PCI
> device, ipmmu_attach_device() has to avoid enabling uTLB because
> the uTLB has already been enabled by the parent device. Otherwise,
> enable a wrong uTLB ID. Also ipmmu_device_is_allowed() has to
> check whether the parent device is the PCIe host controller or not,
> to use the IOMMU's dma_ops from a PCI device.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>   drivers/iommu/ipmmu-vmsa.c | 21 ++++++++++++++++++++-
>   1 file changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> index 9f64c5c9f5b9..c635c9b192f4 100644
> --- a/drivers/iommu/ipmmu-vmsa.c
> +++ b/drivers/iommu/ipmmu-vmsa.c
> @@ -19,6 +19,7 @@
>   #include <linux/of.h>
>   #include <linux/of_device.h>
>   #include <linux/of_platform.h>
> +#include <linux/pci.h>
>   #include <linux/platform_device.h>
>   #include <linux/sizes.h>
>   #include <linux/slab.h>
> @@ -624,6 +625,10 @@ static int ipmmu_attach_device(struct iommu_domain *io_domain,
>   	if (ret < 0)
>   		return ret;
>   
> +	/* Avoid to enable utlb if this is a PCI device */
> +	if (dev_is_pci(dev))
> +		return 0;

Addressing that "TODO: Reference-count the microTLB..." comment instead 
would be even nicer :)

> +
>   	for (i = 0; i < fwspec->num_ids; ++i)
>   		ipmmu_utlb_enable(domain, fwspec->ids[i]);
>   
> @@ -702,10 +707,14 @@ static const struct soc_device_attribute soc_denylist[] = {
>   };
>   
>   static const char * const devices_allowlist[] = {
> +	"e65d0000.pcie",	/* R-Car Gen4 */
> +	"e65d8000.pcie",	/* R-Car Gen4 */
>   	"ee100000.mmc",
>   	"ee120000.mmc",
>   	"ee140000.mmc",
> -	"ee160000.mmc"
> +	"ee160000.mmc",
> +	"ee800000.pcie",	/* R-Car Gen3 */
> +	"fe000000.pcie",	/* R-Car Gen3 */

This would seem to imply that you have not only an "iommu-map" property 
representing the PCI devices, but also an "iommus" property representing 
that the SoC side of the root complex has its own DMA path to an IOMMU, 
distinct from the traffic coming over the PCI bridge. That can 
occasionally be true (e.g. if the root complex IP includes a standalone 
DMA engine), but more often it's just a mistake.

>   };
>   
>   static bool ipmmu_device_is_allowed(struct device *dev)
> @@ -723,12 +732,22 @@ static bool ipmmu_device_is_allowed(struct device *dev)
>   	if (soc_device_match(soc_denylist))
>   		return false;
>   
> +retry:
>   	/* Check whether this device can work with the IPMMU */
>   	for (i = 0; i < ARRAY_SIZE(devices_allowlist); i++) {
>   		if (!strcmp(dev_name(dev), devices_allowlist[i]))
>   			return true;
>   	}
>   
> +	/*
> +	 * Check whether this device has the parent device like a PCI device
> +	 * except "soc".
> +	 */
> +	if (dev->parent && strcmp(dev_name(dev->parent), "soc")) {
> +		dev = dev->parent;
> +		goto retry;
> +	}

This is the place where a simple dev_is_pci() check would seem ideal.

Thanks,
Robin.

> +
>   	/* Otherwise, do not allow use of IPMMU */
>   	return false;
>   }
