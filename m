From: Ganapatrao Kulkarni <gklkml16@gmail.com>
Subject: Re: [PATCH] iommu/iova: Update cached node pointer when current node
 fails to get any free IOVA
Date: Mon, 30 Jul 2018 12:40:23 +0530
Message-ID: <CAKTKpr5HWUoJL0TcCMmUadtY_Z4p-RnwH7ZNjSxQppw-_=qdOw@mail.gmail.com>
References: <20180419171234.11053-1-ganapatrao.kulkarni@cavium.com>
 <c6c3655b-cef2-1112-e8a7-79c99f9ddac6@arm.com> <CAKTKpr67gqCK5y6atsterc7kCAg9fK_NKx2yMD3OjY+1L=j0sQ@mail.gmail.com>
 <CAKTKpr4skf3=Aw1YJNPppSjUT7w7_CF6QhefeHZDQXzENCfm5g@mail.gmail.com>
 <CAKTKpr7BmaR-rwqf=z8JiNpaoQNhpSXuUp8sZogUgSLpfcCe0A@mail.gmail.com>
 <CAKTKpr694WntjTB+pbXN--wthH+sw1mrr=JWjDfddG4bHdLwjw@mail.gmail.com>
 <CAKTKpr74X9e2X-deraxFQzeoTio09LqoZoLDgod4J5AOn+vPMg@mail.gmail.com>
 <3ed2046c-6912-9380-7ea4-4d921981c64c@arm.com> <CAKTKpr5eERRzxDcH5cno5kDQ10XO9nHXbLTmk=ShEi8HK05fsg@mail.gmail.com>
 <642cefaf-9ce7-bf0f-e6b6-e2e520e2427b@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <642cefaf-9ce7-bf0f-e6b6-e2e520e2427b@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>, Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, tomasz.nowicki@cavium.com, jnair@caviumnetworks.com, Robert Richter <Robert.Richter@cavium.com>, Vadim.Lomovtsev@cavium.com, Jan.Glauber@cavium.com
List-Id: iommu@lists.linux-foundation.org

On Fri, Jul 27, 2018 at 9:48 PM, Robin Murphy <robin.murphy@arm.com> wrote:
> On 27/07/18 13:56, Ganapatrao Kulkarni wrote:
> [...]
>>>>
>>>> did you get any chance to look in to this issue?
>>>> i am waiting for your suggestion/patch for this issue!
>>>
>>>
>>>
>>> I got as far as [1], but I wasn't sure how much I liked it, since it
>>> still
>>> seems a little invasive for such a specific case (plus I can't remember
>>> if
>>> it's actually been debugged or not). I think in the end I started
>>> wondering
>>> whether it's even worth bothering with the 32-bit optimisation for PCIe
>>> devices - 4 extra bytes worth of TLP is surely a lot less significant
>>> than
>>> every transaction taking up to 50% more bus cycles was for legacy PCI.
>>
>>
>> how about tracking previous attempt to get 32bit range iova and avoid
>> further attempts, if it was failed. Later Resume attempts once
>> replenish happens.
>> Created patch for the same [2]
>
>
> Ooh, that's a much neater implementation of essentially the same concept -
> now why couldn't I think of that? :)
>
> Looks like it should be possible to make it entirely self-contained too,
> since alloc_iova() is in a position to both test and update the flag based
> on the limit_pfn passed in.

is below patch much better?

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 83fe262..abb15d6 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -56,6 +56,7 @@ init_iova_domain(struct iova_domain *iovad, unsigned
long granule,
     iovad->granule = granule;
     iovad->start_pfn = start_pfn;
     iovad->dma_32bit_pfn = 1UL << (32 - iova_shift(iovad));
+    iovad->free_32bit_pfns = true;
     iovad->flush_cb = NULL;
     iovad->fq = NULL;
     iovad->anchor.pfn_lo = iovad->anchor.pfn_hi = IOVA_ANCHOR;
@@ -139,8 +140,10 @@ __cached_rbnode_delete_update(struct iova_domain
*iovad, struct iova *free)

     cached_iova = rb_entry(iovad->cached32_node, struct iova, node);
     if (free->pfn_hi < iovad->dma_32bit_pfn &&
-        free->pfn_lo >= cached_iova->pfn_lo)
+        free->pfn_lo >= cached_iova->pfn_lo) {
         iovad->cached32_node = rb_next(&free->node);
+        iovad->free_32bit_pfns = true;
+    }

     cached_iova = rb_entry(iovad->cached_node, struct iova, node);
     if (free->pfn_lo >= cached_iova->pfn_lo)
@@ -290,6 +293,10 @@ alloc_iova(struct iova_domain *iovad, unsigned long size,
     struct iova *new_iova;
     int ret;

+    if (limit_pfn < iovad->dma_32bit_pfn &&
+            !iovad->free_32bit_pfns)
+        return NULL;
+
     new_iova = alloc_iova_mem();
     if (!new_iova)
         return NULL;
@@ -299,6 +306,8 @@ alloc_iova(struct iova_domain *iovad, unsigned long size,

     if (ret) {
         free_iova_mem(new_iova);
+        if (limit_pfn < iovad->dma_32bit_pfn)
+            iovad->free_32bit_pfns = false;
         return NULL;
     }

diff --git a/include/linux/iova.h b/include/linux/iova.h
index 928442d..3810ba9 100644
--- a/include/linux/iova.h
+++ b/include/linux/iova.h
@@ -96,6 +96,7 @@ struct iova_domain {
                            flush-queues */
     atomic_t fq_timer_on;            /* 1 when timer is active, 0
                            when not */
+    bool    free_32bit_pfns;
 };

 static inline unsigned long iova_size(struct iova *iova)
-- 
2.9.4
>
> Robin.
>
>
>>
>> [2]
>> https://github.com/gpkulkarni/linux/commit/e2343a3e1f55cdeb5694103dd354bcb881dc65c3
>> note, the testing of this patch is in progress.
>>
>>>
>>> Robin.
>>>
>>> [1]
>>>
>>> http://www.linux-arm.org/git?p=linux-rm.git;a=commitdiff;h=a8e0e4af10ebebb3669750e05bf0028e5bd6afe8
>>
>>
>> thanks
>> Ganapat
>>
>

thanks
Ganapat
