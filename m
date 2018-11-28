From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: move the arm arch_dma_alloc implementation to common code
Date: Wed, 28 Nov 2018 12:18:18 +0000
Message-ID: <9d31a389-4f8c-a709-b404-e3b3e2623ae9@arm.com>
References: <20181105121931.13481-1-hch@lst.de>
 <20181109075238.GA27578@lst.de> <20181115195041.GC4535@brain-police>
 <b3267453-0c2d-4bda-2122-d6212967dafc@arm.com>
 <20181127073715.GA30033@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181127073715.GA30033@lst.de>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Will Deacon <will.deacon@arm.com>, iommu@lists.linux-foundation.org, Catalin Marinas <catalin.marinas@arm.com>, linux-kernel@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>, Laura Abbott <labbott@redhat.com>, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

On 27/11/2018 07:37, Christoph Hellwig wrote:
> On Thu, Nov 15, 2018 at 12:58:04PM -0800, Robin Murphy wrote:
>> On 2018-11-15 11:50 am, Will Deacon wrote:
>>> On Fri, Nov 09, 2018 at 08:52:38AM +0100, Christoph Hellwig wrote:
>>>> Can I get a quick review from the arm64 folks?  I think it should
>>>> be fine there as it basically is a code move, but an additional pair
>>>> or two of eyes always helps to weed out bugs.
>>>
>>> I reviewed the arm64 parts, but it would be ideal if Robin could have a look
>>> as well.
>>
>> Yup, from a quick skim the general shape of the whole series looks
>> pleasing, but I've been holding off going through it in detail until I've
>> figured out what's up with the last thing I thought I'd reviewed
>> exhaustively...
>>
>> Either way I'll make some time for a proper look next week once I'm back.
> 
> Did you get a chance to look over this?

Sorry, it took a little longer than expected to catch up, but I'm 
looking at it now.

Robin.
