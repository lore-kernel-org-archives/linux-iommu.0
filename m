Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2534736B1E
	for <iommu@lists.linux.dev>; Tue, 26 Sep 2023 20:23:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC976C433CA;
	Tue, 26 Sep 2023 20:23:45 +0000 (UTC)
Date: Tue, 26 Sep 2023 21:23:43 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Petr Tesarik <petr@tesarici.cz>
Cc: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>,
	Roberto Sassu <roberto.sassu@huaweicloud.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v3] swiotlb: fix the check whether a device has used
 software IO TLB
Message-ID: <ZRM9z6JQKTtqTMQa@arm.com>
References: <20230926185556.16433-1-petr@tesarici.cz>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230926185556.16433-1-petr@tesarici.cz>

On Tue, Sep 26, 2023 at 08:55:56PM +0200, Petr Tesarik wrote:
> When CONFIG_SWIOTLB_DYNAMIC=y, devices which do not use the software IO TLB
> can avoid swiotlb lookup. A flag is added by commit 1395706a1490 ("swiotlb:
> search the software IO TLB only if the device makes use of it"), the flag
> is correctly set, but it is then never checked. Add the actual check here.
> 
> Note that this code is an alternative to the default pool check, not an
> additional check, because:
> 
> 1. swiotlb_find_pool() also searches the default pool;
> 2. if dma_uses_io_tlb is false, the default swiotlb pool is not used.
> 
> Tested in a KVM guest against a QEMU RAM-backed SATA disk over virtio and
> *not* using software IO TLB, this patch increases IOPS by approx 2% for
> 4-way parallel I/O.
> 
> The write memory barrier in swiotlb_dyn_alloc() is not needed, because a
> newly allocated pool must always be observed by swiotlb_find_slots() before
> an address from that pool is passed to is_swiotlb_buffer().
> 
> Correctness was verified using the following litmus test:
> 
> C swiotlb-new-pool
> 
> (*
>  * Result: Never
>  *
>  * Check that a newly allocated pool is always visible when the
>  *  corresponding swiotlb buffer is visible.
>  *)
> 
> {
> 	mem_pools = default;
> }
> 
> P0(int **mem_pools, int *pool)
> {
> 	/* add_mem_pool() */
> 	WRITE_ONCE(*pool, 999);
> 	rcu_assign_pointer(*mem_pools, pool);
> }
> 
> P1(int **mem_pools, int *flag, int *buf)
> {
> 	/* swiotlb_find_slots() */
> 	int *r0;
> 	int r1;
> 
> 	rcu_read_lock();
> 	r0 = READ_ONCE(*mem_pools);
> 	r1 = READ_ONCE(*r0);
> 	rcu_read_unlock();
> 
> 	if (r1) {
> 		WRITE_ONCE(*flag, 1);
> 		smp_mb();
> 	}
> 
> 	/* device driver (presumed) */
> 	WRITE_ONCE(*buf, r1);
> }
> 
> P2(int **mem_pools, int *flag, int *buf)
> {
> 	/* device driver (presumed) */
> 	int r0 = READ_ONCE(*buf);
> 
> 	/* is_swiotlb_buffer() */
> 	int r1;
> 	int *r2;
> 	int r3;
> 
> 	smp_rmb();
> 	r1 = READ_ONCE(*flag);
> 	if (r1) {
> 		/* swiotlb_find_pool() */
> 		rcu_read_lock();
> 		r2 = READ_ONCE(*mem_pools);
> 		r3 = READ_ONCE(*r2);
> 		rcu_read_unlock();
> 	}
> }
> 
> exists (2:r0<>0 /\ 2:r3=0) (* Not found. *)
> 
> Fixes: 1395706a1490 ("swiotlb: search the software IO TLB only if the device makes use of it")
> Reported-by: Jonathan Corbet <corbet@lwn.net>
> Closes: https://lore.kernel.org/linux-iommu/87a5uz3ob8.fsf@meer.lwn.net/
> Signed-off-by: Petr Tesarik <petr@tesarici.cz>

I added this for v2, here it is again:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
