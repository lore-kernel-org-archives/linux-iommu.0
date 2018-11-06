From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] iommu/dma: Zero pages manually in a length of scatterlist
Date: Tue, 6 Nov 2018 14:39:26 +0000
Message-ID: <afdc0e33-db18-6ad9-61cd-919fe3df1b4e@arm.com>
References: <20181101213500.21800-1-nicoleotsuka@gmail.com>
 <63184c22-4587-be2b-8089-d2e4e0b5482d@arm.com>
 <20181102233613.GA26856@Asurada-Nvidia.nvidia.com>
 <20181105145847.GA31337@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181105145847.GA31337@infradead.org>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>, Nicolin Chen <nicoleotsuka@gmail.com>
Cc: joro@8bytes.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On 05/11/2018 14:58, Christoph Hellwig wrote:
> On Fri, Nov 02, 2018 at 04:36:13PM -0700, Nicolin Chen wrote:
>>> What if the pages came from highmem? I know that doesn't happen on arm64
>>> today, but the point of this code *is* to be generic, and other users will
>>> arrive eventually.
>>
>> Hmm, so it probably should use sg_miter_start/stop() too? Looking
>> at the flush routine doing in PAGE_SIZE for each iteration, would
>> be possible to map and memset contiguous pages together? Actually
>> the flush routine might be also optimized if we can map contiguous
>> pages.
> 
> FYI, I have patches I plan to submit soon that gets rid of the
> struct scatterlist use in this code to simplify it:

...and I have some significant objections to that simplification which I 
plan to respond with ;)

(namely that it defaults the whole higher-order page allocation business 
which will have varying degrees of performance impact on certain cases)

Robin.
