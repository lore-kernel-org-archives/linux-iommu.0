From: Christoph Hellwig <hch@lst.de>
Subject: Re: 4.19-rc3: IOMMU PT warnings: WARNING: CPU: 0 PID: 1 at
 mm/page_alloc.c:4065 __alloc_pages_slowpath+0xb7b/0xcd0
Date: Mon, 10 Sep 2018 15:23:04 +0200
Message-ID: <20180910132304.GA20244@lst.de>
References: <alpine.LRH.2.21.1809101111040.31938@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.21.1809101111040.31938@math.ut.ee>
Sender: linux-kernel-owner@vger.kernel.org
To: Meelis Roos <mroos@linux.ee>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Sep 10, 2018 at 11:16:12AM +0300, Meelis Roos wrote:
> In 4.19-rc1, I found that to keep Intel integrated graphics working when 
> VT-d is on, I need to have IOMMU passthough on or GPU init would fail 
> with DMAR error and the screen would display static gibberish. So I 
> turned IOMMU PT on by default in kernel config. It worked, also in rc2.
> 
> Now with rc3, it still works but I get some warning splats in dmesg 
> about IOMMU passthrough:

Any chance you could bisect this down to a specific commit?  For
a start it might be worth if it is reproducable with:

   git://git.infradead.org/users/hch/dma-mapping.git dma-mapping-4.19-2

which were the only dma-mapping changes post -rc2.
