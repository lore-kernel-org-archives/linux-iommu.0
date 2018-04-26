From: Ganapatrao Kulkarni <gklkml16-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] iommu/iova: Update cached node pointer when current node
	fails to get any free IOVA
Date: Thu, 26 Apr 2018 15:15:00 +0530
Message-ID: <CAKTKpr4skf3=Aw1YJNPppSjUT7w7_CF6QhefeHZDQXzENCfm5g@mail.gmail.com>
References: <20180419171234.11053-1-ganapatrao.kulkarni@cavium.com>
	<c6c3655b-cef2-1112-e8a7-79c99f9ddac6@arm.com>
	<CAKTKpr67gqCK5y6atsterc7kCAg9fK_NKx2yMD3OjY+1L=j0sQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAKTKpr67gqCK5y6atsterc7kCAg9fK_NKx2yMD3OjY+1L=j0sQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: Vadim.Lomovtsev-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, Jan.Glauber-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tomasz.nowicki-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, jnair-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org, Ganapatrao Kulkarni <ganapatrao.kulkarni-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, Robert Richter <Robert.Richter-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Robin,

On Mon, Apr 23, 2018 at 11:11 PM, Ganapatrao Kulkarni
<gklkml16-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On Mon, Apr 23, 2018 at 10:07 PM, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org> wrote:
>> On 19/04/18 18:12, Ganapatrao Kulkarni wrote:
>>>
>>> The performance drop is observed with long hours iperf testing using 40G
>>> cards. This is mainly due to long iterations in finding the free iova
>>> range in 32bit address space.
>>>
>>> In current implementation for 64bit PCI devices, there is always first
>>> attempt to allocate iova from 32bit(SAC preferred over DAC) address
>>> range. Once we run out 32bit range, there is allocation from higher range,
>>> however due to cached32_node optimization it does not suppose to be
>>> painful. cached32_node always points to recently allocated 32-bit node.
>>> When address range is full, it will be pointing to last allocated node
>>> (leaf node), so walking rbtree to find the available range is not
>>> expensive affair. However this optimization does not behave well when
>>> one of the middle node is freed. In that case cached32_node is updated
>>> to point to next iova range. The next iova allocation will consume free
>>> range and again update cached32_node to itself. From now on, walking
>>> over 32-bit range is more expensive.
>>>
>>> This patch adds fix to update cached node to leaf node when there are no
>>> iova free range left, which avoids unnecessary long iterations.
>>
>>
>> The only trouble with this is that "allocation failed" doesn't uniquely mean
>> "space full". Say that after some time the 32-bit space ends up empty except
>> for one page at 0x1000 and one at 0x80000000, then somebody tries to
>> allocate 2GB. If we move the cached node down to the leftmost entry when
>> that fails, all subsequent allocation attempts are now going to fail despite
>> the space being 99.9999% free!
>>
>> I can see a couple of ways to solve that general problem of free space above
>> the cached node getting lost, but neither of them helps with the case where
>> there is genuinely insufficient space (and if anything would make it even
>> slower). In terms of the optimisation you want here, i.e. fail fast when an
>> allocation cannot possibly succeed, the only reliable idea which comes to
>> mind is free-PFN accounting. I might give that a go myself to see how ugly
>> it looks.

For this testing, dual port intel 40G card(XL710) used and both ports
were connected in loop-back. Ran iperf server and clients on both
ports(used NAT to route packets out on intended ports).There were 10
iperf clients invoked every 60 seconds in loop for hours for each
port. Initially the performance on both ports is seen close to line
rate, however after test ran about 4 to 6 hours, the performance
started dropping  to very low (to few hundred Mbps) on both
connections.

IMO,  this is common bug and should happen on any other platforms too
and needs to be fixed at the earliest.
Please let me know if you have better way to fix this,  i am happy to
test your patch!

>
> i see 2 problems in current implementation,
> 1. We don't replenish the 32 bits range, until first attempt of second
> allocation(64 bit) fails.
> 2. Having  per cpu cache might not yield good hit on platforms with
> more number of CPUs.
>
> however irrespective of current issues, It makes sense to update
> cached node as done in this patch , when there is failure to get iova
> range using current cached pointer which is forcing for the
> unnecessary time consuming do-while iterations until any replenish
> happens!
>
> thanks
> Ganapat
>
>>
>> Robin.
>>
>>
>>> Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
>>> ---
>>>   drivers/iommu/iova.c | 6 ++++++
>>>   1 file changed, 6 insertions(+)
>>>
>>> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
>>> index 83fe262..e6ee2ea 100644
>>> --- a/drivers/iommu/iova.c
>>> +++ b/drivers/iommu/iova.c
>>> @@ -201,6 +201,12 @@ static int __alloc_and_insert_iova_range(struct
>>> iova_domain *iovad,
>>>         } while (curr && new_pfn <= curr_iova->pfn_hi);
>>>         if (limit_pfn < size || new_pfn < iovad->start_pfn) {
>>> +               /* No more cached node points to free hole, update to leaf
>>> node.
>>> +                */
>>> +               struct iova *prev_iova;
>>> +
>>> +               prev_iova = rb_entry(prev, struct iova, node);
>>> +               __cached_rbnode_insert_update(iovad, prev_iova);
>>>                 spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
>>>                 return -ENOMEM;
>>>         }
>>>
>>

thanks
Ganapat
