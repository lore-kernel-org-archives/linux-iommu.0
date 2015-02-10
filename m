From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFC PATCH v2 2/3] arm64: add IOMMU dma_ops
Date: Tue, 10 Feb 2015 12:07:34 +0000
Message-ID: <54D9F486.10501@arm.com>
References: <cover.1423226542.git.robin.murphy@arm.com>	
	<058e038009ac708a40197c80e07410914c2a162e.1423226542.git.robin.murphy@arm.com>
	<1423543151.18280.2.camel@mtksdaap41>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1423543151.18280.2.camel@mtksdaap41>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Yingjoe Chen <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, "stefano.stabellini-mvvWK6WmYclDPfheJLI6IQ@public.gmane.org" <stefano.stabellini-mvvWK6WmYclDPfheJLI6IQ@public.gmane.org>, Catalin Marinas <Catalin.Marinas-5wv7dgnIgG8@public.gmane.org>, "thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org" <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org" <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "josephl-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org" <josephl-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org" <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 10/02/15 04:39, Yingjoe Chen wrote:
> On Fri, 2015-02-06 at 14:55 +0000, Robin Murphy wrote
> <...>
>> diff --git a/arch/arm64/include/asm/dma-mapping.h b/arch/arm64/include/asm/dma-mapping.h
>> index 6932bb5..c1b271f 100644
>> --- a/arch/arm64/include/asm/dma-mapping.h
>> +++ b/arch/arm64/include/asm/dma-mapping.h
>> @@ -62,13 +62,30 @@ static inline bool is_device_dma_coherent(struct device *dev)
>>
>>   #include <asm-generic/dma-mapping-common.h>
>>
>> +#ifdef CONFIG_IOMMU_DMA
>> +static inline struct iommu_dma_domain *get_dma_domain(struct device *dev)
>> +{
>> +	return dev->archdata.dma_domain;
>> +}
>> +
>> +static inline void set_dma_domain(struct device *dev,
>> +				  struct iommu_dma_domain *dma_domain)
>> +{
>> +	dev->archdata.dma_domain = dma_domain;
>> +}
>> +#endif
>> +
>>   static inline dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
>>   {
>> +	if (WARN_ON(dev && get_dma_domain(dev)))
>> +		return DMA_ERROR_CODE;
>>   	return (dma_addr_t)paddr;
>>   }
>
>
> Hi Robin,
>
> Build fail if CONFIG_IOMMU_DMA is not enabled.
>
> In file included from ../include/linux/dma-mapping.h:82:0,
>                   from ../arch/arm64/kernel/asm-offsets.c:23:
> ../arch/arm64/include/asm/dma-mapping.h: In function 'phys_to_dma':
> ../arch/arm64/include/asm/dma-mapping.h:81:2: error: implicit declaration of function 'get_dma_domain' [-Werror=implicit-function-declaration]
>    if (WARN_ON(dev && get_dma_domain(dev)))
>    ^
>
> Joe.C

Bah, how did I manage to make such a half-finished mess of the includes? 
Current fixup diff below.

Thanks,
Robin.

--->8---
diff --git a/arch/arm64/include/asm/dma-mapping.h 
b/arch/arm64/include/asm/dma-mapping.h
index 5246d1a..208a268 100644
--- a/arch/arm64/include/asm/dma-mapping.h
+++ b/arch/arm64/include/asm/dma-mapping.h
@@ -58,6 +58,7 @@ static inline bool is_device_dma_coherent(struct 
device *dev)
  }

  #include <asm-generic/dma-mapping-common.h>
+#include <linux/dma-iommu.h>

  #ifdef CONFIG_IOMMU_DMA

diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 9267b20..412d61a 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -23,7 +23,6 @@
  #include <linux/genalloc.h>
  #include <linux/dma-mapping.h>
  #include <linux/dma-contiguous.h>
