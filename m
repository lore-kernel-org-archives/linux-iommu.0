From: Michael Wang <yun.wang@profitbricks.com>
Subject: Re: [RFC PATCH v2] iommu/amd: gray the 'irq_remap_table' object for
 kmemleak
Date: Wed, 2 Dec 2015 11:37:40 +0100
Message-ID: <565EC9F4.2050401@profitbricks.com>
References: <564EFF6A.2050709@profitbricks.com>
 <564F051E.9010703@profitbricks.com> <20151125150806.GG2064@8bytes.org>
 <5655D072.1000901@profitbricks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5655D072.1000901@profitbricks.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hi, Joerg

On 11/25/2015 04:14 PM, Michael Wang wrote:
> On 11/25/2015 04:08 PM, Joerg Roedel wrote:
[snip]
>>> This is caused by the 'irq_lookup_table' was allocated with
>>> __get_free_pages() which won't create kmemleak object, thus it's
>>> pointers won't be count as referencing 'irq_remap_table' in
>>> kmemleak scan.
>>
>> Isn't it better to allocate the kmemleak object manually instead of
>> ignoring all irq-table pointers? With this patch we might not notice any
>> real leak of irq-tables.
> 
> We've considered that too, but found that the irq-tables is not
> dynamically alloc/free, they won't be freed once initialized, so there
> is no leaking for such object :-)

Is there any more concern? actually we just want to get rid of this
annoying report on obj won't leak, if you're going to create obj for
'irq_lookup_table' that's also fine for us, or will you pick this patch?

Regards,
Michael Wang

> 
> Regards,
> Michael Wang
> 
>>
>>
>>
>> 	Joerg
>>
