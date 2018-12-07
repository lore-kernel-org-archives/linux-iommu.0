From: Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC] avoid indirect calls for DMA direct mappings
Date: Fri, 7 Dec 2018 02:21:42 +0100
Message-ID: <20181207012141.GA4256@lst.de>
References: <20181206153720.10702-1-hch@lst.de> <CAHk-=wgz6PFCm+XMWN31dRHzA3JcNP0x0Y-z5NMMw3dHhrDXAw@mail.gmail.com> <20181206184330.GB30039@lst.de> <173bfba7-033d-93c4-6ef1-48c9e39c9efc@arm.com> <20181206200006.GA31548@lst.de> <e3e4c17e-ba6d-d743-04e5-7f240211b9bc@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <e3e4c17e-ba6d-d743-04e5-7f240211b9bc@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@lst.de>, Linus Torvalds <torvalds@linux-foundation.org>, iommu@lists.linux-foundation.org, brouer@redhat.com, tariqt@mellanox.com, ilias.apalodimas@linaro.org, toke@toke.dk, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Dec 06, 2018 at 08:24:38PM +0000, Robin Murphy wrote:
> On 06/12/2018 20:00, Christoph Hellwig wrote:
>> On Thu, Dec 06, 2018 at 06:54:17PM +0000, Robin Murphy wrote:
>>> I'm pretty sure we used to assign dummy_dma_ops explicitly to devices at
>>> the point we detected the ACPI properties are wrong - that shouldn't be too
>>> much of a headache to go back to.
>>
>> Ok.  I've cooked up a patch to use NULL as the go direct marker.
>> This cleans up a few things nicely, but also means we now need to
>> do the bypass scheme for all ops, not just the fast path.  But we
>> probably should just move the slow path ops out of line anyway,
>> so I'm not worried about it.  This has survived some very basic
>> testing on x86, and really needs to be cleaned up and split into
>> multiple patches..
>
> I've also just finished hacking something up to keep the arm64 status quo - 
> I'll need to actually test it tomorrow, but the overall diff looks like the 
> below.

Nice.  I created a branch that picked up your bits and also the ideas
from Linus, and the result looks reall nice.  I'll still need a signoff
for your bits, though.

Jesper, can you give this a spin if it changes the number even further?

  git://git.infradead.org/users/hch/misc.git dma-direct-calls.2

  http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma-direct-calls.2
