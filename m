From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: dma-coherent: fix dma_declare_coherent_memory() logic error
Date: Fri, 15 Sep 2017 17:03:33 +0200
Message-ID: <CAK8P3a3ngo763XY2EqjoO3Xp3Sf2wmDUCJPv2VZ7YSvd7qqsVg@mail.gmail.com>
References: <20170905081026.1198405-1-arnd@arndb.de>
	<DB6PR04MB2999F7968A4C1804E5C1EB80866F0@DB6PR04MB2999.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <DB6PR04MB2999F7968A4C1804E5C1EB80866F0-L6AvkJgIb5ff8seN0ITLGs9NdZoXdze2vxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Roy Pledge <roy.pledge-3arQi8VN3Tc@public.gmane.org>
Cc: Vladimir Murzin <vladimir.murzin-5wv7dgnIgG8@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Craske <Mark_Craske-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>, Bastian Hecht <bhecht-Tbglbhd2jqSoSS7kgVBzIA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "George G. Davis" <george_davis-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

>> @@ -338,14 +346,18 @@ static struct reserved_mem *dma_reserved_default_memory __initdata;
>>   static int rmem_dma_device_init(struct reserved_mem *rmem, struct device *dev)
>>   {
>>       struct dma_coherent_mem *mem = rmem->priv;
>> +     int ret;
>> +
>> +     if (!mem)
>> +             return -ENODEV;
>
> When I picked up this change my use of of_reserved_mem_device_init()
> broke. The only place rmem->priv is set is in this function (bottom of
> the patch) so the !mem check above will always fail. Am I missing
> something? It seems to me the intent here was to only call
> dma_init_coherent_memory() once and use rmem->priv as a cache for future
> calls but I'm just looking at the implemation of this for the first time.

Yes, you are right, I misread that code.  I think we need this fixup on top
to restore the previous behavior:

diff --git a/drivers/base/dma-coherent.c b/drivers/base/dma-coherent.c
index a39b2166b145..744f64f43454 100644
--- a/drivers/base/dma-coherent.c
+++ b/drivers/base/dma-coherent.c
@@ -348,16 +348,15 @@ static int rmem_dma_device_init(struct
reserved_mem *rmem, struct device *dev)
        struct dma_coherent_mem *mem = rmem->priv;
        int ret;

-       if (!mem)
-               return -ENODEV;
-
-       ret = dma_init_coherent_memory(rmem->base, rmem->base, rmem->size,
-                                      DMA_MEMORY_EXCLUSIVE, &mem);
-
-       if (ret) {
-               pr_err("Reserved memory: failed to init DMA memory
pool at %pa, size %ld MiB\n",
-                       &rmem->base, (unsigned long)rmem->size / SZ_1M);
-               return ret;
+       if (!mem) {
+               ret = dma_init_coherent_memory(rmem->base, rmem->base,
+                                              rmem->size,
+                                              DMA_MEMORY_EXCLUSIVE, &mem);
+               if (ret) {
+                       pr_err("Reserved memory: failed to init DMA
memory pool at %pa, size %ld MiB\n",
+                               &rmem->base, (unsigned long)rmem->size / SZ_1M);
+                       return ret;
+               }
        }
        mem->use_dev_dma_pfn_offset = true;
        rmem->priv = mem;
