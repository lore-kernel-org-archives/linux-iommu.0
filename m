From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 6/7] iommu: change intel-iommu to use IOVA frame numbers
Date: Tue, 12 Apr 2016 17:10:24 +0100
Message-ID: <570D1DF0.6050309@arm.com>
References: <20151228161724.GA27916@cs.technion.ac.il>
	<570CD405.7010403@arm.com>
	<CAHMfzJkqrtPT3QvG-myZchp8jUZ3E5X_CDa3yaYPpAQ+BR4LNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAHMfzJkqrtPT3QvG-myZchp8jUZ3E5X_CDa3yaYPpAQ+BR4LNQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Adam Morrison <mad-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>
Cc: Benjamin Serebrin <serebrin-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Dan Tsafrir <dan-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Omer Peleg <omer-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 12/04/16 16:12, Adam Morrison wrote:
> On Tue, Apr 12, 2016 at 1:55 PM, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org> wrote:
>
>>> Make intel-iommu map/unmap/invalidate work with IOVA pfns instead of
>>> pointers to "struct iova". This avoids using the iova struct from the IOVA
>>> red-black tree and the resulting explicit find_iova() on unmap.
>
> [...]
>
>>> diff --git a/include/linux/iova.h b/include/linux/iova.h
>>> index 92f7177..efecee0 100644
>>> --- a/include/linux/iova.h
>>> +++ b/include/linux/iova.h
>>> @@ -75,7 +75,7 @@ struct iova *alloc_iova_mem(void);
>>>    void free_iova_mem(struct iova *iova);
>>>    void free_iova(struct iova_domain *iovad, unsigned long pfn);
>>>    void __free_iova(struct iova_domain *iovad, struct iova *iova);
>>> -struct iova *alloc_iova(struct iova_domain *iovad, unsigned long size,
>>> +unsigned long alloc_iova(struct iova_domain *iovad, unsigned long size,
>>>          unsigned long limit_pfn,
>>>          bool size_aligned);
>>>    struct iova *reserve_iova(struct iova_domain *iovad, unsigned long
>>> pfn_lo,
>>
>>
>> Making the internals more efficient is no bad thing, but changing the
>> external interface to the IOVA library like this breaks at least
>> dma-iommu.c, thus stops arm64 from building.
>
> Good point.  I will add new versions of alloc_iova() and free_iova()
> for this functionality and make intel-iommu uses them, so as to not
> break other users.

I wonder if it might be worth going for the intermediate compromise of 
splitting up the structure thus:

struct iova {
	unsigned long	pfn_hi;
	unsigned long	pfn_lo;
};

/* internal to iova.c */
struct iova_private {
	struct rb_node	node;
	struct iova	iova;
};
	
then externally passing the pfn-only struct iovas by value everywhere we 
currently pass a struct iova *. AFAICS, that ought to require minimal 
changes in the users, and they shouldn't need to know or care whether 
any given iova is backed by the tree or the rcache, because they're 
simple to fake up:

	unsigned long iova_pfn =
		iova_rcache_get(&iovad->rcaches[log_size]);
	if (iova_pfn)
		return { iova_pfn + log_size, iova_pfn };

What do you reckon?

Robin.
