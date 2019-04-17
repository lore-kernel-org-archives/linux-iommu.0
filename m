From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 12/21] dma-iommu: factor atomic pool allocations into
 helpers
Date: Wed, 17 Apr 2019 12:54:01 +0100
Message-ID: <ab00aedc-085d-a4a3-e580-e13d00645d60@arm.com>
References: <20190327080448.5500-1-hch@lst.de>
 <20190327080448.5500-13-hch@lst.de>
 <b3f80a11-1504-e8f9-4438-92bcd5f3df7f@arm.com> <20190410061157.GA5278@lst.de>
 <20190417063358.GA24139@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190417063358.GA24139@lst.de>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Joerg Roedel <joro@8bytes.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Tom Lendacky <thomas.lendacky@amd.com>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On 17/04/2019 07:33, Christoph Hellwig wrote:
> On Wed, Apr 10, 2019 at 08:11:57AM +0200, Christoph Hellwig wrote:
>> On Tue, Apr 09, 2019 at 06:59:32PM +0100, Robin Murphy wrote:
>>> On 27/03/2019 08:04, Christoph Hellwig wrote:
>>>> This keeps the code together and will simplify compiling the code
>>>> out on architectures that are always dma coherent.
>>>
>>> And this is where things take a turn in the direction I just can't get on
>>> with - I'm looking at the final result and the twisty maze of little
>>> disjoint helpers all overlapping each other in functionality is really
>>> difficult to follow. And I would *much* rather have things rely on
>>> compile-time constant optimisation than spend the future having to fix the
>>> #ifdefed parts for arm64 whenever x86-centric changes fail to test them.
>>
>> Can you draft up a patch on top of my series to show me what you
>> want?  I can take care of finishing it up and moving the changes
>> into the right patches in the series.
> 
> Any chance to make some progress on this?  Or at least a better
> description of what you want?

Heh, I did actually start writing a reply last night to apologise for 
the delay - I've been clearing the decks a bit so that I can sit down 
and actually concentrate on this (plus the PCI DT mask fix). That's now 
my plan for the rest of today :)

Robin.
