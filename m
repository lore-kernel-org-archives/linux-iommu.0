From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] iommu/iova: Update cached node pointer when current node
 fails to get any free IOVA
Date: Wed, 25 Jul 2018 15:20:47 +0100
Message-ID: <3ed2046c-6912-9380-7ea4-4d921981c64c@arm.com>
References: <20180419171234.11053-1-ganapatrao.kulkarni@cavium.com>
 <c6c3655b-cef2-1112-e8a7-79c99f9ddac6@arm.com>
 <CAKTKpr67gqCK5y6atsterc7kCAg9fK_NKx2yMD3OjY+1L=j0sQ@mail.gmail.com>
 <CAKTKpr4skf3=Aw1YJNPppSjUT7w7_CF6QhefeHZDQXzENCfm5g@mail.gmail.com>
 <CAKTKpr7BmaR-rwqf=z8JiNpaoQNhpSXuUp8sZogUgSLpfcCe0A@mail.gmail.com>
 <CAKTKpr694WntjTB+pbXN--wthH+sw1mrr=JWjDfddG4bHdLwjw@mail.gmail.com>
 <CAKTKpr74X9e2X-deraxFQzeoTio09LqoZoLDgod4J5AOn+vPMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKTKpr74X9e2X-deraxFQzeoTio09LqoZoLDgod4J5AOn+vPMg@mail.gmail.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Ganapatrao Kulkarni <gklkml16@gmail.com>
Cc: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>, Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, tomasz.nowicki@cavium.com, jnair@caviumnetworks.com, Robert Richter <Robert.Richter@cavium.com>, Vadim.Lomovtsev@cavium.com, Jan.Glauber@cavium.com
List-Id: iommu@lists.linux-foundation.org

On 12/07/18 08:45, Ganapatrao Kulkarni wrote:
> Hi Robin,
> 
> 
> On Mon, Jun 4, 2018 at 9:36 AM, Ganapatrao Kulkarni <gklkml16@gmail.com> wrote:
>> ping??
>>
>> On Mon, May 21, 2018 at 6:45 AM, Ganapatrao Kulkarni <gklkml16@gmail.com> wrote:
>>> On Thu, Apr 26, 2018 at 3:15 PM, Ganapatrao Kulkarni <gklkml16@gmail.com> wrote:
>>>> Hi Robin,
>>>>
>>>> On Mon, Apr 23, 2018 at 11:11 PM, Ganapatrao Kulkarni
>>>> <gklkml16@gmail.com> wrote:
>>>>> On Mon, Apr 23, 2018 at 10:07 PM, Robin Murphy <robin.murphy@arm.com> wrote:
>>>>>> On 19/04/18 18:12, Ganapatrao Kulkarni wrote:
>>>>>>>
>>>>>>> The performance drop is observed with long hours iperf testing using 40G
>>>>>>> cards. This is mainly due to long iterations in finding the free iova
>>>>>>> range in 32bit address space.
>>>>>>>
>>>>>>> In current implementation for 64bit PCI devices, there is always first
>>>>>>> attempt to allocate iova from 32bit(SAC preferred over DAC) address
>>>>>>> range. Once we run out 32bit range, there is allocation from higher range,
>>>>>>> however due to cached32_node optimization it does not suppose to be
>>>>>>> painful. cached32_node always points to recently allocated 32-bit node.
>>>>>>> When address range is full, it will be pointing to last allocated node
>>>>>>> (leaf node), so walking rbtree to find the available range is not
>>>>>>> expensive affair. However this optimization does not behave well when
>>>>>>> one of the middle node is freed. In that case cached32_node is updated
>>>>>>> to point to next iova range. The next iova allocation will consume free
>>>>>>> range and again update cached32_node to itself. From now on, walking
>>>>>>> over 32-bit range is more expensive.
>>>>>>>
>>>>>>> This patch adds fix to update cached node to leaf node when there are no
>>>>>>> iova free range left, which avoids unnecessary long iterations.
>>>>>>
>>>>>>
>>>>>> The only trouble with this is that "allocation failed" doesn't uniquely mean
>>>>>> "space full". Say that after some time the 32-bit space ends up empty except
>>>>>> for one page at 0x1000 and one at 0x80000000, then somebody tries to
>>>>>> allocate 2GB. If we move the cached node down to the leftmost entry when
>>>>>> that fails, all subsequent allocation attempts are now going to fail despite
>>>>>> the space being 99.9999% free!
>>>>>>
>>>>>> I can see a couple of ways to solve that general problem of free space above
>>>>>> the cached node getting lost, but neither of them helps with the case where
>>>>>> there is genuinely insufficient space (and if anything would make it even
>>>>>> slower). In terms of the optimisation you want here, i.e. fail fast when an
>>>>>> allocation cannot possibly succeed, the only reliable idea which comes to
>>>>>> mind is free-PFN accounting. I might give that a go myself to see how ugly
>>>>>> it looks.
> 
> did you get any chance to look in to this issue?
> i am waiting for your suggestion/patch for this issue!

I got as far as [1], but I wasn't sure how much I liked it, since it 
still seems a little invasive for such a specific case (plus I can't 
remember if it's actually been debugged or not). I think in the end I 
started wondering whether it's even worth bothering with the 32-bit 
optimisation for PCIe devices - 4 extra bytes worth of TLP is surely a 
lot less significant than every transaction taking up to 50% more bus 
cycles was for legacy PCI.

Robin.

[1] 
http://www.linux-arm.org/git?p=linux-rm.git;a=commitdiff;h=a8e0e4af10ebebb3669750e05bf0028e5bd6afe8
