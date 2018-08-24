From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] Changing the AMD IOMMU API path to work in an atomic
 context which is necessary for any custom drivers using the IOMMU API while
 holding a spinlock.
Date: Fri, 24 Aug 2018 16:24:49 +0100
Message-ID: <24d3f04a-e6e2-ed8f-e2bd-b38144f33f26@arm.com>
References: <1535120929-5693-1-git-send-email-murphyt7@tcd.ie>
 <20180824145328.GA7996@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180824145328.GA7996@infradead.org>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>, murphyt7@tcd.ie
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On 24/08/18 15:53, Christoph Hellwig wrote:
> On Fri, Aug 24, 2018 at 02:28:49PM +0000, murphyt7@tcd.ie wrote:
>> From: Tom Murphy <murphyt7@tcd.ie>
>>
>> ---
>>
>> This patch allows the IOMMU API path in the AMD driver to be called from an atomic context.
>> This is useful for anyone building a driver which needs to call the IOMMU API while holding a spinlock.
> 
> I don't think that is a good idea.  Please point to the code in the
> driver and we can't probably find a better solution.

Although IIRC the AMD driver is in fact the only one whose map/unmap 
callbacks aren't already spinlock-safe (or at least it was last time I 
was looking). Stuff like iommu-dma is already relying on this in order 
to implement streaming DMA API calls (which may be in atomic context) on 
top of the corresponding IOMMU API operations.

Robin.
