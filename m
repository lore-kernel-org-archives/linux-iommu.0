From: "Sricharan" <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: RE: [PATCH V7 5/8] arm64/dma-mapping: Implement DMA_ATTR_PRIVILEGED
Date: Wed, 14 Dec 2016 00:16:34 +0530
Message-ID: <005f01d25571$3f75b5f0$be6121d0$@codeaurora.org>
References: <1481567927-14791-1-git-send-email-sricharan@codeaurora.org>
	<1481567927-14791-6-git-send-email-sricharan@codeaurora.org>
	<7d09fc5a-9425-c171-e469-2759534de2dc@arm.com>
	<002301d2554e$89112d20$9b338760$@codeaurora.org>
	<4e6ebf88-0138-afce-d752-56b66d69772f@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: 
Content-Language: en-us
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: 'Robin Murphy' <robin.murphy-5wv7dgnIgG8@public.gmane.org>, jcrouse-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, pdaly-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, jgebben-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pratikp-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, tzeng-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Robin,

<snip..>

>>>>>  		return prot | IOMMU_READ | IOMMU_WRITE;
>>>>
>>>> ...and applying against -next now also needs this hunk:
>>>>
>>>> @@ -639,7 +639,7 @@ dma_addr_t iommu_dma_map_resource(struct device
>>>> *dev, phys_addr_t phys,
>>>> 		size_t size, enum dma_data_direction dir, unsigned long attrs)
>>>> {
>>>> 	return __iommu_dma_map(dev, phys, size,
>>>> -			dma_direction_to_prot(dir, false) | IOMMU_MMIO);
>>>> +			dma_info_to_prot(dir, false, attrs) | IOMMU_MMIO);
>>>> }
>>>>
>>>> void iommu_dma_unmap_resource(struct device *dev, dma_addr_t handle,
>>>>
>>>> With those two issues fixed up, I've given the series (applied to
>>>> next-20161213) a spin on a SMMUv3/PL330 fast model and it still checks out.
>>>>
>>>
>>> oops, sorry that i missed this in rebase. I can repost now with this fixed,
>>> 'checks out' you mean something is not working correct ?
>>
>>No, I mean it _is_ still correct - I guess that's more of an idiom than
>>I thought :)
>>
>
>ha ok, thanks for the testing as well. I will just send a v8 with those two fixed now.

Just while checking that i have not missed anything else, realized that the
dma-mapping apis in arm as to be modified to pass the PRIVILIGED attributes
as well. While my testing path was using the iommu_map directly i was not
seeing this, but then i did a patch like below. I will just figure out another
other codebase where the master uses the dma apis, test and add it in the
V8 that i would send.


From: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Date: Tue, 13 Dec 2016 23:25:01 +0530
Subject: [PATCH V8 6/9] arm/dma-mapping: Implement DMA_ATTR_PRIVILEGED

The newly added DMA_ATTR_PRIVILEGED is useful for creating mappings that
are only accessible to privileged DMA engines.  Implementing it in dma-mapping
for it to get used from the dma mappings apis.

Signed-off-by: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
---
 arch/arm/mm/dma-mapping.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index ab77100..e0d9923 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1394,7 +1394,8 @@ static int __iommu_free_buffer(struct device *dev, struct page **pages,
  * Create a mapping in device IO address space for specified pages
  */
 static dma_addr_t
-__iommu_create_mapping(struct device *dev, struct page **pages, size_t size)
+__iommu_create_mapping(struct device *dev, struct page **pages, size_t size,
+		       unsigned long attrs)
 {
 	struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
 	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
@@ -1419,7 +1420,7 @@ static int __iommu_free_buffer(struct device *dev, struct page **pages,
 
 		len = (j - i) << PAGE_SHIFT;
 		ret = iommu_map(mapping->domain, iova, phys, len,
-				IOMMU_READ|IOMMU_WRITE);
+				__dma_info_to_prot(DMA_BIRECTIONAL, attrs));
 		if (ret < 0)
 			goto fail;
 		iova += len;
@@ -1476,7 +1477,8 @@ static struct page **__iommu_get_pages(void *cpu_addr, unsigned long attrs)
 }
 
 static void *__iommu_alloc_simple(struct device *dev, size_t size, gfp_t gfp,
-				  dma_addr_t *handle, int coherent_flag)
+				  dma_addr_t *handle, int coherent_flag,
+				  unsigned long attrs)
 {
 	struct page *page;
 	void *addr;
@@ -1488,7 +1490,7 @@ static void *__iommu_alloc_simple(struct device *dev, size_t size, gfp_t gfp,
 	if (!addr)
 		return NULL;
 
-	*handle = __iommu_create_mapping(dev, &page, size);
+	*handle = __iommu_create_mapping(dev, &page, size, attrs);
 	if (*handle == DMA_ERROR_CODE)
 		goto err_mapping;
 
@@ -1522,7 +1524,8 @@ static void *__arm_iommu_alloc_attrs(struct device *dev, size_t size,
 
 	if (coherent_flag  == COHERENT || !gfpflags_allow_blocking(gfp))
 		return __iommu_alloc_simple(dev, size, gfp, handle,
-					    coherent_flag);
+					    coherent_flag,
+					    attrs);
 
 	/*
 	 * Following is a work-around (a.k.a. hack) to prevent pages
@@ -1672,10 +1675,13 @@ static int arm_iommu_get_sgtable(struct device *dev, struct sg_table *sgt,
 					 GFP_KERNEL);
 }
 
-static int __dma_direction_to_prot(enum dma_data_direction dir)
+static int __dma_info_to_prot(enum dma_data_direction dir, unsigned long attrs)
 {
 	int prot;
 
+	if (attrs & DMA_ATTR_PRIVILEGED)
+		prot |= IOMMU_PRIV;
+
 	switch (dir) {
 	case DMA_BIDIRECTIONAL:
 		prot = IOMMU_READ | IOMMU_WRITE;
@@ -1722,7 +1728,7 @@ static int __map_sg_chunk(struct device *dev, struct scatterlist *sg,
 		if (!is_coherent && (attrs & DMA_ATTR_SKIP_CPU_SYNC) == 0)
 			__dma_page_cpu_to_dev(sg_page(s), s->offset, s->length, dir);
 
-		prot = __dma_direction_to_prot(dir);
+		prot = __dma_info_to_prot(dir, attrs);
 
 		ret = iommu_map(mapping->domain, iova, phys, len, prot);
 		if (ret < 0)
@@ -1930,7 +1936,7 @@ static dma_addr_t arm_coherent_iommu_map_page(struct device *dev, struct page *p
 	if (dma_addr == DMA_ERROR_CODE)
 		return dma_addr;
 
-	prot = __dma_direction_to_prot(dir);
+	prot = __dma_info_to_prot(dir, attrs);
 
 	ret = iommu_map(mapping->domain, dma_addr, page_to_phys(page), len, prot);
 	if (ret < 0)
@@ -2036,7 +2042,7 @@ static dma_addr_t arm_iommu_map_resource(struct device *dev,
 	if (dma_addr == DMA_ERROR_CODE)
 		return dma_addr;
 
-	prot = __dma_direction_to_prot(dir) | IOMMU_MMIO;
+	prot = __dma_info_to_prot(dir, attrs) | IOMMU_MMIO;
 
 	ret = iommu_map(mapping->domain, dma_addr, addr, len, prot);
 	if (ret < 0)
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

Regards,
 Sricharan
