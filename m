From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] [v2] dma-mapping: work around clang bug
Date: Thu, 7 Mar 2019 09:43:06 +0000
Message-ID: <295485e0-a43e-874e-2314-7c501c56ba71@arm.com>
References: <20190307085246.1477426-1-arnd@arndb.de>
	<86b7f396-c525-ae7e-b51c-cb2442d8d507@arm.com>
	<CAK8P3a19dyTxE2o9KAw3G1qH8p4qXO-dhhc885Z2_w9BDSoFHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAK8P3a19dyTxE2o9KAw3G1qH8p4qXO-dhhc885Z2_w9BDSoFHQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-GB
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Nick Desaulniers <ndesaulniers-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "open list:IOMMU DRIVERS" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Paul Burton <paul.burton-8NJIiSa5LzA@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Jesper Dangaard Brouer <brouer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 2019-03-07 9:28 am, Arnd Bergmann wrote:
> On Thu, Mar 7, 2019 at 10:17 AM Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org> wrote:
>> On 2019-03-07 8:52 am, Arnd Bergmann wrote:
>>>
>>> -#define DMA_BIT_MASK(n)      (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
>>> +/* double shift to work around https://bugs.llvm.org/show_bug.cgi?id=38789 */
>>> +#define DMA_BIT_MASK(n)      (((n) == 64) ? ~0ULL : ((1ULL<<((n)-1))<<1)-1)
>>
>> I think that now makes DMA_BIT_MASK(0) undefined - that shouldn't matter
>> in most cases, but it could potentially happen at runtime where callers
>> use a non-constant argument. However, it also means we don't need to
>> special-case 64 any more (since that's there to avoid the same thing
>> anyway), so we could simply flip that to handle 0 instead.
> 
> Yes, good idea.
> 
>> FWIW I'd be very tempted to fold in the second shift as "2ULL<<((n)-1)",
>> but that may not be to everyone's taste.
> 
> I like that. So shall we do this?
> 
> /*
>   * Shifting '2' instead of '1' because of
>   * https://bugs.llvm.org/show_bug.cgi?id=38789
>   */
> #define DMA_BIT_MASK(n)    (((n) == 0) ? 0ULL : ((2ULL<<((n)-1)))-1)

Neat - it was too early in the morning for me to think of a succinct way 
to comment it, but that's great. I suspect there may be a redundant set 
of parentheses around the shift still, but other than that,

Reviewed-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>

Cheers,
Robin.