-#include <linux/dma-iommu.h>
  #include <linux/vmalloc.h>
  #include <linux/swiotlb.h>

@@ -438,6 +437,7 @@ fs_initcall(dma_debug_do_init);


  #ifdef CONFIG_IOMMU_DMA
+#include <linux/iommu.h>

  static struct page **__atomic_get_pages(void *addr)
  {
diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 19027bb..6615cfd 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -22,7 +22,7 @@ config OF_IOMMU

  # IOMMU-agnostic DMA-mapping layer
  config IOMMU_DMA
-	def_bool n
+	bool
  	depends on NEED_SG_DMA_LENGTH
  	select IOMMU_API
  	select IOMMU_IOVA
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index b97cc0b9..6c7ca0b 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -23,6 +23,7 @@

  #include <linux/dma-contiguous.h>
  #include <linux/dma-iommu.h>
+#include <linux/iommu.h>
  #include <linux/iova.h>

  int iommu_dma_init(void)
@@ -38,8 +39,10 @@ struct iommu_dma_domain {

  static inline dma_addr_t dev_dma_addr(struct device *dev, dma_addr_t addr)
  {
-	BUG_ON(addr < dev->dma_pfn_offset);
-	return addr - ((dma_addr_t)dev->dma_pfn_offset << PAGE_SHIFT);
+	dma_addr_t offset = (dma_addr_t)dev->dma_pfn_offset << PAGE_SHIFT;
+
+	BUG_ON(addr < offset);
+	return addr - offset;
  }

  static int __dma_direction_to_prot(enum dma_data_direction dir, bool 
coherent)
@@ -65,9 +68,9 @@ static struct iova *__alloc_iova(struct device *dev, 
size_t size, bool coherent)
  	unsigned long shift = iova_shift(iovad);
  	unsigned long length = iova_align(iovad, size) >> shift;
  	unsigned long limit_pfn = iovad->dma_32bit_pfn;
-	u64 dma_limit = coherent ? dev->coherent_dma_mask : *dev->dma_mask;
+	u64 dma_limit = coherent ? dev->coherent_dma_mask : dma_get_mask(dev);

-	limit_pfn = min(limit_pfn, (unsigned long)(dma_limit >> shift));
+	limit_pfn = min_t(unsigned long, limit_pfn, dma_limit >> shift);
  	/* Alignment should probably come from a domain/device attribute... */
  	return alloc_iova(iovad, length, limit_pfn, false);
  }
diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
index 4bba85a..8de28ad 100644
--- a/include/linux/dma-iommu.h
+++ b/include/linux/dma-iommu.h
@@ -18,8 +18,7 @@

  #ifdef __KERNEL__

-#include <linux/types.h>
-#include <linux/iommu.h>
+#include <linux/dma-mapping.h>

  #ifdef CONFIG_IOMMU_DMA

@@ -39,8 +38,9 @@ void iommu_dma_detach_device(struct device *dev);
   * Implementation of these is left to arch code - it can associate domains
   * with devices however it likes, provided the lookup is efficient.
   */
-struct iommu_dma_domain *get_dma_domain(struct device *dev);
-void set_dma_domain(struct device *dev, struct iommu_dma_domain 
*dma_domain);
+static inline struct iommu_dma_domain *get_dma_domain(struct device *dev);
+static inline void set_dma_domain(struct device *dev,
+		struct iommu_dma_domain *dma_domain);


  dma_addr_t iommu_dma_create_iova_mapping(struct device *dev,
@@ -86,7 +86,9 @@ static inline struct iommu_dma_domain 
*get_dma_domain(struct device *dev)
  	return NULL;
  }

-void set_dma_domain(struct device *dev, struct iommu_dma_domain 
*dma_domain) { }
+static inline void set_dma_domain(struct device *dev,
+		struct iommu_dma_domain *dma_domain)
+{ }

  #endif  /* CONFIG_IOMMU_DMA */
