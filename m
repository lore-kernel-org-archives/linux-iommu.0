From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 02/26] arm64/iommu: improve mmap bounds checking
Date: Tue, 30 Apr 2019 12:38:19 +0100
Message-ID: <a96caa67-ac59-9ce8-aabc-2601c9a10203@arm.com>
References: <20190422175942.18788-1-hch@lst.de>
 <20190422175942.18788-3-hch@lst.de>
 <306b7a19-4eb5-d1d8-5250-40f3ba9bca16@arm.com> <20190429190120.GA5637@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190429190120.GA5637@lst.de>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Joerg Roedel <joro@8bytes.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Tom Lendacky <thomas.lendacky@amd.com>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On 29/04/2019 20:01, Christoph Hellwig wrote:
> On Mon, Apr 29, 2019 at 01:35:46PM +0100, Robin Murphy wrote:
>> On 22/04/2019 18:59, Christoph Hellwig wrote:
>>> The nr_pages checks should be done for all mmap requests, not just those
>>> using remap_pfn_range.
>>
>> I think it probably makes sense now to just squash this with #22 one way or
>> the other, but if you really really still want to keep it as a separate
>> patch with a misleading commit message then I'm willing to keep my
>> complaints to myself :)
> 
> Well, I split this out in response to your earlier comments, so if you
> prefer it squasheѕ back in I can do that..

AFAICS I only ever suggested splitting the original "fix and refactor" 
commit into the fix (patch #1) and the refactor - I think we've just 
ended up adding more "refactor" on top in the evolution of the series :)

Robin.
