From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] iommu/iova: Update cached node pointer when current node
 fails to get any free IOVA
Date: Fri, 27 Jul 2018 17:18:54 +0100
Message-ID: <642cefaf-9ce7-bf0f-e6b6-e2e520e2427b@arm.com>
References: <20180419171234.11053-1-ganapatrao.kulkarni@cavium.com>
 <c6c3655b-cef2-1112-e8a7-79c99f9ddac6@arm.com>
 <CAKTKpr67gqCK5y6atsterc7kCAg9fK_NKx2yMD3OjY+1L=j0sQ@mail.gmail.com>
 <CAKTKpr4skf3=Aw1YJNPppSjUT7w7_CF6QhefeHZDQXzENCfm5g@mail.gmail.com>
 <CAKTKpr7BmaR-rwqf=z8JiNpaoQNhpSXuUp8sZogUgSLpfcCe0A@mail.gmail.com>
 <CAKTKpr694WntjTB+pbXN--wthH+sw1mrr=JWjDfddG4bHdLwjw@mail.gmail.com>
 <CAKTKpr74X9e2X-deraxFQzeoTio09LqoZoLDgod4J5AOn+vPMg@mail.gmail.com>
 <3ed2046c-6912-9380-7ea4-4d921981c64c@arm.com>
 <CAKTKpr5eERRzxDcH5cno5kDQ10XO9nHXbLTmk=ShEi8HK05fsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKTKpr5eERRzxDcH5cno5kDQ10XO9nHXbLTmk=ShEi8HK05fsg@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ganapatrao Kulkarni <gklkml16@gmail.com>
Cc: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>, Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, tomasz.nowicki@cavium.com, jnair@caviumnetworks.com, Robert Richter <Robert.Richter@cavium.com>, Vadim.Lomovtsev@cavium.com, Jan.Glauber@cavium.com
List-Id: iommu@lists.linux-foundation.org

On 27/07/18 13:56, Ganapatrao Kulkarni wrote:
[...]
>>> did you get any chance to look in to this issue?
>>> i am waiting for your suggestion/patch for this issue!
>>
>>
>> I got as far as [1], but I wasn't sure how much I liked it, since it still
>> seems a little invasive for such a specific case (plus I can't remember if
>> it's actually been debugged or not). I think in the end I started wondering
>> whether it's even worth bothering with the 32-bit optimisation for PCIe
>> devices - 4 extra bytes worth of TLP is surely a lot less significant than
>> every transaction taking up to 50% more bus cycles was for legacy PCI.
> 
> how about tracking previous attempt to get 32bit range iova and avoid
> further attempts, if it was failed. Later Resume attempts once
> replenish happens.
> Created patch for the same [2]

Ooh, that's a much neater implementation of essentially the same concept 
- now why couldn't I think of that? :)

Looks like it should be possible to make it entirely self-contained too, 
since alloc_iova() is in a position to both test and update the flag 
based on the limit_pfn passed in.

Robin.

> 
> [2] https://github.com/gpkulkarni/linux/commit/e2343a3e1f55cdeb5694103dd354bcb881dc65c3
> note, the testing of this patch is in progress.
> 
>>
>> Robin.
>>
>> [1]
>> http://www.linux-arm.org/git?p=linux-rm.git;a=commitdiff;h=a8e0e4af10ebebb3669750e05bf0028e5bd6afe8
> 
> thanks
> Ganapat
> 
