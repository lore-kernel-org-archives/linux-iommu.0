From: Randy Dunlap <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: Re: CONFIG_DMA_NOOP_OPS breaks ARM arch
Date: Sun, 15 Oct 2017 20:58:24 -0700
Message-ID: <04535c78-d418-b2b2-89db-ab4732a05984@infradead.org>
References: <CAM3PiRyBpa7vipUfzEYqvYzeLu=tkUWCo+_G79BXrgG0zG3asg@mail.gmail.com>
	<960157c0-13ee-9953-d654-9891465c987d@infradead.org>
	<ffa1481b-de82-f163-6cc9-fbb24615572f@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <ffa1481b-de82-f163-6cc9-fbb24615572f-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Marian Mihailescu <marian.mihailescu-sKtvjTG20lXX/JP9YwkgDA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Bart Van Assche <bart.vanassche-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Vladimir Murzin <vladimir.murzin-5wv7dgnIgG8@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 10/15/17 20:29, Randy Dunlap wrote:
> On 10/15/17 20:27, Randy Dunlap wrote:
>> On 10/15/17 19:27, Marian Mihailescu wrote:
>>> After commit 7844572c633964c864d9f32dc3f2a8ffe5d70371, dma_noop_ops
>>> are built only for architectures that use it.
>>>
>>> For ARM architecture, CONFIG_DMA_NOOP_OPS is not selected, and cannot
>>> be selected.

What kernel version are you looking at?
I see that it is selected:

--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -22,6 +22,7 @@ config ARM
 	select CLONE_BACKWARDS
 	select CPU_PM if (SUSPEND || CPU_IDLE)
 	select DCACHE_WORD_ACCESS if HAVE_EFFICIENT_UNALIGNED_ACCESS
+	select DMA_NOOP_OPS if !MMU
 	select EDAC_SUPPORT
 	select EDAC_ATOMIC_SCRUB
 	select GENERIC_ALLOCATOR


That's in commit ID 1c51c429f30ea10428337f3a33c12059ba59f668 from May 24, 2017.

>>> However, arch/arm/include/asm/dma-mapping.h is referencing dma_noop_ops:
>>>
>>> static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
>>> {
>>> return IS_ENABLED(CONFIG_MMU) ? &arm_dma_ops : &dma_noop_ops;
>>> }
>>>
>>> I will let a maintainer suggest the best resolution for this :)
>>>
>>
>> add Bart and iommu mailing list.
>>
> 
> and add Vladimir.
> 
> 


-- 
~Randy
