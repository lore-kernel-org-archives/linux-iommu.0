From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 02/26] arm64/iommu: improve mmap bounds checking
Date: Mon, 29 Apr 2019 21:01:20 +0200
Message-ID: <20190429190120.GA5637@lst.de>
References: <20190422175942.18788-1-hch@lst.de> <20190422175942.18788-3-hch@lst.de> <306b7a19-4eb5-d1d8-5250-40f3ba9bca16@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <306b7a19-4eb5-d1d8-5250-40f3ba9bca16@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@lst.de>, Joerg Roedel <joro@8bytes.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Tom Lendacky <thomas.lendacky@amd.com>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Apr 29, 2019 at 01:35:46PM +0100, Robin Murphy wrote:
> On 22/04/2019 18:59, Christoph Hellwig wrote:
>> The nr_pages checks should be done for all mmap requests, not just those
>> using remap_pfn_range.
>
> I think it probably makes sense now to just squash this with #22 one way or 
> the other, but if you really really still want to keep it as a separate 
> patch with a misleading commit message then I'm willing to keep my 
> complaints to myself :)

Well, I split this out in response to your earlier comments, so if you
prefer it squasheѕ back in I can do that..
