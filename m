Received: from zulu616.server4you.de (mail.csgraf.de [85.25.223.15])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5349D51B
	for <iommu@lists.linux.dev>; Wed, 30 Nov 2022 23:38:38 +0000 (UTC)
Received: from [0.0.0.0] (ec2-3-122-114-9.eu-central-1.compute.amazonaws.com [3.122.114.9])
	by csgraf.de (Postfix) with ESMTPSA id C8C3D60802DC;
	Thu,  1 Dec 2022 00:32:08 +0100 (CET)
Message-ID: <629d62ce-b993-35fe-05ff-ee0befc0c73d@csgraf.de>
Date: Thu, 1 Dec 2022 00:32:07 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH v3 13/13] dma: arm64: Add
 CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC and enable it for arm64
Content-Language: en-US
To: Isaac Manjarres <isaacmanjarres@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann
 <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Herbert Xu <herbert@gondor.apana.org.au>, Ard Biesheuvel <ardb@kernel.org>,
 Saravana Kannan <saravanak@google.com>, Alasdair Kergon <agk@redhat.com>,
 Daniel Vetter <daniel@ffwll.ch>, Joerg Roedel <joro@8bytes.org>,
 Mark Brown <broonie@kernel.org>, Mike Snitzer <snitzer@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-mm@kvack.org,
 iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>
References: <20221106220143.2129263-1-catalin.marinas@arm.com>
 <20221106220143.2129263-14-catalin.marinas@arm.com>
 <6e846f75-b330-9523-4356-41d5f9e48f12@arm.com> <Y2omz6pibSUNPtHu@arm.com>
 <20221108100331.GA31944@lst.de> <Y4eldGXZjpi2L2SQ@google.com>
From: Alexander Graf <agraf@csgraf.de>
In-Reply-To: <Y4eldGXZjpi2L2SQ@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Isaac,

On 30.11.22 19:48, Isaac Manjarres wrote:
> On Tue, Nov 08, 2022 at 11:03:31AM +0100, Christoph Hellwig wrote:
>> On Tue, Nov 08, 2022 at 09:52:15AM +0000, Catalin Marinas wrote:
>>> Since it's hard to guess the optimal swiotlb buffer for such platforms,
>>> I think a follow-up step would be to use the DMA coherent pool for
>>> bouncing if no swiotlb buffer is available. At least the pool can grow
>>> dynamically. Yet another option would be to increase the swiotlb buffer
>>> at run-time but it has an overhead for is_swiotlb_buffer().
>> Alex said he wanted to look into growing the swiotlb buffer on demand
>> for other reason, so adding him to Cc to check if there has been any
>> progress on that.
> Hi Alex,
>
> Did you get a chance to look into this? If so, have you been able to
> make progress on being able to grow the SWIOTLB buffer on demand?


I've been slightly under water and haven't been able to look at this yet 
:). It's on my list, but will probably be a while until I get to it. 
Would you be interested in having a first try?


Thanks,

Alex


