From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 06/10] swiotlb: use swiotlb_map_page in
 swiotlb_map_sg_attrs
Date: Fri, 23 Nov 2018 19:34:15 +0000
Message-ID: <1c782a3d-cac4-954f-21e7-ef89147f0d56@arm.com>
References: <20181008080246.20543-1-hch@lst.de>
 <20181008080246.20543-7-hch@lst.de>
 <CANcMJZAzrxA9LGNvP-epv2DwsUacEM_hcgA1n5gmaPuWRJG4iw@mail.gmail.com>
 <20181109074955.GA27489@lst.de>
 <CALAqxLVSDkv4faF3ta_ue9AA9s8B=-8cAMxC_sow+wZYtrfxeQ@mail.gmail.com>
 <20181114141311.GA26677@lst.de> <20181114161239.GA29462@lst.de>
 <CALAqxLVMW2sYkaQvggZ-LhvkzpuF2rssQJ4thZkkAkROk=wVVw@mail.gmail.com>
 <20181120092516.GC7270@lst.de> <20181123182715.GA21183@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181123182715.GA21183@arm.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>, Christoph Hellwig <hch@lst.de>, john.stultz@linaro.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, iommu@lists.linux-foundation.org, lkml <linux-kernel@vger.kernel.org>, Valentin Schneider <valentin.schneider@arm.com>
List-Id: iommu@lists.linux-foundation.org

Hi Will,

On 2018-11-23 6:27 pm, Will Deacon wrote:
> Hi John,
> 
> On Tue, Nov 20, 2018 at 10:25:16AM +0100, Christoph Hellwig wrote:
>> On Mon, Nov 19, 2018 at 03:22:13PM -0800, John Stultz wrote:
>>>> +               sg->dma_address = dma_addr;
>>>>                  sg_dma_len(sg) = sg->length;
>>>>          }
>>>
>>> I know Robin has already replied with more detailed info, but just to
>>> close the loop as I'm finally home, applying this patch didn't seem to
>>> help with the IO hangs I'm seeing w/ HiKey960.
>>
>> If Robins observation is right this should fix the problem for you:
> 
> Please could you give this diff a try and let us know whether the problem
> persists with your board?

This is actually the exact same change that I ended up with in my 
fixes[1], which John has indeed confirmed.

(sorry, it's the thing I was telling you about the other day, but I 
neglected to include you on cc you when I sent the patches out the 
following morning)

Robin.

[1] https://lore.kernel.org/lkml/cover.1542812807.git.robin.murphy@arm.com/
