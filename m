From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH/RFC] driver core: Postpone DMA tear-down until after
 devres release
Date: Fri, 8 Feb 2019 17:55:31 +0000
Message-ID: <fa781547-7fa8-cb1a-50bd-d18351c02afd@arm.com>
References: <20190207193653.18221-1-geert+renesas@glider.be>
 <20190208164019.GY32526@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190208164019.GY32526@8bytes.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, "Rafael J . Wysocki" <rafael@kernel.org>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On 08/02/2019 16:40, Joerg Roedel wrote:
> Hi Geert,
> 
> On Thu, Feb 07, 2019 at 08:36:53PM +0100, Geert Uytterhoeven wrote:
>> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
>> index 8ac10af17c0043a3..d62487d024559620 100644
>> --- a/drivers/base/dd.c
>> +++ b/drivers/base/dd.c
>> @@ -968,9 +968,9 @@ static void __device_release_driver(struct device *dev, struct device *parent)
>>   			drv->remove(dev);
>>   
>>   		device_links_driver_cleanup(dev);
>> -		arch_teardown_dma_ops(dev);
>>   
>>   		devres_release_all(dev);
>> +		arch_teardown_dma_ops(dev);
>>   		dev->driver = NULL;
>>   		dev_set_drvdata(dev, NULL);
>>   		if (dev->pm_domain && dev->pm_domain->dismiss)
> 
> Thanks for the fix! Should it also be tagged for stable and get a Fixes
> tag? I know it only triggers with a fix in v5.0-rc, but still...

I think so:

Fixes: 09515ef5ddad ("of/acpi: Configure dma operations at probe time 
for platform/amba/pci bus devices")

There aren't many drivers using dmam_alloc_*(), let alone which would 
also find themselves behind an IOMMU on an Arm system, but it turns out 
I actually have another one which can reproduce the BUG() with 5.0-rc.

I've tried a 4.12 kernel with a bit of instrumentation[1] and sure 
enough the devres-managed buffer is freed with the wrong ops[2] even 
then. How it manages not to blow up more catastrophically I have no 
idea... I guess at best it just leaks the buffers and IOMMU mappings, 
and at worst quietly frees random other pages instead.

Robin.

--------------
[1]

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 4f3eecedca2d..f4dbaa5598e3 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -491,6 +491,7 @@ static inline void *dma_alloc_attrs(struct device 
*dev, size_t size,
  		return NULL;

  	cpu_addr = ops->alloc(dev, size, dma_handle, flag, attrs);
+	dev_info(dev, "alloc %lx %lx\n", (unsigned long)cpu_addr, (unsigned 
long)ops);
  	debug_dma_alloc_coherent(dev, size, *dma_handle, cpu_addr);
  	return cpu_addr;
  }
@@ -512,6 +513,7 @@ static inline void dma_free_attrs(struct device 
*dev, size_t size,

  	debug_dma_free_coherent(dev, size, cpu_addr, dma_handle);
  	ops->free(dev, size, cpu_addr, dma_handle, attrs);
+	dev_info(dev, "free %lx %lx\n", (unsigned long)cpu_addr, (unsigned 
long)ops);
  }

  static inline void *dma_alloc_coherent(struct device *dev, size_t size,

-------------
[2]

/ # echo '0000:03:00.0' > /sys/bus/pci/drivers/sata_sil24/bind
[  107.417252] sata_sil24 0000:03:00.0: alloc ffff00000a6f9000 
ffff0000089b8090
[  107.424397] sata_sil24 0000:03:00.0: alloc ffff00000a719000 
ffff0000089b8090
[  107.432216] scsi host0: sata_sil24
[  107.436134] scsi host1: sata_sil24
[  107.439853] ata7: SATA max UDMA/100 host m128@0x50084000 port 
0x50080000 irq 51
[  107.447228] ata8: SATA max UDMA/100 host m128@0x50084000 port 
0x50082000 irq 51
/ # echo '0000:03:00.0' > /sys/bus/pci/drivers/sata_sil24/unbind
...
[  112.048654] sata_sil24 0000:03:00.0: free ffff00000a719000 
ffff0000089b8120
[  112.055579] sata_sil24 0000:03:00.0: free ffff00000a6f9000 
ffff0000089b8120
