Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF26A3207
	for <iommu@lists.linux.dev>; Tue, 11 Oct 2022 12:16:16 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 19E821042;
	Tue, 11 Oct 2022 05:16:16 -0700 (PDT)
Received: from [10.57.4.42] (unknown [10.57.4.42])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0DC093F766;
	Tue, 11 Oct 2022 05:16:08 -0700 (PDT)
Message-ID: <9df969a8-08b1-2b5a-3a86-9a1918f1949b@arm.com>
Date: Tue, 11 Oct 2022 13:15:57 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: Issue seen since commit f5ff79fddf0e ("dma-mapping: remove
 CONFIG_DMA_REMAP")
To: Jerry Snitselaar <jsnitsel@redhat.com>, Christoph Hellwig <hch@lst.de>
Cc: Joerg Roedel <joro@8bytes.org>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20221010185739.vgw27m7fpmftly3q@cantor>
Content-Language: en-GB
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20221010185739.vgw27m7fpmftly3q@cantor>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2022-10-10 19:57, Jerry Snitselaar wrote:
> I've been looking at an odd issue that shows up with commit
> f5ff79fddf0e ("dma-mapping: remove CONFIG_DMA_REMAP").  What is being
> seen is the bnx2fc driver calling dma_free_coherent(), and eventually
> hits the BUG_ON() in vunmap().  bnx2fc_free_session_resc() does a
> spin_lock_bh() around the dma_free_coherent() calls, and looking at
> preempt.h that will trigger in_interrupt() to return positive, so that
> makes sense. The really odd part is this only happens with the
> shutdown of the kernel after a system install. Reboots after that do not
> hit the BUG_ON() in vunmap().

Most likely a difference in IOMMU config/parameters between the 
installer and the installed kernel - if the latter is defaulting to 
passthrough then it won't be remapping (assuming the device is coherent).

> I still need to grab a system and try to see what it is doing on the
> subsequent shutdowns, because it seems to me that any time
> bnx2fc_free_session_resc() is called it will end up there, unless the
> allocs are not coming from vmalloc() in the later boots. Between the
> comments in dma_free_attrs(), and preempt.h, dma_free_coherent()
> shouldn't be called under a spin_lock_bh(), yes? I think the comments
> in dma_free_attrs() might be out of date with commit f5ff79fddf0e
> ("dma-mapping: remove CONFIG_DMA_REMAP") in place since now it is more
> general that you can land in vunmap(). Also, should that WARN_ON() in
> dma_free_attrs() trigger as well for the BH disabled case?
> 
> It was also reproduced with a 6.0-rc5 kernel build[1].

Looking at the history of that comment I guess I was just trying to 
capture the most common case to explain the original motivation for 
having the WARN_ON(). It was never meant to imply that that's the *only* 
reason, especially since iommu-dma was already well established by that 
point. That warning has been present on x86 in one form or another for 
15 years, so I guess the real issue at hand is the difference between 
irqs_disabled() and in_interrupt()?

As far as that particular driver goes it looks rather questionable 
anyway - it seems like a terrible design flaw if a race between 
consuming things and freeing them can exist at all, but then it looks 
like bnx2fc_arm_cq() might actually program the hardware to *reuse* a CQ 
which may already be waiting to be freed as soon as the lock is 
dropped... that can't be good :/

Thanks,
Robin.
