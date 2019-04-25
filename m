From: Juergen Gross <jgross@suse.com>
Subject: Re: [Xen-devel] [PATCH 3/3] xen/swiotlb: remember having called
 xen_create_contiguous_region()
Date: Thu, 25 Apr 2019 11:07:11 +0200
Message-ID: <a1203397-9704-192a-c157-442dbeee62c5@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
References: =?UTF-8?B?PDIwMTkwNDIzMTA1NDU3LjE3NTAy77+9Me+/vWpncm9zc0BzdXNl?=
 =?UTF-8?B?LmNvbT4gPDIwMTkwNDIzMTA1NDU3LjE3NTAy77+9NO+/vWpncm9zc0BzdXNlLmNv?=
 =?UTF-8?Q?m=3e_=3calpine=2eDEB=2e2=2e10=2e1904230955190=2e24598=40sstabelli?=
 =?UTF-8?Q?ni=ef=bf=bdThinkPad=ef=bf=bdX260=3e_=3ce744c7eb-1685-13b6-7ae9-e9?=
 =?UTF-8?Q?52f8f53ab0=40suse=2ecom=3e_=3c5CC177740200007800228EB2=40suse=2ec?=
 =?UTF-8?B?b20+?=
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jan Beulich <JBeulich@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>, iommu@lists.linux-foundation.org, xen-devel <xen-devel@lists.xenproject.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, lkml <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

On 25/04/2019 11:01, Jan Beulich wrote:
>>>> On 23.04.19 at 20:36, <jgross@suse.com> wrote:
>> On 23/04/2019 19:05, Stefano Stabellini wrote:
>>> On Tue, 23 Apr 2019, Juergen Gross wrote:
>>>> Instead of always calling xen_destroy_contiguous_region() in case the
>>>> memory is DMA-able for the used device, do so only in case it has been
>>>> made DMA-able via xen_create_contiguous_region() before.
>>>>
>>>> This will avoid a lot of xen_destroy_contiguous_region() calls for
>>>> 64-bit capable devices.
>>>>
>>>> As the memory in question is owned by swiotlb-xen the PG_owner_priv_1
>>>> flag of the first allocated page can be used for remembering.
>>>
>>> Although the patch looks OK, this sentence puzzles me. Why do you say
>>> that the memory in question is owned by swiotlb-xen? Because it was
>>> returned by xen_alloc_coherent_pages? Both the x86 and the Arm
>>> implementation return fresh new memory, hence, it should be safe to set
>>> the PageOwnerPriv1 flag?
>>>
>>> My concern with this approach is with the semantics of PG_owner_priv_1.
>>> Is a page marked with PG_owner_priv_1 only supposed to be used by the
>>> owner?
>>
>> The owner of the page is free to use the flag.
>>
>> Like Grant pages are marked by the grant driver using this flag. And
>> Xen page tables are using it in PV-guests for indicating a "Pinned"
>> page table.
> 
> Considering the background of the series, isn't such multi-purpose use
> of the flag a possible problem? You're already suspecting a wrong call
> into here. The function finding the flag set (but for another reason)
> might add to the confusion. But I realize there are only so many page
> flags available.

Right.

> Perhaps the freeing function should, first thing, check the handed
> space actually matches the criteria (within dma_mask and contiguous)?

Yes, I think this is a good idea.


Juergen
