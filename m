From: Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH 3/3] xen/swiotlb: remember having called
 xen_create_contiguous_region()
Date: Tue, 23 Apr 2019 20:36:13 +0200
Message-ID: <e744c7eb-1685-13b6-7ae9-e952f8f53ab0@suse.com>
References: <20190423105457.17502-1-jgross@suse.com>
 <20190423105457.17502-4-jgross@suse.com>
 <alpine.DEB.2.10.1904230955190.24598@sstabellini-ThinkPad-X260>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.10.1904230955190.24598@sstabellini-ThinkPad-X260>
Content-Language: de-DE
Sender: linux-kernel-owner@vger.kernel.org
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
List-Id: iommu@lists.linux-foundation.org

On 23/04/2019 19:05, Stefano Stabellini wrote:
> On Tue, 23 Apr 2019, Juergen Gross wrote:
>> Instead of always calling xen_destroy_contiguous_region() in case the
>> memory is DMA-able for the used device, do so only in case it has been
>> made DMA-able via xen_create_contiguous_region() before.
>>
>> This will avoid a lot of xen_destroy_contiguous_region() calls for
>> 64-bit capable devices.
>>
>> As the memory in question is owned by swiotlb-xen the PG_owner_priv_1
>> flag of the first allocated page can be used for remembering.
> 
> Although the patch looks OK, this sentence puzzles me. Why do you say
> that the memory in question is owned by swiotlb-xen? Because it was
> returned by xen_alloc_coherent_pages? Both the x86 and the Arm
> implementation return fresh new memory, hence, it should be safe to set
> the PageOwnerPriv1 flag?
> 
> My concern with this approach is with the semantics of PG_owner_priv_1.
> Is a page marked with PG_owner_priv_1 only supposed to be used by the
> owner?

The owner of the page is free to use the flag.

Like Grant pages are marked by the grant driver using this flag. And
Xen page tables are using it in PV-guests for indicating a "Pinned"
page table.


Juergen
